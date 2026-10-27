Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F358606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MFjsiMQE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A4B010F8A5;
	Tue, 27 Oct 2026 23:24:51 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CECF10F8A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:24:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogBWHzN1OaSrTOLP6T4aGoAtLtS1CxY1z17PnlKN5NVVHOnEgX2OTlHUAJowmn31VkMR9J5X33G5x/XIbkV1KJmF+FJDoMe/GKHxwx4h3GbWUETUApNTl6GcV+ROnuT1fxnmsPEFMY9EcT4fQXbgxQHApTeMz6sK9a4YD0DWtRfrgvKrsQXckWMa5scusDp660IzRdEWxdegiEbjWja/Ff+PBJPrEnGDoNeCycj4ZKBagEIsBHoosBoSGkXNZFgBPdEtC3GhkwXGPm2mbnAQGwxQocUipVovkbiQCUKB9YfsQWBB7SfryvClksrLTX7qIo8WtWL7WJW3l5We1zJscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UmUqQ0nztN43MhKRrYl/FpMLuOJsPUjZCNt/HmqrkY=;
 b=dBBRd1NRyrnGYrXcQnnRi6Z3sSzoQB/4sukuhJAM92a5ngeouyWzmvwv7wJ9PRvbFMRDdC65UT+8WhumQhB3hK7xB7r5C9Rcu4BEzaOYcc8HGwjr1wRE/B1FsYIoM1j/cR7h+9/eHJpm3O38tjqHwlzqX7OOspD70dBXMHAOMHIWAqQrUYlGZ52dJ78XPAljNkhPsUad4UO+62/s1Qm0jUWd/KJ6V/7E4ZLvO4pTm3q+GNjCd93j5p56CjHgf/3s6ndkeZzUyUF0RCdL9Xb3Ywi/Y9btyYVE/KtpOz5pe3fdx2Jvt8Mlq47D1IpUPpKmG1jLd6ysyQ6ToTk3jP6N4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UmUqQ0nztN43MhKRrYl/FpMLuOJsPUjZCNt/HmqrkY=;
 b=MFjsiMQEMzcjzpSdUdmboXlv5zD6dDdIByzyJM9PHAlAVtnxcvH0+VRYSFiihGsY3dsyhzTUXGxj1HlIjAYncP0uANIpMEWtE1PehLjf1PUvzuebozF6cDvQPaUpkrgqEazhprLSlGdywoTkPkwwGff69v1ql31CYtES08sAyVA=
