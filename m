Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE02DC7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48EFC10E6C7;
	Fri,  3 Mar 2023 15:44:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A2B10E6C7
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OP7QbjehBWjla3KiP/8O9NYCgx4Q21/siccAEF+bwpiDXXHJu/irwB6IjdNy+KqIcwadhcMQ8uLvtfckTfuYJl29vuK1SSWYrJQ9xaWJs1eWsNa8KI6VBRrQHuf86UEBm/C1uAmxCR+B1wYBNp3zmJjl9uMOEBx05wa0JhC9Q5kINtBOO+ZV5E+QRZTBkqFhyMjzWWEjrJULICBwQG6kurNjvTPsMSTJvBTK2rN3f1LD5zBpP8QVhE/iquNpwaXDp6yHWCVLpdmPX7P45joxr4pOY4z+xKld/AHqz/WehElIzBsM/86BelQCCBcouq7TJJQ2MdgyviZH3oOXDSDm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mjCrUsDEu2vZ1OYZijEq6U/7W2OmS3Tb/8cJTnmK/g=;
 b=e8ih/o2asUoVk9WWP6Nq3RU+vlbs7yGMlVHMcBaKrmEuCEaUGLWfhsmvAVNlCtXklLQcONk8RUzogsCxdbh9ahl+F/5SwTEzpFUgXW/6qhsnAUgRN/wKCf2v+wCydEcJbjcJK7kCsGoWrFYEfmgdFmrh0FxPpFI5BkOW19503nG1bcQ7NODsTN3/WEfQawdZ+8JVPPItA2MP0RD4H1n2LFA/JvPALv2IS+SRRWqhufdkhBn2aciuwHZ9WaUYFjmmAFZABxtFVPbavBzQEyTgGnU54xp+eGthq/X/G/WUmFA0VcMPp2MNKXiG7yiJKHYqPD6IT5uXJO3ocQMlnYh6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mjCrUsDEu2vZ1OYZijEq6U/7W2OmS3Tb/8cJTnmK/g=;
 b=EYr+RU4Mv0XAneOMNd8Z7ZKsoib4ryzxRukNEWco5BknHAdOFniw9Mx/e7VLLX0NvW4XrLgc6kW7Uks5Hyr/OhxuYehPnZObkSy60tsjIVE9nY0K2qQra2RLJDz+CFJSOn4WJysEqyIC1K6b/KB2+p2fAYQtlb99pawaJIxShfE=
Received: from MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30)
 by CH0PR12MB5300.namprd12.prod.outlook.com (2603:10b6:610:d7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 15:44:03 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::99) by MW4PR04CA0115.outlook.office365.com
 (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.22 via Frontend Transport; Fri, 3 Mar 2023 15:44:03 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:43:52 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/33] drm/amd/display: Add height granularity limitation for
 dsc slice height calculation
Date: Fri, 3 Mar 2023 10:39:50 -0500
Message-ID: <20230303154022.2667-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|CH0PR12MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: a0765af1-59d4-4e0f-7b32-08db1bfe1d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRuVtn0qv61TsQDmis83U7HFApAnVRwZ22tiIX6tubonw5YEkbdH/fGHlSKej3316aR8tsiNbX0qLajnN75pPBiri/XPzJ21OS4dmHu0Zft95FS9Wg5/Yh1lzTFgXHbVfpHJWVZa4+E/PnZgodtpDrQNUXtt2xauZTK60Vez2gX5wME5zpt5OGH2Byk7RMRMPKpCFUI3WohOjQff7/1aqB97Z+DnJOxY/+1Zsy3BQj+Dzjh+RY8kqGLHQOxSIiYNKLMmBXZbn7DqahXsgeBYAcE0BVks25XGLePQHPLGxjk4qsPWScQDycQy4kljYcUtl98rG9H3OhaQOeavytOTOlkJ7SHNV1IKGtrYEWI7YpOIvLcrU1sTBYyi+Wk8aBLq1Z/wACX4bT1Y+JiCETyckTvI96VfbVHcdsjU/L0l/ai4OeHsI04LfHkvH7hYPYqeE+009sBQ8S3U1XvX6OZjr5wEsVwH7sUlu1AaE5wtlmkuUBAqJOOjp2TScxXs7jhMEhpw2kElm8d2tQA3xo5EpCkjK9BcGeX0/KtzyEotxP0OWIlWqMbErOpueZAfmnyx6tzBHy6d7GhwGEUFNxC1Gaf9Ci7SF0pXizHrMTwrx/f+DXV/JCuZbukrrXXQ1xH6Bi6mOh0DaOypkeQ/UbQX+XBW1qLfElW5VysBHZ4//ky4uhqnWZdBQ5QM2og/eeLR6xTg2GCCpogKVE9lj6Jt1o/O/uc9b4whijMH7777UgA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199018)(36840700001)(46966006)(40470700004)(30864003)(2906002)(44832011)(5660300002)(41300700001)(8936002)(6916009)(4326008)(8676002)(83380400001)(82310400005)(70206006)(70586007)(54906003)(316002)(40460700003)(478600001)(26005)(1076003)(336012)(426003)(47076005)(2616005)(40480700001)(86362001)(16526019)(81166007)(82740400003)(36756003)(186003)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:44:03.2687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0765af1-59d4-4e0f-7b32-08db1bfe1d89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5300
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
Cc: stylon.wang@amd.com, Mike Hsieh <Mike.Hsieh@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Cruise Hung <Cruise.Hung@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mike Hsieh <Mike.Hsieh@amd.com>

