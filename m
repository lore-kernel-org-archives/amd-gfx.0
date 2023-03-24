Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183A5C6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 22:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C48510ECA5;
	Fri, 24 Mar 2023 22:00:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA2EB10E295
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 22:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/9tZut8r0QKsVCtG13EuXNkIygI5ObLih4o3+5KZ8gCNodfzC+ND/kbLzddlmDw8L6UzbxbMnOvfFmHba2EQ3ghX985tgABRBHC0TgYOUdk3wZh3s6QCkrfGUgJW316bL+Q3CWpJAn8lZyMwBwJ5x4BhQL1Hmb4JSYQsk+sdOCpjT064fdpQe7cp++SW06nuP+Yoqb9D2ifrVzVz/+fYvoQtCwrY8ngDVsWhFLopnLSQ9qI9y0eY1WjZqvriLELgYq5YoHaKTBnZRPvlly4RRbMJVnGqgGf5jmcr60EKlGQCrM4UVzX6MoI+vc3Z0T0USht7M5wVMLGUkCpwWkZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej2S8yYjqV4buqT1HmZzWnIsdOm/IG6O1t5aUenSmhQ=;
 b=KxJFVFqJ6wqxBVEx9kiEUCnum1OirWzmRLhFiuOdC2n2jz0o/bzF5mI5ujp7MWdM1uBG6SBwOzt6fYwCYMdfSM0PczoJz8eI1u/FaahBYEeMrD2e8Fc9yqc6Bc/JSK3eojw+jMCf+x/jO4PZ/hnREmQJye1O3VkElGUiSEmp+MEZaFxyFvvgDlwoYlfegiztNzzuLrcUira5h+gPwXRzysKFjGcpjD0WTfsnqMU+1LZTbrdjPyzWfcc8j4kL2xIpSECMzsQgKO9Nc7mBGvCKVX3l6stwj4L0h2gdDikjUbHOIHOmAoXLq+dDN7J7A4Bso1U5w8eqstFYLaH+Jo9vig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej2S8yYjqV4buqT1HmZzWnIsdOm/IG6O1t5aUenSmhQ=;
 b=Pn8KcMxnDjjxytnqjJxO3Sfl/0gd7Zs55uIhKLf6xkyeQYGPQV0bq6E5ZxtVL5dmRNLpPVt9BCTYjE2k2N4qw5gi/OHdAsmNaBAWjY8AUUgpdEVBAydLTU5ByAHapDGc/8ORMEhw719i6KjoacuAbNS11VN+mrmU5f5N6tsOEZk=
Received: from MW4PR03CA0057.namprd03.prod.outlook.com (2603:10b6:303:8e::32)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 22:00:09 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::78) by MW4PR03CA0057.outlook.office365.com
 (2603:10b6:303:8e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 22:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Fri, 24 Mar 2023 22:00:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 17:00:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/9] drm/amdgpu: add gfxhub v1_2 support
