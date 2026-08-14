Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC10C5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC2CA10F701;
	Fri, 14 Aug 2026 21:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gxg+LtjV";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013045.outbound.protection.outlook.com
 [40.93.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D682B10F71F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPutMimFfD2qMHMWt0CoB528Y1PTuSWoNCI58bpBqEeAR6cRMhZMJRo2yn3NKuzTN5egAdQfGjx4TjPKMwnvsKQhU964qQ4V3u3a4HAexd67R2zya+NDir96rN08FwS3bBHR+2kaUvxHe00or9IxIsW7T+0ipM0hhAlVRE0rZh39CbM9uR0Pl2pUDcJPhkU1PyIxImmN9JI4eI58HG19pxLgIRy3qm1A18HsO2ZLrUviquiPFUDm7vqtCAS8wDH5T6jLzQu8kI1vFjk0NlLYMikkuMAptEbzDeEQdTiJuT8HziWpH59jkMK2G3UE4Mixd8UHyPlwsE1blkdKvZG5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIJc0wxTXyDiIev6ESTdLu8xdWhAH9Cvp04PRSjPGDw=;
 b=hHxzkHz3ognDvCzHq/TNjLdUdDjb3fVxj0Ww/fPTVaNAZZ+RX5smShnSiakUBg4fqY0hPwmkFRozCX0TUC/HoyNkXJ44cebMQ/tNhKGii617wX+Qr538JgeFYoz70fIehvOF0MRg68Ub6onY0c1PV8YDSbgw3HXmy9we9CGs4E3ElGq0HC+VI3i+rljEwYT99p0yy6NXZ7yAfbxeJsSnWLqHJ2ktEYQ0FB5o13vi4gLB9f4/LKXSPVO4aehAOgLhkOgJGJaBMDd/gj7D/0ss+BPKawRo5qXto4ZJXSPSyxLLR8EPyWHnkPZhIDAnzOMPd+zoQcarkgBVk9YmJViY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIJc0wxTXyDiIev6ESTdLu8xdWhAH9Cvp04PRSjPGDw=;
 b=Gxg+LtjVI6BsfCSiiy+KKBmWM7Ws3fqnsv6WSJ1wvaT8BlbBhzq0WPlhXqSJky34lIP+jtpZa6jvrczu3yQ5Vbvm3rEDgCxj5DJvP3gO/79Q2ivADItM9tgKmqGy/2ZP0CgINiRAtXlPMNIVro5TfEKaNZVPg6E693Yl5lz2LZY=
Received: from BN9PR03CA0573.namprd03.prod.outlook.com (2603:10b6:408:10d::8)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:38 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::b) by BN9PR03CA0573.outlook.office365.com
 (2603:10b6:408:10d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:33 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 059/109] drm/amdgpu: refactor memory handling to support both
 external and internal allocation
Date: Fri, 14 Aug 2026 17:01:56 -0400
Message-ID: <20260814210246.3067612-60-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9f6343-b258-4dc5-9a04-08defa478347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: hkkidSSXB/Jhy9qBv/dsHRhviovjtODM3mCpjRIJh67+ztGqCLrEQcV4rIugP7apXC1NZ250zOkMRnZn7JA+/QIvF9nz46/PjZV6UwTWcBJug6WfMnMU9+W7l+sDf4etAp7rv952jbc9kHA5Fuh+JQks40Tfq8mMRDhkkifaWtMS4pLMzjhGfqIhYr3cOJYFggWMgW3LwY97865t5qZFasmdFOeXeeyHptz5lUtEU0gKf9CycLlQ2JgSmNZnASlbyIAJCf/DBnKA3RsOTVS00Yv32OXkw8/w9H28r4cGDVQM3lPthl0AW/+cPY75Mnz7GRJGbMPPbPjnhAay6jWw9b0+jv25bDMcciX5NSfTFN9DdwLeosIOhGDmwFtnxZiDx7t7YLESZeFXrlzvgIOJfyxIR4adtEPtpOSHJTtr1FIpn9KCXMRfls5dFJVgNDmpyhdCzcDxcIqW4K2/zf/RRHgimy/wVEvBzzoBphL0EKGxo79rl+dDvdaEfwmWoalWRGWikTON0AjNOqz9dZqQar0BR6UnmE1devq5j/cYVrkrlo7ZVkc8AwhxcJyjJsMihvjtq7bJhMWhxkx8mUfZ5suaTg4PcY4LjnYRUsJGj+bj1lBT7Stq0+P+0k+eRL19z5El5C/ZXLRB2ez6dW1GfuJbGNOXzhPUl7sVBuxA3ynyFf//ciMczD5wmxLrvIfIIIpvb89Eqm4IzqwKrN386A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pPj0bK/iKbjOLBAvyQ1svB8RwUDop/xDxTU67I2wq8Zyx5weVPzq91e++pz5oYGKfflBO7jmBwJY+rRiEchxFhHMOiKGn0ZFwYh/kePGggpPZ4dv6VAPq9cb7WdRtOP3B3+2W+Tk2u5/J0wA3qziz/Oj5cAytEnfZO4ETCVNEgGFg2dz3vvD1QldmHERjdRcxy6SviF//IrKXvRUKrjXoaAiWr+3vAMI2uug2yQMA6hDRBW9nmflt9hiBK+2UwH+E0Xw3nnrz6yU+lq35Twa1j0Gs2nvxtznhgII+JpFb0FE3FdPJoJWiGsPALVhjWbf2W8DVpEStqQn+THY7iH62BM+7bit/74gaxEbucezjaPjNric1vH8CoGAsFXiwDuQgMz88KI9PBdAYxL/dTWAKebbgplsmKcOscWI27chAGo7pZB9R+ZcuMmJYKqLYFQu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:38.4984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9f6343-b258-4dc5-9a04-08defa478347
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
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

