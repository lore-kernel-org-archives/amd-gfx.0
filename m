Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42012CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 15:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A548710E29E;
	Tue, 12 May 2026 15:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uJtvZjF1";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90CB810E294
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 15:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOI/429h9yue6NB/EIiugaoumKmlNVQv36/b3kQuVm7n2BYud/0/EJLV5TzsmLeorF3Ly6teh1S8CF5m7JqKazBCez5R+DftVS1RLHHxz+TQHbD+5tUoUcmj3I54EF1LTni/Y1YU0M6HlsoGErsB9LW0f5/4mACDD2MN2mdTlMkhKQluOE3j1F9t8IJmsaDj8aztsF89gfpRqISsGBsMieeOiMNf5i9W6NJ4NPZ90ckipnFyJrWML1NowQ/eCu9CZapEb9Lde5H3FQol1j5xYP+YVlF/e03HbcsvchQa6o0/PrSKnhNrTwiq5986jKa9+26J0Vn/00Q94lhI1FHMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t04CTeJrax4DKXs0YYS/VBiADE107ktYiQJvNeNQC+w=;
 b=e7KEggEjH6/9a7AS93ieXpqumcW4fD3hdbtiNMfjKlg/ZsJ3/8F99u3XEZUFtBIEzlKkbnCAednPRRB0dcR7fyNwj9z1Pz5eG9YnD37rMzuxxFMhpCq3RxPu3NuDGB3OhoCrolq2UGT/3Ncipca6FQNfeRgDkBITQrYim8CWfO+8D5TOsW21GpbvnGyQ9eRZStocuOwNFBAKH6qZbOtMtaJT9HJrH1OOEu3OlTTp2nYOl7vFhBt2eGcL7zyxKp+XEzc12Q7WFk0DwGnVax3ldZNhXBUV2Wkdey9KuWkpUAezfZRo4w1XSIXnoiXRaKvenyR8XfmB4ehTvJcuUSPXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t04CTeJrax4DKXs0YYS/VBiADE107ktYiQJvNeNQC+w=;
 b=uJtvZjF1ZYPnyoHC8OZAwICg51SZgiTu07/8hh9XJlZIjoKffOl9E6SgijZNAiJ5b0v8g6ApX9bebs1s1+iw8KENS4f/l8g+LQSMZZaHxBrk+zE5NNp5j0sAFjkXDkIRaaWBkQ/0+GO8mOB/prVmkayzjrecPFZVrSherocm/xM=
Received: from BN0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:408:e6::23)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 15:52:49 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::af) by BN0PR03CA0018.outlook.office365.com
 (2603:10b6:408:e6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 15:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 15:52:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 12 May
 2026 10:52:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 May
 2026 10:52:48 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 10:52:47 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v5 02/13] drm/amd/display: Add DML changes to support HDMI FRL
Date: Tue, 12 May 2026 11:52:33 -0400
Message-ID: <20260512155244.403854-3-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512155244.403854-1-harry.wentland@amd.com>
References: <20260512155244.403854-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cda526-d8dc-4b50-ab9d-08deb03e847d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|22082099003|11063799003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: m59oRUSKnsRt+q6kI11Dkvy9vDmYDRZ3HQsxD73gf9WnnD5KKvdfx1Juspp2BAUZGcBc0dTKzIJjegf/S8Soi+4JsXVGk3THIiRT0PffOHZDs8YOZ4egKcqyaS/HGpuIPkNHzLjCGol6ihCf3svX7UeKtfu75e6vb6tsr7behQAS/GxkTQ6Y6tmLOIuDoVz2S6EXwWHAf9cPV65W43AUUEBH+e3JIBP6oqD+C5tBffO+Ej3Ch1JKkiFXAZRbRFWg641xwaBPyjFaaQOQQBEx5//VEhlLXs+lAcAey8ad4q3v9Hx/ASPRa6iDeZevkbShC8LsOFH9CZQRTi0b1bTYVK+5AX/QBGxnYZcfGUoYWgVbD1FtDUDAf1o7mSquxBkSks1rsWCPsUuoMIH7eqIYUrSr4qPipfAecLdN5rpNGaZURJGzz+uJ52z5KktPVV+l20nOGeNM7QUjpdAment+8eX9EVgINh+EonFKm7VONoZjT/o1GM7kS2r65OnDfV9HD/1lAia65saynQ2wVd7zHT+NIXdlnlT5SSwAr1h+j6U1KyAiccUUwxsXv27Lqii+xcWf/C5KUiSDdibVDkpTICg//6SmwFMHRGxZCcpPNYSd1hkRwlgSe1jB9Q7QfS4hsicmhInrDkYGrU/BhGZrqZnT9WWbQVNWwiiCfsXlU0BW4Cv1m3RXf5NOOyp/hDACVBmgrthaGE1lpuTeD1CxEWm7d/olwNIG5tgiia4CTn4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(22082099003)(11063799003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OFmW2M4xc4lEWf3JTNwFH1bhH6f/GnN3WBVoAD9ZTgFhMDOxRMVl4m7EuXd/MHv0+97wqCQVIBWluHSsvLvFxTgZL459rrD8LVY1Whpac0plCcATSjoqD/Vg8jv2Udg3EUVzXz05pTdX5yLTS15qyyDVYA2g7RydspVZMEEJPjpKfDbmlOAv2y3U7pGCbblbxXlm6/axEY3vm4y7NVLcTu8gKH0SLhML/HIGVVlOwQ9Qe0dhdCYZDeD7eGCa2ezdaOmIX4o7LH2cyg0d0BIdNjw4XUNbcqrM8r7D/miLu4t+WaKAd9bwl4GvXbFrvN+Qrhtc77bEQ26velmHeTid05LV48iJDiwf3+tj0rTvXDDfqyh3uS7Hjf9LeHwr4+vyOMZ5EykgFJkN8fmAyuik8TBSEoVatulQUuEy5qAe1Vz+cGxR02atO75QFUiKssXh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:52:49.0039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cda526-d8dc-4b50-ab9d-08deb03e847d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092
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

This adds DML support for HDMI FRL.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   3 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   5 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  89 +++
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |  22 +
 .../dc/dml/dcn30/display_mode_vba_30.c        | 277 +++++++-
 .../amd/display/dc/dml/dcn302/dcn302_fpu.c    |   1 +
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |   1 +
 .../dc/dml/dcn31/display_mode_vba_31.c        | 240 +++++++
 .../dc/dml/dcn314/display_mode_vba_314.c      | 238 +++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  10 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   2 +
 .../dc/dml/dcn32/display_mode_vba_32.c        |  16 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 124 +++-
 .../amd/display/dc/dml/display_mode_enums.h   |   1 +
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.c | 589 ++++++++++++++++++
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.h |   9 -
 16 files changed, 1612 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 268b5fbdb48b..10d4ace04d4f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -78,6 +78,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) -Wno-tautological-compare
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dml1_frl_cap_chk.o := $(dml_ccflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_rcflags)
@@ -117,9 +118,11 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_frl_cap_chk.o := $(dml_rcflags)
 
 ifdef CONFIG_DRM_AMD_DC_FP
 DML += display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o
+DML += dml1_frl_cap_chk.o
 DML += dcn10/dcn10_fpu.o
 DML += dcn20/dcn20_fpu.o
 DML += display_mode_vba.o dcn20/display_rq_dlg_calc_20.o dcn20/display_mode_vba_20.o
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index ed7c989a5b13..5f088d113b9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1049,6 +1049,8 @@ static bool is_dtbclk_required(struct dc *dc, struct dc_state *context)
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
+		if (dc_is_hdmi_frl_signal(context->res_ctx.pipe_ctx[i].stream->signal))
+			return true;
 		if (dc->link_srv->dp_is_128b_132b_signal(&context->res_ctx.pipe_ctx[i]))
 			return true;
 	}
@@ -1467,6 +1469,9 @@ int dcn20_populate_dml_pipes_from_context(struct dc *dc,
 		case SIGNAL_TYPE_DVI_DUAL_LINK:
 			pipes[pipe_cnt].dout.output_type = dm_hdmi;
 			break;
+		case SIGNAL_TYPE_HDMI_FRL:
+			pipes[pipe_cnt].dout.output_type = dm_hdmifrl;
+			break;
 		default:
 			/* In case there is no signal, set dp with 4 lanes to allow max config */
 			pipes[pipe_cnt].dout.is_virtual = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index 0ba388c6aec1..a690324f78dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -33,6 +33,8 @@
 #include "display_mode_vba_30.h"
 #include "dcn30_fpu.h"
 
+#include "../dml1_frl_cap_chk.h"
+
 #define REG(reg)\
 	optc1->tg_regs->reg
 
@@ -131,6 +133,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc = {
 				.phyclk_mhz = 300.0,
 				.phyclk_d18_mhz = 667.0,
 				.dscclk_mhz = 405.6,
+				.dtbclk_mhz = 1217.0,
 			},
 		},
 
@@ -741,3 +744,89 @@ void patch_dcn30_soc_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_bo
 		}
 	}
 }
+
+#undef DC_LOGGER
+#define DC_LOGGER \
+		enc3->base.ctx->logger
+
+#define hdmi_frl_print(str, ...) {DC_LOG_HDMI_FRL(str, ##__VA_ARGS__); }
+
+#define DEBUG_FRL_CAP_CHK 1
+
+void hpo_fpu_enc3_validate_hdmi_frl_output_link(struct hpo_frl_stream_encoder *enc,
+						struct dc_hdmi_frl_link_settings *frl_link_settings,
+						struct frl_cap_chk_params *frl_params,
+						const struct dc_crtc_timing *timing,
+						unsigned int dsc_max_rate)
+{
+	(void)enc;
+	dc_assert_fp_enabled();
+
+	switch (frl_link_settings->frl_link_rate) {
+	case HDMI_FRL_LINK_RATE_3GBPS:
+		frl_params->r_bit_nominal = 3.0e9;
+		break;
+	case HDMI_FRL_LINK_RATE_6GBPS:
+	case HDMI_FRL_LINK_RATE_6GBPS_4LANE:
+		frl_params->r_bit_nominal = 6.0e9;
+		break;
+	case HDMI_FRL_LINK_RATE_8GBPS:
+		frl_params->r_bit_nominal = 8.0e9;
+		break;
+	case HDMI_FRL_LINK_RATE_10GBPS:
+	default:
+		frl_params->r_bit_nominal = 10.0e9;
+		break;
+	case HDMI_FRL_LINK_RATE_12GBPS:
+		frl_params->r_bit_nominal = 12.0e9;
+		break;
+	}
+
+	frl_params->f_pixel_clock_nominal = (double)timing->pix_clk_100hz * 100;
+	frl_params->h_active = timing->h_addressable + timing->h_border_left + timing->h_border_right;
+	frl_params->h_blank = timing->h_total - frl_params->h_active;
+	frl_params->vic = timing->vic;
+}
+
+void hpo_fpu_enc3_validate_hdmi_frl_output_timing(
+		const struct dc_crtc_timing *timing,
+		const struct audio_check *audio,
+		struct frl_cap_chk_params *frl_params)
+{
+	dc_assert_fp_enabled();
+
+	if (timing->flags.DSC) {
+		frl_params->compressed = true;
+	} else {
+		frl_params->compressed = false;
+	}
+
+	frl_params->audio_packet_type = audio->audio_packet_type;
+	frl_params->f_audio = audio->max_audiosample_rate;
+	frl_params->acat = audio->acat;
+}
+
+enum frl_cap_chk_result frl_fpu_cap_chk_common(struct hpo_frl_stream_encoder *enc,
+					       struct frl_cap_chk_intermediates *inter,
+					       struct frl_cap_chk_params *params)
+{
+	(void)enc;
+	return dml1_frl_cap_chk_common(inter, params);
+}
+
+
+enum frl_cap_chk_result frl_fpu_cap_chk_uncompressed(struct hpo_frl_stream_encoder *enc,
+						     struct frl_cap_chk_params *params,
+						     struct frl_cap_chk_intermediates *inter)
+{
+	(void)enc;
+	return dml1_frl_cap_chk_uncompressed(params, inter);
+}
+
+enum frl_cap_chk_result frl_fpu_cap_chk_compressed(struct hpo_frl_stream_encoder *enc,
+						   struct frl_cap_chk_params *params,
+						   struct frl_cap_chk_intermediates *inter)
+{
+	(void)enc;
+	return -5;
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
index e3b6ad6a8784..e3a46915d168 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
@@ -70,4 +70,26 @@ void dcn3_fpu_build_wm_range_table(struct clk_mgr *base);
 
 void patch_dcn30_soc_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *dcn3_0_ip);
 
