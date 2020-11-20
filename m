Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F3CC56202
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD1422D0A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0EZcqp+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD1422D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 484146E930;
	Fri, 20 Nov 2020 20:20:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05A206E921
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldLMCwGz6zG0+fxRGBFFOm+Nu7pkgQ6uyVpzqv34OAPlA4cYgBxrVP/3lCJShKJp5Bx7IQ3jcHW2JNuR+UvvAISDngjmZLKkcJ8Xu5ynpWh94Fwxug1VbRzyGFujUJBhSD4TVG5bBz2tNgZSoLJCa522FI4Hwv7xE3cFaet5tRyyD/UOD6tg7ljfd2H9ZG94T3VMMy/W7IjLZ86T+xECAIVwLqxQWot+0ibrr0+TzSqiMmCg0vAJwj1MVjkF8aENCpjVcktivQTYcnhI82UbGCz4EDZ/7WUxPJWufnGSj1YZZU8W+odACqqFPd8qBSQyCjFYEYUGuxk9VPXBWjAIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEWPW3njpvc06ONs6MlJvCI4/h8ZUvxcFQ6BDkKCpNo=;
 b=YlCHY2XuGxHoVUf/CDC2f4N+qJ91yTEpV7VuFmMsLYbD/e/J4QI5krI3P0cECwwSxJpxsuBq1pMZNccMCjqu3j1ansZJVDyVH1FKkIIK5Hf8OqM9bhGFhuzzz+1kz1dWj0hXjt8T05uhslf+qjKRlTdZ5aN6O4r1CjMeHNGOn4bOYnZtilWUh1rSK0+loSzLhE2WfxW4Qw8xiS8J6nxjj6vefcvz2tmtpyQ1/KJi/WI/p04LQaY/AVA5cANwSdQlsnzb+fQs9wwKw/+5WFiuIJIE3r02G2WQYXWmsV9GXZouEZF1xBiOeA+5eES2u4UXOZxwKuEgYPO3+awyw+UKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEWPW3njpvc06ONs6MlJvCI4/h8ZUvxcFQ6BDkKCpNo=;
 b=0EZcqp+Xwu9VD7xQE0u7u9dWQ/V49kqAjn8SSltedXwp3sUj6o/U0aMRMfMtv0TpWdGwdD1ocKqJJ1AlSdBqO3A45RWshBDBMxMmDcAkn0Vi49N/nsvhO714tEiFQzi7nRBlI8trOegwbLY5xqAqDeXPL3QKlDLCgUHb6RPWG6E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Fri, 20 Nov
 2020 20:20:33 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:33 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/18] drm/amd/display: enable pipe power gating by default
Date: Fri, 20 Nov 2020 15:19:55 -0500
Message-Id: <20201120201958.2455002-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
References: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 377e9492-aa98-4668-01d0-08d88d91bb8f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42615A87E4FD350375D7D86598FF0@CH2PR12MB4261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZwAsUIGleCOVk8AvvN8eDJWAVXPMRePTE+xBCZLqLKFjKzZ8W12SrtGzJ9fnQTExi5llsMREiGh0LbiYflgOhysSD1oybSVUyqf6WF4o/Sw0u7Sf+8tONzQ22PJ+cfB+aEDSAt1syORy0f5yTFxNehF5eaPnpKtWjZRRUwd/JAOe/PQRNxdIjaKt7t3Y7bEROPagdYsnWr3ioXpuJpNHs2m8vc7xH6Fqq0RrAX2bqOhf23uG+UHENIB3C7y/Y/JiWV9Rvhk2ccHe0pSlbhcZGwi0J3sql3IxFmHFngyTffJO51a+1hlPMsay7F5Bd+vdfx3+It0FVEwYs0TX8gasQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(5660300002)(83380400001)(1076003)(6512007)(66476007)(66556008)(186003)(6486002)(66946007)(4326008)(2906002)(16526019)(86362001)(6916009)(316002)(8936002)(36756003)(6506007)(8676002)(54906003)(52116002)(6666004)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mNp13zxzJDxC5MeViHPDnkedu+9EiEG3SXdiDcmTwO0dMdBMmawv6Pgld/V0LTMM+Ax0gYhvebxT1bJ3RGyUqn0gwiMrFDHc/p8a3XkIwYgfSXnlNf8TcJZvG7yIYdGUQ0A55/Y08ECq2yKZ0APhnrX31pJRWpklMN5D8VThfgpUm9Eo7+hsuUlyKdMIuJEvHyesVaJPQ9oRlHXjnzj5HiNF0Su+j523I/AjT6Ez4eZuEqC4bY0TfHiE/DTdQEO5LDiCCpC+ehcb5wUTQ9XbQ7oYVYBlu1fefpBNLDZIXD0uGtsPo8mMaNSLPoXZErj9quVL8d6gtAR00A1ktPWceOQVuZ/WxmosWeTaS98cetA7o+qWnyk/ulHnNxXTQACyBeEcWHp6X3WZSw97EzCNao/Cuxa2yO1dxbbnBysU4bkSlmI0raitRNefodA4HswbzLtbMlgaBPrc/y3GCm5G9/U4H2FntaVdj0oL7b1cqO67IzQL95AzZIzaqGVdjOXmFXkiAgXih0bTPXLuX476x7GCiRBeizNO+Xj3xNd6891dZgtWIshOPVJPatasX8ej3/f/FZtQzrDrqVLr3q+PqfA6xON+0QuLH3SvMS5FxVv9YDhqnoh7y6PRO6hMsZ9rjNAM+c1DSGVZXWqNwTGn2qyU3MONFJ3z/rWdzLs2/HkN2GZJ5q1jpiyUo1dmwgxAp+So/rx6mTQXRiPk2OiLtCm62SD4i1bl+j7lGwAvMaTtaacSrEt1ur66BMr7FA9HqqjXL0lmOrm3NMBvK16tRzzQCFB+eAZZoH8/3g+pNWMkCQ3ioDFrc2fdsVdnnDAKzfX+6R2Br7wvS2iu1C1vfUqa4Ce+380tICMa2epImdxQAMPzb44RwFRu+oDIlUfpZpVAGwXwIO6TdbV4C58/DasK79wwv+3+nY2NVewExQGqHnrLLo7O5IkrD1FXYGGZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377e9492-aa98-4668-01d0-08d88d91bb8f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:33.1179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FRb3nXBJp3Kxcl2iBSMzD/43ukaalPplBrSLZsWz5oZyfYwMRuiAfSodOYghGcwfBYAWvgaRFxJXrOccqxpKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com, Sung Joon Kim <sungjoon.kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why]
ASIC requirement.

[how]
Make disable_*_power_gate to false.

Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 5f97808bb423..4b029631a22c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -850,8 +850,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.force_abm_enable = false,
 	.timing_trace = false,
 	.clock_trace = true,
-	.disable_dpp_power_gate = true,
-	.disable_hubp_power_gate = true,
+	.disable_dpp_power_gate = false,
+	.disable_hubp_power_gate = false,
 	.disable_clock_gate = true,
 	.disable_pplib_clock_request = true,
 	.disable_pplib_wm_range = true,
@@ -873,8 +873,8 @@ static const struct dc_debug_options debug_defaults_diags = {
 	.force_abm_enable = false,
 	.timing_trace = true,
 	.clock_trace = true,
-	.disable_dpp_power_gate = true,
-	.disable_hubp_power_gate = true,
+	.disable_dpp_power_gate = false,
+	.disable_hubp_power_gate = false,
 	.disable_clock_gate = true,
 	.disable_pplib_clock_request = true,
 	.disable_pplib_wm_range = true,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
