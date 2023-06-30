Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC6CEB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 15:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F8C10E4A1;
	Fri, 30 Jun 2023 15:56:31 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBF410E4A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 15:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDVz1jIWET0kls4QudVgrb5n2wyqyWZxWfmxwXFSjN2dWYIqSwFA7GBLoYhN3HDUtXVCRnr6SmGofNER7tuVqA82g4MmhKd2Jja20Buz9WQdjmMIedS2LiBldUvGa9kTHwdSkReFF+U8W5jRgbktmC0g7it2Az1LptLPa5CNmOKy7djqVcaMiPeIKjekjatRRraLextL/FgqZ2W9c5RT1PjVYiAY1HfKMeSBxpLro0fXonRWnaTaM6ZlFh6Vjzet/3+Z2onkzYiEyPTU7/R3kmDSLs9/ffGtRMU2cMgj9D0t0BtJ0suTmTpD88nUkSpEYVfRuQFiE/b07cmgU+371w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccfVmYtzJtBgFU/Yz66XrrAh4ZEmeKFzdTKyuzropQ4=;
 b=TYcn8gUqZOLBt1IRiXl8qX5Hk9Gk1cnRrmjIthoR67wnEw3aJwIgkJ8HxAR/mC89aWagqM30wDm1XL0zkL7T2xrtTP/ALep0JevZO/xVCv/UB0JI+95dsBMchzwnUgfzITJ80kl1gQL75EqT92rxxApfeId3pz+m41raa/HDQUuq8Ra76NrK+IuGSNwl9vyo1GyxIjsCJGo98nJF6KqzGYctEVZGosIOp6Lxvkhm4mZcoZ9W1h6Cge7+nP7j+Vy5uIxkgPxOXiEGegVYvwsc4htTHAALi9IdxR5kBSfV/95RCdh14CG1INSot693NtVSWQ134FuF8zcr6WH8AZKL5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccfVmYtzJtBgFU/Yz66XrrAh4ZEmeKFzdTKyuzropQ4=;
 b=jvXrCZOZqYjRXZvvmY/zD//Y0OuSrRAM9lOWxSs6xXaMpFdu4EdRF++uEvskx/gNo0+bTtgUkflgqK52JeniIYgx3r+0BpQXCYJt9a//DPN6tjIyzQRzxlLWYpjzalb49y9UgCmv9Z6ynvCto/L4ZZWUZV7kOyioDSNQGxBUc6Y=
Received: from BN9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::9)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 15:56:27 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::a6) by BN9P221CA0002.outlook.office365.com
 (2603:10b6:408:10a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 15:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.51 via Frontend Transport; Fri, 30 Jun 2023 15:56:26 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 10:56:24 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: Fix errors & warnings in gmc_ v6_0, v7_0.c
Date: Fri, 30 Jun 2023 21:26:00 +0530
Message-ID: <20230630155603.3388617-4-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT030:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e9e4fa-bdd1-481c-75c3-08db79828fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxZ/0Yru6wKLQMUPAeMuia/P6z3iP/hc90w7zmwtGEoCLnUYjBdwdvp02TwVXK2ukWpa2l0k3hZdPcXs9yL42SegHgwkWiODSux+Jm0bVlHHXny3fOLnbVipjqpvNXBccA1OoqGCXERJBi0d/qGc+pjlbA+MHnR+1jBYK2N/7XCamRcwhAzMlW906MGVFN1Y8/elS6rjKH9TiePh7617h9GQ6fEOCsNPMrVsVzk86b8oFYRH4yHei10JxRycJV34MLMtfsjGB7yRXb7ZJUAYySWehGlLiaMjXqP6ugOGvnpS1lDIjLocIzLGWjJG/mtgm+FaFuVWRnEmtXPZ4FIMrkEqU2Fs4Vevdz3fD7DecNEXARm5aVYJYkSJ6y9TAjoNsY8dm5McAdFwM/H75hcLNGBDo1x3/Qj/uplUBecllTHunBL2pOmJcAlBE/2Y32+jut/70W2NkXQK48rln6UwlcPUYVSt/k2V6k7gayq8yDYs00y6Bl4/5T2Dvt3gCH/GOVOKnE9rf6Ae3GK2XmaQiaoxv+G/ccukwRKOsh/NMX3ijcHzXFol2jlKSdjHCJhZTwwcFYsMShn43rw0bYoVuzyepK6Kx4CHDhtw/3+o16ted2gOzOE0yQ+S0H9JVgLPrGUZJhoGaffVhH0QqicLCcHsyYiQiBz+3oTUe9WMLNRgsXmorqM0EPzxLPaTGJgh6w1rnve/5JpOajp/a1NFqUyjRqmxqxD8ZH3IrG1PW281kldGSRu+n7gJ/9ERDE9TgXRH3abP8dJzy62+DmrVnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(336012)(426003)(66574015)(47076005)(40460700003)(83380400001)(30864003)(2616005)(2906002)(81166007)(356005)(82740400003)(36860700001)(40480700001)(36756003)(8936002)(8676002)(82310400005)(110136005)(5660300002)(86362001)(54906003)(41300700001)(6636002)(4326008)(70206006)(70586007)(6666004)(316002)(7696005)(478600001)(16526019)(186003)(44832011)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 15:56:26.6921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e9e4fa-bdd1-481c-75c3-08db79828fbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
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

Fix below checkpatch errors & warnings:

ERROR: trailing statements should be on next line
+       default: BUG();
ERROR: trailing statements should be on next line

WARNING: braces {} are not necessary for single statement blocks
WARNING: braces {} are not necessary for any arm of this statement
WARNING: Block comments use * on subsequent lines
WARNING: Missing a blank line after declarations
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 52 +++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 53 +++++++++++++--------------
 2 files changed, 50 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index aa754c95a0b3..5b837a65fad2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -120,7 +120,8 @@ static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_HAINAN:
 		chip_name = "hainan";
 		break;
-	default: BUG();
+	default:
+		BUG();
 	}
 
 	/* this memory configuration requires special firmware */
