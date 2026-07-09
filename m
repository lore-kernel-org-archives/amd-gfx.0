Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C57BC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C170C10F6FD;
	Thu,  9 Jul 2026 21:02:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="05/Y5Njr";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE02A10F709
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBbCWQZgqf4HLKaIK33KTPR3uw2Wl4xC2wYNzEui+FeNInEZagjYuKsFTkh2AtUR7BQDSljKEbFcCPs8aRH8gpzAPo2IuPxGYzrZGBJY/BDhf5/CgmwYSRWglNWB5/N12/1ExWb8D8RVM5MO01Lric5u6M7YOxAtZ9ubrxHbZRomRdtCfmaH3u/jKsZdSCRmcEd/7dn+dfwVj3A++OPvXZGC1S/1aVWZSEIteeKYNFwa/V7nlow/BoZRZHQ5ExfFUL4GhKMXtqqfPJjPrHmji8JMST+VD/IfBwmoxHLe4i+W56XBe1xkPYN2/e0MEb+BRvTXVHoyGFyj6RnmW9tl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uqiI95IUFCjNfCDQnatFX9k4hbNCUfIHIw9mEYtaNQ=;
 b=uZz+JDgaYQwCMvO2yWhd8wc5UhvahVOUchvp9YcqnxdKGpcabS4pudias1WZaWZnjIvCU8BdvB4k8kzQ2HlOq8ubE4x6HITGWOP+e1Fbye5QstNeFHw2VcW/o2BRs1d3vgvrS9c1XlhAoAHHWKWMMyhH8v4xswNrFzht+z6l0OcldJwr9h43xAnOStoAoGxr1i6p4COEJg7m4oIsCBtjvbV4iIWiR9rC2OqT8IaO2q0icSl22wb2x9mNv9pvCteeTbw+XpEZK6exzeJ/ulcGBeda38CIpxnNNSfGWkAMwxsg8zjcGdV7ykSYref7UOpDDKWN9PRPXMXYAcxP1KBDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uqiI95IUFCjNfCDQnatFX9k4hbNCUfIHIw9mEYtaNQ=;
 b=05/Y5NjrRjQ82kTQuhQ2pdGPK+aznk0kEp3VO2jQ6rSbGL3OpPVb3toMW0ipWeFr1YRSOQf0taZOoIcY8rB9j5vDniN9+eXfw9Y0LnfpFf8q+9zWXZghEiS7vvkWHHzL5dKLv+wkFjvEk9elRWBIObW6zVnh0B7eqy+brJ8mNQw=
