Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2C8C87FD1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213E210E435;
	Mon,  4 Aug 2025 11:06:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dG7P4Brp";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37D5010E435
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0fYUZJ1ZiXfVu80DvpiQQgtRLY9LFt37EfNeDS7onQ7njM0iaHLQe0oeVJXJd3l0kpkV+fmQE118wI9ZsDV1p4fdgDvf75f1ADU+ToHNkmzgfYKORxDGRz2ARgThkzeuNROV5jGJeOvqYgi4fRELiLvTYUCiVfxZrARHgzIn8m1kLSW6yqKwxsxkVK+jUoTSnpdllfQwUxoMPYTiNTU0bM5B4zXljU+3f0PunCUSW3g4bV3aRFKah2CDPvCUMVV0EXt8UIbmEQL+4sWsk1Jwo9qQgCp6w9dbT2JWcuHEwjflsLyQAHumEIMQj5XdAGUug+PpMlBru2S99ueFOOTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UD0zg3OPkPUQ0jdIHf2GvW8Zqo0d27GdxqhYKzx6zec=;
 b=iml8e0hjs2KxWNDHrv86prqC2+m0QARQnkx3Cai11MlpLlqh5EkgfWTCx7uJF49srLYn+bwb4FQ7vqzyEEthd9NkizIS6Dh+K0GIBo3i3ScurrGe1+DCtqcPggvAWzbTB65E7KEzn+jtjJkyNB5MAsy9bce+4uBnk8Op5mAdElKcX3jFRaR+q7k0O9uOlEAqWO5JNlehALxLCqS1RPBSmg/4LreK6uNSxaLAlhfFwIGwdWyhZM7Fgh/Y/FQezWyh80rn+FL1m2oFhfWvHSO8SHsuW8dYu53IZGTMG75XziazYoynhAnK5cJ5NRUBOwb7Kt1KPQm9rZwB0cw8r1AyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UD0zg3OPkPUQ0jdIHf2GvW8Zqo0d27GdxqhYKzx6zec=;
 b=dG7P4Brp7GDz/hAPxifHkYoz7AIvDdaZJGNAvXb2hffZow0RYGrOnd1L0BXmrG8o8UQjt8t7A/6V0qkxJTXKI1tUSyVWQQrCmovjFtiPE8/DfpqmdsFI3BI3WDjZzeEn/nMeTSp6j4M/SEOoSdHKru0ydJDdHtlU7IzVHAB1mBY=
Received: from MW4PR03CA0348.namprd03.prod.outlook.com (2603:10b6:303:dc::23)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 11:06:31 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::9d) by MW4PR03CA0348.outlook.office365.com
 (2603:10b6:303:dc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 11:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:31 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Aug 2025 06:06:29 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V3 02/13] amdkfd: mark the first kfd_process as the primary one
