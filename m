Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A173C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4DD310F334;
	Tue,  3 May 2022 20:26:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B6B10F334
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEUKO5uueRdtz/hf5LNyyw7UvJMEb9tuMhc7mYeMxq0oFlUa/ggw18Ed4N7bkDiMiI6nujguVhlO5xQbHAmZEL6sk+9dXamXy8+7dVQuuAiw+78XZ///lWf9uIqb8J4ZkIkb9gt0rvIM4lHlSSogFIqB4QXo8Nq9b4c0RnqV/1WRcRZVefcpv40PCJNmD7s0zLlXRxZLdEz149gU1EQX61+vI4aHpB8LV8QyTsO0JUJFsCBPSrSqfJG0BHKkuGI9Fyy6ORkUdFq+fdo2O2QF2N6CcbgKYBflduegUdj5xb/847gYFIKNTdYa8esAa57o+4papHBPVghXzuygbufdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTLO/pl9RBLznmsI0vCVyCKQgyvujxn3Cn3FhjhRDDc=;
 b=HVI27Gyz1CSoR4ekV/EZyAPntGnwa2P8xSrUGJXI6d6R5lmUQEu2Z3aMTJ0jCOZJTV1jUJe1AXQovp+5ztDaIfl2zIIsYExrwRQVVksj/x1xyF7+Sxe74puSOOo1Ejwb6X3IDu7OhYz+//uL48THsFHYfARaS3KwkvWz3Qe+LAuUr7muDJCrdhjOspZKpcXiVMDKyqMlzYf2xBZO6HyYsFhPoaeOES2HyotpTFVrhD427Uf9tiRmdOgpMKa3jnr87qwhXbouHTjGZJHLKvEiySdDpnsTslVDUOCzLPOFr2dwtb2xAnYQ1KRHKbBKEK6Kt/T8TVX6NMwHxtR11owBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTLO/pl9RBLznmsI0vCVyCKQgyvujxn3Cn3FhjhRDDc=;
 b=JlkCg65Z8T5MUWXR03/2tghki7n+uGTowLlKS1yex9WPZTn83t7oXrNqAGoqU9aeVa2/dl1qdocscGEdfeUmhhqlix/R9h9EsBkUyT88FAzAOLKRLZPpXOYXaGQoSKS6WXWvn+AuBdul6RWVmIYidwhaWpYx2k+tczO9rAJ61/k=
