Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D41FC07548
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9758321D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f3kTQz53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9758321D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D053E6E93B;
	Thu, 10 Sep 2020 13:47:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790B16E939
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emsJRYejcqzcZivJtkJr41l+o4uRsqqG17/Y4eHWnhVxI58XV/35N7n4onShsJeejX1F/Gyv+P3kkHFQKw8dYH9veF4xZB9PjL2qJnKjXQRIThXdvcfZEHxZWtZg62Z5lVGntHytwVRwO2vmbcfHpdO6btj9xGYmponJ1Vh4XcsSQwBRrXwBhI2DDOdR9mYMKHZ2R+UESEePdVvyV+AWDXS57e11MTL412PdFDLQLmvQXshIMr+Mpg0cnQm1r4ahe55vb0lplnGFbCykdXJTnAxTn0La96EhAusJFOZ8LJoxmghNpvACspnfXV+2UtNZbvnuDCirBwP79rtUvwAGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8epKTGsaFXrfOgtiQpWqmjPaUIIAnCzvliO8DNkAZ1I=;
 b=iWMIWOzk2nIOV0wHDvF21/eYZ++8lG/tKVtGiakv+FUT8p404XSMl6KguYDbY9hYnFoaTdLWzPU+zGAcK5uOrJccXtIbZ0yZDPSLOC5xu21bPjebvQsOcT48ijbQnn3rjDSmy8oGRaP0B1HKBRew/DCKhgR8cdl41MDWinjiyTvHvTKmcH4okGUp+j07ryXguns+l7K4EUCegs9iEv2NnK8f2DBFatqLc7trsvXEf40kLtFXs+RPyTNw/+cpUFBPp42+04DFqC/U3dF73puHHgRH7f/GgFTjoIxtfhYoz7VVE1M41GU86NsXB64/qS8xWB8Bbvf9VuU5LxkbBCnHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8epKTGsaFXrfOgtiQpWqmjPaUIIAnCzvliO8DNkAZ1I=;
 b=f3kTQz535UyKV2PrBRXv2HWGMQ6e6f9fTp/uBGnvyhBvX+huxhNETsD38m6KbCf67zX3FAIs7xcFc7fc3Wibnxv7wTMUNOEqNLV4+erz13X4lHhHeT6DRUu2a8I89AQz+AFSpUya2uJcQeYLg7o4gC1GlOBRKuaFAUMn9Pv/8wA=
Received: from BN8PR07CA0016.namprd07.prod.outlook.com (2603:10b6:408:ac::29)
 by MN2PR12MB3600.namprd12.prod.outlook.com (2603:10b6:208:c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:30 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::f4) by BN8PR07CA0016.outlook.office365.com
 (2603:10b6:408:ac::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:29 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:29 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:28 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/42] drm/amd/display: Triplebuffering should not be used by
 default
Date: Thu, 10 Sep 2020 09:46:49 -0400
Message-ID: <20200910134723.27410-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce334b09-feda-4066-36b8-08d855900fa0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3600:
X-Microsoft-Antispam-PRVS: <MN2PR12MB36000E1F989C573AA4363F968B270@MN2PR12MB3600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CtI2EKSvAljxof2cS62NNAsjeJ5pHpx/rJC1HM6erIiG5mFJA5ykQvz6vop1CLsc4Bxa6FEZtjUN6pLOlZeCAHeKCGPd84hhK7mb0VztGlvVcHje/EC+b2Voeizvj2N575+sB7zYPiDyn5xy+nMPpZIRAdBjWJWI0vi36872+TKLYX9IU7+QtmaH3wFtSm9h2AK2qfKYDKTFbu1dKY1Y5H6AJ4hYmWH9gwN6w6EzeQoqW+WXGsHfdrxXvPL7N6MLz0Mm3MYVVfL3dU/nqbZF83rdUrmQWcYFQ1neAU/n6fajuBsry82ZeHZJd+0Of6G03P7vUIPdqLlEn+zz7Y86nCNUTwPDqEE9S3lTVlwdjzR11tazh7IcCYUdyHqU73q4dwpoKg4rN4Vr1ibW4Ti1ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966005)(44832011)(186003)(2616005)(8676002)(7696005)(4326008)(336012)(426003)(316002)(6916009)(26005)(47076004)(356005)(83380400001)(82740400003)(478600001)(54906003)(81166007)(82310400003)(2906002)(8936002)(70206006)(70586007)(1076003)(6666004)(86362001)(36756003)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:29.8305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce334b09-feda-4066-36b8-08d855900fa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3600
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Disable triplebuffering by default.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  3 ---
 drivers/gpu/drm/amd/display/dc/core/dc.c            |  9 +++------
 drivers/gpu/drm/amd/display/dc/dc.h                 |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c  | 13 ++++++-------
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   |  2 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   |  1 +
 7 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cb624ee70545..a7f08a8199e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3336,9 +3336,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		goto fail;
 	}
 
