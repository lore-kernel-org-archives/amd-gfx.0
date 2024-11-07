Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A67D5D688
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2024 19:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E5010E00E;
	Thu,  7 Nov 2024 19:59:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nTKeklDy";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F127410E00E
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2024 19:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRccJl//9gwKQUG52hY5zpkaYGVCt9dng4WG53KNE+WETcUSHkEyJPf56pte/GhVgMer93PrvwOYvs6WFjtS0qARBicOm5yiljX80tFXEdHQxv9+HZk49JUbUsMz+EROwr+rtxKmEBpRWbMvBicjup47qLlvic6G0m2wYtyUIpMbOoBKP09IM9TVrLuOKhsQRuVUcBHJ5k0c25zbVYmrC2/9nBHMdQV7YvJKJ6VHFdIcbvalEwwD5WaaObkpmP/T7f3BRgxAkNfQcDc6+3v/5J1l3EZwUvb1OufPtXXzDk4Dn9qVEq4TISZIpdUw/NAS1wVRgoRky0Sy15syO8ntNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azerIenQwEImLGRV14/lV1b+al8zGE46rV/zKah5CUE=;
 b=FqPn9sFt9ur/FLrqFrYKwHeHb1G2qlddMetxuNVV6iCmx3kYFENB87Jv55gWNAPcu8OJoUBz09pUifRA0GRoReT5HKJ4E/Dpw0GubjtgONiCoVD2AFKE8zHVmcMmCutzx59yFIbCgiCOnPbvKATY7FjCEpRT8eH0MBoRT//YRqr+yZn0adVlZ6J+6VJZmFLHtzT4UjPANfPMQrNzeeP4v89UFYQgwpXF38UQv7ePnTgEP9jKnbGO/tyIoODUm3fJsjM31RI9GcvWf41R+zm0Pwlx7odxzzTnrrn9eAwZ3zmscZT8vabajLrAttrG+gLN6Y9S9lZIz+T25Qb/0JjZ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azerIenQwEImLGRV14/lV1b+al8zGE46rV/zKah5CUE=;
 b=nTKeklDyYTEZA2DqSkRCGOWwFIW+hms80PBHvZzrxbIlZvPZd1KUhPWKv01A7t/J+xw+D8pusoZ4MLR/sy3mLUG3UFKI1C4J+UpadamjnvZM3jbvxAeI1zwZO6vH4LAA78HraYhFyvx2wZWflX2kFvmbrgmI4iXY/Nhralm65Dc=
