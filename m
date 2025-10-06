Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02432CCA476
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 14:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9494410E1ED;
	Mon,  6 Oct 2025 14:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NNKVy9bQ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA6110E1ED
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 14:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z18aAit8fCUKXiLUp+yCYpFDmq01j3OgEpZ2el9wbXKUmmedCy4mJPdZc5XedRIx3CX3MMmaHHSsbmNuVfSW7Du4p1NlWhZAeUifta5GlClVeh4W22lE0+mG0xkTcRT5M5lujsgMcFCj+oewKqBuPvfE7ouPvGdN+rCxNj/kvqLVwUL8/Ed1VSUHYNFaojJTLm0fc5uUXB1UDGg3sVt3YIZGcXLKxwAbdDMXhOM40isThwXmVC9jK5wQm7s4drG0GVxxr+E1ilGHJAA75B6KKc4hYGZ3xwZZN2jHEcQEnAN6rEs+HQd3TTIHWvo+I1Q3qyBkfzm7OZiMMycUVGiEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDC5JDSbBrgvTdqPsBzTyK+ySP+55TI80syyiU3IvWQ=;
 b=ywzFAFzlyHbLyv9KyiNnq9zxL572PrMb80CyHvze8d/D31bGoKU7AL75uOmotvC7MHr0iHeOCH9OOljyaZHHkFXFzUsDtBO4Ybzf74TM8Z3WwwoJ9F5HlVV4v7JzOAutYIwEzWUNV9lwmN9Nk2gA5QLdVb2L7LcwG2bmV1iwnsqHgnvZytlI4Ybt8JLgmryvs1g6AjVivw37Fe0WwcX5UbsLQZR2siUmQeVL87Igczjy4fL8o2fbQBvG31XHlI5eiT8RPC9X4rM62FfmwhUpBAo5eWmgPPdKvFpn/IEFzntdBfNR3celKH58SydiPcPUIFPcRNweJDAJO6SSF8igGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDC5JDSbBrgvTdqPsBzTyK+ySP+55TI80syyiU3IvWQ=;
 b=NNKVy9bQ9uMurtwBtsgMAjZqc7fkx5MffZ146mn+f/AZALF7C4rjxcioJXY90TMDe1FG2/4KKOPzdp3NJXOZCQ5C3Tyk/31LEMsaGeUOuC09XjT7fIFK72ks7jIB03gwzroYXQ+kgT7zk23yZAG86iuByFAuCF+1n8I6zQeK2Lw=
