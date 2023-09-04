Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6B2C83F2C
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Sep 2023 07:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF57910E2A6;
	Mon,  4 Sep 2023 07:21:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C1C710E2A6
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 07:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4OlIjlkSYITENYqOI7sSsLWfaAe+1lcUlSWMv+mDj+luSf4wUmrNkm1Q9vMslwhmckPzuMkh+RKIHY05jLkHA608M3QHQ/fjqe2RD3bofh4Yvykw2HrJnrt1IW4vFvx8MB6X9E0lzTyF8UNhmy10EyYRhIqmmkagYFIVKm1WcWLTcx5rILOlaf6WedDqgwA+KXX5c0uWqAS+iSjgVjgu1AsyFwrQKxBHd+geXzIeENlLPDZ6i9M6DmtBlufZmU9uLx4cJf9A1ACbR6NH+HHtCUmgidsHkqKd3squXwouN39ItO++gBj78f8V1yLhlGYKN4s3PgkgV+nNFPVSTpAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFM7faP2NxB9kZGjHFQQNfIwuIKo9yJ8pQaIxsI7fX4=;
 b=EoR2WX3jzN3U5jyZPa9ziF0R9VTMLh6tIx15nbQz0EOnL7kvn4ws89dtsRe41aN5Oox5A29lrY02O7MJTjqcMqUXVnkDw4iMYEYv8a4KACZFfVi/Z8gazs4XLGy2A/0DGhr/Z6nnlv812l0dbVKSPwakMAd4KtvxzSoVV9zi4AvE8Z6LJnU2F51YtuKNkA+5tCd3Oc9u0t6T+xNmrKUYAkTxmR6ppSZ/eRq8tTXqt9sNaPiht68Wp17EX3JvFpKVumZ4ZeqjiRZ658o++WwPYFJE5C5wSeLx85uNy+/qc+jw5/hlSNcDQhME8VM3iLRLobFtFPRFIo46TWrKYCiF1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFM7faP2NxB9kZGjHFQQNfIwuIKo9yJ8pQaIxsI7fX4=;
 b=GogaJe1BRsqTAwUTZWWvIZax7J9FM9CDnwcxSRWvp2rfEw6Sop2gB5MQWVFJHUgZJ0lXVTJv47fM15DugVsykPKaBuEiuHKkgeodaLFUFkau64qrq3rDXRTBC3tot3o6JOJ4G4mrH4PCcBDD+2s2tNSOtkLQhM4O4jGOoLb1lug=
