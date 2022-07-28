Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E170C04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 10:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEC3112B031;
	Thu, 28 Jul 2022 10:30:45 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4D4F12AEC5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 10:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlSSXGg2hffBXZqDx2eiPbVaizCpOzzMJmGU508st2u5wD2HH+H0sfVuoEgl1vs/bJKhwb4ng9KERPZWiu4iGEk3cYb53wlDjtGNdwyVgg/V6wNH6oixnK9cLl7fUK/zMyKmRxJg95HdR/tcUZV80EJECS7zgORkVHpLIOvbLo3newLYOFIbLqg0hbBlt1n4shVaNiGQ5QB2nDX0V5QAasZ/CQZtOelbZsS/lRfzQpM4ZwUHXj+JRdc7rcBWWcg958VpAec6H0Z0eZKMF0LKmh+SsvdoKLP4Qwqy/RVC51qsZ1vo+mT5gtTs9vYOtDzXCeM2Sp6wZfvQjqaZ9drLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlisQ6b5geMeMbWSuTP0u7hCN+aD7M2KskVsZGVAgSo=;
 b=XWjfKDr/Hu7oS/0L9SRu55aqSJeH8vFRhsBaqHx7YUb5O7PFxnASfX5dwlWgxQqpJVgcS0Z2rtKFDHDDW3vLjQzQajPLo1MO58krM9neBAgvTau3HB1dJPfktLlAjzr+QZ/5AFJFrH09jrHAWOSftY7Krg718Znn7xUw6W8UAUtAe+RBY2IJtwhtx9vFJA5VMAItzMtsCPhxqJ2HdVbAnnK98k5s3GkCPnO+juxNGENFSogYmWYIsVzUXygmXhhE5cNys78pM/6HiDTi2LMJrRwDWRJkWxoTeDud/3HPoSIH4ryRgFMhxwpCHlYRGZ+gI3r5oaas2fbcTkNvx0ml7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlisQ6b5geMeMbWSuTP0u7hCN+aD7M2KskVsZGVAgSo=;
 b=nnlvo/RHpZVioDD6GnaKNFtCXhQeAeDI2DVYPafEBLRdEUS5+qjv9uAKKsu64OWUAElAAZns5J198rNoCjf0hpQQkoWE4zNb1BHtxwOgejh8FyTxWkNOg1KVte1FbAn7nQciX02XnA1jSHl48a7YmcQByPCKRlb6oinz4UEvWXs=
