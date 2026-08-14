Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EC7C5DF7A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D6B110F714;
	Fri, 14 Aug 2026 21:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5PnwWtzr";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010041.outbound.protection.outlook.com
 [52.101.193.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D42D010F701
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gf+WmNOlRxf0Q8EkZWOZFVV+XI/hVos8h7zQaRqQIRsrS+GeRk+mphIrwEsICdwHGtpgQsAgEeXpqB6MnyOdM2MCexZZBWz2/I5AMclYLXFytLeVrgWOgYDGUgYewP1idL8xVawqn2PJ3mW90fyPaJw7sX73zK+fvqHVc++BLQwS9C/PSQa4B0zXGwtJSKXiiZfJdklQ7my5sv1wy6cESNU3L/c4fXpxJlaxVtcLaDq08INHEYRMCyWPh2sUjmnYbjZPXb565QxwYyAAPzchC0nQ3Hslo34yqL/0t396x6KAhV11fV86uLQn1ncsiYry9fU+0+j0+Y4l3xw7B+gzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0QWMYc1w9W7U9gpfPRJPDpKfBbu/VhrBsI8LZbh2bc=;
 b=ftXiMCy2Zs0u2YsDpLl1+sDKTD9uYrDwiiojk0mm1F9ajLN2TDnxPF/iExAEqFCImRf7G1qf2/2+xWxFC7UqUK5mcEkR+OF9BDgzb0acbBkBdBieAgfaxMMGqvD+Qv+dc9F2usH10JJOI+yDqD7A5kRlGMYDCvTHiLqmRguM9T6P7gyBOlTSZCacNiDU3EmFMzjA6IUOxaSxD0nTZVb4LbMoqlN101MsvTGWnLK8907KQs3FcGpaUz+dhRwa60TuhVn4YEmmTFOmbELkbgs765x7fzyF4DiXOEN1tB7x1UMqaCg9h7J/b+zPfO/ZT5NMpf96NnUtqjPttoVI0e+LTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0QWMYc1w9W7U9gpfPRJPDpKfBbu/VhrBsI8LZbh2bc=;
 b=5PnwWtzrnrXKGLvGsys3JSR/pviQQll0DhgtTphlWLaq0VMDUNkqDnWYiFTNlzoXKE2ExPlRPaJuSUpaxJ3mDbTET3TTA+mOMALP2AZ8COqwACVAk9vrdHzkRdBSn97CsQSGLVQiMvUm8OOfjQcGS8M3J9PPyt09Kr5aBAmEtLQ=
Received: from CH2PR10CA0018.namprd10.prod.outlook.com (2603:10b6:610:4c::28)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:32 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::32) by CH2PR10CA0018.outlook.office365.com
 (2603:10b6:610:4c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 046/109] drm/amd/ras: unify umc record logging paths for
 runtime and preload
