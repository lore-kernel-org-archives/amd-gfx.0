Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9E4CD98CC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 07:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C46C10ED3A;
	Thu, 11 Jun 2026 07:44:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cj7u3vsX";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43C4010ED3A
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 07:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNLgw17tN/wPEdCO19HFeiXhMlfEQwQtFv7YAyyKNw4uAhmxosHO/2YReQ22g8yIZxp+C9jZpViAxQKuVBBjIPfmL94AvdNE5mby4WXaHadzSw//STYPv9rWMriYLsM/1jZ4c7NQqvh7QoaN0ifpuXCBBB6PQ2SBDRIAPNuoRmAJRT3Wo5WrBP/H4QchtfgTLvcGsYFIxFZz25V3RGs63jHvPWlnQbYNcYr10rq0Cj4ZhX0Pg0hHvaGDs+voyKEIfjju4c66yV02dKP0WEBu3BZSoosLZ1VA9Wefa3XQ+bmVVNB1zJG5YDJ052ggyu38DaTIZaTQJwJijCtALX46aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tzl3t5agiDAacAbLqOmDYwATkdL3wM4gq8q1nhmn9sk=;
 b=p9uZ1IxuJ2qOQuUUxW7vfDtj7320aE61j85B9Q3q0VU/O9V/0iuBBNbKTqA3SVPhdhC81Pc8DAYUTUcIN/gCLr3e27T2sAQ/gCruwmGbEF609uT/tYygR8MXNqE5MqKqyDA1sF6biLEOZNURm+mZeaRpHARaYkxMWnUY44zbaFOU/Hcb/b5McQVxKg3UbRtmLcb9SLd6CWXWOZWxlPR/fkyl24du2XTp3Q72ELF1QuYgX22Q1ASvBq6wcSQ+ufpa9LLdePgHtRAZXtRt5WHJfeMhyHOMQyEuJPY964MH9ucSTPpzFK/kkuf/JDVM5KUzcP/Npp46XekeYFBKPjGN7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzl3t5agiDAacAbLqOmDYwATkdL3wM4gq8q1nhmn9sk=;
 b=cj7u3vsX3HiTFcyLCXY5+AKxqdXWXfcvQxnRzWgy8+RlgDEQVRyvFz4pVT+SjVkwbJG8FYXuOB41bGw5ML8gzdvftUMKy2QiDjtpdXsPILYSFvCtZFaO8c2kF7t6gOpHdtrG++OKQxyablf3j+5bmrSK+UdoOTzuGjPjZAQY1Is=
Received: from BL1P223CA0044.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::17)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 07:44:46 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::97) by BL1P223CA0044.outlook.office365.com
 (2603:10b6:208:5b6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 07:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 07:44:45 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 02:44:44 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v2] drm/amdgpu/ras: Add address sanity check for uniras
