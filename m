Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47C8C7115B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 15:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C9EC10E8BC;
	Wed, 18 Jun 2025 15:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P8ANGNbO";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98AC810E8BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEMPrT1HvmWvZEkMj1aFMnVfG1o9hvnktwJE010gBmKW38SjLYU2EDdwOvgubMvR07d3+gpm53zyS9LfQflMBclmPIsPnkMCsDU+a5RgI3cxFwAWhkcQY+9D0eb6t/MSmPWKG3lWejz2ubfY6L44ExclKOL/zOd2cJHShpUsrqCwgzubZy+cNk5OaMMVwX1i+lUuj1v29I6fQphjJiiUvQRGY5noIvyeo6EkPjFY/FPQ2AlNoXcEkZgVQ9XNRqpRqu6WhaLXhVFoA6b/hqYF2xWhYXkWmEat+ZLNehy+5U8LupNeN5zSq7tCuI6+ggAsbfXRRTiySkX2IeOUN7rW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q//yOKtJgvDDLgZziCoYV4epipnj2NDvFXr1/BUcotQ=;
 b=rnZM7rDqKpoun7NEBhfdBi05PEQI+fO+gPHs1uNwT5g4rFV0oS0cq8Zth6YHIn+6xa1wrpdxEgL1V/FQ574HfP662EHI2mtPVQrhFsUiZehksp0Bsh3AYkQekBoxMbApJCjr7ANCuNrgi/wJuiuHGd7YR9CUUFXcAcEbL4YVmqTtujmim5DJraKhBDbEDxc3t8Rovig2rVrLt+SQ6NTJWIb64Lxx3vfaWXrZOBkaZdgBbBbMPwVSLHsxESg0ZSSQcdvNyueDXabESjgmN4lGvmuyCG/H3lXMz2ZDWdj/K+5kQPFvQZqsF7HlCDCkTENIHqML7t5AQUbd4M1NhdGy3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q//yOKtJgvDDLgZziCoYV4epipnj2NDvFXr1/BUcotQ=;
 b=P8ANGNbO8cZJI7Oipfq5UsJjg9wkgZ5J28J+g/c8J9wnyukLlKgeeCk7+cruHxoDf26c+vGlnVhLFKwlPpIv80ptbdTcw6DR/ozm8kzdylCvh/Ya1t4gpJPsRODhdt9FNtGcBhRu4S74UKEwGFj6OvvpXBcFsHSUkpLthf7fTV4=
Received: from CH2PR07CA0006.namprd07.prod.outlook.com (2603:10b6:610:20::19)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Wed, 18 Jun
 2025 15:54:50 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::44) by CH2PR07CA0006.outlook.office365.com
 (2603:10b6:610:20::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.33 via Frontend Transport; Wed,
 18 Jun 2025 15:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 15:54:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:48 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 10:54:48 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Austin Zheng
 <Austin.Zheng@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 01/13] drm/amd/display: Include EQU Prefetch Bandwidth For
 Bandwidth Calculations
