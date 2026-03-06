Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37BCF513EE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A97D10E30E;
	Fri,  6 Mar 2026 03:28:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A8wo1urg";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010047.outbound.protection.outlook.com
 [52.101.193.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A65210E30E
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:28:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OedkVxuBaQBvT03a+v2gU2Ty+JhzI+7FOAy7QAv3L3/PVVvpMpMyNokEo2VXjD+QDqyeKC5KSARUXpRVPvRCYT28WJhdB0KEuovSRCVBS9R8Ag9uuh6vafiAygEgCT134w+IMxu/ghFMqx4IdvkqIgGwWow8BRV6QoJ3LPb0dH/Wvd3+sIyLw20EQEZGiFBR2fTsvtYvBS9ALOlV4vwIDzU7tnd91iz0IfILMPU5FL7/ZIU7wOJZuerzcnS/4TmZkKbYWDuwIP1htwoZWbBoeTeyny9osBN9h+prfu5G28LFhsKhv/vrxeE6MMv5eV7Le9XLELaMd76DAZoKjhsj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eyNheySMpbb7aGEb56+BixxTG7GHHFtprkvog5/jIk=;
 b=BNng1O4qgZMOYZWwJ2WP9gUTodcf8/A1a4cgQypZlwWgxXYQNuvbO/MSqHUkZeFft69KencFdaMgNM/ecXQa3gB85QM6UJflJYbgGYV0+kvRPRw6WsKJfJbOIVm+r7XrW0NY99NzvmfJwRFIgqSlz6TVunKorGlT8xQyUS3pIYSlANXAXTMOC7hZtQRyz0QAa40mQbWJfaxEc72F+k2CgJSKBlVWRK4/FvXlzMt1DWqqawxdHbbpV8Hu4c4zlTmOrXLZNM/byMKO88LNZXv7nkGzwJ1tHcYSSHhZExVlNra/UthmTXYHcRWsMiJsOuqXJ51LTyPlf57m+UApVN9xpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eyNheySMpbb7aGEb56+BixxTG7GHHFtprkvog5/jIk=;
 b=A8wo1urgUDK+EyI1osf7LupzZtu8TkadWkwQXzh/kyQyRBUwbqHoaVNcrDvufkGq6STKP7svuaTUwIsMtthv4hwC0p8AYFFi8MagBsR8Wjbrqx3rUa9yVqAU+7aWV54Klp+Q0onWKTbZ35DyIlQ+xmuC+/PtLseGyfBrVxoBEDk=
Received: from BLAPR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:32b::19)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 03:28:04 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::44) by BLAPR03CA0014.outlook.office365.com
 (2603:10b6:208:32b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 03:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:28:04 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:27:59 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 19/21] drm/amd/display: Sync dcn42 with DC 3.2.373
Date: Thu, 5 Mar 2026 20:13:45 -0700
Message-ID: <20260306031932.136179-20-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e45409-a5ec-43a4-3317-08de7b3060db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: Fl3jMav8TS8Inky1RPjh8I5zTCWvt3qY3kji0BVRhG4YwkPznf9o32kBUwXIFRabwoy7Tct+3HOarI1eQtCistyzOQQY38Prp5wRPeAOBXyT/HgQrzQlQSvplp8UMVjuoN0dr3Vy9i+I7wgdlXnBt2ey7maw95m5JK6N/Cen6b7+aHkPhQv3uJfRr+jOWtOQgkz3bzl7InhSA3/Dz6cDyKzATE8dNPhvQ07McOhgZQr18FxUqbzsSiSmMQ+0mQK9NFWT9JDtKiYxVqn2N8d5R2UDN5710njSP6GdyLvEBh+EYDyupRaiKqefdqcpGLP565OWlEBB5JRNbTSIRWUui53GbQPLMxViyQidRIahnDkenve/Ph1itZ4JXFldnoNWxGpSeYADglMBRlD0l5pjUEL1w0VMJXEmJ90lYbLYbwI1vVAlArnS8QY4MYmQ9REJaMw+NtYcs2Tt4A5JWtZ7aYALdgN3CadOlR5J+x5CKI1K260+yXxZV1zRziGXSiBhR3BJwnAm74HjyWeVzzOXkzWsBiWnVTxXOuFgYf68oJWzmwjQPdi/A0Sp6rKjsft+GRcLfxJ8+i+6oGzv1Z0HufV3KrhOCIsonCvKndCdFsMp+tC+ypg3l5/TAgjzcxZeO6wDSSiPMMMYvHneVufTH/9V1C1eUEI91zZeqTpkfpzuGhkQjMEtoovgIBwDVSYbClTJASI9I/Zo9zwvYDq5olLEGtjBNj6sWgc+6JN4x9VqedkpDfMiH9BMg6iSQximgPqUvNE/7CwYbGXC7eELQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SiYcM6KUfioIn6+DfbYlTQvmguJQVr/lOUmn/6YuUy294uDMJjSrlD2mOPRlQkayOoq1oOy/RdrXH2dlthBAC/i0uSomsZH184QohdwUVeb1gypgBwnk3bTqklbWfW+IPSjWxiS89AdAqWzlTXZgJf2o1Ze7O90ejDg8J7kjoV3nwfBMr9V+Sj8oDyB00dN7azOWdzZ0APrXp4Q99wU/JLnYYXnFkWLq3hzwTBdJVUlFiRrHPlNBiw2N/g2EZtSjKq8gyOx47sALXjicAhSWXIHJbkty+0/RkgpIffI5+yExILRcsI+/eG1wE2ee+sFw3qq+dnGdoW837CHn0FWT17yi8ulnlOhrAB+f4F9EKIyYukDr+2iiJ+kcnoRFKiMHfXfX0SM72D4sPFBvHvEPNPfFmyY5fMcHwVir640tN0dwWhmisClbtys31ollaQd/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:28:04.6437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e45409-a5ec-43a4-3317-08de7b3060db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
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

From: Roman Li <Roman.Li@amd.com>

This patch provides a bulk merge to align driver
support for DCN42 with Display Core version 3.2.373.

It includes upgrade for:
- clk_mgr
- dml2/dml21
- optc
- hubp
- mpc
- optc
- hwseq

Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  11 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  | 141 +++--
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  95 ++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  41 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   9 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  59 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  24 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  20 +
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  16 +
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.h |  13 +
 .../dml2_0/dml21/dml21_translation_helper.c   |  30 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   1 +
 .../display/dc/dml2_0/dml21/dml21_wrapper.c   |  14 +-
 .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   | 308 ++++------
 .../dml21/inc/dml_top_display_cfg_types.h     |  13 +
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |   2 +
 .../dml21/src/dml2_core/dml2_core_dcn4.c      | 204 +++----
 .../dml21/src/dml2_core/dml2_core_factory.c   |   1 +
 .../dml21/src/dml2_core/dml2_core_utils.c     |  63 +-
 .../dml21/src/dml2_core/dml2_core_utils.h     |   2 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |   1 -
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |   1 +
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.h |   2 +-
 .../dml21/src/dml2_mcg/dml2_mcg_dcn42.h       |   5 +-
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |   1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   6 +
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   4 +-
 .../dml21/src/dml2_pmo/dml2_pmo_factory.h     |   2 +-
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |   1 +
 .../dml21/src/dml2_top/dml2_top_legacy.c      |   1 -
 .../src/inc/dml2_internal_shared_types.h      |   3 +
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.c  |   3 +-
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |   2 +
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  21 +
 .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.c   |   5 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 201 ++++---
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  23 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |  85 ++-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |  16 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 136 +++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 412 +++++--------
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   | 553 +++---------------
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |  10 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   8 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  36 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  18 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 112 ++--
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    | 177 +++---
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  25 +-
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c  | 390 ++----------
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h  |  50 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |   2 +-
 .../amd/display/dc/optc/dcn42/dcn42_optc.c    | 105 +++-
 .../amd/display/dc/optc/dcn42/dcn42_optc.h    |  13 +-
 .../dc/resource/dcn42/dcn42_resource.c        |  10 +-
 .../dcn401/dcn401_soc_and_ip_translator.c     |   3 +
 .../dcn42/dcn42_soc_and_ip_translator.c       |  12 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  38 +-
 .../include/asic_reg/dcn/dcn_4_2_0_offset.h   |   2 +
 .../include/asic_reg/dcn/dcn_4_2_0_sh_mask.h  |   9 +
 65 files changed, 1596 insertions(+), 1984 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index f56f3ee81a22..82877f7b3b6f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -794,13 +794,11 @@ static enum bp_result bios_parser_external_encoder_control(
 
 static enum bp_result bios_parser_dac_load_detection(
 	struct dc_bios *dcb,
-	enum engine_id engine_id,
-	struct graphics_object_id ext_enc_id)
+	enum engine_id engine_id)
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 	struct dc_context *ctx = dcb->ctx;
 	struct bp_load_detection_parameters bp_params = {0};
-	struct bp_external_encoder_control ext_cntl = {0};
 	enum bp_result bp_result = BP_RESULT_UNSUPPORTED;
 	uint32_t bios_0_scratch;
 	uint32_t device_id_mask = 0;
@@ -826,13 +824,6 @@ static enum bp_result bios_parser_dac_load_detection(
 
 		bp_params.engine_id = engine_id;
 		bp_result = bp->cmd_tbl.dac_load_detection(bp, &bp_params);
-	} else if (ext_enc_id.id) {
-		if (!bp->cmd_tbl.external_encoder_control)
-			return BP_RESULT_UNSUPPORTED;
-
-		ext_cntl.action = EXTERNAL_ENCODER_CONTROL_DAC_LOAD_DETECT;
-		ext_cntl.encoder_id = ext_enc_id;
-		bp_result = bp->cmd_tbl.external_encoder_control(bp, &ext_cntl);
 	}
 
 	if (bp_result != BP_RESULT_OK)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index cbb79789a532..927af599bf24 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -87,21 +87,18 @@ static const struct clk_mgr_mask clk_mgr_mask_dcn42 = {
 #define TO_CLK_MGR_DCN42(clk_mgr_int)\
 	container_of(clk_mgr_int, struct clk_mgr_dcn42, base)
 
-int dcn42_get_active_display_cnt_wa(
-		struct dc *dc,
-		struct dc_state *context,
-		int *all_active_disps)
+bool dcn42_has_active_display(struct dc *dc, const struct dc_state *context)
 {
-	int i, display_count = 0;
-	bool tmds_present = false;
+	int i, active_count = 0;
 
 	for (i = 0; i < context->stream_count; i++) {
 		const struct dc_stream_state *stream = context->streams[i];
 
-		if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
-				stream->signal == SIGNAL_TYPE_DVI_SINGLE_LINK ||
-				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK)
-			tmds_present = true;
+		/* Checking stream / link detection ensuring that PHY is active*/
+		if (dc_is_hdmi_signal(stream->signal) ||
+		    dc_is_dvi_signal(stream->signal) ||
+		    (dc_is_dp_signal(stream->signal) && !stream->dpms_off))
+		    active_count++;
 	}
 
 	for (i = 0; i < dc->link_count; i++) {
@@ -110,15 +107,10 @@ int dcn42_get_active_display_cnt_wa(
 		/* abusing the fact that the dig and phy are coupled to see if the phy is enabled */
 		if (link->link_enc && link->link_enc->funcs->is_dig_enabled &&
 				link->link_enc->funcs->is_dig_enabled(link->link_enc))
-			display_count++;
+			active_count++;
 	}
-	if (all_active_disps != NULL)
-		*all_active_disps = display_count;
-	/* WA for hang on HDMI after display off back on*/
-	if (display_count == 0 && tmds_present)
-		display_count = 1;
 
-	return display_count;
+	return active_count > 0;
 }
 
 static uint32_t dcn42_get_clock_freq_from_clkip(struct clk_mgr *clk_mgr_base, enum clock_type clock)
@@ -223,20 +215,18 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int display_count = 0;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
-	int all_active_disps = 0;
+	bool has_active_display;
 
 	if (dc->work_arounds.skip_clock_update)
 		return;
 
-	display_count = dcn42_get_active_display_cnt_wa(dc, context, &all_active_disps);
+	has_active_display = dcn42_has_active_display(dc, context);
 
 	if (new_clocks->dtbclk_en && new_clocks->ref_dtbclk_khz < 590000)
 		new_clocks->ref_dtbclk_khz = 600000;
-
 	/*
 	 * if it is safe to lower, but we are already in the lower state, we don't have to do anything
 	 * also if safe to lower is false, we just go in the higher state
@@ -256,7 +246,7 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 		/* check that we're not already in lower */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
 			/* if we can go lower, go lower */
-			if (display_count == 0)
+			if (has_active_display == false)
 				clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
 		}
 	} else {
@@ -314,7 +304,7 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
-	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
+	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && has_active_display == false))) {
 		int requested_dispclk_khz = new_clocks->dispclk_khz;
 
 		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
@@ -461,7 +451,6 @@ static void dcn42_dump_clk_registers(struct clk_state_registers_and_bypass *regs
 
 		// REGISTER VALUES
 		DC_LOG_SMU("reg_name,value,clk_type\n");
-
 		DC_LOG_SMU("CLK1_CLK3_CURRENT_CNT,%d,dcfclk\n",
 				internal.CLK8_CLK3_CURRENT_CNT);
 
@@ -594,6 +583,7 @@ void dcn42_init_clocks(struct clk_mgr *clk_mgr_base)
 	else
 		clk_mgr_base->dp_dto_source_clock_in_khz = clk_mgr_base->dprefclk_khz;
 
+	DC_LOG_SMU("dp_dto_source_clock %d, dprefclk %d\n", clk_mgr_base->dp_dto_source_clock_in_khz, clk_mgr_base->dprefclk_khz);
 	dcn42_dump_clk_registers(&clk_mgr_base->boot_snapshot, clk_mgr);
 
 	clk_mgr_base->clks.ref_dtbclk_khz =  clk_mgr_base->boot_snapshot.dtbclk * 10;
@@ -602,6 +592,12 @@ void dcn42_init_clocks(struct clk_mgr *clk_mgr_base)
 		clk_mgr_base->clks.dtbclk_en = true;
 	}
 
+	if (clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dcfclk_levels != 0) {
+		/*skip to get clock table and notify pmfw watermark range again*/
+		DC_LOG_SMU("skip to get dpm_clks from pmfw from resume and acr\n");
+		return;
+	}
+
 	smu_dpm_clks.dpm_clks = (DpmClocks_t_dcn42 *)dm_helpers_allocate_gpu_mem(
 				clk_mgr_base->ctx,
 				DC_MEM_ALLOC_TYPE_GART,
@@ -708,10 +704,9 @@ void dcn42_init_clocks(struct clk_mgr *clk_mgr_base)
 			/* DTBCLK*/
 			clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz = clk_mgr_base->clks.ref_dtbclk_khz / 1000;
 			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels = 1;
-
 			/* Refresh bounding box */
 			clk_mgr_base->ctx->dc->res_pool->funcs->update_bw_bounding_box(
-					clk_mgr_base->ctx->dc, clk_mgr_base->bw_params);
+				clk_mgr_base->ctx->dc, clk_mgr_base->bw_params);
 		}
 	}
 	if (smu_dpm_clks.dpm_clks && smu_dpm_clks.mc_address.quad_part != 0)
@@ -823,7 +818,6 @@ static void dcn42_read_ss_info_from_lut(struct clk_mgr_internal *clk_mgr)
 	}
 }
 
-/* Exposed for dcn42b reuse */
 void dcn42_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn42_watermarks *table)
 {
 	int i, num_valid_sets;
@@ -882,18 +876,42 @@ void dcn42_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn42_
 
 void dcn42_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 {
+	int i = 0;
+	struct dcn42_watermarks *table = NULL;
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct clk_mgr_dcn42 *clk_mgr_dcn42 = TO_CLK_MGR_DCN42(clk_mgr);
-	struct dcn42_watermarks *table = clk_mgr_dcn42->smu_wm_set.wm_set;
 
 	if (!clk_mgr->smu_ver)
 		return;
+	/*send once already skip*/
+	if (clk_mgr_base->bw_params->wm_table.entries[WM_A].valid == true)
+		return;
+	clk_mgr_dcn42->smu_wm_set.wm_set = (struct dcn42_watermarks *)dm_helpers_allocate_gpu_mem(
+				clk_mgr->base.ctx,
+				DC_MEM_ALLOC_TYPE_GART,
+				sizeof(struct dcn42_watermarks),
+				&clk_mgr_dcn42->smu_wm_set.mc_address.quad_part);
+
+	ASSERT(clk_mgr_dcn42->smu_wm_set.wm_set);
+
+	table = clk_mgr_dcn42->smu_wm_set.wm_set;
 
 	if (!table || clk_mgr_dcn42->smu_wm_set.mc_address.quad_part == 0)
 		return;
 
 	memset(table, 0, sizeof(*table));
+	/*same as previous asic, set wm valid before building watermark ranges*/
+	for (i = 0; i < WM_SET_COUNT; i++) {
+		clk_mgr_base->bw_params->wm_table.entries[i].wm_inst = i;
 
+		if (i >= clk_mgr_base->bw_params->clk_table.num_entries) {
+			clk_mgr_base->bw_params->wm_table.entries[i].valid = false;
+			continue;
+		}
+		clk_mgr_base->bw_params->wm_table.entries[i].wm_type = WM_TYPE_PSTATE_CHG;
+		clk_mgr_base->bw_params->wm_table.entries[i].valid = true;
+	}
+	/* build watermark_range will check this valid range*/
 	dcn42_build_watermark_ranges(clk_mgr_base->bw_params, table);
 
 	dcn42_smu_set_dram_addr_high(clk_mgr,
@@ -901,18 +919,21 @@ void dcn42_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 	dcn42_smu_set_dram_addr_low(clk_mgr,
 			clk_mgr_dcn42->smu_wm_set.mc_address.low_part);
 	dcn42_smu_transfer_wm_table_dram_2_smu(clk_mgr);
+
+	if (clk_mgr_dcn42->smu_wm_set.wm_set && clk_mgr_dcn42->smu_wm_set.mc_address.quad_part != 0)
+		dm_helpers_free_gpu_mem(clk_mgr->base.ctx, DC_MEM_ALLOC_TYPE_GART,
+				clk_mgr_dcn42->smu_wm_set.wm_set);
+
 }
 
 void dcn42_set_low_power_state(struct clk_mgr *clk_mgr_base)
 {
-	int display_count;
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	struct dc_state *context = dc->current_state;
 
 	if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
-		display_count = dcn42_get_active_display_cnt_wa(dc, context, NULL);
 		/* if we can go lower, go lower */
-		if (display_count == 0)
+		if (dcn42_has_active_display(dc, context) == false)
 			clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
 	}
 
@@ -1093,14 +1114,7 @@ void dcn42_clk_mgr_construct(
 	clk_mgr->base.dprefclk_ss_divider = 1000;
 	clk_mgr->base.ss_on_dprefclk = false;
 	clk_mgr->base.dfs_ref_freq_khz = 48000; /*sync with pmfw*/
-
-	clk_mgr->smu_wm_set.wm_set = (struct dcn42_watermarks *)dm_helpers_allocate_gpu_mem(
-				clk_mgr->base.base.ctx,
-				DC_MEM_ALLOC_TYPE_GART,
-				sizeof(struct dcn42_watermarks),
-				&clk_mgr->smu_wm_set.mc_address.quad_part);
-
-	ASSERT(clk_mgr->smu_wm_set.wm_set);
+	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
 
 	/* Changed from DCN3.2_clock_frequency doc to match
 	 * dcn32_dump_clk_registers from 4 * dentist_vco_freq_khz /
@@ -1108,34 +1122,31 @@ void dcn42_clk_mgr_construct(
 	 */
 	clk_mgr->base.base.dprefclk_khz = 600000;
 
-	clk_mgr->base.smu_present = false;
-	clk_mgr->base.smu_ver = dcn42_smu_get_pmfw_version(&clk_mgr->base);
-	if (clk_mgr->base.smu_ver && clk_mgr->base.smu_ver != -1)
-		clk_mgr->base.smu_present = true;
-
-	if (ctx->dc_bios->integrated_info) {
-		clk_mgr->base.base.dentist_vco_freq_khz = ctx->dc_bios->integrated_info->dentist_vco_freq;
-
-		if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
-			dcn42_bw_params.wm_table = lpddr5_wm_table;
-		else
-			dcn42_bw_params.wm_table = ddr5_wm_table;
-
-		dcn42_bw_params.vram_type = ctx->dc_bios->integrated_info->memory_type;
-		dcn42_bw_params.dram_channel_width_bytes = ctx->dc_bios->integrated_info->memory_type == 0x22 ? 8 : 4;
-		dcn42_bw_params.num_channels = ctx->dc_bios->integrated_info->ma_channel_number ? ctx->dc_bios->integrated_info->ma_channel_number : 4;
-	}
-
-	/* in case we don't get a value from the BIOS, use default */
-	if (clk_mgr->base.base.dentist_vco_freq_khz == 0)
-		clk_mgr->base.base.dentist_vco_freq_khz = 3000000; /* 3000MHz */
+		clk_mgr->base.smu_present = false;
+		clk_mgr->base.smu_ver = dcn42_smu_get_pmfw_version(&clk_mgr->base);
+		if (clk_mgr->base.smu_ver && clk_mgr->base.smu_ver != -1)
+			clk_mgr->base.smu_present = true;
+
+		if (ctx->dc_bios->integrated_info) {
+			clk_mgr->base.base.dentist_vco_freq_khz = ctx->dc_bios->integrated_info->dentist_vco_freq;
+
+			if (ctx->dc_bios->integrated_info->memory_type == LpDdr5MemType)
+				dcn42_bw_params.wm_table = lpddr5_wm_table;
+			else
+				dcn42_bw_params.wm_table = ddr5_wm_table;
+			dcn42_bw_params.vram_type = ctx->dc_bios->integrated_info->memory_type;
+			dcn42_bw_params.dram_channel_width_bytes = ctx->dc_bios->integrated_info->memory_type == 0x22 ? 8 : 4;
+			dcn42_bw_params.num_channels = ctx->dc_bios->integrated_info->ma_channel_number ? ctx->dc_bios->integrated_info->ma_channel_number : 1;
+			clk_mgr->base.base.dprefclk_khz = dcn42_smu_get_dprefclk(&clk_mgr->base);
+			clk_mgr->base.base.clks.ref_dtbclk_khz = dcn42_smu_get_dtbclk(&clk_mgr->base);
+		}
+		/* in case we don't get a value from the BIOS, use default */
+		if (clk_mgr->base.base.dentist_vco_freq_khz == 0)
+			clk_mgr->base.base.dentist_vco_freq_khz = 3000000; /* 3000MHz */
 
-	/* Saved clocks configured at boot for debug purposes */
-	dcn42_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
+		/* Saved clocks configured at boot for debug purposes */
+		dcn42_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
 
-	if (clk_mgr->base.smu_present)
-		clk_mgr->base.base.dprefclk_khz = dcn42_smu_get_dprefclk(&clk_mgr->base);
-	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
 	dce_clock_read_ss_info(&clk_mgr->base);
 	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
index 99fcdb602c62..5ad027a9edaf 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
@@ -59,7 +59,6 @@ void dcn42_clk_mgr_construct(struct dc_context *ctx,
 
 void dcn42_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int);
 
-/* Exposed for dcn42b reuse */
 void dcn42_init_single_clock(unsigned int *entry_0,
 			      uint32_t *smu_entry_0,
 			      uint8_t num_levels);
@@ -76,4 +75,5 @@ int dcn42_get_active_display_cnt_wa(struct dc *dc, struct dc_state *context, int
 void dcn42_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr, struct dc_state *context, bool safe_to_lower);
 void dcn42_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr, struct dc_state *context, int ref_dtbclk_khz);
 bool dcn42_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base);
+bool dcn42_has_active_display(struct dc *dc, const struct dc_state *context);
 #endif //__DCN42_CLK_MGR_H__
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2e89b05fcc32..aeafd2388c01 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2896,16 +2896,27 @@ static struct surface_update_descriptor det_surface_update(
 		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 	}
 
-	if (u->blend_tf || (u->gamma && dce_use_lut(u->plane_info ? u->plane_info->format : u->surface->format))) {
+	if (u->cm || (u->gamma && dce_use_lut(u->plane_info ? u->plane_info->format : u->surface->format))) {
 		update_flags->bits.gamma_change = 1;
 		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 	}
 
-	if (u->lut3d_func || u->func_shaper) {
+	if (u->cm && (u->cm->flags.bits.lut3d_enable || u->surface->cm.flags.bits.lut3d_enable)) {
 		update_flags->bits.lut_3d = 1;
 		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 	}
 
+	if (u->cm && u->cm->flags.bits.lut3d_dma_enable != u->surface->cm.flags.bits.lut3d_dma_enable &&
+			u->cm->flags.bits.lut3d_enable && u->surface->cm.flags.bits.lut3d_enable) {
+		/* Toggling 3DLUT loading between DMA and Host is illegal */
+		BREAK_TO_DEBUGGER();
+	}
+
+	if (u->cm && u->cm->flags.bits.lut3d_enable && !u->cm->flags.bits.lut3d_dma_enable) {
+		/* Host loading 3DLUT requires full update but only stream lock  */
+		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STREAM);
+	}
+
 	if (u->hdr_mult.value)
 		if (u->hdr_mult.value != u->surface->hdr_mult.value) {
 			// TODO: Should be fast?
@@ -2920,24 +2931,15 @@ static struct surface_update_descriptor det_surface_update(
 			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 		}
 
-	if (u->cm2_params) {
-		if (u->cm2_params->component_settings.shaper_3dlut_setting != u->surface->mcm_shaper_3dlut_setting
-				|| u->cm2_params->component_settings.lut1d_enable != u->surface->mcm_lut1d_enable
-				|| u->cm2_params->cm2_luts.lut3d_data.lut3d_src != u->surface->mcm_luts.lut3d_data.lut3d_src) {
-			update_flags->bits.mcm_transfer_function_enable_change = 1;
-			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
-		}
-	}
-
-	if (update_flags->bits.lut_3d &&
-			u->surface->mcm_luts.lut3d_data.lut3d_src != DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM) {
-		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
+	if (u->cm_hist_control) {
+		update_flags->bits.cm_hist_change = 1;
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 	}
-
 	if (check_config->enable_legacy_fast_update &&
 			(update_flags->bits.gamma_change ||
 			update_flags->bits.gamut_remap_change ||
 			update_flags->bits.input_csc_change ||
+			update_flags->bits.cm_hist_change ||
 			update_flags->bits.coeff_reduction_change)) {
 		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 	}
@@ -3169,6 +3171,11 @@ static void copy_surface_update_to_plane(
 		surface->gamma_correction.type =
 			srf_update->gamma->type;
 	}
+	if (srf_update->cm_hist_control) {
+		memcpy(&surface->cm_hist_control,
+			srf_update->cm_hist_control,
+			sizeof(surface->cm_hist_control));
+	}
 
 	if (srf_update->in_transfer_func) {
 		surface->in_transfer_func.sdr_ref_white_level =
@@ -3182,24 +3189,12 @@ static void copy_surface_update_to_plane(
 			sizeof(struct dc_transfer_func_distributed_points));
 	}
 
-	if (srf_update->cm2_params) {
-		surface->mcm_shaper_3dlut_setting = srf_update->cm2_params->component_settings.shaper_3dlut_setting;
-		surface->mcm_lut1d_enable = srf_update->cm2_params->component_settings.lut1d_enable;
-		surface->mcm_luts = srf_update->cm2_params->cm2_luts;
-	}
-
-	if (srf_update->func_shaper) {
-		memcpy(&surface->in_shaper_func, srf_update->func_shaper,
-		sizeof(surface->in_shaper_func));
-
-		if (surface->mcm_shaper_3dlut_setting >= DC_CM2_SHAPER_3DLUT_SETTING_ENABLE_SHAPER)
-			surface->mcm_luts.shaper = &surface->in_shaper_func;
+	/* Shaper, 3DLUT, 1DLUT */
+	if (srf_update->cm) {
+		memcpy(&surface->cm, srf_update->cm,
+				sizeof(surface->cm));
 	}
 
-	if (srf_update->lut3d_func)
-		memcpy(&surface->lut3d_func, srf_update->lut3d_func,
-		sizeof(surface->lut3d_func));
-
 	if (srf_update->hdr_mult.value)
 		surface->hdr_mult =
 				srf_update->hdr_mult;
@@ -3208,17 +3203,6 @@ static void copy_surface_update_to_plane(
 		surface->sdr_white_level_nits =
 				srf_update->sdr_white_level_nits;
 
-	if (srf_update->blend_tf) {
-		memcpy(&surface->blend_tf, srf_update->blend_tf,
-		sizeof(surface->blend_tf));
-
-		if (surface->mcm_lut1d_enable)
-			surface->mcm_luts.lut1d_func = &surface->blend_tf;
-	}
-
-	if (srf_update->cm2_params || srf_update->blend_tf)
-		surface->lut_bank_a = !surface->lut_bank_a;
-
 	if (srf_update->input_csc_color_matrix)
 		surface->input_csc_color_matrix =
 			*srf_update->input_csc_color_matrix;
@@ -4502,11 +4486,9 @@ static void commit_planes_for_stream(struct dc *dc,
 				if (!should_update_pipe_for_plane(context, pipe_ctx, plane_state))
 					continue;
 
-				if (srf_updates[i].cm2_params &&
-						srf_updates[i].cm2_params->cm2_luts.lut3d_data.lut3d_src ==
-								DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM &&
-						srf_updates[i].cm2_params->component_settings.shaper_3dlut_setting ==
-								DC_CM2_SHAPER_3DLUT_SETTING_ENABLE_SHAPER_3DLUT &&
+				if (srf_updates[i].cm &&
+						srf_updates[i].cm->flags.bits.lut3d_enable &&
+						srf_updates[i].cm->flags.bits.lut3d_dma_enable &&
 						dc->hwss.trigger_3dlut_dma_load)
 					dc->hwss.trigger_3dlut_dma_load(dc, pipe_ctx);
 
@@ -5074,6 +5056,7 @@ void populate_fast_updates(struct dc_fast_update *fast_update,
 		fast_update[i].input_csc_color_matrix = srf_updates[i].input_csc_color_matrix;
 		fast_update[i].coeff_reduction_factor = srf_updates[i].coeff_reduction_factor;
 		fast_update[i].cursor_csc_color_matrix = srf_updates[i].cursor_csc_color_matrix;
+		fast_update[i].cm_hist_control = srf_updates[i].cm_hist_control;
 	}
 }
 
@@ -5091,6 +5074,7 @@ static bool fast_updates_exist(const struct dc_fast_update *fast_update, int sur
 				fast_update[i].gamut_remap_matrix ||
 				fast_update[i].input_csc_color_matrix ||
 				fast_update[i].cursor_csc_color_matrix ||
+				fast_update[i].cm_hist_control ||
 				fast_update[i].coeff_reduction_factor)
 			return true;
 	}
@@ -5111,6 +5095,7 @@ bool fast_nonaddr_updates_exist(struct dc_fast_update *fast_update, int surface_
 				fast_update[i].gamma ||
 				fast_update[i].gamut_remap_matrix ||
 				fast_update[i].coeff_reduction_factor ||
+				fast_update[i].cm_hist_control ||
 				fast_update[i].cursor_csc_color_matrix)
 			return true;
 	}
@@ -5152,6 +5137,12 @@ static bool full_update_required(
 		const struct dc_stream_update *stream_update,
 		const struct dc_stream_state *stream)
 {
+	const union dc_plane_cm_flags blend_only_flags = {
+		.bits = {
+			.blend_enable = 1,
+		}
+	};
+
 	if (full_update_required_weak(dc, srf_updates, surface_count, stream_update, stream))
 		return true;
 
@@ -5164,14 +5155,12 @@ static bool full_update_required(
 				(srf_updates[i].sdr_white_level_nits &&
 				srf_updates[i].sdr_white_level_nits != srf_updates->surface->sdr_white_level_nits) ||
 				srf_updates[i].in_transfer_func ||
-				srf_updates[i].func_shaper ||
-				srf_updates[i].lut3d_func ||
 				srf_updates[i].surface->force_full_update ||
 				(srf_updates[i].flip_addr &&
 				srf_updates[i].flip_addr->address.tmz_surface != srf_updates[i].surface->address.tmz_surface) ||
-				(srf_updates[i].cm2_params &&
-				 (srf_updates[i].cm2_params->component_settings.shaper_3dlut_setting != srf_updates[i].surface->mcm_shaper_3dlut_setting ||
-				  srf_updates[i].cm2_params->component_settings.lut1d_enable != srf_updates[i].surface->mcm_lut1d_enable))))
+				(srf_updates[i].cm &&
+				((srf_updates[i].cm->flags.all != blend_only_flags.all && srf_updates[i].cm->flags.all != 0) ||
+				(srf_updates[i].surface->cm.flags.all != blend_only_flags.all && srf_updates[i].surface->cm.flags.all != 0)))))
 			return true;
 	}
 
@@ -6899,7 +6888,7 @@ bool dc_capture_register_software_state(struct dc *dc, struct dc_register_softwa
 			struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 
 			/* MPCC blending tree and mode control - capture actual blend configuration */
-			state->mpc.mpcc_mode[i] = (plane_state->blend_tf.type != TF_TYPE_BYPASS) ? 1 : 0;
+			state->mpc.mpcc_mode[i] = (plane_state->cm.blend_func.type != TF_TYPE_BYPASS) ? 1 : 0;
 			state->mpc.mpcc_alpha_blend_mode[i] = plane_state->per_pixel_alpha ? 1 : 0;
 			state->mpc.mpcc_alpha_multiplied_mode[i] = plane_state->pre_multiplied_alpha ? 1 : 0;
 			state->mpc.mpcc_blnd_active_overlap_only[i] = 0; /* Default - no overlap restriction */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 87c0cf7e290e..44e17329c637 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -33,6 +33,7 @@
 #include "dc_dmub_srv.h"
 #include "dc_state_priv.h"
 #include "dc_stream_priv.h"
+#include "dce/dmub_hw_lock_mgr.h"
 
 #define DC_LOGGER dc->ctx->logger
 #ifndef MIN
@@ -171,10 +172,12 @@ struct dc_stream_state *dc_create_stream_for_sink(
 		goto fail;
 
 	stream = kzalloc(sizeof(struct dc_stream_state), GFP_ATOMIC);
+
 	if (stream == NULL)
 		goto fail;
 
 	stream->update_scratch = kzalloc((int32_t) dc_update_scratch_space_size(), GFP_ATOMIC);
+
 	if (stream->update_scratch == NULL)
 		goto fail;
 
@@ -245,7 +248,6 @@ const struct dc_stream_status *dc_stream_get_status_const(
 	const struct dc_stream_state *stream)
 {
 	struct dc *dc = stream->ctx->dc;
-
 	return dc_state_get_stream_status(dc->current_state, stream);
 }
 
@@ -257,6 +259,7 @@ void program_cursor_attributes(
 	struct resource_context *res_ctx;
 	struct pipe_ctx *pipe_to_program = NULL;
 	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
+	bool unlock_dmub = false;
 
 	if (!stream)
 		return;
@@ -275,6 +278,12 @@ void program_cursor_attributes(
 			if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update) {
 				dc->hwss.begin_cursor_offload_update(dc, pipe_ctx);
 			} else {
+				if (dc->hwss.dmub_hw_control_lock && pipe_ctx->stream &&
+				    should_use_dmub_inbox0_lock_for_link(dc, pipe_ctx->stream->link)) {
+					dc->hwss.dmub_hw_control_lock(dc, dc->current_state, true);
+					unlock_dmub = true;
+				}
+
 				dc->hwss.cursor_lock(dc, pipe_to_program, true);
 				if (pipe_to_program->next_odm_pipe)
 					dc->hwss.cursor_lock(dc, pipe_to_program->next_odm_pipe, true);
@@ -297,6 +306,9 @@ void program_cursor_attributes(
 			dc->hwss.cursor_lock(dc, pipe_to_program, false);
 			if (pipe_to_program->next_odm_pipe)
 				dc->hwss.cursor_lock(dc, pipe_to_program->next_odm_pipe, false);
+
+			if (unlock_dmub)
+				dc->hwss.dmub_hw_control_lock(dc, dc->current_state, false);
 		}
 	}
 }
@@ -404,6 +416,7 @@ void program_cursor_position(
 	struct resource_context *res_ctx;
 	struct pipe_ctx *pipe_to_program = NULL;
 	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
+	bool unlock_dmub = false;
 
 	if (!stream)
 		return;
@@ -423,10 +436,16 @@ void program_cursor_position(
 		if (!pipe_to_program) {
 			pipe_to_program = pipe_ctx;
 
-			if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update)
+			if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update) {
 				dc->hwss.begin_cursor_offload_update(dc, pipe_ctx);
-			else
+			} else {
+				if (dc->hwss.dmub_hw_control_lock && pipe_ctx->stream &&
+				    should_use_dmub_inbox0_lock_for_link(dc, pipe_ctx->stream->link)) {
+					dc->hwss.dmub_hw_control_lock(dc, dc->current_state, true);
+					unlock_dmub = true;
+				}
 				dc->hwss.cursor_lock(dc, pipe_to_program, true);
+			}
 		}
 
 		dc->hwss.set_cursor_position(pipe_ctx);
@@ -438,10 +457,14 @@ void program_cursor_position(
 	}
 
 	if (pipe_to_program) {
-		if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update)
+		if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update) {
 			dc->hwss.commit_cursor_offload_update(dc, pipe_to_program);
-		else
+		} else {
 			dc->hwss.cursor_lock(dc, pipe_to_program, false);
+
+			if (unlock_dmub)
+				dc->hwss.dmub_hw_control_lock(dc, dc->current_state, false);
+		}
 	}
 }
 
@@ -523,8 +546,10 @@ bool dc_stream_program_cursor_position(
 				struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
 
 				/* trigger event on first pipe with current stream */
-				if (stream == pipe_ctx->stream) {
-					pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
+				if (stream == pipe_ctx->stream &&
+				pipe_ctx->stream_res.tg->funcs->program_manual_trigger) {
+					pipe_ctx->stream_res.tg->funcs->program_manual_trigger(
+					pipe_ctx->stream_res.tg);
 					break;
 				}
 			}
@@ -984,7 +1009,6 @@ void dc_stream_release_3dlut_for_stream(
 	if (rmcm_3dlut) {
 		rmcm_3dlut->isInUse = false;
 		rmcm_3dlut->stream  = NULL;
-		rmcm_3dlut->protection_bits = 0;
 	}
 }
 
@@ -996,7 +1020,6 @@ void dc_stream_init_rmcm_3dlut(struct dc *dc)
 	for (int i = 0; i < num_rmcm; i++) {
 		dc->res_pool->rmcm_3dlut[i].isInUse = false;
 		dc->res_pool->rmcm_3dlut[i].stream = NULL;
-		dc->res_pool->rmcm_3dlut[i].protection_bits = 0;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index 0971dfa25845..5d3a8a63b7cd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -139,6 +139,9 @@ const struct dc_plane_status *dc_plane_get_status(
 
 		if (pipe_ctx->plane_state && flags.bits.address)
 			pipe_ctx->plane_state->status.is_flip_pending = false;
+		if (pipe_ctx->plane_state && flags.bits.histogram)
+			memset(&pipe_ctx->plane_state->status.cm_hist, 0,
+				sizeof(pipe_ctx->plane_state->status.cm_hist));
 
 		break;
 	}
@@ -154,6 +157,12 @@ const struct dc_plane_status *dc_plane_get_status(
 
 		if (flags.bits.address)
 			dc->hwss.update_pending_status(pipe_ctx);
+		if (flags.bits.histogram) {
+			struct dpp *dpp = pipe_ctx->plane_res.dpp;
+
+			if (dpp && dpp->funcs->dpp_cm_hist_read)
+				dpp->funcs->dpp_cm_hist_read(dpp, &pipe_ctx->plane_state->status.cm_hist);
+		}
 	}
 
 	return plane_status;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4bdb7bb47c75..8c49f8083475 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1404,15 +1404,50 @@ struct lut_mem_mapping {
 struct dc_rmcm_3dlut {
 	bool isInUse;
 	const struct dc_stream_state *stream;
-	uint8_t protection_bits;
 };
 
 struct dc_3dlut {
 	struct kref refcount;
 	struct tetrahedral_params lut_3d;
-	struct fixed31_32 hdr_multiplier;
 	union dc_3dlut_state state;
 };
+
+/* 3DLUT DMA (Fast Load) params */
+struct dc_3dlut_dma {
+	struct dc_plane_address addr;
+	enum dc_cm_lut_swizzle swizzle;
+	enum dc_cm_lut_pixel_format format;
+	uint16_t bias; /* FP1.5.10 */
+	uint16_t scale; /* FP1.5.10 */
+	enum dc_cm_lut_size size;
+};
+
+/* color manager */
+union dc_plane_cm_flags {
+	unsigned int all;
+	struct {
+		unsigned int shaper_enable    : 1;
+		unsigned int lut3d_enable     : 1;
+		unsigned int blend_enable     : 1;
+		/* whether legacy (lut3d_func) or DMA is valid */
+		unsigned int lut3d_dma_enable : 1;
+		/* RMCM lut to be used instead of MCM */
+		unsigned int rmcm_enable	 : 1;
+		unsigned int reserved: 27;
+	} bits;
+};
+
+struct dc_plane_cm {
+	struct kref refcount;
+	struct dc_transfer_func shaper_func;
+	union {
+		struct dc_3dlut lut3d_func;
+		struct dc_3dlut_dma lut3d_dma;
+	};
+	struct dc_transfer_func blend_func;
+	union dc_plane_cm_flags flags;
+};
+
 /*
  * This structure is filled in by dc_surface_get_status and contains
  * the last requested address and the currently active address so the called
@@ -1490,14 +1525,18 @@ struct dc_plane_state {
 	struct fixed31_32 hdr_mult;
 	struct colorspace_transform gamut_remap_matrix;
 
-	// TODO: No longer used, remove
-	struct dc_hdr_static_metadata hdr_static_ctx;
-
 	enum dc_color_space color_space;
 
+	bool lut_bank_a;
+	struct dc_hdr_static_metadata hdr_static_ctx;
 	struct dc_3dlut lut3d_func;
 	struct dc_transfer_func in_shaper_func;
 	struct dc_transfer_func blend_tf;
+	enum dc_cm2_shaper_3dlut_setting mcm_shaper_3dlut_setting;
+	bool mcm_lut1d_enable;
+	struct dc_cm2_func_luts mcm_luts;
+	enum mpcc_movable_cm_location mcm_location;
+	struct dc_plane_cm cm;
 
 	struct dc_transfer_func *gamcor_tf;
 	enum surface_pixel_format format;
@@ -1534,11 +1573,6 @@ struct dc_plane_state {
 
 	bool is_statically_allocated;
 	enum chroma_cositing cositing;
-	enum dc_cm2_shaper_3dlut_setting mcm_shaper_3dlut_setting;
-	bool mcm_lut1d_enable;
-	struct dc_cm2_func_luts mcm_luts;
-	bool lut_bank_a;
-	enum mpcc_movable_cm_location mcm_location;
 	struct dc_csc_transform cursor_csc_color_matrix;
 	bool adaptive_sharpness_en;
 	int adaptive_sharpness_policy;
@@ -1884,6 +1918,7 @@ struct dc_surface_update {
 	 * change cm2_params.cm2_luts: Fast update
 	 */
 	const struct dc_cm2_parameters *cm2_params;
+	const struct dc_plane_cm *cm;
 	const struct dc_csc_transform *cursor_csc_color_matrix;
 	unsigned int sdr_white_level_nits;
 	struct dc_bias_and_scale bias_and_scale;
@@ -1928,6 +1963,10 @@ struct dc_3dlut *dc_create_3dlut_func(void);
 void dc_3dlut_func_release(struct dc_3dlut *lut);
 void dc_3dlut_func_retain(struct dc_3dlut *lut);
 
+struct dc_plane_cm *dc_plane_cm_create(void);
+void dc_plane_cm_release(struct dc_plane_cm *cm);
+void dc_plane_cm_retain(struct dc_plane_cm *cm);
+
 void dc_post_update_surfaces_to_stream(
 		struct dc *dc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 526f71616f94..6f96c5cf39fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -102,8 +102,7 @@ struct dc_vbios_funcs {
 		struct bp_external_encoder_control *cntl);
 	enum bp_result (*dac_load_detection)(
 		struct dc_bios *bios,
-		enum engine_id engine_id,
-		struct graphics_object_id ext_enc_id);
+		enum engine_id engine_id);
 	enum bp_result (*transmitter_control)(
 		struct dc_bios *bios,
 		struct bp_transmitter_control *cntl);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 9bf853edc46f..c79ad70928e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -276,7 +276,7 @@ enum otg_pwa_sync_mode {
 	DC_OTG_PWA_FRAME_SYNC_MODE_VSTARTUP = 0x1,
 };
 struct otc_pwa_frame_sync {
-	enum otg_pwa_sync_mode pwa_sync_mode;
+    enum otg_pwa_sync_mode pwa_sync_mode;
 	uint32_t pwa_frame_sync_line_offset;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_plane.h b/drivers/gpu/drm/amd/display/dc/dc_plane.h
index 14feb843e694..2ad6d9318566 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_plane.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_plane.h
@@ -31,6 +31,7 @@
 union dc_plane_status_update_flags {
 	struct {
 		uint32_t address : 1;
+		uint32_t histogram : 1;
 	} bits;
 	uint32_t raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index d0ae5c27a511..e224077c8902 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1483,4 +1483,28 @@ struct dc_validation_dpia_set {
 	uint32_t required_bw;
 };
 
+enum dc_cm_lut_swizzle {
+	CM_LUT_3D_SWIZZLE_LINEAR_RGB,
+	CM_LUT_3D_SWIZZLE_LINEAR_BGR,
+	CM_LUT_1D_PACKED_LINEAR
+};
+
+enum dc_cm_lut_pixel_format {
+	CM_LUT_PIXEL_FORMAT_RGBA16161616_UNORM_12MSB,
+	CM_LUT_PIXEL_FORMAT_BGRA16161616_UNORM_12MSB,
+	CM_LUT_PIXEL_FORMAT_RGBA16161616_UNORM_12LSB,
+	CM_LUT_PIXEL_FORMAT_BGRA16161616_UNORM_12LSB,
+	CM_LUT_PIXEL_FORMAT_RGBA16161616_FLOAT_FP1_5_10,
+	CM_LUT_PIXEL_FORMAT_BGRA16161616_FLOAT_FP1_5_10
+};
+
+enum dc_cm_lut_size {
+	CM_LUT_SIZE_NONE,
+	CM_LUT_SIZE_999,
+	CM_LUT_SIZE_171717,
+	CM_LUT_SIZE_333333,
+	CM_LUT_SIZE_454545,
+	CM_LUT_SIZE_656565,
+};
+
 #endif /* DC_TYPES_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index f1d394560892..0cdf93c614b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -827,6 +827,16 @@ void dccg401_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint3
 		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
 			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKD_FE_ROOT_GATE_DISABLE, 1);
 		break;
+	case 4:
+		if (dccg_dcn->dccg_mask->SYMCLKE_FE_ROOT_GATE_DISABLE) {
+			REG_UPDATE_2(SYMCLKE_CLOCK_ENABLE,
+					SYMCLKE_FE_EN, 1,
+					SYMCLKE_FE_SRC_SEL, link_enc_inst);
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKE_FE_ROOT_GATE_DISABLE, 1);
+		}
+		break;
+	default:
+		return;
 	}
 }
 
@@ -855,6 +865,16 @@ void dccg401_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint
 				SYMCLKD_FE_EN, 0,
 				SYMCLKD_FE_SRC_SEL, 0);
 		break;
+	case 4:
+		if (dccg_dcn->dccg_mask->SYMCLKE_FE_ROOT_GATE_DISABLE) {
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, SYMCLKE_FE_ROOT_GATE_DISABLE, 0);
+			REG_UPDATE_2(SYMCLKE_CLOCK_ENABLE,
+					SYMCLKE_FE_EN, 0,
+					SYMCLKE_FE_SRC_SEL, 0);
+		}
+		break;
+	default:
+		return;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index 7116fdd4c7ec..d0ffa99f1fe0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -28,6 +28,14 @@
 #include "dc_types.h"
 #include "core_types.h"
 
