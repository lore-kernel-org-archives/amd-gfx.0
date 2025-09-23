Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7B4CAC5A7
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD9B310E0E4;
	Tue, 23 Sep 2025 07:26:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="08N3mCsG";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012011.outbound.protection.outlook.com
 [40.107.200.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC8A210E0E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGacb1ZwfbGIgvw2+yvBQD4v2p0p7mNYOrhx4G/+VIcRk4OvnhS90haK+hUw5uyc2h+tJaDfPIOTDQHoyWZapVzLmmpXU/AdhEr9ixP13/lrzwGteqk3jZYYCpzL4LmoY0KQ2PaGtf//7lsRaTh6k0pTc83ocNgvRwbTokGoR5rKUXFjY86UUR5REN3ypSCQ/3sDjsN7ulPE/LzJkGF3Zi14sS7Z+mXIn6ssIc6kUrMlAMFx2EtSMn+cEdSUhEYths9KexRecnexZchkWVpovfwqF458iP3fiZdqyEs3RbWv7MFEKLNAYJSuu/k6N9Eo/LYUtXulQr69IYQWOWPplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/YhNJGRHvk9OryIe4cyvCHcf8hRkGFad0xQjZtnodU=;
 b=Q6l01KaI+WfgF2x/RVvZFQ4+/TS+lbPYqdjHQTIKqHLyC5gR9AAxVgH4whb7yTS3VyBQ7/I9LXFCSYzY5/V597CxsC9+C1ldm144LNg8mBucRDzQJu4F5Wz4DUICkmoTqf2j5v7b3m6LgvfXOkpKdY5e8S0qAbBqorWTGNbdaLfwlVp6zeZce357fxCIKEphBTS0Ua+qkvBzU+ATRJOiDEmzzlvIPpEQhI7MFIWwLtrWhaP2HjUY/FwDsvUJNyRur4kvUbak3j/hV4G1GQOfJuh9beqEq6s8rSVCS6tpAb66e/3lFo3EZ1PJyrVWdCEcZblRA0zlBnezbSQUPjPmiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/YhNJGRHvk9OryIe4cyvCHcf8hRkGFad0xQjZtnodU=;
 b=08N3mCsGxcNAb5wbsw4Fw5o+krPthhAFmv7F+TDAttapXeBZZ8+vc7BIc3lid4H747wA4NxWoEkR8mnLhq9hUcrEs8iP1fzv/VJmcgvY8SCGbYAnu5Yabpx1NMYToNRUt4Q1ZQRf9hziN6Tf7V5BeSaWY/36/5bnQmTWZ3HF35Q=
Received: from SJ0PR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:33f::15)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 07:26:39 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::ad) by SJ0PR05CA0040.outlook.office365.com
 (2603:10b6:a03:33f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 07:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:38 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:32 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 02/18] amdkfd: mark the first kfd_process as the primary one
