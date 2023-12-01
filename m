Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBB7C46CA3
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4828D10E896;
	Fri,  1 Dec 2023 13:29:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F9D410E891
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrzFMLqtd5ZQcuhecakY5yCBB39ojVNVe+QwCqcpTCb9qmhWXVE9iW+cjZEileyUuqyj8RXhZYM5Hsk3XmfjRgDRvwtJr+yJEsMtRfy1uiCc2N0Z4WAyGXg0e30h67P/o/JFfhGdbv7ikwsBinxwzBKhn0FdvYKennqZrXd9oa6whAyrii3Wi7T82He5xvsujoWuM5N0F7OmeCPUwq6a0EgaSrUaQtJ4D0nqMYfHoj4p0KgAVF0cUJIMVm3PtJ0JV9k4IVas4IlREvBaOpe2/YDGWWcHv95y5y8m9B3s/rr1qp6ImHyKFG43sYiNhdGGxtfYUu04ZKLwK9FIL85bSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAvHCCGpeXu1IHr7cj75NJf2J+AHww8Vm/sfTvf5kGc=;
 b=AM/Rt8NiTKdjOXkL9EEreY/B6BZVJwvpcjvvdn0yk8jX+31szCv7tzPoLMT5z2ABQqixWkAmYVLlE3U176ErnQx0uuCnl953BxFIha0T65udAPav9xn2XqTpp3+OyiqqfHgoUeBjeCdZZRZyGJiAdpO0qQpz0VsZ3//LYmkUeRVDh5a5VtS2jWbLAZpjfg1weBz0brkQ8a5fFum0t0f7Mf4zR0p9SKH5eaty2iPZpZ3C5XfgYGfvLBrLctf0+ul306epWHfvv2euAxoW6DJTiPchffh3Pz3utyA+Ua0csUbGU7yZ+cUbhuJK588dEC+nRLilKa6A+LJEkxFMfd7ssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAvHCCGpeXu1IHr7cj75NJf2J+AHww8Vm/sfTvf5kGc=;
 b=e+RBlPGpqd0d+RXTBJlPyRPwFVNJWdx1TcsUAjc27FCAaCm4WZy6zT8YCGNE9ASg9l9fXADkLmn9bvL6V3RcxotAvGo5qwVFkPBcV3ojso8O6Ub0gNumPWnb2tPVjz4f8IYWIdJ4AxmNilDNWKsZ+QVUOvWGowjXcnS/5RSYa9k=
Received: from DS0PR17CA0024.namprd17.prod.outlook.com (2603:10b6:8:191::29)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:29:07 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::3d) by DS0PR17CA0024.outlook.office365.com
 (2603:10b6:8:191::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:07 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:04 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/47] drm/amd/display: Skip writeback connector when we get
 amdgpu_dm_connector
