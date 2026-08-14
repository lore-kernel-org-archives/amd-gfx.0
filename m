Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B004C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CCEC10F742;
	Fri, 14 Aug 2026 21:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J3snALnf";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D959710F730
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H10RN1vdTgg7bPFdGQT686W8j4OzxRgaK0EaZbCCFYh0x88LKSp6F6IP39WrErDTKirsU//BP/ghGLEfPXGCi8FRojpOvUJS/ldBZxT34FcrMiDYhCbIOLFgxy9L79HfbZbXJLx0tasqgUSfsfg4AZB1wR5k5FtMwcnWzEGSr0E1s0FjfnVhinZ4gAcPbHR1PE2216RCuS59eY53j2NORYpHrxONdnnFLRsS85c3pVvSG1U+6tFJ3p/ne+SAjpteP8ttTO4vUxiM5hf+0uvQ/0by9a3p/VbqGvTkURrgaH9mNI2JmG68NqVDKXII829a2yPwavj5PSbhHMleOl6T8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jU34EcQnYkmeJZfr8aVXRZEP1EIjHbrXhU7XXSSXqfs=;
 b=BVcQfRmZVHOsBI5CyJ6YM5/kZpsK0fkjnVo5z8N0beTCM58T74LpDSmURln0i8sVjBGr92xEvb68gs7AyMhYs/DaaJtuQtVyCjReBcMGoBCEguT8cVsNf//TUPlG+Ss7UcjjYa9OiPeDLVZVDG5YiddFip8JIjUU9qjIIMCZTOMleCg3FgIMp6LW+fCB2anakRtU1uQDzQAcACxreOokV5NP/x/oVx/u1wPbDZe3vYXeWNDI4SiPvZqgl8tvHkjJYmmXict83HM786queOyMgD3T1YIoesCCgmFh26gM+JvUeTa9vINZZSxk5Is8hIACyuTAl3sXgKiKQdwpYgmouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jU34EcQnYkmeJZfr8aVXRZEP1EIjHbrXhU7XXSSXqfs=;
 b=J3snALnfjUvtndAQjJBTF9Ddo7J2lQLdnOhFIZvkPvpTPR2/4x/fBVVVyYoAnoVpkPC/SVXLdCiZuNdO5C5rAQKhcreckqzHU1VlF6s2x89ybWhO0YMu5DdEiKBeWOyNvW16M77g0HvZYfXd42efvuXmkvGXKaYpZlTAHFfTApk=
Received: from BN9PR03CA0589.namprd03.prod.outlook.com (2603:10b6:408:10d::24)
 by LV5PR12MB9778.namprd12.prod.outlook.com (2603:10b6:408:300::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:58 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::66) by BN9PR03CA0589.outlook.office365.com
 (2603:10b6:408:10d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 096/109] drm/amd/ras: fix and improve bad page count
 calculation
Date: Fri, 14 Aug 2026 17:02:33 -0400
Message-ID: <20260814210246.3067612-97-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|LV5PR12MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c95c234-2f93-4b0c-ed4e-08defa478eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yfTB/YohZoQUsnweb/BfwxLavXQf3lsXBrIxf6AwZ+VV9gQLRKGzkGZF9bkSTKvNCAg5Y8x8J4odTzZ0Pcq76+F0m1g+2YitaU3u9zwPsWDI8sCpDJplXZN0bQ0uCHw6KkbV+pe3T9sJIU8/WR608zxk5h5UrdHtQyxtwaDf4i9YDLnFiQmH+8niY3cBX4G419uUjT5/91n1YkovsOfUpEdD0B05ou7RMsPpgbPIpDNbAjB1S7AWpwgQRpy5G55DL+ADT1R+Sd1sSsMZ5ngY57z4da3oHtrs8HON9OumzBle6URoVuEvOXuwgkJgp/Q4G+gIT10RDqqRhuDlS8jhVH9pxJ5/kgdDNILl3kR/m5CTVG4zPMXQniON+DaYQpl+QXQpWknS6MTZz+XEJDKpH/1C6jPhG0r6Kl5vnM1UdyJc5S51dX+MlQwdopZlLgAu+7U4g7LDT/0g2GgiIzw+/xRnt6TKrzaqEIFwzF0JZByqK6HDDT5SMO2kE7NDxd4Poh4T4MbmNDkr5+WW3vRiTGJ4R6eYOOi8Z5hQf2RCO023kSOvaQqmv970gc+7YOztx9ZzQJv2SmtgHGN8k8xxNjdD94PVcmUNObH+ndwGQ4lka2kyeD0BPPOLuabyogNKpTH4WTP9TlFLOnY+aodEK6ExV5zJYQQd3aL9lubyyChX4BsTa0iYv1HgQaSoFTKiPU5epzNX9a/0GtW417zLrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +9PX2vrhekm59wmtV+IpIlYJe5DTVuRQ+59mdsiamyElNLTkIE7qWcUT3Du8XCg5Qv4kCm8oqafMJc0Aj02kD1f6oShZXxlVluYi8Ta2m5fzj0QHUVKlLktRKKGj8wLk938JtFsnSApxi4Ko9aep10nUl6lthb3LA/y5CaDqD1Z73TjHpuiJ//RZZUW20Ctv3cTAt62pUgmmjHvhKfKft5nENe2i7XSSrplIvZTwAoLWiwWidYepgwwBMCl4/2k8e6nzhBC0O/Rf9mmTbGd0RvSSXlurQhKfjESUIhJOm84D3kT2UKms6naSLNFLGAOHWryVCMkARV1IZhLlabPJ2MgvKoWr5L4hhV1Z7BvsLOCbaqrZM+Im1xSVD/N8G6urHC8djcH7q3PgINUULD1Mik2WR7wkdgq3ZWA5tnAGZaHzH03TsfEOTkvJYFGrlD5Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:58.0145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c95c234-2f93-4b0c-ed4e-08defa478eea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9778
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

