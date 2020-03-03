Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436C8C3F2D7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1585D20716
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eWHmaMgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1585D20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766536EA67;
	Tue,  3 Mar 2020 23:27:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E13B6E980
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 23:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLFMkKtgxSXTiJfd1g6mkKHtXx5JEqTXHJ+VzcrdXAalcAPH0AP691zIQStwULFnfq41HHEGC1ByB5ohDLEpBuo47lmy4FgCH82vWoLbUKm4cb28sovvID8vIGeT9rmp2dagA71QKX5/QIFJUYRlBG6BFYyOhNw4bPGak/ks1NaByDEV8/AZXLXjOGbrOxm65YegPnG5ng1EcQDQmZuPHq8myjVurVYuC1KIvMKRJD5HicSi5c318VTJ6FySW+iusdAtI4Q3nyjEKeNN33wkkovsTddTOQlqrxG9PJUT9RNgHayAU+oZjrlpyvHbE6rn2vzn6Q3WPPuT/Fo4pI9RyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyfbqU+nxpMOeJA4a8xBZ5D7PzMM5rAdpd48bt0kde8=;
 b=AKYte2Ev3jRDGaWxb5XysEFREean76S+m8OO8q0ox8XwFF3oXXe+Xcs2xDpAOM9/vPgOSPV9sFZL0fvsaCvf1J2sCqMqH/21vnKDNuWsqaENpIgfYgfDOLxSEjBI3RTd4NCNIZsBERgJZTB1d4eC8D6Rh5wTHf+3PCcuhpqmS1VfmJn51GY0I3rtZ9V3s4KGJmDU1Y1szIvVuxmyZEHqHaZlpxXdw6dydGVYaZpVBWtHa3Fyc24ypDKRu2UEcp6IIW9Dbb50kivmq8m4NH8gG5myKlr91jWEn6PoHLO4yMaDGA13e25Kbp1Xb/ChfodxNVARy61VpzGvI7W+6rYxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyfbqU+nxpMOeJA4a8xBZ5D7PzMM5rAdpd48bt0kde8=;
 b=eWHmaMgp0Tme3KERs7EkPFFfRIhgsFnqxp06taRz4TeTQVrUp/gV/E5bohGqpyLMmWvOwcIx3JH19PrjpV/RHajQUed9bUKQjsU/ks3udfe50m/dOWchkZ/PMy4HNKPU7YmVNodr/TXT2WYhsobUulse9HWMuXdEj5nOdUA8RUk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2441.namprd12.prod.outlook.com (2603:10b6:907:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 23:27:39 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 23:27:39 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/12] drm/amd/display: Program DSC during timing programming
Date: Tue,  3 Mar 2020 18:27:12 -0500
Message-Id: <20200303232718.351364-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
References: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 23:27:38 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 248ea1f9-1d8e-4dc8-e1aa-08d7bfca769a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2441:|MW2PR12MB2441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24415557D8DE4731E455624D98E40@MW2PR12MB2441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(36756003)(6486002)(8936002)(54906003)(52116002)(7696005)(81166006)(81156014)(316002)(4326008)(6916009)(5660300002)(186003)(66476007)(956004)(66946007)(1076003)(478600001)(86362001)(2616005)(8676002)(6666004)(66556008)(26005)(16526019)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2441;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +M712DK+EfRhEnr1vVvVVbUGn4qCO+eTytApaJP2tkUg8DqhEEPwreig58vUha9HomYpGLpfMvuf2AeeVojsp+QY0IWMnYl0ECUrdkct/cdPEd9HD7d6XBMFqmcIzakeWjHqchQT1XsiW7HFUSl8RO/tZBskZQe34crEGt49XUcHuBGKwja+n0fBFTunBRsM2iM6njDs9yEJOewgHz57zoo6YJ+cM0zNApugm957YCg7SbaUCBHjIZFRTplCTVitgQLW23oD/pIDsdJA1s0BW72KpDRPtTy7rKoq4zp9L9ZEIeSIos81yYPNL8V14kqKvuefoQR4yPfQHotROqfhFaFli0bEAyGqWUGNpUQlRy1pjsLboEEAqGVfMHCz9Thek1ewu9HWc2cvp74Imu1wTq13TAVB79vlPF26P2iQSBGoFG478DKMZBgi9E4peNiu
X-MS-Exchange-AntiSpam-MessageData: CA0illEBQRcPDQIXYU/qNbhlL4bIHCw3dzRDg58sXUXrUQBwyzs9OHF32A6ugdCM/06+YXDKIhoBg71+bOU68IC9N+KJ+O7h6wA/ji7cgRz5q7A+LJUtOR05fktWWusWwY/smGGrV2aDUznQfz4yQw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248ea1f9-1d8e-4dc8-e1aa-08d7bfca769a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 23:27:39.2823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhDPehiIDMf0+vZU4j5Dpa3NokCtKfb1ajeK3mj42I+UWvyhT3ITnLTYIUk05JR5b0mscK4nCJrs+WMp/fFbUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2441
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
Cc: Sunpeng.Li@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Rodrigo.Siqueira@amd.com, Nikola Cornij <nikola.cornij@amd.com>,
 Harry.Wentland@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
