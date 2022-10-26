Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2F8C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 11:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F23F10E4C2;
	Wed, 26 Oct 2022 11:49:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6C510E4BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 11:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmTSGcBpX4Sw8X9S9285lU43Aon9OwQX1rHXNGXyjRnJ5cmQgGVjzBzCoTt2GxIUZtaUP4KMi8KyHas/vm+g7dUE/hBeCPQy6mkIn+1N6TbnwH9m1wZ4iEr7/3WYn4I3s/UEMWYN6247nt2clfnQeHuBHsCXGJ4etH3T/Lt3MxPoN3spZUaHEZrAjsCezj5O5yp3O8X4xL8DUI6HysGCMyURFUH9kgacYl45Mh267tNzN9p99uJP+ojLH4Ca1UKhf94C/Lv6zhvnAtmkYxz7jvpTQgk9e1vA6yLSmcJMKogY7cyhKYZ37ZJc6SJIEiLIUqf9BmIbrfHx2R43HSyJoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1h129oXNAJH2Ob8JrnYumOaNx8hLywt0PsSfz8b0m0=;
 b=bxVeH2JBwRXBevjFFN6ncQZf15zWySCPD3CiRW9tLY8ugacs2Wzb1PFNX6WnJEyYeej8Rtm469yw2P6Y3H1v4v/HWUslDvmP0kU1GkoJItGz5qbbC8slYpsxmLl5Xk7vwOrSwYL5EivGPNkGrL95qEmNX8iy3axmuV/bBiexYsEIclqRURIBsQSGGMbG7erpXkatGVasOrQ+Oq6YIDYV3ovxjq6jN7M3GDZFq3pjvb23n+xFQruomd6i0X0kQqQCR3Ue77A8BSchwQcuC2tD21PiqXsnPw4MOqZy+DMrpEMkiNl31ZuLZxEPEk6TsbNVRA5z8eo2j3nM/ULz5VpodQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1h129oXNAJH2Ob8JrnYumOaNx8hLywt0PsSfz8b0m0=;
 b=mm/Hp63rqKG32yu3tHJI9c5hUqSA8pOpqT1tbhlXXx0ohepactPGtDv29iK4LfqacTif2XeHkbFwZ+W7B7qYoHladwTFw4oPFfVgWTAbHuDynPYmy3gcL/+VPe8fhw1G7yZYnE2g3vdW6fBPBmnIJ8n6ONzoAAa0eXwVU96caOQ=
