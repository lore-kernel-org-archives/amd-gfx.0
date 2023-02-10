Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16ABCC636CD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 05:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29C9010E065;
	Fri, 10 Feb 2023 05:14:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C7210E065
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 05:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfkHI8pvfEZJtFlkwRLTCaXKED4DI/EIsc6A+8AqlLBsr5o4Q1ZyfiafstmKHJPaWsC6CdgAHFvkFXE9mWgk4jbBfwpl38iroe2jcuQQmlqq0/eVV4PpHQOOZfMNaWj2rvlVt1gZeEsGwKhvoXd562UbcnXgWi3Va9fukZvj9J+vCFHCKVhhbPSLsmRKGJZVIKwWIojw8RA9KxZiqqctYtWiFahe7cerk5odtnHB5Vb2nEkfB1BRftBaVvqnkYfKD3qgSHF/8n9PZ6YaUAY6OeAG1ijrAoItKVVg93lWMyrUMGAz+9KX2i69opZOOtyOiqvPHk+eavhE45Z97A6aaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OA74SL6l0jQ794+UcxDQ5paakXofvus8Ty40tCTkWA=;
 b=fBZ9nbbCvN32INB6wCIspDOM5ylIqRLSD/G3A4MBNk3uiCf+sowpL1cFkDTqv0im2RwZ/YrtyJBjr5u/PQjjN74v6CNyxFWG7GH/3/MvzBCrGc33VCSVuoB5YotnAxZgvBIwd5WaVynY3dr3Gj0/ejoGcXiJj/B1ixO/ZF2i7cmRALMWNFS+7sa4nHBzUwlIkr3HxM8+ijE+E7UKSQmECSkaCUBx6QkP3OZn2UbJ2wOLmvPc1bp0iJm3grUdwGajuB33HHGt8HVV0KE1T7Hqtie3Uvy+pKGg3sMNWMSFeTDrUiC8Oap4V5W4QDRyAsI4s6O2kOYGUD6zqlUZ4Ivefg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OA74SL6l0jQ794+UcxDQ5paakXofvus8Ty40tCTkWA=;
 b=ewlG69n/roFKfKNSN+7P0HcOz/fgGjV0OOVIlXhUvpKWHExiSY9tx6ywwEe2eifas6hwCpei9b6Nr+guf/FxUyP6Mux7wch5u4qRAr2tc6tVxHDSVlI+c0N/+5JcvSNqf5lTBZs5GlKtt7qMVO+Rq+ttaj6DDpOwt7p9YfGGC4k=
Received: from DS7PR03CA0348.namprd03.prod.outlook.com (2603:10b6:8:55::8) by
 DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17; Fri, 10 Feb 2023 05:14:00 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::b5) by DS7PR03CA0348.outlook.office365.com
 (2603:10b6:8:55::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Fri, 10 Feb 2023 05:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.19 via Frontend Transport; Fri, 10 Feb 2023 05:14:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 23:13:59 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 23:13:59 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Thu, 9 Feb 2023 23:13:58 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: implement mode2 reset on smu_v13_0_10
Date: Fri, 10 Feb 2023 13:13:50 +0800
Message-ID: <20230210051350.87747-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c9b82b-2c08-482f-2922-08db0b259e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9M80nq438E8UXvrrTKgs9I5oLj+xrdRA0/bDH8o1pObNSk8xNDZU/oT5qRQgrh/eiyINwwKSgUOY99j6fWRnzWRQgDs2Bz+dwfaa2tBiPyVEB4ZOi03fgqHGMB8HVfsVJOrrvkGNw0XxE6YFMO9p2KU4oq5ii1RPEsU6j6zJXn4+54KO/ReYE2ps702ijVUaXH2asM89P25y9HOyFyVvxHWEY5E6og6+LtmRl4S1z4AG6ZMQSB8s/Yy9OfGnfZtk/Uvah0AIspVJGzN8uk4BTyjKF4Kc/RItzs7YCXepNZsvEGfhK6hH2hRDRmhe1SMDb3DLxoybQVf17Ubc9LOxKAfS6qPtTWk/OjE4MKwQIjbG9RP+AUHrYzHzksBwT46MdKQarr5JNjipxjd1nlbc3yar71ktaiEqZ4W5+Ib3J1R1VapdgtdbKjzxDUe25epGpQLL/erbdwHHQSHaaRwCyJzR8YEg6txeKVrQ/R7YaQYCcB6VxX3BIhIThQoZzGB/p/PoqEjysfLSPLUXnjOggUQF+h72eyG9N60+IqF/1DQVJUMcTdqd7qUUB+kriUQ/I6rYbeyQQZK/x9NsuWYX9gz+dR4PvGa2BNx5N9ELU7XyKJULfmDru3DPUJhLtutL25j4ViOuDNuRbeR3Oi8IM39VAgJBy18whlHBXsSZQA7j7qRt1so45yjVUjoHZ9JU4NBPnz5xfw+nGlks+xq+Oa/yHnl6t7Pi0JHPODO+79U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199018)(40470700004)(36840700001)(46966006)(44832011)(26005)(186003)(2906002)(1076003)(36756003)(6666004)(30864003)(356005)(478600001)(81166007)(82310400005)(8936002)(41300700001)(7696005)(40480700001)(2616005)(82740400003)(66899018)(47076005)(5660300002)(8676002)(36860700001)(336012)(70586007)(70206006)(4326008)(6916009)(83380400001)(19627235002)(426003)(86362001)(40460700003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 05:14:00.0483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c9b82b-2c08-482f-2922-08db0b259e57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

implement mode2 reset on smu_v13_0_10

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   7 +
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     | 303 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.h     |  32 ++
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  18 ++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  18 ++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   1 +
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h  |   1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  27 ++
 12 files changed, 412 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 24d8a03091b9..a7a0e385298d 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -80,7 +80,7 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o \
-	sienna_cichlid.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o
+	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index f778466bb9db..6437ead87e5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -24,6 +24,7 @@
 #include "amdgpu_reset.h"
 #include "aldebaran.h"
 #include "sienna_cichlid.h"
+#include "smu_v13_0_10.h"
 
 int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
 			     struct amdgpu_reset_handler *handler)
