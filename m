Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E12C48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D9EA112DDC;
	Tue,  6 Feb 2024 20:13:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FCBlXwdB";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E249112DDC
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:13:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foocLdIK9SBCZyJ9bU6Q5NYrkFOuFPp3Xj4f/xQ0NZAmr0sdj0M8Ckj9tqjesxjqkfu0dkwBk2Q9TVIlyx6xf2kIfMcqocMMkvYGzMf2xJkNYbpUyhy3L9buMk8PHlRnkBQoGqMv/QTFgEP3jxYNvTyEf/9DONzWi9xvwOPCxTPdipU0hsa1DYXAQYSPPsLSNY292lPrVHIYqNOs1FAfhJNpIa14/MhxQHLIK7EbyWlnmNvavzuisU4azPg5S8qQrQ3L7lplhLL7IyxYbjTOlJce7F5sOk1a7n/HkW5eEDUO2hx2jfJA28Skr4DXEoCpViwEUzxVuP6k9cdVUdzwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7UYltyHEI8qx3F/6E41B72HKiC2Y5g8JYfPuYZtww0=;
 b=SRE4kvMk2/s1XkjdC/IudOH5P4kJxAIG6KPtDJmfwl43iG21y1Zbm4ah6DiD7jve9X3YlSLiZFunoAdE46kg3HFOIgl4F4Ywgfxy7PIEHZ595hKDBgd/aIoIMdNaov7o7Ux/jin0iPhB5K8zRtpAtGDWTt+mORUYItVLGHtTDDb0KX8lAS5GuDUs89elT2b+zNgdt2NyRjDxJX5QL3CL0302L7SjSQqiEey13Qv25sKG9zPmiO+95VSvmPbLDqh/uWN/xI1xvTorDhxmcMBx0J0uCCUt4wbcE9xOnDFmQ7FRJgwnEnZ6wRD0PQOVTzCu0QtwtBPni6dJaCH6R/Hk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7UYltyHEI8qx3F/6E41B72HKiC2Y5g8JYfPuYZtww0=;
 b=FCBlXwdBeAXd3v+iz804tYnffktBt9RJ/mpA3zswBHDpFrlAmlCwylkG4gSopC13fGPN6avpi8cKSlf7BH9ZBMva0cqYvv+7DXq+EgdTVLpZq0inhibchRP6+r1pngtkKLF6/jBT80pzqmSH3LXTHHzezjf0xIrjM34u8vibzBY=
