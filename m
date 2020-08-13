Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36542C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE2C20768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FvbpFobq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE2C20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 614EB6E0DC;
	Thu, 13 Aug 2020 21:35:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC72E6E054
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwQFQOCCfB30kU5oC5+5gBKaOQBAi2eZtK+7CipND4UVC4lCfE8LMMmhxguoEKDCfm9ZKsGc2sASvchPsfJX0aXKZBQEX+Dd8TXDSTJ/sTJ7foJvGOzOT0Dzvtf9XSMSVYfcyyYluZwIcH7M2Wkq0UORQ22iYgP5VhBAexHLTfVlsrsBqR22TJ7F3UPmq4HehaEuVMeOvmxCXEOqtx/njxK7DzVLsAcTyE1e36sCmbwW2j7OWc/35Ljj72N++biH21q7YvCS74JoMrkpdQ5tjYqwVsuZvFZ4TFZYrOYYfP8cE6rBKM+vH0BYoSwHFwas6W9dUgmKj6chFSMaHZ9fnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMLlVms2Du8QQ2bodrPDvTd0ygNifFX1dC2Q7EIjYxU=;
 b=eF0cuRXvn8iypP4lraCN8xbvRyDJx6KEzi25b6Owf025KWReFEJoVK5P3kLxZjcQb3M83NLek9NWIOj8H5vb4I2KAoqN5pCz9e5hSfzwuwhHWxzKe64xlhgaO7A4pRkn+mNyDcQVK9l2tyurd2qphPJ6vLE4LVTowpq85x3Cp3LV6QSM00zcvGSSXh1XQbiaArtIkrOHXMvKfRjqa3yrhSSf1RRNwPRdocEifJfZ0amVQxogzarkvvjq/6VgxXxTl4bN5Dn7+Vbc+OcUG8DZVJ9BayvG7eQcU55is6M7IL/LGIeXyHPyzipBH4z1G5DNUfuEdIxhw8QA/lXcLpKIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMLlVms2Du8QQ2bodrPDvTd0ygNifFX1dC2Q7EIjYxU=;
 b=FvbpFobqaPrPGw6Xwcu5/5kY/Oz4lSj2b7qOkUlDHySdNfP/ApzziTqnfjwyTGnJPtIs7AsBADNe5Zlk2UJ2SitYtGX15BiBVQ7jd91WqVmejg6bETzaUbjzilORlu3UiVX+L5IkvIbMx519bZUUApAovo1a793xt3dB9k7t8ag=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:25 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:25 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/17] drm/amd/display: [FW Promotion] Release 0.0.28
Date: Thu, 13 Aug 2020 17:33:40 -0400
Message-Id: <20200813213356.1606886-2-Rodrigo.Siqueira@amd.com>
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
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:24 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 222141f7-1d8b-4453-20f0-08d83fd0ca2a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1355FD51A7B1D31AE743CC0F98430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 13ImFt4KNy1EhweLLIA0G514gTR/pRcIIL+L3nxZP8Nz6muy+eOepzjmv4lKu/mDaTFCxDO4i/Ws0VMyIvRhpgQ7/LKD3U7l3IDeuMRDHt366Gs1m6Otj1MZUAFCZl/rtgxWZGdfldSMPAyPGj93c+eBqohPz/wYck9uEdppGHg8QeqRYGzznLM5q7RZJmZXjkUS5oMahavdvNG2XaUOY38VGaZTgXLyxoVn8BqTUuzUTBZQi8vfiFWDjOcOUJ0mTzQlv1W00Lmck6uW3Xq9OiwX4bvFGal4lg7AlDCMwLZeTaja2SvNnQSrkbdYrdC7/b1zMHsI/60pJVaMypJ2QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(83380400001)(6486002)(4326008)(316002)(478600001)(4744005)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(16526019)(8936002)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: vh2cnOBuhFSzq7SH6JApgwAYHlE1fpMr0/3zFzxaAcRTp6HSNUfo67q5l5RbfA7Rv8qw9c0YMsEC9EpUwg5lvY8zLV+QwMh5vGWl+d/h6WBRpJHBem6JHrl+s5Mb2DTV8NNyko2Cdh/2IXVwzn554Z7oebTcDn5L7PNU+I36ilIt5eBfvkwseY7BkCihJkO0qAsE5AtS9MIGM1FRGDYF9RZoad6bmNWM7a0d2ABGX6KBZwQnWhRR08EXoayo+5OKwU7SRKoSSS+8Es6pSEyDNouPwRW/RLH1Be2imsnHlMjK4xM1TGUrD5Na9ZlDEiFUNkLJYqQ/d3U0jUSG4lPdWeYVE5rdPwaz233TPlrGKWUO7OxmYQbVXSEW0VKODyXT66ar2zPHVYcBfGe7bW1Oc5nciSo5WZ7pZuUUQgN5GfxM1VQeg24iGNW50erO23t3zULZolMmC3BEEjzELk0RKj/fxzCWg8uN+51bH0ja8ijMId4ox8FUJijXKDsDU1aN5SotFPlFIR1G3wMlYO1/YhzrvboPlqyaRJWtZhXdJdlPQpNFq4xEb53UNvI52CMFFv43ETVHarJxVTileTQ0nwEmYunYR3pfDtclj42T8u09D3NUiQ3WxM2uRU7oMfn1jrXnU1j3wdrIzUdJXDI/fXkUNQmQPh5zZKnFpM9I0+lm0RWXtI7JV32cyIyV1OlC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222141f7-1d8b-4453-20f0-08d83fd0ca2a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:25.3866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2N4H2fjETJvvufm0mYYNg5Q9TJP2h1t/UjbGhmdksqNB3Tj7XFbpPxQnDtD0xGKojzyHtaEYqFtJIcTdwMYrQ==
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 55717ae4724d..b58ed6538eab 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xd7f4bb6ee
+#define DMUB_FW_VERSION_GIT_HASH 0x3f7e3738b
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 27
+#define DMUB_FW_VERSION_REVISION 28
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
