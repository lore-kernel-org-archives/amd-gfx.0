Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54BEC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43AB110F082;
	Wed, 15 Jul 2026 13:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ol7LVdbD";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8488910F082
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0DZRR4D//AOPURu4IYliUP/iwK52wLZlIigBuEFZ9q5UGe3k5NGi5CIzbusQsNxomU218UqDY4KbxsVvcE1R0VMd+iF8OGw1iMmxZ3Njcc57oa7/yWSeEZ8zABWhejiW5juemGkqcPIcFCxjmfwWEsOWVyDCMcsBrH5xqbqrTtrago8/fGmuuOuOZzX5bWWijKzbZBUkcdZQZQa0fzogWXsXyOMn2mLmOIwlPpHBCzDFT6NCQuhhyhTx+zVCD9X/XhUGik+rBCRn9FROy9aIm1guZ67nkIJlTLYeFEh2AaXF6GuWomeOT0gz2jPBRlb6gVrNBpZjoN3aDBys2lXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRLmCakKgZnZZTkrz/dQk4wDYOlKXrm3uNXNe5MMbVY=;
 b=yOlv2tDOTBCvNrmH+IoJGEtUrMjEkrGDf5sP5BBWts3baKsIvDftdEHHGshFTHW0NZpwhcJHNYSrKY+ghO/QGmZ36hR5eggcQvPD0U7SbqYfd+a7myQcBRqHuvFrb22AaXhws24lGuZo/DGsl+Dq9w+9kyKoVK+BbnDvamL+Cx3IvHBq270rWGe5kbgW9o4C/M0QpNvhEnDvQjYbBGGH1wmehj9kisCIalD9Q82dULJ2/DE+eu3/t3yX0Fn/K1rqbAdERw+2DIeMoX/Blz2WQE5nse/KtC9ePiyw8EowBOmVztbhwEITCnnmCW76g8IlTmdZ6Q5AOsbwZSNPdK82KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRLmCakKgZnZZTkrz/dQk4wDYOlKXrm3uNXNe5MMbVY=;
 b=ol7LVdbDgIX/hhDVVjXxaxkSmdgKEES246Kx3b04nMlC9fUCZDUe65yuK2KVk8i59XMEYkRUVcP2hGfk9uHaautjUlYiwunUF733CC3Y0F5GnCwJ29QpgCGU00oa6nZkjSvkn168FTeKplmBEPy3s3U1K+nuFdOxcwLINLzRKYw=
Received: from SJ0PR03CA0226.namprd03.prod.outlook.com (2603:10b6:a03:39f::21)
 by SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:46:25 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::92) by SJ0PR03CA0226.outlook.office365.com
 (2603:10b6:a03:39f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:12 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:46:09 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 21/70] drm/amd/display: Add EDID management tests for connector
