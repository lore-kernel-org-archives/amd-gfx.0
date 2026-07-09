Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98913C4450A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01F3910F71B;
	Thu,  9 Jul 2026 21:03:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="einbd/60";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F171710F6FF
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7CN916hsnbHOu0pTiDFelrCncEb9wPy95GGX/rEIi339Y4Z0Qtwh8StxoA1komtiPdfDWN17VwuxE3eYhTM/vSg4aILrPal6DU2hKrK0ArF2eXfAEil/QL6bqyLJaF57Di6+R2Xn/OPUeydVmpPZlf4Xt+12xFJ81TQm0OqQaLQuYywPvbcH98uy/SaPXEcPYGrzBoFXvjB+6+ACn7XMkHxxyL+dAWV7KiIPKclOkx7Fiu9WcT3v5v6yJqsJg9SyteVZun6NYYDep3nfsEsORUYzMv+3MIZKQ8JGh89fnj3wBeNNzOQwNVrU08fh0U+S2ogm60Q9hyqJJPqIBmCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B2lGsKFpvuYl8+O66Jon0KjGJ1mttJ7r8Gb1W7YpgA=;
 b=GaW9AqzpeWmS00nJlKp/IYDAN10o4HS77SoSeCZXioozQIy/aw3PVwrqpBc5lRPdYY3UhvA1ZoJTBMittIi8Ev1SZCBkCKKrmifZx7XchoLa0ffCiosfnQV8LGstNsqLEzF+fVBN5SCq2ceF3FCNtF0LZ8D5u1bIZJK5pU8UyZ5JDNHnNz9u6JXJ2tW7jYbSegbcb9Xe0pGkl7xclNNhglslzgY2tkv24LzC36fGI2b062TMFt6fvecvHAJXSIEDuLeco+o+jVtGxU9KMHJnpvfyMwUbWHtMWzRJmseQFSLuNExx1ut7fnxNp5QzZG1ivFxGZ2SLQ/LxwkoYMKhtww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B2lGsKFpvuYl8+O66Jon0KjGJ1mttJ7r8Gb1W7YpgA=;
 b=einbd/60Y5rJdYQcm6xBeglzvYaYAajuC2vZpq8wKY2TFiHhKj8tu0nEEVRH9g7xddGkqCVeLCYKbId0pnp6WPy3tIvDysGTnHICfphGnemz1b31dyG0oxNytgzZFtOoKrSJF5CDDhzQjYIiSSekzyxdGqWOTkW49YlPv72oYwM=
