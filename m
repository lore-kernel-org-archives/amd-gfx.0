Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBFCD1039B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 16:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 274EF10E141;
	Wed, 26 Nov 2025 16:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fGsu15Dn";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDC7710E141
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 16:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YN3BtAYzz2MjbHgeYm90cBzoKQH3tEvi+6eCNZpCAIA2WKlNuv/DEKKoQFa19JNnQxBtn7Si9cIxdbthEGw4fEj5YiuwHtOfYEbOKPRt5GJl+1Jtjta237zl6/y1rFeewchDqyJoDDtObb+oP+0iNxC2ppCZzVarVLiddx7GQvMEpI4o87JE0bNkc8ZOepYooUnjcxalJvoPLXid7Aj50TjOF972OpQ3Xa8gWBJ/y4aVjyHRLW9hcTgKBs+dxdxB9WC+T76xaNAujo+hGP5ZUpry3bRE9d8pc/+Jn8RC/RyHS+YmggoglgaKkhMy4wFaindjhhtTkt3P0a1FWlvqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7QyOEkOq4tHkNqZFWCP7UouLv1CnoqWvt3/F33idtA=;
 b=cqwNCWG3wDka7Yg+eEMnCSbLzCFQH/xtqDCzN9x9nBIRTF4qdOadxxBS58uiadH7t9Sw3I7tjVo8MnQhaWUiTSfN6+vW1DU0Q4G3T4Yby2FvnuiVuAXky56Zm/8xYha8NTBZhHUUv/XJMq5sMCd4EtS9ZQzI+BypsAhlie0KWDAjNyephz5B3kdi+Y3zZbhATUp0cTox9frLfxK7Zoi/ZsbwMiXFRm8AI0kn7/NAhVjJiZQXzYYP98n6UQ42hWaHrHmccZlQNiRDQ34oh/O4s48oOdvwM5fdqn4JXsciNRVtduud0b3tS002KECSEZfYmdpjPAcO+u6H+mDup6oT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7QyOEkOq4tHkNqZFWCP7UouLv1CnoqWvt3/F33idtA=;
 b=fGsu15DnZHWeLIsB6SgSnWsBLsoQCG4AGrh5UFsJcnuQvI/jpbC3275iI+G48DRoWEBup6Je27svjHEtpZZzet7bhYsWp3xO0lNLaHJuM8mI+grm/0zxR1HmS/4QdqKzXSEHfftWOVdCWy55hBgn/0cg8R/YzA97bibfbfSNppQ=
