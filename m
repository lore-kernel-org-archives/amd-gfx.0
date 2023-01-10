Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7849BC54EBE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 207F810E626;
	Tue, 10 Jan 2023 16:59:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE36C10E621
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYY70T3Kk88r+Tkza3Taf23CgeyqcUmW7YgONlfrNAYvGMYpLY0Dm/BgoS242Y9WvPkRIwzgCEGuGFl6lc8J5vR+IjJmbpMXN482EFoLOYW2EVgpwdHBlWia+o2wIY7OF6NWyRrABTxi7b7Qo4xFmURsHvfktWfN0ZHzazsN06GOpWGJjuB5q1z2xOWyCleGWU5P0/ExVPWWkeZFTPQeSLMhtnDNiUCfgoPjb4kWyeQP3y2iN8rz619MBrF8Bq3qsEwj1IGS5DQze94gELXQNzY5GAmm8Rt5GxIGegpb8qnJLauZQKhY4Hbf66yuk5UqChOfaiF/vo1g0S7ihRmpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ollEAhzwY//m9Kb55bG0Lyyxelxoxz643Mhu6gfquQ=;
 b=L9CWBGbOP/GNfB3pOVwZXYeLXWXIM8ouro6yPRZc8HB7Q9UrwK07JlN2JoMCf6VSWYsXbcua1TmlOVJtVSEcDpZOKbjOQGh3JQ3A43KyJGCyIeAWHYpWXgQAba/6AkybOsIXtJcbamK8IGpqEjaP0ZLY9orJZPJ+yOD6AjXhCgT7Cg9V63Ln3EJv0MWIvZQgShFS4Ve55NnZ5XPAabgVAOS2B8UiRY5Gw/HdQRRbrG0DoGxu0Po9UJgnl/A4QlFMYbwWyTYx/Ot1mInAMvVMEtQlW8Pj98nCL0gGiPbqfo6aRNvzUbAGW4CXYVuFrhnhtcIa76123OL2P0Fdb6cemA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ollEAhzwY//m9Kb55bG0Lyyxelxoxz643Mhu6gfquQ=;
 b=QKPwzBOJROu6LbkPE9cwWnpF4NhTXxlRk61Df2ka7dP0Ly3RF9ASlwlcuHgaaBbjojbqH47EBimreGJH6QcLSxbiFtTJI+052c3JHcHX3P/QRbr5TMB2Yq69EGnP4F0LaLrRvhCOGq4JyEWvz5KrrN4EoMfxRZlwqJJPVp/3JtQ=
Received: from MW4PR03CA0029.namprd03.prod.outlook.com (2603:10b6:303:8f::34)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:58:58 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::45) by MW4PR03CA0029.outlook.office365.com
 (2603:10b6:303:8f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.12 via Frontend Transport; Tue, 10 Jan 2023 16:58:58 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:58:53 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/37] drm/amd/display: Request min clocks after disabling
 pipes on init
Date: Tue, 10 Jan 2023 11:55:30 -0500
Message-ID: <20230110165535.3358492-33-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: b85d1a37-894d-4811-7668-08daf32bf750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCTJHgoJy020mZyJdTdASBN+YLAcueQlSza6z/+6MvuimZGrZikYrwhYN038Vw9iCzXddBmzq4EZRf34H8VX4mxEIqb2kveP84RORN0xwR2zCMk73coSkfs6OXnq8+2WOpM60kSr9VIQGfCag2J/k2/o/Uk3935WHPqGHnQ9oTWrOOX6GJyinJmNGWSaqzDtfV7f53e8idQV0qi0hOwLQbICeqB8hzRrPLxeW3UMNXUCjuwE0IztYcshsyD2kqW4FUKB8zBtvih7bZ0/n4EsHl7Sbv75zYi+MzSXUxvd2CqiA6KfbOouHbEA5bwQm7/JQIYhZl5V/tpNIA0b5yGIVj7kagJ0zloy/k6czMw4KhRCHF6bduz233Xcce/AGmHpF2lNjJn78vsZ/cOUy/le2EEbvDO6qG+mQatah+NmyOcJb93nCXC8gSXmnd85092HWmLJr9zMC8nAZhbB+s3axSISHxlpLY6IzWtG8ZoS0Whc7zH0OhbxFQFiQdMdXM/LPkG3Be4a/jziwAl/p3AqC4qbeBCzSXh1vAvTJph/hVdvyM3bTs6FJpmM8UyT5BWIVhD6xtHRFFnEyNez6/xClV2ajeta2OnZzqc+Ppk9hAutQFE9Io40grjA3e5Vd+Cgvt9u/b0wM1S4/DNYvPwLyog5lX0Qu0D6E1p6vnedUvaDC5RAfYZpt/98/lpEXeP3HotzXktVul8PG95G7Ij0oVbozt/5dAafciu3ZajNlYw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(6916009)(8676002)(70586007)(7696005)(316002)(70206006)(4326008)(54906003)(356005)(5660300002)(2906002)(40460700003)(8936002)(47076005)(81166007)(426003)(41300700001)(36756003)(36860700001)(83380400001)(6666004)(478600001)(40480700001)(2616005)(1076003)(336012)(82740400003)(26005)(16526019)(86362001)(186003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:58.3172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b85d1a37-894d-4811-7668-08daf32bf750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
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
 Alvin Lee <Alvin.Lee2@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Request min clocks after disabling pipes on init
- This optimizes for power savings during init sequence
- Also handles the case where we boot up with no display connected

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 478412220360..766002619a9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -685,6 +685,25 @@ void dcn32_program_mall_pipe_config(struct dc *dc, struct dc_state *context)
 	}
 }
 
+static void dcn32_initialize_min_clocks(struct dc *dc)
+{
+	struct dc_clocks *clocks = &dc->current_state->bw_ctx.bw.dcn.clk;
+
+	clocks->dcfclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dcfclk_mhz * 1000;
+	clocks->socclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].socclk_mhz * 1000;
+	clocks->dramclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].memclk_mhz * 1000;
+	clocks->dppclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dppclk_mhz * 1000;
+	clocks->dispclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dispclk_mhz * 1000;
+	clocks->ref_dtbclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
+	clocks->fclk_p_state_change_support = true;
+	clocks->p_state_change_support = true;
+
+	dc->clk_mgr->funcs->update_clocks(
+			dc->clk_mgr,
+			dc->current_state,
+			true);
+}
+
 void dcn32_init_hw(struct dc *dc)
 {
 	struct abm **abms = dc->res_pool->multiple_abms;
@@ -779,6 +798,8 @@ void dcn32_init_hw(struct dc *dc)
 		if (dc->res_pool->hubbub->funcs->allow_self_refresh_control)
 			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
 					!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
+
+		dcn32_initialize_min_clocks(dc);
 	}
 
 	/* In headless boot cases, DIG may be turned
-- 
2.39.0

