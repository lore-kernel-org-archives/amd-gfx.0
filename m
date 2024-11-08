Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7225D5E15A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176AD10E0FA;
	Fri,  8 Nov 2024 11:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yoO7X6lY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07E0610E0BF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qu7WEkQQmz0I0AGQHRuDd1k5fxyN0Gcxc+nGInFJfREEARobJJSTpNsFtEjC2kwt+UIK5DodwgEOSccPKIVSSCB13KZjOvCvV2fnwsstnD7wVJa7zfCbWzuYSKYKh8ftWANlv2N5bsIptatAGyburJjYJadf2xKHFSo5hT4GJzJ5aNVr2uQBcTH8b4HBm4eTkuc2ynPKVnITfTVLLmh/opV9sRJBe4xPRdIQ2CygLH5qRVHmCQ3KmJTgTv+XwzYrd7R1onhQB7AqyA/a6LOhNZPiYcVmNg+paPRs5tFpYhcKdYTWNVPXPX5b7CV+boU2Mnr2aSn01230GFeFdj7ZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsfLa+2H9g9iORKqXpXtnYbzWmxlHa40DMVKCKltsjE=;
 b=c79CRsXvdqkzxGz/YSzB0ECDfbAIpKRuWZwydpaQHtCkZ1p5NsY6y/k9olwQ+tFQoMhASXwZXQRznod6WK8kEbEcjfhEFbTj/0GAukdLpoaSFmTwpV4UeLT1GpeA2koyI14wk0lXvn5EXqQMBCv+qDUMDD7M3kfK1bj3D4TFkol17pTRpBYwBYuXf3S2qLM/H27O67Z1G3DRz0VnHvjAcBELoBKfUFKFUqondgY8+heDo1XxKALOUrT7Ryxyk0VZ3FlSeNOkPDtkkAY7t1azxNWQXnF3gsZinA/1BV0nQkz5NNUPFpPET/j0lYS5UbWtjQaIA7mTKU1XTTgWIFyKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsfLa+2H9g9iORKqXpXtnYbzWmxlHa40DMVKCKltsjE=;
 b=yoO7X6lY1+mwZ9BTvxaXmIudZaQs4dZfKme0lHcZJGAiI4piOJGRSbIWyRwAM2WYu1NPBO56uSfPsdgM3KThbPFwJvFYC89h5HSoNs0IKOfPrq+THc/yDlkGpl6zluKSOFQRFPnf57KsQ3kDuFupndtZ/wf+oQE2Lysr9dSWOPk=
Received: from BN9PR03CA0267.namprd03.prod.outlook.com (2603:10b6:408:ff::32)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Fri, 8 Nov
 2024 11:14:37 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::df) by BN9PR03CA0267.outlook.office365.com
 (2603:10b6:408:ff::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:36 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:35 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 04/23] drm/amdgpu: remove redundant RAS error address
 coversion code
