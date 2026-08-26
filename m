Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED8BC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E9310EE4E;
	Wed, 26 Aug 2026 23:25:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pjWuUemc";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EECD210EE4E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:25:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhYrRNpxtaRrtIvv1fmP+GtWNN96RP2f0075B/rwGSBZ+W/afAkBDWoL1+b0QjCEvAQ7SkE/VATZs/N+tSTvQ1iMH9n83U9b51g99390nTibygbkcikkwqJnH5h7Id4IGALR87KTsGkv/p1ZdJPckZvKaGa/7Orh+bLL4EKNLiM+sCcFQHYxCPRLRDRnQxlEFHOr9T5bBnt1PFwUAFgGZzGqhn4fEHuPVN4nWwPVtoS1lgtbZkgMzhV7jLGrJvYqH/aI8WUlGznQQiSynd0cNERuyrJMLqUy1dFcBSMrXRP70DMr+HoM0AYqEhV/1ZHewBGpEE4giwITG/DfuxwLHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYEN0E06xFk2qTVUH74f0ycE9Fhs6rYWZ/zXXtCUFPo=;
 b=ZDnfCQe+jC9ce+r0TDxQ+DBVVJn9QF9MtOGi3i+yBqroJVGXfiQMaVaKA/lRDpJb2sW8KM1+REwW/PWn7hkQjDti/B5bve3mmnn+GJvt2a+jU1zsRsNvqlACSUNAcJqyne8U2m8n2ZWLx+XCGtnjfRA+DAQQgKnM7M8xX7kQNgcbmDVWst3FGOesRaUJddudjUqAXwgvTqssVilCNAjJ9/S10WGFtV1RdvYBBrZFDHnwm2VUJU1kK6RlPHfQvsBirnxdGLtUELFJlatN0p3NY+rs3xbTNCvjqq/ECXWcvI6fVIElSMBKjPbOeDgdhaE3vemIQvfIzb/bVIdVsv90vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYEN0E06xFk2qTVUH74f0ycE9Fhs6rYWZ/zXXtCUFPo=;
 b=pjWuUemcDchfs8yZ1lA+/Lcuvv4gkIJPbkTkvYQRj0gO3Xv/RgQI0DVNi0I1bBkRTei6e3iZpvs16K/WEPcGQ8lcoysTxcxqwmHideFUXBHMGwnrfVOw/QBeCnkdwIU2PZl8Ag6ATRTHo7Y7TfLjg3s5wkeGmNpBEU8s2IgZEJY=
Received: from PH7P220CA0171.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::32)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:25:34 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:510:33b:cafe::95) by PH7P220CA0171.outlook.office365.com
 (2603:10b6:510:33b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:25:34 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:25:29 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 29/59] drm/amd/display: Test vblank counter and scanout
 position
Date: Wed, 26 Aug 2026 17:05:00 -0600
Message-ID: <20260826231519.881949-30-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|CH3PR12MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 505ca6a9-c769-4a38-cb05-08df03c953f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +zmMcrXG+QkWv3NOSqu51GG5llRDD/QI6rGykPCxwjpJtpiUXsKA2kil2YmmOD9YY5wHhGNffjLqgBCeDr/9iOuuCnXY2rNIOGzh/pRZh0XSQX9vT/vAB5FlsG/dqYlvD71Qz9su5KOCYcr8tPoNQ9jzZ3YKGbdIc7kKnVTFiOnaxPubl6Eg9VM8cfAsyew3Nxbo8XYf6NLwZUTGGl7yFqPPYU8zqx6GA7FKwc7FkBoEYFxUo84wIlZ9cfdr7CZ7xSWv7/fiKD5L9kZv3/L3V+dV1fFxJQYU4lvXFrBI3GyemXD7y2/RBrvRNinbt7S3BQRggGbLHK7IhF6TCDsvNxU6OV8S4xbEo6mHhr2olPYfYOd1lBrYSgj3yE1sxsbgtb+yT6o41B93+RkoWrBzbKp+C3Vj3daiPyOc1qP5LDK+QieKySL5AEH37JBBCzyYnrrAyAJgdZL6ZpI2tQVAo41DNhUm1l0BxrpX7EQKar+W1AsLT58A/oI5h237m67M8C5WHVULBjEN1dCgMXS6Jcc8OALWwLRG6UPwDeZ5yjTE8wGvO/Ma+ZK4abEc7jE3JXKYVRoXL1FVgT4YBdBE4mzKnajiCP/2xuhVXh5hhB4LxRtjxZD+DJS+bmHfK3zVv+ptoTaB1aiMMhf4GlR1Wo1HAlZLCPoXLMiwmXOsxu1odePyjr0fRzrjC5HDEYQao6Nc6ejcMabk0MWwF/bqWA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5yYHa5T97lJ5QuNU/hTYe+iKVutbe6HQpljHKR4ARSPC/fP3QyX0hceAhixG0Y7aCcW8JDfA+y0pu7pxCiSFvkPXCilXJI3QeV3AuECNk6TdF5MsNiEpWUpgJqil/na1CbLdJ5cbiPpi91kS+Yy4CYIcX/VAPmIAhkRnfXqOSZr6LBtu35d91Y+NxgZLIJUMJ/YYtYAi4VCjg4B3mKrouWGtRCWo1c7ACbUybGX+ktl1CtCO57DfSN0uNQ8Sxh7zylSCPGZ0GGPPjy52u6qUqf/PKNDh94PbcaPY5h8r5POvnzTB4h/lAORF+89X9TFAjDtzZvTjTX/mCNjpjw7ZVa3/LWmXsDXXYDwP1OZYARlffcZsITo6UFIeAfap60mYqaonty41f8RezELdYqQiD9X0l3j7Cr9Zc78GYG2zzvBkWCGzW2E9BfUlZzruc1rJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:25:34.0486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505ca6a9-c769-4a38-cb05-08df03c953f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100
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
Add KUnit tests for dm_vblank_get_counter() and dm_crtc_get_scanoutpos()
covering a CRTC whose stream is not owned by any pipe in the resource
context, and the branch that disables idle optimizations before reading
the scanout position.

