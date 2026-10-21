Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78B606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AOthsKrf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D0810F957;
	Wed, 21 Oct 2026 06:27:09 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E0110F956
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:27:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IA8stNTFqU8+M+5uyILNnCD12yNDDWYCcGR4FdqpM4NbJ2ltjR+M0vk/aMbcWu5gvXrEMeqedSjOftD+1dYDdidk5jcvoQsa40KbEMLyKsGHfh0muYbPqbo/hEz5vpqSbofRRMYJBBwiFCbNLo2+AgzyS5MeukKxH9MyxvUdz3QOJOo29FpVG92D4qGJ/6e/R06zkzmG5bqW7nSpJEuVPPfuQJCG1KBds30na82Inz11Alhw5MCj0nxG+txt8L7ynv7Jk8BBZrYAJIJD2khuZcDz1qAXsPnrjWKox6GCt3azi+Q43fXeEzHlJJnt8NGTW1YfPvBtgLO2+tqa/wjL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8zGuRuaGqilPfwiZkhWa6Hyy0h1I7Zwv4OBH34nxy4=;
 b=FBXKgYLlSfuLraw1RMAgZh8JEFecnN61MJ8cCAvbms4V/zEVf0G7zs/nZScNnIeJq/DWVbkmN2qDtxguTcgheFjLHrtwMWJZnDihn28jyAfC2TzbxdHqtRS6KeBFStUx36tbjXmIou/mdjdlRqTnKA+VQSMxTwfZRkTQkaGxfDMQpwrHC2FggFNJhPdgfohfnN6BhiSRhxEDWTvDJlj+rK1gtSz81BzbxAHi/rBNLLaArLsrR0pKPo6maeoBqq/YBdVjPGkg9bXTqqfmCtV47I6w2E0fGL5szgO7ORTpQSVkpQQHILgn0kXEUsjCOGMxfhCukYIaVmOBCU0FRCMSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8zGuRuaGqilPfwiZkhWa6Hyy0h1I7Zwv4OBH34nxy4=;
 b=AOthsKrf8A3GSfHMgpka5o1+p0NSTo3avIt30lV87uyBjbWnyZrwe7EakglpOpKbAzAyH8a9g6tN5ZVBPuRseBSflBTiM8Zu7Xc5F3VU5HqmMdfUx3Sc4RsoPo87dG8xRiPJEO2N3qx5osoo5ldR0wpw0ss0+JDaaITVEfIOSEc=
Received: from BN0PR04CA0032.namprd04.prod.outlook.com (2603:10b6:408:e8::7)
 by PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Wed, 21 Oct
 2026 06:26:57 +0000
