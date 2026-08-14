Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC79C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1523010F6F3;
	Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="owzuYA+t";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1355410F6EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6x6XWZ5LMyDHT3AOHRCpXyQgXbN7Y7tvq/RLd04XsovtrF18SrvgV6tP7u3w+Tm+FuPOwvbFRCIAYwCWlqXLTm+TfCo5nuseZj+VQvCw+OmfInnzlOaI3U+GT3RjNwIPxiRhecfmjrOiTyUmSRb8bAVmJEO7fPrPtAGh4nIZAHlQ0II/m8zqr/sS1jgpD02PEiyUOtVX6SsUZVqVB6tY+a0aDBuWeNA/8YJN4/5NqS/jxJZlyc4GL2kstkQ+QOemBGXJ70H/LRNrTE6WpzNzhvR5i64Pkv6j6ySaPJXGQkjtDNoGhOQf+cCos1hT6IOZdrD9KIZuxal0x7McI8fVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iB0QcKtWVxV/+SgEuUORIwKuYHgFpZqyVIcODshz8o=;
 b=QtvQej4RWixX2dalCWiXdRPkJyhJO/amd7F26nfgO/ThqiLaklZvQg2yUnIWp+RBuMZ3CS+7KyRjL9fUx1LyHINi4drXHGmIdo1pIaxOZAurNrg6Ot9e5ME3Y7oCsibFZ97RWHo3706VSsNvBhP2Je5EHEJTnRFj8ynKEGa+xvsOmVTBmLNrI9I6gXwhmBNlsF+FZsV1gnPyUfK+8d0pan0snko+S0/wNe87gYqGmgxv6imncL+BtBoGLy4n2MVcwIaiBaSuFYBUI3MAPEd1RgJWuMn79mut30kJLA9qbeS/K/PqH1sklZTuRDzHtNimGQuxXLqtEw9zPS9Ax8j/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iB0QcKtWVxV/+SgEuUORIwKuYHgFpZqyVIcODshz8o=;
 b=owzuYA+tzIKZN+BsFcM+TmNtw7O+wrwQsozCZ0BDqTU8Tzkgcsal6h9CYva/06TOLJungZ4aiF2YFEcHHYTPO8OvQlae8vYL3w/rBfRLL3mUzSvLgTtXbG+mhOcj1MwpCiQpQPza26e4kv57IocBw8LzKxjdteP9Aybmu+uo5mQ=
Received: from BN9PR03CA0496.namprd03.prod.outlook.com (2603:10b6:408:130::21)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:21 +0000
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
 2026 16:03:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 023/109] drm/amd/ras: Support querying RAS driver capabilities