Fix an issue where the saved bad page count is always zero.

The cur_nps_valid_page_num field in the record already tracks
the available bad page count, so use it directly to calculate
the correct saved bad page number.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_umc.c | 32 +++++++++++++-------------
 drivers/gpu/drm/amd/ras/core/ras_umc.h |  6 -----
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index 4cce9f5c65932..3e546e7fde59b 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -683,14 +683,6 @@ static int ras_umc_update_eeprom_ram_data(struct ras_core_context *ras_core,
 	return 0;
 }
 
-static void ras_umc_update_bad_pages(struct ras_core_context *ras_core)
-{
-	struct ras_umc *ras_umc = &ras_core->ras_umc;
-	struct eeprom_store_record *data = &ras_umc->umc_err_data.ram_data;
-
-	data->bad_page_num_old = data->bad_page_num;
-}
-
 void ras_umc_report_badpage_info(struct ras_core_context *ras_core)
 {
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
@@ -797,15 +789,24 @@ int ras_umc_load_bad_pages(struct ras_core_context *ras_core)
 	if (ret)
 		RAS_DEV_ERR(ras_core->dev,
 			"Failed to load EEPROM table records! ret:%d\n", ret);
-	else {
+	else
 		ret = ras_umc_add_bad_pages(ras_core, bps, ras_num_recs, &c);
-		ras_umc_update_bad_pages(ras_core);
-	}
 
 	kfree(bps);
 	return ret;
 }
 
+static int ras_umc_count_valid_pages(struct ras_core_context *ras_core,
+		struct eeprom_umc_record *records, const u32 nr_records)
+{
+	int count = 0, i;
+
+	for (i = 0; i < nr_records; i++)
+		count += records[i].cur_nps_valid_page_num;
+
+	return count;
+}
+
 /*
  * write error record array to eeprom, the function should be
  * protected by recovery_lock
@@ -815,8 +816,7 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 {
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
 	struct eeprom_store_record *data = &ras_umc->umc_err_data.rom_data;
-	struct eeprom_store_record *ram_data = &ras_umc->umc_err_data.ram_data;
-	int eeprom_record_num, logical_count = 0;
+	int eeprom_record_num;
 	int save_count;
 	int ret = -ENODATA;
 
@@ -833,7 +833,6 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 
 	mutex_lock(&ras_umc->umc_lock);
 	save_count = data->count - eeprom_record_num;
-	logical_count = ram_data->bad_page_num - ram_data->bad_page_num_old;
 	/* only new entries are saved */
 	if (save_count > 0) {
 		ret = ras_eeprom_mgr_append_records(ras_core,
@@ -845,8 +844,9 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 			goto exit;
 		}
 
-		ras_umc_update_bad_pages(ras_core);
-		RAS_DEV_INFO(ras_core->dev, "Saved %d records to EEPROM table.\n", logical_count);
+		RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table.\n",
+			ras_umc_count_valid_pages(ras_core,
+				&data->bps[eeprom_record_num], save_count));
 	}
 
 exit:
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.h b/drivers/gpu/drm/amd/ras/core/ras_umc.h
index 362c9ce6a404b..db480d15aad43 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.h
@@ -151,12 +151,6 @@ struct eeprom_store_record {
 	int count;
 	/* the space can place new entries */
 	int space_left;
-	/* logical bad page number */
-	int bad_page_num;
-	/* the bad page number is ras_num_recs or
-	 * ras_num_recs * retire_unit
-	 */
-	int bad_page_num_old;
 	uint64_t umc_channel_bitmap;
 };
 
-- 
2.55.0

