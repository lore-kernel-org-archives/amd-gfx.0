Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139A4CA100F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Aug 2024 18:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 737F010EAD9;
	Fri, 30 Aug 2024 18:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sKhKWD9q";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FCEE10EAD6
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Aug 2024 18:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glaBISPcVBnkem+Y6as6pBobh3e5bRuvkWWSgz0X2z63hc8CjFmJ4Ue//2oeOnWqQSpfix6U42y25SoeqYz7hm+alPkczT0gltBvZMU4Z9zP1SeCOdPVJ9mDZ+LM/lwoaOt2aZNqmTsQagUs8DNfa/cvwqUHKC9LFWd1ME3+g0mrWjoyzUPuordTrX4wvhfqjulvTnKGAK51vRo+OimiiiDK6C+3OT7mDRATp0zG1g/+Pt+fyzMnwg7IIy/Q/WlmIWC1ufvJhfKkniL93cRCLUK71AsqHzChd8kXW/7cHRRa+XZ/KVsFUKAe2yIqnK+N+I++SNL1pe71kqdEyvsLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3m/Rp5LIVANpfdfFu8dPH6nlJyUIQZxQa1ywNM88/QI=;
 b=DDr096WbGNQpKzbUsZwGQPCKN0fZplvvo3ptkrCYBgcg1Reje/loPEiknWnlCsxQFRZimxP2cLgn21rhhqUcP7zqmcn0Zk80NLflzF7DtMlnvNMaYzzJvKDQ+qwC4r7pbLD8K8A5vPceXCPA1KAru09hPcMrflY5TIE00sNkQSh27XAO95eg/DjxIeHxnq0Hy5C6SyPofXHUKqbSvqh9N6FQseE6RjHCh5EfpQb1TbIQg0QQza1E4MwncHOBlLSXGINGYooRT5zftStvTtYAnZpF101o0I2j6qqITxXTPUxvj5R9us8kH0/zTS94iaUNCOGmF3HbAi1eQSBar8aFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3m/Rp5LIVANpfdfFu8dPH6nlJyUIQZxQa1ywNM88/QI=;
 b=sKhKWD9qnPTVYxDwFHI/8XO1G/VNmVD+lxBxrc4pOM2Fezqm1C9thw/K2UKctWZ+uqkglvgfVH0KYl7iZ3BU6Zi/UbReopfqv3MVFTIVm9uwy80YpV5YWaCpGWAMMmPlIyVWUHcvX8VUDn89Q4v4mEF7Foktfqgw0gDOGpGYEGk=
