Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26B2C87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 08:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E7E10E7FE;
	Fri,  1 Aug 2025 08:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t/N7ta6R";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A2810E7FE
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 08:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7UL/JlZwdEH+/IdOuu6VOdxFQJY64Vm4f2Fg1rsJEekml8zO71J4zqiHLvngQDKxFYJYiX7rdyuqs+fz/czNfWGTRtZLhTZi7QNOq9KuBClrkokpSB+0TWGvFz+3SE8sVN+0tmX3jzFsD6+0PQwIdKuX4bbCo4R0WwKPtqhivIVTJ5nlF4tSfOCzOaLBHn/H6FvYDT4B5Fzll/7GZf9HKKJj+wdtjb+cMqA1/GCqDY3bIRSsKQtDw14uKBx/qWcoxUjUsPOTurvtxTFa4STG5ghiQClgI2/GVLLuE+xqlMxBKCc3e+FMB+ghwmNImunAs/4sP9PnYRn46cTs5OrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXyVCI3XZLX7S5naH9Ip37OZK1g1h+MA/MYX7qwLcU0=;
 b=lBvqMjvvPFHhNgo8VHekrZQibjOuwQacmPtROQeMFIo015ovEJp4iUdcQ84sDgDA4QFVhDENImSbsQ+OaLqCTc0c4Uxk7SrUEnQPrhXZsgWATceOHa21x1EQHJSf9ZrHaK/agt1zpbq58EWjyJWRlG7dOK5UWZ1eyQJLOsooQa/lHJah1ur603RfucSsHvBJnCzMfL1pq4CS5Itlwi98zJLMMt9/GkVM3B2HfqK3GQkvD3xA9pMKfsdHpZSLGkt1KRyTt+08CNrA3cY62uDjyxVamFWfRggKF0ZJx9VRxTQiYanJGBCfPzhNpjKkaSwr9ueynhxgNlJz0aZFGt0yYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXyVCI3XZLX7S5naH9Ip37OZK1g1h+MA/MYX7qwLcU0=;
 b=t/N7ta6RE1vQClqeZI+lk9s4sFMAIYxsZNNHk8vb1GAtauFvhZ3TZWYb+APOI6n3cSzpBlOiQWXU8BJeQd0161l49uoc1K000bZPR28SEbw0rcyS8c08iiEGOl/fo5qvPjZU7X9BiNtQrvqmXZy23q1J7QJWxj5LO3d06d3tHYA=
Received: from SJ0PR13CA0066.namprd13.prod.outlook.com (2603:10b6:a03:2c4::11)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 08:56:23 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::80) by SJ0PR13CA0066.outlook.office365.com
 (2603:10b6:a03:2c4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.5 via Frontend Transport; Fri, 1
 Aug 2025 08:56:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 08:56:23 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Aug 2025 03:56:20 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V2 02/10] amdkfd: mark the first kfd_process as the primary one
