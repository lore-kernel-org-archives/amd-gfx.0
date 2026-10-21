Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A6D606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UKQ7JVdU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CFAD10F8EE;
	Wed, 21 Oct 2026 06:25:40 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9DC10F8EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:25:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMg9eB2K+zUI0fZffIfaM+mWToXUZTfBqkeMiQy7G1fniaMdY8z4wzWdSE6AuFWewnju8RyUPvBnbfJmUSKDrd7hRrRbg6+wKcsKyvvQsRb50U8oQuJAoNScmkpmcYUVsh4JBWSmQegHPhQKVzUYbAsfA/NW+eoJV30s/QNfOA61xR6PLOEJCOWAGETzIB7+3LvoWU1/5c10n43wzV/zPQhl7STulugTE1zusUV8dllugBkkhaBGhQWfqQUPQ6jjKvOHDq4/wo/Jfbv9NHPrMtVKEATKzodQz8weItRAdlE020GmyNmj+Vmoh/JWp6vaCI6/3eIDuehuF/QYk14b+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/cAeEYdp2wg7EPBhOA+2B5a7q99qv1Fr4wEwKWEy5g=;
 b=KxSEbSMzX8fnq2yhb4EUWW5NgvR8dV35slPcOo7jKBsvkiANZHABpb4Wtab2OKfFxEYJkJZgAfOj4JqYzJW3ooDujo71vybVc3fqJRYGicFpxGiwH2qYiRyTJB8krhDGQIUt1d4QSI2CPFjNynsFmUx2JjXuYdLA9asUce+hWp+qE/sUaIwCAN7tlGIUUyJAfi/iy5N32j0vaFmSeCGoGp9MlVyYYLvFPwOn8/yO8BJO5Wj8Ms65+K0zhhoPrGNhxLp3qfGnG4jDaVWW9EgEnLerF7EjtfMh6xF9b/1P9Jvcwm5eURdXaBBQ9PE6R0OFicGh/JiCpWaEMt5FubRk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/cAeEYdp2wg7EPBhOA+2B5a7q99qv1Fr4wEwKWEy5g=;
 b=UKQ7JVdUu8O8Gf9Wm/VgimeDj29m9sDvJjnir9GvmCRhAGrMUUXimka6BikX5+QWjXJadFC/WmFmdSh7FPChuOCl2D/KlVHxymwFxUErq3YJPx9SIlsQjiqwN4YIW32g1dsNl84Lle1bWwKXIpZAVU92baqYYXNhuddYrbqjj74=
Received: from BN9PR03CA0430.namprd03.prod.outlook.com (2603:10b6:408:113::15)
 by DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 06:25:28 +0000
