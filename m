Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D653C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 13:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B505311339B;
	Tue, 23 Apr 2024 13:05:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1b5fmvwS";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D4C911339B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 13:05:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaenZQrMbQcb3lNhgxovDNJET3EOBEBCSJeZccMHkP7x+atUvmVPsXZY+feLIR5zw+qpVfBTjuB+agZmvQ30lLhY6sx0EqUrW7AukmzaiNVhGTftBbeFHa2zlUUNN4FYoIl5Q9yB6QFshFZ6dhhiO62m6K8PmJqbpCGaMbubrscy1H9+DmKHo+oCuTUI2fUhlnAaT3LwokgvXFr90XZI7aR3Ld7B1nCuw/r/j6urJnLLxOYxKdXjITisyiOhqGXQBhfIG8/Ag/1LC83wcJY/EVsUfRA3FBsstCtExTgKUykPeZ4Qgv3zKeyNYcwfmCRuqkatFKcxIJHZBU5njfHMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXmONLMJn0Bkfvv7/j3nZoCswqJGjqpPi7Gz97Km/Vw=;
 b=Y9WoVAQ7hsTOI094ZV6uGcsm+dAye0eGjw3sVZQ5Pvb2/y+f8HWywalBGW9aIJ3d65aMdx5Oj+JYGp858Yf1dSVIcNr7XaU+mFQVnSk0dz6lyqIMX9/na/cm0eNU18NFzrQBk7IIPzhKzxoUaOVabBP3fd9CB0VL8XS5H0IsAnc73SXVOiq3Kcc0Ck0jqkENeQwufZ2zJkwR19Iw/FFqT8wa2YIZ5BJLiviZrdPfClZnUCr9jJHDoZ0JGMvwBZPL7h1KMiSrFv8Vc9a01bBi2l7mA0oOJibljsMdFkAM5BrZqzB0JHZOqZFUYq0+3O+BBJ/UPKc4AgGVv1cQTKiYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXmONLMJn0Bkfvv7/j3nZoCswqJGjqpPi7Gz97Km/Vw=;
 b=1b5fmvwSHNcdusjHXoQokQGUBkJLuv+0qADo0paggk83a96SECe/j1AGektvzjgFVMYH3M/eBo/7tuw8cL+iCYwfhHVFjqbsiM3YOZ0ERCBoI5jTQojJ8PRD2IDDQa4uj7qqP0VyKXljnFydWXqO1CrC0aJ0uCyP36yWhO8+/cI=
Received: from CH2PR05CA0025.namprd05.prod.outlook.com (2603:10b6:610::38) by
 SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Tue, 23 Apr 2024 13:05:47 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::23) by CH2PR05CA0025.outlook.office365.com
 (2603:10b6:610::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Tue, 23 Apr 2024 13:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 23 Apr 2024 13:05:47 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 08:05:39 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v4 2/7] drm/amdgpu: Handle sg size limit for contiguous
 allocation
