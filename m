Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6FAC433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 15:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537CC613F1
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 15:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537CC613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC7A56EE4B;
	Fri,  7 May 2021 15:00:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F26D16EE4B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 15:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7hNB1EMKSdNiTUXkGY0TkhWyxRhpZMQD6T3XwplzdwPwUExq9gfBhe4KObxmjebJNQgDp7D+XYi18iOA0F+7mfXW+uiDONFpyu07ShCzl/foRz4EXMMO9ZOE9rOTnuhHYvyNUkDI01O30ay8hprN+MviEVdMHuZ/g6cCFoEkoiJAyASiSjqCaNaklgkseDDbPoateLVvnvgRVpszEfW4iNba8868qJGYhzhL+/vArnHQQkTX3b5Obv1CY/JMl7tW5W3tn+CJYGqLinjwiv0W5XsxdRnvVgeIRcNpKmGRX4ow/NfMKIgZupmQav7a8RWAvmeCZrXZ4zil9XkWU5t5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oASdisrWF1FDl8YLfdtQaPxLKUdbFyvEYXbuUXhH6bI=;
 b=OeNADfu49aOZTrAjdj36IskMfpvxJ+FpM/PIchLxDIsG7IGhQD1JBauj+R5ftXPTmjnbhO+Tbj8Ya/AqV9U/JyFKZVTBHSm/G9ITErQSe1yhIphfkUrgFfJjrNGL+vEg2z2ITTPABLHfzXkvz5pxoUhAcOhAKpkasKwxd/AprahGb2XdKUlVV+M5NyYgflmrt9p6ELDzHtECq/e9ofTpDrNQPchZAUhQudJXh/6rG3OxdO0Af7V5RvDzEXHIZ+MBISKkLmwj9DVhym23DOZt8QPknZDjxALtrZyLm7mog5+9xP6c3cJ4pJHDCDr/gHRylzVEKLOzMwQx+IAyify9SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oASdisrWF1FDl8YLfdtQaPxLKUdbFyvEYXbuUXhH6bI=;
 b=oK1/Zrli6xBnKpLbhQMxGBMOHlstv/x/sclGGabXy+ZPm91kYR5BoYhLDfjjCRQrel1aonW9QhBiwb4LLp++ErMNugiVUm8nITpc77NfRrkpfpB4eoDArIPh+ofbvlVnG9423auW1T2rU6tyxBxPzyLDdHIKwPz7o9OmmPC233Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM5PR12MB1786.namprd12.prod.outlook.com (2603:10b6:3:112::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 15:00:01 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 15:00:00 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/14] drm/amd/display: Handle potential dpp_inst mismatch
 with pipe_idx
