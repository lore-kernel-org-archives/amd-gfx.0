Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35B5D0D7AB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 15:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F57410EB08;
	Fri, 11 Oct 2024 15:01:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="huGfHCwr";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C91FA10EAEB
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 15:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jxgsyhovej9Yd6yVIPOqlmuTPZWxcxlsmooo0rUcQIljSY+wg/0bSQg4hm8lrPcWssYt55AUSn6FWoxjyZ5trGuwsbxYKvZeAdaPclzZvVuNyfdqwug7Iyd/dXnBdexR+v51FVGM7JXN7a4kmrSAR30Y4X3nMa/fY8PI2yIlqHt3GEPlg62DaHfkHU2yXYZzGK2toGTS2cDGar0BMkoNhnhTt7/8hD3F1WGsgvOyh8Z1Pmh8cbzTZEHB5ZkvK7xjOtl7XjuLx8DcWUa82oFzQmWHvvrsy+EFnPlDxv35YWOF7V5nN6nxtES52mwNnyItEg82K0iMfSYR4oYRRMNxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72Z0k0KwUCl5lBzsfoBAjGDoE9gzggA8cSXwMwA6Zm8=;
 b=D4MUjUD6j66iuI9v3TR0O0dtkQgUcLGCqsZINF+h5Ki5O8P/LgtK/ScoCULPCornG1RToMzAr50qhiCqwhB84CvYveZBnMVlr7pO617YvWoJRxW/T6Vj1IjRbcBcc8GhiVx93NfNK3tQ56T/fj4OpHamSptZVrpNhE0nFC8y/k2XtAt+11M8UPKfQDalODnJL5CVyh+NuaQnEaWwvoQnHfVFvdhsSDIi3a/w2VtEh+pRByKBr0CathCY5hi58yWye2re2ez/tbPE6+yHLmiqulWoSPHl7QMzdpOqR2umZltu4vBU4zrxCzbXQUw+pwXJ20JETIs0X4Ga9rx2VYuHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72Z0k0KwUCl5lBzsfoBAjGDoE9gzggA8cSXwMwA6Zm8=;
 b=huGfHCwrWxrqy8VhJrtSeU2sBdsnHA25mEdegs0CIcDfAUTLaCjzshJWcv2Efrcqf2izCVPHEgDR8W60szIHcDC/ABlfGJ0g8UpC0t3Q2KBWfhy4byKt+hqEicNsS8Wiubezy82ijKLSCVfti/xTPFWh/14H/7s/5HXwbsxNv/I=