Received: from DM6PR03CA0034.namprd03.prod.outlook.com (2603:10b6:5:40::47) by
 DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.6; Thu, 28 Jul 2022 10:30:39 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::57) by DM6PR03CA0034.outlook.office365.com
 (2603:10b6:5:40::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20 via Frontend
 Transport; Thu, 28 Jul 2022 10:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 10:30:39 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 05:30:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 03:30:38 -0700
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 28 Jul 2022 05:30:37 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/6] drm/amdgpu: add mode2 reset for sienna_cichlid
Date: Thu, 28 Jul 2022 18:30:22 +0800
Message-ID: <20220728103027.27255-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d287fbc2-7c25-4bf9-1d74-08da7084379b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4925:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/R+tD4zdF6MsSb9PBZflilDDt7PxzjkCy5W40yMzSi4Rj6YNJFegj+e6i0v1Kr9f4RPWnizwlnwK73qClztt/YJgY1l1qxrksE/XVRMO77/sL28ilckVQQwKxITVXPo1pOFjcqcb32BY4HOfpsUwV6MFv74vPo1HuXjBCwyUnGv47M2m7zuB0nxhi0yoQF6+oj0lGVi7VVHXLQR+XZDaYkHEm8hcUKonpFfq4OjQh4EnJe9gcW6iH4TWqg3sJxtGoJ6kmEgYLGljsbwBXqB0htoH4MILKiQjf8KLvXnv7N11CdVg5U1gLTFUzQM2Z4c+Sw3oMsM2mkF+tkTtFuRpFixxmRl6MkzwGTvVJqIwnBHLi6+fWrALu04KgTo6vPJWyr8hp34Kv2lHLkyC6RLCig8u4rasftjfRy9HypFsjt0gSNg0HFv8nU0pi2FBV0hP1F3BcCYDBJmCzlvrNjdbjT1/jgx3tX7JxTNQ1X1dbsmXQqBGKreLx/bT8uehpOJv/XlQYM4Eb1k8BUtAB5K02stJVlLmEy8O7EKtXQDEUU9zGfNCJluy7m0M+xSx4ShHSF6/a8FCvhzOVW9/rpfW1zDEAhcR21YW2odfkK27G7rhGb1VmbliMv7fOv39rJqNgTz4N2M9egOHDEgc4wXh2hwqHVrZvZwEJwjN4TD19Eqym8Z63fSKelsx8Q9pnJDjQUG3pjkRgFLS8O32mVg3IQRhJss5OIaOLw7LCu5/YDf0/5I/I7m7HrgmmcSPaWtIPRYWOct+L1OWJkM2kXpmK63+EW5o/bIhrYV1sXb+21OJVgm/dL5IA6/L+XWIKLzBkonl5qpSWXRY1YsM18r/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(40470700004)(46966006)(36840700001)(36756003)(30864003)(19627235002)(54906003)(6666004)(7696005)(478600001)(41300700001)(26005)(2616005)(40480700001)(4326008)(6916009)(40460700003)(316002)(70586007)(82310400005)(8676002)(70206006)(5660300002)(8936002)(81166007)(426003)(2906002)(86362001)(83380400001)(36860700001)(356005)(186003)(1076003)(82740400003)(336012)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 10:30:39.6315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d287fbc2-7c25-4bf9-1d74-08da7084379b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4925
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
Cc: emily.deng@amd.com, Victor Zhao <Victor.Zhao@amd.com>,
 Andrey.Grodzovsky@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To meet the requirement for multi container usecase which needs
a quicker reset and not causing VRAM lost, adding the Mode2
reset handler for sienna_cichlid.

v2: move skip mode2 flag part separately

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   7 +
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   | 297 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h   |  32 ++
 .../pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h  |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  54 ++++
 7 files changed, 395 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index c7d0cd15b5ef..7030ac2d7d2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -75,7 +75,7 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o \
-	nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o
+	sienna_cichlid.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 32c86a0b145c..f778466bb9db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu_reset.h"
 #include "aldebaran.h"
+#include "sienna_cichlid.h"
 
 int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
 			     struct amdgpu_reset_handler *handler)
@@ -40,6 +41,9 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 2):
 		ret = aldebaran_reset_init(adev);
 		break;
+	case IP_VERSION(11, 0, 7):
+		ret = sienna_cichlid_reset_init(adev);
+		break;
 	default:
 		break;
 	}
@@ -55,6 +59,9 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 2):
 		ret = aldebaran_reset_fini(adev);
 		break;
