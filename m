Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE285C5DF72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14CC010F723;
	Fri, 14 Aug 2026 21:03:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kNs2Go4h";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013048.outbound.protection.outlook.com
 [40.107.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5248A10F71B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wosm3ihQUzQ/bUhr21BhOE+weLbmhOEiGEUg3Xqagadd7qK5sNPdInVhI5BZrBM1qb1aUhbRz1DW7W+k2FtbPj85p0bf6uMKeQMbI6nnnd/iCECLxcBFc0y5ce0bzgvvPI6nuV93MU049ePS8+GHrBnEjBDQBSxtZ2EDmgegzL3dhPfsqOmqRVsbNAL6iROaFwwIEGQze8vZbcInzhHUNnj5D7xnVVsJr41OhRTGDc7FRY3OCsNG6g4QHMmPkfyIvN8IOG5FBm6CeRc+wz/PIKKxytWtMOgoUNrVvBlakvxdFNc4Qr1d2kGC4Wga3QDVm/18C/qBfGt4q+BHd8/AOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYqhpuZU6D/ZkBelki2G04yOEkZjmy9UwLugd1wGry8=;
 b=Erb2YTW2CrGG5JKhPUf7M6eU83jxPwWNZoIs4IIJNxGjvX4z87a+Jj4bckz/PPx1lnohYNRqCeICAhRuMWKOxvu4eNxTL1m4PZ3Ssx3BUGNfLf//l5AWG/iy+6q2GhFLoAO1ZwvCOAJ8ye7zA0vozpS45m7ZYRIHG7Gi1KQu9gVPzJvFAKZquwHBLeg781fMWVVGuNmX58ufAc3Xj8vfH26zewRb02t5wnzDC/6vJXaeoE0SXz6IxjDM8u1Rff7k+6dgFdhngJj795K3XuDXTSfPya9mNSXrC/cJgOc5s1mEYYY3KCgSDd/Lpu6vO9IsKgQUNgrwDgSnM1vVkw9ljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYqhpuZU6D/ZkBelki2G04yOEkZjmy9UwLugd1wGry8=;
 b=kNs2Go4heUIRVMM+DADCKwEhr6qdR+YKsX0SXO1DKqg17ZMJ7wRv6ExT3P2+nwGxuggamM3CdwPZ5eeeMrIHfE196UTiJ36IwcgvAB2L1BlUuctoGspG0d06mxaDoEOAMDv9WlDtW0tIX162wFgYReZUDA1VJLsYtfPhHP+F4eA=
Received: from CH0PR04CA0022.namprd04.prod.outlook.com (2603:10b6:610:76::27)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:39 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:76:cafe::35) by CH0PR04CA0022.outlook.office365.com
 (2603:10b6:610:76::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:34 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 060/109] drm/amdgpu/ras: support loading RAS RL and TA
 firmware in RAS module
Date: Fri, 14 Aug 2026 17:01:57 -0400
Message-ID: <20260814210246.3067612-61-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d30e08d-ac04-420f-143c-08defa478359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|18002099003|22082099003|5023799004|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: kWxF41A+ZiKhWa5nIwSF7r2t6AkaLuAFhodOslS6OUKrNGvIoEbdue7Vhe7/7o6idNBXAKRUFLc4kDA4vUkt/31Nn7NcFuyqltQA4oUQIUuYcyXlzIaV0xM8bZ5IQUQyEewxTwB5OBp7MElI3Jo1oIOKl8PQkvW0TFQurcSGhrdZrnBk40MSWA3RpZmxxkDEy9U9wR6UxU1l7avAZsr6rT9qjPJMzxSFJiRKpnNbJGHyqoQH2KcRJsOnRSIu/IdjEI3k91NqArF2TyAfIZbZYqjNJDXwspPvK/tnSZckcg9CPhq54lqmGp7HyGDPraymVQeSp2YRf4am9HEhdtpXAXIu9LIQtsrG7bRO9XOxsfw+rSJUbVvIeVjvocrq2R11RHH1o6nfOjuva5Pe7SzqqQ9zjAHXCLk5MsqIYb6kLDNSUUH7JeEdSFQJT2F52LVGGgWMQoTh66BlhlgaeO92qBIf/R2agTOlg5vspuZIJHABlGMf/bQk+jV/rsQuaWkJh70B/GehQRH5MDyFO9waxsh9mVqFR0oRn38GaFU3kuNRHDCi4DySNqMKJBtengqycQanxF95lN2vqMP5wrp8mBWH/Bprw0hflB1i5vaXxL/muHeH8wVWrBERHCippzrKZLHLj92GSRu9TEcMHba7CQSh8FxSQy8MXXhpQzmln18=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(5023799004)(56012099006)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rpi9z0gtyI1nboga9UgpwT2Muj7pE1iW98hrUSC1pA22lvDotBg9jhREOIuZPtS7mV4qTpARIzoQhOHgA2KrAqFtw0y1gGXwwkCzLoEZxe/7HUWF+hQyTHBhar42L7akqNzw8Hg85FGefRjy6Cq5Ibke7aBvGVxLm192EBy7UIP/EW8RHkYRep7j81Wq0S9L5gK5U/joVpyRt7/c+w7RjG7qmoXcvFdOasQbk6ihnzNHkMR++xnOUKnf+C3y7hH0SeolUSSt6d7DWbQYM3EW4tC2UO+D2VexmMznGg4BCg7Oxo5zabR1XE3Bn0qIgkIrQJYvOKkZjqc4p2S84UG02frBwcloEatT+cIcDmYNdCV4yDH8jYqba/OaoErCwexcrKNfGXhyuQxKDwDOP2a8/gdAyU10zbxTSvOmAmvxe4G+tUfND8NAMg6PNegcw+8l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:38.6147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d30e08d-ac04-420f-143c-08defa478359
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317
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

