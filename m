Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC95C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5841410E890;
	Fri,  1 Dec 2023 13:29:19 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F7010E895
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVe/mYbzCBywWTl2j8I+G0t3FYNmxtMCWYL0NwhEUq1uMnwgD4rJinfOR/6aneoHl8HU/Sx7VCNasNFqjvSCIq1H5PI6Bwl6l4nVR2XX+1+mMHni6gO+/UJ0w4vYD2T0yYBbCc9Jo07pDNeUoHQcqX7XCsmgRBSF8HzVbqpb0QByEi43Hn+6QWqpVbq/5RiU4/7HdlyWd0rEOHtkuwBA/Cg6Fr/Dtu9t5Rq88hOhJ0a6Qui7olu1ghQ6hrVfnKairnHa45ttUcK1oZYnphpIX+lYvkt40HmSAzI3Rpm8bcr5SjhPlG+b5isROfLtCw9LPZ2BF4/Ya6Z0kMe5BszYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETbH7zG1LgqybBin6GcC+7lkRMfUUxyB07cFbFjIXpA=;
 b=Iescsmn9hx5nIZKKzZyH1FX+3GUWr2txBAF2TmP3zrmO7CkLwqW5wLKsniyldnpwFQaVR+amRHRvcTnxlCGpyEvAMZBeY5fRG2UVgjuJvQOpVY8SxKSHHd5z/5b3SiJasbRtOGEXNHpHJIkeVt/cj4/TwpLdNpMsin18YF9mn4bHdA0o0EnAKegaB0ldcQN1O5fgAbe82Jx2cdjyVaXNwL/y9WJb6BtkeKiNtZtNi9r6YST6Lmz8OctM4s31WHOumIsF3hrH4DiZJ2YGMF67k2XqNf+EeWk/WUz4iSuP/pi1w4/AHhK3lWK5XRCQfZa+m8I1Fllq2nsKfgFUvhCnbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETbH7zG1LgqybBin6GcC+7lkRMfUUxyB07cFbFjIXpA=;
 b=mwWqT4grxZOlJWWI0u7QUzPUmhNgnAEjae1592oC7QazALL3rDzlWR1EgGfhYxT7DAYfJEA4E+ekNb/WUc0me2+bvy6/Gde4h1tp0olDk3i8kN1I2GPqeQPfd28H6YSMJe0HQt7wXfsBIyTWxFqt0G/6isYGiNe155mQQu7XvpM=
Received: from DS0PR17CA0019.namprd17.prod.outlook.com (2603:10b6:8:191::8) by
 LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 13:29:07 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::f) by DS0PR17CA0019.outlook.office365.com
 (2603:10b6:8:191::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:06 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:02 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/47] drm/amd/display: Initialize writeback connector
Date: Fri, 1 Dec 2023 06:25:24 -0700
Message-ID: <20231201132731.2354141-29-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf70d99-ee4b-4f75-262e-08dbf2717e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OxZX0l1ONOvYV6M8yVNoEiSSptnxST+AxinJt+RkImUlz47lN8P8LiY80V8XKgPO/nrgBi5GJI97maZmtmFH7tKr+yYDWHVT02cgfsvI5FibpEiPtCvq+aN+0smA7UdAJrqmVoQPOwy170p1OrW/U0SXq/6GErIYajoUQgXo3y1GPBpedZqR2BgUWm+m+o9sRDi+T8Zi/2Xwes1ebKpXlZ9SXeF4uzAIumrfw8knpnGuaBJndCxzGkzNWA+cjWyq1HYEYG6l/4hn21jyAZvIRJGOisHP9zOoNOqqOAajtQn2G7uVa65dsSljFqaClPGpVlqV0M156ujl3JqH6geu9m/pn/iLQ9rBCtlHIQjKPp3ww3n7e+GTPgCnEaEN7YxvpVSAJ2oupagQ2KGk0jE/sLtfyjRPu6AypD/c4FtaFb4K85Qw82ocEWvgxCl41/WRgHh94L63OHWMfKd9wkRhriqZ2QhOBv6Ikxrye1ilv3swuDBQuSofkFAAo6Vj0ERtrRVPv2ibkna6IPP1mWRmQQrkjEq6dcypnxtN6QeGhrPXILHaHmf2en5MXKfhAuMMtuOeo6UXBukXk2wDYi6m25HrtC7HcXi4fY2Tzf1A63GUuQXQjsQBUae9Uc1H9Mjget/T4lyJ6/iGx4UM2XixI4nJbwkCrPDq0zbXSXtbmtkW51+mDT7QFdCWKsZyPHmVmCF9I6mt/dGwZDZ+CpDqYJJjptOzDbPsielNlOudDVwlvfdDWbEAZRgECP2TUZ3ZKGwYc1DyNa1TJvoBvm6cdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(426003)(336012)(2616005)(16526019)(1076003)(26005)(6666004)(36860700001)(70206006)(70586007)(83380400001)(47076005)(5660300002)(30864003)(2906002)(478600001)(41300700001)(4326008)(8676002)(54906003)(6916009)(316002)(8936002)(82740400003)(40460700003)(356005)(86362001)(81166007)(36756003)(40480700001)(66899024)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:06.9239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf70d99-ee4b-4f75-262e-08dbf2717e77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Create a drm_writeback_connector when connector signal equals
SIGNAL_TYPE_VIRTUAL.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
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
index 21a7db337d8c..2b7224eb63a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -54,6 +54,7 @@
 #include "amdgpu_dm_crtc.h"
 #include "amdgpu_dm_hdcp.h"
 #include <drm/display/drm_hdcp_helper.h>
+#include "amdgpu_dm_wb.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_atombios.h"
 
@@ -4453,8 +4454,25 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
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
2.42.0

