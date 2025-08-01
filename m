Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433FDC87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 08:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D09F410E808;
	Fri,  1 Aug 2025 08:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iqLM0Hrk";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8CC210E805
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 08:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWLrnVNmv/1qk+te8PnEatVI9UfFva6ZFLdPaax0BW8Fgz3TMjNSRQ5Yr5NufXrxwaRsgF++Hr8poqDbRPkv8HQk5HRJgR41NJDH2z8kLNWRsfWCJahjwq1Pg6LJbj9cjuq8zOmROwVwwnHawcYfg60s9g2e0g5KeqKZIc6G19FaPaYWajprMfMoPzvIZe/a4FjVzu5CqSznlVno4MU3wmFmLIUJFJiEG1Ak+q7TLddi6dtqN3wF/b/w0viut5wpnXdZ4K/K7LU2FQKXXM9ay7u8RR6q7w94Dcb4iJVpPNYvrXvnM/B+WWw+jWyJerNDD2x1WQ+liaQ4nGrp64VgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTAObtD+Y239qhMW2HAjMtc0ArFRW9BQrOwiHv0DZik=;
 b=k1lIFPDV3OWpYqObVF1/F+StBM9gB0tVKygFwwEYMrKi9e/TXJPCceGWErP0k2ahFRbQHEXmoTuUrMuJuoSen17mOkIOPDuRquylswG8sp1gLUgtEf8sHtpXoy8nuOrLkHnZPX8aLDhFgw3Eryf3nR825QcO7/lEBan/aTpWE2kIPS8+T6UMTKOoJ1SD96IZDUfF0yMV8pzqmUZzP4vhGYpd3U0U+L0Wi3Lm0CYBD8xkz20dD9XhBRYHcZGVl1gkO+7a7ZsWNPEOrviEhv3ICsqIaCpc7y3q2nLV3OddEE1DlTcoZL8dcCGafz750r0g5jkpz7u7uQpX/kHb1OxLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTAObtD+Y239qhMW2HAjMtc0ArFRW9BQrOwiHv0DZik=;
 b=iqLM0HrkMjD1US3cQo5yVqlnEpn0CmRyta4Sp3FG8KSp9w9tmMpCWJ78FwA5JLP/2ukzrYyljZQ74RihbQagDXVbFKkD0C4UZOV2UXoguYmHX37EiExoZy9Vrj1DxKDAzAW72XQCT4vVluc4N5BaIGgMd5K6ekhU75uQuznmVWc=
Received: from BY3PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:217::15)
 by BN7PPFA42F4F89B.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6dd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 08:56:35 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::11) by BY3PR04CA0010.outlook.office365.com
 (2603:10b6:a03:217::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 08:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 08:56:35 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Aug 2025 03:56:33 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V2 09/10] amdkfd: decommission kfd_get_process and remove DIQ
 support
