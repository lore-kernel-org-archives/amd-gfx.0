Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B902CAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A81710E5F0;
	Thu, 18 Sep 2025 01:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PbVTvQUi";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E044110E5F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaiJ8LoeV5Wzjqy2AzQsFVE6riJBm67wKVdPIB0r6QuPwQO/JbzMBvCQRLnLrOx0hWVeOPbvGlkm571jSbXGPegn/cGPwT33U2lnu/os0FLIRthBBeRqlwrtDV7Kr5alsaIMC1XllfyQzVofaKDcV2sXpXP93d/lvLfavR95BGBaQtdfAYwRyepEIC9cp+WnZr/75ZxV0HhJ0lfdfdxEsM2ltJHl5Aq+37Wa1zRksyTc+2O8KbQXateUlIXB5S+aSZIBq0ea/iwwrhCdaUwCiPoycHcgRTIG8A8OnXgggKfPilxrb7Obx8lwKehoQPPOUfNomgQFE1mZsXStq3JXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbK9dHvB4ZtGxzOrX1ZXqJdFPbEwRVdqCCSVHIH8wg8=;
 b=W2/BE7PoR5F8o0ct+CFn/ukndVJTrJNia5CSzjSlZNGEx9Ll3CbE7VwtNKqZrd5KZX4hKhbRTGgbpNnayt7MUrZD3JKI5cxHhhiXVtWhH886uC0vzSwxTY1Xzg83gf2VnNe23ceqHRgvGRJZZnOy7LUZKMnhp6CRoIOWBolC0QPpjQAJpuxJmE72G4vb/fM8LtGdMR9aASDSrG2ihL9P8zM67bUD4dSt8+b+Xcl+MEJo5M8MvDH75dz8v/AmPS1N92ZV9Pef45ucOvql03vVzes2DGUEsnaLNxcNfb+3jbBqkZEuINnInIQf2+crT6FQ+CC3uqVvN7gp6bUbX/aqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbK9dHvB4ZtGxzOrX1ZXqJdFPbEwRVdqCCSVHIH8wg8=;
 b=PbVTvQUiZMqpEGSLp26KUnT6N/Sqls++hGT2I3EEq2uz6ptvIFEMnCt4BYKKcAXXT2So75VXfUyS/0A7bRh1EY8tJ4C8sP9/45kGoKELqCK0n4PbHJk21blnpwU+mbYf4rwsK2K6tLaEYEya+SaIAq7jJX5LeAd3u4qi0E0C6S4=
Received: from BYAPR05CA0106.namprd05.prod.outlook.com (2603:10b6:a03:e0::47)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 01:33:25 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::80) by BYAPR05CA0106.outlook.office365.com
 (2603:10b6:a03:e0::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 01:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:33:24 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:33:22 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 09/21] drm/amd/ras: Add umc v12_0 ras functions
Date: Thu, 18 Sep 2025 09:32:20 +0800
Message-ID: <20250918013232.2629215-9-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
References: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d734638-f734-422c-960d-08ddf6535c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nbe94wtNGw2hLMmWXe/2mkMfx3P0ZJRCBPz7DKjoYRaVIX84i+/577zPGjjV?=
 =?us-ascii?Q?jhR27TwyLYABmypfpZ2f7JMKjSf79WF4wmcz7oeE0wh82b5262WieREWmb5P?=
 =?us-ascii?Q?HZfNaFfcyXylpeJQqEKP9O30SK/RQr8+/lTseKuSJv3zwYICxOb712eyrmx4?=
 =?us-ascii?Q?97IoT/5BcThsufvPvjiudyIpGuNQFr5S7+q6Kow2IfNjcTraGT1oq9Gducpr?=
 =?us-ascii?Q?oLDqZiJTYcUKqpdKpm46ArYf79JtqlqB2ZTCxTF//pRaA26SqlpCJfj2/kU1?=
 =?us-ascii?Q?y6osCRXGhH3Umoh1S9uixuYPH/BKOW7B/4a+/g86GIk8FQh7DyMrpf6JzC8c?=
 =?us-ascii?Q?33/zGN/0JJzkqQj2TR+F3ZzCxiJqxwUS4d1EOlb1PovpB+cqBrslSxv1goff?=
 =?us-ascii?Q?HxRrM/Lvt11KLb3nvtjW6Y1XcwqadR/sHVfCyakX93YmeEixUC8lO0Daus7+?=
 =?us-ascii?Q?Bd2Pw2uR/pSdTyN6WNqcF7D6s400veCxAFTuRSW//UBuXEkBzKsszAC0MfNZ?=
 =?us-ascii?Q?sEdj1XN7Udapb9cuLv6lhiuZ2+h4JvWhp2wo65BhHBVjiHYTwnBrRVjJEWWn?=
 =?us-ascii?Q?3I7VMl7ebNK9OURXU5hv4UTS/0NiyCMn+Q3DXoAkWizo8HFL4kUogpit1/py?=
 =?us-ascii?Q?XEQ0d9uAIZT5TtejoUXI689Bw2Q438W1qGbdFbU7i+RUWfNTm7gK1W9ZUpKX?=
 =?us-ascii?Q?83L1LJoOjFVIKOBDhB388Pi3uA+e9+nFtcofFLGWU7EIxkVqJG1DQZ4lEtT9?=
 =?us-ascii?Q?cTmJfAN4CgzE9qswKvOy41GhamjJIPm8xX9WLpNdiEpE+1UG1VhP++9FO6MA?=
 =?us-ascii?Q?RSr7gUAqIc3ANbARc/YyKTPok24tezLVE+UYvDV11WXzaIZu6L0k8960TDeR?=
 =?us-ascii?Q?oiX6MORINhNZwrPjIz2IGzUx9tZD4duoG29RnFMQxxwSnINXu02BVJcwjEmp?=
 =?us-ascii?Q?0gNzi31H3CDOAFUQHShTOwb+MSh2Kuz6lbq5Nup4tuJ2HIrMjWh9AeyEWKTz?=
 =?us-ascii?Q?sNl9RhGu9kqfDsdPApjF5QAwBR7MHw1owolfaWH3SJDqhBaItqzgBIhQgrBB?=
 =?us-ascii?Q?/CFTZRtK5wT5+Rg8oQYm7pMaNchCOIZEw+yeD67pXul5bOHJsQV0gqzBbusB?=
 =?us-ascii?Q?955hoYLNbasvwn1x2Bx6ZRnNoGFnJYmxg45Aiuy0aUl5rNPcADcP1BdOaK8D?=
 =?us-ascii?Q?tRqZIu/LHkl90Z/5a+75A60FKRIAG490nFpmG3ORJEbdSr3+L8AqqcuyUdpQ?=
 =?us-ascii?Q?BquKjpRlKzAnRqaskP1I3+ivd7/YdJ+Hlm8PDj1hIq6rN9gNnOgv0/bsGT+3?=
 =?us-ascii?Q?yx4IhALqy4tgp0OW/ZDFKnF1eZCCAL5JGVbZZkZ5wFLAvyblbCwrOjgfQjhL?=
 =?us-ascii?Q?AFsP9O3PNA37JORbWTzvA6JMYBjOPxZ3Cbu0FLZsBfXw976I1qzGkpXdt6NJ?=
 =?us-ascii?Q?1MTYwNTkfH7cFT9n8JeVohP6T+lw9//XYl8yscPG4qBzvwwjT/9I7gW7nRmf?=
 =?us-ascii?Q?E/m0shapCmiEPYdiNBH2r2zsS/YriJUO8rhn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:33:24.3956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d734638-f734-422c-960d-08ddf6535c27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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

