Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D181FC3ABC9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 17:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7606510E1AD;
	Wed,  7 May 2025 17:25:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sa2c8gWS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83DE310E1AD
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 17:25:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpZALr641lCiu3wrLxClZL+uta/piStH5W09YliZdP5h/zaPdVgOYxcU7jewr1wUVRH22lSHscdOmGAGCf6v1fq+kOeceYb7HhDCp+nE8pFuRkACyrAB/Xp0WfdoFL1Yhqr5pzG+CAuYDqzw58NcOwN5Z0z14LMP+5n2ARDsitz6/4hSc1cJp7AQ+audTRXh/6Ly4Vjc8LQAdool41rQVWnfxnO3uvhFokFi6sbDS7lQCxnQu7f8HSnPa/6mj8CCRtMp7AMkgke26yJGLFFBUhKiERsnyL/rJELffN4CP9X1NrummkFQHOoMQPU7mZ/FR6zjTBqUz8ZLzwOUEYkbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7zKAshCz9sBZVQckTKLO5kzwjpiOtq+4PxHqKFa7o4=;
 b=rpLfk5FhmVWDtPyTL6d8mXFX+6Te4XqpMZIdNtsmAmv5zxVgmi9R9UvlbepwiPiUvYcuLk4JqrDihoieu8eVpXGQzA7qjkDuq/TO3VN4c+R6N2Zsyev+sw7GLXXbvyS43LFo1ogDQQkgo+dcASll1ajCff0Bdbfp+QpNuNrAk46CLW6TDkAk5coPJZaxT3ZiCnra61rjhq+a4dImHBou4jibSISwlH8MZciZAr+4paeIHEU+iXLyKPxiFe+tV0V+d2m9jh9pRFFrzxdfRFnAIgCOYZrURoRTY+Eg6obGR7K+yEV2z99eLHODSjlnd3WAu1R1GCCmgSMQiuWSBKMAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7zKAshCz9sBZVQckTKLO5kzwjpiOtq+4PxHqKFa7o4=;
 b=sa2c8gWSlLS8BJ+tLrxwdtsDx5k1ODGRCYfvN4D3SGF66FOFmTdzsEmXAMxIl4RAlFDDFqhLL7zcuI/xrbSYkaceFkp397DcHF2qhMfVstFL+Z4YJK+6Plfb9o9+ybnQpGA91Jfkc7g8f32DqDU4kzeHcj9aW6b5pKcOeXu6aa4=
