Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EE4FEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D9510E5EC;
	Wed, 18 Mar 2026 01:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oZblLL2f";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7074510E5EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:01:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uB+3KmOzOxO67alDaNVyUE+DjMrEN728SSXVsGZUl/9sdRff3RO7sAeuhPrbKdy90UJply8zgKQfnbFgajak/JgxNUgzpxQf2CaXgIHMraAzXgMfrtN6A6o6CxwTXmwhAt0Tvtt8Zg+MaLb2WG3r5nffMxFaRKxQiQ4xLtmsLm2VschjfMBMj1pGTiqJ2Xgyq9h/nUtMhxYuw0R4wHU8haAH4qK1ciiOek3sCR0d1WQYm4pzbxf3jPbyrU4SUbVgutLWcqL8xE1mS1duJ9JfzSFyg5xxcqyzNBbf3szpYVx6g4D+Xvzed/vUenHHmwlAWxbcGo/KgwFC+wPPJF1G7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYpgbSDWx9E5gK9qj9371cv78pm0AdfC6RPlKGwcs6w=;
 b=jTuava8u+FEs4JtJDLOsizHd6eG6zhB35mNB7YDpiQdm8aV/K4ygf1ug5t9DhS1OsFE7kLevix5NeNAJrgScTWWr2xot5a/g23X2E2cZk6WpcNNh8ImsnQ0kp2dFTO0ZaBQaN0L3f1Kg5x4YHBHbGbxuJxO3evAB3NldbuZv4rInxlISVsKVXaPlOVnMhC9F7ACMhmPTnQGYldmk47rG8isGR6BRAKto2yFk8ydm+CSHKzR1qaQXb1cUmoaXwzm+uiIbV7AHMvIsDjJkHtm3JJjePd6zX86o24Phc6QSZU8q9PUPCCCZHxqTAKQjlIvpSpoZvs6LtVMJswQ5eHxEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYpgbSDWx9E5gK9qj9371cv78pm0AdfC6RPlKGwcs6w=;
 b=oZblLL2fYMG20MJQ1xieEWCuIm0630SOaT15nQKdyRuJGFLI836egsA/TtK3k7FZvNvbhhdo4g9N12LrURl2CjhNi1pnI8YavjRQaqJU5MPukLxOcKZaZ2utLgaYgO5mYAslXeOHmqfpJgq118P9YUOSujsFgAKoPxMxLYfm7us=
Received: from SA0PR11CA0028.namprd11.prod.outlook.com (2603:10b6:806:d3::33)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:01:23 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::c) by SA0PR11CA0028.outlook.office365.com
 (2603:10b6:806:d3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 01:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:01:22 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:01:19 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 "Chuanyu Tseng" <Chuanyu.Tseng@amd.com>
Subject: [PATCH 06/31] drm/amd/display: move dcn42 bw_params init
Date: Wed, 18 Mar 2026 08:59:15 +0800
Message-ID: <20260318010224.513094-7-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e98b31a-6e9c-45f9-2cae-08de8489df94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 1EhMgkEn8ThK94lusNKCowV8HHkr8pdKDwYfvwrGVRm5QlTb/jEe34x8Ud7x6sXgp2pqoJBF1xwYIIS7o4y2I3UOfwmFDcT9wuVg/ASpH1GvDd+Ysnf7NPnlFGyPt4WwOuRYUmPsIZ24qq9jEkcdRu8hOgMyWNKhSW0ni4nZtPlPyiSEWoIQNU8vw7zncJaKDu5paGKKfcUGL5GkBQEUBa2hF90HWkGAjUNH7Xm32dMd7EIYwLQuwg7ZLafudWOd9zdL+01TFB+X0WmCm0U7YHip5wOQPeRl/Pyrl5twode6NTognIWlMOho9qwPgfD/ACPwNdCH1Y9wmtY2Otg8+zLyAAff7IeBGn4YEo/IZ5zqN3yeqwkKTxzTiCztGFx25Ix5lZzztLjWbKqABgMLwWkyJtSNmH/mj8kn/afWy73jhDKkPHDY/Fx7lLaONr/Vs4VmO7VnWmmgi20ONf/xa66MtDr5sglROryvUo58Wl+ke2fCOtcl5RzcA3rdaESNVgu+9/7RLxJu6jFVD7F/i/TY/q9D0mFBcDkY9MPJTclox5Cn/QQbKxySxbToiTl3+4OjcU5NnTW3taeiwlct48oChDFd0T81KNsINK0J8x7yxT5KxzMdTYOCLX0rJh+e5ylcKQose7Y/e8N5ub5+4lvU7HOMQLENGIoq+sGmF1YzfReJbE6UbL6bPHkj3KE9erGAe9x2B/Hku7azXAza39lC4cmWLrk80nsSlOPpV1Jc17KEwGrICwWEHdnzqsGy9ZXTXKOUV/ER9j+CMMamMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cQ/hNSOA1ogkU7+VcSPMSRewXWopuq/qEIFnE1nSKEpdUcBnmTTrUJKdx3AlkWap/jZk/rvHBRHCfnyeG8bbRdf/aZ02Y15BrKuqhztr3JcaiMqDRVKlmZSDZqsv5tmywBbOxpGmgW76aix4Msp9zp1ktiKV9Pi7ffEpnPWnA99ulKbZpO1M7p0nmqXUQ3PpjDBU3G8RlT2ynR2PqtL2Q1HKdzTmrfbCf/rcEoyXkJ0qwBE0vj/p8pBd4xtmUkcz6SsJ/HvR8QKS5rIMGC4ynzEn/XsHYzEHsiirixv8+NLQmhh6M8z9MD+xR6gAftD6VeKOGdcn86LPj6f6MnQpn4GKvXhflLnX7nqxVWHekVkw47yfdgYNR2mVWENmUVaH9lv88KkjAItbQuT3SePPNxTjGdAHqNi3elVjxB79TCEAZPkpkq48A/UeXu3sATJM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:01:22.9003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e98b31a-6e9c-45f9-2cae-08de8489df94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

Move it out of smu present block for cases where it isn't

Reviewed-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Chuanyu Tseng <Chuanyu.Tseng@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index df904b6fafe9..a0296d5f0102 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -1138,11 +1138,6 @@ void dcn42_clk_mgr_construct(
 			dcn42_bw_params.num_channels = ctx->dc_bios->integrated_info->ma_channel_number ? ctx->dc_bios->integrated_info->ma_channel_number : 1;
 			clk_mgr->base.base.dprefclk_khz = dcn42_smu_get_dprefclk(&clk_mgr->base);
 			clk_mgr->base.base.clks.ref_dtbclk_khz = dcn42_smu_get_dtbclk(&clk_mgr->base);
-
-			clk_mgr->base.base.bw_params = &dcn42_bw_params;
-
-			if (clk_mgr->base.smu_present)
-				dcn42_get_smu_clocks(&clk_mgr->base);
 		}
 		/* in case we don't get a value from the BIOS, use default */
 		if (clk_mgr->base.base.dentist_vco_freq_khz == 0)
@@ -1155,6 +1150,10 @@ void dcn42_clk_mgr_construct(
 	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
 
 	dcn42_read_ss_info_from_lut(&clk_mgr->base);
+
+	clk_mgr->base.base.bw_params = &dcn42_bw_params;
+	if (clk_mgr->base.smu_present)
+		dcn42_get_smu_clocks(&clk_mgr->base);
 }
 
 void dcn42_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int)
-- 
2.43.0

