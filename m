Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86525C41513
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD05789DFF;
	Tue, 11 Jun 2024 16:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="crvAtBNi";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7558010E6DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCiXcjbR+UgEc7+a3S6ixFUoRcQMbcU0a9JMMTwPiHu4qCa0wie3AuJvAkodnzWQuP6ScIoKNrbzexDlm8tkXYTVedcDjWyA5LdKBnR5bPLBUM/eNsUjOaFtAK2qY2LST8mqUx9Byovt/4ed0iGYcVSUGDttMho5jWyZP8FlzpHoJp5k4flY/73KgLY3Wf+uzY+a5jodywxGQKXzkxJYkHRUDKelENcCeYDrDeU86IQZpATAw9PX3vdLdrf499cb9xIGmqBhgNrXg9RXkj4TEpFXG3eJyIM73w+KV8GBu+9bIlRgkiZhBfhyXg8qanr12PDguzmougotNp7lyWBZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rebHY1LeKBarSM7guNN3OobJP6fObdo50a2n1SLOwQ=;
 b=d9L8KCW6YdO8NDy3+7QM69jBszRK+CRgX1zZ8+TyliUGnxpnx4V4JQmDTj8ihUtjlCRKAXtEplJq/3K0LpwxJOEhYdrZRURtYGk3KchY/YGPIVO7P1Q02MYaK2Fg+ku/c6RoRxPNIw5ARmUh8uDA4tul/Np8SsPNqw7bFhonyy9fYh89NxyT2kRVo0HGwWnFRO2HS3CHyFX6jqU6Dj/urLMq4pzFzCWb3rliotIjOziK4sLVCEpgqrkf/l7ym63RfnaBstOGB0tqbPCZmyJp9fe6fXJE4LNJA9ddetIYTEMkqnmG9Oye9CP/g/YhB1pBE/WLGeOkjQUBWNIbvcIqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rebHY1LeKBarSM7guNN3OobJP6fObdo50a2n1SLOwQ=;
 b=crvAtBNigQzzxM7e8rpHsTKsTRd9xjSu4QtPeWzM3KhSg6WwMPYEn4i5GPwo2dLkcMplOcILuJLbKOpHwcjogd4RKQKLDl59Vajhr3pGix2iA174HEeKnMANa4nqVSLm4OWdtkLRd+F4lBVuq3B2e+HVBcQBxJj6Lb9tlHNx94M=
Received: from BLAPR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:32b::18)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:52:44 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::3f) by BLAPR03CA0013.outlook.office365.com
 (2603:10b6:208:32b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:44 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:39 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 22/36] drm/amd/display: Check dc_stream_state before it is used
