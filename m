Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFDFC55189
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD822071C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LINOgAwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD822071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AEBC6E13C;
	Wed, 22 Apr 2020 22:08:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770040.outbound.protection.outlook.com [40.107.77.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C0176E12E
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YX/il9ZTAqX78ofD/oNrqxPPrTvqlOnTLesI6mUENpY/pKUWv/y+7j7pZGUtxwXik5fLO3b7Hv5CLqw7rBkmYCBakeRsqnXbT8fkCeaW/0/nhPb7O7mVEOL+Lgdd06iIym6cAEuABazp10XFPGTBZhWX+C7GWezVPmNoe2ZhV2/PiYPge59Js3n1zcAMTzs3hLnZfSqIL5694ki7S3x0aEyBmh0ofXnWy+ubHQTqkd2k7RUetKygTCnU+1XWY7XBiaRB6e7aniKi/gPJh+oLPAhNeUUcpTLRw5Y7zy+zeNs/Ii35/nNcDLHB1PdPKnZU1lXHKRitz/xAJZS9s3qsgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryfQqJb32/IvfhObhHesH+qmMZozJRVv9QcaVbWZVKc=;
 b=TdHdMf1nGjufkq+E863i7qzxBCDLnayvYXYsts50+NOIGkYkPKd9526P59ye/g8QMkX7kH6l53cT2d4VCcXjKBNITExtZAEhDw6VCe9hQMhL3UOWTgM1zhkby7vUP0U3sDAu+eVfqCoklIkoKpXYzo6cJlMgSTlYyLNrC83hGw0kNJCOYcc6pccEnsFbclYOyXGcfn+amBYiF2nZsaQmZIE3IDR+nYO6aOmxrDl/CIpmgdiNs3C50+cE9JhoKLj1XnrRguYPB/2SRMqVmudFvzxjrZb8hL+Ni0KVF9do1ZOKilGOpivcFyRxuoT3Yt6EMbHuTFskPZQSn46RNAEdCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryfQqJb32/IvfhObhHesH+qmMZozJRVv9QcaVbWZVKc=;
 b=LINOgAwX1c6LapuV3necgW0m2w5gAVvhnkBoGgLGy58adICiYoQ8sI57BJBg7p84BvT0O7sLPJI51/siaFW9lJKXC0qOyzlr7L24osk7qepDVXTHLq7mwXVHDPBz8b8DppE5j74nxIr42aplUAjyk/isKAgtl9+L+oKN2+WSQxw=
Received: from MWHPR20CA0014.namprd20.prod.outlook.com (2603:10b6:300:13d::24)
 by CY4PR1201MB0230.namprd12.prod.outlook.com (2603:10b6:910:1e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 22 Apr
 2020 22:08:31 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::7c) by MWHPR20CA0014.outlook.office365.com
 (2603:10b6:300:13d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:31 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:29 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:29 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:28 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/19] drm/amd/display: Internal refactoring to abstract color
 caps
Date: Wed, 22 Apr 2020 18:08:02 -0400
Message-ID: <20200422220805.15759-17-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(428003)(46966005)(478600001)(70586007)(44832011)(6666004)(7696005)(2906002)(82310400002)(81166007)(336012)(426003)(70206006)(36756003)(81156014)(8936002)(26005)(6916009)(316002)(47076004)(356005)(30864003)(82740400003)(54906003)(1076003)(4326008)(186003)(5660300002)(8676002)(2616005)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07261971-bf07-4557-3018-08d7e709b102
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0230:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02304D0F699E77E102DCB9DB8BD20@CY4PR1201MB0230.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXN07I1N8cokGs20FW2lrjrkIF1FQWGDf1A4t/YKY3+iiFXr+AhThCi4R4CsQ+JHRcRVv9jV9pRiZKg2S1WipIglGYvfPXvk/y4zUNopngh/ZDdfnc3P64JHuVTeogSO/WIfqBxjk5DyqBcM8vMBHJggbQURz/CM0ceqKsqouecCtWYWWzgBClAaY5ZVp4htIsxfC5dgqW35IS/pvZimAVhL54wLaF+heOxLO8VdD3zD9nSol3YuHQ5GJqeWYfpXwfyu9DZdKIMo6X4TTPMImXcrGoVmUBE2SCdGX2TJ7yKivOFFGMpoV1yEaFH57VPRRxLCHGlB3ugaMmC3vJR+8vGNuFDDzTT1NNbbXo/Fo6OaGdt+bLIsDoC2IDi9so+lmgLpynQXz+AsgbxJO+THywIcf7X1RKo/GLrzvv7DKFJGBKUHekGS17sR3iKwylyF0egupyy4ViOngeeLIK9lIFiXuyI8GxQ/uDV8yCVep1MLlt4GLJFVy10eSHpkpGon7IIBOajUaF2qToIjumli6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:30.5067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07261971-bf07-4557-3018-08d7e709b102
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0230
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Krunoslav Kovac <Krunoslav.Kovac@amd.com>

[Why&How]
modules/color calculates various colour operations which are translated
to abstracted HW. DCE 5-12 had almost no important changes, but
starting with DCN1, every new generation comes with fairly major
differences in color pipeline.
We would hack it with some DCN checks, but a better approach is to
abstract color pipe capabilities so modules/DM can decide mapping to
HW block based on logical capabilities,

Signed-off-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  7 +--
 drivers/gpu/drm/amd/display/dc/dc.h           | 45 ++++++++++++++++++-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c | 34 ++++++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 35 ++++++++++++++-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 35 ++++++++++++++-
 .../amd/display/modules/color/color_gamma.c   | 31 ++++++++++---
 .../amd/display/modules/color/color_gamma.h   |  4 +-
 7 files changed, 178 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 838f35668f12..4dfb6b55bb2e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -239,7 +239,8 @@ static int __set_output_tf(struct dc_transfer_func *func,
 		 * instead to simulate this.
 		 */
 		gamma->type = GAMMA_CUSTOM;
-		res = mod_color_calculate_degamma_params(func, gamma, true);
+		res = mod_color_calculate_degamma_params(NULL, func,
+							gamma, true);
 	} else {
 		/*
 		 * Assume sRGB. The actual mapping will depend on whether the
@@ -271,7 +272,7 @@ static int __set_input_tf(struct dc_transfer_func *func,
 
 	__drm_lut_to_dc_gamma(lut, gamma, false);
 
-	res = mod_color_calculate_degamma_params(func, gamma, true);
+	res = mod_color_calculate_degamma_params(NULL, func, gamma, true);
 	dc_gamma_release(&gamma);
 
 	return res ? 0 : -ENOMEM;
@@ -485,7 +486,7 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 		dc_plane_state->in_transfer_func->tf = tf;
 
 		if (tf != TRANSFER_FUNCTION_SRGB &&
-		    !mod_color_calculate_degamma_params(
+		    !mod_color_calculate_degamma_params(NULL,
 			    dc_plane_state->in_transfer_func, NULL, false))
 			return -ENOMEM;
 	} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 99c8e40049e6..b4aeb5d8a818 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -98,6 +98,49 @@ struct dc_plane_cap {
 	} max_downscale_factor;
 };
 
+// Color management caps (DPP and MPC)
+struct rom_curve_caps {
+	uint16_t srgb : 1;
+	uint16_t bt2020 : 1;
+	uint16_t gamma2_2 : 1;
+	uint16_t pq : 1;
+	uint16_t hlg : 1;
+};
+
+struct dpp_color_caps {
+	uint16_t dcn_arch : 1; // all DCE generations treated the same
+	// input lut is different than most LUTs, just plain 256-entry lookup
+	uint16_t input_lut_shared : 1; // shared with DGAM
+	uint16_t icsc : 1;
+	uint16_t dgam_ram : 1;
+	uint16_t post_csc : 1; // before gamut remap
+	uint16_t gamma_corr : 1;
+
+	// hdr_mult and gamut remap always available in DPP (in that order)
+	// 3d lut implies shaper LUT,
+	// it may be shared with MPC - check MPC:shared_3d_lut flag
+	uint16_t hw_3d_lut : 1;
+	uint16_t ogam_ram : 1; // blnd gam
+	uint16_t ocsc : 1;
+	struct rom_curve_caps dgam_rom_caps;
+	struct rom_curve_caps ogam_rom_caps;
+};
+
+struct mpc_color_caps {
+	uint16_t gamut_remap : 1;
+	uint16_t ogam_ram : 1;
+	uint16_t ocsc : 1;
+	uint16_t num_3dluts : 3; //3d lut always assumes a preceding shaper LUT
+	uint16_t shared_3d_lut:1; //can be in either DPP or MPC, but single instance
+
+	struct rom_curve_caps ogam_rom_caps;
+};
+
+struct dc_color_caps {
+	struct dpp_color_caps dpp;
+	struct mpc_color_caps mpc;
+};
+
 struct dc_caps {
 	uint32_t max_streams;
 	uint32_t max_links;
@@ -120,9 +163,9 @@ struct dc_caps {
 	bool psp_setup_panel_mode;
 	bool extended_aux_timeout_support;
 	bool dmcub_support;
-	bool hw_3d_lut;
 	enum dp_protocol_version max_dp_protocol_version;
 	struct dc_plane_cap planes[MAX_PLANES];
+	struct dc_color_caps color;
 };
 
 struct dc_bug_wa {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 43116749af9f..6d506c37fc71 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -1384,6 +1384,40 @@ static bool dcn10_resource_construct(
 	/* Raven DP PHY HBR2 eye diagram pattern is not stable. Use TP4 */
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 
+	/* Color pipeline capabilities */
+	dc->caps.color.dpp.dcn_arch = 1;
+	dc->caps.color.dpp.input_lut_shared = 1;
+	dc->caps.color.dpp.icsc = 1;
+	dc->caps.color.dpp.dgam_ram = 1;
+	dc->caps.color.dpp.dgam_rom_caps.srgb = 1;
+	dc->caps.color.dpp.dgam_rom_caps.bt2020 = 1;
+	dc->caps.color.dpp.dgam_rom_caps.gamma2_2 = 0;
+	dc->caps.color.dpp.dgam_rom_caps.pq = 0;
+	dc->caps.color.dpp.dgam_rom_caps.hlg = 0;
+	dc->caps.color.dpp.post_csc = 0;
+	dc->caps.color.dpp.gamma_corr = 0;
+
+	dc->caps.color.dpp.hw_3d_lut = 0;
+	dc->caps.color.dpp.ogam_ram = 1; // RGAM on DCN1
+	dc->caps.color.dpp.ogam_rom_caps.srgb = 1;
+	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 1;
+	dc->caps.color.dpp.ogam_rom_caps.gamma2_2 = 0;
+	dc->caps.color.dpp.ogam_rom_caps.pq = 0;
+	dc->caps.color.dpp.ogam_rom_caps.hlg = 0;
+	dc->caps.color.dpp.ocsc = 1;
+
+	/* no post-blend color operations */
+	dc->caps.color.mpc.gamut_remap = 0;
+	dc->caps.color.mpc.num_3dluts = 0;
+	dc->caps.color.mpc.shared_3d_lut = 0;
+	dc->caps.color.mpc.ogam_ram = 0;
+	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
+	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
+	dc->caps.color.mpc.ogam_rom_caps.gamma2_2 = 0;
+	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
+	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
+	dc->caps.color.mpc.ocsc = 0;
+
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
 	else
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index b7e4d0c2432c..f04d0872a8ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3709,9 +3709,42 @@ static bool dcn20_resource_construct(
 	dc->caps.max_slave_planes = 1;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
-	dc->caps.hw_3d_lut = true;
 	dc->caps.extended_aux_timeout_support = true;
 
+	/* Color pipeline capabilities */
+	dc->caps.color.dpp.dcn_arch = 1;
+	dc->caps.color.dpp.input_lut_shared = 0;
+	dc->caps.color.dpp.icsc = 1;
+	dc->caps.color.dpp.dgam_ram = 1;
+	dc->caps.color.dpp.dgam_rom_caps.srgb = 1;
+	dc->caps.color.dpp.dgam_rom_caps.bt2020 = 1;
+	dc->caps.color.dpp.dgam_rom_caps.gamma2_2 = 0;
+	dc->caps.color.dpp.dgam_rom_caps.pq = 0;
+	dc->caps.color.dpp.dgam_rom_caps.hlg = 0;
+	dc->caps.color.dpp.post_csc = 0;
+	dc->caps.color.dpp.gamma_corr = 0;
+
+	dc->caps.color.dpp.hw_3d_lut = 1;
+	dc->caps.color.dpp.ogam_ram = 1;
+	// no OGAM ROM on DCN2, only MPC ROM
+	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
+	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
+	dc->caps.color.dpp.ogam_rom_caps.gamma2_2 = 0;
+	dc->caps.color.dpp.ogam_rom_caps.pq = 0;
+	dc->caps.color.dpp.ogam_rom_caps.hlg = 0;
+	dc->caps.color.dpp.ocsc = 0;
+
+	dc->caps.color.mpc.gamut_remap = 0;
+	dc->caps.color.mpc.num_3dluts = 0;
+	dc->caps.color.mpc.shared_3d_lut = 0;
+	dc->caps.color.mpc.ogam_ram = 1;
+	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
+	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
+	dc->caps.color.mpc.ogam_rom_caps.gamma2_2 = 0;
+	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
+	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
+	dc->caps.color.mpc.ocsc = 1;
+
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV) {
 		dc->debug = debug_defaults_drv;
 	} else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 802372f09dc7..d771fe1e2c4e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1798,7 +1798,6 @@ static bool dcn21_resource_construct(
 	dc->caps.i2c_speed_in_khz = 100;
 	dc->caps.max_cursor_size = 256;
 	dc->caps.dmdata_alloc_size = 2048;
-	dc->caps.hw_3d_lut = true;
 
 	dc->caps.max_slave_planes = 1;
 	dc->caps.post_blend_color_processing = true;
@@ -1807,6 +1806,40 @@ static bool dcn21_resource_construct(
 	dc->caps.dmcub_support = true;
 	dc->caps.is_apu = true;
 
+	/* Color pipeline capabilities */
+	dc->caps.color.dpp.dcn_arch = 1;
+	dc->caps.color.dpp.input_lut_shared = 0;
+	dc->caps.color.dpp.icsc = 1;
+	dc->caps.color.dpp.dgam_ram = 1;
+	dc->caps.color.dpp.dgam_rom_caps.srgb = 1;
+	dc->caps.color.dpp.dgam_rom_caps.bt2020 = 1;
+	dc->caps.color.dpp.dgam_rom_caps.gamma2_2 = 0;
+	dc->caps.color.dpp.dgam_rom_caps.pq = 0;
+	dc->caps.color.dpp.dgam_rom_caps.hlg = 0;
+	dc->caps.color.dpp.post_csc = 0;
+	dc->caps.color.dpp.gamma_corr = 0;
+
+	dc->caps.color.dpp.hw_3d_lut = 1;
+	dc->caps.color.dpp.ogam_ram = 1;
+	// no OGAM ROM on DCN2
+	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
+	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
+	dc->caps.color.dpp.ogam_rom_caps.gamma2_2 = 0;
+	dc->caps.color.dpp.ogam_rom_caps.pq = 0;
+	dc->caps.color.dpp.ogam_rom_caps.hlg = 0;
+	dc->caps.color.dpp.ocsc = 0;
+
+	dc->caps.color.mpc.gamut_remap = 0;
+	dc->caps.color.mpc.num_3dluts = 0;
+	dc->caps.color.mpc.shared_3d_lut = 0;
+	dc->caps.color.mpc.ogam_ram = 1;
+	dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
+	dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
+	dc->caps.color.mpc.ogam_rom_caps.gamma2_2 = 0;
+	dc->caps.color.mpc.ogam_rom_caps.pq = 0;
+	dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
+	dc->caps.color.mpc.ocsc = 1;
+
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
 	else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS) {
diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index d47253cdcc4e..9431b48aecb4 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1782,7 +1782,8 @@ bool calculate_user_regamma_ramp(struct dc_transfer_func *output_tf,
 	return ret;
 }
 
-bool mod_color_calculate_degamma_params(struct dc_transfer_func *input_tf,
+bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
+		struct dc_transfer_func *input_tf,
 		const struct dc_gamma *ramp, bool mapUserRamp)
 {
 	struct dc_transfer_func_distributed_points *tf_pts = &input_tf->tf_pts;
@@ -1801,11 +1802,29 @@ bool mod_color_calculate_degamma_params(struct dc_transfer_func *input_tf,
 	/* we can use hardcoded curve for plain SRGB TF
 	 * If linear, it's bypass if on user ramp
 	 */
-	if (input_tf->type == TF_TYPE_PREDEFINED &&
-			(input_tf->tf == TRANSFER_FUNCTION_SRGB ||
-					input_tf->tf == TRANSFER_FUNCTION_LINEAR) &&
-					!mapUserRamp)
-		return true;
+	if (input_tf->type == TF_TYPE_PREDEFINED) {
+		if ((input_tf->tf == TRANSFER_FUNCTION_SRGB ||
+				input_tf->tf == TRANSFER_FUNCTION_LINEAR) &&
+				!mapUserRamp)
+			return true;
+
+		if (dc_caps != NULL &&
+			dc_caps->dpp.dcn_arch == 1) {
+
+			if (input_tf->tf == TRANSFER_FUNCTION_PQ &&
+					dc_caps->dpp.dgam_rom_caps.pq == 1)
+				return true;
+
+			if (input_tf->tf == TRANSFER_FUNCTION_GAMMA22 &&
+					dc_caps->dpp.dgam_rom_caps.gamma2_2 == 1)
+				return true;
+
+			// HLG OOTF not accounted for
+			if (input_tf->tf == TRANSFER_FUNCTION_HLG &&
+					dc_caps->dpp.dgam_rom_caps.hlg == 1)
+				return true;
+		}
+	}
 
 	input_tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 
diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.h b/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
index 9994817a9a03..7f56226ba77a 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.h
@@ -30,6 +30,7 @@ struct dc_transfer_func;
 struct dc_gamma;
 struct dc_transfer_func_distributed_points;
 struct dc_rgb_fixed;
+struct dc_color_caps;
 enum dc_transfer_func_predefined;
 
 /* For SetRegamma ADL interface support
@@ -100,7 +101,8 @@ bool mod_color_calculate_regamma_params(struct dc_transfer_func *output_tf,
 		const struct dc_gamma *ramp, bool mapUserRamp, bool canRomBeUsed,
 		const struct freesync_hdr_tf_params *fs_params);
 
-bool mod_color_calculate_degamma_params(struct dc_transfer_func *output_tf,
+bool mod_color_calculate_degamma_params(struct dc_color_caps *dc_caps,
+		struct dc_transfer_func *output_tf,
 		const struct dc_gamma *ramp, bool mapUserRamp);
 
 bool mod_color_calculate_degamma_curve(enum dc_transfer_func_predefined trans,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