Date: Thu, 11 Jun 2026 15:44:35 +0800
Message-ID: <fef4383d214d9f82eb2f5426aecf5f3a27e33b6a.1781163712.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ca3cc4-2872-4e31-1fee-08dec78d4ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: YMCBk7ZklJdUBuL8bOY38C8BwaNavz2I5+OZkYQ8muTqLvLv/qXZ6PngXHOrkV9hV8vVBqRQi9xwtZxmFe86jyLCFl3cDQM3znGxw7pBP0XojTX5/Jtu7P5/BR3h+2Pe6lU9Edj+fb54j8hmIqQyZSxMyNycoh4+3pKIPMim/6O5F+33Ye3Zg6M8udsscq2SPeqsvCrebcMWyWz7aWvUyT0j4m+HCT/SaAHktV/EbZF8sQV7tyosly+S9qcRMljcMVXSi9zmnCy4pkjTuY4zHTF+y3c8Jd2+Tg3PQxaQCDjL7ZMJnAnrmamp3xEE/EPDgyNsXtkoGPkq09KpPwRbeV9DRszg0WilOT8pt3tM49svoAkbihlI4jH515dltqVK2VkDwsmBKEAM9axtEImZiS/kYrqS2h0k91oTZR5WD/oWp0rIvz5i84OjNQtEikt4mcPb5/JrBOYbM2IcywDtKAyAV9O+UvfTC3I98NE79yiXS5IYqgVRLgR6ioxjKn/odzUJjjBaClvJOcxQ8s0VC7EkRy/vQoNIAdWUiRFXKLywC2UmZsWxDOmWNXfNQWAPWk4Su/pqo9tlh5eIhQQIbzgG+kn/bDBgRY9+AewyUOLqToGX3Wj1Z5FjjjmVifgKFwdHFM5d8kK2bbAeJxCftlQtUrS4yMHVYsqgHo6Gmye6EnBgwTAVPm4RPBkez5GwZOGqCIfpL8AZUgXdKIY2NPZPEbahwChrIkQQE+epomc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1+baWlgVnROPGvidGjSjLpdO1akRVOoQcdWdZR4nLdhc+WcO1p+BsjFloW3O1GLHc0mOQ2YJPhxY1lMd5EAPdRcQUHnTclKBPKjTRZNdNnYflokf0H5WmFFPO21wSoln2NeAbzT9dB9J8ZB8SSPCx1W/yPjsiqBM3kY36kCUUQm7b1Oujs+DX2JeLIIzuB2plPqJ9TWWMBnfPwhYDfyN0oPI2bzpfeLWcHoDJtqtVgaIw0BT7jF5ZkJE9hTSr6iLrHsP8ahdnyaKoYDK0DV6vot++SWf7MV6iyPNfHZpIt57yzdc+1cF7FnDWn1BraCXbIIU9yonsO6OEYtPLJTCURma28gJ5oQ8mzQJ5nlQrGyiCdY3Lpn0OsH9r5oz/FG1qC5aVvg1LBOJ49i9aBptqv9IvpNOUD4S6iTVc3kWlhDrn4xgoB+/owJyksv5fSwS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 07:44:45.8750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ca3cc4-2872-4e31-1fee-08dec78d4ec6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
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

Add address sanity check for uniras

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  |  3 ---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  | 18 +++++++++++++++
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     |  3 +++
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  2 ++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    | 10 ++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 23 +++++++++++++++----
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h     |  2 ++
 7 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index 658bf3fdb66b..bfbfdffbfbe6 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -30,9 +30,6 @@
 #include "amdgpu_ras_mgr.h"
 #include "amdgpu_virt_ras_cmd.h"
 
-/* inject address is 52 bits */
-#define	RAS_UMC_INJECT_ADDR_LIMIT	(0x1ULL << 52)
-
 #define AMDGPU_RAS_TYPE_RASCORE  0x1
 #define AMDGPU_RAS_TYPE_AMDGPU   0x2
 #define AMDGPU_RAS_TYPE_VF       0x3
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index 7d728e523604..eb840f0861fe 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -266,6 +266,23 @@ static int amdgpu_ras_sys_put_gpu_mem(struct ras_core_context *ras_core,
 
 	return 0;
 }
