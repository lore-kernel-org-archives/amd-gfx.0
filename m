Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A33C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BBDD10F6F4;
	Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XKIgPiGS";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 714B710F6EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sgl+NBE4jGYrsZKn21NRsi6RsHFSuN+aIWrqcsm/vvtzeqimQ0ElKlWNKG5lXFSSHs+rn+j279qrJtq31NzQ8hTs/3QE8I/tmY46mdi56wna+cc6OSoUtsJRwEoPoe4EbB4/t6yhjNtqyYb1RaiClXreYOmYPSL7C9WaVbAGAJ411O80Q4+wd4QU9bSK4GLW7Pr7052zm86X8NF7R0UFeV6jFVis6UJCZ9h3O5FggCmFoB/FoNXGmwvI0WRtWCATUE08/IcNXsgg1Y+5ClIoSPQFp7I4oWITOUR1v1VnZ8So9qcJxSvP/G+YZkaUx9XqO9QXipY/2fk+ZjUEEYNgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxMr00h3bVLMrbBx4F6xE3RNqCZEcrFCMBxbY2pM7fk=;
 b=b1hVN9KZcYrQgYisdphM5DUfySmFxOXCG3mYMz5Iu/Ef7IRr1ORh0rJJTptmVYTaM3k63gXJfDVKiPSCfRj0ZVwWgDiiOdWoH4jsk1YxzG9gdkLfj7sj7DiDbtg/KbCBh3kVFZLMpdZ9nhTP6Z60en8Z/nOYQYzi66b4RWQdM1lFlosEn9FeXnZasehhb8+m0i/bmM9ZK5XaIFGoIXKVSMRSei8IGXv3qGBDBiSWssjDo1s8YwQuhI50CBcsn8LDIJdwBa+mP+UkTJgzaLGNeZXa4He/YC5KVo+S4V8xQNlURIDUirA1ZbhbVze4X22Jr3ePgczuSV/COpRL7CBnEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxMr00h3bVLMrbBx4F6xE3RNqCZEcrFCMBxbY2pM7fk=;
 b=XKIgPiGSL/LNIl7YUovZk7WdJ0E+/Av7tYOk+1yUmYB8ro+7CLlxB0tgOd81FT3IMQMUiwLrBOswxG69gs8z9Vwu5ZrkZB17+wA5yOYRGxzwTFC348GtqP8As/umC1u4RYCOL1ugX+hWNjePfL5UHeKnoFJXvpW5OBPb9YGampo=
Received: from BN9PR03CA0496.namprd03.prod.outlook.com (2603:10b6:408:130::21)
 by BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:22 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::84) by BN9PR03CA0496.outlook.office365.com
 (2603:10b6:408:130::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 024/109] drm/amd/ras: Add ras command to obtain ras
 capabilities
Date: Fri, 14 Aug 2026 17:01:21 -0400
Message-ID: <20260814210246.3067612-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: f95f4bb9-fd25-4e0a-b768-08defa477951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099006|3023799007|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 9G5HuZsQJSxqst/t2Tap3SA1UVfo9V8n4afUEarBjWy1CuzV4EyPhGweP/1qVNP5uE4sHR2uAe8uqIOEAnr3L2+6KUhO/oCl/3mG0W/4lYyfDxqCpQ7c+3z/wzV5XC5C5spbNRxgVYG9/aNpoF74t84VBFp1GWSrmz33K4r58PXzEkKl0WGUWIRJMaP+7U8dfNqBtv22VdsuKXk//Akjj/pK9We/PooXiiaZuyFROciZK2fClHd2ptXLOfbImT+WqvxNjnDkl1d99SjjYOfy1TnFuj0uzpPyVilI9MHRZYOGqzHDB3xiF4D7AY/s48UO7jxlRZN/RF9xNckQ3ej8V3yDfFdqNJe2yfNK/tD4D6fnf2uRzs6obNvnKQxGw8f1vlKbaVs6E5SUoGr22ZJ61FfeEeGmf2vgo89RxTyVqmvkdLxWNxZfYSlPZv9O6bCMipIuxzFYuDPDVIeaQx3FyOSr3UH7uBoSPxhXlGlha3CRpKJNiDY/CLleRsyxQLLcvINux+aur3b3Q75oeCukz7ZUKOeBV0aoO/Gv67zCGF+FFhudG03qa4ee9Q3PGyq4LrVK0hU4ySY8vc1pyWnQxbl0J1o55nj1uZtY3As2tYIox0vIiX7CTF6+oQMhB9YQ90pfhvDrPjSzSurjP4pt8+1gISHuy6U2BzQcYDMVYbBcVt9QAK3oMcUtRFCVtYZAw3nudTXp9p4dLkeSnnewsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wc6nAb+Wu8gnYA490LShNKu4LL8M0MSVTEhzCAsLrf3+hUM6229hIBWkLghX2ybRIj4ySbux1X/BkDztreZmuQ6ntTaKovqVRmFtHpfZaDzSjana1BIxsuhEteQJZp/viFn+ciIr8/1d+sfy0ZP1o7xRO5MBh8qfWKLNefdhGlHSIW4UHfrMaR3bd4WDj/uOwzX/g2BANtLTadaSCB5/08Tf9YjmhduECSJT2oVMZVkIYP6VR0f0NPNLgNIiACxAKWaYefBEGfATW40E9hZO0KmjpeYWSJM5otEW1kypweEjZCRpxkcd9C0TX3xt5vlXivvIcWSB1rghkUdn/I1ufTjZedAM1ft+gWGgvg0M25DY1JQaI2k9SSz1ex8nLkvmjyXUyGXrrpitidCf2aLr3C7NlNfuC7X0gPcshW9Oo56G38rxE6xbZyxCH9d4iw1t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:21.7789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f95f4bb9-fd25-4e0a-b768-08defa477951
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129
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

