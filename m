Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B984CCF2D8
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 02:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B809F10E18C;
	Mon, 19 Oct 2026 02:09:17 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4DD510E18C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 02:09:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOsfsX1laA4MNnyGj814J3wLFKQOiAfVfkU/DhBsBOh4z1aPJa2weYaod4WvSJsIgAYAH2E3GJIlQzO3c9xYxPktyWeE5USX+/loNC/jwWFORTkinPkQomDs7NJz7EyVxmeYF2MQCLOQQ0DugXBoxkSQWRcqLzvwY63esjv/lwFqwXjHsF+5dHcFjDw3hiyKFJdn1Ks8c1AgvhWYS+DbbetprJNNJB7NDyoCDBZvA5gNjM5JeP8AjBw7025le9V3QEc/rdh6qC/igP8jjvpR1oJ9nm+3TeWvjEUnXI5Z2y6RS0QcplfAHjDKS3GYYiOL3xySN6GOFeu+JJkEPaOOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uaWz4y8vLHK3Axg1zs4pcnWEAK4OYOH0arNK7Nt0Vc=;
 b=r59OjRZu2CX6AdDvFTTzNco0QjcpJhVdH/Yx7tNYXcLJVC18EgfytkoF6+lLPtCz3Mlkq56h2JGgolZdO2biw4LUN/R0pSlnGMDnzvXWyyCH+HiHmDv2j1jDgDnAI7XZ8DLOPwyqfyhWX0u7tR0uquRb9peh1WKN6IbOT2Ob2uvx2gUFilhQwTKzLzHrqBn0ZSuSh9O/n61PjzCjLg25FQ6RPDFz45cA8Gs6aIJKQkVBOTjadctG2jbSVOuJZDzlYhGsged7Tr4e74f+zyb6DkwzC7cGhAuc1fCj6Lf/fNUrexYuMv9RhPlTCdihPdAwj1DbHdDFpQDUSXJ0lKXm7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uaWz4y8vLHK3Axg1zs4pcnWEAK4OYOH0arNK7Nt0Vc=;
 b=wN/gu0PZD+WDdDQujj3AtmxQQmC/AMoLFPONmeOGQhdLKyhVdBfqGLcdfqk+H20TCVecaJRznNaoL5gsjD1LhPhyljo7jLNnEWYqzB+WV1c3JLuSeovRtz/2kgFhc2FVzch1fe/q3s/KQHdnTh+p6Hxti9oUhQkJu+3mFT+HILM=
Received: from BN0PR04CA0132.namprd04.prod.outlook.com (2603:10b6:408:ed::17)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:09:08 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:ed:cafe::ae) by BN0PR04CA0132.outlook.office365.com
 (2603:10b6:408:ed::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 02:09:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 02:09:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 18 Oct
 2026 21:08:59 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 18 Oct 2026 21:08:57 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Philip.Yang@amd.com>, <Felix.Kuehling@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v2] drm/amdkfd: split vram_pages of SVM ranges prefetched
 without a GPU mapping
