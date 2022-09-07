Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32341C38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 17:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3113B10E7FE;
	Wed,  7 Sep 2022 17:33:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CAD010E7FE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 17:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSfWZP3MBmA8RFEH6Eh6WRrpD5+jLTVSPCD4KOl0twI4JNmIHbt6AwvWCJooBsRpXW8B3z9Tl3q5peKDEntCoeY58Qa4SaqPIF4skrnjaW1rQzrF3omuDdAQOoIEPt2A5aqiGSgY7mQxXvHZ/UvPwUCjd9fDwE8D9q6YvmfxXnO8LsJ3ZfkTTKtgunyAUigq3SMy1IVGmP/DSFd+2yWtEEBPa1RYLMpVmRTf7H5MbfDC1LNHMX0Q5ObE6GG6/p9YgTNRWdPW6A1yK4oDpA+/3+hKB7bhI1mvRFrbKNIF4BwQCvLdDJaURrXgGPu5MDctiuV44+aYaiutddIapTRgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNnj101mUI/bREJerhTfdTFAEYg7F+Gie/CC2teaQbc=;
 b=O9Qr3OnauBgilKsjb4vw5ardYJyzjIUVGJ9Ivz9w1II38gWG8za9gw2gjpN8Er+PgvrtFX5w4REHVlCty33CKBpOsIW038eE6163MgGOBpctLnEPqeXIygt5zlPG3WmbHnsi6MBU+1KuC+fvHMbj128wagUYep404ehoMxg4ImsodZkO5vg/3ok5QxnRq1zMeoLh2N98f8tD55byPpFg1PjQsL/0n4bOqT80kgn7POXQ7X+/cCtzCZX01X7CezkK87ORqepSkME3H5h8d98elKnmklqtNAe99yBZsZAixx9YFgUZ1MjxIAGZ7FWHfwEDFrfuXov34JXqIIVGdL2GPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNnj101mUI/bREJerhTfdTFAEYg7F+Gie/CC2teaQbc=;
 b=rCAYc1mq+RLl37cQAkN9RmqD4sB5XSqXrrwxopktCEU6nclTpGQ18FTlLuPxl8J/r6ezP/XtBlIcGsD9y9t7mxTqxO/k6PRfWbedJ1+x3lOTTJeW0J7RJihqCEtOlnyHA/0sGI+PDu1gTDoakE1+644+0NA8ocTIOUwd5jnxW+0=
Received: from BN0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:408:ee::28)
 by PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 17:33:20 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::4f) by BN0PR04CA0023.outlook.office365.com
 (2603:10b6:408:ee::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 17:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 17:33:20 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 12:33:18 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/27] drm/amd/display: Optimizations for DML math
Date: Wed, 7 Sep 2022 13:32:07 -0400
Message-ID: <20220907173232.11755-3-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907173232.11755-1-pavle.kotarac@amd.com>
References: <20220907173232.11755-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac22a91-ed47-4142-0be0-08da90f70eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozi3yjKH/KOgm0EYW1SNoygaOnIFhqyMW7Tjj3Dzxh4CXiAXtvFNX0Ala3+ibpocJlcW7QjchbE0KZgBdbnNGmpHWeZyjHIR4ZS/wu5dK6Bsl50IkJjP1mh6TSFUiBswkZfCfinRgzENNNHdZiVJEwTvMuvA0k7ijqHmdyUu5tIsyCcpPzMYsy4rvgR37X0Bnofq6EoyCBhxbdGOWFxKT/Jskl08b2dIozqJ1cvozdpKwvw/6mo8iqc4dKGVi9wFHHkH1ZQrmTXO2ZIcHiR8a5rxKjvyx/rlMlKJu5t5rHbYvM5np2bNrIAN55mefgp7GpLapShfKjKMsCrLrDzpbKf7MamZtrWb3SWiQBchfsmQppIWj8WEpmoRWJbHnXFfC+5bXG5V8GL74WiSFlnFKg5X7y5osh8m0aLHaZY0kF/vlKgycAXCsSZMyljhgZ/DSOdG/kINM8jXxwu1R9+Tf5oZA4pUDgogWwbb9bhy1O/JuyDaIi4cmuWsR/DvVi5Soqd1+5/MlWRE+SKhCiSkiCUK0DL6rQHwH2tV/bFcmDLGWZjALOLsgsZeDzeluu5hEXqNSuS9oBeLi94ImWRrkoI+UxrdYCDMx4rsz1ysLIkoWifMC0NMjZy84dCEiCT18J1hNrHHfgziLbWEWHsNQq1eZaokI13o/yCR4eRYXSYQS40ydsW/CdxQHlGTJFKKP1kMX3oO/9q1xaj78S66FEdkNeEEAhMPIeChk77fVq3hQG0uiR/tkrgyziivsPoVcLqyfeKhuqU0S+FKCjnInDQz5IujjGaw+Me4TBFx8hb4K1qqnEd9+gy7LG/hQQic90S4obz25c41/xUvZaNVEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(36840700001)(40470700004)(46966006)(8676002)(2616005)(8936002)(336012)(356005)(16526019)(426003)(1076003)(186003)(81166007)(26005)(478600001)(30864003)(5660300002)(2906002)(4326008)(44832011)(70206006)(70586007)(36756003)(40480700001)(47076005)(7696005)(86362001)(6666004)(54906003)(41300700001)(36860700001)(40460700003)(6916009)(82310400005)(316002)(82740400003)(83380400001)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 17:33:20.3396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac22a91-ed47-4142-0be0-08da90f70eaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[why]
Conditionals in the DML basic math functions significantly impact mode
enumeration.

