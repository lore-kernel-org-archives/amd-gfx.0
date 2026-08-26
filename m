Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A63C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7526010EE44;
	Wed, 26 Aug 2026 23:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4cfC+TSH";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59BF10EE44
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzE1JAR/Mp7t6zwUbHctkRi8Yen2CEOnK2dPWqRmZN8YKQGKJrVFzsgX1q1z47Wc50L+6Xf++rcpBMiccCwlKityOrmSzQ9+7H6KLW7hIJTxFwncthpY3CKTsyMPslilxvt0uXiCaOo+vDg4MGowDFxU+JiQUfy0f85fyTSSo4pVpcajKua1PydBs7fmAdPFoo5LknNzSvLz3nKAF8c99JyT7B9I1ueIqRGVj8YQ+wE+EH4XNJIGED0oWaPWZYqX6629CrTormOwqMfo1c5h1QlCikt/36DUrwTuyk/8QlFuOFqYQy+OKOOWLRbrdn9hksjRMkOUYayBaAoarHhpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQg1FEsJkwBQQsufP/YcBrpotGE9qTQj2akrOR3uKTA=;
 b=BOjQ6q0W57RFUnPbKceqWTTZVd3skgcOdd3LowN8b+l1A4dohMYKWV5CG15le2ho8+cI1VUGZtBzZCVcpoghJueSZhuP8dIdnVBD84UhKHYcKunziqgPgDIKiPrh5hNhf7m/Q6JmyPheDxnX2CvdQKZrDHW1givz4NOCt54A2sheF9vn85khy4FioDkRelTHzMQKM44jVarLsxeuERyqKgnI5vGFeZ4Zd21VF7ofNFQeRThPyyVwgYFp3/N873ieyUsgAwGiqzmo5gUjgUpJ2M6vCnXTFgWhstR40ZRukWT775vXbSll/uy7aFt3JEX9kIXxmV4q7+RWzZJLe2F17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQg1FEsJkwBQQsufP/YcBrpotGE9qTQj2akrOR3uKTA=;
 b=4cfC+TSHMHyJ8S/6Guker4x+xn8ah2osCLdkQOzeJ0BpusFNG4zSwF07ARyKMykpt7LOfKlsWfLE17aEpgU3Ppo3aG42A/XGaMtT8ABtUi4eV3uh9c3zMH0Xaq5aZDL5rzQllllod3ia6vULWEK3Jj6uxpSwmQ4YPadBr8QrPwc=
Received: from SJ0PR05CA0181.namprd05.prod.outlook.com (2603:10b6:a03:330::6)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:23:14 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::94) by SJ0PR05CA0181.outlook.office365.com
 (2603:10b6:a03:330::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Wed, 26
 Aug 2026 23:23:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:23:13 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:23:07 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH 22/59] drm/amd/display: Update HDMI link rate and DSC handling
 for DCN60
Date: Wed, 26 Aug 2026 17:04:53 -0600
Message-ID: <20260826231519.881949-23-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: d0be7315-3c26-47a7-de21-08df03c90001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: oIctC1vDdkBlCYJ7TsUQSOM3l3g8t929mEsWz5Umrbq5JMlAs2GzC0xckeyCZ74/8OyYf3FC8zMV55agXyK8+JvUbPqrelR+m1LPJENL49i7m59TOc/9RGFscw598XCxhvItlAgIckstDxwnlp/TOHDuQMwXOoG2VbYpLfaOPtkpxNlzsPkWudu4OZW7xhr2JY1Xz2hfcDiK+Z1IS2nhIuINzDpkVZgAfu6vrY+dMSaWEHqkOtaO/Aj2pgYNj4eFUe7yG1ukpvDk5IIK6SZsFKp3Y/4+8JuhuPUXyfiUkJleN30nZPK8osvShbVggEpckzn8woq9ZidDfhz6RiK3yRbPl0G7/dtk9BWaFmS1QjM8eyCS/24IfqMG5nU1qldTdG8zlfRkdhu4LxIw5E1GXQhJVDJz1OAhRRrZpoM9FTfCMU8jH59Y9u87mpcUZtREIWb63RwikVKdfJOtNWrNr2gVuv0VKyU2U0kYLsQzoeOpPxlQrmgIPiekJeBbonmAZDJ9OaJF2r9ekFPtiAJCDPvZN5tOph37iX0q+WPIh/q1Irm2VcESgsdbqquVagdgwwstVo8FoQSyx95iEoiuiIrFORY6FtQEA3zk7rz77l6zJpntCpxpTYFaLZ04NUk9az4ctMKtuaGfZTbrBnJimTsu1FG/NjOEPIMVkwu8At6e6fRes8x907OLP0fgU8c6ZfdFNP5vIJh8r0PrwR8zCg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AWTZqA8Hvz0EgbOmXd0OlvrdcIdBRQsDipm+/Ady7eoaP47OYKEDbSA6XEAE6bm+rxc+e9MurzKfSbMBr5vXMqJ6zXB5CnRBzyXyFx+ptx6hUiSXMPt8l94inZZc5Yzn3d75J5udoLRG2DsrtV94Rr408WDqajXWBUF7MEbKwl/JyJyu2BI6cR3pR3NnP0oMyuRyvfSlUHQ8SBGX943x2YCG40PYBWkI3K5UpgN9zn+kOAVvQBNaeoEENfygqLOmKo1dn6+4i/waf1m8CaUTDWw8ODLErZ+Fx99Q5LwiPz53N75wnLFJ+t0cLAepfe2drnRQnoji7W5NSfG2HUy4m3qIWB0xqHfhuJLSSl12jrzM15VBZLCBIzC2mxvPB2C7s2bFDZ0OmqmGBnNksnVZzm+xlSBRJNt9Xvss9KX01c0VLb7ckyuqvPMGb2swP4dX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:23:13.2111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0be7315-3c26-47a7-de21-08df03c90001
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617
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

