Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72DAC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6020310E646;
	Fri, 17 Dec 2021 21:24:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25AC610E5C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/6PwWmat85l/A0PdwOV+QBusRjPWMtDK35kKrqnM1GcRO0s3ad9ZxPejwzR8FFs5ghgZHBk0ZESTBLoA2ZHBMcEO/twzHDFV5nx7h1vycSHvBVOBv7NkHUqgZ+pVhsXtjD8PlqPLcoA4QNZkyx7K/FYZvNcRWJ4sYHHr5DzKbPaiw6IkDDoraoY14Fam26gCnuQsQl5vaE9oQ5OiuOpr42VTcw129ypYmSwgLfrp6OVgBiPT8QJFyuVJGXolQE7Gw3Il8RiFSalia/M7XChqLVL+4VuCNSo/0VFOgdhQVpmYSjXb5OUkpYHNysQpnoWScC1bIlgnK12DBLE5dzaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h45rCKrEhDNv6hxvDx8OWk4WbvjXvH9j/j553TX0e0=;
 b=lpi/vOf9NAut4TGoB7gS7u0p5MeglIc/8tQqZNR520gObaOGgSb5CqRjeH9GTCkMcqK8v6qyEYRG2sFhsdu7jjZPAUImnqy+M/77Km2ylRp0oNXJI/PaTDDdz9dO/XLalt4bgsBgerq7TRgVTL8e6iNF9BkxOu43Cgj3thXijN6Zv4aTACPSHvQldBpF3aRSUufXJP2c6ytashr5ir/14aqlM9U8LW4g3vbFYSgXJF1W5PBRl+So9/XjKLITHZHpny4cjxdN35zCGzF8I9G13xrb8jtP5gqzbNDRU5xaydb7+Hj5FJ7pHp4RcAuaadKHeFGbqKghNW/nFRq7QlUX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h45rCKrEhDNv6hxvDx8OWk4WbvjXvH9j/j553TX0e0=;
 b=z4UMsZrCE3fjqP2SWAXsf15Oni8WlQc3z23Hm+IhN9PpnmL+s8h4zjG50vJ3FgTYVfwl9AgK+6qWAxyIfuYxlSzMbI4B9IuZjA21LpVcHmXXfq9OO3XhmW6GrXjRpJ98+Ofi9CXgynJQeqb8FHawWl4YpngaroNu/yj3I9alfb8=
Received: from MWHPR20CA0037.namprd20.prod.outlook.com (2603:10b6:300:ed::23)
 by CY4PR1201MB2484.namprd12.prod.outlook.com (2603:10b6:903:d7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 21:24:25 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::c1) by MWHPR20CA0037.outlook.office365.com
 (2603:10b6:300:ed::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:24 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:23 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/19] drm/amd/display: fix B0 TMDS deepcolor no dislay issue
