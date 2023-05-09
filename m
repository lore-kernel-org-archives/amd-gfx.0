Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6675AC7EE26
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC4C10E3D9;
	Tue,  9 May 2023 22:04:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC5BF10E3D9
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu7l0E0Lfvf2Q/HSBsnqlEgtRWxvHlEZ7USrlDNpkadq+2OgAiKEc0qXl81eRY8W6xdbLr9wGZT9bLvgry7dOHOIyHxl04eguxleyeyKDsciOczK+QP35aB+TK/d94jO9Z52/OYL3Q+Fm2FyEzXacITL6z66seXsZorFgCJgJq5RyZgMJNPmg3klGMVUcje3r7iM6IfTgXIo7g/IaaCbilPyeIlBKKjpXm3oJdt0Qqc41G5WNye2/M+ziDpeYWqb0wBHTe2WwEqddV+/oo25PXb2VVzsMiQAi8MEkyzpFcYW6LvzqMJJjpKYX9dpWBw469WfhqeuQ4ibjNQtY8MhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQRQVYWhQ3ufvvJd6JPNaweC4J40TXcqc8drTtgSG3I=;
 b=RR5DJoAHPfVlxfOxd9fzp08AXI0IR17LI8wVsipXO7YAERanz5jOHVxOF7mg9od2EOJppPKLmiNL0zFlMtQxPW9F515c6JRM1MJeeJ+cW+s3HTdgCFmOqoqgMyt+wY9b/B36951y8d4/sZEymg4G1dx5vbAo2rdLWSqmzC1m6z6OIYA/jRkkbBHimCF5BvekWdS9Lxtkpsp5bW1jsrhj4jTaXevq6fvJCuGjLUZNupq2PsbjE+q8bHjFJJkWlqXiznBigdK1RlzXPDBh/fzP0nr7yBjfQA29OBTGH6WAQQ/3mGBumiYOyd1UiEatAkVTvzMqqdeH8HNp/4+fOSnJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQRQVYWhQ3ufvvJd6JPNaweC4J40TXcqc8drTtgSG3I=;
 b=hThM7JVgNPrMZbJgUB0R6Jq2T6R+iPPspFQdqrjjIEt7oHjRhRpcZ7H9d5APvEAo4fOyg8IFGUXlTb/wl+YqH4ebfssWXYUl5bqdrPZDsArY0t9czEKWKjR4n6k0XD6az6hZmLdoA6k9vsEpjlgEj1smnHKvvWQE8/IQL7vfqE0=
