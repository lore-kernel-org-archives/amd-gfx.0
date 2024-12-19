Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB6EE77184
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 10:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C407C10E497;
	Thu, 19 Dec 2024 10:38:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zMpTNYIG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28CF410E4A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 10:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqQZCfFpP6PZoju91s1LCgzJz+AUN0Gd6RbrXK24CgA0Ztatf3hE7nBY3VP0/zSOiCXqiF69T86c2xvSrFpYJMIWp9DOxvp0LQnP2TxWVVJG5kd7cBXiG+0QVJs3Wer3QEMRvvsUI3o4JitGHKcfrZUAGZ1f3+cAynvkbsIQcaHd7RV68pqb2lmaTTKKoMVpBHj38UV1Wie64jezGUnOcNmxq67pWalUId7cyYCTfhX6X0aWt31pdNGIbWQj5q76Ff3PV1SIYZgn2nhH5O/t1n/6Hll0XrGLLRqFjK2urgHzucziUUJF6+m4GM0Qsleq93sT0Do3ZFeHyivt8QD0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCXblfF3UPMdHNYf49IKqNssQJEJ5meZD4FLxPqrUNQ=;
 b=cvrt6tNn/o5c3Rn8D2x5211C5z36V9b7PPyLei2f42xvAtTOd2tY8DuoO5sGqvBWVVV7OY6URLFssadmsoVndxDVx+E2UXobb1+N8zkP76lUZUHM+FF/Hy440gFl4NX4bxjKeQ3CiiTTKyw2NrSe7hdB+ADgAB58Vxa8cBbuAhQDZfC27dg6sS7Ob+O75o8A7XSoQVyp4RhcJwPRU1jGxjAQssbqY5YZSr/6XQm2rIPbrsyNbrlVSniz0XH+kaR+HRzpiFoIkvuPcb7+dz0QdFKP+obKcPRyxvKTGEDHgJvvy7BHflsctdB37Wzpm1sX6NjgOEtL8Ltludmm6EBuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCXblfF3UPMdHNYf49IKqNssQJEJ5meZD4FLxPqrUNQ=;
 b=zMpTNYIGe41e1jj/IQ2fQ6KGtoVCOI9d9XThARmGTZAm6fbT9OQR08GWdaNxBQOV7u+ZTsjGMfRiiaVdhLMthzRh+OfYIuXX1lCRvmuCqP5S5JObDN8DZrIheBAJdouWrB6aEatn/ki4Bu4CHZ1ZS+HEu/j2cKoBZeFZIOn8DJ0=
Received: from CH2PR05CA0028.namprd05.prod.outlook.com (2603:10b6:610::41) by
 DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Thu, 19 Dec 2024 10:38:46 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::69) by CH2PR05CA0028.outlook.office365.com
 (2603:10b6:610::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Thu,
 19 Dec 2024 10:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 10:38:46 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Dec 2024 04:38:44 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3 2/3] drm/amdgpu: Improve the xa field names readability
