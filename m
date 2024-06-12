Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824A3C27C75
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jun 2024 20:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B831310E8F6;
	Wed, 12 Jun 2024 20:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OR7bMxNv";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3181710E8F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jun 2024 20:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtON9BJ6RzMzZcR1wglKs0HMED8fCyiuOch5WX8m9KcPAwdgsWIRJD2ggrqqRWGne+kjfzOkinbKxfpV+OQE6+e8+FMoLqj5CD5Ypl0XDOIoH9E77R6x/pSx9Kri8GA6VQt5Iiuz+YlFKrtACfVN49Vn/KhFYXX0IDQxHBWiKKf9YFcPXi9wYK1OPJIYCWiNOJrSG+qKAU1AI45AW9OAAj4+eeIUznUYDFAdExquPfn0msX1XLosdgyFkcJOMz9Fjv9S4Xq1wG4tV4o+OHEiDmh2v3tPz658D+NkasrFZwhnh1D7qHvYb76ze3BUzwLWWFZ4l38jW5xmop8yabyr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/1u8Qhz0iYCuEgsCFuF8J9WV0N6VOGHbdqlLcSICRg=;
 b=XXKcm29lJKtdR9Yc5dd5TcMjJkcVV2hbXbJsXKzJlMYmRy82+1ZxXb9Z14biND3PVKNPlWYrYC3VE4zvYyPRRvzWYAYU4ne5MZ9dGajjesu6rWSRQrVllIx3X83JLK2bZqT19D7HFLSNKmemSoKPiXfJRMu/R7RJmwHnOMqPf4mkq/IcR/WyP3/YINiKUEmQ4Dx7JSUd8FqNxR1ZVyCu6WMOk3BkMsh9/FciPHLD4tjzoNEWEED4vbtNbuqdeLuzuLESgr8y1qWHIEwJ/VMOWjz/i0IN2Musonuq4g0tItTH+8sE5+rloA92wB/bpybVI3ZNW5EI2G9mCXUjlFE1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/1u8Qhz0iYCuEgsCFuF8J9WV0N6VOGHbdqlLcSICRg=;
 b=OR7bMxNvGe4JwvIOOEG3wt3+uBYg2wRTKPkeSP2ns090VXwB1tmOnEbPFnhkP08URGM+foolvTzCZ/XWNVzLVwGSO6WpPN4a5K+a3vD8Ac10NRr2TqgpLh/RshtP3iTFPk6eNb61e+rbZmbaMtv3inPs3rpwbRsIWW2pV1wzyl4=