Received: from BN9PR03CA0129.namprd03.prod.outlook.com (2603:10b6:408:fe::14)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 22:04:39 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::19) by BN9PR03CA0129.outlook.office365.com
 (2603:10b6:408:fe::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:04:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:04:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Handle VRAM dependencies on GFXIP9.4.3
Date: Tue, 9 May 2023 18:01:42 -0400
Message-ID: <20230509220144.474723-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 7133f2b3-e279-45c8-0f8a-08db50d9623b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJsbKZlTjfVXLEDCMkTV17LpwCo7ql+kqhx6CCITJfBNrJMbp/zH9X83MNMg5Js+rKfVTn6xt5VSJE4HpN10dy36zU41l+gqz1nf7IGG8vnZAj9HThZfwi5fHPfP/sUzgzdOxBAP13NHjUrh+1Bm1GDs36sSFDmXkdlfv8yv9ccBb62ASTRFgElLhiG3+IloHFvycjTjnRgnT3P+FaZmIUE6cl/7WErwNEa6mUesRbRSHMNngcLIni4fEhNvWCJO7BR+SJCd1gCwEPDTlqe62VSOwwkAcr5P9tqcN9xr/QfIVLZyMhk2xr6OGjxOXsyqX6KEITFTWQ9GtacJ9E1qBDbAv1lwUUvvUtpsLY9T4bqq1z2/yTPMZLAnHO9BdQCzCHb9gS9wYSF9nL1PEt5ho8GYHbL1PAVZgnuaScz8Nh1SioO+1zb+HS/pOU4ArRsrwpsKkP0vFF7g3xTIRh9SG9ac8VYx5RDzVNVMxOqXyGiyPw2OUYBwHdUh0ilcu429fNPVYi/m+/z5LAYOcQbGFCHTnt7VkVQYRVFXPvIpKllaZZTdMiMY6Nvz31HdWPBP1FGdH8iL9YDya4rwcvVrk0PivGXfWH0dMbtRNe9OVSccMgQ5eUG2oaH94jQGJi0Sz0ISPvXcwxuFjekhFATVMhcmWEOa9Yp/tRdh5o5Ll28/55c98Nvei3NkMBi0yPeucrZ7vLg0qrMFkhEgX5Ie/Rhlb2aBpAjLGZlZIhlgQ6W38F8/9jLM9KSaWNBCVNI6zf20O2tGy/TBojyf92LjIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(6666004)(2616005)(2906002)(30864003)(16526019)(478600001)(186003)(36756003)(40460700003)(7696005)(40480700001)(26005)(41300700001)(1076003)(356005)(316002)(82740400003)(83380400001)(81166007)(47076005)(54906003)(4326008)(6916009)(70586007)(70206006)(5660300002)(8676002)(36860700001)(426003)(336012)(86362001)(8936002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:04:38.8751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7133f2b3-e279-45c8-0f8a-08db50d9623b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

[For 1P NPS1 mode driver bringup]

Changes required to initialize the amdgpu driver with frontdoor firmware
loading and discovery=2 with the native mode SBIOS that enables CPU GPU
unified interleaved memory.

sudo modprobe amdgpu discovery=2

Once PSP TMR region is reported via the ACPI interface, the dependency
on the ip_discovery.bin will be removed.

Choice of where to allocate driver table is given to each IP version. In
general, both GTT and VRAM domains will be considered. If one of the
tables has a strict restriction for VRAM domain, then only VRAM domain
is considered.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
(lijo: Modified the handling for SMU Tables)
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 89 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |  7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  6 ++
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  5 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  6 +-
 11 files changed, 99 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 9abf940dbac1..bb7e9ab27a4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2291,8 +2291,9 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
 	(*mem)->dmabuf = dma_buf;
 	(*mem)->bo = bo;
 	(*mem)->va = va;
-	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
+	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) && !adev->gmc.is_app_apu ?
 		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
+
 	(*mem)->mapped_to_gpu_memory = 0;
 	(*mem)->process_info = avm->process_info;
 	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 7c9b788ae0a9..a5c4f98f8cd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1044,7 +1044,7 @@ static const char *amdgpu_vram_names[] = {
 int amdgpu_bo_init(struct amdgpu_device *adev)
 {
 	/* On A+A platform, VRAM can be mapped as WB */
-	if (!adev->gmc.xgmi.connected_to_cpu) {
+	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
 		/* reserve PAT memory space to WC for VRAM */
 		int r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
 				adev->gmc.aper_size);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 863fa331e6ff..4395c53d09d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -476,7 +476,8 @@ static int psp_sw_init(void *handle)
 		return ret;
 
 	ret = amdgpu_bo_create_kernel(adev, PSP_FENCE_BUFFER_SIZE, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
+				      AMDGPU_GEM_DOMAIN_VRAM |
+				      AMDGPU_GEM_DOMAIN_GTT,
 				      &psp->fence_buf_bo,
 				      &psp->fence_buf_mc_addr,
 				      &psp->fence_buf);
@@ -484,7 +485,8 @@ static int psp_sw_init(void *handle)
 		goto failed1;
 
 	ret = amdgpu_bo_create_kernel(adev, PSP_CMD_BUFFER_SIZE, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
+				      AMDGPU_GEM_DOMAIN_VRAM |
+				      AMDGPU_GEM_DOMAIN_GTT,
 				      &psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
 				      (void **)&psp->cmd_buf_mem);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 4fb93f367b99..2bdd6bcad506 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1712,15 +1712,20 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
 	}
 
-	ret = amdgpu_bo_create_kernel_at(adev,
-					 adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
-					 adev->mman.discovery_tmr_size,
-					 &adev->mman.discovery_memory,
-					 NULL);
-	if (ret) {
-		DRM_ERROR("alloc tmr failed(%d)!\n", ret);
-		amdgpu_bo_free_kernel(&adev->mman.discovery_memory, NULL, NULL);
-		return ret;
+	if (!adev->gmc.is_app_apu) {
+		ret = amdgpu_bo_create_kernel_at(adev,
+						 adev->gmc.real_vram_size -
+						 adev->mman.discovery_tmr_size,
+						 adev->mman.discovery_tmr_size,
+						 &adev->mman.discovery_memory,
+						 NULL);
+		if (ret) {
+			DRM_ERROR("alloc tmr failed(%d)!\n", ret);
+			amdgpu_bo_free_kernel(&adev->mman.discovery_memory, NULL, NULL);
+			return ret;
+		}
+	} else {
+		DRM_DEBUG_DRIVER("backdoor fw loading path for PSP TMR, no reservation needed\n");
 	}
 
 	return 0;
@@ -1769,10 +1774,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
 				adev->gmc.visible_vram_size);
 
-	else
+	else if (!adev->gmc.is_app_apu)
 #endif
 		adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
 				adev->gmc.visible_vram_size);
+	else
+		DRM_DEBUG_DRIVER("No need to ioremap when real vram size is 0\n");
 #endif
 
 	/*
@@ -1807,23 +1814,32 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * This is used for VGA emulation and pre-OS scanout buffers to
 	 * avoid display artifacts while transitioning between pre-OS
 	 * and driver.  */
-	r = amdgpu_bo_create_kernel_at(adev, 0, adev->mman.stolen_vga_size,
-				       &adev->mman.stolen_vga_memory,
-				       NULL);
-	if (r)
-		return r;
-	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
-				       adev->mman.stolen_extended_size,
-				       &adev->mman.stolen_extended_memory,
-				       NULL);
-	if (r)
-		return r;
-	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_reserved_offset,
-				       adev->mman.stolen_reserved_size,
-				       &adev->mman.stolen_reserved_memory,
-				       NULL);
-	if (r)
-		return r;
+	if (!adev->gmc.is_app_apu) {
+		r = amdgpu_bo_create_kernel_at(adev, 0,
+					       adev->mman.stolen_vga_size,
+					       &adev->mman.stolen_vga_memory,
+					       NULL);
+		if (r)
+			return r;
+
+		r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
+					       adev->mman.stolen_extended_size,
+					       &adev->mman.stolen_extended_memory,
+					       NULL);
+
+		if (r)
+			return r;
+
+		r = amdgpu_bo_create_kernel_at(adev,
+					       adev->mman.stolen_reserved_offset,
+					       adev->mman.stolen_reserved_size,
+					       &adev->mman.stolen_reserved_memory,
+					       NULL);
+		if (r)
+			return r;
+	} else {
+		DRM_DEBUG_DRIVER("Skipped stolen memory reservation\n");
+	}
 
 	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
 		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
