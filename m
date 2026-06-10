Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13A1CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7390110E886;
	Wed, 10 Jun 2026 09:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N7+6t7It";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D255F10E886
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sH8ogk1j9CBkz0iEwXfJLhr7hD/io3l5ivIlb4qPWkWhnsVBj96HpUzmjgAfR5FavgwKO3EHu2IDtNgVhZin/+PuP1m5pHSXfok7dblkNhrwvUeIc/r3/TQNA3Mn/a/5dKswfuXzmH9h21zUo7dv3CBD4i5y/8KZszpv/OkVz6AYr9dTKU8WUiNAh4VOzg781I5A58HtA1J/93KAHvuTvLA/YyrCALLUK/uXkPei26tSBg+hhs9gA/G+8EVy0cTIAuOzCDb6FhOW2DZzXQl5T59EaqHdES66G5OAxYzeTnRHVAqXqFv/dSKuXgVtcTEzVHTN8RdWIts61rUX9kz87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlD8gDwiI+xBJVGdpjbMTwedel63TGW3apgbtwWD/eA=;
 b=kM7Bh0548PIiZ4HS3/tiT+OxcnsCnlGCGbTVj17Q0EQSjV2XBmuDNI/3RAy5vbvz5JXbnZMrGc9GP2qjZlyi1XdjfhJ2RwuCmRLbDknTx2Fg3s1Ee8ImLgA88gRgOoylLE3fYR/JSMvQDwE1yKo03K1zfpjRaF8IyLe7n0CthMeMWctBotrfRuphx0usnG14Dz3KfyvgUcbQG0+fHu+rrRuNVGxq/CjGOR0VLzySxxVhx+4rlZXUm5lXphFoXinCn+d/pjotbnZcWuoCS+u6irS70mg4IsBthawyGi4LgthQlY5hDyYPbl+2A+NBI/+WXxMP2XLyh6/BMAtX71vuFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlD8gDwiI+xBJVGdpjbMTwedel63TGW3apgbtwWD/eA=;
 b=N7+6t7ItmHShkc/KZLXpmae+i7daNmkwTEc3iQz9vp6jbUqKuUckpnEVNI+4GOdMv8Uz2DdtcDTWgtJukQ7uDs50YYuvGsNqXX8rPvadmrSbY5cYMIWcThqgWdKA9oTRDC0NZimMWhfD+odOc2QNVIH9GG+G6OyYXu1Z1txhp20=
Received: from PH7P220CA0098.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::9)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 10 Jun
 2026 09:50:47 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::8e) by PH7P220CA0098.outlook.office365.com
 (2603:10b6:510:32d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 09:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:50:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:50:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:50:45 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:50:37 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>
Subject: [PATCH 18/32] drm/amd/display: Add KUnit tests for amdgpu_dm_backlight
Date: Wed, 10 Jun 2026 17:45:02 +0800
Message-ID: <20260610094639.1965367-19-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a2c6ad-be08-4df3-9bf1-08dec6d5bef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|56012099006|22082099003|18002099003|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: JQmJVl6ZNYVt1AlwIA+g6Vqh41zjWqpat//VvSj2LRxO7YBhRYzjFSWidwL+dZcBKwNTyhbF3GDhHLqLmqf75ooYmwnuX0rks639K15ZuNI6A5MmgZ1URfBtZ2Mid7Kn5n8pPhpzyKYa8TB59+4kID4vfTMyWsSw2WiDRPK0ITM7w8EzetpUvXt5GGFz3jsE/0RxZIihA/TBb7AXS2zqglQ4m/vG8UeSFQHoSMsdORuqd6oyUlTANEnjRoTnAP1KA7XYidzrhuZ/vkIstw+7N1oLAHNEuB4IFLQYW4XcIKPAeObaQ7rPccSbbCodj3WywfEoCLvYyu7OSQFALyUpmswZKmV/onH2DiJjA3lHJmY4nVt/RLOqvU73j6VWqxA7AEvS33hWW/Iet994GgyMt2RQBOsfV7blZXC5ZtWhlutX4+WgrmGmAq54sREaTZp+6gyWfic8+/uQUrjIhoXDvydVicc0ho8PDC+VkHJGUxSvfsUqsiftCTI3DFivobBKAl7+XSceULlqc2KQ4KSqbKGSw5g9hvP4FIEqv/GNDf/3XPd3hKV3dPyZBTCPUSp3YdD9QptsLtN5c2srQPYDM7vwkWTDBfc8xqn+bvwzwhDR+ppVGvbqainTuOniH08Lvctjqos/OeU4PkMJk1gHam4Niu+yfRjqBcroJFazUGTJq02/sQvwMqGvZkC/t0/RXH4JVQyV3+ZxLpu7sy5BAmBzeyKXEqig4gDVfs5CsXM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(56012099006)(22082099003)(18002099003)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hSaq+Bh5dgg+Hp8QYslJWrypqvOc+qAjr2vYokS0EnJ6Z167mhs02CKChTEAbX6pUStJh6oyTvki8c8eCb7peuGou+plPi3XMZjolp2JK1lcEB0rZlcpN0vQEqUK+21erwZdhdjQcaQt3BYAfHH8ZWklIv3nSNIOLzpyq3h2obRFKB/iQT3tFxS5CB82iLExKN19p8OeN1PjnX2ssSL796ln1XQSTQxYp8X0Uu+uEApY50UOuhLCMfENKe/refVEZbQdGP/L5Mo8GKwAGs84rdMNrrUHmL99fzN52uMEUgh4nUNFiomA90sNxVJ2cFGYJlGlhXgGzJIqiHoRIf1lhb/mIomcCR6ZNJdULL2/i8reKrQ2Frm3E21g822IDQpElVsNPyeQLrISubQf2Mf57TYqyfKIplke4EbQnIZfRuzcSO/1JpK16dyo3/38r/Pb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:50:46.6742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a2c6ad-be08-4df3-9bf1-08dec6d5bef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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

From: Alex Hung <alex.hung@amd.com>

Add KUnit tests for the backlight helpers in amdgpu_dm_backlight.c.

Tests cover:
- amdgpu_dm_update_backlight_caps(): short-circuit on populated caps
  and default value assignment
- get_brightness_range(): NULL, PWM-only, and AUX backlight paths
- convert_brightness_to_user(): minimum clamp, maximum passthrough,
  and mid-range rescaling
- convert_brightness_from_user(): linear rescaling, AUX path, and
  custom-curve mapping
- convert_custom_brightness(): exact match, below-first, interpolation,
  above-last, single data point, zero lower luminance, and the
  debug-mask and no-data-point guards
- amdgpu_dm_update_connector_ext_caps(): negative bl_idx and non-eDP
  early returns, OLED defaults, luminance range copy, and the
  amdgpu_backlight force-AUX/force-PWM overrides
- amdgpu_dm_should_create_sysfs(): forced ABM, non-eDP, missing
  backlight index, and AUX vs PWM backlight
- amdgpu_dm_setup_backlight_device(): non-eDP/LVDS skip, disconnected
  link skip, eDP-count limit, and the successful eDP setup path

Assisted-by: Copilot:Claude-Opus-4.8

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |   71 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |   18 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |    2 +
 .../tests/amdgpu_dm_backlight_test.c          | 1128 +++++++++++++++++
 4 files changed, 1210 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 3770e8dafdbf..f101aed75bb3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -47,6 +47,7 @@
 
 #include "amdgpu_dm_trace.h"
 #include "amd_shared.h"
+#include "amdgpu_dm_kunit_helpers.h"
 
 #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
 #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
@@ -92,9 +93,11 @@ void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 	caps->caps_valid = true;
 #endif
 }
