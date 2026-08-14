Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B45DC5DF74
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674C710F71E;
	Fri, 14 Aug 2026 21:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KSaDw/od";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBEA510F715
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yq/0IuH4fk/XhiXK1j8uUi91Pm9A+3W+Vbzmie5HxtONmtXgSsPOzFiCkXO3whS4S0AreCgd2UbVuwvHu56H9+2/v81g9l4zrfNGd7AkWAMx2jGZMtJU4+O3A92YQ+pZMR2xgbYbo3eqmgLHOodIm6nXlEkMwM45zIOfWxh4YWHCDbuQfmUIvgZ6OsbSvkptZET1Di6ibQ68NjGnhHhnyasPkk1s6ABhDbPrPfn7uGFsEPSQTAsX7DVH2OAe2W0vTQDhZyCVELtF+XGD1wxfsHHf8jipTmMVOO9GwwsoPjOx7GU7z0XFFgyhzQgpTvp7c5TQ6/jE0yV1lZA6/QiGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HNEF4JWMuSNPhluxjB1CbXfzILsJsaxYrDdu8HR58c=;
 b=mju9ogsBoz2e5KO2Mwm1tCqJypA/wff+GBBmhk2S54MCS3wt1AhIZsn7ZO+TLIiSda8ovscKcB9syNmwqWFQARLMSarOgyVRFpUMnBtJywcX6SM+qEIPGLqDvIgPIzp/OvNXqc7ippOn0tWSQp/cBca/AEO+lgxJulASHDGW8mLemkoY6PpzlkR0/RgCp3XOH/EFed8bBHJwmp4ZQLD4+sdzRdccXTKyW907XJsCDth6ji99jZiKCnrXtQ/c94sQkClf1SPJpthX9IIuBIoMLtG8SmdvKZz31LIo1rjUpaQzH7GwUkmDyp+Y/uR+a7YpzQ8MYwVp6zbU6x1zLlKnUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HNEF4JWMuSNPhluxjB1CbXfzILsJsaxYrDdu8HR58c=;
 b=KSaDw/odWlDcpzC23l4y3PxFcOJXouFOyWg9/zIwu0b07+HNvtcFa7DLZlD6C/aOqRXfEYDH3q8FWIVsaNI7a/k9qWY5EwQOGzPzgdAnpYFyFGu5G909z+w6BQWP8aG+qwLrw+qLDyeahwtTcAhwM0XaV61OwOGWIQfocouyF5U=
Received: from SJ0PR13CA0204.namprd13.prod.outlook.com (2603:10b6:a03:2c3::29)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 21:03:45 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::2b) by SJ0PR13CA0204.outlook.office365.com
 (2603:10b6:a03:2c3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Fri, 14
 Aug 2026 21:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Stanley.Yang <Stanley.Yang@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 073/109] drm/amd/ras: add PCIE_PL ACA block mapping
