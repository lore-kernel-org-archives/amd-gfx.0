Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26C6CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 15:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A5F10E790;
	Tue,  2 Sep 2025 15:02:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4OhxgdJH";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C04D10E790
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 15:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Esk67cg9YV83EMLvIL4QSUlFbhdfPMGO8PXy7Q6fHHRgwc4SGZgkJ90vJJajjXq5uDgOlqE2LhkubNTo4be9Rrrqnto/vKbnDL1rK0I5cc5CW0Ia7Hy3BL/r64CArKS/CDW0fXS8ruMq9kgQhL+2/++e+LgXk0MNPAiMNtITR/4mT8W5vRgTe9bm7Lgipm2Km5Cjcxphli2Us9b2xPZXQEc5H7ypOG8mutS3RY0uVGslY04+25RS0Gv0rQjKAqFopfXzUqNDGsbnjao9s+WFVWYJ8dsxuZJk7yrkPR1d3W7nZNfpN9j1fa4wxkZdCY9m8rGeecLeEM2Fyye8RxHxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCMfhWI1018IwrD1cNleU1ePpJggxP6ZeGx0Ds3ilAg=;
 b=lJvOeYf0HWRsDDLe1/bBeUvNo3OdFN+PbnTov8LyG4Tl5LWEAIe+QhNwHxx8C82kiklF5/RxgXX/x7DRlSRpkkF1kDIjn/Zinigv96oPtfxw/cHhIdKMjUras948xN2V/bUB+vWX4ENQzq4zuLbI+B2yXMMyMoZJv9NNr8q/zOOmTKL/+Tn5c33JhB4e8hGoSFtsqUm8CPdKQzDw5cQa7kSwdlOQcRwKRdDYmUpxc6+05zt4jDMEfkmcabHJMd2Gqn2yIvb1lBQgnSNqQHEzsypYyPeFq+CmZu7xSdGKharrrBmtFQ06kLBC17TYw8ZOtH4KhfIoeH951wBAy2ZmuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCMfhWI1018IwrD1cNleU1ePpJggxP6ZeGx0Ds3ilAg=;
 b=4OhxgdJH6Ztel83rbm7HXbPIuMUp4d97j1uWKBKQZ4z4NO6aAOY+a/qd+hL69YjyasAH1b9HGdMAjrQ/Hu9b+SXChU9hZg5vZchp4+FhjtgeO2MVAxX2TqEdkE/tM4rSJraDhB3qT+KzgInunKy6Hf/vksu4KghB40i8Fz2qvys=
Received: from BL1PR13CA0230.namprd13.prod.outlook.com (2603:10b6:208:2bf::25)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 15:01:54 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::a0) by BL1PR13CA0230.outlook.office365.com
 (2603:10b6:208:2bf::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 15:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 15:01:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 10:01:53 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Tue, 2 Sep 2025 08:01:51 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 8/8] drm/amdgpu/gem: Return Handle to MMIO_REMAP Singleton
 in GEM_CREATE
