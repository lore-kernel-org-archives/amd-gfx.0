Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA403CDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7759D10E485;
	Mon, 22 Jun 2026 04:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MtROzBgM";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011056.outbound.protection.outlook.com
 [40.93.194.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733EB10E485
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sn/69RWyUbgipff5tUVgDukIEQP/ZnfuDaRiswQHqlAmXjg9Z8sqPKEhU55Chwb8ozw8cO3UK7DQl2FZpsHgwyFLcOKoCyv/6jU+ZiTxTpjlgDqU8hcRkw8yw9nrEfE/eG6sRCpq2NJ7V0fJpAzvkS9uon9COBXQyhbrrC4fkIS3LFy26+/f78d8FuoJl+vWUyyNz0DT0oWJM54eJU29gF9dZ7sC8KIvgoSjcLsaMSXM4DZ6eLAjFTIbJ81wfLLNF+2f7qM7JB/nQF2zvXO+yBJADysMD/0B426ykMV2GWbkHl7oqw8n15kPQrS9dScy/lig36+CLOcEvv/R7ESyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SuQwwe175OBIrVNQWK96vHd8cbyoyySSvhr6AVrdCc=;
 b=WgIsrOH7Dgh+W8l8JKOiQR7J9NhWceddTBYD1cLd60S9IoVjHHV1JrzQ1Rw02Wn+NakdHwl3WOED2vpOkEVDewdIaIWDMOl1y07xUvTedSZIGF6TF+GAPfeXKH1/+zekHnYt3EJUS+tVohAKrmRYOxlqYhzizRM1ybQ+Yg3aB28LNT5tF97gWC3zbQ78wS8NZomxAHTmyNcpHYvonEJsw3YFp1c/dfzPQTDxOF4O6rgHVEbL+whKFGM8RTNsxKcMuF03+puJFuVrpZRI/HPPofvV4opX6F4L0RbA1hEu5G3h5NuxN/+tkipX56hQsTarPf2/eekK0WH+Lp429KExKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SuQwwe175OBIrVNQWK96vHd8cbyoyySSvhr6AVrdCc=;
 b=MtROzBgMT+nJy1r5zitejc3v21gBs9lefdfzMwaDfLw9v75xrLV3FH/ZjdOKYjG/7HxWHC/VYc48iwtDUNTLchyiVPQhDiR/bCX1EYKqvM4CVFsycQnysIVHz2U5fVJJCxSoIaMC3xcmGMPr4WHQyE9QYCk/c9t8ZFqWggT3VVQ=
Received: from BL1PR13CA0393.namprd13.prod.outlook.com (2603:10b6:208:2c2::8)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 04:43:13 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::5c) by BL1PR13CA0393.outlook.office365.com
 (2603:10b6:208:2c2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Mon,
 22 Jun 2026 04:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:43:13 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:43:10 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 38/48] drm/amdgpu: retire legacy pmfw eeprom reset
Date: Mon, 22 Jun 2026 12:40:27 +0800
Message-ID: <83d511386eac087d800d5e9ea0b0d16642c53cfc.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 7572d2fc-3ed6-4eb7-8a2a-08ded018c4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: uuynscGB2SLEMHWQhXdbXQHyeH4MS8iMg4ueJZ7h3X37I4cPdKSnGfpyZUHGcI3JmWN2TKcMSN1HF46wFnJodGRn+EvWKxHdDEF5DZMIAOo+bspS7NUIJdVmmlkhV6r91NFYuuJpbmoj8AIuGAyuOGAGTcW+zE9ArMXwb5qlzaUUP+owwwjIDUKyx5SxFScJ4pZF71zk5AowRzqIFLEZPHrAOjxv9tjQGbEcFh3x+0u6nBBymMTkJ1uBnQPj7XzqLGVLkUVSVeEXZOEAupQoPUA4T3bI+BYHYqApU73wOiVc/CC2vOTWbhLrNb15k4sk43ujZtRsfBKUHMvx1jY7cajI5xa7mChSt9LdeD2C/qn/xnPYVr9NJuq1yPmPmZpQcVqB16UkdXHPnldc0MNu4f5/YCYBPHJOl9ryqjxiA6sVnCv9jG+GFi2G3RdmV4TtrHJuhCKehs/TYDTnCkNDKcxPDIRnwUBbn/I9SBDeDAbz+OmynGEvsCxtrrn09qhqogoIm8dqu0pVe8WIt1jImf5dgtUsZZPT+DXliLwY/u/7W8wEaf3ApWA5FRxSTw5a/AZ0v7H+1YORsM93Ytcpl1PmLgCcYwrT4qGWsLgO4HBMZmdInJWah0Bq+6UAWAmT/WrljRqOUVgJ+WxRYei6GU9JuhLqFkN5zpweQujZPv9PtZ8VFOZy80jD0ExuhJ0GbjVvQ0i4rn1x9HOK7Cq9AQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tc5SahtsLFy4QqhBEKai20NZceoSUv8b9KwHPcdJ6RckO5myjsNRW1jw91pxJpURkEujv9Y77i9WJQNts8kxOJaGMUJEWoP5NUYjbx7zXVyzGgirQaYylvF8RO9ZgWRDOwFT89LdtJqXjTwpewmNOv6lJb5ggVXzEeQON5dSGzpoc9cD9dNQkPz/r/qOhTIqZK6e+tqACVgk7lZBmSoVA1L+UlunkMc+kOMfdDP34ghX7kqIaCBb+qsn1osP08U08d2Zu0QaAOGJpc0LQgNfRsy3cSkzz0PCx13A6niv6nIoXGrED/9H6A+jCBAdtboRlb6oiCHjxbjAx5D8DjrWLgTVGSWec2X92iPTzJd+S2xUB+oF0mrPbUJt02DEbKa6/awmZPv3L8fTsAO+G6adr/g+c6+g8rs5vLHdGgq2fKHW6p/ThOSN4cgaNs5jZBCo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:43:13.3687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7572d2fc-3ed6-4eb7-8a2a-08ded018c4e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180
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

