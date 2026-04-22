Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE81F94CC2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 03:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C78F810E1DD;
	Wed, 22 Apr 2026 03:56:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yJKNtvYe";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013051.outbound.protection.outlook.com
 [40.93.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A40510E1DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 03:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CV9O0KcdXKH7Fn23RMiXbQRBl8CiGq+65GkS+MCxzQU/OAVcHbT7635EMmpYZ0RahaAfpLgJf8xHfFxQAFcUciVsf4KoTvxOs4DayW1k5ZkltRi0mFZZW36haECpmRwui25Ph/DGqOEQQaIwjeODsCF8gy1rCJYsM2tavT0UxTBAaDtWcEXqkZDDlo7sW+sEps1QUCo9mPKj8jWaH/VKRs3P4yg2Svvv34YhRciDUTXhKucg50hyLNPUm+FQYQpa7q0rTixi1Mz/qyFl77eE71kIx7fk/rg50n5LaAvniXdLBNJwhEA7DOJM5Jw5qFMGJEW7LGOhRHOqr96mQI8eqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJmHwbD8xjMERp/WZps33QXJ7bCz6EK4p3c/DfYGtb8=;
 b=vJgS2rjq5BfBYJ7xSBokKf5On9H8WKVcMrtjDfVLuTIIrcjIkudjvyvua/M8Sv4HRAM+yzVoHVm1lkItLyCkIgem23NjPnU/VL9KSnNcRgZHZehxJeDDlgp0NSM4rRqxdHEeKeUGpSmPtqTWHLIzXMZeYyIdHTeSQmgh7LicQ6bxXQbm5SrpaU1BbaOuMmV8Mh2sBXVqmmf8rxXyozhHnHKDi1wXJNsA866sVoTQUDGvfI2pAQUqgcFZcLafzwzLIPz3oF50L4+q0u2RaFPWoiJCUCcNtBtoWlkLhfKQ86rEFZluFUwxbxH7Gn629Y4Lfsd9McWvyZIsb7ZcSQthFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJmHwbD8xjMERp/WZps33QXJ7bCz6EK4p3c/DfYGtb8=;
 b=yJKNtvYeV21xAq4B/JoW8Uhcjs+lbPIU+r6GY8Sme7h5khsvUIBVe92QMP2Bw5I6GwZR6PTPRAAeJv7D1IgoG0AVjg6bdVCdh1WVPSxL9SfnaRZ/UcsHb+JpfzcudQPW+fpx7G5x3PsL1IoJ5FWQYyp40f0tAcm18ePAd+OAb1k=
Received: from CY8PR19CA0047.namprd19.prod.outlook.com (2603:10b6:930:6::28)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 03:56:39 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::2a) by CY8PR19CA0047.outlook.office365.com
 (2603:10b6:930:6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 03:56:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 03:56:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:37 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 22:56:34 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Gaghik Khachatrian
 <gaghik.khachatrian@amd.com>, Clayton King <clayton.king@amd.com>
Subject: [PATCH 04/14] drm/amd/display: Update MCIF_ADDR macro to address IGT
 DWB regression
Date: Wed, 22 Apr 2026 11:52:42 +0800
Message-ID: <20260422035611.1870316-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
References: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac6dd7b-c0e6-497b-ef51-08dea02327e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xXpMCIIvYNMu5+DTGYiBLEjkKbAUDp/kCreD9rLooRRmENzB3mqwbi1Lz3JnARs81jnw/sZeC3B0PkWvb0oM4A3YAdc6dIDnSwyuGpwQ8d4Uf66w/876W6GU35fyoO2Pfgox7GZwVRAuWndNiTjgP9a0w+dLBNzSaYDSpmM6lb4uYAvN07X/F9tvz2RQKt8ozQdUPQ6cHi5Hhhu3KTBRPoJKMmQ/qKoJV5hgkREkUpD7GunqJQ10SOb/Oj7ptJaPtSFuMhcIbKtio3vpKYmyAmXZ+uI3IG1dm5oEB4hvMGSaWjUiNKOmSKTEnu+n15D3aInyBKcY73Rk/Ei4gFC0fZksWJ/n2yNS2BPcZFlBnSq/1w0ZEDgDHfVBWWwdBambDXJ/XLXfp5g1Y/0XUjVkz1fgSLvZKWL969zVy3G5bcHGXLoDtArkaSWCu6Wxj7q8r2plPR2iiEPSfX/FmwSc6EK/yKmB74ycRUSEVGt75njVsPn2wtTIfTRmjv5NkXm45BnWOvZfWIfdcGxcqNfPBd9/w0ozNPOvIH4JpJuDZ5ks12am6Czhf13KJVqb+IdM9ISAAVI8Eyjogd+HbvqXIB34LdEP0M/pTnnEXuZ2hAk41gmA+igZlaG3WOndG4X+BE670itJeiRpZsLNOUgxDs8v/nej+eYo1rkvbdxXnK5LlFRvZ9RU1BylQTaarhPZeg7cNcGn0Mw+1LalFZzt4meg06GtAdz/njzws0GUu7lNzK7nYk+OY2oJBaV493abScWFuLAt+lo/+9Fg5hVw8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KY21IUOPLk6eneddihsWkdGlcbYFEboZrG6+AX2VWK++msjldWAT6vvWpn6gKyZsNcbtH4xL9mq4Eoy0Z0vMAFCsRYIwoHDEaLqbQfMdbscAKLZt1ryigNjtdtNcjJmMa4E5UW+VnnBDwYtk7jGIZAKRILpQchfWjHKBJE8y0cWKSISoXHi+RU4pimUL65sdmegIl4pudeQL5hWqyCuRKHThVQ3NgzZ+hNKiTsZqD5k+KHZs0BX789OBBDNZiuAiUi+sh4nC/MehTb2cqxln1BG7XpI87Y7NOvYyWQDtXcxYC1wYl2bHMz4Y2KjzJGzR/ratVTqvMZ6sRHg9+SMtheKiYbVQtLnmSpYAs1vsvjnU+7lQTfbZmecIhhnRPjkgKqyCT7O/FhJ3p339avYin7UH8VIe3qfFDHv22YoNdM8VTzJZtvyEZm2EUJ59NI66
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 03:56:38.5857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac6dd7b-c0e6-497b-ef51-08dea02327e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why]
A previous warning-fix commit updated type casts in the DCN3
mmhubbub code but missed updating the MCIF_ADDR macro to the
correct, fully parenthesized and casted version. This caused
a regression during DWB tests, where address values could be
misinterpreted, potentially leading to incorrect hardware
programming.

