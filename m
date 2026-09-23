Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D73C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3384E10ED51;
	Wed, 23 Sep 2026 15:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NVR0y2Bs";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9507910EBF1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xkpa2k7cCu2+sMaa7wTFKk790jWpjNU2EQ+aVfC+O/7QumOGwwdUKByeY5cLZzLBBfXHj0wMtCnlowtAuglPnocbWD3N26tmL6R1UMIDVCs60JTVq8tFIoShlcYXHBtQw5Y/D+GKVN9XLe+mVDup1L5QMS4sfiYDic4k4yxHf6v5j8A1gwHlTlwysxM+Vvpiw+klgDMIIFnH5Lg7MzkJe2i5X6ryXTWfgESItylZOZMjrB8POuWuMU6eISBVBiYeHod+blDnxmt6USF7mVh9qpgYY0S1gvzTCPc01CJ3g6s/+KcuxkNxv6dLpnFH5PFfKcVBnnGjJpBfdmUDcGajGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4+Ns4o63Cml/Dvwma1hqAAiRH0P/bda1v4mCymSeqE=;
 b=iLLeMcyV+RXZkDHRSrke6fGZjfRyNxSV26DftkZ1ikiaxwEFFAa0fE/OnKr+IDyHalv6GB9kC682yQQGzAuz8GNB/nwaTMweVJZBH1YMfp1Ev1NChVg7oGoi/HGMgUDUFLuDnvJJnVxqoccMk4Q0Xy4nyZ1CaSMLdlApptFVyyLXK33SzVHq9PdRT/LnFxB1Xvqta8jaFNzhX8hui5ZjvoZPT1oK+AXKb9dt73SlblTMOvOp/HvLsbUWB1GJdtv9EpgmqRPGE3Q+zPapnvr1AxEGp1vfOuJQ0KaCNW1x8X9CYhAd58RuG5hZVt7r8OlKubmjgHvj6FHb74p4zZ4c6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4+Ns4o63Cml/Dvwma1hqAAiRH0P/bda1v4mCymSeqE=;
 b=NVR0y2Bsad6mD/BF6YOVdYa2hAbc4enR39MStbJ2iVEiwCOJsji01XzAGn+ihAt3pLvFU3zZS+Chf2NkndH+jt7Z3AU+TOnN0+NimWCDBBCv3U3dEsb+tqi5pUTSO41HVwNzbY4fIGKbP/ix51RxxGvnFymrpE1wckNF7p6OeGg=
