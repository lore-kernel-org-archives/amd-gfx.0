Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB24C624D3
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 10:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1662810E5DA;
	Sat,  5 Sep 2026 10:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q6Zn4OoS";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E105810E5DA
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 10:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXFnhT1lqZlTZU2dBcnmAFkn64HAr0/u9uosCI9EU/ZeqElYlEdXSVb1XKrHsGIAMQ/vcwSuT0Tg7p4q7xjVLSt4BVd7LCWvtkrgd1bAoZbaFfUeGoZMS9SDhGSbiLPSER72wSfyiwHgNshY+V84KtXyxoCIxlbnDt5Dp7z1MxYFJAJwlVoiA8fSO7zJDzrmFKrpg2P15XEGFnLQY2hh9cisaVE8S2j+aH7jWPKrDA4MY2+dpp6GWYrFPfaLXZWznjLMSJFcrq8z3omQ1g00xsnHdrI6LmS1qBTAwUxVR3tOf6N6sdQMoq20EdKVn1bm7Obrtj0PR4/UffDjlfcvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zqt+fniHtCyFUQwY+al4BAnw1Dh/Vte6Qs7Qdi2Wriw=;
 b=qIOQBQVx5EfVDN4jBiTq/1ZVSGvvTbMWLebf8JWcNCqYwu18pyZzMSRiDOFeZHBB7KTX1/T47YZAdQgrLd35InQ6U4gSmELiTEFutTBEPi9/LsgvnYJki2xFgGhr0nbV7ime0CGAr++TObMQmkAKk+EXjP7+lxDYuss8+/ysZ+WdSLqld/DDqCyk1aiLN6LYba0y+eT1blUjk2k3uQJR5P4EofZxGYO/19viFB31xw/P34wIOHD+I8FuyZY6egzFADTD1ofp+uzjraJB3YDtPKUGxqb1pj4YpYUXWhqA3Y56MugYbDc6Qc57n9SFdzENodqYkwwmTfkYKlAH0ZzbTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqt+fniHtCyFUQwY+al4BAnw1Dh/Vte6Qs7Qdi2Wriw=;
 b=Q6Zn4OoSBaBIse4O1DUelBFowJLLb2dFI8h8GbrKqt2Njv4nn3G1PbzcbC2JJNxQW88QNvvErWTPeQY01E88fbeVDEv6c29Q9zY2zi01B8yMCCE9DA31g/a0HyYQ6AJXXgU0/ZY6VRaoT0Z/Z2/OD3K+RrzL2area4SsIqJB/Tc=
Received: from DS1PR02CA0023.namprd02.prod.outlook.com (2603:10b6:8:44a::19)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 10:06:28 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:44a:cafe::16) by DS1PR02CA0023.outlook.office365.com
 (2603:10b6:8:44a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 10:06:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 10:06:27 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 05:06:26 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 10/13] drm/amdgpu: Add nbio v7_11_4 support
