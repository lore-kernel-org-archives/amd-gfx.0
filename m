Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC574CA6002
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA68510F3B5;
	Wed,  7 Oct 2026 17:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3O6aV4J7";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010034.outbound.protection.outlook.com
 [40.93.198.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 571A410E64A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDwvDlRPDXW9XsesxHWs3iehgb/MKph5K0QbZXw+hpARoWQRuDEyoQHxVjIW7KMYU0EnX6RPtGCk5LU6MKJUe6LDWjxHQJlK7Dgb3IEP1argRm1lsxmCURumhh4yJl8XroStQSUwSgt4CjF+SVPOjTDd3xKdd62kVQX75TOqbr6uuwZjwZGAgtFhYlisk9MC3mkYqp1Ve1V9QTbD7zS8WIMyoyV92wu7/PUiuBvRsdvqvhsX85Jgvjuzq1IfoMy2ZWfBJ9TlxkdrOO9hnShhv+z9z79SUm16bU3EHxBblPo+4A+TJNm85FmSegCed55pTmfZDS+H8nwTNTeJJD2jBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZBUzKEEf4Z2rDAYjOnrsB6T6X9QwuWdTQQDN3rTPEU=;
 b=q+CeftiZTSjuxXoG7aioV8PeSXvqVUWUB15i5SQsQz6JlOZPqNpk7ZYF6nr0DZLIK+sR1hjdYow2ggOe4yxY98hP0FtmQS/ATYZjeFHc4DPWwk0VXl0raRT/H0VOaISQvjsEoecAajf8xze3hjwQLTYiMMgRkT5+sFI5dVftZJPYmI0hFgOub3NezxLi4hdYdglXaupJO4oyO24etobRgBtI7McQ0ZghXegdHUJwS+HtV60WRlVrENqZOBDkfmg1vfWRatOSKQVXI6p8QT0x45VrUiHv4ZzP7dw+40DKsn8uQCEQfwCljeWaonCxsZRYWoIpLwg4VkXRS5FaZgteLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZBUzKEEf4Z2rDAYjOnrsB6T6X9QwuWdTQQDN3rTPEU=;
 b=3O6aV4J7GWnHpu+e6pLHjoOti9d63/zXR3X4fQqlJLWpYI6PnlOdGoUVzqwcqunExqa46bg0A4VSWPgLZrIMSO+Z5DszbOEM2Z0HthUMofZw2AGuKdm2omNOCSr+al0f0YLgr19AZaOqlpyJGlfSyUrT36/rFXqNIZok/n3RBlg=
Received: from YT3PR01CA0124.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:83::33)
 by BN7PPF683A477A9.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 17:04:30 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:b01:83:cafe::52) by YT3PR01CA0124.outlook.office365.com
 (2603:10b6:b01:83::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 17:04:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:26 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:26 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 07/19] drm/amd/display: Fix frac_urg_bw conversion to correct
 U0.10 format
