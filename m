Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A9AC44507
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C41AB10F6E8;
	Thu,  9 Jul 2026 21:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yOW/QP/Y";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C05110F6E8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpaXHjHoPYhyn/faGc9U8pA9y6fm0ayZxxZxo34H8t/e8ExJhaCd8xfurcZwWonmOOkUeSqyFWJisnsUNJ/VEs4vsbXUUMAjSXynUJagtxIXz7vqRU4aO3kgTvJL/13OC7L8YVGLW146meC/h8ewe1BAxd+DC+Ovn+Mk7JA7KUMkJDrwmTTljv60L1DhKBYn9vfYBXEQhZXaxZPn98dZ8Qqfm+6yk9DCBLW/h5ib/kuD/q4un6T/JmH7XwIoS/6rAlnxD8nN4n8WPA/oJVUcMEKdwvqCUgWXXlb8jcLt9AqjRtkmARvZodyoj/MkKgDU6roXdXgAYZkFXSscgbE0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iYXym4IjO9ICK/BVgXRUWFeM2rDEx4BO2HgSKPA/CU=;
 b=xyRkGZFCA2G3zmBMKshzFqQ+Oh8B/MIKuDGQ+6Kmj3iFASCMoUdIDoKpof9S4mvbrpJYY7es+294AeDABdSmLJf59SQwRK4N5FeTJDKIU6HDpgjPLc5iuFeMk4NgvuyqWe6yWcyBSHRu0zGUh1TM1YLNhFeOtvLsAtN1mndt/P7Ta/uv5ECj9Ha1abOVKpTcEDg2GQPtwVnlb2shJJot8iGtUHWN6t0AGMN/MJmmsjqvoal4+05VsCkXpYj+5Qx9/DeIpj6D6J8XowpRIgoyQySjU3bOIYKZKFFA/ipA5ESrXn3ESTdaYwA5nnpP5cRthxrRYl56aUqPIz+Agqq4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iYXym4IjO9ICK/BVgXRUWFeM2rDEx4BO2HgSKPA/CU=;
 b=yOW/QP/YbCRQMiJV/S5/2VkDgOQvOJpSUmY7rjbMS1juSdbEyCvLO0WQp3vC8ePqAfbX+PSEJgRdf/I8gaDEUv2cuNcbZ9DN5W2UMfGO3IpDzhH8TSDTiJvw/0N9eCd0ZoPlsJ1S10iRX3eBHCnj1MZLupyX+tQZK778NY+Nmkw=
Received: from BN9PR03CA0507.namprd03.prod.outlook.com (2603:10b6:408:130::32)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:36 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:130:cafe::92) by BN9PR03CA0507.outlook.office365.com
 (2603:10b6:408:130::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
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
Subject: [PATCH 66/80] drm/amd/display: Test backlight ABM property attach
Date: Thu, 9 Jul 2026 16:48:34 -0400
Message-ID: <20260709205936.5719-67-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3ad324-465a-456a-c99f-08deddfd6746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: omvYSgaIuPq1iH0sgbSncTSJ7OpFFhoaKvBrTl5+ZapNq59S/qSPBSv1/zgYcXylMdak7yF5JACIHHFJ5HSh1PteUkCZXOhf8FmjI9RWf6JC9jNnGYjxmhJyRcZv28tBgFq/oTPlD0ICBen3r9cp8yKW+OyF1vytllDPz4T6PT2lpdjIXTVswqY8++Od+11cQOI90bbi1Zmv5ZmktjQfYS3qblylknbZxAd5EbFrL0F/yy9u4lbbfs5Anrxi6kmudpXCSWOmR3eHZE8IyoTsGTCNq3MGrjNopZWGjcGFVfQIV2TRI33l/EmUi2rv4B21iFpLMaX2qKX1gDZDtqz+q/WsUF+o7nZXsZUWCljIz9XX2RHhA18ufSo5PjtW5AyQarcJmUM6htzzzMqlXZfKjH/f97/MhFAbAf1Db+91wJJWSzbea8idzxnEDSG9J3BNre9GwKEuuYqi/knuc6QLWY189O6NsC6xm8Ps+2Zs1s0p5T5JiyVxAMqlmPAkHNG6XgbMhs/0zMWo44br6Qs14h0hWAlNspNBbxU9Zxf0M/27c2z9/nVIRc9LlcS6l/NslUN2doY8zC1GniGaEuqySt3b5NXZJrReDTnWmpd62OP0mILGW8wLMOsWEjnsZmzsw7FURdLrdj6+ijIXnZLytgcqxkELYg4bC9//baqlkLBYBuU43EoOEp3ZoEUZx1fJDjDhOqYtXGBdWUGU3JS0Ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H3d6bJXbvCNx42vn82tux/QVRnIvFwSZYKD2mo5Dypd6//dR5Nn6I1rfcuuvRxkLv0UxuNvkQz3fDT2XS9f1PWJarF9KHnOBne6ejEhbs5gmURi4SgZFOOtXL87w6n9l6qKZUtwOdRXYnORM+DgvOh0vnSVNgIQlbcj3HkCkSOUUXgbAWuG7EHPIdxZT12tr29txd5H4+KOOBV2U9I8x8BlANaqhc3ZBBZAAXolHzAHdgOmg3r4PcGTowSRgKCD23EZgmJ6D0BVKrpHNl3HY5osohtQf96rfwgGOWgVip6r89wmHHdDzLOLgoI8rIj8ok6pNBFjDSv+CFa2RHCLQTsHBwuTH7ZjFFi/fW+nlcwWYG16Ox9Zyto6vc6Vm39vN8eH/n4zL6Z5AWM+Zyo3rmxWjFejEIsdkX4Yn5B7fGnhttgfAwQWSeHKCeSYg1MmB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:36.1909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3ad324-465a-456a-c99f-08deddfd6746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
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
Cover the eDP success path of amdgpu_dm_setup_backlight_device() where the
ABM level property is attached to the connector. A DRM-managed connector
fixture (drmm_mode_config_init + drmm_connector_init) lets the test verify
that one property is added and that its value is ABM_SYSFS_CONTROL.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../tests/amdgpu_dm_backlight_test.c          | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index b74bbbc7f56f..f55f93747df7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -16,6 +16,7 @@
 #include "dc.h"
 #include "dc_dmub_srv.h"
 #include "amdgpu.h"
+#include "amdgpu_display.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_backlight.h"
@@ -30,6 +31,12 @@ struct dm_backlight_connector_fixture {
 	struct dc_link *link;
 };
 
+static const struct drm_connector_funcs dm_backlight_test_connector_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
 static void setup_test_connector(struct kunit *test,
 				 struct dm_backlight_connector_fixture *fixture,
 				 int bl_idx, enum signal_type signal)
@@ -1787,6 +1794,61 @@ static void dm_test_setup_backlight_device_oled_success(struct kunit *test)
 	amdgpu_dm_set_abm_level_param(saved_abm_level);
 }
 