[WHY]
eDP add new limitation for Y granularity for selected update feature.
DSC does not include this limitation while calculating slice height.

[HOW]
Add new limitation while looking for DSC slice height.

Reviewed-by: Cruise Hung <Cruise.Hung@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Mike Hsieh <Mike.Hsieh@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++-----
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 16 +++++----
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       | 11 +++++--
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 33 ++++++++++++-------
 4 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4217ebe6391b..553406ec24bf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5785,6 +5785,10 @@ static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnector,
 	struct dc *dc = sink->ctx->dc;
 	struct dc_dsc_bw_range bw_range = {0};
 	struct dc_dsc_config dsc_cfg = {0};
+	struct dc_dsc_config_options dsc_options = {0};
+
+	dc_dsc_get_default_config_option(dc, &dsc_options);
+	dsc_options.max_target_bpp_limit_override_x16 = max_dsc_target_bpp_limit_override * 16;
 
 	verified_link_cap = dc_link_get_link_cap(stream->link);
 	link_bw_in_kbps = dc_link_bandwidth_kbps(stream->link, verified_link_cap);
@@ -5807,8 +5811,7 @@ static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnector,
 		if (bw_range.max_kbps < link_bw_in_kbps) {
 			if (dc_dsc_compute_config(dc->res_pool->dscs[0],
 					dsc_caps,
-					dc->debug.dsc_min_slice_height_override,
-					max_dsc_target_bpp_limit_override,
+					&dsc_options,
 					0,
 					&stream->timing,
 					&dsc_cfg)) {
@@ -5822,8 +5825,7 @@ static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnector,
 
 	if (dc_dsc_compute_config(dc->res_pool->dscs[0],
 				dsc_caps,
-				dc->debug.dsc_min_slice_height_override,
-				max_dsc_target_bpp_limit_override,
+				&dsc_options,
 				link_bw_in_kbps,
 				&stream->timing,
 				&dsc_cfg)) {
@@ -5844,6 +5846,10 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 	u32 dsc_max_supported_bw_in_kbps;
 	u32 max_dsc_target_bpp_limit_override =
 		drm_connector->display_info.max_dsc_bpp;
+	struct dc_dsc_config_options dsc_options = {0};
+
+	dc_dsc_get_default_config_option(dc, &dsc_options);
+	dsc_options.max_target_bpp_limit_override_x16 = max_dsc_target_bpp_limit_override * 16;
 
 	link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
 							dc_link_get_link_cap(aconnector->dc_link));
@@ -5862,8 +5868,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 		if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE) {
 			if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
 						dsc_caps,
-						aconnector->dc_link->ctx->dc->debug.dsc_min_slice_height_override,
-						max_dsc_target_bpp_limit_override,
+						&dsc_options,
 						link_bandwidth_kbps,
 						&stream->timing,
 						&stream->timing.dsc_cfg)) {
@@ -5880,8 +5885,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 					dsc_max_supported_bw_in_kbps > 0)
 				if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
 						dsc_caps,
