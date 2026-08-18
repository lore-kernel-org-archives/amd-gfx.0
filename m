Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1ECC5DF8C
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96BCE10ECC3;
	Tue, 18 Aug 2026 20:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F32O9H/W";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD6810E38B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgALPwllVGIRMDv8HEaQsmkexKZWBy/JPVAHFHae6Btpd5ARogGzemedqXONvm14OPGb7Je6l6XeGtRuWox0Mr7I0VaUhq4/1APO2gPlekHxA1Fi+gCjTujzIZ8ste80WEOhWc97/o6pUdu1Kj/AZNy2sZJmtamAxr71DKR4ppdf3WgUFY22wJNGceNYDHG9lfHQAzRYr8S2AtIIRDiKXmiINRa2klxeU4AowKJIy5Bo30ERTha3k3ovQWIG5/hMHK0uQIphX39cL6T7EC0gME3SVgyvj7xmWyR/V1JUTLpEsRZKa6xG7au3X37Sh8FVGIvQDiBEZBa2EVrmqeUCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcfO0Re4F0mn0OggeORyHVywE5NbATTecSjT2+BUKlk=;
 b=tBj+uJt50soWoIbnRsWs4DEhrCP7OFZvVY0mKjAV3UFfvKmigjH/smGTZlLQnP2GspFLAUrlk8WeQPJ03jNiQRaeOSONjvkb/+Yase1sH5noTtPINw5QeZMsLCEpz854dbIeUYv6XGKnW/fTV4gdLAlr1dOzy75fKrf2exQpOHNntfF5rTh60EVOPiIIeIGkW6zKdUNM9nVsMPX6fYL7E2747y5QnMU3hrKrM0MEbVUEKRlZlTvIE6LhX8VZsZMRDqOahvDQGOZCbmw6T0vt7W1aWbFDxLDBwkFnaPn2b7cIxuGsSAAO2yi3pcH6+6eCGMlpWT3jtecBnMd4oPBh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcfO0Re4F0mn0OggeORyHVywE5NbATTecSjT2+BUKlk=;
 b=F32O9H/WCHHSsYoqCUNJq0O2dbEYDknAw6tO1+u41opt+s6HrxHDYk10e1kz2ax561CLhEqb6GYcbwjgX51+KrznZU14BKeyVQ8qeBhXOwGNCVaPQyBFiG3ZKpu32kTHsa/W8c+Z11TA/5YLsn91XpqR1jQMRDJMI+lBujVMRwI=
Received: from BN9PR03CA0356.namprd03.prod.outlook.com (2603:10b6:408:f6::31)
 by PH0PR12MB7471.namprd12.prod.outlook.com (2603:10b6:510:1e9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:45 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::62) by BN9PR03CA0356.outlook.office365.com
 (2603:10b6:408:f6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:35 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:34 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 58/82] drm/amd/display: Cover amdgpu_dm_connector_get_modes
Date: Tue, 18 Aug 2026 16:15:50 -0400
Message-ID: <20260818202139.4172592-59-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|PH0PR12MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: f33f8bcb-a341-4cd4-5345-08defd66763f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ocb3IUEOB5Jxge0SHtHXDGCUdEP91Dv2dg958kLNJiaP3mV4i/+r0PD06fmsmObz4UjPVsVaYIJeUArII+oWi7ERWJh9xDvPDczoVW8yrzZ3z9XX4zZF1JTvnNwBjHRYg1or8FxJQFEprtv274VnEPGoICy7cJguatZKNFPSaoBdBemLr7XaheZj0U6QmjjmZeI7Oc8oJKJKcyn5DOFKgdmjbwqYMFkg93op4AqZPZT9E/vdo/JWaQadtLmfAr9JVbJNfuecQVS0qRrp4h6Qj1fDqiT6CIOiteMtz1cIAibhHORe2zelJWCeRhiQc6bfNSD/YBLS4VvPhDLi4Me2/DMiVlg2osAx9XydN2PYItgTzMEzR/wQx5axUgz5d0L3b2GqFnv/8f3JnuPoqHvNASlsj3UYfuBt6IPELrumrqqz+IIpjCVxZHyF9Nroh300UNa5pDWLK5qW5TAWBWooZd4H/HtdlViexsyeuwYKclc46o4HQEs2jdtw6+X3ReBUvh+Dby6MxVftTNGcUDFqpnNuOf3AE8/bTwmkqNWpgP/9av/G8IbkmQuYf525mlKTDR1HSU6evPk+aOqOmjk9G9HiX6mjro9azFXFBXP4l+eoit389fNS3m4xbmLorKsxYJ9y5tnXJRcbC4aIOucqD8ARlbu7EGspxBC/S2cxxz1+V8qSDJeI5yWwGL3Lt52V7FrHjzzOZOUva44YiezjwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FgOjMuIgVqsEZgtLUOmXMzLRBTkMbz+M9i/k1wr25qoD0yCURMTRS/RxXUmfkIYxOntHaiS7mTvC/v0QwbypQS+JetP1zmTmb15KUX2/18RdaAJ5CG2lk8cEroI8vuI6YSw53uV1QlRWRpALtRj+u8iYLFdMUjt0iCRmm+j4KbmfkWtFBFWo7jZk89vYVT9cQ51Nj1A+XDs5mua3w/B/6FFTMcwTLX5D7j4otHRXd2KyfDyUAq4HYKV2TgK4GdomFycnwkR87gSgpia9rzUJForC0JFxW8eE5lJnRF3UJQjAHVeWUVC2npXr81siy8Ci5WlAwgcgHabiXpZMVSCIjL0Oicmmb6iw22lvf49kExjKaE68DTLgdGKd0/fwulspzNKfncDaow9W64cJXIJfKQDTaOHZeIxDZaJbhl5mli57rpYJYK16b9wKSb4hsz/D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:44.5122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f33f8bcb-a341-4cd4-5345-08defd66763f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7471
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

