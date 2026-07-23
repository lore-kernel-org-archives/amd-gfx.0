Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEA6C531FA
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B38010F1E3;
	Thu, 23 Jul 2026 20:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J7I1xWDP";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013012.outbound.protection.outlook.com
 [40.93.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E085B10E623
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsurS81/P2I7BOf5XJswmh6WfEXas7+XYE6CMuRGj3GQLTykW9ktRylJE8StUZYolY+97w/QsaW4uPPjeMDDKv9j9N+PVRITf32o5WeWrmkmNm1fSqjHUB9o2gVcmzhtdk6w4ZQ6kBiOhVQgU8UmYVXSlYST37hVhHI4xG9cgR3BI397fTS/qwAcs2YtKu1PyW6QtxA/hLhJWbqDTW1fnQkDLTAU8WntEVUKeQOymbROB0alR583qn9SXHmI4wqwRK/6alhod/efJqfqq5dgmcoP3WxXApumQCeME9CAzc/xjiGsTlm7tseyEDRUBHB/aFQELYmQ5QfL5Sadcwi1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvnnTqCcciEJ+K4m7//BAfSYB8+hAXtSh4p2M3CbGxU=;
 b=OCIas6HEalwsfcSmdZSQ570WSVv0pkMHiR4Zrew8i3rMMCYYh/FigpnCbG6yrKtYSVsB3jJW92H365fVTrfIgwX9Ws+pfMOwtkOhhVpkqdNoTmB3vgDeWmudVJ7OSJOkTFf+t40VaJ73+c3ODg9miNLmXXKgp3phhQsWNmAqB/tpkAafbmdH31k2fWg2a+FFBcOWh2Nb3KWCTRlGqtGSV5Lh+3goRpG5ZkwufFw5cweP3261Y9M2dh4S5ZPuSp48AVzdXv3vImyfCFwQTlTfRvwYnqwNOsWUO8sBBtzqI7WlR29kWuEHIRRt2/bxj61VpdN/Xrx5s1XGgOM/1lKGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvnnTqCcciEJ+K4m7//BAfSYB8+hAXtSh4p2M3CbGxU=;
 b=J7I1xWDPhMYzO1+NpHuahqtKw6wbwtl+runNmaZWYVXuY9OyCizH+RkQgdW0kcY2T9028E5Ls8jvqLUxWoLV9iCoKbgWZdG/vKtEL4AEYLAAdWNtl1ICDxTrkCoGTFR3MDLYKd+sd+92fBtIBhNzY2gM9gfHHb0ojSXOL3ck+3s=
Received: from BN9PR03CA0673.namprd03.prod.outlook.com (2603:10b6:408:10e::18)
 by CY8PR12MB7268.namprd12.prod.outlook.com (2603:10b6:930:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:19:13 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::22) by BN9PR03CA0673.outlook.office365.com
 (2603:10b6:408:10e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:13 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:02 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 19/49] drm/amd/display: add KUnit tests for audio commit path
Date: Thu, 23 Jul 2026 16:13:27 -0400
Message-ID: <20260723201908.373300-20-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|CY8PR12MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a7169c-aeba-4f1b-a1ac-08dee8f7a98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|5023799004|11063799006|6133799003|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: GQHfDsMYqUtTCKiMAMESZTUwy4OTrlSd6wbRG8uPliBtBOxs0crfH+TS7gOB0YMl35bxh1M7EFlBOZH4wl5EebGreYxhC1t84TpizkslwM/tXTzUsgK4oHkfmuxrRWTNWe1VWNU7Uh4TnyiH+PGcXewiDOcBvO+7AdK46MEhsOmhfPPowzFxTL9EYCmiut0kw1IRq6YoKnEAUmp6pmufa8jU0jR0Ry79CJpROoyR+YJoGPU2HvL4KIQlvRxtuw8f1o3g7t+rpXKvSbDtQ4xM/uIIWZgCsO82FYy2SL4is62tOyartJ0m+KS/gYPEIq0w5QSQ6qLJrsY6q9H4p1Ys0NX3X80skQpDuVFrOfFH49TC9/KSIMEuZ3wjg1Zf+VhcGDmMd5jB7IrQmIYa8R2DehPGKwxnq3YQqRixCwubxNGIDIuQaMsfO90RMG1ivk9A2lifssVfjFzBZKcnJ+z4LGJ45zJw/fJM6+d8COp3Ja1N9DZ8tmpy1dZlr2ohcAi+roqhg6DPwPJ/6PX3ouKkjcP+3iytHlEw/lTvpKDvSAeRiZWWQ4HEZ+19ULkaxoIyJjCuMlhq2LZMmHFCcFH43rg24pHTgtFPzWb5aH9iLuXjA/WJC1fDTU61VnMbmcie9/z12Czde1ebcnmKti781D/7joBOR+PNUH7LnG1/FkBuTcGxAIxpOT7VxFjOAOqsWPjdXQoMPbJ89B4LOOi5Wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(5023799004)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5eTj2z9NaCth/ji3l8dFhfBKhARB0A+l5g/CfKrU5Vr/A1hXcFEnXFk7TkezWOOBfWMe5qhLc+tG9pXe8Ait2usfcXeHy3tMWVxOtm5vPheu5puHNRNSdbPP99bTNPwKd9qfueODyDsdNL+XKJ/t2+aLhs/IujZPrpWI9ni+WdCg2Q/JoTIZsdDka8w7Vc6GS5QhAm0fPyThGMhoN+iSR+Qb4vVPY3Em4lKn8S1tFFUeAB4/XXz8e0vA9qNrGb787NswINHdSw+O8DB/ylTxJ4tUXN7rbNQ+Fp+3jzgKKwsenWXVw39MhxQtJO0ejRKqZDnf7Uj5gh5q8c/GyPegksdLQ/6WTYRVzUKKBCIRTNP8VRT9s/faydhwUsFTXr+7GjAQHWLkX22H1Ua2D6E9Y9dWx0GfFlclZP3lLq3TDUMLfhqZkeehzFYEnJXUp0j2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:13.1726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a7169c-aeba-4f1b-a1ac-08dee8f7a98a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268
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
Add KUnit coverage for amdgpu_dm_commit_audio(), the remaining function
reported as untested by gcov.

The tests build hand-rolled drm_atomic_state arrays and back
dc_stream_get_status() with a fake dc->current_state to cover the
removal and addition ELD notifications along with their guard/skip
paths: writeback connector, detached connector, missing new CRTC state,
no modeset, and absent stream status.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.c   |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_audio_test.c    | 532 ++++++++++++++++++
 2 files changed, 533 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
index 4b10c683df8e..199f339839b2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
@@ -321,6 +321,7 @@ void amdgpu_dm_commit_audio(struct drm_device *dev,
 		amdgpu_dm_audio_eld_notify(adev, inst);
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_commit_audio);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 int amdgpu_dm_audio_get_param(void)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
index d30b7f644f97..040a7a9c0335 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
@@ -8,9 +8,11 @@
 #include <kunit/test.h>
 #include <linux/device.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_audio_component.h>
 #include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
 #include <drm/drm_eld.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_probe_helper.h>
@@ -37,6 +39,32 @@ static void dm_test_audio_connector_cleanup(void *data)
 	drm_connector_cleanup(data);
 }
 
