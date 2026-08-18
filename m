Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503F3C5DF90
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE8810ECCE;
	Tue, 18 Aug 2026 20:22:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sNIf2H/o";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012046.outbound.protection.outlook.com
 [40.107.200.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A141610ECBF
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y01tHF2w49M+/AjwNmngTEyhQE21US4+1io2IWVXPgYGtGyo83Hfm3TyeEIurCVvn/g1WUkpYKQvR6itsbKC84aBD8iJP/jlFsqa6pisz4KndvOytmwPIY2hDSS0lOmspwdxKJSI02YlObQAa6tyIek904QuFwnbubi32Owc3Y+8kVULoYe7t3kZUnVA4uxHMNTAERBU5yXY5wYUFYl5c7ZQarGZJ7+st5NCJ5szFr3RK7/xyKCIRByLwIpGsUqDmVZDOHYAJ1EI6lCzC6cXOBdNaYyRB8JzY768G3guVbLpxxgnWGqiBlq10mwIMS1Bt9xptYcirC7UcPdvqpIhPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoUvZajBi6AbDuS5Lo4Xvu6GEm4w5mBWasC3a0+b9ag=;
 b=ICWcXmE0FsPJjDQeXEXUOqNE/LI2wjTzR2t3FSSbZ8/gBwlg1SJFa4n4uRj6rK3YUnVGDUNkmNVhTxTwXQTKQXaMNErZeIaZ/sAWWfpCSdy2yjmBZdqdf6tNnQBjsu4z1Zg4QLlfvwFeqLbNYvBOdPhK3BbJBsFZJu62S59jAcHf/6xENRXbqLPGFcA/p04fj7zR+Ymx4zFF9m5JJsMw+q3KZep5exUKE0tE2Ue6jM62cgQObVMlPQ7MACcVFryXIsFeSMk0osETVJBi6y+FdO2m/BjP3eFMKfvq4f2pvsgJreSIKmYzYHmzC+UVqcUS/hDUak0/5Hmd/Lxm31JPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoUvZajBi6AbDuS5Lo4Xvu6GEm4w5mBWasC3a0+b9ag=;
 b=sNIf2H/oueabFUAi7Srw/BK2oCEClKZv2TSmQ/PYXWbwiKzU1aCGwIi+GNbyDKYQGIIuz0yF+B5nC19nvOiZvlX6IzGYYDroNkolXTxbmHwoLWitHWAt8YXm+8IIh6HmOBftuL7NiUUbigI8e3yaCoX/Ua1+jsB//e2ng376gxE=
Received: from BN9PR03CA0551.namprd03.prod.outlook.com (2603:10b6:408:138::16)
 by IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:43 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::2a) by BN9PR03CA0551.outlook.office365.com
 (2603:10b6:408:138::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:43 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:33 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:32 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 55/82] drm/amd/display: Cover amdgpu_dm_connector_atomic_check
