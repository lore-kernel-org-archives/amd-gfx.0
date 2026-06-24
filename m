Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADBCCDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69CC010F084;
	Wed, 24 Jun 2026 18:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dnMkYt6N";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6932810F084
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFiXv9OYtyJrGjWVtWubvmRnAWP0DJNPbMzJfJ3/Mj9LxJwjIGSTOUHJSsJaLSxAdvo/Y5o2h40iVZnR7d6wEcIG3xMoIrbWuMlplP1h7jvSAjGt6+7y4T4rpIry1KiVkazKwFx+sHquTC6XOdBOzWcA5PHISJHXCqbsWyWGpy9wornooBn8sLtsCU+5Ju53eb5cgQjbita8RLU2WxxASD5HZV1mW+w7gpwAioAgNTQrI1ZjWXkIsZN9jzf+GtAJGhh18id2HYL6bQ4P9SRN86DFFkyq3mDyGWJFoe3f/4Ix4xr7mltmPSf9FLj3E+R8Op3N3xo1dsTJYdQptH9i7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsXmklVW7L7ohY0Sdy1Wo4LZZlLiZIYQVa6FmE39gpA=;
 b=Le6XCIugYBbzo7gQhBGkNm5nulKInEbpyBvMh0zooctpGBqAZf5eYZjvkxhsuxBIgG9yNBXZHioxiLbYUtmS1qJ6iADuwPxsxh6cOhxNNqT0E9Ceo+Rk9QU4MKU1k8WgowTp2sQ0jLRxdmqjiecpihEonoLh42jmpa4mlgGCF2giCe718F8GHJztZupCtQATkwd5+H69DE1MUwiouV+Uc6lEvDVUF0P18cE2h6npKON+8EcRe3jJe894LwibaN5bhQJeUkzUZDWswwL1KpTS5V5QggkkdXQw1BYeGo4M/el0l51f5T/GntgmXWbCYrXNxU2cU1S2245MqOHxFA+FdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsXmklVW7L7ohY0Sdy1Wo4LZZlLiZIYQVa6FmE39gpA=;
 b=dnMkYt6N1uXzjBwJVU74gFft5DiybqE8zyyIomRLGQQWY0wJYdaD1HQ1jy2Y1u3HEGRDwOlJPgCdqhbi+wUWSiG+Tu11M23ryb4Q6/tOLhZlBac9IyGfIam/JeouREOYgzstRcqdoibQAmkW2CAVxakyTyLLDgn+g7PNNDrE/nU=
Received: from SJ0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:a03:33e::23)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 18:09:08 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::45) by SJ0PR03CA0048.outlook.office365.com
 (2603:10b6:a03:33e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Wed,
 24 Jun 2026 18:09:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:08 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:06 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 03/28] drm/amd/display: Extract backlight helpers for KUnit
 tests
Date: Wed, 24 Jun 2026 14:03:01 -0400
Message-ID: <20260624180829.4775-4-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: fb17d62d-8fec-489a-458d-08ded21baf83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6QuFAj+Vwq31PvKFG+E1j9w9URZ6THS3NCpWmY/qC+VPGYi6/jL+4JtSHSLcNQ1eEomsR/x4x7Uv1PCT6xhlp2ey8JJjUX/N8LdL/2m8QxpaoGuBJTRv8OPeoNy96BveLB1gDAyTDgYnHR/FD3haPYTqQ7LhHlMC9Fxm0jXOW6sY107xNnqRQuHhuqEQMaPw3Nid3/7/J5gkDhb8r0ygzm8IH5jCrTk11v4NmxXWlMA2TD9pq+akjRKgEm7SLOxu5tu6OL8HjRvURhYFvzp4VGHhrGyc1tbswXMSTCHrO5RXo7MxC2bu7WbMCPSHdhyjERP8Yq1Eu1FgJe9jNbAzlEZtlS4B4O2PqbvPInKCV+F6XQeVI3YtbYpG7hNZPHkFxa0Urx0lApKmU541y/8dPu2OXB46uvwhJWlhaAcGTLGlFBp7C34On7ymi0UCVecMfKqd2+UzTGd2oah5Mh9axY7fe+aVvGCuSQjuJqa1RhrKr5goBknErLtj3Y83dCweccvPnKkPBJvtPXsIR3KFjVudTKAl+IoRjTNqlRh030Wl7WeZy2+lw4ROAEOqq0Q8NI8S/y/chY3dbh7iKg6CNystatfwySmWM2yRsUDWdjx1p+mq0EZK5rGBjUKaTIMf42NpPRqmwaVjLZAPpPawwCxCeH1C9Cq1yj27wY+V2xEbwkDEC3TOEdSXsrXKcjYlexIloLIaLSQorJYEIEVYQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oEHPtb8jfBWlHx3uErK1gDmOgwPDCcAaCStXkqI0wNDrx7+hbER6YJiQvj4KL+jsInYLEG/8Y415Dcsqy0BuIzg+h2RsyPsaP0yDUXnDqYWs3Aaj+a5BM0ZLBNJQX/HHyDMoYBuYJXTJerJenf+Kz0WYKNRmQDPTdugbIifng5ufTDuNIeXBoSb7l85GZu6J6a5x9CxSY2mbFm6GcHXiHViZlasorZahBypcvAUBv02S3xpp3uBD8EaqZf7nMoajwnWtcfrVtmrns11gT56T4JF1YN0YD/JYoiFdddV74h+Nuyz4v8cnQp/M1yq/DDR5j2tR31Bn5wE4NKHbhsWFniVJEi8kvZHwGHizKVXVYnja77f7DaG+9gFnW0oUu5fwzXvQF+VFnWmAC4IrUtbkJK9ivW4Kzv0GZXfQDfk2cYfeVolXwS0h6Igy45bizcqb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:08.2650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb17d62d-8fec-489a-458d-08ded21baf83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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