Received: from BN9PR03CA0697.namprd03.prod.outlook.com (2603:10b6:408:ef::12)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 20:10:44 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:ef:cafe::70) by BN9PR03CA0697.outlook.office365.com
 (2603:10b6:408:ef::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Wed, 12 Jun 2024 20:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 20:10:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 15:10:42 -0500
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Jun 2024 15:10:37 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <Philip.Yang@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>, Xiaogang Chen <Xiaogang.Chen@amd.com>
Subject: [PATCH] drm/amdkfd: Update mm interval notifier tree without
 acquiring mm's mmap lock
Date: Wed, 12 Jun 2024 15:11:01 -0500
Message-ID: <20240612201101.225674-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eff6a92-e3c9-432f-3703-08dc8b1bbd9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|376008|1800799018|82310400020|36860700007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+maYOG8YAd5DuQ6DP9P6Cg2IIRYPTTgBoYU7I2EIjjxH4ryJTN5KC8qPFjSf?=
 =?us-ascii?Q?+N/59epc6anqJi2g7k7IaVgDEeyZu89KrOOiKF4HhGfSIHhZGjbu3iSH/OYR?=
 =?us-ascii?Q?3d6PpNyq1cGbfhFRivbAk7zu1BzQR2h83C9a1QxN9Y7JTShl+OhM7mkaFWjV?=
 =?us-ascii?Q?zlmMJz4HPevmLJdmRlLwOBYwfbrACo4qXql3Qiw/DFNl8v1XDwn0wPJSBjq0?=
 =?us-ascii?Q?g8Ku6rm7v9ZpAToeqW6G6z+siuBTTZovowdhPDfD5Il5WJkoDAFMlZXrhg5b?=
 =?us-ascii?Q?k101wc3nNdAKO5z6PbUatxi6+yZeKy02bJHZvV8pjYotKzLrPhqgX+ER6WxT?=
 =?us-ascii?Q?2pq2lvUbmyJHJ6K46ksMkWzQi0W6bxV6dBWzpBJVqxbgNsiSQBamtmHfNy4U?=
 =?us-ascii?Q?u90J0fulFJnLWHnL68NvaJYDZZAIbXjLjGZh8kOVFF1xSu9yPFeDTdf/nUzO?=
 =?us-ascii?Q?yigUIXXYDzN5T2k2cqPGKfAeQEgbvXXkyyLpERS3N6TT+LiHZGnm5zATWgMy?=
 =?us-ascii?Q?9qPFgZHhUYiKs4ZSCYMBNfSZ7GdwMnYfKjjnGYyZg0/D8WyI2W3OOVITCMvJ?=
 =?us-ascii?Q?Qtro4NZ90UixLCFpEZw+0UPdFoLcTr5JvTz5Yx/QRPIOkGEDcpE+m7Cp86UP?=
 =?us-ascii?Q?M5vM3qVin66e1/cVH1tnGv4uB1L2ZutwZDN04arIkoUamXbUzyzO6MRKPW9D?=
 =?us-ascii?Q?UoPkUEZ3yQ625h0PVk2OPGoCYCP+DIGSXGs852/53wwJ7XKmFnB98uZYnmkf?=
 =?us-ascii?Q?UCY76npQNsUAQ2POWSAhoQpc9M82NJ15VfJSm1IbdInspIlhLEeSzmcQQT/0?=
 =?us-ascii?Q?+LGgEo4J0lT0VXnrD/VgMcYamWf7HPIr5s5I4H/JnUn3wPRUbNkhp5qrK6cE?=
 =?us-ascii?Q?Q+jmma45AsQQdIwm+m94016O3SKzv4tBTZzIJ3u5eq7FsRbkpq7jypnlDnF+?=
 =?us-ascii?Q?pYRE5Z62SrZ4X9MW3Wm3UpNYA3XZw0gB+NT4IqIYN0VWLQlyPfELO5LUcVsF?=
 =?us-ascii?Q?XbsoIUl5cuksAupDiEfZY9wc5acf6v+u+F75lh4cLmGEXP3je5cPJ7CBH8+U?=
 =?us-ascii?Q?x1zy3YSZfwsk5y3tweA1pc8yoxTzaj/SLJZYQaF/0LnsMUa7B6ysSxvpfgZ8?=
 =?us-ascii?Q?bMdo9WIt+0RnMClOJt7ngLsOhvLVFLJIoFHkvqSRnqpofUQqUmuP86+FRNCD?=
 =?us-ascii?Q?Sbyq+D3F7j6V8j3EkT22zZP5iJE1il513MAcNs4MrHW2X5c8pVlSQdo7DBE4?=
 =?us-ascii?Q?LqnSo44Uxvju+mo3lWRntfrqt77apBAensPknAsFhB1nupT85QE4syauX/R8?=
 =?us-ascii?Q?o+6jbNbV4d68MaW7sFH7cYBU2kyCOLM6GorLdaww9Un0ujXfv5VR0zq8Y7pl?=
 =?us-ascii?Q?fxn8f3Hf5aGcEgjlGurRG/X1Y6Wt34s1Or7aejOLoMfPMDPbzQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 20:10:43.8555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eff6a92-e3c9-432f-3703-08dc8b1bbd9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Current kfd/svm driver acquires mm's mmap write lock before update
mm->notifier_subscriptions->itree. This tree is already protected
by mm->notifier_subscriptions->lock at mmu notifier. Each process mm interval
tree update from different components in kernel go to mmu interval notifier
where they got serialized. This patch removes mmap write lock acquiring at
kfd/svm driver when need updates process mm interval tree. It reduces chance
of dead lock or warning from lockdev and simplifies the driver code.

In addition, the patch adjusts some locks granularity to reduce the lock number
that driver holds at same time which also reduces the chance of dead lock or
warning from lockdev.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 181 +++++++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |   2 +-
 4 files changed, 122 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index fdf171ad4a3c..b52588ded567 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1078,9 +1078,8 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	/* Flush pending deferred work to avoid racing with deferred actions
 	 * from previous memory map changes (e.g. munmap).
 	 */
-	svm_range_list_lock_and_flush_work(&p->svms, current->mm);
+	svm_range_list_flush_work(&p->svms);
 	mutex_lock(&p->svms.lock);
-	mmap_write_unlock(current->mm);
 	if (interval_tree_iter_first(&p->svms.objects,
 				     args->va_addr >> PAGE_SHIFT,
 				     (args->va_addr + args->size - 1) >> PAGE_SHIFT)) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8ee3d07ffbdf..eb46643d96b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -969,10 +969,12 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 	mutex_lock(&p->svms.lock);
 
 	prange = svm_range_from_addr(&p->svms, addr, NULL);
+
+	mutex_unlock(&p->svms.lock);
 	if (!prange) {
 		pr_debug("failed get range svms 0x%p addr 0x%lx\n", &p->svms, addr);
 		r = -EFAULT;
-		goto out_unlock_svms;
+		goto out_unref_process;
 	}
 
 	mutex_lock(&prange->migrate_mutex);
@@ -993,8 +995,6 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 
 out_unlock_prange:
 	mutex_unlock(&prange->migrate_mutex);
-out_unlock_svms:
-	mutex_unlock(&p->svms.lock);
 out_unref_process:
 	pr_debug("CPU fault svms 0x%p address 0x%lx done\n", &p->svms, addr);
 	kfd_unref_process(p);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 407636a68814..46f81c1215d9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -106,12 +106,31 @@ static void svm_range_unlink(struct svm_range *prange)
 }
 
 static void
