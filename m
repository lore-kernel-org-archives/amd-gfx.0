Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C11C25B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD4510E3C1;
	Wed, 16 Aug 2023 21:29:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1DB610E3C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsUdJApZqN80PdAnCapulPKA1hr9+oZdYhAKZ6iKs+TCtTOlPf79YRzt6sk1qOJvEFGFD+gcP8aKHgvCNy3ySYT+QIiDSKMQx3VLcjhxzCoV7tmb2w+jo2UxGQKKPS7V+1LY+P1LOyDlPt0sRKZJVu0CJ1cEbxUiwnmXwrVvRR+65Z4eAoUy6T2tTJN2t9GBmAWx+GtNPC2+/ZTr9LHL6Gvya3GK1kRUSErixXPwPqq3uzPztDOGRxkPCoqseDwAudVdJfOdRqFz2He5/6JPEB84daoB7fLM0mvnoDR4tj44+b+Rf8MFSnxbez23VrcCfxUM+PggfhOftNpEWBPNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOj5prqyhdkGePGJVRY11UNpidZzNFx6Zrnq6UrLf60=;
 b=AtJHzGWTVwrl/E7NKEzg07r4Qjs5IMGSwAUxcjG/r9A1UzeBVm2m3O1Nwjrc42isSadGoxsLoRqxAmRQwkyAKTNgZjYbYpWtfspXRZfM5Jv7wBP3M/HPYVAcSjuXsKd//zJ9S7L/WY5vNkygJtJOPTYKi4CQpWyvAVa4NI63imSkGYrDIG7gOYjgvk3Kii6u3b57ALi57pM/AZ8t3WNllYLXZjkZlVTS5cQnqnGL1GnghiOgBdPEEbPY5pBolWKyeAGW6hNz3VKnBEBQUb4AK41DQ/Ik8ciafq2gOd9neTtLdesMvJepIkFPY7fMTaZisD3rPPclHSHgbvMSi0ILaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOj5prqyhdkGePGJVRY11UNpidZzNFx6Zrnq6UrLf60=;
 b=enxkpwatxrjLxgqqF99PBAqiHyF8IrR6h/i5Y/T7RhDmfjLx4nrrtUe1D0zm9W+wk/hMqLZGM/aV2vvLVrfsMxUF4e2aLKmRQPC+JCPFbNM/dZnsNMDeNzV1DmxL0FhIIC9X5qMUX7gF25JZMTRyRgnZaUcq7dI8lBzNQIjQ4ug=
Received: from DS7PR07CA0010.namprd07.prod.outlook.com (2603:10b6:5:3af::29)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Wed, 16 Aug
 2023 21:29:12 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::61) by DS7PR07CA0010.outlook.office365.com
 (2603:10b6:5:3af::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:29:12 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:29:10 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/18] drm/amd/display: Initialize writeback connector
Date: Wed, 16 Aug 2023 15:26:11 -0600
Message-ID: <20230816212626.987519-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA1PR12MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3a29c1-0924-4746-bf11-08db9e9fd578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FG6ZYoAVcc6B8rKUFK+dR3r1d4uqak/+E7xEAHmxQj8LejT/eBZIJaOzZQY1uDlaB6p4uZJ9lws6f3+JslbirvhzH5G2VGBTU09K99ANR2zbeB8vL+JVqxvUTv7SGayimmGJJX61luiQbakc5J5kJkZLejHO2i2Ji3B/CNiUrxDB1KVqN4WmiLcKd65iiLBlFujK2oOvzCggm92s4kjheDOMHKaxpeAO1hawJ33kexkGvwH7Ft9xwPbQ7bVed7qE6f7UV7WQnUeBd8kasSrLy12+omgdGwjTpQZPibgLbeHecuUB+UrCI91CXy3SHtqyr83Gt1HalvtXCatCi+VafMRLxz8do/+GhECEkuLYFiIheYqCdiSYr3Qywcxlqb3EY+Z5EaR4sp5jhM4JMCa1rvBfnCpXnDa3a82PL4A0TQQUxo29F7X+sNTQE32Pdng2gTYI86zVMWY8BNYmIohxvfI6S+nxjMqQ9A84KHlAt0EahNKn6arZrcdx6wsSTVr2fm20QyNzvxa/s+Vy8rm4diP7R1H1uorcqzev2iWsqXewJIc92fAPBTtybWvq8/NLPDB1V1mZW078HhcQ58N/CDH/JEOwNH0NMTK71xl7WcElWqklLLRRUTgGblyKM8l33HmGJJY1CUNcX6Y71Ei+2ZkNg+zogJ+HVtJqFNLuFMtORIDQXNcQeYoXFC2vId+OJkFY7ww4+cLGNrSOXH9zwADVrg4jSD22QarAGP2fW6jnGbeDGul+z5gNS7nJJ/SNnZmbwN/6eTa+gn57Tf97CQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(30864003)(2906002)(40460700003)(83380400001)(66899024)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:29:12.0412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3a29c1-0924-4746-bf11-08db9e9fd578
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHAT]
Create a drm_writeback_connector when connector signal equals
SIGNAL_TYPE_VIRTUAL.

Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  20 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  | 209 ++++++++++++++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h  |  35 +++
 4 files changed, 265 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index 063205ecb137..ab2a97e354da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -37,7 +37,8 @@ AMDGPUDM = \
 	amdgpu_dm_helpers.o \
 	amdgpu_dm_pp_smu.o \
 	amdgpu_dm_psr.o \
