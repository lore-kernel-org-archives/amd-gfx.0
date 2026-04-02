Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1703CD6AAEC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9853510F1BD;
	Thu,  2 Apr 2026 18:34:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eHjxX8zh";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012023.outbound.protection.outlook.com
 [40.93.195.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E269410F1BD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNYB8IO4yVCWDcjUOfcr5GR0m1GCsHcAwHdBG9QXzt1G3CAvJYD50o+Sz+cAXfkRGODfiR6yotKTnJIHbQwVB8cUddUvBjeNRrnV5BQYQ492Cpg7uduwZ437p+GT5Il6NJZQO2mSHBqVqqTja9XeN9lq+xsyDQVeKH8OSRpfkEJS90IgCdvi1/l+z1pVAXofs2d4zJ3Z6Si57Sqo0LkD8/15gXxvD3zWHw/A0nZeUWp7sU8AZ9f6BeMOxcPtMUNPh5O453cPeXRSSjyksThB0ZJlImD0i2JpOhiyzJs326HJFIhX3u2sd3zIDhr85NEMsTjWXhBklLg+Ca/Gx6oGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFqJM4ZNSuO5FvSL6SnOP6mxCoCd/xFEGbtuM13tmkc=;
 b=PX441xo2qDJ27uqWxHqNY9MuobqoaXncsi0wUe/G1VVCtDKWj+oNADfUfKjoV/oC6k9rU80VJYXXpV0Er5oslCLuIlxoCzIH1fShxLh7MBjt8LRMTsHQKcJmLnKbjfvVnLWelQ6ChTqoPWh+RCc58ZLze9wfe7kuHFJGmWXuxoWeCIm5yKw5agjrKt2fXVEhI5jQjIEvuVckvsREFl2Fv/aALUjy4iSEdKrSOAmEUqhLjNSWwGwzXJ5f7B/Kj2Oeiug6eW9t3R8I9bckG/fNBFLzdEXhOmu8PMo8DK8/1qhJSScr7WxULDBGszIRyWkfa20VOEV8Qx9kuKzdgzRqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFqJM4ZNSuO5FvSL6SnOP6mxCoCd/xFEGbtuM13tmkc=;
 b=eHjxX8zhM4RGKOArotnD3XoWCuElCYlo99sT+uTE6nFuI7JNmleecTsazWH+tUeAV2T5MslzTn2n6/NHRhKLSCYgYoyfNKW0rNnpjqUIlJpavYcjPY7FAN9NPRye6+wO557CWiCDZW97bAv1X1NbH3yJhxFMqy/JJdjh2WL98lA=
Received: from DM6PR02CA0126.namprd02.prod.outlook.com (2603:10b6:5:1b4::28)
 by SA1PR12MB999109.namprd12.prod.outlook.com (2603:10b6:806:4a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 18:34:12 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com (2603:10b6:5:1b4::4)
 by DM6PR02CA0126.outlook.office365.com (2603:10b6:5:1b4::28) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18
 via Frontend Transport; Thu, 2 Apr 2026 18:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:34:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:34:06 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:34:00 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 10/22] drm/amd/display: Avoid to do MCCS transaction if
 unnecessary
Date: Thu, 2 Apr 2026 14:33:02 -0400
Message-ID: <20260402183314.1388755-11-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SA1PR12MB999109:EE_
X-MS-Office365-Filtering-Correlation-Id: 8798b5b3-1aff-4e86-6ac5-08de90e66eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZsscX6ql//cy1/Z1omINkTscYTiU3qxHlO1GuSQvLOu1X7KHRUcqmBAIEB6+SHYaoq84Scrlaa864QPHIDQ9FOgQfi/0EeSrnXcOd6kk0f1s/8m0neRRU4D5VidpnqPbcsvwqOF1Aw8Z2kS6IbkpP+GJz/ANbBBxA6OxbWX6JH2c09DK7HJUtcS8fzkgFMTwV77EvXOxQFqsryFodn9G1qQC+823mWJImxtzH7sWNuk9aYv8rIYk/VvclGk/MNatrVpZWdUsnfKJyGtjfJNRmijrQjCZTmkZMVnUgodrl0MGla5JHlVMctVeWPHJv0p7yFo4ZhlcJHy+PLIkLuCVKb8F85auMXA7oxuDZ4raPabt221IuchAvP3Xk37OBhdLw2xgyt8VfDsZUiZ9NZaZKoaJPDsLqEyNHxCkE4q/ePqM3ZN75BP2qEJvZN5VggNEnAPIbT0Zsy5Cxi+2xZJhQSDiUdOgvxru5s0EiCxaqrgBiRjUrxKjyatdJJuBpVCtvGqa+oK3gA/CurL50V7+7UlY7E75uuF8i5/5Ykmq1WED/B0v0sbjDnHtBqF/0vr9ReHVguiGYETSNSNgnNEUVxwjqXg9zMuKP0p094cV50roBCkMPAMWfX/ZQCpTwa0kP9p9VC5iraITxSDpkNhpHaat6HyZPm1trFohOJS89A9qGUbDPUeyUKsNo3rBaAr4qOXOEFnwE4LtSKSqvNxxOclA3FUh+B8RPj5WOerbwrsIlZvtZ7Q5rX4V+IqH8WUMPpcJJ6hG2RmxtgM3vyIyFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jcM13jE2i/hI7chIyykgP1Bw4AR//eLlqFlmL+s6uKUcdrBzkJwmpq4CcEqk7ZvPj3oXRsRhNNUkU4ooK1BhLvid0YlXUpk4lq+tjtKP5t8nK+HaNufIHS5pZ2EF/CIGqpJJZIS+qvIJjyTNs5XSq8ed1UBP3EQXxThmdHG0vbpPmFcDKeqCQQnpk0diSFVMjpgN8zgpbQO0+kaAXqTLedjeCtvnsnfrF5yHvv9072uwIf4ilMqIDSZ1wABj8GJXvyxPSlH8q64kauFcst39TIekl31xTy2mOvlN3/IS53EjzMJ9Q5H0WQuOUN06Mz0JlcG1vpWBV7UEwnt2Ot+UuCEbEcEVXSX3iP5wkD/E+BskcEjnQN1m4PnthUT2jBwASlOdHnn2OQxXecxayTZEiVCCoX/r+8o5jVbhMchmYPJnkc1hSOpO3Wigk7akI01G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:34:10.6195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8798b5b3-1aff-4e86-6ac5-08de90e66eae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999109
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

We don't have to do MCCS/DDCCI transactions with sink side every time by calling
get_modes(). Limit it to be operated when hotplug occurs.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++--------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  2 +-
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 07612463455a..d8f04a2f2967 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3928,7 +3928,7 @@ void amdgpu_dm_update_connector_after_detect(
 
 		if (sink) {
 			if (aconnector->dc_sink) {
-				amdgpu_dm_update_freesync_caps(connector, NULL);
+				amdgpu_dm_update_freesync_caps(connector, NULL, true);
 				/*
 				 * retain and release below are used to
 				 * bump up refcount for sink because the link doesn't point
@@ -3940,9 +3940,9 @@ void amdgpu_dm_update_connector_after_detect(
 			aconnector->dc_sink = sink;
 			dc_sink_retain(aconnector->dc_sink);
 			amdgpu_dm_update_freesync_caps(connector,
-					aconnector->drm_edid);
+					aconnector->drm_edid, true);
 		} else {
-			amdgpu_dm_update_freesync_caps(connector, NULL);
+			amdgpu_dm_update_freesync_caps(connector, NULL, true);
 			if (!aconnector->dc_sink) {
 				aconnector->dc_sink = aconnector->dc_em_sink;
 				dc_sink_retain(aconnector->dc_sink);
@@ -3986,7 +3986,7 @@ void amdgpu_dm_update_connector_after_detect(
 		 * If yes, put it here.
 		 */
 		if (aconnector->dc_sink) {
-			amdgpu_dm_update_freesync_caps(connector, NULL);
+			amdgpu_dm_update_freesync_caps(connector, NULL, true);
 			dc_sink_release(aconnector->dc_sink);
 		}
 
@@ -4019,12 +4019,12 @@ void amdgpu_dm_update_connector_after_detect(
 					"failed to create aconnector->requested_timing\n");
 		}
 
-		amdgpu_dm_update_freesync_caps(connector, aconnector->drm_edid);
+		amdgpu_dm_update_freesync_caps(connector, aconnector->drm_edid, true);
 		update_connector_ext_caps(aconnector);
 	} else {
 		hdmi_cec_unset_edid(aconnector);
 		drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
-		amdgpu_dm_update_freesync_caps(connector, NULL);
+		amdgpu_dm_update_freesync_caps(connector, NULL, true);
 		aconnector->num_modes = 0;
 		dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
@@ -8786,7 +8786,7 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 		 * drm_edid_connector_add_modes() and need to be
 		 * restored here.
 		 */
-		amdgpu_dm_update_freesync_caps(connector, drm_edid);
+		amdgpu_dm_update_freesync_caps(connector, drm_edid, false);
 	} else {
 		amdgpu_dm_connector->num_modes = 0;
 	}
@@ -13266,7 +13266,7 @@ static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
  * FreeSync parameters.
  */
 void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
-				    const struct drm_edid *drm_edid)
+				    const struct drm_edid *drm_edid, bool do_mccs)
 {
 	int i = 0;
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
@@ -13373,13 +13373,16 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	}
 
 	/* Handle MCCS */
