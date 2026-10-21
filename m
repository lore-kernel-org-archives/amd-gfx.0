Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F9606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oGsMeI4O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 731B710F962;
	Wed, 21 Oct 2026 06:27:10 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0891B10F957
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:27:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBqHGWTvt+TcAAziOijT/EEzLXuHqqrAA4L6DpEsvfl6Z2aIFOXLH4dyQzCTznIsawW6ag+LpTp/+l8E6NFVlu8k7jMgpVfmcCdWRvitKlh8f0wOl+aU5VM71j82Vx3yKU9AGPfBAiHgsE1J0ITRyXzXQSSt1bvfQhK1J05+9AGxfyt0bbbHbExhMZ/a8fcLVxD3wLEZtX7X5VLmnEF936pMK5Sbg+TwFhAsmmbGorS2KmznB0sMSc+XlE3IBErJioN7BoODwDNhFBwMwJ0ZNBOxce3FwlocY0vIoePVIprwDfVO94VahOgwKPkbz2O3lRESWpfuJx1ZIIpM2j1DxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKer0Q9r2dKLW9hs6xYctPFJM1zyE34Usf8lPgRdpzs=;
 b=EUq/EZtaUfHuIgTswmEn2RPFjIdFIEiAqx0+IMGqgb3/OVlMqM4HUmLnuPLauivR6G5QWwmOn+uzyGK1aFWmswgjYhEqSC3clYDfwXwg13CxVD0KcaDX/D0hD7W6NyJ5EeWOJO95+RKZkpTTbubiHdD85ZOAgyiVSOxTQ7JY9Og8Yq2EgAQO3zWMviIARjT1i3HyRlVq3JVjIZUnuC1Wteu5+6E5GMLbn2NnI4fYTxkCuP4d/6IOY+CaLt7YOGvuxNXm/hhiXlEpRb1db1eJRyImbCex66lbkqPGdqgH4lMbwFXzCdpebnUgnC+vq63bnb5s6AYaGVgrUyjmTYVZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKer0Q9r2dKLW9hs6xYctPFJM1zyE34Usf8lPgRdpzs=;
 b=oGsMeI4Oq6WI8dVb+QkfkG1JAMFgb8gAvMWMWMwx/un5a4h+GBjSS2FGnbw1BsJJQnX2iUj6E78DQ7V0/fQTDWZU64CymFWL1DeUhwfSGAIzsbgWHanyZI+JjZDXoBdcWFM+23Z9nH5rfbJJISbkDsUZShFcEbKNFTgXNKYUoZE=
Received: from DS7PR03CA0064.namprd03.prod.outlook.com (2603:10b6:5:3bb::9) by
 DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Wed, 21 Oct 2026 06:26:59 +0000