@@ -1870,7 +1886,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		DRM_ERROR("Failed initializing oa heap.\n");
 		return r;
 	}
-
 	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
 				AMDGPU_GEM_DOMAIN_GTT,
 				&adev->mman.sdma_access_bo, NULL,
@@ -1891,13 +1906,15 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 
 	amdgpu_ttm_training_reserve_vram_fini(adev);
 	/* return the stolen vga memory back to VRAM */
-	amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
-	amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
-	/* return the IP Discovery TMR memory back to VRAM */
-	amdgpu_bo_free_kernel(&adev->mman.discovery_memory, NULL, NULL);
-	if (adev->mman.stolen_reserved_size)
-		amdgpu_bo_free_kernel(&adev->mman.stolen_reserved_memory,
-				      NULL, NULL);
+	if (!adev->gmc.is_app_apu) {
+		amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
+		amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
+		/* return the IP Discovery TMR memory back to VRAM */
+		amdgpu_bo_free_kernel(&adev->mman.discovery_memory, NULL, NULL);
+		if (adev->mman.stolen_reserved_size)
+			amdgpu_bo_free_kernel(&adev->mman.stolen_reserved_memory,
+					      NULL, NULL);
+	}
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
@@ -1939,7 +1956,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 	int r;
 
 	if (!adev->mman.initialized || amdgpu_in_reset(adev) ||
-	    adev->mman.buffer_funcs_enabled == enable)
+	    adev->mman.buffer_funcs_enabled == enable || adev->gmc.is_app_apu)
 		return;
 
 	if (enable) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index df63dc3bca18..bc5d126b600b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -512,7 +512,12 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	bp.size = amdgpu_vm_pt_size(adev, level);
 	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
