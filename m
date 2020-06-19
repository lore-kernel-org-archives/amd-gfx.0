Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CA9C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C15208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MgScwHSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C15208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AE8689BFD;
	Fri, 19 Jun 2020 20:13:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E776EA50
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEnUszs1MBx0XuLmoS07e2LqWla+wqAVjAgsYiffG4JpJXM7onaTbGMlv8X9I3TzT8F0HVzXD3NWcbBmxNjY96xJ67HJ8exFH6Crt2HEwRBwjG9g9Z1eoIPBLfHkMsMTnv2pskEKqF8IIlDT/idftukzMI4YRtXQ8DMzY+m82JUqzsPLDqfZMm9O2HOpjGfICMsFYNewbkfEJluIUvF9EeZ1NM6UoBiUXsp7HZb5k72GqozX1buDr3hwKscSncQI15Jd1IcSNBoo9zs+0El2eHbGdIgUQsBFFQGiy9Q/3VskpAOnwp6p7+2InaL+6UrB9vEoVqAbM21T6ckthTwLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbTFTWu8eE4mNgL2RpLgj6wkeTNqJ3CeW6WQUk1zmoU=;
 b=jT2XC7VyB4ea0bJIUtzdjU71mAkr7BziEx5jDpa5EFKmfi6tSYAuDSHkNxE+cO00xAj62bPSUnBndXbfOIEuJ0D85E/sK6jpiXwOeCvDg97vwsfS82McxS7Rly92fxR915yssJldy5EDtvdcbaZ+E5C8I4dOLWFY8JOnzODjxtgg+IR1Nq5lfhyOdZBxWAJvSEsplqIWAMnaqf205f1h+R3GVaSHA9Ab93Nwh5TOTNqArEmHPlIHoOUkc16GgNDYU4BbXs16RK2/7NWYUFtPsEcDEIIGp8Qoq486FVQXq5ZMFRCKSS+Nc57TeXeuAQ6iaKb6GoAQcv7Pmee0vdGDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbTFTWu8eE4mNgL2RpLgj6wkeTNqJ3CeW6WQUk1zmoU=;
 b=MgScwHSFEBJysh5gIkK5qzb/KyMSbrrepDSgGPsSG2TBFhhNGtb8FGhhsKcDG1tJKXUNYCqKx+mRSriMlx4smb4ymcjIBzjqgJnweXVWbK7Dhl5lCo3Ukhzfm3hSuVk04Vw57O0M43f8FCpGE3M4b1z6xT1Zmq914NmBPUhVvX4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:55 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:55 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/30] drm/amd/display: 3.2.90
Date: Fri, 19 Jun 2020 16:12:03 -0400
Message-Id: <20200619201222.2916504-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:54 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dedc8aa9-2970-4abc-961f-08d8148d2710
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4087C8B6167166433C66B82A98980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q40QPoKWg4Bg/jU0iQiGBnzzhjqVgNJkPUzy/GOpw05w4/5fsjd5m1N63sIeaSFC8gh7J63xaHfEfUjg7mQH6LHW+6+FScxyoznaq6zoTGZsFbbezWUdAkxkn4wwCFutWJTiVu6b5fDdsW7Az7O26DsoEkwjgAj4We1ESa4S3R60vY1qzEDErk91G+Ei3H4GF0WsrGOf9Y0gl4YwBbAtOa4ZJEmX5qvkr48Zkq8eL/LWnirDcXOH2gQ8t/aqFLuPOc1ZD4QhVf2oMmOYJfQWLGBcVLNn56MFpQHjWgcs16e0EKprhZwBG1JU69Ib2hVSRv+rQMDZej++VJs6jPQP8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(4744005)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Z4VvT3suGBSCw1u4Xm9/Wbu3FzrR5b0zJYoHBDdg4OwFpzfxb61NS0dMDGxqqZ0vJqP7d++btLDy7k/5G7vnswATQ/VG5M9YWS1mGB6vdkR4vZW8nzFlZqGBbhbRkb/8t4beryhG5Ec0ol4JFsZx1tyjRNmuAjomsWPQp3c3agtUXC5/C+356PGTzzCRlDVWyx/v1aiCLBU8Mj1Ap3Ruu9Bv02ftiF44Q3uBanXO7hvaSdjwC+YsY9HBtMgYBf3/89l69ZJYwjFn8A5nsUgsggxwjTUkD0/jCEC0WknDL2uVCTkrVWGsdeBwdh2gaBFcargO3MjfsRxgWHSZcVlazNmV+bq8YT8iUQg0qUUvU6IBf3fq0Y+dXb2nFeJzkb+WmmiFvTcvpK5QEMRdYFT5+Fc6jmKQuCLCIu/GOTU5gviXiwOpgGHrHD9tZTPQbBTvDmaqDvTMpDCgaoYaOTlSbaIWuN1+VaJiPWt21nynQFM/YmQsm77KR95lTrGptu7aX8U6/l4RFxCM5TsErd4oYg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedc8aa9-2970-4abc-961f-08d8148d2710
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:55.3428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIYPZSuL628U2tmtWEiMzsIYWGzBk/Xl3RLaH6bFkv8Wy8FG+TgLaDET3tpmtWXH9TF5qQg83IN/Kmp6ffBtxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
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
index a45b5ea98918..f9eb8c37d7c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.89"
+#define DC_VER "3.2.90"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