Date: Thu, 19 Dec 2024 16:08:23 +0530
Message-ID: <20241219103824.630689-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241219103824.630689-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241219103824.630689-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: c532cfe7-a3c5-47c2-7f03-08dd20195106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XwW127BviIKHFEkpX937HfQALRXWrKde33o5hGMwtEpj1hOMYRskErBkjv1Y?=
 =?us-ascii?Q?bbX5ICKF55s4ntMFEP4ZIgBSWBYsCQS/Ux67SozceGy7srEKIpzlYNBQAfDD?=
 =?us-ascii?Q?5oed9JUdZUqEuycBALngMmryCCoP1Sbmyyo8lfHxRY/kLBX6xtrILqgAWJlB?=
 =?us-ascii?Q?t10R4Llh+KxwQ7PSzcbskFI9mFi97BKcxw4nCgl4bWC5vitaTUY6fgQfQBCg?=
 =?us-ascii?Q?2TfGd8Mu+vcnQqrRry5xkK5j3S3q8YZmv6AA3P6P35rg3JV5L8HL0T/cut0W?=
 =?us-ascii?Q?RBL1DuVM1ddfqtuv+PWRXe1e/1Q/OAccchqCwGt5E8J7gsaN3I/2xTxR4pOe?=
 =?us-ascii?Q?VqgS/PwAcgP4h2hiTlEy+NbsY5DEobaWHCQ7NdY6RvfG8XQQOvABTlyW9ajd?=
 =?us-ascii?Q?pNJMeJs+lrW0CgnvHCdyJjYL83WwG7hr7/UEOyg0vTgwkFvPTmg4tTdf9jbV?=
 =?us-ascii?Q?cNPLdolGsrNxADqMBvrxXHZH0kgw3jj7QsZEUod1lSAFe5v4czfIRZ9uylYB?=
 =?us-ascii?Q?9KAY7XtCowwdJtzCApQPSzqizjEii4G1tmdbNNyXXfEzOFB2VzD8reDYO0Mm?=
 =?us-ascii?Q?qxxYXGp8TTkUpEUelFP9w5CVnXzdXyml/5N/Ec+LHFDRy4jNkAm1Jeao+apn?=
 =?us-ascii?Q?PqjS31Ep5501jQWtjV1JtBlvnCty5h+PoB1BTsGL4xpdCRl0FAWi4hvnGhjj?=
 =?us-ascii?Q?C0o+1BCedLuqfwTPefjVce7BsrOUzFxhiGN5473x1rDWNesEaMjk77aGFFkh?=
 =?us-ascii?Q?cv2QPlJ0oo8lirEXqk4Pk518kGymXk0/gchFUzl4UVRp3z/lsLY2JKjlK3uK?=
 =?us-ascii?Q?4hgUoGRDFtSzHzU54RywwkESBuZGpjlPx6VqEXCv2WD/V0crYqIGOxC3G1Rc?=
 =?us-ascii?Q?aQzwh1p+gZDVcQD7Hl+739FIdEq3CP1QPP5bzx4RFFay1Jkvp54tFV3qFflR?=
 =?us-ascii?Q?DgfU2WWugQeTeZVTd3IG3e99mxWpb9KdO18KVWge3ylTDasIf+xHO4IzyaQX?=
 =?us-ascii?Q?sGZSpxHGFpUi0UlXc0lEyAeTZduVtZajtYcu0qwAHjozA466VCInJknFQIGL?=
 =?us-ascii?Q?hMKHo7S8ulq6BRkegnRsn4pwsTEf0dUqn5v8Q0IKkS3XnhzXFjjSYCg+u+27?=
 =?us-ascii?Q?O31RhGHlzwvJxLmSHXmdpoYQKLI/vv9YquvD57QGeLOno5ui1qWvhxdjKhFM?=
 =?us-ascii?Q?W5+NWupRBV95rdggYKYeXDrQhiGXa+Sn5yagbWo8tpTQZLOTKv/AjHfYIGXw?=
 =?us-ascii?Q?eM0kjyw3tCrzt8oLixCDCe0Llx1duM3zj4dyU6DsczaRpJzDPdkKprmE+YvX?=
 =?us-ascii?Q?zsqBCVgVrwm3Kju4imR6R1SsQ4811GcuTknOah/ZUnyHoGLzmEMVnw0jtF3m?=
 =?us-ascii?Q?vB96fKLywr9NBLf3FUd68nY2eCF5GhXv51II0UAfdhA9EkKLemZBL92maBLv?=
 =?us-ascii?Q?RtzWAv4DKUtylQ2LXNze41S3I2P/x2VPB6eOikhxzvJQ41xRJELkE45NG/NC?=
 =?us-ascii?Q?Qp5YvpSyMlS+rAI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 10:38:46.1192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c532cfe7-a3c5-47c2-7f03-08dd20195106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560
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

Make the xa field names used in the userqueue and userfence
structure more understandable and add more clarity.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 31 ++++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  8 ++---
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  2 +-
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 4289bed6c1f7..6876f24e5eda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -97,7 +97,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	spin_lock_init(&fence_drv->fence_list_lock);
 
 	fence_drv->adev = adev;
-	fence_drv->fence_drv_xa_ptr = &userq->fence_drv_xa;
+	fence_drv->xa_uq = &userq->xa_uq;
 	fence_drv->context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv->timeline_name, current);
 