Date: Fri, 14 Aug 2026 17:01:43 -0400
Message-ID: <20260814210246.3067612-47-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5a4f63-075e-46d7-4225-08defa477f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LVdxgxQs+gNvTjHkfdNhYeDTOCAsw9Pe3zhKABpxLFMUk9799VN2wkuFquqH6rHzfXETsvB3Lw4XNU3oJwLt764N6RSYosM5pAOIwwxGTjFpYlBIKTdp8TQwQW8vpEFKmt2qdmNVR7pz9rA4HtSGT4XYXnLaM8il/BgVTCO93aQaV6x3fUgziFXKaVdneFs+zTW76uqEGXC+DC2w/6W+YygHw2NLlgPzUqj9aR3DAWiFzWHVHno149ZjNKk59YovI/K+aDIkC0DKO+RY0VJbWlB/tb88FXje1LUqg+oSaFsw5ndbOVrkTuV2YQBXjb4E6uAy+Ei2mR9bSUZaMQMrth9OhiKv8ATVmgKtwYesy57be9/qc1K98Xe+l9pE4lX+2vEfGL3Anw+ShBXD+dX30vywNL0Y6TroWtJK0qoY9HvXrcfD77twmRIRVD7drwQSfevMHQJMI3ISo6oKo54pJIVhwr9hZlcKuLleLB2gGcw8ZiD4sSU8RN6BaA2whBh85jv7yqda+MgVUKK8lVCwrnZWZcfr7sZqrjSVFRttBIz91l8AwajqmIBS4ibSN9fVffcZyufnK+evkXSUo2eChD1ccogs1l2iVTUFF0VT2g0vvNuw//qGCGJxlDaercMwILJpVC/QwqkkabneyExElElNPTCRlLvCLDOMXzDROcI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RDjZmeOSEMos8e+snwSGkPvlmc3rrgiP5e0OWwoPj9wmZ3wjDt4kINIchdn9eQ7ew/sCQLLZCltAJKkjHy47dDdDwjAf8X0rVca8xA3wFvbDx0YNSfcIxi5MhbiGXhYZWP55HP5gXzyYxQDTdS6/f//GRx0rlBt5EUpe5GnETxK0E/+rVnZ69phFHT3ALdtIL0T/AqYsD8DEA94ilgokqyt/ESoNH3MLlQbGSj6namSZqUhBFPAxAyivPbTG8lGbM4zJbYK+yWFg0nzDAWAs9CdOwiykpk5dPPpwZooDyNEpuT/y6Qn6Yb4/OiUbUrnu/suV1ssnEtmOD1/gxJDCE0ZVE9Odd9/hEI9FuiA1Owpb9NyEBgaHwKdphEdGilLg0rONaDZMmmvPAvCSy2akYGj6W1fZfuDf7aL/FREVinmNJXbjOPVbZTNlXOoL93xf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:31.9451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5a4f63-075e-46d7-4225-08defa477f5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200
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

