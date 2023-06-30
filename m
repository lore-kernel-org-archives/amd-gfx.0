Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34B6EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 15:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FCEC10E4A3;
	Fri, 30 Jun 2023 15:56:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A32A210E4A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 15:56:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9W2TtKtw4cnm0YmPbMUDDQRn/Vn+hpTc01PKec6Ra/llLVuhzH2Y0lLg7G/P81OMc2/mE8ybPBYkocB+e1DPpcmlhH1XwX2rzipLD03cTrLcQqVdgKnkJzWVJ8sPOyedXXeW/Wo6sT7fSQsN/8CfmoQ6A9tFrKyTmgxZlLrdyaMO0rgk3OBCMDMUwisknuiwC3/D98P8agp/Ep/TJs5VA/5NHJpAWswsSP6wsAe4x37p4PvIiuKtvSsqBWGOz60g8gLopJ1njc/by0xgXK2qPd0loNYg03UbJcphOEwS08XUMKSLLor7Ub2ot5wLfyCOgsl4Ax2UorkSLJj0pABnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+0zaVERuLm0Tw4Cyx2X43AGU3nY7Qc3LZOn9dxykPg=;
 b=SUCDmY36IAj7j+xnKkqJNORJ7hPSBNB7cCNcPKLYJ+KkCY58VHkv9eGSiMVwdbX+nE4Tz7+8HiOnv/cw5eRxGxxzq+OuUxtKeDjEmREbupW4ZopXpbmvMz3HDLPdUoN0egP9v1QQA/3kt53yCbOmDLF+9w1MhS7W3m0HlTEBoS94n7TMQ7j6Q92N9+1Uthb2ihhe8bBnaK0+yrrl6NSuohjbunp7Poy9BL5eGKv0xAzYUiT5Hz+C2n/Cf1gwtdxXViqdPHGmO1THEN0C+fO7p53Y+hlJ2FhoMUx3R+DWq4RD+Pbk2IHXbE5CuEqXhfIUQ65jbJ8l0rGLfhANwv3PJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+0zaVERuLm0Tw4Cyx2X43AGU3nY7Qc3LZOn9dxykPg=;
 b=dmP9F857T6FpqRHGj5euTMLrvnrGHAHA+EZUAGLRc31I2ONXpzvLNvg6PSKQ4QrlmVKiMOwhQPDV2Nc/vx4u2al9MEZ7aRFeH2hmfkurIVR0QS05H7TARFRCGkIS0w8/w6LjMnrS89iOOUSDx7/dVRxQMq5DxSX83FvS417SZNU=
