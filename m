Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8EBC5DF76
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D666310F716;
	Fri, 14 Aug 2026 21:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kob9xsgC";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A67510F6FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/lD3v6lcHQdkPGxVrvujucsHTexZw3Padt+s6BniElSj89qTdvarOLencZ9vbkoyPC0MzhPffoUPXg66n52FX+mFckAyDPWnkYbE5IfywUqhEpjwU8jexMS9ueDS+t8IECf8eXFECfEq8930TZXWaSWkZL0CX1ZvofFNjUz+Oe/ASHGTTtuO3PNchZPWC8ZisP+LE/4vidiPB0+JvfDxY7PYRmqsS9mna29hOWNJ3tVSHxhW4bi/BI2QyLAQ7mpPDLkhZkftRhhubTTSHb73Uz6ITlG9NWo4bQ6zwXXmNC1cbFNTvDrS0199+GBrBNgLjsfIDVHTs30JsbwQW9YlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPtF1JEzygVGgkj6Hbm5Vq2fUwv8DmtiTQ6T8TwPbi8=;
 b=KXpYw++Of8s5BYsBgILC3S1yUTSzbwzovS+vdxg8+5NaG53RDzkSCvJTpWO67ipHhW/2IB7atNNyuUtebLKnoL97rMDzh+xUao0ei7+iH8UIhUUJxcZIjLymAwjZkaMrchnds09QaNUFEdgvYYHy8jFrhccmd5M3nyI9Fn3U0ueG+iqPDOgRCVd4j9OKJD8N/XYodZ+ZjZBAmHZ4BiFEinEy/mp0XKFWx3uslDvohRaPTaO33g2Dv0NbS3Dw0uYNI6qtM/UW5hccQvAB6W3GBP419BG4lY6csttvqyPxskj+qCm0L8+kLctY5h1ZR6SCgcm5ZHwtI0xmPDavsurvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPtF1JEzygVGgkj6Hbm5Vq2fUwv8DmtiTQ6T8TwPbi8=;
 b=kob9xsgCB3P4Gb35gg6maXE+qDTauLTkf6WnDYgl+KLqsH2B7QXLlxPYdgg5X0IqSlUNhGZNQX3tQyPfXAuagR6JqPaelPY48CUbGncW7fCHHxiLirWHA0MFNLg2NKCUaVJVTiAZCU78MgKvDHLCFCWTbTOyuLPDw/m39h4KLZ4=
