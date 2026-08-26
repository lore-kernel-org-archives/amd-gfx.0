Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A313C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E6C10EE58;
	Wed, 26 Aug 2026 23:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2DDB6P2v";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011008.outbound.protection.outlook.com
 [40.93.194.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 860B910EE58
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ll0GMAzm6L5X+p+al6kpysAvtPlbtXp51uVgFD5ORVhGra+NBpiR5OMN6dQD+JK3gHhPPhEBpT1+7tarC7d+JaLeK7ljLPif6hnN6EJ0y8AnjT8teoTcZeTLlsnesrIw/6nzPvwKi/bE5lVF//6+PzLojGcKi2QT8/TAbwVsJprdcn6HD1Kl5NlLEfEWejZ6W+zF5vMLf2xYyEiksXpY/DisDTS93fI4TL25Zrtt3jzFL4JrETUvlYxxn9DCPTw+frgOVxC4f32xLQN12RWGt2bPfz19qseOYdHhN2yn0BwcUpzW0gVLsplo1Z2W38HiLrGl4Qpoatwn1O/5dWXe4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9Q3tu/dpz/O4apC5z3jfO6bpLU3OQeRmqL9UGe0AIk=;
 b=awx4eQckE4LHo1kVkNm4lMTv3zHr450y/+V3vok5a9C04EDfftfkcZJvFyZFTx0KxsTIR5DG3qQ1dtBHSkTc4bopqEQJ+ZGAnW7n21xFKEH5HxBq0hL+kWzewSY5WeX7U3ghOjmEsUAmTsmNm1kKdznoIyhBvsuprngM5lzZxTlnwv6GY40rescVXBvLRRwL+d1CuWRHXZqsgrkylweh10POATQhlnZep18ml2pLFSvQN9H8c3yPlNkraeRiuphIgZZhYMzPE4arHIYC7Cc/7j4JNBO0gSRr2HCbBv07E9CigAi0iSpxgL2ATVj23ZcAPMtfaMhgP3cZf+q1Ux88HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9Q3tu/dpz/O4apC5z3jfO6bpLU3OQeRmqL9UGe0AIk=;
 b=2DDB6P2vjQKxr/fZlxlBYQjtgBlxJSxWPUscxV1BK7I0WRA6JNZANtYBiTo1+Ta47eP/yBzV6Lv/g8zb77YvuGDqDKxe+wwvAhNk8hfJF7MAVtx7cH/zHf6CwRdccbAUcMu7MV2fcML5md3Ol2T1lBUY8Ubxp3BlMVqXlfOZBL4=
Received: from SN7PR18CA0019.namprd18.prod.outlook.com (2603:10b6:806:f3::30)
 by DS4PR12MB9794.namprd12.prod.outlook.com (2603:10b6:8:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 23:28:51 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::3e) by SN7PR18CA0019.outlook.office365.com
 (2603:10b6:806:f3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Wed, 26
 Aug 2026 23:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:28:51 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:28:44 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 39/59] drm/amd/display: Test HDCP update
Date: Wed, 26 Aug 2026 17:05:10 -0600
Message-ID: <20260826231519.881949-40-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DS4PR12MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: ca304ca1-ef6e-46e6-09f9-08df03c9c9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|11063799006|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8yvrQiNVTn0Km/1vC1MEiRldNLiaBibPH4B312WywC/uhQsTNiIVjR3FmTcwt/rqpXDPUcC3B+yjBSeMRk06ialC5tsOJaI5eN2vwTcohUY7+/j398+DcjBwKPtRcdBPNSZDmF41+9Aw3J0KZnmaXqglFH7kHvk2eQaQOMrhMr3R7nharVt82jTMdVpe8bYK/jvpdiCsqHa5fRKQ1X4Kr9zPaeVPtEiNVYUe14E2K6bNUlXBOLUQKwH3byaq4lVi8b7HClSq1AOf0ODy8egZsWqshZEl6hDEy01ix/oB8WwzrbzYs7ya1FKY9Uqop15TBnOUWQ1zn5CSRf0T2EGcGUxXkqXFq3/EOi/UI8x+1zWw4seFHZCbPIUIwb+3ht0CXGBrwj/MKPHpExcrGpUrJgGue86dEQ63B/BnRi6QCqs7lay+9yueVDV7kkE5l2OAswVwqpKztuY0cGyuT+NZe8FzJEVLOmhdEdauhoxzuuA1mHpMfGl7cHlk0X81MTmlOrc0bVRdzz/TNG19HaRiiIIPkEhDReQEZ08DqLLnvVzL1nYGgSJVwtWydZxMidxXRiR9xCLP2N/Qcy9H7HRwU+lq0gnELDmse0+cgw19y99yKxt28aeMfcLZP8VtVJ54GDZMmAyEHyDgRxwnM4IasP9rb5O3SbQ74RjeYnE37VmpYKsQDrlFNWT1s+A/WEJ6xmLT1bhkMlqcgGjON61Mgg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M+KafmDIol7GIQJCO2m/3hwSHGF2h7n29stdDCSNJPGYzr0xj3nPzxawJ0Noi96N1yMcbhKOrvHIVqVWI4kpeNtl/M9asYSPHrgwxqQuarXrMRkG77p16MVuEaOEXct6s43Vzx/FNi0dUjppXSRericNNQWjPJ2Q8TVtFmdjUh8VFvTPYtf0oKivrzp0M2p5zjH+ZtnLMP33cDoYL+Vv1E0pToVU82EtR/g+p95xciw3YnoCYqhG62lFBEbTa2gkkikxqPV+aiqhqwXYiGtU1nZtyYjb/hxrK4VO9uZiWlWxrtK0BPv04lVMm7SAWpWjAXGLZ0zxvFIUiRJ5jlwusluhv7OjJjbUxtpJ4tLAwD31xro4DvAfvtu/+6dmKhlY3ggXLRM9dKw27wXK0LQHnvCk1AbiOnjZr7c+6wv7JY3Cyr+74XEdpDkNPZMIIUby
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:28:51.6117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca304ca1-ef6e-46e6-09f9-08df03c9c9b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9794
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

[WHAT]
Add KUnit tests for amdgpu_dm_update_hdcp() covering a missing workqueue,
a skipped writeback connector, and an unchanged DisplayPort connector.

[HOW]
Keep content protection unchanged and provide only the sink, connector,
and CRTC state needed for the connector walk, avoiding HDCP operations.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 100 ++++++++++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fc03fcca4c6a..5b69794acc58 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4778,7 +4778,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 	kfree(wb_info);
 }
 
