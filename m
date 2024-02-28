Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E17C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A166F10E296;
	Wed, 28 Feb 2024 18:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jsB+r/Ra";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416D510E296
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBZXdx2TA6EYXD9VVrQnKFKoy8Pl1mjU3oq5ouMAGJKdN4C2jFkEaqXoJjw0V/5iWSZYCsCq4pHC0OzyPGD9fpd3ERwasZTlyzyGJUlD1RNXID4ZhycQiE6yo16IOoY8IKby5flsJ5sukX8ZwNRNBNx7eIv6AH+NtoLyg4ER6bfabpW0beU/u2SlX0VeMdLfJBjTnQEwDcQPv/389CM1G8hpdoPl0qb0gBXF0VsfaJYLMcY7yQ/x2Im0R7wBseMT0nWLW1LEgSMD2hld4j5HBqF1HczIUONINV9yCWIQqtF0gbkmYxX97GRyJV47tmoeJVrxdFOTTPnl3d2AI5ICcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVgVU7pLz6GZEjuEyCSk1wPybi5C2/HHYM8O3H94RjU=;
 b=S5gBFd5aKRjjL0u6kZJdv/7h+nuLuOJlcUSBsejP979VssopQvQDkdL5+RxhA9gyKDnDD0+2sOO/30gjMMrJzchcg1Vm+Zz6FJ1ljeSQCgVITaapkmtpUSGwz/CrLUoCcNGfFaZ9tVUHnHfNpB/mNEq/E7mag+AFuRtcaorVrLITHi3XXOnatnrGLavPaNLnrQ5L9xuJlv1zhNmNFgFUwzqpcI9hsyh4oLGT9gwyZifdF4cMby1iwofqCItEiu8pV7c42/x+vK8nNWZQAPfWk1pWi5RRk93pLzW9RjuCQIFLCAyM46laaM7PRA5yyiqEdfcORSsPH1FHzNDOwVA92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVgVU7pLz6GZEjuEyCSk1wPybi5C2/HHYM8O3H94RjU=;
 b=jsB+r/RaV7Nx3vBDLUNNuAoyk18qDWgW2dpbgC2A7LxNUMhWvDKrybWJuVRp/9z9Z2bXN+PT269S3vGkKXGqp9K6IbHF27I2afleD2IvTTAjAdRddvwHGMIMTvTrzSdekWpDsxaii0vDsyRX330P75SPlJQXTpz81RAWGWLQVLg=
Received: from DM6PR12MB4974.namprd12.prod.outlook.com (2603:10b6:5:1bb::12)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 18:52:33 +0000
Received: from PH8PR07CA0031.namprd07.prod.outlook.com (2603:10b6:510:2cf::11)
 by DM6PR12MB4974.namprd12.prod.outlook.com (2603:10b6:5:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 18:47:34 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::b) by PH8PR07CA0031.outlook.office365.com
 (2603:10b6:510:2cf::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:47:33 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:47:31 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 30/34] drm/amd/display: Backup and restore only on full updates
