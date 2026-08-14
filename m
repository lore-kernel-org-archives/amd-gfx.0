Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B56C5DF6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DD610F72C;
	Fri, 14 Aug 2026 21:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sLGLPq1Z";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B06910F71F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFvcDFiB97au5GehQtUY0//Y9V/w8gbJk1QkUn2cl2wcDrFZ2viRI8+yHTJ0V4M2gxoSBXkfYc+1nn+FloNZhq/t6s8HDir92LKnBkiXmmvu3TUriD3IBRNeUIzdPlWodRbYyiElQlVUEtYxa8S1U3q1OGWlFZxAHPRWNBkpRKS+3qfD4CGlullHy29Q6Ex5YF8H4f+WhkDMj3t+3YRnjsnZ02LePsaFtnV/k7ErAlH9TX6EZhK3ADgHOYZ7CYskNP2fzEAsnmgsbKWAitb9LGnqdROxyqw51Ckr6mPC/tAykk9sS2cek0V4fHAeJXC9cp2Q1JRR+oHklr0m37I5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha+iURjuDmwXr9JMqwJqzdxaEqw0sUZXuTOSn+a5eWA=;
 b=uBZQ7GtaoD7vV3ZCa1hHfFugYKEcUkLjbNaJgBT/o47ecnHGMA8jNC04BeETlXyIEW4yMB0kQcUirLAzzS+kizDf+tzSc4Q81s/0F9MYZus4ZSTc9g1r4cuttVpzffWSlej6CegQzYyfDvFgKIp7EkJjhv3Q90ThNE43EjlxNuBtonyOX7s9RYTAAIwujqnfj9A5ryC6g3m5mQhDHmQbIzKCWiZF3JjxnVM8fqv2nF+cuGW8ssvQrwpglIr3+x6P1J8YBt4lLtXm7ibQnyJUVIXsaYoP6SHhLAgrfVnp3kHJrwx45maOZ9cKTyN6lLJRwKSPocFWAIi+cu0XLSoWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha+iURjuDmwXr9JMqwJqzdxaEqw0sUZXuTOSn+a5eWA=;
 b=sLGLPq1Ziv+86/6N8KOuA7JLYt2TsCbXm1J/xO/rPqazbbsDWAKHV4tiNl03TMQobCt5XsVydnU0B2ryka87pmq9icPMjgMnV6J2A1CzwX3Hz8sPPCQ53vRBX1miKPGqK9/+kmFKbpXovPHPDNfR2MqdEmUJ9aD0mpWxz2UZEDs=
Received: from BN0PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:143::13)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:50 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::4b) by BN0PR10CA0011.outlook.office365.com
 (2603:10b6:408:143::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:45 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 079/109] drm/amd/ras: introduce row page address buffer
 alloc/free interfaces