Date: Fri, 17 Dec 2021 16:23:49 -0500
Message-ID: <20211217212407.3583190-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 300a9782-4df6-4a90-ffdd-08d9c1a39995
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2484:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB24848671840D302F47F549AF98789@CY4PR1201MB2484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vI0NFYLGiknAwGVBMQypZRCzNWVuikH8jZUXGxPXoLzzOddSHzpa7wBUgy9Df5g9Yj2+jN71hjctWsw/+BnqD9dH/8WuHJPiSwfSSexK70l0aqU+E7v/cPY1D/e/5hP+0r1tlLRJlLnzHY8bjxYXKl/40zM12aLrkaRR+DbXwtS59myaVIvCoFXN+V2aurr5XqE+uS8eRdl20p/kkM/fBHyTVOknAh3o6wsAMScjL6LdRaPOHk95kBQ3HeoTJ71XUKWMkjMMoXBsLHVMqz1cienrTwHfL1nfnLRU3h/dcDFZ0B3aq8dJESEk1MdFTM9F3KUmWLbmdj+V6NgGdVT+cWG17Yre/7Cz+vL5gfBMwN+1cDjsArUrlzLkegT9wJ4sRb7c6sKrTe+wHeo2cIwhE3ptbTxLmSp3skUneOFzV/iBIJXo/L+cp1eW6P/TNPS2lffKpQL0zKX11QqqIVyUzbri1JREuZyxloeN/ZGt63yRzR87QZlpajXEQob0vqgP6tuAKnergmHwamm1eO/P6flzFyWLrLb8wtSQnJG6W9hvSlTd5wwxnAHITYrHTyeRlIzFwmDdAEpuxc0Y/tGRRJbXvdASGIOVUkPulmDIO3nksGq3tZKHJXqQLuadbLLZtue2/y34e4aIMCR89fqgnA/wPS/dSlhRNnPJXPYB49L8wsB9CFEpJaxhnzpNw3lYo7jjherkJCihPAkLmkR+ExnZMO+UyTpc3X2CjrxTzz4WNxkoKA/CNXcmM4AyMjbXYzX6JsdR3hiA8hTtinAqIuqP8jDjkKtkq7FScGwov4Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(186003)(16526019)(6666004)(2906002)(36860700001)(26005)(1076003)(426003)(36756003)(47076005)(2616005)(83380400001)(4326008)(70206006)(81166007)(6916009)(40460700001)(508600001)(54906003)(86362001)(356005)(8676002)(82310400004)(336012)(70586007)(8936002)(316002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:24.8804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300a9782-4df6-4a90-ffdd-08d9c1a39995
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2484
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
B0 PHY C map to F, D map to G driver use logic instance, dmub does the
remap. Driver still need use the right PHY instance to access right HW.

[how]
use phyical instance when program PHY register.

[note]
could move resync_control programming to dmub next.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../drm/amd/display/dc/dcn31/dcn31_resource.c | 25 +++++++++++++--
 .../drm/amd/display/dc/dcn31/dcn31_resource.h | 31 +++++++++++++++++++
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 9a9ca70f8fe1..6d07dcecc953 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -355,6 +355,14 @@ static const struct dce110_clk_src_regs clk_src_regs[] = {
 	clk_src_regs(3, D),
 	clk_src_regs(4, E)
 };
+/*pll_id being rempped in dmub, in driver it is logical instance*/
+static const struct dce110_clk_src_regs clk_src_regs_b0[] = {
+	clk_src_regs(0, A),
+	clk_src_regs(1, B),
+	clk_src_regs(2, F),
+	clk_src_regs(3, G),
+	clk_src_regs(4, E)
+};
 
 static const struct dce110_clk_src_shift cs_shift = {
 		CS_COMMON_MASK_SH_LIST_DCN2_0(__SHIFT)
@@ -2288,14 +2296,27 @@ static bool dcn31_resource_construct(
 			dcn30_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL1,
 				&clk_src_regs[1], false);
-	pool->base.clock_sources[DCN31_CLK_SRC_PLL2] =
+	/*move phypllx_pixclk_resync to dmub next*/
+	if (dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
+		pool->base.clock_sources[DCN31_CLK_SRC_PLL2] =
+			dcn30_clock_source_create(ctx, ctx->dc_bios,
+				CLOCK_SOURCE_COMBO_PHY_PLL2,
+				&clk_src_regs_b0[2], false);
+		pool->base.clock_sources[DCN31_CLK_SRC_PLL3] =
+			dcn30_clock_source_create(ctx, ctx->dc_bios,
+				CLOCK_SOURCE_COMBO_PHY_PLL3,
+				&clk_src_regs_b0[3], false);
+	} else {
+		pool->base.clock_sources[DCN31_CLK_SRC_PLL2] =
 			dcn30_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL2,
 				&clk_src_regs[2], false);
-	pool->base.clock_sources[DCN31_CLK_SRC_PLL3] =
+		pool->base.clock_sources[DCN31_CLK_SRC_PLL3] =
 			dcn30_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL3,
 				&clk_src_regs[3], false);
+	}
+
 	pool->base.clock_sources[DCN31_CLK_SRC_PLL4] =
 			dcn30_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL4,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
index 416fe7a721d8..a513363b3326 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
@@ -49,4 +49,35 @@ struct resource_pool *dcn31_create_resource_pool(
 		const struct dc_init_data *init_data,
 		struct dc *dc);
 
