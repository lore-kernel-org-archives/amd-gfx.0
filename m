Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65621C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F83B10ED87;
	Tue,  3 May 2022 20:43:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724E710E66F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCRiGE/Y8omH5UntJLl94ODmvSdIf0c1p6wNYCy0sxXT/EIPcerUqU7d3HnMhkzbfMJsMLudSidsWQijIEqtBHcsD9QOnLw6+L5VS8kr7CSrss4/ji2oCH36ZW54/wocPRI5cvWKm/D1K2RGj9Zo/FD2q1ozFYY9k+WnoOMVM5e2s11Ir9xxn7ZK6Yx4NwlmlZERpk4u7NasNu1Km2p1zo7UFvpYjeW3OnSNfC0RhmbOMYVddvpn8uyHuTNCDesqOxDpN5q+ioaXYFg3qsk/kqu7Fc6BastnoKVw8CyxAsp1wUjqg7/9YJoUrJUZQUIr8RHhpsRp4jHRPIXqntMpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+QL0k/5MnMxnk2AporxMNT+x+md70TCaNSMqGs9ypY=;
 b=P04q65FsRqpqpWBY6ghArwGZHJk/ISif4MuX9sKVJ0aozrWXZi9ybuxSLknQXcp86Ln5+7Uud8+GDf6WYiaga9S7KQAFaDI5oSSBtsPratQLeuoxHQracda1F5+cVUFCbhcKdnuDAVSXJyzEeOnEgTlkjeGZvlkBSXmta+xpA8zxje0ocv0rAoisMMSAWqqnEssOmAE2mWSbCXVBwzMtHsioDJxAtW8330EI9VdlNWPZFnLOCEo7lSGeE9g3rUbfNK+KauI7n+m0wbD2U5IUznVTGTSWStLOcqYHXmj5NmyeuS85LlK+zGiVeMC7CkwiSLTXks2Mu97vJF7s3f7Byw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+QL0k/5MnMxnk2AporxMNT+x+md70TCaNSMqGs9ypY=;
 b=5qUEmyvWWC619w4PJCVxzb7NyUPnjWJyEXfF9FefQbZrKV4mQnahBDJ/wxJrmTmOhfDqbnzoKXaZZfX39GcEcZzk/M12PclyD55NFCpV0EYtgeElDX07PbKb9AzStcpILXvHnAuT43jEGqYksuSlOexpyopppQk1liAg3YrGCYk=
