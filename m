Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B3BC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068EC10E3A1;
	Wed, 29 Mar 2023 20:18:03 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 728DB10E3A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:18:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCkmBACmMf+wQ6+cDCOnLnmw7B0sSyAdP2CmhPcKWQK5c9OXHWgfhduSeBX0SYeOEin/goDKOPwqBiFuU9xbq7qFCSHytDMjhpNXER5iNB7ilN2ZnYxWmRkM8pv5N90s8sj6HGuqkUFiqwdsPmmkU1phkOP/tS19UEZMKOmkdLKIRA+TkCCykuqBG6+4riqqmxF/HmfBBQ6/L7IFgdjotD+Nc1ZwDwTEeAV4FEtuCOCR1AFCUKCebq0VPTDRlMuzPvc3xdoyz4Eczh+AD94NkMd7ytwclk6rm4QMTvjo5U4c3n6PPpTT8tIdY5glSNoqACZKqsbUoYZMtYJHnvo1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MnffXbj7G97hubSYOkycqNQDvZAFyTZ/JUXqkfNWOU=;
 b=ehkWwd3++D0jKTbh/zrJWMq96AbX5QeRa/XWzDwU7bZtBAWWiJIyyHIaaK6SEY+LeTpFytRnUDO4K+IH96usE0ilQvi7iWcI8AaBUJ/UZVLRpf7dkMPzObY813Hn7oIhTkCEnfRohIBgZE33AyLqsl9g5hDA6TnK9w9joFvqjSgyCoDniY9U/KfkRYMLu0CxBEazaBVzPYWlFeYqr4geF44Cifxriewu7hLx3tTezkwvLrH1pDZnkIpec0mMXELlJWuaWYHD4fdCqnNU8dDKhfvPfOSrveR2bLFg7u3zE9XCjskuSPF1WYgqS1PQtJKrBqNd7VrUiALBHzQR/eB4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MnffXbj7G97hubSYOkycqNQDvZAFyTZ/JUXqkfNWOU=;
 b=pEtua7bxAX+VOG1kO2o2O4F4jA3ut+Pb1znXtzCT0dYR6H5PrQG9BIfbN9y9Z+SglNn1foYx6VrBrNwSpbAYHvpozndaiqPIKDXTZWPqsm8AV07eoGSkVwSD72oU0hW6KhUNTX6LZPM2oF6MoXJYVhT3mkCJ/7l4/19H6axspZk=