Date: Fri, 14 Aug 2026 17:01:20 -0400
Message-ID: <20260814210246.3067612-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 1985744b-8c2f-4827-a1ad-08defa4778e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NWCBi/E44db9HQ6/rfM7bPR/RyzZLIL9COusubekqYbaRw9IsSsQwD+KHNCQXYnhau1uapSfl7SH2VwWPKkJlwJ25GmDB1pu7jghhu3DNsvRtXkcawxU9WCZjyPOqSaPVe2a7EorzB18B2g9YvSD1hySvBFkeFdlfHPyBOuu1fKzGuFFDDgTDIRdzzMJbGeUIddRRoBYcT2cvja96p+ujw0lATN5RCG8rx0JUwCZJx/GCBSEDwsPXX1d+h1QGwURHwOP7H6hQc94aEGpxjYaKPWS0Gbo0qjJ/Bj0MUg3QsoWV57MrOafXaIEqpD2HN5UvwezLpV35nPVdi2byKdDdk72BazuVA7Ib+5kV+tYLleYBeoRx0nkNMemo/x3xH30pvzqRlGxUezyFPOYPDUne5NbMRwF0xTQBKk/Gg/6LME8sw9x6ZOtemN9hF+Ny28X/v9vRnCJfYQmeQJdYvx018k/h2auUIQJSckh55n8/LOhOVV7vZtRhf7iMTInSxZwxeJ4MnXIrGolEllyQpYB94NvTMl3DeTU7x75gsVY4DoTIRY6RwI2PPxR2Ng04BBRIQi/xELXHELjFgcaoMBarlxSHgjACV2W3Cak5alYz7MRmp+2r+P3yvF+5myL7VF2eVEMAXnHvC8uP4v6IJXxZk+iqddH9efrNU5CkO/sqB89GJxv/uWnDmkCmsE3p25ohl9e8q0u8EytfRT5XuOc+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tc3WkOvTGL8Dy3zS+4B6Frup3mzm+rgOKxPdv4hZm4Fj/XdmImzo0l09M5vD1Fu5D2t6MWuRp8OZQ0Ml7FIa+1mgNFTYWJd+Ks2xrN2KXd5Vhl18rYULr56d2eBbIH0Ih0suuaLbL8LqkppEr7NiteYDvDXiuUwIfaGIyXxBdzhslEcEX4rdCtJlzEa90seo2BNJ8wVwkxC5kevspojB3m6jP/wMLxdGgT6L4Q3pd1D0mx5B3jxLjqXswLXUJAYtRob0f9suFPXNaFuImJUMlVkm1LYok1SYPr1s1o/Xg072lk1RDzUMrM/1i/6YL0tZHWd0gWTn+itRgpstiGgdqhKq6iKfhZ3+TGIt9rE13mCt80PEgWpnXo5fmQUOH260D5tX9oHsQsfzMkT32f9/7qVi6XgpQAxyyuF1i4AxLi3nx8L11Nxaop9cTR9wWkws
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:21.0707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1985744b-8c2f-4827-a1ad-08defa4778e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466
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

Support querying RAS driver capabilities:
1. Generate ras block bitmask for HW.
   -- Read ras hw capabilities from registers.
   -- Convert hw ras block bitmask to driver ras block bitmask.
2. Generate ras block bitmask for SW.
3. Add interfaces to query RAS capabilities.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c            | 10 +++++
 drivers/gpu/drm/amd/ras/core/aca.h            |  2 +
 drivers/gpu/drm/amd/ras/core/aca_v1_0.c       | 13 ++++++
 drivers/gpu/drm/amd/ras/core/core.c           | 23 ++++++++++
 drivers/gpu/drm/amd/ras/core/ras.h            |  5 ++-
 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c   | 13 ++++++
 drivers/gpu/drm/amd/ras/core/ras_psp.c        | 26 ++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_psp.h        | 25 +++++++++++
 drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c  | 42 +++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c  | 41 ++++++++++++++++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 10 ++---
 11 files changed, 204 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index 8bb93ca61b18a..6d7cfef543622 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -701,3 +701,13 @@ int ras_aca_parse_bank(struct ras_core_context *ras_core,
 
 	return ret;
 }
