Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD585CCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 19:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4927A10EA03;
	Thu, 30 Oct 2025 19:02:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XGISxG39";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010028.outbound.protection.outlook.com
 [40.93.198.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E634A10EA03
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 19:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRD7jG2Y3gu0nkMoB1yX1nfw9KnYfDzqrYfHW6V3XsQ61Ukhl4nPNuDVVuyZo5673RISrasHZ6uI5rsvXHzIiFtYr702z9r8BFoK6XWfHwYIv+1UE/SADAhOHTzAYxQNPTjDHcKQnFtBSAC34YI+8oLNokb8N1K1lyXA3s4xVwrkKmrD6nG0zSK+rprDsxqu9XAKUCde0qsgnApX5+S8i6cDCcekk1J3yPsBBJirm/iVCs6i1CFJysmLBeOOfbDMAOFn9L7B7rV1bOb+V+DbAyY4VQoBaFeiAHgfFHLBYn2O/V2eTzH1IbiDi5aMo7ic1m2dOc5x45eegwiq9naTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFh8iy8ybth12kjgvN6Pnpxa+Y1LiP0yKyPLza37+JU=;
 b=RPH/anyncLgmq1MtqqTxihBijV64GtpY4jwn9HJD4V+0l6aZ141S7QHDyu9bfIa2f8yvF4D+rwmyHCIlD/u8P0R1uk2m0ADFPLKbIc10Jrgrmyw7Tl/3TrTnCpcAr5oF3Ib6/8qxIqBQTHz3S0wnJJQ7pVFAILEITWe7jotGrPvRxISlOKZCRWlbKEYrmT2uDv9wEMx38hwcGGXCRH6ibK5+qEtLxnqryXSatpoy/msvzQ9nXNaCGcpLjYMSyMj9ar9RrKqqNMaolOJNT0k/SC/nnm9p1C2gSvZBTf3MKgInNgBrucVfvaMCM21LnO/5UUoKnesXnXtvF/d1wWtYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFh8iy8ybth12kjgvN6Pnpxa+Y1LiP0yKyPLza37+JU=;
 b=XGISxG39+UusLbEpNc+oAvHoXRdGNXg5jfq3041/b33npNZrWzek4dyhjczB05ZLPPKb4oQ7tOD7CBBNhy0HekPt0loZV1pno7tHjNFLWHcYJHZ35WNXHkBCNJsTaXyZFWQbjPfHIhRJy1ON21eHoXcJnxANmlg7rQFEp+liWv4=
Received: from BN0PR04CA0046.namprd04.prod.outlook.com (2603:10b6:408:e8::21)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.21; Thu, 30 Oct
 2025 19:02:01 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::b5) by BN0PR04CA0046.outlook.office365.com
 (2603:10b6:408:e8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 19:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 19:01:59 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 12:01:59 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, <Gang.Ba@amd.com>,
 Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: Don't clear PT after process killed
Date: Thu, 30 Oct 2025 15:01:25 -0400
Message-ID: <20251030190125.15969-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ae3fc3-980f-4a42-d92d-08de17e6cdef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amxkUTZPNnVYQzM1U0QzL256SlVKS0ZWVFdjc0tQdTE1dTJtNTc0MnV1VklO?=
 =?utf-8?B?c0dkNitwYTlvZ1I3UTM0Q3YwZ0dLQU1FRTQzaTFieUhGWXRCN3cwR1Y2K0xk?=
 =?utf-8?B?NmZkMGljMjJrOUk3OGdxMnR5NGxaUitha2QvWXova2kxMG4xL05hMkE5ZUVN?=
 =?utf-8?B?RmFlblloWVl2bDhrcDIxMW5vMVVGT3B4c3AxOVZDeEFKejdZeE5nR1I3SVdr?=
 =?utf-8?B?REVBeG5zR21kdDErRXZTQTk2ZUhBZFYzM0JaZXFUbGp2S2IrdVJFUUpJR3ZE?=
 =?utf-8?B?aFo1Q3RVWEJ3NEZBTGE2WitjcjNQR0lTaUNFdUhqNTFFeVZLTlc1RlJjTTRl?=
 =?utf-8?B?ZlZNNVhxU3FoNFplckZPNXZlN2h1ZFF5NDhOK21ta0N4VFRCTFNBd2p1b3lO?=
 =?utf-8?B?MXl3VG5MeHR2dkI4OEhYQWMrSk45dVFtdkx4bGl3SG4xaWFMVCs1cnplQk1T?=
 =?utf-8?B?M3ZzSXk5eVRGdVJPSFRRbCt0QlRWODh2c3BUZkpoejFiRndGRzUvQzgvYVVQ?=
 =?utf-8?B?WDZ6TnpsRVFEVGpiQ20vTmgzOTQxV0pxd0F1d2hsMkVpdC9pR01FNWYvNkYv?=
 =?utf-8?B?YXpEQ080eVFZUTEvajJRTnVxNlpUYnV0dVdSTTd1MUJ3V3hWNnRnVHJzWVd2?=
 =?utf-8?B?Tm9wK0RYN1YvRFhEbU83Y3dyckxIVi9hUmxLdDJQbU1vemd5QTFMVmZ0UTc5?=
 =?utf-8?B?MHN6amV2VVIvcFBqQ1pTellPWG9qeGtIdkN4RHpmQWIwWU9Lci92aE1keWZH?=
 =?utf-8?B?OUd5c0FSQ0N4bXlzVmJzV1NqS1oyUHU1TmliWDVDcktDSVRXRTRzU0VZalZh?=
 =?utf-8?B?WkljVkFTTkEzejA5aVo4VXZ3NjNNSkswZmQwNnBNdXJHUGNLaFpqVi9EVkZo?=
 =?utf-8?B?RGsvZXlTZkYxWlZBcWtjT21rRWZ5UGlKelZ1c3RwbHFlSXNRMGY3aTRzenlr?=
 =?utf-8?B?QW82T0xqR215VW4zYUcyQW9nOGxRdVJpd3BuZzUrT0hpZS9WZkt2QlNuekFk?=
 =?utf-8?B?aHI3d00yUXVZRGxKUmxsUmZkVVo1WU9aMDBmWGE2eUFqTitCT1ZoOUhRdll6?=
 =?utf-8?B?bFVhYnh5TFBNZW00TlFScUpTR1BjSk85M05YcHpwR0hoeVpvSWQ1aHU1TFE4?=
 =?utf-8?B?bnFZeU1UYXdjWVhRUkRIYW1rV3QzbWtuUWVJTHVnMmxWT0JRYWFnVS8ydzFE?=
 =?utf-8?B?SHB0eU94Ni9HZXB6d211WXRyWE9DNW5Pd0xzZW1rSzBhZ2hBVTMybVFHZEta?=
 =?utf-8?B?eVpXelBZTXdHRi9wRlFjNEZvT0g1Wm9EcUQ1aDkwVk5tVkJ2M09GRjRCbnBX?=
 =?utf-8?B?bFA5Q25Mc09tNlV2WnM4LzBURGVpMXFlYSsyWVdhMDNDcStwZ0FGeVlQT2E0?=
 =?utf-8?B?WGdTK0xDRXFnMTFMR0pHblNJTnRVZ01vYnRoZk1xcXdmemlBenJJN0hZZ2Vu?=
 =?utf-8?B?dE03NEtLbkRZNDdhRThPNmNkTFRJVUtMeVAxa3ZET2pIZlJIMDlERW1oa05H?=
 =?utf-8?B?dkc4d0ZZWjBVL2t3T3FkUWtvUEovUG5wQUFhQ3A4QjhETnNZUXBRaFRhd21a?=
 =?utf-8?B?Y2dDTjJRVXhEVjZYQm1SUU5rQVpnVXF2WEpjRlhmVlBpWmZyTS9KZnJvLy91?=
 =?utf-8?B?b2c4U1dGakYzM3MyL3k3bFBOYjZqQnh5QmxFTzNaQWljSW9kbGd0MU1BRUVN?=
 =?utf-8?B?anhWNFFSR2xtN2hYYzRKdXlrek1BRzRjWVFoYjdSRlVkcW82dEpqeDZVZTJU?=
 =?utf-8?B?bE5vd2tjSm5hdldER2UybnBUQmZIWU5IbWR5SzNkMW1oTmI5UlZhdHo3bTVJ?=
 =?utf-8?B?SFp5bGxoL1VSdkdpTEhqSlRUQWlIWXRsRUZDUnNnQkMweUV2b1BBamg1dWhN?=
 =?utf-8?B?bGkxbTgydXEzNU40c0g3cUhCZWZvb3l0WFgrMDRhbUMvaG01MnlxQVk5VnpJ?=
 =?utf-8?B?K2l5UzBJNXJhQVdNZnVUUWUreWpHYTFzbGhzMGdrRWdTYzBZS2VhMDJxYlov?=
 =?utf-8?B?K3FYSnJWaTJIU3M4eXVwNVJCR1p3WmlKZ09rbms5Y1NXeGFYSjkrRFRMdy9j?=
 =?utf-8?B?WklDT1IwUzNLQmkxZ1ZZWEk5UmlOYklvYVVBVGNwUVUrMlM2T3ZacGNRK1R2?=
 =?utf-8?Q?nOK4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 19:01:59.7717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ae3fc3-980f-4a42-d92d-08de17e6cdef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322
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

Move amdgpu_vm_ready check to inside amdgpu_vm_clear_freed, this removes
the duplicate code, also removes the error message "*ERROR* Trying to
push to a killed entity" when KFD release wq unmap_bo_from_gpuvm to
unmap outstanding BOs if using SDMA update page table.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 9 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 2 ++
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ecdfe6cb36cc..6e1a5b922eb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1116,9 +1116,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		}
 	}
 