Date: Fri, 24 Mar 2023 17:59:46 -0400
Message-ID: <20230324215949.2560463-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 2167c3ed-a6bb-44ca-9c5e-08db2cb32246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bc3HLkPcUoG9Sl449LNYk/iIxBJtpVkrBxwp1JpOIXBVYo0QkYYl5F30h55kXOXb8+eh5mEXTkEZmEMz+3Yrb5ua/FfKhsiDuDkoZEAXgVPz1D0S/4rpqZa89zon1Mp7KDHSGFJcHHSawd88ud9CtadkCw3Tlo8UbyXWHKL6bJ9Ep5Ih0NHdmqEN5Fnq+ttZ7/O7Q/T0+VcVO3c84MlEXgDJszrPQFttSbjs06sGDj3W0KLW4KKMmGtPzPX4QPXmhJJ4/Y/hZpwLEL1JvbNWbeEUwP7WeFCUYq0BqBVt9Hnt23M+XxnZELJcAVbaUxQjpWiYNjpRVWJBeXJU7DBgUAIsyz0eSVQPsB0/TbG+DOILqNxFnYu+0EGfMkZlC7qUgZI8Ei9doT3/nqwQW7wq0dVRPI06nphxOCa18mUqP+7wM76e1v42lPiq0cuzVELjK2pE5RUeyLngc9Vb9qGAiwdV4ar1kx78AACGn9SWgMixeyglzYrVB3N+aHTlY9nCoARwM2Wi3Uo9OPtHtdhXNmwZVQiP5tNsvIkYm+fWfrsCtdwg860aqJFYzP2qLPpx7BQuRxhBQEU0xPQkSEmMrWmxHr0wVPz8s3nVibMCSKWQiYx5qltmAxQJYox/w2msPCK7ELdhn7mM9P8L+pM1o3CcLnsJ6aDvp1mY2wMmNjJnZDo6/v341UbSUJW+H77dQhaUdD+Diiu9kbxOjK43lwUrS+vaX2qbJu0Odaua9Vo4Tn9KtErxx8w36gsKCSv0wwsw5sxC9m7EddN7liLwhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(66899021)(41300700001)(30864003)(478600001)(54906003)(2906002)(336012)(82310400005)(356005)(7696005)(6666004)(81166007)(36860700001)(186003)(86362001)(40460700003)(2616005)(16526019)(6916009)(316002)(5660300002)(70206006)(8936002)(4326008)(83380400001)(8676002)(36756003)(47076005)(40480700001)(426003)(70586007)(82740400003)(26005)(1076003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 22:00:08.7471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2167c3ed-a6bb-44ca-9c5e-08db2cb32246
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
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

Hack the gc 9.0 reg offset for initial support

v2: squash in header switch (Alex)

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 471 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.h |  29 ++
 3 files changed, 501 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index f2e4dfe8884f..e49b6a888c7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -93,7 +93,7 @@ amdgpu-y += \
 	gfxhub_v1_0.o mmhub_v1_0.o gmc_v9_0.o gfxhub_v1_1.o mmhub_v9_4.o \
 	gfxhub_v2_0.o mmhub_v2_0.o gmc_v10_0.o gfxhub_v2_1.o mmhub_v2_3.o \
 	mmhub_v1_7.o gfxhub_v3_0.o mmhub_v3_0.o mmhub_v3_0_2.o gmc_v11_0.o \
-	mmhub_v3_0_1.o gfxhub_v3_0_3.o
+	mmhub_v3_0_1.o gfxhub_v3_0_3.o gfxhub_v1_2.o
 
 # add UMC block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
new file mode 100644
index 000000000000..c59c6c85fbff
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -0,0 +1,471 @@
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
+#include "gfxhub_v1_2.h"
+#include "gfxhub_v1_1.h"
+
+#include "gc/gc_9_4_3_offset.h"
+#include "gc/gc_9_4_3_sh_mask.h"
+#include "vega10_enum.h"
+
+#include "soc15_common.h"
+
+#define regVM_L2_CNTL3_DEFAULT	0x80100007
+#define regVM_L2_CNTL4_DEFAULT	0x000000c1
+
+static u64 gfxhub_v1_2_get_mc_fb_offset(struct amdgpu_device *adev)
+{
+	return (u64)RREG32_SOC15(GC, 0, regMC_VM_FB_OFFSET) << 24;
+}
+
+static void gfxhub_v1_2_setup_vm_pt_regs(struct amdgpu_device *adev,
+					 uint32_t vmid,
+					 uint64_t page_table_base)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+
+	WREG32_SOC15_OFFSET(GC, 0, regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+			    hub->ctx_addr_distance * vmid,
+			    lower_32_bits(page_table_base));
+
+	WREG32_SOC15_OFFSET(GC, 0, regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+			    hub->ctx_addr_distance * vmid,
+			    upper_32_bits(page_table_base));
+}
+
+static void gfxhub_v1_2_init_gart_aperture_regs(struct amdgpu_device *adev)
+{
+	uint64_t pt_base;
+
+	if (adev->gmc.pdb0_bo)
+		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
+	else
+		pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+
+	gfxhub_v1_2_setup_vm_pt_regs(adev, 0, pt_base);
+
+	/* If use GART for FB translation, vmid0 page table covers both
+	 * vram and system memory (gart)
+	 */
+	if (adev->gmc.pdb0_bo) {
+		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+				(u32)(adev->gmc.fb_start >> 12));
+		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+				(u32)(adev->gmc.fb_start >> 44));
+
+		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+				(u32)(adev->gmc.gart_end >> 12));
+		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+				(u32)(adev->gmc.gart_end >> 44));
+	} else {
+		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+				(u32)(adev->gmc.gart_start >> 12));
+		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+				(u32)(adev->gmc.gart_start >> 44));
+
+		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+				(u32)(adev->gmc.gart_end >> 12));
+		WREG32_SOC15(GC, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+				(u32)(adev->gmc.gart_end >> 44));
+	}
+}
+
+static void gfxhub_v1_2_init_system_aperture_regs(struct amdgpu_device *adev)
+{
+	uint64_t value;
+	uint32_t tmp;
+
+	/* Program the AGP BAR */
+	WREG32_SOC15_RLC(GC, 0, regMC_VM_AGP_BASE, 0);
+	WREG32_SOC15_RLC(GC, 0, regMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15_RLC(GC, 0, regMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
+	if (!amdgpu_sriov_vf(adev) || adev->asic_type <= CHIP_VEGA10) {
+		/* Program the system aperture low logical page number. */
+		WREG32_SOC15_RLC(GC, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
+
+		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+			/*
+			* Raven2 has a HW issue that it is unable to use the
+			* vram which is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR.
+			* So here is the workaround that increase system
+			* aperture high address (add 1) to get rid of the VM
+			* fault and hardware hang.
+			*/
+			WREG32_SOC15_RLC(GC, 0,
+					 regMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+					 max((adev->gmc.fb_end >> 18) + 0x1,
+					     adev->gmc.agp_end >> 18));
+		else
+			WREG32_SOC15_RLC(GC, 0,
+				regMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+				max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
+
+		/* Set default page address. */
+		value = amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
+		WREG32_SOC15(GC, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+			     (u32)(value >> 12));
+		WREG32_SOC15(GC, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+			     (u32)(value >> 44));
+
+		/* Program "protection fault". */
+		WREG32_SOC15(GC, 0, regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+			     (u32)(adev->dummy_page_addr >> 12));
+		WREG32_SOC15(GC, 0, regVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+			     (u32)((u64)adev->dummy_page_addr >> 44));
+
+		tmp = RREG32_SOC15(GC, 0, regVM_L2_PROTECTION_FAULT_CNTL2);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
+				    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+		WREG32_SOC15(GC, 0, regVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+	}
+
+	/* In the case squeezing vram into GART aperture, we don't use
+	 * FB aperture and AGP aperture. Disable them.
+	 */
+	if (adev->gmc.pdb0_bo) {
+		WREG32_SOC15(GC, 0, regMC_VM_FB_LOCATION_TOP, 0);
+		WREG32_SOC15(GC, 0, regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+		WREG32_SOC15(GC, 0, regMC_VM_AGP_TOP, 0);
+		WREG32_SOC15(GC, 0, regMC_VM_AGP_BOT, 0xFFFFFF);
+		WREG32_SOC15(GC, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
+		WREG32_SOC15(GC, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
+	}
+}
+
+static void gfxhub_v1_2_init_tlb_regs(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	/* Setup TLB control */
+	tmp = RREG32_SOC15(GC, 0, regMC_VM_MX_L1_TLB_CNTL);
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
+	WREG32_SOC15_RLC(GC, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
+}
+
+static void gfxhub_v1_2_init_cache_regs(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	/* Setup L2 cache */
+	tmp = RREG32_SOC15(GC, 0, regVM_L2_CNTL);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 1);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_FRAGMENT_PROCESSING, 1);
+	/* XXX for emulation, Refer to closed source code.*/
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, L2_PDE0_CACHE_TAG_GENERATION_MODE,
+			    0);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, PDE_FAULT_CLASSIFICATION, 0);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, CONTEXT1_IDENTITY_ACCESS_MODE, 1);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, IDENTITY_MODE_FRAGMENT_SIZE, 0);
+	WREG32_SOC15_RLC(GC, 0, regVM_L2_CNTL, tmp);
+
+	tmp = RREG32_SOC15(GC, 0, regVM_L2_CNTL2);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_ALL_L1_TLBS, 1);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
+	WREG32_SOC15_RLC(GC, 0, regVM_L2_CNTL2, tmp);
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
+	WREG32_SOC15_RLC(GC, 0, regVM_L2_CNTL3, tmp);
+
+	tmp = regVM_L2_CNTL4_DEFAULT;
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 1);
+	} else {
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
+		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
+	}
+	WREG32_SOC15_RLC(GC, 0, regVM_L2_CNTL4, tmp);
+}
+
+static void gfxhub_v1_2_enable_system_domain(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	tmp = RREG32_SOC15(GC, 0, regVM_CONTEXT0_CNTL);
+	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
+	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH,
+			adev->gmc.vmid0_page_table_depth);
+	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_BLOCK_SIZE,
+			adev->gmc.vmid0_page_table_block_size);
+	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL,
+			    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
+	WREG32_SOC15(GC, 0, regVM_CONTEXT0_CNTL, tmp);
+}
+
+static void gfxhub_v1_2_disable_identity_aperture(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(GC, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
+		     0XFFFFFFFF);
+	WREG32_SOC15(GC, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
+		     0x0000000F);
+
+	WREG32_SOC15(GC, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32,
+		     0);
+	WREG32_SOC15(GC, 0, regVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32,
+		     0);
+
+	WREG32_SOC15(GC, 0, regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32, 0);
+	WREG32_SOC15(GC, 0, regVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32, 0);
+
+}
+
+static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
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
+		tmp = RREG32_SOC15_OFFSET(GC, 0, regVM_CONTEXT1_CNTL, i);
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
+		/* Send no-retry XNACK on fault to suppress VM fault storm.
+		 * On Aldebaran, XNACK can be enabled in the SQ per-process.
+		 * Retry faults need to be enabled for that to work.
+		 */
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
+				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
+				    !adev->gmc.noretry ||
+				    adev->asic_type == CHIP_ALDEBARAN);
+		WREG32_SOC15_OFFSET(GC, 0, regVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
+		WREG32_SOC15_OFFSET(GC, 0,
+				    regVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(GC, 0,
+				    regVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(GC, 0,
+				    regVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+				    i * hub->ctx_addr_distance,
+				    lower_32_bits(adev->vm_manager.max_pfn - 1));
+		WREG32_SOC15_OFFSET(GC, 0,
+				    regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+				    i * hub->ctx_addr_distance,
+				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+	}
+}
+
+static void gfxhub_v1_2_program_invalidation(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	unsigned i;
+
+	for (i = 0 ; i < 18; ++i) {
+		WREG32_SOC15_OFFSET(GC, 0, regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+				    i * hub->eng_addr_distance, 0xffffffff);
+		WREG32_SOC15_OFFSET(GC, 0, regVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+				    i * hub->eng_addr_distance, 0x1f);
+	}
+}
+
+static int gfxhub_v1_2_gart_enable(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev) && adev->asic_type != CHIP_ARCTURUS) {
+		/*
+		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
+		 * VF copy registers so vbios post doesn't program them, for
+		 * SRIOV driver need to program them
+		 */
+		WREG32_SOC15_RLC(GC, 0, regMC_VM_FB_LOCATION_BASE,
+			     adev->gmc.vram_start >> 24);
+		WREG32_SOC15_RLC(GC, 0, regMC_VM_FB_LOCATION_TOP,
+			     adev->gmc.vram_end >> 24);
+	}
+
+	/* GART Enable. */
+	gfxhub_v1_2_init_gart_aperture_regs(adev);
+	gfxhub_v1_2_init_system_aperture_regs(adev);
+	gfxhub_v1_2_init_tlb_regs(adev);
+	if (!amdgpu_sriov_vf(adev))
+		gfxhub_v1_2_init_cache_regs(adev);
+
+	gfxhub_v1_2_enable_system_domain(adev);
+	if (!amdgpu_sriov_vf(adev))
+		gfxhub_v1_2_disable_identity_aperture(adev);
+	gfxhub_v1_2_setup_vmid_config(adev);
+	gfxhub_v1_2_program_invalidation(adev);
+
+	return 0;
+}
+
+static void gfxhub_v1_2_gart_disable(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	u32 tmp;
+	u32 i;
+
+	/* Disable all tables */
+	for (i = 0; i < 16; i++)
+		WREG32_SOC15_OFFSET(GC, 0, regVM_CONTEXT0_CNTL,
+				    i * hub->ctx_distance, 0);
+
+	/* Setup TLB control */
+	tmp = RREG32_SOC15(GC, 0, regMC_VM_MX_L1_TLB_CNTL);
+	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
+	tmp = REG_SET_FIELD(tmp,
+				MC_VM_MX_L1_TLB_CNTL,
+				ENABLE_ADVANCED_DRIVER_MODEL,
+				0);
+	WREG32_SOC15_RLC(GC, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
+
+	/* Setup L2 cache */
+	tmp = RREG32_SOC15(GC, 0, regVM_L2_CNTL);
+	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
+	WREG32_SOC15(GC, 0, regVM_L2_CNTL, tmp);
+	WREG32_SOC15(GC, 0, regVM_L2_CNTL3, 0);
+}
+
+/**
+ * gfxhub_v1_2_set_fault_enable_default - update GART/VM fault handling
+ *
+ * @adev: amdgpu_device pointer
+ * @value: true redirects VM faults to the default page
+ */
+static void gfxhub_v1_2_set_fault_enable_default(struct amdgpu_device *adev,
+						 bool value)
+{
+	u32 tmp;
+	tmp = RREG32_SOC15(GC, 0, regVM_L2_PROTECTION_FAULT_CNTL);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			PDE1_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			PDE2_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp,
+			VM_L2_PROTECTION_FAULT_CNTL,
+			TRANSLATE_FURTHER_PROTECTION_FAULT_ENABLE_DEFAULT,
+			value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			NACK_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			VALID_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			READ_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+			EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	if (!value) {
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				CRASH_ON_NO_RETRY_FAULT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
+				CRASH_ON_RETRY_FAULT, 1);
+	}
+	WREG32_SOC15(GC, 0, regVM_L2_PROTECTION_FAULT_CNTL, tmp);
+}
+
+static void gfxhub_v1_2_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+
+	hub->ctx0_ptb_addr_lo32 =
+		SOC15_REG_OFFSET(GC, 0,
+				regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
+	hub->ctx0_ptb_addr_hi32 =
+		SOC15_REG_OFFSET(GC, 0,
+				regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
+	hub->vm_inv_eng0_sem =
+		SOC15_REG_OFFSET(GC, 0, regVM_INVALIDATE_ENG0_SEM);
+	hub->vm_inv_eng0_req =
+		SOC15_REG_OFFSET(GC, 0, regVM_INVALIDATE_ENG0_REQ);
+	hub->vm_inv_eng0_ack =
+		SOC15_REG_OFFSET(GC, 0, regVM_INVALIDATE_ENG0_ACK);
+	hub->vm_context0_cntl =
+		SOC15_REG_OFFSET(GC, 0, regVM_CONTEXT0_CNTL);
+	hub->vm_l2_pro_fault_status =
+		SOC15_REG_OFFSET(GC, 0, regVM_L2_PROTECTION_FAULT_STATUS);
+	hub->vm_l2_pro_fault_cntl =
+		SOC15_REG_OFFSET(GC, 0, regVM_L2_PROTECTION_FAULT_CNTL);
+
+	hub->ctx_distance = regVM_CONTEXT1_CNTL - regVM_CONTEXT0_CNTL;
+	hub->ctx_addr_distance = regVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
+		regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+	hub->eng_distance = regVM_INVALIDATE_ENG1_REQ - regVM_INVALIDATE_ENG0_REQ;
+	hub->eng_addr_distance = regVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
+		regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+}
+
+
+const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs = {
+	.get_mc_fb_offset = gfxhub_v1_2_get_mc_fb_offset,
+	.setup_vm_pt_regs = gfxhub_v1_2_setup_vm_pt_regs,
+	.gart_enable = gfxhub_v1_2_gart_enable,
+	.gart_disable = gfxhub_v1_2_gart_disable,
+	.set_fault_enable_default = gfxhub_v1_2_set_fault_enable_default,
+	.init = gfxhub_v1_2_init,
+	.get_xgmi_info = gfxhub_v1_1_get_xgmi_info,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.h b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.h
new file mode 100644
index 000000000000..e2d508f5a7ee
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.h
@@ -0,0 +1,29 @@
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
+#ifndef __GFXHUB_V1_2_H__
+#define __GFXHUB_V1_2_H__
+
+extern const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs;
+
+#endif
-- 
2.39.2