Received: from BN1PEPF0001854C.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::34) by DS7PR03CA0064.outlook.office365.com
 (2603:10b6:5:3bb::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:26:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854C.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:58 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:55 -0500
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
Subject: [PATCH 26/49] drm/amd/display: Narrow the DMUB-driven dcn401 init
 builder helpers
Date: Wed, 21 Oct 2026 14:22:32 +0800
Message-ID: <20261021062519.674697-27-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854C:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 74839ca6-56e4-4520-703d-08df2f3c4fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: xNvJCyCmZ+ce61e2NnrObVNw+bS0XK3o8GqKpd2k+6sTjNGZzkIMYry/wYzyv+BmlbiPNCFIB6G3V9YUZwh3SmJUOT58qQ4Y6UjYoZZVvcHCqC6149N6DJHEYm2lDjY8T8JrpJUiaaLUXkKU+FwhbHOAoiE10cKAESBlPDdFHzS5Oeijyv+GMUctoUW5hhPMwpq9Mr+3PruAKyxihWEhYc2UObz+s7/rIG42uoZ7ad0DBX10dEdk4pyofkoiepJ6ffom+zEJxUqPrZREQKQCd5NMJrkheJei8Ci7YaRzgYwqcmIhDoYZoNO9w+IXF+SuVWcWSnH/jo7GGCaInmJ4kl5zNtk23Wb8C/HCtIuJsCbPLaoVkR3aF+kmieaSaqqlCRPKLbNuobsOucuxdfXCPDk1RZy/GcKpaFJ2Dpwo3r/2OlgiwJhRU9tHODattjB/5bHVl3ly/LePX7tcK/HJSGU5W8lY5vIThBpBIHQlIdcn5/EdckCf0ToR/C/aeydnU9xI9y7aXt9mkIHLOSpEUY3IP28JFrnRuDID/sjRK2+uidkyHLxnbw2KtQlCJnFSZeC22iKXlbQDq0y+CUsDbxY1J4Jd+bmtyLSngyzAT60vCjms8HMtF+ccckwGcJUZNXTRbP831pDBp3rvOLRN95qAuffetd4FSLBPV+bW5m6PZEIri534ZJok2Zrun/OTBKiE2uVE4IQni/CPwfpGZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zz6iUq9pUud6k3FW408aogetI9tKpj7uCpCFRzQ8o1u0HSN5YkUSkF2yw/igXGp+xGlOgQGpJpFu6K/L+3dlU36j0HcEdl4rh2xXdK7td7JoQgx6ZBoJlQBAAMagS6489n/qsIAeaWNqIil8xBb12Zh7a+wC4SIEuZXsVOugqATs6deOOlGrlWKsdNMKBkQhjFfxHLH21hsgaULGyBeQqxH+0zGClxtIj/L3wC13xaHWMtpj8p2IUIFtx8sQJho0ufsGsghDYFYlirJLDKeph8WMpUHBQzJIoU+pWyzfQBGYEG/KCFG3HqMBKNzdaosvupghlv7yjF2wPkZ4oBC9t/4wIJVr0SsGBJ6Ot/CxY8JZU4b0jwH3oyDEWKTkuZT5d6RY5a1oWWhYzpUS9qQFvVmVWWFSRkJtiz2g2jHKNviKbh6frRIqllm3bUKqEPIp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:59.1411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74839ca6-56e4-4520-703d-08df2f3c4fb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
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
The next commit, "drm/amd/display: Run DC2_DC1_Wrapped init as staged
BLS builds", adds a second dcn401 initialization builder, for
DC2_DC1_Wrapped, that reuses the clock-manager and DCCG helpers. Today
those helpers take the whole declarative params and reach into
params->dc and the output target themselves. Also, the existing step
list is named dcn401_dc1_init_sequence although it is the
DMUB-driven (DC2_Native) sequence, which will confuse the reader once
a real DC1 sequence sits beside it.

[How]
- Pass dcn401_build_clk_mgr_init, dcn401_build_dc_mode_read and
  dcn401_build_dccg_init the clk_mgr, dccg and out pointer they use.
- Rename dcn401_dc1_init_sequence to dcn401_dc2_init_sequence: a list
  that mirrors DC1 is named dcn401_dc1_*, a DC2-native one
  dcn401_dc2_*.

No functional change: the DMUB-driven build emits the same steps.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../dc/bls_builder/dcn401_init_builder.c      | 40 +++++++++----------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
index 2676ab88b10b..6d96c5244ac9 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_init_builder.c
@@ -12,7 +12,7 @@
 #include "dmub_cmd.h"
 #include "bls_builder/bls_builder_internal.h"
 
-static const enum block_sequence_func dcn401_dc1_init_sequence[] = {
+static const enum block_sequence_func dcn401_dc2_init_sequence[] = {
 	LEGACY_CLK_MGR_INIT_CLOCKS,
 	LEGACY_CLK_MGR_IS_DC_MODE_PRESENT,
 	DCCG_INITIALIZE_CLOCKS,
@@ -137,13 +137,11 @@ static enum bls_builder_result dcn401_validate_initialization_step(
 }
 
 static inline enum bls_builder_result dcn401_build_clk_mgr_init(
-		struct bls_builder_declarative_params *params,
-		struct block_sequence_state *sequence)
+		struct clk_mgr *clk_mgr, struct block_sequence_state *sequence)
 {
 	union block_sequence_params bls_params = {0};
 
-	bls_params.legacy_clk_mgr_init_clocks_params.clk_mgr =
-			params->dc->clk_mgr;
+	bls_params.legacy_clk_mgr_init_clocks_params.clk_mgr = clk_mgr;
 	if (!bls_append(sequence, LEGACY_CLK_MGR_INIT_CLOCKS, &bls_params))
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 
@@ -151,18 +149,15 @@ static inline enum bls_builder_result dcn401_build_clk_mgr_init(
 }
 
 static inline enum bls_builder_result dcn401_build_dc_mode_read(
-		struct bls_builder_declarative_params *params,
+		struct clk_mgr *clk_mgr, bool *out_dcmode_power_limits_present,
 		struct block_sequence_state *sequence)
 {
 	union block_sequence_params bls_params = {0};
-	struct bls_builder_output_init *out_init =
-			params->out_targets->DCN_DECL_INITIALIZATION;
 
-	bls_params.legacy_clk_mgr_is_dc_mode_present_params.clk_mgr =
-			params->dc->clk_mgr;
+	bls_params.legacy_clk_mgr_is_dc_mode_present_params.clk_mgr = clk_mgr;
 	bls_params.legacy_clk_mgr_is_dc_mode_present_params
 			.out_dcmode_power_limits_present =
-			&out_init->dcmode_power_limits_present;
+			out_dcmode_power_limits_present;
 	if (!bls_append(sequence, LEGACY_CLK_MGR_IS_DC_MODE_PRESENT,
 			&bls_params))
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
@@ -171,13 +166,11 @@ static inline enum bls_builder_result dcn401_build_dc_mode_read(
 }
 
 static inline enum bls_builder_result dcn401_build_dccg_init(
-		struct bls_builder_declarative_params *params,
-		struct block_sequence_state *sequence)
+		struct dccg *dccg, struct block_sequence_state *sequence)
 {
 	union block_sequence_params bls_params = {0};
 
-	bls_params.dccg_initialize_clocks_params.dccg =
-			params->dc->res_pool->dccg;
+	bls_params.dccg_initialize_clocks_params.dccg = dccg;
 	if (!bls_append(sequence, DCCG_INITIALIZE_CLOCKS, &bls_params))
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
 
@@ -327,11 +320,14 @@ static enum bls_builder_result dcn401_build_initialization_step(
 {
 	switch (func) {
 	case LEGACY_CLK_MGR_INIT_CLOCKS:
-		return dcn401_build_clk_mgr_init(params, sequence);
+		return dcn401_build_clk_mgr_init(params->dc->clk_mgr, sequence);
 	case LEGACY_CLK_MGR_IS_DC_MODE_PRESENT:
-		return dcn401_build_dc_mode_read(params, sequence);
+		return dcn401_build_dc_mode_read(params->dc->clk_mgr,
+				&params->out_targets->DCN_DECL_INITIALIZATION
+				->dcmode_power_limits_present, sequence);
 	case DCCG_INITIALIZE_CLOCKS:
-		return dcn401_build_dccg_init(params, sequence);
+		return dcn401_build_dccg_init(params->dc->res_pool->dccg,
+				sequence);
 	case DMUB_HALT_FW:
 		return dcn401_build_dmub_halt_fw(params, sequence);
 	case PSP_RELOAD_DMUB_FW:
@@ -369,9 +365,9 @@ static enum bls_builder_result dcn401_build_initialization(
 
 	params->head_num_steps = 0;
 	params->tail_num_steps = 0;
-	for (i = 0; i < ARRAY_SIZE(dcn401_dc1_init_sequence); i++) {
+	for (i = 0; i < ARRAY_SIZE(dcn401_dc2_init_sequence); i++) {
 		result = dcn401_validate_initialization_step(params,
-				dcn401_dc1_init_sequence[i]);
+				dcn401_dc2_init_sequence[i]);
 		if (result != BLS_BUILD_SUCCESS)
 			return result;
 	}
@@ -392,9 +388,9 @@ static enum bls_builder_result dcn401_build_initialization(
 	 * LEGACY/pmfw-msg: preserve the clock-manager entry points until
 	 * PMFW Messenger can express the same calls, order, and output.
 	 */
-	for (i = 0; i < ARRAY_SIZE(dcn401_dc1_init_sequence); i++) {
+	for (i = 0; i < ARRAY_SIZE(dcn401_dc2_init_sequence); i++) {
 		result = dcn401_build_initialization_step(params, &sequence,
-				dcn401_dc1_init_sequence[i]);
+				dcn401_dc2_init_sequence[i]);
 		if (result != BLS_BUILD_SUCCESS)
 			return result;
 	}
-- 
2.43.0

