Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C9FE7E64E
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 16:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5467610E409;
	Tue, 26 Sep 2023 16:40:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F59710E229
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 16:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krsHJvnYI6Cb1rcwcciVSn0PBrBKp4305QGIlLwEtaz99eDymJ98IsGywxnl0Y6KjBXsxt4ei+CLy/3tdH86w1qsVvgQorLAlav/Xff3fZprrizVlPFba6d8iBYr6BP9zELqq+lqVLlqQjMqPKQzv5n+XYC2HRG/Ijx49BMvi4HH6pwZ9Hf2y2Ey89UAQra4eU5jUMb1VNWrONkDqdd9LEu5AHOp4L/FTU30DzK3pY9wNIsjXoWshGRjwSeFbWD7/tWswPleUURhDF7gnMeWhn3w5mEcLic942r48D7DBvK/CXIqSg4oT2q0tpb/KF0CTnj4WMe4gSD6o9/6Ktha9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKHvSaETNO/7FM2Lfb9GMon81l2FSO88Q+R00znnBjE=;
 b=ld0SPN37dV4cd6w3U1niK8SHY4qVUnYFiPHgq7ViKwscXLRYoGgviH9m/PYxU9budE3B+UtMMlIVGE9PRYyz8MmOrlYVgpHYnI+fpVFPkQDVPj01jiswu8GHcBeWbtiuElYJjJ5e78K/Oe/MmeCNq+MXmmFZRT20JYHJDC1MxSWrro8jdiLxzRzNi5Plkn6NGvSZmJmPSc6fOsPEPQXfT/wA5UE9lY2AUpV+vScJVpnIsjjOF9hiIs25aBIkJU0gVgnSy4S6PMAo2wWOoqUatgM/9rlK1ca4pzaqDJ66DdT9AX4p3oXdrHcVTBkjRkQLeMMp33j9XdT26GYF1QNPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKHvSaETNO/7FM2Lfb9GMon81l2FSO88Q+R00znnBjE=;
 b=dXcka5ClseeEYLYfVddDXLEVHrvtIfa7B/FKK6iwu4MVWF/1tXdQ7OLAI7ZxG27S0u2qhiMHPgihsjYk9vWey+dXnjCTJifFxLsPSF5qpnxmDQocYjXz/l6BRKQAjMeIqzbbCW6RysIQrPp9SuauA1xZ4EYHEcJ9oPXL+PGQ3rY=
Received: from MN2PR11CA0001.namprd11.prod.outlook.com (2603:10b6:208:23b::6)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 16:39:54 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::67) by MN2PR11CA0001.outlook.office365.com
 (2603:10b6:208:23b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 16:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 16:39:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 11:39:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: drop struct kfd_cu_info
Date: Tue, 26 Sep 2023 12:39:38 -0400
Message-ID: <20230926163938.1013775-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926163938.1013775-1-alexander.deucher@amd.com>
References: <20230926163938.1013775-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 89823568-39ac-4522-bef4-08dbbeaf3642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3SCMHYM8GroVmZlwT7zIMYtvdRHPmBZXhDInlsQBlLv31LohKtGW6oG+QL17AyKIjdBoSmVPTyYKMkn9KYH/T26z314lErFJi/nC73nbn7uXf6WMJpY/PoB3SIlb2h7aFyE1+1o096D8flWgFzMF7RubM9e25ldEGZdpDlOuv+BRkUTSGc8STGn052yoEmEC5RN+eurzUdIgTytr+J++5/kM79lVnxOI3PKeWG4CZsD+88Oq76ULDjVgh95tNqbLcaLQILU87MY6X20o2Zs5qsi4L7WTYAmNKxo96KdLyDka9oNPaM530kX3V7vSgTjo636gTwFSvpI0YM6eOl6FAPUMgAgl4aI6fAeVleMD6myBfXQNxG8CdxgOnK/Ns0f+VjwfO/tfgGJbr53HTWNUEcNZ2y7iRAlXfIHVLcUGbBF+ouj24qjEa0wc65GtWZOwwCirsbPjBsVdS+X1WChYj62kXY+kzGbB7z31BdsS+qr51ylOjoBMBANuK2+L14UBzE6A6HuzGgAnxXiQqHM0FaXeEBEzAc3vEaBGyWhb2IfW90k4WHN159l1YRDWJFUw/tv+1cwvWNjoVIKHUhybY+NNLF6YWDp9Zt9dJHaqpGFsxSESSp870AzTmwxpqCoVg+xnQIGNaVA7O6PDNBCFRFai+Y7ZTT5o74a2cJRy4cL4uarS4V/lLG5zv41DuVEVrc5doY1f1qSpVBvnZPwqQ/Qz5K8+KRrRrQWZtiOkaWGzaB1WP6mcUw4Q4Rpte15lGB8uLg92mxyDFu5VJrJgcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(40470700004)(36840700001)(46966006)(36756003)(356005)(81166007)(40480700001)(40460700003)(86362001)(82740400003)(6666004)(30864003)(2906002)(54906003)(70586007)(70206006)(2616005)(478600001)(316002)(8936002)(5660300002)(7696005)(8676002)(4326008)(6916009)(41300700001)(36860700001)(83380400001)(47076005)(1076003)(26005)(336012)(16526019)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 16:39:54.0863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89823568-39ac-4522-bef4-08dbbeaf3642
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Arnd Bergmann <arnd@kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I think this was an abstraction back from when
kfd supported both radeon and amdgpu.  Since we just
support amdgpu now, there is no more need for this and
we can use the amdgpu structures directly.

This also avoids having the kfd_cu_info structures on
the stack when inlining which can blow up the stack.

Cc: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 22 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 -
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 28 +++++------
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 28 +++++------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 49 ++++++++-----------
 .../gpu/drm/amd/include/kgd_kfd_interface.h   | 14 ------
 6 files changed, 48 insertions(+), 95 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 38b5457baded..d95fd76102d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -467,28 +467,6 @@ uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev)
 		return 100;
 }
 
