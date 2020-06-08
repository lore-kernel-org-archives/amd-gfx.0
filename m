Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6567FC433E3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A46A20801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a6mRIHvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A46A20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E106E497;
	Mon,  8 Jun 2020 04:59:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF51E6E497
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvpB1yMCjCJ4HcbM4f4/jX3TQsRDls1gG3AS/TP5T1CnD//qkVcglcekOLYKFh6/4pMRvqCX20V6zPxHdwQb9W5fox/jq7bVuXYiM/hyTDWTe7G7OqJqQNBUOCglDPf4WSpCeaZtDqn3BIFZ2INymm9kpmsYbdRmPJ3ttGi/xp+nNUDCq1X5vWvNxl3Vr0KTS+yK74wDO9WS9oY6n6JSTy+iAq+FaKMX0o6OcIncBzS75YuyPC09aDswQXbJSiLpSmtIkq9LVgCNCiqWJC7RC2oyp0FkbJSHgB3azjNUxOzMt4OZxDRkaJGEJIhOM1PWyFf6ld3BttrkIZ9QnfusMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmca4JljK1eVXenI5752EF2d1vJ7xThBRuX5+YEx63Q=;
 b=nEscQ6FWkRljcrNLGwWpuAkxHbtVcHkwf3Mp9e4we9IfU/BtMu9M95hxoVUims+P1yQp8Zkhtz80YRdzOdtHLxHJWONjeQQyaHsuqf8m5h1urjYBjlF30BzxxyEwkJrPYQeoHnVAw8wroNmrT1B8FX8vAsFYPoboUceo3teArbYRiv/C0kCULkwBk3V/wdXUfxUqzo4hb4gfASrdl7IFOM52u//RCPT0rXJnmA/94A6vAU923BnLIH1qd9z7c2S9qhez0h/5FRvz/AOD5amiDDIQelCuIJJZoe+b6VFrBzgGM8pEA1xY0f+mBu+YRmauY1dkM0Fpa6eWMMADOfe5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmca4JljK1eVXenI5752EF2d1vJ7xThBRuX5+YEx63Q=;
 b=a6mRIHvuNirkyS1H2l/56a8pX08RD7UujjbLuwXRokjCthOOD2ZOH8LOrHC2SVO2cI6a3y6d4O3BghRM+Jd2zyv4t+110YphpVTCj8P6+/CkismtV/nGmgQGTf61Kgw1FU5rQgwLkoXHJZ1Kpm0TLCL2E9QjKo9IkfRJ3WHtLYc=
Received: from DM6PR14CA0065.namprd14.prod.outlook.com (2603:10b6:5:18f::42)
 by MN2PR12MB3950.namprd12.prod.outlook.com (2603:10b6:208:16d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Mon, 8 Jun
 2020 04:59:47 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::87) by DM6PR14CA0065.outlook.office365.com
 (2603:10b6:5:18f::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:46 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:46 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:45 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/28] drm/amd/display: Improve DisplayPort monitor interop
Date: Mon, 8 Jun 2020 00:59:20 -0400
Message-ID: <20200608045926.17197-23-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966005)(81166007)(82740400003)(47076004)(2906002)(26005)(316002)(426003)(186003)(36756003)(2616005)(44832011)(336012)(82310400002)(356005)(83380400001)(54906003)(6666004)(70586007)(1076003)(8936002)(4326008)(8676002)(478600001)(86362001)(6916009)(70206006)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cc3a43a-652e-4b60-bee6-08d80b68c460
X-MS-TrafficTypeDiagnostic: MN2PR12MB3950:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39507F933BD4536565109081FB850@MN2PR12MB3950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s6HSTOVG7U9PQHkXe2gIIKdwqiNN8verCqY5IWEzA05hsI0LjWYtoE61CXja2KRWk39/KbubULgCjED+jIGkMdPZCuwtSwHuNJ/WVcvylagTZQmFmWxpn5mKN53OCBc1XhmcNucnF+Bu1dUhhZeJOsQ9n5HIq5iRyhmC82XET7j3mtl5lNxlbab9JX1C+XHYer3wBGq4RHOx03ioVzzXpwZCttx1Bx99WIzS9u09l/IlChwCfct6daNkIUKHXv7HtmtPSLtBxYrGT9/sz+1w1ymx3EOcGFoYY0u8374zQYm6xbzXW0BX4fp0o2QpEPm1cgFQhIFjxPU/VDAluMvlUUB3awSq0YoaXDBnf5SkDB0WTN8taPvX0kxqSOjytrctcZml15HEmWI7lhwj3fdVdw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:47.1264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc3a43a-652e-4b60-bee6-08d80b68c460
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3950
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
Cc: Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
DC is very fast at link training and stream enablement
which causes issues such as blackscreens for non-compliant
monitors.

