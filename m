Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E84C3DA58
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 18:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A14510E55A;
	Thu, 17 Aug 2023 18:15:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D8D10E1CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 18:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjBqyCI0fpwMQ43yxhzebsXRWVdwZs9V5peZQo8zP7fw1A2c53fFN7KHZazAzSj6ONAKeBpixX/OdMh3IpB6cEAbMewIBZuiUiSzw2+8BmnTxlysPiSRI/XVlI2O7lSDJueSeAdLPv7WeZaDa17jDjRoUuy9955m4ywX3wIkKHuqXDtd5NvoCmI3zclVtRC3mj/UyzqAwmBj0MOzJfYdWBoeoUZgpNZV6EeuGCrSMSTsad1wZrwm2K/ZsX0lXzvZaCM3XVPmPkabpJa3LqKgIx/V+13SBsh0eyyYjwyGqtdX3ypX7aPEZqHwwWo4hixRs7OvKno/3RF4D3bY16Ke1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8amC+lV5jaLpcP1/iijIufFVJxfu7BgAYWNsBjeFHnk=;
 b=mkyvz7R0zGZCaTK4GVRmp89Rjqp3wHtomM9l5FldC84hi3BRLajHu60RpFIKFstdGkCvt6SZC4o77lim1K+btuN8d6UscF3ICQi07JwqD2fS46KrD2FtefROBafo0KI/dCVXZtLm24UIs/nsU0qEnVOivhiLtiOnGDBtQk5cRd5rG1fw4mgkrxJIkiFf0WbYtDRAY7aKhvyII/ed0p9bzuHUOasxtDrjvSjCcdaCYfQL5ewS2TYEKm9Tc/9PHwBDq+32uYWpQhTp4wZ/V3Oz1HAax9C4Kawj/A2b9gxHUFo67no7R9Q2me5GBmy6B+dJ1CMQBbvOiuIILce3KnnZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8amC+lV5jaLpcP1/iijIufFVJxfu7BgAYWNsBjeFHnk=;
 b=3WbBSLvuYYTqdM6qrB4PWQKihZGyXm/r7/s9S9dNs+6z9lTBs7wrZKRF3aXeFtrB9vEK3oiYsNmXJUwiVJh3AL4bntvQYfJ1RdXN3mbtVx9K7ypNFjqz1iwk7N0AiP9QqzuOmexAuDgjVxW0dUSggi4TitTKnmqSrZwlTz9xAbc=
