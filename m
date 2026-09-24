Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9851EC98328
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C6110F73B;
	Thu, 24 Sep 2026 18:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="48Z2bzeU";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E0510F728
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNgS991Hs10j4/VGgJIBFxuLI4CyLkTvqPIUfPLv2CvmJbTYKSaalAQaqahNWcK5UppmckDRIAo7qlYi+FV3YKc8EivwS8MmHE4caVtddDOQ/CgkMWVc7aQuXNDa8wijhAJOYlCCLsb+BzpN0mFKcfw76ELR54xpqJ848O4ID6AzRkHc7z1kqd65cHtiO/XToBg48HOsyb5eIQQ/fC0TELHxUKtJA7/6hEujObcaJ2nMvC3Lb7Wxu9afinRRHdWX78iA8BWxAAf7KkF2ZOYAtXqG+z0ocdd/EGR1Mph9vix1+HQMOaWaV0taCIy6thP0MDtoryP+B2obYQH8fR3uAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9KGzfWh32d2XX7/l4hnlFO4s/Y9zb12v5K+uPC8DTM=;
 b=zB6FtJBjUmuRh7lV0kIDIBlT9vu2jAL1HateM0FkD8mXlYXAXJsbT4FYBEcndd3dYbz9ttayHbc5lk5/vcYQXQ9bl4PekmKWSRMeRux4ZLf29RdJKhVLT873c4Dc3HcUx81ikEOfP1koVZ0aBDuVu664tfOtHdaOp2MPKmvlvHMsPNpK5Z/PhLYsfvqARXnzoA8zuCjhNkL1+VdUfu1w4WXSbVchOIx4EdNqp6/+1bcmWd1qo2ZahXaWorlNh0pfsFAPxyUziutpIQ1ya94XdGWFUBHyDX1VxWNGDZvv2++jFKB+cDK0O/nxYcH6DmHVe8pjmboamfAtoxcm9J1oZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9KGzfWh32d2XX7/l4hnlFO4s/Y9zb12v5K+uPC8DTM=;
 b=48Z2bzeUnAHZm1hQeF1tiledPdyxf0oPrBJ6txvDRuhpACs7nJorLJy/uENWFF4Qta6CvD7PByZtA8e9W96sbcMcx9GwofKLu5aFWLNRNBz1uBQc3PH8L22c3T89qr/TpBZj0i9895GeUNfq8P98/S4fRxaiwIJN+BXgrEK8KHg=
Received: from PH8P221CA0052.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::16)
 by IA3PR12MB460542.namprd12.prod.outlook.com (2603:10b6:208:709::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:29 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:510:346:cafe::c) by PH8P221CA0052.outlook.office365.com
 (2603:10b6:510:346::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:28 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:12 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 16/34] drm/amd/display: map PWM brightness through custom
 backlight curve
