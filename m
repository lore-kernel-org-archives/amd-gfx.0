Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B13C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5AF810E79D;
	Wed, 24 Apr 2024 08:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QCAZcZJs";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F1210E79D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFvG2/MEDUxpTxbA381mAxaZM0NSHvPRzFqj4tgp4wn030joCfO7mBHGloji0Oj7BeTC1sZ/soxsReiqmWMTjIFwPOAcVDXeH7/cG4xlB04B4PknAVqNuqU2IiJVhSKXGNOqJ+oUULNlkKJFux3K/b/S4FEn+xMNcL2380Wzx+gVQ/rylx5dRVeNhZVZ9+AiqTvdK4oTcpEXFRPV/Il8G5vfv7gO7UlxVmXH0jptponOZ9Zv2Mye/HNuBROMEA+Go5nwijgcHly9BQai2gG8ixVDfFohCzr0heKDTOnmrNJTawlB7AwKVsfPn0BfjOVgmKrvO0t/ocErfld5ZhXwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBa4yQF99UsKCnBTa9CzHvJboUHyT9sXpncEZilZVqM=;
 b=IKb60yjb+TUh/EVwyXXtIwyaFl+XismWjiKkkTPETc5bg16gz3UkOJEJmW/EZtZUR5H7t+fKJmczXjyElo0AYQ1OSUAZEAUpn60D7BrPDAjUZbXdZMT4NTNTmKsf2LFMA+BQA1lcKBeGIFBQWj5fqfOmG/gjjgNVcRlY1mw6gCmRWr2bGEyDPXlJCQIgF/dmcV97655Fli8yUclqGsdxn4mRANOWieIMgaa0FB2BtcivmQ2XbVWYAMG0E+IRZliASB8jb0Cqv579CgkxzZ7e4BbJmOZIZNvdLaqhgTsafMOCNIPnPKu89icxKMYInDT8aCy9gWaYMJ+/lmsDjkBM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBa4yQF99UsKCnBTa9CzHvJboUHyT9sXpncEZilZVqM=;
 b=QCAZcZJsenGp//fnuz1vI6QA0IDDxVAhuDlRNBSKJhm2YJsiPXzR27TWLMcQf2z9M58mkAjMnSlssjmgYiqJHUWS8SLrFl+KuXnhSzTo1xOfPA/067lsnEQs/iBqg/C+mC7rg/oeeary0AxuYUcYoykxMGBjplrsvTc4UAph8iI=
Received: from BN0PR07CA0009.namprd07.prod.outlook.com (2603:10b6:408:141::8)
 by SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:52:40 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:141:cafe::84) by BN0PR07CA0009.outlook.office365.com
 (2603:10b6:408:141::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:52:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:36 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:52:32 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Leo Ma <hanghong.ma@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 24/46] drm/amd/display: Fix DC mode screen flickering on DCN321
