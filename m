Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0D4CD3438
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E35F610E1CA;
	Wed, 12 Nov 2025 18:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mJ1js2pv";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C86610E1CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyLEZiWrNLhayvK7H0eLE9HCOpfZX+jnhHW6iImUTz0oKa4haWGXWGtcDdVYzL7y4vR/n1jo/e5d2hmJYDk1fM5dU7rizCTWM8Or5kWZSabRqrX6V6Yb8rHyC+63cOntM1r+ReOalKYeHciUL/vcGIulGLA/fCgYv6N8uJCQVuNVxSQICKczSuSB0CVKXY+zaEG5OLaylVVjN/obLMSgVIRbX5eGK20eCFdev7dcwOpDjGhAw0qlRKjeZ1w+I5FRjo6dk/sARxOxfiDUI1Sl7c1tlufWGG45lZwUdnh+xGi8ciADKNl1yzKuZjAo2LJaQN47QNJU+HCv4MIc9IPo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWOBSnOV8y8Ylil1NOk68+I91mYeBrWL29nYsVXNfGE=;
 b=tf1/7xugDlrCg2aOtXbwtmQ5BuJ5Q0cAEums2B333blLcr/pkLzZJkS+Df4Uv4KSW9gVzg69TXh3mulauPIFjGXn3NokdoDw8KAZapmn6OxHGxy2mPgUoUawdv3NfbgaTob/QE9c+Dm0y/KQKDbCTzi52aRix0J/H4/WEb5QQ4Hs/HJT7wRQ6epaohIJf+QO/8gv/tIWbnJHdXnWcr78fP6Y5sSm1L8auaGHZmBNUGeytEtnA7fywDSbsC5UhFV7wVKnzu69Hw7noOzIG7xllVexEUAphysN/VTR+bqZ1Iz5DFS7u3LwrOzXuad760LUkip6DCdjQ5qVPBCSY0ylng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWOBSnOV8y8Ylil1NOk68+I91mYeBrWL29nYsVXNfGE=;
 b=mJ1js2pvunFmCmWss1Z2Wg+aUh3OuntOYTiBEZ0SmtMhrExXQUfT6HcKej8Ek6ns/+sqDYD6mRnxbfc4naUhCBBJNB7lgNSNoN/YOrqwMox3ZGNr5v0qEjx3CeX6xrqbhOH4GDPiG72ATvQpLH+rehdDBtQc7xJqbKQe/67bICM=
Received: from MN0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::28)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Wed, 12 Nov
 2025 18:22:56 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::b8) by MN0P220CA0013.outlook.office365.com
 (2603:10b6:208:52e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 18:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:22:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 10:22:46 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Nov
 2025 12:22:46 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:22:46 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 09/16] drm/amd/display: Add an HPD filter for HDMI
