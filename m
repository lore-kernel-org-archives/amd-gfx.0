Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CE8C61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E50410E32A;
	Wed,  2 Sep 2026 05:06:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fpz+zCeU";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010048.outbound.protection.outlook.com
 [40.93.198.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F37910E32A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIiSScuJjVZrQYZFWwfckeTIF80OhC2rPg11n6D/cvfLnbPcNO0PXJdmf/JRScoa1taL7wdFhs2z06BWMGeP+6XaDpBd8OCddr4L7a9QzWzqaeCGMZjIoCcFB5sFAEzB7PTQJvwhR2KTORjPyeYqJZ0u88WIHen3VQh51KG+wPdAbCfFVok4+oM2A1Vj+RErlmlbCyD63zQ8PXj9sfdKgIS5LyLJms9TThhY7XAySTp6c8ZguOwRTqB0Yf8T1xlWsfkhlE2DHiElBzyFPtX3owv+BgDe07hxo8LcJ2s4i0uswkR2tmdLKsb4h47hVdN46xGA6t1Bn2HfAJ0UwXM0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31uNy3dbL6k2wU7R1ZwIoDGFPcBJ1DF5Ml7bOPtyDnA=;
 b=kPhw2VQGNSknvBmSAnEJC+a99QwZjANz1K29vmc1dzV3MpJMWhkKzwM+HoMmF2/4DoNO5ktNSY8kjzgbk6XbwFa/YdDLtRvFR8Nk55rdm5FL368G4cKrYTWqLlg26iW766VUiXFxiLM7ub4t434mvJaE15Wf6L8I7ZZDYUr94Jw+kKlymQmwQdcheBtDPXweuDXw7/sCd5kQR3U5FwVPJAaODwhapyxILxZ9NJlbOsHtRQHgjT05xe8boBPYbYJBWff97Oe0MVur46XdyOXnXTZuX1cPZ9x315Z29BwGecLPhgsn2YUh8+laA3za0gk7SgmLIz+RLAJifgmq+QnN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31uNy3dbL6k2wU7R1ZwIoDGFPcBJ1DF5Ml7bOPtyDnA=;
 b=Fpz+zCeUdX+o2NYpTgi6wG9kdxn88zw9brWu/qq0nNtTiKLgrb5O2teNLClED9OHg1W7NdFIYIXCmg1wMVg4xrKNpO8C4UUCkQwvRKi/UaxXO8WmHW4u/+YY4Y8B6ErgGxiPDFOeOt3In3v82PZGhbTsBDUNHvf/2Fr42Zakz2o=
Received: from CH5PR04CA0012.namprd04.prod.outlook.com (2603:10b6:610:1f4::28)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.8; Wed, 2 Sep 2026 05:05:55 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::2d) by CH5PR04CA0012.outlook.office365.com
 (2603:10b6:610:1f4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:05:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:05:52 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:05:44 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 10/40] drm/amd/display: Test writeback state transitions