Date: Wed, 24 Apr 2024 16:49:09 +0800
Message-ID: <20240424084931.2656128-25-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 5930d5b6-7911-4e63-5746-08dc643be5dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yGASChrBKh45tiijxQAk/CwuttUPwe9X3hgw9/d/SFuokACN/rFLJ+5WfYMp?=
 =?us-ascii?Q?q+AMRAyMK0CuydUEVw8mFebUYgd1mypte7FHADK/ppUz1aSOReNE5WlrxW5H?=
 =?us-ascii?Q?ZfH320UKRPVbwkbSk4UY+j+ptJDOkTD35Pu6dwdnFMzxO3q+eMoET8Y7OgQi?=
 =?us-ascii?Q?1CfI+DjywKoILtSZhSOystKaMhkXKMYBa2eiOpOj5Iy9kMz/YFs9Vx+bGvsY?=
 =?us-ascii?Q?Qxoc70i8ya7SkOhCrouqCvsyP8yckOaQig8/tjA+0/ikcls5RH35wNZpWVgs?=
 =?us-ascii?Q?viuTrq7fo131p3+kPBb77MAcE3iv3/xzzhTzpLz4o3O1F8WFSoM8N7dGrWs0?=
 =?us-ascii?Q?WqcibrKYITFE0P3IqWZ4G2Yi9QPc8Et/ivWKbtV5dpejG103jj91CPA1WqVH?=
 =?us-ascii?Q?YFQGgTtLunxPLmxgJk0T1n5UUjYMGojxQ5E8nZxTVu/J4IaVe0aysmaZdxeI?=
 =?us-ascii?Q?TRaG4VbXSOr4BEdSYgiW9FDmcUKuBH6BLdkqcnc48ZczMTf2zCD/b+67tlZA?=
 =?us-ascii?Q?UCIL5zrvnx6IaIRK6R937Gem8ijPJnK9RC6OqBfZ0kBJb/TZp+FnJXf60yIp?=
 =?us-ascii?Q?NC6V9Rv+ZCzzmLp+PjlBqzujvyhR4FaTRbkjStdW9tPXwRbI0FkGNldLQDOF?=
 =?us-ascii?Q?LQJv2z5CVgfulIHIeCS74WloIC4MeMpNdMfE0qodG+yRpjglV8TZr3u/FY3S?=
 =?us-ascii?Q?mRWbps/whbkEjKvNSsZcLfqW4I/pmMJu4J3CG3XJiwrS/KXGlt8F2zdh0HnF?=
 =?us-ascii?Q?NguHnJw87m7aDNegf1cLgx62BWai111U2O5NNDSV24WMRpg7HOs65aw/9R4m?=
 =?us-ascii?Q?8vOw9r/04aIa8Orpx2xmGdqLprkQVmh0GxzjTaRWecuK6YNuvxyKPNegQzAG?=
 =?us-ascii?Q?EG8ffXLsajFwGk89QEAmQZCz3kw5OyI0Ce+drdryH1XqaCOO65rx6E80J14w?=
 =?us-ascii?Q?8mZHAiaR3mgjGkoA4RB+IO8dKrCkA/9gFT6m5bleGrTIHkcH3WO/l7V7Z3Ta?=
 =?us-ascii?Q?tkqAs9zHAOPnJWAqD7wqaDTj/bmTISUShgl/kTY9UOjyqsABKa6Yg3GywglO?=
 =?us-ascii?Q?YxnX29rO4GoCXhmbRgk6x2KTHuGt/dTHmJ4Ib+Y8EqAL3AEpYptGBN4/1sB2?=
 =?us-ascii?Q?9GJIInGwag0e0XhctUoNfvXwoYzNG3iDPTRfKMwuIKB1g8hL7nbQNud9nuwL?=
 =?us-ascii?Q?xdR4CCFKNR5mQIq4FqTBWD9Xa2Zjx2E5p2ULKtVPRyXZjXEc3qOKGTrXrHlN?=
 =?us-ascii?Q?kJSbc1V4/nqHAukhLBQpAWTKa5C+yQVfUQxj6RuoVww/KlJYyc/0+cFbHzG/?=
 =?us-ascii?Q?tiimA0Z9Esw7w+pDhdqU2Ewikz0dNpOSrueliPY5dzZoIUmmtUTVnf9xPGF+?=
 =?us-ascii?Q?RAgk/IxmDX2K+ALJu3Jsuv21bEkw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:52:40.1569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5930d5b6-7911-4e63-5746-08dc643be5dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184
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

From: Leo Ma <hanghong.ma@amd.com>

[Why && How]
Screen flickering saw on 4K@60 eDP with high refresh rate external
monitor when booting up in DC mode. DC Mode Capping is disabled
which caused wrong UCLK being used.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index b9e1f3e0b31d..ff5fdc7b1198 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -712,8 +712,12 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 					 * since we calculate mode support based on softmax being the max UCLK
 					 * frequency.
 					 */
-					dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-							dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
+					if (dc->debug.disable_dc_mode_overwrite) {
+						dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
+						dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
+					} else
+						dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
+								dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
 				} else {
 					dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, dc->clk_mgr->bw_params->max_memclk_mhz);
 				}
@@ -746,8 +750,13 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		/* set UCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
 		if (clk_mgr_base->clks.p_state_change_support &&
 				(update_uclk || !clk_mgr_base->clks.prev_p_state_change_support) &&
-				!dc->work_arounds.clock_update_disable_mask.uclk)
+				!dc->work_arounds.clock_update_disable_mask.uclk) {
+			if (dc->clk_mgr->dc_mode_softmax_enabled && dc->debug.disable_dc_mode_overwrite)
+				dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK,
+						max((int)dc->clk_mgr->bw_params->dc_mode_softmax_memclk, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz)));
+
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
+		}
 
 		if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
 				clk_mgr_base->clks.num_ways > new_clocks->num_ways) {
-- 
2.37.3

