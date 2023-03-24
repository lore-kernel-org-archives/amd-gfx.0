Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7276AC76195
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 22:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A87C710ECA6;
	Fri, 24 Mar 2023 22:00:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4B810E295
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 22:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw5RcwNzMvcliqMX9+fvjbdxq3W9NT2pB93QqTO431ilDX4/o18ZMxQeJaFuWeY5qnzjybfiKDJVZEzTzUeGKNulAh+SKCrwizY1FR46NECieJove8iRpNzoc+4jgdeJCWy/IKp3/zfhw1+kYwfy5dPalFsvGwxCK28wHjky29D/3pRBfxJDEK6eqJyuYvN/ElJuhLBn58ObW0P+SPUjiXUqt1OrieRFvPfLezJhyin/pTRwWskg9NUyU6jQ5S+V92TLfGpvb8m7gZqEunCACxD7EnYhNbfkVMNutFiDzBqRLBqiNVIcUdrUQtmOqVrmOtHKhSkWwG20XAKyXfEtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lXt3grY7alS4+O2p72Upv0pB/rTz4bm1ZxNq6Y80c0=;
 b=f3zr/3Ck3FGcMYN7bQlWYoRowJJxPkY0VFVQMjxekY7zYVFBoigNeCV6Bga2Kl+4vghZJ3VwXTPqVwd0ATmtujl03y6Be00AiM2o+dC5k7P0MqYGzAqVgoyHHl3Og+fjsNtBeXS5utwILEn8A7fBVie7AQ8Cq1lEpfo+CpWWdpzpyTyCYBRYLwCeG4zt+ppNEOdI1XKJWVsB42b5AxK/jIIxQl0Iy/jOP1YVg5ET5c/6K480Yu1dfsESKQS5CvoJSSr2ncEv/SBTCEPMHYCVtojZUDeTPKSPeu6ZM4InoaF2Zjxiy6DloZi489LSz1pFz/DuBJtkyVj84y4AJha9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lXt3grY7alS4+O2p72Upv0pB/rTz4bm1ZxNq6Y80c0=;
 b=yU16DVHEZslbB6Wbfdxd0+1vRcjf2TMQTURm/rXzWamAZ8BugoQmviv1sj1vtndrfR13yCSPm0956vJsuhUwZDyYR1CEzp09fJ693dbMo/BQmovxSVq0YJSfNEXGsTys6XM5/JEAV+Nj4sW8Kc7S0uKfFABgkWF3uhSS0kVSSEA=
Received: from MW4PR03CA0047.namprd03.prod.outlook.com (2603:10b6:303:8e::22)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 22:00:10 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::67) by MW4PR03CA0047.outlook.office365.com
 (2603:10b6:303:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 22:00:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Fri, 24 Mar 2023 22:00:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 17:00:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/9] drm/amdgpu: add mmhub v1_8 support