@@ -178,9 +179,8 @@ static int gmc_v6_0_mc_load_microcode(struct amdgpu_device *adev)
 			WREG32(mmMC_SEQ_IO_DEBUG_DATA, le32_to_cpup(new_io_mc_regs++));
 		}
 		/* load the MC ucode */
-		for (i = 0; i < ucode_size; i++) {
+		for (i = 0; i < ucode_size; i++)
 			WREG32(mmMC_SEQ_SUP_PGM, le32_to_cpup(new_fw_data++));
-		}
 
 		/* put the engine back into the active state */
 		WREG32(mmMC_SEQ_SUP_CNTL, 0x00000008);
@@ -208,6 +208,7 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
 				       struct amdgpu_gmc *mc)
 {
 	u64 base = RREG32(mmMC_VM_FB_LOCATION) & 0xFFFF;
+
 	base <<= 24;
 
 	amdgpu_gmc_vram_location(adev, mc, base);
@@ -228,9 +229,8 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
 	}
 	WREG32(mmHDP_REG_COHERENCY_FLUSH_CNTL, 0);
 
-	if (gmc_v6_0_wait_for_idle((void *)adev)) {
+	if (gmc_v6_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
-	}
 
 	if (adev->mode_info.num_crtc) {
 		u32 tmp;
@@ -256,9 +256,8 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_AGP_TOP, 0x0FFFFFFF);
 	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
 
-	if (gmc_v6_0_wait_for_idle((void *)adev)) {
+	if (gmc_v6_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
-	}
 }
 
 static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
@@ -269,13 +268,13 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
 	int r;
 
 	tmp = RREG32(mmMC_ARB_RAMCFG);
-	if (tmp & (1 << 11)) {
+	if (tmp & (1 << 11))
 		chansize = 16;
-	} else if (tmp & MC_ARB_RAMCFG__CHANSIZE_MASK) {
+	else if (tmp & MC_ARB_RAMCFG__CHANSIZE_MASK)
 		chansize = 64;
-	} else {
+	else
 		chansize = 32;
-	}
+
 	tmp = RREG32(mmMC_SHARED_CHMAP);
 	switch ((tmp & MC_SHARED_CHMAP__NOOFCHAN_MASK) >> MC_SHARED_CHMAP__NOOFCHAN__SHIFT) {
 	case 0:
@@ -352,7 +351,7 @@ static void gmc_v6_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 }
 
 static uint64_t gmc_v6_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-					    unsigned vmid, uint64_t pd_addr)
