Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD4FCCD1BC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C6110E6D4;
	Wed, 22 Oct 2025 07:31:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m543YhWu";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2732B10E6D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSUFrGHRCpNtxEI7i01zqeZsr4U2XwMPjz5n2p5kNdseEhCVMge4X7OQLBG6qUZ/EpWwMaCBNjSdMMKAu/KVdQZA+n6jlTbFpSL6GblVvjMF4gq+0cPGPqv4IDvrvl6DR3/kWWReYLI3Nu2Rb7DVIXlWmWT4rHU67DUTe1WnXPN4cjuSw7qSGZDRz+fU8eb689B831aixp/FPvjU0AHsT4hZqJAb2Sl4DD3Yov2qTc1WxQu8Cg32Rx1MNlrrcFqHTsF8R9CFXPFwiklt06DgmR42S7uH3U6egJLx+6m+NAV+qhZaNtlpsf11P5dxB7/duP8DgvMNaJPNV9uCc7B9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EDAUfI+hDsxekFAhO+a/s8+owTwTa0hzXxNylV9COk=;
 b=ol00fFGSk8F+DYOqyR8PPb6lgef2Eg4e2uvOOhfFNQ4rfMga+zJmGVGQBl9Dkajys4skQPuKqV7UWSbuYiRTd5CrKpkFX1qL+cshLAXcoe1ryhK+x1ny03pompRjthWvqDYMCMUufRFL2nxLgbCfpxri/6/RGILOf6fbx7f1j3fYp4Nqv+gWuKCvtGUfaUk7UtPWbzBtlr4Rgv0k1hEjJ1KJ3H6f9eRHP/TYNndHG1gQeycEClhf+ZqehAmyaYQS99xs7H5ueD9z2ETaW2iZVzzxzVyg95TCMVs1sT7rHgAHGgeuYDAY/UqIUsCM+l086ovDjS4FRPNClRHQhZiUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EDAUfI+hDsxekFAhO+a/s8+owTwTa0hzXxNylV9COk=;
 b=m543YhWuHQPv+o5KyLr78XMGB7pk8zhIs1zjgb/Itn2V8dmTV0iGy0AfcZIP999fgaFzsm/iWNxR5VXxPCPDd8M0Pmj42J69ooNH8AMHzzNj5F6eZWbKFuI5zPDIwfRPJ3dVATSzoh4yQ3Rrh7FBbWcZe/WWHVqX1i/v2SkW3xc=
Received: from MW4P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::6) by
 SA3PR12MB7951.namprd12.prod.outlook.com (2603:10b6:806:318::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Wed, 22 Oct 2025 07:31:12 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::1f) by MW4P221CA0001.outlook.office365.com
 (2603:10b6:303:8b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 07:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:11 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:09 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 02/18] amdkfd: mark the first kfd_process as the primary one
