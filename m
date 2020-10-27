Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606C1C63697
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0029D22202
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HRseINsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0029D22202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8215E6EC5A;
	Tue, 27 Oct 2020 20:53:04 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700074.outbound.protection.outlook.com [40.107.70.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56DD66EC5A
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4YOHDDQUABT+cK2+zxXZlLLbEUQr4WYWQntis0PvFmA0+vvtzX2197H6WDzRIl7zdaU/Cg9QaG3YeOUJy1CFdKw98W8/fRt23Q4ntAc0mqgKtxONYbwYSVWWZ8ubjDOVYw3l/xi6WPISKNt9dIzpFHpYmNTw8yCF38u1zN6YxCOPr4RdXWDPguUq59cX4BiogEYh7uuiMb9MuHO8D/UvdlPCVq3pBUtnSagQmFQTMLxJ9SSAxr84DL/NPnhOsV5yYbcsAeR7jpnGqR1yweAKKS8Ori/O5Y1GgpDLfJg06s1hKVma7NWboYy51zyfWwLkoxTuDe2plsC0A/4pu4aKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgCO08IwtOYi6dNQTzSnIch0kCjVn2dMi/I7RzVeTz4=;
 b=apMuGsaUYALEeC8XB20ecdjVtXsGXP3kMIIcEmb7BnHPJhTAO4+6owXcF8dyDCHLQ8SD8/RXCP0agE8tFDpWKujbuhOEgosGY10U+nf2QDvwos5cJYFOp0XYF8F/nrWmj0a6u/PZfH/cvSVsrwCs+gA1NjSaMrWYtTgIsrA+Xhlka3Nm6Gm5kjHYbh+Kgi6z66ahvMTbWvT3NgLM21+WIPbX23hoCp2nxetCV7i0jYr2Rs6XeVoUA8xTOgIiwhTPB91I5Ve4ZZq98/7Kwyiy+kzhTNhI8pmFyAVDMJs/RoqecOgOcThu1oWBQMpgdCX4uAfJoARTznlm4yvbM+PlqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgCO08IwtOYi6dNQTzSnIch0kCjVn2dMi/I7RzVeTz4=;
 b=HRseINsE36fSDU4vcp/SBba3CDvqBswyr855jgFlvk8p1UXCPck9uKPvx1HOOuUL6dgsuh1ZbrtGQw6W4nyMWnEIaoxQd1JNKEct3XTL6vHkVMepIamYkEUZYRAZqJuMdNcwozhSFO9nn8jfTn6Sh+3YS21rMaoTPqoBe04+FI8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:53:01 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:53:01 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/25] drm/amd/display: correct eDP T9 delay
Date: Tue, 27 Oct 2020 16:52:22 -0400
Message-Id: <20201027205234.8239-14-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4118122-eae0-4a39-8d71-08d87aba4640
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595D8FD33856C621A90F725FB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRxIt5HIIexL74MrtP1iB9umCTxIFvhZZzFRb1XQjnKQHgrtMVIxpkTGF7QG2K5EO0/3gnPR3e+DcmCvQLdL8RtrLtdEb/SkW3j2NQ8RGUPC51gzT+O1tiyhR3Wg9ACOIOzMMZ6fwKJuO6X8tkHEAMQ5u12Wm4ICP4gw4RGLXx9eECo7KDYaci56u/dbH+RsPQQz3dSOCU+kJMHLISZ6bi1wKQXzQRwfdBtuj7eEiID4Bvz0H8km7+UWSGdB/s/ytDhgjryR94sYvbIDEERUpFFKr3J1Bo79IiBDasAaySrdMB4Ldy+gKMitx8eXfEqy35Rf/9vLHpny0+0d/+zqZJbCHu6QYGgH6z7iIt693aPYLqxafjD2rcUUgEkrcglu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8dy869MbsgEOQI4gSp1g9nDXEbcTiXdCJi4hIaSJciGAQVayjp+aKI6WREIfdeghyOxraHqJWMz9+7pTvGTdOwLTb2tZCagw/v3YZJBn0+zOGlh5qJd5ydSDrZ+i/VFN6kHRmQxFrU0ZBwjYb1ga981OUeMYlZwOyyZ2/kmD9KRro6c5l8xTVfUOAhyxfA04SFwJtjHASaPvs1RmQO9qlvXgnpDeKpsGwkWIRipEULW1W90WcQS717AjDB4ld8MR75uihs9k6eFTwT01bRkr503xCD4sNMSftM90lo0V1eaF/T/DxGDmd3/CA3RUWfrgOiPZPHCRdQhw/yMjzhIOfLsrXyyoeoOD2CPfF5gCo48AXkVZpe6X29BZG+ptajCGU+NWcsSLmtcdvdAsbqwugs6ZqUZ2eF5ZbHQQy4mrzyrD9UKmeHLToaVZgQ1ZzCKmOuKG7sg2vPoHIuctVoZRCV5r4XuOCSW/+CvRz3Ib8UVPh9iAzhsGNFR5Wgh4vpRQIVyUkLKKpL1c6xt3ZOkKIDfDs1lcQW/fkKHLQ4J+4poHx1KRnmjkrWDZuNiR4dPUx0gavTTO+NlbsHtH5CpEHIvrCLlaXmhn1sn9hGSVufw+CLoK2Dd6nYPcBqrJV9aL4RHjY1NJA35MCDGjA/GPDg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4118122-eae0-4a39-8d71-08d87aba4640
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:53.5575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VS6viNfUiTrMA8rZnDkVV5luhnpNirT91gkDvAUcNQtvLDRwq+anzCHUwgUCKv1w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Hugo Hu <hugo.hu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hugo Hu <hugo.hu@amd.com>

