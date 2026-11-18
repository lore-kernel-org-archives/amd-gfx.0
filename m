Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11172606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Iimkjqa8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87BAC10FD91;
	Wed, 18 Nov 2026 15:11:05 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9533C10FD8C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 15:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsLz02RUc7JYhVJLWMFOZ1w9BtOQFyTuRUtSeXVFUhcTpvl6iI2o4jzTTE/Z+2BWMPwDfPV66rbslSqdRoRjUFa2/o4DZgrrt4GvmqVRhGjKWaEe5urHHUrP7Noj4s6fuQE5ZA8gFv+/H43ZGoD3Vj9rnp2UWr7QL82ok8N97uqUNS6TI1/cGe1gKug1nzQA4CPZJ9WxJ1MzWFPTSMN2cUvFPUV7OkVG5aqgNOTDQObVjEQKbBNWpPO/GnJm+puDZc2jeiwzC7MB2ZEPtr4jlsub5oOiRL6hTFMhZZEUd8/+TM3ipqOBFjET7F1c16yFDQnH04JknWmBye1AfRpKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGGYBKm2tGqlE8kPVmI+DdtiOgRYAEf0cNGrLqfQ9gI=;
 b=R0hjguhEA4sBLgCJZG3G4jUXFIEfYQw1edLYU6HWY7E+SVerbSd01hxZwqj0E2YxtKxsRFwh/Ks3oL+bhdB6eteptxxXEyKSJ5zwH+y2lEbUzcMAOEKHBkNZJp2LPi0vICx8cprVa2l5SbMZ8AY2sPVkpc4nck5a7c9iO9N1rjy+eIavzfOpz9qktNaUtxwSj9Lvhzp9iuElLF64ptHGmiSx+mZRHsRI5cZNUc1G46OkO7DJf68KOXFW+Xb0aldfzAXL8mBUBP16iWSVGkh85f1eaPEDD8hVmOZG5jZPnCZgiLcWhHUVJavgpOQy+diaBYyRLDIJ0vgnHXeCfRHvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGGYBKm2tGqlE8kPVmI+DdtiOgRYAEf0cNGrLqfQ9gI=;
 b=Iimkjqa8Oe4SThUXbXrZjJ1TY9a5ncgBvbHGBsj7Pd08j7vTkglrUV92w2sggEHnDRexHhclWcE6IvzBAL8GoukJK9SD1dMJlRSx4lRA3qPa/4UWtFX2wPsAn8DjYK9XqbhSjyBZpXDe6jfkgwBI+VI8AofX+YZ8lkSef+aGWCA=