From: Relja Vojvodic <Relja.Vojvodic@amd.com>

[WHAT]
- Updated switch cases to handle new link rates
- Reverted set stream attribute behaviour to DCN401 version to unblock
  DSC on DCN 60

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Relja Vojvodic <Relja.Vojvodic@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_exports.c |   3 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  18 ++-
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.c |   8 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |   8 ++
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c  |   4 +-
 .../hpo/dcn60/dcn60_hpo_frl_stream_encoder.c  | 131 +-----------------
 .../drm/amd/display/dc/link/link_detection.c  |   2 +
 7 files changed, 37 insertions(+), 137 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index ba1b46d3a13e..fef857c7336b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -368,8 +368,7 @@ enum dc_link_encoding_format dc_link_get_highest_encoding_format(const struct dc
 
 		if (frl_link_settings->frl_link_rate == HDMI_FRL_LINK_RATE_DISABLE)
 			return DC_LINK_ENCODING_HDMI_TMDS;
-		else if (frl_link_settings->frl_link_rate >= HDMI_FRL_LINK_RATE_3GBPS &&
-				frl_link_settings->frl_link_rate <= HDMI_FRL_LINK_RATE_12GBPS)
+		else if (frl_link_settings->frl_link_rate >= HDMI_FRL_LINK_RATE_3GBPS)
 			return DC_LINK_ENCODING_HDMI_FRL;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index 6f5a11d37899..b8e5985f9307 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -774,12 +774,19 @@ void hpo_fpu_enc3_validate_hdmi_frl_output_link(struct hpo_frl_stream_encoder *e
 		frl_params->r_bit_nominal = 8.0e9;
 		break;
 	case HDMI_FRL_LINK_RATE_10GBPS:
-	default:
 		frl_params->r_bit_nominal = 10.0e9;
 		break;
 	case HDMI_FRL_LINK_RATE_12GBPS:
 		frl_params->r_bit_nominal = 12.0e9;
 		break;
+	case HDMI_FRL_LINK_RATE_16GBPS:
+		frl_params->r_bit_nominal = 16.0e9;
+		break;
+	case HDMI_FRL_LINK_RATE_20GBPS:
+		frl_params->r_bit_nominal = 20.0e9;
+		break;
+	default:
+		break;
 	}
 
 	if (timing->flags.DSC &&
@@ -802,12 +809,19 @@ void hpo_fpu_enc3_validate_hdmi_frl_output_link(struct hpo_frl_stream_encoder *e
 			frl_params->r_bit_nominal = 8.0e9;
 			break;
 		case HDMI_FRL_LINK_RATE_10GBPS:
-		default:
 			frl_params->r_bit_nominal = 10.0e9;
 			break;
 		case HDMI_FRL_LINK_RATE_12GBPS:
 			frl_params->r_bit_nominal = 12.0e9;
 			break;
+		case HDMI_FRL_LINK_RATE_16GBPS:
+			frl_params->r_bit_nominal = 16.0e9;
+			break;
+		case HDMI_FRL_LINK_RATE_20GBPS:
+			frl_params->r_bit_nominal = 20.0e9;
+			break;
+		default:
+			break;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
index da2c92e5c02f..bfbc64163d01 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
@@ -680,12 +680,18 @@ static double calculate_compressed_active_time(uint32_t h_active,
 		r_bit_nominal = 8.0e9;
 		break;
 	case FRL_LINK_RATE_10GBPS:
-	default:
 		r_bit_nominal = 10.0e9;
 		break;
 	case FRL_LINK_RATE_12GBPS:
 		r_bit_nominal = 12.0e9;
 		break;
+	case FRL_LINK_RATE_16GBPS:
+		r_bit_nominal = 16.0e9;
+		break;
+	case FRL_LINK_RATE_20GBPS:
+	default:
+		r_bit_nominal = 20.0e9;
+		break;
 	}
 
 	f_tb_average = pix_clk / (h_active + h_blank)
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index ba4988118c68..febb6af43827 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -1290,6 +1290,14 @@ static bool convert_bandwidth_to_frl_params(
 		*num_lanes = 4;
 		*frl_rate = 12000;
 		break;
+	case 64000000:
+		*num_lanes = 4;
+		*frl_rate = 16000;
+		break;
+	case 80000000:
+		*num_lanes = 4;
+		*frl_rate = 20000;
+		break;
 	default:
 		return false;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c
index 0cfedd4268c6..5bb4ed1d1ba7 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c
@@ -60,7 +60,7 @@ void dsc60_construct(struct dcn60_dsc *dsc,
 	dsc->dsc_shift = dsc_shift;
 	dsc->dsc_mask = dsc_mask;
 
-	dsc->max_image_width = 5184;
+	dsc->max_image_width = 5760;
 }
 
 static void dsc60_init_reg_values(struct dsc60_reg_values *reg_vals)
@@ -181,7 +181,7 @@ static bool dsc60_prepare_config(const struct dsc_config *dsc_cfg, struct dsc60_
 
 	// TODO: in addition to validating slice height (pic height must be divisible by slice height),
 	// see what happens when the same condition doesn't apply for slice_width/pic_width.
-	dsc_reg_vals->pps.slice_width = (u16)(dsc_cfg->pic_width / dsc_cfg->dc_dsc_cfg.num_slices_h);
+	dsc_reg_vals->pps.slice_width = (u16)((dsc_cfg->pic_width + dsc_cfg->dsc_padding + dsc_cfg->dc_dsc_cfg.num_slices_h - 1) / dsc_cfg->dc_dsc_cfg.num_slices_h);
 	dsc_reg_vals->pps.slice_height = (u16)(dsc_cfg->pic_height / dsc_cfg->dc_dsc_cfg.num_slices_v);
 
 	ASSERT(dsc_reg_vals->pps.slice_height * dsc_cfg->dc_dsc_cfg.num_slices_v == dsc_cfg->pic_height);
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c
index 3f3704b68021..bded65896ef5 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c
@@ -32,135 +32,6 @@
 
 #define VBI_LINE_0 0
 
-/* setup stream encoder in hdmi mode */
-/* Precondition: link is trained */
-static void hpo_enc60_set_hdmi_stream_attribute(
-	struct hpo_frl_stream_encoder *enc,
-	struct dc_crtc_timing *crtc_timing,
-	struct frl_borrow_params *borrow_params,
-	int odm_combine_num_segments)
-{
-	(void)odm_combine_num_segments;
-	uint32_t h_active;
-	uint32_t h_blank;
-	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
-
-	DC_LOG_DEBUG("Entering [%s]\n", __func__);
-
-	/* Configure pixel encoding */
-	switch (crtc_timing->pixel_encoding) {
-	case PIXEL_ENCODING_YCBCR422:
-		REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
-				HDMI_PIXEL_ENCODING, 1);
-		REG_UPDATE_2(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
-				FIFO_PIXEL_ENCODING_TYPE, 0,
-				FIFO_UNCOMPRESSED_PIXEL_FORMAT, 0);
-		break;
-	case PIXEL_ENCODING_YCBCR420:
-		REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
-				HDMI_PIXEL_ENCODING, 2);
-		REG_UPDATE_2(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
-				FIFO_PIXEL_ENCODING_TYPE, 0,
-				FIFO_UNCOMPRESSED_PIXEL_FORMAT, 1);
-		break;
-	default:
-		REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
-				HDMI_PIXEL_ENCODING, 0);
-		REG_UPDATE_2(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
-				FIFO_PIXEL_ENCODING_TYPE, 0,
-				FIFO_UNCOMPRESSED_PIXEL_FORMAT, 0);
-		break;
-	}
-
-	/* Configure color depth */
-	switch (crtc_timing->display_color_depth) {
-	case COLOR_DEPTH_888:
-		REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
-				HDMI_DEEP_COLOR_DEPTH, 0,
-				HDMI_DEEP_COLOR_ENABLE, 0);
-		break;
-	case COLOR_DEPTH_101010:
-		if (crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
-			REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
-					HDMI_DEEP_COLOR_DEPTH, 1,
-					HDMI_DEEP_COLOR_ENABLE, 0);
-		} else {
-			REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
-					HDMI_DEEP_COLOR_DEPTH, 1,
-					HDMI_DEEP_COLOR_ENABLE, 1);
-		}
-		break;
-	case COLOR_DEPTH_121212:
-		if (crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
-			REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
-					HDMI_DEEP_COLOR_DEPTH, 2,
-					HDMI_DEEP_COLOR_ENABLE, 0);
-		} else {
-			REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
-					HDMI_DEEP_COLOR_DEPTH, 2,
-					HDMI_DEEP_COLOR_ENABLE, 1);
-		}
-		break;
-	default:
-		break;
-	}
-
-	/* When compression active, CD/PP/Phase field shall be zero in GCP */
-	if (crtc_timing->flags.DSC) {
-		REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
-				HDMI_DEEP_COLOR_DEPTH, 0,
-				HDMI_DEEP_COLOR_ENABLE, 0);
-	}
-
-	/* Configure horizontal active and blank size */
-	h_active = crtc_timing->h_addressable + crtc_timing->h_border_left + crtc_timing->h_border_right;
-	h_blank = crtc_timing->h_total - h_active;
-
-	if (crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 ||
-			crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
-		h_active /= 2;
-		h_blank /= 2;
-	}
-
-	REG_SET_2(HDMI_TB_ENC_H_ACTIVE_BLANK, 0,
-			HDMI_H_ACTIVE, h_active,
-			HDMI_H_BLANK, h_blank);
-
-	/* Configure borrow parameters */
-	REG_UPDATE(HDMI_TB_ENC_MODE,
-			HDMI_BORROW_MODE, borrow_params->borrow_mode);
-	REG_UPDATE(HDMI_TB_ENC_PACKET_CONTROL,
-			HDMI_MAX_PACKETS_PER_LINE, borrow_params->audio_packets_line);
-	REG_SET_2(HDMI_TB_ENC_HC_ACTIVE_BLANK, 0,
-			HDMI_HC_ACTIVE, borrow_params->hc_active_target,
-			HDMI_HC_BLANK, borrow_params->hc_blank_target);
-
-	/* Enable transmission of General Control packet on every frame */
-	REG_UPDATE_2(HDMI_TB_ENC_VBI_PACKET_CONTROL1,
-		HDMI_GC_CONT, 1,
-		HDMI_GC_SEND, 1);
-
-	/* Disable Audio Content Protection packet transmission */
-	/* TODO: review if this needs to be here */
-	REG_UPDATE(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_ACP_SEND, 0);
-
-	/* Enable Audio InfoFrame packet transmission. */
-	REG_UPDATE(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_AUDIO_INFO_SEND, 1);
-
-	/* update double-buffered AUDIO_INFO registers immediately */
-//	ASSERT(enc->afmt);
-//	enc->afmt->funcs->audio_info_immediate_update(enc->afmt);
-
-	/* Select line number on which to send Audio InfoFrame packets */
-	REG_UPDATE(HDMI_TB_ENC_VBI_PACKET_CONTROL1, HDMI_AUDIO_INFO_LINE,
-				VBI_LINE_0 + 2);
-
-	/* set HDMI GC AVMUTE */
-	REG_UPDATE(HDMI_TB_ENC_GC_CONTROL, HDMI_GC_AVMUTE, 0);
-
-	DC_LOG_DEBUG("Exiting [%s]\n", __func__);
-}
-
 static void hpo_enc60_audio_mute_control(
 	struct hpo_frl_stream_encoder *enc,
 	bool mute)
@@ -321,7 +192,7 @@ static const struct hpo_frl_stream_encoder_funcs dcn401_str_enc_funcs = {
 	.hdmi_frl_enable		= hpo_enc401_enable,
 	.hdmi_frl_unblank		= hpo_enc401_unblank,
 	.hdmi_frl_blank			= hpo_enc401_blank,
-	.hdmi_frl_set_stream_attribute	= hpo_enc60_set_hdmi_stream_attribute,
+	.hdmi_frl_set_stream_attribute	= hpo_enc401_set_hdmi_stream_attribute,
 	.validate_hdmi_frl_output	= hpo_enc3_validate_hdmi_frl_output,
 	.update_hdmi_info_packets	= hpo_enc401_update_hdmi_info_packets,
 	.stop_hdmi_info_packets		= hpo_enc401_stop_hdmi_info_packets,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 1384197578ec..12fd4fd24a90 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -995,6 +995,8 @@ static bool should_verify_link_capability_destructively(struct dc_link *link,
 					}
 				}
 			}
+		} else if (link->dc->debug.skip_detection_link_training) {
+			destrictive = false;
 		}
 	}
 
-- 
2.43.0