+
+u64 ras_aca_get_parser_caps(struct ras_core_context *ras_core)
+{
+	struct ras_aca *ras_aca = &ras_core->ras_aca;
+
+	if (ras_aca->ip_func && ras_aca->ip_func->aca_parse_ras_caps)
+		return ras_aca->ip_func->aca_parse_ras_caps(ras_core);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/core/aca.h b/drivers/gpu/drm/amd/ras/core/aca.h
index a9538e64d7d53..b19b6e7089f28 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.h
+++ b/drivers/gpu/drm/amd/ras/core/aca.h
@@ -145,6 +145,7 @@ struct aca_block {
 struct ras_aca_ip_func {
 	uint32_t block_num;
 	const struct aca_block_info **block_info;
+	u64 (*aca_parse_ras_caps)(struct ras_core_context *ras_core);
 };
 
 struct ras_aca {
@@ -169,4 +170,5 @@ void ras_aca_clear_fatal_flag(struct ras_core_context *ras_core);
 int ras_aca_parse_bank(struct ras_core_context *ras_core,
 				struct aca_bank_reg *bank,
 				struct aca_bank_ecc *ecc);
+u64 ras_aca_get_parser_caps(struct ras_core_context *ras_core);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/aca_v1_0.c b/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
index a8b413270de37..c2fba818a4629 100644
--- a/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
+++ b/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
@@ -372,7 +372,20 @@ static const struct aca_block_info *aca_block_info_v1_0[] = {
 	&aca_v1_0_xgmi,
 };
 
+static u64 aca_parse_ras_caps_v1_0(struct ras_core_context *ras_core)
+{
+	u64 parser_supported_mask = 0;
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(aca_block_info_v1_0); i++)
+		parser_supported_mask |=
+			BIT_ULL(aca_block_info_v1_0[i]->ras_block_id);
+
+	return parser_supported_mask;
+}
+
 const struct ras_aca_ip_func ras_aca_func_v1_0 = {
 	.block_num = ARRAY_SIZE(aca_block_info_v1_0),
 	.block_info = aca_block_info_v1_0,
+	.aca_parse_ras_caps = aca_parse_ras_caps_v1_0,
 };
diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index aad95bf3fa180..079032433a916 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -761,3 +761,26 @@ int ras_core_get_eeprom_version(struct ras_core_context *ras_core,
 {
 	return ras_eeprom_get_version(ras_core, version);
 }
+
+uint64_t ras_core_get_ras_caps(struct ras_core_context *ras_core)
+{
+	uint64_t ras_hw_caps,  ras_drv_caps;
+
+	if (!ras_core)
+		return 0;
+
+	ras_hw_caps = ras_psp_get_hw_ras_caps(ras_core);
+	ras_drv_caps = ras_aca_get_parser_caps(ras_core);
+
+	return ras_hw_caps & ras_drv_caps;
+}
+
+bool ras_core_poison_supported(struct ras_core_context *ras_core)
+{
+	if (!ras_core)
+		return false;
+
+	/* For some ASICs, poison flag is detected externally by uniras module. */
+	return ras_core->poison_supported ? true :
+			ras_psp_poison_supported(ras_core);
+}
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index dc590867d82a3..e28d51b1992ef 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -103,7 +103,8 @@ enum ras_block_id {
 	RAS_BLOCK_ID__SSBDCI,
 	RAS_BLOCK_ID__UCIE_PCS,
 
-	RAS_BLOCK_ID__LAST
+	RAS_BLOCK_ID__LAST,
+	MAX_SUPPORTED_RAS_BLOCK_ID  = MAX_RAS_BLOCK_MASK_BITS
 };
 
 enum ras_ecc_err_type {
@@ -448,4 +449,6 @@ int ras_core_get_eeprom_version(struct ras_core_context *ras_core,
 	uint32_t *version);
 int ras_core_get_ip_version(struct ras_core_context *ras_core,
 	enum ras_unit_id unit_id, uint32_t *version);
+uint64_t ras_core_get_ras_caps(struct ras_core_context *ras_core);
+bool ras_core_poison_supported(struct ras_core_context *ras_core);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
index 15e72d4b492d0..3074f8c3f3164 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
@@ -348,7 +348,20 @@ static const struct aca_block_info *aca_block_info_v5_0[] = {
 	&aca_v5_0_xgmi,
 };
 
+static u64 aca_parse_ras_caps_v5_0(struct ras_core_context *ras_core)
+{
+	u64 parser_supported_mask = 0;
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(aca_block_info_v5_0); i++)
+		parser_supported_mask |=
+			BIT_ULL(aca_block_info_v5_0[i]->ras_block_id);
+
+	return parser_supported_mask;
+}
+
 const struct ras_aca_ip_func ras_aca_func_v5_0 = {
 	.block_num = ARRAY_SIZE(aca_block_info_v5_0),
 	.block_info = aca_block_info_v5_0,
+	.aca_parse_ras_caps = aca_parse_ras_caps_v5_0,
 };
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index 5628b384a7333..da49ee79711d9 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -720,6 +720,11 @@ int ras_psp_hw_init(struct ras_core_context *ras_core)
 		psp->ip_func->get_ras_block_maps(ras_core,
 			&psp->blk_maps, &psp->maps_size))
 		return -EINVAL;
+
+	if (psp->ip_func->get_ras_hw_caps &&
+		psp->ip_func->get_ras_hw_caps(ras_core, &psp->ras_hw_caps))
+		return -EINVAL;
+
 	/* After GPU reset, the system RAS PSP status may change.
 	 * therefore, it is necessary to synchronize the system status again.
 	 */
@@ -783,3 +788,24 @@ int ras_psp_get_block_ta_id(struct ras_core_context *ras_core,
 
 	return -RAS_CORE_NOT_SUPPORTED;
 }
+
+bool ras_psp_poison_supported(struct ras_core_context *ras_core)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+
+	return psp->ras_hw_caps.poison_supported;
+}
+
+bool ras_psp_flex_mca_enabled(struct ras_core_context *ras_core)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+
+	return psp->ras_hw_caps.flex_mca_enabled;
+}
+
+uint64_t ras_psp_get_hw_ras_caps(struct ras_core_context *ras_core)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+
+	return psp->ras_hw_caps.features.block_mask;
+}
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.h b/drivers/gpu/drm/amd/ras/core/ras_psp.h
index 5265408ddafea..dbc06c85d4aec 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.h
@@ -26,6 +26,8 @@
 #include "ras.h"
 #include "ta_if.h"
 
