Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBD5C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 15:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75BF3113C16;
	Wed, 24 Apr 2024 15:29:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F5kk5VEF";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8098B113C15
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 15:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWdo95VO+WLo1KEPGCR/lRWmNKxk9w6g6sQ3ZoTCWip5frTGwpc0lYdVJsvInzZ9Z9tGiaVq2h8+tq+ls1OLO6Z9v9kIE36m6aho8kBW1x3P8npc3v7kN1M1s4jrnmuqh4IHAOIJiHXav5qtG0Pod5NTy/jtyfwPwxM9SDrAB3JjDZycBELAE6gp+4NRTjGvBI3wssH1cxhYU/frn1hi2ICp4BiXabbL/laT9yZ0+Y2h0biikuzCepaYiItPG1WpdH1LpnCgF7elfONYopz+YcmcrbUWANzipJfBmXD3fogHlHUz9N0PHfXTUiQsMJHgP8j3Fqppl30lLc0BGvMQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yge2EpqFBn8vBKTheKJwwXsluzsZlbntAH6bGOtZhrA=;
 b=E9gqz/PNBFRKzYEXCOksXNA0BHBxEZFwEsOQq1wXAjnBdQA6qKFetohOC+LmKG7ubXYswWALWMejaw25J7iEjkHih5psrdvM6kYsifHtrp2ojHl9JTXIEPFqHq/wlDDzfb6jNv1UoDSGGmk1iefk4apYNE++YFvlOTj+uHObYJWXq59DULEKqcH/Z08Y5YZiQT3lzWyYWZSWswnTZ4ZWlTA8VOVHSh1zNGS7Mz7P5fXEPY8gPbsDzUz0Xb8f8YjKye6UonruvqZnMiJlPTwz5xGGv9IGyZ5gcaXxuXlzQdQkEVi8UwRoRpYNJSVHNGilw7hUuzKpe0U7idZJQ6O4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yge2EpqFBn8vBKTheKJwwXsluzsZlbntAH6bGOtZhrA=;
 b=F5kk5VEFIuq+aEfslnHvqwYpjihk7wgCxG0AjdlyGIQuWjA+/hvmjs6/NhhvoonOKo8pueZZlLxjj8usqVC+qAGXGYRKhK3E0Vz9RR4FfJG/jVgt51w7d2rn+3BPJHQPlTCoRKRbIBkuaQAy8daov8pjO0BUB+YQoIFc8nYoE1Q=
Received: from BY5PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:180::18)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:29:33 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::5) by BY5PR13CA0005.outlook.office365.com
 (2603:10b6:a03:180::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24 via Frontend
 Transport; Wed, 24 Apr 2024 15:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:29:32 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 10:29:29 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v6 4/5] drm/amdkfd: Evict BO itself for contiguous allocation
