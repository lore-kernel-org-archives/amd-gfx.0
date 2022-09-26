Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44E4C32771
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 21:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C619310E7BD;
	Mon, 26 Sep 2022 21:40:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67AC010E7BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 21:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7iLLqIPoBCtHbO8usqdF4bFwkxYOsmTnqSW9Mt/ubTnU3N3zlLufGjYRZtbMY47v+Z6bgx4RebTSA8Sf1qGoXc6RQ3jgXYJEA9Z/bw/MxEJnc4orDbRD+XJrvd0/K2u0nq/Ka0VZSnnaT0Vn0Ngtd+1Is0+RH6AQjyY81V92/epDJDQVz+ThMxscYPeJd+zKnqMp5yfuK1ViWgPkMaGSyCvL9MxInfhrGFhDt+sZVGZkN+7N0UtiLbI5clFcH0k4nudZCGLfTbgliJYyUGHDPWCbxK+R1f3Z5QH+vkPmottOFr/sCBGwC61FP4JQnGBYL/stUYTFl4WotkYQqNyBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uddSk7wj+5XZ1if9YcdNevKU9ierhJ9onVKkeBgEW/s=;
 b=aNmNODv+MkbsoAC13ew14Y5qwEQa75IscXDz88hiUhUzA1KZp5HQKV2Dy3rF2kT0IvV0NknipBD09IIMgxG/O40rrMUj5FTeJkaFXELPfoNaGEZNxvzO+N2iCFnt445uv7Ka3ff7oPB5YB4/WF9E+ZShv3/+9PyaDQKX/DRt9F2mN+WQDjYKt4gVjT8girMk1Ai1WK0UKLfTPL9vtBCuB/D4X7Pid6IZJquSRRlphH5fs6hq8m0RZaAmb+BuWd8J6PSAD5Jz8ahdI1FSMJ94sFZX5Wja0Fc/p4eOuapzZo6P+yaNrscYcf67RfmY3Y02+knfYEZT7OjwfJwp5n2kmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uddSk7wj+5XZ1if9YcdNevKU9ierhJ9onVKkeBgEW/s=;
 b=QFkpKHxOgkPdAd3uzlSoriQ7bFkoxMZRhFUik2YwiYRvDZE906rAFWYdCrkEVxr/SKwKc8O0nhkwUrs5+l3EuBRbPPKDqObAwDdedn6h1Z7rjO8TpFPmjcjducr0LDHX89qILIGmAnJaZN/BS0Zse0ijPMxUqOUX1Dsrl/qg8Ls=
