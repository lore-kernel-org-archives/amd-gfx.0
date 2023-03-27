Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DABC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89D1810E73F;
	Mon, 27 Mar 2023 19:46:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F2EB10E5B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCghdAC0N0UC4693KPmzv4eSEbYpH43JHmpWN9kmWPo90FpGH0gkRTh8DVFdI0k+bslyVWM0xhQ4lZCc2KYq3fw8exURQF5Rjvhfp9OVzw+VdXqhjR5EbK0xySmnFurSg5E1Qvk/C+1RJ57WM4N29TTbNnDyURukNdrjCFh+TdrdkITMhhxVIdkoWqzutACWCrdDJRJxjeswzUogppu/+yaDz+ir+aPnD7chSRCiGLpLnbldzSQHCm3kKlKSxolsICal1UlPAglJlJ4U5ObxUSzGkzqsZMXh9u49JBRn2t5isOj39yFgx5xPdxPQwjz/8BigaVd8JnoWxPSAO+k82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=284mBO1aeFUhXKucthIXE80FHDuVoNnB5Kv49EgvW6Q=;
 b=ecS+kUJW0p8b67Z4nToBkLc1OAFRrfbMHKT3+Ks26dP//QWXlNjgJ1i2zBoDve9DMzM5JV6ieRFhLcQFszMe4a99sLRGw9DvOo793EsD9I+6IfOKZS8FOKV1+y89cOrRtOwsbs19/OXPzXOB0CAyEdjc91OvRv5GhyoNSOtoeb9PGxhjnzFWeJwvWngaHqGPOCeaCxjkwoHZ+scM5JzAfx58C3KJsXmcUVF8lnCzN7X0swa+DbpbdedTciUbbdWV0JX2blYX8Q//UQGUuI45e/76pJg2hWAXUsIDXRGDB5tHZR/MxzlMxKVRDnya56BeH/M3fHCYWpdqJLhduRZJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=284mBO1aeFUhXKucthIXE80FHDuVoNnB5Kv49EgvW6Q=;
 b=infnEcT5cGCmRWL0xC2HP5uJKpfgz2XGDoHvprkB20Q2pAMOsDzOV+m6ONV2hTLgJ3FbhGbv1e2dfrwqJMyzruTs35vZgD8fMJADkxJBVnmY5oSXgcUkEN8jbJhEe43JvnocR87jaYhgHmnnd09WxMjoIqMTiLqDRUBwfjFQJy8=
Received: from DM6PR08CA0003.namprd08.prod.outlook.com (2603:10b6:5:80::16) by
 MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Mon, 27 Mar
 2023 19:46:38 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::51) by DM6PR08CA0003.outlook.office365.com
 (2603:10b6:5:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 19:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 19:46:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:46:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/11] drm/amdgpu/jpeg: add jpeg support for VCN4_0_3
Date: Mon, 27 Mar 2023 15:46:14 -0400
Message-ID: <20230327194622.8109-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327194622.8109-1-alexander.deucher@amd.com>
References: <20230327194622.8109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9bdab8-f58d-47a7-fdc8-08db2efbfae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfU/a0/UXxIt3A1c1HuCizGnEEwHAFRyIxpjWJ8AtmCEEvWq8SjzhG/R2cT6c0lwFOYlXiaiJLHYXViYorlIOOkoFtfwOM/fAJ4d+hcBJ4D0REigS98hWYLBBuT3Sdg/kymvr6JAH2ObAgQYXyYHk/fMakrvS8aNIjYne/Bu/qn2ijwGK3U7Y/b9p8JEmbx5CXUvioIzc7lnjkEO8NaWBAxkhBY4oIiuf3JL5hXCnMHUWybXFLpWJwLOPEsbUQEh2bpOtjyHCGGUPTTkFCWLuxa0b4PTTlIU62HeuBOxdylTrkU6sJAYGQTBgYmhbNednxqZttJgGPcwH95PBq48d1YxfhwxuW3+PsR15i+iP+RxFI0V2D0mVyUFS5+PuQuDJ18TAWBc2TPJLBUWb/oZcbdQag4zE1R9K4m7FIwgOjeGpmGrff/fmhoFgUltVjO6o9MAuaDCWUFaCgUj4tnAwRMpQvG5S/TZXe2GJ5T4IULKN0boYXRhKyEVW6yL5Ww+MB2OrNa19ZjXeRCn9k4aN7/92Crriv0Y9yrSZL52w8/Ap+mM9pNxOCBo2hF0aRMZSDeKkncpt93d3zgCdeGt6K8pVJ+hxFMT46sj2hhsawyx4QLhqPbx/gFDZ+u73LDWdQEZAYYRDYzvWHOfIJRUUxxVBgzRN2OErSL0PoV/5k4EJDYfmdGl4s8YPTNHlACj+HcBg28dUjLlGnxB5PIYtQPVkg36dqxgo6AnZPAetZ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(66899021)(2616005)(47076005)(83380400001)(336012)(426003)(41300700001)(36860700001)(36756003)(86362001)(5660300002)(356005)(8936002)(81166007)(82740400003)(40460700003)(54906003)(7696005)(478600001)(70586007)(8676002)(4326008)(6916009)(70206006)(2906002)(40480700001)(82310400005)(30864003)(6666004)(16526019)(1076003)(316002)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:46:38.3361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9bdab8-f58d-47a7-fdc8-08db2efbfae8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Add jpeg support for VCN4_0_3.

