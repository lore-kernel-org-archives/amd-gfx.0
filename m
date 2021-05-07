Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45555C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4069613F1
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4069613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA286EE4C;
	Fri,  7 May 2021 14:59:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 161EA6EE4C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 14:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTcxW/StfcBE3KuIgW8mHKh0lpGBXdgSxRa0gJZ75W6oeV0WS5vAefn/3MQJXyoAK9tkYcM8MyHi66Q+nhc3+ByYjuVlBWM94W8ynRbouHvu0ndnMwtRX5W1VWeOk68YKu4eIEcYd6sprhtfolGPzFSoDIShby4pJpdrmKqzay0K/u91ZwAhX/xt4W5YYR0aNaXYpzfz8ri0aWW5Sd1GQVIvsk1lQx+MsXi192D65SlHj/QWm2Jl2iYVJXvulammTdag9wAwHW3M86vk1enp3ncU6Vx4kXaNxTBwHnfUrmSyn/9ysXUp133/FE1yH6gBNuCK8re8QXHfx4P76wYldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAhmKcjIN4boJBcp+aNyNTOpOlB4Nkb2Ol2t9cccGzM=;
 b=ZQyr504fNNTi9b1S5/+ALodu1apU1eUj47tADfYQ00gOfhQHHIr9dVd81UV1CF7TH+XKsmdBCU4t5PCGgMc2FFBT4NS3ImfsP1JhZFLMz8tBkXh2GX+EC3TA2huyG2nwAayaENoIrrnyc5fV3xcTrLQTu0rO9Pjd/GMgmM4nWSIFG5qHHjgjOanKuFYYZPOJlYfS+7MrnAhsQLExRtAEZxK+JVG84O3wBQ3LbjzmpqmaB2AnZm0ewcLxAyyKFoINl+PKqvdGt7VIuZJe7mzdV9s7x1xbV1EpTrlukXF97fDK5oJb1IZHZ9j2PNvfKl87K2xvnk36r9QHMdtnkmnzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAhmKcjIN4boJBcp+aNyNTOpOlB4Nkb2Ol2t9cccGzM=;
 b=umuoFzRVj4Fq6ZkORhCv9g58PelfjEdCZ/6VHhE0rRFry9OR1OrjLIQsRlwot9tPyll9QresDfuMjzNjCji26AnjVE1lAZdk9rv0oBb/SewOozIAy8D2W9AZzAdC3DW67XYoOtj67MBCo9MNFLUw4xi3AVeQx+JlGX6bXDo1HWM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM5PR12MB1786.namprd12.prod.outlook.com (2603:10b6:3:112::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 14:59:54 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 14:59:54 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/14] drm/amd/display: Handle pixel format test request