Received: from CH0PR03CA0116.namprd03.prod.outlook.com (2603:10b6:610:cd::31)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:24:40 +0000
Received: from CH01EPF000BE947.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::89) by CH0PR03CA0116.outlook.office365.com
 (2603:10b6:610:cd::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:24:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE947.mail.protection.outlook.com (10.167.244.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:24:39 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:24:37 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 19/28] drm/amd/display: Add debugfs override for HDMI VRR
Date: Tue, 27 Oct 2026 17:17:15 -0600
Message-ID: <20261027232005.2879750-20-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE947:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd32111-eae3-4104-e0f3-08df34817926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|5023799004|11063799006|56012099006|261021123027099003|261022075727099003|261009223027099003|261021121427099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Nb5AsAQngYnKN9jlXfrJgP+HR96+tcj4ZDrg0jkthx9nEO46VVjjw2TKQVHjGrzF7lTG4SYybDuZKLxXmRQJFGRd6yGrmcxthzOs3PtPc3fonAd9lm/vVWrbpK13yEt/68XschTSkrKEqnvNkXi6NaOg1nZZbLMRh/F9T4nzBGX/xVfKhrI9a5Q+pESlpHBCDdt0r55fD0YgTxoLbvzkZROXaFvnFi1I8OcRuqUnbJrprO8RvrQRb3weyToKutyJftLUAW3VYSImiXpdNf9qoSwHVsyZqh2N71i/t9G+tebvZN0hl407eP7mK7jrYRvyA4y00oQJ+AoX3HKKYIsigiuaAdnillwJznFM/qboNcYurdM8PgQ6ItcAQfDn/pajYH8XH5mpvr6v+sdOzaZgaqiwv6wXhWYBhEVVlCdxYj8cyXaWs2ncMmVrzSOgkF7WoW6cDXT0+Et4pNgd4wcBObOGfQS7Bvd4+52yic3UM0ny0tguuhqcgNtqB+IFN7WNXEiO+nT9WKpIoTT+3udw8v6Qotvduo/WvSqeVHPlYjAI717lcWQPqm4CsgnUXXJVOIkLKrdQeqsaRC1vI/lY+42yew/aI8a3cj3hFfIjp0FVv4bRHohGBmCI0lPlNzFXBO7DH37EvMeifm/dsh+j/qzYyN5H+T0lpDkJehJYiTTUi7zK4GF15wfFTXUtrgcPa+G1f9mpigiau19//zx/nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(5023799004)(11063799006)(56012099006)(261021123027099003)(261022075727099003)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BVReSdxfgdBOk3QRWaihnaQh8xvbVipmJUrq3EjMatAW19kH3F0dggwHLp/YBzktYe85EdKIdnUffZSVedi9qE5O8Kpre9Rti9reHOR4TVlSzoLxMmgmqnN39iHL+MkUV2M5glYDOonghE47WeqEy1M/HwIeREuxFKwNU8LX7ESgCV4pJyc5eWcPSHqPR2M4jwWnC+g74OcbagfwbO4qmZzwivJccQrygthJKZjtoEKf1dsguFppGjlkEbWtgJF5H4rrqDzUkPSzgc83Y8tQMgW6tUYaaBc7vq5NCN1AewW02fCCdiWHpnmynVl3+5e02Vzxk1UxixpoxIUZWu5IhqyChRkqqYfn55SnvGPbKWXrSUezA1yGlf8k/879ZOS7W6DinrIh8Iesz7cbhm3xfB16o07k8XIKyioWX30rXvCMt4INgbfxlnZhunRBWXdW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:24:39.7363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd32111-eae3-4104-e0f3-08df34817926
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fangzhi Zuo <jerry.zuo@amd.com>

[WHY]
Provide a debugfs control to force HDMI VRR or disable VRR while debugging
sink capability and display behavior.

[HOW]
Add per-connector VRR override modes for automatic operation, forced
HDMI_VRR, and disabled VRR. Expose the override through debugfs and apply
it while updating HDMI VRR capability state, ranges, and connector
properties.

Cc: IVAN LIPSKI <ivan.lipski@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 ++
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 105 ++++++++++++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  30 +++++
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |   2 +-
 4 files changed, 123 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 656aa0e465eb..43a5cff3332c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -825,6 +825,12 @@ struct amdgpu_hdmi_vsdb_info {
 	bool replay_mode;
 };
 
+enum amdgpu_dm_vrr_override {
+	AMDGPU_DM_VRR_OVERRIDE_AUTO,
+	AMDGPU_DM_VRR_OVERRIDE_FORCE_HDMI_VRR,
+	AMDGPU_DM_VRR_OVERRIDE_DISABLE_VRR,
+};
+
 struct amdgpu_dm_connector {
 
 	struct drm_connector base;
@@ -915,6 +921,7 @@ struct amdgpu_dm_connector {
 	/* Adaptive Sync */
 	bool pack_sdp_v1_3;
 	enum adaptive_sync_type as_type;
+	enum amdgpu_dm_vrr_override vrr_override;
 	struct amdgpu_hdmi_vsdb_info vsdb_info;
 
 	/* HDMI HPD debounce support */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 37b41c887ede..d30aa21cd3ff 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3210,6 +3210,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	aconnector->audio_inst = -1;
 	aconnector->pack_sdp_v1_3 = false;
 	aconnector->as_type = ADAPTIVE_SYNC_TYPE_NONE;
+	aconnector->vrr_override = AMDGPU_DM_VRR_OVERRIDE_AUTO;
 	memset(&aconnector->vsdb_info, 0, sizeof(aconnector->vsdb_info));
 	mutex_init(&aconnector->hpd_lock);
 	mutex_init(&aconnector->handle_mst_msg_ready);
@@ -3834,6 +3835,58 @@ static __maybe_unused int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconne
 	return valid_vsdb_found ? i : -ENODEV;
 }
 
+static bool amdgpu_dm_apply_hdmi_vrr_override(struct drm_connector *connector,
+					      struct dc_sink *sink,
+					      bool *force_hdmi_vrr)
+{
+	struct amdgpu_dm_connector *aconnector =
+		to_amdgpu_dm_connector(connector);
+	struct amdgpu_device *adev = drm_to_adev(connector->dev);
+
+	if (aconnector->vrr_override ==
+			AMDGPU_DM_VRR_OVERRIDE_DISABLE_VRR) {
+		drm_dbg_driver(adev_to_drm(adev),
+			       "VRR: FreeSync/VRR disabled by debugfs override on %s\n",
+			       connector->name);
+		aconnector->min_vfreq = 0;
+		aconnector->max_vfreq = 0;
+		connector->display_info.monitor_range.min_vfreq = 0;
+		connector->display_info.monitor_range.max_vfreq = 0;
+		connector->display_info.hdmi.vrr_cap.supported = false;
+		connector->display_info.hdmi.vrr_cap.vrr_min = 0;
+		connector->display_info.hdmi.vrr_cap.vrr_max = 0;
+		aconnector->as_type = ADAPTIVE_SYNC_TYPE_NONE;
+		aconnector->pack_sdp_v1_3 = false;
+		memset(&aconnector->vsdb_info, 0,
+		       sizeof(aconnector->vsdb_info));
+		sink->edid_caps.freesync_vcp_code = 0;
+
+		return true;
+	}
+
+	*force_hdmi_vrr = aconnector->vrr_override ==
+		AMDGPU_DM_VRR_OVERRIDE_FORCE_HDMI_VRR;
+	if (*force_hdmi_vrr && connector->display_info.hdmi.vrr_cap.supported) {
+		drm_dbg_driver(adev_to_drm(adev),
+			       "VRR: HDMI_VRR forced by debugfs override on %s\n",
+			       connector->name);
+		aconnector->min_vfreq = 0;
+		aconnector->max_vfreq = 0;
+		aconnector->as_type = ADAPTIVE_SYNC_TYPE_NONE;
+		aconnector->pack_sdp_v1_3 = false;
+		memset(&aconnector->vsdb_info, 0,
+		       sizeof(aconnector->vsdb_info));
+		sink->edid_caps.freesync_vcp_code = 0;
+	} else if (*force_hdmi_vrr) {
+		drm_dbg_driver(adev_to_drm(adev),
+			       "VRR: HDMI_VRR force override ignored on %s (unsupported)\n",
+			       connector->name);
+		*force_hdmi_vrr = false;
+	}
+
+	return false;
+}
+
 /**
  * amdgpu_dm_update_freesync_caps - Update Freesync capabilities
  *
@@ -3860,6 +3913,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
 	const struct edid *edid;
+	bool force_hdmi_vrr = false;
 	bool freesync_capable = false;
 	enum adaptive_sync_type as_type = ADAPTIVE_SYNC_TYPE_NONE;
 
@@ -3927,27 +3981,38 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	} else if (drm_edid &&
 		  (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
 		   sink->sink_signal == SIGNAL_TYPE_HDMI_FRL)) {
-		has_vsdb = get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
-		amdgpu_dm_connector->vsdb_info = vsdb_info;
-		if (has_vsdb) {
-			sink->edid_caps.freesync_vcp_code = vsdb_info.freesync_mccs_vcp_code;
-
-			if (vsdb_info.freesync_supported) {
-				amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
-				amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
-				if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
-					freesync_capable = true;
+		if (amdgpu_dm_apply_hdmi_vrr_override(connector, sink, &force_hdmi_vrr))
+			goto update;
 
-				connector->display_info.monitor_range.min_vfreq = vsdb_info.min_refresh_rate_hz;
-				connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
+		if (!force_hdmi_vrr) {
+			has_vsdb = get_amd_vsdb(amdgpu_dm_connector, &vsdb_info);
+			amdgpu_dm_connector->vsdb_info = vsdb_info;
+			if (has_vsdb) {
+				sink->edid_caps.freesync_vcp_code =
+					vsdb_info.freesync_mccs_vcp_code;
+
+				if (vsdb_info.freesync_supported) {
+					amdgpu_dm_connector->min_vfreq =
+						vsdb_info.min_refresh_rate_hz;
+					amdgpu_dm_connector->max_vfreq =
+						vsdb_info.max_refresh_rate_hz;
+					if (amdgpu_dm_connector->max_vfreq -
+					    amdgpu_dm_connector->min_vfreq > 10)
+						freesync_capable = true;
+
+					connector->display_info.monitor_range.min_vfreq =
+						vsdb_info.min_refresh_rate_hz;
+					connector->display_info.monitor_range.max_vfreq =
+						vsdb_info.max_refresh_rate_hz;
+				}
 			}
-		}
 
-		drm_dbg_driver(adev_to_drm(adev),
-			       "VRR: amd_vsdb i=%d fs_sup=%d min=%d max=%d fs_capable=%d\n",
-					has_vsdb, vsdb_info.freesync_supported,
-			       vsdb_info.min_refresh_rate_hz,
-			       vsdb_info.max_refresh_rate_hz, freesync_capable);
+			drm_dbg_driver(adev_to_drm(adev),
+				       "VRR: FreeSync hdmi_freesync=%d min=%d max=%d freesync_capable=%d\n",
+				       vsdb_info.freesync_supported,
+				       vsdb_info.min_refresh_rate_hz,
+				       vsdb_info.max_refresh_rate_hz, freesync_capable);
+		}
 
 		/*
 		 * If AMD VSDB didn't provide a valid FreeSync range, fall back to
@@ -3958,7 +4023,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				&connector->display_info.hdmi.vrr_cap;
 
 			drm_dbg_driver(adev_to_drm(adev),
-				       "VRR: HF-VSDB fallback: hdmi_vrr=1 vrr_cap[sup=%d min=%d max=%d] mrange_max=%d\n",
+				       "VRR: HDMI_VRR hdmi_vrr=1 vrr_cap[sup=%d min=%d max=%d] mrange_max=%d\n",
 				       vrr_cap->supported, vrr_cap->vrr_min, vrr_cap->vrr_max,
 				       connector->display_info.monitor_range.max_vfreq);
 
@@ -4049,7 +4114,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		dm_con_state->freesync_capable = freesync_capable;
 
 	drm_dbg_driver(adev_to_drm(adev),
-		       "VRR: caps result: freesync_capable=%d min_vfreq=%d max_vfreq=%d\n",
+		       "VRR: caps result: vrr_capable=%d min_vfreq=%d max_vfreq=%d\n",
 		       freesync_capable, amdgpu_dm_connector->min_vfreq,
 		       amdgpu_dm_connector->max_vfreq);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 0cef66e20a86..b6ecd9f051db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3114,6 +3114,35 @@ static const struct file_operations dp_mst_link_settings_debugfs_fops = {
 	.llseek = default_llseek
 };
 
+/* 0: EDID behavior, 1: force HDMI VRR, 2: disable VRR. */
+static int vrr_override_set(void *data, u64 val)
+{
+	struct amdgpu_dm_connector *connector = data;
+
+	if (val > AMDGPU_DM_VRR_OVERRIDE_DISABLE_VRR)
+		return -EINVAL;
+
+	if (connector->vrr_override == val)
+		return 0;
+
+	connector->vrr_override = val;
+	drm_kms_helper_connector_hotplug_event(&connector->base);
+
+	return 0;
+}
+
+static int vrr_override_get(void *data, u64 *val)
+{
+	struct amdgpu_dm_connector *connector = data;
+
+	*val = connector->vrr_override;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(vrr_override_fops, vrr_override_get,
+			 vrr_override_set, "%llu\n");
+
 static const struct {
 	char *name;
 	const struct file_operations *fops;
@@ -3145,6 +3174,7 @@ static const struct {
 	char *name;
 	const struct file_operations *fops;
 } hdmi_debugfs_entries[] = {
+		{"vrr_override", &vrr_override_fops},
 		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
 		{"hdmi_cec_state", &hdmi_cec_state_fops}
 };
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 386ba88c57c6..fa628b2cd3e4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -195,7 +195,7 @@ void amdgpu_dm_get_freesync_config_for_crtc(
 	new_crtc_state->freesync_config = config;
 
 	drm_dbg_driver(new_con_state->base.connector->dev,
-		       "VRR: cfg vrr_enabled=%d vrr_supported=%d fs_capable=%d vrefresh=%d min=%d max=%d state=%d\n",
+		       "VRR: cfg vrr_enabled=%d vrr_supported=%d vrr_capable=%d vrefresh=%d min=%d max=%d state=%d\n",
 		       new_crtc_state->base.vrr_enabled,
 		       new_crtc_state->vrr_supported,
 		       new_con_state->freesync_capable, vrefresh,
-- 
2.53.0