Date: Fri,  7 May 2021 22:58:18 +0800
Message-Id: <20210507145822.248029-11-stylon.wang@amd.com>
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
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 14:59:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf23ceea-7b61-48c0-3d4b-08d91168c977
X-MS-TrafficTypeDiagnostic: DM5PR12MB1786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17869E739775C96CBDF566BBFF579@DM5PR12MB1786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GnE1yU9wp2L0PYcMJWqp+3Won8jxHIW1TFWyOJ/XxvuIXBeWoeGsjyz5ROQRpeHDA3HDkkMb8cPnLW5zZ3heTjK2tUbmhjcZTQaXhpJAlgQKuClxEe2OdSTWzQT6gw+5gi5MmzXM3pTNCvU29Vjpk3SiN00HckZT6S+F4nmItsyNlO+6YjxWZlufLcr3XH+xvgpXrYTuZs7qDlzQpRX0hIwRdMVTB4v1Z94ctZssu7Xko7U7LOz65bVx8MsDuFQ073m2DJc+Ogn00worHntO6milI18MqkqP3T4WviwpV8tuAceISSYitBTjdQxczrNR2yUhGV2I8tJmhSixx5MeUgv0mz9BxXad/Rh8BBrVsB4kVdyWUXtyNvBBmz0L/0Ot466goh9oc7uyuYYlNKfmip6JeoNCTma06FHLYac0l2mWUk00G6q8ii7MOLnwbwq8cNT7C3ZL9ut8VgCznvTmtEQRukLOmjjOGNvYkdtFOz6SMW43F5ZmjLm29eNSCrCj/Wvf8x2UB44RWsS2vdkGWpMnH2IHkcNtJ1bB6w2uV7YBEBgFEJzcsHDgFKU/DzypVGoDKLjM7E0qEgUvSLBdPuevvCV86/EJ2QalnKHTP/9LRCS8EePklOc7FU9tk6dnwO9ZKNIGpE7CLeBtDPbR5dlB1IdGfCb8sGIigI9Q58Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66556008)(66476007)(66946007)(6486002)(54906003)(83380400001)(26005)(6666004)(16526019)(86362001)(956004)(38350700002)(38100700002)(316002)(4326008)(186003)(478600001)(2906002)(6916009)(5660300002)(52116002)(7696005)(8936002)(1076003)(8676002)(36756003)(2616005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?o7S0Sj+uFfHTzoB8dis5hkOyjyLSoyWmDc5ZsXHEl++cfI8SqA0+rdjNB0LQ?=
 =?us-ascii?Q?oQTnA68wIKNuigROBZNedF6HOMhKh8LWM+ox+/LKjiIkzgCTsiLikwFiHHPr?=
 =?us-ascii?Q?8B68hmE2gjIrLqaPSzGFD8n+x3pkD2NZmLwQxIk4/bEebltOOA61QDB0kZjD?=
 =?us-ascii?Q?AhOQlNi/taEgRGWnE6pz6RqK2Ehew/kDyLdFCrXXoneIyyNQJnjarjrbWfr1?=
 =?us-ascii?Q?lucQrp6bplUISR3RghNdj0/5T0K/wcu/Rs4navvvyOaH3IJ6ty6N/5lsNQMK?=
 =?us-ascii?Q?6sJT5Zi3lyCOPZ6k05Koo000E9gATvV6p62txY4tSj6fsF06VufOz1ZeDNtB?=
 =?us-ascii?Q?Gd5auESp9PKaRfdy10G3MWlJeD52k0wrmi3btebsunB72yo3MnyRmXWCtSqm?=
 =?us-ascii?Q?HIVneRafRxVzYMZy+YZwa+b9qcylnbqDqVQqhC0jfVJ6/G1smQKTzZyJpWWw?=
 =?us-ascii?Q?hto+H4ukOu8M5O1tOFvbHe0zjW3zDQYEgIf04q1uS8jaz3N5NcpoU8eTIOX4?=
 =?us-ascii?Q?AWlEOK+yYI6ClLPJJobOu45fVFiOjHFIhdzy3cEZHJK5J+DRaYfJlm2gZki6?=
 =?us-ascii?Q?lh6adBS1pHfVZd+K4EOAdCBqEgxI2WX0huZgv7igD59M20FXqZx49iqzVLFg?=
 =?us-ascii?Q?YajaVj54b1p1JrX31okFsjw3GK65jEpTA8buhFyL9R7vVFErQytjDCEcpSM/?=
 =?us-ascii?Q?2A2lWtta8aexDC2KLv6ZioqWr55Jx8tii/EtMrQuwNgYmY9klxgbMlSwzuH8?=
 =?us-ascii?Q?Y9cG84lkUcXBu1L4dij4DRQi7PoXW34g7p7hxSWn/1Tjiy7yhBndbo6fQuzJ?=
 =?us-ascii?Q?ICOlG5OiKZnD4dnEDQR1X0J9EoJ0yr7o8tjGpyZ1ZlKHkrodaCd7ClpPPUxZ?=
 =?us-ascii?Q?NBQe/hdE6KgYP5lT075QwxNspbpby+OzCebd6MOZUpni/bRkbD87qJMaEsLI?=
 =?us-ascii?Q?i+YFK7REsIdH5CBZao0R07OwZbZIdTCXUm30nPZJEVpFZr2ajHD9QU41XdMH?=
 =?us-ascii?Q?s24uTRzgSJlK0m+9Xprk4phW7IodvG7DvklooU+CTgy4x6wP0APFQpqFZqgn?=
 =?us-ascii?Q?QN3kECsRp6kRttIOL0WlFWtF60TAYvwxyoFEMtl9FpnR4X5ULdGg0q6jF3Qy?=
 =?us-ascii?Q?gOnqBtC18V1uL40Gf+qGv0xWiMDTmO9EDIUZ7tN7iWLz+uKDjatls6Vj99Sa?=
 =?us-ascii?Q?a8AboEzDqptnINvA/4FlpFp3j7hZaiFvdXWuuQqQ5aT/hx7QJh5pkjh9Rre8?=
 =?us-ascii?Q?IWjATFNsiFvNrVFNXoGVyp9RZ/9v8S2BcNUq2+437WJDbD5pGzm67dVOlsC3?=
 =?us-ascii?Q?oEN9jcjanZH+Zjs80fnH4tzL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf23ceea-7b61-48c0-3d4b-08d91168c977
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 15:00:00.7999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwBiT36EhVqD/hldd2qsAaQhey3KGhSew4reAqQrghNVFTJFEAU1xmmHykfdTfG92ehnrM+XLxEhgVtH5NmnBQ==
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Anthony Wang <anthony1.wang@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Wang <anthony1.wang@amd.com>

[Why]
In some pipe harvesting configs, we will select the incorrect
dpp_inst when programming DTO. This is because when any intermediate
pipe is fused, resource instances are no longer in 1:1
correspondence with pipe index.

[How]
When looping through pipes to program DTO, get the dpp_inst
associated with each pipe from res_pool.

Signed-off-by: Anthony Wang <anthony1.wang@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index c2d0f68dbdcc..f965914ea57c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -106,10 +106,10 @@ static void rn_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
 		int dpp_inst, dppclk_khz, prev_dppclk_khz;
 
-		/* Loop index will match dpp->inst if resource exists,
-		 * and we want to avoid dependency on dpp object
+		/* Loop index may not match dpp->inst if some pipes disabled,
+		 * so select correct inst from res_pool
 		 */
-		dpp_inst = i;
+		dpp_inst = clk_mgr->base.ctx->dc->res_pool->dpps[i]->inst;
 		dppclk_khz = context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
 
 		prev_dppclk_khz = clk_mgr->dccg->pipe_dppclk_khz[i];
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
