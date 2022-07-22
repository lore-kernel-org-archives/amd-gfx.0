Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CED6C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 07:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A7CA10E1EA;
	Fri, 22 Jul 2022 07:34:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB4F510E2AF
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 07:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLshRWJstQLTfAbne1XypoR9DvB8oYBN5oNRRqW4i5qqIXXNKw/A2g4lqsxoucuf9mrWXe8rlkEiNum41Muw1P4B8ESpPW35E9ImYfGAkL9mqqN5oSThNVCa5jcEd8JjmPalGNbs8se+YOSx3uy+dlEwAiK9MK+cLpvw+gIuDiTIynIkRbZa/6hHkTb0jbCuHOwcKX9NxzWQkdrlN2zSO0cR8yuvIU0pifb/s1XJrQYohHC1kAXhJR0Upw/SIoL0+e80XDnZ241SheKwTpGo5cW+MIxRkKWiR0vTKpEVXyrGf2mTPH0dfnOt+TF2eZ5PzRCRFEXA9lC2ms8MAU5Aig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epJ0CkvNJvecqBROSKyWv3gEmf5IENS0618c0MnDCng=;
 b=j+flc1V4t/4TCTuNx9yHOKIk+mTrCBXFx7O5GK9ndYUUTSv3mVmZbLKNW4CLpZ3s+6UeYp8+ZzsSG+gnydTuZ8jP9nJyoeiVkdmsM4l441qYYkVrpz4IJVMcPFRhFzP3KM0mBhgf+WspPV8kXYNZVTuT+es+JZ6Qiob/UcDQSE8edgTzeWuL/76B3/vfKnDlIVSguPjBK9feIcXtT/hT+Wsb3I83wh2aD3Ut5sUi16mM1sf0xylNzl/w9LCPWwCMdnk3pGjLxXazeg7INIei8cdkwY9PRMPH+xIZgCfolxqcYhEb+9651qv2U3tWXzRMkl/2YQZT5vEBryFs9z2l6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epJ0CkvNJvecqBROSKyWv3gEmf5IENS0618c0MnDCng=;
 b=z8W9xk0BQH4FReHsrAnsjhtcDjVW0I0k2c2cKO/08VV/fPowP7CerZuXSl5kFqawKTSG2UHbrgGNsGkTUWr1h+yrQygVtiP0shWaDcl4nmtxQjEr0sqcS2qYk7NYFehRPFk9hM8QDoBZmoZwgHfnyg7rHS3yFIJeOhzXzIql1+Y=
