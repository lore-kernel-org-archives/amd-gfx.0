Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB58AC9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 17:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BD1410F6DD;
	Thu, 24 Sep 2026 17:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YhAs1vO8";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF35F10F6DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 17:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFbufgj4dGIh8HwWFpwEw2yEryJPEReYYHEzu2Y7XlbjH1TK39eAfj2RjRX2l1ZGbEir637qdbkxgzGqkscUNqZ/3pg8yebjJ0boav7pQZxD1EkpTWPAGWsVz5xNQgpxNOqAmsN2VsCnzXRzjUlBBFgCZVtnaIeo6h/Tw3Gd7qxGNtMX+W5B7TBoNDORFW7L3a55bdc+9o3SmTuoj9BX0LOVHE+4yQvClqidjPJagIUGANuTe5/gtNJ7/p8DwoKHB3iGRyazxF+I4qpKQVRG+M7whHaf4MaiYBI79AUqx2cpgWreYwn21quS4eo+npJDCGX4574TXuMDPEnwhJoGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89rB6gmVtNmOKeFTlJPPh+KwauZCEfnfNdf8jogm5k4=;
 b=WhUaXhR64T0rYMgjH0IDT4S9/YFERwutc2HB4AmQORVPhR66mAHKfGJNuvKVPChdOttZAmoi6WuJcAgNH4OMH4cf+kQUwbnwgTrltRaE2bymq5lrkBNrvpIveU5K4at5TgL8d9oaGiq0qRBxaxNb8wGPyFnXVTPfLkhcrz/B3n8SWQeCXakudgqZdVOXXDudYg/fMWlLXGHSfP7K4atOzi9/EBUYCUBm5reg4x50OBLsDLphiCQEuq5iJzT1u3wL+P7Bel/fKhb91Zr7J/WAYa9kv/1UZCEGnnFMTlH5AckGfr5cZKlXqwSszYYwlFINaYEzDiGQo56SWDI5xkDyEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89rB6gmVtNmOKeFTlJPPh+KwauZCEfnfNdf8jogm5k4=;
 b=YhAs1vO8gArBd8Vkpk3+ejoiY8fnaXVQzBKfVzRRsbL8ELedHkS/RnbapzZAdrr9cCCfWXoWROYvYlH6Tstvu1YzOlWnuYenqePhXjkFBKDz913WOIhpR2khPvhsz+uxeAgmPwFO+iVkB47JxH+rJ1bM5i2wdaTcYe9eC+b8RPM=