-						aconnector->dc_link->ctx->dc->debug.dsc_min_slice_height_override,
-						max_dsc_target_bpp_limit_override,
+						&dsc_options,
 						dsc_max_supported_bw_in_kbps,
 						&stream->timing,
 						&stream->timing.dsc_cfg)) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index e25e1b2bf194..e10ed2935971 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -678,16 +678,19 @@ static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *p
 {
 	struct drm_connector *drm_connector;
 	int i;
+	struct dc_dsc_config_options dsc_options = {0};
 
 	for (i = 0; i < count; i++) {
 		drm_connector = &params[i].aconnector->base;
 
+		dc_dsc_get_default_config_option(params[i].sink->ctx->dc, &dsc_options);
+		dsc_options.max_target_bpp_limit_override_x16 = drm_connector->display_info.max_dsc_bpp * 16;
+
 		memset(&params[i].timing->dsc_cfg, 0, sizeof(params[i].timing->dsc_cfg));
 		if (vars[i + k].dsc_enabled && dc_dsc_compute_config(
 					params[i].sink->ctx->dc->res_pool->dscs[0],
 					&params[i].sink->dsc_caps.dsc_dec_caps,
-					params[i].sink->ctx->dc->debug.dsc_min_slice_height_override,
-					drm_connector->display_info.max_dsc_bpp,
+					&dsc_options,
 					0,
 					params[i].timing,
 					&params[i].timing->dsc_cfg)) {
@@ -730,15 +733,16 @@ static int bpp_x16_from_pbn(struct dsc_mst_fairness_params param, int pbn)
 	u64 kbps;
 
 	struct drm_connector *drm_connector = &param.aconnector->base;
-	uint32_t max_dsc_target_bpp_limit_override =
-		drm_connector->display_info.max_dsc_bpp;
+	struct dc_dsc_config_options dsc_options = {0};
+
+	dc_dsc_get_default_config_option(param.sink->ctx->dc, &dsc_options);
+	dsc_options.max_target_bpp_limit_override_x16 = drm_connector->display_info.max_dsc_bpp * 16;
 
 	kbps = div_u64((u64)pbn * 994 * 8 * 54, 64);
 	dc_dsc_compute_config(
 			param.sink->ctx->dc->res_pool->dscs[0],
 			&param.sink->dsc_caps.dsc_dec_caps,
-			param.sink->ctx->dc->debug.dsc_min_slice_height_override,
-			max_dsc_target_bpp_limit_override,
+			&dsc_options,
 			(int) kbps, param.timing, &dsc_config);
 
 	return dsc_config.bits_per_pixel;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
index 684713b2cff7..81e62a630d78 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
@@ -54,6 +54,12 @@ struct dc_dsc_policy {
 	bool enable_dsc_when_not_needed;
 };
 
+struct dc_dsc_config_options {
+	uint32_t dsc_min_slice_height_override;
+	uint32_t max_target_bpp_limit_override_x16;
+	uint32_t slight_height_granularity;
+};
+
 bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
 		const uint8_t *dpcd_dsc_basic_data,
 		const uint8_t *dpcd_dsc_ext_data,
@@ -71,8 +77,7 @@ bool dc_dsc_compute_bandwidth_range(
 bool dc_dsc_compute_config(
 		const struct display_stream_compressor *dsc,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
-		uint32_t dsc_min_slice_height_override,
-		uint32_t max_target_bpp_limit_override,
+		const struct dc_dsc_config_options *options,
 		uint32_t target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_config *dsc_cfg);
@@ -100,4 +105,6 @@ void dc_dsc_policy_set_enable_dsc_when_not_needed(bool enable);
 
 void dc_dsc_policy_set_disable_dsc_stream_overhead(bool disable);
 
+void dc_dsc_get_default_config_option(const struct dc *dc, struct dc_dsc_config_options *options);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index d52cbc0e9b67..8b5663853efb 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -79,8 +79,7 @@ static bool setup_dsc_config(
 		const struct dsc_enc_caps *dsc_enc_caps,
 		int target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
-		int min_slice_height_override,
-		int max_dsc_target_bpp_limit_override_x16,
+		const struct dc_dsc_config_options *options,
 		struct dc_dsc_config *dsc_cfg);
 
 static bool dsc_buff_block_size_from_dpcd(int dpcd_buff_block_size, int *buff_block_size)
@@ -352,6 +351,11 @@ bool dc_dsc_compute_bandwidth_range(
 	struct dsc_enc_caps dsc_enc_caps;
 	struct dsc_enc_caps dsc_common_caps;
 	struct dc_dsc_config config;
+	struct dc_dsc_config_options options = {0};
+
+	options.dsc_min_slice_height_override = dsc_min_slice_height_override;
+	options.max_target_bpp_limit_override_x16 = max_bpp_x16;
+	options.slight_height_granularity = 1;
 
 	get_dsc_enc_caps(dsc, &dsc_enc_caps, timing->pix_clk_100hz);
 
@@ -360,7 +364,7 @@ bool dc_dsc_compute_bandwidth_range(
 
 	if (is_dsc_possible)
 		is_dsc_possible = setup_dsc_config(dsc_sink_caps, &dsc_enc_caps, 0, timing,
-				dsc_min_slice_height_override, max_bpp_x16, &config);
+				&options, &config);
 
 	if (is_dsc_possible)
 		is_dsc_possible = decide_dsc_bandwidth_range(min_bpp_x16, max_bpp_x16,
@@ -740,8 +744,7 @@ static bool setup_dsc_config(
 		const struct dsc_enc_caps *dsc_enc_caps,
 		int target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
-		int min_slice_height_override,
-		int max_dsc_target_bpp_limit_override_x16,
+		const struct dc_dsc_config_options *options,
 		struct dc_dsc_config *dsc_cfg)
 {
 	struct dsc_enc_caps dsc_common_caps;
@@ -760,7 +763,7 @@ static bool setup_dsc_config(
 
 	memset(dsc_cfg, 0, sizeof(struct dc_dsc_config));
 
-	dc_dsc_get_policy_for_timing(timing, max_dsc_target_bpp_limit_override_x16, &policy);
+	dc_dsc_get_policy_for_timing(timing, options->max_target_bpp_limit_override_x16, &policy);
 	pic_width = timing->h_addressable + timing->h_border_left + timing->h_border_right;
 	pic_height = timing->v_addressable + timing->v_border_top + timing->v_border_bottom;
 
@@ -909,12 +912,13 @@ static bool setup_dsc_config(
 
 	// Slice height (i.e. number of slices per column): start with policy and pick the first one that height is divisible by.
 	// For 4:2:0 make sure the slice height is divisible by 2 as well.
-	if (min_slice_height_override == 0)
+	if (options->dsc_min_slice_height_override == 0)
 		slice_height = min(policy.min_slice_height, pic_height);
 	else
-		slice_height = min(min_slice_height_override, pic_height);
+		slice_height = min((int)(options->dsc_min_slice_height_override), pic_height);
 
 	while (slice_height < pic_height && (pic_height % slice_height != 0 ||
+		slice_height % options->slight_height_granularity != 0 ||
 		(timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 && slice_height % 2 != 0)))
 		slice_height++;
 
@@ -958,8 +962,7 @@ static bool setup_dsc_config(
 bool dc_dsc_compute_config(
 		const struct display_stream_compressor *dsc,
 		const struct dsc_dec_dpcd_caps *dsc_sink_caps,
-		uint32_t dsc_min_slice_height_override,
-		uint32_t max_target_bpp_limit_override,
+		const struct dc_dsc_config_options *options,
 		uint32_t target_bandwidth_kbps,
 		const struct dc_crtc_timing *timing,
 		struct dc_dsc_config *dsc_cfg)
@@ -971,8 +974,7 @@ bool dc_dsc_compute_config(
 	is_dsc_possible = setup_dsc_config(dsc_sink_caps,
 		&dsc_enc_caps,
 		target_bandwidth_kbps,
-		timing, dsc_min_slice_height_override,
-		max_target_bpp_limit_override * 16, dsc_cfg);
+		timing, options, dsc_cfg);
 	return is_dsc_possible;
 }
 
@@ -1104,3 +1106,10 @@ void dc_dsc_policy_set_disable_dsc_stream_overhead(bool disable)
 {
 	dsc_policy_disable_dsc_stream_overhead = disable;
 }
+
+void dc_dsc_get_default_config_option(const struct dc *dc, struct dc_dsc_config_options *options)
+{
+	options->dsc_min_slice_height_override = dc->debug.dsc_min_slice_height_override;
+	options->max_target_bpp_limit_override_x16 = 0;
+	options->slight_height_granularity = 1;
+}
-- 
2.34.1

