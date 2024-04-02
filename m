Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF20CD1284
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 08:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37AE910FB74;
	Tue,  2 Apr 2024 08:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nzZ176HL";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E72D10FB74
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 08:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEQt7EP6oF3lRSZWWIbsu5fdh5fhiNiaDA7HxLUvQ9AuE1AmUBstv/aoHMnRctyOcmZOZZDCXeBtPBWKFOLka8U18+TfvpZQgvI3zkAq8PmVGI5E0ImO11vc4nvbJiujfHjHljk2JMNc2b+r/gT9IiSmiHE61iOLSafo65KkSfxWkTKg+sSkUgJo8I6qIfEwMlp8h9jynq8mtDgBJo3jX71REnIa8LwiWiHhmJzXWKQ+lgTlUd/GIsbbZkhQawDVYNl0gmaacoIxcZTvHDP04Mu3gm3+1oomddEwKaRbtt/p9cGWvhPuYl+3SEIsZf/xIAaUHckQ21RyKE16ZfUQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlWSdE2a6o5LnYF1sbZ9pjYdNTK+hf4XI/PYwnXDxXI=;
 b=Egw0kSSLsUGLpY7UFGwRvtqywYYF9e09GuGtoQ27pewMtfxwc7q2dFmafN+IfHz6PyjxkjpKYPE2mOccEj6W9atP4k253/2j3qQowDFnrKwVQA5ozym3mx9856mVQolC2lX1aixLxEAJQvoivX6h6MhLl+yi/SgO4GLjQVffWSfSjbfrzAHF90IqIh68HCj4E6/6ESCUqXlZKu+KrGzlwzbw3y3UzpRPZEQOCxh/f1NtgPkl53IzPmR9xx6wVVasMz23mKsH0IQSJzP1PQ60hit3Wph3JAgZI4vadqRK8xtDmWwxFGCIkTRfVAg5Hr3YqujDBcU/OWxfVv6BTv4uMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlWSdE2a6o5LnYF1sbZ9pjYdNTK+hf4XI/PYwnXDxXI=;
 b=nzZ176HL2lQ06mahhLgCrtQZSQcJApBY9qG5EhVU/Dnds/wGoSr3TpWafWl8P1DFQzEWSw6rNOBvOqSwh5aqUgw2LnnnmCzDO3orvu/3BxhazPnDKCODo5sVgDauzLS0fHXoREB/CJWxOg73F5gQYwxvYLRfIRPmqZ0ov7VR90w=