Date: Fri, 14 Aug 2026 17:02:16 -0400
Message-ID: <20260814210246.3067612-80-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: fd84b8a3-a2ec-4f1e-c7e7-08defa478a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VkjbRbVUJYrlsXsOnx/sezHWOfhnNJB/GKGYxOHxQ4p9s70iQUKQnAsEJ1dDIMsMY3sZpX3mmWoJKMQ9kGR5Pi5vuS/BgYBYes3zs3tlYp7aCcIwA5TjODGMpwReKWvZovMV+E7EOzC0Qs0PiV5fBDJ9LKrK6qkbWEe5Vb3XICjcvDCJY8d08o2e/bwxfBZ27/N/jTDnirR5QkM/Wapm5oAjcZzr8ps7Q5hq8/vyph2TizMkLpxl5j9J7pgb3b1T2w6ePv+41txIYD0Aj6ATdPPwy8iCOev8rkISMnApihX1DYMjid9nuFbiaQ9iLglRBvrl7WJOluCD3/ug0bLwVTDMQLsHOjzz+cMcdW1R8NWprIj0dZeGnCc78I80G0+6xo72TWTQRBlYieN3XawYV18A5EGc40M6BYoa+xLK8TvhlYm/+K0fKMgfojg2z99aHYe6CMrcpMW848m5iEeBZyHxDyuH+W8JjrX8d5wEFsg8xUSkr96oj+aJiftK5k+MSUme1Q2YBBKyWIGBs6VWM1usdpYihpcwWfIBXcaNtVBWWtb/iqtpErl914yRjiJ2KUG2HfWa4CtttXZWJ4y4cxfosXUBFEQSjc7SnA7/ZPHjOKIiNhiss8SCKsRXTpn0U0CubX7j/sFcTeeISpf4cP5y07z0fAOAwwdDTPh7FHNanFp+Q4N7yhY5I1i2yO+ffSDeXNpzZoZ9VffCimXxtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2TAaie+DEi/JogUyNPSJD8XriV/JqanmEcCLUNjbyNv/T77KnkNc+RzOZ/I48UWOD3FieRjwP1jzZdWAbVhV7gW7QuG6WXZ/2Qqjf1mH2hsp8z/5kQbi+A9U5i6WW+1gdfzYq9RIFSxPvTu1CgnCPr2UOe9i8Os64x0Lh51JHCCFl5wQeaQx3Ux+zseTX7yZ1d9McOObIIsAStNBTMJK6Bhonpglr+RCGYCFAaRELQ4G8WzPhn7O/ErAK+dcIeE8taszz8mC7xqxVoxfG+cF4EDoBerE3WQYvLrhLmgvfPh5zl6g+ft/uFS0pj73t4TcYQyoMRzhy3d/5VQcrCmNWeMivBqRFdWWP3lf2gdWa8kRyn52y55zXKFf81nyDtiBXO0zl3mCy6GJfSLfP0OAgBfIM2wQ0mstUywV1fuMHGwUqF/PLdH6vJoOQDpuA28f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:49.9759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd84b8a3-a2ec-4f1e-c7e7-08defa478a1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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

Introduce row page address buffer alloc/free interfaces.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/cmd.h           |   2 +-
 drivers/gpu/drm/amd/ras/core/core.c          |  11 +-
 drivers/gpu/drm/amd/ras/core/ras_umc.c       | 137 ++++++++++++-------
 drivers/gpu/drm/amd/ras/core/ras_umc.h       |  11 +-
 drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c |   3 +
 5 files changed, 99 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/cmd.h b/drivers/gpu/drm/amd/ras/core/cmd.h
index 728fbe55d1765..a37b050e913ab 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.h
+++ b/drivers/gpu/drm/amd/ras/core/cmd.h
@@ -452,7 +452,7 @@ struct ras_cmd_convert_retired_address_req {
 	uint32_t reserved[6];
 };
 
