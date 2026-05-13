Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF21CD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 16:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3016010E32E;
	Wed, 13 May 2026 16:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zx8Yov9t";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011066.outbound.protection.outlook.com
 [40.93.194.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA9510E32E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 16:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itUxSJp/MN7vkIeAOYavudq0H3PZbhDhdAJSrUveF4bAhP5s++LeNjQBG67JOgIdMyo5xKJ8kGdO3VQG61YfLvJ9V6XaC5ohoCHTc40cX0SxG1JwhaERjCtu6BOU9kZd+xqx3G1ChCBL2iTXKQrycxz2K/rrFLzRwoyi5veDlriESIHb7hlPl4fhctm1Paz80s7M9lMeklR1fOZnxh9KzHRP5UCRzz05nP+T5fmWanxrAeENyFqF+ndGwp03CqvmJB8xXZzzDNyvJ8dpdURH9FtAlJWvnyB5KHNx29d/yPpTQ1CfCM/gQ2fvep0GST8rrjwm4F3JjzDYyaDgw1/Mhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M08FLuf77b8Z4YVIfw31400wc4avdmNTAQoU75wCzMg=;
 b=gCP/YcIvI1U5zR2a+cO8m3l8h6KLRsfUHjxJfo9333Zqq3iQ9r2mQHRwVUChOqQU8zZplHzXcKnUhfmnjB1IDo2YF6xEFqHJ2y8vG5RYhX4QMAsNuoetM/7RvEaveZg2JXSM4yGrg7OT0vYkNppg2MzlDgB+vxl+Uu8rVVmkcG7gRU/Td3FcLXVI+tt88FsDNY9OLkSuvwobifR+lQIJaPo9kA4aKXsPnBoLzcfl6xxJ6H0IYubKoVCNwvk6fAFr4ampRhzrxR7csmZrAT0wrF/YMtbFCM7P+KvEAqd7qdqHy5x87ntCG2lnH00tBfhHXQry7M7vjgwqsDXpzzw7+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M08FLuf77b8Z4YVIfw31400wc4avdmNTAQoU75wCzMg=;
 b=zx8Yov9t769V8cfuZEGCWgV0xqvjmTU7GJc5ZQGfg1NJt4rl8ciOSXzLgCzbvIU6U4zDkgu8xcxrnzspWxvlhcuJQCM9sbkA+5ObG96YnDszb43msa+AqRvwd6xYWhHTp0QqKJnECi9h8fAkkmExV3HtHkkobFyv+K82yJeklmo=
Received: from SN1PR12CA0049.namprd12.prod.outlook.com (2603:10b6:802:20::20)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 16:07:21 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::76) by SN1PR12CA0049.outlook.office365.com
 (2603:10b6:802:20::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 16:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 16:07:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 13 May
 2026 11:07:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 May
 2026 11:07:19 -0500
Received: from ct-ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 11:07:19 -0500
From: chentien_amdeng <chentien@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <chenli.tien@amd.com>, chentien_amdeng <chentien@amd.com>
Subject: [PATCH] drn/amd/display/amdgpu_dm: fix the issuess found on
 SteacmDeck with USB hub with VRR capability during suspend / resume event.
Date: Wed, 13 May 2026 12:07:18 -0400
Message-ID: <20260513160719.2056179-1-chentien@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chentien@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 857d901c-1023-4d80-9ae9-08deb109b666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|11063799003|3023799003|56012099003;
X-Microsoft-Antispam-Message-Info: 7OMg3Ur9xMHkVLQBoAk8SWC97Bvyqn5GXuMjIIQkQETjkn1CZ3yI3RFyu0L03xPF3l62yGG0zC/eRsS8ZCbb0rPnsi4sm4XbDyBoHaNVmXdmTjzBIZasw6RWwRtrgR+xP8Krj0LvnYKmaKk+KHFb+lEwHrvc/8hqpKQgvfc03BOqhph2wmI0jRPFfza8/kJa8zjoMW9WMVe77sZ2BXC1SJrs+z2NPkI3a0SDhtVYiOzeOK1T5Ym0mBJHEgV+m2eHh27nVUo96bo5y2sqgLiBH/B+wuyIWdMep86NYBRxsaKc9M/QUTzRNFmpDlKv6uW0jVtxDmBbQtwybkAQz0KwyYyg6sfSIzs0NNtZUSsNSTKHMzHriaUciUDEFnvFROdq7AW1WFi8bZUHKSkeB0hQ5fg9SUkgKzwWBu7CR665ErcbG8tAvd9CmJNNq9JgaSsQ/oXhXnuf0TEzJgGp30xaTBVwR3Bz9BwzEJMtYxm1fXHgzkSy2mEO2R8DM6hs+LNe81LlqfqTJb/Fn8pOP2qYs6/wvSf1oqI8aDNKCCDP3aFGwMSxd/LfHXbrTH/PjZiIofeKm5Dqmssml2mIgx3CT3Sco59B+N1Mp85lemjbxCdVyO1mmXH8NdV7mI8zc5P0AylQ32luZ10NDFYajmhEjTmjrT4tdPWMwYwIJhUORG98t0zd0kFoFEITY67VTF6vu5JDa9ALqkq/navoJrXY5Ke4If01J2eTh0uLsQ65B18=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(11063799003)(3023799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +WbKUmSTv/oLyIwyBb4Ps6p08z1IC1WlPDR7BnL2143HvLiUDgtmKaWSQIfX06sNpx2PnbzYTNrAmWKI7l9ywdnaAtwobiwFlqxIw+QUYM407tFHYEvHQW3CnW+MyEqggdts49MQJZ0tm3Ug31lUYgG+G7rV6wEeSTsNjGRXLKSpYixg83RuEorDkbSKveSUodXVMLltRV4EDoPciP4Icr6iEZOkOXtsO33h7NFh+poHxalgRnhED8uJNLU22z6hdEytWmiMCJZahR/OIw7OJJOzoZKHFsxd8LjKL2fo5IAUM28nY9yzfBaCwIKpM/HBEHA4HSr5vrFAwvunL6SzbZwDf/GXy9J4tPVqGQRoKi2pTc+vxzMfYmYEJN5Cfa3d4k/RSlbdD5c1Lw5Y3PXDf+l8S9Q9TkLIiVYUPNhQiB/dBqQF6j5+xGSHqOPUXhqD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 16:07:20.5813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 857d901c-1023-4d80-9ae9-08deb109b666
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442
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

- Monitor connected with self-powered hub cannot get connected after resume
- VRR monitor connected with DP cannot display correcctly after resume
- VRR monitor connected with HDMI diplay with vertical shift
- In desktop(X11) mode, external monitors get lost after resume

Signed-off-by: chentien_amdeng <chentien@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 733 ++++++++++++++++++
 1 file changed, 733 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3fa4dbda4517..474d8e55d222 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -158,6 +158,533 @@ MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
 #define FIRMWARE_DCN_42_DMUB "amdgpu/dcn_4_2_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
 
+#define VRR_USBHUB	/* define this to fix bugs related to USBHUB VRR support */
+#ifdef VRR_USBHUB
+static bool dc_postresume_hard_modeset = true;
+module_param_named(dc_postresume_hard_modeset, dc_postresume_hard_modeset, bool, 0644);
+MODULE_PARM_DESC(dc_postresume_hard_modeset, "Perform hard modeset on resume from suspend (default: true)");
+static atomic_t dm_postresume_force_modeset = ATOMIC_INIT(0);
+
+/* Delay before restoring VRR after resume on PCON-in-TMDS */
+static int dc_vrr_restore_ms = 2500;
+module_param_named(dc_vrr_restore_ms, dc_vrr_restore_ms, int, 0644);
+MODULE_PARM_DESC(dc_vrr_restore_ms,
+	"Delay (ms) before restoring VRR after resume on PCON-TMDS (default: 1500)");
+
+/* Gate VRR works during suspend/shutdown to avoid late commits on reboot */
+static atomic_t dc_vrr_work_ok = ATOMIC_INIT(1);
+
+/* =====================
+ *  Resume policy knobs
+ * =====================
+ */
+
+/* 1) Mask VRR briefly after resume on DP->HDMI PCON in TMDS (no FRL). */
+static bool dc_vrr_pcon_resume_mask = true;
+module_param_named(dc_vrr_pcon_resume_mask, dc_vrr_pcon_resume_mask, bool, 0644);
+MODULE_PARM_DESC(dc_vrr_pcon_resume_mask,
+	"Mask VRR after resume when DP->HDMI PCON reports TMDS (default: N)");
+
+/* Only re-enable VRR if the adapter is NOT PCON-in-TMDS at restore time */
+static bool dc_vrr_restore_only_when_pcon_not_tmds = true;
+module_param_named(dc_vrr_restore_only_when_pcon_not_tmds,
+					dc_vrr_restore_only_when_pcon_not_tmds, bool, 0644);
+MODULE_PARM_DESC(dc_vrr_restore_only_when_pcon_not_tmds,
+	"If Y, skip VRR restore when PCON reports TMDS; default Y");
+
+/* (Optional) Native-DP retrain post-resume: leave disabled by default */
+static bool dc_retrain_dp_on_resume = true;
+module_param_named(dc_retrain_dp_on_resume, dc_retrain_dp_on_resume, bool, 0644);
+MODULE_PARM_DESC(dc_retrain_dp_on_resume,
+	"Native DP retrain after resume (deferred); default N");
+
+/* Try to wake a sink that reports SINK_COUNT==0 by writing D0 to DPCD 0x600 */
+static bool dc_dp_wake_sink = true;
+module_param_named(dc_dp_wake_sink, dc_dp_wake_sink, bool, 0644);
+MODULE_PARM_DESC(dc_dp_wake_sink,
+	"If Y, write DP_SET_POWER=0x01 (D0) to DPCD 0x600 when SINK_COUNT==0; default Y");
+
+/* Readiness-gated requeue policy for deferred retrain */
+static int dc_dp_retrain_retry_ms = 400;
+module_param_named(dc_dp_retrain_retry_ms, dc_dp_retrain_retry_ms, int, 0644);
+MODULE_PARM_DESC(dc_dp_retrain_retry_ms,
+	"Delay (ms) before re-trying native-DP retrain readiness probe (default: 400)");
+
+static int dc_dp_retrain_max_retries = 10;
+module_param_named(dc_dp_retrain_max_retries, dc_dp_retrain_max_retries, int, 0644);
+MODULE_PARM_DESC(dc_dp_retrain_max_retries,
+	"Maximum readiness re-tries before giving up (default: 10)");
+
+/* When a DP connector is ready but inactive, nudge userspace repeatedly (bounded) */
+static int dc_dp_hotplug_retry_ms = 800;
+module_param_named(dc_dp_hotplug_retry_ms, dc_dp_hotplug_retry_ms, int, 0644);
+MODULE_PARM_DESC(dc_dp_hotplug_retry_ms,
+	"Delay (ms) between hotplug nudges for ready-but-inactive DP (default: 800)");
+
+static int dc_dp_hotplug_max_retries = 5;
+module_param_named(dc_dp_hotplug_max_retries, dc_dp_hotplug_max_retries, int, 0644);
+MODULE_PARM_DESC(dc_dp_hotplug_max_retries,
+	"Maximum hotplug nudges after the first one for inactive DP (default: 5)");
+
+/* Defer time for retrain worker (ms) to avoid racing the main resume commit */
+static int dc_dp_retrain_defer_ms = 700;
+module_param_named(dc_dp_retrain_defer_ms, dc_dp_retrain_defer_ms, int, 0644);
+MODULE_PARM_DESC(dc_dp_retrain_defer_ms,
+	"Delay (ms) before running native-DP retrain after resume (default: 500)");
+
+/* DPCD register holding PCON HDMI link status */
+#ifndef DPCD_PCON_HDMI_LINK_CONFIG_STATUS
+#define DPCD_PCON_HDMI_LINK_CONFIG_STATUS 0x03036
+#endif
+
+/* EXPERIMENTAL: pre-clear VRR inside cached atomic state before resume */
+static bool dc_vrr_preclear_in_cached_state = true;
+module_param_named(dc_vrr_preclear_in_cached_state, dc_vrr_preclear_in_cached_state, bool, 0644);
+MODULE_PARM_DESC(dc_vrr_preclear_in_cached_state,
+	"If Y, clear VRR in dm->cached_state for PCON-in-TMDS before drm_atomic_helper_resume(); default N");
+
+/*
+ * Late DP re-detect delay (ms) after HPD-high:
+ * Many docks/bridges aren't AUX/EDID-ready immediately after PSU returns.
+ * A second detect + hotplug after a short delay avoids early AUX/EDID flaps.
+ */
+static int dc_dp_late_hpd_delay_ms = 300;
+module_param_named(dc_dp_late_hpd_delay_ms, dc_dp_late_hpd_delay_ms, int, 0644);
+MODULE_PARM_DESC(dc_dp_late_hpd_delay_ms,
+	"Delay before late DP re-detect/hotplug on HPD-high (ms)");
+
+/* Global (per-file) late reprobe; coalesces HPD-high events. */
+static struct delayed_work dm_late_dp_reprobe_work;
+static struct drm_device *dm_late_reprobe_ddev;
+static bool dm_late_reprobe_initialized;
+
+static void dm_late_dp_reprobe_fn(struct work_struct *work)
+{
+	struct drm_device *ddev = dm_late_reprobe_ddev;
+	struct amdgpu_device *adev;
+	struct drm_connector_list_iter iter;
+	struct drm_connector *connector;
+	int ret;
+
+	if (!ddev)
+		return;
+	adev = drm_to_adev(ddev);
+
+	drm_connector_list_iter_begin(ddev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
+		struct amdgpu_dm_connector *aconn;
+
+		if (connector->connector_type != DRM_MODE_CONNECTOR_DisplayPort)
+			continue;
+		aconn = to_amdgpu_dm_connector(connector);
+		if (!aconn || aconn->mst_root)
+			continue; /* SST only; MST has its own flow */
+
+		/* Try a real detect; if present, refresh connector and nudge userspace */
+		mutex_lock(&aconn->hpd_lock);
+		mutex_lock(&adev->dm.dc_lock);
+		ret = dc_link_detect(aconn->dc_link, DETECT_REASON_HPD);
+		mutex_unlock(&adev->dm.dc_lock);
+
+		if (ret) {
+			amdgpu_dm_update_connector_after_detect(aconn);
+			if (connector->status == connector_status_connected) {
+				drm_modeset_lock_all(ddev);
+				dm_restore_drm_connector_state(ddev, connector);
+				drm_modeset_unlock_all(ddev);
+				drm_kms_helper_connector_hotplug_event(connector);
+				drm_dbg_kms(ddev, "dm: late DP reprobe: hotplugged %s\n",
+					connector->name);
+			} else {
+				drm_dbg_kms(ddev, "dm: late DP reprobe: %s still disconnected\n",
+					connector->name);
+			}
+		} else {
+			drm_dbg_kms(ddev, "dm: late DP reprobe: dc_link_detect failed for %s\n",
+				connector->name);
+		}
+		mutex_unlock(&aconn->hpd_lock);
+	}
+	drm_connector_list_iter_end(&iter);
+}
+
+static void dm_schedule_late_dp_reprobe(struct drm_connector *connector)
+{
+	/* Coalesce multiple HPD-high edges into a single delayed run. */
+	mod_delayed_work(system_wq, &dm_late_dp_reprobe_work,
+			msecs_to_jiffies(dc_dp_late_hpd_delay_ms));
+	drm_dbg_kms(connector->dev,
+			"dm: scheduled late DP reprobe for %s in %d ms\n",
+			connector->name, dc_dp_late_hpd_delay_ms);
+}
+
+struct pcon_vrr_restore_ctx {
+	struct drm_crtc *crtc;
+	bool want_vrr;
+	struct delayed_work work;
+};
+
+struct pcon_vrr_mask_ctx {
+	struct drm_crtc *crtc;
+	struct delayed_work work;
+};
+
+/* Deferred native-DP retrain after resume */
+struct dp_retrain_work {
+	struct amdgpu_device *adev;
+	int tries;
+	struct delayed_work work;
+};
+static void dp_retrain_worker(struct work_struct *w);
+
+/* Small helper: quick DPCD read via DC (returns true on DC_OK) */
+static bool dm_read_dpcd(struct dc_link *link, uint32_t addr, uint8_t *buf, uint32_t bytes)
+{
+	return link && core_link_read_dpcd(link, addr, buf, bytes) == DC_OK;
+}
+
+/* Small helper: quick DPCD write via DC (returns true on DC_OK) */
+static bool dm_write_dpcd(struct dc_link *link, uint32_t addr, const uint8_t *buf, uint32_t bytes)
+{
+	return link && core_link_write_dpcd(link, addr, buf, bytes) == DC_OK;
+}
+
+static bool dm_set_power_d0(struct dc_link *link)
+{
+	uint8_t d0 = 0x01; /* D0 */
+
+	if (!dc_dp_wake_sink)
+		return false;
+	return dm_write_dpcd(link, 0x00600, &d0, 1);
+}
+
+/* DPCD register holding PCON HDMI link status */
+#ifndef DPCD_PCON_HDMI_LINK_CONFIG_STATUS
+#define DPCD_PCON_HDMI_LINK_CONFIG_STATUS 0x03036
+#endif
+
+/* Returns true when link is DP->HDMI PCON and PCON reports TMDS (no FRL) */
+static bool dm_link_is_pcon_tmds(struct dc_link *link, u8 *status_out)
+{
+	u8 val = 0;
+	enum dc_status st;
+
+	if (!link)
+		return false;
+	if (link->dpcd_caps.dongle_type != DISPLAY_DONGLE_DP_HDMI_CONVERTER)
+		return false;
+	st = core_link_read_dpcd(link, DPCD_PCON_HDMI_LINK_CONFIG_STATUS, &val, 1);
+	if (status_out)
+		*status_out = val;
+	return st == DC_OK && val == 0x00;
+}
+
+/* Toggle VRR via an internal atomic commit (CRTC vrr_enabled flag). */
+static int dm_atomic_set_crtc_vrr_ex(struct drm_crtc *crtc, bool enable, bool allow_modeset)
+{
+	struct drm_device *dev = crtc->dev;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_state *state;
+	struct drm_crtc_state *crtc_state;
+	int ret = 0;
+
+	drm_modeset_acquire_init(&ctx, 0);
+retry:
+	state = drm_atomic_state_alloc(dev);
+	if (!state) {
+		ret = -ENOMEM;
+		goto out_fini;
+	}
+	state->acquire_ctx = &ctx;
+
+	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (IS_ERR(crtc_state)) {
+		ret = PTR_ERR(crtc_state);
+		goto out_put;
+	}
+	crtc_state->vrr_enabled = enable;
+	if (allow_modeset)
+		state->allow_modeset = true; /* 6.11.11: per-commit allow_modeset */
+	ret = drm_atomic_commit(state);
+	if (ret == -EDEADLK) {
+		drm_atomic_state_put(state);
+		drm_modeset_backoff(&ctx);
+		goto retry;
+	}
+out_put:
+	drm_atomic_state_put(state);
+	return ret;
+out_fini:
+	drm_modeset_acquire_fini(&ctx);
+	return ret;
+}
+
+static inline int dm_atomic_set_crtc_vrr(struct drm_crtc *crtc, bool enable)
+{
+	return dm_atomic_set_crtc_vrr_ex(crtc, enable, true);
+}
+
+/* Delayed restore worker: re-enable VRR if safe to do so */
+static void pcon_vrr_restore_work(struct work_struct *work)
+{
+	struct pcon_vrr_restore_ctx *ctx =
+		container_of(to_delayed_work(work), struct pcon_vrr_restore_ctx, work);
+	int ret = 0;
+
+	if (!atomic_read(&dc_vrr_work_ok)) {
+		kfree(ctx);
+		return;
+	}
+	if (!ctx->crtc || !ctx->want_vrr) {
+		kfree(ctx);
+		return;
+	}
+
+	/* Skip restoring VRR if the bound connector is a PCON still in TMDS. */
+	if (dc_vrr_restore_only_when_pcon_not_tmds) {
+		struct drm_device *ddev = ctx->crtc->dev;
+		struct drm_connector *conn;
+		struct drm_connector_list_iter iter;
+		bool pcon_tmds = false;
+
+		drm_connector_list_iter_begin(ddev, &iter);
+		drm_for_each_connector_iter(conn, &iter) {
+			struct amdgpu_dm_connector *aconn;
+			u8 st = 0;
+
+			if (!conn->state || conn->state->crtc != ctx->crtc)
+				continue;
+			if (conn->connector_type != DRM_MODE_CONNECTOR_DisplayPort)
+				continue;
+			aconn = to_amdgpu_dm_connector(conn);
+			if (!aconn || !aconn->dc_link)
+				continue;
+			if (dm_link_is_pcon_tmds(aconn->dc_link, &st)) {
+				pcon_tmds = true;
+				break;
+			}
+		}
+		drm_connector_list_iter_end(&iter);
+
+		if (pcon_tmds) {
+			DRM_INFO(
+				"amdgpu_dm: VRR restore skipped (PCON still TMDS); staying fixed timing\n");
+			kfree(ctx);
+			return;
+		}
+	}
+
+	/* Prefer no-modeset; if it fails, retry once with modeset */
+	ret = dm_atomic_set_crtc_vrr_ex(ctx->crtc, true, false);
+	if (ret) {
+		msleep(60);
+		(void)dm_atomic_set_crtc_vrr_ex(ctx->crtc, true, true);
+	}
+	kfree(ctx);
+}
+
+static void late_dp_redetect_and_hotplug(struct drm_device *ddev)
+{
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
+
+	drm_connector_list_iter_begin(ddev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
+		struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(connector);
+		int ret;
+
+		if (connector->connector_type != DRM_MODE_CONNECTOR_DisplayPort ||
+			aconn->mst_root)
+			continue;
+
+		/* Optional: skip if we didn't see resume-time AUX/EDID issues */
+		// if (!aconn->resume_needs_redetect) continue;
+
+		/* Optional: short settle delay on the failure path */
+		// msleep(100);
+
+		mutex_lock(&aconn->hpd_lock);
+		mutex_lock(&adev->dm.dc_lock);
+		ret = dc_link_detect(aconn->dc_link, DETECT_REASON_HPD);
+		mutex_unlock(&adev->dm.dc_lock);
+
+		if (!ret) {
+			mutex_unlock(&aconn->hpd_lock);
+			continue;
+		}
+
+		amdgpu_dm_update_connector_after_detect(aconn);
+
+		/* If still disconnected, nothing to notify */
+		if (connector->status != connector_status_connected) {
+			mutex_unlock(&aconn->hpd_lock);
+			continue;
+		}
+
+		drm_modeset_lock_all(ddev);
+		dm_restore_drm_connector_state(ddev, connector);
+		drm_modeset_unlock_all(ddev);
+
+		drm_kms_helper_connector_hotplug_event(connector);
+		mutex_unlock(&aconn->hpd_lock);
+	}
+	drm_connector_list_iter_end(&iter);
+}
+
+/* Return true if this DP connector is 'ready' for retrain:
+ * - connector has a bound CRTC and is active (we don't touch idle heads)
+ * - DPCD base/ext capability reads succeed (no repeated failures/DEFER storms)
+ * - SINK_COUNT shows sink present/ready (0x41)
+ */
+static bool dm_dp_retrain_ready(struct drm_connector *conn)
+{
+	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(conn);
+	struct dc_link *link;
+	uint8_t dpcd[16], ext[16], sink = 0;
+
+	if (conn->connector_type != DRM_MODE_CONNECTOR_DisplayPort)
+		return false;
+
+	if (!aconn)
+		return false;
+	link = aconn->dc_link;
+	if (!link)
+		return false;
+
+	/* Base DPCD (0x00000..0x0000F) */
+	if (!dm_read_dpcd(link, 0x00000, dpcd, sizeof(dpcd)))
+		return false;
+
+	/* Optional ext caps (0x02200..0x0220F); ignore failure but try once */
+	(void)dm_read_dpcd(link, 0x02200, ext, sizeof(ext));
+
+	/* SINK_COUNT: lower 6 bits are the count; CP_READY is bit 6 and can be 0. */
+	if (!dm_read_dpcd(link, 0x00200, &sink, 1))
+		return false;
+	if ((sink & 0x3f) == 0) {
+		/* Try to wake the sink to D0, then re-read once */
+		if (dm_set_power_d0(link)) {
+			msleep(30); /* small settle */
+			(void)dm_read_dpcd(link, 0x00200, &sink, 1);
+		}
+		if ((sink & 0x3f) == 0)
+			return false;
+	}
+
+	return true;
+}
+
+/* Worker: run a one-shot native-DP retrain after resume settles */
+static void dp_retrain_worker(struct work_struct *w)
+{
+	struct dp_retrain_work *rw =
+		container_of(to_delayed_work(w), struct dp_retrain_work, work);
+	struct amdgpu_device *adev = rw->adev;
+	struct drm_device *ddev = adev_to_drm(adev);
+	struct drm_connector *conn;
+	struct drm_connector_list_iter iter;
+	bool need_requeue = false;
+	bool saw_any_dp = false;
+
+	if (!dc_retrain_dp_on_resume)
+		goto out;
+
+	drm_connector_list_iter_begin(ddev, &iter);
+	drm_for_each_connector_iter(conn, &iter) {
+		struct amdgpu_dm_connector *aconn;
+		struct dc_link *link;
+		union hpd_irq_data irq_data;
+		bool is_active = false;
+
+		if (conn->connector_type != DRM_MODE_CONNECTOR_DisplayPort)
+			continue;
+		saw_any_dp = true;
+
+		aconn = to_amdgpu_dm_connector(conn);
+		if (!aconn)
+			continue;
+		else {
+			link = aconn->dc_link;
+			if (!link)
+				continue;
+		}
+		/* Skip MST root; MST resume handled elsewhere */
+		if (aconn->mst_root)
+			continue;
+		/* Only act on active pipelines */
+		is_active =  (conn->state && conn->state->crtc && conn->state->crtc->state &&
+			conn->state->crtc->state->active);
+
+		/* Readiness gate: if not ready yet, mark for requeue */
+		if (!dm_dp_retrain_ready(conn)) {
+			need_requeue = true;
+			DRM_DEBUG_DRIVER("%s: connector %d not ready, will retry (try #%d)\n",
+				__func__, drm_connector_index(conn), rw->tries);
+			continue;
+		}
+
+		/* Ready but INACTIVE: nudge userspace via hotplug; re-try bounded times */
+		if (!is_active) {
+			DRM_DEBUG_DRIVER("%s: DP-%d ready but inactive -> hotplug\n",
+							__func__, drm_connector_index(conn));
+			drm_kms_helper_hotplug_event(ddev);
+
+			if (rw->tries < dc_dp_hotplug_max_retries) {
+				rw->tries++;
+				schedule_delayed_work(&rw->work,
+					msecs_to_jiffies(max(dc_dp_hotplug_retry_ms, 0)));
+				drm_connector_list_iter_end(&iter);
+				return;
+			}
+			DRM_DEBUG_DRIVER("%s: DP-%d inactive after %d nudges; giving up\n",
+				__func__, drm_connector_index(conn), rw->tries);
+			continue;
+		}
+
+		/* Ready + ACTIVE: retrain only if link-loss is reported */
+		memset(&irq_data, 0, sizeof(irq_data));
+		if (dc_link_dp_read_hpd_rx_irq_data(link, &irq_data) == DC_OK &&
+			dc_link_check_link_loss_status(link, &irq_data)) {
+
+			DRM_DEBUG_DRIVER("%s: DP-%d retraining\n",
+							__func__, drm_connector_index(conn));
+			/* Clean re-train; allow a hard modeset in the next pass */
+			dc_link_dp_handle_link_loss(link);
+			atomic_set(&dm_postresume_force_modeset, 1);
+			/* Nudge userspace to pick up new mode if needed */
+			drm_kms_helper_hotplug_event(ddev);
+
+		} else {
+			DRM_DEBUG_DRIVER("%s: DP-%d no link-loss; nothing to do\n",
+							__func__, drm_connector_index(conn));
+		}
+	}
+	drm_connector_list_iter_end(&iter);
+
+	/* If the dock/connector hasn't enumerated yet, keep probing. */
+	if (!saw_any_dp) {
+		need_requeue = true;
+		DRM_DEBUG_DRIVER("%s: no DP connectors present (try %d)\n",
+						__func__, rw->tries);
+	}
+
+	/* If no head was ready yet, requeue up to the retry cap */
+	if (need_requeue && rw->tries < dc_dp_retrain_max_retries) {
+		rw->tries++;
+		schedule_delayed_work(&rw->work, msecs_to_jiffies(max(dc_dp_retrain_retry_ms, 0)));
+		return;
+	}
+
+	if (need_requeue)
+		DRM_DEBUG_DRIVER("%s: giving up after %d tries\n", __func__, rw->tries);
+	else
+		DRM_DEBUG_DRIVER("%s: done (no requeue)\n", __func__);
+out:
+	kfree(rw);
+}
+#endif	/* VRR_USBHUB */
+
 /**
  * DOC: overview
  *
@@ -2285,6 +2812,16 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		adev->dm.secure_display_ctx.support_mul_roi = true;
 
 #endif
+#ifdef VRR_USBHUB
+	/*
+	 * Initialize the global late-reprobe worker once the DRM device exists.
+	 */
+	if (!dm_late_reprobe_initialized) {
+		INIT_DELAYED_WORK(&dm_late_dp_reprobe_work, dm_late_dp_reprobe_fn);
+		dm_late_reprobe_ddev = &adev->ddev;
+		dm_late_reprobe_initialized = true;
+	}
+#endif	/* VRR_USBHUB */
 
 	drm_dbg_driver(adev_to_drm(adev), "KMS initialized.\n");
 
@@ -3302,7 +3839,9 @@ static int dm_cache_state(struct amdgpu_device *adev)
 static void dm_destroy_cached_state(struct amdgpu_device *adev)
 {
 	struct amdgpu_display_manager *dm = &adev->dm;
+#ifndef VRR_USBHUB
 	struct drm_device *ddev = adev_to_drm(adev);
+#endif
 	struct dm_plane_state *dm_new_plane_state;
 	struct drm_plane_state *new_plane_state;
 	struct dm_crtc_state *dm_new_crtc_state;
@@ -3345,9 +3884,12 @@ static void dm_destroy_cached_state(struct amdgpu_device *adev)
 		}
 	}
 
+	/* postpone these two steps to dm_resume */
+#ifndef VRR_USBHUB
 	drm_atomic_helper_resume(ddev, dm->cached_state);
 
 	dm->cached_state = NULL;
+#endif /* VRR_USBHUB */
 }
 
 static int dm_suspend(struct amdgpu_ip_block *ip_block)