Optimize the memory usage to accommodate both referencing externally
allocated memory from outside the module and allocating memory directly
within the module.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras.h            |   2 +
 drivers/gpu/drm/amd/ras/core/ras_psp.c        | 209 +++++++++++-------
 drivers/gpu/drm/amd/ras/core/ras_psp.h        |  12 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  |  30 +++
 4 files changed, 173 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 3faf16c850da3..17b1e7820855c 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -262,6 +262,8 @@ enum gpu_mem_type {
 	GPU_MEM_TYPE_RAS_PSP_FENCE,
 	GPU_MEM_TYPE_RAS_TA_FW,
 	GPU_MEM_TYPE_RAS_TA_CMD,
+	GPU_MEM_TYPE_ALLOC_MEM,
+	GPU_MEM_TYPE_MAX
 };
 
 struct ras_psp_sys_func {
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index b7af0f2dd6ac6..d3cc992a462a7 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -33,6 +33,11 @@
 #define RAS_TA_INST_MASK 0xfffff000
 #define RAS_TA_INST_SHIFT 0xc
 
+#define RAS_PSP_RING_SIZE  0x100000
+#define RAS_PSP_CMD_SIZE   0x100000
+#define RAS_PSP_FENCE_SIZE 0x1000
+#define RAS_FW_BIN_SIZE    0x100000
+#define RAS_TA_CMD_SIZE    0x100000
 static const struct ras_psp_ip_func *ras_psp_get_ip_funcs(
 			struct ras_core_context *ras_core, uint32_t ip_version)
 {
@@ -90,66 +95,138 @@ static void ras_psp_put_ras_ta_fini_param(struct ras_core_context *ras_core)
 		psp->sys_func->put_ras_ta_fini_param(ras_core);
 }
 
-static struct gpu_mem_block *ras_psp_get_gpu_mem(struct ras_core_context *ras_core,
-			enum gpu_mem_type mem_type)
+static struct gpu_mem_block *ras_psp_alloc_mem(struct ras_core_context *ras_core,
+			enum gpu_mem_type mem_type, u32 mem_size)
 {
-	struct ras_psp *psp = &ras_core->ras_psp;
-	struct gpu_mem_block *gpu_mem = NULL;
+	struct gpu_mem_block *gpu_mem;
 	int ret;
 
-	switch (mem_type) {
-	case GPU_MEM_TYPE_RAS_PSP_RING:
-		gpu_mem = &psp->psp_ring.ras_ring_gpu_mem;
-		break;
-	case GPU_MEM_TYPE_RAS_PSP_CMD:
-		gpu_mem = &psp->psp_ctx.psp_cmd_gpu_mem;
-		break;
-	case GPU_MEM_TYPE_RAS_PSP_FENCE:
-		gpu_mem = &psp->psp_ctx.out_fence_gpu_mem;
-		break;
-	case GPU_MEM_TYPE_RAS_TA_FW:
-		gpu_mem = &psp->ta_ctx.fw_gpu_mem;
-		break;
-	case GPU_MEM_TYPE_RAS_TA_CMD:
-		gpu_mem = &psp->ta_ctx.cmd_gpu_mem;
-		break;
-	default:
+	if ((mem_type >= GPU_MEM_TYPE_MAX) || (mem_size < PAGE_SIZE))
 		return NULL;
-	}
 
-	if (!gpu_mem->ref_count) {
-		ret = ras_core_get_gpu_mem(ras_core, mem_type, gpu_mem);
-		if (ret)
-			return NULL;
-		gpu_mem->mem_type = mem_type;
-	}
+	gpu_mem = kzalloc(sizeof(*gpu_mem), GFP_KERNEL);
+	if (!gpu_mem)
+		return NULL;
 
+	gpu_mem->mem_size = mem_size;
+	ret = ras_core_get_gpu_mem(ras_core, mem_type, gpu_mem);
+	if (ret)
+		goto err;
+
+	gpu_mem->mem_type = mem_type;
 	gpu_mem->ref_count++;
 
 	return gpu_mem;
+
+err:
+	kfree(gpu_mem);
+	return NULL;
 }
 
-static int ras_psp_put_gpu_mem(struct ras_core_context *ras_core,
+static int ras_psp_free_mem(struct ras_core_context *ras_core,
 			struct gpu_mem_block *gpu_mem)
 {
 	if (!gpu_mem)
 		return 0;
 
-	gpu_mem->ref_count--;
-
-	if (gpu_mem->ref_count > 0) {
+	if (!gpu_mem->ref_count) {
 		return 0;
-	} else if (gpu_mem->ref_count < 0) {
-		RAS_DEV_WARN(ras_core->dev,
-			"Duplicate free gpu memory %u\n", gpu_mem->mem_type);
-	} else {
+	} else if (gpu_mem->ref_count == 1) {
 		ras_core_put_gpu_mem(ras_core, gpu_mem->mem_type, gpu_mem);
 		memset(gpu_mem, 0, sizeof(*gpu_mem));
+		kfree(gpu_mem);
+	} else if (gpu_mem->ref_count > 1) {
+		gpu_mem->ref_count--;
 	}
 
 	return 0;
 }
 
+static int __ras_psp_mem_init(struct ras_core_context *ras_core)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+	struct gpu_mem_block *psp_ring = NULL;
+	struct gpu_mem_block *psp_cmd = NULL;
+	struct gpu_mem_block *psp_fence = NULL;
+	struct gpu_mem_block *fw_bin = NULL;
+	struct gpu_mem_block *ta_cmd = NULL;
+
+	/* Avoid repeatedly reinitializing memory */
+	if (psp->psp_ring.ras_ring_gpu_mem)
+		return 0;
+
+	psp_ring = ras_psp_alloc_mem(ras_core,
+				GPU_MEM_TYPE_RAS_PSP_RING, RAS_PSP_RING_SIZE);
+	if (!psp_ring)
+		return -EPIPE;
+
+	psp_cmd = ras_psp_alloc_mem(ras_core,
+				GPU_MEM_TYPE_RAS_PSP_CMD, RAS_PSP_CMD_SIZE);
+	if (!psp_cmd)
+		goto err;
+
+	psp_fence = ras_psp_alloc_mem(ras_core,
+				GPU_MEM_TYPE_RAS_PSP_FENCE, RAS_PSP_FENCE_SIZE);
+	if (!psp_fence)
+		goto err;
+
+	if (psp->use_dedicated_memory) {
+		fw_bin = ras_psp_alloc_mem(ras_core,
+				GPU_MEM_TYPE_RAS_TA_FW, RAS_FW_BIN_SIZE);
+		if (!fw_bin)
+			goto err;
+
+		ta_cmd = ras_psp_alloc_mem(ras_core,
+				GPU_MEM_TYPE_RAS_TA_CMD, RAS_TA_CMD_SIZE);
+		if (!ta_cmd)
+			goto err;
+	} else {
+		fw_bin = ras_psp_alloc_mem(ras_core,
+				GPU_MEM_TYPE_ALLOC_MEM, RAS_FW_BIN_SIZE);
+		if (!fw_bin)
+			goto err;
+
+		ta_cmd = ras_psp_alloc_mem(ras_core,
+				GPU_MEM_TYPE_ALLOC_MEM, RAS_TA_CMD_SIZE);
+		if (!ta_cmd)
+			goto err;
+	}
+
+	psp->psp_ring.ras_ring_gpu_mem = psp_ring;
+	psp->psp_ctx.psp_cmd_gpu_mem = psp_cmd;
+	psp->psp_ctx.out_fence_gpu_mem = psp_fence;
+	psp->ta_ctx.fw_gpu_mem = fw_bin;
+	psp->ta_ctx.cmd_gpu_mem = ta_cmd;
+
+	return 0;
+
+err:
+	ras_psp_free_mem(ras_core, psp_ring);
+	ras_psp_free_mem(ras_core, psp_cmd);
+	ras_psp_free_mem(ras_core, psp_fence);
+	ras_psp_free_mem(ras_core, fw_bin);
+	ras_psp_free_mem(ras_core, ta_cmd);
+	return -EPIPE;
+}
+
+static int __ras_psp_mem_fini(struct ras_core_context *ras_core)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+
+	ras_psp_free_mem(ras_core, psp->psp_ring.ras_ring_gpu_mem);
+	ras_psp_free_mem(ras_core, psp->psp_ctx.psp_cmd_gpu_mem);
+	ras_psp_free_mem(ras_core, psp->psp_ctx.out_fence_gpu_mem);
+	ras_psp_free_mem(ras_core, psp->ta_ctx.fw_gpu_mem);
+	ras_psp_free_mem(ras_core, psp->ta_ctx.cmd_gpu_mem);
+
+	psp->psp_ctx.psp_cmd_gpu_mem = NULL;
+	psp->psp_ctx.out_fence_gpu_mem = NULL;
+	psp->ta_ctx.fw_gpu_mem = NULL;
+	psp->ta_ctx.cmd_gpu_mem = NULL;
+	psp->psp_ring.ras_ring_gpu_mem = NULL;
+	return 0;
+}
+
 static void __acquire_psp_cmd_lock(struct ras_core_context *ras_core)
 {
 	struct ras_psp_ctx *psp_ctx = &ras_core->ras_psp.psp_ctx;
@@ -192,6 +269,7 @@ static int __set_ring_frame_slot(struct ras_core_context *ras_core,
 static int write_frame_to_ras_psp_ring(struct ras_core_context *ras_core,
 		struct psp_gfx_rb_frame *frame)
 {
+	struct ras_psp *psp = &ras_core->ras_psp;
 	struct gpu_mem_block *ring_mem;
 	struct psp_gfx_rb_frame *rb_frame;
 	uint32_t max_frame_slot;
@@ -199,7 +277,7 @@ static int write_frame_to_ras_psp_ring(struct ras_core_context *ras_core,
 	uint32_t write_flush_read_back = 0;
 	int ret = 0;
 
-	ring_mem = ras_psp_get_gpu_mem(ras_core, GPU_MEM_TYPE_RAS_PSP_RING);
+	ring_mem = psp->psp_ring.ras_ring_gpu_mem;
 	if (!ring_mem)
 		return -ENOMEM;
 
@@ -227,8 +305,7 @@ static int write_frame_to_ras_psp_ring(struct ras_core_context *ras_core,
 			rb_frame[slot_idx].fence_addr_hi,
 			rb_frame[slot_idx].fence_addr_lo,
 			write_flush_read_back, frame->fence_value);
-		ret = -EACCES;
-		goto err;
+		return -EACCES;
 	}
 
 	slot_idx++;
@@ -238,8 +315,6 @@ static int write_frame_to_ras_psp_ring(struct ras_core_context *ras_core,
 
 	__set_ring_frame_slot(ras_core, slot_idx);
 
-err:
-	ras_psp_put_gpu_mem(ras_core, ring_mem);
 	return ret;
 }
 
@@ -262,14 +337,9 @@ static int send_psp_cmd(struct ras_core_context *ras_core,
 
 	__acquire_psp_cmd_lock(ras_core);
 
-	psp_cmd_buf = ras_psp_get_gpu_mem(ras_core, GPU_MEM_TYPE_RAS_PSP_CMD);
-	if (!psp_cmd_buf) {
-		ret = -ENOMEM;
-		goto exit;
-	}
-
-	psp_fence_buf = ras_psp_get_gpu_mem(ras_core, GPU_MEM_TYPE_RAS_PSP_FENCE);
-	if (!psp_fence_buf) {
+	psp_cmd_buf = psp_ctx->psp_cmd_gpu_mem;
+	psp_fence_buf = psp_ctx->out_fence_gpu_mem;
+	if (!psp_cmd_buf || !psp_fence_buf) {
 		ret = -ENOMEM;
 		goto exit;
 	}
@@ -316,9 +386,6 @@ static int send_psp_cmd(struct ras_core_context *ras_core,
 	resp->session_id = gfx_cmd->resp.session_id;
 
 exit:
-	ras_psp_put_gpu_mem(ras_core, psp_cmd_buf);
-	ras_psp_put_gpu_mem(ras_core, psp_fence_buf);
-
 	__release_psp_cmd_lock(ras_core);
 
 	return ret;
@@ -380,14 +447,12 @@ static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_core,
 		return -EACCES;
 	}
 
-	cmd_mem = ras_psp_get_gpu_mem(ras_core, GPU_MEM_TYPE_RAS_TA_CMD);
+	cmd_mem = ta_ctx->cmd_gpu_mem;
 	if (!cmd_mem)
 		return -ENOMEM;
 
-	if (!ras_core_down_trylock_gpu_reset_lock(ras_core)) {
-		ret = -EACCES;
-		goto out;
-	}
+	if (!ras_core_down_trylock_gpu_reset_lock(ras_core))
+		return -EACCES;
 
 	ras_cmd = (struct ras_ta_cmd *)cmd_mem->mem_cpu_addr;
 
@@ -433,8 +498,6 @@ static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_core,
 unlock:
 	mutex_unlock(&ta_ctx->ta_mutex);
 	ras_core_up_gpu_reset_lock(ras_core);
-out:
-	ras_psp_put_gpu_mem(ras_core, cmd_mem);
 	return ret;
 }
 
@@ -487,27 +550,20 @@ static int send_load_ta_fw_cmd(struct ras_core_context *ras_core,
 
 	ret = ras_psp_get_ras_ta_init_param(ras_core, &ta_ctx->init_param);
 	if (ret)
-		goto err;
+		return ret;
 
-	fw_mem = ras_psp_get_gpu_mem(ras_core, GPU_MEM_TYPE_RAS_TA_FW);
-	if (!fw_mem)
+	fw_mem = ta_ctx->fw_gpu_mem;
+	cmd_mem = ta_ctx->cmd_gpu_mem;
+	if (!fw_mem || !cmd_mem)
 		return -ENOMEM;
 
-	cmd_mem = ras_psp_get_gpu_mem(ras_core, GPU_MEM_TYPE_RAS_TA_CMD);
-	if (!cmd_mem) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
 	/*
 	 * When skip_lock is true (called from .resume), the PSP has already
 	 * been re-initialized and it is safe to proceed without the read lock
 	 * (GPU reset holds write lock; S3/S4 has no lock to acquire).
 	 */
-	if (!skip_lock && !ras_core_down_trylock_gpu_reset_lock(ras_core)) {
-		ret = -EACCES;
-		goto err;
-	}
+	if (!skip_lock && !ras_core_down_trylock_gpu_reset_lock(ras_core))
+		return -EACCES;
 
 	/* copy ras ta binary to shared gpu memory */
 	memcpy(fw_mem->mem_cpu_addr, fw_bin->bin_addr, fw_bin->bin_size);
@@ -554,9 +610,6 @@ static int send_load_ta_fw_cmd(struct ras_core_context *ras_core,
 	if (!skip_lock)
 		ras_core_up_gpu_reset_lock(ras_core);
 
-err:
-	ras_psp_put_gpu_mem(ras_core, fw_mem);
-	ras_psp_put_gpu_mem(ras_core, cmd_mem);
 	return ret;
 }
 
@@ -714,6 +767,8 @@ int ras_psp_sw_fini(struct ras_core_context *ras_core)
 	mutex_destroy(&psp->psp_ctx.internal_mutex);
 	mutex_destroy(&psp->ta_ctx.ta_mutex);
 
+	__ras_psp_mem_fini(ras_core);
+
 	memset(psp, 0, sizeof(*psp));
 
 	return 0;
@@ -745,6 +800,10 @@ int ras_psp_hw_init(struct ras_core_context *ras_core)
 	 */
 	ras_psp_sync_system_ras_psp_status(ras_core);
 
+	ret = __ras_psp_mem_init(ras_core);
+	if (ret)
+		return ret;
+
 	if (!ta_ctx->preload_ras_ta_enabled && !ta_ctx->ras_ta_initialized)
 		ret = ras_psp_load_firmware(ras_core, false);
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.h b/drivers/gpu/drm/amd/ras/core/ras_psp.h
index cb564b532ac9e..8a483a842e04e 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.h
@@ -42,6 +42,7 @@ struct ras_ta_image_header {
 
 struct ras_psp_sys_status {
 	void *psp_cmd_mutex;
+	bool use_dedicated_memory;
 };
 
 struct ras_ta_init_param {
@@ -96,7 +97,7 @@ struct ras_psp_ip_func {
 };
 
 struct ras_psp_ring {
-	struct gpu_mem_block ras_ring_gpu_mem;
+	struct gpu_mem_block *ras_ring_gpu_mem;
 };
 
 struct psp_cmd_resp {
@@ -108,8 +109,8 @@ struct ras_psp_ctx {
 	void *external_mutex;
 	struct mutex internal_mutex;
 	uint64_t in_fence_value;
-	struct gpu_mem_block psp_cmd_gpu_mem;
-	struct gpu_mem_block out_fence_gpu_mem;
+	struct gpu_mem_block *psp_cmd_gpu_mem;
+	struct gpu_mem_block *out_fence_gpu_mem;
 };
 
 struct ras_ta_fw_bin {
@@ -128,11 +129,12 @@ struct ras_ta_ctx {
 	struct mutex ta_mutex;
 	struct ras_ta_fw_bin fw_bin;
 	struct ras_ta_init_param init_param;
-	struct gpu_mem_block fw_gpu_mem;
-	struct gpu_mem_block cmd_gpu_mem;
+	struct gpu_mem_block *fw_gpu_mem;
+	struct gpu_mem_block *cmd_gpu_mem;
 };
 
 struct ras_psp {
+	bool use_dedicated_memory;
 	uint32_t psp_ip_version;
 	struct ras_block_map *blk_maps;
 	uint32_t maps_size;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index 6115f241f13b4..3c91aea68ebc4 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -247,6 +247,10 @@ static int amdgpu_ras_sys_get_gpu_mem(struct ras_core_context *ras_core,
 	struct psp_context *psp = &adev->psp;
 	struct psp_ring *psp_ring;
 	struct ta_mem_context *mem_ctx;
+	int ret;
+
+	if (!gpu_mem)
+		return -EINVAL;
 
 	if (mem_type == GPU_MEM_TYPE_RAS_PSP_RING) {
 		psp_ring = &psp->km_ring;
@@ -275,6 +279,25 @@ static int amdgpu_ras_sys_get_gpu_mem(struct ras_core_context *ras_core,
 		gpu_mem->mem_size = mem_ctx->shared_mem_size;
 		gpu_mem->mem_mc_addr = mem_ctx->shared_mc_addr;
 		gpu_mem->mem_cpu_addr = mem_ctx->shared_buf;
+	} else if (mem_type == GPU_MEM_TYPE_ALLOC_MEM) {
+		struct amdgpu_bo *mem_bo = NULL;
+
+		if (!gpu_mem->mem_size)
+			return -EINVAL;
+
+		ret = amdgpu_bo_create_kernel(adev, gpu_mem->mem_size,
+				    PSP_1_MEG, AMDGPU_GEM_DOMAIN_VRAM |
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &mem_bo,
+				    &gpu_mem->mem_mc_addr,
+				    &gpu_mem->mem_cpu_addr);
+		if (ret) {
+			RAS_DEV_ERR(ras_core->dev, "Failed to alloc shared memory. ret:%d\n", ret);
+			return ret;
+		}
+
+		gpu_mem->mem_bo = mem_bo;
+
 	} else {
 		return -EINVAL;
 	}
@@ -291,6 +314,13 @@ static int amdgpu_ras_sys_get_gpu_mem(struct ras_core_context *ras_core,
 static int amdgpu_ras_sys_put_gpu_mem(struct ras_core_context *ras_core,
 	enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem)
 {
+	if ((mem_type == GPU_MEM_TYPE_ALLOC_MEM) && gpu_mem &&
+		gpu_mem->mem_bo && gpu_mem->mem_cpu_addr && gpu_mem->mem_mc_addr) {
+		struct amdgpu_bo *mem_bo = gpu_mem->mem_bo;
+
+		amdgpu_bo_free_kernel(&mem_bo,
+			&gpu_mem->mem_mc_addr, &gpu_mem->mem_cpu_addr);
+	}
 
 	return 0;
 }
-- 
2.55.0

