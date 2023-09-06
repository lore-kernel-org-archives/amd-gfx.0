Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCA4EB8FB6
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 10:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7DAE10E5E8;
	Wed,  6 Sep 2023 10:11:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B22410E5E8
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 10:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ma/EbnaGVNqU519VaV+2LAgUkxrntsYGiqhx0Mgxl8Xia25XQXwjBBUHz9XvNJ2ghc3Pahb5WiwI74g1P6aGLb4k9gjIoQevQn8nUZ47dyg62qgx7ptTHnb4ZupxfGL08lqphVHbyeJPBBrR73MCsizf8ueQnTWaSNb6BKESKPczEruGRohMIPF1W4etHUwnKLIKD69k/ylxQ4uS2zddI24tWbr0Fr2UdjrIWHK3UySaBN6iQxj5U53GHvZ//DVYtiT2LXU+JSP0KGigBQ3ro4mh24uP6MghCYRSbshHvMKMbE7DxSn79eH3u3eZKvz8WfL8LQzNY4Yirl+OT6RnDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nWJ4DHoaS0vyFraedig4xYneRWf3COj7YZMCx24ZJ4=;
 b=SFLtCbaV1UJQtgpA89pAICZPWOKjNo/xvdR+VceqNeAKkW5C8ABMoZavSTqwapFjo9yAc3G+b8IIpv3cLROS9m2I8UERccOQaMC0XZR5s46CLMDkLO9saz1XOgARYY1pCVX58zfKBGDjfd74ywYhT5qw1qJzlGRIrNc1Bk8g7e/K4U1APGivS4+Mb0tvFROdjbjZaDgpwAl2q6Y6pjXNuv3QAsRe40oq+Z39iYGq1senVO2TaGR77b/pNYjcfqGF4OB8od0ULlyjUNUsWgx3zKg8TXopwLNa4dJ9GvP4Wm2KMhhXxx+TX87KLqLqqARsnXWonzGU3G7C9/OQb8xiOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nWJ4DHoaS0vyFraedig4xYneRWf3COj7YZMCx24ZJ4=;
 b=b34LllKtEOVD2/iDACJNLKLlxfrWhAJv+jvNTaJ3u+9V6+uYH9x3vj2+1UCasuq842thT1C4Disf2Vt1CZAS9AEx0HTxb/e52dlDheaBangV2BJXde+Bml7/dW9RmO7FM4yNE/EOA38nSaMC7b3s9XkJL6heyq39Z+6pgKK05xw=