Date: Mon, 4 Aug 2025 19:05:39 +0800
Message-ID: <20250804110550.261311-3-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250804110550.261311-1-lingshan.zhu@amd.com>
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS7PR12MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 01be2ff4-187e-4039-c489-08ddd346f7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nAeE+Hoy5irI2FbiK+F+BbSGzs1v0JJWI2bf+pCaGurQWo0MGXt+eLGYQtYh?=
 =?us-ascii?Q?0VDiMNNcx5HfFw7h9BkzsIXQMHKBdb0WX+WAMBMSWT4TMzrwx4Rby9cGnVl6?=
 =?us-ascii?Q?G7Xl7tSpjxRYZzXazQm/WSCiqVCjUxpt6Hhig26p45qBW5WRZ4SQSDENhaJc?=
 =?us-ascii?Q?peXohMuWZq49iGyJvsIvo9r0E/jhM2LzrXnWloyQP0BgeW03te03xSZ4O4SN?=
 =?us-ascii?Q?BczCiwWo23iRpb6npKol+awmTGq7bjNdWJr7AT076N/3jXG227oTejZIZtv0?=
 =?us-ascii?Q?psXzYx0hz/I2AscIVIvtP99kTVQf+P4kvLTZo2gEsoUC4eDsXN/LBrd/t5i3?=
 =?us-ascii?Q?wtV0YlJ0HL+vZo30zUgcPyRRQOc5q+zyUqufeWR7uvq9vV0qN+cYgsPnqwqq?=
 =?us-ascii?Q?dTAMZI9DfkBCvVVexcDdBOR+wN+7AjD+vjSleXb48LaMHrdRaJh+a36l9qtE?=
 =?us-ascii?Q?ydEkH35ElxvGZRfF/eh9GAr8NgGbb4EnPnMRCgvmwNRraBJ7OuEg288Rezot?=
 =?us-ascii?Q?05vMnX8UaPU4FAXnhdAuJPsP44NVBpy+0qeN2mrYlEkeMBRIHC0kjn5vtAPV?=
 =?us-ascii?Q?pQyXERYY+8Pj32NKUb7LpbaVTXquvyI+51/kSeP77o1WE5VXOtECn/ZxR5Cj?=
 =?us-ascii?Q?GjpWZ5CKHKWZ3zwPztwmWzpFzZ/N5w3IZ7OclZ/TZo2oW5LKLC1E6ATgvtzw?=
 =?us-ascii?Q?bRHmf6YbqNwwFtdBVCaMPl6mtb9s/gYjVlLmWe5iGSNFmukma++T9npQzUq6?=
 =?us-ascii?Q?hRvBsNSgiyIXS1Ciu1acdjob53WMLf9qIHT8EGLsDwkCLukyVMLE5XoUC55G?=
 =?us-ascii?Q?7Z1eQLFtPic2xRswCWrd8sS3Co3ng0yQkfEiS7rDqyNIotCNe0C0dbT6piRE?=
 =?us-ascii?Q?b1+lOZ1v+KN46ZORvWetal9DWythNyKuO5SEKmKXnK+y7xTLDHkT23Y4j3y7?=
 =?us-ascii?Q?D+UfQngOTod1Ij+1qhEjfbc/8S8dijrbEJqxUpNdzNHdT8jsmtI9r19oERjt?=
 =?us-ascii?Q?EL/VXo0n/t68erK5fw60DRWp9WMlI2HPCurOfTBsTXUP+g6yEJocURCT8KGU?=
 =?us-ascii?Q?yd5oY4fHRFek1sYQ0o1JaHQoH+uTBhWABEOaT6h4Yey5iGDeDZ2wS1vIe0Cu?=
 =?us-ascii?Q?cRkkjJTpkb3SxpTm/RplvjGlGCb+3lA+lLMSEZdaR3brD+NMawrk31O4xdqY?=
 =?us-ascii?Q?9/yh3C1YpDKmqk8agHr1naONXQ3Ny+1AWTHkt6vpRrwSXnkNgipq62PmQ57Z?=
 =?us-ascii?Q?IATFlucYr9M2tlEQFHxlG0IiwaOCNuul3NMX1kWCDbWo4rA50ZAhVchnc+Qm?=
 =?us-ascii?Q?TcWM7LOumB0YZIYCRBXH9VqYDbqMJ3GhfSTZz+b9yBYByQF+elK+RZSqg5AK?=
 =?us-ascii?Q?yg/HPHIknTui8C/PeKGjJqPW+X9pNAxv8Bpj4ugyAZH0U0Bl4tnkvLzuubcb?=
 =?us-ascii?Q?Ye4b6d4KuYOn6uHt6Pu2wkzLuOHbLnmGSdenCjg596egdDkkPIK+zdcwbyz3?=
 =?us-ascii?Q?iTRROoI6bij5V7HuUrjalns/1v+LhotbxMB/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:31.5066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01be2ff4-187e-4039-c489-08ddd346f7e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273
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
2.47.1

