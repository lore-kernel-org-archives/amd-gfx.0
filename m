Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009DEC87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 08:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8829510E805;
	Fri,  1 Aug 2025 08:56:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lDe0zjbZ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40BE810E805
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 08:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weRXdDZzlu2JzGxLEJ6pXlFzuPp9Rq+71jFNXbgW8NAaiO8ns6m9p8ME2aud6aDyK98v22S/Qjya+fd+AnyiSUxcNkBfoc1c0waAvDgvuh3hiU9OAbZW+vkaMrJ333OmQGJ+cCo9E3iec6p/yCYs+yNi5ypgveLSDIDgIebQLCe73mZrTd2sfiOKUboudiodtFXN0cDTSXNprAYCpo6IOdNhXqTnL9gEOj0peAAa7BS5I1fuoLLFoAQl9IK0FZ5qPI9PCMIop4EwmxeYAhkKVt7YFkoZKn2DrnNS3iHxbSiUhcrSHE5ZHatigqw3tiQnJgt1Vo6DUe3bZw/tNQt5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsK50Z3G6wwSVPOOzYCiK+b1cpXDDvvr2ikzdSSDcTY=;
 b=N8An1GT5PW5H35PJydOZObuGPQhPSbZVmTQHJ5gbLHmuwE+5S/EYW/txVEcVi2sj6viS4SoGdA+ytm1iMXA0/XA9ExHvhKolG1iStHjg467fFuBobDJqh9ynRpmHZ0xW1sK1M2tlHjHpWSSNr06pBXuoqCPQNSRx94OOx9gBV8s9YF2QC1vZSgzM3bSlGy+3H3zrzyDqXySY0Fs1exLTxNM/YgHhEqy36HiCezhctql4Sr1sbSACG2crCWL0/p5PqG46Eb54SFs2pAR6O0rAZEpA5//ZRnpmHob/r3iibfZPQ2b8J59AumTGPMAJo0AvgfukEouiveJQCs+gqYQDgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsK50Z3G6wwSVPOOzYCiK+b1cpXDDvvr2ikzdSSDcTY=;
 b=lDe0zjbZfTx82CCA/W0+/pst9pPSuOtUn9tFhBFN0FnThXJ0puvyT9ZDSItSzE/tZspPz/z/wmGXxuE4UPYkLQDa7/qtWNSbusgbEunCz+OcziKshVBsHZeeQmGC1YeyivYShw7/+3zLL8OzsW7d5JiZNtpJ9mztDO7SHzUz1U0=
Received: from BY3PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:217::31)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 08:56:35 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::7) by BY3PR04CA0026.outlook.office365.com
 (2603:10b6:a03:217::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 08:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 08:56:33 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Aug 2025 03:56:31 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V2 08/10] amdkfd: identify a secondary kfd process by its id