-#define RAS_CMD_MAX_RETIRED_ADDR_COUNT  32
+#define RAS_CMD_MAX_RETIRED_ADDR_COUNT  128
 struct ras_cmd_convert_retired_address_rsp {
 	uint32_t version;
 	uint32_t retired_count;
diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index 00dc6084454cd..71c7c54ddb7c8 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -700,23 +700,14 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_core,
 		uint64_t soc_pa, uint64_t *page_pfn, uint32_t max_pages)
 {
 	struct eeprom_umc_record record;
-	uint32_t cur_nps_mode;
-	int count = 0;
 
 	if (!ras_core || !page_pfn || !max_pages)
 		return -EINVAL;
 
-	cur_nps_mode = ras_core_get_curr_nps_mode(ras_core);
-	if (!cur_nps_mode || cur_nps_mode > UMC_MEMORY_PARTITION_MODE_NPS8)
-		return -EINVAL;
-
 	memset(&record, 0, sizeof(record));
 	record.cur_nps_retired_row_pfn = RAS_ADDR_TO_PFN(soc_pa);
 
-	count = ras_umc_convert_record_to_nps_pages(ras_core,
-				&record, cur_nps_mode, page_pfn, max_pages);
-
-	return count;
+	return ras_umc_convert_record_to_row_pages(ras_core, &record, page_pfn, max_pages);
 }
 
 int ras_core_check_address_sanity(struct ras_core_context *ras_core,
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index c30d11942a72b..299426d6d8318 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -70,11 +70,15 @@ static uint64_t ras_umc_get_eeprom_timestamp(struct ras_core_context *ras_core)
 static const struct ras_umc_ip_func *ras_umc_get_ip_func(
 				struct ras_core_context *ras_core, uint32_t ip_version)
 {
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+
 	switch (ip_version) {
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 5, 0):
+		ras_umc->max_pages_per_row = 16;
 		return &ras_umc_func_v12_0;
 	case IP_VERSION(15, 0, 0):
+		ras_umc->max_pages_per_row = 128;
 		return &ras_umc_func_v15_0;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
@@ -177,6 +181,44 @@ int ras_umc_clear_logged_ecc(struct ras_core_context *ras_core)
 	return 0;
 }
 
+int ras_umc_alloc_row_pages(struct ras_core_context *ras_core,
+		uint64_t **page_pfns, uint32_t *nr_page_pfns)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	uint64_t *address;
+	uint64_t page_num;
+
+	if (!page_pfns || !nr_page_pfns)
+		return -EINVAL;
+
+	if (!ras_umc->max_pages_per_row) {
+		RAS_DEV_ERR(ras_core->dev, "max_pages_per_row was not initialized!\n");
+		return -EPERM;
+	}
+
+	page_num = ras_umc->max_pages_per_row;
+
+	address = kcalloc(page_num, sizeof(*address), GFP_KERNEL);
+	if (!address)
+		return -ENOMEM;
+
+	*page_pfns = address;
+	*nr_page_pfns = page_num;
+
+	return 0;
+}
+
+int ras_umc_free_row_pages(struct ras_core_context *ras_core,
+		uint64_t *page_pfns)
+{
+	if (!page_pfns)
+		return -EINVAL;
+
+	kfree(page_pfns);
+
+	return 0;
+}
+
 static int ras_umc_expand_row_pages(struct ras_core_context *ras_core,
 	struct eeprom_umc_record *record, uint64_t *page_pfns, uint32_t nr_page_pfns)
 {
@@ -209,9 +251,8 @@ static int ras_umc_expand_row_pages(struct ras_core_context *ras_core,
 	return count;
 }
 
-int ras_umc_convert_record_to_nps_pages(struct ras_core_context *ras_core,
-		struct eeprom_umc_record *record, uint32_t nps,
-		uint64_t *page_pfns, uint32_t nr_page_pfns)
+int ras_umc_convert_record_to_row_pages(struct ras_core_context *ras_core,
+	struct eeprom_umc_record *record, uint64_t *page_pfns, uint32_t nr_page_pfns)
 {
 	uint32_t new_nps;
 	int ret, count = 0;
@@ -236,26 +277,21 @@ int ras_umc_convert_record_to_nps_pages(struct ras_core_context *ras_core,
 	return count;
 }
 
-static void ras_umc_reserve_eeprom_record(struct ras_core_context *ras_core,
-				struct eeprom_umc_record *record)
+static void ras_umc_reserve_row_pages(struct ras_core_context *ras_core,
+	struct eeprom_umc_record *record, uint64_t *pages, uint32_t nr_pages)
 {
-	uint64_t page_pfn[16];
-	int count = 0, i;
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	int i;
 
-	memset(page_pfn, 0, sizeof(page_pfn));
-	count = ras_umc_convert_record_to_nps_pages(ras_core,
-					record, record->cur_nps, page_pfn, ARRAY_SIZE(page_pfn));
-	if (count <= 0) {
-		RAS_DEV_ERR(ras_core->dev,
-			"Fail to convert error address! count:%d\n", count);
+	if (!pages || !nr_pages ||
+		(nr_pages > ras_umc->max_pages_per_row))
 		return;
-	}
 
 	/* Reserve memory */
-	for (i = 0; i < count; i++)
+	for (i = 0; i < nr_pages; i++)
 		ras_core_event_notify(ras_core, ras_core_in_early_init(ras_core) ?
 			RAS_EVENT_ID__EARLY_INIT_RESERVE_PAGE : RAS_EVENT_ID__RESERVE_BAD_PAGE,
-			&page_pfn[i]);
+			&pages[i]);
 }
 
 /* When gpu reset is ongoing, ecc logging operations will be pended.
@@ -614,44 +650,25 @@ static int ras_umc_update_eeprom_rom_data(struct ras_core_context *ras_core,
 }
 
 static int ras_umc_update_eeprom_ram_data(struct ras_core_context *ras_core,
-				struct eeprom_umc_record *bps)
+		struct eeprom_umc_record *bps, uint64_t *page_pfns, uint32_t nr_page_pfns)
 {
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
 	struct eeprom_store_record *data = &ras_umc->umc_err_data.ram_data;
-	uint64_t page_pfn[16];
-	int count = 0, i, j;
+	int j;
+
+	if (!bps || !page_pfns || !nr_page_pfns ||
+		(nr_page_pfns > ras_umc->max_pages_per_row))
+		return -EINVAL;
 
 	if (!data->space_left &&
-		ras_umc_realloc_err_data_space(ras_core, data, 256)) {
-		return	-ENOMEM;
-	}
+		ras_umc_realloc_err_data_space(ras_core, data, 256))
+		return -ENOMEM;
 
-	memset(page_pfn, 0, sizeof(page_pfn));
-	count = ras_umc_convert_record_to_nps_pages(ras_core,
-					bps, bps->cur_nps, page_pfn, ARRAY_SIZE(page_pfn));
-	if (count > 0) {
-		for (j = 0; j < count; j++) {
-			if (ras_core_check_address_sanity(ras_core,
-				page_pfn[j] << AMDGPU_GPU_PAGE_SHIFT)) {
-
-				for (i = 0; i < data->count; i++)
-					if (page_pfn[j] == data->bps[i].cur_nps_retired_row_pfn)
-						break;
-				data->bps[data->count].cur_nps_retired_row_pfn = U64_MAX;
-				data->count++;
-				data->space_left--;
-				continue;
-			}
-
-			bps->cur_nps_retired_row_pfn = page_pfn[j];
-			memcpy(&data->bps[data->count], bps, sizeof(*data->bps));
-			data->count++;
-			data->space_left--;
-			data->bad_page_num++;
-		}
-	} else {
-		RAS_DEV_ERR(ras_core->dev, "Failed to convert record to nps pages!");
-		return -EINVAL;
+	for (j = 0; j < nr_page_pfns; j++) {
+		bps->cur_nps_retired_row_pfn = page_pfns[j];
+		memcpy(&data->bps[data->count], bps, sizeof(*data->bps));
+		data->count++;
+		data->space_left--;
 	}
 
 	/* update bad channel bitmap */
@@ -694,17 +711,33 @@ int ras_umc_add_bad_pages(struct ras_core_context *ras_core,
 	struct eeprom_umc_record *bps, uint32_t bps_sz, uint32_t *valid_sz)
 {
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	uint64_t *page_pfns = NULL;
+	uint32_t nr_page_pfns = 0;
+	int nr_valid_pfns = 0;
 	uint32_t i, c = 0;
 	int ret = 0;
 
 	if (!bps || !bps_sz || !valid_sz)
 		return -EINVAL;
 
+	ret = ras_umc_alloc_row_pages(ras_core, &page_pfns, &nr_page_pfns);
+	if (ret)
+		return ret;
+
 	mutex_lock(&ras_umc->umc_lock);
 	for (i = 0; i < bps_sz; i++) {
 		if (ras_umc_check_retired_record(ras_core, &bps[i]))
 			continue;
 
+		nr_valid_pfns = ras_umc_convert_record_to_row_pages(ras_core,
+					&bps[i], page_pfns, nr_page_pfns);
+		if (nr_valid_pfns < 0) {
+			RAS_DEV_ERR(ras_core->dev,
+				"Failed to lookup record bad pages! %d\n", nr_valid_pfns);
+			ret = nr_valid_pfns;
+			goto out;
+		}
+
 		ret = ras_umc_update_eeprom_rom_data(ras_core, &bps[i]);
 		if (ret)
 			goto out;
@@ -713,9 +746,11 @@ int ras_umc_add_bad_pages(struct ras_core_context *ras_core,
 		if (ret)
 			goto out;
 
-		ras_umc_reserve_eeprom_record(ras_core, &bps[i]);
+		ras_umc_reserve_row_pages(ras_core,
+			&bps[i], page_pfns, nr_valid_pfns);
 
-		ret = ras_umc_update_eeprom_ram_data(ras_core, &bps[i]);
+		ret = ras_umc_update_eeprom_ram_data(ras_core,
+				&bps[i], page_pfns, nr_valid_pfns);
 		if (ret)
 			goto out;
 		c++;
@@ -731,7 +766,7 @@ int ras_umc_add_bad_pages(struct ras_core_context *ras_core,
 
 out:
 	mutex_unlock(&ras_umc->umc_lock);
-
+	ras_umc_free_row_pages(ras_core, page_pfns);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.h b/drivers/gpu/drm/amd/ras/core/ras_umc.h
index b52480ba886b8..362c9ce6a404b 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.h
@@ -183,6 +183,8 @@ struct ras_umc {
 
 	u32 last_record_count;
 	u64 last_channel_bitmap;
+
+	u32 max_pages_per_row;
 };
 
 /*
@@ -222,9 +224,8 @@ int ras_umc_get_badpage_record(struct ras_core_context *ras_core, uint32_t index
 bool ras_umc_check_retired_addr(struct ras_core_context *ras_core, uint64_t addr);
 int ras_umc_translate_soc_pa_and_bank(struct ras_core_context *ras_core,
 			uint64_t *soc_pa, struct umc_bank_addr *bank_addr, bool bank_to_pa);
-int ras_umc_convert_record_to_nps_pages(struct ras_core_context *ras_core,
-		struct eeprom_umc_record *record, uint32_t nps,
-		uint64_t *page_pfn, uint32_t max_pages);
+int ras_umc_convert_record_to_row_pages(struct ras_core_context *ras_core,
+	struct eeprom_umc_record *record, uint64_t *page_addrs, uint32_t nr_page_addrs);
 uint32_t ras_umc_bit_wise_xor(uint32_t val);
 int ras_umc_ma2pa(struct ras_core_context *ras_core,
 	struct umc_mca_addr *addr_in, struct umc_phy_addr *addr_out,
@@ -235,4 +236,8 @@ int ras_umc_record_to_nps_record(struct ras_core_context *ras_core,
 		struct eeprom_umc_record *record,  uint32_t nps);
 int ras_umc_dump_fw_records(struct ras_core_context *ras_core);
 void ras_umc_report_badpage_info(struct ras_core_context *ras_core);
+int ras_umc_alloc_row_pages(struct ras_core_context *ras_core,
+		uint64_t **page_pfns, uint32_t *nr_page_pfns);
+int ras_umc_free_row_pages(struct ras_core_context *ras_core,
+		uint64_t *page_pfns);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
index 37fa24acddd02..c637ad9314103 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
@@ -473,6 +473,9 @@ static int umc_v12_0_eeprom_record_to_nps_record(struct ras_core_context *ras_co
 	uint64_t row_pfn;
 	int ret = 0;
 
+	if (!record || !nps)
+		return -EINVAL;
+
 	if (nps == EEPROM_RECORD_UMC_NPS_MODE(record)) {
 		record->cur_nps_pa_flip_mask = __get_nps_pa_flip_mask(ras_core, nps);
 		row_pfn = EEPROM_RECORD_UMC_ADDR_PFN(record);
-- 
2.55.0

