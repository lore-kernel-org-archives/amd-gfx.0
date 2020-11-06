Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0C6C55178
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14B5206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R9fCfYXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14B5206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA406EB4E;
	Fri,  6 Nov 2020 23:19:19 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760071.outbound.protection.outlook.com [40.107.76.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D9C96EB4D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 23:19:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5OMrFk79Rc2203Xf//XrjZU+fSJf5R65tKxPTYNXkdZsrahXTe/GZWxK9hM2mC2gYbwejoSILZ30RABpCyTTCi0ChVigFef33TMTVTzQlNpsnnLDS1wRPwRBELHU+7oHOyliOUc8hxOWK9Z67T/CuW5rR693l0HQcpFSZ4G/wEil2rQ85w2UEB1eXPwGpAcYSgia8QjgZEKMrzaKiLavVNtsYqKdFLNV8wvakZeNjW2ffNBwHejP4fRZdUN+Uae7TJ2Ultmk8rQ7d4xuBDVRDXDtZDvO6AOT3xNUOM6yxqoivwELgu1mgk7GQW8fHkPjge/YVDwZ9+m53d3fsKmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m5vvGpowigPP5aMn5YzJLUz+gKYUD+8fqLWr5uIPbQ=;
 b=CTje2OPVQEN2e6bz617oHlClNUlq6NC3aVRrTR4tzWK0XhcjeTXFHDWxsjG9KCEcj+fLYsYhj6VL6Vdi0sJ9XNy9BlHrcBm6YTTGGW/6bPk+Jfu53D1dZI65djgMCzJByuGbAPfG83LWR/tkLcj7chqPKS74nEfD4LZmCkL2nGVvf7yTPxXPv2BTfHP7TIKcsswGrY+YFvwh1q2KytGKshG/MNEs9zgOdRf9X4G5f+I1yG2cXacigzra9GB8RC6E76F14FKeo/YXC+WRVrC2zIgSmzfz/G95fvEuZ+1/iJAKGSfTwwKFoqsNKToGXh8KSc7/CJkOXAzDSw2N9x4mVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m5vvGpowigPP5aMn5YzJLUz+gKYUD+8fqLWr5uIPbQ=;
 b=R9fCfYXGt/wmto07ogcn4Q/JCO6NGyqfGkKA4vUhuQKoFEnM+OqWjpl4k0chcOEBI9fOicw2STDxrEdtmomPZT88Z0JW2qXD3NlXNi8S87mTBFwb6TqU+S4wWsVKWb4ySV+omxBA6SREnLQHx9d+bq8Qy2exxjfraDd9nqEtAjw=
Received: from MWHPR1601CA0001.namprd16.prod.outlook.com
 (2603:10b6:300:da::11) by SA0PR12MB4494.namprd12.prod.outlook.com
 (2603:10b6:806:94::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 23:19:15 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::b1) by MWHPR1601CA0001.outlook.office365.com
 (2603:10b6:300:da::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27 via Frontend
 Transport; Fri, 6 Nov 2020 23:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 6 Nov 2020 23:19:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:12 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:12 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 6 Nov 2020 17:19:11 -0600
From: Bindu R <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] drm/amd/display: Prevent freesync power optimization
 during validation
Date: Fri, 6 Nov 2020 18:16:58 -0500
Message-ID: <20201106231710.1290392-3-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106231710.1290392-1-bindu.r@amd.com>
References: <20201106231710.1290392-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef1b1b44-177d-461b-1c5e-08d882aa5ff0
X-MS-TrafficTypeDiagnostic: SA0PR12MB4494:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4494381F5AAA7DB6B38CD1A0F5ED0@SA0PR12MB4494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jg14F+rbx4tGTRYfKVtyp1jF5XLAMiZaxBXPs8GpCBgH9QmFOZs3o6lzDsSYmYxh4DpVvhtoWdtJXzkWEkHTlH5M3IViCYITTJEgMd1y16U6FCjT5/BUepW/8iAAbWa8WLrA6nI2SNJAon4crCOU9xyPaQW5p5cDnX0S4hdGkk5VUr0b6t+yDrfrTWsbCT0J4F+lVlqvaewMlwIPmdnvW8p4+68xy0FRsjN6O9Hm3nFYyPjXPbrKIUbTCNjZ5QTYtLDYu5YineLl9ltxXMwJLeAthLNlvb0fsNmAVcXVK7MoiMQveAgzsgANw/RQkoC6gBGoYMJtGvvdX1CcaIQXlAkMq0cdya4hnLhhxEDkYybuoCiqB2YAifP663hfY+6gzV2DLLfHE06iYPEqQcwHOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(46966005)(47076004)(81166007)(36756003)(356005)(1076003)(82740400003)(4326008)(186003)(70586007)(70206006)(86362001)(336012)(2906002)(7696005)(83380400001)(5660300002)(6666004)(8676002)(54906003)(316002)(2616005)(26005)(8936002)(478600001)(82310400003)(426003)(6916009)(30864003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 23:19:13.6578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1b1b44-177d-461b-1c5e-08d882aa5ff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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
Cc: Isabel Zhang <isabel.zhang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Isabel Zhang <isabel.zhang@amd.com>

[Why]
Due to the freesync power optimization increasing vtotal, the driver
believes that MPO is supported. MPO is turned on. Freesync then
exits, MPO can no longer be supported and immediate flip fails. This
causes corruption on the panel.

[How]
Avoid the freesync optimization when doing validation so in the case
freesync exits, driver can still support the configuration.

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 22 +++++++++------
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |  8 ++++--
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 28 ++++++++++++-------
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  9 +++---
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |  3 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  3 +-
 6 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 3e425d554f09..86c21e463640 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2012,7 +2012,10 @@ void dcn20_populate_dml_writeback_from_context(
 }
 
 int dcn20_populate_dml_pipes_from_context(
-		struct dc *dc, struct dc_state *context, display_e2e_pipe_params_st *pipes)
+		struct dc *dc,
+		struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		bool fast_validate)
 {
 	int pipe_cnt, i;
 	bool synchronized_vblank = true;
@@ -2052,6 +2055,7 @@ int dcn20_populate_dml_pipes_from_context(
 
 		v_total = timing->v_total;
 		front_porch = timing->v_front_porch;
+
 		/* todo:
 		pipes[pipe_cnt].pipe.src.dynamic_metadata_enable = 0;
 		pipes[pipe_cnt].pipe.src.dcc = 0;
@@ -2846,7 +2850,8 @@ bool dcn20_fast_validate_bw(
 		display_e2e_pipe_params_st *pipes,
 		int *pipe_cnt_out,
 		int *pipe_split_from,
-		int *vlevel_out)
+		int *vlevel_out,
+		bool fast_validate)
 {
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
@@ -2858,7 +2863,7 @@ bool dcn20_fast_validate_bw(
 
 	dcn20_merge_pipes_for_validate(dc, context);
 
-	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes);
+	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
 
 	*pipe_cnt_out = pipe_cnt;
 
@@ -2962,7 +2967,8 @@ static void dcn20_calculate_wm(
 		display_e2e_pipe_params_st *pipes,
 		int *out_pipe_cnt,
 		int *pipe_split_from,
-		int vlevel)
+		int vlevel,
+		bool fast_validate)
 {
 	int pipe_cnt, i, pipe_idx;
 
@@ -3007,10 +3013,10 @@ static void dcn20_calculate_wm(
 	if (pipe_cnt != pipe_idx) {
 		if (dc->res_pool->funcs->populate_dml_pipes)
 			pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc,
-				context, pipes);
+				context, pipes, fast_validate);
 		else
 			pipe_cnt = dcn20_populate_dml_pipes_from_context(dc,
-				context, pipes);
+				context, pipes, fast_validate);
 	}
 
 	*out_pipe_cnt = pipe_cnt;
@@ -3155,7 +3161,7 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
 
 	BW_VAL_TRACE_COUNT();
 
-	out = dcn20_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_split_from, &vlevel);
+	out = dcn20_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_split_from, &vlevel, fast_validate);
 
 	if (pipe_cnt == 0)
 		goto validate_out;
@@ -3170,7 +3176,7 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
 		goto validate_out;
 	}
 
-	dcn20_calculate_wm(dc, context, pipes, &pipe_cnt, pipe_split_from, vlevel);
+	dcn20_calculate_wm(dc, context, pipes, &pipe_cnt, pipe_split_from, vlevel, fast_validate);
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
 	BW_VAL_TRACE_END_WATERMARKS();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index 64bce14fefa3..c8f3127bbcdf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -50,7 +50,10 @@ unsigned int dcn20_calc_max_scaled_time(
 		enum mmhubbub_wbif_mode mode,
 		unsigned int urgent_watermark);
 int dcn20_populate_dml_pipes_from_context(
-		struct dc *dc, struct dc_state *context, display_e2e_pipe_params_st *pipes);
+		struct dc *dc,
+		struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		bool fast_validate);
 struct pipe_ctx *dcn20_acquire_idle_pipe_for_layer(
 		struct dc_state *state,
 		const struct resource_pool *pool,
@@ -155,7 +158,8 @@ bool dcn20_fast_validate_bw(
 		display_e2e_pipe_params_st *pipes,
 		int *pipe_cnt_out,
 		int *pipe_split_from,
-		int *vlevel_out);
+		int *vlevel_out,
+		bool fast_validate);
 void dcn20_calculate_dlg_params(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 3d8b0875e905..5eedc19662a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -704,7 +704,10 @@ static const struct dcn10_stream_encoder_mask se_mask = {
 static void dcn21_pp_smu_destroy(struct pp_smu_funcs **pp_smu);
 
 static int dcn21_populate_dml_pipes_from_context(
-		struct dc *dc, struct dc_state *context, display_e2e_pipe_params_st *pipes);
+		struct dc *dc,
+		struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		bool fast_validate);
 
 static struct input_pixel_processor *dcn21_ipp_create(
 	struct dc_context *ctx, uint32_t inst)
@@ -1091,7 +1094,8 @@ void dcn21_calculate_wm(
 		display_e2e_pipe_params_st *pipes,
 		int *out_pipe_cnt,
 		int *pipe_split_from,
-		int vlevel_req)
+		int vlevel_req,
+		bool fast_validate)
 {
 	int pipe_cnt, i, pipe_idx;
 	int vlevel, vlevel_max;
@@ -1133,10 +1137,10 @@ void dcn21_calculate_wm(
 	if (pipe_cnt != pipe_idx) {
 		if (dc->res_pool->funcs->populate_dml_pipes)
 			pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc,
-				context, pipes);
+				context, pipes, fast_validate);
 		else
 			pipe_cnt = dcn21_populate_dml_pipes_from_context(dc,
-				context, pipes);
+				context, pipes, fast_validate);
 	}
 
 	*out_pipe_cnt = pipe_cnt;
@@ -1177,7 +1181,8 @@ static bool dcn21_fast_validate_bw(
 		display_e2e_pipe_params_st *pipes,
 		int *pipe_cnt_out,
 		int *pipe_split_from,
-		int *vlevel_out)
+		int *vlevel_out,
+		bool fast_validate)
 {
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
@@ -1189,7 +1194,7 @@ static bool dcn21_fast_validate_bw(
 
 	dcn20_merge_pipes_for_validate(dc, context);
 
-	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes);
+	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
 
 	*pipe_cnt_out = pipe_cnt;
 
@@ -1339,7 +1344,7 @@ bool dcn21_validate_bandwidth(struct dc *dc, struct dc_state *context,
 	/*Unsafe due to current pipe merge and split logic*/
 	ASSERT(context != dc->current_state);
 
-	out = dcn21_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_split_from, &vlevel);
+	out = dcn21_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_split_from, &vlevel, fast_validate);
 
 	if (pipe_cnt == 0)
 		goto validate_out;
@@ -1354,7 +1359,7 @@ bool dcn21_validate_bandwidth(struct dc *dc, struct dc_state *context,
 		goto validate_out;
 	}
 
-	dcn21_calculate_wm(dc, context, pipes, &pipe_cnt, pipe_split_from, vlevel);
+	dcn21_calculate_wm(dc, context, pipes, &pipe_cnt, pipe_split_from, vlevel, fast_validate);
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
 	BW_VAL_TRACE_END_WATERMARKS();
@@ -1870,9 +1875,12 @@ static uint32_t read_pipe_fuses(struct dc_context *ctx)
 }
 
 static int dcn21_populate_dml_pipes_from_context(
-		struct dc *dc, struct dc_state *context, display_e2e_pipe_params_st *pipes)
+		struct dc *dc,
+		struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		bool fast_validate)
 {
-	uint32_t pipe_cnt = dcn20_populate_dml_pipes_from_context(dc, context, pipes);
+	uint32_t pipe_cnt = dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 	int i;
 
 	for (i = 0; i < pipe_cnt; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index d65496917e93..deeeab53ac87 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1451,12 +1451,13 @@ static struct clock_source *dcn30_clock_source_create(
 
 int dcn30_populate_dml_pipes_from_context(
 	struct dc *dc, struct dc_state *context,
-	display_e2e_pipe_params_st *pipes)
+	display_e2e_pipe_params_st *pipes,
+	bool fast_validate)
 {
 	int i, pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
 
-	dcn20_populate_dml_pipes_from_context(dc, context, pipes);
+	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!res_ctx->pipe_ctx[i].stream)
@@ -1976,7 +1977,7 @@ static bool dcn30_internal_validate_bw(
 	if (!pipes)
 		return false;
 
-	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes);
+	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
 
 	if (!pipe_cnt) {
 		out = true;
@@ -2190,7 +2191,7 @@ static bool dcn30_internal_validate_bw(
 	}
 
 	if (repopulate_pipes)
-		pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes);
+		pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
 	*vlevel_out = vlevel;
 	*pipe_cnt_out = pipe_cnt;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
index d163812af858..8ce7f6d39a20 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
@@ -65,7 +65,8 @@ void dcn30_populate_dml_writeback_from_context(
 
 int dcn30_populate_dml_pipes_from_context(
 	struct dc *dc, struct dc_state *context,
-	display_e2e_pipe_params_st *pipes);
+	display_e2e_pipe_params_st *pipes,
+	bool fast_validate);
 
 bool dcn30_acquire_post_bldn_3dlut(
 		struct resource_context *res_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 6e6bc66e49f0..8701ebaeee43 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -109,7 +109,8 @@ struct resource_funcs {
 	int (*populate_dml_pipes)(
 		struct dc *dc,
 		struct dc_state *context,
-		display_e2e_pipe_params_st *pipes);
+		display_e2e_pipe_params_st *pipes,
+		bool fast_validate);
 
 	enum dc_status (*validate_global)(
 		struct dc *dc,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
