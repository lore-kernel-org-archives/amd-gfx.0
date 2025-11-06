Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADC2CCFA19
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F6DF10E331;
	Thu,  6 Nov 2025 06:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A2K/FKg7";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E97F110E315
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgEDQ7qg0VRJNMeQf8NhcPWSoxuWTZJGU1+04T8J4wGiV8UenygmlsCSY5Ijom/BtgOM9ICQxenMFgzyuuKJSr0ChbT8wRwbOYc5AnKDu4wQaB4EAeA8MGlh66Sdtee2vHqfnzSAvJmc0QFSxSHt9MrXT1bS400yopkbtfyRSFUEmwxvqyeOBCwBRG0sQTaauWXhmnQ+HO3p3dTTtnFwqIsZX5/KfxtESazFjfS9W/B8LU+TvqVc9/4kTTOITsfdimOXAtNkrRqLwvR2lNWaZoJwli/euGqikPLcNxfPx99Kk9K/RPp5tpEhqMx9jxvDBeBwnggsYHYSXMjdoRBncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EDAUfI+hDsxekFAhO+a/s8+owTwTa0hzXxNylV9COk=;
 b=seHNpDirSKWLzXPIQuqkDua+Jp/61ohmvc8Udl4MxRtubzyAM/3xScUsn4VtqhXzissRVHX82ut5EK/JNGl2y5XqjyMt22Bj7a2t9YmrmxeY6A7ZFwNr6DiRsYQBgv5S0jUP9JkjvL4Y8XJy6tB5fLw+giMDu1EdtesB2hSb4bgKGlGhctWHC380qjId4ZUWUBWN2GLPB68fxIpQko/+efcIQo6TTLt83z1XkfBl9WOt2fGFZJDFSAa54r5/Kxu/0zylP4KBuKqgFd0I24pPBjqHmPyeXylDTLLPE7wnYLVHu3AWKaZ8Rhy356qayXiVgOzDaD/HkG2cTwDV/gOTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EDAUfI+hDsxekFAhO+a/s8+owTwTa0hzXxNylV9COk=;
 b=A2K/FKg7N1Pwdlu+QBQKpfYh83CA4+GLlsn8sUpJzHpy8glBquBfgUPQTqt6DfyFjQeBJl7orzTog1cE3gGkK48ZvPp41cGyIouAq49C0PMvELCmR3I1GfTk9xuJ5poX5KtTMenIKGR0ggA1NNw28TFC905eGDeH0xHmWniIc94=
Received: from SJ0PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:33f::12)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 06:08:08 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::cd) by SJ0PR05CA0037.outlook.office365.com
 (2603:10b6:a03:33f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Thu,
 6 Nov 2025 06:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:08 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:06 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 02/18] amdkfd: mark the first kfd_process as the primary one
Date: Thu, 6 Nov 2025 14:07:23 +0800
Message-ID: <20251106060739.2281-3-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: ed71a6d2-daa1-4cf7-b714-08de1cfadb67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nLIu1euxNcxVoLhSWhmCFsj4YqumBze9eFcNNpzXvZ5C44F7b2hqpbXrUj1w?=
 =?us-ascii?Q?9+eA1ycS/VVvnHkl0sHRkrghNeiu9f457K48cBXQ5q++UGpsGBGKieUFiB9p?=
 =?us-ascii?Q?TeKdvHk8qv+dUtJCHouYc09Gqk4hkeBOnoYD8lYKSOW5L/L18fTzhXYG+4OG?=
 =?us-ascii?Q?H7sFjmUVRbDqj5bJRkqN7BsRQ0k3QZ7ylnnaxxjr2QU2XpSGF8cGDgea1QR+?=
 =?us-ascii?Q?T5cPlMjILTEQARrrrqj8xwfFSoXHvBKSN9S+1fmRyRnhLGefpXWbgdbZzYCg?=
 =?us-ascii?Q?CSEWozODmedM4QjchnD4klqrMdd1IEbtmRxdLYEjgYu2Asqn4NmaM74AFosf?=
 =?us-ascii?Q?lYNleoBMxcfeC5kWguY7By0RhmzUBdcSmOIDS9HhTitDdnpX474B+8mXjUug?=
 =?us-ascii?Q?Mg/1LiWknKx2S+dhqQsnZNAk1+04wm23eLF09mBEws9ZewFwD0cEbFhuH6uW?=
 =?us-ascii?Q?27G9EPdvGoScgEOpApgxWHo4rBGBfRjNhIiLDNpBHCpjwEzyuFKSEAaqT9bv?=
 =?us-ascii?Q?j+s4lk9auKdwF0jkeaJEXWpK+0fhOJ/JU0s49CtdOnHEgxgvXfdn19YtSIn9?=
 =?us-ascii?Q?HgWPyppXLegJc4yt8eFE5z+9A0Ffv+sOelga5MpVxf4iq3qk2W0w5hLZ7TET?=
 =?us-ascii?Q?ALPOUjmHmFAQNxgSL5txYoJUZ0kmE+zyhysCOxQmPHCLju2O9Kp9VoZ5aKUH?=
 =?us-ascii?Q?/Bs/c5Fsu8SDpAoK16us/vZcxNVKdiQempwxqKwok9LE+6eGior+TCRyJfIy?=
 =?us-ascii?Q?bPTrLD6xo+zzOKmKQOc9dI7Or01ZjfgWCtCAo3UBLOg0mf/VrcwWg+eGpk5E?=
 =?us-ascii?Q?hbNNvVROK1IrwBiug2oR8eJmw5MVn4kOI5MxI3UDINIjlFLwPo1CbX2Xf4Ej?=
 =?us-ascii?Q?bqgbgPJdG5AGmYK3vQw0HCNDrsy+4xnMWKsXhwgXqHq2LZ+BFCj8zUKJeCUj?=
 =?us-ascii?Q?FgbJMz0QfZGmEK4ZkqlCynMbcFtNvXvKMm7tYmkAtxae81EVatIPylg8zWBs?=
 =?us-ascii?Q?bk2XWiC5ZealBY0LG5QQFrO1Evc5SEmYXZpIhTZS6F8iPABTQSuQY9/kHwn0?=
 =?us-ascii?Q?XuxkXCpPNxXPhwu55/l3MNQjzvzu+dQWTBu4IeSHS5NC0dE5IrtSmOLZ9VJD?=
 =?us-ascii?Q?ut0WNvD7ZmL1+S4EenIjOEXF+h+vlymJeYGKCe5zcM+iZLjhrKufdlzhsOkS?=
 =?us-ascii?Q?38/FynXDfKWbdjPGpSGgRhcqZ+lMmobPDFP0qrZvwN6le54vSC7FfCdHpVgJ?=
 =?us-ascii?Q?RX3nA7vy1eoz+jL4ZC64ZTkFrZO/z/2vmWNAr7ATTBD9M4yJRU7DxrJuCU8a?=
 =?us-ascii?Q?qUiYtnx6OnClFD27bMe6MxHAcM9SwplyS2kjpIIuR6VZAyFFIMjFMJSyes7N?=
 =?us-ascii?Q?VwtX0RkugRGlibTUIRpq+Y8woSI3BN4lrBiPGjDyU05H589HTRK62H4/j6Yq?=
 =?us-ascii?Q?xkFdCWuOEfVwOoN7BSNVxYoQc3UqhcmD3FoMmNAU5czUvQQJdWRO7eFhX8pF?=
 =?us-ascii?Q?CisPYcqESTOl3NkHk6JWEr/aWT8/MY0wBqZd1mk3vsHFV48JrD7+u8EHmHnq?=
 =?us-ascii?Q?nJt93h8OY6oGCrN1c2g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:08.0252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed71a6d2-daa1-4cf7-b714-08de1cfadb67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233
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