Date: Mon, 19 Oct 2026 10:08:48 +0800
Message-ID: <20261019020859.1493373-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 66af4622-eb96-4b3f-d77e-08df2d85f549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: nvv1pYhNaMxYfv7pcrnOniNfr+1G+mVNRqSGqYrNeZVUjn5hld5LuvAXvg7nyfEM/34TPUDQ2Y9gZ70o3EhxUFFAy4a2QneKMdeTb0adHtFSt1RXNi0dQ9mBIlUicR/mbJPKyJZRq8ExRlfsG37M2LpARRBEZR9GuC7hFZzpdrE1xLfF82heenBdqIZLH5JC3dGAuT+diRxQFkxv5QRgMeOHe1r+PW8+cg9EVgsgM8IkbIG1knh/2Ansdwm/4t96eXNrQjurAAfkjgzlmVVF6PKwocZTrLXDFf8Rphv+9TtGNx7030pL0TAZ/tuvKqEP89yHcyy9PVHH1hcztFkqs/HDd+t+Og1odyqifMzGNg2dwgNi1RdbHawKnmDy3fe5MBH9vUPPX1kpFW942xPSiw0fKzNj+GcR6ANq1Akqj4/vh6hp9Vv6btpMwEu6hDZo+T417anzvCFjz9j1cZXsaMRbb3vwyz31s7Va2dNkxs5DBr2ctua064bMV3SQeTu8wb8g+TaGLgBA/5+0x7OuWHkMRhP3kAIniFmZQoIq2b6WtXct7WJKVGhK6uC4zqxT0c2jpr+Q/7q5dDUktgK30hTFaNgHeI0zhNC8xfZZzRIOrptQyfQyKejs+edyB8SkpW+Kq+EURAbu6rrYkRIcACDaOGhlMg3xlBNqVutHBudDMXYY9rUjk2+ZWWcDD8Vi9uufJJCHrq9OSPosRdG5eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: McbbUdDnntnZ/z2uZ+0RfkdNn6cyMBVZkS205iG24xh+K1bcWEYAPz+3HB/IXUayhKvuLYFlugsRJhiKf4fzcVqZwRmRj0pCvKm7EPl/fWzR+NhmfX6y9e0vbUv0z1Ldu1x2gdyDIZ+oSM5IEYwRxs/i7XHaqM5SVWBw6x/kvmhsZj6H39Eimbp8Q9vRiGgAVlFdBkdRakJGck8CNH1gS0Y+avFBNcDX6wd4TqT7fzDf5+ljec1JcKmBwO9Ak0pbLPq/abQgiK09NzthpdVUMiXlqaT+yppvtisrfJshHLC2nx6atQcBMaVL34M0e5BcjoOgfVCz+1hmW92sO08EyOwtog+LsgnkFUobseSu9zgNNIT80zP8Jj/7KVf9U3LUuNGm3cg+NuxY2gh6O3zpmlXyTUaEGEqiJDGNx3aigZKypUdqPtJfHYi+Y77xZo8+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 02:09:07.8636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66af4622-eb96-4b3f-d77e-08df2d85f549
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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

When an SVM range is split, svm_range_split_pages() gives the new range
the number of VRAM pages counted in its part of the dma_addr arrays and
subtracts it from the old range. Pages migrated to VRAM by a prefetch
have no dma_addr entries until the range is mapped on a GPU, e.g. with
no ACCESS attribute, or with XNACK off before the delayed restore worker
mapped it, so the new range gets 0 and the old one keeps the count for
both.

Migrating the parts back to system memory then gets the accounting
wrong: the old part keeps a VRAM page count after all its pages are
gone, so its svm_bo is never freed, and the new part underflows. On
navi31, as an unprivileged process: prefetch 4 MiB to the GPU, prefetch
the upper 2 MiB and then the lower 2 MiB back to system memory:

  Recorded vram pages(0x0) should not be less than migration pages(0x200).
  WARNING: ../amdkfd/kfd_migrate.c:922 at svm_migrate_vram_to_ram+0xbdc/0xcd0 [amdgpu]

and /sys/class/kfd/kfd/proc/<pid>/vram_<gpu_id> stays at 4194304 until
the process exits.

Without dma_addr arrays, the split is still exact when the old range is
completely in VRAM, which is what a prefetch of the whole range leaves.
Give the new range all its pages in that case. The warning is gone and
the VRAM usage drops back to 0.

This doesn't cover a range that is only partly in VRAM without dma_addr
arrays, e.g. after a partial migration, since svm_migrate_ram_to_vram()
only counts the pages it actually migrated. That would need VRAM
residency to be tracked per page independently of dma_addr.

v2:
- Rename counted to has_dma_addr and compare against old->npages (Philip)
- Mention the XNACK off case and the partial migration limitation (Philip)

Fixes: 006ad514a50c ("drm/amdkfd: Use partial hmm page walk during buffer validation in SVM")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 1f5d73f0ebce..c67132d9ae9a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1020,9 +1020,12 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 		      uint64_t start, uint64_t last)
 {
 	uint64_t npages = last - start + 1;
+	bool has_dma_addr = false;
 	int i, r;
 
 	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
+		if (old->dma_addr[i])
+			has_dma_addr = true;
 		r = svm_range_split_array(&new->dma_addr[i], &old->dma_addr[i],
 					  sizeof(*old->dma_addr[i]), old->start,
 					  npages, new->start, new->npages,
@@ -1030,8 +1033,16 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 		if (r)
 			return r;
 	}
-	if (old->actual_loc)
+	if (old->actual_loc) {
+		/*
+		 * Pages migrated by prefetch have no dma_addr until they are
+		 * mapped on a GPU. A fully resident range still splits exactly,
+		 * old->npages isn't adjusted yet here.
+		 */
+		if (!has_dma_addr && old->vram_pages == old->npages)
+			new->vram_pages = new->npages;
 		old->vram_pages -= new->vram_pages;
+	}
 
 	return 0;
 }
-- 
2.50.1

