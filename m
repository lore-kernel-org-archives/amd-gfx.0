Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAB2C83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FAF010E960;
	Thu, 10 Jul 2025 21:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bgNegnYa";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FFD710E960
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNrw8bhF+VrcIkQphYEW//RDbY+LMNwpQU08DRCg2VAUqSd6nC8fKttbjWejwgj6ZVYsteT9YYVxIhpW4VugZW0qamkUoxaSNX885X9ghY4AII9T3nVZNafFhp/gdh10yw5LipsZW22QfbuMK/euiHjSaQZs1df1S5saUPys1zsi2BAUNCpTSAzlLxOJ0Xg7D+tjNrOX1zInxVB69KQXGf6i57sAemrfHkAHXbr/P9qs1emquKF6HU495yY2upyaHZz+UkHLcwpbGCSY7e5uYwDlhLR3hMv+ZIn6+BIN4WlLppmB28un4SxmM9a8fgpL/zmLEKN2fk6a4E3Cl9J0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMYvfb6+iLKIuGSRWvWoboLKLsfC2QBVLRcegwBK5Ng=;
 b=AcDzUcXb5x38xT2g3FqBrVNcMHM+XKyauavTgfVBWKL2iZdm3C6EBUP4048Ksudpmu2xgwQJPdgoApcegSifMjoMDnI5Htea0/ivXjZQX3LI9h8u7+XvwwuQmargnalcHSkYHiG8iaU6vLWrmgYiWysQP7sa7/zAVCwL3MJkEzxtVNpNPvnapJatgCp5Gnk3LWY6PdhMgpa27/X6nugA4orpEdAu93hATWHZUa8Q9o53CyPUjh/GE1MNl9BVWSfb0KxFMgp03JFaLqmPmrKQ5lrOodi8hrIg5coZ0izvRH8U+wZUSWfdrQ0MhavUYufovn+a5ucxZn9HlY6zTVs3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMYvfb6+iLKIuGSRWvWoboLKLsfC2QBVLRcegwBK5Ng=;
 b=bgNegnYafsAGxHSnzgTTOu5V8SamsTFDPxgC4/DTij4JzsKfv7OgNvHqumv97Vk4hMrnKvJnFa91rffK0AnWeFtkQhP0IeVy9X4C4RqyEtl2shjWjiXkzVQsRhuwG2/hpYMqbnkZGZm88Rubic1kvcxh2l1Vp8zis4nWN7CtbVA=
Received: from BY3PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:39b::12)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 10 Jul
 2025 21:30:43 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::c5) by BY3PR05CA0037.outlook.office365.com
 (2603:10b6:a03:39b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.6 via Frontend Transport; Thu,
 10 Jul 2025 21:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:30:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:30:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:30:41 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:30:41 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 03/18] drm/amd/display: Refactor DSC cap calculations
