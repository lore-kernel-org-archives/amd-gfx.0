Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4EBC27C42
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D87C10E3C3;
	Wed, 16 Aug 2023 21:29:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A11F110E3C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3sur0FJHZyfJCK+/WS+BftLIURVxKT6gvAZLOSZv1bpcD3RxYuefCvpMwLuIjqCO226dd8a3hE2VvRswcEVXLLUxIatV0uGGQo1yARsKZcOe++yn113Iwd3R4lQpNzDYm0WMALJ6qlWnBHInSjURomJ4B6wQlJvQ6w7H8Wa7qKP+5GU9l7hv2H9ETAKCrjNscSgnXBFbX/hBnQs8Q/A3BCX/GPgWhNqKOaX2Jy9/LbPrQQ8hqOKZtwKiAbJDwSiNLQuDdRA0jEHeihVoCDw4STwsMoYZ6b3vVUMv3CAiSRbNEseklv5U03UXsxHOGpLSCH0ygeY+KvpzIvqGk/pxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ughWP/YvqabsHAbunE5904uYGjAFdzFmsCFBNOmRU/Q=;
 b=Qv28SVEWYCXXXKSn3Zg/38vJNvevOV4xYNBYv7k8alD67LXQpseFC6FCPjR6RRrZF4GGmT8NPfkR2SFH5cisvgnLNakDS1Ak0/WC79mT4e762vehvUIC7ZoZAtM4ydtfHqa/PJ3YNDMcsC8sQ8UcacpsSbftWMr1kwwIQ5ArbwU96t+aEjcTtUbvut02LsPIZTM8pdoY+RKT62BS0ebgdJYsKEZa9t1Sv6MJjZfNZ4miQfh4kA9IChZrbAabRXRPB6xVJXuh9Bvr/WN/bIJt4TAivFmU3HBpTaGeFy7qByDoMyLLni/RG3A6kB28Z8stzEdDEHmgCHUWNHi24AXCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ughWP/YvqabsHAbunE5904uYGjAFdzFmsCFBNOmRU/Q=;
 b=tCugUmxB+AHZsHGqKaX9w5AaUmG70lJ78F/6ZX0H9iD6musB13TSKf/diRbQSmf1C3lDJUJtLcKQTV1Pfc828qVEw8ULFXFxyyGOSqxebUS6/Hbann12aBpNozhULEa0w+5nayBiqKi1bEI+d0HqcFAGTbvk2jbdorCE3SQugOY=
Received: from DS7PR07CA0023.namprd07.prod.outlook.com (2603:10b6:5:3af::28)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 21:29:24 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::5d) by DS7PR07CA0023.outlook.office365.com
 (2603:10b6:5:3af::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:29:24 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:29:23 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/18] drm/amd/display: Skip writeback connector when we get
 amdgpu_dm_connector
Date: Wed, 16 Aug 2023 15:26:12 -0600
Message-ID: <20230816212626.987519-5-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dab47e5-6938-444d-4413-08db9e9fdcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Blc9ic4h+n7ApOfOczS58RKm9RLMyLhjfGXnGOjQj0JNBUmlCAxyfsKwmO6Qa4TZXLzFkhNh1m7cH/qWersLJS64Vsz1vkYvt2Wl4wmNZ5sK08hMSZLD8Om79kEkKOVnZS+jX7MLEaSwkJZe3LIgIYWdmccUWXggJ2W1T92pkGUWtT9wnJKHoRxYL02RoYX5ozOiREi5+e4LKg+eCmxnO79RAAOWs1jSr48caR5+V1CTxXHTiDv5B9NGiv1SXkKHhl5TOjKFC5R+0yGpwjKJDdYqP9TUB1OaMd54jG8h649Or/zCAeJ8TdVCX5+pJwpRJPYFndvPNgJUgHgV0P3RFO6MSC7gXn337+0QHm8gmIUW4AGYeVbGdZ1ULS6Fa6Pd8Y23V4Pan6TYfoG05t9tPynObXEx88ownvHediqksRKI/BgvxdSiciwwX3/ZwR2BYk2g/FUuGd1ExSMFYW2ZVYuF8bKWDUT0my+ij2iEFFy8hviMHQdBg4fvkLROryeA0QCIduOQCPpqAFRstTKhlwtacklKz1k/MBwhV3CpLpGCSXxKTjKtVEemXUeY09XPODs0i6tTLfvTtc9+gkOicWIjkIAzHkj+ORzE18E4ClLHGzCfx+XFOgdMHX0lA9guBt7MEJE6x569WfQk1UtA9LSNWn5ktAbMNGzgHnBL+86cwcJgqoqWNRwh7E0+ja2KR/i5i2n982ebRKMoPqKxbyDxNU1uix8Y/pp9g/UInoDAgUNuo30knJb3GKkLEO5LIUF00p3LPoVSWSUI0lSttg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:29:24.5882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dab47e5-6938-444d-4413-08db9e9fdcf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
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

From: Harry Wentland <harry.wentland@amd.com>

[WHY]
Writeback connectors are based on a different object:
drm_writeback_connector, and are therefore different from
amdgpu_dm_connector. We need to be careful to ensure code
designed for amdgpu_dm_connector doesn't inadvertently try
to operate on a drm_writeback_connector.

[HOW]
Skip them when connector type is DRM_MODE_CONNECTOR_WRITEBACK.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 62 +++++++++++++++++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  3 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 22 +++++--
 3 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 445369afcead..363d91d49a3a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -721,6 +721,10 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (link && aconnector->dc_link == link) {
 			if (notify->type == DMUB_NOTIFICATION_HPD)
@@ -945,6 +949,10 @@ static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int port,
 
 	drm_connector_list_iter_begin(dev, &conn_iter);
 	drm_for_each_connector_iter(connector, &conn_iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (aconnector->audio_inst != port)
 			continue;
@@ -2270,6 +2278,10 @@ static int detect_mst_link_for_all_connectors(struct drm_device *dev)
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (aconnector->dc_link->type == dc_connection_mst_branch &&
 		    aconnector->mst_mgr.aux) {
@@ -2350,6 +2362,10 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (aconnector->dc_link->type != dc_connection_mst_branch ||
 		    aconnector->mst_root)
@@ -2865,6 +2881,10 @@ static int dm_resume(void *handle)
 	/* Do detection*/
 	drm_connector_list_iter_begin(ddev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 
 		if (!aconnector->dc_link)
@@ -3416,6 +3436,9 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 	list_for_each_entry(connector,
 			&dev->mode_config.connector_list, head)	{
 
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 		dc_link = aconnector->dc_link;
 
@@ -5413,10 +5436,13 @@ static void fill_stream_properties_from_drm_display_mode(
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
 
@@ -6843,6 +6869,9 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 
 	for_each_new_connector_in_state(state, connector, new_con_state, i) {
 
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 
 		if (!aconnector->mst_output_port)
@@ -8392,6 +8421,9 @@ static void amdgpu_dm_commit_audio(struct drm_device *dev,
 		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
 			continue;
 
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 notify:
 		aconnector = to_amdgpu_dm_connector(connector);
 
@@ -8425,6 +8457,9 @@ static void amdgpu_dm_commit_audio(struct drm_device *dev,
 		if (!status)
 			continue;
 
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 
 		mutex_lock(&adev->dm.audio_lock);
@@ -8686,7 +8721,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
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
@@ -9029,10 +9069,15 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
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
 
@@ -9109,12 +9154,16 @@ static void get_freesync_config_for_crtc(
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
@@ -9898,6 +9947,9 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
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
2.41.0

