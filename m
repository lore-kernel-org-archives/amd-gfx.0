Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD142C27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB6810E3D8;
	Wed, 16 Aug 2023 21:52:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDC9A10E3D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpm5YpMWePS7Y2wTH6emR3EQUuBymNy60ae6Wyc550pBC0Eru4WhvXFH0Mtpu8VwEqa3SQdpuNuRMA2XmhrGj8tGRyd46ruKND3ozkxBovw0uqWvtmHHc4gUKC9dyrB6fLt+GxNNDyIzIckxnElghC+MdH2FPFQmoHz/kPLMH9sQD0QSqP2xiMePJ/LIflTBdiAe0vo37xPYwZH+MPtakHfATZX/FTa0i6NTjkSj13mQtRAuXsLmztXNnwdO3XU1ymWKATF6yd/n7yqmKwjEYsf6cdMwwKJydYCcy4hB1KHnG+rVePv0GDuamZ+dJOw3rwOK0yz0+3fj7qcwqfNFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZCQnSNbBmSu74IxjLrLZPyM+KzCOUjqudBgUdmD9rM=;
 b=MbF4dWjOJfqlH418TGAyXHSyb3tuLs3sFWnEqrPfztibbalBk51xPll34lJLBe8LvdfozujoqtPdy7/StRMb5MzhA6Yr2HF16ahlcixrE2Uz6Cy0c9HBV/yh+UmYuVgxJddnxBayUYGok7Bt/PpDjZG22QSiypuuATN/+AnThOH65rQf13arRBD3M9Q7H9/DyIH2DYbgUroCzi2BbAXmlRGJ9EGfVm0m9Q6JgwlnNMRF1NsopYX1kIakMMZiX5V0gyXgOHyx9ZQK9MYz159PWd80wR+rKZh7PlXP65ojqbeuSu470Wt18NLOaxzsjrGtG7L2e596dQb8zg8rEIS70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZCQnSNbBmSu74IxjLrLZPyM+KzCOUjqudBgUdmD9rM=;
 b=4HlA8muPzWUTAAFomAp6CkfCC1ZHOZSggPjBkhVb4T8uTsd1XqRPq5lmAt7AdtiNq+QtU+4+f3EEKTq0DgGBGdI3vQ2g1i1olgM77pOA4mfq0fHXJeIczEnE+Gy5UtVNuBlI/zufGq0IrCz0FHtwSaqf+J7+HRJCXm5I5Zy5rkw=
