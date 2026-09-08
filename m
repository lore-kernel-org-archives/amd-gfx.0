Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83995C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A6410EB36;
	Tue,  8 Sep 2026 11:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="At/Xku1T";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9225610EB36
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:35:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ch1UJLtIUQsRKq9uv5tB/ALLN7GpVTSk5F9DIgqt+IDBnti5oTZNMbaIow2FVhxBtmtO2t9Qi8QkfeKkwHxq6Fwepc3j+ifWsnt+krctgubszdF7h0JXG231U6SHrAIC4063JjmPZtVFaDyCQU5bFG21wtMDobA9lS3/AlR9ws39Tls7JS2JSfMrci6NpcnKL95RmFVZpMtlskxSApd5+GlVa+nrdtaXNDj3VPp9Ms1APoV9SbgQEFbjhuJNRwuJfkd64BRuH67aFod1lr+RX7NmhqRFUn39Z11I6w1NzDCKswzQqzqH6xQ3YlfqIiIoI4sP0IQLGkXeHuOtx0xQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+vx20HKiAYW8D+gqY2msXx1lhJNidl6rSjdBnwFh1c=;
 b=mmjR+Umf4kd901RBUqZN7TJ3tc1GgZOqaJiRYUHl7J3kqqqEU5wktbjQWAfA9j1cpZCX61j72QQEiQ7lAdxqjfBtO4CDYottiwj+Srs4e+riS0RL6nsR2br++ug+o/4Uf6XVXj6U2ZEhIcncvidYCdwM4POdvRsTVK9CUzJiW5UWisVMYZkJGxoReUrKeO3sxdXhweJE7Yr/J9jo44M6BdM4ta+VjfkGe7CvyQooCQmCBJlcRR5MiyYSIK4M4Pbsh1PMJMpWua865ydaOO5UUZCmdfcrqF3Hwbkfjvcu4LgAfTJ6xcuTJwBLKf2yWNtSbzG5f+PPyISMM9kxMbScGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+vx20HKiAYW8D+gqY2msXx1lhJNidl6rSjdBnwFh1c=;
 b=At/Xku1TB2pKOEIDtq0Yq2wbpN+hL4YUZgI4K23ltTdNiYhFK5iiYloPN4INGmdFuF+1HKBOxODq3avyn8X0hiCqcM3QesTQ/iKd42Q4/3n0/AzlqZ5QdV16Wef+l2YiUG8cecX48Gw70nA8k+rWk5ft8xBEoaTwINwFnqwyGC4=
Received: from BN9PR03CA0313.namprd03.prod.outlook.com (2603:10b6:408:112::18)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 11:35:16 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::81) by BN9PR03CA0313.outlook.office365.com
 (2603:10b6:408:112::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:35:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:35:15 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:35:06 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 10/66] drm/amd/display: Test forced atomic commit