+void hpo_fpu_enc3_validate_hdmi_frl_output_link(struct hpo_frl_stream_encoder *enc,
+						struct dc_hdmi_frl_link_settings *frl_link_settings,
+						struct frl_cap_chk_params *frl_params,
+						const struct dc_crtc_timing *timing,
+						unsigned int dsc_max_rate);
+
+void hpo_fpu_enc3_validate_hdmi_frl_output_timing(const struct dc_crtc_timing *timing,
+						  const struct audio_check *audio,
+						  struct frl_cap_chk_params *frl_params);
+
+enum frl_cap_chk_result frl_fpu_cap_chk_common(struct hpo_frl_stream_encoder *enc,
+					       struct frl_cap_chk_intermediates *inter,
+					       struct frl_cap_chk_params *params);
+
+enum frl_cap_chk_result frl_fpu_cap_chk_uncompressed(struct hpo_frl_stream_encoder *enc,
+						     struct frl_cap_chk_params *params,
+						     struct frl_cap_chk_intermediates *inter);
+
+enum frl_cap_chk_result frl_fpu_cap_chk_compressed(struct hpo_frl_stream_encoder *enc,
+						   struct frl_cap_chk_params *params,
+						   struct frl_cap_chk_intermediates *inter);
+
 #endif /* __DCN30_FPU_H__*/
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index f0b1bfb408f6..2a309e86f60f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -28,6 +28,8 @@
 #include "display_mode_vba_30.h"
 #include "../dml_inline_defs.h"
 
