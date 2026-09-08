Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FC7C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A93E510EB2E;
	Tue,  8 Sep 2026 11:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MGNuR66E";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B0810EB36
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:35:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHAuussedXqJY5Ed8wq8/JHHnUZXsEMYytn8uNEbfV74H9GxyZy7wM0/aeOUgIT0Z+39YxqpZoLOldMdAcFck0YaQHbr06SrA9gjx3MnnhhnFVbkI3fCLTgHU2aCFar8K+cmqSdB9GCVrKAGY7XPSAEB79rqfRGUJloL6kL5fRgFYsnuU5qrIshEMYgGK2IStewKYm3cpgvGeu4oai8CRZiJD5yJMCJa2D1KbhxTeomLKiFHCQD/xXDmxNeuVz5PplJlD1R68zoQYL5ztBK8dzYXwzASvePLNBJn3KblcteTxrTWOfXe8Wzfsl1xZKV8OZxam5LLLdOcajl0nzdhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zhcO80ymUNN8QD7R4p68O2ik1yP65IAtzhtoeRFvME=;
 b=efstjS9jLE2o0o5pRfu9h1aWAwDsNvH9C0YhUH+u1Uq3/+ctocjOmEmH4isOomFOuuhzve0InYpA6dC+Xl5cZ29Eo5dOOtxqzBL4SrceOKZ+P64MlPN6uBxZ0nzlw6aybNQC3QUdXBbp1XYRFuhOPFKBhW2fZQa/m4WstBXPLE66oFOZ42/QZy3Tw2F9w5BwQ5pOtPElE1wAP3JjeQjx2S5BgOA/DSL5txMWZrkWG2bRp96CscDFbzlGTZDLUqSYENWtZn8d9eLILKaXqf1OqakqcNXHilBnsB8ugGgf/NuPxOUJvhHge8VwSFTHSPh1V9to85XuLAp/X3taREJZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zhcO80ymUNN8QD7R4p68O2ik1yP65IAtzhtoeRFvME=;
 b=MGNuR66EuKJxpit8fymv3EmspXJJNrFedgDaAgVdscb8WwTjcmO9xX2Lq6g09lbxd93P51NJC86+9H0R57kVllqeXyi3wzZO8U5YihqujBQz5f+pdbNatxCsgYHRnggCuyheeq0rOdEdzK3Vf/w1amaNPtSn0+3lN3SsznQQdmQ=
Received: from LV3P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::7)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 11:35:11 +0000
Received: from BN2PEPF0000A890.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::3b) by LV3P220CA0020.outlook.office365.com
 (2603:10b6:408:234::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A890.mail.protection.outlook.com (10.167.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:35:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:35:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:35:06 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:34:57 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>
Subject: [PATCH 09/66] drm/amd/display: Test connector init
Date: Tue, 8 Sep 2026 19:31:02 +0800
Message-ID: <20260908113338.2433445-10-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A890:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9c2d6c-f821-48c7-dbda-08df0d9d3e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nuYJSBEdV3VP3Y1BQudK2vPsF7pajoyG0W2Owo8Iqa1KQykDOxNQhS6R3v5h1YUCJt1VVYzoCmnTdcda914VAnnUt9OtCo3uYfY+RxwLJat5dlsH3rdyMXl3xL73uEM0vV7Ac4cfzz6fZy68cl0t32x3RhWCuaDY1HeMfBpxZxyMIFb72NpiRyAz0iGae3GT6wHTmnWT2ca1jCDpKf/NP01qFmZTO2gw9/uje02tgpzoJABe85jF2LEshrp7MZLANuMSGkcKKfT+YnT+AYNXe3yDBTGXjFI8o2lWOASwbDayaXbj8Vo+8oQxGDEjBI7gjVAMpmBn6iSAgVD6TxjsFjHJA8TuJPwgAP8EpAwL031IdqAeXhrg323Xa5NuI8JVmaFrKH9EQhsy6N4rfNivkMCXCUosIaluxIEy0Tr2B9iuBMnItiqL3AL6r8mdvtJ1PBTN0JLYahPRIj9Ap2QvKG6fcjdrPGNFAGAaJnx22KHGOxprFV/3kwOU92cf2urzn3folQGwXnjUC8xazQ6h0XMtEhLEpGAtSxb5w0HTfcMRAt2BVzY7hOKODd3pJKUzxJPglQ84tLbtAqTwnxV6VVLgKJIG72uAzpm+E6irifw4ovJ+6EqWx4tTIyy6X5pRB2rDjp4EYd4nvSdlMF/FXozSF4h7lz1Y6zzir6KIpTi7i7vx6cGJz4VY1jZ3/5Wx8vX+GhuvCC6xYqXnu/Qccg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z/omf7UMnagEBCbuKEPRGD/IY2t5r/DQtRFSAfLLs/IJwwa5CIESC7Nv1knyFmBvhwu6xM4sv2AmOZxDeWPMZyOj01eRd5i75gl6SUoTv2Ksd6qsFZH+H+Jyt2kdcf1OLLIak4DScJgkVMr24Xlm82uweTO5Km9yESutDo0ARjKxC+968t57zbg4q7b/zvBiC+aRWrw6LqDUPziBbR9J+tcO3Rn1s17HeoEyEA6VBExTxdIETwmlDa/4zDi/up6X7VqTVc0Wl80Z3FksVS59cFZSrGV3gTYplwobMBSG7bWqyfZScjdoJjWjmxz7r8rsx/u0pKKT3nww9ZjljwhDvKUbeJICSFnDVNMiqbUPAW6vjPxN/+lSVhOXpMn4Ql4ViwAE/uu7dMoEJGWQqlts6OUzibI+ukpCckexpay7nzHfLPESlqGFOfUZftUTXZDs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:35:11.1239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9c2d6c-f821-48c7-dbda-08df0d9d3e07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A890.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
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
Add KUnit tests for amdgpu_dm_connector_init() covering a HDMI link
that is fully brought up, a DVI link that maps to a DVI-D connector
without a CEC notifier, and the get_modes() helper hook it installs.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   1 +
 .../tests/amdgpu_dm_connector_test.c          | 190 ++++++++++++++++++
 2 files changed, 191 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index fdfb6f72b9fc..7056bb6f7e26 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3446,6 +3446,7 @@ int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 	}
 	return res;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_connector_init);
 
 static int dm_force_atomic_commit(struct drm_connector *connector)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index d8a6d6ae90ec..d63529336d69 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -16,6 +16,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_mode_object.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_property.h>
 #include <linux/hdmi.h>
 #include <linux/i2c.h>