Link or DIG BE can't be exposed to a higher stream bandwidth than they
can handle. When DSC is required to fit the stream into the link
bandwidth, DSC has to be programmed during timing programming to ensure
this. Without it, intermittent issues such as black screen after S3 or a
hot-plug can be seen.

[how]
Move DSC programming from enabling stream on link to timing setup.

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      | 11 ++++++++---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  7 +++++++
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h    |  1 +
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ddd4dca61cc3..114f77759ebf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3078,9 +3078,14 @@ void core_link_enable_stream(
 
 		if (pipe_ctx->stream->timing.flags.DSC) {
 			if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
-					dc_is_virtual_signal(pipe_ctx->stream->signal))
-				dp_set_dsc_enable(pipe_ctx, true);
+					dc_is_virtual_signal(pipe_ctx->stream->signal)) {
+				/* Here we only need to enable DSC on RX. DSC HW programming
+				 * was done earlier, as part of timing programming.
+				 */
+				dp_set_dsc_on_rx(pipe_ctx, true);
+			}
 		}
+
 		dc->hwss.enable_stream(pipe_ctx);
 
 		/* Set DPS PPS SDP (AKA "info frames") */
@@ -3107,7 +3112,7 @@ void core_link_enable_stream(
 	} else { // if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
 				dc_is_virtual_signal(pipe_ctx->stream->signal))
-			dp_set_dsc_enable(pipe_ctx, true);
+			dp_set_dsc_on_rx(pipe_ctx, true);
 
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 51e0ee6e7695..ac2103dec9e7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -394,7 +394,7 @@ static void dsc_optc_config_log(struct display_stream_compressor *dsc,
 	DC_LOG_DSC("\tslice_width %d", config->slice_width);
 }
 
-static bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
+bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable)
 {
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index b0f61bd7c208..03f0c9914520 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -623,6 +623,13 @@ enum dc_status dcn20_enable_stream_timing(
 
 	/* TODO check if timing_changed, disable stream if timing changed */
 
+	/* Have to setup DSC here to make sure the bandwidth sent to DIG BE won't be bigger than
+	 * what the link and/or DIG BE can handle. VBID[6]/CompressedStream_flag will be automatically
+	 * set at a later time when the video is enabled (DP_VID_STREAM_EN = 1).
+	 */
+	if (pipe_ctx->stream->timing.flags.DSC)
+		dp_set_dsc_on_stream(pipe_ctx, true);
+
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 		opp_inst[opp_cnt] = odm_pipe->stream_res.opp->inst;
 		opp_cnt++;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index e94e5fbf2aa2..64f401e4db54 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -85,6 +85,7 @@ void dp_set_fec_enable(struct dc_link *link, bool enable);
 bool dp_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable);
 bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable);
 void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable);
+bool dp_set_dsc_on_rx(struct pipe_ctx *pipe_ctx, bool enable);
 bool dp_update_dsc_config(struct pipe_ctx *pipe_ctx);
 
 #endif /* __DC_LINK_DP_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
