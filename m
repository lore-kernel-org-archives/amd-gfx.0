Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B33606A31C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DAi5VHJ8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0623410E7F9;
	Mon,  9 Nov 2026 18:47:07 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9474A10E705
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 18:46:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsR0Xy+ZYm5TMqOvs9VC6DIolOOVF0p/mfwNaPIErURfx3PMfM+aDzPmPju3jQxvW59hh3gpV1Cx+h6UBe7Svet5H54+z5fjaEjVYW4H69o2FEfOhkjBp/A2+HyHoEdHIhN4T7+DIu+wuIbKieugVOMw4jlilGmPHDOME/eoVlnPknc7fZ5MSSeOhQz4FZGuzz4aWvK1qfSXsy8HLjWJZ5N9p6eigqEfH3jOvvFKqQizA9e6Xso+HLBvfz3cE5XW1xtoJwyr+wX3bC2l96Hh9LYGBXFMYkwiGynWL5L2nGgEMRAr7UWyT5OBVrtHI4Q3uLLYz3UUqpMhb1CqS9Fm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OEy9jlWn5adp5oHxE1CUJTjHcNogMU5tgWegQS55kA=;
 b=vW5dt0enSMX4g0E/9ZLNjgS9uLbPw281vwaLwwkPG9Dgg+82cmFixJtA3HSfXxIIL4ir69CyzLvjJ5gFqm5psLPL63FqmwIIPPeQVyniTrugnXWvkE2tu0j+atizbzMy+eeBWLi45rfXC2uY117sUEewlmfcMDXZYZ93v8iM34cCD+T/HXq3AmNnJ5wfCEKxwiWlSlUNMe0M5u8QdobanoPHlRn/B+GFTBom9ILkIlGHF6W9Cr/wTGRvMK/EYi7poAboRpsma1fgQpLiTJGXn7u8WyMqX7KvQpJdOuhwFwt1NXW+nvWDPlZxPQU2JoUIH1Wh+CVEvYaT2iF0kGzc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OEy9jlWn5adp5oHxE1CUJTjHcNogMU5tgWegQS55kA=;
 b=DAi5VHJ8xUUrrKWqG6RHqC2MfgdVvP1QLfQT91+wv7V7Q9RA1b3UlAJvONrgyYERcO0EtQILYUHpw5i8g+L4D9vBiFs8Y32yneGLi0YQ77H1Y3mOfws+Bi8dpZmXBTwH4Z+yVPisWKF6Eoko8YsT6be1UtsbwtepUD3OOeMX19I=
Received: from SJ0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:a03:33e::22)
 by SJ5PPFD525C5379.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 18:46:54 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::aa) by SJ0PR03CA0047.outlook.office365.com
 (2603:10b6:a03:33e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Mon, 9
 Nov 2026 18:46:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 18:46:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 12:46:50 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 12:46:50 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 5/8] drm/amdkfd: Add initial GC 13 support
