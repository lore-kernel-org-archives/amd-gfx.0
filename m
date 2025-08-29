Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A816BCA0FF9
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 14:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44EED10EBCC;
	Fri, 29 Aug 2025 14:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PH6QtS4I";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4316E10EBCC
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 14:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPKqUtyQlEPcSO4KwOIF3EQ4f8WojTqLwYZSUMdb6RJGQ70tf5NekE35UsMDDCCAEcwHEzd78Mcj+R7qZGIoovq/46bbqC7t5w+rK5a5skCPjBQf6/KzMfEatILGZkSsDbWbj6tg+N01J/XOl16FiMq74Nky89Qe8r+50ct5EQFeb+VyGVfdBDVv5gZ44+hDuVlSGY8cgYQ5vA93r2gVtpCLf+NOZYhP4AVWYW78vpi7V9OKUJAYUtWTnAULyq9kiYgXakUqWn+FRVgCnhmFhlhzt+c0JkdU6r34Ae6J7dBcIP6MD8AWf3TPgX24dJPGdlN9Iq0ShVIgVGwHSLxM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VHgeYWTTHCB+jnbHdywU1SI73qRrKNDLReBS5WgEd0=;
 b=WlBeGs5+QJldfqnJlw9WY8XlVXF/mELS3e4F6htbTPVAfW7J5MfQUtYgvNqcFHPVShvd8mPSs+9PhFAcAdb72fjK2uHcEjgTK93MFTvbO1o/CYJPW+s7m7byjUusvhmoliUbDo/xGQqizMcWY7IYPDUTgxRu4uRF5i+Y96w2pSGnggfH1eOQyLfEFhDPIS4ZfGdb2VZom0cGxpmLleazIwkOAshcE6mfKDog239GmLGqvELY1LTACNrY8s4ZbTCrbluUxJTy6bIekQ0lmQ7Mncy/904dnh0AqN5Im/Se8QspRWKk7kePHO4Nde+ejT6BDg5YNRIEUL2szvOuomdzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VHgeYWTTHCB+jnbHdywU1SI73qRrKNDLReBS5WgEd0=;
 b=PH6QtS4Inpolmit8QiidJ53lvtpSHGQfFy4+X6GsX4RX0Serf+15qsrubtIlYzdkZdXaGMMXAJjfBrYiPhkYy/BFSGFqcvTQRRhz04rtcqW4h7M0pTthrDoCjOUcF8tOlTQCgeOtChpYcCSees9Kzpi4hZWa30fo5c6O/BvQ6QA=
Received: from DM6PR02CA0125.namprd02.prod.outlook.com (2603:10b6:5:1b4::27)
 by DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Fri, 29 Aug
 2025 14:06:09 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::73) by DM6PR02CA0125.outlook.office365.com
 (2603:10b6:5:1b4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.25 via Frontend Transport; Fri,
 29 Aug 2025 14:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 14:06:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 09:06:04 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Fri, 29 Aug 2025 07:06:02 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 9/9] drm/amdgpu/gem: Return Handle to MMIO_REMAP Singleton
 in GEM_CREATE
