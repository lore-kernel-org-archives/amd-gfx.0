Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980D5C55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 08:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E2C810ED8A;
	Wed,  5 Aug 2026 08:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QIRrsj2O";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0AB710ED87
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 08:42:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMRoKdm0c5qSiSzsGSLaPlzhfYF0QD2tIm3S7tPOIyV5ruEOcgeXYaeZWVmAIQkVl39zZKvmZcLK36Fn4JGKdUlk4JJRCUaKfF7kbUl8Sdd6tvu6on7hVFDc2s7LAqEfuZWM+iSjgYZdqF2ndWzUAAMIbAbpd/oD8iXPSedA03+/yYyoC73rd9guIPvyu5vgg4S7fwGChIo86e3pUwqXKJmP51p/g7M36b87xnHvS5vLsCH3H3VQWpbx8fj/2xo+xsv6EyD6vgHqYESHPWCz4OlPV+3u3DLnbw4LMPf5eNH+4Ke4/cvy0vkbUiY4AY/bjsFcmD/th9TV7hFl2cq0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVLy9ZBg3tEqxZs9wNE4+Cw1LpG5UnISwPK7Cyb8ptw=;
 b=DwZnxTDmvDa6ef1/3q0+xDEkX7qI18MCDJyWCSaSATUIfwNVvZdjCC7ZJZ1vBhrVZ3dY/rcztX64wQ9SL/6YlcS92Ou8eS4iKEMUrVBiTuWrbWJ7Tg71+eNINnnRt0l6Ds66TpK+YmwIa8EHwhrM4U85bOmtbgvyOEmknlxC/YM/eWmrrmWUuRqwxxifeIiJdt/2pbjpmtBW0VBvjpuEW8G8BOod2faKy16QGiOwYhO7YB5R4R0cLBtullkooHD1COecusbkhz52DPHI0vKE+jgosmtTj7UrsqkzWwH2+QRu1iKvXuqCrvtAHragmAU9XXrouZJoQd4fpg9fUI9Z2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVLy9ZBg3tEqxZs9wNE4+Cw1LpG5UnISwPK7Cyb8ptw=;
 b=QIRrsj2O2rTH82TvSxNn1twQPAtgt3FxUYzGjhODtdZNK9CsftVCt7X0SXrxoyjfw6SR6Wl0ohLL6Yoy9tMPN05tL3c4oGg+Iq9yGnsrWhygS1I2k4PyPgN7cXhyMg34s50RfdrNPpVEE5bfKYZ3FqUr0ucCW7umiGUmqeVzJOc=