Received: from MW2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:907::45) by
 MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Wed, 16 Aug 2023 21:52:17 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::df) by MW2PR16CA0032.outlook.office365.com
 (2603:10b6:907::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 21:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 21:52:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:52:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add nbio 7.11 support
Date: Wed, 16 Aug 2023 17:51:57 -0400
Message-ID: <20230816215158.826684-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816215158.826684-1-alexander.deucher@amd.com>
References: <20230816215158.826684-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: c413462c-4231-46d5-f939-08db9ea30ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sTNcwIwC7Ed/iKJiar5vjShjOgLHA6Vtc0GVROM3fqpiJaW8IRgqSDfSRAZQT7mpcMep4ed8F6hreyVQpOiJysl67DreMgLC1PMEZn7CcwD2lrj0Ro3YMY+hAu8sAOdcFw2CdAx5xE+a+sZTqwzqaO51jNBge34Rrx0/6qdHPXaHrbaob3s/4AziihbOhwwEzuQlVnVMK9czW4oW1QDfWPtvcdOcRYN+vTLNtaMXbUER7Bnm4fOo2tTGH1e6zPf5jyzcB4MqazsaSe+IFH/zE3YU3vA02jcySHCrDzLE3euF/ozcJd1zNWSSHlUs7X9kZFevpEfx5AhiUYnRuObMZf5fay60laCkqRcrjnsB2B1laC3uZwxySy7Oyawj1RH4GLTJTKJOJyLIcsBKoF4lWpOSDUk7HNjD4M2cSGg8KguowNlZQOKOQNVKjqxaxYaZ/AOWmttSvJbWPXWPGyz+g2pXVqqzb4Bvv+YNBaYgNAhKFs0HW48rmWf9wFlrF8jcchZsvBvGssQul/HKESINd6zc+jVmCZkXsvd67OYHcqzaV5/JWPzhYu6teHL1C/bIFfqxqjqF0liblo0sUjOpWeg8uHJtPIgSw2NFKMumDRyFFVUX/k8Ov+NEdtz/hvTjJ9NUNHsQEzY4CUxhSwbXIeEtMQhcvzWQ6Z0FK5SzsJuUPzgwPirtF6XnKrK7StOvE5KpHaCUHwizLHDWrlxnmrG3moKbJ74kucMagdOzY3di/gB1rBPSVftcuUtVjgKWsmJlExASvsDx2+Smv3KLrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(54906003)(356005)(82740400003)(6916009)(81166007)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(47076005)(8676002)(4326008)(8936002)(66899024)(30864003)(2906002)(40460700003)(83380400001)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(6666004)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:52:16.8526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c413462c-4231-46d5-f939-08db9ea30ee6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
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
Cc: Alex Deucher <alexander.deucher@amd.com>, benl <ben.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: benl <ben.li@amd.com>

Add initial nbio 7.11 implementation.

Signed-off-by: benl <ben.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |   2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c | 243 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.h |  33 ++++
 3 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 384b798a9bad..4add30ca2897 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -98,7 +98,7 @@ amdgpu-y += \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
-	nbio_v7_9.o aqua_vanjaram.o
+	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
new file mode 100644
index 000000000000..7c08e5f95e97
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -0,0 +1,243 @@
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
+#include "amdgpu.h"
+#include "amdgpu_atombios.h"
+#include "nbio_v7_11.h"
+
+#include "nbio/nbio_7_11_0_offset.h"
+#include "nbio/nbio_7_11_0_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static u32 nbio_v7_11_get_rev_id(struct amdgpu_device *adev)
+{
+	u32 tmp;
+         printk("%s, getid\n",__func__);
+
+		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP1_RCC_DEV0_EPF0_STRAP0);
+
+	tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
+	tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
+
+	return tmp;
+}
+
+static void nbio_v7_11_mc_access_enable(struct amdgpu_device *adev, bool enable)
+{
+	if (enable)
+		WREG32_SOC15(NBIO, 0, regBIF_BX1_BIF_FB_EN,
+			BIF_BX1_BIF_FB_EN__FB_READ_EN_MASK |
+			BIF_BX1_BIF_FB_EN__FB_WRITE_EN_MASK);
+	else
+		WREG32_SOC15(NBIO, 0, regBIF_BX1_BIF_FB_EN, 0);
+}
+
+static u32 nbio_v7_11_get_memsize(struct amdgpu_device *adev)
+{
+	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_0_RCC_CONFIG_MEMSIZE);
+}
+
+static void nbio_v7_11_sdma_doorbell_range(struct amdgpu_device *adev, int instance,
+					  bool use_doorbell, int doorbell_index,
+					  int doorbell_size)
+{
+	u32 reg = SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_SDMA0_DOORBELL_RANGE);
+	u32 doorbell_range = RREG32_PCIE_PORT(reg);
+
+	if (use_doorbell) {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_SDMA0_DOORBELL_RANGE,
+					       OFFSET, doorbell_index);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_SDMA0_DOORBELL_RANGE,
+					       SIZE, doorbell_size);
+	} else {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_SDMA0_DOORBELL_RANGE,
+					       SIZE, 0);
+	}
+
+	WREG32_PCIE_PORT(reg, doorbell_range);
+}
+
+static void nbio_v7_11_enable_doorbell_aperture(struct amdgpu_device *adev,
+					       bool enable)
+{
+	u32 reg;
+
+
+	reg = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_0_RCC_DOORBELL_APER_EN);
+	reg = REG_SET_FIELD(reg, RCC_DEV0_EPF0_0_RCC_DOORBELL_APER_EN,
+			    BIF_DOORBELL_APER_EN, enable ? 1 : 0);
+
+	WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_0_RCC_DOORBELL_APER_EN, reg);
+}
+
+static void nbio_v7_11_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
+							bool enable)
+{
+/*	u32 tmp = 0;
+
+	if (enable) {
+		tmp = REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				DOORBELL_SELFRING_GPA_APER_EN, 1) |
+			REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				DOORBELL_SELFRING_GPA_APER_MODE, 1) |
+			REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				DOORBELL_SELFRING_GPA_APER_SIZE, 0);
+
+		WREG32_SOC15(NBIO, 0,
+			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
+			lower_32_bits(adev->doorbell.base));
+		WREG32_SOC15(NBIO, 0,
+			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
+			upper_32_bits(adev->doorbell.base));
+	}
+
+	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+		tmp);
+*/
+}
+
+
+static void nbio_v7_11_ih_doorbell_range(struct amdgpu_device *adev,
+					bool use_doorbell, int doorbell_index)
+{    
+	u32 ih_doorbell_range = RREG32_SOC15(NBIO, 0,regGDC0_BIF_IH_DOORBELL_RANGE);
+
+	if (use_doorbell) {
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC0_BIF_IH_DOORBELL_RANGE, OFFSET,
+						  doorbell_index);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC0_BIF_IH_DOORBELL_RANGE, SIZE,
+						  2);
+	} else {
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC0_BIF_IH_DOORBELL_RANGE, SIZE,
+						  0);
+	}
+
+	WREG32_SOC15(NBIO, 0, regGDC0_BIF_IH_DOORBELL_RANGE,
+			 ih_doorbell_range);
+}
+
+static void nbio_v7_11_ih_control(struct amdgpu_device *adev)
+{
+	u32 interrupt_cntl;
+
+	/* setup interrupt control */
+	WREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL2,
+		     adev->dummy_page_addr >> 8);
+
+	interrupt_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL);
+	/*
+	 * INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=0 - dummy read disabled with msi, enabled without msi
+	 * INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=1 - dummy read controlled by IH_DUMMY_RD_EN
+	 */
+	interrupt_cntl = REG_SET_FIELD(interrupt_cntl, BIF_BX1_INTERRUPT_CNTL,
+				       IH_DUMMY_RD_OVERRIDE, 0);
+
+	/* INTERRUPT_CNTL__IH_REQ_NONSNOOP_EN_MASK=1 if ring is in non-cacheable memory, e.g., vram */
+	interrupt_cntl = REG_SET_FIELD(interrupt_cntl, BIF_BX1_INTERRUPT_CNTL,
+				       IH_REQ_NONSNOOP_EN, 0);
+
+	WREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL, interrupt_cntl);
+}
+
+static u32 nbio_v7_11_get_hdp_flush_req_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ);
+}
+
+static u32 nbio_v7_11_get_hdp_flush_done_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE);
+}
+
+static u32 nbio_v7_11_get_pcie_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX1_PCIE_INDEX2);
+}
+
+static u32 nbio_v7_11_get_pcie_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX1_PCIE_DATA2);
+}
+
+static u32 nbio_v7_11_get_pcie_port_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX);
+}
+
+static u32 nbio_v7_11_get_pcie_port_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA);
+}
+
+const struct nbio_hdp_flush_reg nbio_v7_11_hdp_flush_reg = {
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
+static void nbio_v7_11_init_registers(struct amdgpu_device *adev)
+{
+/*	uint32_t def, data;
+
+		def = data = RREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3);
+		data = REG_SET_FIELD(data, BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3,
+			CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
+		data = REG_SET_FIELD(data, BIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3,
+			CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
+
+		if (def != data)
+			WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3, data);
+*/
+}
+
+const struct amdgpu_nbio_funcs nbio_v7_11_funcs = {
+	.get_hdp_flush_req_offset = nbio_v7_11_get_hdp_flush_req_offset,
+	.get_hdp_flush_done_offset = nbio_v7_11_get_hdp_flush_done_offset,
+	.get_pcie_index_offset = nbio_v7_11_get_pcie_index_offset,
+	.get_pcie_data_offset = nbio_v7_11_get_pcie_data_offset,
+	.get_pcie_port_index_offset = nbio_v7_11_get_pcie_port_index_offset,
+	.get_pcie_port_data_offset = nbio_v7_11_get_pcie_port_data_offset,
+	.get_rev_id = nbio_v7_11_get_rev_id,
+	.mc_access_enable = nbio_v7_11_mc_access_enable,
+	.get_memsize = nbio_v7_11_get_memsize,
+	.sdma_doorbell_range = nbio_v7_11_sdma_doorbell_range,
+	.enable_doorbell_aperture = nbio_v7_11_enable_doorbell_aperture,
+	.enable_doorbell_selfring_aperture = nbio_v7_11_enable_doorbell_selfring_aperture,
+	.ih_doorbell_range = nbio_v7_11_ih_doorbell_range,
+	.ih_control = nbio_v7_11_ih_control,
+	.init_registers = nbio_v7_11_init_registers,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.h b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.h
new file mode 100644
index 000000000000..9d8258ed3f0a
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.h
@@ -0,0 +1,33 @@
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
+#ifndef __NBIO_V7_11_H__
+#define __NBIO_V7_11_H__
+
+#include "soc15_common.h"
+
+extern const struct nbio_hdp_flush_reg nbio_v7_11_hdp_flush_reg;
+extern const struct amdgpu_nbio_funcs nbio_v7_11_funcs;
+extern const struct amdgpu_nbio_ras_funcs nbio_v7_11_ras_funcs;
+
+#endif
-- 
2.41.0

