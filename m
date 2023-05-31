Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B26C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 04:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F18F310E475;
	Wed, 31 May 2023 04:49:44 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D33F10E478
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 04:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEF5e1460/XSmZx4U4ttypzURaoO9gWk34oxvjG5qzQqAQ60WLvEW0QzYOlOYfga8tRZYKWp400+MDH7MumH2dAh5yuSu87s0yXq7crf9tXw2mVZON1O6wixHCScZ5mM0wTOgdJZ+p/JPXmhZ/RKkXfgqRO6m50XFRavgWXxhsPbTDG/MNjfAJFzwZ+tQaz4MdMlr7tqqLjy+sCH/9KkqG3faptShEOQ6zhCDXF2+WanDOsfgFRkjDZY4XpKtMx5veUzYlhNp0GGKPUrXGm+yBTZV+KkieodtL2i0GCQg9YN3/JwlM+5eCGcdBJvjz25HOq8YRf1mxo6d0shypSPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2E9KBkIsznwbil9DUUgxIYi3sx62pusL6HYlBLlqTBU=;
 b=l8gIFzNjQ76VdcFL3ro963B2SMEQiHX2YMIVBK0/etH/sXDxS8SOYwYQOej6a+U9ZmevGO2JUZ0hsdAEOGS8Me8ztiIVkeIfIJo8T86GKcbxlB/kZtlyJA7E0SXRj527PY6sBac4A13EfUWBqzkJ9716c55D3a9WI3KO0xIYf5yt+oaKmlcjyLjM5SkAaLNP2BDQnRE+jWiF8EX3ZwRxGYz/I2xKqzTFRd5f3SSHuKyazpbdx4fDstQTZxNOD/+kKo3shXVOkOhJ45Xa7DUVRcQ8Zd9lKPhK6jqNgmqhbweYi7AyzaBaDjnDOI9fmxM1JfgBSe+LCot1ChlZjP1r7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E9KBkIsznwbil9DUUgxIYi3sx62pusL6HYlBLlqTBU=;
 b=pT8N9noDk1ydnVNomIEz5Ha2SGoDp26VFo2GtOx0pOghFxMkrm6alQ5CmFEpufbpQkRebBfNEo2yX4uJ1ymojuPxKLvcesaot6Cez4BQ+E3BHH/QvORQlISjn8h6tqD+YhXKzuXHYumznoA39HfcqrS3Gf/07WUZXypd3zdLoTs=
Received: from BN9PR03CA0888.namprd03.prod.outlook.com (2603:10b6:408:13c::23)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 04:49:40 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::f6) by BN9PR03CA0888.outlook.office365.com
 (2603:10b6:408:13c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 04:49:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:49:39 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:49:35 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amd/display: DSC Programming Deltas
Date: Wed, 31 May 2023 12:48:10 +0800
Message-ID: <20230531044813.145361-12-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531044813.145361-1-stylon.wang@amd.com>
References: <20230531044813.145361-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT053:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: da86889f-898f-438c-453b-08db61927142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ojz3sDd2I/L9XCFwrc4y4StyvIf93x89aGZ33Zq1405hJMkW0Geb+xlO/EscdmU2Yk4mOQFQYOM3Y8Px5Plnw0TUmAk141ohb7O6sZ1/oIBdSxx4Qe8c9pPhpvi+grcN1SdB3FH+7OqzX4sFXapDIkPXIBjZourDswzxR+zdK/kLvW1d1PmL0WSfBV8SshYfQpgne0ikuAfhssDvoH7qg3ZcsV7qhvzd9LDZxekDbt9cRJRVjXkZQWIkS0qd7Le3gR7d9tTiqb3XPBQIgbcQRkI02hV778ew4kdRwpXUibHnVH52ObaKVUdm9g0dSJIAuNtIouZ3ButQoMt8EzP1gcX4MLSeWjh3vr8nKmM2j3k9nK7HQnW0oE5hRCl4LPjvKm6Ih96fabLy4SvHX+B0fiDW97t6GYyiOaozKx2MNaabbMvOKORUUV6YvMoQlxDaLxAAEpcURke5opl7ciWjw6KSOSMX3QWAbDZMw0/RsTOt8vqJxv2ewHEFjMuZXW9nxyWw9jDd3sp9ZRLUIID84vasxFCknFgYX1B55uqmOJBgF/KPIFRtS2/T2Yps3UjXGZ0C7Tcpy/WQFQ99BukCWzDXrs1jkmdAlydj84yU1s54GSeAI2649tdQ2C1k4T+zxE9Li+fmIPOR2PUm9f7Oo8Lg660LwLbTvXeID08og/B4Zto1geIIxt8hG7+RaW0PfUI5GtXKhmBYNZ2EwrYgQKqjBT1xqiEtn97IxvFzctJYVKXWHs9kJ450cZj5lJnTIcYHfQ7hUV0d+ueUON7JA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(478600001)(40460700003)(8936002)(5660300002)(8676002)(44832011)(36756003)(2906002)(86362001)(82310400005)(4326008)(6916009)(356005)(81166007)(70586007)(70206006)(316002)(82740400003)(40480700001)(41300700001)(2616005)(16526019)(186003)(26005)(1076003)(36860700001)(47076005)(6666004)(7696005)(426003)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:49:39.5876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da86889f-898f-438c-453b-08db61927142
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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
Cc: stylon.wang@amd.com, Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Sridevi <sarvinde@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sridevi <sarvinde@amd.com>

[Why]
Programming register delta for DSC sub-block

[How]
Change DSC, resource files for programming register delta.

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Sridevi <sarvinde@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  | 29 +++++++------------
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h  | 28 ++++++++++++++++++
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index 5bd698cd6d20..5eebe7f03ddc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -30,22 +30,13 @@
 #include "dsc/dscc_types.h"
 #include "dsc/rc_calc.h"
 
-static void dsc_log_pps(struct display_stream_compressor *dsc, struct drm_dsc_config *pps);
-static bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_values *dsc_reg_vals,
-			struct dsc_optc_config *dsc_optc_cfg);
-static void dsc_init_reg_values(struct dsc_reg_values *reg_vals);
-static void dsc_update_from_dsc_parameters(struct dsc_reg_values *reg_vals, const struct dsc_parameters *dsc_params);
 static void dsc_write_to_registers(struct display_stream_compressor *dsc, const struct dsc_reg_values *reg_vals);