[HOW]
Wire a DC context, a current DC state and a logger to the device so both
callbacks walk the resource context instead of returning early.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index a0f90b0bd74a..33cca3f01b5b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -8,13 +8,23 @@
 #include <kunit/test.h>
 #include <linux/pci.h>
 #include <drm/drm_atomic.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_kunit_helpers.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_modeset_lock.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_property.h>
+#include <drm/drm_vblank.h>
 #include <drm/drm_writeback.h>
 
 #include "dc.h"
+#include "dm_services_types.h"
+#include "dmub/dmub_srv.h"
 #include "inc/core_types.h"
+#include "logger_types.h"
 #include "amd_shared.h"
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
@@ -1141,6 +1151,87 @@ static void dm_test_apply_delay_nonzero_wait(struct kunit *test)
 	amdgpu_dm_apply_delay_after_dpcd_poweroff(adev, sink);
 }
 
+/*
+ * Attach a DC stream to CRTC 0 of @adev so the scanout helpers walk the DC
+ * resource context instead of bailing out early.
+ */
+static void dm_test_crtc_with_stream(struct kunit *test,
+				     struct amdgpu_device *adev, struct dc *dc)
+{
+	struct dc_stream_state *stream;
+	struct amdgpu_crtc *acrtc;
+	struct dal_logger *logger;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+
+	logger = kunit_kzalloc(test, sizeof(*logger), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, logger);
+	logger->dev = &adev->ddev;
+	dc->ctx->logger = logger;
+
+	dc->current_state = dm_kunit_alloc_dc_state(test);
+	KUNIT_ASSERT_NOT_NULL(test, dc->current_state);
+
+	stream = dm_kunit_alloc_stream(test, NULL);
+	stream->ctx = dc->ctx;
+
+	adev->dm.dc = dc;
+	adev->mode_info.num_crtc = 1;
+	adev->mode_info.crtcs[0] = acrtc;
+	acrtc->dm_irq_params.stream = stream;
+}
+
+/**
+ * dm_test_vblank_get_counter_unmapped_stream - Test a stream without a pipe returns zero
+ * @test: The KUnit test context
+ */
+static void dm_test_vblank_get_counter_unmapped_stream(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+
+	dm_test_crtc_with_stream(test, adev, dc);
+
+	KUNIT_EXPECT_EQ(test, dm_vblank_get_counter(adev, 0), 0U);
+}
+
+/**
+ * dm_test_crtc_get_scanoutpos_unmapped_stream - Test scanout position for an unmapped stream
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_scanoutpos_unmapped_stream(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+	u32 vbl = 0xdeadbeef;
+	u32 position = 0xdeadbeef;
+
+	dm_test_crtc_with_stream(test, adev, dc);
+
+	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0, &vbl, &position), 0);
+	KUNIT_EXPECT_EQ(test, vbl, 0U);
+	KUNIT_EXPECT_EQ(test, position, 0U);
+}
+
+/**
+ * dm_test_crtc_get_scanoutpos_exits_idle - Test idle optimizations are disabled first
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_scanoutpos_exits_idle(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+	u32 vbl = 0;
+	u32 position = 0;
+
+	dm_test_crtc_with_stream(test, adev, dc);
+	dc->caps.ips_support = true;
+	dc->idle_optimizations_allowed = true;
+
+	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0, &vbl, &position), 0);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -1207,6 +1298,10 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_apply_delay_null_sink),
 	KUNIT_CASE(dm_test_apply_delay_zero_wait),
 	KUNIT_CASE(dm_test_apply_delay_nonzero_wait),
+	/* dm_vblank_get_counter / dm_crtc_get_scanoutpos with a stream */
+	KUNIT_CASE(dm_test_vblank_get_counter_unmapped_stream),
+	KUNIT_CASE(dm_test_crtc_get_scanoutpos_unmapped_stream),
+	KUNIT_CASE(dm_test_crtc_get_scanoutpos_exits_idle),
 	{}
 };
 
-- 
2.43.0