Add KUnit tests for amdgpu_dm_connector_get_modes() covering the
no-EDID default modes, the extra modes added for 128b/132b and analog
links, and the path that adds modes from a valid EDID.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   5 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   1 +
 .../tests/amdgpu_dm_connector_test.c          | 178 ++++++++++++++++++
 3 files changed, 182 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 44c223b178c50..45ac4e2b5029b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -256,7 +256,7 @@ STATIC_IFN_KUNIT void update_subconnector_property(struct amdgpu_dm_connector *a
 }
 EXPORT_IF_KUNIT(update_subconnector_property);
 
-static int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
+STATIC_IFN_KUNIT int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
 
 STATIC_IFN_KUNIT void amdgpu_dm_fbc_init(struct drm_connector *connector)
 {
@@ -3038,7 +3038,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_add_freesync_modes(struct drm_connecto
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_add_freesync_modes);
 
-static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
+STATIC_IFN_KUNIT int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 			to_amdgpu_dm_connector(connector);
@@ -3077,6 +3077,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 
 	return amdgpu_dm_connector->num_modes;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_connector_get_modes);
 
 static const u32 supported_colorspaces =
 	BIT(DRM_MODE_COLORIMETRY_BT709_YCC) |
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 3571378654fd7..91b8434ba591d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -168,6 +168,7 @@ void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
 					  struct drm_connector *connector);
 void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 				       const struct drm_edid *drm_edid);
+int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
 uint add_fs_modes(struct amdgpu_dm_connector *aconnector);
 void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connector,
 					    const struct drm_edid *drm_edid);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 3a5edf84fbc0a..fc6b6013d1188 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -7171,6 +7171,179 @@ static void dm_test_funcs_force_reads_edid(struct kunit *test)
 	ctx->aconnector->drm_edid = NULL;
 }
 
