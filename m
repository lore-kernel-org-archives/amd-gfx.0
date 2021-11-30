Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D494CC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 20:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 436DF6E4FE;
	Tue, 30 Nov 2021 20:13:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4077D6E4AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 20:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwF0Gonqqr7iLDJ7fk9izKFqh/OX7K2f4B2lnGCsFHMFLuR5FR5X/r98ir6n1+2PX8T7089+Kt+OtrPnk2O+LJtg/E0rZF8NL2RIT93zEoBNN4Yb+AnUV5SqjGjX9vDoTuXL71O4cJl2KrbmINWEZA8JWKjKwbsFzB2zSW3FhJitbUVi8a6TVBDnO4fxzIuZfjeO+540qP0u26oQezWY3XlCRhFWofZruUJjzcbdbEonOqh/STQ5t2ZiDUh6GAAJ0qzgQ34I8ZGIH3J83NJFCGgI1iBk8f59wYp+1SuJLev9dI3WJZi63bR20QNXHAm2UiE4d4z5Shxhv9Rc2SrHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOORhAiEK0IidwMN0iWvV2j2QjYtey0qSK0/MfSq+N0=;
 b=oGzMdVSCy24kR0K/N52jW3MlxgGUuw89KmHNv6YLDZxg+4e/R47x9/T11RWOr45avmMVyv6BvfkyaZNDjrmMU2PCJDh98xDmPY3iO7niNSUOIzl/b43ZxKQq7ZoimE966GQV6yoaGrefEz3tFSvnRJWn9cAxFNo5jejBi+lAE0E1Hom9HTB/otBapImX5Ax4WanfPg2cl9eI4NCFW5axAkT2fF9nO8VrTSAvnUlflCTL+WmP5KDt1JkQ1FAvXmjg3vuk/lsfAgpY+h9ZvSVenzEeOHbVphbNRO/tBGySJSZRLBAbgxIlmIwFiFDzPoPJY7CoC6HBtM03aebeB7M4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOORhAiEK0IidwMN0iWvV2j2QjYtey0qSK0/MfSq+N0=;
 b=c03ie18IR/498Wl/QWzPPjMuf3Ay/ZRcFiMNtiWbzFhoq76AfzziodDMPYjCgqJNCSx+/mR0jJN5bdHHGPLu7XWIOVq8Y1nXpgBpPesSYac1ZdKeg0MPjP1GxwEv34AFRSbvem6LgoVoGlgAznGDdbC+SqqdCIAPUtSG1jd4Lss=