Date: Fri, 1 Aug 2025 16:55:55 +0800
Message-ID: <20250801085556.8504-10-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|BN7PPFA42F4F89B:EE_
X-MS-Office365-Filtering-Correlation-Id: f04237ee-0529-4d6c-14cb-08ddd0d951e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S9ACR34tMKG+4wK7zSJ7/95QbyJ/KldcF4g8jSYZAcEiqWVWY70ZuftpJF++?=
 =?us-ascii?Q?FcK+StZuHy1gFp85h7Xqbc8RbMUiwbYGm9hTgb+FTKD+bWaF7Y1hBfcxIIVT?=
 =?us-ascii?Q?Kc46Au0JakU6cA7pKyLTnz85Uqydoi6nSllPoOl2y6y7Raf6wzAA3UbLYg0k?=
 =?us-ascii?Q?VA+EkdMMbnRVDE/1sjgOPiYJ1IMjmckPzN7Q5prb/G7ig1TzYPdsUG83J3V5?=
 =?us-ascii?Q?dXInAIV/anxw+QT3Eq9Gdmzlcxo334nLkxBJfpCNakZ9osa6/S9P+tj9T1YU?=
 =?us-ascii?Q?dlls/dTBP5xU1hmav4pxJN7HRYX8KEmlJ6l5V/lJp/wSrF1jM6cj0A59mbj4?=
 =?us-ascii?Q?kfgtdS4LvdB+xdlnnYHTLPg63/RCO1pXnzNXnzrVSKGjnHJ6sI6BRwxTK1Ke?=
 =?us-ascii?Q?0L1KR8dpnSmAr6sRabCs9ghLlXJYaJdPVpD/XXz1rhTfiqNzlWE3UVe4ko0c?=
 =?us-ascii?Q?9HXoFwqyeJI/I+vPv7yv7Yvj5Z5X5pNOOpnU2uQPrxAMCgt1cJYCEACql+Wv?=
 =?us-ascii?Q?TUCFu0LNVL3p6EnetzUqt0orTXohKfOm/R9nCP0J+O4ztViZ46DnJUedp2dA?=
 =?us-ascii?Q?HMgvUGK2MFP9GVrhcSRYy3HT2ZiIKmL1apYj/J18RMCk8FEBg2IAGclNe3Gw?=
 =?us-ascii?Q?Enrlq3UF0C9EeTK3mBbl4zkTdAOO9+txzrhhcIqHRvJP+mGAiRugltxMsk3h?=
 =?us-ascii?Q?nxzFEGdoE5wEra9rieVTBtiRTyFwP19OZqDjb0T4mBRtbM3YSq2709bVSJbq?=
 =?us-ascii?Q?/TMs3WSkccrjzRB3KJCk4HRAZQylJstdRUILjPGTnGbzKu1XiuVspiZQzDm6?=
 =?us-ascii?Q?I4HgABZQtO6OC26EQLAn4qNcJnrjuBEYEx2MKVSHU/HWzP7YWa+mvzMru9ka?=
 =?us-ascii?Q?wjUIt9ETueboLe34qxFmviOgS3lzj7kEB3Xhbn8SMvcJI9aWFiQwEZSY81cI?=
 =?us-ascii?Q?tPazLWZ9SaqigK0JL4XPTOlXN41iWUljwnQLbQoNzNynB9cF9H2ZYtgMmeoS?=
 =?us-ascii?Q?jlMFItMCiTzEQZUuFWtgmIMVc7wRUhgeR3ilzneoRrY/0LEQFx73/pHzcHca?=
 =?us-ascii?Q?JdHapzLXmpyP5zJrC7ddXyfHK2ECBLJQpsdJDGOLYESC0ZfM+hRmTgwoVmq1?=
 =?us-ascii?Q?8Dp7JupxMY/4PqY2YXr0mB9SZKxe9+FYZhHxrLqTt/5UKwh55g44ZL9Vjw+3?=
 =?us-ascii?Q?rVy09xh2CAtn7FVXpuNWJRxld2OFs6C8ljkMJPgTbh3TFkp7uq3NYBkkoFOY?=
 =?us-ascii?Q?7fMgNUBW4xpbT99K0E9MU0d/xl5kuZtqNNckgLIcfZ3V1mcUHMqEbDkqVTaf?=
 =?us-ascii?Q?MV7m4akZu6h0rhKCfcULFXLw+3+PZTGVWKsLixJM3QMxF+Jvx7qeYtnNrwkE?=
 =?us-ascii?Q?3Q5LC5++I1h0ck4JU3ROpD40F502PDjM9eJMtkauIjwmMvCw5MFqcMtXWQP9?=
 =?us-ascii?Q?iiT0URfqmuDjz9tzKQrZVAiwqD/AtvMt1kVkq4a5kuWgS0UEOmu6ctxiaVZo?=
 =?us-ascii?Q?kfZwmqAK9Z7B9Sq39UFtjcwV/9eyh18Omshi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:56:35.5250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f04237ee-0529-4d6c-14cb-08ddd0d951e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA42F4F89B
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

This commit decommissions the function kfd_get_process()
because it can not locate a specific kfd process among
mulitple contexts.

This commit refactors the relevant code path accordingly:
- kmmap: retrieve the kfd_process from filep->private_data
- kq_initialize: queue->process for HIQ should be set to NULL
because it does not belong to any kfd_process. DIQ has been
decommissioned in this commit because it has been marked as
DEPRECATED since 2022 in commit 5bdd3eb2

This commit removes test_kq() function becuse it has been
marked as unused since 2014 and no other functions calls it.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 11 ++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 60 ++-----------------
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  4 --
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 --
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 18 ------
 .../amd/amdkfd/kfd_process_queue_manager.c    | 35 +----------
 8 files changed, 16 insertions(+), 123 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 5b22e1c47b2e..9e95acd23889 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3408,16 +3408,19 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
 }
 
 