The first kfd_process is created through open(),
this commit marks it as the primary kfd_process
by assigning a primary id for its context_id.

Only the primary process should register the mmu_notifier.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  5 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 20 ++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d943ecf62a3b..729330f8a384 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1018,9 +1018,14 @@ struct kfd_process {
 
 	/* if gpu page fault sent to KFD */
 	bool gpu_page_fault;
+
+	/*kfd context id */
+	u16 context_id;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
+#define KFD_CONTEXT_ID_PRIMARY	0xFFFF
+
 extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 extern struct srcu_struct kfd_processes_srcu;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ddfe30c13e9d..2a22c718ee94 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -68,7 +68,7 @@ static struct workqueue_struct *kfd_restore_wq;
 static struct kfd_process *find_process(const struct task_struct *thread,
 					bool ref);
 static void kfd_process_ref_release(struct kref *ref);
-static struct kfd_process *create_process(const struct task_struct *thread);
+static struct kfd_process *create_process(const struct task_struct *thread, bool primary);
 
 static void evict_process_worker(struct work_struct *work);
 static void restore_process_worker(struct work_struct *work);
@@ -867,7 +867,7 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	if (process) {
 		pr_debug("Process already found\n");
 	} else {
-		process = create_process(thread);
+		process = create_process(thread, true);
 		if (IS_ERR(process))
 			goto out;
 
@@ -1512,7 +1512,7 @@ void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
  * On return the kfd_process is fully operational and will be freed when the
  * mm is released
  */
-static struct kfd_process *create_process(const struct task_struct *thread)
+static struct kfd_process *create_process(const struct task_struct *thread, bool primary)
 {
 	struct kfd_process *process;
 	struct mmu_notifier *mn;
@@ -1528,6 +1528,7 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	process->lead_thread = thread->group_leader;
 	process->n_pdds = 0;
 	process->queues_paused = false;
+
 	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
 	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
 	process->last_restore_timestamp = get_jiffies_64();
@@ -1571,12 +1572,15 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	 * After this point, mmu_notifier_put will trigger the cleanup by
 	 * dropping the last process reference in the free_notifier.
 	 */
-	mn = mmu_notifier_get(&kfd_process_mmu_notifier_ops, process->mm);
-	if (IS_ERR(mn)) {
-		err = PTR_ERR(mn);
-		goto err_register_notifier;
+	if (primary) {
+		process->context_id = KFD_CONTEXT_ID_PRIMARY;
+		mn = mmu_notifier_get(&kfd_process_mmu_notifier_ops, process->mm);
+		if (IS_ERR(mn)) {
+			err = PTR_ERR(mn);
+			goto err_register_notifier;
+		}
+		BUG_ON(mn != &process->mmu_notifier);
 	}
-	BUG_ON(mn != &process->mmu_notifier);
 
 	kfd_unref_process(process);
 	get_task_struct(process->lead_thread);
-- 
2.51.0