+static struct drm_atomic_commit *dm_test_audio_alloc_atomic_state(struct kunit *test,
+								 unsigned int num_connector,
+								 unsigned int num_crtc)
+{
+	struct drm_atomic_commit *state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	state->num_connector = num_connector;
+	if (num_connector) {
+		state->connectors = kunit_kcalloc(test, num_connector,
+						  sizeof(*state->connectors),
+						  GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, state->connectors);
+	}
+
+	if (num_crtc) {
+		state->crtcs = kunit_kcalloc(test, num_crtc, sizeof(*state->crtcs),
+					     GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
+	}
+
+	return state;
+}
+
 /* Tests for amdgpu_dm_audio_init() */
 
 /**
@@ -411,6 +439,22 @@ static void dm_test_pin_eld_notify(void *audio_ptr, int port, int pipe)
 	dm_test_eld_notify_ptr = audio_ptr;
 }
 
+static void dm_test_audio_setup_notify_component(struct kunit *test,
+						 struct amdgpu_device *adev)
+{
+	struct drm_audio_component *acomp;
+	struct drm_audio_component_audio_ops *audio_ops;
+
+	acomp = kunit_kzalloc(test, sizeof(*acomp), GFP_KERNEL);
+	audio_ops = kunit_kzalloc(test, sizeof(*audio_ops), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acomp);
+	KUNIT_ASSERT_NOT_NULL(test, audio_ops);
+
+	audio_ops->pin_eld_notify = dm_test_pin_eld_notify;
+	acomp->audio_ops = audio_ops;
+	adev->dm.audio_component = acomp;
+}
+
 /**
  * dm_test_eld_notify_invokes_callback - Test ELD notify forwards to hda driver
  * @test: The KUnit test context
@@ -685,6 +729,484 @@ static void dm_test_audio_component_get_eld_no_match(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, buf[0], 0x5a);
 }
 
+/* Tests for amdgpu_dm_commit_audio() */
+
+/**
+ * dm_test_commit_audio_notifies_removed_connector - Test removal notification
+ * @test: The KUnit test context
+ *
+ * When a connector loses its CRTC, commit_audio should clear its audio
+ * instance and notify the audio component for the old pin.
+ */
+static void dm_test_commit_audio_notifies_removed_connector(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector_state *old_conn_state;
+	struct drm_connector_state *new_conn_state;
+	struct drm_crtc *crtc;
+
+	state = dm_test_audio_alloc_atomic_state(test, 1, 0);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	old_conn_state = kunit_kzalloc(test, sizeof(*old_conn_state), GFP_KERNEL);
+	new_conn_state = kunit_kzalloc(test, sizeof(*new_conn_state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, old_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	mutex_init(&adev->dm.audio_lock);
+	dm_test_audio_setup_notify_component(test, adev);
+	aconnector->audio_inst = 5;
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+	old_conn_state->crtc = crtc;
+	state->connectors[0].ptr = &aconnector->base;
+	state->connectors[0].old_state = old_conn_state;
+	state->connectors[0].new_state = new_conn_state;
+
+	dm_test_eld_notify_count = 0;
+	dm_test_eld_notify_port = -1;
+
+	amdgpu_dm_commit_audio(&adev->ddev, state);
+
+	KUNIT_EXPECT_EQ(test, aconnector->audio_inst, -1);
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_count, 1);
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_port, 5);
+}
+
+/**
+ * dm_test_commit_audio_notifies_added_connector - Test addition notification
+ * @test: The KUnit test context
+ *
+ * When a modeset enables a connector with a stream status, commit_audio should
+ * store the stream audio instance and notify the audio component for that pin.
+ */
+static void dm_test_commit_audio_notifies_added_connector(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector_state *old_conn_state;
+	struct drm_connector_state *new_conn_state;
+	struct drm_crtc *crtc;
+	struct dm_crtc_state *dm_crtc_state;
+	struct dc_stream_state *stream;
+
+	state = dm_test_audio_alloc_atomic_state(test, 1, 1);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	old_conn_state = kunit_kzalloc(test, sizeof(*old_conn_state), GFP_KERNEL);
+	new_conn_state = kunit_kzalloc(test, sizeof(*new_conn_state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, old_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	adev->dm.dc = kunit_kzalloc(test, sizeof(*adev->dm.dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.dc);
+	adev->dm.dc->current_state = kunit_kzalloc(test,
+							 sizeof(*adev->dm.dc->current_state),
+							 GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.dc->current_state);
+	stream->ctx = kunit_kzalloc(test, sizeof(*stream->ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream->ctx);
+	stream->ctx->dc = adev->dm.dc;
+	adev->dm.dc->current_state->stream_count = 1;
+	adev->dm.dc->current_state->streams[0] = stream;
+	adev->dm.dc->current_state->stream_status[0].audio_inst = 8;
+
+	mutex_init(&adev->dm.audio_lock);
+	dm_test_audio_setup_notify_component(test, adev);
+	aconnector->audio_inst = -1;
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+	crtc->index = 0;
+	new_conn_state->crtc = crtc;
+	dm_crtc_state->base.crtc = crtc;
+	dm_crtc_state->base.mode_changed = true;
+	dm_crtc_state->stream = stream;
+	state->connectors[0].ptr = &aconnector->base;
+	state->connectors[0].old_state = old_conn_state;
+	state->connectors[0].new_state = new_conn_state;
+	state->crtcs[0].ptr = crtc;
+	state->crtcs[0].new_state = &dm_crtc_state->base;
+
+	dm_test_eld_notify_count = 0;
+	dm_test_eld_notify_port = -1;
+
+	amdgpu_dm_commit_audio(&adev->ddev, state);
+
+	KUNIT_EXPECT_EQ(test, aconnector->audio_inst, 8);
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_count, 2);
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_port, 8);
+}
+
+/**
+ * dm_test_commit_audio_skips_writeback_removal - Test writeback removal skip
+ * @test: The KUnit test context
+ *
+ * Writeback connectors do not represent an HDA audio pin, so removal-style
+ * notifications should leave their audio instance untouched.
+ */
+static void dm_test_commit_audio_skips_writeback_removal(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector_state *old_conn_state;
+	struct drm_connector_state *new_conn_state;
+	struct drm_crtc *crtc;
+
+	state = dm_test_audio_alloc_atomic_state(test, 1, 0);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	old_conn_state = kunit_kzalloc(test, sizeof(*old_conn_state), GFP_KERNEL);
+	new_conn_state = kunit_kzalloc(test, sizeof(*new_conn_state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, old_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	mutex_init(&adev->dm.audio_lock);
+	dm_test_audio_setup_notify_component(test, adev);
+	aconnector->audio_inst = 9;
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_WRITEBACK;
+	old_conn_state->crtc = crtc;
+	state->connectors[0].ptr = &aconnector->base;
+	state->connectors[0].old_state = old_conn_state;
+	state->connectors[0].new_state = new_conn_state;
+
+	dm_test_eld_notify_count = 0;
+
+	amdgpu_dm_commit_audio(&adev->ddev, state);
+
+	KUNIT_EXPECT_EQ(test, aconnector->audio_inst, 9);
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_count, 0);
+}
+
+/**
+ * dm_test_commit_audio_skips_without_new_crtc_state - Test missing CRTC state
+ * @test: The KUnit test context
+ *
+ * A connector still attached to the same CRTC should not notify if the atomic
+ * state does not contain a new CRTC state for that CRTC.
+ */
+static void dm_test_commit_audio_skips_without_new_crtc_state(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector_state *old_conn_state;
+	struct drm_connector_state *new_conn_state;
+	struct drm_crtc *crtc;
+
+	state = dm_test_audio_alloc_atomic_state(test, 1, 1);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	old_conn_state = kunit_kzalloc(test, sizeof(*old_conn_state), GFP_KERNEL);
+	new_conn_state = kunit_kzalloc(test, sizeof(*new_conn_state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, old_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	mutex_init(&adev->dm.audio_lock);
+	dm_test_audio_setup_notify_component(test, adev);
+	aconnector->audio_inst = 4;
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+	crtc->index = 0;
+	old_conn_state->crtc = crtc;
+	new_conn_state->crtc = crtc;
+	state->connectors[0].ptr = &aconnector->base;
+	state->connectors[0].old_state = old_conn_state;
+	state->connectors[0].new_state = new_conn_state;
+
+	dm_test_eld_notify_count = 0;
+
+	amdgpu_dm_commit_audio(&adev->ddev, state);
+
+	KUNIT_EXPECT_EQ(test, aconnector->audio_inst, 4);
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_count, 0);
+}
+
+/**
+ * dm_test_commit_audio_skips_without_stream_status - Test missing DC status
+ * @test: The KUnit test context
+ *
+ * If the new CRTC stream is absent from the current DC state, additions should
+ * be skipped because there is no audio instance to publish.
+ */
+static void dm_test_commit_audio_skips_without_stream_status(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector_state *old_conn_state;
+	struct drm_connector_state *new_conn_state;
+	struct drm_crtc *crtc;
+	struct dm_crtc_state *dm_crtc_state;
+	struct dc_stream_state *stream;
+
+	state = dm_test_audio_alloc_atomic_state(test, 1, 1);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	old_conn_state = kunit_kzalloc(test, sizeof(*old_conn_state), GFP_KERNEL);
+	new_conn_state = kunit_kzalloc(test, sizeof(*new_conn_state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, old_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	adev->dm.dc = kunit_kzalloc(test, sizeof(*adev->dm.dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.dc);
+	adev->dm.dc->current_state = kunit_kzalloc(test,
+							 sizeof(*adev->dm.dc->current_state),
+							 GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.dc->current_state);
+	stream->ctx = kunit_kzalloc(test, sizeof(*stream->ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream->ctx);
+	stream->ctx->dc = adev->dm.dc;
+
+	mutex_init(&adev->dm.audio_lock);
+	dm_test_audio_setup_notify_component(test, adev);
+	aconnector->audio_inst = -1;
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+	crtc->index = 0;
+	new_conn_state->crtc = crtc;
+	dm_crtc_state->base.crtc = crtc;
+	dm_crtc_state->base.mode_changed = true;
+	dm_crtc_state->stream = stream;
+	state->connectors[0].ptr = &aconnector->base;
+	state->connectors[0].old_state = old_conn_state;
+	state->connectors[0].new_state = new_conn_state;
+	state->crtcs[0].ptr = crtc;
+	state->crtcs[0].new_state = &dm_crtc_state->base;
+
+	dm_test_eld_notify_count = 0;
+
+	amdgpu_dm_commit_audio(&adev->ddev, state);
+
+	KUNIT_EXPECT_EQ(test, aconnector->audio_inst, -1);
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_count, 1);
+}
+
+/**
+ * dm_test_commit_audio_skips_detached_connector - Test detached connector skip
+ * @test: The KUnit test context
+ *
+ * A connector that remains detached across the commit should not notify or
+ * alter the stored audio instance.
+ */
+static void dm_test_commit_audio_skips_detached_connector(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector_state *old_conn_state;
+	struct drm_connector_state *new_conn_state;
+
+	state = dm_test_audio_alloc_atomic_state(test, 1, 0);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	old_conn_state = kunit_kzalloc(test, sizeof(*old_conn_state), GFP_KERNEL);
+	new_conn_state = kunit_kzalloc(test, sizeof(*new_conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, old_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_conn_state);
+
+	aconnector->audio_inst = 11;
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+	state->connectors[0].ptr = &aconnector->base;
+	state->connectors[0].old_state = old_conn_state;
+	state->connectors[0].new_state = new_conn_state;
+
+	dm_test_eld_notify_count = 0;
+
+	amdgpu_dm_commit_audio(&adev->ddev, state);
+
+	KUNIT_EXPECT_EQ(test, aconnector->audio_inst, 11);
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_count, 0);
+}
+
+/**
+ * dm_test_commit_audio_skips_without_modeset - Test no-modeset skip
+ * @test: The KUnit test context
+ *
+ * A connector that stays on the same CRTC should not notify if that CRTC does
+ * not need a modeset.
+ */
+static void dm_test_commit_audio_skips_without_modeset(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector_state *old_conn_state;
+	struct drm_connector_state *new_conn_state;
+	struct drm_crtc *crtc;
+	struct dm_crtc_state *dm_crtc_state;
+
+	state = dm_test_audio_alloc_atomic_state(test, 1, 1);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	old_conn_state = kunit_kzalloc(test, sizeof(*old_conn_state), GFP_KERNEL);
+	new_conn_state = kunit_kzalloc(test, sizeof(*new_conn_state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, old_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
+
+	aconnector->audio_inst = 12;
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+	crtc->index = 0;
+	old_conn_state->crtc = crtc;
+	new_conn_state->crtc = crtc;
+	dm_crtc_state->base.crtc = crtc;
+	state->connectors[0].ptr = &aconnector->base;
+	state->connectors[0].old_state = old_conn_state;
+	state->connectors[0].new_state = new_conn_state;
+	state->crtcs[0].ptr = crtc;
+	state->crtcs[0].new_state = &dm_crtc_state->base;
+
+	dm_test_eld_notify_count = 0;
+
+	amdgpu_dm_commit_audio(&adev->ddev, state);
+
+	KUNIT_EXPECT_EQ(test, aconnector->audio_inst, 12);
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_count, 0);
+}
+
+/**
+ * dm_test_commit_audio_skips_addition_without_stream - Test NULL stream skip
+ * @test: The KUnit test context
+ *
+ * A modeset still sends the removal-side ELD notification, but the addition
+ * side must skip if the new DM CRTC state has no stream.
+ */
+static void dm_test_commit_audio_skips_addition_without_stream(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector_state *old_conn_state;
+	struct drm_connector_state *new_conn_state;
+	struct drm_crtc *crtc;
+	struct dm_crtc_state *dm_crtc_state;
+
+	state = dm_test_audio_alloc_atomic_state(test, 1, 1);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	old_conn_state = kunit_kzalloc(test, sizeof(*old_conn_state), GFP_KERNEL);
+	new_conn_state = kunit_kzalloc(test, sizeof(*new_conn_state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, old_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
+
+	mutex_init(&adev->dm.audio_lock);
+	dm_test_audio_setup_notify_component(test, adev);
+	aconnector->audio_inst = 13;
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+	crtc->index = 0;
+	old_conn_state->crtc = crtc;
+	new_conn_state->crtc = crtc;
+	dm_crtc_state->base.crtc = crtc;
+	dm_crtc_state->base.mode_changed = true;
+	state->connectors[0].ptr = &aconnector->base;
+	state->connectors[0].old_state = old_conn_state;
+	state->connectors[0].new_state = new_conn_state;
+	state->crtcs[0].ptr = crtc;
+	state->crtcs[0].new_state = &dm_crtc_state->base;
+
+	dm_test_eld_notify_count = 0;
+	dm_test_eld_notify_port = -1;
+
+	amdgpu_dm_commit_audio(&adev->ddev, state);
+
+	KUNIT_EXPECT_EQ(test, aconnector->audio_inst, -1);
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_count, 1);
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_port, 13);
+}
+
+/**
+ * dm_test_commit_audio_skips_writeback_addition - Test writeback addition skip
+ * @test: The KUnit test context
+ *
+ * Even with a valid modeset and stream status, writeback connectors must not
+ * publish an HDA audio instance.
+ */
+static void dm_test_commit_audio_skips_writeback_addition(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector_state *old_conn_state;
+	struct drm_connector_state *new_conn_state;
+	struct drm_crtc *crtc;
+	struct dm_crtc_state *dm_crtc_state;
+	struct dc_stream_state *stream;
+
+	state = dm_test_audio_alloc_atomic_state(test, 1, 1);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	old_conn_state = kunit_kzalloc(test, sizeof(*old_conn_state), GFP_KERNEL);
+	new_conn_state = kunit_kzalloc(test, sizeof(*new_conn_state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, old_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	adev->dm.dc = kunit_kzalloc(test, sizeof(*adev->dm.dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.dc);
+	adev->dm.dc->current_state = kunit_kzalloc(test,
+							 sizeof(*adev->dm.dc->current_state),
+							 GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.dc->current_state);
+	stream->ctx = kunit_kzalloc(test, sizeof(*stream->ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream->ctx);
+	stream->ctx->dc = adev->dm.dc;
+	adev->dm.dc->current_state->stream_count = 1;
+	adev->dm.dc->current_state->streams[0] = stream;
+	adev->dm.dc->current_state->stream_status[0].audio_inst = 14;
+
+	mutex_init(&adev->dm.audio_lock);
+	dm_test_audio_setup_notify_component(test, adev);
+	aconnector->audio_inst = 15;
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_WRITEBACK;
+	crtc->index = 0;
+	new_conn_state->crtc = crtc;
+	dm_crtc_state->base.crtc = crtc;
+	dm_crtc_state->base.mode_changed = true;
+	dm_crtc_state->stream = stream;
+	state->connectors[0].ptr = &aconnector->base;
+	state->connectors[0].old_state = old_conn_state;
+	state->connectors[0].new_state = new_conn_state;
+	state->crtcs[0].ptr = crtc;
+	state->crtcs[0].new_state = &dm_crtc_state->base;
+
+	dm_test_eld_notify_count = 0;
+
+	amdgpu_dm_commit_audio(&adev->ddev, state);
+
+	KUNIT_EXPECT_EQ(test, aconnector->audio_inst, 15);
+	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_count, 0);
+}
+
 static struct kunit_case dm_audio_test_cases[] = {
 	/* amdgpu_dm_audio_init */
 	KUNIT_CASE(dm_test_audio_init_disabled),
@@ -712,6 +1234,16 @@ static struct kunit_case dm_audio_test_cases[] = {
 	/* amdgpu_dm_audio_component_get_eld */
 	KUNIT_CASE(dm_test_audio_component_get_eld_copies_matching_connector),
 	KUNIT_CASE(dm_test_audio_component_get_eld_no_match),
+	/* amdgpu_dm_commit_audio */
+	KUNIT_CASE(dm_test_commit_audio_notifies_removed_connector),
+	KUNIT_CASE(dm_test_commit_audio_notifies_added_connector),
+	KUNIT_CASE(dm_test_commit_audio_skips_writeback_removal),
+	KUNIT_CASE(dm_test_commit_audio_skips_without_new_crtc_state),
+	KUNIT_CASE(dm_test_commit_audio_skips_without_stream_status),
+	KUNIT_CASE(dm_test_commit_audio_skips_detached_connector),
+	KUNIT_CASE(dm_test_commit_audio_skips_without_modeset),
+	KUNIT_CASE(dm_test_commit_audio_skips_addition_without_stream),
+	KUNIT_CASE(dm_test_commit_audio_skips_writeback_addition),
 	{}
 };
 
-- 
2.53.0

