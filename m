Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441E1606A31C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5UnOlvI6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8495D10E5C3;
	Mon,  9 Nov 2026 18:47:01 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33ECA10E181
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 18:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbqV1ezNwbcpUtb3WxeiMXZeFWfURbZH6sEI1U/wA5iDBphmhsbbJz1Dsaiqj+dlToMglO/G/qElekQnkNykVwGvJYZSMo9pF3PxAKMZOWqEZ/NaR80xhj+kofV9kJJ8MinPnzIo5U9Q858P3S88nfN0WQoWeTauoc+6Rsaf1mGhF+RUgh08E7Imk6DBWs/KOzcYelz026gQ0iSZnw1mihlAj9fjNCc3BbIXJgFXY49cqCgdxtF3vyj35QiyrfNSb0hwVQeoxwrdMYMrfznCkpMnZXhG71AfoyGL23sYE07SuJ8mDqfZwuXrY9QSBpkuBAkoXedqhVN+Qffn7MiErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87xDQdnpxle6hfYaJa/BwEAEVJ2tssIcd8RUygAECxw=;
 b=ivAc7SndeppZTHXXki8mftoUKoegLYR57wNf+nQtXQUuDXDFEqivG4f51Y+Imj9A8oqviPYuPwWaI15M5sTgi5VwdKB7/bS7BtYZ4AolZUmdGf3X738LjvOAJJZdnL3mBRwR9s0Vkvw7eg5EJDDy4Qs/yzDjvEifcqIzmfBx0f7N9RYWoHM4m0KQEYDgZG8ThAzvmDMXU6WZsEy6YsDFiCnV9N6QbkJmYzmvI3MXCZxBj4QLqNh/m23JupaQru9oPYbfAGNtTNvd3FHu1n2xK/RcKVuDHiCMURg1bC2PU/Zn07Cjw1RMOX/PHGRRZAINi2K0hAfIHB1Z1/wRAjCEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87xDQdnpxle6hfYaJa/BwEAEVJ2tssIcd8RUygAECxw=;
 b=5UnOlvI6X9IuIze7nMciQv1BFRvKitUTP3hmGvwaaMiCut9dLob6rEJsvft5RtHTGcRv0LzigIgYcwmdXH1PWav+8TCCJEXPNTtGGmPuaMzk6mcV5a0fZigkBON5MGyduTa1yrWc0hvoVyNUdVdTsEtXqddQgNAF6jszRrT5bls=