+					    unsigned int vmid, uint64_t pd_addr)
 {
 	uint32_t reg;
 
@@ -405,11 +404,11 @@ static void gmc_v6_0_set_fault_enable_default(struct amdgpu_device *adev,
 }
 
  /**
-   + * gmc_v8_0_set_prt - set PRT VM fault
-   + *
-   + * @adev: amdgpu_device pointer
-   + * @enable: enable/disable VM fault handling for PRT
-   +*/
+  * gmc_v8_0_set_prt() - set PRT VM fault
+  *
+  * @adev: amdgpu_device pointer
+  * @enable: enable/disable VM fault handling for PRT
+  */
 static void gmc_v6_0_set_prt(struct amdgpu_device *adev, bool enable)
 {
 	u32 tmp;
@@ -547,7 +546,7 @@ static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)
 
 	gmc_v6_0_flush_gpu_tlb(adev, 0, 0, 0);
 	dev_info(adev->dev, "PCIE GART of %uM enabled (table at 0x%016llX).\n",
-		 (unsigned)(adev->gmc.gart_size >> 20),
+		 (unsigned int)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)table_addr);
 	return 0;
 }
@@ -787,15 +786,16 @@ static int gmc_v6_0_late_init(void *handle)
 		return 0;
 }
 
-static unsigned gmc_v6_0_get_vbios_fb_size(struct amdgpu_device *adev)
+static unsigned int gmc_v6_0_get_vbios_fb_size(struct amdgpu_device *adev)
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
@@ -814,6 +814,7 @@ static int gmc_v6_0_sw_init(void *handle)
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_UNKNOWN;
 	} else {
 		u32 tmp = RREG32(mmMC_SEQ_MISC0);
+
 		tmp &= MC_SEQ_MISC0__MT__MASK;
 		adev->gmc.vram_type = gmc_v6_0_convert_vram_type(tmp);
 	}
@@ -964,7 +965,7 @@ static bool gmc_v6_0_is_idle(void *handle)
 
 static int gmc_v6_0_wait_for_idle(void *handle)
 {
-	unsigned i;
+	unsigned int i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -995,10 +996,8 @@ static int gmc_v6_0_soft_reset(void *handle)
 
 	if (srbm_soft_reset) {
 		gmc_v6_0_mc_stop(adev);
-		if (gmc_v6_0_wait_for_idle(adev)) {
+		if (gmc_v6_0_wait_for_idle(adev))
 			dev_warn(adev->dev, "Wait for GMC idle timed out !\n");
-		}
-
 
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
@@ -1023,7 +1022,7 @@ static int gmc_v6_0_soft_reset(void *handle)
 
 static int gmc_v6_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *src,
-					     unsigned type,
+					     unsigned int type,
 					     enum amdgpu_interrupt_state state)
 {
 	u32 tmp;
@@ -1141,8 +1140,7 @@ static void gmc_v6_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gmc.vm_fault.funcs = &gmc_v6_0_irq_funcs;
 }
 
-const struct amdgpu_ip_block_version gmc_v6_0_ip_block =
-{
+const struct amdgpu_ip_block_version gmc_v6_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_GMC,
 	.major = 6,
 	.minor = 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 027b14603037..0629b6808cb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -58,16 +58,14 @@ MODULE_FIRMWARE("amdgpu/bonaire_mc.bin");
 MODULE_FIRMWARE("amdgpu/hawaii_mc.bin");
 MODULE_FIRMWARE("amdgpu/topaz_mc.bin");
 
-static const u32 golden_settings_iceland_a11[] =
-{
+static const u32 golden_settings_iceland_a11[] = {
 	mmVM_PRT_APERTURE0_LOW_ADDR, 0x0fffffff, 0x0fffffff,
 	mmVM_PRT_APERTURE1_LOW_ADDR, 0x0fffffff, 0x0fffffff,
 	mmVM_PRT_APERTURE2_LOW_ADDR, 0x0fffffff, 0x0fffffff,
 	mmVM_PRT_APERTURE3_LOW_ADDR, 0x0fffffff, 0x0fffffff
 };
 
-static const u32 iceland_mgcg_cgcg_init[] =
-{
+static const u32 iceland_mgcg_cgcg_init[] = {
 	mmMC_MEM_POWER_LS, 0xffffffff, 0x00000104
 };
 
@@ -151,7 +149,8 @@ static int gmc_v7_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_KABINI:
 	case CHIP_MULLINS:
 		return 0;
-	default: BUG();
+	default:
+		BUG();
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
@@ -237,6 +236,7 @@ static void gmc_v7_0_vram_gtt_location(struct amdgpu_device *adev,
 				       struct amdgpu_gmc *mc)
 {
 	u64 base = RREG32(mmMC_VM_FB_LOCATION) & 0xFFFF;
+
 	base <<= 24;
 
 	amdgpu_gmc_vram_location(adev, mc, base);
@@ -266,9 +266,9 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
 	}
 	WREG32(mmHDP_REG_COHERENCY_FLUSH_CNTL, 0);
 
-	if (gmc_v7_0_wait_for_idle((void *)adev)) {
+	if (gmc_v7_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
-	}
+
 	if (adev->mode_info.num_crtc) {
 		/* Lockout access through VGA aperture*/
 		tmp = RREG32(mmVGA_HDP_CONTROL);
@@ -290,9 +290,8 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_AGP_BASE, 0);
 	WREG32(mmMC_VM_AGP_TOP, 0x0FFFFFFF);
 	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
-	if (gmc_v7_0_wait_for_idle((void *)adev)) {
+	if (gmc_v7_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
-	}
 
 	WREG32(mmBIF_FB_EN, BIF_FB_EN__FB_READ_EN_MASK | BIF_FB_EN__FB_WRITE_EN_MASK);
 
@@ -324,11 +323,11 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 
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
@@ -472,7 +471,7 @@ static void gmc_v7_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 }
 
 static uint64_t gmc_v7_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-					    unsigned vmid, uint64_t pd_addr)
+					    unsigned int vmid, uint64_t pd_addr)
 {
 	uint32_t reg;
 
@@ -488,8 +487,8 @@ static uint64_t gmc_v7_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	return pd_addr;
 }
 
-static void gmc_v7_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid,
-					unsigned pasid)
+static void gmc_v7_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int vmid,
+					unsigned int pasid)
 {
 	amdgpu_ring_emit_wreg(ring, mmIH_VMID_0_LUT + vmid, pasid);
 }
@@ -700,7 +699,7 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)
 
 	gmc_v7_0_flush_gpu_tlb(adev, 0, 0, 0);
 	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