Received: from SA1P222CA0063.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::12)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 17:25:26 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::f) by SA1P222CA0063.outlook.office365.com
 (2603:10b6:806:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.34 via Frontend Transport; Wed,
 7 May 2025 17:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 17:25:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 12:25:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 12:25:25 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 7 May 2025 12:25:25 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Alex.Hung@amd.com>, <sunpeng.li@amd.com>,
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: use drm_dbg_driver() in amdgpu_dm.c
Date: Wed, 7 May 2025 13:25:19 -0400
Message-ID: <20250507172519.7632-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 02540312-8dc7-4155-fc96-08dd8d8c27f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?br2e2gkRhUlLd1FoEUlBILoB2MXa5rxDKADjJE/cMiSMwkJWqIEwjt+DgFt6?=
 =?us-ascii?Q?Ad8q5Wl/+UacPPZQB5u7wvZLsTQosdusgFN9pk03DCQyQUvmQBTWgoyTZ7j0?=
 =?us-ascii?Q?0aL11ptT1S3bdGo3mtEpDnqIcQZv/7pnsiuItHVCSioY95R39jc2PbD6EtSZ?=
 =?us-ascii?Q?+EB+HXYp2l8msyUU1RQu34vrgR+syUkz2w+eNGG2oFOjVvuBiFP7W4qsTzTr?=
 =?us-ascii?Q?u6Q4MUhzIxpUWFsYcLjybMr+iL0lYPYbquTUg1l5kIPAGRhV45cOzFcrQPay?=
 =?us-ascii?Q?GjMiyDFOsYHdOkTB9GkORk5trmrhbfkrFnF3E2etjLu2n1yifS0bnhZM2bsB?=
 =?us-ascii?Q?y4EmFG0f37kug56rknhodTdrgCNvjGH1uYiMGjuaFSa4a5/w5TSacYwllpS0?=
 =?us-ascii?Q?41piVvkJzvc8RK+A6L8aIIXu/VlUqBTHiUHJm+XL0T8tJNlvMASRIQr0BaJy?=
 =?us-ascii?Q?GBxAy4S+FqzeTGOVtRUmDZszT0++6zHm+PKSCavZdi/lYHDAJVqZbPpC5cVg?=
 =?us-ascii?Q?odJ53Ei5DMfYc4k+F6iEaSzSVwHDFs89TU6KmwPEskxytD9BZpuVuVrBbZgh?=
 =?us-ascii?Q?F9krqYEwcrTATclhcF7x/9kDdVMY6WM6Irm7FGEMMDZPoSuGGgCiJlwRJQlw?=
 =?us-ascii?Q?IJmZfPWNlVb9FGam93EyTo1n5uLzp+ZvaKlixL/jbNoGU0MTTWSpKSSV6NLk?=
 =?us-ascii?Q?N3tamJ+hDZHfruneEfgnQYP+EG14H62yet6OgpdmB2lxLPR0JotfwlQTX3LK?=
 =?us-ascii?Q?d/qinQvd4GGwzn1kTfWnJDw5MZjbYFcWHBW1bsEy1NnsmSL7yqnlKKc+GXxv?=
 =?us-ascii?Q?YItJrwvzLq5RIW3sf/NjEpnlVPdpbNf8z0tYZhuraKGp8JRFgjw6YIOZyWUG?=
 =?us-ascii?Q?tLdHbWc9yu++PNKlHl8LCoDhA3PNGVELu6PJcSbBDpWbmiJ+MPnCsXjCgfi3?=
 =?us-ascii?Q?J06760Tsm+70KYJHzeeYKVtbIl0UCq4ODrX91JlQECHyAgUHNX0rNIvgRuyt?=
 =?us-ascii?Q?/GfmlodmsWwEXhPY2k0sEHBNxn3bj4/Qv/kQkKraTy04bXo3/8zFwrZk9LcB?=
 =?us-ascii?Q?CYvViU6LNcv9koI4fY0r6DIjiDfReea+iVFE3x3Vc6ro5KgJDV5JmpcVy+zy?=
 =?us-ascii?Q?nCY1K3C/9MJOwhCszO1BwxSKUw2Xp9ABcjPNLMC7iuYXc1sKtkqO9se1e2Gh?=
 =?us-ascii?Q?pWhGEQqWwHkUL3CoNDB4bTu7SsWdDdFT68Yql3vj+AGlal+O/MDnu0gyIdfT?=
 =?us-ascii?Q?yDeWC8zEE9k8JXAoEfGBvFelJlJWWFEI6abjzZyJlgUosZTOF7Xk09QHFONa?=
 =?us-ascii?Q?22Mh+LyBfkGbzc+OoHos/p7eoJtbKNF1kPcGr4SJvUsIle1mcnFYMPYk5iCK?=
 =?us-ascii?Q?gQGgdo+fF/6P0bpC0kC6/oAOjMQLnzpWOB1wNwgdNO0F6dWt2TCOyEY+BSb9?=
 =?us-ascii?Q?Sa6LaRKwKHSs2l7DJbincY9cKh9ObMwpW439NwwMHgP2Bl+ZbByrN3AXiMsy?=
 =?us-ascii?Q?7S9drG3qUFtieIdBQS+862IjvYHdYmZXhyR1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 17:25:26.1019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02540312-8dc7-4155-fc96-08dd8d8c27f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
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

Replace all use of DRM_DEBUG_DRIVER in amdgpu_dm.c with
drm_dbg_driver(). The latter prints the instance of the drm device
associated with the error which would helpful in debugging scenarios
involving multiple GPUs

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 35 ++++++++++---------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8984e211dd1c..46fc4c94a879 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -866,7 +866,7 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 static void dmub_hpd_sense_callback(struct amdgpu_device *adev,
 			      struct dmub_notification *notify)
 {
-	DRM_DEBUG_DRIVER("DMUB HPD SENSE callback.\n");
+	drm_dbg_driver(adev_to_drm(adev), "DMUB HPD SENSE callback.\n");
 }
 
 /**
@@ -963,7 +963,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 			trace_amdgpu_dmub_trace_high_irq(entry.trace_code, entry.tick_count,
 							entry.param0, entry.param1);
 
-			DRM_DEBUG_DRIVER("trace_code:%u, tick_count:%u, param0:%u, param1:%u\n",
+			drm_dbg_driver(adev_to_drm(adev), "trace_code:%u, tick_count:%u, param0:%u, param1:%u\n",
 				 entry.trace_code, entry.tick_count, entry.param0, entry.param1);
 		} else
 			break;
@@ -973,7 +973,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 	} while (count <= DMUB_TRACE_MAX_READ);
 
 	if (count > DMUB_TRACE_MAX_READ)
-		DRM_DEBUG_DRIVER("Warning : count > DMUB_TRACE_MAX_READ");
+		drm_dbg_driver(adev_to_drm(adev), "Warning : count > DMUB_TRACE_MAX_READ");
 
 	if (dc_enable_dmub_notifications(adev->dm.dc) &&
 		irq_params->irq_src == DC_IRQ_SOURCE_DMCUB_OUTBOX) {
@@ -2200,7 +2200,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		drm_err(adev_to_drm(adev),
 		"amdgpu: failed to initialize freesync_module.\n");
 	} else
-		DRM_DEBUG_DRIVER("amdgpu: freesync_module init done %p.\n",
+		drm_dbg_driver(adev_to_drm(adev), "amdgpu: freesync_module init done %p.\n",
 				adev->dm.freesync_module);
 
 	amdgpu_dm_init_color_mod();
@@ -2222,7 +2222,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		if (!adev->dm.hdcp_workqueue)
 			drm_err(adev_to_drm(adev), "amdgpu: failed to initialize hdcp_workqueue.\n");
 		else
-			DRM_DEBUG_DRIVER("amdgpu: hdcp_workqueue init done %p.\n", adev->dm.hdcp_workqueue);
+			drm_dbg_driver(adev_to_drm(adev), "amdgpu: hdcp_workqueue init done %p.\n", adev->dm.hdcp_workqueue);
 
 		dc_init_callbacks(adev->dm.dc, &init_params);
 	}
@@ -2299,7 +2299,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 #endif
 
-	DRM_DEBUG_DRIVER("KMS initialized.\n");
+	drm_dbg_driver(adev_to_drm(adev), "KMS initialized.\n");
 
 	return 0;
 error:
@@ -5097,7 +5097,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		drm_err(drm, "DM: Backlight registration failed!\n");
 		dm->backlight_dev[aconnector->bl_idx] = NULL;
 	} else
-		DRM_DEBUG_DRIVER("DM: Registered Backlight device: %s\n", bl_name);
+		drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
 }
 
 static int initialize_plane(struct amdgpu_display_manager *dm,
@@ -6749,7 +6749,7 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 		m_pref = list_first_entry_or_null(
 				&aconnector->base.modes, struct drm_display_mode, head);
 		if (!m_pref) {
-			DRM_DEBUG_DRIVER("No preferred mode found in EDID\n");
+			drm_dbg_driver(aconnector->base.dev, "No preferred mode found in EDID\n");
 			return NULL;
 		}
 	}
@@ -6924,7 +6924,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 						dc_link_get_highest_encoding_format(aconnector->dc_link),
 						&stream->timing.dsc_cfg)) {
 				stream->timing.flags.DSC = 1;
-				DRM_DEBUG_DRIVER("%s: SST_DSC [%s] DSC is selected from SST RX\n",
+				drm_dbg_driver(drm_connector->dev, "%s: SST_DSC [%s] DSC is selected from SST RX\n",
 							__func__, drm_connector->name);
 			}
 		} else if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
@@ -6944,7 +6944,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 						dc_link_get_highest_encoding_format(aconnector->dc_link),
 						&stream->timing.dsc_cfg)) {
 					stream->timing.flags.DSC = 1;
-					DRM_DEBUG_DRIVER("%s: SST_DSC [%s] DSC is selected from DP-HDMI PCON\n",
+					drm_dbg_driver(drm_connector->dev, "%s: SST_DSC [%s] DSC is selected from DP-HDMI PCON\n",
 									 __func__, drm_connector->name);
 				}
 		}
@@ -7053,7 +7053,7 @@ create_stream_for_sink(struct drm_connector *connector,
 		 * case, we call set mode ourselves to restore the previous mode
 		 * and the modelist may not be filled in time.
 		 */
-		DRM_DEBUG_DRIVER("No preferred mode found\n");
+		drm_dbg_driver(dev, "No preferred mode found\n");
 	} else if (aconnector) {
 		recalculate_timing = amdgpu_freesync_vid_mode &&
 				 is_freesync_video_mode(&mode, aconnector);
@@ -9201,7 +9201,7 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
 		 */
 		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) != 0);
 		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) != 0);
