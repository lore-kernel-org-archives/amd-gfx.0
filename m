Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CC5C5DF6A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC6310F708;
	Fri, 14 Aug 2026 21:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q0n6Msup";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D03AE10F6FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLi57NaFKxpV8K2G6jGKfCJeM1rP4z4jDtspRiC4GzZPbBFJGMvpv8gGHCEdJmL/wU8m8nvMC8lALdUWD7cwHEJI5/yMiDl3xo9w2OhfSWdT/Vl4+Tiw0PuBemUM/GD5/FbPcxbDJD1pkMRn0+C249uicPahTyV8Fpd+i0pTy8d4jvPB9E0c6QTmz4pNWEVnrCD2svwdzbDUQ5yaolT8JgO23jgpzbUxauRAAGbLlFSl3SAB5Wk6OrT2h0wQicMmJ3FGwoNFHbLQkFgqwSvSV/Kc0plD7t/HCC1jTb2zbduyOBlzWyhBUn3Sk3Zx1Vyhem8BuUxQ1tRGlhLakWv79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WxkpjyGUZl0gBv3Qa3LHQ6zBbc5Fcmyr2ftWJO8s9Y=;
 b=JKm5UJxh+SszNODlb0zMvVb57v9MoSQPpm3VLx7/qKU9+sErz5jqVebTcHuLWLIH77diEIutUHU+zjdjdWWTi5YgtSv8JRVUh+ynvMmhTAVfzH9cJ3F+kkBEtMbgiPH22VGS6Qvpt+RpCFsua9LwKOFh24WuptoaLuv2/Uy3touYNDX88Uv762Zf2F2/NBNWzzc6+fTrrXb8O95yvo0CP4+U/0plJ3bgpQ2GBqzG2y1DZgVc8ZHaJ2xk6yJHB/thWl0dzpF3BUgKbVya9aJ9OxLIZVjWGIwR7cFYBkhyKU9Ndt2+zCCm/X6YwbneEZz/b+64TweGwnn/PtJo9hL7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WxkpjyGUZl0gBv3Qa3LHQ6zBbc5Fcmyr2ftWJO8s9Y=;
 b=q0n6MsupIqlZnZzMBBbs/69OW+UEbWxo5OCw1AbHi/OFW3QyFyA6+u7GJZ5IFjF0DFAbTwMKrrW2BwjI1d8MfexBwAtTX50QBKayktnEfw5/exk1uUzYujOwDDiVxVS28O/OGTMrcgFFMiPmnFTzgyv3cuLBhy4o4lab3gZHDRI=
Received: from CH0PR03CA0357.namprd03.prod.outlook.com (2603:10b6:610:11a::6)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:26 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:11a:cafe::3b) by CH0PR03CA0357.outlook.office365.com
 (2603:10b6:610:11a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:19 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 037/109] drm/amd/ras: add interface to query nps mode and vram
 type