Date: Fri, 8 Nov 2024 19:14:04 +0800
Message-ID: <20241108111423.60169-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: f57d24ba-3d29-4b72-d03f-08dcffe68819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/P15yjtMDfRO/ApJEICCMbdgT0gZdQNXcHNuRY5/uMCNPBg5uJbwoIU+fmfV?=
 =?us-ascii?Q?61TDNAfbIIHe+noMRWBAlwViv804gTZawDSY3fjXvCR967H/1xuKYvEf1KFL?=
 =?us-ascii?Q?1ZrJiBKoWhu0saHTrLRe4eZpgOwe4F+WljJcFJV0eOafERYswZSbA7xfqGkR?=
 =?us-ascii?Q?aNkAKCaryXFKO1qHRpgEfEfx+VKpvaD+g0168FRdpY6bHgi3l44Epv4zlrH+?=
 =?us-ascii?Q?Nco6D2stzdKPugzZ7MjDSlpwaU3ODdJvflhA246DfdgxAtacq7OZ6gbu/RaM?=
 =?us-ascii?Q?Gztq5urKlndsHOizzMejHM3TiV2OnhavcmbWuz6UjLheGsB+UZlTOtlOu0PW?=
 =?us-ascii?Q?OnRyy3EqABJHpfEGFT8rrntHobBH3xaDU3dZa0Bm4omARdsr2g4p5WWyjYmA?=
 =?us-ascii?Q?IlqIyGWp5Xft4Qp7W1RNkd/PLOSR7loyqDC370evoyP2Hf9IXeHem1mJzQpb?=
 =?us-ascii?Q?lLlt5K+Ycodlkn/RqUTknFJgggjDXO3se+X7eeiVZdjJlkB1Il193Hi3Yrii?=
 =?us-ascii?Q?7DIwkp0qRsLAnWth3RfG6d4yrklnAI1ZJwFaeAWCitz2u5x7ivxZhtLArkVf?=
 =?us-ascii?Q?xXTVWUrFu9z9i9C8B+B1GUo1nSajJOZJGQSJfUQXF8zid/lS8RXkh2EAn+jn?=
 =?us-ascii?Q?BDklMNd2fMHOeNB89q32PAjKitMiqSeYQWgHJAEnd2oFUdOnU5wSDIeRgGkx?=
 =?us-ascii?Q?8dhu4/xS3aVCZYJluJrQDZ7fOLnKXm4Wr7gLuakAbSSwh4hVJpHzMglIro4f?=
 =?us-ascii?Q?jrj8BS0gYfAml2Lity7fr2D8rs2PG08ZRvlGA87646CcqhzD6aZkw/Qxzlcx?=
 =?us-ascii?Q?UhDI1u2l+MDMfi+062IgT21P/4jh1L4TIO76ZiGPUcv4u2sL7NWO1i3r8IjQ?=
 =?us-ascii?Q?/BIOlIfjBhr2RzOadHxQW8Kr9Z2CSnFC60yC74tyeyThlWRIO4+Av6ta+jqO?=
 =?us-ascii?Q?ZIYsRqgzwk8i9DyxmeXg8r/kUBKIKpWfMigkxwPdj33Xfss4X3Sk26VzmC3u?=
 =?us-ascii?Q?s7olvPc9icutRocnrPz04uVRvFqh2bhSlj7TU+GxYnj1lschSP7tnpcjzZoI?=
 =?us-ascii?Q?AW7Ey37XDlAYqjs2i51Zu0Vn09gg276vZLMLfv2ZVEwkN8J10NTtw71LH2Cj?=
 =?us-ascii?Q?+d6qopMeJE03u2UlYq+Ovc+ZNdpGaryWGpoYeBEQTqU2c5AfFLQMCEUDV2MQ?=
 =?us-ascii?Q?pW5UNdsbEOqaqpeV6mbGYRfnH8y6izqgbN/wEXhoOEM6NNjQlLG5HiLoZ0jU?=
 =?us-ascii?Q?zeRXIHFmQApVlSugsi4yHuC6ArqCAHzh82jDsDT+4a4GAC5S4qlP5wpMCpv5?=
 =?us-ascii?Q?38+B9yEbO32DE/ouVbecleLmRewVeQe/RVd1xKlCghihx9jNbJLbE7GoWoR8?=
 =?us-ascii?Q?unlGJnC6CT9IRPcHWuwNX4cbZH/RTBZ8lgtnXplFu25N4c7bFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:36.9940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f57d24ba-3d29-4b72-d03f-08dcffe68819
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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

