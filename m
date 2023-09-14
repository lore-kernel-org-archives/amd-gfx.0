Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D10DEEAA4F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 14:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3147D10E57A;
	Thu, 14 Sep 2023 14:55:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D33210E57B
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 14:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5ZascXPL6rD7kbKgrbwSRzxuy70oC/ajheqQq1PKV4ayrKU5bJg+aGvtGS8Hw7Rf6zeQdqqNyqEXK4L7yCFWzl/8R4Wjujrj3lj7NIxQQ86OG++GqHFrmZ1R5uvO06pCCwB9j6n7SJo6ghVAn7nj2BMf9IUk37pPQLqYVT0PgXfTXpTQfX44tX54cTjDGdWl2zj2q7i4XtbFmH1sRAPvBSodd7tRy1Kze6vXmP1R9+oghPE4ptYzWcTukB5ufSFJA0csG0VQPjScmKBGWT9AvsO+Z5ML9IrZjHlIIj45vkYxQ4k6dVkTTH7UKZ9EmJnZSyoNkL/DFVgMh3Zw3n8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQVAG7kfHdv7xROv7Dr5VY4CfAnCvjUrlVF0y5vpmkM=;
 b=Z+whnOFzArUHMhQupkTBBKSaqADPRIXKTc52Zfv8fe1MEuCMxQJ37r/vk3AbhbSvd0MKTwcRcEGz2+4ZuLV5F1tUydTq2JJ4n6vyNihVoAodJ0ZsXV2tnYmdUSofBXLR/AtPbQGr8fMJ1RzCQ+hc4wEyXN+q2vsfniF7QTb9kBhHP5vgSWuzDb1w6ddyg192n0O6NY4+Awwa+dPxNoeKKdQskL6ff5jyb3Ej8jVvYLGrhTArQsXk9G2wUucKeMmYLyqeaeTxmhnhqGfGC6XDP/ZZELIWMFrxDUwdKn7/lzie9lZJ7x0YxR5sg9tCd+1d6t6uS7CA6qA/EqgNsiObcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQVAG7kfHdv7xROv7Dr5VY4CfAnCvjUrlVF0y5vpmkM=;
 b=vcr/6xj/CasgGxq9/3q/WkNwIrSFzIpdP1/nxpDsrb0kX/1x4PSWNqj2568D2ccOzhTe0oIWcIA1wfzGsqgHvk9looQy77QAMgnxegY2bTxNT1BKMT0GLqTf4/jx6bc7FlyhTBGVC6GvXCI+AeO2eVK95/1HH4IcSY3i9qysASA=
Received: from DS7PR03CA0284.namprd03.prod.outlook.com (2603:10b6:5:3ad::19)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Thu, 14 Sep
 2023 14:55:15 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::3d) by DS7PR03CA0284.outlook.office365.com
 (2603:10b6:5:3ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 14:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 14 Sep 2023 14:55:15 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 09:55:14 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amdgpu: Add EXT_COHERENT memory allocation flags
Date: Thu, 14 Sep 2023 10:54:59 -0400
Message-ID: <20230914145459.1174743-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: efaa05c7-bd31-4088-0b11-08dbb5329ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nc0kQFNkWcSJTLTDleVwmISnHA0ba9mF2HTGmaLdjxo5yFCgI5UnAW9fVNS3Bpvk9fwO1pdad1cWSnt20JPjRf3PWHltq74+nRYR4eUx2ljToDcuaqQjIlgIZmOE4UUP3En0dvlmxQMxinaKYJqZ7WKd60fGnBWHbfTDfGdupT9s8BGKXxXhZVlwnqMSM595M8nyM0aX96Ck8HM/d1oUSrFO8ZpxY7jv29wK4FzzM7fZEUfC6d0/pdTUPrlHAJYnZoGaf1qrp2te03CM4kJXWCZDp5Fh4ZWkntqT0qDGijpvVEPdHg5R0MA0fS382/1q2ha2bBmqMZ7nvEm+epTcxT3oprhywsTJM4plBPYiDdG7ZhTrg+ekbkz8jfvvVfzgYiv054qV/neR3076/uRtifh+X+gbhb6ItiaXhoof8pXq+FDkFj7Q/zjem6sYqCAXUwQBOL/GVAQZ8Ix6mt5P9boJXXRO5Vk6I7iq7qlmZi0H6LKGYr83eaQuWKBTyYuQKqvOykIb72t46EtcrG9skj4zTAxVRzxWkpX2WuKiFwENZIr2VOvWfrdGLpbspMs6O6xSqcrjRKkLMa9WSbZYM3iXrVQG9hI9oAuEyuhT60YQt50IkUR7+UAnozarQftzRjhC/OCfm/Bwu7JINvAkNuSOht2Xd2bSbsnKbG/J91XUeCo4O6lZgEcttoajcQFQHKB4NxXfym7sicE6CegxToRj6nmwQ5W1/v9anpI+BuMxcYC3bxrFN+Ra6Id5KH4h
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(1800799009)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(41300700001)(54906003)(70586007)(70206006)(478600001)(40480700001)(356005)(6916009)(316002)(81166007)(966005)(40460700003)(36756003)(2906002)(86362001)(5660300002)(4326008)(8936002)(8676002)(426003)(36860700001)(1076003)(336012)(26005)(16526019)(2616005)(83380400001)(7696005)(82740400003)(47076005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:55:15.2134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efaa05c7-bd31-4088-0b11-08dbb5329ac9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067
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
Cc: David Francis <David.Francis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These flags (for GEM and SVM allocations) allocate
memory that allows for system-scope atomic semantics.

On GFX943 these flags cause caches to be avoided on
non-local memory.

On all other ASICs they are identical in functionality to the
equivalent COHERENT flags.

Corresponding Thunk patch is at
https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/pull/88

v3: changed name of flag
v4: added checks for invalid flag combinations

Reviewed-by: David Yat Sin <David.YatSin@amd.com>w
Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c           |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c           |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            |  5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 10 +++++++++-
 include/uapi/drm/amdgpu_drm.h                    | 10 +++++++++-
 include/uapi/linux/kfd_ioctl.h                   |  3 +++
 8 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b5b940485059..ec9e9e95e5f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1738,9 +1738,16 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT)
 		alloc_flags |= AMDGPU_GEM_CREATE_COHERENT;
+	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT)
+		alloc_flags |= AMDGPU_GEM_CREATE_EXT_COHERENT;
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED)
 		alloc_flags |= AMDGPU_GEM_CREATE_UNCACHED;
 