-static int kfd_mmap(struct file *filp, struct vm_area_struct *vma)
+static int kfd_mmap(struct file *filep, struct vm_area_struct *vma)
 {
 	struct kfd_process *process;
 	struct kfd_node *dev = NULL;
 	unsigned long mmap_offset;
 	unsigned int gpu_id;
 
-	process = kfd_get_process(current);
-	if (IS_ERR(process))
-		return PTR_ERR(process);
+	process = filep->private_data;
+	if (!process)
+		return -ESRCH;
+
+	if (process->lead_thread != current->group_leader)
+		return -EBADF;
 
 	mmap_offset = vma->vm_pgoff << PAGE_SHIFT;
 	gpu_id = KFD_MMAP_GET_GPU_ID(mmap_offset);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 76359c6a3f3a..3f78e0bb2dae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -399,8 +399,7 @@ static void increment_queue_count(struct device_queue_manager *dqm,
 				  struct queue *q)
 {
 	dqm->active_queue_count++;
-	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
-	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
+	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
 		dqm->active_cp_queue_count++;
 
 	if (q->properties.is_gws) {
@@ -414,8 +413,7 @@ static void decrement_queue_count(struct device_queue_manager *dqm,
 				  struct queue *q)
 {
 	dqm->active_queue_count--;
-	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
-	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
+	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
 		dqm->active_cp_queue_count--;
 
 	if (q->properties.is_gws) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 2b0a830f5b29..6aa8b0348bad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -46,7 +46,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 	int retval;
 	union PM4_MES_TYPE_3_HEADER nop;
 
-	if (WARN_ON(type != KFD_QUEUE_TYPE_DIQ && type != KFD_QUEUE_TYPE_HIQ))
+	if (WARN_ON(type != KFD_QUEUE_TYPE_HIQ))
 		return false;
 
 	pr_debug("Initializing queue type %d size %d\n", KFD_QUEUE_TYPE_HIQ,
@@ -61,14 +61,9 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 
 	kq->dev = dev;
 	kq->nop_packet = nop.u32all;
-	switch (type) {
-	case KFD_QUEUE_TYPE_DIQ:
-		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_DIQ];
-		break;
-	case KFD_QUEUE_TYPE_HIQ:
+	if (type == KFD_QUEUE_TYPE_HIQ)
 		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
-		break;
-	default:
+	else {
 		dev_err(dev->adev->dev, "Invalid queue type %d\n", type);
 		return false;
 	}
@@ -144,7 +139,8 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 		goto err_init_queue;
 
 	kq->queue->device = dev;
-	kq->queue->process = kfd_get_process(current);
+	if (type == KFD_QUEUE_TYPE_HIQ)
+		kq->queue->process = NULL;
 
 	kq->queue->mqd_mem_obj = kq->mqd_mgr->allocate_mqd(kq->mqd_mgr->dev,
 					&kq->queue->properties);
@@ -162,24 +158,11 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 		kq->mqd_mgr->load_mqd(kq->mqd_mgr, kq->queue->mqd,
 				kq->queue->pipe, kq->queue->queue,
 				&kq->queue->properties, NULL);
-	} else {
-		/* allocate fence for DIQ */
-
-		retval = kfd_gtt_sa_allocate(dev, sizeof(uint32_t),
-						&kq->fence_mem_obj);
-
-		if (retval != 0)
-			goto err_alloc_fence;
-
-		kq->fence_kernel_address = kq->fence_mem_obj->cpu_ptr;
-		kq->fence_gpu_addr = kq->fence_mem_obj->gpu_addr;
 	}
 
 	print_queue(kq->queue);
 
 	return true;
-err_alloc_fence:
-	kq->mqd_mgr->free_mqd(kq->mqd_mgr, kq->queue->mqd, kq->queue->mqd_mem_obj);
 err_allocate_mqd:
 	uninit_queue(kq->queue);
 err_init_queue:
@@ -209,8 +192,6 @@ static void kq_uninitialize(struct kernel_queue *kq)
 					kq->queue->queue);
 		up_read(&kq->dev->adev->reset_domain->sem);
 	}
-	else if (kq->queue->properties.type == KFD_QUEUE_TYPE_DIQ)
-		kfd_gtt_sa_free(kq->dev, kq->fence_mem_obj);
 
 	kq->mqd_mgr->free_mqd(kq->mqd_mgr, kq->queue->mqd,
 				kq->queue->mqd_mem_obj);
@@ -358,34 +339,3 @@ void kernel_queue_uninit(struct kernel_queue *kq)
 	kq_uninitialize(kq);
 	kfree(kq);
 }
-
-/* FIXME: Can this test be removed? */
-static __attribute__((unused)) void test_kq(struct kfd_node *dev)
-{
-	struct kernel_queue *kq;
-	uint32_t *buffer, i;
-	int retval;
-
-	dev_err(dev->adev->dev, "Starting kernel queue test\n");
-
-	kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_HIQ);
-	if (unlikely(!kq)) {
-		dev_err(dev->adev->dev, "  Failed to initialize HIQ\n");
-		dev_err(dev->adev->dev, "Kernel queue test failed\n");
-		return;
-	}
-
-	retval = kq_acquire_packet_buffer(kq, 5, &buffer);
-	if (unlikely(retval != 0)) {
-		dev_err(dev->adev->dev, "  Failed to acquire packet buffer\n");
-		dev_err(dev->adev->dev, "Kernel queue test failed\n");
-		return;
-	}
-	for (i = 0; i < 5; i++)
-		buffer[i] = kq->nop_packet;
-	kq_submit_packet(kq);
-
-	dev_err(dev->adev->dev, "Ending kernel queue test\n");
-}
-
-
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 505036968a77..3d2375817c3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -252,10 +252,6 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 			packet->bitfields2.queue_type =
 		queue_type__mes_map_queues__normal_latency_static_queue_vi;
 		break;
