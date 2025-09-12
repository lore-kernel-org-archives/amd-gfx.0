Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D88FCA101F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 11:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 257A610E1A7;
	Fri, 12 Sep 2025 11:15:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3LRfQ/by";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C76410E1A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 11:15:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZ0BSy1emflcmFmlooCkqsVkWSSaW5D8vsP3FzVdO9ycoCEN13EHTwMi7rZ46iLKSxMkEN0qO2BwpCcXAGGTayxg6DYPsmyj8fS3vitwXPIibEvmYyCR6Lpji8mbcPk9Ae2Mk1a+SmwykZpDpKmlex9PVTUUPo4q8slUy0DG0pr6N+dVw6ctqh+n+ZIZjphL5aPfml2iDPHwWzF/MKi85RiMiQkDErJENRhSu+ThU/Uz7k5vVZW6FxgZnUnzIp+9ETi5uQwDWM2aeu0LIXePpsalpH+pgncER68MhOxPot1DwVQxoJljwF1Ja9M/VMyp6nJJi6MosrC64uekb0cCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0aREEtFx2nxO7lv6zkdvU9PzAZB7h3bxkxOO9zv6jU=;
 b=nqdaTdWVNUFRAozDpjlUu380YoBWa3HKv/oD6QzLIB0aqjI15Gy/ACkaZnzKgFuVnSdm7jO2I3Db5uDC67eSbxc+9YzO44xJw9Zeb08PdGsBjlfujEXP8VA13eCK50ZH4InNyeu22k14/Ah2tsZXuhS8V3xxvZKGB5Ld6IP24AiD6DRiflhEuqi9kPWh7Ls10mI+jvxyDbVNoNUjsQHExFW2/g2drXLGhEJ6MunPgFVQdMTy/zRiaxVE553ux2prne/7eiBeK/aGu+kXJlr0/ANm5DCM30/AjOjT1guoJumnhBwuW8pR2OCPN+VW1BqVj7X2/i8GNGufYFCKF6aCbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0aREEtFx2nxO7lv6zkdvU9PzAZB7h3bxkxOO9zv6jU=;
 b=3LRfQ/by3VDIDUANF0k1t4MNTb3dmWdbCM93brPjfsP+4UdIONo/EOGyvh5NTgNRc9vEnl685DomrWtVI4Dg1XptDRHokEcQDvOmdsBjB6ow0p5FOYUNcz4Km3jHoKsUQSy5QEw5m79E3MQ5lvtHNjjh6jyCzSWOkxbahZ9hIzI=