+/**
+ * dm_test_setup_backlight_device_attaches_abm_property - Test ABM property path
+ * @test: The KUnit test context
+ */
+static void dm_test_setup_backlight_device_attaches_abm_property(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_display_manager *dm;
+	struct amdgpu_device *adev;
+	struct drm_property *prop;
+	struct dc_link *link;
+	int saved_abm_level = amdgpu_dm_get_abm_level_param();
+	int saved_backlight = amdgpu_dm_get_backlight_param();
+	int old_count;
+	int ret;
+
+	amdgpu_dm_set_abm_level_param(-1);
+	amdgpu_dm_set_backlight_param(-1);
+	adev = dm_kunit_alloc_adev(test);
+	ret = drmm_mode_config_init(&adev->ddev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	prop = drm_property_create_range(&adev->ddev, 0, "abm level", 0, 4);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, prop);
+	adev->mode_info.abm_level_property = prop;
+
+	aconnector = dm_kunit_alloc_connector(test, adev, NULL);
+	ret = drmm_connector_init(&adev->ddev, &aconnector->base,
+				   &dm_backlight_test_connector_funcs,
+				   DRM_MODE_CONNECTOR_eDP, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	link = dm_kunit_alloc_link(test);
+	link->connector_signal = SIGNAL_TYPE_EDP;
+	link->type = dc_connection_single;
+	aconnector->dc_link = link;
+	aconnector->bl_idx = -1;
+	dm = &adev->dm;
+	dm->adev = adev;
+	dm->ddev = &adev->ddev;
+	old_count = aconnector->base.base.properties->count;
+
+	amdgpu_dm_setup_backlight_device(dm, aconnector);
+
+	KUNIT_EXPECT_EQ(test, dm->num_of_edps, 1);
+	KUNIT_EXPECT_EQ(test, aconnector->bl_idx, 0);
+	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->count, old_count + 1);
+	KUNIT_EXPECT_PTR_EQ(test, aconnector->base.base.properties->properties[old_count], prop);
+	KUNIT_EXPECT_EQ(test, aconnector->base.base.properties->values[old_count],
+			 (uint64_t)ABM_SYSFS_CONTROL);
+
+	amdgpu_dm_set_backlight_param(saved_backlight);
+	amdgpu_dm_set_abm_level_param(saved_abm_level);
+}
+
 static struct kunit_case dm_backlight_test_cases[] = {
 	/* dm_find_stream_with_link */
 	KUNIT_CASE(dm_test_find_stream_with_link_returns_match),
@@ -1872,6 +1934,7 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_setup_backlight_device_connection_none),
 	KUNIT_CASE(dm_test_setup_backlight_device_max_edps),
 	KUNIT_CASE(dm_test_setup_backlight_device_oled_success),
+	KUNIT_CASE(dm_test_setup_backlight_device_attaches_abm_property),
 	{}
 };
 
-- 
2.55.0

