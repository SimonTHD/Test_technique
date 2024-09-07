import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProjectsView extends StatefulWidget {
  const ProjectsView({super.key});

  @override
  _ProjectsViewState createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  List<dynamic> _projects = [];

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    print("token: $token");

    if (token != null) {
      final response = await http.get(
        Uri.parse('http://192.168.1.39:8000/projects/user/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _projects = json.decode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de la récupération des projets')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token non trouvé')),
      );
    }
  }

  Future<void> _addProject(String githubLink, String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    print("token addproject: $token");
    if (token != null) {
      final response = await http.post(
        Uri.parse('http://192.168.1.39:8000/projects/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'github_link': githubLink, 'description': description}),
      );
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Projet ajouté avec succès')),
        );
        _fetchProjects();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de l\'ajout du projet')),
        );
      }
    }
  }
  Future<void> _deleteProject(int projectId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token != null) {
      final response = await http.delete(
        Uri.parse('http://192.168.1.39:8000/projects/delete/$projectId/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Projet supprimé avec succès')),
        );
        _fetchProjects();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de la suppression du projet')),
        );
      }
    }
  }
  void _showAddProjectDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter un projet'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nom du projet'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Ajouter'),
              onPressed: () {
                _addProject(nameController.text, descriptionController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projets de l\'utilisateur')),
      body: _projects.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 5 / 8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _projects.length,
                itemBuilder: (context, index) {
                  final project = _projects[index];
                  return ProjectCard(
                    project: project,
                    onDelete: () => _deleteProject(project['id']),
                  );
                },
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProjectDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Map<String, dynamic> project;
  final VoidCallback onDelete;

  const ProjectCard({super.key, required this.project, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(project['image'] ?? 'https://seeklogo.com/images/G/github-logo-5F384D0265-seeklogo.com.png'),  // Image du projet ou une image par défaut
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              project['github_link'] ?? 'Aucun lien GitHub',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              project['description'] ?? 'Aucune description',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ),
        ],
      ),
    );
  }
}