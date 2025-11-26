Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D212D10F28
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 16:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5B3410E2C1;
	Wed, 26 Nov 2025 16:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w06zBHvL";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B3DA10E2C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 16:46:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vavaLsLZ6OLj8JZgaHMpQGE6QSJ8RK9YuGXOfKahqKse7Dcc1A9bAz5CvrfJHHS/KGN+iQSY383q+y7kccu6Spl3npKpQbM2L15BoMZ/0q/OrOZGcMcesTguwScEhBYWpH9ZzfIljgg/ziQJ8Zb2zDF+X6I661BV15YOwSy3ntYIu8ucWOOvrCngOrUgil1cxvSbQmf5QhmGZlr7sH4rM/2401c73cCgyiCpJJaBIxD1RnbUWVFBR5/ENUXikL9pvvrdWTErPsdExYBOVGnuVSDFMKPFHC332qiP3KQaiWsaa9u/onKnC5BwH4fRyyqRnoJLS7KG/V7nlUxao1n2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL2nKdLh4EWpTJWShPBLqBvWTyPD9d15TwpgthjRD+U=;
 b=ex3M/5FMlDTYcbfdAzCSLun5CVVDACpmVNlUF/vobaO0gu5BZvuyfTkcB4rnTEken+p+rcuWpf0CKzrjTeTbwkaGOUE+0Y38XZQQyrhJhT08pjYb0a16T9QtqnJweH/tg9bej1B1q4lWT5UOXJ6XmPKKFH1+xfnrylx+mg+5B1+kleb7amuQ6JJYgrzFOz3XfC9FSbAzkCyIr2xI9Ar3SwZI9h01lOSxaP78UEdDBvoEzJ6P8GwP2VoJPFySsuFG8ylzGjTOnWAoMrF3DYZsUJEQLBaGjcNS0k1ie9sr8TTf7JUJsHA7wqe1TH9ufVMo/GFL/3OkGMInmt20AwSoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL2nKdLh4EWpTJWShPBLqBvWTyPD9d15TwpgthjRD+U=;
 b=w06zBHvLbnzy2aWY70zdbd1oglzB/73Ulaehh3ZTxk7tPS6aOkSjFqli6b1ke4VpIALYcFrPIc8ZIwVMzYyc4m8HffFBpmegqqsVu7PcbT1+6pO8YQZoIhFVGJDJZH0/nlP3FlCWirSCeQ/GTDC6fpFacOEVDEsk5hQ2D89A+ng=
Received: from BN9PR03CA0761.namprd03.prod.outlook.com (2603:10b6:408:13a::16)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 16:46:55 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::d4) by BN9PR03CA0761.outlook.office365.com
 (2603:10b6:408:13a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Wed,
 26 Nov 2025 16:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Wed, 26 Nov 2025 16:46:53 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 26 Nov 2025 10:46:50 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3] drm/amdgpu: Treat MMIO_REMAP BOs as linear in
 amdgpu_bo_set/_get_tiling_flags() v3
