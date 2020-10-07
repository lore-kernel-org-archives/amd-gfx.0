Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B070C41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA98620789
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oGD7oI3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA98620789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B4296E8E5;
	Wed,  7 Oct 2020 12:42:47 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680066.outbound.protection.outlook.com [40.107.68.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 217696E8D8
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 12:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThByUuG/xEhnQz6lvoCSY4rvA7xmp6EyikhaIK6vBLosDucs8lGoRdPHzLD01iuzOfSeXAq3SzQPdoaKcHh6LtrC1OYgTsQsMam/igBkf3tazn/qic6IoBNwYcCtF5mqjvJw3crzwatH3Dwb041geNmKO+Ytw84UQwuPfOjm32t/xeqKqpnVhrJDMNmwQUy9O26NsWTNttYZncqjwvxG+EvHpIKtIgJf8GSt+qoG8Rokf+twT1dffVeWzLYgwETVLSTTkLz0K3RcC4K0Us+pTTXeUOTKE6jefA89iWvl09XlAaG8f+G3TH1Y9rIl/V2b2GU7nkvxvrQd07vq0gTLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKShkT+DWGPTT69kbX77bR7lh/Ib3BHIzMwiy3ZBmQw=;
 b=iqzwh/MajY+gJs8CB/8ngdRUMmV4qf59xrjTPnMVi+xGs6LSKW0lcyKsJRG4/duPEkB5vW2kUZwFzrUOvnY/U+rpZLqoS7LgmUUokVEAOmRKWjC09d3YJpml8PJDItqIUqB3bEYKg+O9YBlCS7DfZrckq5dR4joZjMLQ8BVkI1FENUJLP49tFsUoE53urWvfYDHIoODPqhMUHzaz75GxHFzizZQcntylXe/MPj0DwoWlON8OI5aImqka3nXUCl7QsY3W95EumQg4FtQWZeZoo0SUHzYYgNmHsB6ZwzjlPZuIIQ1wk151ggKqJdq+1Bt4O8Mg8J1i5g6KqHm/LPSuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKShkT+DWGPTT69kbX77bR7lh/Ib3BHIzMwiy3ZBmQw=;
 b=oGD7oI3hj4GWo0ExkTYc+zVGrEEq5vj4vHzPsqhiagPOnK+CJll9FKsKr+0yKGpjTAtGJv1+9P0C5ogmrj8BrZc5n/24SK0VYq3ZYOIMOKDXlee7sksgBGh3G/BFZ5fcMmjEf00h5HcpXiU7qQNl4Ay0txv6tvtoG3WzDAAPTrY=
Received: from MW2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:907:1::25)
 by DM6PR12MB2681.namprd12.prod.outlook.com (2603:10b6:5:41::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.43; Wed, 7 Oct
 2020 12:42:41 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::64) by MW2PR16CA0048.outlook.office365.com
 (2603:10b6:907:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend
 Transport; Wed, 7 Oct 2020 12:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 12:42:40 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:38 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 7 Oct 2020 07:42:38 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amd/display: Add an option to limit max DSC target
 bpp per sink
Date: Wed, 7 Oct 2020 08:42:23 -0400
Message-ID: <20201007124224.18789-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201007124224.18789-1-aurabindo.pillai@amd.com>
References: <20201007124224.18789-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c65d9a2-a5ae-4ca4-2c59-08d86abe7adf
X-MS-TrafficTypeDiagnostic: DM6PR12MB2681:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2681DBF5B6730D7A7F206D938B0A0@DM6PR12MB2681.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guiwo7o5QJiVhgbkl7DuJgFWJS0VoKf7/05qX+H9gX1aO/1x33gbbgZVKPFIZuF5A25sdrCMr/XQ5YWddKvKtEfMG0rYMxORFjSvjxwOpLcKXuPZ3Vn1fIeaEVBmkkwCiBdFgK69aGqU7jAo9LN1xJiQxWqAXIOFVBi7DMVLr4DRAE2qI1q3i+KwLXTE2Er9AfSqq4LWT3M9fOHC9iQD31L8FFpsA8RG4WXkXJFC/C+tlmSYBk6j8oJY/SdlvguakWaOzIJSAJe9nLXAVpEMyK4ve2dXhnlbnKsrCvFwGuTShlv63UHcpN3rDiXoOvbMsZDmeA3v/47akn/j4KYfmfpuDesoegp5cFklPEHApo4pCrhYBtMjhCDOLXcJ4mN+ac8wcFOBk2XtO7ZrK1mrfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966005)(54906003)(1076003)(70206006)(4326008)(336012)(316002)(26005)(186003)(478600001)(426003)(2616005)(44832011)(6666004)(8936002)(47076004)(70586007)(82310400003)(86362001)(8676002)(5660300002)(81166007)(7696005)(356005)(6916009)(2906002)(83380400001)(36756003)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 12:42:40.9142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c65d9a2-a5ae-4ca4-2c59-08d86abe7adf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2681
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Nikola Cornij <nikola.cornij@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

