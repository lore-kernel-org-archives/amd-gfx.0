Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44B8CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 04:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D52610E933;
	Tue, 23 Jun 2026 04:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wCEV7Gdq";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD03610E933
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 04:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hho+Qx7s1P6G+ryU/hcXAGfiObFN8KEEe450JjbSL/u7DDwsVUPbNNJy8z9+JDuz9tll+i9tuFDiMiSlneE7ZzuLQ82icLU410yRLnFmgctkTYQKLA65Z8eLUZo1e1hr9PBDZmcbzrz8qq5J8fNuDrIvu5HNHNJlxttgCQTqRa06JQ0IfPuQuJZYx62dX06c5VP7rCDTrQR8aTzW/RodDaXHORj2HPAzPDZdo+aDpJqJoANlEEedrRHzNFdOF9G+VieEN1ZRyKj504Rqk4FzhWoiaf65yx2F8Llnpj7Lh4+5VXWniocmlhnaWhQCJkaCDjgcuzkuCOR55y1LkXOqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWCyWkvGYW+w5MideKgp0iM8jdxKFnZvRVe79rCwRv4=;
 b=bf1o3rB5/eaI2ILcZujPi/V7kTTAi/0LdERc6c8jVnMldOb0/e6HkzgtqUF6C59jDwHjnMFUcvwqYQKCO6o5iK/yiQDyf4O/AeU4QpxL9lNn+O0iwJJRbKxYKOePnYc6b4UvrL9k2BW4qWayRjObFOJMI3eZWT1V2QCQ59DS/I2cuf24cTzsBnJTcZUv4fvB7kbVrrN83EqUWpx6D80i1pJrfsJ3d2Hy0EtMvdtx6dCnMnz7OCFfuy6QTI+t9K+GJrIT3JkxBA4QVX2uHmUMpb/6FNN+uJ2E7oyeBurXSF+eSjhTABoqs0z7doBQ2AbzpBVSXkkd0r6SKguHd4e+fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWCyWkvGYW+w5MideKgp0iM8jdxKFnZvRVe79rCwRv4=;
 b=wCEV7Gdqh1+/leAg4CL0L58Yo0pdru37u7ARicGD5r64Ge5U6z9X4Sooa1NDKQ/poOmi6NY2RZPSUMkjpHsKH9ApCTg5MLNkdrP0Ztt6yWhntm5gZANlDxbUl/8Urmwu7VK166Cx5nqM5o6KzUMnTjbWUcpX752IcYHB38PbpOc=