Received: from BY3PR10CA0018.namprd10.prod.outlook.com (2603:10b6:a03:255::23)
 by SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 18:44:12 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::54) by BY3PR10CA0018.outlook.office365.com
 (2603:10b6:a03:255::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Fri, 30 Aug 2024 18:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 30 Aug 2024 18:44:10 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 13:44:06 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: Add few optimizations to userq fence driver
Date: Sat, 31 Aug 2024 00:13:22 +0530
Message-ID: <20240830184322.1238767-6-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|SA3PR12MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: 27cdd775-751c-4410-0e69-08dcc923bd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?stXHIpjMSS1hMXnFeeXf5dl73RYnyxbVVjkhCYGh+XeJIiQ7t8T5ifkfpQ+S?=
 =?us-ascii?Q?TRx15KJSgS86C1REum8H+b41vjQkRGwVRsCxIupTiMoPI995LKDrxNKzYlIy?=
 =?us-ascii?Q?T65Z1PEFEZRl2bKfUAye2GmRPjPBJhvsI80bzFSZYnLQtDe3c5rrbysW7Lkh?=
 =?us-ascii?Q?61MW6Os4YRWbCe0HdsL8JA8LLNRV0w5PwRFymcQhvoqB7IudqJjlrwy6jVgm?=
 =?us-ascii?Q?71QshZ4ch/+A8Yhc033T0guHZKw4/RCLynEA0GdJLzT/pBlWCMFfwOwaj7sl?=
 =?us-ascii?Q?gRI4ncdlz8UBPaVm0DpYb5UEJqPOuepdS2VLLq0raOxdNbpCehqnOh7743A3?=
 =?us-ascii?Q?KrZTH4TzksMxTlgMebhz0qlNvpBnl1jPioCyXzzj2hmxXFqimuCCfQ1O15fq?=
 =?us-ascii?Q?0yqONp6drH76xK7Mfg3qhBOkiU2lBxbSvmvyYAY+rXhJXhgtetKVwEOO2OfT?=
 =?us-ascii?Q?cd7dqDZ8Z8oT3Mg3Bgitr15vjAYEco8/vEcn/pVwswLz90bil1tVlLYMzQZQ?=
 =?us-ascii?Q?3wsWA5s2Z0hjhlmc4RtauLhU/hUI0rEky6H01UXBolr2vTVLXT7bNacjDB9A?=
 =?us-ascii?Q?kYnVkmWOrgmq2y7h+MQb6esU2hg36RQZAx4jYEyh42OggqZGrK+VdzQTGaFq?=
 =?us-ascii?Q?QmoZ725Shhc7YUTs+amHohDoj/h4meAdH/UhoEcJfYHrcDP/O2RZYTc0iG5J?=
 =?us-ascii?Q?YSWjD4njOyHeJ0pj2PAy4plKZC3CYg8o4bwU1YuACjErxkvIJovsVmS6YYJo?=
 =?us-ascii?Q?K34N6CieU4tqd8FS2fmVv7bpb5MSWJJAPSsu/s49pR3ZWClAd4lOfnq8mlp6?=
 =?us-ascii?Q?jKXwWiNesXhMaaqYv3yNaJtDX9VYTuXP32Xfb/cm1k9hGZEySZRs2PFuZT4h?=
 =?us-ascii?Q?orvVvqX0sUqni3uTHdAxgTR640K4r1VJ/w49LogfsPVL3Cc57H6+iAa/3eT6?=
 =?us-ascii?Q?o8n3o/H05rExcf4MTuPmPBO6ltvm3JhdZkgh38rGqXq3/s8EN8BbIJaOVIp7?=
 =?us-ascii?Q?4c0CGn2wlXtI5ChoynO9llCvmboowYr8541OrHPAds3yF0PAL8aE15K1w9uJ?=
 =?us-ascii?Q?yCVjjBEoxM+84ItZ27Cr+oeuN80RyKcnGeclm9HwsCYacRTxSNIyUSYF4Fiv?=
 =?us-ascii?Q?mYaruweDxsEQWC8YN2bxV/3DlEXCuTyRsiyaRqH6Yee2nX2px3u0Jtd/2dgi?=
 =?us-ascii?Q?rxRSPvBmDKqgBKLd9lxT4QplWdEoCVYWwsTl4q1/pUm90+aqWB/fPtCm/4ie?=
 =?us-ascii?Q?InxvVQSb54JMeuoZ+mS85Sr+Sgvfqnw3C2DtznHrUxJnn2WS9HsBhKDMZ294?=
 =?us-ascii?Q?G4WhYxT/Tb72rtBbxBLZD6yrHRxBOhnYdpYFtOGmWkPxixEKW3my1N8KHco8?=
 =?us-ascii?Q?tP4jh6f6gL6lKaRqd6ojOM6DAxOq3k6bI8ZoaHptYF2IHz+tMcmcpJZ41Y/p?=
 =?us-ascii?Q?eW3fz2m0kxccVSTpl7eq2uonS+GWddcr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:44:10.8695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cdd775-751c-4410-0e69-08dcc923bd3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9198
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

Add few optimizations to userq fence driver.

v1:(Christian):
  - Remove unnecessary comments.
  - In drm_exec_init call give num_bo_handles as last parameter it would
    making allocation of the array more efficient
  - Handle return value of __xa_store() and improve the error handling of
    amdgpu_userq_fence_driver_alloc().

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 64 ++++++++++++-------
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  6 +-
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  2 +-
 5 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5ec6cb237c81..3c4568929d12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3967,7 +3967,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	spin_lock_init(&adev->audio_endpt_idx_lock);
 	spin_lock_init(&adev->mm_stats.lock);
 
-	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
+	xa_init_flags(&adev->userq_xa, XA_FLAGS_ALLOC);
 
 	INIT_LIST_HEAD(&adev->shadow_list);
 	mutex_init(&adev->shadow_list_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index c6d201abf5ec..a30b8abe8a2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -76,7 +76,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
 	if (!fence_drv) {
 		DRM_ERROR("Failed to allocate memory for fence driver\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto free_fence_drv;
 	}
 
 	/* Acquire seq64 memory */
@@ -84,7 +85,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 			       &fence_drv->cpu_addr);
 	if (r) {
 		kfree(fence_drv);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto free_seq64;
 	}
 
 	memset(fence_drv->cpu_addr, 0, sizeof(u64));
@@ -94,18 +96,30 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	spin_lock_init(&fence_drv->fence_list_lock);
 
 	fence_drv->adev = adev;
-	fence_drv->uq_fence_drv_xa_ref = &userq->uq_fence_drv_xa;
+	fence_drv->fence_drv_xa_ptr = &userq->fence_drv_xa;
 	fence_drv->context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv->timeline_name, current);
 
 	xa_lock_irqsave(&adev->userq_xa, flags);
-	__xa_store(&adev->userq_xa, userq->doorbell_index,
-		   fence_drv, GFP_KERNEL);
+	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
+			      fence_drv, GFP_KERNEL));
+	if (r)
+		goto xa_err;
+
 	xa_unlock_irqrestore(&adev->userq_xa, flags);
 
 	userq->fence_drv = fence_drv;
 
 	return 0;