Date: Wed, 18 Jun 2025 11:33:49 -0400
Message-ID: <20250618153936.6472-2-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618153936.6472-1-Jerry.Zuo@amd.com>
References: <20250618153936.6472-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c0c0cab-21f3-4816-876b-08ddae80750f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GhAwjlCcJn+lW9uRYuG7X2JggsXNTQdgtAKOqJe+LJkis6Tz+b0dA57wesYG?=
 =?us-ascii?Q?lDCH2ZRbd3BfHaOcCjTEqeWR4XDu55kLoo8Ar0bl8/6IF9k2cODc8YeCbj+1?=
 =?us-ascii?Q?1fe1HiUfNU/+NRUN86drlQPmgjbHc5ifP8sNOPjjt019uQUadOz3pEoNUOlg?=
 =?us-ascii?Q?2SQXy+GvGaX3EINWlccSizti2nOikEqD2c91HyhsCvCq0Ks9riREr7Sgaeby?=
 =?us-ascii?Q?63yEL1gv78BAtWM4IVKqo1GovSxDtNH114Fq7ud0RruUaFcXLrTVtvMi5glT?=
 =?us-ascii?Q?vEQTHp7XMZaX6Ozlv8nMMJpABvVvWqeC668jQqF/pryIfkImznKOP+XXBBbp?=
 =?us-ascii?Q?+JQNLSA+xj3J6Uztt3FmfGYHZWUb16BjOOjimAgBB6s4TKIwdELar/LgVsPR?=
 =?us-ascii?Q?yJm8tP2WTCay4snAfggzJcIflpWYpjzQ2pSx4GtYuqsld7kdSYhbhuTRtxTo?=
 =?us-ascii?Q?TCGaHruuQT+rmpQ9QKK6/PuIawhMr+Hw0uneRLlfRgsCNFy1qhHXkeIg0Ecg?=
 =?us-ascii?Q?3x0DUngoirv3q7dUi1DKgTvY/E0PuqBEoUfqFHcpxlXWHN1rEurT+swPmQe9?=
 =?us-ascii?Q?LDuLl2rfu1WBl041UAxUjYwETbyTikn1e/AL3UBWm3tPovjfNabfbs4+zoRb?=
 =?us-ascii?Q?9cFt+EiwGfi8FLRkpse+LpvVoNiZ4nz7ygUJc55eH5o7u19pYSMDExEZjzMT?=
 =?us-ascii?Q?otc0QnhdNz1Evjc82RLXdX6I7CLgzhFA34ev3FIlEPqi83hfltehBJe/WTt4?=
 =?us-ascii?Q?pXzq9tq3pfAeFwM+6FAvNhXy+a1iYfG4cFPIH0CVZ6tIs9yCUTHisd10Pfz/?=
 =?us-ascii?Q?r9nNk7rBUh2oN951kiOIJaPKnGBH8yEYH19qJH+TDC3E0oMlygfjEaOEupDs?=
 =?us-ascii?Q?NQrsDXez4GBPiflMjUaUvCGIEV9VPym/F1z84yXrBoBcEZUpHhw4sDarBC9C?=
 =?us-ascii?Q?grHOmaf1jwodsCDU6jV7ZqkO2w3oeuhwiqWTRU6IEWv2MuGf1Sa2qyaCtZxp?=
 =?us-ascii?Q?mBywo5uflPfgEoKUOdMz0dIlsNmxRRiFdVGBOPaAz3hE9kVw3Pz4RihuLxQ/?=
 =?us-ascii?Q?Sdfy/I2ytVqLDe7b2j0OjM2JldSZsPBckzneiLa5Ev3YyQLdrXikslf7a4hV?=
 =?us-ascii?Q?5UfG+NeiO6UU1dzDylDwgYq+Fw3nc1bZWHH62udPWnrupItxiJVZGUlWTqLJ?=
 =?us-ascii?Q?UBC0ucnO5t7/9PnPo7nVHMZr/Dqu4wx1DjTnGHBoftjDwWtSFbVJSF03Qo4U?=
 =?us-ascii?Q?JLCIwHbjG1sT/BgD93TSDgobPfuXad2IVlRUsjAlBnoIkuwGSVrWVNKK/2nu?=
 =?us-ascii?Q?xUFDbT3KbePJw+IvnkVZLqHD1jxuQBT74PIUTAC3dDfeyAbZfvjzPM18SBkF?=
 =?us-ascii?Q?6cvAW3p8ffOvV8dwcF9aSgR9eYI1wco0o/F1Rx/I6SuEanvN0hmkHadzTYEL?=
 =?us-ascii?Q?JBOz3dh1iGGBSSbsMYmpCbr3jFYxRpSTYbWLZDs/mGd13NFduNhciOHRdckr?=
 =?us-ascii?Q?dxci6eeHQzURLpMzCVceAhEUXkJ7361SCMg2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:54:49.8911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0c0cab-21f3-4816-876b-08ddae80750f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why]
Pixel data bandwidth required in mode programming (MP) ends up being
higher than what was calculated in mode support (MS) even though
the prefetch bandwidths calculated in MP are lower than the MS ones.

MP used a different equ prefetch schedule than MS which lead a
slight difference in parameters. This resulted in the pixel data
bandwidth in MP to be higher than MS.

