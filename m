Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE97CCD195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7C310EB67;
	Fri, 17 Oct 2025 08:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="shmvu84A";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8351710EB64
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJXEfWQgnLKL/s0uStG0axOJPOu+3BUbjOr8Q6vkUYUmhF7VIrGsBbvTGTLhWtS8nA5K4Ul5fCgytHsmVma4Ctn6XpYJLFTAl8V7xy8WPHnXtuNdbdf3v1YqBKu8vSTkkObbwfGAm8Pld3C8z7vUOF5qppnarb1TNXLugJ5bMueIJuayo+N2H5GtGGvCCDxu3HLITPhvHOHJDzK+nAMYOn3/vUWMUUGElj1QDiJDEB93mbyYmBBrk/SOM8Cg0CTkJzmVAXJAZxJADFLASkvOofKsiIQMlN8NJ2tvrbKlvnP8OH6ILI1zjck2++mPTQdsJI36pYgWQ5uXaT/8Cwrw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUiwn7cadeRIzu6naxoYYYg2NdOXX4Ubtxe8Q0dHbws=;
 b=BPDcUXa0U4bKgV7BDJXyMfby9SArHQs4WASPBpS04ypFNuevBH1RK7yLZlSSD/olZi3D/F1o57ZHUW9oYlIIbv3ygYhXZKgYCdmSh2O65qb3o2GPYs1TrdXmk8LxAMtl+NjvbtgMiepPYAc0U+1qWh7OCWyJZvrrL+p/Obegr2WYvu5l4y1es4mSbrQb0O+j9COeyQTlYz5eFrHoutzSIdwb7BeZXEKjOpANbOe5BYhNyZU1B7t4gypipqLSfWRsNirAOgiwzlRKOj+O8yyiXn+vbFIY1IAzbVl7XykTYEQzNyROYVh9wsb+qwtriCWoTcri3wqS9ivNC9w0ucBKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUiwn7cadeRIzu6naxoYYYg2NdOXX4Ubtxe8Q0dHbws=;
 b=shmvu84A6nX+f5oDGtSMnNjEB4lscBfKKL+sNmSx0hbym/AtJQRb9soH8CQeI1gDjyxNT6vsRiRZlgiynVfP+38SKkbTQ+GmCtdWUjLt6lukTiv4WZdz5aAU93WxjwxdQP9U0hM4u4JyGmth+ONNbKzSWavmZP1GOhpPLxYbJnQ=
Received: from DM6PR01CA0029.prod.exchangelabs.com (2603:10b6:5:296::34) by
 BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Fri, 17 Oct 2025 08:43:20 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::e9) by DM6PR01CA0029.outlook.office365.com
 (2603:10b6:5:296::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 08:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:19 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:12 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 04/18] amdkfd: Introduce kfd_create_process_sysfs as a
 separate function
Date: Fri, 17 Oct 2025 16:42:08 +0800
Message-ID: <20251017084222.54721-5-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017084222.54721-1-lingshan.zhu@amd.com>
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 7abf187a-675a-44ec-411e-08de0d59396e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BB6o9s4t884nqzva3ELyesgVjAMIvrgAu2zrEJtVlq62WnYDFQgzQzHN7ZKu?=
 =?us-ascii?Q?MCmU5Vz6uP1k6hpqugyZAiNYjOFTIHRWhvihbcBr0lsv5DqVWx6MYySSc0Nr?=
 =?us-ascii?Q?Zp8ND1Qvn1pMfyiWXM7UTf5zafaOOmf3lW8oYPkGhQZ6t9BOF+VKLxMUDMmV?=
 =?us-ascii?Q?rGFS554bzU861uF3m3Ow1KmM/Waa+ve8RYfGBymJahnJUx9fyFNx4N2K0Ss3?=
 =?us-ascii?Q?teGQRYs3oLaNtH5POMDqcPk/3YlVMu2hUkJ9u5Z+pUlcUbfzp1LMGLutYLae?=
 =?us-ascii?Q?rZXjQuvqQav3XuuUuDNPyU6sl4O+hKJcJB/ygGGQKheV/eYuqY0hPC7mYMi5?=
 =?us-ascii?Q?0QDazSPon7duZ4kjBQ3R36R1O5xSMnV5LRTebPaHe4191Hsi7srAteXAdOV9?=
 =?us-ascii?Q?8KkAy6AZvpG3HF7FS2gG68soLhufY8C/1Xrdnz1hm9GcV8HDMNTwVl1tNej7?=
 =?us-ascii?Q?oJ3lwmu53uTODCEJUkqcbK3OnM7vA7moNyn8lRocNQuJNFknfNEJreVP5Os2?=
 =?us-ascii?Q?ws3PvPdd9IGwte/pNkQLhIVBdpIqfQzyOIyutZHIvlfJ5FaGKcSYqPnzo65Q?=
 =?us-ascii?Q?vHFWNhdnCmZjmjR8kMzy5l8W+4LYpEB8mONRPIr6x8gMA/j33TbsDj5zBjSg?=
 =?us-ascii?Q?pFTq4a+KNDHePl1MgqMTIybnr4zBhv93kFSU/f2xXs1GyIjQ+aFIMUwXw5ge?=
 =?us-ascii?Q?dj2mj9TJ0ImvtjQ+0vt9GuS7DraPw68UG5Mx2vm+nrWC5rD1n1iQzopm7kUe?=
 =?us-ascii?Q?PxNmlSYeeKRYOIL9IyHzW3o1w+Vml0HRUj9M/p7ALkUV/CORyShsvb+ftDBU?=
 =?us-ascii?Q?N+3x/0mEkonqBZU5oAWMLyT377HY6hEUdveROBRIPBG29Iy6YctyscG33PSM?=
 =?us-ascii?Q?jEwxnqnBbiYnTD3dgL+Qf4H+33Jq48nLemud7+Rm68gR4PMstih0nLwcJJmr?=
 =?us-ascii?Q?V8AaWcMhvbbFL36E6uaDSjV1cKaDQb1I/3Muv0nVrRuufgO9cRaTK3KEzJ8I?=
 =?us-ascii?Q?C5dijx9+tJr5oUFSRvPpMgQ7Dv/tzZudHpRL9MV8Rw+sL9kiXrepjqln4b3l?=
 =?us-ascii?Q?CUZikDHHjBJzS3BtfX/ovkMgDHiZKybZ/0zJW3KR7jJ9U6bFzVjR3lXCyZ7F?=
 =?us-ascii?Q?lCFpePM7ayhgUdZ7T1bj21AJrj+/UWslqDDjFd0yMipsEcoWYOHKrpUZSCF+?=
 =?us-ascii?Q?mJghEogBC9Ohy0WWBfQF8uzOdfYbPi8Vt7Srzw37PC7HircPSlGQZDXy9pqA?=
 =?us-ascii?Q?OCM7c2Zngr8CkA2w7sjbJFTtBRlI4eCqlrpsJflroFqDL4lunsbBpbPp8csU?=
 =?us-ascii?Q?Sy4s24YpEVikUm/PasyjgPjgyhNbB0lHrzv1y5ObkY2mxyikDW684/bNfi0D?=
 =?us-ascii?Q?kgBy00Y6/vJFTEIypJFleQ35VEOe8DKAJlftuuhDwk5q5EKO7S5yg4uUnwgS?=
 =?us-ascii?Q?O3RTzQxovuqOATv+zrgnjoITmS9RDT9QXljATqb01I1fslqaB8vB6/eTxuPy?=
 =?us-ascii?Q?67FqsVqF+Un2CTSUDlenkpNecD3l5IZRAIZQUEI5gyAMBhlhmdFsN3Sg4qpb?=
 =?us-ascii?Q?kj+LCX0Szjwt6QvlWbM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:19.9266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abf187a-675a-44ec-411e-08de0d59396e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571
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

