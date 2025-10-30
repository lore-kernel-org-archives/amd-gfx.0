Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC5BCCF9EA
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 03:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3040E10E8AE;
	Thu, 30 Oct 2025 03:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DwQOe81D";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 552B110E8AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 03:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrSX1oN7tF9WOWK167YBZnW0XRbxSVHtfqKQLjNUo47E2AS25pT3I+ED46/+BctQjBPb8gxwI/qkLAd8vY0JQ+plYsCK3BvmPUe5HXZtCUhknYHnBiyy0c4FITKDekPCbv2QNIi6KAs+CtL3KU2ISRvU5kMiN/AhxC7wMJJ76zBan1zV1LHVmoDz2RsFaSR7GpIrf9LF6jeKCv0k64J9G8C3aKdEG3YQybI/+fFk/G599zQ91vlfX5x6j89fcFEG6xcLR1iIt1NqIq33CVJlOlqXyDqxt/vjBT5rmaR63ZJrJ2TldGy6jJ+dxcr55b1ihsrYeHWP14CYG99l3hvExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2YPJC+A6Xk851YyvG2MUU2+pXVs3b2xemfOx5nJw74=;
 b=e4cL4zQMUSjN8JVCkIIM3ZUhatgLlLHK4sxUKHmSlsTg5tsR+jrCGb94bm4SFSN1/uxX2KD2LH8Vuo2sbf0WSo5zbSJ7sZg2gNB5FQ37zermL/W+CFBBl3WGi3OIHD/UD9CUqVf0s680cV6J8u1aBenFHufF0SyXeta/OQT4zKv+ERvXHkbtXtyLqPZMeYNfQLjxKx+6HLdMeI6TQc6mxPAKmWWxud9BIYmTGRMiVdd2A5mk+phFKLTmd5T9oMm+3OgHyetrCTRXzE2P3zYatwoQYb1N4w/CMI0Cp+2ms7Be3uIcCFPj1JbXZ27T2c8XmqcZVkMTtNfou2+4vNvAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2YPJC+A6Xk851YyvG2MUU2+pXVs3b2xemfOx5nJw74=;
 b=DwQOe81DkgauGNRHxKrZ+4+uviDqO//DpoYJ8p/S17GaW1B3V2HQW8H2+83xf44DYO95i0QZaH4/OGF41EOBmQ4CmK8ZWU5eyh+7ssNFh3K1uTkkFVhodMxkf3MeDrCbEQczHswDpMQ3X3FdFOHt/m8i1ix3dgywwubHYZpbYwo=
Received: from BN9PR03CA0558.namprd03.prod.outlook.com (2603:10b6:408:138::23)
 by DS4PR12MB9561.namprd12.prod.outlook.com (2603:10b6:8:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 03:46:12 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::51) by BN9PR03CA0558.outlook.office365.com
 (2603:10b6:408:138::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Thu,
 30 Oct 2025 03:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 03:46:12 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 20:46:09 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] amdkfd: implement per process/device pasid in sysfs
Date: Thu, 30 Oct 2025 11:45:36 +0800
Message-ID: <20251030034536.11356-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DS4PR12MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 597c41d2-d4c6-4025-242a-08de1766de8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VG/2eZ2pQtkVZkIE3xy7FhIsJxfedvxTORf98vZ3ONRwwpkkfXd3jfxGFDf9?=
 =?us-ascii?Q?n0PGFzAziYmuTDeB7zUjyo/rH0HMY5Rv7c50qwwwUQKykvj78AvNtbMwtxB8?=
 =?us-ascii?Q?WfkrEBeNPwosgKsCLmB85cnmOEk1h/QVt0X67NCFmy2SoF3FYArfkQt6wZm9?=
 =?us-ascii?Q?YdiwxrAMDYJt4yKvMW3HjYk5yZpOH6a4EPaQcqAhM56eM6qK5CTfPJOZ1Bdv?=
 =?us-ascii?Q?2VgrrvgDALUgANz8kbW3dAzrZhdgjs3Xe5NDIEVftZ0/+FsDcUCjBPJRsH2q?=
 =?us-ascii?Q?nj81BG1cCmYx9D+3eY4zp+yUbymmnpqeRiChqh2rGe94MCJLOCT1hXYFl5Gg?=
 =?us-ascii?Q?/J9mvPB66nNztVUmMFHIP1pK3OuE2g4xFMzBr3o/oynlgzysRQtSiGlVQZE7?=
 =?us-ascii?Q?ZdvxULlQTAtjLLL6NOqxbZ8/gJMp/2hSxAglucwzyn/Nd7iTg+vmVlUFNjub?=
 =?us-ascii?Q?TQ1fJR41H8mwU1QV68iF4sRJ97vPnZn+EPNq2M7CBuw/bJ2Yain3rzc4eY95?=
 =?us-ascii?Q?1/qky4y7p51/ydgZoNEkh7hMzMXINUQjOIOWtcOMKKIroF5wzeH/ajtufFD7?=
 =?us-ascii?Q?iLZdk6DoqPZ1bC1c95uFWZtjF5KfOrCj1yJzZPh5V8OMmZUiHcIiXHYbG1TE?=
 =?us-ascii?Q?HhDiUC85/HkMz4ZoOBSEJY89ddiiA0WEB7yjxMc0+VI/Cz2LNXMEgbSEUhlC?=
 =?us-ascii?Q?aWp0b3xidBlARWNxMbHsULghcxOjmYPu4m1dpyzqe/q9lcAzCUnOrRfG6F8C?=
 =?us-ascii?Q?MEgSHd7o9TAExNHIDOOIHjIkA6wcU2CLM7y1cqmEVbbjqOBGku9d/chdWaH0?=
 =?us-ascii?Q?mN/KmRWZKmY6bMX5AyKeHEk9GIGNRvOPetMj+gEsoAae2mbJCx+/X4GXCudG?=
 =?us-ascii?Q?nxUyK5NQOwu/vDiTmpViGgMTFlsg/7FiEW/GNnUA89Y7rGhgiYYU6ad8VuZf?=
 =?us-ascii?Q?NfMz09nFNQMtcVk9+Czj3GQiQ96F9h2ZzkA5/v9+m4UiNCq2lpz9qDgH4NLJ?=
 =?us-ascii?Q?7ZwgmOtM//na1Fpli57MnAt6WaCNPoLDuKGcJR74gp5dOmgHFeECKwonehTB?=
 =?us-ascii?Q?KylYxe2qVYUNYiZMO9lZxFOJXClBMbZXgX9zCtEKj94Mqhvn+9c6V8T+bUeS?=
 =?us-ascii?Q?YdV9gE6pCfrPlKuzLNQCTV+wd4dr9saFFhQkhBkIZIAZW7TXpSoWuxQanPtu?=
 =?us-ascii?Q?vz1EMPOuJMe/EW2ENwBNzOOenQeZ/jgOUoiROW64CDBDZ4k3Rj2jhTN7silT?=
 =?us-ascii?Q?v5tGCnKCuV+t5jlRoPtuFotGYRxQFdwwABaTlGgGWaGXf203LUiw4/uW0AVe?=
 =?us-ascii?Q?SUVly8gCSpscD2bkXGKayttdTUqoVQ+v6m5cGLoBQcnxpSBDvopwzZFVNfyP?=
 =?us-ascii?Q?f46hA8jk5yFftvMHvqj4ddTI3sTBZ6ff2zQ37+m0wxSDB4vkbVt39EJHA+R0?=
 =?us-ascii?Q?1Dy83Z582h0pH6B1gFBwO76j0UlooaNVE4sVYWJpYPkldrUnpZX4Omwql2/Q?=
 =?us-ascii?Q?8EmXjjBpAqOI0vTkLuYHPswHj6qy43pjgSuGwknFcNYrz/t2ltp+N/KSpub9?=
 =?us-ascii?Q?JW/T2tIkYFv+lQZTfBQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 03:46:12.0663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597c41d2-d4c6-4025-242a-08de1766de8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9561
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

