Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7312C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 09:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C7010E9A5;
	Fri, 10 Mar 2023 09:32:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28BF310E9A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 09:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdKZQcRYD3oZTwlIvFy6fO2QrZCJ5eSOJsilGWMzo4Bg1WhGQHAeTcEx9MB2HJGp4ts+PiBA0JF6mVR1wSnttkM7fNp4GCq3AxrmNyXA+UQjoK3TWUkTygGxbNwd3f2LFyV1IOEv1WvsGVGybVpJNSw4vp1Lvqdt21xGO6JQYL+6JUp7yOnco9dyFuXHbWYXJbfg0SucPf4O8zx3GASR/dELMKLmynL5r8AGQnksyI6xSaUJeLfLXkQ24FDPitPjHuMBU+ybyYn144/RxRuVhYfn3ayOgNxpO2dlMXoGNQ0jMTPjbrz7SbQK57naCjNemwpqlLKvdA3jAI+0eFiQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIDC55WVurkK/2kR8CBJ+SqFe6RtWQCQsCmUkrv96yg=;
 b=i6UfLtWxc/gm9OsO2EVhKPsh7wJiJfzW5SsS4NTCViZcUUuSQo4+i/HHA9nvezf4wOkPLLT3mGaFPHiTFxAyeR+4GdrBZdDX5kZR9sUCE5agGlE1KsYG4+5mFFIBlmFVJ8vVZknunudvfZ5h/+lxi4gmNwEUOesoe/xjtRXbZh+GP/ehdYDc+H74AXcUsvFpWdQJ5Dbnl6zk9qFUKXX4jx2KFGkG8G0eYdqWCLQYESCbWyeY7YbRCQ7sVKypsDWjVmdiiFiTjCx3dam6pjz/RXSqpj53aYImhu+1yL9GLhbHznwAxZBNStfuM1EsJP/7DwUD/EF5v8/xfo4VPWqUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIDC55WVurkK/2kR8CBJ+SqFe6RtWQCQsCmUkrv96yg=;
 b=su/4g44Za/1YyBipMzDna0fhubWmXIT62SyMaLBmes5xI52OeVZEtiYr8QXFVDgZH4FdtXVP4tiCYRN0UOMhc0qbMg0fxP+pyqgiDafBxQlVZQmvq1L1nOOK+q/hfqejt3gNtwwvOARzs0Uwa5G6p69/wUf3tg5fDRisewu3LVk=
Received: from CYZPR14CA0005.namprd14.prod.outlook.com (2603:10b6:930:8f::24)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:32:09 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:8f:cafe::35) by CYZPR14CA0005.outlook.office365.com
 (2603:10b6:930:8f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 09:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:32:08 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:32:03 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/19] drm/amd/display: Use DPP inst instead of pipe idx for
 DPP DTO programming
