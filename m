Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55EDC10F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 15:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAC6E11345F;
	Tue, 23 Apr 2024 15:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LGDmpDWt";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C4F711345E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 15:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDewGLs7DQtyHYfx1R6cHZBy+igCGvg4IS+vEudaBQlUTexg62AbhQ9a/DizDFkRN0kMA+cB0J5jc+aFz2sGLEKvKLHUzAaV5NG/03fZLZb/3rhspgKYiwYoAK+wWlgekuYCcB1tF3pO8tGaS7o2nzAVhIWvYaVkYzbvs9yt/rAR65joVyh9McbP3Hc7qtylIbcAJoVnp8gZwbPmDFYn+gnBCd71vEJzeBNsAbd6NPZJkQZe1/J8dQg92T7UvRSi7h/zea6FYxmQdc62UyivOZ9zdJqA9nS9oRIU3kj2RtPB2hZfqinfFSY+4SBK9fh/NkXQStHb5GH6WaUnKjOYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNyivYZjs+d0o4kKHOMxxaDoAsYg4wV6QpeEhW+6eXM=;
 b=Hw6Ml6vk9faylGj+XE6MWY9adVpBP1W7A9Bf2O3rw9ZVX6HhVE9qqUcL5bFZ9RPD6VbWE6euoOOwGIwcdoIJDN16Kspn3Sv+UkbE/Rlj9KDCgdyBf/8ovr3HR8NJir8Xavh+Yqsns0wJiHDAyFKIQOZZX/CDsYfXeF94IRERR5eFsDNfSkuTwDleA136/AgoJq/S4pO15W4o5iz7M1rw4Mqy6MMufTRXJOfjiRcwtKSw2DKxE/GFWtZar7g++lf/6E9Pd0nV8EArpXrWdW/bRV8IVfG6u5b4uTp2Ga03s96m+ee99nuIffQRUE5H5i3xd76B4t4OlAgaG7UkDN6a1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNyivYZjs+d0o4kKHOMxxaDoAsYg4wV6QpeEhW+6eXM=;
 b=LGDmpDWtd9s9AWGJ2xOIy0E0+WGdsgwsiEOgsMvQdCoxCkJDiRXp7Q2Htg5i+ozednJCGTn0odmImgwMWOZ9iuQGgZA/9tboO7FBwSiEcxPlj0RRaQYidE0dhiowfdmmHKHtZuxO7W85ekrztyFJYM4nlcYLqMFqXiy39d8Bf3U=
Received: from BYAPR06CA0068.namprd06.prod.outlook.com (2603:10b6:a03:14b::45)
 by DS0PR12MB9324.namprd12.prod.outlook.com (2603:10b6:8:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:29:35 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:14b:cafe::6) by BYAPR06CA0068.outlook.office365.com
 (2603:10b6:a03:14b::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Tue, 23 Apr 2024 15:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 15:29:35 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 10:29:27 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v5 4/6] drm/amdkfd: Evict BO itself for contiguous allocation
