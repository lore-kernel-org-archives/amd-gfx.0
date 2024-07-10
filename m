Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B228C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D6A10E8AA;
	Wed, 10 Jul 2024 19:38:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y1guDg8U";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9B510E8AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTiZEkuoFkm5jKl7dsdA9vTIgvpfXEoqWhYimg9NHbGqeYej5AoH/4TTmOeIXHc4wtBNFKJa6t6y8i7iiINfXXR/2+o4SUC1uNqbErRAr6M0Zbekm5B5xotPQ2uh/dw0AKLLnlOawi4gePP0psWLJNHhTyWu9StawAU2UE2HF/CNkgrIPmqnIOMFmUUQpW6pzAEvMx1221YSEtrWcMBYw36LA4ftTwb5PU3GyIaPOMSRl9Ne0PnTSQFPaMdHZVjeLn54MMd1lR5yl97wGN+MYsb8Z/kwUOTTtTHf8ucox1D8w1flc+8/XLeFKpBM14wukElvmfUqXRYCn6gCfC58JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxWn8EPYbDkhrVi69ssgS8lO1c8vzmReUj8q7m9VKwc=;
 b=S0RcqSHJMfg3qF29pwdiws78zHDqlZ3SKXqzGiEybh5MLfPJffn2qkNYrxmt2rNaANPKHTC6rmFPgLPJj1uQ1hsZltKjmXPsu9NPlrdfnblNeUJbuJrnIIismDyrRWhNpyWFRGYP48jeC/Fa/19xotvW7YedKVQBKFXpIa5ZctYEF7PjHj7YbyvoVuvXs7X/QVJI3w2INYAhT3XVKrh7BRRW9zT/udkYLxwcM700bWqvGL/VqMFZv765KLNR+EjmLJcx7vE1lVOnz5+omcqv+ub0Be2g0Z1Zn+1wwFzM2zysf9+QDXCyVxTeYH9mIkAfp1BLERddHzVQ+V6hsr29nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxWn8EPYbDkhrVi69ssgS8lO1c8vzmReUj8q7m9VKwc=;
 b=Y1guDg8UGDYgcMCcM9Im9N6ZzzOwbw9BUFn097/SmSIgSIrPeF01yY4sPedBHr4rKoyFTeF1Dr8TwRxjelAHgIb44/T65/mFMC56r9Kvizjp3ReNgrkMOPPehxckE0RQmEYwJEjehQdS0vz2Co3frQ11wvTUOyPhKTSQBXBUudo=
Received: from BLAPR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:32b::21)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 19:38:12 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::df) by BLAPR03CA0016.outlook.office365.com
 (2603:10b6:208:32b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Wed, 10 Jul 2024 19:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:38:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:07 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:38:01 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Jingwen Zhu <jingwen.zhu@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 11/50] drm/amd/display: avoid disable otg when dig was disabled
Date: Wed, 10 Jul 2024 15:36:28 -0400
Message-ID: <20240710193707.43754-12-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: 190d5af8-968c-4b2d-7710-08dca117d59f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Bd47e8DkjJAwkUvXBh8FDpp8DqKm1Leg76TDrkmWvLek9NR/MPBZFZTzlWm?=
 =?us-ascii?Q?/GwSsU8WVrmYnuAlJdbDaeNbXSAIjojoF2pKhbkCxPGc4SHw3RCBoHwGh9Ym?=
 =?us-ascii?Q?biBq5WYnRylsPZ2vpMf5HnbMHhF5slBzVkbYAO4GAzLybv7qHcqV4L2xNEej?=
 =?us-ascii?Q?XcwwHarGhMb6f+A1UAw1pe4PXyErJFrJDDK9OQODaZc/4tnNf7EPUzV2gZjC?=
 =?us-ascii?Q?tzcpr5VevkcQtaWZRE447HWruDe+Y9/B5I6lTBXZLClnM7Nd/l8EL1DdzajM?=
 =?us-ascii?Q?RzsgPQWS8sdAK8fvz3xf22SF18Yrk3yF46q4izZrb40lRFWse0wzyv3CCC35?=
 =?us-ascii?Q?csVUVYPBeYZTte/MUqUgKcATnRXuTMNKg7/D9JQGFxjsrRBTNxf80rqMcrJk?=
 =?us-ascii?Q?Bcg4pAA1eQW/75kxzamQgDxygX05IXCw1MuYmXWIf5nn6mFCph6wpbL2ProH?=
 =?us-ascii?Q?Q+NMW4DlmeU9g2Q/s6R+oV2mF08eQGa3wF+0Xd35Nt6UAbmt+jGsZ5UEtjyq?=
 =?us-ascii?Q?uZYQUez4841IxHjTpAckvsGL6dz4+QoCbXA4X16ZBpX8XdQmphiceowiLLPB?=
 =?us-ascii?Q?7pVuePgHm9oV/obgzgqmjyTfahRrz2tNPIAtoQXwrldhWN49DaYL8p0n6zOA?=
 =?us-ascii?Q?T/Ptl5jdGOOElbaK5Xc3U8Axi8dfVW0JUqs6WkO2Zo/IfJklLNpnIkCi1lkn?=
 =?us-ascii?Q?w7meFIcvGAOFHh9MYCVfBVXDCVeZ0yF12/vTOW+ru08NpqSq7g5GSyKoCTa7?=
 =?us-ascii?Q?gzvdgsL9rrE4T9/0KlRSJab6ZGHsxDnZ+BLwedOyuV/SQZOm+isfeWF79l6T?=
 =?us-ascii?Q?CWsZCcoXUuezEWc85lN/FaNlrSvjNIV5fqrYFznkU8+QW6vhwyWR5ItN88Bg?=
 =?us-ascii?Q?ckj47C3xIEhK//twXyTf/9AZMklAcJ1hgEfr9RWfpZ3CcqDIM8tsWbE1NhyF?=
 =?us-ascii?Q?z4j5cuAH+xGaEu0xdkB7GY4EyVajg46QgEMn5670B+rUKNxaO3zSFK/1M4Cf?=
 =?us-ascii?Q?/Yfor9aFO7yV1F9r/Xo3A2rt1mpCYlLRb50Z337qqxrVnzjCxUOW1xQtsTif?=
 =?us-ascii?Q?31vWhWUaMoW92VbkfZaMVZASHet+yevham709YkJqAcH7qLYZeMbT7L5koaR?=
 =?us-ascii?Q?F5i/XNdD/BE0V8q9JZaDq7BAlqMDIlPG9t6T/zwyu3feD+AhBs9PVauYGSCP?=
 =?us-ascii?Q?5t/E23GxVSnIM4GZlmG5xRfsX2mVTY8A/NzLNS94JLff66PnnUCyEBF1RCQS?=
 =?us-ascii?Q?4WwtZcYbYaGRE5ArLtJvRGv0G1CUMsex3zdCat65vSVla+Xo2BlMpjp/FhYk?=
 =?us-ascii?Q?LrI5vWVh5hGeitC2uhy6p+N8HRE6KZhhY61vK1AjpU8Ndx5CP6YvpYPN60lT?=
 =?us-ascii?Q?mjVUDDS49/Z1LMmqlIXzUWccG7U6yRUXUsnj34E8bqPCSrqVzGayhPIUehCe?=
 =?us-ascii?Q?xcQIeF1rvJ8t4DyR4FvRQcs4+diSMaVl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:38:11.8053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 190d5af8-968c-4b2d-7710-08dca117d59f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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