Received: from MW4PR04CA0157.namprd04.prod.outlook.com (2603:10b6:303:85::12)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 11:15:53 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::15) by MW4PR04CA0157.outlook.office365.com
 (2603:10b6:303:85::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Fri,
 12 Sep 2025 11:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 11:15:52 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 04:15:50 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu/dma-buf: Map/Unmap MMIO_REMAP as BAR
 register window (dma_map_resource)
Date: Fri, 12 Sep 2025 16:41:48 +0530
Message-ID: <20250912111148.833465-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912111148.833465-1-srinivasan.shanmugam@amd.com>
References: <20250912111148.833465-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd69631-b9ff-489a-5c5e-08ddf1edbc74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjMxd3lkVzN5czNrekd1SEJEWXpZdGs1aWxGU0ZLUm5MVmpNWWppTDRqQ2pm?=
 =?utf-8?B?WnNQbnNEYzAzcEFNN2llYk5GL1g3SEtsTGJpTUc0M3dGUmxEcUNOQ0czYUht?=
 =?utf-8?B?d3BlOGdta0NGbVBBbGNCODZsbUhOaWVJSWlVM0Q4TDI1eTN1cUdMSWtEcFg0?=
 =?utf-8?B?d0lrSlQ4b3lidEhZRFZIUXFtbFlsUmNKdnF5VVhucHNOMVFvRXk2ZWZGbFp0?=
 =?utf-8?B?ZzNMOGowdndCWTA0L2J3L1Q0KzhJKzlMcHc5WnByVjQxaWlKNWxad28wTU1N?=
 =?utf-8?B?dnN1MWF4ZDlJVGo1dmtXTEpBWE9uSTErUzBiZ1I3OU1LY2NMcUtqU24wdTIx?=
 =?utf-8?B?RWl2YnBWb1pZVENiK0djN0t1UnQ1T09zajFFbkRFVUJ4bkVJNkg2OTFKUkph?=
 =?utf-8?B?QkxYdVlPTjV4RVVBa0xlYXpURXBKdXlkVkhqU3pPd3JVZjRYY3A0OXdiV3Vh?=
 =?utf-8?B?Yi9Rc2pBa1Q2TjJqdVNSUDgxS016OXBKRnFxYkFqM0NzMngwWFkwMzltdS9Q?=
 =?utf-8?B?U0pYa3hYSW1MekV2cXlGeUJkbzZqbkxRUXlXK0NjSVA3M1E4SnU0RmlLQTdQ?=
 =?utf-8?B?VXRPb2xCUk5CMmh0QzZRU3I2VWdZeXlYa2lPSTNveURRejdCUHVOdXZZeXBX?=
 =?utf-8?B?RGRjai9weGNHLzVwU1VFcnEzREdoVGdMYTl4d1BzdFY5SGdzSDkxNmdYeDBk?=
 =?utf-8?B?NWoyK3JiTmFLQkxRUmFPdkZ3MTNjblhBNzlMYWRHMjRVcVlxYkVrN1l1V1h1?=
 =?utf-8?B?U040ZXZoclVjVWhMTWNNK3BNS0F4ODluRlA0dUhDK1IwYm45a3FSMmRpTEth?=
 =?utf-8?B?YXhNK2h5VnE4OFZjUUFLcE1Ocy9ERkRmQWl3WHd4eVNnbmllTUZBSTdydW9D?=
 =?utf-8?B?UGJ5SVVTMnNGMHFpR1pVOEFZbDJvZ2JqUzZ6MWphUC81bTY3TDYwWk53M0hz?=
 =?utf-8?B?V1FyUFhVS1lUbS84cmdhQTlHelJ1blVHR20rbGVoREpoNGc3UlcwSUJTUCtu?=
 =?utf-8?B?Z2RWVDFpdytxalg3aXp5Zi9Pc2M4dEhBTGtwY0J0SktpNmJDcTdUaUl3blVY?=
 =?utf-8?B?WWoySXN1UXN3cS83TWVZL2RobTZleER0cmxzVlA2cElTMUEyeGRzcEZWQWZy?=
 =?utf-8?B?b3B3dWJwT3RmdUV3ci94djhJVVNwdVc2M2c5VHBlZGFvZUhsNTNUcmg5K0cz?=
 =?utf-8?B?UGRDNENJT2lkNkdHdGdkZ3h6b0ZMYndaYVUra1l6NklMVkhaVGsxa2RsT0Uw?=
 =?utf-8?B?TDhkM3F3Q0Y5dThFQ0p2TFRqUjhGdU8yRThnNExnOU03UnVvUXNkdHdrV2dv?=
 =?utf-8?B?VFZxd1JnM0tqNjcraU1sRmJNaisxbXdLUDhqa2F6aVlCRWpIM3VDeGVWcEQ2?=
 =?utf-8?B?cm0rQVpBdzk2a3VwcG1ScTR2Zk9sQlZlQ1l6MWEzaHc4TklUdHFOS2dOWHlo?=
 =?utf-8?B?dWZvK3YrZFpXYmFTaUFlZCtNSlBpUWE5MGM1eEdWa3BiSFlNdVpickRETGRq?=
 =?utf-8?B?OCsra0VMZHh2dmxIMjNaNHZ0bFFuSytIeEdpQ0tNM0xqOTI4QzF1TnIrSGdo?=
 =?utf-8?B?Z0FnYnZRRGdOY2ZlejBRUmJnVnZnWUNnbzRnOWdycFR6czZGMlRJREplVFBH?=
 =?utf-8?B?WHNiTWU0UnNkOTk4cFZyL09ZVnRJc3lucGpJUDZoMVUyODR1NjBkRlI4UE55?=
 =?utf-8?B?aWlET3Y1YlRHSlo4UzViaW10WHl0THQxazI4M09xN3hoNFZKbG9GMDVQRnAy?=
 =?utf-8?B?SWtyQkk1NEtIU25QMFMveHpLcHFLb2gyQWpTbE9MNkZldFhvc09ySGhiWXZx?=
 =?utf-8?B?Tktpa09zWjVxNU1EYnRpVGpiTjl5MDE3NndsUWx2ZDhDMzlyRXplTDdNUUZz?=
 =?utf-8?B?NEdwdFFCSVhJQXd0SmhhbDl4SGVzYnJMUEtqbFlTM0orVFZyc0hFdHdheUhG?=
 =?utf-8?B?WUd5VElraW9IblZNbWxNU2krV2NHeE53dU81N09DbUpkZENvNzRIQmYzUVAv?=
 =?utf-8?B?eWwxa1k1d2VqaGFwNExVY0J1ZTRoQk9rRi9OWnEzVm5nRU5mOVlOZlNrSjVC?=
 =?utf-8?Q?LHi0/q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 11:15:52.6429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd69631-b9ff-489a-5c5e-08ddf1edbc74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
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

