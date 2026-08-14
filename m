Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C152CC5DF7B
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B4310F73B;
	Fri, 14 Aug 2026 21:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VGL5Dd9q";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F42010F72E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMNMXJaUM2ky9F67AsAOSgTdHc7IhT9yoUsKsfURURL0NCxsB139cH8IinXjoFDoviuGnid18emV9MkTlI5yKm2q4/h4wm8GdcWZsN5RAbE9ULC3bBeHaasBpavuewX0dRmA+aAQSGb8WaTpXTrClWtQ+tk66DzlmuweuoE/rsbMBkE2nuXMPHAo2Z2iCJQxN8YiapM+k+G2oGy3owC9MFGI/Z7V1qX/9BLd1h8uFi/xx9BB3uTr3ya+d+D3Dw0u5r2BGeg8Z9eZqZRvNRhxmWt4kxo/36tzHWkjprx/QIrzV5z2btLDY6GFdWbbwpvQXWPx96zm1sbm/qKt0gHpYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URxLcbktqJanO7MnQJjan+CyGDDh9dGpT2NAh8gFzRA=;
 b=D/lZcMMaa9A9kSYY3l/Bj0IrzfnVCPUzfKBk8seR5UOvkDdIR6aUVCL2hIKyACHnrFE8QEvplGf3Ya/6wBtqEN1Og6QwXXDZ988AVJrwUuyGCPfrv0bbvEg735LbxomWoR7F5+a+BSDm7DWp3R1hDC/Lzm4n2gDY88d2Rgd0NWBi5jUGW8+nBSVohzYQaLo9fwqFC3nWJdU+VY61PaH1PwYO07Cm52aI9On94iv/25x9c8jBbOr379BAnuBsjCVKH8/nbjR/2OEvOZueVSOiNXqO4lVmUpgKn0UyNuT7mFlsLcUvg/TKetKU1MwoZbhmnvLKZDRlW2sVVGOQ3MEUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URxLcbktqJanO7MnQJjan+CyGDDh9dGpT2NAh8gFzRA=;
 b=VGL5Dd9qqGtcD6goBlXttDFp5xlEr5fsZslEb2G2wTGticvP3AbSrrMbOSjTEojWAMP419yGWf9IfQBwVWOanioyzLsNXg+YkkuXyXlIf5EXaStXSS5Fu9pOVF/nbcH2Q7fTb/0zowWLzRW0zpRNKMs80hRxz31rt2qkpS8vNFs=
Received: from BN9PR03CA0503.namprd03.prod.outlook.com (2603:10b6:408:130::28)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:57 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::a7) by BN9PR03CA0503.outlook.office365.com
 (2603:10b6:408:130::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:54 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 095/109] drm/amd/ras: filter out invalid pages from extended
 page addresses
