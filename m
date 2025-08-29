Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14162CA0FF0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 14:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B7C10EBCB;
	Fri, 29 Aug 2025 14:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jCf8tJ/Z";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C86410EBCB
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 14:05:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCdC2Ljjyqu8te37OkYUKeXYo08LJkzyrVsbFZsnksd/M/HSHf0ZMSmG6E9jKuvnPaCdOR0+xdrtlvjIzXWxNMKSUWUCIRptRb42kNTmLZARFLHaSwYj9kBR4P29+J3ckkx+zQW8Q6R4N1nhP7nFt2+pFPhOTkGH7to+dRSPAtQwlNiiH5JpKh5A00CqNyeE7daPgO8hSpAFvjv9NAhfDBAcSrF65X9zXEVrLcDUdMt5zE1LMwn2G7s/wfDv8rIoPCp7NPoM3aRtW5Y1uUWoWJBubsdydgZbn0gFcHbIzdFHBgCn9SRSbttbSzuWKt1LDMe0X5LW2b1sf9Dcc7wUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSpC7Nd9Ixc0NUQJQA+st5mPhaSjpKylkMpEy/z4fbQ=;
 b=T+jgx5nP2vpxgIW/TZBMtVYu9/CwjVOpxjaCdkmciulUWlS8Lgd4JDrzc//W5PcUh4vjT/mJIr1gGZ/Q5n+BoaMs9VXGk5gZw5BZptNiW8hM0BVt/xEdn4a00SLVHonnGYHNJ5P26nph8xwg3FF2TXRc9nIqXy/f/wGQCLi9VkRJ+MIas/NGbjCzRpthPhIqBEi7MC8rAVvlFyhCeO8P/k5i3+/WDbBgNdESERT6CwrBjxKjw4VsF0tNgZ1z2Jeun6HFPvt4qQlour9jK7Ok/TNt+X1JaBW37kDqlC831a92aTyT1NVJAS/p8NE6T5DZCCYvzFOvMm4waT6C0zR8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSpC7Nd9Ixc0NUQJQA+st5mPhaSjpKylkMpEy/z4fbQ=;
 b=jCf8tJ/ZHzufZAbQXTNvIjSjuqiwbUmyOhNMKWGwHJBXbLzzJYcE7sj8xqdnwyaX6GiiNZMP6SyuYLRldryDFj6drZgSrjpoHgOm7gWJY0n3fLwEk3hCPhPhYHw44+P8dOvWYo/bFY1k/tdojG2qvm4iMi8ruvJ9Kf6KltX06xY=
Received: from CH0PR08CA0029.namprd08.prod.outlook.com (2603:10b6:610:33::34)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Fri, 29 Aug
 2025 14:04:55 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::43) by CH0PR08CA0029.outlook.office365.com
 (2603:10b6:610:33::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.20 via Frontend Transport; Fri,
 29 Aug 2025 14:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 14:04:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 09:04:54 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Fri, 29 Aug 2025 07:04:52 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 8/9] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singleton