Received: from MN2PR07CA0002.namprd07.prod.outlook.com (2603:10b6:208:1a0::12)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 21:02:35 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::1e) by MN2PR07CA0002.outlook.office365.com
 (2603:10b6:208:1a0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:35 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:23 -0500
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
Subject: [PATCH 62/80] drm/amd/display: Test backlight level programming path
Date: Thu, 9 Jul 2026 16:48:30 -0400
Message-ID: <20260709205936.5719-63-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CY5PR12MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 69648909-a110-4618-9ad8-08deddfd66df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jcgGdkIOEJMRRGaoTbdUonz0zT0K8k2nBxPKBjwVlUNszW0KvnsKrN9LrFQ23qZdGpj5HJKl0mCX2oJz3rshPvpriHDscuGknlTvuW59xTbaWeLI9gnLV73YKFnkjBQ/WG3S/LqWaGBnialYVFC0FKwSvk9tZiInmS8Ze7j/gCQyDR7EReoBAg7Wdkwnkbzx1ylLVxW8QhVYshmF4AbAPBvYL0WPH5AiHBvvIvdmqJnr7/Q3IkRMcTB2ME0X0fsi8cY1+/ggwQc4o6lc4j3ub2R70+gQhVk2v/C5r7n5Ebrx61LD5A4v8N7rjxvkWClgGTicPmZWpl6DU45A1T89YLDW7VJ+AUdFcCmYkGkkLUV3xXQfxx9wpjw0E2MAOY37iKQkur1qEgz46LyuEXF9PGl87RgHNd3bw6MZMdVxfpLKc3949O279h5xl0SY5ceIoT/jc2yQFR/vrJ8TRfTHbNXpVXhhTEA8cfbPQrn3wwkVWuFVTDUwOV62IRKNBKLWkgSqRWUOPJpgAwjjDrvGOlZfGd4Y5jUAG4nPSR+jQhZgfPOVHaT4TXdZ6NZYpdjWXcgE5JtigoT7MkPAYClMsqyBEX+j9p2+4Dde2EQuv/BzhF90KBLIo4IGd9YhzlLjUeqnyXCXuVNdm4bPKWQyTQdgpwzDp0fRAgQcxMA5LFV7MXOrfqWeYBDtwpE9d/yRPlAGvsaVda90zULCglSMsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nR/HTUCVv2XTerqTERKJtIaN58jbduVIoRQKAVbuyme8PYQgPLv9kA3slt7fuGaXjGcLhcvlaUNXz3KAIzLrOQkZ9CyBGlNu/oLYTe6D9jW/g6cA8oFdPRYHjK9JwRD0AQVP1+dYwGX5WJl7yL+ME1EUmzsN5VZiYNegjoDPk+AWwdrYHc2glTUYzLsbCgKrkPLpiHgnR1MBc9jiyyBmhj1jJwhTPPg3khI52G0AFtPygttohy3lyIXFUbLxPJz3q9i0k/wSkoikwePMh2xfZWMpEHKO2E7j2LEnjK6sq6Uf5yQBM3m7kDUnRuPU/dcg5aAV9TUOwZsBzWzNjNbiqsErfdAh+sbc5hJiGtHuZDIuxoAGADcwJObc0b6C6BDDVeMKwM6ZkWUqPX/qZTTM7hED/H8+uVyZzezuU4qEtZ/T/nfm3mUbM2fIa7DiJuKF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:35.5151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69648909-a110-4618-9ad8-08deddfd66df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381
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
Add KUnit coverage for the backlight level write path in
amdgpu_dm_backlight.c.

Tests cover stream lookup hit/miss, the connector-off and no-stream early
returns, and the AUX/PWM/idle-reallow programming branches. The DC
programming calls stay safe by injecting a NULL power module and keeping
idle optimizations a no-op via disable_idle_power_optimizations.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |   9 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |   5 +
 .../tests/amdgpu_dm_backlight_test.c          | 260 ++++++++++++++++++
 3 files changed, 272 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index ca60c72855fd..d35b90912bd2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -219,7 +219,8 @@ u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
 }
 EXPORT_IF_KUNIT(convert_brightness_to_user);
 
-static struct dc_stream_state *dm_find_stream_with_link(
+STATIC_IFN_KUNIT
+struct dc_stream_state *dm_find_stream_with_link(
 	struct amdgpu_display_manager *dm,
 	struct dc_link *link)
 {
@@ -235,6 +236,7 @@ static struct dc_stream_state *dm_find_stream_with_link(
 
 	return NULL;
 }
+EXPORT_IF_KUNIT(dm_find_stream_with_link);
 
 STATIC_IFN_KUNIT
 int amdgpu_dm_backlight_get_device_index(struct amdgpu_display_manager *dm,
@@ -346,8 +348,10 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	if (rc)
 		dm->actual_brightness[bl_idx] = user_brightness;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_backlight_set_level);
 
-static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
+STATIC_IFN_KUNIT
+int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
 	int i = amdgpu_dm_backlight_get_device_index(dm, bd);
@@ -356,6 +360,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_backlight_update_status);
 
 static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
 					 int bl_idx)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 98d612c60ae9..5fbaf67369f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -28,6 +28,8 @@ struct amdgpu_display_manager;
 struct amdgpu_dm_connector;
 struct backlight_device;
 struct backlight_properties;
+struct dc_link;
+struct dc_stream_state;
 struct drm_connector;
 struct attribute_group;
 