Received: from MN2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:208:23c::27)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 08:42:04 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::4e) by MN2PR18CA0022.outlook.office365.com
 (2603:10b6:208:23c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Wed, 5
 Aug 2026 08:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 08:42:04 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 5 Aug 2026 03:42:02 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Shubhankar.MilindSardeshpande@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add NBIO 7.11.5 support
Date: Wed, 5 Aug 2026 14:08:27 +0530
Message-ID: <20260805084114.1767743-2-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805084114.1767743-1-Shubhankar.MilindSardeshpande@amd.com>
References: <20260805084114.1767743-1-Shubhankar.MilindSardeshpande@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b93dae-1e4f-46aa-21a9-08def2cd6cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: t1SdDh5NroyXG7X6vpyiZOTW5mLIby/ECvxu8DD169PMLHTiDHC8XAS9NF1TCE+XhyGPlK9QlQLUEwX3M0A87RknrAUhwLSXPGl7G/zz4AyYU9GOC4IYz51tq5mQupLjEhhHXxXyfp9yY1lSsdV2oecbbpFRIgTO6Re1D0w1m94u6Xv7yLXKoo3qx5E6bl9mcuHEGKm9JbjLGUZo7RTqRn+OUeSobjYEPY3U/bQ1MbVEt+GHsY59ZRrzE4HSYp/hlUoK9jRqT6dkmszTxEVmdAfXk9kZjpXP8sueYq4M0PHmv5H3bEBDPFNvFWo0KIcE6OIyK++ujftF66znSQwNnNdGllyu1Ois54ePNcQa81i6P0RYXJyMhtCXA3+d+CO1LCfvdZVDXuoiBjCZaFO/WmPPVNGnopGUuDBtPhyi7eVBoVlMWxjVAT7xzOhUot8gSqjn792mgZuMQF1BwBQVJkeF+SSo2waCgAYPn6joUh/jXeFy7fZ+hK62skTCkGRKDHZu/ceNXJXP5tIHVdBaCWoTCcXK/8n4f7Tdd/9xg4DTZnu5yGmPjE9mJ1zLOYFneYQS5wA35gCCUR5wzi1ZBH7HfUBgD8df573cY6ADOMwZZ7qbde7yPvvhDVL1phJ8I5thgoUf/f31tjZXYrCy/FZsWqWj1CXcwPD55Tg516N5VcrUmSw6N2Gm5PuBo+2WgBrVZvha/1PbhMl6ssAc+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q947yPBTf5pyzXgOfToTF1WZku7gcjii7cS4oyofwAOwl4cT2gk67CDxmAYqGBjPkTosnax/YRe3wNJ8Iy2dLpWM8nuSjd3M16wnQDifzb9EM9yeeMZcoeMlYfVylrOQsWnDqnWDM35jGMTvlcqXETjja/ylSGbTkU6jEaaL9xoTRsGxst9wQaLhn7I52HDsoyo0S3n2+A2ALAQMkdL6i9kzwYsy1wmKqWl/16j4/Af4x7ioDdPMWf1r2UH+4nKMtkQlTndp9tx/l7nGqZFAVfYI+66C6Jqmh2ygywt4zWVZ3q9lLyHqdgVw8CyytF1zyDwM1fqQNRLOI64KIMXs4pSXGs88amoX3jEyxjR6gK9EuQ78iYIXGDHZOdr5/cKRDG/3kR8O2O3ypftehR1Ry60KrMiK3BmG0LzLImhhyyzNljqYMOS/N6axVEQ2fHBB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 08:42:04.3361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b93dae-1e4f-46aa-21a9-08def2cd6cfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
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

Add a new NBIO IP block driver for NBIO 7.11.5 and wire it into the
IP discovery table so that the correct nbio and hdp flush register
callbacks are selected for IP_VERSION(7, 11, 5).

Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   5 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c     | 344 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.h     |  32 ++
 4 files changed, 382 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 105b9dcc19a2..ffb725fb1084 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -91,7 +91,7 @@ amdgpu-y += \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o soc24.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
 	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o \
-	cyan_skillfish_reg_init.o soc_v1_0.o lsdma_v7_1.o nbio_v6_3_2.o
+	cyan_skillfish_reg_init.o soc_v1_0.o lsdma_v7_1.o nbio_v6_3_2.o nbio_v7_11_5.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b5a25ca2e901..b5bc0d71653d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -44,6 +44,7 @@
 #include "nbio_v7_4.h"
 #include "nbio_v7_9.h"
 #include "nbio_v7_11.h"
+#include "nbio_v7_11_5.h"
 #include "hdp_v4_0.h"
 #include "vega10_ih.h"
 #include "vega20_ih.h"
@@ -3491,6 +3492,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbif_v6_3_1_funcs;
 		adev->nbio.hdp_flush_reg = &nbif_v6_3_1_hdp_flush_reg;
 		break;
+	case IP_VERSION(7, 11, 5):
+		adev->nbio.funcs = &nbio_v7_11_5_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v7_11_5_hdp_flush_reg;
+		break;
 	case IP_VERSION(6, 3, 2):
 		adev->nbio.funcs = &nbio_v6_3_2_funcs;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
new file mode 100644
index 000000000000..9bb998a47ef6
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
@@ -0,0 +1,344 @@
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
+#include "amdgpu.h"
+#include "nbio_v7_11_5.h"
+
+#include "nbio/nbio_7_11_5_offset.h"
+#include "nbio/nbio_7_11_5_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void nbio_v7_11_5_remap_hdp_registers(struct amdgpu_device *adev)
+{
+		WREG32_SOC15(NBIO, 0, regBIF_BX1_REMAP_HDP_MEM_FLUSH_CNTL,
+			adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+		WREG32_SOC15(NBIO, 0, regBIF_BX1_REMAP_HDP_REG_FLUSH_CNTL,
+			adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+}
+
+static u32 nbio_v7_11_5_get_rev_id(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP1_RCC_DEV0_EPF0_STRAP0);
+
+	tmp &= RCC_STRAP1_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
+	tmp >>= RCC_STRAP1_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
+
+	return tmp;
+}
+
+static void nbio_v7_11_5_mc_access_enable(struct amdgpu_device *adev, bool enable)
+{
+	if (enable)
+		WREG32_SOC15(NBIO, 0, regBIF_BX1_BIF_FB_EN,
+			BIF_BX1_BIF_FB_EN__FB_READ_EN_MASK |
+			BIF_BX1_BIF_FB_EN__FB_WRITE_EN_MASK);
+	else
+		WREG32_SOC15(NBIO, 0, regBIF_BX1_BIF_FB_EN, 0);
+}
+
+static u32 nbio_v7_11_5_get_memsize(struct amdgpu_device *adev)
+{
+	u32 memsize;
+
+	memsize = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_0_RCC_CONFIG_MEMSIZE);
+
+	return memsize;
+}
+
+static void nbio_v7_11_5_sdma_doorbell_range(struct amdgpu_device *adev,
+					    int instance, bool use_doorbell,
+					    int doorbell_index,
+					    int doorbell_size)
+{
+	u32 doorbell_range;
+
+	if (instance == 0) {
+		doorbell_range = RREG32_SOC15(NBIO, 0,
+					     regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL);
+
+		if (use_doorbell) {
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_ENABLE,
+						       0x1);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_AWID,
+						       0xe);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_RANGE_OFFSET,
+						       doorbell_index);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_RANGE_SIZE,
+						       doorbell_size);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_AWADDR_31_28_VALUE,
+						       0x3);
+		} else {
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_RANGE_SIZE,
+						       0);
+		}
+
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL, doorbell_range);
+	}
+}
+
+static void nbio_v7_11_5_vpe_doorbell_range(struct amdgpu_device *adev,
+							int instance, bool use_doorbell,
+							int doorbell_index,
+							int doorbell_size)
+{
+	u32 doorbell_range;
+
+	if (instance)
+		return;
+
+	doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL);
+
+	if (use_doorbell) {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_ENABLE,
+					       0x1);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_AWID,
+					       0xf);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_RANGE_OFFSET,
+					       doorbell_index);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_RANGE_SIZE,
+					       doorbell_size);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_AWADDR_31_28_VALUE,
+					       0xf);
+	} else {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL,
+					       S2A_DOORBELL_PORT5_RANGE_SIZE,
+					       0);
+	}
+
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
+}
+
+static void nbio_v7_11_5_gc_doorbell_init(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL, 0x30000007);
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL, 0x3000000d);
+}
+
+static void nbio_v7_11_5_enable_doorbell_aperture(struct amdgpu_device *adev,
+						bool enable)
+{
+	WREG32_FIELD15_PREREG(NBIO, 0, RCC_DEV0_EPF0_0_RCC_DOORBELL_APER_EN,
+			BIF_DOORBELL_APER_EN, enable ? 1 : 0);
+}
+
+static void nbio_v7_11_5_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
+							 bool enable)
+{
+	u32 tmp = 0;
+
+	if (enable) {
+		tmp = REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				    DOORBELL_SELFRING_GPA_APER_EN, 1) |
+		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				    DOORBELL_SELFRING_GPA_APER_MODE, 1) |
+		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				    DOORBELL_SELFRING_GPA_APER_SIZE, 0);
+
+		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
+			     lower_32_bits(adev->doorbell.base));
+		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
+			     upper_32_bits(adev->doorbell.base));
+	}
+
+	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL, tmp);
+}
+
+static void nbio_v7_11_5_ih_doorbell_range(struct amdgpu_device *adev,
+					 bool use_doorbell, int doorbell_index)
+{
+	u32 ih_doorbell_range;
+
+	ih_doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL);
+
+	if (use_doorbell) {
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_ENABLE,
+						  0x1);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_AWID,
+						  0x0);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_RANGE_OFFSET,
+						  doorbell_index);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_RANGE_SIZE,
+						  2);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
+						  0x0);
+	} else {
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_RANGE_SIZE,
+						  0);
+	}
+
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL, ih_doorbell_range);
+}
+
+static void nbio_v7_11_5_ih_control(struct amdgpu_device *adev)
+{
+	u32 interrupt_cntl;
+
+	/* setup interrupt control */
+		WREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL2,
+				adev->dummy_page_addr >> 8);
+
+	interrupt_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL);
+	/*
+	 * BIF_BX1_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=0 - dummy read disabled with msi, enabled without msi
+	 * BIF_BX1_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=1 - dummy read controlled by IH_DUMMY_RD_EN
+	 */
+	interrupt_cntl = REG_SET_FIELD(interrupt_cntl, BIF_BX1_INTERRUPT_CNTL,
+				       IH_DUMMY_RD_OVERRIDE, 0);
+
+	/* BIF_BX1_INTERRUPT_CNTL__IH_REQ_NONSNOOP_EN_MASK=1 if ring is in non-cacheable memory, e.g., vram */
+	interrupt_cntl = REG_SET_FIELD(interrupt_cntl, BIF_BX1_INTERRUPT_CNTL,
+				       IH_REQ_NONSNOOP_EN, 0);
+
+		WREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL, interrupt_cntl);
+}
+
+static u32 nbio_v7_11_5_get_hdp_flush_req_offset(struct amdgpu_device *adev)
+{
+	u32 offset;
+
+	offset = SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_GPU_HDP_FLUSH_REQ);
+
+	return offset;
+}
+
+static u32 nbio_v7_11_5_get_hdp_flush_done_offset(struct amdgpu_device *adev)
+{
+	u32 offset;
+
+	offset = SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_GPU_HDP_FLUSH_DONE);
+
+	return offset;
+}
+
+static u32 nbio_v7_11_5_get_pcie_index_offset(struct amdgpu_device *adev)
+{
+	u32 offset;
+
+	offset = SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_RSMU_INDEX);
+
+	return offset;
+}
+
+static u32 nbio_v7_11_5_get_pcie_data_offset(struct amdgpu_device *adev)
+{
+	u32 offset;
+
+	offset = SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF1_RSMU_DATA);
+
+	return offset;
+}
+
+const struct nbio_hdp_flush_reg nbio_v7_11_5_hdp_flush_reg = {
+	.ref_and_mask_cp0 = BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP0_MASK,
+	.ref_and_mask_cp1 = BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP1_MASK,
+	.ref_and_mask_cp2 = BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP2_MASK,
+	.ref_and_mask_cp3 = BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP3_MASK,
+	.ref_and_mask_cp4 = BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP4_MASK,
+	.ref_and_mask_cp5 = BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP5_MASK,
+	.ref_and_mask_cp6 = BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP6_MASK,
+	.ref_and_mask_cp7 = BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP7_MASK,
+	.ref_and_mask_cp8 = BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP8_MASK,
+	.ref_and_mask_cp9 = BIF_BX_PF1_GPU_HDP_FLUSH_DONE__CP9_MASK,
+	.ref_and_mask_sdma0 = BIF_BX_PF1_GPU_HDP_FLUSH_DONE__SDMA0_MASK,
+	.ref_and_mask_sdma1 = BIF_BX_PF1_GPU_HDP_FLUSH_DONE__SDMA1_MASK,
+};
+
+static void nbio_v7_11_5_init_registers(struct amdgpu_device *adev)
+{
+	uint32_t data;
+
+	data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2);
+	data &= ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2_MASK;
+	WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
+}
+
+#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
+
+static void nbio_v7_11_5_set_reg_remap(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	} else {
+		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+			regBIF_BX_PF1_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+		adev->rmmio_remap.bus_addr = 0;
+	}
+}
+
+const struct amdgpu_nbio_funcs nbio_v7_11_5_funcs = {
+	.get_hdp_flush_req_offset = nbio_v7_11_5_get_hdp_flush_req_offset,
+	.get_hdp_flush_done_offset = nbio_v7_11_5_get_hdp_flush_done_offset,
+	.get_pcie_index_offset = nbio_v7_11_5_get_pcie_index_offset,
+	.get_pcie_data_offset = nbio_v7_11_5_get_pcie_data_offset,
+	.get_rev_id = nbio_v7_11_5_get_rev_id,
+	.mc_access_enable = nbio_v7_11_5_mc_access_enable,
+	.get_memsize = nbio_v7_11_5_get_memsize,
+	.sdma_doorbell_range = nbio_v7_11_5_sdma_doorbell_range,
+	.vpe_doorbell_range = nbio_v7_11_5_vpe_doorbell_range,
+	.gc_doorbell_init = nbio_v7_11_5_gc_doorbell_init,
+	.enable_doorbell_aperture = nbio_v7_11_5_enable_doorbell_aperture,
+	.enable_doorbell_selfring_aperture = nbio_v7_11_5_enable_doorbell_selfring_aperture,
+	.ih_doorbell_range = nbio_v7_11_5_ih_doorbell_range,
+	.ih_control = nbio_v7_11_5_ih_control,
+	.init_registers = nbio_v7_11_5_init_registers,
+	.remap_hdp_registers = nbio_v7_11_5_remap_hdp_registers,
+	.set_reg_remap = nbio_v7_11_5_set_reg_remap,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.h b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.h
new file mode 100644
index 000000000000..8003564f857e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.h
@@ -0,0 +1,32 @@
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
+#ifndef __NBIO_V7_11_5_H__
+#define __NBIO_V7_11_5_H__
+
+#include "soc15_common.h"
+
+extern const struct nbio_hdp_flush_reg nbio_v7_11_5_hdp_flush_reg;
+extern const struct amdgpu_nbio_funcs nbio_v7_11_5_funcs;
+
+#endif
-- 
2.43.0

