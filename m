Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7958C00140
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 00:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34540B2F12;
	Tue,  9 Aug 2022 00:53:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F071EB27B0
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 00:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZTG8LgVy0OwiwbgJgCwmyD4P76eVZF1kzBCJliWgoXDVWX1hVNwdlQ823xzUBmsJvOrmD1EQ1wa3pz0YNcuOQn8OT+00Keh5BCLBBp6hboI0FTcuItrbKBr4lbqo1Izmjp/IR89hcsKu/vCnIFBX3Vq0vYQvPMLTpTUgXv9V3tWfYhXgP2K6iStv5paU/F6RdjGuoGhJmWyvvLVoeZyEIcf+psDCjH0Ix0eXejL1U/eb/wNzmuDo++nY84rCY8BH9Dl4bMRxMx6oZY1V1DPogOohlZt1e6KtEh1DM+DRipcr8X2Xp9ljEhhX+d6Hev8C++fc2R0c/g6zptYKNLJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZHHYrAGmTHdxnDiWm1eJ9pn0R7QXcGb2Rz+MjNigHs=;
 b=RlYW+kHarxeThyGGMTA9Zt3RQdAyFQT1QBKdNmzVdlVkxdf2ROq4WOqwSIwCAX6YWcbnB+MYNZiDVNHfRacvsLDCZFqbAixrqA6bZl6a1YTAMVVJHE6WTxXyFedxqHCWwd1bRI07GjQBtLGioI6fg7WRKlAIWYkiVw3pSLiL/ZdRJ0RFF0KZQ6l6JBkdnGkbYb118wZq9+x0Tt27cccCZPXXMRRsg2iPRbzVwjg5no7+PIxfiG94W+Y6YyWNzUlyWkfZcn9VseM/BGaChucfEnfIE2WKiUzVYVrVexNbVeykAw3ZVhjOsIDA7UNzgZPDHEHvUFMiFhiFRKSDEmHYFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZHHYrAGmTHdxnDiWm1eJ9pn0R7QXcGb2Rz+MjNigHs=;
 b=I7sUntjdlwFfIMw+7w+fhKzjEIdSzAZYV3nCEi/aMa5/2JCWQzV+29vWwU1ojS1Hf05tI6rorj5rCLZkOl/OwCDMUnntmF4QpXc+RhvgyERu6jt1tj7RCEneKazWrUiBn3qAxihcZ6JEfd+uddb7BKOkECdvml2vXgj5UAm0zmw=