Date: Wed, 7 Oct 2026 12:59:40 -0400
Message-ID: <20261007170412.1898315-8-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|BN7PPF683A477A9:EE_
X-MS-Office365-Filtering-Correlation-Id: cf475722-794b-4f65-8628-08df24950d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|30052699003|36860700016|376014|23010399003|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: Ey9ri0yRicBF4UtdnjNxwVbdDS1CIVu69561R8rlIET1G4qXlvjODMtDqXz+oT3jbWY4jV1ReqtE0C5Zz5uZ74gkuCYa7EUGXD60GdOdzM8UduNGjnC9GJAhiUnNRRDDL02qwiRxW45jJGCMMol5mw2OGL+5n+LFxW5xZKH9/Wgcv6kXphTh3FIdxcZOf1N191bGOZgWWjhYn/GuuHqPmkvHq6u4q2/j9Hb9it5sAZEWcBZ6KfY88jclNXiGlGkq1YQZT6oyrNLk9vRp5I17occAV8OvZsTYfJialdE2GlTeTFEcTnzxMOCFgDcBtR/G964HSnt4g6lur3IZ/HPUCAcV0nxW8F/3gX5/I7Ij7xBExeqhEiWdcdyo82c+9c49+VznaFbBqDDCioEE5GLrGrAtHH8XttNgO+tnWQ/S5W4B4yCLUfA52SyF6kabFvVC6irvWsjbYDIIGfTRIM0NkLOIlEgVgkSouvZFAEi5a9CF7jAlXlJqecupkSqDD0RThvGUkQ1cwFnE+1kqy4xSW7VaR576PhyUYc1sSvj87DU02qgZ6ofq2lbwazU9jb9JLaYMwn075NowDctwrfr4x0eEuxcbMPnGGAwb2lk+1yriGKnR/qGD0DWiN/vwHi95Tyjyay3Z7SDuUcR251pA4N2TAWYMpxsLj31GSGH/c1bn1n8+qwKy1XRSdc+J4uElAGKoMdt4/MzcupB2X+ZVcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(30052699003)(36860700016)(376014)(23010399003)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tQuLyFGzJA+jAiepZtjizu1+qgyfaWRtVc26y7ZjjNhBqBs6T3QzSLZ1qrxYIBYjDyxVMUHUuv41jcT4DdVI6A8eVgHZEmIbQyNclR5hJyGoet9t+SWtRkONsM4kDdIIaVtnlHGXVv1eJk0xEkcUQNamQUkG+fynURMLJtzowo2wQLnbHrUTs8c2Hy2VzsKILQoKkqMzsSrB/jzQ9UtYfiIjQ/+TQKCC66KwRv+52mvlMOPvQ/oJcURya11w1auo2nfgYNP/WAi8HOO8ufkVD3iJOggejW3SgVVGpcYcZ5ArW1GtoYZ6jCcho92ZxXYhPmPCm1jIs7pu1ksC+Qd1Fw75XmV5+gEI/tjLB8gykVVCDGNO5Sl2enD0AZn6sCsuXekIVjR7wna2lao+n9w20M/R9y9M2f/3KqO7/Nb4V3SULYX/hULWupZUYzcBZ0nF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:29.7761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf475722-794b-4f65-8628-08df24950d16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF683A477A9
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why * how]
DCHUBBUB_ARB_FRAC_URG_BW_* registers only have 10 programmable bits that are formatted in
U0.10 fixed point. Multiplying the fraction by 1000 is incorrect, and understates the
fraction by 2.34%.

Rounding or truncating is not correct either since it can cut off 0.1% of the fraction
which has direct implications on the assumed deadlines and TTU, albeit minor.

Scale the fraction by the correct 1024 value, use ceiling to ensure the assumed fraction is
maintained, and clamp to 1023 since the register field is only 10 bits wide.
Clamping from 1024 -> 1023 only impacts modes at > 99.9% fractions.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  7 ++++---
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |  5 +++--
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |  5 +++--
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      | 20 ++++++++++---------
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn5.c      | 13 ++++++------
 5 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 2d43a35c4c42..a4a77e375d9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -12315,6 +12315,7 @@ static unsigned int dml_get_plane_idx(const struct dml2_core_internal_display_mo
 static void rq_dlg_get_wm_regs(const struct dml2_display_cfg *display_cfg, const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_dchub_watermark_regs *wm_regs)
 {
 	double refclk_freq_in_mhz = (display_cfg->overrides.hw.dlg_ref_clk_mhz > 0) ? (double)display_cfg->overrides.hw.dlg_ref_clk_mhz : mode_lib->soc.dchub_refclk_mhz;
+	unsigned int u0_10_fixed_point_scale = 1U << 10;
 
 	wm_regs->fclk_pstate = (unsigned int)(mode_lib->mp.Watermark.FCLKChangeWatermark * refclk_freq_in_mhz);
 	wm_regs->sr_enter = (unsigned int)(mode_lib->mp.Watermark.StutterEnterPlusExitWatermark * refclk_freq_in_mhz);
@@ -12327,9 +12328,9 @@ static void rq_dlg_get_wm_regs(const struct dml2_display_cfg *display_cfg, const
 	wm_regs->usr = (unsigned int)(mode_lib->mp.Watermark.USRRetrainingWatermark * refclk_freq_in_mhz);
 	wm_regs->refcyc_per_trip_to_mem = (unsigned int)(mode_lib->mp.UrgentLatency * refclk_freq_in_mhz);
 	wm_regs->refcyc_per_meta_trip_to_mem = (unsigned int)(mode_lib->mp.MetaTripToMemory * refclk_freq_in_mhz);
-	wm_regs->frac_urg_bw_flip = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * 1000);
-	wm_regs->frac_urg_bw_nom = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidth * 1000);
-	wm_regs->frac_urg_bw_mall = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthMALL * 1000);
+	wm_regs->frac_urg_bw_flip = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
+	wm_regs->frac_urg_bw_nom = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidth * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
+	wm_regs->frac_urg_bw_mall = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidthMALL * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
 }
 
 static unsigned int log_and_substract_if_non_zero(unsigned int a, unsigned int subtrahend)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