Received: from CH5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:1f1::8)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.11; Wed, 26 Nov 2025 16:43:46 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::2) by CH5PR03CA0022.outlook.office365.com
 (2603:10b6:610:1f1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Wed,
 26 Nov 2025 16:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 16:43:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 26 Nov 2025 10:43:44 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu: Treat MMIO_REMAP BOs as linear in
 amdgpu_bo_set/_get_tiling_flags() v2
Date: Wed, 26 Nov 2025 22:12:08 +0530
Message-ID: <20251126164208.232579-1-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 5717942b-51eb-4359-e308-08de2d0af7e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0RIaTlXT3FtMEhVNVpGamY2NHMwTElqc3QvN1Nsdy9SdjFGTW9KNFRoTEpD?=
 =?utf-8?B?aUJpSkduUG14akFQVUFJWDFEK2p6OHdDT0pjM3NiY2dWR2ZjT3VWV08xa0h5?=
 =?utf-8?B?US9OVVRjRkVVWnQweDd5bVU4dzRUZkVWZmlMWVkwZis3eDgyQ0o2Z1RwUkxN?=
 =?utf-8?B?SVJ5SG1jNlJNTFdGc0dDV1pDTFdGVERoZzdnVXJYT0pKVUhKNGpIWTJyZ1Va?=
 =?utf-8?B?ODZGby8rbmFtK1NDZHBRQm9JMVBOL0JabkRQZGd0OTRlT2xMUU1iVWZaR01Y?=
 =?utf-8?B?NGZlUG1McDExQjlrVkFmekdpU2FES2tRZ0FBOVdPR2N5UFlPM3UxaHZ3SEZB?=
 =?utf-8?B?RndEaWNGRW5Ob2lVMXAyZVc3WmdTcEowY2o4RHFJWnpaMjVyVkQreEgzdEhi?=
 =?utf-8?B?UGRoT1F1UXdQdC9xVnVlTkxPMDg1b1paeUFhVlkwUWNISE03UkQwVEpkZGNZ?=
 =?utf-8?B?UzkwS2pMaGlDYXVaOWZwQ3hHejZmQ0dRUEpCTDJhY2N5cGpjZVhNOHVPcTBa?=
 =?utf-8?B?M0FsMmdMQ0hZeHVlZVpwQisxVHIvMHg3a0QzaHVJQ1orMnd6SmlHQjZ5S2pH?=
 =?utf-8?B?Z1dDMVlIaEdVWmpkL0R6TUROWjV0Q0JIdjYvMndJdXpYZVAyOFNOU1VuYks3?=
 =?utf-8?B?S20vTGwwZWtHa1hVVFZYc0piOFo4R05GVENwTE9JS2NYMkNwMU8wMzY1d1oz?=
 =?utf-8?B?M1FEOXRYSlpjRVdTVDJ0eUFuU1dBZ21KYlFnbkNnZS9ITDdORkQvdC93S2lq?=
 =?utf-8?B?OGlKZUEwWUxLVGpiczVkWEpxMmoxeUxxdEwzUW1CSFZDR2I0TjdpOWhsRjRF?=
 =?utf-8?B?U09FdjNJZE5VZkZYOG5ZakhOcm04b0lrb1Y3R1JvWjlidjZkbUlFU2NWbHNY?=
 =?utf-8?B?QW43enN5VmtEMWdHamZ5Um5Ncno1b1RKUWF4ZXdjVXY5NExOR0RDK1BOeEJC?=
 =?utf-8?B?NWxzaE5vVm1aZzBiYzJ2eGNvaUlGTDFEeW5LdVFTeFA1WGxHdHY1L2ZXZ2xW?=
 =?utf-8?B?UHU0d0YxV2FrUjlGeExCMHlZcUxLRDZNRUNVNnRYQ24yS1RMN0ZwT2tXQ3JW?=
 =?utf-8?B?bVBLd29NK3JqZlYwSUFwckw4OHd6V0J0VmIzWVNEZWJEUVprSGF6K1hjMjVo?=
 =?utf-8?B?WnpueVRyekgvem41OGp1NDlxSkMvb2dGUlpvbkIwalZ0aHJXTS9FUWJCcjNN?=
 =?utf-8?B?STJpMjdvUmhvREhqUm14d2NLd0s2MjdpamhuWXloNEl3dEUwWXROSnBzaTJG?=
 =?utf-8?B?bENJZlBVVzdxZUl5OTNQejFObHV5THJYUUFGT3Y2VUIwUjdRNHpFMmZWTTZz?=
 =?utf-8?B?c3RJWG00YURRVlpEZEhEU3FjVVFDTVZqVEdocFhyNE5uc0FRaVE5QUdDREhQ?=
 =?utf-8?B?Y3Q1VjRoZTZuVyt2TFFpN1ozb3Y3UWtVZEU2N1ZtQzJXY0NITllIWkd0Q0ta?=
 =?utf-8?B?bTB5ZUJvR1hITUJ4NlhkZUxWcngzRFVSaXZSRXZCSWp3b1EzcnhLMUJHaExE?=
 =?utf-8?B?R1Nnd1dkYStoL1pFMGNTOTNEZ0dMeXp6b0VoQy8xa2U1d0hsL2RBdG4zQmh1?=
 =?utf-8?B?NkZUdFF6MGcyTjBQZEJwU2FSTzhveVdGMkRsUXhBUEtLMjd0YllNNUdzOGY1?=
 =?utf-8?B?VVdoTWRadHpYdnlxN08rZjcwZmFjMXQ1MEw4Uit2SlZVczdGbklWR3IybDU3?=
 =?utf-8?B?WWFXVGpzU2NGbVVzeHR4ajFTcGsreU93RDZtZzhvaGJBTXlMaERQSWFyUGJs?=
 =?utf-8?B?clJHRjFvME1LeUZBM2xBbm1HR0IvY0JFVUtWWXdZclE4RGFNWE9Ca0dPMEs3?=
 =?utf-8?B?ODJjd2hSWnBWYkdNYUJaRit0d0NXM0JoM3RoTmord3oxZVl2V1JjZUpVcFo2?=
 =?utf-8?B?YzM0enRDc1RTV0g4cFMwN1J1ZWNqenAycUhnVmlNZ0VNa3pueGN5aS9iNHhl?=
 =?utf-8?B?Tm9sbitzd1lrTko2L1FPZU11YkFmRkVvZXVPZm9VeitpZERRc1hHUEdmTHEr?=
 =?utf-8?B?dzdHZjQyaEQ0Qm83OHdQSUdGRGhndlV6UGYzOHA1dldMR0RPMVUxZGJLMmlX?=
 =?utf-8?B?cTYreEFZSkh6L21kUHdqeHZ0Z3R6VktSWForS3VObW5SWEdRaSs1dkQzbGIz?=
 =?utf-8?Q?qEWM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 16:43:46.4789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5717942b-51eb-4359-e308-08de2d0af7e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
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

