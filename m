Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B790CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 06:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D8760F41
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 06:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64D8760F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5396ECE2;
	Fri, 15 Oct 2021 06:55:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F7B6ECE2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 06:55:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaBtAhW0EDnJfu4L7R670PUpcJIYVhs6PBF0pX/hvIPXGClbKliPuICakXG98Ac+Xl0O6WNwWuR5csFxtsMiwBuvggQcRVrUeEBjGfNiXh7FZGdlNViSfnc4Ll3JejBgThRhsPsEdjaMZe6F62XzNm2HhIWKZBxeSKqR0p+IJT0bleVjLEN0FjchxLSLgAv1O3qRMEjqTyQIwDeFv5We+0eYlnpBEdJdg2l1oCH4Iwg/oKQS9PNLf4LWV6Qavb66PLWQBJ1LFGUy+fwAcG805zxzOs+Fto8DeWF7cUYE79JTK6fKAnYIFpjhjsj5YpQ6FUIy8VsMuXBVLqxSlUkc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sziO3ZHl9wA+8rpyDtQvfF/LlDzyT93DE3Gqo7W+6ig=;
 b=bqpMpzq3A3j8qHMnvEngkAkSi9iN1w35Fh2jXRC/NNlvPn4nAhObFG8Q/QWoqGPSPmAqszFNuCpVXU0cnA0eaLrshyuGGTqWX95YDHyJ88sG4BqWo3YKasnqgZFKnDUwOS2bTi1x/zlrEve1d6KOtAQ2AtoC3S47fvMFPr/QlPQvep7aRKSy0Or2SwD8YfBNZUc/mRDz7LsbbGWYUyzNEy4URAIj4uGoYai0gbQryW5Sq3szfygPeShPtwA9nPpOcOgkO5KUw1zeg3Aw0hXpFTll/FtJGeJUl4jyUJVXE/dlOR83HYNslv/PppcjGDXH68FmZZr8TnVVp+/GJyGmGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sziO3ZHl9wA+8rpyDtQvfF/LlDzyT93DE3Gqo7W+6ig=;
 b=L9f84wbg+3pjb/bVhMYDkH9AdXpsZHqvN879kBGA8bMVy4iQlYMN0pF4Hoy0T3iW8H+ZDAh9jzEIGPbGjcf2FGDi/9ZZwHH5V9TS7ZOi298b+ddmm4FRyfxaV+YI/QkUUhvui8qtsKJB6w17uxj7C2olpQdVmZPaizQeHUH2j5M=
Received: from BN0PR04CA0174.namprd04.prod.outlook.com (2603:10b6:408:eb::29)
 by BYAPR12MB2646.namprd12.prod.outlook.com (2603:10b6:a03:65::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 06:55:05 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::9e) by BN0PR04CA0174.outlook.office365.com
 (2603:10b6:408:eb::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 06:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 06:55:04 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 01:55:01 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Huang
 Rui" <ray.huang@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH v2] drm/amdkfd: Separate pinned BOs destruction from general
 routine
Date: Fri, 15 Oct 2021 14:54:47 +0800
Message-ID: <20211015065447.2025572-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1034566b-40d4-4a47-00fb-08d98fa8b76b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2646:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2646A813E2ED3230771A8F01FBB99@BYAPR12MB2646.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n01aFT3naq01Rcrh4tbhySpEP9oxGUrFVs96lrUyhjdubv4IKYyuNHEalm2pMmqHvr/c9RuGb6p0EZaJjNR4FhrNn4bwOxYdEjJUsHVvxPof0Of+Gyrg8YCrCEqnkmDm09RKbaRKmv3OQVyChk4WAD9f3VpSHNIRb6geVLktm/SD8pBWuh0sMxaTh7rK26/VmGv/j76y9tPYkoQIBH59U3XXS74QdokHbAssGf7XpN3JGVBqq0p5AhS+VWH7kaxSrCDrAZBkqL6kexzukhVtfcfKRynk5wNA8zvSqQtle+UvcHc+JlRAkpBSd13t/Zhu3Ms/Ylz2i9BUFBKY7ThheP+kmA6wpm/wvYxupNG87RmHWTNtDOhnS9QgpEJ6AB5A93yIFWlFWz9yriEUdH8KNfJmtD9hdI/PSUE2AmDwfnISLBX1rJnFlckGlDXM9mvl9WKM0FLb2Se3pCAth0wCNOmz3mIJHW8ZULg0QZ9mCZdHvnwbQUk7PXXSTprWkl54aPwSom8pbbq7YMKMrPZZXk6TG/V1IOXLPMw4ORNRYA2BwEfCg9T0qKUFbiJZyvk98rWfvpLjvvS0PCEe/dFBSQDcnIJnt1CyOz6kwxayGkIkoXF2zaESId342sovjWwg9jThFT9LTdK6qwsYJYMfoIrFomx6pWXoSME0n+8zgX4MPs9CiwgWh0YBxufjIypDyj2WPXdPupELC6FdOmX+RQStRvKZbP16Rc4wYc4InkY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(70586007)(2616005)(336012)(8676002)(6916009)(4326008)(426003)(5660300002)(54906003)(30864003)(36756003)(44832011)(1076003)(316002)(356005)(86362001)(8936002)(6666004)(7696005)(2906002)(81166007)(508600001)(83380400001)(36860700001)(82310400003)(16526019)(186003)(26005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:55:04.3736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1034566b-40d4-4a47-00fb-08d98fa8b76b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2646
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

Currently, all kfd BOs use same destruction routine. But pinned
BOs are not unpinned properly. Separate them from general routine.

v2 (Felix):
Add safeguard to prevent user space from freeing signal BO.
Kunmap signal BO in the event of setting event page error.
Just kunmap signal BO to avoid duplicating the code.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  10 ++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  31 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 110 +++++++++++++-----
 5 files changed, 119 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 69de31754907..751557af09bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -279,6 +279,8 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct kgd_dev *kgd, struct kgd_mem *mem, bool intr);
 int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
 		struct kgd_mem *mem, void **kptr, uint64_t *size);