Date: Thu, 24 Sep 2026 14:45:29 -0400
Message-ID: <20260924184824.596894-17-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|IA3PR12MB460542:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4fd8e8-c4b1-4fc1-b134-08df1a6c24fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /3q/Pi9H/hdK6GVEqft+bEeMDxqaVNQfY6tsYzfAf3yxGMi9s5AZ7NLTH/L+N7/VX+mDTPKW174+OLGKpqhMzQ5E67xO12PFlf7N1vEfes8HcS1i/WTV6c3slUmM5maIp0Q/4cIkyfdzqOdpJWr2RGxnjtig103EfEcK2rky76WVszYeDZzYDukyKM9sRWJm4yEPQgwcDEgn+P/Nn8ZEdf/7jWOIqFLa3dQXNqYwXbXUNjQ2bA0ELWgd+9l5LkK4fFs0KAWOItUqxqaCTZUTO2INvB4xODD3W3K8bKPRSR/72EU8dAKk5bx8VaKJ84BYlxuw8WW6L1Jzf6QeEBXLC5qRCKYpc7P8HP2GgOVP+bt2gZgCnq56oYlnADRNJBnnQMvO5mCd5uIBdmRjMAXqqNDOxoSxz4MiQrCLmtenNgT29GpOGNbvLB/QbeaLYXByBoDU2BlWFAURVT2TPZ7ET3YHU6DRHcLodB32P+QLCwkU/kzMNEP8qSOHLZ2il/aIJoJeSBbh1S22MP3zXg27JzlRc1VRd3C59suY4/HrxwumuH1rlDDHyFr2rl3eURLqfDPJhssO76KS9LoOs2VxrWncD2rKFUDrXDl8FWRgr9S+srBXKAZJp1zhmXBLa/Xg4VXl5MUmZvsluwnWXV1F2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YR0OAAXC07MSlZ5dkIVdgTeQB25Zr2U/UYO7zATetvV6BKmSoESd+sDG6MgsV2CUnb/RF6wNiUI9iicVRJbctSgwLWTuU+P5rrfqaMfz1AXdrjS/vlur/UMManswokrOZwWjcWstaedgo1SR34q8grxjyyBd0ESZcpMhBoXY4RvqyN6Io5I3VgdaDpJHU8O1pchOuGjRHq2DzUEOQGETf8PD/4QKRiz+hFdasdxdhMOkmCkEw2Rn946Lt52YdzStLgvN3QRnwhq4MNl1jwAcyhZMNQjDLzKm88Rz1i+qjJHJVqYUH2pd3zZ6Xkavtg4Fi/2Me+htE/GsDt0R209wA5L4qet5yOWQd01Mh+cb3einpsfldbkfbmrBqFKpJ3uhK3i2gOWHS6MKzGvsYQ9VSzQm8Brslx3VdbFXH2RcF9SGiWWrX03odTQfn5BkjgkU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:28.8085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4fd8e8-c4b1-4fc1-b134-08df1a6c24fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB460542
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

From: Ray Wu <ray.wu@amd.com>

[Why/How]
On the PWM path, convert the userspace brightness to an input signal and
derive the target luminance from the custom backlight curve, then pass
the resulting millipercent to the power module.