@@ -49,6 +51,9 @@ bool amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *aconnector);
 extern const struct attribute_group amdgpu_group;
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+struct dc_stream_state *dm_find_stream_with_link(struct amdgpu_display_manager *dm,
+						 struct dc_link *link);
+int amdgpu_dm_backlight_update_status(struct backlight_device *bd);
 int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 			 unsigned int *min, unsigned int *max);
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 8ebc0f263e3e..732ac8db742d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -9,6 +9,7 @@
 #include <linux/backlight.h>
 
 #include "dc.h"
+#include "dc_dmub_srv.h"
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
@@ -40,6 +41,255 @@ static void setup_test_connector(struct kunit *test,
 	fixture->link->connector_signal = signal;
 }
 
+static void setup_test_dm_ddev(struct kunit *test, struct amdgpu_display_manager *dm)
+{
+	struct drm_device *ddev;
+
+	ddev = kunit_kzalloc(test, sizeof(*ddev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ddev);
+
+	INIT_LIST_HEAD(&ddev->mode_config.connector_list);
+	spin_lock_init(&ddev->mode_config.connector_list_lock);
+	dm->ddev = ddev;
+}
+
+/* Tests for dm_find_stream_with_link() */
+
+/**
+ * dm_test_find_stream_with_link_returns_match - Test matching stream lookup
+ * @test: The KUnit test context
+ */
+static void dm_test_find_stream_with_link_returns_match(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dc_link *other_link = dm_kunit_alloc_link(test);
+	struct dc_link *target_link = dm_kunit_alloc_link(test);
+	struct dc_stream_state *stream;
+
+	dm_kunit_add_stream_to_state(test, dm->dc->current_state, 0, other_link);
+	dm_kunit_add_stream_to_state(test, dm->dc->current_state, 1, target_link);
+	stream = dm_find_stream_with_link(dm, target_link);
+
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	KUNIT_EXPECT_PTR_EQ(test, stream->link, target_link);
+}
+
+/**
+ * dm_test_find_stream_with_link_missing - Test missing stream lookup
+ * @test: The KUnit test context
+ */
+static void dm_test_find_stream_with_link_missing(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dc_link *stream_link = dm_kunit_alloc_link(test);
+	struct dc_link *missing_link = dm_kunit_alloc_link(test);
+
+	dm_kunit_add_stream_to_state(test, dm->dc->current_state, 0, stream_link);
+
+	KUNIT_EXPECT_NULL(test, dm_find_stream_with_link(dm, missing_link));
+}
+
+/* Tests for amdgpu_dm_backlight_set_level() */
+
+/**
+ * dm_test_backlight_set_level_connector_off - Test connector-off cache path
+ * @test: The KUnit test context
+ *
+ * If the matching connector has no encoder, set_level() must cache the
+ * requested brightness and return before touching DC or backlight hardware.
+ */
+static void dm_test_backlight_set_level_connector_off(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct amdgpu_dm_connector *aconnector;
+
+	setup_test_dm_ddev(test, dm);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconnector);
+	INIT_LIST_HEAD(&aconnector->base.head);
+	aconnector->bl_idx = 1;
+	aconnector->base.encoder = NULL;
+	list_add_tail(&aconnector->base.head, &dm->ddev->mode_config.connector_list);
+
+	amdgpu_dm_backlight_set_level(dm, 1, 1234);
+
+	KUNIT_EXPECT_EQ(test, dm->brightness[1], 1234U);
+	KUNIT_EXPECT_EQ(test, dm->actual_brightness[1], 0U);
+}
+
+/**
+ * dm_test_backlight_set_level_no_stream - Test no-stream early return
+ * @test: The KUnit test context
+ *
+ * With no stream for the backlight link, set_level() records the requested
+ * brightness and exits before calling the power-module programming path.
+ */
+static void dm_test_backlight_set_level_no_stream(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dc_link *link = dm_kunit_alloc_link(test);
+
+	setup_test_dm_ddev(test, dm);
+	dm->backlight_caps[1].caps_valid = true;
+	dm->backlight_caps[1].min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	dm->backlight_caps[1].max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	dm->backlight_link[1] = link;
+
+	amdgpu_dm_backlight_set_level(dm, 1, 2000);
+
+	KUNIT_EXPECT_EQ(test, dm->brightness[1], 2000U);
+	KUNIT_EXPECT_EQ(test, dm->actual_brightness[1], 0U);
+}
+
+/**
+ * dm_test_backlight_set_level_aux_programs_power_module - Test AUX programming path
+ * @test: The KUnit test context
+ *
+ * With a matching stream present, set_level() walks into the DC programming
+ * path. A NULL power_module makes mod_power_set_backlight_nits() a safe
+ * early-false, and ips_support disabled leaves idle optimizations untouched.
+ * A non-matching connector exercises the connector-list skip, and a non-zero
+ * brightness_mask exercises the quirk-OR path.
+ */
+static void dm_test_backlight_set_level_aux_programs_power_module(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dc_link *link = dm_kunit_alloc_link(test);
+	struct amdgpu_dm_connector *other;
+
+	setup_test_dm_ddev(test, dm);
+	mutex_init(&dm->dc_lock);
+	dm->power_module = NULL;
+
+	/* Non-matching connector exercises the bl_idx skip (continue). */
+	other = kunit_kzalloc(test, sizeof(*other), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, other);
+	INIT_LIST_HEAD(&other->base.head);
+	other->bl_idx = 0;
+	list_add_tail(&other->base.head, &dm->ddev->mode_config.connector_list);
+
+	dm->backlight_caps[1].caps_valid = true;
+	dm->backlight_caps[1].aux_support = true;
+	dm->backlight_caps[1].brightness_mask = 0x3;
+	dm->backlight_caps[1].aux_min_input_signal = 1;
+	dm->backlight_caps[1].aux_max_input_signal = 512;
+	dm->backlight_caps[1].min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	dm->backlight_caps[1].max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	dm->backlight_link[1] = link;
+	dm_kunit_add_stream_to_state(test, dm->dc->current_state, 0, link);
+
+	amdgpu_dm_backlight_set_level(dm, 1, 2000);
+
+	/* power_module is NULL so programming fails; actual stays unchanged. */
+	KUNIT_EXPECT_EQ(test, dm->brightness[1], 2000U);
+	KUNIT_EXPECT_EQ(test, dm->actual_brightness[1], 0U);
+}
+
+/**
+ * dm_test_backlight_set_level_pwm_programs_power_module - Test PWM programming path
+ * @test: The KUnit test context
+ *
+ * With aux_support cleared, set_level() takes the millipercent branch:
+ * get_brightness_range() + mod_power_set_backlight_percent(). A NULL
+ * power_module keeps the call a safe early-false.
+ */
+static void dm_test_backlight_set_level_pwm_programs_power_module(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dc_link *link = dm_kunit_alloc_link(test);
+
+	setup_test_dm_ddev(test, dm);
+	mutex_init(&dm->dc_lock);
+	dm->power_module = NULL;
+
+	dm->backlight_caps[1].caps_valid = true;
+	dm->backlight_caps[1].aux_support = false;
+	dm->backlight_caps[1].min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	dm->backlight_caps[1].max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	dm->backlight_link[1] = link;
+	dm_kunit_add_stream_to_state(test, dm->dc->current_state, 0, link);
+
+	amdgpu_dm_backlight_set_level(dm, 1, 2000);
+
+	KUNIT_EXPECT_EQ(test, dm->brightness[1], 2000U);
+	KUNIT_EXPECT_EQ(test, dm->actual_brightness[1], 0U);
+}
+
+/**
+ * dm_test_backlight_set_level_reallows_idle - Test idle-optimization toggle path
+ * @test: The KUnit test context
+ *
+ * When ips_support is set and dmub idle is allowed, set_level() disables idle
+ * optimizations around the programming call and re-enables them afterwards.
+ * disable_idle_power_optimizations keeps dc_allow_idle_optimizations() a safe
+ * early return, and ctx->logger is wired because DC_LOG_* dereferences it.
+ */
+static void dm_test_backlight_set_level_reallows_idle(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct dc_link *link = dm_kunit_alloc_link(test);
+	struct dc_dmub_srv *dmub_srv;
+	struct dal_logger *logger;
+	struct dc_context *ctx;
+
+	setup_test_dm_ddev(test, dm);
+	mutex_init(&dm->dc_lock);
+	dm->power_module = NULL;
+
+	/* dm_kunit_alloc_dm() leaves dc->ctx NULL; the idle path dereferences it. */
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	dm->dc->ctx = ctx;
+
+	logger = kunit_kzalloc(test, sizeof(*logger), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, logger);
+	logger->dev = &adev->ddev;
+	dm->dc->ctx->logger = logger;
+
+	dmub_srv = kunit_kzalloc(test, sizeof(*dmub_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub_srv);
+	dmub_srv->idle_allowed = true;
+	dm->dc->ctx->dmub_srv = dmub_srv;
+	dm->dc->caps.ips_support = true;
+	/* Keep dc_allow_idle_optimizations() a safe early return. */
+	dm->dc->debug.disable_idle_power_optimizations = true;
+
+	dm->backlight_caps[1].caps_valid = true;
+	dm->backlight_caps[1].aux_support = true;
+	dm->backlight_caps[1].aux_min_input_signal = 1;
+	dm->backlight_caps[1].aux_max_input_signal = 512;
+	dm->backlight_caps[1].min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	dm->backlight_caps[1].max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	dm->backlight_link[1] = link;
+	dm_kunit_add_stream_to_state(test, dm->dc->current_state, 0, link);
+
+	amdgpu_dm_backlight_set_level(dm, 1, 2000);
+
+	KUNIT_EXPECT_EQ(test, dm->brightness[1], 2000U);
+}
+
+/**
+ * dm_test_backlight_update_status_no_stream - Test update_status wrapper
+ * @test: The KUnit test context
+ */
+static void dm_test_backlight_update_status_no_stream(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
+	struct backlight_device *bd;
+
+	setup_test_dm_ddev(test, dm);
+	bd = kunit_kzalloc(test, sizeof(*bd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bd);
+	dev_set_drvdata(&bd->dev, dm);
+	bd->props.brightness = 3456;
+	dm->num_of_edps = 2;
+	dm->backlight_dev[1] = bd;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_update_status(bd), 0);
+	KUNIT_EXPECT_EQ(test, dm->brightness[1], 3456U);
+}
+
 /* Tests for amdgpu_dm_backlight_get_device_index() */
 
 /**
@@ -1200,6 +1450,16 @@ static void dm_test_setup_backlight_device_oled_success(struct kunit *test)
 }
 
 static struct kunit_case dm_backlight_test_cases[] = {
+	/* dm_find_stream_with_link */
+	KUNIT_CASE(dm_test_find_stream_with_link_returns_match),
+	KUNIT_CASE(dm_test_find_stream_with_link_missing),
+	/* amdgpu_dm_backlight_set_level / update_status */
+	KUNIT_CASE(dm_test_backlight_set_level_connector_off),
+	KUNIT_CASE(dm_test_backlight_set_level_no_stream),
+	KUNIT_CASE(dm_test_backlight_set_level_aux_programs_power_module),
+	KUNIT_CASE(dm_test_backlight_set_level_pwm_programs_power_module),
+	KUNIT_CASE(dm_test_backlight_set_level_reallows_idle),
+	KUNIT_CASE(dm_test_backlight_update_status_no_stream),
 	/* amdgpu_dm_backlight_get_device_index */
 	KUNIT_CASE(dm_test_backlight_device_index_matches_second),
 	KUNIT_CASE(dm_test_backlight_device_index_missing_fallback),
-- 
2.55.0

