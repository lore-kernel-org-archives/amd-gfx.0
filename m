Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34F5C5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 20:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C0F10F400;
	Fri, 21 Aug 2026 19:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5o3i7RPZ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12E1110F400
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwFxk1KPNGMpCE+mUpSexA9u2grTR0JSnL3YP0TLcjE6gNJQS1G4smJ+pxZ4MhX+z0l9U2/fdVjLtCXeDBPK+tCNS8DMfDlJ31vixJA9olgnhkWnt54H/NsM/m05G+66n5wnWwyfeMiZokZBvSCxmXNyhAfEuKAJFuNL5AyxW7w7tttH/k12H0lb4aaINSljaVkgq34SomoEDocyvU7nzfeRCYfPlgQYFTMIw2sKZk70GasxIwp1Krq1fOJMmnHa0pwVXe6su65tuQiNcCpsHBVKbTBxOcR+uYwQyy6RFCFq8MT0FAX/0NsrwmNfTQab/ieHYbSkL3tUdrMdZVoV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oToRd9g74w/IEJeodDIgsxckioDc76/V3sjcd3or4xA=;
 b=VimYD0kWFZuoVAXkcT5MWzhBy7pbmG2CDCBAhVcr93b1FWUBVcIEzJxboiMAG+atPKBJBNGUZ1H4QkG9L5Por6FsXTerZ3xdB05WoyqFboqVNshp8Jv4JRPRax+Wi1eXGUhbU9x2YAoxFTK4pcrhmTxcfBrON8lLCznC8vO1rJjL1VhkxWhW7hQDvMDQmPZEY5kyLGE7ekjvzqzQQWVSFA8JxHN8kw79EsTGO0hoTfyTqGOC3/vdq9QNiJllHkLi2HuopCdPoroIPD+d50cRbtrTvcU58craDt7imFOyX17VW/Gxis42Sw8kEPVBihFYSFYdHBCOxRLUpTpWROMBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oToRd9g74w/IEJeodDIgsxckioDc76/V3sjcd3or4xA=;
 b=5o3i7RPZ5prizP7QCUkGemWPklqBhtEOc7my7WlJ4/iA+vVG7yNFi1wTXRI8fmsm7R7t01EmBt6mTEwo107eFkZaKiqSoEJfF7E7EguuGlwtw6hfej+QEqgZLa1fojSRZEE5/7E/d/JJtTE2KNnQ5D+dMMXJM6s9f2qvPSrRcRk=
Received: from CH5P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::22)
 by SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 21 Aug
 2026 19:36:00 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::3d) by CH5P222CA0002.outlook.office365.com
 (2603:10b6:610:1ee::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:54 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 70/95] drm/amdgpu: Use vm->last_update fence in UALink NPA
 unmap paths