@@ -122,8 +122,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
 {
-	struct amdgpu_userq_fence_driver *stored_fence_drv;
 	struct amdgpu_userq_fence *userq_fence, *tmp;
+	struct amdgpu_userq_fence_driver *fdrv;
 	struct dma_fence *fence;
 	unsigned long index;
 	u64 rptr;
@@ -142,8 +142,8 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 
 		dma_fence_signal(fence);
 
-		xa_for_each(&userq_fence->fence_drv_xa, index, stored_fence_drv)
-			amdgpu_userq_fence_driver_put(stored_fence_drv);
+		xa_for_each(&userq_fence->xa_uf, index, fdrv)
+			amdgpu_userq_fence_driver_put(fdrv);
 
 		list_del(&userq_fence->link);
 		dma_fence_put(fence);
@@ -222,24 +222,25 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	dma_fence_init(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
 		       fence_drv->context, seq);
 
-	xa_init_flags(&userq_fence->fence_drv_xa, XA_FLAGS_ALLOC);
+	xa_init_flags(&userq_fence->xa_uf, XA_FLAGS_ALLOC);
 
 	amdgpu_userq_fence_driver_get(fence_drv);
 	dma_fence_get(fence);
 
-	if (!xa_empty(&userq->fence_drv_xa)) {
-		struct amdgpu_userq_fence_driver *stored_fence_drv;
+	/* Move all fence driver entries from xa_uq to xa_uf */
+	if (!xa_empty(&userq->xa_uq)) {
+		struct amdgpu_userq_fence_driver *fdrv;
 		unsigned long index_uq;
 		u32 index_uf;
 		int err;
 
-		xa_for_each(&userq->fence_drv_xa, index_uq, stored_fence_drv) {
-			err = xa_alloc_irq(&userq_fence->fence_drv_xa, &index_uf,
-					   stored_fence_drv, xa_limit_32b, GFP_KERNEL);
+		xa_for_each(&userq->xa_uq, index_uq, fdrv) {
+			err = xa_alloc_irq(&userq_fence->xa_uf, &index_uf,
+					   fdrv, xa_limit_32b, GFP_KERNEL);
 			if (err)
 				return err;
 		}
-		xa_destroy(&userq->fence_drv_xa);
+		xa_destroy(&userq->xa_uq);
 	}
 
 	/* Check if hardware has already processed the job */
@@ -809,7 +810,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		for (i = 0, cnt = 0; i < num_fences; i++) {
 			struct amdgpu_userq_fence_driver *fence_drv;
 			struct amdgpu_userq_fence *userq_fence;
-			u32 index;
+			u32 index_uq;
 
 			userq_fence = to_amdgpu_userq_fence(fences[i]);
 			if (!userq_fence) {
@@ -834,9 +835,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			 * Otherwise, we would gather those references until we don't
 			 * have any more space left and crash.
 			 */
-			if (fence_drv->fence_drv_xa_ptr) {
-				r = xa_alloc(fence_drv->fence_drv_xa_ptr, &index, fence_drv,
-					     xa_limit_32b, GFP_KERNEL);
+			if (fence_drv->xa_uq) {
+				r = xa_alloc(fence_drv->xa_uq, &index_uq,
+					     fence_drv, xa_limit_32b, GFP_KERNEL);
 				if (r)
 					goto free_fences;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 3283e5573d10..74edabc8e021 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -37,7 +37,7 @@ struct amdgpu_userq_fence {
 	 */
 	spinlock_t lock;
 	struct list_head link;
-	struct xarray fence_drv_xa;
+	struct xarray xa_uf;
 	struct amdgpu_userq_fence_driver *fence_drv;
 };
 
@@ -54,7 +54,7 @@ struct amdgpu_userq_fence_driver {
 	spinlock_t fence_list_lock;
 	struct list_head fences;
 	struct amdgpu_device *adev;
-	struct xarray *fence_drv_xa_ptr;
+	struct xarray *xa_uq;
 	char timeline_name[TASK_COMM_LEN];
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 85baba323ba5..72ff623f8c8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -48,8 +48,8 @@ static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
 static void
 amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 {
-	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
-	xa_destroy(&userq->fence_drv_xa);
+	amdgpu_userq_walk_and_drop_fence_drv(&userq->xa_uq);
+	xa_destroy(&userq->xa_uq);
 	/* Drop the fence_drv reference held by user queue */
 	amdgpu_userq_fence_driver_put(userq->fence_drv);
 }
@@ -73,7 +73,7 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	}
 
 	uq_funcs->mqd_destroy(uq_mgr, queue);
-	queue->fence_drv->fence_drv_xa_ptr = NULL;
+	queue->fence_drv->xa_uq = NULL;
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
 	kfree(queue);
@@ -315,7 +315,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 	queue->doorbell_index = index;
 
-	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
+	xa_init_flags(&queue->xa_uq, XA_FLAGS_ALLOC);
 	r = amdgpu_userq_fence_driver_alloc(adev, queue);
 	if (r) {
 		DRM_ERROR("Failed to alloc fence driver\n");
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index e7e8d79b689d..8048a5fb917a 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -53,7 +53,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_obj	db_obj;
 	struct amdgpu_userq_obj fw_obj;
 	struct amdgpu_userq_obj wptr_obj;
-	struct xarray		fence_drv_xa;
+	struct xarray		xa_uq;
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct dma_fence	*last_fence;
 };
-- 
2.25.1

