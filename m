Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91539C2FC0F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 18:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1117410E564;
	Thu, 17 Aug 2023 18:15:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 127D110E55A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 18:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5PQumZ8l26M/C0G14sBFG+boj0Saw5h47+vE8lQohyUTnnYz7UR20VtqTRwlEEXo05SU0V7ndr28JjUKSFhZ+vK4oeeCykxzWEBrXmptRjmIfKFdT/aOpLxqeOYo1Qj4JIgBSl3az0luECDOKP7TwnfaveUNq49XkNsu8cc/1pNJjiG+YObAWVMKSFAuw56QHbpE4dGKXA7m63YriXKhhxW2rC6OeqbiUfmquHGtGOshMXdjTMXCYxskkHLvFAw+J3RSzqnDn/ZMdLs/i2iTWJpq+pqAY5hmGKGuaZpMUTIUgEElc3pNdHcmu9MIeQ/j4B6/XBPFQRBqrNXnxVmAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvlgW4jfJZvHl4x/zX6AQt91iH2QlAycwenpfcQtmLU=;
 b=iECTXmOP+3SEwndTHY26G7wbfnCSZ/3LL1MjkzWUqJty872Lk2uLJmSSSJK7wkNqLFZ162HnhdD3GOJkMdkOgYzJ2sI7ugEAfvTE0j95Tpqa13yYbX31hXJjr4WhGZ68S/45nVbm+hwAdHGhXoVOT+xcdry8GsHBxa+EG/ngF9F/qc08RkLZW/BsTOorYMhmIska9wqhqlAZdRk3dyg+RGRqsTu35VIpIaLk0Wawba92guqRA61RjpD3Hf6P3Yx233MienVV5yaBBR7oztRrQLMwSmLZc3HqMtG9ytc4tKnVG9om3jryIc8IZM4l9C5rH0WleyHS2Ch9V4ra73y9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvlgW4jfJZvHl4x/zX6AQt91iH2QlAycwenpfcQtmLU=;
 b=SiM+dIOX9SNNxS8GSGCtintPHbjq9usyNwlS7GzjYzVrqX4ibxFKjRx61Aj5MX2xwb4eL0gHHSEEsanUw5ynWnbbQAf7IEY3RCcfwFqke5Zo8aPyJzwVP6ztO6tjpC/WzSXsHUZW08dgByUfoisnStqAhjQFzYGrwxng0WTu5NY=
