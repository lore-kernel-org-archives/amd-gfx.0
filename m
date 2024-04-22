Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A442EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 13:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A0C112B14;
	Mon, 22 Apr 2024 13:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iNt2NRuP";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441EB112B0C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 13:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddD6WwuJd5B4xJITnsI2sJpO8L/NBDStQstXT34ry9vl6jgr9rwnHrEmMlEn8Z5+Icqyc3a/kTvG5ll1ZBKwQYO/NOrjLuESzYxHTF+IpYkXjJdPpq0b0/t9JW13RiuhsE7N/tUAwdAevym5XbjcN4FtZx5Yfbk2ukbBmtj76zjL8j11TXtko0PoZKsgokWG5O55K+u45wUH6zPEckVQto/Z0vpGp2kn47hyoJJ/BmtYZi8dS4EhLfJSUHHD1DfY4khONCqLa2hwRfe4amsAUDoQ31wbadOlB4+Lwal2hu9GTUn6fX2TMZ1P4CRzn4ZKktRVeSvxfW4nUln3fQA9Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yzch0u06xpcIAUG9H3pf2JPcuoFEYsk9SJ6dDRpewnQ=;
 b=ntIXEDmMRT8bOZo8dzd2i9nhTD25Sm+Gu4huME9k7Y4f5E/DzwwHW2PYTOh+dwWofD32Qs21z+BOP/1W7+Q7xka+OhKpcRStprJE6gDPu4t5v1Sx1GhJnzNn/O1vIMpH/Sda6ZUIev21Ir7THVl7IEOPNCPNsWIBnGNipSsqmJjCwnitO6PRjuSCX3irn7uVmyhClZXbUGa/R/zph9vAtXm9jiD9ybRUN5C1wkSH+AinOrM6yD/0Nm+kixKr0sbsMtbk7vqxtA5DHA5iWuC5NvOn2XcJ0YBx/LmqAzScEdrEI39ypGE1jlKuC9E8B9JnlueId60lgoqk4VRPQa3A7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yzch0u06xpcIAUG9H3pf2JPcuoFEYsk9SJ6dDRpewnQ=;
 b=iNt2NRuP/JSCIhkig7NUcJ2ErEtCd+jQ7pCYXiTFMLew2mJoLCMr7MhHYBOs17as34PTHIOYs49CgIB8EYVnQJR69Oh9wyv8O2wJg3QILpwRkgBlULCpoZQ8m3VQjGynzPtJtokF+laBnWbjEQw1EqzZ69ZzbhvBLysoOlDmDv8=
Received: from DM6PR05CA0038.namprd05.prod.outlook.com (2603:10b6:5:335::7) by
 PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 13:57:57 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::ad) by DM6PR05CA0038.outlook.office365.com
 (2603:10b6:5:335::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Mon, 22 Apr 2024 13:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 13:57:57 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:57:54 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 3/7] drm/amdgpu: Evict BOs from same process for contiguous
 allocation
