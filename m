Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6116CC531F7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42B910F1D8;
	Thu, 23 Jul 2026 20:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l+DVI7lm";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D694310F1D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwXNJ1tD6KlcRCXhrnHQOgGSQrBkVGfhUCV4kKnyLtH7ktFCybHGS1155tWY/FDv2Wwn9Gmp7JMcrIPW9KUVOssUdSowk1m5Jq0W/9Ei1FZuP1WKhib2fkL+qjLrua+MjSop2h1p3Ockyi9bT7vrXekX2RisdTRb6GdQL6F5hVU4VJeDS5+QgamNilL4RCBZZBva34q1P4spFIwpBr0FSMwf/EsHsvyyT4HNFQHDz+e285tjF+mg10rhM2oinRQeadNis45SRgFFP5a0Qk5KL3UhQB2plhdxuahbNwJYk//TyRHeHPw5TbY1PGIgvujPhjyCic/XHMBQ697/uV153Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epPB/PW8d8eDYLxDoI8JcYCXQoXrShfKAGR3wI2JITs=;
 b=iAKm+pZMO/0Szf0lFKK+tO9pEwEXYrFppP/Dgze5j0IwJS1pZuRfeHElImYDlyD32gx8j6qxPvtLqbJCJzXjAlVhkErXYE9aONMdeZ+q+xsdUbD60Def5Hq1Qg/i0Ebv2dEhMxQBbBWUeKQ/wKH8izTxFuGCulkHA2Sgbb4qBNSZXb2iVVi0/ngSxTTUOpLmGnN2hEPviJvOqV4Eyp90H7pU1pMw37WbhNksa+EtIDU4byWwtBGonoipbVtPDvFGFVbAodwCxZUcFhC43R1qk2sSOt21DbCDplGGkLb231Yp+DyGgqK1MI8lgEwlQKSAumXrp9eFpFgfGs79YPnWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epPB/PW8d8eDYLxDoI8JcYCXQoXrShfKAGR3wI2JITs=;
 b=l+DVI7lmFNaFFxU7d7b84VYuqtZ3R/0i0py3CAsMAbe7C6cORg5BIl8S6uhY/Ncx4P7lPsHzlewmA0O4Xr8vkOXvVguW+ZxQthWngRz/FU0J+IlcRHufebsP/PZSoTyruAO9fZHN7w0L0bZ9l6NqJrkdM4jF3AeqEEYAb9ndD9U=
Received: from BN9PR03CA0669.namprd03.prod.outlook.com (2603:10b6:408:10e::14)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:12 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::86) by BN9PR03CA0669.outlook.office365.com
 (2603:10b6:408:10e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:12 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:01 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 18/49] drm/amd/display: add KUnit tests for audio component
 get_eld
