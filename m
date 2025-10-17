Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D949CCD19A
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3284310EB64;
	Fri, 17 Oct 2025 08:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UDbV8IMM";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FE9410EB62
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJZi6mBAV+xRhSIQKv3S5H7r2bctiLa3pM9YuNWBoLZLwa5ZSpeWBb8ImY0R2ZDhDUpkvFuY/rMydUob6vLCf6YEV9IryaV3fMW4kt3lHPc79Nbzms/g2+7EKv0pE4naLljzf8gWYsYBcbfwHora6/z2spGOCxxVL5ilJ9RqjmNbsPNH4VskXQ3pZpWUIWKwmcqJzabAStQJcSPsS//zUN8bkKsr/WfEvPjEAje0SJ/WnjpSsQceRJGbAHxpoYJeGogXzfAM7LUiumLvshRfNg25OtJbAzcgWnCkklB4Y0il5nExyJH0VryK9tGqhlQj29+dvQdemarO2y+NfU37LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTAkWkpfB3c0P+ujEC5JnApnKCQP+Y4Ut23//0jYI4A=;
 b=J9DsxinDRYddspE8iBjtWrcOnGmyGdunIMhUD7rLCXa7O7KqyEuxAx6Xu3tXX98mz3Xe9mRPzgm0sIcmuAy9ENzPZV22RbGUrWF4nYLtHHek8ckAyajpodbGo5ySe1Two6nsb3RcfU5D7W84DA6MYYYaWFbLKxAWAJkE6qeWxxZ9K0/mb5BvHvQgxeC8WLNKl5bbiVFYPevByd1PlR9wvZ3MQN5/mzYmeWX1MUTMCkubJ7zBjGHXNsP6LBssdXhxVHzIAFSA+3rt9acrZ8+Mu/mcgmjo1Is5g2iQPm2biMrdaJ5YZ5M3bGH0hndyfgsQ1kHu+K/W4k6MOcQwjI8esA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTAkWkpfB3c0P+ujEC5JnApnKCQP+Y4Ut23//0jYI4A=;
 b=UDbV8IMM99arSbha+rPtYLXu8ELbMV+9LpHvhSS013zpw8aes65kpV7wSDmyt6S39pX4AH18W4DWnbPCdXplS9B/C95ACVZRVDtgZqPlwd2m6lIcWMrokrIjX1pb4ez2rFouQ3AeID1J1zOpS5QlvTqjU6LEsRV0DCKXnGJU/fk=
Received: from DS7P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::18) by
 CY1PR12MB9674.namprd12.prod.outlook.com (2603:10b6:930:106::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Fri, 17 Oct 2025 08:43:17 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::ca) by DS7P222CA0011.outlook.office365.com
 (2603:10b6:8:2e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 08:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:17 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:09 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 02/18] amdkfd: mark the first kfd_process as the primary one