+static int amdgpu_ras_sys_check_address_sanity(struct ras_core_context *ras_core,
+						uint64_t addr)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+
+	if ((addr >= adev->gmc.mc_vram_size &&
+	    adev->gmc.mc_vram_size) ||
+	    (addr >= RAS_UMC_INJECT_ADDR_LIMIT))
+		return -EINVAL;
+
+	if (addr >= adev->gmc.real_vram_size) {
+		RAS_DEV_WARN(ras_core->dev, "Recorded address out of range: 0x%llx!\n", addr);
+		return -EINVAL;
+	}
+
+	return 0;
+}
 
 const struct ras_sys_func amdgpu_ras_sys_fn = {
 	.ras_notifier = amdgpu_ras_sys_event_notifier,
@@ -277,4 +294,5 @@ const struct ras_sys_func amdgpu_ras_sys_fn = {
 	.detect_ras_interrupt = amdgpu_ras_sys_detect_ras_interrupt,
 	.get_gpu_mem = amdgpu_ras_sys_get_gpu_mem,
 	.put_gpu_mem = amdgpu_ras_sys_put_gpu_mem,
+	.check_address_sanity = amdgpu_ras_sys_check_address_sanity,
 };
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
index f34dda7ce87b..2775c7bf41b7 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
@@ -30,6 +30,9 @@
 #include <linux/mempool.h>
 #include "amdgpu.h"
 
+/* inject address is 52 bits */
+#define RAS_UMC_INJECT_ADDR_LIMIT       (0x1ULL << 52)
+
 #define RAS_DEV_ERR(device, fmt, ...)                                               \
 	do {                                                                      \
 		if (device)                                                             \
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index c059fcebaf00..5869bad978b0 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -231,6 +231,7 @@ struct ras_sys_func {
 		enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
 	int (*put_gpu_mem)(struct ras_core_context *ras_core,
 		enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
+	int (*check_address_sanity)(struct ras_core_context *ras_core, uint64_t addr);
 };
 
 struct ras_ecc_count {
@@ -398,4 +399,5 @@ int ras_core_get_device_system_info(struct ras_core_context *ras_core,
 		struct device_system_info *dev_info);
 int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_core,
 		uint64_t soc_pa, uint64_t *page_pfn, uint32_t max_pages);
+int ras_core_check_address_sanity(struct ras_core_context *ras_core, uint64_t addr);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index ad6fffaa42de..61d100b074b9 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -676,3 +676,13 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_core,
 
 	return count;
 }
+
+int ras_core_check_address_sanity(struct ras_core_context *ras_core,
+		uint64_t addr)
+{
+	if (ras_core && ras_core->sys_fn &&
+		ras_core->sys_fn->check_address_sanity)
+		return ras_core->sys_fn->check_address_sanity(ras_core, addr);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index e5971c3dd7da..f56d37d09044 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -406,7 +406,7 @@ static int ras_umc_update_eeprom_ram_data(struct ras_core_context *ras_core,
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
 	struct eeprom_store_record *data = &ras_umc->umc_err_data.ram_data;
 	uint64_t page_pfn[16];
-	int count = 0, j;
+	int count = 0, i, j;
 
 	if (!data->space_left &&
 		ras_umc_realloc_err_data_space(ras_core, data, 256)) {
@@ -418,10 +418,23 @@ static int ras_umc_update_eeprom_ram_data(struct ras_core_context *ras_core,
 					bps, bps->cur_nps, page_pfn, ARRAY_SIZE(page_pfn));
 	if (count > 0) {
 		for (j = 0; j < count; j++) {
+			if (ras_core_check_address_sanity(ras_core,
+				page_pfn[j] << AMDGPU_GPU_PAGE_SHIFT)) {
+
+				for (i = 0; i < data->count; i++)
+					if (page_pfn[j] == data->bps[i].cur_nps_retired_row_pfn)
+						break;
+				data->bps[data->count].cur_nps_retired_row_pfn = U64_MAX;
+				data->count++;
+				data->space_left--;
+				continue;
+			}
+
 			bps->cur_nps_retired_row_pfn = page_pfn[j];
 			memcpy(&data->bps[data->count], bps, sizeof(*data->bps));
 			data->count++;
 			data->space_left--;
+			data->bad_page_num++;
 		}
 	} else {
 		RAS_DEV_ERR(ras_core->dev, "Failed to convert record to nps pages!");
@@ -521,7 +534,8 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 {
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
 	struct eeprom_store_record *data = &ras_umc->umc_err_data.rom_data;
-	uint32_t eeprom_record_num;
+	struct eeprom_store_record *ram_data = &ras_umc->umc_err_data.ram_data;
+	uint32_t eeprom_record_num, logical_count = 0;
 	int save_count;
 	int ret = 0;
 
@@ -534,6 +548,7 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 		eeprom_record_num = ras_eeprom_get_record_count(ras_core);
 	mutex_lock(&ras_umc->umc_lock);
 	save_count = data->count - eeprom_record_num;
+	logical_count = ram_data->bad_page_num - ram_data->ras_num_bad_pages;
 	/* only new entries are saved */
 	if (save_count > 0) {
 		if (ras_fw_eeprom_supported(ras_core))
@@ -547,8 +562,8 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 			ret = -EIO;
 			goto exit;
 		}
-
-		RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table.\n", save_count);
+		ram_data->ras_num_bad_pages = ram_data->bad_page_num;
+		RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table.\n", logical_count);
 	}
 
 exit:
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
index 237525b46b9b..ad12796a048f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -119,6 +119,8 @@ struct eeprom_store_record {
 	int count;
 	/* the space can place new entries */
 	int space_left;
+	int bad_page_num;
+	int ras_num_bad_pages;
 };
 
 struct ras_umc_err_data {
-- 
2.34.1

