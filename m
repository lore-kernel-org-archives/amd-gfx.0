Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D2EC98325
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 17:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE23010F6D7;
	Thu, 24 Sep 2026 17:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cgUDOKhE";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3669C10F6D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 17:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2w+sH2+jah1i/3hji2NFk4AuMuaOWi4GAe3WfBBBCgQUYC3yUFloTsOH483iYNdO64/GL4ecxjfj6t4Gzn3cKIF2xIt6NVW4iBW5GQqnejwINl4eyYnjThFhzSNascrNTJ83s9C1hCn37cNxHO6p14L9hC1WXCm8ySHJoYXSfUXHlSyym/KuEc9Jih3DvLcDVM6Zw5M/5p0YHcxP7EItB6IVFrmG6nf2mvUIn1R92V328W9907kV7ndPB1NcYEsD+Kn7fDz2AU0R+dIDMhlcLZJcpTPEH+YkmQrymR6jHxhEfccnxJ8dpXRahc4WkkqFSHSDzUc3wT4AcroqJF2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNlNUbaBMfyGe5sZUa6MVNZNSVwdGKB/Z40siLxAlqs=;
 b=OyaL3Cq7G2tpPvDMzwEApCc6ioBcpM2SmPQifZsJAjaDCL6uFfFkokPs3UX1hbNix7EOmYAkhdzen9bxD6PsPjBWbO3OTUEvi8kjAdIdPmL8aa2pMtQX14toJFZ2/GsVnG453b/ISRYdUHy9YSHVZZ2kaExoAFIYbhjKiQqrglf/pgusNMMy7jEczrnWGf+XlA+ZZ5jJuLAG7CiuNp8Jngg2bvbqR3r6cqxUbNCF7zv/z480iv+IJGoeSCYABnp9Lp+de/pyPUN88ZivMOfD+MGz+RT3B7UihH45nzBqqkcOfcU6l1Caa2YBnPUOC4ni/nEz6jeluylHq+l0/jbCaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNlNUbaBMfyGe5sZUa6MVNZNSVwdGKB/Z40siLxAlqs=;
 b=cgUDOKhEvQZz2gtGY3ApZAv5G9diHxRmhCMZqfyOezWdnP+tZxIkgYbypozfHuUBBmkDmxOhda4TWQJYJZKxU6NFgFvVTORs337/i/ga77PrmvvZgN1J265nolrhRhAFHiCRsKCTyVFfP/k1L3HrXttmNYq4Jm8aVZWMqbJWk/0=
