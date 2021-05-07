Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2B2C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 15:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91710613F1
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 15:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91710613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F1996EE4D;
	Fri,  7 May 2021 15:00:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C7F6EE4D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 15:00:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJPo5qLf/B6o+6aO9Ff4F2cmUiT4Rn0qTJTOlCp9PNPCFsfB+pAeac6ubQOY1yEhfykfLzW9VnOsnKmS95xWciPhmiHGYvY2gA+NYlzJEgaWtwICE+/IwRmHjinJToT+pjHTDimgFsIgLsql44yV8YFnFwOdGNhXbGM9OKBBbd6rj7sWhVAf6xaJS0L4laKhzHoYG4wS5xjEY1ai4vHOsxTyOqSyGVY4L5jrAla1q6/6HRDVVcymnq0eKovwtO87PtCIhMSE4DVwXNdDWUi/SXZd+AOd1yZY9nb9d9lN5TZWEOTfrCB00+DKHDf0WfuB6mSmqn17kFimT8JXgsLaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7x5HxFjESx81O28O/tzJa9E/j86++NEhRoHXzyD/Xrc=;
 b=EDStnA1c51wxoMbFVwz5TtaH7jvFEM0mGe6S4tNuJtkyEekDmcX4OMGjbAgvxtcT/gYMht8cuZIKSENOtz72eUeQmgGpC7P31JAY33dyCNI1D8Gwq5p7PfhdLxtqNlsVOCZmrDx7Cs2b7jfWpk1+lrbl84kjQk76zeDxNkXTsjKdDw7xoYuP70AHwg1OF/Zq/JcNx3zNObLJhdpBQxY/SkG0S9sbHVS2BjnkcYnL+n6NU7uS837qM4iT0hlrWByZfw27WEL1MS/7Kvcp0HzlnvkuFB8WcMwLxcWhK4ebDBXHbu2NRWsRiMctgDnvmLg2T6CqlZgF6uQXQuei22j3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7x5HxFjESx81O28O/tzJa9E/j86++NEhRoHXzyD/Xrc=;
 b=ZMJxfTetOo23Leg8yZN0UsN+IxkyTmr0uChqX9E/wt+dRyPbaVmJtoEabV+4Hp35xvjJ7LZzqVd2Ksb+yJQSJAL4fX8YqUOcKxDwHyuHHr3d6O7Z+3jEz5Cfd1pS7lURAZrRDRq9kzMlyoFGRgqC2ND9o01mtc5XhMxypyXm9hk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM5PR12MB1786.namprd12.prod.outlook.com (2603:10b6:3:112::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 15:00:06 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 15:00:06 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/14] drm/amd/display: fix use_max_lb flag for 420 pixel
 formats
