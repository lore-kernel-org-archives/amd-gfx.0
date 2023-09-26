Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F28E7F13D
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 21:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B467010E43D;
	Tue, 26 Sep 2023 21:53:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D48410E43C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 21:53:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPGoMRcxnD/a+9ZHFbgx0hvXpoIHBHwKV070WRMV5ryxn2uQld5rZKC/w0rmOAIXkx3cSNh/wN9UzB4CQFXjaLxuqaKiFJ8i/nWKaJ0iaKMR/W9Q/EtKUT17OHpGI3UKmk+RUSb0+OXtuKhmduZgKOwBy8VFEHfzy6D1601Spi80+3DZiBrsgtaIPJYqFgGK3SJH77T+XviGL+JiO2ZUMgMTuEhAlX5d3nhCPaT8ZaeYAEIUkSsNF4MBvWja7wZd2xOhSH9VNuYEZmdBq8m7FGHkDBsIiqvcROeTDztIBo/8gl6z6sMpKQLoOrHvX5shY5+PRXva9EI8gLe+OzwtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpBeJXdKr411W+Fjnd4Sk6v5tPfRz3H4fEWd5mEPMe4=;
 b=FWU7IlwQ7exgETuzxZMzQHzp85fAPkqbp+ZwH2QhMnnlrj/y6SXy+zsIZTRtaIthPtSq0TZqLbAahKK98wRyhqm55b89XQuMxV6hF5WqSYwoHmqd6QFoCJSBbqIGH7AJMKQixUnQrkPZ4Tp2Z303sFKIiOQ3UnGu2H76Z8YDVEHejD+XLoRurzy0bPlIS25ykwkYFmGHDT/dnA1RmBXIhkYoTQBh3X2L4sXGJDTa6dTc2UBp2lpswzZa9CEvvyK+9MpjEqBgwfusjKI1QX40A0NR1RbXO7E8HpbXwdpI+wj6/znphy/oP7Xih1KiGu+gFH1wqxx2NX64Em2jPIzF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpBeJXdKr411W+Fjnd4Sk6v5tPfRz3H4fEWd5mEPMe4=;
 b=2dZ9fBFBXV4lIxDCTc308Zxi2rdzqYMdxwsW8FaudyuvLDdioiS1w2FbY9qFImayXsDnZaCQ5MepTl6gw8SxrXUO7mQY2AyXMJrURKMTkmJ96rXAGePXqeoB7JMGnkXlUUKtUVL3KqV25mqOzqG+Fwjctufj95BPfLGunfSZzQ8=