Received: from DM5PR06CA0087.namprd06.prod.outlook.com (2603:10b6:3:4::25) by
 MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Tue, 30 Nov 2021 20:13:38 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::7e) by DM5PR06CA0087.outlook.office365.com
 (2603:10b6:3:4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Tue, 30 Nov 2021 20:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 30 Nov 2021 20:13:38 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 14:13:36 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix svm_bo release invalid wait context warning
Date: Tue, 30 Nov 2021 15:13:21 -0500
Message-ID: <20211130201321.22190-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a86311f0-51a5-4d8e-6441-08d9b43de53a
X-MS-TrafficTypeDiagnostic: MW3PR12MB4362:
X-Microsoft-Antispam-PRVS: <MW3PR12MB436259CA8123E6D3E78A6586E6679@MW3PR12MB4362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GTDsjpu4TykfRItQNLVSPc7br3KRh9c/dzwkpVVCqJZoULWVVRyL5guxoiCWE0WvZnnyV1Z6hfDJFfo9SBs+4w5+D2d1d+YOP0J0wWqlwFA3XboikDp0SAblThBLXJRYAvsVDTLYVfZfIre3wWqhEFGzlRkueaNxr+D0FMC/E9w0PIqXzgSIDbHepiVwstH/uJaUoIy2XtSYuF7MLArR/tf3YblkgLJl6Lw62+eOCpjseUHGo8cf/gc5zsVB8UPilGS9oEu7j7mPCJCvDvy9AF3HhBNLrt5k65M9tYtjytpdzTJ1pP1h9t+bxtA7QQxrcVqxCS09Cbuj71WzWE45DXkelzuNbA1nrBxYL3vPt49WauItHQvr1fleHWelxLHC2Qzy67w9AF6OUfUd9JsVs1zON7cWaUcOIZvKLYX/b9uFsked4CCVkqsNaQoQmiqplM0t3YtXqIsLBnl4YwheFn5jpIB7IeNiCTtyz2fx/R3cvlWvNMLCPsy8ZdswYHrEOtjB3P9HERYUF77hJ8rgHNE2/zzKx57dk1ijrCI6ar9Rltx39DWoaNqHN4XAaCv2UJoV5FhngKHRQxygIxBH/rKQll8Nw2t7cy7/WKtmzK2eAdEPCFsUg7yvUyby8D8QzSpz1oXgvzegUoj7BUv9119WugrDCJWJFyKzbcnamRFcQvRUo1slW1rg0JlvdVq+eknc6/hZ5IG8wh4WnN4nziDcr2X3n/Z/O28GbRlZWVd6K6dWnFsqCwBmSjg7pMjC3jfqUbIRu9phn9rUMOBZGnj6iDuq4K5bjf74Z2mOPYM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(70586007)(70206006)(4326008)(8676002)(2616005)(40460700001)(336012)(6916009)(5660300002)(426003)(8936002)(82310400004)(2906002)(316002)(47076005)(6666004)(16526019)(508600001)(54906003)(36756003)(83380400001)(26005)(7696005)(81166007)(356005)(1076003)(86362001)(36860700001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 20:13:38.0668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a86311f0-51a5-4d8e-6441-08d9b43de53a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
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
Cc: alex.sierra@amd.com, Philip Yang <Philip.Yang@amd.com>,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

svm_range_bo_release could be called from __do_munmap put_page
atomic context if process release work has finished to free pranges of
the svm_bo. Schedule release_work to wait for svm_bo eviction work done
and then free svm_bo.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 36 +++++++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 +
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f2db49c7a8fd..8af87a662a0d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -327,11 +327,33 @@ static bool svm_bo_ref_unless_zero(struct svm_range_bo *svm_bo)
 	return true;
 }
 
+static void svm_range_bo_wq_release(struct work_struct *work)
+{
+	struct svm_range_bo *svm_bo;
+
+	svm_bo = container_of(work, struct svm_range_bo, release_work);
+	pr_debug("svm_bo 0x%p\n", svm_bo);
+
+	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base)) {
+		/* We're not in the eviction worker.
+		 * Signal the fence and synchronize with any
+		 * pending eviction work.
+		 */
+		dma_fence_signal(&svm_bo->eviction_fence->base);
+		cancel_work_sync(&svm_bo->eviction_work);
+	}
+	dma_fence_put(&svm_bo->eviction_fence->base);
+	amdgpu_bo_unref(&svm_bo->bo);
+	kfree(svm_bo);
+}
+
 static void svm_range_bo_release(struct kref *kref)
 {
 	struct svm_range_bo *svm_bo;
 
 	svm_bo = container_of(kref, struct svm_range_bo, kref);
+	pr_debug("svm_bo 0x%p\n", svm_bo);
+
 	spin_lock(&svm_bo->list_lock);
 	while (!list_empty(&svm_bo->range_list)) {
 		struct svm_range *prange =
@@ -352,17 +374,9 @@ static void svm_range_bo_release(struct kref *kref)
 		spin_lock(&svm_bo->list_lock);
 	}
 	spin_unlock(&svm_bo->list_lock);
-	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base)) {
-		/* We're not in the eviction worker.
-		 * Signal the fence and synchronize with any
-		 * pending eviction work.
-		 */
-		dma_fence_signal(&svm_bo->eviction_fence->base);
-		cancel_work_sync(&svm_bo->eviction_work);
-	}
-	dma_fence_put(&svm_bo->eviction_fence->base);
-	amdgpu_bo_unref(&svm_bo->bo);
-	kfree(svm_bo);
+
+	INIT_WORK(&svm_bo->release_work, svm_range_bo_wq_release);
+	schedule_work(&svm_bo->release_work);
 }
 
 void svm_range_bo_unref(struct svm_range_bo *svm_bo)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 6dc91c33e80f..23478ae7a7d9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -48,6 +48,7 @@ struct svm_range_bo {
 	struct work_struct		eviction_work;
 	struct svm_range_list		*svms;
 	uint32_t			evicting;
+	struct work_struct		release_work;
 };
 
 enum svm_work_list_ops {
-- 
2.17.1