[how]
Remove conditionals for floor/ceil operations which are used frequently
in DML and add an assertion for invalid callers using zero granuality.
Fix existing callers that rely on 0 granularity.

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 .../amd/display/dc/dml/calcs/dcn_calc_auto.c  | 22 ++++++-------
 .../amd/display/dc/dml/calcs/dcn_calc_math.c  | 16 +++++-----
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 10 +++---
 .../dc/dml/dcn21/display_mode_vba_21.c        |  6 ++--
 .../dc/dml/dcn30/display_mode_vba_30.c        |  8 ++---
 .../dc/dml/dcn31/display_mode_vba_31.c        |  6 ++--
 .../dc/dml/dcn314/display_mode_vba_314.c      |  6 ++--
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 31 +++++++++----------
 .../dml/dcn32/display_mode_vba_util_32.c.rej  | 12 +++++++
 .../drm/amd/display/dc/dml/dml_inline_defs.h  |  9 ++----
 10 files changed, 65 insertions(+), 61 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c.rej

diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
index 41284e263325..288d22a16cf2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
@@ -526,10 +526,10 @@ void mode_support_and_system_configuration(struct dcn_bw_internal_vars *v)
 				}
 				if (v->max_swath_height_c[k] > 0.0) {
 					v->swath_width_granularity_c = 256.0 /dcn_bw_ceil2(v->byte_per_pixel_in_detc[k], 2.0) / v->max_swath_height_c[k];
-				}
-				v->rounded_up_max_swath_size_bytes_c = (dcn_bw_ceil2(v->swath_width_yper_state[i][j][k] / 2.0 - 1.0, v->swath_width_granularity_c) + v->swath_width_granularity_c) * v->byte_per_pixel_in_detc[k] * v->max_swath_height_c[k];
-				if (v->source_pixel_format[k] == dcn_bw_yuv420_sub_10) {
-					v->rounded_up_max_swath_size_bytes_c =dcn_bw_ceil2(v->rounded_up_max_swath_size_bytes_c, 256.0) + 256;
+					v->rounded_up_max_swath_size_bytes_c = (dcn_bw_ceil2(v->swath_width_yper_state[i][j][k] / 2.0 - 1.0, v->swath_width_granularity_c) + v->swath_width_granularity_c) * v->byte_per_pixel_in_detc[k] * v->max_swath_height_c[k];
+					if (v->source_pixel_format[k] == dcn_bw_yuv420_sub_10) {
+						v->rounded_up_max_swath_size_bytes_c = dcn_bw_ceil2(v->rounded_up_max_swath_size_bytes_c, 256.0) + 256;
+					}
 				}
 				if (v->rounded_up_max_swath_size_bytes_y + v->rounded_up_max_swath_size_bytes_c <= v->det_buffer_size_in_kbyte * 1024.0 / 2.0) {
 					v->swath_height_yper_state[i][j][k] = v->max_swath_height_y[k];
@@ -552,14 +552,14 @@ void mode_support_and_system_configuration(struct dcn_bw_internal_vars *v)
 					v->lines_in_det_chroma = v->det_buffer_size_in_kbyte * 1024.0 / 3.0 / v->byte_per_pixel_in_dety[k] / (v->swath_width_yper_state[i][j][k] / 2.0);
 				}
 				v->effective_lb_latency_hiding_source_lines_luma =dcn_bw_min2(v->max_line_buffer_lines,dcn_bw_floor2(v->line_buffer_size / v->lb_bit_per_pixel[k] / (v->swath_width_yper_state[i][j][k] /dcn_bw_max2(v->h_ratio[k], 1.0)), 1.0)) - (v->vtaps[k] - 1.0);