Date: Fri, 29 Aug 2025 19:25:22 +0530
Message-ID: <20250829135523.4032168-9-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
References: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 1152dc8a-b0ac-41a7-d34e-08dde705080f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjJydGY0SHpzTmdobFFaalUvcjEzam93Q0gwcUZ3dTFMTlgwN3NFeE9XbERC?=
 =?utf-8?B?QkxMOHlyZ1dBbVQwVHc3ellqODFXNjdNajZhUU5Pc204L2lCU3Rpdmd3a0dP?=
 =?utf-8?B?dURHTmUvKzJoWGZIUW1ZaHBvOTdIUXN3VjNLTDBsY1hNVmt6RElvWk4wYStx?=
 =?utf-8?B?RVNNOXlLQU1pSS9oMTQrOGdOZ2h1NDJmdmkvWVEyd1FCMExvTU1sd0lnRVJ4?=
 =?utf-8?B?Tmc5anY3UmVsN25VSlpKTXhrUnE0VDhtdERPWG5XMTlIYjhsU2U5ekMvemw3?=
 =?utf-8?B?QWMrTzFpV1FYbTlHNzduNXBXb25mN243VlpncENUR2J3VnJIaDFZUU90NDMr?=
 =?utf-8?B?ME5UaXlwNkZkOWFndWhPWFFJV1FOOFErVUJxQlZIZXpqYXpMcnZySFIrMW9F?=
 =?utf-8?B?ajNFNERseDQycFRxZ1lUbFZpaWlzWlMrcjRCSnY2MXo2ek9RS3l5WmdXSksx?=
 =?utf-8?B?REpqajNRUVJhWGxjaGZjODhmeUtueXdVQlJuRHhtdXlsSk1UZzRUd3R4VW5W?=
 =?utf-8?B?Q0s2bUQ2bWJqV3c4STZmSExEYktLaFRaTEVhOEFIa0dhRVBwZ2FqOEtRUmhO?=
 =?utf-8?B?NXZqamtVNGdaSy9OVExEalQxVVozejA4N1preEdNSGxZalhiUTRtYklRVjZN?=
 =?utf-8?B?L2FWMFc5Wlh5cExoS0lwVlNmZGIrM2h5cENwLzlqdXlLaFVFQnIyYW1Fa3M2?=
 =?utf-8?B?MVJ2VnlPOWdsWS92NndRVlh4KzVzWmJ1cGlmVkRsY2dIR2o1U1BrYzFiaEhi?=
 =?utf-8?B?SmxPbjRSd01XYW9aZTdEcjA3blByZ3crWlRMbW5pampxOXZnTmU1anloNnAv?=
 =?utf-8?B?bWxJOUo0Yytja2g4ZDc4aXJKTVBUcUlGUVdvOGEybTdWdGx6eVdqT2s2dHEw?=
 =?utf-8?B?OWY1eVg0Lzg2ZFpVaTczclRCYjE3Tml4ZDg2aDhvNEZBSkV1T2lrNktkMzk4?=
 =?utf-8?B?RzhxSWlqNXZSSUtvck1oSGM2NEdjUExwNDR6UG1tU1lkaTRLUHVTUUhXclA2?=
 =?utf-8?B?WXJzY0FqbkNXTmtCNGQzZUluc0VsMWN0akdEVTJSL2dJMm5uMWlreWJpU2tE?=
 =?utf-8?B?dkg3QkhWVm05bE50Vko1Q0dZUTJnd2x3YVhHSjJPS0Q1eGkrSkFUb3NZaUg4?=
 =?utf-8?B?TllSV2NYZ2dNUkIxaUlvTHhvWVRPT2gyaVFQTUFDTExZdG9uNk5pUjRSM25s?=
 =?utf-8?B?NmNqZTdtZlcvdnZUTjhiMTdaakFZMXRRTSswYUxWQ2dUalRuK0lab0xkWVhl?=
 =?utf-8?B?NW5nZW1ybzRpcWxLZWpHU1RNQnJ6ZnczRHA5TG42VWVkcUw4V1Nnd28rVjlQ?=
 =?utf-8?B?QWk5WENvd3pnTnN6Q3JvbWxKb0lpN21NbFNNeHpXV1Zwb1hoMktjcEloUEI0?=
 =?utf-8?B?RmpMYWpyZWZMcHhSM2RzVW5DYXAxUTR0UjhRWUNqTGpDaGx6K1l5eVdoKzR4?=
 =?utf-8?B?VmpRUnptbTRIMWlPLzlpeG9lZG5wUDI2QmU1QkdIaXBWRndYY2MyNUFZOHFl?=
 =?utf-8?B?T2ExUVd6aWxPMWZuNnBWZ2lDS3V5d09makYxUVlnT3BxQ3BVZ1UxREY5SE1R?=
 =?utf-8?B?QmhEKzhqeWk4dXNJNW1RN2s5T2FabGtYckRHazVrTkZXczNCNGptbDNNM21K?=
 =?utf-8?B?MUlzcWk0L3RtUjFVeE1TbEd4bGwxZzlaMlorVFVIVnFFNkxRRjRFa1BFYXAx?=
 =?utf-8?B?d3o4cW10VnBITXV4Qm5UV3Y5OEVQVzZOMzlwVlNLeEVjZllVQ0tGRmJ0ZDlC?=
 =?utf-8?B?R1ZCYlRYNko4VjBrMjlFZkRsVVAwNFVTc25JY2lFRGpEbHRTMnZHRXZKOFFo?=
 =?utf-8?B?Mm1FQzFId085NXovRTdyN2tqa3RGRG0rN0R4ZnV0NWdRSG5IUFBZUXRtOWoy?=
 =?utf-8?B?YnBiZW9mUW9jWnZkMCtSVUo1TVZPMFp0cTRqR1RESHN3M1gyNHY5aHRFUWxz?=
 =?utf-8?B?UGFlaUxFUU5PRTV6QzRTOWZ6ak5XWjFBcm53REJzdzFsdEdEZVE5QnVqOVhl?=
 =?utf-8?B?eE9Mc2JGTjk0V2VRVGkwTE9XenNrMkEvc1YxRnU0aFlYTkxhK0dqY1lWK3pa?=
 =?utf-8?Q?7/YTEY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:04:55.2025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1152dc8a-b0ac-41a7-d34e-08dde705080f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425
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

