Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C7CC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 15:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F6011345E;
	Tue, 23 Apr 2024 15:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1QHCvKU+";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E85CB11345D
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 15:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAoHhp8I32K76C5Iprs2JhOInwJriE3zVxIqhZgwvbFjADRBNFcOStTeELlQ//GmV01/IFcf+JAxoU1QVpY4D2LXkIVXdxFUJIcgiv1E35u6sJEuIeKaoYYQHPvBHC3LRgUfrewD1w0FhClg8Rid7vT7rQZuXaQ5EsEU5nDPO8E3sc4OqoRsiq42307T/bCWUBJR+OoubWg7ODnvr9vG+28nNMv9Pkbn0AQiMxmTFSgSMX5E72jfbNvYSz75IoBByafWo8bvhW9gBsh7t5H//QtDtvFjK2WUxhauWLS/Cmg7z/N5RStavxWKxwl0NBYFL3jR/B5zJ7vztMJkuo/uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPiyDjJAm8sEb++08F2jbNPJzgBpdFgtKbT+e/bDmBM=;
 b=Vmz5TF93ojxe+jEdDRsqcVqvpDgrbRs3U6JH8tiQuotcHxjbUUYotWWMrowZJXxU+BOQ7hdQdJQrqfUad22LmKlC37Sw88XFmHVzcOgG45RhWzRW8e2Jw8I1sre672AnDbEDKqMYXiddNfxW0VYkKS+NCLEj16fHhxl+pQ81FLnArejE7uURoseO04lBroXdbM28Gc/DfrtX5zCaApS1F/mQIjRBgD4naIq0mLYJ+goC6BTuAfsvEcCi0oL9sHO5iZ39GXUDwYl7/4VlTiX/5Rq+PN+xhB5VUsQK/AKkJQ4HDyofqtsSDXksfZeoN0HP8mgkbktFfLBUqH5OMZ9k0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPiyDjJAm8sEb++08F2jbNPJzgBpdFgtKbT+e/bDmBM=;
 b=1QHCvKU+oEnBxhh/aCGMaVbeYfPR3kx4ngNpIn43tzwwR2X1/vrO1R7kBHDyRURoP1rD78Qz55i+WfpV2wqolFZGqBmc84NIlLo5u3+k91NhlvFqC6w8oLllLAD6WC9s9/TpbAc3fVC0619YUl5gV3fYB7exNNpjh9uuIQh6Gk4=
Received: from BYAPR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:40::39)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Tue, 23 Apr 2024 15:29:34 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::cd) by BYAPR04CA0026.outlook.office365.com
 (2603:10b6:a03:40::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Tue, 23 Apr 2024 15:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 15:29:34 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 10:29:26 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v5 2/6] drm/amdgpu: Handle sg size limit for contiguous
 allocation