Add ras command to obtain ras capabilities.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/cmd.c | 29 +++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/cmd.h | 27 ++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/cmd.c b/drivers/gpu/drm/amd/ras/core/cmd.c
index a0e61826c292a..ecd9da6199831 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.c
+++ b/drivers/gpu/drm/amd/ras/core/cmd.c
@@ -413,6 +413,34 @@ static int ras_cmd_inject_error(struct ras_core_context *ras_core,
 	return ret;
 }
 
+static int ras_cmd_get_ras_cap(struct ras_core_context *ras_core,
+	struct ras_cmd_ctx *cmd, void *data)
+{
+	struct ras_cmd_get_ras_cap_rsp *output_data =
+			(struct ras_cmd_get_ras_cap_rsp *)cmd->output_buff_raw;
+
+	output_data->version = 0;
+	output_data->poison = ras_core_poison_supported(ras_core);
+	output_data->flex_mca = ras_psp_flex_mca_enabled(ras_core);
+	output_data->ras_block_mask = ras_core_get_ras_caps(ras_core);
+
+	output_data->ecc_type = 0;
+	if (output_data->poison)
+		output_data->ecc_type |= BIT_ULL(RAS_ECC_TYPE_POISON);
+
+	if (output_data->ras_block_mask & BIT_ULL(RAS_BLOCK_ID__UMC))
+		output_data->ecc_type |= BIT_ULL(RAS_ECC_TYPE_MEM);
+
+	if (output_data->ras_block_mask &
+		(BIT_ULL(RAS_BLOCK_ID__GFX) | BIT_ULL(RAS_BLOCK_ID__SDMA)))
+		output_data->ecc_type |= BIT_ULL(RAS_ECC_TYPE_SRAM);
+
+
+	cmd->output_size = sizeof(struct ras_cmd_get_ras_cap_rsp);
+
+	return 0;
+}
+
 static struct ras_cmd_func_map ras_cmd_maps[] = {
 	{RAS_CMD__INJECT_ERROR, ras_cmd_inject_error},
 	{RAS_CMD__GET_BLOCK_ECC_STATUS, ras_get_block_ecc_info},
@@ -423,6 +451,7 @@ static struct ras_cmd_func_map ras_cmd_maps[] = {
 	{RAS_CMD__GET_CPER_RECORD, ras_cmd_get_cper_records},
 	{RAS_CMD__GET_BATCH_TRACE_SNAPSHOT, ras_cmd_get_batch_trace_snapshot},
 	{RAS_CMD__GET_BATCH_TRACE_RECORD, ras_cmd_get_batch_trace_records},
+	{RAS_CMD__GET_RAS_CAP, ras_cmd_get_ras_cap},
 };
 
 int rascore_handle_cmd(struct ras_core_context *ras_core,
diff --git a/drivers/gpu/drm/amd/ras/core/cmd.h b/drivers/gpu/drm/amd/ras/core/cmd.h
index 4950d0561b30d..728fbe55d1765 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.h
+++ b/drivers/gpu/drm/amd/ras/core/cmd.h
@@ -77,6 +77,7 @@ enum ras_cmd_id {
 	RAS_CMD__SET_CMD_AUTO_UPDATE,
 	RAS_CMD__CHECK_ADDRESS_VALIDITY,
 	RAS_CMD__CONVERT_RETIRED_ADDRESS,
+	RAS_CMD__GET_RAS_CAP,
 	RAS_CMD__SUPPORTED_MAX = RAS_CMD_ID_COMMON_END,
 };
 
@@ -95,6 +96,12 @@ enum ras_cmd_response {
 	RAS_CMD__ERROR_UNSUPPORT,
 };
 
+enum ras_ecc_type {
+	RAS_ECC_TYPE_MEM = 0,
+	RAS_ECC_TYPE_SRAM,
+	RAS_ECC_TYPE_POISON,
+};
+
 enum ras_error_type {
 	RAS_TYPE_ERROR__NONE = 0,
 	RAS_TYPE_ERROR__PARITY = 1,
@@ -204,12 +211,12 @@ struct ras_cmd_inject_error_rsp {
 struct ras_cmd_dev_info {
 	uint64_t dev_handle;
 	uint32_t location_id;
-	uint32_t ecc_enabled;
-	uint32_t ecc_supported;
+	uint32_t ecc_type;
+	uint64_t block_mask_bits;
 	uint32_t vf_num;
 	uint32_t asic_type;
 	uint32_t oam_id;
-	uint32_t reserved[8];
+	uint32_t reserved[7];
 };
 
 struct ras_cmd_devices_info_rsp {
@@ -469,6 +476,20 @@ struct ras_cmd_blocks_ecc_rsp {
 	struct ras_cmd_block_ecc blocks[MAX_RAS_BLOCK_NUM];
 };
 
+struct ras_cmd_get_ras_cap_req {
+	struct ras_cmd_dev_handle dev;
+	uint32_t reserved[4];
+};
+
+struct ras_cmd_get_ras_cap_rsp {
+	uint32_t version;
+	uint32_t ecc_type;
+	uint32_t poison;
+	uint32_t flex_mca;
+	uint64_t ras_block_mask;
+	uint32_t reserved[8];
+};
+
 #pragma pack(pop)
 
 int ras_cmd_init(struct ras_core_context *ras_core);
-- 
2.55.0

