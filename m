Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2C9C4450A
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 02:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B333710E36A;
	Fri, 17 Jul 2026 02:26:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CUCPXBnJ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012003.outbound.protection.outlook.com
 [40.107.200.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C9F10E36A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 02:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCsTkBAhCesG1lbUobpI7Kq7cV9hL4qatVsvz3y4gU5oc07A5e5c5sylxoaMlNdu9K0hEIn9LbdZffuX35JdSMSzJYyPZxrTEE13ev67o1gtXkyCloSTu5mkb1Zw+FPtxjmlc9qeu+JG0TQJvpF0dLHJPXCx5xLecypyC/fy5d6aMsr6ytBzWpCSsgNm3+91rdBGMhRoNcimrFm+GZXCDtTtahiA7Eyf3hcak6nCkyz3viHrOy31c5EqmLZ+Uyl+kETvGPiYjbjIvIiTYOgaFL3Gil8n0IUN10JDJFvD9HMm+tYn/mFXxlD0ZxIXRO3qdJl3UNiBqHvMWQ6JM01N+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FssJBDrlisToZfF8IhTayN+r+vjwRCx+LHtJXe5Wfgs=;
 b=dKkMCnaA2EIiOpGSNFBAxGKBoJhknxm+mBt9bQDIsCmwwtpw6RjIDjwgQm88RYorUJaNBMOBEfRDf7g54Wm2tAk3UdSzOvFp0DNa/ZwwKDgLE+zY5eAkpFPA2rwV8QEijojo2QpKqspsQe5GsRvvkrCgXjgP38rek2LxG+2gNzR9GOr9UKBVe3rko/MeQ/ePlfxit+3+E/GC3XhRucO9kzIxLv2YrvxQcFzxWKBd6Qx9ffzDfEJ2bGJ9YlMnA/D0wVGSY+bpFwNSjLFx0iQgW4IcTiJh6+16zSpIXkzzNko78S5KBwLe4MDbSRYMThYCKwbiZFtXKLAWsQIpJXKcdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FssJBDrlisToZfF8IhTayN+r+vjwRCx+LHtJXe5Wfgs=;
 b=CUCPXBnJcLIBdEzbd8dmOOAnM94uFDRNwTHbFgJLpVUUufm/nBKn5qjwK+ot5SYZR0d7ffpEZ30Ykx4obGM19xWrdh/ljdcIIb35vZNP6fX3vM8h8jgZXJE6UqfM9cHHLabHJ9tQ4+sWyBOGZXyNnZYzUwFkby50jkj5eml6Aj8=
Received: from PH7PR13CA0012.namprd13.prod.outlook.com (2603:10b6:510:174::18)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 02:26:10 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::a1) by PH7PR13CA0012.outlook.office365.com
 (2603:10b6:510:174::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5 via Frontend Transport; Fri, 17
 Jul 2026 02:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 02:26:08 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 21:26:07 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] drm/amdgpu: fix userq page count in input_validate
Date: Fri, 17 Jul 2026 10:25:50 +0800
Message-ID: <20260717022550.6549-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4b7c5a-c3fc-44e0-47bd-08dee3aac318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: RF3X6+kOlqdntNVPxiZwKdbbb8l3Q8hvOsMJ82pMevPlwgqtxdRTO7cfLaVhaEVQ41LyARGiekpXSEc3ImF12fpok63vEkJNfjuxv0ForN5Sj29YwCVdY8b8LSnzoyNXQ8xzKj1K5FmYdOuGQD7BfDGKOOOOnhkQo+glDBCxirMH92g70H13EvkDFzAtMxCWeo+0h5wHluPQ/BHqggmQWhwSPQvauO/aFjCyUbyX6u1wFtIEwEb7km9U2P/hruR5L/Qzcd1brkYcg3zxf2QNiwdQ2FxaL3oN5dyOKug5hocijS/l4Dg86tnbba8vmoRzOQHKzA1cj7XnK3cjhaX8QaSvcKhxln3mFkU4imkoDhIdba7sd2gg1chnITv5AC9nzOiBOOof2edkBAM7uSB7JhUH4mvDru0wwnRsjTXb4SLcL8itTMgpMUgdy/wuocNhW5Nrhsw6iV/4KeVHsfEntBzbMmkEIlmrB9ExfFL52KhgHQEa6U7jKU5MrqnVx3WIeeGG80bD8G4zjxF9TktHij0mxzZTDjxDPIrCApNYhrdlYU4xG+ZaNx7ifflFy/Y4VQGNLEqmQcsYSzfc/+jHHD8agmuAYhS303Na7MPBkCXZYBdV9fRD50kIrbASBsn0ZzR+4uECFiGvoFa53JXVHSpqXkzO88UwCXv3FFXFTbFPWQlpjy8E/P9kYLWd3LEkmJUcPGPMtEqmgRcmXR0zKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iHdFtNvcwC1Q2D+9Au15aSdOL+ETgvpA5wL+NrCyDgtbudUGlp9YSrjtph1ybwU33ajxjUlhbXjRCqtfJohU9ZDEqf+ynefhsSJLFaIWKX601icoxOk107+dEfZTEICugTRMbjMNuo0kuin6l1o1LlMUCMAmGoLsrmNbp2kRyGOP5IpgqsKUr+w88KVqMOH/qDDlzlgp9GEEtMO7fpvRwBvSGf4iWKWgpqy2IaEA0NH9cUB3e/XyTyxK+rExMPcmRdis2k5geZd8O3X7UcDdBG55quj7aMZPOKU+SPscYB7HoWkIe0DuPQq6LZfHSJcekiVdfju/Xv7k/ws0lZ1Q3Wvlq3XupZo0aP9QfHvIlRk5ztzFnsUgEMS0ijjCEGdVNL9KAGMfaQvyh86znv81IROJbpqhwdtNRnpGnLgTnBkyAipNp5BN6TKpJ9L1Cnr3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 02:26:08.9189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4b7c5a-c3fc-44e0-47bd-08dee3aac318
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851
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

amdgpu_userq_input_va_validate() converts userq
expected_size to page count by right shift.

This undercounts va buffers that less than a page.
For example, in the AMDGPU_HW_IP_COMPUTE userq
creation case, the expected_size 2048,
so size(page count) becomes zero page and the
"va_map->last - user_addr + 1 >= size" is always true
once the start addr locates in the va_map mapping.

A similar case is AMDGPU_HW_IP_DMA, where expected_size is 32.

This commit calculates a proper page count by subtracting
the start_addr and end_addr in pages.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 969f49592450..f9f11bdf2cef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -25,6 +25,7 @@
 #include <drm/drm_auth.h>
 #include <drm/drm_exec.h>
 #include <linux/pm_runtime.h>
+#include <linux/overflow.h>
 #include <drm/drm_drv.h>
 
 #include "amdgpu.h"
@@ -238,14 +239,21 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 {
 	struct amdgpu_bo_va_mapping *va_map;
 	struct amdgpu_vm *vm = queue->vm;
-	u64 user_addr;
+	u64 user_addr, end;
 	u64 size;
 
 	/* Caller must hold vm->root.bo reservation */
 	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
 
-	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
-	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
+	if (!expected_size)
+		return -EINVAL;
+
+	user_addr = addr & AMDGPU_GMC_HOLE_MASK;
+	if (check_add_overflow(user_addr, expected_size - 1, &end))
+		return -EINVAL;
+
+	user_addr >>= AMDGPU_GPU_PAGE_SHIFT;
+	size = (end >> AMDGPU_GPU_PAGE_SHIFT) - user_addr + 1;
 
 	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
 	if (!va_map)
-- 
2.53.0

