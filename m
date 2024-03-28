Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4741FCD1283
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F025112550;
	Thu, 28 Mar 2024 19:52:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZW7NNJ6B";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87CA3112339
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnHA/RLu7jeuyrp2LXGJMhOmCOWv8K71uPQDU1PaZtaXmjrrkm8u0nQUggdPWvjnnwL4eX7p4U0VrzZz9rQQ9DshGMgiPF7qje8L7Rj9G8KLhxQcQmDHZJeWOkhup4f5D2nZTl8doDN9UdnFZlbtu72xkhBl73nuG6qsRiTogXZt+0P6c7P6K4tntUkHjYZZCdmPdQkfLb41okwd65L6WNa9XnvkEKCO0Dp7phgfWfuun58tImsuJo3dcLbkEnt2XZq1oBnon+xJcsYEfhwWLKsVygzAydpt/TwRWgHUUjmECcHVUBNFWIgNKmGnM7nH+O6VQVUEYGOlAIlwiNDLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCvXFICcaw8I5wb6SVvTFm/RLM6iqp4vQ+l9rLx+rlY=;
 b=la5EVAEoEwxByVoG+FwsQL+LA+47CKx0nYVd7gu+ycBbowS46UnRFRld5kmU/diESe0YY+G5kPH/Ud9vZHx1kkWkZVDMngcdPnkhyYI4edSNAwoyJW2iZSBlPh7NMJCuHQLvI7PuGr31+4YRlirGO4bGUTa1yAfePiiN5cQxJDXNDiFtaKwz+TnjNpmslgV0HavqzF988WfVxVXkwA0xhOpTSjnh/YtTiryVhaIXGH3wbKGniFOWL5rzs4un0nQUOYOzh3D3VgH4xeC/rRW6LMq0a9tURQ2N2yfXSj1O3dAvkJ4A2+IcmXVoyw3qIrYCaK9nGshGEz7tde0mxBS2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCvXFICcaw8I5wb6SVvTFm/RLM6iqp4vQ+l9rLx+rlY=;
 b=ZW7NNJ6B92hRC+djyqBlTmyhKTxwZ+wmOXHfzGL+KY1HIM8UFK7o2S72MkwjhKvtg15Atbs0nqrs7HOzhJDsInbBs3LLV/LBaXKL3S6ZRdVKSGJsjAyYH/vYpoT0c49Sfhgrjy6ynSemPiKJO4qrgn4buUapZapkWBV21Cy6v6Q=
Received: from CH0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::32)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:52:02 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::d2) by CH0P220CA0016.outlook.office365.com
 (2603:10b6:610:ef::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:01 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:55 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 25/43] drm/amd/display: Fix compiler warnings on high compiler
 warning levels
Date: Thu, 28 Mar 2024 15:50:29 -0400
Message-ID: <20240328195047.2843715-26-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 955b9a84-ffa2-457b-e9d5-08dc4f60898a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NY/JeYburNXnKTFB7POcoGd2Lua/qXWb1oUNYhXVH4Qy4XmwnpoI9EYlfZ8XZJDHHSBvHP+P5y8vaSGnS3DHMNEEBColIDU96/s4mOpkLiA2JBef5pXIFJEjcR58jyL915b0jhDOQjrdK4U8AcVRTFrUAQR8RXDJcEZQ1GR2VGdc2A3PP22hJ+Q2//wZ5B49GQ9fnXCd6qFwG3OS2wfdomqVe3C4KhLQ7K1f9Viw6oCj6kxBMn/1aqRySg2602FjdiNtJsXVHMXD9+CUcdK4Ll137UibBX78ltA8wWjP6f9Qvxqsv7+BnHFX8iKg9aVcpt4ByHAy0CFl2dS3w1GXkBb5HmD3kFmGePCxMsnRemmu+u1WiZk8Y0QJmYuqI6mt5VYDaayOX+sWCUlD3zTbwSCC0m2yTLYf5u3gzvc/2CKC/dPnN+tPP1uFEMfWUeQFHyMePka3vNDK1wiCHnVHfAnIIVteBmByc1Pj71FTe/fcIJ+thCLiMH1OHDzS115sylHDDRV4NRx4B1nF9iX1i6wtkUWQGL41MCVDWNFz7zFC2bmNwgMDB5oQ1rtf/I4weeqHTmxWRkrhsoRJymJY1eTHa2OW9yJ4ToublGTBOCb2r/SO1Npvgc8PGe7ev6EA9gXFX/ohrW67KLfTx9Wrn6PV2wsCkgBopGIpAmdderWI/cLRUFg92HQ4Lg6uqfaZ/R/Id4yI9S6n3icFFoNAzy34YKR51BxwipiVSVjnQHo2WiQ1+NX2uuMA2w1EpQXr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:02.1398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 955b9a84-ffa2-457b-e9d5-08dc4f60898a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
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

