Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59C5CA6007
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5262D10F6FC;
	Wed,  7 Oct 2026 17:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2rSRVASo";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F9CF10F701
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLcHAJeQa5tNviI5tOop/jZzKvIxOPVjawn0gXJlDllx89z5CqbpWzhEhpUK67+A1yqTEb20Xj8CyNZASahMCACvImPICELUEsmZS2VfU8tq1KyzZcowDLwmdy2JYpaRs/Ug2YWKCYUjUm7bJb6LayTpAUpf2M3o2NXKb2EuM1SkKUwFQcNaesKrwYMMvcen1RjYlvUIqhnTvokWKxysQ/zDpaKcmolivovdwCL5UFjdqZbt7YicZcC5Botx/JVsI5Vik4jml4rj4y33x55pKr+DmMeUqM4QFxh4CHcFSsJig6BXZN1ZawSPGKG1QwrqXFIzmiDu+m+tFbp7gcPrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWFLsT4hq6v6vyN7FBlA6XpUOCYq3Yg7Stv9xWaa4nw=;
 b=Rf2iEkojwkEHTbg/olglfpRL+kTGeF7qGzp3JjuvfoogPL2ei7GuIznhRyo8M7T8m4DYHwtKVcpphCTBfj0i98KJ/7nRu7TRrknrg9cfUF8Ybh7Q9u3G85XP55WIjQaBHgCEIOCCTUnSP92mLkx+Izjz53ZL0Nj4ELbnSvAxt+7WOnzZMfd1kdXcSunUM4975LEUoRDDgc2egirlLDQWL0N739ZjyIqaJ1+bzlheiZCZx3KHDBnDx/1x9PgtkmZv7VrcQ/yy2XZYbEttZWDfAJsElyvd8E7Wg0BBMilmlz61g1Rtq0//PLHLa0N6oAzDRofbmNSe06dmY1VToDSxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWFLsT4hq6v6vyN7FBlA6XpUOCYq3Yg7Stv9xWaa4nw=;
 b=2rSRVASoOwSaAI+xAJZUNdqPrqMEhcfPeJ3ukWzTAlY/SRqwitLy5lxiBfHmsxAZq+QUKbwAF6SFNmTmZh8b1r/E57W36bJmTmFuMfXVXRvQl8G9+HLwcbyb+FBB40C5tEdzwPFQM1X89AWanWARglcEF33miVxX0xQb34Ugds8=