Date: Wed, 22 Oct 2025 15:30:27 +0800
Message-ID: <20251022073043.13009-3-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SA3PR12MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a15fb1-b37d-4e23-3042-08de113cf9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MaZwdvEWeYYUCpX7hMnqKmlhicK86kU6G6Wpmsbmb57NAol7A2Q15VCRfePk?=
 =?us-ascii?Q?i/o0OSQmIIHwStGjwHPczKGx27HCShL/LPg9kMvyP1p8rTs5iuY5KpNsDvGo?=
 =?us-ascii?Q?8qHNJmvjI8IH8j7SGgsE6b22dMz/mnhD5IyWBXufZVIfLzI5OVBvrq3crQk7?=
 =?us-ascii?Q?l8e8QYwLb5NWspnTisHrdzgVQRuTmoBSQ1WEzSc8nE+FMzNxIhcX+B/q1l2H?=
 =?us-ascii?Q?tYTeW6WGFaQnikks9JdWuzvBkCdnkGxOiLfsQ7HdXuJ5Ev1D4wKJM20cc9d/?=
 =?us-ascii?Q?eaXnhf7zR5ftswE4BCI2BwskkoyHPUPZ33iAFgvi6QrGlVe0HJqiyEz9YhAF?=
 =?us-ascii?Q?NFNF/RJDcDbNiwOKcTPKTzdmAxV26RB0fs/Bq7e3ujBy2d4ve5mHHgT6y5Pb?=
 =?us-ascii?Q?yZFQzZ6JNO4Fs/r1AH6aM6ZCX0UnWuBECkdqQjdjIFDPkg8VgbUWNYXxOd3E?=
 =?us-ascii?Q?MpLJKI/n7DWjc7XGqYyYvCRdo2fN/aDaEnkqcPbctF/WTGt9U+kxRuDPJNOe?=
 =?us-ascii?Q?Dzb7Xb4nBhTzzdeFIs49Z7uAzKvDvulK8b1ZtCl0Jdzh0bDJkLf0pamze/iQ?=
 =?us-ascii?Q?1ynMOMO7sZjwFZPd8D5sKXuOvTzaG3ewkkrreM42xZ5PaTqVHuACn8YgTPqT?=
 =?us-ascii?Q?qAm6ifjqwcxbxLH8nPUOlvR3sHKH8r2DJCEWqmrFOhxtVXQM5pQzP1gWDb1z?=
 =?us-ascii?Q?+bbrT1EGvzOSvCdKv8pmWYyatVPN0K/CrAek0rlIpQSzzlssSLUfiRF2RriP?=
 =?us-ascii?Q?tK5ln0NdkAKnbKI2KpsrcOXPSwouFhwDfUfh7p8OTpSSfPJvB70O+iWaZFNd?=
 =?us-ascii?Q?DV4lbBbvLoYNAB1CSJ7SYhO15/Bw6b9HZeI4K/rzyQyRDYshZYI4Zua0wTQp?=
 =?us-ascii?Q?QfG+v7p7vOuLk1jvo5F3l6keavgxmlaZkhKNcLb8mV8DRC+yDYIIWahLzevm?=
 =?us-ascii?Q?ODnjzddlCXSqCOgmcs9i0QbW+/lJwAiGMJ20dSe2BzM85NVrsgxwT24zNShu?=
 =?us-ascii?Q?nMQCSqWgvUc/C+lDyZIIOcXKf7p1Ax8o0szjIdzpNvghPhpqq94I9Kvy1EWO?=
 =?us-ascii?Q?364EAl+oZjTqyILFr11wxL5cx0RYfd+nLGYkTSke9++T8BKm5I4jrX1nymWj?=
 =?us-ascii?Q?I3mrGxH89006b9PRUB/GlqkvmyaVMYnS8Os4KIP1t6DERoDdBMrFelg+Xb3G?=
 =?us-ascii?Q?beeBIkx8n627xYS3i1VnYpZsQkPctohlKzLZvPZtImAAf8TCn8XdLDzfEOUO?=
 =?us-ascii?Q?RcoaP2GVzEUJSRKa2063HUHz+OgmghWfzTBgR7fl7m8p76zveLKsAy2U+xfz?=
 =?us-ascii?Q?yYvZGWWWF7IL6kBYuB2DPhefUSqls0MRIzCJlXEuLAYnv7ER7iSG6O/reaby?=
 =?us-ascii?Q?PiNQ+QC3e3iEHL6tYRpYFRRUbjS8LKWsiSpkIyJ0sTmwIQ0VsKsxmPHMhr9Q?=
 =?us-ascii?Q?xO2eOXpiOT5c0PqYn+ZxoXHfE6/MTBKJ36oiK8f64o49yVBK+3otw3fb3w8b?=
 =?us-ascii?Q?IdBIrmwpowxUCgOi7zpGMKWBRwMOdk+Ab0qTct8dxTs/2rdnQy/GsjZjRDhJ?=
 =?us-ascii?Q?GshD96m/vgmiuvCUgr4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:11.6241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a15fb1-b37d-4e23-3042-08de113cf9aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951
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

