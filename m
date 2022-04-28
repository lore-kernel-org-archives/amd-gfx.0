Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC28C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 18:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E755310EA1B;
	Thu, 28 Apr 2022 18:52:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C34A610EA18
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 18:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDqOnvobbu1cyC36ntU9hm32BoDYUHi+MAo1nz50/YDJEncbpZa1IF0dvAF2t2ZD/v0/fccv3yLrg5YXT5B7Q5lgwC8zQ/0F6zh17Zw9j73qoXgWqcrmFBijqJmtcDXHfdTM9AW+sz8K1rquZbCwfJiJ5jGJrbKxURQPoqWzDc5Ul/xLO7HUBxa1VvQJ1QsRW0CrecxSgp2YiKKNodJMPadgz6WTldIHCBsjD6zOL1YA5i4g3Ljc0M3dM4pCMzwGEQ1hZB34nDkerjMImxLc6nJa22btG4XhozJ7aSKIjBOLPNnTZhM9v+PYAlWp+6vI7/+HL5YyLcd+AnWskvpTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjuAcZROm0zQ7CYk8LBeKwM4egp84RkeuXBjFpsYge0=;
 b=Bzozf2VAxYq3rPdYt2HbSaIKQLzvBcBFYLpKaGxyhzgIXtDCHxFNzvIyf0IigDOWkxCwFiD+A4rFzcGRmHDyYBRRDM7MO+K+EvHwqGsbQiuSxJ5/m4YeZEq7Men8Swh5yh1J+zvUYtoF84uoeV7f6r2MTbV8ln+DKofkh6KGBzGd1Ulgy5tpgDKTQLPIB1Bfqdo81RQ/VCBHxMRjNE7otBIrGujX1p3dafyNAqocLU/hGEUJfCGNk6D+twq/Qoc1qWA2A4I2VW7HJHcpCcmkLtbArC/6eigcElwqmhIIKeuaxjaVpkpSbdFy+mV2N0nNM7yEG8t0UljBnAKlCq3oLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjuAcZROm0zQ7CYk8LBeKwM4egp84RkeuXBjFpsYge0=;
 b=x5ags2Nli72uns6Bay6WQSH8x1Pm0IFcKrjls/wp9Jn+fWmH0xms3GdYyEbcFkbwv6jcMCM712GD8xJ/zP/O+2/rGc8xONgeAJ4MGIDKUjeeGG1UmvC/8hohGmFAnfkJAPtJTy/io/0rRkwyXR0WfSbm5x27QpVjriUaz0OfKj0=
