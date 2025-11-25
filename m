Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F283CFD368
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 05:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A9410E0DA;
	Tue, 25 Nov 2025 05:36:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="158pUx/S";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012019.outbound.protection.outlook.com
 [40.93.195.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C16510E0DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 05:36:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFoAFbcXNoeaYrn73vdIZyliFWp+nLHfRkj8O8fgGnlz3IdDbUlrBZIUWwyhEbJHnoePJkTJkssqpYvzQdQYmFCAN1rGUO3hhgbu0VD1WRcTz/ewLKgR/elqRT6IOhqo+ReoqwxXmLQfbABDXwtgCMsUg1Bv668XrncTuAFA1AbC7/UG+Qh50YrKChhZsFe3cAplDATYK/GU6oMRUfs1+P25mYQCAXv28Xx6dfC8Mku9MNCAH/FLUxTsnX7/be8jOPCeA4iKrUP/odo51l1S3xF4zeRr2fyKlebm85FSVh49hPs+524IoNIcQT1nRokSbnKM65W20uhq48IfWg3cyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt20PmuYqdPK3m7m9AaYThxRE8AFweRhLmJGF7jmKE8=;
 b=X5zqG2/Sy14muS63wr3TiLonesmu3cX6fUbFck6dkeeZoKp3G+Ma3n3+bld2i1FFDad7ch1wW0lpMK/TPueW/n8ARF7ReWm/7tX1p0RrHZZ77HewzFCplnuCbDKQRPANYEcY76hgAw/DMV4rb97EKvbBO08Jd3M8YycuRkdhf7Qg9q3RgfDorQKHRnly40B1v55MiiCDqEI3iBnxOPe2bX5cgH1tzBn8qCAVKNcttHYE/zCjEYENE3yBJonZwkUFusvysZPLdoQCk4Buoqv1iDyanofRZJWETCglDGmBGHe+xb/FbharjQEABCZMR+y5wYTtpQLT7l4PsFJoH6ie5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt20PmuYqdPK3m7m9AaYThxRE8AFweRhLmJGF7jmKE8=;
 b=158pUx/Su9yyjY2vAvVWFhv8k38wnMxPeKEmRUylFQ2FRxEe+csHg4hhnsEWy9U82b8i43H5aPp8NUWIpJa3LqXKSPYzKEzPzPxCqsHz4ZDGAi9JAePsIXoevcgPgyalyOrSEtiGbeFNcfm3OWag6ezgb9Z2x239TZijkme1oXI=
Received: from BN0PR04CA0122.namprd04.prod.outlook.com (2603:10b6:408:ed::7)
 by CH1PPF16C2BD7B0.namprd12.prod.outlook.com (2603:10b6:61f:fc00::607) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 05:36:52 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::69) by BN0PR04CA0122.outlook.office365.com
 (2603:10b6:408:ed::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 05:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 05:36:51 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 24 Nov 2025 23:36:50 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Treat MMIO_REMAP BOs as linear in
 amdgpu_bo_get_tiling_flags()
Date: Tue, 25 Nov 2025 11:06:34 +0530
Message-ID: <20251125053634.219308-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CH1PPF16C2BD7B0:EE_
X-MS-Office365-Filtering-Correlation-Id: ce52725b-b20a-4187-54ce-08de2be4a2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RldMeUhmcXVKOHkza2hxekFZYUVKeDl4VmxUaG9VeGhpZi92SFIwR295VStG?=
 =?utf-8?B?M3Rmc2pOWUpYYjBjcENzUUQ5RmRTYkVkeTVueFpheDM4cGk4MGVyQW14WUNs?=
 =?utf-8?B?MzZZcm1WR3k0L0phNjJyZHZBVm5jNHhFUnp5VmpmdkY1UCt0SS9obHJiSjRS?=
 =?utf-8?B?RXZSNlZiRXJOeENzdGM3TDdkS2hweUFlQjJ5TzI3dWEydUdNdUZSQU0reGQy?=
 =?utf-8?B?OHZ1aFU3c0FmSFcvNDR0TmZuaDJ5Y3M0VnBSbExndWx0dVVNNHpVa0tyTTc0?=
 =?utf-8?B?VTBIT2JGNWdXQ2srYUMxdnh5UHNDcFhYTDhCcDhybHMxQXA2MnE5SWwvY3p0?=
 =?utf-8?B?NlY4SHNjOU13VVI0eENnZ1dNY3FCbTAxUnFSTk9IVUFraVkxVDBLcExUZWdO?=
 =?utf-8?B?c2NiR0Rpc2EySUZPUFd6em1wc2NVd083cmphUytwUXZQRXphbW5ja0lCNm54?=
 =?utf-8?B?VWN0QVhUaVIxODBaZkY5bDllUkswdW1aSzJNdEp1cGU3QnJBWWsxZzR6ZTdm?=
 =?utf-8?B?N0xocGFFTTkydHpEMTk1VG82bXpjaW11eTA5djlJWnZXcklmTGUyeTVGWng5?=
 =?utf-8?B?K3NvQTl3SkNvZDlvRDNLYU1MNXV5NHBhdGt5alhOdEc5bG03d2tYOHExWGVT?=
 =?utf-8?B?dDJpZG5JaSs4MmQ1eXlQQ0FqTi9mYUU4TUl5d1F1c2c0Sng5aTQrNVh3ZXAr?=
 =?utf-8?B?ZE80dXpnMStoZlQxZlM5NGpGVlFNdmY3U2taOEJ4M05XbEgrMkJXd0tGUW9W?=
 =?utf-8?B?VGYvcmpwckFwUFF1UXlRT1hJbGZEYkFJS3hwWVZYSHF5Z0k5NFJ0VmtxaEVk?=
 =?utf-8?B?K0ZyNjNpbDJMS1R2R014K1IrT01JVmRXTXpNcHpURk02K3BRa1NZaVhvdFhl?=
 =?utf-8?B?NDdsM1l2TDlOdGUxeUdFSXFRSTJuWTJ3NHVickxrMFJJZlhZQXZycGNFRWpz?=
 =?utf-8?B?STVVTkhCMXRYSEJqSXE0V3g3ZVIzb2FYWDBqbmdobWYyajlQVExKaEp1T3Zo?=
 =?utf-8?B?K2RvNEpxeU1rRnNqaFRQZGU3VFBLRmh6ekNVVnhHZmdQL3NxakdtYVpTK0dF?=
 =?utf-8?B?ZUVSMWJHVlg1WWdsdUtrc2o4dWpaMHNWMWZNRWhvU05Ud3NmdUhZMjJNT296?=
 =?utf-8?B?NU4wNEl0d2gzaGdScHJrMzlkTjFkN2U2L3IzRldwZ1Q0WWtPRDdSKzArWngw?=
 =?utf-8?B?S2ZXZkREcmxoZGo4OHVCMldtckJHcFVqVjZZQ1RiZ3Nod0RPakNSTUh0Q1dl?=
 =?utf-8?B?NXhBTE5PZWQ1MnNEbWFvN1FwS20zaFZEZ3Y5aEE3K0EwMnl0WHhBVjUwajlU?=
 =?utf-8?B?R2JsT1dEU1JraTVTZWUxT0VzbkVVS2krcXpMQXYvemgrR094aW1DYXhDcXZs?=
 =?utf-8?B?RWRNMWJuV2dLTDRzZzYxRFcrdmM4ci9Gb0FXMCs0cjZ4K3RqMnkzQTN4dTl3?=
 =?utf-8?B?VFZtQ1VycDFLMkxLUWNLc0d2Z04wbUtSaVd6UmlINVN6cmNyU25RVjkxTnUy?=
 =?utf-8?B?S3RQaVFrY0JDOFRTVUhOa0hKa0llbkJseEtvWnF6U3JEMHRBb3UwSklTMzJa?=
 =?utf-8?B?eFBnd1RWOEdjYzN3TmlxTHVzMWpJYUs2WlNqNVBWbHYrcHZHQ2RHUjBWcVFy?=
 =?utf-8?B?L1VyUVYzRktuekJGSWJIanJ3eGxRbTk0cmtyODJLK0RnZVJhWkgyTENlU3kx?=
 =?utf-8?B?ZTRzRTNlUEJSUWx0Sm1jM09naXFpa2JtV09uQk14aVMxTlpzUldlTTY1Wkt4?=
 =?utf-8?B?bVNFNUlubjRibUQrbURtckZmdk9wWTRKNjRkNDVhZ2JhYzJMYWUxeXRZL09E?=
 =?utf-8?B?bkFKZEd0UG8wazcvVHhuVStacTNoQTVYL2w0L2ZUaEM3bHJ2NlIwNitDbE02?=
 =?utf-8?B?RUtqbEpJdVVZZXg3QU5yRnM3d0ZiZkhqL2t0WlAxMEtZdzF1N0lmR3NVL3Va?=
 =?utf-8?B?N1c2UmlqZ0dQV0VNN215SFdUT3FYeFAwSi9ZZ0YrUVB4TmN5TUxuc2tFRlhF?=
 =?utf-8?B?SmNreWtmcW9XNGN6RWx5bG5Lc1NkTW5oN1RlcHpGVUVoTUZ6TjNPQkVZeEh0?=
 =?utf-8?B?bmg0RGJBUXhRdmRFRmVEa2ZJMmdLcW5kWmt6d3lvclBZSnkrOW5xWUtEVGVl?=
 =?utf-8?Q?Ks7Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 05:36:51.8538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce52725b-b20a-4187-54ce-08de2be4a2ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF16C2BD7B0
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
mapping. They are backed by a TTM resource with mem_type ==
AMDGPU_PL_MMIO_REMAP and are allocated as a plain struct amdgpu_bo, not
as struct amdgpu_bo_user.

When such a BO is exported via dma-buf and then imported, userspace can
still issue DRM_IOCTL_AMDGPU_GEM_METADATA on it. That ioctl calls
amdgpu_bo_get_tiling_flags(), which unconditionally treats the BO as
amdgpu_bo_user and reads ubo->tiling_flags.

On MMIO_REMAP BOs this causes a slab-out-of-bounds read. KASAN reports:

  BUG: KASAN: slab-out-of-bounds in amdgpu_bo_get_tiling_flags+0xbc/0xd0 [amdgpu]
  Read of size 8 at addr ffff8881a19a9ab8 by task amd_bo/4574

  The buggy address is located 0 bytes to the right of
  allocated 696-byte region [ffff8881a19a9800, ffff8881a19a9ab8)
  which belongs to the cache kmalloc-1k of size 1024

Triggered by the amd_bo IGT test:

  igt@amdgpu/amd_bo@mmio_remap_dmabuf_loopback

gdb shows that the faulting access is the tiling_flags load:

  (gdb) list *amdgpu_bo_get_tiling_flags+0xbc
  1150         BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
  1151         dma_resv_assert_held(bo->tbo.base.resv);
  1152         ubo = to_amdgpu_bo_user(bo);
  1153
  1154         if (tiling_flags)
  1155                 *tiling_flags = ubo->tiling_flags;

  (gdb) p sizeof(struct amdgpu_bo)
  $1 = 696

  (gdb) ptype /o struct amdgpu_bo_user
  ...
  /*    696      |       8 */    u64 tiling_flags;
  /*    704      |       8 */    u64 metadata_flags;
  ...

So a plain struct amdgpu_bo is exactly 696 (0x2b8) bytes, and in struct
amdgpu_bo_user the tiling_flags field lives at offset 696. The
MMIO_REMAP BO is only a plain struct amdgpu_bo from kmalloc-1k. It does
not include the larger amdgpu_bo_user layout. When this MMIO_REMAP BO is
treated as a struct amdgpu_bo_user, the driver tries to read the field
tiling_flags at offset 0x2b8. But the MMIO_REMAP BO is only a plain
struct amdgpu_bo, which is exactly 696 bytes (0x2b8) in size. So the
read happens just outside the real object, because the field does not
exist in this MMIO_REMAP BO. This is why KASAN reports a
‘slab-out-of-bounds’ error

Fix this by treating MMIO_REMAP BOs as linear in
amdgpu_bo_get_tiling_flags(): if bo->tbo.resource exists and mem_type ==
AMDGPU_PL_MMIO_REMAP, set *tiling_flags = 0 (no tiling) and return
early, without touching struct amdgpu_bo_user. MMIO_REMAP BOs never use
tiling or metadata, so this is the correct behaviour and avoids the
out-of-bounds access.

Fixes: 9e903e5bc958 ("drm/amdgpu: Map/Unmap MMIO_REMAP as BAR register window; add TTM sg helpers; wire dma-buf")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 24ebba43a469..3c8c2b64af83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1148,6 +1148,15 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
 {
 	struct amdgpu_bo_user *ubo;
 
+	/* Avoid slab-out-of-bounds for MMIO_REMAP BOs */
+	/* MMIO_REMAP is a fixed BAR I/O window, never tiled */
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