Date: Fri, 17 Oct 2025 16:42:06 +0800
Message-ID: <20251017084222.54721-3-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|CY1PR12MB9674:EE_
X-MS-Office365-Filtering-Correlation-Id: 6731af3d-0c90-4376-d298-08de0d5937d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NNFLBaqfz8WGVQi6YT0ejAwVR9nhSofsDcDBbWQ/uC3rG6NA+Kc5cbCPeZa/?=
 =?us-ascii?Q?CCVEoZkQqUe09PCT8+b+FrAs5Dsa+9/n/VsFrfmk650pFcxTbi/Xo1t4h2yS?=
 =?us-ascii?Q?MMGUCdMv9gmXRzOD/FNttMclaEF9iEfwhraMgNUMXz/LGBHe1UIULe0qEqcU?=
 =?us-ascii?Q?fTGhGHR3ewHkoLbhme8/dNHbN7BauA/gOYOvht2P9G+pIaNjbAgQB7v2Jtak?=
 =?us-ascii?Q?i9jNS6uByq9yYY4cI0JUYAVlD0f+zKOtLl10QDyTfGSCt2BCkRaua3Zt3Z/T?=
 =?us-ascii?Q?41HEk+UtTOaQSegZlRS4tWVpfzE7z52llqhD1KmBbQr2mahsb4JSxd7eop2w?=
 =?us-ascii?Q?OG64sICsdkNL5IZqZxUhOCpBfOQvp1gAA7F7hWFp5e/CXMih0H05aOMmW4Nh?=
 =?us-ascii?Q?Sz57nJiRE/5Mv9WuSToY+J16JBn8ayvdUUkc/G0VCGGw8wL5Nu2TyvXpqwwq?=
 =?us-ascii?Q?vql3A6K1i//Ml8SIH0B5Ys8IW3yxXULpzDZ+XdOqzdtVypS1dz2IrP9rOd2o?=
 =?us-ascii?Q?KZr9mHpZVNCEgWWlMmlsNwvbtldLsUampAfdOllUOUK11bQhrsTfovCBEXYF?=
 =?us-ascii?Q?OVK44imoG132AUzNxQZlv16NBW4qfVv9yjvwk2dnj/DtLjhCx4amU04VJbqx?=
 =?us-ascii?Q?JyGr0kZpM4biZG568pHHEewtZCBs6CS9vgXp+EwspST3ckFfFXxH3bVEr8s2?=
 =?us-ascii?Q?+t7pBJY0macYjmGWnoTCD2mdOBSUzi09YzHUnG46+wHq56YlYGMivUWFUchM?=
 =?us-ascii?Q?8N9wdVL7nlUHhyyRbA9zBwmJ6eyOFp7m03uyarlCO9N6JF2lSeVhPShGWmXb?=
 =?us-ascii?Q?vBjMwIs/xJUovp+kK+e4SZZaTW369pBZz1zNvJ2tv3DymBymoOFpzOTtWXV5?=
 =?us-ascii?Q?oTrrWW60gHs4GHSRnh042S0/D9u9LfehsfiRxpQxXf+RDYb1IDAYfMUWdPk5?=
 =?us-ascii?Q?Mi5TJWOy6LaEtC3yd+yv0iOI+pB5yoznYWpeqst2P6OM6HEgwue0M96kRuJZ?=
 =?us-ascii?Q?Bm4swsNj+2FkbCk28K4NA+sWYhhbJWS11qJfITYpRIdamrF+JpNaKeOM/chY?=
 =?us-ascii?Q?JVvxTK9omlbhjlYTn+8p+HlwqiU+MwmUj9HReC4H0oLkcb1grJ3icHHuk4Q4?=
 =?us-ascii?Q?gWewnh4d8ERw4HrxMQ9TFEvU2OtsX23YKRkFZMJFnPVr0zUUnCfN29BDXUXf?=
 =?us-ascii?Q?O+Mqv1FIvQdW439gT5er/D9eumr9hAd996qde2A607CvTZTwEM0y7W5+3cx/?=
 =?us-ascii?Q?az8EDcNHowk2WVw57YGxpOy0J7H3EJgqTttpixYLpPn9eN3mX8GbPDgM8uYQ?=
 =?us-ascii?Q?EXXqZGXVucfg5Ihjc0gD+q3/eRpvDLd+yxrQpYt5DthToB689J3RSLFLspXY?=
 =?us-ascii?Q?gC83HoWl5TzKt74+waW1lSHUHr902ptAGSIO7dicxluSzMN7pnLhH1cvwN7N?=
 =?us-ascii?Q?yxuSUxNhqUdF3pNOnRuXUNDLd/j0uvjYBqfHkrQ/M9c4qc/2Nv5AdF1tbSdh?=
 =?us-ascii?Q?3+9oBIQCpQtSMOlN3tS4VqAGfeWdzJzw2yEqTK/rY09iCkZwIVNucSuyNEQa?=
 =?us-ascii?Q?VU38eQbMstJNV3UcjAk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:17.2522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6731af3d-0c90-4376-d298-08de0d5937d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9674
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

