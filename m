Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5C1C46CA3
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77EEC10E89C;
	Fri,  1 Dec 2023 13:31:03 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157F110E89B
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2Gp0edRVPttuA0YEUMEyUfv99Ir8tOuS+x1oHVFOkUV9RzhHN3xG8qsOI/ptTh93gVLYJ/DMfYUXw6dwcwbCVmyV5JXxJrGz4h0Eg61BdU85hTSwY30azdBGMsviekHHM9YNYOGjK1lzv0VqEXzrm/TyFcTg/xtlPEH8o7lMWjjxNnfHc7UPx9zL8twqp5rBcGdnjfa5UlWdcoUoanOm9NHj4TXavwWPxMutCdRySFOgI4+d31XUePvd+QrrD87KsTDAU/Q5XqmnHSnEbIB2HE38w4a1L0GDXV7N8IvcVSR46miD8JvtxeQ9Wk3FE7nXNzwpmZKA05i7DIJUDvVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GKpUNEy6VPwguQ/6id6e9IPQvNuYJ9oc7jbdXr19JA=;
 b=GZXGC7mvfnkKe2UBSmReV2VLfGDo3LzIOP32owjpiAr6ANWiOcX2ysEDC5VOFNCaK7GkjlQ7vKTnLZAZNaiZ0+DW5rz+F8HcPKdI0KYeX5eLGmTY/nvh1R4xaZ/OJq4MBDlSOautrNvLTIxbdifSdd+1WOf7OYxLf2mXwUMbRD/LZBbH5u8q+lnT4ojBn9MKp+CWHKPN6X8nZ56HlAAmUgLSWkj7rVc2/Azi3KJ5/ozMUTWHPYSaY2x377+hCh+srP4FQwzRh/njfvXYnKlmfO/e0kRnYoXgbvsIPEh0Nz/aZBWniv3pLHEjFwHCOIkm4e1oPpQNMRCd/JUdnrotFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GKpUNEy6VPwguQ/6id6e9IPQvNuYJ9oc7jbdXr19JA=;
 b=uFTlRzdV9dGRWsZ9C76UmeK0WUMFogernL3YEmY261UrkX05IkmSeorSXLuY8Xh+82rS07OgxwvK/+IdroA9oF8C0bHud2o1HlNEVFf47ZLUKbEL8TNXiFxNKJ7ELBdFGumdudqd9aopLcbC5Jy8KGnITX7PCK0nmI/zikNQwSU=
Received: from CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 13:29:20 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::94) by CH2PR16CA0025.outlook.office365.com
 (2603:10b6:610:50::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:19 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:16 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 35/47] drm/amd/display: Hande writeback request from userspace
