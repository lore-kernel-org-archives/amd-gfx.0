Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CDEC369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 13:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4456D10EB0A;
	Thu, 17 Apr 2025 13:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KYuyjT0J";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2942610EB0A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 13:34:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+vm4xHduIV5/rDZUEHlJMWp0Qx+Hy+4jQqe10SX2gTsjIHJqEoEu2fQfr4+5y/NhQQ5+ufXXeHyEVuAqhMcclhF26juG7reovRenVCMw9lTeBu8yyZu4gy0oHOsPqOqpqZiOgV6uKTzYmDP3vFwQS1Xd1QBmgx0MPfbTlpO4nsi5/Y54ZPD6sjJD/yi+PBuTQz8Ciscuo9MNpxkDFfzenq6FW5Ivboc9aLVMKbtmaAgdk4olEHIMCFTTzVVMMncPOULagoEBDnLQNHD8tMpAxxdt49u4Bkc8EvFxzE884W5nnDpDUgMFF5/+c9pQdpAPxJ/hEW8RwJ+K9Ywi/ry0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNWC4UTYxOLoV7AUOaU0CkxD86ZAcl2xJWWpRWnDK6E=;
 b=fz5gV+YCMVbmuzErm2ohRjgkrm860EmoOEAL5UjRxxXR/QeQ0zRApc/tBPoNx0iw3+Bd2UyxNh+Ifq4bLZ6xDBSikkonxETrTXho3af9OfRD08apTl4Hv21H7xcA6hLJ/DiZN6pCsmDrZveQ9qGKwOXFTHoq5FNYLVdndmjN36uzIi3U+DxVB+4/H3gBRc4F0SzTIqWoeycAd8A8sRzdAN8KbP8EFEaoSpI32/qkxRw852PLubhk0aQwL1csRq2pGVOwmY+WJy9hkv9ai4vWfxbG4hR7XX5MU8NuW3u5GuC/p6LWp+OOnCC69vLB+mHdSW3OLEHjMfrXSftTznwneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNWC4UTYxOLoV7AUOaU0CkxD86ZAcl2xJWWpRWnDK6E=;
 b=KYuyjT0Jc7qATqLqA6D485OoWCY7bvy7t3J8T/pWVnmqSm/m+TKeYWViz+JNTpGN1w0tdVf1/ffVUl91lrGRGwFcQ3CsardkDfouubSu4FG1kpu9rE1ZwvfRMPEBs9SH0KO2bsP0zBlQ/km9S0FF/si6tmo6BdrKar/p2oZrMoQ=
