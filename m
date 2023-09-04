Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3D5C71153
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Sep 2023 08:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3973910E2F1;
	Mon,  4 Sep 2023 08:18:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF76110E2EE
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 08:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFERdKeurw5fQAS0tEh328316dY4VrlftLgxFhnNr3EJFYFJ0imb2Ekm6E6g9kUOVq0cYjAtyZSEYPlxEN+04A/VXCMYkbohU0DC03+wREYf8kqraw/etULwK+bcOGuAPO/lHquEvnrE5rjXY5k4fsHLrKSZFS6Na6NbG/1U83DQvuHbIKrVIhZA/8kidodfQgEl+557SWVWOqgb0D7iPrtNHbzwUuGCcsnCJXsNXjmoFqaKjPO0NTTlz1Dz2ODdbHyYrLYCPYPtW6LsWYbYUP3GjfodIg6FCi5zHs0WlhfLYcaLAVVjdN4/1AAphJ5MPKzQJO6995Yvvv3lG1BI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwDtP6ckmhRgpTUldBB1LXRSq27aAnmiAF4tpKDjVZE=;
 b=MVPLOwl9iAYseFNxuXr6gYadWLzduD8IAQfymucWV/3Lv+caIUgVNF6Pn5n6djHt0Sp5ZVsiL38m9a4kpDWh/epgwa4Yb4/xI1QnL5aR4NvS703No5RutR5vG9kmlx/zILwsXV5qE7cN7BEqqO1bDT+oRmjMkP14jN8ZINpmvSZFuqqxw5MMsTRhdBJgQXo6zBISRzdfZskl7N0k6PZ3g0u8YHrwerDfZOscWnCEoVdLcNpHwXXAsIsnbL0ywEcjE8YMS9hmL5E8src5xhmpjD3A6bCj20m6GGKlt4udnWYGBge3QlwvVOxVa7nDXTOkk5/RZDdiX6zhbpW/8bYoZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwDtP6ckmhRgpTUldBB1LXRSq27aAnmiAF4tpKDjVZE=;
 b=e6kI5yUAlBPZj4Jd9bb6J/a97n8LhC0irbeCidnYXqw0o7QoSi2JiYtA7Yev0ap6RBoHzFXT6r0E2qLGSsfJrW31FE8sXOX2XFTz1zuszHw2+G/FTXgGUCC0DJkNy7UnHMCPDGQGqvoYUYqFsP0kyy6j0vhF1wfrLXfEmOGep+4=
Received: from MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Mon, 4 Sep
 2023 08:18:26 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::f) by MW3PR06CA0030.outlook.office365.com
 (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32 via Frontend
 Transport; Mon, 4 Sep 2023 08:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 08:18:26 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 03:18:23 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: calling address translation functions to simplify
 codes
Date: Mon, 4 Sep 2023 16:18:06 +0800
Message-ID: <20230904081806.16624-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5e6118-6ff8-4f69-ced8-08dbad1f835f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QddmvT4K9fWVJ9G7vpZ0igACOMwnA0eRLMkgEbEHvHhkadQgzaueIPpn0NBxFIQQzlIdUeQVVebQtOaBik4wxW3+c4hsh7JURnng92phBMYcKA9E3eb1F68rQYwLKVcP1q264MBc2Y7sNlrb8dZaPaqmpwwV5pZUK66P0yzZ81dZEyhEBF1ysjFC3XED1TkG/vZgDO8EaeP7EvweNsNoNYnwCVB3b/3f3Km7p9z7zq4jzmrZbpd7LNA/maokszBSUU1+G3/INE5V1YZcKmXB0owq7WhuMQ3V/lvWjs5u34hItWiuzn3kRNMchjXOsCTA4adPKLbuFDIKGOS2jaQcgzSPfa3GonLNdgDy+3vytexT6epOeaNw/2QZNkA9bLL6Ffg3f4MA+VGA/skZEoIPnbXvbF+1sNYCc2DNDgXcOvXtE80LQH9Dj85YDmTJxQFELK3XoUD4VkoJepxkunQLXuGCJi69lOBonOdPmEihX+xq8NYwMA2JnAl+PsYl53z6sGHCHnjTZ1vwgi9VErOeyL7O2soBW7KjbPxWWSe0y3974jP88vZ+CtEVyhDgmlUdkCszqprk0u6ThLEEt2vl7Kk3C7ryMOgymK7dGppgku0O8q1qSBs7Ey+sSvlBn7LcL6bqhp43NROGCZAoHnqDQAK21qBsOhbgHmpiyX3ixQSvVCJSwVvpmohDedZBqgEz2CRHdw7hQor/ySsxGOWFguVru/Yhn4e/r4Z23hNkEz0WX8A5YTuhhdyeEiXe1u4vo7RCpWfvv+b/OBGUKTamnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(1800799009)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(8936002)(5660300002)(6916009)(316002)(2906002)(54906003)(36756003)(70206006)(70586007)(8676002)(4326008)(41300700001)(40460700003)(7696005)(36860700001)(26005)(336012)(16526019)(1076003)(40480700001)(47076005)(426003)(82740400003)(6666004)(81166007)(356005)(478600001)(2616005)(83380400001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 08:18:26.1336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5e6118-6ff8-4f69-ced8-08dbad1f835f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use amdgpu_gmc_vram_pa to simplify codes.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 3 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      | 3 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c     | 3 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c   | 3 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c   | 3 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c     | 3 +--
 8 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index 2eb3386ae7ac..bcb6ba03cead 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -168,8 +168,7 @@ static void gfxhub_v11_5_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
-	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start
-		+ adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
 	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index e1c76c070ba9..89ff7910cb0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -164,8 +164,7 @@ static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
-	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start
-		+ adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
 	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index 07f369c7a1ed..be1da5927910 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -169,8 +169,7 @@ static void gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device *adev)
 		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
-	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start
-		+ adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
 	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index dcbba981462e..671e288c7575 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -500,8 +500,7 @@ static void gmc_v11_0_get_vm_pde(struct amdgpu_device *adev, int level,
 				 uint64_t *addr, uint64_t *flags)
 {
 	if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
-		*addr = adev->vm_manager.vram_base_offset + *addr -
-			adev->gmc.vram_start;
+		*addr = amdgpu_gmc_vram_mc2pa(adev, *addr);
 	BUG_ON(*addr & 0xFFFF00000000003FULL);
 
 	if (!adev->gmc.translate_further)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 441379e91cfa..7c9ab5491067 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -189,8 +189,7 @@ static void mmhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
-	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index 12c7f4b46ea9..db79e6f92441 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -188,8 +188,7 @@ static void mmhub_v3_0_1_init_system_aperture_regs(struct amdgpu_device *adev)
 		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
-	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index 5dadc85abf7e..d1fc9dce7151 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -181,8 +181,7 @@ static void mmhub_v3_0_2_init_system_aperture_regs(struct amdgpu_device *adev)
 	}
 
 	/* Set default page address. */
-	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index ec1fb329524d..8194ee2b96c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -180,8 +180,7 @@ static void mmhub_v3_3_init_system_aperture_regs(struct amdgpu_device *adev)
 		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
-	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
-- 
2.37.3