Date: Wed, 15 Jul 2026 21:37:31 +0800
Message-ID: <20260715134432.1975118-22-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SN7PR12MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b5f351-ee3c-400b-09e9-08dee2777647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xMzGslYzr3ltLOK/kPD2A2wKolUi9RQfgfYXDDeF1BkwH5ZA2IjLTee6pXhqwlpleLlbuksXbNpukJI7DAK8539B2HHrjBYlFQPqJwZiebOqDRDf3ikxiGeubWZCUAQdJmIgDf5T8aad7mUVL3CsBB1d3USv686HFDxUYJ1vgMMLteE9cvsOCC2Ksl0RQUF2LcziPGNIbJUVGCF8hVsvrOLZhEAWElDFffK6W2wXuK/MPX9kKxqn1fVuhMGzWgkegjvglsLEPJAd+VFWQRZjDYnydEsEqvxVoqhki3Uc5tumeq3d/hFYF8j4H4IE8KlCq2sQKkoRVGI/FCxAe4tK7u8VLoZG03d/xxpdwNVKIb7/N2fPl/VP/l1OxJjY337GgR8WX5E9i21k4KYp2TU+szlJculA59LuCcncWYD5ELhgqiL5dhNufDb89TfA2vbljKJ/VfFJJKRG9+nTnvaol0SE5KwkSrofJywNKcGjs59S+jAU/8s5qvCjnGunOChCU+ni7ckyioN2nVTnb90xXlT7tnhUbFCu8c8BynQmwzUXyI6D+RmWVcCFxYGhNklV9LvG+QtqPZp11b+oD/TZlGuJJzWHjNQp9g2PTT/tSa57TbLUrlXbtD6VSiMN3mqGffM/PjPI4Ste5SCE78D8QNFMt8QVCQWHhhLeL9murq8k13e5L2S7kRpS1LoSwyInfrIpn7Drwijnpq9t0LeAxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ulr9HboAKtwzzVNsXgqsUPaSmmKLWbDgn9JLBovaYlDSo3mBC+7lIR33hNkgrc3E6rYT44NYiyVt9v1g9upPMHXaYCTWJxl6Omu6RJJZBbUpLrGPfAtpAMf4srAqK6CMmUCKJIa/fsgt3y4gwDThYVdD8HfE3kRFewjVYcNQY9NhQXmronYMoB5gLCcBojz4ibynL4aFVC/y1FRfmMd7akFh3v2HgVpInmL09Sug6nLaJFLn9k+Fr/G5kC/lWH1cHEGM8YYDcWUKQ1Cp8HQennCbC11Q/YuDdb8IQVe3+Yf57/SFiVYPLyrIMkdidvYh4NkXhzDH77Swvom6GeDLtzVrWetrnQNtWBhBQq5pjxQDiMm5S4DKdtmooqX2XLvvui0ANX3XVVm8IbEbB5VQ4Dn47ppi9Xn4RdFK9sjkoemBWPMm62c6ob5jy9qAONBE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:24.5278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b5f351-ee3c-400b-09e9-08dee2777647
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931
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

Add KUnit coverage for hdmi_cec_unset_edid(), create_eml_sink() and
handle_edid_mgmt(): unset edid with no notifier, eml sink with no
edid, and DP vs non-DP edid management link caps handling.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   9 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   3 +
 .../tests/amdgpu_dm_connector_test.c          | 119 ++++++++++++++++++
 3 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index a4648acde71b..6d358cb84961 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -334,7 +334,7 @@ int amdgpu_dm_detect_mst_link_for_all_connectors(struct drm_device *dev)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_detect_mst_link_for_all_connectors);
 
-static void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector)
 {
 	struct cec_notifier *n = aconnector->notifier;
 
@@ -343,6 +343,7 @@ static void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector)
 
 	cec_notifier_phys_addr_invalidate(n);
 }
+EXPORT_IF_KUNIT(hdmi_cec_unset_edid);
 
 void amdgpu_dm_hdmi_cec_set_edid(struct amdgpu_dm_connector *aconnector)
 {
@@ -1969,7 +1970,7 @@ static int get_modes(struct drm_connector *connector)
 	return amdgpu_dm_connector_get_modes(connector);
 }
 
-static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
 	struct dc_link *dc_link = aconnector->dc_link;
@@ -2014,8 +2015,9 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 			dc_sink_retain(aconnector->dc_sink);
 	}
 }
+EXPORT_IF_KUNIT(create_eml_sink);
 
-static void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_link *link = (struct dc_link *)aconnector->dc_link;
 
@@ -2030,6 +2032,7 @@ static void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
 
 	create_eml_sink(aconnector);
 }
+EXPORT_IF_KUNIT(handle_edid_mgmt);
 
 static enum dc_status dm_validate_stream_and_context(struct dc *dc,
 						struct dc_stream_state *stream)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index a5fff31b23bf..f7ec4b906e13 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -146,6 +146,9 @@ int amdgpu_dm_encoder_init(struct drm_device *dev,
 			   uint32_t link_index);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector);
+void create_eml_sink(struct amdgpu_dm_connector *aconnector);
+void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector);
 void dm_encoder_helper_disable(struct drm_encoder *encoder);
 int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 				   struct drm_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 441180d427c9..59f2f8235486 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -4267,6 +4267,118 @@ static void dm_test_atomic_check_non_mst_returns_zero(struct kunit *test)
 					       &ctx->dm_state->base), 0);
 }
 
