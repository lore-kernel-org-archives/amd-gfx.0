Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58858CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB2110E971;
	Thu, 28 Aug 2025 09:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2XtUQib4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D4D10E965
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsGojvkPC7xs1U3bfvNgoYVelQG0jbb1Xd4TSYZvQKBJZiFou+N3I9OSLxw2n5NcplULcgoznozpVSEi3M3mJh9pCwgBntRGtneotrkCu3qn7df/Is4j/4OhYg9aS5OhZjnKNJUIfHA7xGVde1o0NAqd0X3V0BLpvxYPgMwTC4zlLEKfFeFkaOJRc6SFTh8RiS2zRRwiWEc4njkxLm5D+oapAKM5OromwM5tyP4hukmsdphSIzVtZCxb7ybVLY9JMk07/ajV7skfSqLKi7pTZPTnHecgr4zViez4SLZeTuLeouzTfMt9w07/+swA/yigVIuP/Dtvt8uUHA6Xv0zlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11Lciha5OG0L7wHSCUCXauVNveu/vYKad2JxmTZREYg=;
 b=ppssAMD1KT8L0EFUI5GmARsz4MLjixUaJBXZrN+f08vYebD5P4fjoVPtubmdVQIOePXOabCYej2VTicrm93y4/XUZCwmhYUV0nAK4W9Q4h7XK7Zd8D2gRun30ogo5SaeXk5+r3l0qxiY43gEOrSDVltYsuZluErMV+NeKLig0X0CNQmNoV1+E0/gTAjT0G5ZfB+YpvrpdcXz8QFxcMZE7a9Gw6KLW/GTcwlHcgxx5Cac3bcVg+mK5QRK8q4XZPj3NarBq76B938Fz7GJuNONbN0oXCkBI7LGVA3uZbEKCX78VyuH7RtLa7eAkDD7UGjP1rbRejgbbeCYsya3LWA1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11Lciha5OG0L7wHSCUCXauVNveu/vYKad2JxmTZREYg=;
 b=2XtUQib4iOEWCVQNKHK4XZ5pCvlqIapS2sCFght0Y0XFULSbhYlkkpm2AlKubmCxkYbTvU16YJtGmlE4iPMpATvlLJgdwKw3jhJhDr4U3+ge12BEfhuU5KqM8Hq2KjA/uQC3ErdtqxB8iAm2tsDu8Vkpmv24Wp169I/pQIdzJ0Y=
Received: from MN0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:52c::23)
 by BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Thu, 28 Aug
 2025 09:21:29 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::7f) by MN0PR05CA0029.outlook.office365.com
 (2603:10b6:208:52c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.6 via Frontend Transport; Thu,
 28 Aug 2025 09:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:21:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:24:26 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:24:25 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 9/9] drm/amdgpu/gem: Return Handle to MMIO_REMAP Singleton
 in GEM_CREATE
