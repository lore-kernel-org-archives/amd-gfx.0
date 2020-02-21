Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E56C35658
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B138D2067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0+LajJvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B138D2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCFA56F4A9;
	Fri, 21 Feb 2020 16:04:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011406F4A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VP0jZ1WSPmYF1X9amjn6PFPFh2c+iq1dsGS+/26FeCn90MrX65Kn8wqlSawb5FKSDO+BgCCtcqaMNFoth59Ijj77GGDSb25BjdpZpi3CMZ74a+j4wzyGO1gwLn3vFOzHqTwx3Es/eiAtSB09NJC9liaCzSV8XlhIPt016A9y7ZdcHph5/BESl4PC5Lqo8OELNk64HcIAymknSd4vVJVOrcJfYDoMzc1ZY2o0FJc/SGFFcLNMW6JZycl1K7keDcfU57GIBYR5OgLD3FyHJ6zdB5sLR2/NZoVH84ixKjgiitVclrbKyUQH7cmEC2mvnLF39LENbUzt/8oed2Gw37htEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9+IdZgncZxMMOV42Fz0ftzesdMGjkI6cecY2LL5e6c=;
 b=G8lIDF6RqNcZka2uxO8NI9gsjJL7KlVQv+K7TFrlemHE56688sN7ldX8N6jSMq2E3M/woc3MqpOJrmAYF3JKAIfVQL9ddfX7JQa+DTH4zbyxuRcsBSWuicgksTgSL5fpdkZueztqWZBMl/hh0Ba9i7fWt8r8rwRItadH6TkBZOf2sNk6yGBdTgluFQFR9O14po+aYsv/guGJ8uAuSGfnRKuKxvWGAilKgyoCzsbba9bsY7O9oP4BnjmslP7MYAkRjhnUHAb/JY6xVoDM5SntEhf9JWFrruz/joghQacvYPi6eFyPlg7mzQVxYgAGdHUi8NYTRPGwg2Yi9DHMLmPVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9+IdZgncZxMMOV42Fz0ftzesdMGjkI6cecY2LL5e6c=;
 b=0+LajJvRcnLWi/Ufe/cAwQlDoDJl/sWOxVEA9U4ezBVgY/xLZG940byP6IFP24J9ivF0UHJ763+boIORtobdyBohAH2hd18uKGcHcROuD/AsrYWbZBihMTJUir8sz4iEVdW+xQ1b/YdqKuySzby3etmLa4uKxIdT+r6Y+IcuNfI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:58 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:58 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/35] drm/amd/display: Add function pointers for panel
 related hw functions
Date: Fri, 21 Feb 2020 11:03:04 -0500
Message-Id: <20200221160324.2969975-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:57 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7323aa0-a293-4238-8cef-08d7b6e7a887
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24094038FE43480D31BC5ED098120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(6666004)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTJZRS/HdJFQT/Lif6HqpxnyL5LB6TMLGp/ufBz7QwBrSBld1n9fYnodnX0hnC26x7JB38Blamy2i/1/MMr4NBhlV0cHGhB/1Gptp8j7xBN+0UtypEmyAzemgNZsU5AhprSxpy619/XYu/JMLuIhK0f60+u3yACSKxA/tuVemqgrAU6VbxYKlvHCEIvS6d14V5sHP3q0/OuS2Wv5Z1ZKg0awMr7I1mUUIzR8W3YTcnzdX0c+Pg9ulip6XEqhCQALRsH/D5H/jz/mXbSmp1NDAKY0zpA6zzmZ5AarZl5ImLQsPCztA8uY+veXNeauxGIzRnPDq6F4UX1QO6RAfqSW/9mJ1yRL/CXa70TlnRrF4VXb093hoEDp879tlV10qO1BJ3RKb1IHJzv7aG5rmSZrxxieRZMa3Yac08iFcBJljtNJu8Y6XTncGHjxmW/jDWWA
X-MS-Exchange-AntiSpam-MessageData: lnUo1Rer+R5zpYO8S4xh3SBxE/eRgVcOHcHT28+TjxeJpD2sY8P0bHdWnpJC0lZuO4AQbNF0u6ZL6Sp5wuT+/uVCsSUxnPJ8oRrgZKihVrHR9cuniFm5Na3hMwvsygT1X1ZTEOeKBI9HwTa36Pyp7g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7323aa0-a293-4238-8cef-08d7b6e7a887
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:58.0099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOc0XsEdcRreyqJq+jyJEXzNMQogEC7JTcJlX4Gc8B3eGfQT/RPungWRnkQdbRWeEzScTchzt28Mu5MQ62x+ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
Make panel backlight and power on/off functions into
hardware specific function pointers

[How]
Add function pointers for panel related hw functions
 - is_panel_powered_on
 - is_panel_backlight_on

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/dc/dce110/dce110_hw_sequencer.c   | 15 ++++++++++-----
 .../amd/display/dc/dce110/dce110_hw_sequencer.h   |  4 ++++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  2 ++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  2 ++
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  2 ++
 .../drm/amd/display/dc/inc/hw_sequencer_private.h |  2 ++
 6 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 28b681b33f7a..0976e378659f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -698,8 +698,10 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 }
 
 /*todo: cloned in stream enc, fix*/