Received: from BN7PR06CA0063.namprd06.prod.outlook.com (2603:10b6:408:34::40)
 by MWHPR12MB1470.namprd12.prod.outlook.com (2603:10b6:301:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 07:34:45 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::96) by BN7PR06CA0063.outlook.office365.com
 (2603:10b6:408:34::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 22 Jul 2022 07:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 07:34:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 02:34:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 02:34:44 -0500
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 22 Jul 2022 02:34:42 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: add mode2 reset for sienna_cichlid
Date: Fri, 22 Jul 2022 15:33:59 +0800
Message-ID: <20220722073403.5171-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985d9a73-167e-4b1c-fb2e-08da6bb4a631
X-MS-TrafficTypeDiagnostic: MWHPR12MB1470:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQcQ5tI0R7vfd1A8cBmba+2djssUkmVlOsVpPN3zGduZ7TppbWFbmgt5FV/Ql9Kr7l/zxywFb5ZNvaUUgVOQJaFWzi3aEEXocb5ltPbnsYmkvNquozQeFuFDmjnLhM75bh7LOTv70V3epo75pbJ+FB0NREuHN5Y20ZnGA+IvwIC0MnWQhnxmSddpBew/fsTNnXPFrQEMGJL5cg/N5wmiI7hCWKNfyOSnYUk0LgqSOdsZiOuG8EHGTgGtLyQcaLr5QUF2JQBSfXZ6ruvpYgANs09YBoe6zJV1HC5D5Ny6OFqkHSG4ba6rC/0DTYQfNIrg/TajATQYqIC/NVUk0eFuZxKp/ZOMG9IuPZkHRK5ch6HAZF1Fuu9yroquYFAWTYB5LLX3Ux6nDwVU/waZ7O5G4gROdVH7fwb7ixPwvYOwyti+u9x072VHSXJdzf7S1gvWV30+KmulAylOvlqq8xiJezyIGdc3rznwSJD4/6F/yoPF4IUCmUdb6APgMpWF32vrWW0d2a5uvnX7b63oZNiCzaLvb8+oDnCWtCcg1JSG659AIAUenUg6DhTxBpNq7WWuXG0wjxXWDczNG95JRi3LyziT8bEHWqFAIq5sDQ051b2Ijz3Hyhuhb+sQPzvpnUn/rMSFpa3iZuCbzOwmZBSf8yLy6b4Kx1zD1EVlmoqQ0rR0sh2LnqFYBVILdyGQShtLpQqnAd0ykBO4+ONLwm85SfRTRHdRsNVjQD7i9pAoHXYSIDKoUwBF0/1na+Rpn0idur/B2MR44/QD2a+N/uaRw3SyBxBCyd2TxsvapUCaGc7AWdqfesU1dKvN4O+KjvDPsJ+25oCDq/Nt8i1wn0jpdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(40470700004)(46966006)(36840700001)(5660300002)(478600001)(86362001)(40480700001)(8936002)(2616005)(47076005)(336012)(426003)(6666004)(40460700003)(41300700001)(2906002)(83380400001)(30864003)(26005)(1076003)(186003)(7696005)(36756003)(19627235002)(82310400005)(70586007)(356005)(70206006)(82740400003)(36860700001)(81166007)(6916009)(54906003)(8676002)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 07:34:45.2300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 985d9a73-167e-4b1c-fb2e-08da6bb4a631
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1470
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
Cc: Alexander.Deucher@amd.com, emily.deng@amd.com,
 Victor Zhao <Victor.Zhao@amd.com>, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To meet the requirement for multi container usecase which needs
a quicker reset and not causing VRAM lost, adding the Mode2
reset handler for sienna_cichlid. Adding a AMDGPU_SKIP_MODE2_RESET
flag so driver can fallback to default reset method when mode2
reset failed and retry.

- add mode2 reset handler for sienna_cichlid
- introduce AMDGPU_SKIP_MODE2_RESET flag
- let mode2 reset fallback to default reset method if failed

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |   1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   | 297 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.h   |  32 ++
 .../pm/swsmu/inc/pmfw_if/smu_v11_0_7_ppsmc.h  |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  54 ++++
 15 files changed, 414 insertions(+), 5 deletions(-)
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 5e53a5293935..091415a4abf0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -135,6 +135,7 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
 	reset_context.method = AMD_RESET_METHOD_NONE;
 	reset_context.reset_req_dev = adev;
 	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+	clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b79ee4ffb879..5498fda8617f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5146,6 +5146,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	reset_context->job = job;
 	reset_context->hive = hive;
+
 	/*
 	 * Build list of devices to reset.
 	 * In case we are in XGMI hive mode, resort the device list
@@ -5265,8 +5266,11 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			amdgpu_ras_resume(adev);
 	} else {
 		r = amdgpu_do_asic_reset(device_list_handle, reset_context);
-		if (r && r == -EAGAIN)
+		if (r && r == -EAGAIN) {
+			set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags);
+			adev->asic_reset_res = 0;
 			goto retry;
+		}
 	}
 
 skip_hw_reset:
@@ -5694,6 +5698,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	reset_context.reset_req_dev = adev;
 	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
+	set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 	adev->no_hw_access = true;
 	r = amdgpu_device_pre_asic_reset(adev, &reset_context);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 10fdd12cf853..9844d99075e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -71,6 +71,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
 		if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4f321375015c..259ec860890a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1949,6 +1949,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 32c86a0b145c..831fb222139c 100644
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
@@ -67,6 +74,9 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
 {
 	struct amdgpu_reset_handler *reset_handler = NULL;
 
+	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
+		return -ENOSYS;
+
 	if (adev->reset_cntl && adev->reset_cntl->get_reset_handler)
 		reset_handler = adev->reset_cntl->get_reset_handler(
 			adev->reset_cntl, reset_context);
@@ -83,6 +93,9 @@ int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
 	int ret;
 	struct amdgpu_reset_handler *reset_handler = NULL;
 
+	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
+		return -ENOSYS;
+
 	if (adev->reset_cntl)
 		reset_handler = adev->reset_cntl->get_reset_handler(
 			adev->reset_cntl, reset_context);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 9e55a5d7a825..cc4b2eeb24cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -30,6 +30,7 @@ enum AMDGPU_RESET_FLAGS {
 
 	AMDGPU_NEED_FULL_RESET = 0,
 	AMDGPU_SKIP_HW_RESET = 1,
+	AMDGPU_SKIP_MODE2_RESET = 2,
 };
 
 struct amdgpu_reset_context {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 12906ba74462..a2f04b249132 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -290,6 +290,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index e07757eea7ad..a977f0027928 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -317,6 +317,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 288c414babdf..fd14fa9b9cd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -529,6 +529,7 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
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

