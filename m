Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3F1C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA3810F370;
	Fri, 21 Aug 2026 16:13:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KtTBGnhb";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013064.outbound.protection.outlook.com
 [40.107.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7323A10F373
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:13:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3LAtmgGoo0bFbguyudnJP0vVnwy+xZoPWHPHFnNQxZv0EDvgiQsNQfdfH7xGWCO25fQOP4uafJ26TfR4Jl3P/8481r0H6dD8mSk0iWPAc5t3/U7MMOpima6kS+N1JwIODMD2+7XViWzx0FngEGpG3yunQWCV3qFwI9h2mnZZOe53UyEWt1V+6gbutC1ZmdUbCk1cJ0xhqa9wqjMvn+ncb0sDZEQ/Vsf1RJ37hjI5GPYdwDx5BtDnpvULE3Rix5NYGsyM8NAJrztEdjlsKqjA2khKbuKEKK+cnTuYVi8hjpzAOTL2WIdMtcFhN3xLvOg2HVMX5RFmkMy85BHLb3eaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iWoVCrVtAwlN01n5MQ+N8hKB0aHScHHyChKeKFpYZ4=;
 b=kQq0gcY2fbI5iiW418b6USCx/TEpLXlPLWm3SWnTZdmQ0QPItGPFGdIkynNu9kn+rMuZJgaemTZJlMYD93Fg3PumFK42LXpMIBMh3Y89qJmvnhZ3BFZtxiiQin715auvLIJqwYysdbCn27UV6+pwVLd8c2EUX7YKvSNr/6SgKw7cHlG2RHRHQ7vBaKg4UNocNcaQrIWMB7uQVhPJBArVglAlpNx13Mir0pWkxvZyVTC4J4SGeo+PuaUu+P/vLQCUsRQin4ZpQa60Md84hPT9b5w44Swc46yKzA32mzAVyqb72A0IvWX+kaynuV3K0wQXpuqlVpIgfJ8ojb3gGJvOxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iWoVCrVtAwlN01n5MQ+N8hKB0aHScHHyChKeKFpYZ4=;
 b=KtTBGnhbe2jLSSHz06zkijh/bFhOO6BC7uhgDZYaSdgb+xRezv/st4/tktZChogOzSNI0ytGpYlHv9+T4LrAa1yYYbaVrtNkcwjEno0VV8fLrhnwhTqhK8p5Z0wI0vcblQ3X9qg5rh9aDOZOTRB/Wz+E+lx3ivbVY8z4cb/76ec=
Received: from SA1P222CA0094.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::14)
 by SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:12:56 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::97) by SA1P222CA0094.outlook.office365.com
 (2603:10b6:806:35e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:12:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:12:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:12:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:12:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amd/ras: add supported aca blocks mapping
Date: Fri, 21 Aug 2026 12:12:29 -0400
Message-ID: <20260821161232.753638-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|SA0PR12MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 68519819-4b41-45f3-4fef-08deff9f0eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: fYPUvAFzS0IHL6hY3y9JQ3HN/u3YLmFN7OemXCG2yEUWJAa2bO++cQJkRBHez1YM5hVmWgA2zP0tQYb5qdJM9i6gkZc73IQr3hj6mN4Ex/SvQ3tRuL28H7AYd14wMqDFbP4Aj5vDZpD7cRpyNiSFCP8AqeGYS6Nr9wyWALpA389+DW8KGDTk0cwU/zCA9ue5FdyL5McDGBnbzyigSkRmO/po2VMeOMC1j6SMXHK1a2ByxICbHQ294zsMUJVH2ugeB5RQTcv4Ia9nG1GJPaU+c4TDItxBg25v3ASr2e9rJnqEekEomKJlxwTS3l0xIY35L8V11QQMWSdbYUhM4/TJ2UvYM0acUC7vh3K1/3D8OmEq1pNM5DFUXASJFiqE1ZrXYEzSDGmegdmsQ9SgRUZuirNkDZ7hNDdw48mAHTosVGjSihSBZZ4/2lDErEhgjBnpZd1Lc4PFOgNb7I4WT36NF+L4E0rUODrsEJuCFjMedaa3N2GJSxiaWLwqHnPbI67lQgKEn1SlYrNKOsjuP4iHrOhRgcE9bFKPiV/WaofJMp6vn9zFW8mlpeJKIaH97DCkVgo1uq0OtheoFiyZzTiY3fOIcZVCpB36tSBCGjYKVCN7eNA+LbB5rxQDqFcgweYSidIOKmxjkaYjXqgLjiCuq5iai2y9uzBxW1k98TGkUsmaUWGPI4eqeBwO8t4j13gfTIjT3os/hUZIlzVX0VXssQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MnIseMFHXrv620bl7T4A2LKKqRNdMjKqGhoNCTIRhqu5lsk4G0wje4oRT8vsDmQCht2gfOv3HCBw7BywHaFo34HBid7moj8bwRVMds+97/P+pMhqnFsZ8keRvzkUheX99CafPhYqTanqONtuTOiq2/tMzns8uysaU8CgrkM/Nysn2tswdDJ4JlAm2CqBQ6lCVRCq+E+L5SAZoF3mtGqEVKDdb/uJGrm3wpdsq0IfX8RdfKyBVOsrnL7DVjZA4J5yGozz7aadNLyQscUbwEUq9T1QGwdvKWkpDes2Dqg8lIegYlJhUEFCjPPUcMtWScQ5k7z1TJ3+D0o9k8wywcBwpJS0ITj41F4eEiv7rv07jBRMxM/Bv1vIuYIz2rtSteTRR95MEGKTXpGfp53SW2MY6d6Zwuckoi8H9IOp9yBtp5UWrGhPeFs9Bqz2oHJZfOZg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:12:54.2711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68519819-4b41-45f3-4fef-08deff9f0eee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073
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

From: "Stanley.Yang" <Stanley.Yang@amd.com>

Add dacee_be, ucie_pcs, lsdma aca blocks mapping,
add pcs_xgmi aca block info.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.h          |  3 ++
 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c | 54 +++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.h b/drivers/gpu/drm/amd/ras/core/aca.h
index 759119bed870c..e428bf53f3ea8 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.h
+++ b/drivers/gpu/drm/amd/ras/core/aca.h
@@ -71,6 +71,9 @@ enum aca_ecc_hwip {
 	ACA_ECC_HWIP__MMHUB,
 	ACA_ECC_HWIP__MPIFOE,
 	ACA_ECC_HWIP__PCIE_PL,
+	ACA_ECC_HWIP__DACC_BE,
+	ACA_ECC_HWIP__UCIE_PCS,
+	ACA_ECC_HWIP__LSDMA,
 	ACA_ECC_HWIP_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
index fe3942f54afc5..2c8dcc5886f3c 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
@@ -50,6 +50,9 @@ static const u32 sdma_aca_types[] =   {0x00};
 static const u32 mmhub_aca_types[] =  {0x00};
 static const u32 mpifoe_aca_types[] = {0x00};
 static const u32 pcie_pl_aca_types[] = {0x00};
+static const u32 dacc_be_aca_types[] = {0x00};
+static const u32 ucie_pcs_aca_types[] = {0x00};
+static const u32 lsdma_aca_types[] = {0x00};
 
 static struct ras_aca_hwip_v5 aca_hwip_maps[] = {
 	ACA_HWIP_MAP(SMU,      0x01,  smu_aca_types),
@@ -62,6 +65,9 @@ static struct ras_aca_hwip_v5 aca_hwip_maps[] = {
 	ACA_HWIP_MAP(MMHUB,    0x73,  mmhub_aca_types),
 	ACA_HWIP_MAP(MPIFOE,   0x1FD, mpifoe_aca_types),
 	ACA_HWIP_MAP(PCIE_PL,  0x1E1, pcie_pl_aca_types),
+	ACA_HWIP_MAP(DACC_BE,  0x164, dacc_be_aca_types),
+	ACA_HWIP_MAP(UCIE_PCS, 0x16C, ucie_pcs_aca_types),
+	ACA_HWIP_MAP(LSDMA,    0x346, lsdma_aca_types),
 };
 
 static void aca_decode_bank_info(struct aca_block *aca_blk,
@@ -344,6 +350,50 @@ static const struct aca_block_info aca_v5_0_pcie_pl = {
 	},
 };
 
+static const struct aca_block_info aca_v5_0_dacc_be = {
+	.name = "dacc_be",
+	.ras_block_id = RAS_BLOCK_ID__DACC_BE,
+	.hwip = ACA_ECC_HWIP__DACC_BE,
+	.mask = ACA_ERROR__UE_MASK | ACA_ERROR__CE_MASK,
+	.bank_ops = {
+		.bank_match = aca_match_bank_default,
+		.bank_parse = aca_parse_bank_default,
+	},
+};
+
+static const struct aca_block_info aca_v5_0_ucie_pcs = {
+	.name = "ucie_pcs",
+	.ras_block_id = RAS_BLOCK_ID__UCIE_PCS,
+	.hwip = ACA_ECC_HWIP__UCIE_PCS,
+	.mask = ACA_ERROR__UE_MASK | ACA_ERROR__CE_MASK,
+	.bank_ops = {
+		.bank_match = aca_match_bank_default,
+		.bank_parse = aca_parse_bank_default,
+	},
+};
+
+static const struct aca_block_info aca_v5_0_lsdma = {
+	.name = "lsdma",
+	.ras_block_id = RAS_BLOCK_ID__LSDMA,
+	.hwip = ACA_ECC_HWIP__LSDMA,
+	.mask = ACA_ERROR__UE_MASK | ACA_ERROR__CE_MASK,
+	.bank_ops = {
+		.bank_match = aca_match_bank_default,
+		.bank_parse = aca_parse_bank_default,
+	},
+};
+
+static const struct aca_block_info aca_v5_0_pcs_xgmi = {
+	.name = "pcs_xgmi",
+	.ras_block_id = RAS_BLOCK_ID__PCS_XGMI,
+	.hwip = ACA_ECC_HWIP__PCS_XGMI,
+	.mask = ACA_ERROR__UE_MASK | ACA_ERROR__CE_MASK,
+	.bank_ops = {
+		.bank_match = aca_match_bank_default,
+		.bank_parse = aca_parse_bank_default,
+	},
+};
+
 static const struct aca_block_info *aca_block_info_v5_0[] = {
 	&aca_v5_0_umc,
 	&aca_v5_0_gfx,
@@ -351,6 +401,10 @@ static const struct aca_block_info *aca_block_info_v5_0[] = {
 	&aca_v5_0_mmhub,
 	&aca_v5_0_xgmi,
 	&aca_v5_0_pcie_pl,
+	&aca_v5_0_dacc_be,
+	&aca_v5_0_ucie_pcs,
+	&aca_v5_0_lsdma,
+	&aca_v5_0_pcs_xgmi,
 };
 
 static u64 aca_parse_ras_caps_v5_0(struct ras_core_context *ras_core)
-- 
2.55.0

