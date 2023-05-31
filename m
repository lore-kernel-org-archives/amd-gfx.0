Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EAEC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 04:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5751310E472;
	Wed, 31 May 2023 04:49:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD7610E470
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 04:49:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6Y9U2rlR/qjV3JABg0xF2dPQlu2cGUEPrqmwlX+Il/modMDtXxJM6hpxGg1xAUDBjYuPQJ8nterqPSpzWqc3n5aHJmDfeGZHQNwr8tK/t53Y5qyrRME1YsP1tbosQEDaasd/ewCQpADDA+BKgOD9wnqSrVg3ABc1J6YSsxqvrLw9mHKARl7gMZM3M3N0W6TLzhoXjqS5ZkKz8dBTttSD4ea6Z8kRwegCTbqDM1tO8ON869UPonX8Q55JXPN4ydIlQknuKv8K7Ch1DMIpTHhKYx33iGPKWmBirs+28ZdTsgMEIPd9u1fM2Bv+gwpZs+ApvIgGKpBTE/uDcYqdCZIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhmy6geeEdWkAY8DNIvzaCd5JVTU6A6j1Bm7gU1n/0Q=;
 b=YpbE0aRnLrkJIaRwA0EWRdMQY+YWHwEIR29f2Jn+lQKkFsDfUlJ6zzXzkEvvG5k/K77Grjbf7f7+9IAY8vc1Jx6wmssThX+x4+TKk1F+DLXcutXy2b7oWqFeYYj7T3CcL8D0btPvgrIW7Bl8i7EsQRNNPtYKY8I5f7dBp/2hqDLICleYv9H6jlvdynM0zNtuYmbvapgwhYtqTtActeAWfkV1FHUtRErqFm6i/W3qM54dr+kKVRbXFC/lx5zs3TLTG3P3GU98F+QWU2OBPWbnGSiZmt1mtNxopC79qdhhPo0u0ihLXdoBy1az1Tkts7zPAOnSe1m/9O0Mx1azU1YYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhmy6geeEdWkAY8DNIvzaCd5JVTU6A6j1Bm7gU1n/0Q=;
 b=2frhWFBmqdIk1/uD36lRo75Kl4HhMe/YigZqw54C+Udz8Gc6vbuB+JFA6XBn2xkroxtG31rKTSe7lD6RnyHnu1uYszxeLNGB7e6O4hUJoc0FmgrxhSXfgrizi0AvcMyfGKq0QBSiJKXQN6HsHp7NvsabtmgmvOVFtk78u/A6P5k=
Received: from BN9PR03CA0856.namprd03.prod.outlook.com (2603:10b6:408:13d::21)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 04:49:19 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::eb) by BN9PR03CA0856.outlook.office365.com
 (2603:10b6:408:13d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 04:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:49:19 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:49:15 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amd/display: Add control flag to dc_stream_state to
 skip eDP BL off/link off
Date: Wed, 31 May 2023 12:48:05 +0800
Message-ID: <20230531044813.145361-7-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531044813.145361-1-stylon.wang@amd.com>
References: <20230531044813.145361-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: d259a352-0c69-4f47-6d02-08db61926530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EdG1N9UGxmNYYZTxo3anPVxFdsU+bjV1cA9ALnD4Y4qlZfHV4WN6Y0Xo/ZAhghu75V/ebJI+T5YzJFMcPlQYqcaVl2LJxCL3TGgbwbU/12wVZC5Q06lB3irDIxoraLLhNsXMrnrfKeNFaX4UyaBy23w3SZo46Cv9Ysb3oHKQKTaZfJiJjy8K3kO5cH0CKKPUEB1a+YdR0NiftFoS6/pXkAAE4BZbQDn9xg6IyN309NZfTEsNEEMLrDxLS3Js2yctO2Z3ZWBf7w32CHw3W6Jl/saVfJQLO1UuzzIs0kOk7fyCVMka8qfJQYuDl5+POPNFh996nteFVjWq9Xk6Tm0PqiB3oKigca+RK+aweFM0bOA/8PgfdO17Y8ZcflAP6Glp5Uuy0PuaDLj1iL3x40Z+lNyawfRdzwCKVo4GQN3kWwH7SHlU+4GgCJeTuVZD7TWuIx6P9ZHOYpUGPX5HjqQFgqfSoRKpZPZu3zfbqiUq87tn7nz1DKKIDtfHekLkSaV0RkiJ0Y5Htn9Rpqs4g9FIB2b5ekS+oTV/qTAIrHQWOfKYcthAIoRN1eEfsY04eArdfXeLp0FjwD3WLguTRAPWMIfhefKo0g/y72AZ8T85y8kLjVcxIjGbhfWt+W/lZzc3DBSofV7VE71LfMseM2IbFSKYRNaOfQghP/BC3fKDdvn/tNFm3nTRJDAimH3OBvpcBDz2Zv3eqiBHapewNZyH/cy+b6EzG2xd4cgjf2fuTpLw5qAYgwzZFo2W8biGBpl57DwxMBBVK6yPMWi8bOLOEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(186003)(2906002)(2616005)(54906003)(336012)(426003)(16526019)(478600001)(26005)(44832011)(83380400001)(47076005)(36860700001)(1076003)(40460700003)(7696005)(8936002)(8676002)(41300700001)(81166007)(356005)(40480700001)(82740400003)(6666004)(70206006)(316002)(70586007)(5660300002)(36756003)(86362001)(82310400005)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:49:19.3380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d259a352-0c69-4f47-6d02-08db61926530
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Max Tseng <max.tseng@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Max Tseng <max.tseng@amd.com>

Add control flag to dc_stream_state to skip eDP BL off/link off.

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Max Tseng <max.tseng@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_stream.h                 | 1 +
 .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c    | 3 ++-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c            | 7 ++++---
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index d5b3e3a32cc6..3697ea1d14c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -302,6 +302,7 @@ struct dc_stream_state {
 	bool vblank_synchronized;
 	bool fpo_in_use;
 	struct mall_stream_config mall_stream_config;
+	bool skip_edp_power_down;
 };
 
 #define ABM_LEVEL_IMMEDIATE_DISABLE 255
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index d4cacb8df631..6c9ca43d1040 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1216,7 +1216,8 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 	struct dce_hwseq *hws = link->dc->hwseq;
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
-		hws->funcs.edp_backlight_control(link, false);
+		if (!stream->skip_edp_power_down)
+			hws->funcs.edp_backlight_control(link, false);
 		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 2963267fe74a..d719a666f974 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2207,9 +2207,8 @@ static enum dc_status enable_link(
 	 * link settings. Need to call disable first before enabling at
 	 * new link settings.
 	 */
-	if (link->link_status.link_active) {
+	if (link->link_status.link_active && !stream->skip_edp_power_down)
 		disable_link(link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
-	}
 
 	switch (pipe_ctx->stream->signal) {
 	case SIGNAL_TYPE_DISPLAY_PORT:
@@ -2327,7 +2326,9 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		dc->hwss.disable_stream(pipe_ctx);
 	} else {
 		dc->hwss.disable_stream(pipe_ctx);
-		disable_link(pipe_ctx->stream->link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
+		if (!pipe_ctx->stream->skip_edp_power_down) {
+			disable_link(pipe_ctx->stream->link, &pipe_ctx->link_res, pipe_ctx->stream->signal);
+		}
 	}
 
 	if (pipe_ctx->stream->timing.flags.DSC) {
-- 
2.40.1