Add umc v12_0 ras functions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   | 511 ++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.h   | 314 +++++++++++
 2 files changed, 825 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
new file mode 100644
index 000000000000..5d9a11c17a86
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -0,0 +1,511 @@
+// SPDX-License-Identifier: MIT
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
+#include "ras.h"
+#include "ras_umc.h"
+#include "ras_core_status.h"
+#include "ras_umc_v12_0.h"
+
+#define NumDieInterleaved 4
+
+static const uint32_t umc_v12_0_channel_idx_tbl[]
+	[UMC_V12_0_UMC_INSTANCE_NUM][UMC_V12_0_CHANNEL_INSTANCE_NUM] = {
+	{{3,   7,   11,  15,  2,   6,   10,  14},  {1,   5,   9,   13,  0,   4,   8,   12},
+	 {19,  23,  27,  31,  18,  22,  26,  30},  {17,  21,  25,  29,  16,  20,  24,  28}},
+	{{47,  43,  39,  35,  46,  42,  38,  34},  {45,  41,  37,  33,  44,  40,  36,  32},
+	 {63,  59,  55,  51,  62,  58,  54,  50},  {61,  57,  53,  49,  60,  56,  52,  48}},
+	{{79,  75,  71,  67,  78,  74,  70,  66},  {77,  73,  69,  65,  76,  72,  68,  64},
+	 {95,  91,  87,  83,  94,  90,  86,  82},  {93,  89,  85,  81,  92,  88,  84,  80}},
+	{{99,  103, 107, 111, 98,  102, 106, 110}, {97,  101, 105, 109, 96,  100, 104, 108},
+	 {115, 119, 123, 127, 114, 118, 122, 126}, {113, 117, 121, 125, 112, 116, 120, 124}}
+};
+
+/* mapping of MCA error address to normalized address */
+static const uint32_t umc_v12_0_ma2na_mapping[] = {
+	0,  5,  6,  8,  9,  14, 12, 13,
+	10, 11, 15, 16, 17, 18, 19, 20,
+	21, 22, 23, 24, 25, 26, 27, 28,
+	24, 7,  29, 30,
+};
+
+static bool umc_v12_0_bit_wise_xor(uint32_t val)
+{
+	bool result = 0;
+	int i;
+
+	for (i = 0; i < 32; i++)
+		result = result ^ ((val >> i) & 0x1);
+
+	return result;
+}
+
+static void __get_nps_pa_flip_bits(struct ras_core_context *ras_core,
+			enum umc_memory_partition_mode nps,
+			struct umc_flip_bits *flip_bits)
+{
+	uint32_t vram_type = ras_core->ras_umc.umc_vram_type;
+
+	/* default setting */
+	flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_C2_BIT;
+	flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C3_BIT;
+	flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_C4_BIT;
+	flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R13_BIT;
+	flip_bits->flip_row_bit = 13;
+	flip_bits->bit_num = 4;
+	flip_bits->r13_in_pa = UMC_V12_0_PA_R13_BIT;
+
+	if (nps == UMC_MEMORY_PARTITION_MODE_NPS2) {
+		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
+		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
+		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
+		flip_bits->r13_in_pa = UMC_V12_0_PA_R12_BIT;
+	} else if (nps == UMC_MEMORY_PARTITION_MODE_NPS4) {
+		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
+		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
+		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
+		flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
+	}
+
+	switch (vram_type) {
+	case UMC_VRAM_TYPE_HBM:
+		/* other nps modes are taken as nps1 */
+		if (nps == UMC_MEMORY_PARTITION_MODE_NPS2)
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
+		else if (nps == UMC_MEMORY_PARTITION_MODE_NPS4)
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+
+		break;
+	case UMC_VRAM_TYPE_HBM3E:
+		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
+		flip_bits->flip_row_bit = 12;
+
+		if (nps == UMC_MEMORY_PARTITION_MODE_NPS2)
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
+		else if (nps == UMC_MEMORY_PARTITION_MODE_NPS4)
+			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
+
+		break;
+	default:
+		RAS_DEV_WARN(ras_core->dev,
+			"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
+		break;
+	}
+}
+
+static uint64_t  convert_nps_pa_to_row_pa(struct ras_core_context *ras_core,
+		uint64_t pa, enum umc_memory_partition_mode nps, bool zero_pfn_ok)
+{
+	struct umc_flip_bits flip_bits = {0};
+	uint64_t row_pa;
+	int i;
+
+	__get_nps_pa_flip_bits(ras_core, nps, &flip_bits);
+
+	row_pa = pa;
+	/* clear loop bits in soc physical address */
+	for (i = 0; i < flip_bits.bit_num; i++)
+		row_pa &= ~BIT_ULL(flip_bits.flip_bits_in_pa[i]);
+
+	if (!zero_pfn_ok && !RAS_ADDR_TO_PFN(row_pa))
+		row_pa |= BIT_ULL(flip_bits.flip_bits_in_pa[2]);
+
+	return row_pa;
+}
+
+static int lookup_bad_pages_in_a_row(struct ras_core_context *ras_core,
+		struct eeprom_umc_record *record, uint32_t nps,
+		uint64_t *pfns, uint32_t num,
+		uint64_t seq_no, bool dump)
+{
+	uint32_t col, col_lower, row, row_lower, idx, row_high;
+	uint64_t soc_pa, row_pa, column, err_addr;
+	uint64_t retired_addr = RAS_PFN_TO_ADDR(record->cur_nps_retired_row_pfn);
+	struct umc_flip_bits flip_bits = {0};
+	uint32_t retire_unit;
+	uint32_t i;
+
+	__get_nps_pa_flip_bits(ras_core, nps, &flip_bits);
+
+	row_pa = convert_nps_pa_to_row_pa(ras_core, retired_addr, nps, true);
+
+	err_addr = record->address;
+	/* get column bit 0 and 1 in mca address */
+	col_lower = (err_addr >> 1) & 0x3ULL;
+	/* MA_R13_BIT will be handled later */
+	row_lower = (err_addr >> UMC_V12_0_MCA_R0_BIT) & 0x1fffULL;
+	row_lower &= ~BIT_ULL(flip_bits.flip_row_bit);
+
+	if (ras_core->ras_gfx.gfx_ip_version >= IP_VERSION(9, 5, 0)) {
+		row_high = (row_pa >> flip_bits.r13_in_pa) & 0x3ULL;
+		/* it's 2.25GB in each channel, from MCA address to PA
+		 * [R14 R13] is converted if the two bits value are 0x3,
+		 * get them from PA instead of MCA address.
+		 */
+		row_lower |= (row_high << 13);
+	}
+
+	idx = 0;
+	row = 0;
+	retire_unit = 0x1 << flip_bits.bit_num;
+	/* loop for all possibilities of retire bits */
+	for (column = 0; column < retire_unit; column++) {
+		soc_pa = row_pa;
+		for (i = 0; i < flip_bits.bit_num; i++)
+			soc_pa |= (((column >> i) & 0x1ULL) << flip_bits.flip_bits_in_pa[i]);
+
+		col = ((column & 0x7) << 2) | col_lower;
+
+		/* add row bit 13 */
+		if (flip_bits.bit_num == UMC_PA_FLIP_BITS_NUM)
+			row = ((column >> 3) << flip_bits.flip_row_bit) | row_lower;
+
+		if (dump)
+			RAS_DEV_INFO(ras_core->dev,
+				"{%llu} Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
+				seq_no, soc_pa, row, col,
+				record->cur_nps_bank, record->mem_channel);
+
+
+		if (pfns && (idx < num))
+			pfns[idx++] = RAS_ADDR_TO_PFN(soc_pa);
+	}
+
+	return idx;
+}
+
+static int umc_v12_convert_ma_to_pa(struct ras_core_context *ras_core,
+			struct umc_mca_addr *addr_in, struct umc_phy_addr *addr_out,
+			uint32_t nps)
+{
+	uint32_t i, na_shift;
+	uint64_t soc_pa, na, na_nps;
+	uint32_t bank_hash0, bank_hash1, bank_hash2, bank_hash3, col, row;
+	uint32_t bank0, bank1, bank2, bank3, bank;
+	uint32_t ch_inst = addr_in->ch_inst;
+	uint32_t umc_inst = addr_in->umc_inst;
+	uint32_t node_inst = addr_in->node_inst;
+	uint32_t socket_id = addr_in->socket_id;
+	uint32_t channel_index;
+	uint64_t err_addr = addr_in->err_addr;
+
+	if (node_inst != UMC_INV_AID_NODE) {
+		if (ch_inst >= UMC_V12_0_CHANNEL_INSTANCE_NUM ||
+			umc_inst >= UMC_V12_0_UMC_INSTANCE_NUM ||
+			node_inst >= UMC_V12_0_AID_NUM_MAX ||
+			socket_id >= UMC_V12_0_SOCKET_NUM_MAX)
+			return -EINVAL;
+	} else {
+		if (socket_id >= UMC_V12_0_SOCKET_NUM_MAX ||
+			ch_inst >= UMC_V12_0_TOTAL_CHANNEL_NUM)
+			return -EINVAL;
+	}
+
+	bank_hash0 = (err_addr >> UMC_V12_0_MCA_B0_BIT) & 0x1ULL;
+	bank_hash1 = (err_addr >> UMC_V12_0_MCA_B1_BIT) & 0x1ULL;
+	bank_hash2 = (err_addr >> UMC_V12_0_MCA_B2_BIT) & 0x1ULL;
+	bank_hash3 = (err_addr >> UMC_V12_0_MCA_B3_BIT) & 0x1ULL;
+	col = (err_addr >> 1) & 0x1fULL;
+	row = (err_addr >> 10) & 0x3fffULL;
+
+	/* apply bank hash algorithm */
+	bank0 =
+		bank_hash0 ^ (UMC_V12_0_XOR_EN0 &
+		(umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR0) ^
+		(umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR0))));
+	bank1 =
+		bank_hash1 ^ (UMC_V12_0_XOR_EN1 &
+		(umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR1) ^
+		(umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR1))));
+	bank2 =
+		bank_hash2 ^ (UMC_V12_0_XOR_EN2 &
+		(umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR2) ^
+		(umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR2))));
+	bank3 =
+		bank_hash3 ^ (UMC_V12_0_XOR_EN3 &
+		(umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR3) ^
+		(umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR3))));
+
+	bank = bank0 | (bank1 << 1) | (bank2 << 2) | (bank3 << 3);
+	err_addr &= ~0x3c0ULL;
+	err_addr |= (bank << UMC_V12_0_MCA_B0_BIT);
+
+	na_nps = 0x0;
+	/* convert mca error address to normalized address */
+	for (i = 1; i < ARRAY_SIZE(umc_v12_0_ma2na_mapping); i++)
+		na_nps |= ((err_addr >> i) & 0x1ULL) << umc_v12_0_ma2na_mapping[i];
+
+	if (nps == UMC_MEMORY_PARTITION_MODE_NPS1)
+		na_shift = 8;
+	else if (nps == UMC_MEMORY_PARTITION_MODE_NPS2)
+		na_shift = 9;
+	else if (nps == UMC_MEMORY_PARTITION_MODE_NPS4)
+		na_shift = 10;
+	else if (nps == UMC_MEMORY_PARTITION_MODE_NPS8)
+		na_shift = 11;
+	else
+		return -EINVAL;
+
+	na = ((na_nps >> na_shift) << 8) | (na_nps & 0xff);
+
+	if (node_inst != UMC_INV_AID_NODE)
+		channel_index =
+			umc_v12_0_channel_idx_tbl[node_inst][umc_inst][ch_inst];
+	else {
+		channel_index = ch_inst;
+		node_inst = channel_index /
+			(UMC_V12_0_UMC_INSTANCE_NUM * UMC_V12_0_CHANNEL_INSTANCE_NUM);
+	}
+
+	/* translate umc channel address to soc pa, 3 parts are included */
+	soc_pa = ADDR_OF_32KB_BLOCK(na) |
+		ADDR_OF_256B_BLOCK(channel_index) |
+		OFFSET_IN_256B_BLOCK(na);
+
+	/* calc channel hash based on absolute address */
+	soc_pa += socket_id * SOCKET_LFB_SIZE;
+	/* the umc channel bits are not original values, they are hashed */
+	UMC_V12_0_SET_CHANNEL_HASH(channel_index, soc_pa);
+	/* restore pa */
+	soc_pa -= socket_id * SOCKET_LFB_SIZE;
+
+	/* get some channel bits from na_nps directly and
+	 * add nps section offset
+	 */
+	if (nps == UMC_MEMORY_PARTITION_MODE_NPS2) {
+		soc_pa &= ~(0x1ULL << UMC_V12_0_PA_CH5_BIT);
+		soc_pa |= ((na_nps & 0x100) << 5);
+		soc_pa += (node_inst >> 1) * (SOCKET_LFB_SIZE >> 1);
+	} else if (nps == UMC_MEMORY_PARTITION_MODE_NPS4) {
+		soc_pa &= ~(0x3ULL << UMC_V12_0_PA_CH4_BIT);
+		soc_pa |= ((na_nps & 0x300) << 4);
+		soc_pa += node_inst * (SOCKET_LFB_SIZE >> 2);
+	} else if (nps == UMC_MEMORY_PARTITION_MODE_NPS8) {
+		soc_pa &= ~(0x7ULL << UMC_V12_0_PA_CH4_BIT);
+		soc_pa |= ((na_nps & 0x700) << 4);
+		soc_pa += node_inst * (SOCKET_LFB_SIZE >> 2) +
+			(channel_index >> 4) * (SOCKET_LFB_SIZE >> 3);
+	}
+
+	addr_out->pa = soc_pa;
+	addr_out->bank = bank;
+	addr_out->channel_idx = channel_index;
+
+	return 0;
+}
+
+static int convert_ma_to_pa(struct ras_core_context *ras_core,
+			struct umc_mca_addr *addr_in, struct umc_phy_addr *addr_out,
+			uint32_t nps)
+{
+	int ret;
+
+	if (ras_psp_check_supported_cmd(ras_core, RAS_TA_CMD_ID__QUERY_ADDRESS))
+		ret = ras_umc_psp_convert_ma_to_pa(ras_core,
+				addr_in, addr_out, nps);
+	else
+		ret = umc_v12_convert_ma_to_pa(ras_core,
+				addr_in, addr_out, nps);
+
+	return ret;
+}
+
+static int convert_bank_to_nps_addr(struct ras_core_context *ras_core,
+			struct ras_bank_ecc *bank, struct umc_phy_addr *pa_addr, uint32_t nps)
+{
+	struct umc_mca_addr addr_in;
+	struct umc_phy_addr addr_out;
+	int ret;
+
+	memset(&addr_in, 0, sizeof(addr_in));
+	memset(&addr_out, 0, sizeof(addr_out));
+
+	addr_in.err_addr = ACA_ADDR_2_ERR_ADDR(bank->addr);
+	addr_in.ch_inst = ACA_IPID_2_UMC_CH(bank->ipid);
+	addr_in.umc_inst = ACA_IPID_2_UMC_INST(bank->ipid);
+	addr_in.node_inst = ACA_IPID_2_DIE_ID(bank->ipid);
+	addr_in.socket_id = ACA_IPID_2_SOCKET_ID(bank->ipid);
+
+	ret = convert_ma_to_pa(ras_core, &addr_in, &addr_out, nps);
+	if (!ret) {
+		pa_addr->pa =
+			convert_nps_pa_to_row_pa(ras_core, addr_out.pa, nps, false);
+		pa_addr->channel_idx = addr_out.channel_idx;
+		pa_addr->bank = addr_out.bank;
+	}
+
+	return ret;
+}
+
+static int umc_v12_0_bank_to_eeprom_record(struct ras_core_context *ras_core,
+		struct ras_bank_ecc *bank, struct eeprom_umc_record *record)
+{
+	struct umc_phy_addr nps_addr;
+	int ret;
+
+	memset(&nps_addr, 0, sizeof(nps_addr));
+
+	ret = convert_bank_to_nps_addr(ras_core, bank,
+			&nps_addr, bank->nps);
+	if (ret)
+		return ret;
+
+	ras_umc_fill_eeprom_record(ras_core,
+		ACA_ADDR_2_ERR_ADDR(bank->addr), ACA_IPID_2_UMC_INST(bank->ipid),
+		&nps_addr, bank->nps, record);
+
+	lookup_bad_pages_in_a_row(ras_core, record,
+		bank->nps, NULL, 0, bank->seq_no, true);
+
+	return 0;
+}
+
+static int convert_eeprom_record_to_nps_addr(struct ras_core_context *ras_core,
+			struct eeprom_umc_record *record, uint64_t *pa, uint32_t nps)
+{
+	struct device_system_info dev_info = {0};
+	struct umc_mca_addr addr_in;
+	struct umc_phy_addr addr_out;
+	int ret;
+
+	memset(&addr_in, 0, sizeof(addr_in));
+	memset(&addr_out, 0, sizeof(addr_out));
+
+	ras_core_get_device_system_info(ras_core, &dev_info);
+
+	addr_in.err_addr = record->address;
+	addr_in.ch_inst = record->mem_channel;
+	addr_in.umc_inst = record->mcumc_id;
+	addr_in.node_inst = UMC_INV_AID_NODE;
+	addr_in.socket_id = dev_info.socket_id;
+
+	ret = convert_ma_to_pa(ras_core, &addr_in, &addr_out, nps);
+	if (ret)
+		return ret;
+
+	*pa = convert_nps_pa_to_row_pa(ras_core, addr_out.pa, nps, false);
+
+	return 0;
+}
+
+static int umc_v12_0_eeprom_record_to_nps_record(struct ras_core_context *ras_core,
+				struct eeprom_umc_record *record, uint32_t nps)
+{
+	uint64_t pa = 0;
+	int ret = 0;
+
+	if (nps == EEPROM_RECORD_UMC_NPS_MODE(record)) {
+		record->cur_nps_retired_row_pfn = EEPROM_RECORD_UMC_ADDR_PFN(record);
+	} else {
+		ret = convert_eeprom_record_to_nps_addr(ras_core,
+				record, &pa, nps);
+		if (!ret)
+			record->cur_nps_retired_row_pfn = RAS_ADDR_TO_PFN(pa);
+	}
+
+	record->cur_nps = nps;
+
+	return ret;
+}
+
+static int umc_v12_0_eeprom_record_to_nps_pages(struct ras_core_context *ras_core,
+			struct eeprom_umc_record *record, uint32_t nps,
+			uint64_t *pfns, uint32_t num)
+{
+	return lookup_bad_pages_in_a_row(ras_core,
+				record, nps, pfns, num, 0, false);
+}
+
+static int umc_12_0_soc_pa_to_bank(struct ras_core_context *ras_core,
+			uint64_t soc_pa,
+			struct umc_bank_addr *bank_addr)
+{
+
+	int channel_hashed = 0;
+	int channel_real = 0;
+	int channel_reversed = 0;
+	int i = 0;
+
+	bank_addr->stack_id = UMC_V12_0_SOC_PA_TO_SID(soc_pa);
+	bank_addr->bank_group = 0; /* This is a combination of SID & Bank. Needed?? */
+	bank_addr->bank = UMC_V12_0_SOC_PA_TO_BANK(soc_pa);
+	bank_addr->row = UMC_V12_0_SOC_PA_TO_ROW(soc_pa);
+	bank_addr->column = UMC_V12_0_SOC_PA_TO_COL(soc_pa);
+
+	/* Channel bits 4-6 are hashed. Bruteforce reverse the hash */
+	channel_hashed = (soc_pa >> UMC_V12_0_PA_CH4_BIT) & 0x7;
+
+	for (i = 0; i < 8; i++) {
+		channel_reversed = 0;
+		channel_reversed |= UMC_V12_0_CHANNEL_HASH_CH4((i << 4), soc_pa);
+		channel_reversed |= (UMC_V12_0_CHANNEL_HASH_CH5((i << 4), soc_pa) << 1);
+		channel_reversed |= (UMC_V12_0_CHANNEL_HASH_CH6((i << 4), soc_pa) << 2);
+		if (channel_reversed == channel_hashed)
+			channel_real = ((i << 4)) | ((soc_pa >> UMC_V12_0_PA_CH0_BIT) & 0xf);
+	}
+
+	bank_addr->channel = channel_real;
+	bank_addr->subchannel = UMC_V12_0_SOC_PA_TO_PC(soc_pa);
+
+	return 0;
+}
+
+static int umc_12_0_bank_to_soc_pa(struct ras_core_context *ras_core,
+			struct umc_bank_addr bank_addr,
+			uint64_t *soc_pa)
+{
+	uint64_t na = 0;
+	uint64_t tmp_pa = 0;
+	*soc_pa = 0;
+
+	tmp_pa |= UMC_V12_0_SOC_SID_TO_PA(bank_addr.stack_id);
+	tmp_pa |= UMC_V12_0_SOC_BANK_TO_PA(bank_addr.bank);
+	tmp_pa |= UMC_V12_0_SOC_ROW_TO_PA(bank_addr.row);
+	tmp_pa |= UMC_V12_0_SOC_COL_TO_PA(bank_addr.column);
+	tmp_pa |= UMC_V12_0_SOC_CH_TO_PA(bank_addr.channel);
+	tmp_pa |= UMC_V12_0_SOC_PC_TO_PA(bank_addr.subchannel);
+
+	/* Get the NA */
+	na = ((tmp_pa >> UMC_V12_0_PA_C2_BIT) << UMC_V12_0_NA_C2_BIT);
+	na |= tmp_pa & 0xff;
+
+	/* translate umc channel address to soc pa, 3 parts are included */
+	tmp_pa = ADDR_OF_32KB_BLOCK(na) |
+		ADDR_OF_256B_BLOCK(bank_addr.channel) |
+		OFFSET_IN_256B_BLOCK(na);
+
+	/* the umc channel bits are not original values, they are hashed */
+	UMC_V12_0_SET_CHANNEL_HASH(bank_addr.channel, tmp_pa);
+
+	*soc_pa = tmp_pa;
+
+	return 0;
+}
+
+const struct ras_umc_ip_func ras_umc_func_v12_0 = {
+	.bank_to_eeprom_record = umc_v12_0_bank_to_eeprom_record,
+	.eeprom_record_to_nps_record = umc_v12_0_eeprom_record_to_nps_record,
+	.eeprom_record_to_nps_pages = umc_v12_0_eeprom_record_to_nps_pages,
+	.bank_to_soc_pa = umc_12_0_bank_to_soc_pa,
+	.soc_pa_to_bank = umc_12_0_soc_pa_to_bank,
+};
+
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h
new file mode 100644
index 000000000000..8a35ad856165
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.h
@@ -0,0 +1,314 @@
+/* SPDX-License-Identifier: MIT */
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
+#ifndef __RAS_UMC_V12_0_H__
+#define __RAS_UMC_V12_0_H__
+#include "ras.h"
+
+/* MCA_UMC_UMC0_MCUMC_ADDRT0 */
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr__SHIFT                0x0
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__Reserved__SHIFT                 0x38
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr_MASK                  0x00FFFFFFFFFFFFFFL
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__Reserved_MASK                   0xFF00000000000000L
+
+/* MCMP1_IPIDT0 */
+#define MCMP1_IPIDT0__InstanceIdLo__SHIFT                          0x0
+#define MCMP1_IPIDT0__HardwareID__SHIFT                            0x20
+#define MCMP1_IPIDT0__InstanceIdHi__SHIFT                          0x2c
+#define MCMP1_IPIDT0__McaType__SHIFT                               0x30
+
+#define MCMP1_IPIDT0__InstanceIdLo_MASK                            0x00000000FFFFFFFFL
+#define MCMP1_IPIDT0__HardwareID_MASK                              0x00000FFF00000000L
+#define MCMP1_IPIDT0__InstanceIdHi_MASK                            0x0000F00000000000L
+#define MCMP1_IPIDT0__McaType_MASK                                 0xFFFF000000000000L
+
+/* number of umc channel instance with memory map register access */
+#define UMC_V12_0_CHANNEL_INSTANCE_NUM		8
+/* number of umc instance with memory map register access */
+#define UMC_V12_0_UMC_INSTANCE_NUM		4
+
+/* one piece of normalized address is mapped to 8 pieces of physical address */
+#define UMC_V12_0_NA_MAP_PA_NUM        8
+
+/* bank bits in MCA error address */
+#define UMC_V12_0_MCA_B0_BIT 6
+#define UMC_V12_0_MCA_B1_BIT 7
+#define UMC_V12_0_MCA_B2_BIT 8
+#define UMC_V12_0_MCA_B3_BIT 9
+
+/* row bits in MCA address */
+#define UMC_V12_0_MCA_R0_BIT 10
+
+/* Stack ID bits in SOC physical address */
+#define UMC_V12_0_PA_SID1_BIT 37
+#define UMC_V12_0_PA_SID0_BIT 36
+
+/* bank bits in SOC physical address */
+#define UMC_V12_0_PA_B3_BIT 18
+#define UMC_V12_0_PA_B2_BIT 17
+#define UMC_V12_0_PA_B1_BIT 20
+#define UMC_V12_0_PA_B0_BIT 19
+
+/* row bits in SOC physical address */
+#define UMC_V12_0_PA_R13_BIT 35
+#define UMC_V12_0_PA_R12_BIT 34
+#define UMC_V12_0_PA_R11_BIT 33
+#define UMC_V12_0_PA_R10_BIT 32
+#define UMC_V12_0_PA_R9_BIT 31
+#define UMC_V12_0_PA_R8_BIT 30
+#define UMC_V12_0_PA_R7_BIT 29
+#define UMC_V12_0_PA_R6_BIT 28
+#define UMC_V12_0_PA_R5_BIT 27
+#define UMC_V12_0_PA_R4_BIT 26
+#define UMC_V12_0_PA_R3_BIT 25
+#define UMC_V12_0_PA_R2_BIT 24
+#define UMC_V12_0_PA_R1_BIT 23
+#define UMC_V12_0_PA_R0_BIT 22
+
+/* column bits in SOC physical address */
+#define UMC_V12_0_PA_C4_BIT 21
+#define UMC_V12_0_PA_C3_BIT 16
+#define UMC_V12_0_PA_C2_BIT 15
+#define UMC_V12_0_PA_C1_BIT 6
+#define UMC_V12_0_PA_C0_BIT 5
+
+/* channel index bits in SOC physical address */
+#define UMC_V12_0_PA_CH6_BIT 14
+#define UMC_V12_0_PA_CH5_BIT 13
+#define UMC_V12_0_PA_CH4_BIT 12
+#define UMC_V12_0_PA_CH3_BIT 11
+#define UMC_V12_0_PA_CH2_BIT 10
+#define UMC_V12_0_PA_CH1_BIT 9
+#define UMC_V12_0_PA_CH0_BIT 8
+
+/* Pseudochannel index bits in SOC physical address */
+#define UMC_V12_0_PA_PC0_BIT 7
+
+#define UMC_V12_0_NA_C2_BIT 8
+
+#define UMC_V12_0_SOC_PA_TO_SID(pa) \
+	((((pa >> UMC_V12_0_PA_SID0_BIT) & 0x1ULL) << 0ULL) | \
+	 (((pa >> UMC_V12_0_PA_SID1_BIT) & 0x1ULL) << 1ULL))
+
+#define UMC_V12_0_SOC_PA_TO_BANK(pa) \
+	((((pa >> UMC_V12_0_PA_B0_BIT) & 0x1ULL) << 0ULL) | \
+	 (((pa >> UMC_V12_0_PA_B1_BIT) & 0x1ULL) << 1ULL) | \
+	 (((pa >> UMC_V12_0_PA_B2_BIT) & 0x1ULL) << 2ULL) | \
+	 (((pa >> UMC_V12_0_PA_B3_BIT) & 0x1ULL) << 3ULL))
+
+#define UMC_V12_0_SOC_PA_TO_ROW(pa) \
+	((((pa >> UMC_V12_0_PA_R0_BIT) & 0x1ULL) << 0ULL) | \
+	 (((pa >> UMC_V12_0_PA_R1_BIT) & 0x1ULL) << 1ULL) | \
+	 (((pa >> UMC_V12_0_PA_R2_BIT) & 0x1ULL) << 2ULL) | \
+	 (((pa >> UMC_V12_0_PA_R3_BIT) & 0x1ULL) << 3ULL) | \
+	 (((pa >> UMC_V12_0_PA_R4_BIT) & 0x1ULL) << 4ULL) | \
+	 (((pa >> UMC_V12_0_PA_R5_BIT) & 0x1ULL) << 5ULL) | \
+	 (((pa >> UMC_V12_0_PA_R6_BIT) & 0x1ULL) << 6ULL) | \
+	 (((pa >> UMC_V12_0_PA_R7_BIT) & 0x1ULL) << 7ULL) | \
+	 (((pa >> UMC_V12_0_PA_R8_BIT) & 0x1ULL) << 8ULL) | \
+	 (((pa >> UMC_V12_0_PA_R9_BIT) & 0x1ULL) << 9ULL) | \
+	 (((pa >> UMC_V12_0_PA_R10_BIT) & 0x1ULL) << 10ULL) | \
+	 (((pa >> UMC_V12_0_PA_R11_BIT) & 0x1ULL) << 11ULL) | \
+	 (((pa >> UMC_V12_0_PA_R12_BIT) & 0x1ULL) << 12ULL) | \
+	 (((pa >> UMC_V12_0_PA_R13_BIT) & 0x1ULL) << 13ULL))
+
+#define UMC_V12_0_SOC_PA_TO_COL(pa) \
+	((((pa >> UMC_V12_0_PA_C0_BIT) & 0x1ULL) << 0ULL) | \
+	 (((pa >> UMC_V12_0_PA_C1_BIT) & 0x1ULL) << 1ULL) | \
+	 (((pa >> UMC_V12_0_PA_C2_BIT) & 0x1ULL) << 2ULL) | \
+	 (((pa >> UMC_V12_0_PA_C3_BIT) & 0x1ULL) << 3ULL) | \
+	 (((pa >> UMC_V12_0_PA_C4_BIT) & 0x1ULL) << 4ULL))
+
+#define UMC_V12_0_SOC_PA_TO_CH(pa) \
+	((((pa >> UMC_V12_0_PA_CH0_BIT) & 0x1ULL) << 0ULL) | \
+	 (((pa >> UMC_V12_0_PA_CH1_BIT) & 0x1ULL) << 1ULL) | \
+	 (((pa >> UMC_V12_0_PA_CH2_BIT) & 0x1ULL) << 2ULL) | \
+	 (((pa >> UMC_V12_0_PA_CH3_BIT) & 0x1ULL) << 3ULL) | \
+	 (((pa >> UMC_V12_0_PA_CH4_BIT) & 0x1ULL) << 4ULL) | \
+	 (((pa >> UMC_V12_0_PA_CH5_BIT) & 0x1ULL) << 5ULL) | \
+	 (((pa >> UMC_V12_0_PA_CH6_BIT) & 0x1ULL) << 6ULL))
+
+#define UMC_V12_0_SOC_PA_TO_PC(pa) (((pa >> UMC_V12_0_PA_PC0_BIT) & 0x1ULL) << 0ULL)
+
+#define UMC_V12_0_SOC_SID_TO_PA(sid) \
+	((((sid >> 0ULL) & 0x1ULL) << UMC_V12_0_PA_SID0_BIT) | \
+	 (((sid >> 1ULL) & 0x1ULL) << UMC_V12_0_PA_SID1_BIT))
+
+#define UMC_V12_0_SOC_BANK_TO_PA(bank) \
+	((((bank >> 0ULL) & 0x1ULL) << UMC_V12_0_PA_B0_BIT) | \
+	 (((bank >> 1ULL) & 0x1ULL) << UMC_V12_0_PA_B1_BIT) | \
+	 (((bank >> 2ULL) & 0x1ULL) << UMC_V12_0_PA_B2_BIT) | \
+	 (((bank >> 3ULL) & 0x1ULL) << UMC_V12_0_PA_B3_BIT))
+
+#define UMC_V12_0_SOC_ROW_TO_PA(row) \
+	((((row >> 0ULL) & 0x1ULL) << UMC_V12_0_PA_R0_BIT) | \
+	 (((row >> 1ULL) & 0x1ULL) << UMC_V12_0_PA_R1_BIT) | \
+	 (((row >> 2ULL) & 0x1ULL) << UMC_V12_0_PA_R2_BIT) | \
+	 (((row >> 3ULL) & 0x1ULL) << UMC_V12_0_PA_R3_BIT) | \
+	 (((row >> 4ULL) & 0x1ULL) << UMC_V12_0_PA_R4_BIT) | \
+	 (((row >> 5ULL) & 0x1ULL) << UMC_V12_0_PA_R5_BIT) | \
+	 (((row >> 6ULL) & 0x1ULL) << UMC_V12_0_PA_R6_BIT) | \
+	 (((row >> 7ULL) & 0x1ULL) << UMC_V12_0_PA_R7_BIT) | \
+	 (((row >> 8ULL) & 0x1ULL) << UMC_V12_0_PA_R8_BIT) | \
+	 (((row >> 9ULL) & 0x1ULL) << UMC_V12_0_PA_R9_BIT) | \
+	 (((row >> 10ULL) & 0x1ULL) << UMC_V12_0_PA_R10_BIT) | \
+	 (((row >> 11ULL) & 0x1ULL) << UMC_V12_0_PA_R11_BIT) | \
+	 (((row >> 12ULL) & 0x1ULL) << UMC_V12_0_PA_R12_BIT) | \
+	 (((row >> 13ULL) & 0x1ULL) << UMC_V12_0_PA_R13_BIT))
+
+#define UMC_V12_0_SOC_COL_TO_PA(col) \
+	((((col >> 0ULL) & 0x1ULL) << UMC_V12_0_PA_C0_BIT) | \
+	 (((col >> 1ULL) & 0x1ULL) << UMC_V12_0_PA_C1_BIT) | \
+	 (((col >> 2ULL) & 0x1ULL) << UMC_V12_0_PA_C2_BIT) | \
+	 (((col >> 3ULL) & 0x1ULL) << UMC_V12_0_PA_C3_BIT) | \
+	 (((col >> 4ULL) & 0x1ULL) << UMC_V12_0_PA_C4_BIT))
+
+#define UMC_V12_0_SOC_CH_TO_PA(ch) \
+	((((ch >> 0ULL) & 0x1ULL) << UMC_V12_0_PA_CH0_BIT) | \
+	 (((ch >> 1ULL) & 0x1ULL) << UMC_V12_0_PA_CH1_BIT) | \
+	 (((ch >> 2ULL) & 0x1ULL) << UMC_V12_0_PA_CH2_BIT) | \
+	 (((ch >> 3ULL) & 0x1ULL) << UMC_V12_0_PA_CH3_BIT) | \
+	 (((ch >> 4ULL) & 0x1ULL) << UMC_V12_0_PA_CH4_BIT) | \
+	 (((ch >> 5ULL) & 0x1ULL) << UMC_V12_0_PA_CH5_BIT) | \
+	 (((ch >> 6ULL) & 0x1ULL) << UMC_V12_0_PA_CH6_BIT))
+
+#define UMC_V12_0_SOC_PC_TO_PA(pc) (((pc >> 0ULL) & 0x1ULL) << UMC_V12_0_PA_PC0_BIT)
+
+/* bank hash settings */
+#define UMC_V12_0_XOR_EN0 1
+#define UMC_V12_0_XOR_EN1 1
+#define UMC_V12_0_XOR_EN2 1
+#define UMC_V12_0_XOR_EN3 1
+#define UMC_V12_0_COL_XOR0 0x0
+#define UMC_V12_0_COL_XOR1 0x0
+#define UMC_V12_0_COL_XOR2 0x800
+#define UMC_V12_0_COL_XOR3 0x1000
+#define UMC_V12_0_ROW_XOR0 0x11111
+#define UMC_V12_0_ROW_XOR1 0x22222
+#define UMC_V12_0_ROW_XOR2 0x4444
+#define UMC_V12_0_ROW_XOR3 0x8888
+
+/* channel hash settings */
+#define UMC_V12_0_HASH_4K 0
+#define UMC_V12_0_HASH_64K 1
+#define UMC_V12_0_HASH_2M 1
+#define UMC_V12_0_HASH_1G 1
+#define UMC_V12_0_HASH_1T 1
+
+/* XOR some bits of PA into CH4~CH6 bits (bits 12~14 of PA),
+ * hash bit is only effective when related setting is enabled
+ */
+#define UMC_V12_0_CHANNEL_HASH_CH4(channel_idx, pa) ((((channel_idx) >> 5) & 0x1) ^ \
+				(((pa)  >> 20) & 0x1ULL & UMC_V12_0_HASH_64K) ^ \
+				(((pa)  >> 27) & 0x1ULL & UMC_V12_0_HASH_2M) ^ \
+				(((pa)  >> 34) & 0x1ULL & UMC_V12_0_HASH_1G) ^ \
+				(((pa)  >> 41) & 0x1ULL & UMC_V12_0_HASH_1T))
+#define UMC_V12_0_CHANNEL_HASH_CH5(channel_idx, pa) ((((channel_idx) >> 6) & 0x1) ^ \
+				(((pa)  >> 21) & 0x1ULL & UMC_V12_0_HASH_64K) ^ \
+				(((pa)  >> 28) & 0x1ULL & UMC_V12_0_HASH_2M) ^ \
+				(((pa)  >> 35) & 0x1ULL & UMC_V12_0_HASH_1G) ^ \
+				(((pa)  >> 42) & 0x1ULL & UMC_V12_0_HASH_1T))
+#define UMC_V12_0_CHANNEL_HASH_CH6(channel_idx, pa) ((((channel_idx) >> 4) & 0x1) ^ \
+				(((pa)  >> 19) & 0x1ULL & UMC_V12_0_HASH_64K) ^ \
+				(((pa)  >> 26) & 0x1ULL & UMC_V12_0_HASH_2M) ^ \
+				(((pa)  >> 33) & 0x1ULL & UMC_V12_0_HASH_1G) ^ \
+				(((pa)  >> 40) & 0x1ULL & UMC_V12_0_HASH_1T) ^ \
+				(((pa)  >> 47) & 0x1ULL & UMC_V12_0_HASH_1T))
+#define UMC_V12_0_SET_CHANNEL_HASH(channel_idx, pa) do { \
+		(pa) &= ~(0x7ULL << UMC_V12_0_PA_CH4_BIT); \
+		(pa) |= (UMC_V12_0_CHANNEL_HASH_CH4(channel_idx, pa) << UMC_V12_0_PA_CH4_BIT); \
+		(pa) |= (UMC_V12_0_CHANNEL_HASH_CH5(channel_idx, pa) << UMC_V12_0_PA_CH5_BIT); \
+		(pa) |= (UMC_V12_0_CHANNEL_HASH_CH6(channel_idx, pa) << UMC_V12_0_PA_CH6_BIT); \
+	} while (0)
+
+
+/*
+ * (addr / 256) * 4096, the higher 26 bits in ErrorAddr
+ * is the index of 4KB block
+ */
+#define ADDR_OF_4KB_BLOCK(addr)			(((addr) & ~0xffULL) << 4)
+/*
+ * (addr / 256) * 8192, the higher 26 bits in ErrorAddr
+ * is the index of 8KB block
+ */
+#define ADDR_OF_8KB_BLOCK(addr)			(((addr) & ~0xffULL) << 5)
+/*
+ * (addr / 256) * 32768, the higher 26 bits in ErrorAddr
+ * is the index of 8KB block
+ */
+#define ADDR_OF_32KB_BLOCK(addr)			(((addr) & ~0xffULL) << 7)
+/* channel index is the index of 256B block */
+#define ADDR_OF_256B_BLOCK(channel_index)	((channel_index) << 8)
+/* offset in 256B block */
+#define OFFSET_IN_256B_BLOCK(addr)		((addr) & 0xffULL)
+
+
+#define UMC_V12_ADDR_MASK_BAD_COLS(addr) \
+	((addr) & ~((0x3ULL << UMC_V12_0_PA_C2_BIT) | \
+			(0x1ULL << UMC_V12_0_PA_C4_BIT) | \
+			(0x1ULL << UMC_V12_0_PA_R13_BIT)))
+
+#define ACA_IPID_HI_2_UMC_AID(_ipid_hi) (((_ipid_hi) >> 2) & 0x3)
+#define ACA_IPID_LO_2_UMC_CH(_ipid_lo)  \
+	(((((_ipid_lo) >> 20) & 0x1) * 4) + (((_ipid_lo) >> 12) & 0xF))
+#define ACA_IPID_LO_2_UMC_INST(_ipid_lo) (((_ipid_lo) >> 21) & 0x7)
+
+#define ACA_IPID_2_DIE_ID(ipid)  ((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) >> 2) & 0x03)
+#define ACA_IPID_2_UMC_CH(ipid) \
+	(ACA_IPID_LO_2_UMC_CH(REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo)))
+
+#define ACA_IPID_2_UMC_INST(ipid) \
+	(ACA_IPID_LO_2_UMC_INST(REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo)))
+
+#define ACA_IPID_2_SOCKET_ID(ipid) \
+	(((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) | \
+	 (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))
+
+#define ACA_ADDR_2_ERR_ADDR(addr) \
+	REG_GET_FIELD(addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr)
+
+/* R13 bit shift should be considered, double the number */
+#define UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL (UMC_V12_0_NA_MAP_PA_NUM * 2)
+
+
+/* C2, C3, C4, R13, four MCA bits are looped in page retirement */
+#define UMC_V12_0_RETIRE_LOOP_BITS 4
+
+/* invalid node instance value */
+#define UMC_INV_AID_NODE 0xffff
+
+#define UMC_V12_0_AID_NUM_MAX     4
+#define UMC_V12_0_SOCKET_NUM_MAX  8
+
+#define UMC_V12_0_TOTAL_CHANNEL_NUM \
+	(UMC_V12_0_AID_NUM_MAX * UMC_V12_0_UMC_INSTANCE_NUM * UMC_V12_0_CHANNEL_INSTANCE_NUM)
+
+/* one device has 192GB HBM */
+#define SOCKET_LFB_SIZE   0x3000000000ULL
+
+extern const struct ras_umc_ip_func ras_umc_func_v12_0;
+
+int ras_umc_get_badpage_count(struct ras_core_context *ras_core);
+int ras_umc_get_badpage_record(struct ras_core_context *ras_core, uint32_t index, void *record);
+#endif
+
-- 
2.34.1

