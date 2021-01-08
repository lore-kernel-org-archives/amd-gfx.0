Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D37C4332B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7355923A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7355923A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F8E06E8E9;
	Fri,  8 Jan 2021 21:50:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E90B76E8ED
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc53XsbBo6rKbHP7/ROBkCs3SF4FZ52WRB6h7IqoxRKrF2fs/8R5jsAcvvXrV4LuXEbekg3GjyXsj6nvY0/tIY2VZC+yCj4CL63IgIsIdqbRBsBj29n9f5QoI2uaaLn2gy5NEnLykxoKz3SJ7zXG5/p94jm9/8xZFWnD8kacHt3S16nTyyEc83LCAV9lN1QkG64BAs71haRQdM1ENsqghyz55i2RDDoIw6AZd1uUKV3qfTY+26gH3o8rP05BPM8qeRF1XjE5DJZ8Uzn1Fmowqahq4sRwbAmP7iSnKpchwVC6ekoim0mUbYggJ6dZKJP9kDUdvZ5e0AIRtl4MfeGiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLsPyIlbD3MC7Fi9Zmc9XhrG5k5i30ZB8gCnL4hiHkE=;
 b=GIopuhQLCG0ybwEUFLsXa9GiI9h6nXv9eRMnuH/KPk2jw3JwpiYTUSqCV9vsQ1GsRIDF5d6pQWoQzPhx/iqgOSIXcE9m6YjzW9dsbDcC58bA6hHgQ3FlxMDgr4eg0kubYPD0TyIWwbX1bu84KT2kXXfcyVc8DvWwZG02a5hGMGim2Q9VdjwwOKqlrF8ilTFCgkfA5l8dXNxFyyZmdh0ENS7PUL1uJLTjl/zWd9T4xhNhB/kZOVb3AlAYg/H0KOaekhuCSwZbcGtH+0YzhQJdwRc7I94YuR8CCQtT9W9+LnYcgxS/uDcmofZ39m1t8rOfMYjbj3+xTjNBej/1mWrkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLsPyIlbD3MC7Fi9Zmc9XhrG5k5i30ZB8gCnL4hiHkE=;
 b=FMypZLnN/N9FZyW/LFRuDkMiIViUTYO/kQjG3IsM4MpHOSILKZtoKSn3LTw1NgaLwgncBQ8lCy6B7J56/5TKBijvSa/qOruBomZ6Pmsaep8vdzKBdIvyFuWozow/4lxPzphr8tTXD0n/bWj456Ecar8r1ZQG/C3wwIh4jmU/QcE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:42 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:42 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/21] drm/amd/display: removed unnecessary check when dpp
 clock increasing