Date: Fri, 1 Aug 2025 16:55:48 +0800
Message-ID: <20250801085556.8504-3-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3c4681-d9ef-43af-7f5e-08ddd0d94a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TysH5uiyf1mMmI/CMJslNqldzCH9kCXQYyVkAo0/9AoPYBZrfnPNRcJHHtmh?=
 =?us-ascii?Q?ZgZChz6PJpU9TvmotXwEtIXSHbjynycYgQIICwBxriRaNqzJyLWdpFsR+6jU?=
 =?us-ascii?Q?jQlZ5zlELLA+EXJ+OFhYAvf1q338PBX8z9MS5ZHp6oC84iiSLm/WPQ5zbQv8?=
 =?us-ascii?Q?8ODvJOoD/ppmv31rDquk0xWuQaJ7y8KK2mVkri4rzgplCThcHUZRnUPuqvQh?=
 =?us-ascii?Q?qw0bSvT+yJgpR5HpBweqOzmc6pphgh3qP8AKyHRvLMaSLUrZMmdlcShHr88d?=
 =?us-ascii?Q?ji5iK/SkFY7QU52oDzp0xR2rRK/adP7q7OIdkSMyq0EIXlA3LFU+2KaK52Cz?=
 =?us-ascii?Q?3oZBEGb79GMt6XjIbIuQxfdQgOA/E6n9KfaM+PhXyH6Xy1NZOr+JwZzCTELq?=
 =?us-ascii?Q?3SVkpBU/9C2xtc4aKJtxqfjNRgarquXITwmm7uvLy0ZL2WeuoBKcpyzP+T1t?=
 =?us-ascii?Q?lckNvCz7qRpKwsBRwr3iAAZgPABTmt4If+HwiyAWrtq5NUo1AG8JEOYRVofM?=
 =?us-ascii?Q?RfPSQvaSp+jDXKt0XAwRw9vmKVMARk9k42Rh1bwejNVjR9jG3CpIQCX771m6?=
 =?us-ascii?Q?8A9c7qJZ4k+U3s65ojJUydJ4S0+XEnNDC5v7G1YKJFfVQCJzqRVc/6F5FsN6?=
 =?us-ascii?Q?mkg6mgYVr3R8S94kuHR07Pwnny2uiGBceky8065X5gAuBKSTzuxCZ3mupXEX?=
 =?us-ascii?Q?6tICbDM3mmZQClkNDW5W+NEwgR75VcForVpaTdrE+NyjuCF0CDt0hVxhCYuv?=
 =?us-ascii?Q?KihKNNM/9FLgqTYAGe7cVhDQBmaMSTssME0XX3ADWEdsaziOeGtga2DjS15y?=
 =?us-ascii?Q?vGA4+fIOLnuVh8KvclJ0nFzFMLxBbCToGKitEpQabmtvYkcdNVr3tgyn/GSn?=
 =?us-ascii?Q?2JIcsrj4JBQNHXqEEHpsTw6CBNCgKnxmoIRuVIueoA54cf7a6kfbnVlw8rBW?=
 =?us-ascii?Q?MQxK+YMDzm3gUjfQDOzL5ihDxkmyJA39C531+B/L15y8S48mQPniO5QGFnRY?=
 =?us-ascii?Q?oMCapPZ0lEiEv6uL/Q3YojbLfrG0IRqaXBC7o4JcCCYKTQF6XfyV3AuoSS6C?=
 =?us-ascii?Q?TwlLuzn10zQ3n0G3uETilw+I+s9LWnm4khDmmY4W6ZVdj/f1nUyGpTfnngFM?=
 =?us-ascii?Q?mviKTbrqP1T+tOMT0CBBTibIuazIqkndYaimDhHQFXcXdW4GvacCkqhPjiEq?=
 =?us-ascii?Q?dnzeZvjKazb0gHNp4VBekBb/oWE9rBSwPJmu0vyuYUaAEAm0IfcPLl5oyh1r?=
 =?us-ascii?Q?s9WophvwyiN3Vh5JI2WU8n/JRC7vEB7hu3Uq6W6OTmYnkFMH5/6Cca8fCJ62?=
 =?us-ascii?Q?UImNhPgMHjBobnA0Wobg23MAytwTdoEyIHt9eKdprRhv3AjzmqOgGx+tNSga?=
 =?us-ascii?Q?0e3n+4HqTXZgOpaTlsQOA6pmsqSBSXINq936iqTLv+xYWPZXPyYFrkRJg8a8?=
 =?us-ascii?Q?3RwDXImRa6ucWIP5+hrrIY6/vOT8P08SahaoTtGxYBILYlme3LILRbka5diZ?=
 =?us-ascii?Q?XDPMfESW815c3iKMOmFWyrsBri2wl/ADS83K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:56:23.1365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3c4681-d9ef-43af-7f5e-08ddd0d94a7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
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
this commit marks it as the primary kfd_process.

Only the primary process should register the mmu_notifier.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 20 ++++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 38a20ba61e24..8149ce0639c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1006,6 +1006,9 @@ struct kfd_process {
 
 	/* if gpu page fault sent to KFD */
 	bool gpu_page_fault;
+
+	/* indicating whether this is a primary kfd_process */
+	bool primary;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 722ac1662bdc..955ca8725bc5 100644
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
 
@@ -1510,7 +1510,7 @@ void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
  * On return the kfd_process is fully operational and will be freed when the
  * mm is released
  */
-static struct kfd_process *create_process(const struct task_struct *thread)
+static struct kfd_process *create_process(const struct task_struct *thread, bool primary)
 {
 	struct kfd_process *process;
 	struct mmu_notifier *mn;
@@ -1526,6 +1526,8 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	process->lead_thread = thread->group_leader;
 	process->n_pdds = 0;
 	process->queues_paused = false;
+	process->primary = primary;
+
 	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
 	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
 	process->last_restore_timestamp = get_jiffies_64();
@@ -1569,12 +1571,14 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	 * After this point, mmu_notifier_put will trigger the cleanup by
 	 * dropping the last process reference in the free_notifier.
 	 */
-	mn = mmu_notifier_get(&kfd_process_mmu_notifier_ops, process->mm);
-	if (IS_ERR(mn)) {
-		err = PTR_ERR(mn);
-		goto err_register_notifier;
+	if (primary) {
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
2.47.1