-void amdgpu_amdkfd_get_cu_info(struct amdgpu_device *adev, struct kfd_cu_info *cu_info)
-{
-	struct amdgpu_cu_info acu_info = adev->gfx.cu_info;
-
-	memset(cu_info, 0, sizeof(*cu_info));
-	if (sizeof(cu_info->cu_bitmap) != sizeof(acu_info.bitmap))
-		return;
-
-	cu_info->cu_active_number = acu_info.number;
-	cu_info->cu_ao_mask = acu_info.ao_cu_mask;
-	memcpy(&cu_info->cu_bitmap[0], &acu_info.bitmap[0],
-	       sizeof(cu_info->cu_bitmap));
-	cu_info->num_shader_engines = adev->gfx.config.max_shader_engines;
-	cu_info->num_shader_arrays_per_engine = adev->gfx.config.max_sh_per_se;
-	cu_info->num_cu_per_sh = adev->gfx.config.max_cu_per_sh;
-	cu_info->simd_per_cu = acu_info.simd_per_cu;
-	cu_info->max_waves_per_simd = acu_info.max_waves_per_simd;
-	cu_info->wave_front_size = acu_info.wave_front_size;
-	cu_info->max_scratch_slots_per_cu = acu_info.max_scratch_slots_per_cu;
-	cu_info->lds_size = acu_info.lds_size;
-}
-
 int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 				  struct amdgpu_device **dmabuf_adev,
 				  uint64_t *bo_size, void *metadata_buffer,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 609a6fefd85f..3ad8dc523b42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -236,8 +236,6 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct amdgpu_device *adev);
 
 uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev);
