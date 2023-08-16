Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87978C25B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F37E10E3C7;
	Wed, 16 Aug 2023 21:30:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7FC10E3C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:30:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYZ1YZxzrfnrM0qzzlz3/WW/2/O3f6JqAS5yuBKoi0/OEGDe8fBheBsUIXd/w/0bcbe9COTT/7xrTjCi0dXCHqC6xUsZ7wkMqUNe3GqrOdu0nGKHdmku0VaWzNpxAm++LRlnWFvl9AplrVlhzrLQVGGJI/97ZTQCWM7kOvPqyXWcrhXF8topXw59zvFBtUkzpGr5sBTrKFclVBZFhOoOfFw+0QK4h63SQemI6KwFQt8aORDyeUjAZRb/lNWg6aOfDND4mXydBQpBhIoj5LQ5K+hQypzzRYbtF1LLFk5CPV5W4S8A5djKdyxO+xxmjrxvHDfru9KgJ9A/DPI5QhK3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwJ2IkSFEoC4i9+pA9jTfj2yUnMQ1LHGx3onP6GWIUA=;
 b=W51LTE6wNOxfFMUwuC52z0izKX+eQ6moXF9FaUl8uEkirIGdjAwsM0eO8h2nVwNfiqO4VGDXsMsnctmaZEoTWS7CzR1j8YAUrvLb0SW8wL/t4xDPtOGkadoVfJ/I4FAfm9DxKIVyn4v4aEAobV1LodOE7PZFXPaMi8hqzah+ywDo1r/tz3b9zQyxZnlfLeCiBxZbYoOhZ565b1CmwxhBRhdG/VEn1GPEC7KptYpaxwMQetwIBm2BMNUDF97SR0ZbwoG8XNPnKENxdX15MLHczduuHLr06lEJM/KkqGEhGV34uC09jtRYntsIyjVAlSEwYR0qmOMPg/fuDpRYYpA77g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwJ2IkSFEoC4i9+pA9jTfj2yUnMQ1LHGx3onP6GWIUA=;
 b=r40eXktlDspEZB5kkSi012JuJyLITMcgXzFkRYpDUsAxLDOSuFaiz0dIX4LJwrllH0zuU8amp/QF4poTVsmQrsUASZyEirHqtRebH7kERsgoQm0xTacI65yCoPy+lQNLlVRj/V/8QIIsU0hqQIrg06YSLXULle14TiQWvlV1+sE=
Received: from DS7P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::7) by
 BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 21:30:40 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::d3) by DS7P222CA0001.outlook.office365.com
 (2603:10b6:8:2e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:30:39 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:30:38 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/18] drm/amd/display: Hande writeback request from userspace
Date: Wed, 16 Aug 2023 15:26:18 -0600
Message-ID: <20230816212626.987519-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc5d2a1-ded0-4059-af63-08db9ea009b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MAtB6UijWZH+BXe6WTE0jMDS3skrBAaL4VNdD9qNMLEM/cOfl7ZrMJydeUViRlJCy+xHrgNHMqRVok1K11+mQgXKxvxnUbcUJyxDmmvlJJDZEZWAJkGRV1N+mUwFDuDEPULI4etYzt8VEAm+BjVHyrqiaxGDUoH4n4CKZ0LGoHh1r1jp/PoqyBSdYfnsg8MXfPf5ZHFH7bHYTD6nSUk2D8hFkaCJsmNM+fXUvqehviGIH6x61I8aNUMUCjoPO8/8G5iN+3xc+SxiAYfeibMYOjtY/oLJYPdmX6Q6nr1kGBkz95ICtO76XWawyxYlSXZIDu1tp0yCm9pJ3zEDNJu0yyJISvCYBMqOlpgh1p6y9KXGxDIN4oPLbv9OcuWXiARm17W4YtH52GRJheaykyRXG4QE8El0i27GuJjwT2bDLmb797S981l04xFIhys4HrborDNjdKaUg36WCUhBaw9gqeaJtckgttAp5snS+GbwcdVKn78+yAIY25Ae2jekAcsjEnAsWgLaZjhKsrZ44bAjYwU5do4agtTIcKVQIPFCWUX8scpafDDrE4jELE89CE1jmvxU858r+EyJzarw4tO8pYR5ukHoA5BNt1MqgengSA8igMc8fdsKo+IIHjkZtacq/MTBY1/n5NWCFM7uBSbVRER5FgIWpL/kX4Ih138kVeM4tPLfcajEAm7S3l2ZwmxfAewc2le7TWu7xyGelmMrAlbbdsR9xyUWx3fiLlLwO2SewTaVm5MXb1EpNvq3xpUJ8A0DRwjQV2jlFvLNQnaNTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:30:39.6755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc5d2a1-ded0-4059-af63-08db9ea009b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHAT]
Handle writeback requests and fill in the required information for DWB
programming and setup.

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
index 82f00af14ada..fdfcafbaa668 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -572,6 +572,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
 {
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
+	struct drm_writeback_job *job;
 	struct amdgpu_crtc *acrtc;
 	unsigned long flags;
 	int vrr_active;
@@ -580,6 +581,21 @@ static void dm_crtc_high_irq(void *interrupt_params)
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
 
 	DC_LOG_VBLANK("crtc:%d, vupdate-vrr:%d, planes:%d\n", acrtc->crtc_id,
@@ -8515,6 +8531,12 @@ static void amdgpu_dm_crtc_copy_transient_flags(struct drm_crtc_state *crtc_stat
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
@@ -8524,9 +8546,34 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
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
@@ -8661,6 +8708,97 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
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
@@ -8982,6 +9120,27 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
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
2.41.0

