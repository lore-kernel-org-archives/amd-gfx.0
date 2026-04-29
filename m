Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E51FF8875
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 01:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661E710E3C0;
	Wed, 29 Apr 2026 01:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2FFfwmrn";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38FD010E3C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 01:54:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqtwsYj0V3BgdunwgtsSkpAlkadLhhQmGO3Ip7G7iY06EvsHvmXdVKuysz0IhclXuYglISxmCbabyAIMNS+zUjLZw37lx4ZfGZU5aQjQv4et6DyXioNELwsBJ0ygzJQwjyeLKg4YmNOMIijQhAQYA6mdR7kFFga+SfCou8zcSr2piwqOY/jwbniRoz4wB80EgjaPUpobg1N+v7kWIon6Bx/646hC+cu6tv0SsejlnPEYEjgMogg9hlhQHIS0Rnjv33RNr03fjvhBErqRp2uw9PUTj2g+AoOPz+GUNWc4NXDzw1t+w83ls/HVoC78AGcwxCmOPNhNAbqiVBReBw25XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+RERDoAC7kWaMe3lXXtrBfu/IkXKbP29VXfpztKtbk=;
 b=xMNKsZ3ZlG/Nw/99WiqfjW9PkvBsebU9o9/421yMKfTfzdu5urj9A4C8HrnLeRx5udpVVexq1TGvGWqH9iwm2PvMM41osm5hnfLmXzcWfpkDVhnVnUQ5ArBAlMaEO6gXN+3DJp3C34f98AHnMg1LWUWj4UfS7RBEQ+AeP5S8RbRIjs5wadv9avl1Umua0/TDhOOTwNzXTT47605lHlZs+okMBiEjK+Z8JedXXVru0yVlWklOKmHZp5KAeQzJVRB3sUj6WzbkSgdE6aL1Bo8Md2SKJc3ChAR/PSV4xZ872LlvBtS5GE4h9tCtafC8A8kgwyqssKdVPmsoEIk7PgpyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+RERDoAC7kWaMe3lXXtrBfu/IkXKbP29VXfpztKtbk=;
 b=2FFfwmrn1JHDxkA1zCu5mkMGZlQlqRC+Qtvh5LJbxuUegJ4s1qMUQla++BMCTFlqrVKwGH8k9LY1fGaC/QKPM8M08pSTsh5rnKft3yLAqsNLNtHoKuAi3ZVcLt0y4Jyhsfey8y2ZbUpVnHze7qAKLMm0xlEkvtyvkBuTD2g0AtI=
Received: from IA1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::10)
 by SJ5PPF0529573EF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::987) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 01:54:05 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:208:461:cafe::8c) by IA1P220CA0004.outlook.office365.com
 (2603:10b6:208:461::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 01:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 01:54:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 20:54:03 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Tue, 28 Apr 2026 20:53:55 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Austin Zheng <austin.zheng@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 14/17] drm/amd/display: fix buffer overruns warnings