Received: from BYAPR06CA0025.namprd06.prod.outlook.com (2603:10b6:a03:d4::38)
 by SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 10:10:54 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::3e) by BYAPR06CA0025.outlook.office365.com
 (2603:10b6:a03:d4::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 10:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 10:10:54 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 05:10:26 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Candice.Li@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add address conversion for UMC v12
Date: Wed, 6 Sep 2023 18:10:14 +0800
Message-ID: <20230906101016.22726-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b35a60-c385-4d1f-a631-08dbaec18e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t5vjRRgXMnxw4uG5WWvvyWsomGakSx81EstmwRBXOMWDP7MLJ4wKfnfC3bpmOgMCLaHn76gJry8H588/x5WeOIJhoQWvTnRBsGZRKnlkZo/vb3Lpr6PozH5UFRffSAM9spDVl2hNJBsmGKhya1BGDX9MiM8ZgF+dy57vMSTRc2QUdq8wSKSwPS3RY174osFIPtC9udLasL0/Fs3mPUKieuKyw7g4Rs5dHm3N7TNEz9WpL83vhAm3Skp320hTorFN2/rJoSEhqIznTSz0A9D5Nnx9xGNuz+7XTtBZGB8J0d9ZQR1JkBRjtu0eBGzfrVD7AGnBLr9VfVWLTdkHQBTZWUZmwdI+sw0asGk4w1KuYV40kGyqrpMXG8vBlWiarPWnV0sR7ZT/2JpXXY1QudUSQQvt2IwMOzMPIySZrh+e+22Iq4G7HhUBVKX9LbiiOKWtGF8zhIX6ZqdI4lHAM4MOnrTb5SRTULuiVsxy+VUnOriu38js+sBBBs4qk155zuldw9BH1czUKe8tpPSVM3mEEmORszCUmsZZdHEVmGtUeUUynRZ1Fy57/uDezhtDJhpPQXeV9b1IX5yP0PsWydLVi5DN9IB0LW6lD0mM3OWj+4aVC3RDFjzt/KLLFBc99roN+v8cMqDUjBKvUJS9otvKzKNGu3GA1GtcRrBQ8zDDyDzGcSv1vjtpVnHfBh5zkHxVncYpb206cKYHLAdb2zX6JzxYIapQPy7ssz2+NwZ1YgvF4MYd3LnJ7R9RNwn6nF5HSTspuSLJjXUONQ/JvFMo7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(8936002)(4326008)(8676002)(478600001)(110136005)(70206006)(70586007)(5660300002)(40480700001)(83380400001)(2906002)(6666004)(41300700001)(316002)(6636002)(86362001)(7696005)(40460700003)(82740400003)(2616005)(1076003)(356005)(81166007)(26005)(16526019)(426003)(336012)(47076005)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 10:10:54.1655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b35a60-c385-4d1f-a631-08dbaec18e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Convert MCA error address to physical address and find out all pages in
one physical row.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  5 ++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 97 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h  | 64 ++++++++++++++++
 3 files changed, 162 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 43321f57f557..417a6726c71b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -32,6 +32,11 @@
  * is the index of 8KB block
  */
 #define ADDR_OF_8KB_BLOCK(addr)			(((addr) & ~0xffULL) << 5)
+/*
+ * (addr / 256) * 32768, the higher 26 bits in ErrorAddr
+ * is the index of 8KB block
+ */
+#define ADDR_OF_32KB_BLOCK(addr)			(((addr) & ~0xffULL) << 7)
 /* channel index is the index of 256B block */
 #define ADDR_OF_256B_BLOCK(channel_index)	((channel_index) << 8)
 /* offset in 256B block */
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 292159814340..2a135fd8ec15 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -27,6 +27,14 @@
 #include "umc/umc_12_0_0_offset.h"
 #include "umc/umc_12_0_0_sh_mask.h"
 
+/* mapping of MCA error address to normalized address */
+static const uint32_t umc_v12_0_ma2na_mapping[] = {
+	0,  5,  6,  8,  9,  14, 12, 13,
+	10, 11, 15, 16, 17, 18, 19, 20,
+	21, 22, 23, 24, 25, 26, 27, 28,
+	24, 7,  29, 30,
+};
+
 static inline uint32_t get_umc_v12_0_reg_offset(struct amdgpu_device *adev,
 					    uint32_t node_inst,
 					    uint32_t umc_inst,
@@ -133,12 +141,93 @@ static void umc_v12_0_query_ras_error_count(struct amdgpu_device *adev,
 	umc_v12_0_reset_error_count(adev);
 }
 
-static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
-					    struct ras_err_data *err_data, uint64_t err_addr,
-					    uint32_t ch_inst, uint32_t umc_inst,
-					    uint32_t node_inst, uint64_t mc_umc_status)
+static bool umc_v12_0_bit_wise_xor(uint32_t val)
 {
+	bool result = 0;
+	int i;
 
+	for (i = 0; i < 32; i++)
+		result = result ^ ((val >> i) & 0x1);
+
+	return result;
+}
+
+static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
+					struct ras_err_data *err_data, uint64_t err_addr,
+					uint32_t ch_inst, uint32_t umc_inst,
+					uint32_t node_inst, uint64_t mc_umc_status)
+{
+	uint32_t channel_index, i;
+	uint64_t soc_pa, na, retired_page, column;
+	uint32_t bank_hash0, bank_hash1, bank_hash2, bank_hash3, col, row;
+	uint32_t bank0, bank1, bank2, bank3, bank;
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
+	na = 0x0;
+	/* convert mca error address to normalized address */
+	for (i = 1; i < ARRAY_SIZE(umc_v12_0_ma2na_mapping); i++)
+		na |= ((err_addr >> i) & 0x1ULL) << umc_v12_0_ma2na_mapping[i];
+
+	channel_index =
+		adev->umc.channel_idx_tbl[node_inst * adev->umc.umc_inst_num *
+			adev->umc.channel_inst_num +
+			umc_inst * adev->umc.channel_inst_num +
+			ch_inst];
+	/* translate umc channel address to soc pa, 3 parts are included */
+	soc_pa = ADDR_OF_32KB_BLOCK(na) |
+		ADDR_OF_256B_BLOCK(channel_index) |
+		OFFSET_IN_256B_BLOCK(na);
+
+	/* the umc channel bits are not original values, they are hashed */
+	UMC_V12_0_SET_CHANNEL_HASH(channel_index, soc_pa);
+
+	/* clear [C3 C2] in soc physical address */
+	soc_pa &= ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
+	/* clear [C4] in soc physical address */
+	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
+
+	/* loop for all possibilities of [C4 C3 C2] */
+	for (column = 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
+		retired_page = soc_pa | ((column & 0x3) << UMC_V12_0_PA_C2_BIT);
+		retired_page |= (((column & 0x4) >> 2) << UMC_V12_0_PA_C4_BIT);
+		dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
+		amdgpu_umc_fill_error_record(err_data, err_addr,
+			retired_page, channel_index, umc_inst);
+
+		/* shift R13 bit */
+		retired_page ^= (0x1ULL << UMC_V12_0_PA_R13_BIT);
+		dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
+		amdgpu_umc_fill_error_record(err_data, err_addr,
+			retired_page, channel_index, umc_inst);
+	}
 }
 
 static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index 3f822b6e0c99..c20b4b4cbfda 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -48,6 +48,70 @@
 #define UMC_V12_0_TOTAL_CHANNEL_NUM(adev) \
 	(UMC_V12_0_CHANNEL_INSTANCE_NUM * (adev)->gmc.num_umc)
 