+
+xa_err:
+	xa_unlock_irqrestore(&adev->userq_xa, flags);
+free_seq64:
+	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
+free_fence_drv:
+	kfree(fence_drv);
+
+	return r;
 }
 
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
@@ -149,7 +163,7 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	struct amdgpu_device *adev = fence_drv->adev;
 	struct amdgpu_userq_fence *fence, *tmp;
 	struct xarray *xa = &adev->userq_xa;
-	unsigned long index;
+	unsigned long index, flags;
 	struct dma_fence *f;
 
 	spin_lock(&fence_drv->fence_list_lock);
@@ -166,11 +180,11 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	}
 	spin_unlock(&fence_drv->fence_list_lock);
 
-	xa_lock(xa);
+	xa_lock_irqsave(xa, flags);
 	xa_for_each(xa, index, xa_fence_drv)
 		if (xa_fence_drv == fence_drv)
 			__xa_erase(xa, index);
-	xa_unlock(xa);
+	xa_unlock_irqrestore(xa, flags);
 
 	/* Free seq64 memory */
 	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
@@ -214,12 +228,12 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	amdgpu_userq_fence_driver_get(fence_drv);
 	dma_fence_get(fence);
 
-	if (!xa_empty(&userq->uq_fence_drv_xa)) {
+	if (!xa_empty(&userq->fence_drv_xa)) {
 		struct amdgpu_userq_fence_driver *stored_fence_drv;
 		unsigned long index, count = 0;
 		int i = 0;
 
-		xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv)
+		xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
 			count++;
 
 		userq_fence->fence_drv_array =
@@ -229,9 +243,9 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 		userq_fence->fence_drv_array_count = count;
 
 		if (userq_fence->fence_drv_array) {
-			xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv) {
+			xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv) {
 				userq_fence->fence_drv_array[i] = stored_fence_drv;
-				xa_erase(&userq->uq_fence_drv_xa, index);
+				xa_erase(&userq->fence_drv_xa, index);
 				i++;
 			}
 		}