Received: from BLAPR05CA0043.namprd05.prod.outlook.com (2603:10b6:208:335::23)
 by SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 08:51:01 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::d2) by BLAPR05CA0043.outlook.office365.com
 (2603:10b6:208:335::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Tue, 2 Apr 2024 08:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 08:51:00 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Apr
 2024 03:50:59 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: retire UMC v12 mca_addr_to_pa
Date: Tue, 2 Apr 2024 16:50:50 +0800
Message-ID: <20240402085050.372402-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ebbec1-5042-4872-a4ea-08dc52f20553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +SA3a47x6P6kmd6rS6uUrjkEbeQybYI2bcMa53FNM/EP1w4sBxNcvIlYhi4wcRkKO2oETZPEun2lIwg0bA6aC2ZU8E/zDL4cd//vFH8WpyqdwTq6gS3LVL98PizaxDI+gnrLemjam/+LsBFdzUZ1rGfNU6V7aHS2oSL1p8vwfTmnQzGXYgI5Ne2Qg0hj8jO5b5yOfU2JehJKvEPvx4W/2iEr308WVnNj0kwPoWaGm5yAtgfq/0Q3N7siWLCQh26Hmh/s9xV9Ntipza4WdgWxkKKAgIfqBJbNl71vDtfdjUAzbdlVFzmp7EBpthtsxVxMY0SkzD9Vu092r9IvHGBnnr0IgIJKQ3iDbhSRMUnFkW0ajrE6WD+CRoyv12Gmu1iB2bjNSz/FmS845Qp8UrwxhHMlbkN8UZWs32V5+M+hz9F926okGtLyuUXP4jNZQlzNztHadn30fFqkZ9PYdmo89F9VMfLzZYfvGkHbY1r7D6ECxajxjfl2lbfot/toG/MzfvUy5xwYXqOsSEUmHGjOHWVQxtnlAaV6yTwUEaMUqJBHN79Pg+RgCPYwUB81phNG553jAVa5ksFFWOwKqZ+G/6dahKzfBOAcvzqamTs30LZxWMAiCLwp4OMe+ti4XAtSHrMNwatUZNqE0WwtZf/S6rLmN8UYRwiop/o8U2Drp2RkamIkIqHPqSNyAitSGXadaZCDivzipEJbauG8uHO2cCl6EJxzyFbVButXPIO5d20cfNI/md9pWqY3q5gVv4xE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 08:51:00.4073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ebbec1-5042-4872-a4ea-08dc52f20553
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316
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

RAS TA will handle it, the interface is useless.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |   1 -
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 105 ++-----------------------
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h |  62 +--------------
 3 files changed, 7 insertions(+), 161 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 4ba26d7e52bd..afae497cbf40 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1460,7 +1460,6 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.channel_offs = UMC_V12_0_PER_CHANNEL_OFFSET;
 		adev->umc.active_mask = adev->aid_mask;
 		adev->umc.retire_unit = UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
-		adev->umc.channel_idx_tbl = &umc_v12_0_channel_idx_tbl[0][0][0];
 		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
 			adev->umc.ras = &umc_v12_0_ras;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index f46a176f9b55..a0122b22eda4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -28,28 +28,6 @@
 #include "umc/umc_12_0_0_sh_mask.h"
 #include "mp/mp_13_0_6_sh_mask.h"
 
-const uint32_t
-	umc_v12_0_channel_idx_tbl[]
-			[UMC_V12_0_UMC_INSTANCE_NUM]
-			[UMC_V12_0_CHANNEL_INSTANCE_NUM] = {
-		{{3,   7,   11,  15,  2,   6,   10,  14},  {1,   5,   9,   13,  0,   4,   8,   12},
-		 {19,  23,  27,  31,  18,  22,  26,  30},  {17,  21,  25,  29,  16,  20,  24,  28}},
-		{{47,  43,  39,  35,  46,  42,  38,  34},  {45,  41,  37,  33,  44,  40,  36,  32},
-		 {63,  59,  55,  51,  62,  58,  54,  50},  {61,  57,  53,  49,  60,  56,  52,  48}},
-		{{79,  75,  71,  67,  78,  74,  70,  66},  {77,  73,  69,  65,  76,  72,  68,  64},
-		 {95,  91,  87,  83,  94,  90,  86,  82},  {93,  89,  85,  81,  92,  88,  84,  80}},
-		{{99,  103, 107, 111, 98,  102, 106, 110}, {97,  101, 105, 109, 96,  100, 104, 108},
-		 {115, 119, 123, 127, 114, 118, 122, 126}, {113, 117, 121, 125, 112, 116, 120, 124}}
-	};
-
-/* mapping of MCA error address to normalized address */
-static const uint32_t umc_v12_0_ma2na_mapping[] = {
-	0,  5,  6,  8,  9,  14, 12, 13,
-	10, 11, 15, 16, 17, 18, 19, 20,
-	21, 22, 23, 24, 25, 26, 27, 28,
-	24, 7,  29, 30,
-};
-
 static inline uint64_t get_umc_v12_0_reg_offset(struct amdgpu_device *adev,
 					    uint32_t node_inst,
 					    uint32_t umc_inst,
@@ -192,79 +170,6 @@ static void umc_v12_0_query_ras_error_count(struct amdgpu_device *adev,
 	umc_v12_0_reset_error_count(adev);
 }
 
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
-static void umc_v12_0_mca_addr_to_pa(struct amdgpu_device *adev,
-					uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst,
-					uint32_t node_inst,
-					struct ta_ras_query_address_output *addr_out)
-{
-	uint32_t channel_index, i;
-	uint64_t na, soc_pa;
-	uint32_t bank_hash0, bank_hash1, bank_hash2, bank_hash3, col, row;
-	uint32_t bank0, bank1, bank2, bank3, bank;
-
-	bank_hash0 = (err_addr >> UMC_V12_0_MCA_B0_BIT) & 0x1ULL;
-	bank_hash1 = (err_addr >> UMC_V12_0_MCA_B1_BIT) & 0x1ULL;
-	bank_hash2 = (err_addr >> UMC_V12_0_MCA_B2_BIT) & 0x1ULL;
-	bank_hash3 = (err_addr >> UMC_V12_0_MCA_B3_BIT) & 0x1ULL;
-	col = (err_addr >> 1) & 0x1fULL;
-	row = (err_addr >> 10) & 0x3fffULL;
-
-	/* apply bank hash algorithm */
-	bank0 =
-		bank_hash0 ^ (UMC_V12_0_XOR_EN0 &
-		(umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR0) ^
-		(umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR0))));
-	bank1 =
-		bank_hash1 ^ (UMC_V12_0_XOR_EN1 &
-		(umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR1) ^
-		(umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR1))));
-	bank2 =
-		bank_hash2 ^ (UMC_V12_0_XOR_EN2 &
-		(umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR2) ^
-		(umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR2))));
-	bank3 =
-		bank_hash3 ^ (UMC_V12_0_XOR_EN3 &
-		(umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR3) ^
-		(umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR3))));
-
-	bank = bank0 | (bank1 << 1) | (bank2 << 2) | (bank3 << 3);
-	err_addr &= ~0x3c0ULL;
-	err_addr |= (bank << UMC_V12_0_MCA_B0_BIT);
-
-	na = 0x0;
-	/* convert mca error address to normalized address */
-	for (i = 1; i < ARRAY_SIZE(umc_v12_0_ma2na_mapping); i++)
-		na |= ((err_addr >> i) & 0x1ULL) << umc_v12_0_ma2na_mapping[i];
-
-	channel_index =
-		adev->umc.channel_idx_tbl[node_inst * adev->umc.umc_inst_num *
-			adev->umc.channel_inst_num +
-			umc_inst * adev->umc.channel_inst_num +
-			ch_inst];
-	/* translate umc channel address to soc pa, 3 parts are included */
-	soc_pa = ADDR_OF_32KB_BLOCK(na) |
-		ADDR_OF_256B_BLOCK(channel_index) |
-		OFFSET_IN_256B_BLOCK(na);
-
-	/* the umc channel bits are not original values, they are hashed */
-	UMC_V12_0_SET_CHANNEL_HASH(channel_index, soc_pa);
-
-	addr_out->pa.pa = soc_pa;
-	addr_out->pa.bank = bank;
-	addr_out->pa.channel_idx = channel_index;
-}
-
 static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 					struct ras_err_data *err_data,
 					struct ta_ras_query_address_input *addr_in)
