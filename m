Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27E1C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A7A10F34E;
	Fri, 21 Aug 2026 16:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LLtmK8LJ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F68D10F34E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwmjrFGTR0d/Ms6DiSS+ln34wE5AT81ZpwzBa87zMS8GD7Eth5JNDUbRpDBEf4p5lTRVrxl1YbmyH8urP5P4HrWXJ1mZYvQRjZ0vFYuxP1TASZQnN6oWLglPpKfg1Jbsn3GIXGYnOYYHPf/qqdsBV/UTKExw1Zko2RFKyutCBEEmvgJ0TgSp6CqwkUERdARCRufbmTXuyQqfMY0B5xmCtUP5bxNooMXu/0HZ4VXjjSyLK9zlTZ8nWZPYRqyb3Ys8DHhjlfWlxkTu835CCOy9y6/sxvpbwRNGqO96bjvgr9QqA76UjY6ydj2SdZnf4ajdBak0wTfBvcrmzByt+scj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8C4vvEsq2IRYpAqeuBSMUR7WmaP0zWVNNm1FYcIH8w=;
 b=ZDFH/chaG+Ryd1ORYEI8U7k5cF3IR4zTPOK3EKsbuuOuqdC8i732pNmF5IkVbQN7EMT9TgY0FJ0/D3uvX5bE0iJlF9nUr9BVrCTCbUlFHhd4TKAlG+H9Ma0Pdxt5+NXdUaAS9nLaoBLm1EiTHoUZCUnXQ8Ubez0t3S5Dm2VNYw1PAIf7tpIk37dawHZiTQKukGJ2TMVNZgMoqoWi6vongmrnNvQtFIs0f3I9iP+79nV7LfD0zko40A2tl4MebsGF+8VurGGJ3UDeHrvA1LPUDYpD3b2gBu7vM6yZIG1lyaNgc4shv8wOXuW2j6Y+ZOlDpy1B+qwqy1mlpj/6ga+iBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8C4vvEsq2IRYpAqeuBSMUR7WmaP0zWVNNm1FYcIH8w=;
 b=LLtmK8LJ2jpYVNT/7reI6oG8KOAGfZhv4WFoDEVzJ+YKWC1HCjyTbTV71WlacB4BQeW7/EPjznrhuyIz8K+d8ahAtR02h3xA282YB6UNCfxfNi9vdzfugUkvK4rKpj9vpklvGdUjoOo44EOi46/n0EP6xUUQf9fjKDhgk/uHgqc=
Received: from SJ0PR13CA0168.namprd13.prod.outlook.com (2603:10b6:a03:2c7::23)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 16:07:26 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::17) by SJ0PR13CA0168.outlook.office365.com
 (2603:10b6:a03:2c7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Fri, 21
 Aug 2026 16:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:07:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:07:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:07:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shiwu Zhang <shiwu.zhang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/15] drm/amdgpu: retire rb settings from gfx v12.1.0
Date: Fri, 21 Aug 2026 12:06:58 -0400
Message-ID: <20260821160710.752459-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160710.752459-1-alexander.deucher@amd.com>
References: <20260821160710.752459-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: 98db7cf8-c17f-410c-fc52-08deff9e4aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|10067099003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ADl7WSxO+Easi3panJXltF2t6n9sEkrxzMfONIgakAHfKggHYcvRHfcReJw83Va7tvOmjGvSH8ZObVF13IebISw/5i++lKEab7xcBPYkeCf2drc2tzG6fNwrb0lL5kxOlOvx3qaMNOQjEBJuBATxhvN//IfydBQBCwJwF0bk1GPgcM6lqnBwgJmfctcXmKCvO9yQcomRzG4uSvDJydeD8+oKOQeb0gRFYZnRs1fGHr4eeruhSnABGKbDbuwxPri5VSXWCEQblMFF3nDn/eitrIwQ1hVS70yMKqhBzDvhDQXVEgmQutw0maZfUzBM2Yy5dDlDdOKxz5292fbb8OGLlTnHbRms9u/lZRPSDfdOdkYRracoGcYN7+wicfyVWFne96QabRKJte+n29+99NhSdXRrZc5394GcyAAZuFpl8c9M1NEHdwBVSPjcAhjCAV3cup/5sjVWWfgje4Ehy4H1Rib12jXM9Ebd5aT/rTNl0AfUsXpe3sEFLgGmrD4bQJAIv7SR0qS4UtWpBicYG9HqiU4lhWAMKgL4o2e3WJQr/hdFCj8rBO2/n3nZmERb3Bcaqz6npso6GjXUWoPlMyX+ZzuoE7GGrsWS3+SZRYKpyfjQd/4R+WWZCujOlu98TI09UFGLoerSbrCO1ECMTOstjaHVD6lYn1907i9iauKZWSsC+nOP60HtJ0wYYhW/jl5f5FJVS5flWRS3KN9FbTWMGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 75jh9Pxj7SuwQUIGL5ndxMzELHfsqALaBTuMbaeuRiUNoVRrd9CK5kw1ZO4Ezx/cToC9y5EC/wqhR/vD2Sqe4id+G0e61DoW/H6Yw127uM1dLI7ypsa8VyWKhyOsKHGfzgAAMC3eJuckaZWdV6ZZhRfTQHN5McFyFVgiCpuY9PWlcHB6xYKob8CtctjBol9xIzouAhwQ1oHs24lSq+UTtjc98D+koAsOm2NbVcDu7TIjOsjMwoCG11MYKtT+CcnNPVk7U5s9US7Weq10dPTPKLPlHCHBCmPQJ2w1+gdZCYpsmcBT2I3NQ30yWUjrMsG81b0dbH5loPFsjWePYaeobWJONu0jS7DZPrntzdJsmp2nlVqRQf1NcKmXinDELifKw8UM0mSTQktiZ88/O3DRc/3lTxf+jJbDGaxCxVuN2H11oMvrKTpPAFajvg5AP8kc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:07:25.5564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98db7cf8-c17f-410c-fc52-08deff9e4aba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
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

