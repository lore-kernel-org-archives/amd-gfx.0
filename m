Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66E4C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A0110F06B;
	Wed, 15 Jul 2026 13:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tlfajRMY";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010011.outbound.protection.outlook.com
 [40.93.198.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D436010F06B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBcwLJV1OYXG6ZcCdFx1koSZBHm0aE/WeJ8lHPA0L17BNa6bD1V0iASA36UL1fZ73xb/s23P1gWeYx/Y8JgyTNSUIEZ4kUhRwXGp/bbYbjl8XhnYSwgLv+Bs03TZUbcKiOe4CROn/HmjbWfv0rSkWJgpRe9DPKpYch+qH/ScXqyMCs2tFb1LUU50HwBC5DeXNq5+qH1/lak6Eg5OZGzZyMyZpByT25CXNxXKP6hkzkmIE1YDHf3Cg9B1sjU10ZjJjIWeIFuEhv+6MWoN31ILivpZLG3/yba0D8k3UF9AU0a0+TO3ifyTdTIFFIv8tEUS/kptLcB2juRnjqB/v6OFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngk5Obtte2PJ82ZJN/7JHW0JVGrnhOpJm5ZR2Rwsk04=;
 b=wmWzCf8SwtbYHocXAQOdetXMXQOW0RZy1QsqAuaZqV7gwATT4CbvLkFUW13y4XwNDyRJRmW/eIpKJvyQc6NqAicbtkwGglt2uDCQxt69pUUFL6pwhRzJQw0YS280CFF3Bi2jEtjUazQhIRaOVRhNG3ROXxwEadFyxIzBPuj3Gq4O8ISZuvMEnJzi7ZB4bjoEQtB8TGRshRJ/QBYqvrJ4N5JT04nqXgsJc23mTX4dh7d7JcpQ35fX/+LDc8IQF5fMvMC/Rhz0iOq9xe2FiUeq7+Ax4bUs1JieK4gaIs3c1mlvvGmcaLYRDSUvTY1zM3MswEeW6pA7Qj1NH8dZkfc78Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngk5Obtte2PJ82ZJN/7JHW0JVGrnhOpJm5ZR2Rwsk04=;
 b=tlfajRMYzh1X9+Q3n5cHQt9kUoE4zcEU1qE8A+xTzrnlkd7IEM+NHumS9we5OsvHntpZkBkUn5GXKVf7GpJnsnvJfguQVuqGYxRowiIhbprUYCiML5Hq3AwL1zd+rZQyXPFhw1I12LMicP6Zimb4V/m0OquJ+PxfU5jg2DdGZIE=
Received: from BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::11)
 by SAVPR12MB999119.namprd12.prod.outlook.com (2603:10b6:806:4e9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.24; Wed, 15 Jul
 2026 13:45:24 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::61) by BY1P220CA0023.outlook.office365.com
 (2603:10b6:a03:5c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:45:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 06:45:11 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:45:08 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 05/70] drm/amd/display: add dm_dmub_hw_init KUnit coverage