+#include "../dml1_frl_cap_chk.h"
+
 
 /*
  * NOTE:
@@ -324,6 +326,17 @@ static void CalculateUrgentBurstFactor(
 		double *UrgentBurstFactorChroma,
 		bool *NotEnoughUrgentLatencyHiding);
 
+static double RequiredDTBCLK(
+		bool DSCEnable,
+		double PixelClock,
+		enum output_format_class OutputFormat,
+		double OutputBPP,
+		int DSCSlices,
+		long HTotal,
+		long HActive,
+		int AudioRate,
+		int AudioLayoutSingle);
+
 static void UseMinimumDCFCLK(
 		struct display_mode_lib *mode_lib,
 		struct vba_vars_st *v,
@@ -626,6 +639,8 @@ static unsigned int dscceComputeDelay(
 		pixelsPerClock = 1;
 	else if (pixelFormat == dm_n422)
 		pixelsPerClock = 2;
+	else if (Output == dm_hdmifrl)
+		pixelsPerClock = 2;
 	else
 		pixelsPerClock = 1;
 
@@ -646,6 +661,8 @@ static unsigned int dscceComputeDelay(
 	//422 mode has an additional cycle of delay
 	if (pixelFormat == dm_420 || pixelFormat == dm_444 || pixelFormat == dm_n422)
 		s = 0;
+	else if (Output == dm_hdmifrl)
+		s = 0;
 	else
 		s = 1;
 
@@ -716,6 +733,25 @@ static unsigned int dscComputeDelay(enum output_format_class pixelFormat, enum o
 		Delay = Delay + 1;
 		//   sft
 		Delay = Delay + 1;
+	} else if (Output == dm_hdmifrl && pixelFormat != dm_444) {
+		//   sfr
+		Delay = Delay + 2;
+		//   dsccif
+		Delay = Delay + 1;
+		//   dscc - input deserializer
+		Delay = Delay + 5;
+		//  dscc - input cdc fifo
+		Delay = Delay + 25;
+		//   dscc - cdc uncertainty
+		Delay = Delay + 2;
+		//   dscc - output cdc fifo
+		Delay = Delay + 10;
+		//   dscc - cdc uncertainty
+		Delay = Delay + 2;
+		//   dscc - output serializer
+		Delay = Delay + 1;
+		//   sft
+		Delay = Delay + 1;
 	} else {
 		//   sfr
 		Delay = Delay + 2;
@@ -2017,6 +2053,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				v->DSCFormatFactor = 1;
 			else if (v->OutputFormat[k] == dm_n422)
 				v->DSCFormatFactor = 2;
+			else if (v->Output[k] == dm_hdmifrl)
+				v->DSCFormatFactor = 2;
 			else
 				v->DSCFormatFactor = 1;
 			if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_4to1)
@@ -3309,19 +3347,38 @@ static double TruncToValidBPP(
 	int NonDSCBPP1 = 0;
 	int NonDSCBPP2 = 0;
 
+	enum frl_cap_chk_result hdmifrlresult = { 0 };
+	struct frl_cap_chk_params hdmifrlparams = { 0 };
+	struct frl_cap_chk_intermediates hdmifrlinter = { 0 };
+
+	hdmifrlparams.lanes = Lanes;
+	hdmifrlparams.f_pixel_clock_nominal = PixelClock * 1000000;
+	hdmifrlparams.r_bit_nominal = LinkBitRate * 1000000;
+	hdmifrlparams.layout = AudioLayout;
+	hdmifrlparams.f_audio = AudioRate * 1000;
+	hdmifrlparams.h_active = HActive;
+	hdmifrlparams.h_blank = HTotal - HActive;
+	hdmifrlparams.compressed = DSCEnable;
+
 	if (Format == dm_420) {
 		NonDSCBPP0 = 12;
 		NonDSCBPP1 = 15;
 		NonDSCBPP2 = 18;
 		MinDSCBPP = 6;
 		MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1.0 / 16;
+		hdmifrlparams.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_420;
+		hdmifrlparams.bpc = (int)(DesiredBPP * 2 / 3);
 	} else if (Format == dm_444) {
 		NonDSCBPP0 = 24;
 		NonDSCBPP1 = 30;
 		NonDSCBPP2 = 36;
 		MinDSCBPP = 8;
 		MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16;
+		hdmifrlparams.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_444;
+	    hdmifrlparams.bpc = (int)(DesiredBPP / 3);
 	} else {
+		hdmifrlparams.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_422;
+	    hdmifrlparams.bpc = (int)(DesiredBPP / 2);
 		NonDSCBPP0 = 16;
 		NonDSCBPP1 = 20;
 		NonDSCBPP2 = 24;
@@ -3329,12 +3386,20 @@ static double TruncToValidBPP(
 		if (Format == dm_n422) {
 			MinDSCBPP = 7;
 			MaxDSCBPP = 2 * DSCInputBitPerComponent - 1.0 / 16.0;
+		} else if (Output == dm_hdmifrl) {
+			MinDSCBPP = 7;
+			MaxDSCBPP = 2 * DSCInputBitPerComponent - 1.0 / 16.0;
 		} else {
 			MinDSCBPP = 8;
 			MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16.0;
 		}
 	}
 
+	if (Output == dm_hdmifrl) {
+		hdmifrlresult = dml1_frl_cap_chk_inter(&hdmifrlparams, &hdmifrlinter);
+		MaxLinkBPP = (1 - hdmifrlinter.overhead_max) * dml_min(hdmifrlinter.r_frl_char_min * 16 * Lanes / hdmifrlinter.f_pixel_clock_max + 24 * TB_BORROWED_MAX / HActive,
+				(hdmifrlinter.r_frl_char_min * 16 * Lanes / hdmifrlinter.f_pixel_clock_max * HTotal - 16 * hdmifrlinter.blank_audio_min) / HActive);
+	} else
 	if (DSCEnable && Output == dm_dp) {
 		MaxLinkBPP = LinkBitRate / 10 * 8 * Lanes / PixelClock * (1 - 2.4 / 100);
 	} else {
@@ -3372,6 +3437,8 @@ static double TruncToValidBPP(
 		if (!((DSCEnable == false && (DesiredBPP == NonDSCBPP2 || DesiredBPP == NonDSCBPP1 || DesiredBPP == NonDSCBPP0 || DesiredBPP == 18)) ||
 				(DSCEnable && DesiredBPP >= MinDSCBPP && DesiredBPP <= MaxDSCBPP))) {
 			return BPP_INVALID;
+		} else if ((Output == dm_hdmifrl && hdmifrlresult != FRL_CAP_CHK_OK) || (Output != dm_hdmifrl && MaxLinkBPP < DesiredBPP)) {
+			return BPP_INVALID;
 		} else {
 			return DesiredBPP;
 		}
@@ -4013,6 +4080,172 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						// TODO: Need some other way to handle this nonsense
 						// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR3"
 					}
+				} else if (v->Output[k] == dm_hdmifrl) {
+					if (v->DSCEnable[k] == true || v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1) {
+						v->RequiresDSC[i][k] = true;
+						v->LinkDSCEnable = true;
+						v->RequiresFEC[i][k] = true;
+					} else {
+						v->RequiresDSC[i][k] = false;
+						v->LinkDSCEnable = false;
+						v->RequiresFEC[i][k] = false;
+					}
+					v->Outbpp = BPP_INVALID;
+					if (v->PHYCLKD18PerState[i] >= 3000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								3000,
+								3,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "3x3";
+					}
+					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 6000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								6000,
+								3,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "6x3";
+					}
+					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 6000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								6000,
+								4,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "6x4";
+					}
+					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 8000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								8000,
+								4,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState(i, k) = v->Output[k] & "8x4";
+					}
+					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 10000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								10000,
+								4,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						if (v->Outbpp == BPP_INVALID && v->ForcedOutputLinkBPP[k] == 0
+								&& v->PHYCLKD18PerState[i] < 12000.0 / 18) {
+							v->RequiresDSC[i][k] = true;
+							v->LinkDSCEnable = true;
+							v->RequiresFEC[i][k] = true;
+							v->Outbpp = TruncToValidBPP(
+									10000,
+									4,
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+						}
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "10x4";
+					}
+					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 12000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								12000,
+								4,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						if (v->Outbpp == BPP_INVALID && v->ForcedOutputLinkBPP[k] == 0) {
+							v->RequiresDSC[i][k] = true;
+							v->LinkDSCEnable = true;
+							v->RequiresFEC[i][k] = true;
+							v->Outbpp = TruncToValidBPP(
+									12000,
+									4,
+									v->HTotal[k],
+									v->HActive[k],
+									v->PixelClockBackEnd[k],
+									v->ForcedOutputLinkBPP[k],
+									v->LinkDSCEnable,
+									v->Output[k],
+									v->OutputFormat[k],
+									v->DSCInputBitPerComponent[k],
+									v->NumberOfDSCSlices[k],
+									v->AudioSampleRate[k],
+									v->AudioSampleLayout[k],
+									v->ODMCombineEnablePerState[i][k]);
+						}
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "12x4";
+					}
 				}
 			} else {
 				v->OutputBppPerState[i][k] = 0;
@@ -4022,7 +4255,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	for (i = start_state; i < v->soc.num_states; i++) {
 		v->DIOSupport[i] = true;
 		for (k = 0; k <= v->NumberOfActivePlanes - 1; k++) {
-			if (!v->skip_dio_check[k] && v->BlendingAndTiming[k] == k && (v->Output[k] == dm_dp || v->Output[k] == dm_edp || v->Output[k] == dm_hdmi)
+			if (!v->skip_dio_check[k] && v->BlendingAndTiming[k] == k && (v->Output[k] == dm_dp || v->Output[k] == dm_edp || v->Output[k] == dm_hdmi || v->Output[k] == dm_hdmifrl)
 					&& (v->OutputBppPerState[i][k] == 0
 							|| (v->OutputFormat[k] == dm_420 && v->Interlace[k] == true && v->ProgressiveToInterlaceUnitInOPP == true))) {
 				v->DIOSupport[i] = false;
@@ -4030,6 +4263,25 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
+	for (i = start_state; i < v->soc.num_states; ++i) {
+		v->DTBCLKRequiredMoreThanSupported[i] = false;
+		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
+			if (v->BlendingAndTiming[k] == k && v->Output[k] == dm_hdmifrl
+					&& RequiredDTBCLK(
+							v->RequiresDSC[i][k],
+							v->PixelClockBackEnd[k],
+							v->OutputFormat[k],
+							v->OutputBppPerState[i][k],
+							v->NumberOfDSCSlices[k],
+							v->HTotal[k],
+							v->HActive[k],
+							v->AudioSampleRate[k],
+							v->AudioSampleLayout[k]) > v->DTBCLKPerState[i]) {
+				v->DTBCLKRequiredMoreThanSupported[i] = true;
+			}
+		}
+	}
+
 	for (i = start_state; i < v->soc.num_states; ++i) {
 		v->ODMCombine4To1SupportCheckOK[i] = true;
 		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
@@ -6248,6 +6500,29 @@ static double CalculateUrgentLatency(
 	return ret;
 }
 
+static double RequiredDTBCLK(
+		bool DSCEnable,
+		double PixelClock,
+		enum output_format_class OutputFormat,
+		double OutputBPP,
+		int DSCSlices,
+		long HTotal,
+		long HActive,
+		int AudioRate,
+		int AudioLayout)
+{
+	if (DSCEnable != true) {
+		return dml_max(PixelClock / 4.0 * OutputBPP / 24.0, 25.0);
+	} else {
+		double PixelWordRate = PixelClock /  (OutputFormat == dm_444 ? 1 : 2);
+		double HCActive = dml_ceil(DSCSlices * dml_ceil(OutputBPP * dml_ceil(HActive / DSCSlices, 1) / 8.0, 1) / 3.0, 1);
+		double HCBlank = 64 + 32 * dml_ceil((double)AudioRate * (AudioLayout == 1 ? 1.0 : 0.25) * HTotal / (PixelClock * 1000), 1);
+		double AverageTribyteRate = PixelWordRate * (HCActive + HCBlank) / HTotal;
+		double HActiveTribyteRate = PixelWordRate * HCActive / HActive;
+		return dml_max4(PixelWordRate / 4.0, AverageTribyteRate / 4.0, HActiveTribyteRate / 4.0, 25.0) * 1.002;
+	}
+}
+
 static noinline_for_stack void UseMinimumDCFCLK(
 		struct display_mode_lib *mode_lib,
 		struct vba_vars_st *v,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
index 90a7b29ebe74..781bc429807f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
@@ -119,6 +119,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc = {
 						.phyclk_mhz = 300.0,
 						.phyclk_d18_mhz = 667.0,
 						.dscclk_mhz = 405.6,
+						.dtbclk_mhz = 1217.0,
 				},
 		},
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
index e42419c7868d..e6d7d67f06a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
@@ -118,6 +118,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_03_soc = {
 						.phyclk_mhz = 300.0,
 						.phyclk_d18_mhz = 667.0,
 						.dscclk_mhz = 405.6,
+						.dtbclk_mhz = 1217.0,
 				},
 		},
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index f9224a433220..261d90aaa3ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -29,6 +29,8 @@
 #include "display_mode_vba_31.h"
 #include "../dml_inline_defs.h"
 
+#include "../dml1_frl_cap_chk.h"
+
 /*
  * NOTE:
  *   This file is gcc-parsable HW gospel, coming straight from HW engineers.
@@ -357,6 +359,17 @@ static void CalculateUrgentBurstFactor(
 		double *UrgentBurstFactorChroma,
 		bool *NotEnoughUrgentLatencyHiding);
 
+static double RequiredDTBCLK(
+		bool DSCEnable,
+		double PixelClock,
+		enum output_format_class OutputFormat,
+		double OutputBPP,
+		int DSCSlices,
+		int HTotal,
+		int HActive,
+		int AudioRate,
+		int AudioLayoutSingle);
+
 static void UseMinimumDCFCLK(
 		struct display_mode_lib *mode_lib,
 		int MaxPrefetchMode,
@@ -695,6 +708,8 @@ static unsigned int dscceComputeDelay(
 		pixelsPerClock = 1;
 	else if (pixelFormat == dm_n422)
 		pixelsPerClock = 2;
+	else if (Output == dm_hdmifrl)
+		pixelsPerClock = 2;
 	// #all other modes operate at 1 pixel per clock
 	else
 		pixelsPerClock = 1;
@@ -716,6 +731,8 @@ static unsigned int dscceComputeDelay(
 	//422 mode has an additional cycle of delay
 	if (pixelFormat == dm_420 || pixelFormat == dm_444 || pixelFormat == dm_n422)
 		s = 0;
+	else if (Output == dm_hdmifrl)
+		s = 0;
 	else
 		s = 1;
 
@@ -786,6 +803,25 @@ static unsigned int dscComputeDelay(enum output_format_class pixelFormat, enum o
 		Delay = Delay + 1;
 		//   sft
 		Delay = Delay + 1;
+	} else if (Output == dm_hdmifrl && pixelFormat != dm_444) {
+		//   sfr
+		Delay = Delay + 2;
+		//   dsccif
+		Delay = Delay + 1;
+		//   dscc - input deserializer
+		Delay = Delay + 5;
+		//  dscc - input cdc fifo
+		Delay = Delay + 25;
+		//   dscc - cdc uncertainty
+		Delay = Delay + 2;
+		//   dscc - output cdc fifo
+		Delay = Delay + 10;
+		//   dscc - cdc uncertainty
+		Delay = Delay + 2;
+		//   dscc - output serializer
+		Delay = Delay + 1;
+		//   sft
+		Delay = Delay + 1;
 	} else {
 		//   sfr
 		Delay = Delay + 2;
@@ -2243,6 +2279,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				v->DSCFormatFactor = 1;
 			else if (v->OutputFormat[k] == dm_n422)
 				v->DSCFormatFactor = 2;
+			else if (v->Output[k] == dm_hdmifrl)
+				v->DSCFormatFactor = 2;
 			else
 				v->DSCFormatFactor = 1;
 			if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_4to1)
@@ -3615,19 +3653,38 @@ static double TruncToValidBPP(
 	int NonDSCBPP1;
 	int NonDSCBPP2;
 
+	enum frl_cap_chk_result hdmifrlresult = FRL_CAP_CHK_OK;
+	struct frl_cap_chk_params hdmifrlparams = { 0 };
+	struct frl_cap_chk_intermediates hdmifrlinter = { 0 };
+
+	hdmifrlparams.lanes = Lanes;
+	hdmifrlparams.f_pixel_clock_nominal = PixelClock * 1000000;
+	hdmifrlparams.r_bit_nominal = LinkBitRate * 1000000;
+	hdmifrlparams.layout = AudioLayout;
+	hdmifrlparams.f_audio = AudioRate * 1000;
+	hdmifrlparams.h_active = HActive;
+	hdmifrlparams.h_blank = HTotal - HActive;
+	hdmifrlparams.compressed = DSCEnable;
+
 	if (Format == dm_420) {
 		NonDSCBPP0 = 12;
 		NonDSCBPP1 = 15;
 		NonDSCBPP2 = 18;
 		MinDSCBPP = 6;
 		MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1.0 / 16;
+		hdmifrlparams.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_420;
+		hdmifrlparams.bpc = (int)(DesiredBPP * 2 / 3);
 	} else if (Format == dm_444) {
 		NonDSCBPP0 = 24;
 		NonDSCBPP1 = 30;
 		NonDSCBPP2 = 36;
 		MinDSCBPP = 8;
 		MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16;
+		hdmifrlparams.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_444;
+	    hdmifrlparams.bpc = (int)(DesiredBPP / 3);
 	} else {
+		hdmifrlparams.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_422;
+	    hdmifrlparams.bpc = (int)(DesiredBPP / 2);
 
 		NonDSCBPP0 = 16;
 		NonDSCBPP1 = 20;
@@ -3636,12 +3693,22 @@ static double TruncToValidBPP(
 		if (Format == dm_n422) {
 			MinDSCBPP = 7;
 			MaxDSCBPP = 2 * DSCInputBitPerComponent - 1.0 / 16.0;
+		} else if (Output == dm_hdmifrl) {
+			MinDSCBPP = 7;
+			MaxDSCBPP = 2 * DSCInputBitPerComponent - 1.0 / 16.0;
 		} else {
 			MinDSCBPP = 8;
 			MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16.0;
 		}
 	}
 
+	if (Output == dm_hdmifrl) {
+		hdmifrlresult = dml1_frl_cap_chk_inter(&hdmifrlparams, &hdmifrlinter);
+		MaxLinkBPP = (1 - hdmifrlinter.overhead_max)
+				* dml_min(
+						hdmifrlinter.r_frl_char_min * 16 * Lanes / hdmifrlinter.f_pixel_clock_max + 24 * TB_BORROWED_MAX / HActive,
+						(hdmifrlinter.r_frl_char_min * 16 * Lanes / hdmifrlinter.f_pixel_clock_max * HTotal - 16 * hdmifrlinter.blank_audio_min) / HActive);
+	} else
 	if (DSCEnable && Output == dm_dp) {
 		MaxLinkBPP = LinkBitRate / 10 * 8 * Lanes / PixelClock * (1 - 2.4 / 100);
 	} else {
@@ -3678,6 +3745,8 @@ static double TruncToValidBPP(
 		if (!((DSCEnable == false && (DesiredBPP == NonDSCBPP2 || DesiredBPP == NonDSCBPP1 || DesiredBPP <= NonDSCBPP0))
 				|| (DSCEnable && DesiredBPP >= MinDSCBPP && DesiredBPP <= MaxDSCBPP))) {
 			return BPP_INVALID;
+		} else if ((Output == dm_hdmifrl && hdmifrlresult != FRL_CAP_CHK_OK) || (Output != dm_hdmifrl && MaxLinkBPP < DesiredBPP)) {
+			return BPP_INVALID;
 		} else {
 			return DesiredBPP;
 		}
@@ -4105,6 +4174,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 				if (v->ODMCombinePolicy == dm_odm_combine_policy_none
 						|| !(v->Output[k] == dm_dp ||
+						     v->Output[k] == dm_hdmifrl ||
 						     v->Output[k] == dm_dp2p0 ||
 						     v->Output[k] == dm_edp)) {
 					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
@@ -4529,6 +4599,131 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR3"
 						}
 					}
+				} else if (v->Output[k] == dm_hdmifrl) {
+					if (v->DSCEnable[k] == true) {
+						v->RequiresDSC[i][k] = true;
+						v->LinkDSCEnable = true;
+						v->RequiresFEC[i][k] = true;
+					} else {
+						v->RequiresDSC[i][k] = false;
+						v->LinkDSCEnable = false;
+						v->RequiresFEC[i][k] = false;
+					}
+					v->Outbpp = BPP_INVALID;
+					if (v->PHYCLKD18PerState[i] >= 3000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								3000,
+								3,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "3x3";
+					}
+					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 6000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								6000,
+								3,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "6x3";
+					}
+					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 6000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								6000,
+								4,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "6x4";
+					}
+					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 8000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								8000,
+								4,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState(i, k) = v->Output[k] & "8x4";
+					}
+					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 10000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								10000,
+								4,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "10x4";
+					}
+					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 12000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								12000,
+								4,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "12x4";
+					}
 				}
 			} else {
 				v->OutputBppPerState[i][k] = 0;
@@ -4542,6 +4737,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			if (v->BlendingAndTiming[k] == k
 					&& (v->Output[k] == dm_dp ||
 					    v->Output[k] == dm_edp ||
+					    v->Output[k] == dm_hdmifrl ||
 					    v->Output[k] == dm_hdmi) && v->OutputBppPerState[i][k] == 0) {
 				v->LinkCapacitySupport[i] = false;
 			}
@@ -4553,6 +4749,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		if (v->BlendingAndTiming[k] == k
 				&& (v->Output[k] == dm_dp ||
 				    v->Output[k] == dm_edp ||
+				    v->Output[k] == dm_hdmifrl ||
 				    v->Output[k] == dm_hdmi)) {
 			if (v->OutputFormat[k] == dm_420 && v->Interlace[k] == 1 && v->ProgressiveToInterlaceUnitInOPP == true) {
 				P2IWith420 = true;
@@ -4564,11 +4761,31 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		}
 	}
 
+	for (i = 0; i < v->soc.num_states; ++i) {
+		v->DTBCLKRequiredMoreThanSupported[i] = false;
+		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
+			if (v->BlendingAndTiming[k] == k && v->Output[k] == dm_hdmifrl
+					&& RequiredDTBCLK(
+							v->RequiresDSC[i][k],
+							v->PixelClockBackEnd[k],
+							v->OutputFormat[k],
+							v->OutputBppPerState[i][k],
+							v->NumberOfDSCSlices[k],
+							v->HTotal[k],
+							v->HActive[k],
+							v->AudioSampleRate[k],
+							v->AudioSampleLayout[k]) > v->DTBCLKPerState[i]) {
+				v->DTBCLKRequiredMoreThanSupported[i] = true;
+			}
+		}
+	}
+
 	for (i = 0; i < v->soc.num_states; ++i) {
 		v->ODMCombine4To1SupportCheckOK[i] = true;
 		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
 			if (v->BlendingAndTiming[k] == k && v->ODMCombineEnablePerState[i][k] == dm_odm_combine_mode_4to1
 					&& (v->ODMCombine4To1Supported == false || v->Output[k] == dm_dp || v->Output[k] == dm_edp
+							|| (v->Output[k] == dm_hdmifrl && v->DSCEnable[k] == false)
 							|| v->Output[k] == dm_hdmi)) {
 				v->ODMCombine4To1SupportCheckOK[i] = false;
 			}
@@ -7055,6 +7272,29 @@ static double CalculateUrgentLatency(
 	return ret;
 }
 
+static double RequiredDTBCLK(
+		bool DSCEnable,
+		double PixelClock,
+		enum output_format_class OutputFormat,
+		double OutputBPP,
+		int DSCSlices,
+		int HTotal,
+		int HActive,
+		int AudioRate,
+		int AudioLayout)
+{
+	if (DSCEnable != true) {
+		return dml_max(PixelClock / 4.0 * OutputBPP / 24.0, 25.0);
+	} else {
+		double PixelWordRate = PixelClock / (OutputFormat == dm_444 ? 1 : 2);
+		double HCActive = dml_ceil(DSCSlices * dml_ceil(OutputBPP * dml_ceil(HActive / DSCSlices, 1) / 8.0, 1) / 3.0, 1);
+		double HCBlank = 64 + 32 * dml_ceil(AudioRate * (AudioLayout == 1 ? 1.0 : 0.25) * HTotal / (PixelClock * 1000), 1);
+		double AverageTribyteRate = PixelWordRate * (HCActive + HCBlank) / HTotal;
+		double HActiveTribyteRate = PixelWordRate * HCActive / HActive;
+		return dml_max4(PixelWordRate / 4.0, AverageTribyteRate / 4.0, HActiveTribyteRate / 4.0, 25.0) * 1.002;
+	}
+}
+
 static noinline_for_stack void UseMinimumDCFCLK(
 		struct display_mode_lib *mode_lib,
 		int MaxPrefetchMode,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index dd9dc0c8cb43..674605d8d4fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -29,6 +29,8 @@
 #include "display_mode_vba_314.h"
 #include "../dml_inline_defs.h"
 
+#include "../dml1_frl_cap_chk.h"
+
 /*
  * NOTE:
  *   This file is gcc-parsable HW gospel, coming straight from HW engineers.
@@ -366,6 +368,17 @@ static void CalculateUrgentBurstFactor(
 		double *UrgentBurstFactorChroma,
 		bool *NotEnoughUrgentLatencyHiding);
 
+static double RequiredDTBCLK(
+		bool DSCEnable,
+		double PixelClock,
+		enum output_format_class OutputFormat,
+		double OutputBPP,
+		int DSCSlices,
+		int HTotal,
+		int HActive,
+		int AudioRate,
+		int AudioLayoutSingle);
+
 static void UseMinimumDCFCLK(
 		struct display_mode_lib *mode_lib,
 		int MaxPrefetchMode,
@@ -713,6 +726,8 @@ static unsigned int dscceComputeDelay(
 		pixelsPerClock = 1;
 	else if (pixelFormat == dm_n422)
 		pixelsPerClock = 2;
+	else if (Output == dm_hdmifrl)
+		pixelsPerClock = 2;
 	// #all other modes operate at 1 pixel per clock
 	else
 		pixelsPerClock = 1;
@@ -734,6 +749,8 @@ static unsigned int dscceComputeDelay(
 	//422 mode has an additional cycle of delay
 	if (pixelFormat == dm_420 || pixelFormat == dm_444 || pixelFormat == dm_n422)
 		s = 0;
+	else if (Output == dm_hdmifrl)
+		s = 0;
 	else
 		s = 1;
 
@@ -804,6 +821,25 @@ static unsigned int dscComputeDelay(enum output_format_class pixelFormat, enum o
 		Delay = Delay + 1;
 		//   sft
 		Delay = Delay + 1;
+	} else if (Output == dm_hdmifrl && pixelFormat != dm_444) {
+		//   sfr
+		Delay = Delay + 2;
+		//   dsccif
+		Delay = Delay + 1;
+		//   dscc - input deserializer
+		Delay = Delay + 5;
+		//  dscc - input cdc fifo
+		Delay = Delay + 25;
+		//   dscc - cdc uncertainty
+		Delay = Delay + 2;
+		//   dscc - output cdc fifo
+		Delay = Delay + 10;
+		//   dscc - cdc uncertainty
+		Delay = Delay + 2;
+		//   dscc - output serializer
+		Delay = Delay + 1;
+		//   sft
+		Delay = Delay + 1;
 	} else {
 		//   sfr
 		Delay = Delay + 2;
@@ -2261,6 +2297,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				v->DSCFormatFactor = 1;
 			else if (v->OutputFormat[k] == dm_n422)
 				v->DSCFormatFactor = 2;
+			else if (v->Output[k] == dm_hdmifrl)
+				v->DSCFormatFactor = 2;
 			else
 				v->DSCFormatFactor = 1;
 			if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_4to1)
@@ -3721,19 +3759,38 @@ static double TruncToValidBPP(
 	int NonDSCBPP1;
 	int NonDSCBPP2;
 
+	enum frl_cap_chk_result hdmifrlresult = FRL_CAP_CHK_OK;
+	struct frl_cap_chk_params hdmifrlparams = { 0 };
+	struct frl_cap_chk_intermediates hdmifrlinter = { 0 };
+
+	hdmifrlparams.lanes = Lanes;
+	hdmifrlparams.f_pixel_clock_nominal = PixelClock * 1000000;
+	hdmifrlparams.r_bit_nominal = LinkBitRate * 1000000;
+	hdmifrlparams.layout = AudioLayout;
+	hdmifrlparams.f_audio = AudioRate * 1000;
+	hdmifrlparams.h_active = HActive;
+	hdmifrlparams.h_blank = HTotal - HActive;
+	hdmifrlparams.compressed = DSCEnable;
+
 	if (Format == dm_420) {
 		NonDSCBPP0 = 12;
 		NonDSCBPP1 = 15;
 		NonDSCBPP2 = 18;
 		MinDSCBPP = 6;
 		MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1.0 / 16;
+		hdmifrlparams.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_420;
+		hdmifrlparams.bpc = (int)(DesiredBPP * 2 / 3);
 	} else if (Format == dm_444) {
 		NonDSCBPP0 = 24;
 		NonDSCBPP1 = 30;
 		NonDSCBPP2 = 36;
 		MinDSCBPP = 8;
 		MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16;
+		hdmifrlparams.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_444;
+	    hdmifrlparams.bpc = (int)(DesiredBPP / 3);
 	} else {
+		hdmifrlparams.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_422;
+	    hdmifrlparams.bpc = (int)(DesiredBPP / 2);
 
 		NonDSCBPP0 = 16;
 		NonDSCBPP1 = 20;
@@ -3742,12 +3799,22 @@ static double TruncToValidBPP(
 		if (Format == dm_n422) {
 			MinDSCBPP = 7;
 			MaxDSCBPP = 2 * DSCInputBitPerComponent - 1.0 / 16.0;
+		} else if (Output == dm_hdmifrl) {
+			MinDSCBPP = 7;
+			MaxDSCBPP = 2 * DSCInputBitPerComponent - 1.0 / 16.0;
 		} else {
 			MinDSCBPP = 8;
 			MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16.0;
 		}
 	}
 
+	if (Output == dm_hdmifrl) {
+		hdmifrlresult = dml1_frl_cap_chk_inter(&hdmifrlparams, &hdmifrlinter);
+		MaxLinkBPP = (1 - hdmifrlinter.overhead_max)
+				* dml_min(
+						hdmifrlinter.r_frl_char_min * 16 * Lanes / hdmifrlinter.f_pixel_clock_max + 24 * TB_BORROWED_MAX / HActive,
+						(hdmifrlinter.r_frl_char_min * 16 * Lanes / hdmifrlinter.f_pixel_clock_max * HTotal - 16 * hdmifrlinter.blank_audio_min) / HActive);
+	} else
 	if (DSCEnable && Output == dm_dp) {
 		MaxLinkBPP = LinkBitRate / 10 * 8 * Lanes / PixelClock * (1 - 2.4 / 100);
 	} else {
@@ -3784,6 +3851,8 @@ static double TruncToValidBPP(
 		if (!((DSCEnable == false && (DesiredBPP == NonDSCBPP2 || DesiredBPP == NonDSCBPP1 || DesiredBPP <= NonDSCBPP0))
 				|| (DSCEnable && DesiredBPP >= MinDSCBPP && DesiredBPP <= MaxDSCBPP))) {
 			return BPP_INVALID;
+		} else if ((Output == dm_hdmifrl && hdmifrlresult != FRL_CAP_CHK_OK) || (Output != dm_hdmifrl && MaxLinkBPP < DesiredBPP)) {
+			return BPP_INVALID;
 		} else {
 			return DesiredBPP;
 		}
@@ -4195,6 +4264,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 
 				if (v->ODMCombinePolicy == dm_odm_combine_policy_none
 						|| !(v->Output[k] == dm_dp ||
+						     v->Output[k] == dm_hdmifrl ||
 						     v->Output[k] == dm_dp2p0 ||
 						     v->Output[k] == dm_edp)) {
 					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
@@ -4616,6 +4686,131 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 							// v->OutputTypeAndRatePerState[i][k] = v->Output[k] & " HBR3"
 						}
 					}
+				} else if (v->Output[k] == dm_hdmifrl) {
+					if (v->DSCEnable[k] == true) {
+						v->RequiresDSC[i][k] = true;
+						v->LinkDSCEnable = true;
+						v->RequiresFEC[i][k] = true;
+					} else {
+						v->RequiresDSC[i][k] = false;
+						v->LinkDSCEnable = false;
+						v->RequiresFEC[i][k] = false;
+					}
+					v->Outbpp = BPP_INVALID;
+					if (v->PHYCLKD18PerState[i] >= 3000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								3000,
+								3,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "3x3";
+					}
+					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 6000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								6000,
+								3,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "6x3";
+					}
+					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 6000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								6000,
+								4,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "6x4";
+					}
+					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 8000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								8000,
+								4,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState(i, k) = v->Output[k] & "8x4";
+					}
+					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 10000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								10000,
+								4,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "10x4";
+					}
+					if (v->Outbpp == BPP_INVALID && v->PHYCLKD18PerState[i] >= 12000.0 / 18) {
+						v->Outbpp = TruncToValidBPP(
+								12000,
+								4,
+								v->HTotal[k],
+								v->HActive[k],
+								v->PixelClockBackEnd[k],
+								v->ForcedOutputLinkBPP[k],
+								v->LinkDSCEnable,
+								v->Output[k],
+								v->OutputFormat[k],
+								v->DSCInputBitPerComponent[k],
+								v->NumberOfDSCSlices[k],
+								v->AudioSampleRate[k],
+								v->AudioSampleLayout[k],
+								v->ODMCombineEnablePerState[i][k]);
+						v->OutputBppPerState[i][k] = v->Outbpp;
+						//v->OutputTypeAndRatePerState[i][k] = v->Output[k] & "12x4";
+					}
 				}
 			} else {
 				v->OutputBppPerState[i][k] = 0;
@@ -4629,6 +4824,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 			if (v->BlendingAndTiming[k] == k
 					&& (v->Output[k] == dm_dp ||
 					    v->Output[k] == dm_edp ||
+					    v->Output[k] == dm_hdmifrl ||
 					    v->Output[k] == dm_hdmi) && v->OutputBppPerState[i][k] == 0) {
 				v->LinkCapacitySupport[i] = false;
 			}
@@ -4640,6 +4836,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 		if (v->BlendingAndTiming[k] == k
 				&& (v->Output[k] == dm_dp ||
 				    v->Output[k] == dm_edp ||
+				    v->Output[k] == dm_hdmifrl ||
 				    v->Output[k] == dm_hdmi)) {
 			if (v->OutputFormat[k] == dm_420 && v->Interlace[k] == 1 && v->ProgressiveToInterlaceUnitInOPP == true) {
 				P2IWith420 = true;
@@ -4651,6 +4848,24 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 		}
 	}
 
+	for (i = 0; i < v->soc.num_states; ++i) {
+		v->DTBCLKRequiredMoreThanSupported[i] = false;
+		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
+			if (v->BlendingAndTiming[k] == k && v->Output[k] == dm_hdmifrl
+					&& RequiredDTBCLK(
+							v->RequiresDSC[i][k],
+							v->PixelClockBackEnd[k],
+							v->OutputFormat[k],
+							v->OutputBppPerState[i][k],
+							v->NumberOfDSCSlices[k],
+							v->HTotal[k],
+							v->HActive[k],
+							v->AudioSampleRate[k],
+							v->AudioSampleLayout[k]) > v->DTBCLKPerState[i]) {
+				v->DTBCLKRequiredMoreThanSupported[i] = true;
+			}
+		}
+	}
 
 	for (i = 0; i < v->soc.num_states; ++i) {
 		v->ODMCombine4To1SupportCheckOK[i] = true;
@@ -7141,6 +7356,29 @@ static double CalculateUrgentLatency(
 	return ret;
 }
 
+static double RequiredDTBCLK(
+		bool DSCEnable,
+		double PixelClock,
+		enum output_format_class OutputFormat,
+		double OutputBPP,
+		int DSCSlices,
+		int HTotal,
+		int HActive,
+		int AudioRate,
+		int AudioLayout)
+{
+	if (DSCEnable != true) {
+		return dml_max(PixelClock / 4.0 * OutputBPP / 24.0, 25.0);
+	} else {
+		double PixelWordRate = PixelClock / (OutputFormat == dm_444 ? 1 : 2);
+		double HCActive = dml_ceil(DSCSlices * dml_ceil(OutputBPP * dml_ceil(HActive / DSCSlices, 1) / 8.0, 1) / 3.0, 1);
+		double HCBlank = 64 + 32 * dml_ceil(AudioRate * (AudioLayout == 1 ? 1.0 : 0.25) * HTotal / (PixelClock * 1000), 1);
+		double AverageTribyteRate = PixelWordRate * (HCActive + HCBlank) / HTotal;
+		double HActiveTribyteRate = PixelWordRate * HCActive / HActive;
+		return dml_max4(PixelWordRate / 4.0, AverageTribyteRate / 4.0, HActiveTribyteRate / 4.0, 25.0) * 1.002;
+	}
+}
+
 static noinline_for_stack void UseMinimumDCFCLK(
 		struct display_mode_lib *mode_lib,
 		int MaxPrefetchMode,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 1b1ab6a6d53a..b5bd1358fdfd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1608,6 +1608,8 @@ static bool is_dtbclk_required(struct dc *dc, struct dc_state *context)
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
+		if (dc_is_hdmi_frl_signal(context->res_ctx.pipe_ctx[i].stream->signal))
+			return true;
 		if (dc->link_srv->dp_is_128b_132b_signal(&context->res_ctx.pipe_ctx[i]))
 			return true;
 	}
@@ -3588,3 +3590,11 @@ void dcn32_override_min_req_memclk(struct dc *dc, struct dc_state *context)
 		}
 	}
 }
+
+unsigned int dcn32_get_max_dispclk_mhz(struct dc *dc, struct dc_state *context)
+{
+	(void)dc;
+	int max_level = context->bw_ctx.dml.soc.num_states;
+
+	return (unsigned int) context->bw_ctx.dml.soc.clock_limits[max_level - 1].dispclk_mhz;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index 273d2bd79d85..ff83fbc811d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -77,4 +77,6 @@ void dcn32_override_min_req_memclk(struct dc *dc, struct dc_state *context);
 
 void dcn32_set_clock_limits(const struct _vcs_dpi_soc_bounding_box_st *soc_bb);
 
+unsigned int dcn32_get_max_dispclk_mhz(struct dc *dc, struct dc_state *context);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 505b5a5f212e..81e608b3cc74 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -29,6 +29,8 @@
 #include "../dml_inline_defs.h"
 #include "display_mode_vba_util_32.h"
 
+#include "../dml1_frl_cap_chk.h"
+
 void dml32_recalculate(struct display_mode_lib *mode_lib);
 static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
 		struct display_mode_lib *mode_lib);
@@ -342,6 +344,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				mode_lib->vba.DSCFormatFactor = 1;
 			else if (mode_lib->vba.OutputFormat[k] == dm_n422)
 				mode_lib->vba.DSCFormatFactor = 2;
+			else if (mode_lib->vba.Output[k] == dm_hdmifrl)
+				mode_lib->vba.DSCFormatFactor = 2;
 			else
 				mode_lib->vba.DSCFormatFactor = 1;
 			if (mode_lib->vba.ODMCombineEnabled[k] == dm_odm_combine_mode_4to1)
@@ -2282,6 +2286,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 		if (mode_lib->vba.BlendingAndTiming[k] == k) {
 			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveOTG = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveOTG + 1;
+			if (mode_lib->vba.Output[k] == dm_hdmifrl)
+				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 + 1;
 			if (mode_lib->vba.Output[k] == dm_dp2p0) {
 				v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 = v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.TotalNumberOfActiveDP2p0 + 1;
 				if (mode_lib->vba.OutputMultistreamId[k]
@@ -2328,6 +2334,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			if (mode_lib->vba.BlendingAndTiming[k] == k
 				&& (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_dp2p0
 					|| mode_lib->vba.Output[k] == dm_edp
+					|| mode_lib->vba.Output[k] == dm_hdmifrl
 					|| mode_lib->vba.Output[k] == dm_hdmi)
 				&& mode_lib->vba.OutputBppPerState[i][k] == 0 &&
 				(mode_lib->vba.UsesMALLForPStateChange[k] != dm_use_mall_pstate_change_phantom_pipe)) {
@@ -2353,6 +2360,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		if (mode_lib->vba.BlendingAndTiming[k] == k
 				&& (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_dp2p0
 						|| mode_lib->vba.Output[k] == dm_edp
+						|| mode_lib->vba.Output[k] == dm_hdmifrl
 						|| mode_lib->vba.Output[k] == dm_hdmi)) {
 			if (mode_lib->vba.OutputFormat[k]
 					== dm_420 && mode_lib->vba.Interlace[k] == 1 &&
@@ -2388,7 +2396,9 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				}
 			}
 
-			if ((mode_lib->vba.Output[k] == dm_edp || mode_lib->vba.Output[k] == dm_hdmi)) {
+			if ((mode_lib->vba.Output[k] == dm_edp
+					|| mode_lib->vba.Output[k] == dm_hdmifrl
+					|| mode_lib->vba.Output[k] == dm_hdmi)) {
 				if (mode_lib->vba.OutputMultistreamEn[k] == true && mode_lib->vba.OutputMultistreamId[k] == k)
 					mode_lib->vba.MultistreamWithHDMIOreDP = true;
 				for (j = 0; j < mode_lib->vba.NumberOfActiveSurfaces; ++j) {
@@ -2415,6 +2425,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		mode_lib->vba.DTBCLKRequiredMoreThanSupported[i] = false;
 		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
 			if (mode_lib->vba.BlendingAndTiming[k] == k
+					&& mode_lib->vba.Output[k] == dm_hdmifrl
 					&& dml32_RequiredDTBCLK(mode_lib->vba.RequiresDSC[i][k],
 							mode_lib->vba.PixelClockBackEnd[k],
 							mode_lib->vba.OutputFormat[k],
@@ -2451,6 +2462,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 			if (mode_lib->vba.BlendingAndTiming[k] == k) {
 				if (mode_lib->vba.Output[k] == dm_dp || mode_lib->vba.Output[k] == dm_dp2p0
+						|| mode_lib->vba.Output[k] == dm_hdmifrl
 						|| mode_lib->vba.Output[k] == dm_edp) {
 					if (mode_lib->vba.OutputFormat[k] == dm_420) {
 						mode_lib->vba.DSCFormatFactor = 2;
@@ -2458,6 +2470,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 						mode_lib->vba.DSCFormatFactor = 1;
 					} else if (mode_lib->vba.OutputFormat[k] == dm_n422) {
 						mode_lib->vba.DSCFormatFactor = 2;
+					} else if (mode_lib->vba.Output[k] == dm_hdmifrl) {
+						mode_lib->vba.DSCFormatFactor = 2;
 					} else {
 						mode_lib->vba.DSCFormatFactor = 1;
 					}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 15f5248340a7..40a0a5815ca5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -24,6 +24,7 @@
  */
 #include "display_mode_vba_util_32.h"
 #include "../dml_inline_defs.h"