Date: Thu, 23 Jul 2026 16:13:26 -0400
Message-ID: <20260723201908.373300-19-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 5922b988-b244-4c1b-7d3d-08dee8f7a923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|18002099003|22082099003|6133799003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: dYEFHhC3Z1FmMChQd+SK50AIpJg7GEjoF5/JfXCwR4XIOVNTvl/KwM1A0TQNRQz4PsymTyOXrM7zxnwcvL7WNZ6U7Iwdf//kRm+kdTOJGC1NU68QiaL0XSjOqXF3T6KdwDKbdCJgUGIU91lsfSNGgsU9FDoSuNJ2hP2kaImcSROFe7VJMpDG/hBIZZ1BcrJA2L8sZeAoVXxDiIJ9/9w0uepO1/JpFYJS5R8Kr3ZIEh/0fpBBgSeA6+JI/Gu5/Gv5prSh6a44JGhd6ck3AAabl+hX5aCmbDnvcqMk1LcTGH6g32WUwqlPKAvlYN2b71yg8qf6vrbDC6uBsg3OWiGWoWaLyjtExyfbp5ghPnuP5b3eek7qkopAoOtW5FOHgrchpcuqe6JBTvKuOOSER0GpvacYcV4VHSKqX4RF+aH0KfMvHvcwR8CkrNPKKxGLNZeznPOBlEhfSGBjpB4vnLP/dAW9aj96+fBkh0tgGxi5AKuwX/eSScYxhYkURVxhbV76bNgN1L8ydBLKf6iE/hVXpRn+qToGUlBLrNDXtXEIKRndXm1SccjArf0ZgXmeBTgioHOAVtnRXOZtvDVSR1gEPydDxONPODnduIssezLSvGgjFimBHl1MZvu606cCaGSiKeWXKEdLApGz0cjZqBqBfNAZTX9krSn4v2CJ93me0lDVBAMMR6yCmx4PpzFYDAYZDUJAjB3yWVVZYLN8U8uyTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k+HgCc20Jntqg4VNvJMJ38zaRe6HWuzVVYbNDvBpuX20uLsq1v+ZGO5B+DIh/dQKr3QV7Ll8ZVUuWhtKARvGJY3Jplv5BxCJuFrqqToBcY68tA4MzUv+fxxig6jQpPAznWtz1Pwjm+ngfn3nM+Y+OCdmAUZHKKZKgdgIRruSav2hSjPF6dNIV+XbGQ0XEnQFcpEVdFr5Q30yhHQK0ApctC4uqpf6iEoXMjKo31CElOKYrqB9LZSXfXgxuyCYNRdWKZWxehomuz+bnO604mKnIZZA8MZW4ysrlvGnPvi76J9N0j3ilD7hBfkCirOICqgSEYfUjmAtkGrSax8E80Rfe+jTdgnwkeRdFxJMtv4Hnio8Op7VLZryV1jV8tkjUAUdZwsZmhzB4Z+Yie7HorqxvNZBPWVvaE+EHFY3DXQDrW7p4avz4SJTOJ/Z0wT7KINA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:12.4983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5922b988-b244-4c1b-7d3d-08dee8f7a923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
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
Add KUnit coverage for amdgpu_dm_audio_component_get_eld(), one of the
functions reported as untested by gcov.

The tests use the standard DRM KUnit device plus drm_connector_init()
to build a real connector list, then invoke the bound audio component
get_eld callback. They cover the matching-connector ELD copy path, the
writeback-connector skip, and the no-match (disabled) path. A shared
connector funcs table and cleanup action back the fixtures.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_audio_test.c    | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
index 3f0108e9a951..d30b7f644f97 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
@@ -8,7 +8,12 @@
 #include <kunit/test.h>
 #include <linux/device.h>
 
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_audio_component.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_eld.h>
+#include <drm/drm_kunit_helpers.h>
+#include <drm/drm_probe_helper.h>
 
 #include "dc.h"
 #include "dc/inc/core_types.h"
@@ -17,6 +22,20 @@
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_audio.h"
+#include "amdgpu_dm_kunit_test_helpers.h"
+
+static const struct drm_connector_funcs dm_test_audio_connector_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+};
+
+static void dm_test_audio_connector_cleanup(void *data)
+{
+	drm_connector_cleanup(data);
+}
 
 /* Tests for amdgpu_dm_audio_init() */
 
@@ -569,6 +588,103 @@ static void dm_test_audio_init_pins_zero_count(struct kunit *test)
 
 /* End of tests for amdgpu_dm_audio_init_pins() */
 