v2: squash in delayed work typo fix (Alex)

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 762 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h |  49 ++
 3 files changed, 813 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 7fb09000efc0..fc20aee6694f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -188,7 +188,8 @@ amdgpu-y += \
 	jpeg_v2_0.o \
 	jpeg_v2_5.o \
 	jpeg_v3_0.o \
-	jpeg_v4_0.o
+	jpeg_v4_0.o \
+	jpeg_v4_0_3.o
 
 # add ATHUB block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
new file mode 100644
index 000000000000..1fc72f9b52ed
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -0,0 +1,762 @@
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
+
+#include "amdgpu.h"
+#include "amdgpu_jpeg.h"
+#include "soc15.h"
+#include "soc15d.h"
+#include "jpeg_v4_0_3.h"
+
+#include "vcn/vcn_4_0_3_offset.h"
+#include "vcn/vcn_4_0_3_sh_mask.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
+
+enum jpeg_engin_status {
+	UVD_PGFSM_STATUS__UVDJ_PWR_ON  = 0,
+	UVD_PGFSM_STATUS__UVDJ_PWR_OFF = 2,
+};
+
+static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev);
+static void jpeg_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
+static int jpeg_v4_0_3_set_powergating_state(void *handle,
+				enum amd_powergating_state state);
+
+/**
+ * jpeg_v4_0_3_early_init - set function pointers
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Set ring and irq function pointers
+ */
+static int jpeg_v4_0_3_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	jpeg_v4_0_3_set_dec_ring_funcs(adev);
+	jpeg_v4_0_3_set_irq_funcs(adev);
+
+	return 0;
+}
+
+/**
+ * jpeg_v4_0_3_sw_init - sw init for JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Load firmware and sw initialization
+ */
+static int jpeg_v4_0_3_sw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_ring *ring;
+	int r;
+
+	/* JPEG TRAP */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+		VCN_2_0__SRCID__JPEG_DECODE, &adev->jpeg.inst->irq);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_sw_init(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_resume(adev);
+	if (r)
+		return r;
+
+	ring = &adev->jpeg.inst->ring_dec;
+	ring->use_doorbell = false;
+	ring->vm_hub = AMDGPU_MMHUB0(0);
+	sprintf(ring->name, "jpeg_dec");
+	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
+			     AMDGPU_RING_PRIO_DEFAULT, NULL);
+	if (r)
+		return r;
+
+	adev->jpeg.internal.jpeg_pitch = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
+	adev->jpeg.inst->external.jpeg_pitch = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
+
+	return 0;
+}
+
+/**
+ * jpeg_v4_0_3_sw_fini - sw fini for JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * JPEG suspend and free up sw allocation
+ */
+static int jpeg_v4_0_3_sw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_jpeg_suspend(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_sw_fini(adev);
+
+	return r;
+}
+
+/**
+ * jpeg_v4_0_3_hw_init - start and test JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ */
+static int jpeg_v4_0_3_hw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_ring *ring = &adev->jpeg.inst->ring_dec;
+	int r;
+
+	r = amdgpu_ring_test_helper(ring);
+	if (!r)
+		DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
+
+	return r;
+}
+
+/**
+ * jpeg_v4_0_3_hw_fini - stop the hardware block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Stop the JPEG block, mark ring as not ready any more
+ */
+static int jpeg_v4_0_3_hw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+
+	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
+		jpeg_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
+
+	return 0;
+}
+
+/**
+ * jpeg_v4_0_3_suspend - suspend JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * HW fini and suspend JPEG block
+ */
+static int jpeg_v4_0_3_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = jpeg_v4_0_3_hw_fini(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_suspend(adev);
+
+	return r;
+}
+
+/**
+ * jpeg_v4_0_3_resume - resume JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Resume firmware and hw init JPEG block
+ */
+static int jpeg_v4_0_3_resume(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_jpeg_resume(adev);
+	if (r)
+		return r;
+
+	r = jpeg_v4_0_3_hw_init(adev);
+
+	return r;
+}
+
+static void jpeg_v4_0_3_disable_clock_gating(struct amdgpu_device *adev)
+{
+	uint32_t data;
+
+	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG)
+		data |= 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data &= ~JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+
+	data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
+
+	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE);
+	data &= ~(JPEG_CGC_GATE__JPEG0_DEC_MASK
+		| JPEG_CGC_GATE__JPEG2_DEC_MASK
+		| JPEG_CGC_GATE__JMCIF_MASK
+		| JPEG_CGC_GATE__JRBBM_MASK);
+	WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
+}
+
+static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev)
+{
+	uint32_t data;
+
+	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG)
+		data |= 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data &= ~JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+
+	data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
+
+	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE);
+	data |= (JPEG_CGC_GATE__JPEG0_DEC_MASK
+		|JPEG_CGC_GATE__JPEG2_DEC_MASK
+		|JPEG_CGC_GATE__JMCIF_MASK
+		|JPEG_CGC_GATE__JRBBM_MASK);
+	WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
+}
+
+/**
+ * jpeg_v4_0_3_start - start JPEG block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Setup and start the JPEG block
+ */
+static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring = &adev->jpeg.inst->ring_dec;
+
+	WREG32_SOC15(JPEG, 0, regUVD_PGFSM_CONFIG,
+		1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
+	SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_PGFSM_STATUS,
+		UVD_PGFSM_STATUS__UVDJ_PWR_ON <<
+		UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
+		UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
+
+	/* disable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
+		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	/* JPEG disable CGC */
+	jpeg_v4_0_3_disable_clock_gating(adev);
+
+	/* MJPEG global tiling registers */
+	WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX8_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
+	WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
+
+	/* enable JMI channel */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL), 0,
+		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+	/* enable System Interrupt for JRBC */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regJPEG_SYS_INT_EN),
+		JPEG_SYS_INT_EN__DJRBC0_MASK,
+		~JPEG_SYS_INT_EN__DJRBC0_MASK);
+
+	WREG32_SOC15(JPEG, 0, regUVD_JMI0_UVD_LMI_JRBC_RB_VMID, 0);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
+	WREG32_SOC15(JPEG, 0, regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+		lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, 0, regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+		upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR, 0);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR, 0);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_CNTL, 0x00000002L);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_SIZE, ring->ring_size / 4);
+	ring->wptr = RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR);
+
+	return 0;
+}
+
+/**
+ * jpeg_v4_0_3_stop - stop JPEG block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * stop the JPEG block
+ */
+static int jpeg_v4_0_3_stop(struct amdgpu_device *adev)
+{
+	/* reset JMI */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
+		UVD_JMI_CNTL__SOFT_RESET_MASK,
+		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+	jpeg_v4_0_3_enable_clock_gating(adev);
+
+	/* enable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS),
+		UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
+		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	WREG32_SOC15(JPEG, 0, regUVD_PGFSM_CONFIG,
+		2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
+	SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_PGFSM_STATUS,
+		UVD_PGFSM_STATUS__UVDJ_PWR_OFF <<
+		UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
+		UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
+
+	return 0;
+}
+
+/**
+ * jpeg_v4_0_3_dec_ring_get_rptr - get read pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware read pointer
+ */
+static uint64_t jpeg_v4_0_3_dec_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	return RREG32_SOC15(JPEG, ring->me, regUVD_JRBC0_UVD_JRBC_RB_RPTR);
+}
+
+/**
+ * jpeg_v4_0_3_dec_ring_get_wptr - get write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware write pointer
+ */
+static uint64_t jpeg_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell)
+		return adev->wb.wb[ring->wptr_offs];
+	else
+		return RREG32_SOC15(JPEG, ring->me, regUVD_JRBC0_UVD_JRBC_RB_WPTR);
+}
+
+/**
+ * jpeg_v4_0_3_dec_ring_set_wptr - set write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Commits the write pointer to the hardware
+ */
+static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell) {
+		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
+	} else {
+		WREG32_SOC15(JPEG, ring->me,
+			regUVD_JRBC0_UVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
+	}
+}
+
+/**
+ * jpeg_v4_0_3_dec_ring_insert_start - insert a start command
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Write a start command to the ring.
+ */
+static void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring)
+{
+	amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, 0x62a04);/* TODO: PCTL0_MMHUB_DEEPSLEEP_IB */
+
+	amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, 0x80004000);
+}
+
+/**
+ * jpeg_v4_0_3_dec_ring_insert_end - insert a end command
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Write a end command to the ring.
+ */
+static void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring)
+{
+	amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, 0x62a04);
+
+	amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, 0x00004000);
+}
+
+/**
+ * jpeg_v4_0_3_dec_ring_emit_fence - emit an fence & trap command
+ *
+ * @ring: amdgpu_ring pointer
+ * @addr: address
+ * @seq: sequence number
+ * @flags: fence related flags
+ *
+ * Write a fence and a trap command to the ring.
+ */
+static void jpeg_v4_0_3_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
+				unsigned int flags)
+{
+	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+
+	amdgpu_ring_write(ring, PACKETJ(regUVD_JPEG_GPCOM_DATA0_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, seq);
+
+	amdgpu_ring_write(ring,	PACKETJ(regUVD_JPEG_GPCOM_DATA1_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, seq);
+
+	amdgpu_ring_write(ring,	PACKETJ(regUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_LOW_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, lower_32_bits(addr));
+
+	amdgpu_ring_write(ring,	PACKETJ(regUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_HIGH_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, upper_32_bits(addr));
+
+	amdgpu_ring_write(ring,	PACKETJ(regUVD_JPEG_GPCOM_CMD_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, 0x8);
+
+	amdgpu_ring_write(ring,	PACKETJ(regUVD_JPEG_GPCOM_CMD_INTERNAL_OFFSET,
+		0, PACKETJ_CONDITION_CHECK0, PACKETJ_TYPE4));
+	amdgpu_ring_write(ring, 0);
+
+	amdgpu_ring_write(ring,	PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, 0x3fbc);
+
+	amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, 0x1);
+
+	amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE7));
+	amdgpu_ring_write(ring, 0);
+}
+
+/**
+ * jpeg_v4_0_3_dec_ring_emit_ib - execute indirect buffer
+ *
+ * @ring: amdgpu_ring pointer
+ * @job: job to retrieve vmid from
+ * @ib: indirect buffer to execute
+ * @flags: unused
+ *
+ * Write ring commands to execute the indirect buffer.
+ */
+static void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
+				struct amdgpu_job *job,
+				struct amdgpu_ib *ib,
+				uint32_t flags)
+{
+	unsigned int vmid = AMDGPU_JOB_GET_VMID(job);
+
+	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
+
+	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
+
+	amdgpu_ring_write(ring,	PACKETJ(regUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
+
+	amdgpu_ring_write(ring,	PACKETJ(regUVD_LMI_JRBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
+
+	amdgpu_ring_write(ring,	PACKETJ(regUVD_JRBC_IB_SIZE_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, ib->length_dw);
+
+	amdgpu_ring_write(ring,	PACKETJ(regUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_LOW_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, lower_32_bits(ring->gpu_addr));
+
+	amdgpu_ring_write(ring,	PACKETJ(regUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_HIGH_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, upper_32_bits(ring->gpu_addr));
+
+	amdgpu_ring_write(ring,	PACKETJ(0, 0, PACKETJ_CONDITION_CHECK0, PACKETJ_TYPE2));
+	amdgpu_ring_write(ring, 0);
+
+	amdgpu_ring_write(ring,	PACKETJ(regUVD_JRBC_RB_COND_RD_TIMER_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, 0x01400200);
+
+	amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_RB_REF_DATA_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, 0x2);
+
+	amdgpu_ring_write(ring,	PACKETJ(regUVD_JRBC_STATUS_INTERNAL_OFFSET,
+		0, PACKETJ_CONDITION_CHECK3, PACKETJ_TYPE3));
+	amdgpu_ring_write(ring, 0x2);
+}
+
+static void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+				uint32_t val, uint32_t mask)
+{
+	uint32_t reg_offset = (reg << 2);
+
+	amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_RB_COND_RD_TIMER_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, 0x01400200);
+
+	amdgpu_ring_write(ring,	PACKETJ(regUVD_JRBC_RB_REF_DATA_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, val);
+
+	amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	if (reg_offset >= 0x10000 && reg_offset <= 0x105ff) {
+		amdgpu_ring_write(ring, 0);
+		amdgpu_ring_write(ring,
+			PACKETJ((reg_offset >> 2), 0, 0, PACKETJ_TYPE3));
+	} else {
+		amdgpu_ring_write(ring, reg_offset);
+		amdgpu_ring_write(ring,	PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
+			0, 0, PACKETJ_TYPE3));
+	}
+	amdgpu_ring_write(ring, mask);
+}
+
+static void jpeg_v4_0_3_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
+				unsigned int vmid, uint64_t pd_addr)
+{
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
+	uint32_t data0, data1, mask;
+
+	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+
+	/* wait for register write */
+	data0 = hub->ctx0_ptb_addr_lo32 + vmid * hub->ctx_addr_distance;
+	data1 = lower_32_bits(pd_addr);
+	mask = 0xffffffff;
+	jpeg_v4_0_3_dec_ring_emit_reg_wait(ring, data0, data1, mask);
+}
+
+static void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
+{
+	uint32_t reg_offset = (reg << 2);
+
+	amdgpu_ring_write(ring,	PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	if (reg_offset >= 0x10000 && reg_offset <= 0x105ff) {
+		amdgpu_ring_write(ring, 0);
+		amdgpu_ring_write(ring,
+			PACKETJ((reg_offset >> 2), 0, 0, PACKETJ_TYPE0));
+	} else {
+		amdgpu_ring_write(ring, reg_offset);
+		amdgpu_ring_write(ring,	PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
+			0, 0, PACKETJ_TYPE0));
+	}
+	amdgpu_ring_write(ring, val);
+}
+
+static void jpeg_v4_0_3_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count)
+{
+	int i;
+
+	WARN_ON(ring->wptr % 2 || count % 2);
+
+	for (i = 0; i < count / 2; i++) {
+		amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
+		amdgpu_ring_write(ring, 0);
+	}
+}
+
+static bool jpeg_v4_0_3_is_idle(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return ((RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS) &
+		UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
+		UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+}
+
+static int jpeg_v4_0_3_wait_for_idle(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int ret;
+
+	ret = SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS,
+		UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
+		UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+	return ret;
+}
+
+static int jpeg_v4_0_3_set_clockgating_state(void *handle,
+					  enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool enable = (state == AMD_CG_STATE_GATE);
+
+	if (enable) {
+		if (!jpeg_v4_0_3_is_idle(handle))
+			return -EBUSY;
+		jpeg_v4_0_3_enable_clock_gating(adev);
+	} else {
+		jpeg_v4_0_3_disable_clock_gating(adev);
+	}
+
+	return 0;
+}
+
+static int jpeg_v4_0_3_set_powergating_state(void *handle,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int ret;
+
+	if (state == adev->jpeg.cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = jpeg_v4_0_3_stop(adev);
+	else
+		ret = jpeg_v4_0_3_start(adev);
+
+	if (!ret)
+		adev->jpeg.cur_state = state;
+
+	return ret;
+}
+
+static int jpeg_v4_0_3_set_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
+static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
+				      struct amdgpu_irq_src *source,
+				      struct amdgpu_iv_entry *entry)
+{
+	DRM_DEV_DEBUG(adev->dev, "IH: JPEG TRAP\n");
+
+	switch (entry->src_id) {
+	case VCN_2_0__SRCID__JPEG_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst->ring_dec);
+		break;
+	default:
+		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
+			  entry->src_id, entry->src_data[0]);
+		break;
+	}
+
+	return 0;
+}
+
+static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
+	.name = "jpeg_v4_0_3",
+	.early_init = jpeg_v4_0_3_early_init,
+	.late_init = NULL,
+	.sw_init = jpeg_v4_0_3_sw_init,
+	.sw_fini = jpeg_v4_0_3_sw_fini,
+	.hw_init = jpeg_v4_0_3_hw_init,
+	.hw_fini = jpeg_v4_0_3_hw_fini,
+	.suspend = jpeg_v4_0_3_suspend,
+	.resume = jpeg_v4_0_3_resume,
+	.is_idle = jpeg_v4_0_3_is_idle,
+	.wait_for_idle = jpeg_v4_0_3_wait_for_idle,
+	.check_soft_reset = NULL,
+	.pre_soft_reset = NULL,
+	.soft_reset = NULL,
+	.post_soft_reset = NULL,
+	.set_clockgating_state = jpeg_v4_0_3_set_clockgating_state,
+	.set_powergating_state = jpeg_v4_0_3_set_powergating_state,
+};
+
+static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
+	.type = AMDGPU_RING_TYPE_VCN_JPEG,
+	.align_mask = 0xf,
+	.get_rptr = jpeg_v4_0_3_dec_ring_get_rptr,
+	.get_wptr = jpeg_v4_0_3_dec_ring_get_wptr,
+	.set_wptr = jpeg_v4_0_3_dec_ring_set_wptr,
+	.emit_frame_size =
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
+		8 + /* jpeg_v4_0_3_dec_ring_emit_vm_flush */
+		18 + 18 + /* jpeg_v4_0_3_dec_ring_emit_fence x2 vm fence */
+		8 + 16,
+	.emit_ib_size = 22, /* jpeg_v4_0_3_dec_ring_emit_ib */
+	.emit_ib = jpeg_v4_0_3_dec_ring_emit_ib,
+	.emit_fence = jpeg_v4_0_3_dec_ring_emit_fence,
+	.emit_vm_flush = jpeg_v4_0_3_dec_ring_emit_vm_flush,
+	.test_ring = amdgpu_jpeg_dec_ring_test_ring,
+	.test_ib = amdgpu_jpeg_dec_ring_test_ib,
+	.insert_nop = jpeg_v4_0_3_dec_ring_nop,
+	.insert_start = jpeg_v4_0_3_dec_ring_insert_start,
+	.insert_end = jpeg_v4_0_3_dec_ring_insert_end,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.begin_use = amdgpu_jpeg_ring_begin_use,
+	.end_use = amdgpu_jpeg_ring_end_use,
+	.emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
+	.emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+};
+
+static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev)
+{
+	adev->jpeg.inst->ring_dec.funcs = &jpeg_v4_0_3_dec_ring_vm_funcs;
+	adev->jpeg.inst->ring_dec.me = 0;
+	DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
+}
+
+static const struct amdgpu_irq_src_funcs jpeg_v4_0_3_irq_funcs = {
+	.set = jpeg_v4_0_3_set_interrupt_state,
+	.process = jpeg_v4_0_3_process_interrupt,
+};
+
+static void jpeg_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
+{
+	adev->jpeg.inst->irq.num_types = 1;
+	adev->jpeg.inst->irq.funcs = &jpeg_v4_0_3_irq_funcs;
+}
+
+const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_JPEG,
+	.major = 4,
+	.minor = 0,
+	.rev = 3,
+	.funcs = &jpeg_v4_0_3_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
new file mode 100644
index 000000000000..ca03d17e13fa
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
@@ -0,0 +1,49 @@
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
+
+#ifndef __JPEG_V4_0_3_H__
+#define __JPEG_V4_0_3_H__
+
+#define regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET			0x1bfff
+#define regUVD_JPEG_GPCOM_CMD_INTERNAL_OFFSET				0x404d
+#define regUVD_JPEG_GPCOM_DATA0_INTERNAL_OFFSET				0x404e
+#define regUVD_JPEG_GPCOM_DATA1_INTERNAL_OFFSET				0x404f
+#define regUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_LOW_INTERNAL_OFFSET		0x40ab
+#define regUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_HIGH_INTERNAL_OFFSET	0x40ac
+#define regUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET				0x40a4
+#define regUVD_LMI_JPEG_VMID_INTERNAL_OFFSET				0x40a6
+#define regUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET		0x40b6
+#define regUVD_LMI_JRBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40b7
+#define regUVD_JRBC_IB_SIZE_INTERNAL_OFFSET				0x4082
+#define regUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_LOW_INTERNAL_OFFSET		0x42d4
+#define regUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_HIGH_INTERNAL_OFFSET	0x42d5
+#define regUVD_JRBC_RB_COND_RD_TIMER_INTERNAL_OFFSET			0x4085
+#define regUVD_JRBC_RB_REF_DATA_INTERNAL_OFFSET				0x4084
+#define regUVD_JRBC_STATUS_INTERNAL_OFFSET				0x4089
+#define regUVD_JPEG_PITCH_INTERNAL_OFFSET				0x4043
+
+#define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
+
+extern const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block;
+
+#endif /* __JPEG_V4_0_3_H__ */
-- 
2.39.2

