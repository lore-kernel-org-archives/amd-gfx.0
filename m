Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA54D0EE0A
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 16:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EFCC10E4C2;
	Tue, 25 Nov 2025 16:44:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kn0kPeuH";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237E310E4C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 16:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsP8ALtx15tCPSJwnVTXB0C4w+4aUU1pnWg79WANKuXxr4GDxjEEKIPXBEkTeo9bXE67yiJ79TGdNAR5F+ig3XSTgSgQXZw9RP5FY30gagny7rSZHKyRHFQdPv3B7yhoXsx0iZF4ixJfiXXGXJIpFMfDDbamxSPvdLu/xL4MTGyadI6mps7jDEr4lJhkV7zmo4sj7dO70un5bT0GVlsDQFBqH+ATP5oRJVEeHsHglyndL5oBSYMYrLlRW9IlDP/Hl+wC+15KNcfbkU1cO4WI17R8hXSg924sgVQqJgoSvWdD9G2pemj15zsnojWQFNpXs612VkKxRLNolT4CzX4CWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7QyOEkOq4tHkNqZFWCP7UouLv1CnoqWvt3/F33idtA=;
 b=uivtr6W94hU66/ZuucSmAK1Nl8n0WbpJ0RIgx9VkZ12v+rqm988gfMVoUmmSvSoyo6lw2/LGSyeqfCjvLgp/R/d+dO3cX1M4VL6hBEeMOor963mMkzjtMV9NTW+h0TuifWNSIzHfPdPab7Fapd6jRIQ6L1dh7HlpYNreTvY3hcsEFMdk5PNckYz3b0pHMGuwnJdfuWqj7vq+py7zVvdKckHroprFBE+5nRXmJaVFGi/hP75BIBllPFkbXI+7DBad9McY/lMQSW97aXsDncxvHOlWdLMj2CEMdQqoHraHI5tFtOeoG9OmYZLD5RT3kb162rD60ljqhRbUkcBv/qWnIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7QyOEkOq4tHkNqZFWCP7UouLv1CnoqWvt3/F33idtA=;
 b=kn0kPeuHesL0KZ+LHcvFcGQrzFl/hAJCNx7oYkEVa71iKvHMfSTF90Hh2hypZ39MIVtYqItNF/wyPcMPQZw3wn1LOFIcnARpV0aMYveUIlvtgg7jcF6i8RlQbYCeo5xvCjXiweW7kArNY8lLU20pX/YE0lx2aaxGx/aDzGIqlm8=