-svm_range_add_notifier_locked(struct mm_struct *mm, struct svm_range *prange)
+svm_range_add_notifier(struct mm_struct *mm, struct svm_range *prange, bool locked)
 {
 	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx]\n", prange->svms,
 		 prange, prange->start, prange->last);
 
-	mmu_interval_notifier_insert_locked(&prange->notifier, mm,
+	/* mm->notifier_subscriptions should have been setup for this process
+	 * ex: during kfd process creation
+	 */
+	WARN_ON_ONCE(!mm->notifier_subscriptions);
+
+	/* not necessary hold mmap lock to update mm interval notifier tree as
+	 * opeations on mm->notifier_subscriptions->itree are serialized by
+	 * mm->notifier_subscriptions->lock
+	 */
+	if (locked) {
+		/* if mmap write lock has been hold use lock version to udpate
+		 * mm interval notifier tree
+		 */
+		mmu_interval_notifier_insert_locked(&prange->notifier, mm,
+			   prange->start << PAGE_SHIFT,
+			   prange->npages << PAGE_SHIFT,
+			   &svm_range_mn_ops);
+	} else
+		/* use no-mmap-lock version to update mm interval notifier tree */
+		mmu_interval_notifier_insert(&prange->notifier, mm,
 				     prange->start << PAGE_SHIFT,
 				     prange->npages << PAGE_SHIFT,
 				     &svm_range_mn_ops);
@@ -895,6 +914,7 @@ svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
 	*vram_pages = 0;
 	for (i = 0; i < num_elements; i++) {
 		dma_addr_t *temp;
+
 		temp = (dma_addr_t *)dst + i;
 		*temp = *((dma_addr_t *)src + i);
 		if (*temp&SVM_RANGE_VRAM_DOMAIN)
@@ -1500,7 +1520,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
 	uint32_t gpuidx;
 	int r;
 
-	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT: 0, 0);
+	drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT : 0, 0);
 	drm_exec_until_all_locked(&ctx->exec) {
 		for_each_set_bit(gpuidx, ctx->bitmap, MAX_GPU_INSTANCE) {
 			pdd = kfd_process_device_from_gpuidx(ctx->process, gpuidx);
@@ -1751,25 +1771,20 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 }
 
 /**
- * svm_range_list_lock_and_flush_work - flush pending deferred work
+ * svm_range_list_flush_work - flush pending deferred work
  *
  * @svms: the svm range list
  * @mm: the mm structure
- *
- * Context: Returns with mmap write lock held, pending deferred work flushed
- *
  */
 void
-svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
-				   struct mm_struct *mm)
+svm_range_list_flush_work(struct svm_range_list *svms)
 {
 retry_flush_work:
 	flush_work(&svms->deferred_list_work);
-	mmap_write_lock(mm);
 
 	if (list_empty(&svms->deferred_range_list))
 		return;
-	mmap_write_unlock(mm);
+
 	pr_debug("retry flush\n");
 	goto retry_flush_work;
 }