@@ -44,6 +45,9 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 7):
 		ret = sienna_cichlid_reset_init(adev);
 		break;
+	case IP_VERSION(13, 0, 10):
+		ret = smu_v13_0_10_reset_init(adev);
+		break;
 	default:
 		break;
 	}
@@ -62,6 +66,9 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 7):
 		ret = sienna_cichlid_reset_fini(adev);
 		break;
+	case IP_VERSION(13, 0, 10):
+		ret = smu_v13_0_10_reset_fini(adev);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
new file mode 100644
index 000000000000..ae29620b1ea4
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -0,0 +1,303 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+ */
+
+#include "smu_v13_0_10.h"
+#include "amdgpu_reset.h"
+#include "amdgpu_dpm.h"
+#include "amdgpu_job.h"
+#include "amdgpu_ring.h"
+#include "amdgpu_ras.h"
+#include "amdgpu_psp.h"
+
+static bool smu_v13_0_10_is_mode2_default(struct amdgpu_reset_control *reset_ctl)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+	if (adev->pm.fw_version >= 0x00502005 && !amdgpu_sriov_vf(adev))
+		return true;
+
+	return false;
+}
+
+static struct amdgpu_reset_handler *
+smu_v13_0_10_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
+			    struct amdgpu_reset_context *reset_context)
+{
+	struct amdgpu_reset_handler *handler;
+	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+
+	if (reset_context->method != AMD_RESET_METHOD_NONE) {
+		list_for_each_entry(handler, &reset_ctl->reset_handlers,
+				     handler_list) {
+			if (handler->reset_method == reset_context->method)
+				return handler;
+		}
+	}
+
+	if (smu_v13_0_10_is_mode2_default(reset_ctl) &&
+		amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE2) {
+		list_for_each_entry (handler, &reset_ctl->reset_handlers,
+				     handler_list) {
+			if (handler->reset_method == AMD_RESET_METHOD_MODE2)
+				return handler;
+		}
+	}
+
+	return NULL;
+}
+
+static int smu_v13_0_10_mode2_suspend_ip(struct amdgpu_device *adev)
+{
+	int r, i;
+
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+
+	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
+		if (!(adev->ip_blocks[i].version->type ==
+			      AMD_IP_BLOCK_TYPE_GFX ||
+		      adev->ip_blocks[i].version->type ==
+			      AMD_IP_BLOCK_TYPE_SDMA ||
+		      adev->ip_blocks[i].version->type ==
+			      AMD_IP_BLOCK_TYPE_MES))
+			continue;
+
+		r = adev->ip_blocks[i].version->funcs->suspend(adev);
+
+		if (r) {
+			dev_err(adev->dev,
+				"suspend of IP block <%s> failed %d\n",
+				adev->ip_blocks[i].version->funcs->name, r);
+			return r;
+		}
+		adev->ip_blocks[i].status.hw = false;
+	}
+
+	return r;
+}
+
+static int
+smu_v13_0_10_mode2_prepare_hwcontext(struct amdgpu_reset_control *reset_ctl,
+				  struct amdgpu_reset_context *reset_context)
+{
+	int r = 0;
+	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+
+	if (!amdgpu_sriov_vf(adev))
+		r = smu_v13_0_10_mode2_suspend_ip(adev);
+
+	return r;
+}
+
+static int smu_v13_0_10_mode2_reset(struct amdgpu_device *adev)
+{
+	return amdgpu_dpm_mode2_reset(adev);
+}
+
+static void smu_v13_0_10_async_reset(struct work_struct *work)
+{
+	struct amdgpu_reset_handler *handler;
+	struct amdgpu_reset_control *reset_ctl =
+		container_of(work, struct amdgpu_reset_control, reset_work);
+	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+
+	list_for_each_entry(handler, &reset_ctl->reset_handlers,
+			     handler_list) {
+		if (handler->reset_method == reset_ctl->active_reset) {
+			dev_dbg(adev->dev, "Resetting device\n");
+			handler->do_reset(adev);
+			break;
+		}
+	}
+}
+static int
+smu_v13_0_10_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
+			      struct amdgpu_reset_context *reset_context)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+	int r;
+
+	r = smu_v13_0_10_mode2_reset(adev);
+	if (r) {
+		dev_err(adev->dev,
+			"ASIC reset failed with error, %d ", r);
+	}
+	return r;
+}
+
+static int smu_v13_0_10_mode2_restore_ip(struct amdgpu_device *adev)
+{
+	int i, r;
+	struct psp_context *psp = &adev->psp;
+	struct amdgpu_firmware_info *ucode;
+	struct amdgpu_firmware_info *ucode_list[2];
+	int ucode_count = 0;
+
+	for (i = 0; i < adev->firmware.max_ucodes; i++) {
+		ucode = &adev->firmware.ucode[i];
+
+		switch (ucode->ucode_id) {
+		case AMDGPU_UCODE_ID_IMU_I:
+		case AMDGPU_UCODE_ID_IMU_D:
+			ucode_list[ucode_count++] = ucode;
+			break;
+		default:
+			break;
+		}
+	}
+
+	r = psp_load_fw_list(psp, ucode_list, ucode_count);
+	if (r) {
+		dev_err(adev->dev, "IMU ucode load failed after mode2 reset\n");
+		return r;
+	}
+
+	r = psp_rlc_autoload_start(psp);
+	if (r) {
+		DRM_ERROR("Failed to start rlc autoload after mode2 reset\n");
+		return r;
+	}
+
+	amdgpu_dpm_enable_gfx_features(adev);
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!(adev->ip_blocks[i].version->type ==
+			      AMD_IP_BLOCK_TYPE_GFX ||
+		      adev->ip_blocks[i].version->type ==
+			      AMD_IP_BLOCK_TYPE_MES ||
+		      adev->ip_blocks[i].version->type ==
+			      AMD_IP_BLOCK_TYPE_SDMA))
+			continue;
+		r = adev->ip_blocks[i].version->funcs->resume(adev);
+		if (r) {
+			dev_err(adev->dev,
+				"resume of IP block <%s> failed %d\n",
+				adev->ip_blocks[i].version->funcs->name, r);
+			return r;
+		}
+
+		adev->ip_blocks[i].status.hw = true;
+	}
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!(adev->ip_blocks[i].version->type ==
+			      AMD_IP_BLOCK_TYPE_GFX ||
+		      adev->ip_blocks[i].version->type ==
+			      AMD_IP_BLOCK_TYPE_MES ||
+		      adev->ip_blocks[i].version->type ==
+			      AMD_IP_BLOCK_TYPE_SDMA))
+			continue;
+
+		if (adev->ip_blocks[i].version->funcs->late_init) {
+			r = adev->ip_blocks[i].version->funcs->late_init(
+				(void *)adev);
+			if (r) {
+				dev_err(adev->dev,
+					"late_init of IP block <%s> failed %d after reset\n",
+					adev->ip_blocks[i].version->funcs->name,
+					r);
+				return r;
+			}
+		}
+		adev->ip_blocks[i].status.late_initialized = true;
+	}
+
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
+
+	return r;
+}
+
+static int
+smu_v13_0_10_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
+				  struct amdgpu_reset_context *reset_context)
+{
+	int r;
+	struct amdgpu_device *tmp_adev = (struct amdgpu_device *)reset_ctl->handle;
+
+	dev_info(tmp_adev->dev,
+			"GPU reset succeeded, trying to resume\n");
+	r = smu_v13_0_10_mode2_restore_ip(tmp_adev);
+	if (r)
+		goto end;
+
+	amdgpu_register_gpu_instance(tmp_adev);
+
+	/* Resume RAS */
+	amdgpu_ras_resume(tmp_adev);
+
+	amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
+
+	r = amdgpu_ib_ring_tests(tmp_adev);
+	if (r) {
+		dev_err(tmp_adev->dev,
+			"ib ring test failed (%d).\n", r);
+		r = -EAGAIN;
+		goto end;
+	}
+
+end:
+	if (r)
+		return -EAGAIN;
+	else
+		return r;
+}
+
+static struct amdgpu_reset_handler smu_v13_0_10_mode2_handler = {
+	.reset_method		= AMD_RESET_METHOD_MODE2,
+	.prepare_env		= NULL,
+	.prepare_hwcontext	= smu_v13_0_10_mode2_prepare_hwcontext,
+	.perform_reset		= smu_v13_0_10_mode2_perform_reset,
+	.restore_hwcontext	= smu_v13_0_10_mode2_restore_hwcontext,
+	.restore_env		= NULL,
+	.do_reset		= smu_v13_0_10_mode2_reset,
+};
+
+int smu_v13_0_10_reset_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_reset_control *reset_ctl;
+
+	reset_ctl = kzalloc(sizeof(*reset_ctl), GFP_KERNEL);
+	if (!reset_ctl)
+		return -ENOMEM;
+
+	reset_ctl->handle = adev;
+	reset_ctl->async_reset = smu_v13_0_10_async_reset;
+	reset_ctl->active_reset = AMD_RESET_METHOD_NONE;
+	reset_ctl->get_reset_handler = smu_v13_0_10_get_reset_handler;
+
+	INIT_LIST_HEAD(&reset_ctl->reset_handlers);
+	INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
+	/* Only mode2 is handled through reset control now */
+	amdgpu_reset_add_handler(reset_ctl, &smu_v13_0_10_mode2_handler);
+
+	adev->reset_cntl = reset_ctl;
+
+	return 0;
+}
+
+int smu_v13_0_10_reset_fini(struct amdgpu_device *adev)
+{
+	kfree(adev->reset_cntl);
+	adev->reset_cntl = NULL;
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.h b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.h
new file mode 100644
index 000000000000..e0cb72a0eec6
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+ */
+
+#ifndef __SMU_V13_0_10_H__
+#define __SMU_V13_0_10_H__
+
+#include "amdgpu.h"
+
+int smu_v13_0_10_reset_init(struct amdgpu_device *adev);
+int smu_v13_0_10_reset_fini(struct amdgpu_device *adev);
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index d68bd7c1aa04..e485a643bb99 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -398,6 +398,7 @@ struct amd_pm_funcs {
 	int (*get_ppfeature_status)(void *handle, char *buf);
 	int (*set_ppfeature_status)(void *handle, uint64_t ppfeature_masks);
 	int (*asic_reset_mode_2)(void *handle);
+	int (*asic_reset_enable_gfx_features)(void *handle);
 	int (*set_df_cstate)(void *handle, enum pp_df_cstate state);
 	int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
 	ssize_t (*get_gpu_metrics)(void *handle, void **table);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 751d01495195..f0068df2d073 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -250,6 +250,24 @@ int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
 	return ret;
 }
 
+int amdgpu_dpm_enable_gfx_features(struct amdgpu_device *adev)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	void *pp_handle = adev->powerplay.pp_handle;
+	int ret = 0;
+
+	if (!pp_funcs || !pp_funcs->asic_reset_enable_gfx_features)
+		return -ENOENT;
+
+	mutex_lock(&adev->pm.mutex);
+
+	ret = pp_funcs->asic_reset_enable_gfx_features(pp_handle);
+
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret;
+}
+
 int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 485522cb0238..ff2ebf786bb0 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -387,6 +387,7 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
 
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
+int amdgpu_dpm_enable_gfx_features(struct amdgpu_device *adev);
 
 bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);
 bool amdgpu_dpm_is_maco_supported(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f08698493502..0fe926bdc18a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2874,6 +2874,23 @@ static int smu_mode2_reset(void *handle)
 	return ret;
 }
 