[How]
Updated the MCIF_ADDR macro in dcn30_mmhubbub.c to use the
proper parenthesization and type casting, ensuring correct
address handling. Removed redundant casts from REG_UPDATE
calls for improved clarity and consistency with current
coding standards.

Fixes: 8ee2655eb4a2 ("drm/amd/display: Fix implicit narrowing conversion warnings")
Reviewed-by: Clayton King <clayton.king@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_mmhubbub.c | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
index 33a4c07a057c..62fe5c3b18dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.c
@@ -40,8 +40,8 @@
 #define FN(reg_name, field_name) \
 	mcif_wb30->mcif_wb_shift->field_name, mcif_wb30->mcif_wb_mask->field_name
 
-#define MCIF_ADDR(addr) (((unsigned long long)addr & 0xffffffffff) + 0xFE) >> 8
-#define MCIF_ADDR_HIGH(addr) (unsigned long long)addr >> 40
+#define MCIF_ADDR(addr) ((uint32_t)((((unsigned long long)(addr) & 0xffffffffffULL) + 0xFEULL) >> 8))
+#define MCIF_ADDR_HIGH(addr) ((uint32_t)(((unsigned long long)(addr)) >> 40))
 
 /* wbif programming guide:
  * 1. set up wbif parameter:
@@ -107,35 +107,35 @@ static void mmhubbub3_config_mcif_buf(struct mcif_wb *mcif_wb,
 	struct dcn30_mmhubbub *mcif_wb30 = TO_DCN30_MMHUBBUB(mcif_wb);
 
 	/* buffer address for packing mode or Luma in planar mode */
-	REG_UPDATE(MCIF_WB_BUF_1_ADDR_Y, MCIF_WB_BUF_1_ADDR_Y, (uint32_t)MCIF_ADDR(params->luma_address[0]));
+	REG_UPDATE(MCIF_WB_BUF_1_ADDR_Y, MCIF_WB_BUF_1_ADDR_Y, MCIF_ADDR(params->luma_address[0]));
 	REG_UPDATE(MCIF_WB_BUF_1_ADDR_Y_HIGH, MCIF_WB_BUF_1_ADDR_Y_HIGH, MCIF_ADDR_HIGH(params->luma_address[0]));
 
 	/* buffer address for Chroma in planar mode (unused in packing mode) */
