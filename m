Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEFEC54EAA
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01DDF10E3B5;
	Thu, 26 Jan 2023 00:34:06 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C70110E3B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBGZIU3E2PhfHv+X1aTQlZTI2YAcYlf+pLznUw4vM/iUqfsQatJgNDPDCyB/569lTNyYkuZ+7sKc/7XPWoXP4c59J0bDXQNZrwj/LvdO9xjZ5etkfgxG4Kj1PmlR/oZkWOHKpRiUQLQtcSkrn1+2Xa46AtVynpzyHMCV/YjVfpxvZMtcvN/Cs3jA3Uy15zmzPjMfHRNknf6LBY7k8EPc7o5CAylF+4UPcfsMtFT/3AJgSA5uS9HRsqW+tVgSjXhUto18jJXJ2uChGAUzV4UA1N/88HVlzKpgbZfIFb8gq7W0VHe1TaVXuvAMCWU1ZOWM3c3KOP7ROSG7BOsNH9GwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ANqxjEadx2utlpXQs4lPHjMvoi7JNVhLPKIakI7h3E=;
 b=fi/cZBTt/QNvtzEpqZkJ7XGPbbp88fQSkYp/kmq+4pqxbvS7Lb+37xgT60eOyNTtbdcivPaj6gyCIdQHFeeeDaMOGRQCr0zBVpG7JD11U5HHK1KynzwF/vY233rmiGLEj17aXN+XKlaZzaP1ihzfjPjTarjf9J9AlwhWXGhRSLLq2yJyP/6eDGDZLZrylR7ZdeIc5aOukM46o8+no5jXOyvPBMJRPCVNs/J42dufBf4rxwBbEAB0XmIJB5u2kMTCJJuMn3I1ZiVgDlfVq8As5PC8qQspa83Hc0Potjk54wZvIk5qzQqKwKbLj0SFkjVGdVCBlOQdl2TCLfAryJnZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ANqxjEadx2utlpXQs4lPHjMvoi7JNVhLPKIakI7h3E=;
 b=jqxPxAxzW1zZOtw6Ktnr9Yp2USDZcmBNLhAcycD7QKbK4ZVhI2dnYvODO/H3qQLQMX/QJdA8tJkSEo6DDgfo3O3oYNRNfz1f7pXtVSNV+rWRR90FD20A9JYnlB1oSl/2TYweYKwkSzYQGQdjdjtx9ZigBcwZPyt57+9XN9RY3tw=
Received: from DS7P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::20) by
 MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Thu, 26 Jan 2023 00:33:59 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::e3) by DS7P222CA0021.outlook.office365.com
 (2603:10b6:8:2e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Thu, 26 Jan 2023 00:33:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.17 via Frontend Transport; Thu, 26 Jan 2023 00:33:59 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:33:56 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/16] drm/amd/display: add rc_params_override option in
 dc_dsc_config