Received: from BN9PR03CA0687.namprd03.prod.outlook.com (2603:10b6:408:10e::32)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 18:15:26 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::f1) by BN9PR03CA0687.outlook.office365.com
 (2603:10b6:408:10e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Thu, 17 Aug 2023 18:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 17 Aug 2023 18:15:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 13:15:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: add gfxhub 11.5.0 support
Date: Thu, 17 Aug 2023 14:15:10 -0400
Message-ID: <20230817181510.1544991-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817181510.1544991-1-alexander.deucher@amd.com>
References: <20230817181510.1544991-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc09ce5-66ea-4535-b7a9-08db9f4dee4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G03wYW1n/Ad1Nj1h/Kx89X9AxGse/a0eZkydFKNgHbY0wWpCdPJoKOvXKIt/PkswN2KttyKzjj7LldcEfgd0jDnf4YqElOKxAuX7TYBuZuibPTlf5U1N3+21q3Ho1YP0kCsWTiIQw0gmaT7p4g1qBCJoL9dsY7Hf+FOXhkKPrbJlkqqseYIXpNInGt8NvIkeCJMR1u2j1jLSoVVa3vq0fedGwoPRmSAkWC0JAJPz2XpfcbIgi9eZRa2OpSlVYfahBTQgBdx1CqvNDIm+BOA3L4/F8HZVkb8tfpgxzgoLpZfoQpCTWS5RjkOBlxBnpqKzktGwO0tr8kGWxrJaxVxbULbpVpfLmkbv0aU6axWX1nE1r/mANFsBP6p3ulnl6Q22NP0KhiKSExo0aaa2SU7ei1cPG7lmVPrpGAB6wsqNaC8Hs0uIafBRlFW+wZj4NwjliUUEZCeDot5fMGZIm2STc9bZbf+1VfiacvJT9GIq8nWSQ5eqriyRnBIzDF8HAGD3gkFMqkOLAn/OEtK7LOhRHSYa/zdZ6LrxXcc1K1BgRLCW3lPNUTAn41ccQid/HZUjRDvPQ8ezoYcO2rPipD2dCaHtpDsFTikVBcui7e2sglwNksybo0lKG9ymG30iECWNyEg09Fjcq1ifKBwL7MXMs/POfdjbgsciLPqKxnHxHcgXZveB3rCQv6NNRfVBtt4E7iQQaHNKsM/qWhIFcKrl8FnVscGL5DrsYCqmFNVG8JAGeiPtfbsMXIXkKwa9xLAz/nQ+KDyytsosczfyTrQPUPevOtbahWgyjBndWzBoDlE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(1800799009)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(83380400001)(66899024)(54906003)(6916009)(316002)(70206006)(70586007)(478600001)(81166007)(356005)(82740400003)(30864003)(2906002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(36860700001)(47076005)(426003)(6666004)(7696005)(1076003)(26005)(16526019)(336012)(2616005)(86362001)(36756003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:15:26.0666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc09ce5-66ea-4535-b7a9-08db9f4dee4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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

Add initial gfxhub 11.5 support.

Signed-off-by: benl <ben.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 517 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.h |  29 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |   4 +
 4 files changed, 552 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 9c5684e5dbf2..2a4d960b8347 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -113,7 +113,8 @@ amdgpu-y += \
 	gfxhub_v1_0.o mmhub_v1_0.o gmc_v9_0.o gfxhub_v1_1.o mmhub_v9_4.o \
 	gfxhub_v2_0.o mmhub_v2_0.o gmc_v10_0.o gfxhub_v2_1.o mmhub_v2_3.o \
 	mmhub_v1_7.o gfxhub_v3_0.o mmhub_v3_0.o mmhub_v3_0_2.o gmc_v11_0.o \
-	mmhub_v3_0_1.o gfxhub_v3_0_3.o gfxhub_v1_2.o mmhub_v1_8.o mmhub_v3_3.o
+	mmhub_v3_0_1.o gfxhub_v3_0_3.o gfxhub_v1_2.o mmhub_v1_8.o mmhub_v3_3.o \
+	gfxhub_v11_5_0.o
 
 # add UMC block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
new file mode 100644
index 000000000000..2eb3386ae7ac
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -0,0 +1,517 @@
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
+#include "gfxhub_v11_5_0.h"
+
+#include "gc/gc_11_5_0_offset.h"
+#include "gc/gc_11_5_0_sh_mask.h"
+
+#include "navi10_enum.h"
+#include "soc15_common.h"
+
+#define regGCVM_L2_CNTL3_DEFAULT                0x80100007
+#define regGCVM_L2_CNTL4_DEFAULT                0x000000c1
+#define regGCVM_L2_CNTL5_DEFAULT                0x00003fe0
+
+
+static const char *gfxhub_client_ids[] = {
+	"CB/DB",
+	"Reserved",
+	"GE1",
+	"GE2",
+	"CPF",
+	"CPC",
+	"CPG",
+	"RLC",
+	"TCP",
+	"SQC (inst)",
+	"SQC (data)",
+	"SQG",
+	"Reserved",
+	"SDMA0",
+	"SDMA1",
+	"GCR",
+	"SDMA2",
+	"SDMA3",
+};
+
+static uint32_t gfxhub_v11_5_0_get_invalidate_req(unsigned int vmid,
+					       uint32_t flush_type)
+{
+	u32 req = 0;
+
+	/* invalidate using legacy mode on vmid*/
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+static void
+gfxhub_v11_5_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					     uint32_t status)
+{
+	u32 cid = REG_GET_FIELD(status,
+				GCVM_L2_PROTECTION_FAULT_STATUS, CID);
+
+	dev_err(adev->dev,
+		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
+		status);
+	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+		cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
+		cid);
+	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
+	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
+	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
+	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
+	dev_err(adev->dev, "\t RW: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, RW));
+}
+
+static u64 gfxhub_v11_5_0_get_fb_location(struct amdgpu_device *adev)
+{
+	u64 base = RREG32_SOC15(GC, 0, regGCMC_VM_FB_LOCATION_BASE);
+
+	base &= GCMC_VM_FB_LOCATION_BASE__FB_BASE_MASK;
+	base <<= 24;
+
+	return base;
+}
+
+static u64 gfxhub_v11_5_0_get_mc_fb_offset(struct amdgpu_device *adev)
+{
+	return (u64)RREG32_SOC15(GC, 0, regGCMC_VM_FB_OFFSET) << 24;
+}
+
+static void gfxhub_v11_5_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
+				uint64_t page_table_base)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+
+	WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+			    hub->ctx_addr_distance * vmid,
+			    lower_32_bits(page_table_base));
+
+	WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+			    hub->ctx_addr_distance * vmid,
+			    upper_32_bits(page_table_base));
+}
+
+static void gfxhub_v11_5_0_init_gart_aperture_regs(struct amdgpu_device *adev)
+{
+	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+
+	gfxhub_v11_5_0_setup_vm_pt_regs(adev, 0, pt_base);
+
+	WREG32_SOC15(GC, 0, regGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+		     (u32)(adev->gmc.gart_start >> 12));
+	WREG32_SOC15(GC, 0, regGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+		     (u32)(adev->gmc.gart_start >> 44));
+
+	WREG32_SOC15(GC, 0, regGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+		     (u32)(adev->gmc.gart_end >> 12));
+	WREG32_SOC15(GC, 0, regGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+		     (u32)(adev->gmc.gart_end >> 44));
+}
+
+static void gfxhub_v11_5_0_init_system_aperture_regs(struct amdgpu_device *adev)
+{
+	uint64_t value;
+
+	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
+	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
+	/* Program the system aperture low logical page number. */
+	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
+
+	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
+
+	/* Set default page address. */
+	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start
+		+ adev->vm_manager.vram_base_offset;
+	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+		     (u32)(value >> 12));
+	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+		     (u32)(value >> 44));
+
+	/* Program "protection fault". */
+	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+		     (u32)(adev->dummy_page_addr >> 12));
+	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+		     (u32)((u64)adev->dummy_page_addr >> 44));
+
+	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
+		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+}
+
+static void gfxhub_v11_5_0_init_tlb_regs(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	/* Setup TLB control */
+	tmp = RREG32_SOC15(GC, 0, regGCMC_VM_MX_L1_TLB_CNTL);
+
+	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 1);
+	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL, SYSTEM_ACCESS_MODE, 3);
+	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
+			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
+	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
+			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
+	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
+	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
+			    MTYPE, MTYPE_UC); /* UC, uncached */
+
+	WREG32_SOC15(GC, 0, regGCMC_VM_MX_L1_TLB_CNTL, tmp);
+}
+
+static void gfxhub_v11_5_0_init_cache_regs(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	/* These registers are not accessible to VF-SRIOV.
+	 * The PF will program them instead.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	/* Setup L2 cache */
+	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_CNTL);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, ENABLE_L2_CACHE, 1);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, ENABLE_L2_FRAGMENT_PROCESSING, 0);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
+			    ENABLE_DEFAULT_PAGE_OUT_TO_SYSTEM_MEMORY, 1);
+	/* XXX for emulation, Refer to closed source code.*/
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL,
+			    L2_PDE0_CACHE_TAG_GENERATION_MODE, 0);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, PDE_FAULT_CLASSIFICATION, 0);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, CONTEXT1_IDENTITY_ACCESS_MODE, 1);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL, IDENTITY_MODE_FRAGMENT_SIZE, 0);
+	WREG32_SOC15(GC, 0, regGCVM_L2_CNTL, tmp);
+
+	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_CNTL2);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL2, INVALIDATE_ALL_L1_TLBS, 1);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
+	WREG32_SOC15(GC, 0, regGCVM_L2_CNTL2, tmp);
+
+	tmp = regGCVM_L2_CNTL3_DEFAULT;
+	if (adev->gmc.translate_further) {
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL3, BANK_SELECT, 12);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL3,
+				    L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
+	} else {
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL3, BANK_SELECT, 9);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL3,
+				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
+	}
+	WREG32_SOC15(GC, 0, regGCVM_L2_CNTL3, tmp);
+
+	tmp = regGCVM_L2_CNTL4_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
+	WREG32_SOC15(GC, 0, regGCVM_L2_CNTL4, tmp);
+
+	tmp = regGCVM_L2_CNTL5_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL5, L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
+	WREG32_SOC15(GC, 0, regGCVM_L2_CNTL5, tmp);
+}
+
+static void gfxhub_v11_5_0_enable_system_domain(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	tmp = RREG32_SOC15(GC, 0, regGCVM_CONTEXT0_CNTL);
+	tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
+	tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH, 0);
+	tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT0_CNTL,
+			    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
+	WREG32_SOC15(GC, 0, regGCVM_CONTEXT0_CNTL, tmp);
+}
+
+static void gfxhub_v11_5_0_disable_identity_aperture(struct amdgpu_device *adev)
+{
+	/* These registers are not accessible to VF-SRIOV.
+	 * The PF will program them instead.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	WREG32_SOC15(GC, 0, regGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
+		     0xFFFFFFFF);
+	WREG32_SOC15(GC, 0, regGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
+		     0x0000000F);
+
+	WREG32_SOC15(GC, 0, regGCVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32,
+		     0);
+	WREG32_SOC15(GC, 0, regGCVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32,
+		     0);
+
+	WREG32_SOC15(GC, 0, regGCVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32, 0);
+	WREG32_SOC15(GC, 0, regGCVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32, 0);
+
+}
+
+static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	int i;
+	uint32_t tmp;
+
+	for (i = 0; i <= 14; i++) {
+		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
+				    adev->vm_manager.num_level);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+				RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+				DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+				PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+				VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+				READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+				WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+				EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+				PAGE_TABLE_BLOCK_SIZE,
+				adev->vm_manager.block_size - 9);
+		/* Send no-retry XNACK on fault to suppress VM fault storm. */
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
+				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
+				    !amdgpu_noretry);
+		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
+		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+				    i * hub->ctx_addr_distance,
+				    lower_32_bits(adev->vm_manager.max_pfn - 1));
+		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+				    i * hub->ctx_addr_distance,
+				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+	}
+
+	hub->vm_cntx_cntl = tmp;
+}
+
+static void gfxhub_v11_5_0_program_invalidation(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	unsigned i;
+
+	for (i = 0 ; i < 18; ++i) {
+		WREG32_SOC15_OFFSET(GC, 0, regGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+				    i * hub->eng_addr_distance, 0xffffffff);
+		WREG32_SOC15_OFFSET(GC, 0, regGCVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+				    i * hub->eng_addr_distance, 0x1f);
+	}
+}
+
+static int gfxhub_v11_5_0_gart_enable(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev)) {
+		/*
+		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
+		 * VF copy registers so vbios post doesn't program them, for
+		 * SRIOV driver need to program them
+		 */
+		WREG32_SOC15(GC, 0, regGCMC_VM_FB_LOCATION_BASE,
+			     adev->gmc.vram_start >> 24);
+		WREG32_SOC15(GC, 0, regGCMC_VM_FB_LOCATION_TOP,
+			     adev->gmc.vram_end >> 24);
+	}
+
+	/* GART Enable. */
+	gfxhub_v11_5_0_init_gart_aperture_regs(adev);
+	gfxhub_v11_5_0_init_system_aperture_regs(adev);
+	gfxhub_v11_5_0_init_tlb_regs(adev);
+	gfxhub_v11_5_0_init_cache_regs(adev);
+
+	gfxhub_v11_5_0_enable_system_domain(adev);
+	gfxhub_v11_5_0_disable_identity_aperture(adev);
+	gfxhub_v11_5_0_setup_vmid_config(adev);
+	gfxhub_v11_5_0_program_invalidation(adev);
+
+	return 0;
+}
+
+static void gfxhub_v11_5_0_gart_disable(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	u32 tmp;
+	u32 i;
+
+	/* Disable all tables */
+	for (i = 0; i < 16; i++)
+		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT0_CNTL,
+				    i * hub->ctx_distance, 0);
+
+	/* Setup TLB control */
+	tmp = RREG32_SOC15(GC, 0, regGCMC_VM_MX_L1_TLB_CNTL);
+	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
+	tmp = REG_SET_FIELD(tmp, GCMC_VM_MX_L1_TLB_CNTL,
+			    ENABLE_ADVANCED_DRIVER_MODEL, 0);
+	WREG32_SOC15(GC, 0, regGCMC_VM_MX_L1_TLB_CNTL, tmp);
+
+	/* Setup L2 cache */
+	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
+	WREG32_SOC15(GC, 0, regGCVM_L2_CNTL3, 0);
+}
+
+/**
+ * gfxhub_v11_5_0_set_fault_enable_default - update GART/VM fault handling
+ *
+ * @adev: amdgpu_device pointer
+ * @value: true redirects VM faults to the default page
+ */
+static void gfxhub_v11_5_0_set_fault_enable_default(struct amdgpu_device *adev,
+					  bool value)
+{
+	u32 tmp;
+
+	/* NO halt CP when page fault */
+	tmp = RREG32_SOC15(GC, 0, regCP_DEBUG);
+	tmp = REG_SET_FIELD(tmp, CP_DEBUG, CPG_UTCL1_ERROR_HALT_DISABLE, 1);
+	WREG32_SOC15(GC, 0, regCP_DEBUG, tmp);
+
+	/* These registers are not accessible to VF-SRIOV.
+	 * The PF will program them instead.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    PDE1_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    PDE2_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    TRANSLATE_FURTHER_PROTECTION_FAULT_ENABLE_DEFAULT,
+			    value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    NACK_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    READ_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	if (!value) {
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+				CRASH_ON_NO_RETRY_FAULT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
+				CRASH_ON_RETRY_FAULT, 1);
+	}
+	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
+}
+
+static const struct amdgpu_vmhub_funcs gfxhub_v11_5_0_vmhub_funcs = {
+	.print_l2_protection_fault_status = gfxhub_v11_5_0_print_l2_protection_fault_status,
+	.get_invalidate_req = gfxhub_v11_5_0_get_invalidate_req,
+};
+
+static void gfxhub_v11_5_0_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+
+	hub->ctx0_ptb_addr_lo32 =
+		SOC15_REG_OFFSET(GC, 0,
+				 regGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
+	hub->ctx0_ptb_addr_hi32 =
+		SOC15_REG_OFFSET(GC, 0,
+				 regGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
+	hub->vm_inv_eng0_sem =
+		SOC15_REG_OFFSET(GC, 0, regGCVM_INVALIDATE_ENG0_SEM);
+	hub->vm_inv_eng0_req =
+		SOC15_REG_OFFSET(GC, 0, regGCVM_INVALIDATE_ENG0_REQ);
+	hub->vm_inv_eng0_ack =
+		SOC15_REG_OFFSET(GC, 0, regGCVM_INVALIDATE_ENG0_ACK);
+	hub->vm_context0_cntl =
+		SOC15_REG_OFFSET(GC, 0, regGCVM_CONTEXT0_CNTL);
+	hub->vm_l2_pro_fault_status =
+		SOC15_REG_OFFSET(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS);
+	hub->vm_l2_pro_fault_cntl =
+		SOC15_REG_OFFSET(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL);
+
+	hub->ctx_distance = regGCVM_CONTEXT1_CNTL - regGCVM_CONTEXT0_CNTL;
+	hub->ctx_addr_distance = regGCVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
+		regGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+	hub->eng_distance = regGCVM_INVALIDATE_ENG1_REQ -
+		regGCVM_INVALIDATE_ENG0_REQ;
+	hub->eng_addr_distance = regGCVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
+		regGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+
+	hub->vm_cntx_cntl_vm_fault = GCVM_CONTEXT1_CNTL__RANGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__DUMMY_PAGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__PDE0_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__VALID_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
+
+	hub->vmhub_funcs = &gfxhub_v11_5_0_vmhub_funcs;
+}
+
+const struct amdgpu_gfxhub_funcs gfxhub_v11_5_0_funcs = {
+	.get_fb_location = gfxhub_v11_5_0_get_fb_location,
+	.get_mc_fb_offset = gfxhub_v11_5_0_get_mc_fb_offset,
+	.setup_vm_pt_regs = gfxhub_v11_5_0_setup_vm_pt_regs,
+	.gart_enable = gfxhub_v11_5_0_gart_enable,
+	.gart_disable = gfxhub_v11_5_0_gart_disable,
+	.set_fault_enable_default = gfxhub_v11_5_0_set_fault_enable_default,
+	.init = gfxhub_v11_5_0_init,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.h b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.h
new file mode 100644
index 000000000000..265ab631b3d0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.h
@@ -0,0 +1,29 @@
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
+#ifndef __GFXHUB_V11_5_0_H__
+#define __GFXHUB_V11_5_0_H__
+
+extern const struct amdgpu_gfxhub_funcs gfxhub_v11_5_0_funcs;
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 32be5ea4b9c3..dcbba981462e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -42,6 +42,7 @@
 #include "nbio_v4_3.h"
 #include "gfxhub_v3_0.h"
 #include "gfxhub_v3_0_3.h"
+#include "gfxhub_v11_5_0.h"
 #include "mmhub_v3_0.h"
 #include "mmhub_v3_0_1.h"
 #include "mmhub_v3_0_2.h"
@@ -633,6 +634,9 @@ static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 3):
 		adev->gfxhub.funcs = &gfxhub_v3_0_3_funcs;
 		break;
+	case IP_VERSION(11, 5, 0):
+		adev->gfxhub.funcs = &gfxhub_v11_5_0_funcs;
+		break;
 	default:
 		adev->gfxhub.funcs = &gfxhub_v3_0_funcs;
 		break;
-- 
2.41.0

