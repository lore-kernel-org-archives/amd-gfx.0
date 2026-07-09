Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56A8C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF4310F6E0;
	Thu,  9 Jul 2026 21:02:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5QTshGey";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7F110F6E0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQWxgLHCPk3McoLjiQa2+Sf4jds0H2gx3ZmlnTyd6AJ66gyEN+jFoyoWogUMUgfrV4zj35EGpjamg4wJEO0rCLH8ZCswQxZdSJ1GR5ww26YzNlxiMVCmcxgv8rNyzknvMy2iI/RcHVjaXZF8Mc1N81WSxcQvX0xY0pRVdfkZopZaFL9FE60cgeaicstjk0Em7g4F8ReBtIYMQ+2Id3vtwlDDNXi+vZkTYbNVDRqPTU9/OXVDM/IUwEbT5JtV/ojWhXD3J/r9fjNa8bvMWo9+JjkktzzJ4R5HJ+CRPGbfa3zbzHXCVhnVS0SGhrOPF2A9Owifr64WBg3Bag6ra0/WfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7/RqB5bskTvV6VdE4fxL7AzTwjBQBoAqvjHiWjUMB4=;
 b=RCDeFtaBUxocYlWACsy/m+kPphQCe6BDXF+ikkHaxuYuYZ5tX9Ah+lR5mE2bc0c0EYXlf2CGLaMP0n2uFHQZemzD+S/UdMoY5UJINKffJidzt1enrVqVIjPYYArVpOvWy/aFOwrSOy7+JltWXiYul8OxXPZd2+xFkAb6Jtc3eTrQN+JUSiiiivKZP64iEPNRl0bO6bEQqHUpyNZSFUY9WeaFSLcjuuHT4pccp/sB0igBaPD7r+YuSxft43egBYtDKrOLiK8dnf9mLf6WbzAVmLArDt3dvpwUM7Re/hXpGa9NkZxhGFHjrRxeItw+91nHWaJKIpkSr2qFhVfWP6cl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7/RqB5bskTvV6VdE4fxL7AzTwjBQBoAqvjHiWjUMB4=;
 b=5QTshGeygJMC4VaRKz4THaI5Oudct69ZsoUd6NR7fEefAuEPnuHPHnZv9lwK58fWo5/kDktfeW16fj8dmYRNxEm/6pSuwvu6JidwV30PLx6hByAsn7Q9ZfkznNLEVgkOOsgWzq0Bq5NKp8/rIxXOmNdXw+n4efx1eabHpEy8vi0=
Received: from MN0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:208:52d::23)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:26 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::a6) by MN0PR04CA0006.outlook.office365.com
 (2603:10b6:208:52d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:26 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:06 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 40/80] drm/amd/display: More Kunit tests for audio
Date: Thu, 9 Jul 2026 16:48:08 -0400
Message-ID: <20260709205936.5719-41-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 66da1bba-bcbd-470e-6630-08deddfd613e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: j4mW7HJP//7pMeYOW6u/7NLM1lZkMO1M+fJlaMmiMEcl3XUN9DnU9KZ+O5Wv0uuCmJrqjobujwlfW6ME0I8Qx4PbSjbXUytkuN+JtgnypjbXleCxmHV0pM2RnQHxYbWcgrsgrE/J4oGn3KF674zrH1KWJUjZkK7OXRb+ADGmy+bgzycZydCGtpMHx6PxM5fMXVHT0cYIQ0lHRDtIst/O9m3V/vpc13sAgYRn4VU+qMNscRWoAzt6KVRioL4mvoGECZdZOGs0GqCVhlvj57/T6RyEP0rV7RNLwHwJHzEu9wsGNErFhpaUWp0GQ+rHde/4GUxaH7uhL+hb7kB5coJkmPECrxwfuhO8FWGmpaNMMs8lbyeeCWx7Ge/S5UHfzvINm3IeEGqTS4T/jNXUvvvVusJNZ2Pjs8NRcEzROsXu+sVp+IerjZNkmuwhl7B8ojln64N9d/5r1q887hPKWq0Kjjz7pPVAM1pHO7uz0PUuUHQMLHNJTkQwLK16lzpB41U0BhcbkXbl6FsIJJShby4Q1OH0ZktApfmf7XpzHWv1OK7lz+TZC9iaqLJhwi7qv+qvot+6ojXFuGqDd6JuaDkCQymTWQqUnm+wNIFQJOyFVMqtptEaguPhup/cyBZX0NHbZRBuDF5L+NQ/aUL4vl1ZsqmbBQr98PHqoIZlZy2gCmYKTe10G7OVH/sIDMmWLkhGVO5eCUHxu5/30/neIlfJQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4jW2804W+IuJW/gVUCBYfoCC5L1M3qjPYp/DL50FZVfoBuUPqep9Cg8OYvz1aKW6yaYQFA3Mw+fCa646ijg/lbte5LlzOHfXHzpfagGR62tlM3DF2hAsSTNZbLC2DQXfKg7n4eS2kCeaGc36S7yqgMBKSd15JOLro28GdcRl2XAaFFwlKm06M7jdJmUr0hVDJluXi6oFHi+CWrEBvYViPTRC/S/JG6D5++429ihlwl7j2dq/zIszVSSv9Mmff/3VYIFogP63Gl6rg+MqNgyFeCHsJ0C6MD1kzB955OIiFyADbwZU8Wel96vOHCpNFefuSFzok2fiucB0EOZmCEWbirmjRhD53+Qn7yf1/2QtgP0uNN9zHas0uS9qH42vDIbkcA/owQLm4DVPgob84b/wo57mvAz4XBBdAp8M6ZUp/QjZU1Tmbkmo3s1R05pdWmh6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:26.0768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66da1bba-bcbd-470e-6630-08deddfd613e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
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