+#include "../dml1_frl_cap_chk.h"
 #include "display_mode_vba_32.h"
 #include "../display_mode_lib.h"
 
@@ -55,6 +56,8 @@ unsigned int dml32_dscceComputeDelay(
 
 	if (pixelFormat == dm_420)
 		pixelsPerClock = 2;
+	else if (Output == dm_hdmifrl)
+		pixelsPerClock = 2;
 	else if (pixelFormat == dm_n422)
 		pixelsPerClock = 2;
 	// #all other modes operate at 1 pixel per clock
@@ -78,6 +81,8 @@ unsigned int dml32_dscceComputeDelay(
 	//422 mode has an additional cycle of delay
 	if (pixelFormat == dm_420 || pixelFormat == dm_444 || pixelFormat == dm_n422)
 		s = 0;
+	else if (Output == dm_hdmifrl)
+		s = 0;
 	else
 		s = 1;
 
@@ -140,7 +145,7 @@ unsigned int dml32_dscComputeDelay(enum output_format_class pixelFormat, enum ou
 		Delay = Delay + 1;
 		//   sft
 		Delay = Delay + 1;
-	} else if (pixelFormat == dm_n422 || (pixelFormat != dm_444)) {
+	} else if (pixelFormat == dm_n422 || (Output == dm_hdmifrl && pixelFormat != dm_444)) {
 		//   sfr
 		Delay = Delay + 2;
 		//   dsccif
@@ -1546,6 +1551,91 @@ void dml32_CalculateOutputLink(
 					*OutputRate = dm_output_rate_dp_rate_hbr3;
 				}
 			}
+		} else if (Output == dm_hdmifrl) {
+			if (DSCEnable == true) {
+				*RequiresDSC = true;
+				LinkDSCEnable = true;
+				*RequiresFEC = true;
+			} else {
+				*RequiresDSC = false;
+				LinkDSCEnable = false;
+				*RequiresFEC = false;
+			}
+			*OutBpp = 0;
+			if (PHYCLKD18PerState >= 3000 / 18) {
+				*OutBpp = dml32_TruncToValidBPP(3000, 3, HTotal, HActive, PixelClockBackEnd,
+						ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat,
+						DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate,
+						AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				//OutputTypeAndRate = Output & "3x3";
+				*OutputType = dm_output_type_hdmifrl;
+				*OutputRate = dm_output_rate_hdmi_rate_3x3;
+			}
+			if (*OutBpp == 0 && PHYCLKD18PerState >= 6000 / 18) {
+				*OutBpp = dml32_TruncToValidBPP(6000, 3, HTotal, HActive, PixelClockBackEnd,
+						ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat,
+						DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate,
+						AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				//OutputTypeAndRate = Output & "6x3";
+				*OutputType = dm_output_type_hdmifrl;
+				*OutputRate = dm_output_rate_hdmi_rate_6x3;
+			}
+			if (*OutBpp == 0 && PHYCLKD18PerState >= 6000 / 18) {
+				*OutBpp = dml32_TruncToValidBPP(6000, 4, HTotal, HActive, PixelClockBackEnd,
+						ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat,
+						DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate,
+						AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				//OutputTypeAndRate = Output & "6x4";
+				*OutputType = dm_output_type_hdmifrl;
+				*OutputRate = dm_output_rate_hdmi_rate_6x4;
+			}
+			if (*OutBpp == 0 && PHYCLKD18PerState >= 8000 / 18) {
+				*OutBpp = dml32_TruncToValidBPP(8000, 4, HTotal, HActive, PixelClockBackEnd,
+						ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat,
+						DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate,
+						AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				//OutputTypeAndRate = Output & "8x4";
+				*OutputType = dm_output_type_hdmifrl;
+				*OutputRate = dm_output_rate_hdmi_rate_8x4;
+			}
+			if (*OutBpp == 0 && PHYCLKD18PerState >= 10000 / 18) {
+				*OutBpp = dml32_TruncToValidBPP(10000, 4, HTotal, HActive, PixelClockBackEnd,
+						ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat,
+						DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate,
+						AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				if (*OutBpp == 0 && DSCEnable == true && ForcedOutputLinkBPP == 0 &&
+						PHYCLKD18PerState < 12000 / 18) {
+					*RequiresDSC = true;
+					LinkDSCEnable = true;
+					*RequiresFEC = true;
+					*OutBpp = dml32_TruncToValidBPP(10000, 4, HTotal, HActive, PixelClockBackEnd,
+							ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat,
+							DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate,
+							AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				}
+				//OutputTypeAndRate = Output & "10x4";
+				*OutputType = dm_output_type_hdmifrl;
+				*OutputRate = dm_output_rate_hdmi_rate_10x4;
+			}
+
+			if (*OutBpp == 0 && PHYCLKD18PerState >= 12000 / 18) {
+				*OutBpp = dml32_TruncToValidBPP(12000, 4, HTotal, HActive, PixelClockBackEnd,
+						ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat,
+						DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate,
+						AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				if (*OutBpp == 0 && DSCEnable == true && ForcedOutputLinkBPP == 0) {
+					*RequiresDSC = true;
+					LinkDSCEnable = true;
+					*RequiresFEC = true;
+					*OutBpp = dml32_TruncToValidBPP(12000, 4, HTotal, HActive, PixelClockBackEnd,
+							ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat,
+							DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate,
+							AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
+				}
+				//OutputTypeAndRate = Output & "12x4";
+				*OutputType = dm_output_type_hdmifrl;
+				*OutputRate = dm_output_rate_hdmi_rate_12x4;
+			}
 		}
 	}
 }
@@ -1599,12 +1689,27 @@ double dml32_TruncToValidBPP(
 	unsigned int   NonDSCBPP2;
 	unsigned int   NonDSCBPP3 = BPP_INVALID;
 
+	enum frl_cap_chk_result          hdmifrlresult = FRL_CAP_CHK_OK;
+	struct frl_cap_chk_params          hdmifrlparams = { 0 };
+	struct frl_cap_chk_intermediates   hdmifrlinter = { 0 };
+
+	hdmifrlparams.lanes = Lanes;
+	hdmifrlparams.f_pixel_clock_nominal = PixelClock * 1000000;
+	hdmifrlparams.r_bit_nominal = LinkBitRate * 1000000;
+	hdmifrlparams.layout = AudioLayout;
+	hdmifrlparams.f_audio = AudioRate * 1000;
+	hdmifrlparams.h_active = HActive;
+	hdmifrlparams.h_blank = HTotal - HActive;
+	hdmifrlparams.bpc = (int)(DesiredBPP / 3);
+	hdmifrlparams.compressed = DSCEnable;
+
 	if (Format == dm_420) {
 		NonDSCBPP0 = 12;
 		NonDSCBPP1 = 15;
 		NonDSCBPP2 = 18;
 		MinDSCBPP = 6;
 		MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1.0 / 16;
+		hdmifrlparams.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_420;
 	} else if (Format == dm_444) {
 		NonDSCBPP3 = 18;
 		NonDSCBPP0 = 24;
@@ -1612,8 +1717,10 @@ double dml32_TruncToValidBPP(
 		NonDSCBPP2 = 36;
 		MinDSCBPP = 8;
 		MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16;
+		hdmifrlparams.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_444;
 	} else {
-		if (Output == dm_hdmi) {
+		hdmifrlparams.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_422;
+		if (Output == dm_hdmi || Output == dm_hdmifrl) {
 			NonDSCBPP0 = 24;
 			NonDSCBPP1 = 24;
 			NonDSCBPP2 = 24;
@@ -1622,7 +1729,7 @@ double dml32_TruncToValidBPP(
 			NonDSCBPP1 = 20;
 			NonDSCBPP2 = 24;
 		}
-		if (Format == dm_n422) {
+		if (Format == dm_n422 || Output == dm_hdmifrl) {
 			MinDSCBPP = 7;
 			MaxDSCBPP = 2 * DSCInputBitPerComponent - 1.0 / 16.0;
 		} else {
@@ -1630,7 +1737,13 @@ double dml32_TruncToValidBPP(
 			MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16.0;
 		}
 	}
-	if (Output == dm_dp2p0) {
+	if (Output == dm_hdmifrl) {
+		hdmifrlresult = dml1_frl_cap_chk_inter(&hdmifrlparams, &hdmifrlinter);
+		MaxLinkBPP = (1 - hdmifrlinter.overhead_max) * dml_min(hdmifrlinter.r_frl_char_min * 16 *
+				Lanes / hdmifrlinter.f_pixel_clock_max + 24 * TB_BORROWED_MAX / HActive,
+				(hdmifrlinter.r_frl_char_min * 16 * Lanes / hdmifrlinter.f_pixel_clock_max *
+						HTotal - 16 * hdmifrlinter.blank_audio_min) / HActive);
+	} else if (Output == dm_dp2p0) {
 		MaxLinkBPP = LinkBitRate * Lanes / PixelClock * 128 / 132 * 383 / 384 * 65536 / 65540;
 	} else if (DSCEnable && Output == dm_dp) {
 		MaxLinkBPP = LinkBitRate / 10 * 8 * Lanes / PixelClock * (1 - 2.4 / 100);
@@ -1681,6 +1794,9 @@ double dml32_TruncToValidBPP(
 				DesiredBPP <= NonDSCBPP0)) ||
 				(DSCEnable && DesiredBPP >= MinDSCBPP && DesiredBPP <= MaxDSCBPP)))
 			return BPP_INVALID;
+		else if ((Output == dm_hdmifrl && hdmifrlresult != FRL_CAP_CHK_OK) ||
+				(Output != dm_hdmifrl && MaxLinkBPP < DesiredBPP))
+			return BPP_INVALID;
 		else
 			return DesiredBPP;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
index d5831a34f5a1..42013fa5ad01 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
@@ -30,6 +30,7 @@ enum output_encoder_class {
 	dm_hdmi = 1,
 	dm_wb = 2,
 	dm_edp = 3,
+	dm_hdmifrl = 4,
 	dm_dp2p0 = 5,
 };
 enum output_format_class {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
new file mode 100644
index 000000000000..9dde4e56f237
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
@@ -0,0 +1,589 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "dml_logger.h"
+#include "dml1_frl_cap_chk.h"
+#include "dml_inline_defs.h"
+
+static const double __maybe_unused EPSILON			= 0.01;
+static const double __maybe_unused DBL_EPSILON			= 2.2204460492503131e-16;
+static const double __maybe_unused OVERHEAD_M			= 0.003;  /* %   */
+static const double __maybe_unused TOLERANCE_PIXEL_CLOCK	= 0.005;  /* %   */
+static const double __maybe_unused DML_TOLERANCE_AUDIO_CLOCK	= 1000;   /* ppm */
+
+#define frl_dump_var(fmt, var) {}
+#define frl_print(fmt, ...) {}
+
+const struct frl_primary_format prim_format_444[] = {
+/* VIC/Rate/Lanes/HCactive/HCBlank */
+	{64,  3, 3, 960,  360}, /* 1920x1080 @ 100 */
+	{77,  3, 3, 960,  360}, /* 1920x1080 @ 100 */
+	{63,  3, 3, 960,  140}, /* 1920x1080 @ 120 */
+	{78,  3, 3, 960,  140}, /* 1920x1080 @ 120 */
+	{93,  3, 3, 1920, 828}, /* 3840x2160 @ 24 */
+	{103, 3, 3, 1920, 828}, /* 3840x2160 @ 24 */
+	{94,  3, 3, 1920, 720}, /* 3840x2160 @ 25 */
+	{104, 3, 3, 1920, 720}, /* 3840x2160 @ 25 */
+	{95,  3, 3, 1920, 280}, /* 3840x2160 @ 30 */
+	{105, 3, 3, 1920, 280}, /* 3840x2160 @ 30 */
+	{114, 3, 3, 1920, 828}, /* 3840x2160 @ 48 */
+	{116, 3, 3, 1920, 828}, /* 3840x2160 @ 48 */
+	{96,  3, 3, 1920, 720}, /* 3840x2160 @ 50 */
+	{106, 3, 3, 1920, 720}, /* 3840x2160 @ 50 */
+	{97,  3, 3, 1920, 280}, /* 3840x2160 @ 60 */
+	{107, 3, 3, 1920, 280}, /* 3840x2160 @ 60 */
+	{117, 6, 3, 1920, 720}, /* 3840x2160 @ 100 */
+	{119, 6, 3, 1920, 720}, /* 3840x2160 @ 100 */
+	{118, 6, 3, 1920, 280}, /* 3840x2160 @ 120 */
+	{120, 6, 3, 1920, 280}, /* 3840x2160 @ 120 */
+	{98,  3, 3, 2048, 700}, /* 4096x2160 @ 24 */
+	{99,  3, 3, 2048, 592}, /* 4096x2160 @ 25 */
+	{100, 3, 3, 2048, 152}, /* 4096x2160 @ 30 */
+	{115, 3, 3, 2048, 700}, /* 4096x2160 @ 48 */
+	{101, 3, 3, 2048, 592}, /* 4096x2160 @ 50 */
+	{102, 3, 3, 2048, 152}, /* 4096x2160 @ 60 */
+	{218, 6, 3, 2048, 592}, /* 4096x2160 @ 100 */
+	{219, 6, 3, 2048, 152}, /* 4096x2160 @ 120 */
+	{121, 3, 3, 2560, 1188}, /* 5120x2160 @ 24 */
+	{122, 3, 3, 2560, 1040}, /* 5120x2160 @ 25 */
+	{123, 3, 3, 2560, 440}, /* 5120x2160 @ 30 */
+	{124, 3, 3, 2560, 256}, /* 5120x2160 @ 48 */
+	{125, 3, 3, 2560, 484}, /* 5120x2160 @ 50 */
+	{126, 3, 3, 2307, 144}, /* 5120x2160 @ 60 */
+	{127, 6, 3, 2560, 484}, /* 5120x2160 @ 100 */
+	{193, 6, 3, 2334, 104}, /* 5120x2160 @ 120 */
+	{194, 6, 3, 3840, 1660}, /* 7680x2160 @ 24 */
+	{202, 6, 3, 3840, 1660}, /* 7680x2160 @ 24 */
+	{195, 6, 3, 3840, 1560}, /* 7680x2160 @ 25 */
+	{203, 6, 3, 3840, 1560}, /* 7680x2160 @ 25 */
+	{196, 6, 3, 3840, 660}, /* 7680x2160 @ 30 */
+	{204, 6, 3, 3840, 660}, /* 7680x2160 @ 30 */
+	{197, 6, 4, 3142, 1292}, /* 7680x2160 @ 48 */
+	{205, 6, 4, 3142, 1292}, /* 7680x2160 @ 48 */
+	{198, 6, 4, 3142, 1180}, /* 7680x2160 @ 50 */
+	{206, 6, 4, 3142, 1180}, /* 7680x2160 @ 50 */
+	{199, 6, 4, 3182, 140}, /* 7680x2160 @ 60 */
+	{207, 6, 4, 3182, 140}, /* 7680x2160 @ 60 */
+	{200, 10, 4, 2680, 784}, /* 7680x2160 @ 100 */
+	{208, 10, 4, 2680, 784}, /* 7680x2160 @ 100 */
+	{201, 10, 4, 2600, 100}, /* 7680x2160 @ 120 */
+	{209, 10, 4, 2600, 100}, /* 7680x2160 @ 120 */
+	{210, 6, 3, 4854, 912}, /* 10240x4320 @ 24 */
+	{211, 6, 3, 4827, 1536}, /* 10240x4320 @ 25 */
+	{212, 6, 3, 4720, 128}, /* 10240x4320 @ 30 */
+	{213, 8, 4, 4347, 756}, /* 10240x4320 @ 48 */
+	{214, 8, 4, 4320, 1376}, /* 10240x4320 @ 50 */
+	{215, 8, 4, 4187, 124}, /* 10240x4320 @ 60 */
+};
+
+const struct frl_primary_format prim_format_422[] = {
+/* VIC/Rate/Lanes/HCactive/HCBlank */
+	{64,  3, 3, 960,  360}, /* 1920x1080 @ 100 */
+	{77,  3, 3, 960,  360}, /* 1920x1080 @ 100 */
+	{63,  3, 3, 960,  140}, /* 1920x1080 @ 120 */
+	{78,  3, 3, 960,  140}, /* 1920x1080 @ 120 */
+	{93,  3, 3, 1920, 828}, /* 3840x2160 @ 24 */
+	{103, 3, 3, 1920, 828}, /* 3840x2160 @ 24 */
+	{94,  3, 3, 1920, 720}, /* 3840x2160 @ 25 */
+	{104, 3, 3, 1920, 720}, /* 3840x2160 @ 25 */
+	{95,  3, 3, 1920, 280}, /* 3840x2160 @ 30 */
+	{105, 3, 3, 1920, 280}, /* 3840x2160 @ 30 */
+	{114, 3, 3, 1920, 828}, /* 3840x2160 @ 48 */
+	{116, 3, 3, 1920, 828}, /* 3840x2160 @ 48 */
+	{96,  3, 3, 1920, 720}, /* 3840x2160 @ 50 */
+	{106, 3, 3, 1920, 720}, /* 3840x2160 @ 50 */
+	{97,  3, 3, 1920, 280}, /* 3840x2160 @ 60 */
+	{107, 3, 3, 1920, 280}, /* 3840x2160 @ 60 */
+	{117, 3, 3, 1370, 104}, /* 3840x2160 @ 100 */
+	{119, 3, 3, 1370, 104}, /* 3840x2160 @ 100 */
+	{118, 3, 3, 1130, 104}, /* 3840x2160 @ 120 */
+	{120, 3, 3, 1130, 104}, /* 3840x2160 @ 120 */
+	{98,  3, 3, 2048, 700}, /* 4096x2160 @ 24 */
+	{99,  3, 3, 2048, 592}, /* 4096x2160 @ 25 */
+	{100, 3, 3, 2048, 152}, /* 4096x2160 @ 30 */
+	{115, 3, 3, 2048, 700}, /* 4096x2160 @ 48 */
+	{101, 3, 3, 2048, 592}, /* 4096x2160 @ 50 */
+	{102, 3, 3, 2048, 152}, /* 4096x2160 @ 60 */
+	{218, 6, 3, 2048, 592}, /* 4096x2160 @ 100 */
+	{219, 6, 3, 2048, 152}, /* 4096x2160 @ 120 */
+	{121, 3, 3, 2560, 1188}, /* 5120x2160 @ 24 */
+	{122, 3, 3, 2560, 1040}, /* 5120x2160 @ 25 */
+	{123, 3, 3, 2560, 440}, /* 5120x2160 @ 30 */
+	{124, 3, 3, 2560, 256}, /* 5120x2160 @ 48 */
+	{125, 3, 3, 2560, 484}, /* 5120x2160 @ 50 */
+	{126, 3, 3, 2307, 144}, /* 5120x2160 @ 60 */
+	{127, 6, 3, 2560, 484}, /* 5120x2160 @ 100 */
+	{193, 6, 3, 2334, 104}, /* 5120x2160 @ 120 */
+	{194, 3, 3, 2460, 816}, /* 7680x2160 @ 24 */
+	{202, 3, 3, 2460, 816}, /* 7680x2160 @ 24 */
+	{195, 3, 3, 2460, 732}, /* 7680x2160 @ 25 */
+	{203, 3, 3, 2460, 732}, /* 7680x2160 @ 25 */
+	{196, 3, 3, 2360, 144}, /* 7680x2160 @ 30 */
+	{204, 3, 3, 2360, 144}, /* 7680x2160 @ 30 */
+	{197, 6, 3, 2460, 816}, /* 7680x2160 @ 48 */
+	{205, 6, 3, 2460, 816}, /* 7680x2160 @ 48 */
+	{198, 6, 3, 2460, 732}, /* 7680x2160 @ 50 */
+	{206, 6, 3, 2460, 732}, /* 7680x2160 @ 50 */
+	{199, 6, 3, 2380, 116}, /* 7680x2160 @ 60 */
+	{207, 6, 3, 2380, 116}, /* 7680x2160 @ 60 */
+	{200, 10, 4, 2680, 784}, /* 7680x2160 @ 100 */
+	{208, 10, 4, 2680, 784}, /* 7680x2160 @ 100 */
+	{201, 10, 4, 2600, 100}, /* 7680x2160 @ 120 */
+	{209, 10, 4, 2600, 100}, /* 7680x2160 @ 120 */
+	{210, 6, 3, 4854, 912}, /* 10240x4320 @ 24 */
+	{211, 6, 3, 4827, 1536}, /* 10240x4320 @ 25 */
+	{212, 6, 3, 4720, 128}, /* 10240x4320 @ 30 */
+	{213, 6, 4, 3360, 420}, /* 10240x4320 @ 48 */
+	{214, 6, 4, 3334, 892}, /* 10240x4320 @ 50 */
+	{215, 6, 4, 3120, 124}, /* 10240x4320 @ 60 */
+	{216, 12, 4, 3334, 764}, /* 10240x4320 @ 100 */
+	{217, 12, 4, 3120, 124}, /* 10240x4320 @ 120 */
+};
+
+const struct frl_primary_format prim_format_420[] = {
+/* VIC/Rate/Lanes/HCactive/HCBlank */
+	{114, 3, 3, 1920, 828}, /* 3840x2160 @ 48 */
+	{116, 3, 3, 1920, 828}, /* 3840x2160 @ 48 */
+	{96,  3, 3, 1920, 720}, /* 3840x2160 @ 50 */
+	{106, 3, 3, 1920, 720}, /* 3840x2160 @ 50 */
+	{97,  3, 3, 1920, 280}, /* 3840x2160 @ 60 */
+	{107, 3, 3, 1920, 280}, /* 3840x2160 @ 60 */
+	{117, 3, 3, 1370, 104}, /* 3840x2160 @ 100 */
+	{119, 3, 3, 1370, 104}, /* 3840x2160 @ 100 */
+	{118, 3, 3, 1130, 104}, /* 3840x2160 @ 120 */
+	{120, 3, 3, 1130, 104}, /* 3840x2160 @ 120 */
+	{115, 3, 3, 2048, 700}, /* 4096x2160 @ 48 */
+	{101, 3, 3, 2048, 592}, /* 4096x2160 @ 50 */
+	{102, 3, 3, 2048, 152}, /* 4096x2160 @ 60 */
+	{218, 3, 3, 1376, 96}, /* 4096x2160 @ 100 */
+	{219, 3, 3, 1131, 84}, /* 4096x2160 @ 120 */
+	{124, 3, 3, 2560, 256}, /* 5120x2160 @ 48 */
+	{125, 3, 3, 2560, 484}, /* 5120x2160 @ 50 */
+	{126, 3, 3, 2307, 144}, /* 5120x2160 @ 60 */
+	{127, 6, 3, 2560, 484}, /* 5120x2160 @ 100 */
+	{193, 6, 3, 2334, 104}, /* 5120x2160 @ 120 */
+	{194, 3, 3, 2460, 816}, /* 7680x2160 @ 24 */
+	{202, 3, 3, 2460, 816}, /* 7680x2160 @ 24 */
+	{195, 3, 3, 2460, 732}, /* 7680x2160 @ 25 */
+	{203, 3, 3, 2460, 732}, /* 7680x2160 @ 25 */
+	{196, 3, 3, 2360, 144}, /* 7680x2160 @ 30 */
+	{204, 3, 3, 2360, 144}, /* 7680x2160 @ 30 */
+	{197, 6, 3, 2460, 816}, /* 7680x2160 @ 48 */
+	{205, 6, 3, 2460, 816}, /* 7680x2160 @ 48 */
+	{198, 6, 3, 2460, 732}, /* 7680x2160 @ 50 */
+	{206, 6, 3, 2460, 732}, /* 7680x2160 @ 50 */
+	{199, 6, 3, 2380, 116}, /* 7680x2160 @ 60 */
+	{207, 6, 3, 2380, 116}, /* 7680x2160 @ 60 */
+	{200, 8, 4, 2240, 480}, /* 7680x2160 @ 100 */
+	{208, 8, 4, 2240, 480}, /* 7680x2160 @ 100 */
+	{201, 8, 4, 2062, 108}, /* 7680x2160 @ 120 */
+	{209, 8, 4, 2062, 108}, /* 7680x2160 @ 120 */
+	{210, 3, 3, 2614, 172}, /* 10240x4320 @ 24 */
+	{211, 3, 3, 2614, 500}, /* 10240x4320 @ 25 */
+	{212, 6, 3, 4720, 128}, /* 10240x4320 @ 30 */
+	{213, 6, 3, 2614, 172}, /* 10240x4320 @ 48 */
+	{214, 6, 4, 3334, 892}, /* 10240x4320 @ 50 */
+	{215, 6, 4, 3120, 124}, /* 10240x4320 @ 60 */
+	{216, 10, 4, 2854, 520}, /* 10240x4320 @ 100 */
+	{217, 10, 4, 2587, 120}, /* 10240x4320 @ 120 */
+};
+
+enum frl_cap_chk_result dml1_frl_cap_chk_common(struct frl_cap_chk_intermediates *inter,
+						struct frl_cap_chk_params *params)
+{
+	double audio_bw_reserve = (params->compressed ? 192000.0 : 0.0);
+
+	dc_assert_fp_enabled();
+
+#ifdef DEBUG_FRL_CAP_CHK
+	{
+		printf("frl_cap_chk inputs:\n");
+		printf("-------------------\n");
+		frl_dump_var("%i",  params->lanes);
+		frl_dump_var("%le", params->f_pixel_clock_nominal);
+		frl_dump_var("%le", params->r_bit_nominal);
+		frl_dump_var("%i",  params->audio_packet_type);
+		frl_dump_var("%le", params->f_audio);
+		frl_dump_var("%i",  params->h_active);
+		frl_dump_var("%i",  params->h_blank);
+		frl_dump_var("%i",  params->bpc);
+		frl_dump_var("%i",  params->pixel_encoding);
+		frl_dump_var("%i",  params->compressed);
+		frl_dump_var("%i",  params->slices);
+		frl_dump_var("%i",  params->slice_width);
+		frl_dump_var("%le", params->bpp_target);
+		frl_dump_var("%i",  params->layout);
+		frl_dump_var("%i",  params->acat);
+		printf("frl_cap_chk outputs:\n");
+		printf("---------------------\n");
+	}
+#endif
+
+	inter->c_frl_sb          = 4 * C_FRL_CB + params->lanes;
+	inter->overhead_sb       = (double)params->lanes / inter->c_frl_sb;
+	inter->overhead_rs       = 8.0 * 4.0 / inter->c_frl_sb;
+	inter->overhead_map      = 2.5 / inter->c_frl_sb;
+	inter->overhead_min      = inter->overhead_sb + inter->overhead_rs + inter->overhead_map;
+	inter->overhead_max      = inter->overhead_min + OVERHEAD_M;
+	inter->f_pixel_clock_max = params->f_pixel_clock_nominal * (1.0 + TOLERANCE_PIXEL_CLOCK);
+	inter->t_line            = (params->h_active + params->h_blank) / inter->f_pixel_clock_max;
+	inter->r_bit_min         = params->r_bit_nominal * (1.0 - TOLERANCE_FRL_BIT / 1000000.0);
+	inter->r_frl_char_min    = inter->r_bit_min / 18.0;
+	inter->c_frl_line        = dml_floor(inter->t_line * inter->r_frl_char_min * params->lanes, 1);
+
+#ifdef DEBUG_FRL_CAP_CHK
+	{
+		frl_dump_var("%i",  inter->c_frl_sb);
+		frl_dump_var("%le", inter->overhead_sb);
+		frl_dump_var("%le", inter->overhead_rs);
+		frl_dump_var("%le", inter->overhead_map);
+		frl_dump_var("%le", inter->overhead_min);
+		frl_dump_var("%le", inter->overhead_max);
+		frl_dump_var("%le", inter->f_pixel_clock_max);
+		frl_dump_var("%le", inter->t_line);
+		frl_dump_var("%le", inter->r_bit_min);
+		frl_dump_var("%le", inter->r_frl_char_min);
+		frl_dump_var("%le", inter->c_frl_line);
+	}
+#endif
+
+	switch (params->audio_packet_type) {
+	case 0x02:
+		if (params->layout == 0)
+			inter->ap = 0.25;
+		else if (params->layout == 1)
+			inter->ap = 1.0;
+		break;
+	case 0x08:
+		inter->ap = 0.25;
+		break;
+	case 0x09:
+		inter->ap = 1.0;
+		break;
+	case 0x07:
+	case 0x0e:
+	case 0x0f:
+	case 0x0b:
+	case 0x0c:
+		/* Unsupported audio format */
+		return FRL_CAP_CHK_ERROR_UNSUPPORTED_AUDIO;
+	default:
+		inter->ap = 0.0;
+	}
+
+	inter->r_ap                   = (dml_max(audio_bw_reserve, params->f_audio * inter->ap) + 2 * ACR_RATE_MAX) * (1 + DML_TOLERANCE_AUDIO_CLOCK / 1000000.0);
+	inter->avg_audio_packets_line = inter->r_ap * inter->t_line;
+	inter->audio_packets_line     = (int)dml_ceil(inter->avg_audio_packets_line, 1);
+	inter->blank_audio_min        = 32 + 32 * inter->audio_packets_line; // h_blank_audio_min or hc_blank_audio_min
+
+	params->borrow_params.audio_packets_line = inter->audio_packets_line;
+
+#ifdef DEBUG_FRL_CAP_CHK
+	{
+		frl_dump_var("%le", inter->ap);
+		frl_dump_var("%le", inter->r_ap);
+		frl_dump_var("%le", inter->avg_audio_packets_line);
+		frl_dump_var("%i",  inter->audio_packets_line);
+		frl_dump_var("%i",  inter->blank_audio_min);
+	}
+#endif
+
+	return FRL_CAP_CHK_OK;
+}
+
+enum frl_cap_chk_result dml1_frl_cap_chk_uncompressed(struct frl_cap_chk_params *params,
+						      struct frl_cap_chk_intermediates *inter)
+{
+	enum frl_cap_chk_result res;
+	int      k_420;
+	double   k_cd;
+	int      c_frl_free;
+	int      c_frl_rc_margin;
+	int      c_frl_rc_savings;
+	int      bpp;
+	double   bytes_line;
+	int      tb_active;
+	int      tb_blank;
+	double   f_tb_average;
+	double   t_active_ref;
+	double   t_blank_ref;
+	double   t_active_min;
+	double   t_blank_min;
+	double   t_borrowed;
+	double   tb_borrowed;
+	int      c_frl_actual_payload;
+	double   utilization;
+	double   margin;
+
+	dc_assert_fp_enabled();
+
+	res = dml1_frl_cap_chk_common(inter, params);
+	if (res != FRL_CAP_CHK_OK)
+		return res;
+
+	k_420            = params->pixel_encoding == HDMI_FRL_PIXEL_ENCODING_420 ? 2 : 1;
+	k_cd             = params->pixel_encoding == HDMI_FRL_PIXEL_ENCODING_422 ? 1.0 : params->bpc / 8.0;
+	c_frl_free       = (int)dml_max(params->h_blank * k_cd / k_420 - 32 * (1 + inter->audio_packets_line) - 7, 0);
+	c_frl_rc_margin  = 4;
+	c_frl_rc_savings = (int)dml_floor(dml_max(((7.0 / 8.0) * c_frl_free) - c_frl_rc_margin, 0.0), 1);
+	bpp              = (int)(24 * k_cd / k_420);
+	bytes_line       = bpp * params->h_active / 8.0;
+	tb_active        = (int)dml_ceil(bytes_line / 3, 1);
+	tb_blank         = (int)dml_ceil(params->h_blank * k_cd / k_420, 1);
+
+#ifdef DEBUG_FRL_CAP_CHK
+	{
+		frl_dump_var("%i", k_420);
+		frl_dump_var("%le", k_cd);
+		frl_dump_var("%i", c_frl_free);
+		frl_dump_var("%i", c_frl_rc_margin);
+		frl_dump_var("%i", c_frl_rc_savings);
+		frl_dump_var("%i", bpp);
+		frl_dump_var("%le", bytes_line);
+		frl_dump_var("%i", tb_active);
+		frl_dump_var("%i", tb_blank);
+	}
+#endif
+
+	if (!(inter->blank_audio_min <= tb_blank)) {
+		frl_dump_var("%i", inter->blank_audio_min);
+		frl_dump_var("%i", tb_blank);
+		return FRL_CAP_CHK_ERROR_AUDIO_BW;
+	}
+
+	f_tb_average = (inter->f_pixel_clock_max / (params->h_active + params->h_blank)) * (tb_active + tb_blank);
+	t_active_ref = inter->t_line * ((double)params->h_active / (params->h_active + params->h_blank));
+	t_blank_ref  = inter->t_line * ((double)params->h_blank / (params->h_active + params->h_blank));
+	t_active_min = (3.0 / 2.0) * tb_active / (params->lanes * inter->r_frl_char_min * (1.0 - inter->overhead_max));
+	t_blank_min  = tb_blank / (params->lanes * inter->r_frl_char_min * (1.0 - inter->overhead_max));
+
+#ifdef DEBUG_FRL_CAP_CHK
+	{
+		frl_dump_var("%le", f_tb_average);
+		frl_dump_var("%le", t_active_ref);
+		frl_dump_var("%le", t_blank_ref);
+		frl_dump_var("%le", t_active_min);
+		frl_dump_var("%le", t_blank_min);
+	}
+#endif
+
+	if (t_active_ref >= t_active_min && t_blank_ref >= t_blank_min) {
+		t_borrowed = 0;
+		params->borrow_params.borrow_mode = FRL_BORROW_MODE_NONE;
+	} else if ((t_active_ref < t_active_min) && (t_blank_ref >= t_blank_min)) {
+		t_borrowed = t_active_min - t_active_ref;
+		params->borrow_params.borrow_mode = FRL_BORROW_MODE_FROM_BLANK;
+	} else {
+		return FRL_CAP_CHK_ERROR_BORROW;
+	}
+
+	tb_borrowed = dml_ceil(t_borrowed * f_tb_average, 1);
+
+#ifdef DEBUG_FRL_CAP_CHK
+	{
+		frl_dump_var("%le", tb_borrowed);
+		frl_dump_var("%i", params->borrow_params.borrow_mode);
+	}
+#endif
+
+	if (!(tb_borrowed <= TB_BORROWED_MAX))
+		return FRL_CAP_CHK_ERROR_MAX_BORROW;
+
+	c_frl_actual_payload = (int)(dml_ceil((3.0 / 2.0) * tb_active, 1) + tb_blank - c_frl_rc_savings);
+	utilization          = c_frl_actual_payload / inter->c_frl_line;
+	margin               = 1.0 - (utilization + inter->overhead_max);
+
+#ifdef DEBUG_FRL_CAP_CHK
+	{
+		frl_dump_var("%i",  c_frl_actual_payload);
+		frl_dump_var("%le", utilization);
+		frl_dump_var("%le", margin);
+	}
+#endif
+
+	if (margin < 0 && dcn_bw_fabs(margin) > EPSILON)
+		return FRL_CAP_CHK_ERROR_MARGIN;
+
+	return FRL_CAP_CHK_OK;
+}
+
+enum frl_cap_chk_result dml1_frl_cap_chk(struct frl_cap_chk_params *params)
+{
+	struct frl_cap_chk_intermediates inter;
+
+	return dml1_frl_cap_chk_inter(params, &inter);
+}
+
+enum frl_cap_chk_result dml1_frl_cap_chk_inter(struct frl_cap_chk_params *params,
+					       struct frl_cap_chk_intermediates *inter)
+{
+	return dml1_frl_cap_chk_uncompressed(params, inter);
+}
+
+static double calculate_compressed_active_time(uint32_t h_active,
+	const uint32_t h_blank,
+	const int hc_active,
+	const int hc_blank,
+	const uint32_t frl_num_lanes,
+	const double pix_clk,
+	const int frl_link_rate)
+{
+	double f_tb_average;
+	double r_bit_nominal;
+	double r_bit_min;
+	double r_frl_char_min;
+	double t_active_est_1;
+	double t_active_est_2;
+	double t_active_target;
+	int c_frl_sb = 510;
+	int frl_bit_tolerance = 300;
+	double overhead_m = 0.003;
+	double overhead_sb;
+	double overhead_rs;
+	double overhead_map;
+	double overhead_min;
+	double overhead_max;
+
+	switch (frl_link_rate) {
+	case FRL_LINK_RATE_3GBPS:
+		r_bit_nominal = 3.0e9;
+		break;
+	case FRL_LINK_RATE_6GBPS:
+	case FRL_LINK_RATE_6GBPS_4LANE:
+		r_bit_nominal = 6.0e9;
+		break;
+	case FRL_LINK_RATE_8GBPS:
+		r_bit_nominal = 8.0e9;
+		break;
+	case FRL_LINK_RATE_10GBPS:
+	default:
+		r_bit_nominal = 10.0e9;
+		break;
+	case FRL_LINK_RATE_12GBPS:
+		r_bit_nominal = 12.0e9;
+		break;
+	}
+
+	f_tb_average = pix_clk / (h_active + h_blank)
+					* (hc_active + hc_blank);
+
+	c_frl_sb = 4 * c_frl_sb + frl_num_lanes;
+	overhead_sb = (double)frl_num_lanes / c_frl_sb;
+	overhead_rs = 8.0 * 4.0 / c_frl_sb;
+	overhead_map = 2.5 / c_frl_sb;
+	overhead_min = overhead_sb + overhead_rs + overhead_map;
+	overhead_max = overhead_min + overhead_m;
+
+	r_bit_min = r_bit_nominal * (1.0 - frl_bit_tolerance / 1000000.0);
+	r_frl_char_min = r_bit_min / 18.0;
+	t_active_est_1 = hc_active / f_tb_average;
+	t_active_est_2 = (3.0 / 2.0 * hc_active) /
+				  (frl_num_lanes * r_frl_char_min * (1.0 - overhead_max));
+
+	if (t_active_est_1 > t_active_est_2) {
+		t_active_target = t_active_est_1;
+	} else {
+		t_active_target = t_active_est_2;
+	}
+
+	return t_active_target;
+}
+
+void frl_modified_pix_clock_for_dsc_padding(const int hc_active_target,
+	const int hc_blank_target,
+	const uint8_t frl_num_lanes,
+	const uint32_t pix_clk_100hz,
+	const int frl_link_rate,
+	const uint32_t h_addressable,
+	const uint32_t h_border_left,
+	const uint32_t h_border_right,
+	const uint32_t h_total,
+	const uint32_t h_addressable_otg,
+	uint32_t *pix_clk_100hz_otg,
+	uint32_t *h_total_otg)
+{
+	double pix_clk;
+	int h_active;
+	int h_blank;
+	double t_active_target;
+	double hw_pix_clk;
+	double h_total_otg_temp;
+
+	pix_clk = (double)pix_clk_100hz * 100;
+
+	h_active = h_addressable + h_border_left + h_border_right;
+	h_blank = h_total - h_active;
+
+	t_active_target = calculate_compressed_active_time(h_active, h_blank, hc_active_target, hc_blank_target, frl_num_lanes, pix_clk, frl_link_rate);
+
+	h_total_otg_temp = ((double)h_addressable_otg * (double)h_total) / ((double)pix_clk_100hz * 100.0 * t_active_target);
+	/* Htotal must be a multiple of 4, also take the ceiling */
+	*h_total_otg = (uint32_t)dml_ceil(h_total_otg_temp, 4.0);
+
+	hw_pix_clk = (double)(pix_clk_100hz * 100.0 * (double)*h_total_otg) / (double)h_total;
+	*pix_clk_100hz_otg = (uint32_t)(hw_pix_clk / 100.0);
+}
+
+int frl_modify_borrow_mode_for_dsc_padding(const uint32_t pix_clk_100hz,
+	const uint32_t h_active,
+	const uint32_t h_active_padded,
+	const uint32_t h_blank,
+	const uint32_t h_blank_padded,
+	const int hc_active,
+	const int hc_blank,
+	const uint8_t frl_num_lanes,
+	const int frl_link_rate)
+{
+	double f_pixel_clock_max;
+	double t_line;
+	double t_active;
+	double t_blank;
+	double t_active_target;
+	double t_blank_target;
+	double pix_clk_tolerance = 0.005;
+
+	enum frl_borrow_mode borrow_mode;
+
+	f_pixel_clock_max = (double)pix_clk_100hz * (1.0 + pix_clk_tolerance);
+	t_line = (double)(h_active + h_blank) / f_pixel_clock_max;
+
+	t_active_target = calculate_compressed_active_time(h_active, h_blank, hc_active, hc_blank, frl_num_lanes, f_pixel_clock_max, frl_link_rate);
+
+	t_active = t_line * ((double)h_active_padded / (h_active_padded + h_blank_padded));
+	t_blank = t_line - t_active;
+
+	t_blank_target = t_line - t_active_target;
+
+	if (t_blank_target - t_blank > DBL_EPSILON) {
+		borrow_mode = FRL_BORROW_MODE_FROM_ACTIVE;
+	} else if (t_active_target - t_active > DBL_EPSILON) {
+		borrow_mode = FRL_BORROW_MODE_FROM_BLANK;
+	} else {
+		borrow_mode = FRL_BORROW_MODE_NONE;
+	}
+
+	return borrow_mode;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
index debe4c1dc0f7..545f498ea396 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
@@ -119,13 +119,6 @@ struct frl_cap_chk_params {
 
 	bool     compressed;              /* set to true if DSC is enabled */
 	bool     bypass_hc_target_calc;   /* debug only */
-	bool     allow_all_bpp;           /* dsc_all_bpp */
-
-	/* DSC parameters */
-	int      slices;
-	int      slice_width;
-	double   bpp_target;
-	bool     is_ovt;
 	int      layout;
 	int      acat;    /* not supported */
 
@@ -145,8 +138,6 @@ enum frl_cap_chk_result dml1_frl_cap_chk_common(struct frl_cap_chk_intermediates
 enum frl_cap_chk_result dml1_frl_cap_chk_uncompressed(struct frl_cap_chk_params *params,
 						      struct frl_cap_chk_intermediates *inter);
 
-enum frl_cap_chk_result dml1_frl_cap_chk_compressed(struct frl_cap_chk_params *params,
-						    struct frl_cap_chk_intermediates *inter);
 #endif
 
 void frl_modified_pix_clock_for_dsc_padding(const int hc_active_target,
-- 
2.54.0

