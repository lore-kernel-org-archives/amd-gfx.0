Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24013C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 14:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC7510E320;
	Mon, 24 Jul 2023 14:15:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D46C10E320
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 14:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyCcskeXQNHtGCqEsgQ29jrOvYGUbjK8SPqsopehEgVM0mDSZfOwCTk8C+3TpAzpc8sm/6IOkSXRpmZ1RBSC4jDkL7JVkBZIZbTDi0FO3Y4RD337OLnsAe3SYDtFMgsTip+bnTsYatOXGn42qXJTwC/Jn3wb+3uljNlRbOD/ugHvhs93iXYwsSIyah4VNClP+acsBi14/pTezHNlpUJy9bDK93FfhYbQGH9CwQHp8Yq+rOGW4pWdAqXT+JcCGCU8bCOX6Q/gsj1AQ1RdqkRa3wdjaTmC270wWWxHGpmRsHbNaZfr0Lr7bmnBhQyrHYJlPlK0pscEGlhz1eWywej+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN3kj8GVA6iKKuNdvACjMN1F5qKldTgvTCwkUUV1Npc=;
 b=Ias60JTOK7B49IWYodzS/GuGwDPwAgXW4yzsWlexqau1mrPEpi5KKIPW/R8SB5K0tRQ4tQ/CRf57duRKkpjjbCmJE4lllhVBwKEj3BTLyl38Z4UG4RyOfFJoggdmXenSK2pBX2HxkdZhfR4VmrE0zMvA7aI25wFB7JeCYgpLnWPejuP0FQKotLB77mMWtW34ZwHU7tO6DpNaXgAz3jRMvlP1RTXLRd/0bmzH5YqEjEpFqWvcOewQX642jmWouXLVzmAb2VgnYovpu5ayNJz1FbY/RrX8S2pC9SFmPemEiIkSHowtwi9yOyMp6Gr7TVx73oSXhwzT7Lu3Cjjllf725w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN3kj8GVA6iKKuNdvACjMN1F5qKldTgvTCwkUUV1Npc=;
 b=puqG1JMzX19G1+Qtwi2P0WON3BfbebFxhkzZsf9WCvTKL6wp1lbW+wdD/j7RRqtfXxMh5WamVy7wSmmoSMzPjkfxUtW7Brl0lClogsk4SlDUONGEpFfJkd3p3+9imLLLZWXJJo6gu3BUBhzFLlMgIO/zDIYGwo30KuxGZJ9lWjg=
