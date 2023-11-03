Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3543C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 14:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92CD510EA0A;
	Fri,  3 Nov 2023 14:57:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1442C10EA0A
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 14:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POERUFCRjALeFwL9BWs9cjGpTWFobdJdOP0YlJjz2GUm8zhrbVPFE2AP0h4KrsAOb+Z//s+3wDrR9FSCF5ZhAX6taS9vz3p8nBVq1SviAzkd+Vk1TSev/e6Rphy96viUYbMESQKafB9RzwvzsUzho0CuoeX/6XeKSmTkoah1MoqKjFO8TQfV/cABTvGuy8zlTXLqiY4DS8yDEbORAVfkDcMhfeX+eb+wK9mEL89v0Mp2ufON+mWKj0tqzJsM3kycyNz9yLLjjk6FJvAC+6XoW87rlBuPjxhLcg2fD/Tb6/cxFFDXMCiKNgu7cNYBM6zj1RC5tCEoJCkq6HO8XqHJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzVaMSRiTMEL+bbsVwG2S9mQElPLbgmlZqQaDMRl8po=;
 b=IqztMiL8aR3gqRMa1kqE4GQt7i4W3z5dnvRHczr7KunlIy3RFIXUJKMr5/U7P0Qi4vPowErX8KI5JW9tnLmxiIDlEWcTbh82e1+KFgBfy+LQrgatwzBKpnypt7I+aJaQZOdarXXbFvImx9oonQUHWrneeHXAhZbk4r903T/TjDn7larPpqEbQkPbGpVeYaScbcGSzxt2gNk23KM9L8Z/eEJgWlmZnUZOhUhnJtMuJmZcBK3Wt8Gf9mD7QdxTlIElNgbqRO9vqoe9XPzP4xmQEaNcT29YCCSmXMj5Ib3lr55Pv1SWHbDdus6ws1X/m3r8br6Hhn7a6uKs6ZNyq6mFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzVaMSRiTMEL+bbsVwG2S9mQElPLbgmlZqQaDMRl8po=;
 b=X28OOWvUMo2RIJIeiueDpsRrqQWWob+9XFOOutXqqLWeM8h0it7W42lnMypGBiCGT/OhDLnK5mMN0BxU5xCfaa0otOR7xFmZ2FALDEv3Jw7LyIapQds4aIZwoTU7MY8KhSJNLy5oacEN0UJVOklmAuF8/INJT2JNhlKuwXXMT6o=
Received: from BL1PR13CA0130.namprd13.prod.outlook.com (2603:10b6:208:2bb::15)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 14:57:15 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::7c) by BL1PR13CA0130.outlook.office365.com
 (2603:10b6:208:2bb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10 via Frontend
 Transport; Fri, 3 Nov 2023 14:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 14:57:15 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 09:57:12 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Use correct KIQ MEC engine for gfx9.4.3 (v5)
Date: Fri, 3 Nov 2023 10:56:53 -0400
Message-ID: <20231103145654.2651-3-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103145654.2651-1-victorchengchi.lu@amd.com>
References: <513b2282-2f88-d837-ff37-6bd04641e833@amd.com>
 <20231103145654.2651-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DS0PR12MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eeab1c1-caa0-4f09-66fb-08dbdc7d2b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQ7IFO7aNG/RCuYTxPJu3XNzqDatpIVpKbRuN6me4uJFoalkxZFiaIBjJhGev3zTjNKRRJsN6rIfm3GGtzVPd7wMy8Z2bh6S/emYGaJSRc76P2TSdX6XUhJTUDmEc6TIflF4UCacBNov7TMwQNLgrvwQpG6P/BivDqHINCyEPtMsh34WwrcGkAppLC3qFIBnSxpHynt/u1g7TQuAVy97AlHVBrb1LmH2cr0ySMzfbOR7HJ7qfK59VBKi+u/OZay96wFQvqXT4VPmKCV2aEGZJp5QjQLCCANGjEgirTo6U9ZW5lVlNyCK76NZLNVumJSAdE10wbUVxEb73cdYlffy9T1hzK1jfxc9rC+4t/MhtP0T2j2kGh1U+fQebXJlpSAtvGGxFEOje0DfO9rcav/vX83C8RKcFNldBfs5SAZHSrsEiZHYGF/sQmRYtCpgDFQR7d7SvP3SkmfRnVAHRnHtZbmnQX6T2BEIF46txTf8KyAr5D4BYTSg+od9L4mh4U0jKoiNGNFKHjdLv/dIuqoSj4Wcq4kKELbiwPBdCvNx1uoIYOZRXDfmN5Hx75U0AIFvrvWXwGlFROeFI1pPNm7pRlqjT4PiQinNtJO8eZolUiIlEfRmYhPY74J3za+tguPR/XpmkfBRtkPrJSH+4tkGPtRjIk7IvnlZTG/9ZLZVQNoI74ZSe8/b1oT87wXrPPPonn6MkbJBsypFQYB837XmlYFlI6WqcUKbwHVKWQPkU+2xdnjEU7uhZC+V3EyGayAw+qlnprvyJETbyjPxcBmI4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(41300700001)(40460700003)(47076005)(5660300002)(2906002)(30864003)(36860700001)(86362001)(82740400003)(81166007)(356005)(1076003)(2616005)(26005)(16526019)(336012)(426003)(316002)(6916009)(70586007)(70206006)(54906003)(6666004)(36756003)(478600001)(7696005)(40480700001)(4326008)(8936002)(8676002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 14:57:15.3869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eeab1c1-caa0-4f09-66fb-08dbdc7d2b29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_kiq_wreg/rreg is hardcoded to use MEC engine 0.

Add an xcc_id parameter to amdgpu_kiq_wreg/rreg, define W/RREG32_XCC
and amdgpu_device_xcc_wreg/rreg to to use the new xcc_id parameter.

Using amdgpu_sriov_runtime to determine whether to access via kiq or
RLC is sufficient for now.

v5: add condition in amdgpu_device_xcc_w/rreg, remove trace func call

v4: avoid using amdgpu_sriov_w/rreg

v3: use W/RREG32_XCC to handle non-kiq case

v2: define amdgpu_device_xcc_wreg/rreg instead of changing parameters
    of amdgpu_device_wreg/rreg

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 13 ++-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 89 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  8 +-
 9 files changed, 116 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 43c579f5a95e..e8dc75a3ff44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1162,11 +1162,18 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
 			    uint32_t reg, uint32_t acc_flags);
 u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev,
 				    u64 reg_addr);
+uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
+				uint32_t reg, uint32_t acc_flags,
+				uint32_t xcc_id);
 void amdgpu_device_wreg(struct amdgpu_device *adev,
 			uint32_t reg, uint32_t v,
 			uint32_t acc_flags);
 void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev,
 				     u64 reg_addr, u32 reg_data);
+void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
+			    uint32_t reg, uint32_t v,
+			    uint32_t acc_flags,
+			    uint32_t xcc_id);
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 			     uint32_t reg, uint32_t v, uint32_t xcc_id);
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value);
@@ -1207,8 +1214,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
 #define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
 
-#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg))
-#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v))
+#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg), 0)
+#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v), 0)
 
 #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
 #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
@@ -1218,6 +1225,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32(reg, v) amdgpu_device_wreg(adev, (reg), (v), 0)
 #define REG_SET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
 #define REG_GET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
+#define RREG32_XCC(reg, inst) amdgpu_device_xcc_rreg(adev, (reg), 0, inst)
+#define WREG32_XCC(reg, v, inst) amdgpu_device_xcc_wreg(adev, (reg), (v), 0, inst)
 #define RREG32_PCIE(reg) adev->pcie_rreg(adev, (reg))
 #define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
 #define RREG32_PCIE_PORT(reg) adev->pciep_rreg(adev, (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 490c8f5ddb60..80309d39737a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -300,7 +300,7 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 	hqd_end = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_AQL_DISPATCH_ID_HI);
 
 	for (reg = hqd_base; reg <= hqd_end; reg++)
-		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
+		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], inst);
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 51011e8ee90d..9285789b3a42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -239,7 +239,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 
 	for (reg = hqd_base;
 	     reg <= SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI); reg++)
-		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
+		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], inst);
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9a11dd1b686e..7cba8d65b0fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -74,6 +74,7 @@
 #include "amdgpu_pmu.h"
 #include "amdgpu_fru_eeprom.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_virt.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -473,7 +474,7 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
 		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
 		    amdgpu_sriov_runtime(adev) &&
 		    down_read_trylock(&adev->reset_domain->sem)) {
-			ret = amdgpu_kiq_rreg(adev, reg);
+			ret = amdgpu_kiq_rreg(adev, reg, 0);
 			up_read(&adev->reset_domain->sem);
 		} else {
 			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
@@ -510,6 +511,49 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
 	BUG();
 }
 
