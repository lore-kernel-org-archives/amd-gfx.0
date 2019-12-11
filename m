Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534C3C2D0CA
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255982173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c42lncPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255982173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBBF76EB73;
	Wed, 11 Dec 2019 15:33:46 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760082.outbound.protection.outlook.com [40.107.76.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 620DE6EB73
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqsd1cch7Vzkw/Ju93TgODOs2R9L+fF0/rPuzYrrxdAm4ZnAGR0CCSlw4Cz3CCoB+JDUgpGVS1wB/PBECvZSJswNJ6yiuzZlS81X+5HLBFfASWQZNTs28e91QnG5S4q/LKsCXgngUySFlIWEVxY5MUQ/s/vSK5wLt5WUERXdPB0+VrcVAVoOA4WonM69UuVd2VfEpfaLya71smZWnI7DQU58OGb9qN6VlL96kwkY0ub/Bvjr5efU/Ce4AaaDpPMA3BRjmHavzuv/lO2kDyZLRKFPybTNENAAbKR6tcykmVXnITKwUW1elvX9+BO3ADnu72Sv7N4hCMgD5TSsFWgrqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2jQ83pTxBytrXVe73fKKFDcU6cdsLDoDla5aH9XOg0=;
 b=ACtpgcQyC+j0Dxw/KYSTH19glCVIxdeAksyk0u1+5JJcNoBV7LQCk+/BG8o/248FxI4xzDRKGb7c+dhmHlANdgHqqlGmpWozBtIvF9L8uz/iCa/jHDEw3q5S/4m5dhpleWfIvUhx/vyLC1fiT9DzkjCwHnzYOXEc0arPEIC1iD1/S816RAAX0MCzCe6SdNmirZ4wwq/4IdOzu0iyf+0QJhE8qtaL3VzLUIc2pr72bqdn6H5KoCtS+66quqZTPh0iw/Q+YZao9cIqsfh/aXVuG3C30psfkWfpzLiXkotepXyD0deFdHjnAjoo+V9W6uszQ2BmN+RdV/bL+//f/7koTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2jQ83pTxBytrXVe73fKKFDcU6cdsLDoDla5aH9XOg0=;
 b=c42lncPqRV7BhJvVCIvgJNS0vSt3Lsd6jqyS2tNktK2Ips34/lNkmESyFMMApnoMlyd6kv+MfbKoZDNRhcU2nl/dN0WYOLhQVWsdiaSynBhRW3izFWqx8CmqZ11zxzANs4xsyCLFjn/+STsxuqAG8qZeDVQ3bov15MQ99idbk98=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:38 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:38 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/39] drm/amd/display: check link status before disable stream
Date: Wed, 11 Dec 2019 10:32:38 -0500
Message-Id: <20191211153253.2291112-25-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89cf35df-1c4a-406f-a274-08d77e4f7e02
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491E7D5CA9A50D60464F8CD985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTJlrBJS3HjxTgNOxpcYUfOTeF0O7GvzMC+wmIP/yh2yWk7xiO872N2IKCwet5pmTpKoHcmzU65ZUtyVWAc1/4r6c2tNSlZOglquY9/+a5Z8OeeD7zu4EUdxWPrE82kuZwyaa7RbyFyzm+9CNDVqFqU8sM3BQcdjwRi0spYVUEdZTi8ziP/qvjL/Nafm813jpRgocT0UDoFNPbKvbEDK6bYMe76deYcMzknaAkhaUcxRwIUsdsnA0/XiRwBycz07F3AuTOIfNhSP6uOJ6FXubNkguJQNgvv6p7RZTRBtBZ3KLinVwayRvSXFJQS+O8hF9PqLlV//wPmnfWmSEoKZcgbb5JJn3+60MPt+p/CxeI7byuu1RYZFOLadhp5SCP5KSCxq6oZIRsj7GKrcXxjKJJtp9eLYpCLNP63Sm4ywAyzRru2ucLgliDb09BOP5g+I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cf35df-1c4a-406f-a274-08d77e4f7e02
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:38.0191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnfvaCwGKLc+9vKXDZascmnWR5TT5QJdsr7quw+zokLsO/x8GXnbSmHIYqclYIoV8o8/SSwnNiuV4GC/4Liylw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Paul Hsieh <paul.hsieh@amd.com>, Harry.Wentland@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
1. Set second screen only then unplug external monitor
2. Enter to S4 then plug in external monitor
3. Resume from S4, eDP will not turn off when OS set
   second screen only
Sometimes OS will not set eDP power up cause eDP dpms_off
keep true then driver skipp disable stream

[How]
When drvier try to disable stream, add link status condition

Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 11 +++++++++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index c9f7c0af58e3..aa389dea279d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -860,6 +860,7 @@ static void dcn10_reset_back_end_for_pipe(
 		struct dc_state *context)
 {
 	int i;
+	struct dc_link *link;
 	DC_LOGGER_INIT(dc->ctx->logger);
 	if (pipe_ctx->stream_res.stream_enc == NULL) {
 		pipe_ctx->stream = NULL;
@@ -867,8 +868,14 @@ static void dcn10_reset_back_end_for_pipe(
 	}
 
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		/* DPMS may already disable */
-		if (!pipe_ctx->stream->dpms_off)
+		link = pipe_ctx->stream->link;
+		/* DPMS may already disable or */
+		/* dpms_off status is incorrect due to fastboot
+		 * feature. When system resume from S4 with second
+		 * screen only, the dpms_off would be true but
+		 * VBIOS lit up eDP, so check link status too.
+		 */
+		if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
 			core_link_disable_stream(pipe_ctx);
 		else if (pipe_ctx->stream_res.audio)
 			dc->hwss.disable_audio_stream(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index fb667546db09..3706299906e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2002,6 +2002,7 @@ static void dcn20_reset_back_end_for_pipe(
 		struct dc_state *context)
 {
 	int i;
+	struct dc_link *link;
 	DC_LOGGER_INIT(dc->ctx->logger);
 	if (pipe_ctx->stream_res.stream_enc == NULL) {
 		pipe_ctx->stream = NULL;
@@ -2009,8 +2010,14 @@ static void dcn20_reset_back_end_for_pipe(
 	}
 
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		/* DPMS may already disable */
-		if (!pipe_ctx->stream->dpms_off)
+		link = pipe_ctx->stream->link;
+		/* DPMS may already disable or */
+		/* dpms_off status is incorrect due to fastboot
+		 * feature. When system resume from S4 with second
+		 * screen only, the dpms_off would be true but
+		 * VBIOS lit up eDP, so check link status too.
+		 */
+		if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
 			core_link_disable_stream(pipe_ctx);
 		else if (pipe_ctx->stream_res.audio)
 			dc->hwss.disable_audio_stream(pipe_ctx);
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