Only one interface is responsible for the conversion.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 136 +++++++++++--------------
 1 file changed, 59 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 8939b4f1fb49..a030fed16c5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -175,62 +175,41 @@ static void umc_v12_0_query_ras_error_count(struct amdgpu_device *adev,
 
 static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 					struct ras_err_data *err_data,
-					struct ta_ras_query_address_input *addr_in)
+					struct ta_ras_query_address_input *addr_in,
+					struct ta_ras_query_address_output *addr_out,
+					bool dump_addr)
 {
-	uint32_t col, row, bank, channel_index;
+	uint32_t col, row, bank, channel_index, umc_inst = 0;
 	uint64_t soc_pa, retired_page, column, err_addr;
-	struct ta_ras_query_address_output addr_out;
-
-	err_addr = addr_in->ma.err_addr;
-	addr_in->addr_type = TA_RAS_MCA_TO_PA;
-	if (psp_ras_query_address(&adev->psp, addr_in, &addr_out)) {
-		dev_warn(adev->dev, "Failed to query RAS physical address for 0x%llx",
-			err_addr);
-
-		return;
-	}
-
-	soc_pa = addr_out.pa.pa;
-	bank = addr_out.pa.bank;
-	channel_index = addr_out.pa.channel_idx;
+	struct ta_ras_query_address_output addr_out_tmp;
+	struct ta_ras_query_address_output *paddr_out;
 
-	col = (err_addr >> 1) & 0x1fULL;
-	/* clear [C3 C2] in soc physical address */
-	soc_pa &= ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
-	/* clear [C4] in soc physical address */
-	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
-	/* clear [R13] in soc physical address */
-	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_R13_BIT);
+	if (!addr_out)
+		paddr_out = &addr_out_tmp;
+	else
+		paddr_out = addr_out;
 
-	/* loop for all possibilities of [R13 C4 C3 C2] */
-	for (column = 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; column++) {
-		retired_page = soc_pa | ((column & 0x3) << UMC_V12_0_PA_C2_BIT);
-		retired_page |= (((column & 0x4) >> 2) << UMC_V12_0_PA_C4_BIT);
-		retired_page |= (((column & 0x8) >> 3) << UMC_V12_0_PA_R13_BIT);
+	err_addr = bank = channel_index = 0;
+	if (addr_in) {
+		err_addr = addr_in->ma.err_addr;
+		addr_in->addr_type = TA_RAS_MCA_TO_PA;
+		if (psp_ras_query_address(&adev->psp, addr_in, paddr_out)) {
+			dev_warn(adev->dev, "Failed to query RAS physical address for 0x%llx",
+				err_addr);
 
-		/* include column bit 0 and 1 */
-		col &= 0x3;
-		col |= (column << 2);
-		row = (retired_page >> UMC_V12_0_PA_R0_BIT) & 0x3fffULL;
+			return;
+		}
 
-		dev_info(adev->dev,
-			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
-			retired_page, row, col, bank, channel_index);
-		amdgpu_umc_fill_error_record(err_data, err_addr,
-			retired_page, channel_index, addr_in->ma.umc_inst);
+		bank = paddr_out->pa.bank;
+		channel_index = paddr_out->pa.channel_idx;
+		/* no need to care about umc inst if addr_in is NULL */
+		umc_inst = addr_in->ma.umc_inst;
 	}
-}
 
