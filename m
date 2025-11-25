Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D4BD0E6F1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 14:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2853210E2A4;
	Tue, 25 Nov 2025 14:39:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="on4x6fWw";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9101010E2A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 14:39:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5Cd0gc6AxU126TYhclCaxCyvkaQBfkqLj7RO/HlKsVKpIttYvQs28VE+FHF15h8MZgN6h2yQAWWhIltzstBsZcty72jOZK/jJKH+j6TgdqjPdG2O5iCTFMQvXozHGmYyd9/2+fFhXe2N3udZ8ay/cDPJa3Dv8F0ARNF+wB/o3gBUNe26qL2R46avtJDbTPRnCKYLa2Fqy0XcJ1lq+ixC8TYW32bTqWde7/twkrvYdDUlvIvH75osnzRer3Hs4E4X2kRN3snShRpMrW068nUazdl1nScO/owmL0EHzPLY5YHSfOKHJmKSG4EwORkWQKmqvPpeB0Hz+60wzVE192jQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDZGgvBGyXqHhLAHhefkcAlWe8OIkTFRIS2WvopgLJk=;
 b=tnQGQc0XbC6YZRAfVlmgf4u8bASgSK8Kw3iaWeLyO875q48oKs/hy4rSmdyydhHDZ20NT0dETrBEg0jY9NhWDHx0B1Gt6LuhrKS31H1xhGN3ZfO3fXGETMvj00OLCiR3uWgOvzUjrtIW2Rn32+FEogOm0q0tEzTzXg4VWym/LkeSr4diltoCHQvk6G4jaMz4Po9k2p8HOyL2aP9/YcJLNIFlazQUznAJUczDv7b3c8QJoUtyyYjpZ3331QgzwJOEehjvb2vs6zRZalfIDPpAz5aQB7yD9RAnoFsEXJoTPG3QmPYlMSEqZvKpThNnTk2geipl6xxxH5C3KnpkJIreQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDZGgvBGyXqHhLAHhefkcAlWe8OIkTFRIS2WvopgLJk=;
 b=on4x6fWwnqVXjVq+Efhl+cUXLFThQF/e0CY1fYl7ZaHR0kYnlUqq41NyvQ0vB7JpaMvxz0Gu6ieiNGomcUSLtm/IJvIzknjfJMtc+WO9+tLKw8+N2JgQLzn6nggJkqhhc1wUeea2LfKmro9VE6MB03L5n/xpr/HWiGIudvJtJmw=
