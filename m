Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F940C531FA
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF54E10F1D5;
	Thu, 23 Jul 2026 20:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cERnpTub";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010037.outbound.protection.outlook.com
 [40.93.198.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99B2010F1D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+5zlfw5PvgVGpMvI+hsJ0ZIw4qu5xApLHaEZHVLPTWplom9cbeOKEF6nga2lZAWZcEnmX7NUWWk9hzM+NKFAI4zR8/GCiwhXotxNRR1AFD+IY9xj+Kgt3WCiwGFzhheMZH62I6EfBHtIRHi7mweBtglx7ZdojuwFlP2Z/tJZkIzqhuaStbVkvbnN09MgJH36Rz2C+jvKdFHoFWLfW/rVZDOdwcw3bVzqoBKsQVaS9ztnYx81CuHLIgxBXsgwfotuFNz6U2WnMY6+XoGzK2yJ+MyasqUJb2EYTbJQd6lqR+UYm/AnPYuU3wuR9ALtFL78dO6Fm1/kJOaew0Je5MzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDvAB10R7YvuZySDiH+gYlqupoXhAw/3bucH89vDZTI=;
 b=OWo+v2jh9LWKZmJzwfLp5f+oPZS0KLQD2O0R3Vyddqv0/vvPKELPOESiqyUugiuj30vK+4B7bSOLGCX8eGYMMGUjxSkjkngbrI72nR0XaBKL58ZW4b2xkQBEfpvWtYe7rRnDj/P/PxFCBoPxDmv4RudYldGMZyv3Gvj8tsgEPNG0K03LzaVBDCcVsaZmRa2/JFQ8kgPTxHwHuIgJUocA+4tMiLE4maz4PBZNg9/x9kDS4P6pWXE/6/xCLdyo4tYucXED1rZKxpfmPvVOCvKi+izRbbpmfdFpokKiGJNqR27dDhcoGn3uTNhJezSrmMwx1c6x5IfG4uEPgzOQtFBWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDvAB10R7YvuZySDiH+gYlqupoXhAw/3bucH89vDZTI=;
 b=cERnpTubmvaW3uWJWGKfrM3B4AzHwwUyH1xI/GqhqpzVXggLmQ57TA0lm91eSYj7ZDSn7NkvZP3Owrn6PbQy8i1aJhxTGRWtxwFlgaeK67QX7+V4SBY4QY3z1lUYcM/XbnA4OfAl5aKv5R5lczM06EPADBn678U3RqToP3rB5+8=
Received: from BN9PR03CA0689.namprd03.prod.outlook.com (2603:10b6:408:10e::34)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:04 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::9d) by BN9PR03CA0689.outlook.office365.com
 (2603:10b6:408:10e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:04 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:18:59 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 15/49] drm/amd/display: move GPU mem helpers to services
Date: Thu, 23 Jul 2026 16:13:23 -0400
Message-ID: <20260723201908.373300-16-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c83534-a893-47f9-d991-08dee8f7a425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eDwASTS0sb3IL2Oo2K55ixPxDkefggVAMcbP+Zq+WCdQBNzBuGBe2qgqMFau73X+jRrvN7MBMo0V9pSsr3vtAUR9L1f+RwFA+B7i5LhhmNDJbDQLr7iExFX1qE0Vc/OgMY19seoLFayP/BvzitouKuH/BL6TjsXS619kvetXqQr9wuUNMdfRY9/3YlONifBETB7YOinJn/QEKqudMoE4E5cyvm0YAAGgNRU/27mB2pzM095cEhajLHFDuFh9NShEiYu3N1Ylb11uW3ToLqQjaXtuKNpzZrHOucXlXFyJchnt1n96FsQYGI14qUaG+pCJUE366VVsvuJh/YTSyxQe54Deux8lmmxE4jdLMojsfZQWB2psH2drja+hjpWtqKAbFSZeNN0p5LeFogLIOlrIEagu0F0sIxcSrtGcKTyAFuDbC1SH7t4R4GeU/dmnd4QAXOLoEmIJ+ItwglEtaNNzOMnNoB/JFyYAyIOIaeCxMoV7M3XRUHtOCnIOB7ZuhzEHShsGhUfXnqz8lCo2yXhuvpbcGdRNxYSSwLB8iN03gWlK9AfddQaNGSX9ME+JOQkmwWXpRxqke8ADeLV1wIbXqcGavjGoUMErthhkWAF51ZYjgCPLD8gf+5WviGBvGZhdBdDp6e4H6UVYwGzZnhZ6tf18FL6NoM0ixforO1s3Y0XXEjUZoO+tN8mtwawJgY7J31bFT9r1W9N7avTWCZty5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VS0wUOgCQetBo2enPu8ef9xK5I1rsR8VLUMtZsxu72hE9Ph3V2ru6bypsBoG2AjIxdtkvEsALeajC2mYlncPws80PvQi5x1w69iUiSYU64PcYhy5CJPCr6HLGQmMspwFEVz2wi6bV92xQ/fbwgg0oYo6cTBC7edwdAS2om4/Zz/eb/JN/pwxgHckfjValJrqiIQMTqFz+trW8jfaBzg71Arap2DnVJN1BjOPz44FE9m9PYkAYLvDfKKv1YlFUeZ2pGgaD8I3o7Vnan3pAGXDqL7j59dF9DR7FkQTxbrtAqhr8Pw8fbwsC1oDV3yzgRb/FAOjHaumYcgouFrTKw4aROvq/B2zhig6cKwf3g1X9VpSwU8IgA4Q5GSoUVk2zmSqb9RYnqMokk+y6trokIUTC7r6BnQrByLmhjnwfdgSrRmRNdMohNdp8CnymfXrUi3w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:04.1243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c83534-a893-47f9-d991-08dee8f7a425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
dm_allocate_gpu_mem() and dm_free_gpu_mem() are generic DM service
helpers that wrap amdgpu_bo_create_kernel()/amdgpu_bo_free_kernel()
and track allocations on adev->dm.da_list. Move them out of
amdgpu_dm.c into amdgpu_dm_services.c alongside the other dm_* service
callbacks.

