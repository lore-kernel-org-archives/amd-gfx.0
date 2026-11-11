Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE2F606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hnvXtkiX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E1510F8C4;
	Wed, 11 Nov 2026 01:41:46 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD49010F8BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Slk8tjiHKw4/kXhGSb6F3Kdfm7DdWNBAw7hOU6kZTwXkDE7GKoy0JC8yCZHMuzPbqF5di4oyieYaYReDa6WrHA70a+8+XdalBV9vfCrcFuY/RfYbvy7ve6SolsyhYJlVwfT0HVV6AufmqjspmL/6lyiXBb3IDCGdr4+fVQNWJgNvY+D2oaxXANXYTF1KUosHBsLW+a+2h/Jxk1RaFwI1f0lyr0b2VgDfkALWTEdC7bOWHPQ5lzeEgBP3jCqh7z2lJcDsSCR3E8sHELHOiDIW+rO2NnrgBc4ShZ2ZsXbntsmI/Z/lL6guRkpcq3vpw954Xj88zjalFnX4fdk7Ig9XSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uWicMD+/dsHObLf8sy1+/5Hi9ch3z7ObGeNVXGxH80=;
 b=prc6epOjwDsu/pqMjZFB6jf6edGC/V0vwpGeKhiKUtJISBCg8EwG5mvePpzGMnsrsFzQjIrpwFXjzSFN1my5HBYejuZyZYgNhQMndZAvznMEs+ResMICt5ziHoRWvjGKHdVug8Bi78YNQOwG1Zx4mGp8fUyKtnPxPsyf0AwlV+szw4w+2HqeuPpHdGLkUrG3qVPcylR55EXI73XFNUBBDOHyjyTfoxPctx2ESVvV/X+xJHUjvO//39waQ4WB6JQBs7Oh99jc0gYFIyzVmYmPrGdstiAzq4ec+MJELQ1DYfSvGYoBxBkxnGWDl0i3sgoE4gACQCZeIiDHOAWHPY1pfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uWicMD+/dsHObLf8sy1+/5Hi9ch3z7ObGeNVXGxH80=;
 b=hnvXtkiXw66euGNqEwtH3Xp3S1eTqx0pcoUE0OZls5ndUTtoRIaDcb7jprfC7BiBVGWUIp7PF6/hOvO8coGq4tHk2CGNrT4Jl/uQVtd2PnpTtjQJ49MZbnJ/X47cDeXJh9pvLAPrt4MG6KcSeYq06dLjeJgfW17d7gugOSOua98=
Received: from SJ0PR13CA0081.namprd13.prod.outlook.com (2603:10b6:a03:2c4::26)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:41:33 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::56) by SJ0PR13CA0081.outlook.office365.com
 (2603:10b6:a03:2c4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Wed, 11
 Nov 2026 01:41:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:31 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:28 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Piotr Maziarz <piotr.maziarz@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 18/74] drm/amd/display: Resolve clk_mgr DTBCLK DTO targets
 when the sequence is built