Remove the legacy pmfw eeprom reset adaptation function,
as the feature is deprecated and unused

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 71 ++++++++-----------
 1 file changed, 30 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 09aa5655e3c1..baa8cc3646d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -450,57 +450,46 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
 	struct amdgpu_ras_eeprom_table_ras_info *rai = &control->tbl_rai;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	u32 erase_res = 0;
 	u8 csum;
 	int res;
 
 	mutex_lock(&control->ras_tbl_mutex);
 
-	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
-		hdr->header = RAS_TABLE_HDR_VAL;
-		amdgpu_ras_set_eeprom_table_version(control);
-
-		if (hdr->version >= RAS_TABLE_VER_V2_1) {
-			hdr->first_rec_offset = RAS_RECORD_START_V2_1;
-			hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
-					RAS_TABLE_V2_1_INFO_SIZE;
-			rai->rma_status = GPU_HEALTH_USABLE;
-
-			control->ras_record_offset = RAS_RECORD_START_V2_1;
-			control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
-			/**
-			 * GPU health represented as a percentage.
-			 * 0 means worst health, 100 means fully health.
-			 */
-			rai->health_percent = 100;
-			/* ecc_page_threshold = 0 means disable bad page retirement */
-			rai->ecc_page_threshold = con->bad_page_cnt_threshold;
-		} else {
-			hdr->first_rec_offset = RAS_RECORD_START;
-			hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
+	hdr->header = RAS_TABLE_HDR_VAL;
+	amdgpu_ras_set_eeprom_table_version(control);
 
-			control->ras_record_offset = RAS_RECORD_START;
-			control->ras_max_record_count = RAS_MAX_RECORD_COUNT;
-		}
+	if (hdr->version >= RAS_TABLE_VER_V2_1) {
+		hdr->first_rec_offset = RAS_RECORD_START_V2_1;
+		hdr->tbl_size = RAS_TABLE_HEADER_SIZE +
+				RAS_TABLE_V2_1_INFO_SIZE;
+		rai->rma_status = GPU_HEALTH_USABLE;
 
-		csum = __calc_hdr_byte_sum(control);
-		if (hdr->version >= RAS_TABLE_VER_V2_1)
-			csum += __calc_ras_info_byte_sum(control);
-		csum = -csum;
-		hdr->checksum = csum;
-		res = __write_table_header(control);
-		if (!res && hdr->version > RAS_TABLE_VER_V1)
-			res = __write_table_ras_info(control);
+		control->ras_record_offset = RAS_RECORD_START_V2_1;
+		control->ras_max_record_count = RAS_MAX_RECORD_COUNT_V2_1;
+		/**
+		 * GPU health represented as a percentage.
+		 * 0 means worst health, 100 means fully health.
+		 */
+		rai->health_percent = 100;
+		/* ecc_page_threshold = 0 means disable bad page retirement */
+		rai->ecc_page_threshold = con->bad_page_cnt_threshold;
 	} else {
-		res = amdgpu_ras_smu_erase_ras_table(adev, &erase_res);
-		if (res || erase_res) {
-			dev_warn(adev->dev, "RAS EEPROM reset failed, res:%d result:%d",
-										res, erase_res);
-			if (!res)
-				res = -EIO;
-		}
+		hdr->first_rec_offset = RAS_RECORD_START;
+		hdr->tbl_size = RAS_TABLE_HEADER_SIZE;
+
+		control->ras_record_offset = RAS_RECORD_START;
+		control->ras_max_record_count = RAS_MAX_RECORD_COUNT;
 	}
 
+	csum = __calc_hdr_byte_sum(control);
+	if (hdr->version >= RAS_TABLE_VER_V2_1)
+		csum += __calc_ras_info_byte_sum(control);
+	csum = -csum;
+	hdr->checksum = csum;
+	res = __write_table_header(control);
+	if (!res && hdr->version > RAS_TABLE_VER_V1)
+		res = __write_table_ras_info(control);
+
 	control->ras_num_recs = 0;
 	control->ras_num_bad_pages = 0;
 	control->ras_num_mca_recs = 0;
-- 
2.34.1

