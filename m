Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01971C33CA3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8AAF2080D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kYbOjsfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AAF2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 969FE6EA56;
	Fri, 10 Jan 2020 14:48:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D476EA56
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtTBni1/LT6F9gDT72kIa5uJR+xbaUi7rdAMuPB1Zf+yQ7GFHKkwxDFF4q1coqIMT1cEQMgSYSO1UwssNOOWFCqhfT13TjUDFj5cUamzK1C8DJ7aKyEp0WGbro5A/h4f18TFhJIjbJsRMdj07j0TKjjRuQHDeYsNvJ/WhpjOiH2a3U/uw6Bb0zaI3js+mANu8HZwL2q+i+ilyKDz3ML2D0bhupqeZOo9sW/HDtx9nV37N1ntqUlGMqqANBX1UriTgMV9sMLKgrQ2TXM3v5jpurlXuVf/eQDZlq4Er+44luzLneRzDh9Ju5ciBlU3qPVWEOQUSS0ZaryeY0vHyEdxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naqQcCQs1vMxg/5YHHrnqcUNUIQqLRyXdNZr87tX5Cs=;
 b=LXr+WPfWVlvr2arvn6bUHeY06Fbo3DlCQDwZo9B+Xvn5e4RenxPmMfa+OH2FTg/evhQbXkEi46Bu11AQ2LnYNLqxWTBeNBSPKicYiloJ91IUkcPILcKtY2fp6Dm4UWb5KXJc2t59+0dTuMkPzQ9QLX+gPKY3aETwlm370LVpjKZPY9sr70K5MYr0fCOSXvImGYQUyRr/0wCN+N8raTTf8mGLWimleihzVv4j+zhNaBAy0a/HFhE9s/pumhSxAGcblM/BCJgAoOKO0AM1m+uk9EvJLigoRpyNosxagMox0b/vBv6ZgXXTJlj3KcovAk6n9Hil5Lwy27OThmCeh7gyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naqQcCQs1vMxg/5YHHrnqcUNUIQqLRyXdNZr87tX5Cs=;
 b=kYbOjsfQUpbTvlMRFaB09bbq+Y4ZTzDgzgKC1iFWNftrsCufI9yaXb81jtZO1ljg7O4ro2q0YEbaapXLpukDwYL1SuT1dVZaJ6fD1guchCC1vbnBfOVbdCt44vLUBeSsATts+pZPXAVuS62Rig/95OARMkncjbXhzQUUlI87SVg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:48:23 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:48:23 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 43/43] drm/amd/display: skip opp blank or unblank if test
 pattern enabled
Date: Fri, 10 Jan 2020 09:46:55 -0500
Message-Id: <20200110144655.55845-44-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:58 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc44219f-5a1d-4be4-f178-08d795dc15ea
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25249FA9C3FC42158B67782598380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtYWIZywhi5PwxlZ+Lt/X0AG6tOf1iEmCKNnLE+sP3WabpVC1B759ueuHbRx3xHGTTv0BYfOiajJJThNaItxs2G3oOw9iYCbDOHK0+qOQNX24zmImJU8HozV54wdERQdLRacATX4x4hiFZkkUU1v3l50fDyj0aoh5aO0DIPe6eh8F5d64EsSl5ADqrfHqjdt0REsLZi5X/ZM5k+ifUh/MW+waNekGNBtViLC+SPs+zP7LkBwTGLqR6RMw1i0Efb1y3lDQiEzJqK6tu/O8D/A1fvSplKLiVk3l9pfcYK1PyO75Uvc8dArG1a/yWqwfQEIp+QaInFV/YtE89Wmr5Ow+Zl8JOJ1taqw/Hf4jrduPs5NCP8J2TIZerIa7ceQj7Ut+iaV6F6kKT+KUkBSfatD/PFt6rtgbndhgVdKMCCvZNWQtdR15Zcf6y70YUeteYzz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc44219f-5a1d-4be4-f178-08d795dc15ea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:59.1615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Blnkr42f8LYBSqGDZojtd8GNEjesF+Ro5O0q5Lgd+5FHQJLtp0Thbm7JmRqQ4k3ZzVdGDgEReqOaZPhAYEW0Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
 Nikola Cornij <Nikola.Cornij@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Wenjing Liu <Wenjing.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

[why]
DPG is used to generate both blank and test automation test pattern.
When test automation is running the requested test pattern can be
overriden by the blank or unblank call because it is using the same
hardware.

[how]
When test pattern is requested, skip blank or unblank.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 0dc652e76848..6baccdd65d3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -945,6 +945,9 @@ void dcn20_blank_pixel_data(
 	int width = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
 	int height = stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
 
+	if (stream->link->test_pattern_enabled)
+		return;
+
 	/* get opp dpg blank color */
 	color_space_to_black_color(dc, color_space, &black_color);
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
