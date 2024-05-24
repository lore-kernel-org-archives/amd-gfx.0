Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE49DC25B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 May 2024 14:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1738310E249;
	Fri, 24 May 2024 14:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nXKaSptz";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7240210EA9E
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 14:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kxms76hYpZ1elvHFc4VfvJbU7lDVPRIle5PxBjSNWioZfdtBB3Hi3zQBI+xFm590jh3ShFrcKAiBQaeuuJ/GpcADaN/VcXiSxWrIYysLLJHTipVLWn6ZNBz+X2OeccuO4m2Tnok/JeiQ2PD2nI61taefL3wRWoCwxHSQ0z2NvbTJJPGmHAOTqhopNxsbUPy4jiQUYASp6j40pwr5yp9cpoYVepcaFjBlcJbFe41VRAWQAJeB/iA9kJJGxoNY5881Pb/P3+CnE2qak+STd+NuNU31Zg9P0iuK5dCv3IiXvaffuFd4DcJDM59Hy8jzXZ5UvTv9SdC7tqLi48Pu0HpwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNGxUir1RRhj2rGlsllOPts8OqlvZsEgjvJ7QsYld0E=;
 b=dvU8Nz4DVJXKFn4PwvEi7tlwlpFMu0Q9BlU1F1FuEqQPLdNIOSEu2EkUIKUGmtSIHYLfRQ6iR23yoXbPUFEMLoi9IbNjDiM8R/SCof6Rb8v7nWCU5aD8TkhKxePFWeehejw9ZEbSTMJabT4H65BnRihRkMq7o7Q4uANt4haraqdiUg0+Fu3gjDv9HWW0ksZDCDsw8KMxkpt/KMOqv9ULAGwLFPp+KUbXZFQOqH4Q8ql7PHpfBRiZGSiWZM0rTBuL+A5mJ5s5+NcTSyIXV3Hto/+Ot6dXW3zB2hmSCJ/fFLk96dCpyImqISYqFhdvawlxTTifHdh/nTWqDm7nMmm8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNGxUir1RRhj2rGlsllOPts8OqlvZsEgjvJ7QsYld0E=;
 b=nXKaSptzhxCOtn1qWzdPRBuKnLrPQl09RwxHBLXpZkNsWPZs4Q3LjEJpvaartpo97zY2VOgJULQEGqO11B2C/hbaJqMRS0DFZGiMI10NgBdmA5Te5dCoCNit/Ue3TQRla5Hv6+KErN8zbku45rzPE4gB5EJw5evfz1ebbPw3Td0=
