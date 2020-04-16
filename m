Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7D3C38A2B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4AE21841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JhctUGTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4AE21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A0766E1AA;
	Thu, 16 Apr 2020 23:41:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67098891DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG8LUfPjtcXts/t9lSXHPR9FbIC9dh8HHCz7qfdzUqhn3p/b/pqLLS6qxLAPjQxEHtDTmDPMITpNZvuE0GU83nY0BK1ebvaVRm2YXlaw362brVLvxCVlFQaZWibaIevyLm9bjZugh+Q8+deSwW89pAiDy2DyCOlKLuGYdOHdsF52AKqiI5Y51O1VwkiLN4o2mumAOGRfNUapHJ6xpmY7B6Clvbgn1YIlrHKI2NXZtWcjAUI199HoOi6HcFKG9hcUeP0dmT+xBEyHFfBot3zjBLcpZaXWMsPKJMiRTL7v5mFmpGNA578I+ZmzgovoJUu8Ly+JVaZ3lfGwiAs5mbTRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4Ck8jKKGPQwDWOuU1MMXFQpBiMuz6/rV5KfECUVUXM=;
 b=YlPv3byLNc29dgp7EVAjfOBUX4B9VUNhj3WhFhE1JsaVicZNK2woukgOSQ8aX3J3flquMOL7S1nGGyp/HxNlze3rHWuEviR5JIcqtYFzlGgEk+GrnKJ7i28W91OKnHQhOwetUXMmYwHO811AR+v6j1Zm8czqwHHpHuNy/1wgPDaR0sp97yN7Wbow5rh78Ee+LbowpRwgnYdF0KfJM5mLsRZ1jPO6+sxPuZXK5OJ9S5HX++yUKEH8rayGFn4kAbeMs2azQFJcXGfXON69Nn416gT4E8BbCygZACVide6PRgBzFAQuuicj41aZjG0BC8WPoWF1Fc+dnp0XKl/nJ7TySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4Ck8jKKGPQwDWOuU1MMXFQpBiMuz6/rV5KfECUVUXM=;
 b=JhctUGTCFsb7bpUHfWSSUru5I/NXszV5IMOTWoylDLYopafY38LnTtRov85/fMtV11Q6SXzFONqB54zEVgrbsTEA4tm3T3QTQxnobpnC60r43+sPPa1X5ZzMezJWGuHRqrA8lusHGALQcBD18FuJAZR8UIfTQ7tG0Ie2/nkqKO8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:21 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:21 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/35] drm/amd/display: Check ramp != NULL before applying
 lut1d for degamma
Date: Thu, 16 Apr 2020 19:40:18 -0400
Message-Id: <20200416234044.2082886-10-Rodrigo.Siqueira@amd.com>
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
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:19 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c87da68-d3c8-4426-ae20-08d7e25faaa9
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2459531CBCF46B865204ADA298D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002)(32563001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLMTA4+IG7pr11po6TGzf7t6yHzk152qQZ3wBGCeId+XoqbvnKshK6npObcQ2sjj2YaQRwlNlGGvmqFjT22SY40robqkRSagRK1+WvpvDTSeYSqnSIlzifkV+f6NpzVRVa5hZZvNlj82mrVU2b8pWf/2XdDGxzl1lNYBCzk5Y+3l+HPW2bIdKmE10lkMJHUfevCe32jyGMEs6e4Vz2rZQDtz9eqWmDTr96En1Vdx2qoew43z+4ZxNwq1pV/MrweEcYQPzjdfTzhiUWaNuNYXZ1pC4XxCskv/0dWWquPL4rtAcwqpOE8c1mWqteFpBY4g4/SsTBazgVXVvL1uQSDpmKO93yVw1NIZyfWiG/fHWJQVQT8iCF6OgbY/XeZY73dtbleuoX/f0L40z/2rgNSsEqU1IclgXze8amQBUiWGQKgPy1KEt3ozq0eGvLT3S4SevwM0W+N9/QKN3WVt57F2DBLd8uZzKYORf6KmRzQ6aY1TDYxCNp7azie6d090BvoW
X-MS-Exchange-AntiSpam-MessageData: iLl0wkA3Yrm4ZTfuMBAx/WJcW3l3FDUWsz8UUsJEG7xrZTij5vpV4cWEJbwXuUgDknK9n7J4VfqUXUnzUZQMchgYLydiTxN2MAdxPR0C3KxacrILZhht7XUCpf5Ir0N9y4TMTV6V7sh+xM/xDl5zo8ADCZCqCR4YmT3OO3ctRY4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c87da68-d3c8-4426-ae20-08d7e25faaa9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:21.2270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qztEk0hfGvhEpUPQwkRx4QSKXXg+B+4Bpkf6S6hsz+5N9fMW+HhwcnHTzsTQC2RxHsgQEjKcC3nPKOOXrlWo1A==
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
Cc: Zhan Liu <Zhan.Liu@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
A NULL ramp is a valid configuration for passing into
mod_color_calculate_degamma_params but we'll hit a NULL pointer if we do
so.

We need this in order to get the right transfer function to do degamma
on NV12 formats where we aren't supplied with a custom user degamma.

[How]
Add the NULL check.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index cac09d500fda..d47253cdcc4e 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1902,7 +1902,7 @@ bool mod_color_calculate_degamma_params(struct dc_transfer_func *input_tf,
 
 
 
-	if (ramp->type == GAMMA_CUSTOM)
+	if (ramp && ramp->type == GAMMA_CUSTOM)
 		apply_lut_1d(ramp, MAX_HW_POINTS, tf_pts);
 
 	ret = true;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
