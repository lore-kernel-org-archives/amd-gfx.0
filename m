Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7C2C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 08:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B14760EBD
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 08:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B14760EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A85F6E446;
	Mon, 11 Oct 2021 08:59:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29CCA6E446
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 08:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUOwsOojX7VqcZ2RfqKPgcXLVkVhkEk49IK3LNtZWomnsOPqo3k4IxbntjMN4lSkTAxRcxbUTX49WOOzZm7waNxySzk4f6ezax/pDJatOB7r95sTBJPl8XKexhvuGthpUC316WFG8CREh56/NI2AGqT9y6oN8aMVWDtpDXktWM30HJcwxeZWRQu1ROEJ0lXSWvt82fi7gLpPNfxpbdheUJX3EXwGM3r8OPs3SLyWppopbLnKcc7InAUdalfxA6jl/1YVZzHOFfoWMebryVPyFJVzST+hmjJnQOBy7NLTu+E1dPJSqf3ZWTqzBfhqMHQ5ncMPN8ei/PSEpSlhz4mrIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0FMHZnUldsfypI/5UiSF/slePRqACVK/HswnpIX5CA=;
 b=iUv0YwdhI8jIM164d2Uw7QGBYvTgJysGbw/FkggS+V5XASXMsF5KonMkdqtKEXP/tFVB3VvruQIXk0Ud0KrD/RcVLACW/toApBADAqOOMkPdBEdiV8JAnCWYgOSSGWlEc09a4rUoFic88/gMbeUOYOIJ/tad6XPcH+urmZRRrm2HT+jyEFNdz+jQg0FKZOHTwyRT/mdCUbYGgi7RJUunjiUIzXr1qswXKG0Cx8c2Uf8/fojVIyCUAbxI79JiZR6LtSqZAhTDBvXigR1ZiX9SQUZ/z2BSSAVmX1bY+Qtaw9FFHlakbdQA8h2KN6x1Y8+ceu/gEi2tJpF1jPvXKu4J0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0FMHZnUldsfypI/5UiSF/slePRqACVK/HswnpIX5CA=;
 b=nDy5acHYPpbInL1kCCtZ2hrGkSYKg2WUvyXu86vB79eUmFc9R3p+x9s1AFZPNCS2pbycHG44uaKcRpNLCbLpoPbkooVFet6rtQlFPisyLLxyWZMinHpXEcoRckjNx7kqLCtbRdmOc6C0QeUJ18GaEWX3F5d0K/HFLTNFGxAV9sE=
Received: from MW4PR03CA0025.namprd03.prod.outlook.com (2603:10b6:303:8f::30)
 by DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Mon, 11 Oct
 2021 08:59:16 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::75) by MW4PR03CA0025.outlook.office365.com
 (2603:10b6:303:8f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Mon, 11 Oct 2021 08:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 08:59:15 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 03:59:11 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Christian Koenig <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Huang Rui
 <ray.huang@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdkfd: Separate pinned BOs destruction from general
 routine
Date: Mon, 11 Oct 2021 16:58:37 +0800
Message-ID: <20211011085837.611326-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bde467dc-5a21-48a0-4e21-08d98c9566d0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4862:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4862AF153B903AE0932A9382FBB59@DM6PR12MB4862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b10nWjs5WNHagxDe1OY07EnZE1hFwN3KOYqxLAqVjZjwufGK1a+b3gUDzbpgbNWrGkkQpFa5ZYU/1RNX9HyVGAb8QlmF8zs2pTDRAIw4gYW4hOrTd+rS6QWHwL64vQ8/9n6zxguxRyyZaLuH3rdMmOXy7Pw3yqk7aPLDx7p7YWu+IiSjwKgtO5dkelASOHPqbkth1my0fNmHkRyAseT2NAVqUPnJCYRTjSjWsXyQv8eo2F1NqVESE0LTVs+1ZY+eYzUA4TN9EFnK79s0V9NxysQC70Yp9xj8SkRPnOP+9u10cunKzXRpAOr7EvjyVHu11LA/FF4lxCtQT4/Ntb0tvUh2U+8VUeNVEBON20ShUoL53DSNj6oqoYQQpiGXQylhrZdx07w50NgrTXsEnZqyVkcns4rs2C2ad7v/MxAGqkoXVtm8RIEzo0Z1zvHq2AN8xehBfOmV5Cw8FRtZGHok2ZV6XHtbOpUjLQey4FPhKlHIbR9jsxHr5V97hky+gGpsr/g/YETSXORauW/1dBSoOT1W+KrfTsqUPXa1SfmN+Q0DglmOKtWlXi/RmJUdbt9d1zQYia1PkDZHfNvsXdbUl7QO3sSTx6Na2RxAEGaw4pCxBw4kGy6CPKd2uv9zGU92b4S2siPIZWboFDjdFuVP6Zu9DFr9ScI2BrPbOv4MPH5t+/8HE7SuIeJBGGHP1UcmlgT7Jwlc982N6DI5o8IuDBK1UbCVdI8I1TBdD942VRQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(70586007)(82310400003)(54906003)(26005)(2616005)(16526019)(70206006)(8936002)(316002)(8676002)(36756003)(336012)(5660300002)(426003)(356005)(81166007)(7696005)(36860700001)(6916009)(1076003)(83380400001)(2906002)(47076005)(30864003)(44832011)(4326008)(6666004)(86362001)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 08:59:15.1139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bde467dc-5a21-48a0-4e21-08d98c9566d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
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

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  10 ++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   3 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 125 ++++++++++++++----
 5 files changed, 114 insertions(+), 29 deletions(-)

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
index 054c1a224def..6acc78b02bdc 100644
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
index f1e7edeb4e6b..0db48ac10fde 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1051,6 +1051,9 @@ static int kfd_ioctl_create_event(struct file *filp, struct kfd_process *p,
 			pr_err("Failed to set event page\n");
 			return err;
 		}
+
+		p->signal_handle = args->event_page_offset;
+
 	}
 
 	err = kfd_event_create(filp, p, args->event_type,
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
index 21ec8a18cad2..c024f2e2efaa 100644
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
@@ -947,6 +949,52 @@ static void kfd_process_device_free_bos(struct kfd_process_device *pdd)
 	}
 }
 