Date: Fri, 1 Dec 2023 06:25:25 -0700
Message-ID: <20231201132731.2354141-30-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: 715b7850-03de-4d94-bf7c-08dbf2717ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luSCuzs24DEDQu+iid17OBxQ+3Q48+bluYzknaoIp8DhVYX1PDcyZQUjYNtr3n5TcGLq4W9R75HEvKKDX3wgrPmuR9c6/CnkzkSJ9IqdE2wg52X7l/5fdMeLmQvPAOHv9x2um4NWEgPS46N+6Tnl5E+/J5eMsZQ3IAPPbhZeDeAzQErVOBgaIeiIYRziQKgpSQFvt5dpSD3cL8tkebVPNqb+r7MH1ookGQLT2EEtrDz5tN+DljtTVr1V0G4UX3FPSyhkMoaQd+J7eFygtMW397bHVPx6AjvaWJRNjl0PhVdDrs1KaPu8XMqmEsrzqQwbHUs4nOAE68YgYNMYIHCM+hryeO7jDxQ5XQBDfaaqjoK6J2Hlhs8+LWtMNgX6tzCuWo7guHlDvl3N8I398iqjHBHGImZxs9yeBhIseJsX6/hIMggWR6aVb1b/xyEFLjsE9JWNSFkS0QuMomB63MCAKOanrGFYUbokK3kavqW5Vm2PPEnutfxNXghETN7HagwUQTdroloRV5+y5/rQD0OXw8r5Me9yI/qtid5dUYOx7ZAD42mZL8uEb34wxeCXXnk/TPV4OggIdDOn85K0OT8EyLtWwBjH21Kke1I7DZR3++NDe4L5cjo6BDq4zi8nzQm2GTvwLmRF44O0/nP4f8SS9hBMfqceiXmMtBeJycuUdpvi2nYegQHNbXEwgh9GXrDPH0h5tkjJ+YyV9Gru6XYWi6zTU9dGhACYvZTNW8ayl1vrJq0+rwJi9jYsgk8RwLDrlbyfSRVTiou8lrnr4PwlJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(316002)(6916009)(54906003)(70206006)(70586007)(478600001)(40460700003)(6666004)(5660300002)(41300700001)(36756003)(2906002)(8676002)(8936002)(86362001)(336012)(426003)(2616005)(16526019)(26005)(4326008)(1076003)(40480700001)(356005)(47076005)(81166007)(36860700001)(82740400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:07.5333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 715b7850-03de-4d94-bf7c-08dbf2717ed1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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

From: Harry Wentland <harry.wentland@amd.com>

[WHY]
Writeback connectors are based on a different object:
drm_writeback_connector, and are therefore different from
amdgpu_dm_connector. We need to be careful to ensure code
designed for amdgpu_dm_connector doesn't inadvertently try
to operate on a drm_writeback_connector.

[HOW]
Skip them when connector type is DRM_MODE_CONNECTOR_WRITEBACK.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 62 +++++++++++++++++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  3 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 22 +++++--
 3 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2b7224eb63a8..b94aceb6e677 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -725,6 +725,10 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (link && aconnector->dc_link == link) {
 			if (notify->type == DMUB_NOTIFICATION_HPD)
@@ -948,6 +952,10 @@ static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int port,
 
 	drm_connector_list_iter_begin(dev, &conn_iter);
 	drm_for_each_connector_iter(connector, &conn_iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (aconnector->audio_inst != port)
 			continue;
@@ -2254,6 +2262,10 @@ static int detect_mst_link_for_all_connectors(struct drm_device *dev)
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (aconnector->dc_link->type == dc_connection_mst_branch &&
 		    aconnector->mst_mgr.aux) {
@@ -2382,6 +2394,10 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (aconnector->dc_link->type != dc_connection_mst_branch ||
 		    aconnector->mst_root)
@@ -2903,6 +2919,10 @@ static int dm_resume(void *handle)
 	/* Do detection*/
 	drm_connector_list_iter_begin(ddev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 
 		if (!aconnector->dc_link)
@@ -3476,6 +3496,9 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 	list_for_each_entry(connector,
 			&dev->mode_config.connector_list, head)	{
 
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 		dc_link = aconnector->dc_link;
 
@@ -5496,10 +5519,13 @@ static void fill_stream_properties_from_drm_display_mode(
 {
 	struct dc_crtc_timing *timing_out = &stream->timing;
 	const struct drm_display_info *info = &connector->display_info;
-	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+	struct amdgpu_dm_connector *aconnector = NULL;
 	struct hdmi_vendor_infoframe hv_frame;
 	struct hdmi_avi_infoframe avi_frame;
 
+	if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
+		aconnector = to_amdgpu_dm_connector(connector);
+
 	memset(&hv_frame, 0, sizeof(hv_frame));
 	memset(&avi_frame, 0, sizeof(avi_frame));
 
@@ -6944,6 +6970,9 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 
 	for_each_new_connector_in_state(state, connector, new_con_state, i) {
 
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 
 		if (!aconnector->mst_output_port)
@@ -8503,6 +8532,9 @@ static void amdgpu_dm_commit_audio(struct drm_device *dev,
 		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
 			continue;
 
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 notify:
 		aconnector = to_amdgpu_dm_connector(connector);
 
@@ -8536,6 +8568,9 @@ static void amdgpu_dm_commit_audio(struct drm_device *dev,
 		if (!status)
 			continue;
 
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 
 		mutex_lock(&adev->dm.audio_lock);
@@ -8759,7 +8794,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
-		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+		struct amdgpu_dm_connector *aconnector;
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		aconnector = to_amdgpu_dm_connector(connector);
 
 		if (!adev->dm.hdcp_workqueue)
 			continue;
@@ -9153,10 +9193,15 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
 void dm_restore_drm_connector_state(struct drm_device *dev,
 				    struct drm_connector *connector)
 {
-	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+	struct amdgpu_dm_connector *aconnector;
 	struct amdgpu_crtc *disconnected_acrtc;
 	struct dm_crtc_state *acrtc_state;
 
+	if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+		return;
+
+	aconnector = to_amdgpu_dm_connector(connector);
+
 	if (!aconnector->dc_sink || !connector->state || !connector->encoder)
 		return;
 
@@ -9233,12 +9278,16 @@ static void get_freesync_config_for_crtc(
 	struct dm_connector_state *new_con_state)
 {
 	struct mod_freesync_config config = {0};
-	struct amdgpu_dm_connector *aconnector =
-			to_amdgpu_dm_connector(new_con_state->base.connector);
+	struct amdgpu_dm_connector *aconnector;
 	struct drm_display_mode *mode = &new_crtc_state->base.mode;
 	int vrefresh = drm_mode_vrefresh(mode);
 	bool fs_vid_mode = false;
 
+	if (new_con_state->base.connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+		return;
+
+	aconnector = to_amdgpu_dm_connector(new_con_state->base.connector);
+
 	new_crtc_state->vrr_supported = new_con_state->freesync_capable &&
 					vrefresh >= aconnector->min_vfreq &&
 					vrefresh <= aconnector->max_vfreq;
@@ -10068,6 +10117,9 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
 		if (conn_state->crtc != crtc)
 			continue;
 
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (!aconnector->mst_output_port || !aconnector->mst_root)
 			aconnector = NULL;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 52ecfa746b54..f936a35fa9eb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -326,6 +326,9 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 			if (!connector->state || connector->state->crtc != crtc)
 				continue;
 
+			if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+				continue;
+
 			aconn = to_amdgpu_dm_connector(connector);
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 51467f132c26..58b880acb087 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -894,10 +894,15 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
-		struct amdgpu_dm_connector *amdgpu_dm_connector =
-				to_amdgpu_dm_connector(connector);
+		struct amdgpu_dm_connector *amdgpu_dm_connector;
+		const struct dc_link *dc_link;
 
-		const struct dc_link *dc_link = amdgpu_dm_connector->dc_link;
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
+
+		dc_link = amdgpu_dm_connector->dc_link;
 
 		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
 			dc_interrupt_set(adev->dm.dc,
@@ -930,9 +935,14 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
-		struct amdgpu_dm_connector *amdgpu_dm_connector =
-				to_amdgpu_dm_connector(connector);
-		const struct dc_link *dc_link = amdgpu_dm_connector->dc_link;
+		struct amdgpu_dm_connector *amdgpu_dm_connector;
+		const struct dc_link *dc_link;
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
+		dc_link = amdgpu_dm_connector->dc_link;
 
 		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
 			dc_interrupt_set(adev->dm.dc,
-- 
2.42.0