+static int smu_enable_gfx_features(void *handle)
+{
+	struct smu_context *smu = handle;
+	int ret = 0;
+
+	if (!smu->pm_enabled)
+		return -EOPNOTSUPP;
+
+	if (smu->ppt_funcs->enable_gfx_features)
+		ret = smu->ppt_funcs->enable_gfx_features(smu);
+
+	if (ret)
+		dev_err(smu->adev->dev, "enable gfx features failed!\n");
+
+	return ret;
+}
+
 static int smu_get_max_sustainable_clocks_by_dc(void *handle,
 						struct pp_smu_nv_clock_table *max_clocks)
 {
@@ -3059,6 +3076,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_ppfeature_status             = smu_sys_get_pp_feature_mask,
 	.set_ppfeature_status             = smu_sys_set_pp_feature_mask,
 	.asic_reset_mode_2                = smu_mode2_reset,
+	.asic_reset_enable_gfx_features   = smu_enable_gfx_features,
 	.set_df_cstate                    = smu_set_df_cstate,
 	.set_xgmi_pstate                  = smu_set_xgmi_pstate,
 	.get_gpu_metrics                  = smu_sys_get_gpu_metrics,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index f5f0b2f3c610..1f65048a5c33 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1202,6 +1202,7 @@ struct pptable_funcs {
 	 * IPs reset varies by asic.
 	 */
 	int (*mode2_reset)(struct smu_context *smu);
+	int (*enable_gfx_features)(struct smu_context *smu);
 
 	/**
 	 * @get_dpm_ultimate_freq: Get the hard frequency range of a clock
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
index 8b8266890a10..10cff75b44d5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
@@ -94,6 +94,7 @@
 //Resets
 #define PPSMC_MSG_PrepareMp1ForUnload            0x2E
 #define PPSMC_MSG_Mode1Reset                     0x2F
+#define PPSMC_MSG_Mode2Reset					 0x4F
 
 //Set SystemVirtual DramAddrHigh
 #define PPSMC_MSG_SetSystemVirtualDramAddrHigh   0x30
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 4180c71d930f..96f6c2db955b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -242,7 +242,8 @@
 	__SMU_DUMMY_MAP(LogGfxOffResidency),			\
 	__SMU_DUMMY_MAP(SetNumBadMemoryPagesRetired),		\
 	__SMU_DUMMY_MAP(SetBadMemoryPagesRetiredFlagsPerChannel), \
-	__SMU_DUMMY_MAP(AllowGpo),
+	__SMU_DUMMY_MAP(AllowGpo),	\
+	__SMU_DUMMY_MAP(Mode2Reset),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 8b06a673e77c..44dd88bb3935 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -138,6 +138,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
 	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
 	MSG_MAP(Mode1Reset,			PPSMC_MSG_Mode1Reset,                  0),
+	MSG_MAP(Mode2Reset,			PPSMC_MSG_Mode2Reset,	       		   0),
 	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         0),
 	MSG_MAP(DFCstateControl,		PPSMC_MSG_SetExternalClientDfCstateAllow, 0),
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       0),
@@ -1957,6 +1958,30 @@ static int smu_v13_0_0_mode1_reset(struct smu_context *smu)
 	return ret;
 }
 
+static int smu_v13_0_0_mode2_reset(struct smu_context *smu)
+{
+	int ret;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 10))
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode2Reset, NULL);
+	else
+		return -EOPNOTSUPP;
+
+	return ret;
+}
+
+static int smu_v13_0_0_enable_gfx_features(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 10))
+		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableAllSmuFeatures,
+										   FEATURE_PWR_GFX, NULL);
+	else
+		return -EOPNOTSUPP;
+}
+
 static void smu_v13_0_0_set_smu_mailbox_registers(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -2073,6 +2098,8 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.baco_exit = smu_v13_0_0_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_0_mode1_reset,
+	.mode2_reset = smu_v13_0_0_mode2_reset,
+	.enable_gfx_features = smu_v13_0_0_enable_gfx_features,
 	.set_mp1_state = smu_v13_0_0_set_mp1_state,
 	.set_df_cstate = smu_v13_0_0_set_df_cstate,
 	.send_hbm_bad_pages_num = smu_v13_0_0_smu_send_bad_mem_page_num,
-- 
2.25.1

