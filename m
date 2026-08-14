Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C94CC5DF72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA25A10F750;
	Fri, 14 Aug 2026 21:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tCtSoqgc";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013048.outbound.protection.outlook.com
 [40.107.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E6110F701
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRD3QtBKIELEOuDB9BW/jLFcCqHtK260L66OTTa6XSGLZKrgO+In1jVswtKCYYAyjrbsqsDBqiDygXrgFAX2tzH/uoQ4z+d6QwvqDDCY6F3UinTWuS7XfQ0OojM8jqQWcsS9g2gJW6SHU/jrZI6gxCrDN15iOrP4d28lQ0LDl11OPNMaLQ9TGK45L4k4vKj0tLPueqnXXEPu+1VYT5qKiRte+fhiatN2djU1k6h9L0xly/chDc/lzVWwWge6WY7iKWD2vMWhXUl3tfFePOo/LWTJOJ6jh7sO+e9vvYKxPbabT4I1Z9aVqUwefyAtLr8/ZMy3gJ9Ew2QM5PzPAglFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vj8iADe+y3YQGF8VTir6hlADny7TsEMLFe7lDGCE5l8=;
 b=CDNzU93w1AlbxV67OyhIrgfo9d/NsaF7oNkAE2uKf3z0+Am+kpTcRRycvbazWrsWvh4XKAlNm81ELDQL87yPRrD6p8z2PO07rq15WF+bVLh3FR44792mXzFC1PZFGk/2TXJE+mmVc0QqBbWkYfVCjKLRmJmMdxMzj/mm6G39f4uDe7R91fLUlEds7OlJ6MR6uLfccgSSbF5I3ouS94l+NjVeEdZ3/qGpLEfoLlCYvV7LkrHinK1DyjpoG/DMvkYseg8JU+sTw6aggW8vEDBPHd/NKhRi+PKdmTlbPqtFkOuEaXGtlPTLufUDlGqeeBn+W9XBgVK4nDmPtvpuTlGnBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vj8iADe+y3YQGF8VTir6hlADny7TsEMLFe7lDGCE5l8=;
 b=tCtSoqgcWXwZ834y13nQmqiO665z2QmLKzkLK6kxfeJa9JqquwUN9D1A5hhW0NWiv6IwrezJvQXETPKa9ub2yNLmfIAC5Y9t9+bpQJGXyKonVtZCYdyDVTdDEnp2Klm33dbLRLUigI5cAvuC86qy30hU0dvf+f9jHs9+77m1XZA=
Received: from CH0PR04CA0008.namprd04.prod.outlook.com (2603:10b6:610:76::13)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:42 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:76:cafe::30) by CH0PR04CA0008.outlook.office365.com
 (2603:10b6:610:76::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:38 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 068/109] drm/amd/ras: add address translation interface for
 umc_v15_0
Date: Fri, 14 Aug 2026 17:02:05 -0400
Message-ID: <20260814210246.3067612-69-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 3907f773-bd6c-4c89-9737-08defa478567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|3023799007|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DTIpSoNDsbhLrLbRoP7Sfk1ICTxt5eGCryVXnVTZw1wXaoLz6ZnEr/r2v+P7wk87Ko0NYMBjKV4wfwG69eo5ugY2fBKv94oI0l1VapexqIeD5ytNcHG2+uav3/J6tS//S9Q17dol7mkiW0EEfh+xiutVhb37B/boJTH/PnUwmZCq7uZjcdfJdOoc8Ad3/n+XHNg2kgKcUVm8Kn7cQORC8c1O2yhB0feqssf4RKPa4NPgn4HqWc77ZxkDaCeCyRHqrTL95+nKRqRJ3qQG51x6q/sDIcY84Oj5sLuzOPqFRkjm0uHI3z4DQpevqXkHdqQrY1tqAxzLmLneTCEXp3Q/AqnDhVZhTFIcMPr1FPBOITdzooTTFoVo1DvSN+bAqcxSQmiqfDAPX2VM5/o7VlQi3jX6um6nVBw7u8XyXONvWfO60BahnmbFddgGis9FPPoYIy8neljUlyn5WV4t1KDZvnirjxe6NA5NlSmYS3YE5g8J1m5uzhiF0yX5ZR2k1Mg0h9xduym5/FIQI9siDdoqQy41KHSEzV8wIni9pKMlkXKFvVo9qU0faruCHKD6s1IzJRXu36y3Crpy0qVcxKkNB0CDhuwOe/adiUixofw+D8CiZ9oeax2Xjm5L3PlpuabP6BDTMAX9xd2kzzX4HYkPwNwCxl09Ths4SsVj9Nl8lW4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(3023799007)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2T3IVQr7wk6bUlXdymEc1gGRdnCmU3EIxrQHkmekzCT6eOZuA5RyoGztlNVEbaE6jlFgKj/N902Twz7YotnfEkWwMtHLGZL+70+xwrnKEVGvqhxtwIGAXzVT29JwPGNFg5p0ByAFTsv38iSFl0PAsA5OAYcYq+YvJKPNfGv5ULPWkRlxgeuiMeoFV25FKHrIqj2hvl3SXRWrs8jykiJ5lBz2fKZOEMD25UkjNpw/h2sRX4Y6IP5uDB7w4uV/cJMtFJ0ztKHzf7cO2NyDpg7H6/6DnavCm49SZQPSWboO8gsIB9x9WcV3aIBMyWTkjX54khvnTcUmY69dREMerGmj95r2LZNFxUI0QugfqrR7CWK+QwHxPkggrdwGxh+6DY2w3u2k34ilzw6ySLNhiyhPP1CwjuPeiZfJrHrs9dYHHnSB31DoEUrOzp+Dqx1wrMqw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:42.0707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3907f773-bd6c-4c89-9737-08defa478567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add address translation interface for umc_v15_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/Makefile        |   1 +
 drivers/gpu/drm/amd/ras/core/ras_umc.c       |   4 +-
 drivers/gpu/drm/amd/ras/core/ras_umc.h       |   2 +
 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c | 220 +++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.h |  69 ++++++
 5 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.h

