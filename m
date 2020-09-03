Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC35C43461
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 21:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECE4206E7
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 21:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xrCl1rp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECE4206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2009C6E934;
	Thu,  3 Sep 2020 21:12:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D49156E934
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 21:12:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjHMCqi3IZkugAUtWAhlrAYByfcc8wWX9VlxvI9H1FYn0v58Zq7fY/4spSLNbCqZsNvRAuJvRbvDfC/WU1KdF3/n0fyCStOusl9QGMKCBkccHC44OlXFJaUrKNa2wRb5YGyvKYOKk3tkLjcniiB6c9hBCUQosa2l5lqjWN8sgPxzagQ8ojhkJ0JMnSyRNu8jRVcVr0uI+z0gGLnbBeZM37geVUCvpumRqclpO30SfPncorNJL2jUabkzckwDsXCvMlb8uO99Ha4RpYZNd0iRbCECzHqNlhpaaTjXshakdEA4lHvPIC26IhsqDs/KP8mSEaQ6hjNb8hO5cjyNVFEYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc6oPxoBDyfd9YzkRhpibQoCLqYfxoAmyPssmtl6c3k=;
 b=HJhI7tWZSLJpyVEFv30Q6+X+3wRZQmlYanlHdKCw3YO3lxaeqb63RCLsrMuzeMvnoTUkUUy9aiWMP22pupkF8d6OwqvopayFgn3MxzVUK2iQgOW+KhYIeDnHFVxWcuGqD9U8uOg3ez6WATGuHJBHrNgAxb7dT38EsNZGLHSMdhgKQc/auoUEbwtq5Yo4sQOLN4YyjCoDFKAv1H01gw6b5rXQbOR3piRrsB2ksBbMEVYuAK//YEhMCtl3puS4VYEZhFVbXc+w4Vv5Pi4xpYZquQauGJMzhT9eO/PMWXZjzN/+AwBilxLz+aN1wGpSqSL5GFVHCEC237M2DrGMu0s5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc6oPxoBDyfd9YzkRhpibQoCLqYfxoAmyPssmtl6c3k=;
 b=xrCl1rp8fPFV41Yadcmo4lJDCLeXSIvdI5cpe1plHIW6xRIEU7GdrAdgrgsFbjitey1ON6Wk4wtw0L1zwWlhhbWLNcTM/s3ocKoQHLXa+wlsz785zWmOUbCZEWmCMEdbRnn3Hf5+f2n1AKuPACBChvdgt63AkV/Ro8hiIm4ojuE=