Date: Tue, 23 Sep 2025 15:25:52 +0800
Message-ID: <20250923072608.252345-3-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: edc73d53-1211-4087-61dd-08ddfa72892a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GnigqCtvIo4zdmYzAR5a1m2Qk2eqzTht3O2xfJKsiViSRD/HQs8OwAdw7rVl?=
 =?us-ascii?Q?GMdsobDjqQitZPYTw56/T/ZN0bTWWgaKAh+o4d2h3huIQ3t+ikgLJ37X1Jzb?=
 =?us-ascii?Q?pZ9USagsd5hxanlxc29ITGDkgkZBJZGwbVJIxKxJk412EDlgI/GKsImqqBSl?=
 =?us-ascii?Q?29yN669WT52vaDjH+KE8gOcFAFPaaO5lwxllf4hGX7uaSgvd9RaS78shiJW8?=
 =?us-ascii?Q?3rZ64Raiy80eOsBAogoZDFSvJBU2epgJbNX+ryhp1MRRRp0iEfL+Y2FHwUGW?=
 =?us-ascii?Q?Elim27+8VyQ5Lum0G4nczmDM0JwjmVcVCfPH/eEabAKOzbbZttfcHahh76FJ?=
 =?us-ascii?Q?4/o0MT0bGDJaLmtirUEtyO8HVZdakEnsW7e2vlWpg9B7+aJSZB+U2KxB9prc?=
 =?us-ascii?Q?NtT7EO5dGzVDY4qot17meJd3iImOsP7MmvOVbL5atacFmjsOHEemlzBcoXe2?=
 =?us-ascii?Q?/Ods/LGe/wE5wmKSZEl5JAaoGV9kw2VbRH64q7qRLMh2yHEDR7LE4zFO/HJz?=
 =?us-ascii?Q?xgZRO0NGDNOx9GRX+8rYwK/fVMWiW/6v5rlpyPi9SXPyLeSwPbhHoRf2wd+4?=
 =?us-ascii?Q?kjE5YwaAwfS+oiklgf4+96nLiDnYQkJ57g1XfUlz6Z9jM8BIntvZOve+YYnK?=
 =?us-ascii?Q?QTUxRrWslYQi8nuGD5i6IlzORqw6gbF2Mj1cn7ddMD6dYg5jzqW5MApz7qko?=
 =?us-ascii?Q?B5md25gx4OkX6yIuCHJ5cQ3qQKSQBKlvwrzjuFaeQyHFCArW09lmMWiRxYls?=
 =?us-ascii?Q?9cbCRUly96zqxeyPBR7e+qtYNZ66btJrzHG2G/VcNIhZseBcQU0L9uUeXYhD?=
 =?us-ascii?Q?GCr5qz/dEDebynbGIoH16MO7xmFj46A5E2ZX0kXMlrlRAUrDzazeDYm7C7Yq?=
 =?us-ascii?Q?GcER8eM1MsE43Rus4moghSnVpYmkk8SYZ3UJWoDy3tL0j6NKILus9wJn+kEq?=
 =?us-ascii?Q?NCv2cezy8x++h+mfcT5qUax53j+iZNvNsouSz9knYXCRSJ/hXGkjbPh8QwmD?=
 =?us-ascii?Q?gcTyNkB+hi9eU14qlTKooQiEbvZm3oDK9Q40/EC1JG09vUgsPHBpSqYtBBM5?=
 =?us-ascii?Q?gmS9FhEm5P/ap6Vkxe+ZFG28S5CN9kaAp1MjZI5qdMJSUc/JCVlRPQDnHg1D?=
 =?us-ascii?Q?1EOYIpfpGML+OLrYyDaBI1gSS491cghgi9f86geQ8C9GMbkiA3iP58Ng+aE9?=
 =?us-ascii?Q?Zil+SzMs9cewTLLiTROBGMnev0osh3vjrsOX0mfcm0R9MOOAfF2uTLhKJuvy?=
 =?us-ascii?Q?0BgUOXDq0Va1VsImUcBxwA0R9GY0kSrkgfyOzPiBA8ve95zJLhEwlL/Mc3uB?=
 =?us-ascii?Q?AtzMYGh65a6V+4fXA18S9ID2+lqee0kU+Ji73X+pzpbszSGULjG5WaFh8IDt?=
 =?us-ascii?Q?wHZPHS7IDbaV81sIF44G3WF59iRObkRUmDB4NRVdIZ7bwjDlhuasThIgCixT?=
 =?us-ascii?Q?TNJl+tL3AP1exi/mCs39RG4qgRgSlcSQXwqwqi4rSGD4PPZ2CWqdGenne8iK?=
 =?us-ascii?Q?KTfodNWT43XlVhWY3sZZ6QeYUh3Ix3JAKZiJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:38.9607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc73d53-1211-4087-61dd-08ddfa72892a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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
index 8a33e6ee6369..2b95f37c1af8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1009,6 +1009,9 @@ struct kfd_process {
 
 	/* if gpu page fault sent to KFD */
 	bool gpu_page_fault;
+
+	/* indicating whether this is a primary kfd_process */
+	bool primary;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 5be28c6c4f6a..762e306d85db 100644
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
2.51.0