Date: Mon, 9 Nov 2026 13:46:37 -0500
Message-ID: <20261109184641.3656885-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109184641.3656885-1-alexander.deucher@amd.com>
References: <20261109184641.3656885-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SJ5PPFD525C5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ded234d-ea67-4360-d892-08df3e91d16e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|6133799003|10063799003|10067099003|3023799007|261026135527099003|11063799006|261026121527099003|261021133027099003|261026130827099003|261028144727099003|261102123227099003|261026140227099003|261021135927099003|261021121427099003|261021123027099003|261021130227099003|261022075727099003|56012099006|261022115727099003|261022113327099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 9imhJs6DU6x+oHeI3Ka7055e/3C2ka6K2dXs+Se2qxr/Ihs+BFrSav4LH6aVdARrhHLOFg88Xg1ZxluU1HoZkYuNzNsDUga5BGHU7qR30qMDbgNc+eE4fGGIkIWUkCETPvLWUDuVwOlChQ8KC8O02M8a+59JAe9sAYmvzHIhc6xNQc8wze3G5pEDALWOTOiC0E2b0tzLQBbzqe/WDB3h19so+HvImMYT2FwttWZBdCU/WjSpyKJrmX7zQ5hXcV78uU8v8JiV+0yvbfmJpRbagO1CAByycFg1yjXuG/e7pmF6osiixaVquzga6AXfZ34j+1kvqjR3GAAh/ujUQ5VNQtWBDQB/AwddGHCvQmosAoH3QwQzEnnj9thBhm3x9Wv6rDvyLsldnOtV34p59G85Q0mi4vfjbqiGQz9xe0Hpzex25lGnMMS5eD+Xt/sg0qW/wsa4R71EyLrnsksn1r74dFhbdP+mGm3GDAK9Md62yZ7aQKROUT+wEWXBaQ5MNz892sxg4r3aum2NVqSLnbHYDbZt32CHYbOHLiwZo0+ceR236QvdCuRZAbjziDRmP/AN+2DNERTJFmz2CCn/GDezXF8o49abUxS5i4HYJWdeYU2iBKQGyfzkG6ReIflDA5NiJv7Az3xUqXMGFs2B7Z6O4j+xpfDcCh/zRSjFztZ/iGwRMLMcAcobvUTGhTr6nJbs2voUbzbhx4hS+EyqO1g7dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10063799003)(10067099003)(3023799007)(261026135527099003)(11063799006)(261026121527099003)(261021133027099003)(261026130827099003)(261028144727099003)(261102123227099003)(261026140227099003)(261021135927099003)(261021121427099003)(261021123027099003)(261021130227099003)(261022075727099003)(56012099006)(261022115727099003)(261022113327099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZhYT17QB+PYipPqypZe5a4aISnapfvxQfSHSl+nUwBYYdclwcwYyfjJr+kXz9fX2F+ilnmKWPftka6U3nks+wxQOgS1pj8VrE9gXXxI1RIGZbnKYeiUsU0SMw9KqmsNTdbiWZzjV3c0Zbx/OGshaPfS5QjBub8dSD8rYD5MXrKjHzpYPB28eWYRwD2sXXsPGjBL1GL9z+eIiSp8LLEbxkwsrvNqWf2favtqxOWy2O3X7xpsGkl5QJwEyoxmGfCpfpLseTXA2lRU1QRhh/FMMLoFnqCqMDn//jCHfaGWx1Cje5O5oe+brKtCYeGv9n6JYC6g9eY+Y7nytpWK8anMvC5EZCYeuE7HgCLlLnpWS6IBwe8LqLD43mS2phk/zkAibGdo8ZP2I52aTptdEicQeoUkCNXAZsFVXQCqjvkHgkr5nPkiXCMEj/Xj9zJBwRxEA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:46:51.3742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ded234d-ea67-4360-d892-08df3e91d16e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Belanger <david.belanger@amd.com>

Add support for GC 13.  Based on GC 12.

v2: squash in updates

Signed-off-by: David Belanger <david.belanger@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v13.c    | 521 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/mes_v13_0.c        |   6 +
 drivers/gpu/drm/amd/amdkfd/Makefile           |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  18 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   4 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   4 +-
 .../amd/amdkfd/kfd_device_queue_manager_v13.c |  90 +++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |   2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v13.c  | 459 +++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |   6 +-
 drivers/gpu/drm/amd/include/mes_v13_api_def.h |   4 +
 drivers/gpu/drm/amd/include/v13_structs.h     |   5 +-
 16 files changed, 1122 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v13.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v13.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v13.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 4585e484ddf4b..0f22ae6f82618 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -307,7 +307,8 @@ amdgpu-y += \
 	amdgpu_amdkfd_gfx_v10_3.o \
 	amdgpu_amdkfd_gfx_v11.o \
 	amdgpu_amdkfd_gfx_v12.o \
-	amdgpu_amdkfd_gfx_v12_1.o
+	amdgpu_amdkfd_gfx_v12_1.o \
+	amdgpu_amdkfd_gfx_v13.o
 
 ifneq ($(CONFIG_DRM_AMDGPU_CIK),)
 amdgpu-y += amdgpu_amdkfd_gfx_v7.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v13.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v13.c
new file mode 100644
index 0000000000000..261b3617ca954
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v13.c
@@ -0,0 +1,521 @@
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
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_amdkfd.h"
+#include "gc/gc_13_0_1_offset.h"
+#include "gc/gc_13_0_1_sh_mask.h"
+#include "soc_v2_0.h"
+#include "navi10_enum.h"
+
+#include <uapi/linux/kfd_ioctl.h>
+
+static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
+			uint32_t queue, uint32_t vmid)
+{
+	mutex_lock(&adev->srbm_mutex);
+	soc_v2_0_grbm_select(adev, mec, pipe, queue, vmid);
+}
+
+static void unlock_srbm(struct amdgpu_device *adev)
+{
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+static void acquire_queue(struct amdgpu_device *adev, uint32_t pipe_id,
+				uint32_t queue_id)
+{
+	uint32_t mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
+	uint32_t pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
+
+	lock_srbm(adev, mec, pipe, queue_id, 0);
+}
+
+static void release_queue(struct amdgpu_device *adev)
+{
+	unlock_srbm(adev);
+}
+
+static int init_interrupts_v13(struct amdgpu_device *adev, uint32_t pipe_id, uint32_t inst)
+{
+	uint32_t mec;
+	uint32_t pipe;
+
+	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
+	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
+
+	lock_srbm(adev, mec, pipe, 0, 0);
+
+	WREG32_SOC15(GC, 0, regCPC_INT_CNTL,
+		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
+		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
+
+	unlock_srbm(adev);
+
+	return 0;
+}
+
+static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
+				unsigned int engine_id,
+				unsigned int queue_id)
+{
+	uint32_t sdma_engine_reg_base = 0;
+	uint32_t sdma_rlc_reg_offset;
+
+	switch (engine_id) {
+	case 0:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, 0,
+				regSDMA0_SDMA_QUEUE0_RB_CNTL) - regSDMA0_SDMA_QUEUE0_RB_CNTL;
+		break;
+	case 1:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA1, 0,
+				regSDMA1_SDMA_QUEUE0_RB_CNTL) - regSDMA0_SDMA_QUEUE0_RB_CNTL;
+		break;
+	default:
+		BUG();
+	}
+
+	sdma_rlc_reg_offset = sdma_engine_reg_base
+		+ queue_id * (regSDMA0_SDMA_QUEUE1_RB_CNTL - regSDMA0_SDMA_QUEUE0_RB_CNTL);
+
+	pr_debug("RLC register offset for SDMA%d RLC%d: 0x%x\n", engine_id,
+			queue_id, sdma_rlc_reg_offset);
+
+	return sdma_rlc_reg_offset;
+}
+
+static int hqd_dump_v13(struct amdgpu_device *adev,
+			uint32_t pipe_id, uint32_t queue_id,
+			uint32_t (**dump)[2], uint32_t *n_regs, uint32_t inst)
+{
+	uint32_t i = 0, reg;
+#define HQD_N_REGS 56
+#define DUMP_REG(addr) do {				\
+		if (WARN_ON_ONCE(i >= HQD_N_REGS))	\
+			break;				\
+		(*dump)[i][0] = (addr) << 2;		\
+		(*dump)[i++][1] = RREG32(addr);		\
+	} while (0)
+
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
+	if (*dump == NULL)
+		return -ENOMEM;
+
+	acquire_queue(adev, pipe_id, queue_id);
+
+	for (reg = SOC15_REG_OFFSET(GC, 0, regCP_MQD_BASE_ADDR);
+	     reg <= SOC15_REG_OFFSET(GC, 0, regCP_HQD_PQ_WPTR_HI); reg++)
+		DUMP_REG(reg);
+
+	release_queue(adev);
+
+	WARN_ON_ONCE(i != HQD_N_REGS);
+	*n_regs = i;
+
+	return 0;
+}
+
+static int hqd_sdma_dump_v13(struct amdgpu_device *adev,
+			     uint32_t engine_id, uint32_t queue_id,
+			     uint32_t (**dump)[2], uint32_t *n_regs)
+{
+	uint32_t sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev,
+			engine_id, queue_id);
+	uint32_t i = 0, reg;
+
+	const uint32_t first_reg = regSDMA0_SDMA_QUEUE0_RB_CNTL;
+	const uint32_t last_reg = regSDMA0_SDMA_QUEUE0_CONTEXT_STATUS;
+#undef HQD_N_REGS
+#define HQD_N_REGS (last_reg - first_reg + 1)
+
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
+	if (*dump == NULL)
+		return -ENOMEM;
+
+	for (reg = first_reg;
+	     reg <= last_reg; reg++)
+		DUMP_REG(sdma_rlc_reg_offset + reg);
+
+	WARN_ON_ONCE(i != HQD_N_REGS);
+	*n_regs = i;
+
+	return 0;
+}
+
+static int wave_control_execute_v13(struct amdgpu_device *adev,
+					uint32_t gfx_index_val,
+					uint32_t sq_cmd, uint32_t inst)
+{
+	uint32_t data = 0;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	WREG32(SOC15_REG_OFFSET(GC, 0, regGRBM_GFX_INDEX), gfx_index_val);
+	WREG32(SOC15_REG_OFFSET(GC, 0, regSQ_CMD), sq_cmd);
+
+	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+		INSTANCE_BROADCAST_WRITES, 1);
+	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+		SA_BROADCAST_WRITES, 1);
+	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+		SE_BROADCAST_WRITES, 1);
+
+	WREG32(SOC15_REG_OFFSET(GC, 0, regGRBM_GFX_INDEX), data);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return 0;
+}
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_gfx_v13_enable_debug_trap(struct amdgpu_device *adev,
+					    bool restore_dbg_registers,
+					    uint32_t vmid)
+{
+	uint32_t data = 0;
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, 0);
+
+	return data;
+}
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_gfx_v13_disable_debug_trap(struct amdgpu_device *adev,
+						bool keep_trap_enabled,
+						uint32_t vmid)
+{
+	uint32_t data = 0;
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, 0);
+
+	return data;
+}
+
+static int kgd_gfx_v13_validate_trap_override_request(struct amdgpu_device *adev,
+							uint32_t trap_override,
+							uint32_t *trap_mask_supported)
+{
+	*trap_mask_supported &= KFD_DBG_TRAP_MASK_FP_INVALID |
+				KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
+				KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
+				KFD_DBG_TRAP_MASK_FP_OVERFLOW |
+				KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
+				KFD_DBG_TRAP_MASK_FP_INEXACT |
+				KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
+				KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
+				KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION |
+				KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START |
+				KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
+
+
+	if (trap_override != KFD_DBG_TRAP_OVERRIDE_OR &&
+			trap_override != KFD_DBG_TRAP_OVERRIDE_REPLACE)
+		return -EPERM;
+
+	return 0;
+}
+
+static uint32_t trap_mask_map_sw_to_hw(uint32_t mask)
+{
+	uint32_t trap_on_start = (mask & KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START) ? 1 : 0;
+	uint32_t trap_on_end = (mask & KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END) ? 1 : 0;
+	uint32_t excp_en = mask & (KFD_DBG_TRAP_MASK_FP_INVALID |
+			KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
+			KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
+			KFD_DBG_TRAP_MASK_FP_OVERFLOW |
+			KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
+			KFD_DBG_TRAP_MASK_FP_INEXACT |
+			KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
+			KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
+			KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION);
+	uint32_t ret;
+
+	ret = REG_SET_FIELD(0, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, excp_en);
+	ret = REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_START, trap_on_start);
+	ret = REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_END, trap_on_end);
+
+	return ret;
+}
+
+static uint32_t trap_mask_map_hw_to_sw(uint32_t mask)
+{
+	uint32_t ret = REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, EXCP_EN);
+
+	if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_START))
+		ret |= KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START;
+
+	if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_END))
+		ret |= KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
+
+	return ret;
+}
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_gfx_v13_set_wave_launch_trap_override(struct amdgpu_device *adev,
+					uint32_t vmid,
+					uint32_t trap_override,
+					uint32_t trap_mask_bits,
+					uint32_t trap_mask_request,
+					uint32_t *trap_mask_prev,
+					uint32_t kfd_dbg_trap_cntl_prev)
+
+{
+	uint32_t data = 0;
+
+	*trap_mask_prev = trap_mask_map_hw_to_sw(kfd_dbg_trap_cntl_prev);
+
+	data = (trap_mask_bits & trap_mask_request) | (*trap_mask_prev & ~trap_mask_request);
+	data = trap_mask_map_sw_to_hw(data);
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, trap_override);
+
+	return data;
+}
+
+/* returns STALL_VMID or LAUNCH_MODE. */
+static uint32_t kgd_gfx_v13_set_wave_launch_mode(struct amdgpu_device *adev,
+					uint8_t wave_launch_mode,
+					uint32_t vmid)
+{
+	uint32_t data = 0;
+	bool is_stall_mode = wave_launch_mode == 4;
+
+	if (is_stall_mode)
+		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, STALL_VMID,
+									1);
+	else
+		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, LAUNCH_MODE,
+							wave_launch_mode);
+
+	return data;
+}
+
+#define TCP_WATCH_STRIDE (regTCP_WATCH1_ADDR_H - regTCP_WATCH0_ADDR_H)
+static uint32_t kgd_gfx_v13_set_address_watch(struct amdgpu_device *adev,
+					uint64_t watch_address,
+					uint32_t watch_address_mask,
+					uint32_t watch_id,
+					uint32_t watch_mode,
+					uint32_t debug_vmid,
+					uint32_t inst)
+{
+	uint32_t watch_address_cntl;
+
+	watch_address_cntl = 0;
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MODE,
+			watch_mode);
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MASK,
+			watch_address_mask >> 7);
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			VALID,
+			1);
+
+	return watch_address_cntl;
+}
+
+static uint32_t kgd_gfx_v13_clear_address_watch(struct amdgpu_device *adev,
+					uint32_t watch_id)
+{
+	return 0;
+}
+
+static uint32_t kgd_gfx_v13_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
+						 int engine, int queue)
+{
+	return 0;
+}
+
+static void lock_spi_csq_mutexes(struct amdgpu_device *adev)
+{
+	mutex_lock(&adev->srbm_mutex);
+	mutex_lock(&adev->grbm_idx_mutex);
+
+}
+
+static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
+{
+	mutex_unlock(&adev->grbm_idx_mutex);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+/**
+ * get_wave_count: Read device registers to get number of waves in flight for
+ * a particular queue. The method also returns the doorbell offset associated
+ * with the queue.
+ *
+ * @adev: Handle of device whose registers are to be read
+ * @queue_idx: Index of queue in the queue-map bit-field
+ * @queue_cnt: Stores the wave count and doorbell offset for an active queue
+ * @inst: xcc's instance number on a multi-XCC setup
+ */
+static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
+		struct kfd_cu_occupancy *queue_cnt, uint32_t inst)
+{
+	int pipe_idx;
+	int queue_slot;
+	unsigned int reg_val;
+	unsigned int wave_cnt;
+	/*
+	 * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMID
+	 * parameters to read out waves in flight. Get doorbell offset if there are
+	 * non-zero waves in flight.
+	 */
+	pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
+	queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
+	soc_v2_0_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
+	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, 0,
+				  regSPI_CSQ_WF_ACTIVE_COUNT_0) + queue_slot);
+	wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
+	if (wave_cnt != 0) {
+		queue_cnt->wave_cnt += wave_cnt;
+		queue_cnt->doorbell_off =
+			(RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL) &
+			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
+			 CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	}
+}
+
+/**
+ * kgd_gfx_v13_get_cu_occupancy: Reads relevant registers associated with each
+ * shader engine and aggregates the number of waves that are in flight for the
+ * process whose pasid is provided as a parameter. The process could have ZERO
+ * or more queues running and submitting waves to compute units.
+ *
+ * @adev: Handle of device from which to get number of waves in flight
+ * @cu_occupancy: Array that gets filled with wave_cnt and doorbell offset
+ *		  for comparison later.
+ * @max_waves_per_cu: Output parameter updated with maximum number of waves
+ *                    possible per Compute Unit
+ * @inst: xcc's instance number on a multi-XCC setup
+ *
+ * Note: It's possible that the device has too many queues (oversubscription)
+ * in which case a VMID could be remapped to a different PASID. This could lead
+ * to an inaccurate wave count. Following is a high-level sequence:
+ *    Time T1: vmid = getVmid(); vmid is associated with Pasid P1
+ *    Time T2: passId = getPasId(vmid); vmid is associated with Pasid P2
+ * In the sequence above wave count obtained from time T1 will be incorrectly
+ * lost or added to total wave count.
+ *
+ * The registers that provide the waves in flight are:
+ *
+ *  SPI_CSQ_WF_ACTIVE_STATUS - bit-map of queues per pipe. The bit is ON if a
+ *  queue is slotted, OFF if there is no queue. A process could have ZERO or
+ *  more queues slotted and submitting waves to be run on compute units. Even
+ *  when there is a queue it is possible there could be zero wave fronts, this
+ *  can happen when queue is waiting on top-of-pipe events - e.g. waitRegMem
+ *  command
+ *
+ *  For each bit that is ON from above:
+ *
+ *    Read (SPI_CSQ_WF_ACTIVE_COUNT_0 + queue_idx) register. It provides the
+ *    number of waves that are in flight for the queue at specified index. The
+ *    index ranges from 0 to 7.
+ *
+ *    If non-zero waves are in flight, store the corresponding doorbell offset
+ *    of the queue, along with the wave count.
+ *
+ *    Determine if the queue belongs to the process by comparing the doorbell
+ *    offset against the process's queues. If it matches, aggregate the wave
+ *    count for the process.
+ *
+ *  Reading registers referenced above involves programming GRBM appropriately
+ */
+static void kgd_gfx_v13_get_cu_occupancy(struct amdgpu_device *adev,
+				struct kfd_cu_occupancy *cu_occupancy,
+				int *max_waves_per_cu, uint32_t inst)
+{
+	int qidx;
+	int se_idx;
+	int se_cnt;
+	int queue_map;
+	int max_queue_cnt;
+	DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
+
+	lock_spi_csq_mutexes(adev);
+	soc_v2_0_grbm_select(adev, 1, 0, 0, 0);
+
+	/*
+	 * Iterate through the shader engines and arrays of the device
+	 * to get number of waves in flight
+	 */
+	bitmap_complement(cp_queue_bitmap, adev->gfx.mec_bitmap[0].queue_bitmap,
+			  AMDGPU_MAX_QUEUES);
+	max_queue_cnt = adev->gfx.mec.num_pipe_per_mec *
+			adev->gfx.mec.num_queue_per_pipe;
+	se_cnt = adev->gfx.config.max_shader_engines;
+	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
+		amdgpu_gfx_select_se_sh(adev, se_idx, 0, 0xffffffff, inst);
+		queue_map = RREG32_SOC15(GC, 0, regSPI_CSQ_WF_ACTIVE_STATUS);
+
+		for (qidx = 0; qidx < max_queue_cnt; qidx++) {
+			/* Skip queues that are not associated with
+			 * compute functions
+			 */
+			if (!test_bit(qidx, cp_queue_bitmap))
+				continue;
+
+			if (!(queue_map & (1 << qidx)))
+				continue;
+
+			/* Get number of waves in flight and aggregate them */
+			get_wave_count(adev, qidx, &cu_occupancy[qidx], inst);
+		}
+	}
+
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, inst);
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	unlock_spi_csq_mutexes(adev);
+
+	/* Update the output parameters and return */
+	*max_waves_per_cu = adev->gfx.cu_info.simd_per_cu *
+				adev->gfx.cu_info.max_waves_per_simd;
+}
+
+const struct kfd2kgd_calls gfx_v13_kfd2kgd = {
+	.init_interrupts = init_interrupts_v13,
+	.hqd_dump = hqd_dump_v13,
+	.hqd_sdma_dump = hqd_sdma_dump_v13,
+	.wave_control_execute = wave_control_execute_v13,
+	.get_atc_vmid_pasid_mapping_info = NULL,
+	.enable_debug_trap = kgd_gfx_v13_enable_debug_trap,
+	.disable_debug_trap = kgd_gfx_v13_disable_debug_trap,
+	.validate_trap_override_request = kgd_gfx_v13_validate_trap_override_request,
+	.set_wave_launch_trap_override = kgd_gfx_v13_set_wave_launch_trap_override,
+	.set_wave_launch_mode = kgd_gfx_v13_set_wave_launch_mode,
+	.set_address_watch = kgd_gfx_v13_set_address_watch,
+	.clear_address_watch = kgd_gfx_v13_clear_address_watch,
+	.hqd_sdma_get_doorbell = kgd_gfx_v13_hqd_sdma_get_doorbell,
+	.get_cu_occupancy = kgd_gfx_v13_get_cu_occupancy,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c
index 41e85d8bd9bd2..d6ae2acfdb4b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c
@@ -5786,6 +5786,7 @@ static int gfx_v13_0_get_cu_info(struct amdgpu_device *adev,
 
 	cu_info->number = active_cu_number;
 	cu_info->simd_per_cu = NUM_SIMD_PER_CU;
+	cu_info->lds_size = 96;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v13_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v13_0.c
index 6daa6910952a5..2781f43ebaee6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v13_0.c
@@ -658,6 +658,12 @@ static int mes_v13_0_misc_op(struct amdgpu_mes *mes,
 		memcpy(misc_pkt.set_shader_debugger.tcp_watch_cntl,
 				input->set_shader_debugger.tcp_watch_cntl,
 				sizeof(misc_pkt.set_shader_debugger.tcp_watch_cntl));
+		for (int i = 0; i < 4; i++) {
+			misc_pkt.set_shader_debugger.tcp_watch_addr_lo[i] =
+				lower_32_bits(input->set_shader_debugger.watch_addresses[i]);
+			misc_pkt.set_shader_debugger.tcp_watch_addr_hi[i] =
+				upper_32_bits(input->set_shader_debugger.watch_addresses[i]) & 0xffff;
+		}
 		misc_pkt.set_shader_debugger.trap_en = input->set_shader_debugger.trap_en;
 		break;
 	case MES_MISC_OP_CHANGE_CONFIG:
diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index 85fc67d521e53..258e66c50d24b 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -39,6 +39,7 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_mqd_manager_v11.o \
 		$(AMDKFD_PATH)/kfd_mqd_manager_v12.o \
 		$(AMDKFD_PATH)/kfd_mqd_manager_v12_1.o \
+		$(AMDKFD_PATH)/kfd_mqd_manager_v13.o \
 		$(AMDKFD_PATH)/kfd_kernel_queue.o \
 		$(AMDKFD_PATH)/kfd_packet_manager.o \
 		$(AMDKFD_PATH)/kfd_packet_manager_vi.o \
@@ -52,6 +53,7 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_device_queue_manager_v11.o \
 		$(AMDKFD_PATH)/kfd_device_queue_manager_v12.o \
 		$(AMDKFD_PATH)/kfd_device_queue_manager_v12_1.o \
+		$(AMDKFD_PATH)/kfd_device_queue_manager_v13.o \
 		$(AMDKFD_PATH)/kfd_interrupt.o \
 		$(AMDKFD_PATH)/kfd_events.o \
 		$(AMDKFD_PATH)/cik_event_interrupt.o \
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 32d7573dffc94..a8fadbbbd2929 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1510,7 +1510,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 		pcache_info[i].num_cu_shared = adev->gfx.config.max_cu_per_sh;
 		pcache_info[i].cache_line_size = adev->gfx.config.gc_tcc_cache_line_size;
 		if (cache_line_size_missing && !pcache_info[i].cache_line_size)
-			pcache_info[i].cache_line_size = 128;
+			pcache_info[i].cache_line_size = KFD_GC_VERSION(kdev) >= IP_VERSION(13, 0, 1) ?
+					256 : 128;
 		i++;
 	}
 	/* L3 Data Cache per GPU */
@@ -1726,7 +1727,8 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 		case IP_VERSION(11, 5, 6):
 		case IP_VERSION(11, 7, 0):
 		case IP_VERSION(11, 7, 1):
-			/* Cacheline size not available in IP discovery for gc11.
+		case IP_VERSION(13, 0, 1):
+			/* Cacheline size not available in IP discovery for gc11/1301.
 			 * kfd_fill_gpu_cache_info_from_gfx_config to hard code it
 			 */
 			cache_line_size_missing = true;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index edafbd9377b5d..3a8f76909752e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -59,6 +59,7 @@ extern const struct kfd2kgd_calls gfx_v10_3_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v11_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v12_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v12_1_kfd2kgd;
+extern const struct kfd2kgd_calls gfx_v13_kfd2kgd;
 
 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 				unsigned int chunk_size);
@@ -111,6 +112,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(7, 0, 0):
 	case IP_VERSION(7, 0, 1):
 	case IP_VERSION(7, 1, 0):
+	case IP_VERSION(8, 0, 1):
 		kfd->device_info.num_sdma_queues_per_engine = 8;
 		/* Reserve 1 for paging and 1 for gfx */
 		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
@@ -176,7 +178,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 		break;
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
-		/* GFX12_TODO: Change to v12 version. */
+	case IP_VERSION(13, 0, 1):
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
 		break;
 	case IP_VERSION(12, 1, 0):
@@ -236,6 +238,8 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
 		} else if (gc_version < IP_VERSION(13, 0, 0)) {
 			kfd->device_info.needs_pci_atomics = true;
 			kfd->device_info.no_atomic_fw_version = 2090;
+		} else if (gc_version < IP_VERSION(14, 0, 0)) {
+		    kfd->device_info.needs_pci_atomics = true;
 		} else {
 			kfd->device_info.needs_pci_atomics = true;
 		}