Received: from MW4PR04CA0274.namprd04.prod.outlook.com (2603:10b6:303:89::9)
 by BYAPR12MB2837.namprd12.prod.outlook.com (2603:10b6:a03:68::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 18:52:19 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::d1) by MW4PR04CA0274.outlook.office365.com
 (2603:10b6:303:89::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 28 Apr 2022 18:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 18:52:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 13:52:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add mmhub v3_0 ip block
Date: Thu, 28 Apr 2022 14:52:06 -0400
Message-ID: <20220428185206.652448-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428185206.652448-1-alexander.deucher@amd.com>
References: <20220428185206.652448-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 323407bb-0f2e-456c-dbeb-08da294838dd
X-MS-TrafficTypeDiagnostic: BYAPR12MB2837:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB28374DF61B4452D967C44B6BF7FD9@BYAPR12MB2837.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4O66Y2nSO8+HyuIFvhsbXs5XV45onmFaQuNILZRQYoMeuqq4e+k6RpAy1Hbkzvf/l0diP500io9dcDX+46hibovbkMjkAqAipMSAPfMfEJ0y856W2CDjiOjjvL+ojwW+mZlrFfjIy37PmCGhcXq5DkwUgxcTdbWDt/RQFVyVnST+DjF5CgBgXgHcYbqJf8YjXNP1tlnD0GHUnt7PcTVLcXc4dr7k4xdixOH2lFSUAEnc/cpkuNQWtCuRcG4fTOqCpQZAkSAca5ZV3IhWGfHi+54UVhHOlTFzZh7i6reoiUgrgjmhXJ59DHJ3gnBuqMR/XRxZNKQOkfkuHthocUW58W6pQJCc3eKtOMb318hKxqjUdkNxgqTMH2r2j6i8a+j+JBLXrl7Of2cdyVHahwy9iKFRDTOeoO9TduJL6RlMJvz4+6Ej5y79MXRiUXZOrhUZBq07L7WNb7vwS2veRxWFVQ0wuvnJxrMYMQj3o2wHEGGQWsglqfjRKJLTHm1dse3yahmBRODr35RDQWxBFbVBMfgo4ZhWW9eyBWQTMEoLg4p6hrMXbkLwAPJdJgc9eYcFhjM8ZXBZ46Sl8Paab0hZPlbp3NrzujQE3Y9cl1EwKQYywwLfW7R4Ulg1CgMnucPk7FiIPyc8152Tm5HI0ByAcaxEOOSo9CDJvSfrOi7/5V8qKYJHqfUJWYG/sWYFjEgG913L7iJfDAnTd+3g/O0/iSnZIr2DIZq0CXJjocse3Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(6916009)(40460700003)(5660300002)(316002)(54906003)(30864003)(36756003)(26005)(82310400005)(8936002)(8676002)(86362001)(70586007)(70206006)(4326008)(6666004)(7696005)(2616005)(36860700001)(1076003)(16526019)(336012)(186003)(2906002)(47076005)(356005)(83380400001)(81166007)(426003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:52:19.2763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 323407bb-0f2e-456c-dbeb-08da294838dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2837
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
 "Tianci.Yin" <tianci.yin@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

Add support for mmhub v3.0

Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h |   1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c   | 576 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.h   |  28 ++
 5 files changed, 607 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 5d447a38e63c..156de606f275 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -88,7 +88,7 @@ amdgpu-y += \
 	gmc_v8_0.o \
 	gfxhub_v1_0.o mmhub_v1_0.o gmc_v9_0.o gfxhub_v1_1.o mmhub_v9_4.o \
 	gfxhub_v2_0.o mmhub_v2_0.o gmc_v10_0.o gfxhub_v2_1.o mmhub_v2_3.o \
-	mmhub_v1_7.o gfxhub_v3_0.o
+	mmhub_v1_7.o gfxhub_v3_0.o mmhub_v3_0.o
 
 # add UMC block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index e7dc069c4512..4be6b657944a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -101,6 +101,7 @@ struct amdgpu_vmhub {
 	uint32_t	eng_addr_distance; /* include LO32/HI32 */
 
 	uint32_t	vm_cntx_cntl_vm_fault;
+	uint32_t	vm_l2_bank_select_reserved_cid2;
 
 	const struct amdgpu_vmhub_funcs *vmhub_funcs;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index f939395c5914..93430d3823c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -27,6 +27,7 @@ struct amdgpu_mmhub_ras {
 
 struct amdgpu_mmhub_funcs {
 	u64 (*get_fb_location)(struct amdgpu_device *adev);
+	u64 (*get_mc_fb_offset)(struct amdgpu_device *adev);
 	void (*init)(struct amdgpu_device *adev);
 	int (*gart_enable)(struct amdgpu_device *adev);
 	void (*set_fault_enable_default)(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
new file mode 100644
index 000000000000..74b5b2f2dfd3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -0,0 +1,576 @@
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
+#include "amdgpu.h"
+#include "mmhub_v3_0.h"
+
+#include "mmhub/mmhub_3_0_0_offset.h"
+#include "mmhub/mmhub_3_0_0_sh_mask.h"
+#include "navi10_enum.h"
+
+#include "soc15_common.h"
+
+#define regMMVM_L2_CNTL3_DEFAULT				0x80100007
+#define regMMVM_L2_CNTL4_DEFAULT				0x000000c1
+#define regMMVM_L2_CNTL5_DEFAULT				0x00003fe0
+
+static const char *mmhub_client_ids_v3_0_0[][2] = {
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
+static uint32_t mmhub_v3_0_get_invalidate_req(unsigned int vmid,
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
+mmhub_v3_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
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
+	switch (adev->ip_versions[MMHUB_HWIP][0]) {
+	case IP_VERSION(3, 0, 0):
+		mmhub_cid = mmhub_client_ids_v3_0_0[cid][rw];
+		break;
+	default:
+		mmhub_cid = NULL;
+		break;
+	}
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
+static void mmhub_v3_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
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
+static void mmhub_v3_0_init_gart_aperture_regs(struct amdgpu_device *adev)
+{
+	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+
+	mmhub_v3_0_setup_vm_pt_regs(adev, 0, pt_base);
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
+static void mmhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
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
+static void mmhub_v3_0_init_tlb_regs(struct amdgpu_device *adev)
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
+static void mmhub_v3_0_init_cache_regs(struct amdgpu_device *adev)
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
+static void mmhub_v3_0_enable_system_domain(struct amdgpu_device *adev)
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
+static void mmhub_v3_0_disable_identity_aperture(struct amdgpu_device *adev)
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
+static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
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
+}
+
+static void mmhub_v3_0_program_invalidation(struct amdgpu_device *adev)
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
+static int mmhub_v3_0_gart_enable(struct amdgpu_device *adev)
+{
+	/* GART Enable. */
+	mmhub_v3_0_init_gart_aperture_regs(adev);
+	mmhub_v3_0_init_system_aperture_regs(adev);
+	mmhub_v3_0_init_tlb_regs(adev);
+	mmhub_v3_0_init_cache_regs(adev);
+
+	mmhub_v3_0_enable_system_domain(adev);
+	mmhub_v3_0_disable_identity_aperture(adev);
+	mmhub_v3_0_setup_vmid_config(adev);
+	mmhub_v3_0_program_invalidation(adev);
+
+	return 0;
+}
+
+static void mmhub_v3_0_gart_disable(struct amdgpu_device *adev)
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
+ * mmhub_v3_0_set_fault_enable_default - update GART/VM fault handling
+ *
+ * @adev: amdgpu_device pointer
+ * @value: true redirects VM faults to the default page
+ */
+static void mmhub_v3_0_set_fault_enable_default(struct amdgpu_device *adev, bool value)
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
+static const struct amdgpu_vmhub_funcs mmhub_v3_0_vmhub_funcs = {
+	.print_l2_protection_fault_status = mmhub_v3_0_print_l2_protection_fault_status,
+	.get_invalidate_req = mmhub_v3_0_get_invalidate_req,
+};
+
+static void mmhub_v3_0_init(struct amdgpu_device *adev)
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
+	hub->vmhub_funcs = &mmhub_v3_0_vmhub_funcs;
+}
+
+static u64 mmhub_v3_0_get_fb_location(struct amdgpu_device *adev)
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
+static u64 mmhub_v3_0_get_mc_fb_offset(struct amdgpu_device *adev)
+{
+	return (u64)RREG32_SOC15(MMHUB, 0, regMMMC_VM_FB_OFFSET) << 24;
+}
+
+static void mmhub_v3_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+							bool enable)
+{
+	//TODO
+}
+
+static void mmhub_v3_0_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+						       bool enable)
+{
+	//TODO
+}
+
+static int mmhub_v3_0_set_clockgating(struct amdgpu_device *adev,
+			       enum amd_clockgating_state state)
+{
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	mmhub_v3_0_update_medium_grain_clock_gating(adev,
+			state == AMD_CG_STATE_GATE);
+	mmhub_v3_0_update_medium_grain_light_sleep(adev,
+			state == AMD_CG_STATE_GATE);
+	return 0;
+}
+
+static void mmhub_v3_0_get_clockgating(struct amdgpu_device *adev, u64 *flags)
+{
+	//TODO
+}
+
+const struct amdgpu_mmhub_funcs mmhub_v3_0_funcs = {
+	.init = mmhub_v3_0_init,
+	.get_fb_location = mmhub_v3_0_get_fb_location,
+	.get_mc_fb_offset = mmhub_v3_0_get_mc_fb_offset,
+	.gart_enable = mmhub_v3_0_gart_enable,
+	.set_fault_enable_default = mmhub_v3_0_set_fault_enable_default,
+	.gart_disable = mmhub_v3_0_gart_disable,
+	.set_clockgating = mmhub_v3_0_set_clockgating,
+	.get_clockgating = mmhub_v3_0_get_clockgating,
+	.setup_vm_pt_regs = mmhub_v3_0_setup_vm_pt_regs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.h
new file mode 100644
index 000000000000..3ced20f350bb
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.h
@@ -0,0 +1,28 @@
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
+#ifndef __MMHUB_V3_0_H__
+#define __MMHUB_V3_0_H__
+
+extern const struct amdgpu_mmhub_funcs mmhub_v3_0_funcs;
+
+#endif
-- 
2.35.1