Date: Wed, 25 Jan 2023 17:32:16 -0700
Message-ID: <20230126003230.4178466-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126003230.4178466-1-alex.hung@amd.com>
References: <20230126003230.4178466-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 71938ac8-2424-46e2-d7f9-08daff350428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+N9ISpmyLIOYCeICMM6hJwHus82Ppa54ZFTTNvcVLxkukBd1QVsSpMbt7J9Kg/Kq0LE5Uf+Cav5jEfSGxcw7h+7gfiTOfkvlrGS5O1AHlQ0a/DA4UXttfNG/ekuZ7IvKpULEOF1+9UFcTlD1ZOI0w+sZfAYNyceTgpV00I68owWjwTgJ/XrgXgwfBq77MJOrEtv/cNUcKnk4h+Ke6p78o3pgoopZ5v9k4cJgS0QyjkB4IgCM5whMPlukqv+Qg62dlq6rB/8lngdKGNM0PZPYq19dgV3X+/gliZ1GsfmD0oIvohj/o5juX9NuyJn932pJE0Tbv9ws3pecT1Qf3KTw/hRkWqrtZaVaGwg2NVZwFCFbuty3/6IdlnFj18j2APnb9Z5SI+qKRZ2SfnxgTqtaFAUvLS7CuC8ZfW2fuRiyOvUfiZnGX+NoC9B1rIWJ2WaNIS1gQUxuPvD+TEnCXlmtJXQKpMsSEY0TyABSEaUZwHFa+gVpsSYNbUrHWdzVnc/fX8KS6Fa6qoFDD7gKGV6StVipHMljzGv9HSeC0BLPKS1ONys/zNhaBJG0YDXYn+SxN7MHCxUedzIcASmI55oLp9LYcehxoUcXSpCUp8f0OZgQvQ06zoRdLOSrIzqKcz+B0hWgVeucU5Hrcn3MWh8r57e9LrStVjgPf24geWepAUtk/XkRptJuzZCHM9y5oAsHkdRpntAfUBMwcVO8ck+e+IxTO/Msk4lbJQGexG/iec=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(82740400003)(40460700003)(81166007)(356005)(36756003)(40480700001)(478600001)(336012)(82310400005)(8676002)(316002)(54906003)(6916009)(86362001)(4326008)(70206006)(426003)(70586007)(2616005)(7696005)(1076003)(36860700001)(47076005)(2906002)(16526019)(6666004)(41300700001)(26005)(44832011)(5660300002)(8936002)(186003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:33:59.3700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71938ac8-2424-46e2-d7f9-08daff350428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Current RC params are based on VESA recommended configurations.
Some DSC sink may prefer non standard rc params values due to
hardware limitations. To support those DSC sink we will allow DM to
optionally pass rc_params_ovrd in dc_dsc_config so DC will override
the default VESA recommended configurations.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  | 24 +++++++++++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  | 36 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/dsc/dscc_types.h   |  5 ++-
 .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  | 10 +++---
 4 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 848db8676adf..cc3d6fb39364 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -797,6 +797,29 @@ enum dc_timing_3d_format {
 	TIMING_3D_FORMAT_MAX,
 };
 
+#define DC_DSC_QP_SET_SIZE 15
+#define DC_DSC_RC_BUF_THRESH_SIZE 14
+struct dc_dsc_rc_params_override {
+	int32_t rc_model_size;
+	int32_t rc_buf_thresh[DC_DSC_RC_BUF_THRESH_SIZE];
+	int32_t rc_minqp[DC_DSC_QP_SET_SIZE];
+	int32_t rc_maxqp[DC_DSC_QP_SET_SIZE];
+	int32_t rc_offset[DC_DSC_QP_SET_SIZE];
+
+	int32_t rc_tgt_offset_hi;
+	int32_t rc_tgt_offset_lo;
+	int32_t rc_edge_factor;
+	int32_t rc_quant_incr_limit0;
+	int32_t rc_quant_incr_limit1;
+
+	int32_t initial_fullness_offset;
+	int32_t initial_delay;
+
+	int32_t flatness_min_qp;
+	int32_t flatness_max_qp;
+	int32_t flatness_det_thresh;
+};
+
 struct dc_dsc_config {
 	uint32_t num_slices_h; /* Number of DSC slices - horizontal */
 	uint32_t num_slices_v; /* Number of DSC slices - vertical */
@@ -811,6 +834,7 @@ struct dc_dsc_config {
 #endif
 	bool is_dp; /* indicate if DSC is applied based on DP's capability */
 	uint32_t mst_pbn; /* pbn of display on dsc mst hub */
+	const struct dc_dsc_rc_params_override *rc_params_ovrd; /* DM owned memory. If not NULL, apply custom dsc rc params */
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index c08c01e05dcf..42344aec60d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -28,6 +28,7 @@
 #include "reg_helper.h"
 #include "dcn20_dsc.h"
 #include "dsc/dscc_types.h"
+#include "dsc/rc_calc.h"
 
 static void dsc_log_pps(struct display_stream_compressor *dsc, struct drm_dsc_config *pps);
 static bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_values *dsc_reg_vals,
@@ -344,10 +345,38 @@ static void dsc_log_pps(struct display_stream_compressor *dsc, struct drm_dsc_co
 	}
 }
 
+static void dsc_override_rc_params(struct rc_params *rc, const struct dc_dsc_rc_params_override *override)
+{
+	uint8_t i;
+
+	rc->rc_model_size = override->rc_model_size;
+	for (i = 0; i < DC_DSC_RC_BUF_THRESH_SIZE; i++)
+		rc->rc_buf_thresh[i] = override->rc_buf_thresh[i];
+	for (i = 0; i < DC_DSC_QP_SET_SIZE; i++) {
+		rc->qp_min[i] = override->rc_minqp[i];
+		rc->qp_max[i] = override->rc_maxqp[i];
+		rc->ofs[i] = override->rc_offset[i];
+	}
+
+	rc->rc_tgt_offset_hi = override->rc_tgt_offset_hi;
+	rc->rc_tgt_offset_lo = override->rc_tgt_offset_lo;
+	rc->rc_edge_factor = override->rc_edge_factor;
+	rc->rc_quant_incr_limit0 = override->rc_quant_incr_limit0;
+	rc->rc_quant_incr_limit1 = override->rc_quant_incr_limit1;
+
+	rc->initial_fullness_offset = override->initial_fullness_offset;
+	rc->initial_xmit_delay = override->initial_delay;
+
+	rc->flatness_min_qp = override->flatness_min_qp;
+	rc->flatness_max_qp = override->flatness_max_qp;
+	rc->flatness_det_thresh = override->flatness_det_thresh;
+}
+
 static bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_values *dsc_reg_vals,
 			struct dsc_optc_config *dsc_optc_cfg)
 {
 	struct dsc_parameters dsc_params;
+	struct rc_params rc;
 
 	/* Validate input parameters */
 	ASSERT(dsc_cfg->dc_dsc_cfg.num_slices_h);
@@ -412,7 +441,12 @@ static bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_
 	dsc_reg_vals->pps.native_420 = (dsc_reg_vals->pixel_format == DSC_PIXFMT_NATIVE_YCBCR420);
 	dsc_reg_vals->pps.simple_422 = (dsc_reg_vals->pixel_format == DSC_PIXFMT_SIMPLE_YCBCR422);
 
-	if (dscc_compute_dsc_parameters(&dsc_reg_vals->pps, &dsc_params)) {
+	calc_rc_params(&rc, &dsc_reg_vals->pps);
+
+	if (dsc_cfg->dc_dsc_cfg.rc_params_ovrd)
+		dsc_override_rc_params(&rc, dsc_cfg->dc_dsc_cfg.rc_params_ovrd);
+
+	if (dscc_compute_dsc_parameters(&dsc_reg_vals->pps, &rc, &dsc_params)) {
 		dm_output_to_console("%s: DSC config failed\n", __func__);
 		return false;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dscc_types.h b/drivers/gpu/drm/amd/display/dc/dsc/dscc_types.h
index ad80bde9bc0f..31574940ccc7 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dscc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dscc_types.h
@@ -46,7 +46,10 @@ struct dsc_parameters {
 	uint32_t rc_buffer_model_size;
 };
 
-int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps, struct dsc_parameters *dsc_params);
+struct rc_params;
 
+int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps,
+		const struct rc_params *rc,
+		struct dsc_parameters *dsc_params);
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
index f0aea988fef0..36d6c1646a51 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
@@ -95,19 +95,19 @@ static void copy_rc_to_cfg(struct drm_dsc_config *dsc_cfg, const struct rc_param
 		dsc_cfg->rc_buf_thresh[i] = rc->rc_buf_thresh[i];
 }
 
-int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps, struct dsc_parameters *dsc_params)
+int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps,
+		const struct rc_params *rc,
+		struct dsc_parameters *dsc_params)
 {
 	int              ret;
-	struct rc_params rc;
 	struct drm_dsc_config   dsc_cfg;
 	unsigned long long tmp;
 
-	calc_rc_params(&rc, pps);
 	dsc_params->pps = *pps;
-	dsc_params->pps.initial_scale_value = 8 * rc.rc_model_size / (rc.rc_model_size - rc.initial_fullness_offset);
+	dsc_params->pps.initial_scale_value = 8 * rc->rc_model_size / (rc->rc_model_size - rc->initial_fullness_offset);
 
 	copy_pps_fields(&dsc_cfg, &dsc_params->pps);
-	copy_rc_to_cfg(&dsc_cfg, &rc);
+	copy_rc_to_cfg(&dsc_cfg, rc);
 
 	dsc_cfg.mux_word_size = dsc_params->pps.bits_per_component <= 10 ? 48 : 64;
 
-- 
2.39.1

