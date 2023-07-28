Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C6BC001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 19:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D3410E786;
	Fri, 28 Jul 2023 19:40:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B935D10E786
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 19:40:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuZcHn5eN5eFdhn8kv7VXly3X6FW1jyRum6mBdzHVd1N5p6Z1I0+sYH5lg0lrsmgxcmkr0tK2vpz7eKPDYMVZLz4nrf7Cd/Ce8kC2wLRuZwCLLysNvFTCvLp2aHbJcONw2gK2fENNyO7Wj0E/TCJ7Np4kxqQCRIcyINIcJvgcjVxKwTeGdY7/xw/OcpNjesptGUTQ2O+E+6LoDzHunMz/WDP7n6IJkTJVKqTq5zrXTKueDJq2sQbUBtDLfANKawLrRgn17B7oCpFPikaJrkjl0OD8pevDlhKEUUxZIJ5hP9H/h0R+X077nlUYAUv8VKPPc9Rwd8plTenYYeY+LLN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrIPmbogSMi1iw0QZKQpo9OmRFQ+cqqY7N/3IV+8zrk=;
 b=Tv1+7zspr06rccdDB30ZNalOf7SES1EE3SR7/qxy49/n+gelYQUsHwbt7q+bHwRh0t/Nsds7IlFbq1PmE9W8g3SyYTCUNy09chf7q73IS38EnUepiTMRMKX9v+28a3f/GJrLTYQYhuXDcKoFxuY/AsSXJ7QYIoS3BuN0+gq0Cjsfo4YhcGJza0adMyQ6RSde/mZZPTDxUKihEpp+k9fetkwkV9EaH/kGRDbxZAsaHu1mUE26T0wb7Tp9PybvsXqGuDPFHYbyJ1i9n8hgeuj0uBImk0sfKndWwR0W7DbAdvwOsdyvDRKFLqTtI39c6cKRybYDuUCNnUXEF3EaFtbsSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrIPmbogSMi1iw0QZKQpo9OmRFQ+cqqY7N/3IV+8zrk=;
 b=DX8urt4ECwe/vaULvyxGNqQujwOXNOzN6EUECc5smTfY8ntZqGbhJiO0RzMgKf3bGX1DQ7sdjUBDu4DDA7loOURJ88RdyAsW5BJbq5a3jFTlaL5JryyIrx2J5w253doXWImi6WjLwtJAptt3rOm+C9tUC3KyKfY+2XJk9BPGo4k=
Received: from CY5PR15CA0175.namprd15.prod.outlook.com (2603:10b6:930:81::20)
 by CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 19:40:09 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::d0) by CY5PR15CA0175.outlook.office365.com
 (2603:10b6:930:81::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 19:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Fri, 28 Jul 2023 19:40:09 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 14:40:08 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: Add EXT_COHERENT memory allocation flags
Date: Fri, 28 Jul 2023 15:39:55 -0400
Message-ID: <20230728193955.2607848-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 06459f3e-700a-4b8a-5239-08db8fa273d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QORKHbgaSjk3jwsJA98VqT6Ew6V3Du5rX53vmgPTa5WMN9iDGALARpk2r6X8D7g8Eg/TIaoJG2OMd08Q2GE9JTVBWy10TayFcNbt2/Slhah2rmC9nv1wrIPNPRgPo1jQmEXlUYWH1gdZvpRIKYpWUv8o1vi/4YKbcUXaW2tUplZ3ZkKmSE/fHA20n1jDMDMrA7PD+c7soL7qwaZm5HLZExdGWziM8vGGtMYmkFI9D0K7fmeH6iRJW8ussSYLqqPgpSrdjjOJ1LDw7K+zikFxrSfn3+MeIedjm2I4sryr2AcCpqcmB9XgE3axw/BWoAl5lm60XNVHrdfkDhkSvQuiCy6Zo7JpCxfoPLQxFRmUuuXDNBIR8JJASMss38GTVJ1s3g/jfFH08wmmxPEEebvLzs1NUQuX/0wgL0yI7h9Tq0bwhtb3YMONI3KnF8Q5hwRDfv4gdXJqR0fpZIBx2fZytPZ64bbwfqfFXartPjRwU95DqvfohlMQcnQsR/Vdac959SD6Mwd0jlCcJ/Ltg7ThomF9ADcs57e4pc5gABon8Sdl8dUw+c7Bv3U7nWG8laK2BhY6Gh76rlPFH0RQc9O05fnwzbJGhmTXGsBGn1XDK8EmUJhK4uUS3y3sI8h4PfHgihy7FaS6MIZk/PH9WtkkuLRo3RV287nUDCk1wS/sWC3BGccjAIDvcaw2B8dhw43PQwCJAdYRbB0BxwH7HQ8Tgyed7uH6Z7jtZcs0GBibJy1Uu3NC9s8BRYt5qJcn0JWbX7mgbdMFCxyz70os8VpZyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(186003)(1076003)(2616005)(426003)(26005)(41300700001)(47076005)(16526019)(336012)(36860700001)(70206006)(70586007)(6916009)(5660300002)(4326008)(83380400001)(8936002)(8676002)(316002)(966005)(7696005)(6666004)(478600001)(2906002)(40480700001)(82740400003)(81166007)(356005)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 19:40:09.2797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06459f3e-700a-4b8a-5239-08db8fa273d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535
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

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c           |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c           |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            |  5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 10 +++++++++-
 include/uapi/drm/amdgpu_drm.h                    | 10 +++++++++-
 include/uapi/linux/kfd_ioctl.h                   |  3 +++
 8 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d34c3ef8f3ed..a1ce261f2d06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1738,6 +1738,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT)
 		alloc_flags |= AMDGPU_GEM_CREATE_COHERENT;