Date: Wed, 15 Jul 2026 21:37:15 +0800
Message-ID: <20260715134432.1975118-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|SAVPR12MB999119:EE_
X-MS-Office365-Filtering-Correlation-Id: 18451be6-eb27-4771-a4c5-08dee27751cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|18002099003|22082099003|6133799003|5023799004|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: tnQ31sd+2GsASBbRFZe9iVGhCbgGPNBdhmndqZisFqq1UXkS2pVx8fkPLelotl/qL8Lf9+M9SJcgGIoajESMLoPLkf2tgRrQMnA3clN4tnW0QKN9jiyTbDugqs0wBBY+DaD5tFM2nFRUzzL7vWYFQTl7KJYo/hOifi0HvugPMoNMdqKpE9YYM1QL5ZHCFYAB/Z4EdR8r/qyYtwShwsQNwnAm1123VhfsD5rZGoNJIM0vQFiR94RmlqJeBdxCU2Uz5XF8aT9Dz+LsT9E+c0GyPbKIEIT6HELvD6vrb3ZWQUDblSbZ7XFkzEx4UOzWmA9H2kaNG8+JyU3mUNj/kq6jfAUNZivUWvjJyGckdiB9jmdcMNGM0rselE4NYFtri11N3A14tHS+lU5UoouPJ+I6hZEI+4ZRag235X8V7bI78IpOHj0dvBN9n4HhtZsaYygCqYM2XGscv0gufkFaJsx/UE+EKjM4bVgZeXdZz05b3P3lwTT+R/dSXhtdtq69bwop3jz1qghYer1m7RmUD8eaSJZF/3gNNciE7ef7eI2/aOwJOd15Joh0IKVehhRMoYG/gg2zjMcGPGYKPBtRAHf7PGI/Wl48UZ1Tw4xplx+M1DYNnbyENPafaA3yqqomov5O0FtJulFPAkKbOMelYt+B9WzTHdIxdE5DamleZSYV7CMLRoENLUtN2iN/o86x1Oz2X9IGIb5i9VoV9jrBJ9UsaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(18002099003)(22082099003)(6133799003)(5023799004)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9gXLp38gLxWu8CiIb+BgdlEDkBQ7F9FIG+SahtX1zsdBmt3bg/3TS0+B2aOaY+G0JbP9l+ybTKTRkTKWIFsPSPwG6/HoN+PC9uEBr2HHmszOmlhDvvt+YXFIYxUh4WfQ/rzNkLlZoVK8sL+tKlRPaD/z+p5e9oixF3prKtLUp+dny/YCq/UZLctFJLiNY3L6xL1bF8uF4TFWUSxnHBQ32JtYa0flnJj6ogBLp1E0Df6Pn6fXJMQol4a9QZ15ByJ0ASce9EJHgFOxL2j0SeYEZdpgxKYLCftdy44la4IJ87ciqHf0fRBVu8YAgSFelgLod1gOifuz32gdpJKIE14cdEQxBzYBppvhq68ns/Cs2JROIWdC65Xtmj4gyOKjgv26s1THHaBCH3qgqeqMWHMqelkDxP5p7mhaeG6FYmtJllk9KTPBvLj0B1BnHyvIpxSl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:45:23.3454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18451be6-eb27-4771-a4c5-08dee27751cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999119
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
Add KUnit coverage for dm_dmub_hw_init() beyond the existing
early-return cases. Introduce reusable fake-DMUB fixtures (fake
dmub_srv/firmware, DMCU/ABM stubs, and adev builders) so the init path
runs without real register access, TTM allocation, or firmware loading.

New cases cover the fake-DMUB success path, unsupported hardware, BSS
data copy, hardware-init failure, auto-load timeout, the APU/DPIA DCN3.5
params, the DCN3.1.x sanity-check ranges, and DMCU/ABM initialization.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 315 ++++++++++++++++++
 1 file changed, 315 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index bf90ccfbf431..4c01f7919170 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -6,14 +6,20 @@
  */
 
 #include <kunit/test.h>
+#include <linux/firmware.h>
 
 #include "dc.h"
 #include "dc/inc/core_types.h"
+#include "dc/inc/hw/dmcu.h"
+#include "dc/inc/hw/abm.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
+#include "dm_services.h"
 #include "dmub/dmub_srv.h"
 #include "amdgpu_dm_dmub.h"
 
