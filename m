Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD47C54E94
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2CA10E3B2;
	Thu, 26 Jan 2023 00:33:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE5910E3B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqmTeU98p7qAszM+14cv1UmOTwtA8gzbMA2DAdZMsiYXUCfrlDgmBcBdYFz/7uK9ThT/0hu9ruZ1+CyT+79n7/+S2UjDV0qeyirC5NJt0BGcI+70jN9Xqrzfch+xWre3mwzLbKCznDdUO97fbHj7i0/k2ZkwrFgDpevN08rvnc6HBaUPNRI0ZdqhgAEUPAU+Qcy/ItauPMlyM90iR+9bqC5mdnaXAvV9e8ZkoMc/MX88pF45SyxGL46Tp2bkhFgJASS963cC1ied03YbpglXATYsWLgJj+/F5bcWGXr4SuQAr4lHTvs0Q/u5pht1KuRZfw00PHCUBp2Sgb/fbqgBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hzd1A3jw37MnJOGBVyOeetk04GYivtJaSgQYUr2PJig=;
 b=TMROhvFF6QYMM7j2g1SxE3f8ppn+vgmRVKD0I3s9eOeIykOskHaaWycITzf7p9P0+A6rTGn/jcY13YVlAkyWdPzXVRSc0TwJUBX6XfDU0QsXP53KlXry36RgwXAdru58gAaPK44TPvurBLZFOm176shs/77qdpikrywtWQx+fLq6iwJa3N8qmIJYUAObTwxqPWvLv2IUxPQcBcZfLhtoTDK0hZ/j9jYRIKtD2uiwy1Bp/CeaWQryYEs25n0p961la7MXfS/LHo/BT5hiOshOD53wNjOP+ox7TQREGalGEdMU4QixsqPWmxvJvSYX83/ty/4nE/VcD63nHlnIRy82Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hzd1A3jw37MnJOGBVyOeetk04GYivtJaSgQYUr2PJig=;
 b=KfhEWQQdnp/y/CSLScuxNDKNY1xX0KBuoU98+NeZMtM95YpElzPLfh4y7J+TeHFu0LHkwG394SWO5teXxa0orCgyxRmzeYb809M9aArz3AyGgK00M/Dpw7hoWXxTylAC/NKY4nPDcW/lE2nTBFGSzoKe0h7XPzLv5FtOVfLwyBU=
Received: from DS7PR05CA0064.namprd05.prod.outlook.com (2603:10b6:8:57::26) by
 DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22; Thu, 26 Jan 2023 00:33:46 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::8f) by DS7PR05CA0064.outlook.office365.com
 (2603:10b6:8:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Thu, 26 Jan 2023 00:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 26 Jan 2023 00:33:46 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:33:43 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/16] drm/amd/display: Enable Freesync over PCon
