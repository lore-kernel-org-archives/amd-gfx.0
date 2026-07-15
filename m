Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7029C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 07:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD8810EF3F;
	Wed, 15 Jul 2026 07:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CozuGOBk";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E87A10EF1E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 07:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/DaV9qYycjx3wPE5QF4oflJQhZ3t8KH651pAtxRKdvue1PJe7RajJ11ufKuCmISgLky5/z5WOtp+RZNnTIpW3+HKG5Xhb+vaxb8ElfU46/S/rUYnePb2vI3hps9pK/yZIIapv1qrg/OhTV0ZIP4zHq50HYdwagJrQYigrQhylOwH/W1xx5Nx9qmp56VEeItv4fM8aXoYa3feoJAQQUf2yY36KT+Gq877rta4PfbMa62V2Vk9FkZH3y0oxREeVbEPMyN2D5eJsvQRWc44aAHdl+S9VfIQa3FGBl7/vLqho30oY3Cq/zKZ/bi1fL6o9Jb/A9qLNlT2TR1J3B3s3E6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nunWtpmvhkByWA44I1dqQpOophWGhTFSHE8DSunFUyY=;
 b=re1wseNTmF9kYbDRQFTpVMEV+4Fh5bOFAwnGncrT+HibVAFTeAhEHs/PtunqqZb8J1trR0olg/7EGaH2DfkCP20P7cvNs+TkpReHSZVW88gcP+p97uthoLOd08757FnLzfFJELdAe9UTvbAO9GHVmEzMBYCiFfIalf4vB027VgwRx6Qmy5rk/obPVBmI//pbkOES95WN+m1Y6aFgQZix5TXMbqvk2rh1oy3MYP0x93d6C8dw3kmUnxLHQcFELkE1XYxGEuoTueKkuOOpPzOkBTXmmYJuKd+LpwbOFGs7sMzQa53xXKvjkYhWsxG+VWABsZ4lDDfTjmK1Dkn5zjM0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nunWtpmvhkByWA44I1dqQpOophWGhTFSHE8DSunFUyY=;
 b=CozuGOBkMBedT0Pb9JBRN/S9cte5wsuPeqGPWJtGQ/DX/ELBKaPmDbj8QZ2u46TzfIRPqlNcn6dVLXdFcGoXunJc8Zn/wi1x8nudhhlw8RM2J71Eo6U8ADbmHyzO6omHdsXcMrkXGrW5m1U9/OrHhzWA7RtKGDxycKxUhPQRE7M=
Received: from MN0PR04CA0027.namprd04.prod.outlook.com (2603:10b6:208:52d::16)
 by BN7PPF08EEA05B5.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 07:47:49 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::64) by MN0PR04CA0027.outlook.office365.com
 (2603:10b6:208:52d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 07:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 07:47:48 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 02:47:47 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/5] drm/amd/ras: add support for old ras eeprom format
Date: Wed, 15 Jul 2026 15:47:32 +0800
Message-ID: <20260715074734.2668631-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715074734.2668631-1-tao.zhou1@amd.com>
References: <20260715074734.2668631-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|BN7PPF08EEA05B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b43ac0d-3324-4a99-948c-08dee2455dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: XFr67aJ7uIbIkSycenR3x7h/oVsKSoKvm+ZLg3PWW3y5V4QDSKx5AJughAfmSsVNyTzNz5/2f0lrGIiFBsCv+du3JqeF4teN8NC5L9hXrRgmSvX7Uc96Z982eDkn37OBfW/Mt0gYjxzwQDNj4xBL3742jwgEO5784SWQgQHvims0T30iAmPpRdaI0Yl9X3NSQpp+0yh7F9YIs8dtkvUdjCS+GyTD28j1i0eUM4G7+GZlF7bT1wbgq3BhTcCEyGWp6SiK1C43WNWRTi0ZS7sT3CwkKCh8FmO2fRuLPFXjM29WeohmLuLUKygWp+pieNHkU+io/jqixeGs6AUwTVeYPp9tQMJsD7dFLM6grBYriEQ9P/1bouXkkTqaLMhNnmatXN8I0nuNJpO+eqsh+EoAOoX045ZlVSZXYMrQVS6j030SRphPb8KMZMnFJDLvHnNOUTnFd2Gkw9Wl4mzd23HFaldQ4dHTC7u+NQyogIjH2TCay5K/aTVWySgbJWH2e+noQFvHmtsIvrEjOJOLaOhm6jzCeLUVzs74b//LNZv9HYHjscZHgYBLgfZ/k+BXhK6AGATuefPww/85ieP8I6kMGLKzPWc9DSq3SH7PgN9msXW99F1SwY6sFLF5BWTAo0EmRJGiGwYPgBwXSv2Uy7YwbHSnQvNGMvtBrjETcwC4IXXdn1MSx/A25cvn1+IQmYL27zcHOdP9JjxQYtQOWh+CXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ubvMR1rQqKGH2Gu+rjEKzo1+lSdcvIgoIdJWQPs/CzlMYRHEDI9/3OvECzVirSYOoqqI9kFZzx2IDnca8kr4C85olH/D+NCf8Fjh9oZGLbws+m0dLk9BcN1yio8mxWWmgdAUpZPMq6agVv2nNc9Be8W2p25WvO6E3K1TguZcFDwHqNSFvSqzySc+xbtOVjvN4IDhBP1FyK90Ml8pa8T8AOh1oN6EYgs4vyX/5ptGCGBG5c2cwkDK9umCbN4Sg41GaeXtGO4FmLQtVaxyQm+ItKE8WM7OAo1kpc5lQRsiNiJL6ZKeLs4aziWRWUES50NWfsf0av1h6KlSC3lKzs+Q33ozbCk2Bq7faxEf/sn2HokoYpAusrHxlLDYygPon3BuM/tdl2ws4ZJj26juw9fzRgbwYRs8lzMtjNiQ2ETRuSqeMIh99y9Y0wc3LphOnxL0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:47:48.7852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b43ac0d-3324-4a99-948c-08dee2455dd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF08EEA05B5
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