Date: Wed, 28 Feb 2024 11:39:36 -0700
Message-ID: <20240228183940.1883742-31-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM6PR12MB4974:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 11791f03-c393-42a9-a4ec-08dc388db9b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIJVKtt7al5XHs7SVY02Hgmq09CIfHXKXYnxdNYrE/m0DFXZsVNGKGCzu4frcqg6wOl5S38P8QO0pAv4ZF2cR+oJcKoDhmzGRG2p/+SL+sm1cFlOXKYFg6dYzlzVHx3GkaD28wvyjyVkiiPcQbBbWq5Kyvn0who3RR+ft6mPyYp93foxCMYGqPwTL46rf8I40BPTzlI9ZXaYOAKfxRG2W+AQg4NYxBgCtOLDEFjxuf2RAX6ro1Paxqb9wMDn/rGNFV8veoJt1XZ4dkD2nRWb9PImGuXFeBwEj/SeMMLLxUaEPGFLolygURcqkaUknHRCGyauSJqfxpOZtNq2ykGPGrDQtM1Ofh7yqbi3/07Xd5L2wkevM9mhrEtTxZ68zplpKxdApd/meT+PPTD6oStf3enNHI9ZAoQOrvwFxyv+3QgDAtX+P3GNfPMTn053WnbLGdk9ZTwGIMW1/55paYd4KJ3duPFHi93Bv+2N28jHdQA574ZPf6cj0Jt2Bb6AK1Yd8EEx5Qwldh/UXU6G3oZ4nGZ8/yoe2OqfBCgfBofHlhtFvsb4/V/mj4qIGdmgRrQ/P20UzsC51lZwx7Fu4RgB4CdHyTkrpyElCO1vIGFCIknzdH1DOsEWxweiozw7FccT5MHE4lcs22n63W1TpcWMn1EUAOSE+TLnQ9m7U0BYstjXXcs7tXtVQcvxNgeQ4APk4DyCMjhD161mGDbsVPJ+CM8L8qyDfKp/Pnpe4TqZAyEXlXO8TZa6DJeVUONhoccV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:47:33.6507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11791f03-c393-42a9-a4ec-08dc388db9b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871
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

From: Alvin Lee <alvin.lee2@amd.com>

[WHY & HOW]
Since the backup and restore for plane and stream states has
a significant amount of data to copy, we will change the backup
and restore sequence to only take place during full updates.

We will also move the scratch memory to struct dc instead of dc_state
to avoid needing to allocate large amounts of memory every time
we create a new DC state.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  10 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   1 -
 drivers/gpu/drm/amd/display/dc/dc.h           | 164 ++++++++++--------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  22 ---
 4 files changed, 100 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d8967087335e..2105e4ba3384 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3162,9 +3162,10 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	}
 
 	context = dc->current_state;
-	backup_planes_and_stream_state(&dc->current_state->scratch, stream);
 	update_type = dc_check_update_surfaces_for_stream(
 			dc, srf_updates, surface_count, stream_update, stream_status);
+	if (update_type == UPDATE_TYPE_FULL)
+		backup_planes_and_stream_state(&dc->scratch.current_state, stream);
 
 	/* update current stream with the new updates */
 	copy_stream_update_to_stream(dc, context, stream, stream_update);
