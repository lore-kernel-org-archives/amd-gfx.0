Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D62CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 05:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C152A10EB3B;
	Fri, 29 Aug 2025 05:55:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YBqXCWah";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1235210EB3B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 05:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBBndV9d4XycnnHXNSCUwxaCuDM5tu6WY5EcYJAPVZYn+avKyBnNW40VukiJOXXuXYtFP5BlRSlt2YgyVTGcknf/O71NyxNzGw+YW8g5ZAhRGx51VH9MCLBHWHfjgsqD9YahjU1BUAIQCIgFFYeGAg8gmLQUbwM1XJUFZQYPenA8smOCrb40l3T5bwNPcwlTEmZKA/s88/Hp8Tt6vR0PyVqzU3XBqdTO6NUFdF5hDZHfloq+lp/xa3f7JHpC+kkq/HQmEjsfkjjfL7o41pOapdK4JNKN46cktavtsdxQm9M9QB6FGdz9FqrJ6o+I5nT6bgCryrCUsUq8zf63ytXZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nI+qLtYMqwJwWUpCrEl3rRPFUDZwx7ynx3b5GxWmDGM=;
 b=I8rYmCeKJfwBFQZqKCWnGMyKgSeKcIDbdASwuaqmY6A0nhcVY+bA+Q7nFxIa3vvLrFf6DN3cM6xV5AIe/Ii1DTCtPZtnePR1ojnIlCwKNJ40kz3geZqPhmkzdKIcpDK98sxsY/8iCcgtl0SKrr/IC67z4gLTUVrsLo2IZD+c2FErvhgEhuf9MXdvjT0ICzo0lP7D+z9uQnyG/4irpY3LPuSWiR4NagqHYCz5bhGkWcxx9jNDH/5epsSf7w6b0BrwLS2K9Slcgg5GqOruYqh+DPgpmsBjJmxx/h58cByTna7vGBlVHMonL0FJKXWKrRKMa2VwgyvFxnRmqlHH8PtrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI+qLtYMqwJwWUpCrEl3rRPFUDZwx7ynx3b5GxWmDGM=;
 b=YBqXCWahAJZMitvm1WM8gvUGC7ZlwUAU3UkVKeKIrJP3faeUQIiJKdzdVHraaJQb0xbTBnVEuCnXVf417Sv/2iVh8Q08BcRsRyDKUf5EpkJPeKHH9etle0X41s//9ACYMMWIsIf1NamySiWptJPG+Si49vHHfGWUSVd/HJ4fays=
Received: from PH2PEPF0000385D.namprd17.prod.outlook.com (2603:10b6:518:1::6b)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Fri, 29 Aug
 2025 05:55:50 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH2PEPF0000385D.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Fri,
 29 Aug 2025 05:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 05:55:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 00:55:48 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 22:55:46 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 9/9] drm/amdgpu/gem: Return Handle to MMIO_REMAP Singleton
 in GEM_CREATE