Received: from BL1PR13CA0265.namprd13.prod.outlook.com (2603:10b6:208:2ba::30)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 15:51:10 +0000
Received: from BN7PEPF00000092.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::22) by BL1PR13CA0265.outlook.office365.com
 (2603:10b6:208:2ba::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 15:51:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000092.mail.protection.outlook.com (10.167.245.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:51:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:51:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:51:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Caden Chien <chih-wei.chien@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/vpe: add vpe v3.0.0 support
Date: Wed, 23 Sep 2026 11:50:53 -0400
Message-ID: <20260923155056.2816021-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923155056.2816021-1-alexander.deucher@amd.com>
References: <20260923155056.2816021-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000092:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a88fe0-6f38-411e-b25a-08df198a7d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|22082099003|18002099003|3023799007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: oF08WlYpRHpAIYmL/wJv8frCeafJfHpDivENWImLaMiJaG6nQme1Oh/TV1SQjdiNFo29aBT19u3mam1LwFMGSTjUCt4um/B/iv9Jwro2X5LZ4vFNP8iyIXFQy+HK8H2Y9YFxGTDvNDeqhdKXRtbX1uY1BKTV6iqqz4+UNjtDwm6paw5iB1a0vYmTFgAA17XSvxsyph5xKU6JKFglLbcrWSg50yfQRY9rF6sdcMlrSC7VZj7M0HMaCz4G3kB3E2Nx9OzDZIZw2uHMSnJD39110/iIbSAyc9KvZZExMi2WKx6Jovu6Hr0XCAtn6bJUYkfG+R5IPwOKLFUdIZGf+i3T9UmJTUyQ+JFNQ4aPEhsnou7fTIapzxbdTTCH2P+wDzvJ9/RRp9LebhkHw+dttzUr5FzDlpVrXgixFPUN1KPw5x0YBz8fBXnzIO9TFoqmhLGEE+EWFxlUlI+ya3TZ0/zF+qoVwGm5lU9Wh2K7E/ezVwOdx1Yc2hHu4Hch+mOPDqSP8LpfFsoHPuXx4z1Y+icpBMPJSZW4r9QQWjP0lSKgcjwRV4XnSDN6gskeHTg3UDujR/XIxXAXWJdfAFwDe0dnSCXfqVZBEfLGLaDb5UB1Q/29yyit8/Bat2lFqm+Sd71BemRRpKEHeLP2NV+A54e7gaG1umFXoUqTHG3RL6LvLcQvrRmvYyU5E29qXW4tz3fwRqhCaqzw9qS+EPquOgUXtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zsp1SvKWXstOSXv8+4KVOh+gl6FQoluYc0VpKAFHsYHxxjIfcoI80jEqacmwj9Tix96kL85JMoFrjnJtxRPNxnReV6MXnHSYjBmBEj2dHdlivu+jDQ3kVPlHznQOPbLOg6zfcmap8P1oRL/NIwo1YiKfe/vZs0N3WO9CeRYATkIFE7+dtpWaU2gY780kek0Yc6N0G7ttTsGX+yKhH4ELhzgcLAKKF+iet4MvHhyEVBgCPzLMMNCWSO56A1p/QY1j+olQ/pU8gatHXVkOXn9t1OnxUxB2O5rcfXaHLlOSs0fRHjgCiNuaT29Ah2GaI8KYVKbnYRczSGrGQ4YG0zY5yi9WJX/56GU9IKYeStNQN/Ab73pCM2aOk7Up5RjIBPgJ+XhYvNqitePqvfM8GoAQkEBMJeEztK24kt2RKMxVPzK5bIX5tRSjOqKsYtqJhunj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:51:10.2952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a88fe0-6f38-411e-b25a-08df198a7d01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

From: Caden Chien <chih-wei.chien@amd.com>

This patch adds support for vpe v3.0.0 with new structs and ip functions

Signed-off-by: Caden Chien <chih-wei.chien@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |  25 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c         | 350 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.h         |  29 ++
 6 files changed, 410 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ae7d8e2c6f190..cdad1f5776845 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -239,7 +239,8 @@ amdgpu-y += \
 amdgpu-y += \
 	amdgpu_vpe.o \
 	vpe_v6_1.o \
-	vpe_v2_0.o
+	vpe_v2_0.o \
+	vpe_v3_0.o
 
 # add UMSCH block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index d43f036a3f37a..dfa6081ac89b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3347,6 +3347,9 @@ static int amdgpu_discovery_set_vpe_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(2, 2, 0):
 		amdgpu_device_ip_block_add(adev, &vpe_v2_0_ip_block);
 		break;
+	case IP_VERSION(3, 0, 0):
+		amdgpu_device_ip_block_add(adev, &vpe_v3_0_ip_block);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index bea4984a08d18..792dca283109e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -30,6 +30,7 @@
 #include "soc15_common.h"
 #include "vpe_v6_1.h"
 #include "vpe_v2_0.h"
+#include "vpe_v3_0.h"
 
 #define AMDGPU_CSA_VPE_SIZE 	64
 /* VPE CSA resides in the 4th page of CSA */
@@ -315,6 +316,9 @@ static int vpe_early_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(2, 2, 0):
 		vpe_v2_0_set_funcs(vpe);
 		break;
+	case IP_VERSION(3, 0, 0):
+		vpe_v3_0_set_funcs(vpe);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1038,6 +1042,19 @@ const struct amd_ip_funcs vpe2_ip_funcs = {
 	.set_powergating_state = vpe_set_powergating_state,
 };
 
+const struct amd_ip_funcs vpe3_ip_funcs = {
+	.name = "vpe_v3_0",
+	.early_init = vpe_early_init,
+	.sw_init = vpe_sw_init,
+	.sw_fini = vpe_sw_fini,
+	.hw_init = vpe_hw_init,
+	.hw_fini = vpe_hw_fini,
+	.suspend = vpe_suspend,
+	.resume = vpe_resume,
+	.set_clockgating_state = vpe_set_clockgating_state,
+	.set_powergating_state = vpe_set_powergating_state,
+};
+
 const struct amdgpu_ip_block_version vpe_v6_1_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_VPE,
 	.major = 6,
@@ -1053,3 +1070,11 @@ const struct amdgpu_ip_block_version vpe_v2_0_ip_block = {
 	.rev = 0,
 	.funcs = &vpe2_ip_funcs,
 };
+
+const struct amdgpu_ip_block_version vpe_v3_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_VPE,
+	.major = 3,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &vpe3_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
index 5c9a9f59a02b1..cefc198e50604 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
@@ -108,5 +108,6 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev);
 
 extern const struct amdgpu_ip_block_version vpe_v6_1_ip_block;
 extern const struct amdgpu_ip_block_version vpe_v2_0_ip_block;
+extern const struct amdgpu_ip_block_version vpe_v3_0_ip_block;
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c
new file mode 100644
index 0000000000000..4af009d469401
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c
@@ -0,0 +1,350 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#include <linux/firmware.h>
+#include "amdgpu.h"
+#include "amdgpu_ucode.h"
+#include "amdgpu_vpe.h"
+#include "vpe_v3_0.h"
+#include "soc15_common.h"
+#include "ivsrcid/vpe/irqsrcs_vpe_6_1.h"
+#include "vpe/vpe_3_0_0_offset.h"
+#include "vpe/vpe_3_0_0_sh_mask.h"
+
+MODULE_FIRMWARE("amdgpu/vpe_3_0_0.bin");
+
+#define VPE_THREAD1_UCODE_OFFSET	0x8000
+
+static uint32_t vpe_v3_0_get_reg_offset(struct amdgpu_vpe *vpe, uint32_t inst, uint32_t offset)
+{
+	uint32_t base;
+
+	base = vpe->ring.adev->reg_offset[VPE_HWIP][inst][0];
+
+	return base + offset;
+}
+
+static int vpe_v3_0_irq_init(struct amdgpu_vpe *vpe)
+{
+	struct amdgpu_device *adev = container_of(vpe, struct amdgpu_device, vpe);
+	int ret;
+
+	ret = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_VPE,
+				VPE_6_1_SRCID__VPE_TRAP,
+				&adev->vpe.trap_irq);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int vpe_v3_0_load_microcode(struct amdgpu_vpe *vpe)
+{
+	struct amdgpu_device *adev = vpe->ring.adev;
+	const struct vpe_firmware_header_v1_0 *vpe_hdr;
+	const __le32 *data;
+	uint32_t ucode_offset[2], ucode_size[2], size_dw, ret;
+	uint32_t f32_offset, f32_cntl, reg_data;
+
+	ret = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL));
+	ret = REG_SET_FIELD(ret, VPEC_CNTL, UMSCH_INT_ENABLE, 0);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL), ret);
+
+	reg_data = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL2));
+	reg_data = REG_SET_FIELD(reg_data, VPEC_CNTL2, IB_FIFO_WATERMARK, 1);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL2), reg_data);
+
+	if (amdgpu_vpe_configure_dpm(vpe))
+		dev_warn(adev->dev, "VPE DPM not enabled.\n");
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+
+		f32_offset = vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNTL);
+		f32_cntl = RREG32(f32_offset);
+		f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, HALT, 0);
+		f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH1_RESET, 0);
+
+		adev->vpe.cmdbuf_cpu_addr[0] = f32_offset;
+		adev->vpe.cmdbuf_cpu_addr[1] = f32_cntl;
+
+		return amdgpu_vpe_psp_update_sram(adev);
+	}
+
+	/* Halt and Check F32 cleaness */
+	f32_offset = vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNTL);
+	f32_cntl = RREG32(f32_offset);
+	f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, HALT, 1);
+	f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH1_RESET, 1);
+	f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH1_CHECKSUM_CLR, 1);
+	f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH0_CHECKSUM_CLR, 1);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNTL), f32_cntl);
+
+	f32_cntl = RREG32(f32_offset);
+	if (!REG_GET_FIELD(f32_cntl, VPEC_F32_CNTL, HALT)) {
+		dev_err(adev->dev, "VPEC is not halted");
+		return -EBUSY;
+	}
+
+	f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH1_CHECKSUM_CLR, 0);
+	f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH0_CHECKSUM_CLR, 0);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNTL), f32_cntl);
+
+	reg_data = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_UCODE_CHECKSUM));
+	if (reg_data) {
+		dev_err(adev->dev, "VPE FW checksum 0 not clean");
+		return -EBUSY;
+	}
+	reg_data = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_UCODE1_CHECKSUM));
+	if (reg_data) {
+		dev_err(adev->dev, "VPE FW checksum 1 not clean");
+		return -EBUSY;
+	}
+
+	reg_data = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_STATUS2));
+	if (REG_GET_FIELD(reg_data, VPEC_STATUS2, TH0F32_INSTR_PTR)) {
+		dev_err(adev->dev, "VPE FW initial status not clean");
+		return -EBUSY;
+	}
+
+	reg_data = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_STATUS6));
+	if (REG_GET_FIELD(reg_data, VPEC_STATUS6, TH1F32_INSTR_PTR)) {
+		dev_err(adev->dev, "VPE FW initial status not clean");
+		return -EBUSY;
+	}
+	/* end of F32 cleaness check */
+
+	vpe_hdr = (const struct vpe_firmware_header_v1_0 *)adev->vpe.fw->data;
+
+	/* Thread 0(command thread) ucode offset/size */
+	ucode_offset[0] = le32_to_cpu(vpe_hdr->header.ucode_array_offset_bytes);
+	ucode_size[0] = le32_to_cpu(vpe_hdr->ctx_ucode_size_bytes);
+	/* Thread 1(control thread) ucode offset/size */
+	ucode_offset[1] = le32_to_cpu(vpe_hdr->ctl_ucode_offset);
+	ucode_size[1] = le32_to_cpu(vpe_hdr->ctl_ucode_size_bytes);
+
+	reg_data = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_PG_CNTL));
+	reg_data = REG_SET_FIELD(reg_data, VPEC_PG_CNTL, PG_EN, 0);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_PG_CNTL), reg_data);
+
+	for (int j = 0; j < vpe->num_instances; j++) {
+		for (int i = 0; i < 2; i++) {
+			if (i > 0)
+				WREG32(vpe_get_reg_offset(vpe, j, regVPEC_UCODE_ADDR), VPE_THREAD1_UCODE_OFFSET);
+			else
+				WREG32(vpe_get_reg_offset(vpe, j, regVPEC_UCODE_ADDR), 0);
+
+			data = (const __le32 *)(adev->vpe.fw->data + ucode_offset[i]);
+			size_dw = ucode_size[i] / sizeof(__le32);
+
+			while (size_dw--) {
+				if (amdgpu_emu_mode && size_dw % 500 == 0)
+					msleep(1);
+				WREG32(vpe_get_reg_offset(vpe, j, regVPEC_UCODE_DATA), le32_to_cpup(data++));
+			}
+		}
+	}
+
+	reg_data = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_PG_CNTL));
+	reg_data = REG_SET_FIELD(reg_data, VPEC_PG_CNTL, PG_EN, 1);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_PG_CNTL), reg_data);
+
+	/* Unhalt F32 */
+	f32_cntl = RREG32(f32_offset);
+	f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, HALT, 0);
+	f32_cntl = REG_SET_FIELD(f32_cntl, VPEC_F32_CNTL, TH1_RESET, 0);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_F32_CNTL), f32_cntl);
+
+	return 0;
+}
+
+static int vpe_v3_0_ring_start(struct amdgpu_vpe *vpe)
+{
+	struct amdgpu_ring *ring = &vpe->ring;
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t doorbell, doorbell_offset;
+	uint32_t rb_bufsz, rb_cntl;
+	uint32_t ib_cntl, i;
+	int ret;
+
+	for (i = 0; i < vpe->num_instances; i++) {
+		/* Set ring buffer size in dwords */
+		rb_bufsz = order_base_2(ring->ring_size / 4);
+		rb_cntl = RREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_CNTL));
+		rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_SIZE, rb_bufsz);
+		rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_PRIV, 1);
+		rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_VMID, 0);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_CNTL), rb_cntl);
+
+		/* Initialize the ring buffer's read and write pointers */
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_RPTR), 0);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_RPTR_HI), 0);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_WPTR), 0);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_WPTR_HI), 0);
+
+		/* set the wb address whether it's enabled or not */
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_RPTR_ADDR_LO),
+			lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_RPTR_ADDR_HI),
+			upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
+
+		rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
+
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
+
+		ring->wptr = 0;
+
+		/* before programing wptr to a less value, need set minor_ptr_update first */
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_MINOR_PTR_UPDATE), 1);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
+		/* set minor_ptr_update to 0 after wptr programed */
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_MINOR_PTR_UPDATE), 0);
+
+		doorbell_offset = RREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_DOORBELL_OFFSET));
+		doorbell_offset = REG_SET_FIELD(doorbell_offset, VPEC_QUEUE0_DOORBELL_OFFSET, OFFSET, ring->doorbell_index + i*4);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
+
+		doorbell = RREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_DOORBELL));
+		doorbell = REG_SET_FIELD(doorbell, VPEC_QUEUE0_DOORBELL, ENABLE, ring->use_doorbell ? 1 : 0);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_DOORBELL), doorbell);
+
+		adev->nbio.funcs->vpe_doorbell_range(adev, i, ring->use_doorbell, ring->doorbell_index + i*4, 4);
+
+		rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
+		rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_ENABLE, 1);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_RB_CNTL), rb_cntl);
+
+		ib_cntl = RREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_IB_CNTL));
+		ib_cntl = REG_SET_FIELD(ib_cntl, VPEC_QUEUE0_IB_CNTL, IB_ENABLE, 1);
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE0_IB_CNTL), ib_cntl);
+	}
+
+	ret = amdgpu_ring_test_helper(ring);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int vpe_v3_0_ring_stop(struct amdgpu_vpe *vpe)
+{
+	struct amdgpu_device *adev = vpe->ring.adev;
+	uint32_t queue_reset, i;
+	int ret;
+
+	for (i = 0; i < vpe->num_instances; i++) {
+		queue_reset = RREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE_RESET_REQ));
+
+		queue_reset = REG_SET_FIELD(queue_reset, VPEC_QUEUE_RESET_REQ, QUEUE0_RESET, 1);
+
+		WREG32(vpe_get_reg_offset(vpe, i, regVPEC_QUEUE_RESET_REQ), queue_reset);
+		/* timeout length is adev->timeout_usec */
+		ret = SOC15_WAIT_ON_RREG(VPE, i, regVPEC_QUEUE_RESET_REQ, 0,
+					 VPEC_QUEUE_RESET_REQ__QUEUE0_RESET_MASK);
+
+		if (ret)
+			dev_err(adev->dev, "VPE queue reset failed\n");
+	}
+
+	vpe->ring.sched.ready = false;
+
+	return ret;
+}
+
+static int vpe_v3_0_set_trap_irq_state(struct amdgpu_device *adev,
+				       struct amdgpu_irq_src *source,
+				       unsigned int type,
+				       enum amdgpu_interrupt_state state)
+{
+	struct amdgpu_vpe *vpe = &adev->vpe;
+	uint32_t vpe_cntl;
+
+	vpe_cntl = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL));
+	vpe_cntl = REG_SET_FIELD(vpe_cntl, VPEC_CNTL, TRAP_ENABLE,
+				 state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_CNTL), vpe_cntl);
+
+	return 0;
+}
+
+static int vpe_v3_0_process_trap_irq(struct amdgpu_device *adev,
+				     struct amdgpu_irq_src *source,
+				     struct amdgpu_iv_entry *entry)
+{
+
+	DRM_DEBUG("IH: VPE trap\n");
+
+	switch (entry->client_id) {
+	case SOC21_IH_CLIENTID_VPE:
+		amdgpu_fence_process(&adev->vpe.ring);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int vpe_v3_0_set_regs(struct amdgpu_vpe *vpe)
+{
+	vpe->regs.queue0_rb_rptr_lo = regVPEC_QUEUE0_RB_RPTR;
+	vpe->regs.queue0_rb_rptr_hi = regVPEC_QUEUE0_RB_RPTR_HI;
+	vpe->regs.queue0_rb_wptr_lo = regVPEC_QUEUE0_RB_WPTR;
+	vpe->regs.queue0_rb_wptr_hi = regVPEC_QUEUE0_RB_WPTR_HI;
+	vpe->regs.queue0_preempt = regVPEC_QUEUE0_PREEMPT;
+	vpe->regs.dpm_enable = regVPEC_PUB_DUMMY2;
+
+	vpe->regs.dpm_pratio = regVPEC_QUEUE6_DUMMY4;
+	vpe->regs.dpm_request_interval = regVPEC_QUEUE5_DUMMY3;
+	vpe->regs.dpm_decision_threshold = regVPEC_QUEUE5_DUMMY4;
+	vpe->regs.dpm_busy_clamp_threshold = regVPEC_QUEUE7_DUMMY2;
+	vpe->regs.dpm_idle_clamp_threshold = regVPEC_QUEUE7_DUMMY3;
+	vpe->regs.dpm_request_lv = regVPEC_QUEUE7_DUMMY1;
+	vpe->regs.context_indicator = regVPEC_QUEUE6_DUMMY3;
+
+	return 0;
+}
+
+static struct vpe_funcs vpe_v3_0_funcs = {
+	.get_reg_offset = vpe_v3_0_get_reg_offset,
+	.set_regs = vpe_v3_0_set_regs,
+	.irq_init = vpe_v3_0_irq_init,
+	.init_microcode = amdgpu_vpe_init_microcode,
+	.load_microcode = vpe_v3_0_load_microcode,
+	.ring_init = amdgpu_vpe_ring_init,
+	.ring_start = vpe_v3_0_ring_start,
+	.ring_stop = vpe_v3_0_ring_stop,
+	.ring_fini = amdgpu_vpe_ring_fini,
+};
+
+static const struct amdgpu_irq_src_funcs vpe_v3_0_trap_irq_funcs = {
+	.set = vpe_v3_0_set_trap_irq_state,
+	.process = vpe_v3_0_process_trap_irq,
+};
+
+void vpe_v3_0_set_funcs(struct amdgpu_vpe *vpe)
+{
+	vpe->funcs = &vpe_v3_0_funcs;
+	vpe->trap_irq.funcs = &vpe_v3_0_trap_irq_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.h b/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.h
new file mode 100644
index 0000000000000..5ab67bac33dbd
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#ifndef __VPE_V3_0_H__
+#define __VPE_V3_0_H__
+
+#include "amdgpu_vpe.h"
+
+void vpe_v3_0_set_funcs(struct amdgpu_vpe *vpe);
+
+#endif
-- 
2.55.0