Date: Fri, 14 Aug 2026 17:01:34 -0400
Message-ID: <20260814210246.3067612-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f74517-dcdf-43ad-a8ee-08defa477c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: sRq9YHu6lrV63qDNguDwZJvJrt+36ha801hc1ZlaIRB98LjB4dIPC00x9jTObtI6zsYRy2/PJy6ddKa2p8amGTbtcT+e2g9Gb1gTCgWBub8KqM2Pt9ys11G3wxCiJEe8oQyKXKFXvqIBi5SG2OY6D4GSvV3FdHTt4XwcMM58LcwHRECw594zwuKrnTFgCtLUYaDFWI4hAlEOVKxL1Nh31qKe3rmePnV9Eb9i+fSXsxvbUWH52eH7xe+RoBkQnk1or1DQillptCAUPn/ItC9UhlRD3OpPJstLyTWB54l8gKjTY2cSm0gcx2A+bXVWcLV8ToSoWSlrrH4V97p0dQsKaP2IX8oXmInRkWJymNruRK6pbyPwJEP5wSF1RL2wm++IcebxqH0i1EIuAeyxZys8YdKMresppz9kesQNFOLAfZvavpQbZl8L8tPTzBfs8q6SdJoqtK6vC52wVDh7HW3TUb0EPqbbMibBaUFAz4mIN20NubBGmfYlsU66IL7OLFYndWpQ+eeria/kG3zHWzfiZt0IM4UnAaorviWkFRPd/3vIWY8gulKlvjvUi2gbaihiyTVkE6oObIQyaYM+rV9e+mZCzgH5XLFte/yvbnWMU9+FsEyEGDq5TS/YiEROMIlN6HRK4kVrUKbY9W3iJ9g34xj665QVFcOUposGGv402kU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FBasBBBzhwzsFNnvFZ6VVL+e3WOagLTztrd8rf1bs6oR8kMESaFNAVFYQOMX0t8mZZeeaP1co3jwip+gibaGBgTY6XcbcevKif+6MurKN7PCqXJprQRNHfrcQ4n9Z6N1kL87Xzqc3X38hrqDrIDzh9pBYjR5D6OQQ4qqpyMIM3yi2P1buQibYH8XccrUrsnL1rNbfLSKVv5HjMizOQ94joUIlqDtraPPtvtfcW5tzubpOkgI5gmOdmbnQ+xC8w5x4d8lHVU62n3vqNtyXwoqdDETicxYzwK0ghEaVjxAxPg/Wp9jJVWFomFpQTQ+sPs1DPgfsivHEFFn3ukR+ByEbR43ZVnqe27w4JA+OrYeVaK94a10EFePgSL83JnXB0jk97Fd7YTfdgVJ+WYBKHdPGrxD1S7VGhnTYlmZSKcjCdzRHpfT7G3xkCHxmjvUQgFt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:26.5522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f74517-dcdf-43ad-a8ee-08defa477c28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058
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

Add interface to query nps mode and vram type.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/core.c           | 40 ++++++++++++++++---
 drivers/gpu/drm/amd/ras/core/ras.h            |  4 +-
 drivers/gpu/drm/amd/ras/core/ras_psp.c        | 18 +++++++--
 drivers/gpu/drm/amd/ras/core/ras_umc.c        | 19 +--------
 drivers/gpu/drm/amd/ras/core/ras_umc.h        |  2 -
 drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c  |  2 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  9 -----
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  | 16 ++++++++
 8 files changed, 69 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index 079032433a916..0815dea06f384 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -519,14 +519,42 @@ int ras_core_handle_fatal_error(struct ras_core_context *ras_core)
 
 uint32_t ras_core_get_curr_nps_mode(struct ras_core_context *ras_core)
 {
-	if (!ras_core)
-		return 0;
+	int ret;
+
+	if (!ras_core->sys_fn || !ras_core->sys_fn->get_nps_mode) {
+		RAS_DEV_ERR(ras_core->dev, "Cannot get memory nps mode!\n");
+		return UMC_MEMORY_PARTITION_MODE_UNKNOWN;
+	}
 
-	if (ras_core->ras_nbio.ip_func &&
-	    ras_core->ras_nbio.ip_func->get_memory_partition_mode)
-		return ras_core->ras_nbio.ip_func->get_memory_partition_mode(ras_core);
+	ret = ras_core->sys_fn->get_nps_mode(ras_core);
+	if (ret < 0) {
+		RAS_DEV_ERR(ras_core->dev, "Failed to get memory nps mode!\n");
+		return UMC_MEMORY_PARTITION_MODE_UNKNOWN;
+	} else if (!ret) {
+		RAS_DEV_WARN(ras_core->dev, "None nps mode!\n");
+	}
+
+	return ret;
+}
 