-				v->effective_lb_latency_hiding_source_lines_chroma =dcn_bw_min2(v->max_line_buffer_lines,dcn_bw_floor2(v->line_buffer_size / v->lb_bit_per_pixel[k] / (v->swath_width_yper_state[i][j][k] / 2.0 /dcn_bw_max2(v->h_ratio[k] / 2.0, 1.0)), 1.0)) - (v->vta_pschroma[k] - 1.0);
 				v->effective_detlb_lines_luma =dcn_bw_floor2(v->lines_in_det_luma +dcn_bw_min2(v->lines_in_det_luma * v->required_dispclk[i][j] * v->byte_per_pixel_in_dety[k] * v->pscl_factor[k] / v->return_bw_per_state[i], v->effective_lb_latency_hiding_source_lines_luma), v->swath_height_yper_state[i][j][k]);
-				v->effective_detlb_lines_chroma =dcn_bw_floor2(v->lines_in_det_chroma +dcn_bw_min2(v->lines_in_det_chroma * v->required_dispclk[i][j] * v->byte_per_pixel_in_detc[k] * v->pscl_factor_chroma[k] / v->return_bw_per_state[i], v->effective_lb_latency_hiding_source_lines_chroma), v->swath_height_cper_state[i][j][k]);
 				if (v->byte_per_pixel_in_detc[k] == 0.0) {
 					v->urgent_latency_support_us_per_state[i][j][k] = v->effective_detlb_lines_luma * (v->htotal[k] / v->pixel_clock[k]) / v->v_ratio[k] - v->effective_detlb_lines_luma * v->swath_width_yper_state[i][j][k] *dcn_bw_ceil2(v->byte_per_pixel_in_dety[k], 1.0) / (v->return_bw_per_state[i] / v->no_of_dpp[i][j][k]);
 				}
 				else {
-					v->urgent_latency_support_us_per_state[i][j][k] =dcn_bw_min2(v->effective_detlb_lines_luma * (v->htotal[k] / v->pixel_clock[k]) / v->v_ratio[k] - v->effective_detlb_lines_luma * v->swath_width_yper_state[i][j][k] *dcn_bw_ceil2(v->byte_per_pixel_in_dety[k], 1.0) / (v->return_bw_per_state[i] / v->no_of_dpp[i][j][k]), v->effective_detlb_lines_chroma * (v->htotal[k] / v->pixel_clock[k]) / (v->v_ratio[k] / 2.0) - v->effective_detlb_lines_chroma * v->swath_width_yper_state[i][j][k] / 2.0 *dcn_bw_ceil2(v->byte_per_pixel_in_detc[k], 2.0) / (v->return_bw_per_state[i] / v->no_of_dpp[i][j][k]));
+					v->effective_lb_latency_hiding_source_lines_chroma = dcn_bw_min2(v->max_line_buffer_lines, dcn_bw_floor2(v->line_buffer_size / v->lb_bit_per_pixel[k] / (v->swath_width_yper_state[i][j][k] / 2.0 / dcn_bw_max2(v->h_ratio[k] / 2.0, 1.0)), 1.0)) - (v->vta_pschroma[k] - 1.0);
+					v->effective_detlb_lines_chroma = dcn_bw_floor2(v->lines_in_det_chroma + dcn_bw_min2(v->lines_in_det_chroma * v->required_dispclk[i][j] * v->byte_per_pixel_in_detc[k] * v->pscl_factor_chroma[k] / v->return_bw_per_state[i], v->effective_lb_latency_hiding_source_lines_chroma), v->swath_height_cper_state[i][j][k]);
+					v->urgent_latency_support_us_per_state[i][j][k] = dcn_bw_min2(v->effective_detlb_lines_luma * (v->htotal[k] / v->pixel_clock[k]) / v->v_ratio[k] - v->effective_detlb_lines_luma * v->swath_width_yper_state[i][j][k] * dcn_bw_ceil2(v->byte_per_pixel_in_dety[k], 1.0) / (v->return_bw_per_state[i] / v->no_of_dpp[i][j][k]), v->effective_detlb_lines_chroma * (v->htotal[k] / v->pixel_clock[k]) / (v->v_ratio[k] / 2.0) - v->effective_detlb_lines_chroma * v->swath_width_yper_state[i][j][k] / 2.0 * dcn_bw_ceil2(v->byte_per_pixel_in_detc[k], 2.0) / (v->return_bw_per_state[i] / v->no_of_dpp[i][j][k]));
 				}
 			}
 		}