Received: from BN9PR03CA0247.namprd03.prod.outlook.com (2603:10b6:408:ff::12)
 by SAWPR12MB999139.namprd12.prod.outlook.com (2603:10b6:806:4e0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 17:55:07 +0000
Received: from BN7PEPF00000090.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::a9) by BN9PR03CA0247.outlook.office365.com
 (2603:10b6:408:ff::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Thu,
 24 Sep 2026 17:55:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000090.mail.protection.outlook.com (10.167.245.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 17:55:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:55:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:55:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 12:55:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Gangliang Xie <ganglxie@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/ras: add support for umc v13
Date: Thu, 24 Sep 2026 13:54:38 -0400
Message-ID: <20260924175443.636193-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000090:EE_|SAWPR12MB999139:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3db87e-d471-4d15-3164-08df1a64f7f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|10067099003|56012099006|6133799003|3023799007|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: CYs33O0ZF+HljJtNIsacmLb0zlDjDal8NRB5oIqcC0JO9W++Pjo4KzWShG5aXjV/i66Mvy9/F8kiLzFZo/atDGa3lZbOQ7uJonCBX31Xcbe8iDxMGHp6qIS3HbKOhbd/IIOefTYWshVFFBtIGvXONs5EK4e5oZMwRKcQqd9wnbCs1h0DxXKurMZuUCY5o087LaHRVAWndhgUsyrU/e084gaQAcPvOsel28LCyEqyAEP3xQBSbKhskEa6mmp5M01fWPesxQePdPFk3b1keXglQebV+Y2zFKqGAYHkcVExW/7bt0M2HACN09Be1lMI9UAIvvA8tZ6ENoeXxrqt4AJOVcyG/uoRHfIXGEVCL9Go0LbM1hSqVKrw+Pnw1xcgLXL2Z+tbDsqZMuuTuHwdpj0U2znRmGx+PDUpzAIA9ll8Wra5lMlweAvibFugDQWFrur2H2oJay27xLC+i3Sa9Myofcwo3LqP8RO0SeqElK8OlE4IOTqIO304PmQ9l1pAAKCiWFpJo1Yp4UyxhV6ZtMmEn/cUAf5k7iaYMhT0FVVptnbAPFkpouVQI7/3eIAoloaIJ1aFerTaIahfu7x7AivinBGnftYfS3atCu4jsdMVo9zYxj+CfN5Ra1WoCDkEV4bHFawD/JsN5yop7T+VClZvChuMH1rwjPS5yrEkcHLYfYUVivcTTASfr8wgaATMf2qIroQG/36XCA7vaHGF/iFtVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: po/TexNKN0Tq7O90RBrOw6jveI8dXOovqEB0dLKI88TB3aVgccVJ1ZIDYemNBGlAbSV+rYzkSdOoFt18PF4X0+jT1EGQEk5eejAAt+2HfhZjvtWh46ASpbkNVum13K/9sE795Gowh8lwg9S2S6D/q+jJLTXqEdi1wASliqJWJIgA3593a3VoQV9qnpaamYsuCyKm1DcKwRMPZfxNyS7JI3WDAYGnkbEgaVKlO9KFewxOEWp82mM5BS4+sZB/7uE8paKNnBUKJPYHroQyMzig7VVzSOCx2+Po5vJdz0BQmHvcWuEixCv2qIy+pyC1TTqA21nXseRUHVN9ozl4PJL3bo7zkEA56YpnFiI9PIOlftHGlwSNb7OE6N1bFmeAf6FaK0mZfUqkk7eZx/MSrPjx7/buCohjpFxZMqdmElVNrl3loGKAH3G2zBNYtWOYfoGY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 17:55:06.8302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3db87e-d471-4d15-3164-08df1a64f7f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999139
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

From: Gangliang Xie <ganglxie@amd.com>

add uniras support for umc v13

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/Makefile        |   1 +
 drivers/gpu/drm/amd/ras/core/ras_umc.c       |   4 +
 drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.c | 221 +++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.h |  70 ++++++
 4 files changed, 296 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.h

diff --git a/drivers/gpu/drm/amd/ras/core/Makefile b/drivers/gpu/drm/amd/ras/core/Makefile
index fb16bacaef2fd..2c73d0405a489 100644
--- a/drivers/gpu/drm/amd/ras/core/Makefile
+++ b/drivers/gpu/drm/amd/ras/core/Makefile
@@ -30,6 +30,7 @@ RAS_CORE_FILES = core.o \
 			eeprom.o \
 			ras_umc.o \
 			ras_umc_v12_0.o \
+			ras_umc_v13_0.o \
 			ras_umc_v15_0.o \
 			cmd.o \
 			ras_gfx.o \
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index b3f30da19a78f..aaf98cbee619b 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -24,6 +24,7 @@
 #include "ras.h"
 #include "ras_umc.h"
 #include "ras_umc_v12_0.h"
+#include "ras_umc_v13_0.h"
 #include "ras_umc_v15_0.h"
 
 #define MAX_ECC_NUM_PER_RETIREMENT  16
@@ -80,6 +81,9 @@ static const struct ras_umc_ip_func *ras_umc_get_ip_func(
 	case IP_VERSION(15, 0, 0):
 		ras_umc->max_pages_per_row = 128;
 		return &ras_umc_func_v15_0;
+	case IP_VERSION(13, 1, 0):
+		ras_umc->max_pages_per_row = 128;
+		return &ras_umc_func_v13_0;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
 			"UMC ip version(0x%x) is not supported!\n", ip_version);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.c b/drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.c
new file mode 100644
index 0000000000000..7cb127c6cafdc
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: MIT
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
+#include "ras.h"
+#include "ras_umc.h"
+#include "core_status.h"
+#include "ras_umc_v13_0.h"
+
+static void __get_nps_pa_flip_bits(struct ras_core_context *ras_core,
+			enum umc_memory_partition_mode nps,
+			struct umc_flip_bits *flip_bits)
+{
+
+}
+
+static uint64_t  __get_nps_pa_flip_mask(struct ras_core_context *ras_core,
+		enum umc_memory_partition_mode nps)
+{
+	struct umc_flip_bits flip_bits = {0};
+	uint64_t flip_mask = 0;
+	int i;
+
+	__get_nps_pa_flip_bits(ras_core, nps, &flip_bits);
+
+	for (i = 0; i < flip_bits.bit_num; i++)
+		flip_mask |= BIT_ULL(flip_bits.flip_bits_in_pa[i]);
+
+	return flip_mask;
+}
+
+static int lookup_bad_pages_in_a_row(struct ras_core_context *ras_core,
+		struct eeprom_umc_record *record, uint32_t nps,
+		uint64_t *pfns, uint32_t num,
+		uint64_t seq_no, bool dump)
+{
+	return 0;
+}
+
+static int umc_v13_convert_ma_to_pa(struct ras_core_context *ras_core,
+			struct umc_mca_addr *addr_in, struct umc_phy_addr *addr_out,
+			uint32_t nps)
+{
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
+	ret = ras_umc_psp_translate_addr(ras_core,
+				addr_in, addr_out, nps);
+	if (ret != -EOPNOTSUPP)
+		return ret;
+
+	if (ras_psp_check_supported_cmd(ras_core, RAS_TA_CMD_ID__QUERY_ADDRESS))
+		ret = ras_umc_ras_ta_translate_addr(ras_core,
+				addr_in, addr_out, nps);
+	else
+		ret = umc_v13_convert_ma_to_pa(ras_core,
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
+	addr_in.mca_addr = bank->addr;
+	addr_in.ipid = bank->ipid;
+
+	ret = convert_ma_to_pa(ras_core, &addr_in, &addr_out, nps);
+	if (!ret) {
+		pa_addr->pa_flip_mask = addr_out.pa_flip_mask;
+		pa_addr->pa = addr_out.pa | pa_addr->pa_flip_mask;
+		pa_addr->channel_idx = addr_out.channel_idx;
+		pa_addr->bank = addr_out.bank;
+	}
+
+	return ret;
+}
+
+static int umc_v13_0_bank_to_eeprom_record(struct ras_core_context *ras_core,
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
+	/* If the bank being converted already has a timestamp,
+	 * then use the bank's timestamp.
+	 */
+	if (bank->timestamp)
+		record->ts = bank->timestamp;
+
+	lookup_bad_pages_in_a_row(ras_core, record,
+		bank->nps, NULL, 0, bank->seq_no, true);
+
+	return 0;
+}
+
+static int convert_eeprom_record_to_nps_addr(struct ras_core_context *ras_core,
+	struct eeprom_umc_record *record, uint64_t *pa, uint64_t *pa_flip_mask, uint32_t nps)
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
+	*pa_flip_mask = addr_out.pa_flip_mask;
+	*pa = addr_out.pa | addr_out.pa_flip_mask;
+
+	return 0;
+}
+
+static int umc_v13_0_eeprom_record_to_nps_record(struct ras_core_context *ras_core,
+				struct eeprom_umc_record *record, uint32_t nps)
+{
+	uint64_t pa = 0, flip_mask = 0;
+	uint64_t row_pfn;
+	int ret = 0;
+
+	if (nps == EEPROM_RECORD_UMC_NPS_MODE(record)) {
+		record->cur_nps_pa_flip_mask = __get_nps_pa_flip_mask(ras_core, nps);
+		row_pfn = EEPROM_RECORD_UMC_ADDR_PFN(record);
+		record->cur_nps_retired_row_pfn =
+			RAS_ADDR_TO_PFN(RAS_PFN_TO_ADDR(row_pfn) | record->cur_nps_pa_flip_mask);
+	} else {
+		ret = convert_eeprom_record_to_nps_addr(ras_core,
+				record, &pa, &flip_mask, nps);
+		if (!ret) {
+			record->cur_nps_retired_row_pfn = RAS_ADDR_TO_PFN(pa);
+			record->cur_nps_pa_flip_mask = flip_mask;
+		}
+	}
+
+	record->cur_nps = nps;
+
+	return ret;
+}
+
+static int umc_v13_0_soc_pa_to_bank(struct ras_core_context *ras_core,
+			uint64_t soc_pa,
+			struct umc_bank_addr *bank_addr)
+{
+	return 0;
+}
+
+static int umc_v13_0_bank_to_soc_pa(struct ras_core_context *ras_core,
+			struct umc_bank_addr bank_addr,
+			uint64_t *soc_pa)
+{
+	return 0;
+}
+
+const struct ras_umc_ip_func ras_umc_func_v13_0 = {
+	.bank_to_eeprom_record = umc_v13_0_bank_to_eeprom_record,
+	.eeprom_record_to_nps_record = umc_v13_0_eeprom_record_to_nps_record,
+	.bank_to_soc_pa = umc_v13_0_bank_to_soc_pa,
+	.soc_pa_to_bank = umc_v13_0_soc_pa_to_bank,
+};
+
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.h b/drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.h
new file mode 100644
index 0000000000000..35b2080473747
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v13_0.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: MIT */
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
+#ifndef __RAS_UMC_V13_0_H__
+#define __RAS_UMC_V13_0_H__
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
+/* invalid node instance value */
+#define UMC_INV_AID_NODE 0xffff
+
+extern const struct ras_umc_ip_func ras_umc_func_v13_0;
+
+#endif
+
-- 
2.55.0