Add amdgpu_ttm_mmio_remap_bo_init()/fini() to manage the kernel-owned
one-page(4K) MMIO_REMAP BO. The allocator runs during TTM init when the
hardware exposes a remap base (adev->rmmio_base) and the host PAGE_SIZE
is <= AMDGPU_GPU_PAGE_SIZE (4K).

The helper is idempotent (returns 0 if already allocated) and only
returns an error when the actual allocation fails.

This keeps MMIO_REMAP lifetime handling localized and prepares for the
subsequent patch that exposes a userspace handle.

v2:
 - Check mmio_remap bus address (adev->rmmio_remap.bus_addr) instead of
   rmmio_base. (Alex)
 - Skip quietly if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE or no bus address
   (no warn). (Alex)
 - Use `amdgpu_bo_create()` (not *_kernel) - Only with this The object
   is stored in adev->mmio_remap.bo and will later be exposed to
userspace via a GEM handle. (Christian)

v3:
 - Remove obvious comment before amdgpu_ttm_mmio_remap_bo_fini() call.
   (Alex)

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 57 +++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7305d40a62e7..23510aeb4a1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1853,6 +1853,57 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
 	adev->mman.ttm_pools = NULL;
 }
 
+/**
+ * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton 4K MMIO_REMAP BO
+ * @adev: amdgpu device
+ *
+ * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when the
+ * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the host
+ * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
+ * GEM object (amdgpu_bo_create).
+ *
+ * Return:
+ *  * 0 on success or intentional skip (feature not present/unsupported)
+ *  * negative errno on allocation failure
+ */
+static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
+{
+	int r;
+	struct amdgpu_bo_param bp = { 0 };
+
+	/* Skip if HW doesn't expose remap, or if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE (4K). */
+	if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
+		return 0;
+
+	/* Create exactly one GEM BO in the MMIO_REMAP domain. */
+	bp.type        = ttm_bo_type_device;          /* userspace-mappable GEM */
+	bp.size        = AMDGPU_GPU_PAGE_SIZE;        /* 4K */
+	bp.byte_align  = AMDGPU_GPU_PAGE_SIZE;
+	bp.domain      = AMDGPU_GEM_DOMAIN_MMIO_REMAP;
+	bp.flags       = 0;
+	bp.resv        = NULL;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+
+	r = amdgpu_bo_create(adev, &bp, &adev->rmmio_remap.bo);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+/**
+ * amdgpu_ttm_mmio_remap_bo_fini - Free the singleton MMIO_REMAP BO
+ * @adev: amdgpu device
+ *
+ * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
+ * amdgpu_ttm_mmio_remap_bo_init().
+ */
+static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
+{
+	amdgpu_bo_unref(&adev->rmmio_remap.bo);
+	adev->rmmio_remap.bo = NULL;
+}
+
 /*
  * amdgpu_ttm_init - Init the memory management (ttm) as well as various
  * gtt/vram related fields.
@@ -2027,6 +2078,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	/* Allocate the singleton MMIO_REMAP BO (4K) if supported */
+	r = amdgpu_ttm_mmio_remap_bo_init(adev);
+	if (r)
+		return r;
+
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
 	if (r) {
@@ -2090,6 +2146,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 
+	amdgpu_ttm_mmio_remap_bo_fini(adev);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
-- 
2.34.1

