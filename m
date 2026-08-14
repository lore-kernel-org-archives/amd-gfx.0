Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635FBC5DF77
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9201710F728;
	Fri, 14 Aug 2026 21:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tnGPqlPQ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA0A10F6FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA/Ugch4YOFM4MD6y+HysTKWmbL3kObV57Yr58Aq9AwZZJADv89BKp3feE0RCKXh6857fF9Q9oqOejr1d/WeCm/ZBgqvY0DxBZacUUFH4AgA7GyH71xP3QTI3sZlrLQTfiy7VKrVCYXbvufFsUTdBHn7obMyqrKoaTgJ+je3CBYcSfLvAkILwZfLDjV6e2BVkD5ZjgFMOpL2gquDSR9nLOfPrvghMiy3OqWREub0/+bAHcJuGucbevDI1MyXP1FOa5Hi2cbxo7GIjVkmV2By+38o2d8nEJmBS8FcotRMD8YtYNlfhvTQPQlLxhiFeURIB46SCNfX7N4iXTeUf4RnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qy9wdat7iqV4DI8LkZ1A1C6cfObKSszVPYagMetIeAo=;
 b=aXXl63XzvzzAl9A3gE2UENjKEyugcHFY3F4IJgKDAI72jkwaQFzJMu6sWt9PyojDWxWpMWEpWi6ASCFlvhDfISB3j7z6D9k8HPdCTwxGs5LFx94LDEFEeaVOrZihQlFEppER0RXUex4rT2O3fj0EV6YMkPE+dtN8atRtz25rEo0gK3GjQRc16C/JdR/Luz5nvmxUr0QN0VWYudw/+O+9iVsqaMZvBiHthdmLC56e2MDY1TsXgRFyP+tRY+mSH5/cY9vCUdxjiKCBzEITdGnkzhQqkWlpyDxKApj7b4dySr664TG8mJU6Eun1xxuV+SERt7vyl2WlbkRSXk6Xaz3eRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy9wdat7iqV4DI8LkZ1A1C6cfObKSszVPYagMetIeAo=;
 b=tnGPqlPQX8x6HyjAvld3vFyFoo1676aVIpbm+wCfAZuhcPKRo29jHh+i4gxQ7E5hKxrZu9wzSF6+ubRgBdN9kdBv9zIQTGbqhyGIhMgwZQwEi1QhLjmGewLf83XhRHtc8CtNNthtXZ0gvE7SXeLnB1I5MnAs9Zwi5QYIkpLamL4=
Received: from CH0PR04CA0027.namprd04.prod.outlook.com (2603:10b6:610:76::32)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 14 Aug
 2026 21:03:36 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:76:cafe::1a) by CH0PR04CA0027.outlook.office365.com
 (2603:10b6:610:76::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:27 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 049/109] drm/amd/ras: add interface to report bad page info
Date: Fri, 14 Aug 2026 17:01:46 -0400
Message-ID: <20260814210246.3067612-50-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 566ebd6e-a8cf-4da0-3796-08defa4781fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|22082099003|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: fCXNwnFtLvjn7PcdsPSX34TUb5x7j6C1wGgFJme54wlaFqNfKQ+WGqlNZhfyGZlws5Np95pKrPwOIfnkUyz6bVXV0XizIsn2Q7fFThqgFHAL6u0KUEaQhAXt10h7FD27agpuAmjEsq9gWD1uHq0vJ4ASA8AyfsrcJNzelKKst0xXW5tpDwxg+5NvznS6zXED7jfway3xVo0xyvZ8FBy7TEpud3jmryN0OvdYNNj3LlZBHWNYqe2ObsT9TrHcaWunpkeaQi6mYh98wtf4dtZ1EzaPhuFhor9v08mw6qEMCd5u5Y5Th2Zf6MJCi16TRnd89AGv9qzeuZMJD8AyxurN8APwxePPNoWeRuWIpu9CSgBWGD2ApxjoKnj3L2oPURcjSFT85HktIsZysmueOVXLpXne3YZbTqmyUglCRDCO8594wUN8gVFOSoxMZthI0Ox2vWPQk7xS2Ks0V7UMKbfZ5rncmnC3YStroGj1KbULMQ05bkspMz+HTZ5yeJWOqH/wbS3Na4bfb5f+sJMBeUhPatwZsnNve9r8N0Ev6nuvTFXhEzC50WU9t9tw79Bf7jDdZ386ewz2zAwT7UAZd9MyIQax1gTp8v7QmwguvZWq7nUTZ9fKXOnz13ZVj1Nc3B/8HDt2iQkoiPxD/+1ukYTsQ8MaG0Ot84+6i3vPqmNFiJI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cdl63zE8SqjXQV5NlAF+asfdlCyEHs9TdOUrgA2PUMdfricpUXmtUj+PA79kX6xrUkF0lWcRZwuVePqGyOYKw5bsyFA3lzdz5CnrsQzvt4Zj+DBJZTMxO1sUPswHVqjN6+RtVz/EfaNAGSzHbSBOUBQFZD7o7IF0rhWAqhiMeSVSL789rGyfruKXFztZ+cks5KGdX8O3jozhe70WYFRYe+2WHlpQY1HqVogZ/dyPec7zDOk+mR6VPrzZKG/MiTzwR1gyU4JdOMJG4OmEYy9jPP3aM95x9P27l7oCQ8t2z/6hgSMgfVCETBcAH9znU0d5bfl/sBYjuwyIIcSj81xFJWnSAf4wp2RIQp9NcQIxT0vTmweefpEcubvVD3dw1FqKdkW+Y1jA5qxQCSWl6qTtIdn+N8o+1reelbd4n/y0oYhlLcen69gfRc5EEDKH6/6O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:36.3139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 566ebd6e-a8cf-4da0-3796-08defa4781fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
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