Received: from BL0PR1501CA0017.namprd15.prod.outlook.com
 (2603:10b6:207:17::30) by PH7PR12MB8796.namprd12.prod.outlook.com
 (2603:10b6:510:272::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 20:17:59 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::1d) by BL0PR1501CA0017.outlook.office365.com
 (2603:10b6:207:17::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 20:17:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:17:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: add new doorbell assignment table for
 aqua_vanjaram
Date: Wed, 29 Mar 2023 16:17:40 -0400
Message-ID: <20230329201744.1982926-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b10ba6-73ab-4d7a-0a83-08db3092b0c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjJN5J0bOvQoDldm9eD5BRu5/qasR6n3eYLjqZNLI/T4disqMNEi9eyM6gcJ4mprqWBJ8/UzXbyThK0kZI/7zbgaiM8by6Lv8ObbXjO2VO+SekgT6NqOvo8QWcVy1c1Wcib3AYOpwyi/xbAC4jHyxT0Mm4k0dM3GYjhjt2YKhE3Tpk+G/N31J58VVQ8ZpVhiJFGt53/ILASoab9VWkTW2ovjEnLIGlyHSSH1qjQ/4oGMvnGGxjJ+OpxNAtUeqRmXTaVDNoAua5pOckjJWf4k2/LiekgSXE4lXZsw/2+U/hDZOQK0R0NO9I30BV1z1xAEF7qUC1eQPP2+Bzqcg9C5/QBsIwuOXe5a5fyiYa6sD2gscPDTindrkBU0+CA7Hyjvhhqo/luJ2JUAJoCuazxY7tcT28EYdfzxfIm5xMgQANSG/BzezRYA/6Z6FDBsnJfX5DN7boHRppGgbisHRcpDWudFE4dieLs8dRnjj5muKzN2UX7uH6f/IQF+Ry8R5f7181X1qPtKsurarDTSgOs2UV1O7FkpYA7g8jYVaDY2RYp9g/jMx6gnJGWLT80sC1vRPbJTuP4IAiqq63v7BepF9EN7jlA4l0gQz+vK3ooMlF2Bbu10M8QhscUxKCKXaX3SCZu48BbVkbuG/Aa9gpI69qUM5J0ynTKctuVs2xiaIwyN3m9xn/A5mh6l8jzMy2dnRfiYfPXTD4TwNVs96dIa6uKAi4Ja0o+g3RxLoILyttM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(36756003)(83380400001)(5660300002)(82740400003)(356005)(8936002)(40480700001)(82310400005)(66899021)(336012)(81166007)(426003)(86362001)(2616005)(41300700001)(7696005)(6666004)(54906003)(1076003)(47076005)(26005)(316002)(478600001)(36860700001)(16526019)(4326008)(8676002)(70206006)(186003)(70586007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:17:59.1322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b10ba6-73ab-4d7a-0a83-08db3092b0c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Four basic reasons as below to do the change:
  1. number of ring expand a lot on aqua_vanjaram, and adjustment on old
     assignment cannot make each ring in a continuous doorbell space.
  2. the SDMA doorbell index should not exceed 0x1FF on aqua_vanjaram due to
     regDOORBELLx_CTRL_ENTRY.BIF_DOORBELLx_RANGE_OFFSET_ENTRY field width.
  3. re-design the doorbell assignment and unify the calculation as
     "start + ring/inst id" will make the code much concise.
  4. only defining the START/END makes the table look simple

v2: (Lijo)
  1. replace name
  2. use num_inst_per_aid/sdma_doorbell_range instead of hardcoding

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c   | 52 +++++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 594e303084c5..90f771423c94 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -78,7 +78,7 @@ amdgpu-y += \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
-	nbio_v7_9.o
+	nbio_v7_9.o aqua_vanjaram_reg_init.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
new file mode 100644
index 000000000000..3b97bc922d4a
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -0,0 +1,52 @@
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
+#include "amdgpu.h"
+#include "soc15.h"
+
+#include "soc15_common.h"
+
+void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
+{
+	int i;
+
+	adev->doorbell_index.kiq = AMDGPU_DOORBELL_LAYOUT1_KIQ_START;
+
+	adev->doorbell_index.mec_ring0 = AMDGPU_DOORBELL_LAYOUT1_MEC_RING_START;
+
+	adev->doorbell_index.userqueue_start = AMDGPU_DOORBELL_LAYOUT1_USERQUEUE_START;
+	adev->doorbell_index.userqueue_end = AMDGPU_DOORBELL_LAYOUT1_USERQUEUE_END;
+
+	adev->doorbell_index.sdma_doorbell_range = 20;
+	for (i = 0; i < adev->num_aid * adev->sdma.num_inst_per_aid; i++)
+		adev->doorbell_index.sdma_engine[i] =
+			AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_START +
+			i * (adev->doorbell_index.sdma_doorbell_range >> 1);
+
+	adev->doorbell_index.ih = AMDGPU_DOORBELL_LAYOUT1_IH;
+	adev->doorbell_index.vcn.vcn_ring0_1 = AMDGPU_DOORBELL_LAYOUT1_VCN_START;
+
+	adev->doorbell_index.first_non_cp = AMDGPU_DOORBELL_LAYOUT1_FIRST_NON_CP;
+	adev->doorbell_index.last_non_cp = AMDGPU_DOORBELL_LAYOUT1_LAST_NON_CP;
+
+	adev->doorbell_index.max_assignment = AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT << 1;
+}
-- 
2.39.2