Date: Wed, 12 Nov 2025 13:20:27 -0500
Message-ID: <20251112182212.559007-10-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
References: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7194e915-d1ac-4940-d3e5-08de221880a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3l1WEFNNVFuSktVZWFGSHZHV1hGVGlxRk9HUnJsMXV5VU13b0FodkFGeU55?=
 =?utf-8?B?ZGtwUWhqQ3prUlAwZmVCTWI5aWovZWFwSFFMMjRRaTFPSzkwNkJYNVBGVW5O?=
 =?utf-8?B?djVTandha1Q3T01lbGRxUE84TEZsUm1GV0YxTmt2UUg4ejBVcnFaYkplMHlK?=
 =?utf-8?B?Q1Mxc3hjeUorUmFYZFZhMTA0bVJPclI2RlplSU5ZVGJTd0wwM0RjZ0ZpUWZs?=
 =?utf-8?B?NTM5allZem00SDJSMVh3a2lTTGloSjV4VEV2anNNVlJLYTEwRUlHMHNZOXZu?=
 =?utf-8?B?L0h3aXRxNENYRDVmQWZIRmtkQ21JS2poNm1UdGVVR2xiaDlkMVo0dkVmNVpY?=
 =?utf-8?B?TUIrZ2kyVVp2aGNLaVowQVViaU15a0R3NS9YN3h1NjA3VEdNa0cya3VTYmN5?=
 =?utf-8?B?UVp6ZUpWZHhieEJxVlUrMHNQbzBOWWxJSHJ3NjdHK0phaVE4SXltN2NBQVpx?=
 =?utf-8?B?bHJkNVFySlJjczZpL0RUc04rU3JTZTNQM0pteGIvQ3NGdk5sS1NCY1B5RnVG?=
 =?utf-8?B?RGNyWTNadzFsM0FrMjViWVM2My8vR25kZmtBN0V2UGQ0ZFNoeTczaWpiL2lk?=
 =?utf-8?B?YTY0YjJiVjNvZnNsc1QyOEs5eXVuV0VqWlVuWERSd2YyS1QvU2VJWlkwUXJ4?=
 =?utf-8?B?LzJvbHlVb1d2eCtMb0cvRXlZK2R2dW5ZR1VmUG5RWGpiVTBrOE1nNTl5UGRs?=
 =?utf-8?B?WjZsZjR6Q1hFSnhDUTdJN1VtU2ZnUkpEUDEzbEhxYk5JcEpQOHdaZThKOVJq?=
 =?utf-8?B?UVVFb1AxaUxSVHRoMHBha3dUT050VnB0SHdWT0NDTEExcGY2NGk2WHNJZTRr?=
 =?utf-8?B?MGhEeGtVaFlsSVkrV1JHK2VLTzB3Q2F6bDd2Rk45ZnpXSTJWL1grQmFoM21U?=
 =?utf-8?B?RWxRd1dlQk9WV1dPdTlTNkludUxFc0ZzV0lQOGNUSFpMMlhiYlJCZThNNHAz?=
 =?utf-8?B?dTVtcHhPNWN6T0FrMU5jMmRsRW50djNvNlR3R3hwbzZZS0JxYW0vM0FoWUNN?=
 =?utf-8?B?aEN6SS9pblhuQ1F6UnY5aElOa2xUcW9xOEUyMlVWTkc1MGp1cUJXZjNxdnVL?=
 =?utf-8?B?cGFDYkl6MUI0K2J6Syt1NGZ5dlpoNURBOXA1R0VTZS9KWWRMVXlPOERIY1Vi?=
 =?utf-8?B?THk4bzU0c0I5NjhHSGpaYlR1ck5Venl2TWJMcWNKUGZ4WGw5bTM0cnJZUWVT?=
 =?utf-8?B?SWFsbUVkdE05eFRKTWlYMk8wQjVFNlV6NnJPb3dFSDVTSkJLcTlwNXdldEJD?=
 =?utf-8?B?RkJ6aythZ3k2dXNCSHFxM3pQSEliVUc3SzFjYm5YUldnczM3VVRiVWZId3U1?=
 =?utf-8?B?bVlhTDhNSmx4VHNuWEg0cVNhU2lTUXZ5SzlscTRRSVJKdlR3N3JRQkhSaXdK?=
 =?utf-8?B?T1NkRkxFUUFHWk5OSTBtY3pwZzJQYkhqc0kydUpwT0YvZnFIRGRNME9vaE5G?=
 =?utf-8?B?WXJxNGR6WDVqK1RqaloxUnhDbyt4MFJZRVR1enlXMm4zVkxMOVJOMHFHWVdM?=
 =?utf-8?B?bkthYWR0WDNtZkthOTNuaWV1aHQwZEFwSC9pWnN0Z1hKUzFSZldVeWNnOTBH?=
 =?utf-8?B?OFYzQUdCMEgrSmoxakZJZThHOFNTWjV0OVdZUEpSNWxyZFcrSHVGWTFMaDZH?=
 =?utf-8?B?elBhV0pMUFU1Y2Y4NWpqMDF5L3kxekgxVFlYd1NEU0h6Y2Y5MUpCR2J1bGpU?=
 =?utf-8?B?TTFjNDNJdEcwbnhsQWR1NE11UERRQmJHdXcxNjJqRnBTaHk3SUxNbFFhYzRL?=
 =?utf-8?B?b0RKRCtVQmJubXA0cC85REhKNlZWa0tldHI3SE1mcTdPTEpwUk9nNEt0K0Fi?=
 =?utf-8?B?YVkyZkFoOVVtRG9Wa0F5Zys0R3dCb3ZFUUZYM3lIS09PdmF3bHRPa1hFcnNt?=
 =?utf-8?B?c2Erb1ZQUnpZcHJhNnZIbHF1WFRyczhkREVrQ2psaUNEY0xyb2dxa1ZtUW1X?=
 =?utf-8?B?NEJ4VjQ1MEFKSkM0dXBGU0NmMWl0WmFIbFk3R2h4YVFKVWV0ZmJJN0Z5aTZo?=
 =?utf-8?B?allCd1hUYVl3ZzZ4Rmo3S2lXTHZXbDVyeUZGajdueGpFcjM0cHVVamFmUU1i?=
 =?utf-8?Q?+Y6lml?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:22:56.5386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7194e915-d1ac-4940-d3e5-08de221880a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why]
Some monitors perform rapid “autoscan” HPD re‑assertions right after a
disconnect or powersaving mode enablement. These appear as a quick
disconnect→reconnect with an identical EDID. Since Linux has no HDMI
hotplug detection (HPD) filter, these quick reconnects are seen as hotplug
events, which can unintentionally wake a system with DPMS off.