-	REG_UPDATE(MCIF_WB_BUF_1_ADDR_C, MCIF_WB_BUF_1_ADDR_C, (uint32_t)MCIF_ADDR(params->chroma_address[0]));
+	REG_UPDATE(MCIF_WB_BUF_1_ADDR_C, MCIF_WB_BUF_1_ADDR_C, MCIF_ADDR(params->chroma_address[0]));
 	REG_UPDATE(MCIF_WB_BUF_1_ADDR_C_HIGH, MCIF_WB_BUF_1_ADDR_C_HIGH, MCIF_ADDR_HIGH(params->chroma_address[0]));
 
 	/* buffer address for packing mode or Luma in planar mode */
-	REG_UPDATE(MCIF_WB_BUF_2_ADDR_Y, MCIF_WB_BUF_2_ADDR_Y, (uint32_t)MCIF_ADDR(params->luma_address[1]));
+	REG_UPDATE(MCIF_WB_BUF_2_ADDR_Y, MCIF_WB_BUF_2_ADDR_Y, MCIF_ADDR(params->luma_address[1]));
 	REG_UPDATE(MCIF_WB_BUF_2_ADDR_Y_HIGH, MCIF_WB_BUF_2_ADDR_Y_HIGH, MCIF_ADDR_HIGH(params->luma_address[1]));
 
 	/* buffer address for Chroma in planar mode (unused in packing mode) */
-	REG_UPDATE(MCIF_WB_BUF_2_ADDR_C, MCIF_WB_BUF_2_ADDR_C, (uint32_t)MCIF_ADDR(params->chroma_address[1]));
+	REG_UPDATE(MCIF_WB_BUF_2_ADDR_C, MCIF_WB_BUF_2_ADDR_C, MCIF_ADDR(params->chroma_address[1]));
 	REG_UPDATE(MCIF_WB_BUF_2_ADDR_C_HIGH, MCIF_WB_BUF_2_ADDR_C_HIGH, MCIF_ADDR_HIGH(params->chroma_address[1]));
 
 	/* buffer address for packing mode or Luma in planar mode */
-	REG_UPDATE(MCIF_WB_BUF_3_ADDR_Y, MCIF_WB_BUF_3_ADDR_Y, (uint32_t)MCIF_ADDR(params->luma_address[2]));
+	REG_UPDATE(MCIF_WB_BUF_3_ADDR_Y, MCIF_WB_BUF_3_ADDR_Y, MCIF_ADDR(params->luma_address[2]));
 	REG_UPDATE(MCIF_WB_BUF_3_ADDR_Y_HIGH, MCIF_WB_BUF_3_ADDR_Y_HIGH, MCIF_ADDR_HIGH(params->luma_address[2]));
 
 	/* buffer address for Chroma in planar mode (unused in packing mode) */
-	REG_UPDATE(MCIF_WB_BUF_3_ADDR_C, MCIF_WB_BUF_3_ADDR_C, (uint32_t)MCIF_ADDR(params->chroma_address[2]));
+	REG_UPDATE(MCIF_WB_BUF_3_ADDR_C, MCIF_WB_BUF_3_ADDR_C, MCIF_ADDR(params->chroma_address[2]));
 	REG_UPDATE(MCIF_WB_BUF_3_ADDR_C_HIGH, MCIF_WB_BUF_3_ADDR_C_HIGH, MCIF_ADDR_HIGH(params->chroma_address[2]));
 
 	/* buffer address for packing mode or Luma in planar mode */
-	REG_UPDATE(MCIF_WB_BUF_4_ADDR_Y, MCIF_WB_BUF_4_ADDR_Y, (uint32_t)MCIF_ADDR(params->luma_address[3]));
+	REG_UPDATE(MCIF_WB_BUF_4_ADDR_Y, MCIF_WB_BUF_4_ADDR_Y, MCIF_ADDR(params->luma_address[3]));
 	REG_UPDATE(MCIF_WB_BUF_4_ADDR_Y_HIGH, MCIF_WB_BUF_4_ADDR_Y_HIGH, MCIF_ADDR_HIGH(params->luma_address[3]));
 
 	/* buffer address for Chroma in planar mode (unused in packing mode) */
-	REG_UPDATE(MCIF_WB_BUF_4_ADDR_C, MCIF_WB_BUF_4_ADDR_C, (uint32_t)MCIF_ADDR(params->chroma_address[3]));
+	REG_UPDATE(MCIF_WB_BUF_4_ADDR_C, MCIF_WB_BUF_4_ADDR_C, MCIF_ADDR(params->chroma_address[3]));
 	REG_UPDATE(MCIF_WB_BUF_4_ADDR_C_HIGH, MCIF_WB_BUF_4_ADDR_C_HIGH, MCIF_ADDR_HIGH(params->chroma_address[3]));
 
 	/* setup luma & chroma size
-- 
2.43.0