+static bool dmub_hw_lock_has_inbox0_lock(const struct dc *dc)
+{
+	return dc->ctx && dc->ctx->dmub_srv &&
+	       dc->hwss.dmub_hw_control_lock &&
+	       dc->hwss.dmub_hw_control_lock_fast &&
+	       dc->ctx->dmub_srv->dmub->meta_info.feature_bits.bits.inbox0_lock_support;
+}
+
 void dmub_hw_lock_mgr_cmd(struct dc_dmub_srv *dmub_srv,
 				bool lock,
 				union dmub_hw_lock_flags *hw_locks,
@@ -105,5 +113,13 @@ bool should_use_dmub_inbox1_lock(const struct dc *dc, const struct dc_link *link
 	if (dc->ctx->dce_version >= DCN_VERSION_4_01)
 		return false;
 
+	if (dmub_hw_lock_has_inbox0_lock(dc))
+		return false;
+
 	return dmub_hw_lock_mgr_does_link_require_lock(dc, link);
 }
+
+bool should_use_dmub_inbox0_lock_for_link(const struct dc *dc, const struct dc_link *link)
+{
+	return dmub_hw_lock_has_inbox0_lock(dc) && dmub_hw_lock_mgr_does_link_require_lock(dc, link);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
index 9495857902ed..3e8caa930390 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
@@ -67,4 +67,17 @@ bool dmub_hw_lock_mgr_does_link_require_lock(const struct dc *dc, const struct d
  */
 bool dmub_hw_lock_mgr_does_context_require_lock(const struct dc *dc, const struct dc_state *context);
 
+/**
+ * should_use_dmub_inbox0_lock_for_link() - Checks if the inbox0 interlock with DMU should be used.
+ *
+ * Is not functionally equivalent to inbox1 as DMUB will not own programming of the relevant locking
+ * registers.
+ *
+ * @dc: pointer to DC object
+ * @link: optional pointer to the link object to check for enabled link features
+ *
+ * Return: true if the inbox0 lock should be used, false otherwise
+ */
+bool should_use_dmub_inbox0_lock_for_link(const struct dc *dc, const struct dc_link *link);
+
 #endif /*_DMUB_HW_LOCK_MGR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index 6cc03391fff6..847fab508750 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -601,36 +601,31 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 
 	plane->composition.viewport.stationary = false;
 
-	if (plane_state->mcm_luts.lut3d_data.lut3d_src == DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM) {
+	if (plane_state->cm.flags.bits.lut3d_dma_enable) {
 		plane->tdlut.setup_for_tdlut = true;
 
-		switch (plane_state->mcm_luts.lut3d_data.gpu_mem_params.layout) {
-		case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_RGB:
-		case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_BGR:
+		switch (plane_state->cm.lut3d_dma.swizzle) {
+		case CM_LUT_3D_SWIZZLE_LINEAR_RGB:
+		case CM_LUT_3D_SWIZZLE_LINEAR_BGR:
 			plane->tdlut.tdlut_addressing_mode = dml2_tdlut_sw_linear;
 			break;
-		case DC_CM2_GPU_MEM_LAYOUT_1D_PACKED_LINEAR:
+		case CM_LUT_1D_PACKED_LINEAR:
+		default:
 			plane->tdlut.tdlut_addressing_mode = dml2_tdlut_simple_linear;
 			break;
 		}
 
-		switch (plane_state->mcm_luts.lut3d_data.gpu_mem_params.size) {
-		case DC_CM2_GPU_MEM_SIZE_171717:
-			plane->tdlut.tdlut_width_mode = dml2_tdlut_width_17_cube;
-			break;
-		case DC_CM2_GPU_MEM_SIZE_333333:
+		switch (plane_state->cm.lut3d_dma.size) {
+		case CM_LUT_SIZE_333333:
 			plane->tdlut.tdlut_width_mode = dml2_tdlut_width_33_cube;
 			break;
-		// handling when use case and HW support available
-		case DC_CM2_GPU_MEM_SIZE_454545:
-		case DC_CM2_GPU_MEM_SIZE_656565:
-			break;
-		case DC_CM2_GPU_MEM_SIZE_TRANSFORMED:
+		case CM_LUT_SIZE_171717:
 		default:
-			//plane->tdlut.tdlut_width_mode = dml2_tdlut_width_flatten; // dml2_tdlut_width_flatten undefined
+			plane->tdlut.tdlut_width_mode = dml2_tdlut_width_17_cube;
 			break;
 		}
 	}
+
 	plane->tdlut.setup_for_tdlut |= dml_ctx->config.force_tdlut_enable;
 
 	plane->dynamic_meta_data.enable = false;
@@ -967,5 +962,8 @@ void dml21_init_min_clocks_for_dc_state(struct dml2_context *in_ctx, struct dc_s
 	min_clocks->phyclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.phyclk.clk_values_khz[lowest_dpm_state_index];
 	min_clocks->stutter_efficiency.base_efficiency = 1;
 	min_clocks->stutter_efficiency.low_power_efficiency = 1;
+	min_clocks->stutter_efficiency.z8_stutter_efficiency = 1;
+	min_clocks->stutter_efficiency.z8_stutter_period = 100000;
+	min_clocks->zstate_support = DCN_ZSTATE_SUPPORT_ALLOW;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
index 732b994b8864..ab7ec24268be 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
@@ -374,6 +374,7 @@ void dml21_handle_phantom_streams_planes(const struct dc *dc, struct dc_state *c
 		dml2_map_dc_pipes(dml_ctx, context, NULL, &dml_ctx->v21.dml_to_dc_pipe_mapping, dc->current_state);
 }
 
+
 static unsigned int dml21_build_fams2_stream_programming_v2(const struct dc *dc,
 		struct dc_state *context,
 		struct dml2_context *dml_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
index 96c62bd6a37b..2623e917ec28 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
@@ -9,16 +9,21 @@
 #include "dml21_utils.h"
 #include "dml21_translation_helper.h"
 #include "dml2_dc_resource_mgmt.h"
+#include "dc_fpu.h"
+
+#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
+#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
+#endif // !DC_RUN_WITH_PREEMPTION_ENABLED
 
 #define INVALID -1
 
 static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 {
-	*dml_ctx = vzalloc(sizeof(struct dml2_context));
+	DC_RUN_WITH_PREEMPTION_ENABLED(*dml_ctx = vzalloc(sizeof(struct dml2_context)));
 	if (!(*dml_ctx))
 		return false;
 
-	(*dml_ctx)->v21.dml_init.dml2_instance = vzalloc(sizeof(struct dml2_instance));
+	DC_RUN_WITH_PREEMPTION_ENABLED((*dml_ctx)->v21.dml_init.dml2_instance = vzalloc(sizeof(struct dml2_instance)));
 	if (!((*dml_ctx)->v21.dml_init.dml2_instance))
 		return false;
 
@@ -28,7 +33,7 @@ static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 	(*dml_ctx)->v21.mode_support.display_config = &(*dml_ctx)->v21.display_config;
 	(*dml_ctx)->v21.mode_programming.display_config = (*dml_ctx)->v21.mode_support.display_config;
 
-	(*dml_ctx)->v21.mode_programming.programming = vzalloc(sizeof(struct dml2_display_cfg_programming));
+	DC_RUN_WITH_PREEMPTION_ENABLED((*dml_ctx)->v21.mode_programming.programming = vzalloc(sizeof(struct dml2_display_cfg_programming)));
 	if (!((*dml_ctx)->v21.mode_programming.programming))
 		return false;
 
@@ -70,8 +75,9 @@ static void dml21_init(const struct dc *in_dc, struct dml2_context *dml_ctx, con
 bool dml21_create(const struct dc *in_dc, struct dml2_context **dml_ctx, const struct dml2_configuration_options *config)
 {
 	/* Allocate memory for initializing DML21 instance */
-	if (!dml21_allocate_memory(dml_ctx))
+	if (!dml21_allocate_memory(dml_ctx)) {
 		return false;
+	}
 
 	dml21_init(in_dc, *dml_ctx, config);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
index 8cd074cfdf18..89e399f81f2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
@@ -1,5 +1,6 @@
-/* SPDX-License-Identifier: MIT */
-/* Copyright 2026 Advanced Micro Devices, Inc. */
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2024 Advanced Micro Devices, Inc.
 
 #ifndef __DML_DML_DCN42_SOC_BB__
 #define __DML_DML_DCN42_SOC_BB__
@@ -9,39 +10,39 @@
 static const struct dml2_soc_qos_parameters dml_dcn42_variant_a_soc_qos_params = {
 	.derate_table = {
 		.system_active_urgent = {
-			.dram_derate_percent_pixel = 22,
-			.dram_derate_percent_vm = 0,
-			.dram_derate_percent_pixel_and_vm = 0,
-			.fclk_derate_percent = 76,
-			.dcfclk_derate_percent = 100,
+			.dram_derate_percent_pixel = 65,
+			.dram_derate_percent_vm = 30,
+			.dram_derate_percent_pixel_and_vm = 60,
+			.fclk_derate_percent = 80,
+			.dcfclk_derate_percent = 80,
 		},
 		.system_active_average = {
-			.dram_derate_percent_pixel = 17,
-			.dram_derate_percent_vm = 0,
-			.dram_derate_percent_pixel_and_vm = 0,
-			.fclk_derate_percent = 57,
-			.dcfclk_derate_percent = 75,
+			.dram_derate_percent_pixel = 30,
+			.dram_derate_percent_vm = 30,
+			.dram_derate_percent_pixel_and_vm = 30,
+			.fclk_derate_percent = 60,
+			.dcfclk_derate_percent = 60,
 		},
 		.dcn_mall_prefetch_urgent = {
-			.dram_derate_percent_pixel = 40,
-			.dram_derate_percent_vm = 0,
-			.dram_derate_percent_pixel_and_vm = 0,
-			.fclk_derate_percent = 83,
-			.dcfclk_derate_percent = 100,
+			.dram_derate_percent_pixel = 65,
+			.dram_derate_percent_vm = 30,
+			.dram_derate_percent_pixel_and_vm = 60,
+			.fclk_derate_percent = 80,
+			.dcfclk_derate_percent = 80,
 		},
 		.dcn_mall_prefetch_average = {
-			.dram_derate_percent_pixel = 33,
-			.dram_derate_percent_vm = 0,
-			.dram_derate_percent_pixel_and_vm = 0,
-			.fclk_derate_percent = 62,
-			.dcfclk_derate_percent = 83,
+			.dram_derate_percent_pixel = 30,
+			.dram_derate_percent_vm = 30,
+			.dram_derate_percent_pixel_and_vm = 30,
+			.fclk_derate_percent = 60,
+			.dcfclk_derate_percent = 60,
 		},
 		.system_idle_average = {
-			.dram_derate_percent_pixel = 70,
-			.dram_derate_percent_vm = 0,
-			.dram_derate_percent_pixel_and_vm = 0,
-			.fclk_derate_percent = 83,
-			.dcfclk_derate_percent = 100,
+			.dram_derate_percent_pixel = 30,
+			.dram_derate_percent_vm = 30,
+			.dram_derate_percent_pixel_and_vm = 30,
+			.fclk_derate_percent = 60,
+			.dcfclk_derate_percent = 60,
 		},
 	},
 	.writeback = {
@@ -50,80 +51,71 @@ static const struct dml2_soc_qos_parameters dml_dcn42_variant_a_soc_qos_params =
 		.scaling_factor_mhz = 0,
 	},
 	.qos_params = {
-		.dcn4x = {
-			.df_qos_response_time_fclk_cycles = 300,
-			.max_round_trip_to_furthest_cs_fclk_cycles = 350,
-			.mall_overhead_fclk_cycles = 50,
-			.meta_trip_adder_fclk_cycles = 36,
-			.average_transport_distance_fclk_cycles = 257,
-			.umc_urgent_ramp_latency_margin = 50,
-			.umc_max_latency_margin = 30,
-			.umc_average_latency_margin = 20,
-			.fabric_max_transport_latency_margin = 20,
-			.fabric_average_transport_latency_margin = 10,
-
-			.per_uclk_dpm_params = {
-				{
-					.minimum_uclk_khz = 97 * 1000,
-					.urgent_ramp_uclk_cycles = 472,
-					.trip_to_memory_uclk_cycles = 827,
-					.meta_trip_to_memory_uclk_cycles = 827,
-					.maximum_latency_when_urgent_uclk_cycles = 72,
-					.average_latency_when_urgent_uclk_cycles = 61,
-					.maximum_latency_when_non_urgent_uclk_cycles = 827,
-					.average_latency_when_non_urgent_uclk_cycles = 118,
-				},
+		.dcn32x = {
+			.loaded_round_trip_latency_fclk_cycles = 106,
+			.urgent_latency_us = {
+				.base_latency_us = 4,
+				.base_latency_pixel_vm_us = 4,
+				.base_latency_vm_us = 4,
+				.scaling_factor_fclk_us = 0,
+				.scaling_factor_mhz = 0,
 			},
+			.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
+			.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
+			.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
 		},
 	},
-	.qos_type = dml2_qos_param_type_dcn4x,
+	.qos_type = dml2_qos_param_type_dcn3,
 };
 
 static const struct dml2_soc_bb dml2_socbb_dcn42 = {
 	.clk_table = {
+		.wck_ratio = {
+				.clk_values_khz = {2},
+		},
 		.uclk = {
-				.clk_values_khz = {97000},
+				.clk_values_khz = {400000},
 				.num_clk_values = 1,
 		},
 		.fclk = {
-				.clk_values_khz = {300000, 2500000},
-				.num_clk_values = 2,
+				.clk_values_khz = {400000},
+				.num_clk_values = 1,
 		},
 		.dcfclk = {
-				.clk_values_khz = {200000, 1564000},
-				.num_clk_values = 2,
+				.clk_values_khz = {200000},
+				.num_clk_values = 1,
 		},
 		.dispclk = {
-				.clk_values_khz = {100000, 1500000},
-				.num_clk_values = 2,
+				.clk_values_khz = {1500000},
+				.num_clk_values = 1,
 		},
 		.dppclk = {
-				.clk_values_khz = {100000, 1500000},
-				.num_clk_values = 2,
+				.clk_values_khz = {1500000},
+				.num_clk_values = 1,
 		},
 		.dtbclk = {
-				.clk_values_khz = {600000, 600000},
-				.num_clk_values = 2,
+				.clk_values_khz = {600000},
+				.num_clk_values = 1,
 		},
 		.phyclk = {
-				.clk_values_khz = {810000, 810000},
-				.num_clk_values = 2,
+				.clk_values_khz = {810000},
+				.num_clk_values = 1,
 		},
 		.socclk = {
-				.clk_values_khz = {300000, 1200000},
-				.num_clk_values = 2,
+				.clk_values_khz = {600000},
+				.num_clk_values = 1,
 		},
 		.dscclk = {
-				.clk_values_khz = {500000, 500000},
-				.num_clk_values = 2,
+				.clk_values_khz = {500000},
+				.num_clk_values = 1,
 		},
 		.phyclk_d18 = {
-				.clk_values_khz = {667000, 667000},
-				.num_clk_values = 2,
+				.clk_values_khz = {667000},
+				.num_clk_values = 1,
 		},
 		.phyclk_d32 = {
-				.clk_values_khz = {625000, 625000},
-				.num_clk_values = 2,
+				.clk_values_khz = {625000},
+				.num_clk_values = 1,
 		},
 		.dram_config = {
 			.channel_width_bytes = 4,
@@ -135,39 +127,39 @@ static const struct dml2_soc_bb dml2_socbb_dcn42 = {
 	.qos_parameters = {
 		.derate_table = {
 			.system_active_urgent = {
-				.dram_derate_percent_pixel = 22,
-				.dram_derate_percent_vm = 0,
-				.dram_derate_percent_pixel_and_vm = 0,
-				.fclk_derate_percent = 76,
-				.dcfclk_derate_percent = 100,
+				.dram_derate_percent_pixel = 65,
+				.dram_derate_percent_vm = 30,
+				.dram_derate_percent_pixel_and_vm = 60,
+				.fclk_derate_percent = 80,
+				.dcfclk_derate_percent = 80,
 			},
 			.system_active_average = {
-				.dram_derate_percent_pixel = 15,
-				.dram_derate_percent_vm = 0,
-				.dram_derate_percent_pixel_and_vm = 0,
-				.fclk_derate_percent = 57,
-				.dcfclk_derate_percent = 75,
+				.dram_derate_percent_pixel = 30,
+				.dram_derate_percent_vm = 30,
+				.dram_derate_percent_pixel_and_vm = 30,
+				.fclk_derate_percent = 60,
+				.dcfclk_derate_percent = 60,
 			},
 			.dcn_mall_prefetch_urgent = {
-				.dram_derate_percent_pixel = 40,
-				.dram_derate_percent_vm = 0,
-				.dram_derate_percent_pixel_and_vm = 0,
-				.fclk_derate_percent = 83,
-				.dcfclk_derate_percent = 100,
+				.dram_derate_percent_pixel = 65,
+				.dram_derate_percent_vm = 30,
+				.dram_derate_percent_pixel_and_vm = 60,
+				.fclk_derate_percent = 80,
+				.dcfclk_derate_percent = 80,
 			},
 			.dcn_mall_prefetch_average = {
 				.dram_derate_percent_pixel = 30,
-				.dram_derate_percent_vm = 0,
-				.dram_derate_percent_pixel_and_vm = 0,
-				.fclk_derate_percent = 62,
-				.dcfclk_derate_percent = 83,
+				.dram_derate_percent_vm = 30,
+				.dram_derate_percent_pixel_and_vm = 30,
+				.fclk_derate_percent = 60,
+				.dcfclk_derate_percent = 60,
 			},
 			.system_idle_average = {
-				.dram_derate_percent_pixel = 70,
-				.dram_derate_percent_vm = 0,
-				.dram_derate_percent_pixel_and_vm = 0,
-				.fclk_derate_percent = 83,
-				.dcfclk_derate_percent = 100,
+				.dram_derate_percent_pixel = 30,
+				.dram_derate_percent_vm = 30,
+				.dram_derate_percent_pixel_and_vm = 30,
+				.fclk_derate_percent = 60,
+				.dcfclk_derate_percent = 60,
 			},
 		},
 		.writeback = {
@@ -176,115 +168,25 @@ static const struct dml2_soc_bb dml2_socbb_dcn42 = {
 			.scaling_factor_mhz = 0,
 		},
 		.qos_params = {
-			.dcn4x = {
-				.df_qos_response_time_fclk_cycles = 300,
-				.max_round_trip_to_furthest_cs_fclk_cycles = 350,
-				.mall_overhead_fclk_cycles = 50,
-				.meta_trip_adder_fclk_cycles = 36,
-				.average_transport_distance_fclk_cycles = 260,
-				.umc_urgent_ramp_latency_margin = 50,
-				.umc_max_latency_margin = 30,
-				.umc_average_latency_margin = 20,
-				.fabric_max_transport_latency_margin = 20,
-				.fabric_average_transport_latency_margin = 10,
-
-				.per_uclk_dpm_params = {
-					{
-						// State 1
-						.minimum_uclk_khz = 0,
-						.urgent_ramp_uclk_cycles = 472,
-						.trip_to_memory_uclk_cycles = 827,
-						.meta_trip_to_memory_uclk_cycles = 827,
-						.maximum_latency_when_urgent_uclk_cycles = 72,
-						.average_latency_when_urgent_uclk_cycles = 72,
-						.maximum_latency_when_non_urgent_uclk_cycles = 827,
-						.average_latency_when_non_urgent_uclk_cycles = 117,
-					},
-					{
-						// State 2
-						.minimum_uclk_khz = 0,
-						.urgent_ramp_uclk_cycles = 546,
-						.trip_to_memory_uclk_cycles = 848,
-						.meta_trip_to_memory_uclk_cycles = 848,
-						.maximum_latency_when_urgent_uclk_cycles = 146,
-						.average_latency_when_urgent_uclk_cycles = 146,
-						.maximum_latency_when_non_urgent_uclk_cycles = 848,
-						.average_latency_when_non_urgent_uclk_cycles = 133,
-					},
-					{
-						// State 3
-						.minimum_uclk_khz = 0,
-						.urgent_ramp_uclk_cycles = 564,
-						.trip_to_memory_uclk_cycles = 853,
-						.meta_trip_to_memory_uclk_cycles = 853,
-						.maximum_latency_when_urgent_uclk_cycles = 164,
-						.average_latency_when_urgent_uclk_cycles = 164,
-						.maximum_latency_when_non_urgent_uclk_cycles = 853,
-						.average_latency_when_non_urgent_uclk_cycles = 136,
-					},
-					{
-						// State 4
-						.minimum_uclk_khz = 0,
-						.urgent_ramp_uclk_cycles = 613,
-						.trip_to_memory_uclk_cycles = 869,
-						.meta_trip_to_memory_uclk_cycles = 869,
-						.maximum_latency_when_urgent_uclk_cycles = 213,
-						.average_latency_when_urgent_uclk_cycles = 213,
-						.maximum_latency_when_non_urgent_uclk_cycles = 869,
-						.average_latency_when_non_urgent_uclk_cycles = 149,
-					},
-					{
-						// State 5
-						.minimum_uclk_khz = 0,
-						.urgent_ramp_uclk_cycles = 632,
-						.trip_to_memory_uclk_cycles = 874,
-						.meta_trip_to_memory_uclk_cycles = 874,
-						.maximum_latency_when_urgent_uclk_cycles = 232,
-						.average_latency_when_urgent_uclk_cycles = 232,
-						.maximum_latency_when_non_urgent_uclk_cycles = 874,
-						.average_latency_when_non_urgent_uclk_cycles = 153,
-					},
-					{
-						// State 6
-						.minimum_uclk_khz = 0,
-						.urgent_ramp_uclk_cycles = 665,
-						.trip_to_memory_uclk_cycles = 885,
-						.meta_trip_to_memory_uclk_cycles = 885,
-						.maximum_latency_when_urgent_uclk_cycles = 265,
-						.average_latency_when_urgent_uclk_cycles = 265,
-						.maximum_latency_when_non_urgent_uclk_cycles = 885,
-						.average_latency_when_non_urgent_uclk_cycles = 161,
-					},
-					{
-						// State 7
-						.minimum_uclk_khz = 0,
-						.urgent_ramp_uclk_cycles = 689,
-						.trip_to_memory_uclk_cycles = 895,
-						.meta_trip_to_memory_uclk_cycles = 895,
-						.maximum_latency_when_urgent_uclk_cycles = 289,
-						.average_latency_when_urgent_uclk_cycles = 289,
-						.maximum_latency_when_non_urgent_uclk_cycles = 895,
-						.average_latency_when_non_urgent_uclk_cycles = 167,
-					},
-					{
-						// State 8
-						.minimum_uclk_khz = 0,
-						.urgent_ramp_uclk_cycles = 716,
-						.trip_to_memory_uclk_cycles = 902,
-						.meta_trip_to_memory_uclk_cycles = 902,
-						.maximum_latency_when_urgent_uclk_cycles = 316,
-						.average_latency_when_urgent_uclk_cycles = 316,
-						.maximum_latency_when_non_urgent_uclk_cycles = 902,
-						.average_latency_when_non_urgent_uclk_cycles = 174,
-					},
+			.dcn32x = {
+				.loaded_round_trip_latency_fclk_cycles = 106,
+				.urgent_latency_us = {
+					.base_latency_us = 4,
+					.base_latency_pixel_vm_us = 4,
+					.base_latency_vm_us = 4,
+					.scaling_factor_fclk_us = 0,
+					.scaling_factor_mhz = 0,
 				},
+				.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
+				.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
+				.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
 			},
 		},
-		.qos_type = dml2_qos_param_type_dcn4x,
+		.qos_type = dml2_qos_param_type_dcn3,
 	},
 
 	.power_management_parameters = {
-		.dram_clk_change_blackout_us = 11.72,
+		.dram_clk_change_blackout_us = 29,
 		.fclk_change_blackout_us = 0,
 		.g7_ppt_blackout_us = 0,
 		.stutter_enter_plus_exit_latency_us = 11,
@@ -293,9 +195,9 @@ static const struct dml2_soc_bb dml2_socbb_dcn42 = {
 		.z8_stutter_exit_latency_us = 200,
 	},
 
-	 .vmin_limit = {
-		.dispclk_khz = 600 * 1000,
-	 },
+	.vmin_limit = {
+		.dispclk_khz = 632 * 1000,
+	},
 
 	.dprefclk_mhz = 600,
 	.xtalclk_mhz = 24,
@@ -307,6 +209,8 @@ static const struct dml2_soc_bb dml2_socbb_dcn42 = {
 	.return_bus_width_bytes = 64,
 	.hostvm_min_page_size_kbytes = 4,
 	.gpuvm_min_page_size_kbytes = 256,
+	.gpuvm_max_page_table_levels = 1,
+	.hostvm_max_non_cached_page_table_levels = 2,
 	.phy_downspread_percent = 0.38,
 	.dcn_downspread_percent = 0.38,
 	.dispclk_dppclk_vco_speed_mhz = 3000,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
index b44762e21550..4e9abe1a568d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_display_cfg_types.h
@@ -27,6 +27,19 @@ enum dml2_swizzle_mode {
 	dml2_gfx11_sw_256kb_d_x,
 	dml2_gfx11_sw_256kb_r_x,
 
+	dml2_sw_linear_256b, // GFX10 SW_LINEAR only accepts 256 byte aligned pitch
+	dml2_gfx10_sw_64kb_r_x,
+	dml2_gfx102_sw_64kb_s,
+	dml2_gfx102_sw_64kb_s_t,
+	dml2_gfx102_sw_64kb_s_x,
+	dml2_gfx102_sw_64kb_r_x,
+
+	dml2_linear_64elements, // GFX7 LINEAR_ALIGNED accepts pitch alignment of the maximum of 64 elements or 256 bytes
+	dml2_gfx7_1d_thin,
+	dml2_gfx7_2d_thin_gen_zero,
+	dml2_gfx7_2d_thin_gen_one,
+	dml2_gfx7_2d_thin_arlene,
+	dml2_gfx7_2d_thin_anubis
 };
 
 enum dml2_source_format_class {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index c854515b49a3..98b26116cdc1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -19,6 +19,7 @@ enum dml2_project_id {
 	dml2_project_dcn4x_stage1,
 	dml2_project_dcn4x_stage2,
 	dml2_project_dcn4x_stage2_auto_drr_svp,
+	dml2_project_dcn40,
 	dml2_project_dcn42,
 };
 
@@ -80,6 +81,7 @@ struct dml2_options {
 	struct dml2_pmo_options pmo_options;
 };
 
+
 struct dml2_initialize_instance_in_out {
 	struct dml2_instance *dml2_instance;
 	struct dml2_options options;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
index 23ede1107340..608b4a305c65 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -79,83 +79,83 @@ struct dml2_core_ip_params core_dcn4_ip_caps_base = {
 };
 
 struct dml2_core_ip_params core_dcn42_ip_caps_base = {
-.vblank_nom_default_us = 668,
-.remote_iommu_outstanding_translations = 256,
-.rob_buffer_size_kbytes = 64,
-.config_return_buffer_size_in_kbytes = 1792,
-.config_return_buffer_segment_size_in_kbytes = 64,
-.compressed_buffer_segment_size_in_kbytes = 64,
-.dpte_buffer_size_in_pte_reqs_luma = 68,
-.dpte_buffer_size_in_pte_reqs_chroma = 36,
-.pixel_chunk_size_kbytes = 8,
-.alpha_pixel_chunk_size_kbytes = 4,
-.min_pixel_chunk_size_bytes = 1024,
-.writeback_chunk_size_kbytes = 8,
-.line_buffer_size_bits = 1171920,
-.max_line_buffer_lines = 32,
-.writeback_interface_buffer_size_kbytes = 90,
-
-//Number of pipes after DCN Pipe harvesting
-.max_num_dpp = 4,
-.max_num_otg = 4,
-.max_num_opp = 4,
-.max_num_wb = 1,
-.max_dchub_pscl_bw_pix_per_clk = 4,
-.max_pscl_lb_bw_pix_per_clk = 2,
-.max_lb_vscl_bw_pix_per_clk = 4,
-.max_vscl_hscl_bw_pix_per_clk = 4,
-.max_hscl_ratio = 6,
-.max_vscl_ratio = 6,
-.max_hscl_taps = 8,
-.max_vscl_taps = 8,
-.dispclk_ramp_margin_percent = 1,
-.dppclk_delay_subtotal = 47,
-.dppclk_delay_scl = 50,
-.dppclk_delay_scl_lb_only = 16,
-.dppclk_delay_cnvc_formatter = 28,
-.dppclk_delay_cnvc_cursor = 6,
-.cursor_buffer_size = 42,
-.cursor_chunk_size = 2,
-.dispclk_delay_subtotal = 125,
-.max_inter_dcn_tile_repeaters = 8,
-.writeback_max_hscl_ratio = 1,
-.writeback_max_vscl_ratio = 1,
-.writeback_min_hscl_ratio = 1,
-.writeback_min_vscl_ratio = 1,
-.writeback_max_hscl_taps = 1,
-.writeback_max_vscl_taps = 1,
-.writeback_line_buffer_buffer_size = 0,
-.num_dsc = 4,
-.maximum_dsc_bits_per_component = 12,
-.maximum_pixels_per_line_per_dsc_unit = 5760,
-.dsc422_native_support = true,
-.dcc_supported = true,
-.ptoi_supported = false,
-
-.cursor_64bpp_support = true,
-.dynamic_metadata_vm_enabled = false,
-
-.max_num_hdmi_frl_outputs = 0,
-.max_num_dp2p0_outputs = 2,
-.max_num_dp2p0_streams = 4,
-.imall_supported = 1,
-.max_flip_time_us = 110,
-.max_flip_time_lines = 50,
-.words_per_channel = 16,
-
-.subvp_fw_processing_delay_us = 15,
-.subvp_pstate_allow_width_us = 20,
-.subvp_swath_height_margin_lines = 16,
-
-.dcn_mrq_present = 1,
-.zero_size_buffer_entries = 512,
-.compbuf_reserved_space_zs = 64,
-.dcc_meta_buffer_size_bytes = 6272,
-.meta_chunk_size_kbytes = 2,
-.min_meta_chunk_size_bytes = 256,
-
-.dchub_arb_to_ret_delay = 102,
-.hostvm_mode = 1,
+	.vblank_nom_default_us = 668,
+	.remote_iommu_outstanding_translations = 256,
+	.rob_buffer_size_kbytes = 64,
+	.config_return_buffer_size_in_kbytes = 1792,
+	.config_return_buffer_segment_size_in_kbytes = 64,
+	.compressed_buffer_segment_size_in_kbytes = 64,
+	.dpte_buffer_size_in_pte_reqs_luma = 68,
+	.dpte_buffer_size_in_pte_reqs_chroma = 36,
+	.pixel_chunk_size_kbytes = 8,
+	.alpha_pixel_chunk_size_kbytes = 4,
+	.min_pixel_chunk_size_bytes = 1024,
+	.writeback_chunk_size_kbytes = 8,
+	.line_buffer_size_bits = 1171920,
+	.max_line_buffer_lines = 32,
+	.writeback_interface_buffer_size_kbytes = 90,
+
+	//Number of pipes after DCN Pipe harvesting
+	.max_num_dpp = 4,
+	.max_num_otg = 4,
+	.max_num_opp = 4,
+	.max_num_wb = 1,
+	.max_dchub_pscl_bw_pix_per_clk = 4,
+	.max_pscl_lb_bw_pix_per_clk = 2,
+	.max_lb_vscl_bw_pix_per_clk = 4,
+	.max_vscl_hscl_bw_pix_per_clk = 4,
+	.max_hscl_ratio = 6,
+	.max_vscl_ratio = 6,
+	.max_hscl_taps = 8,
+	.max_vscl_taps = 8,
+	.dispclk_ramp_margin_percent = 1,
+	.dppclk_delay_subtotal = 47,
+	.dppclk_delay_scl = 50,
+	.dppclk_delay_scl_lb_only = 16,
+	.dppclk_delay_cnvc_formatter = 28,
+	.dppclk_delay_cnvc_cursor = 6,
+	.cursor_buffer_size = 42,
+	.cursor_chunk_size = 2,
+	.dispclk_delay_subtotal = 125,
+	.max_inter_dcn_tile_repeaters = 8,
+	.writeback_max_hscl_ratio = 1,
+	.writeback_max_vscl_ratio = 1,
+	.writeback_min_hscl_ratio = 1,
+	.writeback_min_vscl_ratio = 1,
+	.writeback_max_hscl_taps = 1,
+	.writeback_max_vscl_taps = 1,
+	.writeback_line_buffer_buffer_size = 0,
+	.num_dsc = 4,
+	.maximum_dsc_bits_per_component = 12,
+	.maximum_pixels_per_line_per_dsc_unit = 5760,
+	.dsc422_native_support = true,
+	.dcc_supported = true,
+	.ptoi_supported = false,
+
+	.cursor_64bpp_support = true,
+	.dynamic_metadata_vm_enabled = false,
+
+	.max_num_hdmi_frl_outputs = 0,
+	.max_num_dp2p0_outputs = 2,
+	.max_num_dp2p0_streams = 4,
+	.imall_supported = 1,
+	.max_flip_time_us = 110,
+	.max_flip_time_lines = 50,
+	.words_per_channel = 16,
+
+	.subvp_fw_processing_delay_us = 15,
+	.subvp_pstate_allow_width_us = 20,
+	.subvp_swath_height_margin_lines = 16,
+
+	.dcn_mrq_present = 1,
+	.zero_size_buffer_entries = 512,
+	.compbuf_reserved_space_zs = 64,
+	.dcc_meta_buffer_size_bytes = 6272,
+	.meta_chunk_size_kbytes = 2,
+	.min_meta_chunk_size_bytes = 256,
+
+	.dchub_arb_to_ret_delay = 102,
+	.hostvm_mode = 1,
 };
 
 static void patch_ip_caps_with_explicit_ip_params(struct dml2_ip_capabilities *ip_caps, const struct dml2_core_ip_params *ip_params)
@@ -235,33 +235,33 @@ bool core_dcn4_initialize(struct dml2_core_initialize_in_out *in_out)
 
 bool core_dcn42_initialize(struct dml2_core_initialize_in_out *in_out)
 {
-struct dml2_core_instance *core = in_out->instance;
-
-if (!in_out->minimum_clock_table)
-return false;
-
-core->minimum_clock_table = in_out->minimum_clock_table;
-
-if (in_out->explicit_ip_bb && in_out->explicit_ip_bb_size > 0) {
-memcpy(&core->clean_me_up.mode_lib.ip, in_out->explicit_ip_bb, in_out->explicit_ip_bb_size);
-
-// FIXME_STAGE2:
-// DV still uses stage1 ip_param_st for each variant, need to patch the ip_caps with ip_param info
-// Should move DV to use ip_caps but need move more overrides to ip_caps
-patch_ip_caps_with_explicit_ip_params(in_out->ip_caps, in_out->explicit_ip_bb);
-core->clean_me_up.mode_lib.ip.subvp_pstate_allow_width_us = core_dcn4_ip_caps_base.subvp_pstate_allow_width_us;
-core->clean_me_up.mode_lib.ip.subvp_fw_processing_delay_us = core_dcn4_ip_caps_base.subvp_pstate_allow_width_us;
-core->clean_me_up.mode_lib.ip.subvp_swath_height_margin_lines = core_dcn4_ip_caps_base.subvp_swath_height_margin_lines;
-} else {
-memcpy(&core->clean_me_up.mode_lib.ip, &core_dcn42_ip_caps_base, sizeof(struct dml2_core_ip_params));
-patch_ip_params_with_ip_caps(&core->clean_me_up.mode_lib.ip, in_out->ip_caps);
-core->clean_me_up.mode_lib.ip.imall_supported = false;
-}
+	struct dml2_core_instance *core = in_out->instance;
 
-memcpy(&core->clean_me_up.mode_lib.soc, in_out->soc_bb, sizeof(struct dml2_soc_bb));
-memcpy(&core->clean_me_up.mode_lib.ip_caps, in_out->ip_caps, sizeof(struct dml2_ip_capabilities));
+	if (!in_out->minimum_clock_table)
+		return false;
+	else
+		core->minimum_clock_table = in_out->minimum_clock_table;
+
+	if (in_out->explicit_ip_bb && in_out->explicit_ip_bb_size > 0) {
+		memcpy(&core->clean_me_up.mode_lib.ip, in_out->explicit_ip_bb, in_out->explicit_ip_bb_size);
 
-return true;
+		// FIXME_STAGE2:
+		// DV still uses stage1 ip_param_st for each variant, need to patch the ip_caps with ip_param info
+		// Should move DV to use ip_caps but need move more overrides to ip_caps
+		patch_ip_caps_with_explicit_ip_params(in_out->ip_caps, in_out->explicit_ip_bb);
+		core->clean_me_up.mode_lib.ip.subvp_pstate_allow_width_us = core_dcn4_ip_caps_base.subvp_pstate_allow_width_us;
+		core->clean_me_up.mode_lib.ip.subvp_fw_processing_delay_us = core_dcn4_ip_caps_base.subvp_pstate_allow_width_us;
+		core->clean_me_up.mode_lib.ip.subvp_swath_height_margin_lines = core_dcn4_ip_caps_base.subvp_swath_height_margin_lines;
+	} else {
+		memcpy(&core->clean_me_up.mode_lib.ip, &core_dcn42_ip_caps_base, sizeof(struct dml2_core_ip_params));
+		patch_ip_params_with_ip_caps(&core->clean_me_up.mode_lib.ip, in_out->ip_caps);
+		core->clean_me_up.mode_lib.ip.imall_supported = false;
+	}
+
+	memcpy(&core->clean_me_up.mode_lib.soc, in_out->soc_bb, sizeof(struct dml2_soc_bb));
+	memcpy(&core->clean_me_up.mode_lib.ip_caps, in_out->ip_caps, sizeof(struct dml2_ip_capabilities));
+
+	return true;
 }
 
 static void create_phantom_stream_from_main_stream(struct dml2_stream_parameters *phantom, const struct dml2_stream_parameters *main,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c
index 67e307fa4310..6cad99c21139 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_factory.c
@@ -21,6 +21,7 @@ bool dml2_core_create(enum dml2_project_id project_id, struct dml2_core_instance
 	case dml2_project_dcn4x_stage1:
 		result = false;
 		break;
+	case dml2_project_dcn40:
 	case dml2_project_dcn4x_stage2:
 	case dml2_project_dcn4x_stage2_auto_drr_svp:
 		out->initialize = &core_dcn4_initialize;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
index b57d0f6ea6a1..6930ba7ce5b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
@@ -428,6 +428,9 @@ bool dml2_core_utils_is_phantom_pipe(const struct dml2_plane_parameters *plane_c
 
 unsigned int dml2_core_utils_get_tile_block_size_bytes(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel)
 {
+	if (dml2_core_utils_get_gfx_version(sw_mode) == 10 || dml2_core_utils_get_gfx_version(sw_mode) == 7) {
+		return dml2_core_utils_get_tile_block_size_bytes_backcompat(sw_mode, byte_per_pixel);
+	}
 
 	if (sw_mode == dml2_sw_linear)
 		return 256;
@@ -459,14 +462,56 @@ unsigned int dml2_core_utils_get_tile_block_size_bytes(enum dml2_swizzle_mode sw
 	};
 }
 
+unsigned int dml2_core_utils_get_tile_block_size_bytes_backcompat(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel)
+{
+	if (sw_mode == dml2_sw_linear_256b)
+		return 256;
+	else if (sw_mode == dml2_gfx10_sw_64kb_r_x)
+		return 65536;
+	else if (sw_mode == dml2_gfx102_sw_64kb_s)
+		return 65536;
+	else if (sw_mode == dml2_gfx102_sw_64kb_s_t)
+		return 65536;
+	else if (sw_mode == dml2_gfx102_sw_64kb_s_x)
+		return 65536;
+	else if (sw_mode == dml2_gfx102_sw_64kb_r_x)
+		return 65536;
+	else if (sw_mode == dml2_linear_64elements)
+		return 256;
+	else if (sw_mode == dml2_gfx7_1d_thin)
+		return 256;
+	else if (sw_mode == dml2_gfx7_2d_thin_gen_zero)
+		return (128 * 64 * byte_per_pixel);
+	else if (sw_mode == dml2_gfx7_2d_thin_gen_one)
+		return (128 * 128 * byte_per_pixel);
+	else if (sw_mode == dml2_gfx7_2d_thin_arlene)
+		return (64 * 32 * byte_per_pixel);
+	else if (sw_mode == dml2_gfx7_2d_thin_anubis)
+		return (128 * 128 * byte_per_pixel);
+	else {
+		DML_ASSERT(0);
+		return 256;
+	};
+}
+
 bool dml2_core_utils_get_segment_horizontal_contiguous(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel)
 {
-	return (byte_per_pixel != 2);
+	if (dml2_core_utils_get_gfx_version(sw_mode) == 10 || dml2_core_utils_get_gfx_version(sw_mode) == 7) {
+		return dml2_core_utils_get_segment_horizontal_contiguous_backcompat(sw_mode, byte_per_pixel);
+	} else {
+		return (byte_per_pixel != 2);
+	}
+}
+
+bool dml2_core_utils_get_segment_horizontal_contiguous_backcompat(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel)
+{
+	return !((byte_per_pixel == 4) &&
+		((sw_mode == dml2_gfx10_sw_64kb_r_x) || (sw_mode == dml2_gfx102_sw_64kb_s) || (sw_mode == dml2_gfx102_sw_64kb_s_t) || (sw_mode == dml2_gfx102_sw_64kb_s_x)));
 }
 
 bool dml2_core_utils_is_linear(enum dml2_swizzle_mode sw_mode)
 {
-	return sw_mode == dml2_sw_linear;
+	return (sw_mode == dml2_sw_linear || sw_mode == dml2_sw_linear_256b || sw_mode == dml2_linear_64elements);
 };
 
 
@@ -499,6 +544,20 @@ int unsigned dml2_core_utils_get_gfx_version(enum dml2_swizzle_mode sw_mode)
 		sw_mode == dml2_gfx11_sw_256kb_d_x ||
 		sw_mode == dml2_gfx11_sw_256kb_r_x)
 		version = 11;
+	else if (sw_mode == dml2_sw_linear_256b ||
+		sw_mode == dml2_gfx10_sw_64kb_r_x ||
+		sw_mode == dml2_gfx102_sw_64kb_s ||
+		sw_mode == dml2_gfx102_sw_64kb_s_t ||
+		sw_mode == dml2_gfx102_sw_64kb_s_x ||
+		sw_mode == dml2_gfx102_sw_64kb_r_x)
+		version = 10;
+	else if (sw_mode == dml2_linear_64elements ||
+		sw_mode == dml2_gfx7_1d_thin ||
+		sw_mode == dml2_gfx7_2d_thin_gen_zero ||
+		sw_mode == dml2_gfx7_2d_thin_gen_one ||
+		sw_mode == dml2_gfx7_2d_thin_arlene ||
+		sw_mode == dml2_gfx7_2d_thin_anubis)
+		version = 7;
 	else {
 		DML_LOG_VERBOSE("ERROR: Invalid sw_mode setting! val=%u\n", sw_mode);
 		DML_ASSERT(0);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h
index 95f0d017add4..471e73ed671c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.h
@@ -22,6 +22,8 @@ void dml2_core_utils_pipe_plane_mapping(const struct core_display_cfg_support_in
 bool dml2_core_utils_is_phantom_pipe(const struct dml2_plane_parameters *plane_cfg);
 unsigned int dml2_core_utils_get_tile_block_size_bytes(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel);
 bool dml2_core_utils_get_segment_horizontal_contiguous(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel);
+unsigned int dml2_core_utils_get_tile_block_size_bytes_backcompat(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel);
+bool dml2_core_utils_get_segment_horizontal_contiguous_backcompat(enum dml2_swizzle_mode sw_mode, unsigned int byte_per_pixel);
 bool dml2_core_utils_is_vertical_rotation(enum dml2_rotation_angle Scan);
 bool dml2_core_utils_is_linear(enum dml2_swizzle_mode sw_mode);
 int unsigned dml2_core_utils_get_gfx_version(enum dml2_swizzle_mode sw_mode);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
index 037272d2c2e6..d17e59d684fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
@@ -802,7 +802,6 @@ bool dpmm_dcn4_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_
 
 	return true;
 }
-
 bool dpmm_dcn42_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_out)
 {
 	const struct dml2_display_cfg *display_cfg = &in_out->display_cfg->display_config;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
index 80d4932bf154..1f2d9e97f5fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c
@@ -31,6 +31,7 @@ bool dml2_dpmm_create(enum dml2_project_id project_id, struct dml2_dpmm_instance
 		out->map_watermarks = &dummy_map_watermarks;
 		result = true;
 		break;
+	case dml2_project_dcn40:
 	case dml2_project_dcn4x_stage2:
 		out->map_mode_to_soc_dpm = &dpmm_dcn3_map_mode_to_soc_dpm;
 		out->map_watermarks = &dummy_map_watermarks;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.h
index f54fde8fba90..02da6f45cbf7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.h
@@ -10,4 +10,4 @@
 bool mcg_dcn4_build_min_clock_table(struct dml2_mcg_build_min_clock_table_params_in_out *in_out);
 bool mcg_dcn4_unit_test(void);
 
-#endif
\ No newline at end of file
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.h
index ad8a847a0a17..51677a392333 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.h
@@ -1,5 +1,6 @@
-/* SPDX-License-Identifier: MIT */
-/* Copyright 2026 Advanced Micro Devices, Inc. */
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
 
 #ifndef __DML2_MCG_DCN42_H__
 #define __DML2_MCG_DCN42_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c
index 1cff62b63e72..3dcd2c250633 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c
@@ -26,6 +26,7 @@ bool dml2_mcg_create(enum dml2_project_id project_id, struct dml2_mcg_instance *
 		out->build_min_clock_table = &dummy_build_min_clock_table;
 		result = true;
 		break;
+	case dml2_project_dcn40:
 	case dml2_project_dcn4x_stage2:
 	case dml2_project_dcn4x_stage2_auto_drr_svp:
 		out->build_min_clock_table = &mcg_dcn4_build_min_clock_table;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index c26e100fcaf2..e8691983c0eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -23,6 +23,7 @@ static const struct dml2_pmo_pstate_strategy base_strategy_list_1_display[] = {
 		.allow_state_increase = true,
 	},
 
+
 	// Then VBlank
 	{
 		.per_stream_pstate_method = { dml2_pstate_method_vblank, dml2_pstate_method_na, dml2_pstate_method_na, dml2_pstate_method_na },
@@ -53,6 +54,7 @@ static const struct dml2_pmo_pstate_strategy base_strategy_list_2_display[] = {
 		.allow_state_increase = true,
 	},
 
+
 	// Then VActive + VBlank
 	{
 		.per_stream_pstate_method = { dml2_pstate_method_vactive, dml2_pstate_method_vblank, dml2_pstate_method_na, dml2_pstate_method_na },
@@ -113,6 +115,7 @@ static const struct dml2_pmo_pstate_strategy base_strategy_list_3_display[] = {
 		.allow_state_increase = true,
 	},
 
+
 	// VActive + 1 VBlank
 	{
 		.per_stream_pstate_method = { dml2_pstate_method_vactive, dml2_pstate_method_vactive, dml2_pstate_method_vblank, dml2_pstate_method_na },
@@ -149,6 +152,7 @@ static const struct dml2_pmo_pstate_strategy base_strategy_list_4_display[] = {
 		.allow_state_increase = true,
 	},
 
+
 	// VActive + 1 VBlank
 	{
 		.per_stream_pstate_method = { dml2_pstate_method_vactive, dml2_pstate_method_vactive, dml2_pstate_method_vactive, dml2_pstate_method_vblank },
@@ -1651,6 +1655,7 @@ static bool validate_pstate_support_strategy_cofunctionality(struct dml2_pmo_ins
 	if (svp_count > 0 && (pmo->options->disable_svp || !all_timings_support_svp(pmo, display_cfg, svp_stream_mask)))
 		return false;
 
+
 	return is_config_schedulable(pmo, display_cfg, pstate_strategy);
 }
 
@@ -1980,6 +1985,7 @@ static void reset_display_configuration(struct display_configuation_with_meta *d
 	}
 }
 
+
 static void setup_planes_for_drr_by_mask(struct display_configuation_with_meta *display_config,
 	struct dml2_pmo_instance *pmo,
 	int plane_mask)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
index 55d2464365d0..4d687fa86caa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c
@@ -3,8 +3,8 @@
 // Copyright 2024 Advanced Micro Devices, Inc.
 
 #include "dml2_pmo_factory.h"
-#include "dml2_pmo_dcn4_fams2.h"
 #include "dml2_pmo_dcn3.h"
+#include "dml2_pmo_dcn4_fams2.h"
 #include "dml2_external_lib_deps.h"
 
 static bool dummy_init_for_stutter(struct dml2_pmo_init_for_stutter_in_out *in_out)
@@ -37,6 +37,7 @@ bool dml2_pmo_create(enum dml2_project_id project_id, struct dml2_pmo_instance *
 		out->optimize_dcc_mcache = pmo_dcn4_fams2_optimize_dcc_mcache;
 		result = true;
 		break;
+	case dml2_project_dcn40:
 	case dml2_project_dcn4x_stage2:
 		out->initialize = pmo_dcn3_initialize;
 
@@ -56,6 +57,7 @@ bool dml2_pmo_create(enum dml2_project_id project_id, struct dml2_pmo_instance *
 
 		result = true;
 		break;
+	case dml2_project_dcn42:
 	case dml2_project_dcn4x_stage2_auto_drr_svp:
 		out->initialize = pmo_dcn4_fams2_initialize;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.h
index b90f6263cd85..7218de1824cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.h
@@ -10,4 +10,4 @@
 
 bool dml2_pmo_create(enum dml2_project_id project_id, struct dml2_pmo_instance *out);
 
-#endif
\ No newline at end of file
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c
index 04860b6790df..a6c5031f69c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_interfaces.c
@@ -17,6 +17,7 @@ bool dml2_initialize_instance(struct dml2_initialize_instance_in_out *in_out)
 	case dml2_project_dcn4x_stage1:
 	case dml2_project_dcn4x_stage2:
 	case dml2_project_dcn4x_stage2_auto_drr_svp:
+	case dml2_project_dcn40:
 	case dml2_project_dcn42:
 		return dml2_top_soc15_initialize_instance(in_out);
 	case dml2_project_invalid:
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.c
index 5e14d85821e2..0e3177fe9d27 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.c
@@ -3,7 +3,6 @@
 // Copyright 2024 Advanced Micro Devices, Inc.
 
 #include "dml2_top_legacy.h"
-#include "dml2_top_soc15.h"
 #include "dml2_core_factory.h"
 #include "dml2_pmo_factory.h"
 #include "display_mode_core_structs.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
index a6bd75f30d20..d328d92240b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
@@ -410,6 +410,7 @@ struct dml2_core_mode_support_in_out {
 	} legacy;
 };
 
+
 struct dml2_core_mode_programming_in_out {
 	/*
 	* Inputs
@@ -501,6 +502,7 @@ struct dml2_core_instance {
 	bool (*populate_informative)(struct dml2_core_populate_informative_in_out *in_out);
 	bool (*calculate_mcache_allocation)(struct dml2_calculate_mcache_allocation_in_out *in_out);
 
+
 	struct {
 		struct dml2_core_internal_display_mode_lib mode_lib;
 	} clean_me_up;
@@ -753,6 +755,7 @@ struct dml2_pmo_instance {
 	bool (*test_for_stutter)(struct dml2_pmo_test_for_stutter_in_out *in_out);
 	bool (*optimize_for_stutter)(struct dml2_pmo_optimize_for_stutter_in_out *in_out);
 
+
 	struct dml2_pmo_init_data init_data;
 	struct dml2_pmo_scratch scratch;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
index 307186eb6af0..408559d6fb2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
@@ -84,8 +84,9 @@ static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_op
 bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options *config, struct dml2_context **dml2)
 {
 	// TODO : Temporarily add DCN_VERSION_3_2 for N-1 validation. Remove DCN_VERSION_3_2 after N-1 validation phase is complete.
-	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version >= DCN_VERSION_4_01))
+	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version >= DCN_VERSION_4_01)) {
 		return dml21_create(in_dc, dml2, config);
+	}
 
 	// Allocate Mode Lib Ctx
 	*dml2 = dml2_allocate_memory();
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
index 82eca0e7b7d0..3284084ca7ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c
@@ -132,6 +132,8 @@ static void dpp3_power_on_gamcor_lut(
 	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm) {
 		if (power_on) {
 			REG_UPDATE(CM_MEM_PWR_CTRL, GAMCOR_MEM_PWR_FORCE, 0);
+			if (dpp_base->ctx->dc->caps.ips_v2_support)
+				REG_UPDATE(CM_MEM_PWR_CTRL, GAMCOR_MEM_PWR_DIS, 1);
 			REG_WAIT(CM_MEM_PWR_STATUS, GAMCOR_MEM_PWR_STATE, 0, 1, 5);
 		} else {
 			dpp_base->ctx->dc->optimized_required = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index a62c4733ed3b..41fe8d33efb4 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -155,6 +155,11 @@ static void dpp401_power_on_dscl(
 	if (dpp->tf_regs->DSCL_MEM_PWR_CTRL) {
 		if (power_on) {
 			REG_UPDATE(DSCL_MEM_PWR_CTRL, LUT_MEM_PWR_FORCE, 0);
+			if (dpp->base.ctx->dc->caps.ips_v2_support) {
+				/*hw default changes to LS*/
+				REG_UPDATE(DSCL_MEM_PWR_CTRL, LUT_MEM_PWR_DIS, 1);
+				REG_WAIT(DSCL_MEM_PWR_STATUS, LUT_MEM_PWR_STATE, 0, 1, 100);
+			} else
 			REG_WAIT(DSCL_MEM_PWR_STATUS, LUT_MEM_PWR_STATE, 0, 1, 5);
 		} else {
 			if (dpp->base.ctx->dc->debug.enable_mem_low_power.bits.dscl) {
@@ -956,6 +961,15 @@ static void dpp401_dscl_program_isharp(struct dpp *dpp_base,
 	*bs_coeffs_updated = false;
 
 	PERF_TRACE();
+	/*power on isharp_delta_mem first*/
+	if (dpp_base->ctx->dc->caps.ips_v2_support) {
+		/*HW default is LS, need to wake up*/
+		REG_UPDATE_2(ISHARP_DELTA_LUT_MEM_PWR_CTRL,
+					ISHARP_DELTA_LUT_MEM_PWR_FORCE, 0,
+					ISHARP_DELTA_LUT_MEM_PWR_DIS, 1);
+		REG_WAIT(ISHARP_DELTA_LUT_MEM_PWR_CTRL,
+			ISHARP_DELTA_LUT_MEM_PWR_STATE, 0, 1, 100);
+	}
 	/* ISHARP_MODE */
 	REG_SET_6(ISHARP_MODE, 0,
 		ISHARP_EN, scl_data->dscl_prog_data.isharp_en,
@@ -1033,6 +1047,13 @@ static void dpp401_dscl_program_isharp(struct dpp *dpp_base,
 		}
 	}
 
+	/*power on isharp_delta_mem first*/
+	if (dpp_base->ctx->dc->caps.ips_v2_support) {
+		/*HW default is LS, need to wake up*/
+		REG_UPDATE_SEQ_2(ISHARP_DELTA_LUT_MEM_PWR_CTRL,
+					ISHARP_DELTA_LUT_MEM_PWR_FORCE, 0,
+					ISHARP_DELTA_LUT_MEM_PWR_DIS, 0);
+	}
 	PERF_TRACE();
 } // dpp401_dscl_program_isharp
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c
index 759b453385c4..92ed130aeaec 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -640,6 +640,11 @@ static void dcn31_hpo_dp_stream_enc_audio_setup(
 	REG_UPDATE(DP_STREAM_ENC_AUDIO_CONTROL,
 			DP_STREAM_ENC_INPUT_MUX_AUDIO_STREAM_SOURCE_SEL, az_inst);
 
+	if (enc3->hpo_se_mask->DP_STREAM_ENC_APG_CLOCK_EN) {
+		/*enable apg clk*/
+		REG_UPDATE(DP_STREAM_ENC_AUDIO_CONTROL,
+				DP_STREAM_ENC_APG_CLOCK_EN, 1);
+	}
 	ASSERT(enc->apg);
 	enc->apg->funcs->se_audio_setup(enc->apg, az_inst, info);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index c205500290ec..4985e885952d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -41,12 +41,12 @@
 	hubp2->hubp_shift->field_name, hubp2->hubp_mask->field_name
 
 void hubp401_program_3dlut_fl_addr(struct hubp *hubp,
-	const struct dc_plane_address address)
+	const struct dc_plane_address *address)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
-	REG_UPDATE(HUBP_3DLUT_ADDRESS_HIGH, HUBP_3DLUT_ADDRESS_HIGH, address.lut3d.addr.high_part);
-	REG_WRITE(HUBP_3DLUT_ADDRESS_LOW, address.lut3d.addr.low_part);
+	REG_UPDATE(HUBP_3DLUT_ADDRESS_HIGH, HUBP_3DLUT_ADDRESS_HIGH, address->lut3d.addr.high_part);
+	REG_WRITE(HUBP_3DLUT_ADDRESS_LOW, address->lut3d.addr.low_part);
 }
 
 void hubp401_program_3dlut_fl_dlg_param(struct hubp *hubp, int refcyc_per_3dlut_group)
@@ -72,33 +72,46 @@ int hubp401_get_3dlut_fl_done(struct hubp *hubp)
 	return ret;
 }
 
-void hubp401_program_3dlut_fl_addressing_mode(struct hubp *hubp, enum hubp_3dlut_fl_addressing_mode addr_mode)
+static void hubp401_get_3dlut_fl_xbar_map(
+		const enum dc_cm_lut_pixel_format format,
+		enum hubp_3dlut_fl_crossbar_bit_slice *bit_slice_y_g,
+		enum hubp_3dlut_fl_crossbar_bit_slice *bit_slice_cb_b,
+		enum hubp_3dlut_fl_crossbar_bit_slice *bit_slice_cr_r)
 {
-	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
-
-	REG_UPDATE(HUBP_3DLUT_CONTROL, HUBP_3DLUT_ADDRESSING_MODE, addr_mode);
-}
-
-void hubp401_program_3dlut_fl_width(struct hubp *hubp, enum hubp_3dlut_fl_width width)
-{
-	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
-
-	REG_UPDATE(HUBP_3DLUT_CONTROL, HUBP_3DLUT_WIDTH, width);
+	switch (format) {
+	case CM_LUT_PIXEL_FORMAT_BGRA16161616_UNORM_12MSB:
+	case CM_LUT_PIXEL_FORMAT_BGRA16161616_UNORM_12LSB:
+	case CM_LUT_PIXEL_FORMAT_BGRA16161616_FLOAT_FP1_5_10:
+		/* BGRA */
+		*bit_slice_cr_r = hubp_3dlut_fl_crossbar_bit_slice_32_47;
+		*bit_slice_y_g = hubp_3dlut_fl_crossbar_bit_slice_16_31;
+		*bit_slice_cb_b =  hubp_3dlut_fl_crossbar_bit_slice_0_15;
+		break;
+	case CM_LUT_PIXEL_FORMAT_RGBA16161616_UNORM_12MSB:
+	case CM_LUT_PIXEL_FORMAT_RGBA16161616_UNORM_12LSB:
+	case CM_LUT_PIXEL_FORMAT_RGBA16161616_FLOAT_FP1_5_10:
+	default:
+		/* RGBA */
+		*bit_slice_cr_r = hubp_3dlut_fl_crossbar_bit_slice_0_15;
+		*bit_slice_y_g = hubp_3dlut_fl_crossbar_bit_slice_16_31;
+		*bit_slice_cb_b = hubp_3dlut_fl_crossbar_bit_slice_32_47;
+		break;
+	}
 }
 
-void hubp401_program_3dlut_fl_tmz_protected(struct hubp *hubp, uint8_t protection_bits)
+void hubp401_program_3dlut_fl_crossbar(struct hubp *hubp,
+		const enum dc_cm_lut_pixel_format format)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
-	REG_UPDATE(HUBP_3DLUT_CONTROL, HUBP_3DLUT_TMZ, protection_bits);
-}
+	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_y_g = 0;
+	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cb_b = 0;
+	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cr_r = 0;
 
-void hubp401_program_3dlut_fl_crossbar(struct hubp *hubp,
-			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_y_g,
-			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cb_b,
-			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cr_r)
-{
-	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+	hubp401_get_3dlut_fl_xbar_map(format,
+			&bit_slice_y_g,
+			&bit_slice_cb_b,
+			&bit_slice_cr_r);
 
 	REG_UPDATE_3(HUBP_3DLUT_CONTROL,
 			HUBP_3DLUT_CROSSBAR_SELECT_Y_G, bit_slice_y_g,
@@ -106,62 +119,122 @@ void hubp401_program_3dlut_fl_crossbar(struct hubp *hubp,
 			HUBP_3DLUT_CROSSBAR_SELECT_CR_R, bit_slice_cr_r);
 }
 
-void hubp401_update_3dlut_fl_bias_scale(struct hubp *hubp, uint16_t bias, uint16_t scale)
+static enum hubp_3dlut_fl_width hubp401_get_3dlut_fl_width(
+		const enum dc_cm_lut_size size,
+		const enum dc_cm_lut_swizzle swizzle)
 {
-	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+	enum hubp_3dlut_fl_width width = 0;
+
+	switch (size) {
+	case CM_LUT_SIZE_333333:
+		ASSERT(swizzle != CM_LUT_1D_PACKED_LINEAR);
+		width = hubp_3dlut_fl_width_33;
+		break;
+	case CM_LUT_SIZE_171717:
+		if (swizzle != CM_LUT_1D_PACKED_LINEAR) {
+			width = hubp_3dlut_fl_width_17;
+		} else {
+			width = hubp_3dlut_fl_width_17_transformed;
+		}
+		break;
+	default:
+		width = 0;
+		break;
+	}
 
-	REG_UPDATE_2(_3DLUT_FL_BIAS_SCALE, HUBP0_3DLUT_FL_BIAS, bias, HUBP0_3DLUT_FL_SCALE, scale);
+	return width;
 }
 
-void hubp401_program_3dlut_fl_mode(struct hubp *hubp, enum hubp_3dlut_fl_mode mode)
+static enum hubp_3dlut_fl_format hubp401_get_3dlut_fl_format(
+		const enum dc_cm_lut_pixel_format dc_format)
 {
-	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+	enum hubp_3dlut_fl_format hubp_format = hubp_3dlut_fl_format_unorm_12msb_bitslice;
 
-	REG_UPDATE(_3DLUT_FL_CONFIG, HUBP0_3DLUT_FL_MODE, mode);
+	switch (dc_format) {
+	case CM_LUT_PIXEL_FORMAT_RGBA16161616_UNORM_12MSB:
+	case CM_LUT_PIXEL_FORMAT_BGRA16161616_UNORM_12MSB:
+		hubp_format = hubp_3dlut_fl_format_unorm_12msb_bitslice;
+		break;
+	case CM_LUT_PIXEL_FORMAT_RGBA16161616_UNORM_12LSB:
+	case CM_LUT_PIXEL_FORMAT_BGRA16161616_UNORM_12LSB:
+		hubp_format = hubp_3dlut_fl_format_unorm_12lsb_bitslice;
+		break;
+	case CM_LUT_PIXEL_FORMAT_RGBA16161616_FLOAT_FP1_5_10:
+	case CM_LUT_PIXEL_FORMAT_BGRA16161616_FLOAT_FP1_5_10:
+		hubp_format = hubp_3dlut_fl_format_float_fp1_5_10;
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		break;
+	}
+
+	return hubp_format;
 }
 
-void hubp401_program_3dlut_fl_format(struct hubp *hubp, enum hubp_3dlut_fl_format format)
+static enum hubp_3dlut_fl_addressing_mode hubp401_get_3dlut_fl_addr_mode(
+		const enum dc_cm_lut_swizzle swizzle)
 {
-	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+	enum hubp_3dlut_fl_addressing_mode addr_mode;
+
+	switch (swizzle) {
+	case CM_LUT_1D_PACKED_LINEAR:
+		addr_mode = hubp_3dlut_fl_addressing_mode_simple_linear;
+		break;
+	case CM_LUT_3D_SWIZZLE_LINEAR_RGB:
+	case CM_LUT_3D_SWIZZLE_LINEAR_BGR:
+	default:
+		addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
+		break;
+	}
 
-	REG_UPDATE(_3DLUT_FL_CONFIG, HUBP0_3DLUT_FL_FORMAT, format);
+	return addr_mode;
 }
 
-void hubp401_program_3dlut_fl_config(
-	struct hubp *hubp,
-	struct hubp_fl_3dlut_config *cfg)
+static enum hubp_3dlut_fl_mode hubp401_get_3dlut_fl_mode(
+		const enum dc_cm_lut_swizzle swizzle)
 {
-	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+	enum hubp_3dlut_fl_mode mode;
 
-	uint32_t mpc_width = {(cfg->width == 17) ? 0 : 1};
-	uint32_t width = {cfg->width};
+	switch (swizzle) {
+	case CM_LUT_3D_SWIZZLE_LINEAR_RGB:
+		mode = hubp_3dlut_fl_mode_native_1;
+		break;
+	case CM_LUT_3D_SWIZZLE_LINEAR_BGR:
+		mode = hubp_3dlut_fl_mode_native_2;
+		break;
+	case CM_LUT_1D_PACKED_LINEAR:
+		mode = hubp_3dlut_fl_mode_transform;
+		break;
+	default:
+		mode = hubp_3dlut_fl_mode_disable;
+		break;
+	}
 
-	if (cfg->layout == DC_CM2_GPU_MEM_LAYOUT_1D_PACKED_LINEAR)
-		width = (cfg->width == 17) ? 4916 : 35940;
+	return mode;
+}
+
+void hubp401_program_3dlut_fl_config(struct hubp *hubp,
+		const struct dc_3dlut_dma *config)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	enum hubp_3dlut_fl_width width = hubp401_get_3dlut_fl_width(config->size, config->swizzle);
+	enum hubp_3dlut_fl_format format = hubp401_get_3dlut_fl_format(config->format);
+	enum hubp_3dlut_fl_addressing_mode addr_mode = hubp401_get_3dlut_fl_addr_mode(config->swizzle);
+	enum hubp_3dlut_fl_mode mode = hubp401_get_3dlut_fl_mode(config->swizzle);
 
 	REG_UPDATE_2(_3DLUT_FL_CONFIG,
-		HUBP0_3DLUT_FL_MODE, cfg->mode,
-		HUBP0_3DLUT_FL_FORMAT, cfg->format);
+			HUBP0_3DLUT_FL_MODE, mode,
+			HUBP0_3DLUT_FL_FORMAT, format);
 
 	REG_UPDATE_2(_3DLUT_FL_BIAS_SCALE,
-		HUBP0_3DLUT_FL_BIAS, cfg->bias,
-		HUBP0_3DLUT_FL_SCALE, cfg->scale);
-
-	REG_UPDATE(HUBP_3DLUT_ADDRESS_HIGH,
-		HUBP_3DLUT_ADDRESS_HIGH, cfg->address.lut3d.addr.high_part);
-	REG_UPDATE(HUBP_3DLUT_ADDRESS_LOW,
-		HUBP_3DLUT_ADDRESS_LOW, cfg->address.lut3d.addr.low_part);
-
-	//cross bar
-	REG_UPDATE_8(HUBP_3DLUT_CONTROL,
-		HUBP_3DLUT_MPC_WIDTH, mpc_width,
-		HUBP_3DLUT_WIDTH, width,
-		HUBP_3DLUT_CROSSBAR_SELECT_CR_R, cfg->crossbar_bit_slice_cr_r,
-		HUBP_3DLUT_CROSSBAR_SELECT_Y_G, cfg->crossbar_bit_slice_y_g,
-		HUBP_3DLUT_CROSSBAR_SELECT_CB_B, cfg->crossbar_bit_slice_cb_b,
-		HUBP_3DLUT_ADDRESSING_MODE, cfg->addr_mode,
-		HUBP_3DLUT_TMZ, cfg->protection_bits,
-		HUBP_3DLUT_ENABLE, cfg->enabled ? 1 : 0);
+			HUBP0_3DLUT_FL_BIAS, config->bias,
+			HUBP0_3DLUT_FL_SCALE, config->scale);
+
+	REG_UPDATE_3(HUBP_3DLUT_CONTROL,
+			HUBP_3DLUT_WIDTH, width,
+			HUBP_3DLUT_ADDRESSING_MODE, addr_mode,
+			HUBP_3DLUT_TMZ, config->addr.tmz_surface);
 }
 
 void hubp401_update_mall_sel(struct hubp *hubp, uint32_t mall_sel, bool c_cursor)
@@ -1058,19 +1131,13 @@ static struct hubp_funcs dcn401_hubp_funcs = {
 	.hubp_update_mall_sel = hubp401_update_mall_sel,
 	.hubp_prepare_subvp_buffering = hubp32_prepare_subvp_buffering,
 	.hubp_program_mcache_id_and_split_coordinate = hubp401_program_mcache_id_and_split_coordinate,
-	.hubp_update_3dlut_fl_bias_scale = hubp401_update_3dlut_fl_bias_scale,
-	.hubp_program_3dlut_fl_mode = hubp401_program_3dlut_fl_mode,
-	.hubp_program_3dlut_fl_format = hubp401_program_3dlut_fl_format,
 	.hubp_program_3dlut_fl_addr = hubp401_program_3dlut_fl_addr,
+	.hubp_program_3dlut_fl_config = hubp401_program_3dlut_fl_config,
 	.hubp_program_3dlut_fl_dlg_param = hubp401_program_3dlut_fl_dlg_param,
 	.hubp_enable_3dlut_fl = hubp401_enable_3dlut_fl,
-	.hubp_program_3dlut_fl_addressing_mode = hubp401_program_3dlut_fl_addressing_mode,
-	.hubp_program_3dlut_fl_width = hubp401_program_3dlut_fl_width,
-	.hubp_program_3dlut_fl_tmz_protected = hubp401_program_3dlut_fl_tmz_protected,
 	.hubp_program_3dlut_fl_crossbar = hubp401_program_3dlut_fl_crossbar,
 	.hubp_get_3dlut_fl_done = hubp401_get_3dlut_fl_done,
 	.hubp_clear_tiling = hubp401_clear_tiling,
-	.hubp_program_3dlut_fl_config = hubp401_program_3dlut_fl_config,
 	.hubp_read_reg_state = hubp3_read_reg_state
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
index 4570b8016de5..043948f64b86 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
@@ -328,32 +328,17 @@ int hubp401_get_3dlut_fl_done(struct hubp *hubp);
 
 void hubp401_set_unbounded_requesting(struct hubp *hubp, bool enable);
 
-void hubp401_update_3dlut_fl_bias_scale(struct hubp *hubp, uint16_t bias, uint16_t scale);
-
 void hubp401_program_3dlut_fl_crossbar(struct hubp *hubp,
-	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_y_g,
-	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cb_b,
-	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cr_r);
-
-void hubp401_program_3dlut_fl_tmz_protected(struct hubp *hubp, uint8_t protection_bits);
-
-void hubp401_program_3dlut_fl_width(struct hubp *hubp, enum hubp_3dlut_fl_width width);
-
-void hubp401_program_3dlut_fl_addressing_mode(struct hubp *hubp, enum hubp_3dlut_fl_addressing_mode addr_mode);
+		const enum dc_cm_lut_pixel_format format);
 
 void hubp401_enable_3dlut_fl(struct hubp *hubp, bool enable);
 
 void hubp401_program_3dlut_fl_dlg_param(struct hubp *hubp, int refcyc_per_3dlut_group);
 
-void hubp401_program_3dlut_fl_addr(struct hubp *hubp, const struct dc_plane_address address);
+void hubp401_program_3dlut_fl_addr(struct hubp *hubp, const struct dc_plane_address *address);
 
-void hubp401_program_3dlut_fl_format(struct hubp *hubp, enum hubp_3dlut_fl_format format);
-
-void hubp401_program_3dlut_fl_mode(struct hubp *hubp, enum hubp_3dlut_fl_mode mode);
-
-void hubp401_program_3dlut_fl_config(
-	struct hubp *hubp,
-	struct hubp_fl_3dlut_config *cfg);
+void hubp401_program_3dlut_fl_config(struct hubp *hubp,
+		const struct dc_3dlut_dma *config);
 
 void hubp401_clear_tiling(struct hubp *hubp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
index 07c38dc03960..0e33c739f459 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
@@ -147,13 +147,16 @@ static void hubp42_program_pixel_format(
 	/* don't see the need of program the xbar in DCN 1.0 */
 }
 
-void hubp42_program_deadline(
+static void hubp42_program_deadline(
 		struct hubp *hubp,
 		struct dml2_display_dlg_regs *dlg_attr,
 		struct dml2_display_ttu_regs *ttu_attr)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
+	/* put DLG in mission mode */
+	REG_WRITE(HUBPREQ_DEBUG_DB, 0);
+
 	/* DLG - Per hubp */
 	REG_SET_2(BLANK_OFFSET_0, 0,
 		REFCYC_H_BLANK_END, dlg_attr->refcyc_h_blank_end,
@@ -274,19 +277,84 @@ static void hubp42_program_surface_config(
 	hubp42_program_pixel_format(hubp, format);
 }
 
+static void hubp42_get_3dlut_fl_xbar_map(
+		const enum dc_cm_lut_pixel_format format,
+		enum hubp_3dlut_fl_crossbar_bit_slice *bit_slice_y_g,
+		enum hubp_3dlut_fl_crossbar_bit_slice *bit_slice_cb_b,
+		enum hubp_3dlut_fl_crossbar_bit_slice *bit_slice_cr_r)
+{
+	switch (format) {
+	case CM_LUT_PIXEL_FORMAT_BGRA16161616_UNORM_12MSB:
+	case CM_LUT_PIXEL_FORMAT_BGRA16161616_UNORM_12LSB:
+	case CM_LUT_PIXEL_FORMAT_BGRA16161616_FLOAT_FP1_5_10:
+		/* BGRA */
+		*bit_slice_cr_r = hubp_3dlut_fl_crossbar_bit_slice_32_47;
+		*bit_slice_y_g = hubp_3dlut_fl_crossbar_bit_slice_16_31;
+		*bit_slice_cb_b =  hubp_3dlut_fl_crossbar_bit_slice_0_15;
+		break;
+	case CM_LUT_PIXEL_FORMAT_RGBA16161616_UNORM_12MSB:
+	case CM_LUT_PIXEL_FORMAT_RGBA16161616_UNORM_12LSB:
+	case CM_LUT_PIXEL_FORMAT_RGBA16161616_FLOAT_FP1_5_10:
+	default:
+		/* RGBA */
+		*bit_slice_cr_r = hubp_3dlut_fl_crossbar_bit_slice_0_15;
+		*bit_slice_y_g = hubp_3dlut_fl_crossbar_bit_slice_16_31;
+		*bit_slice_cb_b = hubp_3dlut_fl_crossbar_bit_slice_32_47;
+		break;
+	}
+}
+
 void hubp42_program_3dlut_fl_crossbar(struct hubp *hubp,
-	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_r,
-	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_g,
-	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_b)
+		const enum dc_cm_lut_pixel_format format)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
+	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_g = 0;
+	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_b = 0;
+	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_r = 0;
+
+	hubp42_get_3dlut_fl_xbar_map(format,
+			&bit_slice_g,
+			&bit_slice_b,
+			&bit_slice_r);
+
 	REG_UPDATE_3(HUBP_3DLUT_CONTROL,
 		HUBP_3DLUT_CROSSBAR_SEL_R, bit_slice_r,
 		HUBP_3DLUT_CROSSBAR_SEL_G, bit_slice_g,
 		HUBP_3DLUT_CROSSBAR_SEL_B, bit_slice_b);
 }
 
+static uint32_t hubp42_get_3dlut_fl_mpc_width(
+		const enum dc_cm_lut_size size)
+{
+	uint32_t width = 0;
+
+	switch (size) {
+	case CM_LUT_SIZE_333333:
+		width = 1;
+		break;
+	case CM_LUT_SIZE_171717:
+	default:
+		width = 0;
+		break;
+	}
+
+	return width;
+}
+
+void hubp42_program_3dlut_fl_config(struct hubp *hubp,
+		const struct dc_3dlut_dma *config)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	uint32_t mpc_width = hubp42_get_3dlut_fl_mpc_width(config->size);
+
+	REG_UPDATE(HUBP_3DLUT_CONTROL,
+			HUBP_3DLUT_MPC_WIDTH, mpc_width);
+
+	hubp401_program_3dlut_fl_config(hubp, config);
+}
+
 static bool hubp42_program_surface_flip_and_addr(
 	struct hubp *hubp,
 	const struct dc_plane_address *address,
@@ -548,6 +616,7 @@ struct hubp_funcs dcn42_hubp_funcs = {
 	.hubp_setup_interdependent2 = hubp401_setup_interdependent,
 	.hubp_set_vm_system_aperture_settings = hubp3_set_vm_system_aperture_settings,
 	.set_blank = hubp2_set_blank,
+	.set_blank_regs = hubp2_set_blank_regs,
 	.dcc_control = hubp3_dcc_control,
 	.hubp_reset = hubp_reset,
 	.mem_program_viewport = min_set_viewport,
@@ -567,17 +636,13 @@ struct hubp_funcs dcn42_hubp_funcs = {
 	.hubp_set_flip_int = hubp1_set_flip_int,
 	.hubp_in_blank = hubp1_in_blank,
 	.program_extended_blank = hubp31_program_extended_blank_value,
-	.hubp_update_3dlut_fl_bias_scale = hubp401_update_3dlut_fl_bias_scale,
-	.hubp_program_3dlut_fl_mode = hubp401_program_3dlut_fl_mode,
-	.hubp_program_3dlut_fl_format = hubp401_program_3dlut_fl_format,
 	.hubp_program_3dlut_fl_addr = hubp401_program_3dlut_fl_addr,
+	.hubp_program_3dlut_fl_config = hubp42_program_3dlut_fl_config,
 	.hubp_program_3dlut_fl_dlg_param = hubp401_program_3dlut_fl_dlg_param,
 	.hubp_enable_3dlut_fl = hubp401_enable_3dlut_fl,
-	.hubp_program_3dlut_fl_addressing_mode = hubp401_program_3dlut_fl_addressing_mode,
-	.hubp_program_3dlut_fl_width = hubp401_program_3dlut_fl_width,
-	.hubp_program_3dlut_fl_tmz_protected = hubp401_program_3dlut_fl_tmz_protected,
 	.hubp_program_3dlut_fl_crossbar = hubp42_program_3dlut_fl_crossbar,
 	.hubp_get_3dlut_fl_done = hubp401_get_3dlut_fl_done,
+	.hubp_clear_tiling = hubp3_clear_tiling,
 	.hubp_program_3dlut_fl_config = hubp401_program_3dlut_fl_config,
 	.hubp_read_reg_state = hubp3_read_reg_state
 };
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
index 976614f38981..486c8907413a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
@@ -56,11 +56,11 @@ bool hubp42_construct(
 	const struct dcn_hubp2_shift *hubp_shift,
 	const struct dcn_hubp2_mask *hubp_mask);
 
-void hubp42_program_3dlut_fl_crossbar(
-	struct hubp *hubp,
-	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_r,
-	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_g,
-	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_b);
+void hubp42_program_3dlut_fl_crossbar(struct hubp *hubp,
+		const enum dc_cm_lut_pixel_format format);
+
+void hubp42_program_3dlut_fl_config(struct hubp *hubp,
+		const struct dc_3dlut_dma *config);
 
 void hubp42_read_state(struct hubp *hubp);
 
@@ -70,10 +70,4 @@ void hubp42_setup(
 		union dml2_global_sync_programming *pipe_global_sync,
 		struct dc_crtc_timing *timing);
 
-void hubp42_program_deadline(
-		struct hubp *hubp,
-		struct dml2_display_dlg_regs *dlg_attr,
-		struct dml2_display_ttu_regs *ttu_attr);
-
-
 #endif /* __DC_HUBP_DCN42_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 38a5f312ddb4..420b9aa206e7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -661,45 +661,15 @@ void dce110_update_info_frame(struct pipe_ctx *pipe_ctx)
 }
 
 static void
-dce110_external_encoder_control(enum bp_external_encoder_control_action action,
-				struct dc_link *link,
-				struct dc_crtc_timing *timing)
+dce110_dac_encoder_control(struct pipe_ctx *pipe_ctx, bool enable)
 {
-	struct dc *dc = link->ctx->dc;
+	struct dc_link *link = pipe_ctx->stream->link;
 	struct dc_bios *bios = link->ctx->dc_bios;
-	const struct dc_link_settings *link_settings = &link->cur_link_settings;
-	enum bp_result bp_result = BP_RESULT_OK;
-	struct bp_external_encoder_control ext_cntl = {
-		.action = action,
-		.connector_obj_id = link->link_enc->connector,
-		.encoder_id = link->ext_enc_id,
-		.lanes_number = link_settings->lane_count,
-		.link_rate = link_settings->link_rate,
-
-		/* Use signal type of the real link encoder, ie. DP */
-		.signal = link->connector_signal,
-
-		/* We don't know the timing yet when executing the SETUP action,
-		 * so use a reasonably high default value. It seems that ENABLE
-		 * can change the actual pixel clock but doesn't work with higher
-		 * pixel clocks than what SETUP was called with.
-		 */
-		.pixel_clock = timing ? timing->pix_clk_100hz / 10 : 300000,
-		.color_depth = timing ? timing->display_color_depth : COLOR_DEPTH_888,
-	};
-	DC_LOGGER_INIT(dc->ctx);
-
-	bp_result = bios->funcs->external_encoder_control(bios, &ext_cntl);
-
-	if (bp_result != BP_RESULT_OK)
-		DC_LOG_ERROR("Failed to execute external encoder action: 0x%x\n", action);
-}
-
-static void
-dce110_prepare_ddc(struct dc_link *link)
-{
-	if (link->ext_enc_id.id)
-		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_DDC_SETUP, link, NULL);
+	struct bp_encoder_control encoder_control = {0};
+	encoder_control.action = enable ? ENCODER_CONTROL_ENABLE : ENCODER_CONTROL_DISABLE;
+	encoder_control.engine_id = link->link_enc->analog_engine;
+	encoder_control.pixel_clock = pipe_ctx->stream->timing.pix_clk_100hz / 10;
+	bios->funcs->encoder_control(bios, &encoder_control);
 }
 
 static bool
@@ -709,8 +679,7 @@ dce110_dac_load_detect(struct dc_link *link)
 	struct link_encoder *link_enc = link->link_enc;
 	enum bp_result bp_result;
 
-	bp_result = bios->funcs->dac_load_detection(
-			bios, link_enc->analog_engine, link->ext_enc_id);
+	bp_result = bios->funcs->dac_load_detection(bios, link_enc->analog_engine);
 	return bp_result == BP_RESULT_OK;
 }
 
@@ -726,6 +695,7 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 	uint32_t early_control = 0;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 
+	link_hwss->setup_stream_attribute(pipe_ctx);
 	link_hwss->setup_stream_encoder(pipe_ctx);
 
 	dc->hwss.update_info_frame(pipe_ctx);
@@ -744,8 +714,8 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 
 	tg->funcs->set_early_control(tg, early_control);
 
-	if (link->ext_enc_id.id)
-		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_ENABLE, link, timing);
+	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
+		dce110_dac_encoder_control(pipe_ctx, true);
 }
 
 static enum bp_result link_transmitter_control(
@@ -1244,8 +1214,8 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 					       link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
 
-	if (link->ext_enc_id.id)
-		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_DISABLE, link, NULL);
+	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
+		dce110_dac_encoder_control(pipe_ctx, false);
 }
 
 void dce110_unblank_stream(struct pipe_ctx *pipe_ctx,
@@ -1627,6 +1597,22 @@ static enum dc_status dce110_enable_stream_timing(
 
 	return DC_OK;
 }
+static void
+dce110_select_crtc_source(struct pipe_ctx *pipe_ctx)
+{
+	struct dc_link *link = pipe_ctx->stream->link;
+	struct dc_bios *bios = link->ctx->dc_bios;
+	struct bp_crtc_source_select crtc_source_select = {0};
+	enum engine_id engine_id = link->link_enc->preferred_engine;
+
+	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
+		engine_id = link->link_enc->analog_engine;
+	crtc_source_select.controller_id = CONTROLLER_ID_D0 + pipe_ctx->stream_res.tg->inst;
+	crtc_source_select.color_depth = pipe_ctx->stream->timing.display_color_depth;
+	crtc_source_select.engine_id = engine_id;
+	crtc_source_select.sink_signal = pipe_ctx->stream->signal;
+	bios->funcs->select_crtc_source(bios, &crtc_source_select);
+}
 
 enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		struct pipe_ctx *pipe_ctx,
@@ -1647,6 +1633,10 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		hws->funcs.disable_stream_gating(dc, pipe_ctx);
 	}
 
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_RGB) {
+		dce110_select_crtc_source(pipe_ctx);
+	}
+
 	if (pipe_ctx->stream_res.audio != NULL) {
 		struct audio_output audio_output = {0};
 
@@ -1726,7 +1716,8 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		pipe_ctx->stream_res.tg->funcs->set_static_screen_control(
 				pipe_ctx->stream_res.tg, event_triggers, 2);
 
-	if (!dc_is_virtual_signal(pipe_ctx->stream->signal))
+	if (!dc_is_virtual_signal(pipe_ctx->stream->signal) &&
+		!dc_is_rgb_signal(pipe_ctx->stream->signal))
 		pipe_ctx->stream_res.stream_enc->funcs->dig_connect_to_otg(
 			pipe_ctx->stream_res.stream_enc,
 			pipe_ctx->stream_res.tg->inst);
@@ -1948,6 +1939,34 @@ static void clean_up_dsc_blocks(struct dc *dc)
 	}
 }
 
+static void dc_hwss_enable_otg_pwa(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx)
+{
+	struct timing_generator *tg = NULL;
+
+	if (dc->debug.enable_otg_frame_sync_pwa == 0)
+		return;
+
+	if (pipe_ctx == NULL || pipe_ctx->stream_res.tg == NULL)
+			return;
+	tg = pipe_ctx->stream_res.tg;
+
+	/*only enable this if one active*/
+	if (tg->funcs->enable_otg_pwa) {
+		struct otc_pwa_frame_sync pwa_param = {0} ;
+
+		DC_LOGGER_INIT(dc->ctx);
+		/*mode 1 to choose generate pwa sync signal on line 0 counting
+		from vstartup at very begining of the frame*/
+		pwa_param.pwa_frame_sync_line_offset = 0;
+		pwa_param.pwa_sync_mode = DC_OTG_PWA_FRAME_SYNC_MODE_VSTARTUP;
+		/*frame sync line for generating high frame sync*/
+		tg->funcs->enable_otg_pwa(tg, &pwa_param);
+		DC_LOG_DC("Enable OTG PWA frame sync on TG %d\n", tg->inst);
+	}
+}
+
 /*
  * When ASIC goes from VBIOS/VGA mode to driver/accelerated mode we need:
  *  1. Power down all DC HW blocks
@@ -2024,6 +2043,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 						// If VBios supports it, we check it from reigster or other flags.
 						pipe_ctx->stream_res.pix_clk_params.dio_se_pix_per_cycle = 1;
 					}
+					dc_hwss_enable_otg_pwa(dc, pipe_ctx);
 				}
 				break;
 			}
@@ -2593,6 +2613,18 @@ enum dc_status dce110_apply_ctx_to_hw(
 #endif
 	}
 
+
+	if (dc->debug.enable_otg_frame_sync_pwa && context->stream_count == 1) {
+		/* only enable this on one OTG*/
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+			if (pipe_ctx && pipe_ctx->stream != NULL) {
+				dc_hwss_enable_otg_pwa(dc, pipe_ctx);
+				break;
+			}
+		}
+	}
 	if (dc->fbc_compressor)
 		enable_fbc(dc, dc->current_state);
 
@@ -3320,15 +3352,6 @@ void dce110_enable_tmds_link_output(struct dc_link *link,
 	link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
 }
 
-static void dce110_enable_analog_link_output(
-		struct dc_link *link,
-		uint32_t pix_clk_100hz)
-{
-	link->link_enc->funcs->enable_analog_output(
-			link->link_enc,
-			pix_clk_100hz);
-}
-
 void dce110_enable_dp_link_output(
 		struct dc_link *link,
 		const struct link_resource *link_res,
@@ -3376,11 +3399,6 @@ void dce110_enable_dp_link_output(
 		}
 	}
 
-	if (link->ext_enc_id.id) {
-		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_INIT, link, NULL);
-		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_SETUP, link, NULL);
-	}
-
 	if (dc->link_srv->dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING) {
 		if (dc->clk_mgr->funcs->notify_link_rate_change)
 			dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
@@ -3471,10 +3489,8 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
 	.enable_tmds_link_output = dce110_enable_tmds_link_output,
 	.enable_dp_link_output = dce110_enable_dp_link_output,
-	.enable_analog_link_output = dce110_enable_analog_link_output,
 	.disable_link_output = dce110_disable_link_output,
 	.dac_load_detect = dce110_dac_load_detect,
-	.prepare_ddc = dce110_prepare_ddc,
 };
 
 static const struct hwseq_private_funcs dce110_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 55c48c4bc6ce..d47b2a16f099 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -95,10 +95,6 @@ void dcn401_program_gamut_remap(struct pipe_ctx *pipe_ctx)
 	unsigned int mpcc_id = pipe_ctx->plane_res.mpcc_inst;
 	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
 
-	//For now assert if location is not pre-blend
-	if (pipe_ctx->plane_state)
-		ASSERT(pipe_ctx->plane_state->mcm_location == MPCC_MOVABLE_CM_LOCATION_BEFORE);
-
 	// program MPCC_MCM_FIRST_GAMUT_REMAP
 	memset(&mpc_adjust, 0, sizeof(mpc_adjust));
 	mpc_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
@@ -304,6 +300,7 @@ void dcn401_init_hw(struct dc *dc)
 			}
 		}
 	}
+
 	for (i = 0; i < res_pool->audio_count; i++) {
 		struct audio *audio = res_pool->audios[i];
 
@@ -372,293 +369,179 @@ void dcn401_init_hw(struct dc *dc)
 	}
 }
 
-static void dcn401_get_mcm_lut_xable_from_pipe_ctx(struct dc *dc, struct pipe_ctx *pipe_ctx,
-		enum MCM_LUT_XABLE *shaper_xable,
-		enum MCM_LUT_XABLE *lut3d_xable,
-		enum MCM_LUT_XABLE *lut1d_xable)
+void dcn401_trigger_3dlut_dma_load(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
-	enum dc_cm2_shaper_3dlut_setting shaper_3dlut_setting = DC_CM2_SHAPER_3DLUT_SETTING_BYPASS_ALL;
-	bool lut1d_enable = false;
-	struct mpc *mpc = dc->res_pool->mpc;
-	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
-
-	if (!pipe_ctx->plane_state)
-		return;
-	shaper_3dlut_setting = pipe_ctx->plane_state->mcm_shaper_3dlut_setting;
-	lut1d_enable = pipe_ctx->plane_state->mcm_lut1d_enable;
-	mpc->funcs->set_movable_cm_location(mpc, MPCC_MOVABLE_CM_LOCATION_BEFORE, mpcc_id);
-	pipe_ctx->plane_state->mcm_location = MPCC_MOVABLE_CM_LOCATION_BEFORE;
-
-	*lut1d_xable = lut1d_enable ? MCM_LUT_ENABLE : MCM_LUT_DISABLE;
+	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 
-	switch (shaper_3dlut_setting) {
-	case DC_CM2_SHAPER_3DLUT_SETTING_BYPASS_ALL:
-		*lut3d_xable = *shaper_xable = MCM_LUT_DISABLE;
-		break;
-	case DC_CM2_SHAPER_3DLUT_SETTING_ENABLE_SHAPER:
-		*lut3d_xable = MCM_LUT_DISABLE;
-		*shaper_xable = MCM_LUT_ENABLE;
-		break;
-	case DC_CM2_SHAPER_3DLUT_SETTING_ENABLE_SHAPER_3DLUT:
-		*lut3d_xable = *shaper_xable = MCM_LUT_ENABLE;
-		break;
+	if (hubp->funcs->hubp_enable_3dlut_fl) {
+		hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
 	}
 }
 
-void dcn401_populate_mcm_luts(struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
-		struct dc_cm2_func_luts mcm_luts,
-		bool lut_bank_a)
+bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
+				const struct dc_plane_state *plane_state)
 {
+	struct dc *dc = pipe_ctx->plane_res.hubp->ctx->dc;
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
+	const struct dc_plane_cm *cm = &plane_state->cm;
 	int mpcc_id = hubp->inst;
 	struct mpc *mpc = dc->res_pool->mpc;
 	union mcm_lut_params m_lut_params;
-	enum dc_cm2_transfer_func_source lut3d_src = mcm_luts.lut3d_data.lut3d_src;
-	enum hubp_3dlut_fl_format format = 0;
-	enum hubp_3dlut_fl_mode mode;
-	enum hubp_3dlut_fl_width width = 0;
-	enum hubp_3dlut_fl_addressing_mode addr_mode;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_y_g = 0;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cb_b = 0;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cr_r = 0;
-	enum MCM_LUT_XABLE shaper_xable = MCM_LUT_DISABLE;
-	enum MCM_LUT_XABLE lut3d_xable = MCM_LUT_DISABLE;
-	enum MCM_LUT_XABLE lut1d_xable = MCM_LUT_DISABLE;
+	struct dc_3dlut_dma lut3d_dma;
+	bool lut_enable;
+	bool lut_bank_a;
 	bool rval;
+	bool result = true;
 
-	dcn401_get_mcm_lut_xable_from_pipe_ctx(dc, pipe_ctx, &shaper_xable, &lut3d_xable, &lut1d_xable);
+	/* decide LUT bank based on current in use */
+	mpc->funcs->get_lut_mode(mpc, MCM_LUT_1DLUT, mpcc_id, &lut_enable, &lut_bank_a);
+	if (!lut_enable) {
+		mpc->funcs->get_lut_mode(mpc, MCM_LUT_SHAPER, mpcc_id, &lut_enable, &lut_bank_a);
+	}
+	if (!lut_enable) {
+		mpc->funcs->get_lut_mode(mpc, MCM_LUT_3DLUT, mpcc_id, &lut_enable, &lut_bank_a);
+	}
+
+	/* switch to the next bank */
+	if (lut_enable) {
+		lut_bank_a = !lut_bank_a;
+	}
+
+	/* MCM location fixed to pre-blend */
+	mpc->funcs->set_movable_cm_location(mpc, MPCC_MOVABLE_CM_LOCATION_BEFORE, mpcc_id);
 
 	/* 1D LUT */
-	if (mcm_luts.lut1d_func) {
-		memset(&m_lut_params, 0, sizeof(m_lut_params));
-		if (mcm_luts.lut1d_func->type == TF_TYPE_HWPWL)
-			m_lut_params.pwl = &mcm_luts.lut1d_func->pwl;
-		else if (mcm_luts.lut1d_func->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			rval = cm3_helper_translate_curve_to_hw_format(mpc->ctx,
-					mcm_luts.lut1d_func,
-					&dpp_base->regamma_params, false);
+	lut_enable = cm->flags.bits.blend_enable;
+	memset(&m_lut_params, 0, sizeof(m_lut_params));
+	if (lut_enable) {
+		if (cm->blend_func.type == TF_TYPE_HWPWL)
+			m_lut_params.pwl = &cm->blend_func.pwl;
+		else if (cm->blend_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
+			rval = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
+					&cm->blend_func,
+					&dpp_base->regamma_params,
+					false);
 			m_lut_params.pwl = rval ? &dpp_base->regamma_params : NULL;
 		}
-		if (m_lut_params.pwl) {
-			if (mpc->funcs->populate_lut)
-				mpc->funcs->populate_lut(mpc, MCM_LUT_1DLUT, m_lut_params, lut_bank_a, mpcc_id);
+
+		if (!m_lut_params.pwl) {
+			lut_enable = false;
 		}
-		if (mpc->funcs->program_lut_mode)
-			mpc->funcs->program_lut_mode(mpc, MCM_LUT_1DLUT, lut1d_xable && m_lut_params.pwl, lut_bank_a, mpcc_id);
+	} else {
+		lut_enable = false;
 	}
 
+	if (mpc->funcs->program_lut_mode)
+		mpc->funcs->program_lut_mode(mpc, MCM_LUT_1DLUT, lut_enable, lut_bank_a, CM_LUT_SIZE_NONE, mpcc_id);
+	if (lut_enable && mpc->funcs->populate_lut)
+		mpc->funcs->populate_lut(mpc, MCM_LUT_1DLUT, &m_lut_params, lut_bank_a, mpcc_id);
+
 	/* Shaper */
-	if (mcm_luts.shaper && mcm_luts.lut3d_data.mpc_3dlut_enable) {
+	lut_enable = cm->flags.bits.shaper_enable;
+	if (lut_enable) {
 		memset(&m_lut_params, 0, sizeof(m_lut_params));
-		if (mcm_luts.shaper->type == TF_TYPE_HWPWL)
-			m_lut_params.pwl = &mcm_luts.shaper->pwl;
-		else if (mcm_luts.shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
+		if (cm->shaper_func.type == TF_TYPE_HWPWL)
+			m_lut_params.pwl = &cm->shaper_func.pwl;
+		else if (cm->shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
 			ASSERT(false);
-			rval = cm3_helper_translate_curve_to_hw_format(mpc->ctx,
-					mcm_luts.shaper,
-					&dpp_base->regamma_params, true);
-			m_lut_params.pwl = rval ? &dpp_base->regamma_params : NULL;
+			rval = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
+					&cm->shaper_func,
+					&dpp_base->shaper_params,
+					true);
+			m_lut_params.pwl = rval ? &dpp_base->shaper_params : NULL;
 		}
-		if (m_lut_params.pwl) {
-			if (mpc->funcs->mcm.populate_lut)
-				mpc->funcs->mcm.populate_lut(mpc, m_lut_params, lut_bank_a, mpcc_id);
-			if (mpc->funcs->program_lut_mode)
-				mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, MCM_LUT_ENABLE, lut_bank_a, mpcc_id);
+		if (!m_lut_params.pwl) {
+			lut_enable = false;
 		}
+	} else {
+		lut_enable = false;
 	}
 
-	/* 3DLUT */
-	switch (lut3d_src) {
-	case DC_CM2_TRANSFER_FUNC_SOURCE_SYSMEM:
-		memset(&m_lut_params, 0, sizeof(m_lut_params));
-		if (hubp->funcs->hubp_enable_3dlut_fl)
-			hubp->funcs->hubp_enable_3dlut_fl(hubp, false);
-
-		if (mcm_luts.lut3d_data.lut3d_func && mcm_luts.lut3d_data.lut3d_func->state.bits.initialized) {
-			m_lut_params.lut3d = &mcm_luts.lut3d_data.lut3d_func->lut_3d;
-			if (mpc->funcs->populate_lut)
-				mpc->funcs->populate_lut(mpc, MCM_LUT_3DLUT, m_lut_params, lut_bank_a, mpcc_id);
-			if (mpc->funcs->program_lut_mode)
-				mpc->funcs->program_lut_mode(mpc, MCM_LUT_3DLUT, lut3d_xable, lut_bank_a,
-						mpcc_id);
-		}
-		break;
-		case DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM:
-		switch (mcm_luts.lut3d_data.gpu_mem_params.size) {
-		case DC_CM2_GPU_MEM_SIZE_171717:
-			width = hubp_3dlut_fl_width_17;
-			break;
-		case DC_CM2_GPU_MEM_SIZE_TRANSFORMED:
-			width = hubp_3dlut_fl_width_transformed;
-			break;
-		default:
-			//TODO: handle default case
-			break;
-		}
+	if (mpc->funcs->program_lut_mode)
+		mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, lut_enable, lut_bank_a, CM_LUT_SIZE_NONE, mpcc_id);
+	if (lut_enable && mpc->funcs->populate_lut)
+		mpc->funcs->populate_lut(mpc, MCM_LUT_SHAPER, &m_lut_params, lut_bank_a, mpcc_id);
 
-		//check for support
-		if (mpc->funcs->mcm.is_config_supported &&
-			!mpc->funcs->mcm.is_config_supported(width))
-			break;
+	/* NOTE: Toggling from DMA->Host is not supported atomically as hardware
+	 * blocks writes until 3DLUT FL mode is cleared from HUBP on VUpdate.
+	 * Expectation is either option is used consistently.
+	*/
 
-		if (mpc->funcs->program_lut_read_write_control)
-			mpc->funcs->program_lut_read_write_control(mpc, MCM_LUT_3DLUT, lut_bank_a, mpcc_id);
+	/* 3DLUT */
+	lut_enable = cm->flags.bits.lut3d_enable;
+	if (lut_enable && cm->flags.bits.lut3d_dma_enable) {
+		/* Fast (DMA) Load Mode */
+		/* MPC */
 		if (mpc->funcs->program_lut_mode)
-			mpc->funcs->program_lut_mode(mpc, MCM_LUT_3DLUT, lut3d_xable, lut_bank_a, mpcc_id);
-
-		if (hubp->funcs->hubp_program_3dlut_fl_addr)
-			hubp->funcs->hubp_program_3dlut_fl_addr(hubp, mcm_luts.lut3d_data.gpu_mem_params.addr);
-
-		if (mpc->funcs->mcm.program_bit_depth)
-			mpc->funcs->mcm.program_bit_depth(mpc, mcm_luts.lut3d_data.gpu_mem_params.bit_depth, mpcc_id);
+			mpc->funcs->program_lut_mode(mpc, MCM_LUT_3DLUT, lut_enable, lut_bank_a, cm->lut3d_dma.size, mpcc_id);
 
-		switch (mcm_luts.lut3d_data.gpu_mem_params.layout) {
-		case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_RGB:
-			mode = hubp_3dlut_fl_mode_native_1;
-			addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
-			break;
-		case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_BGR:
-			mode = hubp_3dlut_fl_mode_native_2;
-			addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
-			break;
-		case DC_CM2_GPU_MEM_LAYOUT_1D_PACKED_LINEAR:
-			mode = hubp_3dlut_fl_mode_transform;
-			addr_mode = hubp_3dlut_fl_addressing_mode_simple_linear;
-			break;
-		default:
-			mode = hubp_3dlut_fl_mode_disable;
-			addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
-			break;
-		}
-		if (hubp->funcs->hubp_program_3dlut_fl_mode)
-			hubp->funcs->hubp_program_3dlut_fl_mode(hubp, mode);
+		/* only supports 12 bit */
+		if (mpc->funcs->program_lut_read_write_control)
+			mpc->funcs->program_lut_read_write_control(mpc, MCM_LUT_3DLUT, lut_bank_a, 12, mpcc_id);
 
-		if (hubp->funcs->hubp_program_3dlut_fl_addressing_mode)
-			hubp->funcs->hubp_program_3dlut_fl_addressing_mode(hubp, addr_mode);
+		if (mpc->funcs->update_3dlut_fast_load_select)
+			mpc->funcs->update_3dlut_fast_load_select(mpc, mpcc_id, hubp->inst);
 
-		switch (mcm_luts.lut3d_data.gpu_mem_params.format_params.format) {
-		case DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12MSB:
-			format = hubp_3dlut_fl_format_unorm_12msb_bitslice;
-			break;
-		case DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12LSB:
-			format = hubp_3dlut_fl_format_unorm_12lsb_bitslice;
-			break;
-		case DC_CM2_GPU_MEM_FORMAT_16161616_FLOAT_FP1_5_10:
-			format = hubp_3dlut_fl_format_float_fp1_5_10;
-			break;
-		}
-		if (hubp->funcs->hubp_program_3dlut_fl_format)
-			hubp->funcs->hubp_program_3dlut_fl_format(hubp, format);
-		if (hubp->funcs->hubp_update_3dlut_fl_bias_scale &&
-				mpc->funcs->mcm.program_bias_scale) {
-			mpc->funcs->mcm.program_bias_scale(mpc,
-				mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.bias,
-				mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.scale,
-				mpcc_id);
-			hubp->funcs->hubp_update_3dlut_fl_bias_scale(hubp,
-						mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.bias,
-						mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.scale);
-		}
-
-		//navi 4x has a bug and r and blue are swapped and need to be worked around here in
-		//TODO: need to make a method for get_xbar per asic OR do the workaround in program_crossbar for 4x
-		switch (mcm_luts.lut3d_data.gpu_mem_params.component_order) {
-		case DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_RGBA:
-		default:
-			crossbar_bit_slice_cr_r = hubp_3dlut_fl_crossbar_bit_slice_0_15;
-			crossbar_bit_slice_y_g = hubp_3dlut_fl_crossbar_bit_slice_16_31;
-			crossbar_bit_slice_cb_b = hubp_3dlut_fl_crossbar_bit_slice_32_47;
-			break;
-		}
+		/* HUBP */
+		if (hubp->funcs->hubp_program_3dlut_fl_config)
+			hubp->funcs->hubp_program_3dlut_fl_config(hubp, &cm->lut3d_dma);
 
 		if (hubp->funcs->hubp_program_3dlut_fl_crossbar)
-			hubp->funcs->hubp_program_3dlut_fl_crossbar(hubp,
-					crossbar_bit_slice_cr_r,
-					crossbar_bit_slice_y_g,
-					crossbar_bit_slice_cb_b);
-
-		if (mpc->funcs->mcm.program_lut_read_write_control)
-			mpc->funcs->mcm.program_lut_read_write_control(mpc, MCM_LUT_3DLUT, lut_bank_a, true, mpcc_id);
+			hubp->funcs->hubp_program_3dlut_fl_crossbar(hubp, cm->lut3d_dma.format);
 
-		if (mpc->funcs->mcm.program_3dlut_size)
-			mpc->funcs->mcm.program_3dlut_size(mpc, width, mpcc_id);
-
-		if (mpc->funcs->update_3dlut_fast_load_select)
-			mpc->funcs->update_3dlut_fast_load_select(mpc, mpcc_id, hubp->inst);
+		if (hubp->funcs->hubp_program_3dlut_fl_addr)
+			hubp->funcs->hubp_program_3dlut_fl_addr(hubp, &cm->lut3d_dma.addr);
 
-		if (hubp->funcs->hubp_enable_3dlut_fl)
+		if (hubp->funcs->hubp_enable_3dlut_fl) {
 			hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
-		else {
-			if (mpc->funcs->program_lut_mode) {
-				mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, MCM_LUT_DISABLE, lut_bank_a, mpcc_id);
-				mpc->funcs->program_lut_mode(mpc, MCM_LUT_3DLUT, MCM_LUT_DISABLE, lut_bank_a, mpcc_id);
-				mpc->funcs->program_lut_mode(mpc, MCM_LUT_1DLUT, MCM_LUT_DISABLE, lut_bank_a, mpcc_id);
-			}
+		} else {
+			/* GPU memory only supports fast load path */
+			BREAK_TO_DEBUGGER();
+			lut_enable = false;
+			result = false;
 		}
-		break;
+	} else {
+		/* Legacy (Host) Load Mode */
+		memset(&m_lut_params, 0, sizeof(m_lut_params));
 
-	}
-}
+		if (cm->flags.bits.lut3d_enable && cm->lut3d_func.state.bits.initialized) {
+			m_lut_params.lut3d = &cm->lut3d_func.lut_3d;
+		} else {
+			lut_enable = false;
+		}
 
-void dcn401_trigger_3dlut_dma_load(struct dc *dc, struct pipe_ctx *pipe_ctx)
-{
-	struct hubp *hubp = pipe_ctx->plane_res.hubp;
+		/* MPC */
+		if (mpc->funcs->program_lut_mode)
+			mpc->funcs->program_lut_mode(mpc,
+					MCM_LUT_3DLUT,
+					lut_enable,
+					lut_bank_a,
+					cm->lut3d_func.lut_3d.use_tetrahedral_9 ? CM_LUT_SIZE_999 : CM_LUT_SIZE_171717,
+					mpcc_id);
+
+		if (lut_enable) {
+			if (mpc->funcs->program_lut_read_write_control)
+				mpc->funcs->program_lut_read_write_control(mpc,
+						MCM_LUT_3DLUT,
+						lut_bank_a,
+						cm->lut3d_func.lut_3d.use_12bits ? 12 : 10,
+						mpcc_id);
 
-	if (hubp->funcs->hubp_enable_3dlut_fl) {
-		hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
-	}
-}
+			if (mpc->funcs->update_3dlut_fast_load_select)
+				mpc->funcs->update_3dlut_fast_load_select(mpc, mpcc_id, 0xf);
 
-bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
-				const struct dc_plane_state *plane_state)
-{
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
-	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
-	struct dc *dc = pipe_ctx->stream_res.opp->ctx->dc;
-	struct mpc *mpc = dc->res_pool->mpc;
-	bool result;
-	const struct pwl_params *lut_params = NULL;
-	bool rval;
+			if (mpc->funcs->populate_lut)
+				mpc->funcs->populate_lut(mpc, MCM_LUT_3DLUT, &m_lut_params, lut_bank_a, mpcc_id);
+		}
 
-	if (plane_state->mcm_luts.lut3d_data.lut3d_src == DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM) {
-		dcn401_populate_mcm_luts(dc, pipe_ctx, plane_state->mcm_luts, plane_state->lut_bank_a);
-		return true;
-	}
+		/* HUBP */
+		memset(&lut3d_dma, 0, sizeof(lut3d_dma));
+		if (hubp->funcs->hubp_program_3dlut_fl_config)
+			hubp->funcs->hubp_program_3dlut_fl_config(hubp, &lut3d_dma);
 
-	mpc->funcs->set_movable_cm_location(mpc, MPCC_MOVABLE_CM_LOCATION_BEFORE, mpcc_id);
-	pipe_ctx->plane_state->mcm_location = MPCC_MOVABLE_CM_LOCATION_BEFORE;
-	// 1D LUT
-	if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
-		lut_params = &plane_state->blend_tf.pwl;
-	else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
-		rval = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
-							       &plane_state->blend_tf,
-							       &dpp_base->regamma_params, false);
-		lut_params = rval ? &dpp_base->regamma_params : NULL;
-	}
-	result = mpc->funcs->program_1dlut(mpc, lut_params, mpcc_id);
-	lut_params = NULL;
-
-	// Shaper
-	if (plane_state->in_shaper_func.type == TF_TYPE_HWPWL)
-		lut_params = &plane_state->in_shaper_func.pwl;
-	else if (plane_state->in_shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
-		// TODO: dpp_base replace
-		rval = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
-							       &plane_state->in_shaper_func,
-							       &dpp_base->shaper_params, true);
-		lut_params = rval ? &dpp_base->shaper_params : NULL;
-	}
-	result &= mpc->funcs->program_shaper(mpc, lut_params, mpcc_id);
-
-	// 3D
-	if (mpc->funcs->program_3dlut) {
-		if (plane_state->lut3d_func.state.bits.initialized == 1)
-			result &= mpc->funcs->program_3dlut(mpc, &plane_state->lut3d_func.lut_3d, mpcc_id);
-		else
-			result &= mpc->funcs->program_3dlut(mpc, NULL, mpcc_id);
+		if (hubp->funcs->hubp_enable_3dlut_fl)
+			hubp->funcs->hubp_enable_3dlut_fl(hubp, false);
 	}
 
 	return result;
@@ -982,6 +865,8 @@ void dcn401_enable_stream(struct pipe_ctx *pipe_ctx)
 		}
 	}
 
+	link_hwss->setup_stream_attribute(pipe_ctx);
+
 	if (dc->res_pool->dccg->funcs->set_pixel_rate_div) {
 		dc->res_pool->dccg->funcs->set_pixel_rate_div(
 			dc->res_pool->dccg,
@@ -1930,10 +1815,9 @@ void dcn401_perform_3dlut_wa_unlock(struct pipe_ctx *pipe_ctx)
 
 	for (odm_pipe = pipe_ctx; odm_pipe != NULL; odm_pipe = odm_pipe->next_odm_pipe) {
 		for (mpc_pipe = odm_pipe; mpc_pipe != NULL; mpc_pipe = mpc_pipe->bottom_pipe) {
-			if (mpc_pipe->plane_state && mpc_pipe->plane_state->mcm_luts.lut3d_data.lut3d_src
-						== DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM
-					&& mpc_pipe->plane_state->mcm_shaper_3dlut_setting
-						== DC_CM2_SHAPER_3DLUT_SETTING_ENABLE_SHAPER_3DLUT) {
+			if (mpc_pipe->plane_state &&
+					mpc_pipe->plane_state->cm.flags.bits.lut3d_enable &&
+					mpc_pipe->plane_state->cm.flags.bits.lut3d_dma_enable) {
 				wa_pipes[wa_pipe_ct++] = mpc_pipe;
 			}
 		}
@@ -2060,6 +1944,22 @@ void dcn401_reset_back_end_for_pipe(
 	DC_LOG_DEBUG("Reset back end for pipe %d, tg:%d\n",
 					pipe_ctx->pipe_idx, pipe_ctx->stream_res.tg->inst);
 }
+static void dc_hwss_disable_otg_pwa(struct dc *dc)
+{
+	if (dc->debug.enable_otg_frame_sync_pwa) {
+		int i;
+
+		/*reset all the otg*/
+		for (i = dc->res_pool->timing_generator_count - 1; i >= 0 ; i--) {
+			struct timing_generator *tg = dc->res_pool->timing_generators[i];
+
+			if (tg->funcs->disable_otg_pwa) {
+				tg->funcs->disable_otg_pwa(tg);
+				DC_LOG_DC("otg frame sync pwa disabled on otg%d\n", tg->inst);
+			}
+		}
+	}
+}
 
 void dcn401_reset_hw_ctx_wrap(
 		struct dc *dc,
@@ -2068,6 +1968,7 @@ void dcn401_reset_hw_ctx_wrap(
 	int i;
 	struct dce_hwseq *hws = dc->hwseq;
 
+	dc_hwss_disable_otg_pwa(dc);
 	/* Reset Back End*/
 	for (i = dc->res_pool->pipe_count - 1; i >= 0 ; i--) {
 		struct pipe_ctx *pipe_ctx_old =
@@ -2258,6 +2159,10 @@ void dcn401_program_pipe(
 			pipe_ctx->stream_res.test_pattern_params.height,
 			pipe_ctx->stream_res.test_pattern_params.offset);
 	}
+	if (pipe_ctx->plane_state
+		&& pipe_ctx->plane_state->update_flags.bits.cm_hist_change
+		&& hws->funcs.program_cm_hist)
+		hws->funcs.program_cm_hist(dc, pipe_ctx, pipe_ctx->plane_state);
 }
 
 /*
@@ -2409,6 +2314,13 @@ void dcn401_program_pipe_sequence(
 			pipe_ctx->stream_res.test_pattern_params.offset);
 	}
 
+	if (pipe_ctx->plane_state
+			&& pipe_ctx->plane_state->update_flags.bits.cm_hist_change
+			&& hws->funcs.program_cm_hist) {
+
+		hwss_add_dpp_program_cm_hist(seq_state, pipe_ctx->plane_res.dpp,
+			pipe_ctx->plane_state->cm_hist_control, pipe_ctx->plane_state->color_space);
+	}
 }
 
 void dcn401_program_front_end_for_ctx(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index f0e1ed0f2949..8e12dc1297c4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -261,7 +261,7 @@ void dcn42_init_hw(struct dc *dc)
 		dc->res_pool->hubbub->funcs->init_crb(dc->res_pool->hubbub);
 
 	if (dc->res_pool->hubbub->funcs->set_request_limit && dc->config.sdpif_request_limit_words_per_umc > 0)
-		dc->res_pool->hubbub->funcs->set_request_limit(dc->res_pool->hubbub, dc->ctx->dc_bios->vram_info.num_chans, dc->config.sdpif_request_limit_words_per_umc);
+		dc->res_pool->hubbub->funcs->set_request_limit(dc->res_pool->hubbub, dc->clk_mgr->bw_params->num_channels, dc->config.sdpif_request_limit_words_per_umc);
 
 	// Get DMCUB capabilities
 	if (dc->ctx->dmub_srv) {
@@ -275,8 +275,7 @@ void dcn42_init_hw(struct dc *dc)
 			|| res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq) {
 			/* update bounding box if FAMS2 disabled, or if dchub clk has changed */
 			if (dc->clk_mgr)
-				dc->res_pool->funcs->update_bw_bounding_box(dc,
-									    dc->clk_mgr->bw_params);
+				dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
 		}
 	}
 	if (dc->res_pool->pg_cntl) {
@@ -383,68 +382,6 @@ void dcn42_program_cm_hist(
 			plane_state->cm_hist_control, plane_state->color_space);
 }
 
-static void dc_get_lut_xbar(
-	enum dc_cm2_gpu_mem_pixel_component_order order,
-	enum hubp_3dlut_fl_crossbar_bit_slice *cr_r,
-	enum hubp_3dlut_fl_crossbar_bit_slice *y_g,
-	enum hubp_3dlut_fl_crossbar_bit_slice *cb_b)
-{
-	switch (order) {
-	case DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_RGBA:
-		*cr_r = hubp_3dlut_fl_crossbar_bit_slice_32_47;
-		*y_g = hubp_3dlut_fl_crossbar_bit_slice_16_31;
-		*cb_b =  hubp_3dlut_fl_crossbar_bit_slice_0_15;
-		break;
-	case DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_BGRA:
-		*cr_r = hubp_3dlut_fl_crossbar_bit_slice_0_15;
-		*y_g = hubp_3dlut_fl_crossbar_bit_slice_16_31;
-		*cb_b = hubp_3dlut_fl_crossbar_bit_slice_32_47;
-		break;
-	}
-}
-
-static void dc_get_lut_mode(
-	enum dc_cm2_gpu_mem_layout layout,
-	enum hubp_3dlut_fl_mode *mode,
-	enum hubp_3dlut_fl_addressing_mode *addr_mode)
-{
-	switch (layout) {
-	case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_RGB:
-		*mode = hubp_3dlut_fl_mode_native_1;
-		*addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
-		break;
-	case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_BGR:
-		*mode = hubp_3dlut_fl_mode_native_2;
-		*addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
-		break;
-	case DC_CM2_GPU_MEM_LAYOUT_1D_PACKED_LINEAR:
-		*mode = hubp_3dlut_fl_mode_transform;
-		*addr_mode = hubp_3dlut_fl_addressing_mode_simple_linear;
-		break;
-	default:
-		*mode = hubp_3dlut_fl_mode_disable;
-		*addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
-		break;
-	}
-}
-
-static void dc_get_lut_format(
-	enum dc_cm2_gpu_mem_format dc_format,
-	enum hubp_3dlut_fl_format *format)
-{
-	switch (dc_format) {
-	case DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12MSB:
-		*format = hubp_3dlut_fl_format_unorm_12msb_bitslice;
-		break;
-	case DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12LSB:
-		*format = hubp_3dlut_fl_format_unorm_12lsb_bitslice;
-		break;
-	case DC_CM2_GPU_MEM_FORMAT_16161616_FLOAT_FP1_5_10:
-		*format = hubp_3dlut_fl_format_float_fp1_5_10;
-		break;
-	}
-}
-
 static bool dc_is_rmcm_3dlut_supported(struct hubp *hubp, struct mpc *mpc)
 {
 	if (mpc->funcs->rmcm.power_on_shaper_3dlut &&
@@ -455,119 +392,17 @@ static bool dc_is_rmcm_3dlut_supported(struct hubp *hubp, struct mpc *mpc)
 	return false;
 }
 
-static bool is_rmcm_3dlut_fl_supported(struct dc *dc, enum dc_cm2_gpu_mem_size size)
-{
-	if (!dc->caps.color.mpc.rmcm_3d_lut_caps.dma_3d_lut)
-		return false;
-	if (size == DC_CM2_GPU_MEM_SIZE_171717)
-		return (dc->caps.color.mpc.rmcm_3d_lut_caps.lut_dim_caps.dim_17);
-	else if (size == DC_CM2_GPU_MEM_SIZE_333333)
-		return (dc->caps.color.mpc.rmcm_3d_lut_caps.lut_dim_caps.dim_33);
-	return false;
-}
-
-static void dcn42_set_mcm_location_post_blend(struct dc *dc, struct pipe_ctx *pipe_ctx, bool bPostBlend)
-{
-	struct mpc *mpc = dc->res_pool->mpc;
-	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
-
-	if (!pipe_ctx->plane_state)
-		return;
-
-	mpc->funcs->set_movable_cm_location(mpc, MPCC_MOVABLE_CM_LOCATION_BEFORE, mpcc_id);
-	pipe_ctx->plane_state->mcm_location = (bPostBlend) ?
-											MPCC_MOVABLE_CM_LOCATION_AFTER :
-											MPCC_MOVABLE_CM_LOCATION_BEFORE;
-}
-
-static void dcn42_get_mcm_lut_xable_from_pipe_ctx(struct dc *dc, struct pipe_ctx *pipe_ctx,
-		enum MCM_LUT_XABLE *shaper_xable,
-		enum MCM_LUT_XABLE *lut3d_xable,
-		enum MCM_LUT_XABLE *lut1d_xable)
-{
-	enum dc_cm2_shaper_3dlut_setting shaper_3dlut_setting = DC_CM2_SHAPER_3DLUT_SETTING_BYPASS_ALL;
-	bool lut1d_enable = false;
-	struct mpc *mpc = dc->res_pool->mpc;
-	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
-
-	if (!pipe_ctx->plane_state)
-		return;
-	shaper_3dlut_setting = pipe_ctx->plane_state->mcm_shaper_3dlut_setting;
-	lut1d_enable = pipe_ctx->plane_state->mcm_lut1d_enable;
-	mpc->funcs->set_movable_cm_location(mpc, MPCC_MOVABLE_CM_LOCATION_BEFORE, mpcc_id);
-	pipe_ctx->plane_state->mcm_location = MPCC_MOVABLE_CM_LOCATION_BEFORE;
-
-	*lut1d_xable = lut1d_enable ? MCM_LUT_ENABLE : MCM_LUT_DISABLE;
-
-	switch (shaper_3dlut_setting) {
-	case DC_CM2_SHAPER_3DLUT_SETTING_BYPASS_ALL:
-		*lut3d_xable = *shaper_xable = MCM_LUT_DISABLE;
-		break;
-	case DC_CM2_SHAPER_3DLUT_SETTING_ENABLE_SHAPER:
-		*lut3d_xable = MCM_LUT_DISABLE;
-		*shaper_xable = MCM_LUT_ENABLE;
-		break;
-	case DC_CM2_SHAPER_3DLUT_SETTING_ENABLE_SHAPER_3DLUT:
-		*lut3d_xable = *shaper_xable = MCM_LUT_ENABLE;
-		break;
-	}
-}
-
-static void fl_get_lut_mode(
-	enum dc_cm2_gpu_mem_layout layout,
-	enum dc_cm2_gpu_mem_size   size,
-	enum hubp_3dlut_fl_mode *mode,
-	enum hubp_3dlut_fl_addressing_mode *addr_mode,
-	enum hubp_3dlut_fl_width *width)
-{
-	*width = hubp_3dlut_fl_width_17;
-
-	if (size == DC_CM2_GPU_MEM_SIZE_333333)
-		*width = hubp_3dlut_fl_width_33;
-
-	switch (layout) {
-	case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_RGB:
-		*mode = hubp_3dlut_fl_mode_native_1;
-		*addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
-		break;
-	case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_BGR:
-		*mode = hubp_3dlut_fl_mode_native_2;
-		*addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
-		break;
-	case DC_CM2_GPU_MEM_LAYOUT_1D_PACKED_LINEAR:
-		*mode = hubp_3dlut_fl_mode_transform;
-		*addr_mode = hubp_3dlut_fl_addressing_mode_simple_linear;
-		break;
-	default:
-		*mode = hubp_3dlut_fl_mode_disable;
-		*addr_mode = hubp_3dlut_fl_addressing_mode_sw_linear;
-		break;
-	}
-}
-
 bool dcn42_program_rmcm_luts(
 	struct hubp *hubp,
 	struct pipe_ctx *pipe_ctx,
-	enum dc_cm2_transfer_func_source lut3d_src,
-	struct dc_cm2_func_luts *mcm_luts,
+	const struct dc_plane_cm *cm,
 	struct mpc *mpc,
-	bool lut_bank_a,
 	int mpcc_id)
 {
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	union mcm_lut_params m_lut_params = {0};
-	enum MCM_LUT_XABLE shaper_xable, lut3d_xable = MCM_LUT_DISABLE, lut1d_xable;
-		enum hubp_3dlut_fl_mode mode;
-	enum hubp_3dlut_fl_addressing_mode addr_mode;
-	enum hubp_3dlut_fl_format format = hubp_3dlut_fl_format_unorm_12msb_bitslice;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_y_g = hubp_3dlut_fl_crossbar_bit_slice_16_31;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cb_b = hubp_3dlut_fl_crossbar_bit_slice_0_15;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cr_r = hubp_3dlut_fl_crossbar_bit_slice_32_47;
-	enum hubp_3dlut_fl_width width = hubp_3dlut_fl_width_17;
-
 
 	struct dc *dc = hubp->ctx->dc;
-	struct hubp_fl_3dlut_config fl_config;
 	struct mpc_fl_3dlut_config mpc_fl_config;
 
 	struct dc_stream_state *stream = pipe_ctx->stream;
@@ -575,25 +410,23 @@ bool dcn42_program_rmcm_luts(
 	// true->false when it can be allocated at DI time
 	struct dc_rmcm_3dlut *rmcm_3dlut = dc_stream_get_3dlut_for_stream(dc, stream, false);
 
+	bool lut_bank_a = true; // TODO get from HW
+
 	//check to see current pipe is part of a stream with allocated rmcm 3dlut
 	if (!rmcm_3dlut)
 		return false;
 
-	rmcm_3dlut->protection_bits = mcm_luts->lut3d_data.rmcm_tmz;
-
-	dcn42_get_mcm_lut_xable_from_pipe_ctx(dc, pipe_ctx, &shaper_xable, &lut3d_xable, &lut1d_xable);
-
 	/* Shaper */
-	if (mcm_luts->shaper) {
+	if (cm->flags.bits.shaper_enable) {
 		memset(&m_lut_params, 0, sizeof(m_lut_params));
 
-		if (mcm_luts->shaper->type == TF_TYPE_HWPWL) {
-			m_lut_params.pwl = &mcm_luts->shaper->pwl;
-		} else if (mcm_luts->shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
+		if (cm->shaper_func.type == TF_TYPE_HWPWL) {
+			m_lut_params.pwl = &cm->shaper_func.pwl;
+		} else if (cm->shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
 			ASSERT(false);
 			cm_helper_translate_curve_to_hw_format(
 					dc->ctx,
-					mcm_luts->shaper,
+					&cm->shaper_func,
 					&dpp_base->shaper_params, true);
 			m_lut_params.pwl = &dpp_base->shaper_params;
 		}
@@ -609,58 +442,21 @@ bool dcn42_program_rmcm_luts(
 	}
 
 	/* 3DLUT */
-	switch (lut3d_src) {
-	case DC_CM2_TRANSFER_FUNC_SOURCE_SYSMEM:
+	if (!cm->flags.bits.lut3d_dma_enable) {
 		memset(&m_lut_params, 0, sizeof(m_lut_params));
 		// Don't know what to do in this case.
-		//case DC_CM2_TRANSFER_FUNC_SOURCE_SYSMEM:
-		break;
-	case DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM:
-		fl_get_lut_mode(mcm_luts->lut3d_data.gpu_mem_params.layout,
-				mcm_luts->lut3d_data.gpu_mem_params.size,
-				&mode,
-				&addr_mode,
-				&width);
-
-		if (!dc_is_rmcm_3dlut_supported(hubp, mpc) ||
-			!mpc->funcs->rmcm.is_config_supported(
-				(width == hubp_3dlut_fl_width_17 ||
-				 width == hubp_3dlut_fl_width_transformed) ? 17 : 33))
+	} else {
+		if (!dc_is_rmcm_3dlut_supported(hubp, mpc))
 			return false;
 
-		// setting native or transformed mode,
-		dc_get_lut_mode(mcm_luts->lut3d_data.gpu_mem_params.layout, &mode, &addr_mode);
-
 		//seems to be only for the MCM
-		dc_get_lut_format(mcm_luts->lut3d_data.gpu_mem_params.format_params.format, &format);
-
-		dc_get_lut_xbar(
-			mcm_luts->lut3d_data.gpu_mem_params.component_order,
-			&crossbar_bit_slice_cr_r,
-			&crossbar_bit_slice_y_g,
-			&crossbar_bit_slice_cb_b);
-
-		fl_config.mode					= mode;
-		fl_config.enabled				= lut3d_xable != MCM_LUT_DISABLE;
-		fl_config.address				= mcm_luts->lut3d_data.gpu_mem_params.addr;
-		fl_config.format				= format;
-		fl_config.crossbar_bit_slice_y_g  = crossbar_bit_slice_y_g;
-		fl_config.crossbar_bit_slice_cb_b = crossbar_bit_slice_cb_b;
-		fl_config.crossbar_bit_slice_cr_r = crossbar_bit_slice_cr_r;
-		fl_config.width				    = width;
-		fl_config.protection_bits		= rmcm_3dlut->protection_bits;
-		fl_config.addr_mode			    = addr_mode;
-		fl_config.layout                = mcm_luts->lut3d_data.gpu_mem_params.layout;
-		fl_config.bias	= mcm_luts->lut3d_data.gpu_mem_params.format_params.float_params.bias;
-		fl_config.scale	= mcm_luts->lut3d_data.gpu_mem_params.format_params.float_params.scale;
-
-		mpc_fl_config.enabled			= fl_config.enabled;
-		mpc_fl_config.width	            = width;
+		mpc_fl_config.enabled			= cm->flags.bits.lut3d_enable;
+		mpc_fl_config.size	            = cm->lut3d_dma.size;
 		mpc_fl_config.select_lut_bank_a = lut_bank_a;
-		mpc_fl_config.bit_depth		    = mcm_luts->lut3d_data.gpu_mem_params.bit_depth;
+		mpc_fl_config.bit_depth		    = 0;
 		mpc_fl_config.hubp_index		= hubp->inst;
-		mpc_fl_config.bias	= mcm_luts->lut3d_data.gpu_mem_params.format_params.float_params.bias;
-		mpc_fl_config.scale	= mcm_luts->lut3d_data.gpu_mem_params.format_params.float_params.scale;
+		mpc_fl_config.bias	= cm->lut3d_dma.bias;
+		mpc_fl_config.scale	= cm->lut3d_dma.scale;
 
 		//1. power down the block
 		mpc->funcs->rmcm.power_on_shaper_3dlut(mpc, mpcc_id, false);
@@ -668,268 +464,44 @@ bool dcn42_program_rmcm_luts(
 		//2. program RMCM - 3dlut reg programming
 		mpc->funcs->rmcm.fl_3dlut_configure(mpc, &mpc_fl_config, mpcc_id);
 
-		hubp->funcs->hubp_program_3dlut_fl_config(hubp, &fl_config);
+		/* HUBP */
+		if (hubp->funcs->hubp_program_3dlut_fl_config)
+			hubp->funcs->hubp_program_3dlut_fl_config(hubp, &cm->lut3d_dma);
+
+		if (hubp->funcs->hubp_program_3dlut_fl_addr)
+			hubp->funcs->hubp_program_3dlut_fl_addr(hubp, &cm->lut3d_dma.addr);
 
 		//3. power on the block
 		mpc->funcs->rmcm.power_on_shaper_3dlut(mpc, mpcc_id, true);
-
-		break;
-	default:
-		return false;
 	}
 
 	return true;
 }
 
-void dcn42_populate_mcm_luts(struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
-		struct dc_cm2_func_luts mcm_luts,
-		bool lut_bank_a)
+bool dcn42_set_mcm_luts(struct pipe_ctx *pipe_ctx,
+				const struct dc_plane_state *plane_state)
 {
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
+	struct dc *dc = pipe_ctx->plane_res.hubp->ctx->dc;
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
-	int mpcc_id = hubp->inst;
+	const struct dc_plane_cm *cm = &plane_state->cm;
 	struct mpc *mpc = dc->res_pool->mpc;
-	union mcm_lut_params m_lut_params;
-	enum dc_cm2_transfer_func_source lut3d_src = mcm_luts.lut3d_data.lut3d_src;
-	enum hubp_3dlut_fl_format format = 0;
-	enum hubp_3dlut_fl_mode mode;
-	enum hubp_3dlut_fl_width width = 0;
-	enum hubp_3dlut_fl_addressing_mode addr_mode;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_y_g = 0;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cb_b = 0;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cr_r = 0;
-	enum MCM_LUT_XABLE shaper_xable = MCM_LUT_DISABLE;
-	enum MCM_LUT_XABLE lut3d_xable = MCM_LUT_DISABLE;
-	enum MCM_LUT_XABLE lut1d_xable = MCM_LUT_DISABLE;
-	bool rval;
-
-	dcn42_get_mcm_lut_xable_from_pipe_ctx(dc, pipe_ctx, &shaper_xable, &lut3d_xable, &lut1d_xable);
-
-	//MCM - setting its location (Before/After) blender
-	//set to post blend (true)
-	dcn42_set_mcm_location_post_blend(
-		dc,
-		pipe_ctx,
-		mcm_luts.lut3d_data.mpc_mcm_post_blend);
-
-	//RMCM - 3dLUT+Shaper
-	if (mcm_luts.lut3d_data.rmcm_3dlut_enable &&
-		is_rmcm_3dlut_fl_supported(dc, mcm_luts.lut3d_data.gpu_mem_params.size)) {
+	int mpcc_id = hubp->inst;
+	bool result;
+
+	/* MCM */
+	result = dcn401_set_mcm_luts(pipe_ctx, plane_state);
+
+	/* RMCM */
+	if (cm->flags.bits.rmcm_enable && cm->flags.bits.lut3d_dma_enable) {
+		/* TODO - move RMCM to its own block */
 		dcn42_program_rmcm_luts(
 			hubp,
 			pipe_ctx,
-			lut3d_src,
-			&mcm_luts,
+			cm,
 			mpc,
-			lut_bank_a,
 			mpcc_id);
 	}
 
-	/* 1D LUT */
-	if (mcm_luts.lut1d_func) {
-		memset(&m_lut_params, 0, sizeof(m_lut_params));
-		if (mcm_luts.lut1d_func->type == TF_TYPE_HWPWL)
-			m_lut_params.pwl = &mcm_luts.lut1d_func->pwl;
-		else if (mcm_luts.lut1d_func->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			rval = cm3_helper_translate_curve_to_hw_format(mpc->ctx,
-					mcm_luts.lut1d_func,
-					&dpp_base->regamma_params, false);
-			m_lut_params.pwl = rval ? &dpp_base->regamma_params : NULL;
-		}
-		if (m_lut_params.pwl) {
-			if (mpc->funcs->populate_lut)
-				mpc->funcs->populate_lut(mpc, MCM_LUT_1DLUT, m_lut_params, lut_bank_a, mpcc_id);
-		}
-		if (mpc->funcs->program_lut_mode)
-			mpc->funcs->program_lut_mode(mpc, MCM_LUT_1DLUT, lut1d_xable && m_lut_params.pwl, lut_bank_a, mpcc_id);
-	}
-
-	/* Shaper */
-	if (mcm_luts.shaper && mcm_luts.lut3d_data.mpc_3dlut_enable) {
-		memset(&m_lut_params, 0, sizeof(m_lut_params));
-		if (mcm_luts.shaper->type == TF_TYPE_HWPWL)
-			m_lut_params.pwl = &mcm_luts.shaper->pwl;
-		else if (mcm_luts.shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			ASSERT(false);
-			rval = cm3_helper_translate_curve_to_hw_format(mpc->ctx,
-					mcm_luts.shaper,
-					&dpp_base->regamma_params, true);
-			m_lut_params.pwl = rval ? &dpp_base->regamma_params : NULL;
-		}
-		if (m_lut_params.pwl) {
-			if (mpc->funcs->mcm.populate_lut)
-				mpc->funcs->mcm.populate_lut(mpc, m_lut_params, lut_bank_a, mpcc_id);
-			if (mpc->funcs->program_lut_mode)
-				mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, MCM_LUT_ENABLE, lut_bank_a, mpcc_id);
-		}
-	}
-
-	/* 3DLUT */
-	switch (lut3d_src) {
-	case DC_CM2_TRANSFER_FUNC_SOURCE_SYSMEM:
-		memset(&m_lut_params, 0, sizeof(m_lut_params));
-		if (hubp->funcs->hubp_enable_3dlut_fl)
-			hubp->funcs->hubp_enable_3dlut_fl(hubp, false);
-
-		if (mcm_luts.lut3d_data.lut3d_func && mcm_luts.lut3d_data.lut3d_func->state.bits.initialized) {
-			m_lut_params.lut3d = &mcm_luts.lut3d_data.lut3d_func->lut_3d;
-			if (mpc->funcs->populate_lut)
-				mpc->funcs->populate_lut(mpc, MCM_LUT_3DLUT, m_lut_params, lut_bank_a, mpcc_id);
-			if (mpc->funcs->program_lut_mode)
-				mpc->funcs->program_lut_mode(mpc, MCM_LUT_3DLUT, lut3d_xable, lut_bank_a,
-						mpcc_id);
-		}
-		break;
-	case DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM:
-		switch (mcm_luts.lut3d_data.gpu_mem_params.size) {
-		case DC_CM2_GPU_MEM_SIZE_333333:
-			width = hubp_3dlut_fl_width_33;
-			break;
-		case DC_CM2_GPU_MEM_SIZE_171717:
-			width = hubp_3dlut_fl_width_17;
-			break;
-		case DC_CM2_GPU_MEM_SIZE_TRANSFORMED:
-			width = hubp_3dlut_fl_width_transformed;
-			break;
-		default:
-			//TODO: Handle default case
-			break;
-		}
-
-		//check for support
-		if (mpc->funcs->mcm.is_config_supported &&
-			!mpc->funcs->mcm.is_config_supported(width))
-			break;
-
-		if (mpc->funcs->program_lut_read_write_control)
-			mpc->funcs->program_lut_read_write_control(mpc, MCM_LUT_3DLUT, lut_bank_a, mpcc_id);
-		if (mpc->funcs->program_lut_mode)
-			mpc->funcs->program_lut_mode(mpc, MCM_LUT_3DLUT, lut3d_xable, lut_bank_a, mpcc_id);
-
-		if (hubp->funcs->hubp_program_3dlut_fl_addr)
-			hubp->funcs->hubp_program_3dlut_fl_addr(hubp, mcm_luts.lut3d_data.gpu_mem_params.addr);
-
-		if (mpc->funcs->mcm.program_bit_depth)
-			mpc->funcs->mcm.program_bit_depth(mpc, mcm_luts.lut3d_data.gpu_mem_params.bit_depth, mpcc_id);
-
-		dc_get_lut_mode(mcm_luts.lut3d_data.gpu_mem_params.layout, &mode, &addr_mode);
-		if (hubp->funcs->hubp_program_3dlut_fl_mode)
-			hubp->funcs->hubp_program_3dlut_fl_mode(hubp, mode);
-
-		if (hubp->funcs->hubp_program_3dlut_fl_addressing_mode)
-			hubp->funcs->hubp_program_3dlut_fl_addressing_mode(hubp, addr_mode);
-
-		switch (mcm_luts.lut3d_data.gpu_mem_params.format_params.format) {
-		case DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12MSB:
-			format = hubp_3dlut_fl_format_unorm_12msb_bitslice;
-			break;
-		case DC_CM2_GPU_MEM_FORMAT_16161616_UNORM_12LSB:
-			format = hubp_3dlut_fl_format_unorm_12lsb_bitslice;
-			break;
-		case DC_CM2_GPU_MEM_FORMAT_16161616_FLOAT_FP1_5_10:
-			format = hubp_3dlut_fl_format_float_fp1_5_10;
-			break;
-		}
-		if (hubp->funcs->hubp_program_3dlut_fl_format)
-			hubp->funcs->hubp_program_3dlut_fl_format(hubp, format);
-		if (hubp->funcs->hubp_update_3dlut_fl_bias_scale &&
-				mpc->funcs->mcm.program_bias_scale) {
-			mpc->funcs->mcm.program_bias_scale(mpc,
-				mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.bias,
-				mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.scale,
-				mpcc_id);
-			hubp->funcs->hubp_update_3dlut_fl_bias_scale(hubp,
-						mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.bias,
-						mcm_luts.lut3d_data.gpu_mem_params.format_params.float_params.scale);
-		}
-
-		//navi 4x has a bug and r and blue are swapped and need to be worked around here in
-		//TODO: need to make a method for get_xbar per asic OR do the workaround in program_crossbar for 4x
-		dc_get_lut_xbar(
-			mcm_luts.lut3d_data.gpu_mem_params.component_order,
-			&crossbar_bit_slice_cr_r,
-			&crossbar_bit_slice_y_g,
-			&crossbar_bit_slice_cb_b);
-
-		if (hubp->funcs->hubp_program_3dlut_fl_crossbar)
-			hubp->funcs->hubp_program_3dlut_fl_crossbar(hubp,
-					crossbar_bit_slice_cr_r,
-					crossbar_bit_slice_y_g,
-					crossbar_bit_slice_cb_b);
-
-		if (mpc->funcs->mcm.program_lut_read_write_control)
-			mpc->funcs->mcm.program_lut_read_write_control(mpc, MCM_LUT_3DLUT, lut_bank_a, true, mpcc_id);
-
-		if (mpc->funcs->mcm.program_3dlut_size)
-			mpc->funcs->mcm.program_3dlut_size(mpc, width, mpcc_id);
-
-		if (mpc->funcs->update_3dlut_fast_load_select)
-			mpc->funcs->update_3dlut_fast_load_select(mpc, mpcc_id, hubp->inst);
-
-		if (hubp->funcs->hubp_enable_3dlut_fl)
-			hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
-		else {
-			if (mpc->funcs->program_lut_mode) {
-				mpc->funcs->program_lut_mode(mpc, MCM_LUT_SHAPER, MCM_LUT_DISABLE, lut_bank_a, mpcc_id);
-				mpc->funcs->program_lut_mode(mpc, MCM_LUT_3DLUT, MCM_LUT_DISABLE, lut_bank_a, mpcc_id);
-				mpc->funcs->program_lut_mode(mpc, MCM_LUT_1DLUT, MCM_LUT_DISABLE, lut_bank_a, mpcc_id);
-			}
-		}
-		break;
-	}
-}
-
-bool dcn42_set_mcm_luts(struct pipe_ctx *pipe_ctx,
-				const struct dc_plane_state *plane_state)
-{
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
-	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
-	struct dc *dc = pipe_ctx->stream_res.opp->ctx->dc;
-	struct mpc *mpc = dc->res_pool->mpc;
-	bool result;
-	const struct pwl_params *lut_params = NULL;
-	bool rval;
-
-	if (plane_state->mcm_luts.lut3d_data.lut3d_src == DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM) {
-		dcn42_populate_mcm_luts(dc, pipe_ctx, plane_state->mcm_luts, plane_state->lut_bank_a);
-		return true;
-	}
-
-	mpc->funcs->set_movable_cm_location(mpc, MPCC_MOVABLE_CM_LOCATION_BEFORE, mpcc_id);
-	pipe_ctx->plane_state->mcm_location = MPCC_MOVABLE_CM_LOCATION_BEFORE;
-	// 1D LUT
-	if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
-		lut_params = &plane_state->blend_tf.pwl;
-	else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
-		rval = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
-				&plane_state->blend_tf,
-				&dpp_base->regamma_params, false);
-		lut_params = rval ? &dpp_base->regamma_params : NULL;
-	}
-	result = mpc->funcs->program_1dlut(mpc, lut_params, mpcc_id);
-	lut_params = NULL;
-
-	// Shaper
-	if (plane_state->in_shaper_func.type == TF_TYPE_HWPWL)
-		lut_params = &plane_state->in_shaper_func.pwl;
-	else if (plane_state->in_shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
-		// TODO: dpp_base replace
-		rval = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
-				&plane_state->in_shaper_func,
-				&dpp_base->shaper_params, true);
-		lut_params = rval ? &dpp_base->shaper_params : NULL;
-	}
-	result &= mpc->funcs->program_shaper(mpc, lut_params, mpcc_id);
-
-	// 3D
-	if (mpc->funcs->program_3dlut) {
-		if (plane_state->lut3d_func.state.bits.initialized == 1)
-			result &= mpc->funcs->program_3dlut(mpc, &plane_state->lut3d_func.lut_3d, mpcc_id);
-		else
-			result &= mpc->funcs->program_3dlut(mpc, NULL, mpcc_id);
-	}
-
 	return result;
 }
 void dcn42_hardware_release(struct dc *dc)
@@ -1050,7 +622,7 @@ void dcn42_prepare_bandwidth(
 			dc->hwss.hw_block_power_up(dc, &pg_update_state);
 	}
 
-	dcn20_prepare_bandwidth(dc, context);
+	dcn401_prepare_bandwidth(dc, context);
 }
 
 void dcn42_optimize_bandwidth(struct dc *dc, struct dc_state *context)
@@ -1470,3 +1042,50 @@ void dcn42_dmub_hw_control_lock_fast(union block_sequence_params *params)
 		dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
 	}
 }
+
+/* In headless boot cases, DIG may be turned
+ * on which causes HW/SW discrepancies.
+ * To avoid this, power down hardware on boot
+ * if DIG is turned on
+ */
+void dcn42_power_down_on_boot(struct dc *dc)
+{
+	struct dc_link *edp_links[MAX_NUM_EDP];
+	struct dc_link *edp_link = NULL;
+	int edp_num;
+	int i = 0;
+
+	dc_get_edp_links(dc, edp_links, &edp_num);
+	if (edp_num)
+		edp_link = edp_links[0];
+
+	if (edp_link && edp_link->link_enc->funcs->is_dig_enabled &&
+			edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
+			dc->hwseq->funcs.edp_backlight_control &&
+			dc->hwseq->funcs.power_down &&
+			dc->hwss.edp_power_control) {
+		dc->hwseq->funcs.edp_backlight_control(edp_link, false);
+		dc->hwseq->funcs.power_down(dc);
+		dc->hwss.edp_power_control(edp_link, false);
+	} else {
+		for (i = 0; i < dc->link_count; i++) {
+			struct dc_link *link = dc->links[i];
+
+			if (link->link_enc && link->link_enc->funcs->is_dig_enabled &&
+					link->link_enc->funcs->is_dig_enabled(link->link_enc) &&
+					dc->hwseq->funcs.power_down) {
+				dc->hwseq->funcs.power_down(dc);
+				break;
+			}
+
+		}
+	}
+
+	/*
+	 * Call update_clocks with empty context
+	 * to send DISPLAY_OFF
+	 * Otherwise DISPLAY_OFF may not be asserted
+	 */
+	if (dc->clk_mgr->funcs->set_low_power_state)
+		dc->clk_mgr->funcs->set_low_power_state(dc->clk_mgr);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
index 89ebb6520eaf..c4cfeed45b19 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
@@ -18,18 +18,11 @@ void dcn42_program_cm_hist(
 bool dcn42_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 	const struct dc_plane_state *plane_state);
 
-void dcn42_populate_mcm_luts(struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
-		struct dc_cm2_func_luts mcm_luts,
-		bool lut_bank_a);
-
 bool dcn42_program_rmcm_luts(
 	struct hubp *hubp,
 	struct pipe_ctx *pipe_ctx,
-	enum dc_cm2_transfer_func_source lut3d_src,
-	struct dc_cm2_func_luts *mcm_luts,
+	const struct dc_plane_cm *cm,
 	struct mpc *mpc,
-	bool lut_bank_a,
 	int mpcc_id);
 void dcn42_hardware_release(struct dc *dc);
 
@@ -50,4 +43,5 @@ void dcn42_root_clock_control(struct dc *dc,
 void dcn42_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock);
 void dcn42_dmub_hw_control_lock_fast(union block_sequence_params *params);
 void dcn42_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc);
+void dcn42_power_down_on_boot(struct dc *dc);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
index a8e2f59d5e50..b324a2195e8a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
@@ -19,7 +19,7 @@ static const struct hw_sequencer_funcs dcn42_funcs = {
 	.program_gamut_remap = dcn401_program_gamut_remap,
 	.init_hw = dcn42_init_hw,
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
-	.power_down_on_boot = dcn35_power_down_on_boot,
+	.power_down_on_boot = dcn42_power_down_on_boot,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn401_program_front_end_for_ctx,
 	.clear_surface_dcc_and_tiling = dcn10_reset_surface_dcc_and_tiling,
@@ -64,6 +64,12 @@ static const struct hw_sequencer_funcs dcn42_funcs = {
 	.set_cursor_position = dcn401_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
+	.abort_cursor_offload_update = dcn35_abort_cursor_offload_update,
+	.begin_cursor_offload_update = dcn35_begin_cursor_offload_update,
+	.commit_cursor_offload_update = dcn35_commit_cursor_offload_update,
+	.update_cursor_offload_pipe = dcn401_update_cursor_offload_pipe,
+	.notify_cursor_offload_drr_update = dcn35_notify_cursor_offload_drr_update,
+	.program_cursor_offload_now = dcn35_program_cursor_offload_now,
 	.setup_periodic_interrupt = dcn10_setup_periodic_interrupt,
 	.set_clock = dcn10_set_clock,
 	.get_clock = dcn10_get_clock,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index a79019365af8..2a5a81d15950 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -89,7 +89,7 @@ enum hubp_3dlut_fl_addressing_mode {
 enum hubp_3dlut_fl_width {
 	hubp_3dlut_fl_width_17 = 17,
 	hubp_3dlut_fl_width_33 = 33,
-	hubp_3dlut_fl_width_transformed    = 4916, //mpc default
+	hubp_3dlut_fl_width_17_transformed    = 4916, //mpc default
 };
 
 enum hubp_3dlut_fl_crossbar_bit_slice {
@@ -99,22 +99,6 @@ enum hubp_3dlut_fl_crossbar_bit_slice {
 	hubp_3dlut_fl_crossbar_bit_slice_48_63 = 3
 };
 
-struct hubp_fl_3dlut_config {
-	bool enabled;
-	enum hubp_3dlut_fl_width width;
-	enum hubp_3dlut_fl_mode mode;
-	enum hubp_3dlut_fl_format format;
-	uint16_t bias;
-	uint16_t scale;
-	struct dc_plane_address address;
-	enum hubp_3dlut_fl_addressing_mode addr_mode;
-	enum dc_cm2_gpu_mem_layout layout;
-	uint8_t protection_bits;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_y_g;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cb_b;
-	enum hubp_3dlut_fl_crossbar_bit_slice crossbar_bit_slice_cr_r;
-};
-
 struct hubp {
 	const struct hubp_funcs *funcs;
 	struct dc_context *ctx;
@@ -243,7 +227,6 @@ struct hubp_funcs {
 	void (*hubp_disable_control)(struct hubp *hubp, bool disable_hubp);
 	unsigned int (*hubp_get_underflow_status)(struct hubp *hubp);
 	void (*hubp_init)(struct hubp *hubp);
-
 	void (*dmdata_set_attributes)(
 			struct hubp *hubp,
 			const struct dc_dmdata_attributes *attr);
@@ -290,24 +273,15 @@ struct hubp_funcs {
 
 	void (*hubp_wait_pipe_read_start)(struct hubp *hubp);
 	void (*hubp_program_mcache_id_and_split_coordinate)(struct hubp *hubp, struct dml2_hubp_pipe_mcache_regs *mcache_regs);
-	void (*hubp_update_3dlut_fl_bias_scale)(struct hubp *hubp, uint16_t bias, uint16_t scale);
-	void (*hubp_program_3dlut_fl_mode)(struct hubp *hubp,
-			enum hubp_3dlut_fl_mode mode);
-	void (*hubp_program_3dlut_fl_format)(struct hubp *hubp,
-			enum hubp_3dlut_fl_format format);
 	void (*hubp_program_3dlut_fl_addr)(struct hubp *hubp,
-		const struct dc_plane_address address);
+		const struct dc_plane_address *address);
+	void (*hubp_program_3dlut_fl_config)(struct hubp *hubp,
+		const struct dc_3dlut_dma *config);
 	void (*hubp_program_3dlut_fl_dlg_param)(struct hubp *hubp, int refcyc_per_3dlut_group);
 	void (*hubp_enable_3dlut_fl)(struct hubp *hubp, bool enable);
-	void (*hubp_program_3dlut_fl_addressing_mode)(struct hubp *hubp, enum hubp_3dlut_fl_addressing_mode addr_mode);
-	void (*hubp_program_3dlut_fl_width)(struct hubp *hubp, enum hubp_3dlut_fl_width width);
-	void (*hubp_program_3dlut_fl_tmz_protected)(struct hubp *hubp, uint8_t protection_bits);
 	void (*hubp_program_3dlut_fl_crossbar)(struct hubp *hubp,
-			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_y_g,
-			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cb_b,
-			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cr_r);
+			enum dc_cm_lut_pixel_format format);
 	int (*hubp_get_3dlut_fl_done)(struct hubp *hubp);
-	void (*hubp_program_3dlut_fl_config)(struct hubp *hubp, struct hubp_fl_3dlut_config *cfg);
 	void (*hubp_clear_tiling)(struct hubp *hubp);
 	uint32_t (*hubp_get_current_read_line)(struct hubp *hubp);
 	uint32_t (*hubp_get_det_config_error)(struct hubp *hubp);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index 2bc86777dfb6..ec5eaea416dc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -153,6 +153,13 @@ struct dc_rgb {
 	uint32_t blue;
 };
 
+struct tetrahedral_33x33x33 {
+	struct dc_rgb lut0[8985];
+	struct dc_rgb lut1[8984];
+	struct dc_rgb lut2[8984];
+	struct dc_rgb lut3[8984];
+};
+
 struct tetrahedral_17x17x17 {
 	struct dc_rgb lut0[1229];
 	struct dc_rgb lut1[1228];
@@ -166,14 +173,23 @@ struct tetrahedral_9x9x9 {
 	struct dc_rgb lut3[182];
 };
 
+enum lut_dimension {
+	LUT_DIM_INVALID = 0,
+	LUT_DIM_9 = 9,
+	LUT_DIM_17 = 17,
+	LUT_DIM_33 = 33,
+};
+
 struct tetrahedral_params {
 	union {
+//TODO: Uncomment when in use.
+//		struct tetrahedral_33x33x33 tetrahedral_33;
 		struct tetrahedral_17x17x17 tetrahedral_17;
 		struct tetrahedral_9x9x9 tetrahedral_9;
 	};
 	bool use_tetrahedral_9;
 	bool use_12bits;
-
+	enum lut_dimension lut_dim;
 };
 
 /* arr_curve_points - regamma regions/segments specification
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 0db607f2a410..f5617674bea8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -54,6 +54,7 @@
 #include "dc_hw_types.h"
 #include "hw_shared.h"
 #include "transform.h"
+#include "dc_types.h"
 
 #define MAX_MPCC 6
 #define MAX_OPP 6
@@ -66,7 +67,6 @@ enum mpc_output_csc_mode {
 	MPC_OUTPUT_CSC_COEF_B
 };
 
-
 enum mpcc_blend_mode {
 	MPCC_BLEND_MODE_BYPASS,
 	MPCC_BLEND_MODE_TOP_LAYER_PASSTHROUGH,
@@ -102,13 +102,6 @@ enum mpcc_movable_cm_location {
 	MPCC_MOVABLE_CM_LOCATION_AFTER,
 };
 
-enum MCM_LUT_XABLE {
-	MCM_LUT_DISABLE,
-	MCM_LUT_DISABLED = MCM_LUT_DISABLE,
-	MCM_LUT_ENABLE,
-	MCM_LUT_ENABLED = MCM_LUT_ENABLE,
-};
-
 enum MCM_LUT_ID {
 	MCM_LUT_3DLUT,
 	MCM_LUT_1DLUT,
@@ -117,7 +110,7 @@ enum MCM_LUT_ID {
 
 struct mpc_fl_3dlut_config {
 	bool enabled;
-	uint16_t width;
+	enum dc_cm_lut_size size;
 	bool select_lut_bank_a;
 	uint16_t bit_depth;
 	int hubp_index;
@@ -1042,22 +1035,22 @@ struct mpc_funcs {
 
 	void (*update_3dlut_fast_load_select)(struct mpc *mpc, int mpcc_id, int hubp_idx);
 
-/**
- * @get_3dlut_fast_load_status:
- *
- * Get 3D LUT fast load status and reference them with done, soft_underflow and hard_underflow pointers.
- *
- * Parameters:
- * - [in/out] mpc - MPC context.
- * - [in] mpcc_id
- * - [in/out] done
- * - [in/out] soft_underflow
- * - [in/out] hard_underflow
- *
- * Return:
- *
- * void
- */
+	/**
+	* @get_3dlut_fast_load_status:
+	*
+	* Get 3D LUT fast load status and reference them with done, soft_underflow and hard_underflow pointers.
+	*
+	* Parameters:
+	* - [in/out] mpc - MPC context.
+	* - [in] mpcc_id
+	* - [in/out] done
+	* - [in/out] soft_underflow
+	* - [in/out] hard_underflow
+	*
+	* Return:
+	*
+	* void
+	*/
 	void (*get_3dlut_fast_load_status)(struct mpc *mpc, int mpcc_id, uint32_t *done, uint32_t *soft_underflow, uint32_t *hard_underflow);
 
 	/**
@@ -1076,8 +1069,11 @@ struct mpc_funcs {
 	*
 	* void
 	*/
-	void (*populate_lut)(struct mpc *mpc, const enum MCM_LUT_ID id, const union mcm_lut_params params,
-			bool lut_bank_a, int mpcc_id);
+	void (*populate_lut)(struct mpc *mpc,
+			const enum MCM_LUT_ID id,
+			const union mcm_lut_params *params,
+			const bool lut_bank_a,
+			const int mpcc_id);
 
 	/**
 	* @program_lut_read_write_control:
@@ -1088,13 +1084,18 @@ struct mpc_funcs {
 	* - [in/out] mpc - MPC context.
 	* - [in] id
 	* - [in] lut_bank_a
+	* - [in] bit_depth
 	* - [in] mpcc_id
 	*
 	* Return:
 	*
 	* void
 	*/
-	void (*program_lut_read_write_control)(struct mpc *mpc, const enum MCM_LUT_ID id, bool lut_bank_a, int mpcc_id);
+	void (*program_lut_read_write_control)(struct mpc *mpc,
+		const enum MCM_LUT_ID id,
+		const bool lut_bank_a,
+		const unsigned int bit_depth,
+		const int mpcc_id);
 
 	/**
 	* @program_lut_mode:
@@ -1104,33 +1105,44 @@ struct mpc_funcs {
 	* Parameters:
 	* - [in/out] mpc - MPC context.
 	* - [in] id
-	* - [in] xable
+	* - [in] enable
 	* - [in] lut_bank_a
+	* - [in] size
 	* - [in] mpcc_id
 	*
 	* Return:
 	*
 	* void
 	*/
-	void (*program_lut_mode)(struct mpc *mpc, const enum MCM_LUT_ID id, const enum MCM_LUT_XABLE xable,
-			bool lut_bank_a, int mpcc_id);
+	void (*program_lut_mode)(struct mpc *mpc,
+			const enum MCM_LUT_ID id,
+			const bool enable,
+			const bool lut_bank_a,
+			const enum dc_cm_lut_size size,
+			const int mpcc_id);
 
-	/**
-	 * @mcm:
-	 *
-	 * MPC MCM new HW sequential programming functions
-	 */
-	struct {
-		void (*program_3dlut_size)(struct mpc *mpc, uint32_t width, int mpcc_id);
-		void (*program_bias_scale)(struct mpc *mpc, uint16_t bias, uint16_t scale, int mpcc_id);
-		void (*program_bit_depth)(struct mpc *mpc, uint16_t bit_depth, int mpcc_id);
-		bool (*is_config_supported)(uint32_t width);
-		void (*program_lut_read_write_control)(struct mpc *mpc, const enum MCM_LUT_ID id,
-			bool lut_bank_a, bool enabled, int mpcc_id);
 
-		void (*populate_lut)(struct mpc *mpc, const union mcm_lut_params params,
-			bool lut_bank_a, int mpcc_id);
-	} mcm;
+	/**
+	* @get_lut_mode:
+	*
+	* Obtains enablement and ram bank status.
+	*
+	* Parameters:
+	* - [in/out] mpc - MPC context.
+	* - [in] id
+	* - [in] mpcc_id
+	* - [out] enable
+	* - [out] lut_bank_a
+	*
+	* Return:
+	*
+	* void
+	*/
+	void (*get_lut_mode)(struct mpc *mpc,
+			const enum MCM_LUT_ID id,
+			const int mpcc_id,
+			bool *enable,
+			bool *lut_bank_a);
 
 	/**
 	 * @rmcm:
@@ -1143,9 +1155,11 @@ struct mpc_funcs {
 		void (*update_3dlut_fast_load_select)(struct mpc *mpc, int mpcc_id, int hubp_idx);
 		void (*program_lut_read_write_control)(struct mpc *mpc, const enum MCM_LUT_ID id,
 			bool lut_bank_a, bool enabled, int mpcc_id);
-		void (*program_lut_mode)(struct mpc *mpc, const enum MCM_LUT_XABLE xable,
-			bool lut_bank_a, int mpcc_id);
-		void (*program_3dlut_size)(struct mpc *mpc, uint32_t width, int mpcc_id);
+		void (*program_lut_mode)(struct mpc *mpc,
+			bool enable,
+			bool lut_bank_a,
+			int mpcc_id);
+		void (*program_3dlut_size)(struct mpc *mpc, const enum dc_cm_lut_size size, int mpcc_id);
 		void (*program_bias_scale)(struct mpc *mpc, uint16_t bias, uint16_t scale, int mpcc_id);
 		void (*program_bit_depth)(struct mpc *mpc, uint16_t bit_depth, int mpcc_id);
 		bool (*is_config_supported)(uint32_t width);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 79746d931471..cecd3282a29f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -60,6 +60,7 @@ struct resource_caps {
 	int num_hpo_dp_stream_encoder;
 	int num_hpo_dp_link_encoder;
 	int num_mpc_3dlut;
+	int num_rmcm;
 };
 
 struct resource_straps {
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
index ce1ee2062e41..e0617db2d0c1 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
@@ -73,56 +73,15 @@ void mpc401_set_movable_cm_location(struct mpc *mpc, enum mpcc_movable_cm_locati
 	}
 }
 
-static enum dc_lut_mode get3dlut_config(
-			struct mpc *mpc,
-			bool *is_17x17x17,
-			bool *is_12bits_color_channel,
-			int mpcc_id)
-{
-	uint32_t i_mode, i_enable_10bits, lut_size;
-	enum dc_lut_mode mode;
-	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
-
-	REG_GET(MPCC_MCM_3DLUT_MODE[mpcc_id],
-			MPCC_MCM_3DLUT_MODE_CURRENT,  &i_mode);
-
-	REG_GET(MPCC_MCM_3DLUT_READ_WRITE_CONTROL[mpcc_id],
-			MPCC_MCM_3DLUT_30BIT_EN, &i_enable_10bits);
-
-	switch (i_mode) {
-	case 0:
-		mode = LUT_BYPASS;
-		break;
-	case 1:
-		mode = LUT_RAM_A;
-		break;
-	case 2:
-		mode = LUT_RAM_B;
-		break;
-	default:
-		mode = LUT_BYPASS;
-		break;
-	}
-	if (i_enable_10bits > 0)
-		*is_12bits_color_channel = false;
-	else
-		*is_12bits_color_channel = true;
-
-	REG_GET(MPCC_MCM_3DLUT_MODE[mpcc_id], MPCC_MCM_3DLUT_SIZE, &lut_size);
-
-	if (lut_size == 0)
-		*is_17x17x17 = true;
-	else
-		*is_17x17x17 = false;
-
-	return mode;
-}
-
-void mpc401_populate_lut(struct mpc *mpc, const enum MCM_LUT_ID id, const union mcm_lut_params params, bool lut_bank_a, int mpcc_id)
+void mpc401_populate_lut(struct mpc *mpc,
+		const enum MCM_LUT_ID id,
+		const union mcm_lut_params *params,
+		const bool lut_bank_a,
+		const int mpcc_id)
 {
 	const enum dc_lut_mode next_mode = lut_bank_a ? LUT_RAM_A : LUT_RAM_B;
-	const struct pwl_params *lut1d = params.pwl;
-	const struct pwl_params *lut_shaper = params.pwl;
+	const struct pwl_params *lut1d = params->pwl;
+	const struct pwl_params *lut_shaper = params->pwl;
 	bool is_17x17x17;
 	bool is_12bits_color_channel;
 	const struct dc_rgb *lut0;
@@ -131,7 +90,7 @@ void mpc401_populate_lut(struct mpc *mpc, const enum MCM_LUT_ID id, const union
 	const struct dc_rgb *lut3;
 	int lut_size0;
 	int lut_size;
-	const struct tetrahedral_params *lut3d = params.lut3d;
+	const struct tetrahedral_params *lut3d = params->lut3d;
 
 	switch (id) {
 	case MCM_LUT_1DLUT:
@@ -174,8 +133,6 @@ void mpc401_populate_lut(struct mpc *mpc, const enum MCM_LUT_ID id, const union
 
 		mpc32_power_on_shaper_3dlut(mpc, mpcc_id, true);
 
-		get3dlut_config(mpc, &is_17x17x17, &is_12bits_color_channel, mpcc_id);
-
 		is_17x17x17 = !lut3d->use_tetrahedral_9;
 		is_12bits_color_channel = lut3d->use_12bits;
 		if (is_17x17x17) {
@@ -198,8 +155,6 @@ void mpc401_populate_lut(struct mpc *mpc, const enum MCM_LUT_ID id, const union
 					sizeof(lut3d->tetrahedral_9.lut1[0]);
 			}
 
-		mpc32_select_3dlut_ram(mpc, next_mode,
-					is_12bits_color_channel, mpcc_id);
 		mpc32_select_3dlut_ram_mask(mpc, 0x1, mpcc_id);
 		if (is_12bits_color_channel)
 			mpc32_set3dlut_ram12(mpc, lut0, lut_size0, mpcc_id);
@@ -232,46 +187,69 @@ void mpc401_populate_lut(struct mpc *mpc, const enum MCM_LUT_ID id, const union
 
 }
 
+static uint32_t mpc401_cm_lut_size_to_3dlut_size(const enum dc_cm_lut_size cm_size)
+{
+	uint32_t size = 0;
+
+	switch (cm_size) {
+	case CM_LUT_SIZE_999:
+		size = 1;
+		break;
+	case CM_LUT_SIZE_171717:
+		size = 0;
+		break;
+	default:
+		/* invalid LUT size */
+		ASSERT(false);
+		size = 0;
+		break;
+	}
+
+	return size;
+}
+
 void mpc401_program_lut_mode(
 		struct mpc *mpc,
 		const enum MCM_LUT_ID id,
-		const enum MCM_LUT_XABLE xable,
-		bool lut_bank_a,
-		int mpcc_id)
+		const bool enable,
+		const bool lut_bank_a,
+		const enum dc_cm_lut_size size,
+		const int mpcc_id)
 {
+	uint32_t lut_size;
 	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
 
 	switch (id) {
 	case MCM_LUT_3DLUT:
-		switch (xable) {
-		case MCM_LUT_DISABLE:
+		if (enable) {
+			lut_size = mpc401_cm_lut_size_to_3dlut_size(size);
+			REG_UPDATE_2(MPCC_MCM_3DLUT_MODE[mpcc_id],
+					MPCC_MCM_3DLUT_MODE, lut_bank_a ? 1 : 2,
+					MPCC_MCM_3DLUT_SIZE, lut_size);
+		} else {
+			if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc)
+				mpc32_power_on_shaper_3dlut(mpc, mpcc_id, false);
 			REG_UPDATE(MPCC_MCM_3DLUT_MODE[mpcc_id], MPCC_MCM_3DLUT_MODE, 0);
-			break;
-		case MCM_LUT_ENABLE:
-			REG_UPDATE(MPCC_MCM_3DLUT_MODE[mpcc_id], MPCC_MCM_3DLUT_MODE, lut_bank_a ? 1 : 2);
-			break;
 		}
 		break;
 	case MCM_LUT_SHAPER:
-		switch (xable) {
-		case MCM_LUT_DISABLE:
-			REG_UPDATE(MPCC_MCM_SHAPER_CONTROL[mpcc_id], MPCC_MCM_SHAPER_LUT_MODE, 0);
-			break;
-		case MCM_LUT_ENABLE:
+		if (enable) {
 			REG_UPDATE(MPCC_MCM_SHAPER_CONTROL[mpcc_id], MPCC_MCM_SHAPER_LUT_MODE, lut_bank_a ? 1 : 2);
-			break;
+		} else {
+			if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc)
+				mpc32_power_on_shaper_3dlut(mpc, mpcc_id, false);
+			REG_UPDATE(MPCC_MCM_SHAPER_CONTROL[mpcc_id], MPCC_MCM_SHAPER_LUT_MODE, 0);
 		}
 		break;
 	case MCM_LUT_1DLUT:
-		switch (xable) {
-		case MCM_LUT_DISABLE:
-			REG_UPDATE(MPCC_MCM_1DLUT_CONTROL[mpcc_id],
-					MPCC_MCM_1DLUT_MODE, 0);
-			break;
-		case MCM_LUT_ENABLE:
+		if (enable) {
 			REG_UPDATE(MPCC_MCM_1DLUT_CONTROL[mpcc_id],
 					MPCC_MCM_1DLUT_MODE, 2);
-			break;
+		} else {
+			if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc)
+				mpc32_power_on_blnd_lut(mpc, mpcc_id, false);
+			REG_UPDATE(MPCC_MCM_1DLUT_CONTROL[mpcc_id],
+					MPCC_MCM_1DLUT_MODE, 0);
 		}
 		REG_UPDATE(MPCC_MCM_1DLUT_CONTROL[mpcc_id],
 				MPCC_MCM_1DLUT_SELECT, lut_bank_a ? 0 : 1);
@@ -279,14 +257,20 @@ void mpc401_program_lut_mode(
 	}
 }
 
-void mpc401_program_lut_read_write_control(struct mpc *mpc, const enum MCM_LUT_ID id, bool lut_bank_a, int mpcc_id)
+void mpc401_program_lut_read_write_control(struct mpc *mpc,
+		const enum MCM_LUT_ID id,
+		const bool lut_bank_a,
+		const unsigned int bit_depth,
+		const int mpcc_id)
 {
 	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
 
 	switch (id) {
 	case MCM_LUT_3DLUT:
 		mpc32_select_3dlut_ram_mask(mpc, 0xf, mpcc_id);
-		REG_UPDATE(MPCC_MCM_3DLUT_READ_WRITE_CONTROL[mpcc_id], MPCC_MCM_3DLUT_RAM_SEL, lut_bank_a ? 0 : 1);
+		REG_UPDATE_2(MPCC_MCM_3DLUT_READ_WRITE_CONTROL[mpcc_id],
+				MPCC_MCM_3DLUT_30BIT_EN, (bit_depth == 10) ? 1 : 0,
+				MPCC_MCM_3DLUT_RAM_SEL, lut_bank_a ? 0 : 1);
 		break;
 	case MCM_LUT_SHAPER:
 		mpc32_configure_shaper_lut(mpc, lut_bank_a, mpcc_id);
@@ -578,6 +562,44 @@ void mpc401_get_gamut_remap(struct mpc *mpc,
 		arr_reg_val, ARRAY_SIZE(arr_reg_val));
 }
 
+void mpc401_get_lut_mode(struct mpc *mpc,
+		const enum MCM_LUT_ID id,
+		const int mpcc_id,
+		bool *enable,
+		bool *lut_bank_a)
+{
+	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
+
+	uint32_t lut_mode = 0;
+	uint32_t lut_select = 0;
+
+	*enable = false;
+	*lut_bank_a = true;
+
+	switch (id) {
+	case MCM_LUT_SHAPER:
+		REG_GET(MPCC_MCM_SHAPER_CONTROL[mpcc_id],
+				MPCC_MCM_SHAPER_MODE_CURRENT, &lut_mode);
+		*enable = lut_mode != 0;
+		*lut_bank_a = lut_mode != 2;
+		break;
+	case MCM_LUT_1DLUT:
+		REG_GET_2(MPCC_MCM_1DLUT_CONTROL[mpcc_id],
+				MPCC_MCM_1DLUT_MODE_CURRENT, &lut_mode,
+				MPCC_MCM_1DLUT_SELECT_CURRENT, &lut_select);
+		*enable = lut_mode != 0;
+		*lut_bank_a = lut_mode == 0 || lut_select == 0;
+		break;
+	case MCM_LUT_3DLUT:
+	default:
+		REG_GET(MPCC_MCM_3DLUT_MODE[mpcc_id],
+				MPCC_MCM_3DLUT_MODE_CURRENT, &lut_mode);
+		*enable = lut_mode != 0;
+		*lut_bank_a = lut_mode != 2;
+		break;
+	}
+}
+
 static const struct mpc_funcs dcn401_mpc_funcs = {
 	.read_mpcc_state = mpc1_read_mpcc_state,
 	.insert_plane = mpc1_insert_plane,
@@ -616,6 +638,7 @@ static const struct mpc_funcs dcn401_mpc_funcs = {
 	.populate_lut = mpc401_populate_lut,
 	.program_lut_read_write_control = mpc401_program_lut_read_write_control,
 	.program_lut_mode = mpc401_program_lut_mode,
+	.get_lut_mode = mpc401_get_lut_mode,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
index 6d842d7b95c7..c16560c84453 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
@@ -206,21 +206,32 @@ void dcn401_mpc_construct(struct dcn401_mpc *mpc401,
 	int num_rmu);
 
 void mpc401_set_movable_cm_location(struct mpc *mpc, enum mpcc_movable_cm_location location, int mpcc_id);
-void mpc401_populate_lut(struct mpc *mpc, const enum MCM_LUT_ID id, const union mcm_lut_params params,
-		bool lut_bank_a, int mpcc_id);
+void mpc401_populate_lut(struct mpc *mpc,
+		const enum MCM_LUT_ID id,
+		const union mcm_lut_params *params,
+		bool lut_bank_a,
+		int mpcc_id);
 
 void mpc401_program_lut_mode(
 		struct mpc *mpc,
 		const enum MCM_LUT_ID id,
-		const enum MCM_LUT_XABLE xable,
-		bool lut_bank_a,
-		int mpcc_id);
+		const bool enable,
+		const bool lut_bank_a,
+		const enum dc_cm_lut_size size,
+		const int mpcc_id);
+
+void mpc401_get_lut_mode(struct mpc *mpc,
+		const enum MCM_LUT_ID id,
+		const int mpcc_id,
+		bool *enable,
+		bool *lut_bank_a);
 
 void mpc401_program_lut_read_write_control(
 		struct mpc *mpc,
 		const enum MCM_LUT_ID id,
-		bool lut_bank_a,
-		int mpcc_id);
+		const bool lut_bank_a,
+		const unsigned int bit_depth,
+		const int mpcc_id);
 
 void mpc401_set_gamut_remap(
 	struct mpc *mpc,
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c
index 304b23109fb0..507dbdbea600 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c
@@ -20,7 +20,7 @@
 	mpc42->mpc_shift->field_name, mpc42->mpc_mask->field_name
 
 
-static void mpc42_init_mpcc(struct mpcc *mpcc, int mpcc_inst)
+void mpc42_init_mpcc(struct mpcc *mpcc, int mpcc_inst)
 {
 	mpcc->mpcc_id = mpcc_inst;
 	mpcc->dpp_id = 0xf;
@@ -63,154 +63,6 @@ void mpc42_update_blending(
 	mpcc->blnd_cfg = *blnd_cfg;
 }
 
-/* Shaper functions */
-void mpc42_power_on_shaper_3dlut(
-	struct mpc *mpc,
-	uint32_t mpcc_id,
-	bool power_on)
-{
-	uint32_t power_status_shaper = 2;
-	uint32_t power_status_3dlut  = 2;
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-	int max_retries = 10;
-
-	REG_SET(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], 0,
-		MPCC_MCM_3DLUT_MEM_PWR_DIS, power_on == true ? 1:0);
-	REG_SET(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], 0,
-		MPCC_MCM_SHAPER_MEM_PWR_DIS, power_on == true ? 1:0);
-	/* wait for memory to fully power up */
-	if (power_on && mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc) {
-		REG_WAIT(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], MPCC_MCM_SHAPER_MEM_PWR_STATE, 0, 1, max_retries);
-		REG_WAIT(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], MPCC_MCM_3DLUT_MEM_PWR_STATE, 0, 1, max_retries);
-	}
-
-	/*read status is not mandatory, it is just for debugging*/
-	REG_GET(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], MPCC_MCM_SHAPER_MEM_PWR_STATE, &power_status_shaper);
-	REG_GET(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], MPCC_MCM_3DLUT_MEM_PWR_STATE, &power_status_3dlut);
-
-	if (power_status_shaper != 0 && power_on == true)
-		BREAK_TO_DEBUGGER();
-
-	if (power_status_3dlut != 0 && power_on == true)
-		BREAK_TO_DEBUGGER();
-}
-
-void mpc42_configure_shaper_lut(
-	struct mpc *mpc,
-	bool is_ram_a,
-	uint32_t mpcc_id)
-{
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
-	REG_UPDATE(MPCC_MCM_SHAPER_SCALE_G_B[mpcc_id],
-		MPCC_MCM_SHAPER_SCALE_B, 0x7000);
-	REG_UPDATE(MPCC_MCM_SHAPER_SCALE_G_B[mpcc_id],
-		MPCC_MCM_SHAPER_SCALE_G, 0x7000);
-	REG_UPDATE(MPCC_MCM_SHAPER_SCALE_R[mpcc_id],
-		MPCC_MCM_SHAPER_SCALE_R, 0x7000);
-	REG_UPDATE(MPCC_MCM_SHAPER_LUT_WRITE_EN_MASK[mpcc_id],
-			MPCC_MCM_SHAPER_LUT_WRITE_EN_MASK, 7);
-	REG_UPDATE(MPCC_MCM_SHAPER_LUT_WRITE_EN_MASK[mpcc_id],
-			MPCC_MCM_SHAPER_LUT_WRITE_SEL, is_ram_a == true ? 0:1);
-	REG_SET(MPCC_MCM_SHAPER_LUT_INDEX[mpcc_id], 0, MPCC_MCM_SHAPER_LUT_INDEX, 0);
-}
-
-
-void mpc42_program_3dlut_size(struct mpc *mpc, uint32_t width, int mpcc_id)
-{
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-	uint32_t size = 0xff;
-
-	REG_GET(MPCC_MCM_3DLUT_MODE[mpcc_id], MPCC_MCM_3DLUT_SIZE, &size);
-
-	REG_UPDATE(MPCC_MCM_3DLUT_MODE[mpcc_id], MPCC_MCM_3DLUT_SIZE,
-		(width == 33) ? 2 :
-		(width == 17) ? 0 : 2);
-
-	REG_GET(MPCC_MCM_3DLUT_MODE[mpcc_id], MPCC_MCM_3DLUT_SIZE, &size);
-}
-
-void mpc42_program_3dlut_fl_bias_scale(struct mpc *mpc, uint16_t bias, uint16_t scale, int mpcc_id)
-{
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
-	REG_UPDATE_2(MPCC_MCM_3DLUT_OUT_OFFSET_R[mpcc_id],
-		MPCC_MCM_3DLUT_OUT_OFFSET_R, bias,
-		MPCC_MCM_3DLUT_OUT_SCALE_R, scale);
-
-	REG_UPDATE_2(MPCC_MCM_3DLUT_OUT_OFFSET_G[mpcc_id],
-		MPCC_MCM_3DLUT_OUT_OFFSET_G, bias,
-		MPCC_MCM_3DLUT_OUT_SCALE_G, scale);
-
-	REG_UPDATE_2(MPCC_MCM_3DLUT_OUT_OFFSET_B[mpcc_id],
-		MPCC_MCM_3DLUT_OUT_OFFSET_B, bias,
-		MPCC_MCM_3DLUT_OUT_SCALE_B, scale);
-}
-
-void mpc42_program_bit_depth(struct mpc *mpc, uint16_t bit_depth, int mpcc_id)
-{
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
-	REG_UPDATE(MPCC_MCM_3DLUT_READ_WRITE_CONTROL[mpcc_id], MPCC_MCM_3DLUT_WRITE_EN_MASK, 0xF);
-
-	//program bit_depth
-	REG_UPDATE(MPCC_MCM_3DLUT_READ_WRITE_CONTROL[mpcc_id],
-		MPCC_MCM_3DLUT_30BIT_EN,
-		(bit_depth == 10) ? 1 : 0);
-}
-
-bool mpc42_is_config_supported(uint32_t width)
-{
-	if (width == 17)
-		return true;
-
-	return false;
-}
-
-void mpc42_populate_lut(struct mpc *mpc, const union mcm_lut_params params,
-	bool lut_bank_a, int mpcc_id)
-{
-	const enum dc_lut_mode next_mode = lut_bank_a ? LUT_RAM_A : LUT_RAM_B;
-	const struct pwl_params *lut_shaper = params.pwl;
-
-	if (lut_shaper == NULL)
-		return;
-	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.mpc)
-		mpc42_power_on_shaper_3dlut(mpc, mpcc_id, true);
-
-	mpc42_configure_shaper_lut(mpc, next_mode == LUT_RAM_A, mpcc_id);
-
-	if (next_mode == LUT_RAM_A)
-		mpc32_program_shaper_luta_settings(mpc, lut_shaper, mpcc_id);
-	else
-		mpc32_program_shaper_lutb_settings(mpc, lut_shaper, mpcc_id);
-
-	mpc32_program_shaper_lut(
-			mpc, lut_shaper->rgb_resulted, lut_shaper->hw_points_num, mpcc_id);
-
-	mpc42_power_on_shaper_3dlut(mpc, mpcc_id, false);
-}
-
-void mpc42_program_lut_read_write_control(struct mpc *mpc, const enum MCM_LUT_ID id,
-	bool lut_bank_a, bool enabled, int mpcc_id)
-{
-	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-
-	switch (id) {
-	case MCM_LUT_3DLUT:
-		REG_UPDATE(MPCC_MCM_3DLUT_MODE[mpcc_id], MPCC_MCM_3DLUT_MODE,
-			(!enabled) ? 0 :
-			(lut_bank_a) ? 1 : 2);
-		REG_UPDATE(MPCC_MCM_3DLUT_READ_WRITE_CONTROL[mpcc_id], MPCC_MCM_3DLUT_RAM_SEL, lut_bank_a ? 0 : 1);
-		break;
-	case MCM_LUT_SHAPER:
-		mpc32_configure_shaper_lut(mpc, lut_bank_a, mpcc_id);
-		break;
-	default:
-		break;
-	}
-}
-
 /* RMCM Shaper functions */
 void mpc42_power_on_rmcm_shaper_3dlut(
 	struct mpc *mpc,
@@ -674,32 +526,47 @@ void mpc42_program_rmcm_lut_read_write_control(struct mpc *mpc, const enum MCM_L
 	}
 }
 
-void mpc42_program_lut_mode(struct mpc *mpc, const enum MCM_LUT_XABLE xable,
-	bool lut_bank_a, int mpcc_id)
+void mpc42_program_lut_mode(struct mpc *mpc,
+	bool enable,
+	bool lut_bank_a,
+	int mpcc_id)
 {
 	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
 
-	switch (xable) {
-	case MCM_LUT_DISABLE:
+	if (enable) {
+		REG_UPDATE(MPC_RMCM_SHAPER_CONTROL[mpcc_id], MPC_RMCM_SHAPER_LUT_MODE, lut_bank_a ? 1 : 2);
+	} else {
 		REG_UPDATE(MPC_RMCM_SHAPER_CONTROL[mpcc_id], MPC_RMCM_SHAPER_LUT_MODE, 0);
+	}
+}
+
+static uint32_t mpc42_get_rmcm_3dlut_width(
+		const enum dc_cm_lut_size size)
+{
+	uint32_t width = 0;
+
+	switch (size) {
+	case CM_LUT_SIZE_333333:
+		width = 2;
 		break;
-	case MCM_LUT_ENABLE:
-		REG_UPDATE(MPC_RMCM_SHAPER_CONTROL[mpcc_id], MPC_RMCM_SHAPER_LUT_MODE, lut_bank_a ? 1 : 2);
+	case CM_LUT_SIZE_171717:
+	default:
+		width = 0;
 		break;
 	}
+
+	return width;
 }
 
-void mpc42_program_rmcm_3dlut_size(struct mpc *mpc, uint32_t width, int mpcc_id)
+void mpc42_program_rmcm_3dlut_size(struct mpc *mpc,
+		const enum dc_cm_lut_size size,
+		int mpcc_id)
 {
 	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-	uint32_t size = 0xff;
-
-	REG_GET(MPC_RMCM_3DLUT_MODE[mpcc_id], MPC_RMCM_3DLUT_SIZE, &size);
+	uint32_t width = mpc42_get_rmcm_3dlut_width(size);
 
-	REG_UPDATE(MPC_RMCM_3DLUT_MODE[mpcc_id], MPC_RMCM_3DLUT_SIZE,
-		(width == 33) ? 2 : 0);
-
-	REG_GET(MPC_RMCM_3DLUT_MODE[mpcc_id], MPC_RMCM_3DLUT_SIZE, &size);
+	REG_UPDATE(MPC_RMCM_3DLUT_MODE[mpcc_id],
+			MPC_RMCM_3DLUT_SIZE, width);
 }
 
 void mpc42_program_rmcm_3dlut_fast_load_bias_scale(struct mpc *mpc, uint16_t bias, uint16_t scale, int mpcc_id)
@@ -731,14 +598,6 @@ void mpc42_program_rmcm_bit_depth(struct mpc *mpc, uint16_t bit_depth, int mpcc_
 		(bit_depth == 10) ? 1 : 0);
 }
 
-bool mpc42_is_rmcm_config_supported(uint32_t width)
-{
-	if (width == 17 || width == 33)
-		return true;
-
-	return false;
-}
-
 void mpc42_set_fl_config(
 	struct mpc *mpc,
 	struct mpc_fl_3dlut_config *cfg,
@@ -746,6 +605,7 @@ void mpc42_set_fl_config(
 {
 	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
 
+	uint32_t width = mpc42_get_rmcm_3dlut_width(cfg->size);
 	/*
 	From: Jie Zhou
 
@@ -786,7 +646,7 @@ void mpc42_set_fl_config(
 
 	//width
 	REG_UPDATE_2(MPC_RMCM_3DLUT_MODE[mpcc_id],
-		MPC_RMCM_3DLUT_SIZE, (cfg->width == 33) ? 2 : 0,
+		MPC_RMCM_3DLUT_SIZE, width,
 		MPC_RMCM_3DLUT_MODE, (!cfg->enabled) ? 0 : (cfg->select_lut_bank_a) ? 1 : 2);
 
 	//connect to hubp
@@ -799,182 +659,6 @@ void mpc42_set_fl_config(
 	REG_UPDATE(MPC_RMCM_CNTL[mpcc_id], MPC_RMCM_CNTL, cfg->enabled ? 0 : 0xF);
 }
 
-//static void rmcm_program_gamut_remap(
-//	struct mpc *mpc,
-//	unsigned int mpcc_id,
-//	const uint16_t *regval,
-//	enum mpcc_gamut_remap_id gamut_remap_block_id,
-//	enum mpcc_gamut_remap_mode_select mode_select)
-//{
-//	struct color_matrices_reg gamut_regs;
-//	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-//
-//	if (gamut_remap_block_id == MPCC_OGAM_GAMUT_REMAP ||
-//		gamut_remap_block_id == MPCC_MCM_FIRST_GAMUT_REMAP ||
-//		gamut_remap_block_id == MPCC_MCM_SECOND_GAMUT_REMAP) {
-//		mpc_program_gamut_remap(mpc, mpcc_id, regval, gamut_remap_block_id, mode_select);
-//		return;
-//	}
-//	if (gamut_remap_block_id == MPCC_OGAM_GAMUT_REMAP) {
-//
-//		if (regval == NULL || mode_select == MPCC_GAMUT_REMAP_MODE_SELECT_0) {
-//			REG_SET(MPC_RMCM_GAMUT_REMAP_MODE[mpcc_id], 0,
-//				MPC_RMCM_GAMUT_REMAP_MODE, mode_select);
-//			return;
-//		}
-//
-//		gamut_regs.shifts.csc_c11 = mpc42->mpc_shift->MPCC_GAMUT_REMAP_C11_A;
-//		gamut_regs.masks.csc_c11 = mpc42->mpc_mask->MPCC_GAMUT_REMAP_C11_A;
-//		gamut_regs.shifts.csc_c12 = mpc42->mpc_shift->MPCC_GAMUT_REMAP_C12_A;
-//		gamut_regs.masks.csc_c12 = mpc42->mpc_mask->MPCC_GAMUT_REMAP_C12_A;
-//
-//		switch (mode_select) {
-//		case MPCC_GAMUT_REMAP_MODE_SELECT_1:
-//			gamut_regs.csc_c11_c12 = REG(MPC_RMCM_GAMUT_REMAP_C11_C12_A[mpcc_id]);
-//			gamut_regs.csc_c33_c34 = REG(MPC_RMCM_GAMUT_REMAP_C33_C34_A[mpcc_id]);
-//			break;
-//		case MPCC_GAMUT_REMAP_MODE_SELECT_2:
-//			gamut_regs.csc_c11_c12 = REG(MPC_RMCM_GAMUT_REMAP_C11_C12_B[mpcc_id]);
-//			gamut_regs.csc_c33_c34 = REG(MPC_RMCM_GAMUT_REMAP_C33_C34_B[mpcc_id]);
-//			break;
-//		default:
-//			break;
-//		}
-//
-//		cm_helper_program_color_matrices(
-//			mpc->ctx,
-//			regval,
-//			&gamut_regs);
-//
-//		//select coefficient set to use, set A (MODE_1) or set B (MODE_2)
-//		REG_SET(MPC_RMCM_GAMUT_REMAP_MODE[mpcc_id], 0, MPC_RMCM_GAMUT_REMAP_MODE, mode_select);
-//	}
-//}
-
-//static bool is_mpc_legacy_gamut_id(enum mpcc_gamut_remap_id gamut_remap_block_id)
-//{
-//	if (gamut_remap_block_id == MPCC_OGAM_GAMUT_REMAP ||
-//		gamut_remap_block_id == MPCC_MCM_FIRST_GAMUT_REMAP ||
-//		gamut_remap_block_id == MPCC_MCM_SECOND_GAMUT_REMAP) {
-//		return true;
-//	}
-//	return false;
-//}
-//static void program_gamut_remap(
-//	struct mpc *mpc,
-//	unsigned int mpcc_id,
-//	const uint16_t *regval,
-//	enum mpcc_gamut_remap_id gamut_remap_block_id,
-//	enum mpcc_gamut_remap_mode_select mode_select)
-//{
-//	if (is_mpc_legacy_gamut_id(gamut_remap_block_id))
-//		mpc_program_gamut_remap(mpc, mpcc_id, regval, gamut_remap_block_id, mode_select);
-//	else
-//		rmcm_program_gamut_remap(mpc, mpcc_id, regval, gamut_remap_block_id, mode_select);
-//}
-
-//void mpc42_set_gamut_remap(
-//	struct mpc *mpc,
-//	int mpcc_id,
-//	const struct mpc_grph_gamut_adjustment *adjust)
-//{
-//	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-//	unsigned int i = 0;
-//	uint32_t mode_select = 0;
-//
-//	if (adjust->gamut_adjust_type != GRAPHICS_GAMUT_ADJUST_TYPE_SW) {
-//		/* Bypass / Disable if type is bypass or hw */
-//		program_gamut_remap(mpc, mpcc_id, NULL,
-//			adjust->mpcc_gamut_remap_block_id, MPCC_GAMUT_REMAP_MODE_SELECT_0);
-//	} else {
-//		struct fixed31_32 arr_matrix[12];
-//		uint16_t arr_reg_val[12];
-//
-//		for (i = 0; i < 12; i++)
-//			arr_matrix[i] = adjust->temperature_matrix[i];
-//
-//		convert_float_matrix(arr_reg_val, arr_matrix, 12);
-//
-//		if (is_mpc_legacy_gamut_id(adjust->mpcc_gamut_remap_block_id))
-//			REG_GET(MPCC_GAMUT_REMAP_MODE[mpcc_id],
-//				MPCC_GAMUT_REMAP_MODE_CURRENT, &mode_select);
-//		else
-//			REG_GET(MPC_RMCM_GAMUT_REMAP_MODE[mpcc_id],
-//				MPC_RMCM_GAMUT_REMAP_MODE_CURRENT, &mode_select);
-//
-//		//If current set in use not set A (MODE_1), then use set A, otherwise use set B
-//		if (mode_select != MPCC_GAMUT_REMAP_MODE_SELECT_1)
-//			mode_select = MPCC_GAMUT_REMAP_MODE_SELECT_1;
-//		else
-//			mode_select = MPCC_GAMUT_REMAP_MODE_SELECT_2;
-//
-//		program_gamut_remap(mpc, mpcc_id, arr_reg_val,
-//			adjust->mpcc_gamut_remap_block_id, mode_select);
-//	}
-//}
-
-//static void read_gamut_remap(struct mpc *mpc,
-//	int mpcc_id,
-//	uint16_t *regval,
-//	enum mpcc_gamut_remap_id gamut_remap_block_id,
-//	uint32_t *mode_select)
-//{
-//	struct color_matrices_reg gamut_regs = {0};
-//	struct dcn42_mpc *mpc42 = TO_DCN42_MPC(mpc);
-//
-//	if (is_mpc_legacy_gamut_id(gamut_remap_block_id)) {
-//		mpc_read_gamut_remap(mpc, mpcc_id, regval, gamut_remap_block_id, mode_select);
-//	}
-//	if (gamut_remap_block_id == MPCC_RMCM_GAMUT_REMAP) {
-//		//current coefficient set in use
-//		REG_GET(MPC_RMCM_GAMUT_REMAP_MODE[mpcc_id], MPC_RMCM_GAMUT_REMAP_MODE, mode_select);
-//
-//		gamut_regs.shifts.csc_c11 = mpc42->mpc_shift->MPCC_GAMUT_REMAP_C11_A;
-//		gamut_regs.masks.csc_c11 = mpc42->mpc_mask->MPCC_GAMUT_REMAP_C11_A;
-//		gamut_regs.shifts.csc_c12 = mpc42->mpc_shift->MPCC_GAMUT_REMAP_C12_A;
-//		gamut_regs.masks.csc_c12 = mpc42->mpc_mask->MPCC_GAMUT_REMAP_C12_A;
-//
-//		switch (*mode_select) {
-//		case MPCC_GAMUT_REMAP_MODE_SELECT_1:
-//			gamut_regs.csc_c11_c12 = REG(MPC_RMCM_GAMUT_REMAP_C11_C12_A[mpcc_id]);
-//			gamut_regs.csc_c33_c34 = REG(MPC_RMCM_GAMUT_REMAP_C33_C34_A[mpcc_id]);
-//			break;
-//		case MPCC_GAMUT_REMAP_MODE_SELECT_2:
-//			gamut_regs.csc_c11_c12 = REG(MPC_RMCM_GAMUT_REMAP_C11_C12_B[mpcc_id]);
-//			gamut_regs.csc_c33_c34 = REG(MPC_RMCM_GAMUT_REMAP_C33_C34_B[mpcc_id]);
-//			break;
-//		default:
-//			break;
-//		}
-//	}
-//
-//	if (*mode_select != MPCC_GAMUT_REMAP_MODE_SELECT_0) {
-//		cm_helper_read_color_matrices(
-//			mpc42->base.ctx,
-//			regval,
-//			&gamut_regs);
-//	}
-//}
-
-//void mpc42_get_gamut_remap(struct mpc *mpc,
-//	int mpcc_id,
-//	struct mpc_grph_gamut_adjustment *adjust)
-//{
-//	uint16_t arr_reg_val[12] = {0};
-//	uint32_t mode_select;
-//
-//	read_gamut_remap(mpc, mpcc_id, arr_reg_val, adjust->mpcc_gamut_remap_block_id, &mode_select);
-//
-//	if (mode_select == MPCC_GAMUT_REMAP_MODE_SELECT_0) {
-//		adjust->gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
-//		return;
-//	}
-//
-//	adjust->gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
-//	convert_hw_matrix(adjust->temperature_matrix,
-//		arr_reg_val, ARRAY_SIZE(arr_reg_val));
-//}
-
 void mpc42_read_mpcc_state(
 		struct mpc *mpc,
 		int mpcc_inst,
@@ -1071,14 +755,7 @@ static const struct mpc_funcs dcn42_mpc_funcs = {
 	.populate_lut = mpc401_populate_lut,
 	.program_lut_read_write_control = mpc401_program_lut_read_write_control,
 	.program_lut_mode = mpc401_program_lut_mode,
-	.mcm = {
-		.program_lut_read_write_control = mpc42_program_lut_read_write_control,
-		.program_3dlut_size = mpc42_program_3dlut_size,
-		.program_bias_scale = mpc42_program_3dlut_fl_bias_scale,
-		.program_bit_depth = mpc42_program_bit_depth,
-		.is_config_supported = mpc42_is_config_supported,
-		.populate_lut = mpc42_populate_lut,
-	},
+	.get_lut_mode = mpc401_get_lut_mode,
 	.rmcm = {
 		.enable_3dlut_fl = mpc42_enable_3dlut_fl,
 		.update_3dlut_fast_load_select = mpc42_update_3dlut_fast_load_select,
@@ -1087,7 +764,6 @@ static const struct mpc_funcs dcn42_mpc_funcs = {
 		.program_3dlut_size = mpc42_program_rmcm_3dlut_size,
 		.program_bias_scale = mpc42_program_rmcm_3dlut_fast_load_bias_scale,
 		.program_bit_depth = mpc42_program_rmcm_bit_depth,
-		.is_config_supported = mpc42_is_rmcm_config_supported,
 		.power_on_shaper_3dlut = mpc42_power_on_rmcm_shaper_3dlut,
 		.populate_lut = mpc42_populate_rmcm_lut,
 		.fl_3dlut_configure = mpc42_set_fl_config,
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h
index 9b87fd2be904..a5f7f4f2bb3b 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h
@@ -882,49 +882,7 @@ void dcn42_mpc_construct(struct dcn42_mpc *mpc401,
 	int num_mpcc,
 	int num_rmu);
 
-
-void mpc42_program_shaper_lutb_settings(
-	struct mpc *mpc,
-	const struct pwl_params *params,
-	uint32_t mpcc_id);
-void mpc42_program_shaper_luta_settings(
-		struct mpc *mpc,
-		const struct pwl_params *params,
-		uint32_t mpcc_id);
-void mpc42_configure_shaper_lut(
-		struct mpc *mpc,
-		bool is_ram_a,
-		uint32_t mpcc_id);
-void mpc42_power_on_shaper_3dlut(
-		struct mpc *mpc,
-		uint32_t mpcc_id,
-		bool power_on);
-void mpc42_program_3dlut_size(
-		struct mpc *mpc,
-		uint32_t width,
-		int mpcc_id);
-void mpc42_program_3dlut_fl_bias_scale(
-		struct mpc *mpc,
-		uint16_t bias,
-		uint16_t scale,
-		int mpcc_id);
-void mpc42_program_bit_depth(
-		struct mpc *mpc,
-		uint16_t bit_depth,
-		int mpcc_id);
-void mpc42_populate_lut(
-		struct mpc *mpc,
-		const union mcm_lut_params params,
-		bool lut_bank_a,
-		int mpcc_id);
-void mpc42_program_lut_read_write_control(
-		struct mpc *mpc,
-		const enum MCM_LUT_ID id,
-		bool lut_bank_a,
-		bool enabled,
-		int mpcc_id);
-
-bool mpc42_is_config_supported(uint32_t width);
+void mpc42_init_mpcc(struct mpcc *mpcc, int mpcc_inst);
 
 /* RMCM */
 void mpc42_program_rmcm_shaper_lut(
@@ -969,12 +927,12 @@ void mpc42_program_rmcm_lut_read_write_control(
 		int mpcc_id);
 void mpc42_program_lut_mode(
 		struct mpc *mpc,
-		const enum MCM_LUT_XABLE xable,
+		bool enable,
 		bool lut_bank_a,
 		int mpcc_id);
 void mpc42_program_rmcm_3dlut_size(
 		struct mpc *mpc,
-		uint32_t width,
+		const enum dc_cm_lut_size size,
 		int mpcc_id);
 void mpc42_program_rmcm_3dlut_fast_load_bias_scale(
 		struct mpc *mpc,
@@ -986,8 +944,6 @@ void mpc42_program_rmcm_bit_depth(
 		uint16_t bit_depth,
 		int mpcc_id);
 
-bool mpc42_is_rmcm_config_supported(uint32_t width);
-
 void mpc42_set_fl_config(
 	struct mpc *mpc,
 	struct mpc_fl_3dlut_config *cfg,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index d2ba63046a50..138081e6cc97 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -707,7 +707,7 @@ struct dcn_optc_shift {
 	TG_REG_FIELD_LIST_DCN3_5(uint8_t)
 	TG_REG_FIELD_LIST_DCN3_6(uint8_t)
 	TG_REG_FIELD_LIST_DCN401(uint8_t)
-	TG_REG_FIELD_LIST_DCN42(uint8_t)
+		TG_REG_FIELD_LIST_DCN42(uint8_t)
 };
 
 struct dcn_optc_mask {
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
index effd05b3685f..b196d689d916 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
@@ -6,11 +6,13 @@
 #include "dcn30/dcn30_optc.h"
 #include "dcn31/dcn31_optc.h"
 #include "dcn32/dcn32_optc.h"
+#include "dcn35/dcn35_optc.h"
 #include "dcn401/dcn401_optc.h"
 #include "reg_helper.h"
 #include "dc.h"
 #include "dcn_calc_math.h"
 #include "dc_dmub_srv.h"
+#include "dc_trace.h"
 
 #define REG(reg)\
 	optc1->tg_regs->reg
@@ -108,6 +110,89 @@ void  optc42_disable_pwa(struct timing_generator *optc)
 	REG_UPDATE(OTG_PWA_FRAME_SYNC_CONTROL,
 			OTG_PWA_FRAME_SYNC_EN, 0);
 }
+void optc42_clear_optc_underflow(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	REG_UPDATE(OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_CLEAR, 1);
+	REG_UPDATE(OPTC_RSMU_UNDERFLOW, OPTC_RSMU_UNDERFLOW_CLEAR, 1);
+}
+bool optc42_is_optc_underflow_occurred(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t underflow_occurred = 0, rsmu_underflow_occurred = 0;
+
+	REG_GET(OPTC_INPUT_GLOBAL_CONTROL,
+			OPTC_UNDERFLOW_OCCURRED_STATUS,
+			&underflow_occurred);
+
+	REG_GET(OPTC_RSMU_UNDERFLOW,
+			OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS,
+			&rsmu_underflow_occurred);
+	return (underflow_occurred == 1 || rsmu_underflow_occurred);
+}
+/* disable_crtc */
+bool optc42_disable_crtc(struct timing_generator *optc)
+{
+	optc401_disable_crtc(optc);
+	optc42_clear_optc_underflow(optc);
+
+	return true;
+}
+static void optc42_set_timing_double_buffer(struct timing_generator *optc, bool enable)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t mode = enable ? 2 : 0;
+	/*actually we have 4 modes now, use as the same as previous dcn3x
+	00	OTG_DOUBLE_BUFFER_CONTROL_OTG_DRR_TIMING_DBUF_UPDATE_MODE_0	Double buffer update occurs at any time in a frame.
+	01	OTG_DOUBLE_BUFFER_CONTROL_OTG_DRR_TIMING_DBUF_UPDATE_MODE_1	Double buffer update occurs at OTG start of frame.
+	02	OTG_DOUBLE_BUFFER_CONTROL_OTG_DRR_TIMING_DBUF_UPDATE_MODE_2	Double buffer occurs DP start of frame.
+	03	OTG_DOUBLE_BUFFER_CONTROL_OTG_DRR_TIMING_DBUF_UPDATE_MODE_3	Reserved.
+	*/
+
+	REG_UPDATE(OTG_DOUBLE_BUFFER_CONTROL,
+		   OTG_DRR_TIMING_DBUF_UPDATE_MODE, mode);
+}
+void optc42_tg_init(struct timing_generator *optc)
+{
+	optc42_set_timing_double_buffer(optc, true);
+	optc42_clear_optc_underflow(optc);
+}
+
+void optc42_lock_doublebuffer_enable(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t v_blank_start = 0;
+	uint32_t v_blank_end = 0;
+	uint32_t h_blank_start = 0;
+	uint32_t h_blank_end = 0;
+
+	REG_GET_2(OTG_V_BLANK_START_END,
+		OTG_V_BLANK_START, &v_blank_start,
+		OTG_V_BLANK_END, &v_blank_end);
+	REG_GET_2(OTG_H_BLANK_START_END,
+		OTG_H_BLANK_START, &h_blank_start,
+		OTG_H_BLANK_END, &h_blank_end);
+
+	REG_UPDATE_2(OTG_GLOBAL_CONTROL1,
+		MASTER_UPDATE_LOCK_DB_START_Y, v_blank_start,
+		MASTER_UPDATE_LOCK_DB_END_Y, v_blank_start);
+	REG_UPDATE_2(OTG_GLOBAL_CONTROL4,
+		DIG_UPDATE_POSITION_X, 20,
+		DIG_UPDATE_POSITION_Y, v_blank_start);
+	REG_UPDATE_3(OTG_GLOBAL_CONTROL0,
+		MASTER_UPDATE_LOCK_DB_START_X, h_blank_start - 200 - 1,
+		MASTER_UPDATE_LOCK_DB_END_X, h_blank_end,
+		MASTER_UPDATE_LOCK_DB_EN, 1);
+	REG_UPDATE(OTG_GLOBAL_CONTROL2, GLOBAL_UPDATE_LOCK_EN, 1);
+
+	REG_SET_3(OTG_VUPDATE_KEEPOUT, 0,
+		MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, 0,
+		MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, 100,
+		OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, 1);
+
+	TRACE_OPTC_LOCK_UNLOCK_STATE(optc1, optc->inst, true);
+}
 
 static struct timing_generator_funcs dcn42_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
@@ -117,7 +202,7 @@ static struct timing_generator_funcs dcn42_tg_funcs = {
 		.setup_vertical_interrupt2 = optc1_setup_vertical_interrupt2,
 		.program_global_sync = optc401_program_global_sync,
 		.enable_crtc = optc401_enable_crtc,
-		.disable_crtc = optc401_disable_crtc,
+		.disable_crtc = optc42_disable_crtc,
 		.phantom_crtc_post_enable = optc401_phantom_crtc_post_enable,
 		.disable_phantom_crtc = optc401_disable_phantom_otg,
 		/* used by enable_timing_synchronization. Not need for FPGA */
@@ -138,7 +223,7 @@ static struct timing_generator_funcs dcn42_tg_funcs = {
 		.disable_reset_trigger = optc1_disable_reset_trigger,
 		.lock = optc3_lock,
 		.unlock = optc1_unlock,
-		.lock_doublebuffer_enable = optc3_lock_doublebuffer_enable,
+		.lock_doublebuffer_enable = optc42_lock_doublebuffer_enable,
 		.lock_doublebuffer_disable = optc3_lock_doublebuffer_disable,
 		.enable_optc_clock = optc1_enable_optc_clock,
 		.set_drr = optc401_set_drr,
@@ -147,13 +232,13 @@ static struct timing_generator_funcs dcn42_tg_funcs = {
 		.set_static_screen_control = optc1_set_static_screen_control,
 		.program_stereo = optc1_program_stereo,
 		.is_stereo_left_eye = optc1_is_stereo_left_eye,
-		.tg_init = optc3_tg_init,
+		.tg_init = optc42_tg_init,
 		.is_tg_enabled = optc1_is_tg_enabled,
-		.is_optc_underflow_occurred = optc1_is_optc_underflow_occurred,
-		.clear_optc_underflow = optc1_clear_optc_underflow,
+		.is_optc_underflow_occurred = optc42_is_optc_underflow_occurred,
+		.clear_optc_underflow = optc42_clear_optc_underflow,
 		.setup_global_swap_lock = NULL,
 		.get_crc = optc42_get_crc,
-		.configure_crc = optc1_configure_crc,
+		.configure_crc = optc35_configure_crc,
 		.set_dsc_config = optc3_set_dsc_config,
 		.get_dsc_status = optc2_get_dsc_status,
 		.set_dwb_source = NULL,
@@ -162,6 +247,7 @@ static struct timing_generator_funcs dcn42_tg_funcs = {
 		.wait_odm_doublebuffer_pending_clear = optc32_wait_odm_doublebuffer_pending_clear,
 		.set_h_timing_div_manual_mode = optc401_set_h_timing_div_manual_mode,
 		.get_optc_source = optc2_get_optc_source,
+		.wait_otg_disable = optc35_wait_otg_disable,
 		.set_out_mux = optc401_set_out_mux,
 		.set_drr_trigger_window = optc3_set_drr_trigger_window,
 		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
@@ -171,6 +257,8 @@ static struct timing_generator_funcs dcn42_tg_funcs = {
 		.program_manual_trigger = optc2_program_manual_trigger,
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
+		.init_odm = optc3_init_odm,
+		.set_long_vtotal = optc35_set_long_vtotal,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
 		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
 		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
@@ -178,6 +266,7 @@ static struct timing_generator_funcs dcn42_tg_funcs = {
 		.set_vupdate_keepout = optc401_set_vupdate_keepout,
 		.wait_update_lock_status = optc401_wait_update_lock_status,
 		.optc_read_reg_state = optc31_read_reg_state,
+		.read_otg_state = optc31_read_otg_state,
 		.enable_otg_pwa = optc42_enable_pwa,
 		.disable_otg_pwa = optc42_disable_pwa,
 };
@@ -194,5 +283,9 @@ void dcn42_timing_generator_init(struct optc *optc1)
 	optc1->min_v_blank_interlace = 5;
 	optc1->min_h_sync_width = 4;
 	optc1->min_v_sync_width = 1;
+	optc1->max_frame_count = 0xFFFFFF;
+
+	dcn35_timing_generator_set_fgcg(
+		optc1, CTX->dc->debug.enable_fine_grain_clock_gating.bits.optc);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
index 45d2187efaca..fc7192f01b33 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
@@ -119,6 +119,10 @@
 	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_OCCURRED_STATUS, mask_sh),\
 	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_DOUBLE_BUFFER_PENDING, mask_sh),\
 	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_CLEAR, mask_sh),\
+	SF(ODM0_OPTC_RSMU_UNDERFLOW, OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS, mask_sh),\
+	SF(ODM0_OPTC_RSMU_UNDERFLOW, OPTC_RSMU_UNDERFLOW_CLEAR, mask_sh),\
+	SF(ODM0_OPTC_RSMU_UNDERFLOW, OPTC_RSMU_UNDERFLOW_INT_EN, mask_sh),\
+	SF(ODM0_OPTC_RSMU_UNDERFLOW, OPTC_RSMU_UNDERFLOW_INT_STATUS, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_ENABLE, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_FP2, mask_sh),\
 	SF(VTG0_CONTROL, VTG0_VCOUNT_INIT, mask_sh),\
@@ -202,10 +206,15 @@
 	SF(OTG0_OTG_PWA_FRAME_SYNC_CONTROL, OTG_PWA_FRAME_SYNC_EN, mask_sh),\
 	SF(OTG0_OTG_PWA_FRAME_SYNC_CONTROL, OTG_PWA_FRAME_SYNC_VCOUNT_MODE, mask_sh),\
 	SF(OTG0_OTG_PWA_FRAME_SYNC_CONTROL, OTG_PWA_FRAME_SYNC_LINE, mask_sh),\
-	SF(OTG0_INTERRUPT_DEST, OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST, mask_sh)
+	SF(OTG0_INTERRUPT_DEST, OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST, mask_sh),\
+	SF(OPTC_CLOCK_CONTROL, OPTC_FGCG_REP_DIS, mask_sh)
 
 void dcn42_timing_generator_init(struct optc *optc1);
 void optc42_enable_pwa(struct timing_generator *optc, struct otc_pwa_frame_sync *pwa_sync_param);
 void optc42_disable_pwa(struct timing_generator *optc);
-
+void optc42_tg_init(struct timing_generator *optc);
+void optc42_clear_optc_underflow(struct timing_generator *optc);
+bool optc42_is_optc_underflow_occurred(struct timing_generator *optc);
+bool optc42_disable_crtc(struct timing_generator *optc);
+void optc42_lock_doublebuffer_enable(struct timing_generator *optc);
 #endif /* __DC_OPTC_DCN42_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 8e41367cf238..aef187bcf5c3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -53,7 +53,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
-#include "virtual/virtual_stream_encoder.h"
+#include "dio/virtual/virtual_stream_encoder.h"
 #include "dml/display_mode_vba.h"
 #include "dcn42/dcn42_dccg.h"
 #include "dcn10/dcn10_resource.h"
@@ -666,6 +666,7 @@ static const struct resource_caps res_cap_dcn42 = {
 	.num_vmid = 16,
 	.num_mpc_3dlut = 2,
 	.num_dsc = 4,
+	.num_rmcm = 2,
 };
 
 static const struct dc_plane_cap plane_cap = {
@@ -755,6 +756,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.dcc_meta_propagation_delay_us = 10,
 	.disable_timeout = true,
 	.min_disp_clk_khz = 50000,
+	.static_screen_wait_frames = 2,
 	.disable_z10 = false,
 	.ignore_pg = true,
 	.disable_stutter_for_wm_program = true,
@@ -2302,14 +2304,12 @@ static bool dcn42_resource_construct(
 
 	dc->dml2_options.max_segments_per_hubp = 24;
 	dc->dml2_options.det_segment_size = DCN42_CRB_SEGMENT_SIZE_KB;
+	dc->dml2_options.gpuvm_enable = true;
+	dc->dml2_options.hostvm_enable = true;
 
 	/* SPL */
 	dc->caps.scl_caps.sharpener_support = true;
 
-	/* init DC limited DML2 options */
-	memcpy(&dc->dml2_dc_power_options, &dc->dml2_options, sizeof(struct dml2_configuration_options));
-	dc->dml2_dc_power_options.use_clock_dc_limits = true;
-
 	return true;
 
 create_fail:
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
index 3190c76eb482..1b397fa7e05c 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
@@ -102,6 +102,9 @@ static void dcn401_convert_dc_clock_table_to_soc_bb_clock_table(
 					}
 				} else {
 					dml_clk_table->uclk.clk_values_khz[i] = dc_clk_table->entries[i].memclk_mhz * 1000;
+					#ifdef ENABLE_WCK
+					dml_clk_table->wck_ratio.clk_values_khz[i] = dc_clk_table->entries[i].wck_ratio;
+					#endif
 				}
 			} else {
 				dml_clk_table->uclk.clk_values_khz[i] = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
index 87ac56739030..fd9c24b5df53 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
@@ -3,7 +3,7 @@
 // Copyright 2025 Advanced Micro Devices, Inc.
 
 #include "dcn42_soc_and_ip_translator.h"
-#include "soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.h"
+#include "../dcn401/dcn401_soc_and_ip_translator.h"
 #include "bounding_boxes/dcn42_soc_bb.h"
 
 /* soc_and_ip_translator component used to get up-to-date values for bounding box.
@@ -11,10 +11,12 @@
  * This component provides an interface to get DCN-specific bounding box values.
  */
 
-static void get_default_soc_bb(struct dml2_soc_bb *soc_bb)
+static void get_default_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc)
 {
-	memcpy(soc_bb, &dml2_socbb_dcn42, sizeof(struct dml2_soc_bb));
-	memcpy(&soc_bb->qos_parameters, &dml_dcn42_variant_a_soc_qos_params, sizeof(struct dml2_soc_qos_parameters));
+	{
+		memcpy(soc_bb, &dml2_socbb_dcn42, sizeof(struct dml2_soc_bb));
+		memcpy(&soc_bb->qos_parameters, &dml_dcn42_variant_a_soc_qos_params, sizeof(struct dml2_soc_qos_parameters));
+	}
 }
 
 /*
@@ -162,7 +164,7 @@ static void apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc
 void dcn42_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
 {
 	//get default soc_bb with static values
-	get_default_soc_bb(soc_bb);
+	get_default_soc_bb(soc_bb, dc);
 	//update soc_bb values with more accurate values
 	apply_soc_bb_updates(soc_bb, dc, config);
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index f67a0ffb9335..0b04f985b15e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -909,7 +909,8 @@ union dmub_fw_meta_feature_bits {
 	struct {
 		uint32_t shared_state_link_detection : 1; /**< 1 supports link detection via shared state */
 		uint32_t cursor_offload_v1_support: 1; /**< 1 supports cursor offload */
-		uint32_t reserved : 30;
+		uint32_t inbox0_lock_support: 1; /**< 1 supports inbox0 lock mechanism */
+		uint32_t reserved : 29;
 	} bits; /**< status bits */
 	uint32_t all; /**< 32-bit access to status bits */
 };
@@ -1535,14 +1536,12 @@ enum dmub_gpint_command {
 	 *       1 - Enable ips measurement
 	 */
 	DMUB_GPINT__IPS_RESIDENCY = 121,
-
 	/**
 	 * DESC: Enable measurements for various task duration
 	 * ARGS: 0 - Disable measurement
 	 *       1 - Enable measurement
 	 */
 	DMUB_GPINT__TRACE_DMUB_WAKE_ACTIVITY = 123,
-
 	/**
 	 * DESC: Gets IPS residency in microseconds
 	 * ARGS: 0 - Return IPS1 residency
@@ -1552,21 +1551,18 @@ enum dmub_gpint_command {
 	 * RETURN: Total residency in microseconds - lower 32 bits
 	 */
 	DMUB_GPINT__GET_IPS_RESIDENCY_DURATION_US_LO = 124,
-
 	/**
 	 * DESC: Gets IPS1 histogram counts
 	 * ARGS: Bucket index
 	 * RETURN: Total count for the bucket
 	 */
 	DMUB_GPINT__GET_IPS1_HISTOGRAM_COUNTER = 125,
-
 	/**
 	 * DESC: Gets IPS2 histogram counts
 	 * ARGS: Bucket index
 	 * RETURN: Total count for the bucket
 	 */
 	DMUB_GPINT__GET_IPS2_HISTOGRAM_COUNTER = 126,
-
 	/**
 	 * DESC: Gets IPS residency
 	 * ARGS: 0 - Return IPS1 residency
@@ -1576,21 +1572,18 @@ enum dmub_gpint_command {
 	 * RETURN: Total residency in milli-percent.
 	 */
 	DMUB_GPINT__GET_IPS_RESIDENCY_PERCENT = 127,
-
 	/**
 	 * DESC: Gets IPS1_RCG histogram counts
 	 * ARGS: Bucket index
 	 * RETURN: Total count for the bucket
 	 */
 	DMUB_GPINT__GET_IPS1_RCG_HISTOGRAM_COUNTER = 128,
-
 	/**
 	 * DESC: Gets IPS1_ONO2_ON histogram counts
 	 * ARGS: Bucket index
 	 * RETURN: Total count for the bucket
 	 */
 	DMUB_GPINT__GET_IPS1_ONO2_ON_HISTOGRAM_COUNTER = 129,
-
 	/**
 	 * DESC: Gets IPS entry counter during residency measurement
 	 * ARGS: 0 - Return IPS1 entry counts
@@ -1600,7 +1593,6 @@ enum dmub_gpint_command {
 	 * RETURN: Entry counter for selected IPS mode
 	 */
 	DMUB_GPINT__GET_IPS_RESIDENCY_ENTRY_COUNTER = 130,
-
 	/**
 	 * DESC: Gets IPS inactive residency in microseconds
 	 * ARGS: 0 - Return IPS1_MAX residency
@@ -1610,7 +1602,6 @@ enum dmub_gpint_command {
 	 * RETURN: Total inactive residency in microseconds - lower 32 bits
 	 */
 	DMUB_GPINT__GET_IPS_INACTIVE_RESIDENCY_DURATION_US_LO = 131,
-
 	/**
 	 * DESC: Gets IPS inactive residency in microseconds
 	 * ARGS: 0 - Return IPS1_MAX residency
@@ -1620,7 +1611,6 @@ enum dmub_gpint_command {
 	 * RETURN: Total inactive residency in microseconds - upper 32 bits
 	 */
 	DMUB_GPINT__GET_IPS_INACTIVE_RESIDENCY_DURATION_US_HI = 132,
-
 	/**
 	 * DESC: Gets IPS residency in microseconds
 	 * ARGS: 0 - Return IPS1 residency
@@ -1679,7 +1669,7 @@ union dmub_inbox0_cmd_lock_hw {
 
 		uint32_t lock: 1;			/**< Lock */
 		uint32_t should_release: 1;		/**< Release */
-		uint32_t reserved: 7;			/**< Reserved for extending more clients, HW, etc. */
+		uint32_t reserved: 7; 			/**< Reserved for extending more clients, HW, etc. */
 	} bits;
 	uint32_t all;
 };
@@ -2614,9 +2604,9 @@ struct dmub_fams2_stream_static_state {
 	uint8_t allow_to_target_delay_otg_vlines; // time from allow vline to target vline
 	union {
 		struct {
-			uint8_t is_drr: 1; // stream is DRR enabled
-			uint8_t clamp_vtotal_min: 1; // clamp vtotal to min instead of nominal
-			uint8_t min_ttu_vblank_usable: 1; // if min ttu vblank is above wm, no force pstate is needed in blank
+			uint8_t is_drr : 1; // stream is DRR enabled
+			uint8_t clamp_vtotal_min : 1; // clamp vtotal to min instead of nominal
+			uint8_t min_ttu_vblank_usable : 1; // if min ttu vblank is above wm, no force pstate is needed in blank
 		} bits;
 		uint8_t all;
 	} config;
@@ -4660,6 +4650,18 @@ struct dmub_rb_cmd_replay_enable_data {
 	 * This does not support HDMI/DP2 for now.
 	 */
 	uint8_t phy_rate;
+	/**
+	 * @hpo_stream_enc_inst: HPO stream encoder instance
+	 */
+	uint8_t hpo_stream_enc_inst;
+	/**
+	 * @hpo_link_enc_inst: HPO link encoder instance
+	 */
+	uint8_t hpo_link_enc_inst;
+	/**
+	 * @pad: Align structure to 4 byte boundary.
+	 */
+	uint8_t pad[2];
 };
 
 /**
@@ -5273,8 +5275,8 @@ enum dmub_cmd_lsdma_type {
 	 */
 	DMUB_CMD__LSDMA_LINEAR_COPY = 1,
 	/**
-	 * LSDMA copies data from source to destination linearly in sub window
-	 */
+	* LSDMA copies data from source to destination linearly in sub window
+	*/
 	DMUB_CMD__LSDMA_LINEAR_SUB_WINDOW_COPY = 2,
 	/**
 	 * Send the tiled-to-tiled copy command
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_offset.h
index 825201f4e113..52fbf2dc1899 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_offset.h
@@ -9010,6 +9010,8 @@
 // base address: 0x0
 #define regODM0_OPTC_INPUT_GLOBAL_CONTROL                                                               0x1aca
 #define regODM0_OPTC_INPUT_GLOBAL_CONTROL_BASE_IDX                                                      2
+#define regODM0_OPTC_RSMU_UNDERFLOW                                                                     0x1acb
+#define regODM0_OPTC_RSMU_UNDERFLOW_BASE_IDX                                                            2
 #define regODM0_OPTC_UNDERFLOW_THRESHOLD                                                                0x1acc
 #define regODM0_OPTC_UNDERFLOW_THRESHOLD_BASE_IDX                                                       2
 #define regODM0_OPTC_DATA_SOURCE_SELECT                                                                 0x1acd
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_sh_mask.h
index 4ed96244f61b..01fb53093369 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_sh_mask.h
@@ -33583,6 +33583,15 @@
 #define ODM0_OPTC_INPUT_GLOBAL_CONTROL__OPTC_UNDERFLOW_CLEAR_MASK                                             0x00001000L
 #define ODM0_OPTC_INPUT_GLOBAL_CONTROL__OPTC_UNDERFLOW_OCCURRED_CURRENT_MASK                                  0x00002000L
 #define ODM0_OPTC_INPUT_GLOBAL_CONTROL__OPTC_DOUBLE_BUFFER_PENDING_MASK                                       0x80000000L
+//ODM0_OPTC_RSMU_UNDERFLOW
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN__SHIFT                                           0x0
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS__SHIFT                                  0x1
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS__SHIFT                                       0x2
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR__SHIFT                                            0x3
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_EN_MASK                                             0x00000001L
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_OCCURRED_STATUS_MASK                                    0x00000002L
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_INT_STATUS_MASK                                         0x00000004L
+#define ODM0_OPTC_RSMU_UNDERFLOW__OPTC_RSMU_UNDERFLOW_CLEAR_MASK                                              0x00000008L
 //ODM0_OPTC_UNDERFLOW_THRESHOLD
 #define ODM0_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD__SHIFT                                        0x0
 #define ODM0_OPTC_UNDERFLOW_THRESHOLD__OPTC_UNDERFLOW_THRESHOLD_MASK                                          0x01FFFFFFL
-- 
2.43.0