Date: Tue, 11 Jun 2024 12:51:25 -0400
Message-ID: <20240611165204.195093-23-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: c86a5913-cd88-46e4-347e-08dc8a36ea54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JFcRUqyEQ1PZYyiVv6UWI9g5PfTEUB41RTFidvpD6meYV2hM/0Z+BCNNIK2A?=
 =?us-ascii?Q?iiV1nlSKosrfd7hM6K1pauWT71TgIS2E1OynIWpqt7w5WFisFlMqPlmbL6in?=
 =?us-ascii?Q?dawSnxc+bwOlIa/K75MSuD5nVM5e1mMICf/d+luRWm4oGTXIvFd1GoKmIGF7?=
 =?us-ascii?Q?MqxN77uqUGXHm8Wuz/iR2zWXH1Mo6WQwnrMbwUdtRipVR7AQ6yotsH/6iXZs?=
 =?us-ascii?Q?FiKH0lyqky8mAVp6V/xtXuMyeJHLBlJpBYFUwNOwCxOUqioh8x3qqAf0Snlu?=
 =?us-ascii?Q?dTcI0PxB8euNIg8312sYEnGm257Dy7KimbN3VqUH0Hf1NNo5bpZyNliW2jkP?=
 =?us-ascii?Q?BGw1XRjRKrm8PAPy0wgx0kEOROq7OLCvdlMsju91EfY3K83jZbV9RsFAOTgx?=
 =?us-ascii?Q?WTj2w6Dfaa5ZjIrpOvyAHGzqZ734P6GGRRdZlMBulLf2YMthJqGMM2FFsg3z?=
 =?us-ascii?Q?nsGT9/8alRWDdqT+O5oJXVaWrsHX18kwI1QjreFenEjPerCxZsi2dX7Z84N7?=
 =?us-ascii?Q?Bm6wjImsgXhrfyeKjSIT60bzi9DFzzJ6xVWl2HF0FyYuXJgq7fQ8H4KQjlni?=
 =?us-ascii?Q?izwqKsyf9qeb2Ln3mK+Qa80BHwSuvRYl2125ZehlH+DMp+SfiLYUzSaEv7LS?=
 =?us-ascii?Q?Khq3eECDDFp7+OUSIfdGiehq3sI1VQAdiG/uHVhf2Ce6XgdOjf25Hm83bR3X?=
 =?us-ascii?Q?jRWgHWVAth4zaI5heirXvpBnLdrzS0+JbBZr5I8SjcT44CnPWyzgF+rvnqR1?=
 =?us-ascii?Q?qPIE7hKYy9H9gNLKjDgyZ+1qwxAPhPF2nPzNyjW+YafrqtBCtVFOOaKO8LnQ?=
 =?us-ascii?Q?pbgAe6olHJ9aN56UY5o/SEQAwDDhg7XJznVQ4/9SQNeuDESk/kt5Hac5kj+H?=
 =?us-ascii?Q?EW5XZTBy4ThFHAfUron0i4YeGeKYIhFmEVb2JKlfuTsQ1XGdSWaa0mSHelX8?=
 =?us-ascii?Q?1YyNuI3Sb1U3gaxZSXEojOHeXgYqgsjbpBMSPfr2Pn0uX/Eu3rMyd/XtsqIV?=
 =?us-ascii?Q?Q2ln2MmQpPdWsh+PNBEsV6byeSnrFj4bDgHxeQaO/XC4KjqkirueA1hi6Ebo?=
 =?us-ascii?Q?+CIsbDU+twZJI0yisbUYoWZwszai/INv+BuD4+2u+Hx3sP9DynH4rno3gBEt?=
 =?us-ascii?Q?ALS52JTpyfTs8+PSUzfModauiApWT4LtvpoqpYxrOWOnSFH0fBW0tDjVkcP9?=
 =?us-ascii?Q?X7BUZPILJ2HHcLi7+3IU/YruQ/EtgcpqEsss1WckqWs/3kkw1M+T8xy2+NT5?=
 =?us-ascii?Q?Lc+OU5rqlCXXQIaJDmykWxZyGsmCTdRt1D3ySAsQhhT2dBF63pGyMiZ4psaQ?=
 =?us-ascii?Q?WBrLr/BbxA0vb7K58lbOq9Cdj2L8hIupLJjLzL3VINiiWvHcQ2fOuhZmpTWL?=
 =?us-ascii?Q?AurQJOzWWReRFTZaimR+PuqGMMC4Te2+8QyQKH65eVZ5w+t2bw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:44.3396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c86a5913-cd88-46e4-347e-08dc8a36ea54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
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

From: Alex Hung <alex.hung@amd.com>

dc_state_get_stream_status dc_state_get_paired_subvp_stream and other
functions can return null, and therefore null must be checked before
status can be used.

