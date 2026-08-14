Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDDAC5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 150D710F718;
	Fri, 14 Aug 2026 21:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0o9Qin6j";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8905D10F71F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trDKGGAe3a2eDBWMQxQsGY9knkD+GBWBWkq31gzwkop3nnwQFCagIWWkX8W2g+yuWuVCEXfzzRnpK+iuKEaMsIhWtAvfYhEeNJtuzYXyDw7cKqUA6/jkB9QUElpQSCjzm+vcGYYBH1evr7kjV0sXOjREgZfY/dd1Lk6qVVW2Dig7QLXHTgvVygnWoL1+crPQHbBtLFrj0DE6DdkmVAKT9oD9PfykCBrXOc6tHNjEZZMxN8RKWibZW7bdk/ZLXiA0/1hBumPfT9I3i3o/C39mRUfcciE6IiUDVHwzl02jj+0tGTjj1q3C8N0J8KlEk8XIa42D9z3JoDmSWOMFoXwdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAfTRebp6I7XRBbydy2GuJ+jI1P1cBp9IFK5hiT31aE=;
 b=W/MPwmuVtocsbzWws9wTS3E6b4sZ1jmvUTMiRFU4bbJUml3+pny7nEiBqJpK+SuNdT/SRudGLbgpzXdibYi6qRBy+6bfkgyuyLgkgZVmDzlWm3kUWd0uBC+aczm0myKdlBk+/Qm8DxHTvZ8koedlg9a4pu2/60SSB9ib6/TK3Sr7dp1h3a6lmA/UfvE/3ZSVI4uKQ0vzBvSd0N3uWBqNOTwSh2lJmrkQz5eZYC0CFnsxgM6urG2JHXLZwaUCJQBf6IonPy2s6r4IKYm3tHvwypq9fQ5UqeluuNPY9C9jmOBmCe5sk8jl05OQSvP4rznExW4UQtKUTxu3m1rlaR0Jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAfTRebp6I7XRBbydy2GuJ+jI1P1cBp9IFK5hiT31aE=;
 b=0o9Qin6jqJEcpeRLmdXvgcx/I3piLCtKogRUpuSkRqaRp5DQy5fMF0qq75yV4d6q/se3lEs9Sjib6drK+RrFsSEqReXk5kNzzEgcFpWWurgV5eBelBWPYvPVQDa6CDgjBRjOizCP/Eokih2V4uJ1UZ1lw4fkVailgCZ3L3g1PMk=
Received: from BN0PR10CA0009.namprd10.prod.outlook.com (2603:10b6:408:143::6)
 by MW4PR12MB7214.namprd12.prod.outlook.com (2603:10b6:303:229::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 21:03:49 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::83) by BN0PR10CA0009.outlook.office365.com
 (2603:10b6:408:143::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:44 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 078/109] drm/amdgpu/ras: use flip-bit mask to generalize bad
 page address derivation