This keeps PWM programming and backlight curve mapping in the power
module, aligning the Linux path with the Windows behavior.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5723

Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
Assisted-by: Cursor:Claude-Opus-4.8
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: ChiaHsuan (Tom) Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   | 90 ++++++++++++++++---
 2 files changed, 80 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b6d7be0c15bc..96eb9ea3f497 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -456,6 +456,8 @@ STATIC_IFN_KUNIT int amdgpu_dm_init_power_module(struct amdgpu_display_manager *
 		init_data[i].use_custom_backlight_caps = false;
 		init_data[i].custom_backlight_caps_config_no = 0;
 		init_data[i].use_linear_backlight_curve = false;
+		if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
+			init_data[i].use_linear_backlight_curve = true;
 		init_data[i].def_varibright_enable = 0;
 		init_data[i].varibright_level = 0;
 		/*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 45e1732a5b04..27546febf90d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -39,6 +39,7 @@
 #include "modules/inc/mod_power.h"
 
 #include <linux/backlight.h>
+#include <linux/minmax.h>
 #include <linux/power_supply.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_utils.h>
@@ -127,6 +128,68 @@ static inline u32 scale_fw_to_input(int min, int max, u64 input)
 	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LEVEL);
 }
 
+static u32 backlight_signal_to_luminance(const struct amdgpu_dm_backlight_caps *caps,
+					 u32 signal)
+{
+	u32 lower_signal, upper_signal;
+	u32 lower_lum, upper_lum;
+	int i;
+
+	if (!caps->data_points)
+		return DIV_ROUND_CLOSEST(signal * 100, AMDGPU_MAX_BL_LEVEL);
+
+	if (signal < caps->luminance_data[0].input_signal) {
+		lower_signal = 0;
+		lower_lum = 0;
+		upper_signal = caps->luminance_data[0].input_signal;
+		upper_lum = caps->luminance_data[0].luminance;
+	} else if (signal >=
+		   caps->luminance_data[caps->data_points - 1].input_signal) {
+		lower_signal = caps->luminance_data[caps->data_points - 1].input_signal;
+		lower_lum = caps->luminance_data[caps->data_points - 1].luminance;
+		upper_signal = caps->max_input_signal;
+		upper_lum = 100;
+	} else {
+		for (i = 1;
+		     i < caps->data_points &&
+		     signal > caps->luminance_data[i].input_signal;
+		     i++)
+			;
+
+		lower_signal = caps->luminance_data[i - 1].input_signal;
+		upper_signal = caps->luminance_data[i].input_signal;
+		lower_lum = caps->luminance_data[i - 1].luminance;
+		upper_lum = caps->luminance_data[i].luminance;
+	}
+
+	if (upper_signal == lower_signal)
+		return upper_lum;
+
+	return lower_lum + DIV_ROUND_CLOSEST((upper_lum - lower_lum) *
+					     (signal - lower_signal),
+					     upper_signal - lower_signal);
+}
+
+static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_caps *caps,
+					      u32 user_brightness)
+{
+	unsigned int min, max;
+	u32 signal, luminance;
+
+	if (!get_brightness_range(caps, &min, &max))
+		return DIV_ROUND_CLOSEST_ULL((u64)user_brightness * 100000,
+					     MAX_BACKLIGHT_LEVEL);
+
+	user_brightness = clamp(user_brightness, min, max);
+	if (amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)
+		return DIV_ROUND_CLOSEST_ULL((u64)user_brightness * 100000, max);
+
+	signal = scale_input_to_fw(max, user_brightness);
+	luminance = backlight_signal_to_luminance(caps, signal);
+
+	return min_t(u32, luminance * 1000, 100000);
+}
+
 STATIC_IFN_KUNIT
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
 			       unsigned int min, unsigned int max,
@@ -269,10 +332,10 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	struct amdgpu_dm_backlight_caps *caps;
 	struct dc_link *link;
 	u32 brightness = 0;
+	u32 millipercent = 0;
 	bool rc = false, reallow_idle = false;
 	struct drm_connector *connector;
 	struct dc_stream_state *stream;
-	unsigned int min, max;
 
 	list_for_each_entry(connector, &dm->ddev->mode_config.connector_list, head) {
 		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
@@ -295,12 +358,21 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	/* update scratch register */
 	if (bl_idx == 0)
 		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
-	brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
+
 	link = (struct dc_link *)dm->backlight_link[bl_idx];
+	stream = dm_find_stream_with_link(dm, link);
+	if (!stream)
+		return;
 
-	/* Apply brightness quirk */
-	if (caps->brightness_mask)
-		brightness |= caps->brightness_mask;
+	if (caps->aux_support) {
+		brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
+		/* Apply brightness quirk */
+		if (caps->brightness_mask)
+			brightness |= caps->brightness_mask;
+	} else {
+		millipercent = convert_brightness_to_millipercent(caps,
+								  user_brightness);
+	}
 
 	if (trace_amdgpu_dm_brightness_enabled()) {
 		trace_amdgpu_dm_brightness(__builtin_return_address(0),
@@ -310,10 +382,6 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 					   power_supply_is_system_supplied() > 0);
 	}
 
-	stream = dm_find_stream_with_link(dm, link);
-	if (!stream)
-		return;
-
 	mutex_lock(&dm->dc_lock);
 	if (dm->dc->caps.ips_support && dm->dc->ctx->dmub_srv->idle_allowed) {
 		dc_allow_idle_optimizations(dm->dc, false);
@@ -325,10 +393,8 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 			AUX_BL_DEFAULT_TRANSITION_TIME_MS, false, true);
 	} else {
 		/* power module uses millipercent */
-		get_brightness_range(caps, &min, &max);
-		brightness = DIV_ROUND_CLOSEST(brightness * 100, (max - min)) * 1000;
 		rc = mod_power_set_backlight_percent(dm->power_module, stream,
-						     brightness, 0, false);
+						     millipercent, 0, false);
 	}
 
 	/*
-- 
2.53.0