+
+/**
+ * amdgpu_device_xcc_rreg - read a memory mapped IO or indirect register with specific XCC
+ *
+ * @adev: amdgpu_device pointer
+ * @reg: dword aligned register offset
+ * @acc_flags: access flags which require special behavior
+ * @xcc_id: xcc accelerated compute core id
+ *
+ * Returns the 32 bit value from the offset specified.
+ */
+uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
+				uint32_t reg, uint32_t acc_flags,
+				uint32_t xcc_id)
+{
+	uint32_t ret, rlcg_flag;
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
+	if ((reg * 4) < adev->rmmio_size) {
+		if (amdgpu_sriov_vf(adev) &&
+		    !amdgpu_sriov_runtime(adev) &&
+		    adev->gfx.rlc.rlcg_reg_access_supported &&
+		    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
+							 GC_HWIP, false,
+							 &rlcg_flag)) {
+			amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_flag, xcc_id);
+		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
+		    amdgpu_sriov_runtime(adev) &&
+		    down_read_trylock(&adev->reset_domain->sem)) {
+			ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
+			up_read(&adev->reset_domain->sem);
+		} else {
+			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
+		}
+	} else {
+		ret = adev->pcie_rreg(adev, reg * 4);
+	}
+
+	return ret;
+}
+
 /*
  * MMIO register write with bytes helper functions
  * @offset:bytes offset from MMIO start
@@ -557,7 +601,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
 		    amdgpu_sriov_runtime(adev) &&
 		    down_read_trylock(&adev->reset_domain->sem)) {
-			amdgpu_kiq_wreg(adev, reg, v);
+			amdgpu_kiq_wreg(adev, reg, v, 0);
 			up_read(&adev->reset_domain->sem);
 		} else {
 			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
@@ -598,6 +642,47 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	}
 }
 
+/**
+ * amdgpu_device_xcc_wreg - write to a memory mapped IO or indirect register with specific XCC
+ *
+ * @adev: amdgpu_device pointer
+ * @reg: dword aligned register offset
+ * @v: 32 bit value to write to the register
+ * @acc_flags: access flags which require special behavior
+ * @xcc_id: xcc accelerated compute core id
+ *
+ * Writes the value specified to the offset specified.
+ */
+void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
+			uint32_t reg, uint32_t v,
+			uint32_t acc_flags, uint32_t xcc_id)
+{
+	uint32_t rlcg_flag;
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
+	if ((reg * 4) < adev->rmmio_size) {
+		if (amdgpu_sriov_vf(adev) &&
+		    !amdgpu_sriov_runtime(adev) &&
+		    adev->gfx.rlc.rlcg_reg_access_supported &&
+		    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
+							 GC_HWIP, true,
+							 &rlcg_flag)) {
+			amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag, xcc_id);
+		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
+		    amdgpu_sriov_runtime(adev) &&
+		    down_read_trylock(&adev->reset_domain->sem)) {
+			amdgpu_kiq_wreg(adev, reg, v, xcc_id);
+			up_read(&adev->reset_domain->sem);
+		} else {
+			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
+		}
+	} else {
+		adev->pcie_wreg(adev, reg * 4, v);
+	}
+}
+
 /**
  * amdgpu_device_indirect_rreg - read an indirect register
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c92e0aba69e1..60ae4bfdc7f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -929,12 +929,12 @@ void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
 		func(adev, ras_error_status, i);
 }
 
-uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
+uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id)
 {
 	signed long r, cnt = 0;
 	unsigned long flags;
 	uint32_t seq, reg_val_offs = 0, value = 0;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *ring = &kiq->ring;
 
 	if (amdgpu_device_skip_hw_access(adev))
@@ -997,12 +997,12 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	return ~0;
 }
 
-void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
+void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id)
 {
 	signed long r, cnt = 0;
 	unsigned long flags;
 	uint32_t seq;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *ring = &kiq->ring;
 
 	BUG_ON(!ring->funcs->emit_wreg);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 7088c5015675..f23bafec71c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -521,8 +521,8 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry);
-uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
-void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
+uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id);
+void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id);
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
 void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index e179f022c428..82762c61d3ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -943,7 +943,7 @@ void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
 	}
 }
 
-static bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
+bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
 						 u32 acc_flags, u32 hwip,
 						 bool write, u32 *rlcg_flag)
 {
@@ -976,7 +976,7 @@ static bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
 	return ret;
 }
 
-static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id)
+u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id)
 {
 	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
 	uint32_t timeout = 50000;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index bb436d41b4ca..ca13ae70e87d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -366,4 +366,8 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
 			uint32_t ucode_id);
 void amdgpu_virt_post_reset(struct amdgpu_device *adev);
+bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device *adev,
+					  u32 acc_flags, u32 hwip,
+					  bool write, u32 *rlcg_flag);
+u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag, u32 xcc_id);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ce2a9876369e..9afd43276ab2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2738,16 +2738,16 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, xcc_id);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 0);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, xcc_id);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, xcc_id);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 1);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, xcc_id);
 		break;
 	default:
 		break;
-- 
2.34.1