Date: Mon, 22 Apr 2024 09:57:21 -0400
Message-ID: <20240422135725.11898-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422135725.11898-1-Philip.Yang@amd.com>
References: <20240422135725.11898-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 592e7eeb-4748-408d-6b71-08dc62d436dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gS6sLJaP4u6QSQQzwmc3/VeSQ0gPGD2hpcx7dquTl7ptF2ni9VAHxDPA5Ioh?=
 =?us-ascii?Q?AEdlmai5nPyZg96YBvXHcypM/lR0XaSUa1v6W/H0galSZx36WuBfDZuH/pR5?=
 =?us-ascii?Q?JrIurUC55clTFZSbYLP/lgHILNZnFiQOmNdqxAI2J4Gc1JuHnPBnh/Lc4nSa?=
 =?us-ascii?Q?apWvI1k5k4H9SLvbfifn5pqiVkqs65YajNYIgVjcNjxx+eOX3bktJSWqh7ts?=
 =?us-ascii?Q?+m33v0ndI+A5F9Mi6XIqOiu9qhJaNCqh4QjlfAXPmKs2Y0bynVe/NIvpAmt4?=
 =?us-ascii?Q?76wUbXVtZ+ll9SkAlgWZJXvPlhBkC3jRs+d40i+ejRP+dDlfE4+52YwiQZjv?=
 =?us-ascii?Q?+1djx/xJza2qme06wmwp/jRooASzehPShpNjuytEuVdyHOLAazYRnqc65PXA?=
 =?us-ascii?Q?S24D52M8G7YLt3HCkCRniDRnP4AkMjVZUFQXtNdYqFmocvqpzYu0q1RJ5A1o?=
 =?us-ascii?Q?z4dJeVIpCQHQk7mIiWi0yEmwN2n8Y85R+FTxRXy1D2e3jUkLl9ZbEuotKWrE?=
 =?us-ascii?Q?7HRD8N+tu5X3dtZOSA2Y4rUiDT83e1hrgMvHz7D1PhayjEVZxwCxQHEMekAo?=
 =?us-ascii?Q?Vs/Jp5JxVvlxdmeRvfth2oeSd0EWkUzGhrkDfOzYdIL3DYBAEc7ni8JXgsA/?=
 =?us-ascii?Q?Q51de0JEXv/8XB62iK8MZmazn6wZUb6x1aMk2oebKiA2Uph2vDwtglW1tWpi?=
 =?us-ascii?Q?NY/TA4jzFdffert/v2dLdRqKoAdeNjmDDfEGuhFiyQ9pqMGlK3lL1VxkGugt?=
 =?us-ascii?Q?2VlPKezjWjwhU0dB7o6k/XamWlbxMtHaAopW5XjCoLYZ2AbMeMHQvq+YRKmi?=
 =?us-ascii?Q?I1cMgdsM/wL46nRwjt2iBR6EwKcsq3v7VbLInkMc8BQ6g6vbLvwFC/pcN4mE?=
 =?us-ascii?Q?jgOCND5LutVb5lxk6VCUXfwUxoQMlao/zbAtrLmJH72Ki6bGQ00yz2Av+0V0?=
 =?us-ascii?Q?ll3IpTim1oiIV/A72/7b7mxkyd7VGhCNM3eF2i+94WtPtctXqJAyv4o0M1Ve?=
 =?us-ascii?Q?CqCP8nspgQqFrswwdfazqfgLQF/8sNQD5bHAXr8JZXJci7EFvV1ZS+YlN/Qj?=
 =?us-ascii?Q?hKIhdKTK0i41kZrJG4wwm3UlHuVkRDTYGPlcrovSOGVlM1K9OtTos7CkSG8C?=
 =?us-ascii?Q?HaN5yl+Cv7eJ8t0M6Ib0ga0qY/01uETfkzGfD51UwJ1SNz6Lj+ErdmJo+5YA?=
 =?us-ascii?Q?v1GEEqMdd27YAiuLoMZJEQemcz9OfKuRFZMnCWHWOvJ+JcKNwXxr2Q87cAzE?=
 =?us-ascii?Q?wxv4kJBC7zpE28iFFQwCLBSCGsIVkMMvBfJ4JJgH//vpBUFR1VZP1NHZpbHW?=
 =?us-ascii?Q?0IvtDH5Wz9wdU2pEv14+g2hER5p903kyLsQyszhi1X9+s2KhjdFoZVEwruUk?=
 =?us-ascii?Q?gCD/o+07K0q3440tyLGP/u9JOpwh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:57:57.0962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 592e7eeb-4748-408d-6b71-08dc62d436dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006
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

When TTM failed to alloc VRAM, TTM try evict BOs from VRAM to system
memory then retry the allocation, this skips the KFD BOs from the same
process because KFD require all BOs are resident for user queues.

If TTM with TTM_PL_FLAG_CONTIGUOUS flag to alloc contiguous VRAM, allow
TTM evict KFD BOs from the same process, this will evict the user queues
first, and restore the queues later after contiguous VRAM allocation.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 851509c6e90e..c907d6005641 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1398,7 +1398,8 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 	 */
 	dma_resv_for_each_fence(&resv_cursor, bo->base.resv,
 				DMA_RESV_USAGE_BOOKKEEP, f) {
-		if (amdkfd_fence_check_mm(f, current->mm))
+		if (amdkfd_fence_check_mm(f, current->mm) &&
+		    !(place->flags & TTM_PL_FLAG_CONTIGUOUS))
 			return false;
 	}
 
-- 
2.43.2

