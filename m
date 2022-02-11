Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3C9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 21:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF43510EB46;
	Fri, 11 Feb 2022 21:52:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 711CC10EB46
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 21:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqkiuLuyd47TuxRZVYKb3p3Jl8c+shQ1lYPGkZ0m2aHdaFnix3ajnG7SHGpNLtrTfZvWGReK4AZyv/8NVweAl3YdZ6Mb1Ds9PRKXI9BZ9boLRfA2RyM86z7Qb+X6CJyTEPIJ9+mYy4/J/noX3Sn7TeW03szOvHLBEIji8AxoUQszQyxXiDbQ1LKoqtXZTJ+f2NwhAQ+fG1CACv8dSBaYLjMPjRZICgN+xOiktcDPJK3fO1IUrXce2vrOu4RIxL4XJSlvZzQ5FSvwWU+g0zuA3NbuzSuRF+cJ8EsAQdxw6IJ/1ObvaFPJaTZrJ4WePCcj1nYOkyjs9L+bG6lmXrB4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDN8ytzb3C7+WANXuHa8i0N/JX5jmVly4ddug2XspL8=;
 b=gXHe1seKiZKCuhrEXuaHbI+yU4PlNaD/mPz94xowOCGaAcRe2qmW0FdnfeW3O1mvXugndbXN+O0hsnUOZlHS+1pm5MMYYevaHbjPxEe265tZdkN5522JGaKue8+XZy3V2ww/+9TLTQhGoJGERmAi6cZG0uTjCbGYJnfi9km8t2eeefdg0UW3uVf64Mm/8rLjXCe1EDTYMuuvzPATSkpjO2dnQ7frZgbBftBQd8se/LTqo67a5TSvaTcJAhLI9M5asDmBRraqgb5eCOWBrDP3wy2kHmCyFUjCGplji+yjs3yuVN/RLe4Q8wT5X3wcH0PszGpI3Pbm2eBoUpMtIXA5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDN8ytzb3C7+WANXuHa8i0N/JX5jmVly4ddug2XspL8=;
 b=XkHJpwrRo7S+OFuOTblrQYxnx9WonLGdsOhGGikUA5VJ0/vShF1tQosRkaKyCamViAAXI3aFAAvvbn0lY/KoavBzhAB1hSXRvxkNzs1cTxK2zkMuGQfhoz2wP2QvpU03ZR9kNQ6O8ZpVwXr4zCTLXy+Fju0HQ7moPL+Zt5Qcw5g=
Received: from MWHPR1701CA0017.namprd17.prod.outlook.com
 (2603:10b6:301:14::27) by BN6PR12MB1731.namprd12.prod.outlook.com
 (2603:10b6:404:106::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 11 Feb
 2022 21:52:19 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::92) by MWHPR1701CA0017.outlook.office365.com
 (2603:10b6:301:14::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.13 via Frontend
 Transport; Fri, 11 Feb 2022 21:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:52:18 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Feb 2022 15:52:14 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/11] drm/amd/display: Add dsc pre-validation in atomic check
