Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51534CD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBDAE10E885;
	Wed, 10 Jun 2026 09:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OTH/rzQh";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5410210E885
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:51:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XV7R6rIVhwXWzPt4Sk9QoX5C7mPB9AUt7lX+5gwByGzCigafjXQXqHl04yUds85YO1YGNw9J+GrPyOEdwVS8/VTs7wJ6VBuPeaAJEth89bFfErvS+u59LYiEOkP22zuL18LFpeKpeCV2aPlbIinfVgwq9DTA081/AraPeZ0c46FdzWRh8WMM2NnElIMBigBdoDCa65uFCBBfs6L7t5HP0r66g9RAzE9GTrzfgZZfjGa+8oV80cQ547oHFR4IY3A9Fq5R70u9U5nebHTKZYQCuWMD5dnP+CMKSLzUr9xNMB3Nr8Dr5yFr/kaWt9ZHxL8XwXAX1U/vrLznPqDZqHEqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eJBRQNYdgwHqUdA2GAgKZ5eX1Pa4OVSRitvZY85F2U=;
 b=OFNlCmG6OrgExBSmR65WZyFsxxaIlVGb0SOrvyjFWXLGwNF9MzkIwdpFyg0urA4L5E3BAUxuL4Ag/tSDMaJGWOrc2A5xX0huhQY8Wxcxk49yYkWZBsgVhESBW4Lo/TFrmAArtCQNYm6RpZYbHjP4Mq3tv/xZUDK0WIJibr2JBLIp8FkZvF7QPehhJ+nyqhgbmGWT3aXxf/eHm/rVyKvyOTk1WlY6oiaTBzjmZQYVcS7eaQI0rmQo1+uPLAvmDeI2UL1ncKg+noWX/MM8TY1Rr1PyBrcDQmXFICkgNf2dG7Y4Ugat3Sxrb38AqbNvn4Fk9clkSf71mhbAoKOnUeolcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eJBRQNYdgwHqUdA2GAgKZ5eX1Pa4OVSRitvZY85F2U=;
 b=OTH/rzQhOLMGNyik/Sm6W6+OPK2QfJTTEGN5qDJrlA4e4CR0SRqn5ddvG8kN75QxzFJSoAdeyEMP458zT1IRH9kVR555XfvTJ8HJg3idvOy0EJx+bWv1BOm5D8S+s4K8G6osWqUz9JguEAbH7oejpbGM7yy/7NPCval2AbZGziw=
Received: from BL1PR13CA0105.namprd13.prod.outlook.com (2603:10b6:208:2b9::20)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 09:51:04 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::41) by BL1PR13CA0105.outlook.office365.com
 (2603:10b6:208:2b9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 09:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:51:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:51:03 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:50:55 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 20/32] drm/amd/display: Add KUnit tests for amdgpu_dm_dmub
Date: Wed, 10 Jun 2026 17:45:04 +0800
Message-ID: <20260610094639.1965367-21-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 312d75ca-51d4-4a2d-4563-08dec6d5c95a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +9wUcLuFCSb8wUcvzFdY3iLsCA6jo9VpR06W4j7/nSQ5O2ec4QQHhJ5iK5a7CbYZUxGSvMEHL3EqQdtFgWyRgpBUqtOVPHy1P36qzbaS7O/eA7kO9A9ie/urJH33Uj3xTZxP9k4qffjJpPpY+6KdkQOz27E+nT9VcMQofBjGhYm2x261kTIyiiesm8Tqg+KuaFucyWIkXVe7U+W+8AzGdHTuP7w/Cg3S3sQt+ujiwzHZazz2VbT06I12pJM0r7+57XR33cM8P96TqHDRjW9td1IerkO7seZ/afnyy5kOsLAJUcBc28rtCaVyG18Tm2aEohPpUN2xvzJID3M46+qIRUBrL0d/HkeX2do8ctK7hA5VW/PvlOUVORfFNtkatJnes7RcJzXKd42n7F1YsrPOKyoEcfwC18dLzqmu47JnbrAENT1izEaTYSDQ6FEj+C218N6K4KmjGpjTOkoU7g+dEzKz1L95OGRIJJpcosRIn29YpRgnY2G/t7+LhSc0PBVliJO98fcNuVEUZzlltA/uU8d6DP4wcj0v5dt8KTVuo2zxnRLaj9NUmNTxtdq8SuNJahwmIWOplQvNcUUVuEk1H9QwK13/C8bk9+jFavxHefVh1TkcO0TgIuFIML3Q+lJaF3MzcyA+fStQ7111sVq7vNvN4rKm4W1+SrBfyquUQ+tJpnAMs1BkCEAhVn6CjtXzFBfkBGwhsqLeDEu5iE7JELRc7aLWOrL6aJ+pO7+4fnw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sHdcTHSPz0C45BbPlK2+KTx2NEEYIHMHTZMeZ2cK+NFW26sSgqq6nh1vhlDf0dIVw9PxaKD3wIJnSRAdKAAFe6o4qUszr23Q9Up8UOXgBlORZMo3TsRTkLagxhZUsPBnb/vEt/5HldqtcA9ga108fU9wfQ0JJc/JvB/0a06bN5CY1Hhdhywf932b6GsajacpEH/4odEdY/U1XSTCtQUHftnK/gyfiq1FqJCBF2PyQrdrMN7dHBcD5dgAZh9DOG9+FG/QJBGZpKEvs3HR8bUAfQvfyLTRsNEEWWg6VfmIzup2vVyIJftKcthrXcsX75p37gexOYd9PWbQPgBCwoAIYY71/1fTQupzzDClUdI0fcTwo25xp4wF37QZHR6IalLynWIj/3S8xlYCDzXpDkvOzQ8sbWxbl7HrtBB5gK1BYbb3SEEu7Wt7ZUKyKGKhPgTd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:51:04.1216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312d75ca-51d4-4a2d-4563-08dec6d5c95a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972
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