Received: from SA1P222CA0096.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::23)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Mon, 6 Oct
 2025 14:17:16 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::55) by SA1P222CA0096.outlook.office365.com
 (2603:10b6:806:35e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 14:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 14:17:15 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Oct 2025 07:17:13 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: Map/Unmap MMIO_REMAP as BAR register
 window; add TTM sg helpers; wire dma-buf
Date: Mon, 6 Oct 2025 19:46:54 +0530
Message-ID: <20251006141654.32291-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006141654.32291-1-srinivasan.shanmugam@amd.com>
References: <20250912111148.833465-1-srinivasan.shanmugam@amd.com>
 <20251006141654.32291-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b1cd09-2e8d-4a2b-a54a-08de04e30d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmQzdmNJRW5jVTdlb2tKWG9HeWc5Vm1iblVSK2JCRXVycHkwS0gwaFNoQkZO?=
 =?utf-8?B?eWJ5bFFLRkwwNHRycWZqN1FlVkIxb1lMM0hwWURmNmdOWTd0Y0pySHUzc0xO?=
 =?utf-8?B?L1FZQ0FQMXFIVnF3eE1iRXFETXRieVBOcS9kRGp5ODlGMDI2OGJvSG41ekdY?=
 =?utf-8?B?TGgzd3ZHUnI4aUdJSDFBUVJId21lcEYxNzV1bmg0SXNQZ2NqcHRIRWdJZ0xK?=
 =?utf-8?B?NWJ5U2RwSUozd2gvVyswTWc2YTErRjNiMHVzVk82SEtJNmNTTEpZTk9jZHc4?=
 =?utf-8?B?YzAxMGRRdXJhL0JONDZXcXVURkZqakJoekx0bWZOd1E5YUNyb3F0cDZOOEJN?=
 =?utf-8?B?ajE2bFNQaDZ4ZXRtaGhOYkRZVmkzbW15VmxKZVN6Z05jQUE2b0JXeGZQVnN4?=
 =?utf-8?B?djlxZW94bGxNOTlMV3kra1p4WXphM3RwQWN6WlN6cTFnRWJmRnVqTEVkQkFR?=
 =?utf-8?B?ZUw4VTFRZ3JFYzhUdVZIeEVFRytjWCt2a0Vmc1BaUFJCN2pmNU5xNC9iZ3Vj?=
 =?utf-8?B?ZXhDZ3NoTjNrdmZBcC81RnhRdXd2TCtQOFI5UGFqOE5ISEtiVmlZaUloS3h5?=
 =?utf-8?B?MzcyeklPQ204Y1lLSG9FVTZnVEU1ZkdJUzVRczVXYTlHTmFEUUtqdU1VV2xp?=
 =?utf-8?B?T2ZzallsczVPV1N2WFdWV3o2NEQrazlpOFlLc2NlVC9SSXBTWkQwc21SdUhN?=
 =?utf-8?B?UGIvRHd0UVJhbmNjMi9hbzVQWW9xNmNONXJHWit6dGx6T2J0RFN1ay9mQnNl?=
 =?utf-8?B?dWZncDVIVUdQOTNlRlo1cHZnRVY0Ni9Jb3ozQ0NET25yTjNxdGF6a2hWTzJU?=
 =?utf-8?B?N21kSFhuT2Z3N2hwUXZuZzVKZlp1R0xWdEhPc2sydGlHeG9jQU51YndhMjVl?=
 =?utf-8?B?Y3RNT1V2MTdUS1dwWjNvRlNjWlg3KzN1TjZ3dlhlUHR6eU9SV0prWUR3R0Y4?=
 =?utf-8?B?Wmg2V1BIcHVNK1ZueTdpYmtxRDhjV1g1ZnVlL2h4M21kUXk4L3FITDZGakFV?=
 =?utf-8?B?TG4yZGF4SzFkbnpWKzBtallMOWRPc2RTM0ZSc0FsZnJjaXpHRkFXeldjVjBQ?=
 =?utf-8?B?dkd3aWQ0UWhCSUZVQ3pPa3VHQWlVMSswZEFkaW1zOWtMMzVKM2hqbDBJOWQw?=
 =?utf-8?B?UmdWaFdPTEJZdTBWMGJuSHQxdUxlWFlEWForcWhQNzZiWGdQNFdsYkQ4T0xY?=
 =?utf-8?B?dFZFYzZLZ2l5bzZLTnBvR0ttNTVsT1JIVE9RS2FkL21KRndlTkFIYVdQcE9N?=
 =?utf-8?B?UjRySm5EcnluN0xZcGJ6ekRMRk1yUW5KNTVFYnZTOVIzbnQrQ0VRU3RCL0dU?=
 =?utf-8?B?UFlzRHVlZngvQldwdWtaRUNKN1ZpQnFEUmtMUjJYRDZYOU1oSE9aODV3OTRP?=
 =?utf-8?B?ZG1zaWVmbm5pd0tJYVhUR1FPRGtpVFRwQjBJV0FkLzdJcVN3SXg5eVI1L0hr?=
 =?utf-8?B?d1RDZm4rdnFjeGtURUhndUZad1oxdWliUk4zN0xIb2V4OU5HbmllRHpILzkw?=
 =?utf-8?B?dXdyaGxvVVNYUUk2eVdWczcvWVNBbVBEemxOQ2Zvb1cyTldCdk5JWE1ZYnZX?=
 =?utf-8?B?OEtaYmxLVCs3aTlyTmQ5ZFNMSFluUzVhTThYcVpJVDJuTXJYcjBmNGpaS1dX?=
 =?utf-8?B?ODh3SFp3aTBJOXJrd1hsUmdyTjRhQkErbjBSTEdoMkxVZFVsbVlWNkZKOHpV?=
 =?utf-8?B?MmZ0cWFybHJFTDN5d2J4R2RjTmc2WnorMEYxSFdnYWhSYW9IbWJYL3RUNld2?=
 =?utf-8?B?MllZK05TVUwzL0Q5ZFRLU0g4eFJ3WEd1RGJJb3FBYTJOZS95Z1ZvZ1VwR3ht?=
 =?utf-8?B?LzU3VFgzblZ5ajVPeXpFS2ZYcGVWVW9qTytTaDZ5QmRwL3JDT0E0d0VhSU95?=
 =?utf-8?B?ZXhsQWJxSWVGeUNXQ0pVaThqU2dMM0tUcEJ4YmZRT1VVV3lrd01BWU5jMzhB?=
 =?utf-8?B?Q1hwWGRMK3JhKzRvdTBWQXNyYWsyT0pFVU4vQ0ROYmNHUzRzUGRqVkFPR3hm?=
 =?utf-8?B?bnFQdjk1ZUI2c1ErWkhETzhQdldUaGJOVGtsQVFmYlJWby9ESEhKT0xHQVgv?=
 =?utf-8?B?QWpybEJpeGpCL0pqcnl3aGQxWTA4dlorVmMxaWwwekdZbDIxV2ptRkRFZUw2?=
 =?utf-8?Q?yO/I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:17:15.6460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b1cd09-2e8d-4a2b-a54a-08de04e30d19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
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

MMIO_REMAP (HDP flush page) exposes a hardware MMIO register window via
a PCI BAR; there are no struct pages backing it (not normal RAM).  But
when one device shares memory with another through dma-buf, the receiver
still expects a delivery route—a list of DMA-able chunks—called an
sg_table. For the BAR window, we can’t (no pages!), so we instead create
a one-entry list that points directly to the BAR’s physical bus address
and tell DMA: “use this I/O span.” - A single, contiguous byte range on
the PCI bus (start DMA address + length)). That’s why we map it with
dma_map_resource() and set sg_set_page(..., NULL, ...). Perform DMA
reads/writes directly to that range so we build an sg_table from a BAR
physical span and map it with dma_map_resource().