@@ -1804,7 +1819,11 @@ static void svm_range_restore_work(struct work_struct *work)
 	}
 
 	mutex_lock(&process_info->lock);
-	svm_range_list_lock_and_flush_work(svms, mm);
+
+	svm_range_list_flush_work(svms);
+
+	mmap_read_lock(mm);
+
 	mutex_lock(&svms->lock);
 
 	evicted_ranges = atomic_read(&svms->evicted_ranges);
@@ -1854,8 +1873,9 @@ static void svm_range_restore_work(struct work_struct *work)
 	pr_debug("restore svm ranges successfully\n");
 
 out_reschedule:
+
 	mutex_unlock(&svms->lock);
-	mmap_write_unlock(mm);
+	mmap_read_unlock(mm);
 	mutex_unlock(&process_info->lock);
 
 	/* If validation failed, reschedule another attempt */
@@ -2186,8 +2206,8 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 }
 
 static void
-svm_range_update_notifier_and_interval_tree(struct mm_struct *mm,
-					    struct svm_range *prange)
+svm_range_update_notifier_and_interval_tree(struct svm_range_list *svms,
+					struct mm_struct *mm, struct svm_range *prange)
 {
 	unsigned long start;
 	unsigned long last;
@@ -2203,14 +2223,28 @@ svm_range_update_notifier_and_interval_tree(struct mm_struct *mm,
 		  prange->last);
 
 	if (start != 0 && last != 0) {
+
+		mutex_lock(&svms->lock);
+		mutex_lock(&prange->lock);
 		interval_tree_remove(&prange->it_node, &prange->svms->objects);
+		mutex_unlock(&prange->lock);
+		mutex_unlock(&svms->lock);
+
 		svm_range_remove_notifier(prange);
 	}
+
+	mutex_lock(&prange->lock);
 	prange->it_node.start = prange->start;
 	prange->it_node.last = prange->last;
+	mutex_unlock(&prange->lock);
 
+	mutex_lock(&svms->lock);
+	mutex_lock(&prange->lock);
 	interval_tree_insert(&prange->it_node, &prange->svms->objects);
-	svm_range_add_notifier_locked(mm, prange);
+	mutex_unlock(&prange->lock);
+	mutex_unlock(&svms->lock);
+
+	svm_range_add_notifier(mm, prange, true);
 }
 
 static void
@@ -2225,32 +2259,51 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
 	case SVM_OP_UNMAP_RANGE:
 		pr_debug("remove 0x%p prange 0x%p [0x%lx 0x%lx]\n",
 			 svms, prange, prange->start, prange->last);
+
+		mutex_lock(&svms->lock);
+		svm_range_lock(prange);
 		svm_range_unlink(prange);
+		svm_range_unlock(prange);
+		mutex_unlock(&svms->lock);
+
 		svm_range_remove_notifier(prange);
 		svm_range_free(prange, true);
 		break;
 	case SVM_OP_UPDATE_RANGE_NOTIFIER:
 		pr_debug("update notifier 0x%p prange 0x%p [0x%lx 0x%lx]\n",
 			 svms, prange, prange->start, prange->last);
-		svm_range_update_notifier_and_interval_tree(mm, prange);
+		svm_range_update_notifier_and_interval_tree(svms, mm, prange);
 		break;
 	case SVM_OP_UPDATE_RANGE_NOTIFIER_AND_MAP:
 		pr_debug("update and map 0x%p prange 0x%p [0x%lx 0x%lx]\n",
 			 svms, prange, prange->start, prange->last);
-		svm_range_update_notifier_and_interval_tree(mm, prange);
+		svm_range_update_notifier_and_interval_tree(svms, mm, prange);
+
 		/* TODO: implement deferred validation and mapping */
 		break;
 	case SVM_OP_ADD_RANGE:
 		pr_debug("add 0x%p prange 0x%p [0x%lx 0x%lx]\n", svms, prange,
 			 prange->start, prange->last);
+
+		mutex_lock(&svms->lock);
+		mutex_lock(&prange->lock);
 		svm_range_add_to_svms(prange);