Received: from CH2PR04CA0021.namprd04.prod.outlook.com (2603:10b6:610:52::31)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:37 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:52:cafe::9a) by CH2PR04CA0021.outlook.office365.com
 (2603:10b6:610:52::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:32 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Jinzhou Su <jinzhou.su@amd.com>, "Hawking
 Zhang" <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 057/109] drm/amdgpu/ras: prepare ras_psp for ras_mgr-owned TA
 reload
Date: Fri, 14 Aug 2026 17:01:54 -0400
Message-ID: <20260814210246.3067612-58-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: ce721b9b-d7f8-4bc0-bdcf-08defa4782d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|3023799007|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: bHP9AJzOXUHcfDT2m7xIZl8uSuuLv42KBIMWTTvO/qVZcIcIL5jS06Te+LBPlo35+CP6K+gb2A1IRMcy+pafiXhEVYOavnxjQpd51K4Qs117mvQ1pOYuax81LH2DK/XEw5HSIK8lFTuTC5rDdntN5Wk//+ju/Io0se2LW9PGDKDD4543UC8P9pNO/0hg53k7S6k8rjkyWX8ygkptABGfMex6i5as7cPXv3NgAhR8mudL8bkRm/f8Dp0vxFIZpiIuZ1S+Ib2UeF8nhRM5oUp9WDK+QPBjYVLKIOQKMbIA5TsIbDjuJn3up3pDjJpwh8Ei4FfwARkGLOKGiRiN31A8DBYVL/7oBR42neiJFVpWxrLJiJekTMr1SPu570BIi90VR0FFHbV92YxU1qbQxm0NJ6KnzskJVd3VCuxg5rNPUeSWC0OWsBEOacCasV+lrTozb/Sj+2f5Q12GOFEwBbv4S8jaS2oKTHzHEk+XnKyhaFeyZHQZFXTlJDzXmoHZE22RD7e5Kwh6FNbAruKUIcf4XnN5H+hmI3Worh6ALhKsTnH9cmcWxgJ0mcSPEEl6xe71yai7UElQtkc4u7jqs9jpBya6SD1uP7+WvwlgmZfT0tnzQVaXM+9zJ9H3YyVBctVEt4cnFtlWEc/NgA2bUTu7IyMR6jP5amDomAwA4I8ymjI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j7Xoh+rsiRuwpeRCWsoa9upAjg5gfU9gtFUzEBUdBcoWgU8wLjvJxHe+FES6yENAf0N9if+MU0OX1GhiQRqVvx1Y9YoTtPhvP/GaGpxjOc4UMZIUev3Wwy0iwZytDssn6pLedg16T8ZOPPXHcL3hPhB6pqFgYvsmZ+ClIqPuhjECoBXh4esijt2aejfFQYv68gezhnfEEMndFE2MTaQrFNr0JalUtrl9ZadN0rHnQho5myIPea87a04ImtTW80Dd/Cbu+2N4IdtVzsovzpRqOwAuUYPpV5yobjrgpmNLaCnvipCFhO3u8A0aA4TcvfhETn746JkAzvI0i8URVd7oqorWJxGgT47zlG/a1Jpfva0cqsI63Kv5Z6EtCLNaKDoq0pWcF4HI9BtkDq4AK0Ab6gTAYQzw+Dd9O+oVCH/oJceUlq/ivsqU/FcvcIK69fDC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:37.7679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce721b9b-d7f8-4bc0-bdcf-08defa4782d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
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

From: Xiang Liu <xiang.liu@amd.com>

Stop deriving RAS TA session state from the legacy PSP status query and
switch ras_psp over to locally tracked TA lifetime. Delegate TA init
parameters and fini cleanup through ras_psp sys callbacks, update the
load and unload flow to keep firmware metadata in rascore, and add a
skip_lock load path that can be used after PSP reinitialization.

This prepares ras_psp for a later ras_mgr resume hook that reloads the
TA without relying on legacy PSP-managed session ownership.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras.h            |   1 +
 drivers/gpu/drm/amd/ras/core/ras_psp.c        | 149 ++++++++++--------
 drivers/gpu/drm/amd/ras/core/ras_psp.h        |  15 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |   3 -
 4 files changed, 89 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 4cee407c36595..3faf16c850da3 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -269,6 +269,7 @@ struct ras_psp_sys_func {
 		struct ras_psp_sys_status *status);
 	int (*get_ras_ta_init_param)(struct ras_core_context *ras_core,
 		struct ras_ta_init_param *ras_ta_param);
+	void (*put_ras_ta_fini_param)(struct ras_core_context *ras_core);
 };
 
 struct ras_sys_func {
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index 30d22c51758a3..b7af0f2dd6ac6 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -55,7 +55,6 @@ static const struct ras_psp_ip_func *ras_psp_get_ip_funcs(
 static int ras_psp_sync_system_ras_psp_status(struct ras_core_context *ras_core)
 {
 	struct ras_psp *psp = &ras_core->ras_psp;
-	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
 	struct ras_psp_ctx *psp_ctx = &ras_core->ras_psp.psp_ctx;
 	struct ras_psp_sys_status status = {0};
 	int ret;
@@ -65,12 +64,6 @@ static int ras_psp_sync_system_ras_psp_status(struct ras_core_context *ras_core)
 		if (ret)
 			return ret;
 
-		if (status.initialized) {
-			ta_ctx->preload_ras_ta_enabled = true;
-			ta_ctx->ras_ta_initialized = status.initialized;
-			ta_ctx->session_id = status.session_id;
-		}
-
 		psp_ctx->external_mutex = status.psp_cmd_mutex;
 	}
 
@@ -81,22 +74,20 @@ static int ras_psp_get_ras_ta_init_param(struct ras_core_context *ras_core,
 	struct ras_ta_init_param *ras_ta_param)
 {
 	struct ras_psp *psp = &ras_core->ras_psp;
-	int ret;
 
-	if (!psp->sys_func || !psp->sys_func->get_ras_ta_init_param) {
-		RAS_DEV_ERR(ras_core->dev, "Not config get_ras_ta_init_param API!!\n");
-		return -EINVAL;
-	}
+	if (psp->sys_func && psp->sys_func->get_ras_ta_init_param)
+		return psp->sys_func->get_ras_ta_init_param(ras_core, ras_ta_param);
 
-	ret = psp->sys_func->get_ras_ta_init_param(ras_core, ras_ta_param);
-	if (ret)
-		return ret;
+	RAS_DEV_ERR(ras_core->dev, "Not config get_ras_ta_init_param API!!\n");
+	return -EACCES;
+}
 
-	ras_ta_param->nps_mode = ras_core_get_curr_nps_mode(ras_core);
-	ras_ta_param->vram_type = ras_core_get_vram_type(ras_core);
-	ras_ta_param->poison_mode_en = ras_core_poison_supported(ras_core) ? 1 : 0;
+static void ras_psp_put_ras_ta_fini_param(struct ras_core_context *ras_core)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
 
-	return 0;
+	if (psp->sys_func && psp->sys_func->put_ras_ta_fini_param)
+		psp->sys_func->put_ras_ta_fini_param(ras_core);
 }
 
 static struct gpu_mem_block *ras_psp_get_gpu_mem(struct ras_core_context *ras_core,
@@ -384,7 +375,10 @@ static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_core,
 		return -EINVAL;
 	}
 
-	ras_psp_sync_system_ras_psp_status(ras_core);
+	if (!ta_ctx->ras_ta_initialized) {
+		RAS_DEV_ERR(ras_core->dev, "RAS TA is not initialized, cmd_id: %u\n", cmd_id);
+		return -EACCES;
+	}
 
 	cmd_mem = ras_psp_get_gpu_mem(ras_core, GPU_MEM_TYPE_RAS_TA_CMD);
 	if (!cmd_mem)
@@ -479,11 +473,11 @@ static int trigger_ras_ta_error(struct ras_core_context *ras_core,
 }
 
 static int send_load_ta_fw_cmd(struct ras_core_context *ras_core,
-				struct ras_ta_ctx *ta_ctx)
+				struct ras_ta_ctx *ta_ctx, bool skip_lock)
 {
 	struct ras_ta_fw_bin  *fw_bin = &ta_ctx->fw_bin;
-	struct gpu_mem_block *fw_mem;
-	struct gpu_mem_block *cmd_mem;
+	struct gpu_mem_block *fw_mem = NULL;
+	struct gpu_mem_block *cmd_mem = NULL;
 	struct ras_ta_cmd *ta_cmd;
 	struct ras_ta_init_flags *ta_init_flags;
 	struct psp_gfx_cmd_load_ta  psp_load_ta_cmd;
@@ -491,6 +485,10 @@ static int send_load_ta_fw_cmd(struct ras_core_context *ras_core,
 	struct ras_ta_image_header *fw_hdr = NULL;
 	int ret;
 
+	ret = ras_psp_get_ras_ta_init_param(ras_core, &ta_ctx->init_param);
+	if (ret)
+		goto err;
+
 	fw_mem = ras_psp_get_gpu_mem(ras_core, GPU_MEM_TYPE_RAS_TA_FW);
 	if (!fw_mem)
 		return -ENOMEM;
@@ -501,11 +499,12 @@ static int send_load_ta_fw_cmd(struct ras_core_context *ras_core,
 		goto err;
 	}
 
-	ret = ras_psp_get_ras_ta_init_param(ras_core, &ta_ctx->init_param);
-	if (ret)
-		goto err;
-
-	if (!ras_core_down_trylock_gpu_reset_lock(ras_core)) {
+	/*
+	 * When skip_lock is true (called from .resume), the PSP has already
+	 * been re-initialized and it is safe to proceed without the read lock
+	 * (GPU reset holds write lock; S3/S4 has no lock to acquire).
+	 */
+	if (!skip_lock && !ras_core_down_trylock_gpu_reset_lock(ras_core)) {
 		ret = -EACCES;
 		goto err;
 	}
@@ -552,7 +551,8 @@ static int send_load_ta_fw_cmd(struct ras_core_context *ras_core,
 			"Failed to load RAS TA! ret:%d, status:%d\n", ret, resp.status);
 	}
 
-	ras_core_up_gpu_reset_lock(ras_core);
+	if (!skip_lock)
+		ras_core_up_gpu_reset_lock(ras_core);
 
 err:
 	ras_psp_put_gpu_mem(ras_core, fw_mem);
@@ -560,24 +560,12 @@ static int send_load_ta_fw_cmd(struct ras_core_context *ras_core,
 	return ret;
 }
 
-static int load_ras_ta_firmware(struct ras_core_context *ras_core,
-		struct ras_psp_ta_load *ras_ta_load)
+static int load_ras_ta_firmware(struct ras_core_context *ras_core, bool skip_lock)
 {
 	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
-	struct ras_ta_fw_bin  *fw_bin = &ta_ctx->fw_bin;
 	int ret;
 
-	fw_bin->bin_addr = ras_ta_load->bin_addr;
-	fw_bin->bin_size = ras_ta_load->bin_size;
-	fw_bin->fw_version = ras_ta_load->fw_version;
-	fw_bin->feature_version = ras_ta_load->feature_version;
-
-	ret = send_load_ta_fw_cmd(ras_core, ta_ctx);
-	if (!ret) {
-		ras_ta_load->out_session_id = ta_ctx->session_id;
-		ras_ta_load->out_loaded_ta_version = ta_ctx->ta_version;
-	}
-
+	ret = send_load_ta_fw_cmd(ras_core, ta_ctx, skip_lock);
 	return ret;
 }
 
@@ -602,12 +590,13 @@ static int unload_ras_ta_firmware(struct ras_core_context *ras_core,
 		goto unlock;
 	}
 
-	kfree(ta_ctx->fw_bin.bin_addr);
-	memset(&ta_ctx->fw_bin, 0, sizeof(ta_ctx->fw_bin));
+	RAS_DEV_INFO(ras_core->dev,
+		     "Successfully to unload RAS TA! ret:%d, status:%u\n",
+			ret, resp.status);
+
 	ta_ctx->ta_version = 0;
 	ta_ctx->ras_ta_initialized = false;
 	ta_ctx->session_id = 0;
-
 unlock:
 	ras_core_up_gpu_reset_lock(ras_core);
 
@@ -615,26 +604,42 @@ static int unload_ras_ta_firmware(struct ras_core_context *ras_core,
 }
 
 int ras_psp_load_firmware(struct ras_core_context *ras_core,
-	struct ras_psp_ta_load *ras_ta_load)
+		bool skip_lock)
 {
 	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
 	struct ras_psp_ta_unload ras_ta_unload = {0};
-	int ret;
-
-	if (ta_ctx->preload_ras_ta_enabled)
-		return 0;
+	int ret = 0;
 
-	if (!ras_ta_load)
-		return -EINVAL;
+	if (skip_lock) {
+		/*
+		 * Called from .resume: PSP has been re-initialized after a GPU
+		 * reset or S3/S4, so any previous TA session is gone. Clear
+		 * stale state and proceed directly to a fresh load, bypassing
+		 * both the unload step and the reset read-lock acquisition
+		 * (which would deadlock inside a GPU reset).
+		 */
+		ta_ctx->preload_ras_ta_enabled = false;
+		ta_ctx->ras_ta_initialized = false;
+		ta_ctx->session_id = 0;
+		ta_ctx->ta_version = 0;
+	} else {
+		/*
+		 * Normal path: only skip a reload when the current TA session is
+		 * known to be alive. Firmware metadata may already be cached even
+		 * when the TA is not loaded, so that must not suppress a reload.
+		 */
+		if (ta_ctx->preload_ras_ta_enabled && ta_ctx->ras_ta_initialized)
+			return 0;
 
-	if (ta_ctx->ras_ta_initialized) {
-		ras_ta_unload.ras_session_id = ta_ctx->session_id;
-		ret = unload_ras_ta_firmware(ras_core, &ras_ta_unload);
-		if (ret)
-			return ret;
+		if (ta_ctx->ras_ta_initialized) {
+			ras_ta_unload.ras_session_id = ta_ctx->session_id;
+			ret = unload_ras_ta_firmware(ras_core, &ras_ta_unload);
+			if (ret)
+				return ret;
+		}
 	}
 
-	return load_ras_ta_firmware(ras_core, ras_ta_load);
+	return load_ras_ta_firmware(ras_core, skip_lock);
 }
 
 int ras_psp_unload_firmware(struct ras_core_context *ras_core,
@@ -642,9 +647,6 @@ int ras_psp_unload_firmware(struct ras_core_context *ras_core,
 {
 	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
 
-	if (ta_ctx->preload_ras_ta_enabled)
-		return 0;
-
 	if ((!ras_ta_unload) ||
 	    (ras_ta_unload->ras_session_id != ta_ctx->session_id))
 		return -EINVAL;
@@ -719,7 +721,9 @@ int ras_psp_sw_fini(struct ras_core_context *ras_core)
 
 int ras_psp_hw_init(struct ras_core_context *ras_core)
 {
+	int ret = 0;
 	struct ras_psp *psp = &ras_core->ras_psp;
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
 
 	psp->psp_ip_version = ras_core->config->psp_ip_version;
 
@@ -741,11 +745,30 @@ int ras_psp_hw_init(struct ras_core_context *ras_core)
 	 */
 	ras_psp_sync_system_ras_psp_status(ras_core);
 
-	return 0;
+	if (!ta_ctx->preload_ras_ta_enabled && !ta_ctx->ras_ta_initialized)
+		ret = ras_psp_load_firmware(ras_core, false);
+
+	return ret;
 }
 
 int ras_psp_hw_fini(struct ras_core_context *ras_core)
 {
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+	struct ras_psp_ta_unload ras_ta_unload = {0};
+
+	if (ta_ctx->ras_ta_initialized) {
+		ras_ta_unload.ras_session_id = ta_ctx->session_id;
+		ras_psp_unload_firmware(ras_core, &ras_ta_unload);
+	}
+
+	ta_ctx->ta_version = 0;
+	ta_ctx->ras_ta_initialized = false;
+	ta_ctx->preload_ras_ta_enabled = false;
+	ta_ctx->session_id = 0;
+
+	/* Free shared BO only on hw_fini, not on suspend */
+	ras_psp_put_ras_ta_fini_param(ras_core);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.h b/drivers/gpu/drm/amd/ras/core/ras_psp.h
index f1d32f31a64ee..cb564b532ac9e 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.h
@@ -41,8 +41,6 @@ struct ras_ta_image_header {
 };
 
 struct ras_psp_sys_status {
-	bool  initialized;
-	uint32_t session_id;
 	void *psp_cmd_mutex;
 };
 
@@ -146,15 +144,6 @@ struct ras_psp {
 	const struct ras_psp_sys_func *sys_func;
 };
 
-struct ras_psp_ta_load {
-	uint32_t fw_version;
-	uint32_t feature_version;
-	uint32_t bin_size;
-	uint8_t *bin_addr;
-	uint64_t out_session_id;
-	uint32_t out_loaded_ta_version;
-};
-
 struct ras_psp_ta_unload {
 	uint64_t ras_session_id;
 };
@@ -163,8 +152,8 @@ int ras_psp_sw_init(struct ras_core_context *ras_core);
 int ras_psp_sw_fini(struct ras_core_context *ras_core);
 int ras_psp_hw_init(struct ras_core_context *ras_core);
 int ras_psp_hw_fini(struct ras_core_context *ras_core);
-int ras_psp_load_firmware(struct ras_core_context *ras_core,
-		struct ras_psp_ta_load *ras_ta_load);
+
+int ras_psp_load_firmware(struct ras_core_context *ras_core, bool skip_lock);
 int ras_psp_unload_firmware(struct ras_core_context *ras_core,
 		struct ras_psp_ta_unload *ras_ta_unload);
 int ras_psp_trigger_error(struct ras_core_context *ras_core,
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 525abb7e05474..29558888832c1 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -188,10 +188,7 @@ static int amdgpu_ras_mgr_get_ras_psp_system_status(struct ras_core_context *ras
 			struct ras_psp_sys_status *status)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
-	struct ta_context *context = &adev->psp.ras_context.context;
 
-	status->initialized = context->initialized;
-	status->session_id = context->session_id;
 	status->psp_cmd_mutex = &adev->psp.mutex;
 
 	return 0;
-- 
2.55.0