Received: from CO2PR18CA0055.namprd18.prod.outlook.com (2603:10b6:104:2::23)
 by BY5PR12MB3779.namprd12.prod.outlook.com (2603:10b6:a03:1a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 21:12:27 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::cc) by CO2PR18CA0055.outlook.office365.com
 (2603:10b6:104:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Thu, 3 Sep 2020 21:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Thu, 3 Sep 2020 21:12:26 +0000
Received: from rkhaire-dev2.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 3 Sep 2020
 16:12:24 -0500
From: Rohit Khaire <rohit.khaire@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix L1 policy violations (PSP) on Navi21 SRIOV
Date: Thu, 3 Sep 2020 17:11:46 -0400
Message-ID: <20200903211146.6692-1-rohit.khaire@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB02.amd.com (10.181.40.143) To SATLEXMB01.amd.com
 (10.181.40.142)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8aa97a3a-b6d4-4897-62b9-08d8504e0f63
X-MS-TrafficTypeDiagnostic: BY5PR12MB3779:
X-Microsoft-Antispam-PRVS: <BY5PR12MB37796571E13DC935AAE377EA872C0@BY5PR12MB3779.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7X1ZUYRfenO6uUdbPCiqmAFeQ8JBZaIyK0FOeWdFNJZZqTq1gAAQosOy6ANaeYm7edLlpWO81wXF2yUPeKTbdRTevx4THzPCZozp4CojPe1xKdHSseDnScUJ5xXPQXXve7ZJCIl/bQtjNVmyknydToNt1p4PtYSB2exCDaGR03AZvbAhiFndLHx63dgTCv5ftBLkIpBBYr4p502ck0Af1PnyR6KTXYU07p+gpZcTgB9pWfb834c1NMtCMpOTCmFiaRqvnDQHmTVm2la954f3NurqYniz8DQzvAVjFtDE6E08kpHpqraRM+cr6HR6OzYT5BZlvwnUiKLlHvwI7YWspVOoVMOrPeUBqAsyM35WOOTp4ByWOAl3C6hi2HigNVve1/ROFlzK4q+uaUhCj+TKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966005)(2906002)(426003)(8676002)(336012)(478600001)(70206006)(70586007)(6916009)(186003)(44832011)(83380400001)(2616005)(316002)(4326008)(16526019)(82310400003)(7696005)(30864003)(8936002)(81166007)(82740400003)(6666004)(86362001)(1076003)(26005)(36756003)(47076004)(356005)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 21:12:26.7258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa97a3a-b6d4-4897-62b9-08d8504e0f63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3779
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
Cc: Rohit Khaire <rohit.khaire@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 49 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 64 +++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 42 ++++++++--------
 3 files changed, 95 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d502e30f67d9..4bafbd453e53 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4808,14 +4808,23 @@ static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
 
 void gfx_v10_0_rlc_stop(struct amdgpu_device *adev)
 {
-	u32 tmp = RREG32_SOC15(GC, 0, mmRLC_CNTL);
+	u32 tmp;
 
+	/* For SRIOV, don't touch RLC_G */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	tmp = RREG32_SOC15(GC, 0, mmRLC_CNTL);
 	tmp = REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 0);
 	WREG32_SOC15(GC, 0, mmRLC_CNTL, tmp);
 }
 
 static void gfx_v10_0_rlc_reset(struct amdgpu_device *adev)
 {
+	/* For SRIOV, don't touch RLC_G */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	WREG32_FIELD15(GC, 0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
 	udelay(50);
 	WREG32_FIELD15(GC, 0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 0);
@@ -4846,6 +4855,10 @@ static void gfx_v10_0_rlc_smu_handshake_cntl(struct amdgpu_device *adev,
 
 static void gfx_v10_0_rlc_start(struct amdgpu_device *adev)
 {
+	/* For SRIOV, don't touch RLC_G */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* TODO: enable rlc & smu handshake until smu
 	 * and gfxoff feature works as expected */
 	if (!(amdgpu_pp_feature_mask & PP_GFXOFF_MASK))
@@ -4859,6 +4872,10 @@ static void gfx_v10_0_rlc_enable_srm(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
 
+	/* For SRIOV, don't touch RLC_G */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* enable Save Restore Machine */
 	tmp = RREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_SRM_CNTL));
 	tmp |= RLC_SRM_CNTL__AUTO_INCR_ADDR_MASK;
@@ -4872,6 +4889,10 @@ static int gfx_v10_0_rlc_load_microcode(struct amdgpu_device *adev)
 	const __le32 *fw_data;
 	unsigned i, fw_size;
 
+	/* For SRIOV, don't touch RLC_G */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (!adev->gfx.rlc_fw)
 		return -EINVAL;
 
@@ -4906,8 +4927,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
 
 		gfx_v10_0_init_csb(adev);
 
-		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
-			gfx_v10_0_rlc_enable_srm(adev);
+		gfx_v10_0_rlc_enable_srm(adev);
 	} else {
 		if (amdgpu_sriov_vf(adev)) {
 			gfx_v10_0_init_csb(adev);
@@ -6990,7 +7010,6 @@ static int gfx_v10_0_hw_fini(void *handle)
 	if (amdgpu_gfx_disable_kcq(adev))
 		DRM_ERROR("KCQ disable failed\n");
 	if (amdgpu_sriov_vf(adev)) {
-		gfx_v10_0_cp_gfx_enable(adev, false);
 		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
 		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
 		tmp &= 0xffffff00;
@@ -7272,6 +7291,10 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 {
 	uint32_t data, def;
 
+	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* It is disabled by HW by default */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
 		/* 0 - Disable some blocks' MGCG */
@@ -7339,6 +7362,10 @@ static void gfx_v10_0_update_3d_clock_gating(struct amdgpu_device *adev,
 {
 	uint32_t data, def;
 
+	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* Enable 3D CGCG/CGLS */
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
 		/* write cmd to clear cgcg/cgls ov */
@@ -7381,6 +7408,10 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 {
 	uint32_t def, data;
 
+	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset CGCG override */
@@ -7422,6 +7453,10 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
+	/* For SRIOV, guest VM should not touch CGCG and PG stuff */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	amdgpu_gfx_rlc_enter_safe_mode(adev);
 
 	if (enable) {
@@ -7584,6 +7619,12 @@ static void gfx_v10_0_get_clockgating_state(void *handle, u32 *flags)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
 
+	/* bypass PG and CG on SRIOV VF */
+	if (amdgpu_sriov_vf(adev)) {
+		*flags = 0;
+		return;
+	}
+
 	/* AMD_CG_SUPPORT_GFX_MGCG */
 	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
 	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 237a9ff5afa0..44ebb2722c4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -152,33 +152,35 @@ static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 
-	/* Disable AGP. */
-	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
-
-	/* Program the system aperture low logical page number. */
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-		     adev->gmc.vram_start >> 18);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-		     adev->gmc.vram_end >> 18);
-
-	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
-		+ adev->vm_manager.vram_base_offset;
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-		     (u32)(value >> 12));
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
-		     (u32)(value >> 44));
+	if (!amdgpu_sriov_vf(adev)) {
+		/* Disable AGP. */
+		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
+		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
+		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
+
+		/* Program the system aperture low logical page number. */
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+				adev->gmc.vram_start >> 18);
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+				adev->gmc.vram_end >> 18);
+
+		/* Set default page address. */
+		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
+			+ adev->vm_manager.vram_base_offset;
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+				(u32)(value >> 12));
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+				(u32)(value >> 44));
+	}
 
 	/* Program "protection fault". */
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
-		     (u32)(adev->dummy_page_addr >> 12));
+				 (u32)(adev->dummy_page_addr >> 12));
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
-		     (u32)((u64)adev->dummy_page_addr >> 44));
+				 (u32)((u64)adev->dummy_page_addr >> 44));
 
 	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