-		svm_range_add_notifier_locked(mm, prange);
+		mutex_unlock(&prange->lock);
+		mutex_unlock(&svms->lock);
+
+		svm_range_add_notifier(mm, prange, true);
 		break;
 	case SVM_OP_ADD_RANGE_AND_MAP:
 		pr_debug("add and map 0x%p prange 0x%p [0x%lx 0x%lx]\n", svms,
 			 prange, prange->start, prange->last);
+
+		mutex_lock(&svms->lock);
+		mutex_lock(&prange->lock);
 		svm_range_add_to_svms(prange);
-		svm_range_add_notifier_locked(mm, prange);
+		mutex_unlock(&prange->lock);
+		mutex_unlock(&svms->lock);
+
+		svm_range_add_notifier(mm, prange, true);
 		/* TODO: implement deferred validation and mapping */
 		break;
 	default:
@@ -2316,6 +2369,12 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 
 		mm = prange->work_item.mm;
 retry:
+		/* use mmap write lock to prevent unmap_from_cpu for same process
+		 * happening at same time to prevent race conditions between
+		 * svm_range_deferred_list_work and unmap_from_cpu, ex:
+		 * work_item.op of prange may be changed by unmap_from_cpu
+		 * during svm_range_deferred_list_work
+		 */
 		mmap_write_lock(mm);
 
 		/* Checking for the need to drain retry faults must be inside
@@ -2327,20 +2386,11 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 			goto retry;
 		}
 
-		/* Remove from deferred_list must be inside mmap write lock, for
-		 * two race cases:
-		 * 1. unmap_from_cpu may change work_item.op and add the range
-		 *    to deferred_list again, cause use after free bug.
-		 * 2. svm_range_list_lock_and_flush_work may hold mmap write
-		 *    lock and continue because deferred_list is empty, but
-		 *    deferred_list work is actually waiting for mmap lock.
-		 */
 		spin_lock(&svms->deferred_list_lock);
 		list_del_init(&prange->deferred_list);
 		spin_unlock(&svms->deferred_list_lock);
 
-		mutex_lock(&svms->lock);
-		mutex_lock(&prange->migrate_mutex);
+		svm_range_lock(prange);
 		while (!list_empty(&prange->child_list)) {
 			struct svm_range *pchild;
 
@@ -2349,12 +2399,15 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 			pr_debug("child prange 0x%p op %d\n", pchild,
 				 pchild->work_item.op);
 			list_del_init(&pchild->child_list);
+			svm_range_unlock(prange);
+
 			svm_range_handle_list_op(svms, pchild, mm);
+			svm_range_lock(prange);
 		}
-		mutex_unlock(&prange->migrate_mutex);
+		svm_range_unlock(prange);
 
 		svm_range_handle_list_op(svms, prange, mm);
-		mutex_unlock(&svms->lock);
+
 		mmap_write_unlock(mm);
 
 		/* Pairs with mmget in svm_range_add_list_work. If dropping the
@@ -2814,7 +2867,7 @@ svm_range *svm_range_create_unregistered_range(struct kfd_node *node,
 		prange->preferred_loc = KFD_IOCTL_SVM_LOCATION_SYSMEM;
 
 	svm_range_add_to_svms(prange);
-	svm_range_add_notifier_locked(mm, prange);
+	svm_range_add_notifier(mm, prange, false);
 
 	return prange;
 }
@@ -2911,7 +2964,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	struct kfd_node *node;
 	int32_t best_loc;
 	int32_t gpuidx = MAX_GPU_INSTANCE;
-	bool write_locked = false;
 	struct vm_area_struct *vma;
 	bool migration = false;
 	int r = 0;
@@ -2959,35 +3011,26 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		r = -EFAULT;
 		goto out;
 	}
-	mmap_read_lock(mm);
-retry_write_locked:
+
 	mutex_lock(&svms->lock);
 	prange = svm_range_from_addr(svms, addr, NULL);
+	mutex_unlock(&svms->lock);
 	if (!prange) {
 		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
 			 svms, addr);
-		if (!write_locked) {
-			/* Need the write lock to create new range with MMU notifier.
-			 * Also flush pending deferred work to make sure the interval
-			 * tree is up to date before we add a new range
-			 */
-			mutex_unlock(&svms->lock);
-			mmap_read_unlock(mm);
-			mmap_write_lock(mm);
-			write_locked = true;
-			goto retry_write_locked;
-		}
+		/* not need to hold mmap write lock before create new range in
+		 * mm interval notifier tree, mm has its own lock to protect it
+		 */
 		prange = svm_range_create_unregistered_range(node, p, mm, addr);
 		if (!prange) {
 			pr_debug("failed to create unregistered range svms 0x%p address [0x%llx]\n",
 				 svms, addr);
-			mmap_write_downgrade(mm);
 			r = -EFAULT;
 			goto out_unlock_svms;
 		}
 	}