Date: Fri, 14 Aug 2026 17:02:15 -0400
Message-ID: <20260814210246.3067612-79-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|MW4PR12MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 666f8b0a-98b9-421d-c23c-08defa478951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|6133799003|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: NQ//EmlQDvLuFdg7eD3+I/xkvHyBnlpSXsNwisJyHbh31wrBzfPMlVcH9dxMSnIrnXxz7zqH5nFP538rGIXeCFbAWwfG+IR8r4Y+5za60qwm2zGuItg5iPwu7vNXwjzQRNrPG6kWJr0hG1tP1gHTu4qBrjWhx8uhhgYuj0VZYXZ1AiLVhdrxWQ2EVIjMGjNsd7Qn9XQ7pGCAzcEIXSeo8JkovGpEvKMgbnZmNg61mr3cAxyGSwhs4nmgWqmL4NavqLwa+vjLiC79PfPJq9arDLW+Yjfk40cww3fde1N3DumL6EZXXqAEzG5nuf5dQwnXuHd5LUcjvdGlR5HAK/DoNB0vvKk9EzP3I1pjO1P1azxhocHn0Cuyj/KZi42fFmJCERdBgC40lZwU67aXKwm2r103VQKzAxwRyGedKO+8Ae9JJ2Tlmo0PL+1kCS17urLKPpgK3F/LIzCRrXWQFP+xUKo9CPJn0B2eejSJ6TQ2d7bpCbI9QPQNS/8638FxYRsvUNKmWMdL0fuVLd0cv7ammVAyYtPxlMJKYo+BkJiiydgr/E3DkxcrNfr7/bjvVZWy4lm+uwSgat1olvYbKJM7SVDmu/rc7cEesMwfv9Hm+3/Bpb9ue3phDcclcq/yaM1M6KysYLq3hZpCVjYMAVqijVBAHrp6vVPVX8YKoew0AUxrOEk3NMivozk4dGVnD0vPEjMKAfUgD27q/iWjtMlrWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: naR/XvthgLlLycfPsom6VGiqgFpcAyyuSH8n5vXtj14hyI3jplppLYjAygpnXiR0oRsTREKTnP9hgrR8yccvS3AT/uJZm88dWTLNhotVDfcXL1vF1t16GD2Dcb9wjWEKNQTfcxZQavg1Cg4czBllHALVmhMxmPE3XYmf9rKcfCj7zNO1i2uBZEdANOhle3QnpARame6sHu5A9oa3KxCirSIkVta/SkoEXVNf2RnfIxg/ANc4Pu9bUazpvx+8w4gafp1cWFft6IX7aK2N+M2j1zcMD6DUP4lJXOjdbUKquTWDu9HA8DhqCdoAMU4C718uniyQvePp+mpScz8mJYQmwq4+OxGAy9rill79hsQ78AgfS6FzZyGi0CFYd1DMVNP+PoKrGRYHBwy55ib6b0Iyly0ky8Hljor2txHydRUz36OQxm6Pg8JOIm0mEGT6ayCS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:48.6223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666f8b0a-98b9-421d-c23c-08defa478951
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214
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

Use flip-bit mask to generalize bad page address derivation in a row.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/eeprom.h        |   1 +
 drivers/gpu/drm/amd/ras/core/ras_umc.c       |  77 +++++++++++--
 drivers/gpu/drm/amd/ras/core/ras_umc.h       |   3 -
 drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c | 110 ++++++++++++++++---
 drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c |  49 ++++-----
 5 files changed, 181 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.h b/drivers/gpu/drm/amd/ras/core/eeprom.h
index ae22bb3f83187..bf721c2a11f1e 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.h
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.h
@@ -167,6 +167,7 @@ struct eeprom_umc_record {
 	 * used with cur_nps_retired_row_pfn to derive all bad page addresses
 	 */
 	uint64_t cur_nps_pa_flip_mask;
+	uint32_t cur_nps_valid_page_num;
 	uint32_t cur_nps_bank;
 	uint32_t cur_nps;
 	uint64_t ipid;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index cef5770a75a60..c30d11942a72b 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -177,19 +177,61 @@ int ras_umc_clear_logged_ecc(struct ras_core_context *ras_core)
 	return 0;
 }
 