Date: Wed, 11 Nov 2026 09:28:24 +0800
Message-ID: <20261111014100.3596072-19-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: edea2e6b-9ad5-44fc-de3a-08df3f94eac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|22082099003|18002099003|6133799003|20052099010|3023799007|11063799006|56012099006|261028144727099003|261009223027099003|261026140227099003|261102123227099003|261022113327099003|261022105027099003|261021121427099003|261022075727099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: ejEEZ8Bov0Tlgx3SE7HPBWEKIFcwQ19sdUuoaTe63P/7rC9S7SK7K/FOnGbXc/s+RyFRxfvqEGx+xCqoFhWXRLbKrXXIkWiUzOQi979HDYbHBud8oMsee/dxwznD5byDB9RmMsKXUiOTTz/OruqF3ZhlmR9wzVa9yf9SyV3EkTTT2njF87ihVbFwPbJq4zowbTzpgPNyTCiChvsv8Ld6LEkT5iopBTjBNB9rqumsanr2Wo780b3OGrBPoNmOfE4iUV1J8bki2zBxQSxrz8M5apdB7Sm61Q/zuVRvGeLa9YuAwwAcrd7Po2saUDR18TXa5DIzNPD5mBf4fJpcTogJrz545w+UYliX3V6FEZ8w29bEc6mIuX7ZN1mFN98BPn3VnvuBdF+AYj9inVXkBBIeEmBu/MFqEz7kmQuZLjIGdk+sUwZoFB+cFeBRghC+WUi0+iMR5C/LatFgDOdO0BW56MAa2K3tj5CXHGNeUbmaI9mFF/i2WGH/0sXsRQUBeboUfcpSgMIZf+80hYrYxKwZW3bEX/42lWGB8JPD70XmCWDFZb6/z/37cQE/dxq5lsBP0hJPBwUMQffidDybJGIakgXFWzbSxqFTvtg1t7RcX49SuTC9bKrRb4srLnLjtfRASmppWvfS44PXOZ4DtouMg4QaxuiqpBzKtlLrfwTq38/ceEn3VYXriAcmIybEl9ZOu0ZSdTyIku3Nw/jGb9yhsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(20052099010)(3023799007)(11063799006)(56012099006)(261028144727099003)(261009223027099003)(261026140227099003)(261102123227099003)(261022113327099003)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qmnx9Wi2aurXymHrI5yCqepi5ZHOH2EyqClEBzvCtIGdZKFVgSmj1epe/6bygwlTe7CFlKYVeyVrCikLk+1mssU4iuXDqhhsObJdYdVMTo9O5kV/mVq2/5l5/4jvLdlU9rMKA95TK5fD4lbyqy3IZQH+x8OKcBraE5SLWEeX1wrZqo5YaaItbJ+D0458PTt96I2Ww8bYgpx8GBOwoymqgnf+lwnc9hDkNj/i62DfzD3Ax4MpIxIXRrvQ3Z82Sm8/r04odN4R3H/7R5hOuLWzMg/1JEDH7SWaaeKFGX+HIKOGnygbKII5JDwi28xuGttds/c9CkPJCV/amnp0HDK5c4Ynu7Jvd1WbVvFvh3JatUrrQLjmqmp+oP7bUf4LCILhhdQie+LMUQTKtyM83wyLORn1ETguFM0MlOQFeMmo7YtKV5NQlRXpw8NofSgu5K01
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:33.4960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edea2e6b-9ad5-44fc-de3a-08df3f94eac2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Piotr Maziarz <piotr.maziarz@amd.com>

[WHY]
The DTBCLK DTO step of the DCN401 and DCN60 clk_mgr block sequences
keeps a dc_state pointer and, when it executes, walks the state's streams,
looks up each OTG master, decides whether it uses an HPO encoder and reads
its pixel clock parameters. The step also carries an unused pointer to the
reference DTBCLK.

[HOW]
Add clk_mgr_build_dtbclk_dto_target(), which resolves one HPO stream's
clock source, pixel clock parameters, PLL settings and link encoding while
the sequence is built, and clk_mgr_program_dtbclk_dto(), which programs it.
The builders emit one DTBCLK DTO step per HPO stream, and the clk_mgr
sequence capacity grows by MAX_PIPES - 1 to hold them.

The per-ASIC copies of the DTBCLK DTO loop are removed.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 37 +++++++++++++
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 53 +++----------------
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |  9 ++--
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 53 +++----------------
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h  |  6 +--
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  | 16 ++++++
 6 files changed, 73 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index cf1f1c8761c6..28dc3eb3e472 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -144,6 +144,43 @@ void clk_mgr_program_dpp_dto(
 	}
 }
 