Received: from DM6PR08CA0054.namprd08.prod.outlook.com (2603:10b6:5:1e0::28)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Thu, 17 Apr
 2025 13:34:29 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::a5) by DM6PR08CA0054.outlook.office365.com
 (2603:10b6:5:1e0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Thu,
 17 Apr 2025 13:34:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 13:34:29 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 08:34:23 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <yang.su2@amd.com>, <hao.zhou@amd.com>,
 <asher.song@amd.com>, <pak.lui@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu: Optimize DMABuf attachment with XGMI
Date: Thu, 17 Apr 2025 09:33:52 -0400
Message-ID: <20250417133352.1204510-3-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417133352.1204510-1-felix.kuehling@amd.com>
References: <20250417133352.1204510-1-felix.kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: a69c05c7-21ce-4728-f8dc-08dd7db49460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/JrD6cIr1SVsMzbQiEP0hqgTaaP/7C57P5rjCmEoUXylo8OBZ/FXWn7K2AVe?=
 =?us-ascii?Q?QfP8qr0mvMn1Vqbsp3oh0tPVEuLtaWEs9Dny7QE2zZx+qOQ4I2BBtoW0wCB0?=
 =?us-ascii?Q?+MZhG2NHaU3lxXNXD8dkvDD1B9XsizaO7Tm1xGo79xxtSsVFrrpJUmodow2L?=
 =?us-ascii?Q?E+aYgleyk4oHvzLPO9GyDB7bav8P2+hs2GkuWpoABTGzpNppZ0W+0/A+xneQ?=
 =?us-ascii?Q?8mgNukL3Xh9573BObmfdWsohAbnBgKc1sccVb0YA3wItvvuP69uvO78o7hGy?=
 =?us-ascii?Q?jN3x0yAFXNkHbTujjhmlX4V629LOaTv3XpdDl7ao/LLt+DOAPnxc9xJV8iwt?=
 =?us-ascii?Q?BpWS9GRmoiO68rkCxmKTFcU7ix8ekRUDoGSbRM5cYPzjfR/9LWNIbrSbt3Wg?=
 =?us-ascii?Q?5L6srFDD1o5PmOcVlBzS2xqEsbLOyxgRuX2myolI0mHev0g1SrBK8Hz+2t+p?=
 =?us-ascii?Q?iDCmhM78ofjGlUDHgIjeMU/JgGgVI/pOS2/0/4iwYGE/7ndNJJZ4Mn716cxt?=
 =?us-ascii?Q?ou4JgBQ3WY1hsARs5JQqttYbQdDRCO3R/OFrS99otjjH7GCFsIwn//OUn05P?=
 =?us-ascii?Q?p7SQ9y80Og9AZUEsAKANF42uvbbdOkyMx/frsVVz9zhHHNrd7L07VUFNtiwh?=
 =?us-ascii?Q?Pb9DJTU93jfAOR12L7ezD58uYX0gxRVfZOYvfDJ6wyHODeorz9gKVgHVkp0z?=
 =?us-ascii?Q?uzj7bx16WO2B9cNQVNaZlWi4oYtmgivVb9QmebgbEurNf7zzPu0s1AeL3RSR?=
 =?us-ascii?Q?0ARLquomVdIGJoT6g8Q4EhFf8n0qv/YbzaxBUyiwXmY5hcsvAyXw19IaHaJy?=
 =?us-ascii?Q?HqaGOcedeXz26pCM06J6KuIS0lxPHxXEsxS/h4/Rkm62/RR6to7dIt1cBD/X?=
 =?us-ascii?Q?jlWlS9IggDqIXJCfv+otPlAtcPCDHi/3BLA8MS2vZdnPXcjTpGtR4R/Fkf3w?=
 =?us-ascii?Q?Mom7FbHGgnzdeWWhorFpN/ThfAhIwPxVdwwqcVjyzc1XUD4DWs6OXlMghIyu?=
 =?us-ascii?Q?QGODzFH5QiS0c+znUk/a/WRW4837lZFF4s8X91A768fwwpnxWAz/yq3XwoCB?=
 =?us-ascii?Q?5BgPB8KT3VM6DIXaac0tpD7PL26hBpmpZFUqULWuZVd4o2fiHi9KjQ93y7LW?=
 =?us-ascii?Q?IexDopIoD3I/a3ZzOqYoXTtzDEKS09nCQRot1iW4JVR2lCTr7NpKFNpQPaRS?=
 =?us-ascii?Q?3VQvj6IphLDsxvR/vWkD0GMj9tJfGeKtv4ilcXe355pPuINplbjh+wAlO34q?=
 =?us-ascii?Q?qnIKJa4UiAGGkZsDKWg2v20AffknRjkqY6Bxttwjc+C5FrtyHbVET+CqD/Qa?=
 =?us-ascii?Q?vqXK/r3Q/Fftj7/+BoLX5KkO2xgQ0w6ZKN0RyiY2IxLQMBDC/lGAssnM8LL/?=
 =?us-ascii?Q?t3q9+6l/UFPZ6OCW4NBcYoBpL7AAsBSqcdEWDNEVrlay5K8ljTXvCBiXAz5P?=
 =?us-ascii?Q?33TF8T6AFeOpB2zd0pd/3/mtIXlwiVU5R5w1n0z6Vu3MOGpqueqTPQckTzAY?=
 =?us-ascii?Q?2Y7dbya0k5mrcAx1kxguimtx2CTzg2OJTXDd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:34:29.2665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a69c05c7-21ce-4728-f8dc-08dd7db49460
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
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

When peer memory is accessed through XGMI, it does not need to be visible
in the BAR and there is no need for SG-tables or DMA mappings.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Tested-by: Hao (Claire) Zhou <hao.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 073e64a667f7..f28f3ec2efb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -145,6 +145,11 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
 	amdgpu_bo_unpin(bo);
 }
 
+/* Dummy SG table for XGMI attachments. It should never be dereferenced. If it
+ * is, it will be caught as a kernel oops.
+ */
+#define SGT_DUMMY ((struct sg_table *)1)
+
 /**
  * amdgpu_dma_buf_map - &dma_buf_ops.map_dma_buf implementation
  * @attach: DMA-buf attachment
@@ -161,9 +166,11 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
 static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 					   enum dma_data_direction dir)
 {
+	struct amdgpu_device *attach_adev = dma_buf_attach_adev(attach);
 	struct dma_buf *dma_buf = attach->dmabuf;
 	struct drm_gem_object *obj = dma_buf->priv;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+	bool is_xgmi = amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct sg_table *sgt;
 	long r;
@@ -175,7 +182,8 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 
 		if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
 		    attach->peer2peer) {
-			bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+			if (!is_xgmi)
+				bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 			domains |= AMDGPU_GEM_DOMAIN_VRAM;
 		}
 		amdgpu_bo_placement_from_domain(bo, domains);
@@ -198,6 +206,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		break;
 
 	case TTM_PL_VRAM:
+		if (is_xgmi)
+			return SGT_DUMMY;
+
 		r = amdgpu_vram_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
 					      bo->tbo.base.size, attach->dev,
 					      dir, &sgt);
@@ -229,6 +240,9 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
+	if (sgt == SGT_DUMMY)
+		return;
+
 	if (sg_page(sgt->sgl)) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
-- 
2.34.1