Received: from SJ0PR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:33f::14)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 04:26:24 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:a03:33f:cafe::a3) by SJ0PR05CA0039.outlook.office365.com
 (2603:10b6:a03:33f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8 via Frontend Transport; Tue, 23
 Jun 2026 04:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.0 via Frontend Transport; Tue, 23 Jun 2026 04:26:23 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 23:26:20 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amd/pm: Guard VBIOS AC timing table walk
Date: Tue, 23 Jun 2026 12:26:01 +0800
Message-ID: <20260623042601.562748-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: ffdba11c-fe24-4b34-3a42-08ded0df951a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: oMBmJjx2XGpJdhKTr0zsdwTqaEA9BzTs2ZXH9MQDU4rGxxDcVaeTMA04NxeS427pLRV+VYEdiWvaEzFdOV+n8IuQh16eVfLASKdZDikZmefyy4cZw6NM4hus/DHuMMoqU4nGxqlGwlq7n6943PZgqsU1h2hxgC//TivunbObDhCDe8BBgMgQZbA2vUCw8DP2XCW2rtyawfve2jbmkzNkhNxW9Wk1lhmZxqQCAwCL8e9w3+X6Gy1Ypt+IkKAwCTbtLE8Bf8gRUEvSJ9JefBsleHx2lXs0V+M4HVl4sTI1dDJrQs2NzqWg0jNtz/S7PxYJtuosQxjr8U5WRC/E3Impo+oMcD1liCvHinyrqTS6fahadjIWRQZXrRLPkfPTDlml5YYniBJlQtJdtVcmLwNiorpxYlf/Ll+hLEh4ymOLO4ApnFa9deQkpNK+Zy9PFWLWCOWDPjXrpUt/aWGpdS8P9ULi4lD858/FG/fYAmefWSiopSezZdR+ydWMTKo5fiJOW6B8QRr5j5sTopHUW4nqbDZdOxEa1Wy0adraVCAcoRt/ebAujNcvzOejNETnkIq9AH0D1LmT/da2Y1vDhxQnCJg7BDYcPASU+8RZFlPHRjKjZumwsIQjZxe/UfA20nOTfl0nfluObrDyf8eUMmt4b562LpkGcJoE8LHaygAXEFGB9jcC3cmhWejxMPrY9CK6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bOdTZ50KraaExggcQcvq17yh/Mpvcc1G7CRXPsU5uDzNWxCrXTDTaOKkY9hpfOOZq787rFeopo8R3y4Hm6UDq6jRbstyzWP6WzbQatyHcRPGBwII4OrKbEq4mIdev3Yfl5TXNppUZTHPRA4bLpjAcOH4jEn7iqYJR+Gh2f0Czg+s+K/RQx8fpBhAFE/KmEVS7DGWPq7B/xFUffkD48LjD+mw2nuKts479omMIcD8Hjw9P7qHEhl+bRoUJv5B6oN28j49UmhnOXpWsCmoYZL+Nxp2KkCIv9IHQLyC4DGt7BR0xmBIVaFQLuj8iaf1dRp+62dG9smNMRZJMsp7QjP3fRBbjpK5rQxmpT+MRr7bCU71vaywVsRcEs870AjTgQ3ES+EBEkMoSiy8eefJuzadoiTc35rtvxb8lkuI5D9/8spYgpGPLbGIiJDWkrGINQEr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 04:26:23.0173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdba11c-fe24-4b34-3a42-08ded0df951a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
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

Reject AC timing blocks with a stride smaller than a dword before walking
VBIOS data. A zero stride can otherwise keep reg_data pinned on a
nonmatching MEM_ID forever.

Also bound the data-block and END marker reads by the returned VRAM_Info
table size so malformed index/data sizes do not push the timing walk past
the table.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/ppatomctrl.c   | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index ce166a7f8e420..85bf1527c6f44 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -46,16 +46,22 @@ union voltage_object_info {
 static int atomctrl_retrieve_ac_timing(
 		uint8_t index,
 		ATOM_INIT_REG_BLOCK *reg_block,
+		u8 *table_end,
 		pp_atomctrl_mc_reg_table *table)
 {
 	uint32_t i, j;
+	u16 stride = le16_to_cpu(reg_block->usRegDataBlkSize);
 	uint8_t tmem_id;
 	ATOM_MEMORY_SETTING_DATA_BLOCK *reg_data = (ATOM_MEMORY_SETTING_DATA_BLOCK *)
 		((uint8_t *)reg_block + (2 * sizeof(uint16_t)) + le16_to_cpu(reg_block->usRegIndexTblSize));
 
 	uint8_t num_ranges = 0;
 
-	while (*(uint32_t *)reg_data != END_OF_REG_DATA_BLOCK &&
+	if (stride < sizeof(uint32_t))
+		return -EINVAL;
+
+	while ((uint8_t *)reg_data + sizeof(uint32_t) <= table_end &&
+	       *(uint32_t *)reg_data != END_OF_REG_DATA_BLOCK &&
 			num_ranges < VBIOS_MAX_AC_TIMING_ENTRIES) {
 		tmem_id = (uint8_t)((*(uint32_t *)reg_data & MEM_ID_MASK) >> MEM_ID_SHIFT);
 
@@ -67,6 +73,10 @@ static int atomctrl_retrieve_ac_timing(
 			for (i = 0, j = 1; i < table->last; i++) {
 				if ((table->mc_reg_address[i].uc_pre_reg_data &
 							LOW_NIBBLE_MASK) == DATA_FROM_TABLE) {
+					if ((uint8_t *)reg_data +
+					    (j + 1) * sizeof(uint32_t) > table_end)
+						return -EINVAL;
+
 					table->mc_reg_table_entry[num_ranges].mc_data[i] =
 						(uint32_t)*((uint32_t *)reg_data + j);
 					j++;
@@ -81,11 +91,13 @@ static int atomctrl_retrieve_ac_timing(
 		}
 
 		reg_data = (ATOM_MEMORY_SETTING_DATA_BLOCK *)
-			((uint8_t *)reg_data + le16_to_cpu(reg_block->usRegDataBlkSize)) ;
+			((uint8_t *)reg_data + stride);
 	}
 
-	PP_ASSERT_WITH_CODE((*(uint32_t *)reg_data == END_OF_REG_DATA_BLOCK),
-			"Invalid VramInfo table.", return -1);
+	if ((uint8_t *)reg_data + sizeof(uint32_t) > table_end ||
+	    *(uint32_t *)reg_data != END_OF_REG_DATA_BLOCK)
+		return -EINVAL;
+
 	table->num_entries = num_ranges;
 
 	return 0;
@@ -136,6 +148,7 @@ int atomctrl_initialize_mc_reg_table(
 {
 	ATOM_VRAM_INFO_HEADER_V2_1 *vram_info;
 	ATOM_INIT_REG_BLOCK *reg_block;
+	u8 *table_end;
 	int result = 0;
 	u8 frev, crev;
 	u16 size;
@@ -157,6 +170,7 @@ int atomctrl_initialize_mc_reg_table(
 	}
 
 	if (0 == result) {
+		table_end = (uint8_t *)vram_info + size;
 		reg_block = (ATOM_INIT_REG_BLOCK *)
 			((uint8_t *)vram_info + le16_to_cpu(vram_info->usMemClkPatchTblOffset));
 		result = atomctrl_set_mc_reg_address_table(reg_block, table);
@@ -164,7 +178,7 @@ int atomctrl_initialize_mc_reg_table(
 
 	if (0 == result) {
 		result = atomctrl_retrieve_ac_timing(module_index,
-					reg_block, table);
+					reg_block, table_end, table);
 	}
 
 	return result;
@@ -177,6 +191,7 @@ int atomctrl_initialize_mc_reg_table_v2_2(
 {
 	ATOM_VRAM_INFO_HEADER_V2_2 *vram_info;
 	ATOM_INIT_REG_BLOCK *reg_block;
+	u8 *table_end;
 	int result = 0;
 	u8 frev, crev;
 	u16 size;
@@ -198,6 +213,7 @@ int atomctrl_initialize_mc_reg_table_v2_2(
 	}
 
 	if (0 == result) {
+		table_end = (uint8_t *)vram_info + size;
 		reg_block = (ATOM_INIT_REG_BLOCK *)
 			((uint8_t *)vram_info + le16_to_cpu(vram_info->usMemClkPatchTblOffset));
 		result = atomctrl_set_mc_reg_address_table(reg_block, table);
@@ -205,7 +221,7 @@ int atomctrl_initialize_mc_reg_table_v2_2(
 
 	if (0 == result) {
 		result = atomctrl_retrieve_ac_timing(module_index,
-					reg_block, table);
+					reg_block, table_end, table);
 	}
 
 	return result;
-- 
2.34.1

