Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0DFC04FF8
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 08:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C143112B05;
	Tue, 16 Apr 2024 08:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T+ZWKMTj";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9C6411232F
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 08:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJl1MjiqPi3pSBENih/fMGs6wlfgP189E2bzHE8u0nalgUJnpg2ZE8OLtjgj/aXTpdrzb4cqktNNKIOwvxkd50HCqWaWrQ08QzQxdO2/6RA85+HrlojSLt/vytrwwd/wsKBemUcuLXaPSQb20dkCT1Hx75gSoQr/oQzllZJJxgYGNEVjQaLTFhlxBHXI1XklYnNEPdtBBGOle6FQq2XOA4AARXPk2cQWqaiCVkk4JapBNNVHCbEE3mCl7SlExGOvAZJ6SvVV3OuWXDi3cr7otHUq34eN13cbWTgLAt1XqzwI1OgFMoegP5TAIIQ/+dDNzC7JQbaBXaYO9Gx/tOLrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHYO120YdDLSTBdGvLge4cJobzzVfBY1+OobAxVIK6Y=;
 b=Qt9eDW1G2cTxq6L4Wqo9TXcnmJEJJik8n+NG98vLRUrwtFB8Gu6Q73BVa+lbC9ocpmtHaE3ZDAoACuVQ/MH7IAhXm1oW7/uZvljNvxYg82Nqcwik+i3STNinK/7pzwjobezOpuo+5ImZEok70+wm1K+kaSnSdperSWqSf0+E6c0w/JKwCpbZ7p9GkO9Qwmu11YCvzHdWlTas9U956UoVgHweA5fQla06jUyR5eTi71vDptcd79ZzOC4i+v8Zv/VzDIGyyCjpAT9oB+N5uie8iSoErv2SDiUcyEpcMwdWxWRbfCvLGCW8cUEwko3rPKQXKkw2/4NvjE/1wBeiL41Ozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHYO120YdDLSTBdGvLge4cJobzzVfBY1+OobAxVIK6Y=;
 b=T+ZWKMTjJiIgDJS7f6qXEYwbAwebGOrtNTfgVzUKR7ojFZZyt3foNFMQwW3Fv1IuvlwzNjCyUh1uOQ7RNB2NaFm2vhRw/q25pn7NPXQzJHLFvi0XGeYc1G9Iviz05y+/HTKwLVli3BrWbRpxTALHYotvSi/DjVqHTU3h6T2tJw4=
Received: from CH0PR03CA0442.namprd03.prod.outlook.com (2603:10b6:610:10e::32)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 08:52:03 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::6) by CH0PR03CA0442.outlook.office365.com
 (2603:10b6:610:10e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Tue, 16 Apr 2024 08:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 08:52:02 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 03:52:00 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add AMDGPU benchmark dump function skeleton
Date: Tue, 16 Apr 2024 16:51:48 +0800
Message-ID: <20240416085150.2459820-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: e066d7ef-ad71-48d6-ad8b-08dc5df27c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUNSO1TvJL9l07a3z2XqS5V2qanvOKDLi2hXikS2/j/ruHk9RbTl4E/qaJPOdLQmnHdX3c+DVm89iAcX0GgCkisM2DtxMOFFxIUWnPND67RSeQtVRrotqgFRmdkY88ECYWRGjjv04tHaIKx1IlaNKIQNCc4skcuQTDN7RqRcjpxAySTRJN19gZfdWDmz3Zjb/eeQZDoCWH2BmNDPBfb233Ncc8qqMz+9NzzWGsD5TMMIs3EOm1e/Y3M1zJ3egyGl6LQf50kYDKxOtZlZ+GbrxiMFeVi3BgkieVsc/DFzqOvOzbRBXHwirMxgHKjkBku+J9JldROIOjfQUjNOLwJ+0/UT+YBCzfg02YxXzHDullbCi1OXyoXlTEZgfHx+Xu/Aj1B1YenX83ga/seCeznoaeaMDVltOV7w/lu62ZOWTpspG9Vr4q56dErON/BivRngg7eMQLPmNOnRNZ/WN5KNP83BkdSjlvNBuv9wRvxshD/l3R8Br3Am07YYsTvePASm7O/DYguXl5hxoam7ICGgUEa4wMlaw5XFcSkmCFIuA7YXI5Aa9NuFtsSqTgy5LvV28UtjHublkUhAkmj8/6JSa0ysdaEKi5QAvfVlsN4rnEPn/qECebMqQfj2UZA9cEjJiK57upl1kfWql/i7o8d3wb2fsENHIMrIzJegHz3luVU/L0l27Zbqgb8xF+AGsC4I80K6/GzL2R+oKj0FCKyU3sywHnE3LZcMDj2+C9v0g/MN77MjuFaMglTZ6kRwkDIa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 08:52:02.8001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e066d7ef-ad71-48d6-ad8b-08dc5df27c53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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

This will add the following bechmark dump for the amdgpu driver
performance tunning.

1. AMDGPU hardware configuration.
2. AMDGPU engine clock setting
3. AMDGPU link speed
4. AMDGPU momory move performance

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 262 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  24 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |   2 +-
 4 files changed, 288 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 65c17c59c152..163d221b3bbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -504,6 +504,7 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);
  */
 int amdgpu_benchmark(struct amdgpu_device *adev, int test_number);
 
