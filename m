Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297BACAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 14:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA62310EB54;
	Thu, 11 Sep 2025 14:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pCi9DCBY";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 076A110EB54
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 14:40:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IelxaIVVok3z2sP5O3dpcxvPqRhtSiaYLTWvAk/EW4Ky0JpWOayzl6j/n1VQGlvYI6x3WuIaXTgRnSItvShiUfgJi8EtoP1Jwr194SvA5e7fflxg60uLFvvI6PK9AKj7n4txl2pqvuF8cNJw5/Lgpa4smNIfnGqG5V4TTHA5+mq5la1hY/Z2K1IPxVbcsqIRExhtncqoCRL75RRTjlMqX7yfqiJ2FRRMMnuHK2MlnAYUiql/R4/ET+pw+f5qpDpUy3caQ92ycnaGhhWRp6edzBqskH4tEtT/UXYsYVt8XdQPo7cI+BwDliFvUwS2fSHDZG+D55OvvelG1wbQzT0L2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0aREEtFx2nxO7lv6zkdvU9PzAZB7h3bxkxOO9zv6jU=;
 b=HpJtmzruP4HRvSkQOxJtnSsI0TCWzgXkRtrNLgDdAGJE7A/WCFgH+r5hv/cd6w0Cfw7LuJ/4NqG7QWQ0mvMmxevTPb2QHrVo7uZbiqKPofsQJZIMLVBZdnOOmjLO/mgOr6wW8rsKhm+1l3cr3brbqyPAEtD0RG7oznWJYaE2eWkahRxsY1+gJXWDQkRnBUEztfJodc33C9CAiTZIG95RxvZRz6JkdQetoX916e+/5IY5MrkhG+w5uNfdSz3g8oprcMk2mhKcxu0rfZUxIXAqZEP+p8IUIcHyqWXLbk7MS9XRk69oD95Lgfw1OdvBnURUQ6RnkOSDhEvnho0ufxHG/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0aREEtFx2nxO7lv6zkdvU9PzAZB7h3bxkxOO9zv6jU=;
 b=pCi9DCBYfh8p0feIOuD2CO/eA20kve1Ndvhqil7GC0UY7/7CQ21zoREzURqA0A0OsaZgdiwC19IiA5gmOdXiBbMsC2Vu175+SH/uN/rCVMOTh7yVY6JbR5Sj7JIH61iFGtOhEG/+7t4oXPWLfaJY9779TcEKd4EVULYfsojCX3Q=
Received: from SA0PR11CA0192.namprd11.prod.outlook.com (2603:10b6:806:1bc::17)
 by SJ5PPF0170DF9F2.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::985) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:40:54 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::81) by SA0PR11CA0192.outlook.office365.com
 (2603:10b6:806:1bc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 14:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 14:40:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 07:40:51 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 2/4] drm/amdgpu/dma-buf: Map/Unmap MMIO_REMAP as BAR
 register window (dma_map_resource)