-static void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state)
+STATIC_IFN_KUNIT void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state)
 {
 	struct drm_connector_state *old_con_state, *new_con_state;
 	struct drm_device *dev = state->dev;
@@ -4892,6 +4892,7 @@ static void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state)
 		}
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_update_hdcp);
 
 static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 7cb22915d18b..ed3210be7ab8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1202,6 +1202,7 @@ bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
 				     struct drm_atomic_commit *state,
 				     struct drm_crtc_state *crtc_state);
 void amdgpu_dm_dump_links_and_sinks(struct amdgpu_device *adev);
+void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
 int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 				const enum surface_pixel_format format,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 63d43f917273..de2f2f8af230 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -29,6 +29,7 @@
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
+#include "amdgpu_dm_hdcp.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
 
 /* Tests for simple DM callbacks */
@@ -2846,6 +2847,101 @@ static void dm_test_dump_links_unnamed_sinks(struct kunit *test)
 	amdgpu_dm_dump_links_and_sinks(adev);
 }
 
+/**
+ * dm_test_update_hdcp_no_workqueue - Test HDCP update is skipped without a workqueue
+ * @test: The KUnit test context
+ */
+static void dm_test_update_hdcp_no_workqueue(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	amdgpu_dm_update_hdcp(dm_test_alloc_commit(test, adev));
+}
+
+/*
+ * A commit with one connector of @type bound to a CRTC that keeps its stream.
+ * The content protection state is unchanged, so amdgpu_dm_update_hdcp() walks
+ * the connector without reaching hdcp_update_display() or hdcp_reset_display(),
+ * which are the only users of the HDCP workqueue contents.
+ */
+static struct drm_atomic_commit *dm_test_hdcp_commit(struct kunit *test,
+						     struct amdgpu_device *adev,
+						     int type)
+{
+	struct drm_atomic_commit *state = dm_test_alloc_commit(test, adev);
+	struct dm_crtc_state *old_crtc_state, *new_crtc_state;
+	struct dm_connector_state *old_dm, *new_dm;
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_crtc *acrtc;
+	struct dc_sink *sink;
+
+	adev->dm.hdcp_workqueue = kunit_kzalloc(test,
+						sizeof(*adev->dm.hdcp_workqueue),
+						GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.hdcp_workqueue);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	old_dm = kunit_kzalloc(test, sizeof(*old_dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_dm);
+	new_dm = kunit_kzalloc(test, sizeof(*new_dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, new_dm);
+	old_crtc_state = kunit_kzalloc(test, sizeof(*old_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_crtc_state);
+	new_crtc_state = kunit_kzalloc(test, sizeof(*new_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, new_crtc_state);
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+	state->connectors = kunit_kzalloc(test, sizeof(*state->connectors), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state->connectors);
+	state->crtcs = kunit_kzalloc(test, sizeof(*state->crtcs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
+
+	strscpy(sink->edid_caps.display_name, "panel");
+	sink->sink_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	aconnector->dc_sink = sink;
+	aconnector->base.connector_type = type;
+	aconnector->base.dpms = DRM_MODE_DPMS_ON;
+	aconnector->base.state = &new_dm->base;
+	new_dm->base.crtc = &acrtc->base;
+	new_crtc_state->stream = dm_kunit_alloc_stream(test, NULL);
+
+	state->num_connector = 1;
+	state->connectors[0].ptr = &aconnector->base;
+	state->connectors[0].old_state = &old_dm->base;
+	state->connectors[0].new_state = &new_dm->base;
+	state->crtcs[0].ptr = &acrtc->base;
+	state->crtcs[0].old_state = &old_crtc_state->base;
+	state->crtcs[0].new_state = &new_crtc_state->base;
+
+	return state;
+}
+
+/**
+ * dm_test_update_hdcp_writeback_skipped - Test writeback connectors are skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_update_hdcp_writeback_skipped(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	amdgpu_dm_update_hdcp(dm_test_hdcp_commit(test, adev,
+						  DRM_MODE_CONNECTOR_WRITEBACK));
+}
+
+/**
+ * dm_test_update_hdcp_unchanged - Test an unchanged connector needs no HDCP update
+ * @test: The KUnit test context
+ */
+static void dm_test_update_hdcp_unchanged(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	amdgpu_dm_update_hdcp(dm_test_hdcp_commit(test, adev,
+						  DRM_MODE_CONNECTOR_DisplayPort));
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -2988,6 +3084,10 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_dump_links_no_links),
 	KUNIT_CASE(dm_test_dump_links_with_sinks),
 	KUNIT_CASE(dm_test_dump_links_unnamed_sinks),
+	/* commit-tail helpers */
+	KUNIT_CASE(dm_test_update_hdcp_no_workqueue),
+	KUNIT_CASE(dm_test_update_hdcp_writeback_skipped),
+	KUNIT_CASE(dm_test_update_hdcp_unchanged),
 	{}
 };
 
-- 
2.43.0

