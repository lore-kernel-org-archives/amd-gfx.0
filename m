Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC488C19437
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C0823B86
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C0823B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3BE56E9C0;
	Tue,  8 Dec 2020 19:29:04 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760045.outbound.protection.outlook.com [40.107.76.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 451086E9BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoWokFlb0Xf2MlFdOqAdq0P+63IFwBJXR965XimPoIGApsrVJzW7pTxMu/TYkuJlMXrY9OfZmeFlMetmUJHbx+2xU4k0/B9weev9lDKiXDiLuCj6/GJU6lkVa+3uTp9RTtHZ97HiXRTS9GIXoSGv+U6dLRMOcebRgMFS7kHuzELGWXc7c2lTdAtoemVxlnQ305iUvgkx1BpaVEbqsddw3eOYjIguc6boNt/UEaWhMPrZxzdEPLIALVduntB4G3djP8pRn6ZYVvg/aST5Ra+5vTuE3FvOxuaHAIIwOP4nq0pp+DJn0RWmhsZOU6R+/nZhA4qLTgRVgh/GqQaSTrFDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPq4rwR67nx8Pwbzt1mkNo4aBgcslX8ppsStOI9ToTI=;
 b=fg93+bBBjPjdfYuDNtMgx90zeQng/GvT1HviSZdGWBzufqLSDuyjflCXYOJVRivgr1zbskmlMxHNLBlvjvwVGfRldXNMVKzEDxjV24j9+ZIA2GCqjdMA9tF48QpBw4hmMpzQjpKuVD3UDKLjp5KGlUcZFs5pDvA79grlh0IG3AGVbK1J6Tu7w60j9/Kh22ObS123dO6rr5tvWGBZ0wJNAY4PGeMbhZqxyt/INbhg6Iue5USrEl+Ed4vns3OlxduQcm+q4Cq8XqW1/w41HUJZj8V37V2VkuUbmAXQ14TsmPlNgBQOHrOcRRQaKm5L6wwVRbRFGvNljy8APjoz6ZNobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPq4rwR67nx8Pwbzt1mkNo4aBgcslX8ppsStOI9ToTI=;
 b=OIyAdD1qGxDQ1zLFY/94E/fH/FspUx2AyZoRJe4C6Gtz288skZw5kQQ4Emf0IjpQhn4vidpDo0AgGLVmyRxkniGXhpH/U+v6aCt+LiGUMorvKUpsomxI3lyWwNKvCB+buBgI0DEckiBT20V0k5SxAOis1coz9Y24+Fhn4SZlPEw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 19:29:02 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:29:02 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/13] drm/amd/display: updated wm table for Renoir