Add KUnit tests for amdgpu_dm_dmub.c covering the following
functions:

- dm_register_dmub_notify_callback(): NULL callback rejection,
  out-of-range type, valid registration with offload flag
- dm_dmub_aux_setconfig_callback(): copy and complete on AUX
  reply, non-AUX skip, NULL dm_notify, SET_CONFIG reply
- dm_dmub_aux_fused_io_callback(): copy reply and complete,
  max ddc_line boundary
- dm_get_default_ips_mode(): IPS mode per DCN version (3.5,
  3.5.1, 3.6, 4.2), disabled for older ASICs, default enabled
  for unhandled newer ASICs
- dm_dmub_hw_init(): early returns for no dmub_srv, no fb_info,
  no firmware
- dm_dmub_hw_resume(): no-op when dmub_srv is NULL
- dm_dmub_sw_init(): returns 0 for unsupported ASIC
- dm_init_microcode(): returns 0 for unsupported ASIC

Assisted-by: Copilot:Claude-Opus-4.6

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   9 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 600 ++++++++++++++++++
 3 files changed, 610 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 54b3b884968b..579a435dcefc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -38,6 +38,7 @@
 #include "amdgpu_ucode.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_dmub.h"
+#include "amdgpu_dm_kunit_helpers.h"
 #include <linux/component.h>
 #include <linux/firmware.h>
 
@@ -80,6 +81,7 @@ void dm_dmub_aux_setconfig_callback(struct amdgpu_device *adev,
 	if (notify->type == DMUB_NOTIFICATION_AUX_REPLY)
 		complete(&adev->dm.dmub_aux_transfer_done);
 }
+EXPORT_IF_KUNIT(dm_dmub_aux_setconfig_callback);
 
 void dm_dmub_aux_fused_io_callback(struct amdgpu_device *adev,
 				   struct dmub_notification *notify)
@@ -103,6 +105,7 @@ void dm_dmub_aux_fused_io_callback(struct amdgpu_device *adev,
 	memcpy(sync->reply_data, req, sizeof(*req));
 	complete(&sync->replied);
 }
