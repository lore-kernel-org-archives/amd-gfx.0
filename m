Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B4DC4829D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35E55112DF8;
	Tue,  6 Feb 2024 20:28:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JkvJOmNV";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F1E6112DF8
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsR2y5bczDnEZkrcRpPD7CTxx1zCiCW6Vy9ZO84nFvGW/4FRX8F9lze1SzUY4NBKc9xwEhqpoZtUDByts+831fb8cyV5Pjur7CRgyYqgfocilqYlfN0oUtvYlbSXQdduwWNuTagFaxAjnJ5LMv+VcKmqmf1Ol5YUkY8h0xUhhSb6LuLexlKv8l76+x2ajmjXwGbEAEtppiIlp8pNIwZAq/7yOChIJPeoletTVGlOfvrOi8SQkRaxLmCvxBWC1OkCxSnR+gLLShoTmZDooBLoX7zAahjKY3rbrFubfHMKNNEIJSh94MXtDRSVr7mIs6j2pW1r+7GH9bS4/dspes6OkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZelX9hv3eG1iUZj8hA/w5gInSsk75ljpBz7usL9uec=;
 b=lAiAbw36xgdlgFT41SvgKJE6MExyyH54fCUeDPOsE1LQ3Uq5ahD6+19PB/z4vCdagOCoszA3XlIFVFXZrq2ed8UZia4hETjATRfim+nPcaeI/7+KR9MWCUYJroQKGPdTJeMNstvp+py0WJuFE0Im2np53cx+/R8b5TfslkIrMqD5Mjt5hqitU10x6oLLgvOuCfpHM+9aImwAtGDkt13wbVg5/issxaiTD7pVRhtrYUiBTV1+5jwxOoqIprDBkjCoT09iN4TEvU5PNBN0Uz9EZ0Ra4gQr3FKN3/Za4caIIg9641owO4B8j1y/Iqia4OG44fM/fsrApRcY+OpX/u+V4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZelX9hv3eG1iUZj8hA/w5gInSsk75ljpBz7usL9uec=;
 b=JkvJOmNVG6WSO7VIKynJzLb73MyXdb8a4IZMsfhncwNFlG+dRxC4CtdqzpdbO/JFqmeSUl1ETBxYwjZrlt/gjEObvFslb3KrtTLR0JjtGf2u55iB6aZfcszzOJgv0BLKXniHS1H0qK2qMUyxhSvvAuqXte/yvEPsybBRZpeyPDY=
