Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B682C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C2710F6F3;
	Thu,  9 Jul 2026 21:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VOHIrYyb";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013033.outbound.protection.outlook.com
 [40.93.196.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A37C510F6F6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwPk3n61+qFthih6innac0WZU62NxkE+rrqROT4Gz6p3kNz3W8V3d8nOhFVWbB40DQO7e3xZNZRyeMace9Cj0YKpzgZkjsjDNhD+HnxSCdgBn1uvYztsanzYrL+UgWVKr0mwp1BzHDAv74KErTHDwCTrpNS3aTVIm1HzdQwLtzbIrahJEbBxFwpkNhbILd0yGzRVCm4m/zzp+LfTbO+3GeqnXiPLLQ+dZjXMySZpXm5bReQ59ABhYb28JNtOfrh3QeY0QB3fZQ1X22kx7gFYMPylHshYQoKguEhg+z73Zhhb4ecdSfWndVL2XgJ56mbdb7r5Ntut2E3c1Ts8U6UxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIFrTGPPna3Az8cx9YoU9aZAqIu8DdxOL0OcprxLiUo=;
 b=Me5pBP1znW52Wq45L8tizUh3Bc5AOsZ60Qzsbewt5W+rX36ZFBagX8C75/BnbUjKy0BvtOm62FZ6OlExXCvuCsahjjC2wIHfZ9J0Rn3gYT4ORWv3lyPfeGF6SBAowkp14i/N/R8hJClHd1hVwc9zZ+fDbjUtPDtewsrjutOqvcIFb6sFcoyI3lAwTVO9sSSocaR4oGj4CzrDn6yS2H5L773aW20VhvksNQKh/9XP5euLlsc2h1wv7RYpNf4fQFdtDFmhDqkvPDFORJGKYNinZm2kv8ixbRzkr2hFf0SnG+Mpu19ZY0xkg3W9W4jRW6y8BN3+YNCUuSo+3YKesKajYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIFrTGPPna3Az8cx9YoU9aZAqIu8DdxOL0OcprxLiUo=;
 b=VOHIrYybfJxYe+VGD2hZ3TkWXv7TnGyIUhZeQtO3JySu+OdO++lIDrvezBQlX88MKGzzaY5vW0DpmfL5dv4+DISeH3v5uBr1OmbIzmWk2viPIrSLWumPjc/Ah3QVb230cyTI/oC7xV4a9+o1ya+nXoVtv89/cXJD2m/LvOwwxOs=
Received: from BLAPR03CA0113.namprd03.prod.outlook.com (2603:10b6:208:32a::28)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:37 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::88) by BLAPR03CA0113.outlook.office365.com
 (2603:10b6:208:32a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:37 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:29 -0500
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
Subject: [PATCH 70/80] drm/amd/display: Add crtc matching and panel type tests
 for connector
Date: Thu, 9 Jul 2026 16:48:38 -0400
Message-ID: <20260709205936.5719-71-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2035a7-9ecb-4603-368c-08deddfd67f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: PBHnKqMqa+vEr0JCQ8xqHOwyccX+VTh45Dl1m024eeMM0KC+gYYX77baChdtVSOlP06AiU9kEV3UUXuNoM351sCE4nIfc7sldmDB5oiB/skmTufXUBwmVjW5TH0B0ElqIEkYke8aJOXq+CrpfPzBfMP+07vICfkil+YGHycuZzVIn/8ErNwPEXagIWqAtNcfJa5HnsGKem7dr4e/W0ameQEepFkQmGr4WYOuAPcq5+DKf/voUBEGPEXiBjl4vG9IBgoP7Y05C6FmvBOdM22MdWe62IDRf3o2ZhnQaNfhoqmyXicgp9yq/lzhW0ADe7E997T+9U/j8zfZW3qdD8iDvHUUa82CDAezV0wDA2Z/5/f7+FXvB6OZyDbEQ3ITL5bfgL2H6aKV8nxRWn+U1UKA8ewxrMWlcCsMxVMjzGeZ5FeEeT6DMH7YZDsriAylQ36ajmEfkgdN1DmxZqtuu6YNUQNSw27YGpDUrvFCzGnUFgLd5VVCueOJLv+XQtDrBANf1ovNOVxLeHIGH88qFiEs1UMqTtP5wSNBUMpvc00+iNpF33YYdtblBNS6L51mU9TiXfhXBvcoDRKC0+CV5KU0jDnAMaqeAm0WNWdfhn3DALFeISRDmJPhiBQV1Wpip1AbscJ+qsU+XvLTS75q3JUeX6+G9TjALtJyjy0PBxAA3y5J+cZOkcXuYi2jyIJUQwgH2qY9bbcZm+U3I6dezVnxhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iareSvkXbFTNkyW33QYWy0Ze0sBfDKLJxCH6OFZHKXG3+a0WYg/NE4xA7cEPqxjb8hSTnODEOK3rYryXXd5J53mzKvPcBVGerxgKAzffir6FqvXGxvvVAoO5woYtWNxQKOiI1hy5uAVBODkUi2K7c2YOBS6LX96NVFSQzIARFftnI7g/afq9LptpTywpEyZ37NoPhP1kg/FdNmlY+/IuwZMGJXRvyiFvIxY0Gv8zyDu/A30f/AQ6s6wHVWxxbl4E4QJBcd73P6bNICC4wlhdGyOxGEDO6/nG+qCIBEAiL8jr0ll5hTOvyjrppQtZ2YGSmUx6OCUoQ5hW/RTXiOpKNRX+crwSDdYryURsU+YL2sBOEVqI8nALDVa+jK+BRfOVVptt5oUXI40cpWlhE8vu1INsIC7PYYWy4hOuTUyiKcs4betaAYBWqyc05c+rxlEm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:37.3292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2035a7-9ecb-4603-368c-08deddfd67f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Add KUnit coverage for amdgpu_dm_find_first_crtc_matching_connector():
match, no match, empty state, skipping NULL connector slots, and
returning the first match when several target the same crtc.

Also add coverage for amdgpu_dm_set_panel_type(): VSDB OLED/miniLED,
DPCD OLED/miniLED, Samsung miniLED above and below threshold, and the
default LCD fallback.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   1 +
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   1 +
 .../tests/amdgpu_dm_connector_test.c          | 313 ++++++++++++++++++
 3 files changed, 315 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 2c213bed8a6c..7ce2efb9aaa1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -394,6 +394,7 @@ amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 
 	return NULL;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_find_first_crtc_matching_connector);
 
 STATIC_IFN_KUNIT void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 707308c02820..99b5f20699b4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -149,6 +149,7 @@ int amdgpu_dm_encoder_init(struct drm_device *dev,
 enum drm_mode_subconnector get_subconnector_type(struct dc_link *link);
 void update_subconnector_property(struct amdgpu_dm_connector *aconnector);
 void amdgpu_dm_fbc_init(struct drm_connector *connector);
+void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector);
 enum display_content_type
 get_output_content_type(const struct drm_connector_state *connector_state);
 bool adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 0dcc13e7f0af..6639962dd289 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -6,10 +6,14 @@
  */
 
 #include <kunit/test.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_kunit_helpers.h>