-	/* No userspace support. */
-	dm->dc->debug.disable_tri_buf = true;
-
 	return 0;
 fail:
 	kfree(aencoder);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index dc463d99ef50..511ab25b3f1a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2415,8 +2415,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				plane_state->triplebuffer_flips = false;
 				if (update_type == UPDATE_TYPE_FAST &&
 					dc->hwss.program_triplebuffer != NULL &&
-					!plane_state->flip_immediate &&
-					!dc->debug.disable_tri_buf) {
+					!plane_state->flip_immediate && dc->debug.enable_tri_buf) {
 						/*triple buffer for VUpdate  only*/
 						plane_state->triplebuffer_flips = true;
 				}
@@ -2443,8 +2442,7 @@ static void commit_planes_for_stream(struct dc *dc,
 
 			ASSERT(!pipe_ctx->plane_state->triplebuffer_flips);
 
-			if (dc->hwss.program_triplebuffer != NULL &&
-				!dc->debug.disable_tri_buf) {
+			if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
 				/*turn off triple buffer for full update*/
 				dc->hwss.program_triplebuffer(
 					dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
@@ -2509,8 +2507,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				if (pipe_ctx->plane_state != plane_state)
 					continue;
 				/*program triple buffer after lock based on flip type*/
-				if (dc->hwss.program_triplebuffer != NULL &&
-					!dc->debug.disable_tri_buf) {
+				if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
 					/*only enable triplebuffer for  fast_update*/
 					dc->hwss.program_triplebuffer(
 						dc, pipe_ctx, plane_state->triplebuffer_flips);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7416fd37e7d8..0607122e04de 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -476,7 +476,7 @@ struct dc_debug_options {
 	unsigned int force_odm_combine_4to1; //bit vector based on otg inst
 #endif
 	unsigned int force_fclk_khz;
-	bool disable_tri_buf;
+	bool enable_tri_buf;
 	bool dmub_offload_enabled;
 	bool dmcub_emulation;
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index ee3348711abe..ee56060943f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1642,16 +1642,15 @@ void dcn20_program_front_end_for_ctx(
 	struct dce_hwseq *hws = dc->hwseq;
 	DC_LOGGER_INIT(dc->ctx->logger);
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+	if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
-		if (!pipe_ctx->top_pipe && !pipe_ctx->prev_odm_pipe && pipe_ctx->plane_state) {
-			ASSERT(!pipe_ctx->plane_state->triplebuffer_flips);
-			if (dc->hwss.program_triplebuffer != NULL &&
-				!dc->debug.disable_tri_buf) {
+			if (!pipe_ctx->top_pipe && !pipe_ctx->prev_odm_pipe && pipe_ctx->plane_state) {
+				ASSERT(!pipe_ctx->plane_state->triplebuffer_flips);
 				/*turn off triple buffer for full update*/
 				dc->hwss.program_triplebuffer(
-					dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
+						dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 1b9874445134..55ce2c7df84e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1075,7 +1075,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.disable_pplib_wm_range = false,
 		.scl_reset_length10 = true,
 		.sanity_checks = false,
-		.disable_tri_buf = true,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
 };
 
@@ -1092,6 +1091,7 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.disable_stutter = true,
 		.scl_reset_length10 = true,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
+		.enable_tri_buf = true,
 };
 
 void dcn20_dpp_destroy(struct dpp **dpp)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 78743ae37851..e73785e74cba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -894,6 +894,8 @@ static const struct dc_debug_options debug_defaults_diags = {
 		.disable_pplib_wm_range = true,
 		.disable_stutter = true,
 		.disable_48mhz_pwrdwn = true,
+		.disable_psr = true,
+		.enable_tri_buf = true
 };
 
 enum dcn20_clk_src_array_id {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 8be4f21169d0..6746d582d723 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -865,6 +865,7 @@ static const struct dc_debug_options debug_defaults_diags = {
 	.scl_reset_length10 = true,
 	.dwb_fi_phase = -1, // -1 = disable
 	.dmub_command_table = true,
+	.enable_tri_buf = true,
 };
 
 void dcn30_dpp_destroy(struct dpp **dpp)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