Date: Thu, 11 Sep 2025 20:08:13 +0530
Message-ID: <20250911143815.825607-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911143815.825607-1-srinivasan.shanmugam@amd.com>
References: <20250911143815.825607-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|SJ5PPF0170DF9F2:EE_
X-MS-Office365-Filtering-Correlation-Id: a0209b9c-6e0c-493d-73b5-08ddf1413670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXZtTUFsYmJSMEFZRGVCZFo2aEdxbktpRkkyZnZya3VRUGYvWU11bXQvVm1u?=
 =?utf-8?B?UnF4WkZXemZRL2R6WUhySHZRNGZyWCtCUU9nZnpUd0xXRHpBYlp3emtRTFNU?=
 =?utf-8?B?ckt6VVpGZHNIbVB2Snd0Zy9UaXY2Y2ZGUFZvdU9razBRNTh2NTdDVCs3S3FU?=
 =?utf-8?B?Q3owSElNOUx1U0V0TnJxenJEL1pyUENtR1JaQStEK09zTTBrUENrV2ZuQURB?=
 =?utf-8?B?ZlFqV3N4dGdhNUhLSUxNVnpZb2VzOW9rVWMvbHdCUFZBL1NuZEVPU2VoeEJZ?=
 =?utf-8?B?ZnNpOTk4NWhHMzVxRU5Ga29NRzk0eVI5ZnJRQUQrTno3Z05HUFVVQ2x3akxh?=
 =?utf-8?B?YjlzcVpGaEs4dmFpa1dxZDJFL1M2NjMyb3A3MzFTMk9zU2w4UnVYQS9uMVFj?=
 =?utf-8?B?SEVFSDkxMCtXdWtZcGNweENEeCtQQmZGRVlFbHdxK3F1dXVGSXZuM2h4YTQ5?=
 =?utf-8?B?TmNhemNPaml2SkVNUW9LWUl5aDZUR2ZPVEE5bUNPT0pxTlpjV1ZsMXBFWWls?=
 =?utf-8?B?aUFnY3hmenpSWkpMNXFvT2xGdGJvTGlwM2p6aUxVN1Fjc3JSZkdWRkRHTnFo?=
 =?utf-8?B?K0RKNGhTcXMvS0g5aXFEV3hhTXB1VXppeWFlQmJlbUhWN0V4eVRCTVBqMUhh?=
 =?utf-8?B?aHlxYmhUS25tMHRqWGJjYTl6TVE1VkorQ2tMTjRuaUhJelhRV0R4YzFLVXph?=
 =?utf-8?B?VlhnSGZWNE9MNk9yWXhVMjA5NTZFM0h2ZU4rUFhYaXFadi93anBwVzQwN0xJ?=
 =?utf-8?B?cFJza3RLdjZrQzJCcGg0bzkrakx0NHZOVlNJNUNJS3o0SlZ5NnJ3TnRKd3lQ?=
 =?utf-8?B?VnorU29rc2FadTB4OFdRR0F4amh2d3lQTWFNWi9UUklBV3RRT3BtdHl3SUts?=
 =?utf-8?B?M0RvZlB5ZGY2N1ZReUJZb3FuVDlCdzZaaS9SUHZjN3hwQTBCQmR0bkJsdVk4?=
 =?utf-8?B?MHlmVkZ5eEtxSXlZZTU5S0VZQ2ZKakdkNkJEUy9Zci90UWFISTZqMmFYYjNo?=
 =?utf-8?B?QzhZbS9RZUdQbURhNVA2VTBudUh6Zjl3U040cWdJZENyV2JYRmZZb3kzczRJ?=
 =?utf-8?B?SUNOM0o5Wm9qMTJSMlF2b2JQTGYybzFDNHhkLzZkMDNlclRCcDdaZXdTaW90?=
 =?utf-8?B?aWY3MUpBc3FkMDAwNUUydC81Sm9vRTcvcW03OWQ1a1h0bGZpRnNTU0RCN3V2?=
 =?utf-8?B?Qlc5NFcyUm12b2lFTDhIWFpwTEtEWjZtblhrWkpwaUJ6ejR4eVFlclJYZjZG?=
 =?utf-8?B?cTNPRUFzTzNlMkdVRjVmcW9FZzR0M2tzNHBzaGl3TmpSL1BiQ2NhNEpscXcr?=
 =?utf-8?B?UThtbUs4RjFUaEdSZWdBM0ZJTnF1YTJiMHBYc0V4c3RWVkYyNjg5cmV4MGh3?=
 =?utf-8?B?YXBPYVpnOVN3NDZUUlIrYVhwY29QcEViNjJNYzE5RzdDZTJxWWZEbDRpcHho?=
 =?utf-8?B?ZDUvUysvQnZEeTBkV0ZQNU1kUmduNUtSVUxBWnN1MWppOEhaTlRzY0h5V1Y0?=
 =?utf-8?B?NDJpM1E3eWpyM2Zqc1VxM0hsQ1k4ei82OFJsTWNjMTI5NDk5VDJkcWljMzV6?=
 =?utf-8?B?TS9qazNsbU4yNXhWNHhMQnJBTGJJbTFkUW4vNERJUGhiUHJ4RWFyMFRoeUM1?=
 =?utf-8?B?am5pRkREV09sdzQvOTV0QTBmcllaSGNYUmxLV1lmWjgrUlVmSS9FU3ZoSzZL?=
 =?utf-8?B?NnBtb3ZsQitVc1JkeGVMUkNsbkk2eWFHNEx5ODQ0aG1tc2RqMWdJa2d5djV5?=
 =?utf-8?B?NmdlWm0wb3VpQisvTTNKVExGeFpYUkNJdnJKU2JCMHB0Y28rei92Q0pwWDRk?=
 =?utf-8?B?VmZaWHlKVzJhRDh6OWxvMCtpY2dpOTJlamg5SmhnTjdWSjcyU0grenpIVDdk?=
 =?utf-8?B?dXc5R2xHYTE5czZTQnlNdDZyT0l4YmwvYnp2NG5kVk52MTU3QzdSQ2xBSlQ0?=
 =?utf-8?B?UWNONVBVNnJQMGY5U0NuV0tUOXVlMC9xVUJ1V21TMDFQbmk0MSt4NHc2TXlu?=
 =?utf-8?B?RS9pVEdTbjMvQlg2NXlTY3dPYzBNYXZTT2c1TXlCRjdLNXZqWTVvdXlsbmNC?=
 =?utf-8?Q?DIm+m6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:40:54.4336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0209b9c-6e0c-493d-73b5-08ddf1413670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0170DF9F2
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

