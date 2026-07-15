Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DB6C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 14:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0BAC10F0E2;
	Wed, 15 Jul 2026 14:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="osat/Ae9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D96A610F0E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vq7HzblUxxM786nKqJjLr6Kc6oBPKc0u7OlSlkAhFKTZZeZ89IZqJue590Q3G0Na5ZDT2d4Fhw77s6gZUHSH9wipTdTJ3Jy0bV0Scn9RuXXYAHb2MAkThI4wttcksQAViz+QY7yzNa9uCFez0ud246+06Zoaum1VsEShzEj0MREivAiQj2jfbE9dCurMgfj44cTAgKPQlveddd7+AvyQ0WxBCag0m4XS4uUa9hwUipybk4Ft5/hkQal2gdf+kUbjDWtB0Citeb4Nc7SjnHoYxJfgtoyAb2Fg2XMLLrGmql9h0sEIwy2LUlqTDcbKuea+nsENulLc1T9YMDBj/KLgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Vg7NSiC0GDi3sChNKMfROzclJyaQgRoCusPCgB7myA=;
 b=TM99gfqAWYp00YZy9yR31LdLWXkvrSUeJR1CEiDkVVEQNxSRAebxkDkrTIrWPJO9Bcw1rNdxPIZjmwqOqlIj4ayCpI2539KlqfOZ8ImbyuIyiqD9LgkxK3nAsrHJVHVO8+XMbxdwRPLdy1VAB7BYmyz7+Do+oLf985EIKixTjJVfaBNZVgb3pqacUIdkxQl/OjwftIQIgTyivzakOjcPpXcdqGDPX9KIkhcebgDTUlBI3IxjdmRCJSOjAPyuQwa8cUmK40KrT6NircDY3BM8gT5V6gEa50bY8viR26ZRgxi5TqyJmyrsFM+RnXS/u+W+bwAsIEEj66soLFqHDft2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Vg7NSiC0GDi3sChNKMfROzclJyaQgRoCusPCgB7myA=;
 b=osat/Ae9zdLm6qVYX7ea82d3GXVJJRhbjj8GwgWN5bBJz1K8m6JeyzH95QdvKQEhk/U9Ni5jAJf+6+IYEJ6mImaNLWB0Zaaw5EIJFMbA3QoVR6faFfo2xFLfCnTCMFc/3+N87A5cO+oEFwOJni/TP2046tP4Si1Zx6TbyTgMrW8=
Received: from SJ0PR13CA0040.namprd13.prod.outlook.com (2603:10b6:a03:2c2::15)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 14:26:28 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::2d) by SJ0PR13CA0040.outlook.office365.com
 (2603:10b6:a03:2c2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Wed, 15
 Jul 2026 14:26:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 14:26:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 09:26:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 0/4] drm/amdgpu: Wire GPU events into EVENTFD notifications
Date: Wed, 15 Jul 2026 19:56:13 +0530
Message-ID: <20260715142617.3475314-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ff7590-910f-47e3-bb97-08dee27d0f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 2MHgsxidiBr2UeiwPJ5syD0uizXZts+Gysg8QFsv4ld180weFVNwVnZ3E4Au+DACMRJibBniVak7ToYTpI1JXNG/xcTpbG/svoKTgzev4/J9RvV9J206p9QQbiAhnkLsOQOQ3+BshK6zELp0XWA+xFkum9VvKifHUJ6B39/1+rmgMc7zZ0JjRRqvdghC+TmstQLKSAcZB+2Rob5+c2kPcRk82/70QuB7cW7lV9J0Z5x9s0HrHTKqek1EPEvlUMgpLWtsGi6Q5OlRIea0DcIqzIOfBNJxXELAOPbM7uMvazBza7GrMiI9DLTToS14GbfXO8tgNg9Yv7+S4K6sv/CSPOyXhr+xagMGXGH63HWY0zSrB6DMLXaquoxXnLnvD5SOb8AclxnsLpGyTeZwRrmpbBAgX9nY/ZMxBctzBdKj5QZV+NeKWo7oLmCljbCiWrRN8pz1Dk5PE8RJwhF8HjGYmChSVA2w3aTl/HuSB0+JBXx02AduSjxaifiPaVC8oT6UY2/62rPEbZOU81ec7tLvlb/bf2tCdk33I1+dQZNMf2ayxjJ0Ty1Ca+wjUyHYmbpMyt8W81i+18tXMurPmOyUqgEdV3pRVQ37tPahHuZ5qnetbq1efMhdJy+T2FtazSRK+zf7aK7tpLVOHIeVtXloeb5ImLAf17I9KugoK8HizyOQqu7VKwE58z7o3awz8UYqVGWJutTCVg1DEt027FSONQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tkHK5+XvM79wHJR+gYOk2uy9Zwf2rEPtL9OO8roNF4Usg7rxA2Jh/ShAKp921D4ejICjTardt+5rt4wIhWXZaIBpwfAyygsBfUvp26LUcvxmntOd2+j0xNV8bsah98qd/oKCuRyoIHoYzgxz0JLcrSELSCGORgwagjkbynp4Jm4yowQOYrV2AJ5r3Ufg/EgYc+npb30dd4VKK5uG7hVBUZ/GYRF65f3q3gLHXrAqapDrAsmv6GQ7mmvei6iPk55aJCZKwf4bJniiyIgO6IZCY0aenUMa0DpqIRrAQftiPbcdtMabaGBmzs1QGdQSnIuuK+tgHyGn3ow8bdRxUOzm6hjjLonFh0Y5HXCZkxowMX6hmovqx0RrRcQWKczb1uNZ7TvzNrujM7vyNsk60yZnbhd03uVmQEPH0ImvZV+Y5JaJW9WDLCC5hUef5XsxVYeL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:26:28.4707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ff7590-910f-47e3-bb97-08dee27d0f23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series wires GPU events into the render-node EVENTFD
notification infrastructure.

It builds on the render-node EVENTFD infrastructure by adding
notification producers for USERQ_EOP, QUEUE_RESET, and GPU_RESET
events.

QUEUE_RESET notifications are generated from the common
queue-specific reset helper, while device-level reset accounting
and DRM wedged-event notification remain in the top-level
recovery paths.

Patches
=======

  1. drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
  2. drm/amdgpu/userq: properly account for resets with user queues
  3. drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
  4. drm/amdgpu: Signal GPU_RESET EVENTFD notifications

Changes since v4
================

- Rebased on the latest user queue reset handling changes.
- Reworked the QUEUE_RESET producer to reuse the common
  queue-specific reset helper.
- Kept device-level reset accounting and DRM wedged-event
  notification in the top-level recovery paths.

Only compilation tested.

Alex Deucher (1):
  drm/amdgpu: properly account for resets with user queues

Srinivasan Shanmugam (3):
  drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
  drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
  drm/amdgpu: Signal GPU_RESET EVENTFD notifications

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 51 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 61 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 77 +++++++++++++------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 17 +++-
 5 files changed, 173 insertions(+), 34 deletions(-)

-- 
2.34.1