Received: from BN1PR14CA0028.namprd14.prod.outlook.com (2603:10b6:408:e3::33)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Mon, 26 Sep
 2022 21:40:44 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::11) by BN1PR14CA0028.outlook.office365.com
 (2603:10b6:408:e3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 21:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 21:40:43 +0000
Received: from shashanks-target.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 16:40:40 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power profile
Date: Mon, 26 Sep 2022 23:40:11 +0200
Message-ID: <20220926214014.5450-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926214014.5450-1-shashank.sharma@amd.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ba37b7-b3bc-4570-577d-08daa007c3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BA62JFH6hlAWmTzjSuC2p18E3dxN62+1THO1gh9fDYB3NDHl39HIeqzvuk3gUqiylCMCgVZ/GnPLfCmfyjFUnWfs7peX/3Tvb70M4dJ7pIbztHVQwWhK523axNtjaNxcY93aS8/x8/+4RLEunw749xKScaFlVoUn07WD5NkVZunpDyKV0am63mv767J5IpzyMxxH2u4dSPR+w0lUnTZFv3sMR5UNM8SEuuxQ7NQERHK90zZq7FOgRrfbUqTT5m+QefHhHhse5PqeanyotfHHuGTgnZC7ARqV+rH8/vk1e5smAqxCKMsS4WFBswc4gIpDwAhpuDI2IbxVWnDe5qXrcrV1NQ/ZgLL3tIQbMb09fPT7rN3GD4GPmxfJ52myUMI2nYPmEORkbIXE3xYx4JmQWC/EU8CdGcbu79Ie1Wpxzni2lOTiNpT1STubFf6esyjxzhRrA4JEXUBCDABQ0FkGSeeX0U/DIDVltly8ug5Ih9quSBrKtth4Ap5Wfh9Ah324IQMxnlJ+0jtLCZr+Ctz+ob/7dVaCHvKy3B62fixxJ3CYeYw7OCq5JohmhvPw0a9tkR0ZLJLdzBezTIMhJDsi8S2yXMt6rlACTimDAdp3p7q+DmBOE2UZPQ4hA8Md6UuejMPNYyXjiODKDpXMLRZMQ12lAHBywGcqM/3YsmWoWllS/niNIp2mMxUzmJGlLpoAwwHulb54Wyij8Xv8qqU2GW6nLyiCMp1Km3pk4/VUCXEosC+1ZddXmw2zuR8hLwMmYMBbAq6mnFHRcmDmqEVc/d0KTblhZipF16TPDiW0UOv1JnfqaBirI/6sjeq66I1i
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(70586007)(356005)(1076003)(70206006)(47076005)(81166007)(4326008)(86362001)(426003)(40480700001)(2906002)(44832011)(83380400001)(16526019)(36756003)(8936002)(478600001)(82740400003)(40460700003)(336012)(66899012)(26005)(36860700001)(8676002)(5660300002)(2616005)(54906003)(186003)(6666004)(6916009)(7696005)(82310400005)(41300700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 21:40:43.7917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ba37b7-b3bc-4570-577d-08daa007c3eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com, Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds new functions which will allow a user to
change the GPU power profile based a GPU workload hint
flag.

Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
 .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
 5 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 5a283d12f8e1..34679c657ecc 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -50,7 +50,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
 	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
 	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o amdgpu_pll.o \
-	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
+	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_ctx_workload.o amdgpu_sync.o \
 	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
 	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
 	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
new file mode 100644
index 000000000000..a11cf29bc388
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
@@ -0,0 +1,97 @@
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
+ */
+#include <drm/drm.h>
+#include "kgd_pp_interface.h"
+#include "amdgpu_ctx_workload.h"
+
+static enum PP_SMC_POWER_PROFILE
+amdgpu_workload_to_power_profile(uint32_t hint)
+{
+	switch (hint) {
+	case AMDGPU_CTX_WORKLOAD_HINT_NONE:
+	default:
+		return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+
+	case AMDGPU_CTX_WORKLOAD_HINT_3D:
+		return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+	case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
+		return PP_SMC_POWER_PROFILE_VIDEO;
+	case AMDGPU_CTX_WORKLOAD_HINT_VR:
+		return PP_SMC_POWER_PROFILE_VR;
+	case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
+		return PP_SMC_POWER_PROFILE_COMPUTE;
+	}
+}
+
+int amdgpu_set_workload_profile(struct amdgpu_device *adev,
+				uint32_t hint)
+{
+	int ret = 0;
+	enum PP_SMC_POWER_PROFILE profile =
+			amdgpu_workload_to_power_profile(hint);
+
+	if (adev->pm.workload_mode == hint)
+		return 0;
+
+	mutex_lock(&adev->pm.smu_workload_lock);
+
+	if (adev->pm.workload_mode == hint)
+		goto unlock;
+
+	ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
+	if (!ret)
+		adev->pm.workload_mode = hint;
+	atomic_inc(&adev->pm.workload_switch_ref);
+
+unlock:
+	mutex_unlock(&adev->pm.smu_workload_lock);
+	return ret;
+}
+
+int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
+				  uint32_t hint)
+{
+	int ret = 0;
+	enum PP_SMC_POWER_PROFILE profile =
+			amdgpu_workload_to_power_profile(hint);
+
+	if (hint == AMDGPU_CTX_WORKLOAD_HINT_NONE)
+		return 0;
+
+	/* Do not reset GPU power profile if another reset is coming */
+	if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
+		return 0;
+
+	mutex_lock(&adev->pm.smu_workload_lock);
+
+	if (adev->pm.workload_mode != hint)
+		goto unlock;
+
+	ret = amdgpu_dpm_switch_power_profile(adev, profile, 0);
+	if (!ret)
+		adev->pm.workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
+
+unlock:
+	mutex_unlock(&adev->pm.smu_workload_lock);
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index be7aff2d4a57..1f0f64662c04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
+	mutex_init(&adev->pm.smu_workload_lock);
 	mutex_init(&adev->benchmark_mutex);
 
 	amdgpu_device_init_apu_flags(adev);
diff --git a/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
new file mode 100644
index 000000000000..6060fc53c3b0
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
@@ -0,0 +1,54 @@
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
+ */
+#ifndef _AMDGPU_CTX_WL_H_
+#define _AMDGPU_CTX_WL_H_
+#include <drm/amdgpu_drm.h>
+#include "amdgpu.h"
+
+/* Workload mode names */
+static const char * const amdgpu_workload_mode_name[] = {
+	"None",
+	"3D",
+	"Video",
+	"VR",
+	"Compute",
+	"Unknown",
+};
+
+static inline const
+char *amdgpu_workload_profile_name(uint32_t profile)
+{
+	if (profile >= AMDGPU_CTX_WORKLOAD_HINT_NONE &&
+		profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
+		return amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile)];
+
+	return amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
+}
+
+int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
+				uint32_t hint);
+
+int amdgpu_set_workload_profile(struct amdgpu_device *adev,
+				uint32_t hint);
+
+#endif
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 65624d091ed2..565131f789d0 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -361,6 +361,11 @@ struct amdgpu_pm {
 	struct mutex            stable_pstate_ctx_lock;
 	struct amdgpu_ctx       *stable_pstate_ctx;
 
+	/* SMU workload mode */
+	struct mutex smu_workload_lock;
+	uint32_t workload_mode;
+	atomic_t workload_switch_ref;
+
 	struct config_table_setting config_table;
 	/* runtime mode */
 	enum amdgpu_runpm_mode rpm_mode;
-- 
2.34.1