-		DRM_DEBUG_DRIVER("%s: crtc=%u VRR off->on: Get vblank ref\n",
+		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR off->on: Get vblank ref\n",
 				 __func__, new_state->base.crtc->base.id);
 	} else if (old_vrr_active && !new_vrr_active) {
 		/* Transition VRR active -> inactive:
@@ -9209,7 +9209,7 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
 		 */
 		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) != 0);
 		drm_crtc_vblank_put(new_state->base.crtc);
-		DRM_DEBUG_DRIVER("%s: crtc=%u VRR on->off: Drop vblank ref\n",
+		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR on->off: Drop vblank ref\n",
 				 __func__, new_state->base.crtc->base.id);
 	}
 }
@@ -10836,6 +10836,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	struct dm_atomic_state *dm_state = NULL;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
 	struct dc_stream_state *new_stream;
+	struct amdgpu_device *adev = dm->adev;
 	int ret = 0;
 
 	/*
@@ -10889,7 +10890,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		 */
 
 		if (!new_stream) {
-			DRM_DEBUG_DRIVER("%s: Failed to create new stream for crtc %d\n",
+			drm_dbg_driver(adev_to_drm(adev), "%s: Failed to create new stream for crtc %d\n",
 					__func__, acrtc->base.base.id);
 			ret = -ENOMEM;
 			goto fail;
@@ -10927,7 +10928,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
 		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream)) {
 			new_crtc_state->mode_changed = false;
-			DRM_DEBUG_DRIVER("Mode change not required, setting mode_changed to %d",
+			drm_dbg_driver(adev_to_drm(adev), "Mode change not required, setting mode_changed to %d",
 					 new_crtc_state->mode_changed);
 		}
 	}
@@ -10965,7 +10966,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		    is_timing_unchanged_for_freesync(new_crtc_state,
 						     old_crtc_state)) {
 			new_crtc_state->mode_changed = false;
-			DRM_DEBUG_DRIVER(
+			drm_dbg_driver(adev_to_drm(adev),
 				"Mode change not required for front porch change, setting mode_changed to %d",
 				new_crtc_state->mode_changed);
 
@@ -10986,7 +10987,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		if (ret)
 			goto fail;
 
-		DRM_DEBUG_DRIVER("Disabling DRM crtc: %d\n",
+		drm_dbg_driver(adev_to_drm(adev), "Disabling DRM crtc: %d\n",
 				crtc->base.id);
 
 		/* i.e. reset mode */
-- 
2.49.0

