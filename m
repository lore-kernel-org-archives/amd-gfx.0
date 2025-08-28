Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72FCC8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 641A510E89E;
	Thu, 28 Aug 2025 09:15:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VP5tretp";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E78410E89E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/m951BEXLJYKidbmK2kkP4zW6/u1jpSoNNq1sS1FTFYPsT3oYfbBr5aAmpAYoyvqGux1qB21mpPw9Ns4sr/JZa8bGxUy+vNKR5+OEByW/xNNrVd4laIVXE3rLfZbqKJFnZzXUXuNjyU7LbqBn1ABJWL1rMRK9HziZkN51+g/sPyJ5vEYo8mYz+9QxsfWodW4W+P4K3xftyBpbW4cREplPy5IFSyNWfhiGeBodkVzHlXXmNl9Zo7NH9JJV0cG4Hp8A+F/ib3KMADVYxxyU89SUDeV+QO2pBkqo5gnBlFyzFwz5F4r6EbZSA+cSDQR7TVJdgdM2ZnQ347C0f2RGaMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11Lciha5OG0L7wHSCUCXauVNveu/vYKad2JxmTZREYg=;
 b=T0hHaRXV+HX254rqYOW7o2D1Mompo0ChZjkJiUf8yHPJR3ZBHdGTzkSgYI3+3K3A0Aob/sO3qlw1Crfb+C7iryaaR6n2YJkyvGz7b678fReur5af9jMCkiL+afShv4P6jwNv9lRr/i6bfzMFWcmLUx0NHO2/TRN4EWLfIYv/xNiymHt37hQjjg016YpMO5UsoF24sAXsphI1PrgM76f9hm2X3wczGmCconMIp9Z+A444rcFWLEKGERjppElvMZKYScHl1eZl8zL262WFK3FoQJojfqd5ahB4/pjkz8MqubEzB9XdDK4n/1WZsawM+moA5WIkKtm2jxKrQTwyMEpVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11Lciha5OG0L7wHSCUCXauVNveu/vYKad2JxmTZREYg=;
 b=VP5tretpeFOiCLYOuK/QR9H69Zyabu1fYG3bExyUiGSltqsy2Cp3vNuLXZV20VGYKGMkwVOP610W/NhczEccoEeWekpK8mVsxNLQwilk4LZ6yxEeyV9PAR5Q6Kfm38VuPMxsRwP3HgTZBhysCaxZSmPO7p+wZWYG0QgQ5whox1M=
Received: from CH5PR03CA0011.namprd03.prod.outlook.com (2603:10b6:610:1f1::23)
 by SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Thu, 28 Aug
 2025 09:15:36 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::88) by CH5PR03CA0011.outlook.office365.com
 (2603:10b6:610:1f1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:15:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Aug 2025 01:46:07 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 9/9] drm/amdgpu/gem: Return Handle to MMIO_REMAP Singleton
 in GEM_CREATE
