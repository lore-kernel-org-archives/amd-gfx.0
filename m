Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4728EC2BA19
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F4C20644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fihxACs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F4C20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6EA989F53;
	Sun,  5 Apr 2020 20:41:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F1689EA6
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJpjBGcehgPqAdpYsP27lvdUDtFq0C2OkD8gypq95lgpg23ADhjjcaJznL58iwd7wKJw1G/+nNXyk2sbHmS+IWzjhO9tqOFMbK/dCndfWpWHT2TOS9LfGLMO9QVlynXZO5KUP+1EzYDVI62GzNvrv5WXop+nmhqD8pTSCghl9R4bYmzO/W69hacZNQmqI71S2Ex/XyD2vQCDihbc0dP8tLP5CHsXTeIDn+CHUKRTF8/CUDYbDlYNXZjTDb8I+TUcTbQqTKJ1BDMelXXF85wICnyXeykQkrPgcMwEsCWxOTFS2q0Ai+1lPxVQxkuZNyrymjcgKhNLGVuzXTUY2eUjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8h+GDqokSJMcDFm8WMecx79jT0O/Z1FstUQw9Nr9Ovs=;
 b=ZPBveJs5SUSSpaX5zOevPE9k3yxOSBm2S2+URsV/UKxI2+pPNywCYtfIiHpsHsmYMaaMU0+Ex18Mkt4x382/7u/KtcUNR5Jl0YIY4xEFUf35r031ROv6g3uAPr7vwydrU8otwX26dJEB929sVcSZhDn4LxdjcewEAuIH8Oy7WEHqATreTWC8h/fp+IJbypiEa2coiIQdUpb5hMmEFEuMsFxpn7YZ9KCJKuNJq1sp/CeSaQm79NYymzaZO4R24T8nm7nm8al56QqlY6w69HcCvqgEt6fxYvEQihz5uLkqLvfA6FrTa0eT4LIQjxj5Sd3r+sAQETJ7EWo3Ha/aZ7eHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8h+GDqokSJMcDFm8WMecx79jT0O/Z1FstUQw9Nr9Ovs=;
 b=fihxACs+cM/+NMt+TGDT6TeF/jnaGFDPUG+6g+NO0eEKVbZZMO6wkofcrpVzZw8Ne87+GrKqdIMIpVAXbV2qBhJLOswPGLg8ThhrnaTYR/HwJAYt96jGIkblKvOwEi9lGoYG6MACumb4I/FwnDDjo5oGKhfS9h7Ar6bfvtyfWSk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:41 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:41 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/36] drm/amd/display: Program DSC before enabling link
Date: Sun,  5 Apr 2020 16:40:42 -0400
Message-Id: <20200405204115.683559-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:41:40 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea5c17b5-dd2e-4b1d-3c05-08d7d9a1bef7
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25558101010F9B3C5803162398C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEvJsljOIUg9HYew/kC9QdPVzPNGrBIVSqEjdpb5nbQfahYLRmeCnkuNcquP8e+CpSdfKGM/Q52Ja7E+y/KYTE131zIWyNuEOi0PXi6BtzIj6abNH1ypOhUksgfCtQisiUP4um1ZThWanEc/B9C9ZN2X9byHwroZz5THbBLgyTkcs1jjYJfYqq2SPuvhfXrrw3zfQDPsJqIwXMmVmbMGxO9D/76wzASoalHutSgOYrUW9EyXR+aPe2d5O5RW/ZV9dygBKr5ECW1VghWlljEuPldQitXoUmPm+g4CFkfEmoG97BFmubppzgnr7CCuuA3j3j4+ZCm0kCRFLLt2Ib6akIxr9bnFck2vSPRKaWWJccKjw/mlv/oZLZNzZWc87m9OUwbDfodQWIj5D6VVfhuNoonY1ZiWswcsDBGnBV14mhnRjFyyf+WINMsiDkFZqsTK
X-MS-Exchange-AntiSpam-MessageData: np/xwdpU3WJxUhMVHzy72mgt9WxjTQNh7cnFuWsWzqPT62AK1N29BJH48uUFeXFtYpWv5ucwSvEJNnalIRm95UIfV64QqmEgXA04M6j//iFVeDzzWfF6iJ4fp2LZoF7jtVD8kg14FJr5KY6B4mugeP+CVmL2yNN0pVaZ2zWvMe0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5c17b5-dd2e-4b1d-3c05-08d7d9a1bef7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:41.6108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tQWFKfmn4Y+hE9alO5viV4um1Z+HWyID2Hjo4Oo1uFcPpnXWljZgnCS/QcvLjoEWQ1fvmpUGFd6tcRqTj4zzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Harry.Wentland@amd.com, Nikola Cornij <nikola.cornij@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
Link or DIG BE can't be exposed to a higher stream bandwidth than they
can handle. When DSC is required to fit the stream into the link
bandwidth, DSC has to be programmed before the link is enabled to ensure
this. Without it, intermittent issues such as black screen after S3 or a
hot-plug can be seen with DSC timings like 4k144Hz or 8k60Hz.

[how]
Move DSC programming from before enabling stream to before enabling link

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 67cfff1586e9..ecbf165b5775 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3040,6 +3040,18 @@ void core_link_enable_stream(
 		if (pipe_ctx->stream->dpms_off)
 			return;
 
+		/* Have to setup DSC before DIG FE and BE are connected (which happens before the
+		 * link training). This is to make sure the bandwidth sent to DIG BE won't be
+		 * bigger than what the link and/or DIG BE can handle. VBID[6]/CompressedStream_flag
+		 * will be automatically set at a later time when the video is enabled
+		 * (DP_VID_STREAM_EN = 1).
+		 */
+		if (pipe_ctx->stream->timing.flags.DSC) {
+			if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
+					dc_is_virtual_signal(pipe_ctx->stream->signal))
+				dp_set_dsc_enable(pipe_ctx, true);
+		}
+
 		status = enable_link(state, pipe_ctx);
 
 		if (status != DC_OK) {
@@ -3067,11 +3079,6 @@ void core_link_enable_stream(
 					CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
 					COLOR_DEPTH_UNDEFINED);
 
-		if (pipe_ctx->stream->timing.flags.DSC) {
-			if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
-					dc_is_virtual_signal(pipe_ctx->stream->signal))
-				dp_set_dsc_enable(pipe_ctx, true);
-		}
 		dc->hwss.enable_stream(pipe_ctx);
 
 		/* Set DPS PPS SDP (AKA "info frames") */
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