Date: Tue, 23 Apr 2024 11:28:56 -0400
Message-ID: <20240423152900.533-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423152900.533-1-Philip.Yang@amd.com>
References: <20240423152900.533-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 810d45ec-c57c-46da-301c-08dc63aa2dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rVVrY5C1PXZb0FIixJc8EQ2iWxgnrYvwVMsoDw3/YYhriaV2Z4nGcJPSP29E?=
 =?us-ascii?Q?UVXT32Fsgd+iP91X8ADRQ2oBVOJB4RNZDALdDDXhiDJKY9Q+eNdCvVuBmdcO?=
 =?us-ascii?Q?voDblauGJRUN9ErRAD57U/EOUdoc5zTFqeYQ9vo64By9XgdE/xN7pz6zsvwf?=
 =?us-ascii?Q?n2v459R6KyyHIWStCHH4MGXV0AbskCKUjNdTDqRlrfM2NKLQ710ZTCYBCzcX?=
 =?us-ascii?Q?+2b9ULCDsu17Ks9m90mkISb6kraoVGwPF8dxiZS0K/ulCsSoFQixXvocJuGY?=
 =?us-ascii?Q?ADr2Ml9sXdM5nMZUIs4+Dyklp6lONkpQeklrescqT5mOwXyF5RbjERbElauS?=
 =?us-ascii?Q?amUc4kMIC7uYDzio/h7xnL0BIEMa/1GL0gfc+CImQGRbRSy3NbmKrkBlrOQw?=
 =?us-ascii?Q?osHC/f0Np25dCQ0Z1kwFudg4vh90yAnpTFRV4WflzikfFex3Ewn4nSR7MFum?=
 =?us-ascii?Q?cUosbokOijjXXMfVC4QJ+HsMWxAFqa2MevLiz0PMyGiFPzxJqhw6nmPA6S7x?=
 =?us-ascii?Q?ZT1X0vURnh8Xt2qNcG/R8eGRYdf9IYn0Q8rNS/Um5DoWmrrfDzfmbiEfGofd?=
 =?us-ascii?Q?9Q+fRWBHHcZL5ZvhQb7DvDgTiT0d+AaW9zi0c9yBcx+uDPcE0SUiJNR5mAtg?=
 =?us-ascii?Q?K6K0MQ9Eo6/8LW8JZQWbHZUl86oc4CXdwPUJQLzIOA6WW6w8onwwytU/MWeB?=
 =?us-ascii?Q?ZInVgx0lIl2CmFNwg+xNRLqP3X+YvWLDALrp0hbRSp5/vA+NUSDbc3ddhCQu?=
 =?us-ascii?Q?qY4VlWzo+Bzsjjov1CaLFKY/Nuxa1tDlo70TsoiWd/zVtNi+oWztu5K+zVvA?=
 =?us-ascii?Q?MX70k7G+uN778aGEovaaCoHHpnorx08gosfHlEtp6WB5/ky8rOX0X/HsV9Ef?=
 =?us-ascii?Q?xsloY3M498F96r9P9GORcnZNZ12qr7DeUtq812PQMYvFL8gbEfmf2K+NOfsA?=
 =?us-ascii?Q?sLVPAWncJbEqOGIPCAQ6+ohTM+VGIc29Uk10WMJD2puB+VkH2oIep7347zPX?=
 =?us-ascii?Q?xLY+AJ5souPspgb4vyG7f1+XqvQ/wf9662C7uqmpJSu79NTR32rjwT8Kc2TL?=
 =?us-ascii?Q?+RjxyRiBVKNyWvLO2qI/b6wGdIRWH1U/XGxE657w16HKtpIbe65Rd8q8rg04?=
 =?us-ascii?Q?IkQCtWngE3BXn3+LGxDGS+1wRmyTgImvRpxLhWG1Kf58M8AxGcz2oUpWjdjp?=
 =?us-ascii?Q?t2kBSTestVVZsWfE20i3hjiGABee9ka3FyJJMlCh4SDbLsSA82PRxoJe1/Yt?=
 =?us-ascii?Q?ZkAC4VMFLdS+yL9l49L77i8Lc59UNy4CN1znRbxzX6K1cpcx/BfW6gWRNvsc?=
 =?us-ascii?Q?fog9kQCEeFT3QUpj3ej0OsmuRP5jtRSSwB/x3F6aqXklRm6oaiXqE4PxnIkH?=
 =?us-ascii?Q?gcu5askMMwzZrU4nLr26eYUjwsYg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:29:34.0342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 810d45ec-c57c-46da-301c-08dc63aa2dae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133
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
index 4be8b091099a..ebffb58ea53a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -31,6 +31,8 @@
 #include "amdgpu_atomfirmware.h"
 #include "atom.h"
 
+#define AMDGPU_MAX_SG_SEGMENT_SIZE	(2UL << 30)
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
+		amdgpu_res_next(&cursor, min(cursor.size, AMDGPU_MAX_SG_SEGMENT_SIZE));
 	}
 
 	r = sg_alloc_table(*sgt, num_entries, GFP_KERNEL);
@@ -695,7 +695,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 	amdgpu_res_first(res, offset, length, &cursor);
 	for_each_sgtable_sg((*sgt), sg, i) {
 		phys_addr_t phys = cursor.start + adev->gmc.aper_base;
-		size_t size = cursor.size;
+		unsigned long size = min(cursor.size, AMDGPU_MAX_SG_SEGMENT_SIZE);
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