Date: Fri, 1 Dec 2023 06:25:31 -0700
Message-ID: <20231201132731.2354141-36-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 5889a896-a780-4280-b17f-08dbf2718630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8VcNuKhTzqKRvYM2yQ+/BGoR75qXMCFDhxe2Fh6IqDYHuXMrV69WaYYYKDXxGm+IMGrPer+nilsGblYs8Wab3bFn/77vxicVPGEpgbR9jp4cvBLqOErv8V5PToKRsut+tUjCS9d/SWGDHHp2zwiMJTFO7dP5KuY7jzW9BZ/NqNL8hMvcAxM0pKMpZfd9/dmHh8hR/gjURgshbGA6JZnkgrwPYgi+Y/jajwRMe1wA1Yil6dU3XXX3tRnjOpbbhWbMoh9za3fplLtDRKsMdrNtZraOG1HU/jbm7JYwaFgK6szlWp6zKje2IzCe70J0D2LTygTtduhvH5ltJ1OcWkJ/8db6HPDwBr1BwKIC/GBhzhX1eAdQk1BgFm4+CSrg81sWaabGnY4lALz4ilGqYZVzonqoYi50yPetu96dIict9Ww3e2LatLwBg47CJM1syrTy3CpPmLzaLTr89g2SNw6kMJ0u/MDWBLPPKT9vIFdQWzPLoJw+aNsP8it4gly0+J85Wcn4TljDGrIG+vKVmm6iAkhMj5r1ZMdJE+vfv4uIfMZpkD6vHAWmxjzc/3vOXnytnhrXjyz/p5Eg5HkfWM1/NydFjUPDP7bvKg7hpSp6m9Bxvuhz+DX1K2TSXgFy6bVg8/gJiZJd+ES5hWjnAI/rH0BaJ1WycLaQUVJUQA+9bVTrlpX9iDm53m7PH5tJlrqocDIM5EGLaYkATgHeqQQ1/YI65N+h/9RhkPiCt/WjJurFtDH9TgXGvWfTK50c4Yyb/yLfrgfTT1GQI5I6nM+MPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(336012)(83380400001)(40480700001)(426003)(40460700003)(86362001)(5660300002)(70206006)(2906002)(36756003)(16526019)(6916009)(36860700001)(41300700001)(2616005)(26005)(1076003)(6666004)(47076005)(70586007)(82740400003)(356005)(81166007)(54906003)(316002)(478600001)(8676002)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:19.8840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5889a896-a780-4280-b17f-08dbf2718630
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Handle writeback requests and fill in the required information for DWB
programming and setup.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   3 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 159 ++++++++++++++++++
 2 files changed, 162 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 32fe05c810c6..a166d7684719 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -416,6 +416,9 @@ struct amdgpu_crtc {
 
 	int otg_inst;
 	struct drm_pending_vblank_event *event;
+
+	bool wb_pending;
+	struct drm_writeback_connector *wb_conn;
 };
 
 struct amdgpu_encoder_atom_dig {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index aeb4a4e25450..04e06665eb0d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -575,6 +575,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
 {
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
+	struct drm_writeback_job *job;
 	struct amdgpu_crtc *acrtc;
 	unsigned long flags;
 	int vrr_active;
@@ -583,6 +584,21 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	if (!acrtc)
 		return;
 
+	if (acrtc->wb_pending) {
+		if (acrtc->wb_conn) {
+			spin_lock_irqsave(&acrtc->wb_conn->job_lock, flags);
+			job = list_first_entry_or_null(&acrtc->wb_conn->job_queue,
+						       struct drm_writeback_job,
+						       list_entry);
+			spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
+
+			if (job)
+				drm_writeback_signal_completion(acrtc->wb_conn, 0);
+		} else
+			DRM_ERROR("%s: no amdgpu_crtc wb_conn\n", __func__);
+		acrtc->wb_pending = false;
+	}
+
 	vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
 
 	drm_dbg_vbl(adev_to_drm(adev),
@@ -8619,6 +8635,12 @@ static void amdgpu_dm_crtc_copy_transient_flags(struct drm_crtc_state *crtc_stat
 	stream_state->mode_changed = drm_atomic_crtc_needs_modeset(crtc_state);
 }
 
+static void dm_clear_writeback(struct amdgpu_display_manager *dm,
+			      struct dm_crtc_state *crtc_state)
+{
+	dc_stream_remove_writeback(dm->dc, crtc_state->stream, 0);
+}
+
 static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 					struct dc_state *dc_state)
 {
@@ -8628,9 +8650,34 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
+	struct drm_connector_state *old_con_state;
+	struct drm_connector *connector;
 	bool mode_set_reset_required = false;
 	u32 i;
 
+	/* Disable writeback */
+	for_each_old_connector_in_state(state, connector, old_con_state, i) {
+		struct dm_connector_state *dm_old_con_state;
+		struct amdgpu_crtc *acrtc;
+
+		if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		old_crtc_state = NULL;
+
+		dm_old_con_state = to_dm_connector_state(old_con_state);
+		if (!dm_old_con_state->base.crtc)
+			continue;
+
+		acrtc = to_amdgpu_crtc(dm_old_con_state->base.crtc);
+		if (acrtc)
+			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
+
+		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
+
+		dm_clear_writeback(dm, dm_old_crtc_state);
+	}
+
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
 				      new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
@@ -8767,6 +8814,97 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	}
 }
 
+static void dm_set_writeback(struct amdgpu_display_manager *dm,
+			      struct dm_crtc_state *crtc_state,
+			      struct drm_connector *connector,
+			      struct drm_connector_state *new_con_state)
+{
+	struct drm_writeback_connector *wb_conn = drm_connector_to_writeback(connector);
+	struct amdgpu_crtc *acrtc;
+	struct dc_writeback_info *wb_info;
+	struct pipe_ctx *pipe = NULL;
+	struct amdgpu_framebuffer *afb;
+	int i = 0;
+
+	wb_info = kzalloc(sizeof(*wb_info), GFP_KERNEL);
+	if (!wb_info) {
+		DRM_ERROR("Failed to allocate wb_info\n");
+		return;
+	}
+
+	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
+	if (!acrtc) {
+		DRM_ERROR("no amdgpu_crtc found\n");
+		return;
+	}
+
+	afb = to_amdgpu_framebuffer(new_con_state->writeback_job->fb);
+	if (!afb) {
+		DRM_ERROR("No amdgpu_framebuffer found\n");
+		return;
+	}
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (dm->dc->current_state->res_ctx.pipe_ctx[i].stream == crtc_state->stream) {
+			pipe = &dm->dc->current_state->res_ctx.pipe_ctx[i];
+			break;
+		}
+	}
+
+	/* fill in wb_info */
+	wb_info->wb_enabled = true;
+
+	wb_info->dwb_pipe_inst = 0;
+	wb_info->dwb_params.dwbscl_black_color = 0;
+	wb_info->dwb_params.hdr_mult = 0x1F000;
+	wb_info->dwb_params.csc_params.gamut_adjust_type = CM_GAMUT_ADJUST_TYPE_BYPASS;
+	wb_info->dwb_params.csc_params.gamut_coef_format = CM_GAMUT_REMAP_COEF_FORMAT_S2_13;
+	wb_info->dwb_params.output_depth = DWB_OUTPUT_PIXEL_DEPTH_10BPC;
+	wb_info->dwb_params.cnv_params.cnv_out_bpc = DWB_CNV_OUT_BPC_10BPC;
+
+	/* width & height from crtc */
+	wb_info->dwb_params.cnv_params.src_width = acrtc->base.mode.crtc_hdisplay;
+	wb_info->dwb_params.cnv_params.src_height = acrtc->base.mode.crtc_vdisplay;
+	wb_info->dwb_params.dest_width = acrtc->base.mode.crtc_hdisplay;
+	wb_info->dwb_params.dest_height = acrtc->base.mode.crtc_vdisplay;
+
+	wb_info->dwb_params.cnv_params.crop_en = false;
+	wb_info->dwb_params.stereo_params.stereo_enabled = false;
+
+	wb_info->dwb_params.cnv_params.out_max_pix_val = 0x3ff;	// 10 bits
+	wb_info->dwb_params.cnv_params.out_min_pix_val = 0;
+	wb_info->dwb_params.cnv_params.fc_out_format = DWB_OUT_FORMAT_32BPP_ARGB;
+	wb_info->dwb_params.cnv_params.out_denorm_mode = DWB_OUT_DENORM_BYPASS;
+
+	wb_info->dwb_params.out_format = dwb_scaler_mode_bypass444;
+
+	wb_info->dwb_params.capture_rate = dwb_capture_rate_0;
+
+	wb_info->dwb_params.scaler_taps.h_taps = 4;
+	wb_info->dwb_params.scaler_taps.v_taps = 4;
+	wb_info->dwb_params.scaler_taps.h_taps_c = 2;
+	wb_info->dwb_params.scaler_taps.v_taps_c = 2;
+	wb_info->dwb_params.subsample_position = DWB_INTERSTITIAL_SUBSAMPLING;
+
+	wb_info->mcif_buf_params.luma_pitch = afb->base.pitches[0];
+	wb_info->mcif_buf_params.chroma_pitch = afb->base.pitches[1];
+
+	for (i = 0; i < DWB_MCIF_BUF_COUNT; i++) {
+		wb_info->mcif_buf_params.luma_address[i] = afb->address;
+		wb_info->mcif_buf_params.chroma_address[i] = 0;
+	}
+
+	wb_info->mcif_buf_params.p_vmid = 1;
+	wb_info->mcif_warmup_params.p_vmid = 1;
+	wb_info->writeback_source_plane = pipe->plane_state;
+
+	dc_stream_add_writeback(dm->dc, crtc_state->stream, wb_info);
+
+	acrtc->wb_pending = true;
+	acrtc->wb_conn = wb_conn;
+	drm_writeback_queue_job(wb_conn, new_con_state);
+}
+
 /**
  * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementation.
  * @state: The atomic state to commit
@@ -9099,6 +9237,27 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			amdgpu_dm_commit_planes(state, dev, dm, crtc, wait_for_vblank);
 	}
 
+	/* Enable writeback */
+	for_each_new_connector_in_state(state, connector, new_con_state, i) {
+		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
+		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
+
+		if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		if (!new_con_state->writeback_job)
+			continue;
+
+		new_crtc_state = NULL;
+
+		if (acrtc)
+			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
+
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+
+		dm_set_writeback(dm, dm_new_crtc_state, connector, new_con_state);
+	}
+
 	/* Update audio instances for each connector. */
 	amdgpu_dm_commit_audio(dev, state);
 
-- 
2.42.0