Handler of some formats will be implemented in the future.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h     | 17 ++++++++++
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   | 31 ++++++++++++++-----
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
index 71b6703193f5..5b9218ebf2ad 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -46,6 +46,23 @@
 #define UMC_ECC_NEW_DETECTED_TAG       0x1
 #define UMC_INV_MEM_PFN  (0xFFFFFFFFFFFFFFFF)
 
+/*
+ * a flag to indicate v2 of channel index stored in eeprom
+ *
+ * v1 (legacy way): store channel index within a umc instance in eeprom
+ *    range in UMC v12: 0 ~ 7
+ * v2: store global channel index in eeprom
+ *    range in UMC v12: 0 ~ 127
+ *
+ * NOTE: it's better to store it in eeprom_table_record.mem_channel,
+ * but there is only 8 bits in mem_channel, and the channel number may
+ * increase in the future, we decide to save it in
+ * eeprom_table_record.retired_page. retired_page is useless in v2,
+ * we depend on eeprom_table_record.address instead of retired_page in v2.
+ * Only 48 bits are saved on eeprom, use bit 47 here.
+ */
+#define UMC_CHANNEL_IDX_V2      BIT_ULL(47)
+
 /* three column bits and one row bit in MCA address flip
  * in bad page retirement
  */
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index 809cbd846883..b8630aba9e64 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -459,16 +459,33 @@ static int convert_eeprom_record_to_nps_addr(struct ras_core_context *ras_core,
 static int umc_v12_0_eeprom_record_to_nps_record(struct ras_core_context *ras_core,
 				struct eeprom_umc_record *record, uint32_t nps)
 {
-	uint64_t pa = 0;
+	uint64_t ch_idx_v2, pa = 0;
+	uint32_t save_nps;
 	int ret = 0;
 
-	if (nps == EEPROM_RECORD_UMC_NPS_MODE(record) && !ras_fw_eeprom_supported(ras_core)) {
-		record->cur_nps_retired_row_pfn = EEPROM_RECORD_UMC_ADDR_PFN(record);
-	} else {
-		ret = convert_eeprom_record_to_nps_addr(ras_core,
+	save_nps = EEPROM_RECORD_UMC_NPS_MODE(record);
+	ch_idx_v2 = record->retired_row_pfn & UMC_CHANNEL_IDX_V2;
+
+	if (save_nps || ch_idx_v2) {
+		if ((nps == save_nps) && !ras_fw_eeprom_supported(ras_core)) {
+			record->cur_nps_retired_row_pfn =
+				EEPROM_RECORD_UMC_ADDR_PFN(record);
+		} else {
+			ret = convert_eeprom_record_to_nps_addr(ras_core,
 				record, &pa, nps);
-		if (!ret)
-			record->cur_nps_retired_row_pfn = RAS_ADDR_TO_PFN(pa);
+			if (!ret)
+				record->cur_nps_retired_row_pfn = RAS_ADDR_TO_PFN(pa);
+		}
+	} else {
+		if (record->address == 0) {
+			/* for specific old eeprom data, mca address is not stored,
+			 * calc it from pa
+			 */
+		} else {
+			/* old eeprom data format, the scope of channel index is
+			 * limited to umc instance
+			 */
+		}
 	}
 
 	record->cur_nps = nps;
-- 
2.34.1

