Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294AAC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 01:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B353510EAFD;
	Fri, 14 Jan 2022 01:38:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13A4F10EAFA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 01:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POXivUBPRDyA82rHS631b0TYfd/EzBq+3KLiuDwaS/6I3nM82OJ1gisM3P91WwOwM7AnUObcqmjW+5WkVPs9p2m84W5FSfgiTPzL0DI3+eofAD3ptoq9ystCTo3XJ0qPEzFptLSt9t3K30XasF4tZg8Uyolo2VR3LGc/9Kh9K+4Q6MvY+9diLNEBLkVF91+Tf2KA7rmBTWRtEktRyKc4pQYpj/MOfxi0d6adSLVyqjJkcC8H91CJUzUJ5uXgRSOm39P66N6C0TKWvbybLpswLQBdGX6/vp6bGl9bEgPDE6U2n7qt/91uCaSflqnz0WhWOAlQBEAFbCktATy+VlxHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBs3Np/VK/qmd2obEfB7HYgGcV5dU88ydfrNXkUBtIw=;
 b=IuF2vaod/IQuVbodBcEWdLbX27EbJHNNNUjib5Tg3oYzWEeZip7xCqv355BCGzX6RyWvZzvnEUodLzQj/45XtTX2dgRFlonEDhaEKeQQQRusk46ED2uoJuuLPMRMQZsQtJPr6TxGsERtAr565QpxkRNHQiIDb+5Bd+AHma/sGBf8F/ql1XiPCL5f4IVEaoEBF5oB0AUTATOF4IPrvmq2D3MXEKvRi2KJIea0n00vgMazOVda/wl3TSGuNM9r9y3mbB8tUNzGSGXtuNGSkEYiJD0jwug8vLifO99yG3FSgZ2XqugHu69bThweFli98HOmUyjtZh0kPKr8QGNn0UY4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBs3Np/VK/qmd2obEfB7HYgGcV5dU88ydfrNXkUBtIw=;
 b=ghIluB3SskciUGgwHNqXJSWvkCXQIEalcu84W+cQGiLQ5z6noZFmSwN8S7YV14cu8gAv6mDSxbMrzVekWTFZbTK1e4m5OB1/zYSEWlPhm9IsngFYARedrcL0UausAwjrg5VnBfwRpfCzEmJ6OMy5B1OzKCP1HLIKHv6oucogyIM=
Received: from BN6PR11CA0018.namprd11.prod.outlook.com (2603:10b6:405:2::28)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 01:37:54 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::36) by BN6PR11CA0018.outlook.office365.com
 (2603:10b6:405:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Fri, 14 Jan 2022 01:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 01:37:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:37:54 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:37:53 -0600
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 13 Jan 2022 19:37:49 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/13] drm/amd/display: DCEFCLK DS on CLK init
Date: Fri, 14 Jan 2022 09:36:52 +0800
Message-ID: <20220114013657.3119627-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114013657.3119627-1-Wayne.Lin@amd.com>
References: <20220114013657.3119627-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55360944-47f3-4385-541e-08d9d6fe7c58
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB417574455682563D1CA73A67FC549@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pI/dyo6tzIclqKv6MlPmB2gU+utW03tWPo2Ga+U8y48ZrXc+i5p+yh5Yuzyb5tJljpCqXWx1NwzTrRS0vfWwugK6kwK7PaDeB60L1fvPOVElXms+Bh1mxObIe5egkhWlE2glSKjEgxU4ed7KkVimRCGi/G8PZuWAWX8ACjxTG1WC0vSma+JByY1m943MO3cGLI7aCdAhawfUGuJCk16Vgi227qrGmOfAbWFS53Rg/3+VUBfGz6Bd/C1cdZlK0xcFyui4epXt4GgLVn5XypFpu2Z7SUR7XnXMdsNGNiKefqqRozjqHONLaG2VGjX2bZwxeo7DeD5wAczeupg0Wvg5rafVNFrSwptWAVpakS8QWaDSUZuC+BaWEV/6vde6m6fg8Yu0Y9eLSohZizYQ69B4j996+7SzfbKz/GdX8/e9taHr6/vHWPhiV+ZF2Iy+g8DUh01h7Nl+JsBO01kutFm+/FXm1UlW4T/25q4UnihYTqLlYkD+XUkxDmZU88edeZamuvRTNdA8OzaIRedJFQXFe1D3VsXJFCmGdM+LeNKLGRIo0mf8BtF1Sg0YRMebemOBZQ+2FRHZLq91rKA6Oq+dDPHLNS1mgLb1bR7pSQuZy2Sbmx2FzXDwqIfI1JPw0cVrCN3kh6zsdLU7lzaBGXuYlKDJKdRwJ1HXplIFTWuhknufXiHhqA1lXWQh+8gJdNYHdwuquElYCPrcuvBaG3Ivj21q1Ab28edrM67Z4cnehUQ+yxXpUFEzAM2UIDWRtmLu/XTyX5wJLWnJOt9WHVX+tTbjwXSNDfVVju6aelrSqPY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(186003)(26005)(54906003)(40460700001)(1076003)(8936002)(316002)(2906002)(83380400001)(82310400004)(86362001)(8676002)(7696005)(6916009)(70206006)(4326008)(5660300002)(36860700001)(508600001)(6666004)(336012)(47076005)(426003)(70586007)(2616005)(356005)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 01:37:54.5524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55360944-47f3-4385-541e-08d9d6fe7c58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: stylon.wang@amd.com, Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
On HG APU + dGPU scenario with no display to dGPU,
DS stays disabled due to no display present.
This problem can be worked around by DAL calling
DCEFCLK DS message to SMU on clk init.

[How]
Call DCEFCLK DS message to SMU on clk init.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Chris Park <Chris.Park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index f977f29907df..0602bde78e6c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -184,6 +184,7 @@ void dcn3_init_clocks(struct clk_mgr *clk_mgr_base)
 	dcn3_init_single_clock(clk_mgr, PPCLK_DCEFCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].dcfclk_mhz,
 			&num_levels);
+	dcn30_smu_set_min_deep_sleep_dcef_clk(clk_mgr, 0);
 
 	/* DTBCLK */
 	dcn3_init_single_clock(clk_mgr, PPCLK_DTBCLK,
-- 
2.25.1

