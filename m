Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F97C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 01:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F84410E1EB;
	Fri, 21 Feb 2025 01:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C2QN+Lfv";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 049DF10E1EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 01:35:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZ0hWpAij0euR5AnBHleAdolVH/vlf2x985a4q4WoTHg5q6l+bGHXXJi9tm74uFLp0btD5S69amvlWVQToo+TfIHdqw5qQuvXS3fAumfzSUKz8lSln9IOiduMz0mtAH8zDbIRn98HGK7A0/VRODWYHumm55ylA7tRUrC3OocKXcO//PSmFJewI8NGLKwlHlmUvNXK1tV0u7FokkGyDanskCbJ27Qr/b7bJI61211oqbgA8V8BreefaMdcv6m0xnE6dVh4DpCTxTMCOG5LFytMBfDOM0KBT2v6THZ2QNMqoWm0oTweqe4omb7cVG55R38S6WY4r1VNEOReGpFfNWVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9FdcSa6+DVX82X02Kj8UnSOFhpMRKBErblTWqg1gHg=;
 b=cdnFJVkzu/Bx+EYcXoH3AmjsSW7jahINgoqSC5ErGEsFSmMSbM2DvSByZ6cjR2MTqSPkpiSgNtWejxE6zT6PbI0UlKmhfC25NoAqrfGbCEC5zdkE1KYA0Xxvulc51WITnNzBRtpwz2TmaRJOdRQhGr4YTzHrtIdKg3Dd7QbJrQyrUNBoc/rKAGwhZNoeu+/2iyPvu5oTy/3p3JZVEX3qlH8sdYaYWGM/fTGR0Tox0bYHzjDMpkUN1eiOuc2qGK+3h7Prrr9lIYKGHOixeu3lPYUwcWkO01lWpiQW53mdlNV0w++nMz+yTCPDh7SQcFo9amRi0KC+WQPtMUPp68IC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9FdcSa6+DVX82X02Kj8UnSOFhpMRKBErblTWqg1gHg=;
 b=C2QN+Lfvd5iEd9HakLJbQTXn3BiProKhRpxFWbR8MD+57riD3hNxpLdNT5zZT4d1VGwlj2hagYxarV3VfQqxYWMCfqTaTcu6sUSoFD7A9aD05VqoqT/zwyZYmy6VbZBoUj93szCNm+I3VrYhj0BBqBefYj5dmuF8OyLPCx3SMi4=
Received: from PH8PR20CA0017.namprd20.prod.outlook.com (2603:10b6:510:23c::17)
 by DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 01:35:16 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::c8) by PH8PR20CA0017.outlook.office365.com
 (2603:10b6:510:23c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 01:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 01:35:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 19:35:14 -0600
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Feb 2025 19:35:13 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v2] drm/amdkfd: Correct the postion of reserve and unreserve
 memory
Date: Fri, 21 Feb 2025 09:35:08 +0800
Message-ID: <20250221013508.3102481-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a04a42-6c96-4fd9-7b7a-08dd5217fdbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FNXIBKPjFAL5GFNSVpIo5tzodmgGzlG/m6g15g2drrdstPesZuugXG5Kaebm?=
 =?us-ascii?Q?nVWDwDLI3oJ3H/xE3D4lc04jXsqrTE8IQAndTcqEtee1TQ8dOPPevpaU4Hsc?=
 =?us-ascii?Q?ukGIMxl2Sl2zSEpAAy0zkyK90YHfDZROlDG2YAXedQHj+UtDcb0DvvRr3tGu?=
 =?us-ascii?Q?t+odsIf/AE+0OAuDu4At+iytOCr+SbUOyxwKdJFnWfVhdjQ8GseLpREbT1L3?=
 =?us-ascii?Q?BaPXfCVjiu2gafD8JeAqwwi5MgiZp+u1DXrGJTWoY4SLxnFIVrADnwsCYWyx?=
 =?us-ascii?Q?hb8fZJmbMWPi4r7I0AMSJ/CcgG7ZGyw6nVIYJm/w4t7LbRKcD6t3MigTV2qe?=
 =?us-ascii?Q?OW+8+XK9/zqC5Bht6zd4+y8M/9Cz9+73nLODLN+xXSEW4p66DK++DGYbaLjC?=
 =?us-ascii?Q?r4PA3fn2/qsbMtLosAIKO7Ez7FDrufg3i9rI0EQ9aDAQdBzTn4Gig9oAXtFI?=
 =?us-ascii?Q?sMm0SVc4vbRx5tE9TjitbQXXjJwlDCdS8KSK1pIbdvXdevp7AmXDqqgJCClV?=
 =?us-ascii?Q?ldRsRnWqo3aEkXGE8p+YPrUIxQxfO+L0B0VZYsnCBGvdYKAcSrLClm98Dq5W?=
 =?us-ascii?Q?LA72/+7WdbCYpocGxahViXjyX6aevFUHUd5TJ0Ng+6XdqJg4k/j8CpbMJO4y?=
 =?us-ascii?Q?3JouNfrB7tSMzVOEQK19LfAUqu5b+arXJFe1IMjXdOunm61ecq8Y/zZ5V0MM?=
 =?us-ascii?Q?jIPldgUKcHJDAenzAIDkmkWtIUs0Jl/EWhk7DunAOgyBQSTbu8fIjk42E9TU?=
 =?us-ascii?Q?MpW0uaotY5Suq9/2bfcjSxPjO8+za0M6g+kDRBN3vB0p8nYMlMGoJCjHjqul?=
 =?us-ascii?Q?SDG6j7fvfqWhQB8RC1dvXYmC95G/Cel/7hbdSwabRVMxud9Fn3NvJjRITpyz?=
 =?us-ascii?Q?MOSzGd9Myvjs0dTt7DDhcsGz0t6lDscry2/NbkinPi7rJxZ31g7LEIjiQzxd?=
 =?us-ascii?Q?ukuIbjZGbHcqWX8+vbvRysvnZliTmYN8WqIVhyB2YGstDNUjzMC0HB9ZpN6h?=
 =?us-ascii?Q?LcgqiI531lIVuFdiFGu9Sw4D1ujDCaLjfT3lMczsGKnqR7sgB6ird9f5Ncsj?=
 =?us-ascii?Q?tws+En4io41evP1r4k013tqUqI2daPJREJMkuECknFkT+LaynozINbpDLZpw?=
 =?us-ascii?Q?65XjESeF3+plGeKaWn6g1xMJgq0lIIPui39DLxZ02j8T5a1MXwkPrtAyOY0a?=
 =?us-ascii?Q?7jUEzfEjHqQP9Oc92K2H2XQVcA4UZ9I70t9Sxy+kHFgpQRRL9JmKdfbidsUJ?=
 =?us-ascii?Q?R0gPVCVWJVEp8iGnc/Dfr/+C9t3tfrJlpsOptugV4YwascXgmcxIyfRhaAru?=
 =?us-ascii?Q?56lpjbFH9UR0o1m6XtuUuwWn+jkpYEL83knIdTdTyJHILZaVpzT7d5kB2R88?=
 =?us-ascii?Q?soZKEf9z2NJRTmjDv+yGFqVedApgjnak0DFxZC+zZnTRKNFGnnF9b9Q8yfCr?=
 =?us-ascii?Q?jxnTRd0YotiH7p+QjJDLhIZRKLlIkz3tQB1kS9UzkIsts9FA7ss0NKSlaqZl?=
 =?us-ascii?Q?7OuEIlpuWB4dqwo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 01:35:15.0229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a04a42-6c96-4fd9-7b7a-08dd5217fdbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
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