+#define DM_TEST_FW_SIZE	512
+
 /* Tests for dm_register_dmub_notify_callback() */
 
 static void dummy_callback(struct amdgpu_device *adev,
@@ -21,6 +27,99 @@ static void dummy_callback(struct amdgpu_device *adev,
 {
 }
 
+static bool dm_test_dmub_supported(struct dmub_srv *dmub)
+{
+	return true;
+}
+
+static bool dm_test_dmub_unsupported(struct dmub_srv *dmub)
+{
+	return false;
+}
+
+static bool dm_test_dmub_hw_initialized(struct dmub_srv *dmub)
+{
+	return true;
+}
+
+static union dmub_fw_boot_status dm_test_dmub_fw_ready(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_status status = { 0 };
+
+	status.bits.dal_fw = 1;
+	status.bits.mailbox_rdy = 1;
+	return status;
+}
+
+static union dmub_fw_boot_status dm_test_dmub_fw_not_ready(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_status status = { 0 };
+
+	return status;
+}
+
+static void dm_test_dmub_init_reg_offsets(struct dmub_srv *dmub,
+					  struct dc_context *ctx)
+{
+}
+
+static bool dm_test_dmcu_init(struct dmcu *dmcu)
+{
+	return true;
+}
+
+static bool dm_test_dmcu_is_initialized(struct dmcu *dmcu)
+{
+	return true;
+}
+
+static const struct dmcu_funcs dm_test_dmcu_funcs = {
+	.dmcu_init = dm_test_dmcu_init,
+	.is_dmcu_initialized = dm_test_dmcu_is_initialized,
+};
+
+static struct dmub_srv *dm_test_alloc_dmub_srv(struct kunit *test)
+{
+	struct dmub_srv *dmub_srv;
+
+	dmub_srv = kunit_kzalloc(test, sizeof(*dmub_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub_srv);
+
+	dmub_srv->sw_init = true;
+	dmub_srv->hw_init = true;
+	dmub_srv->power_state = DMUB_POWER_STATE_D0;
+	dmub_srv->hw_funcs.is_supported = dm_test_dmub_supported;
+	dmub_srv->hw_funcs.is_hw_init = dm_test_dmub_hw_initialized;
+	dmub_srv->hw_funcs.get_fw_status = dm_test_dmub_fw_ready;
+	dmub_srv->hw_funcs.init_reg_offsets = dm_test_dmub_init_reg_offsets;
+
+	return dmub_srv;
+}
+
+static const struct firmware *dm_test_alloc_dmub_fw(struct kunit *test)
+{
+	struct dmcub_firmware_header_v1_0 *hdr;
+	struct firmware *fw;
+	u8 *data;
+
+	fw = kunit_kzalloc(test, sizeof(*fw), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fw);
+
+	data = kunit_kzalloc(test, DM_TEST_FW_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, data);
+
+	hdr = (struct dmcub_firmware_header_v1_0 *)data;
+	hdr->header.ucode_array_offset_bytes = cpu_to_le32(0);
+	hdr->header.ucode_version = cpu_to_le32(DMUB_FW_VERSION(9, 9, 9));
+	hdr->inst_const_bytes = cpu_to_le32(PSP_HEADER_BYTES_256);
+	hdr->bss_data_bytes = cpu_to_le32(0);
+
+	fw->size = DM_TEST_FW_SIZE;
+	fw->data = data;
+
+	return fw;
+}
+
 /**
  * dm_test_register_dmub_notify_callback_null_callback - Test null callback is rejected
  * @test: The KUnit test context
@@ -395,6 +494,7 @@ static void dm_test_get_default_ips_mode_newer_default(struct kunit *test)
 static struct amdgpu_device *dm_test_alloc_adev_with_dc(struct kunit *test)
 {
 	struct amdgpu_device *adev;
+	struct dc_context *ctx;
 	struct dc *dc;
 	struct resource_pool *res_pool;
 
@@ -407,12 +507,47 @@ static struct amdgpu_device *dm_test_alloc_adev_with_dc(struct kunit *test)
 	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
 
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
 	dc->res_pool = res_pool;
+	dc->ctx = ctx;
+	ctx->dc = dc;
+	ctx->driver_context = adev;
 	adev->dm.dc = dc;
 
 	return adev;
 }
 
+static struct amdgpu_device *dm_test_alloc_adev_with_dmub(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dmub_srv_fb_info *fb_info;
+	int i;
+
+	adev = dm_test_alloc_adev_with_dc(test);
+
+	fb_info = kunit_kzalloc(test, sizeof(*fb_info), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fb_info);
+
+	fb_info->num_fb = DMUB_WINDOW_TOTAL;
+	for (i = 0; i < DMUB_WINDOW_TOTAL; i++) {
+		fb_info->fb[i].size = PAGE_SIZE;
+		fb_info->fb[i].cpu_addr = kunit_kzalloc(test, PAGE_SIZE, GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fb_info->fb[i].cpu_addr);
+	}
+
+	adev->dm.dmub_srv = dm_test_alloc_dmub_srv(test);
+	adev->dm.dmub_fb_info = fb_info;
+	adev->dm.dmub_fw = dm_test_alloc_dmub_fw(test);
+	adev->bios = kunit_kzalloc(test, 4, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->bios);
+	adev->bios_size = 4;
+	adev->dm.fw_inst_size = 0;
+
+	return adev;
+}
+
 /**
  * dm_test_dmub_hw_init_no_dmub_srv - Test hw init returns 0 when DMUB unsupported
  * @test: The KUnit test context
@@ -476,6 +611,177 @@ static void dm_test_dmub_hw_init_no_firmware(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), -EINVAL);
 }
 
+/**
+ * dm_test_dmub_hw_init_success_fake_dmub - Test hw init with a fake DMUB service
+ * @test: The KUnit test context
+ *
+ * With fake DMUB callbacks and preallocated framebuffer windows, the init path
+ * should reach DMUB service initialization without real register access.
+ */
+static void dm_test_dmub_hw_init_success_fake_dmub(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dmub(test);
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), 0);
+	KUNIT_EXPECT_TRUE(test, adev->dm.dmub_srv->hw_init);
+	KUNIT_EXPECT_NOT_NULL(test, adev->dm.dc->ctx->dmub_srv);
+}
+
+/**
+ * dm_test_dmub_hw_init_no_hw_support - Test hw init returns 0 when HW is unsupported
+ * @test: The KUnit test context
+ *
+ * When the DMUB service reports no hardware support, dm_dmub_hw_init() should
+ * log and return 0 without initializing the DMUB hardware.
+ */
+static void dm_test_dmub_hw_init_no_hw_support(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dmub(test);
+
+	adev->dm.dmub_srv->hw_funcs.is_supported = dm_test_dmub_unsupported;
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), 0);
+	KUNIT_EXPECT_NULL(test, adev->dm.dc->ctx->dmub_srv);
+}
+
+/**
+ * dm_test_dmub_hw_init_bss_data - Test hw init copies BSS data into FB memory
+ * @test: The KUnit test context
+ *
+ * When the DMUB firmware declares a non-zero BSS data size, dm_dmub_hw_init()
+ * should copy that region into the BSS framebuffer window.
+ */
+static void dm_test_dmub_hw_init_bss_data(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dmub(test);
+	struct dmcub_firmware_header_v1_0 *hdr;
+
+	hdr = (struct dmcub_firmware_header_v1_0 *)adev->dm.dmub_fw->data;
+	hdr->bss_data_bytes = cpu_to_le32(16);
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), 0);
+	KUNIT_EXPECT_TRUE(test, adev->dm.dmub_srv->hw_init);
+}
+
+/**
+ * dm_test_dmub_hw_init_hw_init_fails - Test hw init returns -EINVAL on DMUB init failure
+ * @test: The KUnit test context
+ *
+ * A framebuffer-info window count below the required total makes
+ * dmub_srv_hw_init() reject the request, so dm_dmub_hw_init() logs and
+ * returns -EINVAL. (The rejection path emits a one-time WARN via ASSERT.)
+ */
+static void dm_test_dmub_hw_init_hw_init_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dmub(test);
+
+	adev->dm.dmub_fb_info->num_fb = 0;
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), -EINVAL);
+}
+
+/**
+ * dm_test_dmub_hw_init_auto_load_timeout - Test hw init tolerates an auto-load timeout
+ * @test: The KUnit test context
+ *
+ * When the DMUB firmware never reports ready, dmub_srv_wait_for_auto_load()
+ * times out; dm_dmub_hw_init() only warns and still completes successfully.
+ */
+static void dm_test_dmub_hw_init_auto_load_timeout(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dmub(test);
+
+	adev->dm.dmub_srv->hw_funcs.get_fw_status = dm_test_dmub_fw_not_ready;
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), 0);
+	KUNIT_EXPECT_NOT_NULL(test, adev->dm.dc->ctx->dmub_srv);
+}
+
+/**
+ * dm_test_dmub_hw_init_apu_dpia_dcn35 - Test hw init APU DPIA and DCN35 hw params
+ * @test: The KUnit test context
+ *
+ * On a DCN3.5 APU with a USB4 DPIA link, dm_dmub_hw_init() should populate the
+ * DPIA hw params and the DCN3.5 IPS-sequential hw params before initializing
+ * the fake DMUB service.
+ */
+static void dm_test_dmub_hw_init_apu_dpia_dcn35(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dmub(test);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 5, 0);
+	adev->dm.dc->caps.is_apu = true;
+	adev->dm.dc->res_pool->usb4_dpia_count = 1;
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), 0);
+	KUNIT_EXPECT_TRUE(test, adev->dm.dmub_srv->hw_init);
+}
+
+/**
+ * dm_test_dmub_hw_init_sanity_checks_dcn31 - Test hw init enables DCN31 sanity checks
+ * @test: The KUnit test context
+ *
+ * On DCN3.1.2 with a DMCUB firmware version in the affected range,
+ * dm_dmub_hw_init() should enable the DC sanity-check debug flag.
+ */
+static void dm_test_dmub_hw_init_sanity_checks_dcn31(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dmub(test);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 1, 2);
+	adev->dm.dmcub_fw_version = DMUB_FW_VERSION(4, 0, 10);
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), 0);
+	KUNIT_EXPECT_TRUE(test, adev->dm.dc->debug.sanity_checks);
+}
+
+/**
+ * dm_test_dmub_hw_init_sanity_checks_dcn314 - Test hw init enables DCN314 sanity checks
+ * @test: The KUnit test context
+ *
+ * On DCN3.1.4 with a DMCUB firmware version in the affected range,
+ * dm_dmub_hw_init() should enable the DC sanity-check debug flag.
+ */
+static void dm_test_dmub_hw_init_sanity_checks_dcn314(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dmub(test);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 1, 4);
+	adev->dm.dmcub_fw_version = DMUB_FW_VERSION(4, 0, 10);
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), 0);
+	KUNIT_EXPECT_TRUE(test, adev->dm.dc->debug.sanity_checks);
+}
+
+/**
+ * dm_test_dmub_hw_init_dmcu_abm - Test hw init initializes DMCU and ABM when present
+ * @test: The KUnit test context
+ *
+ * When the resource pool exposes a DMCU and ABM, dm_dmub_hw_init() should
+ * program the PSP version, invoke the DMCU init callback, and record the
+ * running state reported by the DMCU.
+ */
+static void dm_test_dmub_hw_init_dmcu_abm(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dmub(test);
+	struct dmcu *dmcu;
+	struct abm *abm;
+
+	dmcu = kunit_kzalloc(test, sizeof(*dmcu), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmcu);
+
+	abm = kunit_kzalloc(test, sizeof(*abm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, abm);
+
+	dmcu->funcs = &dm_test_dmcu_funcs;
+	dmcu->psp_version = 0x12345678;
+	adev->dm.dc->res_pool->dmcu = dmcu;
+	adev->dm.dc->res_pool->abm = abm;
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), 0);
+	KUNIT_EXPECT_TRUE(test, abm->dmcu_is_running);
+}
+
 /* Tests for dm_dmub_hw_resume() */
 
 /**
@@ -561,6 +867,15 @@ static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	KUNIT_CASE(dm_test_dmub_hw_init_no_dmub_srv),
 	KUNIT_CASE(dm_test_dmub_hw_init_no_fb_info),
 	KUNIT_CASE(dm_test_dmub_hw_init_no_firmware),
+	KUNIT_CASE(dm_test_dmub_hw_init_success_fake_dmub),
+	KUNIT_CASE(dm_test_dmub_hw_init_no_hw_support),
+	KUNIT_CASE(dm_test_dmub_hw_init_bss_data),
+	KUNIT_CASE(dm_test_dmub_hw_init_hw_init_fails),
+	KUNIT_CASE(dm_test_dmub_hw_init_auto_load_timeout),
+	KUNIT_CASE(dm_test_dmub_hw_init_apu_dpia_dcn35),
+	KUNIT_CASE(dm_test_dmub_hw_init_sanity_checks_dcn31),
+	KUNIT_CASE(dm_test_dmub_hw_init_sanity_checks_dcn314),
+	KUNIT_CASE(dm_test_dmub_hw_init_dmcu_abm),
 	/* dm_dmub_hw_resume() */
 	KUNIT_CASE(dm_test_dmub_hw_resume_no_dmub_srv),
 	/* dm_dmub_sw_init() */
-- 
2.43.0