Date: Wed, 2 Sep 2026 12:58:32 +0800
Message-ID: <20260902050411.3473916-11-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|DM4PR12MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a5fd8b-608d-45a6-e480-08df08afdea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: K3zMGIdKR4wtX56CO0hu1Fvd78WRCLvvDotZ2xQwuuPOmCimE7SelFxcS10Ydtpt7FriOqeliRR9T7gypEhhOLCPXT7LFYc/5NlZfb6BCmTGTLTUUFVpjOa4syJlmJF5GUrPASixe9sG3tNvahswiyiCr7386txQO1ZE81wA+4mqGIf0IMsivt0NI35WFK7e7GltnIuEpaNvzJB+5YI8H2A8IC60zuzvGX3oBgpdwCUzl/yNzBMypxSSJu9Nng1OyNd+Rxwygh54PTnmJyjgsZ87ewvCxK9i4OH01mijzWrHJQj92sFJUwBXEjUArHULC68DouaZrJ0QjW/aziaZw3YLuV9xVaN0rizFz2L+PF1DU+hGBbOwTRxtossZ+TS7YlUWgKh/mNquwyS5cY3016V6X+HyPwgZfym+GXhL71sGZIjtfv7uLghhpRyJex/8BvLB5Q+8kczCnqm323bXRVRGoxdxPiTgv3DCG+DsO1wz2zBDjTZP3jjgIi0cMw6hWJ6N36PnMiLhjMII5G/YZXTfwpcJcGViPpgz6Z7NRegid181NyTFWX1tgAKTo5bYXNNKwSeoO5a/qGuYhZ+/LI1Nc/7etiJAkmqe1E3v/aYT1spyg0jn8xUdiFFDVyITiwBI3z6a5MW6sEFFuMV/awsjuq8ukZlHf0Lmgw/ZYo3eB1qRZ+OvAL9s7CyKDhqR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gKn1yTvY710lZHwAbS1gzQcRhEfegy8JLmqC3XL839x4FCrEqJon6CajJ8lapAzEDGXknUCcXCS0rbvL+X8h1X9Ewqvgt27osw8eQCUHNTYWrKhpHmg4MrW5JlevlH0lRZqRfiqRfFkYU9rSY6D7kuAwFWVLIBvISaqb4yBmoJPX2lXU7e49ky6xx1Xu1g8GK563I98XBX1SKKHGulpe7w7FKmXjWnU1v5eu5KrjYY75HkoUgRDu1W5nDoK6N3RSWOMNaeUJhqCN6pOsL5P1UEwjTDFATi7iuRoYTDrpHIP8mPvzto4ZfVNwhv+R4uf1PsNwYO+ebGt+Dl/2kMRSOuYuSR19pPz3AM+sZgfesn1JshU/u5XHQA+s2scLyeENI9dNigVRUluHKb5t4zmu2IzbR1ptwZ1l9G6ic4GQXY5qGDZNKWfDCr50/c6PmzXN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:05:55.7000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a5fd8b-608d-45a6-e480-08df08afdea3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206
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

[Why]
Add KUnit tests for dm_clear_writeback() removing stream writeback
state and dm_set_writeback() leaving a job unarmed when no DC pipe
matches.

[How]
Use the real DC removal helper with a state-only update_bandwidth
fake, and construct the minimal DRM writeback objects needed to reach
the no-pipe cleanup path.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6 Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 17 ++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 ++
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 77 +++++++++++++++++++
 3 files changed, 94 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 42e2ef74c687..d94d18e884ef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4375,9 +4375,9 @@ bool amdgpu_dm_crtc_complete_writeback(struct amdgpu_crtc *acrtc)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_complete_writeback);
 