Received: from BN8PR15CA0025.namprd15.prod.outlook.com (2603:10b6:408:c0::38)
 by BL1PR12MB5093.namprd12.prod.outlook.com (2603:10b6:208:309::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 11:49:21 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::cb) by BN8PR15CA0025.outlook.office365.com
 (2603:10b6:408:c0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23 via Frontend
 Transport; Wed, 26 Oct 2022 11:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 26 Oct 2022 11:49:21 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 06:49:19 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: fix some coding style issues
Date: Wed, 26 Oct 2022 17:18:50 +0530
Message-ID: <20221026114850.3559949-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|BL1PR12MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: dc731282-2c68-4847-5e3e-08dab7481f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7fTVi6sN6gJlL4L/KIiCNE5D4kOA3ugvf7IXLMZlJ6ut1zozJPO1nF+JbT+mdG0cX51ToUZEOrmFoicXi4SnF0dZdNSLkffLobDoUyOPX/k9In8COYgJhQ56+398rUBP5p0a/8P/4D076CEkOtoQQDrVSWKg2dYavQEcImescYoCdoTzwfBHv6N17TRhrs34mXs7p6NnM9m2a18ExAuh4DtYchMrQ39S+mYRrycttWI4jVECFAzVED69B6VO33fMwDfsAZ4lJ5p6m7xw/g7Opn+JdfsrbaaencHJ0xy9BpXrWAqpGSQdvuBgvPfAz8pbHYfYzdoSNH85AcJ8PlNBKyNT7sACSmlO4W41aVtrSeS1jLo7VsuvhywffrtIkPPwI5obckE7NKMqVoFSJwiL2Rc4K89PzgyZ+iZGyyYOYhLhR85QGodWC4YQ+uhj3e4MxmmV/I+lPuHrYzTbBkFJ8jq43KHieRlfk0YZ5d8Nd5KadJ6vKBQx/YErd2jcjxK3CX8JJISNYmsMtL55O57p29iFmMCYsHgWKAMYhKBkt5U4vcE2cqPBRYfaoDWiDQfL9mNUY2ZGSb6gZ35xEypNJpPeDJNnx8JQw4KuKYZXNm6nawztK4nrzVk5dBieKLw73qQ3rjmkriDi6PpI8Tww9XwWOVjumF/JAy9vIZ6vIEXNVN480EuAyjxBPounOpYHcqvYz0M+FjrIOgzZ/M2QMcRpSnsw2zDacfBIjU2zlDiBEJPLUUPyBvlIRBqRuGXqNxQELZeBzb7hMtteq4b6jWKmWmy8dmQv1fT+z48zNkOs8Fv78BAjIBrPCQFu9KH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(70586007)(426003)(30864003)(4326008)(70206006)(7696005)(44832011)(81166007)(356005)(2616005)(478600001)(5660300002)(36860700001)(8676002)(6636002)(86362001)(336012)(26005)(54906003)(82310400005)(110136005)(40480700001)(41300700001)(8936002)(36756003)(16526019)(47076005)(40460700003)(2906002)(1076003)(83380400001)(186003)(82740400003)(6666004)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 11:49:21.8274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc731282-2c68-4847-5e3e-08dab7481f67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5093
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following checkpatch checks in amdgpu_dm.c

CHECK: Prefer kernel type 'u8' over 'uint8_t'
CHECK: Prefer kernel type 'u32' over 'uint32_t'
CHECK: Prefer kernel type 'u64' over 'uint64_t'
CHECK: Prefer kernel type 's32' over 'int32_t'

Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 90 +++++++++----------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e733042531a6..1ee31c7290ac 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -258,7 +258,7 @@ static u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 				  u32 *vbl, u32 *position)
 {
-	uint32_t v_blank_start, v_blank_end, h_position, v_position;
+	u32 v_blank_start, v_blank_end, h_position, v_position;
 
 	if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
 		return -EINVAL;
@@ -357,7 +357,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
 	struct amdgpu_device *adev = irq_params->adev;
 	unsigned long flags;
 	struct drm_pending_vblank_event *e;
-	uint32_t vpos, hpos, v_blank_start, v_blank_end;
+	u32 vpos, hpos, v_blank_start, v_blank_end;
 	bool vrr_active;
 
 	amdgpu_crtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_PFLIP);
@@ -644,7 +644,7 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
 	struct dc_link *link;
-	uint8_t link_index = 0;
+	u8 link_index = 0;
 	struct drm_device *dev;
 
 	if (adev == NULL)
@@ -745,7 +745,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 	struct amdgpu_device *adev = irq_params->adev;
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct dmcub_trace_buf_entry entry = { 0 };
-	uint32_t count = 0;
+	u32 count = 0;
 	struct dmub_hpd_work *dmub_hpd_wrk;
 	struct dc_link *plink = NULL;
 
@@ -1011,7 +1011,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	struct dmub_srv_hw_params hw_params;
 	enum dmub_status status;
 	const unsigned char *fw_inst_const, *fw_bss_data;
-	uint32_t i, fw_inst_const_size, fw_bss_data_size;
+	u32 i, fw_inst_const_size, fw_bss_data_size;
 	bool has_hw_support;
 
 	if (!dmub_srv)