Date: Fri, 21 Aug 2026 15:34:33 -0400
Message-ID: <20260821193458.808626-71-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: f754913e-5a52-4108-4b80-08deffbb6e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|22082099003|18002099003|3023799007|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: tE/cUEuemuvayy0+3KgGAhyNNfD/hp6KmWK7RKadrZaxQ2NeJQOBcPhYUPLsn/GuBsnxNJFAmpcRP9acfPDjPObr6KVdOAZgGJEzlkhEcT8e/DqPSNrTNIIxzGldWRm/BXc8eG9JMovSA+KxBkvzXFDpTAQkN80qOgXmJKuBIfOZOM6dB+GhyXmXUd0sBHAlCgU5ppqbqfbcT2e/ynDME3CUW82RBPAGcIwHMvtpxyrQcuMjZS922vXd1ECihq8/stFR4OJw+M547ErAkMSa4jzA8bLzUqQBWqwfeTYiLN1jNiw3q+DXFKYfclFXps18UbuYeETXc2XZjl9/deJdaW2TQMnlXiEj4Skl5KJlZTJIyYhYhgnx7gGqsWn8SjZ3Gh9LgyR9al5XTmpeff95sY07M3Ut6UQ07o7wqCif9Je8UH5TehS1jX6LAHsxOdwtddP6Wnzd0bkE9kQRsqjQhXWle++IfjMwHAZqqK/BRFIJqf9/wkYKFH8AJQDuFEAhk8SbDpEz3tQ0RoNYeLb0d4r0BLknMZeDHBlL7W3MLqpu0fTXtpL9KTB6yzinukdm2yO9Bf9MQV/Xdwf3X3UpI0mxP3ftRxSVtFxJiLgYgRVyLCasNUd275qbK7bSbtzb0VMoySjENoMEDgjStS30FTYAwwnictotcMztwQ1CFYHqYZX0PIeqWE5jbiER/Zez66jLa2fUqZLrelTTNbP/HQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(22082099003)(18002099003)(3023799007)(56012099006)(6133799003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GJfVY8owtXfa9MlHb8U0bhrYgCUlIH9eX64zJO4pDrKr5Vrtf4E6B+K0AvWodH6AbhPrEQuo6ChLYD/noHPNeKOgfHAscnPGIs2v2+6rmvvsZDDLaqSd4UOmHr1E0D2WdBbNwbZevN2VLsvVvuOlXgsQaf/ZI9lvTzVd6Ebc3IeyrIcBRJImzkuxdotyYQXRfGHTEBMZ9G1q5aWK06HmLSggmZ/vcgO/pXZCqYJVLnrCeKuiW511mY5GbWXPt1H5Rf6gLYLqzu3kttHlkyxqf6iB4bmgwUr/OTsxhsq8u0y7aFGqPEXWroS9LoSWZGTZiorwnegZ7n3TZ4TDuhBQru1gJuuTg8hPIFwjIPYFs4AmRaf9lqL0gCX1SLQdFXfgLHjRB7ZWE1XdAijf2WxJWt+ZvZKXX70067ZG/L4RiuDDJlRGvDGFV5LwfQukv+c8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:00.4078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f754913e-5a52-4108-4b80-08deffbb6e1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872
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

From: Mukul Joshi <mukul.joshi@amd.com>

amdgpu_ualink_map_npa_addr() already uses vm->last_update as the fence
output for amdgpu_vm_update_range(), but the two unmap functions used a
local fence variable instead. This is incorrect because
amdgpu_vm_update_pdes() always commits into vm->last_update regardless
of the fence passed to update_range(). As a result the PDE update job
(submitted after the range update) would not wait before the TLB flush.

As a result, switch both amdgpu_ualink_unmap_npa_addr() and
amdgpu_ualink_unmap_all_npa_addr() to use vm->last_update fence.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 0edfc685b70f5..68faf2a30e0a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1441,6 +1441,7 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 					struct amdgpu_bo *bo,
 					u64 npa_addr, u64 size)
 {
+	struct amdgpu_vm *vm = &adev->ualink.npa_vm;
 	uint64_t pte_value = adev->gmc.noretry_flags;
 	struct amdgpu_bo *bos[] = { bo };
 	struct dma_fence *fence = NULL;
@@ -1453,16 +1454,16 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 		return r;
 	}
 
-	r = amdgpu_vm_update_range(adev, &adev->ualink.npa_vm, false, false, true,
+	r = amdgpu_vm_update_range(adev, vm, false, false, true,
 				false, NULL, npa_addr, npa_addr + size - 1,
-				pte_value, 0, 0, NULL, NULL, &fence);
+				pte_value, 0, 0, NULL, NULL, &vm->last_update);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed to unmap NPA addr (%llx) from NPA VM\n", npa_addr);
 		goto out;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm, false);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed %d to update page directories during unmapping NPA: 0x%llx\n",
@@ -1470,12 +1471,16 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 		goto out;
 	}
 
+	fence = dma_fence_get(vm->last_update);
 	if (fence) {
 		r = dma_fence_wait(fence, false);
 		dma_fence_put(fence);
 		fence = NULL;
-		if (r)
+		if (r) {
+			dev_dbg(adev->dev,
+				"UNMAP-NPA: dma fence wait failed, error: %d\n", r);
 			goto out;
+		}
 	}
 
 	amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
@@ -2082,6 +2087,7 @@ static void amdgpu_ualink_send_tlb_shootdown(struct amdgpu_device *adev,
 static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 				struct amdgpu_ualink_exp_xa_node *exp_xa_node)
 {
+	struct amdgpu_vm *vm = &adev->ualink.npa_vm;
 	u32 addr_mode = adev->ualink.info->vpod.addr_mode;
 	struct amdgpu_ualink_importer_entry *imp_entry;
 	u64 pte_value = adev->gmc.noretry_flags;
@@ -2120,10 +2126,10 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 			npa_addr, exp_xa_node->handle.handle_hi, exp_xa_node->handle.handle_lo,
 			remote_acc_id, pte_value);
 
-		r = amdgpu_vm_update_range(adev, &adev->ualink.npa_vm, false,
+		r = amdgpu_vm_update_range(adev, vm, false,
 					   false, true, false, NULL, npa_addr,
 					   npa_addr + size - 1, pte_value, 0,
-					   0, NULL, NULL, &fence);
+					   0, NULL, NULL, &vm->last_update);
 
 		if (r)
 			dev_err(adev->dev,
@@ -2135,7 +2141,7 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 			break;
 	}
 
-	r = amdgpu_vm_update_pdes(adev, &adev->ualink.npa_vm, false);
+	r = amdgpu_vm_update_pdes(adev, vm, false);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed %d to update page directories during all NPA addresses unmapping\n",
@@ -2144,6 +2150,7 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 		return;
 	}
 
+	fence = dma_fence_get(vm->last_update);
 	if (fence) {
 		r = dma_fence_wait(fence, false);
 		dma_fence_put(fence);
-- 
2.55.0

