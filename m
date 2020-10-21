Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67A2C55179
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7088F22283
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nATajXvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7088F22283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D49BF6EDCE;
	Wed, 21 Oct 2020 14:23:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC6FA6EDC5
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/xsW15P1Nlvl/EKHcWIrKHbk1bR0H6ifkrLQAMMd5S44SO/McdFGdixOWoJIbojMkQ2kNQ1o4SOvJDJW/C6myCYDX5rmlStycG6KKYQddKoZllUo9u28HTE6bvaaZS7LgQZ8/F1dE39yR0cSk6o0AeVE2tYXplCnBErgK29uBjyMDYFewNVYhIvXAI/rGPtZZrrloj6j/JuKg81Vpvw7ATAyU2t/H7octXRprWic6gjKsLWXXVsv+LOPpCaz36gN6vhARfMEt2BU4qdgUmt12oNZ+ryRWiIzRzn7aDiWxu/Jf3641PSZNJxsBrUFi6I6X6t4gZKNurHKsOJBa/6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6OLOzuDVzWSgtVZO50NWAzF7j2w5I6KXSZCMSzh/z0=;
 b=aVvF/TwnRdMKKWW3TjMOetdYhPw1qP2qSMzrU2CqPrNv9poHJ2maeB3JQdTkIP+yUztYEBwdsGl28Qd48FSUJMMPRaaJ0LZyN+xT6BwGV+RQQTEcI/UMilGLVxXTg5t+KDucnmKbI2LU5DEeZ4U2fnGQItsoaBWY3v+sfelQ6BeWR8Q+pt+Y3vUmaObmujDPX16r+mqdUOCupH3ptZ3sZQ3GLnFGS2stPW1mScKTMGA+Y5IKMmJ7rXQeaEe9umhKV1jR0X9XzD+/OAoSJH68Z6H83rbopF1rgIi+mpLm2gJ5ZQTqCLxqXn/ANJc611+g4E9+gLpyklmvX+u648uqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6OLOzuDVzWSgtVZO50NWAzF7j2w5I6KXSZCMSzh/z0=;
 b=nATajXvUp6bY4pu61CEomvx0mDjwEsxw29DKTUWYsf/yxhh9qjjXFNqWeqbEH9qo8y6se3tl85Of+pzVpEayGNw41Sj5QuTGyCKPIWtf/KyEmDaPbfduWuqm0kaNYm0J3Ds6vhqcHDmIlZOK8mVLAfke9YRiKC7lWjxMRP0vEfk=
Received: from DM5PR11CA0017.namprd11.prod.outlook.com (2603:10b6:3:115::27)
 by CH2PR12MB4857.namprd12.prod.outlook.com (2603:10b6:610:64::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 21 Oct
 2020 14:23:18 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::ae) by DM5PR11CA0017.outlook.office365.com
 (2603:10b6:3:115::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:18 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:17 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:17 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/33] drm/amd/display: Reduce height of visual confirm on
 right side.
Date: Wed, 21 Oct 2020 10:22:41 -0400
Message-ID: <20201021142257.190969-18-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 544486ef-4ada-4ea9-1621-08d875ccdb4f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4857:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4857B1B2E426989F0703E7588B1C0@CH2PR12MB4857.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6uR98abvoSgD146ozamHk9LWB7pnWt70UmHmEPECWPzW1+/3kEoMrHIsFHu9YEWjCgMQkniYTomyihQSM5snjjKxdEHdi8K7rm2wFVVQ9cAkauMc9PLZ2cmnlLJscCvFCtuWIOsQtP5NxR2yyOFf7iDEq8WXEUFie/0Iq2wn1Q/PCllXCqj73uF2RqlHWl1BJkguTyA+Jux/Ig9jbUtTBiNX8hwceU3vavfRykilRdsMiaPBrI6b6aK8/wj1d34k1MbjOkqScvAtckwt7OYH/HDDRtCopJM5Fww+KaQvwFJkHBXawMsG7JtsqdOrRoFhHQL5Mhadf4QspHJGvwAhR8kUC3a4CZ7Bgx3wmbygOseQUGGtjcUgrJmoDU/TLILPYlaDO6QLmDqPi972O2dyzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966005)(82740400003)(336012)(1076003)(47076004)(44832011)(2906002)(356005)(478600001)(81166007)(316002)(4326008)(36756003)(26005)(8936002)(7696005)(70206006)(54906003)(426003)(186003)(8676002)(82310400003)(6666004)(5660300002)(70586007)(86362001)(83380400001)(6916009)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:18.5167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 544486ef-4ada-4ea9-1621-08d875ccdb4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4857
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
right side visual confirm is too thick due to it is 4 times of
left side (16 lines).

[How]
Change factor from 4 to 2.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index fce37c527a0b..878b53d85694 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -656,7 +656,7 @@ static void dpp1_dscl_set_recout(
 			 RECOUT_WIDTH, recout->width,
 		/* Number of RECOUT vertical lines */
 			 RECOUT_HEIGHT, recout->height
-			 - visual_confirm_on * 4 * (dpp->base.inst + 1));
+			 - visual_confirm_on * 2 * (dpp->base.inst + 1));
 }
 
 /* Main function to program scaler and line buffer in manual scaling mode */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
