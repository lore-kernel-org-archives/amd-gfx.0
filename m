Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF69C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB39B24073
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BsEQZ4g/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB39B24073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B8B6E924;
	Fri, 20 Nov 2020 20:20:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8506E918
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBKr3Gw/s9Lt2pYbWJw6YLwBDIPpsRaVGt7Z7p0jQW7sOhI04r+t1H0sPdySypnYoQ8jiyDgcRFwzlf6iJ8/CP6fJrm3O8zZiETfIJ0nlHBsCwCyfF4gB+ts2rRjN9SSz7Gc9tcwTws6flUhxyyOnOO+L5nbCgNPAiDYEZGXCw4wkWGou7+ZGFiuieCB9w0AbaTp1MgXrnHPKIDehYVWRD3wKe23NKYcFsg8J5rx9wK4YRiatZ6qOkJpTqZ+2n877B8Q7spdYMciZM0CDBfjPRCRK9eBOUjqSBer3oTcULZXyG24BcxJ1FnVq/5nlsGlyCfiLY6yTmfljcXeluLv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cJaENuoTz6BhcNxfDIO4fI5QeUlZpb/yFenCGyGaAo=;
 b=Ic9VH/4eSi1oW+aneQ2cv9OZH6BMvsK7P6RJ6ETrlRXyMureTTRBF9MpMSKxcxwqiizXrP1//QkqZTdXksW9RfGaDHkoMC8aBXD1M+IMIwWSRLF/K+eHM8V5UWSBrnjjeKrM5PfdIPBendDMVt+O8ikml++JSc040fRR78woaSpHPaEH5xDKH5FPA4ds+RNR1won06+Ie8yGGfwJT1l7s9S3oXd1q/flZc71oRRKbMq1vuqyZJNhHyYNo5SiFmRs5WhgavpZUhqeKq0bCTI+pqGWKYOHhp1I0T0mmraFVlbPocLlcpk6zb0p9VMb8G8G5deJsRJ5whembjyabQ8N8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cJaENuoTz6BhcNxfDIO4fI5QeUlZpb/yFenCGyGaAo=;
 b=BsEQZ4g/Ob/lJoL2Sq2ndZD/zDuYTO4VQkDDKtYK7+RHeBjU8gY2Ae7DqcPbnX2f6/grSeLgCkazyEbCPI9+VXCyKtm//NEjxLJiaA4ktc+6cQrukuXhEyyniR9jLLa1mzIhMGzC2rMyoCUie12G9v1q3Zp398VXvF9JuFxbix0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Fri, 20 Nov
 2020 20:20:32 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:32 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/18] drm/amd/display: Add GAMCOR memory shutdown support