+bool clk_mgr_build_dtbclk_dto_target(
+		const struct dc *dc,
+		struct dc_state *context,
+		const struct dc_stream_state *stream,
+		struct clk_mgr_dtbclk_dto_target *target)
+{
+	struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(&context->res_ctx, stream);
+
+	ASSERT(otg_master);
+	if (!otg_master)
+		return false;
+
+	ASSERT(otg_master->clock_source);
+	ASSERT(otg_master->clock_source->funcs->program_pix_clk);
+	ASSERT(otg_master->stream_res.pix_clk_params.controller_id >= CONTROLLER_ID_D0);
+
+	if (!dc->link_srv->dp_is_128b_132b_signal(otg_master) &&
+			!dc_is_hdmi_frl_signal(otg_master->stream->signal))
+		return false;
+
+	if (otg_master->stream_res.pix_clk_params.controller_id <= CONTROLLER_ID_UNDEFINED)
+		return false;
+
+	target->clock_source = otg_master->clock_source;
+	target->pix_clk_params = otg_master->stream_res.pix_clk_params;
+	target->pll_settings = otg_master->pll_settings;
+	target->encoding = dc->link_srv->dp_get_encoding_format(
+			&otg_master->link_config.dp_link_settings);
+	return true;
+}
+
+void clk_mgr_program_dtbclk_dto(struct clk_mgr_dtbclk_dto_target *target)
+{
+	target->clock_source->funcs->program_pix_clk(target->clock_source,
+			&target->pix_clk_params, target->encoding, &target->pll_settings);
+}
+
 void clk_mgr_exit_optimized_pwr_state(const struct dc *dc, struct clk_mgr *clk_mgr)
 {
 	struct dc_link *edp_links[MAX_NUM_EDP];
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index d609f77d5298..0785f70fb535 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -523,43 +523,6 @@ static void dcn401_auto_dpm_test_log(
 	}
 }
 