Date: Tue,  8 Dec 2020 14:28:39 -0500
Message-Id: <20201208192844.23580-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208192844.23580-1-qingqing.zhuo@amd.com>
References: <20201208192844.23580-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 19:29:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 26b2ec68-1ecb-43da-8fa7-08d89baf84e6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43880BF6F1ED5AB29DAF8287FBCD0@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBViP+ZrfcNj2vCZWnEtgD4BPld08tN2fs48i7XcgFE4/G0S56bGzNGqeXZEYcQ5bk57Q8G+hywEf88RyKgjCUjsdbilXbkooWbNmecEwOK+Bq/7dHTnnUm1DkwmT2fj9nucA1jGQavRZY/i8vicSJgFmAWtZ8ZFckgN5CHJ5B9nCbpsjDuTT/kJW48fhD4gZXfRPAQ7Kebksn30wN++r7Shp58jbZZEJYIdSB0OROA9XmEF640nCCY1o4eyuL5/ZL7KzEA0Y3R56h/3F6ICo3PiUYOVXihvPNj3hfNcVjjo2LsGFe2cowtX/v07PiC+F8mZFCzInCOhhM2Y7P4cJ05Qth7F21Hx+0srpSdbEN3bomA4qoi4z9D/DaoL2au4XvcAfZiZK914ybloOHyaWG/Aezb0RQQZUohK3O3OUFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(6666004)(86362001)(83380400001)(34490700003)(6916009)(44832011)(8936002)(956004)(2616005)(186003)(6506007)(36756003)(52116002)(66556008)(26005)(6486002)(5660300002)(16526019)(66946007)(4326008)(15650500001)(2906002)(66476007)(8676002)(1076003)(6512007)(508600001)(69590400008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GeudywbSG2h7w6DYUrGuC4H3veKmoBXMiLhiILyCpmD4SvebUx3XcZC2Fmtm?=
 =?us-ascii?Q?5oPMsSs1NWRY7V2GC91LfWpj0iso6Bu/AVFeirv9HmX9zB9/zujcgCSy4gld?=
 =?us-ascii?Q?AvpqIOmATB4zyAMsvdgNFhoo+EiW+AftwUn2Xwau0eIzKnty4AnbWVjQwAT9?=
 =?us-ascii?Q?qBYnfe9tJq/wKz5f3HgBCHjVSUpwJMHc7YPJWcrep4QMHEwAusZSMcYbC+oD?=
 =?us-ascii?Q?+8rtwiCEVwbLvkIDIfP56IjKP86IO28iOaY5RNeLUn0zMLveRC78eIa6obq3?=
 =?us-ascii?Q?Qq52ZCp5f3tQFqqHGVr2lVorJBybW5g9WfZQ6Upc1LYNFAXvddwlWy6g5JM+?=
 =?us-ascii?Q?b/sf5iH+d5kWuYi4aD0ysSncOhrgOAGDXpZ55FS19R5QYlmfpb8C2AzI4vya?=
 =?us-ascii?Q?YUrAOhIzI7ferBI3VKHSk5tBzavG1l+lLCyNVIkHby5waD4LcE3nHExWCxed?=
 =?us-ascii?Q?mlMf7MngHeT4JawCPUkWSn/LTpM6Iq0jzo8e3N3PJMA/ELuI4OhV7Yqhndoy?=
 =?us-ascii?Q?oqzZD6BdOvaLXNtk0Y3/WV9tJpWolSEYF88ZWipPssNgTs1UcqiYcWlbkqxP?=
 =?us-ascii?Q?Ks+1biZykYj4vGTYEcugUDsdLyHmL5z8zr4xmaobtVCMcGWK+tQezc/ZGJ14?=
 =?us-ascii?Q?NZS3gFLu/nzkTC/74fxkvd5Msjmyx1OEnQlRk8EDNBICGsur0eA6NuyNNpnf?=
 =?us-ascii?Q?lV4WOGPg0tQO+DAqRKJDiFH6jZsx80zm9rS6kBFpLmhhVdECOe+QQC7dzJlL?=
 =?us-ascii?Q?TTazfcub1xD7sT9/k/SmOc6MqnGAUJWui8Y1JzCzs614wiHosjm2iAKySmYP?=
 =?us-ascii?Q?5Zgg0LSEkqizuxirQGX51M6WytyPdOcUi30fcVyYnQtdqJCXLgp5jkvHuR2K?=
 =?us-ascii?Q?TK8sRzkX/6pkuaKPluz920jYp5Hz3SgpdiPTBvBMVWrvjHfaOygUjrc6qly7?=
 =?us-ascii?Q?mzOkFeIxmXYhbgENYdDOvIqWySOLBxFPKF1iDSJF5RC4HFFMJIm5vqanw10F?=
 =?us-ascii?Q?kzAG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:29:01.6144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b2ec68-1ecb-43da-8fa7-08d89baf84e6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQa+hVUcOzVClykSn8g6xbiImj3v7vxVcke4ISY96pjnSovg2TWCGTJyryGt0jc/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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
Cc: Eryk.Brol@amd.com, Jake Wang <haonan.wang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[Why]
For certain timings, Renoir may underflow due to sr exit
latency being too slow.

[How]
Updated wm table for renoir.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 6f4fe8fce6b7..d00b02553d62 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -746,24 +746,24 @@ static struct wm_table ddr4_wm_table_rn = {
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 10.12,
-			.sr_enter_plus_exit_time_us = 11.48,
+			.sr_exit_time_us = 11.12,
+			.sr_enter_plus_exit_time_us = 12.48,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 10.12,
-			.sr_enter_plus_exit_time_us = 11.48,
+			.sr_exit_time_us = 11.12,
+			.sr_enter_plus_exit_time_us = 12.48,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 10.12,
-			.sr_enter_plus_exit_time_us = 11.48,
+			.sr_exit_time_us = 11.12,
+			.sr_enter_plus_exit_time_us = 12.48,
 			.valid = true,
 		},
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