An example: https://gitlab.freedesktop.org/drm/amd/-/issues/2876

Such 'fake reconnects' are considered when the interval between a
disconnect and a connect is within 1500ms (experimentally chosen using
several monitors), and the two connections have the same EDID.

[How]
Implement a time-based debounce mechanism:

1. On HDMI disconnect detection, instead of immediately processing the
HPD event, save the current sink and schedule delayed work (default 1500ms)

2. If another HDMI disconnect HPD event arrives during the debounce period,
it reschedules the pending work, ensuring only the final state is processed.

3. When the debounce timer expires, re-detect the display and compare the
new sink with the cached one using EDID comparison.

4. If sinks match (same EDID), this was a spontaneous HPD toggle:
   - Update connector state internally
   - Skip hotplug event to prevent desktop rearrangement

   If sinks differ, this was a real display change:
   - Process normally with the hotplug event

The debounce delay is configurable via module parameter
'hdmi_hpd_debounce_delay_ms'.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2876
Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 138 ++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   6 +
 2 files changed, 144 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index aa31e969b39d..dea88e908933 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3915,6 +3915,97 @@ void amdgpu_dm_update_connector_after_detect(
 		mutex_unlock(&dev->mode_config.mutex);
 }
 
+static bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2)
+{
+	if (!sink1 || !sink2)
+		return false;
+	if (sink1->sink_signal != sink2->sink_signal)
+		return false;
+
+	if (sink1->dc_edid.length != sink2->dc_edid.length)
+		return false;
+
+	if (memcmp(sink1->dc_edid.raw_edid, sink2->dc_edid.raw_edid,
+		   sink1->dc_edid.length) != 0)
+		return false;
+	return true;
+}
+
+
+/**
+ * DOC: hdmi_hpd_debounce_work
+ *
+ * HDMI HPD debounce delay in milliseconds. When an HDMI display toggles HPD
+ * (such as during power save transitions), this delay determines how long to
+ * wait before processing the HPD event. This allows distinguishing between a
+ * physical unplug (>hdmi_hpd_debounce_delay)
+ * and a spontaneous RX HPD toggle (<hdmi_hpd_debounce_delay).
+ *
+ * If the toggle is less than this delay, the driver compares sink capabilities
+ * and permits a hotplug event if they changed.
+ *
+ * The default value of 1500ms was chosen based on experimental testing with
+ * various monitors that exhibit spontaneous HPD toggling behavior.
+ */
+static void hdmi_hpd_debounce_work(struct work_struct *work)
+{
+	struct amdgpu_dm_connector *aconnector =
+		container_of(to_delayed_work(work), struct amdgpu_dm_connector,
+			     hdmi_hpd_debounce_work);
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *dev = connector->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct dc *dc = aconnector->dc_link->ctx->dc;
+	bool fake_reconnect = false;
+	bool reallow_idle = false;
+	bool ret = false;
+	guard(mutex)(&aconnector->hpd_lock);
+
+	/* Re-detect the display */
+	scoped_guard(mutex, &adev->dm.dc_lock) {
+		if (dc->caps.ips_support && dc->ctx->dmub_srv->idle_allowed) {
+			dc_allow_idle_optimizations(dc, false);
+			reallow_idle = true;
+		}
+		ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
+	}
+
+	if (ret) {
+		/* Apply workaround delay for certain panels */
+		apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
+		/* Compare sinks to determine if this was a spontaneous HPD toggle */
+		if (are_sinks_equal(aconnector->dc_link->local_sink, aconnector->hdmi_prev_sink)) {
+			/*
+			* Sinks match - this was a spontaneous HDMI HPD toggle.
+			*/
+			drm_dbg_kms(dev, "HDMI HPD: Sink unchanged after debounce, internal re-enable\n");
+			fake_reconnect = true;
+		}
+
+		/* Update connector state */
+		amdgpu_dm_update_connector_after_detect(aconnector);
+
+		drm_modeset_lock_all(dev);
+		dm_restore_drm_connector_state(dev, connector);
+		drm_modeset_unlock_all(dev);
+
+		/* Only notify OS if sink actually changed */
+		if (!fake_reconnect && aconnector->base.force == DRM_FORCE_UNSPECIFIED)
+			drm_kms_helper_hotplug_event(dev);
+	}
+
+	/* Release the cached sink reference */
+	if (aconnector->hdmi_prev_sink) {
+		dc_sink_release(aconnector->hdmi_prev_sink);
+		aconnector->hdmi_prev_sink = NULL;
+	}
+
+	scoped_guard(mutex, &adev->dm.dc_lock) {
+		if (reallow_idle && dc->caps.ips_support)
+			dc_allow_idle_optimizations(dc, true);
+	}
+}
+
 static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
