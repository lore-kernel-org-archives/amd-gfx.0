Return-Path: <SRS0=iabP=AP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D99C433E0
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD0D2075D
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ggvol7DS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD0D2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 490096EBE5;
	Sat,  4 Jul 2020 01:15:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD28D6E3D2
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jul 2020 01:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E324eW4LXDAD4sW+yjzqRn1r5YhBXWLiVUZxD7mzMl4HigensGACQZXr8Ge3vQse+3yTmDWGcVw/DLD5pdhnp6NHcLEpRggG0mCT6IA7WQIUWLJJic5Q3wQaz/j0UmXEW+lXFOvi2zD5COvnkYgF0BY1w3mXjqRQi8DGUz0OUBlD2b09NxiPziyGsLR7mRs00RFYPXZJ7UbvLNvwN6Sxz40Iu2EArhYjB59a7QLo3VxlfT0PSidAjW0FtlOkdDP0dlqwTh4NoPexyvh6/bC6qyiT3ZoxxmBGB6DYpsaZgNWqtkf4js00wc07qXU9rvlKNsDcHCa64K30tEhp52YQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d7gbVcaeq+vvdkjuomI5/Fbs5DN/vWy2FyFBaQgUCI=;
 b=Dtf/32PvGhM3HnppWfSCDpRy5fw27560j8dXLBdYspqYcmc4tCoSu6FhtLlXqH2mjraS00h/vGJy97bgC8FC35clgpnqH0LyS3lPqhlYuEeP9B0dvmsSY1kG8SB4JHIyQaSM0cWrnrYkvsoUKXbtvnOHQ2O8+r9OtL5O5lfYP/Wj4h+vkIdj/DRFaDwqM1RPRJP+EP2kqd/UtKRl3fARmhwmv5XRo0SrSCshaPcJGYXODVwbidIPbekd5F8mrdLjICfuMRPzjATUy2ZeJ0QOwpvDvnv3SzprF9488eALBnAr5JUv0L82f9fAgZcd32ywhu9SNaf7UjUpmjnpJt0yQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d7gbVcaeq+vvdkjuomI5/Fbs5DN/vWy2FyFBaQgUCI=;
 b=ggvol7DS3Tcwl2p7bssV5QGx1Zh10/dqjN770cJeingp1V/um1moO91DNlQn4AqW3OITN6/kBLK1b6XYbKBfyHVwhSv8gC02cUjNDsuLGfIXEjsAA1bCdBGD5xO4RGl4cbPSOt9pr0Kpsky3Kra0ijmsQBUqiG63ZfxxQ6MskTw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3768.namprd12.prod.outlook.com (2603:10b6:610:22::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Sat, 4 Jul
 2020 01:15:27 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%8]) with mapi id 15.20.3153.028; Sat, 4 Jul 2020
 01:15:27 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] drm/amd/display: 3.2.93
Date: Fri,  3 Jul 2020 21:14:55 -0400
Message-Id: <20200704011457.2368241-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
References: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::26) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Sat, 4 Jul 2020 01:15:27 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c5f0da5-5f46-415f-2c6d-08d81fb7bc71
X-MS-TrafficTypeDiagnostic: CH2PR12MB3768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3768FB08E0825693DC450F53986B0@CH2PR12MB3768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0454444834
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fbqH1LbiRGgJ3hMibqkPAx8txdsqLF9EikRJFVl0aNfhEC69qgg8yQWcTZKbx60eUBpwbYdnDF3Xkggpo/yvYGLarFQlfhiiJkSiScMWlTnh+0YpZIS5Ew0jDQRoJIUA9mGbECxfkBMmgyPlAL+veQw/LXrp4Ux7BRQaF8h66XOV3mQdTPdPXZfhnDaZ07MUf84s6G14tvOnTMXVFnOSG9VWCNTMytVJKV+WXkjRE/EC5gOjmpKbR9uNLtYf6Fx5ATCUI/bjn0AV1jfebG3RO2Cm3HHFODhUytI4cjCbhqs1mhKObDGPZNbOTpDmZaHq2yfesXCuHnJoUwSnxcuEOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(478600001)(8936002)(8676002)(6916009)(52116002)(6506007)(6486002)(316002)(66946007)(66476007)(66556008)(6512007)(4744005)(2906002)(1076003)(36756003)(4326008)(86362001)(16526019)(5660300002)(83380400001)(186003)(2616005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: FpO4dOck13pFGYLuu71/lsCdcSHeDKikQ4oYhYBGhajxPhzLX0L/Go9BS0AZ+/3r1UC7jiZ6aZVYOzTkMEBROxNQGooJ+N1CV4qKzsXAUfTAuVs1gdtu03FT1xWIVq/l/v74uuCRbNEsObvOrHtH2CH5EvUZhxX7Rs0kM1yuHDFcy4cFmZQDxi6tpSWVNlSB6cftTbYtPCGiap/SfesslzYVKVr8/UTPnfUI3ysTQl3BHw+HwWcv4CKcCFLTJN2UmjwEMuWkE5YlOWuT/g66UaaX0Zd33J95geNEsUtG7aAb2iua6m/WQOgvebGHp3J5uh/EWi4ADCXZKNwavp+iayBU0h/XnfBZGbWtxfjkhOnWYPe4XEaAQY5bN8NEBkY+ctFK+v6NEICOKSr2MsPhZ2992RlsFuI45aag6kbAFBE+5RszLPkI/e4kqsJWzGT6ytvYHP1AGZfOCe10bk0eO/lyv3JgwKRDz7qaNb1IfvXaH1oqgTymgC5RrOrSb25FpZfYS2OVZu0gVWA891dKOg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5f0da5-5f46-415f-2c6d-08d81fb7bc71
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2020 01:15:27.7210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fS3K32CTx9zGB3OLvrdNqP0N1a//wDQpklM/tGfiXFQKHYsu7Enhk9A9OTg1qvbSSPpEAnFiMpq49kuy+AET7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3768
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
Cc: eryk.brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, aurabindo.pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 90cc3abe26f2..389edcf3f6ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.92"
+#define DC_VER "3.2.93"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
