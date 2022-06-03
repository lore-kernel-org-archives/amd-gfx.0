Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9241CC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA9AB1123DF;
	Fri,  3 Jun 2022 20:12:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 123EC1123D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:12:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/pQYTW6hprO2GNCORIBN/oD09/s9dsj+sIDXTSSDJTjT90SSE8f3QJq1T4bdnmR7l2v1kZaGEqBh/RzHYy4C5AyWL3I/MdlJJALDvkLtVvyUUXpr66M/U8xNh+RfhX3VnjqrxTHnOpb2xddCTq6ZAL9bZAgsQ6UXk3XJtc0ayXvZHC1XCSIALQoZ1hKLQj4LOt4IgYaB4BTNOuhxWs6o1++GA/MjQrVy/BPgTyu9XKnwaYNzsiHzC6w76b0oKE8H7AGqmpph1im9MZg2m5X623XlL0ptRWJmEO3JbQPTykMbfdtXvl88/tA3p8z2Dd7e39tYnUAN5CHbSDPn/ZpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jiLfYAoqU/a3PG9QXjWAg6LPNE/jWgcsxHfpd+xF+8=;
 b=jjXbnZnbhYK4D3aFlZfef6liefr9F6lbOiA96EYEvVPAMYaljeCjVYBtcX8gNZMjmVv8usYeU5KbsGSPUmbBdBp2WwM1GL4r8hbP2vhx8mpKAJ/l9+kr/9csJ2XDDceNmtm7BAqeN+MBE7DRRaj1fjbxPVjJmjyuIyS/HduA86PXP6tzSTaew13USHnSuO1EsHZBOCElZYPsqMI656k2cJgiUadbj8iJDhJi4sP/zaW34mQAMCt1neXH+jTwZekn0o0K20t09EyQobiqkCIEqnhWAkUGHWB9Mbsm9cYawFZyilSjAqJHzAbCb+Gvf3ZPkyIiAW10AhCHWsT6qxqnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jiLfYAoqU/a3PG9QXjWAg6LPNE/jWgcsxHfpd+xF+8=;
 b=ee4tyi1h4pFKXJQIs0DtSvLWu/AeyF6q+pHU5BfUXYPTFZKND75x05ofaJHB8nyGbzn/KI3zcgkGiqbKVZ85lWypzUP/1FrD864FI+d5DKS8jjgMSo8oTowi8l+K1zb+QhAiwpKKsAO8pTYJ75m625I9CjYW54SArPOJYwnRryw=
Received: from DM5PR06CA0074.namprd06.prod.outlook.com (2603:10b6:3:4::12) by
 DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Fri, 3 Jun 2022 20:12:31 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::f8) by DM5PR06CA0074.outlook.office365.com
 (2603:10b6:3:4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Fri, 3 Jun 2022 20:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:12:31 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:29 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/16] Revert "drm/amd/display: Pass the new context into
 disable OTG WA"
Date: Fri, 3 Jun 2022 16:11:34 -0400
Message-ID: <20220603201147.121817-4-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 825d3964-538e-4bd9-5685-08da459d63bf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4563:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4563A0D567D96912937CB268F4A19@DM6PR12MB4563.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QnfIWljQQmGGTXqpqcNQf46CM/R2P97+eOHDws1+JuSFa+Q8I8Vkf4KefsNp0W4NWvf8jSYn6SdXWIOc87BrfvLdiDBpfgnzZhSaGCd43tmhS8IRlvcDplt7Ql/d8MQDE3TvLSmccRxtR7JZzxD+iMfJqkuEbzyGVVYmrnu23YROwKO7v6Zv0iPkqxZBgAWrovK3BMZRpABuH49nIZvfNJcyc7Hea7M/PvgymMssF+VChRulG9hx2OVS1eoeFboEBYL4I4FzSll3qljvJPR1heQOGInC7iZtiE8RFV/jw7DliYchki2JqD4dw7RiTLyCFoEBHxcuuXf+KMLzLiP1TTM34A2F6JemZy8BYUQjlHVbkPIugT4YW/Ow37SY+uxwX4wyqzJDLXd/X214KlBVgCU35lVcsG+gQKBC7D4OBM8vHSzszPY2jAmu6q3WQCtx3SnRIiTCFVUXQ+eFYUDeFlax3vhs5qvCmyCdJkvfgkLt1RwbY4bbRYUSe/qBUHi1P4lMjBiGAAShQKp3YKpLF/vac7p/x12rSI9cqv0zqSgyRvNspW19CseEHNbj42kqe/WLRQYM5zqTHjiB9oet2BZWraXWS8uKwYUvZQews3vOJ+420d5wX12unT6qTackMG74mf2CuahBfBjwdHsbqZgqVyri9h+osWXUeuymkowWJ6oQuWso9NcdmYQhORTzY/hduKw314gS4UjBMEkg2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(2616005)(83380400001)(82310400005)(36860700001)(4326008)(36756003)(6916009)(70206006)(70586007)(40460700003)(316002)(8676002)(47076005)(508600001)(8936002)(6666004)(5660300002)(186003)(336012)(426003)(16526019)(44832011)(86362001)(356005)(2906002)(1076003)(81166007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:12:31.0918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825d3964-538e-4bd9-5685-08da459d63bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

This reverts commit 25b1b4128c75bc9b9cf033425427d085f97439ec.

Causes a hang when hotplugging DP, shutting down system, or
enabling dual eDP.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  | 8 ++++----
 .../drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c    | 8 ++++----
 .../drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c    | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 6a81c1aea0be..bca5f01da763 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -99,13 +99,13 @@ static int dcn31_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn31_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
+static void dcn31_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
@@ -211,11 +211,11 @@ void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn31_disable_otg_wa(clk_mgr_base, context, true);
+		dcn31_disable_otg_wa(clk_mgr_base, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn31_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn31_disable_otg_wa(clk_mgr_base, context, false);
+		dcn31_disable_otg_wa(clk_mgr_base, false);
 
 		update_dispclk = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index aa01a18df419..fb4ae800e919 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -79,13 +79,13 @@ static int dcn315_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn315_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
+static void dcn315_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
@@ -173,11 +173,11 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn315_disable_otg_wa(clk_mgr_base, context, true);
+		dcn315_disable_otg_wa(clk_mgr_base, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn315_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn315_disable_otg_wa(clk_mgr_base, context, false);
+		dcn315_disable_otg_wa(clk_mgr_base, false);
 
 		update_dispclk = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 7192f30858eb..e4bb9c6193b5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -112,13 +112,13 @@ static int dcn316_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn316_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
+static void dcn316_disable_otg_wa(struct clk_mgr *clk_mgr_base, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
@@ -221,11 +221,11 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn316_disable_otg_wa(clk_mgr_base, context, true);
+		dcn316_disable_otg_wa(clk_mgr_base, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn316_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn316_disable_otg_wa(clk_mgr_base, context, false);
+		dcn316_disable_otg_wa(clk_mgr_base, false);
 
 		update_dispclk = true;
 	}
-- 
2.36.1

