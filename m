Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2C8C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 20:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8243F10F850;
	Fri, 12 Apr 2024 20:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m7s8maIH";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC6F410F850
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 20:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWY3IyhvELj0CFk++ZjS0nXU4jKEokZPs33gtMY9trFVUd9O98Z/0Tw3HNH9ghjrpoGGvQKZoI1w6/CKfhV/ki1mHTi5p0H19dzOYOGm58jX+NCMwH/QOvyRfLCZ51upji555eWxaW04HaR2kepqul/ZLA//KHCDSSKiIp4/SuPB+rn2dMNDNCA0w80peCew4r2m+M/+veJgzXgZCQJ7Xp1t5GgjqzdLGjTO0CAtW9NRjb/KRpfATphwjlwEEvtd6DquqyVwrpqx19uLNPo/vOFq3cgJCbUbFsMzFx1mK/aOrhUXFXsGs5X9P9fJ5SrsmkkZgEm+MgXnNmBw9pSDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i421Q5HGxmzXc8IqY0QDFrhhyxUa5wqDuMvd0H7wkPQ=;
 b=Fg1p33zwfn9TWjLUUrM0edowk7BZL1VAuETPhpjgMYX/voH0SukvL0PSEbgJODZM379SklyQmdgQDuf+sprA8ei1ci7gnJPSZkoDy/Gg/4cN+GYy54+EdhCrYCsK3xmbSUtKVhmBd0ZmR/j3/BuqZMoaBZx6sREvDZKoD9mwiGMgNtzlTObbmjp51DEFSrjnH1jA3ImbXIJXDIgNIqhrp1FQXTAxHOEr617ugIpT8mCM4wT0UsT7+xyPWQM2EC0xx7DUsm4G7OLqcsXaXIf0iBG3/o8lfDV1hhIJL4tcOygov4yIxc0goFTo2Md3QUrlNkRfTVLvLa1KrDWkBozo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i421Q5HGxmzXc8IqY0QDFrhhyxUa5wqDuMvd0H7wkPQ=;
 b=m7s8maIHisiDnNCiEkFTr4ADUEMgJ40nCWjLp28Wl8rJadsA3kpUEESGJy6mKHwHek2BdqWTkALt2dIDnXW054dUca/3Y5RRqXNxKAGcX8J8Q+RQQx6EygDWV9IOsdnMAgCh/yDWdVzcMGYb1y8DMZrWVeerd6X/yGM7UNYz8oU=
Received: from BY5PR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:1d0::27)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 20:13:42 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::d6) by BY5PR04CA0017.outlook.office365.com
 (2603:10b6:a03:1d0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 20:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 20:13:41 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 15:13:39 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 3/6] drm/amdkfd: Evict BO itself for contiguous allocation
Date: Fri, 12 Apr 2024 16:12:58 -0400
Message-ID: <20240412201301.14154-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240412201301.14154-1-Philip.Yang@amd.com>
References: <20240412201301.14154-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|SJ2PR12MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5a6c40-438b-48df-01f6-08dc5b2d0c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEPiFBT5uGdyPMxkjX7MOPhr+Z2BG7noaTBLhmOF4TqceGoAHHu/TkrL/QX5HaLoDzqBSHyuilwgpLNn5ZKrnMnhaNtlN1ErnPbAkcG4hEnLj4RN6220aeOtlwnTs0yJ8VtgNJqsYpMlUsYbPWoPHxo7UXJ2e10r7nHMtv6zIhn5sGaw0s12WurghxRxrMgX0DjVEoBbs3PAL+K3K0CLO35SBSvyAH+a3dimfPFTTgoTFrSes0809bW1AF3pWIwwG1uLbDjZlfQ1CpBNSwPm9KRtjV6aJNsAN1OqBYMsKSzXLssCjEnt36pBsiBugDlsdeXzobf1m28S4FMmNAmhQy0nXc9Lr9FIGtz11XNKPLBYoqlWnTm2spRmivDhQoWPqh/uDngHGeF50kEGEagQRWTUQP2Xfqls4l3xLsHGYV2cjA2aOvrtW3qUVBqZJmdDHkeK8XakECyDIxVhkQmy1zefV0V+Ed2utydoB5xFeLBJ8MVyLcUaSPycINt0Dp5r2VoYpcA4Iy2n6lY7/184IBWih7NpZMsfcwq+lqiUq1xKI9jjqXActZx6i7Ry2S568pB8aK45lqjZEwO7F7hrfbK+DbDE2lCeMx8vnnRxvb9qw1NoLnyNMJ+VXPc1JYD3Rr83q+9htAczZzKg5OW16Y8mToo8Fe1KSEw1u6rJA4oxo1ANnXWEqecVGKwR1SLTnoY18dOSjWmOADDRQwTuwrjOwHOYBLb4rlHXUfrxfM4LBPqBwwGPMFVl2Gd9WKXE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 20:13:41.9077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5a6c40-438b-48df-01f6-08dc5b2d0c76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893
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
VRAM and then move it from system memory back to VRAM.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 3523b91f8add..9506de1094ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1470,8 +1470,21 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
 	if (unlikely(ret))
 		return ret;
 
-	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS_BEST_EFFORT)
+	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS_BEST_EFFORT) {
+		/*
+		 * If bo is not contiguous on VRAM, move to system memory first to ensure
+		 * we can get contiguous VRAM space after evicting other BOs.
+		 */
+		if (!(bo->tbo.resource->placement & TTM_PL_FLAG_CONTIGUOUS)) {
+			ret = amdgpu_amdkfd_bo_validate(bo, AMDGPU_GEM_DOMAIN_GTT, false);
+			if (unlikely(ret)) {
+				pr_debug("validate bo 0x%p to GTT failed %d\n", &bo->tbo, ret);
+				return ret;
+			}
+		}
+
 		bo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
+	}
 
 	ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
 	if (ret)
-- 
2.43.2