+#include <drm/drm_mode_object.h>
+#include <drm/drm_property.h>
 #include <linux/hdmi.h>
 
 #include "dc.h"
@@ -2896,6 +2900,305 @@ static void dm_test_detect_mst_branch_without_aux(struct kunit *test)
 		amdgpu_dm_detect_mst_link_for_all_connectors(drm), 0);
 }
 
+/* Tests for amdgpu_dm_find_first_crtc_matching_connector() */
+
+/*
+ * Build a minimal drm_atomic_state holding @count connector slots. The
+ * function under test only reads num_connector, connectors[i].ptr and
+ * connectors[i].new_state, so a hand-rolled state is sufficient.
+ */
+static struct drm_atomic_state *
+dm_test_alloc_atomic_state(struct kunit *test, int count)
+{
+	struct drm_atomic_state *state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	state->num_connector = count;
+	if (count) {
+		state->connectors = kunit_kcalloc(test, count,
+						  sizeof(*state->connectors),
+						  GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, state->connectors);
+	}
+
+	return state;
+}
+
+/**
+ * dm_test_find_first_crtc_match - Test find_first_crtc returns matching connector
+ * @test: The KUnit test context
+ */
+static void dm_test_find_first_crtc_match(struct kunit *test)
+{
+	struct drm_atomic_state *state = dm_test_alloc_atomic_state(test, 1);
+	struct drm_connector *connector;
+	struct drm_connector_state *con_state;
+	struct drm_crtc *crtc;
+
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+	con_state = kunit_kzalloc(test, sizeof(*con_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, con_state);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	con_state->crtc = crtc;
+	state->connectors[0].ptr = connector;
+	state->connectors[0].new_state = con_state;
+
+	KUNIT_EXPECT_PTR_EQ(test,
+		amdgpu_dm_find_first_crtc_matching_connector(state, crtc),
+		connector);
+}
+
+/**
+ * dm_test_find_first_crtc_no_match - Test find_first_crtc returns NULL when no crtc matches
+ * @test: The KUnit test context
+ */
+static void dm_test_find_first_crtc_no_match(struct kunit *test)
+{
+	struct drm_atomic_state *state = dm_test_alloc_atomic_state(test, 1);
+	struct drm_connector *connector;
+	struct drm_connector_state *con_state;
+	struct drm_crtc *crtc;
+	struct drm_crtc *other_crtc;
+
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+	con_state = kunit_kzalloc(test, sizeof(*con_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, con_state);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	other_crtc = kunit_kzalloc(test, sizeof(*other_crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, other_crtc);
+
+	con_state->crtc = other_crtc;
+	state->connectors[0].ptr = connector;
+	state->connectors[0].new_state = con_state;
+
+	KUNIT_EXPECT_NULL(test,
+		amdgpu_dm_find_first_crtc_matching_connector(state, crtc));
+}
+
+/**
+ * dm_test_find_first_crtc_empty_state - Test find_first_crtc returns NULL with no connectors
+ * @test: The KUnit test context
+ */
+static void dm_test_find_first_crtc_empty_state(struct kunit *test)
+{
+	struct drm_atomic_state *state = dm_test_alloc_atomic_state(test, 0);
+	struct drm_crtc *crtc;
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	KUNIT_EXPECT_NULL(test,
+		amdgpu_dm_find_first_crtc_matching_connector(state, crtc));
+}
+
+/**
+ * dm_test_find_first_crtc_skips_null_ptr - Test find_first_crtc skips empty connector slots
+ * @test: The KUnit test context
+ */
+static void dm_test_find_first_crtc_skips_null_ptr(struct kunit *test)
+{
+	struct drm_atomic_state *state = dm_test_alloc_atomic_state(test, 2);
+	struct drm_connector *connector;
+	struct drm_connector_state *con_state;
+	struct drm_crtc *crtc;
+
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+	con_state = kunit_kzalloc(test, sizeof(*con_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, con_state);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	/* Slot 0 has no connector (ptr == NULL) and must be skipped. */
+	con_state->crtc = crtc;
+	state->connectors[1].ptr = connector;
+	state->connectors[1].new_state = con_state;
+
+	KUNIT_EXPECT_PTR_EQ(test,
+		amdgpu_dm_find_first_crtc_matching_connector(state, crtc),
+		connector);
+}
+
+/**
+ * dm_test_find_first_crtc_returns_first - Test find_first_crtc returns the first match
+ * @test: The KUnit test context
+ */
+static void dm_test_find_first_crtc_returns_first(struct kunit *test)
+{
+	struct drm_atomic_state *state = dm_test_alloc_atomic_state(test, 2);
+	struct drm_connector *first;
+	struct drm_connector *second;
+	struct drm_connector_state *first_state;
+	struct drm_connector_state *second_state;
+	struct drm_crtc *crtc;
+
+	first = kunit_kzalloc(test, sizeof(*first), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, first);
+	second = kunit_kzalloc(test, sizeof(*second), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, second);
+	first_state = kunit_kzalloc(test, sizeof(*first_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, first_state);
+	second_state = kunit_kzalloc(test, sizeof(*second_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, second_state);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	/* Both connectors target the same crtc; the first one must win. */
+	first_state->crtc = crtc;
+	second_state->crtc = crtc;
+	state->connectors[0].ptr = first;
+	state->connectors[0].new_state = first_state;
+	state->connectors[1].ptr = second;
+	state->connectors[1].new_state = second_state;
+
+	KUNIT_EXPECT_PTR_EQ(test,
+		amdgpu_dm_find_first_crtc_matching_connector(state, crtc),
+		first);
+}
+
+/* Tests for amdgpu_dm_set_panel_type() */
+
+/*
+ * Build an amdgpu_dm_connector registered against a real kunit drm_device that
+ * is embedded in an amdgpu_device, so drm_to_adev()/adev_to_drm() resolve and
+ * the panel_type property can be created, attached and updated for real.
+ */
+struct dm_test_panel_ctx {
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+	struct drm_display_info *display_info;
+};
+
+static struct dm_test_panel_ctx *dm_test_panel_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_panel_ctx *ctx;
+	struct drm_property *prop;
+	struct device *dev;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	ctx->drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						       sizeof(*ctx->adev),
+						       offsetof(struct amdgpu_device, ddev),
+						       DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
+	ctx->adev = drm_to_adev(ctx->drm);
+
+	/* The function under test writes through this property. */
+	prop = drm_property_create_range(ctx->drm, DRM_MODE_PROP_IMMUTABLE,
+					 "panel_type", 0, 0xff);
+	KUNIT_ASSERT_NOT_NULL(test, prop);
+	ctx->drm->mode_config.panel_type_property = prop;
+
+	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	KUNIT_ASSERT_EQ(test,
+		drmm_connector_init(ctx->drm, &ctx->aconnector->base,
+				    &dm_test_connector_funcs,
+				    DRM_MODE_CONNECTOR_eDP, NULL), 0);
+	drm_object_attach_property(&ctx->aconnector->base.base, prop,
+				   DRM_MODE_PANEL_TYPE_UNKNOWN);
+
+	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
+	ctx->aconnector->dc_link = ctx->link;
+
+	ctx->display_info = &ctx->aconnector->base.display_info;
+
+	return ctx;
+}
+
+static uint64_t dm_test_panel_prop_value(struct kunit *test,
+					 struct dm_test_panel_ctx *ctx)
+{
+	uint64_t val = ~0ULL;
+
+	KUNIT_EXPECT_EQ(test,
+		drm_object_property_get_value(&ctx->aconnector->base.base,
+			ctx->drm->mode_config.panel_type_property, &val), 0);
+	return val;
+}
+
+/**
+ * dm_test_set_panel_type_samsung_miniled - Test Samsung luminance heuristic
+ * @test: The KUnit test context
+ *
+ * When no VSDB or DPCD hint is present, a Samsung sink whose first luminance
+ * range is at least 1.5x the second is treated as mini-LED.
+ */
+static void dm_test_set_panel_type_samsung_miniled(struct kunit *test)
+{
+	struct dm_test_panel_ctx *ctx = dm_test_panel_ctx_alloc(test);
+	struct dc_sink *sink;
+
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+	sink->edid_caps.manufacturer_id = DDC_MANUFACTURERNAME_SAMSUNG;
+	ctx->link->local_sink = sink;
+
+	ctx->display_info->amd_vsdb.version = 1;
+	ctx->display_info->amd_vsdb.luminance_range1.max_luminance = 1500;
+	ctx->display_info->amd_vsdb.luminance_range2.max_luminance = 1000;
+
+	amdgpu_dm_set_panel_type(ctx->aconnector);
+
+	KUNIT_EXPECT_EQ(test, (int)ctx->link->panel_type, (int)PANEL_TYPE_MINILED);
+}
+
+/**
+ * dm_test_set_panel_type_samsung_below_threshold - Test Samsung sink below the
+ * mini-LED luminance threshold falls back to LCD
+ * @test: The KUnit test context
+ */
+static void dm_test_set_panel_type_samsung_below_threshold(struct kunit *test)
+{
+	struct dm_test_panel_ctx *ctx = dm_test_panel_ctx_alloc(test);
+	struct dc_sink *sink;
+
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+	sink->edid_caps.manufacturer_id = DDC_MANUFACTURERNAME_SAMSUNG;
+	ctx->link->local_sink = sink;
+
+	ctx->display_info->amd_vsdb.version = 1;
+	ctx->display_info->amd_vsdb.luminance_range1.max_luminance = 1000;
+	ctx->display_info->amd_vsdb.luminance_range2.max_luminance = 1000;
+
+	amdgpu_dm_set_panel_type(ctx->aconnector);
+
+	KUNIT_EXPECT_EQ(test, (int)ctx->link->panel_type, (int)PANEL_TYPE_LCD);
+}
+
+/**
+ * dm_test_set_panel_type_default_lcd - Test default fallback is LCD
+ * @test: The KUnit test context
+ *
+ * With no VSDB, DPCD or DID hints the panel type defaults to LCD.
+ */
+static void dm_test_set_panel_type_default_lcd(struct kunit *test)
+{
+	struct dm_test_panel_ctx *ctx = dm_test_panel_ctx_alloc(test);
+
+	amdgpu_dm_set_panel_type(ctx->aconnector);
+
+	KUNIT_EXPECT_EQ(test, (int)ctx->link->panel_type, (int)PANEL_TYPE_LCD);
+	KUNIT_EXPECT_EQ(test, dm_test_panel_prop_value(test, ctx),
+			(uint64_t)DRM_MODE_PANEL_TYPE_LCD);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -3063,6 +3366,16 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_detect_mst_skips_writeback),
 	KUNIT_CASE(dm_test_detect_mst_non_mst_link),
 	KUNIT_CASE(dm_test_detect_mst_branch_without_aux),
+	/* amdgpu_dm_find_first_crtc_matching_connector */
+	KUNIT_CASE(dm_test_find_first_crtc_match),
+	KUNIT_CASE(dm_test_find_first_crtc_no_match),
+	KUNIT_CASE(dm_test_find_first_crtc_empty_state),
+	KUNIT_CASE(dm_test_find_first_crtc_skips_null_ptr),
+	KUNIT_CASE(dm_test_find_first_crtc_returns_first),
+	/* amdgpu_dm_set_panel_type */
+	KUNIT_CASE(dm_test_set_panel_type_samsung_miniled),
+	KUNIT_CASE(dm_test_set_panel_type_samsung_below_threshold),
+	KUNIT_CASE(dm_test_set_panel_type_default_lcd),
 	{}
 };
 
-- 
2.55.0