@@ -275,10 +180,12 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 
 	err_addr = addr_in->ma.err_addr;
 	addr_in->addr_type = TA_RAS_MCA_TO_PA;
-	if (psp_ras_query_address(&adev->psp, addr_in, &addr_out))
-		/* fallback to old path if fail to get pa from psp */
-		umc_v12_0_mca_addr_to_pa(adev, err_addr, addr_in->ma.ch_inst,
-				addr_in->ma.umc_inst, addr_in->ma.node_inst, &addr_out);
+	if (psp_ras_query_address(&adev->psp, addr_in, &addr_out)) {
+		dev_warn(adev->dev, "Failed to query RAS physical address for 0x%llx",
+			err_addr);
+
+		return;
+	}
 
 	soc_pa = addr_out.pa.pa;
 	bank = addr_out.pa.bank;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index 5973bfb14fce..1d5f44dcffdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -55,67 +55,12 @@
 #define UMC_V12_0_NA_MAP_PA_NUM        8
 /* R13 bit shift should be considered, double the number */
 #define UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL (UMC_V12_0_NA_MAP_PA_NUM * 2)
-/* bank bits in MCA error address */
-#define UMC_V12_0_MCA_B0_BIT 6
-#define UMC_V12_0_MCA_B1_BIT 7
-#define UMC_V12_0_MCA_B2_BIT 8
-#define UMC_V12_0_MCA_B3_BIT 9
+
 /* column bits in SOC physical address */
 #define UMC_V12_0_PA_C2_BIT 15
 #define UMC_V12_0_PA_C4_BIT 21
 /* row bits in SOC physical address */
 #define UMC_V12_0_PA_R13_BIT 35