Received: from CYZPR17CA0008.namprd17.prod.outlook.com (2603:10b6:930:8c::17)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 07:21:18 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::49) by CYZPR17CA0008.outlook.office365.com
 (2603:10b6:930:8c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32 via Frontend
 Transport; Mon, 4 Sep 2023 07:21:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 07:21:18 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 02:21:14 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Add umc v12_0 ras functions
Date: Mon, 4 Sep 2023 15:20:21 +0800
Message-ID: <20230904072021.59152-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cf095d-33e6-4a8a-e3ff-08dbad178857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APNTeTdl8tOF5+tlcLKcCIAJ0ELxndTKXsS3xFBM70uajB1/piRZgN5KRBUaEP65YFL1ayBMSOeFIfQsluBUfjBXK2EylRXBSb1oeIYUPxzCV8e/WCEeEWwJh6BJ5OK+T2Ts7eGU98TsnaPgYFHTbQP/5kKVLnYZEsROHj4mJYhSvNUyfIvX1vFJ+Y8CAzM0avnQ/sB4d2ct497MFabB6GpuE/VyxxI9KH/58clQlZ4ezxS8yGOOSA/i7RJzSh0+m2BY7Rbydlr600udvoZfSMe9Cy8I116hFw7+ng3cy5L6LMly/7TBOuVbh1aXVx9FJzgEajc88Teg4zdHHVtg8TR5cZd7eycG0ZZdnMJaVZpKg7AS82AolNiyLDJAC9erO585jxpncxsGfRWKD4eAOALt84CPgVjCMx5VcOVygeXDkbYIZ/dSFhOA9H+Ud9KNromBkNWMQl7JINEJyTOuV//9EB4L2SKA68l/Q1xb7A5pWm4HTUK5UZSNnkmNuCTVhhsS9mLGp+MNMuDmXzMmIiR5E9Hdpso6t8Ace3dq2BRKX1zv3GTSVb5Tz5RnxIYdBGFtAUWDF+lm+SE0sJJ3B6a/iGGrBrJ+uEeBfLS6VBVE/Uho/za5rUUbIgTbwYqTeATG8J2vW62YkvMa5bdauMDRxdHFoLDwy1Tj6BAQkSt9s2n9yPKgXcLL0TErrl1u7Gwc53LbJLehmst8eQl2/VyMBjCyKuo/7HizMmgWhBLwtm20Jt9U+hRPMdgzMDghnJZivDypydxk/+koi4eDAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(7696005)(26005)(16526019)(2616005)(1076003)(66899024)(86362001)(47076005)(356005)(81166007)(82740400003)(36756003)(36860700001)(426003)(336012)(83380400001)(40480700001)(44832011)(30864003)(8936002)(41300700001)(6916009)(316002)(54906003)(70206006)(5660300002)(70586007)(8676002)(4326008)(2906002)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 07:21:18.5277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cf095d-33e6-4a8a-e3ff-08dbad178857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add umc v12_0 ras error querying.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  16 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 256 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h |  56 ++++++
 4 files changed, 327 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ce0188b329cdeb..adf5470aa81020 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -121,7 +121,7 @@ amdgpu-y += \
 
 # add UMC block
 amdgpu-y += \
-	umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7.o umc_v8_10.o
+	umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7.o umc_v8_10.o umc_v12_0.o
 
 # add IH block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8447fcada8bb92..41e1759b5f1eaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -56,6 +56,7 @@
 #include "umc_v6_1.h"
 #include "umc_v6_0.h"
 #include "umc_v6_7.h"
+#include "umc_v12_0.h"
 #include "hdp_v4_0.h"
 #include "mca_v3_0.h"
 
@@ -737,7 +738,8 @@ static void gmc_v9_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gmc.vm_fault.funcs = &gmc_v9_0_irq_funcs;
 
 	if (!amdgpu_sriov_vf(adev) &&
-	    !adev->gmc.xgmi.connected_to_cpu) {
+	    !adev->gmc.xgmi.connected_to_cpu &&
+	    !adev->gmc.is_app_apu) {
 		adev->gmc.ecc_irq.num_types = 1;
 		adev->gmc.ecc_irq.funcs = &gmc_v9_0_ecc_funcs;
 	}
@@ -1487,6 +1489,15 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		else
 			adev->umc.channel_idx_tbl = &umc_v6_7_channel_idx_tbl_second[0][0];
 		break;
+	case IP_VERSION(12, 0, 0):
+		adev->umc.max_ras_err_cnt_per_query = UMC_V12_0_TOTAL_CHANNEL_NUM(adev);
+		adev->umc.channel_inst_num = UMC_V12_0_CHANNEL_INSTANCE_NUM;
+		adev->umc.umc_inst_num = UMC_V12_0_UMC_INSTANCE_NUM;
+		adev->umc.node_inst_num /= UMC_V12_0_UMC_INSTANCE_NUM;
+		adev->umc.channel_offs = UMC_V12_0_PER_CHANNEL_OFFSET;
+		adev->umc.active_mask = adev->aid_mask;
+		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
+			adev->umc.ras = &umc_v12_0_ras;
 	default:
 		break;
 	}