Received: from BL0PR0102CA0053.prod.exchangelabs.com (2603:10b6:208:25::30) by
 BN9PR12MB5275.namprd12.prod.outlook.com (2603:10b6:408:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 20:28:02 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::b3) by BL0PR0102CA0053.outlook.office365.com
 (2603:10b6:208:25::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 20:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:28:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:28:00 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add hdp v7_0 ip block support
Date: Tue, 6 Feb 2024 15:27:42 -0500
Message-ID: <20240206202743.1671739-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240206202743.1671739-1-alexander.deucher@amd.com>
References: <20240206202743.1671739-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|BN9PR12MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: ef69d1d7-d3ac-4bc0-64aa-08dc27521de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66gz9fsKeANZK8SNQrT1wuMR+OZdl68hLalqCo0uI2pa9DphDV04ug3bCA12cR3yrx2XnkxRbBfjku7eL6Qy88SElrgKQhAXhTsT+shx5eKdrn3yLJ+ZPjQDQOGLlewqhwtdP0ksQsHniCg1iTQVAAH3Ukw0HQEDj5nJTyJRRhWc/cqd8W39gRLTaR0ChvWhz1wOYg6s1b/wgjMbHV12n+JTZ/KKAf0cnwvunL01IMBFJbXWhKUbx0cGLcEwNYYPXnWo7bQ1s9CRqiXiCbRm1lITzWbRIEkYxMPQbzSgaEEi954Z/lT6zwkSWNGxuyOdgZsxnbtLPaXdRcyV6Wd5vQoWyz/4IvcpG21KuSAQach/8tNKppAQiTAAMRaShiW044Rqp5IRSO/Jakla0UN66FP34RZY8KIzBoFsZhY2uA7/yAa5ZGMwyrVBWsntqCwklhZHCbbxqEA90Hyqh+pTxLpinh6anIWY8HAMIcDc6MaIiSG3F7N2yaZ7v4rBdP7+4/1I9QJCTPTflOQzixK3/PNpKbnw70GMj8DOpjeSBMmmPgvQenX+6t/TOh8SZ+oeh0XBug7Qt8/g1nDDatbmq7aMxUyj578xs4crtG6VB73fGmcvbTAroSYtWU7GjCNjMSCOTIQEvDLC1HDPQeae4mm538WMy4WtdDg/QBHcZV/8BuIaJR9aq6+zyDEf6VIVxGDrdECv2Vc69GVCGBRmwE5RHIWTjukCPQIQEh87McGaM2zdJvPpk6FPB7FkarFhA05feo4KjycDDwJeWq6pNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(83380400001)(40460700003)(40480700001)(26005)(2616005)(1076003)(426003)(16526019)(66899024)(36756003)(41300700001)(6916009)(478600001)(7696005)(336012)(82740400003)(6666004)(81166007)(316002)(47076005)(356005)(36860700001)(8676002)(5660300002)(70206006)(70586007)(4326008)(54906003)(86362001)(8936002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:28:02.1320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef69d1d7-d3ac-4bc0-64aa-08dc27521de2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5275
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

From: Likun Gao <Likun.Gao@amd.com>

Add hdp v7_0 ip block support.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile   |   2 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c | 142 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.h |  31 ++++++
 3 files changed, 174 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 9bc5f3dde442..87022325bbf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -98,7 +98,7 @@ amdgpu-y += \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
-	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o
+	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
new file mode 100644
index 000000000000..8d7d0813e331
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
@@ -0,0 +1,142 @@
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
+#include "amdgpu.h"
+#include "amdgpu_atombios.h"
+#include "hdp_v7_0.h"
+
+#include "hdp/hdp_7_0_0_offset.h"
+#include "hdp/hdp_7_0_0_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg)
+		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	else
+		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+}
+
+static void hdp_v7_0_update_clock_gating(struct amdgpu_device *adev,
+					 bool enable)
+{
+	uint32_t hdp_clk_cntl, hdp_clk_cntl1;
+	uint32_t hdp_mem_pwr_cntl;
+
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS |
+				AMD_CG_SUPPORT_HDP_DS |
+				AMD_CG_SUPPORT_HDP_SD)))
+		return;
+
+	hdp_clk_cntl = hdp_clk_cntl1 = RREG32_SOC15(HDP, 0,regHDP_CLK_CNTL);
+	hdp_mem_pwr_cntl = RREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL);
+
+	/* Before doing clock/power mode switch,
+	 * forced on IPH & RC clock */
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     RC_MEM_CLK_SOFT_OVERRIDE, 1);
+	WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
+
+	/* disable clock and power gating before any changing */
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_CTRL_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_LS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_DS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_SD_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_CTRL_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_LS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_DS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_SD_EN, 0);
+	WREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
+
+	/* Already disabled above. The actions below are for "enabled" only */
+	if (enable) {
+		/* only one clock gating mode (LS/DS/SD) can be enabled */
+		if (adev->cg_flags & AMD_CG_SUPPORT_HDP_SD) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_SD_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_SD_EN, 1);
+		} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_LS_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_LS_EN, 1);
+		} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_DS) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_DS_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_DS_EN, 1);
+		}
+
+		/* confirmed that IPH_MEM_POWER_CTRL_EN and RC_MEM_POWER_CTRL_EN have to
+		 * be set for SRAM LS/DS/SD */
+		if (adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS | AMD_CG_SUPPORT_HDP_DS |
+				      AMD_CG_SUPPORT_HDP_SD)) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_CTRL_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_CTRL_EN, 1);
+			WREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
+		}
+	}
+
+	/* disable IPH & RC clock override after clock/power mode changing */
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     RC_MEM_CLK_SOFT_OVERRIDE, 0);
+	WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
+}
+
+static void hdp_v7_0_get_clockgating_state(struct amdgpu_device *adev,
+					    u64 *flags)
+{
+	uint32_t tmp;
+
+	/* AMD_CG_SUPPORT_HDP_LS/DS/SD */
+	tmp = RREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL);
+	if (tmp & HDP_MEM_POWER_CTRL__ATOMIC_MEM_POWER_LS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_LS;
+	else if (tmp & HDP_MEM_POWER_CTRL__ATOMIC_MEM_POWER_DS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_DS;
+	else if (tmp & HDP_MEM_POWER_CTRL__ATOMIC_MEM_POWER_SD_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_SD;
+}
+
+const struct amdgpu_hdp_funcs hdp_v7_0_funcs = {
+	.flush_hdp = hdp_v7_0_flush_hdp,
+	.update_clock_gating = hdp_v7_0_update_clock_gating,
+	.get_clock_gating_state = hdp_v7_0_get_clockgating_state,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.h b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.h
new file mode 100644
index 000000000000..25b69201402d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.h
@@ -0,0 +1,31 @@
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
+#ifndef __HDP_V7_0_H__
+#define __HDP_V7_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_hdp_funcs hdp_v7_0_funcs;
+
+#endif
-- 
2.42.0