index f407afefb37f..262b8e098343 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
@@ -5344,6 +5344,7 @@ void dcn5_adjust_pixel_clock_for_progressive_to_interlace_unit(const struct dml2
 static void dcn5_rq_dlg_get_wm_regs(const struct dml2_display_cfg *display_cfg, const struct dml2_core_internal_display_mode_lib *mode_lib, const struct dml2_utm_soc_bb *utm_soc_bb, struct dml2_dchub_watermark_regs *wm_regs)
 {
 	double refclk_freq_in_mhz = (display_cfg->overrides.hw.dlg_ref_clk_mhz > 0) ? (double)display_cfg->overrides.hw.dlg_ref_clk_mhz : utm_soc_bb->dchub_refclk_mhz;
+	unsigned int u0_10_fixed_point_scale = 1U << 10;
 
 	wm_regs->fclk_pstate = (int unsigned)(mode_lib->mp.Watermark.FCLKChangeWatermark * refclk_freq_in_mhz);
 	wm_regs->sr_enter = (int unsigned)(mode_lib->mp.Watermark.StutterEnterPlusExitWatermark * refclk_freq_in_mhz);
@@ -5356,8 +5357,8 @@ static void dcn5_rq_dlg_get_wm_regs(const struct dml2_display_cfg *display_cfg,
 	wm_regs->usr = (int unsigned)(mode_lib->mp.Watermark.USRRetrainingWatermark * refclk_freq_in_mhz);
 	wm_regs->refcyc_per_trip_to_mem = (unsigned int)(mode_lib->mp.UrgentLatency * refclk_freq_in_mhz);
 	wm_regs->refcyc_per_meta_trip_to_mem = (unsigned int)(mode_lib->mp.MetaTripToMemory * refclk_freq_in_mhz);
-	wm_regs->frac_urg_bw_flip = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * 1000);
-	wm_regs->frac_urg_bw_nom = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidth * 1000);
+	wm_regs->frac_urg_bw_flip = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
+	wm_regs->frac_urg_bw_nom = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidth * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
 }
 
 void dcn5_get_mcif_arb_params(const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_mcif_global_register_set *out)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