-static void dm_clear_writeback(struct amdgpu_display_manager *dm,
-			      struct amdgpu_crtc *acrtc,
-			      struct dm_crtc_state *crtc_state)
+STATIC_IFN_KUNIT void dm_clear_writeback(struct amdgpu_display_manager *dm,
+					 struct amdgpu_crtc *acrtc,
+					 struct dm_crtc_state *crtc_state)
 {
 	dc_stream_remove_writeback(dm->dc, crtc_state->stream, 0);
 
@@ -4389,6 +4389,7 @@ static void dm_clear_writeback(struct amdgpu_display_manager *dm,
 	 */
 	amdgpu_dm_crtc_complete_writeback(acrtc);
 }
+EXPORT_IF_KUNIT(dm_clear_writeback);
 
 /**
  * amdgpu_dm_mod_power_update_streams - update mod_power stream state on modeset
@@ -4722,10 +4723,11 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 	}
 }
 
-static void dm_set_writeback(struct amdgpu_display_manager *dm,
-			      struct dm_crtc_state *crtc_state,
-			      struct drm_connector *connector,
-			      struct drm_connector_state *new_con_state)
+STATIC_IFN_KUNIT void
+dm_set_writeback(struct amdgpu_display_manager *dm,
+		 struct dm_crtc_state *crtc_state,
+		 struct drm_connector *connector,
+		 struct drm_connector_state *new_con_state)
 {
 	struct drm_writeback_connector *wb_conn = drm_connector_to_writeback(connector);
 	struct amdgpu_device *adev = dm->adev;
@@ -4842,6 +4844,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 cleanup:
 	kfree(wb_info);
 }
+EXPORT_IF_KUNIT(dm_set_writeback);
 
 STATIC_IFN_KUNIT void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 4d12632d048f..3c63dfcc2343 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1278,6 +1278,13 @@ void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev, struct dc_state *
 enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc);
 int dm_cache_state(struct amdgpu_device *adev);
 void dm_destroy_cached_state(struct amdgpu_device *adev);
+void dm_clear_writeback(struct amdgpu_display_manager *dm,
+			struct amdgpu_crtc *acrtc,
+			struct dm_crtc_state *crtc_state);
+void dm_set_writeback(struct amdgpu_display_manager *dm,
+		      struct dm_crtc_state *crtc_state,
+		      struct drm_connector *connector,
+		      struct drm_connector_state *new_con_state);
 int dm_early_init(struct amdgpu_ip_block *ip_block);
 int fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 				const struct drm_plane_state *plane_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 61fa553c7a99..3209608a41b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -4422,6 +4422,81 @@ static void dm_test_destroy_cached_state_none(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, adev->dm.cached_state);
 }
 
+static bool dm_test_update_bandwidth(struct dc *dc, struct dc_state *context)
+{
+	return true;
+}
+
+/**
+ * dm_test_clear_writeback_removes_stream - Test teardown removes the stream writeback
+ * @test: The KUnit test context
+ */
+static void dm_test_clear_writeback_removes_stream(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+	struct dm_crtc_state *crtc_state;
+	struct amdgpu_crtc *acrtc;
+	struct dc_stream_state *stream;
+
+	dm = dm_kunit_alloc_dm(test);
+	crtc_state = kunit_kzalloc(test, sizeof(*crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	stream = dm_kunit_alloc_stream(test, NULL);
+	dm->dc->hwss.update_bandwidth = dm_test_update_bandwidth;
+	crtc_state->stream = stream;
+	stream->num_wb_info = 1;
+	stream->writeback_info[0].dwb_pipe_inst = 0;
+
+	dm_clear_writeback(dm, acrtc, crtc_state);
+
+	KUNIT_EXPECT_EQ(test, stream->num_wb_info, 0U);
+}
+
+/**
+ * dm_test_set_writeback_no_pipe - Test a stream without a DC pipe is not armed
+ * @test: The KUnit test context
+ */
+static void dm_test_set_writeback_no_pipe(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_writeback_connector *wb_conn;
+	struct drm_connector_state *conn_state;
+	struct drm_writeback_job *job;
+	struct amdgpu_framebuffer *afb;
+	struct dm_crtc_state *crtc_state;
+	struct amdgpu_crtc *acrtc;
+	struct dc *dc;
+
+	wb_conn = kunit_kzalloc(test, sizeof(*wb_conn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, wb_conn);
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+	job = kunit_kzalloc(test, sizeof(*job), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, job);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+	crtc_state = kunit_kzalloc(test, sizeof(*crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+	dc->current_state = dm_kunit_alloc_dc_state(test);
+
+	adev->dm.adev = adev;
+	adev->dm.dc = dc;
+	wb_conn->encoder.crtc = &acrtc->base;
+	job->fb = &afb->base;
+	conn_state->writeback_job = job;
+	crtc_state->stream = dm_kunit_alloc_stream(test, NULL);
+
+	dm_set_writeback(&adev->dm, crtc_state, &wb_conn->base, conn_state);
+
+	KUNIT_EXPECT_NULL(test, acrtc->wb_conn);
+	KUNIT_EXPECT_FALSE(test, acrtc->wb_pending);
+}
+
 /* Tests for dm_update_mst_vcpi_slots_for_dsc() */
 
 /**
@@ -5237,6 +5312,8 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_cache_state_empty_device),
 	KUNIT_CASE(dm_test_cache_state_error),
 	KUNIT_CASE(dm_test_destroy_cached_state_none),
+	KUNIT_CASE(dm_test_clear_writeback_removes_stream),
+	KUNIT_CASE(dm_test_set_writeback_no_pipe),
 	/* dm_update_mst_vcpi_slots_for_dsc */
 	KUNIT_CASE(dm_test_mst_vcpi_slots_no_connector),
 	KUNIT_CASE(dm_test_mst_vcpi_slots_skips_writeback),
-- 
2.43.0