+int amdgpu_benchmark_dump(struct amdgpu_device *adev, struct seq_file *m);
 /*
  * ASIC specific register table accessible by UMD
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index edc6377ec5ff..20784c407e0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -24,6 +24,11 @@
 
 #include <drm/amdgpu_drm.h>
 #include "amdgpu.h"
+#include "amdgpu_dpm.h"
+#include "amd_pcie.h"
+#include "atom.h"
+#include "amdgpu_smu.h"
+#include <linux/utsname.h>
 
 #define AMDGPU_BENCHMARK_ITERATIONS 1024
 #define AMDGPU_BENCHMARK_COMMON_MODES_N 17
@@ -258,3 +263,260 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 
 	return r;
 }
+
+static void amdgpu_benchmark_hw_config_dump(struct amdgpu_device *adev, struct seq_file *m)
+{
+	/*TODO: Export more AMDGPU hardware configuration*/
+	struct pci_dev *pdev = adev->pdev;
+
+	seq_puts(m, "Device info:\n");
+	seq_printf(m, "\tname:%s 0x%04X:0x%04X 0x%04X:0x%04X 0x%02X\n",
+			 amdgpu_asic_name[adev->asic_type], pdev->vendor, pdev->device,
+			 pdev->subsystem_vendor, pdev->subsystem_device, pdev->revision);
+	seq_printf(m, "\tnum_se = %d\n",  adev->gfx.config.max_shader_engines);
+	seq_printf(m, "\tnum_rb = %d\n",  hweight32(adev->gfx.config.backend_enable_mask));
+	seq_printf(m, "\tnum_active_cu = %d\n",  adev->gfx.cu_info.number);
+	seq_printf(m, "\n");
+}
+
+static void amdgpu_benchmark_freq_dump(struct amdgpu_device *adev, struct seq_file *m)
+{
+
+	uint32_t value;
+	uint32_t query = 0;
+	int size;
+
+	seq_puts(m, "amdgpu benchmark freq dump:\n");
+		if (adev->pm.dpm_enabled) {
+			seq_printf(m, "\tmax_gpu_freq_mhz = %d\n",  amdgpu_dpm_get_sclk(adev, false) / 100);
+			seq_printf(m, "\tmax_mem_freq_mhz = %d\n",  amdgpu_dpm_get_mclk(adev, false) / 100);
+			seq_printf(m, "\tmin_gpu_freq_mhz = %d\n",  amdgpu_dpm_get_sclk(adev, true) / 100);
+			seq_printf(m, "\tmin_mem_freq_mhz = %d\n",  amdgpu_dpm_get_mclk(adev, true) / 100);
+			if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0))
+				seq_printf(m, "\tmax glops = %d\n",
+						256 * adev->gfx.cu_info.number * amdgpu_dpm_get_sclk(adev, false) / 1000);
+			else
+				seq_printf(m, "\tmax glops = %d\n",
+						128 * adev->gfx.cu_info.number * amdgpu_dpm_get_sclk(adev, false) / 1000);
+
+
+		} else {
+			seq_printf(m, "\tmax_gpu_freq_mhz = %d\n",  adev->clock.default_sclk / 100);
+			seq_printf(m, "\tmax_mem_freq_mhz = %d\n",  adev->clock.default_mclk / 100);
+
+			if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0))
+				seq_printf(m, "\tmax glops = %d\n",
+						256 * adev->gfx.cu_info.number * adev->clock.default_sclk / 1000);
+			else
+				seq_printf(m, "\tmax glops = %d\n",
+						128 * adev->gfx.cu_info.number * adev->clock.default_sclk / 1000);
+		}
+
+		seq_printf(m, "\tclock_crystal_freq = %d\n",  amdgpu_asic_get_xclk(adev));
+
+		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_MCLK, (void *)&value, &size))
+			 seq_printf(m, "\t%u MHz (MCLK)\n", value/100);
+		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_SCLK, (void *)&value, &size))
+			 seq_printf(m, "\t%u MHz (SCLK)\n", value/100);
+		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK, (void *)&value, &size))
+			seq_printf(m, "\t%u MHz (PSTATE_SCLK)\n", value/100);
+		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_STABLE_PSTATE_MCLK, (void *)&value, &size))
+			seq_printf(m, "\t%u MHz (PSTATE_MCLK)\n", value/100);
+		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDGFX, (void *)&value, &size))
+			seq_printf(m, "\t%u mV (VDDGFX)\n", value);
+		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDNB, (void *)&value, &size))
+			seq_printf(m, "\t%u mV (VDDNB)\n", value);
+
+		size = sizeof(uint32_t);
+		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void *)&query, &size)) {
+			if (adev->flags & AMD_IS_APU)
+				seq_printf(m, "\t%u.%02u W (average SoC including CPU)\n", query >> 8, query & 0xff);
+			else
+				seq_printf(m, "\t%u.%02u W (average SoC)\n", query >> 8, query & 0xff);
+		}
+
+		size = sizeof(uint32_t);
+		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (void *)&query, &size)) {
+			if (adev->flags & AMD_IS_APU)
+				seq_printf(m, "\t%u.%02u W (current SoC including CPU)\n", query >> 8, query & 0xff);
+			else
+				seq_printf(m, "\t%u.%02u W (current SoC)\n", query >> 8, query & 0xff);
+		}
+
+		size = sizeof(value);
+		/* GPU Temp */
+		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_TEMP, (void *)&value, &size))
+			seq_printf(m, "\tGPU Temperature: %u C\n", value/1000);
+
+		/* GPU Load */
+		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_LOAD, (void *)&value, &size))
+			 seq_printf(m, "\tGPU Load: %u %%\n", value);
+		/* MEM Load */
+		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MEM_LOAD, (void *)&value, &size))
+			seq_printf(m, "\tMEM Load: %u %%\n", value);
+		/* VCN Load */
+		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VCN_LOAD, (void *)&value, &size))
+			seq_printf(m, "\tVCN Load: %u %%\n", value);
+		seq_printf(m, "\n");
+}
+
+/* Indexed by PCI_EXP_LNKCAP_SLS, PCI_EXP_LNKSTA_CLS */
+static const unsigned char pcie_link_speed[] = {
+	PCI_SPEED_UNKNOWN,              /* 0 */
+	PCIE_SPEED_2_5GT,               /* 1 */
+	PCIE_SPEED_5_0GT,               /* 2 */
+	PCIE_SPEED_8_0GT,               /* 3 */
+	PCIE_SPEED_16_0GT,              /* 4 */
+	PCIE_SPEED_32_0GT,              /* 5 */
+	PCIE_SPEED_64_0GT,              /* 6 */
+	PCI_SPEED_UNKNOWN,              /* 7 */
+	PCI_SPEED_UNKNOWN,              /* 8 */
+	PCI_SPEED_UNKNOWN,              /* 9 */
+	PCI_SPEED_UNKNOWN,              /* A */
+	PCI_SPEED_UNKNOWN,              /* B */
+	PCI_SPEED_UNKNOWN,              /* C */
+	PCI_SPEED_UNKNOWN,              /* D */
+	PCI_SPEED_UNKNOWN,              /* E */
+	PCI_SPEED_UNKNOWN               /* F */
+};
+static const char *pci_speed_string(enum pci_bus_speed speed)
+{
+	/* Indexed by the pci_bus_speed enum */
+	static const char *speed_strings[] = {
+	    "33 MHz PCI",		/* 0x00 */
+	    "66 MHz PCI",		/* 0x01 */
+	    "66 MHz PCI-X",		/* 0x02 */
+	    "100 MHz PCI-X",		/* 0x03 */
+	    "133 MHz PCI-X",		/* 0x04 */
+	    NULL,			/* 0x05 */
+	    NULL,			/* 0x06 */
+	    NULL,			/* 0x07 */
+	    NULL,			/* 0x08 */
+	    "66 MHz PCI-X 266",		/* 0x09 */
+	    "100 MHz PCI-X 266",	/* 0x0a */
+	    "133 MHz PCI-X 266",	/* 0x0b */
+	    "Unknown AGP",		/* 0x0c */
+	    "1x AGP",			/* 0x0d */
+	    "2x AGP",			/* 0x0e */
+	    "4x AGP",			/* 0x0f */
+	    "8x AGP",			/* 0x10 */
+	    "66 MHz PCI-X 533",		/* 0x11 */
+	    "100 MHz PCI-X 533",	/* 0x12 */
+	    "133 MHz PCI-X 533",	/* 0x13 */
+	    "2.5 GT/s PCIe",		/* 0x14 */
+	    "5.0 GT/s PCIe",		/* 0x15 */
+	    "8.0 GT/s PCIe",		/* 0x16 */
+	    "16.0 GT/s PCIe",		/* 0x17 */
+	    "32.0 GT/s PCIe",		/* 0x18 */
+	    "64.0 GT/s PCIe",		/* 0x19 */
+	};
+
+	if (speed < ARRAY_SIZE(speed_strings))
+		return speed_strings[speed];
+	return "Unknown";
+}
+
+static void amdgpu_benchmark_link_speed_dump(struct amdgpu_device *adev, struct seq_file *m)
+{
+	u16 linkstat;
+	enum pci_bus_speed speed;
+
+	seq_puts(m, "amdgpu benchmark link speed dump:\n");
+	seq_printf(m, "\tGPU PCIe gen: %d\n", fls(adev->pm.pcie_gen_mask &
+				(adev->pm.pcie_gen_mask >> 16)));
+	seq_printf(m, "\tGPU PCIe lanes num: %d\n",
+			adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X32 ? 32 :
+			adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16 ? 16 :
+			adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12 ? 12 :
+			adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8 ? 8 :
+			adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4 ? 4 :
+			adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 ? 2 :
+			1);
+	seq_printf(m, "\tGPU PCIe link max speed: %s\n",
+			pci_speed_string(pcie_get_speed_cap(adev->pdev)));
+
+	pcie_capability_read_word(adev->pdev, PCI_EXP_LNKSTA, &linkstat);
+	speed = pcie_link_speed[linkstat & PCI_EXP_LNKSTA_CLS];
+
+	seq_printf(m, "\tGPU PCIe link current speed: %s\n", pci_speed_string(speed));
+	seq_printf(m, "\n");
+
+}
+
+static void amdgpu_benchmark_mem_metrics_dump(struct amdgpu_device *adev, struct seq_file *m)
+{
+	struct ttm_resource_manager *gtt_man =
+			&adev->mman.gtt_mgr.manager;
+	struct ttm_resource_manager *vram_man =
+			&adev->mman.vram_mgr.manager;
+	uint32_t l1_cache_size;
+
+	seq_puts(m, "amdgpu benchmark mem metrics dump:\n");
+
+	l1_cache_size = adev->gfx.config.gc_gl1c_size_per_instance *
+			adev->gfx.config.gc_gl1c_per_sa;
+
+	seq_printf(m, "\tL0 cache size:%d KB\n", round_up(l1_cache_size, 1024));
+	seq_printf(m, "\tL1 cache size:%d KB\n", l1_cache_size);
+	seq_printf(m, "\tL2 cache size:%d KB\n", round_up(adev->gfx.config.gc_gl2c_per_gpu, 1024));
+	seq_printf(m, "\ttexture channels cache:%d \n", adev->gfx.config.max_texture_channel_caches);
+
+	seq_printf(m, "\tVRAM type:%d \n", adev->gmc.vram_type);
+	seq_printf(m, "\tVRAM bit width:%d \n", adev->gmc.vram_width);
+	seq_printf(m, "\tVRAM total heap size:%lld KB\n", adev->gmc.real_vram_size);
+	seq_printf(m, "\tVRAM usable heap size:%lld KB\n", adev->gmc.real_vram_size -
+			atomic64_read(&adev->vram_pin_size) -
+			AMDGPU_VM_RESERVED_VRAM);
+	seq_printf(m, "\tVRAM heap usage size:%lld KB\n", ttm_resource_manager_usage(vram_man));
+
+	seq_printf(m, "\tVRAM cpu acessable total size:%lld KB\n", adev->gmc.visible_vram_size);
+	seq_printf(m, "\tVRAM cpu acessable usable size:%lld KB\n", min(adev->gmc.visible_vram_size -
+			atomic64_read(&adev->visible_pin_size),
+			adev->gmc.real_vram_size -
+			atomic64_read(&adev->vram_pin_size) -
+			AMDGPU_VM_RESERVED_VRAM));
+	seq_printf(m, "\tVRAM cpu acessable heap usage size:%lld KB\n",
+			amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr));
+
+	seq_printf(m, "\tGTT total heap size:%lld KB\n", gtt_man->size);
+	seq_printf(m, "\tGTT heap usable size:%lld KB\n", gtt_man->size -
+			atomic64_read(&adev->gart_pin_size));
+	seq_printf(m, "\tGTT heap usage size:%lld KB\n", ttm_resource_manager_usage(gtt_man));
+
+	seq_printf(m, "\n");
+
+}
+
+static void amdgpu_benchmark_driver_config_dump(struct amdgpu_device *adev, struct seq_file *m)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
+	seq_puts(m, "amdgpu benchmark driver config dump:\n");
+
+	seq_printf(m, "\tKernel version = %s\n", init_utsname()->release);
+	/*TODO: It's better to parse the performance level.*/
+	seq_printf(m, "\tperformace level = %d\n",
+		 amdgpu_dpm_get_performance_level(adev));
+	seq_printf(m, "\tprofile mode = %s\n",
+			amdgpu_pp_profile_name[smu->power_profile_mode]);
+
+	seq_printf(m, "\tvbios: %s\n", adev->mode_info.atom_context->vbios_pn);
+
+	seq_printf(m, "\n");
+
+}
+
+int amdgpu_benchmark_dump(struct amdgpu_device *adev, struct seq_file *m)
+{
+	int ret = 0;
+
+	seq_puts(m, "amdgpu benchmark dump:\n");
+
+	amdgpu_benchmark_hw_config_dump(adev, m);
+	amdgpu_benchmark_freq_dump(adev, m);
+	amdgpu_benchmark_link_speed_dump(adev, m);
+	amdgpu_benchmark_mem_metrics_dump(adev, m);
+	amdgpu_benchmark_driver_config_dump(adev, m);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f5d0fa207a88..7e935b9736c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1768,6 +1768,26 @@ static int amdgpu_debugfs_benchmark(void *data, u64 val)
 	return r;
 }
 