Date: Tue, 18 Aug 2026 16:15:47 -0400
Message-ID: <20260818202139.4172592-56-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b7ff09-c7c1-4ad3-8ef6-08defd6675c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|56012099006|10067099003|11063799006|18002099003|5023799004|22082099003;
X-Microsoft-Antispam-Message-Info: hzHafudBUtdkkAvMNDJuXdLXNwuaiPavhnxLye0RnI9XnmpbZ6+iNYJoLY8XdMHZJnTrWNk8rudrH2mzn5seKAwew8AusBvn73oYzOfq5IGZWlD8n6cz07F0REq4acYwlAoHKJnJ8txGsvpTFVQooQgz8UMVhjlGDrdY5aGQxaRLaI8Hiilu3xOn4gQj0OEtbON329H+jXTD7nMSxvA7XKOnpiiMz66fXcvWIIaAlbefnSfUrUbvq8bswVEAJOONdUVaTGoVCISjR7Br5S1QzlWqGVTzsLweAmX31iHJwN9K7p/XmuYTC4pJREnW+2Gx/y9HdZf6zxbPvjMm1VJ6fsFUOn2zSxMdfLeJSRSPMFJE8zvFxnL2+tlMGmvipbshVIdQVMeZtcikLAcbYyYP1UgYw96lwd3GzNvTBtvrMn8ifSUOIbGMHbEjspauxYbrkF2ZGmt84mdL8CUkHY3TLA5J+dbffZ27ZknmZeifTWm9Txfj1C/QIqYKSmfZxyCtH12CI7vUqXlztBPggFgb0NQ89gHwE+Tq4uMXapnj5QvmmnT9ZSO1/naBn69UrfjISEv4CyMoLHjzQGnmbjAj3m98FaSG1Bp1J3K8Fkl18xojNOXF0oSmrI4+XeZB3ECogDk2vAYEVJehSqUEI28AQjA1e0uXLGF62RxtKoRQIYGwMofgmCUgNLXdqC6V8djqQVK5KCc/VobebfB8AvAXUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(5023799004)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rZy23gU1ckZY7Odm/2xMvTXbEQlbJTSxtuqnE5PLUy8MTGuA3rd9LyNMQUz1iBRYwe6C7RkMnUMYxJqx1h3I4ptuHKdx8OyDmkOmEkRLl+Jnk6q6aDTCuyP1XTfxTspORh8bJJrEypUlIOG0TarJXwADbEIsHXCgJxIZcMQGwap+R5cYa1Edf3o+5YzSzZZyA8m4mRXAVm6bK9mpjyUDBvYcYZFDhjNZxDTZQ2HG94/lrYAau0igOF35Q0KSsHkmnwz+TdTos6w+QScvrmta/sWfi97m2bNWT1uxLdXxrTHaOhIlsso9BG8Hgn5H5V4Deiye9RpT1kAjhxejSL7qE/Iradw0G2oXS40G5Vln21crN5nCMQArn/gZOkM+E9Hht7sP/VWLaar3/dnk4IeC8dM/NqMeVVaA4JnHmGh2AKuOOroO8tbV0TQJJbE/JTRM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:43.7327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b7ff09-c7c1-4ad3-8ef6-08defd6675c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032
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

Add KUnit tests for amdgpu_dm_connector_atomic_check() covering the
no-CRTC early return, the DP-MST connector path, and an unchanged state
that skips revalidation.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   3 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   3 +
 .../tests/amdgpu_dm_connector_test.c          | 109 ++++++++++++++++++
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index ed16e01987726..44c223b178c50 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -2526,7 +2526,7 @@ int amdgpu_dm_fill_hdr_info_packet(const struct drm_connector_state *state,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_fill_hdr_info_packet);
 
-static int
+STATIC_IFN_KUNIT int
 amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
 				 struct drm_atomic_commit *state)
 {
@@ -2607,6 +2607,7 @@ amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_connector_atomic_check);
 
 static const struct drm_connector_helper_funcs
 amdgpu_dm_connector_helper_funcs = {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 4e9eb3ff2c904..3571378654fd7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -222,5 +222,8 @@ void decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 					     bool scale_enabled);
 void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector);
 void amdgpu_dm_update_cacp_caps(struct amdgpu_dm_connector *aconnector);
+struct drm_atomic_commit;
+int amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
+				     struct drm_atomic_commit *state);
 #endif
 #endif /* __AMDGPU_DM_CONNECTOR_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 5c701c6b0511d..47c6caba46889 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -6463,6 +6463,111 @@ static void dm_test_mode_valid_edid_mgmt_forced(struct kunit *test)
 			MODE_ERROR);
 }
 
