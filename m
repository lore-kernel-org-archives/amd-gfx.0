Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B29DCD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 03:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 191CC10E6CF;
	Wed, 10 Jun 2026 03:38:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BxHDbMpp";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A95810E6CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 03:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSP1L4tQHMiYtDrwjN4BCXr9Ozucqs3SCIJpjkPBBE+Fz1STkZ05iwkQepSlZFegAjUmskky0Hxg13+S4os9Kmo7ixk4bh0lFV8W9QmSq7a4bEZXVVJWGsfAVcd1aGIWOa28vyvM9PVhSslHN64UpTZccVdb08ljCYE8fM6nEyPJZbLZSSNduPQUcRHx3Cf0QRBHitaSPaCAjsUCY3tvR4R8TQB0oK2sXWW5Vm3v4GN9QiWBCiioAIw8tKzJP4I+UOgygVl7MElWupYj4ZLMc6IDmK/rzEzI0hX8AR/6gpzRtTz597sDuobJK/ZhYSQ/2cynShCIbnhUokiSumRxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np/to5n/3EQMng0xYhWrY0s2czPyENbpByb0sIwNFrE=;
 b=DmrMKpdz+ZfZZ5jw2DH4T1R2m3mbh5jf7yVs267d6KAqI7gN3iHW9EnsUR07dI5WoCI52Wchj6b2AqQNsMOQqG8xABcWSampAZqLJoy9R64lcrb1IFiP5WFwTvNQfll9SWzr78Rrlj3rr664IIdPaW4wQ4Sfew7jNBNrRPo9mYJ4lcmqwTO8zhNI3wcwAg1o3VVxUHrrHqMm2OwNDFdTNt1HOiHC/dEiVBi/4J1NXohhpjIHqwMcqw3jr26DX+4R+5s3fBPeBA+kVLblN8Xmr035e40wAw3xErid2eJyxKhDZAwQJZWZJesBsqe4L9IwxYQsjnMNn7Rh1T1tpGFjHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np/to5n/3EQMng0xYhWrY0s2czPyENbpByb0sIwNFrE=;
 b=BxHDbMppMEVdZv1RIQ12a34LSBO0wXD/F/sjm9sJPmt69p29EKv6retXydSAtVrsI+6IsoQEtQvZw8GhQYd6gezFxZk5HreVOGSXS3BpnhYKXBGDys21GropB1oqOvBvNm30RLj41+99gYM7ykA59bax1xKoq3ErWGZHvWYvIzw=