Date: Fri, 14 Aug 2026 17:02:10 -0400
Message-ID: <20260814210246.3067612-74-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e50eef-90b2-4019-85ad-08defa4786f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aHh55BelQfjSliiTxSe3XfEDjpYM7GJYa/anDhNplKVc5cvdzDlVPE17ej8aoZdKDDCmA2D94skfGLg6uJOM8APRE30mVzFSBKPpThNb1BRdQFwTvuY/t7t7LTNMRVbaiZPgz6ynE1AKylebrX3LMiJ7U+/s/Br1eY07ES/RHK94tdo3mNFkYQrcTu82u3rJ7J3+ifGM2JNv83z3IGfseDatLP3AVKGCUEOkwZaJC3SvD9taJiiPZXtXRbs18Egd8tOqO+CcAvc27GKy5cC7jfS7sUtdX35TfNQM882juMO2EqybtpZ/CxOhp00EzokATKJ0/Gy/AuEcBq4bQGKT0dCxnRBOPRih+V/2VVRPCEwS3Oq6myyqf/9fQTgR1olyOx7zyQ1E1PXYExOTaUM72/5QVUJkGfwPcPgwBm7gpLbRhzXF6T0TbReLh6QQhInaW/Pz8iaC7FC8l5UkFuCDrIVp7/oSgkTn4mA6iGKgh7I7JlVGwFqtehsh9hVCO7b2rQDirur0XZ7liZ7Iz+txD/8TGfjkIzjjawXHPBG++RQtAL6FdTF7B7LfI1b9ya6zMq22FyK2BUofbkWLPzO/7L8GMavwh3xGDltz6kNyD6WNc4v6BIfQReShBC1vRRgOB4V+nCnT3qbSu5NKTfA5pDZqQeK/TEQQyzYKqGiyDvggR+jVg5/3E48NA7kR3onJhMU6yYRyVqt7nHIAMUa79g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eEqvDCIs+3LlDmImTAKNJGw96upfj+8XJEky6iUft7ZAIJZX8t8jK+EWZDlU9lJV/Mi7/shdzGPlevwhld8T02uv0vBHS451Phkwk7h94FjWbZ1lKKlXV8t2hQuczt5hx0erTxvSk9BZrzmovmAIqfYKh6y1H2nz5PNlHcoUECpo+KeP9HQSqVLNYrAHJ13XfcXhcCrmQ21p+P8tO9JXmZOg/0B1iG7Xq7AC1WUmuzSykVGG07mbmD7O91ktftSZ5zrHexZMB2aJyP2GPUltZluGt5KckoykrUWmHlh5yiQK5vPXJxjrhnOtwrZc/LNf8PlL6HRytkQYCuDsj4rVtOP+1N715ok9n0t3880++vcroxpwqMwXZbRepXFZCSX6G8ZcW91KkEO8zwsuivo0Yj4u1sCZSKPH29kXqPPj4QG4qgkXA5vxjntFlweu9E+B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:44.5762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e50eef-90b2-4019-85ad-08defa4786f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197
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

From: Xiang Liu <xiang.liu@amd.com>

Add the PCIE_PL ACA HWIP mapping for ACA v5 hardware so MCE banks
with HWID 0x1e1 and ACA type 0x0 can be decoded by the RAS ACA path.

Register PCIE_PL as a RAS block using the default ACA bank match and
parse helpers, matching the other simple v5 block mappings.

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.h          |  1 +
 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.h b/drivers/gpu/drm/amd/ras/core/aca.h
index d3e2e1ac7b6ad..518351fe187aa 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.h
+++ b/drivers/gpu/drm/amd/ras/core/aca.h
@@ -68,6 +68,7 @@ enum aca_ecc_hwip {
 	ACA_ECC_HWIP__SDMA,
 	ACA_ECC_HWIP__MMHUB,
 	ACA_ECC_HWIP__MPIFOE,
+	ACA_ECC_HWIP__PCIE_PL,
 	ACA_ECC_HWIP_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
index 41290ec3b49d9..60d087d977b14 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
@@ -49,6 +49,7 @@ static const u32 gfx_sdma_aca_types[] = {0x11};
 static const u32 sdma_aca_types[] =   {0x00};
 static const u32 mmhub_aca_types[] =  {0x00};
 static const u32 mpifoe_aca_types[] = {0x00};
+static const u32 pcie_pl_aca_types[] = {0x00};
 
 static struct ras_aca_hwip_v5 aca_hwip_maps[] = {
 	ACA_HWIP_MAP(SMU,      0x01,  smu_aca_types),
@@ -60,6 +61,7 @@ static struct ras_aca_hwip_v5 aca_hwip_maps[] = {
 	ACA_HWIP_MAP(SDMA,     0x15A, sdma_aca_types),
 	ACA_HWIP_MAP(MMHUB,    0x73,  mmhub_aca_types),
 	ACA_HWIP_MAP(MPIFOE,   0x1FD, mpifoe_aca_types),
+	ACA_HWIP_MAP(PCIE_PL,  0x1E1, pcie_pl_aca_types),
 };
 
 static void aca_decode_bank_info(struct aca_block *aca_blk,
@@ -314,12 +316,24 @@ static const struct aca_block_info aca_v5_0_xgmi = {
 	},
 };
 
+static const struct aca_block_info aca_v5_0_pcie_pl = {
+	.name = "pcie_pl",
+	.ras_block_id = RAS_BLOCK_ID__PCIE_PL,
+	.hwip = ACA_ECC_HWIP__PCIE_PL,
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
 	&aca_v5_0_sdma,
 	&aca_v5_0_mmhub,
 	&aca_v5_0_xgmi,
+	&aca_v5_0_pcie_pl,
 };
 
 static u64 aca_parse_ras_caps_v5_0(struct ras_core_context *ras_core)
-- 
2.55.0

