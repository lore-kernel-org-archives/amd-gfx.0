Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E357606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1sNDtGEK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F19510F948;
	Wed, 21 Oct 2026 06:26:09 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBA0D10F948
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHGLlEKtXygm8IKyVREYl0mAkjV4JQuLRveFAttFtMxMJfVDTTu4aFnwLua19BNZxEhIbP+y2kFCL0sCzlIDE+/AVnUFn8ChPNTEo/j6E/u0kQGj0YZ6C+YhNe903R/ssiT4jz6o5Psd9z3RC1M/mzoT0t6iVYuH/ySspJ7Tu7zkOwi0VBvWxgnV/yi6BjVKz9G3zcakso75VOXJny48EWOiK06Z8AW2HESlPj45hdViO14V2s+HOwsa29hSdv3zFsFtUL+VT/IiFT36JnwUh1P+RwfwiJOfsr0N1UGzD5Ck71e9ptS1ZDGzPp+T1OaE41zeVmJ8SQQFO8iH4jT6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS8vmJxgRA9vSRdSIBGf1LCC+HkOIMyd95gd2p+MauI=;
 b=VOTwf4WQaqBe1i/n4REg3S0Hp0wtfz8cNOg3YVKR+LkddjmPuWcIZtzZfnjBdAU+2Z320Q3LbDWSC46qlhK3okIT/L4rmAS/dfUhqR4gy/kq30FOku4tDzsf3ygFmDJITmxp8le0Eh3lvvOrEeOCEZpKXC2K8alkvcgsGoFIM5nUWOqyX40qdmfvXzw2QVKNj2/SdLDHvlFQq6Gv01zGjDjwnEcvruGAIQ8tMBa+BHuIsr+dZMb3EXhkgCYArGBUqKHpKVZ9UFvXVXXmrLdJ8up+1EKfKw/dDWNZhS2od3fR1T09wR0A4XFmZ746sqMaSwbw6ArjrV0Yb3PvG9olTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS8vmJxgRA9vSRdSIBGf1LCC+HkOIMyd95gd2p+MauI=;
 b=1sNDtGEKIExWLvVfzoaz9ix7CgkI82+K9x5vtjFC3uOFPeBuiMFV6K8ZPnBoht5h+R1WKDjeH1l8j/UlWJzo47hGGut8bK/MDHFdGj9O93yspliaJXoEEOsXuo59U6jfngmNxR3svksYYIFR97htXT2lKr9fq2mTrziTHkCxPyk=
