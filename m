Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CFDCA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 05:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E74510EB3A;
	Fri, 29 Aug 2025 05:55:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iAHKsau7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8BA10EB3A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 05:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyClYWJ/mhDJ7dy8ZnNMz6QAvWa21RO+OznDZGT8JtUvE++MUhX6DUspdiKalAdUr70n5nTmVGheslBzFrimpEfcZE9AJqvA4Wa1giHKQHdlsSKxRip63yq7SqhviyqCVF1utjPYclCVE+NT7fO/IvZnKbkVrOK5LucgVe6bBYNQhMN8Hf6qLfaU3w+I+udFLArlYgD2ZPqC30hlfauTf04YARPp2Q08HGB0xLesI1cN+PmJqDPZRu9GX6WPMpR09B4TJxRNEM+yufndakYUmkpmkhIYDNZmMb+/PlAaVTUTDUjItsvOkM/RZFb92wQswCA5I1MV7wE0sylwKf2Ipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSpC7Nd9Ixc0NUQJQA+st5mPhaSjpKylkMpEy/z4fbQ=;
 b=i11sgjewg/L5RZ2XFeFng7Sn21lAtgQzsmVfmUYgPJVqkk4+festAw8Sjk2jmKRB0izamYoSe3G+qca/lm7VRpJttGoQ1Go1cLR/sM3q5fkvGb6KaH3+fhpZAuTbiRPnDxRYhEwViCgXTSt8rVx7qALx/I2CSuD/+a+2pIx+iku9/jflXfEZQU4K8k5gwIuRaZflJkYIE/LxBETekUVOSFTdNmNEgojXGlanzIq88VjnvaUqLr4jjuFL6VZxFVQRUNT6lI/ZYMq43ZXtlfKqjADLs0BuIWpxCQb96fnX353rQNxGChLW6qOfOuTcK/Hr3X7h8bqhUvU7OpfFMybAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSpC7Nd9Ixc0NUQJQA+st5mPhaSjpKylkMpEy/z4fbQ=;
 b=iAHKsau7PNjNdBaxnx9TdwobW/xbq+zaN0HqRaS4M2qM8RGR6C0NUUlQ/C+pfJOkBRh585TxZVs1dwhQJtgwCtOykVO4wLUtE0ptlyUECJUgJrkRS3lryXSZgLdY/gJGRjHucb2hwGlhcvDj0394k2N4QythHi/NfOJSKBgc4B8=
Received: from PH8PR20CA0022.namprd20.prod.outlook.com (2603:10b6:510:23c::22)
 by CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Fri, 29 Aug
 2025 05:55:30 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::f5) by PH8PR20CA0022.outlook.office365.com
 (2603:10b6:510:23c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.25 via Frontend Transport; Fri,
 29 Aug 2025 05:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 05:55:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 00:55:27 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 22:55:25 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 8/9] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singleton
