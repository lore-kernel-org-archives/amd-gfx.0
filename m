Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76137606A333
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SPdagKGL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E075C11220C;
	Thu, 12 Nov 2026 16:44:29 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013046.outbound.protection.outlook.com
 [40.107.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE9411220C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 16:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uREbh0KZN29o2uGcju24IVenLHQRNScPrGfKy0HGamuTMdpsok8/KYeiaF5VRBLb5YtjkKAhBXERsHT6EWIhOuendwSIlNK7gFyRkH4DUFpcnz3BtTWn6a2WANUi1ZL9GNvXLEMOBms6eWjdviAZUtSf9ZtZxauwb82uuTnIWDe4z3/gVESqfZr5xzd5gXgOw/3iTxhdBVFXeTwJ2SPde9F+rLAy2RwMhSRUCgysvfEpraIfhAoPsyzRB2kUh95jUJWUD5wSAmjYwhTUFgOFTFYnaj1CCeGbZULYJdK9B+G8/FTB3HtBTD+YvStRCtwKRB/ACnKjN8Tg8d6t/NHd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0KwFDVnw7shgDhFjLs9OM6GxgjkXS6HQDVNjUzaPjw=;
 b=LaXrFl1G88UfW5HA8GW9rG8b+Enl58wckYk54LyOc0MzExj88sVBFDhagZWlHtsqSMXTPd0ukf/5u6PtJjAb+ktleoRDcA986dIhGhZX7GLwFQl0toAbZcNO9aW97xZ8HsH091W4e/6mHEDVwhDLUaQxhhH6VDbLrQF1WamWVfShZTP51Y2Fq3zzy4C3TFurC0xrnDQudulXQlqUSlYTr4IhvERzwPeiDFwCtduG507bYKKS6fHejAsCuYoNtrA4KcYHsI91GFtXnmpsnTYTWHq5izbNNheHAlhgjN4nqSY453JDQaTM04+XmZwAsSn2POkXV/mhWoftjj9NPe4KtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0KwFDVnw7shgDhFjLs9OM6GxgjkXS6HQDVNjUzaPjw=;
 b=SPdagKGL0E7pGxLt7G9fTUv/o6Myr3yqMr2mnYmUOv3DlyfRcZGpNWBqhnoLakWRXVydA38i7cy23JPidWOI+YQTBt60717Dbjsa8EkHPCNbEGJlNYUsF/61VC78Bsd5+r/CO6JqvCJGKwzweY3X0Nyv7oFTet6oeqzvjeuBVr8=
Received: from BL1PR13CA0010.namprd13.prod.outlook.com (2603:10b6:208:256::15)
 by LY0PR12MB975187.namprd12.prod.outlook.com (2603:10b6:404:22d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 16:44:20 +0000
Received: from BN3PEPF00022BBC.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::57) by BL1PR13CA0010.outlook.office365.com
 (2603:10b6:208:256::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 12
 Nov 2026 16:44:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BBC.mail.protection.outlook.com (10.167.248.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 16:44:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 10:44:18 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 10:44:18 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/vm: stop using amdgpu_bo_fence
Date: Thu, 12 Nov 2026 11:44:06 -0500
Message-ID: <20261112164408.1748006-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014022107.2511834-1-benjamin.cheng@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBC:EE_|LY0PR12MB975187:EE_
X-MS-Office365-Filtering-Correlation-Id: 594b30b0-25cd-46c7-7988-08df40dc32c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iJyQa65sMJr/IgPaIQnoLoz3WXk2MC4UzDdd/VgOWAP2jiCwmUXZvbMrXdziCuXByXegfIQCALxOTIwIVCYIGrrbVLuKdnv2+kqZl1xCs90lcou6QhEwBEBNbGDmAtUWiEI8yTcUu83JbRF89VGix3L3GC7TiF4qxQI3JJdudnKkI11of5JEwep6USKehGPANTaHvwwCHFnlAs/lOuRh79zq337JC3xm/usIceSX8tFyRxPvNzceOnVMhMpjNXKcZMCmuUiMncQMcmJPKTAq3iZz33BFssG7N9yPlPw9nh0u3FJ3xiJQ0Mut/fcqDb3cR5oiUWw3EEPdntOzwsAsQnmx+ncAmv/xDnLWzuFgRWIj7thKxnA1xZyraavkBYdO7uHwy68natckj+EnKiNHvwsUrfr5LOaGErBQMrb57IWXGUrajNDZGf6APMgtiI4eyE2mFisF1q8s67WlVAX52g0wPSFkPnAti5dGO4GWui+KQsCM8ByTC4rlPwXw7XStABvb5ZCahHAlUSEiH5leHQtqjVL3HyQNKgT+uEZbkmPCAcB3VaW1lGkxMuIqnSHx8i9tRTl+A9RTeRQ3hbyMxIDLc7IspUkAgrJvyZHQzUDEo8XuEefVlYK8EjKhs+KcWc0YElT3B+G+phlpz4jzraYHYCVBMIHr+H5u4dn/BcDnSvpwOpFNihrTM3dDyfnr6W1z3b6yD9Wvuj4WIopdRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jkbZgHgQl91YNtJwDUa8UxM9UmEJdpjAoNDBVIXD7DFUAaVLqJYpaDHYiIX/zfUDXi7Pg2SeGhlQ596kVtAf2aASUI/0cSP5qPB8UZI0wHOkDwcB0vsxjeP46QRmrvtXtPJh5Z+rcrYaXkgWg+XZIVVadmBJf4TMdc2o6g7gfeGzg/lNkZoCdISeUlTFMB4W4WKh+LONy3iaDmwoBLaYrkPti+YzaYwhD4xhLRJ0wRjG8Nz+YdNNmghUcXvOQk0hxI1/lwp0eJRs6WKu5T39ZuLSfNRglWdPLdl1g198OzfuKX8hcrt3dobbgKbVw04wH4MDLgD/Z2QDfN2HFf/CmzqRPaATSWbmPIWjnFl6q64/VoijxjRmy/eCkB1KKpVU3xZXh21BIaXl2lQEMCip5zaVKwtKqnKQ6wZlYBg+yjJKMwa0Vl0AWlDnyI3sbM66
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:44:19.8313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 594b30b0-25cd-46c7-7988-08df40dc32c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB975187
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Switch to stop using this deprecated helper.

The original could be incorrect under certain circumstances, since the
amdgpu_bo_fence only reserves one slot, and at the time of calling the
SDMA commit and TLB flush fences were not added yet (the reserve_fences
is not additive). In addition this allows us to switch to use BOOKKEEP
usage.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 94b1cfe05e3e..fe6f2fcb88f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1212,10 +1212,18 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free;
 
+	if (!unlocked) {
+		/* last_unlocked + SDMA commit + TLB flush */
+		r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 3);
+		if (r)
+			goto error_free;
+	}
+
 	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
 		struct dma_fence *tmp = dma_fence_get_stub();
 
-		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
+		dma_resv_add_fence(vm->root.bo->tbo.base.resv, vm->last_unlocked,
+				   DMA_RESV_USAGE_BOOKKEEP);
 		swap(vm->last_unlocked, tmp);
 		dma_fence_put(tmp);
 	}
-- 
2.56.0