Date: Fri, 10 Mar 2023 04:31:02 -0500
Message-ID: <20230310093117.3030-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093117.3030-1-qingqing.zhuo@amd.com>
References: <20230310093117.3030-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffb7249-4011-4785-eedf-08db214a51f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omZu0zvoBkp91DEQSLcJaMCLKwzdOuKQTm5043g2REy7lPXbKbufljHm030vFXC761u7A00/4FErXD4vjosmvhIOahnKTyOKWzph65j9NuLOlqOiZ3WyDSCYi1NMCr7nb9l+1Fsc4qhlKUjLIlaWHag2H35kn0eq4HDe749+X2e9diS3RiRFo/YgDlLMhgle9TCZBxbcb4blbPe/36Mb03+O/KKEqQxupa/6QuYl8qU9sRJTRx94sgr9XSTVP9pUSelwuvBGsKdrWhXQ/RCxQc6AorHVx5TQYa5MiNiQI7nu9aU40IkHjctCXnG6I4t9oVzsOrVVhJ++Inq99zlpSGln2qaAN1wIw5XUCWN+4EJM0QDjGfWcJC99QRdUkzwbfPUoJDfLUxAFzlfZ23O2oTtgk9PxEbFhktb0hsA9NPEhGc+jVS4iw9a+ta6yCB2DpNiHJwBDiUDkN6wgOMWfbnKdk0MJIQePPZXqtUIjjUAmiScNND+GUwP9cXytNwxlWlvt/xVl1ML6/1+08oJ0xO2ciPMcGOxLfMhjGzXKwVYI41oNG4d8s9ZSITkM6wGmV9KjPdbjLfXQF9E4pQtqq/EXeS+AlyhdGTfC0oliod0ph2SIkjFPUR91D37ClogzPhcgSbiaQd39OFNDGJwVNWg1gxo97Ly86HTNC+tX9IQYpGtzvL2av50yT7Ou7jAlD2GjOkIZ6QH2PQXFnGA5gsTVKo+mrTX0hfxCS65YT8M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199018)(40470700004)(36840700001)(46966006)(1076003)(26005)(426003)(47076005)(54906003)(186003)(336012)(316002)(70586007)(8676002)(70206006)(16526019)(8936002)(36860700001)(81166007)(82740400003)(41300700001)(5660300002)(4326008)(2906002)(2616005)(83380400001)(44832011)(6916009)(356005)(86362001)(82310400005)(478600001)(40480700001)(40460700003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:32:08.8594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffb7249-4011-4785-eedf-08db214a51f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- For pipe harvesting cases we must use DPP inst instead of
  pipe index for DPP related programming

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 38 ++++++++++++++++++-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.h  |  3 ++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index e686d6610fd4..af108f88b112 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -255,6 +255,40 @@ static void dcn32_update_dppclk_dispclk_freq(struct clk_mgr_internal *clk_mgr, s
 	}
 }
 
+void dcn32_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
+		struct dc_state *context, bool safe_to_lower)
+{
+	int i;
+
+	clk_mgr->dccg->ref_dppclk = clk_mgr->base.clks.dppclk_khz;
+	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
+		int dpp_inst, dppclk_khz, prev_dppclk_khz;
+
+		dppclk_khz = context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
+
+		if (context->res_ctx.pipe_ctx[i].plane_res.dpp)
+			dpp_inst = context->res_ctx.pipe_ctx[i].plane_res.dpp->inst;
+		else if (!context->res_ctx.pipe_ctx[i].plane_res.dpp && dppclk_khz == 0) {
+			/* dpp == NULL && dppclk_khz == 0 is valid because of pipe harvesting.
+			 * In this case just continue in loop
+			 */
+			continue;
+		} else if (!context->res_ctx.pipe_ctx[i].plane_res.dpp && dppclk_khz > 0) {
+			/* The software state is not valid if dpp resource is NULL and
+			 * dppclk_khz > 0.
+			 */
+			ASSERT(false);
+			continue;
+		}
+
+		prev_dppclk_khz = clk_mgr->dccg->pipe_dppclk_khz[i];
+
+		if (safe_to_lower || prev_dppclk_khz < dppclk_khz)
+			clk_mgr->dccg->funcs->update_dpp_dto(
+							clk_mgr->dccg, dpp_inst, dppclk_khz);
+	}
+}
+
 static void dcn32_update_clocks_update_dentist(
 		struct clk_mgr_internal *clk_mgr,
 		struct dc_state *context)
@@ -524,7 +558,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (dc->config.forced_clocks == false || (force_reset && safe_to_lower)) {
 		if (dpp_clock_lowered) {
 			/* if clock is being lowered, increase DTO before lowering refclk */
-			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
+			dcn32_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 			dcn32_update_clocks_update_dentist(clk_mgr, context);
 			if (clk_mgr->smu_present)
 				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DPPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dppclk_khz));
@@ -536,7 +570,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			 * that we do not lower dto when it is not safe to lower. We do not need to
 			 * compare the current and new dppclk before calling this function.
 			 */
-			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
+			dcn32_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.h
index 57e09c7c95f5..186daada7b03 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.h
@@ -32,6 +32,9 @@ void dcn32_clk_mgr_construct(struct dc_context *ctx,
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg);
 
+void dcn32_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
+		struct dc_state *context, bool safe_to_lower);
+
 void dcn32_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr);
 
 
-- 
2.34.1