+void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_dev *kgd, struct kgd_mem *mem);
+
 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 					    struct dma_fence **ef);
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cdf46bd0d8d5..4969763c2e47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1871,6 +1871,16 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_dev *kgd,
 	return ret;
 }
 
+void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_dev *kgd, struct kgd_mem *mem)
+{
+	struct amdgpu_bo *bo = mem->bo;
+
+	amdgpu_bo_reserve(bo, true);
+	amdgpu_bo_kunmap(bo);
+	amdgpu_bo_unpin(bo);
+	amdgpu_bo_unreserve(bo);
+}
+
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
 					      struct kfd_vm_fault_info *mem)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f1e7edeb4e6b..9317a2e238d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1011,11 +1011,6 @@ static int kfd_ioctl_create_event(struct file *filp, struct kfd_process *p,
 		void *mem, *kern_addr;
 		uint64_t size;
 
-		if (p->signal_page) {
-			pr_err("Event page is already set\n");
-			return -EINVAL;
-		}
-
 		kfd = kfd_device_by_id(GET_GPU_ID(args->event_page_offset));
 		if (!kfd) {
 			pr_err("Getting device by id failed in %s\n", __func__);
@@ -1023,6 +1018,13 @@ static int kfd_ioctl_create_event(struct file *filp, struct kfd_process *p,
 		}
 
 		mutex_lock(&p->mutex);
+
+		if (p->signal_page) {
+			pr_err("Event page is already set\n");
+			err = -EINVAL;
+			goto out_unlock;
+		}
+
 		pdd = kfd_bind_process_to_device(kfd, p);
 		if (IS_ERR(pdd)) {
 			err = PTR_ERR(pdd);
@@ -1037,20 +1039,24 @@ static int kfd_ioctl_create_event(struct file *filp, struct kfd_process *p,
 			err = -EINVAL;
 			goto out_unlock;
 		}
-		mutex_unlock(&p->mutex);
 
 		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kfd->kgd,
 						mem, &kern_addr, &size);
 		if (err) {
 			pr_err("Failed to map event page to kernel\n");
-			return err;
+			goto out_unlock;
 		}
 
 		err = kfd_event_page_set(p, kern_addr, size);
 		if (err) {
 			pr_err("Failed to set event page\n");
-			return err;
+			amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(kfd->kgd, mem);
+			goto out_unlock;
 		}
+
+		p->signal_handle = args->event_page_offset;
+
+		mutex_unlock(&p->mutex);
 	}
 
 	err = kfd_event_create(filp, p, args->event_type,
@@ -1368,6 +1374,15 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 		return -EINVAL;
 
 	mutex_lock(&p->mutex);
+	/*
+	 * Safeguard to prevent user space from freeing signal BO.
+	 * It will be freed at process termination.
+	 */
+	if (p->signal_handle && (p->signal_handle == args->handle)) {
+		pr_err("Free signal BO is not allowed\n");
+		ret = -EPERM;
+		goto err_unlock;
+	}
 
 	pdd = kfd_get_process_device_data(dev, p);
 	if (!pdd) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 6d8f9bb2d905..30f08f1606bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -608,12 +608,14 @@ struct qcm_process_device {
 	uint32_t sh_hidden_private_base;
 
 	/* CWSR memory */
+	struct kgd_mem *cwsr_mem;
 	void *cwsr_kaddr;
 	uint64_t cwsr_base;
 	uint64_t tba_addr;
 	uint64_t tma_addr;
 
 	/* IB memory */
+	struct kgd_mem *ib_mem;
 	uint64_t ib_base;
 	void *ib_kaddr;
 
@@ -808,6 +810,7 @@ struct kfd_process {
 	/* Event ID allocator and lookup */
 	struct idr event_idr;
 	/* Event page */
+	u64 signal_handle;
 	struct kfd_signal_page *signal_page;
 	size_t signal_mapped_size;
 	size_t signal_event_count;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 21ec8a18cad2..26fc716a92c2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -72,6 +72,8 @@ static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep);
 static void evict_process_worker(struct work_struct *work);
 static void restore_process_worker(struct work_struct *work);
 
+static void kfd_process_device_destroy_cwsr_dgpu(struct kfd_process_device *pdd);
+
 struct kfd_procfs_tree {
 	struct kobject *kobj;
 };
@@ -685,10 +687,15 @@ void kfd_process_destroy_wq(void)
 }
 
 static void kfd_process_free_gpuvm(struct kgd_mem *mem,
-			struct kfd_process_device *pdd)
+			struct kfd_process_device *pdd, void *kptr)
 {
 	struct kfd_dev *dev = pdd->dev;
 
+	if (kptr) {
+		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(dev->kgd, mem);
+		kptr = NULL;
+	}
+
 	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(dev->kgd, mem, pdd->drm_priv);
 	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, mem, pdd->drm_priv,
 					       NULL);
@@ -702,63 +709,46 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
  */
 static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 				   uint64_t gpu_va, uint32_t size,
-				   uint32_t flags, void **kptr)
+				   uint32_t flags, struct kgd_mem **mem, void **kptr)
 {
 	struct kfd_dev *kdev = pdd->dev;
-	struct kgd_mem *mem = NULL;
-	int handle;
 	int err;
 
 	err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->kgd, gpu_va, size,
-						 pdd->drm_priv, &mem, NULL, flags);
+						 pdd->drm_priv, mem, NULL, flags);
 	if (err)
 		goto err_alloc_mem;
 