-	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
+
+	if (!adev->gmc.is_app_apu)
+		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
+	else
+		bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+
 	bp.domain = amdgpu_bo_get_preferred_domain(adev, bp.domain);
 	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 1f1268cd5e09..42877c4505f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -459,7 +459,8 @@ static int gfx_v9_4_3_mec_init(struct amdgpu_device *adev)
 		adev->gfx.num_compute_rings * num_xcc * GFX9_MEC_HPD_SIZE;
 	if (mec_hpd_size) {
 		r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
-					      AMDGPU_GEM_DOMAIN_VRAM,
+					      AMDGPU_GEM_DOMAIN_VRAM |
+					      AMDGPU_GEM_DOMAIN_GTT,
 					      &adev->gfx.mec.hpd_eop_obj,
 					      &adev->gfx.mec.hpd_eop_gpu_addr,
 					      (void **)&hpd);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 18116e92e33a..d95205b4277e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1593,8 +1593,13 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 	int r;
 
 	/* size in MB on si */
-	adev->gmc.mc_vram_size =
-		adev->nbio.funcs->get_memsize(adev) * 1024ULL * 1024ULL;
+	if (!adev->gmc.is_app_apu) {
+		adev->gmc.mc_vram_size =
+			adev->nbio.funcs->get_memsize(adev) * 1024ULL * 1024ULL;
+	} else {
+		DRM_DEBUG("Set mc_vram_size = 0 for APP APU\n");
+		adev->gmc.mc_vram_size = 0;
+	}
 	adev->gmc.real_vram_size = adev->gmc.mc_vram_size;
 
 	if (!(adev->flags & AMD_IS_APU) &&
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 82749405be79..8c86d69938ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1026,6 +1026,12 @@ bool kfd_dev_is_large_bar(struct kfd_node *dev)
 	if (dev->kfd->local_mem_info.local_mem_size_private == 0 &&
 	    dev->kfd->local_mem_info.local_mem_size_public > 0)
 		return true;
+
+	if (dev->kfd->local_mem_info.local_mem_size_public == 0 && dev->kfd->adev->gmc.is_app_apu) {
+		pr_debug("APP APU, Consider like a large bar system\n");
+		return true;
+	}
+
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 16475921587b..1aaf933f9f48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -30,6 +30,9 @@
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 
+/* Fixme: Fake 32GB for 1PNPS1 mode bringup */
+#define DUMMY_VRAM_SIZE 31138512896
+
 /* GPU Processor ID base for dGPUs for which VCRAT needs to be created.
  * GPU processor ID are expressed with Bit[31]=1.
  * The base is set to 0x8000_0000 + 0x1000 to avoid collision with GPU IDs
@@ -1053,6 +1056,8 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
 
 			props->heap_type = heap_type;
 			props->flags = flags;
+			if (size_in_bytes == 0)
+				size_in_bytes = DUMMY_VRAM_SIZE; /* Fixme: TBD */
 			props->size_in_bytes = size_in_bytes;
 			props->width = width;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5633c5797e85..7cf56587d320 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -804,11 +804,20 @@ static int smu_init_fb_allocations(struct smu_context *smu)
 		}
 	}
 
+	driver_table->domain = AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT;
 	/* VRAM allocation for driver table */
 	for (i = 0; i < SMU_TABLE_COUNT; i++) {
 		if (tables[i].size == 0)
 			continue;
 
+		/* If one of the tables has VRAM domain restriction, keep it in
+		 * VRAM
+		 */
+		if ((tables[i].domain &
+		    (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) ==
+			    AMDGPU_GEM_DOMAIN_VRAM)
+			driver_table->domain = AMDGPU_GEM_DOMAIN_VRAM;
+
 		if (i == SMU_TABLE_PMSTATUSLOG)
 			continue;
 
@@ -818,7 +827,6 @@ static int smu_init_fb_allocations(struct smu_context *smu)
 
 	driver_table->size = max_table_size;
 	driver_table->align = PAGE_SIZE;
-	driver_table->domain = AMDGPU_GEM_DOMAIN_VRAM;
 
 	ret = amdgpu_bo_create_kernel(adev,
 				      driver_table->size,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ea8f3d6fb98b..8969b3ff5c8f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -220,10 +220,12 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 			       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(MetricsTable_t),
-		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+		       PAGE_SIZE,
+		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),
-		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+		       PAGE_SIZE,
+		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
 
 	smu_table->metrics_table = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
-- 
2.40.1