[WHAT]
Extract shared backlight device index lookup and property
setup into testable helpers. The duplicated bd-to-index
scan in update_status/get_brightness is replaced by
amdgpu_dm_backlight_get_device_index(), and the inline
backlight_properties calculation is replaced by
amdgpu_dm_backlight_fill_props().

Add KUnit coverage for both new helpers. Keep the runtime
power_supply_is_system_supplied() call at the caller so
the helpers remain pure and deterministic under test.

Assisted-by: Copilot:GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  84 +++++++-----
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |   8 ++
 .../tests/amdgpu_dm_backlight_test.c          | 123 ++++++++++++++++++
 3 files changed, 184 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index f19092a3237e..33f4be403a65 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -236,6 +236,21 @@ static struct dc_stream_state *dm_find_stream_with_link(
 	return NULL;
 }
 
+STATIC_IFN_KUNIT
+int amdgpu_dm_backlight_get_device_index(struct amdgpu_display_manager *dm,
+					 struct backlight_device *bd)
+{
+	int i;
+
+	for (i = 0; i < dm->num_of_edps; i++) {
+		if (bd == dm->backlight_dev[i])
+			return i;
+	}
+
+	return 0;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_backlight_get_device_index);
+
 void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 				   int bl_idx,
 				   u32 user_brightness)
@@ -335,14 +350,8 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
-	int i;
+	int i = amdgpu_dm_backlight_get_device_index(dm, bd);
 
-	for (i = 0; i < dm->num_of_edps; i++) {
-		if (bd == dm->backlight_dev[i])
-			break;
-	}
-	if (i >= AMDGPU_DM_MAX_NUM_EDP)
-		i = 0;
 	amdgpu_dm_backlight_set_level(dm, i, bd->props.brightness);
 
 	return 0;
@@ -377,14 +386,8 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
-	int i;
+	int i = amdgpu_dm_backlight_get_device_index(dm, bd);
 
-	for (i = 0; i < dm->num_of_edps; i++) {
-		if (bd == dm->backlight_dev[i])
-			break;
-	}
-	if (i >= AMDGPU_DM_MAX_NUM_EDP)
-		i = 0;
 	return amdgpu_dm_backlight_get_level(dm, i);
 }
 
@@ -394,6 +397,35 @@ static const struct backlight_ops amdgpu_dm_backlight_ops = {
 	.update_status	= amdgpu_dm_backlight_update_status,
 };
 
+STATIC_IFN_KUNIT
+void amdgpu_dm_backlight_fill_props(const struct amdgpu_dm_backlight_caps *caps,
+				    bool is_system_supplied,
+				    bool custom_curve_enabled,
+				    struct backlight_properties *props)
+{
+	unsigned int min, max;
+
+	if (get_brightness_range(caps, &min, &max)) {
+		if (is_system_supplied)
+			props->brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level,
+							       100);
+		else
+			props->brightness = DIV_ROUND_CLOSEST((max - min) * caps->dc_level,
+							       100);
+		props->max_brightness = max - min;
+	} else {
+		props->brightness = MAX_BACKLIGHT_LEVEL;
+		props->max_brightness = MAX_BACKLIGHT_LEVEL;
+	}
+
+	if (caps && caps->data_points && custom_curve_enabled)
+		props->scale = BACKLIGHT_SCALE_NON_LINEAR;
+	else
+		props->scale = BACKLIGHT_SCALE_LINEAR;
+	props->type = BACKLIGHT_RAW;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_backlight_fill_props);
+
 void
 amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 {
@@ -402,7 +434,6 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	struct backlight_properties props = { 0 };
 	struct amdgpu_dm_backlight_caps *caps;
 	char bl_name[16];
-	int min, max;
 	int real_brightness;
 	int init_brightness;
 
@@ -417,26 +448,17 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	}
 
 	caps = &dm->backlight_caps[aconnector->bl_idx];
