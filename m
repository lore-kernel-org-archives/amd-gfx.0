Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F8DC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 21:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B40AC60EE5
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 21:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B40AC60EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E8B96E063;
	Mon, 16 Aug 2021 21:05:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDAB6E063
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 21:05:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVlNuXeEJsGEKo0vuv++ugeAdtRY1XIvolqarROdraG5MVmoxaSN3+jp6+dPthLBPsGfF8W39VsYXWYAI3xhLf7WHc8wooIlDiBT/slE4ii9x8WDQ10lSCeqoUlGJ2KSJ4+cpGlq4Kr5ueIRiTG5p2IQ2w+GHQioYlt8jfD0vte8OfkbZOmt2CPDgP8vo9RQYxyuda4VlGqIHnM50+H/DzvUO5DsQIZEpaPPLRMD/gb7MJD13qOt8l5BWQaycuoFAcf2IuUpobnzrggrxhQTNpjOqLkZOrqivCzFQtpIY7JQQ3vD4M/A31LxICRljcgVA+OzoQ9PH3ECn9mQ+bil9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhYF8SxgGsNzVYvQ9NASHYvaTvPgrkTTx8ej7/6qHKM=;
 b=UHbGKo/m/h3v/VFT4LPvz/Fa3JeiVHOdJbah/U34twhkECHdM+LKylS4VzH2pB5I+4yhifRQ4NTUTTfs5LsEzvnoevacJGAI31il8slXCUf+39bk1Eh0vkuB11C9zbTtEqAhWckPMSF7wqWtvRPsx+isv5mOc7/KUxdXORZukDOos3PllqqAgvBHzmjmkY58xIfyyV4tnwUKmUFCyOIvgvX8BGu2w/OxtkpCzu4msuCkuAbdDoWDSZmEqJx1lt7dt6wtbTxnvA9sbYZ3IfEjW0+K/ztGYwIC8ezub8D4xQi7S98C6weBKsK6n1qdz760fbjn4B0P2rgnUEeRXlOtoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhYF8SxgGsNzVYvQ9NASHYvaTvPgrkTTx8ej7/6qHKM=;
 b=OsJRswoQRnMqeioY6aip1chgtUSL9YkAXM8HGVQxu6TCx2H2qOqh5J1J6KCs9Otz2gLeDYY3+OJZERLQl9OcK53qg5DLQkTBuwUCZFZWaq8yhlJG+Iu3RsjQpeaKgsrcR45wxTAjYVZeLf8Lpt5xA41gCkcgzzk26XmntdsHiac=
Received: from MW4PR04CA0376.namprd04.prod.outlook.com (2603:10b6:303:81::21)
 by CY4PR1201MB2516.namprd12.prod.outlook.com (2603:10b6:903:db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Mon, 16 Aug
 2021 21:05:43 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::7) by MW4PR04CA0376.outlook.office365.com
 (2603:10b6:303:81::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Mon, 16 Aug 2021 21:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Mon, 16 Aug 2021 21:05:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 16 Aug
 2021 16:05:41 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 16 Aug 2021 16:05:41 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nicholas.kazlauskas@amd.com>,
 <harry.wentland@amd.com>
CC: <wayne.lin@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 6/6] drm/amd/display: Add DP 2.0 SST DC Support
Date: Mon, 16 Aug 2021 16:59:19 -0400
Message-ID: <20210816205919.614691-7-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816205919.614691-1-Jerry.Zuo@amd.com>
References: <20210816205919.614691-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2098b038-2ed3-4bb1-bba0-08d960f99c45
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2516:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2516037A72DCAE868072A90EE5FD9@CY4PR1201MB2516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9j4sWsWLLnXou0ndf3OYs29kJIj5ghPsJ7uIlbofLUnId/WavgSrqBFWihGXSFojuPVURdZ9jbUiSdArBuNJzN6jRcaQv6iL5WuxF8cz4WuP/8xMUdt9FTZYthSU3pqhO0EaDoMs3SjqgmPyAxRIxpykzCucgPyZDiTEhFn5vDyRbWrVwpnC8nCdAbrTxyPZQNtraOLlkZOCpCavmLUiUce1J8C7V3RLgg4F4A8+oBoKyNn5mOg/fZpY+aGWBH8VGlLB7m0WkntwWM4ng0UdzPo3z2LybVg6nFZT4GZ4wuzZHnaWdxqE6x+4Za1LejLOX5BYz25s+YxVNB19c3dBE7RuMUBtBXOHi0qTvP0nXTfeboN4VX8u6X7lhauIicqpvOHwjJadL1Qpo174aoyEQ6r+ek9rnXTuI1DOTYgDOFXuFvzyW/bZNkXBpOcS1RSPM8+dq5EsO6ncG7n1/4ejzl+DXr31T2U8eNW2hREH5+TzhnDCucM+3l4TFVJzil/BarnDRLaw6qWVhN9ZlSlqtxPLXwVc72rYuu6VBVZxuUQU3LnjZhFqmVMI6BL6GISADZ3RIFSbwfuyAZ1l22EWsHybxkydf6XzjuHkWjkw+CwJtew7REes/RWhg7hPcxG8YHW7Tee+Xc+/LP9nR3IrQJqxQk4QY1FFX6SRvHKM/v9RKPvgd8IXjnBvPI/YbyxBByx56yWDsTL9D0jEEuVBOMejTy8ByW/i5Irc/CbhiMx7+FGQcintbl97p8jVTuy+W9qtvQHtxFo2WskxlCq3s5wEq0si+TsZ6agVKDZNq0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(46966006)(82310400003)(4326008)(47076005)(54906003)(30864003)(2616005)(83380400001)(8936002)(8676002)(34020700004)(26005)(336012)(36860700001)(86362001)(1076003)(7696005)(2906002)(82740400003)(70206006)(6666004)(5660300002)(356005)(81166007)(186003)(426003)(478600001)(6636002)(36756003)(110136005)(70586007)(316002)(334744004)(36900700001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 21:05:43.2975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2098b038-2ed3-4bb1-bba0-08d960f99c45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2516
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

1. Retrieve 128/132b link cap.
2. 128/132b link training and payload allocation.
3. UHBR10 link rate support.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    6 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   17 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  503 +++++++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 1071 +++++++++++++++--
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  291 ++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  104 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |   17 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  199 ++-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |    1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   15 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |   86 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |    9 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   26 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |    4 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   18 +-
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |    1 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |    2 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   22 +
 .../amd/display/dc/inc/hw_sequencer_private.h |    1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |    3 +
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   14 +-
 .../amd/display/include/link_service_types.h  |   18 +-
 .../drm/amd/display/include/logger_types.h    |    2 +
 23 files changed, 2201 insertions(+), 229 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6fee12c91ef5..ba142e8bbee2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -751,3 +751,9 @@ void dm_helpers_mst_enable_stream_features(const struct dc_stream_state *stream)
 					 &new_downspread.raw,
 					 sizeof(new_downspread));
 }
+
+void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz)
+{
+       // FPGA programming for this clock in diags framework that
+       // needs to go through dm layer, therefore leave dummy interace here
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7a442fcfa6ac..29f5ce2fed36 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -186,6 +186,7 @@ static bool create_links(
 	int i;
 	int connectors_num;
 	struct dc_bios *bios = dc->ctx->dc_bios;
+	int dp_hpo_link_count = 0;
 
 	dc->link_count = 0;
 
@@ -255,6 +256,22 @@ static bool create_links(
 			goto failed_alloc;
 		}
 
+		if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) &&
+				dc->caps.dp_hpo &&
+				link->dc->res_pool->res_cap->num_hpo_dp_link_encoder > 0) {
+			/* FPGA case - Allocate HPO DP link encoder */
+			if (i < link->dc->res_pool->res_cap->num_hpo_dp_link_encoder) {
+				link->hpo_dp_link_enc = link->dc->res_pool->hpo_dp_link_enc[i];
+
+				if (link->hpo_dp_link_enc == NULL) {
+					BREAK_TO_DEBUGGER();
+					goto failed_alloc;
+				}
+				link->hpo_dp_link_enc->hpd_source = link->link_enc->hpd_source;
+				link->hpo_dp_link_enc->transmitter = link->link_enc->transmitter;
+			}
+		}
+
 		link->link_status.dpcd_caps = &link->dpcd_caps;
 
 		enc_init.ctx = dc->ctx;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 8bd7f42a8053..293b1c6aac42 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -64,6 +64,29 @@
 /*******************************************************************************
  * Private functions
  ******************************************************************************/
+static bool add_dp_hpo_link_encoder_to_link(struct dc_link *link)
+{
+	struct hpo_dp_link_encoder *enc = resource_get_unused_hpo_dp_link_encoder(
+					link->dc->res_pool);
+
+	if (!link->hpo_dp_link_enc && enc) {
+		link->hpo_dp_link_enc = enc;
+		link->hpo_dp_link_enc->transmitter = link->link_enc->transmitter;
+		link->hpo_dp_link_enc->hpd_source = link->link_enc->hpd_source;
+	}
+
+	return (link->hpo_dp_link_enc != NULL);
+}
+
+static void remove_dp_hpo_link_encoder_from_link(struct dc_link *link)
+{
+	if (link->hpo_dp_link_enc) {
+		link->hpo_dp_link_enc->hpd_source = HPD_SOURCEID_UNKNOWN;
+		link->hpo_dp_link_enc->transmitter = TRANSMITTER_UNKNOWN;
+		link->hpo_dp_link_enc = NULL;
+	}
+}
+
 static void dc_link_destruct(struct dc_link *link)
 {
 	int i;
@@ -91,6 +114,10 @@ static void dc_link_destruct(struct dc_link *link)
 		link->link_enc->funcs->destroy(&link->link_enc);
 	}
 
+	if (link->hpo_dp_link_enc) {
+		remove_dp_hpo_link_encoder_from_link(link);
+	}
+
 	if (link->local_sink)
 		dc_sink_release(link->local_sink);
 
@@ -928,6 +955,9 @@ static bool dc_link_detect_helper(struct dc_link *link,
 				return false;
 			}
 
+			if (dp_get_link_encoding_format(&link->reported_link_cap) == DP_128b_132b_ENCODING)
+				add_dp_hpo_link_encoder_to_link(link);
+
 			if (link->type == dc_connection_mst_branch) {
 				LINK_INFO("link=%d, mst branch is now Connected\n",
 					  link->link_index);
@@ -1173,6 +1203,9 @@ static bool dc_link_detect_helper(struct dc_link *link,
 			       sizeof(link->mst_stream_alloc_table.stream_allocations));
 		}
 
+		if (dp_get_link_encoding_format(&link->cur_link_settings) == DP_128b_132b_ENCODING)
+			reset_dp_hpo_stream_encoders_for_link(link);
+
 		link->type = dc_connection_none;
 		sink_caps.signal = SIGNAL_TYPE_NONE;
 		/* When we unplug a passive DP-HDMI dongle connection, dongle_max_pix_clk
@@ -1549,6 +1582,7 @@ static bool dc_link_construct(struct dc_link *link,
 	}
 
 	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
+	DC_LOG_DC("BIOS object table - IS_DP2_CAPABLE: %d", link->link_enc->features.flags.bits.IS_DP2_CAPABLE);
 
 	/* Update link encoder tracking variables. These are used for the dynamic
 	 * assignment of link encoders to streams.
@@ -1741,17 +1775,26 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	/* get link settings for video mode timing */
 	decide_link_settings(stream, &link_settings);
 
+	if (dp_get_link_encoding_format(&link_settings) == DP_128b_132b_ENCODING &&
+			pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT) {
+		dp_enable_mst_on_sink(link, true);
+	}
+
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP) {
 		/*in case it is not on*/
 		link->dc->hwss.edp_power_control(link, true);
 		link->dc->hwss.edp_wait_for_hpd_ready(link, true);
 	}
 
-	pipe_ctx->stream_res.pix_clk_params.requested_sym_clk =
-			link_settings.link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
-	if (state->clk_mgr && !apply_seamless_boot_optimization)
-		state->clk_mgr->funcs->update_clocks(state->clk_mgr,
-						     state, false);
+	if (dp_get_link_encoding_format(&link_settings) == DP_128b_132b_ENCODING) {
+		/* TODO - DP2.0 HW: calculate 32 symbol clock for HPO encoder */
+	} else {
+		pipe_ctx->stream_res.pix_clk_params.requested_sym_clk =
+				link_settings.link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
+		if (state->clk_mgr && !apply_seamless_boot_optimization)
+			state->clk_mgr->funcs->update_clocks(state->clk_mgr,
+					state, false);
+	}
 
 	// during mode switch we do DP_SET_POWER off then on, and OUI is lost
 	dpcd_set_source_specific_data(link);
@@ -1780,7 +1823,8 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	else
 		fec_enable = true;
 
-	dp_set_fec_enable(link, fec_enable);
+	if (dp_get_link_encoding_format(&link_settings) == DP_8b_10b_ENCODING)
+		dp_set_fec_enable(link, fec_enable);
 
 	// during mode set we do DP_SET_POWER off then on, aux writes are lost
 	if (link->dpcd_sink_ext_caps.bits.oled == 1 ||
@@ -2284,6 +2328,7 @@ static void disable_link(struct dc_link *link, enum signal_type signal)
 
 	if (dc_is_dp_signal(signal)) {
 		/* SST DP, eDP */
+		struct dc_link_settings link_settings = link->cur_link_settings;
 		if (dc_is_dp_sst_signal(signal))
 			dp_disable_link_phy(link, signal);
 		else
@@ -2291,8 +2336,10 @@ static void disable_link(struct dc_link *link, enum signal_type signal)
 
 		if (dc_is_dp_sst_signal(signal) ||
 				link->mst_stream_alloc_table.stream_count == 0) {
-			dp_set_fec_enable(link, false);
-			dp_set_fec_ready(link, false);
+			if (dp_get_link_encoding_format(&link_settings) == DP_8b_10b_ENCODING) {
+				dp_set_fec_enable(link, false);
+				dp_set_fec_ready(link, false);
+			}
 		}
 	} else {
 		if (signal != SIGNAL_TYPE_VIRTUAL)
@@ -2475,9 +2522,8 @@ static bool dp_active_dongle_validate_timing(
 		break;
 	}
 
-	if (dpcd_caps->dongle_type != DISPLAY_DONGLE_DP_HDMI_CONVERTER ||
-		dongle_caps->extendedCapValid == false)
-		return true;
+	if (dpcd_caps->dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER &&
+			dongle_caps->extendedCapValid == true) {
 
 	/* Check Pixel Encoding */
 	switch (timing->pixel_encoding) {
@@ -2520,6 +2566,85 @@ static bool dp_active_dongle_validate_timing(
 	if (get_timing_pixel_clock_100hz(timing) > (dongle_caps->dp_hdmi_max_pixel_clk_in_khz * 10))
 		return false;
 
+	}
+
+	if (dongle_caps->dfp_cap_ext.supported) {
+
+		if (dongle_caps->dfp_cap_ext.max_pixel_rate_in_mps < (timing->pix_clk_100hz / 10000))
+			return false;
+
+		if (dongle_caps->dfp_cap_ext.max_video_h_active_width < timing->h_addressable)
+			return false;
+
+		if (dongle_caps->dfp_cap_ext.max_video_v_active_height < timing->v_addressable)
+			return false;
+
+		if (timing->pixel_encoding == PIXEL_ENCODING_RGB) {
+			if (!dongle_caps->dfp_cap_ext.encoding_format_caps.support_rgb)
+				return false;
+			if (timing->display_color_depth == COLOR_DEPTH_666 &&
+					!dongle_caps->dfp_cap_ext.rgb_color_depth_caps.support_6bpc)
+				return false;
+			else if (timing->display_color_depth == COLOR_DEPTH_888 &&
+					!dongle_caps->dfp_cap_ext.rgb_color_depth_caps.support_8bpc)
+				return false;
+			else if (timing->display_color_depth == COLOR_DEPTH_101010 &&
+					!dongle_caps->dfp_cap_ext.rgb_color_depth_caps.support_10bpc)
+				return false;
+			else if (timing->display_color_depth == COLOR_DEPTH_121212 &&
+					!dongle_caps->dfp_cap_ext.rgb_color_depth_caps.support_12bpc)
+				return false;
+			else if (timing->display_color_depth == COLOR_DEPTH_161616 &&
+					!dongle_caps->dfp_cap_ext.rgb_color_depth_caps.support_16bpc)
+				return false;
+		} else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR444) {
+			if (!dongle_caps->dfp_cap_ext.encoding_format_caps.support_rgb)
+				return false;
+			if (timing->display_color_depth == COLOR_DEPTH_888 &&
+					!dongle_caps->dfp_cap_ext.ycbcr444_color_depth_caps.support_8bpc)
+				return false;
+			else if (timing->display_color_depth == COLOR_DEPTH_101010 &&
+					!dongle_caps->dfp_cap_ext.ycbcr444_color_depth_caps.support_10bpc)
+				return false;
+			else if (timing->display_color_depth == COLOR_DEPTH_121212 &&
+					!dongle_caps->dfp_cap_ext.ycbcr444_color_depth_caps.support_12bpc)
+				return false;
+			else if (timing->display_color_depth == COLOR_DEPTH_161616 &&
+					!dongle_caps->dfp_cap_ext.ycbcr444_color_depth_caps.support_16bpc)
+				return false;
+		} else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+			if (!dongle_caps->dfp_cap_ext.encoding_format_caps.support_rgb)
+				return false;
+			if (timing->display_color_depth == COLOR_DEPTH_888 &&
+					!dongle_caps->dfp_cap_ext.ycbcr422_color_depth_caps.support_8bpc)
+				return false;
+			else if (timing->display_color_depth == COLOR_DEPTH_101010 &&
+					!dongle_caps->dfp_cap_ext.ycbcr422_color_depth_caps.support_10bpc)
+				return false;
+			else if (timing->display_color_depth == COLOR_DEPTH_121212 &&
+					!dongle_caps->dfp_cap_ext.ycbcr422_color_depth_caps.support_12bpc)
+				return false;
+			else if (timing->display_color_depth == COLOR_DEPTH_161616 &&
+					!dongle_caps->dfp_cap_ext.ycbcr422_color_depth_caps.support_16bpc)
+				return false;
+		} else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+			if (!dongle_caps->dfp_cap_ext.encoding_format_caps.support_rgb)
+				return false;
+			if (timing->display_color_depth == COLOR_DEPTH_888 &&
+					!dongle_caps->dfp_cap_ext.ycbcr420_color_depth_caps.support_8bpc)
+				return false;
+			else if (timing->display_color_depth == COLOR_DEPTH_101010 &&
+					!dongle_caps->dfp_cap_ext.ycbcr420_color_depth_caps.support_10bpc)
+				return false;
+			else if (timing->display_color_depth == COLOR_DEPTH_121212 &&
+					!dongle_caps->dfp_cap_ext.ycbcr420_color_depth_caps.support_12bpc)
+				return false;
+			else if (timing->display_color_depth == COLOR_DEPTH_161616 &&
+					!dongle_caps->dfp_cap_ext.ycbcr420_color_depth_caps.support_16bpc)
+				return false;
+		}
+	}
+
 	return true;
 }
 
@@ -3016,6 +3141,157 @@ static void update_mst_stream_alloc_table(
 		link->mst_stream_alloc_table.stream_allocations[i] =
 				work_table[i];
 }