-static bool is_panel_backlight_on(struct dce_hwseq *hws)
+bool dce110_is_panel_backlight_on(struct dc_link *link)
 {
+	struct dc_context *ctx = link->ctx;
+	struct dce_hwseq *hws = ctx->dc->hwseq;
 	uint32_t value;
 
 	REG_GET(LVTMA_PWRSEQ_CNTL, LVTMA_BLON, &value);
@@ -707,11 +709,12 @@ static bool is_panel_backlight_on(struct dce_hwseq *hws)
 	return value;
 }
 
-static bool is_panel_powered_on(struct dce_hwseq *hws)
+bool dce110_is_panel_powered_on(struct dc_link *link)
 {
+	struct dc_context *ctx = link->ctx;
+	struct dce_hwseq *hws = ctx->dc->hwseq;
 	uint32_t pwr_seq_state, dig_on, dig_on_ovrd;
 
-
 	REG_GET(LVTMA_PWRSEQ_STATE, LVTMA_PWRSEQ_TARGET_STATE_R, &pwr_seq_state);
 
 	REG_GET_2(LVTMA_PWRSEQ_CNTL, LVTMA_DIGON, &dig_on, LVTMA_DIGON_OVRD, &dig_on_ovrd);
@@ -818,7 +821,7 @@ void dce110_edp_power_control(
 		return;
 	}
 
-	if (power_up != is_panel_powered_on(hwseq)) {
+	if (power_up != hwseq->funcs.is_panel_powered_on(link)) {
 		/* Send VBIOS command to prompt eDP panel power */
 		if (power_up) {
 			unsigned long long current_ts = dm_get_timestamp(ctx);
@@ -898,7 +901,7 @@ void dce110_edp_backlight_control(
 		return;
 	}
 
-	if (enable && is_panel_backlight_on(hws)) {
+	if (enable && hws->funcs.is_panel_backlight_on(link)) {
 		DC_LOG_HW_RESUME_S3(
 				"%s: panel already powered up. Do nothing.\n",
 				__func__);
@@ -2764,6 +2767,8 @@ static const struct hwseq_private_funcs dce110_private_funcs = {
 	.disable_stream_gating = NULL,
 	.enable_stream_gating = NULL,
 	.edp_backlight_control = dce110_edp_backlight_control,
+	.is_panel_backlight_on = dce110_is_panel_backlight_on,
+	.is_panel_powered_on = dce110_is_panel_powered_on,
 };
 
 void dce110_hw_sequencer_construct(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
index 26a9c14a58b1..34be166e8ff0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
@@ -85,5 +85,9 @@ void dce110_edp_wait_for_hpd_ready(
 		struct dc_link *link,
 		bool power_up);
 
+bool dce110_is_panel_backlight_on(struct dc_link *link);
+
+bool dce110_is_panel_powered_on(struct dc_link *link);
+
 #endif /* __DC_HWSS_DCE110_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index b88ef9703b2b..dd02d3983695 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -87,6 +87,8 @@ static const struct hwseq_private_funcs dcn10_private_funcs = {
 	.reset_hw_ctx_wrap = dcn10_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn10_enable_stream_timing,
 	.edp_backlight_control = dce110_edp_backlight_control,
+	.is_panel_backlight_on = dce110_is_panel_backlight_on,
+	.is_panel_powered_on = dce110_is_panel_powered_on,
 	.disable_stream_gating = NULL,
 	.enable_stream_gating = NULL,
 	.setup_vupdate_interrupt = dcn10_setup_vupdate_interrupt,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 44ec5f5f9fd2..6c4f90f58656 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -97,6 +97,8 @@ static const struct hwseq_private_funcs dcn20_private_funcs = {
 	.reset_hw_ctx_wrap = dcn20_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn20_enable_stream_timing,
 	.edp_backlight_control = dce110_edp_backlight_control,
+	.is_panel_backlight_on = dce110_is_panel_backlight_on,
+	.is_panel_powered_on = dce110_is_panel_powered_on,
 	.disable_stream_gating = dcn20_disable_stream_gating,
 	.enable_stream_gating = dcn20_enable_stream_gating,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 53006f3b9eb9..f9a7e43d66b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -105,6 +105,8 @@ static const struct hwseq_private_funcs dcn21_private_funcs = {
 	.reset_hw_ctx_wrap = dcn20_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn20_enable_stream_timing,
 	.edp_backlight_control = dce110_edp_backlight_control,
+	.is_panel_backlight_on = dce110_is_panel_backlight_on,
+	.is_panel_powered_on = dce110_is_panel_powered_on,
 	.disable_stream_gating = dcn20_disable_stream_gating,
 	.enable_stream_gating = dcn20_enable_stream_gating,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index ecf566378ccd..c5511e6157af 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -97,6 +97,8 @@ struct hwseq_private_funcs {
 			struct dc *dc);
 	void (*edp_backlight_control)(struct dc_link *link,
 			bool enable);
+	bool (*is_panel_backlight_on)(struct dc_link *link);
+	bool (*is_panel_powered_on)(struct dc_link *link);
 	void (*setup_vupdate_interrupt)(struct dc *dc,
 			struct pipe_ctx *pipe_ctx);
 	bool (*did_underflow_occur)(struct dc *dc, struct pipe_ctx *pipe_ctx);
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