Date: Tue, 2 Sep 2025 20:22:13 +0530
Message-ID: <20250902145213.486199-9-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
References: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f54e2ec-93af-43c9-a06d-08ddea31a761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1RpekhxQ1JocVY4QTBua1grVTZwc3hwWm82cUhvZjMxZzIySXdXNDRRQ2d1?=
 =?utf-8?B?K3kvSS9rV2E0UGdVTUVBaW9mcGNmc3IwcjdMei8wYjFKR0Y2WC8wNE9sV21W?=
 =?utf-8?B?bkJhTWoyWGZQdWkzMENhdGw5dWxkaHhHRm9jcWZiY0I3RWgvK1RpS2cvWGNi?=
 =?utf-8?B?amxkTEU5OEpBd1lISE4rSFcvOVBRUnQzQW9lOTVuamM3aVlGKzcyczI2Q2pj?=
 =?utf-8?B?UmtnUzVyelV5Nm1SNWRpeW1mem1zc1ZJYkNub2dVTEEzZER0aDkwNjZxOEo2?=
 =?utf-8?B?dHd4d3VLV2k0VkJpU2dCMTMxdEk1d2dicEtUU0hmR0d2TUsxUmNFVEhYK21s?=
 =?utf-8?B?N3N4ZVp1TGpGVkMzT2ZFVjgzSDJSSW9yUkZjNDdTL3VMNnJLTCtLUWZXR0xB?=
 =?utf-8?B?WUxMQ0o0RWl6TTd1R2NSa0FRSit1Wi9TSXRIVG5rU1NvdUMrc3hiNVFFUGph?=
 =?utf-8?B?VUtNUVhCZjFjd3pnRXFKY2dlQWdmUHl5SUloVEpHM21YVUpHd3ZHOVJRVE5M?=
 =?utf-8?B?aUtPLzlPaE9QcUlLLzYwUXRqVHhrVm5HdEhtck1UdGFacnlYRE5DYzhrT0l5?=
 =?utf-8?B?clZyR1h4Zm8wQXNTSFFwQ01ZRTY4Mm5NQlFJaEZia1NWaldBV2kxMFRkT05x?=
 =?utf-8?B?SDl3ck45bkwzU0pLaWhCY3lYbEttcldNV0JmQkc2cTRTOXB2cjQvaCtBTmNh?=
 =?utf-8?B?azYzQmdrdlBxVDgxcm5ReXdZKzU2MkFKY05xa3p4bnRXZy9oMldma3dUbjlj?=
 =?utf-8?B?dkpleGRlTFZEdHY4R1g2ZU1Ya1BaRXExQU5tSUVpUDBWcW1wQ3V1blA1Z1k3?=
 =?utf-8?B?NEN1aHhMZUwyZ0pTMUY0N3FsT0pHRWhsaG9NSUlER1JkUlExNkVoQS9uVTN5?=
 =?utf-8?B?YWpHc0RQbGFaQUZCY3lYL3BLUGdMN01MODJlODRQZUdPMlZ1Z012bFFlQ1NE?=
 =?utf-8?B?cWY1NUtQZ09CUkVMODZrU09HZ1U4YVBhVWxNMGVHOExGSlhQUWlMZjRZZHY2?=
 =?utf-8?B?WW1jdkNZUUYzZHhiU0dBTU9EalFWT2lZTS9vUG8xNHYyRFdUQkFDYlhhZUZ5?=
 =?utf-8?B?Qm5CR3RkUkhqQkJYRGU2VVhuK25UOTZIY3hFNU43QllyK1owZkJiSlZYT0p1?=
 =?utf-8?B?Sms0b3BUUG84eG9xK2pNeGlsaWF1bXpmSTd5b1pOeFJySjRxYittRGt2ejJG?=
 =?utf-8?B?OTM0N2ppTFM5VzVkRnBmSEhrYTkrbjM2ZlpSZkpHcDIrY0Jnb3l4eE85dlNk?=
 =?utf-8?B?cmlpV3R5SDRMWG1zR2hacFo1RUhTcWRSdDdjODV3U1Y2QXdDNFVNczJacnVi?=
 =?utf-8?B?bGVXWGhIMUhYZ2ZnamZBSEdGcit3dktoTWpydXBjNllTcnVTYnBZb0dUbFBE?=
 =?utf-8?B?c2NVeFVDblp1Znl6NFJITTVzK3Zvby84NjFjQ1p5Sy9tQ09YOWxJSm9BTlo3?=
 =?utf-8?B?dFBQNXNQU1Ywa1JFOWRWMGE2WHhIbE9mek9GSm4xREo3cXR0aXc1bkw2OU1Z?=
 =?utf-8?B?V0tjWkRid1d4YUo5SnJCb0Yva240WlliRndNbkl6UWtjQ2Zla2E2Z3ZaZHNp?=
 =?utf-8?B?Y2JaeFRWREZ0NGM0Q25MNHR5S3hzN2p3NzFYYVRyMXBmKzF1WnZQZ0g1bG9B?=
 =?utf-8?B?M2t3dVo1aFh2M25XNXVrbHNNQUJKNDgvSmxjTDZLcmNwS0NYUU9kc0xMUFBE?=
 =?utf-8?B?d2JYNjJnb2VLSlBJWXVvRU9va2lTNzRNSU5TWlhHNXNtcWFiTXVxYlJuMk41?=
 =?utf-8?B?dmZKby9Rc2JPQXRrTW4xeUVUVWZNMG5KL2dpaXFka0t0TGZORGd3TWViaTJx?=
 =?utf-8?B?dDIwRWQ1dUVjdVA1aVVFQnRMSzEzYkpsM0tqc3U1bkZCQzRVK3IrKzRtaWQz?=
 =?utf-8?B?UzBhZVNTMFozalY2dE9aU2FadlRHdVJuQmoyclFoTjNtMytKcXZlUzZ0b05V?=
 =?utf-8?B?cjRHVVNyTFE0b254eTg3dVdPN3hoUUdTbFFWeHZGVHF4Ymw5K3FaSExXSitQ?=
 =?utf-8?B?MjFUVUUrSHI4UUV3QWhvelNGZDJuWERmM1IzdlNjdGNOWFFSdHFQM3JzU0dj?=
 =?utf-8?Q?O1LBWL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:01:53.8485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f54e2ec-93af-43c9-a06d-08ddea31a761
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
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