From: Aric Cyr <aric.cyr@amd.com>

[why]
Enabling higher compiler warning levels results in many issues that can
be trivially resolved as well as some potentially critical issues.

[how]
Fix all compiler warnings found with various compilers and higher
warning levels.  Primarily, potentially uninitialized variables and
unreachable code.

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |  2 --
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |  3 ++-
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |  3 ++-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |  3 ++-
 .../amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |  3 ++-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |  2 +-
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.c  |  1 -
 .../amd/display/dc/dcn32/dcn32_resource_helpers.c  |  2 +-
 .../amd/display/dc/dcn35/dcn35_dio_link_encoder.c  |  1 -
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |  2 --
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |  1 -
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |  1 -
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c |  2 +-
 .../display/dc/dml/dcn314/display_mode_vba_314.c   |  1 -
 .../dc/dml/dcn32/display_mode_vba_util_32.c        | 14 ++++++--------
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   |  2 +-
 .../gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c |  2 +-
 .../drm/amd/display/dc/dml2/display_mode_core.c    | 12 +++++-------
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c   |  2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |  8 ++++----
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |  2 +-
 .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h |  2 +-
 .../amd/display/dc/link/accessories/link_dp_cts.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |  2 +-
 .../dc/link/protocols/link_dp_training_dpia.c      |  4 ++--
 .../display/dc/resource/dce112/dce112_resource.c   |  2 --
 .../display/dc/resource/dce120/dce120_resource.c   |  2 +-
 .../amd/display/dc/resource/dcn30/dcn30_resource.c |  2 +-
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |  2 +-
 .../display/dc/resource/dcn316/dcn316_resource.c   |  2 +-
 .../drm/amd/display/modules/color/color_gamma.c    |  2 +-
 .../drm/amd/display/modules/hdcp/hdcp2_execution.c |  2 +-
 35 files changed, 44 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 05f392501c0a..517c976dbc19 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1594,8 +1594,6 @@ static bool bios_parser_is_device_id_supported(
 		return (le16_to_cpu(bp->object_info_tbl.v1_5->supporteddevices) & mask) != 0;
 		break;
 	}