Date: Wed, 26 Nov 2025 22:16:37 +0530
Message-ID: <20251126164637.232668-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251125164345.224298-1-srinivasan.shanmugam@amd.com>
References: <20251125164345.224298-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 551dd277-1304-4589-2996-08de2d0b677e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUh4amxsV1RPMXB6Q2pNeUdaY2pFL2lGWm13MnFEdEk2SC9TSTA1bjBqYU1K?=
 =?utf-8?B?RFF4YURQRzZmc2FnaWgvSW41WFg5SDFQWkR5VUR5Wi9YZEJadXpFQktmTmcr?=
 =?utf-8?B?RlV0MmtxYTdZTlE5ZG5zUWNHMjR6WWs0RGlmOVpKenFvTGV6SmZvRGZIajJK?=
 =?utf-8?B?LzYvcy9Ua0Zycjd3cis5ZEFRNHBndUo3YmxXMWJCSHpWMGw3d0t2U3hvb2FO?=
 =?utf-8?B?MFR6WnZ2UktUa1RWQTVkZFhrNnd4TzhQM2Naajh3K2xkQ0NsNjI3cytaUENo?=
 =?utf-8?B?VWJ6dlI1eGRaYTRWYzh3My9LQVZhTXpSZ1kwT2pxTUhuRXBiZEZ6YkdSMlJ1?=
 =?utf-8?B?Q28rWEV3ZHcxOWFzdHVxSjBmeDYzV1NqNnp1ckl0Z21OZDVkeGpWcXZJbmlV?=
 =?utf-8?B?MSs0eFZEdzJ0cmJmQVpPak9rMnliZUN0UEFRUmRBcTZYQWx4OThCRDRHT0k3?=
 =?utf-8?B?b1hPMVR6UCs1WXppWE9RNUthbzJpNWFuRE1uV3FneHZaWXcvK2dyYTNtSUZB?=
 =?utf-8?B?TmRtbkJXNklVRDlGYk9vdXhDZlFFQ2F5TVRYbnJkdmV4c0NpNjhzTUllejBm?=
 =?utf-8?B?SEFJS2tmWG1QY3Q1ZUNrSUNZaHlvekhCRjVRNzFoc09sRWgxVTc5OGd6Q3R2?=
 =?utf-8?B?RkNkc3RycmNOY21pNnU0bG9wQlpsd3ZhRjRPdVdHR3poUUV1cm9PN25JaFlq?=
 =?utf-8?B?eXpEeXB6aGZ4L3pXTjM0L3gyUDJUUzBkcnpwaS8ybWpBaEpmeElsMFJLcGhn?=
 =?utf-8?B?SExNYjBTd0orR1lUN0UycmRJR1h5SXJ5clJrV3RTVTRRQTNuYTZrNGNrdXZY?=
 =?utf-8?B?cHZVbXljZnROakxuWnpDOXF2VVhWSDVrWW1GdlVhZXVzTHoyRm5HK2hMbUor?=
 =?utf-8?B?YVVRcStMWS9QckhINERZQmNwRVRxWmVNU09ReHFEd1VETU5uMk10cFg4Qkdo?=
 =?utf-8?B?S1dNRmdXWmROM1pmczJCaTBoRThPcDVmYnMrcExDRDNHWWNEeXgzSFduaUkz?=
 =?utf-8?B?Z1JacFc1WGF3VTIwdnowcFowYnZGa2p4Ly91VXhBMlZQMWp6QjcvaXZRbGRz?=
 =?utf-8?B?T2RINlp4Q0dpc3ZKMUh0aHFXN0luaG9Vb29RWW1rY09BSWRZRmorditIVW8v?=
 =?utf-8?B?NGszd0R4L1ZPeXNyRU1JV0FWcGtCYVYyWGppWkZHTG1SelhUd0FiYW1wWFJu?=
 =?utf-8?B?N2Q4V2hjd0VHMEwvcHJKWlJkVklaVGl3MWpWbjdFMDJtcVllMUxvaWF1bThm?=
 =?utf-8?B?Ri9FUlJxNTNQQjdINGQzNTFKZDNGWWZMTE82QXR4VW5INzlCM1B5bmZRQmZr?=
 =?utf-8?B?Z213VFlLeTBkb2hGNzQ2d1REL25TZ2hGM3I0TVhBcDFVMFN6ekxjMzRremNG?=
 =?utf-8?B?cXBvTDBzempHZGl1NXVZbWJxcktseDA5Ny9aR1krN2RJWjhFc0h4ZW1FOE1p?=
 =?utf-8?B?aXp2czdTNS82MVBvRzhoZ0F3b3JRdkV2dDYyRkI2RGZaVUtFRmVnSlp4a3Zw?=
 =?utf-8?B?YkxHeXBybFl5dkd1NVZGQjlpdlJYVFRmcUtpSzJaOWY4OHJjNk5CUWFkcGts?=
 =?utf-8?B?d3ZXTWJTRFd5VzZWQVVtQjA3UmppRVE5VlFDUzVBN1VBYUlmcDZ1SHJMcmpY?=
 =?utf-8?B?SnVZUkdDeW9BNVdzcm1Dc3JQdXdzaVdZYlZsTzZmVUxYTSt6eGtTTHJCZ2JM?=
 =?utf-8?B?czRRS1pKWE1ILzNSY2t6eVFvaERuM1lwTGRrWXdJNGtEL0MwMjdYS3lJK24w?=
 =?utf-8?B?S2pzTlR3SXdLek80TUIvbGtBenhhenk5STJ4cFVqOUcwQlN6c0tkSHRwV3VI?=
 =?utf-8?B?eXhxSHkzZTVQWHBaZmNITExEUkx1dEptWlNWTlloV2d2ZjdTNFRUTGRFRjM4?=
 =?utf-8?B?a3RoeE9lNGZOeE1ZK25UdW4yb25MN0dNOWNyd2JMRFBobXllUzhqNUg3Vnh5?=
 =?utf-8?B?TkxISVZTNlFxbmdsTEw5UnV1ckVNM01qdi9TVkZIQ1h6RmZRSVEvYUNLUFdS?=
 =?utf-8?B?MHFBMzJnYmtwSUpqUkN0Y1BJNCt2T0wzWUx5OTV6c3NDU3RMTHdzUEFwRnF4?=
 =?utf-8?B?cXh5WFJUQWVvMkNOQ2JXUmNPTkVUaGFVODZqbDBieVRuRDdsWGNpTE1kcWNQ?=
 =?utf-8?Q?lGk0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 16:46:53.6982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551dd277-1304-4589-2996-08de2d0b677e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
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
    mem_type == AMDGPU_PL_MMIO_REMAP, warn (if requested).  MMIO_REMAP
    BOs are a fixed BAR I/O window and are never tiled, and avoids touching
    struct amdgpu_bo_user.