@@ -474,6 +478,11 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			gfx_target_version = 120500;
 			f2g = &gfx_v12_1_kfd2kgd;
 			break;
+		case IP_VERSION(13, 0, 1):
+			/* Note: Compiler version is 13.1.0 while HW version is 13.0.1 */
+			gfx_target_version = 130100;
+			f2g = &gfx_v13_kfd2kgd;
+			break;
 		default:
 			break;
 		}
@@ -570,11 +579,16 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_gfx12_1_0_rev_0_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_1_0_rev_0_hex);
-		} else {
+		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(13, 0, 0)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_rev_1_hex)
 					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_gfx12_1_0_rev_1_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_1_0_rev_1_hex);
+		} else {
+			BUILD_BUG_ON(sizeof(cwsr_trap_gfx13_hex)
+					     > KFD_CWSR_TMA_OFFSET);
+			kfd->cwsr_isa = cwsr_trap_gfx13_hex;
+			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx13_hex);
 		}
 
 		kfd->cwsr_enabled = true;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ce67e56efa8c1..6f5a8a016d2b8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3499,7 +3499,9 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		break;
 
 	default:
-		if (KFD_GC_VERSION(dev) >= IP_VERSION(12, 1, 0))
+		if (KFD_GC_VERSION(dev) >= IP_VERSION(13, 0, 0))
+			device_queue_manager_init_v13(&dqm->asic_ops);
+		else if (KFD_GC_VERSION(dev) >= IP_VERSION(12, 1, 0))
 			device_queue_manager_init_v12_1(&dqm->asic_ops);
 		else if (KFD_GC_VERSION(dev) >= IP_VERSION(12, 0, 0))
 			device_queue_manager_init_v12(&dqm->asic_ops);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index c21da12d3f384..2e4f1c467b00d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2014-2022 Advanced Micro Devices, Inc.