Received: from SJ0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:a03:33e::15)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 18:46:49 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::46) by SJ0PR03CA0040.outlook.office365.com
 (2603:10b6:a03:33e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Mon, 9
 Nov 2026 18:46:49 +0000
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
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 18:46:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 12:46:48 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 12:46:48 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Frank Min <Frank.Min@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: Add imu v13 ip block v2
Date: Mon, 9 Nov 2026 13:46:33 -0500
Message-ID: <20261109184641.3656885-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109184641.3656885-1-alexander.deucher@amd.com>
References: <20261109184641.3656885-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|CH3PR12MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad0e360-a1e9-4a89-7b7d-08df3e91d01b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|11063799006|56012099006|261021123027099003|261022075727099003|261021121427099003|261022113327099003|261022105027099003|261022115727099003|261009223027099003|261028144727099003|261026140227099003|261026121527099003|261102123227099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 8uHzbu/Q+yFpgfiYEzD+9aYbjUkXmlrzakCBMK6XKaKgqS37pBhb+6ThLDJn/hBi4psMBHCIwMldD9VyLRvXmUCzPOBqqJ9qrBfrEmiUUI6BAiQ3y/6IgG5C+4VXeJsAb5LCVSdLjqsc0F0rqwb5MRTicBrVkAKEip2LW50CgBfroRHRbzWtr8UBNUasfOVcYXeevsSudHMk0YI5cbOZ/eWim4m4vuGqjILYew08nX2y1eHZ3XuJ4f8afPtMdtWbnivpY/vUap+4OklcrEabjWyzN+JJllDiTgnUaWfZ7u5zNfx7yiPjFqgQJZ2oi/e60CaVg/JrAjy+GAdyNtb7/N0PMjlYBIYBe+NTixnOsY0y5vCfSxc9pvlWR0bKmxbFMChpUZFApXwsV2X5astTftdoEXrwxJ86dhIyslm1ePR4I7H5B0mAfSPd1xZMZje4Vwy5/+yIFQ6BcHEaxYZbSlfATzYgGN44p1lCpIheO3telwCXHKAW9ncT6noDLzGarBld8s/tE2bLs8qbwahb7Ka2K8jeH0k6wocmMRi2FxNPE15VK5k6CWEK/NtpPYNmgfnTR/FYKYdApBl2yvXNz1tSs1iYaqTL3snk2Qaac+pf9dTNYgEDzTalcSAzoSb3AKHuS3uorofdaohqnLMQN3/FB5XM6puvJ7o2IttteqSoPa4dm5h8uzplGIzMEXvqaBFsy4ZS71JyhHBwCiaBuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(11063799006)(56012099006)(261021123027099003)(261022075727099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022115727099003)(261009223027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4Z57+3T/oE36EvgzRJm/D2gZZUBZaesBFref6LbVXUPgZJHb2J4HFCpsSVQQ6jgqDgFmduJOfigg7z0A3ohkqKzLAIrVyCLBE/I3F9nYia2Tb7LXUxs2f4B2MXXbf4AjGCoGWxigofI0/YsLscsGkcZQE6MOUiTKOhCcnruSNedz61+7DTEGWgwKJMp7GnnAzNWWic4oeqFms8jSN/VEFTKXt0H6i2mw+TRIM2avUeNb8/SOgy2hUDr62z1DzfMbJNWA7Gmv2pfviV11dVtBnSocm7GEnVLtRkc9ptaxI5RV4lPiVhbYaxtYtl5jwpIavBCiFQWXcrptsC+T9O6D5BVj6KLnM7pAKLfsjFLNc1RGfCM0cJskR/WT5l+E5HzVPukM+YTlv5PzaFWpb+idUVu7I2JE3Y9ZZaf7lukENj/NEnwh1YukiXCku07dV5r5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:46:49.1222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad0e360-a1e9-4a89-7b7d-08df3e91d01b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Min <Frank.Min@amd.com>

Add imu v13 ip block.
V2: clean up code.

Signed-off-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |   3 +-
 drivers/gpu/drm/amd/amdgpu/imu_v13_0.c | 288 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/imu_v13_0.h |  29 +++
 3 files changed, 319 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v13_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 2f708710e020a..92236baf43498 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -170,7 +170,8 @@ amdgpu-y += \
 	gfx_v12_0.o \
 	gfx_v12_1.o \
 	imu_v12_0.o \
-	imu_v12_1.o
+	imu_v12_1.o \
+	imu_v13_0.o
 
 # add async DMA block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v13_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v13_0.c
new file mode 100644
index 0000000000000..aea418be444a0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v13_0.c
@@ -0,0 +1,288 @@
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
+#include <linux/firmware.h>
+#include "amdgpu.h"
+#include "amdgpu_imu.h"
+#include "amdgpu_dpm.h"
+
+#include "imu_v13_0.h"
+
+#include "gc/gc_13_0_1_offset.h"
+#include "gc/gc_13_0_1_sh_mask.h"
+#include "mmhub/mmhub_5_0_1_offset.h"
+
+MODULE_FIRMWARE("amdgpu/gc_13_0_1_imu.bin");
+
+#define TRANSFER_RAM_MASK	0x001c0000
+
+static int imu_v13_0_init_microcode(struct amdgpu_device *adev)
+{
+	char ucode_prefix[15];
+	int err;
+	const struct imu_firmware_header_v1_0 *imu_hdr;
+	struct amdgpu_firmware_info *info = NULL;
+
+	DRM_DEBUG("\n");
+
+	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
+	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_imu.bin", ucode_prefix);
+	if (err)
+		goto out;
+
+	imu_hdr = (const struct imu_firmware_header_v1_0 *)adev->gfx.imu_fw->data;
+	adev->gfx.imu_fw_version = le32_to_cpu(imu_hdr->header.ucode_version);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_I];
+		info->ucode_id = AMDGPU_UCODE_ID_IMU_I;
+		info->fw = adev->gfx.imu_fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(imu_hdr->imu_iram_ucode_size_bytes), PAGE_SIZE);
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_D];
+		info->ucode_id = AMDGPU_UCODE_ID_IMU_D;
+		info->fw = adev->gfx.imu_fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(imu_hdr->imu_dram_ucode_size_bytes), PAGE_SIZE);
+	}
+
+out:
+	if (err) {
+		dev_err(adev->dev,
+			"gfx13: Failed to load firmware \"%s_imu.bin\"\n",
+			ucode_prefix);
+		amdgpu_ucode_release(&adev->gfx.imu_fw);
+	}
+
+	return err;
+}
+
+static int imu_v13_0_load_microcode(struct amdgpu_device *adev)
+{
+	const struct imu_firmware_header_v1_0 *hdr;
+	const __le32 *fw_data;
+	unsigned i, fw_size;
+
+	if (!adev->gfx.imu_fw)
+		return -EINVAL;
+
+	hdr = (const struct imu_firmware_header_v1_0 *)adev->gfx.imu_fw->data;
+
+	fw_data = (const __le32 *)(adev->gfx.imu_fw->data +
+			le32_to_cpu(hdr->header.ucode_array_offset_bytes));
+	fw_size = le32_to_cpu(hdr->imu_iram_ucode_size_bytes) / 4;
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_I_RAM_ADDR, 0);
+
+	for (i = 0; i < fw_size; i++)
+		WREG32_SOC15(GC, 0, regGFX_IMU_I_RAM_DATA, le32_to_cpup(fw_data++));
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_I_RAM_ADDR, adev->gfx.imu_fw_version);
+
+	fw_data = (const __le32 *)(adev->gfx.imu_fw->data +
+			le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
+			le32_to_cpu(hdr->imu_iram_ucode_size_bytes));
+	fw_size = le32_to_cpu(hdr->imu_dram_ucode_size_bytes) / 4;
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_D_RAM_ADDR, 0);
+
+	for (i = 0; i < fw_size; i++)
+		WREG32_SOC15(GC, 0, regGFX_IMU_D_RAM_DATA, le32_to_cpup(fw_data++));
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_D_RAM_ADDR, adev->gfx.imu_fw_version);
+
+	return 0;
+}
+
+static int imu_v13_0_wait_for_reset_status(struct amdgpu_device *adev)
+{
+	u32 imu_reg_val = 0;
+	int i;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_GFX_RESET_CTRL);
+		if ((imu_reg_val & 0x1f) == 0x1f)
+			break;
+		udelay(1);
+	}
+
+	if (i >= adev->usec_timeout) {
+		dev_err(adev->dev, "init imu: IMU start timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void imu_v13_0_setup(struct amdgpu_device *adev)
+{
+	u32 imu_reg_val;
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL0, 0xffffff);
+	WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_ACCESS_CTRL1, 0xffff);
+
+	if (adev->gfx.imu.mode == DEBUG_MODE) {
+		imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16);
+		imu_reg_val |= 0x1;
+		WREG32_SOC15(GC, 0, regGFX_IMU_C2PMSG_16, imu_reg_val);
+
+		imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_SCRATCH_10);
+		imu_reg_val |= 0x10007;
+		WREG32_SOC15(GC, 0, regGFX_IMU_SCRATCH_10, imu_reg_val);
+
+	}
+}
+
+static int imu_v13_0_start(struct amdgpu_device *adev)
+{
+	u32 imu_reg_val;
+
+	imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL);
+	imu_reg_val &= 0xfffffffe;
+	WREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL, imu_reg_val);
+
+	if (adev->flags & AMD_IS_APU)
+		amdgpu_dpm_set_gfx_power_up_by_imu(adev);
+
+	return imu_v13_0_wait_for_reset_status(adev);
+}
+
+static u32 imu_v13_0_grbm_gfx_index_remap(struct amdgpu_device *adev,
+					  u32 data, bool high)
+{
+	u32 val, inst_index;
+
+	inst_index = REG_GET_FIELD(data, GRBM_GFX_INDEX, INSTANCE_INDEX);
+
+	if (high)
+		val = inst_index >> 5;
+	else
+		val = REG_GET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES) << 18 |
+		      REG_GET_FIELD(data, GRBM_GFX_INDEX, SA_BROADCAST_WRITES) << 19 |
+		      REG_GET_FIELD(data, GRBM_GFX_INDEX, INSTANCE_BROADCAST_WRITES) << 20 |
+		      REG_GET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX) << 21 |
+		      REG_GET_FIELD(data, GRBM_GFX_INDEX, SA_INDEX) << 25 |
+		      (inst_index & 0x1f);
+
+	return val;
+}
+
+static u32 imu_v13_init_gfxhub_settings(struct amdgpu_device *adev,
+					u32 reg, u32 data)
+{
+	if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_FB_LOCATION_BASE))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_FB_LOCATION_BASE);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_FB_LOCATION_TOP))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_FB_LOCATION_TOP);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_FB_OFFSET))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_FB_OFFSET);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_AGP_BASE))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_AGP_BOT))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_AGP_TOP))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_MX_L1_TLB_CNTL))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_MX_L1_TLB_CNTL);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_LOCAL_FB_ADDRESS_START))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_LOCAL_FB_ADDRESS_START);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_LOCAL_FB_ADDRESS_END))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_LOCAL_FB_ADDRESS_END);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_LOCAL_SYSMEM_ADDRESS_START))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_LOCAL_SYSMEM_ADDRESS_START);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_LOCAL_SYSMEM_ADDRESS_END))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_LOCAL_SYSMEM_ADDRESS_END);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB);
+	else if (reg == SOC15_REG_OFFSET(GC, 0, regGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB))
+		return RREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB);
+	else
+		return data;
+}
+
+static void program_imu_rlc_ram(struct amdgpu_device *adev,
+				const u32 *regs,
+				const u32 array_size)
+{
+	u32 reg, data, val_h = 0, val_l = TRANSFER_RAM_MASK;
+	int i;
+
+	if (array_size % 3)
+		return;
+
+	for (i = 0; i < array_size; i += 3) {
+		reg = regs[i + 0];
+		data = regs[i + 2];
+		data = imu_v13_init_gfxhub_settings(adev, reg, data);
+		if (reg == SOC15_REG_OFFSET(GC, 0, regGRBM_GFX_INDEX)) {
+			val_l = imu_v13_0_grbm_gfx_index_remap(adev, data, false);
+			val_h = imu_v13_0_grbm_gfx_index_remap(adev, data, true);
+		} else {
+			WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_HIGH, val_h);
+			WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_LOW, reg | val_l);
+			WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_DATA, data);
+		}
+	}
+}
+
+static void imu_v13_0_program_rlc_ram(struct amdgpu_device *adev)
+{
+	u32 reg_data, size = 0;
+	const u32 *data;
+	int r = -EINVAL;
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, 0x2);
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(13, 0, 1):
+		if (!r)
+			program_imu_rlc_ram(adev, data, (const u32)size);
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	//Indicate the latest entry
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_HIGH, 0);
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_LOW, 0);
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_DATA, 0);
+
+	reg_data = RREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX);
+	reg_data |= GFX_IMU_RLC_RAM_INDEX__RAM_VALID_MASK;
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, reg_data);
+}
+
+const struct amdgpu_imu_funcs gfx_v13_0_imu_funcs = {
+	.init_microcode = imu_v13_0_init_microcode,
+	.load_microcode = imu_v13_0_load_microcode,
+	.setup_imu = imu_v13_0_setup,
+	.start_imu = imu_v13_0_start,
+	.program_rlc_ram = imu_v13_0_program_rlc_ram,
+	.wait_for_reset_status = imu_v13_0_wait_for_reset_status,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v13_0.h b/drivers/gpu/drm/amd/amdgpu/imu_v13_0.h
new file mode 100644
index 0000000000000..83f041d8cd34d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v13_0.h
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
+ *
+ */
+
+#ifndef __IMU_V13_0_H__
+#define __IMU_V13_0_H__
+
+extern const struct amdgpu_imu_funcs gfx_v13_0_imu_funcs;
+
+#endif
-- 
2.56.0

