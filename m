Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089FFC2BA2B
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70D720644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B12nd5H6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70D720644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B6A06E200;
	Sun,  5 Apr 2020 20:42:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19EAB6E2B0
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJHUvzmssEJUg8th3txwyiDNfRpUgxNPD1lMI41PddfyCq0rAe5wsfSG+2IahnKfyqeElLCtGUlTA/4CFDi3MEFH/5hEN90ewMGwJHUm4SQHX/Uylv3MTaD9som3b+xNqxpD0PL8e8yYQESipzO49m09VrNc5L1ZFCnlrq8uRwNggy/NdsXKuxAcRUbB2wRSddGYuLuI98/sy0YxdYkPARktcQHkNKR4Y1MR5YJOR+sObjxHRFEyeN8cmwChJBmMkZKUqWM8oCvDwm/Eg3dzk2AHCeL6X7bYto7I+Q7Arb7qGoDU+4ThVpu4VOStt7+3thQLmFjETQ7w6D3vzYYIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnFQdEfD8Ic5g/ioDdaA14HxtrXU/DenRC9EB/yMkuE=;
 b=L8LG0LV6JlorI5gRkF9YfvW7TmbbhQG6Xk8SId8pmoAQUYrW4vd313TwQf7XM3sfOLBPgoaLNN7eTHCdLPoS/i0zMc2kdvPaqsXLJCwByCVTd2sbmSFeiD7axjl6ezvj/gnRmsp6m8oH/DhJMAKYyRu7aOkt4MLjlKQ573Nr1X+tcdPMMzGfTSXb/JZw9i8QbkbKchYLP76tA6IjdPqPZgwUqsFnBe73M6PXQVlnOH6rcqfMbHVN1vcuRw2O3vdCLVYMDiiQf40cANdsijJBhCDcZyQMsf0oiuuD4/3C4zO7adXx5Lyyb9BTrXpqphazpnzQcM4OFfqGDRU1ZFMTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnFQdEfD8Ic5g/ioDdaA14HxtrXU/DenRC9EB/yMkuE=;
 b=B12nd5H63MDE/RrBMynZnNG+ielK1s8VeR41VEkhasX7sGmCorzWhr+QMTd9RrCZV/TA3sI+59rM9hjjucLYGUyaJSwebFkXdrmGcfhhEavQ2IscwTmn9jGlmASXrhnSUYKB4lWPoCcBTQPrx53K29nkmsELNTdeqQ1wqqSJCuA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:59 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:59 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/36] drm/amd/display: 3.2.79
Date: Sun,  5 Apr 2020 16:41:00 -0400
Message-Id: <20200405204115.683559-22-Rodrigo.Siqueira@amd.com>
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
 Transport; Sun, 5 Apr 2020 20:41:58 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e09fd84-5e6b-43ba-ce04-08d7d9a1c9bd
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555CF1B2BA1DB36D4E6F19698C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(4744005)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(6666004)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q8tWKybBwo00tuqOWWK2yG21UPw+O8g0e1Z0qwFa4khG/ro0sq5dx+Nks3hAaFBaGghRNOt/jZDMD4NuQUCft0NDU+Gbkvh4TQYzZigwZBFIp8fpmQqeLcbNLoypKrzTB5j3IXN9UD3jZ3YQg0NgRtLF+6u2HuxVhCZVQXEpvqUvGkS4toGVs4fbqXwqQt9hvcuBmF0b/pAkORHYFaOPSOUqr5bnP2hG0zaq0MUW0cYq7S1elvN+qbpUwmWXEets3IWZsbOrTxaBEbfiF/R8a8qtWQFbFLHblkZ/d59Hqxn47yB3gkRoyx1sdt5vmDfnMAqR/PdwguERzhRVoqE40uEwOKmjk0+arGKnkAEs/BUV5Qz4tQwCExgTLJhcKWkEW4Km5QpLGaK0ZoOYJH0My8uBCCBySH5cu7/SFEN8O79ju0CucGQDybgbxQ0Gpd7I
X-MS-Exchange-AntiSpam-MessageData: nYb5y6Kx7ZvNFSN4XOIJ0Aqehd0bhCkdPfr3GkvLH9nCBli3wl4KnQQ8/id2X2+6eO+eJuEjqjIUwTkiWUioBueVbq/tKBuTrUbc1VVL9wnPA+4mUI1Xcf4Y+LFYqQinuu58KkOU2e/TfQBMlus6tqEQQyYVx1Z6glFTGwoWSxg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e09fd84-5e6b-43ba-ce04-08d7d9a1c9bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:59.6374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clZBq7K8nSSRGHOPo+pmcuJIaZHInXEIc26s6ua1/4/Mc57ChWwwHwl9LJdGtC/k3c4klq+vlILFXjsL1ofh8g==
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fa0724435a3e..e20b09ca8894 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.78"
+#define DC_VER "3.2.79"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