Received: from BN0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:e4::9)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 20:13:08 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::25) by BN0PR02CA0004.outlook.office365.com
 (2603:10b6:408:e4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 20:13:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:13:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:13:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add athub v4_1_0 ip block support
Date: Tue, 6 Feb 2024 15:12:51 -0500
Message-ID: <20240206201251.1670941-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240206201251.1670941-1-alexander.deucher@amd.com>
References: <20240206201251.1670941-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|BL0PR12MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: b4da57e4-bb1f-478b-0f5b-08dc27500954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYJMexVopJ9rv/u3b9+9HsyhPjbtBzH7sEhIBt414GRABKdT+dq1mBDKY4DUwjwEguGTz7Dyix6y4L1W4IhH2Icl/aJnl58FZ+NC2pIqel8GbgczKy1FbQ8U/ksKepLqUYSd+xaVkjiXYFmfmmqjWjNu1hHFNgih81o8zXDIKxu/H+BBaDRNF15yg41iunVE1hZBil+wdSzmOv29ryI/J6dkH1Xz8dkP2KuKCKoeMwFSdk37PRACCnLFz/+MCXVFT65n06WFwdVl7iycofE9LpvCEu469DyouENFZ5ts0JH7oXVTFqIIdy2lg2UyabmhNdu8fe96+NJhoNOrMfKtzLugvgDwZkwI1PrXt/jr/4iopUYEIiqNH08JSR33cm4CEGZNv7v0wlWbndX6WMrPLDZZVibYeomRR41AAdqnz4VLUmuDTGf+KhhYtoIe77Scb/hHJn2tigwkVf2bf0iR1kkDw9UUK+Q3zxGU59WXiX/ETheeXcVMxsVQBWjsxc/HSOJ1x9OzESog9auropXPMZMBgteKbIpJtc+Rf9lfkQ3jEE+pv6KxzhD9TfLRc0GoAuBxA49YTgfAF7/aFXN0EhMiEMeYW44ZXC1AsMLOfJmjhUdKo1LpkJgwAYYsMuTwoM/bVmrA50hDYWZqPGagmsV4yDtDfOpqgV85acXYNvV5L+zzFJ1O5lb+QYkiDiw6RhgBfJ6YC9Z5Qs6OYx4smEgzq2n/PFVZX5uPs6JzJ8La64YMz2xHxY6SREePwjdcOnHPVSy5ZLvs17ICvJxUJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(36756003)(66899024)(36860700001)(478600001)(86362001)(82740400003)(81166007)(1076003)(83380400001)(426003)(41300700001)(356005)(47076005)(26005)(16526019)(2616005)(54906003)(5660300002)(316002)(70206006)(70586007)(4326008)(7696005)(6666004)(6916009)(336012)(2906002)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:13:08.6669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4da57e4-bb1f-478b-0f5b-08dc27500954
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
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

Add athub v4_1_0 ip block support.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile       |   3 +-
 drivers/gpu/drm/amd/amdgpu/athub_v4_1_0.c | 121 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/athub_v4_1_0.h |  30 ++++++
 3 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v4_1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v4_1_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 4c989da4d2f3..1b04bae60fbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -233,7 +233,8 @@ amdgpu-y += \
 	athub_v1_0.o \
 	athub_v2_0.o \
 	athub_v2_1.o \
-	athub_v3_0.o
+	athub_v3_0.o \
+	athub_v4_1_0.o
 
 # add SMUIO block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v4_1_0.c
new file mode 100644
index 000000000000..14f0a63cfb45
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v4_1_0.c
@@ -0,0 +1,121 @@
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
+#include "athub_v4_1_0.h"
+#include "athub/athub_4_1_0_offset.h"
+#include "athub/athub_4_1_0_sh_mask.h"
+#include "soc15_common.h"
+
+static uint32_t athub_v4_1_0_get_cg_cntl(struct amdgpu_device *adev)
+{
+	uint32_t data;
+
+	switch (amdgpu_ip_version(adev, ATHUB_HWIP, 0)) {
+	case IP_VERSION(4, 1, 0):
+		data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL);
+		break;
+	default:
+		break;
+	}
+	return data;
+}
+
+static void athub_v4_1_0_set_cg_cntl(struct amdgpu_device *adev, uint32_t data)
+{
+	switch (amdgpu_ip_version(adev, ATHUB_HWIP, 0)) {
+	case IP_VERSION(4, 1, 0):
+		WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL, data);
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+athub_v4_1_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+					      bool enable)
+{
+	uint32_t def, data;
+
+	def = data = athub_v4_1_0_get_cg_cntl(adev);
+
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_ATHUB_MGCG))
+		data |= ATHUB_MISC_CNTL__CG_ENABLE_MASK;
+	else
+		data &= ~ATHUB_MISC_CNTL__CG_ENABLE_MASK;
+
+	if (def != data)
+		athub_v4_1_0_set_cg_cntl(adev, data);
+}
+
+static void
+athub_v4_1_0_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+					     bool enable)
+{
+	uint32_t def, data;
+
+	def = data = athub_v4_1_0_get_cg_cntl(adev);
+
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_ATHUB_LS))
+		data |= ATHUB_MISC_CNTL__CG_MEM_LS_ENABLE_MASK;
+	else
+		data &= ~ATHUB_MISC_CNTL__CG_MEM_LS_ENABLE_MASK;
+
+	if (def != data)
+		athub_v4_1_0_set_cg_cntl(adev, data);
+}
+
+int athub_v4_1_0_set_clockgating(struct amdgpu_device *adev,
+				 enum amd_clockgating_state state)
+{
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	switch (amdgpu_ip_version(adev, ATHUB_HWIP, 0)) {
+	case IP_VERSION(4, 1, 0):
+		athub_v4_1_0_update_medium_grain_clock_gating(adev,
+				state == AMD_CG_STATE_GATE);
+		athub_v4_1_0_update_medium_grain_light_sleep(adev,
+				state == AMD_CG_STATE_GATE);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+void athub_v4_1_0_get_clockgating(struct amdgpu_device *adev, u64 *flags)
+{
+	int data;
+
+	/* AMD_CG_SUPPORT_ATHUB_MGCG */
+	data = athub_v4_1_0_get_cg_cntl(adev);
+	if (data & ATHUB_MISC_CNTL__CG_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_ATHUB_MGCG;
+
+	/* AMD_CG_SUPPORT_ATHUB_LS */
+	if (data & ATHUB_MISC_CNTL__CG_MEM_LS_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_ATHUB_LS;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v4_1_0.h b/drivers/gpu/drm/amd/amdgpu/athub_v4_1_0.h
new file mode 100644
index 000000000000..4d18d0998fa8
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v4_1_0.h
@@ -0,0 +1,30 @@
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
+#ifndef __ATHUB_V4_1_0_H__
+#define __ATHUB_V4_1_0_H__
+
+int athub_v4_1_0_set_clockgating(struct amdgpu_device *adev,
+				 enum amd_clockgating_state state);
+void athub_v4_1_0_get_clockgating(struct amdgpu_device *adev, u64 *flags);
+
+#endif
-- 
2.42.0