@@ -377,14 +391,12 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	int r, i, entry;
 	u64 wptr;
 
-	/* Array of syncobj handles */
 	num_syncobj_handles = args->num_syncobj_handles;
 	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles_array),
 				      sizeof(u32) * num_syncobj_handles);
 	if (IS_ERR(syncobj_handles))
 		return PTR_ERR(syncobj_handles);
 
-	/* Array of syncobj object handles */
 	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
 	if (!syncobj) {
 		r = -ENOMEM;
@@ -399,14 +411,12 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	/* Array of bo handles */
 	num_bo_handles = args->num_bo_handles;
 	bo_handles = memdup_user(u64_to_user_ptr(args->bo_handles_array),
 				 sizeof(u32) * num_bo_handles);
 	if (IS_ERR(bo_handles))
 		goto put_syncobj_handles;
 
-	/* Array of GEM object handles */
 	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
 	if (!gobj) {
 		r = -ENOMEM;
@@ -421,7 +431,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
+
+	/* Lock all BOs with retry handling */
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 1);
 		drm_exec_retry_on_contention(&exec);
@@ -526,7 +538,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		goto free_timeline_handles;
 	}
 
-	/* Array of GEM object handles */
 	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
 	if (!gobj) {
 		r = -ENOMEM;
@@ -541,7 +552,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
+
+	/* Lock all BOs with retry handling */
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
 		drm_exec_retry_on_contention(&exec);
@@ -703,9 +716,16 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			 * Otherwise, we would gather those references until we don't
 			 * have any more space left and crash.
 			 */
-			if (fence_drv->uq_fence_drv_xa_ref) {
-				r = xa_alloc(fence_drv->uq_fence_drv_xa_ref, &index, fence_drv,
-					     xa_limit_32b, GFP_KERNEL);
+			if (fence_drv->fence_drv_xa_ptr) {
+				/*
+				 * Store the fence_drv reference into the corresponding
+				 * userq fence_drv_xa.
+				 */
+				r = xa_alloc(fence_drv->fence_drv_xa_ptr,
+					     &index,
+					     fence_drv,
+					     xa_limit_32b,
+					     GFP_KERNEL);
 				if (r)
 					goto free_fences;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index f72424248cc5..89c82ba38b50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -54,7 +54,7 @@ struct amdgpu_userq_fence_driver {
 	spinlock_t fence_list_lock;
 	struct list_head fences;
 	struct amdgpu_device *adev;
-	struct xarray *uq_fence_drv_xa_ref;
+	struct xarray *fence_drv_xa_ptr;
 	char timeline_name[TASK_COMM_LEN];
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index e7f7354e0c0e..9b24218f7ad2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -48,8 +48,8 @@ static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
 static void
 amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 {
-	amdgpu_userq_walk_and_drop_fence_drv(&userq->uq_fence_drv_xa);
-	xa_destroy(&userq->uq_fence_drv_xa);
+	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
+	xa_destroy(&userq->fence_drv_xa);
 	/* Drop the fence_drv reference held by user queue */
 	amdgpu_userq_fence_driver_put(userq->fence_drv);
 }
@@ -348,7 +348,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 	queue->doorbell_index = index;
 
-	xa_init_flags(&queue->uq_fence_drv_xa, XA_FLAGS_ALLOC);
+	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
 	r = amdgpu_userq_fence_driver_alloc(adev, queue);
 	if (r) {
 		DRM_ERROR("Failed to alloc fence driver\n");
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index d035b5c2b14b..6eb094a54f4b 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -52,7 +52,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_obj	db_obj;
 	struct amdgpu_userq_obj fw_obj;
 	struct amdgpu_userq_obj wptr_obj;
-	struct xarray		uq_fence_drv_xa;
+	struct xarray		fence_drv_xa;
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct dma_fence	*last_fence;
 };
-- 
2.34.1