-static void dcn401_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
-			struct dc_state *context,
-			int ref_dtbclk_khz)
-{
-	(void)ref_dtbclk_khz;
-	int i;
-	struct dccg *dccg = clk_mgr->dccg;
-	struct pipe_ctx *otg_master;
-	bool use_hpo_encoder;
-
-
-	for (i = 0; i < context->stream_count; i++) {
-		otg_master = resource_get_otg_master_for_stream(
-				&context->res_ctx, context->streams[i]);
-		ASSERT(otg_master);
-		if (!otg_master)
-			continue;
-
-		ASSERT(otg_master->clock_source);
-		ASSERT(otg_master->clock_source->funcs->program_pix_clk);
-		ASSERT(otg_master->stream_res.pix_clk_params.controller_id >= CONTROLLER_ID_D0);
-
-		use_hpo_encoder = dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(otg_master);
-		use_hpo_encoder |= dc_is_hdmi_frl_signal(otg_master->stream->signal);
-		if (!use_hpo_encoder)
-			continue;
-
-		if (otg_master->stream_res.pix_clk_params.controller_id > CONTROLLER_ID_UNDEFINED)
-			otg_master->clock_source->funcs->program_pix_clk(
-				otg_master->clock_source,
-				&otg_master->stream_res.pix_clk_params,
-				dccg->ctx->dc->link_srv->dp_get_encoding_format(
-					&otg_master->link_config.dp_link_settings),
-				&otg_master->pll_settings);
-	}
-}
-
 static int dcn401_set_hard_min_by_freq_optimized(struct clk_mgr_internal *clk_mgr, PPCLK_e clk, int requested_clk_khz)
 {
 	if (!clk_mgr->smu_present || !dcn401_is_ppclk_dpm_enabled(clk_mgr, clk))
@@ -710,10 +673,7 @@ static void dcn401_execute_block_sequence(struct clk_mgr *clk_mgr_base, unsigned
 					&params->update_dppclk_dto_params.targets);
 			break;
 		case CLK_MGR401_UPDATE_DTBCLK_DTO:
-			dcn401_update_clocks_update_dtb_dto(
-					clk_mgr_internal,
-					params->update_dtbclk_dto_params.context,
-					*params->update_dtbclk_dto_params.ref_dtbclk_khz);
+			clk_mgr_program_dtbclk_dto(&params->update_dtbclk_dto_params);
 			break;
 		case CLK_MGR401_UPDATE_DENTIST:
 			dcn401_update_clocks_update_dentist(
@@ -1119,10 +1079,13 @@ static unsigned int dcn401_build_update_display_clocks_sequence(
 		num_steps++;
 
 		/* Update DTO in DCCG */
-		block_sequence[num_steps].params.update_dtbclk_dto_params.context = context;
-		block_sequence[num_steps].params.update_dtbclk_dto_params.ref_dtbclk_khz = &clk_mgr_base->clks.ref_dtbclk_khz;
-		block_sequence[num_steps].func = CLK_MGR401_UPDATE_DTBCLK_DTO;
-		num_steps++;
+		for (i = 0; i < context->stream_count; i++) {
+			if (!clk_mgr_build_dtbclk_dto_target(dc, context, context->streams[i],
+					&block_sequence[num_steps].params.update_dtbclk_dto_params))
+				continue;
+			block_sequence[num_steps].func = CLK_MGR401_UPDATE_DTBCLK_DTO;
+			num_steps++;
+		}
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr_base->clks.dppclk_khz)) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
index 7f03a30546a2..a2ba8b665a14 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
@@ -5,7 +5,8 @@
 #ifndef __DCN401_CLK_MGR_H_
 #define __DCN401_CLK_MGR_H_
 
-#define DCN401_CLK_MGR_MAX_SEQUENCE_SIZE 30
+/* Leaves room for a DTBCLK DTO step per stream. */
+#define DCN401_CLK_MGR_MAX_SEQUENCE_SIZE (30 + MAX_PIPES - 1)
 
 union dcn401_clk_mgr_block_sequence_params {
 	struct {
@@ -57,11 +58,7 @@ union dcn401_clk_mgr_block_sequence_params {
 		int *ref_dppclk_khz;
 		struct clk_mgr_dpp_dto_targets targets;
 	} update_dppclk_dto_params;
-	struct {
-		/* inputs */
-		struct dc_state *context;
-		int *ref_dtbclk_khz;
-	} update_dtbclk_dto_params;
+	struct clk_mgr_dtbclk_dto_target update_dtbclk_dto_params;
 	struct {
 		/* inputs */
 		struct dc_state *context;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 6f16bc33b6af..43d1932085b7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -208,43 +208,6 @@ static int dcn60_set_clock_freq_optimized(struct clk_mgr_internal *clk_mgr, PPCL
 	return actual_clk_khz;
 }
 
-static void dcn60_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
-	struct dc_state *context,
-	int ref_dtbclk_khz)
-{
-	(void)ref_dtbclk_khz;
-	int i;
-	struct dccg *dccg = clk_mgr->dccg;
-	struct pipe_ctx *otg_master;
-	bool use_hpo_encoder;
-
-	for (i = 0; i < context->stream_count; i++) {
-		otg_master = resource_get_otg_master_for_stream(
-			&context->res_ctx, context->streams[i]);
-
-		ASSERT(otg_master);
-		if (!otg_master)
-			continue;
-
-		ASSERT(otg_master->clock_source);
-		ASSERT(otg_master->clock_source->funcs->program_pix_clk);
-		ASSERT(otg_master->stream_res.pix_clk_params.controller_id >= CONTROLLER_ID_D0);
-
-		use_hpo_encoder = dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(otg_master);
-		use_hpo_encoder |= dc_is_hdmi_frl_signal(otg_master->stream->signal);
-		if (!use_hpo_encoder)
-			continue;
-
-		if (otg_master->stream_res.pix_clk_params.controller_id > CONTROLLER_ID_UNDEFINED)
-			otg_master->clock_source->funcs->program_pix_clk(
-				otg_master->clock_source,
-				&otg_master->stream_res.pix_clk_params,
-				dccg->ctx->dc->link_srv->dp_get_encoding_format(
-					&otg_master->link_config.dp_link_settings),
-				&otg_master->pll_settings);
-	}
-}
-
 static unsigned int dcn60_build_update_display_clocks_sequence(
 	struct clk_mgr *clk_mgr_base,
 	struct dc_state *context,
@@ -316,10 +279,13 @@ static unsigned int dcn60_build_update_display_clocks_sequence(
 		num_steps++;
 
 		/* Update DTO in DCCG */
-		block_sequence[num_steps].params.update_dtbclk_dto_params.context = context;
-		block_sequence[num_steps].params.update_dtbclk_dto_params.ref_dtbclk_khz = &clk_mgr_base->clks.ref_dtbclk_khz;
-		block_sequence[num_steps].func = CLK_MGR60_UPDATE_DTBCLK_DTO;
-		num_steps++;
+		for (i = 0; i < context->stream_count; i++) {
+			if (!clk_mgr_build_dtbclk_dto_target(dc, context, context->streams[i],
+					&block_sequence[num_steps].params.update_dtbclk_dto_params))
+				continue;
+			block_sequence[num_steps].func = CLK_MGR60_UPDATE_DTBCLK_DTO;
+			num_steps++;
+		}
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr_base->clks.dppclk_khz)) {
@@ -1196,10 +1162,7 @@ static void dcn60_execute_block_sequence(struct clk_mgr *clk_mgr_base, unsigned
 					&params->update_dppclk_dto_params.targets);
 			break;
 		case CLK_MGR60_UPDATE_DTBCLK_DTO:
-			dcn60_update_clocks_update_dtb_dto(
-					clk_mgr_internal,
-					params->update_dtbclk_dto_params.context,
-					*params->update_dtbclk_dto_params.ref_dtbclk_khz);
+			clk_mgr_program_dtbclk_dto(&params->update_dtbclk_dto_params);
 			break;
 		case CLK_MGR60_UPDATE_PSR_WAIT_LOOP:
 			params->update_psr_wait_loop_params.dmcu->funcs->set_psr_wait_loop(
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h
index 6d96ec8440a2..bd61817a5ef9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h
@@ -49,11 +49,7 @@ union dcn60_clk_mgr_block_sequence_params {
 		int *ref_dppclk_khz;
 		struct clk_mgr_dpp_dto_targets targets;
 	} update_dppclk_dto_params;
-	struct {
-		/* inputs */
-		struct dc_state *context;
-		int *ref_dtbclk_khz;
-	} update_dtbclk_dto_params;
+	struct clk_mgr_dtbclk_dto_target update_dtbclk_dto_params;
 	struct {
 		/* inputs */
 		struct dc_state *context;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index c6c087197f82..ff43c1814766 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -624,6 +624,22 @@ void clk_mgr_program_dpp_dto(
 		int ref_dppclk_khz,
 		const struct clk_mgr_dpp_dto_targets *targets);
 
+/* DTBCLK DTO programming of one HPO stream, resolved from dc_state when a clock update is built. */
+struct clk_mgr_dtbclk_dto_target {
+	struct clock_source *clock_source;
+	struct pixel_clk_params pix_clk_params;
+	struct pll_settings pll_settings;
+	enum dp_link_encoding encoding;
+};
+
+bool clk_mgr_build_dtbclk_dto_target(
+		const struct dc *dc,
+		struct dc_state *context,
+		const struct dc_stream_state *stream,
+		struct clk_mgr_dtbclk_dto_target *target);
+
+void clk_mgr_program_dtbclk_dto(struct clk_mgr_dtbclk_dto_target *target);
+
 
 
 #endif //__DAL_CLK_MGR_INTERNAL_H__
-- 
2.43.0