+	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT)
+		alloc_flags |= AMDGPU_GEM_CREATE_EXT_COHERENT;
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED)
 		alloc_flags |= AMDGPU_GEM_CREATE_UNCACHED;
 
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
index 6b430e10d38e..301ffe30824f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -632,6 +632,7 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
 	}
 
 	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+			       AMDGPU_GEM_CREATE_EXT_COHERENT |
 			       AMDGPU_GEM_CREATE_UNCACHED))
 		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
 			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index a6ee0220db56..846894e212e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -540,6 +540,7 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
 	}
 
 	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+			       AMDGPU_GEM_CREATE_EXT_COHERENT |
 			       AMDGPU_GEM_CREATE_UNCACHED))
 		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
 			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 880460cd3239..92a623e130d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1183,7 +1183,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 {
 	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	bool is_vram = bo->tbo.resource->mem_type == TTM_PL_VRAM;
-	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
+	bool coherent = bo->flags & (AMDGPU_GEM_CREATE_COHERENT | AMDGPU_GEM_CREATE_EXT_COHERENT);
+	bool ext_coherent = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
 	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
 	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
 	unsigned int mtype_local, mtype;
@@ -1251,6 +1252,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		snoop = true;
 		if (uncached) {
 			mtype = MTYPE_UC;
+		} else if (ext_coherent) {
+			mtype = is_local ? MTYPE_CC : MTYPE_UC;
 		} else if (adev->flags & AMD_IS_APU) {
 			mtype = is_local ? mtype_local : MTYPE_NC;
 		} else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 1b50eae051a4..e9ffcfc5dedc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1155,7 +1155,8 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	uint32_t mapping_flags = 0;
 	uint64_t pte_flags;
 	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
-	bool coherent = flags & KFD_IOCTL_SVM_FLAG_COHERENT;
+	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENT);
+	bool ext_coherent = flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENT;
 	bool uncached = false; /*flags & KFD_IOCTL_SVM_FLAG_UNCACHED;*/
 	unsigned int mtype_local;
 
@@ -1203,6 +1204,13 @@ svm_range_get_pte_flags(struct kfd_node *node,
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
index 79b14828d542..629860dbc9ec 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -145,7 +145,7 @@ extern "C" {
  */
 #define AMDGPU_GEM_CREATE_DISCARDABLE		(1 << 12)
 /* Flag that BO is shared coherently between multiple devices or CPU threads.
- * May depend on GPU instructions to flush caches explicitly
+ * May depend on GPU instructions to flush caches to system scope explicitly.
  *
  * This influences the choice of MTYPE in the PTEs on GFXv9 and later GPUs and
  * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
@@ -158,6 +158,14 @@ extern "C" {
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