+/* Tests for hdmi_cec_unset_edid() */
+
+/**
+ * dm_test_hdmi_cec_unset_edid_no_notifier - Test the no-notifier no-op path
+ * @test: The KUnit test context
+ *
+ * With aconnector->notifier NULL the function returns early and must not crash.
+ */
+static void dm_test_hdmi_cec_unset_edid_no_notifier(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	hdmi_cec_unset_edid(aconnector);
+}
+
+/* Tests for create_eml_sink() and handle_edid_mgmt() */
+
+/*
+ * create_eml_sink() reads EDID off the connector's DDC. Forcing the connector
+ * DRM_FORCE_OFF makes drm_edid_read_ddc() return NULL before touching any i2c
+ * adapter, exercising the "no EDID" branch without real hardware. aux_mode is
+ * set so the embedded DP AUX ddc is selected (no i2c adapter pointer needed).
+ */
+struct dm_test_edid_ctx {
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+};
+
+static struct dm_test_edid_ctx *
+dm_test_edid_ctx_alloc(struct kunit *test, int connector_type)
+{
+	struct dm_test_edid_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->drm = dm_test_alloc_drm(test);
+	ctx->aconnector = dm_test_add_connector(test, ctx->drm, connector_type);
+
+	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
+	ctx->link->aux_mode = true;
+	ctx->aconnector->dc_link = ctx->link;
+
+	ctx->aconnector->base.force = DRM_FORCE_OFF;
+
+	return ctx;
+}
+
+/**
+ * dm_test_create_eml_sink_no_edid - Test the no-EDID branch creates no sink
+ * @test: The KUnit test context
+ *
+ * When no EDID can be read the function logs an error and returns without
+ * allocating an emulated sink.
+ */
+static void dm_test_create_eml_sink_no_edid(struct kunit *test)
+{
+	struct dm_test_edid_ctx *ctx =
+		dm_test_edid_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+
+	create_eml_sink(ctx->aconnector);
+
+	KUNIT_EXPECT_NULL(test, ctx->aconnector->dc_em_sink);
+}
+
+/**
+ * dm_test_handle_edid_mgmt_dp_sets_link_caps - Test DP seeds verified link caps
+ * @test: The KUnit test context
+ *
+ * For a DisplayPort link the function primes verified_link_cap before reading
+ * EDID so a headless force-on connector can still modeset.
+ */
+static void dm_test_handle_edid_mgmt_dp_sets_link_caps(struct kunit *test)
+{
+	struct dm_test_edid_ctx *ctx =
+		dm_test_edid_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+
+	ctx->link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+	handle_edid_mgmt(ctx->aconnector);
+
+	KUNIT_EXPECT_EQ(test, (int)ctx->link->verified_link_cap.lane_count,
+			(int)LANE_COUNT_FOUR);
+	KUNIT_EXPECT_EQ(test, (int)ctx->link->verified_link_cap.link_rate,
+			(int)LINK_RATE_HIGH2);
+	KUNIT_EXPECT_NULL(test, ctx->aconnector->dc_em_sink);
+}
+
+/**
+ * dm_test_handle_edid_mgmt_non_dp_leaves_caps - Test non-DP links keep zeroed caps
+ * @test: The KUnit test context
+ *
+ * A non-DisplayPort link skips the verified_link_cap seeding entirely.
+ */
+static void dm_test_handle_edid_mgmt_non_dp_leaves_caps(struct kunit *test)
+{
+	struct dm_test_edid_ctx *ctx =
+		dm_test_edid_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+
+	ctx->link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+
+	handle_edid_mgmt(ctx->aconnector);
+
+	KUNIT_EXPECT_EQ(test, (int)ctx->link->verified_link_cap.lane_count, 0);
+	KUNIT_EXPECT_EQ(test, (int)ctx->link->verified_link_cap.link_rate, 0);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -4489,6 +4601,13 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_atomic_check_edp_native_keeps_scaling),
 	KUNIT_CASE(dm_test_atomic_check_lvds_non_native_enables_scaling),
 	KUNIT_CASE(dm_test_atomic_check_non_mst_returns_zero),
+	/* hdmi_cec_unset_edid */
+	KUNIT_CASE(dm_test_hdmi_cec_unset_edid_no_notifier),
+	/* create_eml_sink */
+	KUNIT_CASE(dm_test_create_eml_sink_no_edid),
+	/* handle_edid_mgmt */
+	KUNIT_CASE(dm_test_handle_edid_mgmt_dp_sets_link_caps),
+	KUNIT_CASE(dm_test_handle_edid_mgmt_non_dp_leaves_caps),
 	{}
 };
 
-- 
2.43.0

