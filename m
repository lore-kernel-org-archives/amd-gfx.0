Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A544C072A2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3213E10E576;
	Wed, 15 Nov 2023 19:44:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F072C10E1DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Shx2ARNLI1olERrhral1/yyADgDCAwfOGUjseWzZwN8nxvTYJUt8CHX/SFJlt9XJ/bNbvm1LRwhHBQF+yXo5V49tnerOSbIg8AuVgcLluJ3iS2fW3G9GmZzXnOdxFgH9sWljo5dKKUAMLDKewoeH9WnRfOAn/WTWzzdmpASnJDRO5UBQZ4zfsmW+5b59lLWuEtg3CjWb0fSptZIF7TtAqojma1WTS88r4JY25RL1D3luzCHPfrzYK8mwHHd6AejzK5W4uMOSGRGEfIuLxksfpPdvXtkIY5pol2VJBsMOMKKW5sUlWX5sAhrFDwnDqPnSgx9dJlQg1xdejdKtPNBp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcmhALWT5EbgKw4uxa01nYMK24f4B6F5p6k1R4qIXB0=;
 b=L/0sBVd8wmSZoJ1S0R9jJ3Pd9zofV/fsRir7MMuTf+pTeRChDyiUfEyIvTTuAZtx8cgPwKJBKcz/A0F7ZCt91EiS5RNGY33C1YULA/zbDXE4iel2c4aHavej5d/sRfeip59yBjoQfWuiX3Ms5OQeO4qzp5Q+82Y2vajrw89WPqJossrSGayVffBwd+fYMFYQFtM1csqlj3ocueFe4sBia0nMUsU8oEnWmRPKR6SfuI3IGzo03febCqw5td45zDQDwI2Wu5t+I2/J1pFteh7ruwf+ofEbKkgrTxx3/2eWY+MT5j5W9xxCcRxO1FrwQQunsiYwd//RYNmX7YWE7k7pFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcmhALWT5EbgKw4uxa01nYMK24f4B6F5p6k1R4qIXB0=;
 b=LueauWtYrN4q8Fu9GJhb+sdCk1Im/tafmJinZpxbD5DO2rUulqWO25T67dhj4ptH6eQnumDBW+aBSzLy8rOI1MzJvq7IFRAcbLjmAfM4eolHq4NGLHyYWIj9m2JHIsE7CYvRi4EAHW4Ii32t1Dk2HMUIbQ+BYQqMlbi2SNB2Uzk=
Received: from BL1PR13CA0095.namprd13.prod.outlook.com (2603:10b6:208:2b9::10)
 by CH2PR12MB4921.namprd12.prod.outlook.com (2603:10b6:610:62::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.35; Wed, 15 Nov
 2023 19:44:18 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::50) by BL1PR13CA0095.outlook.office365.com
 (2603:10b6:208:2b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:18 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:16 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/35] drm/amd/display: always use mpc factor of 2 for stereo
 timings