+static int ras_umc_expand_row_pages(struct ras_core_context *ras_core,
+	struct eeprom_umc_record *record, uint64_t *page_pfns, uint32_t nr_page_pfns)
+{
+	uint64_t retired_addr = RAS_PFN_TO_ADDR(record->cur_nps_retired_row_pfn);
+	uint64_t flip_mask = record->cur_nps_pa_flip_mask;
+	uint64_t subset;
+	uint64_t row_pa, addr;
+	uint32_t count = 0;
+
+	if (!retired_addr || !flip_mask || !page_pfns || !nr_page_pfns)
+		return -ENOEXEC;
+
+	row_pa = retired_addr & ~(flip_mask);
+
+	if (count < nr_page_pfns)
+		page_pfns[count++] = RAS_ADDR_TO_PFN(row_pa);
+
+	subset = flip_mask;
+	while (subset) {
+		addr = row_pa ^ subset;
+
+		if (count >= nr_page_pfns)
+			break;
+
+		page_pfns[count++] = RAS_ADDR_TO_PFN(addr);
+
+		subset = (subset - 1) & flip_mask;
+	};
+
+	return count;
+}
+
 int ras_umc_convert_record_to_nps_pages(struct ras_core_context *ras_core,
 		struct eeprom_umc_record *record, uint32_t nps,
-		uint64_t *page_pfn, uint32_t max_pages)
+		uint64_t *page_pfns, uint32_t nr_page_pfns)
 {
-	int count = 0;
-	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	uint32_t new_nps;
+	int ret, count = 0;
 
-	if (!page_pfn || !max_pages)
+	if (!page_pfns || !nr_page_pfns || !record ||
+	    (record->cur_nps > UMC_MEMORY_PARTITION_MODE_NPS8))
 		return -EINVAL;
 
-	if (ras_umc->ip_func && ras_umc->ip_func->eeprom_record_to_nps_pages)
-		count = ras_umc->ip_func->eeprom_record_to_nps_pages(ras_core,
-					record, nps, page_pfn, max_pages);
+	if (!record->cur_nps || !record->cur_nps_retired_row_pfn ||
+	    !record->cur_nps_pa_flip_mask) {
+		new_nps = record->cur_nps ?
+			record->cur_nps : ras_core_get_curr_nps_mode(ras_core);
+		ret = ras_umc_record_to_nps_record(ras_core, record, new_nps);
+		if (ret)
+			return ret;
+	}
+
+	count = ras_umc_expand_row_pages(ras_core, record, page_pfns, nr_page_pfns);
+	if (count > 0)
+		record->cur_nps_valid_page_num = count;
 
 	return count;
 }