-	if (!amdgpu_vm_ready(vm))
-		return -EINVAL;
-
 	r = amdgpu_vm_clear_freed(adev, vm, NULL);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index ce073e894584..f6c297d62cfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -373,11 +373,9 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 
 	amdgpu_vm_bo_del(adev, bo_va);
 	amdgpu_vm_bo_update_shared(bo);
-	if (!amdgpu_vm_ready(vm))
-		goto out_unlock;
 
 	r = amdgpu_vm_clear_freed(adev, vm, &fence);
-	if (unlikely(r < 0))
+	if (unlikely(r < 0 && r != -EINVAL))
 		dev_err(adev->dev, "failed to clear page "
 			"tables on GEM object close (%ld)\n", r);
 	if (r || !fence)
@@ -387,7 +385,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 	dma_fence_put(fence);
 
 out_unlock:
-	if (r)
+	if (r && r != -EINVAL)
 		dev_err(adev->dev, "leaking bo va (%ld)\n", r);
 	drm_exec_fini(&exec);
 }
@@ -766,9 +764,6 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	struct dma_fence *fence = dma_fence_get_stub();
 	int r;
 
-	if (!amdgpu_vm_ready(vm))
-		return fence;
-
 	r = amdgpu_vm_clear_freed(adev, vm, &fence);
 	if (r)
 		goto error;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index db66b4232de0..febdd1b4286c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1543,6 +1543,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 	struct amdgpu_sync sync;
 	int r;
 
+	if (!amdgpu_vm_ready(vm))
+		return -EINVAL;
 
 	/*
 	 * Implicitly sync to command submissions in the same VM before
-- 
2.49.0