index 6ad41846a73a..ce6eb94230c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
@@ -1059,6 +1059,7 @@ static void dcn6_rq_dlg_get_dlg_reg(
 static void dcn6_rq_dlg_get_wm_regs(const struct dml2_display_cfg *display_cfg, const struct dml2_core_internal_display_mode_lib *mode_lib, const struct dml2_utm_soc_bb *utm_soc_bb, struct dml2_dchub_watermark_regs *wm_regs)
 {
 	double refclk_freq_in_mhz = (display_cfg->overrides.hw.dlg_ref_clk_mhz > 0) ? (double)display_cfg->overrides.hw.dlg_ref_clk_mhz : utm_soc_bb->dchub_refclk_mhz;
+	unsigned int u0_10_fixed_point_scale = 1U << 10;
 
 	wm_regs->fclk_pstate = (int unsigned)(mode_lib->mp.Watermark.FCLKChangeWatermark * refclk_freq_in_mhz);
 	wm_regs->sr_enter = (int unsigned)(mode_lib->mp.Watermark.StutterEnterPlusExitWatermark * refclk_freq_in_mhz);
@@ -1074,8 +1075,8 @@ static void dcn6_rq_dlg_get_wm_regs(const struct dml2_display_cfg *display_cfg,
 	wm_regs->usr = (int unsigned)(mode_lib->mp.Watermark.USRRetrainingWatermark * refclk_freq_in_mhz);
 	wm_regs->refcyc_per_trip_to_mem = (unsigned int)(mode_lib->mp.UrgentLatency * refclk_freq_in_mhz);
 	wm_regs->refcyc_per_meta_trip_to_mem = (unsigned int)(mode_lib->mp.MetaTripToMemory * refclk_freq_in_mhz);
-	wm_regs->frac_urg_bw_flip = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * 1000);
-	wm_regs->frac_urg_bw_nom = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidth * 1000);
+	wm_regs->frac_urg_bw_flip = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
+	wm_regs->frac_urg_bw_nom = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidth * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
 }
 
 void dcn6_get_pipe_regs(const struct dml2_display_cfg *display_cfg,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
index 54a1f9c13dbf..7fa50ccfcfd1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
@@ -898,6 +898,7 @@ bool dpmm_dcn4_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_
 	struct dml2_dchub_global_register_set *dchubbub_regs = &in_out->programming->global_regs;
 
 	double refclk_freq_in_mhz = (display_cfg->overrides.hw.dlg_ref_clk_mhz > 0) ? (double)display_cfg->overrides.hw.dlg_ref_clk_mhz : mode_lib->soc.dchub_refclk_mhz;
+	unsigned int u0_10_fixed_point_scale = 1U << 10;
 
 	/* set A */
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].fclk_pstate = (int unsigned)(mode_lib->mp.Watermark.FCLKChangeWatermark * refclk_freq_in_mhz);
@@ -911,9 +912,9 @@ bool dpmm_dcn4_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].usr = (int unsigned)(mode_lib->mp.Watermark.USRRetrainingWatermark * refclk_freq_in_mhz);
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].refcyc_per_trip_to_mem = (unsigned int)(mode_lib->mp.Watermark.UrgentWatermark * refclk_freq_in_mhz);
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].refcyc_per_meta_trip_to_mem = (unsigned int)(mode_lib->mp.Watermark.UrgentWatermark * refclk_freq_in_mhz);
-	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_flip = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * 1000);
-	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_nom = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidth * 1000);
-	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_mall = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthMALL * 1000);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_flip = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_nom = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidth * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_mall = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidthMALL * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
 
 	/* set B */
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].fclk_pstate = (int unsigned)(mode_lib->mp.Watermark.FCLKChangeWatermark * refclk_freq_in_mhz);
@@ -927,9 +928,9 @@ bool dpmm_dcn4_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].usr = (int unsigned)(mode_lib->mp.Watermark.USRRetrainingWatermark * refclk_freq_in_mhz);
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].refcyc_per_trip_to_mem = (unsigned int)(mode_lib->mp.Watermark.UrgentWatermark * refclk_freq_in_mhz);
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].refcyc_per_meta_trip_to_mem = (unsigned int)(mode_lib->mp.Watermark.UrgentWatermark * refclk_freq_in_mhz);
-	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].frac_urg_bw_flip = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * 1000);
-	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].frac_urg_bw_nom = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidth * 1000);
-	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].frac_urg_bw_mall = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthMALL * 1000);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].frac_urg_bw_flip = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].frac_urg_bw_nom = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidth * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].frac_urg_bw_mall = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidthMALL * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
 
 	dchubbub_regs->num_watermark_sets = 2;
 
@@ -944,6 +945,7 @@ bool dpmm_dcn42_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in
 	struct dml2_dchub_global_register_set *dchubbub_regs = &in_out->programming->global_regs;
 
 	double refclk_freq_in_mhz = (display_cfg->overrides.hw.dlg_ref_clk_mhz > 0) ? (double)display_cfg->overrides.hw.dlg_ref_clk_mhz : mode_lib->soc.dchub_refclk_mhz;
