Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9BFC87FCC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 02:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324A410E411;
	Fri, 25 Jul 2025 02:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CLMlIZs1";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAE4810E410
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 02:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuEHvnNRHkYMTMETfoD9WosOdW9wLUBzR6dqeXmETVupOXrqsrxOSYwqHc5AQfejmYhmJMW4bMU9usfKF+/g3TOpFzRtzaHDJQqHcBwv94iRUgm/k//3Rjt8ZJk6VkGtfzPrv8DVpWA4QSHwBPvJcFmo/nGNc9Ycoa/8Xslkjb7FaMEMcqbtKQBM1zu6BOckgdflVaPLjFu2/UzyYblF8xOhyQ0uZ9r9oTNr3UkSMCHv+ti3+CF4dlRfiL4JxORnfkQ5S9p/+aEDQ8/t1RcoCM3g9P7iQr3lCw926ApSfcKM9WmhxpstcjmRny0xyzekv/XoegV12mugeTyZLVPshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xo+F2j+SgoqxzkN+OY13kBKfwfCfZaUFmWBDj0iXU/Y=;
 b=wBYaXu78eV56QmZ2HHeYq+/vA9UleokaxWUH+F6Yo/ZfT80O3naepowj7PO9Qusp/HsjzB7zy/c0iWTpAITVUR+Al3v5o8sB4uutKMr/NxTnaWxcInOKxauqxcL7qw8SB6rCgTyGr1xpiu+8fpootPp0PLtcXWwfVmyTopgA3oW4meqgrGd70SqCPVp+LaTs3PvU+xT3a8GHos0XpOk0Q+9X/k3n84QXkZUVwd00GFRNAMf5Pbesmd5G4QQQIVOVrA2JVQHqW+c06MgQ0f8+sZvfsGqf6hOJGxulJxvBpYW9zviDuIOO7dPdPI2sI8qd7V+CZ0mPKgjZd+a9LQW4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo+F2j+SgoqxzkN+OY13kBKfwfCfZaUFmWBDj0iXU/Y=;
 b=CLMlIZs1WAUfYCE3aM2y6RxwueF5mo522wNT0/RZgY6QSweSVvSOdPp46/PD3KqQb2IsHsW2nu1ff9tb4129PB0uNO9TjIKODTUjc8FGXflhJdzyedBFzGyuWKp14e5EY+Se1FLKZByUnj50dGq5T/I8XxxNCE/2gUJmWs37Aj0=
Received: from CH0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:610:cd::11)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 02:43:45 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::d1) by CH0PR03CA0096.outlook.office365.com
 (2603:10b6:610:cd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 02:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 02:43:45 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Jul 2025 21:43:43 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 8/9] amdkfd: identify a secondary kfd process by its id