Received: from BN9PR03CA0322.namprd03.prod.outlook.com (2603:10b6:408:112::27)
 by DSSPR12MB999237.namprd12.prod.outlook.com (2603:10b6:8:377::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:25:59 +0000
Received: from BN1PEPF00018547.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::49) by BN9PR03CA0322.outlook.office365.com
 (2603:10b6:408:112::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 06:25:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018547.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:25:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:25:58 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:25:55 -0500
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
Subject: [PATCH 10/49] drm/amd/display: Attach retained DMUB windows to PSP
 reload
Date: Wed, 21 Oct 2026 14:22:16 +0800
Message-ID: <20261021062519.674697-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018547:EE_|DSSPR12MB999237:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e00b98b-2e69-4851-4683-08df2f3c2be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: J4j9jO9NwdqTW11DIWZjlApQS/oKBr2Hm0GSVy9rMCKuUX67HcTLmJHPBDlYo0UQ6TxV1tcTE90bGJTimMBScBPjOD91szKXtNld3ee3QOPS5iH3V0Y1OnPDb/V47E3F2E67RSQsbbl25uwOS1oKFL1u6sVNwM06zJe0ZaNTsh8XTVLDGliPzv7cVCB7IoUNWTa7AszUxaIpiFlFeRmq+QIBK9vgRorZsIyvkLNlNX1CTEMRoWEyq/wOiIwSysJEZ34orgtVJqE+U9HyiPf+LJr26Ik911DSvIMMFSDpgmYmyAntMYSGg9Clid/aSBs4i8Kxu6dFTl7PZBpEcV7Sg73KzlWDGPL0M2Bnp32+JtDAwdRpC9mnQ6uoma77O8p0uw/PGVxYsupn3MqYX+qcQTBxoTGaojD12kNNeo7PU021XJbDfc1WeKLfw8uWNG61GlOWHQmDITxVlI0faz/cb4lJLUzlaq9ypmae3Lc4N2GJiirow6Sp1iJJUdaOtuBpox1+Uqr5vmDPyXp+nTHngc0m1KhzUZ9lTd1eikUt3sFqtvCYkHDtq2KHWkpFxEiASepO5CG55Apqm1k3YJD+y5t4khnOiDykPZ3tB42XIGnR7GjyWhaqkyo5YpgClGa2HajZ2MZo/9nK60ywrhyXfivJkaczf2I1CImOuSWEdTabJPRGw/y3exNfKHQEMwk4wy0yUJIvj6ghkHWDAHkeqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qNGwFTfPCzX+d8qLGPPKaVKhJ6Drgbm6Ee0uGnNUxwXVLtjW6ATG9+YPmBjpygbrODSccpPZaIurkQK0QsKyvYNGkNQD9r6nGZyVoFyHt7+NhgaLCz7sIITrOLIiMhys95WxjnLiaGaSRs1EyCbWFePbCyR9Hbx/GobHWmE6biP+tTMH1apLkQFEvjOfXpq6W/RZ3DFYCES6rFcedFI5tToDBrnpYIVRPSg9brluugd8M8mGxMouqQRI5EngSuAHZIEfq5r9BVPvBFHtWUY9To0wI7/pdjI/rM8IEPMEk6hYs4NLfH4WTABL1cIv0GIsJgJnt+GlkEeM230ZD+47G5yYu1MxH5BLE3YrP0F24Wlb69Rau60ospW3f7Ihce0pYId2FbOC2rmSF7vzPPDpODf6qDRTYWT4onm2lCUtAlarghS6Lo/R3IIj3yPEgRq+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:25:59.0394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e00b98b-2e69-4851-4683-08df2f3c2be4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018547.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999237
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

Core2 init never supplied DMUB window params, so PSP reload
failed closed before the builder could name the framebuffers
dmub_srv already retained.

When the caller does not pass hw params, copy the retained
window table, soc_fb_info, and psp_version onto the
declarative params and point PSP_RELOAD_DMUB_FW at that copy.
Require a full window count before execute. A zero Initialize
DCN command still leaves the build unsupported, so
core2_hardware_init does not run the head.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/dc/bls_builder/bls_builder.h  |  9 +++++
 .../dc/bls_builder/dcn401_init_builder.c      | 39 +++++++++++++++++--
 .../display/dc/bls_executor/bls_executor.c    | 10 +++--
 .../drm/amd/display/dc/core2/dc_core2_init.c  |  6 +--
 4 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
index b06074a4c480..73d985e9b04f 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
@@ -7,6 +7,7 @@
 
 #include "dc.h"
 #include "dmub_cmd.h"
+#include "dmub/dmub_srv.h"
 #include "hwss/hw_sequencer.h"
 
 #define DC2_BLS_MAX_STEPS 64
@@ -64,6 +65,14 @@ struct bls_builder_declarative_params {
 	const struct dc_state *new_state;
 	const struct dmub_abi *dmub_abi;
 	const struct dmub_srv_hw_params *dmub_hw_params;
+	/*
+	 * Filled when the caller does not pass dmub_hw_params and dmub_srv
+	 * already retained framebuffer windows. fb_info on dmub_srv is
+	 * const, so the window table is copied here before the PSP entry
+	 * points at owned_dmub_hw_params.
+	 */
+	struct dmub_srv_hw_params owned_dmub_hw_params;
+	struct dmub_srv_fb_info owned_dmub_fb_info;
 	struct bls_builder_output_targets *out_targets;
 	struct block_sequence head_sequence[DC2_BLS_MAX_STEPS];
 	unsigned int head_num_steps;
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
index 21ba6a9245dd..a546ea80803a 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
@@ -106,12 +106,25 @@ static enum bls_builder_result dcn401_validate_initialization_step(
 			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
 		return BLS_BUILD_SUCCESS;
 	}
-	case PSP_RELOAD_DMUB_FW:
+	case PSP_RELOAD_DMUB_FW: {
+		struct dmub_srv *dmub;
+
 		if (!params->dc->ctx || !params->dc->ctx->dmub_srv ||
-				!params->dc->ctx->dmub_srv->dmub ||
-				!params->dmub_hw_params)
+				!params->dc->ctx->dmub_srv->dmub)
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+		/*
+		 * An explicit caller pointer wins, including a test double
+		 * whose fb_info is still empty. Otherwise use the windows
+		 * dmub_srv retained from the DM's earlier hw init.
+		 */
+		if (params->dmub_hw_params)
+			return BLS_BUILD_SUCCESS;
+		dmub = params->dc->ctx->dmub_srv->dmub;
+		if (!dmub->fb_info ||
+				dmub->fb_info->num_fb < DMUB_WINDOW_TOTAL)
 			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
 		return BLS_BUILD_SUCCESS;
+	}
 	case DMUB_SEND_DMCUB_CMD:
 	case DMUB_INITIALIZE_DCN:
 		if (!params->dc->ctx || !params->dc->ctx->dmub_srv ||
@@ -189,6 +202,24 @@ static inline enum bls_builder_result dcn401_build_dmub_halt_fw(
 	return BLS_BUILD_SUCCESS;
 }
 
+static const struct dmub_srv_hw_params *dcn401_psp_hw_params(
+		struct bls_builder_declarative_params *params)
+{
+	struct dmub_srv *dmub;
+
+	if (params->dmub_hw_params)
+		return params->dmub_hw_params;
+
+	dmub = params->dc->ctx->dmub_srv->dmub;
+	params->owned_dmub_fb_info = *dmub->fb_info;
+	memset(&params->owned_dmub_hw_params, 0,
+			sizeof(params->owned_dmub_hw_params));
+	params->owned_dmub_hw_params.fb_info = &params->owned_dmub_fb_info;
+	params->owned_dmub_hw_params.soc_fb_info = dmub->soc_fb_info;
+	params->owned_dmub_hw_params.psp_version = dmub->psp_version;
+	return &params->owned_dmub_hw_params;
+}
+
 static inline enum bls_builder_result dcn401_build_psp_reload(
 		struct bls_builder_declarative_params *params,
 		struct block_sequence_state *sequence)
@@ -198,7 +229,7 @@ static inline enum bls_builder_result dcn401_build_psp_reload(
 	bls_params.psp_reload_dmub_fw_params.dmub =
 			params->dc->ctx->dmub_srv->dmub;
 	bls_params.psp_reload_dmub_fw_params.hw_params =
-			params->dmub_hw_params;
+			dcn401_psp_hw_params(params);
 	if (!bls_append(sequence, PSP_RELOAD_DMUB_FW, &bls_params))
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
index 23e3c39a69b7..7b08d4154268 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
@@ -58,10 +58,14 @@ static bool dc2_bls_step_supported(const struct dc2 *dc2,
 				dmub->hw_funcs.is_gpint_acked &&
 				dmub->hw_funcs.get_gpint_response &&
 				step->params.dmub_gpint_params.response;
-	case PSP_RELOAD_DMUB_FW:
+	case PSP_RELOAD_DMUB_FW: {
+		const struct dmub_srv_hw_params *hw_params =
+				step->params.psp_reload_dmub_fw_params.hw_params;
+
 		return step->params.psp_reload_dmub_fw_params.dmub &&
-				step->params.psp_reload_dmub_fw_params.hw_params &&
-				step->params.psp_reload_dmub_fw_params.hw_params->fb_info;
+				hw_params && hw_params->fb_info &&
+				hw_params->fb_info->num_fb >= DMUB_WINDOW_TOTAL;
+	}
 	case DMUB_INITIALIZE_DCN:
 		ctx = step->params.send_dmcub_cmd_params.ctx;
 		if (!ctx || !ctx->dmub_srv || !ctx->dmub_srv->dmub ||
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
index f3d01b14b360..a94c976f067c 100644
--- a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
@@ -40,9 +40,9 @@ void core2_hardware_init(struct dc *dc)
 	out_targets.DCN_DECL_INITIALIZATION = out_init;
 	params->out_targets = &out_targets;
 	/*
-	 * DC does not carry DMUB framebuffer windows. Missing hw_params
-	 * fails the build closed. Execute only a successful build, and
-	 * do not fall back to legacy hwseq.
+	 * The builder copies DMUB windows retained on dmub_srv. Missing
+	 * windows fail the build closed. Execute only a successful build,
+	 * and do not fall back to legacy hwseq.
 	 */
 	result = builder->build.declarative(params);
 	if (result == BLS_BUILD_SUCCESS)
-- 
2.43.0