+	unsigned int u0_10_fixed_point_scale = 1U << 10;
 
 	/* set A */
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].fclk_pstate = (int unsigned)(mode_lib->mp.Watermark.FCLKChangeWatermark * refclk_freq_in_mhz);
@@ -957,9 +959,9 @@ bool dpmm_dcn42_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].usr = (int unsigned)(mode_lib->mp.Watermark.USRRetrainingWatermark * refclk_freq_in_mhz);
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].refcyc_per_trip_to_mem = (unsigned int)(mode_lib->mp.Watermark.UrgentWatermark * refclk_freq_in_mhz);
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].refcyc_per_meta_trip_to_mem = (unsigned int)(mode_lib->mp.Watermark.UrgentWatermark * refclk_freq_in_mhz);
-	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_flip = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * 1000);
-	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_nom = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidth * 1000);
-	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_mall = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthMALL * 1000);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_flip = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_nom = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidth * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_mall = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidthMALL * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
 
 	/* set B */
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B] = dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A];
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn5.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn5.c
index f6230f8f9127..e607d763f5a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn5.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn5.c
@@ -397,6 +397,7 @@ bool dpmm_dcn5_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_
 	struct dml2_mcif_global_register_set *mcif_regs = &in_out->programming->mcif_global_regs;
 
 	double refclk_freq_in_mhz = (display_cfg->overrides.hw.dlg_ref_clk_mhz > 0) ? (double)display_cfg->overrides.hw.dlg_ref_clk_mhz : in_out->core->utm_soc_bb->dchub_refclk_mhz;
+	unsigned int u0_10_fixed_point_scale = 1U << 10;
 
 	/* set A */
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].fclk_pstate = (int unsigned)(mode_lib->mp.Watermark.FCLKChangeWatermark * refclk_freq_in_mhz);
@@ -410,9 +411,9 @@ bool dpmm_dcn5_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].usr = (int unsigned)(mode_lib->mp.Watermark.USRRetrainingWatermark * refclk_freq_in_mhz);
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].refcyc_per_trip_to_mem = (unsigned int)(mode_lib->mp.Watermark.UrgentWatermark * refclk_freq_in_mhz);
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].refcyc_per_meta_trip_to_mem = (unsigned int)(mode_lib->mp.Watermark.UrgentWatermark * refclk_freq_in_mhz);
-	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_flip = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * 1000);
-	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_nom = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidth * 1000);
-	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_mall = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthMALL * 1000);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_flip = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_nom = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidth * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_A].frac_urg_bw_mall = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidthMALL * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
 
 	/* set B */
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].fclk_pstate = (int unsigned)(mode_lib->mp.Watermark.FCLKChangeWatermark * refclk_freq_in_mhz);
@@ -426,9 +427,9 @@ bool dpmm_dcn5_map_watermarks(struct dml2_dpmm_map_watermarks_params_in_out *in_
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].usr = (int unsigned)(mode_lib->mp.Watermark.USRRetrainingWatermark * refclk_freq_in_mhz);
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].refcyc_per_trip_to_mem = (unsigned int)(mode_lib->mp.Watermark.UrgentWatermark * refclk_freq_in_mhz);
 	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].refcyc_per_meta_trip_to_mem = (unsigned int)(mode_lib->mp.Watermark.UrgentWatermark * refclk_freq_in_mhz);
-	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].frac_urg_bw_flip = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * 1000);
-	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].frac_urg_bw_nom = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidth * 1000);
-	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].frac_urg_bw_mall = (unsigned int)(mode_lib->mp.FractionOfUrgentBandwidthMALL * 1000);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].frac_urg_bw_flip = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidthImmediateFlip * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].frac_urg_bw_nom = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidth * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
+	dchubbub_regs->wm_regs[DML2_DCHUB_WATERMARK_SET_B].frac_urg_bw_mall = (unsigned int)math_min2(math_ceil(mode_lib->mp.FractionOfUrgentBandwidthMALL * u0_10_fixed_point_scale), u0_10_fixed_point_scale - 1);
 
 	dchubbub_regs->num_watermark_sets = 2;
 
-- 
2.43.0