+	if (((flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT) && (flags & KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT)) ||
+	    ((flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED) && (flags & KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT)) ||
+	    ((flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT) && (flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED)))
+		return -EINVAL;	
+
 	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
 	if (!*mem) {
 		ret = -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 12210598e5b8..76b618735dc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -331,6 +331,7 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 
 		flags |= other->flags & (AMDGPU_GEM_CREATE_CPU_GTT_USWC |
 					 AMDGPU_GEM_CREATE_COHERENT |
+					 AMDGPU_GEM_CREATE_EXT_COHERENT |
 					 AMDGPU_GEM_CREATE_UNCACHED);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index fa87a85e1017..c45fde9f1887 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -634,6 +634,7 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
 	}
 
 	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+			       AMDGPU_GEM_CREATE_EXT_COHERENT |
 			       AMDGPU_GEM_CREATE_UNCACHED))
 		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
 			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 671e288c7575..dd135d8b25f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -543,6 +543,7 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
 	}
 
 	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+			       AMDGPU_GEM_CREATE_EXT_COHERENT |
 			       AMDGPU_GEM_CREATE_UNCACHED))
 		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
 			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3d13d0bba7b1..e63d9c39fc35 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1185,7 +1185,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 {
 	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	bool is_vram = bo->tbo.resource->mem_type == TTM_PL_VRAM;
-	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
+	bool coherent = bo->flags & (AMDGPU_GEM_CREATE_COHERENT | AMDGPU_GEM_CREATE_EXT_COHERENT);
+	bool ext_coherent = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
 	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
 	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
 	unsigned int mtype_local, mtype;
@@ -1253,6 +1254,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		snoop = true;
 		if (uncached) {
 			mtype = MTYPE_UC;
+		} else if (ext_coherent) {
+			mtype = is_local ? MTYPE_CC : MTYPE_UC;
 		} else if (adev->flags & AMD_IS_APU) {
 			mtype = is_local ? mtype_local : MTYPE_NC;
 		} else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 841ba6102bbb..25de243ef0a8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1187,7 +1187,8 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	uint32_t mapping_flags = 0;
 	uint64_t pte_flags;
 	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
-	bool coherent = flags & KFD_IOCTL_SVM_FLAG_COHERENT;
+	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENT);
+	bool ext_coherent = flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENT;
 	bool uncached = false; /*flags & KFD_IOCTL_SVM_FLAG_UNCACHED;*/
 	unsigned int mtype_local;
 
@@ -1235,6 +1236,13 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		snoop = true;
 		if (uncached) {
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
+		} else if (ext_coherent) {
+			/* local HBM region close to partition */
+			if (bo_node->adev == node->adev &&
+			    (!bo_node->xcp || !node->xcp || bo_node->xcp->mem_id == node->xcp->mem_id))
+				mapping_flags |= AMDGPU_VM_MTYPE_CC;
+			else
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
 		} else if (domain == SVM_RANGE_VRAM_DOMAIN) {
 			/* local HBM region close to partition */
 			if (bo_node->adev == node->adev &&
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ec437120b083..984fc16577ca 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -150,7 +150,7 @@ extern "C" {
  */
 #define AMDGPU_GEM_CREATE_DISCARDABLE		(1 << 12)
 /* Flag that BO is shared coherently between multiple devices or CPU threads.
- * May depend on GPU instructions to flush caches explicitly
+ * May depend on GPU instructions to flush caches to system scope explicitly.
  *
  * This influences the choice of MTYPE in the PTEs on GFXv9 and later GPUs and
  * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
@@ -163,6 +163,14 @@ extern "C" {
  * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
  */
 #define AMDGPU_GEM_CREATE_UNCACHED		(1 << 14)
+/* Flag that BO should be coherent across devices when using device-level
+ * atomics. May depend on GPU instructions to flush caches to device scope
+ * explicitly, promoting them to system scope automatically.
+ *
+ * This influences the choice of MTYPE in the PTEs on GFXv9 and later GPUs and
+ * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
+ */
+#define AMDGPU_GEM_CREATE_EXT_COHERENT		(1 << 15)
 
 struct drm_amdgpu_gem_create_in  {
 	/** the requested memory size */
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index eeb2fdcbdcb7..f0ed68974c54 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -405,6 +405,7 @@ struct kfd_ioctl_acquire_vm_args {
 #define KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM	(1 << 27)
 #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
 #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
+#define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT	(1 << 24)
 
 /* Allocate memory for later SVM (shared virtual memory) mapping.
  *
@@ -659,6 +660,8 @@ enum kfd_mmio_remap {
 #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
 /* Keep GPU memory mapping always valid as if XNACK is disable */
 #define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
+/* Fine grained coherency between all devices using device-scope atomics */
+#define KFD_IOCTL_SVM_FLAG_EXT_COHERENT        0x00000080
 
 /**
  * kfd_ioctl_svm_op - SVM ioctl operations
-- 
2.34.1

