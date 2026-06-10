Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20727CD8CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 10:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE4210E47D;
	Wed, 10 Jun 2026 10:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VoYmOR+j";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB5710E47D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 10:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuKxN6RI6OMJvVVtPRv9Jaa67ajPaJ6e2Qp3EJJn3xcYKuoSJh9SlF3IHAqhk86PikTDMbJKkZ8UkrGXH/qs8/C31SE3zUBMCagsBaYW4Fn9emDMIiQxNRaAV9IdCLtA/F2g8mLNaj7sJHO0e6UkxFdAkC9GyjlNn1WEcaR1Wfv8+weE5ycY9OmWbzUzjB4/p74tZwDOliwp0SM7IvzxXCWOegkyKgp0IB2Kbbwq9NsYCpjtajXvNKtH4JFLokVfx1PR9kcMOt7oFUmS/wnDCtKvEMi3y/35Kx3RYdu2YBCSt5X0JiYyrgBnE4mj16/k5UeNuH2R9D2pFSZ+weUtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIs3AVAWzGmxrQath3f9vSd2TaihcGK3pGeId//oGP8=;
 b=deUniV2yN6tMXPGAFMaKDwS+besHKYrtHtdVapYZ2pnMGxn+NfmKijWZ6rB48qL8CSIM44wIryBnpWoAWqpBs3/+O2sqym0+x302y0rozFRVeKzrW7+PSsBytWnQ+/IwcpvicxWm3sqtLS0CZM9JGMAqdCrx+6nXlwReD8SYGYLS9EAVZpli3DZWAgBxio2dJXZqq1IZDf/JXphKHFoeM4L8rZvzZq06zEoIjmLcAdPoEltVOMaIyHBta4NudcOcgn3PX4XiuF4xnbVEwUk7wTgMqMbjJj+XIMuz9BE8HrU2yP8me3OQc9Sj3pmfFXkiw6mDErm/nfA2Rmo6NfQxkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIs3AVAWzGmxrQath3f9vSd2TaihcGK3pGeId//oGP8=;
 b=VoYmOR+jnoN/LyWyPSw8RKieLDX4OE1R8p+zYT5tf5OuIhvLviGeW3FLt2GRkTkHF3kXpm9JmIRwWK2juCNKMFJYBFmhAIhdFdxfJAlwfnsplTJw/Yjp7iZ6NGCGdWlnXHrrmsWkbz08gSDYj0cyDWHemDPy5rDhQsErf+7sQ+0=
