Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367B1C79F9E
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 02:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB17510E08C;
	Tue,  8 Sep 2026 02:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x0aAQCxn";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A5B10E08C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 02:33:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjTTorivhqjizik0mMZzbyX2bEHZcFSv1mkFQaH7jJU+bHjhzJILfaxJHxxAf3vHS2zKehbPTTMLKYPxp3bEO30+g2vatp5Uff0DYtBGUYhcsB2EPN5G/3KOoULEA4Sk1BaQUVkQs+YJOAwFLbfQbJwT4OsK3MAS06xBFao6iIE/BrWOurYz43nW2p+3zQsfCZp0tYA2qT7s7vWtFN3jZfE6WfKCBFnsL2NKIDM+KQCV/VlhQgatXa7VXwGbRG90SU2dof+sy9IxGs2GbkHMa14Si64MXygP36Tdeo7n33U79WH9Wg/PsuInl36i5VZGE5NzYmPltOSklxxA8L1RIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFOyOHxCtnvUzuIH0+96E2waCwv162OHO4kHI0uho7s=;
 b=cnsAFJ2az+pSILOuZs9OiLAx/oRrjsbXhTqpSkab9pJEk9HetScXXQkLSAuYStbmgXZqfoTsH14FCDGuQqOjXxFl3DzG6p+s3AmHdwvyggaCGgC3j8NFXDIELL4EVLHC0koqjtfqQtN9t6ZK+C990TkannWY+usO+Gr3xQ0fxW9lOd5A5MhfLpnhjTIZNl3GE2tuxXtZugcAoumAFG1ZJvenq6u1ebo8+lLeGcLuZmxD7Vwp2qywrQ2K8GlubM3AogTg0M22zVSoznRoZJhE79Q47+DTwR/85SWLqcGVhNJXNN1C2bqzI/vrK7q4BP4CqI/c0bAJEcpjFKXAMd0htg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFOyOHxCtnvUzuIH0+96E2waCwv162OHO4kHI0uho7s=;
 b=x0aAQCxn+zjIKQf1yi4Ihpo3xIY4jgHanCJYP5xk7u+vYg1nTZ80VdHrK3LP2ri7yxxGdBXPBizd0S6v+HZwFc/yzgLZ/ofJs6d6/tDms81p7KWs8vuJ1o1Wsz/VBorfWcL4GfDzBOGVDT0RrynYwNCuY8TpSsstZ9FaYa6kFHI=
Received: from CH0PR08CA0003.namprd08.prod.outlook.com (2603:10b6:610:33::8)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 02:33:10 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::a0) by CH0PR08CA0003.outlook.office365.com
 (2603:10b6:610:33::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 02:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 02:33:09 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 21:33:06 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <Yifan1.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH] drm/amdgpu: use ttm_to_amdgpu_ttm_tt() instead of open-coded
 casts