+	case IP_VERSION(11, 0, 7):
+		ret = sienna_cichlid_reset_fini(adev);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
new file mode 100644
index 000000000000..0512960bed23
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -0,0 +1,297 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#include "sienna_cichlid.h"
+#include "amdgpu_reset.h"
+#include "amdgpu_amdkfd.h"
+#include "amdgpu_dpm.h"
+#include "amdgpu_job.h"
+#include "amdgpu_ring.h"
+#include "amdgpu_ras.h"
+#include "amdgpu_psp.h"
+#include "amdgpu_xgmi.h"
+
+static struct amdgpu_reset_handler *
+sienna_cichlid_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
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
+	} else {
+		list_for_each_entry(handler, &reset_ctl->reset_handlers,
+				     handler_list) {
+			if (handler->reset_method == AMD_RESET_METHOD_MODE2 &&
+			    adev->pm.fw_version >= 0x3a5500 &&
+			    !amdgpu_sriov_vf(adev)) {
+				reset_context->method = AMD_RESET_METHOD_MODE2;
+				return handler;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static int sienna_cichlid_mode2_suspend_ip(struct amdgpu_device *adev)
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
+			      AMD_IP_BLOCK_TYPE_SDMA))
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
+sienna_cichlid_mode2_prepare_hwcontext(struct amdgpu_reset_control *reset_ctl,
+				  struct amdgpu_reset_context *reset_context)
+{
+	int r = 0;
+	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+
+	if (!amdgpu_sriov_vf(adev))
+		r = sienna_cichlid_mode2_suspend_ip(adev);
+
+	return r;
+}
+
+static void sienna_cichlid_async_reset(struct work_struct *work)
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
+
+static int sienna_cichlid_mode2_reset(struct amdgpu_device *adev)
+{
+	/* disable BM */
+	pci_clear_master(adev->pdev);
+	adev->asic_reset_res = amdgpu_dpm_mode2_reset(adev);
+	return adev->asic_reset_res;
+}
+
+static int
+sienna_cichlid_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
+			      struct amdgpu_reset_context *reset_context)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+	int r;
+
+	r = sienna_cichlid_mode2_reset(adev);
+	if (r) {
+		dev_err(adev->dev,
+			"ASIC reset failed with error, %d ", r);
+	}
+	return r;
+}
+
+static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
+{
+	int i, r;
+	struct psp_context *psp = &adev->psp;
+
+	r = psp_rlc_autoload_start(psp);
+	if (r) {
+		dev_err(adev->dev, "Failed to start rlc autoload\n");
+		return r;
+	}
+
+	/* Reinit GFXHUB */
+	adev->gfxhub.funcs->init(adev);
+	r = adev->gfxhub.funcs->gart_enable(adev);
+	if (r) {
+		dev_err(adev->dev, "GFXHUB gart reenable failed after reset\n");
+		return r;
+	}
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)
+			r = adev->ip_blocks[i].version->funcs->resume(adev);
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
+sienna_cichlid_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
+				  struct amdgpu_reset_context *reset_context)
+{
+	int r;
+	struct amdgpu_device *tmp_adev = (struct amdgpu_device *)reset_ctl->handle;
+
+	dev_info(tmp_adev->dev,
+			"GPU reset succeeded, trying to resume\n");
+	r = sienna_cichlid_mode2_restore_ip(tmp_adev);
+	if (r)
+		goto end;
+
+	/*
+	* Add this ASIC as tracked as reset was already
+	* complete successfully.
+	*/
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
+		tmp_adev->asic_reset_res = r;
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
+static struct amdgpu_reset_handler sienna_cichlid_mode2_handler = {
+	.reset_method		= AMD_RESET_METHOD_MODE2,
+	.prepare_env		= NULL,
+	.prepare_hwcontext	= sienna_cichlid_mode2_prepare_hwcontext,
+	.perform_reset		= sienna_cichlid_mode2_perform_reset,
+	.restore_hwcontext	= sienna_cichlid_mode2_restore_hwcontext,
+	.restore_env		= NULL,
+	.do_reset		= sienna_cichlid_mode2_reset,
+};
+
+int sienna_cichlid_reset_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_reset_control *reset_ctl;
+
+	reset_ctl = kzalloc(sizeof(*reset_ctl), GFP_KERNEL);
+	if (!reset_ctl)
+		return -ENOMEM;
+
+	reset_ctl->handle = adev;
+	reset_ctl->async_reset = sienna_cichlid_async_reset;
+	reset_ctl->active_reset = AMD_RESET_METHOD_NONE;
+	reset_ctl->get_reset_handler = sienna_cichlid_get_reset_handler;
+
+	INIT_LIST_HEAD(&reset_ctl->reset_handlers);
+	INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
+	/* Only mode2 is handled through reset control now */
+	amdgpu_reset_add_handler(reset_ctl, &sienna_cichlid_mode2_handler);
+
+	adev->reset_cntl = reset_ctl;
+
+	return 0;
+}
+
+int sienna_cichlid_reset_fini(struct amdgpu_device *adev)
+{
+	kfree(adev->reset_cntl);
+	adev->reset_cntl = NULL;
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h
new file mode 100644
index 000000000000..5213b162dacd
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#ifndef __SIENNA_CICHLID_H__
+#define __SIENNA_CICHLID_H__
+
+#include "amdgpu.h"
+
+int sienna_cichlid_reset_init(struct amdgpu_device *adev);
+int sienna_cichlid_reset_fini(struct amdgpu_device *adev);
+
+#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h
index d2e10a724560..82cf9e563065 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h
@@ -137,7 +137,7 @@
 #define PPSMC_MSG_DisallowGpo                    0x56
 
 #define PPSMC_MSG_Enable2ndUSB20Port             0x57
-
-#define PPSMC_Message_Count                      0x58
+#define PPSMC_MSG_DriverMode2Reset               0x5D
+#define PPSMC_Message_Count                      0x5E
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 19084a4fcb2b..28f6a1eb6945 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -235,7 +235,8 @@
 	__SMU_DUMMY_MAP(UnforceGfxVid),           \
 	__SMU_DUMMY_MAP(HeavySBR),			\
 	__SMU_DUMMY_MAP(SetBadHBMPagesRetiredFlagsPerChannel), \
-	__SMU_DUMMY_MAP(EnableGfxImu),
+	__SMU_DUMMY_MAP(EnableGfxImu), \
+	__SMU_DUMMY_MAP(DriverMode2Reset),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index fa520d79ef67..a73d241bb64f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -154,6 +154,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(SetGpoFeaturePMask,		PPSMC_MSG_SetGpoFeaturePMask,          0),
 	MSG_MAP(DisallowGpo,			PPSMC_MSG_DisallowGpo,                 0),
 	MSG_MAP(Enable2ndUSB20Port,		PPSMC_MSG_Enable2ndUSB20Port,          0),
+	MSG_MAP(DriverMode2Reset,		PPSMC_MSG_DriverMode2Reset,	       0),
 };
 
 static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
