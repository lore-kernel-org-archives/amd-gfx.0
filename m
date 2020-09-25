Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E017AC47420
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9456D206CA
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rJnXJoxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9456D206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 518526ED14;
	Fri, 25 Sep 2020 14:55:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 336A16ED0E
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Txe5TinRn3fahCSAvHM4hzwmDw/fCW/NHaeJkPf7dvC/MyuvcqUTb2GW1Z8N3KhlHsW7qEck9mM0J2pjsnAe1clJZrrIF3E/njHY9Wq1fDUAE75X3u+QGuWycwsPziQMHsXmY61N/Y0JwKfR3+z8Ho7+egEV0/Sp6BiZJP9A108s3dYdVfT7uw7ipMHM5nkL9xgG2nh3I5l6Apt7D9gP+9d1G4qdKmRbDT2wX6kgLBqB+gUmSxeTi88vpM4Zg8uKBxvLiyGf98zFFkQDeMj+Lefuhk+il1/R2YHU07CUbmkh2gk7AXx9hmBGpFunK8/V5lCyVwWU1iPtOiTiRVq6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68Liuz8jEU6rgqh8/N3zMt2HPE2uSh+uE6MGHQyuHX8=;
 b=nm234DaXsrtRzNkEtd5QiddG2FN4dOSWd7dZdETOgHCpOX1eSMbdp7oRx8RLjyJPZlJIoXaZr0mXNnJhgQwL41iBm1LF43UXELpDcVxUcrzUsjO1wsUA40m8EDBP7sUR9emxRlqoH2FFphq12lVattZeFioOUPMtldeuAqugMYqafRkpHJON3KLAtao2NTqd/WshSSKxYO4XuiutjKKwKcd8DtHL/bNHGb5jqPt3A/IKXCzvVSnJjfobb1q24D+Osd6ZGxo76L6r949EzprtTONrl5KiRPDu8jMFLDCrNgqwaeClCnEuVL+w3NiX4ZWczGJzjJcAVPFBdtvQ0p/Dbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68Liuz8jEU6rgqh8/N3zMt2HPE2uSh+uE6MGHQyuHX8=;
 b=rJnXJoxd0uUNYgdM0GyGWg4dp2FVydFeSmyl6fE20RTdouoEYydr5XZdg7AyFvcTq+ufysed3cyHiL8vtO05rl8uDUYFN10QTCmrVf1yj9Mv04FsS7EO5Ee4bIJNlms9IfPDlVeAV7hqnw9UfWTGwvgkwzunEtiBMxsV7vUO4NE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 14:55:11 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%7]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 14:55:11 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/9] drm/amd/display: Add dp_set_dsc_pps_info_packet to
 virtual stream encoder
Date: Fri, 25 Sep 2020 10:54:48 -0400
Message-Id: <20200925145455.2398170-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
References: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::980e]
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::980e) by
 YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 14:55:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8f777bc-fe3d-43e2-f800-08d861630043
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42196286C8CA88794944634D98360@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bW+PYg3l0l21oB7bmuoQsOGkMqX1FUd+oE91Jo1wL9zEhtMkNKaGSf+s8iSMsP219RBmyBKvLEHRRTdL3E2kfjJTS+4Ghl0Wf8TjacWgmMCaDFaTdZw3CyDijviOu+ZbCUHRqxCosE0FjjYnlczJ6U8QRGnvKPZg8b2L8Thrl8P5h506c0MQgWFxOvbkkNpB9Pxh8pNjmNrmCrUFaxYlQZasf00OsM5Oagy8Nb2xaljfHceMF7O3cFanaYl6KKw3cyJG0AG4xvFF6GcQHJFLExnm01buXfhs7+t2gdpjhVbBCobkyuq/uT47RUcN0lAke1dMbCQO440LDGIq0v57NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66946007)(6666004)(36756003)(16526019)(4326008)(6506007)(52116002)(2906002)(86362001)(2616005)(478600001)(6512007)(66556008)(186003)(66476007)(6916009)(1076003)(5660300002)(54906003)(316002)(8936002)(83380400001)(6486002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HkVzYbGqUKkmMBkKJg4tz+TenfCeo8wpA+QHAhfuWCdbYOLduIoPB10kbASmDm+hhfjWN+K3/Teftb+jtDIT5E66dIcHRdplvyNpaYscvCSoLvyqhrYJcsEcYb5yaAlGQ27HBfl1YBVF0eFtaZBe7aYkcp9YeaDwuCbtrR0MsdxxL4B/KdFlaSKUobbNLveGQl3dBGj6c4DcK/NWULeHux04eQjUpbGaHHXRlu5oDFhyeqCUz/vvk6hLSDhtJTho2gdCOYGanEihfgXlfuHaB+Zx+p5hx+5DBfjXNSx1WWMfUmsa1OrV3hlPQW9mSGuqZ4mKtxHijsm2qycPKnum3MJB0Jm/zCVXODm4+F/n89aW7dBccs8CmAXfeWz9vC6LxP1dW8X9ECl/35cho36sW32hp1KID/E+kU185t9JRwyc/7zIhkAn+lLdp41l/FkddRb9BDPaXQkEjEiXncgtZY6mkIbrznXT7s+jIBQfuIwTUbR2j/W1iQQormKjQ9qHBxwYHGNEQGgTYUs/y0ju+OG5xlTWm6g2ymJQMdnH2s4S8H8PzT5KcF0M988ev4EQIzlH7ZOLGsgXUxrnet2oyNmlVhZ0E/Xre9MjGFf3Ic6VsOR7L/2kF4131hEHbRzecHRA1pAt2H+MwBNTvF7N/ODzWp1Q/vX3WkT6QsJun8IKj3E9VW79EUMrhltgujcf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f777bc-fe3d-43e2-f800-08d861630043
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 14:55:10.8698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZirFFeWmBdu+boSjad9PwmWNifr1oxJ7gD/jCUjUyQ687FuGvxPpsMjnWRtfINBUVEmefSyrvveO3nO2A56L8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 21 ++++++++++---------
 .../dc/virtual/virtual_stream_encoder.c       |  7 +++++++
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index dba338c88256..11a619befb42 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -493,13 +493,15 @@ void dp_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 				OPTC_DSC_DISABLED, 0, 0);
 
 		/* disable DSC in stream encoder */