@@ -9860,6 +9861,191 @@ static void dm_test_fs_caps_disables_replay(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, ctx->link->replay_settings.replay_feature_enabled);
 }
 
+/* Tests for amdgpu_dm_connector_init() and the get_modes() helper hook */
+
+/*
+ * amdgpu_dm_create_i2c() parents the adapter on adev->pdev->dev, so
+ * devm_i2c_add_adapter() needs a registered device there. Provide one by
+ * registering the device embedded in a KUnit allocated pci_dev.
+ */
+static void dm_test_conn_init_release_dev(struct device *dev)
+{
+	/* Backing storage is KUnit managed, so there is nothing to free. */
+}
+
+static void dm_test_conn_init_unregister_dev(void *data)
+{
+	device_unregister(data);
+}
+
+struct dm_test_conn_init_ctx {
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct amdgpu_display_manager *dm;
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_encoder *aencoder;
+	struct dc_link *link;
+};
+
+static struct dm_test_conn_init_ctx *
+dm_test_conn_init_ctx_alloc(struct kunit *test, enum signal_type signal)
+{
+	struct dm_test_conn_init_ctx *ctx;
+	struct link_service *link_srv;
+	struct dc_context *dc_ctx;
+	struct ddc_service *ddc;
+	struct pci_dev *pdev;
+	struct device *dev;
+	struct dc *dc;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	ctx->drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						       sizeof(struct amdgpu_device),
+						       offsetof(struct amdgpu_device, ddev),
+						       DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
+	ctx->adev = drm_to_adev(ctx->drm);
+	ctx->adev->dev = dev;
+	ctx->adev->mode_info.num_crtc = 1;
+	dm_test_create_mode_props(test, ctx->adev);
+
+	pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pdev);
+	device_initialize(&pdev->dev);
+	pdev->dev.parent = dev;
+	pdev->dev.release = dm_test_conn_init_release_dev;
+	KUNIT_ASSERT_EQ(test, dev_set_name(&pdev->dev, "dm-test-i2c-parent"), 0);
+	KUNIT_ASSERT_EQ(test, device_add(&pdev->dev), 0);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_conn_init_unregister_dev,
+						  &pdev->dev), 0);
+	ctx->adev->pdev = pdev;
+
+	ctx->dm = &ctx->adev->dm;
+	ctx->dm->adev = ctx->adev;
+	ctx->dm->ddev = ctx->drm;
+
+	dc_ctx = kunit_kzalloc(test, sizeof(*dc_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_ctx);
+	dc_ctx->driver_context = ctx->adev;
+
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	link_srv->dp_get_encoding_format = dm_test_gm_enc_8b10b;
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	dc->ctx = dc_ctx;
+	dc->link_srv = link_srv;
+
+	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
+	ctx->link->connector_signal = signal;
+	ctx->link->dc = dc;
+	ctx->link->link_enc = kunit_kzalloc(test, sizeof(*ctx->link->link_enc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link->link_enc);
+
+	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ddc);
+	ddc->ctx = dc_ctx;
+	ddc->link = ctx->link;
+	ctx->link->ddc = ddc;
+
+	dc->links[0] = ctx->link;
+	dc->link_count = 1;
+	ctx->dm->dc = dc;
+
+	/* amdgpu_dm_connector_destroy() and amdgpu_dm_encoder_destroy() kfree() these. */
+	ctx->aconnector = kzalloc_obj(*ctx->aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	ctx->aencoder = kzalloc_obj(*ctx->aencoder);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aencoder);
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_encoder_init(ctx->drm, ctx->aencoder, 0), 0);
+
+	return ctx;
+}
+
+/**
+ * dm_test_conn_init_hdmi - Test a HDMI connector is fully brought up
+ * @test: The KUnit test context
+ *
+ * The DC link is bound to the connector, an i2c adapter is created and
+ * registered as the DDC bus, the DRM connector is initialized with the DM
+ * funcs and helpers, the encoder is attached and the CEC notifier registered.
+ */
+static void dm_test_conn_init_hdmi(struct kunit *test)
+{
+	struct dm_test_conn_init_ctx *ctx =
+		dm_test_conn_init_ctx_alloc(test, SIGNAL_TYPE_HDMI_TYPE_A);
+	struct drm_connector *connector = &ctx->aconnector->base;
+
+	KUNIT_ASSERT_EQ(test,
+			amdgpu_dm_connector_init(ctx->dm, ctx->aconnector, 0,
+						 ctx->aencoder), 0);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx->link->priv, ctx->aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->i2c);
+	KUNIT_EXPECT_PTR_EQ(test, connector->ddc, &ctx->aconnector->i2c->base);
+	KUNIT_EXPECT_EQ(test, connector->connector_type, DRM_MODE_CONNECTOR_HDMIA);
+	KUNIT_EXPECT_NOT_NULL(test, connector->helper_private);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->aconnector->dc_link, ctx->link);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->connector_id, 0);
+	KUNIT_EXPECT_EQ(test, connector->possible_encoders,
+			drm_encoder_mask(&ctx->aencoder->base));
+	KUNIT_EXPECT_NOT_NULL(test, ctx->aconnector->notifier);
+}
+
+/**
+ * dm_test_conn_init_dvi - Test a DVI link maps to a DVI-D connector
+ * @test: The KUnit test context
+ *
+ * A single link DVI signal is not HDMI, so no CEC notifier is registered.
+ */
+static void dm_test_conn_init_dvi(struct kunit *test)
+{
+	struct dm_test_conn_init_ctx *ctx =
+		dm_test_conn_init_ctx_alloc(test, SIGNAL_TYPE_DVI_SINGLE_LINK);
+
+	KUNIT_ASSERT_EQ(test,
+			amdgpu_dm_connector_init(ctx->dm, ctx->aconnector, 0,
+						 ctx->aencoder), 0);
+
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->base.connector_type,
+			DRM_MODE_CONNECTOR_DVID);
+	KUNIT_EXPECT_NULL(test, ctx->aconnector->notifier);
+}
+
+/**
+ * dm_test_conn_init_get_modes_hook - Test the installed get_modes helper
+ * @test: The KUnit test context
+ *
+ * The connector helper funcs that amdgpu_dm_connector_init() installs forward
+ * mode enumeration to amdgpu_dm_connector_get_modes(), which synthesizes the
+ * no-EDID fallback modes.
+ */
+static void dm_test_conn_init_get_modes_hook(struct kunit *test)
+{
+	struct dm_test_conn_init_ctx *ctx =
+		dm_test_conn_init_ctx_alloc(test, SIGNAL_TYPE_HDMI_TYPE_A);
+	const struct drm_connector_helper_funcs *helper;
+	struct drm_connector *connector = &ctx->aconnector->base;
+
+	KUNIT_ASSERT_EQ(test,
+			amdgpu_dm_connector_init(ctx->dm, ctx->aconnector, 0,
+						 ctx->aencoder), 0);
+
+	helper = connector->helper_private;
+	KUNIT_ASSERT_NOT_NULL(test, helper);
+	KUNIT_ASSERT_NOT_NULL(test, helper->get_modes);
+
+	KUNIT_EXPECT_GT(test, helper->get_modes(connector), 0);
+	KUNIT_EXPECT_GT(test, ctx->aconnector->num_modes, 0);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -10281,6 +10467,10 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_fs_caps_force_min_hz_quirk),
 	KUNIT_CASE(dm_test_fs_caps_mccs_clears_capability),
 	KUNIT_CASE(dm_test_fs_caps_disables_replay),
+	/* amdgpu_dm_connector_init */
+	KUNIT_CASE(dm_test_conn_init_hdmi),
+	KUNIT_CASE(dm_test_conn_init_dvi),
+	KUNIT_CASE(dm_test_conn_init_get_modes_hook),
 	{}
 };
 
-- 
2.43.0