-
-	return false;
 }
 
 static uint32_t bios_parser_get_ss_entry_number(
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index f65bb4c21b7d..5ef0879f6ad9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -642,7 +642,8 @@ static void rn_clk_mgr_helper_populate_bw_params(struct clk_bw_params *bw_params
 
 	j = -1;
 
-	ASSERT(PP_SMU_NUM_FCLK_DPM_LEVELS <= MAX_NUM_DPM_LVL);
+	static_assert(PP_SMU_NUM_FCLK_DPM_LEVELS <= MAX_NUM_DPM_LVL,
+		"number of reported FCLK DPM levels exceed maximum");
 
 	/* Find lowest DPM, FCLK is filled in reverse order*/
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index aa9fd1dc550a..191d8b969d19 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -566,7 +566,8 @@ static void vg_clk_mgr_helper_populate_bw_params(
 
 	j = -1;
 
-	ASSERT(VG_NUM_FCLK_DPM_LEVELS <= MAX_NUM_DPM_LVL);
+	static_assert(VG_NUM_FCLK_DPM_LEVELS <= MAX_NUM_DPM_LVL,
+		"number of reported FCLK DPM levels exceeds maximum");
 
 	/* Find lowest DPM, FCLK is filled in reverse order*/
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index ce1386e22576..12a7752758b8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -562,7 +562,8 @@ static void dcn31_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 
 	j = -1;
 
-	ASSERT(NUM_DF_PSTATE_LEVELS <= MAX_NUM_DPM_LVL);
+	static_assert(NUM_DF_PSTATE_LEVELS <= MAX_NUM_DPM_LVL,
+		"number of reported pstate levels exceeds maximum");
 
 	/* Find lowest DPM, FCLK is filled in reverse order*/
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 12f3e8aa46d8..e4ed888f8403 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -480,7 +480,8 @@ static void dcn316_clk_mgr_helper_populate_bw_params(
 
 	j = -1;
 
-	ASSERT(NUM_DF_PSTATE_LEVELS <= MAX_NUM_DPM_LVL);
+	static_assert(NUM_DF_PSTATE_LEVELS <= MAX_NUM_DPM_LVL,
+		"number of reported pstate levels exceeds maximum");
 
 	/* Find lowest DPM, FCLK is filled in reverse order*/
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 3b1b324c0824..df0f23afc8bb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -558,7 +558,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 		struct dc_dmub_cmd *dc_dmub_cmd,
 		unsigned int dmub_cmd_count,
 		struct block_sequence block_sequence[],
-		int *num_steps,
+		unsigned int *num_steps,
 		struct pipe_ctx *pipe_ctx,
 		struct dc_stream_status *stream_status)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 34d199b08dd9..4c98cd066b8f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1316,7 +1316,7 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 {
 	struct dc_dmub_srv *dc_dmub_srv;
-	uint32_t rcg_exit_count, ips1_exit_count, ips2_exit_count;
+	uint32_t rcg_exit_count = 0, ips1_exit_count = 0, ips2_exit_count = 0;
 
 	if (dc->debug.dmcub_emulation)
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 670d5ab9d998..2b1673d69ea8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -1408,7 +1408,7 @@ void dce110_opp_set_csc_default(
 static void program_pwl(struct dce_transform *xfm_dce,
 			const struct pwl_params *params)
 {
-	int retval;
+	uint32_t retval;
 	uint8_t max_tries = 10;
 	uint8_t counter = 0;
 	uint32_t i = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index 377f1ba1a81b..4d0eed7598b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -1439,7 +1439,6 @@ enum signal_type dcn10_get_dig_mode(
 	default:
 		return SIGNAL_TYPE_NONE;
 	}
-	return SIGNAL_TYPE_NONE;
 }
 
 void dcn10_link_encoder_get_max_link_cap(struct link_encoder *enc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index c831f6c69a17..fbcd6f7bc993 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -382,7 +382,7 @@ void dcn32_set_det_allocations(struct dc *dc, struct dc_state *context,
 {
 	int i, pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
-	struct pipe_ctx *pipe;
+	struct pipe_ctx *pipe = 0;
 	bool disable_unbounded_requesting = dc->debug.disable_z9_mpc || dc->debug.disable_unbounded_requesting;
 
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
index 6e6ae3de08e4..87eab924ecaf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
@@ -80,7 +80,6 @@ enum signal_type dcn35_get_dig_mode(
 	default:
 		return SIGNAL_TYPE_NONE;
 	}
-	return SIGNAL_TYPE_NONE;
 }
 
 void dcn35_link_encoder_setup(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 9c93a9f1eb0c..25d46c69464f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1102,8 +1102,6 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	} else {
 		return DCN_ZSTATE_SUPPORT_DISALLOW;
 	}
-
-	return DCN_ZSTATE_SUPPORT_DISALLOW;
 }
 
 static void dcn20_adjust_freesync_v_startup(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index e7f4a2d491cc..e0b52db2c210 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -3535,7 +3535,6 @@ static double TruncToValidBPP(
 			return DesiredBPP;
 		}
 	}
-	return BPP_INVALID;
 }
 
 void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index adea459e7d36..33cf824c5da1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -3679,7 +3679,6 @@ static double TruncToValidBPP(
 			return DesiredBPP;
 		}
 	}
-	return BPP_INVALID;
 }
 
 static noinline void CalculatePrefetchSchedulePerPlane(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index fb21572750e8..21f637ae4add 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -310,7 +310,7 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 {
 	int i, pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
-	struct pipe_ctx *pipe;
+	struct pipe_ctx *pipe = 0;
 	bool upscaled = false;
 	const unsigned int max_allowed_vblank_nom = 1023;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 88e56889a68c..3242957d00c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -3788,7 +3788,6 @@ static double TruncToValidBPP(
 			return DesiredBPP;
 		}
 	}
-	return BPP_INVALID;
 }
 
 static noinline void CalculatePrefetchSchedulePerPlane(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 80fccd4999a5..76399c66bc3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1650,6 +1650,8 @@ double dml32_TruncToValidBPP(
 			MaxLinkBPP = 2 * MaxLinkBPP;
 	}
 
+	*RequiredSlots = dml_ceil(DesiredBPP / MaxLinkBPP * 64, 1);
+
 	if (DesiredBPP == 0) {
 		if (DSCEnable) {
 			if (MaxLinkBPP < MinDSCBPP)
@@ -1676,10 +1678,6 @@ double dml32_TruncToValidBPP(
 		else
 			return DesiredBPP;
 	}
-
-	*RequiredSlots = dml_ceil(DesiredBPP / MaxLinkBPP * 64, 1);
-
-	return BPP_INVALID;
 } // TruncToValidBPP
 
 double dml32_RequiredDTBCLK(
@@ -4291,7 +4289,7 @@ void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 	unsigned int i, j, k;
 	unsigned int SurfaceWithMinActiveFCLKChangeMargin = 0;
 	unsigned int DRAMClockChangeSupportNumber = 0;
-	unsigned int LastSurfaceWithoutMargin;
+	unsigned int LastSurfaceWithoutMargin = 0;
 	unsigned int DRAMClockChangeMethod = 0;
 	bool FoundFirstSurfaceWithMinActiveFCLKChangeMargin = false;
 	double MinActiveFCLKChangeMargin = 0.;
@@ -5656,9 +5654,9 @@ void dml32_CalculateStutterEfficiency(
 	double LastZ8StutterPeriod = 0.0;
 	double LastStutterPeriod = 0.0;
 	unsigned int TotalNumberOfActiveOTG = 0;
-	double doublePixelClock;
-	unsigned int doubleHTotal;
-	unsigned int doubleVTotal;
+	double doublePixelClock = 0;
+	unsigned int doubleHTotal = 0;
+	unsigned int doubleVTotal = 0;
 	bool SameTiming = true;
 	double DETBufferingTimeY;
 	double SwathWidthYCriticalSurface = 0.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 714c2fe03c5f..60f251cf973b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -439,7 +439,7 @@ int dcn35_populate_dml_pipes_from_context_fpu(struct dc *dc,
 {
 	int i, pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
-	struct pipe_ctx *pipe;
+	struct pipe_ctx *pipe = 0;
 	bool upscaled = false;
 	const unsigned int max_allowed_vblank_nom = 1023;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index b3ffab77cf88..5abf120ff075 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -474,7 +474,7 @@ int dcn351_populate_dml_pipes_from_context_fpu(struct dc *dc,
 {
 	int i, pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
-	struct pipe_ctx *pipe;
+	struct pipe_ctx *pipe = 0;
 	bool upscaled = false;
 	const unsigned int max_allowed_vblank_nom = 1023;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 9184772d2e38..470dca3950c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -2784,6 +2784,8 @@ static dml_float_t TruncToValidBPP(
 		}
 	}
 
+	*RequiredSlots = (dml_uint_t)(dml_ceil(DesiredBPP / MaxLinkBPP * 64, 1));
+
 	if (DesiredBPP == 0) {
 		if (DSCEnable) {
 			if (MaxLinkBPP < MinDSCBPP) {
@@ -2812,10 +2814,6 @@ static dml_float_t TruncToValidBPP(
 			return DesiredBPP;
 		}
 	}
-
-	*RequiredSlots = (dml_uint_t)(dml_ceil(DesiredBPP / MaxLinkBPP * 64, 1));
-
-	return __DML_DPP_INVALID__;
 } // TruncToValidBPP
 
 static void CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
@@ -3792,9 +3790,9 @@ static void CalculateStutterEfficiency(struct display_mode_lib_scratch_st *scrat
 	dml_bool_t FoundCriticalSurface = false;
 
 	dml_uint_t TotalNumberOfActiveOTG = 0;
-	dml_float_t SinglePixelClock;
-	dml_uint_t SingleHTotal;
-	dml_uint_t SingleVTotal;
+	dml_float_t SinglePixelClock = 0;
+	dml_uint_t SingleHTotal = 0;
+	dml_uint_t SingleVTotal = 0;
 	dml_bool_t SameTiming = true;
 
 	dml_float_t LastStutterPeriod = 0.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index bedf1cd390df..81b4e08f8098 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -224,7 +224,7 @@ static int find_dml_pipe_idx_by_plane_id(struct dml2_context *ctx, unsigned int
 static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *state, const struct dc_plane_state *plane,
 	unsigned int stream_id, unsigned int plane_index, unsigned int *plane_id)
 {
-	int i, j;
+	unsigned int i, j;
 	bool is_plane_duplicate = dml2->v20.scratch.plane_duplicate_exists;
 
 	if (!plane_id)
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index ac41f9c0a283..a15b21edb0cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -458,7 +458,7 @@ bool dc_dsc_compute_bandwidth_range(
 	bool is_dsc_possible = false;
 	struct dsc_enc_caps dsc_enc_caps;
 	struct dsc_enc_caps dsc_common_caps;
-	struct dc_dsc_config config;
+	struct dc_dsc_config config = {0};
 	struct dc_dsc_config_options options = {0};
 
 	options.dsc_min_slice_height_override = dsc_min_slice_height_override;
@@ -868,9 +868,9 @@ static bool setup_dsc_config(
 		struct dc_dsc_config *dsc_cfg)
 {
 	struct dsc_enc_caps dsc_common_caps;
-	int max_slices_h;
-	int min_slices_h;
-	int num_slices_h;
+	int max_slices_h = 0;
+	int min_slices_h = 0;
+	int num_slices_h = 0;
 	int pic_width;
 	int slice_width;
 	int target_bpp;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 17b404cb1155..5920d1825a4c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -2188,7 +2188,7 @@ static void dce110_setup_audio_dto(
 		struct dc *dc,
 		struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 
 	/* program audio wall clock. use HDMI as clock source if HDMI
 	 * audio active. Otherwise, use DP as clock source
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 774605a029e8..40391dd16944 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -885,7 +885,7 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 {
 	union dmub_rb_cmd cmd;
 	uint32_t tmr_delay = 0, tmr_scale = 0;
-	struct dc_cursor_attributes cursor_attr;
+	struct dc_cursor_attributes cursor_attr = {0};
 	bool cursor_cache_enable = false;
 	struct dc_stream_state *stream = NULL;
 	struct dc_plane_state *plane = NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 2368fad61b41..659ce11ad446 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -480,7 +480,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 		struct dc_dmub_cmd *dc_dmub_cmd,
 		unsigned int dmub_cmd_count,
 		struct block_sequence block_sequence[],
-		int *num_steps,
+		unsigned int *num_steps,
 		struct pipe_ctx *pipe_ctx,
 		struct dc_stream_status *stream_status);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 22b24749c9d2..8d1a1cc94a8b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -884,7 +884,7 @@ void dp_set_preferred_link_settings(struct dc *dc,
 {
 	int i;
 	struct pipe_ctx *pipe;
-	struct dc_stream_state *link_stream;
+	struct dc_stream_state *link_stream = 0;
 	struct dc_link_settings store_settings = *link_setting;
 
 	link->preferred_link_setting = store_settings;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 9c0e2b9cffc9..ce68476e69d5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -127,7 +127,7 @@ void link_blank_dp_stream(struct dc_link *link, bool hw_init)
 		if (link->ep_type == DISPLAY_ENDPOINT_PHY &&
 			link->link_enc->funcs->get_dig_frontend &&
 			link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
-			unsigned int fe = link->link_enc->funcs->get_dig_frontend(link->link_enc);
+			int fe = link->link_enc->funcs->get_dig_frontend(link->link_enc);
 
 			if (fe != ENGINE_ID_UNKNOWN)
 				for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
index 5d36bab0029c..edb21d21952a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
@@ -291,7 +291,7 @@ static enum link_training_result dpia_training_cr_non_transparent(
 {
 	enum link_training_result result = LINK_TRAINING_CR_FAIL_LANE0;
 	uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
-	enum dc_status status;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
 	uint32_t retries_cr = 0; /* Number of consecutive attempts with same VS or PE. */
 	uint32_t retry_count = 0;
 	uint32_t wait_time_microsec = TRAINING_AUX_RD_INTERVAL; /* From DP spec, CR read interval is always 100us. */
@@ -617,7 +617,7 @@ static enum link_training_result dpia_training_eq_non_transparent(
 	enum link_training_result result = LINK_TRAINING_EQ_FAIL_EQ;
 	uint8_t repeater_cnt = 0; /* Number of hops/repeaters in display path. */
 	uint32_t retries_eq = 0;
-	enum dc_status status;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
 	enum dc_dp_training_pattern tr_pattern;
 	uint32_t wait_time_microsec = 0;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index d1edac46c9a0..88afb2a30eef 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -864,8 +864,6 @@ static struct clock_source *find_matching_pll(
 	default:
 		return NULL;
 	}
-
-	return NULL;
 }
 
 static enum dc_status build_mapped_resource(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index 20662edd0ae4..621825a51f46 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -1060,7 +1060,7 @@ static bool dce120_resource_construct(
 	struct irq_service_init_data irq_init_data;
 	static const struct resource_create_funcs *res_funcs;
 	bool is_vg20 = ASICREV_IS_VEGA20_P(ctx->asic_id.hw_internal_rev);
-	uint32_t pipe_fuses;
+	uint32_t pipe_fuses = 0;
 
 	ctx->dc_bios->regs = &bios_regs;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index ecc477ef8e3b..237e00ea3e94 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -1639,7 +1639,7 @@ noinline bool dcn30_internal_validate_bw(
 	int split[MAX_PIPES] = { 0 };
 	bool merge[MAX_PIPES] = { false };
 	bool newly_split[MAX_PIPES] = { false };
-	int pipe_cnt, i, pipe_idx, vlevel;
+	int pipe_cnt, i, pipe_idx, vlevel = 0;
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 
 	ASSERT(pipes);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index ce3699f62602..ecec3b69bb88 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1644,7 +1644,7 @@ int dcn31_populate_dml_pipes_from_context(
 {
 	int i, pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
-	struct pipe_ctx *pipe;
+	struct pipe_ctx *pipe = 0;
 	bool upscaled = false;
 
 	DC_FP_START();
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 83a71f1b933d..e808231e8478 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1613,7 +1613,7 @@ static int dcn316_populate_dml_pipes_from_context(
 {
 	int i, pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
-	struct pipe_ctx *pipe;
+	struct pipe_ctx *pipe = 0;
 	const int max_usable_det = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes - DCN3_16_MIN_COMPBUF_SIZE_KB;
 
 	DC_FP_START();
diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 8b5c27857671..3699e633801d 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1059,7 +1059,7 @@ static bool build_freesync_hdr(struct pwl_float_data_ex *rgb_regamma,
 	struct fixed31_32 min_display;
 	struct fixed31_32 max_content;
 	struct fixed31_32 clip = dc_fixpt_one;
-	struct fixed31_32 output;
+	struct fixed31_32 output = dc_fixpt_zero;
 	bool use_eetf = false;
 	bool is_clipped = false;
 	struct fixed31_32 sdr_white_level;
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index 733f22bed021..c996365e84b0 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -151,7 +151,7 @@ static enum mod_hdcp_status check_pairing_info_available(struct mod_hdcp *hdcp)
 
 static enum mod_hdcp_status poll_l_prime_available(struct mod_hdcp *hdcp)
 {
-	enum mod_hdcp_status status;
+	enum mod_hdcp_status status = MOD_HDCP_STATUS_FAILURE;
 	uint8_t size;
 	uint16_t max_wait = 20; // units of ms
 	uint16_t num_polls = 5;
-- 
2.34.1

