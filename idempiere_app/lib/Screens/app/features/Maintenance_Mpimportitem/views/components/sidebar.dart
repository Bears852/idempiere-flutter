part of dashboard;

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.data,
    Key? key,
  }) : super(key: key);

  final ProjectCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(kSpacing),
              child: ProjectCard(
                data: data,
              ),
            ),
            const Divider(thickness: 1),
            SelectionButton(
              initialSelected: 0,
              data: [
                SelectionButtonData(
                  activeIcon: EvaIcons.arrowBack,
                  icon: EvaIcons.arrowBackOutline,
                  label: "Dashboard",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.person,
                  icon: EvaIcons.personOutline,
                  label: "Maintenance",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.person,
                  icon: EvaIcons.personOutline,
                  label: "MaintenanceCalendar",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.person,
                  icon: EvaIcons.personOutline,
                  label: "MaintenanceMptask",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.person,
                  icon: EvaIcons.personOutline,
                  label: "MaintenanceMpanomaly",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.person,
                  icon: EvaIcons.personOutline,
                  label: "MaintenanceMpwarehouse",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.person,
                  icon: EvaIcons.personOutline,
                  label: "MaintenanceMppicking",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.person,
                  icon: EvaIcons.personOutline,
                  label: "MaintenanceInternaluseinventory",
                ),
                SelectionButtonData(
                  activeIcon: EvaIcons.person,
                  icon: EvaIcons.personOutline,
                  label: "MaintenanceMpimportitem",
                ),
              ],
              onSelected: (index, value) {
                //log("index : $index | label : ${value.label}");
                Get.toNamed('/${value.label}');
              },
            ),
            const Divider(thickness: 1),
            const SizedBox(height: kSpacing * 2),
            /* UpgradePremiumCard(
              backgroundColor: Theme.of(context).canvasColor.withOpacity(.4),
              onPressed: () {},
            ), */
            const SizedBox(height: kSpacing),
          ],
        ),
      ),
    );
  }
}