diff --git a/drivers/gpu/drm/amd/ras/core/Makefile b/drivers/gpu/drm/amd/ras/core/Makefile
index 980ae48b1ab8e..def5fbb2a49e6 100644
--- a/drivers/gpu/drm/amd/ras/core/Makefile
+++ b/drivers/gpu/drm/amd/ras/core/Makefile
@@ -30,6 +30,7 @@ RAS_CORE_FILES = core.o \
 			eeprom.o \
 			ras_umc.o \
 			ras_umc_v12_0.o \
+			ras_umc_v15_0.o \
 			cmd.o \
 			ras_gfx.o \
 			ras_gfx_v9_0.o \
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index 32203e85ef14b..d78b111b87852 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -24,6 +24,7 @@
 #include "ras.h"
 #include "ras_umc.h"
 #include "ras_umc_v12_0.h"
+#include "ras_umc_v15_0.h"
 
 #define MAX_ECC_NUM_PER_RETIREMENT  16
 
@@ -72,8 +73,9 @@ static const struct ras_umc_ip_func *ras_umc_get_ip_func(
 	switch (ip_version) {
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 5, 0):
-	case IP_VERSION(15, 0, 0):
 		return &ras_umc_func_v12_0;
+	case IP_VERSION(15, 0, 0):
+		return &ras_umc_func_v15_0;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
 			"UMC ip version(0x%x) is not supported!\n", ip_version);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.h b/drivers/gpu/drm/amd/ras/core/ras_umc.h
index 5b7b497503927..725f74740ead9 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.h
@@ -128,6 +128,8 @@ struct ras_umc_ip_func {
 	int (*eeprom_record_to_nps_pages)(struct ras_core_context *ras_core,
 			struct eeprom_umc_record *record, uint32_t nps,
 			uint64_t *pfns, uint32_t num);
+	int (*eeprom_record_to_nps_record)(struct ras_core_context *ras_core,
+			struct eeprom_umc_record *record, uint32_t nps);
 	int (*bank_to_soc_pa)(struct ras_core_context *ras_core,
 			struct umc_bank_addr bank_addr, uint64_t *soc_pa);
 	int (*soc_pa_to_bank)(struct ras_core_context *ras_core,
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c b/drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c
new file mode 100644
index 0000000000000..0f3182b14dae9
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c
@@ -0,0 +1,220 @@
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
+#include "ras_umc_v15_0.h"
+
+static void __get_nps_pa_flip_bits(struct ras_core_context *ras_core,
+			enum umc_memory_partition_mode nps,
+			struct umc_flip_bits *flip_bits)
+{
+
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
+	return 0;
+}
+
+static int umc_v15_convert_ma_to_pa(struct ras_core_context *ras_core,
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
+	if (ras_psp_check_supported_cmd(ras_core, RAS_TA_CMD_ID__QUERY_ADDRESS))
+		ret = ras_umc_psp_ma2pa(ras_core,
+				addr_in, addr_out, nps);
+	else
+		ret = umc_v15_convert_ma_to_pa(ras_core,
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
+static int umc_v15_0_bank_to_eeprom_record(struct ras_core_context *ras_core,
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
+static int umc_v15_0_eeprom_record_to_nps_record(struct ras_core_context *ras_core,
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
+static int umc_v15_0_eeprom_record_to_nps_pages(struct ras_core_context *ras_core,
+			struct eeprom_umc_record *record, uint32_t nps,
+			uint64_t *pfns, uint32_t num)
+{
+	return lookup_bad_pages_in_a_row(ras_core,
+				record, nps, pfns, num, 0, false);
+}
+
+static int umc_v15_0_soc_pa_to_bank(struct ras_core_context *ras_core,
+			uint64_t soc_pa,
+			struct umc_bank_addr *bank_addr)
+{
+	return 0;
+}
+
+static int umc_v15_0_bank_to_soc_pa(struct ras_core_context *ras_core,
+			struct umc_bank_addr bank_addr,
+			uint64_t *soc_pa)
+{
+	return 0;
+}
+
+const struct ras_umc_ip_func ras_umc_func_v15_0 = {
+	.bank_to_eeprom_record = umc_v15_0_bank_to_eeprom_record,
+	.eeprom_record_to_nps_record = umc_v15_0_eeprom_record_to_nps_record,
+	.eeprom_record_to_nps_pages = umc_v15_0_eeprom_record_to_nps_pages,
+	.bank_to_soc_pa = umc_v15_0_bank_to_soc_pa,
+	.soc_pa_to_bank = umc_v15_0_soc_pa_to_bank,
+};
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.h b/drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.h
new file mode 100644
index 0000000000000..5c3a79a48ec00
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.h
@@ -0,0 +1,69 @@
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
+#ifndef __RAS_UMC_V15_0_H__
+#define __RAS_UMC_V15_0_H__
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
+extern const struct ras_umc_ip_func ras_umc_func_v15_0;
+
+#endif
-- 
2.55.0