[How]
After debugging with scaler vendors we implement the
minimum delays at the necessary locations to ensure
the monitor does not hang.  Delays are generic due to
lack of IEEE OUI information on the failing displays.

Also reverts commit b9976bd920a19d509de09b6dc727fcaae60fbb32.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Tony Cheng <Tony.Cheng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  4 +++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 23 +++++++++++--------
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 -
 .../display/dc/dce110/dce110_hw_sequencer.c   | 11 ++++++++-
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index cbb4c24d748d..114ee29132fa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3309,9 +3309,11 @@ void core_link_disable_stream(struct pipe_ctx *pipe_ctx)
 			write_i2c_redriver_setting(pipe_ctx, false);
 		}
 	}
-	dc->hwss.disable_stream(pipe_ctx);
 
 	disable_link(pipe_ctx->stream->link, pipe_ctx->stream->signal);
+
+	dc->hwss.disable_stream(pipe_ctx);
+
 	if (pipe_ctx->stream->timing.flags.DSC) {
 		if (dc_is_dp_signal(pipe_ctx->stream->signal))
 			dp_set_dsc_enable(pipe_ctx, false);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 6c03dcd6acb5..484a6849f3de 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1102,6 +1102,10 @@ static inline enum link_training_result perform_link_training_int(
 	dpcd_pattern.v1_4.TRAINING_PATTERN_SET = DPCD_TRAINING_PATTERN_VIDEOIDLE;
 	dpcd_set_training_pattern(link, dpcd_pattern);
 
+	/* delay 5ms after notifying sink of idle pattern before switching output */
+	if (link->connector_signal != SIGNAL_TYPE_EDP)
+		msleep(5);
+
 	/* 4. mainlink output idle pattern*/
 	dp_set_hw_test_pattern(link, DP_TEST_PATTERN_VIDEO_MODE, NULL, 0);
 
@@ -1551,6 +1555,12 @@ bool perform_link_training_with_retries(
 	struct dc_link *link = stream->link;
 	enum dp_panel_mode panel_mode = dp_get_panel_mode(link);
 
+	/* We need to do this before the link training to ensure the idle pattern in SST
+	 * mode will be sent right after the link training
+	 */
+	link->link_enc->funcs->connect_dig_be_to_fe(link->link_enc,
+							pipe_ctx->stream_res.stream_enc->id, true);
+
 	for (j = 0; j < attempts; ++j) {
 
 		dp_enable_link_phy(
@@ -1559,21 +1569,14 @@ bool perform_link_training_with_retries(
 			pipe_ctx->clock_source->id,
 			link_setting);
 
-		if ((link && link->dc->debug.dppowerup_delay > 0) || stream->sink_patches.dppowerup_delay > 0) {
-			int delay_dp_power_up_in_ms =
-				(link->dc->debug.dppowerup_delay >= stream->sink_patches.dppowerup_delay) ?
-				link->dc->debug.dppowerup_delay : stream->sink_patches.dppowerup_delay;
+		if (stream->sink_patches.dppowerup_delay > 0) {
+			int delay_dp_power_up_in_ms = stream->sink_patches.dppowerup_delay;
+
 			msleep(delay_dp_power_up_in_ms);
 		}
 
 		dp_set_panel_mode(link, panel_mode);
 
-		/* We need to do this before the link training to ensure the idle pattern in SST
-		 * mode will be sent right after the link training
-		 */
-		link->link_enc->funcs->connect_dig_be_to_fe(link->link_enc,
-								pipe_ctx->stream_res.stream_enc->id, true);
-
 		if (link->aux_access_disabled) {
 			dc_link_dp_perform_link_training_skip_aux(link, link_setting);
 			return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f9bdd9115edc..7da41d465a34 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -498,7 +498,6 @@ struct dc_debug_options {
 	bool usbc_combo_phy_reset_wa;
 	bool disable_dsc;
 	bool enable_dram_clock_change_one_display_vactive;
-	unsigned int dppowerup_delay;
 };
 
 struct dc_debug_data {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 0ce430cf4dd0..49380ed3aeae 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1069,8 +1069,17 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
 	}
 
-	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+	if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
 		pipe_ctx->stream_res.stream_enc->funcs->dp_blank(pipe_ctx->stream_res.stream_enc);
+
+		/*
+		 * After output is idle pattern some sinks need time to recognize the stream
+		 * has changed or they enter protection state and hang.
+		 */
+		if (!dc_is_embedded_signal(pipe_ctx->stream->signal))
+			msleep(60);
+	}
+
 }
 
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