v3:
- Drop early -EINVAL for AMDGPU_GEM_DOMAIN_MMIO_REMAP; let the
  MMIO_REMAP fast-path (For MMIO_REMAP, if asked, we don’t allocate a
  new BO — we just check size/alignment, grab the one pre-made BO,
  return a handle) handle it and return the singleton handle.

v4:
 - Return -EOPNOTSUPP if the singleton isn’t available; drop PAGE_SIZE
   check from IOCTL; inline the MMIO_REMAP fast-path and keep
   size/alignment validation there. (Christian)

v5:
 - Reword comments (no “===”), explain why the singleton is returned.
 - Pass &args->in to amdgpu_gem_get_mmio_remap_handle() (drop local
   ‘size’) (Christian)

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 58 ++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index d3c369742124..7676eafbedbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -424,6 +424,47 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
 	.vm_ops = &amdgpu_gem_vm_ops,
 };
 
+/**
+ * amdgpu_gem_get_mmio_remap_handle - Create a GEM handle for the MMIO_REMAP BO
+ * @file_priv: DRM file of the caller
+ * @adev: amdgpu device
+ * @in: GEM create input parameters from userspace (size/alignment fields may be unset (0))
+ * @handle: returned GEM handle for userspace (output)
+ *
+ * Creates a GEM handle to the kernel-owned singleton MMIO_REMAP buffer object
+ * (adev->rmmio_remap.bo). The BO is expected to be allocated during TTM init
+ * when the hardware exposes a remap base and PAGE_SIZE <= 4K.
+ *
+ * Although @in can specify size or alignment, this BO is fixed and unique;
+ * those fields are only validated, not used for allocation.
+ *
+ * drm_gem_handle_create() acquires the handle reference, which will be dropped
+ * by GEM_CLOSE in userspace.
+ *
+ * Returns 0 on success,
+ *         -EOPNOTSUPP if the singleton BO is not available on this system,
+ *         or a negative errno from drm_gem_handle_create() / validation.
+ */
+static int amdgpu_gem_get_mmio_remap_handle(struct drm_file *file_priv,
+					    struct amdgpu_device *adev,
+					    const struct drm_amdgpu_gem_create_in *in,
+					    u32 *handle)
+{
+	struct amdgpu_bo *bo = adev->rmmio_remap.bo;
+
+	if (!bo)
+		return -EOPNOTSUPP;
+
+	/* MMIO_REMAP is a fixed 4K page; enforce only if userspace specified them. */
+	if (in->bo_size != AMDGPU_GPU_PAGE_SIZE)
+		return -EINVAL;
+	if (in->alignment != AMDGPU_GPU_PAGE_SIZE)
+		return -EINVAL;
+
+	/* drm_gem_handle_create() gets the ref; GEM_CLOSE will drop it */
+	return drm_gem_handle_create(file_priv, &bo->tbo.base, handle);
+}
+
 /*
  * GEM ioctls.
  */
@@ -465,8 +506,21 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	/* always clear VRAM */
 	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
 
-	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
-		return -EINVAL;
+	/*
+	 * MMIO_REMAP fast-path:
+	 * For AMDGPU_GEM_DOMAIN_MMIO_REMAP we expose a single global, fixed 4K page
+	 * via one shared BO. Don’t allocate a new BO; return a handle to that singleton.
+	 */
+	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
+		r = amdgpu_gem_get_mmio_remap_handle(filp, adev,
+						     &args->in,
+						     &handle);
+		if (r)
+			return r;
+
+		args->out.handle = handle;
+		return 0;
+	}
 
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
-- 
2.34.1