Date: Tue, 8 Sep 2026 19:31:03 +0800
Message-ID: <20260908113338.2433445-11-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 294733d2-5abc-41e5-3a85-08df0d9d4138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|18002099003|22082099003|18092099006;
X-Microsoft-Antispam-Message-Info: yZ/cDJUIdSCaO8B80K2k3rNzDYtOH0sBjC++SrOUW42WwPjIOISxYXt+TNfh1/MzcOgb4nNwHJFw6xKH5wCteJrpUbLMMsPJaOy2AjoWJNeMYRO1jj/VKw/VS9K+vWY1W01YaasKNUYkp0TniNZUuae5VwPPT3div6WSNo0zwk9WjTdQin9M9z3m0Id4wZMzMqH8Tly/DRKUaQDx8zT1TeT/7TN8QCmBmxZYpthIFLWPF6UWKB3AxkIr2XS5NfwAh/6Xis0FG1qKsIl1XsJftmL0q1sKU/ZgQq0GU8EcXcqaI0eVBqzQ63bkUCLC5dV860nccKbpx/PY5asiBhWmpUTyK6qCDOSs2cHmuwM92c/KLMMNtWvDd6ZGre+Y/OMIVFXPw4speodSWBfS0oh5x2KUGEwyhrqlM+mEwzvJpXun5E4jM0GmAHttOCEKN0gxY0z/ROi8+qgFGCOeChWko/y6ajxWA9jpMlqyYbH56E9gNCQ457mvSVd2eWVAFiRLLh62BRhhK7N95u3jf0rxY4LGE+QyOKA17Kcg59DOtodWoJZUdoYSHUVp3iQVAKYl0m+FLNUKVkoNSLb5rBOWhBt7ZxDt1azZYJx3v9wVJJ4g8O0oli2fBPjz6DFzVj8qdEob+0HTkAwTI1TFDyRcNEwmUP+W5ipoKerMajwv7MHqEO8zVal3e52UZp6l3yzj4MGu3tyAf+GcXLlpYkM2+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T7HmoKvVcWK2sfuE53G8aPsT9MDElz9y2fIYt1f97uQmVtxBnYRnSgh5AN2G6Ekf/H0w9wDoFGApWBESjzlQW5KbrRFaseFDTYr7tg8PbdYE5xopwU+f0VG2qJzxrB8f2e5k9/nOBb+bVurAdnzvDRyVlgXgApN59JB8shjb/tLXT+g6vYw8hiYPVWXBmTv6q0E/1HmqxfP+FqCHsmcwN70UrDITM37chr9lGL3V2n671j5TK4crVeX8bnxD5AJ4JdbKCZqA/z7s/1hgwpUc/Nbz2996zwGOdL5I1uRh09nuWMfI3WHBeO4TBfbnuFfwZyw2RvH37hIghzP0CC9vL3vuqf8ynp4wzyx19rsmP7hLN6TBgzcLWRz7mVv2xhYniI1UzKkhGDRw93IPMeAA4G4GGWc1oJAlx9KuXYvqKGnEHN92HOkmEdV822GPdzXU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:35:16.4711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 294733d2-5abc-41e5-3a85-08df0d9d4138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
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
Add KUnit tests for dm_force_atomic_commit() covering a successful
restore of the connector, its CRTC and the CRTC primary plane, and the
error path taken when the connector state cannot be duplicated.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   3 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   1 +
 .../tests/amdgpu_dm_connector_test.c          | 131 ++++++++++++++++++
 3 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 7056bb6f7e26..4fb992871b95 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3448,7 +3448,7 @@ int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_init);
 
-static int dm_force_atomic_commit(struct drm_connector *connector)
+STATIC_IFN_KUNIT int dm_force_atomic_commit(struct drm_connector *connector)
 {
 	int ret = 0;
 	struct drm_device *ddev = connector->dev;
@@ -3508,6 +3508,7 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
 
 	return ret;
 }