Date: Thu, 10 Jul 2025 17:25:36 -0400
Message-ID: <20250710212941.630259-4-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c797f01-de6b-474a-769c-08ddbff90692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RdSFZBeaHHBcsHCeR/gDWfzqsI6s3dOQQZFvLNUYsaWa5rehmu+z15ewBBaP?=
 =?us-ascii?Q?oogjv9AwMhGn+mMvCCcZPrt0kNjChdZOXVMPSTA0zNM9/kJaD0i3VzSWgzUD?=
 =?us-ascii?Q?5bjoFubvPb2GlgPQgDc2ttS55VrUCeB8oR9DKFnU6zglGnIoe9Fb20pq1mzV?=
 =?us-ascii?Q?TBvkYGvJziPE6gwhSAALzLGX5iMBUWBLUxddf5pFPAhaTGo6aUj1xxHXFxvc?=
 =?us-ascii?Q?9tf3Mr/QYX/U13rKfmYl5JSDPMbLSrA4Lmrt1wXsYhtuC8+AcTw23reZ7JHp?=
 =?us-ascii?Q?jACSM0U/QvGbb9n5fkvWzyGH212oT7Svi+5jz5KCJPkWQUoBQOLq16R/1l73?=
 =?us-ascii?Q?Rp5z4egA0Dh3t69N6OjpexIRdyU++2+Xpdqr2YTyjLbfwaVgeVi+a2hAAeSj?=
 =?us-ascii?Q?NKoICrr1gI+YPmj9zdRwQVS2+oNV9pmB8dr56WjONUXn6XB2+VGiTiYp9FF9?=
 =?us-ascii?Q?6oxil8JV1f8/xEzcsn16yRIB/sz0RuvGXt5fC3Knczu2OLTvxZIFPYnZvdWd?=
 =?us-ascii?Q?Epinkrbj9Zg2sW9eymBVaEQPYp325q7zC2knx9DWj45qSKqTBr5yyngme2HS?=
 =?us-ascii?Q?rnupjDahaL/OSY71cRjHxsv4fjyaKBG9/l318lo9Fd9PdLldoVqnivvDOwg8?=
 =?us-ascii?Q?nGUChLo4OQk50LCzLMJBT9gP2B8MTjfOrrNIIlu5yCSDNd7f7rFEMsREC/Up?=
 =?us-ascii?Q?Bb4UTg0mo+GaoPUOIZ/aMmQUkpM1ebso0BewvnIDPOX8RK1JuS2GLxkKEo9P?=
 =?us-ascii?Q?C0Ab5wHMnlkQdFdmsHCBTff2nXB395t2nzQw3pl82MDbdlgsw79Dp3WQkqrG?=
 =?us-ascii?Q?6I5jhSTWAhj2jQ50CmsGsuzFmBj91j8Cnk1iUtNsFkeQRCNYmJF3rbCem8u1?=
 =?us-ascii?Q?iMXU/ItI70DhNnWl5Oa3ay6GoJuNr7W7qH6nB6FZ5s4hI2bqv3lTabZCOHhi?=
 =?us-ascii?Q?pqi4B5seQaUCdLSvRYEiGu8mFL4b/C92GHDBUJk8NeKKyLgIY0POJNptmuyH?=
 =?us-ascii?Q?eWDT28e1uVbkqFxdb315HyQiA9kkOQsGWQ7yHfdIAmAiWiK7lfUiAACghPl7?=
 =?us-ascii?Q?8y2FNpr+sVPO+e+FCGCCgye1Z4gZQKw4mW3J48n8FJps1NacuhogfU8rtquB?=
 =?us-ascii?Q?B89TeFc1ZWQ57uEYeVm/1gVRks9GdrTB2HKRwn2y45KpzmGe8ADY70JdLcVX?=
 =?us-ascii?Q?8VF5Qvenu4sZPy3IsQGQHUvtnx/9H4n2Tx84nV9FxZ2Av6JBJCRoEnohtFRm?=
 =?us-ascii?Q?VAFTKJXl0OQeLtAZm6eZxD5u9hM2686gLRekDu1aG3AA5jmN+se0EXNFlCHt?=
 =?us-ascii?Q?paeinwFzsWzhhaNDu1jJDaHwsw17ti8rpa/FkyKWCQzYh8XoIavCVFVmCDZF?=
 =?us-ascii?Q?Xxb54vO7uHu3ycJGYV3dQx0y2gWPXOP1xC6Uc91lan12QETCBy3jOogNqrqb?=
 =?us-ascii?Q?xC62T5qM3Aqea7tDZH6mMFicLpKYxcosHCuQs+Q/vhTxcb86pFs+ZWXUjjN9?=
 =?us-ascii?Q?/6XlAAlxUbXvSJHqQuLNmC6rAUcsDdcs4OWt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:30:43.3199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c797f01-de6b-474a-769c-08ddbff90692
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY]
DSC block level should only be responsible for reporting single DSC
instance capabilities. Factoring in ODM combine requirements should be
handled in dc_dsc.c. Both components should acquire clocks from clk_mgr
to determine throughput capabilities instead of relying on hard coded
values as these can differ by SoC and SKU.

[HOW]
1) Add dsc_get_single_enc_caps to acquire single DSC instance
    capabilities (replacing dsc_get_enc_caps), factoring in DSCCLK
2) add build_dsc_enc_caps to combine single DSC instance capabilities
3) account for max pixel rate per pipe (DISPCLK) when calculating
    minimum slice count

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  30 +++
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |   2 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 192 +++++++++++++++---
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |  24 +--
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.h    |   1 -
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  12 ++
 .../dc/resource/dcn20/dcn20_resource.c        |   2 +
 .../dc/resource/dcn201/dcn201_resource.c      |   2 +
 .../dc/resource/dcn21/dcn21_resource.c        |   2 +
 .../dc/resource/dcn30/dcn30_resource.c        |   2 +
 .../dc/resource/dcn301/dcn301_resource.c      |   2 +
 .../dc/resource/dcn302/dcn302_resource.c      |   2 +
 .../dc/resource/dcn303/dcn303_resource.c      |   2 +
 .../dc/resource/dcn31/dcn31_resource.c        |   2 +
 .../dc/resource/dcn314/dcn314_resource.c      |   2 +
 .../dc/resource/dcn315/dcn315_resource.c      |   2 +
 .../dc/resource/dcn316/dcn316_resource.c      |   2 +
 .../dc/resource/dcn32/dcn32_resource.c        |   2 +
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +
 .../dc/resource/dcn35/dcn35_resource.c        |   2 +
 .../dc/resource/dcn351/dcn351_resource.c      |   2 +
 .../dc/resource/dcn36/dcn36_resource.c        |   2 +
 .../dc/resource/dcn401/dcn401_resource.c      |   2 +
 24 files changed, 253 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 514a5efda102..724484573a2a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -1500,6 +1500,35 @@ static int dcn401_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 	return 0;
 }
 