MMIO_REMAP (HDP flush page) exposes a hardware MMIO register window via a PCI BAR.

Handle it as fixed I/O:
- map(): if MMIO_REMAP, require P2P, compute the BAR address (bus_addr + page
  offset), and build a 1-entry sg_table with dma_map_resource().
- unmap(): if MMIO_REMAP, call dma_unmap_resource() and return.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 39 +++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 33fa17a927ce..f85e16be438f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -151,7 +151,7 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
 }
 
 /* Map a BAR-backed I/O span as a 1-entry sg_table via dma_map_resource(). */
-static __maybe_unused struct sg_table *
+static struct sg_table *
 amdgpu_dmabuf_map_iomem(struct device *dev, resource_size_t phys,
 			size_t size, enum dma_data_direction dir)
 {
@@ -183,7 +183,7 @@ amdgpu_dmabuf_map_iomem(struct device *dev, resource_size_t phys,
 	return sgt;
 }
 
-static __maybe_unused void
+static void
 amdgpu_dmabuf_unmap_iomem(struct device *dev, struct sg_table *sgt,
 			  enum dma_data_direction dir)
 {
@@ -218,6 +218,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct sg_table *sgt;
+	resource_size_t phys;
+	u64 off;
+	size_t len;
 	long r;
 
 	if (!bo->tbo.pin_count) {
@@ -261,6 +264,29 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		if (r)
 			return ERR_PTR(r);
 		break;
+
+	case AMDGPU_PL_MMIO_REMAP:
+		/* Only allow when importer can reach exporter via P2P. */
+		if (!attach->peer2peer ||
+		    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
+			return ERR_PTR(-EOPNOTSUPP);
+
+		if (!adev->rmmio_remap.bus_addr)
+			return ERR_PTR(-ENODEV);
+
+		if (bo->tbo.base.size != AMDGPU_GPU_PAGE_SIZE)
+			return ERR_PTR(-EINVAL);
+
+		/* TTM start is in pages → convert to byte offset. */
+		off  = (u64)bo->tbo.resource->start << PAGE_SHIFT;
+		len  = AMDGPU_GPU_PAGE_SIZE;
+		phys = adev->rmmio_remap.bus_addr + off;
+
+		sgt = amdgpu_dmabuf_map_iomem(attach->dev, phys, len, dir);
+		if (IS_ERR(sgt))
+			return sgt;
+		break;
+
 	default:
 		return ERR_PTR(-EINVAL);
 	}
@@ -286,6 +312,15 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
+	struct drm_gem_object *obj = attach->dmabuf->priv;
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+
+	if (bo->tbo.resource &&
+	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP) {
+		amdgpu_dmabuf_unmap_iomem(attach->dev, sgt, dir);
+		return;
+	}
+
 	if (sg_page(sgt->sgl)) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
-- 
2.34.1

