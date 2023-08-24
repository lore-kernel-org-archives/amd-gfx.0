Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0F0C27C40
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3D910E5D9;
	Thu, 24 Aug 2023 21:53:23 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB11210E5CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqUYrUa5Int0qiWs+ClJfMhcB371gosgCEQm8ZOcQSoD8NUlMTmHj+DTrEh7O+PghCtZv+QJnYPYG/qhk1DaUsF8XZBMnN6cbzp1vQzTytxwJmkRNjYDrPK0TcVUFLHrcp2PIxzDtsBpdIHZQiciI/2oN6jyBTB6TkVCcUIe536SsGi6znAKp4PUueb3ZEpt25raC54SnPGvKKFLrZSMZSSEygha53GgI4Whc3GFR7PNZl/r6h7pvGQ7SEoztyrr0nteFk7a5in2OR9BlJUKV5fNpg1nJq/OL2vm70SoOoOAHkWC8kuGDrKgDK0CvS1vmAAu1nKepW+w8vKL5A/+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ud1B+Y/UomfjkKaMMkTiHizcbym9VLSo13kEDTRf1YA=;
 b=FLLcrkC/YDa9be7SBBDFM6IEMLcp0L5PoPl1FP0T61VfcAtMm2ZYXn1CTd6VOzc89X66QbKWkUAAqr+EKzjs3eMoMEp9KKjX2DC3QFL+huSeMaGEz0dbu8LrnrUa877obAavEqYVTvuE4Bq8/N9njTAfuXupJGCgMJGLbG7H+OPkLpEDPDAeM/KG06+t7Hnf0wx/b8zqYHfniM6fFQd65QCmthMh6m279YQdzR9batxLtrfgB3ArwkcDJzOwiueJBnUXnjgcdQX1mI6yj0PaxGsO1JU8HcwgqSZ4scceXSn0j2a/c5Acq5wVl4IMf+xRjEI9h1MRICC38iLQZwr1zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ud1B+Y/UomfjkKaMMkTiHizcbym9VLSo13kEDTRf1YA=;
 b=e4EJBb8eFP209GHkhESUhbCMdi2i62y63uy6jSCt8C+hMPvMN/Dxji1pMsyQhlIzUY/kMmGBPEgSrjW9qLDNu4N9nKXf7KSRNCqDkyZR0cOTF9kIbcjMNHiFlNYIY7ExRlumzP7C4n1/L7aiZajq/0+m/PrWgRO/lOAQdh8rS+o=
Received: from CYXPR02CA0046.namprd02.prod.outlook.com (2603:10b6:930:cc::13)
 by DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Thu, 24 Aug 2023 21:53:15 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::d1) by CYXPR02CA0046.outlook.office365.com
 (2603:10b6:930:cc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:53:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:53:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/9] drm/amdgpu/jpeg: add jpeg support for VCN4_0_5
Date: Thu, 24 Aug 2023 17:52:55 -0400
Message-ID: <20230824215301.2739707-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215301.2739707-1-alexander.deucher@amd.com>
References: <20230824215301.2739707-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd93d69-7bf9-49c3-e278-08dba4ec8543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +S6lQBtHiKNstBUAbn/p7Rm8qGd6fbZZ53haHIraQ+tboTsZ/7id+O8dnV/Bx95Y0sB2vaRBlglCK9vTPEy8Pw3K80vRKIcrjDKBomvWLzKz1zsT3lQQNW8QdBZFX8mj9sd1P7GvTsJhG3BO2p/TdGfJOuU2ssb41JDOQKUH/Ck0BwVEWaVlUXY4IPlwL56Z18D6TIZtwwGuSgpMrCE+Kx3zT2N/13E0hBhanWyE1Gdnzbe3hKdEnBqsv9Wm0qJDiJ4kWq6TWCPBxi5SMoeBBxszzWgIQYIVwUwkpalvfKhBOel0ZTfZkftbYjBsJHOQPSOfg8nsBX47mJ1KLCfDUJ0nfc6sC2cZfXjynNwVw5F5+WgC0Yhs1ByMOdMKZFAnNd4zAPbAvE7QrLSziw7psvkxMd6sp7EMnUA1KrJxly6c1ZhlDbPntKTQZAuoLFW/2dDhDFCIhkmvLs+swENARy5yxO61mD3Ll8SN55aIReorD2AMm6nJ2T6Y/yd+9VV3VXckQtHVPwLOxa98FbxezI10J7EJBH2O4qcbHAcsA9cF2ztbM9IQ8S/lV1stxa8F8mOC4UNvBmoHFiNj7rIyzdYFqbflrpfJlsjfohykrtWcWa8DzfM3T9ZVsOcitGSgMtDblnEDgt9fqb9pGSIFDsQwmrN40UNifMODZbQ26C73J/WnAyqsUg8Zni6976vGxGAOorFD3Ig45we+/BRDdveTz0DsJThLgEJg/+VrnozO68bAaKNNIHXqePqXErfODn0yVZ7RY7TIm3vZM95tJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(1076003)(40460700003)(2616005)(66899024)(5660300002)(4326008)(8676002)(8936002)(336012)(47076005)(426003)(36756003)(30864003)(83380400001)(7696005)(36860700001)(26005)(40480700001)(16526019)(82740400003)(356005)(6666004)(81166007)(70586007)(70206006)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:53:15.7019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd93d69-7bf9-49c3-e278-08dba4ec8543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