-		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+				   ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
 }
 
 
@@ -350,18 +352,6 @@ static void gfxhub_v2_1_program_invalidation(struct amdgpu_device *adev)
 
 int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev)) {
-		/*
-		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
-		WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
-	}
-
 	/* GART Enable. */
 	gfxhub_v2_1_init_gart_aperture_regs(adev);
 	gfxhub_v2_1_init_system_aperture_regs(adev);
@@ -394,9 +384,11 @@ void gfxhub_v2_1_gart_disable(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 0);
 	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);
 
-	/* Setup L2 cache */
-	WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
-	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
+	if (!amdgpu_sriov_vf(adev)) {
+		/* Setup L2 cache */
+		WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
+		WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 2d88278c50bf..99f697e63e3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -211,26 +211,26 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 			     adev->gmc.vram_start >> 18);
 		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
 			     adev->gmc.vram_end >> 18);
-	}
 
-	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-		     (u32)(value >> 12));
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
-		     (u32)(value >> 44));
-
-	/* Program "protection fault". */
-	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
-		     (u32)(adev->dummy_page_addr >> 12));
-	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
-		     (u32)((u64)adev->dummy_page_addr >> 44));
-
-	tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2);
-	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
-			    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
-	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+		/* Set default page address. */
+		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
+			adev->vm_manager.vram_base_offset;
+		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+				(u32)(value >> 12));
+		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+				(u32)(value >> 44));
+
+		/* Program "protection fault". */
+		WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+				(u32)(adev->dummy_page_addr >> 12));
+		WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+				(u32)((u64)adev->dummy_page_addr >> 44));
+
+		tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
+					ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+		WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+	}
 }
 
 static void mmhub_v2_0_init_tlb_regs(struct amdgpu_device *adev)
@@ -656,8 +656,10 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 {
 	int data, data1;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		*flags = 0;
+		return;
+	}
 
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