-static void umc_v12_0_dump_addr_info(struct amdgpu_device *adev,
-				struct ta_ras_query_address_output *addr_out,
-				uint64_t err_addr)
-{
-	uint32_t col, row, bank, channel_index;
-	uint64_t soc_pa, retired_page, column;
+	soc_pa = paddr_out->pa.pa;
 
-	soc_pa = addr_out->pa.pa;
-	bank = addr_out->pa.bank;
-	channel_index = addr_out->pa.channel_idx;
+	if (!err_data && !dump_addr)
+		return;
 
 	col = (err_addr >> 1) & 0x1fULL;
 	/* clear [C3 C2] in soc physical address */
@@ -248,41 +227,50 @@ static void umc_v12_0_dump_addr_info(struct amdgpu_device *adev,
 
 		/* include column bit 0 and 1 */
 		col &= 0x3;
-		col |= ((column & 0x7) << 2);
+		col |= (column << 2);
 		row = (retired_page >> UMC_V12_0_PA_R0_BIT) & 0x3fffULL;
 
-		dev_info(adev->dev,
-			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
-			retired_page, row, col, bank, channel_index);
+		if (dump_addr)
+			dev_info(adev->dev,
+				"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
+				retired_page, row, col, bank, channel_index);
+
+		if (err_data)
+			amdgpu_umc_fill_error_record(err_data, err_addr,
+				retired_page, channel_index, umc_inst);
 	}
 }
 
 static int umc_v12_0_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 			uint64_t pa_addr, uint64_t *pfns, int len)
 {
-	uint64_t soc_pa, retired_page, column;
-	uint32_t pos = 0;
-
-	soc_pa = pa_addr;
-	/* clear [C3 C2] in soc physical address */
-	soc_pa &= ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
-	/* clear [C4] in soc physical address */
-	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
-	/* clear [R13] in soc physical address */
-	soc_pa &= ~(0x1ULL << UMC_V12_0_PA_R13_BIT);
+	uint32_t i, ret = 0, pos = 0;
+	struct ta_ras_query_address_output addr_out;
+	struct ras_err_data err_data;
+
+	err_data.err_addr =
+		kcalloc(adev->umc.max_ras_err_cnt_per_query,
+				sizeof(struct eeprom_table_record), GFP_KERNEL);
+	if(!err_data.err_addr) {
+		dev_warn(adev->dev, "Failed to alloc memory in "
+				"bad page lookup!\n");
+		return 0;
+	}
 
-	/* loop for all possibilities of [C4 C3 C2] */
-	for (column = 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL; column++) {
-		retired_page = soc_pa | ((column & 0x3) << UMC_V12_0_PA_C2_BIT);
-		retired_page |= (((column & 0x4) >> 2) << UMC_V12_0_PA_C4_BIT);
-		retired_page |= (((column & 0x8) >> 3) << UMC_V12_0_PA_R13_BIT);
+	addr_out.pa.pa = pa_addr;
+	umc_v12_0_convert_error_address(adev, &err_data, NULL, &addr_out, false);
 
+	for (i = 0; i < adev->umc.max_ras_err_cnt_per_query; i++) {
 		if (pos >= len)
-			return 0;
-		pfns[pos++] = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
+			goto out;
+
+		pfns[pos++] = err_data.err_addr[pos].retired_page;
 	}
+	ret = pos;
 
-	return pos;
+out:
+	kfree(err_data.err_addr);
+	return ret;
 }
 
 static int umc_v12_0_convert_mca_to_addr(struct amdgpu_device *adev,
@@ -300,14 +288,8 @@ static int umc_v12_0_convert_mca_to_addr(struct amdgpu_device *adev,
 	addr_in.ma.node_inst = node;
 	addr_in.ma.socket_id = socket;
 	addr_in.addr_type = TA_RAS_MCA_TO_PA;
-	if (psp_ras_query_address(&adev->psp, &addr_in, &addr_out)) {
-		dev_warn(adev->dev, "Failed to query RAS physical address for 0x%llx",
-			err_addr);
-		return -EINVAL;
-	}
 
-	if (dump_addr)
-		umc_v12_0_dump_addr_info(adev, &addr_out, err_addr);
+	umc_v12_0_convert_error_address(adev, NULL, &addr_in, &addr_out, dump_addr);
 
 	*addr = addr_out.pa.pa;
 
@@ -363,7 +345,7 @@ static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
 		addr_in.ma.umc_inst = umc_inst;
 		addr_in.ma.node_inst = node_inst;
 
-		umc_v12_0_convert_error_address(adev, err_data, &addr_in);
+		umc_v12_0_convert_error_address(adev, err_data, &addr_in, NULL, true);
 	}
 
 	/* clear umc status */
-- 
2.34.1

