Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4C3C25B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1958D10E255;
	Fri, 31 May 2024 16:52:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OPpZRhZR";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 832B510E255
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofjD0zAwTaUEXlw7V9tZfDv4vZOHFvfnSiteQyyFPbn9R0WMYXgUWOwc4jyMhfn4ojiIvamW8SiZgozbaZXksCFAt+PF/a+U2plaNFAyOf7ENee1hLCC8HqQFbl8eSVJA48CWHd6iNcgFYT0Xg+f3bUCZFJbWLw0QK7M7r4PJRyT4ZFBLZsAo/gEi8YzX3p8o4fjPXdkiTQxj2t+/XhIbtQno37ABA2DAvlG2dtQNi2AhymfDbXKQ4e6MmP9TQLxWuZfo/zDKfSqsJmZzCTXFs/5bfy7/ywaOvAAMFE7fWygRAI2yIMSQP1qivodhAPR0k/edJuiRNAXm+7TY1TK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2RHJy8WFgTaNDkL49o2oSl+JA0uUT6hh3zBX6AUUbQ=;
 b=cG8yexMEbMwLgdbfS6DIKTnNEP5jtTDKSNQ33FoiidorJSn7losQrnzphi4KRah8jP7IpD432rGh3sUIMwlt3aLbfBuLC3GSqM4CfZu66ycHHeSPz2uexpe3IfWWxCijEA+d7mMjiz3c4X5bzHKZ2d9IckkIiPhT6IFuR/985C1P3MY48U7fcyHEqB5Q9t8AF0JLBdwk70wm5B9evwrtmC2CfJHA6lOTDDfvxyB1JMDyOqcDxurMg7d8yQ7mI9hIpJI6W7W2vLmRgWFRF7bz50hUMD7OrBbQtAMQQe0tN8KSSnDMiHuWBjpCJq8/k6LtEOPF+3jVxylc4KAAdCJSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2RHJy8WFgTaNDkL49o2oSl+JA0uUT6hh3zBX6AUUbQ=;
 b=OPpZRhZRM1YUIFB3KrigqrQlaANLojtJeG9w/MLJ78JkjhkPvjGHfJOoy8lY8dZ+ev6XXWycM+5b0dfkST9DAG108hfvr+l4puZ6PiJkIoyjh6oTKVMeGAzM9L6djKRZOlqnRoii6yLeGkJrueubgtOwCgf6H14QVjsK9o58b3I=
Received: from PH7PR10CA0010.namprd10.prod.outlook.com (2603:10b6:510:23d::19)
 by SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 16:52:25 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::ff) by PH7PR10CA0010.outlook.office365.com
 (2603:10b6:510:23d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Fri, 31 May 2024 16:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:24 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:22 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 02/32] drm/amd/display: turn on symclk for dio virtual stream
 in dpms sequence