Date: Fri, 11 Feb 2022 16:51:41 -0500
Message-ID: <20220211215142.94169-11-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211215142.94169-1-jdhillon@amd.com>
References: <20220211215142.94169-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92fe74a1-aac9-4638-1d68-08d9eda8c607
X-MS-TrafficTypeDiagnostic: BN6PR12MB1731:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1731E83360A19F0FE323005AFB309@BN6PR12MB1731.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pF7DFhT4iO7/PKbiqudiKzICd+vg/RaKzgy1JwoJCiGZYfMmr8agx3IRNDig9c23jQI9SQfd3QnPjDfauxWLu7igYM15wl1rUo80XgMANqREcXS82RZgaE/4x1TRccArj3emj6b00l4aBs27yOPDEmEOFr9e/qRV3zmXwr+ZuHtT75KrHbLwHq0ZYFL2DhzrP4tX3WczAyrhhbfM4X0m7yy2N/0A5Z9BAo7EMkt2VMUONc3EXN0QJezpu1aG731QaTQeAnPbFxn9rYGH5huRSo5lwiiNXFpR5HyFIH4WculztOm6A+WwHZL+Qoog7IXhkZ4Fau7+9exYK8rZ/Xi4GBsxxiJgSfVeyQJhtMGM0X4lNxVKrdrHCI3BSbeWmFzUcD4DCoCpCwcTMhjEoGGQlP9uwBlqWR9YizSSt/Jr4bGs05DdteBzurKaDN4O6+v4E8M/luE27TXBjS3j6Fc+8aueSkUc2vMlP3UEUK38qi45CGJmAKLDxX6EC2B8ZWdcSU0p0RDCtTP2g46ohx+r9t0QGj5ztaXdkuGUuF2B/HKfLq5aryzg5od4WE8TZx1j76bNCyubhGZcs7MmmMAva1+BqQkvi258evsdK6NGDx80UDXKin7XVAMWUnbJB2Xsxf2cdRpG1Bqmf5QrRVGA1lxOYqgfAB5YtpCnPaNOlXTuy1wXnDITF6v8F2ayBuHr1h+F204XnZlQTk2wyQ3Ysw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(47076005)(36756003)(508600001)(1076003)(6666004)(5660300002)(30864003)(40460700003)(2906002)(36860700001)(356005)(70206006)(16526019)(82310400004)(186003)(4326008)(8676002)(54906003)(6916009)(8936002)(336012)(426003)(2616005)(81166007)(316002)(26005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:52:18.0404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fe74a1-aac9-4638-1d68-08d9eda8c607
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1731
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
The previous change:
"Add affected crtcs to atomic state for dsc mst unplug"
forces modeset on all added crctc regardless whether timing changed or not.
Per our implementation of dsc we need modeset only if timing changed.
Otherwise dsc can be programmed incorrectly leading to dsc engine hang.

[How]
During atomic_check pre-compute dsc params.
Only set mode_changed if timing is changed.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  11 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  13 ++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 189 ++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   4 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   2 +-
 5 files changed, 213 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e26217e46c57..e69c3415801e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2406,7 +2406,7 @@ static int dm_suspend(void *handle)
 	return 0;
 }
 
-static struct amdgpu_dm_connector *
+struct amdgpu_dm_connector *
 amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 					     struct drm_crtc *crtc)
 {
@@ -3723,7 +3723,7 @@ static int register_outbox_irq_handlers(struct amdgpu_device *adev)
  *
  * This should only be called during atomic check.
  */
-static int dm_atomic_get_state(struct drm_atomic_state *state,
+int dm_atomic_get_state(struct drm_atomic_state *state,
 			       struct dm_atomic_state **dm_state)
 {
 	struct drm_device *dev = state->dev;
@@ -6349,7 +6349,7 @@ static bool is_freesync_video_mode(const struct drm_display_mode *mode,
 		return true;
 }
 
-static struct dc_stream_state *
+struct dc_stream_state *
 create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		       const struct drm_display_mode *drm_mode,
 		       const struct dm_connector_state *dm_state,
@@ -7002,7 +7002,7 @@ static void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
 	create_eml_sink(aconnector);
 }
 
-static struct dc_stream_state *
+struct dc_stream_state *
 create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 				const struct drm_display_mode *drm_mode,
 				const struct dm_connector_state *dm_state,
@@ -10176,7 +10176,7 @@ static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state) {
 	dm_new_crtc_state->freesync_config.fixed_refresh_in_uhz = res;
 }
 
-static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
+int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 				struct drm_atomic_state *state,
 				struct drm_crtc *crtc,
 				struct drm_crtc_state *old_crtc_state,
@@ -10964,6 +10964,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 				}
 			}
 		}