[Why] Can be used for debug purposes
[How] Add max target bpp override field and related handling

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  4 +++-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       | 10 ++++----
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 24 ++++++++++++-------
 5 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 03a45c3331c1..429b6e2f3190 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4736,6 +4736,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
 						  &dsc_caps,
 						  aconnector->dc_link->ctx->dc->debug.dsc_min_slice_height_override,
+						  0,
 						  link_bandwidth_kbps,
 						  &stream->timing,
 						  &stream->timing.dsc_cfg))
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 98b4d5e2e336..3714b16bada5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -497,6 +497,7 @@ static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *p
 					&params[i].sink->dsc_caps.dsc_dec_caps,
 					params[i].sink->ctx->dc->debug.dsc_min_slice_height_override,
 					0,
+					0,
 					params[i].timing,
 					&params[i].timing->dsc_cfg)) {
 			params[i].timing->flags.DSC = 1;
@@ -527,6 +528,7 @@ static int bpp_x16_from_pbn(struct dsc_mst_fairness_params param, int pbn)
 			param.sink->ctx->dc->res_pool->dscs[0],
 			&param.sink->dsc_caps.dsc_dec_caps,
 			param.sink->ctx->dc->debug.dsc_min_slice_height_override,
+			0,
 			(int) kbps, param.timing, &dsc_config);
 
 	return dsc_config.bits_per_pixel;
@@ -731,7 +733,7 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		params[count].num_slices_v = aconnector->dsc_settings.dsc_num_slices_v;
 		params[count].bpp_overwrite = aconnector->dsc_settings.dsc_bits_per_pixel;
 		params[count].compression_possible = stream->sink->dsc_caps.dsc_dec_caps.is_dsc_supported;
