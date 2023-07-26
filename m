Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6932FC001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 13:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A5110E478;
	Wed, 26 Jul 2023 13:21:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1712410E478
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 13:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkGKArXAknxDHcruysNxtog/xAA+7eddIWzxvsOXQw/9sPFXmConRIcI0tRJ8HHUmyeNBEXR5lUujNJmx/0lVUY6Br06kiv7ajsnddclxfLjxNYTXzHVtrFFxIXKPtkGo1xKbBjo3CngBcFjoYSrIZShEAI0CaiP/K0ZgCrmYAJH7U2VF3ZFtdyq4sdFPyuSf+5oFp38xarTCzJW+50i/af+RdF3mS+iW8duJpD8brCDmOP0g6y+bEMjfwSxQJZM8W7bzOwBDRoa/Aqc2+U6tvPdQKnd6sithjT9Fy6taKXMoixWHjtaotvwMWOIue2dsZjNqa7pL5x9OMnh4O5Suw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxYOJ5L/cs2lP/nt4t4LYDK8o5TJpsf1gjiAk9iILrA=;
 b=MTOuDTOMGUBAi0TS8krjIKqXsChyC8Nmf0V9OnCCfymPdiXJKAjknifcbh4edhofkJx22muylXfxi4dspyJAbHe9QTqtsgPdoWeCayXI5n8Ok74t6AUQE9bI4wXtyrvTtrM+Ka2VwBn24FYIsQBFfWKQmbcxdlIzvQAji2iTNJ9Nj5Yi5H11w9pmh8tjhTJC+7Lld5ymAlmpP0ILCG5FwXyJ1EcT6wunt3k3oVx0UFi3OrAIxemwEi/OWcfYSyTF3jOv0rQCT/YU/xHxU0y/aO08qh/Xispcx3LEV9fFhHHFLAMB7Ez0766ABz8rrARne2XdOCNC5vgIMR2v3ml8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxYOJ5L/cs2lP/nt4t4LYDK8o5TJpsf1gjiAk9iILrA=;
 b=rUoFJ1/iipoRR3EL8s6tzCmSwhsDMFKWkr259F1UWASeG3JJmsIh5DUJfXkkhpag/SQdvbEmWBv0/IvLseeN5iIUzP/XxlsDusm5lTaRF/qHxpELfWYZocmEbOi72NnqoRVgp0Dms8Bus3jeiDExLe7tBB7FAG0zsaP7RSCnfNw=
Received: from SJ0PR05CA0164.namprd05.prod.outlook.com (2603:10b6:a03:339::19)
 by CYYPR12MB8703.namprd12.prod.outlook.com (2603:10b6:930:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 13:21:43 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:339:cafe::b3) by SJ0PR05CA0164.outlook.office365.com
 (2603:10b6:a03:339::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 13:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 13:21:42 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 08:21:41 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Add EXT_COHERENCE memory allocation flags
Date: Wed, 26 Jul 2023 09:21:26 -0400
Message-ID: <20230726132126.2516313-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|CYYPR12MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 87aeb707-5822-4cb4-ed3e-08db8ddb40a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LigPpK/wM29sBvhhQ6AYJdHxm7I+tw7+PIWAd1HeeAdwuDUUIyf3YWyhQBIMkDJuGeNzdTVFmxqbFc3Uz5+TM4O1tcExSyepHLoZMF6Iz5c5BnrO/p+gmKmQ6+BQiPtkw7kV7z50dawrj9IehI/ndmU6weLjNDAJmK3nUu+flkZj81/Ge8lxC6DbwMbptc+g/s5f/by//DgMDlJmCfpm49ofkQNnmbaMtIWe4uxzGg4MVUpHc/ri12sgGmojTCZvxwPC73W4vop7vwBWKQM7I/RfUm+TbGBT/OD3uHI2vwwN+Rv0pcWbsTJNeNVOB9HTwIQOmPkqDzeLjr8GvTkIlQivLxhfZ+Ojfe8Zdmt5dXw7wjT/Bsjqz05QCKNW104pqrISN8vu1YqjTGbH+x2fXIkBUJU8dbkq/jW9b/Fd1ePXeVRmh8+Q/TitKiKZbgGFgZ+0Q//au7xy7elqyLCnmsbfpxczU5skWERI/GTjIHzsg4o/DuAd1qlpc2VYJL30G40UftQfcBA5YKY1iT6nplcJfALT3B1RvC3MTbhkYwobT2TZi5kvp58txy0u21qqs+3jn8uo8JwUuR4QQnOGvoUEIaD6nNl6lmZo0jtRGrXJW5NN8X83mVZ8zMp7EBsv8gnUPKx9FrvioSvEzKLfSPuorc9w4ZDJ4ACuN+YIpo1kWyoz4NiMMUCJF8TjM2I43ViavXQlPHIgHPKVGbUGtgqdTMUgNF0dexXJ/yuqniIYtNR2d+LrUqqWaQc4f63i8Qj01Xk58bnUhQ98B91MQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(1076003)(7696005)(6666004)(36860700001)(47076005)(16526019)(186003)(426003)(336012)(83380400001)(36756003)(86362001)(2616005)(81166007)(356005)(82740400003)(26005)(40480700001)(6916009)(4326008)(70206006)(70586007)(2906002)(316002)(5660300002)(41300700001)(8676002)(8936002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 13:21:42.4246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87aeb707-5822-4cb4-ed3e-08db8ddb40a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8703
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
index d34c3ef8f3ed..7f23bc0ee592 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1738,6 +1738,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT)
 		alloc_flags |= AMDGPU_GEM_CREATE_COHERENT;