From: Shiwu Zhang <shiwu.zhang@amd.com>

Use the default all zero settings.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 56 --------------------------
 1 file changed, 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 3f757dfcd1c36..4192e49fbb291 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1648,61 +1648,6 @@ static u32 gfx_v12_1_get_sa_active_bitmap(struct amdgpu_device *adev,
 	return sa_mask & (~(gc_disabled_sa_mask | gc_user_disabled_sa_mask));
 }
 
-static u32 gfx_v12_1_get_rb_active_bitmap(struct amdgpu_device *adev,
-					  int xcc_id)
-{
-	u32 gc_disabled_rb_mask, gc_user_disabled_rb_mask;
-	u32 rb_mask;
-
-	gc_disabled_rb_mask = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
-					   regCC_RB_BACKEND_DISABLE);
-	gc_disabled_rb_mask = REG_GET_FIELD(gc_disabled_rb_mask,
-					    CC_RB_BACKEND_DISABLE,
-					    BACKEND_DISABLE);
-	gc_user_disabled_rb_mask = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
-						regGC_USER_RB_BACKEND_DISABLE);
-	gc_user_disabled_rb_mask = REG_GET_FIELD(gc_user_disabled_rb_mask,
-						 GC_USER_RB_BACKEND_DISABLE,
-						 BACKEND_DISABLE);
-	rb_mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se *
-					    adev->gfx.config.max_shader_engines);
-
-	return rb_mask & (~(gc_disabled_rb_mask | gc_user_disabled_rb_mask));
-}
-
-static void gfx_v12_1_setup_rb(struct amdgpu_device *adev)
-{
-	u32 rb_bitmap_width_per_sa;
-	u32 max_sa;
-	u32 active_sa_bitmap;
-	u32 global_active_rb_bitmap;
-	u32 active_rb_bitmap = 0;
-	u32 i;
-	int xcc_id;
-
-	for (xcc_id = 0; xcc_id < NUM_XCC(adev->gfx.xcc_mask); xcc_id++) {
-		/* query sa bitmap from SA_UNIT_DISABLE registers */
-		active_sa_bitmap = gfx_v12_1_get_sa_active_bitmap(adev, xcc_id);
-		/* query rb bitmap from RB_BACKEND_DISABLE registers */
-		global_active_rb_bitmap = gfx_v12_1_get_rb_active_bitmap(adev, xcc_id);
-
-		/* generate active rb bitmap according to active sa bitmap */
-		max_sa = adev->gfx.config.max_shader_engines *
-			 adev->gfx.config.max_sh_per_se;
-		rb_bitmap_width_per_sa = adev->gfx.config.max_backends_per_se /
-					 adev->gfx.config.max_sh_per_se;
-		for (i = 0; i < max_sa; i++) {
-			if (active_sa_bitmap & (1 << i))
-				active_rb_bitmap |= (0x3 << (i * rb_bitmap_width_per_sa));
-		}
-
-		active_rb_bitmap |= global_active_rb_bitmap;
-	}
-
-	adev->gfx.config.backend_enable_mask = active_rb_bitmap;
-	adev->gfx.config.num_rbs = hweight32(active_rb_bitmap);
-}
-
 static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
 					    int xcc_id)
 {
@@ -1800,7 +1745,6 @@ static void gfx_v12_1_constants_init(struct amdgpu_device *adev)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
-	gfx_v12_1_setup_rb(adev);
 	gfx_v12_1_get_cu_info(adev, &adev->gfx.cu_info);
 	gfx_v12_1_get_tcc_info(adev);
 	adev->gfx.config.pa_sc_tile_steering_override = 0;
-- 
2.55.0