+static int amdgpu_debugfs_benchmark_dump_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_device *adev = m->private;
+	struct drm_device *dev = adev_to_drm(adev);
+	int r = 0;
+
+	r = pm_runtime_get_sync(dev->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
+		return r;
+	}
+
+	r = amdgpu_benchmark_dump(adev, m);
+
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
+	return r;
+}
+
 static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
 {
 	struct amdgpu_device *adev = m->private;
@@ -1804,6 +1824,8 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_test_ib);
 DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_vm_info);
+DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_benchmark_dump);
+
 DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_evict_vram_fops, amdgpu_debugfs_evict_vram,
 			 NULL, "%lld\n");
 DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_evict_gtt_fops, amdgpu_debugfs_evict_gtt,
@@ -2198,6 +2220,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_test_ib_fops);
 	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
 			    &amdgpu_debugfs_vm_info_fops);
+	debugfs_create_file("amdgpu_benchmark_dump", 0444, root, adev,
+			    &amdgpu_debugfs_benchmark_dump_fops);
 	debugfs_create_file("amdgpu_benchmark", 0200, root, adev,
 			    &amdgpu_benchmark_fops);
 	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5bc1cd4993e8..ae597dba065f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -96,7 +96,7 @@ const char * const amdgpu_pp_profile_name[] = {
 	"CAPPED",
 	"UNCAPPED",
 };
-
+EXPORT_SYMBOL_GPL(amdgpu_pp_profile_name);
 /**
  * DOC: power_dpm_state
  *
-- 
2.34.1