+		pre_validate_dsc(state, &dm_state, vars);
 	}
 #endif
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index e35977fda5c1..03d457f8a5f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -737,4 +737,17 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(bool is_cmd_aux,
 
 bool check_seamless_boot_capability(struct amdgpu_device *adev);
 
+struct dc_stream_state *create_validate_stream_for_sink(
+				struct amdgpu_dm_connector *aconnector,
+				const struct drm_display_mode *drm_mode,
+				const struct dm_connector_state *dm_state,
+				const struct dc_stream_state *old_stream);
+
+int dm_atomic_get_state(
+			struct drm_atomic_state *state,
+			struct dm_atomic_state **dm_state);
+
+struct amdgpu_dm_connector *amdgpu_dm_find_first_crtc_matching_connector(
+					struct drm_atomic_state *state,
+					struct drm_crtc *crtc);
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 52ce5cc6462f..d881b094ce28 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -47,6 +47,9 @@
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 #include "dc/dcn20/dcn20_resource.h"
+bool is_timing_changed(struct dc_stream_state *cur_stream,
+			struct dc_stream_state *new_stream);
+
 #endif
 
 static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
@@ -1079,5 +1082,191 @@ bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 
 	return true;
 }
+static bool pre_compute_mst_dsc_configs_for_state(
+					struct drm_atomic_state *state,
+					struct dc_state *dc_state,
+					struct dsc_mst_fairness_vars *vars)
+{
+	int i, j;
+	struct dc_stream_state *stream;
+	bool computed_streams[MAX_PIPES];
+	struct amdgpu_dm_connector *aconnector;
+	int link_vars_start_index = 0;
+
+	for (i = 0; i < dc_state->stream_count; i++)
+		computed_streams[i] = false;
+
+	for (i = 0; i < dc_state->stream_count; i++) {
+		stream = dc_state->streams[i];
+
+		if (stream->signal != SIGNAL_TYPE_DISPLAY_PORT_MST)
+			continue;
+
+		aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
+
+		if (!aconnector || !aconnector->dc_sink)
+			continue;
+
+		if (!aconnector->dc_sink->dsc_caps.dsc_dec_caps.is_dsc_supported)
+			continue;
+
+		if (computed_streams[i])
+			continue;
+
+		if (!is_dsc_need_re_compute(state, dc_state, stream->link))
+			continue;
+
+		mutex_lock(&aconnector->mst_mgr.lock);
+		if (!compute_mst_dsc_configs_for_link(state, dc_state, stream->link,
+			vars, &link_vars_start_index)) {
+			mutex_unlock(&aconnector->mst_mgr.lock);
+		return false;
+		}
+		mutex_unlock(&aconnector->mst_mgr.lock);
+
+		for (j = 0; j < dc_state->stream_count; j++) {
+			if (dc_state->streams[j]->link == stream->link)
+				computed_streams[j] = true;
+		}
+	}
+
+	return true;
+}
+
+static int find_crtc_index_in_state_by_stream(struct drm_atomic_state *state,
+					struct dc_stream_state *stream)
+{
+	int i;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *new_state, *old_state;
+
+	for_each_oldnew_crtc_in_state(state, crtc, old_state, new_state, i) {
+		struct dm_crtc_state *dm_state = to_dm_crtc_state(new_state);
 
+		if (dm_state->stream == stream)
+			return i;
+	}
+	return -1;
+}
+static bool is_link_to_dschub(struct dc_link *dc_link)
+{
+	union dpcd_dsc_basic_capabilities *dsc_caps =
+			&dc_link->dpcd_caps.dsc_caps.dsc_basic_caps;
+
+	/* only check phy used by dsc mst branch */
+	if (dc_link->type != dc_connection_mst_branch)
+		return false;
+
+	if (!(dsc_caps->fields.dsc_support.DSC_SUPPORT ||
+			dsc_caps->fields.dsc_support.DSC_PASSTHROUGH_SUPPORT))
+		return false;
+	return true;
+}
+
+static bool is_dsc_precompute_needed(struct drm_atomic_state *state)
+{
+	uint32_t i;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	bool ret = false;
+
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
+		struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(new_crtc_state);
+
+		if (amdgpu_dm_find_first_crtc_matching_connector(state, crtc) == NULL) {
+			ret =  false;
+			break;
+		}
+		if (dm_crtc_state->stream && dm_crtc_state->stream->link)
+			if (is_link_to_dschub(dm_crtc_state->stream->link))
+				ret = true;
+	}
+	return ret;
+}
+
+void pre_validate_dsc(struct drm_atomic_state *state,
+			struct dm_atomic_state **dm_state_ptr,
+			struct dsc_mst_fairness_vars *vars)
+{
+	uint32_t i;
+	struct dm_atomic_state *dm_state;
+	struct dc_state *local_dc_state = NULL;
+
+	if (!is_dsc_precompute_needed(state)) {
+		DRM_DEBUG_DRIVER("DSC precompute is not needed.\n");
+		return;
+	}
+	if (dm_atomic_get_state(state, dm_state_ptr)) {
+		DRM_DEBUG_DRIVER("dm_atomic_get_state() failed\n");
+		return;
+	}
+	dm_state = *dm_state_ptr;
+
+	/*
+	 * create local vailable for dc_state. copy content of streams of dm_state->context
+	 * to local variable. make sure stream pointer of local variable not the same as stream
+	 * from dm_state->context.
+	 */
+
+	local_dc_state = kmemdup(dm_state->context, sizeof(struct dc_state), GFP_KERNEL);
+	if (!local_dc_state)
+		return;
+
+	for (i = 0; i < local_dc_state->stream_count; i++) {
+		struct dc_stream_state *stream = dm_state->context->streams[i];
+		int ind = find_crtc_index_in_state_by_stream(state, stream);
+
+		if (ind >= 0) {
+			struct amdgpu_dm_connector *aconnector;
+			struct drm_connector_state *drm_new_conn_state;
+			struct dm_connector_state *dm_new_conn_state;
+			struct dm_crtc_state *dm_old_crtc_state;
+
+			aconnector = amdgpu_dm_find_first_crtc_matching_connector(state,
+									state->crtcs[ind].ptr);
+			drm_new_conn_state = drm_atomic_get_new_connector_state(state,
+									&aconnector->base);
+			dm_new_conn_state = to_dm_connector_state(drm_new_conn_state);
+			dm_old_crtc_state = to_dm_crtc_state(state->crtcs[ind].old_state);
+
+			local_dc_state->streams[i] = create_validate_stream_for_sink(aconnector,
+								&state->crtcs[ind].new_state->mode,
+								dm_new_conn_state,
+								dm_old_crtc_state->stream);
+		}
+	}
+
+	if (!pre_compute_mst_dsc_configs_for_state(state, local_dc_state, vars)) {
+		DRM_DEBUG_DRIVER("pre_compute_mst_dsc_configs_for_state() failed\n");
+		goto clean_exit;
+	}
+
+
+	/*
+	 * compare local_streams -> timing  with dm_state->context,
+	 * if the same set crtc_state->mode-change = 0;
+	 */
+	for (i = 0; i < local_dc_state->stream_count; i++) {
+		struct dc_stream_state *stream = dm_state->context->streams[i];
+
+		if (local_dc_state->streams[i] &&
+				is_timing_changed(stream, local_dc_state->streams[i])) {
+			DRM_DEBUG_DRIVER("crtc[%d] needs mode_changed\n", i);
+		} else {
+			int ind = find_crtc_index_in_state_by_stream(state, stream);
+
+			if (ind >= 0)
+				state->crtcs[ind].new_state->mode_changed = 0;
+		}
+	}
+clean_exit:
+	for (i = 0; i < local_dc_state->stream_count; i++) {
+		struct dc_stream_state *stream = dm_state->context->streams[i];
+
+		if (local_dc_state->streams[i] != stream)
+			dc_stream_release(local_dc_state->streams[i]);
+	}
+
+	kfree(local_dc_state);
+}
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 5da28ca03372..c561e0d872d6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -60,6 +60,10 @@ bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 				       struct dsc_mst_fairness_vars *vars);
 
 bool needs_dsc_aux_workaround(struct dc_link *link);
+
+void pre_validate_dsc(struct drm_atomic_state *state,
+		      struct dm_atomic_state **dm_state_ptr,
+		      struct dsc_mst_fairness_vars *vars);
 #endif
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b36bae4b5bc9..23e113dc0790 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1614,7 +1614,7 @@ bool dc_add_all_planes_for_stream(
 	return add_all_planes_for_stream(dc, stream, &set, 1, context);
 }
 
-static bool is_timing_changed(struct dc_stream_state *cur_stream,
+bool is_timing_changed(struct dc_stream_state *cur_stream,
 		struct dc_stream_state *new_stream)
 {
 	if (cur_stream == NULL)
-- 
2.25.1