@@ -496,7 +538,7 @@ static bool ras_umc_check_retired_record(struct ras_core_context *ras_core,
 	int ret;
 
 	nps = ras_core_get_curr_nps_mode(ras_core);
-	ret = ras_umc_eeprom_rec2nps_rec(ras_core, record, nps);
+	ret = ras_umc_record_to_nps_record(ras_core, record, nps);
 	if (ret) {
 		RAS_DEV_ERR(ras_core->dev, "Failed to translate nps record! ret:%d\n", ret);
 		return true;
@@ -993,11 +1035,28 @@ int ras_umc_bank_to_umc_record(struct ras_core_context *ras_core,
 int ras_umc_record_to_nps_record(struct ras_core_context *ras_core,
 		struct eeprom_umc_record *record,  uint32_t nps)
 {
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	uint64_t ch_idx_v2;
+	uint32_t save_nps;
+
 	if (!record || !nps ||
 		(nps >= UMC_MEMORY_PARTITION_MODE_UNKNOWN))
 		return -EINVAL;
 
-	return ras_umc_eeprom_rec2nps_rec(ras_core, record, nps);
+	/* Avoid redundant conversion for the same NPS mode */
+	if ((record->cur_nps == nps) && record->cur_nps_retired_row_pfn &&
+	    record->cur_nps_pa_flip_mask)
+		return 0;
+
+	save_nps = EEPROM_RECORD_UMC_NPS_MODE(record);
+	ch_idx_v2 = record->retired_row_pfn & UMC_CHANNEL_IDX_V2;
+	if (!save_nps && !ch_idx_v2)
+		return ras_umc_eeprom_rec2nps_rec(ras_core, record, nps);
+
+	if (!ras_umc->ip_func || !ras_umc->ip_func->eeprom_record_to_nps_record)
+		return -EOPNOTSUPP;
+
+	return ras_umc->ip_func->eeprom_record_to_nps_record(ras_core, record, nps);
 }
 
 int ras_umc_dump_fw_records(struct ras_core_context *ras_core)
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.h b/drivers/gpu/drm/amd/ras/core/ras_umc.h
index a64b5106d0051..b52480ba886b8 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.h
@@ -128,9 +128,6 @@ struct umc_bank_addr {
 struct ras_umc_ip_func {
 	int (*bank_to_eeprom_record)(struct ras_core_context *ras_core,
 			struct ras_bank_ecc *bank, struct eeprom_umc_record *record);
-	int (*eeprom_record_to_nps_pages)(struct ras_core_context *ras_core,
-			struct eeprom_umc_record *record, uint32_t nps,
-			uint64_t *pfns, uint32_t num);
 	int (*eeprom_record_to_nps_record)(struct ras_core_context *ras_core,
 			struct eeprom_umc_record *record, uint32_t nps);
 	int (*bank_to_soc_pa)(struct ras_core_context *ras_core,
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
index 438270adcfcbb..37fa24acddd02 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
@@ -148,21 +148,31 @@ static void __get_nps_pa_flip_bits(struct ras_core_context *ras_core,
 	}
 }
 
-static uint64_t umc_v12_0_nps_pa_to_row_pa(struct ras_core_context *ras_core,
-		uint64_t pa, enum umc_memory_partition_mode nps, bool zero_pfn_ok)
+static uint64_t __get_nps_pa_flip_mask(struct ras_core_context *ras_core,
+		enum umc_memory_partition_mode nps)
 {
 	struct umc_flip_bits flip_bits = {0};
-	uint64_t row_pa;
+	uint64_t flip_mask = 0;
 	int i;
 
 	__get_nps_pa_flip_bits(ras_core, nps, &flip_bits);
 
-	row_pa = pa;
-	/* clear loop bits in soc physical address */
 	for (i = 0; i < flip_bits.bit_num; i++)
-		row_pa &= ~BIT_ULL(flip_bits.flip_bits_in_pa[i]);
+		flip_mask |= BIT_ULL(flip_bits.flip_bits_in_pa[i]);
+
+	return flip_mask;
+}
+
+static uint64_t umc_v12_0_nps_pa_to_row_pa(struct ras_core_context *ras_core,
+		uint64_t pa, enum umc_memory_partition_mode nps, bool zero_pfn_ok)
+{
+	struct umc_flip_bits flip_bits = {0};
+	uint64_t row_pa;
 
-	if (!zero_pfn_ok && !RAS_ADDR_TO_PFN(row_pa))
+	__get_nps_pa_flip_bits(ras_core, nps, &flip_bits);
+	row_pa = pa & ~__get_nps_pa_flip_mask(ras_core, nps);
+
+	if (!zero_pfn_ok && !RAS_ADDR_TO_PFN(row_pa) && flip_bits.bit_num > 2)
 		row_pa |= BIT_ULL(flip_bits.flip_bits_in_pa[2]);
 
 	return row_pa;
@@ -176,13 +186,15 @@ static int lookup_bad_pages_in_a_row(struct ras_core_context *ras_core,
 	uint32_t col, col_lower, row, row_lower, idx, row_high;
 	uint64_t soc_pa, row_pa, column, err_addr;
 	uint64_t retired_addr = RAS_PFN_TO_ADDR(record->cur_nps_retired_row_pfn);
+	uint64_t flip_mask = 0;
 	struct umc_flip_bits flip_bits = {0};
 	uint32_t retire_unit;
 	uint32_t i;
 
 	__get_nps_pa_flip_bits(ras_core, nps, &flip_bits);
 
-	row_pa = umc_v12_0_nps_pa_to_row_pa(ras_core, retired_addr, nps, true);
+	flip_mask = __get_nps_pa_flip_mask(ras_core, nps);
+	row_pa = retired_addr & ~(flip_mask);
 
 	err_addr = record->address;
 	/* get column bit 0 and 1 in mca address */
@@ -348,7 +360,24 @@ static int umc_v12_0_ma2pa(struct ras_core_context *ras_core,
 
 	return 0;
 }
+static int convert_ma_to_pa(struct ras_core_context *ras_core,
+			struct umc_mca_addr *addr_in, struct umc_phy_addr *addr_out,
+			uint32_t nps)
+{
+	int ret;
 
+	if (ras_psp_check_supported_cmd(ras_core, RAS_TA_CMD_ID__QUERY_ADDRESS))
+		ret = ras_umc_ras_ta_translate_addr(ras_core,
+				addr_in, addr_out, nps);
+	else
+		ret = umc_v12_0_ma2pa(ras_core,
+				addr_in, addr_out, nps);
+
+	if (!addr_out->pa_flip_mask)
+		addr_out->pa_flip_mask = __get_nps_pa_flip_mask(ras_core, nps);
+
+	return ret;
+}
 static int convert_bank_to_nps_addr(struct ras_core_context *ras_core,
 			struct ras_bank_ecc *bank, struct umc_phy_addr *pa_addr, uint32_t nps)
 {
@@ -365,10 +394,10 @@ static int convert_bank_to_nps_addr(struct ras_core_context *ras_core,
 	addr_in.node_inst = ACA_IPID_2_DIE_ID(bank->ipid);
 	addr_in.socket_id = ACA_IPID_2_SOCKET_ID(bank->ipid);
 
-	ret = ras_umc_ma2pa(ras_core, &addr_in, &addr_out, nps);
+	ret = convert_ma_to_pa(ras_core, &addr_in, &addr_out, nps);
 	if (!ret) {
-		pa_addr->pa =
-			umc_v12_0_nps_pa_to_row_pa(ras_core, addr_out.pa, nps, false);
+		pa_addr->pa_flip_mask = addr_out.pa_flip_mask;
+		pa_addr->pa = addr_out.pa | pa_addr->pa_flip_mask;
 		pa_addr->channel_idx = addr_out.channel_idx;
 		pa_addr->bank = addr_out.bank;
 	}
@@ -408,12 +437,59 @@ static int umc_v12_0_bank_to_eeprom_record(struct ras_core_context *ras_core,
 	return 0;
 }
 
-static int umc_v12_0_eeprom_record_to_nps_pages(struct ras_core_context *ras_core,
-			struct eeprom_umc_record *record, uint32_t nps,
-			uint64_t *pfns, uint32_t num)
+static int convert_eeprom_record_to_nps_addr(struct ras_core_context *ras_core,
+	struct eeprom_umc_record *record, uint64_t *pa, uint64_t *pa_flip_mask, uint32_t nps)
 {
-	return lookup_bad_pages_in_a_row(ras_core,
-				record, nps, pfns, num, 0, false);
+	struct device_system_info dev_info = {0};
+	struct umc_mca_addr addr_in;
+	struct umc_phy_addr addr_out;
+	int ret;
+
+	memset(&addr_in, 0, sizeof(addr_in));
+	memset(&addr_out, 0, sizeof(addr_out));
+
+	ras_core_get_device_system_info(ras_core, &dev_info);
+
+	addr_in.err_addr = record->address;
+	addr_in.ch_inst = record->mem_channel;
+	addr_in.umc_inst = record->mcumc_id;
+	addr_in.node_inst = UMC_INV_AID_NODE;
+	addr_in.socket_id = dev_info.socket_id;
+
+	ret = convert_ma_to_pa(ras_core, &addr_in, &addr_out, nps);
+	if (ret)
+		return ret;
+
+	*pa_flip_mask = addr_out.pa_flip_mask;
+	*pa = addr_out.pa | addr_out.pa_flip_mask;
+
+	return 0;
+}
+
+static int umc_v12_0_eeprom_record_to_nps_record(struct ras_core_context *ras_core,
+				struct eeprom_umc_record *record, uint32_t nps)
+{
+	uint64_t pa = 0, flip_mask = 0;
+	uint64_t row_pfn;
+	int ret = 0;
+
+	if (nps == EEPROM_RECORD_UMC_NPS_MODE(record)) {
+		record->cur_nps_pa_flip_mask = __get_nps_pa_flip_mask(ras_core, nps);
+		row_pfn = EEPROM_RECORD_UMC_ADDR_PFN(record);
+		record->cur_nps_retired_row_pfn =
+			RAS_ADDR_TO_PFN(RAS_PFN_TO_ADDR(row_pfn) | record->cur_nps_pa_flip_mask);
+	} else {
+		ret = convert_eeprom_record_to_nps_addr(ras_core,
+				record, &pa, &flip_mask, nps);
+		if (!ret) {
+			record->cur_nps_retired_row_pfn = RAS_ADDR_TO_PFN(pa);
+			record->cur_nps_pa_flip_mask = flip_mask;
+		}
+	}
+
+	record->cur_nps = nps;
+
+	return ret;
 }
 
 static int umc_12_0_soc_pa_to_bank(struct ras_core_context *ras_core,
@@ -527,7 +603,7 @@ static uint32_t umc_v12_0_get_die_id(uint64_t mca_addr, uint64_t pa)
 
 const struct ras_umc_ip_func ras_umc_func_v12_0 = {
 	.bank_to_eeprom_record = umc_v12_0_bank_to_eeprom_record,
-	.eeprom_record_to_nps_pages = umc_v12_0_eeprom_record_to_nps_pages,
+	.eeprom_record_to_nps_record = umc_v12_0_eeprom_record_to_nps_record,
 	.bank_to_soc_pa = umc_12_0_bank_to_soc_pa,
 	.soc_pa_to_bank = umc_12_0_soc_pa_to_bank,
 	.mca_ipid_parse = umc_v12_0_mca_ipid_parse,
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c b/drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c
index 39e95a5515f83..8f3bba2621f89 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v15_0.c
@@ -33,27 +33,19 @@ static void __get_nps_pa_flip_bits(struct ras_core_context *ras_core,
 
 }
 
-static uint64_t  convert_nps_pa_to_row_pa(struct ras_core_context *ras_core,
-	struct umc_phy_addr *pa, enum umc_memory_partition_mode nps, bool zero_pfn_ok)
+static uint64_t  __get_nps_pa_flip_mask(struct ras_core_context *ras_core,
+		enum umc_memory_partition_mode nps)
 {
 	struct umc_flip_bits flip_bits = {0};
-	uint64_t row_pa;
+	uint64_t flip_mask = 0;
 	int i;
 
-	if (pa->pa_flip_mask)
-		return zero_pfn_ok ? (pa->pa & ~pa->pa_flip_mask) : pa->pa;
-
 	__get_nps_pa_flip_bits(ras_core, nps, &flip_bits);
 
-	row_pa = pa->pa;
-	/* clear loop bits in soc physical address */
 	for (i = 0; i < flip_bits.bit_num; i++)
-		row_pa &= ~BIT_ULL(flip_bits.flip_bits_in_pa[i]);
-
-	if (!zero_pfn_ok && !RAS_ADDR_TO_PFN(row_pa))
-		row_pa |= BIT_ULL(flip_bits.flip_bits_in_pa[2]);
+		flip_mask |= BIT_ULL(flip_bits.flip_bits_in_pa[i]);
 
-	return row_pa;
+	return flip_mask;
 }
 
 static int lookup_bad_pages_in_a_row(struct ras_core_context *ras_core,
@@ -113,9 +105,8 @@ static int convert_bank_to_nps_addr(struct ras_core_context *ras_core,
 
 	ret = convert_ma_to_pa(ras_core, &addr_in, &addr_out, nps);
 	if (!ret) {
-		pa_addr->pa =
-			convert_nps_pa_to_row_pa(ras_core, &addr_out, nps, false);
 		pa_addr->pa_flip_mask = addr_out.pa_flip_mask;
+		pa_addr->pa = addr_out.pa | pa_addr->pa_flip_mask;
 		pa_addr->channel_idx = addr_out.channel_idx;
 		pa_addr->bank = addr_out.bank;
 	}
@@ -153,7 +144,7 @@ static int umc_v15_0_bank_to_eeprom_record(struct ras_core_context *ras_core,
 }
 
 static int convert_eeprom_record_to_nps_addr(struct ras_core_context *ras_core,
-			struct eeprom_umc_record *record, uint64_t *pa, uint32_t nps)
+	struct eeprom_umc_record *record, uint64_t *pa, uint64_t *pa_flip_mask, uint32_t nps)
 {
 	struct device_system_info dev_info = {0};
 	struct umc_mca_addr addr_in;
@@ -175,7 +166,8 @@ static int convert_eeprom_record_to_nps_addr(struct ras_core_context *ras_core,
 	if (ret)
 		return ret;
 
-	*pa = convert_nps_pa_to_row_pa(ras_core, &addr_out, nps, false);
+	*pa_flip_mask = addr_out.pa_flip_mask;
+	*pa = addr_out.pa | addr_out.pa_flip_mask;
 
 	return 0;
 }
@@ -183,16 +175,22 @@ static int convert_eeprom_record_to_nps_addr(struct ras_core_context *ras_core,
 static int umc_v15_0_eeprom_record_to_nps_record(struct ras_core_context *ras_core,
 				struct eeprom_umc_record *record, uint32_t nps)
 {
-	uint64_t pa = 0;
+	uint64_t pa = 0, flip_mask = 0;
+	uint64_t row_pfn;
 	int ret = 0;
 
 	if (nps == EEPROM_RECORD_UMC_NPS_MODE(record)) {
-		record->cur_nps_retired_row_pfn = EEPROM_RECORD_UMC_ADDR_PFN(record);
+		record->cur_nps_pa_flip_mask = __get_nps_pa_flip_mask(ras_core, nps);
+		row_pfn = EEPROM_RECORD_UMC_ADDR_PFN(record);
+		record->cur_nps_retired_row_pfn =
+			RAS_ADDR_TO_PFN(RAS_PFN_TO_ADDR(row_pfn) | record->cur_nps_pa_flip_mask);
 	} else {
 		ret = convert_eeprom_record_to_nps_addr(ras_core,
-				record, &pa, nps);
-		if (!ret)
+				record, &pa, &flip_mask, nps);
+		if (!ret) {
 			record->cur_nps_retired_row_pfn = RAS_ADDR_TO_PFN(pa);
+			record->cur_nps_pa_flip_mask = flip_mask;
+		}
 	}
 
 	record->cur_nps = nps;
@@ -200,14 +198,6 @@ static int umc_v15_0_eeprom_record_to_nps_record(struct ras_core_context *ras_co
 	return ret;
 }
 
-static int umc_v15_0_eeprom_record_to_nps_pages(struct ras_core_context *ras_core,
-			struct eeprom_umc_record *record, uint32_t nps,
-			uint64_t *pfns, uint32_t num)
-{
-	return lookup_bad_pages_in_a_row(ras_core,
-				record, nps, pfns, num, 0, false);
-}
-
 static int umc_v15_0_soc_pa_to_bank(struct ras_core_context *ras_core,
 			uint64_t soc_pa,
 			struct umc_bank_addr *bank_addr)
@@ -225,7 +215,6 @@ static int umc_v15_0_bank_to_soc_pa(struct ras_core_context *ras_core,
 const struct ras_umc_ip_func ras_umc_func_v15_0 = {
 	.bank_to_eeprom_record = umc_v15_0_bank_to_eeprom_record,
 	.eeprom_record_to_nps_record = umc_v15_0_eeprom_record_to_nps_record,
-	.eeprom_record_to_nps_pages = umc_v15_0_eeprom_record_to_nps_pages,
 	.bank_to_soc_pa = umc_v15_0_bank_to_soc_pa,
 	.soc_pa_to_bank = umc_v15_0_soc_pa_to_bank,
 };
-- 
2.55.0