+/*temp: B0 specific before switch to dcn313 headers*/
+#ifndef regPHYPLLF_PIXCLK_RESYNC_CNTL
+#define regPHYPLLF_PIXCLK_RESYNC_CNTL 0x007e
+#define regPHYPLLF_PIXCLK_RESYNC_CNTL_BASE_IDX 1
+#define regPHYPLLG_PIXCLK_RESYNC_CNTL 0x005f
+#define regPHYPLLG_PIXCLK_RESYNC_CNTL_BASE_IDX 1
+
+//PHYPLLF_PIXCLK_RESYNC_CNTL
+#define PHYPLLF_PIXCLK_RESYNC_CNTL__PHYPLLF_PIXCLK_RESYNC_ENABLE__SHIFT 0x0
+#define PHYPLLF_PIXCLK_RESYNC_CNTL__PHYPLLF_DEEP_COLOR_DTO_ENABLE_STATUS__SHIFT 0x1
+#define PHYPLLF_PIXCLK_RESYNC_CNTL__PHYPLLF_DCCG_DEEP_COLOR_CNTL__SHIFT 0x4
+#define PHYPLLF_PIXCLK_RESYNC_CNTL__PHYPLLF_PIXCLK_ENABLE__SHIFT 0x8
+#define PHYPLLF_PIXCLK_RESYNC_CNTL__PHYPLLF_PIXCLK_DOUBLE_RATE_ENABLE__SHIFT 0x9
+#define PHYPLLF_PIXCLK_RESYNC_CNTL__PHYPLLF_PIXCLK_RESYNC_ENABLE_MASK 0x00000001L
+#define PHYPLLF_PIXCLK_RESYNC_CNTL__PHYPLLF_DEEP_COLOR_DTO_ENABLE_STATUS_MASK 0x00000002L
+#define PHYPLLF_PIXCLK_RESYNC_CNTL__PHYPLLF_DCCG_DEEP_COLOR_CNTL_MASK 0x00000030L
+#define PHYPLLF_PIXCLK_RESYNC_CNTL__PHYPLLF_PIXCLK_ENABLE_MASK 0x00000100L
+#define PHYPLLF_PIXCLK_RESYNC_CNTL__PHYPLLF_PIXCLK_DOUBLE_RATE_ENABLE_MASK 0x00000200L
+
+//PHYPLLG_PIXCLK_RESYNC_CNTL
+#define PHYPLLG_PIXCLK_RESYNC_CNTL__PHYPLLG_PIXCLK_RESYNC_ENABLE__SHIFT 0x0
+#define PHYPLLG_PIXCLK_RESYNC_CNTL__PHYPLLG_DEEP_COLOR_DTO_ENABLE_STATUS__SHIFT 0x1
+#define PHYPLLG_PIXCLK_RESYNC_CNTL__PHYPLLG_DCCG_DEEP_COLOR_CNTL__SHIFT 0x4
+#define PHYPLLG_PIXCLK_RESYNC_CNTL__PHYPLLG_PIXCLK_ENABLE__SHIFT 0x8
+#define PHYPLLG_PIXCLK_RESYNC_CNTL__PHYPLLG_PIXCLK_DOUBLE_RATE_ENABLE__SHIFT 0x9
+#define PHYPLLG_PIXCLK_RESYNC_CNTL__PHYPLLG_PIXCLK_RESYNC_ENABLE_MASK 0x00000001L
+#define PHYPLLG_PIXCLK_RESYNC_CNTL__PHYPLLG_DEEP_COLOR_DTO_ENABLE_STATUS_MASK 0x00000002L
+#define PHYPLLG_PIXCLK_RESYNC_CNTL__PHYPLLG_DCCG_DEEP_COLOR_CNTL_MASK 0x00000030L
+#define PHYPLLG_PIXCLK_RESYNC_CNTL__PHYPLLG_PIXCLK_ENABLE_MASK 0x00000100L
+#define PHYPLLG_PIXCLK_RESYNC_CNTL__PHYPLLG_PIXCLK_DOUBLE_RATE_ENABLE_MASK 0x00000200L
+#endif
 #endif /* _DCN31_RESOURCE_H_ */
-- 
2.25.1