Call amdgpu_amdkfd_reserve_mem_limit in svm_range_vram_node_new when
creating a new SVM BO. Call amdgpu_amdkfd_unreserve_mem_limit
in svm_range_bo_release when the SVM BO is deleted.

v2:
Refine the error handle part in svm_range_vram_node_new.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 13 -------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index edff564d6a3c..724baa2e60bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -512,15 +512,6 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	start = start_mgr << PAGE_SHIFT;
 	end = (last_mgr + 1) << PAGE_SHIFT;
 
-	r = amdgpu_amdkfd_reserve_mem_limit(node->adev,
-					prange->npages * PAGE_SIZE,
-					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
-					node->xcp ? node->xcp->id : 0);
-	if (r) {
-		dev_dbg(node->adev->dev, "failed to reserve VRAM, r: %ld\n", r);
-		return -ENOSPC;
-	}
-
 	r = svm_range_vram_node_new(node, prange, true);
 	if (r) {
 		dev_dbg(node->adev->dev, "fail %ld to alloc vram\n", r);
@@ -558,10 +549,6 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	}
 
 out:
-	amdgpu_amdkfd_unreserve_mem_limit(node->adev,
-					prange->npages * PAGE_SIZE,
-					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
-					node->xcp ? node->xcp->id : 0);
 	return r < 0 ? r : 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index bd3e20d981e0..529c295fde06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -430,6 +430,10 @@ static void svm_range_bo_release(struct kref *kref)
 		/* We're not in the eviction worker. Signal the fence. */
 		dma_fence_signal(&svm_bo->eviction_fence->base);
 	dma_fence_put(&svm_bo->eviction_fence->base);
+	amdgpu_amdkfd_unreserve_mem_limit(svm_bo->node->adev,
+		svm_bo->bo->tbo.base.size,
+		KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
+		svm_bo->node->xcp ? svm_bo->node->xcp->id : 0);
 	amdgpu_bo_unref(&svm_bo->bo);
 	kfree(svm_bo);
 }
@@ -586,6 +590,15 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 					   mm,
 					   svm_bo);
 	mmput(mm);
+	r = amdgpu_amdkfd_reserve_mem_limit(node->adev,
+			prange->npages * PAGE_SIZE,
+			KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
+			node->xcp ? node->xcp->id : 0);
+	if (r) {
+		pr_debug("failed to reserve VRAM, r: %ld\n", r);
+		r =  -ENOSPC;
+		goto reserve_mem_failed;
+	}
 	INIT_WORK(&svm_bo->eviction_work, svm_range_evict_svm_bo_worker);
 	svm_bo->evicting = 0;
 	memset(&bp, 0, sizeof(bp));
@@ -654,6 +667,11 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 reserve_bo_failed:
 	amdgpu_bo_unref(&bo);
 create_bo_failed:
+	amdgpu_amdkfd_unreserve_mem_limit(svm_bo->node->adev,
+		prange->npages * PAGE_SIZE,
+		KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
+		node->xcp ? node->xcp->id : 0);
+reserve_mem_failed:
 	dma_fence_put(&svm_bo->eviction_fence->base);
 	kfree(svm_bo);
 	prange->ttm_res = NULL;
-- 
2.34.1