Allow the RAS module to load RAS RL and TA firmware internally while
maintaining backward compatibility with the system-level firmware
loading path.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras.h            |   7 +-
 drivers/gpu/drm/amd/ras/core/ras_psp.c        | 320 +++++++++++-------
 drivers/gpu/drm/amd/ras/core/ras_psp.h        |  47 ++-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  83 ++---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  |   2 +-
 5 files changed, 265 insertions(+), 194 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 17b1e7820855c..2311d988b3e52 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -260,7 +260,7 @@ enum gpu_mem_type {
 	GPU_MEM_TYPE_RAS_PSP_RING,
 	GPU_MEM_TYPE_RAS_PSP_CMD,
 	GPU_MEM_TYPE_RAS_PSP_FENCE,
-	GPU_MEM_TYPE_RAS_TA_FW,
+	GPU_MEM_TYPE_RAS_FW_BIN,
 	GPU_MEM_TYPE_RAS_TA_CMD,
 	GPU_MEM_TYPE_ALLOC_MEM,
 	GPU_MEM_TYPE_MAX
@@ -269,9 +269,8 @@ enum gpu_mem_type {
 struct ras_psp_sys_func {
 	int (*get_ras_psp_system_status)(struct ras_core_context *ras_core,
 		struct ras_psp_sys_status *status);
-	int (*get_ras_ta_init_param)(struct ras_core_context *ras_core,
-		struct ras_ta_init_param *ras_ta_param);
-	void (*put_ras_ta_fini_param)(struct ras_core_context *ras_core);
+	int (*get_ras_param)(struct ras_core_context *ras_core,
+		struct ras_param *param);
 };
 
 struct ras_sys_func {
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index d3cc992a462a7..36d6021afcf76 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -38,6 +38,7 @@
 #define RAS_PSP_FENCE_SIZE 0x1000
 #define RAS_FW_BIN_SIZE    0x100000
 #define RAS_TA_CMD_SIZE    0x100000
+
 static const struct ras_psp_ip_func *ras_psp_get_ip_funcs(
 			struct ras_core_context *ras_core, uint32_t ip_version)
 {
@@ -57,42 +58,41 @@ static const struct ras_psp_ip_func *ras_psp_get_ip_funcs(
 	return NULL;
 }
 
-static int ras_psp_sync_system_ras_psp_status(struct ras_core_context *ras_core)
+static int ras_psp_get_system_ras_status(struct ras_core_context *ras_core,
+		struct ras_psp_sys_status *status)
 {
 	struct ras_psp *psp = &ras_core->ras_psp;
-	struct ras_psp_ctx *psp_ctx = &ras_core->ras_psp.psp_ctx;
-	struct ras_psp_sys_status status = {0};
 	int ret;
 
 	if (psp->sys_func && psp->sys_func->get_ras_psp_system_status) {
-		ret = psp->sys_func->get_ras_psp_system_status(ras_core, &status);
+		ret = psp->sys_func->get_ras_psp_system_status(ras_core, status);
 		if (ret)
 			return ret;
-
-		psp_ctx->external_mutex = status.psp_cmd_mutex;
 	}
 
 	return 0;
 }
 
-static int ras_psp_get_ras_ta_init_param(struct ras_core_context *ras_core,
-	struct ras_ta_init_param *ras_ta_param)
+static int ras_psp_get_ras_param(struct ras_core_context *ras_core,
+	struct ras_param *param)
 {
 	struct ras_psp *psp = &ras_core->ras_psp;
+	int ret;
 
-	if (psp->sys_func && psp->sys_func->get_ras_ta_init_param)
-		return psp->sys_func->get_ras_ta_init_param(ras_core, ras_ta_param);
+	if (!psp->sys_func || !psp->sys_func->get_ras_param) {
+		RAS_DEV_ERR(ras_core->dev, "Not config get_ras_ta_init_param API!!\n");
+		return -EINVAL;
+	}
 
-	RAS_DEV_ERR(ras_core->dev, "Not config get_ras_ta_init_param API!!\n");
-	return -EACCES;
-}
+	ret = psp->sys_func->get_ras_param(ras_core, param);
+	if (ret)
+		return ret;
 
-static void ras_psp_put_ras_ta_fini_param(struct ras_core_context *ras_core)
-{
-	struct ras_psp *psp = &ras_core->ras_psp;
+	param->ta_param.nps_mode = ras_core_get_curr_nps_mode(ras_core);
+	param->ta_param.vram_type = ras_core_get_vram_type(ras_core);
+	param->ta_param.poison_mode_en = ras_core_poison_supported(ras_core) ? 1 : 0;
 
-	if (psp->sys_func && psp->sys_func->put_ras_ta_fini_param)
-		psp->sys_func->put_ras_ta_fini_param(ras_core);
+	return 0;
 }
 
 static struct gpu_mem_block *ras_psp_alloc_mem(struct ras_core_context *ras_core,
@@ -172,7 +172,7 @@ static int __ras_psp_mem_init(struct ras_core_context *ras_core)
 
 	if (psp->use_dedicated_memory) {
 		fw_bin = ras_psp_alloc_mem(ras_core,
-				GPU_MEM_TYPE_RAS_TA_FW, RAS_FW_BIN_SIZE);
+				GPU_MEM_TYPE_RAS_FW_BIN, RAS_FW_BIN_SIZE);
 		if (!fw_bin)
 			goto err;
 
@@ -434,6 +434,7 @@ static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_core,
 	struct ras_ta_cmd *ras_cmd;
 	struct psp_gfx_cmd_invoke_cmd invoke_cmd = {0};
 	struct psp_cmd_resp resp = {0};
+	int got_reset_lock = 0;
 	int ret = 0;
 
 	if (!in || (in_size > sizeof(union ras_ta_cmd_input)) ||
@@ -451,8 +452,11 @@ static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_core,
 	if (!cmd_mem)
 		return -ENOMEM;
 
-	if (!ras_core_down_trylock_gpu_reset_lock(ras_core))
-		return -EACCES;
+	if (!ras_core_gpu_in_reset(ras_core)) {
+		got_reset_lock = ras_core_down_trylock_gpu_reset_lock(ras_core);
+		if (!got_reset_lock)
+			return  -EACCES;
+	}
 
 	ras_cmd = (struct ras_ta_cmd *)cmd_mem->mem_cpu_addr;
 
@@ -497,7 +501,8 @@ static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_core,
 
 unlock:
 	mutex_unlock(&ta_ctx->ta_mutex);
-	ras_core_up_gpu_reset_lock(ras_core);
+	if (got_reset_lock)
+		ras_core_up_gpu_reset_lock(ras_core);
 	return ret;
 }
 
@@ -535,10 +540,57 @@ static int trigger_ras_ta_error(struct ras_core_context *ras_core,
 				info, sizeof(*info), NULL, 0);
 }
 
-static int send_load_ta_fw_cmd(struct ras_core_context *ras_core,
-				struct ras_ta_ctx *ta_ctx, bool skip_lock)
+static int load_ras_rl_fw(struct ras_core_context *ras_core,
+		struct ras_fw_bin *rl_bin)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+	struct gpu_mem_block *fw_mem;
+	struct psp_gfx_cmd_load_ip_fw psp_load_rl_fw;
+	struct psp_cmd_resp resp = {0};
+	int got_reset_lock = 0;
+	int ret = 0;
+
+	fw_mem = psp->ta_ctx.fw_gpu_mem;
+	if (!fw_mem)
+		return -ENOMEM;
+
+	if (!ras_core_gpu_in_reset(ras_core)) {
+		got_reset_lock = ras_core_down_trylock_gpu_reset_lock(ras_core);
+		if (!got_reset_lock)
+			return -EACCES;
+	}
+
+	mutex_lock(&psp->ta_ctx.ta_mutex);
+	/* copy ras RL to shared gpu memory */
+	memcpy(fw_mem->mem_cpu_addr, rl_bin->bin_addr, rl_bin->bin_size);
+	fw_mem->mem_size = rl_bin->bin_size;
+
+	/* Setup load RL command */
+	memset(&psp_load_rl_fw, 0, sizeof(psp_load_rl_fw));
+	psp_load_rl_fw.fw_phy_addr_lo = lower_32_bits(fw_mem->mem_mc_addr);
+	psp_load_rl_fw.fw_phy_addr_hi = upper_32_bits(fw_mem->mem_mc_addr);
+	psp_load_rl_fw.fw_size = fw_mem->mem_size;
+	psp_load_rl_fw.fw_type = GFX_FW_TYPE_REG_LIST;
+
+	ret = send_psp_cmd(ras_core, GFX_CMD_ID_LOAD_IP_FW,
+			&psp_load_rl_fw, sizeof(psp_load_rl_fw), &resp);
+	if (ret || resp.status) {
+		RAS_DEV_ERR(ras_core->dev,
+			"Failed to load RAS WL. ret:%d, status:%d\n", ret, resp.status);
+		ret = -EPIPE;
+	}
+
+	mutex_unlock(&psp->ta_ctx.ta_mutex);
+	if (got_reset_lock)
+		ras_core_up_gpu_reset_lock(ras_core);
+
+	return ret;
+}
+
+static int load_ras_ta_fw(struct ras_core_context *ras_core,
+		struct ras_fw_bin *ta_bin, struct ras_ta_param *ta_param)
 {
-	struct ras_ta_fw_bin  *fw_bin = &ta_ctx->fw_bin;
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
 	struct gpu_mem_block *fw_mem = NULL;
 	struct gpu_mem_block *cmd_mem = NULL;
 	struct ras_ta_cmd *ta_cmd;
@@ -546,41 +598,38 @@ static int send_load_ta_fw_cmd(struct ras_core_context *ras_core,
 	struct psp_gfx_cmd_load_ta  psp_load_ta_cmd;
 	struct psp_cmd_resp resp = {0};
 	struct ras_ta_image_header *fw_hdr = NULL;
+	int got_reset_lock = 0;
 	int ret;
 
-	ret = ras_psp_get_ras_ta_init_param(ras_core, &ta_ctx->init_param);
-	if (ret)
-		return ret;
-
 	fw_mem = ta_ctx->fw_gpu_mem;
 	cmd_mem = ta_ctx->cmd_gpu_mem;
 	if (!fw_mem || !cmd_mem)
 		return -ENOMEM;
 
-	/*
-	 * When skip_lock is true (called from .resume), the PSP has already
-	 * been re-initialized and it is safe to proceed without the read lock
-	 * (GPU reset holds write lock; S3/S4 has no lock to acquire).
-	 */
-	if (!skip_lock && !ras_core_down_trylock_gpu_reset_lock(ras_core))
-		return -EACCES;
+	if (!ras_core_gpu_in_reset(ras_core)) {
+		got_reset_lock = ras_core_down_trylock_gpu_reset_lock(ras_core);
+		if (!got_reset_lock)
+			return -EACCES;
+	}
+
+	mutex_lock(&ta_ctx->ta_mutex);
 
 	/* copy ras ta binary to shared gpu memory */
-	memcpy(fw_mem->mem_cpu_addr, fw_bin->bin_addr, fw_bin->bin_size);
-	fw_mem->mem_size = fw_bin->bin_size;
+	memcpy(fw_mem->mem_cpu_addr, ta_bin->bin_addr, ta_bin->bin_size);
+	fw_mem->mem_size = ta_bin->bin_size;
 
 	/* Initialize ras ta startup parameter */
 	ta_cmd = (struct ras_ta_cmd *)cmd_mem->mem_cpu_addr;
 	ta_init_flags = &ta_cmd->ras_in_message.init_flags;
 
-	ta_init_flags->poison_mode_en = ta_ctx->init_param.poison_mode_en;
-	ta_init_flags->dgpu_mode = ta_ctx->init_param.dgpu_mode;
-	ta_init_flags->xcc_mask = ta_ctx->init_param.xcc_mask;
-	ta_init_flags->channel_dis_num = ta_ctx->init_param.channel_dis_num;
-	ta_init_flags->nps_mode = ta_ctx->init_param.nps_mode;
-	ta_init_flags->active_umc_mask = ta_ctx->init_param.active_umc_mask;
-	ta_init_flags->vram_type = ta_ctx->init_param.vram_type;
-	ta_init_flags->ext_umc_mask = ta_ctx->init_param.ext_umc_mask;
+	ta_init_flags->poison_mode_en = ta_param->poison_mode_en;
+	ta_init_flags->dgpu_mode = ta_param->dgpu_mode;
+	ta_init_flags->xcc_mask = ta_param->xcc_mask;
+	ta_init_flags->channel_dis_num = ta_param->channel_dis_num;
+	ta_init_flags->nps_mode = ta_param->nps_mode;
+	ta_init_flags->active_umc_mask = ta_param->active_umc_mask;
+	ta_init_flags->vram_type = ta_param->vram_type;
+	ta_init_flags->ext_umc_mask = ta_param->ext_umc_mask;
 
 	/* Setup load ras ta command */
 	memset(&psp_load_ta_cmd, 0, sizeof(psp_load_ta_cmd));
@@ -595,7 +644,7 @@ static int send_load_ta_fw_cmd(struct ras_core_context *ras_core,
 			&psp_load_ta_cmd, sizeof(psp_load_ta_cmd), &resp);
 	if (!ret && !resp.status) {
 		/* Read TA version at FW offset 0x60 if TA version not found*/
-		fw_hdr = (struct ras_ta_image_header *)fw_bin->bin_addr;
+		fw_hdr = (struct ras_ta_image_header *)ta_bin->bin_addr;
 		RAS_DEV_INFO(ras_core->dev, "PSP: RAS TA(version:%X.%X.%X.%X) is loaded.\n",
 			(fw_hdr->image_version >> 24) & 0xFF, (fw_hdr->image_version >> 16) & 0xFF,
 			(fw_hdr->image_version >> 8) & 0xFF, fw_hdr->image_version & 0xFF);
@@ -605,32 +654,27 @@ static int send_load_ta_fw_cmd(struct ras_core_context *ras_core,
 	} else {
 		RAS_DEV_ERR(ras_core->dev,
 			"Failed to load RAS TA! ret:%d, status:%d\n", ret, resp.status);
+		ret = -EPIPE;
 	}
 
-	if (!skip_lock)
+	mutex_unlock(&ta_ctx->ta_mutex);
+	if (got_reset_lock)
 		ras_core_up_gpu_reset_lock(ras_core);
 
 	return ret;
 }
 
-static int load_ras_ta_firmware(struct ras_core_context *ras_core, bool skip_lock)
-{
-	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
-	int ret;
-
-	ret = send_load_ta_fw_cmd(ras_core, ta_ctx, skip_lock);
-	return ret;
-}
-
-static int unload_ras_ta_firmware(struct ras_core_context *ras_core,
+static int unload_ras_ta_fw(struct ras_core_context *ras_core,
 		struct ras_psp_ta_unload *ras_ta_unload)
 {
 	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
 	struct psp_gfx_cmd_unload_ta  cmd_unload_ta = {0};
 	struct psp_cmd_resp resp = {0};
+	int got_reset_lock = 0;
 	int ret;
 
-	if (!ras_core_down_trylock_gpu_reset_lock(ras_core))
+	got_reset_lock = ras_core_down_trylock_gpu_reset_lock(ras_core);
+	if (!got_reset_lock)
 		return -EACCES;
 
 	cmd_unload_ta.session_id = ta_ctx->session_id;
@@ -650,52 +694,86 @@ static int unload_ras_ta_firmware(struct ras_core_context *ras_core,
 	ta_ctx->ta_version = 0;
 	ta_ctx->ras_ta_initialized = false;
 	ta_ctx->session_id = 0;
+
 unlock:
-	ras_core_up_gpu_reset_lock(ras_core);
+	if (got_reset_lock)
+		ras_core_up_gpu_reset_lock(ras_core);
 
 	return ret;
 }
 
-int ras_psp_load_firmware(struct ras_core_context *ras_core,
-		bool skip_lock)
+static int load_ras_all_fw(struct ras_core_context *ras_core)
+{
+	struct ras_param ras_param = {0};
+	int ret;
+
+	ret = ras_psp_get_ras_param(ras_core, &ras_param);
+	if (ret)
+		return ret;
+
+	ret = load_ras_rl_fw(ras_core, &ras_param.fw_param.rl_bin);
+	if (ret)
+		return ret;
+
+	return load_ras_ta_fw(ras_core,
+			&ras_param.fw_param.ta_bin, &ras_param.ta_param);
+}
+
+static int unload_ras_all_fw(struct ras_core_context *ras_core)
 {
 	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
-	struct ras_psp_ta_unload ras_ta_unload = {0};
-	int ret = 0;
+	struct ras_psp_ta_unload ta_unload = {0};
 
-	if (skip_lock) {
-		/*
-		 * Called from .resume: PSP has been re-initialized after a GPU
-		 * reset or S3/S4, so any previous TA session is gone. Clear
-		 * stale state and proceed directly to a fresh load, bypassing
-		 * both the unload step and the reset read-lock acquisition
-		 * (which would deadlock inside a GPU reset).
-		 */
-		ta_ctx->preload_ras_ta_enabled = false;
+	if (ta_ctx->ras_ta_initialized) {
+		ta_unload.ras_session_id = ta_ctx->session_id;
+		unload_ras_ta_fw(ras_core, &ta_unload);
 		ta_ctx->ras_ta_initialized = false;
 		ta_ctx->session_id = 0;
 		ta_ctx->ta_version = 0;
-	} else {
-		/*
-		 * Normal path: only skip a reload when the current TA session is
-		 * known to be alive. Firmware metadata may already be cached even
-		 * when the TA is not loaded, so that must not suppress a reload.
-		 */
-		if (ta_ctx->preload_ras_ta_enabled && ta_ctx->ras_ta_initialized)
-			return 0;
+	}
 
-		if (ta_ctx->ras_ta_initialized) {
-			ras_ta_unload.ras_session_id = ta_ctx->session_id;
-			ret = unload_ras_ta_firmware(ras_core, &ras_ta_unload);
-			if (ret)
-				return ret;
-		}
+	return 0;
+}
+
+int ras_psp_sideload_ras_ta(struct ras_core_context *ras_core,
+		struct ras_psp_ta_load *ta_load)
+{
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+	struct ras_psp_ta_unload ras_ta_unload = {0};
+	struct ras_param ras_param = {0};
+	struct ras_fw_bin ta_bin = {0};
+	int ret = 0;
+
+	if (!ta_load || !ta_load->bin_addr || !ta_load->bin_size)
+		return -EINVAL;
+
+	if (ta_ctx->ras_ta_initialized) {
+		ras_ta_unload.ras_session_id = ta_ctx->session_id;
+		ret = unload_ras_ta_fw(ras_core, &ras_ta_unload);
+		if (ret)
+			return ret;
 	}
 
-	return load_ras_ta_firmware(ras_core, skip_lock);
+	ret = ras_psp_get_ras_param(ras_core, &ras_param);
+	if (ret)
+		return ret;
+
+	ta_bin.bin_addr = ta_load->bin_addr;
+	ta_bin.bin_size = ta_load->bin_size;
+	ta_bin.fw_version = ta_load->fw_version;
+	ta_bin.feature_version = ta_load->feature_version;
+
+	ret = load_ras_ta_fw(ras_core, &ta_bin, &ras_param.ta_param);
+	if (ret)
+		return ret;
+
+	ta_load->out_session_id = ta_ctx->session_id;
+	ta_load->out_loaded_ta_version = ta_ctx->ta_version;
+
+	return 0;
 }
 
-int ras_psp_unload_firmware(struct ras_core_context *ras_core,
+int ras_psp_unsideload_ras_ta(struct ras_core_context *ras_core,
 	struct ras_psp_ta_unload *ras_ta_unload)
 {
 	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
@@ -704,7 +782,19 @@ int ras_psp_unload_firmware(struct ras_core_context *ras_core,
 	    (ras_ta_unload->ras_session_id != ta_ctx->session_id))
 		return -EINVAL;
 
-	return unload_ras_ta_firmware(ras_core, ras_ta_unload);
+	return unload_ras_ta_fw(ras_core, ras_ta_unload);
+}
+
+int ras_psp_reload_firmwares(struct ras_core_context *ras_core,
+		uint32_t flags)
+{
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+
+	ta_ctx->ras_ta_initialized = false;
+	ta_ctx->session_id = 0;
+	ta_ctx->ta_version = 0;
+
+	return load_ras_all_fw(ras_core);
 }
 
 int ras_psp_trigger_error(struct ras_core_context *ras_core,
@@ -712,7 +802,7 @@ int ras_psp_trigger_error(struct ras_core_context *ras_core,
 {
 	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
 
-	if (!ta_ctx->preload_ras_ta_enabled && !ta_ctx->ras_ta_initialized) {
+	if (!ta_ctx->ras_ta_initialized) {
 		RAS_DEV_ERR(ras_core->dev, "RAS: ras firmware not initialized!");
 		return -ENOEXEC;
 	}
@@ -729,8 +819,7 @@ int ras_psp_query_address(struct ras_core_context *ras_core,
 {
 	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
 
-	if (!ta_ctx->preload_ras_ta_enabled &&
-	    !ta_ctx->ras_ta_initialized) {
+	if (!ta_ctx->ras_ta_initialized) {
 		RAS_DEV_ERR(ras_core->dev, "RAS: ras firmware not initialized!");
 		return -ENOEXEC;
 	}
@@ -779,6 +868,7 @@ int ras_psp_hw_init(struct ras_core_context *ras_core)
 	int ret = 0;
 	struct ras_psp *psp = &ras_core->ras_psp;
 	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+	struct ras_psp_sys_status sys_status = {0};
 
 	psp->psp_ip_version = ras_core->config->psp_ip_version;
 
@@ -798,36 +888,34 @@ int ras_psp_hw_init(struct ras_core_context *ras_core)
 	/* After GPU reset, the system RAS PSP status may change.
 	 * therefore, it is necessary to synchronize the system status again.
 	 */
-	ras_psp_sync_system_ras_psp_status(ras_core);
+	ret = ras_psp_get_system_ras_status(ras_core, &sys_status);
+	if (ret)
+		return ret;
+
+	if (sys_status.uniras_load_fw) {
+		ta_ctx->ras_ta_initialized = false;
+		psp->load_ras_fw_internal = true;
+	} else {
+		ta_ctx->ras_ta_initialized = true;
+		psp->load_ras_fw_internal = false;
+	}
+
+	psp->use_dedicated_memory = sys_status.use_dedicated_memory;
+	psp->psp_ctx.external_mutex = sys_status.psp_cmd_mutex;
 
 	ret = __ras_psp_mem_init(ras_core);
 	if (ret)
 		return ret;
 
-	if (!ta_ctx->preload_ras_ta_enabled && !ta_ctx->ras_ta_initialized)
-		ret = ras_psp_load_firmware(ras_core, false);
+	if (psp->load_ras_fw_internal)
+		ret = load_ras_all_fw(ras_core);
 
 	return ret;
 }
 
 int ras_psp_hw_fini(struct ras_core_context *ras_core)
 {
-	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
-	struct ras_psp_ta_unload ras_ta_unload = {0};
-
-	if (ta_ctx->ras_ta_initialized) {
-		ras_ta_unload.ras_session_id = ta_ctx->session_id;
-		ras_psp_unload_firmware(ras_core, &ras_ta_unload);
-	}
-
-	ta_ctx->ta_version = 0;
-	ta_ctx->ras_ta_initialized = false;
-	ta_ctx->preload_ras_ta_enabled = false;
-	ta_ctx->session_id = 0;
-
-	/* Free shared BO only on hw_fini, not on suspend */
-	ras_psp_put_ras_ta_fini_param(ras_core);
-
+	unload_ras_all_fw(ras_core);
 	return 0;
 }
 
@@ -837,16 +925,12 @@ bool ras_psp_check_supported_cmd(struct ras_core_context *ras_core,
 	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
 	bool ret = false;
 
-	if (!ta_ctx->preload_ras_ta_enabled && !ta_ctx->ras_ta_initialized)
+	if (!ta_ctx->ras_ta_initialized)
 		return false;
 
 	switch (cmd_id) {
 	case RAS_TA_CMD_ID__QUERY_ADDRESS:
-		/* Currently, querying the address from RAS TA is only supported
-		 * when the RAS TA firmware is loaded during driver installation.
-		 */
-		if (ta_ctx->preload_ras_ta_enabled)
-			ret = true;
+		ret = true;
 		break;
 	case RAS_TA_CMD_ID__TRIGGER_ERROR:
 		ret = true;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.h b/drivers/gpu/drm/amd/ras/core/ras_psp.h
index 8a483a842e04e..5e668730cf176 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.h
@@ -43,9 +43,10 @@ struct ras_ta_image_header {
 struct ras_psp_sys_status {
 	void *psp_cmd_mutex;
 	bool use_dedicated_memory;
+	bool uniras_load_fw;
 };
 
-struct ras_ta_init_param {
+struct ras_ta_param {
 	uint8_t poison_mode_en;
 	uint8_t dgpu_mode;
 	uint16_t xcc_mask;
@@ -56,6 +57,23 @@ struct ras_ta_init_param {
 	uint32_t ext_umc_mask;
 };
 
+struct ras_fw_bin {
+	uint32_t fw_version;
+	uint32_t feature_version;
+	uint32_t bin_size;
+	uint8_t *bin_addr;
+};
+
+struct ras_fw_param {
+	struct ras_fw_bin rl_bin;
+	struct ras_fw_bin ta_bin;
+};
+
+struct ras_param {
+	struct ras_fw_param  fw_param;
+	struct ras_ta_param  ta_param;
+};
+
 struct gpu_mem_block {
 	uint32_t mem_type;
 	void *mem_bo;
@@ -113,28 +131,20 @@ struct ras_psp_ctx {
 	struct gpu_mem_block *out_fence_gpu_mem;
 };
 
-struct ras_ta_fw_bin {
-	uint32_t fw_version;
-	uint32_t feature_version;
-	uint32_t bin_size;
-	uint8_t *bin_addr;
-};
-
 struct ras_ta_ctx {
-	bool  preload_ras_ta_enabled;
 	bool  ras_ta_initialized;
 	uint32_t  session_id;
 	uint32_t  resp_status;
 	uint32_t  ta_version;
 	struct mutex ta_mutex;
-	struct ras_ta_fw_bin fw_bin;
-	struct ras_ta_init_param init_param;
+	struct ras_fw_bin fw_bin;
 	struct gpu_mem_block *fw_gpu_mem;
 	struct gpu_mem_block *cmd_gpu_mem;
 };
 
 struct ras_psp {
 	bool use_dedicated_memory;
+	bool  load_ras_fw_internal;
 	uint32_t psp_ip_version;
 	struct ras_block_map *blk_maps;
 	uint32_t maps_size;
@@ -146,6 +156,15 @@ struct ras_psp {
 	const struct ras_psp_sys_func *sys_func;
 };
 
+struct ras_psp_ta_load {
+	uint32_t fw_version;
+	uint32_t feature_version;
+	uint32_t bin_size;
+	uint8_t *bin_addr;
+	uint64_t out_session_id;
+	uint32_t out_loaded_ta_version;
+};
+
 struct ras_psp_ta_unload {
 	uint64_t ras_session_id;
 };
@@ -155,8 +174,10 @@ int ras_psp_sw_fini(struct ras_core_context *ras_core);
 int ras_psp_hw_init(struct ras_core_context *ras_core);
 int ras_psp_hw_fini(struct ras_core_context *ras_core);
 
-int ras_psp_load_firmware(struct ras_core_context *ras_core, bool skip_lock);
-int ras_psp_unload_firmware(struct ras_core_context *ras_core,
+int ras_psp_reload_firmwares(struct ras_core_context *ras_core, uint32_t flags);
+int ras_psp_sideload_ras_ta(struct ras_core_context *ras_core,
+		struct ras_psp_ta_load *ta_load);
+int ras_psp_unsideload_ras_ta(struct ras_core_context *ras_core,
 		struct ras_psp_ta_unload *ras_ta_unload);
 int ras_psp_trigger_error(struct ras_core_context *ras_core,
 	struct ras_ta_trigger_error_input *info, uint32_t instance_mask);
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 3abd33796c032..3797a17385b44 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -190,76 +190,47 @@ static int amdgpu_ras_mgr_get_ras_psp_system_status(struct ras_core_context *ras
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
 
 	status->psp_cmd_mutex = &adev->psp.mutex;
+	status->uniras_load_fw = false;
+
+	status->use_dedicated_memory = !status->uniras_load_fw;
 
 	return 0;
 }
 
-static int amdgpu_ras_mgr_get_ras_ta_init_param(struct ras_core_context *ras_core,
-	struct ras_ta_init_param *ras_ta_param)
+static int amdgpu_ras_mgr_get_ras_param(struct ras_core_context *ras_core,
+	struct ras_param *param)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
-	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
-	struct ras_ta_fw_bin  *fw_bin = &ta_ctx->fw_bin;
 	struct ta_context *context = &adev->psp.ras_context.context;
-	struct ta_mem_context *mem_ctx = &context->mem_context;
-	uint32_t nps_mode;
 
-	if (ras_core_poison_supported(ras_core))
-		ras_ta_param->poison_mode_en = 1;
+	if (!param)
+		return -EINVAL;
 
 	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
-		ras_ta_param->dgpu_mode = 1;
-
-	ras_ta_param->xcc_mask = adev->gfx.xcc_mask;
-	ras_ta_param->channel_dis_num = hweight32(adev->gmc.m_half_use) * 2;
-
-	ras_ta_param->active_umc_mask = lower_32_bits(adev->umc.active_mask);
-	ras_ta_param->ext_umc_mask = upper_32_bits(adev->umc.active_mask);
-	ras_ta_param->vram_type = (uint8_t)adev->gmc.vram_type;
-
-	if (!amdgpu_ras_mgr_get_curr_nps_mode(adev, &nps_mode))
-		ras_ta_param->nps_mode = nps_mode;
-
-	/* If RAS TA is not initialized, it means RAS TA is not loaded. In this case, RAS module
-	 * needs to get the FW bin info from the context and load RAS TA.
-	 */
-	if (!ta_ctx->ras_ta_initialized) {
-		fw_bin->fw_version = context->bin_desc.fw_version;
-		fw_bin->feature_version = context->bin_desc.feature_version;
-		fw_bin->bin_size = context->bin_desc.size_bytes;
-		fw_bin->bin_addr = context->bin_desc.start_addr;
-
-		if (!mem_ctx->shared_buf) {
-			mem_ctx->shared_mem_size = PSP_RAS_SHARED_MEM_SIZE;
-			return amdgpu_bo_create_kernel(adev, mem_ctx->shared_mem_size,
-				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM |
-				    AMDGPU_GEM_DOMAIN_GTT,
-				    &mem_ctx->shared_bo,
-				    &mem_ctx->shared_mc_addr,
-				    &mem_ctx->shared_buf);
-		}
-	}
+		param->ta_param.dgpu_mode = 1;
 
-	return 0;
-}
+	param->ta_param.xcc_mask = adev->gfx.xcc_mask;
+	param->ta_param.channel_dis_num = hweight32(adev->gmc.m_half_use) * 2;
 
-static void amdgpu_ras_mgr_put_ras_ta_fini_param(struct ras_core_context *ras_core)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
-	struct ta_context *context = &adev->psp.ras_context.context;
-	struct ta_mem_context *mem_ctx = &context->mem_context;
+	param->ta_param.active_umc_mask = lower_32_bits(adev->umc.active_mask);
+	param->ta_param.ext_umc_mask = upper_32_bits(adev->umc.active_mask);
 
-	if (mem_ctx->shared_buf) {
-		amdgpu_bo_free_kernel(&mem_ctx->shared_bo,
-				      &mem_ctx->shared_mc_addr,
-				      &mem_ctx->shared_buf);
-	}
+	param->fw_param.rl_bin.fw_version = adev->psp.rl.fw_version;
+	param->fw_param.rl_bin.feature_version = adev->psp.rl.feature_version;
+	param->fw_param.rl_bin.bin_size = adev->psp.rl.size_bytes;
+	param->fw_param.rl_bin.bin_addr = adev->psp.rl.start_addr;
+
+	param->fw_param.ta_bin.fw_version = context->bin_desc.fw_version;
+	param->fw_param.ta_bin.feature_version = context->bin_desc.feature_version;
+	param->fw_param.ta_bin.bin_size = context->bin_desc.size_bytes;
+	param->fw_param.ta_bin.bin_addr = context->bin_desc.start_addr;
+
+	return 0;
 }
 
 const struct ras_psp_sys_func amdgpu_ras_psp_sys_func = {
 	.get_ras_psp_system_status = amdgpu_ras_mgr_get_ras_psp_system_status,
-	.get_ras_ta_init_param = amdgpu_ras_mgr_get_ras_ta_init_param,
-	.put_ras_ta_fini_param = amdgpu_ras_mgr_put_ras_ta_fini_param,
+	.get_ras_param = amdgpu_ras_mgr_get_ras_param,
 };
 
 static int amdgpu_ras_mgr_init_psp_config(struct amdgpu_device *adev,
@@ -517,11 +488,7 @@ static int amdgpu_ras_mgr_resume(struct amdgpu_ip_block *ip_block)
 	if (!ras_mgr || !ras_mgr->ras_core)
 		return 0;
 
-	/*
-	 * Pass skip_lock=true: PSP is re-initialized after GPU reset or
-	 * S3/S4, so bypass the trylock and clear stale TA session state.
-	 */
-	ret = ras_psp_load_firmware(ras_mgr->ras_core, true);
+	ret = ras_psp_reload_firmwares(ras_mgr->ras_core, 0);
 	if (ret)
 		RAS_DEV_ERR(adev,
 			    "Failed to reload RAS TA on resume, ret:%d\n", ret);
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index 3c91aea68ebc4..7bc827cc8e9fc 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -268,7 +268,7 @@ static int amdgpu_ras_sys_get_gpu_mem(struct ras_core_context *ras_core,
 		gpu_mem->mem_size = PSP_FENCE_BUFFER_SIZE;
 		gpu_mem->mem_mc_addr = psp->fence_buf_mc_addr;
 		gpu_mem->mem_cpu_addr = psp->fence_buf;
-	} else if (mem_type == GPU_MEM_TYPE_RAS_TA_FW) {
+	} else if (mem_type == GPU_MEM_TYPE_RAS_FW_BIN) {
 		gpu_mem->mem_bo = psp->fw_pri_bo;
 		gpu_mem->mem_size = PSP_1_MEG;
 		gpu_mem->mem_mc_addr = psp->fw_pri_mc_addr;
-- 
2.55.0