Received: from MW4PR03CA0014.namprd03.prod.outlook.com (2603:10b6:303:8f::19)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Mon, 24 Jul
 2023 14:15:06 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::4d) by MW4PR03CA0014.outlook.office365.com
 (2603:10b6:303:8f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 14:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 14:15:06 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 09:15:05 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add EXT_COHERENCE memory allocation flags
Date: Mon, 24 Jul 2023 10:14:45 -0400
Message-ID: <20230724141445.2451975-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724141445.2451975-1-David.Francis@amd.com>
References: <20230724141445.2451975-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: c296ab53-9d42-4bff-ff30-08db8c506175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCDd+7Bv9aVZ/xrgngSSGccBi1LLOYZ74pVo6ZeyyU5z1LCyIj+XzzYxo9rK8+JUjJrSL8jLg4zlmtRz5YG1p2CwvKNWt5cBhqD8RH/7kGjcCjHttVo87eI8EANzUPp5HWLEEPV6iIfL687fC+aIGUzJCmiOcFRCIvx4p01QS/nL/6NqFaY26hvSZFod/sEugxIz85Mv6eqVvIQNmvkE9m69NrOCHBCLiE/kVWEPeNVvgFQrEeGe9d+AgQ+dgg3KEGw/B7ZWVu2EKNeX93wOkbayEP7OkJAbROMWygWt41ModA8a5tGa7JE1Ma5kTjbK/Umk7ply49bamtUntpt2/6LOwLHvpZVdrnt2NW6gfNR5Rq69Wc3xb/LbYL6yB/sUPTP+Xr+hX9HBs5Zd3315JVsfQbBZFUAO370Puvgpb2curJh+s9QAG9BLp2Cv/fmfIt7KRTC1Ynm6xEuLEq31qtpqzdHhf3XEsiOrROchN4Sr2wA8nDv7cADDZ6UrJlsXBNfT6Giz6Uhae67YcpEpcAHaKM/Dd67CJYLRt+Cxb3jDr0V7mYMTdA5FH4BuoG4AUkU3FMqtwp4xQTgOgO1dQO8OMt4QXTbjLxYw+G1QHDAe8WlKBZ/GqOXyNhVqSIRx7UalA6D7FkgLtvWNykMYZGrIAgqfQO9+LBhJ1HE0+nK0DhtZTbc6dCQ92tg4uNJscEvv+Is6eJGqwFaHf8qKrVJRy/nkB7kSyPSu2IhDFLPNOCFWNYMfn6Vaj736L1+jP4gQTOhHdz2EwFQ3iS+rLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(83380400001)(36860700001)(40480700001)(40460700003)(2906002)(2616005)(47076005)(426003)(82740400003)(356005)(81166007)(70206006)(70586007)(4326008)(316002)(6916009)(41300700001)(1076003)(36756003)(336012)(186003)(478600001)(26005)(16526019)(7696005)(6666004)(5660300002)(8676002)(8936002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:15:06.1733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c296ab53-9d42-4bff-ff30-08db8c506175
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693
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

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c           |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c           |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            |  5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 10 +++++++++-
 include/uapi/drm/amdgpu_drm.h                    |  7 +++++++
 include/uapi/linux/kfd_ioctl.h                   |  3 +++
 7 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 9e18fe5eb190..67634e9f6466 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1790,6 +1790,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT)
 		alloc_flags |= AMDGPU_GEM_CREATE_COHERENT;
+	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENCE)
+		alloc_flags |= AMDGPU_GEM_CREATE_EXT_COHERENCE;
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED)
 		alloc_flags |= AMDGPU_GEM_CREATE_UNCACHED;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 1c07459e2bd2..6a6f6068bea0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -631,6 +631,7 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
 	}
 
 	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+			       AMDGPU_GEM_CREATE_EXT_COHERENCE |
 			       AMDGPU_GEM_CREATE_UNCACHED))
 		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
 			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index a6ee0220db56..ff330c7c0232 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -540,6 +540,7 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
 	}
 
 	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+			       AMDGPU_GEM_CREATE_EXT_COHERENCE |
 			       AMDGPU_GEM_CREATE_UNCACHED))
 		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
 			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8447fcada8bb..17cf19c868e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1180,7 +1180,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 {
 	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	bool is_vram = bo->tbo.resource->mem_type == TTM_PL_VRAM;
-	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
+	bool coherent = bo->flags & (AMDGPU_GEM_CREATE_COHERENT | AMDGPU_GEM_CREATE_EXT_COHERENCE);
+	bool ext_coherence = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENCE;
 	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
 	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
 	unsigned int mtype_local, mtype;
@@ -1248,6 +1249,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		snoop = true;
 		if (uncached) {
 			mtype = MTYPE_UC;
+		} else if (ext_coherence) {
+			mtype = is_local ? MTYPE_CC : MTYPE_UC;
 		} else if (adev->flags & AMD_IS_APU) {
 			mtype = is_local ? mtype_local : MTYPE_NC;
 		} else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 909f1ef8927d..acb87b2fe8df 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1157,7 +1157,8 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	uint32_t mapping_flags = 0;
 	uint64_t pte_flags;
 	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
-	bool coherent = flags & KFD_IOCTL_SVM_FLAG_COHERENT;
+	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENCE);
+	bool ext_coherence = flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENCE;
 	bool uncached = false; /*flags & KFD_IOCTL_SVM_FLAG_UNCACHED;*/
 	unsigned int mtype_local;
 
@@ -1205,6 +1206,13 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		snoop = true;
 		if (uncached) {
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
+		} else if (ext_coherence) {
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
index 3b98635bdfa8..7dbee3e3d9d1 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -173,6 +173,13 @@ extern "C" {
  * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
  */
 #define AMDGPU_GEM_CREATE_UNCACHED		(1 << 14)
+/* Flag that BO should be coherent across devices when using device-level
+ * atomics. May depend on GPU instructions to flush caches explicitly.
+ *
+ * This influences the choice of MTYPE in the PTEs on GFXv9 and later GPUs and
+ * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
+ */
+#define AMDGPU_GEM_CREATE_EXT_COHERENCE		(1 << 15)
 
 /* hybrid specific */
 /* Flag that the memory should be in SPARSE resource */
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index e467ac678ba9..7a4041ee5951 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -416,6 +416,7 @@ struct kfd_ioctl_acquire_vm_args {
 #define KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM	(1 << 27)
 #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
 #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
+#define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENCE	(1 << 24)
 
 /* Allocate memory for later SVM (shared virtual memory) mapping.
  *
@@ -777,6 +778,8 @@ struct kfd_ioctl_cross_memory_copy_deprecated_args {
 #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
 /* Keep GPU memory mapping always valid as if XNACK is disable */
 #define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
+/* Fine grained coherency between all devices using device-scope atomics */
+#define KFD_IOCTL_SVM_FLAG_EXT_COHERENCE       0x00000080
 
 /**
  * kfd_ioctl_svm_op - SVM ioctl operations
-- 
2.34.1

