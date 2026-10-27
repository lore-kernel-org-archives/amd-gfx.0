Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC96606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tSxb0QhU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B00A10F8B9;
	Tue, 27 Oct 2026 23:26:00 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010028.outbound.protection.outlook.com
 [52.101.193.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC94610F8B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2WEovUO/jpd7nKfyQwMyjJNUnQVADe3iU+tv4fqdI7kmysxGsZ8s2TRH5Q+5rNdGdAIUmrLxzx3qX12u+aUmpj7yJKn+OccF1uroh6ZRUpAa0FMWCCgHiipVCpZpRqbW4350X3FobcV2fQDjElKaVQFVdCMuNLzHGhvicUrmoAhiZjtkAVEHpPmXEz5wE90bkH+H4hEmgCIH4tyFAFmJydSeUgWGslRetAnMGI3z6Ek3DdFcBGgeEyRFEA+F9srKUntdoxIh71smzuias7LIuEpX1c+Eeb7aNm5fimxuv5VZ59GiLxpG7dWX8aOiGek0YrWQBPweS19TdpO7rtldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvfWEt0SCWpRWaxS2SY9H7Kv8zoIi8cmAb8HES8wifw=;
 b=t2+Y6K592aE+mTN4txYr4rRwcV08FR59BumHnv3oQuJ6r23qkTS5FZ3mAuk2riq7WmF9TPjZ84WmbUJzw063PBNxmHvKUYy1oHpl78yJsZlEv/lFE8tPygsdSGmeQIQa4Y8mnSuSV/Pfcp6KtD+CxsA18mGtSZI3W7KSGbyY0R9g95QkRdJ500712jZT4qy66rQVXSmqGxIM589tOMJeMwP7uCCJjTBCs70A7aikBq+Gjw7iYlSup2iPDV5MdkfK2L6astbjg92WP/Ejh6R2U1e81cxv/LwVmWEumxG6EGOEXqwjnS0z3AJgwHClXdTmgW4u9ARvF1YUOezD2nJDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvfWEt0SCWpRWaxS2SY9H7Kv8zoIi8cmAb8HES8wifw=;
 b=tSxb0QhUS/9Ux7LgOQ88DccmJm5weVBFzCG9kvL4vz/co8mBvbWcuokP35M6JagDPU1Bd4S5/ckv+svYpbWgZSa7Cg41g6cmgTQGakKsdmX6WBgJ/C7W3jUIHjIaaHndDKAS3pbvRI1juSSdqFb0ymp2cb93q1+0c782moK/7aw=
Received: from CH2PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:59::32)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:25:45 +0000
Received: from CH01EPF000BE942.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::62) by CH2PR03CA0022.outlook.office365.com
 (2603:10b6:610:59::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:25:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE942.mail.protection.outlook.com (10.167.244.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:25:45 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:25:43 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 24/28] drm/amd/display: Add more CRC KUnit tests
Date: Tue, 27 Oct 2026 17:17:20 -0600
Message-ID: <20261027232005.2879750-25-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE942:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d892fd9-09be-4241-7091-08df3481a023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261022075727099003|260925021911599003|261026121527099003|260925021311599003|260925022911599003|11063799006|56012099006|261009223027099003|261022105027099003|261026140227099003|261021121427099003|261021123027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1NCx3x+Y1eJ/rnr5OxANDR8RxDTU6qRZTt3JZ1SsR1C7yq05dLETwAzzvyq1QdTumq3XXwDJpSB81Wk84Fhb5Udgakjn8e9k4TYU5ggScpUrZ2GsMX0mSm2Y4Al5AMaEEXvnkOS1oRqWowLrdEVRSfYeZAqQCFyoyzfCfOJBB8G/VsTa4mtevpW7DboHja6QpwZ50EU58PpugPeRUyfjAEV5nlGZquS6vxz1wAuDnX7F3s8pbOQ6pdPFf0FvY8SNjU/53/nh3dbXa1QTmKmArL0STHYSqOBpnyAufzWfdxIR7f/HJsWCnGq0KCgARY6Fj6vyjdhq2z5EaCAMdp10JaHc/Czpct7XgM2N4/GyahMW7xWLvC5Our+pc088s6Ghl75muoBypFUnOlr5awA6UqmtHB9NQUD32xMDAqMNU4gwL8EHk5mYValcYpW1yw4nHJ59RqfgxMQ3iLd6OeWGqG7ElcY1jqZ5BBb1+Wjn8KIv4xDz64enHa20TTNtI+ouoXRYQU2fNIl/9gW0+EunSZK/dfBMIjfeT4+D5YrlCEjkrr1I5E0o1ZSNJoe9mKFpVoj3rEAlprJCBKpVECFZdaXq7IaqCTBFyYrdHQHEl4LydZ38WhQRXDVQ8E3NbnV3YtGJuHmpDb1W1sPX8pCJ/ChvfYSWB6hXqUL9m5so659ONI+YwLjNxVs+z7dM9E9w3KDV/hGt3RgTmTWgepTNqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261022075727099003)(260925021911599003)(261026121527099003)(260925021311599003)(260925022911599003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261026140227099003)(261021121427099003)(261021123027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n1NDlG/CKoyLChq1579uwPDSVJ2J8CT4AU5mq/Jc8dreInrhrheVMx0R/jX+HORsomWxW6G2wEtvEjJQQTd1DchHCeKoHy7I2/DHDiF8nD6VUsbRs4OqDfm9Nipkh/TMRB3ofhtGaRucDJR7Wadj3xs9+4FUCsd50vMy/8o+tx8Ig5L4Us9OyNGa4OWCPUiCxJQi7x627aERINfqias3jgn4ywfc3KxCeKWymrCTj7cfBAx/LF5Cx1R4HUFvPKLf+gcZagj3qjX9LExfBweZ1WWzh9ax3BSq4SXNfuXXtm/lNQlHisO+Rr/GMi/5YrUZa2yLFlghd5tFS253h9XUt44TjgvdsgguAthfcv26B6GedS4DEV3CZK8jy8lHY6AC1nh35sPZbi2CBSnZWaaaGSHp7LDuAOQDd7HpG98xgibQ7iELD8bSLyh9HRgfq9et
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:25:45.1449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d892fd9-09be-4241-7091-08df3481a023
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE942.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[WHAT]
Add KUnit tests for amdgpu_dm_crc.c:
- amdgpu_dm_crtc_set_crc_source(): a DPRX source on a non-DP
  connector bound to the CRTC, a DPRX source on a DP connector that
  fails to take a vblank reference, and switching from the CRTC
  source to none.
- amdgpu_dm_crtc_handle_crc_irq(): delivering a CRTC CRC read from DC
  to the DRM CRC entry queue.

[HOW]
Bind an amdgpu_dm_connector to the CRTC and request "dprx" first as
HDMI, then as DisplayPort on a device without vblank support. Reuse
the DC CRC fixture with a held vblank reference to turn CRTC CRC off
and check the source, skip count and vblank refcount. Register a real
CRTC with vblank support and CRC entries to check the queued CRC.

Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
index 29a513dab9cd..7f6340702502 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
@@ -10,8 +10,10 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_connector.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_modeset_lock.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
 
 #include "dc.h"
 #include "core_types.h"
@@ -187,6 +189,11 @@ static void dm_test_crc_connector_cleanup(void *data)
 	drm_connector_cleanup(data);
 }
 