@@ -1146,10 +1146,10 @@ void display_pipe_configuration(struct dcn_bw_internal_vars *v)
 		}
 		if (v->maximum_swath_height_c > 0.0) {
 			v->swath_width_granularity_c = 256.0 /dcn_bw_ceil2(v->byte_per_pix_detc, 2.0) / v->maximum_swath_height_c;
-		}
-		v->rounded_up_max_swath_size_bytes_c = (dcn_bw_ceil2(v->swath_width / 2.0 - 1.0, v->swath_width_granularity_c) + v->swath_width_granularity_c) * v->byte_per_pix_detc * v->maximum_swath_height_c;
-		if (v->source_pixel_format[k] == dcn_bw_yuv420_sub_10) {
-			v->rounded_up_max_swath_size_bytes_c =dcn_bw_ceil2(v->rounded_up_max_swath_size_bytes_c, 256.0) + 256;
+			v->rounded_up_max_swath_size_bytes_c = (dcn_bw_ceil2(v->swath_width / 2.0 - 1.0, v->swath_width_granularity_c) + v->swath_width_granularity_c) * v->byte_per_pix_detc * v->maximum_swath_height_c;
+			if (v->source_pixel_format[k] == dcn_bw_yuv420_sub_10) {
+				v->rounded_up_max_swath_size_bytes_c = dcn_bw_ceil2(v->rounded_up_max_swath_size_bytes_c, 256.0) + 256;
+			}
 		}
 		if (v->rounded_up_max_swath_size_bytes_y + v->rounded_up_max_swath_size_bytes_c <= v->det_buffer_size_in_kbyte * 1024.0 / 2.0) {
 			v->swath_height_y[k] = v->maximum_swath_height_y;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
index 07d18e78de49..cac72413a097 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
@@ -23,6 +23,7 @@
  *
  */
 
+#include "os_types.h"
 #include "dcn_calc_math.h"
 
 #define isNaN(number) ((number) != (number))
@@ -69,8 +70,8 @@ float dcn_bw_max2(const float arg1, const float arg2)
 
 float dcn_bw_floor2(const float arg, const float significance)
 {
-	if (significance == 0)
-		return 0;
+	ASSERT(significance != 0);
+
 	return ((int) (arg / significance)) * significance;
 }
 float dcn_bw_floor(const float arg)
@@ -80,17 +81,14 @@ float dcn_bw_floor(const float arg)
 
 float dcn_bw_ceil(const float arg)
 {
-	float flr = dcn_bw_floor2(arg, 1);
-
-	return flr + 0.00001 >= arg ? arg : flr + 1;
+	return (int) (arg + 0.99999);
 }
 
 float dcn_bw_ceil2(const float arg, const float significance)
 {
-	float flr = dcn_bw_floor2(arg, significance);
-	if (significance == 0)
-		return 0;
-	return flr + 0.00001 >= arg ? arg : flr + significance;
+	ASSERT(significance != 0);
+
+	return ((int) (arg / significance + 0.99999)) * significance;
 }
 
 float dcn_bw_max3(float v1, float v2, float v3)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 63bbdf8b8678..edd098c7eb92 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -4478,17 +4478,17 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 						locals->EffectiveLBLatencyHidingSourceLinesLuma),
 						locals->SwathHeightYPerState[i][j][k]);
 