Received: from DS7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::25) by
 DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Fri, 24 May 2024 14:08:27 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::50) by DS7P222CA0022.outlook.office365.com
 (2603:10b6:8:2e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 14:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 24 May 2024 14:08:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 09:08:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: simplify APU VRAM handling
Date: Fri, 24 May 2024 10:08:07 -0400
Message-ID: <20240524140807.3186797-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: bc234458-39b6-489e-b773-08dc7bfafb94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MjV0TE2gNammQJMqjWAe+EELyXMZtHWOBnD9CbUdMMaW63K0bxAvPA8dS6EV?=
 =?us-ascii?Q?YOkPkB3PPdnqFSJJJsIHgK+PVzyzJ81HkAhmkDgiJMjl/XdpUow0sG/+B470?=
 =?us-ascii?Q?yEYaszuq8LflIfciMO5bCeYj2js3LSeKhaUyvpXOk02aFPLWvQpSiHpf+k1N?=
 =?us-ascii?Q?2NnJ6PAkKNx80RqFSkrizwUw6VHg669PptdPoWxOPnEC4vrXOqvqVXT2WRLx?=
 =?us-ascii?Q?zHmnWen4+PwYJBM3LZ5WZVw1xdO9R9KGDsCAWlN5VpX6XVDQEScuJsYdDkk1?=
 =?us-ascii?Q?CLKYOLgyWLcfGRUtO6zctnvDLk0oOuOapTY5xBx32PI+GLKovGB4GWboLuA8?=
 =?us-ascii?Q?JGdx0TCRtFUHcUvqxKK0AO3L+DOVKAeexK1J0Q/r+ahOAxMwDYVyeTsaafw6?=
 =?us-ascii?Q?Ii7Gg2ow0omaGigf3kpRCztyBiskVIeZNEOzqF30WYkFdHTRoDAKJKsZSyP/?=
 =?us-ascii?Q?rR4jptDjh1V/CyxwPKX59IIc6xzgdfKdr1OreByM3OohVDH1mS2IzcYGUUBO?=
 =?us-ascii?Q?G9iMcGNMBtnqutIhCpeSSLSgi6GXlKwUsTXg+RvVyD157i/JTOTxEqmtIk3d?=
 =?us-ascii?Q?llLlkKRR991Gz5NYyUQ70Pj/KtL1p6gpiwCjV9Bbey3bGiSn7lX64Dr9oH2G?=
 =?us-ascii?Q?/pBsblowjU3hu53s0uyoD7fky97DtyrBZVqQabP9La4K57wds2j6M8X/cygo?=
 =?us-ascii?Q?H7mNtyDL3OhDGOIGzs4GwunIhq9H9u4t8lclTds99JzM44VjnOiPRnO2ARn5?=
 =?us-ascii?Q?GGjS9A2OqlPktYebQMMzzMouILo54U0h4FN7TYsThytZzcMbisvof+VGg1Oi?=
 =?us-ascii?Q?T/D0SRirouPguVq581K/GF2XeU08V3cbMnw4W8+CqAY3swfL7BJ0JfIA47BF?=
 =?us-ascii?Q?sEtia+8ynB4tQnJkKz64do5G4oDW/xs3ia44hr2CXcbamsgay3LH+nG5HE1q?=
 =?us-ascii?Q?d1CYitCe15u1PbgvCwfNr/MqwJqbvdWdad9ZIDHRN7ENjqVXR6vgz5b/O9pm?=
 =?us-ascii?Q?wAJ8mNywNS790beEvYX0VYPdYp9DVa3V6qWE5qQF4yb0F74HXZJpVF/yzQjF?=
 =?us-ascii?Q?p7oSrxcVnmrqov/BRG0uzpjQZu4w+G8QZXAWtIwTbv2/P/R54nCQyNoniYI0?=
 =?us-ascii?Q?fRnJMLLNRYxGegpyV/Cin80ahfGxfhF+pyF+E21M9NLQX4FxDkPDAZ6vGu9R?=
 =?us-ascii?Q?7fgrRS20HOyOQk6Ok4iASi0TeEhKa3ouzs3ZguHuS51rOoiMS3Zl13zkAo9z?=
 =?us-ascii?Q?HmDBrwh+T5W6sOH5DIREoTZCttN6vymr+EUQX0ccxOsu0z0SD4y2VTEPhb3B?=
 =?us-ascii?Q?bbuEZolWplmuvn4iPxisK+yFkMWDafRnGu1pKtpCy+vzVkqT7qTcMKRCZIqB?=
 =?us-ascii?Q?zkXitmbtxx/uBHIJT/Xn/BAM+B5j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 14:08:27.2010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc234458-39b6-489e-b773-08dc7bfafb94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276
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

With commit 89773b85599a
("drm/amdkfd: Let VRAM allocations go to GTT domain on small APUs")
big and small APU "VRAM" handling in KFD was unified.  Since AMD_IS_APU
is set for both big and small APUs, we can simplify the checks in
the code.

v2: clean up a few more places (Lang)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  6 ++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h             |  1 -
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 336eb51c4839..3af00b57cd8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -196,7 +196,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 			return -EINVAL;
 
 		vram_size = KFD_XCP_MEMORY_SIZE(adev, xcp_id);
-		if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
+		if (adev->flags & AMD_IS_APU) {
 			system_mem_needed = size;
 			ttm_mem_needed = size;
 		}
@@ -233,7 +233,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	if (adev && xcp_id >= 0) {
 		adev->kfd.vram_used[xcp_id] += vram_needed;
 		adev->kfd.vram_used_aligned[xcp_id] +=
-				(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) ?
+				(adev->flags & AMD_IS_APU) ?
 				vram_needed :
 				ALIGN(vram_needed, VRAM_AVAILABLITY_ALIGN);
 	}
@@ -261,7 +261,7 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 
 		if (adev) {
 			adev->kfd.vram_used[xcp_id] -= size;
-			if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
+			if (adev->flags & AMD_IS_APU) {
 				adev->kfd.vram_used_aligned[xcp_id] -= size;
 				kfd_mem_limit.system_mem_used -= size;
 				kfd_mem_limit.ttm_mem_used -= size;
@@ -894,7 +894,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 	 * if peer device has large BAR. In contrast, access over xGMI is
 	 * allowed for both small and large BAR configurations of peer device
 	 */
-	if ((adev != bo_adev && !(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)) &&
+	if ((adev != bo_adev && !(adev->flags & AMD_IS_APU)) &&
 	    ((mem->domain == AMDGPU_GEM_DOMAIN_VRAM) ||
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
 	     (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
@@ -1682,7 +1682,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 		- atomic64_read(&adev->vram_pin_size)
 		- reserved_for_pt;
 
-	if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
+	if (adev->flags & AMD_IS_APU) {
 		system_mem_available = no_system_mem_limit ?
 					kfd_mem_limit.max_system_mem_limit :
 					kfd_mem_limit.max_system_mem_limit -
@@ -1730,7 +1730,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_VRAM;
 
-		if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
+		if (adev->flags & AMD_IS_APU) {
 			domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_flags = 0;
@@ -1981,7 +1981,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	if (size) {
 		if (!is_imported &&
 		   (mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||
-		   ((adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) &&
+		   ((adev->flags & AMD_IS_APU) &&
 		    mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))
 			*size = bo_size;
 		else
@@ -2404,7 +2404,7 @@ static int import_obj_create(struct amdgpu_device *adev,
 	(*mem)->bo = bo;
 	(*mem)->va = va;
 	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) &&
-			 !(adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) ?
+			 !(adev->flags & AMD_IS_APU) ?
 			 AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
 
 	(*mem)->mapped_to_gpu_memory = 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 4816fcb9803a..8ee3d07ffbdf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1023,7 +1023,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 1))
 		return -EINVAL;
 
-	if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)
+	if (adev->flags & AMD_IS_APU)
 		return 0;
 
 	pgmap = &kfddev->pgmap;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 28c2c1b66226..407636a68814 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2634,8 +2634,7 @@ svm_range_best_restore_location(struct svm_range *prange,
 		return -1;
 	}
 
-	if (node->adev->gmc.is_app_apu ||
-	    node->adev->flags & AMD_IS_APU)
+	if (node->adev->flags & AMD_IS_APU)
 		return 0;
 
 	if (prange->preferred_loc == gpuid ||
@@ -3353,8 +3352,7 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 		goto out;
 	}
 
-	if (bo_node->adev->gmc.is_app_apu ||
-	    bo_node->adev->flags & AMD_IS_APU) {
+	if (bo_node->adev->flags & AMD_IS_APU) {
 		best_loc = 0;
 		goto out;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 9c37bd0567ef..70c1776611c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -201,7 +201,6 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
  * is initialized to not 0 when page migration register device memory.
  */
 #define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
-					(adev)->gmc.is_app_apu ||\
 					((adev)->flags & AMD_IS_APU))
 
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
-- 
2.45.1