+/* one piece of normalized address is mapped to 8 pieces of physical address */
+#define UMC_V12_0_NA_MAP_PA_NUM        8
+/* bank bits in MCA error address */
+#define UMC_V12_0_MCA_B0_BIT 6
+#define UMC_V12_0_MCA_B1_BIT 7
+#define UMC_V12_0_MCA_B2_BIT 8
+#define UMC_V12_0_MCA_B3_BIT 9
+/* column bits in SOC physical address */
+#define UMC_V12_0_PA_C2_BIT 15
+#define UMC_V12_0_PA_C4_BIT 21
+/* row bits in SOC physical address */
+#define UMC_V12_0_PA_R13_BIT 35
+/* channel index bits in SOC physical address */
+#define UMC_V12_0_PA_CH4_BIT 12
+#define UMC_V12_0_PA_CH5_BIT 13
+#define UMC_V12_0_PA_CH6_BIT 14
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
+				(((pa)  >> 47) & 0x1ULL & UMC_V12_0_HASH_4K))
+#define UMC_V12_0_SET_CHANNEL_HASH(channel_idx, pa) do { \
+		(pa) &= ~(0x7ULL << UMC_V12_0_PA_CH4_BIT); \
+		(pa) |= (UMC_V12_0_CHANNEL_HASH_CH4(channel_idx, pa) << UMC_V12_0_PA_CH4_BIT); \
+		(pa) |= (UMC_V12_0_CHANNEL_HASH_CH5(channel_idx, pa) << UMC_V12_0_PA_CH5_BIT); \
+		(pa) |= (UMC_V12_0_CHANNEL_HASH_CH6(channel_idx, pa) << UMC_V12_0_PA_CH6_BIT); \
+	} while (0)
+
 #define GET_CROSS_NODE_ADDR(reg) \
 	((((reg) >> 32) & 0x3) ? ((reg) | (1ULL << 34)) : (reg))
 
-- 
2.35.1

