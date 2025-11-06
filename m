Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65B0CCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C66610E807;
	Thu,  6 Nov 2025 06:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tch9DWcu";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EEB010E33D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7pSty/alBLP5TV4RWtXxDftqMdzbocYOpj42bpBXqNXzUyHcxOOZDt1teRLRy5XIg3yFKJ9+R2Ls0gIW+widfYzXlK2RWoK0mh6I+qp6q35CvAppSbjfEYh57SEwtHR2u8hyQvBmkSO5p8U+eEgG/ll/U3PMMxhSF1Gviq9fF8IePBJwHknWxfi18nYvoA264PGE5uJbWivB7QdxHxvYQiulGZphk/0UFEAkTMiZRD6VdX2VyOZYMeBm7v5R5Kk6eUQHcr375YQvoihwqWP3ZgDjsYjlGNxqlrK0gBjPJt2ChA3lvRWH0CL9mPe2Koz0+Ecyy25rcdXfe8JaeBEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLs1QOAmzSx0Ds/5H+rrKqMH3dqtDT8ptD3EQaEuZ1U=;
 b=Ju9Wodcis48fSp13IxNNc9Ru1uTy94LD9Hckr9Px9usLy/m6FJvzNlbq3YNE+mfzGlZ2+X5BVyfi12i6HNP+YnbkEmOUPoDeqYAuIplGXMAU/yyTI0vKP6ARs11adQkcv3kpSkMiw4ipQ9aK9TUhpVUey/QCzIojkoEbLbH99TIRAx7RD8HBtHoQtlIIaWQw6Aw2pw4zVjrlPUhAipTIdJ2wER5sA9gABLiVxSS/iZU8LHk7vL9Kx7CIDyzaBPA9GWqi6GNtjnaHBm5wXWd07mi55eTwOyJo6L4bzixBglkL6gYi9R1CIYSr8eQMf3kKZnHay5xAbNvE4d6WLrCLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLs1QOAmzSx0Ds/5H+rrKqMH3dqtDT8ptD3EQaEuZ1U=;
 b=tch9DWcuLCB2WbGlIOOwUq9PepElVtZNooQikjz4f3HxHeZs4Wb1eMFtOTaDLjrKqnhcAwrwx/AaU69mK2NAM26c8XI37SdzlWGhZ7zK9ZLOHCNvCKrbYJU3gFrsLLZkzPNmcYGB+XM7HLJ0bffjD5z0pbev8V3wkB/PKM51zdQ=
Received: from SJ0PR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:33f::26)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 06:08:19 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::b2) by SJ0PR05CA0051.outlook.office365.com
 (2603:10b6:a03:33f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.6 via Frontend Transport; Thu, 6
 Nov 2025 06:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:18 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:17 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 08/18] amdkfd: identify a secondary kfd process by its id