Received: from BYAPR06CA0051.namprd06.prod.outlook.com (2603:10b6:a03:14b::28)
 by SJ2PR12MB8808.namprd12.prod.outlook.com (2603:10b6:a03:4d0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 15:01:06 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::a1) by BYAPR06CA0051.outlook.office365.com
 (2603:10b6:a03:14b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21 via Frontend
 Transport; Fri, 11 Oct 2024 15:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Fri, 11 Oct 2024 15:01:05 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Oct
 2024 10:01:02 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Save pdd to svm_bo to replace node
Date: Fri, 11 Oct 2024 11:00:05 -0400
Message-ID: <20241011150007.26310-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SJ2PR12MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: c0214133-132b-4482-2cda-08dcea058839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SRRje4+qsWRTqhXp7ioC/V66AiPWHJwkgzNmzHj1LcyD0Vj6xkUPPZWADHDG?=
 =?us-ascii?Q?4a8KDegcIpb0e/wziSBu6RhfKsD4xwFPa7AbeQHvYaXSEr+tm0Wnh9PjOIOL?=
 =?us-ascii?Q?/9FRCGyYxDSWBq1vEfcoaatK1r6VwTJF17k4J59GXAIvsAZHkAHcR09lYL8Q?=
 =?us-ascii?Q?wNwY3IcStbmIE4oCDdJpyHRlPOf9xy6+M62LVCbZa6U8Ay1j3/gxUdXDJO+o?=
 =?us-ascii?Q?OVu8BE5C86cTkstHU2ZyjThzrMk3lYnZTdJ0sTqUKp4/jllHxlWXrrsEWX0F?=
 =?us-ascii?Q?B8bWhtgpqPBs9C6oV8eiNqHdJ7mIAWP7d9HhBZznn4tC03fMOWK6CXT8ykuE?=
 =?us-ascii?Q?a8l3PwOU05Dg1PRCjqmjwdMUF+4iCOepovb3gHkaLDzGnYFurvg05gE+SzVT?=
 =?us-ascii?Q?BkU7/yYxxmFupgQZPZxRhEejLHHMw+FewZBo8Z2ObSk6qJoh0EdBvI0ttOVe?=
 =?us-ascii?Q?V9giZCeSSxmAx7vsghYSzRxh6+xRe8AF8F5E/QL/1tiA+ZjLQDMBZtqS1Vv7?=
 =?us-ascii?Q?j+hf8mRE3n3iz1Fn+wYrWhsN59QtFgmhQhbt4Shj5FpC1pwjZICO4UatFHFA?=
 =?us-ascii?Q?r4062/GxldHhQz51vOBcsPnLBenUY5Gil3nOlN0eeFQpnrs7V9cg41mXyoe2?=
 =?us-ascii?Q?yCrGkB9pF9o1Swk/Xy1v3iXBJ4HlpB3MVtwbX4FMuzVukc5LujwIfFAKkfpw?=
 =?us-ascii?Q?qRjhZV62JpYfwp7sEUljiONDmShw2yiiMfbrvxZYbggq7egzh10wrnJiCwIv?=
 =?us-ascii?Q?PDO3kUCyrFRsTzzO0s8FuWyG7UgEYcPyjS4UcnXrFR/fyR6gwNJ3yekpXacs?=
 =?us-ascii?Q?bhymm1vfq36YLms1KKr9UMa7L3YRR51C2ToxmP5enolPI7EGzWn2vlkgNySi?=
 =?us-ascii?Q?PONKVSDe8qYRAiG/qA28/R8jnXugNT12bRa1MvofDcjZAyhLials4HGGFuhd?=
 =?us-ascii?Q?EieFEYE88W4U26WFtznIUKqGJs4xWbBXdQQTgHPv0Cp6luxXFPnkgEx8hxOd?=
 =?us-ascii?Q?3w0Ds2TUZlAGVxnlw9V0HLMvOGWwuPrBK2ZurcQSm+729luHE0d7EuNuDyu0?=
 =?us-ascii?Q?wQ/Bmj5q6L7kcBBqOQsdktxAvxfzWxWknu1S5ArjBEQARcYyGqBgRp/qa4qs?=
 =?us-ascii?Q?ZDghFEmXA2ljXYLi40oz/a3ECFGNv7bXcZXSokFLKlCsRZYgwzEdfIVxP9vF?=
 =?us-ascii?Q?klrhRABlFelTEpLtm5l8NjYiNSx/solsToBpjNrKs6QD7Lwl+wwW/TNGBZsX?=
 =?us-ascii?Q?qEXlfik8/hWvueB8YbElByHl8PEuP8MfgTlWZ/gZ13Bb3RaP9/F14xwlo9fl?=
 =?us-ascii?Q?hi/ugA0Pvc9a9ctFPsVkoFQ1e+7yl3KOSyRmfDwuX8nDaq69qWFxfO6+Bm1T?=
 =?us-ascii?Q?8mOBlHUwBDyFjHLStbJvIKSzM7Ud?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:01:05.8296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0214133-132b-4482-2cda-08dcea058839
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8808
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

KFD process device data pdd will be used for VRAM usage accounting, save
pdd to svm_bo to avoid searching pdd for every accounting, and get KFD
node from pdd->dev.

svm_bo->pdd will always be valid because KFD process release free all
svm_bo first, then destroy process pdds.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 27 +++++++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  2 +-
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 857ec6f23bba..d40f6fb803df 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -180,7 +180,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
 		if (is_zone_device_page(page)) {
-			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
+			struct amdgpu_device *bo_adev = prange->svm_bo->pdd->dev->adev;
 
 			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
 				   bo_adev->vm_manager.vram_base_offset -
@@ -457,11 +457,11 @@ svm_range_validate_svm_bo(struct kfd_node *node, struct svm_range *prange)
 	}
 	if (svm_bo_ref_unless_zero(prange->svm_bo)) {
 		/*
-		 * Migrate from GPU to GPU, remove range from source svm_bo->node
+		 * Migrate from GPU to GPU, remove range from source svm_bo node
 		 * range list, and return false to allocate svm_bo from destination
 		 * node.
 		 */
-		if (prange->svm_bo->node != node) {
+		if (prange->svm_bo->pdd->dev != node) {
 			mutex_unlock(&prange->lock);
 
 			spin_lock(&prange->svm_bo->list_lock);
@@ -532,6 +532,7 @@ int
 svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			bool clear)
 {
+	struct kfd_process_device *pdd;
 	struct amdgpu_bo_param bp;
 	struct svm_range_bo *svm_bo;
 	struct amdgpu_bo_user *ubo;
@@ -548,17 +549,22 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 		return 0;
 
 	svm_bo = svm_range_bo_new();
-	if (!svm_bo) {
-		pr_debug("failed to alloc svm bo\n");
+	if (!svm_bo)
 		return -ENOMEM;
+
+	pdd = svm_range_get_pdd_by_node(prange, node);
+	if (!pdd) {
+		r = -ESRCH;
+		goto out_free;
 	}
+	svm_bo->pdd = pdd;
+
 	mm = get_task_mm(p->lead_thread);
 	if (!mm) {
 		pr_debug("failed to get mm\n");
-		kfree(svm_bo);
-		return -ESRCH;
+		r = -ESRCH;
+		goto out_free;
 	}
-	svm_bo->node = node;
 	svm_bo->eviction_fence =
 		amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
 					   mm,
@@ -629,6 +635,7 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	amdgpu_bo_unref(&bo);
 create_bo_failed:
 	dma_fence_put(&svm_bo->eviction_fence->base);
+out_free:
 	kfree(svm_bo);
 	prange->ttm_res = NULL;
 
@@ -1176,7 +1183,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	unsigned int mtype_local;
 
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
-		bo_node = prange->svm_bo->node;
+		bo_node = prange->svm_bo->pdd->dev;
 
 	switch (amdgpu_ip_version(node->adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 1):
@@ -1440,7 +1447,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 	int r = 0;
 
 	if (prange->svm_bo && prange->ttm_res)
-		bo_adev = prange->svm_bo->node->adev;
+		bo_adev = prange->svm_bo->pdd->dev->adev;
 
 	p = container_of(prange->svms, struct kfd_process, svms);
 	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index bddd24f04669..fad2d6d2223a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -48,7 +48,7 @@ struct svm_range_bo {
 	struct work_struct		eviction_work;
 	uint32_t			evicting;
 	struct work_struct		release_work;
-	struct kfd_node			*node;
+	struct kfd_process_device	*pdd;
 };
 
 enum svm_work_list_ops {
-- 
2.43.2