Received: from MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12) by
 IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 21:02:39 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::1a) by MN2PR01CA0043.outlook.office365.com
 (2603:10b6:208:23f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:36 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:26 -0500
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
Subject: [PATCH 65/80] drm/amd/display: Test panel power savings sysfs
Date: Thu, 9 Jul 2026 16:48:33 -0400
Message-ID: <20260709205936.5719-66-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c23d70-af63-46ce-4c1e-08deddfd672f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|6133799003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 0j94OpgcaaYLMcYJUxofgiQQPZoyN9SdDMqDdjeM4twUrncano/KCmWPIlecQlbrtahtPhP6e2VpNO1ZPz9UwLUw2LYeHji2ukHNUgOq0GrNJeHSH4yzzHbifY8Dh4jGsnCbR+BIlAYooWk1iWN4OupBc/mrUu65i+ek8U9ojrJlatquqN+2+wOHdTd1tULMbBGvbjqyjxw0Li1VSRyw1b0fvz5HoIXGyZtGttX0zcqd0ZJvGPl+5TTv1CsgUomLEjgEUdOEojsXGjrCIZHPM3CwosMzrUFzLEfSzGdAt1ZD1XA+yyYVkEBhvgBMZ6p5ikLipZvJEhTkKmGlh8IhmwFOz2yc6+L07A/6supWdxgF+ZDOlS09NBIqbAiZ06I6Z3EsnaU0RHiLShvZZYzSTwJPPn2qXfN7s3bCe3iEN8UtkFhcul6C0Uvad/nJ+LtdNdOEodZXWvvWF1ECppY6CIcg7LgkorIR3QM8myYGhY8W0bkwAbAb0XDb8mfv1hTv8ZL8qLx9hd+CYdtRWf/SSJiSr+CUDnkE5oupduyJgQwkOnne8hPYmSAefl5B/KUlQcPi9cT8NVg4mIp22qjd5CIgelztTjj5ISl/7nHKMSH3l3Fr2zGdEOQS/QXzlL6VuUeDCytmRTr3s/XMIbJO+JtCgKIE2ixiawOlstEB0JEPzIbxps1LTul7fBHz5TOHcRQfk8KZGMjQZq5HuDd8zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7XrRX+qIKkiIBuZ+8lVvpyvPE1kDQ1/uqNEYxMMTbLklvcohrZqV8BeNh13RFyBIDhxYUKXQrB0E1JNJMoXKThgwARqU9CVJES54jXPHkZ3FKkig4DXkFLR81QIQkbe10hgK9oBcGc6N4cvIrGnJ4tk1Q0C/DgE0mXy6e2Ji984BhgKsTZwcVm9bS8AmlwePUV/aSSFRfeH6IWd9oUDhgOpR2il5ABYwsO1t2Wh6K8WxZGmnUqXInBSuL5LLsL/+n9028G62hXV+bq4LnBSU/sUg8R5YVwX5r79sic8rN8jEoLJH1nqLWzFhB/U6mLqj/TzFl2dn3nHAtgWSeRiLSmQXjdUV/lk+8PWPDLPDcfJe3tiyTgki6EegrnCqyvwiGsshsEEptJsuDrZsanr3NqL7gdm7/M7csxWRTb9ou86d7mMuXbCBiDRJPcp4zakY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:36.0466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c23d70-af63-46ce-4c1e-08deddfd672f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
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
Add KUnit coverage using a DRM-managed connector fixture.

Tests cover show() mapping immediate-disable to 0 and reporting an active
ABM level, and store() handling the disable mapping, the forbidden update,
invalid text, and out-of-range input. show() writes through a page-backed
buffer because sysfs_emit() requires one.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  16 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |   8 +
 .../tests/amdgpu_dm_backlight_test.c          | 177 ++++++++++++++++++
 3 files changed, 195 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 859cbce2cdaf..373ef4d217f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -611,9 +611,10 @@ EXPORT_IF_KUNIT(amdgpu_dm_setup_backlight_device);
  * carefully.
  */
 
-static ssize_t panel_power_savings_show(struct device *device,
-					struct device_attribute *attr,
-					char *buf)
+STATIC_IFN_KUNIT
+ssize_t panel_power_savings_show(struct device *device,
+				 struct device_attribute *attr,
+				 char *buf)
 {
 	struct drm_connector *connector = dev_get_drvdata(device);
 	struct drm_device *dev = connector->dev;
@@ -627,10 +628,12 @@ static ssize_t panel_power_savings_show(struct device *device,
 
 	return sysfs_emit(buf, "%u\n", val);
 }
+EXPORT_IF_KUNIT(panel_power_savings_show);
 
-static ssize_t panel_power_savings_store(struct device *device,
-					 struct device_attribute *attr,
-					 const char *buf, size_t count)
+STATIC_IFN_KUNIT
+ssize_t panel_power_savings_store(struct device *device,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
 	struct drm_connector *connector = dev_get_drvdata(device);
 	struct drm_device *dev = connector->dev;
@@ -660,6 +663,7 @@ static ssize_t panel_power_savings_store(struct device *device,
 
 	return count;
 }
+EXPORT_IF_KUNIT(panel_power_savings_store);
 
 static DEVICE_ATTR_RW(panel_power_savings);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 7b417c79980f..07b75064847c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -30,6 +30,8 @@ struct backlight_device;
 struct backlight_properties;
 struct dc_link;
 struct dc_stream_state;
+struct device;
+struct device_attribute;
 struct drm_connector;
 struct attribute_group;
 
@@ -56,6 +58,12 @@ struct dc_stream_state *dm_find_stream_with_link(struct amdgpu_display_manager *
 int amdgpu_dm_backlight_update_status(struct backlight_device *bd);
 u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx);
 int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd);
+ssize_t panel_power_savings_show(struct device *device,
+				 struct device_attribute *attr,
+				 char *buf);
+ssize_t panel_power_savings_store(struct device *device,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count);
 int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 			 unsigned int *min, unsigned int *max);
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 5a2c32d53487..b74bbbc7f56f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -8,6 +8,11 @@
 #include <kunit/test.h>
 #include <linux/backlight.h>
 
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_mode_config.h>
+#include <drm/drm_property.h>
+
 #include "dc.h"
 #include "dc_dmub_srv.h"
 #include "amdgpu.h"
@@ -458,6 +463,171 @@ static void dm_test_register_backlight_device_negative_index(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, adev->dm.backlight_dev[0]);
 }
 
