Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F12C4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F270F10F097;
	Wed, 15 Jul 2026 13:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0j5pbiuu";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B84F10F097
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:47:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFUh9yzWQtPVKbUZ3hmsxxUoqQlv6s+ya2s+KlCKLnLFA69ABzwhEx09CL6W4GXSR8UAkF/75ePdsDSFPwgGr8FX9ObV65Ojel1nHF6ArjNEIVDPJ+SUPVUBcQCls9obIUfN+LhbUKMEu5ijV+VCyByTT1/4gGjFX5E6F6fRJsuim9Fij3ESCoGgiemT6w4LCz6MRs1NppWoADYF11yE/UlIJPToKvZQvrxW8XdHNxloczMCuTXPixmpwgnSH1Oq/6XyZxvGLg3EA1aKq2Mlxx9/PcoZ0HQFiIF6V8snuk94kSxMTPHxBmORxBlwnM1F1meT36P0nJCpgJR3RoBq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEMHN56zcrlTJskqZQcCWLBBghvSiYe1g+Dp+3z4jd4=;
 b=JQZr+liAe3/J63x+VZqqSewSrN/O743bmIrzb5JbprXcdcqcuvpkO3unUwk+B7SD2UN00mrFQ4665Qo6ghMjYc8YEIY20o3FsFLoDo7idkE9QOKM+nQDglpzujRgDNHKcSAeMpXGs3ncc05RvqPGY8MEdEjhjoalVeW8pF9Bei2TWudNzsM/tSa+KCqOVZku5L6booJV8Wa3y9FHhmspOii4WVVfUdsC4FVE/uipglSlkrmcFXphwGjTbdcBtrNlvJ25CZrFe67gE5Db2YXGaACx24YJsur4a88hYAZszgA+ETEqQJ7dvcaY0U4i8V33EvVbsFc7X7tW+n5R3ZJ1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEMHN56zcrlTJskqZQcCWLBBghvSiYe1g+Dp+3z4jd4=;
 b=0j5pbiuufrD7vUQt7PEwzVgTSo1CUy8wvltEMzNmbdSjKMtcjx04HN8PTuA1uO5GsZyzKXJkhsszEOV72AFUDfqTv7Vj/cMW9AmUzKWp8JNRAz7qAJjme1UC0SIOPkPEyO42ZScm08dHSSYb61ZDX/WJ9pXKQ/IXu2i02J4AwxA=
Received: from PH1PEPF00013312.namprd07.prod.outlook.com (2603:10b6:518:1::d)
 by DS4PR12MB9610.namprd12.prod.outlook.com (2603:10b6:8:277::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 13:47:32 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF00013312.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:47:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:31 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:28 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 42/70] drm/amd/display: add CRC set-source KUnit coverage
Date: Wed, 15 Jul 2026 21:37:52 +0800
Message-ID: <20260715134432.1975118-43-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DS4PR12MB9610:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1a818d-a783-402a-0589-08dee2779e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: P4fAPdVe4Xv09huqID0Sm0xlVSpW2ONJZf9V8BSi5b4bvx/e8JHP+yGrQvT2CysVxv1TC28b7sjDrftQA8/lUqsMJvZpL2oC9FEO3UaPZF485XbG9Cjz5cUgxwrh0LBB3RrC+JP+GVEqIyTZmWgK1uHGECNy6wTDlJv4jbm7d6n5Ck1oF9muc6l/M1IEOJSZUhYEhxWiRaGSRoftp2MtLIIEr4/zUk96a47KKdVGdXFnvboZRd5HqpKpoJp8RE+2D9pvAdTso81iCpJhzmr/NHnxCfOpwvxL72Wyg1UgvHPcgbzi0JPZwhtgS2hVIvuyWps/UPY8mHp8XkNXfZu3n7Qb4dp7s1if8QOA3Zh6ZzklLLyhHMMlX+yycz1rz3w6xtnhkGFKe1Iq/tqMnGLIPxh7uUWqBH9QJ2G4Cv2fmKFYNt5OYU3x7ns/bOysbKglOQlvvoz6x4cuaSZAwdRd8yiwMYxER8sXKbQv5xnSo0j5fi9Q8cPDZhZUZtQ2isRJxJEkC3uVKTA+h24Vzsh6FmqGsxPFpBG0p2rc74wIatTyFhEXn1im/P4N4l+h3h2R02r7kchzSvYDuKQlOHQse0Qh7GwUsuOeVVf1FoQH0oAAJ/WVAxeeC7NCWBVO+WHp4yE93xHD2QvZ111jKvB5cRweOjC1lIEmopDBGllo4IsxWzmjlK9hjf3/yxXVVzVRLda63JBko4U2EO+8dmpvOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OqmPTbLmH+p+IOqwia5gwLC3dNka6KnJqdB67o2Ie3OPrmwfRpgkl215Am+3wpaBGhbZDBBERuTebl+3uKLqJOdWVn3aBaTuUhVCoyv/b7Nb93k81WNUeuHaht0of+wGfTvqRtaXwAq5eNrph5Mp9t2SMvkd+9aKfiUkLteHQ7UX1R9a9yYiEF2P9B8Kt6T1HXCz4j14Za3AbpZxOGpt854TWs0bBQm+6UgdCM0Hdwxc2QhrI8M+Hv+9SaA3U4+CFbcLxnHFlPktT8n2OlBgdFtg8azrLn74rHL5prSrc0k5uZeKuKKvDhi7hAXnGMgrosnuc8F0Qca/R9vKsUTQTkjkQQQixIzbMd+3Av9e+ioHLEo6jCphY2WVCZe41dWeTenCbTyv3UYuu/bTqHg5x5miOXzDdc2Vx8G5RRCBwptA+MbuZUJ47fC6L1k1xOpJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:47:32.0660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1a818d-a783-402a-0589-08dee2779e84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9610
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
Expose amdgpu_dm_crtc_set_crc_source() for KUnit and add tests for the
invalid-source guard, the valid NONE no-stream exit, the pending-commit
wait/put path, and the DPRX connector-walk that returns -EINVAL when no
matching DP connector is attached.