Received: from BN1PEPF00018545.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::9b) by BN9PR03CA0430.outlook.office365.com
 (2603:10b6:408:113::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:25:28 +0000
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
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:25:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:25:27 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:25:23 -0500
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
Subject: [PATCH 02/49] drm/amd/display: Scaffold Core2 BLS builder and executor
Date: Wed, 21 Oct 2026 14:22:08 +0800
Message-ID: <20261021062519.674697-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018545:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c3dc6e-1df5-44db-9af6-08df2f3c1943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|56012099006|11063799006|261009223027099003|5023799004|261009221227099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: CIjDzJtQExhrCcuU6f2W+elGR0mByoLaHepU4dJpLeOR4kvVWOtyXZBtv31dqRC7JJC90vXkGfq/DWz30BPEFfURWbmYcuN2XnkZj97XfVrOp0T0f4WtL8jQroX8HY3GjEoyDHzKGxmvWk87GLs5TW4O2poMbWhj7C5Gn+QXAEiNLFET822N7sKQkN34gZgS9wEDxdatOPgwl+/vCFyHlJhy5OJJa+dUNbkzhNtiMxmp/iqtMWCXkDvB+4wBAlYkApSvUq2MWtG2/PKeu92F+1XHnNAuK3PPRSCcewmQz34MVRMUM2plq8WjGLB4b0Efqu8YKL/r5ATdpndbWoSreVHY1XjXjk+PMbzIil/cJ4XKfB061k5zyRN7/NCrxpwHFJ2ZyCQI1NKyqFllAfrEBHgoqWSgvTIHoMsl8SYQuABjl2GBWlR0jV2nnrn481b4NjHbwvDkjH/ixhSLdTKwWE00Q/Pw3oXv6e4h9XSXTu4f1xkJhva9Go47Dp+m58TVRtYECZoFiWQLu30aCbJ8cfcXWP4Fr6QfFHCguLzqZVP7NaRx1F+38nthhE8RPQgw5HtWNVO/RDaoO4+PEpTsDLszOSMJMRfkkEv9EtkPmWnQ6nWicLeo3gRXB9DFTsjhYSOvZ+JYKeZyjgaSeWqeTxUROOWKa7DxxweNjFWedqz3NW7sDaffm2jLsZlj0Kmd+4j1GRXGbotJaZzHeQMhJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(11063799006)(261009223027099003)(5023799004)(261009221227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ewcazWy4HhUhPKb+GQznHyd/feZHE1LQ9Ahb3gOYcAfD02MG96kEaVPoz4zOQj/AQ8ymGsVAmCeZK8C9WLi7Sb35MKxdzOZaCWLtPyi+aS1FstL/M1xC0EOtjROuWOetrpnUbcyDQGsqUja6WwpN93+tTJt2u2EdwufV9sKlJzsLUpHkiukIDeqxHoPnmqulwBKQQJ15RGgpgB7vJ0W+xC/7h1rMx5POtPK04ZDwR744OLlYAZyM0Mfyz/wIMkQUu3GXKWkHi/ODQLJGPvVBQb08LM8MfRMh5R6P6HUdKdURvUQZnqeNIeQHk+WsF5R3enAzsVeyF6C+YOcRnJtfzBPrcg3xzY/lOSWCm26RLC/WqedyVdvdlYQaDomDtjpZ8WJrq2g5kEuzgo7ADta2N0NI/47yBneDGkJAL13MaVsATfylDDf9xpMga/7/i2Ao
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:25:27.7870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c3dc6e-1df5-44db-9af6-08df2f3c1943
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018545.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925
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
This is builder/executor scaffolding, not a live init path. The
legacy hwseq is still in use; switching onto this sequence would
not pass.

How:
Keep an explicit dcn401_dc1_init_sequence, validate callbacks inline,
then populate LEGACY_CLK_MGR_* and DCCG_INITIALIZE_CLOCKS. The
completed walk still returns UNSUPPORTED so the scaffold cannot be
treated as working init.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/dc/bls_builder/bls_builder.h  |   1 +
 .../dc/bls_builder/dcn401_init_builder.c      | 145 ++++++++++++++++--
 .../display/dc/bls_executor/bls_executor.c    |  36 +++++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  15 ++
 4 files changed, 182 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
index 61952f8b95b6..d7de73d1d3d2 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder.h
@@ -38,6 +38,7 @@ struct bls_builder_output_init {
 	unsigned int dchub_ref_clock_inKhz;
 	unsigned int dchub_ref_clock_inKhz_before;
 	unsigned int backlight;
+	bool dcmode_power_limits_present;
 	struct dmub_abi dmub_abi;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
index 42a648b8c065..802cd42f254e 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
@@ -5,9 +5,17 @@
 
 #include "dm_services.h"
 #include "core_types.h"
+#include "clk_mgr.h"
+#include "dccg.h"
 #include "resource.h"
 #include "bls_builder/bls_builder_internal.h"
 
+static const enum block_sequence_func dcn401_dc1_init_sequence[] = {
+	LEGACY_CLK_MGR_INIT_CLOCKS,
+	LEGACY_CLK_MGR_IS_DC_MODE_PRESENT,
+	DCCG_INITIALIZE_CLOCKS,
+};
+
 static bool bls_append(struct block_sequence_state *sequence,
 		enum block_sequence_func func,
 		const union block_sequence_params *params)
@@ -50,14 +58,111 @@ static bool dcn401_initialization_check_capability(
 			BLS_BUILD_SUCCESS;
 }
 
+static enum bls_builder_result dcn401_validate_initialization_step(
+		const struct bls_builder_declarative_params *params,
+		enum block_sequence_func func)
+{
+	struct bls_builder_output_init *out_init = NULL;
+	struct clk_mgr *clk_mgr = params->dc->clk_mgr;
+	struct dccg *dccg = params->dc->res_pool->dccg;
+
+	if (params->out_targets)
+		out_init = params->out_targets->DCN_DECL_INITIALIZATION;
+
+	switch (func) {
+	case LEGACY_CLK_MGR_INIT_CLOCKS:
+		if (!clk_mgr || !clk_mgr->funcs ||
+				!clk_mgr->funcs->init_clocks)
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+		return BLS_BUILD_SUCCESS;
+	case LEGACY_CLK_MGR_IS_DC_MODE_PRESENT:
+		if (!clk_mgr || !clk_mgr->funcs ||
+				!clk_mgr->funcs->is_dc_mode_present ||
+				!out_init)
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+		return BLS_BUILD_SUCCESS;
+	case DCCG_INITIALIZE_CLOCKS:
+		if (!dccg->funcs || !dccg->funcs->dccg_init)
+			return BLS_BUILD_ERROR_RESOURCE_MAPPING;
+		return BLS_BUILD_SUCCESS;
+	default:
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+	}
+}
+
+static inline enum bls_builder_result dcn401_build_clk_mgr_init(
+		struct bls_builder_declarative_params *params,
+		struct block_sequence_state *sequence)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.legacy_clk_mgr_init_clocks_params.clk_mgr =
+			params->dc->clk_mgr;
+	if (!bls_append(sequence, LEGACY_CLK_MGR_INIT_CLOCKS, &bls_params))
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static inline enum bls_builder_result dcn401_build_dc_mode_read(
+		struct bls_builder_declarative_params *params,
+		struct block_sequence_state *sequence)
+{
+	union block_sequence_params bls_params = {0};
+	struct bls_builder_output_init *out_init =
+			params->out_targets->DCN_DECL_INITIALIZATION;
+
+	bls_params.legacy_clk_mgr_is_dc_mode_present_params.clk_mgr =
+			params->dc->clk_mgr;
+	bls_params.legacy_clk_mgr_is_dc_mode_present_params
+			.out_dcmode_power_limits_present =
+			&out_init->dcmode_power_limits_present;
+	if (!bls_append(sequence, LEGACY_CLK_MGR_IS_DC_MODE_PRESENT,
+			&bls_params))
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static inline enum bls_builder_result dcn401_build_dccg_init(
+		struct bls_builder_declarative_params *params,
+		struct block_sequence_state *sequence)
+{
+	union block_sequence_params bls_params = {0};
+
+	bls_params.dccg_initialize_clocks_params.dccg =
+			params->dc->res_pool->dccg;
+	if (!bls_append(sequence, DCCG_INITIALIZE_CLOCKS, &bls_params))
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+
+	return BLS_BUILD_SUCCESS;
+}
+
+static enum bls_builder_result dcn401_build_initialization_step(
+		struct bls_builder_declarative_params *params,
+		struct block_sequence_state *sequence,
+		enum block_sequence_func func)
+{
+	switch (func) {
+	case LEGACY_CLK_MGR_INIT_CLOCKS:
+		return dcn401_build_clk_mgr_init(params, sequence);
+	case LEGACY_CLK_MGR_IS_DC_MODE_PRESENT:
+		return dcn401_build_dc_mode_read(params, sequence);
+	case DCCG_INITIALIZE_CLOCKS:
+		return dcn401_build_dccg_init(params, sequence);
+	default:
+		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+	}
+}
+
 static enum bls_builder_result dcn401_build_initialization(
 		struct bls_builder_declarative_params *params)
 {
 	struct bls_builder_check_capability_params check_params = {0};
-	enum bls_builder_result support_result;
+	enum bls_builder_result result;
 	struct block_sequence_state sequence;
-	union block_sequence_params bls_params = {0};
-	struct dc *dc;
+	struct bls_builder_output_init *out_init = NULL;
+	unsigned int i;
 
 	if (!params)
 		return dcn401_check_initialization_support(NULL);
@@ -65,27 +170,37 @@ static enum bls_builder_result dcn401_build_initialization(
 	check_params.dc = params->dc;
 	check_params.current_state = params->current_state;
 	check_params.new_state = params->new_state;
-	support_result =
+	result =
 			dcn401_check_initialization_support(&check_params);
-	if (support_result != BLS_BUILD_SUCCESS)
-		return support_result;
+	if (result != BLS_BUILD_SUCCESS)
+		return result;
 
-	dc = params->dc;
 	params->head_num_steps = 0;
 	params->tail_num_steps = 0;
+	for (i = 0; i < ARRAY_SIZE(dcn401_dc1_init_sequence); i++) {
+		result = dcn401_validate_initialization_step(params,
+				dcn401_dc1_init_sequence[i]);
+		if (result != BLS_BUILD_SUCCESS)
+			return result;
+	}
+
 	sequence.steps = params->head_sequence;
 	sequence.num_steps = &params->head_num_steps;
+	if (params->out_targets)
+		out_init = params->out_targets->DCN_DECL_INITIALIZATION;
+	if (out_init)
+		out_init->dcmode_power_limits_present = false;
 
 	/*
-	 * Add only operations with explicit component dispatch today. Core will
-	 * not execute or commit ownership until the fixed four-entry DCN
-	 * initialization sequence is available.
+	 * LEGACY/pmfw-msg: preserve the clock-manager entry points until
+	 * PMFW Messenger can express the same calls, order, and output.
 	 */
-	bls_params.dccg_initialize_clocks_params.dccg =
-			dc->res_pool->dccg;
-	if (!bls_append(&sequence, DCCG_INITIALIZE_CLOCKS,
-			&bls_params))
-		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
+	for (i = 0; i < ARRAY_SIZE(dcn401_dc1_init_sequence); i++) {
+		result = dcn401_build_initialization_step(params, &sequence,
+				dcn401_dc1_init_sequence[i]);
+		if (result != BLS_BUILD_SUCCESS)
+			return result;
+	}
 
 	return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
index d1bb951e47ae..b1425f8ca73c 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
@@ -5,14 +5,29 @@
  */
 
 #include "dm_services.h"
+#include "clk_mgr.h"
 #include "dccg.h"
 #include "bls_executor/bls_executor.h"
 
 static bool dc2_bls_step_supported(const struct block_sequence *step)
 {
+	struct clk_mgr *clk_mgr;
 	struct dccg *dccg;
 
 	switch (step->func) {
+	case LEGACY_CLK_MGR_INIT_CLOCKS:
+		clk_mgr =
+				step->params.legacy_clk_mgr_init_clocks_params.clk_mgr;
+		return clk_mgr && clk_mgr->funcs &&
+				clk_mgr->funcs->init_clocks;
+	case LEGACY_CLK_MGR_IS_DC_MODE_PRESENT:
+		clk_mgr = step->params
+				.legacy_clk_mgr_is_dc_mode_present_params.clk_mgr;
+		return clk_mgr && clk_mgr->funcs &&
+				clk_mgr->funcs->is_dc_mode_present &&
+				step->params
+				.legacy_clk_mgr_is_dc_mode_present_params
+				.out_dcmode_power_limits_present;
 	case DCCG_INITIALIZE_CLOCKS:
 		dccg = step->params.dccg_initialize_clocks_params.dccg;
 		return dccg && dccg->funcs && dccg->funcs->dccg_init;
@@ -38,6 +53,27 @@ enum dc2_bls_exec_result dc2_bls_execute(
 	for (i = 0; i < num_steps; i++) {
 		entry = &steps[i];
 		switch (entry->func) {
+		/*
+		 * LEGACY/pmfw-msg: remove both cases when PMFW Messenger can
+		 * reproduce the same calls, order, and output.
+		 */
+		case LEGACY_CLK_MGR_INIT_CLOCKS:
+			entry->params.legacy_clk_mgr_init_clocks_params
+					.clk_mgr->funcs->init_clocks(
+					entry->params
+					.legacy_clk_mgr_init_clocks_params.clk_mgr);
+			break;
+		case LEGACY_CLK_MGR_IS_DC_MODE_PRESENT:
+			*entry->params
+					.legacy_clk_mgr_is_dc_mode_present_params
+					.out_dcmode_power_limits_present =
+					entry->params
+					.legacy_clk_mgr_is_dc_mode_present_params
+					.clk_mgr->funcs->is_dc_mode_present(
+					entry->params
+					.legacy_clk_mgr_is_dc_mode_present_params
+					.clk_mgr);
+			break;
 		case DCCG_INITIALIZE_CLOCKS:
 			entry->params.dccg_initialize_clocks_params.dccg->funcs->dccg_init(
 					entry->params.dccg_initialize_clocks_params.dccg);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 48ccbc3b1240..24e438202ba0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1003,6 +1003,15 @@ struct clk_mgr_update_clocks_params {
 	struct clk_mgr *clk_mgr;
 };
 
+struct legacy_clk_mgr_init_clocks_params {
+	struct clk_mgr *clk_mgr;
+};
+
+struct legacy_clk_mgr_is_dc_mode_present_params {
+	struct clk_mgr *clk_mgr;
+	bool *out_dcmode_power_limits_present;
+};
+
 struct dccg_initialize_clocks_params {
 	struct dccg *dccg;
 };
@@ -1202,6 +1211,10 @@ union block_sequence_params {
 	struct link_set_dpms_on_params link_set_dpms_on_params;
 	struct clk_mgr_set_max_memclk_params clk_mgr_set_max_memclk_params;
 	struct clk_mgr_update_clocks_params clk_mgr_update_clocks_params;
+	struct legacy_clk_mgr_init_clocks_params
+			legacy_clk_mgr_init_clocks_params;
+	struct legacy_clk_mgr_is_dc_mode_present_params
+			legacy_clk_mgr_is_dc_mode_present_params;
 	struct dccg_initialize_clocks_params dccg_initialize_clocks_params;
 	struct hubbub_program_watermarks_params hubbub_program_watermarks_params;
 	struct hubbub_program_arbiter_params hubbub_program_arbiter_params;
@@ -1373,6 +1386,8 @@ enum block_sequence_func {
 	HUBBUB_PERFMON_GET_URGENT_ASSERTION_COUNT,
 	HUBBUB_PERFMON_GET_PREFETCH_DATA_SIZE,
 	HUBBUB_PERFMON_GET_URGENT_RAMP_LATENCY,
+	LEGACY_CLK_MGR_INIT_CLOCKS,
+	LEGACY_CLK_MGR_IS_DC_MODE_PRESENT,
 	DCCG_INITIALIZE_CLOCKS,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
-- 
2.43.0