Received: from DM6PR21CA0021.namprd21.prod.outlook.com (2603:10b6:5:174::31)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 16:44:04 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:174:cafe::99) by DM6PR21CA0021.outlook.office365.com
 (2603:10b6:5:174::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.3 via Frontend Transport; Tue,
 25 Nov 2025 16:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 16:44:03 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 25 Nov 2025 10:44:00 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu: Treat MMIO_REMAP BOs as linear in
 amdgpu_bo_set/_get_tiling_flags() v2
Date: Tue, 25 Nov 2025 22:13:45 +0530
Message-ID: <20251125164345.224298-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251125053634.219308-1-srinivasan.shanmugam@amd.com>
References: <20251125053634.219308-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ca4c5f-b6f5-4b3b-a2b4-08de2c41d7b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emh3aUNSekFnbWxjT1dyMTE5YTAvRHNiQ01pcE5FeUJHZk01bnZNWCtTQmNS?=
 =?utf-8?B?eTN3eUJLZFduR2Vib1R3Y0t0YlF3bDNSUkVWNmt5ZUNacHZkZDByQ2dyd3ZZ?=
 =?utf-8?B?cFExQytjWTRSV0RiVGxnM3MyYnc2ZHpCMzJNT3ZJWFNyWGI4SnpNbWlRbVNJ?=
 =?utf-8?B?V2IvMjdCbUlIbWZvbXlxV3dZM1lsS09ZM2JFRXI4M1JaZlovelhPWWtaZXI2?=
 =?utf-8?B?MFErMVppOWJTWjVpd0JrOFJkcDVrTmZDeS9qcDBXUHgzTUc0aDliQ2FHRVda?=
 =?utf-8?B?QzFHeVRIZWI2NnhmVGhpQnZBRGRRYmZmUzB0YkxxSHQ1N0ZqWCswenJLTHVu?=
 =?utf-8?B?R3M5anUzUDhYcGF4aUdrTFE1TWVNRFBqQTM1eVpqckNrTmVDakU5azRpVFl4?=
 =?utf-8?B?UmxFc0lQcEI3QlhlUUYrRXFUWUpKcGJTRjk4eUNtOEdGVVF1aXBUMDBPdGg4?=
 =?utf-8?B?WTBOMGdxbnNUVXExVmZtWjFhU3B0RlpkSTRiZGptYzduWFcyUHNZcHMxeW9p?=
 =?utf-8?B?TEROTXBLTklOMkU3M1IrTWt0U09rQ21Bd2ZpN2F5dnJrejV2MkFMcHJFcEtP?=
 =?utf-8?B?YzdvakRaS0xnTDVDU1BpRGI4cERhQWFnQllsbFN1bEQxcnBEd0hjcTlYaGNE?=
 =?utf-8?B?ZXo0OE9WQVh5UllURGRrNTF5WkRTZHVFMnRwTmlsQUk3VGt4S2NrekRscDBV?=
 =?utf-8?B?UFNIc2pzV2pTZE5yMHdiZ2NBL0dnWVlFdmt1NXNqTktaUmdNb1FpN043UUpE?=
 =?utf-8?B?SUM4VE51R0RLbkNlYWFNWE9RK1l6S3diKzN1OHYrelpmZHpLRVR2eUpITmxm?=
 =?utf-8?B?dUxyY29PZmdSZ0NISWJKVERlaG50SUovWmZsZCtTaU9XMWVzeWlxYjAvajdQ?=
 =?utf-8?B?RDVnWTRWd0lHMVZzU2ZWcXliRU5mUkRlbXJZZVZjeTRLK0dpaFFPU3JJUndV?=
 =?utf-8?B?RnhFZWJla1djMjJkREc3YUdORVlYV1NSODhzR3l0N3kzMEpnNU9hb2srVWRP?=
 =?utf-8?B?ZjdYZHpRb0pvT2xkcTFZVVBmbHcrMjQ5c0ZqM0YvbHFSdGRwTFgwdkVRdXkz?=
 =?utf-8?B?ckdOdFJEbzZPV1JFeUxvbFQ1UmllRWpUcU1FeE5ZYlFneExPcWVEY0diNHFM?=
 =?utf-8?B?N2x1R3RTMXFTbm16L3pQUHpLVUJCQ01ESVdSallHMENnMTJzS3A2ajd6S2xB?=
 =?utf-8?B?d2R6eUNlb1hPTDM1OTByLytITUhZeWlrSG9LQ3VaMzg1SlZMK1NQTWUrb29V?=
 =?utf-8?B?eDZqUjNIb293QXhrNjVocWg1RFYybENIajV5Y1c4RU1FOEw5dVpWNnpBZnNM?=
 =?utf-8?B?NVNkaS9aQzJPa1hFZGl5TFBPSnZUZ05RRkQyVGdCZVFKSEgzdFJPVGtHa2Nk?=
 =?utf-8?B?QVZMMlFaVExZWFdDVHJ2U3Z6aUxTTEhBc0pGRStHcE1temZqemQ0WDJSM1E3?=
 =?utf-8?B?d2JENGVWbSthQnYwWlprcWQ5TFlBcytYSUMzU0M5QlJkaStxaFFJVTlYM3RH?=
 =?utf-8?B?WWVwOXRIb282SVhKd1pmRVU5dHBYbEQ3NXkranlUblZoVG84eVFlT3lOb1FE?=
 =?utf-8?B?cm9zbzhJdVp6dmM1LzJ2aUl6RkxsV01BWm91ZlR5amlKUEJtMjMvQVcxdEJX?=
 =?utf-8?B?SnhySi9mRTFlSXBKaVp1MXVQRzY4Sm1XWkN5WnNlRm1OeWtsODYrMDlZcEJS?=
 =?utf-8?B?N2NUVGc1SHIxWlRLazhpb0J5d2MwU3F3VWJ1WlFWUVR3eE1xcFd1Zm5Ma2ox?=
 =?utf-8?B?WVFEK0ZKemVQMWhyWlB6dmY4Kzc4SHREUytTM1dRdFhGelB4R2RPZHN2VjhF?=
 =?utf-8?B?UTRpTWxKZitIOERWb1JhRVNoQUM4ZVVFVVAvWFUrNGVkdVhaK291dzh0TXVN?=
 =?utf-8?B?czNxK2YxeGthMnN2NDZva29YVnNqcUkrSXBxcWFoczNBUFJZSldhUTZ1a3hq?=
 =?utf-8?B?a0p4cTdWMC94R0hBOC96eHBaYjZLRlh6S2t5QndvYTlqUFJRRytNcTZKZGxu?=
 =?utf-8?B?NnBJOWVnLytwWXRUdzVMMVRlUDJrem9ESWFkK3BPbkptZEpBdFZJR09MUFpE?=
 =?utf-8?B?T2V0N2hTRGpJYlZmZmtBOHZwK25sSW14SGh2dUdHeVFEcENOeWE2NzdBakRw?=
 =?utf-8?Q?naxg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 16:44:03.6237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ca4c5f-b6f5-4b3b-a2b4-08de2c41d7b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
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

MMIO_REMAP BOs are created for HDP flush and device<->device MMIO
mapping.  They are backed by a TTM resource with mem_type ==
AMDGPU_PL_MMIO_REMAP and are allocated as a plain struct amdgpu_bo, not
as struct amdgpu_bo_user.

When such a BO is exported as a dma-buf and imported back, userspace can
still issue DRM_IOCTL_AMDGPU_GEM_METADATA on it. That ioctl calls
amdgpu_bo_get_tiling_flags(), which unconditionally casts the BO to
struct amdgpu_bo_user and reads ubo->tiling_flags.

On MMIO_REMAP BOs this leads to a slab-out-of-bounds read. KASAN reports:

  BUG: KASAN: slab-out-of-bounds in amdgpu_bo_get_tiling_flags+0xbc/0xd0 [amdgpu]
  Read of size 8 at addr ffff8881a19a9ab8 by task amd_bo/4574

  The buggy address is located 0 bytes to the right of
  allocated 696-byte region [ffff8881a19a9800, ffff8881a19a9ab8)
  which belongs to the cache kmalloc-1k of size 1024

Using gdb shows that the faulting load is the tiling_flags access:

  (gdb) list *amdgpu_bo_get_tiling_flags+0xbc
    1150  BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
    1151  dma_resv_assert_held(bo->tbo.base.resv);
    1152  ubo = to_amdgpu_bo_user(bo);
    1153
    1154  if (tiling_flags)
    1155          *tiling_flags = ubo->tiling_flags;

  (gdb) p sizeof(struct amdgpu_bo)
  $1 = 696

  (gdb) ptype /o struct amdgpu_bo_user
  ...
  /*    696      |       8 */    u64 tiling_flags;
  /*    704      |       8 */    u64 metadata_flags;
  ...

So a plain struct amdgpu_bo is exactly 696 (0x2b8) bytes, and in struct
amdgpu_bo_user the tiling_flags field lives at offset 696.  The
MMIO_REMAP BO is only a plain struct amdgpu_bo allocated from
kmalloc-1k; it does not include the larger amdgpu_bo_user layout.  When
this MMIO_REMAP BO is treated as struct amdgpu_bo_user and the driver
reads ubo->tiling_flags at +0x2b8, the read happens just past the end of
the real object, which is what KASAN reports.

Fix this in the GEM tiling helpers:

  - In amdgpu_bo_get_tiling_flags(), if bo->tbo.resource exists and
    mem_type == AMDGPU_PL_MMIO_REMAP, return early and (if requested)
    report *tiling_flags = 0. MMIO_REMAP BOs are a fixed BAR I/O window and
    are never tiled, so treating them as linear is correct and avoids
    touching struct amdgpu_bo_user.

With these checks in place, the slab-out-of-bounds read is gone.

v2:
  - Also guard amdgpu_bo_set_tiling_flags() for MMIO_REMAP and return
    -EINVAL (Alex/Christian)

Fixes: 9e903e5bc958 ("drm/amdgpu: Map/Unmap MMIO_REMAP as BAR register window; add TTM sg helpers; wire dma-buf")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 24ebba43a469..6c375f805866 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1126,6 +1126,11 @@ int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct amdgpu_bo_user *ubo;
 
+	/* MMIO_REMAP is BAR I/O space; tiling does not apply. */
+	if (bo->tbo.resource &&
+	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP)
+		return -EINVAL;
+
 	BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
 	if (adev->family <= AMDGPU_FAMILY_CZ &&
 	    AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT) > 6)
@@ -1148,6 +1153,19 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
 {
 	struct amdgpu_bo_user *ubo;
 
+	/*
+	 * MMIO_REMAP BOs are not real VRAM/GTT memory but a fixed BAR I/O window.
+	 * They are allocated as plain struct amdgpu_bo, not amdgpu_bo_user.
+	 * Therefore they have no tiling_flags field, and accessing it would cause
+	 * a slab-out-of-bounds. Always report tiling = 0 (linear) and return.
+	 */
+	if (bo->tbo.resource &&
+	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP) {
+		if (tiling_flags)
+			*tiling_flags = 0; /* linear layout */
+		return;
+	}
+
 	BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
 	dma_resv_assert_held(bo->tbo.base.resv);
 	ubo = to_amdgpu_bo_user(bo);
-- 
2.34.1