Date: Thu, 28 Aug 2025 12:43:35 +0530
Message-ID: <20250828071335.3948819-10-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|BY1PR12MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ca3688-136d-4be2-61c7-08dde61444d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUJTbXFxUkYySnJIR2g2N0pIMEZIUUpWSDhnWVFzSWFXSXprQ1J5MjBkc1kz?=
 =?utf-8?B?R2dYSlBqV3dXUmwxT1hNVkVMMHk1Q1VYN05FaUZ3N0tKc0E4Y21ZbTRlMFpG?=
 =?utf-8?B?QmxsWVlzUVZSZWg2Mk5DRlpUSmN4aU1pY2hJcG5CT05MVDZiR0Z2R0dCaDVa?=
 =?utf-8?B?YzNBSGR0VUlFeW9FMWJRQTI4ZVZDRXhtSjNRdlBjVithTklvRzZtNW40ekxo?=
 =?utf-8?B?SzJwLzExQTd5Vkx3Q0UwdTFWMkNzcmpFSGovOEtNT3AyTGxOZlZFaVhCWGto?=
 =?utf-8?B?Q2FyaklNdkt3SC9iS1pLRzRMd3dtL0xLOHlXZDJTUnZZQ0FtdE03bVFNRGk0?=
 =?utf-8?B?bHFKYm5iNFpQdjRXNlB5cGdEMUNLTnFFbnBNSWtGQ2Rtbko5VHYzdWk4SHF1?=
 =?utf-8?B?K04xckp5OUJjY3JVK2c2QXp2dnJNWFdqcW8vUC9WdHlVdVF3VlgyN2hwaU1N?=
 =?utf-8?B?cm85QVpGMzVFZndseGtsb2ZzTzR2MEw0Q29oUFZOc1pQK3Y5MlVONW9HY3pa?=
 =?utf-8?B?MW5VNWdDSG9RYW5WWW1TM3VkL2JTU0RLbnFtaFpnY0FQMDlkckhGTlZsYmRG?=
 =?utf-8?B?S0dUVkFDcHJHdUNnczBuWDFMbTBjVG1CZ0hGSi8rQWpZU1VRMytSaGtVTjRr?=
 =?utf-8?B?d1d3L2VPWnZjRTBKVUppdmdib2x5alhhQ0pRR0Yzdi9DaTdjOFZqYThJZlBL?=
 =?utf-8?B?Z3ZXV1BndVdOdys5ZjhmQjUrcW42eDVRZXh5Vit4ZUl0VFB2ZDBLbUloRnBZ?=
 =?utf-8?B?dFpVUStodnEzZlZPUDZXODJGWGhuRC9WdXY0b2FxRHI3ZWtqQTVTMmg0L2li?=
 =?utf-8?B?dzBTeGtkdUE3Nk80KzMxemo1c1BqUGhNblhycnFaSDVBblEwODN5MnVBMVd3?=
 =?utf-8?B?OFJKSmM4ek9xQkYxSjRQY1IzY1BkTXhjVStBeVphS0VSbXVZdjZ2Y3MzdXI5?=
 =?utf-8?B?SzJMTnFLRSs5V0Jqdk0yUU5tS1duOU1YbG9xUGpKcE1JMm9MbWthMVNsa3Iw?=
 =?utf-8?B?MDBMM0xjczlsaEpYc2FYZ1prZ1ZDL3lGNE4xWlZwMTNRUmhVNWJ3OXh5MDVs?=
 =?utf-8?B?d2tDa3l0cWJhV3pWcHBCYzZDYldwQ2RVQ2xZS3RpRmNVQnpweGdld092MlBr?=
 =?utf-8?B?RHFjdWtTTmdtRGJ2ZU5ETUFtc3FYWnFtdGRWMXlqZjlZY2RlRmpncHlhTXlo?=
 =?utf-8?B?SlZ5OFdKWTA3MDlUUzladUw0YVlQOVROcitPcnQwTE5kVmVmaWNTbm9vM211?=
 =?utf-8?B?SHdlMW95aTQxQldTUHI3K3Vza2I4dWRoZmxLdFh3eVpmQVluWEZheUNvWHdZ?=
 =?utf-8?B?TSs2Sk1BaWtBZXZPWktzbjhvY2RTOVhsQWxOTnhKdkNQNjY0N3lNc0hjaUNU?=
 =?utf-8?B?SkFYbkxyZVlNSzI2amgvZDJOUXdtTE8rUG85MXlsYzY2ZlNGcVpua09jZSsz?=
 =?utf-8?B?RGFzV1pROGpsUFFqT1djQmk0OHJWZkFRYTlYZlJxMmp6elBwbjF2UWVPVlVH?=
 =?utf-8?B?aU5qMFM4L21id0tqU2VGVStOWnR0UHNyMmdYemNDZStzamFRUUZrdmJnNWNE?=
 =?utf-8?B?QnMxTlhzWE1SS25WMnMvWUFwRjJBUGlsL1pkOUI3YUplQUhmVUlsWXlRTVo1?=
 =?utf-8?B?U1RONmtKMk1UZjVyYjhZbXE4ZnlyMEU4V0VEVjFGZjFHQk9MUnQ2ZWhGaXdB?=
 =?utf-8?B?ZG5WV1pMczFVaExsZHMxa3I5cXlaSzcwQjRnbXdvOG5KT1Q5TWVvbkVzb3da?=
 =?utf-8?B?dDR1RXNWaXZCNmpNMmkwYkVsRTZ2UkYwNzQwUSsyKzZwM2JKTmFRYjByTEZq?=
 =?utf-8?B?TmxtcHJQSnN2YVY3K2wzU28rRDBmREFmWFNWNC9pUmJ2bG1CTkZxdFlXdHZK?=
 =?utf-8?B?SktIZnlwaW5rclBoU0RsUUJKYnE4L1dNK3dwR0U3OU80TEVjQzRUYlQ3QmVs?=
 =?utf-8?B?d1IrOTlPcVN1VDNJL0JQdXNnMm9ua1lpNGw0ak9sNXJHa3Q5RzJ4OFdJbXpm?=
 =?utf-8?B?MUpybTNvMkZvSEdyeEFZeFNrVjdIeFZjanRicXVmb2FkaHIvc21qV2hnNGpk?=
 =?utf-8?Q?9I0MvH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:21:28.4608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ca3688-136d-4be2-61c7-08dde61444d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447
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

Enable userspace to obtain a handle to the kernel-owned MMIO_REMAP
singleton when AMDGPU_GEM_DOMAIN_MMIO_REMAP is requested via
amdgpu_gem_create_ioctl().

Validate the fixed 4K constraint: if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE
return -EINVAL; when provided, size and alignment must equal
AMDGPU_GPU_PAGE_SIZE.

If the singleton BO is not available, return -ENODEV.