+EXPORT_IF_KUNIT(dm_dmub_aux_fused_io_callback);
 
 /**
  * dm_register_dmub_notify_callback - Sets callback for DMUB notify
@@ -129,6 +132,7 @@ bool dm_register_dmub_notify_callback(struct amdgpu_device *adev,
 
 	return true;
 }
+EXPORT_IF_KUNIT(dm_register_dmub_notify_callback);
 
 int dm_dmub_hw_init(struct amdgpu_device *adev)
 {
@@ -318,6 +322,7 @@ int dm_dmub_hw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(dm_dmub_hw_init);
 
 void dm_dmub_hw_resume(struct amdgpu_device *adev)
 {
@@ -347,6 +352,7 @@ void dm_dmub_hw_resume(struct amdgpu_device *adev)
 			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
 	}
 }
+EXPORT_IF_KUNIT(dm_dmub_hw_resume);
 
 static enum dmub_status
 dm_dmub_send_vbios_gpint_command(struct amdgpu_device *adev,
@@ -460,6 +466,7 @@ enum dmub_ips_disable_type dm_get_default_ips_mode(
 
 	return ret;
 }
+EXPORT_IF_KUNIT(dm_get_default_ips_mode);
 
 static uint32_t amdgpu_dm_dmub_reg_read(void *ctx, uint32_t address)
 {
@@ -678,6 +685,7 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(dm_dmub_sw_init);
 
 int dm_init_microcode(struct amdgpu_device *adev)
 {
@@ -750,6 +758,7 @@ int dm_init_microcode(struct amdgpu_device *adev)
 				 "%s", fw_name_dmub);
 	return r;
 }
+EXPORT_IF_KUNIT(dm_init_microcode);
 
 int amdgpu_dm_process_dmub_aux_transfer_sync(
 		struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index 5bb43b3bc439..4bd8d1fa0fee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_audio_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_color_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_colorop_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_backlight_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_dmub_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_psr_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_replay_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_ism_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
new file mode 100644
index 000000000000..b82dd301a896
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -0,0 +1,600 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_dmub.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+
+#include "dc.h"
+#include "dc/inc/core_types.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
+#include "dmub/dmub_srv.h"
+#include "amdgpu_dm_dmub.h"
+
+/* Tests for dm_register_dmub_notify_callback() */
+
+static void dummy_callback(struct amdgpu_device *adev,
+			   struct dmub_notification *notify)
+{
+}
+
+/**
+ * dm_test_register_dmub_notify_callback_null_callback - Test null callback is rejected
+ * @test: The KUnit test context
+ */
+static void dm_test_register_dmub_notify_callback_null_callback(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	KUNIT_EXPECT_FALSE(test, dm_register_dmub_notify_callback(adev,
+		DMUB_NOTIFICATION_AUX_REPLY, NULL, false));
+}
+
+/**
+ * dm_test_register_dmub_notify_callback_type_out_of_range - Test out-of-range type is rejected
+ * @test: The KUnit test context
+ */
+static void dm_test_register_dmub_notify_callback_type_out_of_range(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	KUNIT_EXPECT_FALSE(test, dm_register_dmub_notify_callback(adev,
+		AMDGPU_DMUB_NOTIFICATION_MAX, dummy_callback, false));
+}
+
+/**
+ * dm_test_register_dmub_notify_callback_valid - Test Register dmub notify callback valid
+ * @test: The KUnit test context
+ */
+static void dm_test_register_dmub_notify_callback_valid(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	KUNIT_EXPECT_TRUE(test, dm_register_dmub_notify_callback(adev,
+		DMUB_NOTIFICATION_AUX_REPLY, dummy_callback, true));
+
+	KUNIT_EXPECT_TRUE(test,
+		adev->dm.dmub_callback[DMUB_NOTIFICATION_AUX_REPLY] == dummy_callback);
+	KUNIT_EXPECT_TRUE(test,
+		adev->dm.dmub_thread_offload[DMUB_NOTIFICATION_AUX_REPLY]);
+}
+
+/**
+ * dm_test_register_dmub_notify_callback_offload_false - Test registration with offload disabled
+ * @test: The KUnit test context
+ */
+static void dm_test_register_dmub_notify_callback_offload_false(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	KUNIT_EXPECT_TRUE(test, dm_register_dmub_notify_callback(adev,
+		DMUB_NOTIFICATION_HPD, dummy_callback, false));
+
+	KUNIT_EXPECT_TRUE(test,
+		adev->dm.dmub_callback[DMUB_NOTIFICATION_HPD] == dummy_callback);
+	KUNIT_EXPECT_FALSE(test,
+		adev->dm.dmub_thread_offload[DMUB_NOTIFICATION_HPD]);
+}
+
+/* Tests for dm_dmub_aux_setconfig_callback() */
+
+/**
+ * dm_test_dmub_aux_setconfig_callback_copies_and_completes - Test copy and complete on AUX reply
+ * @test: The KUnit test context
+ */
+static void dm_test_dmub_aux_setconfig_callback_copies_and_completes(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dmub_notification *dm_notify;
+	struct dmub_notification notify = {};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	dm_notify = kunit_kzalloc(test, sizeof(*dm_notify), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_notify);
+
+	init_completion(&adev->dm.dmub_aux_transfer_done);
+	adev->dm.dmub_notify = dm_notify;
+
+	notify.type = DMUB_NOTIFICATION_AUX_REPLY;
+	notify.result = AUX_RET_SUCCESS;
+	notify.aux_reply.command = 0xA5;
+	notify.aux_reply.length = 3;
+	notify.aux_reply.data[0] = 0x11;
+	notify.aux_reply.data[1] = 0x22;
+	notify.aux_reply.data[2] = 0x33;
+
+	dm_dmub_aux_setconfig_callback(adev, &notify);
+
+	KUNIT_EXPECT_EQ(test, dm_notify->type, notify.type);
+	KUNIT_EXPECT_EQ(test, dm_notify->result, notify.result);
+	KUNIT_EXPECT_EQ(test, dm_notify->aux_reply.command, notify.aux_reply.command);
+	KUNIT_EXPECT_EQ(test, dm_notify->aux_reply.length, notify.aux_reply.length);
+	KUNIT_EXPECT_EQ(test, dm_notify->aux_reply.data[0], notify.aux_reply.data[0]);
+	KUNIT_EXPECT_EQ(test, dm_notify->aux_reply.data[1], notify.aux_reply.data[1]);
+	KUNIT_EXPECT_EQ(test, dm_notify->aux_reply.data[2], notify.aux_reply.data[2]);
+	KUNIT_EXPECT_TRUE(test, completion_done(&adev->dm.dmub_aux_transfer_done));
+}
+
+/**
+ * dm_test_dmub_aux_setconfig_callback_non_aux_no_complete - Test non-AUX type skips completion
+ * @test: The KUnit test context
+ */
+static void dm_test_dmub_aux_setconfig_callback_non_aux_no_complete(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dmub_notification *dm_notify;
+	struct dmub_notification notify = {};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	dm_notify = kunit_kzalloc(test, sizeof(*dm_notify), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_notify);
+
+	init_completion(&adev->dm.dmub_aux_transfer_done);
+	adev->dm.dmub_notify = dm_notify;
+
+	notify.type = DMUB_NOTIFICATION_HPD;
+	notify.result = AUX_RET_ERROR_TIMEOUT;
+
+	dm_dmub_aux_setconfig_callback(adev, &notify);
+
+	KUNIT_EXPECT_EQ(test, dm_notify->type, notify.type);
+	KUNIT_EXPECT_FALSE(test, completion_done(&adev->dm.dmub_aux_transfer_done));
+}
+
+/**
+ * dm_test_dmub_aux_setconfig_callback_aux_with_null_dm_notify - Test AUX with NULL dm_notify
+ * @test: The KUnit test context
+ */
+static void dm_test_dmub_aux_setconfig_callback_aux_with_null_dm_notify(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dmub_notification notify = {};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	init_completion(&adev->dm.dmub_aux_transfer_done);
+	adev->dm.dmub_notify = NULL;
+
+	notify.type = DMUB_NOTIFICATION_AUX_REPLY;
+
+	dm_dmub_aux_setconfig_callback(adev, &notify);
+
+	KUNIT_EXPECT_TRUE(test, completion_done(&adev->dm.dmub_aux_transfer_done));
+}
+
+/**
+ * dm_test_dmub_aux_setconfig_callback_set_config_reply - Test SET_CONFIG reply copies status
+ * @test: The KUnit test context
+ */
+static void dm_test_dmub_aux_setconfig_callback_set_config_reply(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dmub_notification *dm_notify;
+	struct dmub_notification notify = {};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	dm_notify = kunit_kzalloc(test, sizeof(*dm_notify), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm_notify);
+
+	init_completion(&adev->dm.dmub_aux_transfer_done);
+	adev->dm.dmub_notify = dm_notify;
+
+	notify.type = DMUB_NOTIFICATION_SET_CONFIG_REPLY;
+	notify.sc_status = SET_CONFIG_RX_TIMEOUT;
+
+	dm_dmub_aux_setconfig_callback(adev, &notify);
+
+	KUNIT_EXPECT_EQ(test, dm_notify->type, notify.type);
+	KUNIT_EXPECT_EQ(test, dm_notify->sc_status, notify.sc_status);
+	KUNIT_EXPECT_FALSE(test, completion_done(&adev->dm.dmub_aux_transfer_done));
+}
+
+/* Tests for dm_dmub_aux_fused_io_callback() */
+
+/**
+ * dm_test_dmub_aux_fused_io_callback_copies_reply_and_completes - Test copy and complete
+ * @test: The KUnit test context
+ */
+static void dm_test_dmub_aux_fused_io_callback_copies_reply_and_completes(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dmub_notification notify = {};
+	struct dmub_cmd_fused_request *reply;
+	u32 reply_ddc_line;
+	u32 notify_ddc_line;
+	u32 reply_address;
+	u32 notify_address;
+	u32 reply_length;
+	u32 notify_length;
+	uint8_t ddc_line = 2;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	init_completion(&adev->dm.fused_io[ddc_line].replied);
+
+	notify.fused_request.identifier = 0x34;
+	notify.fused_request.status = FUSED_REQUEST_STATUS_SUCCESS;
+	notify.fused_request.u.aux.ddc_line = ddc_line;
+	notify.fused_request.u.aux.address = 0x50;
+	notify.fused_request.u.aux.length = 4;
+
+	dm_dmub_aux_fused_io_callback(adev, &notify);
+
+	KUNIT_EXPECT_TRUE(test, completion_done(&adev->dm.fused_io[ddc_line].replied));
+
+	reply = (struct dmub_cmd_fused_request *)adev->dm.fused_io[ddc_line].reply_data;
+	reply_ddc_line = reply->u.aux.ddc_line;
+	notify_ddc_line = notify.fused_request.u.aux.ddc_line;
+	reply_address = reply->u.aux.address;
+	notify_address = notify.fused_request.u.aux.address;
+	reply_length = reply->u.aux.length;
+	notify_length = notify.fused_request.u.aux.length;
+
+	KUNIT_EXPECT_EQ(test, reply->identifier, notify.fused_request.identifier);
+	KUNIT_EXPECT_EQ(test, reply->status, notify.fused_request.status);
+	KUNIT_EXPECT_EQ(test, reply_ddc_line, notify_ddc_line);
+	KUNIT_EXPECT_EQ(test, reply_address, notify_address);
+	KUNIT_EXPECT_EQ(test, reply_length, notify_length);
+}
+
+/**
+ * dm_test_dmub_aux_fused_io_callback_max_ddc_line - Test Dmub aux fused io callback max ddc line
+ * @test: The KUnit test context
+ */
+static void dm_test_dmub_aux_fused_io_callback_max_ddc_line(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dmub_notification notify = {};
+	struct dmub_cmd_fused_request *reply;
+	u32 reply_ddc_line;
+	u32 notify_ddc_line;
+	uint8_t ddc_line;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	ddc_line = ARRAY_SIZE(adev->dm.fused_io) - 1;
+	init_completion(&adev->dm.fused_io[ddc_line].replied);
+
+	notify.fused_request.identifier = 0x56;
+	notify.fused_request.status = FUSED_REQUEST_STATUS_SUCCESS;
+	notify.fused_request.u.aux.ddc_line = ddc_line;
+	notify.fused_request.u.aux.address = 0x50;
+	notify.fused_request.u.aux.length = 1;
+
+	dm_dmub_aux_fused_io_callback(adev, &notify);
+
+	KUNIT_EXPECT_TRUE(test, completion_done(&adev->dm.fused_io[ddc_line].replied));
+
+	reply = (struct dmub_cmd_fused_request *)adev->dm.fused_io[ddc_line].reply_data;
+	reply_ddc_line = reply->u.aux.ddc_line;
+	notify_ddc_line = notify.fused_request.u.aux.ddc_line;
+
+	KUNIT_EXPECT_EQ(test, reply->identifier, notify.fused_request.identifier);
+	KUNIT_EXPECT_EQ(test, reply_ddc_line, notify_ddc_line);
+}
+
+/* Tests for dm_get_default_ips_mode() */
+
+/**
+ * dm_test_get_default_ips_mode_dcn35 - Test Get default ips mode dcn35
+ * @test: The KUnit test context
+ */
+static void dm_test_get_default_ips_mode_dcn35(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 5, 0);
+
+	KUNIT_EXPECT_EQ(test, dm_get_default_ips_mode(adev),
+			DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF);
+}
+
+/**
+ * dm_test_get_default_ips_mode_dcn351 - Test Get default ips mode dcn351
+ * @test: The KUnit test context
+ */
+static void dm_test_get_default_ips_mode_dcn351(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 5, 1);
+
+	KUNIT_EXPECT_EQ(test, dm_get_default_ips_mode(adev),
+			DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF);
+}
+
+/**
+ * dm_test_get_default_ips_mode_dcn36 - Test Get default ips mode dcn36
+ * @test: The KUnit test context
+ */
+static void dm_test_get_default_ips_mode_dcn36(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 6, 0);
+
+	KUNIT_EXPECT_EQ(test, dm_get_default_ips_mode(adev),
+			DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF);
+}
+
+/**
+ * dm_test_get_default_ips_mode_dcn42 - Test Get default ips mode dcn42
+ * @test: The KUnit test context
+ */
+static void dm_test_get_default_ips_mode_dcn42(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 2, 0);
+
+	KUNIT_EXPECT_EQ(test, dm_get_default_ips_mode(adev),
+			DMUB_IPS_DISABLE_ALL);
+}
+
+/**
+ * dm_test_get_default_ips_mode_older_than_dcn35 - Test Get default ips mode older than dcn35
+ * @test: The KUnit test context
+ */
+static void dm_test_get_default_ips_mode_older_than_dcn35(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 2, 0);
+
+	KUNIT_EXPECT_EQ(test, dm_get_default_ips_mode(adev),
+			DMUB_IPS_DISABLE_ALL);
+}
+
+/**
+ * dm_test_get_default_ips_mode_newer_default - Test Get default ips mode newer default
+ * @test: The KUnit test context
+ */
+static void dm_test_get_default_ips_mode_newer_default(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	/* DCN 4.0.1 is >= 3.5 but has no explicit case, returns ENABLE */
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
+
+	KUNIT_EXPECT_EQ(test, dm_get_default_ips_mode(adev),
+			DMUB_IPS_ENABLE);
+}
+
+/* Tests for dm_dmub_hw_init() */
+
+/*
+ * Build an amdgpu_device with the minimal dc/res_pool pointers that
+ * dm_dmub_hw_init() and dm_dmub_hw_resume() dereference before their
+ * early-return checks.
+ */
+static struct amdgpu_device *dm_test_alloc_adev_with_dc(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct resource_pool *res_pool;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+
+	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res_pool);
+
+	dc->res_pool = res_pool;
+	adev->dm.dc = dc;
+
+	return adev;
+}
+
+/**
+ * dm_test_dmub_hw_init_no_dmub_srv - Test hw init returns 0 when DMUB unsupported
+ * @test: The KUnit test context
+ *
+ * When adev->dm.dmub_srv is NULL the ASIC does not support DMUB and
+ * dm_dmub_hw_init() should return 0 without touching the hardware.
+ */
+static void dm_test_dmub_hw_init_no_dmub_srv(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dc(test);
+
+	adev->dm.dmub_srv = NULL;
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), 0);
+}
+
+/**
+ * dm_test_dmub_hw_init_no_fb_info - Test hw init fails without framebuffer info
+ * @test: The KUnit test context
+ *
+ * With a DMUB service present but no framebuffer info, dm_dmub_hw_init()
+ * should return -EINVAL.
+ */
+static void dm_test_dmub_hw_init_no_fb_info(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dc(test);
+	struct dmub_srv *dmub_srv;
+
+	dmub_srv = kunit_kzalloc(test, sizeof(*dmub_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub_srv);
+
+	adev->dm.dmub_srv = dmub_srv;
+	adev->dm.dmub_fb_info = NULL;
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), -EINVAL);
+}
+
+/**
+ * dm_test_dmub_hw_init_no_firmware - Test hw init fails without firmware
+ * @test: The KUnit test context
+ *
+ * With a DMUB service and framebuffer info present but no firmware,
+ * dm_dmub_hw_init() should return -EINVAL.
+ */
+static void dm_test_dmub_hw_init_no_firmware(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dc(test);
+	struct dmub_srv *dmub_srv;
+	struct dmub_srv_fb_info *fb_info;
+
+	dmub_srv = kunit_kzalloc(test, sizeof(*dmub_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmub_srv);
+
+	fb_info = kunit_kzalloc(test, sizeof(*fb_info), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fb_info);
+
+	adev->dm.dmub_srv = dmub_srv;
+	adev->dm.dmub_fb_info = fb_info;
+	adev->dm.dmub_fw = NULL;
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_hw_init(adev), -EINVAL);
+}
+
+/* Tests for dm_dmub_hw_resume() */
+
+/**
+ * dm_test_dmub_hw_resume_no_dmub_srv - Test hw resume is a no-op when DMUB unsupported
+ * @test: The KUnit test context
+ *
+ * When adev->dm.dmub_srv is NULL, dm_dmub_hw_resume() should return early
+ * without dereferencing the (absent) DMUB service.
+ */
+static void dm_test_dmub_hw_resume_no_dmub_srv(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_dc(test);
+
+	adev->dm.dmub_srv = NULL;
+
+	/* Must not crash. */
+	dm_dmub_hw_resume(adev);
+}
+
+/* Tests for dm_dmub_sw_init() */
+
+/**
+ * dm_test_dmub_sw_init_unsupported_asic - Test sw init returns 0 for unsupported ASIC
+ * @test: The KUnit test context
+ *
+ * For an IP version with no DMUB support, dm_dmub_sw_init() should return 0
+ * before attempting to access the firmware.
+ */
+static void dm_test_dmub_sw_init_unsupported_asic(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(1, 0, 0);
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_sw_init(adev), 0);
+}
+
+/* Tests for dm_init_microcode() */
+
+/**
+ * dm_test_init_microcode_unsupported_asic - Test microcode init returns 0 for unsupported ASIC
+ * @test: The KUnit test context
+ *
+ * For an IP version with no DMUB support, dm_init_microcode() should return 0
+ * without requesting any firmware.
+ */
+static void dm_test_init_microcode_unsupported_asic(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(1, 0, 0);
+
+	KUNIT_EXPECT_EQ(test, dm_init_microcode(adev), 0);
+}
+
+static struct kunit_case amdgpu_dm_dmub_tests[] = {
+	/* dm_register_dmub_notify_callback() */
+	KUNIT_CASE(dm_test_register_dmub_notify_callback_null_callback),
+	KUNIT_CASE(dm_test_register_dmub_notify_callback_type_out_of_range),
+	KUNIT_CASE(dm_test_register_dmub_notify_callback_valid),
+	KUNIT_CASE(dm_test_register_dmub_notify_callback_offload_false),
+	/* dm_dmub_aux_setconfig_callback() */
+	KUNIT_CASE(dm_test_dmub_aux_setconfig_callback_copies_and_completes),
+	KUNIT_CASE(dm_test_dmub_aux_setconfig_callback_non_aux_no_complete),
+	KUNIT_CASE(dm_test_dmub_aux_setconfig_callback_aux_with_null_dm_notify),
+	KUNIT_CASE(dm_test_dmub_aux_setconfig_callback_set_config_reply),
+	/* dm_dmub_aux_fused_io_callback() */
+	KUNIT_CASE(dm_test_dmub_aux_fused_io_callback_copies_reply_and_completes),
+	KUNIT_CASE(dm_test_dmub_aux_fused_io_callback_max_ddc_line),
+	/* dm_get_default_ips_mode() */
+	KUNIT_CASE(dm_test_get_default_ips_mode_dcn35),
+	KUNIT_CASE(dm_test_get_default_ips_mode_dcn351),
+	KUNIT_CASE(dm_test_get_default_ips_mode_dcn36),
+	KUNIT_CASE(dm_test_get_default_ips_mode_dcn42),
+	KUNIT_CASE(dm_test_get_default_ips_mode_older_than_dcn35),
+	KUNIT_CASE(dm_test_get_default_ips_mode_newer_default),
+	/* dm_dmub_hw_init() */
+	KUNIT_CASE(dm_test_dmub_hw_init_no_dmub_srv),
+	KUNIT_CASE(dm_test_dmub_hw_init_no_fb_info),
+	KUNIT_CASE(dm_test_dmub_hw_init_no_firmware),
+	/* dm_dmub_hw_resume() */
+	KUNIT_CASE(dm_test_dmub_hw_resume_no_dmub_srv),
+	/* dm_dmub_sw_init() */
+	KUNIT_CASE(dm_test_dmub_sw_init_unsupported_asic),
+	/* dm_init_microcode() */
+	KUNIT_CASE(dm_test_init_microcode_unsupported_asic),
+	{}
+};
+
+static struct kunit_suite amdgpu_dm_dmub_test_suite = {
+	.name = "amdgpu_dm_dmub",
+	.test_cases = amdgpu_dm_dmub_tests,
+};
+
+kunit_test_suite(amdgpu_dm_dmub_test_suite);
+
+MODULE_AUTHOR("AMD");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_dmub");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.43.0