Date: Fri, 31 May 2024 12:51:15 -0400
Message-ID: <20240531165145.1874966-3-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb74b96-d7ce-4538-ebef-08dc81920c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bIqcDngoAiA4bkiefhW3a3VY/1hP4KGNIHQ/8bLlxBqyhgq0aIJAHm8Dyt5+?=
 =?us-ascii?Q?LKnwVy+dR3Ji4SXtWi7uV/p4ljbCY0FANUO0+rb3wD+1c7oUYSrrnfkEPPZN?=
 =?us-ascii?Q?4SH1uWBFqwbgMGyQlpoO6lUB4vPfw49vH6wu/Nt9wcLTkCmnmg1BFCLtbA7e?=
 =?us-ascii?Q?KgabJzDwB+DE62yGjo8FzK4Wrk2CM1UzFz5Nac1aXxykoPdYN4GlTSAdI8np?=
 =?us-ascii?Q?LEHcIKk7XkB2RaGQEhNEv/8TbEynzpmle1uu4Iz+WfsyWHeG00o5XIs2sodh?=
 =?us-ascii?Q?/1baylALwnpBQf7olVt6FdhEKWI+XGn5I6LYCQ+xSiLv2oIZit0ZAiAdFcnm?=
 =?us-ascii?Q?c8AWUqI0mTuQGUKcxE9YVsk+kTELQ7CYGD/leETuCBVSomWHWwzhvznxkWLn?=
 =?us-ascii?Q?q327DEeskfxTEqMd4o/6eFgKb6QAapn9KDRuDZF/HoPNYqKyBv3t9Bb8ePUg?=
 =?us-ascii?Q?iOBuI8bGinlmW4jQcnCoZLP2qbE0bRbKfH0l+7voTO68r6wp7haUc9VBc9OY?=
 =?us-ascii?Q?qvk65JFFjvkC1SnyL/EmJii1nsWapIC/lpZfaya9LkDfV0RT2LLHPSITXrbR?=
 =?us-ascii?Q?KpwWW6Y4QIqzawwDcEn0GvsG/Elemm4e2JzvnhjhZL5/4+13dAx0aq579IUd?=
 =?us-ascii?Q?BddZly/RzyRrZhVNZj3X6kWC0C+lIztrETgLPiMOzpqRwUkN299sBVlptm5I?=
 =?us-ascii?Q?KqJFD64yRRv3IELmEk80MAjhiT/e9e02Bi+l6XeKmPMANtfg+1HCssYkdOgg?=
 =?us-ascii?Q?6Gywj74RTeJekLeB8ZiIY/kzK6dE/U6pElj+oMP1SkDKcKBTgayKS0XnG/1H?=
 =?us-ascii?Q?qmokWn6ExStliayVarF4euabZtopyQaTfH/JGcqmWFRP1QtlhhwW9wkKzIHq?=
 =?us-ascii?Q?fC95t7znqTnUe12KaiQ0uWwNwnPOmwZm4SYmaHhJwrRBHR1wXshs9T/I9db5?=
 =?us-ascii?Q?K8+fiJmrv4D+SLIIGg8Ptt0Rfbnrl69ZyJsh726wYJjMx5lCHRAM/mnyNJUY?=
 =?us-ascii?Q?WpV/5uvBzOvrQ4T1t+3Uk+tAcUYIrlW33XkPE3rYWEi5LWUgtmgXFP+g1gL8?=
 =?us-ascii?Q?7QWaKgFe2KXZgJOyTDIno17gte4XXdB9r51UCNV5CcHQtOYEd5ea0w5at0lo?=
 =?us-ascii?Q?wnM79XNoxcarkUXWt2Z0y3E/f3TdVb7KEIFH8F652LOdyxxeY4L7yB98hhrM?=
 =?us-ascii?Q?4BcI44issWhufTkkWTOZ7t4JjTstmNxVuvxqIZ64Z5S6Pa+zE2h0BZVoN3kJ?=
 =?us-ascii?Q?CdJuemsSWenIfSXBeTillo8w1hw3UxJTPEdf3s8mnbcngsS+jf9ruDdy5pzD?=
 =?us-ascii?Q?NUTX04iUESNgTdkytBtHzd20o1QR5J4bHLqo6RRUNzufddC/L+Y3vuuiRIcm?=
 =?us-ascii?Q?qGAKdZJz4GLaOcjJ/JE3LHcRaIIc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:24.6212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb74b96-d7ce-4538-ebef-08dc81920c0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