The pasid is a per-process-per-device attribute,
therefore this commit implements per
struct kfd_process_device->pasid in sysfs

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  9 ++-------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 18 +++++++++++-------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 70ef051511bb..6a3cfeccacd8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -864,6 +864,8 @@ struct kfd_process_device {
 	bool has_reset_queue;
 
 	u32 pasid;
+	char pasid_filename[MAX_SYSFS_FILENAME_LEN];
+	struct attribute attr_pasid;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
@@ -983,7 +985,6 @@ struct kfd_process {
 	/* Kobj for our procfs */
 	struct kobject *kobj;
 	struct kobject *kobj_queues;
-	struct attribute attr_pasid;
 
 	/* Keep track cwsr init */
 	bool has_cwsr;
@@ -1100,12 +1101,6 @@ void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
 					int handle);
 struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
 
-/* PASIDs */
-int kfd_pasid_init(void);
-void kfd_pasid_exit(void);
-u32 kfd_pasid_alloc(void);
-void kfd_pasid_free(u32 pasid);
-
 /* Doorbells */
 size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
 int kfd_doorbell_init(struct kfd_dev *kfd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ddfe30c13e9d..24cf3b250b37 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -328,9 +328,11 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 			       char *buffer)
 {
-	if (strcmp(attr->name, "pasid") == 0)
-		return snprintf(buffer, PAGE_SIZE, "%d\n", 0);
-	else if (strncmp(attr->name, "vram_", 5) == 0) {
+	if (strncmp(attr->name, "pasid_", 6) == 0) {
+		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
+							      attr_pasid);
+		return snprintf(buffer, PAGE_SIZE, "%u\n", pdd->pasid);
+	} else if (strncmp(attr->name, "vram_", 5) == 0) {
 		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
 							      attr_vram);
 		return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
@@ -662,6 +664,7 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
 	 * Create sysfs files for each GPU:
 	 * - proc/<pid>/vram_<gpuid>
 	 * - proc/<pid>/sdma_<gpuid>
+	 * - proc/<pid>/pasid_<gpuid>
 	 */
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
@@ -675,6 +678,10 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
 			 pdd->dev->id);
 		kfd_sysfs_create_file(p->kobj, &pdd->attr_sdma,
 					    pdd->sdma_filename);
+
+		snprintf(pdd->pasid_filename, MAX_SYSFS_FILENAME_LEN, "pasid_%u",
+			 pdd->dev->id);
+		kfd_sysfs_create_file(p->kobj, &pdd->attr_pasid, pdd->pasid_filename);
 	}
 }
 
@@ -888,9 +895,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 			goto out;
 		}
 
-		kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
-				      "pasid");
-
 		process->kobj_queues = kobject_create_and_add("queues",
 							process->kobj);
 		if (!process->kobj_queues)
@@ -1104,7 +1108,6 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
 	if (!p->kobj)
 		return;
 
-	sysfs_remove_file(p->kobj, &p->attr_pasid);
 	kobject_del(p->kobj_queues);
 	kobject_put(p->kobj_queues);
 	p->kobj_queues = NULL;
@@ -1114,6 +1117,7 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
 
 		sysfs_remove_file(p->kobj, &pdd->attr_vram);
 		sysfs_remove_file(p->kobj, &pdd->attr_sdma);
+		sysfs_remove_file(p->kobj, &pdd->attr_pasid);
 
 		sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
 		if (pdd->dev->kfd2kgd->get_cu_occupancy)
-- 
2.51.0