+/* Tests for amdgpu_dm_audio_component_get_eld() */
+
+/**
+ * dm_test_audio_component_get_eld_copies_matching_connector - Test ELD lookup
+ * @test: The KUnit test context
+ *
+ * The bound component callback should find the connector whose audio instance
+ * matches the requested port, report it enabled, and copy the connector ELD.
+ */
+static void dm_test_audio_component_get_eld_copies_matching_connector(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector *wb_connector;
+	struct drm_audio_component *acomp;
+	struct device *kdev;
+	unsigned char buf[DRM_ELD_HEADER_BLOCK_SIZE + 8] = {0};
+	bool enabled = false;
+	int ret;
+
+	kdev = adev->ddev.dev;
+	KUNIT_ASSERT_NOT_NULL(test, kdev);
+	acomp = kunit_kzalloc(test, sizeof(*acomp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acomp);
+	wb_connector = kunit_kzalloc(test, sizeof(*wb_connector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, wb_connector);
+	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, wb_connector,
+						 &dm_test_audio_connector_funcs,
+						 DRM_MODE_CONNECTOR_WRITEBACK), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+			 dm_test_audio_connector_cleanup, wb_connector), 0);
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconnector->base,
+						 &dm_test_audio_connector_funcs,
+						 DRM_MODE_CONNECTOR_HDMIA), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+			 dm_test_audio_connector_cleanup, &aconnector->base), 0);
+
+	mutex_init(&adev->dm.audio_lock);
+	aconnector->audio_inst = 3;
+	aconnector->base.eld[DRM_ELD_BASELINE_ELD_LEN] = 2;
+	aconnector->base.eld[DRM_ELD_VER] = DRM_ELD_VER_CEA861D;
+	aconnector->base.eld[DRM_ELD_SPEAKER] = DRM_ELD_SPEAKER_FLR;
+	dev_set_drvdata(kdev, &adev->ddev);
+
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_audio_component_bind(kdev, NULL, acomp), 0);
+	ret = acomp->ops->get_eld(kdev, 3, 0, &enabled, buf, sizeof(buf));
+
+	KUNIT_EXPECT_EQ(test, ret, DRM_ELD_HEADER_BLOCK_SIZE + 8);
+	KUNIT_EXPECT_TRUE(test, enabled);
+	KUNIT_EXPECT_EQ(test, memcmp(buf, aconnector->base.eld, ret), 0);
+}
+
+/**
+ * dm_test_audio_component_get_eld_no_match - Test ELD lookup miss
+ * @test: The KUnit test context
+ *
+ * A non-matching connector should leave the audio port disabled and return an
+ * empty ELD size without copying data.
+ */
+static void dm_test_audio_component_get_eld_no_match(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_audio_component *acomp;
+	struct device *kdev;
+	unsigned char buf[DRM_ELD_HEADER_BLOCK_SIZE] = {0x5a};
+	bool enabled = true;
+	int ret;
+
+	kdev = adev->ddev.dev;
+	KUNIT_ASSERT_NOT_NULL(test, kdev);
+	acomp = kunit_kzalloc(test, sizeof(*acomp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acomp);
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconnector->base,
+						 &dm_test_audio_connector_funcs,
+						 DRM_MODE_CONNECTOR_HDMIA), 0);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+			 dm_test_audio_connector_cleanup, &aconnector->base), 0);
+
+	mutex_init(&adev->dm.audio_lock);
+	aconnector->audio_inst = 4;
+	dev_set_drvdata(kdev, &adev->ddev);
+
+	KUNIT_ASSERT_EQ(test, amdgpu_dm_audio_component_bind(kdev, NULL, acomp), 0);
+	ret = acomp->ops->get_eld(kdev, 3, 0, &enabled, buf, sizeof(buf));
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_FALSE(test, enabled);
+	KUNIT_EXPECT_EQ(test, buf[0], 0x5a);
+}
+
 static struct kunit_case dm_audio_test_cases[] = {
 	/* amdgpu_dm_audio_init */
 	KUNIT_CASE(dm_test_audio_init_disabled),
@@ -593,6 +709,9 @@ static struct kunit_case dm_audio_test_cases[] = {
 	KUNIT_CASE(dm_test_eld_notify_no_component),
 	KUNIT_CASE(dm_test_eld_notify_null_audio_ops),
 	KUNIT_CASE(dm_test_eld_notify_null_callback),
+	/* amdgpu_dm_audio_component_get_eld */
+	KUNIT_CASE(dm_test_audio_component_get_eld_copies_matching_connector),
+	KUNIT_CASE(dm_test_audio_component_get_eld_no_match),
 	{}
 };
 
-- 
2.53.0