-	err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(kdev->kgd, mem,
+	err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(kdev->kgd, *mem,
 			pdd->drm_priv, NULL);
 	if (err)
 		goto err_map_mem;
 
-	err = amdgpu_amdkfd_gpuvm_sync_memory(kdev->kgd, mem, true);
+	err = amdgpu_amdkfd_gpuvm_sync_memory(kdev->kgd, *mem, true);
 	if (err) {
 		pr_debug("Sync memory failed, wait interrupted by user signal\n");
 		goto sync_memory_failed;
 	}
 
-	/* Create an obj handle so kfd_process_device_remove_obj_handle
-	 * will take care of the bo removal when the process finishes.
-	 * We do not need to take p->mutex, because the process is just
-	 * created and the ioctls have not had the chance to run.
-	 */
-	handle = kfd_process_device_create_obj_handle(pdd, mem);
-
-	if (handle < 0) {
-		err = handle;
-		goto free_gpuvm;
-	}
-
 	if (kptr) {
 		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kdev->kgd,
-				(struct kgd_mem *)mem, kptr, NULL);
+				(struct kgd_mem *)*mem, kptr, NULL);
 		if (err) {
 			pr_debug("Map GTT BO to kernel failed\n");
-			goto free_obj_handle;
+			goto sync_memory_failed;
 		}
 	}
 
 	return err;
 
-free_obj_handle:
-	kfd_process_device_remove_obj_handle(pdd, handle);
-free_gpuvm:
 sync_memory_failed:
-	kfd_process_free_gpuvm(mem, pdd);
-	return err;
+	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(kdev->kgd, *mem, pdd->drm_priv);
 
 err_map_mem:
-	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, mem, pdd->drm_priv,
+	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, *mem, pdd->drm_priv,
 					       NULL);
 err_alloc_mem:
+	*mem = NULL;
 	*kptr = NULL;
 	return err;
 }