Date: Fri,  7 May 2021 22:58:19 +0800
Message-Id: <20210507145822.248029-12-stylon.wang@amd.com>
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
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 15:00:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd0649a3-cd67-4808-fa71-08d91168cd0a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB178678C6821518AAE157FE5FFF579@DM5PR12MB1786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNB6e4tHelXRROYD/B1kJhrgP8T0m94hkqy2W3KenyNyGtjFfvY6lZhdadap5JL6XcJtItkwigL5HCGq7nKvdWO7A8/nI/tacrAA5B724kd17zDTXEjCLN2B2KYe2GhzIWKUehcCf3gz6SR//7kxw2S7Vhcb3rZbCG6vzylHquT9pkxPB7pwfhHKIdW19x1Iu7zQbiuMHrmln7xPX4FWH9tKCNqszpi5yI8KieAeuaqv5anAxsr9hn9oAUpGW7MpkyMSQ8jMJ2fyk1E+3p4mc5jTX8Bcy4x3VuoMq9hOFW2IBiRshjmwPSzlzFHL7Px+bDORAxeMOvya1Xiy4Pjfpo6usopMTdT/JSDoqzsYyfMWNS9IrrFlFeaiiF3Kh35LCJTuLCclkyv3jI5HhtveI8o+2EprgJgNmUoDqlTKcBgehubVxMvv842NXWxaNtrk+ciYm86JM1kV3hHVbTHvXgF5vAsybLdsP7kofFRHvZo/B6BgjCei1ni9psOy/sQ3+zOi5Dy4wkHAeEviNHfhshH3MCsa8Cxj1yCz3MizF+Jk+/uH4HKkiI1o4UIBww06pU2S8/PyHrYvxMsSQYZC3epBYcshFXe+8W1lUnYpRS8w4XqCmgLSswvd/vx1LVFO/EPHK/JNs/FjZIeTGYu2/p+DwTHMMmcmGBCi/EUennQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66556008)(66476007)(66946007)(6486002)(54906003)(83380400001)(26005)(6666004)(16526019)(86362001)(956004)(38350700002)(38100700002)(316002)(4326008)(186003)(478600001)(2906002)(6916009)(5660300002)(52116002)(7696005)(8936002)(1076003)(8676002)(36756003)(2616005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FtgTupqkAeCsUQpSOwfO0hJ+ZGBYflLeVd2OHBnqtCu6obvXaJ13rByvyNi9?=
 =?us-ascii?Q?blu3f1QRSXTWtBmz7oYdq0fV/z83SaJqhg4pXvRD90aKpHaksZbHzMIob8G/?=
 =?us-ascii?Q?USRzyIWnLzVOE2hi6g8ceSbx6eHj/X2KgjTZ9jRfCoMVOMgFBpepMhwTe2wM?=
 =?us-ascii?Q?pJ1ejR3IgkyPtLKGJbpX3xawKilDE9Fi8zbr3NJxUArykDKGxyZuPmLYVtoU?=
 =?us-ascii?Q?pgSkLzL6IUdIk8yD3zuN6lVlQnd6YvFKP/jV53CiqSlzEc8GyJtZHi62ljVD?=
 =?us-ascii?Q?7ZuXZt4GwDDc77YmZR3dapIMikEKqD5MaI5h2VIToSLUSmDgQ7SfTNsvAGhI?=
 =?us-ascii?Q?DxD7yGlEox2eryPl8h81b010ysAJee37OYzLVVoUFKgZSE7NBEDJGRh//CGJ?=
 =?us-ascii?Q?UtFwVHXvs0O4RImMgE8HG/Wq2Vfgx0+aioN4jCaAawUWBdOkLzy9Q7x6FX6j?=
 =?us-ascii?Q?+7/0CvPL0+Y42ilWYcqX1THc1BtPRctzOFqhheLSusLEwaUuLSWkiVAtdVze?=
 =?us-ascii?Q?fbN6bfv1AJH/BoPBqgSl3kby8hPwTlgkPZu5K2IRGCTRRFXDSSJhI+kRgXDk?=
 =?us-ascii?Q?DEdrTaY7LicqcEKhytCRntfJRRbwP3OkaZnouJZVfIU2sX+J6eFIokO/TJzP?=
 =?us-ascii?Q?9zWP2CB0bPfpVH3DX6WJvC0RmzbkIF6M1pMDamujWt+VBJQs/s91rH5Lo+U/?=
 =?us-ascii?Q?7WUSK2lwM4boExvjjGjR265C5Q6ADXEuA5LHyUVZvnf+rU5M17WriNiV2TWk?=
 =?us-ascii?Q?HwymvSJzRcctOfSmzcvxW0CG7PgIwlWtRvVtCUg5S0TU8WuVArS4dBvOmL2L?=
 =?us-ascii?Q?+JGSJnRLhsIlGsAfkz0nOYSpovXUH5V4Um0nZLKDv5x+H9pyOg4qBhorkybW?=
 =?us-ascii?Q?Py+yH4dm3j6+dTdZucEmWrLey85KXOMiX8PhwJcIHRRTiOZ1VwoR4Jb0Gs0s?=
 =?us-ascii?Q?8MXzjBUT/rxVByG6fjNRwBeXp7xnQ7NDlDlXPXso7iegzyPfHUXNLApktQ36?=
 =?us-ascii?Q?IRvaWZ6/eeRhwRbHghzzx2pjYVrwYD+GLxsPaOtCWSuC+LVulND5VCX7acXy?=
 =?us-ascii?Q?lK/VlN6cu38WL8jxnDxUCdaFu1VNEe4xqAkA/FfD14BTd/DqsmWiZtJvwZ+z?=
 =?us-ascii?Q?K8Aj6ykD6M0xcqiZ7R8yIGY32L/9Y6NSp2nnomc9MvTIJWWd7QTTEAIDIDAO?=
 =?us-ascii?Q?6j0ZbRmjjgp4Sl2gxV5NceaWn6I5jdS3MeBeh0MDx88CY0rXOSTcAz0DgfHa?=
 =?us-ascii?Q?QwBykjDCvuwMo6Lbof6WYFhHfNc/gRtLdGIerHZvZvf7fuGPQqzkqfRACuwv?=
 =?us-ascii?Q?yx2w3s5H0PrOrGW9Uc/laI1i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0649a3-cd67-4808-fa71-08d91168cd0a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 15:00:06.5844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQMbMFdkCsAQvCyNmwFvzz//vcZ/GFyAehkX5P2bbcjgf4XGeuVJ3/G7WoFUJy8Q03aGJCrOqaJ8v7eXw/wPFw==
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
Cc: Stylon Wang <stylon.wang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Right now the flag simply selects memory config 0 when flag is true
however 420 modes benefit more from memory config 3.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index efa86d5c6847..98ab4b776924 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -496,10 +496,13 @@ static enum lb_memory_config dpp1_dscl_find_lb_memory_config(struct dcn10_dpp *d
 	int vtaps_c = scl_data->taps.v_taps_c;
 	int ceil_vratio = dc_fixpt_ceil(scl_data->ratios.vert);
 	int ceil_vratio_c = dc_fixpt_ceil(scl_data->ratios.vert_c);
-	enum lb_memory_config mem_cfg = LB_MEMORY_CONFIG_0;
 
-	if (dpp->base.ctx->dc->debug.use_max_lb)
-		return mem_cfg;
+	if (dpp->base.ctx->dc->debug.use_max_lb) {
+		if (scl_data->format == PIXEL_FORMAT_420BPP8
+				|| scl_data->format == PIXEL_FORMAT_420BPP10)
+			return LB_MEMORY_CONFIG_3;
+		return LB_MEMORY_CONFIG_0;
+	}
 
 	dpp->base.caps->dscl_calc_lb_num_partitions(
 			scl_data, LB_MEMORY_CONFIG_1, &num_part_y, &num_part_c);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
