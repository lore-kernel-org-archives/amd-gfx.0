Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7380DC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE37B10EE59;
	Wed, 26 Aug 2026 23:29:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kaUkYE0P";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1892D10EE59
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tv9c/aIjrP09Bpivs8YtetmQ8Bvo5Mn0bfAT7kcnLQJVj/QIaWXtQmtAbpOwQ4G7efsld3QGI/oy+pyza9LNjdYqTDk1OX84vO6JLx0RVkwnBGFSIPsd1FHaLTC32pjIyi4Ra0FmdKRRl9gLBwgb4oormcCPkPFZNTvO6CFk+fW43Rtexp0kCZT3gBAolKttnqjreJStSV+ziPg4BrchAUUvhwGd8nAHmJKFPJrIRJC4J876q2JL+gM+lbOVteMRN9d9eSU7T8RlxKeCN3wCDdMf+lahd42J9pn1imrcHsZZyALe2ImZnLK8IfjGEpcAjF1zH+4Fp5qReuekJSmFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2FFThNiP7sh3aEKP2yhj7Igao318ofRK1pCe63roR8=;
 b=Hfn6TJM7o1O1ieIhKYFUL5Zz3o6waAGvW1aSj7cVMooxAcbmt7L+fCL/d1kWfWMkhwUFh7WKKoNol9G42qNcIre4TEUAVzJOc5lo6nothc4d+MzkD1AGk61hnfZmlx+1elSBusglKUulcg0QaT/D/ei205i3a3KFeWdQVavskD7uNlc54uh2jgZcRr7FDu47pytjWQwvukdtwVdNaSyY0ZrX6Bz1WB+D4x8rwH5KjwZKba2su5lRlO1E4YCEJ16MJQH0p1Y5zfSGdPApq4oOpd3vHhHeGonhoH5/aUJCvVKX8i3IyMxg+wpA7HAL87tFvLSa7KpPBrsLMxpbm6xV6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2FFThNiP7sh3aEKP2yhj7Igao318ofRK1pCe63roR8=;
 b=kaUkYE0PEQaEMjT24GDj04P/UZMwso5PqUidLcz7CrayhZuYwIdzWwLzaNbdkS1AmLfN4P7Vurt6qXsFyM0ehYkgfI7gpEbVva+5LvCoO9wQTwYYOIXbI12wcMQ7JO/2meTZn9utLlZSN6rnW3auvj+kpGGl+QD/iB6Vu4l/ts8=
Received: from SN7PR18CA0005.namprd18.prod.outlook.com (2603:10b6:806:f3::24)
 by LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 23:29:08 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::84) by SN7PR18CA0005.outlook.office365.com
 (2603:10b6:806:f3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:29:08 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:29:02 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 40/59] drm/amd/display: Test global modeset lock acquisition
Date: Wed, 26 Aug 2026 17:05:11 -0600
Message-ID: <20260826231519.881949-41-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: d608a313-8e50-45ca-0174-08df03c9d390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZzHxKrfMA5FlP1RZ495ytlguRpdCPz7yQ6iPdeF1NBymq0Hv4GRMtZfxwb5nTzdK45tuKNmj3bRsbxKtNifzcjTVt6x9cMl2QnLU2PLuNYhsJtT+OQuG2hWkYIl4quZ1zOp3VA3gmvzz/bRHkCdDfjVmfEbCtkuRAlvgzUnYfLzKgqQAgC9QTQkIfR59fbuwg9gh0gRjeHG8e1sg/yy8yBMX4jh/QmPcKJy3t3YQd7JmEdDhoGYywHQ+pjE5bIPHfqkhL5iXBYblX1MQk1MQug8fbZPQRh5khm2fl2Vpz9qheYGlLqFPONMOcxnlkGaZpQ8H3p4XPY3nu2m9Wgja63YugzYW7DnwO6iggBzSQ1o001a4vF4NYVRYfNbM2iGNDLvxKA5fhljwUh09OtNjNqjLnwZrq2UV9oVdJr+yZFHicjta6jIvpa8DmN1qauUxP7k/IZEV5OQtreLwuJGuw+GuI99JBoyfN/jIRPgl9MA5jNIK3YL31/KeboAXOruWUgdazZ2+OMe7fqpAmfq6lDTvfeaQrfQpo5wtZaCp2A/XKCt9dJVW/JwVCC7CsJH44XHT7snWvme18KjCaaaPFZQ4lwaeClKYcCegGwGAxYCWorsLO52+OVD2UQGYO7fzI+bxAY72lfFs+n/iC/3Y+PWB2PHKmaF7h+vwEULpLqFE1n7QWLZz/qGP/Uh18Gnt772krjGGFC9kCSxlx2j4Tg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aWveh2LfOyIg5DzAuX7ltR7+96Qs3iNenToe8u8Om+ZM0Djy+QUwqtnNliQH2lehJR+Rw0MQJ2qoHtPBw8gQTXPRDhB3fLIcQ9P4a/vPXr+w5cupth7HnGwqoMkZXchgh6aueBbObR+QpWGcxX5E4ve8K9hJDrtoJLD4p+xncgb1l1+u6BdMWc5hm1Bopdvun0EPdn+d9XKP2fg+9Xptxcf7hZJBoXjf175e7EX36F5utVfmrbftxs76A2Sa4tt0MAqC90YdT/kthMLLuL2JTvqUfQaX6XRXNqNBbnoptzp+lgeKt+eaDYHdxXfSRbefZweb3y9tqc+OeA5NqO9SvlX3pNMuQlKRJSnV4gGl4Y410HTK5uEZjWAlB9oTp/FAfHo6+ixg1hZ7zw/azrElVPtYdOUKz+ozAxomgGEVt22Qyf3KCREjgwCiNm/sKEOf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:29:08.1751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d608a313-8e50-45ca-0174-08df03c9d390
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215
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
Add KUnit tests for do_aquire_global_lock() covering a device without
CRTCs, a CRTC with no pending commit, and a CRTC whose commit has already
completed.

