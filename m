Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DBDD6AAF7
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A73E10F2E8;
	Thu,  2 Apr 2026 18:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zltc75EO";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B6C10F2E1
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwVBLicZ/Jl3Kv4CEnJi4L/DhL4h7pZmzfHc3/MlOlwH2AD/+99uzxw1EtrlH+RsXH9HJeaiU/zGfkQV3rQFWk4eC/0hjGZLGpClL5k3vXnRF/k83ttELX1qxBxdhbg1WqR3AhH6FPjS5DxCGZ9o44qkkmObca7DM4eyscez+xfIWeOhRAxT6tPJfmmWiJg3IqC3J143AldligEm0ZWnZASev6MIdXh8vkAkmZh3adZC64YnBbb+IOR0tJjDUTrujee0im/OIRzk4e0WIQqkBOgZcF1AIAAK9O0HBMpuYJQoIZOytyMwS8NfmA/cLEKtajj375jRCkrFLqroj+QyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1r+UckM36lA296X5jDyT9k41/+kQb1A/h008NretKQ=;
 b=SSKOBL95lGIJQw07M6vbjRDHsFv0F23BGmPHcRufsLD2lhqtlULIU6K+v1QRWbzPI92Z6m1jNRvLGK4SifBSq3y6ea6gwuKULLcBTp5btmuqZDqGiIVvluLmt9mm/Yc+GUWTYZWoWWZtYOsLELsUsv0oz1tGSijBzcr6c7fICPjH8rUjjzaV31O2uk3lPT2YEYcbVQudWzCX0NqRE0c9u6YNryEwGMotg1YJmiU1hXj2HwuFwlZeXJZEEY4HCKstB6UkP4T+Rp6d3HiKpGIHY9oS/q/Nh4dN32DZKuyAQgfqtYFRWbBVXnCVQzc2xyZxbxFV2FzfxZMqkET4z8KCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1r+UckM36lA296X5jDyT9k41/+kQb1A/h008NretKQ=;
 b=zltc75EOB9uT8AyqXCPhscrLW2FixLlo3QIc23Patcmchbafh9Dq9plzP1sEmru4gJweatLSt1h1iosiGpxW4/iD84ApUhtBnAh5k0c8y3ATby52g51hPMZR9iDVMeeSTXeQPfhWM5tsz2R9PLcC6vJ65qkLeo4+bxC7nBKZ5+0=
Received: from CH0PR04CA0095.namprd04.prod.outlook.com (2603:10b6:610:75::10)
 by CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 18:33:49 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::65) by CH0PR04CA0095.outlook.office365.com
 (2603:10b6:610:75::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 18:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:33:49 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:33:48 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:33:42 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 07/22] drm/amd/display: Parse freesync mccs vcp code
Date: Thu, 2 Apr 2026 14:32:59 -0400
Message-ID: <20260402183314.1388755-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|CYXPR12MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: ec27c692-7a32-4b3f-b7f1-08de90e66212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nawc7zyOuqMXhpV4md6/vve3P47jPzUuDtW3IpXuRGi6I+SXeggNFsJ5dKdPFNj/Pnvadffhgtzd+69YrE2yCVu8TJcZREWKZTwze1ro91B2h8eVvOmoGHbuuCmqkStNG6Ik7DwuIdn+5aK5kQrs3R0A2tVem8aX3m5nWN5JFzUGv3n8kzHGqmrRCuA2qOB3GiXFHo2utK4zEPtoKUTqKCXdWDdD2Ngm0TalZiB0JLmTfXI3dM5XZzOEe+PXMbnOHkulnwjY4WZjyCfcxE9qaAhXCMm4B2VYlR9i/ar8C76zd8P0LxeBfv9JwMRWxIYfrno2hzSIBAdguYhRj5kkvyLDtk+jvH01Jmk0fyO8hE5fWpJWlm/3dQR3Ck4YxJlFJarIgOexeVwtmtL0TmaHN5hShxCnEAbpFlZaOtAzj34QKVex9yJ6YzVS46mo12B8WjtanjSbTWMvWxCNz/FLWWIBoa4vm8MObpRUwfxsHD3r1fAQ++xALAD/COP2JrEbdJUDPxM66JoBktQnSWXb5wEuIeIZprqEWlSEB5A9EwUQVRqM+u+oqX6JlLUWLxsfnwx2PFoiXc0FI2KzsSFWb+3zWFBjAgKl/jFnlqEhVgp/YO9IN1/XXVloEpZOG8TzaP9QgeNf6HLT6knIxDuLyC8CIyGKS5uyLujL9Zwz333c3vyOnfs2xqjKswhKRNHq0gppA5bUnz/LVZ5I0/NQ0MTlvmUPsn3IrEDl7T+pNE5BMI7RY8xqgPYaJpZwWn9SwRRp60W9EiBKSz7vDXzeww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 07SU13gAnEOivrrDXZPqOljr+EF0JbVbHPDJNZYVe18V/Iz+wZ0ZFwNxLgqqI55DcalvLALuUHlPuwWbs2rrVNzseoY3k38L+lHjQJVW3MmujaR8NB89rQ8XEbkh7cEGVnPFM4hHiH5MtF5lCKEY3chf/+p0SU+Fh8q12KD351O638XOcVndHkoBqdC3gt52MKapYKedZLV1CaE85P3ROVYcPZ6xNwIWw94I815XCB3rQf3h3nGUA5wrMEFOxBObN0Ni3Uegcvfi2SpMYUTbntqt3pFr0+otR2fLXknUPT/vrJrrdi0jNTwm6CbDKcqm11fgpdlq26/CN/Uqt26SDV2A9lDsXGd58eDeaDh0XBWEev3sNQPCdyeoRFRUbSAH4hA6R+qni2K/7NVBs1AEYtGBJyWbmcOLgHx3Tos+BHRdZHPirzWdi8VnEzJxoGYJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:33:49.5039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec27c692-7a32-4b3f-b7f1-08de90e66212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
DMUB supports to parse freesynce mccs vcp code now. Store it for
later freesync mccs manipulation.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 45 ++++++++++++-------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  5 +++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  2 +
 3 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 48e12f9a1818..c613deb7c88a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13043,6 +13043,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 		vsdb->amd_vsdb_version = output->amd_vsdb.amd_vsdb_version;
 		vsdb->min_refresh_rate_hz = output->amd_vsdb.min_frame_rate;
 		vsdb->max_refresh_rate_hz = output->amd_vsdb.max_frame_rate;
