Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EDCC55174
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 03:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC3310E39D;
	Mon,  3 Aug 2026 03:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T5BLPPow";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB66410E39D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 03:38:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IX5/eJ+IqlhBJZgWgPOD3iy3CPJGMxcsimGr8ZX2uXEM6eJEBQL9c1BJ6Mnq1fe+CP1M0r3FNY3ZMfZOGlH2uQovZ18egfbrO54fpDjRLn13RC0K9KQEjZp8xwe3d8+p6rQMjj/6gSRJPhaNN5RwTMyu6pwXF3HhvfIE88jeR1+1dH7Hwk2f2cMHO6nyBn13qvN+45PxqU9i3hj+F/avGB+Z1U546Cz/w1/B2nK/JTjrpofjdNiwdFnSSwF2Zc6ACsrUzs+Z2B33ZxqmA8yqLjqvxyF+yKMLXVtuC8EhAoLsEFPyI6E3ZL65guqBD1TAwg3S7oiTn5TitPZThMnUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swrhdlxRhldlmeqc0TRWRoF0u3G0Yw3Dj2u68oNs8FM=;
 b=ZUNEWaVGyCewdgQ5ar8fZ3UtEDKk79F/h0zxOiQihe0D+l8lbg56RZcXkGPiYGiEcoF5xi1AV4g2Gu7fiL4RunG73TU2gNwyNwp7TjjFQDi60e2CfdKWLkpPN53rnd1LKI+qeSh10slVVNVPQy3LUtp6uZIbvsLgLPPBSAE03PoucYLQWgXA20eehZkcGN4rIVnDg8Oka+U5ET4SvjC3HUM+IkD47gLrCKW9lGuLsN/slKjjwuPPgVSnuh8thKTp1ylV7uMtbxJ2q0T3utEK4500htZxx3g9TamuYxOPagwMzHuCw4t/8aAsnVCfaWPXv2aKSTju0/eSIHlbFJjybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swrhdlxRhldlmeqc0TRWRoF0u3G0Yw3Dj2u68oNs8FM=;
 b=T5BLPPowOB6GWq3WJ/hObjd/NMztpfgrbIFP9iOUZOxLkkDno17eSQattgOrqBN0PUjQ0vioLPgYlIgXTI0ebXy9Mk4vL01vbILyzeU+JBZTb1vXiNtmt3DVZU2lz5KDvh8oPfmSKM8SIg2vlyblq3tsiqWGtpA1QMvDaVt7nro=
Received: from BL1PR13CA0412.namprd13.prod.outlook.com (2603:10b6:208:2c2::27)
 by LV3PR12MB9403.namprd12.prod.outlook.com (2603:10b6:408:217::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 03:38:18 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::59) by BL1PR13CA0412.outlook.office365.com
 (2603:10b6:208:2c2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.12 via Frontend Transport; Mon, 3
 Aug 2026 03:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 03:38:17 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 2 Aug
 2026 22:38:16 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/3] drm/amd/ras: move some umc v12 specific functions to
 ras_umc.c
Date: Mon, 3 Aug 2026 11:38:04 +0800
Message-ID: <20260803033806.2881888-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|LV3PR12MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb93ebe-9676-430e-0d71-08def110a81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|11063799006|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 61fcTcffIypQT5EwXz9GijqSuVxGtsyTkHZrepE4syd6a3qM8Q8SCs3VaJBhPniSlLDOqyBgHExBNkwJrZ1HRo0gelNlKtGIyHNyTnghVaEev802WiEgbd3Vgxz9zdCb8blPlSm/pXzcpivF2L/i24Jg5AmhyfW/TmRTIuPwX27tBPZ5MXJAKQajm32oW0lRrFAGGcYYrfypKczDryeQz4p6tPTZN/U0uxUUZ67NUcgOX+wn92IQAfrRcBh1xR0AE4JkUBzWmnSRuVL7t86cEPjijqtKmGugyOrtjaROVhp/hkA8mu4vmk9vT3cWxYGSO0gAHJPEpdhOpTw2umbNk0w6r/QwU57Lt2l8DCVHiD97G0Aeglk3TyYFds+mGAYuj+RdCkFd+Xhx7lXkaaSD0jEJagUFB/rnKqMwxXPdOrmi/Pk7Wb9gBBxgmHmuIukZ+BStLkUcxxk6WFOZLmsmOiTL8Kofj5D0xjVmXU0UgjzgGMxC2+glhYRTJwgi1AAfYVcwp+sn6LzUBgxQ0qHMPE9BuZpk8+tAfgDLqjo6wtuqPIoyz67aNongNCQ+K/LOhMzSpPy7b/lfMNs6ITQsUz8D8nMpGPHF8B1XWFWjJEkfNMkLynN2tRZsjxaD1xGOQhTUiJ4x3WLEVAO8dhNsFZChrLn8/GKkRREFvac6yVxSN4NckXVkUwImnZuMLTz65ZiUSdsz+xt0XBQHyT5r/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tUb3blKwV2sWRa74GDdDp/gk5hX0iPMlsux7JIjEJ6gqT1TCvUu3LXHC7xQ02kg+Ir4aEunIQd1ME2g8d0qf7cXOa0Z7CUb/irBcIUPfGGvfmzq+RXpOHJMOs1VRttw7tKvf3SUeOGO/WUPRchYW3BxjBR57tVPP2YCWPKaFhXKCauTTr61XbvnXNhVzaXfd9OOzKiF/xrRNUqJcvY9qvgD8zrsNQHxP1jzg8TXq4O5DD4WeTUk5yLpcZ/rMiMscVsM3rInO2GgItteQ+q0WtzxIMyI7s1RWT3XAm5mLmID3sCERhjWJ9mW59dIQ6IpHrM0QBQFfXsDTiA0qd9Zd6hUCuOEk9gQPQrPZfohUhf0BhWLgdX5HnHnJX9jgjFcAoHFm6eM/P40S16H4D/177AzzU5i1/9wHyii11wRg52gJWfCKJHoz24H8SUsDw9vL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 03:38:17.4973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb93ebe-9676-430e-0d71-08def110a81c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9403
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