Date: Thu, 6 Nov 2025 14:07:29 +0800
Message-ID: <20251106060739.2281-9-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106060739.2281-1-lingshan.zhu@amd.com>
References: <20251106060739.2281-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: abc93d64-2e7b-4aba-e97d-08de1cfae1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YVrQnV7zQthkUvh1r99AZNL7BLNAmPuMlf9ykHXWg/jyS01jgiFV/vxY3t7h?=
 =?us-ascii?Q?AxyF8FmRYGst3R+XxtoY71r25YoIm2tyBklIa75IAh6V5TOSl8bVoYiktuGM?=
 =?us-ascii?Q?IEQaYb84N63OPuI0DbTT6vRNqshR1T4L83XV772u4Rj74ZHo4LF8/1YKgbNU?=
 =?us-ascii?Q?aRPBas+0bi5aa7E64ZS5Z8IfjaTvMbLGsKFNIZJBYvgWoM4JcDk1/E1pD97v?=
 =?us-ascii?Q?5Vlw0M3lX/0LeEN8bD9Ji87iT8b00Z+6XQR+kjktqC9rk7IsMQ/X9HcB1Bqo?=
 =?us-ascii?Q?e8uVWx2WypSmqRqqOhUSIcKRo39UvLsRbgfTpGh4x1GNyndZ5QIFPOpKRKGa?=
 =?us-ascii?Q?EpuKK95RV73XE9jM9vO4Bp5/eDQEDBOfBN+esQ5OM4RjlDIB13YOxS7qXTsm?=
 =?us-ascii?Q?ISRl0CbBhnxk+PRQKHfX9WeQtyZeVE7PFRNJOmTKfR8uOG210u2mljwd1C68?=
 =?us-ascii?Q?uYL/Dlo/eRdbQ8gpE3ROuZ28PHFHApkzIfJjSLkpVsyalI9aJv0T2tBoM/aq?=
 =?us-ascii?Q?f6oLPKOk7YSGNLhR8ylnBD9Rb4OTntogSZSG7j4Szh8NygpamvLrG/o7g+oT?=
 =?us-ascii?Q?zqd+Bde8COwcOJ83c7Sbab1AkOqG3nPe/X3s2dXb09LNwkJNCeUPTUWnIglW?=
 =?us-ascii?Q?KkLS168Z7pHW0neANZIaOEzuEaOleT7o/4sk9JEAIMx5GkEgZYiRAb4K4IJ1?=
 =?us-ascii?Q?TwW7AL98Y2RURZnP9ar7/x9KAZ35zTTK9riX4qVo3bduexPAWtLrCJLSAGYa?=
 =?us-ascii?Q?Q8T7cU2UzU5pwKdLTrqD5eTPz6jN4velVztLF6X5DiVynBXoTcm11IzcCBRG?=
 =?us-ascii?Q?h8YEkusc0MhJvlrz8mWNAvyHBrHzdkzwEX3dVS1T2qq7hej2a8aCG92vCsPy?=
 =?us-ascii?Q?BZUKQ+VQyNn+vEJFEt9rQ5wuowzLgCX8P5ZIps7qKUnMoY2xszDvzje0TUlz?=
 =?us-ascii?Q?0j45umuKb4RIch09KYMZZX9IfRo8BQvoDtCeYvU5LRKvuwxJO//AF65BfycS?=
 =?us-ascii?Q?1nWSGnSnRVT1RfqxCxpijicYPu9cy1JHLKrK7m5DMpQgfp3b7HnKFgHnqqj4?=
 =?us-ascii?Q?xj7EMKn9+dBFQcSeNgBg9CHhf7HLPZdC7kyDW/HwhPp/f9yFSrHrD+iPLT0T?=
 =?us-ascii?Q?tQDfnHyLN1oLu2mZM44r4X4fiu+hOpN8wuc7ownXzyo/gYApwp7BHZr5get/?=
 =?us-ascii?Q?QndO9AoRpmkNV5gembic6056k7GGXLfYMqHsj6eDR6BebsXqri2QQdLtJYj1?=
 =?us-ascii?Q?QYChNjbUBm/YjYBM1Gn/4gnmBU2RBWAZUQ1rW27SRCttnfZ4IW8OVvaT4eY8?=
 =?us-ascii?Q?RLVrMqZ0q5lzFGTM3PEK9MXBn8LRvugpwYeez8/YzmIgSGVhHbxBUz7Yxdhb?=
 =?us-ascii?Q?FVN7mzWIrjaGKvDn49bW8FBmQDrsARIyccXKs6DhK+4CWkHCAWTt55HDE6wh?=
 =?us-ascii?Q?Ir9AN8U32Um3oEi1AA09IkRY1ZA61eibdHBI2dxpk8Uzknj7KtXaVzH629en?=
 =?us-ascii?Q?u6afjOgGgq3frftpOCPwnniEcyjIO6sMnxgHOnTilmsDcm9TnTbqDfExovo3?=
 =?us-ascii?Q?tUkRDsv66P0/74atSJ4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:18.9781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc93d64-2e7b-4aba-e97d-08de1cfae1ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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

This commit introduces a new id field for
struct kfd process, which helps identify
a kfd process among multiple contexts that
all belong to a single user space program.

The sysfs entry of a secondary kfd process
is placed under the sysfs entry folder of
its primary kfd process.