Date: Tue, 23 Apr 2024 11:28:58 -0400
Message-ID: <20240423152900.533-5-Philip.Yang@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a74872-1876-4506-2f23-08dc63aa2e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6WzxN6Qv/hdszchhSMCy4hup4hsDE4Df5y+wa85+WZF8zihVDNCNk6nF2uuc?=
 =?us-ascii?Q?DBCYpLRUEn8RbFzxPFZZJVLtDWxavJGqlnzWpFdVelB3elP+8Z6aGPk7MfW0?=
 =?us-ascii?Q?P1xQMwzcQcVGRUbPCZiLuUnKOXBNC2ufp2+BVTJqrz7MPi39MAteYCaClicu?=
 =?us-ascii?Q?WR+nq0ladYocSdu23Py2ZfRwyd/o0KccNlfYAFUpxICdRCjExzrjRpC/SXJ8?=
 =?us-ascii?Q?FSvbw8DgH3J08cirzUuJVPWfseCeZOwXt4Tl8jX7VCv1AguKqjMKk50z4SmF?=
 =?us-ascii?Q?++jFVVAMDdR3+cv993DCuW8WINTnrslfD/o1dfo7pCmw+Fy1Yqr/ZNioJ1Zx?=
 =?us-ascii?Q?PTjfTkdStkcC32bhCUZ7wKjCPF4rJAVefpTPn+JiyONL2GrbHwWhldfGcmfI?=
 =?us-ascii?Q?QiyfLeKvE7r2gVqR/Psmeh1grUEPJeuQkP/N++SwrWVTZI3/KRCWfI5aK9XA?=
 =?us-ascii?Q?zpxcdoFpdkPuomfEh/bcoG98MZsLjkg5w1w675crXi6SKeQNtKXZyKHg0a/X?=
 =?us-ascii?Q?CJE1wXeGucTNn+EQii/+Th/Q2pG617gCbvw684zkgjiIGSNzS2bgnDxOXDoK?=
 =?us-ascii?Q?smAL3SD5sRNPNcM9FZNhSEtuTMPNnv/FnTG4wE/HKBPKNGWMX2UAThxQWXxx?=
 =?us-ascii?Q?9sk2AHnzeTPvbU0IqLk6voGPy5zWSVOvFFVDDHAfHbt0IgWYO1r7o6SEAenQ?=
 =?us-ascii?Q?9IZwHjUj1TF2phYm2L26SzWc443K4NbbgWk919mLvvzgyS1r6I3Q4H3VKfr8?=
 =?us-ascii?Q?DOvgijdmzwEsnv0KQNwF1xu1KykYh0/CO+nGNwWo3MfpbNZCkx1mmxUo1cVE?=
 =?us-ascii?Q?0bdIVC9KSIaCdFXAuQjxwJmll5+WpKyWyRnGFOeAUdYgWPif+W7YNo65qWCU?=
 =?us-ascii?Q?DLn75v1bx3b1PzMARbl9Z5pU5iKoqYuc3y4v2Ri3dKSoeeQXauxA0cw3+CHV?=
 =?us-ascii?Q?0TAtHQAnaW5fFaH/3UAO4kQTNScUDbUX0tT4JevF9w00c6x5IFejfjBPWyu7?=
 =?us-ascii?Q?OqdFYOcgV4V97J+wwI8ad6E9IXu8azs3QNsE8u57hWD2K/1tEUjRNGzQs6eg?=
 =?us-ascii?Q?VlglEswFCE0e7f01f9kryoB2PLN2zyggS3WQuy3cF6zYgq4IC8W76Oe+MRc0?=
 =?us-ascii?Q?xm3qbto/6u7QUbrJXD9TFsXw5ANkuUs+IDgFVYk3jK45kvvaqlOCb5c+SpjR?=
 =?us-ascii?Q?dO3LgG73KkA8LV4CmCeJw3FlUDqIv6i35UuVdbd+0utqWyz1al+AElnCwwBH?=
 =?us-ascii?Q?sv9LLG8QOz8XoelybcXiQmotuoFk5+XZf7xQIks5TH6b5xAMFgcpyEyPScrW?=
 =?us-ascii?Q?jcNCXCrMryR2hP15ytEnKY+6W7PcOerMdtqbww94iY1qTr87U9XV49ModHtV?=
 =?us-ascii?Q?skQSF2S+MVy01OPPlPjfvUW9DKEB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:29:35.2309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a74872-1876-4506-2f23-08dc63aa2e67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324
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

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ef9154043757..5d118e5580ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1470,13 +1470,27 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
 	if (unlikely(ret))
 		return ret;
 
+	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
+		/*
+		 * If bo is not contiguous on VRAM, move to system memory first to ensure
+		 * we can get contiguous VRAM space after evicting other BOs.
+		 */
+		if (!(bo->tbo.resource->placement & TTM_PL_FLAG_CONTIGUOUS)) {
+			ret = amdgpu_amdkfd_bo_validate(bo, AMDGPU_GEM_DOMAIN_GTT, false);
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