From: Jingwen Zhu <jingwen.zhu@amd.com>

[Why]
This is a workaround for an dcn3.1 hang that happens if otg dispclk
is ramped while otg is on and stream enc is off.
But this w/a should not trigger when we have a dig active.

[How]
Avoid disable otg when dig FE/BE FIFO was not switched.

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Jingwen Zhu <jingwen.zhu@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 18 +++++++++++++++---
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c    |  9 +++++++++
 .../drm/amd/display/dc/inc/hw/stream_encoder.h |  1 +
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 70ee0089a20d..248d22b23a6d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -120,7 +120,6 @@ static int dcn35_get_active_display_cnt_wa(
 
 	return display_count;
 }
-
 static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context,
 		bool safe_to_lower, bool disable)
 {
@@ -128,14 +127,27 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 	int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
+		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
 		struct pipe_ctx *pipe = safe_to_lower
 			? &context->res_ctx.pipe_ctx[i]
 			: &dc->current_state->res_ctx.pipe_ctx[i];
-
+		bool stream_changed_otg_dig_on = false;
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
+		stream_changed_otg_dig_on = old_pipe->stream && new_pipe->stream &&
+		old_pipe->stream != new_pipe->stream &&
+		old_pipe->stream_res.tg == new_pipe->stream_res.tg &&
+		new_pipe->stream->link_enc && !new_pipe->stream->dpms_off &&
+		new_pipe->stream->link->link_enc->funcs->is_dig_enabled &&
+		new_pipe->stream->link->link_enc->funcs->is_dig_enabled(
+		new_pipe->stream->link->link_enc) &&
+		new_pipe->stream_res.stream_enc &&
+		new_pipe->stream_res.stream_enc->funcs->is_fifo_enabled &&
+		new_pipe->stream_res.stream_enc->funcs->is_fifo_enabled(new_pipe->stream_res.stream_enc);
 		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) ||
-				     !pipe->stream->link_enc)) {
+			!pipe->stream->link_enc) && !stream_changed_otg_dig_on) {
+			/* This w/a should not trigger when we have a dig active */
 			if (disable) {
 				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->disable_crtc)
 					pipe->stream_res.tg->funcs->disable_crtc(pipe->stream_res.tg);
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
index 6a179e5ab417..fcc88ef83e6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
@@ -392,6 +392,14 @@ static void enc35_reset_fifo(struct stream_encoder *enc, bool reset)
 		udelay(10);
 }
 
+static bool enc35_is_fifo_enabled(struct stream_encoder *enc)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+	uint32_t reset_val;
+
+	REG_GET(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, &reset_val);
+	return (reset_val == 0) ? false : true;
+}
 void enc35_disable_fifo(struct stream_encoder *enc)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
@@ -465,6 +473,7 @@ static const struct stream_encoder_funcs dcn35_str_enc_funcs = {
 	.set_input_mode = enc314_set_dig_input_mode,
 	.enable_fifo = enc35_enable_fifo,
 	.disable_fifo = enc35_disable_fifo,
+	.is_fifo_enabled = enc35_is_fifo_enabled,
 	.map_stream_to_link = enc35_stream_encoder_map_to_link,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index e5e11c84e9e2..6fe42120738d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -271,6 +271,7 @@ struct stream_encoder_funcs {
 		struct stream_encoder *enc, unsigned int pix_per_container);
 	void (*enable_fifo)(struct stream_encoder *enc);
 	void (*disable_fifo)(struct stream_encoder *enc);
+	bool (*is_fifo_enabled)(struct stream_encoder *enc);
 	void (*map_stream_to_link)(struct stream_encoder *enc, uint32_t stream_enc_inst, uint32_t link_enc_inst);
 };
 
-- 
2.34.1