@@ -3405,6 +3947,9 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 		dc_allow_idle_optimizations(dm->dc, true);
 
 	dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D3);
+#ifdef VRR_USBHUB
+	atomic_set(&dc_vrr_work_ok, 0);
+#endif /* VRR_USBHUB */
 
 	return 0;
 }
@@ -3640,6 +4185,9 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
 	int i, r, j;
+#ifdef VRR_USBHUB
+	int ret;
+#endif
 	struct dc_commit_streams_params commit_params = {};
 
 	if (dm->dc->caps.ips_support) {
@@ -3839,6 +4387,119 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	}
 	drm_connector_list_iter_end(&iter);
 
+#ifdef VRR_USBHUB
+	/* Allow post-resume workers */
+	atomic_set(&dc_vrr_work_ok, 1);
+
+	/* ------------------------------------------------------
+	 *  PCON-in-TMDS: clear VRR in cached state before resume
+	 * ------------------------------------------------------
+	 */
+	if (dc_vrr_pcon_resume_mask && dc_vrr_preclear_in_cached_state && dm->cached_state) {
+		struct drm_atomic_state *cached = dm->cached_state;
+		struct drm_connector *conn;
+		struct drm_connector_state *conn_state;
+		struct drm_crtc *crtc;
+		struct drm_crtc_state *crtc_state;
+		int i, n_crtcs = ddev->mode_config.num_crtc;
+		bool *crtc_restore = NULL;
+
+		if (n_crtcs > 0)
+			crtc_restore = kvcalloc(n_crtcs, sizeof(bool), GFP_KERNEL);
+
+		/* Walk connector states being restored and identify PCON-in-TMDS links */
+		for_each_new_connector_in_state(cached, conn, conn_state, i) {
+			struct amdgpu_dm_connector *aconn;
+			u8 hdmi_stat = 0;
+
+			if (!conn_state || !conn)
+				continue;
+			if (conn->connector_type != DRM_MODE_CONNECTOR_DisplayPort)
+				continue;
+
+			aconn = to_amdgpu_dm_connector(conn);
+			if (!aconn || !aconn->dc_link)
+				continue;
+			if (aconn->mst_root)
+				continue; /* only root DP connector */
+
+			/* Only act on PCON-in-TMDS */
+			if (!dm_link_is_pcon_tmds(aconn->dc_link, &hdmi_stat))
+				continue;
+
+			/* Needs a target CRTC in the cached state */
+			if (!conn_state->crtc)
+				continue;
+			crtc = conn_state->crtc;
+
+			/* Find the matching CRTC state inside the same cached state */
+			crtc_state = drm_atomic_get_new_crtc_state(cached, crtc);
+			if (!crtc_state)
+				continue;
+
+			/* If VRR was enabled pre-suspend, clear it for this resume commit */
+			if (crtc_state->vrr_enabled) {
+				int idx = drm_crtc_index(crtc);
+
+				crtc_state->vrr_enabled = false;
+				if (crtc_restore && idx >= 0 && idx < n_crtcs)
+					crtc_restore[idx] = true; /* remember to restore later */
+			}
+		}
+
+		/* Single resume commit with VRR-off on the flagged CRTCs */
+		ret = drm_atomic_helper_resume(ddev, cached);
+		dm->cached_state = NULL;
+
+		/* Schedule delayed VRR restore for the CRTCs masked */
+		if (!ret && crtc_restore) {
+			int idx;
+
+			for (idx = 0; idx < n_crtcs; idx++) {
+				struct drm_crtc *iter;
+				struct drm_crtc_state *iter_state;
+				struct pcon_vrr_restore_ctx *r;
+
+				if (!crtc_restore[idx])
+					continue;
+				iter = drm_crtc_from_index(ddev, idx);
+				if (!iter)
+					continue;
+				iter_state = iter->state;
+				if (!iter_state || !iter_state->active)
+					continue;
+
+				r = kzalloc(sizeof(*r), GFP_KERNEL);
+				if (!r)
+					continue;
+				r->crtc = iter;
+				r->want_vrr = true;
+				INIT_DELAYED_WORK(&r->work, pcon_vrr_restore_work);
+				schedule_delayed_work(
+					&r->work, msecs_to_jiffies(dc_vrr_restore_ms)
+				);
+			}
+		}
+		kvfree(crtc_restore);
+	} else {
+		/* Single legacy resume */
+		ret = drm_atomic_helper_resume(ddev, dm->cached_state);
+		dm->cached_state = NULL;
+	}
+
+	/* (Optional) Native DP: schedule retrain once after resume settles */
+	if (dc_retrain_dp_on_resume) {
+		struct dp_retrain_work *rw = kzalloc(sizeof(*rw), GFP_KERNEL);
+
+		if (rw) {
+			rw->adev = adev;
+			INIT_DELAYED_WORK(&rw->work, dp_retrain_worker);
+			schedule_delayed_work(&rw->work,
+				msecs_to_jiffies(max(dc_dp_retrain_defer_ms, 0)));
+		}
+	}
+#endif /* VRR_USBHUB */
+
 	/* Debug dump: list all DC links and their associated sinks after detection
 	 * is complete for all connectors. This provides a comprehensive view of the
 	 * final state without repeating the dump for each connector.
@@ -3851,6 +4512,13 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 
 	drm_kms_helper_hotplug_event(ddev);
 
+#ifdef VRR_USBHUB
+	if (dc_postresume_hard_modeset) {
+		atomic_set(&dm_postresume_force_modeset, 1);
+		drm_kms_helper_hotplug_event(ddev);
+	}
+	late_dp_redetect_and_hotplug(ddev);
+#endif /* VRR_USBHUB */
 	return 0;
 }
 