@@ -3267,7 +3268,8 @@ static bool update_planes_and_stream_state(struct dc *dc,
 
 	*new_context = context;
 	*new_update_type = update_type;
-	backup_planes_and_stream_state(&context->scratch, stream);
+	if (update_type == UPDATE_TYPE_FULL)
+		backup_planes_and_stream_state(&dc->scratch.new_state, stream);
 
 	return true;
 
@@ -4321,7 +4323,7 @@ static bool commit_minimal_transition_based_on_current_context(struct dc *dc,
 	 * This restores back the original stream and plane states associated
 	 * with the current state.
 	 */
-	restore_planes_and_stream_state(&dc->current_state->scratch, stream);
+	restore_planes_and_stream_state(&dc->scratch.current_state, stream);
 	intermediate_context = create_minimal_transition_state(dc,
 			dc->current_state, &policy);
 	if (intermediate_context) {
@@ -4348,7 +4350,7 @@ static bool commit_minimal_transition_based_on_current_context(struct dc *dc,
 	 * Restore stream and plane states back to the values associated with
 	 * new context.
 	 */
-	restore_planes_and_stream_state(&new_context->scratch, stream);
+	restore_planes_and_stream_state(&dc->scratch.new_state, stream);
 	return success;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 5cc7f8da209c..cce4e1c465b6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -310,7 +310,6 @@ void dc_state_destruct(struct dc_state *state)
 	memset(state->dc_dmub_cmd, 0, sizeof(state->dc_dmub_cmd));
 	state->dmub_cmd_count = 0;
 	memset(&state->perf_params, 0, sizeof(state->perf_params));
-	memset(&state->scratch, 0, sizeof(state->scratch));
 }
 
 void dc_state_retain(struct dc_state *state)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 09c6a393642a..9629bd9252b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1004,76 +1004,6 @@ struct dc_current_properties {
 	unsigned int cursor_size_limit;
 };
 
-struct dc {
-	struct dc_debug_options debug;
-	struct dc_versions versions;
-	struct dc_caps caps;
-	struct dc_cap_funcs cap_funcs;
-	struct dc_config config;
-	struct dc_bounding_box_overrides bb_overrides;
-	struct dc_bug_wa work_arounds;
-	struct dc_context *ctx;
-	struct dc_phy_addr_space_config vm_pa_config;
-
-	uint8_t link_count;
-	struct dc_link *links[MAX_PIPES * 2];
-	struct link_service *link_srv;
-
-	struct dc_state *current_state;
-	struct resource_pool *res_pool;
-
-	struct clk_mgr *clk_mgr;
-
-	/* Display Engine Clock levels */
-	struct dm_pp_clock_levels sclk_lvls;
-
-	/* Inputs into BW and WM calculations. */
-	struct bw_calcs_dceip *bw_dceip;
-	struct bw_calcs_vbios *bw_vbios;
-	struct dcn_soc_bounding_box *dcn_soc;
-	struct dcn_ip_params *dcn_ip;
-	struct display_mode_lib dml;
-
-	/* HW functions */
-	struct hw_sequencer_funcs hwss;
-	struct dce_hwseq *hwseq;
-
-	/* Require to optimize clocks and bandwidth for added/removed planes */
-	bool optimized_required;
-	bool wm_optimized_required;
-	bool idle_optimizations_allowed;
-	bool enable_c20_dtm_b0;
-
-	/* Require to maintain clocks and bandwidth for UEFI enabled HW */
-
-	/* FBC compressor */
-	struct compressor *fbc_compressor;
-
-	struct dc_debug_data debug_data;
-	struct dpcd_vendor_signature vendor_signature;
-
-	const char *build_id;
-	struct vm_helper *vm_helper;
-
-	uint32_t *dcn_reg_offsets;
-	uint32_t *nbio_reg_offsets;
-	uint32_t *clk_reg_offsets;
-
-	/* Scratch memory */
-	struct {
-		struct {
-			/*
-			 * For matching clock_limits table in driver with table
-			 * from PMFW.
-			 */
-			struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
-		} update_bw_bounding_box;
-	} scratch;
-
-	struct dml2_configuration_options dml2_options;
-	enum dc_acpi_cm_power_state power_state;
-};
-
 enum frame_buffer_mode {
 	FRAME_BUFFER_MODE_LOCAL_ONLY = 0,
 	FRAME_BUFFER_MODE_ZFB_ONLY,
@@ -1363,6 +1293,100 @@ struct dc_plane_info {
 	int layer_index;
 };
 
+#include "dc_stream.h"
+
+struct dc_scratch_space {
+	/* used to temporarily backup plane states of a stream during
+	 * dc update. The reason is that plane states are overwritten
+	 * with surface updates in dc update. Once they are overwritten
+	 * current state is no longer valid. We want to temporarily
+	 * store current value in plane states so we can still recover
+	 * a valid current state during dc update.
+	 */
+	struct dc_plane_state plane_states[MAX_SURFACE_NUM];
+	struct dc_gamma gamma_correction[MAX_SURFACE_NUM];
+	struct dc_transfer_func in_transfer_func[MAX_SURFACE_NUM];
+	struct dc_3dlut lut3d_func[MAX_SURFACE_NUM];
+	struct dc_transfer_func in_shaper_func[MAX_SURFACE_NUM];
+	struct dc_transfer_func blend_tf[MAX_SURFACE_NUM];
+
+	struct dc_stream_state stream_state;
+	struct dc_transfer_func out_transfer_func;
+};
+
+struct dc {
+	struct dc_debug_options debug;
+	struct dc_versions versions;
+	struct dc_caps caps;
+	struct dc_cap_funcs cap_funcs;
+	struct dc_config config;
+	struct dc_bounding_box_overrides bb_overrides;
+	struct dc_bug_wa work_arounds;
+	struct dc_context *ctx;
+	struct dc_phy_addr_space_config vm_pa_config;
+
+	uint8_t link_count;
+	struct dc_link *links[MAX_PIPES * 2];
+	struct link_service *link_srv;
+
+	struct dc_state *current_state;
+	struct resource_pool *res_pool;
+
+	struct clk_mgr *clk_mgr;
+
+	/* Display Engine Clock levels */
+	struct dm_pp_clock_levels sclk_lvls;
+
+	/* Inputs into BW and WM calculations. */
+	struct bw_calcs_dceip *bw_dceip;
+	struct bw_calcs_vbios *bw_vbios;
+	struct dcn_soc_bounding_box *dcn_soc;
+	struct dcn_ip_params *dcn_ip;
+	struct display_mode_lib dml;
+
+	/* HW functions */
+	struct hw_sequencer_funcs hwss;
+	struct dce_hwseq *hwseq;
+
+	/* Require to optimize clocks and bandwidth for added/removed planes */
+	bool optimized_required;
+	bool wm_optimized_required;
+	bool idle_optimizations_allowed;
+	bool enable_c20_dtm_b0;
+
+	/* Require to maintain clocks and bandwidth for UEFI enabled HW */
+
+	/* FBC compressor */
+	struct compressor *fbc_compressor;
+
+	struct dc_debug_data debug_data;
+	struct dpcd_vendor_signature vendor_signature;
+
+	const char *build_id;
+	struct vm_helper *vm_helper;
+
+	uint32_t *dcn_reg_offsets;
+	uint32_t *nbio_reg_offsets;
+	uint32_t *clk_reg_offsets;
+
+	/* Scratch memory */
+	struct {
+		struct {
+			/*
+			 * For matching clock_limits table in driver with table
+			 * from PMFW.
+			 */
+			struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
+		} update_bw_bounding_box;
+		struct dc_scratch_space current_state;
+		struct dc_scratch_space new_state;
+	} scratch;
+
+	struct dml2_configuration_options dml2_options;
+	enum dc_acpi_cm_power_state power_state;
+
+};
+
 struct dc_scaling_info {
 	struct rect src_rect;
 	struct rect dst_rect;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index e034cbb40620..b5b090197ad7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -524,25 +524,6 @@ struct dc_dmub_cmd {
 	enum dm_dmub_wait_type wait_type;
 };
 
-struct dc_scratch_space {
-	/* used to temporarily backup plane states of a stream during
-	 * dc update. The reason is that plane states are overwritten
-	 * with surface updates in dc update. Once they are overwritten
-	 * current state is no longer valid. We want to temporarily
-	 * store current value in plane states so we can still recover
-	 * a valid current state during dc update.
-	 */
-	struct dc_plane_state plane_states[MAX_SURFACE_NUM];
-	struct dc_gamma gamma_correction[MAX_SURFACE_NUM];
-	struct dc_transfer_func in_transfer_func[MAX_SURFACE_NUM];
-	struct dc_3dlut lut3d_func[MAX_SURFACE_NUM];
-	struct dc_transfer_func in_shaper_func[MAX_SURFACE_NUM];
-	struct dc_transfer_func blend_tf[MAX_SURFACE_NUM];
-
-	struct dc_stream_state stream_state;
-	struct dc_transfer_func out_transfer_func;
-};
-
 /**
  * struct dc_state - The full description of a state requested by users
  */
@@ -624,9 +605,6 @@ struct dc_state {
 	struct {
 		unsigned int stutter_period_us;
 	} perf_params;
-
-
-	struct dc_scratch_space scratch;
 };
 
 struct replay_context {
-- 
2.34.1