+ * Copyright 2014-2025 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -308,6 +308,8 @@ void device_queue_manager_init_v12(
 		struct device_queue_manager_asic_ops *asic_ops);
 void device_queue_manager_init_v12_1(
 		struct device_queue_manager_asic_ops *asic_ops);
+void device_queue_manager_init_v13(
+		struct device_queue_manager_asic_ops *asic_ops);
 void program_sh_mem_settings(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd);
 unsigned int get_cp_queues_num(struct device_queue_manager *dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v13.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v13.c
new file mode 100644
index 0000000000000..766ebd625ef6e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v13.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
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
+#include "kfd_device_queue_manager.h"
+#include "gc/gc_13_0_1_sh_mask.h"
+#include "soc24_enum.h"
+
+static int update_qpd_v13(struct device_queue_manager *dqm,
+			 struct qcm_process_device *qpd);
+static void init_sdma_vm_v13(struct device_queue_manager *dqm, struct queue *q,
+			    struct qcm_process_device *qpd);
+static bool set_cache_memory_policy_v13(struct device_queue_manager *dqm,
+				   struct qcm_process_device *qpd,
+				   enum cache_policy default_policy,
+				   enum cache_policy alternate_policy,
+				   void __user *alternate_aperture_base,
+				   uint64_t alternate_aperture_size,
+				   u32 misc_process_properties);
+
+void device_queue_manager_init_v13(
+	struct device_queue_manager_asic_ops *asic_ops)
+{
+	asic_ops->set_cache_memory_policy = set_cache_memory_policy_v13;
+	asic_ops->update_qpd = update_qpd_v13;
+	asic_ops->init_sdma_vm = init_sdma_vm_v13;
+	asic_ops->mqd_manager_init = mqd_manager_init_v13;
+}
+
+static uint32_t compute_sh_mem_bases_64bit(struct kfd_process_device *pdd)
+{
+	uint32_t shared_base = pdd->lds_base >> 48;
+	uint32_t private_base = pdd->scratch_base >> 48;
+
+	return (shared_base << SH_MEM_BASES__SHARED_BASE__SHIFT) |
+		private_base;
+}
+
+static bool set_cache_memory_policy_v13(struct device_queue_manager *dqm,
+				   struct qcm_process_device *qpd,
+				   enum cache_policy default_policy,
+				   enum cache_policy alternate_policy,
+				   void __user *alternate_aperture_base,
+				   uint64_t alternate_aperture_size,
+				   u32 misc_process_properties)
+{
+	qpd->sh_mem_config = (SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
+			      SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
+			      (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
+
+	qpd->sh_mem_ape1_limit = 0;
+	qpd->sh_mem_ape1_base = 0;
+	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(qpd_to_pdd(qpd));
+
+	pr_debug("sh_mem_bases 0x%X\n", qpd->sh_mem_bases);
+	return true;
+}
+
+static int update_qpd_v13(struct device_queue_manager *dqm,
+			 struct qcm_process_device *qpd)
+{
+	return 0;
+}
+
+static void init_sdma_vm_v13(struct device_queue_manager *dqm, struct queue *q,
+			    struct qcm_process_device *qpd)
+{
+	/* Not needed on SDMAv4 onwards any more */
+	q->properties.sdma_vm_addr = 0;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 9b7859a77950e..640112fa39e8a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -133,7 +133,7 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	}
 
 	cu_bitmap_sh_mul = (KFD_GC_VERSION(mm->dev) >= IP_VERSION(11, 0, 0) &&
-			    KFD_GC_VERSION(mm->dev) < IP_VERSION(13, 0, 0)) ? 2 : 1;
+			    KFD_GC_VERSION(mm->dev) < IP_VERSION(14, 0, 0)) ? 2 : 1;
 
 	/* Count active CUs per SH.
 	 *
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v13.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v13.c
new file mode 100644
index 0000000000000..2891ee2edb224
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v13.c
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
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
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include "kfd_priv.h"
+#include "kfd_mqd_manager.h"
+#include "v13_structs.h"
+#include "gc/gc_13_0_1_sh_mask.h"
+
+#include "amdgpu_amdkfd.h"
+
+static inline struct v13_compute_mqd *get_mqd(void *mqd)
+{
+	return (struct v13_compute_mqd *)mqd;
+}
+
+static inline struct v13_sdma_mqd *get_sdma_mqd(void *mqd)
+{
+	return (struct v13_sdma_mqd *)mqd;
+}
+
+static void update_cu_mask(struct mqd_manager *mm, void *mqd,
+			   struct mqd_update_info *minfo)
+{
+	struct v13_compute_mqd *m;
+	uint32_t se_mask[KFD_MAX_NUM_SE] = {0};
+
+	if (!minfo || !minfo->cu_mask.ptr)
+		return;
+
+	mqd_symmetrically_map_cu_mask(mm,
+		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask, 0);
+
+	m = get_mqd(mqd);
+	m->compute_static_thread_mgmt_se0 = se_mask[0];
+	m->compute_static_thread_mgmt_se1 = se_mask[1];
+	m->compute_static_thread_mgmt_se2 = se_mask[2];
+	m->compute_static_thread_mgmt_se3 = se_mask[3];
+	m->compute_static_thread_mgmt_se4 = se_mask[4];
+	m->compute_static_thread_mgmt_se5 = se_mask[5];
+	m->compute_static_thread_mgmt_se6 = se_mask[6];
+	m->compute_static_thread_mgmt_se7 = se_mask[7];
+
+	pr_debug("update cu mask to %#x %#x %#x %#x %#x %#x %#x %#x\n",
+		m->compute_static_thread_mgmt_se0,
+		m->compute_static_thread_mgmt_se1,
+		m->compute_static_thread_mgmt_se2,
+		m->compute_static_thread_mgmt_se3,
+		m->compute_static_thread_mgmt_se4,
+		m->compute_static_thread_mgmt_se5,
+		m->compute_static_thread_mgmt_se6,
+		m->compute_static_thread_mgmt_se7);
+}
+
+static void set_priority(struct v13_compute_mqd *m, struct queue_properties *q)
+{
+	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
+	m->cp_hqd_queue_priority = q->priority;
+}
+
+static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
+		struct queue_properties *q)
+{
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
+	struct kfd_node *node = mm->dev;
+	struct kfd_mem_obj *mqd_mem_obj;
+
+	if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
+		return NULL;
+
+	return mqd_mem_obj;
+}
+
+static void init_mqd(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *q)
+{
+	uint64_t addr;
+	struct v13_compute_mqd *m;
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
+
+	m = (struct v13_compute_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memset(m, 0, mqd_size);
+
+	m->header = 0xC0310800;
+	m->compute_pipelinestat_enable = 1;
+	m->compute_static_thread_mgmt_se0 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se1 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se2 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se3 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se4 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se5 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se6 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se7 = 0xFFFFFFFF;
+
+	m->cp_hqd_persistent_state = CP_HQD_PERSISTENT_STATE__PRELOAD_REQ_MASK |
+			0x65 << CP_HQD_PERSISTENT_STATE__PRELOAD_SIZE__SHIFT;
+
+	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
+	m->cp_mqd_control = 1 << CP_MQD_CONTROL__PRIV_STATE__SHIFT;
+
+	m->cp_mqd_base_addr_lo        = lower_32_bits(addr);
+	m->cp_mqd_base_addr_hi        = upper_32_bits(addr);
+
+	m->cp_hqd_quantum = 1 << CP_HQD_QUANTUM__QUANTUM_EN__SHIFT |
+			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
+			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
+
+	/* Set cp_hqd_hq_status0.c_queue_debug_en to 1 to have the CP set up the
+	 * DISPATCH_PTR.  This is required for the kfd debugger
+	 */
+	m->cp_hqd_hq_status0 = 1 << 14;
+
+	if (amdgpu_amdkfd_have_atomics_support(mm->dev->adev))
+		m->cp_hqd_hq_status0 |= 1 << 29;
+
+	if (q->format == KFD_QUEUE_FORMAT_AQL) {
+		m->cp_hqd_aql_control =
+			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
+	}
+
+	if (mm->dev->kfd->cwsr_enabled) {
+		m->cp_hqd_persistent_state |=
+			(1 << CP_HQD_PERSISTENT_STATE__QSWITCH_MODE__SHIFT);
+		m->cp_hqd_ctx_save_base_addr_lo =
+			lower_32_bits(q->ctx_save_restore_area_address);
+		m->cp_hqd_ctx_save_base_addr_hi =
+			upper_32_bits(q->ctx_save_restore_area_address);
+		m->cp_hqd_ctx_save_size = q->ctx_save_restore_area_size;
+		m->cp_hqd_cntl_stack_size = q->ctl_stack_size;
+		m->cp_hqd_cntl_stack_offset = q->ctl_stack_size;
+		m->cp_hqd_wg_state_offset = q->ctl_stack_size;
+	}
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+	mm->update_mqd(mm, m, q, NULL);
+}
+
+static int load_mqd(struct mqd_manager *mm, void *mqd,
+			uint32_t pipe_id, uint32_t queue_id,
+			struct queue_properties *p, struct mm_struct *mms)
+{
+	int r = 0;
+	/* AQL write pointer counts in 64B packets, PM4/CP counts in dwords. */
+	uint32_t wptr_shift = (p->format == KFD_QUEUE_FORMAT_AQL ? 4 : 0);
+
+	r = mm->dev->kfd2kgd->hqd_load(mm->dev->adev, mqd, pipe_id, queue_id,
+					  (uint32_t __user *)p->write_ptr,
+					  wptr_shift, 0, mms, 0);
+	return r;
+}
+
+static void update_mqd(struct mqd_manager *mm, void *mqd,
+		       struct queue_properties *q,
+		       struct mqd_update_info *minfo)
+{
+	struct v13_compute_mqd *m;
+
+	m = get_mqd(mqd);
+
+	m->cp_hqd_pq_control &= ~CP_HQD_PQ_CONTROL__QUEUE_SIZE_MASK;
+	m->cp_hqd_pq_control |=
+			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
+	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
+
+	m->cp_hqd_pq_base_lo = lower_32_bits((uint64_t)q->queue_address >> 8);
+	m->cp_hqd_pq_base_hi = upper_32_bits((uint64_t)q->queue_address >> 8);
+
+	m->cp_hqd_pq_rptr_report_addr_lo = lower_32_bits((uint64_t)q->read_ptr);
+	m->cp_hqd_pq_rptr_report_addr_hi = upper_32_bits((uint64_t)q->read_ptr);
+	m->cp_hqd_pq_wptr_poll_addr_lo = lower_32_bits((uint64_t)q->write_ptr);
+	m->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits((uint64_t)q->write_ptr);
+
+	m->cp_hqd_pq_doorbell_control =
+		q->doorbell_off <<
+			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	pr_debug("cp_hqd_pq_doorbell_control 0x%x\n",
+			m->cp_hqd_pq_doorbell_control);
+
+	m->cp_hqd_ib_control = 3 << CP_HQD_IB_CONTROL__MIN_IB_AVAIL_SIZE__SHIFT;
+
+	/*
+	 * HW does not clamp this field correctly. Maximum EOP queue size
+	 * is constrained by per-SE EOP done signal count, which is 8-bit.
+	 * Limit is 0xFF EOP entries (= 0x7F8 dwords). CP will not submit
+	 * more than (EOP entry count - 1) so a queue size of 0x800 dwords
+	 * is safe, giving a maximum field value of 0xA.
+	 */
+	m->cp_hqd_eop_control = min(0xA,
+		ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1);
+	m->cp_hqd_eop_base_addr_lo =
+			lower_32_bits(q->eop_ring_buffer_address >> 8);
+	m->cp_hqd_eop_base_addr_hi =
+			upper_32_bits(q->eop_ring_buffer_address >> 8);
+
+	m->cp_hqd_iq_timer = 0;
+
+	m->cp_hqd_vmid = q->vmid;
+
+	if (q->format == KFD_QUEUE_FORMAT_AQL) {
+		/* GC 10 removed WPP_CLAMP from PQ Control */
+		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
+				2 << CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__SHIFT |
+				1 << CP_HQD_PQ_CONTROL__QUEUE_FULL_EN__SHIFT;
+		m->cp_hqd_pq_doorbell_control |=
+			1 << CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_BIF_DROP__SHIFT;
+	}
+	if (mm->dev->kfd->cwsr_enabled)
+		m->cp_hqd_ctx_save_control = 0;
+
+	update_cu_mask(mm, mqd, minfo);
+	set_priority(m, q);
+
+	q->is_active = QUEUE_IS_ACTIVE(*q);
+}
+
+static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
+{
+	struct v13_compute_mqd *m = (struct v13_compute_mqd *)mqd;
+
+	return kfd_check_hiq_mqd_doorbell_id(mm->dev, m->queue_doorbell_id0, 0);
+}
+
+static int get_wave_state(struct mqd_manager *mm, void *mqd,
+			  struct queue_properties *q,
+			  void __user *ctl_stack,
+			  u32 *ctl_stack_used_size,
+			  u32 *save_area_used_size)
+{
+	struct v13_compute_mqd *m;
+	struct mqd_user_context_save_area_header header;
+
+	m = get_mqd(mqd);
+
+	/* Control stack is written backwards, while workgroup context data
+	 * is written forwards. Both starts from m->cp_hqd_cntl_stack_size.
+	 * Current position is at m->cp_hqd_cntl_stack_offset and
+	 * m->cp_hqd_wg_state_offset, respectively.
+	 */
+	*ctl_stack_used_size = m->cp_hqd_cntl_stack_size -
+		m->cp_hqd_cntl_stack_offset;
+	*save_area_used_size = m->cp_hqd_wg_state_offset -
+		m->cp_hqd_cntl_stack_size;
+
+	/* Control stack is not copied to user mode for GFXv13 because
+	 * it's part of the context save area that is already
+	 * accessible to user mode
+	 */
+	header.control_stack_size = *ctl_stack_used_size;
+	header.wave_state_size = *save_area_used_size;
+
+	header.wave_state_offset = m->cp_hqd_wg_state_offset;
+	header.control_stack_offset = m->cp_hqd_cntl_stack_offset;
+
+	if (copy_to_user(ctl_stack, &header, sizeof(header)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *q)
+{
+	struct v13_compute_mqd *m;
+
+	init_mqd(mm, mqd, mqd_mem_obj, gart_addr, q);
+
+	m = get_mqd(*mqd);
+
+	m->cp_hqd_pq_control |= 1 << CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT |
+			1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
+}
+
+static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
+		struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+		struct queue_properties *q)
+{
+	struct v13_sdma_mqd *m;
+
+	m = (struct v13_sdma_mqd *) mqd_mem_obj->cpu_ptr;
+
+	memset(m, 0, sizeof(struct v13_sdma_mqd));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = mqd_mem_obj->gpu_addr;
+
+	mm->update_mqd(mm, m, q, NULL);
+}
+
+#define SDMA_RLC_DUMMY_DEFAULT 0xf
+
+static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
+		struct queue_properties *q,
+		struct mqd_update_info *minfo)
+{
+	struct v13_sdma_mqd *m;
+
+	m = get_sdma_mqd(mqd);
+	m->sdmax_queuen_rb_cntl = (ffs(q->queue_size / sizeof(unsigned int)) - 1)
+		<< SDMA0_SDMA_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
+		q->vmid << SDMA0_SDMA_QUEUE0_RB_CNTL__RB_VMID__SHIFT |
+		1 << SDMA0_SDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
+		6 << SDMA0_SDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT |
+		1 << SDMA0_SDMA_QUEUE0_RB_CNTL__MCU_WPTR_POLL_ENABLE__SHIFT;
+
+	m->sdmax_queuen_rb_base = lower_32_bits(q->queue_address >> 8);
+	m->sdmax_queuen_rb_base_hi = upper_32_bits(q->queue_address >> 8);
+	m->sdmax_queuen_rb_rptr_addr_lo = lower_32_bits((uint64_t)q->read_ptr);
+	m->sdmax_queuen_rb_rptr_addr_hi = upper_32_bits((uint64_t)q->read_ptr);
+	m->sdmax_queuen_rb_wptr_poll_addr_lo = lower_32_bits((uint64_t)q->write_ptr);
+	m->sdmax_queuen_rb_wptr_poll_addr_hi = upper_32_bits((uint64_t)q->write_ptr);
+	m->sdmax_queuen_doorbell_offset =
+		q->doorbell_off << SDMA0_SDMA_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
+
+	m->sdmax_queuen_schedule_cntl = (amdgpu_sdma_phase_quantum
+		<< SDMA0_SDMA_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT)
+		 & SDMA0_SDMA_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK;
+
+	m->sdma_engine_id = q->sdma_engine_id;
+	m->sdma_queue_id = q->sdma_queue_id;
+
+	m->sdmax_queuen_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
+
+	q->is_active = QUEUE_IS_ACTIVE(*q);
+}
+
+#if defined(CONFIG_DEBUG_FS)
+
+static int debugfs_show_mqd(struct seq_file *m, void *data)
+{
+	seq_hex_dump(m, "    ", DUMP_PREFIX_OFFSET, 32, 4,
+		     data, sizeof(struct v13_compute_mqd), false);
+	return 0;
+}
+
+static int debugfs_show_mqd_sdma(struct seq_file *m, void *data)
+{
+	seq_hex_dump(m, "    ", DUMP_PREFIX_OFFSET, 32, 4,
+		     data, sizeof(struct v13_sdma_mqd), false);
+	return 0;
+}
+
+#endif
+
+struct mqd_manager *mqd_manager_init_v13(enum KFD_MQD_TYPE type,
+		struct kfd_node *dev)
+{
+	struct mqd_manager *mqd;
+
+	if (WARN_ON(type >= KFD_MQD_TYPE_MAX))
+		return NULL;
+
+	mqd = kzalloc(sizeof(*mqd), GFP_KERNEL);
+	if (!mqd)
+		return NULL;
+
+	mqd->dev = dev;
+
+	switch (type) {
+	case KFD_MQD_TYPE_CP:
+		pr_debug("%s@%i\n", __func__, __LINE__);
+		mqd->allocate_mqd = allocate_mqd;
+		mqd->init_mqd = init_mqd;
+		mqd->free_mqd = kfd_free_mqd_cp;
+		mqd->load_mqd = load_mqd;
+		mqd->update_mqd = update_mqd;
+		mqd->destroy_mqd = kfd_destroy_mqd_cp;
+		mqd->is_occupied = kfd_is_occupied_cp;
+		mqd->mqd_size = sizeof(struct v13_compute_mqd);
+		mqd->get_wave_state = get_wave_state;
+		mqd->mqd_stride = kfd_mqd_stride;
+#if defined(CONFIG_DEBUG_FS)
+		mqd->debugfs_show_mqd = debugfs_show_mqd;
+#endif
+		pr_debug("%s@%i\n", __func__, __LINE__);
+		break;
+	case KFD_MQD_TYPE_HIQ:
+		pr_debug("%s@%i\n", __func__, __LINE__);
+		mqd->allocate_mqd = allocate_hiq_mqd;
+		mqd->init_mqd = init_mqd_hiq;
+		mqd->free_mqd = free_mqd_hiq_sdma;
+		mqd->load_mqd = kfd_hiq_load_mqd_kiq;
+		mqd->update_mqd = update_mqd;
+		mqd->destroy_mqd = kfd_destroy_mqd_cp;
+		mqd->is_occupied = kfd_is_occupied_cp;
+		mqd->mqd_size = sizeof(struct v13_compute_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
+#if defined(CONFIG_DEBUG_FS)
+		mqd->debugfs_show_mqd = debugfs_show_mqd;
+#endif
+		mqd->check_preemption_failed = check_preemption_failed;
+		pr_debug("%s@%i\n", __func__, __LINE__);
+		break;
+	case KFD_MQD_TYPE_DIQ:
+		mqd->allocate_mqd = allocate_mqd;
+		mqd->init_mqd = init_mqd_hiq;
+		mqd->free_mqd = kfd_free_mqd_cp;
+		mqd->load_mqd = load_mqd;
+		mqd->update_mqd = update_mqd;
+		mqd->destroy_mqd = kfd_destroy_mqd_cp;
+		mqd->is_occupied = kfd_is_occupied_cp;
+		mqd->mqd_size = sizeof(struct v13_compute_mqd);
+#if defined(CONFIG_DEBUG_FS)
+		mqd->debugfs_show_mqd = debugfs_show_mqd;
+#endif
+		break;
+	case KFD_MQD_TYPE_SDMA:
+		pr_debug("%s@%i\n", __func__, __LINE__);
+		mqd->allocate_mqd = allocate_mqd;
+		mqd->init_mqd = init_mqd_sdma;
+		mqd->free_mqd = kfd_free_mqd_cp;
+		mqd->load_mqd = kfd_load_mqd_sdma;
+		mqd->update_mqd = update_mqd_sdma;
+		mqd->destroy_mqd = kfd_destroy_mqd_sdma;
+		mqd->is_occupied = kfd_is_occupied_sdma;
+		mqd->mqd_size = sizeof(struct v13_sdma_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
+#if defined(CONFIG_DEBUG_FS)
+		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
+#endif
+		pr_debug("%s@%i\n", __func__, __LINE__);
+		break;
+	default:
+		kfree(mqd);
+		return NULL;
+	}
+
+	return mqd;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f0ce5fc4a138f..d99c0bc2e1a57 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1402,6 +1402,8 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
 		struct kfd_node *dev);
 struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD_TYPE type,
 		struct kfd_node *dev);
+struct mqd_manager *mqd_manager_init_v13(enum KFD_MQD_TYPE type,
+		struct kfd_node *dev);
 struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev);
 void device_queue_manager_uninit(struct device_queue_manager *dqm);
 struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 6010a5d7a7eb9..82e485f85cbc2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -458,6 +458,8 @@ static u32 kfd_get_hwreg_size_per_cu(u32 gfxv)
 
 	if (gfxv == 120500 || gfxv == 120501)
 		hwreg_size = 0x8000;
+	else if (gfxv == 130100)
+		hwreg_size = 0x4000;
 
 	return hwreg_size;
 }