Date: Tue, 23 Apr 2024 09:04:45 -0400
Message-ID: <20240423130450.25200-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423130450.25200-1-Philip.Yang@amd.com>
References: <20240423130450.25200-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f67b0e5-a7f7-413b-5168-08dc639617e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ypQU2JiTQn1P+AwULAK2pHlabLydfqo3AmYD8yp0x5dhAbu9VVWUPMb1W152?=
 =?us-ascii?Q?GiMNXrcpxCNdPe1hK0CNsuHbIZrJGaF9/Uj7pvce6JOYAIQRZt8/MeGVP3KQ?=
 =?us-ascii?Q?wwZKHHlw+S3m+N50VwSHC3tjMP4MPWPkhcUGsQiogu6v0dMpBKptvC4vg+ZI?=
 =?us-ascii?Q?wA7tPTgwIXv2LpOC5RVCnTPE7zz42V3t74fCYIULttcG3Kw50zdDqAg2Zxhb?=
 =?us-ascii?Q?nKqkmVvHbMQkEzBxkgMjlywOjULsQWM17RCvQGAkG2iRmnCAMxcxEQ1cGQ00?=
 =?us-ascii?Q?K6TRT8nke35rkVjljoJO0eUPPupVjcu4zKA5v6BH/2St/VXYOgmVmuSSTwas?=
 =?us-ascii?Q?2UBh/Xppie0ksxMeclcAqBen2h2i9Hgfa0w4mBvuWqndD0EsHMyEbVWmedyE?=
 =?us-ascii?Q?4QvqiyUwhTIKYe8pebnRwmfe/+j4IbFqD+LRa9+0e3WVVOc8DOW7RRDhvHXi?=
 =?us-ascii?Q?lXlvt4svaLrTycziTSgnjLqcQrVN0kD4EYBWTmFEMHJSIqE8Tr0Rhwqvz0OT?=
 =?us-ascii?Q?p7XujXAPIgiszH8GAs02xQRVqWRjm8vl35qM++PgLHoTQVAk784k7Cu5YMhZ?=
 =?us-ascii?Q?3hwYfdBgFwMPm5IGd7HhQLXbG+z4zQCpjc4pcfiBn5V1Bz3Cd/OyPp9b2Klb?=
 =?us-ascii?Q?NyI2nqSUg/jAJq17qB+2uy9AThr63ZCCLQDAgB3jeV9Gwko9yq9bDcscm5Tn?=
 =?us-ascii?Q?uncy5MUSlpHfPBA/+aO265i0XqnKofYihEuOjX37MN28HIaBdkrqlYJkiLWr?=
 =?us-ascii?Q?kOrYTwqp3yd8rpMzc5MHOCIdrzwWroaK5mg8XL0mKXHSY7lpYIfVIUU9lOQ8?=
 =?us-ascii?Q?HL05HsLMLpuBq00yxC50mpYsEHDDha/5rlWVgF3ME0YteVfVUaXNT+N1V5I9?=
 =?us-ascii?Q?lUeNCXPAbl+u79Hxn655AB3+JdAY1ikvgU5X9EfGi/APDC5yNpDN5jv2jrtz?=
 =?us-ascii?Q?zhRzQkIUuf1g10dTEonTGpl40qbNFTqiXAyDNp2AW/ICmewDCcwNjL1AZg20?=
 =?us-ascii?Q?Hxog1SeVzUjlOoyCR8S3yTtYx/seNWnqMJsRdqbkzTpvI8m8tpziek6KIWLK?=
 =?us-ascii?Q?1jSewGrLnTnDYtGi0mohCfaRgvfdJGaAtGdYfEulGJBtAkYRVER4iPlv8ypQ?=
 =?us-ascii?Q?wuT+OUNYEbinzA6B9mIjfdE5GusBRNxQcK9qAqFtvOUu+cXNeh1k1ptPfDwp?=
 =?us-ascii?Q?Op46fQbOG57haZGWtDWvEhXLwpPnVbvLGF6KC/hBYrI+jcYoDcqtWIcW7wWC?=
 =?us-ascii?Q?F3Rz7ZuRiPrg2CIvYdhYt4TFnGbMfAW0/sAgjfPVvfFC9Qz8ACutmTpfRIvu?=
 =?us-ascii?Q?RG704XjHuV+J3Kc5OfO78ucu8WvIbIXfhteHOzjRf64EMVAnw7JtgzMRonTa?=
 =?us-ascii?Q?mJg+XPkmbGqPD6G7I+17tHav5G7R?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 13:05:47.6094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f67b0e5-a7f7-413b-5168-08dc639617e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
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

Define macro MAX_SG_SEGMENT_SIZE 2GB, because struct scatterlist length
is unsigned int, and some users of it cast to a signed int, so every
segment of sg table is limited to size 2GB maximum.

For contiguous VRAM allocation, don't limit the max buddy block size in
order to get contiguous VRAM memory. To workaround the sg table segment
size limit, allocate multiple segments if contiguous size is bigger than
MAX_SG_SEGMENT_SIZE.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 4be8b091099a..6c7133bf51d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -31,6 +31,8 @@
 #include "amdgpu_atomfirmware.h"
 #include "atom.h"
 
+#define MAX_SG_SEGMENT_SIZE	(2UL << 30)
+
 struct amdgpu_vram_reservation {
 	u64 start;
 	u64 size;
@@ -532,9 +534,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 
 		BUG_ON(min_block_size < mm->chunk_size);
 
-		/* Limit maximum size to 2GiB due to SG table limitations */
-		size = min(remaining_size, 2ULL << 30);
-
+		size = remaining_size;
 		if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
 				!(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
 			min_block_size = (u64)pages_per_block << PAGE_SHIFT;
@@ -675,7 +675,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 	amdgpu_res_first(res, offset, length, &cursor);
 	while (cursor.remaining) {
 		num_entries++;
-		amdgpu_res_next(&cursor, cursor.size);
+		amdgpu_res_next(&cursor, min(cursor.size, MAX_SG_SEGMENT_SIZE));
 	}
 
 	r = sg_alloc_table(*sgt, num_entries, GFP_KERNEL);
@@ -695,7 +695,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 	amdgpu_res_first(res, offset, length, &cursor);
 	for_each_sgtable_sg((*sgt), sg, i) {
 		phys_addr_t phys = cursor.start + adev->gmc.aper_base;
-		size_t size = cursor.size;
+		unsigned long size = min(cursor.size, MAX_SG_SEGMENT_SIZE);
 		dma_addr_t addr;
 
 		addr = dma_map_resource(dev, phys, size, dir,
@@ -708,7 +708,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 		sg_dma_address(sg) = addr;
 		sg_dma_len(sg) = size;
 
-		amdgpu_res_next(&cursor, cursor.size);
+		amdgpu_res_next(&cursor, size);
 	}
 
 	return 0;
-- 
2.43.2