Date: Fri,  8 Jan 2021 16:49:55 -0500
Message-Id: <20210108215007.851249-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:404:e3::25) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 21:50:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e5d253c0-a2bd-400f-d900-08d8b41f7234
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882F3BF76BE90AFB9FF51CD98AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZncETG2Ur/G6aQsv0kI4GHnJIg3AQW0iV4VXG7/aRrukxRbZuj3hnbr1Zt7m/sm2AfbQbjFyTnXXkiuYWwb5r93F+zVxWx68T0oPalc7mqgkd8CFg4XrTr94NDqeire7CI6nEYII/di68YAOWf2oq+OUEpeVeqsxj1EddLM+JF2WFGyEzOsnjoR7GWdL7ZNwGdceUL5HKVilFWFym72J8zGMunRpYR04g3G4ySw+DBveM8YvNOsihAE2L68ki1xysufgnUxDmCvHCOjtC8FhlXclrKTHz2kIhRKwvdGAACBo0Hf4cWDXsGC95/Gtjj+taZURftrEBsKpxZdbfDLws4ZvBo7lpjddGY9AtQXc+NFq2Zx2e/H/S07qsb0JEaBvqbMY10T2717NXpi5zkaZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?28MF4aiewfANH1UTxVRthG4STRFyc1h79BkbSBLbZ/ZCF6Hz4yVK5N6hoNxR?=
 =?us-ascii?Q?m+ZPuOhKQVC9xVeYKBRkejYYtPSVaRVHE9oILFe14s+qBLkmxQcR8ABgshtX?=
 =?us-ascii?Q?ULipEHhoqyHxBxfQZDj6o0kuch+XK59+lvp7ZbhmktcCwk2qIRAd2NxyANEK?=
 =?us-ascii?Q?N/57hfHSyU76DWEoFjStlncGnXQqOW6Mp+NPWJQDA4HLOsAvZle9k8CnGm9i?=
 =?us-ascii?Q?2OVwiqAf7IxEhSKjiZJbNvL0jKXYQV6e7bZV88neDMovUC0boabYTOh3nlpP?=
 =?us-ascii?Q?dtL2ivd5yiNuGoJSmYn78TCjc7lvmAprya5BJVZZz3+YEzaExOLKLZTDMN20?=
 =?us-ascii?Q?aawrIXNly426JzQ1c7XHBUy+klz8WF7Yg6eGsE0wL33WsPNbhGnP06kdkC4N?=
 =?us-ascii?Q?CPzyNRTCr4gSZvCp4lda08703NjpOwZs7WXHZhV+UWD3tKTihTxK7BHehSzf?=
 =?us-ascii?Q?2Z672YKO6Zt8GaNAA0ymVYAcnvKBMz7tH0IsoY0iTR67vIgk4DJEAW84X8PU?=
 =?us-ascii?Q?tHHWP6iap3gDmAIcCqktoyomc/V3OUEK9hs0hRmlnVBCHWN8jK37s0QXdKk2?=
 =?us-ascii?Q?/mIdiQ/iefUej+4u7C78GnPtnjjjTEPIlcO+3iI03WuDtkIXfec4/rrns1kU?=
 =?us-ascii?Q?80JOAb+KJeTtRc/pijn5q65Rq5gN94XfedSbLsvVi7EG1hU6026Hx2u2hu1h?=
 =?us-ascii?Q?uhgxcDw3uOe5m9WpFxykFKwQVZU2yq4o7vaToU45xr0F33WG922IEZFzKj/5?=
 =?us-ascii?Q?kZccoE5zBQ3gML21N98MHqatw9/wsQuLnxwb4pLxHkMJC02Txmv+mWnqpIHj?=
 =?us-ascii?Q?wBiMU77vyrf5BAzObbuP9910zQ2BEmYUxbvgPm8lXt879Hkm0zpRuZsZITjs?=
 =?us-ascii?Q?tG2g7BTt3usrFGEufj1//KqkX3iJmoOEC3jUakLAeMr93qL3eQ+Vs50aaFgv?=
 =?us-ascii?Q?4lbmWX7FgNg6Dv5UIhNN855udyFpI//tTeuIyy10DztVtbak3UAfmTRqSUdH?=
 =?us-ascii?Q?v9I5H2+XD94yEaRceU4gShmMeFZ4pqxWeNA/mTA3bbtncBWAG9XpVrpY/SnX?=
 =?us-ascii?Q?yJX1wvl+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:42.4337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d253c0-a2bd-400f-d900-08d8b41f7234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5THMc4QbUfh7Kz2R3/Z8HcBnRzdhBHRed6HO0A6JtWPd5pShLXIkmzcXf6EsS4JDy/++55lkU1NqBh23vHVVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Chiawen Huang <chiawen.huang@amd.com>, Aurabindo.Pillai@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chiawen Huang <chiawen.huang@amd.com>

[Why]
When switching single pipe to split pipe, the bandwidth check is just
for first pipe.  The 2nd pipe with abnormal(or zero) dpp clock when pipe
ready and unlock leads the garbage on display.

[How]
Removed external increasing dpp clock check, the internal function
already loops all of pipes to check whether update dpp clock.

Signed-off-by: Chiawen Huang <chiawen.huang@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index f2114bc910bf..ec9dc265cde0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -257,8 +257,7 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 			if (update_dppclk || update_dispclk)
 				dcn20_update_clocks_update_dentist(clk_mgr);
 			// always update dtos unless clock is lowered and not safe to lower
-			if (new_clocks->dppclk_khz >= dc->current_state->bw_ctx.bw.dcn.clk.dppclk_khz)
-				dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
+			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 		}
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