+/* Tests for amdgpu_dm_connector_atomic_check() */
+
+/*
+ * Build a single-connector atomic commit for amdgpu_dm_connector_atomic_check().
+ * The connector lives at index 0 so the hand-rolled connectors[] slot resolves
+ * both the old and new connector state; leaving crtc NULL keeps the check off
+ * the crtc-state machinery that a real atomic path would require.
+ */
+struct dm_test_conn_ac_ctx {
+	struct amdgpu_dm_connector *aconn;
+	struct drm_atomic_commit *state;
+	struct drm_connector_state *old_state;
+	struct drm_connector_state *new_state;
+};
+
+static struct dm_test_conn_ac_ctx *
+dm_test_conn_ac_ctx_alloc(struct kunit *test, int connector_type)
+{
+	struct dm_test_conn_ac_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->aconn = kunit_kzalloc(test, sizeof(*ctx->aconn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconn);
+	ctx->old_state = kunit_kzalloc(test, sizeof(*ctx->old_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->old_state);
+	ctx->new_state = kunit_kzalloc(test, sizeof(*ctx->new_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->new_state);
+
+	ctx->state = dm_test_alloc_atomic_state(test, 1);
+
+	ctx->aconn->base.connector_type = connector_type;
+	ctx->new_state->connector = &ctx->aconn->base;
+	ctx->new_state->state = ctx->state;
+	ctx->old_state->connector = &ctx->aconn->base;
+
+	ctx->state->connectors[0].ptr = &ctx->aconn->base;
+	ctx->state->connectors[0].old_state = ctx->old_state;
+	ctx->state->connectors[0].new_state = ctx->new_state;
+
+	return ctx;
+}
+
+/**
+ * dm_test_conn_atomic_check_no_crtc - Test the unbound-connector short-circuit
+ * @test: The KUnit test context
+ *
+ * A non-DisplayPort connector with no crtc has nothing to validate and returns
+ * 0 immediately.
+ */
+static void dm_test_conn_atomic_check_no_crtc(struct kunit *test)
+{
+	struct dm_test_conn_ac_ctx *ctx =
+		dm_test_conn_ac_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	int ret;
+
+	ret = amdgpu_dm_connector_atomic_check(&ctx->aconn->base, ctx->state);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/**
+ * dm_test_conn_atomic_check_dp_mst - Test the DisplayPort MST root check
+ * @test: The KUnit test context
+ *
+ * A DisplayPort connector runs the MST root atomic check; with no crtc bound on
+ * either state it finds nothing to reserve and returns 0.
+ */
+static void dm_test_conn_atomic_check_dp_mst(struct kunit *test)
+{
+	struct dm_test_conn_ac_ctx *ctx =
+		dm_test_conn_ac_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	int ret;
+
+	ret = amdgpu_dm_connector_atomic_check(&ctx->aconn->base, ctx->state);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/**
+ * dm_test_conn_atomic_check_no_change - Test the bound-but-unchanged path
+ * @test: The KUnit test context
+ *
+ * With a crtc bound but no privacy/colorspace/content-type/HDR differences the
+ * check skips every modeset trigger and returns 0 without touching the crtc
+ * state.
+ */
+static void dm_test_conn_atomic_check_no_change(struct kunit *test)
+{
+	struct dm_test_conn_ac_ctx *ctx =
+		dm_test_conn_ac_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+	struct drm_crtc *crtc;
+	int ret;
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	ctx->new_state->crtc = crtc;
+
+	ret = amdgpu_dm_connector_atomic_check(&ctx->aconn->base, ctx->state);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
 /**
  * dm_test_update_after_detect_mst_noop - Test MST connectors are left to drm_mst
  * @test: The KUnit test context
@@ -7140,6 +7245,10 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_fill_hdr_dp),
 	KUNIT_CASE(dm_test_fill_hdr_unsupported_connector),
 	KUNIT_CASE(dm_test_fill_hdr_bad_metadata),
+	/* amdgpu_dm_connector_atomic_check */
+	KUNIT_CASE(dm_test_conn_atomic_check_no_crtc),
+	KUNIT_CASE(dm_test_conn_atomic_check_dp_mst),
+	KUNIT_CASE(dm_test_conn_atomic_check_no_change),
 	/* amdgpu_dm_connector_atomic_set_property */
 	KUNIT_CASE(dm_test_set_property_scaling_center),
 	KUNIT_CASE(dm_test_set_property_scaling_aspect),
-- 
2.43.0

