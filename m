Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C3D606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0gM4JEbi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9235E10F94A;
	Wed, 21 Oct 2026 06:26:10 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA3610F932
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h08HEDYSyyfh8YEbQlNWIs5fh4XJwer3VdIJN/TQLxv1U0XWA05uV7OVVI/kbi5WYCj3htsV5YTLocDKuRktJd2Cbd0HVGOOactlpkZ4PW4nw8dQXa0IoWSCV2f1DfNLYrI3j7dlzxux1o6zCAYibOTsz9/7E0Drze62RcGl0SGfu3eqa1dK0s12XQoNoT2s3Xg98THLcHAYUVY8+5mxnrPPEnhhe00WRIem5gzlfWJbMxk9L7w3X4HyJKFENulweBlD/dSmrmVQctQgvxi25zmSOI+nOxF8vcAp6/lJg37F4kn0SxvCM40/yGC3mHZQMoxxybQrjm27+59W33QGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u1Z1pjli3V5HOt8i0LfpqhER2BjeZerfnOASv134Qs=;
 b=wT50Cu6QWjv57/UG1BddSRdNUGPqCV05DGnEjbt1kAgQEiSCq1K2Gg1Lvr4c/0NX69g7QcxTj94/1UgOZxFnG1mJ14j0GRHaCCNZydroeNJZQci3j40cfiJzcsk/BKflYw6rbonrH9DoJhFonj3Y8JyUoDe5ECEOjBccYF/9HXwUfUrKYkiYNtgm7jlVoRVd4XFeSNFHiaswcvkYRSufbldxzOgpqxS8DBmmfKwm2/RIQ5TuJVwAndXVmh2PTf2POv4MKndvayDin6QxSs0xoKImjwWcgfUlQZdelh6WsGbCfiweE223aFVuWUAAtlQdS21/ELwzRamjUeGsOWa+4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u1Z1pjli3V5HOt8i0LfpqhER2BjeZerfnOASv134Qs=;
 b=0gM4JEbi+hNXSjmxGFBuJkiCO3xnC0TnRWGnV+47a/CQeB5farAsWuli0WgWXmppqHsT9xCqrVbJyMGy1VOoOkh8TE6yXMDEhebrKOYwTYSdTbtGlSeibF4hsgQ37pgn/YJtqCTG3ruHoJfFbN4vD0S4oB4t5gQ9wQvI2NrfqGQ=
Received: from BN9PR03CA0425.namprd03.prod.outlook.com (2603:10b6:408:113::10)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:25:51 +0000
Received: from BN1PEPF00018545.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::5e) by BN9PR03CA0425.outlook.office365.com
 (2603:10b6:408:113::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:25:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018545.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:25:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:25:50 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:25:47 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 08/49] drm/amd/display: Scaffold PSP reload, ABI query,
 and Initialize DCN