@@ -3924,6 +4015,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
 	struct dc *dc = aconnector->dc_link->ctx->dc;
 	bool ret = false;
+	bool debounce_required = false;
 
 	if (adev->dm.disable_hpd_irq)
 		return;
@@ -3946,6 +4038,14 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 	if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
 		drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
+	/*
+	 * Check for HDMI disconnect with debounce enabled.
+	 */
+	debounce_required = (aconnector->hdmi_hpd_debounce_delay_ms > 0 &&
+			      dc_is_hdmi_signal(aconnector->dc_link->connector_signal) &&
+			      new_connection_type == dc_connection_none &&
+			      aconnector->dc_link->local_sink != NULL);
+
 	if (aconnector->base.force && new_connection_type == dc_connection_none) {
 		emulated_link_detect(aconnector->dc_link);
 
@@ -3955,7 +4055,34 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 
 		if (aconnector->base.force == DRM_FORCE_UNSPECIFIED)
 			drm_kms_helper_connector_hotplug_event(connector);
+	} else if (debounce_required) {
+		/*
+		 * HDMI disconnect detected - schedule delayed work instead of
+		 * processing immediately. This allows us to coalesce spurious
+		 * HDMI signals from physical unplugs.
+		 */
+		drm_dbg_kms(dev, "HDMI HPD: Disconnect detected, scheduling debounce work (%u ms)\n",
+			    aconnector->hdmi_hpd_debounce_delay_ms);
+
+		/* Cache the current sink for later comparison */
+		if (aconnector->hdmi_prev_sink)
+			dc_sink_release(aconnector->hdmi_prev_sink);
+		aconnector->hdmi_prev_sink = aconnector->dc_link->local_sink;
+		if (aconnector->hdmi_prev_sink)
+			dc_sink_retain(aconnector->hdmi_prev_sink);
+
+		/* Schedule delayed detection. */
+		if (mod_delayed_work(system_wq,
+				 &aconnector->hdmi_hpd_debounce_work,
+				 msecs_to_jiffies(aconnector->hdmi_hpd_debounce_delay_ms)))
+			drm_dbg_kms(dev, "HDMI HPD: Re-scheduled debounce work\n");
+
 	} else {
+
+		/* If the aconnector->hdmi_hpd_debounce_work is scheduled, exit early */
+		if (delayed_work_pending(&aconnector->hdmi_hpd_debounce_work))
+			return;
+
 		scoped_guard(mutex, &adev->dm.dc_lock) {
 			dc_exit_ips_for_hw_access(dc);
 			ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
@@ -7569,6 +7696,13 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 	if (aconnector->mst_mgr.dev)
 		drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
 
+	/* Cancel and flush any pending HDMI HPD debounce work */
+	cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_work);
+	if (aconnector->hdmi_prev_sink) {
+		dc_sink_release(aconnector->hdmi_prev_sink);
+		aconnector->hdmi_prev_sink = NULL;
+	}
+
 	if (aconnector->bl_idx != -1) {
 		backlight_device_unregister(dm->backlight_dev[aconnector->bl_idx]);
 		dm->backlight_dev[aconnector->bl_idx] = NULL;
@@ -8748,6 +8882,10 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	mutex_init(&aconnector->hpd_lock);
 	mutex_init(&aconnector->handle_mst_msg_ready);
 
+	aconnector->hdmi_hpd_debounce_delay_ms = AMDGPU_DM_HDMI_HPD_DEBOUNCE_MS;
+	INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, hdmi_hpd_debounce_work);
+	aconnector->hdmi_prev_sink = NULL;
+
 	/*
 	 * configure support HPD hot plug connector_>polled default value is 0
 	 * which means HPD hot plug not supported
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 952926fe9c59..20ac784f0ee9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -59,6 +59,7 @@
 
 #define AMDGPU_HDR_MULT_DEFAULT (0x100000000LL)
 
+#define AMDGPU_DM_HDMI_HPD_DEBOUNCE_MS 1500
 /*
 #include "include/amdgpu_dal_power_if.h"
 #include "amdgpu_dm_irq.h"
@@ -814,6 +815,11 @@ struct amdgpu_dm_connector {
 	bool pack_sdp_v1_3;
 	enum adaptive_sync_type as_type;
 	struct amdgpu_hdmi_vsdb_info vsdb_info;
+
+	/* HDMI HPD debounce support */
+	unsigned int hdmi_hpd_debounce_delay_ms;
+	struct delayed_work hdmi_hpd_debounce_work;
+	struct dc_sink *hdmi_prev_sink;
 };
 
 static inline void amdgpu_dm_set_mst_status(uint8_t *status,
-- 
2.43.0