+unsigned int dcn401_get_max_clock_khz(struct clk_mgr *clk_mgr_base, enum clk_type clk_type)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	unsigned int num_clk_levels;
+
+	switch (clk_type) {
+	case CLK_TYPE_DISPCLK:
+		num_clk_levels = clk_mgr->base.bw_params->clk_table.num_entries_per_clk.num_dispclk_levels;
+		return dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DISPCLK) ?
+				clk_mgr->base.bw_params->clk_table.entries[num_clk_levels - 1].dispclk_mhz * 1000 :
+				clk_mgr->base.boot_snapshot.dispclk;
+	case CLK_TYPE_DPPCLK:
+		num_clk_levels = clk_mgr->base.bw_params->clk_table.num_entries_per_clk.num_dppclk_levels;
+		return dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DPPCLK) ?
+				clk_mgr->base.bw_params->clk_table.entries[num_clk_levels - 1].dppclk_mhz * 1000 :
+				clk_mgr->base.boot_snapshot.dppclk;
+	case CLK_TYPE_DSCCLK:
+		num_clk_levels = clk_mgr->base.bw_params->clk_table.num_entries_per_clk.num_dispclk_levels;
+		return dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DISPCLK) ?
+				clk_mgr->base.bw_params->clk_table.entries[num_clk_levels - 1].dispclk_mhz * 1000 / 3 :
+				clk_mgr->base.boot_snapshot.dispclk / 3;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static struct clk_mgr_funcs dcn401_funcs = {
 		.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 		.get_dtb_ref_clk_frequency = dcn401_get_dtb_ref_freq_khz,
@@ -1516,6 +1545,7 @@ static struct clk_mgr_funcs dcn401_funcs = {
 		.get_hard_min_memclk = dcn401_get_hard_min_memclk,
 		.get_hard_min_fclk = dcn401_get_hard_min_fclk,
 		.is_dc_mode_present = dcn401_is_dc_mode_present,
+		.get_max_clock_khz = dcn401_get_max_clock_khz,
 };
 
 struct clk_mgr_internal *dcn401_clk_mgr_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
index 616e964df96d..97a1ce1e8a9e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
@@ -112,4 +112,6 @@ struct clk_mgr_internal *dcn401_clk_mgr_construct(struct dc_context *ctx,
 
 void dcn401_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr);
 
+unsigned int dcn401_get_max_clock_khz(struct clk_mgr *clk_mgr_base, enum clk_type clk_type);
+
 #endif /* __DCN401_CLK_MGR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6825b8a9af59..a160671d2a01 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -348,6 +348,8 @@ struct dc_caps {
 	struct dc_scl_caps scl_caps;
 	uint8_t num_of_host_routers;
 	uint8_t num_of_dpias_per_host_router;
+	/* limit of the ODM only, could be limited by other factors (like pipe count)*/
+	uint8_t max_odm_combine_factor;
 };
 
 struct dc_bug_wa {
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 11535922b5ff..a454d16e6586 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -30,6 +30,9 @@
 #include "rc_calc.h"
 #include "fixed31_32.h"
 
+#include "clk_mgr.h"
+#include "resource.h"
+
 #define DC_LOGGER \
 	dsc->ctx->logger
 
@@ -149,6 +152,11 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
 }
 
 /* Forward Declerations */
+static unsigned int get_min_slice_count_for_odm(
+		const struct display_stream_compressor *dsc,
+		const struct dsc_enc_caps *dsc_enc_caps,
+		const struct dc_crtc_timing *timing);
+
 static bool decide_dsc_bandwidth_range(
 		const uint32_t min_bpp_x16,
 		const uint32_t max_bpp_x16,
@@ -183,6 +191,7 @@ static bool setup_dsc_config(
 		const struct dc_crtc_timing *timing,
 		const struct dc_dsc_config_options *options,
 		const enum dc_link_encoding_format link_encoding,
+		int min_slice_count,
 		struct dc_dsc_config *dsc_cfg);
 
 static bool dsc_buff_block_size_from_dpcd(int dpcd_buff_block_size, int *buff_block_size)
@@ -442,7 +451,6 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
 	return true;
 }
 