v2:
- Drop READ_ONCE() on adev->mmio_remap.bo (use a plain pointer load).
  The pointer is set `bo = adev->mmio_remap.bo;` ie., The pointer is
  written once during init and not changed while IOCTLs run. There’s no
  concurrent writer in this execution path, so a normal read is safe.
  (Alex)

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 59 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 18 +++-----
 2 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index d3c369742124..465f9d4a79d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -424,6 +424,38 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
 	.vm_ops = &amdgpu_gem_vm_ops,
 };
 
+/**
+ * amdgpu_gem_get_mmio_remap_handle - Create a GEM handle for the MMIO_REMAP BO
+ * @file_priv: DRM file corresponding to the calling process
+ * @adev: amdgpu device
+ * @handle: returned userspace GEM handle (out)
+ *
+ * Creates a GEM handle to the kernel-owned singleton MMIO_REMAP buffer object
+ * (adev->rmmio_remap.bo). The BO is expected to be allocated during TTM init
+ * when the hardware exposes a remap base and PAGE_SIZE <= 4K.
+ *
+ * drm_gem_handle_create() acquires the handle reference, which will be dropped
+ * by GEM_CLOSE in userspace.
+ *
+ * * Return:
+ * * 0 on success
+ * * -ENODEV if the MMIO_REMAP BO is not available
+ * * A negative errno from drm_gem_handle_create() on failure
+ *
+ */
+static int amdgpu_gem_get_mmio_remap_handle(struct drm_file *file_priv,
+					    struct amdgpu_device *adev,
+					    u32 *handle)
+{
+	struct amdgpu_bo *bo = adev->rmmio_remap.bo;
+
+	if (!bo)
+		return -ENODEV;
+
+	/* drm_gem_handle_create() gets the ref; GEM_CLOSE drops it */
+	return drm_gem_handle_create(file_priv, &bo->tbo.base, handle);
+}
+
 /*
  * GEM ioctls.
  */
@@ -468,6 +500,33 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
 		return -EINVAL;
 
+	/*
+	 * === MMIO remap (HDP flush) fast-path ===
+	 * If userspace asks for the MMIO_REMAP domain, don't allocate a new BO.
+	 * Return a handle to the singleton BO created at ttm init.
+	 */
+	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
+		/*
+		 * The MMIO remap page is fixed 4K on the GPU side. Do not
+		 * allow use if the system PAGE_SIZE is larger than the GPU
+		 * page size.
+		 */
+		if (PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
+			return -EINVAL;
+
+		/* Enforce fixed size/alignment when provided by userspace. */
+		if (size && size != AMDGPU_GPU_PAGE_SIZE)
+			return -EINVAL;
+		if (args->in.alignment && args->in.alignment != AMDGPU_GPU_PAGE_SIZE)
+			return -EINVAL;
+
+		r = amdgpu_gem_get_mmio_remap_handle(filp, adev, &handle);
+		if (r)
+			return r;
+		args->out.handle = handle;
+		return 0;
+	}
+
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
 	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0e301cab74e0..14af9b0b8673 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1854,14 +1854,13 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_ttm_mmio_remap_bo_init - allocate the singleton 4K MMIO_REMAP BO
+ * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton 4K MMIO_REMAP BO
  * @adev: amdgpu device
  *
  * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when the
  * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the host
  * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
- * GEM object (amdgpu_bo_create), then reserved and kmap’ed once to exercise
- * the io-mem setup path. If prerequisites are not met, this is a no-op.
+ * GEM object (amdgpu_bo_create).
  *
  * Return:
  *  * 0 on success or intentional skip (feature not present/unsupported)
@@ -1871,16 +1870,13 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
 {
 	int r;
 	struct amdgpu_bo_param bp = { 0 };
-	void *kptr;
 
-	/* Skip if HW doesn’t expose remap or system PAGE > GPU 4K */
+	/* Skip if HW doesn’t expose remap or
+	 * Hardware remap page is fixed 4K; skip on larger PAGE_SIZE.
+	 */
 	if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
 		return 0;
 
-	/* Hardware remap page is fixed 4K; skip on larger PAGE_SIZE. */
-	if (PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
-		return 0;
-
 	/* Create exactly one GEM BO in the MMIO_REMAP domain. */
 	bp.type        = ttm_bo_type_device;          /* userspace-mappable GEM */
 	bp.size        = AMDGPU_GPU_PAGE_SIZE;        /* 4K */
@@ -1898,7 +1894,7 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_ttm_mmio_remap_bo_fini - free the singleton MMIO_REMAP BO
+ * amdgpu_ttm_mmio_remap_bo_fini - Free the singleton MMIO_REMAP BO
  * @adev: amdgpu device
  *
  * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
@@ -1907,7 +1903,7 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
 static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
 {
 	amdgpu_bo_unref(&adev->rmmio_remap.bo);
-	adev->mmio_remap.bo = NULL;
+	adev->rmmio_remap.bo = NULL;
 }
 
 /*
-- 
2.34.1