Date: Fri, 24 Mar 2023 17:59:47 -0400
Message-ID: <20230324215949.2560463-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324215949.2560463-1-alexander.deucher@amd.com>
References: <20230324215949.2560463-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f3a17d-363c-4740-e142-08db2cb322d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gr6j20PVmcYtXiOgtzyNVxClQSgfWezhOO5Djz8tUgJbtzXTxSzYoAH9eqyN6aDAwC1LSRyNDAJowOEr7/4JnH3/kbtt/8Lmanz9Ji4EwecfN66p+tHn0Gfwj753KmRqiAe4QtT53NzoWaL8IRwaYm4pbkCOOMKsiEonY+pXiuoN2LzLoCgmX/2vn6h+nfHbpnJnJl6GZyhj4OcZBfh84o3b7zAN9mS97uFYzRzleFw3pBEbs9gyu4uJ/PE7e8w9Jl1H4LFkcuzYD/d31OU1+hO48pNS3kqTSYmkSP13TZ5Hu3IhddtNZZMZ79jUvbAGaw+pzGM5rPVU3USgH2FL/K8bcbtwKDB6hKGMTjMAfY10Z58RMX3PcproZ97V6ASDcsQ/+9fVCF+AMyeeNoZh3hVlocc4FFEuAJpFQ7vfYemdjThxzI+OCskFJw0h+Q/CLGO51hfCFFk+PrLa/8I39YK9I289C+hs2EWs8RvQZVuxLvfX7RggMQVDslXt49Ehs4S3vPuw2RLgR+5sM+4Rc3nH/B7VBCwZj5+tEhtHXuJpCQYwybCPCB0OfQ8lh13zrHW2aQaR2g2dS1p+2v8/nIyH6gxOwW7FIpSB4Tn4S2JSK/rXWZbXNZGgN9PEY+h3uK7Iz4wjVXpcUAB9RLs7ziQlmxAOP/JZ/6BDmtDrckj8u8zPXoQravhiYv8UNUaZTedsUcXePAkEhHsGvUNWOyXqVgfo4BaSMFG+SgDlYL9l8w7HCxfW9wPzeBu4m+wqW7OgFWgMzAh9eq7+BaU0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(66899021)(2906002)(8676002)(8936002)(6666004)(82310400005)(54906003)(5660300002)(47076005)(26005)(86362001)(30864003)(82740400003)(7696005)(316002)(356005)(336012)(478600001)(70586007)(70206006)(6916009)(4326008)(41300700001)(40460700003)(83380400001)(36756003)(1076003)(2616005)(426003)(81166007)(40480700001)(36860700001)(16526019)(186003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 22:00:09.6377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f3a17d-363c-4740-e142-08db2cb322d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Hack the mmhub 1.7 reg offset for initial support

v2: squash in header switch, CG funcs (Alex)

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |   2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 477 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.h |  28 ++
 3 files changed, 506 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index e49b6a888c7f..dd8bc53411bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -93,7 +93,7 @@ amdgpu-y += \
 	gfxhub_v1_0.o mmhub_v1_0.o gmc_v9_0.o gfxhub_v1_1.o mmhub_v9_4.o \
 	gfxhub_v2_0.o mmhub_v2_0.o gmc_v10_0.o gfxhub_v2_1.o mmhub_v2_3.o \
 	mmhub_v1_7.o gfxhub_v3_0.o mmhub_v3_0.o mmhub_v3_0_2.o gmc_v11_0.o \
-	mmhub_v3_0_1.o gfxhub_v3_0_3.o gfxhub_v1_2.o
+	mmhub_v3_0_1.o gfxhub_v3_0_3.o gfxhub_v1_2.o mmhub_v1_8.o
 
 # add UMC block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
new file mode 100644
index 000000000000..342d1702104c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -0,0 +1,477 @@
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
+#include "amdgpu.h"
+#include "mmhub_v1_8.h"
+
+#include "mmhub/mmhub_1_8_0_offset.h"
+#include "mmhub/mmhub_1_8_0_sh_mask.h"
+#include "vega10_enum.h"
+
+#include "soc15_common.h"
+#include "soc15.h"
+
+#define regVM_L2_CNTL3_DEFAULT	0x80100007
+#define regVM_L2_CNTL4_DEFAULT	0x000000c1
+
+static u64 mmhub_v1_8_get_fb_location(struct amdgpu_device *adev)
+{
+	u64 base = RREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE);
+	u64 top = RREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP);
+
+	base &= MC_VM_FB_LOCATION_BASE__FB_BASE_MASK;
+	base <<= 24;
+
+	top &= MC_VM_FB_LOCATION_TOP__FB_TOP_MASK;
+	top <<= 24;
+
+	adev->gmc.fb_start = base;
+	adev->gmc.fb_end = top;
+
+	return base;
+}
+
+static void mmhub_v1_8_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
+				uint64_t page_table_base)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+
+	WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+			    hub->ctx_addr_distance * vmid, lower_32_bits(page_table_base));
+
+	WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+			    hub->ctx_addr_distance * vmid, upper_32_bits(page_table_base));
+}
+
+static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
+{
+	uint64_t pt_base;
+
+	if (adev->gmc.pdb0_bo)
+		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
+	else
+		pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+
+	mmhub_v1_8_setup_vm_pt_regs(adev, 0, pt_base);
+
+	/* If use GART for FB translation, vmid0 page table covers both
+	 * vram and system memory (gart)
+	 */
+	if (adev->gmc.pdb0_bo) {
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+			     (u32)(adev->gmc.fb_start >> 12));
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+			     (u32)(adev->gmc.fb_start >> 44));
+
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+			     (u32)(adev->gmc.gart_end >> 12));
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+			     (u32)(adev->gmc.gart_end >> 44));
+
+	} else {
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+			     (u32)(adev->gmc.gart_start >> 12));
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+			     (u32)(adev->gmc.gart_start >> 44));
+
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+			     (u32)(adev->gmc.gart_end >> 12));
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+			     (u32)(adev->gmc.gart_end >> 44));
+	}
+}
+
+static void mmhub_v1_8_init_system_aperture_regs(struct amdgpu_device *adev)
+{
+	uint64_t value;
+	uint32_t tmp;
+
+	/* Program the AGP BAR */
+	WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BASE, 0);
+	WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
+	/* Program the system aperture low logical page number. */
+	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
+
+	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
+
+	/* In the case squeezing vram into GART aperture, we don't use
+	 * FB aperture and AGP aperture. Disable them.
+	 */
+	if (adev->gmc.pdb0_bo) {
+		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BOT, 0xFFFFFF);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_TOP, 0);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, 0);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
+	}
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	/* Set default page address. */
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
+	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+		     (u32)(value >> 12));
+	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+		     (u32)(value >> 44));
+
+	/* Program "protection fault". */
+	WREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+		     (u32)(adev->dummy_page_addr >> 12));
+	WREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+		     (u32)((u64)adev->dummy_page_addr >> 44));
+
+	tmp = RREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
+			    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	WREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+}
+
+static void mmhub_v1_8_init_tlb_regs(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	/* Setup TLB control */
+	tmp = RREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL);
+
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 1);
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, SYSTEM_ACCESS_MODE, 3);
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+			    MTYPE, MTYPE_UC);/* XXX for emulation. */
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
+
+	WREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
+}
+
+static void mmhub_v1_8_init_cache_regs(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	/* Setup L2 cache */
+	tmp = RREG32_SOC15(MMHUB, 0, regVM_L2_CNTL);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 1);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_FRAGMENT_PROCESSING, 1);
+	/* XXX for emulation, Refer to closed source code.*/
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, L2_PDE0_CACHE_TAG_GENERATION_MODE,
+			    0);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, PDE_FAULT_CLASSIFICATION, 0);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, CONTEXT1_IDENTITY_ACCESS_MODE, 1);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, IDENTITY_MODE_FRAGMENT_SIZE, 0);
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL, tmp);
+
+	tmp = RREG32_SOC15(MMHUB, 0, regVM_L2_CNTL2);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_ALL_L1_TLBS, 1);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL2, tmp);
+
+	tmp = regVM_L2_CNTL3_DEFAULT;
+	if (adev->gmc.translate_further) {
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 12);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
+				    L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
+	} else {
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 9);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
+				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
+	}
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL3, tmp);
+
+	tmp = regVM_L2_CNTL4_DEFAULT;
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
+				    VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
+				    VMC_TAP_PTE_REQUEST_PHYSICAL, 1);
+	} else {
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
+				    VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
+				    VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
+	}
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL4, tmp);
+}
+
+static void mmhub_v1_8_enable_system_domain(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	tmp = RREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_CNTL);
+	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
+	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH,
+			adev->gmc.vmid0_page_table_depth);
+	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_BLOCK_SIZE,
+			adev->gmc.vmid0_page_table_block_size);
+	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL,
+			    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
+	WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_CNTL, tmp);
+}
+
+static void mmhub_v1_8_disable_identity_aperture(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32, 0xFFFFFFFF);
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32, 0x0000000F);
+
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32, 0);
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32, 0);
+
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32, 0);
+	WREG32_SOC15(MMHUB, 0, regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32, 0);
+}
+
+static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	unsigned num_level, block_size;
+	uint32_t tmp;
+	int i;
+
+	num_level = adev->vm_manager.num_level;
+	block_size = adev->vm_manager.block_size;
+	if (adev->gmc.translate_further)
+		num_level -= 1;
+	else
+		block_size -= 9;
+
+	for (i = 0; i <= 14; i++) {
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
+				    num_level);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT,
+				    1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    PAGE_TABLE_BLOCK_SIZE,
+				    block_size);
+		/* On Aldebaran, XNACK can be enabled in the SQ per-process.
+		 * Retry faults need to be enabled for that to work.
+		 */
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
+				    1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+				    i * hub->ctx_addr_distance,
+				    lower_32_bits(adev->vm_manager.max_pfn - 1));
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+				    i * hub->ctx_addr_distance,
+				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+	}
+}
+
+static void mmhub_v1_8_program_invalidation(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	unsigned i;
+
+	for (i = 0; i < 18; ++i) {
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+				    i * hub->eng_addr_distance, 0xffffffff);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+				    i * hub->eng_addr_distance, 0x1f);
+	}
+}
+
+static int mmhub_v1_8_gart_enable(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev)) {
+		/*
+		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
+		 * VF copy registers so vbios post doesn't program them, for
+		 * SRIOV driver need to program them
+		 */
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE,
+			     adev->gmc.vram_start >> 24);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP,
+			     adev->gmc.vram_end >> 24);
+	}
+
+	/* GART Enable. */
+	mmhub_v1_8_init_gart_aperture_regs(adev);
+	mmhub_v1_8_init_system_aperture_regs(adev);
+	mmhub_v1_8_init_tlb_regs(adev);
+	mmhub_v1_8_init_cache_regs(adev);
+
+	mmhub_v1_8_enable_system_domain(adev);
+	mmhub_v1_8_disable_identity_aperture(adev);
+	mmhub_v1_8_setup_vmid_config(adev);
+	mmhub_v1_8_program_invalidation(adev);
+
+	return 0;
+}
+
+static void mmhub_v1_8_gart_disable(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	u32 tmp;
+	u32 i;
+
+	/* Disable all tables */
+	for (i = 0; i < 16; i++)
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT0_CNTL,
+				    i * hub->ctx_distance, 0);
+
+	/* Setup TLB control */
+	tmp = RREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL);
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
+			    ENABLE_ADVANCED_DRIVER_MODEL, 0);
+	WREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
+
+	if (!amdgpu_sriov_vf(adev)) {
+		/* Setup L2 cache */
+		tmp = RREG32_SOC15(MMHUB, 0, regVM_L2_CNTL);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
+		WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL, tmp);
+		WREG32_SOC15(MMHUB, 0, regVM_L2_CNTL3, 0);
+	}
+}
+
+/**
+ * mmhub_v1_8_set_fault_enable_default - update GART/VM fault handling
+ *
+ * @adev: amdgpu_device pointer
+ * @value: true redirects VM faults to the default page
+ */
+static void mmhub_v1_8_set_fault_enable_default(struct amdgpu_device *adev, bool value)
+{
+	u32 tmp;
+
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	tmp = RREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			    PDE1_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			    PDE2_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			    TRANSLATE_FURTHER_PROTECTION_FAULT_ENABLE_DEFAULT,
+			    value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			    NACK_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			    READ_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	if (!value) {
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				    CRASH_ON_NO_RETRY_FAULT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				    CRASH_ON_RETRY_FAULT, 1);
+	}
+
+	WREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL, tmp);
+}
+
+static void mmhub_v1_8_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+
+	hub->ctx0_ptb_addr_lo32 =
+		SOC15_REG_OFFSET(MMHUB, 0,
+				 regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
+	hub->ctx0_ptb_addr_hi32 =
+		SOC15_REG_OFFSET(MMHUB, 0,
+				 regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
+	hub->vm_inv_eng0_req =
+		SOC15_REG_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_REQ);
+	hub->vm_inv_eng0_ack =
+		SOC15_REG_OFFSET(MMHUB, 0, regVM_INVALIDATE_ENG0_ACK);
+	hub->vm_context0_cntl =
+		SOC15_REG_OFFSET(MMHUB, 0, regVM_CONTEXT0_CNTL);
+	hub->vm_l2_pro_fault_status =
+		SOC15_REG_OFFSET(MMHUB, 0, regVM_L2_PROTECTION_FAULT_STATUS);
+	hub->vm_l2_pro_fault_cntl =
+		SOC15_REG_OFFSET(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL);
+
+	hub->ctx_distance = regVM_CONTEXT1_CNTL - regVM_CONTEXT0_CNTL;
+	hub->ctx_addr_distance = regVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
+		regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+	hub->eng_distance = regVM_INVALIDATE_ENG1_REQ - regVM_INVALIDATE_ENG0_REQ;
+	hub->eng_addr_distance = regVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
+		regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+
+}
+
+static int mmhub_v1_8_set_clockgating(struct amdgpu_device *adev,
+				      enum amd_clockgating_state state)
+{
+	return 0;
+}
+
+static void mmhub_v1_8_get_clockgating(struct amdgpu_device *adev, u64 *flags)
+{
+
+}
+
+const struct amdgpu_mmhub_funcs mmhub_v1_8_funcs = {
+	.get_fb_location = mmhub_v1_8_get_fb_location,
+	.init = mmhub_v1_8_init,
+	.gart_enable = mmhub_v1_8_gart_enable,
+	.set_fault_enable_default = mmhub_v1_8_set_fault_enable_default,
+	.gart_disable = mmhub_v1_8_gart_disable,
+	.setup_vm_pt_regs = mmhub_v1_8_setup_vm_pt_regs,
+	.set_clockgating = mmhub_v1_8_set_clockgating,
+	.get_clockgating = mmhub_v1_8_get_clockgating,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.h
new file mode 100644
index 000000000000..0bb36200e4e5
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.h
@@ -0,0 +1,28 @@
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
+#ifndef __MMHUB_V1_8_H__
+#define __MMHUB_V1_8_H__
+
+extern const struct amdgpu_mmhub_funcs mmhub_v1_8_funcs;
+
+#endif
-- 
2.39.2