Date: Fri, 29 Aug 2025 11:25:17 +0530
Message-ID: <20250829055517.3983597-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ed4176-c4b0-4be2-1f26-08dde6c0a8a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDMwK2hBZ3JwOVJkQ3M1R1ZGd1NXNExMUUJEeXBOVDY0dG8rTGd3ZXdaVHhF?=
 =?utf-8?B?S0JWR2toOWt2YTNnR3J0N2kzZXdaN3VIQWZzak5NS2hXb3ltSlJGTm5QVjRF?=
 =?utf-8?B?MWxYZ05CZ01CMTZsMk5BNTluMnRRc0FsRjRxWk9ScmxOem5ldWtzQVZrSndW?=
 =?utf-8?B?RW5rSlpQaVl3SFJIMmJIREZIQmIyL2wySHVpNHliSUhvSjFyaFI5UVhmYlhL?=
 =?utf-8?B?U2ZuUFl5NDlIQXdBTy83S0tIbGRTTVF3L3dZc3V2T3JQRXhLeEdRRTNydWk4?=
 =?utf-8?B?bmxENmFUTXJpNDBFT2JhR3VTZWRCTGlNb0NqenJHcUNUT05DMDVsSThPMjR1?=
 =?utf-8?B?Y1lGTWZJVVg3dzVCZFpLKzR2UzJ5YTFPRGkwWjVMOTAweXdWUnJ3Y2RaanNO?=
 =?utf-8?B?R1V3QXk4YnJld3Z0ekVDOGpJaStlL040VG8yellmcForT1BhVGg0WUs1M0JP?=
 =?utf-8?B?VVovSjgzNkNXL09QVjVtR2tmZzZBMDNza0RnbEtRRkZqQ3VzMCs1ODh6VnlS?=
 =?utf-8?B?QVpkQytYWm9oYkVseVpzajgzYzM1K0d3NW1IMFhJeHFxSkRKamQ4QnJkUFFW?=
 =?utf-8?B?YTlpTmlIVzlzZmJKM2Y1VEFQRUM1azUrQzVpUWllNUt5OUhEclh0YzlKci95?=
 =?utf-8?B?YUNTY2JKYlpHU2pBbmxFS2EveXcvSXFuMFBlMkU5eU51SXQrSnAzeFFpOWcr?=
 =?utf-8?B?bnlrbVRUUkFLdm1xQWRRZ0M5dWltZmFJTHBoaDl2dzBOSm9OdkIyODBkZXBT?=
 =?utf-8?B?L1FWSDc3azgwWnNOcGFrM2hyMnNzWFZvZml2VE9vUk9neVJrWm5WOEhtNFBN?=
 =?utf-8?B?c3lMRzJlKzl1UFI1S0R1VFZLbnJ6MTM2cTl2bW02TVFCSDZJRjNQTTVFMGZK?=
 =?utf-8?B?VW80M1hhMDVGbWkwcmhHN0p1L2dKNXErRGtvcTVzMkM1Y2E4VzlndEFtM29p?=
 =?utf-8?B?TTJKS3Z3RjRyTEE4aXJWV3cvcEFuT3dPaGhlYzFNYmhVcjlrb1NDSHJERVJj?=
 =?utf-8?B?MFFCQjFKOExxK0w1Z1NCck5WeEdvQndSSzRoZmNzY0RsRWU2RjdBY0QrY3la?=
 =?utf-8?B?QkZoNVp6YVJhVTRUQU1TeU83dUpnN2FGd1JCUVJQOE9WUThVYm1mOEx4bytj?=
 =?utf-8?B?VjNRS3pNRXZYN0hNd202U1lwejhjZWpVbjlXWkszc3ltcnhyM1NNMGFoMDlL?=
 =?utf-8?B?TFZMU2hLVjhlcWViZ1dCVDBRbmVVak5DSElzTnZxOWlWemdrUUVuSUxZTFBv?=
 =?utf-8?B?R0puL2RVbS8vY3kxcjRQR0grOXRSbGNGN0tkb2R3aHdLZitVcloxc2hkUHJx?=
 =?utf-8?B?azJTeDVUQmVQeGZKQnNaS3laN0hTU1VFenVrYVl0eHN1ZkxoVXFGWTJFVHZh?=
 =?utf-8?B?dXNaYWlVWjhPK3ZEZk9sUzNoQUhUbjJjTzl4aEpSMFVrR0hCazU0QWlaL3hk?=
 =?utf-8?B?N0xVZkVud0pBMzZpVUs2YU1BL0ZDUzBPWEdaZFlwbVFra3BGVUFGRC9MY2RV?=
 =?utf-8?B?eExyWlQ1VUpDWmdvS1Zmemh5WmorSzBWNU5vVlAzY3FOd3RqM1U2RGlIRnVQ?=
 =?utf-8?B?K0tTcFJWTkl6Z0Rsd1FDbjVjaDJsODF4c3pkMUROak5BMjFRY0Zlb01TbjZ2?=
 =?utf-8?B?bkF5UzJNYXNzVU9vRHJOcjQ2amJVOThJNWVORkxHQURmNEpyWmh4SkJha3M0?=
 =?utf-8?B?d0lwV0RLbWFwSGNqa0NqVWczU3RuUmtxbWVTWWJuN3Fvc3VuTVRBK0srTUJr?=
 =?utf-8?B?VXJBMXlOcEUrVmVwVWllS3JhYmdOb2d1QTQ0SlRJS1hMTXhIVW84RDh4OHVu?=
 =?utf-8?B?Y08rZklRSjFtYlNocUxqbFpkZWUyeElIbVZCVjh0cFMxR0RBVnBJWGdTbG9k?=
 =?utf-8?B?Y25SUVB0Vkh4b0swZjRDMC9YK2VKSFd4bFpsN2ZsMkNlUkp3TTJCUEdKdDRk?=
 =?utf-8?B?Z0RCejJwT2FiVEdxdUR0cnZjYzZ4bnFxOGt1K3dYaXFEMVlGbWI3NXl0eUVI?=
 =?utf-8?B?ajlOQStZV2pXTDNkNW5NVHBETVV6TDNJOUFKcEwyMDh5aWczNklDTU5QZWR1?=
 =?utf-8?Q?JXtI1J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:55:29.3227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ed4176-c4b0-4be2-1f26-08dde6c0a8a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155
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