@@ -466,7 +468,7 @@ static u32 kfd_get_lds_size_per_cu(u32 gfxv, struct kfd_node_properties *props)
 {
 	u32 lds_size = 0x10000;
 
-	if (gfxv == 90500 || gfxv == 120500 || gfxv == 120501)
+	if (gfxv == 90500 || gfxv == 120500 || gfxv == 120501 || gfxv == 130100)
 		lds_size = props->lds_size_in_kb << 10;
 
 	return lds_size;
@@ -483,6 +485,8 @@ static u32 get_num_waves(struct kfd_node_properties *props, u32 gfxv, u32 cu_num
 		wave_num = cu_num * 32;
 	else if (gfxv <= 120501)
 		wave_num = cu_num * 64;
+	else if (gfxv == 130100)
+		wave_num = cu_num * 32;
 
 	WARN_ON(wave_num == 0);
 
diff --git a/drivers/gpu/drm/amd/include/mes_v13_api_def.h b/drivers/gpu/drm/amd/include/mes_v13_api_def.h
index 1b7aa5c40eb19..757f671e75af3 100644
--- a/drivers/gpu/drm/amd/include/mes_v13_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v13_api_def.h
@@ -759,6 +759,10 @@ struct SET_SHADER_DEBUGGER {
 	uint32_t spi_gdbg_per_vmid_cntl;
 	uint32_t tcp_watch_cntl[4]; // TCP_WATCHx_CNTL
 	uint32_t trap_en;
+    uint32_t tcp_watch_addr_lo[4]; // TCP_WATCHx_ADDR_L
+    uint32_t tcp_watch_addr_hi[4]; // TCP_WATCHx_ADDR_H
+    uint32_t process_context_array_index;
+
 };
 
 struct SET_GANG_SUBMIT {
diff --git a/drivers/gpu/drm/amd/include/v13_structs.h b/drivers/gpu/drm/amd/include/v13_structs.h
index 704d96bcecf89..e552bd727d129 100644
--- a/drivers/gpu/drm/amd/include/v13_structs.h
+++ b/drivers/gpu/drm/amd/include/v13_structs.h
@@ -672,8 +672,9 @@ struct v13_sdma_mqd {
     uint32_t reserved_123; // offset: 123 (0x7B)
     uint32_t reserved_124; // offset: 124 (0x7C)
     uint32_t reserved_125; // offset: 125 (0x7D)
-    uint32_t reserved_126; // offset: 126 (0x7E)
-    uint32_t reserved_127; // offset: 127 (0x7F)
+    /* reserved_126,127: repurposed for driver-internal use */
+    uint32_t sdma_engine_id;
+    uint32_t sdma_queue_id;
 };
 
 struct v13_compute_mqd {
-- 
2.56.0