+EXPORT_IF_KUNIT(amdgpu_dm_update_backlight_caps);
 
-static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
-				unsigned int *min, unsigned int *max)
+STATIC_IFN_KUNIT
+int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
+			 unsigned int *min, unsigned int *max)
 {
 	if (!caps)
 		return 0;
@@ -110,6 +113,7 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 	}
 	return 1;
 }
+EXPORT_IF_KUNIT(get_brightness_range);
 
 /* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
 static inline u32 scale_input_to_fw(int min, int max, u64 input)
@@ -123,9 +127,10 @@ static inline u32 scale_fw_to_input(int min, int max, u64 input)
 	return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MAX_BL_LEVEL);
 }
 
-static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
-				      unsigned int min, unsigned int max,
-				      uint32_t *user_brightness)
+STATIC_IFN_KUNIT
+void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
+			       unsigned int min, unsigned int max,
+			       uint32_t *user_brightness)
 {
 	u32 brightness = scale_input_to_fw(min, max, *user_brightness);
 	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
@@ -187,8 +192,11 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
 					     DIV_ROUND_CLOSEST(lum * brightness, 101));
 }
 
-static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
-					uint32_t brightness)
+EXPORT_IF_KUNIT(convert_custom_brightness);
+
+STATIC_IFN_KUNIT
+u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
+				uint32_t brightness)
 {
 	unsigned int min, max;
 
@@ -201,8 +209,11 @@ static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *c
 	return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
 }
 
-static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
-				      uint32_t brightness)
+EXPORT_IF_KUNIT(convert_brightness_from_user);
+
+STATIC_IFN_KUNIT
+u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
+			      uint32_t brightness)
 {
 	unsigned int min, max;
 
@@ -215,6 +226,7 @@ static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *cap
 	return DIV_ROUND_CLOSEST_ULL((u64)max * (brightness - min),
 				 max - min);
 }
+EXPORT_IF_KUNIT(convert_brightness_to_user);
 
 static struct dc_stream_state *dm_find_stream_with_link(
 	struct amdgpu_display_manager *dm,
@@ -529,6 +541,7 @@ void amdgpu_dm_update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 		}
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_update_connector_ext_caps);
 
 void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 			    struct amdgpu_dm_connector *aconnector)
@@ -561,6 +574,7 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 					   dm->adev->mode_info.abm_level_property,
 					   ABM_SYSFS_CONTROL);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_setup_backlight_device);
 
 /**
  * DOC: panel power savings
@@ -658,3 +672,42 @@ amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *amdgpu_dm_connector)
 
 	return true;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_should_create_sysfs);
+
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+uint amdgpu_dm_get_dc_debug_mask(void)
+{
+	return amdgpu_dc_debug_mask;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_get_dc_debug_mask);
+
+void amdgpu_dm_set_dc_debug_mask(uint val)
+{
+	amdgpu_dc_debug_mask = val;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_set_dc_debug_mask);
+
+int amdgpu_dm_get_abm_level_param(void)
+{
+	return amdgpu_dm_abm_level;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_get_abm_level_param);
+
+void amdgpu_dm_set_abm_level_param(int val)
+{
+	amdgpu_dm_abm_level = val;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_set_abm_level_param);
+
+int amdgpu_dm_get_backlight_param(void)
+{
+	return amdgpu_backlight;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_get_backlight_param);
+
+void amdgpu_dm_set_backlight_param(int val)
+{
+	amdgpu_backlight = val;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_set_backlight_param);
+#endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index acff23f9feef..5234da6ae484 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -41,4 +41,22 @@ bool amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *aconnector);
 
 extern const struct attribute_group amdgpu_group;
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
+			 unsigned int *min, unsigned int *max);
+void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
+			       unsigned int min, unsigned int max,
+			       uint32_t *user_brightness);
+u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
+				 uint32_t brightness);
+u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
+			       uint32_t brightness);
+uint amdgpu_dm_get_dc_debug_mask(void);
+void amdgpu_dm_set_dc_debug_mask(uint val);
+int amdgpu_dm_get_abm_level_param(void);
+void amdgpu_dm_set_abm_level_param(int val);
+int amdgpu_dm_get_backlight_param(void);
+void amdgpu_dm_set_backlight_param(int val);
+#endif
+
 #endif /* __AMDGPU_DM_BACKLIGHT_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index 4365d4024f70..ddd9fce66232 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -8,12 +8,14 @@ ccflags-y += -I$(src)/../../include
 ccflags-y += -I$(src)/../../modules/inc
 ccflags-y += -I$(src)/../../dc
 ccflags-y += -I$(src)/../../../amdgpu
+ccflags-y += -I$(src)/../../../amdkfd
 ccflags-y += -I$(src)/../../../include
 
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crc_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_hdcp_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_color_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_colorop_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_backlight_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_psr_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_replay_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_ism_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
new file mode 100644
index 000000000000..2f4293cfd478
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -0,0 +1,1128 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_backlight.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+
+#include "dc.h"
+#include "amdgpu.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
+#include "amdgpu_dm_backlight.h"
+#include "amd_shared.h"
+
+struct dm_backlight_connector_fixture {
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+};
+
+static struct amdgpu_display_manager *alloc_test_dm(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm);
+
+	return dm;
+}
+
+static void setup_test_connector(struct kunit *test,
+				 struct dm_backlight_connector_fixture *fixture,
+				 int bl_idx, enum signal_type signal)
+{
+	fixture->adev = kunit_kzalloc(test, sizeof(*fixture->adev), GFP_KERNEL);
+	fixture->aconnector = kunit_kzalloc(test, sizeof(*fixture->aconnector), GFP_KERNEL);
+	fixture->link = kunit_kzalloc(test, sizeof(*fixture->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->aconnector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->link);
+
+	fixture->aconnector->bl_idx = bl_idx;
+	fixture->aconnector->dc_link = fixture->link;
+	fixture->aconnector->base.dev = &fixture->adev->ddev;
+	fixture->link->connector_signal = signal;
+}
+
+/* Tests for amdgpu_dm_update_backlight_caps() */
+
+/**
+ * dm_test_backlight_caps_valid_short_circuit - Test Backlight caps valid short circuit
+ * @test: The KUnit test context
+ */
+static void dm_test_backlight_caps_valid_short_circuit(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = alloc_test_dm(test);
+	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[0];
+
+	caps->caps_valid = true;
+	caps->aux_support = false;
+	caps->min_input_signal = 42;
+	caps->max_input_signal = 199;
+
+	amdgpu_dm_update_backlight_caps(dm, 0);
+
+	KUNIT_EXPECT_TRUE(test, caps->caps_valid);
+	KUNIT_EXPECT_EQ(test, caps->min_input_signal, 42);
+	KUNIT_EXPECT_EQ(test, caps->max_input_signal, 199);
+}
+
+#if !defined(CONFIG_ACPI)
+
+/**
+ * dm_test_backlight_caps_aux_support_noop - Test Backlight caps aux support noop
+ * @test: The KUnit test context
+ */
+static void dm_test_backlight_caps_aux_support_noop(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = alloc_test_dm(test);
+	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[0];
+
+	caps->caps_valid = false;
+	caps->aux_support = true;
+	caps->min_input_signal = 11;
+	caps->max_input_signal = 222;
+
+	amdgpu_dm_update_backlight_caps(dm, 0);
+
+	KUNIT_EXPECT_FALSE(test, caps->caps_valid);
+	KUNIT_EXPECT_EQ(test, caps->min_input_signal, 11);
+	KUNIT_EXPECT_EQ(test, caps->max_input_signal, 222);
+}
+
+/**
+ * dm_test_backlight_caps_non_aux_sets_defaults - Test Backlight caps non aux sets defaults
+ * @test: The KUnit test context
+ */
+static void dm_test_backlight_caps_non_aux_sets_defaults(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = alloc_test_dm(test);
+	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[0];
+
+	caps->caps_valid = false;
+	caps->aux_support = false;
+	caps->min_input_signal = 0;
+	caps->max_input_signal = 0;
+
+	amdgpu_dm_update_backlight_caps(dm, 0);
+
+	KUNIT_EXPECT_TRUE(test, caps->caps_valid);
+	KUNIT_EXPECT_EQ(test, caps->min_input_signal, 12);
+	KUNIT_EXPECT_EQ(test, caps->max_input_signal, 255);
+}
+#endif
+
+/* Tests for get_brightness_range() */
+
+/**
+ * dm_test_brightness_range_null_caps - Test Brightness range null caps
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_range_null_caps(struct kunit *test)
+{
+	unsigned int min = 99, max = 99;
+
+	KUNIT_EXPECT_EQ(test, get_brightness_range(NULL, &min, &max), 0);
+	/* min/max should remain untouched */
+	KUNIT_EXPECT_EQ(test, min, 99U);
+	KUNIT_EXPECT_EQ(test, max, 99U);
+}
+
+/**
+ * dm_test_brightness_range_pwm - Test Brightness range pwm
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_range_pwm(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int min, max;
+
+	caps.aux_support = false;
+	caps.min_input_signal = 12;
+	caps.max_input_signal = 255;
+
+	KUNIT_EXPECT_EQ(test, get_brightness_range(&caps, &min, &max), 1);
+	/* 0x101 * 12 = 3084, 0x101 * 255 = 65535 */
+	KUNIT_EXPECT_EQ(test, min, 0x101U * 12);
+	KUNIT_EXPECT_EQ(test, max, 0x101U * 255);
+}
+
+/**
+ * dm_test_brightness_range_aux - Test Brightness range aux
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_range_aux(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int min, max;
+
+	caps.aux_support = true;
+	caps.aux_min_input_signal = 1;
+	caps.aux_max_input_signal = 512;
+
+	KUNIT_EXPECT_EQ(test, get_brightness_range(&caps, &min, &max), 1);
+	/* millinits: 1000 * value */
+	KUNIT_EXPECT_EQ(test, min, 1000U);
+	KUNIT_EXPECT_EQ(test, max, 512000U);
+}
+
+/* Tests for convert_brightness_to_user() */
+
+/**
+ * dm_test_brightness_to_user_null_caps - Test Brightness to user null caps
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_to_user_null_caps(struct kunit *test)
+{
+	/*
+	 * With NULL caps, get_brightness_range fails → passthrough.
+	 * We simulate this by passing a zeroed caps struct where
+	 * max_input_signal=0 makes max=0 and the function hits
+	 * get_brightness_range returning 0 since caps is NULL.
+	 */
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_user(NULL, 42), 42U);
+}
+
+/**
+ * dm_test_brightness_to_user_below_min - Test Brightness to user below min
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_to_user_below_min(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+
+	caps.aux_support = false;
+	caps.min_input_signal = 12;
+	caps.max_input_signal = 255;
+
+	/* brightness < min (0x101*12 = 3084), should return 0 */
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_user(&caps, 100), 0U);
+}
+
+/**
+ * dm_test_brightness_to_user_at_max - Test Brightness to user at max
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_to_user_at_max(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int min, max;
+
+	caps.aux_support = false;
+	caps.min_input_signal = 12;
+	caps.max_input_signal = 255;
+
+	get_brightness_range(&caps, &min, &max);
+
+	/* At max → should return max */
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_user(&caps, max), max);
+}
+
+/**
+ * dm_test_brightness_to_user_at_min - Test Brightness to user at min
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_to_user_at_min(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int min, max;
+
+	caps.aux_support = false;
+	caps.min_input_signal = 12;
+	caps.max_input_signal = 255;
+
+	get_brightness_range(&caps, &min, &max);
+
+	/* At min → should return 0 */
+	KUNIT_EXPECT_EQ(test, convert_brightness_to_user(&caps, min), 0U);
+}
+
+/**
+ * dm_test_brightness_to_user_midpoint_pwm - Test Brightness to user midpoint pwm
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_to_user_midpoint_pwm(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int min, max, mid_hw, result;
+	u64 expected;
+
+	caps.aux_support = false;
+	caps.min_input_signal = 12;
+	caps.max_input_signal = 255;
+
+	get_brightness_range(&caps, &min, &max);
+
+	/* midpoint of hw range */
+	mid_hw = min + (max - min) / 2;
+	/* expected = DIV_ROUND_CLOSEST_ULL((u64)max * (mid_hw - min), max - min) */
+	expected = DIV_ROUND_CLOSEST_ULL((u64)max * (mid_hw - min), max - min);
+	result = convert_brightness_to_user(&caps, mid_hw);
+
+	KUNIT_EXPECT_EQ(test, result, (u32)expected);
+}
+
+/* Tests for convert_brightness_from_user() — no custom curve */
+
+/**
+ * dm_test_brightness_from_user_null_caps - Test Brightness from user null caps
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_from_user_null_caps(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(NULL, 100), 100U);
+}
+
+/**
+ * dm_test_brightness_from_user_zero - Test Brightness from user zero
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_from_user_zero(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int min, max;
+
+	caps.aux_support = false;
+	caps.min_input_signal = 12;
+	caps.max_input_signal = 255;
+	/* no custom curve */
+	caps.data_points = 0;
+
+	get_brightness_range(&caps, &min, &max);
+
+	/* brightness=0 → min + 0 = min */
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), (u32)min);
+}
+
+/**
+ * dm_test_brightness_from_user_max - Test Brightness from user max
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_from_user_max(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int min, max;
+
+	caps.aux_support = false;
+	caps.min_input_signal = 12;
+	caps.max_input_signal = 255;
+	caps.data_points = 0;
+
+	get_brightness_range(&caps, &min, &max);
+
+	/*
+	 * brightness=max → min + DIV_ROUND_CLOSEST((max-min)*max, max)
+	 *               = min + (max - min) = max
+	 */
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, max), (u32)max);
+}
+
+/**
+ * dm_test_brightness_from_user_aux - Test Brightness from user aux
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_from_user_aux(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int min, max;
+
+	caps.aux_support = true;
+	caps.aux_min_input_signal = 1;
+	caps.aux_max_input_signal = 512;
+	caps.data_points = 0;
+
+	get_brightness_range(&caps, &min, &max);
+
+	/* brightness=0 → min */
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 0), (u32)min);
+	/* brightness=max → max */
+	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, max), (u32)max);
+}
+
+/* Tests for convert_custom_brightness() */
+
+/**
+ * dm_test_custom_brightness_no_data_points - Test Custom brightness no data points
+ * @test: The KUnit test context
+ */
+static void dm_test_custom_brightness_no_data_points(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	uint32_t brightness = 128;
+	uint32_t saved = brightness;
+
+	caps.data_points = 0;
+
+	convert_custom_brightness(&caps, 3084, 65535, &brightness);
+
+	/* No data points → no-op */
+	KUNIT_EXPECT_EQ(test, brightness, saved);
+}
+
+/**
+ * dm_test_custom_brightness_debug_mask_disables - Test Custom brightness debug mask disables
+ * @test: The KUnit test context
+ */
+static void dm_test_custom_brightness_debug_mask_disables(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	uint32_t brightness = 128;
+	uint32_t saved = brightness;
+	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
+
+	caps.data_points = 3;
+	caps.luminance_data[0].input_signal = 50;
+	caps.luminance_data[0].luminance = 10;
+
+	/* Set the disable flag */
+	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() | DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+
+	convert_custom_brightness(&caps, 3084, 65535, &brightness);
+
+	/* Should be no-op due to debug mask */
+	KUNIT_EXPECT_EQ(test, brightness, saved);
+
+	amdgpu_dm_set_dc_debug_mask(saved_mask);
+}
+
+/**
+ * dm_test_custom_brightness_exact_match - Test Custom brightness exact match
+ * @test: The KUnit test context
+ */
+static void dm_test_custom_brightness_exact_match(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	uint32_t brightness;
+	unsigned int min, max;
+	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
+
+	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+
+	caps.aux_support = false;
+	caps.min_input_signal = 0;
+	caps.max_input_signal = 255;
+	caps.data_points = 3;
+	caps.luminance_data[0].input_signal = 50;
+	caps.luminance_data[0].luminance = 20;
+	caps.luminance_data[1].input_signal = 128;
+	caps.luminance_data[1].luminance = 50;
+	caps.luminance_data[2].input_signal = 200;
+	caps.luminance_data[2].luminance = 90;
+
+	get_brightness_range(&caps, &min, &max);
+
+	/*
+	 * Set brightness so that scale_input_to_fw yields exactly 128.
+	 * scale_input_to_fw(min, max, x) = DIV_ROUND_CLOSEST(x * 255, max - min)
+	 * With min=0, max=0x101*255=65535:
+	 * We need x such that DIV_ROUND_CLOSEST(x * 255, 65535) = 128
+	 * → x = 128 * 65535 / 255 = 32896
+	 */
+	brightness = 32896;
+
+	convert_custom_brightness(&caps, min, max, &brightness);
+
+	/*
+	 * Exact match: lum=50, brightness_scaled=128
+	 * result = scale_fw_to_input(min, max, DIV_ROUND_CLOSEST(50*128, 101))
+	 *        = scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(6400, 101))
+	 *        = scale_fw_to_input(0, 65535, 63)
+	 *        = 0 + DIV_ROUND_CLOSEST(63 * 65535, 255) = 16191 (approx)
+	 */
+	KUNIT_EXPECT_TRUE(test, brightness != 32896);
+	KUNIT_EXPECT_TRUE(test, brightness < 32896);
+
+	amdgpu_dm_set_dc_debug_mask(saved_mask);
+}
+
+/**
+ * dm_test_custom_brightness_below_first - Test Custom brightness below first
+ * @test: The KUnit test context
+ */
+static void dm_test_custom_brightness_below_first(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	uint32_t brightness;
+	unsigned int min, max;
+	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
+
+	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+
+	caps.aux_support = false;
+	caps.min_input_signal = 0;
+	caps.max_input_signal = 255;
+	caps.data_points = 2;
+	caps.luminance_data[0].input_signal = 100;
+	caps.luminance_data[0].luminance = 40;
+	caps.luminance_data[1].input_signal = 200;
+	caps.luminance_data[1].luminance = 80;
+
+	get_brightness_range(&caps, &min, &max);
+
+	/*
+	 * Set brightness low enough that scaled value < 100.
+	 * scale_input_to_fw(0, 65535, x) = DIV_ROUND_CLOSEST(x*255, 65535)
+	 * For result=50: x = 50*65535/255 = 12850
+	 */
+	brightness = 12850;
+
+	convert_custom_brightness(&caps, min, max, &brightness);
+
+	/*
+	 * Below first data point: lum = DIV_ROUND_CLOSEST(40 * 50, 100) = 20
+	 * Then: scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(20 * 50, 101))
+	 *      = scale_fw_to_input(0, 65535, DIV_ROUND_CLOSEST(1000, 101))
+	 *      = scale_fw_to_input(0, 65535, 10)
+	 * The output should be significantly less than input.
+	 */
+	KUNIT_EXPECT_TRUE(test, brightness < 12850);
+
+	amdgpu_dm_set_dc_debug_mask(saved_mask);
+}
+
+/**
+ * dm_test_custom_brightness_interpolation - Test Custom brightness interpolation
+ * @test: The KUnit test context
+ */
+static void dm_test_custom_brightness_interpolation(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	uint32_t brightness;
+	unsigned int min, max;
+	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
+
+	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+
+	caps.aux_support = false;
+	caps.min_input_signal = 0;
+	caps.max_input_signal = 255;
+	caps.data_points = 2;
+	caps.luminance_data[0].input_signal = 50;
+	caps.luminance_data[0].luminance = 20;
+	caps.luminance_data[1].input_signal = 200;
+	caps.luminance_data[1].luminance = 80;
+
+	get_brightness_range(&caps, &min, &max);
+
+	/*
+	 * Choose a value between data points 50 and 200.
+	 * scale_input_to_fw(0, 65535, x) = 125 when x = 125*65535/255 = 32125
+	 */
+	brightness = 32125;
+
+	convert_custom_brightness(&caps, min, max, &brightness);
+
+	/*
+	 * The function should interpolate between data points and produce
+	 * a remapped value different from the input.
+	 */
+	KUNIT_EXPECT_TRUE(test, brightness != 32125);
+
+	amdgpu_dm_set_dc_debug_mask(saved_mask);
+}
+
+/**
+ * dm_test_custom_brightness_above_last - Test Custom brightness above last data point
+ * @test: The KUnit test context
+ */
+static void dm_test_custom_brightness_above_last(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	uint32_t brightness;
+	unsigned int min, max;
+	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
+
+	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+
+	caps.aux_support = false;
+	caps.min_input_signal = 0;
+	caps.max_input_signal = 255;
+	caps.data_points = 2;
+	caps.luminance_data[0].input_signal = 50;
+	caps.luminance_data[0].luminance = 20;
+	caps.luminance_data[1].input_signal = 150;
+	caps.luminance_data[1].luminance = 60;
+
+	get_brightness_range(&caps, &min, &max);
+
+	/*
+	 * Choose brightness above the last data point (150).
+	 * scale_input_to_fw(0, 65535, x) = 220 when x = 220*65535/255 = 56533
+	 * After binary search, left >= data_points, clamped → right==left,
+	 * so lum = upper_lum = 60.
+	 */
+	brightness = 56533;
+
+	convert_custom_brightness(&caps, min, max, &brightness);
+
+	/* Output should differ from input (remapped via curve) */
+	KUNIT_EXPECT_TRUE(test, brightness != 56533);
+	KUNIT_EXPECT_TRUE(test, brightness < 56533);
+
+	amdgpu_dm_set_dc_debug_mask(saved_mask);
+}
+
+/**
+ * dm_test_custom_brightness_single_data_point - Test Custom brightness with single data point
+ * @test: The KUnit test context
+ */
+static void dm_test_custom_brightness_single_data_point(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	uint32_t brightness;
+	unsigned int min, max;
+	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
+
+	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+
+	caps.aux_support = false;
+	caps.min_input_signal = 0;
+	caps.max_input_signal = 255;
+	caps.data_points = 1;
+	caps.luminance_data[0].input_signal = 128;
+	caps.luminance_data[0].luminance = 50;
+
+	get_brightness_range(&caps, &min, &max);
+
+	/*
+	 * Brightness below the single data point triggers the
+	 * "below first" path: lum = DIV_ROUND_CLOSEST(50 * scaled, 128).
+	 * scale_input_to_fw(0, 65535, x) = 64 when x = 64*65535/255 = 16448
+	 */
+	brightness = 16448;
+
+	convert_custom_brightness(&caps, min, max, &brightness);
+
+	KUNIT_EXPECT_TRUE(test, brightness < 16448);
+
+	amdgpu_dm_set_dc_debug_mask(saved_mask);
+}
+
+/**
+ * dm_test_custom_brightness_lower_lum_zero - Test Custom brightness with zero lower luminance
+ * @test: The KUnit test context
+ */
+static void dm_test_custom_brightness_lower_lum_zero(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	uint32_t brightness;
+	unsigned int min, max;
+	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
+
+	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+
+	caps.aux_support = false;
+	caps.min_input_signal = 0;
+	caps.max_input_signal = 255;
+	caps.data_points = 2;
+	caps.luminance_data[0].input_signal = 50;
+	caps.luminance_data[0].luminance = 0;	/* zero lower luminance */
+	caps.luminance_data[1].input_signal = 200;
+	caps.luminance_data[1].luminance = 80;
+
+	get_brightness_range(&caps, &min, &max);
+
+	/*
+	 * Choose brightness between data points to trigger interpolation.
+	 * scale_input_to_fw(0, 65535, x) = 125 when x = 125*65535/255 = 32125
+	 * With lower_lum == 0, code takes shortcut: lum = upper_lum = 80.
+	 */
+	brightness = 32125;
+
+	convert_custom_brightness(&caps, min, max, &brightness);
+
+	/* Should remap; result should differ from input */
+	KUNIT_EXPECT_TRUE(test, brightness != 32125);
+
+	amdgpu_dm_set_dc_debug_mask(saved_mask);
+}
+
+/**
+ * dm_test_brightness_to_user_above_max - Test Brightness to user above max
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_to_user_above_max(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int min, max, result;
+
+	caps.aux_support = false;
+	caps.min_input_signal = 12;
+	caps.max_input_signal = 255;
+
+	get_brightness_range(&caps, &min, &max);
+
+	/* brightness above max → result > max (linear extrapolation) */
+	result = convert_brightness_to_user(&caps, max + 1000);
+
+	KUNIT_EXPECT_GT(test, result, max);
+}
+
+/**
+ * dm_test_brightness_from_user_midrange - Test Brightness from user mid-range value
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_from_user_midrange(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int min, max;
+	u32 result;
+
+	caps.aux_support = false;
+	caps.min_input_signal = 12;
+	caps.max_input_signal = 255;
+	caps.data_points = 0;
+
+	get_brightness_range(&caps, &min, &max);
+
+	/* Mid-range brightness should map to between min and max */
+	result = convert_brightness_from_user(&caps, max / 2);
+
+	KUNIT_EXPECT_GE(test, result, min);
+	KUNIT_EXPECT_LE(test, result, max);
+}
+
+/**
+ * dm_test_brightness_from_user_with_curve - Test Brightness from user with custom curve active
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_from_user_with_curve(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int min, max;
+	u32 with_curve, without_curve;
+	uint saved_mask = amdgpu_dm_get_dc_debug_mask();
+
+	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() & ~DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+
+	caps.aux_support = false;
+	caps.min_input_signal = 0;
+	caps.max_input_signal = 255;
+	caps.data_points = 2;
+	caps.luminance_data[0].input_signal = 50;
+	caps.luminance_data[0].luminance = 20;
+	caps.luminance_data[1].input_signal = 200;
+	caps.luminance_data[1].luminance = 80;
+
+	get_brightness_range(&caps, &min, &max);
+
+	with_curve = convert_brightness_from_user(&caps, max / 2);
+
+	/* Now disable the curve and compare */
+	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() | DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
+	without_curve = convert_brightness_from_user(&caps, max / 2);
+
+	/* Custom curve should produce a different mapping */
+	KUNIT_EXPECT_NE(test, with_curve, without_curve);
+
+	amdgpu_dm_set_dc_debug_mask(saved_mask);
+}
+
+/**
+ * dm_test_brightness_range_zero_signals - Test Brightness range with zero min and max signals
+ * @test: The KUnit test context
+ */
+static void dm_test_brightness_range_zero_signals(struct kunit *test)
+{
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int min = 99, max = 99;
+
+	caps.aux_support = false;
+	caps.min_input_signal = 0;
+	caps.max_input_signal = 0;
+
+	/* Both signals zero → min=max=0 */
+	KUNIT_EXPECT_EQ(test, get_brightness_range(&caps, &min, &max), 1);
+	KUNIT_EXPECT_EQ(test, min, 0U);
+	KUNIT_EXPECT_EQ(test, max, 0U);
+}
+
+/* Tests for amdgpu_dm_update_connector_ext_caps() */
+
+/**
+ * dm_test_update_connector_ext_caps_negative_bl_idx - Test negative backlight index early return
+ * @test: The KUnit test context
+ */
+static void dm_test_update_connector_ext_caps_negative_bl_idx(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconnector);
+
+	aconnector->bl_idx = -1;
+
+	amdgpu_dm_update_connector_ext_caps(aconnector);
+
+	KUNIT_SUCCEED(test);
+}
+
+/**
+ * dm_test_update_connector_ext_caps_non_edp - Test non-eDP connector early return
+ * @test: The KUnit test context
+ */
+static void dm_test_update_connector_ext_caps_non_edp(struct kunit *test)
+{
+	struct dm_backlight_connector_fixture fixture = {};
+
+	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_HDMI_TYPE_A);
+	fixture.adev->dm.backlight_caps[0].aux_support = true;
+
+	amdgpu_dm_update_connector_ext_caps(fixture.aconnector);
+
+	KUNIT_EXPECT_TRUE(test, fixture.adev->dm.backlight_caps[0].aux_support);
+	KUNIT_EXPECT_PTR_EQ(test, fixture.adev->dm.backlight_caps[0].ext_caps, NULL);
+}
+
+/**
+ * dm_test_update_connector_ext_caps_oled_defaults - Test OLED eDP defaults to AUX backlight
+ * @test: The KUnit test context
+ */
+static void dm_test_update_connector_ext_caps_oled_defaults(struct kunit *test)
+{
+	struct dm_backlight_connector_fixture fixture = {};
+	int saved_backlight = amdgpu_dm_get_backlight_param();
+
+	amdgpu_dm_set_backlight_param(-1);
+	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_EDP);
+	fixture.link->dpcd_sink_ext_caps.bits.oled = 1;
+
+	amdgpu_dm_update_connector_ext_caps(fixture.aconnector);
+
+	KUNIT_EXPECT_PTR_EQ(test, fixture.adev->dm.backlight_caps[0].ext_caps,
+			    &fixture.link->dpcd_sink_ext_caps);
+	KUNIT_EXPECT_TRUE(test, fixture.adev->dm.backlight_caps[0].aux_support);
+	KUNIT_EXPECT_EQ(test, fixture.link->backlight_control_type,
+			BACKLIGHT_CONTROL_AMD_AUX);
+	KUNIT_EXPECT_EQ(test, fixture.adev->dm.backlight_caps[0].aux_max_input_signal, 512);
+	KUNIT_EXPECT_EQ(test, fixture.adev->dm.backlight_caps[0].aux_min_input_signal, 1);
+
+	amdgpu_dm_set_backlight_param(saved_backlight);
+}
+
+/**
+ * dm_test_update_connector_ext_caps_luminance_values - Test luminance range copy
+ * @test: The KUnit test context
+ */
+static void dm_test_update_connector_ext_caps_luminance_values(struct kunit *test)
+{
+	struct dm_backlight_connector_fixture fixture = {};
+	int saved_backlight = amdgpu_dm_get_backlight_param();
+
+	amdgpu_dm_set_backlight_param(-1);
+	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_EDP);
+	fixture.aconnector->base.display_info.luminance_range.min_luminance = 2;
+	fixture.aconnector->base.display_info.luminance_range.max_luminance = 400;
+
+	amdgpu_dm_update_connector_ext_caps(fixture.aconnector);
+
+	KUNIT_EXPECT_FALSE(test, fixture.adev->dm.backlight_caps[0].aux_support);
+	KUNIT_EXPECT_EQ(test, fixture.adev->dm.backlight_caps[0].aux_max_input_signal, 400);
+	KUNIT_EXPECT_EQ(test, fixture.adev->dm.backlight_caps[0].aux_min_input_signal, 2);
+
+	amdgpu_dm_set_backlight_param(saved_backlight);
+}
+
+/**
+ * dm_test_update_connector_ext_caps_force_aux - Test module parameter forces AUX backlight
+ * @test: The KUnit test context
+ */
+static void dm_test_update_connector_ext_caps_force_aux(struct kunit *test)
+{
+	struct dm_backlight_connector_fixture fixture = {};
+	int saved_backlight = amdgpu_dm_get_backlight_param();
+
+	amdgpu_dm_set_backlight_param(1);
+	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_EDP);
+
+	amdgpu_dm_update_connector_ext_caps(fixture.aconnector);
+
+	KUNIT_EXPECT_TRUE(test, fixture.adev->dm.backlight_caps[0].aux_support);
+	KUNIT_EXPECT_EQ(test, fixture.link->backlight_control_type,
+			BACKLIGHT_CONTROL_AMD_AUX);
+
+	amdgpu_dm_set_backlight_param(saved_backlight);
+}
+
+/**
+ * dm_test_update_connector_ext_caps_force_pwm - Test module parameter forces PWM backlight
+ * @test: The KUnit test context
+ */
+static void dm_test_update_connector_ext_caps_force_pwm(struct kunit *test)
+{
+	struct dm_backlight_connector_fixture fixture = {};
+	int saved_backlight = amdgpu_dm_get_backlight_param();
+
+	amdgpu_dm_set_backlight_param(0);
+	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_EDP);
+	fixture.link->dpcd_sink_ext_caps.bits.oled = 1;
+
+	amdgpu_dm_update_connector_ext_caps(fixture.aconnector);
+
+	KUNIT_EXPECT_FALSE(test, fixture.adev->dm.backlight_caps[0].aux_support);
+	KUNIT_EXPECT_NE(test, fixture.link->backlight_control_type,
+			BACKLIGHT_CONTROL_AMD_AUX);
+
+	amdgpu_dm_set_backlight_param(saved_backlight);
+}
+
+/* Tests for amdgpu_dm_should_create_sysfs() */
+
+/**
+ * dm_test_should_create_sysfs_abm_forced - Test forced ABM disables sysfs
+ * @test: The KUnit test context
+ */
+static void dm_test_should_create_sysfs_abm_forced(struct kunit *test)
+{
+	struct dm_backlight_connector_fixture fixture = {};
+	int saved_abm_level = amdgpu_dm_get_abm_level_param();
+
+	amdgpu_dm_set_abm_level_param(1);
+	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_EDP);
+	fixture.aconnector->base.connector_type = DRM_MODE_CONNECTOR_eDP;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_should_create_sysfs(fixture.aconnector));
+
+	amdgpu_dm_set_abm_level_param(saved_abm_level);
+}
+
+/**
+ * dm_test_should_create_sysfs_non_edp - Test non-eDP connector disables sysfs
+ * @test: The KUnit test context
+ */
+static void dm_test_should_create_sysfs_non_edp(struct kunit *test)
+{
+	struct dm_backlight_connector_fixture fixture = {};
+	int saved_abm_level = amdgpu_dm_get_abm_level_param();
+
+	amdgpu_dm_set_abm_level_param(-1);
+	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_HDMI_TYPE_A);
+	fixture.aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_should_create_sysfs(fixture.aconnector));
+
+	amdgpu_dm_set_abm_level_param(saved_abm_level);
+}
+
+/**
+ * dm_test_should_create_sysfs_no_backlight_index - Test eDP without backlight index enables sysfs
+ * @test: The KUnit test context
+ */
+static void dm_test_should_create_sysfs_no_backlight_index(struct kunit *test)
+{
+	struct dm_backlight_connector_fixture fixture = {};
+	int saved_abm_level = amdgpu_dm_get_abm_level_param();
+
+	amdgpu_dm_set_abm_level_param(-1);
+	setup_test_connector(test, &fixture, -1, SIGNAL_TYPE_EDP);
+	fixture.aconnector->base.connector_type = DRM_MODE_CONNECTOR_eDP;
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_should_create_sysfs(fixture.aconnector));
+
+	amdgpu_dm_set_abm_level_param(saved_abm_level);
+}
+
+/**
+ * dm_test_should_create_sysfs_aux_backlight - Test AUX backlight disables sysfs
+ * @test: The KUnit test context
+ */
+static void dm_test_should_create_sysfs_aux_backlight(struct kunit *test)
+{
+	struct dm_backlight_connector_fixture fixture = {};
+	int saved_abm_level = amdgpu_dm_get_abm_level_param();
+
+	amdgpu_dm_set_abm_level_param(-1);
+	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_EDP);
+	fixture.aconnector->base.connector_type = DRM_MODE_CONNECTOR_eDP;
+	fixture.adev->dm.backlight_caps[0].aux_support = true;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_should_create_sysfs(fixture.aconnector));
+
+	amdgpu_dm_set_abm_level_param(saved_abm_level);
+}
+
+/**
+ * dm_test_should_create_sysfs_pwm_backlight - Test PWM backlight enables sysfs
+ * @test: The KUnit test context
+ */
+static void dm_test_should_create_sysfs_pwm_backlight(struct kunit *test)
+{
+	struct dm_backlight_connector_fixture fixture = {};
+	int saved_abm_level = amdgpu_dm_get_abm_level_param();
+
+	amdgpu_dm_set_abm_level_param(-1);
+	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_EDP);
+	fixture.aconnector->base.connector_type = DRM_MODE_CONNECTOR_eDP;
+	fixture.adev->dm.backlight_caps[0].aux_support = false;
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_should_create_sysfs(fixture.aconnector));
+
+	amdgpu_dm_set_abm_level_param(saved_abm_level);
+}
+
+/* Tests for amdgpu_dm_setup_backlight_device() */
+
+/**
+ * dm_test_setup_backlight_device_non_edp - Test non-eDP/LVDS link is skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_setup_backlight_device_non_edp(struct kunit *test)
+{
+	struct dm_backlight_connector_fixture fixture = {};
+	struct amdgpu_display_manager *dm;
+
+	setup_test_connector(test, &fixture, -1, SIGNAL_TYPE_HDMI_TYPE_A);
+	fixture.link->type = dc_connection_single;
+	dm = &fixture.adev->dm;
+	dm->adev = fixture.adev;
+	dm->num_of_edps = 0;
+
+	amdgpu_dm_setup_backlight_device(dm, fixture.aconnector);
+
+	/* Non-eDP/LVDS signal → no backlight setup */
+	KUNIT_EXPECT_EQ(test, dm->num_of_edps, 0);
+	KUNIT_EXPECT_EQ(test, fixture.aconnector->bl_idx, -1);
+}
+
+/**
+ * dm_test_setup_backlight_device_connection_none - Test disconnected link is skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_setup_backlight_device_connection_none(struct kunit *test)
+{
+	struct dm_backlight_connector_fixture fixture = {};
+	struct amdgpu_display_manager *dm;
+
+	setup_test_connector(test, &fixture, -1, SIGNAL_TYPE_EDP);
+	fixture.link->type = dc_connection_none;
+	dm = &fixture.adev->dm;
+	dm->adev = fixture.adev;
+	dm->num_of_edps = 0;
+
+	amdgpu_dm_setup_backlight_device(dm, fixture.aconnector);
+
+	/* Disconnected link → no backlight setup */
+	KUNIT_EXPECT_EQ(test, dm->num_of_edps, 0);
+	KUNIT_EXPECT_EQ(test, fixture.aconnector->bl_idx, -1);
+}
+
+/**
+ * dm_test_setup_backlight_device_max_edps - Test setup is skipped when at eDP limit
+ * @test: The KUnit test context
+ */
+static void dm_test_setup_backlight_device_max_edps(struct kunit *test)
+{
+	struct dm_backlight_connector_fixture fixture = {};
+	struct amdgpu_display_manager *dm;
+
+	setup_test_connector(test, &fixture, -1, SIGNAL_TYPE_EDP);
+	fixture.link->type = dc_connection_single;
+	dm = &fixture.adev->dm;
+	dm->adev = fixture.adev;
+	dm->num_of_edps = AMDGPU_DM_MAX_NUM_EDP;
+
+	amdgpu_dm_setup_backlight_device(dm, fixture.aconnector);
+
+	/* Already at the eDP limit → no additional setup */
+	KUNIT_EXPECT_EQ(test, dm->num_of_edps, AMDGPU_DM_MAX_NUM_EDP);
+	KUNIT_EXPECT_EQ(test, fixture.aconnector->bl_idx, -1);
+}
+
+/**
+ * dm_test_setup_backlight_device_oled_success - Test successful eDP backlight setup
+ * @test: The KUnit test context
+ */
+static void dm_test_setup_backlight_device_oled_success(struct kunit *test)
+{
+	struct dm_backlight_connector_fixture fixture = {};
+	struct amdgpu_display_manager *dm;
+	int saved_backlight = amdgpu_dm_get_backlight_param();
+
+	amdgpu_dm_set_backlight_param(-1);
+	setup_test_connector(test, &fixture, -1, SIGNAL_TYPE_EDP);
+	fixture.link->type = dc_connection_single;
+	/* OLED panel avoids the ABM property attach path */
+	fixture.link->dpcd_sink_ext_caps.bits.oled = 1;
+	dm = &fixture.adev->dm;
+	dm->adev = fixture.adev;
+	dm->num_of_edps = 0;
+
+	amdgpu_dm_setup_backlight_device(dm, fixture.aconnector);
+
+	KUNIT_EXPECT_EQ(test, dm->num_of_edps, 1);
+	KUNIT_EXPECT_EQ(test, fixture.aconnector->bl_idx, 0);
+	KUNIT_EXPECT_PTR_EQ(test, (void *)dm->backlight_link[0],
+			    (void *)fixture.link);
+	KUNIT_EXPECT_TRUE(test, dm->backlight_caps[0].aux_support);
+
+	amdgpu_dm_set_backlight_param(saved_backlight);
+}
+
+static struct kunit_case dm_backlight_test_cases[] = {
+	KUNIT_CASE(dm_test_backlight_caps_valid_short_circuit),
+#if !defined(CONFIG_ACPI)
+	KUNIT_CASE(dm_test_backlight_caps_aux_support_noop),
+	KUNIT_CASE(dm_test_backlight_caps_non_aux_sets_defaults),
+#endif
+	/* get_brightness_range */
+	KUNIT_CASE(dm_test_brightness_range_null_caps),
+	KUNIT_CASE(dm_test_brightness_range_pwm),
+	KUNIT_CASE(dm_test_brightness_range_aux),
+	/* convert_brightness_to_user */
+	KUNIT_CASE(dm_test_brightness_to_user_null_caps),
+	KUNIT_CASE(dm_test_brightness_to_user_below_min),
+	KUNIT_CASE(dm_test_brightness_to_user_at_max),
+	KUNIT_CASE(dm_test_brightness_to_user_at_min),
+	KUNIT_CASE(dm_test_brightness_to_user_midpoint_pwm),
+	/* convert_brightness_from_user */
+	KUNIT_CASE(dm_test_brightness_from_user_null_caps),
+	KUNIT_CASE(dm_test_brightness_from_user_zero),
+	KUNIT_CASE(dm_test_brightness_from_user_max),
+	KUNIT_CASE(dm_test_brightness_from_user_aux),
+	/* convert_custom_brightness */
+	KUNIT_CASE(dm_test_custom_brightness_no_data_points),
+	KUNIT_CASE(dm_test_custom_brightness_debug_mask_disables),
+	KUNIT_CASE(dm_test_custom_brightness_exact_match),
+	KUNIT_CASE(dm_test_custom_brightness_below_first),
+	KUNIT_CASE(dm_test_custom_brightness_interpolation),
+	KUNIT_CASE(dm_test_custom_brightness_above_last),
+	KUNIT_CASE(dm_test_custom_brightness_single_data_point),
+	KUNIT_CASE(dm_test_custom_brightness_lower_lum_zero),
+	KUNIT_CASE(dm_test_brightness_to_user_above_max),
+	KUNIT_CASE(dm_test_brightness_from_user_midrange),
+	KUNIT_CASE(dm_test_brightness_from_user_with_curve),
+	KUNIT_CASE(dm_test_brightness_range_zero_signals),
+	/* amdgpu_dm_update_connector_ext_caps */
+	KUNIT_CASE(dm_test_update_connector_ext_caps_negative_bl_idx),
+	KUNIT_CASE(dm_test_update_connector_ext_caps_non_edp),
+	KUNIT_CASE(dm_test_update_connector_ext_caps_oled_defaults),
+	KUNIT_CASE(dm_test_update_connector_ext_caps_luminance_values),
+	KUNIT_CASE(dm_test_update_connector_ext_caps_force_aux),
+	KUNIT_CASE(dm_test_update_connector_ext_caps_force_pwm),
+	/* amdgpu_dm_should_create_sysfs */
+	KUNIT_CASE(dm_test_should_create_sysfs_abm_forced),
+	KUNIT_CASE(dm_test_should_create_sysfs_non_edp),
+	KUNIT_CASE(dm_test_should_create_sysfs_no_backlight_index),
+	KUNIT_CASE(dm_test_should_create_sysfs_aux_backlight),
+	KUNIT_CASE(dm_test_should_create_sysfs_pwm_backlight),
+	/* amdgpu_dm_setup_backlight_device */
+	KUNIT_CASE(dm_test_setup_backlight_device_non_edp),
+	KUNIT_CASE(dm_test_setup_backlight_device_connection_none),
+	KUNIT_CASE(dm_test_setup_backlight_device_max_edps),
+	KUNIT_CASE(dm_test_setup_backlight_device_oled_success),
+	{}
+};
+
+static struct kunit_suite dm_backlight_test_suite = {
+	.name = "amdgpu_dm_backlight",
+	.test_cases = dm_backlight_test_cases,
+};
+
+kunit_test_suite(dm_backlight_test_suite);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_backlight");
+MODULE_AUTHOR("AMD");
-- 
2.43.0