Date: Fri, 29 Aug 2025 19:25:23 +0530
Message-ID: <20250829135523.4032168-10-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|DS2PR12MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: 3989d56b-5d6e-43d1-a452-08dde7053348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDNWS25lRVBEUDluVjlOU2ZHejdUVC83QzZzTTA1b0hMTFNQRGpyOUxpWjRI?=
 =?utf-8?B?RFlUYmNRclIzdVR4aXhsNVlXclFUUS9xb1p2SmlwT1ZQaU5qK3N6Nnhrd0xB?=
 =?utf-8?B?MHVzMWZJcGp2NURJVTEybFNQcDFMS0M5Vm94c1RhVk5EVEVuUjNwdEUyQm1o?=
 =?utf-8?B?dmdLMHVpdW9BRzVjK3JMUUIrOWlhK1haZDNXQ0VYQTB6WStaU3R2RzZzeWVm?=
 =?utf-8?B?eXJ4T0dleWZFMmRzeCtGZkllQXNjdTFXMEFpR0JMU01TSU02a2JsOTdNd0gv?=
 =?utf-8?B?TVBUWW9rQWt4amJMang3d2VKQXBKRGczZnhORzhjSzd0NDFha3lPMzcwQm9T?=
 =?utf-8?B?RGplZVZFb2VVSVdaeFlvNTVtOCtwMzhoMWNYTGo4UUtxR2VrTXlKaVJpV0Y2?=
 =?utf-8?B?VE0xZW82MXZZSitHdVpncmx0VTlBb2wwb1Blc0FocTQ3N1pYU3drNjQyeWZJ?=
 =?utf-8?B?RmNuejdncnlYcDF1RFpnQ3E5ZCsrM21uSEV4czNZOVMzZ29wak96UkNVWU5E?=
 =?utf-8?B?Zk16MTUrME5wMEp5MmN6WUhpVXFWZHI1bHlqUUFhL0JNd2cvSmJPaSszeG41?=
 =?utf-8?B?WXRmYkJmOWJQaS9DeVFoWGRaa2d0YTB0Q1pxM1NwZEg3SDFqQVJqYTluSE9n?=
 =?utf-8?B?L3FZVUFHUFp2TFgxUXVpVHpsb2RkZzIvNkRLa2ZBdEhRTDc5Zk1vbmU3cGVt?=
 =?utf-8?B?Rm1ycksyVWdVM0Z1OGRPTEhyV0piWklJQ2RTNCtIbDI0S2gydFFZSzh1UlBK?=
 =?utf-8?B?VStrTWNQeWpDOTFoZzJxZDRLVHFIdW1wK0szUTlXRVg5L1RKQU9JY1RSa3BI?=
 =?utf-8?B?SXZCbE5xUUwvMnhUc0RMR3U4bmJVWnBtM1VEdHBiS1czODFZdmhhNi9KTHBJ?=
 =?utf-8?B?OTF6U1pPcnpWaWdnSVR4WmZjT05Vcnl0S3VxMUNzandkTUlXSnJGVXByeS91?=
 =?utf-8?B?eHdSWlFSTktTMWdoekZEN2E0WU5QZDQvQ05BdHhVbUhramFRRG9YQW5jZk90?=
 =?utf-8?B?cjY2T2hpbFhhNGNGMnNpMVA3NmpmRGtuSkpRT0l6cEZCWEw4MGF0SnRhL0l1?=
 =?utf-8?B?M1JjK2YzNFNaOVN3NGFVUCtLSExNcVY1ak5FaTZDTU9HMWN1WkVTdmQ1eXFT?=
 =?utf-8?B?QWdGTWxzZEhyekpaZFBMVzdxdkFGc0F1RVByM0VvS3YxYkE4eERBQ3R4SWc2?=
 =?utf-8?B?b1hJVklGYnZEVTlUaHB4OXd5RmtjWE5vQTVuVEhnbGNPekttd0djZlhxeWp0?=
 =?utf-8?B?ZXV6SThHbzJzdDBvbldSOEd2Nk0yQjVkTkNOcUZGcmtBNmhHNXRkMnIxVDRs?=
 =?utf-8?B?VVBWMFphTElnZS9BQ0dtUTRFYURJenM1dldJR1lVSWpHbk9OdlAvaFN1STZS?=
 =?utf-8?B?Zm9Nazdlak9KZ2lQY3U1UU9EUHYwVUJNbVZ4djZuQWlKVXQ3ejlib3RkK3V2?=
 =?utf-8?B?RUdYcGswWXdnRmZJWE1OUUM5Y0dIWHJsSUl1dHhRbmNyZFRrZzBQeEVpQmlC?=
 =?utf-8?B?MUlQNENtTHIvZ0lJOE9DR0h3aGtaSEJuMlZxOFMrLzBWTFlOWUp0UVhvekdj?=
 =?utf-8?B?cTFoZHM5VmlLUlg1R0QwYjVJbzJadmNYdVhMczFGQkN6N1JiSHVZbDBzcG5u?=
 =?utf-8?B?TEYzaVgycGdSMmRzWnFVbXlrYmhqN2Q0cnhmYXg3T1hpQzBCY25aeDZzN0sy?=
 =?utf-8?B?SXI4RTl6Zi9Ia0loZWUxckxPbFIwYTVPbHZ4K0h5Zldic3ZWNW83eFpDcEtt?=
 =?utf-8?B?VXlNajhnWEh1c045VlBueXdmUU9kTVdIMGprVVR1U1VRMVd0YjR6amgvUXZh?=
 =?utf-8?B?UUxiOXB3dU9raUtHckxMOXUvV1JEWUdTNFZIS3I0Qk9nQ0xVd2FGdDZiQjFa?=
 =?utf-8?B?RVQ0MkVYZ2s4bzdiZTFKU0w5Y1FGZUhiSVFiQVZzMFRpaEgvZFE5ckxrQmVN?=
 =?utf-8?B?bXpEdkNhd0tLMXU3akpveGtTUTQ4NHYyVzEyL3hpeHhVUC9BNHRkTmFHMXB1?=
 =?utf-8?B?ZXdZR2N2b0ZHTDBtWFArTTYyUjNSZU9IaExVOTlkN2FMdGpoWTVtZ0xxOGV2?=
 =?utf-8?Q?McXQfq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:06:07.6903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3989d56b-5d6e-43d1-a452-08dde7053348
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9615
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
  MMIO_REMAP fast-path handle it and return the singleton handle.

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 61 ++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index d3c369742124..7f331c34e581 100644
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
@@ -465,8 +497,33 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	/* always clear VRAM */
 	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
 
-	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
-		return -EINVAL;
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
+
+		args->out.handle = handle;
+		return 0;
+	}
 
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
-- 
2.34.1