-		 (unsigned)(adev->gmc.gart_size >> 20),
+		 (unsigned int)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)table_addr);
 	return 0;
 }
@@ -761,7 +760,7 @@ static void gmc_v7_0_gart_disable(struct amdgpu_device *adev)
  * Print human readable fault information (CIK).
  */
 static void gmc_v7_0_vm_decode_fault(struct amdgpu_device *adev, u32 status,
-				     u32 addr, u32 mc_client, unsigned pasid)
+				     u32 addr, u32 mc_client, unsigned int pasid)
 {
 	u32 vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS, VMID);
 	u32 protections = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -957,15 +956,16 @@ static int gmc_v7_0_late_init(void *handle)
 		return 0;
 }
 
-static unsigned gmc_v7_0_get_vbios_fb_size(struct amdgpu_device *adev)
+static unsigned int gmc_v7_0_get_vbios_fb_size(struct amdgpu_device *adev)
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
@@ -985,6 +985,7 @@ static int gmc_v7_0_sw_init(void *handle)
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_UNKNOWN;
 	} else {
 		u32 tmp = RREG32(mmMC_SEQ_MISC0);
+
 		tmp &= MC_SEQ_MISC0__MT__MASK;
 		adev->gmc.vram_type = gmc_v7_0_convert_vram_type(tmp);
 	}
@@ -1153,7 +1154,7 @@ static bool gmc_v7_0_is_idle(void *handle)
 
 static int gmc_v7_0_wait_for_idle(void *handle)
 {
-	unsigned i;
+	unsigned int i;
 	u32 tmp;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
@@ -1191,10 +1192,8 @@ static int gmc_v7_0_soft_reset(void *handle)
 
 	if (srbm_soft_reset) {
 		gmc_v7_0_mc_stop(adev);
-		if (gmc_v7_0_wait_for_idle((void *)adev)) {
+		if (gmc_v7_0_wait_for_idle((void *)adev))
 			dev_warn(adev->dev, "Wait for GMC idle timed out !\n");
-		}
-
 
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
@@ -1220,7 +1219,7 @@ static int gmc_v7_0_soft_reset(void *handle)
 
 static int gmc_v7_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *src,
-					     unsigned type,
+					     unsigned int type,
 					     enum amdgpu_interrupt_state state)
 {
 	u32 tmp;
@@ -1384,8 +1383,7 @@ static void gmc_v7_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gmc.vm_fault.funcs = &gmc_v7_0_irq_funcs;
 }
 
-const struct amdgpu_ip_block_version gmc_v7_0_ip_block =
-{
+const struct amdgpu_ip_block_version gmc_v7_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_GMC,
 	.major = 7,
 	.minor = 0,
@@ -1393,8 +1391,7 @@ const struct amdgpu_ip_block_version gmc_v7_0_ip_block =
 	.funcs = &gmc_v7_0_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version gmc_v7_4_ip_block =
-{
+const struct amdgpu_ip_block_version gmc_v7_4_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_GMC,
 	.major = 7,
 	.minor = 4,
-- 
2.25.1

