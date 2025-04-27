Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A11C369D8
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Apr 2025 07:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 125AF10E0C7;
	Sun, 27 Apr 2025 07:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zrffYhrc";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC52710E169
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Apr 2025 07:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beeASrXW67NZ89SoSGSqE9eFhhXr6aLM8k0mwRoY995N3xetaxLMZTz5mpJgzF5s6ufn+253qP5WZ6yP6ST6oILBEJbKofDOwG/FE6mujGnlcH+zwnhut6nyvZw1JlZpTyimTFUV7pP56EnrE8nusdBYxQuCttAgY6odfLjOqfOWC90uJj1YUhiLqhRQdhO7EqdOVK5VnPXnWLO9hNiFQUs1T5HDNapQkJN4rdy8cHRKN5TQCDx9847mpPVmUgm9CRrA/0/mO5zc48Bv+zuie2/t5XO8d/RgYNAhDf3kfp81qgVPzVPHoesKJ8Yy53n3qAMFMNv2DrlZNo53e8aXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8w2EeF+yghsIvNTCCucScZHaC8Xy2LE837btRi3O1Q=;
 b=GDoBk0awLIPL7kubAIXTHPDhYkrNHixVUb09K38SNk7w83xKLjMbBuw7xud181lSK94Cvo0JaMZ+mEykjMsf7TIrMBSl9UdKDD7TuS5IW6wK63XYbToH7qVEQOqlDphtmq28AYFaZFsoeNUDxycZQLf7AdZRuzxTdfJUNYZfHJj6tJvFOdwuEVUbm+G+kIhtpwq12PRXCAG8wyCOiFE+31E+mfT9VA5eXLEcZHgTcpLt2hV+6V9Fkm6GCsXwEIVHyqkoR6aLbgKf+UGWDqxAPc3YNrs7eO7mRNuZXVeOHiPhrKGCuZlQd/+krhOlA9PzsvQRZEWLorw7PVIclfvPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8w2EeF+yghsIvNTCCucScZHaC8Xy2LE837btRi3O1Q=;
 b=zrffYhrcmdc9rKVlo3kmJgcJ+1YRFdC9dWhPFUym8UaCpPDOnyDmXL7ofqtXGKLfehEt//WLcl7zKk2gMjcXzPNWChr8lKqMCM95MWs4U3Ny/1sdKQKPH3obDdhJe3us+5ekHN94mh0672rqcjow+j4BST+eqqrMX4N2LSTw6mA=