+static void kfd_process_free_signal_bo(struct kfd_process *p)
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
+	if (!pdd) {
+		mutex_unlock(&p->mutex);
+		return;
+	}
+
+	mem = kfd_process_device_translate_handle(
+		pdd, GET_IDR_HANDLE(p->signal_handle));
+	if (!mem) {
+		mutex_unlock(&p->mutex);
+		return;
+	}
+
+	mutex_unlock(&p->mutex);
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *peer_pdd = p->pdds[i];
+
+		if (!peer_pdd->drm_priv)
+			continue;
+		amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
+				peer_pdd->dev->kgd, mem, peer_pdd->drm_priv);
+	}
+
+	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(kdev->kgd, mem);
+
+	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->kgd, mem,
+		pdd->drm_priv, NULL);
+
+	kfd_process_device_remove_obj_handle(pdd,
+		GET_IDR_HANDLE(p->signal_handle));
+}
+
 static void kfd_process_free_outstanding_kfd_bos(struct kfd_process *p)
 {
 	int i;
@@ -965,6 +1013,9 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
 				pdd->dev->id, p->pasid);
 
+		kfd_process_device_destroy_cwsr_dgpu(pdd);
+		kfd_process_device_destroy_ib_mem(pdd);
+
 		if (pdd->drm_file) {
 			amdgpu_amdkfd_gpuvm_release_process_vm(
 					pdd->dev->kgd, pdd->drm_priv);
@@ -1049,9 +1100,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 {
 	struct kfd_process *p = container_of(work, struct kfd_process,
 					     release_work);
+
 	kfd_process_remove_sysfs(p);
 	kfd_iommu_unbind_process(p);
 
+	kfd_process_free_signal_bo(p);
 	kfd_process_free_outstanding_kfd_bos(p);
 	svm_range_list_fini(p);
 
@@ -1066,6 +1119,7 @@ static void kfd_process_wq_release(struct work_struct *work)
 	put_task_struct(p->lead_thread);
 
 	kfree(p);
+
 }
 
 static void kfd_process_ref_release(struct kref *ref)
@@ -1198,6 +1252,7 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_GTT
 			| KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
 			| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
+	struct kgd_mem *mem;
 	void *kaddr;
 	int ret;
 
@@ -1206,10 +1261,11 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 
 	/* cwsr_base is only set for dGPU */
 	ret = kfd_process_alloc_gpuvm(pdd, qpd->cwsr_base,
-				      KFD_CWSR_TBA_TMA_SIZE, flags, &kaddr);
+				      KFD_CWSR_TBA_TMA_SIZE, flags, &mem, &kaddr);
 	if (ret)
 		return ret;
 
+	qpd->cwsr_mem = mem;
 	qpd->cwsr_kaddr = kaddr;
 	qpd->tba_addr = qpd->cwsr_base;
 
@@ -1222,6 +1278,17 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
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