+		vsdb->freesync_mccs_vcp_code = output->amd_vsdb.freesync_mccs_vcp_code;
 	} else {
 		drm_warn(adev_to_drm(dm->adev), "Unknown EDID CEA parser results\n");
 		return false;
@@ -13077,6 +13078,8 @@ static bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
 				vsdb_info->amd_vsdb_version = version;
 				vsdb_info->min_refresh_rate_hz = min_rate;
 				vsdb_info->max_refresh_rate_hz = max_rate;
+				/* Not enabled on DMCU*/
+				vsdb_info->freesync_mccs_vcp_code = 0;
 				return true;
 			}
 			/* not amd vsdb */
@@ -13329,14 +13332,19 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 	} else if (drm_edid && sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
 		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
-		if (i >= 0 && vsdb_info.freesync_supported) {
-			amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
-			amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
-			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
-				freesync_capable = true;
+		if (i >= 0) {
+			amdgpu_dm_connector->vsdb_info = vsdb_info;
+			sink->edid_caps.freesync_vcp_code = vsdb_info.freesync_mccs_vcp_code;
 
-			connector->display_info.monitor_range.min_vfreq = vsdb_info.min_refresh_rate_hz;
-			connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
+			if (vsdb_info.freesync_supported) {
+				amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
+				amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
+				if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
+					freesync_capable = true;
+
+				connector->display_info.monitor_range.min_vfreq = vsdb_info.min_refresh_rate_hz;
+				connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
+			}
 		}
 	}
 
@@ -13345,19 +13353,22 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 	if (as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) {
 		i = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
-		if (i >= 0 && vsdb_info.freesync_supported && vsdb_info.amd_vsdb_version > 0) {
-
-			amdgpu_dm_connector->pack_sdp_v1_3 = true;
-			amdgpu_dm_connector->as_type = as_type;
+		if (i >= 0) {
 			amdgpu_dm_connector->vsdb_info = vsdb_info;
+			sink->edid_caps.freesync_vcp_code = vsdb_info.freesync_mccs_vcp_code;
 
-			amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
-			amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
-			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
-				freesync_capable = true;
+			if (vsdb_info.freesync_supported && vsdb_info.amd_vsdb_version > 0) {
+				amdgpu_dm_connector->pack_sdp_v1_3 = true;
+				amdgpu_dm_connector->as_type = as_type;
 
-			connector->display_info.monitor_range.min_vfreq = vsdb_info.min_refresh_rate_hz;
-			connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
+				amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
+				amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
+				if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
+					freesync_capable = true;
+
+				connector->display_info.monitor_range.min_vfreq = vsdb_info.min_refresh_rate_hz;
+				connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index d1a14e0c12bd..4a2c1bde28c9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -772,6 +772,11 @@ struct amdgpu_hdmi_vsdb_info {
 	 */
 	unsigned int max_refresh_rate_hz;
 
+	/**
+	 * @freesync_mccs_vcp_code: MCCS VCP code for freesync state
+	 */
+	unsigned int freesync_mccs_vcp_code;
+
 	/**
 	 * @replay_mode: Replay supported
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index fd8ec1660312..5b7490a7dc7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -205,6 +205,8 @@ struct dc_edid_caps {
 	uint32_t audio_latency;
 	uint32_t video_latency;
 
+	unsigned int freesync_vcp_code;
+
 	uint8_t qs_bit;
 	uint8_t qy_bit;
 
-- 
2.34.1