Received: from BN9PR03CA0150.namprd03.prod.outlook.com (2603:10b6:408:fe::35)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 19:59:18 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::75) by BN9PR03CA0150.outlook.office365.com
 (2603:10b6:408:fe::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Thu, 7 Nov 2024 19:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 19:59:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 13:59:16 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Add documentation for enforce isolation feature
Date: Fri, 8 Nov 2024 01:29:07 +0530
Message-ID: <20241107195907.601798-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f2be71-87da-42d0-8bf0-08dcff66aa0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGczS0M4dUdDbjdGNWRTNHNiUU1MdjFGUW43bmNPTzRuOHdGWXpLYlRwOE91?=
 =?utf-8?B?SWc4b0dLc3pmellXaStqMXdLUWxQUDFrMFp2ZlVtajRoU3ZDcXI3d0hpT2Fy?=
 =?utf-8?B?S0paS2RRWlk4SU1ITGFQeDByQVo3eTh1ZHVWV0NmWGIyUG1oYTJ0ZittVDVB?=
 =?utf-8?B?b3UrQWVQTW9KL0d2YTYvc2s5cEgrQWdUY3RSbGd5SnBXK3N0VEpTMk0ySXhD?=
 =?utf-8?B?SGUwdGZhb1psN0djRGlKUm96cFhRMFdmQWRXa2tpWVNmODNLQ1NIUjcrSEll?=
 =?utf-8?B?Sm1Ed0UzQ3k3R0FOdnByaW1kaHArL3d5S1FkbWFxMzdlNk83cmJKQVV4aFEx?=
 =?utf-8?B?QnRpUFBYZTY3andEWW9obmlUcG5IbVpkdXA4V0tNRlJKVzAvY293dktObVdq?=
 =?utf-8?B?TmxRc2YvejlDeVlrZXRDeGd4NjBONlRFdDlzbGZUNjl5VmFBcFJITFdGU3pj?=
 =?utf-8?B?UWYyMW9jSVBiSEhuKzF0WkJoTnQ0aUQ4c3hWSC9ic2pVdklkd0Z4RVE4SUdV?=
 =?utf-8?B?YzRBL3d3WDlWMVZCT0d3cE5sNEhpay90UUhvYUpSWXdycEVVY1BkcDB6azcw?=
 =?utf-8?B?VFcra1JWVUxEWXRVbk9jUDc0eHJZVWx4T09reG1GT3REc1l0eFN0c1g5am9C?=
 =?utf-8?B?T1NFWXpUMDBFRVZWaHdvWnQ4eTkzYkVMMk91NUxDOUR1cnliSGFhWUR6QmRh?=
 =?utf-8?B?RTRrVG5xTUY3aTNXc0hpcnpoYUt3M0tCZzJwcEpmbkhqWG9lR1FacUlzb1Nt?=
 =?utf-8?B?bmtyY3JQeXFmaHh2OEhlM21zOFpBQmxiSzVJb0VRZWJGeGFlUHBOSGRzN09C?=
 =?utf-8?B?bjQ0R2NLYlRjL0FmVlJYbXJva2NaU2V1ck02QksybHU5dFp6bnVqVE14Z1FB?=
 =?utf-8?B?OVBFS056MEV0aW5ONnRsRERxUG9aSG9nS1JqdkNVME4wREJQdXU5SGhIYml5?=
 =?utf-8?B?OE9zZXVRTXpnaEwyalFZRzQ1dTVBWHEzWTFVVnBNeVZ0NGpTQW0xYjYwSGho?=
 =?utf-8?B?Nk9pZy9zTWRtazhFVEQvUlkrck53enlQMlB0V2lpL3pnd2wxSW9uOWdsYUta?=
 =?utf-8?B?TFU5RjZnZW1pSzFVL2Z4cWJGempxMWQxYkZPN28yZC90eXd2QUhuQlBPVjZJ?=
 =?utf-8?B?b2RvVXJrV2k5cmlKbW5mbEg3MHNWTFMyUlNENUhsNDdzRFI4SkhKS0hrUVpa?=
 =?utf-8?B?STFqY3crMXU0ZGJsNTNBbzdmMVRsKzdhOVNUbHZIYUJxdWhsNTJYM1R1dloz?=
 =?utf-8?B?ZTdXUndqbjBzM1JCdjNud2ZrMWg3WVFsV3g3cEdTVGVzZHd2N3BLVzUrUTA0?=
 =?utf-8?B?QVRWd1ZnV1lram11S2o1aHBrSDBWMVJoMnpSOFdwc0pjai91NTBoUUdUc2VM?=
 =?utf-8?B?UXpFek1LNDhaeE5BOVpUVlBzV0VuOU05eHBIZUk3d0xYQWFDbEJPSEdSY3ZR?=
 =?utf-8?B?YWN6c2tjSFNCdGQwempOUHVaSHBub2VvR3FwZkgrcVNWRW4zWVkvWG94Sklj?=
 =?utf-8?B?eWlOY2JQRW9IdUNjaXdwVlN4S3I5TXJLRktTWEhXaUhHQUhyUTUvcGdTN0FK?=
 =?utf-8?B?dklFZ25oSjhpc2tEKyt5K08wd0lqMGxjNzJqSHpTMk1pNFhWeThrWTVHM2FZ?=
 =?utf-8?B?OTdjc09HVEUyNUx1Wnd6b1ZSSTJlSFo0U2NZVG1iekk4Z2hyYmZPZTk5RE1M?=
 =?utf-8?B?LytHcmtaeUo5NGFWUzVTeTZZMmJ3UzN5ejRxa1JCNC95YnZ4VUlVN1lQOXF2?=
 =?utf-8?B?YWswU3pEVXExTHdHeFM5c2t4RjNlNnhXeWlBRVZObnpHb1JNNUdkSlZRR2RL?=
 =?utf-8?B?RUVhWU5SQ1oyN0dXcG55eUFSbS9selFpK0trOHhBTWI5ZFJIai9aY1NiQXA4?=
 =?utf-8?B?ZnRDa1NxdnhRNEpzbzcxWEhybnBybStJRE5qSWlDZm9uRFE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:59:18.4037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f2be71-87da-42d0-8bf0-08dcff66aa0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353
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

This feature enables process isolation on the graphics engine by
serializing access to it and adding a cleaner shader which clears LDS
(Local Data Store) and GPRs (General Purpose Registers) between jobs.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Asad Kamal <asad.kamal@amd.com>
---
 Documentation/gpu/amdgpu/index.rst            |  1 +
 .../gpu/amdgpu/process-isolation.rst          | 59 +++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/process-isolation.rst

diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
index 847e04924030..302d039928ee 100644
--- a/Documentation/gpu/amdgpu/index.rst
+++ b/Documentation/gpu/amdgpu/index.rst
@@ -16,4 +16,5 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.
    thermal
    driver-misc
    debugging
+   process-isolation
    amdgpu-glossary
diff --git a/Documentation/gpu/amdgpu/process-isolation.rst b/Documentation/gpu/amdgpu/process-isolation.rst
new file mode 100644
index 000000000000..6b6d70e357a7
--- /dev/null
+++ b/Documentation/gpu/amdgpu/process-isolation.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+ AMDGPU Process Isolation
+=========================
+
+The AMDGPU driver includes a feature that enables automatic process isolation on the graphics engine. This feature serializes access to the graphics engine and adds a cleaner shader which clears the Local Data Store (LDS) and General Purpose Registers (GPRs) between jobs. All processes using the GPU, including both graphics and compute workloads, are serialized when this feature is enabled. On GPUs that support partitionable graphics engines, this feature can be enabled on a per-partition basis.
+
+In addition, there is an interface to manually run the cleaner shader when the use of the GPU is complete. This may be preferable in some use cases, such as a single-user system where the login manager triggers the cleaner shader when the user logs out.
+
+Process Isolation
+=================
+
+The `run_cleaner_shader` and `enforce_isolation` sysfs interfaces allow users to manually execute the cleaner shader and control the process isolation feature, respectively.
+
+Partition Handling
+------------------
+
+The `enforce_isolation` file in sysfs can be used to enable process isolation and automatic shader cleanup between processes. On GPUs that support graphics engine partitioning, this can be enabled per partition. The partition and its current setting (0 disabled, 1 enabled) can be read from sysfs. On GPUs that do not support graphics engine partitioning, only a single partition will be present. Writing 1 to the partition position enables enforce isolation, writing 0 disables it.
+
+Example of enabling enforce isolation on a GPU with multiple partitions:
+
+.. code-block:: console
+
+    $ echo 1 0 1 0 > /sys/class/drm/card0/device/enforce_isolation
+    $ cat /sys/class/drm/card0/device/enforce_isolation
+    1 0 1 0
+
+The output indicates that enforce isolation is enabled on zeroth and second parition and disabled on first and fourth parition.
+
+For devices with a single partition or those that do not support partitions, there will be only one element:
+
+.. code-block:: console
+
+    $ echo 1 > /sys/class/drm/card0/device/enforce_isolation
+    $ cat /sys/class/drm/card0/device/enforce_isolation
+    1
+
+Cleaner Shader Execution
+========================
+
+The driver can trigger a cleaner shader to clean up the LDS and GPR state on the graphics engine. When process isolation is enabled, this happens automatically between processes. In addition, there is a sysfs file to manually trigger cleaner shader execution.
+
+To manually trigger the execution of the cleaner shader, write `0` to the `run_cleaner_shader` sysfs file:
+
+.. code-block:: console
+
+    $ echo 0 > /sys/class/drm/card0/device/run_cleaner_shader
+
+For multi-partition devices, you can specify the partition index when triggering the cleaner shader:
+
+.. code-block:: console
+
+    $ echo 0 > /sys/class/drm/card0/device/run_cleaner_shader # For partition 0
+    $ echo 1 > /sys/class/drm/card0/device/run_cleaner_shader # For partition 1
+    $ echo 2 > /sys/class/drm/card0/device/run_cleaner_shader # For partition 2
+    # ... and so on for each partition
+
+This command initiates the cleaner shader, which will run and complete before any new tasks are scheduled on the GPU.
-- 
2.34.1