Received: from CH2PR04CA0009.namprd04.prod.outlook.com (2603:10b6:610:52::19)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 10:46:43 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::6e) by CH2PR04CA0009.outlook.office365.com
 (2603:10b6:610:52::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 10:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 10:46:42 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 05:46:41 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu/ras: Add address sanity check for uniras
Date: Wed, 10 Jun 2026 18:46:32 +0800
Message-ID: <20260610104632.615416-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: ef175e35-054c-434a-eef0-08dec6dd8f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: F3ADPbUKPU0rNWcFXkxNzXI6SRM4ATpTIzX2sO+vCaLqnzqk/AeGMUVPTVOwoltM1cuAqtHGRnuw7Ah3ZkKIFDG87+zHnnwcarbeq0ph9iMO0vC7lj4MSBMQijSCfCMeZPQAIjVpK8iz9NUx+FaWMG3XFBnDFcgobddkciTgWbwnf4uEF7At1kuDb7l/W6toeQ2KJzDD9ucN4sFvBIavhezn6ULVVU1SApBuiz86u1wNF+8DlO3LntpcSqCBbW4XbfEeu+MifeyDj5Q8PRR55kwJrIt2BYqblajfT5g1krMFjR+7AtUBvTG8zLkwemuZjifkHWCN8nPGxm0Pw68/PctcVnycJgXWVJdClCrshO6Zy50uzFTSAPKEtO6DsOg1/Dja47A8RcJ2gMae2R0VAE1IjTMYuhaYrOd56fAwr/gsPSWQUxbiHm9rkoKod50uU6uWu5D7pA/ePRau7m4jFv7gm9JGdQAQa+bwRNXkr8ObM2tSfWzhNUBO1FJJrho1yHm17lph7A/5myiJhxfh6imXv5eqd9M22h+tuBCJVuqeqEqcwG91akQFwHwtcV6JAUCVIQR0ZrYJnA2bapecN2g3AnTVqH8WDcBBh4OnNs94rDAhSPgeFDc4sOhyu3kwgZSRfGXFCktQu+DnR5bQx1gr5hkM0tJWTSFs735vHTYFCLdfL7lMw1Pgb4swkfTw3vGp68HP0nszxiJgrXblyGSle881J1a69qy7viD3tn8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F+R5pkApXxbV9q2TuGVn7xcOORQ2Mg/BYEBln3HJVq9ZKPuHKDFxKSY3i8c5so0w0ztDCQQ3y/NyArM10gPAY0+BzLfI2BcwyqIjaxnU5vUPb02IkiwWY/O6NPJ1nQw44GevkJtH3n5c+lfKdEGuHuwI1Cgie4cBOwfR/+UOFcUL6W7H024L1EPfOzZTJd7gStoE+wWfsZ9WZMlyGzpZ3UblFWYfXIc3QbMAovI5W29dsX6yaPxUijj5mLjtNjywwFwc68ijWztv/z5npivp70HxuRozgHDLEuVvupt7hlWX+/WjQNGP5qbc5z5Q5e4XJgIkA7+ZDITh8zj+vus89BJdQ5UBQQ9vjlKs1c2/F0ItWZJFCDIQDn5kPtz6Ri8ZdCaqj3l3AKHE/fZGVweMotf6LdOtbe5N4UzOpYFyp7hmtJTg5iRuGZ2LDeNTBsLV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 10:46:42.8969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef175e35-054c-434a-eef0-08dec6dd8f6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495
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
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  | 18 +++++++++++++
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     |  3 +++
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  2 ++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    | 10 ++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 25 +++++++++++++++++--
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h     |  1 +
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   |  9 +++++--
 8 files changed, 64 insertions(+), 7 deletions(-)

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
index 6449d7b8627d..44ddb7943a48 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -231,6 +231,7 @@ struct ras_sys_func {
 		enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
 	int (*put_gpu_mem)(struct ras_core_context *ras_core,
 		enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
+	int (*check_address_sanity)(struct ras_core_context *ras_core, uint64_t addr);
 };
 
 struct ras_ecc_count {
@@ -399,4 +400,5 @@ int ras_core_get_device_system_info(struct ras_core_context *ras_core,
 		struct device_system_info *dev_info);
 int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras_core_context *ras_core,
 		uint64_t soc_pa, uint64_t *page_pfn, uint32_t max_pages);
+int ras_core_check_address_sanity(struct ras_core_context *ras_core, uint64_t addr);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 29b1b8f0cc26..cfab7a7d2623 100644
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
index d4072350f48f..0d4405a975b5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -480,6 +480,27 @@ int ras_umc_load_bad_pages(struct ras_core_context *ras_core)
 	return ret;
 }
 
+static int __calc_bad_page_count(struct ras_core_context *ras_core,
+		struct eeprom_umc_record *record, const u32 num)
+{
+	uint64_t *pfns;
+	uint32_t pfns_sz = ras_core->ras_umc.retire_unit;
+	int i, ret, count = 0;
+
+	pfns = kcalloc(pfns_sz, sizeof(*pfns), GFP_KERNEL);
+	if (!pfns)
+		return pfns_sz;
+
+	for (i = 0; i < num; i++) {
+		ret = ras_core_convert_soc_pa_to_cur_nps_pages(ras_core,
+			RAS_PFN_TO_ADDR(record[i].retired_row_pfn), pfns, pfns_sz);
+		count  += (ret <= 0) ? pfns_sz : ret;
+	}
+
+	kfree(pfns);
+	return count;
+}
+
 /*
  * write error record array to eeprom, the function should be
  * protected by recovery_lock
@@ -515,8 +536,8 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 			ret = -EIO;
 			goto exit;
 		}
-
-		RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table.\n", save_count);
+		RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table.\n",
+			__calc_bad_page_count(ras_core, &data->bps[eeprom_record_num], save_count));
 	}
 
 exit:
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
index 1d3026be509b..05edacc165ba 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -139,6 +139,7 @@ struct ras_umc {
 	struct mutex  pending_ecc_lock;
 	struct ras_umc_err_data umc_err_data;
 	struct list_head pending_ecc_list;
+	u32 retire_unit;
 };
 
 int ras_umc_sw_init(struct ras_core_context *ras);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index b809a2f21d73..fe5f92eb94a1 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -26,6 +26,8 @@
 #include "ras_core_status.h"
 #include "ras_umc_v12_0.h"
 
+#define RAS_UMC_V12_0_ADDR_LIMIT       (0x1ULL << 52)
+
 #define NumDieInterleaved 4
 
 static const uint32_t umc_v12_0_channel_idx_tbl[]
@@ -110,6 +112,7 @@ static void __get_nps_pa_flip_bits(struct ras_core_context *ras_core,
 			"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
 		break;
 	}
+	ras_core->ras_umc.retire_unit = 0x1 << flip_bits->bit_num;
 }
 
 static uint64_t  convert_nps_pa_to_row_pa(struct ras_core_context *ras_core,
@@ -166,7 +169,7 @@ static int lookup_bad_pages_in_a_row(struct ras_core_context *ras_core,
 
 	idx = 0;
 	row = 0;
-	retire_unit = 0x1 << flip_bits.bit_num;
+	retire_unit = ras_core->ras_umc.retire_unit;
 	/* loop for all possibilities of retire bits */
 	for (column = 0; column < retire_unit; column++) {
 		soc_pa = row_pa;
@@ -186,7 +189,9 @@ static int lookup_bad_pages_in_a_row(struct ras_core_context *ras_core,
 				record->cur_nps_bank, record->mem_channel);
 
 
-		if (pfns && (idx < num))
+		if (pfns && (idx < num) &&
+		   (soc_pa < RAS_UMC_V12_0_ADDR_LIMIT) &&
+		   !ras_core_check_address_sanity(ras_core, soc_pa))
 			pfns[idx++] = RAS_ADDR_TO_PFN(soc_pa);
 	}
 
-- 
2.34.1