This fixes 21 NULL_RETURNS issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 17 +++++++++----
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 24 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 20 ++++++++++++++--
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  8 +++----
 .../amd/display/dc/dml2/dml21/dml21_utils.c   | 12 +++++++++-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  6 +++--
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  9 ++++---
 .../dc/resource/dcn32/dcn32_resource.c        |  2 ++
 8 files changed, 74 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 25a498f65c1c..fce1c3e03094 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1233,11 +1233,14 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 			 */
 			if (is_phantom) {
 				if (tg->funcs->enable_crtc) {
-					int main_pipe_width, main_pipe_height;
+					int main_pipe_width = 0, main_pipe_height = 0;
 					struct dc_stream_state *old_paired_stream = dc_state_get_paired_subvp_stream(dc->current_state, old_stream);
 
-					main_pipe_width = old_paired_stream->dst.width;
-					main_pipe_height = old_paired_stream->dst.height;
+					if (old_paired_stream) {
+						main_pipe_width = old_paired_stream->dst.width;
+						main_pipe_height = old_paired_stream->dst.height;
+					}
+
 					if (dc->hwss.blank_phantom)
 						dc->hwss.blank_phantom(dc, tg, main_pipe_width, main_pipe_height);
 					tg->funcs->enable_crtc(tg);
@@ -1628,6 +1631,9 @@ static void program_timing_sync(
 		for (k = 0; k < group_size; k++) {
 			struct dc_stream_status *status = dc_state_get_stream_status(ctx, pipe_set[k]->stream);
 
+			if (!status)
+				continue;
+
 			status->timing_sync_info.group_id = num_group;
 			status->timing_sync_info.group_size = group_size;
 			if (k == 0)
@@ -2225,6 +2231,9 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params
 			if (dc_is_embedded_signal(params->streams[i]->signal)) {
 				struct dc_stream_status *status = dc_state_get_stream_status(context, params->streams[i]);
 
+				if (!status)
+					continue;
+
 				if (dc->hwss.is_abm_supported)
 					status->is_abm_supported = dc->hwss.is_abm_supported(dc, context, params->streams[i]);
 				else
@@ -4023,7 +4032,7 @@ static void commit_planes_for_stream(struct dc *dc,
 			stream_status =
 				stream_get_status(context, pipe_ctx->stream);
 
-			if (dc->hwss.apply_ctx_for_surface)
+			if (dc->hwss.apply_ctx_for_surface && stream_status)
 				dc->hwss.apply_ctx_for_surface(
 					dc, pipe_ctx->stream, stream_status->plane_count, context);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index c75dcdc20428..e990346e51f6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -794,11 +794,16 @@ enum dc_status dc_state_add_phantom_stream(const struct dc *dc,
 
 	/* setup subvp meta */
 	main_stream_status = dc_state_get_stream_status(state, main_stream);
+	if (main_stream_status) {
+		main_stream_status->mall_stream_config.type = SUBVP_MAIN;
+		main_stream_status->mall_stream_config.paired_stream = phantom_stream;
+	}
+
 	phantom_stream_status = dc_state_get_stream_status(state, phantom_stream);
-	phantom_stream_status->mall_stream_config.type = SUBVP_PHANTOM;
-	phantom_stream_status->mall_stream_config.paired_stream = main_stream;
-	main_stream_status->mall_stream_config.type = SUBVP_MAIN;
-	main_stream_status->mall_stream_config.paired_stream = phantom_stream;
+	if (phantom_stream_status) {
+		phantom_stream_status->mall_stream_config.type = SUBVP_PHANTOM;
+		phantom_stream_status->mall_stream_config.paired_stream = main_stream;
+	}
 
 	return res;
 }
@@ -807,14 +812,17 @@ enum dc_status dc_state_remove_phantom_stream(const struct dc *dc,
 		struct dc_state *state,
 		struct dc_stream_state *phantom_stream)
 {
-	struct dc_stream_status *main_stream_status;
+	struct dc_stream_status *main_stream_status = NULL;
 	struct dc_stream_status *phantom_stream_status;
 
 	/* reset subvp meta */
 	phantom_stream_status = dc_state_get_stream_status(state, phantom_stream);
-	main_stream_status = dc_state_get_stream_status(state, phantom_stream_status->mall_stream_config.paired_stream);
-	phantom_stream_status->mall_stream_config.type = SUBVP_NONE;
-	phantom_stream_status->mall_stream_config.paired_stream = NULL;
+	if (phantom_stream_status) {
+		main_stream_status = dc_state_get_stream_status(state, phantom_stream_status->mall_stream_config.paired_stream);
+		phantom_stream_status->mall_stream_config.type = SUBVP_NONE;
+		phantom_stream_status->mall_stream_config.paired_stream = NULL;
+	}
+
 	if (main_stream_status) {
 		main_stream_status->mall_stream_config.type = SUBVP_NONE;
 		main_stream_status->mall_stream_config.paired_stream = NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 6ff87b023081..b2051c4dd7b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -562,7 +562,7 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
 {
 	struct dc_stream_state *phantom_stream = dc_state_get_paired_subvp_stream(context, subvp_pipe->stream);
 	struct dc_crtc_timing *main_timing = &subvp_pipe->stream->timing;
-	struct dc_crtc_timing *phantom_timing = &phantom_stream->timing;
+	struct dc_crtc_timing *phantom_timing;
 	struct dc_crtc_timing *drr_timing = &vblank_pipe->stream->timing;
 	uint16_t drr_frame_us = 0;
 	uint16_t min_drr_supported_us = 0;
@@ -576,6 +576,11 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
 	uint16_t min_vtotal_supported = 0;
 	uint16_t max_vtotal_supported = 0;
 
+	if (!phantom_stream)
+		return;
+
+	phantom_timing = &phantom_stream->timing;
+
 	pipe_data->pipe_config.vblank_data.drr_info.drr_in_use = true;
 	pipe_data->pipe_config.vblank_data.drr_info.use_ramping = false; // for now don't use ramping
 	pipe_data->pipe_config.vblank_data.drr_info.drr_window_size_ms = 4; // hardcode 4ms DRR window for now
@@ -699,7 +704,13 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 	struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 *pipe_data = NULL;
 
 	phantom_stream0 = dc_state_get_paired_subvp_stream(context, subvp_pipes[0]->stream);
+	if (!phantom_stream0)
+		return;
+
 	phantom_stream1 = dc_state_get_paired_subvp_stream(context, subvp_pipes[1]->stream);
+	if (!phantom_stream1)
+		return;
+
 	phantom_timing0 = &phantom_stream0->timing;
 	phantom_timing1 = &phantom_stream1->timing;
 
@@ -754,9 +765,14 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 			&cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[cmd_pipe_index];
 	struct dc_stream_state *phantom_stream = dc_state_get_paired_subvp_stream(context, subvp_pipe->stream);
 	struct dc_crtc_timing *main_timing = &subvp_pipe->stream->timing;
-	struct dc_crtc_timing *phantom_timing = &phantom_stream->timing;
+	struct dc_crtc_timing *phantom_timing;
 	uint32_t out_num_stream, out_den_stream, out_num_plane, out_den_plane, out_num, out_den;
 
+	if (!phantom_stream)
+		return;
+
+	phantom_timing = &phantom_stream->timing;
+
 	pipe_data->mode = SUBVP;
 	pipe_data->pipe_config.subvp_data.pix_clk_100hz = subvp_pipe->stream->timing.pix_clk_100hz;
 	pipe_data->pipe_config.subvp_data.htotal = subvp_pipe->stream->timing.h_total;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 5ef10e2b9443..a63b5dcba3f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -738,9 +738,9 @@ static bool subvp_subvp_schedulable(struct dc *dc, struct dc_state *context)
 		/* Loop to calculate the maximum microschedule time between the two SubVP pipes,
 		 * and also to store the two main SubVP pipe pointers in subvp_pipes[2].
 		 */
-		if (pipe->stream && pipe->plane_state && !pipe->top_pipe &&
+		phantom = dc_state_get_paired_subvp_stream(context, pipe->stream);
+		if (phantom && pipe->stream && pipe->plane_state && !pipe->top_pipe &&
 			dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_MAIN) {
-			phantom = dc_state_get_paired_subvp_stream(context, pipe->stream);
 			microschedule_lines = (phantom->timing.v_total - phantom->timing.v_front_porch) +
 					phantom->timing.v_addressable;
 
@@ -845,8 +845,8 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
 		}
 	}
 
-	if (subvp_found && drr_found) {
-		phantom_stream = dc_state_get_paired_subvp_stream(context, pipe->stream);
+	phantom_stream = dc_state_get_paired_subvp_stream(context, pipe->stream);
+	if (phantom_stream && subvp_found && drr_found) {
 		main_timing = &pipe->stream->timing;
 		phantom_timing = &phantom_stream->timing;
 		drr_timing = &drr_pipe->stream->timing;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
index b97d9abfdbc6..87c7b13391bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
@@ -108,6 +108,8 @@ int dml21_find_dc_pipes_for_plane(const struct dc *in_dc,
 
 	dc_main_stream = dml_ctx->config.callbacks.get_stream_from_id(context, main_stream_id);
 	dc_main_stream_status = dml_ctx->config.callbacks.get_stream_status(context, dc_main_stream);
+	if (!dc_main_stream_status)
+		return num_pipes;
 
 	/* find main plane based on id */
 	dc_plane_index = dml21_get_dc_plane_idx_from_plane_id(dml_ctx->v21.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_id[dml_plane_idx]);
@@ -325,6 +327,8 @@ static struct dc_stream_state *dml21_add_phantom_stream(struct dml2_context *dml
 	struct dml2_stream_parameters *phantom_stream_descriptor = &stream_programming->phantom_stream.descriptor;
 
 	phantom_stream = dml_ctx->config.svp_pstate.callbacks.create_phantom_stream(dc, context, main_stream);
+	if (!phantom_stream)
+		return NULL;
 
 	/* copy details of phantom stream from main */
 	memcpy(&phantom_stream->timing, &main_stream->timing, sizeof(phantom_stream->timing));
@@ -411,7 +415,7 @@ void dml21_handle_phantom_streams_planes(const struct dc *dc, struct dc_state *c
 
 			main_stream_status = dml_ctx->config.callbacks.get_stream_status(context, main_stream);
 
-			if (main_stream_status->plane_count == 0)
+			if (!main_stream_status || main_stream_status->plane_count == 0)
 				continue;
 
 			/* create phantom stream for subvp enabled stream */
@@ -421,6 +425,9 @@ void dml21_handle_phantom_streams_planes(const struct dc *dc, struct dc_state *c
 					main_stream,
 					&dml_ctx->v21.mode_programming.programming->stream_programming[dml_stream_index]);
 
+			if (!phantom_stream)
+				continue;
+
 			/* iterate through DML planes associated with this stream */
 			for (dml_plane_index = 0; dml_plane_index < dml_ctx->v21.mode_programming.programming->display_config.num_planes; dml_plane_index++) {
 				if (dml_ctx->v21.mode_programming.programming->plane_programming[dml_plane_index].plane_descriptor->stream_index == dml_stream_index) {
@@ -509,6 +516,9 @@ void dml21_build_fams2_programming(const struct dc *dc,
 			break;
 		case FAMS2_STREAM_TYPE_SUBVP:
 			phantom_stream = dml_ctx->config.svp_pstate.callbacks.get_paired_subvp_stream(context, stream);
+			if (!phantom_stream)
+				break;
+
 			phantom_status = dml_ctx->config.callbacks.get_stream_status(context, phantom_stream);
 
 			/* phantom status should always be present */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 23ffecfd70eb..486b222083e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -874,13 +874,14 @@ static unsigned int get_target_odm_factor(
 		default:
 			break;
 		}
-	}
-	else if (ctx->architecture == dml2_architecture_21) {
+	} else if (ctx->architecture == dml2_architecture_21) {
 		if (ctx->config.svp_pstate.callbacks.get_stream_subvp_type(state, stream) == SUBVP_PHANTOM) {
 			struct dc_stream_state *main_stream;
 
 			/* get stream id of main stream */
 			main_stream = ctx->config.svp_pstate.callbacks.get_paired_subvp_stream(state, stream);
+			if (!main_stream)
+				goto failed;
 
 			/* get cfg idx for associated main stream */
 			cfg_idx = find_disp_cfg_idx_by_stream_id(
@@ -893,6 +894,7 @@ static unsigned int get_target_odm_factor(
 		return ctx->v21.mode_programming.programming->stream_programming[cfg_idx].num_odms_required;
 	}
 
+failed:
 	ASSERT(false);
 	return 1;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 09376c367c14..1b71cb365aa9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2051,11 +2051,14 @@ void dcn20_program_front_end_for_ctx(
 
 			if (tg->funcs->enable_crtc) {
 				if (dc->hwss.blank_phantom) {
-					int main_pipe_width, main_pipe_height;
+					int main_pipe_width = 0, main_pipe_height = 0;
 					struct dc_stream_state *phantom_stream = dc_state_get_paired_subvp_stream(dc->current_state, dc->current_state->res_ctx.pipe_ctx[i].stream);
 
-					main_pipe_width = phantom_stream->dst.width;
-					main_pipe_height = phantom_stream->dst.height;
+					if (phantom_stream) {
+						main_pipe_width = phantom_stream->dst.width;
+						main_pipe_height = phantom_stream->dst.height;
+					}
+
 					dc->hwss.blank_phantom(dc, tg, main_pipe_width, main_pipe_height);
 				}
 				tg->funcs->enable_crtc(tg);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 2e1b30a33ea9..969658313fd6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1687,6 +1687,8 @@ static struct dc_stream_state *dcn32_enable_phantom_stream(struct dc *dc,
 	struct pipe_ctx *ref_pipe = &context->res_ctx.pipe_ctx[dc_pipe_idx];
 
 	phantom_stream = dc_state_create_phantom_stream(dc, context, ref_pipe->stream);
+	if (!phantom_stream)
+		return phantom_stream;
 
 	/* stream has limited viewport and small timing */
 	memcpy(&phantom_stream->timing, &ref_pipe->stream->timing, sizeof(phantom_stream->timing));
-- 
2.45.1