Received: from PH7P220CA0033.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::33)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 15:10:54 +0000
Received: from CY6PEPF0000004D.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::1b) by PH7P220CA0033.outlook.office365.com
 (2603:10b6:510:32b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 15:10:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004D.mail.protection.outlook.com (10.167.247.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:10:53 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 09:10:52 -0600
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <William.Palacek@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, <philip.yang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: limit userptr sg segments to half of
 sg->length
Date: Wed, 18 Nov 2026 10:10:35 -0500
Message-ID: <5a6eb18599b44e0457abdc9d54a00dbb0060f10c.1795014593.git.William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795014593.git.William.Palacek@amd.com>
References: <cover.1795014593.git.William.Palacek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004D:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 985c5eaf-a229-4f18-fa98-08df45862394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261021123027099003|11063799006|56012099006|261026140227099003|261028144727099003|10067099003|261021121427099003|261022105027099003|261102123227099003|261026121527099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: bIdUpSzSZM8epo5syo63o3Upgwc4FN8ROKYS2lCCYur8hS2evtVa0QmraWAadcLEcuquWiKlLPpJp9UnODJ2MFn14D4VvBucg/BgIle79uaeqnZ+9W6eO2VHaeJebLDSPPG2dbzm5SPhorPUYycozuuYRLtHDkk8R+usg/7aOa2qoyWbg0MIQ5TRSDEX84xAEEIrja6tLm+vKN8MQNyD4wCSETs666WzFOMIazrEwJplN63tLBMhlvThX0wMdxhDWXIhmINX4wEHzyTzIMxIMy1DHrnG/xcC9NA//K/UGd7TMdan7C4x1/tIf0xbt9LL5/KGKLYT6Snjs0UeeLpw+PUYzP8+kzdmSRbzaVvYAwvD5w3t7YPfYnSs43s8myNGyd8P/2nkir1qRIQ2zVjyZMcyZOL0vvXMI0SJaQhcr0dmR9ZvFZG3WEXv//lNhaQ7BjEPim6QeWAsnjAehKMXiwb7zoZwqCdAYypgB7oz8BOWhFwAyXD4DMwNqCEQJzWyl8PHwdvBncZlmjBA+5uo/YcpxDA1LvkQiQ7RcZ5JsMPIYFizc5FoKq4sNRsAbgsfxMw7Rn4iwSIhY1d+qdFD/8icMNyEcjZrW0AvwBr/M3mN1Wx65u0ODPpJFwE23bGv4DwmMIPvUeGsVj33SrWR9K8e/hq/B4oxnDCGd+wQTYbsbZYH+zf0CDhW+eLvkHCesycV/LtOmgyDV/uwLu5VsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261021123027099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(10067099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026121527099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lxnsfejz/RjlB8iIBguXtE70ktdH06zDzwHw1MUukgd/E5r4P3OHY4U825C5tIKPDrO5qbk8y9t1MT7QX8HAhNBo9T+bvyJthB/SZyeKCmXt2+MUHLV9IkURTPq3bEd5OX/7ia88X82L+ccxaA2Qw9iRDiLTuxwaTNboYzQxhHBLT7ikOjAMvCgGM9hy1wDkjeWHkfmkeI5vIUMoqxs1yvmHbacDR0S1rodNMqZ3+xRcNKyk8Te/nr6DUnG/NX2fpqwnBPxCLi/oWKlomuIFObKusaJBo0gfy9pAmSIaDMAqUYl0y+qUfKK/eOYGPtqgOyuF5et3SS8BB1qjbgHT9QH47OGvyfCKMP3H2jPOmutNb26VraXMHQ6xeh1hXtu+idhtR59wpK33RadOPO+nFxZUSuFG/D1YS4Xj+3pY6uVqFFky8T31RZnL7HSaLr7s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:10:53.3929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 985c5eaf-a229-4f18-fa98-08df45862394
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Userptr sg tables are built with sg_alloc_table_from_pages(), which
merges physically contiguous pages into segments of up to
0xfffff000 bytes. iommu_dma_map_sg() pads a segment so that the next
one does not cross the DMA segment boundary, and adds the padding to
the 32-bit sg->length. With two large contiguous segments the padded
length reaches 4 GiB and wraps to 0.

On kernels without commit 1c8f6308e557 ("iommu/dma: Catch scatterlist
length overflows") the wrapped length makes iommu_map_sg() map less
than the allocated IOVA range. The IOVA is then freed without
unmapping it, and a later map at that address fails with -EADDRINUSE.
On kernels with that commit, iommu_dma_map_sg() returns -EOVERFLOW
instead. In both cases a large userptr allocation fails to pin. On
MI300X with the default DMA-FQ IOMMU domain, the first 32 GiB
hipHostMalloc after boot built 16 segments of up to 3.7 GiB, mapped
only 15.7 GiB and failed.

The padding is shorter than the next segment, so a padded segment
still fits sg->length when no segment exceeds half of it. Limit both
userptr sg tables to that, as xe does in commit 1b1d3710380d
("drm/xe: Apply upper limit to sg element size").

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h          | 7 +++++++
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f060b206c255..565ecd7e012a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -589,10 +589,10 @@ kfd_mem_dmamap_userptr(struct kgd_mem *mem,
 		return -ENOMEM;
 
 	/* Same sequence as in amdgpu_ttm_tt_pin_userptr */
-	ret = sg_alloc_table_from_pages(ttm->sg, src_ttm->pages,
-					ttm->num_pages, 0,
-					(u64)ttm->num_pages << PAGE_SHIFT,
-					GFP_KERNEL);
+	ret = sg_alloc_table_from_pages_segment(ttm->sg, src_ttm->pages,
+						ttm->num_pages, 0,
+						(u64)ttm->num_pages << PAGE_SHIFT,
+						AMDGPU_SG_MAX_SEGMENT, GFP_KERNEL);
 	if (unlikely(ret))
 		goto free_sg;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8dfa92967b63..b0672f1747ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -837,9 +837,10 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 	int r;
 
 	/* Allocate an SG array and squash pages into it */
-	r = sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm->num_pages, 0,
-				      (u64)ttm->num_pages << PAGE_SHIFT,
-				      GFP_KERNEL);
+	r = sg_alloc_table_from_pages_segment(ttm->sg, ttm->pages,
+					      ttm->num_pages, 0,
+					      (u64)ttm->num_pages << PAGE_SHIFT,
+					      AMDGPU_SG_MAX_SEGMENT, GFP_KERNEL);
 	if (r)
 		goto release_sg;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 9856a2fc2d08..da7d7621aad1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -44,6 +44,13 @@
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	(1ULL << 22)
 
+/*
+ * iommu_dma_map_sg() pads a segment so that the next one does not cross the
+ * DMA segment boundary. The padding is shorter than the next segment, so the
+ * padded length still fits sg->length if no segment exceeds half of it.
+ */
+#define AMDGPU_SG_MAX_SEGMENT	round_down(UINT_MAX / 2, PAGE_SIZE)
+
 extern const struct attribute_group amdgpu_vram_mgr_attr_group;
 extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
 
-- 
2.43.0

