Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDE9C43217
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FDB110E8B4;
	Thu,  6 Oct 2022 21:27:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D5910E8B1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajgJNGAQhIhOW3h4xwawO4+sy9lnfqtcdnS/ECdtWuafYTyS3cQnpLCGbgUTSR2u6Mv1+rtrbts79Y3SR+EhMB3UdEuWWUrKjroebrpU7w2r91ylS92zLFZ23R+tTPE8IJz/+H0gl/ZxCxGG3TOEgya/yJXYcWHfdJo4ucIO43gJANefczqDqbfHjsVWn0Mtke0N9i0SFF537lDeIEz6M5J3k+ItGC8dpuBXQpv2vPEAojL6wbO6A6eCbxI4o6mUvcGe4ewscc9rUHBbMnfE/a3KCQBi/W3QI6wf0DFy8xAkmclWb+Gl0InOOkAI+cHgD2flYUQk0tXNxgxyffPpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNDcmMcPqNwr2xcdFzzyFHFptsF3XqB9KnHnbPqtO30=;
 b=IHmIBkaCa2kWSPjGodHXUC3b5ZBfbrU4jWK571HSZ+NK/VLnH7AJIEVXbYoKNYLuvOwFl2fghhlY+8DvgowqwQP63BkYb8fhqb1bk0ntIgeZz2l52aHYSvinmC4+SXlqxOrrIAIckhXplIDj2rAUxhVvB50Ny7uglZEKEnFynAdtguc2tGD23aTgfENyisz2tvNDUxm1aDguNe0k3gYZDTQmVKGJV4I/g7tsDGdR6s/6ZokonK4lx+sKCJPl+sh6oXJTX0sORFOYExkK/iYsBSd1vfNzVYu+7st6fJ9qiRi2VsTdzteOlFxkYS8ucMtYF9Reuwyjjg0w1IgV6k/csw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNDcmMcPqNwr2xcdFzzyFHFptsF3XqB9KnHnbPqtO30=;
 b=wy8P245LFsBkcZ2kYmJCPCR4CSZrSapezRXIcc7pMv7hhVorCdShP36+pdQGrkxFPq8pPY3zpu+suXdKLaabm3tAL06ZgnB3bEPdKE9Vgvzx9Jmqws4KHmxcba6fxdE3DwpReGEWMreEKAm1B+4tT1g0KQ4vRJxnSdrFlify+Qk=
Received: from BN8PR15CA0012.namprd15.prod.outlook.com (2603:10b6:408:c0::25)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 21:27:37 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::1a) by BN8PR15CA0012.outlook.office365.com
 (2603:10b6:408:c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:37 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:35 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/23] drm/amd/display: Use correct pixel clock to program
 DTBCLK DTO's
Date: Thu, 6 Oct 2022 17:26:33 -0400
Message-ID: <20221006212650.561923-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc4ee6e-268c-45d5-82f8-08daa7e19724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnDYkhejS+WUb4ViQ00nTszVN8P88fTTh1TCGA6NIJSkSCxkP59QEUjmI4nqYV9o2awD65K2qXIDigNQzNsBCQHQy8rA0BHf2TKyCz3Vg9GRV9XoNa6IkFArsWuRxItep9JHCqNgyTGwMchlT9eXD8V91ko2+WN8LKOgdyeOgge3WajnED4kpWtx9daJ659sfgQBNDOjjwAojZekzXX559U8XPM/ti22YNh5M4F1nFbk+RzFQ/6GkJOyKvueWT163pZIzmOTzReOx7UZBhJh/IyGuS0GmGSWKhbmdOWYyo6/6BNMJqTjVYrqRxP6i9NrlnUD/ilmhtUjKomeDmsarSLcrZgLw0G505fdOJIMHJ1LfpZwTsPjA2g6/gIaXUS39O+caXulyRUeqwzwFHXwDY+jBIMez1bzFetK+m2ZRz2Qyrq2SLZkuUV2Xtkv05au5OKpTM/MEambkb73oemTaFwUglGSf/p2oZlsewQ4KaHfCJ1jOlEcS1EO0yKsdKmOBj+0Nu+V7yLIu0mg+yKxfs68KyVxmV0nFXaFMWTeIDUYMG3X8FQ7/68LA8Dfsv7tLoYg82GPK9pmlNrJBzh7GRSk2QN4kicM74xye9o/3E44FzTI23wRComYvck5FRDgTgIxDJx9ssuHKhLfziNcNaBUgmKD1HEpMXEPnJcWwalIFrp8ppSUVfqwDtqYQ5LF/GOOiz94/U+cdUBoVk1eZloTJN+noLSD48Oa4AU3pTTdHizBXaGmzL4uwALAnnOnCT9JkQtY/Y/Wyy7XCFW6EOM0xYn25eCj2kX/MUEznWU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(26005)(86362001)(356005)(81166007)(8936002)(40460700003)(8676002)(40480700001)(70206006)(41300700001)(316002)(6916009)(54906003)(478600001)(4326008)(5660300002)(82740400003)(44832011)(2906002)(82310400005)(70586007)(83380400001)(36756003)(36860700001)(426003)(47076005)(16526019)(1076003)(336012)(2616005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:37.0954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc4ee6e-268c-45d5-82f8-08daa7e19724
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Why?]
Currently phy_pix_clk is used to program DTO's which is incorrect.

[How?]
Use the timing pixel clock to program DTO's correctly.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
index 7d3147175ca2..153a88381f2c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
@@ -111,7 +111,7 @@ static void setup_hpo_dp_stream_encoder(struct pipe_ctx *pipe_ctx)
 	enum phyd32clk_clock_source phyd32clk = get_phyd32clk_src(pipe_ctx->stream->link);
 
 	dto_params.otg_inst = tg->inst;
-	dto_params.pixclk_khz = pipe_ctx->stream->phy_pix_clk;
+	dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
 	dto_params.num_odm_segments = get_odm_segment_count(pipe_ctx);
 	dto_params.timing = &pipe_ctx->stream->timing;
 	dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
-- 
2.25.1