Date: Fri, 20 Nov 2020 15:19:54 -0500
Message-Id: <20201120201958.2455002-15-Rodrigo.Siqueira@amd.com>
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
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 80673d66-5d63-453d-18ad-08d88d91bb1d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4261A156050FE05CF7A6D45598FF0@CH2PR12MB4261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfyFJHBp2/hLD/uVi6bVa9zrLz2dwrIcN2ed5j/H0aHCqa30wri8tdCCUqJf394yV5OKGFsw31NobFAUJegrOXth0Q55lWpNnjhq1BQLGokQ6/MBDyRHOmoz31GOnNCi2PBRg/EU2X2g6AOdhL1d1n3lTzrvNFQw1T2EUUZEd+z5nLviNCNDlI+sKX9GonfJG7/fVDLxfyd3imGpihLP0Mi55DzbYSWQXPfv8JsyQMzf1BxIi1kf8670d3+d6rffpFskwHj6/4w29XuUo/nooJFu75O0a7nKcSTJXQPKXK4LXJZzDpsv802OJEJjw9aojJZX6umV16IoNszjoCeauA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(5660300002)(83380400001)(1076003)(6512007)(66476007)(66556008)(186003)(6486002)(66946007)(4326008)(2906002)(16526019)(86362001)(6916009)(316002)(8936002)(36756003)(6506007)(8676002)(54906003)(52116002)(6666004)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: aoYOVOloDambXSakEP/YBd4gbHunpQI5/QggFlUb8hb38kvm8zB71NwtP4nb/1aoU5mjzPUX+1/YjXfd9Xgz3JqkqrIh0qa+MtKOC8EdOF8Kknf+kp6uHv43W/MdXyDOY3U1/8GUNJzDN8lK9B8j76JGegkp/NzPRpjNaPDyiky23fpJKxUN/zI1Dmslc6q/T7/JX3EZxaSAnZn/E7Hi4qV8ja74uDBNrD+Xj8DO1f+TlWHnJXvpnr3UdfmNOm6BckhutTjlN9ohgKzOUuOKJ95FOk5l6mVpFGUHBWCyQqEN6aXae3FhcTgLLF93mfJKmaDI2z0juYb8oGXNGglsl/CGIaX/ngqL2m4i0baPPhxN40UShV1WyeMM6NFErBuw61/fK8JGiYKf55+LZesmqgHvTMZeqvFElq0P1FzUC3PSMq9L6wmc9ShGoHpuh6cMXXkLay6cF3oqDhzryRumJQxQYl6i8zJtFPhU6E1jqx+DJI90kw/w0y8lQHWmixG6P/F1mTrDwPRTtdmsnQeEjNG9p2IVSDmTrdRdNyArvoRzO2V5kyAoJrVr6QgJ1TYvAOG/sHTPUEjlIEWE8obWAoztsxiBmq3MVv0Bbp1rnJAsd1dzItJhexqD9UgPvY4kNthyaORV5OB+vbXZNr420k4FgmEi7PI9RriQvflGOSmNU6dz3WJYNAyloaZA9g0+ffmhuQYjVOpudSiuyOZuIrl9+n4eM9jtDyMOJhuz/kf5+cnDM+ibtYBNHmi9C2kqtoaD3boZjKj3bIFZOLodfuaccro7Imfn/SLwrLSU5P3b4M5K7UWSldHGODV3PAtQR6FxdWGEHEvHNG/62N8OiqRolFYgsMFtlOC/AkwAvWOP73pk5KuFv4g8Ob1bnEvVI+jAzPktKWecMjeJR18iBAj/qHu5VS+XxYJF1t8L8HOckWxfVQrGQkAYxMYZnlyR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80673d66-5d63-453d-18ad-08d88d91bb1d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:32.3904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ip3fSgeHRm5+v2I7f9jsrPwntxy9cD6ajI6EHAA3fUvIyA1grU7VXtWOhRePdJagRUpJiVH/keEl2OCn3801qg==
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
Cc: Eric Yang <eric.yang2@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Jacky Liao <ziyu.liao@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jacky Liao <ziyu.liao@amd.com>

[Why]
The GAMCOR memory blocks should be powered down when they're not in use.
This will reduce power consumption.

[How]
Write to GAMCOR_MEM_PWR_FORCE to put memory to shutdown
when GAMCOR is not used.

Signed-off-by: Jacky Liao <ziyu.liao@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
index 9ab63c72f21c..9da66e491116 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
@@ -136,9 +136,13 @@ static void dpp3_power_on_gamcor_lut(
 	uint32_t power_status;
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
-
-	REG_SET(CM_MEM_PWR_CTRL, 0,
-			GAMCOR_MEM_PWR_DIS, power_on == true ? 0:1);
+	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm) {
+		REG_UPDATE(CM_MEM_PWR_CTRL, GAMCOR_MEM_PWR_FORCE, power_on ? 0 : 3);
+		if (power_on)
+			REG_WAIT(CM_MEM_PWR_STATUS, GAMCOR_MEM_PWR_STATE, 0, 1, 5);
+	} else
+		REG_SET(CM_MEM_PWR_CTRL, 0,
+				GAMCOR_MEM_PWR_DIS, power_on == true ? 0:1);
 
 	REG_GET(CM_MEM_PWR_STATUS, GAMCOR_MEM_PWR_STATE, &power_status);
 	if (power_status != 0)
@@ -229,6 +233,8 @@ bool dpp3_program_gamcor_lut(
 
 	if (params == NULL) { //bypass if we have no pwl data
 		REG_SET(CM_GAMCOR_CONTROL, 0, CM_GAMCOR_MODE, 0);
+		if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm)
+			dpp3_power_on_gamcor_lut(dpp_base, false);
 		return false;
 	}
 	dpp3_power_on_gamcor_lut(dpp_base, true);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