Received: from PH7P221CA0055.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::27)
 by DS5PPF2FA070BDF.namprd12.prod.outlook.com (2603:10b6:f:fc00::649)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 17:57:20 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:510:33c:cafe::42) by PH7P221CA0055.outlook.office365.com
 (2603:10b6:510:33c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 17:57:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 17:57:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:57:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:57:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 12:57:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Frank Min <Frank.Min@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add mmhub v5_0 support
Date: Thu, 24 Sep 2026 13:56:56 -0400
Message-ID: <20260924175656.636354-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924175656.636354-1-alexander.deucher@amd.com>
References: <20260924175656.636354-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|DS5PPF2FA070BDF:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f9974a-1ea6-41d0-1247-08df1a654315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|6133799003|22082099003|18002099003|3023799007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: C3ebuXDIJ37QG1YjIxxCsQYG587BGKORmuJffqAgqkM9+xR/5YhZSjDR/HMGXcNdkFio7Sgi0KXyDHDE0OV3+ZGcfWMxcC+WyZF44S+tK+NGtKA9/jqiTj4ZgA2NyGtEX64bD5lIm3glluYkkkZc87CptXuRlvoj3Bl8LC96mUgcQRvvg0BC67TrDcsg4LFDZtOSiUekg7l5s++pJX3jb4RwAP7Hdd9goXhQ7pm+O1L5LRpR2yZQc+ujb9x2dhXAerWbbNDpr5R9Q8+5uUoL5SSC2IWdUqHxfUV9pvnau33BTRccLPxqHss9uxufL3SnaN4CJIANOJ7SFt2A0lu753udR9msHI9a/tCyW+OFpHmMtuK1gD4qFNHL6gJ34dH52HU+9roIS0hh/T+regyOv68ThIQpd619gq/9K5a8iz9Z6yGjsmXUAHavW6xDU483Xx0ios2bKCyb7ZXaNtnX7ywv78eRryzg+avGJUg2ucmyfIV+MPydi2TgJSnu66n/qiCSD8aPB6+L8Jj4dMVUdWNEwWmHKNbYykZ9TT/0+QcfJ0O48bXbtE3F8ZQ8wWCelX4Y182it60RUohtszKqw1P9WcmOleKrwsjD4Ure8ZTRG/vaC3VAXAdYzarGhNadk47kbtzsM16Qxfu9e96yeiqtlRCdB8DKdavF326udYjoGc4HWF1N/PR7fEGUEjcs4m/c7IMrl4FoBzuUZEpekg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hdal4t1NJTpgwG1Rvxe3S1udADLkTLL+0yNAVPEz/HUZEmkEmqRVFZ7fjwFBWgsqtSHw4SdSQgqaw2N8eknuwNkS9bMEsTEiqD+eqASYxwuIg073Z4nFCeuiLBY6UrO2P+91iAfxoXVerke6j14b1sCdiEMgE20COieIGAEHrqXqPdLQt2Wqw7FezFizTuofk2LwGoIhkR8auLMkZ3vIa5zUwmFubIuWkJfhEVubpSWCv+oa4//nm6qOJXBS17RquFJWnWVGZevuIw1ozWvNGl85eeC1Y+p/YGauuWvSKv14OW0IX9BSYRmtCKlNPx/tUSSmijk8fZGoWMMPhtjDZBiRB8I0QLcMtuTzCDaZ4fpPl+plZdnZTEexm6cNLNb9cvHAntrrwcrIZRBq+fsxjsjcwX9jKwu8YzIyT90USSQRd6j7LhKU90wd0uxDb194
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 17:57:12.7975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f9974a-1ea6-41d0-1247-08df1a654315
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF2FA070BDF
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add initial implemenation for the new generation of mmhub

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |   2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.c | 603 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.h |  28 ++
 3 files changed, 632 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index cdad1f5776845..63a2f5fc99fc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -111,7 +111,7 @@ amdgpu-y += \
 	mmhub_v1_7.o gfxhub_v3_0.o mmhub_v3_0.o mmhub_v3_0_2.o gmc_v11_0.o \
 	mmhub_v3_0_1.o gfxhub_v3_0_3.o gfxhub_v1_2.o mmhub_v1_8.o mmhub_v3_3.o \
 	gfxhub_v11_5_0.o mmhub_v4_1_0.o gfxhub_v12_0.o gmc_v12_0.o \
-	mmhub_v4_2_0.o gfxhub_v12_1.o gmc_v12_1.o
+	mmhub_v4_2_0.o gfxhub_v12_1.o gmc_v12_1.o mmhub_v5_0.o
 
 # add UMC block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.c
new file mode 100644
index 0000000000000..1a43fe0d5f27e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.c
@@ -0,0 +1,603 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#include "mmhub_v5_0.h"
+
+#include "mmhub/mmhub_5_0_1_offset.h"
+#include "mmhub/mmhub_5_0_1_sh_mask.h"
+
+#include "soc15_common.h"
+#include "soc24_enum.h"
+
+#define regMMVM_L2_CNTL3_DEFAULT				0x80100007
+#define regMMVM_L2_CNTL4_DEFAULT				0x000000c1
+#define regMMVM_L2_CNTL5_DEFAULT				0x00003fe0
+
+static const char *mmhub_client_ids_v5_0[][2] = {
+	[0][0] = "VMC",
+	[4][0] = "DCEDMC",
+	[5][0] = "DCEVGA",
+	[6][0] = "MP0",
+	[7][0] = "MP1",
+	[8][0] = "MPIO",
+	[16][0] = "HDP",
+	[17][0] = "LSDMA",
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
+};
+
+static uint32_t mmhub_v5_0_get_invalidate_req(unsigned int vmid,
+					      uint32_t flush_type)
+{
+	u32 req = 0;
+
+	/* invalidate using legacy mode on vmid*/
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	/* Only use legacy inv on mmhub side */
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, 0);
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
+static void mmhub_v5_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
+							uint32_t status)
+{
+	uint32_t cid, rw;
+	const char *mmhub_cid = NULL;
+
+	cid = REG_GET_FIELD(status,
+			    MMVM_L2_PROTECTION_FAULT_STATUS_LO32, CID);
+	rw = REG_GET_FIELD(status,
+			   MMVM_L2_PROTECTION_FAULT_STATUS_LO32, RW);
+
+	dev_err(adev->dev,
+		"MMVM_L2_PROTECTION_FAULT_STATUS_LO32:0x%08X\n",
+		status);
+	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
+	case IP_VERSION(5, 0, 1):
+		mmhub_cid = mmhub_client_ids_v5_0[cid][rw];
+		break;
+	default:
+		mmhub_cid = NULL;
+		break;
+	}
+	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+		mmhub_cid ? mmhub_cid : "unknown", cid);
+	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS_LO32, MORE_FAULTS));
+	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS_LO32, WALKER_ERROR));
+	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS_LO32, PERMISSION_FAULTS));
+	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS_LO32, MAPPING_ERROR));
+	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
+}
+
+static void mmhub_v5_0_setup_vm_pt_regs(struct amdgpu_device *adev,
+					uint32_t vmid, uint64_t page_table_base)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
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
+static void mmhub_v5_0_init_gart_aperture_regs(struct amdgpu_device *adev)
+{
+	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+
+	mmhub_v5_0_setup_vm_pt_regs(adev, 0, pt_base);
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
+static void mmhub_v5_0_init_system_aperture_regs(struct amdgpu_device *adev)
+{
+	uint64_t value;
+	uint32_t tmp;
+
+	/*
+	 * the new L1 policy will block SRIOV guest from writing
+	 * these regs, and they will be programed at host.
+	 * so skip programing these regs.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	/* Program the AGP BAR */
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
+	/* Program the system aperture low logical page number. */
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
+
+	/* Set default page address. */
+	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
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
+static void mmhub_v5_0_init_tlb_regs(struct amdgpu_device *adev)
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
+static void mmhub_v5_0_init_cache_regs(struct amdgpu_device *adev)
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
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_CNTL5, tmp);
+}
+
+static void mmhub_v5_0_enable_system_domain(struct amdgpu_device *adev)
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
+static void mmhub_v5_0_disable_identity_aperture(struct amdgpu_device *adev)
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
+static void mmhub_v5_0_setup_vmid_config(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
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
+static void mmhub_v5_0_program_invalidation(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
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
+static int mmhub_v5_0_gart_enable(struct amdgpu_device *adev)
+{
+	/* GART Enable. */
+	mmhub_v5_0_init_gart_aperture_regs(adev);
+	mmhub_v5_0_init_system_aperture_regs(adev);
+	mmhub_v5_0_init_tlb_regs(adev);
+	mmhub_v5_0_init_cache_regs(adev);
+
+	mmhub_v5_0_enable_system_domain(adev);
+	mmhub_v5_0_disable_identity_aperture(adev);
+	mmhub_v5_0_setup_vmid_config(adev);
+	mmhub_v5_0_program_invalidation(adev);
+
+	return 0;
+}
+
+static void mmhub_v5_0_gart_disable(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
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
+ * mmhub_v5_0_set_fault_enable_default - update GART/VM fault handling
+ *
+ * @adev: amdgpu_device pointer
+ * @value: true redirects VM faults to the default page
+ */
+static void mmhub_v5_0_set_fault_enable_default(struct amdgpu_device *adev,
+						bool value)
+{
+	u32 tmp;
+
+	/* These registers are not accessible to VF-SRIOV.
+	 * The PF will program them instead.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	tmp = RREG32_SOC15(MMHUB, 0, regMMVM_L2_PROTECTION_FAULT_CNTL_LO32);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+			    PDE0_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+			    PDE1_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+			    PDE2_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+			    TRANSLATE_FURTHER_PROTECTION_FAULT_ENABLE_DEFAULT,
+			    value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+			    NACK_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+			    DUMMY_PAGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+			    VALID_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+			    READ_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+			    WRITE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+			    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+			    CLIENT_ID_NO_RETRY_FAULT_INTERRUPT, value ? 0xFFFF : 0);
+	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+			    OTHER_CLIENT_ID_NO_RETRY_FAULT_INTERRUPT, value);
+	if (!value)
+		tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL_LO32,
+				    CRASH_ON_NO_RETRY_FAULT, 1);
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_PROTECTION_FAULT_CNTL_LO32, tmp);
+
+	tmp = RREG32_SOC15(MMHUB, 0, regMMVM_L2_PROTECTION_FAULT_CNTL_HI32);
+	if (!value)
+		tmp = REG_SET_FIELD(tmp,
+				    MMVM_L2_PROTECTION_FAULT_CNTL_HI32,
+				    CRASH_ON_RETRY_FAULT, 1);
+	WREG32_SOC15(MMHUB, 0, regMMVM_L2_PROTECTION_FAULT_CNTL_HI32, tmp);
+}
+
+static const struct amdgpu_vmhub_funcs mmhub_v5_0_vmhub_funcs = {
+	.print_l2_protection_fault_status = mmhub_v5_0_print_l2_protection_fault_status,
+	.get_invalidate_req = mmhub_v5_0_get_invalidate_req,
+};
+
+static void mmhub_v5_0_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
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
+		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_L2_PROTECTION_FAULT_STATUS_LO32);
+	hub->vm_l2_pro_fault_cntl =
+		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_L2_PROTECTION_FAULT_CNTL_LO32);
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
+	hub->vm_contexts_disable =
+		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_CONTEXTS_DISABLE);
+
+	hub->vmhub_funcs = &mmhub_v5_0_vmhub_funcs;
+}
+
+static u64 mmhub_v5_0_get_fb_location(struct amdgpu_device *adev)
+{
+	u64 base;
+
+	base = RREG32_SOC15(MMHUB, 0, regMMMC_VM_FB_LOCATION_BASE);
+
+	base &= MMMC_VM_FB_LOCATION_BASE__FB_BASE_MASK;
+	base <<= 24;
+
+	return base;
+}
+
+static u64 mmhub_v5_0_get_mc_fb_offset(struct amdgpu_device *adev)
+{
+	return (u64)RREG32_SOC15(MMHUB, 0, regMMMC_VM_FB_OFFSET) << 24;
+}
+
+static void mmhub_v5_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+							bool enable)
+{
+	uint32_t def1, data1, def2 = 0, data2 = 0;
+	def1 = data1 = RREG32_SOC15(MMHUB, 0, regDAGB0_CNTL_MISC2);
+	def2 = data2 = RREG32_SOC15(MMHUB, 0, regDAGB1_CNTL_MISC2);
+
+	if (enable) {
+		data1 &= ~(DAGB0_CNTL_MISC2__DISABLE_RDRET_TAP_CHAIN_FGCG_MASK |
+			   DAGB0_CNTL_MISC2__DISABLE_WRRET_TAP_CHAIN_FGCG_MASK);
+
+		data2 &= ~(DAGB1_CNTL_MISC2__DISABLE_RDRET_TAP_CHAIN_FGCG_MASK |
+			   DAGB1_CNTL_MISC2__DISABLE_WRRET_TAP_CHAIN_FGCG_MASK);
+	} else {
+		data1 |= (DAGB0_CNTL_MISC2__DISABLE_RDRET_TAP_CHAIN_FGCG_MASK |
+			  DAGB0_CNTL_MISC2__DISABLE_WRRET_TAP_CHAIN_FGCG_MASK);
+
+		data2 |= (DAGB1_CNTL_MISC2__DISABLE_RDRET_TAP_CHAIN_FGCG_MASK |
+			  DAGB1_CNTL_MISC2__DISABLE_WRRET_TAP_CHAIN_FGCG_MASK);
+	}
+
+	if (def1 != data1)
+		WREG32_SOC15(MMHUB, 0, regDAGB0_CNTL_MISC2, data1);
+
+	if (def2 != data2)
+		WREG32_SOC15(MMHUB, 0, regDAGB1_CNTL_MISC2, data2);
+}
+
+static void mmhub_v5_0_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+						       bool enable)
+{
+}
+
+static int mmhub_v5_0_set_clockgating(struct amdgpu_device *adev,
+				      enum amd_clockgating_state state)
+{
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	if (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG)
+		mmhub_v5_0_update_medium_grain_clock_gating(adev,
+				state == AMD_CG_STATE_GATE);
+
+	if (adev->cg_flags & AMD_CG_SUPPORT_MC_LS)
+		mmhub_v5_0_update_medium_grain_light_sleep(adev,
+				state == AMD_CG_STATE_GATE);
+
+	return 0;
+}
+
+static void mmhub_v5_0_get_clockgating(struct amdgpu_device *adev, u64 *flags)
+{
+}
+
+const struct amdgpu_mmhub_funcs mmhub_v5_0_funcs = {
+	.init = mmhub_v5_0_init,
+	.get_fb_location = mmhub_v5_0_get_fb_location,
+	.get_mc_fb_offset = mmhub_v5_0_get_mc_fb_offset,
+	.gart_enable = mmhub_v5_0_gart_enable,
+	.set_fault_enable_default = mmhub_v5_0_set_fault_enable_default,
+	.gart_disable = mmhub_v5_0_gart_disable,
+	.set_clockgating = mmhub_v5_0_set_clockgating,
+	.get_clockgating = mmhub_v5_0_get_clockgating,
+	.setup_vm_pt_regs = mmhub_v5_0_setup_vm_pt_regs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.h
new file mode 100644
index 0000000000000..4b9b3eafb45b0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v5_0.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#ifndef __MMHUB_V5_0_H__
+#define __MMHUB_V5_0_H__
+
+extern const struct amdgpu_mmhub_funcs mmhub_v5_0_funcs;
+
+#endif
-- 
2.55.0