Date: Fri, 14 Aug 2026 17:02:32 -0400
Message-ID: <20260814210246.3067612-96-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: a3267ee5-768f-4866-7ea6-08defa478e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: cfaHumJNXhtze8rhUE2+EDJwqKu/IvSorZqWprDh+PMyXUZaVkaq31QQtTFamo/JafiIBkk96dcD5kQkEbfKzA43btZs6OP/+zNehtfrPqpsS6Uu7spT+O6ieoGR+TQ+E1hknJqUHlGDexlrm0jeoofAq72ifKcjwDOor/ei6/PZ9TQ2mDs9XAm/FsNTdakw29n1JRx/n3iiySAIXUZGYeOlGUDaOSmSz9+auuuWv5VoXdo3mBIPD34fac9tvQJsmuZ1EZmz0lqBUfBk8Dce658InoupDujmbrz0MK6hP8XKw4R7TNMdZHt1sYrLAGKgil2g92jGpYQO1jBbXvB1eHZ/oAAukqAxAA+g+J33jR0OT5tG9K+g6fJhNG1ooIhdhb250gVSuoR5x683wePeet468VEj4WHTZ0VDI5Y2tb6Uxq2xfhmLE7s5vHfkmuZoCNtUerhy6YAT+Hlw58IEkU7R6S/Zfppev9lsXQSgf9HFTxNIQJmceu332cB7hPlDMMnUKEmbUP8iMK92gfWslFLLfGfP8gqUlCv8yHc8xvfRA27M9LMIpGmpLh0UG1hM9L5SOxSerNc1uCjzfw1n2wr1Hlvxgy81Lf9dQtmDgK/KDcMRIwTw5XH8lU0n2YFvkWN28JiNZnvnKhAP7+UFxulWWxYoY35xKWney0FJe3HzqipEltbBkvTS0JnbbFhbV8O5mAJfOHY9QQ79AZCSTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CBubNZsUvXWUkv6ZP8yYx6V8759cjA4G6uC+IDg0yYA486WRagprzjyjygr/Shh/TR8JY19Q1BS1EEnZkI5v8J56FpXufzSOWE9oamOp8jXOXYqbTwtQUgvv9CmBFNGsQ1c+bXeeo2dx/inE9n4qhzilH8+lX1AmF8M59dnAT4FsovPa/mqC7oh00mjMwoh6p8KLF3Rom7E3qS9kaI2/xabI/05lPmW2348RXL/JCg7caTVAWj6CwWSobDT2uXzgsw2U88PpQeBKSA4ps9t79T+3+o00Dtf7EL0b1/4aFfzq8QmIWC5JMaNMcH8ikqHu9TWtp+Grz5sWcFeNaVYrfTI9qQanyVrZWWoiYN0GVZfdUI3t0pFNEJEmfoQx19G5x5scY6wEjxV8OK/Ax+7OGt9VWNPbHtfxxAQzp21+jlq+YSfwgtXBehqJAbBow+V8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:57.0906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3267ee5-768f-4866-7ea6-08defa478e5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872
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

Filter out invalid pages from extended page addresses.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_umc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index 299426d6d8318..4cce9f5c65932 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -233,7 +233,8 @@ static int ras_umc_expand_row_pages(struct ras_core_context *ras_core,
 
 	row_pa = retired_addr & ~(flip_mask);
 
-	if (count < nr_page_pfns)
+	if ((count < nr_page_pfns) &&
+	    !ras_core_check_address_sanity(ras_core, row_pa))
 		page_pfns[count++] = RAS_ADDR_TO_PFN(row_pa);
 
 	subset = flip_mask;
@@ -243,7 +244,8 @@ static int ras_umc_expand_row_pages(struct ras_core_context *ras_core,
 		if (count >= nr_page_pfns)
 			break;
 
-		page_pfns[count++] = RAS_ADDR_TO_PFN(addr);
+		if (!ras_core_check_address_sanity(ras_core, addr))
+			page_pfns[count++] = RAS_ADDR_TO_PFN(addr);
 
 		subset = (subset - 1) & flip_mask;
 	};
@@ -271,7 +273,7 @@ int ras_umc_convert_record_to_row_pages(struct ras_core_context *ras_core,
 	}
 
 	count = ras_umc_expand_row_pages(ras_core, record, page_pfns, nr_page_pfns);
-	if (count > 0)
+	if (count >= 0)
 		record->cur_nps_valid_page_num = count;
 
 	return count;
@@ -656,10 +658,13 @@ static int ras_umc_update_eeprom_ram_data(struct ras_core_context *ras_core,
 	struct eeprom_store_record *data = &ras_umc->umc_err_data.ram_data;
 	int j;
 
-	if (!bps || !page_pfns || !nr_page_pfns ||
+	if (!bps || !page_pfns ||
 		(nr_page_pfns > ras_umc->max_pages_per_row))
 		return -EINVAL;
 
+	if (!nr_page_pfns)
+		return 0;
+
 	if (!data->space_left &&
 		ras_umc_realloc_err_data_space(ras_core, data, 256))
 		return -ENOMEM;
-- 
2.55.0