Date: Wed, 29 Apr 2026 09:19:23 +0800
Message-ID: <20260429012055.2065869-15-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429012055.2065869-1-PingLei.Lin@amd.com>
References: <20260429012055.2065869-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|SJ5PPF0529573EF:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f5147d-e801-45e0-2e0a-08dea592315a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: rsAry8apVN2R52Lg8KFHHN5Qdos3VmUtoyK+JapJ7kqi5YqTsDYiE3b4w7UbKrkXQebS+rBNq5lMYCinSBEM8a7DS7FNqmc2gXq02CS6d1ktwcHxig0roXYF2SlflAbls/nTiaBYN1mhEeO04aevYycGSETw3v1Ekk+VmzY/uLoMQI41kUhk5rJLZVZcBzeOQ44pNn/NRaJJcR16DKRsKtEGHhjXUudIkhkuqpK1zVFaD3l2p9ehN+bZzwLoGTxNDseGcXGjtPgOjBJT/XnwHLrqoYSvoEfotpzHRoDVRUCmxbd7/vxwX2XIHciP+Li+f7mn0msCCNsZHrwrgWeUJa9cLUy4mKstaMMsIQW1o/fZ8686vy9gHF8Mxsv3pY4DiMrmNB1MIv6f83dRcL3wcmNb5CTLY7965Iz/xsebj+jDVZG02luG+hmZ6YE0wn8vZJ2ezej8TXI9xr59K8zl9gDuMkZPDLsqbf0YoHvq6LYCdytdrFho/HmFomGTUeEDF2ReREljtBu+A4Rs8Tuz1/8yQ+c5l0UisNFWxJgNnEY/6H1oWu/dJ/nbppqtJ09bhI32FN/QJSsRgmSwK5Pmkn556IoN5aCZm+rhwXpPqohf5zIXyxqjiCbdguRXrEz+LNPEPqFRgjcPaxeIbfDcRm6I4jXS8axwiF/bIAEDNMrd3rsCuIBr+c1oC0CaspXkpWvCKkh/qBxOq+6tLxW5uIitukhsF30HRXX1L8KvGNSD3wmLhFXhlo/32idmt54E7doTmDPthB0PoSHDmRK2sQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2jt5M4t8ig7svHiQmknacc1wooZdAEYPvYy/55EH57oqMFPLLA11w8GEPeg/4vWRdzcwSN5fOv6QqIfy5P7o1iS+xp0liJofAW4mI69EInMzUNT5X5n5iPylZqdxH5K6lyYqMkNLXCNK+VuTq9madPSFX3VpHSZCmaw+alkCtsth3nyG+3gF5aYB5dkbgdIYNqtZshvE0tlIB6soR2LJqkJhxL9j7pPjOpnKsY9uELsdsEgZBS8+iRsuzU83DjFpsxUEmPQn6K1COe4ityIroiAy/zX1gK9y9hmzP0h5/5Z7927llwHY+DScE2kCPtJo1W4gKX+sOh8JFBGDmGvhGS7mfnPkDfo2lGBnYN2xUp3Dp35hUP1q8D23ULngv/XTSXQ7/yLfmW+Gmh+tDw3uuP/jpJeh92B7I6K/0WdRxRJVf+9N3rRC1f0uLJeL0Dg9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:54:04.4548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f5147d-e801-45e0-2e0a-08dea592315a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0529573EF
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why & How]
Fixes a warning by adding bounds checks and index validation in dml2_0
sources to address static analysis warnings. Ensures safe array access and
prevents out-of-bounds reads by validating indices before use, improving
robustness and reliability in the affected files.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c
index 3eaeff39ee79..ef8b75fed9a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c
@@ -22,7 +22,7 @@ static bool build_min_clk_table_coarse_grained(const struct dml2_soc_bb *soc_bb,
 			min_table->dram_bw_table.entries[i].pre_derate_dram_bw_kbps =
 					uclk_to_dram_bw_kbps(soc_bb->clk_table.uclk.clk_values_khz[i], &soc_bb->clk_table.dram_config, soc_bb->clk_table.wck_ratio.clk_values_khz[i]);
 			min_table->dram_bw_table.entries[i].min_uclk_khz = soc_bb->clk_table.uclk.clk_values_khz[i];
-		} else {
+		} else if (soc_bb->clk_table.uclk.num_clk_values > 0) {
 			min_table->dram_bw_table.entries[i].pre_derate_dram_bw_kbps = min_table->dram_bw_table.entries[soc_bb->clk_table.uclk.num_clk_values - 1].pre_derate_dram_bw_kbps;
 			min_table->dram_bw_table.entries[i].min_uclk_khz = soc_bb->clk_table.uclk.clk_values_khz[soc_bb->clk_table.uclk.num_clk_values - 1];
 		}
-- 
2.43.0