Date: Wed, 15 Nov 2023 14:40:21 -0500
Message-ID: <20231115194332.39469-9-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CH2PR12MB4921:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d76b5c3-1284-4f1e-843f-08dbe61341bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1V69/QwcGUsc0QqAubg8d9NFWU9D+BEqyJJTus1ckHTRUJvJLndrGLQscAYylgAqGpkLj45dKy8oJJD9nnfRLLK1VyqHB+e1jUSInmk5W5dJpNgNEA3ePn+oS4bO13bgCNEQs/c/8q8seCQZbkFAoxvkMtHYkL/dS84u7enfxvAoa07YfAdmgb8HeceG636x9ehefXTzh0cRdrbVT2hsutTdBvi+910Ussh4kaLoS75Giq+6q5lJ5Y0/48CHaLd/HcJ5tmTBXbIzL9kNk19P1n9id2japa3uUIXxd/b35f0ODAHgNuAVw7vOUHrzwxS2gn12qGrrJ165i6ghIcRL9wJoOu6wA9k9ZJ2D5kE/SDXEKZnURnJ6hv68g4ajvHw4cY5pQiHbDXnUYCrFXH1Q/7/jmmsGryHTCHAKZH0PPbjyTfRQEG+Vx/fPl+yZnpLanZG32N5HXviA0SnfaMdaMy9lZtEdx3mTy1qloahRH9GDCnpECfaJ0aCRLugVrsKqLd8hNFsDaLMNF5xAEeFdEs7MB0fOTvOzRts9b48i4TGks59nJ8QQ1+n+Evmk7psla1hYA/BsPbqzZWG7fj5bhvjp3FlO2HNZ9VUXB/R7jZgBqLM5Y7O9ql13E+i827jQRAXyrxQdYpGcGWYjX5k26eCClgrRaybLF+dZlJUaM4taqeg1ZYWBDHLViXyeI9CJkW+LhyQYxe/9fmoaeKVBLtOahzIwkjSLKB8JwP0BgKjlbKl4iXAP8J8zOfJiPFGNGylBpAZWCBG8sCIC9XGcv+7yjiG0TmIP3QqL1GOF0JaRySIxWfawyXOhtablb/L
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(40470700004)(46966006)(36840700001)(86362001)(47076005)(5660300002)(44832011)(36860700001)(81166007)(356005)(316002)(36756003)(6916009)(70586007)(70206006)(4326008)(8676002)(8936002)(54906003)(40480700001)(41300700001)(2906002)(336012)(426003)(40460700003)(83380400001)(26005)(16526019)(2616005)(1076003)(82740400003)(6666004)(478600001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:18.4163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d76b5c3-1284-4f1e-843f-08dbe61341bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4921
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
In the new pipe resource management logic, the special handling for
stereo timings is missing.
This commit implements the same stereo timings handling as old
pipe resource management code.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 26 +++++++++++++------
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |  2 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.h  |  2 +-
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 1a2b24cc6b61..0baf39d64a2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -772,18 +772,29 @@ static unsigned int get_mpc_factor(struct dml2_context *ctx,
 		const struct dc_state *state,
 		const struct dml_display_cfg_st *disp_cfg,
 		struct dml2_dml_to_dc_pipe_mapping *mapping,
-		const struct dc_stream_status *status, unsigned int stream_id,
+		const struct dc_stream_status *status,
+		const struct dc_stream_state *stream,
 		int plane_idx)
 {
 	unsigned int plane_id;
 	unsigned int cfg_idx;
+	unsigned int mpc_factor;
 
-	get_plane_id(ctx, state, status->plane_states[plane_idx], stream_id, plane_idx, &plane_id);
+	get_plane_id(ctx, state, status->plane_states[plane_idx],
+			stream->stream_id, plane_idx, &plane_id);
 	cfg_idx = find_disp_cfg_idx_by_plane_id(mapping, plane_id);
-	if (ctx->architecture == dml2_architecture_20)
-		return (unsigned int)disp_cfg->hw.DPPPerSurface[cfg_idx];
-	ASSERT(false);
-	return 1;
+	if (ctx->architecture == dml2_architecture_20) {
+		mpc_factor = (unsigned int)disp_cfg->hw.DPPPerSurface[cfg_idx];
+	} else {
+		mpc_factor = 1;
+		ASSERT(false);
+	}
+
+	/* For stereo timings, we need to pipe split */
+	if (dml2_is_stereo_timing(stream))
+		mpc_factor = 2;
+
+	return mpc_factor;
 }
 
 static unsigned int get_odm_factor(
@@ -820,14 +831,13 @@ static void populate_mpc_factors_for_stream(
 		unsigned int mpc_factors[MAX_PIPES])
 {
 	const struct dc_stream_status *status = &state->stream_status[stream_idx];
-	unsigned int stream_id = state->streams[stream_idx]->stream_id;
 	int i;
 
 	for (i = 0; i < status->plane_count; i++)
 		if (odm_factor == 1)
 			mpc_factors[i] = get_mpc_factor(
 					ctx, state, disp_cfg, mapping, status,
-					stream_id, i);
+					state->streams[stream_idx], i);
 		else
 			mpc_factors[i] = 1;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 2498b8341199..33eab80e89a8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -468,7 +468,7 @@ bool dml2_verify_det_buffer_configuration(struct dml2_context *in_ctx, struct dc
 	return need_recalculation;
 }
 
-bool dml2_is_stereo_timing(struct dc_stream_state *stream)
+bool dml2_is_stereo_timing(const struct dc_stream_state *stream)
 {
 	bool is_stereo = false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.h
index 23b9028337d4..5842d6d3c4b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.h
@@ -42,7 +42,7 @@ void dml2_copy_clocks_to_dc_state(struct dml2_dcn_clocks *out_clks, struct dc_st
 void dml2_extract_watermark_set(struct dcn_watermarks *watermark, struct display_mode_lib_st *dml_core_ctx);
 int dml2_helper_find_dml_pipe_idx_by_stream_id(struct dml2_context *ctx, unsigned int stream_id);
 bool is_dtbclk_required(const struct dc *dc, struct dc_state *context);
-bool dml2_is_stereo_timing(struct dc_stream_state *stream);
+bool dml2_is_stereo_timing(const struct dc_stream_state *stream);
 
 /*
  * dml2_dc_construct_pipes - This function will determine if we need additional pipes based
-- 
2.42.0

