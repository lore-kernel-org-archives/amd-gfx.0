Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2E9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFC910F428;
	Tue,  3 May 2022 20:47:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F20110F428
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmbNL64kjes9yiI2EYMol0yFaL8b9smMCu6wjqVnU+7qneK10gSZRjr5kJYj4TnCTsVJborMvS8Phi+1RHoqQcqdGWyHNPbyFrHeOwzzmv46DKoVPOUqyUjVKMpQMAHVEQ4UHC0jttbbi/3l6lTCZIBhaM6Sji+yi02jnddx4PWG3UW02wRvcdtb0nxBPUfCr7B4pzBHOql3JWtmrR/D5etzg9TC6pJD/kh/hIIVp8pPuP1NHBt9jwyORYRs9DqT1dq71YDt3SWcgnJAkSj2Ajy8fNN62qNDyFTwnDD/clsqXDsvcS9vtJG4PWsBtpp2V+ycfWCUDziYVC4Yb553tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdnakL/lO8yTCe6TTTG0Cy8bhuglN1JYq3mH0hZMik8=;
 b=f+Dclih3jhO2ykWmKzyvmqVUYuu4XqlE8zzEkw0uwUQG9j8Y0JMK5NKq8Mq/QaL07FdlePtCAD0CsXbdfNmcUsIahUrcYed7SS2AJk99PWiVeRJL6eMi3rW6Xa1V7jgY2FAwxlsx9BOdOja9zuA700yfDOKdjrVN5y6Zq4iqvI2qGlQKI5vz3NdIjNNs3d4mwAvf+kYCyLSUo9USX6HGXO+xFnb4or9uVqTT8D0RODLUjFYx6IGhv3uHcAk7SXKYbl2sbXL0lYdygz+DhbLAcYfa9VsRnhdULuFJA1GosH0zUPknrn/fPtFokEUbj8/gnzp1GoMEyGkaZzbrHtmKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdnakL/lO8yTCe6TTTG0Cy8bhuglN1JYq3mH0hZMik8=;
 b=LLOUUwBBqBn399pZP5rzZNGW7T6XH41lt5Wf6J7J7YZH2d+A7OZ5Azd7e031y4+vjTN8quvN9lU1LTa8Fr9zo0PqZ2aEmMKP9EmWCE3GscJhdw6zQuG1sCt5Yt3FfvBD5VN4yJoJsErAd3T8hpWUGVDtYf/hKYBP1HeNWKFJH5A=
Received: from DS7PR03CA0124.namprd03.prod.outlook.com (2603:10b6:5:3b4::9) by
 MW2PR12MB2412.namprd12.prod.outlook.com (2603:10b6:907:b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Tue, 3 May 2022 20:47:04 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::2a) by DS7PR03CA0124.outlook.office365.com
 (2603:10b6:5:3b4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Tue, 3 May 2022 20:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:47:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:46:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add the files of HDP v5.2 block
Date: Tue, 3 May 2022 16:46:44 -0400
Message-ID: <20220503204645.1266993-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503204645.1266993-1-alexander.deucher@amd.com>
References: <20220503204645.1266993-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6eb899d-852e-427f-332a-08da2d4614bd
X-MS-TrafficTypeDiagnostic: MW2PR12MB2412:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB241260198F10BAD2A7BEAA2DF7C09@MW2PR12MB2412.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlrHS/vIwpdOhZjaXjgumbTP2+L7qIX/q6vUEu5NtXPb7JALy1sCJqlyTZviZO1TIv1nONAReANAhDZrlrgYowd7z/Pyh8Fe/WhiAfipdjET8ZwANQntZokGZynsYhjmrRn8CaQnYtjXlYA07wP9q/quulzND8LGrEngYvIbacXU6zKTVtdsZAnzzkhZf+fFXctTb4kKb4IW8VvumJw6RqqUg79ILK/7Odvz7XT9jguzqbqmrHljy4M5Da9TXMqyvg7oMgc27oKWo6ASPzBP4NTCpeyr9qGSEtEPtXCfHyUb4zFitIGMwqSn+c8lbuyW4PIgs3fSwRp5vbm633kLfTNPwlhL2x8uL7Yz7oLlaf5UHDWkBQjbEDgLKSOUbHJEYQjXshPZtjtu7pqmiW8FP1u5qTZZwdTWLxwq969DDMbXJH/Z0saN3Y8HoFv6J4OE5AF6CxAolb0P+sAiXOEYnjbMZgJvXxgZC+o3x6P5Vj4LmUgWuRCqOX4vJ0JfyCJEKkdc49FRakvutrpuk1f7qWTZ+6Q2+1iPJj8UjFAqt1lxrxXZL2CtfwXSvZBb+iwSfBJfX0+xlNThppZKFXY6NfYLxhbXqmpG0EDVGBqWj5HOeYi4uDoAwO+g/AlDKVFWQ2YMEHMpaekZtrmgGQe3ZoDTgPPkWtuq8gHFQaxlXAELTef2pLMnrK7k2SdyorIAJIYlUloSt0WEgrPjPsL2hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(82310400005)(81166007)(70586007)(4326008)(70206006)(40460700003)(356005)(8936002)(54906003)(5660300002)(6916009)(86362001)(36860700001)(316002)(2906002)(508600001)(426003)(83380400001)(2616005)(336012)(47076005)(36756003)(6666004)(16526019)(186003)(7696005)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:47:04.4313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6eb899d-852e-427f-332a-08da2d4614bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2412
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch is to add the files of HDP v5.2 block.
HDP (Host Data Port) is the IP which handles
host access to VRAM via the PCI BAR.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile   |  2 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c | 45 +++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.h | 31 ++++++++++++++++++
 3 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index f2d64b156ba4..de7abc7c371f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -75,7 +75,7 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o \
-	nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o
+	nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
new file mode 100644
index 000000000000..39a696cd45b5
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
@@ -0,0 +1,45 @@
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
+#include "amdgpu.h"
+#include "amdgpu_atombios.h"
+#include "hdp_v5_2.h"
+
+#include "hdp/hdp_5_2_1_offset.h"
+#include "hdp/hdp_5_2_1_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void hdp_v5_2_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg)
+		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2,
+			0);
+	else
+		amdgpu_ring_emit_wreg(ring,
+			(adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2,
+			0);
+}
+
+const struct amdgpu_hdp_funcs hdp_v5_2_funcs = {
+	.flush_hdp = hdp_v5_2_flush_hdp,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.h b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.h
new file mode 100644
index 000000000000..cb2abc0c80ee
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.h
@@ -0,0 +1,31 @@
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
+#ifndef __HDP_V5_2_H__
+#define __HDP_V5_2_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_hdp_funcs hdp_v5_2_funcs;
+
+#endif
-- 
2.35.1