This patch centralizes the BAR-I/O mapping in TTM and wires dma-buf to
it:

Add amdgpu_ttm_mmio_remap_alloc_sgt() /
amdgpu_ttm_mmio_remap_free_sgt(). They walk the TTM resource via
amdgpu_res_cursor, add the byte offset to adev->rmmio_remap.bus_addr,
build a one-entry sg_table with sg_set_page(NULL, …), and map/unmap it
with dma_map_resource().

In dma-buf map/unmap, if the BO is in AMDGPU_PL_MMIO_REMAP, call the new
helpers.

Single place for BAR-I/O handling: amdgpu_ttm.c in
amdgpu_ttm_mmio_remap_alloc_sgt() and ..._free_sgt().
No struct pages: sg_set_page(sg, NULL, cur.size, 0); inside
amdgpu_ttm_mmio_remap_alloc_sgt().
Minimal sg_table: sg_alloc_table(*sgt, 1, GFP_KERNEL); inside
amdgpu_ttm_mmio_remap_alloc_sgt().
Hooked into dma-buf: amdgpu_dma_buf_map()/unmap() in amdgpu_dma_buf.c
call these helpers for AMDGPU_PL_MMIO_REMAP.

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 18 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 80 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  9 +++
 3 files changed, 107 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index ff98c87b2e0b..2fbd6d458a6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -37,6 +37,7 @@
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_ttm.h"
 #include <drm/amdgpu_drm.h>
 #include <drm/ttm/ttm_tt.h>
 #include <linux/dma-buf.h>
@@ -210,6 +211,14 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		if (r)
 			return ERR_PTR(r);
 		break;
+
+	case AMDGPU_PL_MMIO_REMAP:
+		r = amdgpu_ttm_mmio_remap_alloc_sgt(adev, bo->tbo.resource,
+						    attach->dev, dir, &sgt);
+		if (r)
+			return ERR_PTR(r);
+		break;
+
 	default:
 		return ERR_PTR(-EINVAL);
 	}
@@ -235,6 +244,15 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
+	struct drm_gem_object *obj = attach->dmabuf->priv;
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+
+	if (bo->tbo.resource &&
+	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP) {
+		amdgpu_ttm_mmio_remap_free_sgt(attach->dev, dir, sgt);
+		return;
+	}
+
 	if (sg_page(sgt->sgl)) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d4c93c78b80a..17ea079bd96f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1102,6 +1102,86 @@ static void amdgpu_ttm_backend_destroy(struct ttm_device *bdev,
 	kfree(gtt);
 }
 