KFD creates sysfs entries for a kfd_process in
function kfd_create_process when creating it.

This commit extracts the code creating sysfs
entries to a separate function because it
would be invoked in other code path like
creating secondary kfd contexts (kfd_process).

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 66 +++++++++++++++---------
 2 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 729330f8a384..cfedc0c5892c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1054,6 +1054,7 @@ int kfd_process_create_wq(void);
 void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
 struct kfd_process *kfd_create_process(struct task_struct *thread);
+int kfd_create_process_sysfs(struct kfd_process *process);
 struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 051000e79e95..83fe571b801c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -825,6 +825,44 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
 	kfd_process_free_gpuvm(qpd->ib_mem, pdd, &qpd->ib_kaddr);
 }
 
+int kfd_create_process_sysfs(struct kfd_process *process)
+{
+	int ret;
+
+	if (process->kobj) {
+		pr_warn("kobject already exsists for the kfd_process\n");
+		return -EINVAL;
+	}
+
+	process->kobj = kfd_alloc_struct(process->kobj);
+	if (!process->kobj) {
+		pr_warn("Creating procfs kobject failed");
+		return -ENOMEM;
+	}
+	ret = kobject_init_and_add(process->kobj, &procfs_type,
+				   procfs.kobj, "%d",
+				   (int)process->lead_thread->pid);
+	if (ret) {
+		pr_warn("Creating procfs pid directory failed");
+		kobject_put(process->kobj);
+		return ret;
+	}
+
+	kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
+			      "pasid");
+
+	process->kobj_queues = kobject_create_and_add("queues",
+						process->kobj);
+	if (!process->kobj_queues)
+		pr_warn("Creating KFD proc/queues folder failed");
+
+	kfd_procfs_add_sysfs_stats(process);
+	kfd_procfs_add_sysfs_files(process);
+	kfd_procfs_add_sysfs_counters(process);
+
+	return 0;
+}
+
 struct kfd_process *kfd_create_process(struct task_struct *thread)
 {
 	struct kfd_process *process;
@@ -874,31 +912,9 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		if (!procfs.kobj)
 			goto out;
 
-		process->kobj = kfd_alloc_struct(process->kobj);
-		if (!process->kobj) {
-			pr_warn("Creating procfs kobject failed");
-			goto out;
-		}
-		ret = kobject_init_and_add(process->kobj, &procfs_type,
-					   procfs.kobj, "%d",
-					   (int)process->lead_thread->pid);
-		if (ret) {
-			pr_warn("Creating procfs pid directory failed");
-			kobject_put(process->kobj);
-			goto out;
-		}
-
-		kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
-				      "pasid");
-
-		process->kobj_queues = kobject_create_and_add("queues",
-							process->kobj);
-		if (!process->kobj_queues)
-			pr_warn("Creating KFD proc/queues folder failed");
-
-		kfd_procfs_add_sysfs_stats(process);
-		kfd_procfs_add_sysfs_files(process);
-		kfd_procfs_add_sysfs_counters(process);
+		ret = kfd_create_process_sysfs(process);
+		if (ret)
+			pr_warn("Failed to create sysfs entry for the kfd_process");
 
 		kfd_debugfs_add_process(process);
 
-- 
2.51.0