-		if (dc_is_dp_signal(stream->signal) && !IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-			pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(
-					pipe_ctx->stream_res.stream_enc,
-					OPTC_DSC_DISABLED, 0, 0);
-
-			pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
-					pipe_ctx->stream_res.stream_enc, false, NULL);
+		if (dc_is_dp_signal(stream->signal)) {
+
+			if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
+				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(
+						pipe_ctx->stream_res.stream_enc,
+						OPTC_DSC_DISABLED, 0, 0);
+				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
+							pipe_ctx->stream_res.stream_enc, false, NULL);
+			}
 		}
 
 		/* disable DSC block */
@@ -536,7 +538,6 @@ bool dp_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable)
 bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable)
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 
 	if (!pipe_ctx->stream->timing.flags.DSC || !dsc)
@@ -559,7 +560,7 @@ bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable)
 
 		DC_LOG_DSC(" ");
 		dsc->funcs->dsc_get_packed_pps(dsc, &dsc_cfg, &dsc_packed_pps[0]);
-		if (dc_is_dp_signal(stream->signal) && !IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
+		if (dc_is_dp_signal(stream->signal)) {
 			DC_LOG_DSC("Setting stream encoder DSC PPS SDP for engine %d\n", (int)pipe_ctx->stream_res.stream_enc->id);
 			pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
 									pipe_ctx->stream_res.stream_enc,
@@ -568,7 +569,7 @@ bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable)
 		}
 	} else {
 		/* disable DSC PPS in stream encoder */
-		if (dc_is_dp_signal(stream->signal) && !IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
+		if (dc_is_dp_signal(stream->signal)) {
 			pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
 						pipe_ctx->stream_res.stream_enc, false, NULL);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
index f0a0d419e555..1053b165c139 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
@@ -99,6 +99,12 @@ static void virtual_setup_stereo_sync(
 			bool enable)
 {}
 
+static void virtual_stream_encoder_set_dsc_pps_info_packet(
+		struct stream_encoder *enc,
+		bool enable,
+		uint8_t *dsc_packed_pps)
+{}
+
 static const struct stream_encoder_funcs virtual_str_enc_funcs = {
 	.dp_set_odm_combine =
 		virtual_enc_dp_set_odm_combine,
@@ -128,6 +134,7 @@ static const struct stream_encoder_funcs virtual_str_enc_funcs = {
 	.hdmi_reset_stream_attribute = virtual_stream_encoder_reset_hdmi_stream_attribute,
 	.dig_connect_to_otg = virtual_dig_connect_to_otg,
 	.setup_stereo_sync = virtual_setup_stereo_sync,
+	.dp_set_dsc_pps_info_packet = virtual_stream_encoder_set_dsc_pps_info_packet,
 };
 
 bool virtual_stream_encoder_construct(
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