-static enum dsc_pixel_format dsc_dc_pixel_encoding_to_dsc_pixel_format(enum dc_pixel_encoding dc_pix_enc, bool is_ycbcr422_simple);
-static enum dsc_bits_per_comp dsc_dc_color_depth_to_dsc_bits_per_comp(enum dc_color_depth);
 
 /* Object I/F functions */
-static void dsc2_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz);
 static void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s);
 static bool dsc2_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg);
 static void dsc2_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
 		struct dsc_optc_config *dsc_optc_cfg);
-static bool dsc2_get_packed_pps(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg, uint8_t *dsc_packed_pps);
 static void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe);
 static void dsc2_disable(struct display_stream_compressor *dsc);
 static void dsc2_disconnect(struct display_stream_compressor *dsc);
@@ -108,7 +99,7 @@ void dsc2_construct(struct dcn20_dsc *dsc,
 /* This returns the capabilities for a single DSC encoder engine. Number of slices and total throughput
  * can be doubled, tripled etc. by using additional DSC engines.
  */
-static void dsc2_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz)
+void dsc2_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz)
 {
 	dsc_enc_caps->dsc_version = 0x21; /* v1.2 - DP spec defined it in reverse order and we kept it */
 
@@ -184,7 +175,7 @@ static bool dsc2_validate_stream(struct display_stream_compressor *dsc, const st
 }
 
 
-static void dsc_config_log(struct display_stream_compressor *dsc, const struct dsc_config *config)
+void dsc_config_log(struct display_stream_compressor *dsc, const struct dsc_config *config)
 {
 	DC_LOG_DSC("\tnum_slices_h %d", config->dc_dsc_cfg.num_slices_h);
 	DC_LOG_DSC("\tnum_slices_v %d", config->dc_dsc_cfg.num_slices_v);
@@ -211,7 +202,7 @@ static void dsc2_set_config(struct display_stream_compressor *dsc, const struct
 }
 
 
-static bool dsc2_get_packed_pps(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg, uint8_t *dsc_packed_pps)
+bool dsc2_get_packed_pps(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg, uint8_t *dsc_packed_pps)
 {
 	bool is_config_ok;
 	struct dsc_reg_values dsc_reg_vals;
@@ -291,7 +282,7 @@ static void dsc2_disconnect(struct display_stream_compressor *dsc)
 }
 
 /* This module's internal functions */
-static void dsc_log_pps(struct display_stream_compressor *dsc, struct drm_dsc_config *pps)
+void dsc_log_pps(struct display_stream_compressor *dsc, struct drm_dsc_config *pps)
 {
 	int i;
 	int bits_per_pixel = pps->bits_per_pixel;
@@ -345,7 +336,7 @@ static void dsc_log_pps(struct display_stream_compressor *dsc, struct drm_dsc_co
 	}
 }
 
-static void dsc_override_rc_params(struct rc_params *rc, const struct dc_dsc_rc_params_override *override)
+void dsc_override_rc_params(struct rc_params *rc, const struct dc_dsc_rc_params_override *override)
 {
 	uint8_t i;
 
@@ -372,7 +363,7 @@ static void dsc_override_rc_params(struct rc_params *rc, const struct dc_dsc_rc_
 	rc->flatness_det_thresh = override->flatness_det_thresh;
 }
 
-static bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_values *dsc_reg_vals,
+bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_values *dsc_reg_vals,
 			struct dsc_optc_config *dsc_optc_cfg)
 {
 	struct dsc_parameters dsc_params;
@@ -463,7 +454,7 @@ static bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_
 }
 
 
-static enum dsc_pixel_format dsc_dc_pixel_encoding_to_dsc_pixel_format(enum dc_pixel_encoding dc_pix_enc, bool is_ycbcr422_simple)
+enum dsc_pixel_format dsc_dc_pixel_encoding_to_dsc_pixel_format(enum dc_pixel_encoding dc_pix_enc, bool is_ycbcr422_simple)
 {
 	enum dsc_pixel_format dsc_pix_fmt = DSC_PIXFMT_UNKNOWN;
 
@@ -495,7 +486,7 @@ static enum dsc_pixel_format dsc_dc_pixel_encoding_to_dsc_pixel_format(enum dc_p
 }
 
 
-static enum dsc_bits_per_comp dsc_dc_color_depth_to_dsc_bits_per_comp(enum dc_color_depth dc_color_depth)
+enum dsc_bits_per_comp dsc_dc_color_depth_to_dsc_bits_per_comp(enum dc_color_depth dc_color_depth)
 {
 	enum dsc_bits_per_comp bpc = DSC_BPC_UNKNOWN;
 
@@ -518,7 +509,7 @@ static enum dsc_bits_per_comp dsc_dc_color_depth_to_dsc_bits_per_comp(enum dc_co
 }
 
 
-static void dsc_init_reg_values(struct dsc_reg_values *reg_vals)
+void dsc_init_reg_values(struct dsc_reg_values *reg_vals)
 {
 	int i;
 
@@ -574,7 +565,7 @@ static void dsc_init_reg_values(struct dsc_reg_values *reg_vals)
  * This is required because dscc_compute_dsc_parameters returns a modified PPS, which in turn
  * affects non-PPS register values.
  */
-static void dsc_update_from_dsc_parameters(struct dsc_reg_values *reg_vals, const struct dsc_parameters *dsc_params)
+void dsc_update_from_dsc_parameters(struct dsc_reg_values *reg_vals, const struct dsc_parameters *dsc_params)
 {
 	int i;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
index 7ce64a3c1b02..ba869387c3c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
@@ -549,6 +549,27 @@ struct dcn20_dsc {
 	int max_image_width;
 };
 
+void dsc_config_log(struct display_stream_compressor *dsc,
+		const struct dsc_config *config);
+
+void dsc_log_pps(struct display_stream_compressor *dsc,
+		struct drm_dsc_config *pps);
+
+void dsc_override_rc_params(struct rc_params *rc,
+		const struct dc_dsc_rc_params_override *override);
+
+bool dsc_prepare_config(const struct dsc_config *dsc_cfg,
+		struct dsc_reg_values *dsc_reg_vals,
+		struct dsc_optc_config *dsc_optc_cfg);
+
+enum dsc_pixel_format dsc_dc_pixel_encoding_to_dsc_pixel_format(enum dc_pixel_encoding dc_pix_enc,
+		bool is_ycbcr422_simple);
+
+enum dsc_bits_per_comp dsc_dc_color_depth_to_dsc_bits_per_comp(enum dc_color_depth dc_color_depth);
+
+void dsc_init_reg_values(struct dsc_reg_values *reg_vals);
+
+void dsc_update_from_dsc_parameters(struct dsc_reg_values *reg_vals, const struct dsc_parameters *dsc_params);
 
 void dsc2_construct(struct dcn20_dsc *dsc,
 		struct dc_context *ctx,
@@ -557,5 +578,12 @@ void dsc2_construct(struct dcn20_dsc *dsc,
 		const struct dcn20_dsc_shift *dsc_shift,
 		const struct dcn20_dsc_mask *dsc_mask);
 
+void dsc2_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps,
+		int pixel_clock_100Hz);
+
+bool dsc2_get_packed_pps(struct display_stream_compressor *dsc,
+		const struct dsc_config *dsc_cfg,
+		uint8_t *dsc_packed_pps);
+
 #endif
 
-- 
2.40.1