Date: Sat, 5 Sep 2026 18:05:35 +0800
Message-ID: <20260905100538.12877-11-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260905100538.12877-1-Hawking.Zhang@amd.com>
References: <20260905100538.12877-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: cebae66f-d6dd-490e-cebd-08df0b3559dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|11063799006|56012099006|3023799007|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: Lli+YmueN23EACKSosSS8wSIfzGoJUj5v6Te4VedJBSMG9aHufrMDwScgpw2uAibLBHcO+UrSJKjnsFRYPi8iE4B9LuF7UM0XWSb/wrnfPLy66DjIwmwi49LVY2XmkbNAOHUwz5iCj2Ru56GN8wEzT2mfuJnppQv3/uleOdySmbLLe4l/OZdZpIb4te5arB6kUb1LmpF25UsBUkU6hGcaKUdqAEkGG84B0l/0d/Lwr2Eo/D8NL1u9p997Ve6fpd9OSO3o0ijshNfBQz0k2nP99QZ3bvdxpCSIbOCxqxT9nuYAuW8yoBjjOQ+ZEUFjCcIAnlorZfPfNA873lCU4aF6krPVosb0qIvaYoFY9iplVNox88X5+U+faQyTCM4QfRxxdHMTOrPE1pEDa2umgVbczL220icifHz4ZY/wLHMn1/lRmKpK2OpnSVB5TAgFccbSSlZOZTg5wVSRCdeToZKkc13hyPk/3zLiqn4BrFfgNQpVOzs5D27jYapvUWjbeWq5dw7OAhZCKhubx+DPSadeA1lD8ZcoglZhmtjdW6N+9UY1h8oErJog64jBj+i9hzcBmAiIzzKTFcleH+b+2n30hcFjTd/lRNv/QgASq1Zjovhm0ky3PJxM/5re0d1R3EkP73pSf6pljEZMO/pPetP1YvPHQL4+wS6eN+OIEAb7b4QeFEMNSj7jV0LuXGqySn19QM3WtJ6FSgG7dr1RS0T3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(11063799006)(56012099006)(3023799007)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P/LKDavVWFeg0TvZIdcJ7hY8dcaRz/m3DDRE3tQIcpvL+v8T2Hli3qr6UpbX5VN9Y50OMW0ABKTYL/J+PLt4kf0BADN9UM7hzYh/JpNS/SOXMtGpFmOWx5/2yYKKVRHYgtEwpb22n2/eoqzqjiyzddrA3LTyu52u2qkVuKFql1bVdsXeJ5ADWVtz28QIeRs+c5uVk7kZ5K6qszRwYbwIHqdu9rUn8QxTxgYRgJC03v9vrJKZ0DRm6syaOOxgbNESozkzhl2C/+q1zEAvu/BDXSE+GjdxDjMoNB7rLe7onCsGeZ1muzl2FGCkaHEa3SaV2aAQaYSHryBsZMu9tIDdwhkqIn5SikY6Gow+GfNzgdrPoYxbUp3YbxK5W83XTy/cg4i6eNYBhmqEcMXOWaKdR09Ul0tKXrDlnBMy9N8mS59/eeXBdUnd/jAtCOch0bv/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:06:27.8165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cebae66f-d6dd-490e-cebd-08df0b3559dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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

nbio v7_11_4 uses different bif doorbell port registers than
nbif v6_3_1, and different HDP flush and memory coherency
registers than nbio v7_11_5.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile       |   3 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.c | 391 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.h |  32 ++
 3 files changed, 425 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 7b08814a24da..776b1f56ef61 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -91,7 +91,8 @@ amdgpu-y += \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o soc24.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
 	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o \