-
 /* If DSC is possbile, get DSC bandwidth range based on [min_bpp, max_bpp] target bitrate range and
  * timing's pixel clock and uncompressed bandwidth.
  * If DSC is not possible, leave '*range' untouched.
@@ -458,6 +466,7 @@ bool dc_dsc_compute_bandwidth_range(
 		struct dc_dsc_bw_range *range)
 {
 	bool is_dsc_possible = false;
+	unsigned int min_slice_count;
 	struct dsc_enc_caps dsc_enc_caps;
 	struct dsc_enc_caps dsc_common_caps;
 	struct dc_dsc_config config = {0};
@@ -469,12 +478,14 @@ bool dc_dsc_compute_bandwidth_range(
 
 	get_dsc_enc_caps(dsc, &dsc_enc_caps, timing->pix_clk_100hz);
 
+	min_slice_count = get_min_slice_count_for_odm(dsc, &dsc_enc_caps, timing);
+
 	is_dsc_possible = intersect_dsc_caps(dsc_sink_caps, &dsc_enc_caps,
 			timing->pixel_encoding, &dsc_common_caps);
 
 	if (is_dsc_possible)
 		is_dsc_possible = setup_dsc_config(dsc_sink_caps, &dsc_enc_caps, 0, timing,
-				&options, link_encoding, &config);
+				&options, link_encoding, min_slice_count, &config);
 
 	if (is_dsc_possible)
 		is_dsc_possible = decide_dsc_bandwidth_range(min_bpp_x16, max_bpp_x16,
@@ -525,20 +536,152 @@ void dc_dsc_dump_decoder_caps(const struct display_stream_compressor *dsc,
 	DC_LOG_DSC("\tis_dp %d", dsc_sink_caps->is_dp);
 }
 
+
+static void build_dsc_enc_combined_slice_caps(
+		const struct dsc_enc_caps *single_dsc_enc_caps,
+		struct dsc_enc_caps *dsc_enc_caps,
+		unsigned int max_odm_combine_factor)
+{
+	/* 1-16 slice configurations, single DSC */
+	dsc_enc_caps->slice_caps.raw |= single_dsc_enc_caps->slice_caps.raw;
+
+	/* 2x DSC's */
+	if (max_odm_combine_factor >= 2) {
+		/* 1 + 1 */
+		dsc_enc_caps->slice_caps.bits.NUM_SLICES_2 |= single_dsc_enc_caps->slice_caps.bits.NUM_SLICES_1;
+
+		/* 2 + 2 */
+		dsc_enc_caps->slice_caps.bits.NUM_SLICES_4 |= single_dsc_enc_caps->slice_caps.bits.NUM_SLICES_2;
+
+		/* 4 + 4 */
+		dsc_enc_caps->slice_caps.bits.NUM_SLICES_8 |= single_dsc_enc_caps->slice_caps.bits.NUM_SLICES_4;
+
+		/* 8 + 8 */
+		dsc_enc_caps->slice_caps.bits.NUM_SLICES_16 |= single_dsc_enc_caps->slice_caps.bits.NUM_SLICES_8;
+	}
+
+	/* 3x DSC's */
+	if (max_odm_combine_factor >= 3) {
+		/* 4 + 4 + 4 */
+		dsc_enc_caps->slice_caps.bits.NUM_SLICES_12 |= single_dsc_enc_caps->slice_caps.bits.NUM_SLICES_4;
+	}
+
+	/* 4x DSC's */
+	if (max_odm_combine_factor >= 4) {
+		/* 1 + 1 + 1 + 1 */
+		dsc_enc_caps->slice_caps.bits.NUM_SLICES_4 |= single_dsc_enc_caps->slice_caps.bits.NUM_SLICES_1;
+
+		/* 2 + 2 + 2 + 2 */
+		dsc_enc_caps->slice_caps.bits.NUM_SLICES_8 |= single_dsc_enc_caps->slice_caps.bits.NUM_SLICES_2;
+
+		/* 3 + 3 + 3 + 3 */
+		dsc_enc_caps->slice_caps.bits.NUM_SLICES_12 |= single_dsc_enc_caps->slice_caps.bits.NUM_SLICES_3;
+
+		/* 4 + 4 + 4 + 4 */
+		dsc_enc_caps->slice_caps.bits.NUM_SLICES_16 |= single_dsc_enc_caps->slice_caps.bits.NUM_SLICES_4;
+	}
+}
+
+static void build_dsc_enc_caps(
+		const struct display_stream_compressor *dsc,
+		struct dsc_enc_caps *dsc_enc_caps)
+{
+	unsigned int max_dscclk_khz;
+	unsigned int num_dsc;
+	unsigned int max_odm_combine_factor;
+	struct dsc_enc_caps single_dsc_enc_caps;
+
+	struct dc *dc;
+
+	memset(&single_dsc_enc_caps, 0, sizeof(struct dsc_enc_caps));
+
+	if (!dsc || !dsc->ctx || !dsc->ctx->dc || !dsc->funcs->dsc_get_single_enc_caps)
+		return;
+
+	dc = dsc->ctx->dc;
+
+	if (!dc->clk_mgr || !dc->clk_mgr->funcs->get_max_clock_khz || !dc->res_pool)
+		return;
+
+	/* get max DSCCLK from clk_mgr */
+	max_dscclk_khz = dc->clk_mgr->funcs->get_max_clock_khz(dc->clk_mgr, CLK_TYPE_DSCCLK);
+
+	dsc->funcs->dsc_get_single_enc_caps(&single_dsc_enc_caps, max_dscclk_khz);
+
+	/* global capabilities */
+	dsc_enc_caps->dsc_version = single_dsc_enc_caps.dsc_version;
+	dsc_enc_caps->lb_bit_depth = single_dsc_enc_caps.lb_bit_depth;
+	dsc_enc_caps->is_block_pred_supported = single_dsc_enc_caps.is_block_pred_supported;
+	dsc_enc_caps->max_slice_width = single_dsc_enc_caps.max_slice_width;
+	dsc_enc_caps->bpp_increment_div = single_dsc_enc_caps.bpp_increment_div;
+	dsc_enc_caps->color_formats.raw = single_dsc_enc_caps.color_formats.raw;
+	dsc_enc_caps->color_depth.raw = single_dsc_enc_caps.color_depth.raw;
+
+	/* expand per DSC capabilities to global */
+	max_odm_combine_factor = dc->caps.max_odm_combine_factor;
+	num_dsc = dc->res_pool->res_cap->num_dsc;
+	max_odm_combine_factor = min(max_odm_combine_factor, num_dsc);
+	dsc_enc_caps->max_total_throughput_mps =
+			single_dsc_enc_caps.max_total_throughput_mps *
+			max_odm_combine_factor;
+
+	/* check slice counts possible for with ODM combine */
+	build_dsc_enc_combined_slice_caps(&single_dsc_enc_caps, dsc_enc_caps, max_odm_combine_factor);
+}
+
+static inline uint32_t dsc_div_by_10_round_up(uint32_t value)
+{
+	return (value + 9) / 10;
+}
+
+static unsigned int get_min_slice_count_for_odm(
+		const struct display_stream_compressor *dsc,
+		const struct dsc_enc_caps *dsc_enc_caps,
+		const struct dc_crtc_timing *timing)
+{
+	unsigned int max_dispclk_khz;
+
+	/* get max pixel rate and combine caps */
+	max_dispclk_khz = dsc_enc_caps->max_total_throughput_mps * 1000;
+	if (dsc && dsc->ctx->dc) {
+		if (dsc->ctx->dc->clk_mgr &&
+			dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz) {
+			/* dispclk is available */
+			max_dispclk_khz = dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz(dsc->ctx->dc->clk_mgr, CLK_TYPE_DISPCLK);
+		}
+	}
+
+	/* consider minimum odm slices required due to
+	 * 1) display pipe throughput (dispclk)
+	 * 2) max image width per slice
+	 */
+	return dc_fixpt_ceil(dc_fixpt_max(
+			dc_fixpt_div_int(dc_fixpt_from_int(dsc_div_by_10_round_up(timing->pix_clk_100hz)),
+			max_dispclk_khz), // throughput
+			dc_fixpt_div_int(dc_fixpt_from_int(timing->h_addressable + timing->h_border_left + timing->h_border_right),
+			dsc_enc_caps->max_slice_width))); // slice width
+}
+
 static void get_dsc_enc_caps(
 		const struct display_stream_compressor *dsc,
 		struct dsc_enc_caps *dsc_enc_caps,
 		int pixel_clock_100Hz)
 {
-	// This is a static HW query, so we can use any DSC
-
 	memset(dsc_enc_caps, 0, sizeof(struct dsc_enc_caps));
-	if (dsc) {
+
+	if (!dsc)
+		return;
+
+	/* check if reported cap global or only for a single DCN DSC enc */
+	if (dsc->funcs->dsc_get_enc_caps) {
 		if (!dsc->ctx->dc->debug.disable_dsc)
 			dsc->funcs->dsc_get_enc_caps(dsc_enc_caps, pixel_clock_100Hz);
-		if (dsc->ctx->dc->debug.native422_support)
-			dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 1;
+	} else {
+		build_dsc_enc_caps(dsc, dsc_enc_caps);
 	}
+
+	if (dsc->ctx->dc->debug.native422_support)
+		dsc_enc_caps->color_formats.bits.YCBCR_NATIVE_422 = 1;
 }
 
 /* Returns 'false' if no intersection was found for at least one capability.
@@ -621,11 +764,6 @@ static bool intersect_dsc_caps(
 	return true;
 }
 
-static inline uint32_t dsc_div_by_10_round_up(uint32_t value)
-{
-	return (value + 9) / 10;
-}
-
 static uint32_t compute_bpp_x16_from_target_bandwidth(
 	const uint32_t bandwidth_in_kbps,
 	const struct dc_crtc_timing *timing,
@@ -910,11 +1048,11 @@ static bool setup_dsc_config(
 		const struct dc_crtc_timing *timing,
 		const struct dc_dsc_config_options *options,
 		const enum dc_link_encoding_format link_encoding,
+		int min_slices_h,
 		struct dc_dsc_config *dsc_cfg)
 {
 	struct dsc_enc_caps dsc_common_caps;
 	int max_slices_h = 0;
-	int min_slices_h = 0;
 	int num_slices_h = 0;
 	int pic_width;
 	int slice_width;
@@ -1018,12 +1156,9 @@ static bool setup_dsc_config(
 	if (!is_dsc_possible)
 		goto done;
 
-	min_slices_h = pic_width / dsc_common_caps.max_slice_width;
-	if (pic_width % dsc_common_caps.max_slice_width)
-		min_slices_h++;
-
 	min_slices_h = fit_num_slices_up(dsc_common_caps.slice_caps, min_slices_h);
 
+	/* increase minimum slice count to meet sink throughput limitations */
 	while (min_slices_h <= max_slices_h) {
 		int pix_clk_per_slice_khz = dsc_div_by_10_round_up(timing->pix_clk_100hz) / min_slices_h;
 		if (pix_clk_per_slice_khz <= sink_per_slice_throughput_mps * 1000)
@@ -1032,14 +1167,12 @@ static bool setup_dsc_config(
 		min_slices_h = inc_num_slices(dsc_common_caps.slice_caps, min_slices_h);
 	}
 
-	is_dsc_possible = (min_slices_h <= max_slices_h);
-
-	if (pic_width % min_slices_h != 0)
-		min_slices_h = 0; // DSC TODO: Maybe try increasing the number of slices first?
-
-	if (min_slices_h == 0 && max_slices_h == 0)
-		is_dsc_possible = false;
+	/* increase minimum slice count to meet divisibility requirements */
+	while (pic_width % min_slices_h != 0 && min_slices_h <= max_slices_h) {
+		min_slices_h = inc_num_slices(dsc_common_caps.slice_caps, min_slices_h);
+	}
 
+	is_dsc_possible = (min_slices_h <= max_slices_h) && max_slices_h != 0;
 	if (!is_dsc_possible)
 		goto done;
 
@@ -1162,12 +1295,19 @@ bool dc_dsc_compute_config(
 {
 	bool is_dsc_possible = false;
 	struct dsc_enc_caps dsc_enc_caps;
-
+	unsigned int min_slice_count;
 	get_dsc_enc_caps(dsc, &dsc_enc_caps, timing->pix_clk_100hz);
+
+	min_slice_count = get_min_slice_count_for_odm(dsc, &dsc_enc_caps, timing);
+
 	is_dsc_possible = setup_dsc_config(dsc_sink_caps,
 		&dsc_enc_caps,
 		target_bandwidth_kbps,
-		timing, options, link_encoding, dsc_cfg);
+		timing,
+		options,
+		link_encoding,
+		min_slice_count,
+		dsc_cfg);
 	return is_dsc_possible;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
index af5de564faec..7bd92ae8b13e 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
@@ -9,17 +9,14 @@
 #include "dsc/dscc_types.h"
 #include "dsc/rc_calc.h"
 
-#define MAX_THROUGHPUT_PER_DSC_100HZ 20000000
-#define MAX_DSC_UNIT_COMBINE 4
-
 static void dsc_write_to_registers(struct display_stream_compressor *dsc, const struct dsc_reg_values *reg_vals);
 
 /* Object I/F functions */
 //static void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz);
 //static bool dsc401_get_packed_pps(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg, uint8_t *dsc_packed_pps);
+static void dsc401_get_single_enc_caps(struct dsc_enc_caps *dsc_enc_caps, unsigned int max_dscclk_khz);
 
 static const struct dsc_funcs dcn401_dsc_funcs = {
-	.dsc_get_enc_caps = dsc401_get_enc_caps,
 	.dsc_read_state = dsc401_read_state,
 	.dsc_validate_stream = dsc401_validate_stream,
 	.dsc_set_config = dsc401_set_config,
@@ -28,6 +25,7 @@ static const struct dsc_funcs dcn401_dsc_funcs = {
 	.dsc_disable = dsc401_disable,
 	.dsc_disconnect = dsc401_disconnect,
 	.dsc_wait_disconnect_pending_clear = dsc401_wait_disconnect_pending_clear,
+	.dsc_get_single_enc_caps = dsc401_get_single_enc_caps,
 };
 
 /* Macro definitios for REG_SET macros*/
@@ -64,22 +62,14 @@ void dsc401_construct(struct dcn401_dsc *dsc,
 	dsc->max_image_width = 5184;
 }
 
-void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz)
+static void dsc401_get_single_enc_caps(struct dsc_enc_caps *dsc_enc_caps, unsigned int max_dscclk_khz)
 {
-	int min_dsc_unit_required = (pixel_clock_100Hz + MAX_THROUGHPUT_PER_DSC_100HZ - 1) / MAX_THROUGHPUT_PER_DSC_100HZ;
-
 	dsc_enc_caps->dsc_version = 0x21; /* v1.2 - DP spec defined it in reverse order and we kept it */
 
-	/* 1 slice is only supported with 1 DSC unit */
-	dsc_enc_caps->slice_caps.bits.NUM_SLICES_1 = min_dsc_unit_required == 1 ? 1 : 0;
-	/* 2 slice is only supported with 1 or 2 DSC units */
-	dsc_enc_caps->slice_caps.bits.NUM_SLICES_2 = (min_dsc_unit_required == 1 || min_dsc_unit_required == 2) ? 1 : 0;
-	/* 3 slice is only supported with 1 DSC unit */
-	dsc_enc_caps->slice_caps.bits.NUM_SLICES_3 = min_dsc_unit_required == 1 ? 1 : 0;
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_1 = 1;
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_2 = 1;
+	dsc_enc_caps->slice_caps.bits.NUM_SLICES_3 = 1;
 	dsc_enc_caps->slice_caps.bits.NUM_SLICES_4 = 1;
-	dsc_enc_caps->slice_caps.bits.NUM_SLICES_8 = 1;
-	dsc_enc_caps->slice_caps.bits.NUM_SLICES_12 = 1;
-	dsc_enc_caps->slice_caps.bits.NUM_SLICES_16 = 1;
 
 	dsc_enc_caps->lb_bit_depth = 13;
 	dsc_enc_caps->is_block_pred_supported = true;
@@ -93,7 +83,7 @@ void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100H
 	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_8_BPC = 1;
 	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_10_BPC = 1;
 	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_12_BPC = 1;
-	dsc_enc_caps->max_total_throughput_mps = MAX_THROUGHPUT_PER_DSC_100HZ * MAX_DSC_UNIT_COMBINE;
+	dsc_enc_caps->max_total_throughput_mps = max_dscclk_khz * 3 / 1000;
 
 	dsc_enc_caps->max_slice_width = 5184; /* (including 64 overlap pixels for eDP MSO mode) */
 	dsc_enc_caps->bpp_increment_div = 16; /* 1/16th of a bit */
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h
index 1d927d8e83bf..7acd57eb4f42 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.h
@@ -341,7 +341,6 @@ void dsc401_set_config(struct display_stream_compressor *dsc, const struct dsc_c
 void dsc401_enable(struct display_stream_compressor *dsc, int opp_pipe);
 void dsc401_disable(struct display_stream_compressor *dsc);
 void dsc401_disconnect(struct display_stream_compressor *dsc);
-void dsc401_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz);
 void dsc401_wait_disconnect_pending_clear(struct display_stream_compressor *dsc);
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 3b736f4687a6..7d66e62b6be6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -100,6 +100,17 @@ struct dcn301_clk_internal {
 #define MAX_NUM_DPM_LVL		8
 #define WM_SET_COUNT 		4
 
+enum clk_type {
+	CLK_TYPE_DCFCLK,
+	CLK_TYPE_FCLK,
+	CLK_TYPE_MCLK,
+	CLK_TYPE_SOCCLK,
+	CLK_TYPE_DTBCLK,
+	CLK_TYPE_DISPCLK,
+	CLK_TYPE_DPPCLK,
+	CLK_TYPE_DSCCLK,
+	CLK_TYPE_COUNT
+};
 
 struct clk_limit_table_entry {
 	unsigned int voltage; /* milivolts withh 2 fractional bits */
@@ -326,6 +337,7 @@ struct clk_mgr_funcs {
 
 	bool (*is_dc_mode_present)(struct clk_mgr *clk_mgr);
 
+	unsigned int (*get_max_clock_khz)(struct clk_mgr *clk_mgr_base, enum clk_type clk_type);
 };
 
 struct clk_mgr {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 067a93420a23..f9cbdad3ef37 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -2736,6 +2736,8 @@ static bool dcn20_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 2;
+
 	dc->cap_funcs = cap_funcs;
 
 	if (dc->ctx->dc_bios->fw_info.oem_i2c_present) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index 43fa2cb117f3..e4a1338d21e0 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -1285,6 +1285,8 @@ static bool dcn201_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 2;
+
 	dc->cap_funcs = cap_funcs;
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 238d7f8beb7c..918742a42ded 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -1684,6 +1684,8 @@ static bool dcn21_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 2;
+
 	dc->cap_funcs = cap_funcs;
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 4d4635e01eb6..895349d9ca07 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -2586,6 +2586,8 @@ static bool dcn30_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 4;
+
 	dc->cap_funcs = cap_funcs;
 
 	if (dc->ctx->dc_bios->fw_info.oem_i2c_present) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 121a86a59833..82a205a7c25c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -1706,6 +1706,8 @@ static bool dcn301_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 4;
+
 	dc->cap_funcs = cap_funcs;
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index 012c5fd52cb1..3345068a878c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -1481,6 +1481,8 @@ static bool dcn302_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 4;
+
 	dc->cap_funcs = cap_funcs;
 
 	if (dc->ctx->dc_bios->fw_info.oem_i2c_present) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index a8d0b4686f9a..3479e1eab4cd 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -1414,6 +1414,8 @@ static bool dcn303_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 4;
+
 	dc->cap_funcs = cap_funcs;
 
 	if (dc->ctx->dc_bios->fw_info.oem_i2c_present) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 88afa59d17b0..3ed7f50554e2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -2204,6 +2204,8 @@ static bool dcn31_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 4;
+
 	dc->cap_funcs = cap_funcs;
 
 	dc->dcn_ip->max_num_dpp = dcn3_1_ip.max_num_dpp;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index dedf7bce6ece..de708fdc1e80 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -2119,6 +2119,8 @@ static bool dcn314_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 4;
+
 	dc->cap_funcs = cap_funcs;
 
 	dc->dcn_ip->max_num_dpp = dcn3_14_ip.max_num_dpp;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index d110be626bc2..82cc78c291d8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -2142,6 +2142,8 @@ static bool dcn315_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 4;
+
 	dc->cap_funcs = cap_funcs;
 
 	dc->dcn_ip->max_num_dpp = dcn3_15_ip.max_num_dpp;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 939811858ff7..636110e48d01 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -2010,6 +2010,8 @@ static bool dcn316_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 4;
+
 	dc->cap_funcs = cap_funcs;
 
 	dc->dcn_ip->max_num_dpp = dcn3_16_ip.max_num_dpp;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 9ffa10189eee..9917b366f00c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2500,6 +2500,8 @@ static bool dcn32_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 4;
+
 	dc->cap_funcs = cap_funcs;
 
 	if (dc->ctx->dc_bios->fw_info.oem_i2c_present) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index c53266e16c58..061c0907d802 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1999,6 +1999,8 @@ static bool dcn321_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 4;
+
 	dc->cap_funcs = cap_funcs;
 
 	if (dc->ctx->dc_bios->fw_info.oem_i2c_present) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index e327dee9be21..1d1a002f6d54 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -2154,6 +2154,8 @@ static bool dcn35_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 4;
+
 	dc->cap_funcs = cap_funcs;
 
 	dc->dcn_ip->max_num_dpp = pool->base.pipe_count;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 2f2976afc229..47912e0861a2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -2125,6 +2125,8 @@ static bool dcn351_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 4;
+
 	dc->cap_funcs = cap_funcs;
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 5b7848496a70..9ba91e214dda 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -2127,6 +2127,8 @@ static bool dcn36_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 4;
+
 	dc->cap_funcs = cap_funcs;
 
 	dc->dcn_ip->max_num_dpp = pool->base.pipe_count;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index a9d989f20405..b3988e38d0a6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -2190,6 +2190,8 @@ static bool dcn401_resource_construct(
 	for (i = 0; i < dc->caps.max_planes; ++i)
 		dc->caps.planes[i] = plane_cap;
 
+	dc->caps.max_odm_combine_factor = 4;
+
 	dc->cap_funcs = cap_funcs;
 
 	if (dc->ctx->dc_bios->fw_info.oem_i2c_present) {
-- 
2.43.0