@@ -4232,6 +4900,70 @@ static void hdmi_hpd_debounce_work(struct work_struct *work)
 	bool fake_reconnect = false;
 	bool reallow_idle = false;
 	bool ret = false;
+#ifdef VRR_USBHUB
+	scoped_guard(mutex, &aconnector->hpd_lock) {
+
+		/* Re-detect the display */
+		scoped_guard(mutex, &adev->dm.dc_lock) {
+			if (dc->caps.ips_support && dc->ctx->dmub_srv->idle_allowed) {
+				dc_allow_idle_optimizations(dc, false);
+				reallow_idle = true;
+			}
+			ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
+		}
+
+		if (ret) {
+			/* Apply workaround delay for certain panels */
+			apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
+			/* Compare sinks to determine if this was a spontaneous HPD toggle */
+			if (are_sinks_equal(
+				aconnector->dc_link->local_sink, aconnector->hdmi_prev_sink)) {
+				/*
+				 * Sinks match - this was a spontaneous HDMI HPD toggle.
+				 */
+				drm_dbg_kms(
+					dev, "Sink unchanged after debounce, internal re-enable\n");
+				fake_reconnect = true;
+			}
+
+			/* Update connector state */
+			amdgpu_dm_update_connector_after_detect(aconnector);
+
+			drm_modeset_lock_all(dev);
+			dm_restore_drm_connector_state(dev, connector);
+			drm_modeset_unlock_all(dev);
+
+			/* Only notify OS if sink actually changed */
+			if (!fake_reconnect && aconnector->base.force == DRM_FORCE_UNSPECIFIED)
+				drm_kms_helper_hotplug_event(dev);
+		}
+
+		/* Release the cached sink reference */
+		if (aconnector->hdmi_prev_sink) {
+			dc_sink_release(aconnector->hdmi_prev_sink);
+			aconnector->hdmi_prev_sink = NULL;
+		}
+
+		scoped_guard(mutex, &adev->dm.dc_lock) {
+			if (reallow_idle && dc->caps.ips_support)
+				dc_allow_idle_optimizations(dc, true);
+		}
+	}
+	/* --- Begin: late re-probe policy (bus-powered VRR PCON) --- */
+	if (aconnector &&
+		aconnector->base.connector_type == DRM_MODE_CONNECTOR_DisplayPort &&
+		!aconnector->mst_root) {
+		if (aconnector->base.status == connector_status_connected) {
+			dm_schedule_late_dp_reprobe(&aconnector->base);
+		} else if (aconnector->base.status == connector_status_disconnected) {
+			cancel_delayed_work_sync(&dm_late_dp_reprobe_work);
+			drm_dbg_kms(aconnector->base.dev,
+					"dm: late DP reprobe cancelled for %s (status=disconnected)\n",
+					aconnector->base.name);
+		}
+	}
+	/* --- End: late re-probe policy --- */
+	#else
 	guard(mutex)(&aconnector->hpd_lock);
 
 	/* Re-detect the display */
@@ -4277,6 +5009,7 @@ static void hdmi_hpd_debounce_work(struct work_struct *work)
 		if (reallow_idle && dc->caps.ips_support)
 			dc_allow_idle_optimizations(dc, true);
 	}
+#endif
 }
 
 static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
-- 
2.43.0