+/* Tests for amdgpu_dm_connector_get_modes() */
+
+static enum dp_link_encoding dm_test_gm_enc_8b10b(const struct dc_link_settings *s)
+{
+	return DP_8b_10b_ENCODING;
+}
+
+static enum dp_link_encoding dm_test_gm_enc_128b(const struct dc_link_settings *s)
+{
+	return DP_128b_132b_ENCODING;
+}
+
+/*
+ * Build an amdgpu_dm_connector on an amdgpu_device-backed drm device (so
+ * drm_to_adev() resolves for amdgpu_dm_fbc_init()) with an attached encoder
+ * and a dc/dc_link whose link_srv reports a non-128b encoding by default. The
+ * fbc compressor is left NULL so amdgpu_dm_fbc_init() early-returns.
+ */
+struct dm_test_gm_ctx {
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_encoder *aenc;
+	struct dc *dc;
+	struct link_service *link_srv;
+	struct dc_link *link;
+};
+
+static struct dm_test_gm_ctx *
+dm_test_gm_ctx_alloc(struct kunit *test, int connector_type)
+{
+	struct dm_test_gm_ctx *ctx;
+	struct device *dev;
+	int ret;
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
+	ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx->aconnector),
+				       GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	ret = drmm_connector_init(ctx->drm, &ctx->aconnector->base,
+				  &dm_test_connector_funcs, connector_type,
+				  NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ctx->aenc = drmm_kzalloc(ctx->drm, sizeof(*ctx->aenc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aenc);
+	ret = drmm_encoder_init(ctx->drm, &ctx->aenc->base, NULL,
+				DRM_MODE_ENCODER_TMDS, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	ret = drm_connector_attach_encoder(&ctx->aconnector->base,
+					   &ctx->aenc->base);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ctx->dc = kunit_kzalloc(test, sizeof(*ctx->dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dc);
+	ctx->link_srv = kunit_kzalloc(test, sizeof(*ctx->link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link_srv);
+	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
+
+	ctx->link_srv->dp_get_encoding_format = dm_test_gm_enc_8b10b;
+	ctx->dc->link_srv = ctx->link_srv;
+	ctx->adev->dm.dc = ctx->dc;
+	ctx->link->dc = ctx->dc;
+	ctx->aconnector->dc_link = ctx->link;
+
+	return ctx;
+}
+
+/**
+ * dm_test_get_modes_noedid_default - Test synthesized modes without an EDID
+ * @test: The KUnit test context
+ *
+ * With no cached EDID and a non-128b link, get_modes() synthesizes the default
+ * 640x480 fallback mode(s) and reports a non-zero count.
+ */
+static void dm_test_get_modes_noedid_default(struct kunit *test)
+{
+	struct dm_test_gm_ctx *ctx =
+		dm_test_gm_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+
+	KUNIT_EXPECT_GT(test,
+			amdgpu_dm_connector_get_modes(&ctx->aconnector->base), 0);
+}
+
+/**
+ * dm_test_get_modes_noedid_128b_adds_more - Test 128b links add 1080p modes
+ * @test: The KUnit test context
+ *
+ * A 128b/132b link synthesizes the extra 1920x1080 fallback modes, so the mode
+ * count is strictly greater than for an 8b/10b link.
+ */
+static void dm_test_get_modes_noedid_128b_adds_more(struct kunit *test)
+{
+	struct dm_test_gm_ctx *ctx =
+		dm_test_gm_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	int n_8b, n_128b;
+
+	n_8b = amdgpu_dm_connector_get_modes(&ctx->aconnector->base);
+
+	ctx->link_srv->dp_get_encoding_format = dm_test_gm_enc_128b;
+	n_128b = amdgpu_dm_connector_get_modes(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_GT(test, n_128b, n_8b);
+}
+
+/**
+ * dm_test_get_modes_noedid_analog_adds_common - Test analog sinks add common modes
+ * @test: The KUnit test context
+ *
+ * An analog VGA sink detected by load detection adds the common fallback modes
+ * on top of the default 640x480 mode(s).
+ */
+static void dm_test_get_modes_noedid_analog_adds_common(struct kunit *test)
+{
+	struct dm_test_gm_ctx *ctx =
+		dm_test_gm_ctx_alloc(test, DRM_MODE_CONNECTOR_VGA);
+	struct dc_sink *sink;
+	int n_base, n_analog;
+
+	n_base = amdgpu_dm_connector_get_modes(&ctx->aconnector->base);
+
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+	sink->edid_caps.analog = true;
+	ctx->aconnector->dc_sink = sink;
+	ctx->link->link_id.id = CONNECTOR_ID_VGA;
+
+	n_analog = amdgpu_dm_connector_get_modes(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_GT(test, n_analog, n_base);
+}
+
+/**
+ * dm_test_get_modes_with_edid - Test the cached-EDID path adds common modes
+ * @test: The KUnit test context
+ *
+ * With a cached EDID on an eDP connector, get_modes() takes the DDC path and
+ * adds the common downscaled modes derived from the encoder native mode.
+ */
+static void dm_test_get_modes_with_edid(struct kunit *test)
+{
+	struct dm_test_gm_ctx *ctx =
+		dm_test_gm_ctx_alloc(test, DRM_MODE_CONNECTOR_eDP);
+	const struct drm_edid *drm_edid;
+
+	drm_edid = drm_edid_alloc(dm_test_uad_edid, sizeof(dm_test_uad_edid));
+	KUNIT_ASSERT_NOT_NULL(test, drm_edid);
+	drm_edid_connector_update(&ctx->aconnector->base, drm_edid);
+	ctx->aconnector->drm_edid = drm_edid;
+
+	ctx->aenc->native_mode.hdisplay = 1920;
+	ctx->aenc->native_mode.vdisplay = 1200;
+
+	KUNIT_EXPECT_GT(test,
+			amdgpu_dm_connector_get_modes(&ctx->aconnector->base), 0);
+
+	drm_edid_free(drm_edid);
+	ctx->aconnector->drm_edid = NULL;
+}
+
 /* Tests for amdgpu_dm_update_stream_scaling_settings() */
 
 /**
@@ -7634,6 +7807,11 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* amdgpu_dm_connector_funcs_force */
 	KUNIT_CASE(dm_test_funcs_force_no_edid),
 	KUNIT_CASE(dm_test_funcs_force_reads_edid),
+	/* amdgpu_dm_connector_get_modes */
+	KUNIT_CASE(dm_test_get_modes_noedid_default),
+	KUNIT_CASE(dm_test_get_modes_noedid_128b_adds_more),
+	KUNIT_CASE(dm_test_get_modes_noedid_analog_adds_common),
+	KUNIT_CASE(dm_test_get_modes_with_edid),
 	/* dm_validate_stream_and_context */
 	KUNIT_CASE(dm_test_validate_stream_null_stream),
 	KUNIT_CASE(dm_test_validate_stream_dc_ok_no_pipe),
-- 
2.43.0

