Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6EAC2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4EEC21841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DL06hXkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EEC21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 906D06E222;
	Thu, 16 Apr 2020 23:41:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92ECF6E222
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq11gpg7pp6uAP3X6KmuYn714EGf6/dn/4RtsQbbHKnnYrthMyVX0oj/1mzFZTgATy4OHGS7O71kFeCMvtCM/5Ml5Chfp0/x2A30ViEutJkIp4tgKNRzoDluApcUudtwCG5TNnPCYQ4ychnOz97DUeUiYo/+vvMpxFV3tUm1DKkXZke2WUYg/6RoTuYmV6DaBxTIcPq7a/tdXCDS2t6ZVNElHoE8bI4alSeREnccbXSe2V9ky4ce2twF98rkjzGzpBrLJE+8UBtWmNJA/uE0d0T5mft/pT9g4hMjAtMnsff0NFwoXxEd2pDJJI2ejPjibT60kdSuTxGe4slrtwtn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnBqTft+SNM6jJX3xf8iFeXTv88t2lsHsIpnOVCIzJA=;
 b=gYFyDtO032JS2QaVpJnDoIYdQ65BrTqnRy+VpKvzkSdzYIFW04bKhgIStGlvJ2Pr8pt5nbyrqUq4CK3g+JN9OqWmRqrpUqK3OyUAFOuLRrfkmqaMzfybVWfnC13QFUfg5+ryt530InOwF7JOcAvlLwJq6sAeHBALg1N/F4v6+CMfXJjg4xTrSRisRGcTJ6KPTqDtp9ll1aT9hAqynd1kxSJtWoDaKwzmOErqYFeUkHDD/FTy4EsVT2dLp++D9XMCG5hWGaC75ik7ZVq4dP9RKa9eOar1neSj8l/+JVEAYzjyf4drQZBKsX0HsJ35+37NwHlun4x7wNr+6Q0+cGeV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnBqTft+SNM6jJX3xf8iFeXTv88t2lsHsIpnOVCIzJA=;
 b=DL06hXkUftYEpolkHjE8P49vBQ1zpPkYXtRRHdhmeaiCTIoWeWlAl4Lcfi5bySimWXfkXrUPTu7hIVTJzx5LTGEhaXr6dsTCQEc2s1+T6u+chngWKzqtJtBSeP1e7sdKp+mpL3PW0CncOFty283d+qFVEyIvEooPImY9TWSCIXM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:37 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:37 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/35] drm/amd/display: 3.2.81
Date: Thu, 16 Apr 2020 19:40:29 -0400
Message-Id: <20200416234044.2082886-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:36 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 032125f4-a25f-4f6c-c711-08d7e25fb454
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24596A2451F488234744FBA698D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(4744005)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clHFtyhAmbMoK/T6ULpeU4hpZmOvnJJMmEiKmIzNufXM4wyHn8PXA9jFTz5Xwr3Fiq+sz0hVa96avtFfmtHikHzTxa8wX3eGzs6Lhb40WirkG0LXVxbuimR6ZOeUiLdJvYFdgn/Tl+XlsDMaQlELd4Iu3cEg1mtMWefzWpzIvsTUlRKdoX/XzhqAVTMpcaucTu3yB2ocAfzHLvvGUYmeJV/0k0J4dEyTwDO7LeGaJzTX95FOS/uKlZ+HZBFoRqKiAINSNaY2NCd2JQkdpgFJoqap/rMARv5jDFnOSMMEfI6NRXUHEQcep1YXaGp50iEk6GIoVyS3i4Leshwx5lindoTAe99lg0woSxys9y5hdTof8jRt5bn3sbXz5r7plhf/WL9T19c9ANZ2FZELusCdO7e6R1jZs14eRuAjp7doCVaGXQ/OdAPFawWuGg9CoY3N
X-MS-Exchange-AntiSpam-MessageData: 4I5im0OIfrq21uJv/XKHFPrsAnlASF4yQBaGHUAX+eomLTytyvpda2ayuqJW2vrfvIhwYcH2OKG04f0l1LZB0T1I7z3sy59VKTmPk3stU7Qw53ZTX0bf3zXVMpI6vRU9CQ8SlNNlrlAJEMpP9Jk2gN82WJ7v5gvxtma/3CQ6FnI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032125f4-a25f-4f6c-c711-08d7e25fb454
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:37.4478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKPGCMyQftTakGZ4jgT6kjNaWKZcrfc3ZAjQfcFpumTj9gEcxnoI/PSJyBmarquDCNYxYjyww2eNt/FV/jy47Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
 Rodrigo.Siqueira@amd.com, Harry.Wentland@amd.com
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
index 89cce79c950d..f9a2069ea30f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.80"
+#define DC_VER "3.2.81"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