With these checks in place, the slab-out-of-bounds read is gone.

v2:
  - Also guard amdgpu_bo_set_tiling_flags() for MMIO_REMAP and return
    -EINVAL (Alex/Christian)

v3:
  - Move MMIO_REMAP rejection to amdgpu_gem_metadata_ioctl() and warn on
    amdgpu_bo_set/_get_tiling_flags() (Christian)

Fixes: 9e903e5bc958 ("drm/amdgpu: Map/Unmap MMIO_REMAP as BAR register window; add TTM sg helpers; wire dma-buf")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f2505ae5fd65..dacfc57dd179 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -719,6 +719,15 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 	if (unlikely(r != 0))
 		goto out;
 
+	/* Reject MMIO_REMAP BOs at IOCTL level: metadata/tiling does not apply. */
+	if (robj->tbo.resource &&
+	    robj->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP) {
+		DRM_WARN("metadata ioctl on MMIO_REMAP BO (handle %d)\n",
+			 args->handle);
+		r = -EINVAL;
+		goto unreserve;
+	}
+
 	if (args->op == AMDGPU_GEM_METADATA_OP_GET_METADATA) {
 		amdgpu_bo_get_tiling_flags(robj, &args->data.tiling_info);
 		r = amdgpu_bo_get_metadata(robj, args->data.data,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 24ebba43a469..138fd62a47a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1126,6 +1126,10 @@ int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct amdgpu_bo_user *ubo;
 
+	/* MMIO_REMAP is BAR I/O space; tiling should never be used here. */
+	WARN_ON_ONCE(bo->tbo.resource &&
+		     bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP);
+
 	BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
 	if (adev->family <= AMDGPU_FAMILY_CZ &&
 	    AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT) > 6)
@@ -1148,6 +1152,13 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
 {
 	struct amdgpu_bo_user *ubo;
 
+	/*
+	 * MMIO_REMAP BOs are not real VRAM/GTT memory but a fixed BAR I/O window.
+	 * They should never go through GEM tiling helpers.
+	 */
+	WARN_ON_ONCE(bo->tbo.resource &&
+		     bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP);
+
 	BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
 	dma_resv_assert_held(bo->tbo.base.resv);
 	ubo = to_amdgpu_bo_user(bo);
-- 
2.34.1