[HOW]
Pre-signal the commit completions so the waits return immediately. The
extra reference the loop takes is released again, so the commit never
reaches zero and stays test-managed.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 101 ++++++++++++++++++
 3 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5b69794acc58..72962c1c63e3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5311,8 +5311,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
  * Grabs all modesetting locks to serialize against any blocking commits,
  * Waits for completion of all non blocking commits.
  */
-static int do_aquire_global_lock(struct drm_device *dev,
-				 struct drm_atomic_commit *state)
+STATIC_IFN_KUNIT int do_aquire_global_lock(struct drm_device *dev,
+					   struct drm_atomic_commit *state)
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_commit *commit;
@@ -5357,6 +5357,7 @@ static int do_aquire_global_lock(struct drm_device *dev,
 
 	return ret < 0 ? ret : 0;
 }
+EXPORT_IF_KUNIT(do_aquire_global_lock);
 
 static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			 struct drm_atomic_commit *state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index ed3210be7ab8..cec86779b959 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1203,6 +1203,8 @@ bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
 				     struct drm_crtc_state *crtc_state);
 void amdgpu_dm_dump_links_and_sinks(struct amdgpu_device *adev);
 void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state);
+int do_aquire_global_lock(struct drm_device *dev,
+			  struct drm_atomic_commit *state);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
 int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 				const enum surface_pixel_format format,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index de2f2f8af230..97ff91dd7e0f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -2942,6 +2942,104 @@ static void dm_test_update_hdcp_unchanged(struct kunit *test)
 						  DRM_MODE_CONNECTOR_DisplayPort));
 }
 
+/*
+ * Run do_aquire_global_lock() with a fresh acquire context, releasing the locks
+ * it leaves held on @state->acquire_ctx.
+ */
+static int dm_test_run_global_lock(struct kunit *test,
+				   struct amdgpu_device *adev)
+{
+	struct drm_atomic_commit *state = dm_test_alloc_commit(test, adev);
+	struct drm_modeset_acquire_ctx acquire_ctx;
+	int ret;
+
+	drm_modeset_acquire_init(&acquire_ctx, 0);
+	state->acquire_ctx = &acquire_ctx;
+
+	ret = do_aquire_global_lock(&adev->ddev, state);
+
+	drm_modeset_drop_locks(&acquire_ctx);
+	drm_modeset_acquire_fini(&acquire_ctx);
+
+	return ret;
+}
+
+/**
+ * dm_test_aquire_global_lock_no_crtc - Test the global lock is taken without CRTCs
+ * @test: The KUnit test context
+ */
+static void dm_test_aquire_global_lock_no_crtc(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	KUNIT_EXPECT_EQ(test, dm_test_run_global_lock(test, adev), 0);
+}
+
+/*
+ * A CRTC registered on @adev, needed to walk the per-CRTC commit loop.
+ */
+static struct drm_crtc *dm_test_alloc_crtc(struct kunit *test,
+					   struct amdgpu_device *adev)
+{
+	struct drm_plane *primary;
+	struct drm_crtc *crtc;
+
+	primary = drm_kunit_helper_create_primary_plane(test, &adev->ddev, NULL,
+							NULL, NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary);
+	crtc = drm_kunit_helper_create_crtc(test, &adev->ddev, primary, NULL,
+					    NULL, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+
+	return crtc;
+}
+
+/**
+ * dm_test_aquire_global_lock_no_commit - Test a CRTC without a pending commit
+ * @test: The KUnit test context
+ */
+static void dm_test_aquire_global_lock_no_commit(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	dm_test_alloc_crtc(test, adev);
+
+	KUNIT_EXPECT_EQ(test, dm_test_run_global_lock(test, adev), 0);
+}
+
+/**
+ * dm_test_aquire_global_lock_waits_commit - Test a completed commit is waited on
+ * @test: The KUnit test context
+ */
+static void dm_test_aquire_global_lock_waits_commit(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_crtc_commit *commit;
+	struct drm_crtc *crtc;
+	int ret;
+
+	crtc = dm_test_alloc_crtc(test, adev);
+	commit = kunit_kzalloc(test, sizeof(*commit), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, commit);
+
+	/*
+	 * The extra reference taken by the loop is dropped again, so the commit
+	 * never reaches zero and stays KUnit-managed.
+	 */
+	kref_init(&commit->ref);
+	init_completion(&commit->hw_done);
+	init_completion(&commit->flip_done);
+	complete_all(&commit->hw_done);
+	complete_all(&commit->flip_done);
+	list_add_tail(&commit->commit_entry, &crtc->commit_list);
+
+	ret = dm_test_run_global_lock(test, adev);
+
+	list_del(&commit->commit_entry);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -3088,6 +3186,9 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_update_hdcp_no_workqueue),
 	KUNIT_CASE(dm_test_update_hdcp_writeback_skipped),
 	KUNIT_CASE(dm_test_update_hdcp_unchanged),
+	KUNIT_CASE(dm_test_aquire_global_lock_no_crtc),
+	KUNIT_CASE(dm_test_aquire_global_lock_no_commit),
+	KUNIT_CASE(dm_test_aquire_global_lock_waits_commit),
 	{}
 };
 
-- 
2.43.0