-	case KFD_QUEUE_TYPE_DIQ:
-		packet->bitfields2.queue_type =
-			queue_type__mes_map_queues__debug_interface_queue_vi;
-		break;
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
 		if (q->properties.sdma_engine_id < 2 &&
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
index a1de5d7e173a..60086e7cc258 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
@@ -166,10 +166,6 @@ static int pm_map_queues_vi(struct packet_manager *pm, uint32_t *buffer,
 			packet->bitfields2.queue_type =
 		queue_type__mes_map_queues__normal_latency_static_queue_vi;
 		break;
-	case KFD_QUEUE_TYPE_DIQ:
-		packet->bitfields2.queue_type =
-			queue_type__mes_map_queues__debug_interface_queue_vi;
-		break;
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
 		packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a6e12c705734..67ebdaa9995f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1047,7 +1047,6 @@ void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
 struct kfd_process *kfd_create_process(struct task_struct *thread);
 int kfd_create_process_sysfs(struct kfd_process *process);
-struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 117e524f4fb3..2d01356627ef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -989,24 +989,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	return process;
 }
 
-struct kfd_process *kfd_get_process(const struct task_struct *thread)
-{
-	struct kfd_process *process;
-
-	if (!thread->mm)
-		return ERR_PTR(-EINVAL);
-
-	/* Only the pthreads threading model is supported. */
-	if (thread->group_leader->mm != thread->mm)
-		return ERR_PTR(-EINVAL);
-
-	process = find_process(thread, false);
-	if (!process)
-		return ERR_PTR(-EINVAL);
-
-	return process;
-}
-
 static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
 {
 	struct kfd_process *process;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c643e0ccec52..287ac5de838a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -345,7 +345,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	 * If we are just about to create DIQ, the is_debug flag is not set yet
 	 * Hence we also check the type as well
 	 */
-	if ((pdd->qpd.is_debug) || (type == KFD_QUEUE_TYPE_DIQ))
+	if ((pdd->qpd.is_debug))
 		max_queues = dev->kfd->device_info.max_no_of_hqd/2;
 
 	if (pdd->qpd.queue_count >= max_queues)
@@ -426,22 +426,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 						    restore_mqd, restore_ctl_stack);
 		print_queue(q);
 		break;
-	case KFD_QUEUE_TYPE_DIQ:
-		kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_DIQ);
-		if (!kq) {
-			retval = -ENOMEM;
-			goto err_create_queue;
-		}
-		kq->queue->properties.queue_id = *qid;
-		pqn->kq = kq;
-		pqn->q = NULL;
-		retval = kfd_process_drain_interrupts(pdd);
-		if (retval)
-			break;
-
-		retval = dev->dqm->ops.create_kernel_queue(dev->dqm,
-							kq, &pdd->qpd);
-		break;
 	default:
 		WARN(1, "Invalid queue type %d", type);
 		retval = -EINVAL;
@@ -1128,24 +1112,9 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
 			mqd_mgr = q->device->dqm->mqd_mgrs[mqd_type];
 			size = mqd_mgr->mqd_stride(mqd_mgr,
 							&q->properties);
-		} else if (pqn->kq) {
-			q = pqn->kq->queue;
-			mqd_mgr = pqn->kq->mqd_mgr;
-			switch (q->properties.type) {
-			case KFD_QUEUE_TYPE_DIQ:
-				seq_printf(m, "  DIQ on device %x\n",
-					   pqn->kq->dev->id);
-				break;
-			default:
-				seq_printf(m,
-				"  Bad kernel queue type %d on device %x\n",
-					   q->properties.type,
-					   pqn->kq->dev->id);
-				continue;
-			}
 		} else {
 			seq_printf(m,
-		"  Weird: Queue node with neither kernel nor user queue\n");
+			"  Weird: Queue node with neither kernel nor user queue\n");
 			continue;
 		}
 
-- 
2.47.1

