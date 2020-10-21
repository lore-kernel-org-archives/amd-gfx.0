Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F94C56202
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C299D2224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qgblhD6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C299D2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3418A6EDC3;
	Wed, 21 Oct 2020 14:23:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64EA66EDBD
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGoJ3fI5fYDQMQ/xIFLwJ/cAld4pieiXpqJgOU3C5uNkOt+T79BXxNVf0HxE0gm/BEYTav8I/0GQD4SagZXzOCf8WudMrEe7p52LDbDgcN9rWrfKSMReATBWmdtqqvQxQn2rrhwSfsXvb0nBl0n+349yPrusCBT2YV+7/efXLqCtA/a7YTyiBOpL2u2lpSW6P8hFs33SVBk8YPMVtzgcIN5APne2AWqr3p8vvpDP1xkxpbmhnUNyXzw+YMUDGdMQ74EhL3qLBD0zByY3TOnx+mvwbaoE6Oe2+4e8X3ohvk9LhlxDYRO/x6PbO0qti4J5STiL5/QzFy35wLMTNIhZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PEDioC4JiidfUUpPkCHFW4VKxEvZxSIu8SqSJsDrTk=;
 b=E9XhjeGd1NBXVdLSc7wqDTzGaEaQYQc4hnEhBngCWuCzjBkIF57bPCsRllS0lzqHFxtW1SW+P3A5sfUjsPrMGWi44AUeEbMqRptpGZqNPIFsyigNfqmzScUsiYcZukTG6g+BzJiy0VuMaucCPSA9jAVrFQ6zcEnguFv8vLMptx//ovQ45A7uXxV0A7ZGYguEBqga/9Mi8anqrz3Q5uzqyLPF50xGicGEAPvmuZtGHu6d7I//p6J5Dhi1njFGRVzMyoVkWdKJqU/Z5WyHN8wey1uZx+YfFZviaR5YmCP0us5Hwn+K6CCjWjDT0At/CHxZ0x/Xre1XqjFAz4CKcKbsug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PEDioC4JiidfUUpPkCHFW4VKxEvZxSIu8SqSJsDrTk=;
 b=qgblhD6FeUDo6ggQZVo8em08rXVmu6isz67VjikPboBwp3UddUFtpcuxEwRie5wNoIB0TXylRNcnsfoYHwpCk5pSOz2Gg66dIicCmxdnhTYez3bIMjq94JQmfAlgjuGRTTXeNzGGUFIV7kn2vYjTBGmgxpnO2PsTeJevC+QPHDc=
Received: from BN8PR15CA0048.namprd15.prod.outlook.com (2603:10b6:408:80::25)
 by DM5PR12MB1563.namprd12.prod.outlook.com (2603:10b6:4:a::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.27; Wed, 21 Oct 2020 14:23:12 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::48) by BN8PR15CA0048.outlook.office365.com
 (2603:10b6:408:80::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:12 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:11 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:11 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/33] drm/amd/display: Add an option to limit max DSC target
 bpp per sink
Date: Wed, 21 Oct 2020 10:22:34 -0400
Message-ID: <20201021142257.190969-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 044af20e-cdac-4ee3-c315-08d875ccd7a5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1563:
X-Microsoft-Antispam-PRVS: <DM5PR12MB156354A562623EAD76BD5BAB8B1C0@DM5PR12MB1563.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SA/OrYEyNCV/Gh+KRtM7BFx+4GBEYdL46yzs7nok5gdDAGqvEmTpGuhL7I8Vtglsilx2dMiUF8kT48eUN/7WFU8ZN+1zEKeh9kpSA8s1S0fkcVyXhroeBKHTKn2DRPevtBDHRyi7lMqb0rY8UN7XXLF8aeo/JgGUxelsG4uqkq9Ghgb4dYuPijeUBw4kZNm27kJq6JE21bRWEj+TySxIwlDAX6ef+OdlwDd/9FevEm4yWH1+74A/YfEdto7UVs+oejC3WgllBOTrH6Ox2EJWTmmcN5ADPe+jCpbTYl10KelhiUHFHohCLFSkBHpc98l1zIL4Q78361LQszH4gFBpUMklj3giQPhAVwZ0mnjMJOoJl5Xi0gSOOrQl2xOm9FZVqqnjLDjNO9ARsa2q7+BdTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966005)(2906002)(26005)(70206006)(186003)(6916009)(4326008)(5660300002)(86362001)(54906003)(6666004)(36756003)(356005)(2616005)(8936002)(70586007)(83380400001)(7696005)(316002)(478600001)(8676002)(81166007)(82310400003)(1076003)(336012)(82740400003)(44832011)(47076004)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:12.4228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044af20e-cdac-4ee3-c315-08d875ccd7a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1563
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
index 71d21cf09f4e..a7f4874f698f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4851,6 +4851,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
 						  &dsc_caps,
 						  aconnector->dc_link->ctx->dc->debug.dsc_min_slice_height_override,
+						  0,
 						  link_bandwidth_kbps,
 						  &stream->timing,
 						  &stream->timing.dsc_cfg))
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index fc87b9faec92..d79b229af095 100644
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