Date: Fri, 29 Aug 2025 11:25:38 +0530
Message-ID: <20250829055538.3983632-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 1332a1a3-172b-40db-62ec-08dde6c0b4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDdMV1BIekdsZWg2clZwYkRSQjhjQUdHQXpOWUthZDJaUGU3R0hvL1NvbDd2?=
 =?utf-8?B?M1NpV2o0YjRucDIxYjRtLzJCWEsxYXRRQ0hhOU1wcWZYMzZZUjVSNjRzeHUx?=
 =?utf-8?B?U01EMjBJVDQ5bzQ1Uno0ZXBaQUw5NHowa2Y3QXdGeGRuNnJvNGo5bUhBZDVT?=
 =?utf-8?B?eU42TkdxcTVQZVNaeWdCQWMyWTZKQkdqT0xVYWFyNyttT3hHMmR3TnFXRnpi?=
 =?utf-8?B?KzBSaUZMWGFPeGJySkhmMTF6WjgzU21rTEFrN2h6UyttQmFWQWY3R1BuWXlW?=
 =?utf-8?B?U3kra2VIa0d6R1o3ejdoMktxNXJFdGpmbURSMXpiaG9ETnVDc01TbDdqZlY5?=
 =?utf-8?B?SEkwa3pQT0kwZVZTM25HaERRQ294cmN3dWljK1pTZ285eG02dG1JMUhEMWls?=
 =?utf-8?B?ZXIrRkhkWjliYkxoRVZtMjJCaWhzTjV2WGV3QjZKTm9taGxqUTl1NGlXWHZz?=
 =?utf-8?B?OWhjY0lwWE5mZmFTRmt1eVJZUjB4MEZsM0JtSmZ0Y3JuN3FwZWx3cDRhZUJU?=
 =?utf-8?B?bE5DODlWZVFzQXE4aGN4UkFiN0NHYUxsQU5XVTJZQW9kVE81RGdPQVdSL3JD?=
 =?utf-8?B?dThtRFJzSmNGZ2tNc0t4YzN3UlJaZnpwV2gyT3NZNVNYUk5OTjJqUEFkSFdp?=
 =?utf-8?B?L1lkREtqODkzZk1GbzdrZHFjbGRRK1lZT3BxL0VsaW5PNlg4MUlGQzEzdS9t?=
 =?utf-8?B?VUNmUmZDWmoxcjBDMnZYWVBldWJjeVBqaSsybTIweFd4aiszYkZYbGVQcGJ2?=
 =?utf-8?B?MHJHdkxBcGYyUzlpKzNLdGIwUUprZE5aZU1MWHA0UU56d0N5cFJVM0RNY1Yw?=
 =?utf-8?B?K0dDaC84dkhNVUJlVGZRRkUzbEVuLzRrc1VEbmRHZllyb29jaVh4Vm9GS3hP?=
 =?utf-8?B?WXJNZmkyNE1kWUFDek5CVEJUbGlwVHpUclB3K281ZWN3UTZLSmZqNTJXRWpD?=
 =?utf-8?B?ejQwL3Z1V2ZEV3hLV051WGR3dnRDWTlqUDFaRzIrYlNUQkRROWFOa05XQ0Fq?=
 =?utf-8?B?eDdDR05Xdmd4S2xpZW9tZ01lTzI3d2tEcEkyYTd0Q1pzWm44cmJldnAzR2l2?=
 =?utf-8?B?WGkvNHZnbG1QRXVHYVpqUXdFOFY5NUs3bUx4THNJd1AyZUJqcDdyWGNNQW4x?=
 =?utf-8?B?M2hzWmcwb3lqTC95WGtaSjk5dXRaSi9Fc09GcHB2aGVnSnJUUG9VS1A0Z0dH?=
 =?utf-8?B?SVRucVlXMWZZTVdDekNyVjk1VDJQdzMyYmt3d2VmTG5nN1cyVUR4V01VNWlq?=
 =?utf-8?B?VUR2MW02a3BLZGZTQXgrMGhEVHAwdVFoUXlsSXNLdFkvZWorM2JsZCtsb0Vw?=
 =?utf-8?B?TGorTUpMd3ZTdTRrLzRhM3FpM1Y0SC9abWdpeFprbVNKbGV3d1J2QWNwTGZm?=
 =?utf-8?B?Y3V0UHczc0dQTjZnU0tlUWZVSGt5d2c0QnViajR2NXp6MmVMMm1SOHFpUzJ5?=
 =?utf-8?B?VjFHa3FSYjVxS25XMFB6MmU0emI1ekV2WlZYLzlSRG1EZ0p4TWpZdktnWVVy?=
 =?utf-8?B?SWFrcGxUYkdvdXFYRFlBK0JXTVRaeW1yKzVZUW5sWW5HREJRVGFwbU9zd0xk?=
 =?utf-8?B?cytVbWlPSEp3Y3p2QUN0WmwrM1k1SXA2YVh2N2NhNmZZREE0YitMRkpLYzRo?=
 =?utf-8?B?aEFjalZBK0VnWHY5TlFNR1R4ZS9KdERCR0ZmcEdwZWlXM0xmWmwzV2xPZFpB?=
 =?utf-8?B?bUxKbmhVNSs5aFA3WUJCZWFSdlNNOG1zNUJGRjVHZ3lJRWpDVkZ2NDhZRXJq?=
 =?utf-8?B?SThwWjJSVFNMTUtOV3Rzc1E2YUZWVzhNaW8xaTQrTkhqSWQ0ck1JZngwcE1x?=
 =?utf-8?B?a0kzRkMwSVBHVmhoYWlURWJ1Rk5MdXVzejI5cTlzUGYvZkFsMHgyR1BBclFu?=
 =?utf-8?B?ajEyQUx0V1VvdVY2bEc1M0VacWZXS3JETzJodkl3b09PQVpBUmRXYzJtTjF5?=
 =?utf-8?B?d1FIRk1SZm0rRDV0WkhSOXAyM3dKMktoUDZsR241c0VIcGN4dWgxaVVncnRx?=
 =?utf-8?B?YXBGaHg0N0VHeDREcXZhUkhEZGdaSlRrVjE1RE1EMjN3Lzl3SjNOZHBPSUwv?=
 =?utf-8?Q?c5av25?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:55:49.8892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1332a1a3-172b-40db-62ec-08dde6c0b4e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
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
 1 file changed, 59 insertions(+)

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
-- 
2.34.1