-	if (write_locked)
-		mmap_write_downgrade(mm);
+
+	mmap_read_lock(mm);
 
 	mutex_lock(&prange->migrate_mutex);
 
@@ -3082,10 +3125,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 out_unlock_range:
 	mutex_unlock(&prange->migrate_mutex);
-out_unlock_svms:
-	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
-
+out_unlock_svms:
 	svm_range_count_fault(node, p, gpuidx);
 
 	mmput(mm);
@@ -3192,6 +3233,7 @@ int svm_range_list_init(struct kfd_process *p)
 {
 	struct svm_range_list *svms = &p->svms;
 	int i;
+	int ret;
 
 	svms->objects = RB_ROOT_CACHED;
 	mutex_init(&svms->lock);
@@ -3208,6 +3250,14 @@ int svm_range_list_init(struct kfd_process *p)
 		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
 			bitmap_set(svms->bitmap_supported, i, 1);
 
+	 /* signals the notifier is being registered for itree mode
+	  * it does not register new mmu_notifier or increae mm->mm_count,
+	  * so not need call mmu_notifier_unregister at svm_range_list_fini
+	  */
+	ret = mmu_notifier_register(NULL, p->mm);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -3553,29 +3603,27 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 	mutex_lock(&process_info->lock);
 
-	svm_range_list_lock_and_flush_work(svms, mm);
+	svm_range_list_flush_work(svms);
 
 	r = svm_range_is_valid(p, start, size);
 	if (r) {
 		pr_debug("invalid range r=%d\n", r);
-		mmap_write_unlock(mm);
 		goto out;
 	}
 
-	mutex_lock(&svms->lock);
-
 	/* Add new range and split existing ranges as needed */
 	r = svm_range_add(p, start, size, nattr, attrs, &update_list,
 			  &insert_list, &remove_list, &remap_list);
-	if (r) {
-		mutex_unlock(&svms->lock);
-		mmap_write_unlock(mm);
+	if (r)
 		goto out;
-	}
+
 	/* Apply changes as a transaction */
 	list_for_each_entry_safe(prange, next, &insert_list, list) {
+		mutex_lock(&svms->lock);
 		svm_range_add_to_svms(prange);
-		svm_range_add_notifier_locked(mm, prange);
+		mutex_unlock(&svms->lock);
+
+		svm_range_add_notifier(mm, prange, false);
 	}
 	list_for_each_entry(prange, &update_list, update_list) {
 		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
@@ -3585,12 +3633,17 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
 			 prange->svms, prange, prange->start,
 			 prange->last);
+
+		mutex_lock(&svms->lock);
 		svm_range_unlink(prange);
+		mutex_unlock(&svms->lock);
+
 		svm_range_remove_notifier(prange);
 		svm_range_free(prange, false);
 	}
 
-	mmap_write_downgrade(mm);
+	mmap_read_lock(mm);
+
 	/* Trigger migrations and revalidate and map to GPUs as needed. If
 	 * this fails we may be left with partially completed actions. There
 	 * is no clean way of rolling back to the previous state in such a
@@ -3646,8 +3699,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 	dynamic_svm_range_dump(svms);
 
-	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
+
 out:
 	mutex_unlock(&process_info->lock);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 70c1776611c4..f7cee69ff191 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -195,7 +195,7 @@ int kfd_criu_restore_svm(struct kfd_process *p,
 int kfd_criu_resume_svm(struct kfd_process *p);
 struct kfd_process_device *
 svm_range_get_pdd_by_node(struct svm_range *prange, struct kfd_node *node);
-void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);
+void svm_range_list_flush_work(struct svm_range_list *svms);
 
 /* SVM API and HMM page migration work together, device memory type
  * is initialized to not 0 when page migration register device memory.
-- 
2.25.1