Received: from BN8PR04CA0007.namprd04.prod.outlook.com (2603:10b6:408:70::20)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 15:56:28 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::45) by BN8PR04CA0007.outlook.office365.com
 (2603:10b6:408:70::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 15:56:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.51 via Frontend Transport; Fri, 30 Jun 2023 15:56:28 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 10:56:26 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: Fix error & warnings in gmc_v8_0.c
Date: Fri, 30 Jun 2023 21:26:01 +0530
Message-ID: <20230630155603.3388617-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630155603.3388617-1-srinivasan.shanmugam@amd.com>
References: <20230630155603.3388617-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a17fa96-e656-4409-f851-08db798290a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhV8uDiBeWZ9UOZPpk3f/fTsrsZv0MSNPUNIn0ZLzzYORIHt013sbXBEGf/SIggUOrRuEZ9sfl2s5F+3nq4ipIy174cENUTHz6UN89OWLKk+qhFIOYRR9HyFij3XpVh9D6n39eiFB/dShY8R2GhzWZGXKqsp8Ttw5MrYI5U+JPHoEYVHAoKw8jQMSaV7MagX6oC4V8hRR99nqd+qkhG4ERz3MYiJaUTIGGZvv6qdO/TLJQzSkLV8ckmLfyjigVI3jBPDcRcGqYyjHcORTGFvjbDGHZJ9oHSfBbDrGF5MYkOszg4Jm2SB3jTP8E3TyKiXQ7DHbZl420M80nQq4JWPTOhnwAi1ZNVB8bYPY3INAkaZZFFKABZKjk9QXXiECSG24EnB/O2hWEL2UIoPlX64Jl3MMQoGxV3pMHn6zs2klka2IspQHrx9jto7heC6GebdW7SN5v6Hk28siD6JozjIfzqA2pHu4oKdxjzkVOz3KLNdmTET12xU+CWQMobXq4pCyjNmBs+A8aWMZvgr/bmVj6cvRtavU3X6AszaS9EV/izpxzUuJRtGMKIEBptZqYanGNRkzLAJFCV5dZoCFjt4tVvNcFcoGdEfnRWLnTvCdekZM0yK8K4j9ADDx9c4+1KjuIlzC0Y1/3Nq5c8fd1eHsF8JoeGOoJorwxZ52BOh68PgKO2kc2HO0QI/CHvu3gBHrUJhg1pL4hDjBNn+9uzkzeZbnePOnB1XdLzJwZdhdygobDL4iZddCOX531fJXi0Y2sWR3sbwcdH5QC1UWCcsRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(36860700001)(36756003)(5660300002)(356005)(86362001)(44832011)(41300700001)(70206006)(4326008)(8936002)(8676002)(316002)(6636002)(40480700001)(82740400003)(40460700003)(81166007)(70586007)(110136005)(1076003)(478600001)(66574015)(47076005)(186003)(2906002)(16526019)(426003)(2616005)(336012)(7696005)(54906003)(83380400001)(26005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 15:56:28.2381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a17fa96-e656-4409-f851-08db798290a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix below checkpatch error & warnings:

ERROR: trailing statements should be on next line
+       default: BUG();

WARNING: braces {} are not necessary for single statement blocks
WARNING: braces {} are not necessary for any arm of this statement
WARNING: Block comments should align the * on each line

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 78 ++++++++++++---------------
 1 file changed, 33 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 581ed922dbe3..9b33a1013df5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -64,8 +64,7 @@ MODULE_FIRMWARE("amdgpu/polaris11_k_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris10_k_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris12_k_mc.bin");
 
-static const u32 golden_settings_tonga_a11[] =
-{
+static const u32 golden_settings_tonga_a11[] = {
 	mmMC_ARB_WTM_GRPWT_RD, 0x00000003, 0x00000000,
 	mmMC_HUB_RDREQ_DMIF_LIMIT, 0x0000007f, 0x00000028,
 	mmMC_HUB_WDP_UMC, 0x00007fb6, 0x00000991,
@@ -75,34 +74,29 @@ static const u32 golden_settings_tonga_a11[] =
 	mmVM_PRT_APERTURE3_LOW_ADDR, 0x0fffffff, 0x0fffffff,
 };
 
-static const u32 tonga_mgcg_cgcg_init[] =
-{
+static const u32 tonga_mgcg_cgcg_init[] = {
 	mmMC_MEM_POWER_LS, 0xffffffff, 0x00000104
 };
 
-static const u32 golden_settings_fiji_a10[] =
-{
+static const u32 golden_settings_fiji_a10[] = {
 	mmVM_PRT_APERTURE0_LOW_ADDR, 0x0fffffff, 0x0fffffff,
 	mmVM_PRT_APERTURE1_LOW_ADDR, 0x0fffffff, 0x0fffffff,
 	mmVM_PRT_APERTURE2_LOW_ADDR, 0x0fffffff, 0x0fffffff,
 	mmVM_PRT_APERTURE3_LOW_ADDR, 0x0fffffff, 0x0fffffff,
 };
 
-static const u32 fiji_mgcg_cgcg_init[] =
-{
+static const u32 fiji_mgcg_cgcg_init[] = {
 	mmMC_MEM_POWER_LS, 0xffffffff, 0x00000104
 };
 
-static const u32 golden_settings_polaris11_a11[] =
-{
+static const u32 golden_settings_polaris11_a11[] = {
 	mmVM_PRT_APERTURE0_LOW_ADDR, 0x0fffffff, 0x0fffffff,
 	mmVM_PRT_APERTURE1_LOW_ADDR, 0x0fffffff, 0x0fffffff,
 	mmVM_PRT_APERTURE2_LOW_ADDR, 0x0fffffff, 0x0fffffff,
 	mmVM_PRT_APERTURE3_LOW_ADDR, 0x0fffffff, 0x0fffffff
 };
 
-static const u32 golden_settings_polaris10_a11[] =
-{
+static const u32 golden_settings_polaris10_a11[] = {
 	mmMC_ARB_WTM_GRPWT_RD, 0x00000003, 0x00000000,
 	mmVM_PRT_APERTURE0_LOW_ADDR, 0x0fffffff, 0x0fffffff,
 	mmVM_PRT_APERTURE1_LOW_ADDR, 0x0fffffff, 0x0fffffff,
@@ -110,19 +104,16 @@ static const u32 golden_settings_polaris10_a11[] =
 	mmVM_PRT_APERTURE3_LOW_ADDR, 0x0fffffff, 0x0fffffff
 };
 
-static const u32 cz_mgcg_cgcg_init[] =
-{
+static const u32 cz_mgcg_cgcg_init[] = {
 	mmMC_MEM_POWER_LS, 0xffffffff, 0x00000104
 };
 
-static const u32 stoney_mgcg_cgcg_init[] =
-{
+static const u32 stoney_mgcg_cgcg_init[] = {
 	mmATC_MISC_CG, 0xffffffff, 0x000c0200,
 	mmMC_MEM_POWER_LS, 0xffffffff, 0x00000104
 };
 
-static const u32 golden_settings_stoney_common[] =
-{
+static const u32 golden_settings_stoney_common[] = {
 	mmMC_HUB_RDREQ_UVD, MC_HUB_RDREQ_UVD__PRESCALE_MASK, 0x00000004,
 	mmMC_RD_GRP_OTH, MC_RD_GRP_OTH__UVD_MASK, 0x00600000
 };
@@ -260,7 +251,8 @@ static int gmc_v8_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_STONEY:
 	case CHIP_VEGAM:
 		return 0;
-	default: BUG();
+	default:
+		BUG();
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
@@ -448,9 +440,9 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
 	}
 	WREG32(mmHDP_REG_COHERENCY_FLUSH_CNTL, 0);
 
-	if (gmc_v8_0_wait_for_idle((void *)adev)) {
+	if (gmc_v8_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
-	}
+
 	if (adev->mode_info.num_crtc) {
 		/* Lockout access through VGA aperture*/
 		tmp = RREG32(mmVGA_HDP_CONTROL);
@@ -483,9 +475,8 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_AGP_BASE, 0);
 	WREG32(mmMC_VM_AGP_TOP, 0x0FFFFFFF);
 	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
-	if (gmc_v8_0_wait_for_idle((void *)adev)) {
+	if (gmc_v8_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
-	}
 
 	WREG32(mmBIF_FB_EN, BIF_FB_EN__FB_READ_EN_MASK | BIF_FB_EN__FB_WRITE_EN_MASK);
 
@@ -517,11 +508,11 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 
 		/* Get VRAM informations */
 		tmp = RREG32(mmMC_ARB_RAMCFG);
-		if (REG_GET_FIELD(tmp, MC_ARB_RAMCFG, CHANSIZE)) {
+		if (REG_GET_FIELD(tmp, MC_ARB_RAMCFG, CHANSIZE))
 			chansize = 64;
-		} else {
+		else
 			chansize = 32;
-		}
+
 		tmp = RREG32(mmMC_SHARED_CHMAP);
 		switch (REG_GET_FIELD(tmp, MC_SHARED_CHMAP, NOOFCHAN)) {
 		case 0:
@@ -671,7 +662,7 @@ static void gmc_v8_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 }
 
 static uint64_t gmc_v8_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-					    unsigned vmid, uint64_t pd_addr)
+					    unsigned int vmid, uint64_t pd_addr)
 {
 	uint32_t reg;
 
@@ -687,8 +678,8 @@ static uint64_t gmc_v8_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	return pd_addr;
 }
 
-static void gmc_v8_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid,
-					unsigned pasid)
+static void gmc_v8_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int vmid,
+					unsigned int pasid)
 {
 	amdgpu_ring_emit_wreg(ring, mmIH_VMID_0_LUT + vmid, pasid);
 }
@@ -759,11 +750,11 @@ static void gmc_v8_0_set_fault_enable_default(struct amdgpu_device *adev,
 }
 
 /**
- * gmc_v8_0_set_prt - set PRT VM fault
+ * gmc_v8_0_set_prt() - set PRT VM fault
  *
  * @adev: amdgpu_device pointer
  * @enable: enable/disable VM fault handling for PRT
-*/
+ */
 static void gmc_v8_0_set_prt(struct amdgpu_device *adev, bool enable)
 {
 	u32 tmp;
@@ -940,7 +931,7 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
 
 	gmc_v8_0_flush_gpu_tlb(adev, 0, 0, 0);
 	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
-		 (unsigned)(adev->gmc.gart_size >> 20),
+		 (unsigned int)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)table_addr);
 	return 0;
 }
@@ -1001,7 +992,7 @@ static void gmc_v8_0_gart_disable(struct amdgpu_device *adev)
  * Print human readable fault information (VI).
  */
 static void gmc_v8_0_vm_decode_fault(struct amdgpu_device *adev, u32 status,
-				     u32 addr, u32 mc_client, unsigned pasid)
+				     u32 addr, u32 mc_client, unsigned int pasid)
 {
 	u32 vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS, VMID);
 	u32 protections = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -1071,15 +1062,16 @@ static int gmc_v8_0_late_init(void *handle)
 		return 0;
 }
 
-static unsigned gmc_v8_0_get_vbios_fb_size(struct amdgpu_device *adev)
+static unsigned int gmc_v8_0_get_vbios_fb_size(struct amdgpu_device *adev)
 {
 	u32 d1vga_control = RREG32(mmD1VGA_CONTROL);
-	unsigned size;
+	unsigned int size;
 
 	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
 		size = AMDGPU_VBIOS_VGA_ALLOCATION;
 	} else {
 		u32 viewport = RREG32(mmVIEWPORT_SIZE);
+
 		size = (REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
 			REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_WIDTH) *
 			4);
@@ -1283,7 +1275,7 @@ static bool gmc_v8_0_is_idle(void *handle)
 
 static int gmc_v8_0_wait_for_idle(void *handle)
 {
-	unsigned i;
+	unsigned int i;
 	u32 tmp;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
@@ -1336,9 +1328,8 @@ static int gmc_v8_0_pre_soft_reset(void *handle)
 		return 0;
 
 	gmc_v8_0_mc_stop(adev);
-	if (gmc_v8_0_wait_for_idle(adev)) {
+	if (gmc_v8_0_wait_for_idle(adev))
 		dev_warn(adev->dev, "Wait for GMC idle timed out !\n");
-	}
 
 	return 0;
 }
@@ -1387,7 +1378,7 @@ static int gmc_v8_0_post_soft_reset(void *handle)
 
 static int gmc_v8_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *src,
-					     unsigned type,
+					     unsigned int type,
 					     enum amdgpu_interrupt_state state)
 {
 	u32 tmp;
@@ -1748,8 +1739,7 @@ static void gmc_v8_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gmc.vm_fault.funcs = &gmc_v8_0_irq_funcs;
 }
 
-const struct amdgpu_ip_block_version gmc_v8_0_ip_block =
-{
+const struct amdgpu_ip_block_version gmc_v8_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_GMC,
 	.major = 8,
 	.minor = 0,
@@ -1757,8 +1747,7 @@ const struct amdgpu_ip_block_version gmc_v8_0_ip_block =
 	.funcs = &gmc_v8_0_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version gmc_v8_1_ip_block =
-{
+const struct amdgpu_ip_block_version gmc_v8_1_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_GMC,
 	.major = 8,
 	.minor = 1,
@@ -1766,8 +1755,7 @@ const struct amdgpu_ip_block_version gmc_v8_1_ip_block =
 	.funcs = &gmc_v8_0_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version gmc_v8_5_ip_block =
-{
+const struct amdgpu_ip_block_version gmc_v8_5_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_GMC,
 	.major = 8,
 	.minor = 5,
-- 
2.25.1