So we can reuse these functions across different ASICs.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 101 +++++++++++++--
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h     |  13 +-
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   | 118 +++---------------
 3 files changed, 119 insertions(+), 113 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index f59f0b6cad06..b8e3a92ab174 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -82,7 +82,7 @@ static const struct ras_umc_ip_func *ras_umc_get_ip_func(
 	return NULL;
 }
 
-int ras_umc_psp_convert_ma_to_pa(struct ras_core_context *ras_core,
+int ras_umc_psp_ma2pa(struct ras_core_context *ras_core,
 		struct umc_mca_addr *in, struct umc_phy_addr *out,
 		uint32_t nps)
 {
@@ -307,6 +307,83 @@ int ras_umc_log_bad_bank(struct ras_core_context *ras_core, struct ras_bank_ecc
 	return ret;
 }
 
+int ras_umc_ma2pa(struct ras_core_context *ras_core,
+	struct umc_mca_addr *addr_in, struct umc_phy_addr *addr_out,
+	uint32_t nps)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	int ret;
+
+	if (ras_psp_check_supported_cmd(ras_core, RAS_TA_CMD_ID__QUERY_ADDRESS))
+		ret = ras_umc_psp_ma2pa(ras_core, addr_in, addr_out, nps);
+	else
+		ret = ras_umc->ip_func->ma2pa(ras_core, addr_in,
+				addr_out, nps);
+
+	return ret;
+}
+
+static int ras_umc_eeprom_rec2nps_addr(struct ras_core_context *ras_core,
+	struct eeprom_umc_record *record, uint64_t *pa, uint32_t nps)
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
+	ret = ras_umc_ma2pa(ras_core, &addr_in, &addr_out, nps);
+	if (ret)
+		return ret;
+
+	*pa = ras_core->ras_umc.ip_func->nps_pa_to_row_pa(ras_core, addr_out.pa, nps, false);
+
+	return 0;
+}
+
+static int ras_umc_eeprom_rec2nps_rec(struct ras_core_context *ras_core,
+	struct eeprom_umc_record *record, uint32_t nps)
+{
+	uint64_t ch_idx_v2, pa = 0;
+	uint32_t save_nps;
+	int ret = 0;
+
+	save_nps = EEPROM_RECORD_UMC_NPS_MODE(record);
+	/* eeprom v2 has no stored nps, always convert if the flag is set */
+	ch_idx_v2 = record->retired_row_pfn & UMC_CHANNEL_IDX_V2;
+
+	if (save_nps || ch_idx_v2) {
+		if ((nps == save_nps) && !ras_fw_eeprom_supported(ras_core)) {
+			record->cur_nps_retired_row_pfn =
+				EEPROM_RECORD_UMC_ADDR_PFN(record);
+		} else {
+			ret = ras_umc_eeprom_rec2nps_addr(ras_core, record, &pa, nps);
+			if (!ret)
+				record->cur_nps_retired_row_pfn = RAS_ADDR_TO_PFN(pa);
+		}
+	} else {
+		/* old eeprom data format, the scope of channel index is
+		 * limited to umc instance
+		 */
+		/* TODO */
+		ret = -EOPNOTSUPP;
+	}
+
+	record->cur_nps = nps;
+
+	return ret;
+}
+
 static int ras_umc_get_new_records(struct ras_core_context *ras_core,
 			struct eeprom_umc_record *records, u32 num)
 {
@@ -343,12 +420,11 @@ static bool ras_umc_check_retired_record(struct ras_core_context *ras_core,
 
 	if (from_eeprom) {
 		nps = ras_umc->umc_err_data.umc_nps_mode;
-		if (ras_umc->ip_func && ras_umc->ip_func->eeprom_record_to_nps_record) {
-			ret = ras_umc->ip_func->eeprom_record_to_nps_record(ras_core, record, nps);
-			if (ret)
-				RAS_DEV_WARN_RATELIMITED(ras_core->dev,
-					"Failed to adjust eeprom record, ret:%d", ret);
-		}
+		ret = ras_umc_eeprom_rec2nps_rec(ras_core, record, nps);
+		if (ret)
+			RAS_DEV_WARN_RATELIMITED(ras_core->dev,
+				"Failed to adjust eeprom record, ret:%d", ret);
+
 		return false;
 	}
 
@@ -805,3 +881,14 @@ int ras_umc_translate_soc_pa_and_bank(struct ras_core_context *ras_core,
 
 	return ret;
 }
+
+bool ras_umc_bit_wise_xor(uint32_t val)
+{
+	bool result = 0;
+	int i;
+
+	for (i = 0; i < 32; i++)
+		result = result ^ ((val >> i) & 0x1);
+
+	return result;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
index 3d902b0d663a..9d32ac344316 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -119,8 +119,6 @@ struct umc_bank_addr {
 struct ras_umc_ip_func {
 	int (*bank_to_eeprom_record)(struct ras_core_context *ras_core,
 			struct ras_bank_ecc *bank, struct eeprom_umc_record *record);
-	int (*eeprom_record_to_nps_record)(struct ras_core_context *ras_core,
-			struct eeprom_umc_record *record, uint32_t nps);
 	int (*eeprom_record_to_nps_pages)(struct ras_core_context *ras_core,
 			struct eeprom_umc_record *record, uint32_t nps,
 			uint64_t *pfns, uint32_t num);
@@ -130,6 +128,11 @@ struct ras_umc_ip_func {
 			uint64_t soc_pa, struct umc_bank_addr *bank_addr);
 	void (*mca_ipid_parse)(struct ras_core_context *ras_core, uint64_t ipid,
 			uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid);
+	int (*ma2pa)(struct ras_core_context *ras_core,
+		struct umc_mca_addr *addr_in, struct umc_phy_addr *addr_out,
+		uint32_t nps);
+	uint64_t (*nps_pa_to_row_pa)(struct ras_core_context *ras_core,
+		uint64_t pa, enum umc_memory_partition_mode nps, bool zero_pfn_ok);
 };
 
 struct eeprom_store_record {
@@ -184,7 +187,7 @@ int ras_umc_sw_init(struct ras_core_context *ras);
 int ras_umc_sw_fini(struct ras_core_context *ras);
 int ras_umc_hw_init(struct ras_core_context *ras);
 int ras_umc_hw_fini(struct ras_core_context *ras);
-int ras_umc_psp_convert_ma_to_pa(struct ras_core_context *ras_core,
+int ras_umc_psp_ma2pa(struct ras_core_context *ras_core,
 		struct umc_mca_addr *in, struct umc_phy_addr *out,
 		uint32_t nps);
 int ras_umc_handle_bad_pages(struct ras_core_context *ras_core, void *data);
@@ -207,4 +210,8 @@ int ras_umc_translate_soc_pa_and_bank(struct ras_core_context *ras_core,
 int ras_umc_convert_record_to_nps_pages(struct ras_core_context *ras_core,
 		struct eeprom_umc_record *record, uint32_t nps,
 		uint64_t *page_pfn, uint32_t max_pages);
+bool ras_umc_bit_wise_xor(uint32_t val);
+int ras_umc_ma2pa(struct ras_core_context *ras_core,
+	struct umc_mca_addr *addr_in, struct umc_phy_addr *addr_out,
+	uint32_t nps);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index 6bf30dee8d17..73eb1dba16ec 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -48,17 +48,6 @@ static const uint32_t umc_v12_0_ma2na_mapping[] = {
 	24, 7,  29, 30,
 };
 
-static bool umc_v12_0_bit_wise_xor(uint32_t val)
-{
-	bool result = 0;
-	int i;
-
-	for (i = 0; i < 32; i++)
-		result = result ^ ((val >> i) & 0x1);
-
-	return result;
-}
-
 static void __get_nps_pa_flip_bits(struct ras_core_context *ras_core,
 			enum umc_memory_partition_mode nps,
 			struct umc_flip_bits *flip_bits)
@@ -159,7 +148,7 @@ static void __get_nps_pa_flip_bits(struct ras_core_context *ras_core,
 	}
 }
 
-static uint64_t  convert_nps_pa_to_row_pa(struct ras_core_context *ras_core,
+static uint64_t  umc_v12_0_nps_pa_to_row_pa(struct ras_core_context *ras_core,
 		uint64_t pa, enum umc_memory_partition_mode nps, bool zero_pfn_ok)
 {
 	struct umc_flip_bits flip_bits = {0};
@@ -193,7 +182,7 @@ static int lookup_bad_pages_in_a_row(struct ras_core_context *ras_core,
 
 	__get_nps_pa_flip_bits(ras_core, nps, &flip_bits);
 
-	row_pa = convert_nps_pa_to_row_pa(ras_core, retired_addr, nps, true);
+	row_pa = umc_v12_0_nps_pa_to_row_pa(ras_core, retired_addr, nps, true);
 
 	err_addr = record->address;
 	/* get column bit 0 and 1 in mca address */
@@ -240,7 +229,7 @@ static int lookup_bad_pages_in_a_row(struct ras_core_context *ras_core,
 	return idx;
 }
 
-static int umc_v12_convert_ma_to_pa(struct ras_core_context *ras_core,
+static int umc_v12_ma2pa(struct ras_core_context *ras_core,
 			struct umc_mca_addr *addr_in, struct umc_phy_addr *addr_out,
 			uint32_t nps)
 {
@@ -277,20 +266,20 @@ static int umc_v12_convert_ma_to_pa(struct ras_core_context *ras_core,
 	/* apply bank hash algorithm */
 	bank0 =
 		bank_hash0 ^ (UMC_V12_0_XOR_EN0 &
-		(umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR0) ^
-		(umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR0))));
+		(ras_umc_bit_wise_xor(col & UMC_V12_0_COL_XOR0) ^
+		(ras_umc_bit_wise_xor(row & UMC_V12_0_ROW_XOR0))));
 	bank1 =
 		bank_hash1 ^ (UMC_V12_0_XOR_EN1 &
-		(umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR1) ^
-		(umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR1))));
+		(ras_umc_bit_wise_xor(col & UMC_V12_0_COL_XOR1) ^
+		(ras_umc_bit_wise_xor(row & UMC_V12_0_ROW_XOR1))));
 	bank2 =
 		bank_hash2 ^ (UMC_V12_0_XOR_EN2 &
-		(umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR2) ^
-		(umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR2))));
+		(ras_umc_bit_wise_xor(col & UMC_V12_0_COL_XOR2) ^
+		(ras_umc_bit_wise_xor(row & UMC_V12_0_ROW_XOR2))));
 	bank3 =
 		bank_hash3 ^ (UMC_V12_0_XOR_EN3 &
-		(umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR3) ^
-		(umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR3))));
+		(ras_umc_bit_wise_xor(col & UMC_V12_0_COL_XOR3) ^
+		(ras_umc_bit_wise_xor(row & UMC_V12_0_ROW_XOR3))));
 
 	bank = bank0 | (bank1 << 1) | (bank2 << 2) | (bank3 << 3);
 	err_addr &= ~0x3c0ULL;