Received: from BN9PR03CA0508.namprd03.prod.outlook.com (2603:10b6:408:130::33)
 by BN6PR1201MB2547.namprd12.prod.outlook.com (2603:10b6:404:aa::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:43:37 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::20) by BN9PR03CA0508.outlook.office365.com
 (2603:10b6:408:130::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:43:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:43:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: add the files of NBIO v7.7 block
Date: Tue, 3 May 2022 16:43:13 -0400
Message-ID: <20220503204314.1250729-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503204314.1250729-1-alexander.deucher@amd.com>
References: <20220503204314.1250729-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 283f9710-ce85-4f71-0bf1-08da2d45993a
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2547:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2547A972869709636D2307BAF7C09@BN6PR1201MB2547.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NvJQp8DvrfsIllBsmUWi9yJne2NOGSYrAcLOygE+sRYubPxy3LPVO7nXx4wbf71/csH4Mu2+kFmVUMaAVShMWlUNRmeox2NykXXbIyIC7tDoqEfUK8vJPnU4fPLHivIj8uZKra+1teq5log53uYsq71AJySmh7l3axH0pthVqlN+ok96TXpx94t6plDDW556kwCyaglL0CL/tdBsDgGX4e2Srjk+q48BGd8kOg23dW7sMMqIrvV0dZpEMO9elNooytWOmbc4U13IQStB1Ek5D+NTGtRn7EHlNCMdvfO6a8RWwgsTMwAl+Tc/AhHzCJyM0T3j5awB0VYoFt1klpajxTmlMAJFsQfK959Mq6NhOnTOIoFYWEHIDAKD5FB/WjuUGRGDVzH1cc48YzwEVi0o5BBeZX2u5SMIRKrOwZdhlOd5XDjMayyxFCDr7OUAICz30xVm+5pVMK6Lx/V6EvS18449X6cD5YyTk89wneY+iJYKiAKg20EWAnec5X2PwSyj8dj8L3fte4r4cz6guhmOeGi4rnvIG5QteLd6KDs1neDli3QGATD9L1aR8jM+3LcA4o1PqflVuHhEdiLrjdeqIXn5w8bg10l50fqNIp4o8th+AU5WzHhzpq820xU3hEqwXXnz0TSrrI8PbVGT2YInClK+5xGKM+mPpdGvKIjLVEPuDYxoNhKZ+9xgc7iHwsstyjgSOlZ72OpYkVNxX48V+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(508600001)(186003)(40460700003)(70586007)(36860700001)(70206006)(1076003)(8676002)(4326008)(6666004)(356005)(26005)(16526019)(7696005)(47076005)(426003)(336012)(81166007)(54906003)(316002)(83380400001)(86362001)(36756003)(30864003)(82310400005)(8936002)(5660300002)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:43:37.2276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 283f9710-ce85-4f71-0bf1-08da2d45993a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2547
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch is to add the files of NBIO v7.7 block.
NBIO (New Bus IO) is the block which handles
the GPU interface to the PCIe bus.

v2: squash in register name fix (Xiaojian)

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |   2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 241 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.h |  33 ++++
 3 files changed, 275 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index d4e7d297f883..f2d64b156ba4 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -75,7 +75,7 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o \
-	nbio_v4_3.o hdp_v6_0.o
+	nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
new file mode 100644
index 000000000000..e32c874b42b5
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -0,0 +1,241 @@
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
+#include "nbio_v7_7.h"
+
+#include "nbio/nbio_7_7_0_offset.h"
+#include "nbio/nbio_7_7_0_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static u32 nbio_v7_7_get_rev_id(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
+
+	tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
+	tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
+
+	return tmp;
+}
+
+static void nbio_v7_7_mc_access_enable(struct amdgpu_device *adev, bool enable)
+{
+	if (enable)
+		WREG32_SOC15(NBIO, 0, regBIF_BX1_BIF_FB_EN,
+			BIF_BX1_BIF_FB_EN__FB_READ_EN_MASK |
+			BIF_BX1_BIF_FB_EN__FB_WRITE_EN_MASK);
+	else
+		WREG32_SOC15(NBIO, 0, regBIF_BX1_BIF_FB_EN, 0);
+}
+
+static u32 nbio_v7_7_get_memsize(struct amdgpu_device *adev)
+{
+	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_0_RCC_CONFIG_MEMSIZE);
+}
+
+static void nbio_v7_7_sdma_doorbell_range(struct amdgpu_device *adev, int instance,
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
+static void nbio_v7_7_enable_doorbell_aperture(struct amdgpu_device *adev,
+					       bool enable)
+{
+	u32 reg;
+
+	reg = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_0_RCC_DOORBELL_APER_EN);
+	reg = REG_SET_FIELD(reg, RCC_DEV0_EPF0_0_RCC_DOORBELL_APER_EN,
+			    BIF_DOORBELL_APER_EN, enable ? 1 : 0);
+
+	WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_0_RCC_DOORBELL_APER_EN, reg);
+}
+
+static void nbio_v7_7_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
+							bool enable)
+{
+	u32 tmp = 0;
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
+}
+
+
+static void nbio_v7_7_ih_doorbell_range(struct amdgpu_device *adev,
+					bool use_doorbell, int doorbell_index)
+{
+	u32 ih_doorbell_range = RREG32_SOC15(NBIO, 0,
+								regGDC0_BIF_IH_DOORBELL_RANGE);
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
+static void nbio_v7_7_ih_control(struct amdgpu_device *adev)
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
+static u32 nbio_v7_7_get_hdp_flush_req_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ);
+}
+
+static u32 nbio_v7_7_get_hdp_flush_done_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE);
+}
+
+static u32 nbio_v7_7_get_pcie_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX2);
+}
+
+static u32 nbio_v7_7_get_pcie_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_DATA2);
+}
+
+static u32 nbio_v7_7_get_pcie_port_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX);
+}
+
+static u32 nbio_v7_7_get_pcie_port_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA);
+}
+
+const struct nbio_hdp_flush_reg nbio_v7_7_hdp_flush_reg = {
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
+static void nbio_v7_7_init_registers(struct amdgpu_device *adev)
+{
+	uint32_t def, data;
+
+		def = data = RREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3);
+		data = REG_SET_FIELD(data, BIF0_PCIE_MST_CTRL_3,
+			CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
+		data = REG_SET_FIELD(data, BIF0_PCIE_MST_CTRL_3,
+			CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
+
+		if (def != data)
+			WREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3, data);
+
+}
+
+const struct amdgpu_nbio_funcs nbio_v7_7_funcs = {
+	.get_hdp_flush_req_offset = nbio_v7_7_get_hdp_flush_req_offset,
+	.get_hdp_flush_done_offset = nbio_v7_7_get_hdp_flush_done_offset,
+	.get_pcie_index_offset = nbio_v7_7_get_pcie_index_offset,
+	.get_pcie_data_offset = nbio_v7_7_get_pcie_data_offset,
+	.get_pcie_port_index_offset = nbio_v7_7_get_pcie_port_index_offset,
+	.get_pcie_port_data_offset = nbio_v7_7_get_pcie_port_data_offset,
+	.get_rev_id = nbio_v7_7_get_rev_id,
+	.mc_access_enable = nbio_v7_7_mc_access_enable,
+	.get_memsize = nbio_v7_7_get_memsize,
+	.sdma_doorbell_range = nbio_v7_7_sdma_doorbell_range,
+	.enable_doorbell_aperture = nbio_v7_7_enable_doorbell_aperture,
+	.enable_doorbell_selfring_aperture = nbio_v7_7_enable_doorbell_selfring_aperture,
+	.ih_doorbell_range = nbio_v7_7_ih_doorbell_range,
+	.ih_control = nbio_v7_7_ih_control,
+	.init_registers = nbio_v7_7_init_registers,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.h b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.h
new file mode 100644
index 000000000000..2a33b256ba81
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.h
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
+#ifndef __NBIO_V7_7_H__
+#define __NBIO_V7_7_H__
+
+#include "soc15_common.h"
+
+extern const struct nbio_hdp_flush_reg nbio_v7_7_hdp_flush_reg;
+extern const struct amdgpu_nbio_funcs nbio_v7_7_funcs;
+extern const struct amdgpu_nbio_ras_funcs nbio_v7_7_ras_funcs;
+
+#endif
-- 
2.35.1