Both are already public and declared in amdgpu_dm.h; their callers in
amdgpu_dm_dmub.c and amdgpu_dm_helpers.c are unaffected. No functional
change.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 53 -------------------
 .../display/amdgpu_dm/amdgpu_dm_services.c    | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d49f0cd3b113..dfc16f5e415a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -411,59 +411,6 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 
 }
 
-void*
-dm_allocate_gpu_mem(
-		struct amdgpu_device *adev,
-		enum dc_gpu_mem_alloc_type type,
-		size_t size,
-		long long *addr)
-{
-	struct dal_allocation *da;
-	u32 domain = (type == DC_MEM_ALLOC_TYPE_GART) ?
-		AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM;
-	int ret;
-
-	da = kzalloc_obj(struct dal_allocation);
-	if (!da)
-		return NULL;
-
-	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
-				      domain, &da->bo,
-				      &da->gpu_addr, &da->cpu_ptr);
-
-	*addr = da->gpu_addr;
-
-	if (ret) {
-		kfree(da);
-		return NULL;
-	}
-
-	/* add da to list in dm */
-	list_add(&da->list, &adev->dm.da_list);
-
-	return da->cpu_ptr;
-}
-
-void
-dm_free_gpu_mem(
-		struct amdgpu_device *adev,
-		enum dc_gpu_mem_alloc_type type,
-		void *pvMem)
-{
-	struct dal_allocation *da;
-
-	/* walk the da list in DM */
-	list_for_each_entry(da, &adev->dm.da_list, list) {
-		if (pvMem == da->cpu_ptr) {
-			amdgpu_bo_free_kernel(&da->bo, &da->gpu_addr, &da->cpu_ptr);
-			list_del(&da->list);
-			kfree(da);
-			break;
-		}
-	}
-
-}
-
 static int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm)
 {
 	struct mod_power_init_params init_data[MAX_NUM_EDP];
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index dbdda6ed12d4..6dbc8d1b4ecd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -96,3 +96,56 @@ bool dm_query_extended_brightness_caps(struct dc_context *ctx,
 	return true;
 }
 EXPORT_IF_KUNIT(dm_query_extended_brightness_caps);
+
+void*
+dm_allocate_gpu_mem(
+		struct amdgpu_device *adev,
+		enum dc_gpu_mem_alloc_type type,
+		size_t size,
+		long long *addr)
+{
+	struct dal_allocation *da;
+	u32 domain = (type == DC_MEM_ALLOC_TYPE_GART) ?
+		AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM;
+	int ret;
+
+	da = kzalloc_obj(*da);
+	if (!da)
+		return NULL;
+
+	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+				      domain, &da->bo,
+				      &da->gpu_addr, &da->cpu_ptr);
+
+	*addr = da->gpu_addr;
+
+	if (ret) {
+		kfree(da);
+		return NULL;
+	}
+
+	/* add da to list in dm */
+	list_add(&da->list, &adev->dm.da_list);
+
+	return da->cpu_ptr;
+}
+
+void
+dm_free_gpu_mem(
+		struct amdgpu_device *adev,
+		enum dc_gpu_mem_alloc_type type,
+		void *pvMem)
+{
+	struct dal_allocation *da;
+
+	/* walk the da list in DM */
+	list_for_each_entry(da, &adev->dm.da_list, list) {
+		if (pvMem == da->cpu_ptr) {
+			amdgpu_bo_free_kernel(&da->bo, &da->gpu_addr, &da->cpu_ptr);
+			list_del(&da->list);
+			kfree(da);
+			break;
+		}
+	}
+
+}
-- 
2.53.0

