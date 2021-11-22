import 'package:container_locations/core/values/strings.dart';
import 'package:container_locations/data/model/container_model.dart';
import 'package:flutter/material.dart';

Widget containerInfo(BuildContext context, ContainerModel item) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(StringResources.container + ' ${item.id}',
          style: Theme.of(context).textTheme.headline3),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringResources.nextCollection,
                style: Theme.of(context).textTheme.headline4),
            Text(
                DateTime.fromMillisecondsSinceEpoch(item.date)
                    .toLocal()
                    .toIso8601String(),
                style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ),
      Text(StringResources.fullnessRate,
          style: Theme.of(context).textTheme.headline4),
      Text('%${item.occupancy}', style: Theme.of(context).textTheme.bodyText1),
    ],
  );
}