Received: from DM6PR07CA0060.namprd07.prod.outlook.com (2603:10b6:5:74::37) by
 SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 26 Sep
 2023 21:53:49 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::92) by DM6PR07CA0060.outlook.office365.com
 (2603:10b6:5:74::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 21:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 21:53:48 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 14:53:47 -0700
Received: from manjaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 16:53:46 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amd/display: remove duplicated edp relink to
 fastboot
Date: Tue, 26 Sep 2023 17:46:56 -0400
Message-ID: <20230926215335.200765-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926215335.200765-1-aurabindo.pillai@amd.com>
References: <20230926215335.200765-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: a6edb7f2-2e0f-4464-2c64-08dbbedb105f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkwvQQ/mzmhHCRnDxgVpiIMC8J5D28+wh/IehdBLz+z73n7nuniGeP4NE5tZ4qNLL+I6ZGuqW44ro557NwQqrTCFC2xhzeh8kIV4j7cKp1O9piznmQnKW8D0JzdFaKahTk2aK4ZP1dRwVt6I+35KdRhXVlauV/OgO5E6MHJaM7dftBw0Dj0eABxgVz+T52RgQhf9izLIAvwsrXPU4xX0P5t7TSRoqwXvJtckXSb7+4NNdxzQUQ1BDVbrlBpD25Mg103UkDa0M6D0MeSOuOaPfaXyfLM5CDEV6ACZZXFjCr1ClwBtZ2gS/TvAQFWv+17tKg6IDbmBP12je2HKr1bA2f/uuE9VUBmgxOKquSpv34HYZpGP9qEbp7cp/DZvcwiQECgIitGBVfORjzZ4hAZ7vvk0oNBmNwYGN2syyCquCajpq9sA0p2pxMrCuM70dpBi17SxIuWui2QRuoD6kUcqgmQpnpMxwLMy6xTaZR4OzHV55Msm3E/5t8ScV99tjYQtgLuVzQcBW27kucCXxEct5b2HMONs3jY3j9didBNN/I8SVa8niluBcaEzEOzR/WENXUVLPgYefgoeW5zb3f6gAy/Dy4DV3Mwxtz6hocGwnezPY0k4LgLvwcyBlB+CkLYBvQiQyXGGbevw9qM/eh5LFvQPcZ5eIbKesNuxQIySfaufjYu+D6Yr7puAbqsJdea8iXElZJyxGnhTpc6/snJpWGdW7XmfVMIDMSxDozNfWJ6jPrnkZ1DNyQgT4pw9bdZ7Lm6xzfIoDc54IX17ZvOLTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(40480700001)(1076003)(336012)(40460700003)(356005)(26005)(426003)(81166007)(2616005)(47076005)(36860700001)(82740400003)(70206006)(41300700001)(2906002)(86362001)(5660300002)(54906003)(83380400001)(316002)(44832011)(6916009)(70586007)(4326008)(8676002)(36756003)(6666004)(478600001)(8936002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:48.4063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6edb7f2-2e0f-4464-2c64-08dbbedb105f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081
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
Cc: stylon.wang@amd.com, Anthony Koo <anthony.koo@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Chiawen Huang <chiawen.huang@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chiawen Huang <chiawen.huang@amd.com>

[Why&How]
enable_accelerated_mode function is fully to check
whether fastboot support or not.
It is no longer to disable_vbios_mode_if_required.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Chiawen Huang <chiawen.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 59 ------------------------
 1 file changed, 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6f2300f71ca8..4508904bbca1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1212,64 +1212,6 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 	dc_release_state(current_ctx);
 }
 
-static void disable_vbios_mode_if_required(
-		struct dc *dc,
-		struct dc_state *context)
-{
-	unsigned int i, j;
-
-	/* check if timing_changed, disable stream*/
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct dc_stream_state *stream = NULL;
-		struct dc_link *link = NULL;
-		struct pipe_ctx *pipe = NULL;
-
-		pipe = &context->res_ctx.pipe_ctx[i];
-		stream = pipe->stream;
-		if (stream == NULL)
-			continue;
-
-		// only looking for first odm pipe
-		if (pipe->prev_odm_pipe)
-			continue;
-
-		if (stream->link->local_sink &&
-			stream->link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
-			link = stream->link;
-		}
-
-		if (link != NULL && link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
-			unsigned int enc_inst, tg_inst = 0;
-			unsigned int pix_clk_100hz;
-
-			enc_inst = link->link_enc->funcs->get_dig_frontend(link->link_enc);
-			if (enc_inst != ENGINE_ID_UNKNOWN) {
-				for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-					if (dc->res_pool->stream_enc[j]->id == enc_inst) {
-						tg_inst = dc->res_pool->stream_enc[j]->funcs->dig_source_otg(
-							dc->res_pool->stream_enc[j]);
-						break;
-					}
-				}
-
-				dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
-					dc->res_pool->dp_clock_source,
-					tg_inst, &pix_clk_100hz);
-
-				if (link->link_status.link_active) {
-					uint32_t requested_pix_clk_100hz =
-						pipe->stream_res.pix_clk_params.requested_pix_clk_100hz;
-
-					if (pix_clk_100hz != requested_pix_clk_100hz) {
-						dc->link_srv->set_dpms_off(pipe);
-						pipe->stream->dpms_off = false;
-					}
-				}
-			}
-		}
-	}
-}
-
 static void wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
 {
 	int i;
@@ -1839,7 +1781,6 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc_streams[i] =  context->streams[i];
 
 	if (!dcb->funcs->is_accelerated_mode(dcb)) {
-		disable_vbios_mode_if_required(dc, context);
 		dc->hwss.enable_accelerated_mode(dc, context);
 	}
 
-- 
2.42.0