+EXPORT_IF_KUNIT(dm_force_atomic_commit);
 
 /*
  * This function handles all cases when set mode does not come upon hotplug.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index e42a0d53b549..dec4f35765b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -239,5 +239,6 @@ void amdgpu_dm_update_cacp_caps(struct amdgpu_dm_connector *aconnector);
 struct drm_atomic_commit;
 int amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
 				     struct drm_atomic_commit *state);
+int dm_force_atomic_commit(struct drm_connector *connector);
 #endif
 #endif /* __AMDGPU_DM_CONNECTOR_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index d63529336d69..cbdcea33f097 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -10046,6 +10046,134 @@ static void dm_test_conn_init_get_modes_hook(struct kunit *test)
 	KUNIT_EXPECT_GT(test, ctx->aconnector->num_modes, 0);
 }
 
+/* Tests for dm_force_atomic_commit() */
+
+/* Fails the very first state duplication so the error path is taken. */
+static struct drm_connector_state *
+dm_test_force_dup_state_fail(struct drm_connector *connector)
+{
+	return NULL;
+}
+
+static const struct drm_connector_funcs dm_test_force_fail_funcs = {
+	.reset = amdgpu_dm_connector_funcs_reset,
+	.atomic_duplicate_state = dm_test_force_dup_state_fail,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+/* The atomic modeset check dereferences the helper funcs unconditionally. */
+static int dm_test_force_get_modes(struct drm_connector *connector)
+{
+	return 0;
+}
+
+static const struct drm_connector_helper_funcs dm_test_force_conn_helper_funcs = {
+	.get_modes = dm_test_force_get_modes,
+};
+
+struct dm_test_force_ctx {
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_modeset_acquire_ctx acquire_ctx;
+};
+
+static void dm_test_force_drop_locks(void *data)
+{
+	struct dm_test_force_ctx *ctx = data;
+
+	ctx->drm->mode_config.acquire_ctx = NULL;
+	drm_modeset_drop_locks(&ctx->acquire_ctx);
+	drm_modeset_acquire_fini(&ctx->acquire_ctx);
+}
+
+/*
+ * Build a disabled but fully initialized pipe: a primary plane, a CRTC (whose
+ * drm_crtc is the first member of amdgpu_crtc, so to_amdgpu_crtc() resolves)
+ * and a connector wired to an encoder that still points at the CRTC, which is
+ * the state dm_force_atomic_commit() is asked to restore.
+ */
+static struct dm_test_force_ctx *
+dm_test_force_ctx_alloc(struct kunit *test, const struct drm_connector_funcs *funcs)
+{
+	struct dm_test_force_ctx *ctx;
+	struct drm_encoder *encoder;
+	struct drm_plane *primary;
+	struct drm_crtc *crtc;
+	struct device *dev;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	ctx->drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						       sizeof(struct amdgpu_device),
+						       offsetof(struct amdgpu_device, ddev),
+						       DRIVER_MODESET | DRIVER_ATOMIC);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
+
+	primary = drm_kunit_helper_create_primary_plane(test, ctx->drm, NULL, NULL,
+							NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary);
+	crtc = drm_kunit_helper_create_crtc(test, ctx->drm, primary, NULL, NULL, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
+
+	ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx->aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	KUNIT_ASSERT_EQ(test,
+			drmm_connector_init(ctx->drm, &ctx->aconnector->base, funcs,
+					    DRM_MODE_CONNECTOR_HDMIA, NULL), 0);
+	drm_connector_helper_add(&ctx->aconnector->base, &dm_test_force_conn_helper_funcs);
+
+	encoder = drmm_kzalloc(ctx->drm, sizeof(*encoder), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, encoder);
+	KUNIT_ASSERT_EQ(test,
+			drmm_encoder_init(ctx->drm, encoder, NULL,
+					  DRM_MODE_ENCODER_TMDS, NULL), 0);
+	encoder->crtc = crtc;
+	ctx->aconnector->base.encoder = encoder;
+
+	drm_mode_config_reset(ctx->drm);
+
+	drm_modeset_acquire_init(&ctx->acquire_ctx, 0);
+	ctx->drm->mode_config.acquire_ctx = &ctx->acquire_ctx;
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_force_drop_locks, ctx), 0);
+
+	return ctx;
+}
+
+/**
+ * dm_test_force_commit_succeeds - Test the forced restore commits the pipe
+ * @test: The KUnit test context
+ *
+ * The connector, its CRTC and the CRTC primary plane are pulled into a fresh
+ * atomic state, the CRTC is marked as needing a modeset and the commit
+ * succeeds.
+ */
+static void dm_test_force_commit_succeeds(struct kunit *test)
+{
+	struct dm_test_force_ctx *ctx =
+		dm_test_force_ctx_alloc(test, &dm_test_connector_funcs);
+
+	KUNIT_EXPECT_EQ(test, dm_force_atomic_commit(&ctx->aconnector->base), 0);
+}
+
+/**
+ * dm_test_force_commit_conn_state_error - Test a failed connector state duplication
+ * @test: The KUnit test context
+ *
+ * When the connector state cannot be duplicated the error is propagated and
+ * the partially built atomic state is released without committing.
+ */
+static void dm_test_force_commit_conn_state_error(struct kunit *test)
+{
+	struct dm_test_force_ctx *ctx =
+		dm_test_force_ctx_alloc(test, &dm_test_force_fail_funcs);
+
+	KUNIT_EXPECT_EQ(test, dm_force_atomic_commit(&ctx->aconnector->base), -ENOMEM);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -10471,6 +10599,9 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_conn_init_hdmi),
 	KUNIT_CASE(dm_test_conn_init_dvi),
 	KUNIT_CASE(dm_test_conn_init_get_modes_hook),
+	/* dm_force_atomic_commit */
+	KUNIT_CASE(dm_test_force_commit_succeeds),
+	KUNIT_CASE(dm_test_force_commit_conn_state_error),
 	{}
 };
 
-- 
2.43.0