Received: from BN0PR04CA0128.namprd04.prod.outlook.com (2603:10b6:408:ed::13)
 by CY4PR12MB1527.namprd12.prod.outlook.com (2603:10b6:910:5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:26:40 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::a0) by BN0PR04CA0128.outlook.office365.com
 (2603:10b6:408:ed::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:26:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:26:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add mmhub v3_0_2 ip callback functions
Date: Tue, 3 May 2022 16:26:26 -0400
Message-ID: <20220503202627.1210404-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202627.1210404-1-alexander.deucher@amd.com>
References: <20220503202627.1210404-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97814c49-31f1-4961-3d80-08da2d433af6
X-MS-TrafficTypeDiagnostic: CY4PR12MB1527:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB15272883F5CAE3269EFF8AFBF7C09@CY4PR12MB1527.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQ2T5DW6oLeot8tezEAQauorvJnkUE667Ra4CDiUWdS9GNDzwsj+5sGRIMxHN1S+zSyshneaXPppVGBeLJDXn06whdmo24oR80L/hRc8Mk7LCfSunTuSVsKh4WlSri+fxU/FXqDH68FAQdJLE+LIzzkdRXELM+OJHuSpJWQUi40UcfYtNnyu1A3yX+W87J24neybZjas2A3U6QSF+wvOhSBflFKNXf+Z+CVMZSZYfPVM30/lKMUeGm0ENRd1Xw2JxHRyFXeAYktgLVOER5DSRBAfyRldEqVyIP5w2aLzSdw2J8hMLS9vdShZA0ZeAcsqjJpKLs0NdL0dy2dhDbLOcjKOEU7XRE447ewatU5cxr2szWzYA7v7JcM9XQBoEXzZkLNbwg+w0BOPVoe1vdc9km2qYALYDpVRwh/idDocTyCRz09Ml0r+k3+Ly/ekTcoLBxVFw5Q7ihmZN+nxbK8Mfd8c9wtA0AgeOs/Pods4190hyusdv2QGZlmUS6CQzUhOuSPhkIcQD1rEvRz3GOpNRZNLkI18t+6pb8Azoaer+Cf6dQlYgeQRLVr+gRkotA7/OIAatam7ldpXScngkI1SSFuo6MoyvKq6KxoPHgAHhh/lZwONzVY8D/CZvGanRCUixX61LT36aE4QrttIT0NwZ6sYBeZOClwEVEZxVjcnnh9DylYfvsz4H92f/tWLU3VkQ7x9TYjifLEtjKre5PjgVzSccWbd/TYRPrhAJmYexPQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(54906003)(16526019)(5660300002)(4326008)(30864003)(6916009)(336012)(1076003)(426003)(2616005)(36756003)(186003)(316002)(86362001)(70206006)(81166007)(356005)(70586007)(8676002)(47076005)(82310400005)(508600001)(2906002)(36860700001)(8936002)(7696005)(26005)(40460700003)(83380400001)(6666004)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:26:40.0840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97814c49-31f1-4961-3d80-08da2d433af6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1527
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Unlike mmhub v3_0_0, there is no atc_l2 related
registers available in mmhub v3_0_2. Split the mmhub
v3_0_2 callback implementations from mmhub v3_0 so we
don't need to add ip version check when atc related
programming needs to be added to mmhub v3_0_0.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile       |   2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c | 571 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.h |  28 ++
 3 files changed, 600 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 7c7f946f1e6f..d4e7d297f883 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -88,7 +88,7 @@ amdgpu-y += \
 	gmc_v8_0.o \
 	gfxhub_v1_0.o mmhub_v1_0.o gmc_v9_0.o gfxhub_v1_1.o mmhub_v9_4.o \
 	gfxhub_v2_0.o mmhub_v2_0.o gmc_v10_0.o gfxhub_v2_1.o mmhub_v2_3.o \
-	mmhub_v1_7.o gfxhub_v3_0.o mmhub_v3_0.o gmc_v11_0.o
+	mmhub_v1_7.o gfxhub_v3_0.o mmhub_v3_0.o mmhub_v3_0_2.o gmc_v11_0.o
 
 # add UMC block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
new file mode 100644
index 000000000000..770be0a8f7ce
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -0,0 +1,571 @@
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
+#include "mmhub_v3_0_2.h"
+
+#include "mmhub/mmhub_3_0_2_offset.h"
+#include "mmhub/mmhub_3_0_2_sh_mask.h"
+#include "navi10_enum.h"
+
+#include "soc15_common.h"
+
+#define regMMVM_L2_CNTL3_DEFAULT				0x80100007
+#define regMMVM_L2_CNTL4_DEFAULT				0x000000c1
+#define regMMVM_L2_CNTL5_DEFAULT				0x00003fe0
+
+static const char *mmhub_client_ids_v3_0_2[][2] = {
+	[0][0] = "VMC",
+	[4][0] = "DCEDMC",
+	[5][0] = "DCEVGA",
+	[6][0] = "MP0",
+	[7][0] = "MP1",
+	[8][0] = "MPIO",
+	[16][0] = "HDP",
+	[17][0] = "LSDMA",
+	[18][0] = "JPEG",
+	[19][0] = "VCNU0",
+	[21][0] = "VSCH",
+	[22][0] = "VCNU1",
+	[23][0] = "VCN1",
+	[32+20][0] = "VCN0",
+	[2][1] = "DBGUNBIO",
+	[3][1] = "DCEDWB",
+	[4][1] = "DCEDMC",
+	[5][1] = "DCEVGA",
+	[6][1] = "MP0",
+	[7][1] = "MP1",
+	[8][1] = "MPIO",
+	[10][1] = "DBGU0",
+	[11][1] = "DBGU1",
+	[12][1] = "DBGU2",
+	[13][1] = "DBGU3",
+	[14][1] = "XDP",
+	[15][1] = "OSSSYS",
+	[16][1] = "HDP",
+	[17][1] = "LSDMA",
+	[18][1] = "JPEG",
+	[19][1] = "VCNU0",
+	[20][1] = "VCN0",
+	[21][1] = "VSCH",
+	[22][1] = "VCNU1",
+	[23][1] = "VCN1",
+};
+
+static uint32_t mmhub_v3_0_2_get_invalidate_req(unsigned int vmid,
+					      uint32_t flush_type)
+{
+	u32 req = 0;
+
+	/* invalidate using legacy mode on vmid*/
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+static void
+mmhub_v3_0_2_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					     uint32_t status)
+{
+	uint32_t cid, rw;
+	const char *mmhub_cid = NULL;
+
+	cid = REG_GET_FIELD(status,
+			    MMVM_L2_PROTECTION_FAULT_STATUS, CID);
+	rw = REG_GET_FIELD(status,
+			   MMVM_L2_PROTECTION_FAULT_STATUS, RW);
+
+	dev_err(adev->dev,
+		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
+		status);
+
+	mmhub_cid = mmhub_client_ids_v3_0_2[cid][rw];
+	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+		mmhub_cid ? mmhub_cid : "unknown", cid);
+	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
+	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
+	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
+	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
+	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
+}
+
+static void mmhub_v3_0_2_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
+				uint64_t page_table_base)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+
+	WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
+			    hub->ctx_addr_distance * vmid,
+			    lower_32_bits(page_table_base));
+
+	WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
+			    hub->ctx_addr_distance * vmid,
+			    upper_32_bits(page_table_base));
+}
+
+static void mmhub_v3_0_2_init_gart_aperture_regs(struct amdgpu_device *adev)
+{
+	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+
+	mmhub_v3_0_2_setup_vm_pt_regs(adev, 0, pt_base);
+
+	WREG32_SOC15(MMHUB, 0, regMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+		     (u32)(adev->gmc.gart_start >> 12));
+	WREG32_SOC15(MMHUB, 0, regMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+		     (u32)(adev->gmc.gart_start >> 44));
+
+	WREG32_SOC15(MMHUB, 0, regMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+		     (u32)(adev->gmc.gart_end >> 12));
+	WREG32_SOC15(MMHUB, 0, regMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+		     (u32)(adev->gmc.gart_end >> 44));
+}
+
+static void mmhub_v3_0_2_init_system_aperture_regs(struct amdgpu_device *adev)
+{
+	uint64_t value;
+	uint32_t tmp;
+
+	/* Disable AGP. */
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
+
+	if (!amdgpu_sriov_vf(adev)) {
+		/*
+		 * the new L1 policy will block SRIOV guest from writing
+		 * these regs, and they will be programed at host.
+		 * so skip programing these regs.
+		 */
+		/* Program the system aperture low logical page number. */
+		WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+			     adev->gmc.vram_start >> 18);
+		WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+			     adev->gmc.vram_end >> 18);
+	}
+
+	/* Set default page address. */
+	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
+		adev->vm_manager.vram_base_offset;
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+		     (u32)(value >> 12));
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+		     (u32)(value >> 44));
+
+	/* Program "protection fault". */
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
+		     (u32)(adev->dummy_page_addr >> 12));
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
+		     (u32)((u64)adev->dummy_page_addr >> 44));
+
+	tmp = RREG32_SOC15(MMHUB, 0, regMMVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL2,
+			    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
+}
+
+static void mmhub_v3_0_2_init_tlb_regs(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	/* Setup TLB control */
+	tmp = RREG32_SOC15(MMHUB, 0, regMMMC_VM_MX_L1_TLB_CNTL);
+
+	tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 1);
+	tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL, SYSTEM_ACCESS_MODE, 3);
+	tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
+			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
+	tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
+			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
+	tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
+	tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
+			    MTYPE, MTYPE_UC); /* UC, uncached */
+
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_MX_L1_TLB_CNTL, tmp);
+}
+
+static void mmhub_v3_0_2_init_cache_regs(struct amdgpu_device *adev)
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
+	tmp = RREG32_SOC15(MMHUB, 0, regMMVM_L2_CNTL);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, ENABLE_L2_CACHE, 1);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, ENABLE_L2_FRAGMENT_PROCESSING, 0);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL,
+			    ENABLE_DEFAULT_PAGE_OUT_TO_SYSTEM_MEMORY, 1);
+	/* XXX for emulation, Refer to closed source code.*/
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, L2_PDE0_CACHE_TAG_GENERATION_MODE,
+			    0);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, PDE_FAULT_CLASSIFICATION, 0);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, CONTEXT1_IDENTITY_ACCESS_MODE, 1);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, IDENTITY_MODE_FRAGMENT_SIZE, 0);
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_CNTL, tmp);
+
+	tmp = RREG32_SOC15(MMHUB, 0, regMMVM_L2_CNTL2);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL2, INVALIDATE_ALL_L1_TLBS, 1);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_CNTL2, tmp);
+
+	tmp = regMMVM_L2_CNTL3_DEFAULT;
+	if (adev->gmc.translate_further) {
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL3, BANK_SELECT, 12);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL3,
+				    L2_CACHE_BIGK_FRAGMENT_SIZE, 9);
+	} else {
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL3, BANK_SELECT, 9);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL3,
+				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
+	}
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_CNTL3, tmp);
+
+	tmp = regMMVM_L2_CNTL4_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_CNTL4, tmp);
+
+	tmp = regMMVM_L2_CNTL5_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL5, L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
+	WREG32_SOC15(GC, 0, regMMVM_L2_CNTL5, tmp);
+}
+
+static void mmhub_v3_0_2_enable_system_domain(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	tmp = RREG32_SOC15(MMHUB, 0, regMMVM_CONTEXT0_CNTL);
+	tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
+	tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH, 0);
+	tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
+			    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
+	WREG32_SOC15(MMHUB, 0, regMMVM_CONTEXT0_CNTL, tmp);
+}
+
+static void mmhub_v3_0_2_disable_identity_aperture(struct amdgpu_device *adev)
+{
+	/* These registers are not accessible to VF-SRIOV.
+	 * The PF will program them instead.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	WREG32_SOC15(MMHUB, 0,
+		     regMMVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
+		     0xFFFFFFFF);
+	WREG32_SOC15(MMHUB, 0,
+		     regMMVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32,
+		     0x0000000F);
+
+	WREG32_SOC15(MMHUB, 0,
+		     regMMVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_LO32, 0);
+	WREG32_SOC15(MMHUB, 0,
+		     regMMVM_L2_CONTEXT1_IDENTITY_APERTURE_HIGH_ADDR_HI32, 0);
+
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_LO32,
+		     0);
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_CONTEXT_IDENTITY_PHYSICAL_OFFSET_HI32,
+		     0);
+}
+
+static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	int i;
+	uint32_t tmp;
+
+	for (i = 0; i <= 14; i++) {
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
+				    adev->vm_manager.num_level);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+				    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+				    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT,
+				    1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+				    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+				    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+				    READ_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+				    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+				    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+				    PAGE_TABLE_BLOCK_SIZE,
+				    adev->vm_manager.block_size - 9);
+		/* Send no-retry XNACK on fault to suppress VM fault storm. */
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
+				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
+				    !amdgpu_noretry);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+				    i * hub->ctx_addr_distance,
+				    lower_32_bits(adev->vm_manager.max_pfn - 1));
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+				    i * hub->ctx_addr_distance,
+				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+	}
+
+	hub->vm_cntx_cntl = tmp;
+}
+
+static void mmhub_v3_0_2_program_invalidation(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	unsigned i;
+
+	for (i = 0; i < 18; ++i) {
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+				    i * hub->eng_addr_distance, 0xffffffff);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+				    i * hub->eng_addr_distance, 0x1f);
+	}
+}
+
+static int mmhub_v3_0_2_gart_enable(struct amdgpu_device *adev)
+{
+	/* GART Enable. */
+	mmhub_v3_0_2_init_gart_aperture_regs(adev);
+	mmhub_v3_0_2_init_system_aperture_regs(adev);
+	mmhub_v3_0_2_init_tlb_regs(adev);
+	mmhub_v3_0_2_init_cache_regs(adev);
+
+	mmhub_v3_0_2_enable_system_domain(adev);
+	mmhub_v3_0_2_disable_identity_aperture(adev);
+	mmhub_v3_0_2_setup_vmid_config(adev);
+	mmhub_v3_0_2_program_invalidation(adev);
+
+	return 0;
+}
+
+static void mmhub_v3_0_2_gart_disable(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+	u32 tmp;
+	u32 i;
+
+	/* Disable all tables */
+	for (i = 0; i < 16; i++)
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT0_CNTL,
+				    i * hub->ctx_distance, 0);
+
+	/* Setup TLB control */
+	tmp = RREG32_SOC15(MMHUB, 0, regMMMC_VM_MX_L1_TLB_CNTL);
+	tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
+	tmp = REG_SET_FIELD(tmp, MMMC_VM_MX_L1_TLB_CNTL,
+			    ENABLE_ADVANCED_DRIVER_MODEL, 0);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_MX_L1_TLB_CNTL, tmp);
+
+	/* Setup L2 cache */
+	tmp = RREG32_SOC15(MMHUB, 0, regMMVM_L2_CNTL);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL, ENABLE_L2_CACHE, 0);
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_CNTL, tmp);
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_CNTL3, 0);
+}
+
+/**
+ * mmhub_v3_0_2_set_fault_enable_default - update GART/VM fault handling
+ *
+ * @adev: amdgpu_device pointer
+ * @value: true redirects VM faults to the default page
+ */
+static void mmhub_v3_0_2_set_fault_enable_default(struct amdgpu_device *adev, bool value)
+{
+	u32 tmp;
+
+	/* These registers are not accessible to VF-SRIOV.
+	 * The PF will program them instead.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	tmp = RREG32_SOC15(MMHUB, 0, regMMVM_L2_PROTECTION_FAULT_CNTL);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
+			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
+			    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
+			    PDE1_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
+			    PDE2_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
+			    TRANSLATE_FURTHER_PROTECTION_FAULT_ENABLE_DEFAULT,
+			    value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
+			    NACK_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
+			    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
+			    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
+			    READ_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
+			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
+			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	if (!value) {
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
+				CRASH_ON_NO_RETRY_FAULT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
+				CRASH_ON_RETRY_FAULT, 1);
+	}
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_PROTECTION_FAULT_CNTL, tmp);
+}
+
+static const struct amdgpu_vmhub_funcs mmhub_v3_0_2_vmhub_funcs = {
+	.print_l2_protection_fault_status = mmhub_v3_0_2_print_l2_protection_fault_status,
+	.get_invalidate_req = mmhub_v3_0_2_get_invalidate_req,
+};
+
+static void mmhub_v3_0_2_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
+
+	hub->ctx0_ptb_addr_lo32 =
+		SOC15_REG_OFFSET(MMHUB, 0,
+				 regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
+	hub->ctx0_ptb_addr_hi32 =
+		SOC15_REG_OFFSET(MMHUB, 0,
+				 regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
+	hub->vm_inv_eng0_sem =
+		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_INVALIDATE_ENG0_SEM);
+	hub->vm_inv_eng0_req =
+		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_INVALIDATE_ENG0_REQ);
+	hub->vm_inv_eng0_ack =
+		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_INVALIDATE_ENG0_ACK);
+	hub->vm_context0_cntl =
+		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_CONTEXT0_CNTL);
+	hub->vm_l2_pro_fault_status =
+		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_L2_PROTECTION_FAULT_STATUS);
+	hub->vm_l2_pro_fault_cntl =
+		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_L2_PROTECTION_FAULT_CNTL);
+
+	hub->ctx_distance = regMMVM_CONTEXT1_CNTL - regMMVM_CONTEXT0_CNTL;
+	hub->ctx_addr_distance = regMMVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32 -
+		regMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+	hub->eng_distance = regMMVM_INVALIDATE_ENG1_REQ -
+		regMMVM_INVALIDATE_ENG0_REQ;
+	hub->eng_addr_distance = regMMVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
+		regMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+
+	hub->vm_cntx_cntl_vm_fault = MMVM_CONTEXT1_CNTL__RANGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		MMVM_CONTEXT1_CNTL__DUMMY_PAGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		MMVM_CONTEXT1_CNTL__PDE0_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		MMVM_CONTEXT1_CNTL__VALID_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		MMVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		MMVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
+		MMVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
+
+	hub->vm_l2_bank_select_reserved_cid2 =
+		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_L2_BANK_SELECT_RESERVED_CID2);
+
+	hub->vmhub_funcs = &mmhub_v3_0_2_vmhub_funcs;
+}
+
+static u64 mmhub_v3_0_2_get_fb_location(struct amdgpu_device *adev)
+{
+	u64 base;
+
+	base = RREG32_SOC15(MMHUB, 0, regMMMC_VM_FB_LOCATION_BASE);
+	base &= MMMC_VM_FB_LOCATION_BASE__FB_BASE_MASK;
+	base <<= 24;
+
+	return base;
+}
+
+static u64 mmhub_v3_0_2_get_mc_fb_offset(struct amdgpu_device *adev)
+{
+	return (u64)RREG32_SOC15(MMHUB, 0, regMMMC_VM_FB_OFFSET) << 24;
+}
+
+static void mmhub_v3_0_2_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+							bool enable)
+{
+	//TODO
+}
+
+static void mmhub_v3_0_2_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+						       bool enable)
+{
+	//TODO
+}
+
+static int mmhub_v3_0_2_set_clockgating(struct amdgpu_device *adev,
+			       enum amd_clockgating_state state)
+{
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	mmhub_v3_0_2_update_medium_grain_clock_gating(adev,
+			state == AMD_CG_STATE_GATE);
+	mmhub_v3_0_2_update_medium_grain_light_sleep(adev,
+			state == AMD_CG_STATE_GATE);
+	return 0;
+}
+
+static void mmhub_v3_0_2_get_clockgating(struct amdgpu_device *adev, u64 *flags)
+{
+	//TODO
+}
+
+const struct amdgpu_mmhub_funcs mmhub_v3_0_2_funcs = {
+	.init = mmhub_v3_0_2_init,
+	.get_fb_location = mmhub_v3_0_2_get_fb_location,
+	.get_mc_fb_offset = mmhub_v3_0_2_get_mc_fb_offset,
+	.gart_enable = mmhub_v3_0_2_gart_enable,
+	.set_fault_enable_default = mmhub_v3_0_2_set_fault_enable_default,
+	.gart_disable = mmhub_v3_0_2_gart_disable,
+	.set_clockgating = mmhub_v3_0_2_set_clockgating,
+	.get_clockgating = mmhub_v3_0_2_get_clockgating,
+	.setup_vm_pt_regs = mmhub_v3_0_2_setup_vm_pt_regs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.h
new file mode 100644
index 000000000000..23ad7b156cdb
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.h
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
+#ifndef __MMHUB_V3_0_2_H__
+#define __MMHUB_V3_0_2_H__
+
+extern const struct amdgpu_mmhub_funcs mmhub_v3_0_2_funcs;
+
+#endif
-- 
2.35.1