Received: from MW3PR06CA0005.namprd06.prod.outlook.com (2603:10b6:303:2a::10)
 by CH8PR12MB9792.namprd12.prod.outlook.com (2603:10b6:610:2b5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 17:04:40 +0000
Received: from MW1PEPF00018892.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::aa) by MW3PR06CA0005.outlook.office365.com
 (2603:10b6:303:2a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 17:04:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00018892.mail.protection.outlook.com (10.167.249.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:33 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:33 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Austin Zheng
 <austin.zheng@amd.com>
Subject: [PATCH 16/19] drm/amd/display: Improve mandatory pstate optimization
 and check
Date: Wed, 7 Oct 2026 12:59:49 -0400
Message-ID: <20261007170412.1898315-17-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018892:EE_|CH8PR12MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: 649b113d-94d2-40dc-e3fa-08df249512e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: U+IieHW9V3qzqtQ9zHLoPKPI2FdokTLnNOgZYnA7AC178ouBSKrai+lZt8LZZR69ropAmVtt+DCpmVoD9CjEXwH2LMiwMnjCr6iWXCJ0JAl1HwtVTGvl6WJpKExvEiNqhvWqD/d47N2KJ06LLCWJCXpZlOQ5k4LRYMjzO639Xenr1a+riGbP3Q27oKd0EsJRXOy0uvxh2TezX3V8Z+nv/+5nL2fBm6rjyVFHDLeEo8ZcKyEUCFMyj6DqdEUk0kBx8TPlRSrPJ6FQX/Z1hesl0mevhzjcZkT7nVYdDMUhEy3ElraTOLrxUlNhMDy2e67dvYn79nGH+n8qOXFq3Aivvt0RDd1AJdWMe0Jt/PWXYP//ud4v7jF/RWYyxqr/Qnn6P1Uf6nIcvqvs4D4XmUbDEeUchy8TgrhuCX99CLb1A2p6VWz9LnG7ri7SCKJjYZZlmTsmgRdL+nM8Q1sLTnCtGyyEy2dE1IPV2jRuoDn/9q9+Pf+PiqOiAo2EFB4BMdNyOaAlh5QUzINcQvdppQ+TezVb2HTqn8xTx0XETuuauG3suUHIJGKGUZeR2DTZTb0oFSp968dFRQfbvqyX/9wlZi/j0IkyAOPFzUi5abf4P19uCYbsk2GSHQcn4RpCO1NAdYcTmwrbvFXuhOhrdW7u+iEvOLvi/Z5BipWkPizeUo2r6TDTdK9UxUrh0QcvRykdaw81xC+ZtmdwsQO8lC3wBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b90i9KzgkgV2QmYWle53iE0lNmFOVrbA97zOGrhhpXhJyuKJY24sTZZRrY4Nqs4hFwqe0d5sLH3Ml52x9Y8OrgTvMeLT27khNOLGXvakCBDLH4O/GQGkV/apRUtxp8ns0SCtaleC1RdTWGj5vZixtvese9nZ9N4Z+Uizy+iAwBuw93gn0kf97h59/yRK55bMlfz9bQ2Fa9XcR1EujasPnQq9hFGE0PHfDvAccSP78/WIhVTmzadR3NGY38YAg9gffSYOUMaW6YRqekLUJopNRgnpwpTMBE9x77d0647KZQjcDbjBbIvH33pS7MkynlsIFKD+XltjZEsFX1phyyVSgSmyLCB/p8AYjUU1N9qr7oMzOC8Zhu0GFGGwEadQjK6zaOZ/+JaTyjjFqX5bBJeVBP35WLRDfrAiyOmcQrK4Iypko5mALIOF98uEACHDvUYQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:39.4456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649b113d-94d2-40dc-e3fa-08df249512e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00018892.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9792
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Improves the optimization heuristic for "ideal" disallow time to clamp
to a number more likely to pass the mandatory pstate checks.

Fixes core calculations to account for reserved time when considering
the allow time for mandatory pstate checks.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |  5 +-
 .../dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c | 97 +++++++++++--------
 .../src/inc/dml2_internal_shared_types.h      |  2 +-
 3 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
index ce6eb94230c1..485ad96f64b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
@@ -1753,8 +1753,9 @@ void dcn6_calculate_pstate_schedule_windows(
 		det_fill_delay_otg_vlines = (int)(math_ceil(det_fill_delay_us[k] / otg_vline_time_us[k]));
 		reserved_vblank_otg_vlines = (int)(math_ceil(reserved_vblank_us[k] / otg_vline_time_us[k]));
 
-		allow_start_otg_vlines = v_blank_end[k] + det_fill_delay_otg_vlines;
-		allow_end_otg_vlines = v_blank_start[k] - (blackout_otg_vlines - reserved_vblank_otg_vlines);
+		/* for vactive only, make relative to vblank end */
+		allow_start_otg_vlines = det_fill_delay_otg_vlines;
+		allow_end_otg_vlines = v_blank_start[k] - v_blank_end[k] - (blackout_otg_vlines - reserved_vblank_otg_vlines);
 
 		/* Convert them back to time since the start of a frame */
 		allow_start_us[k] = allow_start_otg_vlines * otg_vline_time_us[k];
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c
index 6d6611a6b5a6..40dcaa6588ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c
@@ -407,14 +407,20 @@ static bool dcn6_update_worksheet_for_pstate_admissibility(struct dml2_optimizat
 		enum dml2_pstate_type pstate_type)
 {
 	const double vblank_ratio = 0.8;
-	unsigned int plane_index, stream_index;
-	double ideal_relative_disallow, ideal_disallow_time_us, disallow_time_us;
+	const double min_vblank_unreserved_ratio = 0.15;
+	const double min_vblank_unreserved_time_us = 50.0;
+	// min reserved for prefetch + 1 line lost for max vstartup
+	const unsigned int min_vblank_unreserved_otg_vlines = 4 + 1;
+
+	unsigned int plane_index, stream_index, stream_index1;
+	double ideal_disallow_time_us, disallow_time_us;
 	double extra_time_required_us;
 	double vblank_time_us;
 	double min_unreserved_vblank_time_us;
 	double min_det_fill_delay_us;
 	double delta_max_det_fill_delay_us;
 	double delta_reserved_vblank_time_us;
+	double smallest_allow_us;
 
 	int max_vactive_det_fill_delay_us;
 	long reserved_vblank_time_ns;
@@ -428,54 +434,67 @@ static bool dcn6_update_worksheet_for_pstate_admissibility(struct dml2_optimizat
 	 * configs failing pstate admissibility tend to have a large vblank to vactive ratio.
 	 */
 
-	ideal_relative_disallow = 1.0;
-	if (display_config->num_streams > 1) {
-		/* The disallow region should be less than (0.5) ^ (number of displays - 1) * total frame time
-		* Calculation assumes identical displays / timings when performing the scheduling check
-		* Make the relative disallow 5% smaller than the ideal case to add extra margin
-		*/
-		ideal_relative_disallow = (double)math_pow(0.5, (float)(display_config->num_streams - 1)) * 0.95;
-	}
-
 	for (stream_index = 0; stream_index < display_config->num_streams; stream_index++) {
 		disallow_time_us = per_stream_pstate_meta[stream_index].method_vactive.common.disallow_time_us;
-		ideal_disallow_time_us = per_stream_pstate_meta[stream_index].method_vactive.common.period_us * ideal_relative_disallow;
+		ideal_disallow_time_us = disallow_time_us;
+
+		/* find the smallest active to build the heurisitic for ideal disallow */
+		smallest_allow_us = 0.0;
+		for (stream_index1 = 0; stream_index1 < display_config->num_streams; stream_index1++) {
+			if (stream_index != stream_index1 &&
+					(smallest_allow_us == 0.0 ||
+					per_stream_pstate_meta[stream_index1].method_vactive.common.allow_time_us < smallest_allow_us)) {
+				smallest_allow_us = per_stream_pstate_meta[stream_index1].method_vactive.common.allow_time_us;
+			}
+		}
 
-		extra_time_required_us = 0.0;
 		delta_max_det_fill_delay_us = 0.0;
 		delta_reserved_vblank_time_us = 0.0;
-		if (disallow_time_us > ideal_disallow_time_us) {
-			/* minimum unreserved 15% of blank, or 50us left over for prefetch */
-			vblank_time_us = display_config->stream_descriptors[stream_index].timing.vblank_nom *
+		if (worksheet->fclk_ppt_temp_read_pstate.index > 0) {
+			if (smallest_allow_us > 0.0 && display_config->num_streams > 1) {
+				ideal_disallow_time_us = smallest_allow_us / math_pow(2.0, (float)display_config->num_streams - 2) *
+					(1.0 / (2.0 - math_pow(2.0, (float)(2 - display_config->num_streams))));
+			}
+
+			extra_time_required_us = 0.0;
+			delta_max_det_fill_delay_us = 0.0;
+			delta_reserved_vblank_time_us = 0.0;
+			if (disallow_time_us > ideal_disallow_time_us) {
+				/* minimum unreserved 15% of blank, or 50us left over for prefetch */
+				vblank_time_us = display_config->stream_descriptors[stream_index].timing.vblank_nom *
 					per_stream_pstate_meta[stream_index].otg_vline_time_us;
-			min_unreserved_vblank_time_us = math_min2(vblank_time_us * 0.15, 50);
+				min_unreserved_vblank_time_us = math_max2(
+					per_stream_pstate_meta[stream_index].otg_vline_time_us * min_vblank_unreserved_otg_vlines,
+					math_min2(vblank_time_us * min_vblank_unreserved_ratio,
+						min_vblank_unreserved_time_us));
 
-			/* minmum of blackout time (~2x VActive bandwidth) */
-			min_det_fill_delay_us = per_stream_pstate_meta[stream_index].blackout_otg_vlines *
+				/* minmum of blackout time (~2x VActive bandwidth) */
+				min_det_fill_delay_us = per_stream_pstate_meta[stream_index].blackout_otg_vlines *
 					per_stream_pstate_meta[stream_index].otg_vline_time_us;
 
-			extra_time_required_us = disallow_time_us - ideal_disallow_time_us;
+				extra_time_required_us = disallow_time_us - ideal_disallow_time_us;
 
-			/* try compressing VActive fill first */
-			delta_max_det_fill_delay_us = math_min2(extra_time_required_us * (1.0 - vblank_ratio),
+				/* try compressing VActive fill first */
+				delta_max_det_fill_delay_us = math_min2(extra_time_required_us * (1.0 - vblank_ratio),
 					math_max2(0.0,
-					per_stream_pstate_meta[stream_index].method_vactive.max_vactive_det_fill_delay_us - min_det_fill_delay_us));
-			delta_max_det_fill_delay_us = math_floor2(delta_max_det_fill_delay_us, per_stream_pstate_meta[stream_index].otg_vline_time_us);
-			extra_time_required_us -= delta_max_det_fill_delay_us;
+						per_stream_pstate_meta[stream_index].method_vactive.max_vactive_det_fill_delay_us - min_det_fill_delay_us));
+				delta_max_det_fill_delay_us = math_floor2(delta_max_det_fill_delay_us, per_stream_pstate_meta[stream_index].otg_vline_time_us);
+				extra_time_required_us -= delta_max_det_fill_delay_us;
 
-			/* try reserving VBlank */
-			delta_reserved_vblank_time_us = math_min2(extra_time_required_us,
+				/* try reserving VBlank */
+				delta_reserved_vblank_time_us = math_min2(extra_time_required_us,
 					math_max2(0.0,
-					vblank_time_us - per_stream_pstate_meta[stream_index].method_vactive.reserved_vblank_required_us - min_unreserved_vblank_time_us));
-			delta_reserved_vblank_time_us = math_floor2(delta_reserved_vblank_time_us, per_stream_pstate_meta[stream_index].otg_vline_time_us);
-			extra_time_required_us -= delta_reserved_vblank_time_us;
+						vblank_time_us - per_stream_pstate_meta[stream_index].method_vactive.reserved_vblank_required_us - min_unreserved_vblank_time_us));
+				delta_reserved_vblank_time_us = math_floor2(delta_reserved_vblank_time_us, per_stream_pstate_meta[stream_index].otg_vline_time_us);
+				extra_time_required_us -= delta_reserved_vblank_time_us;
 
-			if (extra_time_required_us > 0.0 &&
+				if (extra_time_required_us > 0.0 &&
 					per_stream_pstate_meta[stream_index].method_vactive.max_vactive_det_fill_delay_us > math_ceil2(delta_max_det_fill_delay_us + extra_time_required_us, per_stream_pstate_meta[stream_index].otg_vline_time_us)) {
-				/* final attempt to compress fill time */
-				delta_max_det_fill_delay_us = delta_max_det_fill_delay_us + extra_time_required_us;
-				delta_max_det_fill_delay_us = math_ceil2(delta_max_det_fill_delay_us, per_stream_pstate_meta[stream_index].otg_vline_time_us);
-				extra_time_required_us = 0.0;
+					/* final attempt to compress fill time */
+					delta_max_det_fill_delay_us = delta_max_det_fill_delay_us + extra_time_required_us;
+					delta_max_det_fill_delay_us = math_ceil2(delta_max_det_fill_delay_us, per_stream_pstate_meta[stream_index].otg_vline_time_us);
+					extra_time_required_us = 0.0;
+				}
 			}
 		}
 
@@ -1688,7 +1707,7 @@ static void dml2_pmo_dcn6_stage_optimizer_fclk_ppt_temp_read_pstate_init(
 		struct dml2_pmo_stage_optimizer *stage, struct dml2_optimization_worksheet *worksheet)
 {
 	DML_LOG_COMP_IF_ENTER();
-	worksheet->fclk_ppt_temp_read_pstate.is_attempted = false;
+	worksheet->fclk_ppt_temp_read_pstate.index = 0;
 	memset(&stage->func_locals->fclk_ppt_temp_read_pstate_optimize, 0,
 			sizeof(struct dml2_stage_optimizer_fclk_ppt_temp_read_pstate_optimize_locals));
 	DML_LOG_COMP_IF_EXIT();
@@ -1712,13 +1731,11 @@ static bool dml2_pmo_dcn6_stage_optimizer_fclk_ppt_temp_read_pstate_optimize_nex
 
 	DML_LOG_COMP_IF_ENTER();
 
-	if (worksheet->fclk_ppt_temp_read_pstate.is_attempted) {
+	if (worksheet->fclk_ppt_temp_read_pstate.index >= 2) {
 		DML_LOG_COMP_IF_EXIT();
 		return false;
 	}
 
-	worksheet->fclk_ppt_temp_read_pstate.is_attempted = true;
-
 	if (display_config->overrides.all_streams_blanked)
 		goto exit;
 
@@ -1761,6 +1778,8 @@ static bool dml2_pmo_dcn6_stage_optimizer_fclk_ppt_temp_read_pstate_optimize_nex
 		}
 	}
 
+	worksheet->fclk_ppt_temp_read_pstate.index++;
+
 exit:
 	DML_LOG_DEBUG("%s exit with should_continue = %s\n", __func__, modified ? "true" : "false");
 	DML_LOG_COMP_IF_EXIT();
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
index dc9d4be9d7f7..6f527760071c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
@@ -643,7 +643,7 @@ struct dml2_optimization_worksheet {
 	} dcfclk_vmin;
 
 	struct {
-		bool is_attempted;
+		unsigned int index;
 	} fclk_ppt_temp_read_pstate;
 
 	/*
-- 
2.43.0