-	amdgpu_dm_replay.o
+	amdgpu_dm_replay.o \
+	amdgpu_dm_wb.o
 
 ifdef CONFIG_DRM_AMD_DC_FP
 AMDGPUDM += dc_fpu.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 00254fdfa1f7..445369afcead 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -54,6 +54,7 @@
 #include "amdgpu_dm_crtc.h"
 #include "amdgpu_dm_hdcp.h"
 #include <drm/display/drm_hdcp_helper.h>
+#include "amdgpu_dm_wb.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_atombios.h"
 
@@ -4391,8 +4392,25 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 		link = dc_get_link_at_index(dm->dc, i);
 
-		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL)
+		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL) {
+			struct drm_writeback_connector *wbcon = kzalloc(sizeof(*wbcon), GFP_KERNEL);
+
+			if (!wbcon) {
+				DRM_ERROR("KMS: Failed to allocate writeback connector\n");
+				continue;
+			}
+
+			if (amdgpu_dm_wb_connector_init(dm, wbcon)) {
+				DRM_ERROR("KMS: Failed to initialize writeback connector\n");
+				kfree(wbcon);
+				continue;
+			}
+
+			link->psr_settings.psr_feature_enabled = false;
+			link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
+
 			continue;
+		}
 
 		aconnector = kzalloc(sizeof(*aconnector), GFP_KERNEL);
 		if (!aconnector)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