+/**
+ * amdgpu_ttm_mmio_remap_alloc_sgt - build an sg_table for MMIO_REMAP I/O aperture
+ * @adev: amdgpu device providing the remap BAR base (adev->rmmio_remap.bus_addr)
+ * @res:  TTM resource of the BO to export; expected to live in AMDGPU_PL_MMIO_REMAP
+ * @dev:  importing device to map for (typically @attach->dev in dma-buf paths)
+ * @dir:  DMA data direction for the importer (passed to dma_map_resource())
+ * @sgt:  output; on success, set to a newly allocated sg_table describing the I/O span
+ *
+ * The HDP flush page (AMDGPU_PL_MMIO_REMAP) is a fixed hardware I/O window in a PCI
+ * BAR—there are no struct pages to back it. Importers still need a DMA address list,
+ * so we synthesize a minimal sg_table and populate it from dma_map_resource(), not
+ * from pages. Using the common amdgpu_res_cursor walker keeps the offset/size math
+ * consistent with other TTM/manager users.
+ *
+ * - @res is assumed to be a small, contiguous I/O region (typically a single 4 KiB
+ *   page) in AMDGPU_PL_MMIO_REMAP. Callers should validate placement before calling.
+ * - The sg entry is created with sg_set_page(sg, NULL, …) to reflect I/O space.
+ * - The mapping uses DMA_ATTR_SKIP_CPU_SYNC because this is MMIO, not cacheable RAM.
+ * - Peer reachability / p2pdma policy checks must be done by the caller.
+ *
+ * Return:
+ * * 0 on success, with *@sgt set to a valid table that must be freed via
+ *   amdgpu_ttm_mmio_remap_free_sgt().
+ * * -ENOMEM if allocation of the sg_table fails.
+ * * -EIO if dma_map_resource() fails.
+ *
+ */
+int amdgpu_ttm_mmio_remap_alloc_sgt(struct amdgpu_device *adev,
+				    struct ttm_resource *res,
+				    struct device *dev,
+				    enum dma_data_direction dir,
+				    struct sg_table **sgt)
+{
+	struct amdgpu_res_cursor cur;
+	dma_addr_t dma;
+	resource_size_t phys;
+	struct scatterlist *sg;
+	int r;
+
+	/* Walk the resource once; MMIO_REMAP is expected to be contiguous+small. */
+	amdgpu_res_first(res, 0, res->size, &cur);
+
+	/* Translate byte offset in the remap window into a host physical BAR address. */
+	phys = adev->rmmio_remap.bus_addr + cur.start;
+
+	/* Build a single-entry sg_table mapped as I/O (no struct page backing). */
+	*sgt = kzalloc(sizeof(**sgt), GFP_KERNEL);
+	if (!*sgt)
+		return -ENOMEM;
+	r = sg_alloc_table(*sgt, 1, GFP_KERNEL);
+	if (r) {
+		kfree(*sgt);
+		return r;
+	}
+	sg = (*sgt)->sgl;
+	sg_set_page(sg, NULL, cur.size, 0);  /* WHY: I/O space → no pages */
+
+	dma = dma_map_resource(dev, phys, cur.size, dir, DMA_ATTR_SKIP_CPU_SYNC);
+	if (dma_mapping_error(dev, dma)) {
+		sg_free_table(*sgt);
+		kfree(*sgt);
+		return -EIO;
+	}
+	sg_dma_address(sg) = dma;
+	sg_dma_len(sg) = cur.size;
+	return 0;
+}
+
+void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
+				    enum dma_data_direction dir,
+				    struct sg_table *sgt)
+{
+	struct scatterlist *sg = sgt->sgl;
+
+	dma_unmap_resource(dev, sg_dma_address(sg), sg_dma_len(sg),
+			   dir, DMA_ATTR_SKIP_CPU_SYNC);
+	sg_free_table(sgt);
+	kfree(sgt);
+}
+
 /**
  * amdgpu_ttm_tt_create - Create a ttm_tt object for a given BO
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index a8379b925878..116f3bb1d64b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -233,4 +233,13 @@ int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type);
 
 void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
 
+int amdgpu_ttm_mmio_remap_alloc_sgt(struct amdgpu_device *adev,
+				    struct ttm_resource *res,
+				    struct device *dev,
+				    enum dma_data_direction dir,
+				    struct sg_table **sgt);
+void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
+				    enum dma_data_direction dir,
+				    struct sg_table *sgt);
+
 #endif
-- 
2.34.1

