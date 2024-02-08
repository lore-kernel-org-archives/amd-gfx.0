Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D736DC48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 19:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC79E10EBD8;
	Thu,  8 Feb 2024 19:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hXrtPoNG";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1284F10EBA0
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 19:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnPm4D12g2+fUkjLwPjTzmPzkU6oYY+t3EYOPfiFwnMzKLCAawEcxc2zOS9ZD/lfpWVfIgF5axEuNNN4G0zuMSYq7QND1xW1EjyDXMeD9fX4IePHyxwnt9ubzeTjMCVmroG7FuuwIFwewrRmbOxGhFNJNts1G+bh/9+vkNkOaXv2me5nXZL+MRWdCOJpT7EZ8LMTZdpMbX4D+9Nw5o+29Bbv0+OxIwprQvvzx3V83Ys7mnxYcUyPeg8bdk+zO9VY1HOPHMd9dqfO3Ka3LM2JcaSgC1lUHS2dBLDhGc9qkLpQG7kNb8VswxGaJefIq7EYKcXVxwiPCGg1NGIaRnX9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atS4pdDHU/r+6iPoy/oVix3AIAOCpy3jcvqRSAfWECw=;
 b=mXriLFkVuH7WspF94eDIUZSqu01PQ7QIX+L9X6nFG8Z2D126Rq9XJK/V2FgNaeuBAHnGGzbpCKpgajBjrgJw18pjS1xXGzH+2cl5Kn2LQUUTrldBnHVpSzVVL0H06fNabTd6mHoZ+O9RD2BixfH7AjDCEzfG0f6aNyvfrbyVuFW2PCzgEC6qK5MlNb0tw+TQtZ90hwKS7onQ9ETtLkXcHb+Q/SWWHesaKJoemsK8E0pGlAWgwtjxN3Xnid6dzLHi3jabr6Mci5+EUXiz0lpWOAvaVXLrkfwT0KTrIcPlMRrIEKEGK/8QxOKpq8yhkgME0J6trTx2YBXAu+4wHrye6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atS4pdDHU/r+6iPoy/oVix3AIAOCpy3jcvqRSAfWECw=;
 b=hXrtPoNGZK3pO/46P7z9USsRli/Z76uxHwPoTSoQ3ZgdWMS0zOmkApuK7a2jclGI5YBs3jyHZxlg2oWBsPECCDP1HSycSeiaYdBN9u3sr9A1qRiqrSLTzQ5gIbiSqVzxUXsiRMeiWtnIr6YFjB/eQfek6aF4Pnh7MK2Y9gRrfLE=
Received: from MN2PR16CA0038.namprd16.prod.outlook.com (2603:10b6:208:234::7)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Thu, 8 Feb
 2024 19:53:48 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::7b) by MN2PR16CA0038.outlook.office365.com
 (2603:10b6:208:234::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 19:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 8 Feb 2024 19:53:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 8 Feb
 2024 13:53:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonny.jiang@amd.com>, Leo Liu <leo.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add VCN_5_0_0 IP block support
Date: Thu, 8 Feb 2024 14:53:29 -0500
Message-ID: <20240208195330.408853-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240208195330.408853-1-alexander.deucher@amd.com>
References: <20240208195330.408853-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: ce467994-95b7-434e-3ff4-08dc28dfaa4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ncD6vdYuN34yel9vtanI6/cbC/YX702BRn8rzNZtLJhGq5p0Chl2Ku+JKd7uXMecBqkemMW6JwtNgtUPLId7k8GZ6oFa7wH0hKuopIhZ0wLjInVnxb8Jj+woiVLmX90JxKk+sk9RrnIP4hiS10FVxcQIOhJ2khLa/mKOkvOPKJK4nMIut/aBAgKSxpkSIgQmCaPoYeE3t12/N40LoDXyGCTky/kdS7dNMHYTza+xB7UrT7DmYUh+hRA3oJcoYrk3hB3aouFKdR0alY6YRWQAdgVfpF3nAayQJHJTANdjW5QT3K6z19GeeO5xdjGGisyNISywyaxeEpLX2e2q33YPsYCzlbH94WTCiQ+psLK8lpk1LxaCYifvrp3/7JOY+AxDkaTUt03qLKUV8+Mgo/0mbXmcWx3OQ31B2vi3sz7wI8RvQKObciuGmBshov7S9ebOVMDdZtBH/R/hAgecs4L5x6N+dEnRGvhCPA6KQoCUaB2vXqmOmpOY7KWmkYORmnDP7piL05I2BleoHF+Q/H8mXZO48rTzoVaBLo3lodLtulryIurG/DFKl1b0st02joLl73kbsK8wlHSJUbF43Q9akAyECc+4gk8lgPLE4OHF+5Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(46966006)(36840700001)(40470700004)(30864003)(5660300002)(478600001)(8936002)(70206006)(316002)(2616005)(36756003)(426003)(86362001)(70586007)(6916009)(6666004)(4326008)(54906003)(26005)(8676002)(16526019)(1076003)(41300700001)(81166007)(82740400003)(336012)(83380400001)(7696005)(356005)(66899024)(2906002)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 19:53:47.9306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce467994-95b7-434e-3ff4-08dc28dfaa4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660
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

From: Sonny Jiang <sonny.jiang@amd.com>

Add VCN_5_0_0 IP init, ring functions, DPG support.

v2: squash in warning fixes (Alex)
v3: squash in block and ring init, boot, doorbell enablement,
    DPG support (Alex)

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |   42 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 1339 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h |   37 +
 4 files changed, 1419 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 87022325bbf7..84c1baf8f3cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -209,6 +209,7 @@ amdgpu-y += \
 	vcn_v4_0.o \
 	vcn_v4_0_3.o \
 	vcn_v4_0_5.o \
+	vcn_v5_0_0.o \
 	amdgpu_jpeg.o \
 	jpeg_v1_0.o \
 	jpeg_v2_0.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 514c98ea144f..1985f71b4373 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -160,6 +160,48 @@
 		}                                                                     \
 	} while (0)
 