-	if (get_brightness_range(caps, &min, &max)) {
-		if (power_supply_is_system_supplied() > 0)
-			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level, 100);
-		else
-			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->dc_level, 100);
-		/* min is zero, so max needs to be adjusted */
-		props.max_brightness = max - min;
-		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
-			caps->ac_level, caps->dc_level);
-	} else
-		props.brightness = props.max_brightness = MAX_BACKLIGHT_LEVEL;
+	amdgpu_dm_backlight_fill_props(caps, power_supply_is_system_supplied() > 0,
+				       !(amdgpu_dc_debug_mask &
+					 DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE),
+				       &props);
+	drm_dbg(drm, "Backlight caps: max_brightness: %d, ac %d, dc %d\n",
+		props.max_brightness, caps->ac_level, caps->dc_level);
 
 	init_brightness = props.brightness;
 
-	if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE)) {
+	if (props.scale == BACKLIGHT_SCALE_NON_LINEAR)
 		drm_info(drm, "Using custom brightness curve\n");
-		props.scale = BACKLIGHT_SCALE_NON_LINEAR;
-	} else
-		props.scale = BACKLIGHT_SCALE_LINEAR;
-	props.type = BACKLIGHT_RAW;
 
 	snprintf(bl_name, sizeof(bl_name), "amdgpu_bl%d",
 		 drm->primary->index + aconnector->bl_idx);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index a6c01b7ccab3..98d612c60ae9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -26,6 +26,8 @@
 
 struct amdgpu_display_manager;
 struct amdgpu_dm_connector;
+struct backlight_device;
+struct backlight_properties;
 struct drm_connector;
 struct attribute_group;
 
@@ -56,6 +58,12 @@ u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 				 uint32_t brightness);
 u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
 			       uint32_t brightness);
+int amdgpu_dm_backlight_get_device_index(struct amdgpu_display_manager *dm,
+					 struct backlight_device *bd);
+void amdgpu_dm_backlight_fill_props(const struct amdgpu_dm_backlight_caps *caps,
+				    bool is_system_supplied,
+				    bool custom_curve_enabled,
+				    struct backlight_properties *props);
 uint amdgpu_dm_get_dc_debug_mask(void);
 void amdgpu_dm_set_dc_debug_mask(uint val);
 int amdgpu_dm_get_abm_level_param(void);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 8763cd635ae1..0e9de940e5a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -6,6 +6,7 @@
  */
 
 #include <kunit/test.h>
+#include <linux/backlight.h>
 
 #include "dc.h"
 #include "amdgpu.h"
@@ -13,6 +14,7 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_backlight.h"
 #include "amd_shared.h"