[How]
Rename the RequiredPrefetchBWOTO term so it can be applied generically.
Update the value with the EQU bandwidth if the EQU schedule is used.
Get the max prefetch bandwidth that MS calculated and use it
as part of the calculations for required bandwidth.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 42 +++++++++++--------
 .../src/dml2_core/dml2_core_shared_types.h    | 16 ++++---
 2 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 5dceab1208f2..8d4e5a91af06 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -4861,7 +4861,7 @@ static double get_urgent_bandwidth_required(
 	double ReadBandwidthChroma[],
 	double PrefetchBandwidthLuma[],
 	double PrefetchBandwidthChroma[],
-	double PrefetchBandwidthOto[],
+	double PrefetchBandwidthMax[],
 	double excess_vactive_fill_bw_l[],
 	double excess_vactive_fill_bw_c[],
 	double cursor_bw[],
@@ -4925,9 +4925,9 @@ static double get_urgent_bandwidth_required(
 			l->vm_row_bw = NumberOfDPP[k] * prefetch_vmrow_bw[k];
 			l->flip_and_active_bw = l->per_plane_flip_bw[k] + ReadBandwidthLuma[k] * l->adj_factor_p0 + ReadBandwidthChroma[k] * l->adj_factor_p1 + cursor_bw[k] * l->adj_factor_cur;
 			l->flip_and_prefetch_bw = l->per_plane_flip_bw[k] + NumberOfDPP[k] * (PrefetchBandwidthLuma[k] * l->adj_factor_p0_pre + PrefetchBandwidthChroma[k] * l->adj_factor_p1_pre) + prefetch_cursor_bw[k] * l->adj_factor_cur_pre;
-			l->flip_and_prefetch_bw_oto = l->per_plane_flip_bw[k] + NumberOfDPP[k] * (PrefetchBandwidthOto[k] * l->adj_factor_p0_pre + PrefetchBandwidthChroma[k] * l->adj_factor_p1_pre) + prefetch_cursor_bw[k] * l->adj_factor_cur_pre;
+			l->flip_and_prefetch_bw_max = l->per_plane_flip_bw[k] + NumberOfDPP[k] * (PrefetchBandwidthMax[k] * l->adj_factor_p0_pre + PrefetchBandwidthChroma[k] * l->adj_factor_p1_pre) + prefetch_cursor_bw[k] * l->adj_factor_cur_pre;
 			l->active_and_excess_bw = (ReadBandwidthLuma[k] + excess_vactive_fill_bw_l[k]) * l->tmp_nom_adj_factor_p0 + (ReadBandwidthChroma[k] + excess_vactive_fill_bw_c[k]) * l->tmp_nom_adj_factor_p1 + dpte_row_bw[k] + meta_row_bw[k];
-			surface_required_bw[k] = math_max5(l->vm_row_bw, l->flip_and_active_bw, l->flip_and_prefetch_bw, l->active_and_excess_bw, l->flip_and_prefetch_bw_oto);
+			surface_required_bw[k] = math_max5(l->vm_row_bw, l->flip_and_active_bw, l->flip_and_prefetch_bw, l->active_and_excess_bw, l->flip_and_prefetch_bw_max);
 
 			/* export peak required bandwidth for the surface */
 			surface_peak_required_bw[k] = math_max2(surface_required_bw[k], surface_peak_required_bw[k]);
@@ -5125,7 +5125,7 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 	s->Tsw_est3 = 0.0;
 	s->cursor_prefetch_bytes = 0;
 	*p->prefetch_cursor_bw = 0;
-	*p->RequiredPrefetchBWOTO = 0.0;
+	*p->RequiredPrefetchBWMax = 0.0;
 
 	dcc_mrq_enable = (p->dcc_enable && p->mrq_present);
 
@@ -5356,7 +5356,7 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 	 * mp will fail if ms decides to use equ schedule and mp decides to use oto schedule
 	 * and the required bandwidth increases when going from ms to mp
 	 */
-	*p->RequiredPrefetchBWOTO = s->prefetch_bw_oto;
+	*p->RequiredPrefetchBWMax = s->prefetch_bw_oto;
 
 #ifdef __DML_VBA_DEBUG__
 	DML_LOG_VERBOSE("DML::%s: vactive_sw_bw_l = %f\n", __func__, p->vactive_sw_bw_l);
@@ -5718,8 +5718,14 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 			s->TimeForFetchingVM = s->Tvm_equ;
 			s->TimeForFetchingRowInVBlank = s->Tr0_equ;
 
-		*p->dst_y_per_vm_vblank = math_ceil2(4.0 * s->TimeForFetchingVM / s->LineTime, 1.0) / 4.0;
-		*p->dst_y_per_row_vblank = math_ceil2(4.0 * s->TimeForFetchingRowInVBlank / s->LineTime, 1.0) / 4.0;
+			*p->dst_y_per_vm_vblank = math_ceil2(4.0 * s->TimeForFetchingVM / s->LineTime, 1.0) / 4.0;
+			*p->dst_y_per_row_vblank = math_ceil2(4.0 * s->TimeForFetchingRowInVBlank / s->LineTime, 1.0) / 4.0;
+
+			/* equ bw should be propagated so a ceiling of the equ bw is accounted for prior to mode programming.
+			 * Overall bandwidth may be lower when going from mode support to mode programming but final pixel data
+			 * bandwidth may end up higher than what was calculated in mode support.
+			 */
+			*p->RequiredPrefetchBWMax = math_max2(s->prefetch_bw_equ, *p->RequiredPrefetchBWMax);
 
 #ifdef __DML_VBA_DEBUG__
 			DML_LOG_VERBOSE("DML::%s: Using equ bw scheduling for prefetch\n", __func__);
@@ -6115,7 +6121,7 @@ static void calculate_peak_bandwidth_required(
 				p->surface_read_bandwidth_c,
 				l->zero_array, //PrefetchBandwidthLuma,
 				l->zero_array, //PrefetchBandwidthChroma,
-				l->zero_array, //PrefetchBWOTO
+				l->zero_array, //PrefetchBWMax
 				l->zero_array,
 				l->zero_array,
 				l->zero_array,
@@ -6152,7 +6158,7 @@ static void calculate_peak_bandwidth_required(
 				p->surface_read_bandwidth_c,
 				l->zero_array, //PrefetchBandwidthLuma,
 				l->zero_array, //PrefetchBandwidthChroma,
-				l->zero_array, //PrefetchBWOTO
+				l->zero_array, //PrefetchBWMax
 				p->excess_vactive_fill_bw_l,
 				p->excess_vactive_fill_bw_c,
 				p->cursor_bw,
@@ -6189,7 +6195,7 @@ static void calculate_peak_bandwidth_required(
 				p->surface_read_bandwidth_c,
 				p->prefetch_bandwidth_l,
 				p->prefetch_bandwidth_c,
-				p->prefetch_bandwidth_oto, // to prevent ms/mp mismatch when oto bw > total vactive bw
+				p->prefetch_bandwidth_max, // to prevent ms/mp mismatches where mp prefetch bw > ms prefetch bw
 				p->excess_vactive_fill_bw_l,
 				p->excess_vactive_fill_bw_c,
 				p->cursor_bw,
@@ -6226,7 +6232,7 @@ static void calculate_peak_bandwidth_required(
 				p->surface_read_bandwidth_c,
 				p->prefetch_bandwidth_l,
 				p->prefetch_bandwidth_c,
-				p->prefetch_bandwidth_oto, // to prevent ms/mp mismatch when oto bw > total vactive bw
+				p->prefetch_bandwidth_max, // to prevent ms/mp mismatch where mp prefetch bw > ms prefetch bw
 				p->excess_vactive_fill_bw_l,
 				p->excess_vactive_fill_bw_c,
 				p->cursor_bw,
@@ -6263,7 +6269,7 @@ static void calculate_peak_bandwidth_required(
 				p->surface_read_bandwidth_c,
 				p->prefetch_bandwidth_l,
 				p->prefetch_bandwidth_c,
-				p->prefetch_bandwidth_oto, // to prevent ms/mp mismatch when oto bw > total vactive bw
+				p->prefetch_bandwidth_max, // to prevent ms/mp mismatches where mp prefetch bw > ms prefetch bw
 				p->excess_vactive_fill_bw_l,
 				p->excess_vactive_fill_bw_c,
 				p->cursor_bw,
@@ -7490,7 +7496,7 @@ static noinline_for_stack void dml_core_ms_prefetch_check(struct dml2_core_inter
 			CalculatePrefetchSchedule_params->VRatioPrefetchC = &mode_lib->ms.VRatioPreC[k];
 			CalculatePrefetchSchedule_params->RequiredPrefetchPixelDataBWLuma = &mode_lib->ms.RequiredPrefetchPixelDataBWLuma[k]; // prefetch_sw_bw_l
 			CalculatePrefetchSchedule_params->RequiredPrefetchPixelDataBWChroma = &mode_lib->ms.RequiredPrefetchPixelDataBWChroma[k]; // prefetch_sw_bw_c
-			CalculatePrefetchSchedule_params->RequiredPrefetchBWOTO = &mode_lib->ms.RequiredPrefetchBWOTO[k];
+			CalculatePrefetchSchedule_params->RequiredPrefetchBWMax = &mode_lib->ms.RequiredPrefetchBWMax[k];
 			CalculatePrefetchSchedule_params->NotEnoughTimeForDynamicMetadata = &mode_lib->ms.NoTimeForDynamicMetadata[k];
 			CalculatePrefetchSchedule_params->Tno_bw = &mode_lib->ms.Tno_bw[k];
 			CalculatePrefetchSchedule_params->Tno_bw_flip = &mode_lib->ms.Tno_bw_flip[k];
@@ -7635,7 +7641,7 @@ static noinline_for_stack void dml_core_ms_prefetch_check(struct dml2_core_inter
 			calculate_peak_bandwidth_params->surface_read_bandwidth_c = mode_lib->ms.vactive_sw_bw_c;
 			calculate_peak_bandwidth_params->prefetch_bandwidth_l = mode_lib->ms.RequiredPrefetchPixelDataBWLuma;
 			calculate_peak_bandwidth_params->prefetch_bandwidth_c = mode_lib->ms.RequiredPrefetchPixelDataBWChroma;
-			calculate_peak_bandwidth_params->prefetch_bandwidth_oto = mode_lib->ms.RequiredPrefetchBWOTO;
+			calculate_peak_bandwidth_params->prefetch_bandwidth_max = mode_lib->ms.RequiredPrefetchBWMax;
 			calculate_peak_bandwidth_params->excess_vactive_fill_bw_l = mode_lib->ms.excess_vactive_fill_bw_l;
 			calculate_peak_bandwidth_params->excess_vactive_fill_bw_c = mode_lib->ms.excess_vactive_fill_bw_c;
 			calculate_peak_bandwidth_params->cursor_bw = mode_lib->ms.cursor_bw;
@@ -7802,7 +7808,7 @@ static noinline_for_stack void dml_core_ms_prefetch_check(struct dml2_core_inter
 		calculate_peak_bandwidth_params->surface_read_bandwidth_c = mode_lib->ms.vactive_sw_bw_c;
 		calculate_peak_bandwidth_params->prefetch_bandwidth_l = mode_lib->ms.RequiredPrefetchPixelDataBWLuma;
 		calculate_peak_bandwidth_params->prefetch_bandwidth_c = mode_lib->ms.RequiredPrefetchPixelDataBWChroma;
-		calculate_peak_bandwidth_params->prefetch_bandwidth_oto = mode_lib->ms.RequiredPrefetchBWOTO;
+		calculate_peak_bandwidth_params->prefetch_bandwidth_max = mode_lib->ms.RequiredPrefetchBWMax;
 		calculate_peak_bandwidth_params->excess_vactive_fill_bw_l = mode_lib->ms.excess_vactive_fill_bw_l;
 		calculate_peak_bandwidth_params->excess_vactive_fill_bw_c = mode_lib->ms.excess_vactive_fill_bw_c;
 		calculate_peak_bandwidth_params->cursor_bw = mode_lib->ms.cursor_bw;
@@ -11257,7 +11263,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 			CalculatePrefetchSchedule_params->VRatioPrefetchC = &mode_lib->mp.VRatioPrefetchC[k];
 			CalculatePrefetchSchedule_params->RequiredPrefetchPixelDataBWLuma = &mode_lib->mp.RequiredPrefetchPixelDataBWLuma[k];
 			CalculatePrefetchSchedule_params->RequiredPrefetchPixelDataBWChroma = &mode_lib->mp.RequiredPrefetchPixelDataBWChroma[k];
-			CalculatePrefetchSchedule_params->RequiredPrefetchBWOTO = &s->dummy_single_array[0][k];
+			CalculatePrefetchSchedule_params->RequiredPrefetchBWMax = &s->dummy_single_array[0][k];
 			CalculatePrefetchSchedule_params->NotEnoughTimeForDynamicMetadata = &mode_lib->mp.NotEnoughTimeForDynamicMetadata[k];
 			CalculatePrefetchSchedule_params->Tno_bw = &mode_lib->mp.Tno_bw[k];
 			CalculatePrefetchSchedule_params->Tno_bw_flip = &mode_lib->mp.Tno_bw_flip[k];
@@ -11400,7 +11406,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 			calculate_peak_bandwidth_params->surface_read_bandwidth_c = mode_lib->mp.vactive_sw_bw_c;
 			calculate_peak_bandwidth_params->prefetch_bandwidth_l = mode_lib->mp.RequiredPrefetchPixelDataBWLuma;
 			calculate_peak_bandwidth_params->prefetch_bandwidth_c = mode_lib->mp.RequiredPrefetchPixelDataBWChroma;
-			calculate_peak_bandwidth_params->prefetch_bandwidth_oto = s->dummy_single_array[0];
+			calculate_peak_bandwidth_params->prefetch_bandwidth_max = s->dummy_single_array[0];
 			calculate_peak_bandwidth_params->excess_vactive_fill_bw_l = mode_lib->mp.excess_vactive_fill_bw_l;
 			calculate_peak_bandwidth_params->excess_vactive_fill_bw_c = mode_lib->mp.excess_vactive_fill_bw_c;
 			calculate_peak_bandwidth_params->cursor_bw = mode_lib->mp.cursor_bw;
@@ -11540,7 +11546,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 			calculate_peak_bandwidth_params->meta_row_bw = mode_lib->mp.meta_row_bw;
 			calculate_peak_bandwidth_params->prefetch_cursor_bw = mode_lib->mp.prefetch_cursor_bw;
 			calculate_peak_bandwidth_params->prefetch_vmrow_bw = mode_lib->mp.prefetch_vmrow_bw;
-			calculate_peak_bandwidth_params->prefetch_bandwidth_oto = s->dummy_single_array[0];
+			calculate_peak_bandwidth_params->prefetch_bandwidth_max = s->dummy_single_array[0];
 			calculate_peak_bandwidth_params->flip_bw = mode_lib->mp.final_flip_bw;
 			calculate_peak_bandwidth_params->urgent_burst_factor_l = mode_lib->mp.UrgentBurstFactorLuma;
 			calculate_peak_bandwidth_params->urgent_burst_factor_c = mode_lib->mp.UrgentBurstFactorChroma;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
index 5f5b15b478e3..fb57fe459227 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -497,8 +497,14 @@ struct dml2_core_internal_mode_support {
 	double WriteBandwidth[DML2_MAX_PLANES][DML2_MAX_WRITEBACK];
 	double RequiredPrefetchPixelDataBWLuma[DML2_MAX_PLANES];
 	double RequiredPrefetchPixelDataBWChroma[DML2_MAX_PLANES];
-	/* oto bw should also be considered when calculating peak urgent bw to avoid situations oto/equ mismatches between ms and mp */
-	double RequiredPrefetchBWOTO[DML2_MAX_PLANES];
+	/* Max bandwidth calculated from prefetch schedule should be considered in addition to the pixel data bw to avoid ms/mp mismatches.
+	 * 1. oto bw should also be considered when calculating peak urgent bw to avoid situations oto/equ mismatches between ms and mp
+	 *
+	 * 2. equ bandwidth needs to be considered for calculating peak urgent bw when equ schedule is used in mode support.
+	 *    Some slight difference in variables may cause the pixel data bandwidth to be higher
+	 *    even though overall equ prefetch bandwidths can be lower going from ms to mp
+	 */
+	double RequiredPrefetchBWMax[DML2_MAX_PLANES];
 	double cursor_bw[DML2_MAX_PLANES];
 	double prefetch_cursor_bw[DML2_MAX_PLANES];
 	double prefetch_vmrow_bw[DML2_MAX_PLANES];
@@ -1469,7 +1475,7 @@ struct dml2_core_shared_get_urgent_bandwidth_required_locals {
 	double vm_row_bw;
 	double flip_and_active_bw;
 	double flip_and_prefetch_bw;
-	double flip_and_prefetch_bw_oto;
+	double flip_and_prefetch_bw_max;
 	double active_and_excess_bw;
 };
 
@@ -1881,7 +1887,7 @@ struct dml2_core_calcs_CalculatePrefetchSchedule_params {
 	double *VRatioPrefetchC;
 	double *RequiredPrefetchPixelDataBWLuma;
 	double *RequiredPrefetchPixelDataBWChroma;
-	double *RequiredPrefetchBWOTO;
+	double *RequiredPrefetchBWMax;
 	bool *NotEnoughTimeForDynamicMetadata;
 	double *Tno_bw;
 	double *Tno_bw_flip;
@@ -2118,7 +2124,7 @@ struct dml2_core_calcs_calculate_peak_bandwidth_required_params {
 	double *surface_read_bandwidth_c;
 	double *prefetch_bandwidth_l;
 	double *prefetch_bandwidth_c;
-	double *prefetch_bandwidth_oto;
+	double *prefetch_bandwidth_max;
 	double *excess_vactive_fill_bw_l;
 	double *excess_vactive_fill_bw_c;
 	double *cursor_bw;
-- 
2.43.0

