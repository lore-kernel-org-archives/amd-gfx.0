Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1B4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 18:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E40610E9FA;
	Thu, 28 Apr 2022 18:48:45 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2055.outbound.protection.outlook.com [40.107.212.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A50C10E9FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 18:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRtubE//g5szEcWFZ62CUUMZEfYO1YA+hDmDvyhCvagu3DMv3KS0P4euFzZL8Gc3njWlR3UivCYOzHUHZg1Q+dTBzQjNfdCuIxTp3CJ1CTtHsbogrekU05DrCzYpPf9oECQhIHCGTKMhKKXY40prs/W/1BQDIe5g5+PDJu9VBsCBMY5W3bK4/Z6KK5yqdJsVKNdlcJz9S8Hv9WHPe1VU0dj/thc9zR8zJgZTqyt6pAMliYks7xizfOTklpwwE8/Vcget7Cxhfbz2N900EH8lTObd1NIExTdsVXY0JBx3QBEEaW3hfoWMXmWjweMb1fhoeXlxeZzodKyXtSERgaJHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXV1GgwLt/VsyGR96GTV4LkG0/1h4B+6YnNAPiF86Cg=;
 b=PQ+W6HXpZ/sm/dVOMexwu9ZH9kVbNcDQtH3h6w3bmwq0fwfK1ic9xU2cXXs69ooGvF/c5JjXEA5apRnYUZ6o8mW1f/21tw/pkv5s1N2PZh/BbZ5FAGA/lnLy0N+aBcmaQxwNoSDrm9XZv4Vgrfl8MDBVlPijBYA/EFlzxoq51bydp8S9XZpFSd8r/usSKz6xKNEVJdGrjMNWQRLYIW5yA2v/bSPkf1UHkJseDGNW3BUPGEh6gqqE1rT2vYU3KHCF4cPd55ZecqOt/zh69Y3EMUNcLjd0GmW+YYVxvH3wmkKmZBmHXDlGftnljEPglQMhdTafF+bnd847VeGghaoliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXV1GgwLt/VsyGR96GTV4LkG0/1h4B+6YnNAPiF86Cg=;
 b=gsOtliRkC0lNXrhTQo0qtOVS6GhvlUjUuuw/H8GesfbkwBjXZ80jYgsRjPvXFVyNXCvJClzLOFHRILazj4dARXcaoZAv1ruILzgKqzxzqV+9TlpNZ1jX9mwiS+rInYdapILAgKbwJGYd2hQlkncJbQwBqrWfONYZn+3wU9UiTdg=
Received: from DM6PR11CA0016.namprd11.prod.outlook.com (2603:10b6:5:190::29)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 18:48:41 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::8d) by DM6PR11CA0016.outlook.office365.com
 (2603:10b6:5:190::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20 via Frontend
 Transport; Thu, 28 Apr 2022 18:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 18:48:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 13:48:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add athub v3_0 ip block
Date: Thu, 28 Apr 2022 14:48:20 -0400
Message-ID: <20220428184820.652153-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428184820.652153-1-alexander.deucher@amd.com>
References: <20220428184820.652153-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62e47d6f-46b9-4085-bd0d-08da2947b71a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2409177853E09495E5D8E5A2F7FD9@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jFpdc0MTzzNQvOMv8xiUQ+acWjKUsGcjbvI3Hhg74pHlvdgoXfhEzzu3A6Hv1vOU0P9ulSGSrHnyjqJATIslSxA3qAHXayjaSBYHOAcjuXksof92dyCty1Zyo3Nid2Zt4OOL1BPRg8RwCuf4JaNbPh+WKKc75LPwAYFv4Js4pWPo2+S7hqs0ETBOx5PMdC3fSr+LUQYvz2lrFOQyxKoMtGAvA9bvvtbLE8YAgXXjz5ssfDvsyLg6gXjLJyH3RtqwEorgiIYvP4CVOefntbIp2ys6bBvk6izYkYnrEZplQQiQAiIYvZBwZrsp9/zlCXnPgurrA2DISI/pxfBNRXtfmBUksqRKtAdI+4k5MUE9bxX98kFtqOHiaRx5KS8ay8imHMxBi3lQbhcF1U6Hx1r6I2iIY97rlPtrxxsLdAlp5WmT2Z4fOT3Jm7yAYza6ptGoJAXT+7SOhnkfguOZkyXdQiRvf56xoyc/EaOdtpoe6km6mDAr4oUrfMBsOm0gTc6uE2DHrGiv+FM4TplqAhYcbH7x7UY8M2bcT+NfYOYxHLCnfXw+D9YFnIPqbA/I/EFNT+FGGeV4xqdR2xF6yqiJ/Z6ZkccnF4D7n3wFlWtvb/8LChtmRBeD+mRXfsI0pLkI+ql5FVOviPhGDJHw1V2853HgMLtUhaTydcFlK9HIBuyY+rkIULHZ00FILXcVlzWI3kMHvbLahb9ol5c/fTmIUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(6666004)(26005)(36860700001)(86362001)(83380400001)(356005)(186003)(336012)(1076003)(47076005)(16526019)(2616005)(426003)(8936002)(4326008)(40460700003)(8676002)(82310400005)(2906002)(5660300002)(81166007)(36756003)(508600001)(70586007)(316002)(6916009)(70206006)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:48:41.6808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e47d6f-46b9-4085-bd0d-08da2947b71a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Tianci.Yin" <tianci.yin@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

Add support for athub v3.0

Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |  3 +-
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c | 98 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.h | 30 ++++++++
 3 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v3_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 6097ad614937..93b83dd3978e 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -176,7 +176,8 @@ amdgpu-y += \
 amdgpu-y += \
 	athub_v1_0.o \
 	athub_v2_0.o \
-	athub_v2_1.o
+	athub_v2_1.o \
+	athub_v3_0.o
 
 # add SMUIO block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
new file mode 100644
index 000000000000..bfc7484589b9
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
@@ -0,0 +1,98 @@
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
+#include "athub_v3_0.h"
+#include "athub/athub_3_0_0_offset.h"
+#include "athub/athub_3_0_0_sh_mask.h"
+#include "navi10_enum.h"
+#include "soc15_common.h"
+
+static void
+athub_v3_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+					    bool enable)
+{
+	uint32_t def, data;
+
+	def = data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL);
+
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG))
+		data |= ATHUB_MISC_CNTL__CG_ENABLE_MASK;
+	else
+		data &= ~ATHUB_MISC_CNTL__CG_ENABLE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL, data);
+}
+
+static void
+athub_v3_0_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+					   bool enable)
+{
+	uint32_t def, data;
+
+	def = data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL);
+
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS) &&
+	    (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
+		data |= ATHUB_MISC_CNTL__CG_MEM_LS_ENABLE_MASK;
+	else
+		data &= ~ATHUB_MISC_CNTL__CG_MEM_LS_ENABLE_MASK;
+
+	if(def != data)
+		WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL, data);
+}
+
+int athub_v3_0_set_clockgating(struct amdgpu_device *adev,
+			       enum amd_clockgating_state state)
+{
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	switch (adev->ip_versions[ATHUB_HWIP][0]) {
+	case IP_VERSION(3, 0, 0):
+		athub_v3_0_update_medium_grain_clock_gating(adev,
+				state == AMD_CG_STATE_GATE);
+		athub_v3_0_update_medium_grain_light_sleep(adev,
+				state == AMD_CG_STATE_GATE);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+void athub_v3_0_get_clockgating(struct amdgpu_device *adev, u64 *flags)
+{
+	int data;
+
+	/* AMD_CG_SUPPORT_ATHUB_MGCG */
+	data = RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL);
+	if (data & ATHUB_MISC_CNTL__CG_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_ATHUB_MGCG;
+
+	/* AMD_CG_SUPPORT_ATHUB_LS */
+	if (data & ATHUB_MISC_CNTL__CG_MEM_LS_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_ATHUB_LS;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.h b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.h
new file mode 100644
index 000000000000..e08a7d564365
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.h
@@ -0,0 +1,30 @@
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
+#ifndef __ATHUB_V3_0_H__
+#define __ATHUB_V3_0_H__
+
+int athub_v3_0_set_clockgating(struct amdgpu_device *adev,
+			       enum amd_clockgating_state state);
+void athub_v3_0_get_clockgating(struct amdgpu_device *adev, u64 *flags);
+
+#endif
-- 
2.35.1