Received: from DS1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:44c::17) by
 SJ5PPFCD5E2E1DE.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a2)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 03:38:34 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:44c:cafe::19) by DS1P220CA0026.outlook.office365.com
 (2603:10b6:8:44c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 03:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 03:38:34 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 22:38:32 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu/ras: Implement check_bad_page_unlock for uniras
Date: Wed, 10 Jun 2026 11:38:23 +0800
Message-ID: <20260610033823.613644-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SJ5PPFCD5E2E1DE:EE_
X-MS-Office365-Filtering-Correlation-Id: d80a43d5-2f66-47f4-7c35-08dec6a1bfad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: V9jEPCzjh/byXedZv4c6eIbMU/iWwcMSahAM36JpthKAvHVuU+plCTLb7oKzKAmBI142Zuhi7FZA4+2FUF0J/TqZHsUoRnECNPLQSZ6tqbGG3JbuGfJKWgfI5r28VSPclHUMat6crOTBFCw4BR7SmYruGfvhbOxJ2HuZ6/XxJn4UU9/3zLIfvtWPHpVOmq5+an7TaqQ8Yot8I3IEKhTGfA8lh1vLASa4oE0QfCLN7ZuaH8JUpFsLE0zKuZk/nunqE4FlNBxI/gMlHhCldlRVg7sMjbnnSJbbJpq8URcdWpfehaghdMIlhEnazLwPTme35mejes5vLbBe0ToxE1vUlxb3Yfbr6LRJCBXE7iAG1J0DfiGPYP7wiImpJi7hMcC2pseVIWG8DdOTd7Exj9eGV+s31knGOTuEiZb9yfK2zNSyLEOvFMYP6mvUz8MFXiq6o40k8Z3kUGRVXivS1IAfz72P7RDd77OlmQhD97DMYADwD/eHvaJV2l1P323ocs7tJd4qa21/dGMWkZLOUKmoLJDrjZGvFtPcbpU5+da36Qea6tgiQfp6RoUbz1lyLTyc3vxLONkC6FlcX+1jQi0P5z4bTw13zjIAkrxazCnaquAiIW86ST6C24VI62KtjT7kegZcIHOzPJklrAzJ0zwcaC7hztyEAawL8biZsNqxCfN3I2gwtDfhCf1N6uOD+DuIIbct+VU7vqAutZ/AEmo5n94IylmETlI74mTn7WSoWug=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ITG7vZJHK8salvz/2Nr/4pl/R9DkP6NzBd0zdlIxLMYNcqYBPM/eQAIgXFoCr2D9Mbxs7MXETMOIdQxc5E6ICyiIBn129lr5iHszp9/lRr7+Wi+xTbcJFh3M6FDnVYd06qP57cf4GKwnOHz6DaYiGhOgx71XudCxFidCleSI/C6JBGzuUDCeUUhEOxbmFrWSA7puTvpzKkXqA1DMSsUp1WMnQzEaHRP75JoM601MTLJcccQ4N0NZbpJXzC4k9aGcID5+IYn+cr4xqId9P/g3+FhHiumS4Ye/Cc7kv355/osxkjEzYev7pzQIdBg7boy1JUm+/1ui/cWIcHmgEIiuLxpBa/VMrVjo1VJuyqzyQLrcPg0bSmNvt4wx3TJ1UurbQpZf0XXcVWXELKKVbFn8BpgdX3faCSOvpJ7DZhngczJGI0gaWQgzh0ADHzuR5JnJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 03:38:34.0608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d80a43d5-2f66-47f4-7c35-08dec6a1bfad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCD5E2E1DE
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

Add check_bad_page_unlock() to ras_sys_func and racore to support
uniras bad page validation

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  |  3 ---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  | 19 ++++++++++++++
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     |  3 +++
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  2 ++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    | 10 +++++++
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 26 +++++++++++++++----
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h     |  1 +
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   |  3 ++-
 8 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index cb6498c30834..473b387fa3db 100644
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
index 7d728e523604..cc6d571a5479 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -266,6 +266,24 @@ static int amdgpu_ras_sys_put_gpu_mem(struct ras_core_context *ras_core,
 
 	return 0;
 }
+static int amdgpu_ras_sys_check_bad_page_unlock(struct ras_core_context *ras_core,
+						uint64_t addr)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	uint64_t pfn = addr >> AMDGPU_GPU_PAGE_SHIFT;
+
+	if ((addr >= adev->gmc.mc_vram_size &&
+	    adev->gmc.mc_vram_size) ||
+	    (addr >= RAS_UMC_INJECT_ADDR_LIMIT))
+		return -EINVAL;
+
+	if (pfn >= (adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT)) {
+		RAS_DEV_WARN(ras_core->dev, "Recorded address out of range: 0x%llx!\n", addr);
+		return -EINVAL;
+	}
+
+	return 0;
+}
 
 const struct ras_sys_func amdgpu_ras_sys_fn = {
 	.ras_notifier = amdgpu_ras_sys_event_notifier,
@@ -277,4 +295,5 @@ const struct ras_sys_func amdgpu_ras_sys_fn = {
 	.detect_ras_interrupt = amdgpu_ras_sys_detect_ras_interrupt,
 	.get_gpu_mem = amdgpu_ras_sys_get_gpu_mem,
 	.put_gpu_mem = amdgpu_ras_sys_put_gpu_mem,
+	.check_bad_page_unlock = amdgpu_ras_sys_check_bad_page_unlock,
 };
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
index 8156531a7b63..239e56732e3e 100644
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
index 6449d7b8627d..6c3697de1f98 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -231,6 +231,7 @@ struct ras_sys_func {
 		enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
 	int (*put_gpu_mem)(struct ras_core_context *ras_core,
 		enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
+	int (*check_bad_page_unlock)(struct ras_core_context *ras_core, uint64_t addr);
 };
 
 struct ras_ecc_count {
@@ -399,4 +400,5 @@ int ras_core_get_device_system_info(struct ras_core_context *ras_core,
 		struct device_system_info *dev_info);
 int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_core,
 		uint64_t soc_pa, uint64_t *page_pfn, uint32_t max_pages);
+int ras_core_check_bad_page_unlock(struct ras_core_context *ras_core, uint64_t addr);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 29b1b8f0cc26..efd4023f133b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -676,3 +676,13 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_core,
 
 	return count;
 }
+
+int ras_core_check_bad_page_unlock(struct ras_core_context *ras_core,
+		uint64_t addr)
+{
+	if (ras_core && ras_core->sys_fn &&
+		ras_core->sys_fn->check_bad_page_unlock)
+		return ras_core->sys_fn->check_bad_page_unlock(ras_core, addr);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index d4072350f48f..7ff019a8c7a8 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -373,7 +373,7 @@ static int ras_umc_update_eeprom_ram_data(struct ras_core_context *ras_core,
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
 	struct eeprom_store_record *data = &ras_umc->umc_err_data.ram_data;
 	uint64_t page_pfn[16];
-	int count = 0, j;
+	int count = 0, i, j;
 
 	if (!data->space_left &&
 		ras_umc_realloc_err_data_space(ras_core, data, 256)) {
@@ -385,6 +385,18 @@ static int ras_umc_update_eeprom_ram_data(struct ras_core_context *ras_core,
 					bps, bps->cur_nps, page_pfn, ARRAY_SIZE(page_pfn));
 	if (count > 0) {
 		for (j = 0; j < count; j++) {
+			if (ras_core_check_bad_page_unlock(ras_core,
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
@@ -489,9 +501,11 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 {
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
 	struct eeprom_store_record *data = &ras_umc->umc_err_data.rom_data;
-	uint32_t eeprom_record_num;
+	struct eeprom_store_record *ram_data = &ras_umc->umc_err_data.ram_data;
+	uint32_t eeprom_record_num, logical_count = 0;
+	uint32_t retire_unit = ras_core->ras_umc.retire_unit;
 	int save_count;
-	int ret = 0;
+	int ret = 0, i;
 
 	if (!data->bps)
 		return 0;
@@ -515,8 +529,10 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 			ret = -EIO;
 			goto exit;
 		}
-
-		RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table.\n", save_count);
+		for (i = ram_data->count - retire_unit; i < ram_data->count; i++)
+			if (ram_data->bps[i].cur_nps_retired_row_pfn != U64_MAX)
+				logical_count++;
+		RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table.\n", logical_count);
 	}
 
 exit:
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
index 1d3026be509b..05edacc165ba 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -139,6 +139,7 @@ struct ras_umc {
 	u32 pending_ecc_count;
 	/* number of entries dropped because pending_ecc_list was full */
 	u32 pending_ecc_dropped;
+	u32 retire_unit;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index b809a2f21d73..0064e89ac1ab 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -110,6 +110,7 @@ static void __get_nps_pa_flip_bits(struct ras_core_context *ras_core,
 			"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
 		break;
 	}
+	ras_core->ras_umc.retire_unit = 0x1 << flip_bits->bit_num;
 }
 
 static uint64_t  convert_nps_pa_to_row_pa(struct ras_core_context *ras_core,
@@ -166,7 +167,7 @@ static int lookup_bad_pages_in_a_row(struct ras_core_context *ras_core,
 
 	idx = 0;
 	row = 0;
-	retire_unit = 0x1 << flip_bits.bit_num;
+	retire_unit = ras_core->ras_umc.retire_unit;
 	/* loop for all possibilities of retire bits */
 	for (column = 0; column < retire_unit; column++) {
 		soc_pa = row_pa;
-- 
2.34.1