+	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENCE)
+		alloc_flags |= AMDGPU_GEM_CREATE_EXT_COHERENCE;
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED)
 		alloc_flags |= AMDGPU_GEM_CREATE_UNCACHED;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 6b430e10d38e..8e951688668b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -632,6 +632,7 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
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
index 880460cd3239..e40fcfc1a3f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1183,7 +1183,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 {
 	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	bool is_vram = bo->tbo.resource->mem_type == TTM_PL_VRAM;
-	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
+	bool coherent = bo->flags & (AMDGPU_GEM_CREATE_COHERENT | AMDGPU_GEM_CREATE_EXT_COHERENCE);
+	bool ext_coherence = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENCE;
 	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
 	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
 	unsigned int mtype_local, mtype;
@@ -1251,6 +1252,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		snoop = true;
 		if (uncached) {
 			mtype = MTYPE_UC;
+		} else if (ext_coherence) {
+			mtype = is_local ? MTYPE_CC : MTYPE_UC;
 		} else if (adev->flags & AMD_IS_APU) {
 			mtype = is_local ? mtype_local : MTYPE_NC;
 		} else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 1b50eae051a4..28304b93a990 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1155,7 +1155,8 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	uint32_t mapping_flags = 0;
 	uint64_t pte_flags;
 	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
-	bool coherent = flags & KFD_IOCTL_SVM_FLAG_COHERENT;
+	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENCE);
+	bool ext_coherence = flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENCE;
 	bool uncached = false; /*flags & KFD_IOCTL_SVM_FLAG_UNCACHED;*/
 	unsigned int mtype_local;
 
@@ -1203,6 +1204,13 @@ svm_range_get_pte_flags(struct kfd_node *node,
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
index 79b14828d542..d67102dc214a 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -158,6 +158,13 @@ extern "C" {
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
 
 struct drm_amdgpu_gem_create_in  {
 	/** the requested memory size */
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index eeb2fdcbdcb7..dd8f0dba7631 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -405,6 +405,7 @@ struct kfd_ioctl_acquire_vm_args {
 #define KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM	(1 << 27)
 #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
 #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
+#define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENCE	(1 << 24)
 
 /* Allocate memory for later SVM (shared virtual memory) mapping.
  *
@@ -659,6 +660,8 @@ enum kfd_mmio_remap {
 #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
 /* Keep GPU memory mapping always valid as if XNACK is disable */
 #define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
+/* Fine grained coherency between all devices using device-scope atomics */
+#define KFD_IOCTL_SVM_FLAG_EXT_COHERENCE       0x00000080
 
 /**
  * kfd_ioctl_svm_op - SVM ioctl operations
-- 
2.34.1