Add jpeg support for VCN4_0_5

v2 - update license year (Leo Liu)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 621 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.h |  35 ++
 3 files changed, 658 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 3c4b26691989..97bce96e0e50 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -213,7 +213,8 @@ amdgpu-y += \
 	jpeg_v2_5.o \
 	jpeg_v3_0.o \
 	jpeg_v4_0.o \
-	jpeg_v4_0_3.o
+	jpeg_v4_0_3.o \
+	jpeg_v4_0_5.o
 
 # add VPE block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
new file mode 100644
index 000000000000..b99faf55d3c4
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -0,0 +1,621 @@
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
+#include "amdgpu.h"
+#include "amdgpu_jpeg.h"
+#include "amdgpu_pm.h"
+#include "soc15.h"
+#include "soc15d.h"
+#include "jpeg_v2_0.h"
+#include "jpeg_v4_0_5.h"
+#include "mmsch_v4_0.h"
+
+#include "vcn/vcn_4_0_5_offset.h"
+#include "vcn/vcn_4_0_5_sh_mask.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
+
+#define regUVD_JPEG_PITCH_INTERNAL_OFFSET                  0x401f
+
+static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev);
+static void jpeg_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
+static int jpeg_v4_0_5_set_powergating_state(void *handle,
+				enum amd_powergating_state state);
+
+static void jpeg_v4_0_5_dec_ring_set_wptr(struct amdgpu_ring *ring);
+
+/**
+ * jpeg_v4_0_5_early_init - set function pointers
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Set ring and irq function pointers
+ */
+static int jpeg_v4_0_5_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+
+	adev->jpeg.num_jpeg_inst = 1;
+
+	jpeg_v4_0_5_set_dec_ring_funcs(adev);
+	jpeg_v4_0_5_set_irq_funcs(adev);
+
+	return 0;
+}
+
+/**
+ * jpeg_v4_0_5_sw_init - sw init for JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Load firmware and sw initialization
+ */
+static int jpeg_v4_0_5_sw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_ring *ring;
+	int r;
+
+	/* JPEG TRAP */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+		VCN_4_0__SRCID__JPEG_DECODE, &adev->jpeg.inst->irq);
+	if (r)
+		return r;
+
+	/* JPEG DJPEG POISON EVENT */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+			VCN_4_0__SRCID_DJPEG0_POISON, &adev->jpeg.inst->irq);
+	if (r)
+		return r;
+
+	/* JPEG EJPEG POISON EVENT */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+			VCN_4_0__SRCID_EJPEG0_POISON, &adev->jpeg.inst->irq);
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
+	ring = adev->jpeg.inst->ring_dec;
+	ring->use_doorbell = true;
+	ring->doorbell_index = amdgpu_sriov_vf(adev) ?
+				(((adev->doorbell_index.vcn.vcn_ring0_1) << 1) + 4) :
+				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1);
+	ring->vm_hub = AMDGPU_MMHUB0(0);
+
+	sprintf(ring->name, "jpeg_dec");
+	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
+			     AMDGPU_RING_PRIO_DEFAULT, NULL);
+	if (r)
+		return r;
+
+	adev->jpeg.internal.jpeg_pitch[0] = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
+	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
+
+	return 0;
+}
+
+/**
+ * jpeg_v4_0_5_sw_fini - sw fini for JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * JPEG suspend and free up sw allocation
+ */
+static int jpeg_v4_0_5_sw_fini(void *handle)
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
+ * jpeg_v4_0_5_hw_init - start and test JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ */
+static int jpeg_v4_0_5_hw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
+	int r;
+
+	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
+
+	WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
+		ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+		VCN_JPEG_DB_CTRL__EN_MASK);
+
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+
+	DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
+
+	return 0;
+}
+
+/**
+ * jpeg_v4_0_5_hw_fini - stop the hardware block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Stop the JPEG block, mark ring as not ready any more
+ */
+static int jpeg_v4_0_5_hw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	if (!amdgpu_sriov_vf(adev)) {
+		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
+			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
+			jpeg_v4_0_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+	}
+	amdgpu_irq_put(adev, &adev->jpeg.inst->irq, 0);
+
+	return 0;
+}
+
+/**
+ * jpeg_v4_0_5_suspend - suspend JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * HW fini and suspend JPEG block
+ */
+static int jpeg_v4_0_5_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = jpeg_v4_0_5_hw_fini(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_suspend(adev);
+
+	return r;
+}
+
+/**
+ * jpeg_v4_0_5_resume - resume JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Resume firmware and hw init JPEG block
+ */
+static int jpeg_v4_0_5_resume(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_jpeg_resume(adev);
+	if (r)
+		return r;
+
+	r = jpeg_v4_0_5_hw_init(adev);
+
+	return r;
+}
+
+static void jpeg_v4_0_5_disable_clock_gating(struct amdgpu_device *adev)
+{
+	uint32_t data = 0;
+
+	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG) {
+		data |= 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+		data &= (~JPEG_CGC_CTRL__JPEG_DEC_MODE_MASK);
+	} else {
+		data &= ~JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	}
+
+	data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
+
+	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE);
+	data &= ~(JPEG_CGC_GATE__JPEG_DEC_MASK
+		| JPEG_CGC_GATE__JPEG2_DEC_MASK
+		| JPEG_CGC_GATE__JMCIF_MASK
+		| JPEG_CGC_GATE__JRBBM_MASK);
+	WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
+}
+
+static void jpeg_v4_0_5_enable_clock_gating(struct amdgpu_device *adev)
+{
+	uint32_t data = 0;
+
+	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG) {
+		data |= 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+		data |= JPEG_CGC_CTRL__JPEG_DEC_MODE_MASK;
+	} else {
+		data &= ~JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	}
+
+	data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
+
+	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE);
+	data |= (JPEG_CGC_GATE__JPEG_DEC_MASK
+		|JPEG_CGC_GATE__JPEG2_DEC_MASK
+		|JPEG_CGC_GATE__JMCIF_MASK
+		|JPEG_CGC_GATE__JRBBM_MASK);
+	WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
+}
+
+static int jpeg_v4_0_5_disable_static_power_gating(struct amdgpu_device *adev)
+{
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
+		WREG32(SOC15_REG_OFFSET(JPEG, 0, regUVD_IPX_DLDO_CONFIG),
+			1 << UVD_IPX_DLDO_CONFIG__ONO1_PWR_CONFIG__SHIFT);
+		SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_IPX_DLDO_STATUS,
+			0, UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS_MASK);
+	}
+
+	/* disable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
+		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	/* keep the JPEG in static PG mode */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
+		~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK);
+
+	return 0;
+}
+
+static int jpeg_v4_0_5_enable_static_power_gating(struct amdgpu_device *adev)
+{
+	/* enable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS),
+		UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
+		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
+		WREG32(SOC15_REG_OFFSET(JPEG, 0, regUVD_IPX_DLDO_CONFIG),
+			2 << UVD_IPX_DLDO_CONFIG__ONO1_PWR_CONFIG__SHIFT);
+		SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_IPX_DLDO_STATUS,
+			1 << UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS__SHIFT,
+			UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS_MASK);
+	}
+
+	return 0;
+}
+
+/**
+ * jpeg_v4_0_5_start - start JPEG block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Setup and start the JPEG block
+ */
+static int jpeg_v4_0_5_start(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
+	int r;
+
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_jpeg(adev, true);
+
+	/* disable power gating */
+	r = jpeg_v4_0_5_disable_static_power_gating(adev);
+	if (r)
+		return r;
+
+	/* JPEG disable CGC */
+	jpeg_v4_0_5_disable_clock_gating(adev);
+
+	/* MJPEG global tiling registers */
+	WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
+
+
+	/* enable JMI channel */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL), 0,
+		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+	/* enable System Interrupt for JRBC */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regJPEG_SYS_INT_EN),
+		JPEG_SYS_INT_EN__DJRBC_MASK,
+		~JPEG_SYS_INT_EN__DJRBC_MASK);
+
+	WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_VMID, 0);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
+	WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+		lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+		upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_RPTR, 0);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR, 0);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_CNTL, 0x00000002L);
+	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_SIZE, ring->ring_size / 4);
+	ring->wptr = RREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR);
+
+	return 0;
+}
+
+/**
+ * jpeg_v4_0_5_stop - stop JPEG block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * stop the JPEG block
+ */
+static int jpeg_v4_0_5_stop(struct amdgpu_device *adev)
+{
+	int r;
+
+	/* reset JMI */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
+		UVD_JMI_CNTL__SOFT_RESET_MASK,
+		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+	jpeg_v4_0_5_enable_clock_gating(adev);
+
+	/* enable power gating */
+	r = jpeg_v4_0_5_enable_static_power_gating(adev);
+	if (r)
+		return r;
+
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_jpeg(adev, false);
+
+	return 0;
+}
+
+/**
+ * jpeg_v4_0_5_dec_ring_get_rptr - get read pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware read pointer
+ */
+static uint64_t jpeg_v4_0_5_dec_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	return RREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_RPTR);
+}
+
+/**
+ * jpeg_v4_0_5_dec_ring_get_wptr - get write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware write pointer
+ */
+static uint64_t jpeg_v4_0_5_dec_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell)
+		return *ring->wptr_cpu_addr;
+	else
+		return RREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR);
+}
+
+/**
+ * jpeg_v4_0_5_dec_ring_set_wptr - set write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Commits the write pointer to the hardware
+ */
+static void jpeg_v4_0_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell) {
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
+	} else {
+		WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
+	}
+}
+
+static bool jpeg_v4_0_5_is_idle(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int ret = 1;
+
+	ret &= (((RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS) &
+		UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
+		UVD_JRBC_STATUS__RB_JOB_DONE_MASK));
+
+	return ret;
+}
+
+static int jpeg_v4_0_5_wait_for_idle(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_JRBC_STATUS,
+		UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
+		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+}
+
+static int jpeg_v4_0_5_set_clockgating_state(void *handle,
+					  enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+
+	if (enable) {
+		if (!jpeg_v4_0_5_is_idle(handle))
+			return -EBUSY;
+		jpeg_v4_0_5_enable_clock_gating(adev);
+	} else {
+		jpeg_v4_0_5_disable_clock_gating(adev);
+	}
+
+	return 0;
+}
+
+static int jpeg_v4_0_5_set_powergating_state(void *handle,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int ret;
+
+	if (amdgpu_sriov_vf(adev)) {
+		adev->jpeg.cur_state = AMD_PG_STATE_UNGATE;
+		return 0;
+	}
+
+	if (state == adev->jpeg.cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = jpeg_v4_0_5_stop(adev);
+	else
+		ret = jpeg_v4_0_5_start(adev);
+
+	if (!ret)
+		adev->jpeg.cur_state = state;
+
+	return ret;
+}
+
+static int jpeg_v4_0_5_set_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
+static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
+				      struct amdgpu_irq_src *source,
+				      struct amdgpu_iv_entry *entry)
+{
+	DRM_DEBUG("IH: JPEG TRAP\n");
+
+	switch (entry->src_id) {
+	case VCN_4_0__SRCID__JPEG_DECODE:
+		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
+		break;
+	case VCN_4_0__SRCID_DJPEG0_POISON:
+	case VCN_4_0__SRCID_EJPEG0_POISON:
+		amdgpu_jpeg_process_poison_irq(adev, source, entry);
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
+static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
+	.name = "jpeg_v4_0_5",
+	.early_init = jpeg_v4_0_5_early_init,
+	.late_init = NULL,
+	.sw_init = jpeg_v4_0_5_sw_init,
+	.sw_fini = jpeg_v4_0_5_sw_fini,
+	.hw_init = jpeg_v4_0_5_hw_init,
+	.hw_fini = jpeg_v4_0_5_hw_fini,
+	.suspend = jpeg_v4_0_5_suspend,
+	.resume = jpeg_v4_0_5_resume,
+	.is_idle = jpeg_v4_0_5_is_idle,
+	.wait_for_idle = jpeg_v4_0_5_wait_for_idle,
+	.check_soft_reset = NULL,
+	.pre_soft_reset = NULL,
+	.soft_reset = NULL,
+	.post_soft_reset = NULL,
+	.set_clockgating_state = jpeg_v4_0_5_set_clockgating_state,
+	.set_powergating_state = jpeg_v4_0_5_set_powergating_state,
+};
+
+static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
+	.type = AMDGPU_RING_TYPE_VCN_JPEG,
+	.align_mask = 0xf,
+	.get_rptr = jpeg_v4_0_5_dec_ring_get_rptr,
+	.get_wptr = jpeg_v4_0_5_dec_ring_get_wptr,
+	.set_wptr = jpeg_v4_0_5_dec_ring_set_wptr,
+	.emit_frame_size =
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
+		8 + /* jpeg_v4_0_5_dec_ring_emit_vm_flush */
+		18 + 18 + /* jpeg_v4_0_5_dec_ring_emit_fence x2 vm fence */
+		8 + 16,
+	.emit_ib_size = 22, /* jpeg_v4_0_5_dec_ring_emit_ib */
+	.emit_ib = jpeg_v2_0_dec_ring_emit_ib,
+	.emit_fence = jpeg_v2_0_dec_ring_emit_fence,
+	.emit_vm_flush = jpeg_v2_0_dec_ring_emit_vm_flush,
+	.test_ring = amdgpu_jpeg_dec_ring_test_ring,
+	.test_ib = amdgpu_jpeg_dec_ring_test_ib,
+	.insert_nop = jpeg_v2_0_dec_ring_nop,
+	.insert_start = jpeg_v2_0_dec_ring_insert_start,
+	.insert_end = jpeg_v2_0_dec_ring_insert_end,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.begin_use = amdgpu_jpeg_ring_begin_use,
+	.end_use = amdgpu_jpeg_ring_end_use,
+	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
+	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+};
+
+static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev)
+{
+	adev->jpeg.inst->ring_dec->funcs = &jpeg_v4_0_5_dec_ring_vm_funcs;
+	DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
+}
+
+static const struct amdgpu_irq_src_funcs jpeg_v4_0_5_irq_funcs = {
+	.set = jpeg_v4_0_5_set_interrupt_state,
+	.process = jpeg_v4_0_5_process_interrupt,
+};
+
+static void jpeg_v4_0_5_set_irq_funcs(struct amdgpu_device *adev)
+{
+	adev->jpeg.inst->irq.num_types = 1;
+	adev->jpeg.inst->irq.funcs = &jpeg_v4_0_5_irq_funcs;
+}
+
+const struct amdgpu_ip_block_version jpeg_v4_0_5_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_JPEG,
+	.major = 4,
+	.minor = 0,
+	.rev = 5,
+	.funcs = &jpeg_v4_0_5_ip_funcs,
+};
+
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.h
new file mode 100644
index 000000000000..c5eee572079c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.h
@@ -0,0 +1,35 @@
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
+#ifndef __JPEG_V4_0_5_H__
+#define __JPEG_V4_0_5_H__
+
+enum amdgpu_jpeg_v4_0_5_sub_block {
+	AMDGPU_JPEG_V4_0_5_JPEG0 = 0,
+
+	AMDGPU_JPEG_V4_0_5_MAX_SUB_BLOCK,
+};
+
+extern const struct amdgpu_ip_block_version jpeg_v4_0_5_ip_block;
+
+#endif /* __JPEG_V4_0_H__ */
-- 
2.41.0