@@ -776,6 +766,7 @@ static int kfd_process_device_reserve_ib_mem(struct kfd_process_device *pdd)
 			KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE |
 			KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE |
 			KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
+	struct kgd_mem *mem;
 	void *kaddr;
 	int ret;
 
@@ -784,15 +775,26 @@ static int kfd_process_device_reserve_ib_mem(struct kfd_process_device *pdd)
 
 	/* ib_base is only set for dGPU */
 	ret = kfd_process_alloc_gpuvm(pdd, qpd->ib_base, PAGE_SIZE, flags,
-				      &kaddr);
+				      &mem, &kaddr);
 	if (ret)
 		return ret;
 
+	qpd->ib_mem = mem;
 	qpd->ib_kaddr = kaddr;
 
 	return 0;
 }
 
+static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
+{
+	struct qcm_process_device *qpd = &pdd->qpd;
+
+	if (!qpd->ib_kaddr || !qpd->ib_base)
+		return;
+
+	kfd_process_free_gpuvm(qpd->ib_mem, pdd, qpd->ib_kaddr);
+}
+
 struct kfd_process *kfd_create_process(struct file *filep)
 {
 	struct kfd_process *process;
@@ -947,6 +949,38 @@ static void kfd_process_device_free_bos(struct kfd_process_device *pdd)
 	}
 }
 
+/*
+ * Just kunmap and unpin signal BO here. It will be freed in
+ * kfd_process_free_outstanding_kfd_bos()
+ */
+static void kfd_process_kunmap_signal_bo(struct kfd_process *p)
+{
+	struct kfd_process_device *pdd;
+	struct kfd_dev *kdev;
+	void *mem;
+	int i;
+
+	kdev = kfd_device_by_id(GET_GPU_ID(p->signal_handle));
+	if (!kdev)
+		return;
+
+	mutex_lock(&p->mutex);
+
+	pdd = kfd_get_process_device_data(kdev, p);
+	if (!pdd)
+		goto out;
+
+	mem = kfd_process_device_translate_handle(
+		pdd, GET_IDR_HANDLE(p->signal_handle));
+	if (!mem)
+		goto out;
+
+	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(kdev->kgd, mem);
+
+out:
+	mutex_unlock(&p->mutex);
+}
+
 static void kfd_process_free_outstanding_kfd_bos(struct kfd_process *p)
 {
 	int i;
@@ -965,6 +999,9 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
 				pdd->dev->id, p->pasid);
 
+		kfd_process_device_destroy_cwsr_dgpu(pdd);
+		kfd_process_device_destroy_ib_mem(pdd);
+
 		if (pdd->drm_file) {
 			amdgpu_amdkfd_gpuvm_release_process_vm(
 					pdd->dev->kgd, pdd->drm_priv);
@@ -1049,9 +1086,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 {
 	struct kfd_process *p = container_of(work, struct kfd_process,
 					     release_work);
+
 	kfd_process_remove_sysfs(p);
 	kfd_iommu_unbind_process(p);
 
+	kfd_process_kunmap_signal_bo(p);
 	kfd_process_free_outstanding_kfd_bos(p);
 	svm_range_list_fini(p);
 
@@ -1198,6 +1237,7 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_GTT
 			| KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
 			| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
+	struct kgd_mem *mem;
 	void *kaddr;
 	int ret;
 
@@ -1206,10 +1246,11 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 
 	/* cwsr_base is only set for dGPU */
 	ret = kfd_process_alloc_gpuvm(pdd, qpd->cwsr_base,
-				      KFD_CWSR_TBA_TMA_SIZE, flags, &kaddr);
+				      KFD_CWSR_TBA_TMA_SIZE, flags, &mem, &kaddr);
 	if (ret)
 		return ret;
 
+	qpd->cwsr_mem = mem;
 	qpd->cwsr_kaddr = kaddr;
 	qpd->tba_addr = qpd->cwsr_base;
 
@@ -1222,6 +1263,17 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 	return 0;
 }
 
+static void kfd_process_device_destroy_cwsr_dgpu(struct kfd_process_device *pdd)
+{
+	struct kfd_dev *dev = pdd->dev;
+	struct qcm_process_device *qpd = &pdd->qpd;
+
+	if (!dev->cwsr_enabled || !qpd->cwsr_kaddr || !qpd->cwsr_base)
+		return;
+
+	kfd_process_free_gpuvm(qpd->cwsr_mem, pdd, qpd->cwsr_kaddr);
+}
+
 void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
 				  uint64_t tba_addr,
 				  uint64_t tma_addr)
-- 
2.25.1