@@ -2131,7 +2142,8 @@ static int gmc_v9_0_sw_init(void *handle)
 		return r;
 
 	if (!amdgpu_sriov_vf(adev) &&
-	    !adev->gmc.xgmi.connected_to_cpu) {
+	    !adev->gmc.xgmi.connected_to_cpu &&
+	    !adev->gmc.is_app_apu) {
 		/* interrupt sent to DF. */
 		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DF, 0,
 				      &adev->gmc.ecc_irq);
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
new file mode 100644
index 00000000000000..b3d6db14b351f1
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -0,0 +1,256 @@
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
+#include "umc_v12_0.h"
+#include "amdgpu_ras.h"
+#include "amdgpu_umc.h"
+#include "amdgpu.h"
+#include "umc/umc_12_0_0_offset.h"
+#include "umc/umc_12_0_0_sh_mask.h"
+
+static inline uint64_t get_umc_v12_0_reg_offset(struct amdgpu_device *adev,
+					    uint32_t node_inst,
+					    uint32_t umc_inst,
+					    uint32_t ch_inst)
+{
+	uint32_t index = umc_inst * adev->umc.channel_inst_num + ch_inst;
+	uint64_t cross_node_offset = (node_inst == 0) ? 0 : UMC_V12_0_CROSS_NODE_OFFSET;
+
+	umc_inst = index / 4;
+	ch_inst = index % 4;
+
+	return adev->umc.channel_offs * ch_inst + UMC_V12_0_INST_DIST * umc_inst +
+		UMC_V12_0_NODE_DIST * node_inst + cross_node_offset;
+}
+
+static int umc_v12_0_reset_error_count_per_channel(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
+{
+	uint64_t odecc_err_cnt_addr;
+	uint64_t umc_reg_offset =
+		get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst);
+
+	odecc_err_cnt_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_OdEccErrCnt);
+
+	/* clear error count */
+	WREG32_PCIE_EXT((odecc_err_cnt_addr + umc_reg_offset) * 4,
+			UMC_V12_0_CE_CNT_INIT);
+
+	return 0;
+}
+
+static void umc_v12_0_reset_error_count(struct amdgpu_device *adev)
+{
+	amdgpu_umc_loop_channels(adev,
+		umc_v12_0_reset_error_count_per_channel, NULL);
+}
+
+static void umc_v12_0_query_correctable_error_count(struct amdgpu_device *adev,
+						   uint64_t umc_reg_offset,
+						   unsigned long *error_count)
+{
+	uint64_t mc_umc_status;
+	uint64_t mc_umc_status_addr;
+
+	mc_umc_status_addr =
+		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
+
+	/* Rely on MCUMC_STATUS for correctable error counter
+	 * MCUMC_STATUS is a 64 bit register
+	 */
+	mc_umc_status =
+		RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4);
+
+	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
+		*error_count += 1;
+}
+
+static void umc_v12_0_query_uncorrectable_error_count(struct amdgpu_device *adev,
+						      uint64_t umc_reg_offset,
+						      unsigned long *error_count)
+{
+	uint64_t mc_umc_status;
+	uint64_t mc_umc_status_addr;
+
+	mc_umc_status_addr =
+		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
+
+	/* Check the MCUMC_STATUS. */
+	mc_umc_status =
+		RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4);
+
+	if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
+	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1))
+		*error_count += 1;
+}
+
+static int umc_v12_0_query_error_count(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)data;
+	uint64_t umc_reg_offset =
+		get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst);
+
+	umc_v12_0_query_correctable_error_count(adev,
+					umc_reg_offset,
+					&(err_data->ce_count));
+	umc_v12_0_query_uncorrectable_error_count(adev,
+					umc_reg_offset,
+					&(err_data->ue_count));
+
+	return 0;
+}
+
+static void umc_v12_0_query_ras_error_count(struct amdgpu_device *adev,
+					   void *ras_error_status)
+{
+	amdgpu_umc_loop_channels(adev,
+		umc_v12_0_query_error_count, ras_error_status);
+
+	umc_v12_0_reset_error_count(adev);
+}
+
+static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
+					    struct ras_err_data *err_data, uint64_t err_addr,
+					    uint32_t ch_inst, uint32_t umc_inst,
+					    uint32_t node_inst, uint64_t mc_umc_status)
+{
+
+}
+
+static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
+{
+	uint64_t mc_umc_status_addr;
+	uint64_t mc_umc_status, err_addr;
+	uint64_t mc_umc_addrt0;
+	struct ras_err_data *err_data = (struct ras_err_data *)data;
+	uint64_t umc_reg_offset =
+		get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst);
+
+	mc_umc_status_addr =
+		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
+
+	mc_umc_status = RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4);
+
+	if (mc_umc_status == 0)
+		return 0;
+
+	if (!err_data->err_addr) {
+		/* clear umc status */
+		WREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
+
+		return 0;
+	}
+
+	/* calculate error address if ue error is detected */
+	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, AddrV) == 1 &&
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1) {
+
+		mc_umc_addrt0 =
+			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
+
+		err_addr = RREG64_PCIE_EXT((mc_umc_addrt0 + umc_reg_offset) * 4);
+
+		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
+
+		umc_v12_0_convert_error_address(adev, err_data, err_addr,
+					ch_inst, umc_inst, node_inst);
+	}
+
+	/* clear umc status */
+	WREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
+
+	return 0;
+}
+
+static void umc_v12_0_query_ras_error_address(struct amdgpu_device *adev,
+					     void *ras_error_status)
+{
+	amdgpu_umc_loop_channels(adev,
+		umc_v12_0_query_error_address, ras_error_status);
+}
+
+static int umc_v12_0_err_cnt_init_per_channel(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
+{
+	uint32_t odecc_cnt_sel;
+	uint64_t odecc_cnt_sel_addr, odecc_err_cnt_addr;
+	uint64_t umc_reg_offset =
+		get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst);
+
+	odecc_cnt_sel_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_OdEccCntSel);
+	odecc_err_cnt_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_OdEccErrCnt);
+
+	odecc_cnt_sel = RREG32_PCIE_EXT((odecc_cnt_sel_addr + umc_reg_offset) * 4);
+
+	/* set ce error interrupt type to APIC based interrupt */
+	odecc_cnt_sel = REG_SET_FIELD(odecc_cnt_sel, UMCCH0_OdEccCntSel,
+					OdEccErrInt, 0x1);
+	WREG32_PCIE_EXT((odecc_cnt_sel_addr + umc_reg_offset) * 4, odecc_cnt_sel);
+
+	/* set error count to initial value */
+	WREG32_PCIE_EXT((odecc_err_cnt_addr + umc_reg_offset) * 4, UMC_V12_0_CE_CNT_INIT);
+
+	return 0;
+}
+
+static void umc_v12_0_err_cnt_init(struct amdgpu_device *adev)
+{
+	amdgpu_umc_loop_channels(adev,
+		umc_v12_0_err_cnt_init_per_channel, NULL);
+}
+
+static bool umc_v12_0_query_ras_poison_mode(struct amdgpu_device *adev)
+{
+	/*
+	 * Force return true, because regUMCCH0_EccCtrl
+	 * is not accessible from host side
+	 */
+	return true;
+}
+
+const struct amdgpu_ras_block_hw_ops umc_v12_0_ras_hw_ops = {
+	.query_ras_error_count = umc_v12_0_query_ras_error_count,
+	.query_ras_error_address = umc_v12_0_query_ras_error_address,
+};
+
+struct amdgpu_umc_ras umc_v12_0_ras = {
+	.ras_block = {
+		.hw_ops = &umc_v12_0_ras_hw_ops,
+	},
+	.err_cnt_init = umc_v12_0_err_cnt_init,
+	.query_ras_poison_mode = umc_v12_0_query_ras_poison_mode,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
new file mode 100644
index 00000000000000..2e63cc30766bc3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -0,0 +1,56 @@
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
+#ifndef __UMC_V12_0_H__
+#define __UMC_V12_0_H__
+
+#include "soc15_common.h"
+#include "amdgpu.h"
+
+#define UMC_V12_0_NODE_DIST		0x40000000
+#define UMC_V12_0_INST_DIST		0x40000
+
+/* UMC register per channel offset */
+#define UMC_V12_0_PER_CHANNEL_OFFSET	0x400
+
+/* UMC cross node offset */
+#define UMC_V12_0_CROSS_NODE_OFFSET		0x100000000
+
+/* OdEccErrCnt max value */
+#define UMC_V12_0_CE_CNT_MAX		0xffff
+/* umc ce interrupt threshold */
+#define UMC_V12_0_CE_INT_THRESHOLD	0xffff
+/* umc ce count initial value */
+#define UMC_V12_0_CE_CNT_INIT	(UMC_V12_0_CE_CNT_MAX - UMC_V12_0_CE_INT_THRESHOLD)
+
+/* number of umc channel instance with memory map register access */
+#define UMC_V12_0_CHANNEL_INSTANCE_NUM		8
+/* number of umc instance with memory map register access */
+#define UMC_V12_0_UMC_INSTANCE_NUM		4
+
+/* Total channel instances for all available umc nodes */
+#define UMC_V12_0_TOTAL_CHANNEL_NUM(adev) \
+	(UMC_V12_0_CHANNEL_INSTANCE_NUM * (adev)->gmc.num_umc)
+
+extern struct amdgpu_umc_ras umc_v12_0_ras;
+
+#endif
-- 
2.25.1