Date: Thu, 28 Aug 2025 12:15:30 +0530
Message-ID: <20250828064530.3948378-10-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
References: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SN7PR12MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 7865cc5e-4d01-4da4-b6b9-08dde6137336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzZnaGhKTzRiMXJVR2J0ak1XMGNLZUdCQ21ady9ZZTA5bnh1MzRWNlRNUzdX?=
 =?utf-8?B?QWNncmdSR0wxOHd0QXNHOC9MTW45V0NZenlrbUhyMzYvcXZ3d2dpWllESnJS?=
 =?utf-8?B?andMekhZaE1xZ1FhUnpwbmk3K2U4WjBrYlZlM1BjdmNOL3JLRWJZRzI4OWp3?=
 =?utf-8?B?enNJZXVFelZISTFuVkx5T0tQSHczK0R2Uk41dUsrWHVOUEc5SEFQaXdZUnNw?=
 =?utf-8?B?MlBZckEyVG9HMUZxRWNJditsV1V5YXZibm1obGFuQzgrR1c5MGNqOTdoY2Jq?=
 =?utf-8?B?My8vQWVtNlZpRUJzeVE0ajB3bjR6R1NaSGNRdHJsYWZ6eVRDWk9aYy9aYnlE?=
 =?utf-8?B?UHU0cXlEUWJ5VnJtVjB6T3lodmszaXo2TWMzN2E3cVQ3OHNPeEFrTkZyZHFR?=
 =?utf-8?B?cC9Wb1RyUGFYWHJUTUpZMnBaMkZ5aE9nSXplRm1KNjh6czRRZWdPdjlQVUxQ?=
 =?utf-8?B?a2F4bDdEY0VTUVVvZHdJSHVMVmZhQ3ZoazAyZEd1dkJ1ZWJXMnNWeUt3OE9U?=
 =?utf-8?B?SEloR250Y2hJR2NTZWpaeXJrNExFRXovQ2YxS25HbFBpdE9GWlFrR0I4TEtC?=
 =?utf-8?B?TlJmQ2IwdTgyWHlOaEpIMFFkeXF1Y2diai9tdzQxZnpSOXc2OC9JOGNoSlZn?=
 =?utf-8?B?a08veWExZlFYcWhnWWdQelZjZHJGYS9pSURRSUliWXF4aFhnWkNiZkpuQjh2?=
 =?utf-8?B?YTFiQXJJT05QbGVKRThlQUhIQTc5cWZrTmZaZVZaU3ZCODZsSlRTVUhwbmtL?=
 =?utf-8?B?cURPWllDSjNraXE2QUs3TUM4WExWeEhkZFZMSkRYd1lGTzl5a1N2OW03Z3Bn?=
 =?utf-8?B?KzIyazdSTy93a2wrMHh0VnJWcU4vOGpCSThSeDlFQ25oNnJkT2x0MkNnS05O?=
 =?utf-8?B?TFg1d1Z6NXFZbVVvR1VieWV0Q2U0T0U2OTdmMFNLUXcwZGxwZXNEeTFtSlB5?=
 =?utf-8?B?ZWRDMFdyZGxhckhjQkVWektmKzVDT0s4U25qYkNKdytDb2g4eFRBNkwxQ1pS?=
 =?utf-8?B?d1ZIeUphc01uSi8ydlZuaVlUUmdGRVQ4M1hvUXcyS3RMelNCbjlmbE5UZzJo?=
 =?utf-8?B?M2V0bENYcThCSWsvOUFVZ1R1TExkbUxnWkpCazRoZGVzMkVxOHdDZ0tRY205?=
 =?utf-8?B?dEtGVHhGbmZhenhDTjJIbU9GTHpsTERSNTU2V0VnSGcyem4rcXFrdjVtUTR2?=
 =?utf-8?B?ZUJOcjY1U0tYVVVIT0UzRngxcmMzTTAwenlsM2lyQ2NZcytHNnYrRE5LQW5V?=
 =?utf-8?B?bHBFZ0FVR29oUDNyT3RiUlJjSERFUUxMejQ3WjVTaGNHZWJWTzdZN0JWa2JI?=
 =?utf-8?B?QW5QY2QrcTIvbXA4LzFBTWRYNDF6dkprUzB4SVRTU0ZERzBqQlNzdFAyeUtO?=
 =?utf-8?B?VStrNzEwMEhoOEFIcDY1NnVTSHpFS0VreU41bE1VT1VPRjh3aHBVZXBJbHl5?=
 =?utf-8?B?czhzNVpqWmRmUFJQbTRIY1RNQzdyeVl2RzRzK2VlU001N01ZQVVCbTBtMnlk?=
 =?utf-8?B?SVRhTncvd1RveFhiYTlhQkdMWnU0cHNFUnFFUG4yRy9xSVdqTFhBYkZsNS9p?=
 =?utf-8?B?N0x2WVQreHFycS8xN0tTRHRJLzhVK2puQlpwVVZwTDVDRkw3Q2hGbnVzcVM0?=
 =?utf-8?B?OTgvVUwrWFNqdWNnTUFXNk45ekpXMmlVOU5NbXE5V2ltQ01NU3N0YkdNU1Vj?=
 =?utf-8?B?WWY4TmZUeUVkV28xMnNoOFhMVk1LcXRVRDYyZkpoNHAyVElmRHJDaXhCVnpR?=
 =?utf-8?B?RjhSSEkraEJNdUh6clRtemp2VlVvaENhaDV1Qk1HdnpsT3lFWDNWRWRIY1F6?=
 =?utf-8?B?TmlXQjNUUTNMK1dzNFJKM1NMWFkxcmJtVjhHRDlXbDFmMHFSdVMxb2dYZ2pz?=
 =?utf-8?B?M2VyUENBcGlpVjl0OUgrYUJGdjBLc3puS1NJR1Y4MU5xRXhWbXNqaHo2VVRo?=
 =?utf-8?B?eXZCdFdvRlV4UVlYdWI2c20yb0J6TjhZdUpRRjZySGpsbXNiODg2RTlpYndC?=
 =?utf-8?B?U1ZJdTZBZTVjRHFqalJMempITnY3MzBTaWZocEZyY1N4czBsTFVRZXZKMUh3?=
 =?utf-8?Q?BrM43s?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:15:36.7671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7865cc5e-4d01-4da4-b6b9-08dde6137336
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131
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