Received: from BN9PR03CA0687.namprd03.prod.outlook.com (2603:10b6:408:10e::32)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sun, 27 Apr
 2025 07:14:15 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::50) by BN9PR03CA0687.outlook.office365.com
 (2603:10b6:408:10e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Sun,
 27 Apr 2025 07:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Sun, 27 Apr 2025 07:14:14 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Apr
 2025 02:14:12 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu: validate the eviction fence before
 attaching/detaching
Date: Sun, 27 Apr 2025 15:14:01 +0800
Message-ID: <20250427071401.4047874-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250427071401.4047874-1-Prike.Liang@amd.com>
References: <20250427071401.4047874-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: c9681a75-5aa2-4426-0207-08dd855b1dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8QGe/fxCG0EWsE/YU+GxhBiaAoN1CLpnc5gTEjJpnXBYzXv4dXHPE8xL9+xq?=
 =?us-ascii?Q?NTafnCnSNOq74Yuu9LJzYDcO5byLi9VWbIe3T7AsdoeMxm2r8JLbd43h4CEW?=
 =?us-ascii?Q?FJJ4nRHI+TNKucTRLXpCxrsbBfruqDG5aDyyIKiuugM7q6YhvQzJJAtej+sR?=
 =?us-ascii?Q?l+NTeAXF46Ln4snmbOm9i9xzf5vPoUKbBDbtJHHQ5IwdCDYWpSogUdwK8P3W?=
 =?us-ascii?Q?o5MqwUxtwUELby27GLLyggEEUSl2IGnV5as7dhn8YStTaVczG4DKEHWG2e7X?=
 =?us-ascii?Q?Mrkk2snnQecDeg+Ql8ZnFlXCTn7RnGsg///cA1c+xZ1z9QVMp9uPsk9RuM9w?=
 =?us-ascii?Q?D2jEMu7bs4/ssgmPp4sbCkWi/n4rERgIJHYA6e+53/yMWI/j3DNpZg9YGToZ?=
 =?us-ascii?Q?4tE8zGNBqlNzUano+Zgek/S2tKCrGmg0nKB8qTKjm0hEHMk0nFrLXoD0xoCm?=
 =?us-ascii?Q?plEjE96nomyBSl+2g/Sqp6PWoiZrcjB3KTth5QFNiNms2LWXmIRJ2Sb1+eVR?=
 =?us-ascii?Q?U0V3XonoH6+8QYtdnX/F51pVThHS9zHn5Pjw2kleDqgUJvaPmGfjwKC0LSVl?=
 =?us-ascii?Q?gYkIJRSZFGqn6da8//01hbrH3kh3/TBq4+SPDPfc/1ASey40M2LiPVV8WoGP?=
 =?us-ascii?Q?m6h1UJzh+gfC87pS3/ysFpTXacl2v0rzQlwoO1aqjZcFctWhkXuHw2DqZOnY?=
 =?us-ascii?Q?pogWUM83KR7/fl54kAR2DbfVpNFfx3sCx6s9z+SAJdDwewk4t0xhBltdveIP?=
 =?us-ascii?Q?LY6sZwZ4hv2rwX/7QtBR/TNtQLmesHbBECzCdyAukASsENvzd0Lp6oRrAty4?=
 =?us-ascii?Q?49/nMp2A6VXUxt/YUSkd57/YUwqSypufy6rcYfNcQggZEWLVJo8oLduI4+oJ?=
 =?us-ascii?Q?qeuwWWq74gcPT3O43i/JhdsvXgqkTcUtQ1bzKfE47up6ttyTFoxrUfti8hR5?=
 =?us-ascii?Q?MCi/ncO6U97MHWMarAw4Pdtg2F2VQMeng8ADkQr5uGd4z1fKcQYXFSSAgHxG?=
 =?us-ascii?Q?EekNBFrEoau00zwNTSvfFtGXovmUDyYukxHiwYiT/mJw9DPFgIVCzb9ZECSp?=
 =?us-ascii?Q?HwSXyMEgPrqWHbyszk7u9HHy1EMXaKQwZMkqjCXZ2JUG9GhheuGwyY085dgh?=
 =?us-ascii?Q?esnkklZQFYegLqj9UOyndr5dLj+Qkf1w7gEjQj/IUETY7NXmr54gyaQKIMuz?=
 =?us-ascii?Q?Eq0lvbmMITLRBW0ueqwBFHYuxN0vwc56T7g+yAOXhJlRdFkoTiWg87TMC9cZ?=
 =?us-ascii?Q?FvdVnxgyb0YEga49K3M9PtgVmNZSDK11mfq16mbSO+XC4/+0Z+DKcUSxgFSC?=
 =?us-ascii?Q?SQxULeK46qZBGOf1sCZVUNdAGgAR0f4SMASyzdbHMBeLJf+pLaJ6kCikxG1m?=
 =?us-ascii?Q?Kedq8dbWmB4io46dpvKdEEHghO3ziqyMkZzx01Lep219cSa38fz0O5Hu7gjC?=
 =?us-ascii?Q?IoFGFJB76ire8Z6oQKWPIevD8SW7KXKiTg8RqTn8M/rLalx5lwdkvnOQ/fq4?=
 =?us-ascii?Q?KFha+1tpZuija8zJat6szPbTwI73zMNRxSvN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 07:14:14.5223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9681a75-5aa2-4426-0207-08dd855b1dd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
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

Before the user queue BOs resume workqueue is scheduled;
there's no valid eviction fence to attach the gem obj.
For this case, it doesn't need to attach/detach the eviction
fence. Also, it needs to unlock the bo first before returning
from the eviction fence attached error.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c   |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 16 ++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 7a5f02ef45a7..aa9f523e62c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -216,6 +216,9 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
 {
 	struct dma_fence *stub = dma_fence_get_stub();
 
+	if (dma_fence_is_signaled(&evf_mgr->ev_fence->base))
+		return;
+
 	dma_resv_replace_fences(bo->tbo.base.resv, evf_mgr->ev_fence_ctx,
 				stub, DMA_RESV_USAGE_BOOKKEEP);
 	dma_fence_put(stub);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f03fc3cf4d50..11d4a9af7bc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -294,11 +294,14 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	else
 		++bo_va->ref_count;
 
-	/* attach gfx eviction fence */
-	r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
-	if (r) {
-		DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
-		return r;
+	/* attach gfx the validated eviction fence */
+	if (!IS_ERR_OR_NULL(fpriv->evf_mgr.ev_fence)) {
+		r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
+		if (r) {
+			DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
+			amdgpu_bo_unreserve(abo);
+			return r;
+		}
 	}
 
 	amdgpu_bo_unreserve(abo);
@@ -364,7 +367,8 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 			goto out_unlock;
 	}
 
-	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
+	if (!amdgpu_vm_is_bo_always_valid(vm, bo) &&
+			!IS_ERR_OR_NULL(fpriv->evf_mgr.ev_fence))
 		amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
 
 	bo_va = amdgpu_vm_bo_find(vm, bo);
-- 
2.34.1