@@ -360,22 +349,6 @@ static int umc_v12_convert_ma_to_pa(struct ras_core_context *ras_core,
 	return 0;
 }
 
-static int convert_ma_to_pa(struct ras_core_context *ras_core,
-			struct umc_mca_addr *addr_in, struct umc_phy_addr *addr_out,
-			uint32_t nps)
-{
-	int ret;
-
-	if (ras_psp_check_supported_cmd(ras_core, RAS_TA_CMD_ID__QUERY_ADDRESS))
-		ret = ras_umc_psp_convert_ma_to_pa(ras_core,
-				addr_in, addr_out, nps);
-	else
-		ret = umc_v12_convert_ma_to_pa(ras_core,
-				addr_in, addr_out, nps);
-
-	return ret;
-}
-
 static int convert_bank_to_nps_addr(struct ras_core_context *ras_core,
 			struct ras_bank_ecc *bank, struct umc_phy_addr *pa_addr, uint32_t nps)
 {
@@ -392,10 +365,10 @@ static int convert_bank_to_nps_addr(struct ras_core_context *ras_core,
 	addr_in.node_inst = ACA_IPID_2_DIE_ID(bank->ipid);
 	addr_in.socket_id = ACA_IPID_2_SOCKET_ID(bank->ipid);
 
-	ret = convert_ma_to_pa(ras_core, &addr_in, &addr_out, nps);
+	ret = ras_umc_ma2pa(ras_core, &addr_in, &addr_out, nps);
 	if (!ret) {
 		pa_addr->pa =
-			convert_nps_pa_to_row_pa(ras_core, addr_out.pa, nps, false);
+			umc_v12_0_nps_pa_to_row_pa(ras_core, addr_out.pa, nps, false);
 		pa_addr->channel_idx = addr_out.channel_idx;
 		pa_addr->bank = addr_out.bank;
 	}
@@ -429,68 +402,6 @@ static int umc_v12_0_bank_to_eeprom_record(struct ras_core_context *ras_core,
 	return 0;
 }
 
-static int convert_eeprom_record_to_nps_addr(struct ras_core_context *ras_core,
-			struct eeprom_umc_record *record, uint64_t *pa, uint32_t nps)
-{
-	struct device_system_info dev_info = {0};
-	struct umc_mca_addr addr_in;
-	struct umc_phy_addr addr_out;
-	int ret;
-
-	memset(&addr_in, 0, sizeof(addr_in));
-	memset(&addr_out, 0, sizeof(addr_out));
-
-	ras_core_get_device_system_info(ras_core, &dev_info);
-
-	addr_in.err_addr = record->address;
-	addr_in.ch_inst = record->mem_channel;
-	addr_in.umc_inst = record->mcumc_id;
-	addr_in.node_inst = UMC_INV_AID_NODE;
-	addr_in.socket_id = dev_info.socket_id;
-
-	ret = convert_ma_to_pa(ras_core, &addr_in, &addr_out, nps);
-	if (ret)
-		return ret;
-
-	*pa = convert_nps_pa_to_row_pa(ras_core, addr_out.pa, nps, false);
-
-	return 0;
-}
-
-static int umc_v12_0_eeprom_record_to_nps_record(struct ras_core_context *ras_core,
-				struct eeprom_umc_record *record, uint32_t nps)
-{
-	uint64_t ch_idx_v2, pa = 0;
-	uint32_t save_nps;
-	int ret = 0;
-
-	save_nps = EEPROM_RECORD_UMC_NPS_MODE(record);
-	/* eeprom v2 has no stored nps, always convert if the flag is set */
-	ch_idx_v2 = record->retired_row_pfn & UMC_CHANNEL_IDX_V2;
-
-	if (save_nps || ch_idx_v2) {
-		if ((nps == save_nps) && !ras_fw_eeprom_supported(ras_core)) {
-			record->cur_nps_retired_row_pfn =
-				EEPROM_RECORD_UMC_ADDR_PFN(record);
-		} else {
-			ret = convert_eeprom_record_to_nps_addr(ras_core,
-				record, &pa, nps);
-			if (!ret)
-				record->cur_nps_retired_row_pfn = RAS_ADDR_TO_PFN(pa);
-		}
-	} else {
-		/* old eeprom data format, the scope of channel index is
-		 * limited to umc instance
-		 */
-		/* TODO */
-		ret = -EOPNOTSUPP;
-	}
-
-	record->cur_nps = nps;
-
-	return ret;
-}
-
 static int umc_v12_0_eeprom_record_to_nps_pages(struct ras_core_context *ras_core,
 			struct eeprom_umc_record *record, uint32_t nps,
 			uint64_t *pfns, uint32_t num)
@@ -580,10 +491,11 @@ static void umc_v12_0_mca_ipid_parse(struct ras_core_context *ras_core, uint64_t
 
 const struct ras_umc_ip_func ras_umc_func_v12_0 = {
 	.bank_to_eeprom_record = umc_v12_0_bank_to_eeprom_record,
-	.eeprom_record_to_nps_record = umc_v12_0_eeprom_record_to_nps_record,
 	.eeprom_record_to_nps_pages = umc_v12_0_eeprom_record_to_nps_pages,
 	.bank_to_soc_pa = umc_12_0_bank_to_soc_pa,
 	.soc_pa_to_bank = umc_12_0_soc_pa_to_bank,
 	.mca_ipid_parse = umc_v12_0_mca_ipid_parse,
+	.ma2pa = umc_v12_ma2pa,
+	.nps_pa_to_row_pa = umc_v12_0_nps_pa_to_row_pa,
 };
 
-- 
2.34.1