Date: Fri,  7 May 2021 22:58:17 +0800
Message-Id: <20210507145822.248029-10-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507145822.248029-1-stylon.wang@amd.com>
References: <20210507145822.248029-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR04CA0045.apcprd04.prod.outlook.com (2603:1096:202:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 14:59:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8873f9a-d522-4bd6-5827-08d91168c582
X-MS-TrafficTypeDiagnostic: DM5PR12MB1786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1786760464CD09747E2C92E6FF579@DM5PR12MB1786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nfzaUP1tZd8wWKGgB58WxdImYQgbgoDV4OR7Dx4hxYYfWdLGV4WVeDETk7cXst0Qog6POUWW7u+7palrabvTXsrxKR0srO/cpGkoxsAm08gHZETMQO2Mh0Gxe1qunzIS+3IhVZEX/aNVmzHjimhiPosjOopiPObUvNvlpiN7ajCoNN+WHxdTixNF1yakUkyv7vXuhIEONhFXjJ+BywOUl8X5R95Ayezcei7w3bOHdjILKPmokGu1nDNpDXCasy/lwmRKpGP9wKygOlepAV2qu8z6oGpfkfYr6QmSkqmjrBradmfBRjc7VC9ksw0DncGuMb45qAAPW1uA8+s9PV95L6eFjECl1kWq0w5LYS+W2Dp+7OaOwYPTYhBlvnzSqFqgZcQpokl8l2Fz+0ZG0ee48N1emNUGBUFoisdwWg4Mcqbh5Dx5pCuo3Ai2m6a82wXa7xXLpTYD78rvcEn632LSSZ4cDfZP4+5UOrA9jJF+g7Agc6n8LFGqddApcNsx0WXLDLCDdh4eOMyFRrE747OmFreEUCU2bMW+cl3McdrtyaUzSbUxFLYjaBj3PUqwXqPtFRe/Kvl6hV7onIntJWTJ/Z9tqrnY7VTKT7OOjTW8pEBVd0z/x6DLwMUGd9qP9R8gc2VisqcKdc4B9uhrTFTqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66556008)(66476007)(66946007)(6486002)(54906003)(83380400001)(26005)(6666004)(16526019)(86362001)(956004)(38350700002)(38100700002)(316002)(4326008)(186003)(478600001)(2906002)(6916009)(5660300002)(52116002)(7696005)(8936002)(1076003)(8676002)(36756003)(2616005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VsH2wUfMhQWX3l+vkmBl5uT/Mh7YWQhVmbAfi3PWZe3z5kqwO8qQGQr37Gai?=
 =?us-ascii?Q?UUnUYss27/RdqWgJvYH5LCs03FSGZuPE6I9M3dBX1BIZjnpCLHyeRyL6hVsn?=
 =?us-ascii?Q?Sds9x6VOAM7yzbzCuOo073LihMR7lpLl75vQlk0qVnSyOrCxsZdA4BGL90NX?=
 =?us-ascii?Q?U/cxw3bnDuiDLftSz4PhEx4Q9g7dtzjAB0dPu+x2xTlBibi7WZzOT40KI9TI?=
 =?us-ascii?Q?0+OF6jQhWI721nrXpSR/bMMO4cTG8t+M+JE+Ecv2P/OkzbAMb4INhpHbQqTS?=
 =?us-ascii?Q?1PSGbpBkuIHTLQC8rlGU63Ma/W1vVl5XyeM7/Dr12vjxC5CeDcIuQ75K/rjY?=
 =?us-ascii?Q?T5omu5XT+mMPggR940Gv62RrBLBOrqnClCHq7i/jE40h/I7FSq9hXm6vBX3+?=
 =?us-ascii?Q?rxRlrllEi/Q5EUQ8zYR1CaDu2B48Yh5yPDQlpC+0kJPJE1SVI43wuclL8Su0?=
 =?us-ascii?Q?T/ubb5YzCsBTYvla6WQGNaTQ5chXCEaeb2Am8biGsit7zu8v1t5VHR9P0tfb?=
 =?us-ascii?Q?tQg4FXgiwSsjjYD/ggSMffduwnlWHWHZ18OJidoq3IMF3/PpMggBdsBlPYHM?=
 =?us-ascii?Q?QylUhctG4IiEW9YIOdSiKB5c92vn7gDCtQK392iEF3om10DlnyKSf77F9Mje?=
 =?us-ascii?Q?p0jWqKVAt3YFcCwWVU6Jo6502JUjqsKEuf7cB3TQnJOnTFG+SYKj7FToU1WF?=
 =?us-ascii?Q?8OuaoOQM+/PsCQBTLTIPmBKQC3dv1jsELseCK59Yi+nEur9nnzoK//io/GzA?=
 =?us-ascii?Q?MBLZBPPHswCNUB0IY3+Am30hfL3ltBvHw3nJLVujKlPHGtp++pY1rMcLV4Om?=
 =?us-ascii?Q?aqBqWy7GSjsKCw1Mkkj09aTAETu+C9GeNqL0MwOlRb9osKVt3U7YAY9Fe9Gb?=
 =?us-ascii?Q?D+VwpPa9/CaLUhKTpp0BTKAH+JJVGMVuveXsK588HXCq235lQ5TtJ+KxlqNv?=
 =?us-ascii?Q?Qzw1yUu0jfDebsbOCWmy2rks0KRuXGwH8dP3KlOHQ22MBhdmyLMQi25Vu8gC?=
 =?us-ascii?Q?DtgZ8x1nMD4s32Uns4/fJ9RNh9nNXfzz1iaCSbO9kbzF1SeA8MabmVw3yU8X?=
 =?us-ascii?Q?mlyvRYKJ7pqPznd0RmHgmLmPM4bf1lqxh9RvD6tunrKw+vvi98oZU1CSk2/W?=
 =?us-ascii?Q?RBK187cZoNTNbvZfraZy9ZDFgpM1ofGoTpkgSF4V0/E9jXR1xWl+RgLOBcFX?=
 =?us-ascii?Q?Y4LLwDOQhFidauDDtpMAklZ3V5JfgVpLeDKkPem7PyRmtzo62xMb9vEh76Fb?=
 =?us-ascii?Q?BUfIL8GEvoz7cryQex9ITewKmpG2XeLOKxj0gxG9TpXnEilsAL1GywvAccAx?=
 =?us-ascii?Q?TwHR0oIAKSeuX18o+IfTEWR6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8873f9a-d522-4bd6-5827-08d91168c582
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 14:59:53.9519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtYQi127HRza9j7XW+mWVdisqCXdRRdhkZlR6ZeGTAmSsuFJfY+Y1bzW1cei/RxTGol+yJORphGZI7UbxwOVJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
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
Cc: Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Stylon Wang <stylon.wang@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Hanghong Ma <Hanghong.Ma@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why]
Some DSC tests fail because stream pixel encoding does not change
its value according to the type requested in the DPCD test params.

[How]
Set stream pixel encoding before updating DSC config and configuring
the test pattern.

Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Reviewed-by: Hanghong Ma <Hanghong.Ma@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 27c5d49a7bc1..ba4883fca616 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2975,6 +2975,22 @@ static void dp_test_send_link_test_pattern(struct dc_link *link)
 		break;
 	}
 
+	switch (dpcd_test_params.bits.CLR_FORMAT) {
+	case 0:
+		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_RGB;
+		break;
+	case 1:
+		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_YCBCR422;
+		break;
+	case 2:
+		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_YCBCR444;
+		break;
+	default:
+		pipe_ctx->stream->timing.pixel_encoding = PIXEL_ENCODING_RGB;
+		break;
+	}
+
+
 	if (requestColorDepth != COLOR_DEPTH_UNDEFINED
 			&& pipe_ctx->stream->timing.display_color_depth != requestColorDepth) {
 		DC_LOG_DEBUG("%s: original bpc %d, changing to %d\n",
@@ -2982,9 +2998,10 @@ static void dp_test_send_link_test_pattern(struct dc_link *link)
 				pipe_ctx->stream->timing.display_color_depth,
 				requestColorDepth);
 		pipe_ctx->stream->timing.display_color_depth = requestColorDepth;
-		dp_update_dsc_config(pipe_ctx);
 	}
 
+	dp_update_dsc_config(pipe_ctx);
+
 	dc_link_dp_set_test_pattern(
 			link,
 			test_pattern,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