new file mode 100644
index 000000000000..74e656696d8e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "dm_services_types.h"
+
+#include "amdgpu.h"
+#include "amdgpu_dm.h"
+#include "amdgpu_dm_wb.h"
+#include "amdgpu_display.h"
+
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_modeset_helper_vtables.h>
+
+static const u32 amdgpu_dm_wb_formats[] = {
+	DRM_FORMAT_XRGB2101010,
+};
+
+static int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encoder,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state)
+{
+	struct drm_framebuffer *fb;
+	const struct drm_display_mode *mode = &crtc_state->mode;
+	bool found = false;
+	uint8_t i;
+
+	if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
+		return 0;
+
+	fb = conn_state->writeback_job->fb;
+	if (fb->width != mode->hdisplay || fb->height != mode->vdisplay) {
+		DRM_DEBUG_KMS("Invalid framebuffer size %ux%u\n",
+			      fb->width, fb->height);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < sizeof(amdgpu_dm_wb_formats) / sizeof(u32); i++) {
+		if (fb->format->format == amdgpu_dm_wb_formats[i])
+			found = true;
+	}
+
+	if (!found) {
+		DRM_DEBUG_KMS("Invalid pixel format %p4cc\n",
+			      &fb->format->format);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+static int amdgpu_dm_wb_connector_get_modes(struct drm_connector *connector)
+{
+	struct drm_device *dev = connector->dev;
+
+	return drm_add_modes_noedid(connector, dev->mode_config.max_width,
+				    dev->mode_config.max_height);
+}
+
+static int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector,
+			       struct drm_writeback_job *job)
+{
+	struct amdgpu_framebuffer *afb;
+	struct drm_gem_object *obj;
+	struct amdgpu_device *adev;
+	struct amdgpu_bo *rbo;
+	uint32_t domain;
+	int r;
+
+	if (!job->fb) {
+		DRM_DEBUG_KMS("No FB bound\n");
+		return 0;
+	}
+
+	afb = to_amdgpu_framebuffer(job->fb);
+	obj = job->fb->obj[0];
+	rbo = gem_to_amdgpu_bo(obj);
+	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
+
+	r = amdgpu_bo_reserve(rbo, true);
+	if (r) {
+		dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
+		return r;
+	}
+
+	r = dma_resv_reserve_fences(rbo->tbo.base.resv, 1);
+	if (r) {
+		dev_err(adev->dev, "reserving fence slot failed (%d)\n", r);
+		goto error_unlock;
+	}
+
+	domain = amdgpu_display_supported_domains(adev, rbo->flags);
+
+	r = amdgpu_bo_pin(rbo, domain);
+	if (unlikely(r != 0)) {
+		if (r != -ERESTARTSYS)
+			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
+		goto error_unlock;
+	}
+
+	r = amdgpu_ttm_alloc_gart(&rbo->tbo);
+	if (unlikely(r != 0)) {
+		DRM_ERROR("%p bind failed\n", rbo);
+		goto error_unpin;
+	}
+
+	amdgpu_bo_unreserve(rbo);
+
+	afb->address = amdgpu_bo_gpu_offset(rbo);
+
+	amdgpu_bo_ref(rbo);
+
+	return 0;
+
+error_unpin:
+	amdgpu_bo_unpin(rbo);
+
+error_unlock:
+	amdgpu_bo_unreserve(rbo);
+	return r;
+}
+
+static void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *connector,
+				struct drm_writeback_job *job)
+{
+	struct amdgpu_bo *rbo;
+	int r;
+
+	if (!job->fb)
+		return;
+
+	rbo = gem_to_amdgpu_bo(job->fb->obj[0]);
+	r = amdgpu_bo_reserve(rbo, false);
+	if (unlikely(r)) {
+		DRM_ERROR("failed to reserve rbo before unpin\n");
+		return;
+	}
+
+	amdgpu_bo_unpin(rbo);
+	amdgpu_bo_unreserve(rbo);
+	amdgpu_bo_unref(&rbo);
+}
+
+static const struct drm_encoder_helper_funcs amdgpu_dm_wb_encoder_helper_funcs = {
+	.atomic_check = amdgpu_dm_wb_encoder_atomic_check,
+};
+
+static const struct drm_connector_funcs amdgpu_dm_wb_connector_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.reset = amdgpu_dm_connector_funcs_reset,
+	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static const struct drm_connector_helper_funcs amdgpu_dm_wb_conn_helper_funcs = {
+	.get_modes = amdgpu_dm_wb_connector_get_modes,
+	.prepare_writeback_job = amdgpu_dm_wb_prepare_job,
+	.cleanup_writeback_job = amdgpu_dm_wb_cleanup_job,
+};
+
+int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
+				struct drm_writeback_connector *wbcon)
+{
+	int res = 0;
+
+	drm_connector_helper_add(&wbcon->base, &amdgpu_dm_wb_conn_helper_funcs);
+
+	res = drm_writeback_connector_init(&dm->adev->ddev, wbcon,
+					    &amdgpu_dm_wb_connector_funcs,
+					    &amdgpu_dm_wb_encoder_helper_funcs,
+					    amdgpu_dm_wb_formats,
+					    ARRAY_SIZE(amdgpu_dm_wb_formats),
+					    amdgpu_dm_get_encoder_crtc_mask(dm->adev));
+
+	if (res)
+		return res;
+	/*
+	 * Some of the properties below require access to state, like bpc.
+	 * Allocate some default initial connector state with our reset helper.
+	 */
+	if (wbcon->base.funcs->reset)
+		wbcon->base.funcs->reset(&wbcon->base);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
new file mode 100644
index 000000000000..0bc9df7e7ee1
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __AMDGPU_DM_WB_H__
+#define __AMDGPU_DM_WB_H__
+
+#include <drm/drm_writeback.h>
+
+int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
+				struct drm_writeback_connector *wbcon);
+
+#endif
-- 
2.41.0

