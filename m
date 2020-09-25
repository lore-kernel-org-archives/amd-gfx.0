Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1286C4727C
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A942068E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qkmomT0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A942068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D18886ED0B;
	Fri, 25 Sep 2020 14:55:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B1B16ED0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ8/1CaAPuBrwzAkd1N0j11wsDgMvNe3Lu8Ako3wc9ciHMQD1A7gFmeZHJKwE7j7nEzkw4s8PzbbFXIhf39+oevXgY8CyWoatco12Hw5EWc3kraDzvk5sYha/lmUSVj+sXzKXtnsfoiQJHLYt54vwaCd4tEz0LNXQHBBrAVpbrpLggQ/zaiuFNo+xLEpGNumxf5i/Ni/r+igl7Sw1SquVYfDnFyThO5eYaw6Es3sXVDHSAoMQvp9OJxbpnQgmXGsiPfaCDnM+xAKzvd+5NdDRFPYs3feQju3gu/23zQjYl2x/PVqpFK3C0gCJ1efB4lH/Ov8ZC49BkfVArop9Q6ong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5m4yDaN1SO62qKyIY+M5amPrig6z+k+oK3JEeWmWNw=;
 b=UUZo2A2LADZ+bcISrRvOiM2CwMZT07YAphlJ61rAOqz4bw1XIks7gtwnBgmJJoakAU7FmS843HOJ3DiGrLpoNOIDKmn95fXXmCBRgKJSAywkTWhZGNPkcDfguyAa/IujknF3Tlm6JQ7+iv5B/4rJg1CYisucaLIsvrnwKDTywgELJ2EeEnMqXzAQz8E42qkMZqfn+FpUeBE2KU9a1aTtCadaXGDFyCkJYLmCZjy0CIV77YdZeKvUHJomMiDbLiDf5puETsdwovITVkTpnikUUc6CkjSpUGAfvMJRp1EDfw2FDqZWpJrzMzGNVa/jIyPG8V9uNJR/jrDwOYgZ+MRbVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5m4yDaN1SO62qKyIY+M5amPrig6z+k+oK3JEeWmWNw=;
 b=qkmomT0K0GHpqWpt2/rmuFC1d2H5WXwtpw4zOuo++lflgEQ7VTCdRuEpmGombqF104pw+ZbX477htDxI4BKgunjpMoY4S3UJJ+5+tUs0UsWeAZB3GaNFlGbBSZOF0qUYVOcVVyEJqERzOT22//6E1kYNd1S74JahcKyziEjtmMU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 14:55:13 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%7]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 14:55:13 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/9] drm/amd/display: Add debug param to force dio disable
Date: Fri, 25 Sep 2020 10:54:52 -0400
Message-Id: <20200925145455.2398170-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
References: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::980e]
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::980e) by
 YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 14:55:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f442d13c-7e9c-46e9-474d-08d8616301f3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42195B445B75939D04D7E69198360@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3v28/GB0EFgEg+uRZCsyvELAtK+7dnwIyvrUvo15gTrZZU/UTnQwafS0ZfM4WtBqEfpB5sryjlw/6RdGqCU5G6Uc5+T+ExKoJ5/XidVA1G4xUJrTfvZwXes3bDiWHGIs2NQaKCT1L7PoeOQ7cLdIqxnQBdnuve9BIBOqD+gMmnE11YB8/ka631nibpeyaFez2WGkj9cYagYp9wvXnwARNjr2510lfu+mFkcsoUObFwmqltzPNxege9QD+ow+f4o24ZbAoDwXswclBxtYpX0n/FbafSkMQzaYkMPjnO5F92jekhlA0YG6kbcy+GZmq84R/DyTHvyFiJX5drOTXsH9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66946007)(6666004)(36756003)(16526019)(4326008)(6506007)(52116002)(2906002)(86362001)(2616005)(478600001)(6512007)(66556008)(186003)(66476007)(6916009)(1076003)(5660300002)(54906003)(316002)(8936002)(83380400001)(6486002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Yj32gX5w7k7fVUaW95CD8Ez6MUuqCK4bUf5BydjbLFLZuTLj8FBqJJXGvhTBgTuyv0tkHrIkvFGTvBDwvQj+4ToN8HGzB3NzYCxMiZy4CGpcHhKupJCsLaGD8jtUfCPwYsvIg+xI7dbMtNMTvMDMl5tb759AGoyfrjIb8GbAR8zMwnUB3PeoyODpo3P8cxuiQRdIFq07fiH5L9eWFV9NBBTeVTEXLCjOICbAkmoIAy22IvY4MEj36+78tN+7a/OhBVhcoRoI+C53mKSTt5VQG1xaSuEQQ0qF0ejXnzP8gBGPr4isyj+Df+MCWxnwIVKslt/cZDrlSx8FQJ766TgmeHvW0Zyjh48kGJGs/+9gN6VbgI5Qm3A4wDcigOC6CptxgHSM9IJujUirv1LMtAFmzPdl8i8cGwEsJr8FYrRPylrU1ZlTfWlC+GD078qVfrCWk4K80ibQ2sHVReTCXIrE3jfNa2Ee6ysBWWdCzlOi4KHlX0uL5Yl6/qVbzWPLnTv0P0spoVTyfFxZyYktbgMu+pHX9ZZYxHL8UVV5PVF37B3mJLHzrfHK5R5PiZZ+u3P5ABU8vqye+NWO4P/RijExb0qcHO4sjPDKtAvKbtVFtFpqev96QsiXbJ0sjp+a7wXs6vlAfkqn2hHZ3ZQvKqLVfDbPmf/GmvTXFq2QLhdOoDt38mrIitt/oVBzr/8Hwzl7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f442d13c-7e9c-46e9-474d-08d8616301f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 14:55:13.7194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIJV+TknpEBddzThKmZ1UH/3Q0tefHsV423qDXW5T41wrBbXo5DsfhdpWASk6xD4ijbf2mbSIcZB30VG8fegKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
At the moment, some tests are failing because cur_link_settings is
invalid. As a workaround, add an option to force dio disable.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dc.h      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9fabe264cdea..dc90d26e2663 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -735,6 +735,8 @@ static bool dc_construct(struct dc *dc,
 	dc->clk_mgr->force_smu_not_present = init_params->force_smu_not_present;
 #endif
 
+	dc->debug.force_ignore_link_settings = init_params->force_ignore_link_settings;
+
 	if (dc->res_pool->funcs->update_bw_bounding_box)
 		dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 061ca15660ac..82fe0ab56e3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -503,6 +503,7 @@ struct dc_debug_options {
 	bool usbc_combo_phy_reset_wa;
 	bool disable_dsc;
 	bool enable_dram_clock_change_one_display_vactive;
+	bool force_ignore_link_settings;
 };
 
 struct dc_debug_data {
@@ -660,6 +661,7 @@ struct dc_init_data {
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	bool force_smu_not_present;
 #endif
+	bool force_ignore_link_settings;
 };
 
 struct dc_callback_init {
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