-/* channel index bits in SOC physical address */
-#define UMC_V12_0_PA_CH4_BIT 12
-#define UMC_V12_0_PA_CH5_BIT 13
-#define UMC_V12_0_PA_CH6_BIT 14
-
-/* bank hash settings */
-#define UMC_V12_0_XOR_EN0 1
-#define UMC_V12_0_XOR_EN1 1
-#define UMC_V12_0_XOR_EN2 1
-#define UMC_V12_0_XOR_EN3 1
-#define UMC_V12_0_COL_XOR0 0x0
-#define UMC_V12_0_COL_XOR1 0x0
-#define UMC_V12_0_COL_XOR2 0x800
-#define UMC_V12_0_COL_XOR3 0x1000
-#define UMC_V12_0_ROW_XOR0 0x11111
-#define UMC_V12_0_ROW_XOR1 0x22222
-#define UMC_V12_0_ROW_XOR2 0x4444
-#define UMC_V12_0_ROW_XOR3 0x8888
-
-/* channel hash settings */
-#define UMC_V12_0_HASH_4K 0
-#define UMC_V12_0_HASH_64K 1
-#define UMC_V12_0_HASH_2M 1
-#define UMC_V12_0_HASH_1G 1
-#define UMC_V12_0_HASH_1T 1
-
-/* XOR some bits of PA into CH4~CH6 bits (bits 12~14 of PA),
- * hash bit is only effective when related setting is enabled
- */
-#define UMC_V12_0_CHANNEL_HASH_CH4(channel_idx, pa) ((((channel_idx) >> 5) & 0x1) ^ \
-				(((pa)  >> 20) & 0x1ULL & UMC_V12_0_HASH_64K) ^ \
-				(((pa)  >> 27) & 0x1ULL & UMC_V12_0_HASH_2M) ^ \
-				(((pa)  >> 34) & 0x1ULL & UMC_V12_0_HASH_1G) ^ \
-				(((pa)  >> 41) & 0x1ULL & UMC_V12_0_HASH_1T))
-#define UMC_V12_0_CHANNEL_HASH_CH5(channel_idx, pa) ((((channel_idx) >> 6) & 0x1) ^ \
-				(((pa)  >> 21) & 0x1ULL & UMC_V12_0_HASH_64K) ^ \
-				(((pa)  >> 28) & 0x1ULL & UMC_V12_0_HASH_2M) ^ \
-				(((pa)  >> 35) & 0x1ULL & UMC_V12_0_HASH_1G) ^ \
-				(((pa)  >> 42) & 0x1ULL & UMC_V12_0_HASH_1T))
-#define UMC_V12_0_CHANNEL_HASH_CH6(channel_idx, pa) ((((channel_idx) >> 4) & 0x1) ^ \
-				(((pa)  >> 19) & 0x1ULL & UMC_V12_0_HASH_64K) ^ \
-				(((pa)  >> 26) & 0x1ULL & UMC_V12_0_HASH_2M) ^ \
-				(((pa)  >> 33) & 0x1ULL & UMC_V12_0_HASH_1G) ^ \
-				(((pa)  >> 40) & 0x1ULL & UMC_V12_0_HASH_1T) ^ \
-				(((pa)  >> 47) & 0x1ULL & UMC_V12_0_HASH_4K))
-#define UMC_V12_0_SET_CHANNEL_HASH(channel_idx, pa) do { \
-		(pa) &= ~(0x7ULL << UMC_V12_0_PA_CH4_BIT); \
-		(pa) |= (UMC_V12_0_CHANNEL_HASH_CH4(channel_idx, pa) << UMC_V12_0_PA_CH4_BIT); \
-		(pa) |= (UMC_V12_0_CHANNEL_HASH_CH5(channel_idx, pa) << UMC_V12_0_PA_CH5_BIT); \
-		(pa) |= (UMC_V12_0_CHANNEL_HASH_CH6(channel_idx, pa) << UMC_V12_0_PA_CH6_BIT); \
-	} while (0)
 
 #define MCA_IPID_LO_2_UMC_CH(_ipid_lo) (((((_ipid_lo) >> 20) & 0x1) * 4) + \
 			(((_ipid_lo) >> 12) & 0xF))
@@ -127,11 +72,6 @@ bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_
 
 typedef bool (*check_error_type_func)(struct amdgpu_device *adev, uint64_t mc_umc_status);
 
-extern const uint32_t
-	umc_v12_0_channel_idx_tbl[]
-			[UMC_V12_0_UMC_INSTANCE_NUM]
-			[UMC_V12_0_CHANNEL_INSTANCE_NUM];
-
 extern struct amdgpu_umc_ras umc_v12_0_ras;
 
 #endif
-- 
2.34.1