Date: Wed, 25 Jan 2023 17:32:15 -0700
Message-ID: <20230126003230.4178466-2-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: f01531d7-e780-4c16-222e-08daff34fc46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWNTiMbz2bBW52vXpjtVDViMCIoD75CyZGq7/vA4NG3me/SH8jqlnJkYDhDUuKOv9KDPtUJMrZ4o01T5F4iYZFIqVHwJ29C3TcsqHYpkmP7AtK8a0fezIAkkoR4HBOerDG1V2TX3r/WOrJFaErZcEVUdyL7zIiCEf4W1Wilf7wR11ayVar28pzgwGKg+MGJcEQL7gAfJ2oYf3EWtzYErl0SVTbZdRKny1zD6SsPfg8fFWM8Hl6FkazheR1Jn9imvipp0suPGYTz4LezU80Oxy8AA8HKMyWdlz48uMRffRoADNNZkB5Tsd/oFpV6hmANwZm8NKkNShdtHO5a3Ebig5NG7u3F3TKjmwMR/gl0z+ahayt+G+ebj0fsfpX9GbSJZeIbP22kYwjjipBLeJ5pLGIujGxIejH0naTgL+r0bnWO6wBxnqZ+trjEIwtFpg9sML2lR3cVg9VmNLxE4r/s2gtBD6ff44z75pF4K/npgTY9xlbSdJbmWpVvPzes+LOUDqXvWTRUrWL1MAzWwrfGRO03AH2LYamEnJStS4LL+U10f6oc6YkAkgxFTGxeJSIGt4hPpJ1s8Ltv0OVhcENso2rLbjsFA0sEGebjGGRQM+iQ2t1MTAqcZuqKJ58MTnbp6+PIT4NRg7kT9/iXgwB2eVv13TnNgSOBnj7SSfinb/hl6XEupgtp21w5JYBSb49QQquGg47qIZGqKIS8Gsi+dBCObp1cXxsRfS2cHScCclho=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199018)(46966006)(36840700001)(40470700004)(6916009)(41300700001)(8936002)(44832011)(5660300002)(36756003)(30864003)(2906002)(82310400005)(40460700003)(40480700001)(8676002)(54906003)(478600001)(4326008)(7696005)(70586007)(70206006)(36860700001)(47076005)(81166007)(356005)(86362001)(82740400003)(336012)(83380400001)(2616005)(316002)(426003)(186003)(26005)(16526019)(1076003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:33:46.1402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f01531d7-e780-4c16-222e-08daff34fc46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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
Cc: Chao-kai Wang <Stylon.Wang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Sung Joon Kim <sungkim@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
Enable Freesync over PCon on Linux environment.

[how]
Adding Freesync over PCon support in amdgpu_dm
- Read DPCD for Freesync over PCon capabilitiy
- Add whitelist for compatible branch devices

Reviewed-by: Chao-kai Wang <Stylon.Wang@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 45 ++++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 67 ++++++++++---------
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 33 +++++++++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  1 +
 .../amd/display/include/ddc_service_types.h   |  1 +
 .../amd/display/modules/inc/mod_info_packet.h |  4 +-
 .../display/modules/info_packet/info_packet.c |  4 +-
 7 files changed, 118 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 86a2f7f58550..763bc92385da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -106,7 +106,6 @@
 
 #include "modules/inc/mod_freesync.h"
 #include "modules/power/power_helpers.h"
-#include "modules/inc/mod_info_packet.h"
 
 #define FIRMWARE_RENOIR_DMUB "amdgpu/renoir_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_RENOIR_DMUB);
@@ -7115,6 +7114,9 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	aconnector->base.dpms = DRM_MODE_DPMS_OFF;
 	aconnector->hpd.hpd = AMDGPU_HPD_NONE; /* not used */
 	aconnector->audio_inst = -1;
+	aconnector->pack_sdp_v1_3 = false;
+	aconnector->as_type = ADAPTIVE_SYNC_TYPE_NONE;
+	memset(&aconnector->vsdb_info, 0, sizeof(aconnector->vsdb_info));
 	mutex_init(&aconnector->hpd_lock);
 
 	/*
@@ -7605,6 +7607,8 @@ static void update_freesync_state_on_stream(
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(new_crtc_state->base.crtc);
 	unsigned long flags;
 	bool pack_sdp_v1_3 = false;
+	struct amdgpu_dm_connector *aconn;
+	enum vrr_packet_type packet_type = PACKET_TYPE_VRR;
 
 	if (!new_stream)
 		return;
@@ -7640,11 +7644,27 @@ static void update_freesync_state_on_stream(
 		}
 	}
 
+	aconn = (struct amdgpu_dm_connector *)new_stream->dm_stream_context;
+
+	if (aconn && aconn->as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) {
+		pack_sdp_v1_3 = aconn->pack_sdp_v1_3;
+
+		if (aconn->vsdb_info.amd_vsdb_version == 1)
+			packet_type = PACKET_TYPE_FS_V1;
+		else if (aconn->vsdb_info.amd_vsdb_version == 2)
+			packet_type = PACKET_TYPE_FS_V2;
+		else if (aconn->vsdb_info.amd_vsdb_version == 3)
+			packet_type = PACKET_TYPE_FS_V3;
+
+		mod_build_adaptive_sync_infopacket(new_stream, aconn->as_type, NULL,
+					&new_stream->adaptive_sync_infopacket);
+	}
+
 	mod_freesync_build_vrr_infopacket(
 		dm->freesync_module,
 		new_stream,
 		&vrr_params,
-		PACKET_TYPE_VRR,
+		packet_type,
 		TRANSFER_FUNC_UNKNOWN,
 		&vrr_infopacket,
 		pack_sdp_v1_3);
@@ -10313,6 +10333,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
 	bool freesync_capable = false;
+	enum adaptive_sync_type as_type = ADAPTIVE_SYNC_TYPE_NONE;
 
 	if (!connector->state) {
 		DRM_ERROR("%s - Connector has no state", __func__);
@@ -10405,6 +10426,26 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		}
 	}
 
+	as_type = dm_get_adaptive_sync_support_type(amdgpu_dm_connector->dc_link);
+
+	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) {
+		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
+		if (i >= 0 && vsdb_info.freesync_supported && vsdb_info.amd_vsdb_version > 0) {
+
+			amdgpu_dm_connector->pack_sdp_v1_3 = true;
+			amdgpu_dm_connector->as_type = as_type;
+			amdgpu_dm_connector->vsdb_info = vsdb_info;
+
+			amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
+			amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
+			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
+				freesync_capable = true;
+
+			connector->display_info.monitor_range.min_vfreq = vsdb_info.min_refresh_rate_hz;
+			connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
+		}
+	}
+
 update:
 	if (dm_con_state)
 		dm_con_state->freesync_capable = freesync_capable;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index d89f2eaf9117..ed5cbe9da40c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -59,6 +59,7 @@
 #include "irq_types.h"
 #include "signal_types.h"
 #include "amdgpu_dm_crc.h"
+#include "mod_info_packet.h"
 struct aux_payload;
 struct set_config_cmd_payload;
 enum aux_return_code_type;
@@ -577,6 +578,36 @@ enum mst_progress_status {
 	MST_CLEAR_ALLOCATED_PAYLOAD = BIT(3),
 };
 
+/**
+ * struct amdgpu_hdmi_vsdb_info - Keep track of the VSDB info
+ *
+ * AMDGPU supports FreeSync over HDMI by using the VSDB section, and this
+ * struct is useful to keep track of the display-specific information about
+ * FreeSync.
+ */
+struct amdgpu_hdmi_vsdb_info {
+	/**
+	 * @amd_vsdb_version: Vendor Specific Data Block Version, should be
+	 * used to determine which Vendor Specific InfoFrame (VSIF) to send.
+	 */
+	unsigned int amd_vsdb_version;
+
+	/**
+	 * @freesync_supported: FreeSync Supported.
+	 */
+	bool freesync_supported;
+
+	/**
+	 * @min_refresh_rate_hz: FreeSync Minimum Refresh Rate in Hz.
+	 */
+	unsigned int min_refresh_rate_hz;
+
+	/**
+	 * @max_refresh_rate_hz: FreeSync Maximum Refresh Rate in Hz
+	 */
+	unsigned int max_refresh_rate_hz;
+};
+
 struct amdgpu_dm_connector {
 
 	struct drm_connector base;
@@ -649,6 +680,11 @@ struct amdgpu_dm_connector {
 	/* Automated testing */
 	bool timing_changed;
 	struct dc_crtc_timing *timing_requested;
+
+	/* Adaptive Sync */
+	bool pack_sdp_v1_3;
+	enum adaptive_sync_type as_type;
+	struct amdgpu_hdmi_vsdb_info vsdb_info;
 };
 
 static inline void amdgpu_dm_set_mst_status(uint8_t *status,
@@ -719,37 +755,6 @@ struct dm_connector_state {
 	uint64_t pbn;
 };
 
-/**
- * struct amdgpu_hdmi_vsdb_info - Keep track of the VSDB info
- *
- * AMDGPU supports FreeSync over HDMI by using the VSDB section, and this
- * struct is useful to keep track of the display-specific information about
- * FreeSync.
- */
-struct amdgpu_hdmi_vsdb_info {
-	/**
-	 * @amd_vsdb_version: Vendor Specific Data Block Version, should be
-	 * used to determine which Vendor Specific InfoFrame (VSIF) to send.
-	 */
-	unsigned int amd_vsdb_version;
-
-	/**
-	 * @freesync_supported: FreeSync Supported.
-	 */
-	bool freesync_supported;
-
-	/**
-	 * @min_refresh_rate_hz: FreeSync Minimum Refresh Rate in Hz.
-	 */
-	unsigned int min_refresh_rate_hz;
-
-	/**
-	 * @max_refresh_rate_hz: FreeSync Maximum Refresh Rate in Hz
-	 */
-	unsigned int max_refresh_rate_hz;
-};
-
-
 #define to_dm_connector_state(x)\
 	container_of((x), struct dm_connector_state, base)
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index a50319fc42b1..5c733d445fe9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1133,3 +1133,36 @@ void dm_helpers_dp_mst_update_branch_bandwidth(
 	// TODO
 }
 
+static bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id)
+{
+	bool ret_val = false;
+
+	switch (branch_dev_id) {
+	case DP_BRANCH_DEVICE_ID_0060AD:
+		ret_val = true;
+		break;
+	default:
+		break;
+	}
+
+	return ret_val;
+}
+
+enum adaptive_sync_type dm_get_adaptive_sync_support_type(struct dc_link *link)
+{
+	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
+	enum adaptive_sync_type as_type = ADAPTIVE_SYNC_TYPE_NONE;
+
+	switch (dpcd_caps->dongle_type) {
+	case DISPLAY_DONGLE_DP_HDMI_CONVERTER:
+		if (dpcd_caps->adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT == true &&
+			dpcd_caps->allow_invalid_MSA_timing_param == true &&
+			dm_is_freesync_pcon_whitelist(dpcd_caps->branch_dev_id))
+			as_type = FREESYNC_TYPE_PCON_IN_WHITELIST;
+		break;
+	default:
+		break;
+	}
+
+	return as_type;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index c624c768cc3d..7ce9a5b6c33b 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -199,6 +199,7 @@ int dm_helpers_dmub_set_config_sync(struct dc_context *ctx,
 		const struct dc_link *link,
 		struct set_config_cmd_payload *payload,
 		enum set_config_status *operation_result);
+enum adaptive_sync_type dm_get_adaptive_sync_support_type(struct dc_link *link);
 
 enum dc_edid_status dm_helpers_get_sbios_edid(struct dc_link *link, struct dc_edid *edid);
 
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 3610f71891a3..31a12ce79a8e 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -35,6 +35,7 @@
 #define DP_BRANCH_DEVICE_ID_00E04C 0x00E04C
 #define DP_BRANCH_DEVICE_ID_006037 0x006037
 #define DP_BRANCH_DEVICE_ID_001CF8 0x001CF8
+#define DP_BRANCH_DEVICE_ID_0060AD 0x0060AD
 #define DP_BRANCH_HW_REV_10 0x10
 #define DP_BRANCH_HW_REV_20 0x20
 
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 91fe039c0c95..66dc9a19aebe 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -44,8 +44,8 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 enum adaptive_sync_type {
 	ADAPTIVE_SYNC_TYPE_NONE                  = 0,
 	ADAPTIVE_SYNC_TYPE_DP                    = 1,
-	ADAPTIVE_SYNC_TYPE_PCON_IN_WHITELIST     = 2,
-	ADAPTIVE_SYNC_TYPE_PCON_NOT_IN_WHITELIST = 3,
+	FREESYNC_TYPE_PCON_IN_WHITELIST          = 2,
+	FREESYNC_TYPE_PCON_NOT_IN_WHITELIST      = 3,
 	ADAPTIVE_SYNC_TYPE_EDP                   = 4,
 };
 
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index a8a31d0a7a7f..ec64f19e1786 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -533,11 +533,11 @@ void mod_build_adaptive_sync_infopacket(const struct dc_stream_state *stream,
 		if (stream != NULL)
 			mod_build_adaptive_sync_infopacket_v2(stream, param, info_packet);
 		break;
-	case ADAPTIVE_SYNC_TYPE_PCON_IN_WHITELIST:
+	case FREESYNC_TYPE_PCON_IN_WHITELIST:
 		mod_build_adaptive_sync_infopacket_v1(info_packet);
 		break;
 	case ADAPTIVE_SYNC_TYPE_NONE:
-	case ADAPTIVE_SYNC_TYPE_PCON_NOT_IN_WHITELIST:
+	case FREESYNC_TYPE_PCON_NOT_IN_WHITELIST:
 	default:
 		break;
 	}
-- 
2.39.1