Add connector test helpers (drm_connector_funcs plus a cleanup action)
to back the DPRX connector-walk test.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      | 161 ++++++++++++++++++
 2 files changed, 162 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 47beee584dbf..0e896aab098a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -816,6 +816,7 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 
 	return ret;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_set_crc_source);
 
 /**
  * amdgpu_dm_crtc_handle_crc_irq: Report to DRM the CRC on given CRTC.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
index 383646ad7005..96bdb83317ec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
@@ -7,7 +7,11 @@
 
 #include <kunit/test.h>
 
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_modeset_lock.h>
+#include <drm/drm_probe_helper.h>
 
 #include "dc.h"
 #include "core_types.h"
@@ -170,6 +174,19 @@ static struct amdgpu_crtc *dm_test_alloc_crc_crtc(struct kunit *test,
 	return acrtc;
 }
 
+static const struct drm_connector_funcs dm_test_crc_connector_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+};
+
+static void dm_test_crc_connector_cleanup(void *data)
+{
+	drm_connector_cleanup(data);
+}
+
 static void dm_test_parse_crc_source_none(struct kunit *test)
 {
 	KUNIT_EXPECT_EQ(test, AMDGPU_DM_PIPE_CRC_SOURCE_NONE, dm_parse_crc_source("none"));
@@ -517,6 +534,145 @@ static void dm_test_crtc_configure_crc_source_none(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, fixture->bit_depth_reduction_called);
 }
 
+/**
+ * dm_test_crtc_set_crc_source_invalid() - Test invalid source guard.
+ * @test: KUnit test context.
+ *
+ * Verifies that amdgpu_dm_crtc_set_crc_source() rejects invalid source names
+ * before taking modeset locks, vblank references, or touching DC state.
+ */
+static void dm_test_crtc_set_crc_source_invalid(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	int ret;
+
+	ret = amdgpu_dm_crtc_set_crc_source(&acrtc->base, "invalid");
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+/**
+ * dm_test_crtc_set_crc_source_none_no_stream() - Test valid source no-stream exit.
+ * @test: KUnit test context.
+ *
+ * Verifies that a valid NONE request enters the set-source body, reads the
+ * current CRC state, and exits cleanly when configuration is deferred because
+ * no stream is attached.
+ */
+static void dm_test_crtc_set_crc_source_none_no_stream(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct dm_crtc_state *dm_state;
+	int ret;
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+	acrtc->base.state = &dm_state->base;
+	acrtc->dm_irq_params.crc_src = AMDGPU_DM_PIPE_CRC_SOURCE_NONE;
+
+	ret = amdgpu_dm_crtc_set_crc_source(&acrtc->base, "none");
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	KUNIT_EXPECT_EQ(test, acrtc->dm_irq_params.crc_src,
+			AMDGPU_DM_PIPE_CRC_SOURCE_NONE);
+	KUNIT_EXPECT_EQ(test, dm_state->crc_skip_count, 0);
+}
+
+/**
+ * dm_test_crtc_set_crc_source_none_commit() - Test set-source with pending commit.
+ * @test: KUnit test context.
+ *
+ * Verifies that a pending CRTC commit is acquired and waited on (already
+ * completed here so the wait returns immediately), then released during
+ * cleanup. Configuration is still deferred because no stream is attached.
+ */
+static void dm_test_crtc_set_crc_source_none_commit(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct dm_crtc_state *dm_state;
+	struct drm_crtc_commit *commit;
+	int ret;
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+	acrtc->base.state = &dm_state->base;
+	acrtc->dm_irq_params.crc_src = AMDGPU_DM_PIPE_CRC_SOURCE_NONE;
+
+	commit = kunit_kzalloc(test, sizeof(*commit), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, commit);
+	kref_init(&commit->ref);
+	init_completion(&commit->hw_done);
+	/* Mark the commit finished so the wait returns immediately. */
+	complete_all(&commit->hw_done);
+	list_add_tail(&commit->commit_entry, &acrtc->base.commit_list);
+
+	ret = amdgpu_dm_crtc_set_crc_source(&acrtc->base, "none");
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	KUNIT_EXPECT_EQ(test, dm_state->crc_skip_count, 0);
+}
+
+/**
+ * dm_test_crtc_set_crc_source_dprx_no_connector() - Test DPRX with no match.
+ * @test: KUnit test context.
+ *
+ * Verifies that requesting a DPRX source walks the connector list and returns
+ * -EINVAL when no matching DP connector is attached to the CRTC. A stateless
+ * connector and a writeback connector exercise both connector filter branches.
+ */
+static void dm_test_crtc_set_crc_source_dprx_no_connector(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
+	struct drm_connector *dp_conn;
+	struct drm_connector *wb_conn;
+	struct dm_crtc_state *dm_state;
+	int ret;
+
+	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_state);
+	acrtc->base.state = &dm_state->base;
+	acrtc->dm_irq_params.crc_src = AMDGPU_DM_PIPE_CRC_SOURCE_NONE;
+
+	/* Stateless DP connector: skipped by the !state filter. */
+	dp_conn = kunit_kzalloc(test, sizeof(*dp_conn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dp_conn);
+	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, dp_conn,
+						 &dm_test_crc_connector_funcs,
+						 DRM_MODE_CONNECTOR_DisplayPort), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+			dm_test_crc_connector_cleanup, dp_conn), 0);
+
+	/* Writeback connector bound to this CRTC: skipped by the WB filter. */
+	wb_conn = kunit_kzalloc(test, sizeof(*wb_conn), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, wb_conn);
+	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, wb_conn,
+						 &dm_test_crc_connector_funcs,
+						 DRM_MODE_CONNECTOR_WRITEBACK), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+			dm_test_crc_connector_cleanup, wb_conn), 0);
+	drm_atomic_helper_connector_reset(wb_conn);
+	KUNIT_ASSERT_NOT_NULL(test, wb_conn->state);
+	wb_conn->state->crtc = &acrtc->base;
+	/*
+	 * __drm_atomic_helper_connector_destroy_state() drops a connector
+	 * reference when state->crtc is set. Balance it here since the CRTC is
+	 * assigned directly rather than via drm_atomic_set_crtc_for_connector(),
+	 * otherwise cleanup would drop the connector to zero and schedule an
+	 * async free on the system workqueue.
+	 */
+	drm_connector_get(wb_conn);
+
+	ret = amdgpu_dm_crtc_set_crc_source(&acrtc->base, "dprx");
+
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+	KUNIT_EXPECT_EQ(test, acrtc->dm_irq_params.crc_src,
+			AMDGPU_DM_PIPE_CRC_SOURCE_NONE);
+}
+
 /**
  * dm_test_need_dp_aux() - Test dm_need_dp_aux().
  * @test: KUnit test context.
@@ -657,6 +813,11 @@ static struct kunit_case dm_crc_test_cases[] = {
 	KUNIT_CASE(dm_test_crtc_configure_crc_source_crtc_dcn36_poly),
 	KUNIT_CASE(dm_test_crtc_configure_crc_source_crtc_configure_fails),
 	KUNIT_CASE(dm_test_crtc_configure_crc_source_none),
+	/* amdgpu_dm_crtc_set_crc_source() */
+	KUNIT_CASE(dm_test_crtc_set_crc_source_invalid),
+	KUNIT_CASE(dm_test_crtc_set_crc_source_none_no_stream),
+	KUNIT_CASE(dm_test_crtc_set_crc_source_none_commit),
+	KUNIT_CASE(dm_test_crtc_set_crc_source_dprx_no_connector),
 	/* dm_need_dp_aux() */
 	KUNIT_CASE(dm_test_need_dp_aux),
 	/* dm_crc_source_should_start_dprx() */
-- 
2.43.0