+static struct drm_connector *setup_panel_power_savings_connector(struct kunit *test,
+							 struct device **device_out,
+							 struct dm_connector_state **state_out)
+{
+	struct dm_connector_state *state;
+	struct drm_connector *connector;
+	struct amdgpu_device *adev;
+	struct device *device;
+	int ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	ret = drmm_mode_config_init(&adev->ddev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	device = kunit_kzalloc(test, sizeof(*device), GFP_KERNEL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, device);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+
+	connector->dev = &adev->ddev;
+	connector->state = &state->base;
+	dev_set_drvdata(device, connector);
+	*device_out = device;
+	*state_out = state;
+
+	return connector;
+}
+
+static void dm_test_free_sysfs_buf(void *data)
+{
+	free_page((unsigned long)data);
+}
+
+static char *dm_test_alloc_sysfs_buf(struct kunit *test)
+{
+	char *buf;
+
+	buf = (char *)get_zeroed_page(GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_free_sysfs_buf, buf), 0);
+
+	return buf;
+}
+
+/* Tests for panel_power_savings_show()/panel_power_savings_store() */
+
+/**
+ * dm_test_panel_power_savings_show_maps_disable_to_zero - Test show output
+ * @test: The KUnit test context
+ */
+static void dm_test_panel_power_savings_show_maps_disable_to_zero(struct kunit *test)
+{
+	struct dm_connector_state *state;
+	struct device *device;
+	char *buf;
+
+	setup_panel_power_savings_connector(test, &device, &state);
+	buf = dm_test_alloc_sysfs_buf(test);
+	state->abm_level = ABM_LEVEL_IMMEDIATE_DISABLE;
+
+	KUNIT_EXPECT_EQ(test, panel_power_savings_show(device, NULL, buf), 2);
+	KUNIT_EXPECT_STREQ(test, buf, "0\n");
+}
+
+/**
+ * dm_test_panel_power_savings_show_reports_level - Test show output for active level
+ * @test: The KUnit test context
+ *
+ * When abm_level is not the immediate-disable sentinel, show() reports the
+ * raw level value.
+ */
+static void dm_test_panel_power_savings_show_reports_level(struct kunit *test)
+{
+	struct dm_connector_state *state;
+	struct device *device;
+	char *buf;
+
+	setup_panel_power_savings_connector(test, &device, &state);
+	buf = dm_test_alloc_sysfs_buf(test);
+	state->abm_level = 3;
+
+	KUNIT_EXPECT_EQ(test, panel_power_savings_show(device, NULL, buf), 2);
+	KUNIT_EXPECT_STREQ(test, buf, "3\n");
+}
+
+/**
+ * dm_test_panel_power_savings_store_sets_disable - Test zero maps to disable
+ * @test: The KUnit test context
+ */
+static void dm_test_panel_power_savings_store_sets_disable(struct kunit *test)
+{
+	struct dm_connector_state *state;
+	struct device *device;
+	size_t count = strlen("0");
+
+	setup_panel_power_savings_connector(test, &device, &state);
+
+	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "0", count),
+			 (ssize_t)count);
+	KUNIT_EXPECT_EQ(test, state->abm_level, ABM_LEVEL_IMMEDIATE_DISABLE);
+}
+
+/**
+ * dm_test_panel_power_savings_store_forbidden - Test forbidden update
+ * @test: The KUnit test context
+ */
+static void dm_test_panel_power_savings_store_forbidden(struct kunit *test)
+{
+	struct dm_connector_state *state;
+	struct device *device;
+
+	setup_panel_power_savings_connector(test, &device, &state);
+	state->abm_sysfs_forbidden = true;
+
+	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "1", 1), -EBUSY);
+}
+
+/**
+ * dm_test_panel_power_savings_store_rejects_invalid_text - Test parse failure
+ * @test: The KUnit test context
+ */
+static void dm_test_panel_power_savings_store_rejects_invalid_text(struct kunit *test)
+{
+	struct drm_connector *connector;
+	struct drm_device *drm;
+	struct device *device;
+
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	drm = kunit_kzalloc(test, sizeof(*drm), GFP_KERNEL);
+	device = kunit_kzalloc(test, sizeof(*device), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, device);
+
+	connector->dev = drm;
+	dev_set_drvdata(device, connector);
+
+	KUNIT_EXPECT_LT(test, panel_power_savings_store(device, NULL, "bad", 3), 0);
+}
+
+/**
+ * dm_test_panel_power_savings_store_rejects_out_of_range - Test range failure
+ * @test: The KUnit test context
+ */
+static void dm_test_panel_power_savings_store_rejects_out_of_range(struct kunit *test)
+{
+	struct drm_connector *connector;
+	struct drm_device *drm;
+	struct device *device;
+
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	drm = kunit_kzalloc(test, sizeof(*drm), GFP_KERNEL);
+	device = kunit_kzalloc(test, sizeof(*device), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, device);
+
+	connector->dev = drm;
+	dev_set_drvdata(device, connector);
+
+	KUNIT_EXPECT_EQ(test, panel_power_savings_store(device, NULL, "5", 1), -EINVAL);
+}
+
 /* Tests for amdgpu_dm_backlight_get_device_index() */
 
 /**
@@ -1636,6 +1806,13 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_backlight_get_brightness_uses_device_index),
 	/* amdgpu_dm_register_backlight_device */
 	KUNIT_CASE(dm_test_register_backlight_device_negative_index),
+	/* panel_power_savings_show / store */
+	KUNIT_CASE(dm_test_panel_power_savings_show_maps_disable_to_zero),
+	KUNIT_CASE(dm_test_panel_power_savings_show_reports_level),
+	KUNIT_CASE(dm_test_panel_power_savings_store_sets_disable),
+	KUNIT_CASE(dm_test_panel_power_savings_store_forbidden),
+	KUNIT_CASE(dm_test_panel_power_savings_store_rejects_invalid_text),
+	KUNIT_CASE(dm_test_panel_power_savings_store_rejects_out_of_range),
 	/* amdgpu_dm_backlight_get_device_index */
 	KUNIT_CASE(dm_test_backlight_device_index_matches_second),
 	KUNIT_CASE(dm_test_backlight_device_index_missing_fallback),
-- 
2.55.0