Unify UMC record logging paths for runtime and preload.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_umc.c | 190 ++++++++++---------------
 drivers/gpu/drm/amd/ras/core/ras_umc.h |   5 +-
 2 files changed, 76 insertions(+), 119 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index 2ff6c9a7e5c17..9cf1515dfd02e 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -130,8 +130,6 @@ static int ras_umc_log_ecc(struct ras_core_context *ras_core,
 
 	mutex_lock(&ras_umc->tree_lock);
 	ret = radix_tree_insert(&ras_umc->root, idx, data);
-	if (!ret)
-		radix_tree_tag_set(&ras_umc->root, idx, UMC_ECC_NEW_DETECTED_TAG);
 	mutex_unlock(&ras_umc->tree_lock);
 
 	return ret;
@@ -269,39 +267,24 @@ int ras_umc_log_pending_bad_bank(struct ras_core_context *ras_core)
 int ras_umc_log_bad_bank(struct ras_core_context *ras_core, struct ras_bank_ecc *bank)
 {
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
-	struct eeprom_umc_record umc_rec;
-	struct eeprom_umc_record *err_rec;
+	struct eeprom_umc_record umc_rec = {0};
+	uint32_t c = 0;
 	int ret;
 
-	memset(&umc_rec, 0, sizeof(umc_rec));
-
 	mutex_lock(&ras_umc->bank_log_lock);
-	ret = ras_umc->ip_func->bank_to_eeprom_record(ras_core, bank, &umc_rec);
+	ret = ras_umc_bank_to_umc_record(ras_core, bank, &umc_rec);
 	if (ret)
 		goto out;
 
-	err_rec = kzalloc_obj(*err_rec);
-	if (!err_rec) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	memcpy(err_rec, &umc_rec, sizeof(umc_rec));
-	ret = ras_umc_log_ecc(ras_core, err_rec->cur_nps_retired_row_pfn, err_rec);
+	ret = ras_umc_add_bad_pages(ras_core, &umc_rec, 1, &c);
 	if (ret) {
-		if (ret == -EEXIST) {
-			RAS_DEV_INFO(ras_core->dev, "The bad pages have been logged before.\n");
-			ret = 0;
-		}
-
-		kfree(err_rec);
+		RAS_DEV_ERR(ras_core->dev, "Failed to log bad bank! ret:%x\n", ret);
 		goto out;
 	}
 
-	ras_umc_reserve_eeprom_record(ras_core, err_rec);
-
-	ret = ras_core_event_notify(ras_core,
-			RAS_EVENT_ID__BAD_PAGE_DETECTED, NULL);
+	if (c)
+		ret = ras_core_event_notify(ras_core,
+				RAS_EVENT_ID__BAD_PAGE_DETECTED, NULL);
 
 out:
 	mutex_unlock(&ras_umc->bank_log_lock);
@@ -468,59 +451,52 @@ static int ras_umc_eeprom_rec2nps_rec(struct ras_core_context *ras_core,
 	return ret;
 }
 
-static int ras_umc_get_new_records(struct ras_core_context *ras_core,
-			struct eeprom_umc_record *records, u32 num)
+static bool ras_umc_check_logged_record(struct ras_core_context *ras_core,
+			struct eeprom_umc_record *record)
 {
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
-	struct eeprom_umc_record *entries[MAX_ECC_NUM_PER_RETIREMENT];
-	u32 entry_num = num < MAX_ECC_NUM_PER_RETIREMENT ? num : MAX_ECC_NUM_PER_RETIREMENT;
-	int count = 0;
-	int new_detected, i;
+	void *res = NULL;
 
 	mutex_lock(&ras_umc->tree_lock);
-	new_detected = radix_tree_gang_lookup_tag(&ras_umc->root, (void **)entries,
-			0, entry_num, UMC_ECC_NEW_DETECTED_TAG);
-	for (i = 0; i < new_detected; i++) {
-		if (!entries[i])
-			continue;
-
-		memcpy(&records[i], entries[i], sizeof(struct eeprom_umc_record));
-		count++;
-		radix_tree_tag_clear(&ras_umc->root,
-				entries[i]->cur_nps_retired_row_pfn, UMC_ECC_NEW_DETECTED_TAG);
-	}
+	res = radix_tree_lookup(&ras_umc->root, record->cur_nps_retired_row_pfn);
 	mutex_unlock(&ras_umc->tree_lock);
 
-	return count;
+	return res ? true : false;
 }
 
 static bool ras_umc_check_retired_record(struct ras_core_context *ras_core,
-				struct eeprom_umc_record *record, bool from_eeprom)
+				struct eeprom_umc_record *record)
 {
-	struct ras_umc *ras_umc = &ras_core->ras_umc;
-	struct eeprom_store_record *data = &ras_umc->umc_err_data.rom_data;
 	uint32_t nps = 0;
-	int i, ret;
-
-	if (from_eeprom) {
-		nps = ras_core_get_curr_nps_mode(ras_core);
-		ret = ras_umc_eeprom_rec2nps_rec(ras_core, record, nps);
-		if (ret)
-			RAS_DEV_WARN_RATELIMITED(ras_core->dev,
-				"Failed to adjust eeprom record, ret:%d", ret);
+	int ret;
 
-		return false;
+	nps = ras_core_get_curr_nps_mode(ras_core);
+	ret = ras_umc_eeprom_rec2nps_rec(ras_core, record, nps);
+	if (ret) {
+		RAS_DEV_ERR(ras_core->dev, "Failed to translate nps record! ret:%d\n", ret);
+		return true;
 	}
 
-	for (i = 0; i < data->count; i++) {
-		if ((data->bps[i].retired_row_pfn == record->retired_row_pfn) &&
-		    (data->bps[i].cur_nps_retired_row_pfn == record->cur_nps_retired_row_pfn))
-			return true;
-	}
+	if (ras_umc_check_logged_record(ras_core, record))
+		return true;
 
 	return false;
 }
 
+static int ras_umc_log_record(struct ras_core_context *ras_core,
+				struct eeprom_umc_record *record)
+{
+	struct eeprom_umc_record *rec;
+
+	rec = kzalloc(sizeof(*rec), GFP_KERNEL);
+	if (!rec)
+		return -ENOMEM;
+
+	memcpy(rec, record, sizeof(*rec));
+
+	return ras_umc_log_ecc(ras_core, rec->cur_nps_retired_row_pfn, rec);
+}
+
 /* alloc/realloc bps array */
 static int ras_umc_realloc_err_data_space(struct ras_core_context *ras_core,
 		struct eeprom_store_record *data, int pages)
@@ -612,41 +588,41 @@ static void ras_umc_update_bad_pages(struct ras_core_context *ras_core)
 	data->bad_page_num_old = data->bad_page_num;
 }
 
-/* it deal with vram only. */
-static int ras_umc_add_bad_pages(struct ras_core_context *ras_core,
-				 struct eeprom_umc_record *bps,
-				 int pages, bool from_eeprom)
+int ras_umc_add_bad_pages(struct ras_core_context *ras_core,
+	struct eeprom_umc_record *bps, uint32_t bps_sz, uint32_t *valid_sz)
 {
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
-	struct ras_umc_err_data *data = &ras_umc->umc_err_data;
-	int i, ret = 0;
+	uint32_t i, c = 0;
+	int ret = 0;
 
-	if (!bps || pages <= 0)
-		return 0;
+	if (!bps || !bps_sz || !valid_sz)
+		return -EINVAL;
 
 	mutex_lock(&ras_umc->umc_lock);
-	for (i = 0; i < pages; i++) {
-		if (ras_umc_check_retired_record(ras_core, &bps[i], from_eeprom))
+	for (i = 0; i < bps_sz; i++) {
+		if (ras_umc_check_retired_record(ras_core, &bps[i]))
 			continue;
 
 		ret = ras_umc_update_eeprom_rom_data(ras_core, &bps[i]);
 		if (ret)
 			goto out;
 
-		if (data->last_retired_pfn == bps[i].cur_nps_retired_row_pfn)
-			continue;
-
-		data->last_retired_pfn = bps[i].cur_nps_retired_row_pfn;
+		ret = ras_umc_log_record(ras_core, &bps[i]);
+		if (ret)
+			goto out;
 
-		if (from_eeprom)
-			ras_umc_reserve_eeprom_record(ras_core, &bps[i]);
+		ras_umc_reserve_eeprom_record(ras_core, &bps[i]);
 
 		ret = ras_umc_update_eeprom_ram_data(ras_core, &bps[i]);
 		if (ret)
 			goto out;
+		c++;
 	}
 
-	ras_eeprom_mgr_check_and_report_status(ras_core, true);
+	*valid_sz = c;
+
+	if (c)
+		ras_eeprom_mgr_check_and_report_status(ras_core, true);
 
 out:
 	mutex_unlock(&ras_umc->umc_lock);
@@ -661,7 +637,7 @@ static int ras_umc_add_bad_pages(struct ras_core_context *ras_core,
 int ras_umc_load_bad_pages(struct ras_core_context *ras_core)
 {
 	struct eeprom_umc_record *bps;
-	uint32_t ras_num_recs;
+	uint32_t ras_num_recs, c = 0;
 	int ret;
 
 	ras_num_recs = ras_eeprom_mgr_get_record_count(ras_core);
@@ -673,12 +649,11 @@ int ras_umc_load_bad_pages(struct ras_core_context *ras_core)
 		return -ENOMEM;
 
 	ret = ras_eeprom_mgr_get_records(ras_core, 0, bps, ras_num_recs);
-	if (ret) {
+	if (ret)
 		RAS_DEV_ERR(ras_core->dev,
 			"Failed to load EEPROM table records! ret:%d\n", ret);
-	} else {
-		ras_core->ras_umc.umc_err_data.last_retired_pfn = UMC_INV_MEM_PFN;
-		ret = ras_umc_add_bad_pages(ras_core, bps, ras_num_recs, true);
+	else {
+		ret = ras_umc_add_bad_pages(ras_core, bps, ras_num_recs, &c);
 		ras_umc_update_bad_pages(ras_core);
 	}
 
@@ -698,10 +673,10 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 	struct eeprom_store_record *ram_data = &ras_umc->umc_err_data.ram_data;
 	uint32_t eeprom_record_num, logical_count = 0;
 	int save_count;
-	int ret = 0;
+	int ret = -ENODATA;
 
 	if (!data->bps)
-		return 0;
+		return -EINVAL;
 
 	eeprom_record_num = ras_eeprom_mgr_get_record_count(ras_core);
 	mutex_lock(&ras_umc->umc_lock);
@@ -717,8 +692,9 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 			ret = -EIO;
 			goto exit;
 		}
+
 		ras_umc_update_bad_pages(ras_core);
-		RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table.\n", logical_count);
+		RAS_DEV_INFO(ras_core->dev, "Saved %d records to EEPROM table.\n", logical_count);
 	}
 
 exit:
@@ -728,39 +704,7 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 
 int ras_umc_handle_bad_pages(struct ras_core_context *ras_core, void *data)
 {
-	struct eeprom_umc_record *records;
-	int count, ret;
-
-	records = kzalloc_objs(*records, MAX_ECC_NUM_PER_RETIREMENT);
-	if (!records)
-		return -ENOMEM;
-
-	count = ras_umc_get_new_records(ras_core, records,
-					MAX_ECC_NUM_PER_RETIREMENT);
-	if (count <= 0) {
-		ret = -ENODATA;
-		goto out;
-	}
-
-	ret = ras_umc_add_bad_pages(ras_core, records, count, false);
-	if (ret) {
-		RAS_DEV_ERR(ras_core->dev, "Failed to add ras bad page!\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = ras_umc_save_bad_pages(ras_core);
-	if (ret) {
-		RAS_DEV_ERR(ras_core->dev, "Failed to save ras bad page\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = 0;
-
-out:
-	kfree(records);
-	return ret;
+	return ras_umc_save_bad_pages(ras_core);
 }
 
 int ras_umc_sw_init(struct ras_core_context *ras_core)
@@ -964,3 +908,13 @@ int ras_umc_bank_to_umc_record(struct ras_core_context *ras_core,
 
 	return 0;
 }
+
+int ras_umc_record_to_nps_record(struct ras_core_context *ras_core,
+		struct eeprom_umc_record *record,  uint32_t nps)
+{
+	if (!record || !nps ||
+		(nps >= UMC_MEMORY_PARTITION_MODE_UNKNOWN))
+		return -EINVAL;
+
+	return ras_umc_eeprom_rec2nps_rec(ras_core, record, nps);
+}
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.h b/drivers/gpu/drm/amd/ras/core/ras_umc.h
index ed77fb3912d59..221cd008e55a0 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.h
@@ -160,7 +160,6 @@ struct eeprom_store_record {
 struct ras_umc_err_data {
 	struct eeprom_store_record rom_data;
 	struct eeprom_store_record ram_data;
-	uint64_t last_retired_pfn;
 };
 
 struct ras_umc {
@@ -201,6 +200,8 @@ int ras_umc_log_bad_bank_pending(struct ras_core_context *ras_core, struct ras_b
 int ras_umc_log_pending_bad_bank(struct ras_core_context *ras_core);
 int ras_umc_clear_logged_ecc(struct ras_core_context *ras_core);
 int ras_umc_load_bad_pages(struct ras_core_context *ras_core);
+int ras_umc_add_bad_pages(struct ras_core_context *ras_core,
+	struct eeprom_umc_record *bps, uint32_t bps_sz, uint32_t *valid_sz);
 int ras_umc_get_saved_eeprom_count(struct ras_core_context *ras_core);
 int ras_umc_clean_badpage_data(struct ras_core_context *ras_core);
 int ras_umc_fill_eeprom_record(struct ras_core_context *ras_core,
@@ -221,4 +222,6 @@ int ras_umc_ma2pa(struct ras_core_context *ras_core,
 	uint32_t nps);
 int ras_umc_bank_to_umc_record(struct ras_core_context *ras_core,
 		struct ras_bank_ecc *bank, struct eeprom_umc_record *record);
+int ras_umc_record_to_nps_record(struct ras_core_context *ras_core,
+		struct eeprom_umc_record *record,  uint32_t nps);
 #endif
-- 
2.55.0