-	cyan_skillfish_reg_init.o soc_v1_0.o lsdma_v7_1.o nbio_v6_3_2.o nbio_v7_11_5.o
+	cyan_skillfish_reg_init.o soc_v1_0.o lsdma_v7_1.o nbio_v6_3_2.o nbio_v7_11_5.o \
+	nbio_v7_11_4.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.c
new file mode 100644
index 000000000000..8bae45c9ddfd
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.c
@@ -0,0 +1,391 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#include "amdgpu.h"
+#include "nbio_v7_11_4.h"
+
+#include "nbif/nbif_4_10_0_offset.h"
+#include "nbif/nbif_4_10_0_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void nbio_v7_11_4_remap_hdp_registers(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+}
+
+static u32 nbio_v7_11_4_get_rev_id(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+	tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
+	tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
+	tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
+
+	return tmp;
+}
+
+static void nbio_v7_11_4_mc_access_enable(struct amdgpu_device *adev, bool enable)
+{
+	if (enable)
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
+			     BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
+			     BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
+	else
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
+}
+
+static u32 nbio_v7_11_4_get_memsize(struct amdgpu_device *adev)
+{
+	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_0_RCC_CONFIG_MEMSIZE);
+}
+
+static void nbio_v7_11_4_sdma_doorbell_range(struct amdgpu_device *adev,
+					    int instance, bool use_doorbell,
+					    int doorbell_index,
+					    int doorbell_size)
+{
+	if (instance == 0) {
+		u32 doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL);
+
+		if (use_doorbell) {
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_ENABLE,
+						       0x1);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_AWID,
+						       0xe);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_RANGE_OFFSET,
+						       doorbell_index);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_RANGE_SIZE,
+						       doorbell_size);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_AWADDR_31_28_VALUE,
+						       0x3);
+		} else {
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_RANGE_SIZE,
+						       0);
+		}
+
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+			     doorbell_range);
+	}
+}
+
+static void nbio_v7_11_4_vcn_doorbell_range(struct amdgpu_device *adev,
+					   bool use_doorbell, int doorbell_index,
+					   int instance)
+{
+	u32 doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL);
+
+	if (instance)
+		return;
+
+	if (use_doorbell) {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_ENABLE,
+					       0x1);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_AWID,
+					       0x4);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_RANGE_OFFSET,
+					       doorbell_index);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_RANGE_SIZE,
+					       8);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_AWADDR_31_28_VALUE,
+					       0x4);
+	} else {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_RANGE_SIZE,
+					       0);
+	}
+
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+		     doorbell_range);
+}
+
+static void nbio_v7_11_4_vpe_doorbell_range(struct amdgpu_device *adev,
+					    int instance, bool use_doorbell,
+					    int doorbell_index,
+					    int doorbell_size)
+{
+	if (instance)
+		return;
+
+	u32 doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL);
+
+	if (use_doorbell) {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_ENABLE,
+					       0x1);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_AWID,
+					       0xf);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_RANGE_OFFSET,
+					       doorbell_index);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_RANGE_SIZE,
+					       doorbell_size);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_AWADDR_31_28_VALUE,
+					       0xf);
+	} else {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_RANGE_SIZE,
+					       0);
+	}
+
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
+}
+
+static void nbio_v7_11_4_gc_doorbell_init(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL, 0x30000007);
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL, 0x3000000d);
+}
+
+static void nbio_v7_11_4_enable_doorbell_aperture(struct amdgpu_device *adev,
+						 bool enable)
+{
+	WREG32_FIELD15_PREREG(NBIO, 0, RCC_DEV0_EPF0_RCC_DOORBELL_APER_EN,
+			BIF_DOORBELL_APER_EN, enable ? 1 : 0);
+}
+
+static void
+nbio_v7_11_4_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
+					      bool enable)
+{
+	u32 tmp = 0;
+
+	if (enable) {
+		tmp = REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				    DOORBELL_SELFRING_GPA_APER_EN, 1) |
+		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				    DOORBELL_SELFRING_GPA_APER_MODE, 1) |
+		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				    DOORBELL_SELFRING_GPA_APER_SIZE, 0);
+
+		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
+			     lower_32_bits(adev->doorbell.base));
+		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
+			     upper_32_bits(adev->doorbell.base));
+	}
+
+	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL, tmp);
+}
+
+static void nbio_v7_11_4_ih_doorbell_range(struct amdgpu_device *adev,
+					  bool use_doorbell, int doorbell_index)
+{
+	u32 ih_doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL);
+
+	if (use_doorbell) {
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_ENABLE,
+						  0x1);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_AWID,
+						  0x0);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_RANGE_OFFSET,
+						  doorbell_index);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_RANGE_SIZE,
+						  2);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
+						  0x0);
+	} else {
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_RANGE_SIZE,
+						  0);
+	}
+
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+		     ih_doorbell_range);
+}
+
+static void nbio_v7_11_4_ih_control(struct amdgpu_device *adev)
+{
+	u32 interrupt_cntl;
+
+	/* setup interrupt control */
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2, adev->dummy_page_addr >> 8);
+
+	interrupt_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL);
+	/*
+	 * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=0 - dummy read disabled with msi, enabled without msi
+	 * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=1 - dummy read controlled by IH_DUMMY_RD_EN
+	 */
+	interrupt_cntl = REG_SET_FIELD(interrupt_cntl, BIF_BX0_INTERRUPT_CNTL,
+				       IH_DUMMY_RD_OVERRIDE, 0);
+
+	/* BIF_BX0_INTERRUPT_CNTL__IH_REQ_NONSNOOP_EN_MASK=1 if ring is in non-cacheable memory, e.g., vram */
+	interrupt_cntl = REG_SET_FIELD(interrupt_cntl, BIF_BX0_INTERRUPT_CNTL,
+				       IH_REQ_NONSNOOP_EN, 0);
+
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL, interrupt_cntl);
+}
+
+static void
+nbio_v7_11_4_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+					     bool enable)
+{
+}
+
+static void
+nbio_v7_11_4_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+					    bool enable)
+{
+}
+
+static void
+nbio_v7_11_4_get_clockgating_state(struct amdgpu_device *adev,
+				  u64 *flags)
+{
+}
+
+static u32 nbio_v7_11_4_get_hdp_flush_req_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ);
+}
+
+static u32 nbio_v7_11_4_get_hdp_flush_done_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE);
+}
+
+static u32 nbio_v7_11_4_get_pcie_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX);
+}
+
+static u32 nbio_v7_11_4_get_pcie_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_DATA);
+}
+
+const struct nbio_hdp_flush_reg nbio_v7_11_4_hdp_flush_reg = {
+	.ref_and_mask_cp0 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP0_MASK,
+	.ref_and_mask_cp1 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP1_MASK,
+	.ref_and_mask_cp2 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP2_MASK,
+	.ref_and_mask_cp3 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP3_MASK,
+	.ref_and_mask_cp4 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP4_MASK,
+	.ref_and_mask_cp5 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP5_MASK,
+	.ref_and_mask_cp6 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP6_MASK,
+	.ref_and_mask_cp7 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP7_MASK,
+	.ref_and_mask_cp8 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP8_MASK,
+	.ref_and_mask_cp9 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP9_MASK,
+	.ref_and_mask_sdma0 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA0_MASK,
+	.ref_and_mask_sdma1 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA1_MASK,
+};
+
+static void nbio_v7_11_4_init_registers(struct amdgpu_device *adev)
+{
+	uint32_t data;
+
+	data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2);
+	data &= ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2_MASK;
+	WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
+}
+
+static u32 nbio_v7_11_4_get_rom_offset(struct amdgpu_device *adev)
+{
+	u32 data, rom_offset;
+
+	data = RREG32_SOC15(NBIO, 0, regREGS_ROM_OFFSET_CTRL);
+	rom_offset = REG_GET_FIELD(data, REGS_ROM_OFFSET_CTRL, ROM_OFFSET);
+
+	return rom_offset;
+}
+
+#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
+
+static void nbio_v7_11_4_set_reg_remap(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	} else {
+		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+			regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+		adev->rmmio_remap.bus_addr = 0;
+	}
+}
+
+const struct amdgpu_nbio_funcs nbio_v7_11_4_funcs = {
+	.get_hdp_flush_req_offset = nbio_v7_11_4_get_hdp_flush_req_offset,
+	.get_hdp_flush_done_offset = nbio_v7_11_4_get_hdp_flush_done_offset,
+	.get_pcie_index_offset = nbio_v7_11_4_get_pcie_index_offset,
+	.get_pcie_data_offset = nbio_v7_11_4_get_pcie_data_offset,
+	.get_rev_id = nbio_v7_11_4_get_rev_id,
+	.mc_access_enable = nbio_v7_11_4_mc_access_enable,
+	.get_memsize = nbio_v7_11_4_get_memsize,
+	.sdma_doorbell_range = nbio_v7_11_4_sdma_doorbell_range,
+	.vcn_doorbell_range = nbio_v7_11_4_vcn_doorbell_range,
+	.vpe_doorbell_range = nbio_v7_11_4_vpe_doorbell_range,
+	.gc_doorbell_init = nbio_v7_11_4_gc_doorbell_init,
+	.enable_doorbell_aperture = nbio_v7_11_4_enable_doorbell_aperture,
+	.enable_doorbell_selfring_aperture = nbio_v7_11_4_enable_doorbell_selfring_aperture,
+	.ih_doorbell_range = nbio_v7_11_4_ih_doorbell_range,
+	.update_medium_grain_clock_gating = nbio_v7_11_4_update_medium_grain_clock_gating,
+	.update_medium_grain_light_sleep = nbio_v7_11_4_update_medium_grain_light_sleep,
+	.get_clockgating_state = nbio_v7_11_4_get_clockgating_state,
+	.ih_control = nbio_v7_11_4_ih_control,
+	.init_registers = nbio_v7_11_4_init_registers,
+	.remap_hdp_registers = nbio_v7_11_4_remap_hdp_registers,
+	.get_rom_offset = nbio_v7_11_4_get_rom_offset,
+	.set_reg_remap = nbio_v7_11_4_set_reg_remap,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.h b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.h
new file mode 100644
index 000000000000..2757fb8ccfa9
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_4.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#ifndef __NBIO_V7_11_4_H__
+#define __NBIO_V7_11_4_H__
+
+#include "soc15_common.h"
+
+extern const struct nbio_hdp_flush_reg nbio_v7_11_4_hdp_flush_reg;
+extern const struct amdgpu_nbio_funcs nbio_v7_11_4_funcs;
+
+#endif
-- 
2.17.1