Split audio init to make the initialization modular

Test the audio pin initialization

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.c   |  36 ++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.h   |   2 +
 .../amdgpu_dm/tests/amdgpu_dm_audio_test.c    | 118 ++++++++++++++++++
 3 files changed, 145 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
index 1ae121387297..7bba82ce2182 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
@@ -116,28 +116,42 @@ static const struct component_ops amdgpu_dm_audio_component_bind_ops = {
 	.unbind	= amdgpu_dm_audio_component_unbind,
 };
 
-int amdgpu_dm_audio_init(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT
+void amdgpu_dm_audio_init_pins(struct amdgpu_device *adev, int audio_count,
+			       const unsigned int *inst_array)
 {
-	int i, ret;
+	int i;
 
-	if (!amdgpu_audio)
-		return 0;
+	adev->mode_info.audio.num_pins = audio_count;
 
-	adev->mode_info.audio.enabled = true;
-
-	adev->mode_info.audio.num_pins = adev->dm.dc->res_pool->audio_count;
-
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++) {
+	for (i = 0; i < audio_count; i++) {
 		adev->mode_info.audio.pin[i].channels = -1;
 		adev->mode_info.audio.pin[i].rate = -1;
 		adev->mode_info.audio.pin[i].bits_per_sample = -1;
 		adev->mode_info.audio.pin[i].status_bits = 0;
 		adev->mode_info.audio.pin[i].category_code = 0;
 		adev->mode_info.audio.pin[i].connected = false;
-		adev->mode_info.audio.pin[i].id =
-			adev->dm.dc->res_pool->audios[i]->inst;
+		adev->mode_info.audio.pin[i].id = inst_array[i];
 		adev->mode_info.audio.pin[i].offset = 0;
 	}
+}
+EXPORT_IF_KUNIT(amdgpu_dm_audio_init_pins);
+
+int amdgpu_dm_audio_init(struct amdgpu_device *adev)
+{
+	unsigned int inst_array[MAX_AUDIOS];
+	int audio_count;
+	int i, ret;
+
+	if (!amdgpu_audio)
+		return 0;
+
+	adev->mode_info.audio.enabled = true;
+
+	audio_count = adev->dm.dc->res_pool->audio_count;
+	for (i = 0; i < audio_count; i++)
+		inst_array[i] = adev->dm.dc->res_pool->audios[i]->inst;
+	amdgpu_dm_audio_init_pins(adev, audio_count, inst_array);
 
 	ret = component_add(adev->dev, &amdgpu_dm_audio_component_bind_ops);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
index 48391305c3c2..761808b42f3d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
@@ -51,6 +51,8 @@ void amdgpu_dm_audio_component_unbind(struct device *kdev,
 void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin);
 int amdgpu_dm_audio_get_param(void);
 void amdgpu_dm_audio_set_param(int val);
+void amdgpu_dm_audio_init_pins(struct amdgpu_device *adev, int audio_count,
+			       const unsigned int *inst_array);
 #endif
 
 #endif /* __AMDGPU_DM_AUDIO_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
index 79ff5d9b3fa5..3f0108e9a951 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
@@ -6,10 +6,13 @@
  */
 
 #include <kunit/test.h>
+#include <linux/device.h>
 
 #include <drm/drm_audio_component.h>
 
 #include "dc.h"
+#include "dc/inc/core_types.h"
+#include "dc/inc/hw/audio.h"
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
@@ -38,6 +41,57 @@ static void dm_test_audio_init_disabled(struct kunit *test)
 	amdgpu_dm_audio_set_param(saved_audio);
 }
 
+/**
+ * dm_test_audio_init_enabled_success - Test init deeper path when audio is enabled
+ * @test: The KUnit test context
+ */
+static void dm_test_audio_init_enabled_success(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct resource_pool *res_pool;
+	struct audio *audio0;
+	struct audio *audio1;
+	struct device *dev;
+	int saved_audio = amdgpu_dm_audio_get_param();
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
+	audio0 = kunit_kzalloc(test, sizeof(*audio0), GFP_KERNEL);
+	audio1 = kunit_kzalloc(test, sizeof(*audio1), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, audio1);
+
+	dev = root_device_register("kunit-dm-audio-init");
+	KUNIT_ASSERT_FALSE(test, IS_ERR(dev));
+
+	audio0->inst = 2;
+	audio1->inst = 6;
+	res_pool->audio_count = 2;
+	res_pool->audios[0] = audio0;
+	res_pool->audios[1] = audio1;
+	dc->res_pool = res_pool;
+	adev->dm.dc = dc;
+	adev->dev = dev;
+
+	amdgpu_dm_audio_set_param(1);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_audio_init(adev), 0);
+	KUNIT_EXPECT_TRUE(test, adev->mode_info.audio.enabled);
+	KUNIT_EXPECT_TRUE(test, adev->dm.audio_registered);
+	KUNIT_EXPECT_EQ(test, adev->mode_info.audio.num_pins, 2);
+	KUNIT_EXPECT_EQ(test, adev->mode_info.audio.pin[0].id, 2U);
+	KUNIT_EXPECT_EQ(test, adev->mode_info.audio.pin[1].id, 6U);
+
+	amdgpu_dm_audio_fini(adev);
+	root_device_unregister(dev);
+	amdgpu_dm_audio_set_param(saved_audio);
+}
+
 /* Tests for amdgpu_dm_audio_fini() */
 
 /**
@@ -455,9 +509,73 @@ static void dm_test_eld_notify_null_callback(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_test_eld_notify_count, 0);
 }
 
+/* Tests for amdgpu_dm_audio_init_pins() */
+
+/**
+ * dm_test_audio_init_pins_sets_defaults - pin entries are initialised to default values
+ * @test: The KUnit test context
+ *
+ * amdgpu_dm_audio_init_pins() must set num_pins from audio_count, reset every
+ * pin to the sentinel defaults (-1 for rate/channels/bits, 0 for the rest)
+ * and copy each pin's hardware instance index from res_pool->audios[i]->inst.
+ */
+static void dm_test_audio_init_pins_sets_defaults(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	const unsigned int inst_array[] = {3, 7};
+	int i;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	amdgpu_dm_audio_init_pins(adev, 2, inst_array);
+
+	KUNIT_EXPECT_EQ(test, adev->mode_info.audio.num_pins, 2);
+
+	for (i = 0; i < 2; i++) {
+		KUNIT_EXPECT_EQ(test, adev->mode_info.audio.pin[i].channels, -1);
+		KUNIT_EXPECT_EQ(test, adev->mode_info.audio.pin[i].rate, -1);
+		KUNIT_EXPECT_EQ(test, adev->mode_info.audio.pin[i].bits_per_sample, -1);
+		KUNIT_EXPECT_EQ(test, adev->mode_info.audio.pin[i].status_bits, 0);
+		KUNIT_EXPECT_EQ(test, adev->mode_info.audio.pin[i].category_code, 0);
+		KUNIT_EXPECT_FALSE(test, adev->mode_info.audio.pin[i].connected);
+		KUNIT_EXPECT_EQ(test, adev->mode_info.audio.pin[i].offset, 0);
+	}
+	KUNIT_EXPECT_EQ(test, adev->mode_info.audio.pin[0].id, 3U);
+	KUNIT_EXPECT_EQ(test, adev->mode_info.audio.pin[1].id, 7U);
+}
+
+/**
+ * dm_test_audio_init_pins_zero_count - zero audio_count leaves num_pins at zero
+ * @test: The KUnit test context
+ *
+ * When res_pool->audio_count is 0, num_pins must be 0 and no pins touched.
+ */
+static void dm_test_audio_init_pins_zero_count(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	/* Pre-fill a sentinel so we can confirm the loop never ran. */
+	adev->mode_info.audio.pin[0].channels = 99;
+
+	amdgpu_dm_audio_init_pins(adev, 0, NULL);
+
+	KUNIT_EXPECT_EQ(test, adev->mode_info.audio.num_pins, 0);
+	KUNIT_EXPECT_EQ(test, adev->mode_info.audio.pin[0].channels, 99);
+}
+
+/* End of tests for amdgpu_dm_audio_init_pins() */
+
 static struct kunit_case dm_audio_test_cases[] = {
 	/* amdgpu_dm_audio_init */
 	KUNIT_CASE(dm_test_audio_init_disabled),
+	KUNIT_CASE(dm_test_audio_init_enabled_success),
+	/* amdgpu_dm_audio_init_pins */
+	KUNIT_CASE(dm_test_audio_init_pins_sets_defaults),
+	KUNIT_CASE(dm_test_audio_init_pins_zero_count),
 	/* amdgpu_dm_audio_fini */
 	KUNIT_CASE(dm_test_audio_fini_without_enabled_audio),
 	/* amdgpu_dm_fill_audio_info */
-- 
2.55.0