Date: Tue, 8 Sep 2026 10:32:48 +0800
Message-ID: <20260908023248.2663780-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: e047faf4-5bbd-41e7-77f2-08df0d5185e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 5zJjFgiT5IvXou5gCC2dNajiThTTqBpczrHxAudUgTc3gAYrgnWZKcylJju9j2jVr5Kt57FTo2dwBXu4xK56wEoo8pxC3Q5GhciD6pIhwZE9hoJIL6l2b7eWLM9D1e87nGtOM9imbl169UccyCr2hup/Ca5G8OlNqt3OuI1pzSsQCfKCkzmNO9C56wy/nHAh6BhFpvLyQdLLv/7DjdL3gsbf8cUFx8SjVn6vQwnfvHObpy3unvWKftHznqaenia3KqOT/uPxazyLDI0PqY1m5jq9u8yiwq5E6bYjZYnvXhJIGUT/eU4hG4g+FMpXurbCejefUXw0MGfW/iBBQN1sioDz8tzmJfYSgY3N6qdmCTIBaUBk7sLCoAG80+Lg9pL7iK+VFJ/Kwh5m3rMEU5vyP9eckiDu9vDShaZ7GhDnbfHlIjOSId5aqXCT6OjdBwS8Q9hWs4WrqggFDFFKI1Xr7NJd0htqrEoJKyp0+BAA3j7fITtb+1V4FUDgX1g5SPfRGbFcqfVYz4QchUe0Ha3eg14mWu1gG1U1VCLvsL85e6+7wU1/ZBhV6bH1QxhKtDnjya1l8eDlQ0kAAz7Ct340Y6cHVLeK2Epe1kO+16l5R1D5lnd1c5MazMaZP2bZCYeE1w60b3ZKmSwwB2hq4hg9AjXFZzUfYfntGvWiKyphEWbBwEesl5DmYUpimcSN5bmRRhkRtSEkDf6aPYzVKdaNkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J+3ekCfqDaRMAAISkd6776WT22jfmfkdufeJi653ECq94e4cPrSXuLyMa8eHPQ9vCXDOvzqGUdexeaLUVORT/jQxqEPi/KDRkW5bI/LhZYJgtZz5LH8HizI4INHa7DIQBvpaq6z5b2RqneMXISaYVQujZ/Un1VcO2u01hoWPD+EPdsJmjRK5ymIsylZpF2r6qauoHBx8KJ0Hy8IGKNAl0KpcSFZwLL8js0W6se7oJgJWUnABeE6h1ddVUEzaVEq5DXUKV9soU2wZ8DvQMcSr1EUnsxFdCrd6YWjYvgQt1r0Bf0V9t4bvfGSYiz+nXFDlwA9T48cwRyUKRoSwXpy7BF/ZO6JmlWSm5e+rxjf8jSLW4TeaPZ6R0z+prfNbWqiiPFstEet/UxiNRU5GGFMqW7+37kOJLW9roFW0qy1IgDDoOQcoCp4pjb5THgsIxp0l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 02:33:09.8943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e047faf4-5bbd-41e7-77f2-08df0d5185e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
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

Convert all of them to the existing ttm_to_amdgpu_ttm_tt() helper, which
goes through container_of() and is checked at build time.

No functional change intended.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ff6eeca5dabf..6a24705b4b48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -854,7 +854,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 {
 	struct ttm_tt *ttm = bo->tbo.ttm;
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	struct mm_struct *mm = gtt->usertask->mm;
 	unsigned int flags = 0;
 	unsigned pinned = 0;
@@ -950,7 +950,7 @@ void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct amdgpu_hmm_range *r
  */
 void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct page **pages)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	unsigned i;
 
 	gtt->last_set_pages = atomic_read(&gtt->mmu_invalidations);
@@ -969,7 +969,7 @@ void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct page **pages)
  */
 void amdgpu_ttm_tt_mark_user_pages(struct ttm_tt *ttm)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	unsigned i;
 
 	for (i = 0; i < ttm->num_pages; ++i) {
@@ -1067,7 +1067,7 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
 static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 				struct ttm_tt *ttm, uint64_t flags)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	uint64_t total_pages = ttm->num_pages;
 	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
 	uint64_t page_idx, pages_per_xcc;
@@ -1505,7 +1505,7 @@ int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
 	if (!tbo->ttm)
 		return -EINVAL;
 
-	gtt = (void *)tbo->ttm;
+	gtt = ttm_to_amdgpu_ttm_tt(tbo->ttm);
 	*user_addr = gtt->userptr;
 	return 0;
 }
@@ -1621,7 +1621,7 @@ bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
 bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
 				  unsigned long end, unsigned long *userptr)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	struct amdgpu_ttm_gup_task_list *entry;
 	unsigned long size;
 
@@ -1661,7 +1661,7 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
 bool amdgpu_ttm_tt_userptr_invalidated(struct ttm_tt *ttm,
 				       int *last_invalidated)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	int prev_invalidated = *last_invalidated;
 
 	*last_invalidated = atomic_read(&gtt->mmu_invalidations);
@@ -1674,7 +1674,7 @@ bool amdgpu_ttm_tt_userptr_invalidated(struct ttm_tt *ttm,
  */
 bool amdgpu_ttm_tt_userptr_needs_pages(struct ttm_tt *ttm)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 
 	if (gtt == NULL || !gtt->userptr)
 		return false;
-- 
2.34.1