Received: from CH2PR02CA0021.namprd02.prod.outlook.com (2603:10b6:610:4e::31)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 14:39:19 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::c4) by CH2PR02CA0021.outlook.office365.com
 (2603:10b6:610:4e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Tue,
 25 Nov 2025 14:38:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 14:39:18 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 08:39:18 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <Sunpeng.Li@amd.com>,
 <ivan.lipski@amd.com>
Subject: [PATCH] Revert "drm/amd/display: Move setup_stream_attribute"
Date: Tue, 25 Nov 2025 09:39:00 -0500
Message-ID: <20251125143900.2027472-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: c49d0a26-d1d4-4469-a8cc-08de2c306a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qt3P3RypSZG4RigB3LrlI5qzbVQ8EB4kUQtuXsvrJm18XXqQLlgw2+HCxEGH?=
 =?us-ascii?Q?sipK1Nbh8C41Yb8wjhr0YLqA4kpgquZiEpviTmLGKcSYs+P79m3Pz4VuH6Cp?=
 =?us-ascii?Q?Z8eceV7xuNtWAnlx099NkiACzyGsq93l0CRBYWXTCOri1u7iwHmknpu7W7rd?=
 =?us-ascii?Q?xUEqA0udjZqMliHp//UFBLEXKcZH2GlvzGfhDwHFqyWdJIoq7ag310IWJhrn?=
 =?us-ascii?Q?fm7fOiMyttknXaVAU2Vs+Qlwzqcpuh69o5aF/ANx4tKZXJr/8hfRYOL7nxQf?=
 =?us-ascii?Q?sPSZz+UWKL/tHYIOFPeyu3Gh9QsvQuyR79ppAcL7+Xk3I29+SkM/oPR9VFy1?=
 =?us-ascii?Q?gZUPCAnqqLvUaUY0Nm0STAXPXVSzHoy/VcsKkcRkLYi90Zzz+x3JdpShM7cg?=
 =?us-ascii?Q?6gfRYpvuT/jF3dqFM7in773Ci/q+LyQ/pyllTgFajW6cjBuVlLSG4Qry1doo?=
 =?us-ascii?Q?PLTK77uy3efhFtkXX093NPHQ+Z1IAMYlQjHsF5sUnJ28Iw+2LheSM9u4YE6m?=
 =?us-ascii?Q?5E7Cwj+hRgaFpRonJl9VmakSRuHe28WjdQBgA6oy8s7gg/2VNyfDJlWvL7YA?=
 =?us-ascii?Q?hLCfSC8WsUG+umlmQRqoRn8aleNT/otXK3pNRWLEhyQISwX0jRne7eMHi12A?=
 =?us-ascii?Q?iccbQJDNXKjKDWxfPEASSQB1zjsj3e97YY6M46Hssq5Rjr4AL20Ezb214DZv?=
 =?us-ascii?Q?Bhb27Yu1oRyJwMOtV+PPAwGYeE/wsTlrNw4RQC6FK2FjvV1h/mwZl0hJ0SUE?=
 =?us-ascii?Q?JbCi1HPUn2QkTIcblxHakw+GCG71oUctor14zitDoNQ+4agPp4OlBG6Nfn93?=
 =?us-ascii?Q?sLkcVxiWEkSoaCtuQGTY9BEzyj1cKdFY1xBANofNfB490EN+o3a/UFDTbAmq?=
 =?us-ascii?Q?aBmO8KGw/lUuzUb2+hFZcSW84LDSflQpLkXogj+xlG+Ue7Txk64TFjPHU510?=
 =?us-ascii?Q?F3Yd44+V2P1/oNO3dTrRd/i9tilnNYxbAp4rYAz5bnmNiAeU5lsPMS2GInyi?=
 =?us-ascii?Q?/UGkm8xt/KpgidgArkzNPm/IgGTQ21VdB7C6Tfzb+HEJkdTxDi2HtyFeFAph?=
 =?us-ascii?Q?TiVEHL6j0C2mn9SwsWr7ujFeoFU0foy4sBUlqOuhlbcqI/BBkTWlbrjgWNP6?=
 =?us-ascii?Q?i42d/QJ8WU5O21hTK4u62tqjGrDwP04k1UlSCDvD7htuXK8zyUdrU+ayRMv7?=
 =?us-ascii?Q?Mk66BAhXCre9BR7Ke1O3iAov/nBkNZn2egfshCwqLoWdNSCHAiEBxnkhC2hb?=
 =?us-ascii?Q?tTAd+c9+suizTtEIXkn+GaGD6hFaXtRHq/BgpBnDQpRiAmYV0QwNxTokdxHQ?=
 =?us-ascii?Q?f0HTGCAmAQwV+53E4tGhlF+SwP22AM67Lk2KNUNhrgkDzD8gYvCpfmmmef/u?=
 =?us-ascii?Q?k1nwkG8r3qjct3J4b4KH2BKmuBbAofbviIY+dQnBn6tsrOQDy/B8ozNDnOgK?=
 =?us-ascii?Q?Oh1anSOwtT8tvGhkO37EblzgSys/cGbOInmLVN2PZtZnBUfKPu/ZAGDwfuBU?=
 =?us-ascii?Q?FYPInQzUSv0mCJrEY4fgmLwyaK4rBQDyO84Ud87wpqefdRp3Ez+6F+LyOlqE?=
 =?us-ascii?Q?Aa0RdfehTFE2TB4itjw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 14:39:18.9278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c49d0a26-d1d4-4469-a8cc-08de2c306a7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
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

This reverts commit 2681bf4ae8d24df950138b8c9ea9c271cd62e414.

This results in a blank screen on the HDMI port on some systems.
Revert for now so as not to regress 6.18, can be addressed
in 6.19 once the issue is root caused.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4652
Cc: Sunpeng.Li@amd.com
Cc: ivan.lipski@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  | 1 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    | 2 --
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  | 2 --
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c            | 3 +++
 .../drm/amd/display/dc/virtual/virtual_stream_encoder.c    | 7 -------
 5 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 94e66d96c403a..98c6dfb167966 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -685,7 +685,6 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 	uint32_t early_control = 0;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 
-	link_hwss->setup_stream_attribute(pipe_ctx);
 	link_hwss->setup_stream_encoder(pipe_ctx);
 
 	dc->hwss.update_info_frame(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 1460d3fc7115a..c8ff8ae85a030 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -3063,8 +3063,6 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 						      link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
 
-	link_hwss->setup_stream_attribute(pipe_ctx);
-
 	if (dc->res_pool->dccg->funcs->set_pixel_rate_div)
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index f02edc9371b0a..e75bf409a3d86 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -974,8 +974,6 @@ void dcn401_enable_stream(struct pipe_ctx *pipe_ctx)
 		}
 	}
 
-	link_hwss->setup_stream_attribute(pipe_ctx);
-
 	if (dc->res_pool->dccg->funcs->set_pixel_rate_div) {
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 475f71bb48ffe..6960eff5816dd 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2467,6 +2467,7 @@ void link_set_dpms_on(
 	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	enum otg_out_mux_dest otg_out_dest = OUT_MUX_DIO;
 	struct vpg *vpg = pipe_ctx->stream_res.stream_enc->vpg;
+	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	bool apply_edp_fast_boot_optimization =
 		pipe_ctx->stream->apply_edp_fast_boot_optimization;
 
@@ -2511,6 +2512,8 @@ void link_set_dpms_on(
 		pipe_ctx->stream_res.tg->funcs->set_out_mux(pipe_ctx->stream_res.tg, otg_out_dest);
 	}
 
+	link_hwss->setup_stream_attribute(pipe_ctx);
+
 	pipe_ctx->stream->apply_edp_fast_boot_optimization = false;
 
 	// Enable VPG before building infoframe
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
index 6ffc74fc9dcd8..ad088d70e1893 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
@@ -44,11 +44,6 @@ static void virtual_stream_encoder_dvi_set_stream_attribute(
 	struct dc_crtc_timing *crtc_timing,
 	bool is_dual_link) {}
 
-static void virtual_stream_encoder_lvds_set_stream_attribute(
-	struct stream_encoder *enc,
-	struct dc_crtc_timing *crtc_timing)
-{}
-
 static void virtual_stream_encoder_set_throttled_vcp_size(
 	struct stream_encoder *enc,
 	struct fixed31_32 avg_time_slots_per_mtp)
@@ -120,8 +115,6 @@ static const struct stream_encoder_funcs virtual_str_enc_funcs = {
 		virtual_stream_encoder_hdmi_set_stream_attribute,
 	.dvi_set_stream_attribute =
 		virtual_stream_encoder_dvi_set_stream_attribute,
-	.lvds_set_stream_attribute =
-		virtual_stream_encoder_lvds_set_stream_attribute,
 	.set_throttled_vcp_size =
 		virtual_stream_encoder_set_throttled_vcp_size,
 	.update_hdmi_info_packets =
-- 
2.51.1

