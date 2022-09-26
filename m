Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5135CC07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 15:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C06D10E6C9;
	Mon, 26 Sep 2022 15:03:21 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7016210E324
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 15:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMU7vXJ6rgOo9hf1OQmphMi6nsPOkEw96hzL0AL66t5DkgHpQUPZCxYmOk/R9k1FnrHoPlpoCr55DKgqs3ASQiIoS7uHtH2gzQ7/44r6SwkuGzensWaZKUlPsJWqt/+E2bcKn53pi0JU17yfpEWK8S9mRQJkowuE+/CG3nJf528RcMbT2S//A0JIvF9Ay3JC3ek7q7N85DnzBTFoPDghqOhcqLU+pCdJSCDOqQRzScm3pT8nClwc+xGaIDr0pO9iIH10h9S6DMtHzd8LhdfPER9Agbj48bosjhVM9NxRqnSd1lGFZ5vlzZE9oMGsSWeKuzSc5PVR2OHNc3Qgia76bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIHlTjpEpB/+DBTCq/mu9+lygdQyL3HOD7SvE//KaWY=;
 b=IgNbxLYpbESSt9J05DUjNAOqFPjwj3Na7jtUenc5Rc7ffDBIKEbAUEXt6idnox8XA450mwSeojcGtqDNxdNB4+nbPvd8ylNgDZfBGY5vXXFB5lhydjftfZR46WiBG+G2VRfIUbt7Xc7l7C8TFTtCLZe6b01Y40TBKc1ekH2v8wxhs76wx78m9vsNupeCrN0yywddWJblJJpyUZnl9etnu0dvOMRrWkPWq7UGf5EgX1WiNrBj8xLGs0cvQguCIs2HvVVhGvzaKcsGSu2NUhT9Xl8AfjNlSz4aqN4vH5akjv3s3YigJ+Vl2Xszrd93NAdfx+l/iK0GOJtNs92mmnf41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIHlTjpEpB/+DBTCq/mu9+lygdQyL3HOD7SvE//KaWY=;
 b=mLLJJFe055RjYWDs+2uYkFtPqoiaaUqm8t7v13s5HO9xy4j1LjYLSr1r9Gc06VPgsfuryDCj5qbY68QMsicYO7emL90ZZYOVDwYHgX416vegxO1wx6Ylp5RGyd+5RC/2CWdSgG1fPT7JiuLbNEQnEVHFz0DcUPCyj/7q23RxQJo=
Received: from MW4PR04CA0362.namprd04.prod.outlook.com (2603:10b6:303:81::7)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 15:03:12 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::2c) by MW4PR04CA0362.outlook.office365.com
 (2603:10b6:303:81::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 15:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 15:03:11 +0000
Received: from shashanks-target.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 10:03:09 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/5] drm/amdgpu: add new functions to set GPU power profile
Date: Mon, 26 Sep 2022 17:02:49 +0200
Message-ID: <20220926150252.18635-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926150252.18635-1-shashank.sharma@amd.com>
References: <20220926150252.18635-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 18abc83e-eee2-4c86-d81f-08da9fd03adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4+ZjO7EpIiUd+yIZD7RK/mKNnZUh1OEEvzkO32nCx48MoUpDpj1hp3XO31ID/OTf+7Mj0rKECu3MfQh8tT0qFccGgcIoHbTJ+CK5Os9SMl9jMpus8jg/Op4E78H09Yd18ZRvgyxhzRzavBlVX0K7VllJZp0ot31SfFt5NDW3QtgXWXNTjcSyz2c80gO8Lv6c6TNFhSv1CVXBct3wf5+gGQxSc9WNaF59ynMzzxc3yQYGajuFoI1oxKrpQWz9qBzCLT3oks7erwAuvcb3PI3xmL6/6Qrp8350Vnxdb9r4S1Hjbh4NVhC1jY/k8hh7PPRwVy8MqJMDCGTemsm8jPIg56ki4EarXIfW7Ew6CptBjZX+Iclm3ri3Z8OCqLrFFf4IqKq6XxrqrmelfgGVF9ufJoMDFWvbyDVsP+F0DE/Iu28VM3YkagWHUAi7zJIb4xbRHpvQ+La3FWMkZqBCaBRsRZ7WGASgV6Gct84jOIFH9P7mhq9QHBCJFX/uX1WgpDU3p/Ffb04Nz7j5SYzjD5j1m6/hU5sCB4ikfyn+rIO9w/ansJzGPFa/RjGvrluUk0t75Mdmp2rymCY0vb3POnS9vX32pXw3tOZ71WVN668yYF72kzc4urrMSNAIIJqTGrYaiHFsb5wT7gauj41LgAhaOYzZ/MO2PsETp90+w3q4Uz8OYaOp50rHnINT6czaNVH6PWXvIdXog2rXOXqBcqbPEXjCskuAfXfeekTjgutybqnFPp24KOy5zZJvRhPaktqa6MrIERJ3dDrCtu1phVeCf6YU8oQYwdK9waaoVTnmUvDpKp64DZQmkm8lf3ZnIFO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(40480700001)(8676002)(8936002)(2616005)(1076003)(7696005)(2906002)(16526019)(86362001)(336012)(186003)(5660300002)(26005)(426003)(44832011)(70586007)(4326008)(70206006)(40460700003)(41300700001)(6666004)(36756003)(47076005)(83380400001)(66899012)(356005)(82310400005)(81166007)(478600001)(36860700001)(54906003)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:03:11.4193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18abc83e-eee2-4c86-d81f-08da9fd03adc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
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
Cc: amaranath.somalapuram@amd.com, Alex Deucher <alexandar.deucher@amd.com>,
 christian.koenig@amd.com, Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch adds new functions which will allow a user to
change the GPU power profile based a GPU workload hint
flag.

Cc: Alex Deucher <alexandar.deucher@amd.com>
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