+#include "dc/inc/hw/panel_cntl.h"
 
 struct dm_backlight_connector_fixture {
 	struct amdgpu_device *adev;
@@ -47,6 +49,51 @@ static void setup_test_connector(struct kunit *test,
 	fixture->link->connector_signal = signal;
 }
 
+/* Tests for amdgpu_dm_backlight_get_device_index() */
+
+/**
+ * dm_test_backlight_device_index_matches_second - Test matching second backlight device
+ * @test: The KUnit test context
+ */
+static void dm_test_backlight_device_index_matches_second(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = alloc_test_dm(test);
+	struct backlight_device *bd0;
+	struct backlight_device *bd1;
+
+	bd0 = kunit_kzalloc(test, sizeof(*bd0), GFP_KERNEL);
+	bd1 = kunit_kzalloc(test, sizeof(*bd1), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, bd0);
+	KUNIT_ASSERT_NOT_NULL(test, bd1);
+
+	dm->num_of_edps = 2;
+	dm->backlight_dev[0] = bd0;
+	dm->backlight_dev[1] = bd1;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_device_index(dm, bd1), 1);
+}
+
+/**
+ * dm_test_backlight_device_index_missing_fallback - Test missing backlight device fallback
+ * @test: The KUnit test context
+ */
+static void dm_test_backlight_device_index_missing_fallback(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = alloc_test_dm(test);
+	struct backlight_device *known_bd;
+	struct backlight_device *unknown_bd;
+
+	known_bd = kunit_kzalloc(test, sizeof(*known_bd), GFP_KERNEL);
+	unknown_bd = kunit_kzalloc(test, sizeof(*unknown_bd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, known_bd);
+	KUNIT_ASSERT_NOT_NULL(test, unknown_bd);
+
+	dm->num_of_edps = 1;
+	dm->backlight_dev[0] = known_bd;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_device_index(dm, unknown_bd), 0);
+}
+
 /* Tests for amdgpu_dm_update_backlight_caps() */
 
 /**
@@ -740,6 +787,75 @@ static void dm_test_brightness_range_zero_signals(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, max, 0U);
 }
 
+/* Tests for amdgpu_dm_backlight_fill_props() */
+
+/**
+ * dm_test_backlight_fill_props_ac_linear - Test AC brightness and linear scale
+ * @test: The KUnit test context
+ */
+static void dm_test_backlight_fill_props_ac_linear(struct kunit *test)
+{
+	struct backlight_properties props = {};
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int min, max;
+
+	caps.min_input_signal = 12;
+	caps.max_input_signal = 255;
+	caps.ac_level = 40;
+	caps.dc_level = 20;
+
+	get_brightness_range(&caps, &min, &max);
+	amdgpu_dm_backlight_fill_props(&caps, true, false, &props);
+
+	KUNIT_EXPECT_EQ(test, props.brightness,
+			 DIV_ROUND_CLOSEST((max - min) * caps.ac_level, 100));
+	KUNIT_EXPECT_EQ(test, props.max_brightness, max - min);
+	KUNIT_EXPECT_EQ(test, props.scale, BACKLIGHT_SCALE_LINEAR);
+	KUNIT_EXPECT_EQ(test, props.type, BACKLIGHT_RAW);
+}
+
+/**
+ * dm_test_backlight_fill_props_dc_nonlinear - Test DC brightness and non-linear scale
+ * @test: The KUnit test context
+ */
+static void dm_test_backlight_fill_props_dc_nonlinear(struct kunit *test)
+{
+	struct backlight_properties props = {};
+	struct amdgpu_dm_backlight_caps caps = {};
+	unsigned int min, max;
+
+	caps.min_input_signal = 12;
+	caps.max_input_signal = 255;
+	caps.ac_level = 40;
+	caps.dc_level = 20;
+	caps.data_points = 2;
+
+	get_brightness_range(&caps, &min, &max);
+	amdgpu_dm_backlight_fill_props(&caps, false, true, &props);
+
+	KUNIT_EXPECT_EQ(test, props.brightness,
+			 DIV_ROUND_CLOSEST((max - min) * caps.dc_level, 100));
+	KUNIT_EXPECT_EQ(test, props.max_brightness, max - min);
+	KUNIT_EXPECT_EQ(test, props.scale, BACKLIGHT_SCALE_NON_LINEAR);
+	KUNIT_EXPECT_EQ(test, props.type, BACKLIGHT_RAW);
+}
+
+/**
+ * dm_test_backlight_fill_props_default_range - Test default properties without caps
+ * @test: The KUnit test context
+ */
+static void dm_test_backlight_fill_props_default_range(struct kunit *test)
+{
+	struct backlight_properties props = {};
+
+	amdgpu_dm_backlight_fill_props(NULL, false, true, &props);
+
+	KUNIT_EXPECT_EQ(test, props.brightness, MAX_BACKLIGHT_LEVEL);
+	KUNIT_EXPECT_EQ(test, props.max_brightness, MAX_BACKLIGHT_LEVEL);
+	KUNIT_EXPECT_EQ(test, props.scale, BACKLIGHT_SCALE_LINEAR);
+	KUNIT_EXPECT_EQ(test, props.type, BACKLIGHT_RAW);
+}
+
 /* Tests for amdgpu_dm_update_connector_ext_caps() */
 
 /**
@@ -1062,6 +1178,9 @@ static void dm_test_setup_backlight_device_oled_success(struct kunit *test)
 }
 
 static struct kunit_case dm_backlight_test_cases[] = {
+	/* amdgpu_dm_backlight_get_device_index */
+	KUNIT_CASE(dm_test_backlight_device_index_matches_second),
+	KUNIT_CASE(dm_test_backlight_device_index_missing_fallback),
 	KUNIT_CASE(dm_test_backlight_caps_valid_short_circuit),
 #if !defined(CONFIG_ACPI)
 	KUNIT_CASE(dm_test_backlight_caps_aux_support_noop),
@@ -1095,6 +1214,10 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_brightness_from_user_midrange),
 	KUNIT_CASE(dm_test_brightness_from_user_with_curve),
 	KUNIT_CASE(dm_test_brightness_range_zero_signals),
+	/* amdgpu_dm_backlight_fill_props */
+	KUNIT_CASE(dm_test_backlight_fill_props_ac_linear),
+	KUNIT_CASE(dm_test_backlight_fill_props_dc_nonlinear),
+	KUNIT_CASE(dm_test_backlight_fill_props_default_range),
 	/* amdgpu_dm_update_connector_ext_caps */
 	KUNIT_CASE(dm_test_update_connector_ext_caps_negative_bl_idx),
 	KUNIT_CASE(dm_test_update_connector_ext_caps_non_edp),
-- 
2.53.0