-		dc_dsc_get_policy_for_timing(params[count].timing, &dsc_policy);
+		dc_dsc_get_policy_for_timing(params[count].timing, 0, &dsc_policy);
 		if (!dc_dsc_compute_bandwidth_range(
 				stream->sink->ctx->dc->res_pool->dscs[0],
 				stream->sink->ctx->dc->debug.dsc_min_slice_height_override,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index 768ab38d41cf..ec55b77727d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -61,9 +61,9 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
 
 bool dc_dsc_compute_bandwidth_range(
 		const struct display_stream_compressor *dsc,
-		const uint32_t dsc_min_slice_height_override,
-		const uint32_t min_bpp,
-		const uint32_t max_bpp,
+		uint32_t dsc_min_slice_height_override,
+		uint32_t min_bpp,
+		uint32_t max_bpp,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_bw_range *range);
@@ -71,12 +71,14 @@ bool dc_dsc_compute_bandwidth_range(
 bool dc_dsc_compute_config(
 		const struct display_stream_compressor *dsc,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
-		const uint32_t dsc_min_slice_height_override,
+		uint32_t dsc_min_slice_height_override,
+		uint32_t max_target_bpp_limit_override,
 		uint32_t target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_config *dsc_cfg);
 
 void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
+		uint32_t max_target_bpp_limit_override,
 		struct dc_dsc_policy *policy);
 
 void dc_dsc_policy_set_max_target_bpp_limit(uint32_t limit);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index c47a19719de2..c36f0daefd83 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -234,6 +234,7 @@ struct dc_panel_patch {
 	unsigned int delay_ignore_msa;
 	unsigned int disable_fec;
 	unsigned int extra_t3_ms;
+	unsigned int max_dsc_target_bpp_limit;
 };
 
 struct dc_edid_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 4c844cfaa956..c62d0eddc9c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -545,6 +545,7 @@ static bool setup_dsc_config(
 		int target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
 		int min_slice_height_override,
+		int max_dsc_target_bpp_limit_override,
 		struct dc_dsc_config *dsc_cfg)
 {
 	struct dsc_enc_caps dsc_common_caps;
@@ -563,7 +564,7 @@ static bool setup_dsc_config(
 
 	memset(dsc_cfg, 0, sizeof(struct dc_dsc_config));
 
-	dc_dsc_get_policy_for_timing(timing, &policy);
+	dc_dsc_get_policy_for_timing(timing, max_dsc_target_bpp_limit_override, &policy);
 	pic_width = timing->h_addressable + timing->h_border_left + timing->h_border_right;
 	pic_height = timing->v_addressable + timing->v_border_top + timing->v_border_bottom;
 
@@ -863,9 +864,9 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc, const uint8_t *dpcd_dsc_basic_da
  */
 bool dc_dsc_compute_bandwidth_range(
 		const struct display_stream_compressor *dsc,
-		const uint32_t dsc_min_slice_height_override,
-		const uint32_t min_bpp,
-		const uint32_t max_bpp,
+		uint32_t dsc_min_slice_height_override,
+		uint32_t min_bpp,
+		uint32_t max_bpp,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_bw_range *range)
@@ -882,7 +883,7 @@ bool dc_dsc_compute_bandwidth_range(
 
 	if (is_dsc_possible)
 		is_dsc_possible = setup_dsc_config(dsc_sink_caps, &dsc_enc_caps, 0, timing,
-				dsc_min_slice_height_override, &config);
+				dsc_min_slice_height_override, max_bpp, &config);
 
 	if (is_dsc_possible)
 		get_dsc_bandwidth_range(min_bpp, max_bpp, &dsc_common_caps, timing, range);
@@ -893,7 +894,8 @@ bool dc_dsc_compute_bandwidth_range(
 bool dc_dsc_compute_config(
 		const struct display_stream_compressor *dsc,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
-		const uint32_t dsc_min_slice_height_override,
+		uint32_t dsc_min_slice_height_override,
+		uint32_t max_target_bpp_limit_override,
 		uint32_t target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_config *dsc_cfg)
@@ -905,11 +907,12 @@ bool dc_dsc_compute_config(
 	is_dsc_possible = setup_dsc_config(dsc_sink_caps,
 			&dsc_enc_caps,
 			target_bandwidth_kbps,
-			timing, dsc_min_slice_height_override, dsc_cfg);
+			timing, dsc_min_slice_height_override,
+			max_target_bpp_limit_override, dsc_cfg);
 	return is_dsc_possible;
 }
 
-void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, struct dc_dsc_policy *policy)
+void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, uint32_t max_target_bpp_limit_override, struct dc_dsc_policy *policy)
 {
 	uint32_t bpc = 0;
 
@@ -963,10 +966,15 @@ void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing, struct dc
 	default:
 		return;
 	}
+
 	/* internal upper limit, default 16 bpp */
 	if (policy->max_target_bpp > dsc_policy_max_target_bpp_limit)
 		policy->max_target_bpp = dsc_policy_max_target_bpp_limit;
 
+	/* apply override */
+	if (max_target_bpp_limit_override && policy->max_target_bpp > max_target_bpp_limit_override)
+		policy->max_target_bpp = max_target_bpp_limit_override;
+
 	/* enable DSC when not needed, default false */
 	if (dsc_policy_enable_dsc_when_not_needed)
 		policy->enable_dsc_when_not_needed = dsc_policy_enable_dsc_when_not_needed;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