Received: from BN9PR03CA0686.namprd03.prod.outlook.com (2603:10b6:408:10e::31)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 18:15:24 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::e8) by BN9PR03CA0686.outlook.office365.com
 (2603:10b6:408:10e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 18:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 17 Aug 2023 18:15:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 13:15:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: add mmhub 3.3.0 support
Date: Thu, 17 Aug 2023 14:15:08 -0400
Message-ID: <20230817181510.1544991-2-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 4966be5f-1802-4afe-d901-08db9f4ded27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GntK5ojUkcFxKrfFxBjbHgF6JDTldd9zxKBEoAPnhuVgxuJuhvmywZXdFTjVWbyPdKkiipTNP6UOmnzCxAkrPkGP/cZPJ4UdUzBY2SAIkvEYT4YL9Zu/Soo+Iq2mHXX1jJe12nRGPQlgnsKNHIHdu06kZqQ+6dgnKvPgalynQsmbNoessFqwb1csuLLpuWRMvzRXtaUIUMzsopTN/ku4N6C0sPE3Q2HM8acxCB8TJOgoDt+Tx0/+K2bgRWZWm6LcIQu7GAPeE+SDTL5o8clDW76HFocQR1Z758m8YFpocPABKSFhjFpqD+EpDO/2pJd7EHWmMPkhmWEIUXOIdcqMJ8Pw2YNu7WMs21oEW7sN+ySk1FlFyg3R1enxV93HDIlq9AQLOzuMe3FYUUXnGsgzdezVTsg6N/VRwC80x+D8pSCsLxsg03cnzutRZbtg/9dTtICDrdAkW5biV8GSnzhZ2MrXeU3qmNPIi0iIC9cEwylvmWhIqwWo8wmgHFI3BO6gBTMhy2bep6duUAbFdIQLtJRXImNRTfaLyggfupCYXA56LRMawMD+IqFP85ewj7ZWYe7s5ZWkm4u1MFEY1zC+Bdo/4bxBxDUTmzfiTSxV7TOH9BwZTsVLckw/Ep9uuNdd853oIpK23Rc62oziqyKOlEAKNUy70BiFZVqqbMiyb+S1O1Fghtk2WNFlHI8oatymDw2JDa1q8FoyM6XGEgXNmqQyfdKOlRCvbUIYznT4zZowrT27Foot0VsqFBnQCMPEJbr+yTdTtR7VtQYemiSKpf9QvcuiGJ/UKPndkUET9PA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82740400003)(356005)(81166007)(40480700001)(2616005)(5660300002)(16526019)(70586007)(478600001)(70206006)(7696005)(6666004)(54906003)(6916009)(316002)(26005)(1076003)(4326008)(8676002)(41300700001)(8936002)(40460700003)(47076005)(66899024)(336012)(36860700001)(83380400001)(426003)(30864003)(2906002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:15:24.2385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4966be5f-1802-4afe-d901-08db9f4ded27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add initial implementation for mmhub 3.3.0.

v2: squash in client id fix (Alex)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |   4 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 590 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.h |  29 ++
 4 files changed, 624 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 4add30ca2897..9c5684e5dbf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -113,7 +113,7 @@ amdgpu-y += \
 	gfxhub_v1_0.o mmhub_v1_0.o gmc_v9_0.o gfxhub_v1_1.o mmhub_v9_4.o \
 	gfxhub_v2_0.o mmhub_v2_0.o gmc_v10_0.o gfxhub_v2_1.o mmhub_v2_3.o \
 	mmhub_v1_7.o gfxhub_v3_0.o mmhub_v3_0.o mmhub_v3_0_2.o gmc_v11_0.o \
-	mmhub_v3_0_1.o gfxhub_v3_0_3.o gfxhub_v1_2.o mmhub_v1_8.o
+	mmhub_v3_0_1.o gfxhub_v3_0_3.o gfxhub_v1_2.o mmhub_v1_8.o mmhub_v3_3.o
 
 # add UMC block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 596571c94529..32be5ea4b9c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -45,6 +45,7 @@
 #include "mmhub_v3_0.h"
 #include "mmhub_v3_0_1.h"
 #include "mmhub_v3_0_2.h"
+#include "mmhub_v3_3.h"
 #include "athub_v3_0.h"
 
 
@@ -617,6 +618,9 @@ static void gmc_v11_0_set_mmhub_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(3, 0, 2):
 		adev->mmhub.funcs = &mmhub_v3_0_2_funcs;
 		break;
+	case IP_VERSION(3, 3, 0):
+		adev->mmhub.funcs = &mmhub_v3_3_funcs;
+		break;
 	default:
 		adev->mmhub.funcs = &mmhub_v3_0_funcs;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
new file mode 100644
index 000000000000..ec1fb329524d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -0,0 +1,590 @@
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
+#include "mmhub_v3_3.h"
+
+#include "mmhub/mmhub_3_3_0_offset.h"
+#include "mmhub/mmhub_3_3_0_sh_mask.h"
+
+#include "navi10_enum.h"
+#include "soc15_common.h"
+
+#define regMMVM_L2_CNTL3_DEFAULT				0x80100007
+#define regMMVM_L2_CNTL4_DEFAULT				0x000000c1
+#define regMMVM_L2_CNTL5_DEFAULT				0x00003fe0
+
+static const char *mmhub_client_ids_v3_3[][2] = {
+	[0][0] = "VMC",
+	[4][0] = "DCEDMC",
+	[6][0] = "MP0",
+	[7][0] = "MP1",
+	[8][0] = "MPM",
+	[24][0] = "HDP",
+	[25][0] = "LSDMA",
+	[26][0] = "JPEG",
+	[27][0] = "VPE",
+	[29][0] = "VCNU",
+	[30][0] = "VCN",
+	[3][1] = "DCEDWB",
+	[4][1] = "DCEDMC",
+	[6][1] = "MP0",
+	[7][1] = "MP1",
+	[8][1] = "MPM",
+	[21][1] = "OSSSYS",
+	[24][1] = "HDP",
+	[25][1] = "LSDMA",
+	[26][1] = "JPEG",
+	[27][1] = "VPE",
+	[29][1] = "VCNU",
+	[30][1] = "VCN",
+};
+
+static uint32_t mmhub_v3_3_get_invalidate_req(unsigned int vmid,
+						uint32_t flush_type)
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
+mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					      uint32_t status)
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
+	switch (adev->ip_versions[MMHUB_HWIP][0]) {
+	case IP_VERSION(3, 3, 0):
+		mmhub_cid = mmhub_client_ids_v3_3[cid][rw];
+		break;
+	default:
+		mmhub_cid = NULL;
+		break;
+	}
+
+	if (!mmhub_cid && cid == 0x140)
+		mmhub_cid = "UMSCH";
+
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
+static void mmhub_v3_3_setup_vm_pt_regs(struct amdgpu_device *adev,
+					  uint32_t vmid,
+					  uint64_t page_table_base)
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
+
+}
+
+static void mmhub_v3_3_init_gart_aperture_regs(struct amdgpu_device *adev)
+{
+	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+
+	mmhub_v3_3_setup_vm_pt_regs(adev, 0, pt_base);
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
+static void mmhub_v3_3_init_system_aperture_regs(struct amdgpu_device *adev)
+{
+	uint64_t value;
+	uint32_t tmp;
+
+	/* Program the AGP BAR */
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
+	/*
+	 * the new L1 policy will block SRIOV guest from writing
+	 * these regs, and they will be programed at host.
+	 * so skip programing these regs.
+	 */
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
+static void mmhub_v3_3_init_tlb_regs(struct amdgpu_device *adev)
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
+static void mmhub_v3_3_init_cache_regs(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
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
+static void mmhub_v3_3_enable_system_domain(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	tmp = RREG32_SOC15(MMHUB, 0, regMMVM_CONTEXT0_CNTL);
+	tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
+	tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH, 0);
+	tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
+			    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
+
+	WREG32_SOC15(MMHUB, 0, regMMVM_CONTEXT0_CNTL, tmp);
+}
+
+static void mmhub_v3_3_disable_identity_aperture(struct amdgpu_device *adev)
+{
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
+static void mmhub_v3_3_setup_vmid_config(struct amdgpu_device *adev)
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
+static void mmhub_v3_3_program_invalidation(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
+	unsigned int i;
+
+	for (i = 0; i < 18; ++i) {
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
+				    i * hub->eng_addr_distance, 0xffffffff);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
+				    i * hub->eng_addr_distance, 0x1f);
+	}
+}
+
+static int mmhub_v3_3_gart_enable(struct amdgpu_device *adev)
+{
+	/* GART Enable. */
+	mmhub_v3_3_init_gart_aperture_regs(adev);
+	mmhub_v3_3_init_system_aperture_regs(adev);
+	mmhub_v3_3_init_tlb_regs(adev);
+	mmhub_v3_3_init_cache_regs(adev);
+
+	mmhub_v3_3_enable_system_domain(adev);
+	mmhub_v3_3_disable_identity_aperture(adev);
+	mmhub_v3_3_setup_vmid_config(adev);
+	mmhub_v3_3_program_invalidation(adev);
+
+	return 0;
+}
+
+static void mmhub_v3_3_gart_disable(struct amdgpu_device *adev)
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
+ * mmhub_v3_3_set_fault_enable_default - update GART/VM fault handling
+ *
+ * @adev: amdgpu_device pointer
+ * @value: true redirects VM faults to the default page
+ */
+static void mmhub_v3_3_set_fault_enable_default(struct amdgpu_device *adev,
+						  bool value)
+{
+	u32 tmp;
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
+static const struct amdgpu_vmhub_funcs mmhub_v3_3_vmhub_funcs = {
+	.print_l2_protection_fault_status = mmhub_v3_3_print_l2_protection_fault_status,
+	.get_invalidate_req = mmhub_v3_3_get_invalidate_req,
+};
+
+static void mmhub_v3_3_init(struct amdgpu_device *adev)
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
+	hub->vmhub_funcs = &mmhub_v3_3_vmhub_funcs;
+}
+
+static u64 mmhub_v3_3_get_fb_location(struct amdgpu_device *adev)
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
+static u64 mmhub_v3_3_get_mc_fb_offset(struct amdgpu_device *adev)
+{
+	u64 offset;
+
+	offset = RREG32_SOC15(MMHUB, 0, regMMMC_VM_FB_OFFSET);
+	offset &= MMMC_VM_FB_OFFSET__FB_OFFSET_MASK;
+	offset <<= 24;
+
+	return offset;
+}
+
+static void mmhub_v3_3_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+							  bool enable)
+{
+	uint32_t def, data;
+
+	def = data = RREG32_SOC15(MMHUB, 0, regMM_ATC_L2_MISC_CG);
+
+	if (enable)
+		data |= MM_ATC_L2_MISC_CG__ENABLE_MASK;
+	else
+		data &= ~MM_ATC_L2_MISC_CG__ENABLE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(MMHUB, 0, regMM_ATC_L2_MISC_CG, data);
+}
+
+static void mmhub_v3_3_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+							 bool enable)
+{
+	uint32_t def, data;
+
+	def = data = RREG32_SOC15(MMHUB, 0, regMM_ATC_L2_MISC_CG);
+
+	if (enable)
+		data |= MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
+	else
+		data &= ~MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(MMHUB, 0, regMM_ATC_L2_MISC_CG, data);
+}
+
+static int mmhub_v3_3_set_clockgating(struct amdgpu_device *adev,
+					enum amd_clockgating_state state)
+{
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	mmhub_v3_3_update_medium_grain_clock_gating(adev,
+			state == AMD_CG_STATE_GATE);
+	mmhub_v3_3_update_medium_grain_light_sleep(adev,
+			state == AMD_CG_STATE_GATE);
+	return 0;
+}
+
+static void mmhub_v3_3_get_clockgating(struct amdgpu_device *adev, u64 *flags)
+{
+	int data;
+
+	if (amdgpu_sriov_vf(adev))
+		*flags = 0;
+
+	data = RREG32_SOC15(MMHUB, 0, regMM_ATC_L2_MISC_CG);
+
+	/* AMD_CG_SUPPORT_MC_MGCG */
+	if (data & MM_ATC_L2_MISC_CG__ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_MC_MGCG;
+
+	/* AMD_CG_SUPPORT_MC_LS */
+	if (data & MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_MC_LS;
+}
+
+const struct amdgpu_mmhub_funcs mmhub_v3_3_funcs = {
+	.init = mmhub_v3_3_init,
+	.get_fb_location = mmhub_v3_3_get_fb_location,
+	.get_mc_fb_offset = mmhub_v3_3_get_mc_fb_offset,
+	.gart_enable = mmhub_v3_3_gart_enable,
+	.set_fault_enable_default = mmhub_v3_3_set_fault_enable_default,
+	.gart_disable = mmhub_v3_3_gart_disable,
+	.set_clockgating = mmhub_v3_3_set_clockgating,
+	.get_clockgating = mmhub_v3_3_get_clockgating,
+	.setup_vm_pt_regs = mmhub_v3_3_setup_vm_pt_regs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.h
new file mode 100644
index 000000000000..37b62c7e5a4a
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.h
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
+#ifndef __MMHUB_V3_3_H__
+#define __MMHUB_V3_3_H__
+
+extern const struct amdgpu_mmhub_funcs mmhub_v3_3_funcs;
+
+#endif
-- 
2.41.0