-void amdgpu_amdkfd_get_cu_info(struct amdgpu_device *adev,
-			       struct kfd_cu_info *cu_info);
 int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 				  struct amdgpu_device **dmabuf_adev,
 				  uint64_t *bo_size, void *metadata_buffer,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 9459603804b9..0e792a8496d6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2038,11 +2038,12 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 				      uint32_t proximity_domain)
 {
 	struct crat_header *crat_table = (struct crat_header *)pcrat_image;
+	struct amdgpu_gfx_config *gfx_info = &kdev->adev->gfx.config;
+	struct amdgpu_cu_info *cu_info = &kdev->adev->gfx.cu_info;
 	struct crat_subtype_generic *sub_type_hdr;
 	struct kfd_local_mem_info local_mem_info;
 	struct kfd_topology_device *peer_dev;
 	struct crat_subtype_computeunit *cu;
-	struct kfd_cu_info cu_info;
 	int avail_size = *size;
 	uint32_t total_num_of_cu;
 	uint32_t nid = 0;
@@ -2086,21 +2087,20 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	cu->flags |= CRAT_CU_FLAGS_GPU_PRESENT;
 	cu->proximity_domain = proximity_domain;
 
-	amdgpu_amdkfd_get_cu_info(kdev->adev, &cu_info);
-	cu->num_simd_per_cu = cu_info.simd_per_cu;
-	cu->num_simd_cores = cu_info.simd_per_cu *
-			(cu_info.cu_active_number / kdev->kfd->num_nodes);
-	cu->max_waves_simd = cu_info.max_waves_per_simd;
+	cu->num_simd_per_cu = cu_info->simd_per_cu;
+	cu->num_simd_cores = cu_info->simd_per_cu *
+			(cu_info->number / kdev->kfd->num_nodes);
+	cu->max_waves_simd = cu_info->max_waves_per_simd;
 
-	cu->wave_front_size = cu_info.wave_front_size;
-	cu->array_count = cu_info.num_shader_arrays_per_engine *
-		cu_info.num_shader_engines;
-	total_num_of_cu = (cu->array_count * cu_info.num_cu_per_sh);
+	cu->wave_front_size = cu_info->wave_front_size;
+	cu->array_count = gfx_info->max_sh_per_se *
+		gfx_info->max_shader_engines;
+	total_num_of_cu = (cu->array_count * gfx_info->max_cu_per_sh);
 	cu->processor_id_low = get_and_inc_gpu_processor_id(total_num_of_cu);
-	cu->num_cu_per_array = cu_info.num_cu_per_sh;
-	cu->max_slots_scatch_cu = cu_info.max_scratch_slots_per_cu;
-	cu->num_banks = cu_info.num_shader_engines;
-	cu->lds_size_in_kb = cu_info.lds_size;
+	cu->num_cu_per_array = gfx_info->max_cu_per_sh;
+	cu->max_slots_scatch_cu = cu_info->max_scratch_slots_per_cu;
+	cu->num_banks = gfx_info->max_shader_engines;
+	cu->lds_size_in_kb = cu_info->lds_size;
 
 	cu->hsa_capability = 0;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 447829c22295..050a6936ff84 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -99,7 +99,8 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 		const uint32_t *cu_mask, uint32_t cu_mask_count,
 		uint32_t *se_mask, uint32_t inst)
 {
-	struct kfd_cu_info cu_info;
+	struct amdgpu_cu_info *cu_info = &mm->dev->adev->gfx.cu_info;
+	struct amdgpu_gfx_config *gfx_info = &mm->dev->adev->gfx.config;
 	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
 	bool wgp_mode_req = KFD_GC_VERSION(mm->dev) >= IP_VERSION(10, 0, 0);
 	uint32_t en_mask = wgp_mode_req ? 0x3 : 0x1;
@@ -108,9 +109,7 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	int inc = cu_inc * NUM_XCC(mm->dev->xcc_mask);
 	int xcc_inst = inst + ffs(mm->dev->xcc_mask) - 1;
 
-	amdgpu_amdkfd_get_cu_info(mm->dev->adev, &cu_info);
-
-	cu_active_per_node = cu_info.cu_active_number / mm->dev->kfd->num_nodes;
+	cu_active_per_node = cu_info->number / mm->dev->kfd->num_nodes;
 	if (cu_mask_count > cu_active_per_node)
 		cu_mask_count = cu_active_per_node;
 
@@ -118,13 +117,14 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	 * Returning with no CU's enabled will hang the queue, which should be
 	 * attention grabbing.
 	 */
-	if (cu_info.num_shader_engines > KFD_MAX_NUM_SE) {
-		pr_err("Exceeded KFD_MAX_NUM_SE, chip reports %d\n", cu_info.num_shader_engines);
+	if (gfx_info->max_shader_engines > KFD_MAX_NUM_SE) {
+		pr_err("Exceeded KFD_MAX_NUM_SE, chip reports %d\n",
+		       gfx_info->max_shader_engines);
 		return;
 	}
-	if (cu_info.num_shader_arrays_per_engine > KFD_MAX_NUM_SH_PER_SE) {
+	if (gfx_info->max_sh_per_se > KFD_MAX_NUM_SH_PER_SE) {
 		pr_err("Exceeded KFD_MAX_NUM_SH, chip reports %d\n",
-			cu_info.num_shader_arrays_per_engine * cu_info.num_shader_engines);
+			gfx_info->max_sh_per_se * gfx_info->max_shader_engines);
 		return;
 	}
 
@@ -142,10 +142,10 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	 * See note on Arcturus cu_bitmap layout in gfx_v9_0_get_cu_info.
 	 * See note on GFX11 cu_bitmap layout in gfx_v11_0_get_cu_info.
 	 */
-	for (se = 0; se < cu_info.num_shader_engines; se++)
-		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++)
+	for (se = 0; se < gfx_info->max_shader_engines; se++)
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++)
 			cu_per_sh[se][sh] = hweight32(
-				cu_info.cu_bitmap[xcc_inst][se % 4][sh + (se / 4) *
+				cu_info->bitmap[xcc_inst][se % 4][sh + (se / 4) *
 				cu_bitmap_sh_mul]);
 
 	/* Symmetrically map cu_mask to all SEs & SHs:
@@ -184,13 +184,13 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	 *
 	 * First ensure all CUs are disabled, then enable user specified CUs.
 	 */
-	for (i = 0; i < cu_info.num_shader_engines; i++)
+	for (i = 0; i < gfx_info->max_shader_engines; i++)
 		se_mask[i] = 0;
 
 	i = inst;
 	for (cu = 0; cu < 16; cu += cu_inc) {
-		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++) {
-			for (se = 0; se < cu_info.num_shader_engines; se++) {
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++) {
+			for (se = 0; se < gfx_info->max_shader_engines; se++) {
 				if (cu_per_sh[se][sh] > cu) {
 					if (cu_mask[i / 32] & (en_mask << (i % 32)))
 						se_mask[se] |= en_mask << (cu + sh * 16);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3f9f882d3f5c..4e530791507e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1533,7 +1533,6 @@ static int kfd_dev_create_p2p_links(void)
 /* Helper function. See kfd_fill_gpu_cache_info for parameter description */
 static int fill_in_l1_pcache(struct kfd_cache_properties **props_ext,
 				struct kfd_gpu_cache_info *pcache_info,
-				struct kfd_cu_info *cu_info,
 				int cu_bitmask,
 				int cache_type, unsigned int cu_processor_id,
 				int cu_block)
@@ -1595,7 +1594,8 @@ static int fill_in_l1_pcache(struct kfd_cache_properties **props_ext,
 /* Helper function. See kfd_fill_gpu_cache_info for parameter description */
 static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 				struct kfd_gpu_cache_info *pcache_info,
-				struct kfd_cu_info *cu_info,
+				struct amdgpu_cu_info *cu_info,
+				struct amdgpu_gfx_config *gfx_info,
 				int cache_type, unsigned int cu_processor_id,
 				struct kfd_node *knode)
 {
@@ -1606,7 +1606,7 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 
 	start = ffs(knode->xcc_mask) - 1;
 	end = start + NUM_XCC(knode->xcc_mask);
-	cu_sibling_map_mask = cu_info->cu_bitmap[start][0][0];
+	cu_sibling_map_mask = cu_info->bitmap[start][0][0];
 	cu_sibling_map_mask &=
 		((1 << pcache_info[cache_type].num_cu_shared) - 1);
 	first_active_cu = ffs(cu_sibling_map_mask);
@@ -1642,15 +1642,15 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 		k = 0;
 
 		for (xcc = start; xcc < end; xcc++) {
-			for (i = 0; i < cu_info->num_shader_engines; i++) {
-				for (j = 0; j < cu_info->num_shader_arrays_per_engine; j++) {
+			for (i = 0; i < gfx_info->max_shader_engines; i++) {
+				for (j = 0; j < gfx_info->max_sh_per_se; j++) {
 					pcache->sibling_map[k] = (uint8_t)(cu_sibling_map_mask & 0xFF);
 					pcache->sibling_map[k+1] = (uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
 					pcache->sibling_map[k+2] = (uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
 					pcache->sibling_map[k+3] = (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
 					k += 4;
 
-					cu_sibling_map_mask = cu_info->cu_bitmap[xcc][i % 4][j + i / 4];
+					cu_sibling_map_mask = cu_info->bitmap[xcc][i % 4][j + i / 4];
 					cu_sibling_map_mask &= ((1 << pcache_info[cache_type].num_cu_shared) - 1);
 				}
 			}
@@ -1675,16 +1675,14 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 	unsigned int cu_processor_id;
 	int ret;
 	unsigned int num_cu_shared;
-	struct kfd_cu_info cu_info;
-	struct kfd_cu_info *pcu_info;
+	struct amdgpu_cu_info *cu_info = &kdev->adev->gfx.cu_info;
+	struct amdgpu_gfx_config *gfx_info = &kdev->adev->gfx.config;
 	int gpu_processor_id;
 	struct kfd_cache_properties *props_ext;
 	int num_of_entries = 0;
 	int num_of_cache_types = 0;
 	struct kfd_gpu_cache_info cache_info[KFD_MAX_CACHE_TYPES];
 
-	amdgpu_amdkfd_get_cu_info(kdev->adev, &cu_info);
-	pcu_info = &cu_info;
 
 	gpu_processor_id = dev->node_props.simd_id_base;
 
@@ -1711,12 +1709,12 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 		cu_processor_id = gpu_processor_id;
 		if (pcache_info[ct].cache_level == 1) {
 			for (xcc = start; xcc < end; xcc++) {
-				for (i = 0; i < pcu_info->num_shader_engines; i++) {
-					for (j = 0; j < pcu_info->num_shader_arrays_per_engine; j++) {
-						for (k = 0; k < pcu_info->num_cu_per_sh; k += pcache_info[ct].num_cu_shared) {
+				for (i = 0; i < gfx_info->max_shader_engines; i++) {
+					for (j = 0; j < gfx_info->max_sh_per_se; j++) {
+						for (k = 0; k < gfx_info->max_cu_per_sh; k += pcache_info[ct].num_cu_shared) {
 
-							ret = fill_in_l1_pcache(&props_ext, pcache_info, pcu_info,
-										pcu_info->cu_bitmap[xcc][i % 4][j + i / 4], ct,
+							ret = fill_in_l1_pcache(&props_ext, pcache_info,
+										cu_info->bitmap[xcc][i % 4][j + i / 4], ct,
 										cu_processor_id, k);
 
 							if (ret < 0)
@@ -1729,9 +1727,9 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 
 							/* Move to next CU block */
 							num_cu_shared = ((k + pcache_info[ct].num_cu_shared) <=
-								pcu_info->num_cu_per_sh) ?
+								gfx_info->max_cu_per_sh) ?
 								pcache_info[ct].num_cu_shared :
-								(pcu_info->num_cu_per_sh - k);
+								(gfx_info->max_cu_per_sh - k);
 							cu_processor_id += num_cu_shared;
 						}
 					}
@@ -1739,7 +1737,7 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 			}
 		} else {
 			ret = fill_in_l2_l3_pcache(&props_ext, pcache_info,
-					pcu_info, ct, cu_processor_id, kdev);
+						   cu_info, gfx_info, ct, cu_processor_id, kdev);
 
 			if (ret < 0)
 				break;
@@ -1918,10 +1916,11 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 {
 	uint32_t gpu_id;
 	struct kfd_topology_device *dev;
-	struct kfd_cu_info *cu_info;
 	int res = 0;
 	int i;
 	const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
+	struct amdgpu_gfx_config *gfx_info = &gpu->adev->gfx.config;
+	struct amdgpu_cu_info *cu_info = &gpu->adev->gfx.cu_info;
 
 	gpu_id = kfd_generate_gpu_id(gpu);
 	if (gpu->xcp && !gpu->xcp->ddev) {
@@ -1959,12 +1958,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	/* Fill-in additional information that is not available in CRAT but
 	 * needed for the topology
 	 */
-	cu_info = kzalloc(sizeof(struct kfd_cu_info), GFP_KERNEL);
-	if (!cu_info)
-		return -ENOMEM;
-
-	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, cu_info);
-
 	for (i = 0; i < KFD_TOPOLOGY_PUBLIC_NAME_SIZE-1; i++) {
 		dev->node_props.name[i] = __tolower(asic_name[i]);
 		if (asic_name[i] == '\0')
@@ -1973,7 +1966,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	dev->node_props.name[i] = '\0';
 
 	dev->node_props.simd_arrays_per_engine =
-		cu_info->num_shader_arrays_per_engine;
+		gfx_info->max_sh_per_se;
 
 	dev->node_props.gfx_target_version =
 				gpu->kfd->device_info.gfx_target_version;
@@ -2054,7 +2047,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	 */
 	if (dev->gpu->adev->asic_type == CHIP_CARRIZO) {
 		dev->node_props.simd_count =
-			cu_info->simd_per_cu * cu_info->cu_active_number;
+			cu_info->simd_per_cu * cu_info->number;
 		dev->node_props.max_waves_per_simd = 10;
 	}
 
@@ -2081,8 +2074,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 
 	kfd_notify_gpu_change(gpu_id, 1);
 
-	kfree(cu_info);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 255adc30f802..6d094cf3587d 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -57,20 +57,6 @@ struct kfd_vm_fault_info {
 	bool		prot_exec;
 };
 
-struct kfd_cu_info {
-	uint32_t num_shader_engines;
-	uint32_t num_shader_arrays_per_engine;
-	uint32_t num_cu_per_sh;
-	uint32_t cu_active_number;
-	uint32_t cu_ao_mask;
-	uint32_t simd_per_cu;
-	uint32_t max_waves_per_simd;
-	uint32_t wave_front_size;
-	uint32_t max_scratch_slots_per_cu;
-	uint32_t lds_size;
-	uint32_t cu_bitmap[AMDGPU_MAX_GC_INSTANCES][4][4];
-};
-
 /* For getting GPU local memory information from KGD */
 struct kfd_local_mem_info {
 	uint64_t local_mem_size_private;
-- 
2.41.0