Received: from DM6PR10CA0036.namprd10.prod.outlook.com (2603:10b6:5:60::49) by
 BY5PR12MB3891.namprd12.prod.outlook.com (2603:10b6:a03:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 9 Aug
 2022 00:38:55 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::8d) by DM6PR10CA0036.outlook.office365.com
 (2603:10b6:5:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20 via Frontend
 Transport; Tue, 9 Aug 2022 00:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 00:38:55 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 8 Aug
 2022 19:38:54 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix mm reference in SVM eviction worker
Date: Mon, 8 Aug 2022 20:38:38 -0400
Message-ID: <20220809003838.684180-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a045e77c-9e0c-4cd3-ec3e-08da799f8a33
X-MS-TrafficTypeDiagnostic: BY5PR12MB3891:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArVJre7TrGKOvzIttwPKS8Nmw81pD11XkX16g5/cw90blekqilCy89avL/IwMpF4bY4sYELs3+F8vTIM0yA7luN20g0uXOPsX4gz63NBiMALNOE6dUHPqFxXVHPYCDdHOvXWRMeMYbsNh0KrGVie9avq0e9Xgwuy0O/ts3D2p75ykYxxnNAuudyN68lPVWrGK202DjhjXFOq8YAKvLn8G9WaTg/9IIQOnU9pK93HAwHCdpuhNsu5tjB460t7qTrorRlAFAPWPfjkuSQkNDeLnL6BgUhz1vSXAbR0ZzNd8IBux5/8umCE1ioGWND9H6ZddPOphoYs+pdq5D9yx9MpADn80HfuNT6Kq1Iv6efYGteMZ4daQkvgNXd1jv8nqpkReG582L6LerUloAd6XVTOjytdMoI3SROfVIAbyu50cJU7W2obWxw1D49XGRB09DUJHV/PLvDLLyXYKDKIxJ8LZdKXMfrhjvtqN9VXQMamdkKlmq7uGQbsi1cRJg+JigK7xOjk8w5YL56kLZQ7fBuytsCiN0SnosBHKH5bnGr+M37fNvlzCa9IgAV/1FKO/bktYFASJ4873EqdAFa/9A9+TVPxDQqcXDSz0YnfUmpm7IYGJntRUk/hWBIOa7VBCFa6zGta/Wj3o3zQ4DM2XafS40x/Cg+v3oGTJU5JBOOdcOeRif1katgp2J8+WfevjyrckVCBDw97fJlToYcURtV0gXxvERB8I1S/ww6sAyWFDFe+SCbuUTT+6GEerqKPnIJ+8ya/QZQnsgzCgAaq82s7UJF9s5LuU8d8ZNSqfJ4xt+8Kv3Ri5lBD67SFtXHeROU7nwKWc2t3mk6cP75aMEFrSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(40470700004)(46966006)(36840700001)(426003)(16526019)(5660300002)(336012)(478600001)(186003)(47076005)(2616005)(1076003)(70586007)(7696005)(26005)(36860700001)(40480700001)(70206006)(41300700001)(6666004)(86362001)(82310400005)(36756003)(2906002)(83380400001)(40460700003)(8676002)(4326008)(8936002)(6916009)(356005)(316002)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 00:38:55.0672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a045e77c-9e0c-4cd3-ec3e-08da799f8a33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3891
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
Cc: philip.yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the mm reference from the fence. This allows removing the
svm_bo->svms pointer, which was problematic because we cannot assume
that the struct kfd_process containing the svms is still allocated
without holding a refcount on the process.

Use mmget_not_zero to ensure the mm is still valid, and drop the svm_bo
reference if it isn't.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 17 +++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a67ba8879a56..11074cc8c333 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -541,7 +541,6 @@ svm_range_vram_node_new(struct amdgpu_device *adev, struct svm_range *prange,
 		kfree(svm_bo);
 		return -ESRCH;
 	}
-	svm_bo->svms = prange->svms;
 	svm_bo->eviction_fence =
 		amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
 					   mm,
@@ -3273,7 +3272,6 @@ int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence)
 static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 {
 	struct svm_range_bo *svm_bo;
-	struct kfd_process *p;
 	struct mm_struct *mm;
 	int r = 0;
 
@@ -3281,13 +3279,12 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	if (!svm_bo_ref_unless_zero(svm_bo))
 		return; /* svm_bo was freed while eviction was pending */
 
-	/* svm_range_bo_release destroys this worker thread. So during
-	 * the lifetime of this thread, kfd_process and mm will be valid.
-	 */
-	p = container_of(svm_bo->svms, struct kfd_process, svms);
-	mm = p->mm;
-	if (!mm)
+	if (mmget_not_zero(svm_bo->eviction_fence->mm)) {
+		mm = svm_bo->eviction_fence->mm;
+	} else {
+		svm_range_bo_unref(svm_bo);
 		return;
+	}
 
 	mmap_read_lock(mm);
 	spin_lock(&svm_bo->list_lock);
@@ -3305,8 +3302,7 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 
 		mutex_lock(&prange->migrate_mutex);
 		do {
-			r = svm_migrate_vram_to_ram(prange,
-						svm_bo->eviction_fence->mm,
+			r = svm_migrate_vram_to_ram(prange, mm,
 						KFD_MIGRATE_TRIGGER_TTM_EVICTION);
 		} while (!r && prange->actual_loc && --retries);
 
@@ -3324,6 +3320,7 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	}
 	spin_unlock(&svm_bo->list_lock);
 	mmap_read_unlock(mm);
+	mmput(mm);
 
 	dma_fence_signal(&svm_bo->eviction_fence->base);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 9156b041ef17..cfac13ad06ef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -46,7 +46,6 @@ struct svm_range_bo {
 	spinlock_t			list_lock;
 	struct amdgpu_amdkfd_fence	*eviction_fence;
 	struct work_struct		eviction_work;
-	struct svm_range_list		*svms;
 	uint32_t			evicting;
 	struct work_struct		release_work;
 };
-- 
2.32.0