Date: Wed, 21 Oct 2026 14:22:14 +0800
Message-ID: <20261021062519.674697-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018545:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6f8e5c-0a9d-4499-15e0-08df2f3c273f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|56012099006|11063799006|261009221227099003|261009223027099003|10067099003|22082099003|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: 4DmNgFc/h3GS48vKdVfNu8MT91SH1Pvnqv2jU4spzOqAlLz1yJpqCVGC9im4g+Ei/Rsfmr0WZPVd1ts2RlWy8szWlX1Svkkq/A7HqhYhi69ft4qIc/114fTKFZfo0WPszvwxrdguyPvCK1KAkgbG5Q05X1F3puP5jtoN1gdiyEuFRqT9CWV5WTzrqUuovaUWsPbANJjyS2ZqYx5WI6Z/uFpn3bvBFNuZLAiiKDEHXxQuDNC1yn40M8D3kY0jQDWcq3LCGi64+4TFCWMPAkPL+JfgjVba/ClVID/AMqn4duW3A2sD7znQKLaxht/Ow9PiziaX69yTP5KpRaFoZR5jcRjyp0Rsxu9COI96PtCMafsAOHFTa++smzq1o5EcPEpVZGbIidE8VL7fO9c+Z7KAuyoYH3MWuvhrrGeM+bY1W9tBZ9rSXPo2dR9TM3ACSsf2Hb5ushWnbIQbDAIkC+jEXnJNM/enVC65Vfq82tNSL+3u0dCtXHwAdHq4IuEb8JaZBQTmTGxzB2yfuQQ2aajSih4G5WADx3snGeNJnkQCYRnMz6dEezUuaOvSc5td3QkzxGzkhcQQQuoDJ8/5CkJyHRIqqSr0gJmR4fdUOJc4wj5CEz1vk4DrorQJWSdvuNgjm42lh2t9sPAfGyb5ZeSuo8pxiQMwCV2luns7Mjdrbee8Ll+VwvNhKyB4c/iyob5m3sH/PdQIQcKA/loePeb6Zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(261009221227099003)(261009223027099003)(10067099003)(22082099003)(6133799003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DWuy6XnTVaFQ+IX2iY7kkKgguWaSOHF85VDa43fE5dPOKDLeFgkhQl6lygW/EIpw3s1FI0txPZXK0B+4sx2gqajcNjpMtb3R5P/z6x+k/mm/LAk04jgPRKysidwQBmw9A1sabKdJDGReJbuvqKyxxUPIuxzkNOHg4MndG/V9pfOzhtRRDQAd+GkkD5+Ff2FQbZcVouqogZ75GpNHrJeRDoi4RLaEghCOYPouNsiLsKht8wELfPlXuiiO7ogWoFSehGFO7sn3+hQRQlT7vbgymPHZPKPSA3v5r/yWBEXEUS2pJymW1VbdVCIJFVmCkhA8TBEYK2khfiBqCKRLuxGBFGRh0XGRJHJJfNsonFGz53BooX/T4uf1FBZ3F91JjCX+P8P2dTh8Den9UVTZYnzL4GAHLJaAZYufkE5ZsI/S5YVJSZVhfWn8GgKAPWvbp7ft
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:25:51.2466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6f8e5c-0a9d-4499-15e0-08df2f3c273f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018545.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

Why:
The init head stopped at firmware halt. The flow still needs a PSP
reload, an ABI query, and an Initialize DCN entry before Core2 can
call the sequence.

How:
Keep DMUB_GPINT_SEND_AND_WAIT valid beside DMUB_HALT_FW. Append
PSP_RELOAD_DMUB_FW through dmub_srv_hw_init, a GET_FW_VERSION GPINT
into dmub_abi.fw_version, and a QUERY_FEATURE_CAPS inbox command whose
reply is copied into dmub_abi.feature_caps. Emit DMUB_INITIALIZE_DCN
with a zero command type and keep the walk UNSUPPORTED so an undefined
opcode cannot succeed.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/dc/bls_builder/bls_builder.h  |   6 +-
 .../dc/bls_builder/dcn401_init_builder.c      | 116 ++++++++++++++++++
 .../display/dc/bls_executor/bls_executor.c    |  38 ++++++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  11 ++
 4 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
index c2156117b73f..b06074a4c480 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
@@ -6,6 +6,7 @@
 #pragma once
 
 #include "dc.h"
+#include "dmub_cmd.h"
 #include "hwss/hw_sequencer.h"
 
 #define DC2_BLS_MAX_STEPS 64
@@ -29,7 +30,7 @@ enum bls_builder_kind {
 
 struct dmub_abi {
 	unsigned int fw_version;
-	unsigned int feature_caps;
+	struct dmub_feature_caps feature_caps;
 };
 
 struct bls_builder_output_init {
@@ -41,6 +42,8 @@ struct bls_builder_output_init {
 	bool dcmode_power_limits_present;
 	unsigned int dmub_stop_fw_response;
 	struct dmub_abi dmub_abi;
+	union dmub_rb_cmd dmub_query_feature_caps_cmd;
+	union dmub_rb_cmd dmub_initialize_dcn_cmd;
 };
 
 struct bls_builder_output_targets {
@@ -60,6 +63,7 @@ struct bls_builder_declarative_params {
 	const struct dc_state *current_state;
 	const struct dc_state *new_state;
 	const struct dmub_abi *dmub_abi;
+	const struct dmub_srv_hw_params *dmub_hw_params;
 	struct bls_builder_output_targets *out_targets;
 	struct block_sequence head_sequence[DC2_BLS_MAX_STEPS];
 	unsigned int head_num_steps;
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
index e8f518d17af6..b63f255303d1 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
@@ -17,6 +17,10 @@ static const enum block_sequence_func dcn401_dc1_init_sequence[] = {
 	LEGACY_CLK_MGR_IS_DC_MODE_PRESENT,
 	DCCG_INITIALIZE_CLOCKS,
 	DMUB_HALT_FW,
+	PSP_RELOAD_DMUB_FW,
+	DMUB_GPINT_SEND_AND_WAIT,
+	DMUB_SEND_DMCUB_CMD,
+	DMUB_INITIALIZE_DCN,
 };
 
 static bool bls_append(struct block_sequence_state *sequence,
@@ -88,6 +92,7 @@ static enum bls_builder_result dcn401_validate_initialization_step(
 		if (!dccg->funcs || !dccg->funcs->dccg_init)
 			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
 		return BLS_BUILD_SUCCESS;
+	case DMUB_GPINT_SEND_AND_WAIT:
 	case DMUB_HALT_FW: {
 		struct dc_context *ctx = params->dc->ctx;
 		struct dmub_srv *dmub;
@@ -101,6 +106,18 @@ static enum bls_builder_result dcn401_validate_initialization_step(
 			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
 		return BLS_BUILD_SUCCESS;
 	}
+	case PSP_RELOAD_DMUB_FW:
+		if (!params->dc->ctx || !params->dc->ctx->dmub_srv ||
+				!params->dc->ctx->dmub_srv->dmub ||
+				!params->dmub_hw_params)
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+		return BLS_BUILD_SUCCESS;
+	case DMUB_SEND_DMCUB_CMD:
+	case DMUB_INITIALIZE_DCN:
+		if (!params->dc->ctx || !params->dc->ctx->dmub_srv ||
+				!params->dc->ctx->dmub_srv->dmub || !out_init)
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+		return BLS_BUILD_SUCCESS;
 	default:
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 	}
@@ -172,6 +189,94 @@ static inline enum bls_builder_result dcn401_build_dmub_halt_fw(
 	return BLS_BUILD_SUCCESS;
 }
 
+static inline enum bls_builder_result dcn401_build_psp_reload(
+		struct bls_builder_declarative_params *params,
+		struct block_sequence_state *sequence)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.psp_reload_dmub_fw_params.dmub =
+			params->dc->ctx->dmub_srv->dmub;
+	bls_params.psp_reload_dmub_fw_params.hw_params =
+			params->dmub_hw_params;
+	if (!bls_append(sequence, PSP_RELOAD_DMUB_FW, &bls_params))
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static inline enum bls_builder_result dcn401_build_dmub_fw_version(
+		struct bls_builder_declarative_params *params,
+		struct block_sequence_state *sequence)
+{
+	union block_sequence_params bls_params = {0};
+	struct bls_builder_output_init *out_init =
+			params->out_targets->DCN_DECL_INITIALIZATION;
+
+	bls_params.dmub_gpint_params.command_code =
+			DMUB_GPINT__GET_FW_VERSION;
+	bls_params.dmub_gpint_params.param = 0;
+	bls_params.dmub_gpint_params.response =
+			&out_init->dmub_abi.fw_version;
+	if (!bls_append(sequence, DMUB_GPINT_SEND_AND_WAIT, &bls_params))
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static inline enum bls_builder_result dcn401_build_dmub_feature_caps(
+		struct bls_builder_declarative_params *params,
+		struct block_sequence_state *sequence)
+{
+	union block_sequence_params bls_params = {0};
+	struct bls_builder_output_init *out_init =
+			params->out_targets->DCN_DECL_INITIALIZATION;
+	union dmub_rb_cmd *cmd = &out_init->dmub_query_feature_caps_cmd;
+
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->query_feature_caps.header.type = DMUB_CMD__QUERY_FEATURE_CAPS;
+	cmd->query_feature_caps.header.sub_type = 0;
+	cmd->query_feature_caps.header.ret_status = 1;
+	cmd->query_feature_caps.header.payload_bytes =
+			sizeof(struct dmub_cmd_query_feature_caps_data);
+	bls_params.send_dmcub_cmd_params.ctx = params->dc->ctx;
+	bls_params.send_dmcub_cmd_params.cmd = cmd;
+	bls_params.send_dmcub_cmd_params.wait_type =
+			DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY;
+	bls_params.send_dmcub_cmd_params.feature_caps =
+			&out_init->dmub_abi.feature_caps;
+	if (!bls_append(sequence, DMUB_SEND_DMCUB_CMD, &bls_params))
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static inline enum bls_builder_result dcn401_build_dmub_initialize_dcn(
+		struct bls_builder_declarative_params *params,
+		struct block_sequence_state *sequence)
+{
+	union block_sequence_params bls_params = {0};
+	struct bls_builder_output_init *out_init =
+			params->out_targets->DCN_DECL_INITIALIZATION;
+	union dmub_rb_cmd *cmd = &out_init->dmub_initialize_dcn_cmd;
+
+	/*
+	 * No Initialize DCN opcode exists in dmub_cmd.h. A caller-supplied
+	 * non-zero type is preserved for tests; zero stays an undefined
+	 * command and cannot complete a successful build.
+	 */
+	if (!cmd->cmd_common.header.type)
+		memset(cmd, 0, sizeof(*cmd));
+	bls_params.send_dmcub_cmd_params.ctx = params->dc->ctx;
+	bls_params.send_dmcub_cmd_params.cmd = cmd;
+	bls_params.send_dmcub_cmd_params.wait_type =
+			DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY;
+	if (!bls_append(sequence, DMUB_INITIALIZE_DCN, &bls_params))
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	return BLS_BUILD_SUCCESS;
+}
+
 static enum bls_builder_result dcn401_build_initialization_step(
 		struct bls_builder_declarative_params *params,
 		struct block_sequence_state *sequence,
@@ -186,6 +291,14 @@ static enum bls_builder_result dcn401_build_initialization_step(
 		return dcn401_build_dccg_init(params, sequence);
 	case DMUB_HALT_FW:
 		return dcn401_build_dmub_halt_fw(params, sequence);
+	case PSP_RELOAD_DMUB_FW:
+		return dcn401_build_psp_reload(params, sequence);
+	case DMUB_GPINT_SEND_AND_WAIT:
+		return dcn401_build_dmub_fw_version(params, sequence);
+	case DMUB_SEND_DMCUB_CMD:
+		return dcn401_build_dmub_feature_caps(params, sequence);
+	case DMUB_INITIALIZE_DCN:
+		return dcn401_build_dmub_initialize_dcn(params, sequence);
 	default:
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 	}
@@ -227,6 +340,9 @@ static enum bls_builder_result dcn401_build_initialization(
 	if (out_init) {
 		out_init->dcmode_power_limits_present = false;
 		out_init->dmub_stop_fw_response = 0;
+		out_init->dmub_abi.fw_version = 0;
+		memset(&out_init->dmub_abi.feature_caps, 0,
+				sizeof(out_init->dmub_abi.feature_caps));
 	}
 
 	/*
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
index 510943a12724..23e3c39a69b7 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
@@ -9,6 +9,7 @@
 #include "dccg.h"
 #include "core_types.h"
 #include "dc_dmub_srv.h"
+#include "dmub_cmd.h"
 #include "bls_executor/bls_executor.h"
 #include "dmub_messenger/dmub_messenger.h"
 
@@ -57,6 +58,19 @@ static bool dc2_bls_step_supported(const struct dc2 *dc2,
 				dmub->hw_funcs.is_gpint_acked &&
 				dmub->hw_funcs.get_gpint_response &&
 				step->params.dmub_gpint_params.response;
+	case PSP_RELOAD_DMUB_FW:
+		return step->params.psp_reload_dmub_fw_params.dmub &&
+				step->params.psp_reload_dmub_fw_params.hw_params &&
+				step->params.psp_reload_dmub_fw_params.hw_params->fb_info;
+	case DMUB_INITIALIZE_DCN:
+		ctx = step->params.send_dmcub_cmd_params.ctx;
+		if (!ctx || !ctx->dmub_srv || !ctx->dmub_srv->dmub ||
+				!step->params.send_dmcub_cmd_params.cmd ||
+				!step->params.send_dmcub_cmd_params.cmd->cmd_common
+				.header.type ||
+				(ctx->dmub_srv->idle_allowed && !ctx->dc))
+			return false;
+		return true;
 	default:
 		return false;
 	}
@@ -81,6 +95,19 @@ static enum dc2_bls_exec_result dc2_bls_exec_dmub_send(
 			DMUB_MSG_OK)
 		return DC2_BLS_EXEC_ERROR;
 
+	/*
+	 * The messenger leaves the reply in the builder-owned command.
+	 * Deposit feature caps into the ABI slot the builder named.
+	 */
+	if (entry->params.send_dmcub_cmd_params.feature_caps &&
+			entry->params.send_dmcub_cmd_params.cmd->
+			query_feature_caps.header.ret_status == 0)
+		memcpy(entry->params.send_dmcub_cmd_params.feature_caps,
+				&entry->params.send_dmcub_cmd_params.cmd->
+				query_feature_caps.query_feature_caps_data,
+				sizeof(*entry->params.send_dmcub_cmd_params
+						.feature_caps));
+
 	return DC2_BLS_EXEC_OK;
 }
 
@@ -152,6 +179,17 @@ enum dc2_bls_exec_result dc2_bls_execute(
 			if (dc2_bls_exec_dmub_gpint(dc2, entry) != DC2_BLS_EXEC_OK)
 				return DC2_BLS_EXEC_ERROR;
 			break;
+		case PSP_RELOAD_DMUB_FW:
+			if (dmub_srv_hw_init(
+					entry->params.psp_reload_dmub_fw_params.dmub,
+					entry->params.psp_reload_dmub_fw_params.hw_params) !=
+					DMUB_STATUS_OK)
+				return DC2_BLS_EXEC_ERROR;
+			break;
+		case DMUB_INITIALIZE_DCN:
+			if (dc2_bls_exec_dmub_send(entry) != DC2_BLS_EXEC_OK)
+				return DC2_BLS_EXEC_ERROR;
+			break;
 		default:
 			ASSERT(false);
 			return DC2_BLS_EXEC_ERROR;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 2393174bc282..7ce6135bb348 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -63,6 +63,8 @@ struct hpo_frl_stream_encoder;
 struct link_training_settings;
 struct dc_link;
 struct dc_crtc_timing;
+struct dmub_srv_hw_params;
+struct dmub_feature_caps;
 
 struct tg_lock_params {
 	struct dc *dc;
@@ -140,6 +142,7 @@ struct send_dmcub_cmd_params {
 	struct dc_context *ctx;
 	union dmub_rb_cmd *cmd;
 	enum dm_dmub_wait_type wait_type;
+	struct dmub_feature_caps *feature_caps;
 };
 
 struct dmub_gpint_params {
@@ -148,6 +151,11 @@ struct dmub_gpint_params {
 	unsigned int *response;
 };
 
+struct psp_reload_dmub_fw_params {
+	struct dmub_srv *dmub;
+	const struct dmub_srv_hw_params *hw_params;
+};
+
 struct lsdma_send_pio_copy_params {
 	struct dc_dmub_srv *dc_dmub_srv;
 	uint64_t src_addr;
@@ -1223,6 +1231,7 @@ union block_sequence_params {
 			legacy_clk_mgr_is_dc_mode_present_params;
 	struct dccg_initialize_clocks_params dccg_initialize_clocks_params;
 	struct dmub_gpint_params dmub_gpint_params;
+	struct psp_reload_dmub_fw_params psp_reload_dmub_fw_params;
 	struct hubbub_program_watermarks_params hubbub_program_watermarks_params;
 	struct hubbub_program_arbiter_params hubbub_program_arbiter_params;
 	struct hubbub_program_compbuf_segments_params hubbub_program_compbuf_segments_params;
@@ -1398,6 +1407,8 @@ enum block_sequence_func {
 	DCCG_INITIALIZE_CLOCKS,
 	DMUB_GPINT_SEND_AND_WAIT,
 	DMUB_HALT_FW,
+	PSP_RELOAD_DMUB_FW,
+	DMUB_INITIALIZE_DCN,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
-- 
2.43.0