+/* TODO: Temp function for Diags FPGA */
+static void dp2_update_mst_stream_alloc_table(
+	struct dc_link *link,
+	struct stream_encoder *dio_stream_enc,
+	struct hpo_dp_stream_encoder *hpo_dp_stream_enc,
+	const struct dp_mst_stream_allocation_table *proposed_table)
+{
+	struct link_mst_stream_allocation work_table[MAX_CONTROLLER_NUM] = {
+			{ 0 } };
+	struct link_mst_stream_allocation *dc_alloc;
+
+	int i;
+	int j;
+
+	/* if DRM proposed_table has more than one new payload */
+	ASSERT(proposed_table->stream_count -
+			link->mst_stream_alloc_table.stream_count < 2);
+
+	/* copy proposed_table to link, add stream encoder */
+	for (i = 0; i < proposed_table->stream_count; i++) {
+
+		for (j = 0; j < link->mst_stream_alloc_table.stream_count; j++) {
+			dc_alloc =
+			&link->mst_stream_alloc_table.stream_allocations[j];
+
+			if (dc_alloc->vcp_id ==
+				proposed_table->stream_allocations[i].vcp_id) {
+
+				work_table[i] = *dc_alloc;
+				break; /* exit j loop */
+			}
+		}
+
+		/* new vcp_id */
+		if (j == link->mst_stream_alloc_table.stream_count) {
+			work_table[i].vcp_id =
+				proposed_table->stream_allocations[i].vcp_id;
+			work_table[i].slot_count =
+				proposed_table->stream_allocations[i].slot_count;
+			work_table[i].stream_enc = dio_stream_enc;
+			work_table[i].hpo_dp_stream_enc = hpo_dp_stream_enc;
+		}
+	}
+
+	/* update link->mst_stream_alloc_table with work_table */
+	link->mst_stream_alloc_table.stream_count =
+			proposed_table->stream_count;
+	for (i = 0; i < MAX_CONTROLLER_NUM; i++)
+		link->mst_stream_alloc_table.stream_allocations[i] =
+				work_table[i];
+}
+
+/*
+ * Payload allocation/deallocation for SST introduced in DP2.0
+ */
+enum dc_status dc_link_update_sst_payload(struct pipe_ctx *pipe_ctx, bool allocate)
+{
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->link;
+	struct hpo_dp_link_encoder *hpo_dp_link_encoder = link->hpo_dp_link_enc;
+	struct hpo_dp_stream_encoder *hpo_dp_stream_encoder = pipe_ctx->stream_res.hpo_dp_stream_enc;
+	struct link_mst_stream_allocation_table proposed_table = {0};
+	struct fixed31_32 avg_time_slots_per_mtp;
+	DC_LOGGER_INIT(link->ctx->logger);
+
+	/* slot X.Y for SST payload deallocate */
+	if (!allocate) {
+		avg_time_slots_per_mtp = dc_fixpt_from_int(0);
+
+		DC_LOG_DP2("SST Update Payload: set_throttled_vcp_size slot X.Y for SST stream"
+				"X: %d "
+				"Y: %d",
+				dc_fixpt_floor(
+					avg_time_slots_per_mtp),
+				dc_fixpt_ceil(
+					dc_fixpt_shl(
+						dc_fixpt_sub_int(
+							avg_time_slots_per_mtp,
+							dc_fixpt_floor(
+									avg_time_slots_per_mtp)),
+						26)));
+
+		hpo_dp_link_encoder->funcs->set_throttled_vcp_size(
+				hpo_dp_link_encoder,
+				hpo_dp_stream_encoder->inst,
+				avg_time_slots_per_mtp);
+	}
+
+	/* calculate VC payload and update branch with new payload allocation table*/
+	if (!dpcd_write_128b_132b_sst_payload_allocation_table(
+			stream,
+			link,
+			&proposed_table,
+			allocate)) {
+		DC_LOG_ERROR("SST Update Payload: Failed to update "
+						"allocation table for "
+						"pipe idx: %d\n",
+						pipe_ctx->pipe_idx);
+	}
+
+	proposed_table.stream_allocations[0].hpo_dp_stream_enc = hpo_dp_stream_encoder;
+
+	ASSERT(proposed_table.stream_count == 1);
+
+	//TODO - DP2.0 Logging: Instead of hpo_dp_stream_enc pointer, log instance id
+	DC_LOG_DP2("SST Update Payload: hpo_dp_stream_enc: %p      "
+		"vcp_id: %d      "
+		"slot_count: %d\n",
+		(void *) proposed_table.stream_allocations[0].hpo_dp_stream_enc,
+		proposed_table.stream_allocations[0].vcp_id,
+		proposed_table.stream_allocations[0].slot_count);
+
+	/* program DP source TX for payload */
+	hpo_dp_link_encoder->funcs->update_stream_allocation_table(
+			hpo_dp_link_encoder,
+			&proposed_table);
+
+	/* poll for ACT handled */
+	if (!dpcd_poll_for_allocation_change_trigger(link)) {
+		// Failures will result in blackscreen and errors logged
+		BREAK_TO_DEBUGGER();
+	}
+
+	/* slot X.Y for SST payload allocate */
+	if (allocate) {
+		avg_time_slots_per_mtp = calculate_sst_avg_time_slots_per_mtp(stream, link);
+
+		DC_LOG_DP2("SST Update Payload: "
+				"slot.X: %d      "
+				"slot.Y: %d",
+				dc_fixpt_floor(
+					avg_time_slots_per_mtp),
+				dc_fixpt_ceil(
+					dc_fixpt_shl(
+						dc_fixpt_sub_int(
+							avg_time_slots_per_mtp,
+							dc_fixpt_floor(
+									avg_time_slots_per_mtp)),
+						26)));
+
+		hpo_dp_link_encoder->funcs->set_throttled_vcp_size(
+				hpo_dp_link_encoder,
+				hpo_dp_stream_encoder->inst,
+				avg_time_slots_per_mtp);
+	}
+
+	/* Always return DC_OK.
+	 * If part of sequence fails, log failure(s) and show blackscreen
+	 */
+	return DC_OK;
+}
 
 /* convert link_mst_stream_alloc_table to dm dp_mst_stream_alloc_table
  * because stream_encoder is not exposed to dm
@@ -3203,6 +3479,11 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 		config.stream_enc_idx = pipe_ctx->stream_res.stream_enc->id - ENGINE_ID_DIGA;
 		config.link_enc_idx = pipe_ctx->stream->link->link_enc->transmitter - TRANSMITTER_UNIPHY_A;
 		config.phy_idx = pipe_ctx->stream->link->link_enc->transmitter - TRANSMITTER_UNIPHY_A;
+		if (is_dp_128b_132b_signal(pipe_ctx)) {
+			config.stream_enc_idx = pipe_ctx->stream_res.hpo_dp_stream_enc->id - ENGINE_ID_HPO_DP_0;
+			config.link_enc_idx = pipe_ctx->stream->link->hpo_dp_link_enc->inst;
+			config.dp2_enabled = 1;
+		}
 #endif
 		config.dpms_off = dpms_off;
 		config.dm_stream_ctx = pipe_ctx->stream->dm_stream_context;
@@ -3214,6 +3495,86 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 }
 #endif
 
+static void fpga_dp_hpo_enable_link_and_stream(struct dc_state *state, struct pipe_ctx *pipe_ctx)
+{
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct link_mst_stream_allocation_table proposed_table = {0};
+	struct fixed31_32 avg_time_slots_per_mtp;
+	uint8_t req_slot_count = 0;
+	uint8_t vc_id = 1; /// VC ID always 1 for SST
+
+	struct dc_link_settings link_settings = {0};
+	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
+
+	decide_link_settings(stream, &link_settings);
+	stream->link->cur_link_settings = link_settings;
+
+	/*  Enable clock, Configure lane count, and Enable Link Encoder*/
+	enable_dp_hpo_output(stream->link, &stream->link->cur_link_settings);
+
+#ifdef DIAGS_BUILD
+	/* Workaround for FPGA HPO capture DP link data:
+	 * HPO capture will set link to active mode
+	 * This workaround is required to get a capture from start of frame
+	 */
+	if (!dc->debug.fpga_hpo_capture_en) {
+		struct encoder_set_dp_phy_pattern_param params = {0};
+		params.dp_phy_pattern = DP_TEST_PATTERN_VIDEO_MODE;
+
+		/* Set link active */
+		stream->link->hpo_dp_link_enc->funcs->set_link_test_pattern(
+				stream->link->hpo_dp_link_enc,
+				&params);
+	}
+#endif
+
+	/* Enable DP_STREAM_ENC */
+	dc->hwss.enable_stream(pipe_ctx);
+
+	/* Set DPS PPS SDP (AKA "info frames") */
+	if (pipe_ctx->stream->timing.flags.DSC) {
+		dp_set_dsc_pps_sdp(pipe_ctx, true);
+	}
+
+	/* Allocate Payload */
+	if ((stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) && (state->stream_count > 1)) {
+		// MST case
+		uint8_t i;
+
+		proposed_table.stream_count = state->stream_count;
+		for (i = 0; i < state->stream_count; i++) {
+			avg_time_slots_per_mtp = calculate_sst_avg_time_slots_per_mtp(state->streams[i], state->streams[i]->link);
+			req_slot_count = dc_fixpt_ceil(avg_time_slots_per_mtp);
+			proposed_table.stream_allocations[i].slot_count = req_slot_count;
+			proposed_table.stream_allocations[i].vcp_id = i+1;
+			/* NOTE: This makes assumption that pipe_ctx index is same as stream index */
+			proposed_table.stream_allocations[i].hpo_dp_stream_enc = state->res_ctx.pipe_ctx[i].stream_res.hpo_dp_stream_enc;
+		}
+	} else {
+		// SST case
+		avg_time_slots_per_mtp = calculate_sst_avg_time_slots_per_mtp(stream, stream->link);
+		req_slot_count = dc_fixpt_ceil(avg_time_slots_per_mtp);
+		proposed_table.stream_count = 1; /// Always 1 stream for SST
+		proposed_table.stream_allocations[0].slot_count = req_slot_count;
+		proposed_table.stream_allocations[0].vcp_id = vc_id;
+		proposed_table.stream_allocations[0].hpo_dp_stream_enc = pipe_ctx->stream_res.hpo_dp_stream_enc;
+	}
+
+	stream->link->hpo_dp_link_enc->funcs->update_stream_allocation_table(
+			stream->link->hpo_dp_link_enc,
+			&proposed_table);
+
+	stream->link->hpo_dp_link_enc->funcs->set_throttled_vcp_size(
+			stream->link->hpo_dp_link_enc,
+			pipe_ctx->stream_res.hpo_dp_stream_enc->inst,
+			avg_time_slots_per_mtp);
+
+
+
+	dc->hwss.unblank_stream(pipe_ctx, &stream->link->cur_link_settings);
+}
+
 void core_link_enable_stream(
 		struct dc_state *state,
 		struct pipe_ctx *pipe_ctx)
@@ -3230,7 +3591,8 @@ void core_link_enable_stream(
 			dc_is_virtual_signal(pipe_ctx->stream->signal))
 		return;
 
-	if (!dc_is_virtual_signal(pipe_ctx->stream->signal)) {
+	if (!dc_is_virtual_signal(pipe_ctx->stream->signal)
+			&& !is_dp_128b_132b_signal(pipe_ctx)) {
 		stream->link->link_enc->funcs->setup(
 			stream->link->link_enc,
 			pipe_ctx->stream->signal);
@@ -3240,13 +3602,23 @@ void core_link_enable_stream(
 			stream->timing.timing_3d_format != TIMING_3D_FORMAT_NONE);
 	}
 
-	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+	if (is_dp_128b_132b_signal(pipe_ctx)) {
+		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->set_stream_attribute(
+				pipe_ctx->stream_res.hpo_dp_stream_enc,
+				&stream->timing,
+				stream->output_color_space,
+				stream->use_vsc_sdp_for_colorimetry,
+				stream->timing.flags.DSC,
+				false);
+		otg_out_dest = OUT_MUX_HPO_DP;
+	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
 		pipe_ctx->stream_res.stream_enc->funcs->dp_set_stream_attribute(
-			pipe_ctx->stream_res.stream_enc,
-			&stream->timing,
-			stream->output_color_space,
-			stream->use_vsc_sdp_for_colorimetry,
-			stream->link->dpcd_caps.dprx_feature.bits.SST_SPLIT_SDP_CAP);
+				pipe_ctx->stream_res.stream_enc,
+				&stream->timing,
+				stream->output_color_space,
+				stream->use_vsc_sdp_for_colorimetry,
+				stream->link->dpcd_caps.dprx_feature.bits.SST_SPLIT_SDP_CAP);
+	}
 
 	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
 		pipe_ctx->stream_res.stream_enc->funcs->hdmi_set_stream_attribute(
@@ -3357,7 +3729,8 @@ void core_link_enable_stream(
 		 * as a workaround for the incorrect value being applied
 		 * from transmitter control.
 		 */
-		if (!dc_is_virtual_signal(pipe_ctx->stream->signal))
+		if (!(dc_is_virtual_signal(pipe_ctx->stream->signal) ||
+				is_dp_128b_132b_signal(pipe_ctx)))
 			stream->link->link_enc->funcs->setup(
 				stream->link->link_enc,
 				pipe_ctx->stream->signal);
@@ -3375,6 +3748,9 @@ void core_link_enable_stream(
 
 		if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 			dc_link_allocate_mst_payload(pipe_ctx);
+		else if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
+				is_dp_128b_132b_signal(pipe_ctx))
+			dc_link_update_sst_payload(pipe_ctx, true);
 
 		dc->hwss.unblank_stream(pipe_ctx,
 			&pipe_ctx->stream->link->cur_link_settings);
@@ -3391,6 +3767,9 @@ void core_link_enable_stream(
 		dc->hwss.enable_audio_stream(pipe_ctx);
 
 	} else { // if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
+		if (is_dp_128b_132b_signal(pipe_ctx)) {
+			fpga_dp_hpo_enable_link_and_stream(state, pipe_ctx);
+		}
 		if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
 				dc_is_virtual_signal(pipe_ctx->stream->signal))
 			dp_set_dsc_enable(pipe_ctx, true);
@@ -3426,6 +3805,9 @@ void core_link_disable_stream(struct pipe_ctx *pipe_ctx)
 
 	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 		deallocate_mst_payload(pipe_ctx);
+	else if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
+			is_dp_128b_132b_signal(pipe_ctx))
+		dc_link_update_sst_payload(pipe_ctx, false);
 
 	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
 		struct ext_hdmi_settings settings = {0};
@@ -3452,14 +3834,31 @@ void core_link_disable_stream(struct pipe_ctx *pipe_ctx)
 		}
 	}
 
-	disable_link(pipe_ctx->stream->link, pipe_ctx->stream->signal);
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
+			!is_dp_128b_132b_signal(pipe_ctx)) {
 
-	dc->hwss.disable_stream(pipe_ctx);
+		/* In DP1.x SST mode, our encoder will go to TPS1
+		 * when link is on but stream is off.
+		 * Disabling link before stream will avoid exposing TPS1 pattern
+		 * during the disable sequence as it will confuse some receivers
+		 * state machine.
+		 * In DP2 or MST mode, our encoder will stay video active
+		 */
+		disable_link(pipe_ctx->stream->link, pipe_ctx->stream->signal);
+		dc->hwss.disable_stream(pipe_ctx);
+	} else {
+		dc->hwss.disable_stream(pipe_ctx);
+		disable_link(pipe_ctx->stream->link, pipe_ctx->stream->signal);
+	}
 
 	if (pipe_ctx->stream->timing.flags.DSC) {
 		if (dc_is_dp_signal(pipe_ctx->stream->signal))
 			dp_set_dsc_enable(pipe_ctx, false);
 	}
+	if (is_dp_128b_132b_signal(pipe_ctx)) {
+		if (pipe_ctx->stream_res.tg->funcs->set_out_mux)
+			pipe_ctx->stream_res.tg->funcs->set_out_mux(pipe_ctx->stream_res.tg, OUT_MUX_DIO);
+	}
 }
 
 void core_link_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