The naming format of the sysfs entry of a secondary
kfd process is "context_%u" where %u is the context id.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  5 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 78 +++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 919510f18249..30b0b45bcc8d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1021,10 +1021,15 @@ struct kfd_process {
 
 	/*kfd context id */
 	u16 context_id;
+
+	/* The primary kfd_process allocating IDs for its secondary kfd_process, 0 for primary kfd_process */
+	struct ida id_table;
+
 };
 
 #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
 #define KFD_CONTEXT_ID_PRIMARY	0xFFFF
+#define KFD_CONTEXT_ID_MIN 0
 
 extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 extern struct srcu_struct kfd_processes_srcu;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 995d27be06e3..f1e8ce61290b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -827,6 +827,7 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
 
 int kfd_create_process_sysfs(struct kfd_process *process)
 {
+	struct kfd_process *primary_process;
 	int ret;
 
 	if (process->kobj) {
@@ -839,9 +840,22 @@ int kfd_create_process_sysfs(struct kfd_process *process)
 		pr_warn("Creating procfs kobject failed");
 		return -ENOMEM;
 	}
-	ret = kobject_init_and_add(process->kobj, &procfs_type,
-				   procfs.kobj, "%d",
-				   (int)process->lead_thread->pid);
+
+	if (process->context_id == KFD_CONTEXT_ID_PRIMARY)
+		ret = kobject_init_and_add(process->kobj, &procfs_type,
+					   procfs.kobj, "%d",
+					   (int)process->lead_thread->pid);
+	else {
+		primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
+		if (!primary_process)
+			return -ESRCH;
+
+		ret = kobject_init_and_add(process->kobj, &procfs_type,
+					   primary_process->kobj, "context_%u",
+					   process->context_id);
+		kfd_unref_process(primary_process);
+	}
+
 	if (ret) {
 		pr_warn("Creating procfs pid directory failed");
 		kobject_put(process->kobj);
@@ -863,6 +877,50 @@ int kfd_create_process_sysfs(struct kfd_process *process)
 	return 0;
 }
 
+static int kfd_process_alloc_id(struct kfd_process *process)
+{
+	int ret;
+	struct kfd_process *primary_process;
+
+	/* already assign 0xFFFF when create */
+	if (process->context_id == KFD_CONTEXT_ID_PRIMARY)
+		return 0;
+
+	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
+	if (!primary_process)
+		return -ESRCH;
+
+	/* id range: KFD_CONTEXT_ID_MIN to 0xFFFE */
+	ret = ida_alloc_range(&primary_process->id_table, KFD_CONTEXT_ID_MIN,
+	      KFD_CONTEXT_ID_PRIMARY - 1, GFP_KERNEL);
+	if (ret < 0)
+		goto out;
+
+	process->context_id = ret;
+	ret = 0;
+
+out:
+	kfd_unref_process(primary_process);
+
+	return ret;
+}
+
+static void kfd_process_free_id(struct kfd_process *process)
+{
+	struct kfd_process *primary_process;
+
+	if (process->context_id != KFD_CONTEXT_ID_PRIMARY)
+		return;
+
+	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
+	if (!primary_process)
+		return;
+
+	ida_free(&primary_process->id_table, process->context_id);
+
+	kfd_unref_process(primary_process);
+}
+
 struct kfd_process *kfd_create_process(struct task_struct *thread)
 {
 	struct kfd_process *process;
@@ -1195,6 +1253,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 	if (ef)
 		dma_fence_signal(ef);
 
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
+		kfd_process_free_id(p);
+	else
+		ida_destroy(&p->id_table);
+
 	kfd_process_remove_sysfs(p);
 	kfd_debugfs_remove_process(p);
 
@@ -1601,6 +1664,13 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 			goto err_register_notifier;
 		}
 		BUG_ON(mn != &process->mmu_notifier);
+		ida_init(&process->id_table);
+	}
+
+	err = kfd_process_alloc_id(process);
+	if (err) {
+		pr_err("Creating kfd process: failed to alloc an id\n");
+		goto err_alloc_id;
 	}
 
 	kfd_unref_process(process);
@@ -1610,6 +1680,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 
 	return process;
 
+err_alloc_id:
+	kfd_process_free_id(process);
 err_register_notifier:
 	hash_del_rcu(&process->kfd_processes);
 	svm_range_list_fini(process);
-- 
2.51.0