-	dm_helpers_read_mccs_caps(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
+	if (do_mccs)
+		dm_helpers_read_mccs_caps(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
+
 	if ((sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
 		as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) &&
 		(!sink->edid_caps.freesync_vcp_code ||
 		(sink->edid_caps.freesync_vcp_code && !sink->mccs_caps.freesync_supported)))
 		freesync_capable = false;
-	if (sink->mccs_caps.freesync_supported && freesync_capable)
+
+	if (do_mccs && sink->mccs_caps.freesync_supported && freesync_capable)
 		dm_helpers_mccs_vcp_set(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
 
 update:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 4a2c1bde28c9..4226a29a9e7c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1085,7 +1085,7 @@ void dm_restore_drm_connector_state(struct drm_device *dev,
 				    struct drm_connector *connector);
 
 void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
-				    const struct drm_edid *drm_edid);
+				    const struct drm_edid *drm_edid, bool do_mccs);
 
 void amdgpu_dm_trigger_timing_sync(struct drm_device *dev);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 2e0895f4f9b1..67e7e14d8976 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -474,7 +474,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 
 		if (aconnector->dc_sink) {
 			amdgpu_dm_update_freesync_caps(
-					connector, aconnector->drm_edid);
+					connector, aconnector->drm_edid, true);
 
 #if defined(CONFIG_DRM_AMD_DC_FP)
 			if (!validate_dsc_caps_on_connector(aconnector))
-- 
2.34.1