@@ -3592,6 +3991,11 @@ void dc_link_set_preferred_training_settings(struct dc *dc,
 
 	if (link_setting != NULL) {
 		link->preferred_link_setting = *link_setting;
+		if (dp_get_link_encoding_format(link_setting) ==
+				DP_128b_132b_ENCODING && !link->hpo_dp_link_enc) {
+			if (!add_dp_hpo_link_encoder_to_link(link))
+				memset(&link->preferred_link_setting, 0, sizeof(link->preferred_link_setting));
+		}
 	} else {
 		link->preferred_link_setting.lane_count = LANE_COUNT_UNKNOWN;
 		link->preferred_link_setting.link_rate = LINK_RATE_UNKNOWN;
@@ -3633,39 +4037,36 @@ uint32_t dc_link_bandwidth_kbps(
 	const struct dc_link *link,
 	const struct dc_link_settings *link_setting)
 {
-	uint32_t link_bw_kbps =
-		link_setting->link_rate * LINK_RATE_REF_FREQ_IN_KHZ; /* bytes per sec */
-
-	link_bw_kbps *= 8;   /* 8 bits per byte*/
-	link_bw_kbps *= link_setting->lane_count;
-
-	if (dc_link_should_enable_fec(link)) {
-		/* Account for FEC overhead.
-		 * We have to do it based on caps,
-		 * and not based on FEC being set ready,
-		 * because FEC is set ready too late in
-		 * the process to correctly be picked up
-		 * by mode enumeration.
-		 *
-		 * There's enough zeros at the end of 'kbps'
-		 * that make the below operation 100% precise
-		 * for our purposes.
-		 * 'long long' makes it work even for HDMI 2.1
-		 * max bandwidth (and much, much bigger bandwidths
-		 * than that, actually).
-		 *
-		 * NOTE: Reducing link BW by 3% may not be precise
-		 * because it may be a stream BT that increases by 3%, and so
-		 * 1/1.03 = 0.970873 factor should have been used instead,
-		 * but the difference is minimal and is in a safe direction,
-		 * which all works well around potential ambiguity of DP 1.4a spec.
+	uint32_t total_data_bw_efficiency_x10000 = 0;
+	uint32_t link_rate_per_lane_kbps = 0;
+
+	switch (dp_get_link_encoding_format(link_setting)) {
+	case DP_8b_10b_ENCODING:
+		/* For 8b/10b encoding:
+		 * link rate is defined in the unit of LINK_RATE_REF_FREQ_IN_KHZ per DP byte per lane.
+		 * data bandwidth efficiency is 80% with additional 3% overhead if FEC is supported.
+		 */
+		link_rate_per_lane_kbps = link_setting->link_rate * LINK_RATE_REF_FREQ_IN_KHZ * BITS_PER_DP_BYTE;
+		total_data_bw_efficiency_x10000 = DATA_EFFICIENCY_8b_10b_x10000;
+		if (dc_link_should_enable_fec(link)) {
+			total_data_bw_efficiency_x10000 /= 100;
+			total_data_bw_efficiency_x10000 *= DATA_EFFICIENCY_8b_10b_FEC_EFFICIENCY_x100;
+		}
+		break;
+	case DP_128b_132b_ENCODING:
+		/* For 128b/132b encoding:
+		 * link rate is defined in the unit of 10mbps per lane.
+		 * total data bandwidth efficiency is always 96.71%.
 		 */
-		long long fec_link_bw_kbps = link_bw_kbps * 970LL;
-		link_bw_kbps = (uint32_t)(div64_s64(fec_link_bw_kbps, 1000LL));
+		link_rate_per_lane_kbps = link_setting->link_rate * 10000;
+		total_data_bw_efficiency_x10000 = DATA_EFFICIENCY_128b_132b_x10000;
+		break;
+	default:
+		break;
 	}
 
-	return link_bw_kbps;
-
+	/* overall effective link bandwidth = link rate per lane * lane count * total data bandwidth efficiency */
+	return link_rate_per_lane_kbps * link_setting->lane_count / 10000 * total_data_bw_efficiency_x10000;
 }
 
 const struct dc_link_settings *dc_link_get_link_cap(
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index cd025c12f17b..4dd3a3a73e62 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -39,6 +39,41 @@ enum {
 	POST_LT_ADJ_REQ_TIMEOUT = 200
 };
 
+struct dp_lt_fallback_entry {
+	enum dc_lane_count lane_count;
+	enum dc_link_rate link_rate;
+};
+
+static const struct dp_lt_fallback_entry dp_lt_fallbacks[] = {
+		/* This link training fallback array is ordered by
+		 * link bandwidth from highest to lowest.
+		 * DP specs makes it a normative policy to always
+		 * choose the next highest link bandwidth during
+		 * link training fallback.
+		 */
+		{LANE_COUNT_FOUR, LINK_RATE_UHBR20},
+		{LANE_COUNT_FOUR, LINK_RATE_UHBR13_5},
+		{LANE_COUNT_TWO, LINK_RATE_UHBR20},
+		{LANE_COUNT_FOUR, LINK_RATE_UHBR10},
+		{LANE_COUNT_TWO, LINK_RATE_UHBR13_5},
+		{LANE_COUNT_FOUR, LINK_RATE_HIGH3},
+		{LANE_COUNT_ONE, LINK_RATE_UHBR20},
+		{LANE_COUNT_TWO, LINK_RATE_UHBR10},
+		{LANE_COUNT_FOUR, LINK_RATE_HIGH2},
+		{LANE_COUNT_ONE, LINK_RATE_UHBR13_5},
+		{LANE_COUNT_TWO, LINK_RATE_HIGH3},
+		{LANE_COUNT_ONE, LINK_RATE_UHBR10},
+		{LANE_COUNT_TWO, LINK_RATE_HIGH2},
+		{LANE_COUNT_FOUR, LINK_RATE_HIGH},
+		{LANE_COUNT_ONE, LINK_RATE_HIGH3},
+		{LANE_COUNT_FOUR, LINK_RATE_LOW},
+		{LANE_COUNT_ONE, LINK_RATE_HIGH2},
+		{LANE_COUNT_TWO, LINK_RATE_HIGH},
+		{LANE_COUNT_TWO, LINK_RATE_LOW},
+		{LANE_COUNT_ONE, LINK_RATE_HIGH},
+		{LANE_COUNT_ONE, LINK_RATE_LOW},
+};
+
 static bool decide_fallback_link_setting(
 		struct dc_link_settings initial_link_settings,
 		struct dc_link_settings *current_link_setting,
@@ -54,13 +89,16 @@ static uint32_t get_cr_training_aux_rd_interval(struct dc_link *link,
 	uint32_t wait_in_micro_secs = 100;
 
 	memset(&training_rd_interval, 0, sizeof(training_rd_interval));
-	core_link_read_dpcd(
-			link,
-			DP_TRAINING_AUX_RD_INTERVAL,
-			(uint8_t *)&training_rd_interval,
-			sizeof(training_rd_interval));
-	if (training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL)
-		wait_in_micro_secs = training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL * 4000;
+	if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING &&
+			link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_12) {
+		core_link_read_dpcd(
+				link,
+				DP_TRAINING_AUX_RD_INTERVAL,
+				(uint8_t *)&training_rd_interval,
+				sizeof(training_rd_interval));
+		if (training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL)
+			wait_in_micro_secs = training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL * 4000;
+	}
 	return wait_in_micro_secs;
 }
 
@@ -69,31 +107,43 @@ static uint32_t get_eq_training_aux_rd_interval(
 	const struct dc_link_settings *link_settings)
 {
 	union training_aux_rd_interval training_rd_interval;
-	uint32_t wait_in_micro_secs = 400;
 
 	memset(&training_rd_interval, 0, sizeof(training_rd_interval));
-	/* overwrite the delay if rev > 1.1*/
-	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_12) {
-		/* DP 1.2 or later - retrieve delay through
-		 * "DPCD_ADDR_TRAINING_AUX_RD_INTERVAL" register */
+	if (dp_get_link_encoding_format(link_settings) == DP_128b_132b_ENCODING) {
 		core_link_read_dpcd(
-			link,
-			DP_TRAINING_AUX_RD_INTERVAL,
-			(uint8_t *)&training_rd_interval,
-			sizeof(training_rd_interval));
-
-		if (training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL)
-			wait_in_micro_secs = training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL * 4000;
+				link,
+				DP_128b_132b_TRAINING_AUX_RD_INTERVAL,
+				(uint8_t *)&training_rd_interval,
+				sizeof(training_rd_interval));
+	} else if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING &&
+			link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_12) {
+		core_link_read_dpcd(
+				link,
+				DP_TRAINING_AUX_RD_INTERVAL,
+				(uint8_t *)&training_rd_interval,
+				sizeof(training_rd_interval));
 	}
 
-	return wait_in_micro_secs;
+	switch (training_rd_interval.bits.TRAINIG_AUX_RD_INTERVAL) {
+	case 0: return 400;
+	case 1: return 4000;
+	case 2: return 8000;
+	case 3: return 12000;
+	case 4: return 16000;
+	case 5: return 32000;
+	case 6: return 64000;
+	default: return 400;
+	}
 }
 
 void dp_wait_for_training_aux_rd_interval(
 	struct dc_link *link,
 	uint32_t wait_in_micro_secs)
 {
-	udelay(wait_in_micro_secs);
+	if (wait_in_micro_secs > 16000)
+		msleep(wait_in_micro_secs/1000);
+	else
+		udelay(wait_in_micro_secs);
 
 	DC_LOG_HW_LINK_TRAINING("%s:\n wait = %d\n",
 		__func__,
@@ -121,6 +171,15 @@ enum dpcd_training_patterns
 	case DP_TRAINING_PATTERN_SEQUENCE_4:
 		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_4;
 		break;
+	case DP_128b_132b_TPS1:
+		dpcd_tr_pattern = DPCD_128b_132b_TPS1;
+		break;
+	case DP_128b_132b_TPS2:
+		dpcd_tr_pattern = DPCD_128b_132b_TPS2;
+		break;
+	case DP_128b_132b_TPS2_CDS:
+		dpcd_tr_pattern = DPCD_128b_132b_TPS2_CDS;
+		break;
 	case DP_TRAINING_PATTERN_VIDEOIDLE:
 		dpcd_tr_pattern = DPCD_TRAINING_PATTERN_VIDEOIDLE;
 		break;
@@ -159,16 +218,27 @@ static void dpcd_set_training_pattern(
 static enum dc_dp_training_pattern decide_cr_training_pattern(
 		const struct dc_link_settings *link_settings)
 {
-	return DP_TRAINING_PATTERN_SEQUENCE_1;
+	enum dc_dp_training_pattern pattern = DP_TRAINING_PATTERN_SEQUENCE_1;
+
+	switch (dp_get_link_encoding_format(link_settings)) {
+	case DP_8b_10b_ENCODING:
+		pattern = DP_TRAINING_PATTERN_SEQUENCE_1;
+		break;
+	case DP_128b_132b_ENCODING:
+		pattern = DP_128b_132b_TPS1;
+		break;
+	}
+
+	return pattern;
 }
 
 static enum dc_dp_training_pattern decide_eq_training_pattern(struct dc_link *link,
 		const struct dc_link_settings *link_settings)
 {
 	struct link_encoder *link_enc;
-	enum dc_dp_training_pattern highest_tp = DP_TRAINING_PATTERN_SEQUENCE_2;
-	struct encoder_feature_support *features;
-	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
+	struct encoder_feature_support *enc_caps;
+	struct dpcd_caps *rx_caps = &link->dpcd_caps;
+	enum dc_dp_training_pattern pattern = DP_TRAINING_PATTERN_SEQUENCE_2;
 
 	/* Access link encoder capability based on whether it is statically
 	 * or dynamically assigned to a link.
@@ -179,23 +249,55 @@ static enum dc_dp_training_pattern decide_eq_training_pattern(struct dc_link *li
 	else
 		link_enc = link->link_enc;
 	ASSERT(link_enc);
-	features = &link_enc->features;
-
-	if (features->flags.bits.IS_TPS3_CAPABLE)
-		highest_tp = DP_TRAINING_PATTERN_SEQUENCE_3;
-
-	if (features->flags.bits.IS_TPS4_CAPABLE)
-		highest_tp = DP_TRAINING_PATTERN_SEQUENCE_4;
+	enc_caps = &link_enc->features;
+
+	switch (dp_get_link_encoding_format(link_settings)) {
+	case DP_8b_10b_ENCODING:
+		if (enc_caps->flags.bits.IS_TPS4_CAPABLE &&
+				rx_caps->max_down_spread.bits.TPS4_SUPPORTED)
+			pattern = DP_TRAINING_PATTERN_SEQUENCE_4;
+		else if (enc_caps->flags.bits.IS_TPS3_CAPABLE &&
+				rx_caps->max_ln_count.bits.TPS3_SUPPORTED)
+			pattern = DP_TRAINING_PATTERN_SEQUENCE_3;
+		else
+			pattern = DP_TRAINING_PATTERN_SEQUENCE_2;
+		break;
+	case DP_128b_132b_ENCODING:
+		pattern = DP_128b_132b_TPS2;
+		break;
+	default:
+		pattern = DP_TRAINING_PATTERN_SEQUENCE_2;
+		break;
+	}
+	return pattern;
+}
 
-	if (dpcd_caps->max_down_spread.bits.TPS4_SUPPORTED &&
-		highest_tp >= DP_TRAINING_PATTERN_SEQUENCE_4)
-		return DP_TRAINING_PATTERN_SEQUENCE_4;
+static uint8_t get_dpcd_link_rate(const struct dc_link_settings *link_settings)
+{
+	uint8_t link_rate = 0;
+	enum dp_link_encoding encoding = dp_get_link_encoding_format(link_settings);
 
-	if (dpcd_caps->max_ln_count.bits.TPS3_SUPPORTED &&
-		highest_tp >= DP_TRAINING_PATTERN_SEQUENCE_3)
-		return DP_TRAINING_PATTERN_SEQUENCE_3;
+	if (encoding == DP_128b_132b_ENCODING)
+		switch (link_settings->link_rate) {
+		case LINK_RATE_UHBR10:
+			link_rate = 0x1;
+			break;
+		case LINK_RATE_UHBR20:
+			link_rate = 0x2;
+			break;
+		case LINK_RATE_UHBR13_5:
+			link_rate = 0x4;
+			break;
+		default:
+			link_rate = 0;
+			break;
+		}
+	else if (encoding == DP_8b_10b_ENCODING)
+		link_rate = (uint8_t) link_settings->link_rate;
+	else
+		link_rate = 0;
 
-	return DP_TRAINING_PATTERN_SEQUENCE_2;
+	return link_rate;
 }
 
 enum dc_status dpcd_set_link_settings(
@@ -247,7 +349,8 @@ enum dc_status dpcd_set_link_settings(
 		status = core_link_write_dpcd(link, DP_LINK_RATE_SET,
 				&lt_settings->link_settings.link_rate_set, 1);
 	} else {
-		rate = (uint8_t) (lt_settings->link_settings.link_rate);
+		rate = get_dpcd_link_rate(&lt_settings->link_settings);
+
 		status = core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
 	}
 
@@ -289,6 +392,8 @@ uint8_t dc_dp_initialize_scrambling_data_symbols(
 		disable_scrabled_data_symbols = 1;
 		break;
 	case DP_TRAINING_PATTERN_SEQUENCE_4:
+	case DP_128b_132b_TPS1:
+	case DP_128b_132b_TPS2:
 		disable_scrabled_data_symbols = 0;
 		break;
 	default:
@@ -356,17 +461,24 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 	for (lane = 0; lane <
 		(uint32_t)(lt_settings->link_settings.lane_count); lane++) {
 
-		dpcd_lane[lane].bits.VOLTAGE_SWING_SET =
-		(uint8_t)(lt_settings->lane_settings[lane].VOLTAGE_SWING);
-		dpcd_lane[lane].bits.PRE_EMPHASIS_SET =
-		(uint8_t)(lt_settings->lane_settings[lane].PRE_EMPHASIS);
-
-		dpcd_lane[lane].bits.MAX_SWING_REACHED =
-		(lt_settings->lane_settings[lane].VOLTAGE_SWING ==
-		VOLTAGE_SWING_MAX_LEVEL ? 1 : 0);
-		dpcd_lane[lane].bits.MAX_PRE_EMPHASIS_REACHED =
-		(lt_settings->lane_settings[lane].PRE_EMPHASIS ==
-		PRE_EMPHASIS_MAX_LEVEL ? 1 : 0);
+		if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
+				DP_128b_132b_ENCODING) {
+			dpcd_lane[lane].tx_ffe.PRESET_VALUE =
+					lt_settings->lane_settings[lane].FFE_PRESET.settings.level;
+		} else if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
+				DP_8b_10b_ENCODING) {
+			dpcd_lane[lane].bits.VOLTAGE_SWING_SET =
+					(uint8_t)(lt_settings->lane_settings[lane].VOLTAGE_SWING);
+			dpcd_lane[lane].bits.PRE_EMPHASIS_SET =
+					(uint8_t)(lt_settings->lane_settings[lane].PRE_EMPHASIS);
+
+			dpcd_lane[lane].bits.MAX_SWING_REACHED =
+					(lt_settings->lane_settings[lane].VOLTAGE_SWING ==
+							VOLTAGE_SWING_MAX_LEVEL ? 1 : 0);
+			dpcd_lane[lane].bits.MAX_PRE_EMPHASIS_REACHED =
+					(lt_settings->lane_settings[lane].PRE_EMPHASIS ==
+							PRE_EMPHASIS_MAX_LEVEL ? 1 : 0);
+		}
 	}
 
 	/* concatenate everything into one buffer*/
@@ -380,6 +492,16 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 		size_in_bytes);
 
 	if (is_repeater(link, offset)) {
+		if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
+				DP_128b_132b_ENCODING)
+			DC_LOG_HW_LINK_TRAINING("%s:\n LTTPR Repeater ID: %d\n"
+					" 0x%X TX_FFE_PRESET_VALUE = %x\n",
+					__func__,
+					offset,
+					dpcd_base_lt_offset,
+					dpcd_lane[0].tx_ffe.PRESET_VALUE);
+		else if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
+				DP_8b_10b_ENCODING)
 		DC_LOG_HW_LINK_TRAINING("%s:\n LTTPR Repeater ID: %d\n"
 				" 0x%X VS set = %x PE set = %x max VS Reached = %x  max PE Reached = %x\n",
 			__func__,
@@ -390,6 +512,14 @@ static void dpcd_set_lt_pattern_and_lane_settings(
 			dpcd_lane[0].bits.MAX_SWING_REACHED,
 			dpcd_lane[0].bits.MAX_PRE_EMPHASIS_REACHED);
 	} else {
+		if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
+				DP_128b_132b_ENCODING)
+			DC_LOG_HW_LINK_TRAINING("%s:\n 0x%X TX_FFE_PRESET_VALUE = %x\n",
+					__func__,
+					dpcd_base_lt_offset,
+					dpcd_lane[0].tx_ffe.PRESET_VALUE);
+		else if (dp_get_link_encoding_format(&lt_settings->link_settings) ==
+				DP_8b_10b_ENCODING)
 		DC_LOG_HW_LINK_TRAINING("%s:\n 0x%X VS set = %x  PE set = %x max VS Reached = %x  max PE Reached = %x\n",
 			__func__,
 			dpcd_base_lt_offset,
@@ -484,6 +614,11 @@ void dp_update_drive_settings(
 			dest->lane_settings[lane].POST_CURSOR2 = src.lane_settings[lane].POST_CURSOR2;
 		else
 			dest->lane_settings[lane].POST_CURSOR2 = *dest->post_cursor2;
+
+		if (dest->ffe_preset == NULL)
+			dest->lane_settings[lane].FFE_PRESET = src.lane_settings[lane].FFE_PRESET;
+		else
+			dest->lane_settings[lane].FFE_PRESET = *dest->ffe_preset;
 	}
 }
 
@@ -529,6 +664,8 @@ static void find_max_drive_settings(
 		lane_settings[0].PRE_EMPHASIS;
 	/*max_requested.postCursor2 =
 	 * link_training_setting->laneSettings[0].postCursor2;*/
+	max_requested.FFE_PRESET =
+		link_training_setting->lane_settings[0].FFE_PRESET;
 
 	/* Determine what the maximum of the requested settings are*/
 	for (lane = 1; lane < link_training_setting->link_settings.lane_count;
@@ -554,6 +691,11 @@ static void find_max_drive_settings(
 		link_training_setting->laneSettings[lane].postCursor2;
 		}
 		*/
+		if (link_training_setting->lane_settings[lane].FFE_PRESET.settings.level >
+				max_requested.FFE_PRESET.settings.level)
+			max_requested.FFE_PRESET.settings.level =
+					link_training_setting->
+					lane_settings[lane].FFE_PRESET.settings.level;
 	}
 
 	/* make sure the requested settings are
@@ -567,6 +709,8 @@ static void find_max_drive_settings(
 	if (max_requested.postCursor2 > PostCursor2_MaxLevel)
 	max_requested.postCursor2 = PostCursor2_MaxLevel;
 	*/
+	if (max_requested.FFE_PRESET.settings.level > DP_FFE_PRESET_MAX_LEVEL)
+		max_requested.FFE_PRESET.settings.level = DP_FFE_PRESET_MAX_LEVEL;
 
 	/* make sure the pre-emphasis matches the voltage swing*/
 	if (max_requested.PRE_EMPHASIS >
@@ -604,6 +748,8 @@ static void find_max_drive_settings(
 		/*max_lt_setting->laneSettings[lane].postCursor2 =
 		 * max_requested.postCursor2;
 		 */
+		max_lt_setting->lane_settings[lane].FFE_PRESET =
+			max_requested.FFE_PRESET;
 	}
 
 }
@@ -701,12 +847,19 @@ enum dc_status dp_get_lane_status_and_drive_settings(
 		(uint32_t)(link_training_setting->link_settings.lane_count);
 		lane++) {
 
-		request_settings.lane_settings[lane].VOLTAGE_SWING =
-			(enum dc_voltage_swing)(dpcd_lane_adjust[lane].bits.
-				VOLTAGE_SWING_LANE);
-		request_settings.lane_settings[lane].PRE_EMPHASIS =
-			(enum dc_pre_emphasis)(dpcd_lane_adjust[lane].bits.
-				PRE_EMPHASIS_LANE);
+		if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
+				DP_128b_132b_ENCODING) {
+			request_settings.lane_settings[lane].FFE_PRESET.raw =
+					dpcd_lane_adjust[lane].tx_ffe.PRESET_VALUE;
+		} else if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
+				DP_8b_10b_ENCODING) {
+			request_settings.lane_settings[lane].VOLTAGE_SWING =
+					(enum dc_voltage_swing)(dpcd_lane_adjust[lane].bits.
+							VOLTAGE_SWING_LANE);
+			request_settings.lane_settings[lane].PRE_EMPHASIS =
+					(enum dc_pre_emphasis)(dpcd_lane_adjust[lane].bits.
+							PRE_EMPHASIS_LANE);
+		}
 	}
 
 	/*Note: for postcursor2, read adjusted
@@ -745,20 +898,24 @@ enum dc_status dpcd_set_lane_settings(
 		(uint32_t)(link_training_setting->
 		link_settings.lane_count);
 		lane++) {
-		dpcd_lane[lane].bits.VOLTAGE_SWING_SET =
-			(uint8_t)(link_training_setting->
-			lane_settings[lane].VOLTAGE_SWING);
-		dpcd_lane[lane].bits.PRE_EMPHASIS_SET =
-			(uint8_t)(link_training_setting->
-			lane_settings[lane].PRE_EMPHASIS);
-		dpcd_lane[lane].bits.MAX_SWING_REACHED =
-			(link_training_setting->
-			lane_settings[lane].VOLTAGE_SWING ==
-			VOLTAGE_SWING_MAX_LEVEL ? 1 : 0);
-		dpcd_lane[lane].bits.MAX_PRE_EMPHASIS_REACHED =
-			(link_training_setting->
-			lane_settings[lane].PRE_EMPHASIS ==
-			PRE_EMPHASIS_MAX_LEVEL ? 1 : 0);
+		if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
+				DP_128b_132b_ENCODING) {
+			dpcd_lane[lane].tx_ffe.PRESET_VALUE =
+					link_training_setting->lane_settings[lane].FFE_PRESET.settings.level;
+		} else if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
+				DP_8b_10b_ENCODING) {
+			dpcd_lane[lane].bits.VOLTAGE_SWING_SET =
+					(uint8_t)(link_training_setting->lane_settings[lane].VOLTAGE_SWING);
+			dpcd_lane[lane].bits.PRE_EMPHASIS_SET =
+					(uint8_t)(link_training_setting->lane_settings[lane].PRE_EMPHASIS);
+
+			dpcd_lane[lane].bits.MAX_SWING_REACHED =
+					(link_training_setting->lane_settings[lane].VOLTAGE_SWING ==
+							VOLTAGE_SWING_MAX_LEVEL ? 1 : 0);
+			dpcd_lane[lane].bits.MAX_PRE_EMPHASIS_REACHED =
+					(link_training_setting->lane_settings[lane].PRE_EMPHASIS ==
+							PRE_EMPHASIS_MAX_LEVEL ? 1 : 0);
+		}
 	}
 
 	status = core_link_write_dpcd(link,
@@ -786,6 +943,16 @@ enum dc_status dpcd_set_lane_settings(
 	*/
 
 	if (is_repeater(link, offset)) {
+		if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
+				DP_128b_132b_ENCODING)
+			DC_LOG_HW_LINK_TRAINING("%s:\n LTTPR Repeater ID: %d\n"
+					" 0x%X TX_FFE_PRESET_VALUE = %x\n",
+					__func__,
+					offset,
+					lane0_set_address,
+					dpcd_lane[0].tx_ffe.PRESET_VALUE);
+		else if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
+				DP_8b_10b_ENCODING)
 		DC_LOG_HW_LINK_TRAINING("%s\n LTTPR Repeater ID: %d\n"
 				" 0x%X VS set = %x  PE set = %x max VS Reached = %x  max PE Reached = %x\n",
 			__func__,
@@ -797,6 +964,14 @@ enum dc_status dpcd_set_lane_settings(
 			dpcd_lane[0].bits.MAX_PRE_EMPHASIS_REACHED);
 
 	} else {
+		if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
+				DP_128b_132b_ENCODING)
+			DC_LOG_HW_LINK_TRAINING("%s:\n 0x%X TX_FFE_PRESET_VALUE = %x\n",
+					__func__,
+					lane0_set_address,
+					dpcd_lane[0].tx_ffe.PRESET_VALUE);
+		else if (dp_get_link_encoding_format(&link_training_setting->link_settings) ==
+				DP_8b_10b_ENCODING)
 		DC_LOG_HW_LINK_TRAINING("%s\n 0x%X VS set = %x  PE set = %x max VS Reached = %x  max PE Reached = %x\n",
 			__func__,
 			lane0_set_address,
@@ -932,6 +1107,12 @@ uint32_t dp_translate_training_aux_read_interval(uint32_t dpcd_aux_read_interval
 	case 0x04:
 		aux_rd_interval_us = 16000;
 		break;
+	case 0x05:
+		aux_rd_interval_us = 32000;
+		break;
+	case 0x06:
+		aux_rd_interval_us = 64000;
+		break;
 	default:
 		break;
 	}
@@ -972,7 +1153,7 @@ static enum link_training_result perform_channel_equalization_sequence(
 
 	tr_pattern = lt_settings->pattern_for_eq;
 
-	if (is_repeater(link, offset))
+	if (is_repeater(link, offset) && dp_get_link_encoding_format(&lt_settings->link_settings) == DP_8b_10b_ENCODING)
 		tr_pattern = DP_TRAINING_PATTERN_SEQUENCE_4;
 
 	dp_set_hw_training_pattern(link, tr_pattern, offset);
@@ -1125,16 +1306,18 @@ static enum link_training_result perform_clock_recovery_sequence(
 			return LINK_TRAINING_SUCCESS;
 
 		/* 6. max VS reached*/
-		if (dp_is_max_vs_reached(lt_settings))
+		if ((dp_get_link_encoding_format(&lt_settings->link_settings) ==
+				DP_8b_10b_ENCODING) &&
+				dp_is_max_vs_reached(lt_settings))
 			break;
 
-		/* 7. same lane settings*/
-		/* Note: settings are the same for all lanes,
-		 * so comparing first lane is sufficient*/
-		if ((lt_settings->lane_settings[0].VOLTAGE_SWING ==
-			req_settings.lane_settings[0].VOLTAGE_SWING)
-			&& (lt_settings->lane_settings[0].PRE_EMPHASIS ==
-				req_settings.lane_settings[0].PRE_EMPHASIS))
+		if ((dp_get_link_encoding_format(&lt_settings->link_settings) == DP_128b_132b_ENCODING) &&
+				lt_settings->lane_settings[0].FFE_PRESET.settings.level ==
+						req_settings.lane_settings[0].FFE_PRESET.settings.level)
+			retries_cr++;
+		else if ((dp_get_link_encoding_format(&lt_settings->link_settings) == DP_8b_10b_ENCODING) &&
+				lt_settings->lane_settings[0].VOLTAGE_SWING ==
+						req_settings.lane_settings[0].VOLTAGE_SWING)
 			retries_cr++;
 		else
 			retries_cr = 0;
@@ -1172,7 +1355,7 @@ static inline enum link_training_result dp_transition_to_video_idle(
 	 * TPS4 must be used instead of POST_LT_ADJ_REQ.
 	 */
 	if (link->dpcd_caps.max_ln_count.bits.POST_LT_ADJ_REQ_SUPPORTED != 1 ||
-			lt_settings->pattern_for_eq == DP_TRAINING_PATTERN_SEQUENCE_4) {
+			lt_settings->pattern_for_eq >= DP_TRAINING_PATTERN_SEQUENCE_4) {
 		/* delay 5ms after Main Link output idle pattern and then check
 		 * DPCD 0202h.
 		 */
@@ -1268,6 +1451,30 @@ static inline void decide_8b_10b_training_settings(
 	lt_settings->should_set_fec_ready = true;
 }
 
+static inline void decide_128b_132b_training_settings(struct dc_link *link,
+		const struct dc_link_settings *link_settings,
+		struct link_training_settings *lt_settings)
+{
+	memset(lt_settings, 0, sizeof(*lt_settings));
+
+	lt_settings->link_settings = *link_settings;
+	/* TODO: should decide link spread when populating link_settings */
+	lt_settings->link_settings.link_spread = link->dp_ss_off ? LINK_SPREAD_DISABLED :
+			LINK_SPREAD_05_DOWNSPREAD_30KHZ;
+
+	lt_settings->pattern_for_cr = decide_cr_training_pattern(link_settings);
+	lt_settings->pattern_for_eq = decide_eq_training_pattern(link, link_settings);
+	lt_settings->eq_pattern_time = 2500;
+	lt_settings->eq_wait_time_limit = 400000;
+	lt_settings->eq_loop_count_limit = 20;
+	lt_settings->pattern_for_cds = DP_128b_132b_TPS2_CDS;
+	lt_settings->cds_pattern_time = 2500;
+	lt_settings->cds_wait_time_limit = (dp_convert_to_count(
+			link->dpcd_caps.lttpr_caps.phy_repeater_cnt) + 1) * 20000;
+	lt_settings->lttpr_mode = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) ?
+			LTTPR_MODE_NON_TRANSPARENT : LTTPR_MODE_TRANSPARENT;
+}
+
 void dp_decide_training_settings(
 		struct dc_link *link,
 		const struct dc_link_settings *link_settings,
@@ -1275,6 +1482,8 @@ void dp_decide_training_settings(
 {
 	if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING)
 		decide_8b_10b_training_settings(link, link_settings, lt_settings);
+	else if (dp_get_link_encoding_format(link_settings) == DP_128b_132b_ENCODING)
+		decide_128b_132b_training_settings(link, link_settings, lt_settings);
 }
 
 static void override_training_settings(
@@ -1303,6 +1512,9 @@ static void override_training_settings(
 		lt_settings->pre_emphasis = overrides->pre_emphasis;
 	if (overrides->post_cursor2 != NULL)
 		lt_settings->post_cursor2 = overrides->post_cursor2;
+	if (overrides->ffe_preset != NULL)
+		lt_settings->ffe_preset = overrides->ffe_preset;
+
 	for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
 		lt_settings->lane_settings[lane].VOLTAGE_SWING =
 			lt_settings->voltage_swing != NULL ?
@@ -1489,6 +1701,15 @@ static void print_status_message(
 	case LINK_RATE_HIGH3:
 		link_rate = "HBR3";
 		break;
+	case LINK_RATE_UHBR10:
+		link_rate = "UHBR10";
+		break;
+	case LINK_RATE_UHBR13_5:
+		link_rate = "UHBR13.5";
+		break;
+	case LINK_RATE_UHBR20:
+		link_rate = "UHBR20";
+		break;
 	default:
 		break;
 	}
@@ -1518,6 +1739,18 @@ static void print_status_message(
 	case LINK_TRAINING_LINK_LOSS:
 		lt_result = "Link loss";
 		break;
+	case DP_128b_132b_LT_FAILED:
+		lt_result = "LT_FAILED received";
+		break;
+	case DP_128b_132b_MAX_LOOP_COUNT_REACHED:
+		lt_result = "max loop count reached";
+		break;
+	case DP_128b_132b_CHANNEL_EQ_DONE_TIMEOUT:
+		lt_result = "channel EQ timeout";
+		break;
+	case DP_128b_132b_CDS_DONE_TIMEOUT:
+		lt_result = "CDS timeout";
+		break;
 	default:
 		break;
 	}
@@ -1537,6 +1770,7 @@ static void print_status_message(
 	}
 
 	/* Connectivity log: link training */
+	/* TODO - DP2.0 Log: add connectivity log for FFE PRESET */
 	CONN_MSG_LT(link, "%sx%d %s VS=%d, PE=%d, DS=%s",
 				link_rate,
 				lt_settings->link_settings.lane_count,
@@ -1619,9 +1853,19 @@ enum dc_status dpcd_configure_lttpr_mode(struct dc_link *link, struct link_train
 
 static void dpcd_exit_training_mode(struct dc_link *link)
 {
+	uint8_t sink_status = 0;
+	uint8_t i;
 
 	/* clear training pattern set */
 	dpcd_set_training_pattern(link, DP_TRAINING_PATTERN_VIDEOIDLE);
+
+	/* poll for intra-hop disable */
+	for (i = 0; i < 10; i++) {
+		if ((core_link_read_dpcd(link, DP_SINK_STATUS, &sink_status, 1) == DC_OK) &&
+				(sink_status & DP_INTRA_HOP_AUX_REPLY_INDICATION) == 0)
+			break;
+		udelay(1000);
+	}
 }
 
 enum dc_status dpcd_configure_channel_coding(struct dc_link *link,
@@ -1645,6 +1889,129 @@ enum dc_status dpcd_configure_channel_coding(struct dc_link *link,
 	return status;
 }
 
+static void dpcd_128b_132b_get_aux_rd_interval(struct dc_link *link,
+		uint32_t *interval_in_us)
+{
+	union dp_128b_132b_training_aux_rd_interval dpcd_interval;
+	uint32_t interval_unit = 0;
+
+	dpcd_interval.raw = 0;
+	core_link_read_dpcd(link, DP_128b_132b_TRAINING_AUX_RD_INTERVAL,
+			&dpcd_interval.raw, sizeof(dpcd_interval.raw));
+	interval_unit = dpcd_interval.bits.UNIT ? 1 : 2; /* 0b = 2 ms, 1b = 1 ms */
+	/* (128b/132b_TRAINING_AUX_RD_INTERVAL value + 1) *
+	 * INTERVAL_UNIT. The maximum is 256 ms
+	 */
+	*interval_in_us = (dpcd_interval.bits.VALUE + 1) * interval_unit * 1000;
+}
+
+static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
+		struct dc_link *link,
+		struct link_training_settings *lt_settings)
+{
+	uint8_t loop_count = 0;
+	uint32_t aux_rd_interval = 0;
+	uint32_t wait_time = 0;
+	struct link_training_settings req_settings;
+	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
+	enum link_training_result status = LINK_TRAINING_SUCCESS;
+
+	/* Transmit 128b/132b_TPS1 over Main-Link and Set TRAINING_PATTERN_SET to 01h */
+	dp_set_hw_training_pattern(link, lt_settings->pattern_for_cr, DPRX);
+	dpcd_set_training_pattern(link, lt_settings->pattern_for_cr);
+
+	/* Adjust TX_FFE_PRESET_VALUE as requested */
+	dp_get_lane_status_and_drive_settings(link, lt_settings, dpcd_lane_status,
+			&dpcd_lane_status_updated, &req_settings, DPRX);
+	dp_update_drive_settings(lt_settings, req_settings);
+	dpcd_128b_132b_get_aux_rd_interval(link, &aux_rd_interval);
+	dp_set_hw_lane_settings(link, lt_settings, DPRX);
+	dpcd_set_lane_settings(link, lt_settings, DPRX);
+
+	/* Transmit 128b/132b_TPS2 over Main-Link and Set TRAINING_PATTERN_SET to 02h */
+	dp_set_hw_training_pattern(link, lt_settings->pattern_for_eq, DPRX);
+	dpcd_set_training_pattern(link, lt_settings->pattern_for_eq);
+
+	/* poll for channel EQ done */
+	while (status == LINK_TRAINING_SUCCESS) {
+		loop_count++;
+		dp_wait_for_training_aux_rd_interval(link, aux_rd_interval);
+		wait_time += aux_rd_interval;
+		dp_get_lane_status_and_drive_settings(link, lt_settings, dpcd_lane_status,
+				&dpcd_lane_status_updated, &req_settings, DPRX);
+		dp_update_drive_settings(lt_settings, req_settings);
+		dpcd_128b_132b_get_aux_rd_interval(link, &aux_rd_interval);
+		if (dp_is_ch_eq_done(lt_settings->link_settings.lane_count,
+				dpcd_lane_status)) {
+			/* pass */
+			break;
+		} else if (loop_count >= lt_settings->eq_loop_count_limit) {
+			status = DP_128b_132b_MAX_LOOP_COUNT_REACHED;
+		} else if (dpcd_lane_status_updated.bits.LT_FAILED_128b_132b) {
+			status = DP_128b_132b_LT_FAILED;
+		} else {
+			dp_set_hw_lane_settings(link, lt_settings, DPRX);
+			dpcd_set_lane_settings(link, lt_settings, DPRX);
+		}
+	}
+
+	/* poll for EQ interlane align done */
+	while (status == LINK_TRAINING_SUCCESS) {
+		if (dpcd_lane_status_updated.bits.EQ_INTERLANE_ALIGN_DONE_128b_132b) {
+			/* pass */
+			break;
+		} else if (wait_time >= lt_settings->eq_wait_time_limit) {
+			status = DP_128b_132b_CHANNEL_EQ_DONE_TIMEOUT;
+		} else if (dpcd_lane_status_updated.bits.LT_FAILED_128b_132b) {
+			status = DP_128b_132b_LT_FAILED;
+		} else {
+			dp_wait_for_training_aux_rd_interval(link,
+					lt_settings->eq_pattern_time);
+			wait_time += lt_settings->eq_pattern_time;
+			dp_get_lane_status_and_drive_settings(link, lt_settings, dpcd_lane_status,
+					&dpcd_lane_status_updated, &req_settings, DPRX);
+		}
+	}
+
+	return status;
+}
+
+static enum link_training_result dp_perform_128b_132b_cds_done_sequence(
+		struct dc_link *link,
+		struct link_training_settings *lt_settings)
+{
+	/* Assumption: assume hardware has transmitted eq pattern */
+	enum link_training_result status = LINK_TRAINING_SUCCESS;
+	struct link_training_settings req_settings;
+	union lane_align_status_updated dpcd_lane_status_updated = { {0} };
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = { { {0} } };
+	uint32_t wait_time = 0;
+
+	/* initiate CDS done sequence */
+	dpcd_set_training_pattern(link, lt_settings->pattern_for_cds);
+
+	/* poll for CDS interlane align done and symbol lock */
+	while (status == LINK_TRAINING_SUCCESS) {
+		dp_wait_for_training_aux_rd_interval(link,
+				lt_settings->cds_pattern_time);
+		wait_time += lt_settings->cds_pattern_time;
+		dp_get_lane_status_and_drive_settings(link, lt_settings, dpcd_lane_status,
+						&dpcd_lane_status_updated, &req_settings, DPRX);
+		if (dp_is_symbol_locked(lt_settings->link_settings.lane_count, dpcd_lane_status) &&
+				dpcd_lane_status_updated.bits.CDS_INTERLANE_ALIGN_DONE_128b_132b) {
+			/* pass */
+			break;
+		} else if (dpcd_lane_status_updated.bits.LT_FAILED_128b_132b) {
+			status = DP_128b_132b_LT_FAILED;
+		} else if (wait_time >= lt_settings->cds_wait_time_limit) {
+			status = DP_128b_132b_CDS_DONE_TIMEOUT;
+		}
+	}
+
+	return status;
+}
+
 static enum link_training_result dp_perform_8b_10b_link_training(
 		struct dc_link *link,
 		struct link_training_settings *lt_settings)
@@ -1701,6 +2068,33 @@ static enum link_training_result dp_perform_8b_10b_link_training(
 	return status;
 }
 
+static enum link_training_result dp_perform_128b_132b_link_training(
+		struct dc_link *link,
+		struct link_training_settings *lt_settings)
+{
+	enum link_training_result result = LINK_TRAINING_SUCCESS;
+
+	/* TODO - DP2.0 Link: remove legacy_dp2_lt logic */
+	if (link->dc->debug.legacy_dp2_lt) {
+		struct link_training_settings legacy_settings;
+
+		decide_8b_10b_training_settings(link,
+				&lt_settings->link_settings,
+				&legacy_settings);
+		return dp_perform_8b_10b_link_training(link, &legacy_settings);
+	}
+
+	dpcd_set_link_settings(link, lt_settings);
+
+	if (result == LINK_TRAINING_SUCCESS)
+		result = dp_perform_128b_132b_channel_eq_done_sequence(link, lt_settings);
+
+	if (result == LINK_TRAINING_SUCCESS)
+		result = dp_perform_128b_132b_cds_done_sequence(link, lt_settings);
+
+	return result;
+}
+
 enum link_training_result dc_link_dp_perform_link_training(
 	struct dc_link *link,
 	const struct dc_link_settings *link_settings,
@@ -1735,6 +2129,8 @@ enum link_training_result dc_link_dp_perform_link_training(
 	 */
 	if (encoding == DP_8b_10b_ENCODING)
 		status = dp_perform_8b_10b_link_training(link, &lt_settings);
+	else if (encoding == DP_128b_132b_ENCODING)
+		status = dp_perform_128b_132b_link_training(link, &lt_settings);
 	else
 		ASSERT(0);
 
@@ -1780,7 +2176,8 @@ bool perform_link_training_with_retries(
 	/* We need to do this before the link training to ensure the idle pattern in SST
 	 * mode will be sent right after the link training
 	 */
-	link_enc->funcs->connect_dig_be_to_fe(link_enc,
+	if (dp_get_link_encoding_format(&current_setting) == DP_8b_10b_ENCODING)
+		link_enc->funcs->connect_dig_be_to_fe(link_enc,
 							pipe_ctx->stream_res.stream_enc->id, true);
 
 	for (j = 0; j < attempts; ++j) {
@@ -1950,8 +2347,10 @@ enum link_training_result dc_link_dp_sync_lt_attempt(
 		dp_cs_id, link_settings);
 
 	/* Set FEC enable */
-	fec_enable = lt_overrides->fec_enable && *lt_overrides->fec_enable;
-	dp_set_fec_ready(link, fec_enable);
+	if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING) {
+		fec_enable = lt_overrides->fec_enable && *lt_overrides->fec_enable;
+		dp_set_fec_ready(link, fec_enable);
+	}
 
 	if (lt_overrides->alternate_scrambler_reset) {
 		if (*lt_overrides->alternate_scrambler_reset)
@@ -1993,14 +2392,30 @@ bool dc_link_dp_sync_lt_end(struct dc_link *link, bool link_down)
 	 * Still shouldn't turn off dp_receiver (DPCD:600h)
 	 */
 	if (link_down == true) {
+		struct dc_link_settings link_settings = link->cur_link_settings;
 		dp_disable_link_phy(link, link->connector_signal);
-		dp_set_fec_ready(link, false);
+		if (dp_get_link_encoding_format(&link_settings) == DP_8b_10b_ENCODING)
+			dp_set_fec_ready(link, false);
 	}
 
 	link->sync_lt_in_progress = false;
 	return true;
 }
 
+static enum dc_link_rate get_lttpr_max_link_rate(struct dc_link *link)
+{
+	enum dc_link_rate lttpr_max_link_rate = link->dpcd_caps.lttpr_caps.max_link_rate;
+
+	if (link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.bits.UHBR20)
+		lttpr_max_link_rate = LINK_RATE_UHBR20;
+	else if (link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.bits.UHBR13_5)
+		lttpr_max_link_rate = LINK_RATE_UHBR13_5;
+	else if (link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.bits.UHBR10)
+		lttpr_max_link_rate = LINK_RATE_UHBR10;
+
+	return lttpr_max_link_rate;
+}
+
 bool dc_link_dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_settings *max_link_enc_cap)
 {
 	if (!max_link_enc_cap) {
@@ -2025,6 +2440,9 @@ static struct dc_link_settings get_max_link_cap(struct dc_link *link)
 
 	/* get max link encoder capability */
 	link->link_enc->funcs->get_max_link_cap(link->link_enc, &max_link_cap);
+	if (max_link_cap.link_rate >= LINK_RATE_UHBR10 &&
+			!link->hpo_dp_link_enc)
+		max_link_cap.link_rate = LINK_RATE_HIGH3;
 
 	/* Lower link settings based on sink's link cap */
 	if (link->reported_link_cap.lane_count < max_link_cap.lane_count)
@@ -2045,8 +2463,10 @@ static struct dc_link_settings get_max_link_cap(struct dc_link *link)
 		if (link->dpcd_caps.lttpr_caps.max_lane_count < max_link_cap.lane_count)
 			max_link_cap.lane_count = link->dpcd_caps.lttpr_caps.max_lane_count;
 
-		if (link->dpcd_caps.lttpr_caps.max_link_rate < max_link_cap.link_rate)
-			max_link_cap.link_rate = link->dpcd_caps.lttpr_caps.max_link_rate;
+		enum dc_link_rate lttpr_max_link_rate = get_lttpr_max_link_rate(link);
+
+		if (lttpr_max_link_rate < max_link_cap.link_rate)
+			max_link_cap.link_rate = lttpr_max_link_rate;
 
 		DC_LOG_HW_LINK_TRAINING("%s\n Training with LTTPR,  max_lane count %d max_link rate %d \n",
 						__func__,
@@ -2205,6 +2625,8 @@ bool dp_verify_link_cap(
 		core_link_write_dpcd(link, DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT, &grant, sizeof(grant));
 	}
 
+	if (dp_get_link_encoding_format(&link->cur_link_settings) == DP_128b_132b_ENCODING)
+		reset_dp_hpo_stream_encoders_for_link(link);
 	/* TODO implement override and monitor patch later */
 
 	/* try to train the link from high to low to
@@ -2360,7 +2782,13 @@ static struct dc_link_settings get_common_supported_link_settings(
 	 * We map it to the maximum supported link rate that
 	 * is smaller than MAX_LINK_BW in this case.
 	 */
-	if (link_settings.link_rate > LINK_RATE_HIGH3) {
+	if (link_settings.link_rate > LINK_RATE_UHBR20) {
+		link_settings.link_rate = LINK_RATE_UHBR20;
+	} else if (link_settings.link_rate < LINK_RATE_UHBR20 &&
+			link_settings.link_rate > LINK_RATE_UHBR13_5) {
+		link_settings.link_rate = LINK_RATE_UHBR13_5;
+	} else if (link_settings.link_rate < LINK_RATE_UHBR10 &&
+			link_settings.link_rate > LINK_RATE_HIGH3) {
 		link_settings.link_rate = LINK_RATE_HIGH3;
 	} else if (link_settings.link_rate < LINK_RATE_HIGH3
 			&& link_settings.link_rate > LINK_RATE_HIGH2) {
@@ -2405,6 +2833,12 @@ static enum dc_lane_count reduce_lane_count(enum dc_lane_count lane_count)
 static enum dc_link_rate reduce_link_rate(enum dc_link_rate link_rate)
 {
 	switch (link_rate) {
+	case LINK_RATE_UHBR20:
+		return LINK_RATE_UHBR13_5;
+	case LINK_RATE_UHBR13_5:
+		return LINK_RATE_UHBR10;
+	case LINK_RATE_UHBR10:
+		return LINK_RATE_HIGH3;
 	case LINK_RATE_HIGH3:
 		return LINK_RATE_HIGH2;
 	case LINK_RATE_HIGH2:
@@ -2439,11 +2873,51 @@ static enum dc_link_rate increase_link_rate(enum dc_link_rate link_rate)
 		return LINK_RATE_HIGH2;
 	case LINK_RATE_HIGH2:
 		return LINK_RATE_HIGH3;
+	case LINK_RATE_HIGH3:
+		return LINK_RATE_UHBR10;
+	case LINK_RATE_UHBR10:
+		return LINK_RATE_UHBR13_5;
+	case LINK_RATE_UHBR13_5:
+		return LINK_RATE_UHBR20;
 	default:
 		return LINK_RATE_UNKNOWN;
 	}
 }
 
+static bool decide_fallback_link_setting_max_bw_policy(
+		const struct dc_link_settings *max,
+		struct dc_link_settings *cur)
+{
+	uint8_t cur_idx = 0, next_idx;
+	bool found = false;
+
+	while (cur_idx < ARRAY_SIZE(dp_lt_fallbacks))
+		/* find current index */
+		if (dp_lt_fallbacks[cur_idx].lane_count == cur->lane_count &&
+				dp_lt_fallbacks[cur_idx].link_rate == cur->link_rate)
+			break;
+		else
+			cur_idx++;
+
+	next_idx = cur_idx + 1;
+
+	while (next_idx < ARRAY_SIZE(dp_lt_fallbacks))
+		/* find next index */
+		if (dp_lt_fallbacks[next_idx].lane_count <= max->lane_count &&
+				dp_lt_fallbacks[next_idx].link_rate <= max->link_rate)
+			break;
+		else
+			next_idx++;
+
+	if (next_idx < ARRAY_SIZE(dp_lt_fallbacks)) {
+		cur->lane_count = dp_lt_fallbacks[next_idx].lane_count;
+		cur->link_rate = dp_lt_fallbacks[next_idx].link_rate;
+		found = true;
+	}
+
+	return found;
+}
+
 /*
  * function: set link rate and lane count fallback based
  * on current link setting and last link training result
@@ -2459,6 +2933,9 @@ static bool decide_fallback_link_setting(
 {
 	if (!current_link_setting)
 		return false;
+	if (dp_get_link_encoding_format(&initial_link_settings) == DP_128b_132b_ENCODING)
+		return decide_fallback_link_setting_max_bw_policy(&initial_link_settings,
+				current_link_setting);
 
 	switch (training_result) {
 	case LINK_TRAINING_CR_FAIL_LANE0:
@@ -2832,8 +3309,8 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 	union lane_adjust dpcd_lane_adjustment[2];
 	unsigned char dpcd_post_cursor_2_adjustment = 0;
 	unsigned char test_pattern_buffer[
-			(DP_TEST_80BIT_CUSTOM_PATTERN_79_72 -
-			DP_TEST_80BIT_CUSTOM_PATTERN_7_0)+1] = {0};
+			(DP_TEST_264BIT_CUSTOM_PATTERN_263_256 -
+			DP_TEST_264BIT_CUSTOM_PATTERN_7_0)+1] = {0};
 	unsigned int test_pattern_size = 0;
 	enum dp_test_pattern test_pattern;
 	struct dc_link_training_settings link_settings;
@@ -2899,6 +3376,33 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 	case PHY_TEST_PATTERN_CP2520_3:
 		test_pattern = DP_TEST_PATTERN_TRAINING_PATTERN4;
 		break;
+	case PHY_TEST_PATTERN_128b_132b_TPS1:
+		test_pattern = DP_TEST_PATTERN_128b_132b_TPS1;
+		break;
+	case PHY_TEST_PATTERN_128b_132b_TPS2:
+		test_pattern = DP_TEST_PATTERN_128b_132b_TPS2;
+		break;
+	case PHY_TEST_PATTERN_PRBS9:
+		test_pattern = DP_TEST_PATTERN_PRBS9;
+		break;
+	case PHY_TEST_PATTERN_PRBS11:
+		test_pattern = DP_TEST_PATTERN_PRBS11;
+		break;
+	case PHY_TEST_PATTERN_PRBS15:
+		test_pattern = DP_TEST_PATTERN_PRBS15;
+		break;
+	case PHY_TEST_PATTERN_PRBS23:
+		test_pattern = DP_TEST_PATTERN_PRBS23;
+		break;
+	case PHY_TEST_PATTERN_PRBS31:
+		test_pattern = DP_TEST_PATTERN_PRBS31;
+		break;
+	case PHY_TEST_PATTERN_264BIT_CUSTOM:
+		test_pattern = DP_TEST_PATTERN_264BIT_CUSTOM;
+		break;
+	case PHY_TEST_PATTERN_SQUARE_PULSE:
+		test_pattern = DP_TEST_PATTERN_SQUARE_PULSE;
+		break;
 	default:
 		test_pattern = DP_TEST_PATTERN_VIDEO_MODE;
 	break;
@@ -2914,6 +3418,25 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 				test_pattern_size);
 	}
 
+	if (test_pattern == DP_TEST_PATTERN_SQUARE_PULSE) {
+		test_pattern_size = 1; // Square pattern data is 1 byte (DP spec)
+		core_link_read_dpcd(
+				link,
+				DP_PHY_SQUARE_PATTERN,
+				test_pattern_buffer,
+				test_pattern_size);
+	}
+
+	if (test_pattern == DP_TEST_PATTERN_264BIT_CUSTOM) {
+		test_pattern_size = (DP_TEST_264BIT_CUSTOM_PATTERN_263_256-
+				DP_TEST_264BIT_CUSTOM_PATTERN_7_0) + 1;
+		core_link_read_dpcd(
+				link,
+				DP_TEST_264BIT_CUSTOM_PATTERN_7_0,
+				test_pattern_buffer,
+				test_pattern_size);
+	}
+
 	/* prepare link training settings */
 	link_settings.link = link->cur_link_settings;
 
@@ -2922,15 +3445,22 @@ static void dp_test_send_phy_test_pattern(struct dc_link *link)
 		lane++) {
 		dpcd_lane_adjust.raw =
 			get_nibble_at_index(&dpcd_lane_adjustment[0].raw, lane);
-		link_settings.lane_settings[lane].VOLTAGE_SWING =
-			(enum dc_voltage_swing)
-			(dpcd_lane_adjust.bits.VOLTAGE_SWING_LANE);
-		link_settings.lane_settings[lane].PRE_EMPHASIS =
-			(enum dc_pre_emphasis)
-			(dpcd_lane_adjust.bits.PRE_EMPHASIS_LANE);
-		link_settings.lane_settings[lane].POST_CURSOR2 =
-			(enum dc_post_cursor2)
-			((dpcd_post_cursor_2_adjustment >> (lane * 2)) & 0x03);
+		if (dp_get_link_encoding_format(&link->cur_link_settings) ==
+				DP_128b_132b_ENCODING) {
+			link_settings.lane_settings[lane].FFE_PRESET.raw =
+					dpcd_lane_adjust.tx_ffe.PRESET_VALUE;
+		} else if (dp_get_link_encoding_format(&link->cur_link_settings) ==
+				DP_8b_10b_ENCODING) {
+			link_settings.lane_settings[lane].VOLTAGE_SWING =
+				(enum dc_voltage_swing)
+				(dpcd_lane_adjust.bits.VOLTAGE_SWING_LANE);
+			link_settings.lane_settings[lane].PRE_EMPHASIS =
+				(enum dc_pre_emphasis)
+				(dpcd_lane_adjust.bits.PRE_EMPHASIS_LANE);
+			link_settings.lane_settings[lane].POST_CURSOR2 =
+				(enum dc_post_cursor2)
+				((dpcd_post_cursor_2_adjustment >> (lane * 2)) & 0x03);
+		}
 	}
 
 	for (i = 0; i < 4; i++)
@@ -3535,6 +4065,41 @@ static void get_active_converter_info(
 			dp_hw_fw_revision.ieee_fw_rev,
 			sizeof(dp_hw_fw_revision.ieee_fw_rev));
 	}
+	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_14 &&
+			link->dpcd_caps.dongle_type != DISPLAY_DONGLE_NONE) {
+		union dp_dfp_cap_ext dfp_cap_ext;
+		memset(&dfp_cap_ext, '\0', sizeof (dfp_cap_ext));
+		core_link_read_dpcd(
+				link,
+				DP_DFP_CAPABILITY_EXTENSION_SUPPORT,
+				dfp_cap_ext.raw,
+				sizeof(dfp_cap_ext.raw));
+		link->dpcd_caps.dongle_caps.dfp_cap_ext.supported = dfp_cap_ext.fields.supported;
+		link->dpcd_caps.dongle_caps.dfp_cap_ext.max_pixel_rate_in_mps =
+				dfp_cap_ext.fields.max_pixel_rate_in_mps[0] +
+				(dfp_cap_ext.fields.max_pixel_rate_in_mps[1] << 8);
+		link->dpcd_caps.dongle_caps.dfp_cap_ext.max_video_h_active_width =
+				dfp_cap_ext.fields.max_video_h_active_width[0] +
+				(dfp_cap_ext.fields.max_video_h_active_width[1] << 8);
+		link->dpcd_caps.dongle_caps.dfp_cap_ext.max_video_v_active_height =
+				dfp_cap_ext.fields.max_video_v_active_height[0] +
+				(dfp_cap_ext.fields.max_video_v_active_height[1] << 8);
+		link->dpcd_caps.dongle_caps.dfp_cap_ext.encoding_format_caps =
+				dfp_cap_ext.fields.encoding_format_caps;
+		link->dpcd_caps.dongle_caps.dfp_cap_ext.rgb_color_depth_caps =
+				dfp_cap_ext.fields.rgb_color_depth_caps;
+		link->dpcd_caps.dongle_caps.dfp_cap_ext.ycbcr444_color_depth_caps =
+				dfp_cap_ext.fields.ycbcr444_color_depth_caps;
+		link->dpcd_caps.dongle_caps.dfp_cap_ext.ycbcr422_color_depth_caps =
+				dfp_cap_ext.fields.ycbcr422_color_depth_caps;
+		link->dpcd_caps.dongle_caps.dfp_cap_ext.ycbcr420_color_depth_caps =
+				dfp_cap_ext.fields.ycbcr420_color_depth_caps;
+		DC_LOG_DP2("DFP capability extension is read at link %d", link->link_index);
+		DC_LOG_DP2("\tdfp_cap_ext.supported = %s", link->dpcd_caps.dongle_caps.dfp_cap_ext.supported ? "true" : "false");
+		DC_LOG_DP2("\tdfp_cap_ext.max_pixel_rate_in_mps = %d", link->dpcd_caps.dongle_caps.dfp_cap_ext.max_pixel_rate_in_mps);
+		DC_LOG_DP2("\tdfp_cap_ext.max_video_h_active_width = %d", link->dpcd_caps.dongle_caps.dfp_cap_ext.max_video_h_active_width);
+		DC_LOG_DP2("\tdfp_cap_ext.max_video_v_active_height = %d", link->dpcd_caps.dongle_caps.dfp_cap_ext.max_video_v_active_height);
+	}
 }
 
 static void dp_wa_power_up_0010FA(struct dc_link *link, uint8_t *dpcd_data,
@@ -3602,6 +4167,16 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 
 	memset(lttpr_dpcd_data, '\0', sizeof(lttpr_dpcd_data));
 
+	bool allow_lttpr_non_transparent_mode = 0;
+
+	if ((link->dc->config.allow_lttpr_non_transparent_mode.bits.DP2_0 &&
+			link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED)) {
+		allow_lttpr_non_transparent_mode = 1;
+	} else if (link->dc->config.allow_lttpr_non_transparent_mode.bits.DP1_4A &&
+			!link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
+		allow_lttpr_non_transparent_mode = 1;
+	}
+
 	/*
 	 * Logic to determine LTTPR mode
 	 */
@@ -3609,13 +4184,12 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 	if (vbios_lttpr_enable && vbios_lttpr_interop)
 		link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
 	else if (!vbios_lttpr_enable && vbios_lttpr_interop) {
-		if (link->dc->config.allow_lttpr_non_transparent_mode)
+		if (allow_lttpr_non_transparent_mode)
 			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
 		else
 			link->lttpr_mode = LTTPR_MODE_TRANSPARENT;
 	} else if (!vbios_lttpr_enable && !vbios_lttpr_interop) {
-		if (!link->dc->config.allow_lttpr_non_transparent_mode
-			|| !link->dc->caps.extended_aux_timeout_support)
+		if (!allow_lttpr_non_transparent_mode || !link->dc->caps.extended_aux_timeout_support)
 			link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
 		else
 			link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
@@ -3909,16 +4483,72 @@ static bool retrieve_link_cap(struct dc_link *link)
 				DP_DSC_SUPPORT,
 				link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
 				sizeof(link->dpcd_caps.dsc_caps.dsc_basic_caps.raw));
-		status = core_link_read_dpcd(
-				link,
-				DP_DSC_BRANCH_OVERALL_THROUGHPUT_0,
-				link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
-				sizeof(link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw));
+		if (link->dpcd_caps.dongle_type != DISPLAY_DONGLE_NONE) {
+			status = core_link_read_dpcd(
+					link,
+					DP_DSC_BRANCH_OVERALL_THROUGHPUT_0,
+					link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
+					sizeof(link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw));
+			DC_LOG_DSC("DSC branch decoder capability is read at link %d", link->link_index);
+			DC_LOG_DSC("\tBRANCH_OVERALL_THROUGHPUT_0 = 0x%02x",
+					link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.fields.BRANCH_OVERALL_THROUGHPUT_0);
+			DC_LOG_DSC("\tBRANCH_OVERALL_THROUGHPUT_1 = 0x%02x",
+					link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.fields.BRANCH_OVERALL_THROUGHPUT_1);
+			DC_LOG_DSC("\tBRANCH_MAX_LINE_WIDTH 0x%02x",
+					link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.fields.BRANCH_MAX_LINE_WIDTH);
+		}
 	}
 
 	if (!dpcd_read_sink_ext_caps(link))
 		link->dpcd_sink_ext_caps.raw = 0;
 
+	link->dpcd_caps.channel_coding_cap.raw = dpcd_data[DP_MAIN_LINK_CHANNEL_CODING_CAP - DP_DPCD_REV];
+
+	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
+		DC_LOG_DP2("128b/132b encoding is supported at link %d", link->link_index);
+
+		core_link_read_dpcd(link,
+				DP_128b_132b_SUPPORTED_LINK_RATES,
+				&link->dpcd_caps.dp_128b_132b_supported_link_rates.raw,
+				sizeof(link->dpcd_caps.dp_128b_132b_supported_link_rates.raw));
+		if (link->dpcd_caps.dp_128b_132b_supported_link_rates.bits.UHBR20)
+			link->reported_link_cap.link_rate = LINK_RATE_UHBR20;
+		else if (link->dpcd_caps.dp_128b_132b_supported_link_rates.bits.UHBR13_5)
+			link->reported_link_cap.link_rate = LINK_RATE_UHBR13_5;
+		else if (link->dpcd_caps.dp_128b_132b_supported_link_rates.bits.UHBR10)
+			link->reported_link_cap.link_rate = LINK_RATE_UHBR10;
+		else
+			dm_error("%s: Invalid RX 128b_132b_supported_link_rates\n", __func__);
+		DC_LOG_DP2("128b/132b supported link rates is read at link %d", link->link_index);
+		DC_LOG_DP2("\tmax 128b/132b link rate support is %d.%d GHz",
+				link->reported_link_cap.link_rate / 100,
+				link->reported_link_cap.link_rate % 100);
+
+		core_link_read_dpcd(link,
+				DP_SINK_VIDEO_FALLBACK_FORMATS,
+				&link->dpcd_caps.fallback_formats.raw,
+				sizeof(link->dpcd_caps.fallback_formats.raw));
+		DC_LOG_DP2("sink video fallback format is read at link %d", link->link_index);
+		if (link->dpcd_caps.fallback_formats.bits.dp_1920x1080_60Hz_24bpp_support)
+			DC_LOG_DP2("\t1920x1080@60Hz 24bpp fallback format supported");
+		if (link->dpcd_caps.fallback_formats.bits.dp_1280x720_60Hz_24bpp_support)
+			DC_LOG_DP2("\t1280x720@60Hz 24bpp fallback format supported");
+		if (link->dpcd_caps.fallback_formats.bits.dp_1024x768_60Hz_24bpp_support)
+			DC_LOG_DP2("\t1024x768@60Hz 24bpp fallback format supported");
+		if (link->dpcd_caps.fallback_formats.raw == 0) {
+			DC_LOG_DP2("\tno supported fallback formats, assume 1920x1080@60Hz 24bpp is supported");
+			link->dpcd_caps.fallback_formats.bits.dp_1920x1080_60Hz_24bpp_support = 1;
+		}
+
+		core_link_read_dpcd(link,
+				DP_FEC_CAPABILITY_1,
+				&link->dpcd_caps.fec_cap1.raw,
+				sizeof(link->dpcd_caps.fec_cap1.raw));
+		DC_LOG_DP2("FEC CAPABILITY 1 is read at link %d", link->link_index);
+		if (link->dpcd_caps.fec_cap1.bits.AGGREGATED_ERROR_COUNTERS_CAPABLE)
+			DC_LOG_DP2("\tFEC aggregated error counters are supported");
+	}
+
 	/* Connectivity log: detection */
 	CONN_DATA_DETECT(link, dpcd_data, sizeof(dpcd_data), "Rx Caps: ");
 
@@ -4389,6 +5019,33 @@ bool dc_link_dp_set_test_pattern(
 		case DP_TEST_PATTERN_CP2520_3:
 			pattern = PHY_TEST_PATTERN_CP2520_3;
 			break;
+		case DP_TEST_PATTERN_128b_132b_TPS1:
+			pattern = PHY_TEST_PATTERN_128b_132b_TPS1;
+			break;
+		case DP_TEST_PATTERN_128b_132b_TPS2:
+			pattern = PHY_TEST_PATTERN_128b_132b_TPS2;
+			break;
+		case DP_TEST_PATTERN_PRBS9:
+			pattern = PHY_TEST_PATTERN_PRBS9;
+			break;
+		case DP_TEST_PATTERN_PRBS11:
+			pattern = PHY_TEST_PATTERN_PRBS11;
+			break;
+		case DP_TEST_PATTERN_PRBS15:
+			pattern = PHY_TEST_PATTERN_PRBS15;
+			break;
+		case DP_TEST_PATTERN_PRBS23:
+			pattern = PHY_TEST_PATTERN_PRBS23;
+			break;
+		case DP_TEST_PATTERN_PRBS31:
+			pattern = PHY_TEST_PATTERN_PRBS31;
+			break;
+		case DP_TEST_PATTERN_264BIT_CUSTOM:
+			pattern = PHY_TEST_PATTERN_264BIT_CUSTOM;
+			break;
+		case DP_TEST_PATTERN_SQUARE_PULSE:
+			pattern = PHY_TEST_PATTERN_SQUARE_PULSE;
+			break;
 		default:
 			return false;
 		}
@@ -4964,6 +5621,206 @@ enum dp_link_encoding dp_get_link_encoding_format(const struct dc_link_settings
 	if ((link_settings->link_rate >= LINK_RATE_LOW) &&
 			(link_settings->link_rate <= LINK_RATE_HIGH3))
 		return DP_8b_10b_ENCODING;
+	else if ((link_settings->link_rate >= LINK_RATE_UHBR10) &&
+			(link_settings->link_rate <= LINK_RATE_UHBR20))
+		return DP_128b_132b_ENCODING;
 	return DP_UNKNOWN_ENCODING;
 }
 
+// TODO - DP2.0 Link: Fix get_lane_status to handle LTTPR offset (SST and MST)
+static void get_lane_status(
+	struct dc_link *link,
+	uint32_t lane_count,
+	union lane_status *status,
+	union lane_align_status_updated *status_updated)
+{
+	unsigned int lane;
+
+	if (status == NULL || status_updated == NULL) {
+		return;
+	}
+
+	uint8_t dpcd_buf[3] = {0};
+
+	core_link_read_dpcd(
+			link,
+			DP_LANE0_1_STATUS,
+			dpcd_buf,
+			sizeof(dpcd_buf));
+
+	for (lane = 0; lane < lane_count; lane++) {
+		status[lane].raw = get_nibble_at_index(&dpcd_buf[0], lane);
+	}
+
+	status_updated->raw = dpcd_buf[2];
+}
+
+bool dpcd_write_128b_132b_sst_payload_allocation_table(
+		const struct dc_stream_state *stream,
+		struct dc_link *link,
+		struct link_mst_stream_allocation_table *proposed_table,
+		bool allocate)
+{
+	const uint8_t vc_id = 1; /// VC ID always 1 for SST
+	const uint8_t start_time_slot = 0; /// Always start at time slot 0 for SST
+	bool result = false;
+	uint8_t req_slot_count = 0;
+	struct fixed31_32 avg_time_slots_per_mtp = { 0 };
+
+	if (allocate)	{
+		avg_time_slots_per_mtp = calculate_sst_avg_time_slots_per_mtp(stream, link);
+		req_slot_count = dc_fixpt_ceil(avg_time_slots_per_mtp);
+	} else {
+		/// Leave req_slot_count = 0 if allocate is false.
+	}
+
+	union payload_table_update_status update_status = { 0 };
+
+	/// Write DPCD 2C0 = 1 to start updating
+	update_status.bits.VC_PAYLOAD_TABLE_UPDATED = 1;
+	core_link_write_dpcd(
+			link,
+			DP_PAYLOAD_TABLE_UPDATE_STATUS,
+			&update_status.raw,
+			1);
+
+	/// Program the changes in DPCD 1C0 - 1C2
+	ASSERT(vc_id == 1);
+	core_link_write_dpcd(
+			link,
+			DP_PAYLOAD_ALLOCATE_SET,
+			&vc_id,
+			1);
+
+	ASSERT(start_time_slot == 0);
+	core_link_write_dpcd(
+			link,
+			DP_PAYLOAD_ALLOCATE_START_TIME_SLOT,
+			&start_time_slot,
+			1);
+
+	ASSERT(req_slot_count <= MAX_MTP_SLOT_COUNT); /// Validation should filter out modes that exceed link BW
+	core_link_write_dpcd(
+			link,
+			DP_PAYLOAD_ALLOCATE_TIME_SLOT_COUNT,
+			&req_slot_count,
+			1);
+
+	/// Poll till DPCD 2C0 read 1
+	/// Try for at least 150ms (30 retries, with 5ms delay after each attempt)
+	const uint32_t max_retries = 30;
+	uint32_t retries = 0;
+
+	while (retries < max_retries) {
+		if (core_link_read_dpcd(
+				link,
+				DP_PAYLOAD_TABLE_UPDATE_STATUS,
+				&update_status.raw,
+				1) == DC_OK) {
+			if (update_status.bits.VC_PAYLOAD_TABLE_UPDATED == 1) {
+				DC_LOG_DP2("SST Update Payload: downstream payload table updated.");
+				result = true;
+				break;
+			}
+		} else {
+			union dpcd_rev dpcdRev;
+
+			if (core_link_read_dpcd(
+					link,
+					DP_DPCD_REV,
+					&dpcdRev.raw,
+					1) != DC_OK) {
+				DC_LOG_ERROR("SST Update Payload: Unable to read DPCD revision "
+						"of sink while polling payload table "
+						"updated status bit.");
+				break;
+			}
+		}
+		retries++;
+		udelay(5000);
+	}
+
+	if (!result && retries == max_retries) {
+		DC_LOG_ERROR("SST Update Payload: Payload table not updated after retries, "
+				"continue on. Something is wrong with the branch.");
+		// TODO - DP2.0 Payload: Read and log the payload table from downstream branch
+	}
+
+	proposed_table->stream_count = 1; /// Always 1 stream for SST
+	proposed_table->stream_allocations[0].slot_count = req_slot_count;
+	proposed_table->stream_allocations[0].vcp_id = vc_id;
+
+	return result;
+}
+
+bool dpcd_poll_for_allocation_change_trigger(struct dc_link *link)
+{
+	/*
+	 * wait for ACT handled
+	 */
+	int i;
+	const int act_retries = 30;
+	enum act_return_status result = ACT_FAILED;
+	union payload_table_update_status update_status = {0};
+	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX];
+	union lane_align_status_updated lane_status_updated;
+
+	for (i = 0; i < act_retries; i++) {
+		get_lane_status(link, link->cur_link_settings.lane_count, dpcd_lane_status, &lane_status_updated);
+
+		if (!dp_is_cr_done(link->cur_link_settings.lane_count, dpcd_lane_status) ||
+				!dp_is_ch_eq_done(link->cur_link_settings.lane_count, dpcd_lane_status) ||
+				!dp_is_symbol_locked(link->cur_link_settings.lane_count, dpcd_lane_status) ||
+				!dp_is_interlane_aligned(lane_status_updated)) {
+			DC_LOG_ERROR("SST Update Payload: Link loss occurred while "
+					"polling for ACT handled.");
+			result = ACT_LINK_LOST;
+			break;
+		}
+		core_link_read_dpcd(
+				link,
+				DP_PAYLOAD_TABLE_UPDATE_STATUS,
+				&update_status.raw,
+				1);
+
+		if (update_status.bits.ACT_HANDLED == 1) {
+			DC_LOG_DP2("SST Update Payload: ACT handled by downstream.");
+			result = ACT_SUCCESS;
+			break;
+		}
+
+		udelay(5000);
+	}
+
+	if (result == ACT_FAILED) {
+		DC_LOG_ERROR("SST Update Payload: ACT still not handled after retries, "
+				"continue on. Something is wrong with the branch.");
+	}
+
+	return (result == ACT_SUCCESS);
+}
+
+struct fixed31_32 calculate_sst_avg_time_slots_per_mtp(
+		const struct dc_stream_state *stream,
+		const struct dc_link *link)
+{
+	struct fixed31_32 link_bw_effective =
+			dc_fixpt_from_int(
+					dc_link_bandwidth_kbps(link, &link->cur_link_settings));
+	struct fixed31_32 timeslot_bw_effective =
+			dc_fixpt_div_int(link_bw_effective, MAX_MTP_SLOT_COUNT);
+	struct fixed31_32 timing_bw =
+			dc_fixpt_from_int(
+					dc_bandwidth_in_kbps_from_timing(&stream->timing));
+	struct fixed31_32 avg_time_slots_per_mtp =
+			dc_fixpt_div(timing_bw, timeslot_bw_effective);
+
+	return avg_time_slots_per_mtp;
+}
+
+bool is_dp_128b_132b_signal(struct pipe_ctx *pipe_ctx)
+{
+	return (pipe_ctx->stream_res.hpo_dp_stream_enc &&
+			pipe_ctx->stream->link->hpo_dp_link_enc &&
+			dc_is_dp_signal(pipe_ctx->stream->signal));
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 9c51cd09dcf1..e77152ab57f9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -17,6 +17,7 @@
 #include "link_enc_cfg.h"
 #include "clk_mgr.h"
 #include "inc/link_dpcd.h"
+#include "dccg.h"
 
 static uint8_t convert_to_count(uint8_t lttpr_repeater_count)
 {
@@ -111,22 +112,30 @@ void dp_enable_link_phy(
 
 	link->cur_link_settings = *link_settings;
 
-	if (dc->clk_mgr->funcs->notify_link_rate_change)
-		dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
+	if (dp_get_link_encoding_format(link_settings) == DP_128b_132b_ENCODING) {
+		/* TODO - DP2.0 HW: notify link rate change here */
+	} else if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING) {
+		if (dc->clk_mgr->funcs->notify_link_rate_change)
+			dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
+	}
 
 	if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->lock_phy(dmcu);
 
-	if (dc_is_dp_sst_signal(signal)) {
-		link_enc->funcs->enable_dp_output(
-						link_enc,
-						link_settings,
-						clock_source);
-	} else {
-		link_enc->funcs->enable_dp_mst_output(
-						link_enc,
-						link_settings,
-						clock_source);
+	if (dp_get_link_encoding_format(link_settings) == DP_128b_132b_ENCODING) {
+		enable_dp_hpo_output(link, link_settings);
+	} else if (dp_get_link_encoding_format(link_settings) == DP_8b_10b_ENCODING) {
+		if (dc_is_dp_sst_signal(signal)) {
+			link_enc->funcs->enable_dp_output(
+							link_enc,
+							link_settings,
+							clock_source);
+		} else {
+			link_enc->funcs->enable_dp_mst_output(
+							link_enc,
+							link_settings,
+							clock_source);
+		}
 	}
 
 	if (dmcu != NULL && dmcu->funcs->unlock_phy)
@@ -206,6 +215,7 @@ void dp_disable_link_phy(struct dc_link *link, enum signal_type signal)
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
+	struct hpo_dp_link_encoder *hpo_link_enc = link->hpo_dp_link_enc;
 	struct link_encoder *link_enc;
 
 	/* Link should always be assigned encoder when en-/disabling. */
@@ -221,13 +231,21 @@ void dp_disable_link_phy(struct dc_link *link, enum signal_type signal)
 	if (signal == SIGNAL_TYPE_EDP) {
 		if (link->dc->hwss.edp_backlight_control)
 			link->dc->hwss.edp_backlight_control(link, false);
-		link_enc->funcs->disable_output(link_enc, signal);
+		if (dp_get_link_encoding_format(&link->cur_link_settings) == DP_128b_132b_ENCODING)
+			disable_dp_hpo_output(link, signal);
+		else
+			link_enc->funcs->disable_output(link_enc, signal);
+
 		link->dc->hwss.edp_power_control(link, false);
 	} else {
 		if (dmcu != NULL && dmcu->funcs->lock_phy)
 			dmcu->funcs->lock_phy(dmcu);
 
-		link_enc->funcs->disable_output(link_enc, signal);
+		if (dp_get_link_encoding_format(&link->cur_link_settings) == DP_128b_132b_ENCODING &&
+				hpo_link_enc)
+			disable_dp_hpo_output(link, signal);
+		else
+			link_enc->funcs->disable_output(link_enc, signal);
 
 		if (dmcu != NULL && dmcu->funcs->unlock_phy)
 			dmcu->funcs->unlock_phy(dmcu);
@@ -273,6 +291,12 @@ bool dp_set_hw_training_pattern(
 	case DP_TRAINING_PATTERN_SEQUENCE_4:
 		test_pattern = DP_TEST_PATTERN_TRAINING_PATTERN4;
 		break;
+	case DP_128b_132b_TPS1:
+		test_pattern = DP_TEST_PATTERN_128b_132b_TPS1_TRAINING_MODE;
+		break;
+	case DP_128b_132b_TPS2:
+		test_pattern = DP_TEST_PATTERN_128b_132b_TPS2_TRAINING_MODE;
+		break;
 	default:
 		break;
 	}
@@ -282,6 +306,8 @@ bool dp_set_hw_training_pattern(
 	return true;
 }
 
+#define DC_LOGGER \
+	link->ctx->logger
 void dp_set_hw_lane_settings(
 	struct dc_link *link,
 	const struct link_training_settings *link_settings,
@@ -293,7 +319,16 @@ void dp_set_hw_lane_settings(
 		return;
 
 	/* call Encoder to set lane settings */
-	encoder->funcs->dp_set_lane_settings(encoder, link_settings);
+	if (dp_get_link_encoding_format(&link_settings->link_settings) ==
+			DP_128b_132b_ENCODING) {
+		link->hpo_dp_link_enc->funcs->set_ffe(
+				link->hpo_dp_link_enc,
+				&link_settings->link_settings,
+				link_settings->lane_settings[0].FFE_PRESET.raw);
+	} else if (dp_get_link_encoding_format(&link_settings->link_settings)
+			== DP_8b_10b_ENCODING) {
+		encoder->funcs->dp_set_lane_settings(encoder, link_settings);
+	}
 }
 
 void dp_set_hw_test_pattern(
@@ -319,8 +354,22 @@ void dp_set_hw_test_pattern(
 	pattern_param.custom_pattern_size = custom_pattern_size;
 	pattern_param.dp_panel_mode = dp_get_panel_mode(link);
 
-	encoder->funcs->dp_set_phy_pattern(encoder, &pattern_param);
+	enum dp_link_encoding link_encoding_format = dp_get_link_encoding_format(&link->cur_link_settings);
+	switch (link_encoding_format) {
+	case DP_128b_132b_ENCODING:
+		link->hpo_dp_link_enc->funcs->set_link_test_pattern(
+				link->hpo_dp_link_enc, &pattern_param);
+		break;
+	case DP_8b_10b_ENCODING:
+		ASSERT(encoder);
+		encoder->funcs->dp_set_phy_pattern(encoder, &pattern_param);
+		break;
+	default:
+		DC_LOG_ERROR("%s: Unknown link encoding format.", __func__);
+		break;
+	}
 }
+#undef DC_LOGGER
 
 void dp_retrain_link_dp_test(struct dc_link *link,
 			struct dc_link_settings *link_setting,
@@ -468,7 +517,8 @@ void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		optc_dsc_mode = dsc_optc_cfg.is_pixel_format_444 ? OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
 
 		/* Enable DSC in encoder */
-		if (dc_is_dp_signal(stream->signal) && !IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
+		if (dc_is_dp_signal(stream->signal) && !IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)
+				&& !is_dp_128b_132b_signal(pipe_ctx)) {
 			DC_LOG_DSC("Setting stream encoder DSC config for engine %d:", (int)pipe_ctx->stream_res.stream_enc->id);
 			dsc_optc_config_log(dsc, &dsc_optc_cfg);
 			pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(pipe_ctx->stream_res.stream_enc,
@@ -495,13 +545,19 @@ void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		/* disable DSC in stream encoder */
 		if (dc_is_dp_signal(stream->signal)) {
 
-			if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(
-						pipe_ctx->stream_res.stream_enc,
-						OPTC_DSC_DISABLED, 0, 0);
-				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
-							pipe_ctx->stream_res.stream_enc, false, NULL);
-			}
+			if (is_dp_128b_132b_signal(pipe_ctx))
+				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
+										pipe_ctx->stream_res.hpo_dp_stream_enc,
+										false,
+										NULL);
+			else
+				if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
+					pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(
+							pipe_ctx->stream_res.stream_enc,
+							OPTC_DSC_DISABLED, 0, 0);
+					pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
+								pipe_ctx->stream_res.stream_enc, false, NULL);
+				}
 		}
 
 		/* disable DSC block */
@@ -562,16 +618,28 @@ bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable)
 		dsc->funcs->dsc_get_packed_pps(dsc, &dsc_cfg, &dsc_packed_pps[0]);
 		if (dc_is_dp_signal(stream->signal)) {
 			DC_LOG_DSC("Setting stream encoder DSC PPS SDP for engine %d\n", (int)pipe_ctx->stream_res.stream_enc->id);
-			pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
-									pipe_ctx->stream_res.stream_enc,
-									true,
-									&dsc_packed_pps[0]);
+			if (is_dp_128b_132b_signal(pipe_ctx))
+				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
+										pipe_ctx->stream_res.hpo_dp_stream_enc,
+										true,
+										&dsc_packed_pps[0]);
+			else
+				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
+										pipe_ctx->stream_res.stream_enc,
+										true,
+										&dsc_packed_pps[0]);
 		}
 	} else {
 		/* disable DSC PPS in stream encoder */
 		if (dc_is_dp_signal(stream->signal)) {
-			pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
-						pipe_ctx->stream_res.stream_enc, false, NULL);
+			if (is_dp_128b_132b_signal(pipe_ctx))
+				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
+										pipe_ctx->stream_res.hpo_dp_stream_enc,
+										false,
+										NULL);
+			else
+				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
+							pipe_ctx->stream_res.stream_enc, false, NULL);
 		}
 	}
 
@@ -593,3 +661,166 @@ bool dp_update_dsc_config(struct pipe_ctx *pipe_ctx)
 	return true;
 }
 
+#undef DC_LOGGER
+#define DC_LOGGER \
+	link->ctx->logger
+
+static enum phyd32clk_clock_source get_phyd32clk_src(struct dc_link *link)
+{
+	switch (link->link_enc->transmitter) {
+	case TRANSMITTER_UNIPHY_A:
+		return PHYD32CLKA;
+	case TRANSMITTER_UNIPHY_B:
+		return PHYD32CLKB;
+	case TRANSMITTER_UNIPHY_C:
+		return PHYD32CLKC;
+	case TRANSMITTER_UNIPHY_D:
+		return PHYD32CLKD;
+	case TRANSMITTER_UNIPHY_E:
+		return PHYD32CLKE;
+	}
+
+	//BREAK_TO_DEBUGGER();
+	return TRANSMITTER_UNIPHY_A;
+}
+
+void enable_dp_hpo_output(struct dc_link *link, const struct dc_link_settings *link_settings)
+{
+	const struct dc *dc = link->dc;
+	enum phyd32clk_clock_source phyd32clk;
+
+	/* Enable PHY PLL at target bit rate
+	 *   UHBR10 = 10Gbps (SYMCLK32 = 312.5MHz)
+	 *   UBR13.5 = 13.5Gbps (SYMCLK32 = 421.875MHz)
+	 *   UHBR20 = 20Gbps (SYMCLK32 = 625MHz)
+	 */
+	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
+		switch (link_settings->link_rate) {
+		case LINK_RATE_UHBR10:
+			dm_set_phyd32clk(dc->ctx, 312500);
+			break;
+		case LINK_RATE_UHBR13_5:
+			dm_set_phyd32clk(dc->ctx, 412875);
+			break;
+		case LINK_RATE_UHBR20:
+			dm_set_phyd32clk(dc->ctx, 625000);
+			break;
+		default:
+			return;
+		}
+	} else {
+		/* DP2.0 HW: call transmitter control to enable PHY */
+		link->hpo_dp_link_enc->funcs->enable_link_phy(
+				link->hpo_dp_link_enc,
+				link_settings,
+				link->link_enc->transmitter);
+	}
+
+	/* DCCG muxing and DTBCLK DTO */
+	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
+		dc->res_pool->dccg->funcs->set_physymclk(
+				dc->res_pool->dccg,
+				link->link_enc_hw_inst,
+				PHYSYMCLK_FORCE_SRC_PHYD32CLK,
+				true);
+
+		phyd32clk = get_phyd32clk_src(link);
+		dc->res_pool->dccg->funcs->enable_symclk32_le(
+				dc->res_pool->dccg,
+				link->hpo_dp_link_enc->inst,
+				phyd32clk);
+		link->hpo_dp_link_enc->funcs->link_enable(
+					link->hpo_dp_link_enc,
+					link_settings->lane_count);
+	}
+}
+
+void disable_dp_hpo_output(struct dc_link *link, enum signal_type signal)
+{
+	const struct dc *dc = link->dc;
+
+	link->hpo_dp_link_enc->funcs->link_disable(link->hpo_dp_link_enc);
+
+	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
+		dc->res_pool->dccg->funcs->disable_symclk32_le(
+					dc->res_pool->dccg,
+					link->hpo_dp_link_enc->inst);
+
+		dc->res_pool->dccg->funcs->set_physymclk(
+					dc->res_pool->dccg,
+					link->link_enc_hw_inst,
+					PHYSYMCLK_FORCE_SRC_SYMCLK,
+					false);
+
+		dm_set_phyd32clk(dc->ctx, 0);
+	} else {
+		/* DP2.0 HW: call transmitter control to disable PHY */
+		link->hpo_dp_link_enc->funcs->disable_link_phy(
+				link->hpo_dp_link_enc,
+				signal);
+	}
+}
+
+void setup_dp_hpo_stream(struct pipe_ctx *pipe_ctx, bool enable)
+{
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	struct pipe_ctx *odm_pipe;
+	int odm_combine_num_segments = 1;
+	enum phyd32clk_clock_source phyd32clk;
+
+	if (enable) {
+		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+				odm_combine_num_segments++;
+
+		dc->res_pool->dccg->funcs->set_dpstreamclk(
+				dc->res_pool->dccg,
+				DTBCLK0,
+				pipe_ctx->stream_res.tg->inst);
+
+		phyd32clk = get_phyd32clk_src(stream->link);
+		dc->res_pool->dccg->funcs->enable_symclk32_se(
+				dc->res_pool->dccg,
+				pipe_ctx->stream_res.hpo_dp_stream_enc->inst,
+				phyd32clk);
+
+		dc->res_pool->dccg->funcs->set_dtbclk_dto(
+				dc->res_pool->dccg,
+				pipe_ctx->stream_res.tg->inst,
+				stream->phy_pix_clk,
+				odm_combine_num_segments,
+				&stream->timing);
+	} else {
+		dc->res_pool->dccg->funcs->set_dtbclk_dto(
+				dc->res_pool->dccg,
+				pipe_ctx->stream_res.tg->inst,
+				0,
+				0,
+				&stream->timing);
+		dc->res_pool->dccg->funcs->disable_symclk32_se(
+				dc->res_pool->dccg,
+				pipe_ctx->stream_res.hpo_dp_stream_enc->inst);
+		dc->res_pool->dccg->funcs->set_dpstreamclk(
+				dc->res_pool->dccg,
+				REFCLK,
+				pipe_ctx->stream_res.tg->inst);
+	}
+}
+
+void reset_dp_hpo_stream_encoders_for_link(struct dc_link *link)
+{
+	const struct dc *dc = link->dc;
+	struct dc_state *state = dc->current_state;
+	uint8_t i;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (state->res_ctx.pipe_ctx[i].stream_res.hpo_dp_stream_enc &&
+				state->res_ctx.pipe_ctx[i].stream &&
+				state->res_ctx.pipe_ctx[i].stream->link == link &&
+				!state->res_ctx.pipe_ctx[i].stream->dpms_off) {
+			setup_dp_hpo_stream(&state->res_ctx.pipe_ctx[i], false);
+		}
+	}
+}
+
+#undef DC_LOGGER
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index a60396d5be44..7bb5b506e36d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -41,6 +41,7 @@
 #include "set_mode_types.h"
 #include "virtual/virtual_stream_encoder.h"
 #include "dpcd_defs.h"
+#include "dc_link_dp.h"
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
 #include "dce60/dce60_resource.h"
@@ -346,6 +347,27 @@ bool resource_construct(
 		}
 	}
 
+	pool->hpo_dp_stream_enc_count = 0;
+	if (create_funcs->create_hpo_dp_stream_encoder) {
+		for (i = 0; i < caps->num_hpo_dp_stream_encoder; i++) {
+			pool->hpo_dp_stream_enc[i] = create_funcs->create_hpo_dp_stream_encoder(i+ENGINE_ID_HPO_DP_0, ctx);
+			if (pool->hpo_dp_stream_enc[i] == NULL)
+				DC_ERR("DC: failed to create HPO DP stream encoder!\n");
+			pool->hpo_dp_stream_enc_count++;
+
+		}
+	}
+
+	pool->hpo_dp_link_enc_count = 0;
+	if (create_funcs->create_hpo_dp_link_encoder) {
+		for (i = 0; i < caps->num_hpo_dp_link_encoder; i++) {
+			pool->hpo_dp_link_enc[i] = create_funcs->create_hpo_dp_link_encoder(i, ctx);
+			if (pool->hpo_dp_link_enc[i] == NULL)
+				DC_ERR("DC: failed to create HPO DP link encoder!\n");
+			pool->hpo_dp_link_enc_count++;
+		}
+	}
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	for (i = 0; i < caps->num_mpc_3dlut; i++) {
 		pool->mpc_lut[i] = dc_create_3dlut_func();
@@ -1665,6 +1687,20 @@ static void update_stream_engine_usage(
 	}
 }
 
+static void update_hpo_dp_stream_engine_usage(
+		struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		struct hpo_dp_stream_encoder *hpo_dp_stream_enc,
+		bool acquired)
+{
+	int i;
+
+	for (i = 0; i < pool->hpo_dp_stream_enc_count; i++) {
+		if (pool->hpo_dp_stream_enc[i] == hpo_dp_stream_enc)
+			res_ctx->is_hpo_dp_stream_enc_acquired[i] = acquired;
+	}
+}
+
 /* TODO: release audio object */
 void update_audio_usage(
 		struct resource_context *res_ctx,
@@ -1709,6 +1745,24 @@ static int acquire_first_free_pipe(
 	return -1;
 }
 
+static struct hpo_dp_stream_encoder *find_first_free_match_hpo_dp_stream_enc_for_link(
+		struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		struct dc_stream_state *stream)
+{
+	int i;
+
+	for (i = 0; i < pool->hpo_dp_stream_enc_count; i++) {
+		if (!res_ctx->is_hpo_dp_stream_enc_acquired[i] &&
+				pool->hpo_dp_stream_enc[i]) {
+
+			return pool->hpo_dp_stream_enc[i];
+		}
+	}
+
+	return NULL;
+}
+
 static struct audio *find_first_free_audio(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
@@ -1799,6 +1853,13 @@ enum dc_status dc_remove_stream_from_ctx(
 	if (dc->res_pool->funcs->link_enc_unassign)
 		dc->res_pool->funcs->link_enc_unassign(new_ctx, del_pipe->stream);
 
+	if (is_dp_128b_132b_signal(del_pipe)) {
+		update_hpo_dp_stream_engine_usage(
+			&new_ctx->res_ctx, dc->res_pool,
+			del_pipe->stream_res.hpo_dp_stream_enc,
+			false);
+	}
+
 	if (del_pipe->stream_res.audio)
 		update_audio_usage(
 			&new_ctx->res_ctx,
@@ -2051,6 +2112,29 @@ enum dc_status resource_map_pool_resources(
 		pipe_ctx->stream_res.stream_enc,
 		true);
 
+	/* Allocate DP HPO Stream Encoder based on signal, hw capabilities
+	 * and link settings
+	 */
+	if (dc_is_dp_signal(stream->signal) &&
+			dc->caps.dp_hpo) {
+		struct dc_link_settings link_settings = {0};
+
+		decide_link_settings(stream, &link_settings);
+		if (dp_get_link_encoding_format(&link_settings) == DP_128b_132b_ENCODING) {
+			pipe_ctx->stream_res.hpo_dp_stream_enc =
+					find_first_free_match_hpo_dp_stream_enc_for_link(
+							&context->res_ctx, pool, stream);
+
+			if (!pipe_ctx->stream_res.hpo_dp_stream_enc)
+				return DC_NO_STREAM_ENC_RESOURCE;
+
+			update_hpo_dp_stream_engine_usage(
+					&context->res_ctx, pool,
+					pipe_ctx->stream_res.hpo_dp_stream_enc,
+					true);
+		}
+	}
+
 	/* TODO: Add check if ASIC support and EDID audio */
 	if (!stream->converter_disable_audio &&
 	    dc_is_audio_capable_signal(pipe_ctx->stream->signal) &&
@@ -2726,6 +2810,9 @@ bool pipe_need_reprogram(
 	if (pipe_ctx_old->stream_res.dsc != pipe_ctx->stream_res.dsc)
 		return true;
 
+	if (pipe_ctx_old->stream_res.hpo_dp_stream_enc != pipe_ctx->stream_res.hpo_dp_stream_enc)
+		return true;
+
 	/* DIG link encoder resource assignment for stream changed. */
 	if (pipe_ctx_old->stream->link_enc != pipe_ctx->stream->link_enc)
 		return true;
@@ -2975,3 +3062,20 @@ void get_audio_check(struct audio_info *aud_modes,
 	}
 }
 
+struct hpo_dp_link_encoder *resource_get_unused_hpo_dp_link_encoder(
+		const struct resource_pool *pool)
+{
+	uint8_t i;
+	struct hpo_dp_link_encoder *enc = NULL;
+
+	ASSERT(pool->hpo_dp_link_enc_count <= MAX_HPO_DP2_LINK_ENCODERS);
+
+	for (i = 0; i < pool->hpo_dp_link_enc_count; i++) {
+		if (pool->hpo_dp_link_enc[i]->transmitter == TRANSMITTER_UNKNOWN) {
+			enc = pool->hpo_dp_link_enc[i];
+			break;
+		}
+	}
+
+	return enc;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 03b81e5c5d67..abcf27c046e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -183,6 +183,7 @@ struct dc_caps {
 	unsigned int cursor_cache_size;
 	struct dc_plane_cap planes[MAX_PLANES];
 	struct dc_color_caps color;
+	bool dp_hpo;
 	bool vbios_lttpr_aware;
 	bool vbios_lttpr_enable;
 };
@@ -289,7 +290,13 @@ struct dc_cap_funcs {
 
 struct link_training_settings;
 
-
+union allow_lttpr_non_transparent_mode {
+	struct {
+		bool DP1_4A : 1;
+		bool DP2_0 : 1;
+	} bits;
+	unsigned char raw;
+};
 /* Structure to hold configuration flags set by dm at dc creation. */
 struct dc_config {
 	bool gpu_vm_support;
@@ -302,7 +309,7 @@ struct dc_config {
 	bool edp_no_power_sequencing;
 	bool force_enum_edp;
 	bool forced_clocks;
-	bool allow_lttpr_non_transparent_mode;
+	union allow_lttpr_non_transparent_mode allow_lttpr_non_transparent_mode;
 	bool multi_mon_pp_mclk_switch;
 	bool disable_dmcu;
 	bool enable_4to1MPC;
@@ -614,6 +621,8 @@ struct dc_debug_options {
 	bool enable_dmcub_surface_flip;
 	bool usbc_combo_phy_reset_wa;
 	bool enable_dram_clock_change_one_display_vactive;
+	/* TODO - remove once tested */
+	bool legacy_dp2_lt;
 	union mem_low_power_enable_options enable_mem_low_power;
 	bool force_vblank_alignment;
 
@@ -1146,6 +1155,10 @@ struct dpcd_caps {
 	struct dc_lttpr_caps lttpr_caps;
 	struct psr_caps psr_caps;
 
+	union dp_128b_132b_supported_link_rates dp_128b_132b_supported_link_rates;
+	union dp_main_line_channel_coding_cap channel_coding_cap;
+	union dp_sink_video_fallback_formats fallback_formats;
+	union dp_fec_capability1 fec_cap1;
 };
 
 union dpcd_sink_ext_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 4f54bde1bb1c..43f2ee2cd931 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -53,7 +53,13 @@ enum dc_link_rate {
 	LINK_RATE_RBR2 = 0x0C,		// Rate_5 (RBR2)- 3.24 Gbps/Lane
 	LINK_RATE_RATE_6 = 0x10,	// Rate_6		- 4.32 Gbps/Lane
 	LINK_RATE_HIGH2 = 0x14,		// Rate_7 (HBR2)- 5.40 Gbps/Lane
-	LINK_RATE_HIGH3 = 0x1E		// Rate_8 (HBR3)- 8.10 Gbps/Lane
+	LINK_RATE_HIGH3 = 0x1E,		// Rate_8 (HBR3)- 8.10 Gbps/Lane
+	/* Starting from DP2.0 link rate enum directly represents actual
+	 * link rate value in unit of 10 mbps
+	 */
+	LINK_RATE_UHBR10 = 1000,	// UHBR10 - 10.0 Gbps/Lane
+	LINK_RATE_UHBR13_5 = 1350,	// UHBR13.5 - 13.5 Gbps/Lane
+	LINK_RATE_UHBR20 = 2000,	// UHBR10 - 20.0 Gbps/Lane
 };
 
 enum dc_link_spread {
@@ -90,17 +96,41 @@ enum dc_post_cursor2 {
 	POST_CURSOR2_MAX_LEVEL = POST_CURSOR2_LEVEL3,
 };
 
+enum dc_dp_ffe_preset_level {
+	DP_FFE_PRESET_LEVEL0 = 0,
+	DP_FFE_PRESET_LEVEL1,
+	DP_FFE_PRESET_LEVEL2,
+	DP_FFE_PRESET_LEVEL3,
+	DP_FFE_PRESET_LEVEL4,
+	DP_FFE_PRESET_LEVEL5,
+	DP_FFE_PRESET_LEVEL6,
+	DP_FFE_PRESET_LEVEL7,
+	DP_FFE_PRESET_LEVEL8,
+	DP_FFE_PRESET_LEVEL9,
+	DP_FFE_PRESET_LEVEL10,
+	DP_FFE_PRESET_LEVEL11,
+	DP_FFE_PRESET_LEVEL12,
+	DP_FFE_PRESET_LEVEL13,
+	DP_FFE_PRESET_LEVEL14,
+	DP_FFE_PRESET_LEVEL15,
+	DP_FFE_PRESET_MAX_LEVEL = DP_FFE_PRESET_LEVEL15,
+};
+
 enum dc_dp_training_pattern {
 	DP_TRAINING_PATTERN_SEQUENCE_1 = 0,
 	DP_TRAINING_PATTERN_SEQUENCE_2,
 	DP_TRAINING_PATTERN_SEQUENCE_3,
 	DP_TRAINING_PATTERN_SEQUENCE_4,
 	DP_TRAINING_PATTERN_VIDEOIDLE,
+	DP_128b_132b_TPS1,
+	DP_128b_132b_TPS2,
+	DP_128b_132b_TPS2_CDS,
 };
 
 enum dp_link_encoding {
 	DP_UNKNOWN_ENCODING = 0,
 	DP_8b_10b_ENCODING = 1,
+	DP_128b_132b_ENCODING = 2,
 };
 
 struct dc_link_settings {
@@ -112,10 +142,22 @@ struct dc_link_settings {
 	bool dpcd_source_device_specific_field_support;
 };
 
+union dc_dp_ffe_preset {
+	struct {
+		uint8_t level		: 4;
+		uint8_t reserved	: 1;
+		uint8_t no_preshoot	: 1;
+		uint8_t no_deemphasis	: 1;
+		uint8_t method2		: 1;
+	} settings;
+	uint8_t raw;
+};
+
 struct dc_lane_settings {
 	enum dc_voltage_swing VOLTAGE_SWING;
 	enum dc_pre_emphasis PRE_EMPHASIS;
 	enum dc_post_cursor2 POST_CURSOR2;
+	union dc_dp_ffe_preset FFE_PRESET;
 };
 
 struct dc_link_training_settings {
@@ -127,6 +169,7 @@ struct dc_link_training_overrides {
 	enum dc_voltage_swing *voltage_swing;
 	enum dc_pre_emphasis *pre_emphasis;
 	enum dc_post_cursor2 *post_cursor2;
+	union dc_dp_ffe_preset *ffe_preset;
 
 	uint16_t *cr_pattern_time;
 	uint16_t *eq_pattern_time;
@@ -140,6 +183,14 @@ struct dc_link_training_overrides {
 	bool *fec_enable;
 };
 
+union payload_table_update_status {
+	struct {
+		uint8_t  VC_PAYLOAD_TABLE_UPDATED:1;
+		uint8_t  ACT_HANDLED:1;
+	} bits;
+	uint8_t  raw;
+};
+
 union dpcd_rev {
 	struct {
 		uint8_t MINOR:4;
@@ -227,7 +278,10 @@ union lane_align_status_updated {
 	struct {
 		uint8_t INTERLANE_ALIGN_DONE:1;
 		uint8_t POST_LT_ADJ_REQ_IN_PROGRESS:1;
-		uint8_t RESERVED:4;
+		uint8_t EQ_INTERLANE_ALIGN_DONE_128b_132b:1;
+		uint8_t CDS_INTERLANE_ALIGN_DONE_128b_132b:1;
+		uint8_t LT_FAILED_128b_132b:1;
+		uint8_t RESERVED:1;
 		uint8_t DOWNSTREAM_PORT_STATUS_CHANGED:1;
 		uint8_t LINK_STATUS_UPDATED:1;
 	} bits;
@@ -240,6 +294,10 @@ union lane_adjust {
 		uint8_t PRE_EMPHASIS_LANE:2;
 		uint8_t RESERVED:4;
 	} bits;
+	struct {
+		uint8_t PRESET_VALUE	:4;
+		uint8_t RESERVED	:4;
+	} tx_ffe;
 	uint8_t raw;
 };
 
@@ -269,6 +327,10 @@ union dpcd_training_lane {
 		uint8_t MAX_PRE_EMPHASIS_REACHED:1;
 		uint8_t RESERVED:2;
 	} bits;
+	struct {
+		uint8_t PRESET_VALUE	:4;
+		uint8_t RESERVED	:4;
+	} tx_ffe;
 	uint8_t raw;
 };
 
@@ -551,12 +613,9 @@ union test_response {
 
 union phy_test_pattern {
 	struct {
-		/* DpcdPhyTestPatterns. This field is 2 bits for DP1.1
-		 * and 3 bits for DP1.2.
-		 */
-		uint8_t PATTERN     :3;
-		/* BY speci, bit7:2 is 0 for DP1.1. */
-		uint8_t RESERVED    :5;
+		/* This field is 7 bits for DP2.0 */
+		uint8_t PATTERN     :7;
+		uint8_t RESERVED    :1;
 	} bits;
 	uint8_t raw;
 };
@@ -634,7 +693,10 @@ union dpcd_fec_capability {
 		uint8_t UNCORRECTED_BLOCK_ERROR_COUNT_CAPABLE:1;
 		uint8_t CORRECTED_BLOCK_ERROR_COUNT_CAPABLE:1;
 		uint8_t BIT_ERROR_COUNT_CAPABLE:1;
-		uint8_t RESERVED:4;
+		uint8_t PARITY_BLOCK_ERROR_COUNT_CAPABLE:1;
+		uint8_t ARITY_BIT_ERROR_COUNT_CAPABLE:1;
+		uint8_t FEC_RUNNING_INDICATOR_SUPPORTED:1;
+		uint8_t FEC_ERROR_REPORTING_POLICY_SUPPORTED:1;
 	} bits;
 	uint8_t raw;
 };
@@ -758,4 +820,123 @@ struct psr_caps {
 	bool psr_exit_link_training_required;
 };
 
+#define DP_MAIN_LINK_CHANNEL_CODING_CAP			0x006
+#define DP_SINK_VIDEO_FALLBACK_FORMATS			0x020
+#define DP_FEC_CAPABILITY_1				0x091
+#define DP_DFP_CAPABILITY_EXTENSION_SUPPORT		0x0A3
+#define DP_DSC_CONFIGURATION				0x161
+#define DP_PHY_SQUARE_PATTERN				0x249
+#define DP_128b_132b_SUPPORTED_LINK_RATES		0x2215
+#define DP_128b_132b_TRAINING_AUX_RD_INTERVAL		0x2216
+#define DP_TEST_264BIT_CUSTOM_PATTERN_7_0		0X2230
+#define DP_TEST_264BIT_CUSTOM_PATTERN_263_256		0X2250
+#define DP_DSC_SUPPORT_AND_DECODER_COUNT		0x2260
+#define DP_DSC_MAX_SLICE_COUNT_AND_AGGREGATION_0	0x2270
+# define DP_DSC_DECODER_0_MAXIMUM_SLICE_COUNT_MASK	(1 << 0)
+# define DP_DSC_DECODER_0_AGGREGATION_SUPPORT_MASK	(0b111 << 1)
+# define DP_DSC_DECODER_0_AGGREGATION_SUPPORT_SHIFT	1
+# define DP_DSC_DECODER_COUNT_MASK			(0b111 << 5)
+# define DP_DSC_DECODER_COUNT_SHIFT			5
+#define DP_MAIN_LINK_CHANNEL_CODING_SET			0x108
+#define DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER	0xF0006
+#define DP_PHY_REPEATER_128b_132b_RATES			0xF0007
+#define DP_128b_132b_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1	0xF0022
+#define DP_INTRA_HOP_AUX_REPLY_INDICATION		(1 << 3)
+/* TODO - Use DRM header to replace above once available */
+
+union dp_main_line_channel_coding_cap {
+	struct {
+		uint8_t DP_8b_10b_SUPPORTED	:1;
+		uint8_t DP_128b_132b_SUPPORTED	:1;
+		uint8_t RESERVED		:6;
+	} bits;
+	uint8_t raw;
+};
+
+union dp_main_link_channel_coding_lttpr_cap {
+	struct {
+		uint8_t DP_128b_132b_SUPPORTED	:1;
+		uint8_t RESERVED		:7;
+	} bits;
+	uint8_t raw;
+};
+
+union dp_128b_132b_supported_link_rates {
+	struct {
+		uint8_t UHBR10	:1;
+		uint8_t UHBR20	:1;
+		uint8_t UHBR13_5:1;
+		uint8_t RESERVED:5;
+	} bits;
+	uint8_t raw;
+};
+
+union dp_128b_132b_supported_lttpr_link_rates {
+	struct {
+		uint8_t UHBR10	:1;
+		uint8_t UHBR13_5:1;
+		uint8_t UHBR20	:1;
+		uint8_t RESERVED:5;
+	} bits;
+	uint8_t raw;
+};
+
+union dp_sink_video_fallback_formats {
+	struct {
+		uint8_t dp_1024x768_60Hz_24bpp_support	:1;
+		uint8_t dp_1280x720_60Hz_24bpp_support	:1;
+		uint8_t dp_1920x1080_60Hz_24bpp_support	:1;
+		uint8_t RESERVED			:5;
+	} bits;
+	uint8_t raw;
+};
+
+union dp_fec_capability1 {
+	struct {
+		uint8_t AGGREGATED_ERROR_COUNTERS_CAPABLE	:1;
+		uint8_t RESERVED				:7;
+	} bits;
+	uint8_t raw;
+};
+
+struct dp_color_depth_caps {
+	uint8_t support_6bpc	:1;
+	uint8_t support_8bpc	:1;
+	uint8_t support_10bpc	:1;
+	uint8_t support_12bpc	:1;
+	uint8_t support_16bpc	:1;
+	uint8_t RESERVED	:3;
+};
+
+struct dp_encoding_format_caps {
+	uint8_t support_rgb	:1;
+	uint8_t support_ycbcr444:1;
+	uint8_t support_ycbcr422:1;
+	uint8_t support_ycbcr420:1;
+	uint8_t RESERVED	:4;
+};
+
+union dp_dfp_cap_ext {
+	struct {
+		uint8_t supported;
+		uint8_t max_pixel_rate_in_mps[2];
+		uint8_t max_video_h_active_width[2];
+		uint8_t max_video_v_active_height[2];
+		struct dp_encoding_format_caps encoding_format_caps;
+		struct dp_color_depth_caps rgb_color_depth_caps;
+		struct dp_color_depth_caps ycbcr444_color_depth_caps;
+		struct dp_color_depth_caps ycbcr422_color_depth_caps;
+		struct dp_color_depth_caps ycbcr420_color_depth_caps;
+	} fields;
+	uint8_t raw[12];
+};
+
+union dp_128b_132b_training_aux_rd_interval {
+	struct {
+		uint8_t VALUE	:7;
+		uint8_t UNIT	:1;
+	} bits;
+	uint8_t raw;
+};
+
 #endif /* DC_DP_TYPES_H */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 0ed7085384f0..2970d352ebf1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -152,6 +152,7 @@ struct dc_link {
 
 	struct panel_cntl *panel_cntl;
 	struct link_encoder *link_enc;
+	struct hpo_dp_link_encoder *hpo_dp_link_enc;
 	struct graphics_object_id link_id;
 	/* Endpoint type distinguishes display endpoints which do not have entries
 	 * in the BIOS connector table from those that do. Helps when tracking link
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index c1532930169b..87f36b4b2564 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -395,9 +395,23 @@ struct dc_lttpr_caps {
 	uint8_t max_link_rate;
 	uint8_t phy_repeater_cnt;
 	uint8_t max_ext_timeout;
+	union dp_main_link_channel_coding_lttpr_cap main_link_channel_coding;
+	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
 	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
 };
 
+struct dc_dongle_dfp_cap_ext {
+	bool supported;
+	uint16_t max_pixel_rate_in_mps;
+	uint16_t max_video_h_active_width;
+	uint16_t max_video_v_active_height;
+	struct dp_encoding_format_caps encoding_format_caps;
+	struct dp_color_depth_caps rgb_color_depth_caps;
+	struct dp_color_depth_caps ycbcr444_color_depth_caps;
+	struct dp_color_depth_caps ycbcr422_color_depth_caps;
+	struct dp_color_depth_caps ycbcr420_color_depth_caps;
+};
+
 struct dc_dongle_caps {
 	/* dongle type (DP converter, CV smart dongle) */
 	enum display_dongle_type dongle_type;
@@ -411,6 +425,7 @@ struct dc_dongle_caps {
 	bool is_dp_hdmi_ycbcr420_converter;
 	uint32_t dp_hdmi_max_bpc;
 	uint32_t dp_hdmi_max_pixel_clk_in_khz;
+	struct dc_dongle_dfp_cap_ext dfp_cap_ext;
 };
 /* Scaling format */
 enum scaling_transformation {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 62d595ded866..8cfa954c393c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1108,7 +1108,11 @@ void dce110_enable_audio_stream(struct pipe_ctx *pipe_ctx)
 			clk_mgr->funcs->enable_pme_wa(clk_mgr);
 		/* un-mute audio */
 		/* TODO: audio should be per stream rather than per link */
-		pipe_ctx->stream_res.stream_enc->funcs->audio_mute_control(
+		if (is_dp_128b_132b_signal(pipe_ctx))
+			pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->audio_mute_control(
+					pipe_ctx->stream_res.hpo_dp_stream_enc, false);
+		else
+			pipe_ctx->stream_res.stream_enc->funcs->audio_mute_control(
 					pipe_ctx->stream_res.stream_enc, false);
 		if (pipe_ctx->stream_res.audio)
 			pipe_ctx->stream_res.audio->enabled = true;
@@ -1129,14 +1133,22 @@ void dce110_disable_audio_stream(struct pipe_ctx *pipe_ctx)
 	if (pipe_ctx->stream_res.audio && pipe_ctx->stream_res.audio->enabled == false)
 		return;
 
-	pipe_ctx->stream_res.stream_enc->funcs->audio_mute_control(
-			pipe_ctx->stream_res.stream_enc, true);
+	if (is_dp_128b_132b_signal(pipe_ctx))
+		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->audio_mute_control(
+				pipe_ctx->stream_res.hpo_dp_stream_enc, true);
+	else
+		pipe_ctx->stream_res.stream_enc->funcs->audio_mute_control(
+				pipe_ctx->stream_res.stream_enc, true);
 	if (pipe_ctx->stream_res.audio) {
 		pipe_ctx->stream_res.audio->enabled = false;
 
 		if (dc_is_dp_signal(pipe_ctx->stream->signal))
-			pipe_ctx->stream_res.stream_enc->funcs->dp_audio_disable(
-					pipe_ctx->stream_res.stream_enc);
+			if (is_dp_128b_132b_signal(pipe_ctx))
+				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_audio_disable(
+						pipe_ctx->stream_res.hpo_dp_stream_enc);
+			else
+				pipe_ctx->stream_res.stream_enc->funcs->dp_audio_disable(
+						pipe_ctx->stream_res.stream_enc);
 		else
 			pipe_ctx->stream_res.stream_enc->funcs->hdmi_audio_disable(
 					pipe_ctx->stream_res.stream_enc);
@@ -1166,16 +1178,26 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 			pipe_ctx->stream_res.stream_enc);
 	}
 
-	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+	if (is_dp_128b_132b_signal(pipe_ctx)) {
+		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->stop_dp_info_packets(
+					pipe_ctx->stream_res.hpo_dp_stream_enc);
+	} else if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		pipe_ctx->stream_res.stream_enc->funcs->stop_dp_info_packets(
 			pipe_ctx->stream_res.stream_enc);
 
 	dc->hwss.disable_audio_stream(pipe_ctx);
 
-	link->link_enc->funcs->connect_dig_be_to_fe(
-			link->link_enc,
-			pipe_ctx->stream_res.stream_enc->id,
-			false);
+	if (is_dp_128b_132b_signal(pipe_ctx)) {
+		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->disable(
+				pipe_ctx->stream_res.hpo_dp_stream_enc);
+		setup_dp_hpo_stream(pipe_ctx, false);
+	/* TODO - DP2.0 HW: unmap stream from link encoder here */
+	} else {
+		link->link_enc->funcs->connect_dig_be_to_fe(
+				link->link_enc,
+				pipe_ctx->stream_res.stream_enc->id,
+				false);
+	}
 
 }
 
@@ -1210,7 +1232,11 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
 	}
 
-	if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
+	if (is_dp_128b_132b_signal(pipe_ctx)) {
+		/* TODO - DP2.0 HW: Set ODM mode in dp hpo encoder here */
+		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_blank(
+				pipe_ctx->stream_res.hpo_dp_stream_enc);
+	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
 		pipe_ctx->stream_res.stream_enc->funcs->dp_blank(pipe_ctx->stream_res.stream_enc);
 
 		if (!dc_is_embedded_signal(pipe_ctx->stream->signal)) {
@@ -1451,10 +1477,16 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 		build_audio_output(context, pipe_ctx, &audio_output);
 
 		if (dc_is_dp_signal(pipe_ctx->stream->signal))
-			pipe_ctx->stream_res.stream_enc->funcs->dp_audio_setup(
-					pipe_ctx->stream_res.stream_enc,
-					pipe_ctx->stream_res.audio->inst,
-					&pipe_ctx->stream->audio_info);
+			if (is_dp_128b_132b_signal(pipe_ctx))
+				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_audio_setup(
+						pipe_ctx->stream_res.hpo_dp_stream_enc,
+						pipe_ctx->stream_res.audio->inst,
+						&pipe_ctx->stream->audio_info);
+			else
+				pipe_ctx->stream_res.stream_enc->funcs->dp_audio_setup(
+						pipe_ctx->stream_res.stream_enc,
+						pipe_ctx->stream_res.audio->inst,
+						&pipe_ctx->stream->audio_info);
 		else
 			pipe_ctx->stream_res.stream_enc->funcs->hdmi_audio_setup(
 					pipe_ctx->stream_res.stream_enc,
@@ -1469,10 +1501,16 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 				&pipe_ctx->stream->audio_info);
 	}
 
-	/*  */
-	/* Do not touch stream timing on seamless boot optimization. */
-	if (!pipe_ctx->stream->apply_seamless_boot_optimization)
-		hws->funcs.enable_stream_timing(pipe_ctx, context, dc);
+	/* DCN3.1 FPGA Workaround
+	 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
+	 * To do so, move calling function enable_stream_timing to only be done AFTER calling
+	 * function core_link_enable_stream
+	 */
+	if (!(hws->wa.dp_hpo_and_otg_sequence && is_dp_128b_132b_signal(pipe_ctx)))
+		/*  */
+		/* Do not touch stream timing on seamless boot optimization. */
+		if (!pipe_ctx->stream->apply_seamless_boot_optimization)
+			hws->funcs.enable_stream_timing(pipe_ctx, context, dc);
 
 	if (hws->funcs.setup_vupdate_interrupt)
 		hws->funcs.setup_vupdate_interrupt(dc, pipe_ctx);
@@ -1526,6 +1564,16 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 	if (!stream->dpms_off)
 		core_link_enable_stream(context, pipe_ctx);
 
+	/* DCN3.1 FPGA Workaround
+	 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
+	 * To do so, move calling function enable_stream_timing to only be done AFTER calling
+	 * function core_link_enable_stream
+	 */
+	if (hws->wa.dp_hpo_and_otg_sequence && is_dp_128b_132b_signal(pipe_ctx)) {
+		if (!pipe_ctx->stream->apply_seamless_boot_optimization)
+			hws->funcs.enable_stream_timing(pipe_ctx, context, dc);
+	}
+
 	pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->bottom_pipe != 0;
 
 	pipe_ctx->stream->link->psr_settings.psr_feature_enabled = false;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index e4701825b5a0..2dc4b4e4ba02 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -1460,5 +1460,14 @@ void dcn10_link_encoder_get_max_link_cap(struct link_encoder *enc,
 	if (enc->features.flags.bits.IS_HBR3_CAPABLE)
 		max_link_cap.link_rate = LINK_RATE_HIGH3;
 
+	if (enc->features.flags.bits.IS_UHBR10_CAPABLE)
+		max_link_cap.link_rate = LINK_RATE_UHBR10;
+
+	if (enc->features.flags.bits.IS_UHBR13_5_CAPABLE)
+		max_link_cap.link_rate = LINK_RATE_UHBR13_5;
+
+	if (enc->features.flags.bits.IS_UHBR20_CAPABLE)
+		max_link_cap.link_rate = LINK_RATE_UHBR20;
+
 	*link_settings = max_link_cap;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index a47ba1d45be9..b9276da87872 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2135,7 +2135,12 @@ void dcn20_unblank_stream(struct pipe_ctx *pipe_ctx,
 
 	params.link_settings.link_rate = link_settings->link_rate;
 
-	if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
+	if (is_dp_128b_132b_signal(pipe_ctx)) {
+		/* TODO - DP2.0 HW: Set ODM mode in dp hpo encoder here */
+		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_unblank(
+				pipe_ctx->stream_res.hpo_dp_stream_enc,
+				pipe_ctx->stream_res.tg->inst);
+	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
 		if (optc2_is_two_pixels_per_containter(&stream->timing) || params.opp_cnt > 1)
 			params.timing.pix_clk_100hz /= 2;
 		pipe_ctx->stream_res.stream_enc->funcs->dp_set_odm_combine(
@@ -2380,8 +2385,19 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	 * disconnect them during disable_stream
 	 * BY this, it is logic clean to separate stream and link
 	 */
-	link->link_enc->funcs->connect_dig_be_to_fe(link->link_enc,
-						    pipe_ctx->stream_res.stream_enc->id, true);
+	if (is_dp_128b_132b_signal(pipe_ctx)) {
+		setup_dp_hpo_stream(pipe_ctx, true);
+		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->enable_stream(
+				pipe_ctx->stream_res.hpo_dp_stream_enc);
+		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->map_stream_to_link(
+				pipe_ctx->stream_res.hpo_dp_stream_enc,
+				pipe_ctx->stream_res.hpo_dp_stream_enc->inst,
+				link->hpo_dp_link_enc->inst);
+	}
+
+	if (!is_dp_128b_132b_signal(pipe_ctx))
+		link->link_enc->funcs->connect_dig_be_to_fe(
+			link->link_enc, pipe_ctx->stream_res.stream_enc->id, true);
 
 	if (pipe_ctx->plane_state && pipe_ctx->plane_state->flip_immediate != 1) {
 		if (link->dc->hwss.program_dmdata_engine)
@@ -2406,7 +2422,9 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 
 	/* enable audio only within mode set */
 	if (pipe_ctx->stream_res.audio != NULL) {
-		if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		if (is_dp_128b_132b_signal(pipe_ctx))
+			pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_audio_enable(pipe_ctx->stream_res.hpo_dp_stream_enc);
+		else if (dc_is_dp_signal(pipe_ctx->stream->signal))
 			pipe_ctx->stream_res.stream_enc->funcs->dp_audio_enable(pipe_ctx->stream_res.stream_enc);
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index e3e01b17c164..0159700c148a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -63,6 +63,7 @@
 #include "dcn20_dccg.h"
 #include "dcn20_vmid.h"
 #include "dc_link_ddc.h"
+#include "dc_link_dp.h"
 #include "dce/dce_panel_cntl.h"
 
 #include "navi10_ip_offset.h"
@@ -1604,6 +1605,7 @@ static void get_pixel_clock_parameters(
 	pixel_clk_params->signal_type = pipe_ctx->stream->signal;
 	pixel_clk_params->controller_id = pipe_ctx->stream_res.tg->inst + 1;
 	/* TODO: un-hardcode*/
+	/* TODO - DP2.0 HW: calculate requested_sym_clk for UHBR rates */
 	pixel_clk_params->requested_sym_clk = LINK_RATE_LOW *
 		LINK_RATE_REF_FREQ_IN_KHZ;
 	pixel_clk_params->flags.ENABLE_SS = 0;
@@ -3044,6 +3046,8 @@ static bool is_dtbclk_required(struct dc *dc, struct dc_state *context)
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
+		if (is_dp_128b_132b_signal(&context->res_ctx.pipe_ctx[i]))
+			return true;
 	}
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index f264a32ebade..463e96f8f14c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -561,11 +561,6 @@ static const struct dcn10_link_enc_mask le_mask = {
 	DPCS_DCN31_MASK_SH_LIST(_MASK)
 };
 
-#define dpp_regs(id)\
-[id] = {\
-	DPP_REG_LIST_DCN30(id),\
-}
-
 #define hpo_dp_stream_encoder_reg_list(id)\
 [id] = {\
 	DCN3_1_HPO_DP_STREAM_ENC_REG_LIST(id)\
@@ -609,6 +604,11 @@ static const struct dcn31_hpo_dp_link_encoder_mask hpo_dp_le_mask = {
 	DCN3_1_HPO_DP_LINK_ENC_MASK_SH_LIST(_MASK)
 };
 
+#define dpp_regs(id)\
+[id] = {\
+	DPP_REG_LIST_DCN30(id),\
+}
+
 static const struct dcn3_dpp_registers dpp_regs[] = {
 	dpp_regs(0),
 	dpp_regs(1),
@@ -1449,6 +1449,13 @@ static struct dce_hwseq *dcn31_hwseq_create(
 		hws->regs = &hwseq_reg;
 		hws->shifts = &hwseq_shift;
 		hws->masks = &hwseq_mask;
+		/* DCN3.1 FPGA Workaround
+		 * Need to enable HPO DP Stream Encoder before setting OTG master enable.
+		 * To do so, move calling function enable_stream_timing to only be done AFTER calling
+		 * function core_link_enable_stream
+		 */
+		if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment))
+			hws->wa.dp_hpo_and_otg_sequence = true;
 	}
 	return hws;
 }
@@ -2102,6 +2109,7 @@ static bool dcn31_resource_construct(
 	dc->caps.max_slave_rgb_planes = 1;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
+	dc->caps.dp_hpo = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 	dc->caps.is_apu = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
index a9170b9f84d3..43f33e186088 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
@@ -37,6 +37,7 @@ struct cp_psp_stream_config {
 	uint8_t phy_idx;
 	uint8_t assr_enabled;
 	uint8_t mst_enabled;
+	uint8_t dp2_enabled;
 	void *dm_stream_ctx;
 	bool dpms_off;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 9ab854293ace..8de554fb98b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -160,6 +160,8 @@ void dm_set_dcn_clocks(
 		struct dc_context *ctx,
 		struct dc_clocks *clks);
 
+void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz);
+
 bool dm_helpers_dmub_outbox_interrupt_control(struct dc_context *ctx, bool enable);
 
 void dm_helpers_smu_timeout(struct dc_context *ctx, unsigned int msg_id, unsigned int param, unsigned int timeout_us);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index 01c3a31be191..3cc110e13213 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -30,6 +30,7 @@
 #define LINK_TRAINING_RETRY_DELAY 50 /* ms */
 #define LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD 3200 /*us*/
 #define LINK_AUX_DEFAULT_TIMEOUT_PERIOD 552 /*us*/
+#define MAX_MTP_SLOT_COUNT 64
 #define DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE 0x50
 #define TRAINING_AUX_RD_INTERVAL 100 //us
 
@@ -189,5 +190,26 @@ enum dc_status dpcd_configure_lttpr_mode(
 		struct link_training_settings *lt_settings);
 
 enum dp_link_encoding dp_get_link_encoding_format(const struct dc_link_settings *link_settings);
+bool dpcd_write_128b_132b_sst_payload_allocation_table(
+		const struct dc_stream_state *stream,
+		struct dc_link *link,
+		struct link_mst_stream_allocation_table *proposed_table,
+		bool allocate);
+
+enum dc_status dpcd_configure_channel_coding(
+		struct dc_link *link,
+		struct link_training_settings *lt_settings);
+
+bool dpcd_poll_for_allocation_change_trigger(struct dc_link *link);
+
+struct fixed31_32 calculate_sst_avg_time_slots_per_mtp(
+		const struct dc_stream_state *stream,
+		const struct dc_link *link);
+void enable_dp_hpo_output(struct dc_link *link, const struct dc_link_settings *link_settings);
+void disable_dp_hpo_output(struct dc_link *link, enum signal_type signal);
+void setup_dp_hpo_stream(struct pipe_ctx *pipe_ctx, bool enable);
+bool is_dp_128b_132b_signal(struct pipe_ctx *pipe_ctx);
+void reset_dp_hpo_stream_encoders_for_link(struct dc_link *link);
+
 bool dp_retrieve_lttpr_cap(struct dc_link *link);
 #endif /* __DC_LINK_DP_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index f7f7e4fff0c2..518a157d70be 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -41,6 +41,7 @@ struct dce_hwseq_wa {
 	bool DEGVIDCN10_254;
 	bool DEGVIDCN21;
 	bool disallow_self_refresh_during_multi_plane_transition;
+	bool dp_hpo_and_otg_sequence;
 };
 
 struct hwseq_wa_state {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index ceafcdb3c929..f2aa833edf98 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -196,4 +196,7 @@ int get_num_mpc_splits(struct pipe_ctx *pipe);
 
 int get_num_odm_splits(struct pipe_ctx *pipe);
 
+struct hpo_dp_link_encoder *resource_get_unused_hpo_dp_link_encoder(
+		const struct resource_pool *pool);
+
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index aec7389aff37..d04f56be5ff2 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -80,6 +80,15 @@ enum dpcd_phy_test_patterns {
 	PHY_TEST_PATTERN_CP2520_1,
 	PHY_TEST_PATTERN_CP2520_2,
 	PHY_TEST_PATTERN_CP2520_3, /* same as TPS4 */
+	PHY_TEST_PATTERN_128b_132b_TPS1 = 0x8,
+	PHY_TEST_PATTERN_128b_132b_TPS2 = 0x10,
+	PHY_TEST_PATTERN_PRBS9 = 0x18,
+	PHY_TEST_PATTERN_PRBS11 = 0x20,
+	PHY_TEST_PATTERN_PRBS15 = 0x28,
+	PHY_TEST_PATTERN_PRBS23 = 0x30,
+	PHY_TEST_PATTERN_PRBS31 = 0x38,
+	PHY_TEST_PATTERN_264BIT_CUSTOM = 0x40,
+	PHY_TEST_PATTERN_SQUARE_PULSE = 0x48,
 };
 
 enum dpcd_test_dyn_range {
@@ -135,7 +144,10 @@ enum dpcd_training_patterns {
 	DPCD_TRAINING_PATTERN_1,
 	DPCD_TRAINING_PATTERN_2,
 	DPCD_TRAINING_PATTERN_3,
-	DPCD_TRAINING_PATTERN_4 = 7
+	DPCD_TRAINING_PATTERN_4 = 7,
+	DPCD_128b_132b_TPS1 = 1,
+	DPCD_128b_132b_TPS2 = 2,
+	DPCD_128b_132b_TPS2_CDS = 3,
 };
 
 /* This enum is for use with PsrSinkPsrStatus.bits.sinkSelfRefreshStatus
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 3def204c6695..61474be923df 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -53,7 +53,11 @@ enum edp_revision {
 };
 
 enum {
-	LINK_RATE_REF_FREQ_IN_KHZ = 27000 /*27MHz*/
+	LINK_RATE_REF_FREQ_IN_KHZ = 27000, /*27MHz*/
+	BITS_PER_DP_BYTE = 10,
+	DATA_EFFICIENCY_8b_10b_x10000 = 8000, /* 80% data efficiency */
+	DATA_EFFICIENCY_8b_10b_FEC_EFFICIENCY_x100 = 97, /* 97% data efficiency when FEC is enabled */
+	DATA_EFFICIENCY_128b_132b_x10000 = 9646, /* 96.71% data efficiency x 99.75% downspread factor */
 };
 
 enum link_training_result {
@@ -70,6 +74,10 @@ enum link_training_result {
 	LINK_TRAINING_LINK_LOSS,
 	/* Abort link training (because sink unplugged) */
 	LINK_TRAINING_ABORT,
+	DP_128b_132b_LT_FAILED,
+	DP_128b_132b_MAX_LOOP_COUNT_REACHED,
+	DP_128b_132b_CHANNEL_EQ_DONE_TIMEOUT,
+	DP_128b_132b_CDS_DONE_TIMEOUT,
 };
 
 enum lttpr_mode {
@@ -86,11 +94,19 @@ struct link_training_settings {
 	enum dc_pre_emphasis *pre_emphasis;
 	enum dc_post_cursor2 *post_cursor2;
 	bool should_set_fec_ready;
+	/* TODO - factor lane_settings out because it changes during LT */
+	union dc_dp_ffe_preset *ffe_preset;
 
 	uint16_t cr_pattern_time;
 	uint16_t eq_pattern_time;
+	uint16_t cds_pattern_time;
 	enum dc_dp_training_pattern pattern_for_cr;
 	enum dc_dp_training_pattern pattern_for_eq;
+	enum dc_dp_training_pattern pattern_for_cds;
+
+	uint32_t eq_wait_time_limit;
+	uint8_t eq_loop_count_limit;
+	uint32_t cds_wait_time_limit;
 
 	bool enhanced_framing;
 	bool allow_invalid_msa_timing_param;
diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index 571fcf23cea9..f093b49c5e6e 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -72,6 +72,7 @@
 #define DC_LOG_DSC(...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define DC_LOG_SMU(...) pr_debug("[SMU_MSG]:"__VA_ARGS__)
 #define DC_LOG_DWB(...) DRM_DEBUG_KMS(__VA_ARGS__)
+#define DC_LOG_DP2(...) DRM_DEBUG_KMS(__VA_ARGS__)
 
 struct dal_logger;
 
@@ -123,6 +124,7 @@ enum dc_log_type {
 	LOG_MAX_HW_POINTS,
 	LOG_ALL_TF_CHANNELS,
 	LOG_SAMPLE_1DLUT,
+	LOG_DP2,
 	LOG_SECTION_TOTAL_COUNT
 };
 
-- 
2.25.1