Received: from BN1PEPF00018546.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::59) by BN0PR04CA0032.outlook.office365.com
 (2603:10b6:408:e8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:26:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018546.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:54 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:51 -0500
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
Subject: [PATCH 25/49] drm/amd/display: Dispatch the dcn401_init_hw calls from
 the Executor
Date: Wed, 21 Oct 2026 14:22:31 +0800
Message-ID: <20261021062519.674697-26-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018546:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: c1756095-66ea-4b0d-51e0-08df2f3c4e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|6133799003|3023799007|18002099003|22082099003|10067099003|261009221227099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: p3pFAD7iLbRk/tWzEn227tvsAfd8jT12g710TVvWhzUJCh6Dcub8UaWeSemV8tS/AON6UZw22PCp+93zd8XfDU4kSG2aHRWtXliquHFuOwsED8LvRJZyJeQJR6Z76Kiwbt2urYXhvHkWrGP4uLwUYL2D62c9DZDEmQ1++JIobAYR1lntdV6Fgdyd2uMCi27uC1Ayey+NMfqXzKRB6ZaeN74FdkGQLX6si0FqJjYFcxtJUAt3+K8kSACt2oUJw2eDe8PICcFkO1f7mm0QbuUyji9sut9jeyPlrcUL8Jw13yaMfrVvGoZvn+VAqHisAnimw4z+4mD9OaCDl0V6fkNrPcsQV/Zt7GqLU9UQDEJTXEGwSwuqUPfyAQKAuccUiAjv1PQvnn9azDapo9Qa+9BkFw8NbFcF50x0IxiqmVNDTqxKk0gjK39Qv/Ps2Mw3nv619UiaVdZmANh3PFcmJywQ/iblmv6umHioQTu+HGqesFCn3aJf99Q+mgKjP8watMTPpF1hkmPllSWHALuQM50GdgH9u1c70H4niUzV5ads2/DXJ98jrpMaft1uZeErMm8sZH43ysiIATulWcoUjw3ot1n4U9KzkLxyblXNza6WFALTQgs+CEv5r+3MTpGAeLP4nPfwPQMlGIYjE89pTP5kGy53B+rvV58i33GUukdXyS9mWN+X6TlFJBkvQSjoQlxivebtwx/6QBhrNujxWiOqXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(6133799003)(3023799007)(18002099003)(22082099003)(10067099003)(261009221227099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sObrvon+4j/s2/2IbIHVITUsULTAm7eFVhNHuAoZwoS4r9arg2d05MTECjGnYcx1Fwtd86yiUmq76O5CIwo1wE9N9RZbA/v1+2jqbd5kymLEBMM8VjvouzLq/2wC4Y7RYimqE/OIMSXky7CbqH4u5NGqcxSd95olnbgL6B1kQcbg3kSy8eGG2V9T/tI7cFtslNIXFCron+bBTmQ01OzCsh0qQszA8b0BjCPEt6RdTI/f7E9/0F6cB9jJiRDnm3JYM/1wKsKF0d4OTeSyZNeNfCyKKxx8pAAFlcbmSkI+RmvtfRg+/5788rtDRNa6B0WfyZ6d2URUJPph/K8y7BpaMY6g868WK1//uaPyFnEV2dzHC/XCGl0Ld09PLVPWc6HBz6WT9F/sLC+qrjDC4eZGK572zTmGKuD0YgggtwBqbJT5/hrxF0t4Zu51EASzgUqu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:56.6027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1756095-66ea-4b0d-51e0-08df2f3c4e33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018546.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428
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

[Why]
To replay dcn401_init_hw as BLS, the Executor must be able to make
every call dcn401_init_hw makes, each with flat parameters, and with
no decisions of its own. Init also sends DMUB messages that legacy
ignores on failure; the Executor has to support that, not stop.

[How]
hw_sequencer.h:
- Add one params struct per new entry: hwseq register control, ref
  clock reads, link encoder init/DIG/FEC reads, BIOS I2C info and
  accelerated-mode reads, DENTIST dispclk read, eDP backlight and
  power, audio, panel_cntl, ABM, DDC open, gating, HUBBUB init and
  the min-clocks call. Each read takes an out_ pointer.
- Give send_dmcub_cmd_params a continue_on_error flag. Drop its
  feature_caps out-pointer; the caller now owns the reply.

bls_executor.c:
- Check that the target and function of every new entry are present
  before running anything, and dispatch each entry as one call.
- A failed DMUB send with continue_on_error keeps going, and the run
  returns DC2_BLS_EXEC_CONTINUED_ON_ERROR (new) instead of
  DC2_BLS_EXEC_ERROR.
- Stop copying the feature-caps reply into the builder's dmub_abi.
  No caller reads it: core2_hardware_init frees it after execution.

dcn401_init_builder.c: build DMUB sends with a dcn401_add_dmub_cmd
helper, which sets continue_on_error. The feature-caps query keeps
its old parameters, with continue_on_error false.

No Builder emits the new entries yet.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../dc/bls_builder/dcn401_init_builder.c      |  38 +-
 .../display/dc/bls_executor/bls_executor.c    | 557 +++++++++++++++++-
 .../display/dc/bls_executor/bls_executor.h    |   2 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 191 +++++-
 4 files changed, 744 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
index a546ea80803a..2676ab88b10b 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
@@ -255,28 +255,40 @@ static inline enum bls_builder_result dcn401_build_dmub_fw_version(
 	return BLS_BUILD_SUCCESS;
 }
 
-static inline enum bls_builder_result dcn401_build_dmub_feature_caps(
-		struct bls_builder_declarative_params *params,
-		struct block_sequence_state *sequence)
+static bool dcn401_add_dmub_cmd(struct block_sequence_state *sequence,
+		struct dc_context *ctx, union dmub_rb_cmd *cmd,
+		enum dm_dmub_wait_type wait_type, bool continue_on_error)
 {
 	union block_sequence_params bls_params = {0};
-	struct bls_builder_output_init *out_init =
-			params->out_targets->DCN_DECL_INITIALIZATION;
-	union dmub_rb_cmd *cmd = &out_init->dmub_query_feature_caps_cmd;
 
+	bls_params.send_dmcub_cmd_params.ctx = ctx;
+	bls_params.send_dmcub_cmd_params.cmd = cmd;
+	bls_params.send_dmcub_cmd_params.wait_type = wait_type;
+	bls_params.send_dmcub_cmd_params.continue_on_error = continue_on_error;
+	return bls_append(sequence, DMUB_SEND_DMCUB_CMD, &bls_params);
+}
+
+static void dcn401_fill_query_feature_caps_cmd(union dmub_rb_cmd *cmd)
+{
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->query_feature_caps.header.type = DMUB_CMD__QUERY_FEATURE_CAPS;
 	cmd->query_feature_caps.header.sub_type = 0;
 	cmd->query_feature_caps.header.ret_status = 1;
 	cmd->query_feature_caps.header.payload_bytes =
 			sizeof(struct dmub_cmd_query_feature_caps_data);
-	bls_params.send_dmcub_cmd_params.ctx = params->dc->ctx;
-	bls_params.send_dmcub_cmd_params.cmd = cmd;
-	bls_params.send_dmcub_cmd_params.wait_type =
-			DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY;
-	bls_params.send_dmcub_cmd_params.feature_caps =
-			&out_init->dmub_abi.feature_caps;
-	if (!bls_append(sequence, DMUB_SEND_DMCUB_CMD, &bls_params))
+}
+
+static inline enum bls_builder_result dcn401_build_dmub_feature_caps(
+		struct bls_builder_declarative_params *params,
+		struct block_sequence_state *sequence)
+{
+	struct bls_builder_output_init *out_init =
+			params->out_targets->DCN_DECL_INITIALIZATION;
+	union dmub_rb_cmd *cmd = &out_init->dmub_query_feature_caps_cmd;
+
+	dcn401_fill_query_feature_caps_cmd(cmd);
+	if (!dcn401_add_dmub_cmd(sequence, params->dc->ctx, cmd,
+			DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY, false))
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 
 	return BLS_BUILD_SUCCESS;
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
index 7b08d4154268..7600954c3478 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
@@ -10,10 +10,20 @@
 #include "core_types.h"
 #include "dc_dmub_srv.h"
 #include "dmub_cmd.h"
+#include "abm.h"
+#include "audio.h"
+#include "dchubbub.h"
+#include "dio.h"
+#include "link_encoder.h"
+#include "panel_cntl.h"
+#include "link_service.h"
+#include "dc_bios_types.h"
+#include "gpio_service_interface.h"
+#include "hwss/hw_sequencer_private.h"
 #include "bls_executor/bls_executor.h"
 #include "dmub_messenger/dmub_messenger.h"
 
-static bool dc2_bls_step_supported(const struct dc2 *dc2,
+static noinline_for_stack bool dc2_bls_step_supported(const struct dc2 *dc2,
 		const struct block_sequence *step)
 {
 	const struct dc *dc = dc2 ? &dc2->dc : NULL;
@@ -75,12 +85,228 @@ static bool dc2_bls_step_supported(const struct dc2 *dc2,
 				(ctx->dmub_srv->idle_allowed && !ctx->dc))
 			return false;
 		return true;
+	case OPTC_SET_ODM_MEM_POWER: {
+		struct dce_hwseq *hws = step->params.hwseq_reg_control_params.hws;
+
+		return hws && hws->funcs.init_odm_mem_power;
+	}
+	case MMHUBBUB_SET_MEM_POWER: {
+		struct dce_hwseq *hws = step->params.hwseq_reg_control_params.hws;
+
+		return hws && hws->funcs.power_down_vga_mem;
+	}
+	case DCCG_SET_DCFCLK_GATING: {
+		struct dce_hwseq *hws = step->params.hwseq_reg_control_params.hws;
+
+		return hws && hws->funcs.dcfclk_gating_control;
+	}
+	case HPO_SET_HW_CONTROL: {
+		struct dce_hwseq *hws = step->params.hwseq_reg_control_params.hws;
+
+		return hws && hws->funcs.init_hpo_hw_control;
+	}
+	case PG_SET_PLANE_POWER_GATING: {
+		struct dce_hwseq *hws = step->params.hwseq_reg_control_params.hws;
+
+		return hws && hws->funcs.enable_power_gating_plane;
+	}
+	case DCCG_GET_REF_FREQ: {
+		const struct dccg_get_ref_freq_params *p =
+				&step->params.dccg_get_ref_freq_params;
+
+		return p->dccg && p->dccg->funcs &&
+				p->dccg->funcs->get_dccg_ref_freq &&
+				p->out_xtalin_khz && p->out_dccg_ref_khz;
+	}
+	case HUBBUB_GET_DCHUB_REF_FREQ: {
+		const struct hubbub_get_dchub_ref_freq_params *p =
+				&step->params.hubbub_get_dchub_ref_freq_params;
+
+		return p->hubbub && p->hubbub->funcs &&
+				p->hubbub->funcs->get_dchub_ref_freq &&
+				p->out_dchub_ref_khz;
+	}
+	case DIO_LINK_ENC_HW_INIT: {
+		struct link_encoder *enc =
+				step->params.link_enc_hw_init_params.link_enc;
+
+		return enc && enc->funcs && enc->funcs->hw_init;
+	}
+	case DIO_LINK_ENC_IS_DIG_ENABLED: {
+		const struct link_enc_is_dig_enabled_params *p =
+				&step->params.link_enc_is_dig_enabled_params;
+
+		return p->link_enc && p->link_enc->funcs &&
+				p->link_enc->funcs->is_dig_enabled &&
+				p->out_dig_enabled;
+	}
+	case DIO_LINK_ENC_FEC_IS_ACTIVE: {
+		const struct link_enc_fec_is_active_params *p =
+				&step->params.link_enc_fec_is_active_params;
+
+		return p->link_enc && p->link_enc->funcs &&
+				p->link_enc->funcs->fec_is_active &&
+				p->out_fec_active;
+	}
+	case BIOS_GET_I2C_INFO: {
+		const struct bios_get_i2c_info_params *p =
+				&step->params.bios_get_i2c_info_params;
+
+		return p->dcb && p->dcb->funcs && p->dcb->funcs->get_i2c_info &&
+				p->out_info && p->out_result;
+	}
+	case CLK_MGR_GET_DISPCLK_FROM_DENTIST: {
+		const struct clk_mgr_get_dispclk_from_dentist_params *p =
+				&step->params.clk_mgr_get_dispclk_from_dentist_params;
+
+		return p->clk_mgr && p->clk_mgr->funcs &&
+				p->clk_mgr->funcs->get_dispclk_from_dentist &&
+				p->out_dispclk_khz;
+	}
+	case EDP_BACKLIGHT_CONTROL: {
+		struct dc_link *link = step->params.edp_control_params.link;
+
+		return link && link->dc && link->dc->hwss.edp_backlight_control;
+	}
+	case EDP_POWER_CONTROL: {
+		struct dc_link *link = step->params.edp_control_params.link;
+
+		return link && link->dc && link->dc->hwss.edp_power_control;
+	}
+	case LINK_BLANK_ALL_DP_DISPLAYS: {
+		struct dc *init_dc = step->params.dc_init_call_params.dc;
+
+		return init_dc && init_dc->link_srv &&
+				init_dc->link_srv->blank_all_dp_displays;
+	}
+	case HWSS_ENABLE_ACCELERATED_MODE: {
+		struct dc *init_dc = step->params.dc_init_call_params.dc;
+
+		return init_dc && init_dc->hwss.enable_accelerated_mode;
+	}
+	case HWSEQ_INIT_PIPES: {
+		struct dc *init_dc = step->params.dc_init_call_params.dc;
+
+		return init_dc && init_dc->hwseq &&
+				init_dc->hwseq->funcs.init_pipes;
+	}
+	case DMUB_SET_IDLE_OPTIMIZATION:
+		return step->params.dc_init_call_params.dc != NULL;
+	case HWSEQ_POWER_DOWN: {
+		struct dc *init_dc = step->params.dc_init_call_params.dc;
+
+		return init_dc && init_dc->hwseq &&
+				init_dc->hwseq->funcs.power_down;
+	}
+	case HUBBUB_ALLOW_SELF_REFRESH_CONTROL: {
+		struct hubbub *hubbub = step->params
+				.hubbub_allow_self_refresh_control_params.hubbub;
+
+		return hubbub && hubbub->funcs &&
+				hubbub->funcs->allow_self_refresh_control;
+	}
+	case LEGACY_CLK_MGR_INITIALIZE_MIN_CLOCKS: {
+		const struct clk_mgr_initialize_min_clocks_params *p =
+				&step->params.clk_mgr_initialize_min_clocks_params;
+
+		return p->clk_mgr && p->clk_mgr->funcs &&
+				p->clk_mgr->funcs->update_clocks && p->context;
+	}
+	case AUDIO_HW_INIT: {
+		struct audio *audio = step->params.audio_hw_init_params.audio;
+
+		return audio && audio->funcs && audio->funcs->hw_init;
+	}
+	case PANEL_CNTL_HW_INIT: {
+		const struct panel_cntl_hw_init_params *p =
+				&step->params.panel_cntl_hw_init_params;
+
+		return p->panel_cntl && p->panel_cntl->funcs &&
+				p->panel_cntl->funcs->hw_init &&
+				p->out_backlight && p->out_user_level;
+	}
+	case GPIO_DDC_OPEN:
+		return step->params.gpio_ddc_open_params.gpio_service != NULL;
+	case ABM_INIT: {
+		const struct abm_init_params *p = &step->params.abm_init_params;
+
+		return p->abm && p->abm->funcs && p->abm->funcs->abm_init;
+	}
+	case DIO_AFMT_SET_MEM_POWER: {
+		struct dio *dio = step->params.dio_set_mem_power_params.dio;
+
+		return dio && dio->funcs && dio->funcs->mem_pwr_ctrl;
+	}
+	case DCCG_SET_ROOT_CLOCK_GATING: {
+		struct dccg *gating_dccg =
+				step->params.dccg_set_root_clock_gating_params.dccg;
+
+		return gating_dccg && gating_dccg->funcs &&
+				gating_dccg->funcs->allow_clock_gating;
+	}
+	case HUBBUB_INIT_WATERMARKS: {
+		const struct hubbub_init_watermarks_params *p =
+				&step->params.hubbub_init_watermarks_params;
+
+		return p->hubbub && p->hubbub->funcs &&
+				p->hubbub->funcs->init_watermarks;
+	}
+	case BIOS_IS_ACCELERATED_MODE: {
+		const struct bios_is_accelerated_mode_params *p =
+				&step->params.bios_is_accelerated_mode_params;
+
+		return p->dcb && p->dcb->funcs &&
+				p->dcb->funcs->is_accelerated_mode &&
+				p->out_accelerated_mode;
+	}
+	case LEGACY_CLK_MGR_NOTIFY_WM_RANGES:
+		clk_mgr = step->params.clk_mgr_notify_wm_ranges_params.clk_mgr;
+		return clk_mgr && clk_mgr->funcs &&
+				clk_mgr->funcs->notify_wm_ranges;
+	case HUBBUB_INIT_CRB: {
+		struct hubbub *hubbub =
+				step->params.hubbub_init_crb_params.hubbub;
+
+		return hubbub && hubbub->funcs && hubbub->funcs->init_crb;
+	}
+	case HUBBUB_SET_REQUEST_LIMIT: {
+		struct hubbub *hubbub =
+				step->params.hubbub_set_request_limit_params.hubbub;
+
+		return hubbub && hubbub->funcs &&
+				hubbub->funcs->set_request_limit;
+	}
+	case HUBBUB_FORCE_PSTATE_CHANGE_CONTROL: {
+		struct hubbub *hubbub = step->params
+				.hubbub_force_pstate_change_control_params.hubbub;
+
+		return hubbub && hubbub->funcs &&
+				hubbub->funcs->force_pstate_change_control;
+	}
 	default:
 		return false;
 	}
 }
 
-static enum dc2_bls_exec_result dc2_bls_exec_dmub_send(
+static noinline_for_stack void dc2_bls_exec_initialize_min_clocks(
+		const struct clk_mgr_initialize_min_clocks_params *p)
+{
+	struct dc_clocks *clocks = &p->context->bw_ctx.bw.dcn.clk;
+
+	clocks->dcfclk_deep_sleep_khz = p->dcfclk_deep_sleep_khz;
+	clocks->dcfclk_khz = p->dcfclk_khz;
+	clocks->socclk_khz = p->socclk_khz;
+	clocks->dramclk_khz = p->dramclk_khz;
+	clocks->dppclk_khz = p->dppclk_khz;
+	clocks->dispclk_khz = p->dispclk_khz;
+	clocks->ref_dtbclk_khz = p->ref_dtbclk_khz;
+	clocks->fclk_p_state_change_support = p->fclk_p_state_change_support;
+	clocks->p_state_change_support = p->p_state_change_support;
+
+	p->clk_mgr->funcs->update_clocks(p->clk_mgr, p->context, true);
+}
+
+static noinline_for_stack enum dc2_bls_exec_result dc2_bls_exec_dmub_send(
 		const struct block_sequence *entry)
 {
 	struct dmub_messenger messenger;
@@ -97,25 +323,14 @@ static enum dc2_bls_exec_result dc2_bls_exec_dmub_send(
 	dmub_messenger_construct(&messenger, &init_data);
 	if (messenger.funcs->inbox_cmd_send_and_wait(&messenger, &params) !=
 			DMUB_MSG_OK)
-		return DC2_BLS_EXEC_ERROR;
-
-	/*
-	 * The messenger leaves the reply in the builder-owned command.
-	 * Deposit feature caps into the ABI slot the builder named.
-	 */
-	if (entry->params.send_dmcub_cmd_params.feature_caps &&
-			entry->params.send_dmcub_cmd_params.cmd->
-			query_feature_caps.header.ret_status == 0)
-		memcpy(entry->params.send_dmcub_cmd_params.feature_caps,
-				&entry->params.send_dmcub_cmd_params.cmd->
-				query_feature_caps.query_feature_caps_data,
-				sizeof(*entry->params.send_dmcub_cmd_params
-						.feature_caps));
+		return entry->params.send_dmcub_cmd_params.continue_on_error ?
+				DC2_BLS_EXEC_CONTINUED_ON_ERROR :
+				DC2_BLS_EXEC_ERROR;
 
 	return DC2_BLS_EXEC_OK;
 }
 
-static enum dc2_bls_exec_result dc2_bls_exec_dmub_gpint(
+static noinline_for_stack enum dc2_bls_exec_result dc2_bls_exec_dmub_gpint(
 		struct dc2 *dc2, const struct block_sequence *entry)
 {
 	struct dmub_messenger messenger;
@@ -136,7 +351,9 @@ enum dc2_bls_exec_result dc2_bls_execute(
 		const struct block_sequence *steps,
 		unsigned int num_steps)
 {
+	enum dc2_bls_exec_result result = DC2_BLS_EXEC_OK;
 	const struct block_sequence *entry;
+	enum dc2_bls_exec_result sent;
 	unsigned int i;
 
 	if (!steps || num_steps > MAX_HWSS_BLOCK_SEQUENCE_SIZE)
@@ -159,24 +376,26 @@ enum dc2_bls_exec_result dc2_bls_execute(
 					entry->params
 					.legacy_clk_mgr_init_clocks_params.clk_mgr);
 			break;
-		case LEGACY_CLK_MGR_IS_DC_MODE_PRESENT:
-			*entry->params
-					.legacy_clk_mgr_is_dc_mode_present_params
-					.out_dcmode_power_limits_present =
-					entry->params
-					.legacy_clk_mgr_is_dc_mode_present_params
-					.clk_mgr->funcs->is_dc_mode_present(
-					entry->params
-					.legacy_clk_mgr_is_dc_mode_present_params
-					.clk_mgr);
+		case LEGACY_CLK_MGR_IS_DC_MODE_PRESENT: {
+			const struct legacy_clk_mgr_is_dc_mode_present_params *p =
+					&entry->params
+					.legacy_clk_mgr_is_dc_mode_present_params;
+
+			*p->out_dcmode_power_limits_present =
+					p->clk_mgr->funcs->is_dc_mode_present(
+					p->clk_mgr);
 			break;
+		}
 		case DCCG_INITIALIZE_CLOCKS:
 			entry->params.dccg_initialize_clocks_params.dccg->funcs->dccg_init(
 					entry->params.dccg_initialize_clocks_params.dccg);
 			break;
 		case DMUB_SEND_DMCUB_CMD:
-			if (dc2_bls_exec_dmub_send(entry) != DC2_BLS_EXEC_OK)
+			sent = dc2_bls_exec_dmub_send(entry);
+			if (sent == DC2_BLS_EXEC_ERROR)
 				return DC2_BLS_EXEC_ERROR;
+			if (sent == DC2_BLS_EXEC_CONTINUED_ON_ERROR)
+				result = DC2_BLS_EXEC_CONTINUED_ON_ERROR;
 			break;
 		case DMUB_GPINT_SEND_AND_WAIT:
 		case DMUB_HALT_FW:
@@ -194,11 +413,291 @@ enum dc2_bls_exec_result dc2_bls_execute(
 			if (dc2_bls_exec_dmub_send(entry) != DC2_BLS_EXEC_OK)
 				return DC2_BLS_EXEC_ERROR;
 			break;
+		/*
+		 * S-INT/bld-seq: dce_hwseq init functions. Remove when the
+		 * OPTC, MMHUBBUB, DCCG and HPO BLCs expose them.
+		 */
+		case OPTC_SET_ODM_MEM_POWER: {
+			struct dce_hwseq *hws =
+					entry->params.hwseq_reg_control_params.hws;
+
+			hws->funcs.init_odm_mem_power(hws);
+			break;
+		}
+		case MMHUBBUB_SET_MEM_POWER: {
+			struct dce_hwseq *hws =
+					entry->params.hwseq_reg_control_params.hws;
+
+			hws->funcs.power_down_vga_mem(hws);
+			break;
+		}
+		case DCCG_SET_DCFCLK_GATING: {
+			struct dce_hwseq *hws =
+					entry->params.hwseq_reg_control_params.hws;
+
+			hws->funcs.dcfclk_gating_control(hws,
+					entry->params.hwseq_reg_control_params
+					.enable);
+			break;
+		}
+		case HPO_SET_HW_CONTROL: {
+			struct dce_hwseq *hws =
+					entry->params.hwseq_reg_control_params.hws;
+
+			hws->funcs.init_hpo_hw_control(hws,
+					entry->params.hwseq_reg_control_params
+					.enable);
+			break;
+		}
+		case PG_SET_PLANE_POWER_GATING: {
+			struct dce_hwseq *hws =
+					entry->params.hwseq_reg_control_params.hws;
+
+			hws->funcs.enable_power_gating_plane(hws,
+					entry->params.hwseq_reg_control_params
+					.enable);
+			break;
+		}
+		case DCCG_GET_REF_FREQ: {
+			const struct dccg_get_ref_freq_params *p =
+					&entry->params.dccg_get_ref_freq_params;
+
+			*p->out_xtalin_khz = p->xtalin_khz;
+			p->dccg->funcs->get_dccg_ref_freq(p->dccg, p->xtalin_khz,
+					p->out_dccg_ref_khz);
+			break;
+		}
+		case HUBBUB_GET_DCHUB_REF_FREQ: {
+			const struct hubbub_get_dchub_ref_freq_params *p =
+					&entry->params.hubbub_get_dchub_ref_freq_params;
+
+			p->hubbub->funcs->get_dchub_ref_freq(p->hubbub,
+					p->dccg_ref_khz, p->out_dchub_ref_khz);
+			break;
+		}
+		case DIO_LINK_ENC_HW_INIT: {
+			struct link_encoder *enc =
+					entry->params.link_enc_hw_init_params.link_enc;
+
+			enc->funcs->hw_init(enc);
+			break;
+		}
+		case DIO_LINK_ENC_IS_DIG_ENABLED: {
+			const struct link_enc_is_dig_enabled_params *p =
+					&entry->params.link_enc_is_dig_enabled_params;
+
+			*p->out_dig_enabled =
+					p->link_enc->funcs->is_dig_enabled(p->link_enc);
+			break;
+		}
+		case DIO_LINK_ENC_FEC_IS_ACTIVE: {
+			const struct link_enc_fec_is_active_params *p =
+					&entry->params.link_enc_fec_is_active_params;
+
+			*p->out_fec_active =
+					p->link_enc->funcs->fec_is_active(p->link_enc);
+			break;
+		}
+		/*
+		 * S-INT/bld-seq: VBIOS table read through dc_bios. Remove
+		 * when a BLC exposes the DDC GPIO info.
+		 */
+		case BIOS_GET_I2C_INFO: {
+			const struct bios_get_i2c_info_params *p =
+					&entry->params.bios_get_i2c_info_params;
+
+			*p->out_result = p->dcb->funcs->get_i2c_info(p->dcb,
+					p->link_id, p->out_info);
+			break;
+		}
+		/*
+		 * S-INT/link-seq: composite link call. Remove when Link
+		 * builds the blanking through the shared Builder/Executor.
+		 */
+		case LINK_BLANK_ALL_DP_DISPLAYS: {
+			struct dc *init_dc = entry->params.dc_init_call_params.dc;
+
+			init_dc->link_srv->blank_all_dp_displays(init_dc);
+			break;
+		}
+		/*
+		 * S-INT/bld-seq: composite hwseq calls. Remove each when the
+		 * DCN401 BLCs it drives are contract-conformant.
+		 */
+		case HWSS_ENABLE_ACCELERATED_MODE: {
+			struct dc *init_dc = entry->params.dc_init_call_params.dc;
+
+			init_dc->hwss.enable_accelerated_mode(init_dc,
+					init_dc->current_state);
+			break;
+		}
+		case HWSEQ_INIT_PIPES: {
+			struct dc *init_dc = entry->params.dc_init_call_params.dc;
+
+			init_dc->hwseq->funcs.init_pipes(init_dc,
+					init_dc->current_state);
+			break;
+		}
+		case HWSEQ_POWER_DOWN: {
+			struct dc *init_dc = entry->params.dc_init_call_params.dc;
+
+			init_dc->hwseq->funcs.power_down(init_dc);
+			break;
+		}
+		case EDP_BACKLIGHT_CONTROL: {
+			struct dc_link *link = entry->params.edp_control_params.link;
+
+			link->dc->hwss.edp_backlight_control(link,
+					entry->params.edp_control_params.enable);
+			break;
+		}
+		case EDP_POWER_CONTROL: {
+			struct dc_link *link = entry->params.edp_control_params.link;
+
+			link->dc->hwss.edp_power_control(link,
+					entry->params.edp_control_params.enable);
+			break;
+		}
+		case HUBBUB_ALLOW_SELF_REFRESH_CONTROL: {
+			const struct hubbub_allow_self_refresh_control_params *p =
+					&entry->params
+					.hubbub_allow_self_refresh_control_params;
+
+			p->hubbub->funcs->allow_self_refresh_control(p->hubbub,
+					p->allow);
+			break;
+		}
+		/*
+		 * S-INT/pmfw-msg: remove these cases when PMFW Messenger can
+		 * reproduce the same calls, order, and output.
+		 */
+		case CLK_MGR_GET_DISPCLK_FROM_DENTIST: {
+			const struct clk_mgr_get_dispclk_from_dentist_params *p =
+					&entry->params
+					.clk_mgr_get_dispclk_from_dentist_params;
+
+			*p->out_dispclk_khz =
+					p->clk_mgr->funcs->get_dispclk_from_dentist(
+					p->clk_mgr);
+			break;
+		}
+		case LEGACY_CLK_MGR_INITIALIZE_MIN_CLOCKS:
+			dc2_bls_exec_initialize_min_clocks(
+					&entry->params
+					.clk_mgr_initialize_min_clocks_params);
+			break;
+		case LEGACY_CLK_MGR_NOTIFY_WM_RANGES: {
+			struct clk_mgr *wm_clk_mgr = entry->params
+					.clk_mgr_notify_wm_ranges_params.clk_mgr;
+
+			wm_clk_mgr->funcs->notify_wm_ranges(wm_clk_mgr);
+			break;
+		}
+		/*
+		 * S-INT/dmub-msg: composite idle call. Remove when DMUB
+		 * Messenger carries the idle commands.
+		 */
+		case DMUB_SET_IDLE_OPTIMIZATION:
+			dc_allow_idle_optimizations(
+					entry->params.dc_init_call_params.dc,
+					entry->params.dc_init_call_params.enable);
+			break;
+		case AUDIO_HW_INIT: {
+			struct audio *audio =
+					entry->params.audio_hw_init_params.audio;
+
+			audio->funcs->hw_init(audio);
+			break;
+		}
+		case PANEL_CNTL_HW_INIT: {
+			const struct panel_cntl_hw_init_params *p =
+					&entry->params.panel_cntl_hw_init_params;
+
+			*p->out_backlight =
+					p->panel_cntl->funcs->hw_init(p->panel_cntl);
+			*p->out_user_level = p->panel_cntl
+					->stored_backlight_registers.USER_LEVEL;
+			break;
+		}
+		case GPIO_DDC_OPEN: {
+			const struct gpio_ddc_open_params *p =
+					&entry->params.gpio_ddc_open_params;
+
+			dal_gpio_ddc_open_aux_once(p->gpio_service,
+					p->clk_a_register_index, p->clk_a_mask,
+					&p->hw_info);
+			break;
+		}
+		case ABM_INIT: {
+			const struct abm_init_params *p =
+					&entry->params.abm_init_params;
+
+			p->abm->funcs->abm_init(p->abm, p->backlight,
+					p->user_level);
+			break;
+		}
+		case DIO_AFMT_SET_MEM_POWER: {
+			const struct dio_set_mem_power_params *p =
+					&entry->params.dio_set_mem_power_params;
+
+			p->dio->funcs->mem_pwr_ctrl(p->dio, p->enable);
+			break;
+		}
+		case DCCG_SET_ROOT_CLOCK_GATING: {
+			const struct dccg_set_root_clock_gating_params *p =
+					&entry->params.dccg_set_root_clock_gating_params;
+
+			p->dccg->funcs->allow_clock_gating(p->dccg, p->allow);
+			break;
+		}
+		case HUBBUB_INIT_WATERMARKS: {
+			struct hubbub *hubbub = entry->params
+					.hubbub_init_watermarks_params.hubbub;
+
+			hubbub->funcs->init_watermarks(hubbub);
+			break;
+		}
+		/*
+		 * S-INT/bld-seq: VBIOS scratch read through dc_bios. Remove
+		 * when a BLC exposes the accelerated-mode bit.
+		 */
+		case BIOS_IS_ACCELERATED_MODE: {
+			const struct bios_is_accelerated_mode_params *p =
+					&entry->params.bios_is_accelerated_mode_params;
+
+			*p->out_accelerated_mode =
+					p->dcb->funcs->is_accelerated_mode(p->dcb);
+			break;
+		}
+		case HUBBUB_FORCE_PSTATE_CHANGE_CONTROL: {
+			const struct hubbub_force_pstate_change_control_params *p =
+					&entry->params
+					.hubbub_force_pstate_change_control_params;
+
+			p->hubbub->funcs->force_pstate_change_control(p->hubbub,
+					p->enable, p->allow);
+			break;
+		}
+		case HUBBUB_INIT_CRB: {
+			struct hubbub *hubbub =
+					entry->params.hubbub_init_crb_params.hubbub;
+
+			hubbub->funcs->init_crb(hubbub);
+			break;
+		}
+		case HUBBUB_SET_REQUEST_LIMIT: {
+			const struct hubbub_set_request_limit_params *p =
+					&entry->params.hubbub_set_request_limit_params;
+
+			p->hubbub->funcs->set_request_limit(p->hubbub,
+					p->num_chans, p->words_per_umc);
+			break;
+		}
 		default:
 			ASSERT(false);
 			return DC2_BLS_EXEC_ERROR;
 		}
 	}
 
-	return DC2_BLS_EXEC_OK;
+	return result;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h
index 561dabaaa294..d686f03c34c2 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h
@@ -11,6 +11,8 @@
 enum dc2_bls_exec_result {
 	DC2_BLS_EXEC_OK,
 	DC2_BLS_EXEC_ERROR,
+	/* Every step ran; at least one continue-on-error step failed. */
+	DC2_BLS_EXEC_CONTINUED_ON_ERROR,
 };
 
 enum dc2_bls_exec_result dc2_bls_execute(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 7ce6135bb348..f576039161e2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -64,7 +64,6 @@ struct link_training_settings;
 struct dc_link;
 struct dc_crtc_timing;
 struct dmub_srv_hw_params;
-struct dmub_feature_caps;
 
 struct tg_lock_params {
 	struct dc *dc;
@@ -142,7 +141,7 @@ struct send_dmcub_cmd_params {
 	struct dc_context *ctx;
 	union dmub_rb_cmd *cmd;
 	enum dm_dmub_wait_type wait_type;
-	struct dmub_feature_caps *feature_caps;
+	bool continue_on_error;
 };
 
 struct dmub_gpint_params {
@@ -156,6 +155,135 @@ struct psp_reload_dmub_fw_params {
 	const struct dmub_srv_hw_params *hw_params;
 };
 
+struct hwseq_reg_control_params {
+	struct dce_hwseq *hws;
+	bool enable;
+};
+
+struct dc_init_call_params {
+	struct dc *dc;
+	bool enable;
+};
+
+struct dccg_get_ref_freq_params {
+	struct dccg *dccg;
+	unsigned int xtalin_khz;
+	unsigned int *out_xtalin_khz;
+	unsigned int *out_dccg_ref_khz;
+};
+
+struct hubbub_get_dchub_ref_freq_params {
+	struct hubbub *hubbub;
+	unsigned int dccg_ref_khz;
+	unsigned int *out_dchub_ref_khz;
+};
+
+struct link_enc_hw_init_params {
+	struct link_encoder *link_enc;
+};
+
+struct link_enc_is_dig_enabled_params {
+	struct link_encoder *link_enc;
+	bool *out_dig_enabled;
+};
+
+struct link_enc_fec_is_active_params {
+	struct link_encoder *link_enc;
+	bool *out_fec_active;
+};
+
+struct clk_mgr_get_dispclk_from_dentist_params {
+	struct clk_mgr *clk_mgr;
+	int *out_dispclk_khz;
+};
+
+struct edp_control_params {
+	struct dc_link *link;
+	bool enable;
+};
+
+struct bios_get_i2c_info_params {
+	struct dc_bios *dcb;
+	struct graphics_object_id link_id;
+	struct graphics_object_i2c_info *out_info;
+	enum bp_result *out_result;
+};
+
+struct hubbub_allow_self_refresh_control_params {
+	struct hubbub *hubbub;
+	bool allow;
+};
+
+struct audio_hw_init_params {
+	struct audio *audio;
+};
+
+struct panel_cntl_hw_init_params {
+	struct panel_cntl *panel_cntl;
+	uint32_t *out_backlight;
+	uint32_t *out_user_level;
+};
+
+struct gpio_ddc_open_params {
+	struct gpio_service *gpio_service;
+	uint32_t clk_a_register_index;
+	uint32_t clk_a_mask;
+	struct gpio_ddc_hw_info hw_info;
+};
+
+struct abm_init_params {
+	struct abm *abm;
+	uint32_t backlight;
+	uint32_t user_level;
+};
+
+struct dio_set_mem_power_params {
+	struct dio *dio;
+	bool enable;
+};
+
+struct dccg_set_root_clock_gating_params {
+	struct dccg *dccg;
+	bool allow;
+};
+
+struct hubbub_init_watermarks_params {
+	struct hubbub *hubbub;
+};
+
+struct hubbub_init_crb_params {
+	struct hubbub *hubbub;
+};
+
+struct hubbub_set_request_limit_params {
+	struct hubbub *hubbub;
+	unsigned int num_chans;
+	unsigned int words_per_umc;
+};
+
+struct clk_mgr_initialize_min_clocks_params {
+	struct clk_mgr *clk_mgr;
+	struct dc_state *context;
+	int dcfclk_deep_sleep_khz;
+	int dcfclk_khz;
+	int socclk_khz;
+	int dramclk_khz;
+	int dppclk_khz;
+	int dispclk_khz;
+	int ref_dtbclk_khz;
+	bool fclk_p_state_change_support;
+	bool p_state_change_support;
+};
+
+struct clk_mgr_notify_wm_ranges_params {
+	struct clk_mgr *clk_mgr;
+};
+
+struct bios_is_accelerated_mode_params {
+	struct dc_bios *dcb;
+	bool *out_accelerated_mode;
+};
+
 struct lsdma_send_pio_copy_params {
 	struct dc_dmub_srv *dc_dmub_srv;
 	uint64_t src_addr;
@@ -1232,6 +1360,33 @@ union block_sequence_params {
 	struct dccg_initialize_clocks_params dccg_initialize_clocks_params;
 	struct dmub_gpint_params dmub_gpint_params;
 	struct psp_reload_dmub_fw_params psp_reload_dmub_fw_params;
+	struct hwseq_reg_control_params hwseq_reg_control_params;
+	struct dc_init_call_params dc_init_call_params;
+	struct dccg_get_ref_freq_params dccg_get_ref_freq_params;
+	struct hubbub_get_dchub_ref_freq_params hubbub_get_dchub_ref_freq_params;
+	struct link_enc_hw_init_params link_enc_hw_init_params;
+	struct link_enc_is_dig_enabled_params link_enc_is_dig_enabled_params;
+	struct link_enc_fec_is_active_params link_enc_fec_is_active_params;
+	struct clk_mgr_get_dispclk_from_dentist_params
+			clk_mgr_get_dispclk_from_dentist_params;
+	struct edp_control_params edp_control_params;
+	struct bios_get_i2c_info_params bios_get_i2c_info_params;
+	struct hubbub_allow_self_refresh_control_params
+			hubbub_allow_self_refresh_control_params;
+	struct audio_hw_init_params audio_hw_init_params;
+	struct panel_cntl_hw_init_params panel_cntl_hw_init_params;
+	struct gpio_ddc_open_params gpio_ddc_open_params;
+	struct abm_init_params abm_init_params;
+	struct dio_set_mem_power_params dio_set_mem_power_params;
+	struct dccg_set_root_clock_gating_params
+			dccg_set_root_clock_gating_params;
+	struct hubbub_init_watermarks_params hubbub_init_watermarks_params;
+	struct hubbub_init_crb_params hubbub_init_crb_params;
+	struct hubbub_set_request_limit_params hubbub_set_request_limit_params;
+	struct clk_mgr_initialize_min_clocks_params
+			clk_mgr_initialize_min_clocks_params;
+	struct clk_mgr_notify_wm_ranges_params clk_mgr_notify_wm_ranges_params;
+	struct bios_is_accelerated_mode_params bios_is_accelerated_mode_params;
 	struct hubbub_program_watermarks_params hubbub_program_watermarks_params;
 	struct hubbub_program_arbiter_params hubbub_program_arbiter_params;
 	struct hubbub_program_compbuf_segments_params hubbub_program_compbuf_segments_params;
@@ -1409,6 +1564,38 @@ enum block_sequence_func {
 	DMUB_HALT_FW,
 	PSP_RELOAD_DMUB_FW,
 	DMUB_INITIALIZE_DCN,
+	OPTC_SET_ODM_MEM_POWER,
+	MMHUBBUB_SET_MEM_POWER,
+	DCCG_GET_REF_FREQ,
+	HUBBUB_GET_DCHUB_REF_FREQ,
+	DIO_LINK_ENC_HW_INIT,
+	DIO_LINK_ENC_IS_DIG_ENABLED,
+	DIO_LINK_ENC_FEC_IS_ACTIVE,
+	BIOS_GET_I2C_INFO,
+	PG_SET_PLANE_POWER_GATING,
+	LINK_BLANK_ALL_DP_DISPLAYS,
+	HWSS_ENABLE_ACCELERATED_MODE,
+	HWSEQ_INIT_PIPES,
+	HUBBUB_ALLOW_SELF_REFRESH_CONTROL,
+	CLK_MGR_GET_DISPCLK_FROM_DENTIST,
+	LEGACY_CLK_MGR_INITIALIZE_MIN_CLOCKS,
+	DMUB_SET_IDLE_OPTIMIZATION,
+	EDP_BACKLIGHT_CONTROL,
+	HWSEQ_POWER_DOWN,
+	EDP_POWER_CONTROL,
+	AUDIO_HW_INIT,
+	PANEL_CNTL_HW_INIT,
+	GPIO_DDC_OPEN,
+	ABM_INIT,
+	DIO_AFMT_SET_MEM_POWER,
+	DCCG_SET_ROOT_CLOCK_GATING,
+	DCCG_SET_DCFCLK_GATING,
+	HPO_SET_HW_CONTROL,
+	HUBBUB_INIT_WATERMARKS,
+	LEGACY_CLK_MGR_NOTIFY_WM_RANGES,
+	HUBBUB_INIT_CRB,
+	HUBBUB_SET_REQUEST_LIMIT,
+	BIOS_IS_ACCELERATED_MODE,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
-- 
2.43.0