Date: Fri, 1 Aug 2025 16:55:54 +0800
Message-ID: <20250801085556.8504-9-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250801085556.8504-1-lingshan.zhu@amd.com>
References: <20250801085556.8504-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: e6001e52-bab1-4c9f-83a0-08ddd0d950bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vl+706lrJmyGtkYJ9awpwacTYVzHkHYyhvF7tbJr1KFGWO+GsLF7jCsq9dYY?=
 =?us-ascii?Q?cH2gtoz/QaWFBiip/XvPTf7GMocgXCAXOllcM6Vr78kJAHNdYAiE6HQgNPAz?=
 =?us-ascii?Q?dCdEe2rPgDkzKwxeTVyPEUlYGyuLbgX05WVij9rHHBJDyKmM8ok5eHWFeE4H?=
 =?us-ascii?Q?4raP/Gznteo58OuAdPnfQT3jXCldme/YIlwiYGL0Yizxy7fkf13H0Cn51wEz?=
 =?us-ascii?Q?dNZnGa1n40DmZ3cjaVOAMt0CoFEUFHozoXaTPAAiLzm9cYkQELZgbX3lCL36?=
 =?us-ascii?Q?MTqGmbBFEDlT5MlnpGvXLj78cVzNIsmwbB2OeeLZTl8IOp4GEedqNS05ZIgx?=
 =?us-ascii?Q?rCWUVFHsPBCvFK+3q4CLSqvJYG4HsB71Xtoc7hzCzqjO08vpxO3Ya5KFgT59?=
 =?us-ascii?Q?hYiew23WXNjWR69vXYQYRGxQB67vmlJEXV+W8JblmMJEYeViwapZcCE2OZwS?=
 =?us-ascii?Q?ekM+rMfzMgQyo1HVrbc8nugwDd+xwaFXYngZQT6+guDWo+euMmg2bKjXdP/e?=
 =?us-ascii?Q?Opo6OhDO9yPG2j3BzE22vE+7YMR3KboG23ligs/KBtNydcHtm6eMCzJC6C6s?=
 =?us-ascii?Q?DnBSsFaNFJThvSadLq1wBi2/UUmAwvnOqktymoWuPSVr8NEifeSZxW15Gjgi?=
 =?us-ascii?Q?RgV7yFvEQRoXiIlySTG8qsyy31kqlrWxPw4hkvYa2YBcwuY5LioEYjbBILjZ?=
 =?us-ascii?Q?d0lx9tEDi+RPIxQmt/sLtAfFOmA5g5O6YEmhcuJmB5AAKhVjBjyLaSsT6KYO?=
 =?us-ascii?Q?OErlrxAJjFt4znQizGurAmd60x2UwOv8CXqkEqFGrAa9zcFWdW/3pqA2sZm4?=
 =?us-ascii?Q?2xkELKeI+vPFS0wOrmVbxr4Or+J3GdGy0t/ApoLCnW0lR7mWTXmnOsdsf4Ft?=
 =?us-ascii?Q?9kFF0QKO4+l5GyX9nMZjPVaGfAv7kMnjcXfkqUjQ4DyoCJTjMOg8O7qxjYVH?=
 =?us-ascii?Q?MtY26VKzLwkskZBAOBfyQT5QL1CktR+3YPFJw6rLWzw32T8PoRab1ukmFLpk?=
 =?us-ascii?Q?IW7Jhnq42t3hqaUtiMyEpEPRvGVTDWnFtA3wZDBYIWWyhlhVgmHQgPXGsykJ?=
 =?us-ascii?Q?vxwU1PT+rBWdglmGSIprdXQeHbeDlpk2u6fYGgQcvHSAfIL4p70whzAlO2UC?=
 =?us-ascii?Q?aIEuzo/R3Pvt+iMdSYSXs2LSvVTDVsaWEAdHSCRNb3dHM2u4NqWdA1FaNb1U?=
 =?us-ascii?Q?hGwcwXHRiJXJK1RL316OaNs+XeK5X848mJOiQWd1PgFJYyRIZZjuQNgonMBR?=
 =?us-ascii?Q?4iTRXKXadV7x85LLT+TlvdZshxqxT4MPy0klVj5cOmuXGbs/M+FiVmLEXSqw?=
 =?us-ascii?Q?+wEMn20jnMFLm9585X3JYatpX91Ocf1PgLoleRxV07h7jzrnesrG4x2t+uo+?=
 =?us-ascii?Q?q4fmPSWn4sh60V/Sc0xyuwFrHk9Z7vMUVmuHDEEcf9I3PP5cC+OaV5BDjUub?=
 =?us-ascii?Q?xPILuFmcMZgL6xp8qvGbhqHIA8tgLYeqtdI2r79C/JpR6cedm7Rztu6phsHc?=
 =?us-ascii?Q?SWDNW6b3ca4R5v966sxQrVkDiUr2kyh4zcMj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:56:33.6342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6001e52-bab1-4c9f-83a0-08ddd0d950bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726
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
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 83 +++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 3 deletions(-)

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
index 440fde75d1e4..117e524f4fb3 100644
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
+			return -ESRCH;
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
+		return -ESRCH;
+
+	ret = ida_alloc_range(&primary_process->id_table, KFD_PROCESS_ID_MIN,
+	     (1 << KFD_PROCESS_ID_WIDTH) - 1, GFP_KERNEL);
+	if (ret < 0)
+		goto out;
+
+	process->id = ret;
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
+		goto err_alloc_id;
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
@@ -1619,6 +1694,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 err_process_pqm_init:
 	kfd_event_free_process(process);
 err_event_init:
+	kfd_process_free_id(process);
+err_alloc_id:
 	mutex_destroy(&process->mutex);
 	kfree(process);
 err_alloc_process:
-- 
2.47.1