-				locals->EffectiveDETLBLinesChroma = dml_floor(locals->LinesInDETChroma + dml_min(
-						locals->LinesInDETChroma * locals->RequiredDISPCLK[i][j] * locals->BytePerPixelInDETC[k] *
-						locals->PSCL_FACTOR_CHROMA[k] / locals->ReturnBWPerState[i][0],
-						locals->EffectiveLBLatencyHidingSourceLinesChroma),
-						locals->SwathHeightCPerState[i][j][k]);
 
 				if (locals->BytePerPixelInDETC[k] == 0) {
 					locals->UrgentLatencySupportUsPerState[i][j][k] = locals->EffectiveDETLBLinesLuma * (locals->HTotal[k] / locals->PixelClock[k])
 							/ locals->VRatio[k] - locals->EffectiveDETLBLinesLuma * locals->SwathWidthYPerState[i][j][k] *
 								dml_ceil(locals->BytePerPixelInDETY[k], 1) / (locals->ReturnBWPerState[i][0] / locals->NoOfDPP[i][j][k]);
 				} else {
+					locals->EffectiveDETLBLinesChroma = dml_floor(locals->LinesInDETChroma + dml_min(
+							locals->LinesInDETChroma * locals->RequiredDISPCLK[i][j] * locals->BytePerPixelInDETC[k] *
+							locals->PSCL_FACTOR_CHROMA[k] / locals->ReturnBWPerState[i][0],
+							locals->EffectiveLBLatencyHidingSourceLinesChroma),
+							locals->SwathHeightCPerState[i][j][k]);
 					locals->UrgentLatencySupportUsPerState[i][j][k] = dml_min(
 						locals->EffectiveDETLBLinesLuma * (locals->HTotal[k] / locals->PixelClock[k])
 						/ locals->VRatio[k] - locals->EffectiveDETLBLinesLuma * locals->SwathWidthYPerState[i][j][k] *
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 8a7485e21d53..d40d32e380f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -806,10 +806,12 @@ static bool CalculatePrefetchSchedule(
 
 	if (myPipe->SourceScan == dm_horz) {
 		*swath_width_luma_ub = dml_ceil(SwathWidthY - 1, myPipe->BlockWidth256BytesY) + myPipe->BlockWidth256BytesY;
-		*swath_width_chroma_ub = dml_ceil(SwathWidthY / 2 - 1, myPipe->BlockWidth256BytesC) + myPipe->BlockWidth256BytesC;
+		if (myPipe->BlockWidth256BytesC > 0)
+			*swath_width_chroma_ub = dml_ceil(SwathWidthY / 2 - 1, myPipe->BlockWidth256BytesC) + myPipe->BlockWidth256BytesC;
 	} else {
 		*swath_width_luma_ub = dml_ceil(SwathWidthY - 1, myPipe->BlockHeight256BytesY) + myPipe->BlockHeight256BytesY;
-		*swath_width_chroma_ub = dml_ceil(SwathWidthY / 2 - 1, myPipe->BlockHeight256BytesC) + myPipe->BlockHeight256BytesC;
+		if (myPipe->BlockWidth256BytesC > 0)
+			*swath_width_chroma_ub = dml_ceil(SwathWidthY / 2 - 1, myPipe->BlockHeight256BytesC) + myPipe->BlockHeight256BytesC;
 	}
 
 	prefetch_bw_oto = (PrefetchSourceLinesY * *swath_width_luma_ub * dml_ceil(BytePerPixelDETY, 1) + PrefetchSourceLinesC * *swath_width_chroma_ub * dml_ceil(BytePerPixelDETC, 2)) / Tsw_oto;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index b7fa003ffe06..c117a9724ae1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -6322,10 +6322,6 @@ static void CalculateSwathWidth(
 
 	for (k = 0; k < NumberOfActivePlanes; ++k) {
 		enum odm_combine_mode MainPlaneODMCombine = 0;
-		surface_width_ub_l = dml_ceil(SurfaceWidthY[k], Read256BytesBlockWidthY[k]);
-		surface_height_ub_l = dml_ceil(SurfaceHeightY[k], Read256BytesBlockHeightY[k]);
-		surface_width_ub_c = dml_ceil(SurfaceWidthC[k], Read256BytesBlockWidthC[k]);
-		surface_height_ub_c = dml_ceil(SurfaceHeightC[k], Read256BytesBlockHeightC[k]);
 
 		if (SourceScan[k] != dm_vert) {
 			SwathWidthSingleDPPY[k] = ViewportWidth[k];
@@ -6365,8 +6361,6 @@ static void CalculateSwathWidth(
 
 		surface_width_ub_l  = dml_ceil(SurfaceWidthY[k], Read256BytesBlockWidthY[k]);
 		surface_height_ub_l = dml_ceil(SurfaceHeightY[k], Read256BytesBlockHeightY[k]);
-		surface_width_ub_c  = dml_ceil(SurfaceWidthC[k], Read256BytesBlockWidthC[k]);
-		surface_height_ub_c = dml_ceil(SurfaceHeightC[k], Read256BytesBlockHeightC[k]);
 
 		if (SourceScan[k] != dm_vert) {
 			MaximumSwathHeightY[k] = Read256BytesBlockHeightY[k];
@@ -6374,6 +6368,7 @@ static void CalculateSwathWidth(
 			swath_width_luma_ub[k] = dml_min(surface_width_ub_l, (long) dml_ceil(SwathWidthY[k] - 1,
 					Read256BytesBlockWidthY[k]) + Read256BytesBlockWidthY[k]);
 			if (BytePerPixC[k] > 0) {
+				surface_width_ub_c  = dml_ceil(SurfaceWidthC[k], Read256BytesBlockWidthC[k]);
 				swath_width_chroma_ub[k] = dml_min(surface_width_ub_c, (long) dml_ceil(SwathWidthC[k] - 1,
 						Read256BytesBlockWidthC[k]) + Read256BytesBlockWidthC[k]);
 			} else {
@@ -6385,6 +6380,7 @@ static void CalculateSwathWidth(
 			swath_width_luma_ub[k] = dml_min(surface_height_ub_l, (long) dml_ceil(SwathWidthY[k] - 1,
 					Read256BytesBlockHeightY[k]) + Read256BytesBlockHeightY[k]);
 			if (BytePerPixC[k] > 0) {
+				surface_height_ub_c = dml_ceil(SurfaceHeightC[k], Read256BytesBlockHeightC[k]);
 				swath_width_chroma_ub[k] = dml_min(surface_height_ub_c, (long) dml_ceil(SwathWidthC[k] - 1,
 						Read256BytesBlockHeightC[k]) + Read256BytesBlockHeightC[k]);
 			} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index d63b4209b14c..8753f94bdd79 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -6933,8 +6933,6 @@ static void CalculateSwathWidth(
 		{
 		int surface_width_ub_l = dml_ceil(SurfaceWidthY[k], Read256BytesBlockWidthY[k]);
 		int surface_height_ub_l = dml_ceil(SurfaceHeightY[k], Read256BytesBlockHeightY[k]);
-		int surface_width_ub_c = dml_ceil(SurfaceWidthC[k], Read256BytesBlockWidthC[k]);
-		int surface_height_ub_c = dml_ceil(SurfaceHeightC[k], Read256BytesBlockHeightC[k]);
 
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: k=%d surface_width_ub_l=%0d\n", __func__, k, surface_width_ub_l);
@@ -6945,6 +6943,8 @@ static void CalculateSwathWidth(
 			MaximumSwathHeightC[k] = Read256BytesBlockHeightC[k];
 			swath_width_luma_ub[k] = dml_min(surface_width_ub_l, (int) dml_ceil(SwathWidthY[k] - 1, Read256BytesBlockWidthY[k]) + Read256BytesBlockWidthY[k]);
 			if (BytePerPixC[k] > 0) {
+				int surface_width_ub_c = dml_ceil(SurfaceWidthC[k], Read256BytesBlockWidthC[k]);
+
 				swath_width_chroma_ub[k] = dml_min(
 						surface_width_ub_c,
 						(int) dml_ceil(SwathWidthC[k] - 1, Read256BytesBlockWidthC[k]) + Read256BytesBlockWidthC[k]);
@@ -6956,6 +6956,8 @@ static void CalculateSwathWidth(
 			MaximumSwathHeightC[k] = Read256BytesBlockWidthC[k];
 			swath_width_luma_ub[k] = dml_min(surface_height_ub_l, (int) dml_ceil(SwathWidthY[k] - 1, Read256BytesBlockHeightY[k]) + Read256BytesBlockHeightY[k]);
 			if (BytePerPixC[k] > 0) {
+				int surface_height_ub_c = dml_ceil(SurfaceHeightC[k], Read256BytesBlockHeightC[k]);
+
 				swath_width_chroma_ub[k] = dml_min(
 						surface_height_ub_c,
 						(int) dml_ceil(SwathWidthC[k] - 1, Read256BytesBlockHeightC[k]) + Read256BytesBlockHeightC[k]);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index fc4d7474c111..503d9ede0ac1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -7049,8 +7049,6 @@ static void CalculateSwathWidth(
 		{
 		int surface_width_ub_l = dml_ceil(SurfaceWidthY[k], Read256BytesBlockWidthY[k]);
 		int surface_height_ub_l = dml_ceil(SurfaceHeightY[k], Read256BytesBlockHeightY[k]);
-		int surface_width_ub_c = dml_ceil(SurfaceWidthC[k], Read256BytesBlockWidthC[k]);
-		int surface_height_ub_c = dml_ceil(SurfaceHeightC[k], Read256BytesBlockHeightC[k]);
 
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: k=%d surface_width_ub_l=%0d\n", __func__, k, surface_width_ub_l);
@@ -7061,6 +7059,8 @@ static void CalculateSwathWidth(
 			MaximumSwathHeightC[k] = Read256BytesBlockHeightC[k];
 			swath_width_luma_ub[k] = dml_min(surface_width_ub_l, (int) dml_ceil(SwathWidthY[k] - 1, Read256BytesBlockWidthY[k]) + Read256BytesBlockWidthY[k]);
 			if (BytePerPixC[k] > 0) {
+				int surface_width_ub_c = dml_ceil(SurfaceWidthC[k], Read256BytesBlockWidthC[k]);
+
 				swath_width_chroma_ub[k] = dml_min(
 						surface_width_ub_c,
 						(int) dml_ceil(SwathWidthC[k] - 1, Read256BytesBlockWidthC[k]) + Read256BytesBlockWidthC[k]);
@@ -7072,6 +7072,8 @@ static void CalculateSwathWidth(
 			MaximumSwathHeightC[k] = Read256BytesBlockWidthC[k];
 			swath_width_luma_ub[k] = dml_min(surface_height_ub_l, (int) dml_ceil(SwathWidthY[k] - 1, Read256BytesBlockHeightY[k]) + Read256BytesBlockHeightY[k]);
 			if (BytePerPixC[k] > 0) {
+				int surface_height_ub_c = dml_ceil(SurfaceHeightC[k], Read256BytesBlockHeightC[k]);
+
 				swath_width_chroma_ub[k] = dml_min(
 						surface_height_ub_c,
 						(int) dml_ceil(SwathWidthC[k] - 1, Read256BytesBlockHeightC[k]) + Read256BytesBlockHeightC[k]);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index dc501ee7d01a..c385c54832cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -719,8 +719,8 @@ void dml32_CalculateSwathWidth(
 
 	unsigned int surface_width_ub_l;
 	unsigned int surface_height_ub_l;
-	unsigned int surface_width_ub_c;
-	unsigned int surface_height_ub_c;
+	unsigned int surface_width_ub_c = 0;
+	unsigned int surface_height_ub_c = 0;
 
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: ForceSingleDPP = %d\n", __func__, ForceSingleDPP);
@@ -784,21 +784,6 @@ void dml32_CalculateSwathWidth(
 
 		surface_width_ub_l  = dml_ceil(SurfaceWidthY[k], Read256BytesBlockWidthY[k]);
 		surface_height_ub_l = dml_ceil(SurfaceHeightY[k], Read256BytesBlockHeightY[k]);
-		surface_width_ub_c  = dml_ceil(SurfaceWidthC[k], Read256BytesBlockWidthC[k]);
-		surface_height_ub_c = dml_ceil(SurfaceHeightC[k], Read256BytesBlockHeightC[k]);
-
-#ifdef __DML_VBA_DEBUG__
-		dml_print("DML::%s: k=%d surface_width_ub_l=%0d\n", __func__, k, surface_width_ub_l);
-		dml_print("DML::%s: k=%d surface_height_ub_l=%0d\n", __func__, k, surface_height_ub_l);
-		dml_print("DML::%s: k=%d surface_width_ub_c=%0d\n", __func__, k, surface_width_ub_c);
-		dml_print("DML::%s: k=%d surface_height_ub_c=%0d\n", __func__, k, surface_height_ub_c);
-		dml_print("DML::%s: k=%d Read256BytesBlockWidthY=%0d\n", __func__, k, Read256BytesBlockWidthY[k]);
-		dml_print("DML::%s: k=%d Read256BytesBlockHeightY=%0d\n", __func__, k, Read256BytesBlockHeightY[k]);
-		dml_print("DML::%s: k=%d Read256BytesBlockWidthC=%0d\n", __func__, k, Read256BytesBlockWidthC[k]);
-		dml_print("DML::%s: k=%d Read256BytesBlockHeightC=%0d\n", __func__, k, Read256BytesBlockHeightC[k]);
-		dml_print("DML::%s: k=%d ViewportStationary=%0d\n", __func__, k, ViewportStationary[k]);
-		dml_print("DML::%s: k=%d DPPPerSurface=%0d\n", __func__, k, DPPPerSurface[k]);
-#endif
 
 		if (!IsVertical(SourceRotation[k])) {
 			MaximumSwathHeightY[k] = Read256BytesBlockHeightY[k];
@@ -818,6 +803,7 @@ void dml32_CalculateSwathWidth(
 								Read256BytesBlockWidthY[k]);
 			}
 			if (BytePerPixC[k] > 0) {
+				surface_width_ub_c  = dml_ceil(SurfaceWidthC[k], Read256BytesBlockWidthC[k]);
 				if (ViewportStationary[k] && DPPPerSurface[k] == 1) {
 					swath_width_chroma_ub[k] = dml_min(surface_width_ub_c,
 							dml_floor(ViewportXStartC[k] + SwathWidthC[k] +
@@ -848,6 +834,7 @@ void dml32_CalculateSwathWidth(
 						Read256BytesBlockHeightY[k]) + Read256BytesBlockHeightY[k]);
 			}
 			if (BytePerPixC[k] > 0) {
+				surface_height_ub_c = dml_ceil(SurfaceHeightC[k], Read256BytesBlockHeightC[k]);
 				if (ViewportStationary[k] && DPPPerSurface[k] == 1) {
 					swath_width_chroma_ub[k] = dml_min(surface_height_ub_c,
 							dml_floor(ViewportYStartC[k] + SwathWidthC[k] +
@@ -866,6 +853,16 @@ void dml32_CalculateSwathWidth(
 		}
 
 #ifdef __DML_VBA_DEBUG__
+		dml_print("DML::%s: k=%d surface_width_ub_l=%0d\n", __func__, k, surface_width_ub_l);
+		dml_print("DML::%s: k=%d surface_height_ub_l=%0d\n", __func__, k, surface_height_ub_l);
+		dml_print("DML::%s: k=%d surface_width_ub_c=%0d\n", __func__, k, surface_width_ub_c);
+		dml_print("DML::%s: k=%d surface_height_ub_c=%0d\n", __func__, k, surface_height_ub_c);
+		dml_print("DML::%s: k=%d Read256BytesBlockWidthY=%0d\n", __func__, k, Read256BytesBlockWidthY[k]);
+		dml_print("DML::%s: k=%d Read256BytesBlockHeightY=%0d\n", __func__, k, Read256BytesBlockHeightY[k]);
+		dml_print("DML::%s: k=%d Read256BytesBlockWidthC=%0d\n", __func__, k, Read256BytesBlockWidthC[k]);
+		dml_print("DML::%s: k=%d Read256BytesBlockHeightC=%0d\n", __func__, k, Read256BytesBlockHeightC[k]);
+		dml_print("DML::%s: k=%d ViewportStationary=%0d\n", __func__, k, ViewportStationary[k]);
+		dml_print("DML::%s: k=%d DPPPerSurface=%0d\n", __func__, k, DPPPerSurface[k]);
 		dml_print("DML::%s: k=%d swath_width_luma_ub=%0d\n", __func__, k, swath_width_luma_ub[k]);
 		dml_print("DML::%s: k=%d swath_width_chroma_ub=%0d\n", __func__, k, swath_width_chroma_ub[k]);
 		dml_print("DML::%s: k=%d MaximumSwathHeightY=%0d\n", __func__, k, MaximumSwathHeightY[k]);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c.rej b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c.rej
new file mode 100644
index 000000000000..dff2badbf820
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c.rej
@@ -0,0 +1,12 @@
+diff a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c	(rejected hunks)
+@@ -727,8 +727,8 @@ void dml32_CalculateSwathWidth(
+ 	enum odm_combine_mode MainSurfaceODMMode;
+ 	unsigned int surface_width_ub_l;
+ 	unsigned int surface_height_ub_l;
+-	unsigned int surface_width_ub_c;
+-	unsigned int surface_height_ub_c;
++	unsigned int surface_width_ub_c = 0;
++	unsigned int surface_height_ub_c = 0;
+ 	unsigned int k, j;
+ 
+ #ifdef __DML_VBA_DEBUG__
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
index 479d7d83220c..072bd0539605 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
@@ -76,14 +76,9 @@ static inline double dml_floor(double a, double granularity)
 
 static inline double dml_round(double a)
 {
-	double round_pt = 0.5;
-	double ceil = dml_ceil(a, 1);
-	double floor = dml_floor(a, 1);
+	const double round_pt = 0.5;
 
-	if (a - floor >= round_pt)
-		return ceil;
-	else
-		return floor;
+	return dml_floor(a + round_pt, 1);
 }
 
 /* float
-- 
2.34.1

