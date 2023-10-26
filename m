Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8DFC27C47
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5407E10E81D;
	Thu, 26 Oct 2023 14:21:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB2C610E812
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4IAUAOJmvm2q5+No/JlJCjjrBMQyqh7ljnte35DK72jZnNA/GLQ4tCh1kfloi5pqcO2AKCsDJifqkrm8//JJqEB5HU9sCbcdqqueImAQQPTd8uaOEWveDjkuoV1rhXs+eCVxXNtBM7kqr4F8pfo5SMGSm/UQ2tX1l/R0JkZe6imDVuoaIWvspzPhZzz1B4jPKHgfA4zDj5gM3GzffASi1/JQl2IRN56DpYq2e4/5Xfe0qsJZvK7CrmHe/xTO31f8G2vBikH16c52Uv1WG9ujnoqqBvsU30sWmu/GLowsMlrthFgmR6CzO6cAW+Zv6+GCMXIrqtJQypK7j89A8mXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lr9t1+qvXixC8LhJKHXh984ps4QbwNILcG76kacrds=;
 b=PvBVcglsDIw6gy5Q40UZFmovaaeYXo8HANMwSzEZYubxyMscKTN9ggOG/K8hETfcYSeEWq1c3I1z1xn/JqMfZyIDFxTliFY6T1ZS5BhfvP/okxrwQGk+g9OIHz2e+b45JMPpXS2cnxCuMkTY8MpelDtJJ9qL4iTVGZpv/JcMPVtI68gqHk1mzdWQ6f93wbw95v4XXnDPsOF53ptvLzF5QakUz2hIOPPgrO32uKpaPGIV0YWqK+A6NUGQQuQ1GsLppgbEEsfesZvjAlyd11GsHSg4VrUs2/DEBU80j/xWBvsnaMnB+FTg4KMMXwqHjkvK7bm8XWUHCLixe+IgdZ00zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lr9t1+qvXixC8LhJKHXh984ps4QbwNILcG76kacrds=;
 b=tD9+2fpTUkGoQhcVGjAKuWAtp7HEEWXM5ePr3/8zm1ucDynSe5qMq0AWdbAvtbbW0YwwCDdeanZXA+JHiC+OhwnsZZK7ea0tpA6rYmZ6oDbKwaQktoTlcSr/y8FKQCGfUIMj9Redf/4gKsYNbkiVlemMgroZB+HZB398gLW+gBw=
Received: from DM6PR13CA0039.namprd13.prod.outlook.com (2603:10b6:5:134::16)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 14:20:44 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::1a) by DM6PR13CA0039.outlook.office365.com
 (2603:10b6:5:134::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:42 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:41 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/25] drm/amd/display: Fix OTG disable workaround logic
Date: Thu, 26 Oct 2023 10:20:08 -0400
Message-ID: <20231026142020.67861-14-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: fd854584-4929-48c1-743d-08dbd62ebd72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/BNAjCyFZvroRUL0/92Zmv/7T6QAh+Iy4qAmvVI1HUb2d3wo4ayqy4GJ+TCiNocTYI4VpwQ/VArESskO19z9z1GxNY19NTZJJ7qfus8ACFa4r0yBWj7ZFE2Ljz15tkHeY4voLIPOdM8tW5sQEgJ1qZKWvNVae4WGoxSMpL6RKMuTkB0RCPf8ToOyW/6qg9HNXvYmJMnan0wlNSZ9E6wfMtoZpbWUBLVDzrKvrcSbCtqwh1jgXpZ1bIIXYvbFh2RxB28lWScsvqSWGCpiobWvEeIbl5vxirD0K+eANbGkwe5rgtSdOs8HGzGtXEJ2tTZqQ8PNLkWHdWXSUtycQkn+AH0dR3rwKOcuq+n7hDjaNGfFQa0whz/tF9JcJkD5vamFV0zJXTSRlGpQQdyDEGZCQiwmVKI89rR4sLUTjP95V5/hA8B06+XzGB9KflawV2VY9lAClckJ4qT+3tZoUt1H4QfJgHhO3YRA0jVWHaEEgXqdcKiq+zFjKfMTJlEJD5m5aZZFGJcTT6isnRuWKc+jSzKvRFJitp8bhFPn5L/lDRHMir4R5HFEEGpR9gwHUtSXdk9CHXWhnKSaN0DDidjyqmLsAp5P9cQo20Jj4M/flVllcLITbgzhah6e+n+YaNfKyVr+JFi0KU36Pb18YOrnRgTodfqDnB+kRXCitm7UiG7Nc+gElBn8IVx62nyel4i/J9YAtWGQIL+VmvLlbW/E0LiER2lnGyDdkbXciR3m7vYbACgt4mk984yIuGauWCFx434mr1D5N2c6jjyX/lmGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(41300700001)(36756003)(2906002)(5660300002)(81166007)(356005)(2616005)(40460700003)(54906003)(6916009)(82740400003)(70586007)(478600001)(1076003)(426003)(40480700001)(6666004)(47076005)(83380400001)(336012)(70206006)(36860700001)(86362001)(4326008)(8676002)(316002)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:43.7354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd854584-4929-48c1-743d-08dbd62ebd72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur Hassan <syed.hassan@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <syed.hassan@amd.com>

[Why]
DENTIST was hanging when performing DISPCLK update with OTG enabled, as
OTG disable workaround was not executing.

[How]
Workaround was checking against current_state before running, but when
called from optimize_bandwidth (safe_to_lower), we should be checking
against context instead.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index f80917f6153b..25b75c44b0b3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -111,13 +111,16 @@ static int dcn35_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
+static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context,
+		bool safe_to_lower, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
-		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe = safe_to_lower
+			? &context->res_ctx.pipe_ctx[i]
+			: &dc->current_state->res_ctx.pipe_ctx[i];
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
@@ -301,11 +304,11 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn35_disable_otg_wa(clk_mgr_base, context, true);
+		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn35_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn35_disable_otg_wa(clk_mgr_base, context, false);
+		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
 		update_dispclk = true;
 	}
-- 
2.25.1