-	return UMC_MEMORY_PARTITION_MODE_UNKNOWN;
+uint32_t ras_core_get_vram_type(struct ras_core_context *ras_core)
+{
+	int ret;
+
+	if (!ras_core->sys_fn || !ras_core->sys_fn->get_vram_type) {
+		RAS_DEV_ERR(ras_core->dev, "Cannot get vram type!\n");
+		return UMC_VRAM_TYPE_UNKNOWN;
+	}
+
+	ret = ras_core->sys_fn->get_vram_type(ras_core);
+	if (ret < 0) {
+		RAS_DEV_ERR(ras_core->dev, "Failed to get vram type!\n");
+		return UMC_VRAM_TYPE_UNKNOWN;
+	} else if (!ret) {
+		RAS_DEV_WARN(ras_core->dev, "None vram type!\n");
+	}
+
+	return ret;
 }
 
 int ras_core_update_ecc_info(struct ras_core_context *ras_core)
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index e28d51b1992ef..47cc934520448 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -269,6 +269,8 @@ struct ras_sys_func {
 	int (*put_gpu_mem)(struct ras_core_context *ras_core,
 		enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem);
 	int (*check_address_sanity)(struct ras_core_context *ras_core, uint64_t addr);
+	int (*get_nps_mode)(struct ras_core_context *ras_core);
+	int (*get_vram_type)(struct ras_core_context *ras_core);
 };
 
 struct ras_ecc_count {
@@ -314,7 +316,6 @@ struct ras_psp_config {
 };
 
 struct ras_umc_config {
-	uint32_t umc_vram_type;
 	uint32_t num_umc;
 };
 
@@ -417,6 +418,7 @@ bool ras_core_handle_nbio_irq(struct ras_core_context *ras_core, void *data);
 int ras_core_handle_fatal_error(struct ras_core_context *ras_core);
 
 uint32_t ras_core_get_curr_nps_mode(struct ras_core_context *ras_core);
+uint32_t ras_core_get_vram_type(struct ras_core_context *ras_core);
 const char *ras_core_get_ras_block_name(enum ras_block_id block_id);
 int ras_core_convert_timestamp_to_time(struct ras_core_context *ras_core,
 			uint64_t timestamp, struct ras_time *tm);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index 4835228993181..30d22c51758a3 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -81,12 +81,22 @@ static int ras_psp_get_ras_ta_init_param(struct ras_core_context *ras_core,
 	struct ras_ta_init_param *ras_ta_param)
 {
 	struct ras_psp *psp = &ras_core->ras_psp;
+	int ret;
 
-	if (psp->sys_func && psp->sys_func->get_ras_ta_init_param)
-		return psp->sys_func->get_ras_ta_init_param(ras_core, ras_ta_param);
+	if (!psp->sys_func || !psp->sys_func->get_ras_ta_init_param) {
+		RAS_DEV_ERR(ras_core->dev, "Not config get_ras_ta_init_param API!!\n");
+		return -EINVAL;
+	}
 
-	RAS_DEV_ERR(ras_core->dev, "Not config get_ras_ta_init_param API!!\n");
-	return -EACCES;
+	ret = psp->sys_func->get_ras_ta_init_param(ras_core, ras_ta_param);
+	if (ret)
+		return ret;
+
+	ras_ta_param->nps_mode = ras_core_get_curr_nps_mode(ras_core);
+	ras_ta_param->vram_type = ras_core_get_vram_type(ras_core);
+	ras_ta_param->poison_mode_en = ras_core_poison_supported(ras_core) ? 1 : 0;
+
+	return 0;
 }
 
 static struct gpu_mem_block *ras_psp_get_gpu_mem(struct ras_core_context *ras_core,
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index fcf65dc5f7146..0237a4f737ec3 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -502,7 +502,7 @@ static bool ras_umc_check_retired_record(struct ras_core_context *ras_core,
 	int i, ret;
 
 	if (from_eeprom) {
-		nps = ras_umc->umc_err_data.umc_nps_mode;
+		nps = ras_core_get_curr_nps_mode(ras_core);
 		ret = ras_umc_eeprom_rec2nps_rec(ras_core, record, nps);
 		if (ret)
 			RAS_DEV_WARN_RATELIMITED(ras_core->dev,
@@ -838,24 +838,7 @@ int ras_umc_sw_fini(struct ras_core_context *ras_core)
 int ras_umc_hw_init(struct ras_core_context *ras_core)
 {
 	struct ras_umc *ras_umc = &ras_core->ras_umc;
-	uint32_t nps;
-
-	nps = ras_core_get_curr_nps_mode(ras_core);
-
-	if (!nps || (nps >= UMC_MEMORY_PARTITION_MODE_UNKNOWN)) {
-		RAS_DEV_ERR(ras_core->dev, "Invalid memory NPS mode: %u!\n", nps);
-		return -ENODATA;
-	}
-
-	ras_umc->umc_err_data.umc_nps_mode = nps;
-
-	ras_umc->umc_vram_type = ras_core->config->umc_cfg.umc_vram_type;
 	ras_umc->num_umc = ras_core->config->umc_cfg.num_umc;
-	if (!ras_umc->umc_vram_type) {
-		RAS_DEV_ERR(ras_core->dev, "Invalid UMC VRAM Type: %u!\n",
-			ras_umc->umc_vram_type);
-		return -ENODATA;
-	}
 
 	ras_umc->umc_ip_version = ras_core->config->umc_ip_version;
 	ras_umc->ip_func = ras_umc_get_ip_func(ras_core, ras_umc->umc_ip_version);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.h b/drivers/gpu/drm/amd/ras/core/ras_umc.h
index af76de70ddd1d..1f257eb3e3df6 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.h
@@ -160,13 +160,11 @@ struct eeprom_store_record {
 struct ras_umc_err_data {
 	struct eeprom_store_record rom_data;
 	struct eeprom_store_record ram_data;
-	enum umc_memory_partition_mode umc_nps_mode;
 	uint64_t last_retired_pfn;
 };
 
 struct ras_umc {
 	u32 umc_ip_version;
-	u32 umc_vram_type;
 	u32 num_umc;
 	const struct ras_umc_ip_func *ip_func;
 	struct radix_tree_root root;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
index ac78c404bed41..63f4e0cf9a415 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
@@ -52,7 +52,7 @@ static void __get_nps_pa_flip_bits(struct ras_core_context *ras_core,
 			enum umc_memory_partition_mode nps,
 			struct umc_flip_bits *flip_bits)
 {
-	uint32_t vram_type = ras_core->ras_umc.umc_vram_type;
+	uint32_t vram_type = ras_core_get_vram_type(ras_core);
 	u32 num_umc = ras_core->ras_umc.num_umc;
 
 	/* default setting */
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 4b9384bc87b38..030edfebd0b78 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -267,10 +267,6 @@ static int amdgpu_ras_mgr_get_ras_ta_init_param(struct ras_core_context *ras_cor
 	struct ras_ta_init_param *ras_ta_param)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
-	uint32_t nps_mode;
-
-	if (ras_core_poison_supported(ras_core))
-		ras_ta_param->poison_mode_en = 1;
 
 	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
 		ras_ta_param->dgpu_mode = 1;
@@ -279,12 +275,8 @@ static int amdgpu_ras_mgr_get_ras_ta_init_param(struct ras_core_context *ras_cor
 	ras_ta_param->channel_dis_num = hweight32(adev->gmc.m_half_use) * 2;
 
 	ras_ta_param->active_umc_mask = lower_32_bits(adev->umc.active_mask);
-	ras_ta_param->vram_type = (uint8_t)adev->gmc.vram_type;
 	ras_ta_param->ext_umc_mask = upper_32_bits(adev->umc.active_mask);
 
-	if (!amdgpu_ras_mgr_get_curr_nps_mode(adev, &nps_mode))
-		ras_ta_param->nps_mode = nps_mode;
-
 	return 0;
 }
 
@@ -308,7 +300,6 @@ static int amdgpu_ras_mgr_init_umc_config(struct amdgpu_device *adev,
 {
 	struct ras_umc_config *umc_cfg = &config->umc_cfg;
 
-	umc_cfg->umc_vram_type = adev->gmc.vram_type;
 	umc_cfg->num_umc = adev->gmc.num_umc;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index c34af5c8e65ad..17703ed0c7f6d 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -292,6 +292,20 @@ static int amdgpu_ras_sys_check_address_sanity(struct ras_core_context *ras_core
 	return 0;
 }
 
+static int amdgpu_ras_sys_get_nps_mode(struct ras_core_context *ras_core)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+
+	return amdgpu_gmc_query_memory_partition(adev);
+}
+
+static int amdgpu_ras_sys_get_vram_type(struct ras_core_context *ras_core)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+
+	return adev->gmc.vram_type;
+}
+
 const struct ras_sys_func amdgpu_ras_sys_fn = {
 	.ras_notifier = amdgpu_ras_sys_event_notifier,
 	.get_utc_second_timestamp = amdgpu_ras_sys_get_utc_second_timestamp,
@@ -303,4 +317,6 @@ const struct ras_sys_func amdgpu_ras_sys_fn = {
 	.get_gpu_mem = amdgpu_ras_sys_get_gpu_mem,
 	.put_gpu_mem = amdgpu_ras_sys_put_gpu_mem,
 	.check_address_sanity = amdgpu_ras_sys_check_address_sanity,
+	.get_nps_mode = amdgpu_ras_sys_get_nps_mode,
+	.get_vram_type = amdgpu_ras_sys_get_vram_type,
 };
-- 
2.55.0

