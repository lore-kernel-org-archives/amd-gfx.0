Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B5DC433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2859420768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B5+ZthAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2859420768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE59D6E260;
	Thu, 13 Aug 2020 21:35:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3108A6E25D
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vo21NkljDZdXZ3MQyJ5qtyzWoiYEnXkhLs8QAMHWrFVzraXmSsnVtdpZYqJx+sRYFSOObpSKvZlub1YwsajHZGhbEQz3VYY1LsMIm8s8DGA5jywgxw0AQFz5+85/+Ta+v5Z50aLiakl0ZQFa9ClD7RkEcS0uAwJ3ZvYQMXnOXuxFAEotUyIyeS2FfhRGDmPQxuq6BjI0lNTJGsWQ+LZ66udZn/jZs5utW0iG7R8mYnq5hglZQjdASSB8tfX13l6UHDYdzS07skmankVTg5oKn1QVwOvRn7UyK65tws8pk91zv2MrpTHZFcaX7uLhe5PUJ9TOnBoz+db2KJaCfbeGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTKG9st7WINq869pinmtzXwz0gSB6BdVz+rEKLzdxaQ=;
 b=cU26n6aQWuDOODYF7KBjjF7cGAvN0GpXdkjXmE1/sC2GAr/6FWIdiWn/HkcSgFGbNxAYvEPhg6w4n1Hf3CDC9AiKJwymfLJOo+Es2S11kOsGxXQmkIGjREYmjWmy96R0LOFPJjnUttOq8gC8CaBvgTgmMsCoT8nqK5ct7PMFk/ZEd9AnJuIbBmUwvxLS7PM73Ygn3I837TKUCzCzgYp2fOgQpeTLJn0rq92qrDw4UDR1K9JPECthMN/9Bokz3a6LmtTIbM1+NhLl6Ozgn43avKWMAON5Nxl3Pi1aRVCzqOPXd+RTIp+h31I6sdWD1ra5fKUvFHaB8PUxlSy3LJCgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTKG9st7WINq869pinmtzXwz0gSB6BdVz+rEKLzdxaQ=;
 b=B5+ZthAjjTLR7M2PSI+XqEwe86alvwZiIhI2sVmb+IewCz6WiuqyyM+U+Ja3UTM/6aGUhaTXqFgNNq0ZOFvUZWNDQIhIGLfPjiYc0nMYjEaYxq7bpj3lD1qOG/RKcf+ybpAP/VXaj/u9Z27Ebw0Lou/FcSNYj1CZkgznXq0QD1c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:34 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:34 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/17] drm/amd/display: Add extra T3 delay
Date: Thu, 13 Aug 2020 17:33:52 -0400
Message-Id: <20200813213356.1606886-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
References: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::2db6) by
 YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:33 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 200d2487-0557-4835-9206-08d83fd0cf51
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1355DFA6AC0D857B123470B298430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Um2aKoe7BJzoySVMK/15F0n75CA7JeUfZsCoiIWyRq2b5geqozLbUvOCuqh50BeNv77vG1WUbwm1Klcn1DfZhZ2J6DLf5mxG05/tuqNd4AzRo8PnCRs1jw36jO0JJN29G4mx1b4LQJos4gdTIEM65fYU2/MBXTrmQpKKlJdjgqznwWEOctOdj0KSU0VTK1EZwivlWhlyBG1FCFQ5YtTTk4P2DjqOBymQI9BOjRPtJ4G7rcFIta+vXUCi1rISiwDr4TZqaf/guGQ+PtUb1FDm2vcG2VrTbbcvOLaWi7Ulo0GSwPbXdvAiAcRp0gQkxl0622HZrjpDyWb9dmlyrtqeSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(83380400001)(6486002)(4326008)(316002)(478600001)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(54906003)(16526019)(8936002)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: iWiB3CK/RbNDrMGZEGfzfE4y3fGraMaPfd/YyLDGB9sb47dCp5YpR+DSk47Bwnvn6A86iYwqdm3sBndnvqCA3kBhD4+2a0qtzAm7tunmR7Io5S2pUAL2QgQYrfXyOyzEOmP1f/2Lo+UYvsh+Z6VlgFjXriXwwvXlkyjX32cRl4A8lF6j4P/cTmQE2Tz4ZtP63l3ahvlGaqxR/p//VIZsdFtYHiC0oqaN6QH93tvcBO5Y4OgbutKhln3fuCdqyE1GoUvSG1l3FJ3sfpt+k3suDFBxaktq5cnX8GAMisZUynuyVwobRx/tXWcwNKQ9Pj5gGL7CE3KG7wLkTP7Pn3P5mGsyg4L/+yvPH9i1gLck3+j5E14JoQI0cAwuvkkWMAQ97ateepbKeuurRPROM5+BeMREHyh34unzNg0fqSbn9/W7MfQaLKBvUBahQgYbe1Wga59eu6orPxVneYgGUWEzB3T95w69S3nBjyuwDgjH5rx+2PQyYB+XD9R5tkbA8GvXDH+EZ5V/3qrja4Um3l47mLQtewmQdM8hJ2znbKki39DUF9er2yrM4KeaLyaig921oEgGP5HmD886gyGhO7+ZkxGIp0sBAlNNNp0pYcCt2i9x2lpeW2EVviIXKlg+dU9kmccQ8PAzaXH5xSxuHqgjLnjRxi2tZLl7KOwK9gyx75bSa0Oeo0xaTfHQ0bkp1Wvs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200d2487-0557-4835-9206-08d83fd0cf51
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:33.8763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDfjl1bpqSN9aV8MBUQnwh5jpnc4KWWsIXmF7z7JefbMPhFyVaT1eh9zHbNQ1eXmpjcdpdo3Yn0VvWNSnKQX+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: Lewis Huang <Lewis.Huang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
For some special panel, it will have an invalid HPD high cause driver
DPCD read/write fail.

[How]
Add extra T3 delay as a monitor patch in dce110_edp_wait_for_hpd_ready

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                | 1 +
 .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c  | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 946ba929c6f6..aa8e0955db48 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -233,6 +233,7 @@ struct dc_panel_patch {
 	unsigned int skip_scdc_overwrite;
 	unsigned int delay_ignore_msa;
 	unsigned int disable_fec;
+	unsigned int extra_t3_ms;
 };
 
 struct dc_edid_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 45c9e9027886..0603ddca7bd0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -720,6 +720,7 @@ void dce110_edp_wait_for_hpd_ready(
 	struct dc_context *ctx = link->ctx;
 	struct graphics_object_id connector = link->link_enc->connector;
 	struct gpio *hpd;
+	struct dc_sink *sink = link->local_sink;
 	bool edp_hpd_high = false;
 	uint32_t time_elapsed = 0;
 	uint32_t timeout = power_up ?
@@ -752,6 +753,14 @@ void dce110_edp_wait_for_hpd_ready(
 		return;
 	}
 
+	if (sink != NULL) {
+		if (sink->edid_caps.panel_patch.extra_t3_ms > 0) {
+			int extra_t3_in_ms = sink->edid_caps.panel_patch.extra_t3_ms;
+
+			msleep(extra_t3_in_ms);
+		}
+	}
+
 	dal_gpio_open(hpd, GPIO_MODE_INTERRUPT);
 
 	/* wait until timeout or panel detected */
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