Add interface to report bad page info.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_umc.c | 43 +++++++++++++++++++++++++-
 drivers/gpu/drm/amd/ras/core/ras_umc.h |  5 +++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index ee4ad9ffb50c0..0e6a341f0729a 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -534,6 +534,11 @@ static int ras_umc_update_eeprom_rom_data(struct ras_core_context *ras_core,
 	memcpy(&data->bps[data->count], bps, sizeof(*data->bps));
 	data->count++;
 	data->space_left--;
+
+	/* update bad channel bitmap */
+	if (bps->mem_channel < BITS_PER_TYPE(data->umc_channel_bitmap))
+		data->umc_channel_bitmap |= 1 << bps->mem_channel;
+
 	return 0;
 }
 
@@ -578,6 +583,10 @@ static int ras_umc_update_eeprom_ram_data(struct ras_core_context *ras_core,
 		return -EINVAL;
 	}
 
+	/* update bad channel bitmap */
+	if (bps->mem_channel < BITS_PER_TYPE(data->umc_channel_bitmap))
+		data->umc_channel_bitmap |= 1 << bps->mem_channel;
+
 	return 0;
 }
 
@@ -589,6 +598,27 @@ static void ras_umc_update_bad_pages(struct ras_core_context *ras_core)
 	data->bad_page_num_old = data->bad_page_num;
 }
 
+void ras_umc_report_badpage_info(struct ras_core_context *ras_core)
+{
+	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	struct eeprom_store_record *data = &ras_umc->umc_err_data.ram_data;
+
+	if (ras_umc->last_record_count != data->count) {
+		ras_umc->last_record_count = data->count;
+		ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM,
+			&ras_umc->last_record_count);
+	}
+
+	if (ras_umc->last_channel_bitmap != data->umc_channel_bitmap) {
+		ras_umc->last_channel_bitmap = data->umc_channel_bitmap;
+		ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP,
+			&ras_umc->last_channel_bitmap);
+	}
+
+	if (ras_core->is_rma)
+		ras_core_event_notify(ras_core, RAS_EVENT_ID__DEVICE_RMA, NULL);
+}
+
 int ras_umc_add_bad_pages(struct ras_core_context *ras_core,
 	struct eeprom_umc_record *bps, uint32_t bps_sz, uint32_t *valid_sz)
 {
@@ -622,8 +652,11 @@ int ras_umc_add_bad_pages(struct ras_core_context *ras_core,
 
 	*valid_sz = c;
 
-	if (c)
+	if (c) {
 		ras_eeprom_mgr_check_and_report_status(ras_core, true);
+		if (!ras_core_in_early_init(ras_core))
+			ras_umc_report_badpage_info(ras_core);
+	}
 
 out:
 	mutex_unlock(&ras_umc->umc_lock);
@@ -781,8 +814,16 @@ int ras_umc_sw_fini(struct ras_core_context *ras_core)
 int ras_umc_hw_init(struct ras_core_context *ras_core)
 {
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
+	int count = ras_umc_get_badpage_count(ras_core);
+
 	ras_umc->num_umc = ras_core->config->umc_cfg.num_umc;
 
+	/* For preloaded bad pages case, bad page info is
+	 * deferred to report in hw init.
+	 */
+	if (count > 0)
+		ras_umc_report_badpage_info(ras_core);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.h b/drivers/gpu/drm/amd/ras/core/ras_umc.h
index 5a3e019af8ad9..5b7b497503927 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.h
@@ -155,6 +155,7 @@ struct eeprom_store_record {
 	 * ras_num_recs * retire_unit
 	 */
 	int bad_page_num_old;
+	uint64_t umc_channel_bitmap;
 };
 
 struct ras_umc_err_data {
@@ -177,6 +178,9 @@ struct ras_umc {
 	u32 pending_ecc_count;
 	/* number of entries dropped because pending_ecc_list was full */
 	u32 pending_ecc_dropped;
+
+	u32 last_record_count;
+	u64 last_channel_bitmap;
 };
 
 /*
@@ -225,4 +229,5 @@ int ras_umc_bank_to_umc_record(struct ras_core_context *ras_core,
 int ras_umc_record_to_nps_record(struct ras_core_context *ras_core,
 		struct eeprom_umc_record *record,  uint32_t nps);
 int ras_umc_dump_fw_records(struct ras_core_context *ras_core);
+void ras_umc_report_badpage_info(struct ras_core_context *ras_core);
 #endif
-- 
2.55.0