+#define SOC24_DPG_MODE_OFFSET(ip, inst_idx, reg)						\
+	({											\
+		uint32_t internal_reg_offset, addr;						\
+		bool video_range, aon_range;				\
+												\
+		addr = (adev->reg_offset[ip##_HWIP][inst_idx][reg##_BASE_IDX] + reg);		\
+		addr <<= 2;									\
+		video_range = ((((0xFFFFF & addr) >= (VCN_VID_SOC_ADDRESS)) &&			\
+				((0xFFFFF & addr) < ((VCN_VID_SOC_ADDRESS + 0x2600)))));	\
+		aon_range   = ((((0xFFFFF & addr) >= (VCN_AON_SOC_ADDRESS)) &&			\
+				((0xFFFFF & addr) < ((VCN_AON_SOC_ADDRESS + 0x600)))));		\
+		if (video_range)								\
+			internal_reg_offset = ((0xFFFFF & addr) - (VCN_VID_SOC_ADDRESS) +	\
+				(VCN_VID_IP_ADDRESS));						\
+		else if (aon_range)								\
+			internal_reg_offset = ((0xFFFFF & addr) - (VCN_AON_SOC_ADDRESS) +	\
+				(VCN_AON_IP_ADDRESS));						\
+		else										\
+			internal_reg_offset = (0xFFFFF & addr);					\
+												\
+		internal_reg_offset >>= 2;							\
+	})
+
+#define WREG32_SOC24_DPG_MODE(inst_idx, offset, value, mask_en, indirect)		\
+	do {										\
+		if (!indirect) {							\
+			WREG32_SOC15(VCN, GET_INST(VCN, inst_idx),			\
+				     regUVD_DPG_LMA_DATA, value);			\
+			WREG32_SOC15(							\
+				VCN, GET_INST(VCN, inst_idx),				\
+				regUVD_DPG_LMA_CTL,					\
+				(0x1 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |		\
+				 mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |		\
+				 offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));	\
+		} else {								\
+			*adev->vcn.inst[inst_idx].dpg_sram_curr_addr++ =		\
+				offset;							\
+			*adev->vcn.inst[inst_idx].dpg_sram_curr_addr++ =		\
+				value;							\
+		}									\
+	} while (0)
+
 #define AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE (1 << 2)
 #define AMDGPU_FW_SHARED_FLAG_0_DRM_KEY_INJECT (1 << 4)
 #define AMDGPU_VCN_FW_SHARED_FLAG_0_RB	(1 << 6)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
new file mode 100644
index 000000000000..d6ee9958ba5f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -0,0 +1,1339 @@
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
+#include <linux/firmware.h>
+#include "amdgpu.h"
+#include "amdgpu_vcn.h"
+#include "amdgpu_pm.h"
+#include "soc15.h"
+#include "soc15d.h"
+#include "soc15_hw_ip.h"
+#include "vcn_v2_0.h"
+
+#include "vcn/vcn_5_0_0_offset.h"
+#include "vcn/vcn_5_0_0_sh_mask.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
+#include "vcn_v5_0_0.h"
+
+#include <drm/drm_drv.h>
+
+static int amdgpu_ih_clientid_vcns[] = {
+	SOC15_IH_CLIENTID_VCN,
+	SOC15_IH_CLIENTID_VCN1
+};
+
+static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
+static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v5_0_0_set_powergating_state(void *handle,
+		enum amd_powergating_state state);
+static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
+		int inst_idx, struct dpg_pause_state *new_state);
+static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
+
+/**
+ * vcn_v5_0_0_early_init - set function pointers and load microcode
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Set ring and irq function pointers
+ * Load microcode from filesystem
+ */
+static int vcn_v5_0_0_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	/* re-use enc ring as unified ring */
+	adev->vcn.num_enc_rings = 1;
+
+	vcn_v5_0_0_set_unified_ring_funcs(adev);
+	vcn_v5_0_0_set_irq_funcs(adev);
+
+	return amdgpu_vcn_early_init(adev);
+}
+
+/**
+ * vcn_v5_0_0_sw_init - sw init for VCN block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Load firmware and sw initialization
+ */
+static int vcn_v5_0_0_sw_init(void *handle)
+{
+	struct amdgpu_ring *ring;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i, r;
+
+	r = amdgpu_vcn_sw_init(adev);
+	if (r)
+		return r;
+
+	amdgpu_vcn_setup_ucode(adev);
+
+	r = amdgpu_vcn_resume(adev);
+	if (r)
+		return r;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		atomic_set(&adev->vcn.inst[i].sched_score, 0);
+
+		/* VCN UNIFIED TRAP */
+		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
+				VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
+		if (r)
+			return r;
+
+		/* VCN POISON TRAP */
+		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
+				VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[i].irq);
+		if (r)
+			return r;
+
+		ring = &adev->vcn.inst[i].ring_enc[0];
+		ring->use_doorbell = true;
+		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * i;
+
+		ring->vm_hub = AMDGPU_MMHUB0(0);
+		sprintf(ring->name, "vcn_unified_%d", i);
+
+		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
+						AMDGPU_RING_PRIO_0, &adev->vcn.inst[i].sched_score);
+		if (r)
+			return r;
+
+		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
+		fw_shared->sq.is_enabled = 1;
+
+		if (amdgpu_vcnfw_log)
+			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
+	}
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		adev->vcn.pause_dpg_mode = vcn_v5_0_0_pause_dpg_mode;
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_0_sw_fini - sw fini for VCN block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * VCN suspend and free up sw allocation
+ */
+static int vcn_v5_0_0_sw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i, r, idx;
+
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
+
+			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+			fw_shared->present_flag_0 = 0;
+			fw_shared->sq.is_enabled = 0;
+		}
+
+		drm_dev_exit(idx);
+	}
+
+	r = amdgpu_vcn_suspend(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_vcn_sw_fini(adev);
+
+	return r;
+}
+
+/**
+ * vcn_v5_0_0_hw_init - start and test VCN block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Initialize the hardware, boot up the VCPU and do some testing
+ */
+static int vcn_v5_0_0_hw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_ring *ring;
+	int i, r;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		ring = &adev->vcn.inst[i].ring_enc[0];
+
+		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+			((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
+
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			goto done;
+	}
+
+done:
+	if (!r)
+		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
+			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
+
+	return r;
+}
+
+/**
+ * vcn_v5_0_0_hw_fini - stop the hardware block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Stop the VCN block, mark ring as not ready any more
+ */
+static int vcn_v5_0_0_hw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i;
+
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		amdgpu_irq_put(adev, &adev->vcn.inst[i].irq, 0);
+	}
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_0_suspend - suspend VCN block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * HW fini and suspend VCN block
+ */
+static int vcn_v5_0_0_suspend(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	r = vcn_v5_0_0_hw_fini(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_vcn_suspend(adev);
+
+	return r;
+}
+
+/**
+ * vcn_v5_0_0_resume - resume VCN block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Resume firmware and hw init VCN block
+ */
+static int vcn_v5_0_0_resume(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	r = amdgpu_vcn_resume(adev);
+	if (r)
+		return r;
+
+	r = vcn_v5_0_0_hw_init(adev);
+
+	return r;
+}
+
+/**
+ * vcn_v5_0_0_mc_resume - memory controller programming
+ *
+ * @adev: amdgpu_device pointer
+ * @inst: instance number
+ *
+ * Let the VCN memory controller know it's offsets
+ */
+static void vcn_v5_0_0_mc_resume(struct amdgpu_device *adev, int inst)
+{
+	uint32_t offset, size;
+	const struct common_firmware_header *hdr;
+
+	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
+	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
+
+	/* cache window 0: fw */
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		WREG32_SOC15(VCN, inst, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst].tmr_mc_addr_lo));
+		WREG32_SOC15(VCN, inst, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst].tmr_mc_addr_hi));
+		WREG32_SOC15(VCN, inst, regUVD_VCPU_CACHE_OFFSET0, 0);
+		offset = 0;
+	} else {
+		WREG32_SOC15(VCN, inst, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+			lower_32_bits(adev->vcn.inst[inst].gpu_addr));
+		WREG32_SOC15(VCN, inst, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+			upper_32_bits(adev->vcn.inst[inst].gpu_addr));
+		offset = size;
+		WREG32_SOC15(VCN, inst, regUVD_VCPU_CACHE_OFFSET0, AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
+	}
+	WREG32_SOC15(VCN, inst, regUVD_VCPU_CACHE_SIZE0, size);
+
+	/* cache window 1: stack */
+	WREG32_SOC15(VCN, inst, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
+		lower_32_bits(adev->vcn.inst[inst].gpu_addr + offset));
+	WREG32_SOC15(VCN, inst, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
+		upper_32_bits(adev->vcn.inst[inst].gpu_addr + offset));
+	WREG32_SOC15(VCN, inst, regUVD_VCPU_CACHE_OFFSET1, 0);
+	WREG32_SOC15(VCN, inst, regUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE);
+
+	/* cache window 2: context */
+	WREG32_SOC15(VCN, inst, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
+		lower_32_bits(adev->vcn.inst[inst].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
+	WREG32_SOC15(VCN, inst, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
+		upper_32_bits(adev->vcn.inst[inst].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
+	WREG32_SOC15(VCN, inst, regUVD_VCPU_CACHE_OFFSET2, 0);
+	WREG32_SOC15(VCN, inst, regUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
+
+	/* non-cache window */
+	WREG32_SOC15(VCN, inst, regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
+		lower_32_bits(adev->vcn.inst[inst].fw_shared.gpu_addr));
+	WREG32_SOC15(VCN, inst, regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
+		upper_32_bits(adev->vcn.inst[inst].fw_shared.gpu_addr));
+	WREG32_SOC15(VCN, inst, regUVD_VCPU_NONCACHE_OFFSET0, 0);
+	WREG32_SOC15(VCN, inst, regUVD_VCPU_NONCACHE_SIZE0,
+		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared)));
+}
+
+/**
+ * vcn_v5_0_0_mc_resume_dpg_mode - memory controller programming for dpg mode
+ *
+ * @adev: amdgpu_device pointer
+ * @inst_idx: instance number index
+ * @indirect: indirectly write sram
+ *
+ * Let the VCN memory controller know it's offsets with dpg mode
+ */
+static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+{
+	uint32_t offset, size;
+	const struct common_firmware_header *hdr;
+
+	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
+	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
+
+	/* cache window 0: fw */
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		if (!indirect) {
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, inst_idx, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_lo), 0, indirect);
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, inst_idx, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_hi), 0, indirect);
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, inst_idx, regUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+		} else {
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, inst_idx, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, inst_idx, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, inst_idx, regUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+		}
+		offset = 0;
+	} else {
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, inst_idx, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, inst_idx, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
+		offset = size;
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, inst_idx, regUVD_VCPU_CACHE_OFFSET0),
+			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
+	}
+
+	if (!indirect)
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, inst_idx, regUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
+	else
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, inst_idx, regUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
+
+	/* cache window 1: stack */
+	if (!indirect) {
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, inst_idx, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, inst_idx, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, inst_idx, regUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+	} else {
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, inst_idx, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, inst_idx, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, inst_idx, regUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+	}
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, inst_idx, regUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
+
+	/* cache window 2: context */
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, inst_idx, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+		lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, inst_idx, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+		upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, inst_idx, regUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, inst_idx, regUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
+
+	/* non-cache window */
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, inst_idx, regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
+		lower_32_bits(adev->vcn.inst[inst_idx].fw_shared.gpu_addr), 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, inst_idx, regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
+		upper_32_bits(adev->vcn.inst[inst_idx].fw_shared.gpu_addr), 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, inst_idx, regUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, inst_idx, regUVD_VCPU_NONCACHE_SIZE0),
+		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared)), 0, indirect);
+
+	/* VCN global tiling registers */
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+
+	return;
+}
+
+/**
+ * vcn_v5_0_0_disable_static_power_gating - disable VCN static power gating
+ *
+ * @adev: amdgpu_device pointer
+ * @inst: instance number
+ *
+ * Disable static power gating for VCN block
+ */
+static void vcn_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
+{
+	uint32_t data = 0;
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
+		data = 1 << UVD_IPX_DLDO_CONFIG__ONO2_PWR_CONFIG__SHIFT;
+		WREG32_SOC15(VCN, inst, regUVD_IPX_DLDO_CONFIG, data);
+		SOC15_WAIT_ON_RREG(VCN, inst, regUVD_IPX_DLDO_STATUS, 0,
+				UVD_IPX_DLDO_STATUS__ONO2_PWR_STATUS_MASK);
+
+		data = 2 << UVD_IPX_DLDO_CONFIG__ONO3_PWR_CONFIG__SHIFT;
+		WREG32_SOC15(VCN, inst, regUVD_IPX_DLDO_CONFIG, data);
+		SOC15_WAIT_ON_RREG(VCN, inst, regUVD_IPX_DLDO_STATUS,
+				1 << UVD_IPX_DLDO_STATUS__ONO3_PWR_STATUS__SHIFT,
+				UVD_IPX_DLDO_STATUS__ONO3_PWR_STATUS_MASK);
+
+		data = 2 << UVD_IPX_DLDO_CONFIG__ONO4_PWR_CONFIG__SHIFT;
+		WREG32_SOC15(VCN, inst, regUVD_IPX_DLDO_CONFIG, data);
+		SOC15_WAIT_ON_RREG(VCN, inst, regUVD_IPX_DLDO_STATUS,
+				1 << UVD_IPX_DLDO_STATUS__ONO4_PWR_STATUS__SHIFT,
+				UVD_IPX_DLDO_STATUS__ONO4_PWR_STATUS_MASK);
+
+		data = 2 << UVD_IPX_DLDO_CONFIG__ONO5_PWR_CONFIG__SHIFT;
+		WREG32_SOC15(VCN, inst, regUVD_IPX_DLDO_CONFIG, data);
+		SOC15_WAIT_ON_RREG(VCN, inst, regUVD_IPX_DLDO_STATUS,
+				1 << UVD_IPX_DLDO_STATUS__ONO5_PWR_STATUS__SHIFT,
+				UVD_IPX_DLDO_STATUS__ONO5_PWR_STATUS_MASK);
+	} else {
+		data = 1 << UVD_IPX_DLDO_CONFIG__ONO2_PWR_CONFIG__SHIFT;
+		WREG32_SOC15(VCN, inst, regUVD_IPX_DLDO_CONFIG, data);
+		SOC15_WAIT_ON_RREG(VCN, inst, regUVD_IPX_DLDO_STATUS, 0,
+				UVD_IPX_DLDO_STATUS__ONO2_PWR_STATUS_MASK);
+
+		data = 1 << UVD_IPX_DLDO_CONFIG__ONO3_PWR_CONFIG__SHIFT;
+		WREG32_SOC15(VCN, inst, regUVD_IPX_DLDO_CONFIG, data);
+		SOC15_WAIT_ON_RREG(VCN, inst, regUVD_IPX_DLDO_STATUS, 0,
+				UVD_IPX_DLDO_STATUS__ONO3_PWR_STATUS_MASK);
+
+		data = 1 << UVD_IPX_DLDO_CONFIG__ONO4_PWR_CONFIG__SHIFT;
+		WREG32_SOC15(VCN, inst, regUVD_IPX_DLDO_CONFIG, data);
+		SOC15_WAIT_ON_RREG(VCN, inst, regUVD_IPX_DLDO_STATUS, 0,
+				UVD_IPX_DLDO_STATUS__ONO4_PWR_STATUS_MASK);
+
+		data = 1 << UVD_IPX_DLDO_CONFIG__ONO5_PWR_CONFIG__SHIFT;
+		WREG32_SOC15(VCN, inst, regUVD_IPX_DLDO_CONFIG, data);
+		SOC15_WAIT_ON_RREG(VCN, inst, regUVD_IPX_DLDO_STATUS, 0,
+				UVD_IPX_DLDO_STATUS__ONO5_PWR_STATUS_MASK);
+	}
+
+	data = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
+	data &= ~0x103;
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
+		data |= UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON |
+			UVD_POWER_STATUS__UVD_PG_EN_MASK;
+
+	WREG32_SOC15(VCN, inst, regUVD_POWER_STATUS, data);
+	return;
+}
+
+/**
+ * vcn_v5_0_0_enable_static_power_gating - enable VCN static power gating
+ *
+ * @adev: amdgpu_device pointer
+ * @inst: instance number
+ *
+ * Enable static power gating for VCN block
+ */
+static void vcn_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev, int inst)
+{
+	uint32_t data;
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
+		/* Before power off, this indicator has to be turned on */
+		data = RREG32_SOC15(VCN, inst, regUVD_POWER_STATUS);
+		data &= ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK;
+		data |= UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF;
+		WREG32_SOC15(VCN, inst, regUVD_POWER_STATUS, data);
+
+		data = 2 << UVD_IPX_DLDO_CONFIG__ONO5_PWR_CONFIG__SHIFT;
+		WREG32_SOC15(VCN, inst, regUVD_IPX_DLDO_CONFIG, data);
+		SOC15_WAIT_ON_RREG(VCN, inst, regUVD_IPX_DLDO_STATUS,
+				1 << UVD_IPX_DLDO_STATUS__ONO5_PWR_STATUS__SHIFT,
+				UVD_IPX_DLDO_STATUS__ONO5_PWR_STATUS_MASK);
+
+		data = 2 << UVD_IPX_DLDO_CONFIG__ONO4_PWR_CONFIG__SHIFT;
+		WREG32_SOC15(VCN, inst, regUVD_IPX_DLDO_CONFIG, data);
+		SOC15_WAIT_ON_RREG(VCN, inst, regUVD_IPX_DLDO_STATUS,
+				1 << UVD_IPX_DLDO_STATUS__ONO4_PWR_STATUS__SHIFT,
+				UVD_IPX_DLDO_STATUS__ONO4_PWR_STATUS_MASK);
+
+		data = 2 << UVD_IPX_DLDO_CONFIG__ONO3_PWR_CONFIG__SHIFT;
+		WREG32_SOC15(VCN, inst, regUVD_IPX_DLDO_CONFIG, data);
+		SOC15_WAIT_ON_RREG(VCN, inst, regUVD_IPX_DLDO_STATUS,
+				1 << UVD_IPX_DLDO_STATUS__ONO3_PWR_STATUS__SHIFT,
+				UVD_IPX_DLDO_STATUS__ONO3_PWR_STATUS_MASK);
+
+		data = 2 << UVD_IPX_DLDO_CONFIG__ONO2_PWR_CONFIG__SHIFT;
+		WREG32_SOC15(VCN, inst, regUVD_IPX_DLDO_CONFIG, data);
+		SOC15_WAIT_ON_RREG(VCN, inst, regUVD_IPX_DLDO_STATUS,
+				1 << UVD_IPX_DLDO_STATUS__ONO2_PWR_STATUS__SHIFT,
+				UVD_IPX_DLDO_STATUS__ONO2_PWR_STATUS_MASK);
+	}
+	return;
+}
+
+/**
+ * vcn_v5_0_0_disable_clock_gating - disable VCN clock gating
+ *
+ * @adev: amdgpu_device pointer
+ * @inst: instance number
+ *
+ * Disable clock gating for VCN block
+ */
+static void vcn_v5_0_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
+{
+	return;
+}
+
+#if 0
+/**
+ * vcn_v5_0_0_disable_clock_gating_dpg_mode - disable VCN clock gating dpg mode
+ *
+ * @adev: amdgpu_device pointer
+ * @sram_sel: sram select
+ * @inst_idx: instance number index
+ * @indirect: indirectly write sram
+ *
+ * Disable clock gating for VCN block with dpg mode
+ */
+static void vcn_v5_0_0_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel,
+	int inst_idx, uint8_t indirect)
+{
+	return;
+}
+#endif
+
+/**
+ * vcn_v5_0_0_enable_clock_gating - enable VCN clock gating
+ *
+ * @adev: amdgpu_device pointer
+ * @inst: instance number
+ *
+ * Enable clock gating for VCN block
+ */
+static void vcn_v5_0_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
+{
+	return;
+}
+
+/**
+ * vcn_v5_0_0_start_dpg_mode - VCN start with dpg mode
+ *
+ * @adev: amdgpu_device pointer
+ * @inst_idx: instance number index
+ * @indirect: indirectly write sram
+ *
+ * Start VCN block with dpg mode
+ */
+static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+{
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+	struct amdgpu_ring *ring;
+	uint32_t tmp;
+
+	/* disable register anti-hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 1,
+		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+
+	/* enable dynamic power gating mode */
+	tmp = RREG32_SOC15(VCN, inst_idx, regUVD_POWER_STATUS);
+	tmp |= UVD_POWER_STATUS__UVD_PG_MODE_MASK;
+	tmp |= UVD_POWER_STATUS__UVD_PG_EN_MASK;
+	WREG32_SOC15(VCN, inst_idx, regUVD_POWER_STATUS, tmp);
+
+	if (indirect)
+		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
+
+	/* enable VCPU clock */
+	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
+	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK | UVD_VCPU_CNTL__BLK_RST_MASK;
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, inst_idx, regUVD_VCPU_CNTL), tmp, 0, indirect);
+
+	/* disable master interrupt */
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, inst_idx, regUVD_MASTINT_EN), 0, 0, indirect);
+
+	/* setup regUVD_LMI_CTRL */
+	tmp = (UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+		UVD_LMI_CTRL__REQ_MODE_MASK |
+		UVD_LMI_CTRL__CRC_RESET_MASK |
+		UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK |
+		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
+		0x00100000L);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, inst_idx, regUVD_LMI_CTRL), tmp, 0, indirect);
+
+	vcn_v5_0_0_mc_resume_dpg_mode(adev, inst_idx, indirect);
+
+	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
+	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, inst_idx, regUVD_VCPU_CNTL), tmp, 0, indirect);
+
+	/* enable LMI MC and UMC channels */
+	tmp = 0x1f << UVD_LMI_CTRL2__RE_OFLD_MIF_WR_REQ_NUM__SHIFT;
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, inst_idx, regUVD_LMI_CTRL2), tmp, 0, indirect);
+
+	/* enable master interrupt */
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, inst_idx, regUVD_MASTINT_EN),
+		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
+
+	if (indirect)
+		amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
+
+	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
+
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_LO, ring->gpu_addr);
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_SIZE, ring->ring_size / 4);
+
+	tmp = RREG32_SOC15(VCN, inst_idx, regVCN_RB_ENABLE);
+	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
+	WREG32_SOC15(VCN, inst_idx, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR, 0);
+
+	tmp = RREG32_SOC15(VCN, inst_idx, regUVD_RB_RPTR);
+	WREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR, tmp);
+	ring->wptr = RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR);
+
+	tmp = RREG32_SOC15(VCN, inst_idx, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
+	WREG32_SOC15(VCN, inst_idx, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
+
+	WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
+		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+		VCN_RB1_DB_CTRL__EN_MASK);
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_0_start - VCN start
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Start VCN block
+ */
+static int vcn_v5_0_0_start(struct amdgpu_device *adev)
+{
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	struct amdgpu_ring *ring;
+	uint32_t tmp;
+	int i, j, k, r;
+
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_uvd(adev, true);
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+			r = vcn_v5_0_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
+			continue;
+		}
+
+		/* disable VCN power gating */
+		vcn_v5_0_0_disable_static_power_gating(adev, i);
+
+		/* set VCN status busy */
+		tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+		WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
+
+		/* enable VCPU clock */
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
+			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
+
+		/* disable master interrupt */
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
+			~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+		/* enable LMI MC and UMC channels */
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
+			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+
+		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
+		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
+
+		/* setup regUVD_LMI_CTRL */
+		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
+		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
+			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+		vcn_v5_0_0_mc_resume(adev, i);
+
+		/* VCN global tiling registers */
+		WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
+			adev->gfx.config.gb_addr_config);
+
+		/* unblock VCPU register access */
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
+			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+		/* release VCPU reset to boot */
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+		for (j = 0; j < 10; ++j) {
+			uint32_t status;
+
+			for (k = 0; k < 100; ++k) {
+				status = RREG32_SOC15(VCN, i, regUVD_STATUS);
+				if (status & 2)
+					break;
+				mdelay(10);
+				if (amdgpu_emu_mode == 1)
+					msleep(1);
+			}
+
+			if (amdgpu_emu_mode == 1) {
+				r = -1;
+				if (status & 2) {
+					r = 0;
+					break;
+				}
+			} else {
+				r = 0;
+				if (status & 2)
+					break;
+
+				dev_err(adev->dev,
+					"VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
+				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
+							UVD_VCPU_CNTL__BLK_RST_MASK,
+							~UVD_VCPU_CNTL__BLK_RST_MASK);
+				mdelay(10);
+				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
+							~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+				mdelay(10);
+				r = -1;
+			}
+		}
+
+		if (r) {
+			dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
+			return r;
+		}
+
+		/* enable master interrupt */
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
+				UVD_MASTINT_EN__VCPU_EN_MASK,
+				~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+		/* clear the busy bit of VCN_STATUS */
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
+			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+
+		ring = &adev->vcn.inst[i].ring_enc[0];
+		WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
+			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+			VCN_RB1_DB_CTRL__EN_MASK);
+
+		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
+		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
+
+		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
+		tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
+		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
+		fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
+		WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
+		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
+
+		tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
+		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
+		ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
+
+		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
+		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
+		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
+		fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
+	}
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_0_stop_dpg_mode - VCN stop with dpg mode
+ *
+ * @adev: amdgpu_device pointer
+ * @inst_idx: instance number index
+ *
+ * Stop VCN block with dpg mode
+ */
+static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+{
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
+	uint32_t tmp;
+
+	vcn_v5_0_0_pause_dpg_mode(adev, inst_idx, &state);
+
+	/* Wait for power status to be 1 */
+	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 1,
+		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+
+	/* wait for read ptr to be equal to write ptr */
+	tmp = RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR);
+	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_RB_RPTR, tmp, 0xFFFFFFFF);
+
+	/* disable dynamic power gating mode */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 0,
+		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+
+	return;
+}
+
+/**
+ * vcn_v5_0_0_stop - VCN stop
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Stop VCN block
+ */
+static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
+{
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	uint32_t tmp;
+	int i, r = 0;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
+
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+			vcn_v5_0_0_stop_dpg_mode(adev, i);
+			continue;
+		}
+
+		/* wait for vcn idle */
+		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+		if (r)
+			return r;
+
+		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		      UVD_LMI_STATUS__READ_CLEAN_MASK |
+		      UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		      UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
+		if (r)
+			return r;
+
+		/* disable LMI UMC channel */
+		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
+		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
+		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
+		      UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
+		if (r)
+			return r;
+
+		/* block VCPU register access */
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
+			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+		/* reset VCPU */
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
+			UVD_VCPU_CNTL__BLK_RST_MASK,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+		/* disable VCPU clock */
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
+			~(UVD_VCPU_CNTL__CLK_EN_MASK));
+
+		/* apply soft reset */
+		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
+		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
+		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
+
+		/* clear status */
+		WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
+
+		/* enable VCN power gating */
+		vcn_v5_0_0_enable_static_power_gating(adev, i);
+	}
+
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_uvd(adev, false);
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_0_pause_dpg_mode - VCN pause with dpg mode
+ *
+ * @adev: amdgpu_device pointer
+ * @inst_idx: instance number index
+ * @new_state: pause state
+ *
+ * Pause dpg mode for VCN block
+ */
+static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
+	struct dpg_pause_state *new_state)
+{
+	uint32_t reg_data = 0;
+	int ret_code;
+
+	/* pause/unpause if state is changed */
+	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {
+		DRM_DEV_DEBUG(adev->dev, "dpg pause state changed %d -> %d",
+			adev->vcn.inst[inst_idx].pause_state.fw_based,  new_state->fw_based);
+		reg_data = RREG32_SOC15(VCN, inst_idx, regUVD_DPG_PAUSE) &
+			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+
+		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
+			ret_code = SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 0x1,
+					UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+
+			if (!ret_code) {
+				/* pause DPG */
+				reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+				WREG32_SOC15(VCN, inst_idx, regUVD_DPG_PAUSE, reg_data);
+
+				/* wait for ACK */
+				SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_DPG_PAUSE,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+			}
+		} else {
+			/* unpause dpg, no need to wait */
+			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+			WREG32_SOC15(VCN, inst_idx, regUVD_DPG_PAUSE, reg_data);
+		}
+		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
+	}
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_0_unified_ring_get_rptr - get unified read pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware unified read pointer
+ */
+static uint64_t vcn_v5_0_0_unified_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
+		DRM_ERROR("wrong ring id is identified in %s", __func__);
+
+	return RREG32_SOC15(VCN, ring->me, regUVD_RB_RPTR);
+}
+
+/**
+ * vcn_v5_0_0_unified_ring_get_wptr - get unified write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware unified write pointer
+ */
+static uint64_t vcn_v5_0_0_unified_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
+		DRM_ERROR("wrong ring id is identified in %s", __func__);
+
+	if (ring->use_doorbell)
+		return *ring->wptr_cpu_addr;
+	else
+		return RREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR);
+}
+
+/**
+ * vcn_v5_0_0_unified_ring_set_wptr - set enc write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Commits the enc write pointer to the hardware
+ */
+static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
+		DRM_ERROR("wrong ring id is identified in %s", __func__);
+
+	if (ring->use_doorbell) {
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
+	} else {
+		WREG32_SOC15(VCN, ring->me, regUVD_RB_WPTR, lower_32_bits(ring->wptr));
+	}
+}
+
+static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
+	.type = AMDGPU_RING_TYPE_VCN_ENC,
+	.align_mask = 0x3f,
+	.nop = VCN_ENC_CMD_NO_OP,
+	.get_rptr = vcn_v5_0_0_unified_ring_get_rptr,
+	.get_wptr = vcn_v5_0_0_unified_ring_get_wptr,
+	.set_wptr = vcn_v5_0_0_unified_ring_set_wptr,
+	.emit_frame_size =
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
+		4 + /* vcn_v2_0_enc_ring_emit_vm_flush */
+		5 + 5 + /* vcn_v2_0_enc_ring_emit_fence x2 vm fence */
+		1, /* vcn_v2_0_enc_ring_insert_end */
+	.emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
+	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
+	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
+	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
+	.test_ring = amdgpu_vcn_enc_ring_test_ring,
+	.test_ib = amdgpu_vcn_unified_ring_test_ib,
+	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_end = vcn_v2_0_enc_ring_insert_end,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.begin_use = amdgpu_vcn_ring_begin_use,
+	.end_use = amdgpu_vcn_ring_end_use,
+	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
+	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+};
+
+/**
+ * vcn_v5_0_0_set_unified_ring_funcs - set unified ring functions
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set unified ring functions
+ */
+static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v5_0_0_unified_ring_vm_funcs;
+		adev->vcn.inst[i].ring_enc[0].me = i;
+
+		DRM_INFO("VCN(%d) encode/decode are enabled in VM mode\n", i);
+	}
+}
+
+/**
+ * vcn_v5_0_0_is_idle - check VCN block is idle
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Check whether VCN block is idle
+ */
+static bool vcn_v5_0_0_is_idle(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i, ret = 1;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		ret &= (RREG32_SOC15(VCN, i, regUVD_STATUS) == UVD_STATUS__IDLE);
+	}
+
+	return ret;
+}
+
+/**
+ * vcn_v5_0_0_wait_for_idle - wait for VCN block idle
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Wait for VCN block idle
+ */
+static int vcn_v5_0_0_wait_for_idle(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i, ret = 0;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		ret = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE,
+			UVD_STATUS__IDLE);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+/**
+ * vcn_v5_0_0_set_clockgating_state - set VCN block clockgating state
+ *
+ * @handle: amdgpu_device pointer
+ * @state: clock gating state
+ *
+ * Set VCN block clockgating state
+ */
+static int vcn_v5_0_0_set_clockgating_state(void *handle, enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+	int i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		if (enable) {
+			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
+				return -EBUSY;
+			vcn_v5_0_0_enable_clock_gating(adev, i);
+		} else {
+			vcn_v5_0_0_disable_clock_gating(adev, i);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_0_set_powergating_state - set VCN block powergating state
+ *
+ * @handle: amdgpu_device pointer
+ * @state: power gating state
+ *
+ * Set VCN block powergating state
+ */
+static int vcn_v5_0_0_set_powergating_state(void *handle, enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int ret;
+
+	if (state == adev->vcn.cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v5_0_0_stop(adev);
+	else
+		ret = vcn_v5_0_0_start(adev);
+
+	if (!ret)
+		adev->vcn.cur_state = state;
+
+	return ret;
+}
+
+/**
+ * vcn_v5_0_0_set_interrupt_state - set VCN block interrupt state
+ *
+ * @adev: amdgpu_device pointer
+ * @source: interrupt sources
+ * @type: interrupt types
+ * @state: interrupt states
+ *
+ * Set VCN block interrupt state
+ */
+static int vcn_v5_0_0_set_interrupt_state(struct amdgpu_device *adev, struct amdgpu_irq_src *source,
+	unsigned type, enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
+/**
+ * vcn_v5_0_0_process_interrupt - process VCN block interrupt
+ *
+ * @adev: amdgpu_device pointer
+ * @source: interrupt sources
+ * @entry: interrupt entry from clients and sources
+ *
+ * Process VCN block interrupt
+ */
+static int vcn_v5_0_0_process_interrupt(struct amdgpu_device *adev, struct amdgpu_irq_src *source,
+	struct amdgpu_iv_entry *entry)
+{
+	uint32_t ip_instance;
+
+	switch (entry->client_id) {
+	case SOC15_IH_CLIENTID_VCN:
+		ip_instance = 0;
+		break;
+	case SOC15_IH_CLIENTID_VCN1:
+		ip_instance = 1;
+		break;
+	default:
+		DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
+		return 0;
+	}
+
+	DRM_DEBUG("IH: VCN TRAP\n");
+
+	switch (entry->src_id) {
+	case VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
+		amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[0]);
+		break;
+	case VCN_4_0__SRCID_UVD_POISON:
+		amdgpu_vcn_process_poison_irq(adev, source, entry);
+		break;
+	default:
+		DRM_ERROR("Unhandled interrupt: %d %d\n",
+			  entry->src_id, entry->src_data[0]);
+		break;
+	}
+
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs vcn_v5_0_0_irq_funcs = {
+	.set = vcn_v5_0_0_set_interrupt_state,
+	.process = vcn_v5_0_0_process_interrupt,
+};
+
+/**
+ * vcn_v5_0_0_set_irq_funcs - set VCN block interrupt irq functions
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set VCN block interrupt irq functions
+ */
+static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
+		adev->vcn.inst[i].irq.funcs = &vcn_v5_0_0_irq_funcs;
+	}
+}
+
+static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
+	.name = "vcn_v5_0_0",
+	.early_init = vcn_v5_0_0_early_init,
+	.late_init = NULL,
+	.sw_init = vcn_v5_0_0_sw_init,
+	.sw_fini = vcn_v5_0_0_sw_fini,
+	.hw_init = vcn_v5_0_0_hw_init,
+	.hw_fini = vcn_v5_0_0_hw_fini,
+	.suspend = vcn_v5_0_0_suspend,
+	.resume = vcn_v5_0_0_resume,
+	.is_idle = vcn_v5_0_0_is_idle,
+	.wait_for_idle = vcn_v5_0_0_wait_for_idle,
+	.check_soft_reset = NULL,
+	.pre_soft_reset = NULL,
+	.soft_reset = NULL,
+	.post_soft_reset = NULL,
+	.set_clockgating_state = vcn_v5_0_0_set_clockgating_state,
+	.set_powergating_state = vcn_v5_0_0_set_powergating_state,
+};
+
+const struct amdgpu_ip_block_version vcn_v5_0_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_VCN,
+	.major = 5,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &vcn_v5_0_0_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h
new file mode 100644
index 000000000000..51bbccd4360f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h
@@ -0,0 +1,37 @@
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
+#ifndef __VCN_V5_0_0_H__
+#define __VCN_V5_0_0_H__
+
+#define VCN_VID_SOC_ADDRESS                        0x1FC00
+#define VCN_AON_SOC_ADDRESS                        0x1F800
+#define VCN1_VID_SOC_ADDRESS                       0x48300
+#define VCN1_AON_SOC_ADDRESS                       0x48000
+
+#define VCN_VID_IP_ADDRESS                         0x0
+#define VCN_AON_IP_ADDRESS                         0x30000
+
+extern const struct amdgpu_ip_block_version vcn_v5_0_0_ip_block;
+
+#endif /* __VCN_V5_0_0_H__ */
-- 
2.42.0