+#define MAX_RAS_BLOCK_MASK_BITS 56
+
 struct ras_core_context;
 struct ras_ta_trigger_error_input;
 struct ras_ta_query_address_input;
@@ -68,11 +70,30 @@ struct ras_block_map {
 	uint32_t ras_id;
 	uint32_t ta_id;
 };
+
+union ras_feature {
+	struct {
+		uint64_t block_mask : MAX_RAS_BLOCK_MASK_BITS;
+		uint64_t rsv: 4;
+		uint64_t tag: 3;
+		uint64_t en : 1;
+	};
+	uint64_t value;
+};
+
+struct ras_hw_caps {
+	bool poison_supported;
+	bool flex_mca_enabled;
+	union ras_feature features;
+};
+
 struct ras_psp_ip_func {
 	uint32_t (*psp_ras_ring_wptr_get)(struct ras_core_context *ras_core);
 	int (*psp_ras_ring_wptr_set)(struct ras_core_context *ras_core, uint32_t wptr);
 	int (*get_ras_block_maps)(struct ras_core_context *ras_core,
 			struct ras_block_map **blk_maps, uint32_t *maps_size);
+	int (*get_ras_hw_caps)(struct ras_core_context *ras_core,
+			struct ras_hw_caps *ras_cap);
 };
 
 struct ras_psp_ring {
@@ -116,6 +137,7 @@ struct ras_psp {
 	uint32_t psp_ip_version;
 	struct ras_block_map *blk_maps;
 	uint32_t maps_size;
+	struct ras_hw_caps ras_hw_caps;
 	struct ras_psp_ring psp_ring;
 	struct ras_psp_ctx  psp_ctx;
 	struct ras_ta_ctx   ta_ctx;
@@ -153,4 +175,7 @@ bool ras_psp_check_supported_cmd(struct ras_core_context *ras_core,
 		enum ras_ta_cmd_id cmd_id);
 int ras_psp_get_block_ta_id(struct ras_core_context *ras_core,
 		uint32_t ras_id, uint32_t *ta_id);
+bool ras_psp_poison_supported(struct ras_core_context *ras_core);
+bool ras_psp_flex_mca_enabled(struct ras_core_context *ras_core);
+uint64_t ras_psp_get_hw_ras_caps(struct ras_core_context *ras_core);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c b/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
index 92e617eca8791..49ba57f58878c 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
@@ -27,6 +27,9 @@
 
 #define regMP0_SMN_C2PMSG_67                           0x0083
 #define regMP0_SMN_C2PMSG_67_BASE_IDX                  0
+#define regMP0_SMN_C2PMSG_127                          0x00bf
+#define regMP0_SMN_C2PMSG_127_BASE_IDX                 0
+
 static struct ras_block_map   ras_block_maps_v13_0[] = {
 	{RAS_BLOCK_ID__UMC,       RAS_TA_BLOCK__UMC},
 	{RAS_BLOCK_ID__SDMA,      RAS_TA_BLOCK__SDMA},
@@ -73,8 +76,47 @@ static int ras_psp_v13_0_get_ras_block_maps(struct ras_core_context *ras_core,
 
 	return 0;
 }
+
+static int ras_psp_v13_0_get_ras_hw_caps(struct ras_core_context *ras_core,
+				struct ras_hw_caps *ras_cap)
+{
+	uint32_t ras_hw_cap, bit;
+	uint32_t i;
+
+	if (!ras_cap)
+		return -EINVAL;
+
+	ras_hw_cap = RAS_DEV_RREG32_SOC15(ras_core->dev, MP0, 0, regMP0_SMN_C2PMSG_127);
+
+	ras_cap->poison_supported = true;
+	ras_cap->flex_mca_enabled = false;
+
+	ras_cap->features.value = 0;
+	for (bit = 0; bit <= 29; bit++) {
+		if (!(ras_hw_cap & BIT_ULL(bit)))
+			continue;
+
+		for (i = 0; i < ARRAY_SIZE(ras_block_maps_v13_0); i++) {
+			if (ras_block_maps_v13_0[i].ta_id == bit) {
+				if (ras_block_maps_v13_0[i].ras_id < MAX_SUPPORTED_RAS_BLOCK_ID)
+					ras_cap->features.block_mask |=
+						BIT_ULL(ras_block_maps_v13_0[i].ras_id);
+				else
+					RAS_DEV_WARN(ras_core->dev,
+						"RAS block maps v13 error: invalid ras block id %u\n",
+						ras_block_maps_v13_0[i].ras_id);
+
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
 const struct ras_psp_ip_func ras_psp_v13_0 = {
 	.psp_ras_ring_wptr_get = ras_psp_v13_0_ring_wptr_get,
 	.psp_ras_ring_wptr_set = ras_psp_v13_0_ring_wptr_set,
 	.get_ras_block_maps = ras_psp_v13_0_get_ras_block_maps,
+	.get_ras_hw_caps = ras_psp_v13_0_get_ras_hw_caps,
 };
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c b/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c
index 74f00eec40782..e3cae8c94b28f 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c
@@ -28,6 +28,8 @@
 
 #define regMPASP_SMN_C2PMSG_67                           0x0083
 #define regMPASP_SMN_C2PMSG_67_BASE_IDX                  1
+#define regMPASP_SMN_C2PMSG_127                          0x00bf
+#define regMPASP_SMN_C2PMSG_127_BASE_IDX                 1
 
 static struct ras_block_map   ras_block_maps_v15_0[] = {
 	{RAS_BLOCK_ID__UMC,         RAS_TA_MPASP_BLOCK__UMC},
@@ -85,8 +87,47 @@ static int ras_psp_v15_0_get_ras_block_maps(struct ras_core_context *ras_core,
 
 	return 0;
 }
+
+static int ras_psp_v15_0_get_ras_hw_caps(struct ras_core_context *ras_core,
+				struct ras_hw_caps *ras_cap)
+{
+	uint32_t ras_hw_cap, bit;
+	uint32_t i;
+
+	if (!ras_cap)
+		return -EINVAL;
+
+	ras_hw_cap = RAS_DEV_RREG32_SOC15(ras_core->dev,
+				MP0, 0, regMPASP_SMN_C2PMSG_127);
+
+	ras_cap->poison_supported = (ras_hw_cap & BIT_ULL(31)) ? true : false;
+	ras_cap->flex_mca_enabled = (ras_hw_cap & BIT_ULL(30)) ? true : false;
+
+	ras_cap->features.value = 0;
+	for (bit = 0; bit <= 29; bit++) {
+		if (!(ras_hw_cap & BIT_ULL(bit)))
+			continue;
+
+		for (i = 0; i < ARRAY_SIZE(ras_block_maps_v15_0); i++) {
+			if (ras_block_maps_v15_0[i].ta_id == bit) {
+				if (ras_block_maps_v15_0[i].ras_id < MAX_SUPPORTED_RAS_BLOCK_ID)
+					ras_cap->features.block_mask |=
+						BIT_ULL(ras_block_maps_v15_0[i].ras_id);
+				else
+					RAS_DEV_WARN(ras_core->dev,
+						"RAS block maps v15 error: invalid ras block id %u\n",
+						ras_block_maps_v15_0[i].ras_id);
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
 const struct ras_psp_ip_func ras_psp_v15_0 = {
 	.psp_ras_ring_wptr_get = ras_psp_v15_0_ring_wptr_get,
 	.psp_ras_ring_wptr_set = ras_psp_v15_0_ring_wptr_set,
 	.get_ras_block_maps = ras_psp_v15_0_get_ras_block_maps,
+	.get_ras_hw_caps = ras_psp_v15_0_get_ras_hw_caps,
 };
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 1b23ffffc415c..3b8d61785a897 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -269,7 +269,7 @@ static int amdgpu_ras_mgr_get_ras_ta_init_param(struct ras_core_context *ras_cor
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
 	uint32_t nps_mode;
 
-	if (amdgpu_ras_is_poison_mode_supported(adev))
+	if (ras_core_poison_supported(ras_core))
 		ras_ta_param->poison_mode_en = 1;
 
 	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
@@ -624,7 +624,7 @@ int amdgpu_ras_mgr_handle_controller_interrupt(struct amdgpu_device *adev, void
 		return -EPERM;
 
 	if (ih_info && (ih_info->block == AMDGPU_RAS_BLOCK__UMC)) {
-		if (ras_mgr->ras_core->poison_supported) {
+		if (ras_core_poison_supported(ras_mgr->ras_core)) {
 			seq_no = amdgpu_ras_mgr_gen_ras_event_seqno(adev, RAS_SEQNO_TYPE_DE);
 			RAS_DEV_INFO(adev,
 				"{%llu} RAS poison is created, no user action is needed.\n",
@@ -632,7 +632,7 @@ int amdgpu_ras_mgr_handle_controller_interrupt(struct amdgpu_device *adev, void
 		}
 
 		ret = amdgpu_ras_process_handle_umc_interrupt(adev, ih_info);
-	} else if (ras_mgr->ras_core->poison_supported) {
+	} else if (ras_core_poison_supported(ras_mgr->ras_core)) {
 		ret = amdgpu_ras_process_handle_unexpected_interrupt(adev, ih_info);
 	} else {
 		RAS_DEV_WARN(adev,
@@ -655,7 +655,7 @@ int amdgpu_ras_mgr_dispatch_interrupt(struct amdgpu_device *adev, struct ras_ih_
 		return 0;
 
 	if (ih_info->block == RAS_BLOCK_ID__UMC) {
-		if (ras_mgr->ras_core->poison_supported) {
+		if (ras_core_poison_supported(ras_mgr->ras_core)) {
 			seq_no = amdgpu_ras_mgr_gen_ras_event_seqno(adev, RAS_SEQNO_TYPE_DE);
 			RAS_DEV_INFO(adev,
 				"{%llu} RAS poison is created, no user action is needed.\n",
@@ -663,7 +663,7 @@ int amdgpu_ras_mgr_dispatch_interrupt(struct amdgpu_device *adev, struct ras_ih_
 		}
 
 		ret = amdgpu_ras_process_handle_umc_interrupt(adev, ih_info);
-	} else if (ras_mgr->ras_core->poison_supported) {
+	} else if (ras_core_poison_supported(ras_mgr->ras_core)) {
 		ret = amdgpu_ras_process_handle_consumption_interrupt(adev, ih_info);
 	} else {
 		RAS_DEV_WARN(adev,
-- 
2.55.0