[Why]
The current end of T9 delay is relay on polling
sink status by DPCD. But the polling for sink
status change after NoVideoStream_flag set to 0.

[How]
Add function edp_add_delay_for_T9 to add T9 delay.
Move the sink status polling after blank.

Signed-off-by: Hugo Hu <hugo.hu@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_hwss.c   | 13 ++++++++-----
 .../amd/display/dc/dce110/dce110_hw_sequencer.c  | 16 ++++++++--------
 drivers/gpu/drm/amd/display/dc/inc/link_hwss.h   |  1 +
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 11a619befb42..124ce215fca5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -156,6 +156,13 @@ void dp_enable_link_phy(
 	dp_receiver_power_ctrl(link, true);
 }
 
+void edp_add_delay_for_T9(struct dc_link *link)
+{
+	if (link->local_sink &&
+			link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off > 0)
+		udelay(link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off * 1000);
+}
+
 bool edp_receiver_ready_T9(struct dc_link *link)
 {
 	unsigned int tries = 0;
@@ -165,7 +172,7 @@ bool edp_receiver_ready_T9(struct dc_link *link)
 
 	result = core_link_read_dpcd(link, DP_EDP_DPCD_REV, &edpRev, sizeof(edpRev));
 
-     /* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
+    /* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
 	if (result == DC_OK && edpRev >= DP_EDP_12) {
 		do {
 			sinkstatus = 1;
@@ -178,10 +185,6 @@ bool edp_receiver_ready_T9(struct dc_link *link)
 		} while (++tries < 50);
 	}
 
-	if (link->local_sink &&
-			link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off > 0)
-		udelay(link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off * 1000);
-
 	return result;
 }
 bool edp_receiver_ready_T7(struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 3ac6c7b65a45..9f56887029ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -992,8 +992,6 @@ void dce110_edp_backlight_control(
 
 	link_transmitter_control(ctx->dc_bios, &cntl);
 
-
-
 	if (enable && link->dpcd_sink_ext_caps.bits.oled)
 		msleep(OLED_POST_T7_DELAY);
 
@@ -1004,7 +1002,7 @@ void dce110_edp_backlight_control(
 
 	/*edp 1.2*/
 	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_OFF)
-		edp_receiver_ready_T9(link);
+		edp_add_delay_for_T9(link);
 
 	if (!enable && link->dpcd_sink_ext_caps.bits.oled)
 		msleep(OLED_PRE_T11_DELAY);
@@ -1145,12 +1143,14 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 	if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
 		pipe_ctx->stream_res.stream_enc->funcs->dp_blank(pipe_ctx->stream_res.stream_enc);
 
-		/*
-		 * After output is idle pattern some sinks need time to recognize the stream
-		 * has changed or they enter protection state and hang.
-		 */
-		if (!dc_is_embedded_signal(pipe_ctx->stream->signal))
+		if (!dc_is_embedded_signal(pipe_ctx->stream->signal)) {
+			/*
+			 * After output is idle pattern some sinks need time to recognize the stream
+			 * has changed or they enter protection state and hang.
+			 */
 			msleep(60);
+		} else if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP)
+			edp_receiver_ready_T9(link);
 	}
 
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index 9af7ee5bc8ee..33590a728fc5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -51,6 +51,7 @@ void dp_enable_link_phy(
 	const struct dc_link_settings *link_settings);
 
 void dp_receiver_power_ctrl(struct dc_link *link, bool on);
+void edp_add_delay_for_T9(struct dc_link *link);
 bool edp_receiver_ready_T9(struct dc_link *link);
 bool edp_receiver_ready_T7(struct dc_link *link);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