In order to support glitchless display clock ramping for virtual stream,
we must
turn on symclk for stream encoder. The code will power on phy and enable
symclk
for dio encoder during virtual stream dpms sequence.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  6 ++--
 .../dc/dcn35/dcn35_dio_stream_encoder.c       |  3 +-
 .../dc/dcn401/dcn401_dio_stream_encoder.c     |  3 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |  2 +-
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  7 ++++-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 31 ++++++++++---------
 .../dc/link/protocols/link_dp_capability.c    |  3 ++
 7 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index dc236264d9b3..234236c43d21 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3648,8 +3648,10 @@ enum dc_status resource_map_pool_resources(
 	/* Allocate DP HPO Stream Encoder based on signal, hw capabilities
 	 * and link settings
 	 */
-	if (dc_is_dp_signal(stream->signal)) {
-		if (!dc->link_srv->dp_decide_link_settings(stream, &pipe_ctx->link_config.dp_link_settings))
+	if (dc_is_dp_signal(stream->signal) ||
+			dc_is_virtual_signal(stream->signal)) {
+		if (!dc->link_srv->dp_decide_link_settings(stream,
+				&pipe_ctx->link_config.dp_link_settings))
 			return DC_FAIL_DP_LINK_BANDWIDTH;
 		if (dc->link_srv->dp_get_encoding_format(
 				&pipe_ctx->link_config.dp_link_settings) == DP_128b_132b_ENCODING) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
index 2595cbef5942..1325db3a4ed0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
@@ -254,6 +254,7 @@ static void enc35_stream_encoder_enable(
 			break;
 		case SIGNAL_TYPE_EDP:
 		case SIGNAL_TYPE_DISPLAY_PORT:
+		case SIGNAL_TYPE_VIRTUAL:
 			/* DP SST */
 			REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_MODE, 0);
 			break;
@@ -459,7 +460,7 @@ static const struct stream_encoder_funcs dcn35_str_enc_funcs = {
 	.dp_set_dsc_pps_info_packet = enc3_dp_set_dsc_pps_info_packet,
 	.set_dynamic_metadata = enc2_set_dynamic_metadata,
 	.hdmi_reset_stream_attribute = enc1_reset_hdmi_stream_attribute,
-	.dig_stream_enable = enc35_stream_encoder_enable,
+	.enable_stream = enc35_stream_encoder_enable,
 
 	.set_input_mode = enc314_set_dig_input_mode,
 	.enable_fifo = enc35_enable_fifo,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c
index 090288305609..2ebfca4769aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c
@@ -416,6 +416,7 @@ static void enc401_stream_encoder_enable(
 			break;
 		case SIGNAL_TYPE_EDP:
 		case SIGNAL_TYPE_DISPLAY_PORT:
+		case SIGNAL_TYPE_VIRTUAL:
 			/* DP SST */
 			REG_UPDATE(DIG_FE_CLK_CNTL, DIG_FE_MODE, 0);
 			break;
@@ -760,7 +761,7 @@ static const struct stream_encoder_funcs dcn401_str_enc_funcs = {
 	.dp_set_dsc_pps_info_packet = enc3_dp_set_dsc_pps_info_packet,
 	.set_dynamic_metadata = enc401_set_dynamic_metadata,
 	.hdmi_reset_stream_attribute = enc1_reset_hdmi_stream_attribute,
-	.dig_stream_enable = enc401_stream_encoder_enable,
+	.enable_stream = enc401_stream_encoder_enable,
 
 	.set_input_mode = enc401_set_dig_input_mode,
 	.enable_fifo = enc32_enable_fifo,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 60228f5de4d7..e5e11c84e9e2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -223,7 +223,7 @@ struct stream_encoder_funcs {
 		struct stream_encoder *enc,
 		int tg_inst);
 
-	void (*dig_stream_enable)(
+	void (*enable_stream)(
 		struct stream_encoder *enc,
 		enum signal_type signal,
 		bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index afe4614e0087..50459d7a0f85 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
@@ -46,6 +46,9 @@ void setup_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		pipe_ctx->stream->ctx->dc->link_srv->dp_trace_source_sequence(pipe_ctx->stream->link,
 				DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_BE);
+	if (stream_enc->funcs->enable_stream)
+		stream_enc->funcs->enable_stream(stream_enc,
+				pipe_ctx->stream->signal, true);
 	if (stream_enc->funcs->map_stream_to_link)
 		stream_enc->funcs->map_stream_to_link(stream_enc,
 				stream_enc->stream_enc_inst, link_enc->transmitter - TRANSMITTER_UNIPHY_A);
@@ -65,7 +68,9 @@ void reset_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
 		stream_enc->funcs->disable_fifo(stream_enc);
 	if (stream_enc->funcs->set_input_mode)
 		stream_enc->funcs->set_input_mode(stream_enc, 0);
-
+	if (stream_enc->funcs->enable_stream)
+		stream_enc->funcs->enable_stream(stream_enc,
+				pipe_ctx->stream->signal, false);
 	link_enc->funcs->connect_dig_be_to_fe(
 			link_enc,
 			pipe_ctx->stream_res.stream_enc->id,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 955c720fb565..a9ddbe12142f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1907,7 +1907,9 @@ static void disable_link(struct dc_link *link,
 {
 	if (dc_is_dp_signal(signal)) {
 		disable_link_dp(link, link_res, signal);
-	} else if (signal != SIGNAL_TYPE_VIRTUAL) {
+	} else if (signal == SIGNAL_TYPE_VIRTUAL) {
+		link->dc->hwss.disable_link_output(link, link_res, SIGNAL_TYPE_DISPLAY_PORT);
+	} else {
 		link->dc->hwss.disable_link_output(link, link_res, signal);
 	}
 
@@ -2154,6 +2156,18 @@ static enum dc_status enable_link_dp_mst(
 	return enable_link_dp(state, pipe_ctx);
 }
 
+static enum dc_status enable_link_virtual(struct pipe_ctx *pipe_ctx)
+{
+	struct dc_link *link = pipe_ctx->stream->link;
+
+	link->dc->hwss.enable_dp_link_output(link,
+			&pipe_ctx->link_res,
+			SIGNAL_TYPE_DISPLAY_PORT,
+			pipe_ctx->clock_source->id,
+			&pipe_ctx->link_config.dp_link_settings);
+	return DC_OK;
+}
+
 static enum dc_status enable_link(
 		struct dc_state *state,
 		struct pipe_ctx *pipe_ctx)
@@ -2193,7 +2207,7 @@ static enum dc_status enable_link(
 		status = DC_OK;
 		break;
 	case SIGNAL_TYPE_VIRTUAL:
-		status = DC_OK;
+		status = enable_link_virtual(pipe_ctx);
 		break;
 	default:
 		break;
@@ -2437,17 +2451,10 @@ void link_set_dpms_on(
 
 	if (!dc_is_virtual_signal(pipe_ctx->stream->signal)
 			&& !dp_is_128b_132b_signal(pipe_ctx)) {
-		struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
-
 		if (link_enc)
 			link_enc->funcs->setup(
 				link_enc,
 				pipe_ctx->stream->signal);
-
-		if (stream_enc && stream_enc->funcs->dig_stream_enable)
-			stream_enc->funcs->dig_stream_enable(
-				stream_enc,
-				pipe_ctx->stream->signal, 1);
 	}
 
 	pipe_ctx->stream->link->link_state_valid = true;
@@ -2547,18 +2554,12 @@ void link_set_dpms_on(
 	 */
 	if (!(dc_is_virtual_signal(pipe_ctx->stream->signal) ||
 			dp_is_128b_132b_signal(pipe_ctx))) {
-			struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
 			if (link_enc)
 				link_enc->funcs->setup(
 					link_enc,
 					pipe_ctx->stream->signal);
 
-			if (stream_enc && stream_enc->funcs->dig_stream_enable)
-				stream_enc->funcs->dig_stream_enable(
-					stream_enc,
-					pipe_ctx->stream->signal, 1);
-
 		}
 
 	dc->hwss.enable_stream(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 766116ec627d..964abccebdc6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -955,6 +955,9 @@ bool link_decide_link_settings(struct dc_stream_state *stream,
 		} else {
 			edp_decide_link_settings(link, link_setting, req_bw);
 		}
+	} else if (stream->signal == SIGNAL_TYPE_VIRTUAL) {
+		link_setting->lane_count = LANE_COUNT_FOUR;
+		link_setting->link_rate = LINK_RATE_HIGH3;
 	} else {
 		decide_dp_link_settings(link, link_setting, req_bw);
 	}
-- 
2.34.1