Date: Wed, 24 Apr 2024 11:27:48 -0400
Message-ID: <20240424152814.9608-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240424152814.9608-1-Philip.Yang@amd.com>
References: <20240424152814.9608-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c06d6f8-b7b2-48d3-da72-08dc6473576b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ul4yXagpSzHoGBl5RYlPyarUWb8xycEeVg3JCntXrh/jbytdiltnF+kPETda?=
 =?us-ascii?Q?lhXytYQ/UIDhbD56X9H2EOtCdBCxa1QalaHWK9wGrDOmlKIlwS1AEJ16xFRY?=
 =?us-ascii?Q?AXnOAai7Lk8vorP/3iVhk8Zze8l+UytRVfo3KOtrqAZgI8wc5yas15UTnWx7?=
 =?us-ascii?Q?1QCk/OcAn9uja2UIu3DivVOMQjBxo1SuvBxA5KnRYonmgoxLeZCx/1BXPDMJ?=
 =?us-ascii?Q?6GIgOMi5FEXe6/qoa1J6KJHXkywn77DSF+1q07jJSAybXS/atU8gDNwbAGnZ?=
 =?us-ascii?Q?0f2+0b9I+uDAfJA3fXM/VYnth4Kv5jZmi0H7g99+055N9VVEwuE814JCwTCe?=
 =?us-ascii?Q?yKYc+zAB9eD04u76C1Vs5ylHfg69E6E6QAI836eZkHUPo3QchGP3SZg1SVJ3?=
 =?us-ascii?Q?JNdHvh97a6KAnlNjJ/V1xmG3MEblHBHYcbdxiu/qaYQ/BV+UGN7+xJ749ZKG?=
 =?us-ascii?Q?cYGFIGYrIYi+iLQYkcHsSjTu9oaXIF9eZW84dtvaFJUDBJ72iCwokt9hGW1R?=
 =?us-ascii?Q?5mxYUTTB8/4bWVcMzcbiqXifBaL7TX+kTqzT67Jyg7cH5655NNcby0uARkt+?=
 =?us-ascii?Q?R0ZmnEmE5+tc1Gt7kUeX9ax3nt7CpKNg18lM9EoLP8UH4YCpq1D82D2lqyMc?=
 =?us-ascii?Q?tbojNWGLj3/BGp6d4cDcO4hHbEssvqi4sgRpds3ojfGESr5E6K0qnfWv5LTw?=
 =?us-ascii?Q?n3vJ65iBQvwBncNhpGTvDTjxSignyy2IVmtE9qz0EdBRmNAXDkKvJrVrnxUX?=
 =?us-ascii?Q?4+49CEVdrgMeQdvS5e4s+qdl0ZPTUnrFTkMYcsgBomMzltlxAL18hmiZTtYt?=
 =?us-ascii?Q?OhFyF4iy4Ziajh2cIBDYTOIJfDkwcBmjbLSFis1Yt2oUyyqhQRinZhxgTC7/?=
 =?us-ascii?Q?cofdAum5wQM5IlF+qE9MAgm8g8YYs8frjSdWIsvLZjusxpqGDneSCpqHy75P?=
 =?us-ascii?Q?qqt27TYQ6RTEvdKhBEIChvWV0ZUKhTz9CgpHUo3oVt8O2Hbgg+gq4SrYZdnB?=
 =?us-ascii?Q?nASdyj6wiXN+ZSCeQVsjsRVt1l5im/IO7mlkuwo1JIBTbKaA6vWAAJDLHF9b?=
 =?us-ascii?Q?uomIKVKXrf4k81TIs2jZtQ/dBXVFOucYRVYy2j+7uhPsmQL2gkYefVl+3kSj?=
 =?us-ascii?Q?XX5xv/h6t6OxNGy+w1tFVbvg24gvs7QonN1kIq5JulSA+LqcRdpyXIaDiucX?=
 =?us-ascii?Q?9bn4E4zOj0xq7OFPuU9XGpiyySa+S1rSfZtPGGUt9v09zY3cQjc4AuZ2X/x7?=
 =?us-ascii?Q?/ROmc2zvraYUN8hpOlhOW4Tna5xUtBw0ZvxBpdYQ2ESJREEcUUudJjdKbIFr?=
 =?us-ascii?Q?6bZR5GYUE/VnS+j8EDzPwqBTbvEiMKublC5JKJFVq2dcLBYX0iIQSA84OG0d?=
 =?us-ascii?Q?nvn/SwWCOoXNfT+5JjHO8PvOfgdq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:29:32.9220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c06d6f8-b7b2-48d3-da72-08dc6473576b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024
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

If the BO pages pinned for RDMA is not contiguous on VRAM, evict it to
system memory first to free the VRAM space, then allocate contiguous
VRAM space, and then move it from system memory back to VRAM.

v6: user context should use interruptible call (Felix)

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 02d66faaade5..acc825b84113 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1470,13 +1470,30 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
 	if (unlikely(ret))
 		return ret;
 
+	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
+		/*
+		 * If bo is not contiguous on VRAM, move to system memory first to ensure
+		 * we can get contiguous VRAM space after evicting other BOs.
+		 */
+		if (!(bo->tbo.resource->placement & TTM_PL_FLAG_CONTIGUOUS)) {
+			struct ttm_operation_ctx ctx = { true, false };
+
+			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
+			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+			if (unlikely(ret)) {
+				pr_debug("validate bo 0x%p to GTT failed %d\n", &bo->tbo, ret);
+				goto out;
+			}
+		}
+	}
+
 	ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
 	if (ret)
 		pr_err("Error in Pinning BO to domain: %d\n", domain);
 
 	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
+out:
 	amdgpu_bo_unreserve(bo);
-
 	return ret;
 }
 
-- 
2.43.2