Date: Fri, 25 Jul 2025 10:43:15 +0800
Message-ID: <20250725024316.9273-9-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250725024316.9273-1-lingshan.zhu@amd.com>
References: <20250725024316.9273-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ded9f4-495f-4c79-aac6-08ddcb251366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gyp+6ROgMDSu7zT9DwhkE+Olim5MLsaANGQ1QmQfTfkO7rfrr69Cfh8J141/?=
 =?us-ascii?Q?98HXIsJ8dVaVzAF2V4VAjCVqeJvginbu03dCZ26XSLd5jNPr/y+6ad/bOYcH?=
 =?us-ascii?Q?0w46vnF3GUDd2aNUjMDFnd/B2adlOMhtTyVjgKn0tFAfxypsoZeUH26kLsxG?=
 =?us-ascii?Q?T+oElG6zd+x9gTrsRZDlh8uiqcK/5SKsS5eDSvwX2+BSEG76dwlfuBHfqKTv?=
 =?us-ascii?Q?voI6CjkF/9nIaeg38JHVWsNp4PBLSqM6RX5xipj/TsNBxijwQwolAcl7BZbf?=
 =?us-ascii?Q?1kfeDp79CrOVrB+SQGu3JsI6kVK60udAdCybvxLm/AWI8Q+i334/+LifDD8M?=
 =?us-ascii?Q?otLZdxhB5YFFLBEg4Tgf0z3yhF61G4ZNLUylJqwrIGMEod0v41YGWLEyLOc/?=
 =?us-ascii?Q?Xfs5aoiJnNaDXl77EkG/Xp9suW9e2WQtRzmd2eT6AEFpcR3Ew3/GmixHGgij?=
 =?us-ascii?Q?9XpCUQqy5H6zHChaW7CdtUuUZC1+zSMx4djSIQvDDi4B0fBA5vzF/0gkuM4s?=
 =?us-ascii?Q?mJC2pFzj1NTmul794UPjB8IW3k5u91wDjck/DYPNy0QiBbfNcrwPqFwnQFYp?=
 =?us-ascii?Q?vg852GC4e/DilMdM2JAnuAS0RsLtxTRw7HLZUVw2a6+RPmNNJY+fg3tw9ZlJ?=
 =?us-ascii?Q?D4JgdeIlwUYlPI68UbWYPUvtkLsLmcny++dzqVGYHRV+NV2n0+nVxQ0yamOS?=
 =?us-ascii?Q?k1wc97YGb6RvR82MTlFmo/oLCw14Bm8hNyYQ/g3/zdN70P5S+yApQqqQiL2h?=
 =?us-ascii?Q?xD2Jk0nXW595svVPdxngotFYIZGQ08TzGmwowNAUQg6/Rmh4app5U1NA57JJ?=
 =?us-ascii?Q?z/b0HRx3HBlhzCw4jZRcAm/ga/lszxDdIetKhqh1VS0WI3yPEqgJ9ldV61UF?=
 =?us-ascii?Q?fp9akxMTJ/qY1Cm2IDQcnjKyOJksV6RiVeuhy+s8PppQJyi+ptsjo+NlLiIj?=
 =?us-ascii?Q?9qSMCd3gWTWwrw8oJJCbMPjoS5DtGB3GzYee+KvskGZFMAdjp8WSwPz0efsa?=
 =?us-ascii?Q?PaE7Bl1SGkwgY2yx04etvJwX6X5MnU7pTgmWJ+AVxXie3W23YqImBDLUMk8y?=
 =?us-ascii?Q?r5BoaWX2yVU139G8h/SZcnU4VaQvqupDSw2aB8FB+bzyETRpkWZcGXPmLeFN?=
 =?us-ascii?Q?AMal3Mkmbbw4bHBm6L8GzxlV/wtBN2YidFk5Dn7HYfXczzX58utkayY4XLHV?=
 =?us-ascii?Q?SG3ZrR5uOwgWIMFj8IXn2PR3kTfS4NGlKLCtgf9C67XZciSUlm61cd5yxKGA?=
 =?us-ascii?Q?WaE91qStCxDWBFDT1l42deVh67rlgX3ejZoXCladX5SZRUhozopSfvgYG1bB?=
 =?us-ascii?Q?spTNGKzGzUb09MbD7kkx+THSQeQzFECCR2KWpMNNdjqoN3fSd5KAlgfAC3st?=
 =?us-ascii?Q?QWV2bV/eG1Sy1nabME0q255+vbd/08n1R4tRzXHpdscKIyrvhgqACf0W+WZ6?=
 =?us-ascii?Q?dVqVnETtYA88DWPneSaBTwWP2NRuRKfyaq5m1gHzH2ZXdiG1N5lTpNHBCLJh?=
 =?us-ascii?Q?0IaO5DwuxfFHcOgai7HRdzfwimSxjNzgWeA1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 02:43:45.5646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ded9f4-495f-4c79-aac6-08ddcb251366
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
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
kfd process is "context_%u" where %u is the process id.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 82 +++++++++++++++++++++++-
 2 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index de701d72aa5c..a6e12c705734 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -995,6 +995,9 @@ struct kfd_process {
 	/* Tracks debug per-vmid request for debug flags */
 	u32 dbg_flags;
 
+	/* kfd process id */
+	u16 id;
+
 	atomic_t poison;
 	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
 	bool queues_paused;
@@ -1009,6 +1012,9 @@ struct kfd_process {
 
 	/* indicating whether this is a primary kfd_process */
 	bool primary;
+
+	/* The primary kfd_process allocating IDs for its secondary kfd_process, 0 for primary kfd_process */
+	struct ida id_table;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 440fde75d1e4..e1ba9015bb83 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -54,6 +54,9 @@ DEFINE_MUTEX(kfd_processes_mutex);
 
 DEFINE_SRCU(kfd_processes_srcu);
 
+#define KFD_PROCESS_ID_MIN 1
+#define KFD_PROCESS_ID_WIDTH 16
+
 /* For process termination handling */
 static struct workqueue_struct *kfd_process_wq;
 
@@ -827,6 +830,7 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
 
 int kfd_create_process_sysfs(struct kfd_process *process)
 {
+	struct kfd_process *primary_process;
 	int ret;
 
 	if (process->kobj) {
@@ -839,9 +843,22 @@ int kfd_create_process_sysfs(struct kfd_process *process)
 		pr_warn("Creating procfs kobject failed");
 		return -ENOMEM;
 	}
-	ret = kobject_init_and_add(process->kobj, &procfs_type,
-				   procfs.kobj, "%d",
-				   (int)process->lead_thread->pid);
+
+	if (process->primary)
+		ret = kobject_init_and_add(process->kobj, &procfs_type,
+					   procfs.kobj, "%d",
+					   (int)process->lead_thread->pid);
+	else {
+		primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
+		if (!primary_process)
+			return -EFAULT;
+
+		ret = kobject_init_and_add(process->kobj, &procfs_type,
+					   primary_process->kobj, "context_%u",
+					   process->id);
+		kfd_unref_process(primary_process);
+	}
+
 	if (ret) {
 		pr_warn("Creating procfs pid directory failed");
 		kobject_put(process->kobj);
@@ -863,6 +880,51 @@ int kfd_create_process_sysfs(struct kfd_process *process)
 	return 0;
 }
 
+static int kfd_process_alloc_id(struct kfd_process *process)
+{
+	u16 ret;
+	struct kfd_process *primary_process;
+
+	if (process->primary) {
+		process->id = 0;
+
+		return 0;
+	}
+
+	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
+	if (!primary_process)
+		return -EFAULT;
+
+	ret = ida_alloc_range(&primary_process->id_table, KFD_PROCESS_ID_MIN,
+	     1 << (KFD_PROCESS_ID_WIDTH - 1), GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	process->id = ret;
+
+	kfd_unref_process(primary_process);
+
+	return 0;
+}
+
+static void kfd_process_free_id(struct kfd_process *process)
+{
+	struct kfd_process *primary_process;
+
+	if (process->primary)
+		return;
+
+	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
+	if (!primary_process)
+		return;
+
+	ida_free(&primary_process->id_table, process->id);
+
+	kfd_unref_process(primary_process);
+
+	return;
+}
+
 struct kfd_process *kfd_create_process(struct task_struct *thread)
 {
 	struct kfd_process *process;
@@ -1193,6 +1255,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 	if (ef)
 		dma_fence_signal(ef);
 
+	if (!p->primary)
+		kfd_process_free_id(p);
+	else
+		ida_destroy(&p->id_table);
+
 	kfd_process_remove_sysfs(p);
 	kfd_debugfs_remove_process(p);
 
@@ -1549,6 +1616,12 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 	process->queues_paused = false;
 	process->primary = primary;
 
+	err = kfd_process_alloc_id(process);
+	if (err) {
+		pr_err("Creating kfd process: failed to alloc an id\n");
+		goto err_alloc_process;
+	}
+
 	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
 	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
 	process->last_restore_timestamp = get_jiffies_64();
@@ -1599,6 +1672,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 			goto err_register_notifier;
 		}
 		BUG_ON(mn != &process->mmu_notifier);
+
+		ida_init(&process->id_table);
 	}
 
 	kfd_unref_process(process);
@@ -1619,6 +1694,7 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 err_process_pqm_init:
 	kfd_event_free_process(process);
 err_event_init:
+	kfd_process_free_id(process);
 	mutex_destroy(&process->mutex);
 	kfree(process);
 err_alloc_process:
-- 
2.47.1