@@ -4254,6 +4255,57 @@ static int sienna_cichlid_stb_get_data_direct(struct smu_context *smu,
 	return 0;
 }
 
+static bool sienna_cichlid_is_mode2_reset_supported(struct smu_context *smu)
+{
+	return true;
+}
+
+static int sienna_cichlid_mode2_reset(struct smu_context *smu)
+{
+	u32 smu_version;
+	int ret = 0, index;
+	struct amdgpu_device *adev = smu->adev;
+	int timeout = 100;
+
+	smu_cmn_get_smc_version(smu, NULL, &smu_version);
+
+	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
+						SMU_MSG_DriverMode2Reset);
+
+	mutex_lock(&smu->message_lock);
+
+	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
+					       SMU_RESET_MODE_2);
+
+	ret = smu_cmn_wait_for_response(smu);
+	while (ret != 0 && timeout) {
+		ret = smu_cmn_wait_for_response(smu);
+		/* Wait a bit more time for getting ACK */
+		if (ret != 0) {
+			--timeout;
+			usleep_range(500, 1000);
+			continue;
+		} else {
+			break;
+		}
+	}
+
+	if (!timeout) {
+		dev_err(adev->dev,
+			"failed to send mode2 message \tparam: 0x%08x response %#x\n",
+			SMU_RESET_MODE_2, ret);
+		goto out;
+	}
+
+	dev_info(smu->adev->dev, "restore config space...\n");
+	/* Restore the config space saved during init */
+	amdgpu_device_load_pci_state(adev->pdev);
+out:
+	mutex_unlock(&smu->message_lock);
+
+	return ret;
+}
+
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
@@ -4348,6 +4400,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_default_config_table_settings = sienna_cichlid_get_default_config_table_settings,
 	.set_config_table = sienna_cichlid_set_config_table,
 	.get_unique_id = sienna_cichlid_get_unique_id,
+	.mode2_reset_is_support = sienna_cichlid_is_mode2_reset_supported,
+	.mode2_reset = sienna_cichlid_mode2_reset,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