+static const struct drm_crtc_funcs dm_test_crc_crtc_funcs = {
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
 static void dm_test_parse_crc_source_none(struct kunit *test)
 {
 	KUNIT_EXPECT_EQ(test, AMDGPU_DM_PIPE_CRC_SOURCE_NONE, dm_parse_crc_source("none"));
@@ -673,6 +680,77 @@ static void dm_test_crtc_set_crc_source_dprx_no_connector(struct kunit *test)
 			AMDGPU_DM_PIPE_CRC_SOURCE_NONE);
 }
 
+/**
+ * dm_test_crtc_set_crc_source_dprx_connector() - Test DPRX connector checks.
+ * @test: KUnit test context.
+ *
+ * Verifies that a DPRX source is rejected for a non-DP connector bound to the
+ * CRTC, and that a DP connector passes the AUX lookup but still fails when the
+ * device has no vblank support.
+ */
+static void dm_test_crtc_set_crc_source_dprx_connector(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct amdgpu_dm_connector *aconn;
+	int ret;
+
+	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconn);
+	/* Init as DP: drm_connector_cleanup() frees the type id from this type's IDA. */
+	ret = drm_connector_init(&adev->ddev, &aconn->base, &dm_test_crc_connector_funcs,
+				 DRM_MODE_CONNECTOR_DisplayPort);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	ret = kunit_add_action_or_reset(test, dm_test_crc_connector_cleanup, &aconn->base);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	drm_atomic_helper_connector_reset(&aconn->base);
+	KUNIT_ASSERT_NOT_NULL(test, aconn->base.state);
+	aconn->base.state->crtc = &acrtc->base;
+	/* Balance the reference the state destroy drops for a set CRTC. */
+	drm_connector_get(&aconn->base);
+
+	aconn->base.connector_type = DRM_MODE_CONNECTOR_HDMIA;
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_set_crc_source(&acrtc->base, "dprx"), -EINVAL);
+
+	aconn->base.connector_type = DRM_MODE_CONNECTOR_DisplayPort;
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_set_crc_source(&acrtc->base, "dprx"), -EINVAL);
+	KUNIT_EXPECT_EQ(test, acrtc->dm_irq_params.crc_src, AMDGPU_DM_PIPE_CRC_SOURCE_NONE);
+}
+
+/**
+ * dm_test_crtc_set_crc_source_crtc_to_none() - Test turning CRTC CRC off.
+ * @test: KUnit test context.
+ *
+ * Verifies that switching from the CRTC source to NONE disables DC CRC capture,
+ * drops the vblank reference held while CRC was on, records the new source and
+ * resets the skip counter.
+ */
+static void dm_test_crtc_set_crc_source_crtc_to_none(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct dm_test_crc_dc_fixture *fixture;
+	int ret;
+
+	fixture = dm_test_alloc_crc_dc_fixture(test, adev);
+	fixture->dm_state->crc_skip_count = 2;
+	acrtc->base.state = &fixture->dm_state->base;
+	acrtc->dm_irq_params.crc_src = AMDGPU_DM_PIPE_CRC_SOURCE_CRTC;
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
+	atomic_set(&adev->ddev.vblank[0].refcount, 1);
+	dm_test_crc_dc_ctx = fixture;
+
+	ret = amdgpu_dm_crtc_set_crc_source(&acrtc->base, "none");
+	dm_test_crc_dc_ctx = NULL;
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, fixture->configure_crc_called);
+	KUNIT_EXPECT_FALSE(test, fixture->crc_params.enable);
+	KUNIT_EXPECT_EQ(test, atomic_read(&adev->ddev.vblank[0].refcount), 0);
+	KUNIT_EXPECT_EQ(test, acrtc->dm_irq_params.crc_src, AMDGPU_DM_PIPE_CRC_SOURCE_NONE);
+	KUNIT_EXPECT_EQ(test, fixture->dm_state->crc_skip_count, 0);
+}
+
 /**
  * dm_test_crtc_handle_crc_irq_early_returns() - Test null/missing state exits.
  * @test: KUnit test context.
@@ -799,6 +877,49 @@ static void dm_test_crtc_handle_crc_irq_get_crc_fails(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, fixture->dm_state->crc_skip_count, 2);
 }
 
+/**
+ * dm_test_crtc_handle_crc_irq_adds_entry() - Test CRC delivery to DRM.
+ * @test: KUnit test context.
+ *
+ * Verifies that a CRTC CRC read from DC after the skip window is queued as a
+ * DRM CRC entry on a registered CRTC.
+ */
+static void dm_test_crtc_handle_crc_irq_adds_entry(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dm_test_crc_dc_fixture *fixture;
+	struct amdgpu_crtc *acrtc;
+	struct drm_crtc_crc *crc;
+	int ret;
+
+	acrtc = drmm_kzalloc(&adev->ddev, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	ret = drmm_crtc_init_with_planes(&adev->ddev, &acrtc->base, NULL, NULL,
+					 &dm_test_crc_crtc_funcs, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, drm_vblank_init(&adev->ddev, 1), 0);
+	crc = &acrtc->base.crc;
+	crc->entries = kunit_kcalloc(test, DRM_CRC_ENTRIES_NR, sizeof(*crc->entries), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crc->entries);
+	crc->values_cnt = 3;
+
+	fixture = dm_test_alloc_crc_dc_fixture(test, adev);
+	fixture->dm_state->crc_skip_count = 2;
+	fixture->get_crc_return = true;
+	fixture->crc_r = 0x111;
+	acrtc->base.state = &fixture->dm_state->base;
+	acrtc->dm_irq_params.crc_src = AMDGPU_DM_PIPE_CRC_SOURCE_CRTC;
+	dm_test_crc_dc_ctx = fixture;
+
+	amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
+	dm_test_crc_dc_ctx = NULL;
+	/* Keep drm_crtc_cleanup() from freeing the KUnit-managed state. */
+	acrtc->base.state = NULL;
+
+	KUNIT_EXPECT_EQ(test, crc->head, 1);
+	KUNIT_EXPECT_EQ(test, crc->entries[0].crcs[0], 0x111U);
+}
+
 /**
  * dm_test_need_dp_aux() - Test dm_need_dp_aux().
  * @test: KUnit test context.
@@ -944,12 +1065,15 @@ static struct kunit_case dm_crc_test_cases[] = {
 	KUNIT_CASE(dm_test_crtc_set_crc_source_none_no_stream),
 	KUNIT_CASE(dm_test_crtc_set_crc_source_none_commit),
 	KUNIT_CASE(dm_test_crtc_set_crc_source_dprx_no_connector),
+	KUNIT_CASE(dm_test_crtc_set_crc_source_dprx_connector),
+	KUNIT_CASE(dm_test_crtc_set_crc_source_crtc_to_none),
 	/* amdgpu_dm_crtc_handle_crc_irq() */
 	KUNIT_CASE(dm_test_crtc_handle_crc_irq_early_returns),
 	KUNIT_CASE(dm_test_crtc_handle_crc_irq_disabled_source),
 	KUNIT_CASE(dm_test_crtc_handle_crc_irq_skips_initial_frames),
 	KUNIT_CASE(dm_test_crtc_handle_crc_irq_dprx_after_skip),
 	KUNIT_CASE(dm_test_crtc_handle_crc_irq_get_crc_fails),
+	KUNIT_CASE(dm_test_crtc_handle_crc_irq_adds_entry),
 	/* dm_need_dp_aux() */
 	KUNIT_CASE(dm_test_need_dp_aux),
 	/* dm_crc_source_should_start_dprx() */
-- 
2.53.0