@@ -1172,10 +1172,10 @@ static void dm_dmub_hw_resume(struct amdgpu_device *adev)
 
 static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
 {
-	uint64_t pt_base;
-	uint32_t logical_addr_low;
-	uint32_t logical_addr_high;
-	uint32_t agp_base, agp_bot, agp_top;
+	u64 pt_base;
+	u32 logical_addr_low;
+	u32 logical_addr_high;
+	u32 agp_base, agp_bot, agp_top;
 	PHYSICAL_ADDRESS_LOC page_table_start, page_table_end, page_table_base;
 
 	memset(pa_config, 0, sizeof(*pa_config));
@@ -2443,7 +2443,7 @@ struct amdgpu_dm_connector *
 amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 					     struct drm_crtc *crtc)
 {
-	uint32_t i;
+	u32 i;
 	struct drm_connector_state *new_con_state;
 	struct drm_connector *connector;
 	struct drm_crtc *crtc_from_state;
@@ -3101,8 +3101,8 @@ static void handle_hpd_irq(void *param)
 
 static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
 {
-	uint8_t esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = { 0 };
-	uint8_t dret;
+	u8 esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = { 0 };
+	u8 dret;
 	bool new_irq_handled = false;
 	int dpcd_addr;
 	int dpcd_bytes_to_read;
@@ -3130,7 +3130,7 @@ static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
 
 	while (dret == dpcd_bytes_to_read &&
 		process_count < max_process_count) {
-		uint8_t retry;
+		u8 retry;
 		dret = 0;
 
 		process_count++;
@@ -3149,7 +3149,7 @@ static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
 				dpcd_bytes_to_read - 1;
 
 			for (retry = 0; retry < 3; retry++) {
-				uint8_t wret;
+				u8 wret;
 
 				wret = drm_dp_dpcd_write(
 					&aconnector->dm_dp_aux.aux,
@@ -4158,12 +4158,12 @@ static void amdgpu_set_panel_orientation(struct drm_connector *connector);
 static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 {
 	struct amdgpu_display_manager *dm = &adev->dm;
-	int32_t i;
+	s32 i;
 	struct amdgpu_dm_connector *aconnector = NULL;
 	struct amdgpu_encoder *aencoder = NULL;
 	struct amdgpu_mode_info *mode_info = &adev->mode_info;
-	uint32_t link_cnt;
-	int32_t primary_planes;
+	u32 link_cnt;
+	s32 primary_planes;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const struct dc_plane_cap *plane;
 	bool psr_feature_enabled = false;
@@ -4675,7 +4675,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 static int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 			    const struct drm_plane_state *plane_state,
-			    const uint64_t tiling_flags,
+			    const u64 tiling_flags,
 			    struct dc_plane_info *plane_info,
 			    struct dc_plane_address *address,
 			    bool tmz_surface,
@@ -4881,10 +4881,10 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 {
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
 	struct rect *dirty_rects = flip_addrs->dirty_rects;
-	uint32_t num_clips;
+	u32 num_clips;
 	bool bb_changed;
 	bool fb_changed;
-	uint32_t i = 0;
+	u32 i = 0;
 
 	flip_addrs->dirty_rect_count = 0;
 
@@ -5018,7 +5018,7 @@ static enum dc_color_depth
 convert_color_depth_from_display_info(const struct drm_connector *connector,
 				      bool is_y420, int requested_bpc)
 {
-	uint8_t bpc;
+	u8 bpc;
 
 	if (is_y420) {
 		bpc = 8;
@@ -5562,8 +5562,8 @@ static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnector,
 				    uint32_t max_dsc_target_bpp_limit_override)
 {
 	const struct dc_link_settings *verified_link_cap = NULL;
-	uint32_t link_bw_in_kbps;
-	uint32_t edp_min_bpp_x16, edp_max_bpp_x16;
+	u32 link_bw_in_kbps;
+	u32 edp_min_bpp_x16, edp_max_bpp_x16;
 	struct dc *dc = sink->ctx->dc;
 	struct dc_dsc_bw_range bw_range = {0};
 	struct dc_dsc_config dsc_cfg = {0};
@@ -5620,11 +5620,11 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 					struct dsc_dec_dpcd_caps *dsc_caps)
 {
 	struct drm_connector *drm_connector = &aconnector->base;
-	uint32_t link_bandwidth_kbps;
-	uint32_t max_dsc_target_bpp_limit_override = 0;
+	u32 link_bandwidth_kbps;
+	u32 max_dsc_target_bpp_limit_override = 0;
 	struct dc *dc = sink->ctx->dc;
-	uint32_t max_supported_bw_in_kbps, timing_bw_in_kbps;
-	uint32_t dsc_max_supported_bw_in_kbps;
+	u32 max_supported_bw_in_kbps, timing_bw_in_kbps;
+	u32 dsc_max_supported_bw_in_kbps;
 
 	link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
 							dc_link_get_link_cap(aconnector->dc_link));
@@ -6838,7 +6838,7 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 	const struct drm_display_mode *m;
 	struct drm_display_mode *new_mode;
 	uint i;
-	uint32_t new_modes_count = 0;
+	u32 new_modes_count = 0;
 
 	/* Standard FPS values
 	 *
@@ -6852,7 +6852,7 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 	 * 60 	        - Commonly used
 	 * 48,72,96,120 - Multiples of 24
 	 */
-	static const uint32_t common_rates[] = {
+	static const u32 common_rates[] = {
 		23976, 24000, 25000, 29970, 30000,
 		48000, 50000, 60000, 72000, 96000, 120000
 	};
@@ -6868,8 +6868,8 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(common_rates); i++) {
-		uint64_t target_vtotal, target_vtotal_diff;
-		uint64_t num, den;
+		u64 target_vtotal, target_vtotal_diff;
+		u64 num, den;
 
 		if (drm_mode_vrefresh(m) * 1000 < common_rates[i])
 			continue;
@@ -7111,7 +7111,7 @@ create_i2c(struct ddc_service *ddc_service,
  */
 static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 				    struct amdgpu_dm_connector *aconnector,
-				    uint32_t link_index,
+				    u32 link_index,
 				    struct amdgpu_encoder *aencoder)
 {
 	int res = 0;
@@ -7595,8 +7595,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				    struct drm_crtc *pcrtc,
 				    bool wait_for_vblank)
 {
-	uint32_t i;
-	uint64_t timestamp_ns;
+	u32 i;
+	u64 timestamp_ns;
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state, *new_plane_state;
 	struct amdgpu_crtc *acrtc_attach = to_amdgpu_crtc(pcrtc);
@@ -7609,7 +7609,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	long r;
 	unsigned long flags;
 	struct amdgpu_bo *abo;
-	uint32_t target_vblank, last_flip_vblank;
+	u32 target_vblank, last_flip_vblank;
 	bool vrr_active = amdgpu_dm_vrr_active(acrtc_state);
 	bool cursor_update = false;
 	bool pflip_present = false;
@@ -8059,7 +8059,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct dm_atomic_state *dm_state;
 	struct dc_state *dc_state = NULL, *dc_state_temp = NULL;
-	uint32_t i, j;
+	u32 i, j;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	unsigned long flags;
@@ -8685,7 +8685,7 @@ is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 }
 
 static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state) {
-	uint64_t num, den, res;
+	u64 num, den, res;
 	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
 
 	dm_new_crtc_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
@@ -9851,7 +9851,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 static bool is_dp_capable_without_timing_msa(struct dc *dc,
 					     struct amdgpu_dm_connector *amdgpu_dm_connector)
 {
-	uint8_t dpcd_data;
+	u8 dpcd_data;
 	bool capable = false;
 
 	if (amdgpu_dm_connector->dc_link &&
@@ -9870,7 +9870,7 @@ static bool is_dp_capable_without_timing_msa(struct dc *dc,
 static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 		unsigned int offset,
 		unsigned int total_length,
-		uint8_t *data,
+		u8 *data,
 		unsigned int length,
 		struct amdgpu_hdmi_vsdb_info *vsdb)
 {
@@ -9925,7 +9925,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 }
 
 static bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
-		uint8_t *edid_ext, int len,
+		u8 *edid_ext, int len,
 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	int i;
@@ -9966,7 +9966,7 @@ static bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
 }
 
 static bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm,
-		uint8_t *edid_ext, int len,
+		u8 *edid_ext, int len,
 		struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	int i;
@@ -9996,7 +9996,7 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
 static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 		struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
-	uint8_t *edid_ext = NULL;
+	u8 *edid_ext = NULL;
 	int i;
 	bool valid_vsdb_found = false;
 
@@ -10172,7 +10172,7 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
 }
 
 void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
-		       uint32_t value, const char *func_name)
+		       u32 value, const char *func_name)
 {
 #ifdef DM_CHECK_ADDR_0
 	if (address == 0) {
@@ -10187,7 +10187,7 @@ void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
 uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
 			  const char *func_name)
 {
-	uint32_t value;
+	u32 value;
 #ifdef DM_CHECK_ADDR_0
 	if (address == 0) {
 		DC_ERR("invalid register read; address = 0\n");
@@ -10211,7 +10211,7 @@ uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
 
 static int amdgpu_dm_set_dmub_async_sync_status(bool is_cmd_aux,
 						struct dc_context *ctx,
-						uint8_t status_type,
+						u8 status_type,
 						uint32_t *operation_result)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
-- 
2.25.1

