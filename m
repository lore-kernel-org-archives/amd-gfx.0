Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1FBC369AB
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Apr 2025 08:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0152E10E10E;
	Sat, 12 Apr 2025 08:13:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3/4f5NIk";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A68910E10E
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Apr 2025 08:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkiiC1kNEl0A87GIA2cYsSs0m6aUYUA4FFtMX2L3C7pEu7EqgYAlecOOGGatQaV+84+YEP7+tkWhCi1QU5gApczF3GWZm1Rs3gz+hKs6duqpLYjgK81mwOhzccgQGRllo2mJ7OtUdQfLvK6bkKAR1Ol6PWOY3Ig3/zjKdkcYAgz83UzwqMia16oRHpnfIWx5QrSPzbKqnFxhlTDn++KMEXNRGo6XHhzzi8jH1CDR+oRRsjtXe1CdJ+b+tJH4/jhMmNZ5rqJcqi824G1/UUoMTGWoJ94/H+ogNnfFIG14xw9146uVQVGEpSm9QEGJYHOlzPAsxl0RTJeyv+sI2J6LxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RLFDj40BX6ria5CDdUw2us0T5oroojCImWNJBNbCms=;
 b=iFAVfgaiKEEdWhTE1pNP70EG3EwvlzM4h497kGG4NG0uw4RFfewMrNg1DjtoqUXTKF8goU/7T0rwl/UsB+EM09gSVu9ihgknWhHm+w/8gfDocBvtUeB7GygZOT9DgtAI5jsJi7d3d3l25gJ0GQ5Zca5fz3D1ShuCRjuuQWIArMGL0ix1GIe4bsMfCt289G4KPZk6nJhnYdzF+UhAD4xO5E0J/HC5kT/cgcXOGkkCSnPXksf9MCuWpPLzT1XdMSvNfPmjRznupnLP6QZNT5VpGcx/ISOj8vJnqC42t9tVXvQrAejtslVZC5R//JJGa1mNyYL8hTtGhyAZRabA0Ij96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RLFDj40BX6ria5CDdUw2us0T5oroojCImWNJBNbCms=;
 b=3/4f5NIkb8d53HcCoKYpXd+INxqSQoYpic1ONz97rw2gxaQEQGA7AcNscgCPxtIs8knq5YyMdDKiVcE/w3wKAduJLGscAr6z4hgsZ1bmTG0x00HR1mNKdrycb4EVPZv+pglSiGUVJ6BeYXl6d72mL8nrC0ECOsJ4O+C6EABjOAk=
Received: from CH0PR03CA0064.namprd03.prod.outlook.com (2603:10b6:610:cc::9)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Sat, 12 Apr
 2025 07:57:43 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:cc:cafe::5b) by CH0PR03CA0064.outlook.office365.com
 (2603:10b6:610:cc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.30 via Frontend Transport; Sat,
 12 Apr 2025 07:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Sat, 12 Apr 2025 07:57:42 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 12 Apr
 2025 02:57:39 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, <marek.olsak@amd.com>, "Arunpravin Paneer
 Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH] drm/amdgpu: Add queue id support to the user queue wait IOCTL
Date: Sat, 12 Apr 2025 13:26:39 +0530
Message-ID: <20250412075639.2494-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: ba80714e-9511-4848-d5ff-08dd7997b400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c01aL0o2Rmk0VlJxR29ENkVtYzZ4dVl4STdZbzFJMjhtZytvc0k1Nm5nRlk2?=
 =?utf-8?B?WGhmNUlZMFdJSkQ1bm4vcmY5UnF5dnZZMVA5SUxhdnFXUWxmcEVucHR4MnMr?=
 =?utf-8?B?dzJJMDh5WUR3NHQ1ZmR3aVdDL1BITzM5MlAzWEdCbWZTZmw3Uld2SkFBVzd6?=
 =?utf-8?B?S2lPU3c1REx0aXBSZndFN0pFeTBwUGpURVF5UjVrNlovK1N4Yit6SHNZVkhi?=
 =?utf-8?B?QTBjRW10Nm05ZG9vd3RCQ2F3eEhmTGVMNjBmcTZmOHpJUXp5dzdSRktLNS9U?=
 =?utf-8?B?b1E5eUx4VTcxSCtOVHFjNlphNDJ5d2lnV0I4VkpvWlowLzA0dFhGYy90S2Vj?=
 =?utf-8?B?anhoYWJML2o5TGNoSmQ4Q3JES0FvWDBacTFUU2pUNEVqSDFidXNYMS9HQlFQ?=
 =?utf-8?B?OEQ2Qi91ZEFtMmlNQWZ6bTR1N0djRTgyditvUUxQN08yd3V5RndoaHRvSlI2?=
 =?utf-8?B?RFliWE00aHFFYUMzbjlaMEREWHk3Nzg1dHFoUkllRXRFSnMwTUNzcTY2WHhn?=
 =?utf-8?B?VU5sZ1VzbmdUQ00vK1BzUUZERmR5Ym1qekhBcUZKNTNGQml2OHhyUzJSYXgr?=
 =?utf-8?B?U2t6Q3NzV1o1akNqOWs4MlNMMENCQ1hlcjcrL21kZ01vdFJXbnIwakdxRlJ5?=
 =?utf-8?B?U3MxVGZkS2cxRWc0NG9Ec3M4Q1BHeGdDVkRrNS9mM1ZUWWsvL0ZpUEhWWW5o?=
 =?utf-8?B?QzhpRXZRNVdLZGVOcVNCdnAyS1hPdHFaM3E4YkdHQWR1bG1idHNWejIrRENm?=
 =?utf-8?B?T2JVdGdQVnlZSnVFWXhnSnltVytjVzJLcXUwUk9CSFJybUJJVU52SnYvSlVC?=
 =?utf-8?B?NWwvcnFtOTQ2UDBmYThXeHkxNytZeWg5R2dWRXBTNkNLV0pqYStsamFOcVBy?=
 =?utf-8?B?NDU1eGUvMmZkNk1hc0ZMTVd5Q0JZNzViMkh2SkhkenZSVTBHYnpQS2ordlNS?=
 =?utf-8?B?VmNCZGVNMEgycjh5dE9reC9HZlhTcm8xL0QwbEdCb25GNVE2cFFyb1FGd3Rs?=
 =?utf-8?B?YmhnOU94YzBVQVFuT0p1dmZiQXd2Y2R2VzYwekp3WUJGSlJWZ0xVRDc5MHpu?=
 =?utf-8?B?V3o3eWMrbndNR3E1eldwTEROajIvS1FxU1FQYVNNUGhwMVpRZDczcmhubjJK?=
 =?utf-8?B?VERIUnkzdjRtMDhleFZIaExIZ2lJdkFrQkQ0QjRhWmpwbG42b1oxR0YxMWJx?=
 =?utf-8?B?Ymp5VGlOSDJRanQvUS9tTHJ5WjNPb2pQTm1jY1d0WGd6UGhqelFFa2p4UDk0?=
 =?utf-8?B?SFg4dk42Mit6aUpjdWhUUTc2L0EvRWFBZE8zamNJQ1RQVGV6VFY0aHdYUDA2?=
 =?utf-8?B?dEhXTVlUQkFhU2R5RVZGcWYweUZsQjY1SzhlcTlOMUlkdG5XMklwODBJZXdt?=
 =?utf-8?B?V1p2ZWxZQlIyMjZEbjRtL0dITFo2S04raUFUZENSRjhIU29OMWRUblpnbno4?=
 =?utf-8?B?dWhlRlY3ZzI3OUhOUkpDMWJWKy80emdlUHdTd1JBQlRYL1luVGtPYTJaenpx?=
 =?utf-8?B?Z2cvMXBuZDMzVUYwcllFaTlqb0ZEbHlkYzdNd2Q4dWY3SVg1dXJqODBabDdo?=
 =?utf-8?B?M1NoazEyTmxCNThob1RIcUt3eE41OUxZbDBxWjBQVkpEdDhodzNac1VaKzM2?=
 =?utf-8?B?T1dlUFdWU0VQUUpsRy92WFNFT0ZTN0IyTXhPZHlDOGZPaVRJeklndWNBNFo2?=
 =?utf-8?B?RlUycjF2YjZsN3hnNHVIMXk2cnI0WjZhQ2swb0tmY2dDL0g3ME1RK0FCczhq?=
 =?utf-8?B?SDZRUTdQa2VQKzVJR29qbzc3VUJjcGEvUEhrT013d3lDMEFQRERxeHQybEIw?=
 =?utf-8?B?ZnBNMG1vT0l2Ym4xUWdRVkFjTnF4MkpnUEJ1ZkxWVG9hVlpIdGhvR0dMcFFO?=
 =?utf-8?B?M25QMU92MCtuNkRsWmlCUnBkUDlBeXhTK2Q1WG5uRTZKeVpPVi9SNDVBL2lv?=
 =?utf-8?B?NkNLaWI5SHhwZkI0dDN3WGxqaXJ2ZjdlcjQzQmJvaWwyKzI1WW5acTUrV2tV?=
 =?utf-8?B?VXJNYmx0cEpBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 07:57:42.2737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba80714e-9511-4848-d5ff-08dd7997b400
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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

Add queue id support to the user queue wait IOCTL
drm_amdgpu_userq_wait structure.

This is required to retrieve the wait user queue and maintain
the fence driver references in it so that the user queue in
the same context releases their reference to the fence drivers
at some point before queue destruction.

Otherwise, we would gather those references until we
don't have any more space left and crash.

Libdrm MR: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/408
Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/34493

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 20 +++++++++++--------
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  1 -
 include/uapi/drm/amdgpu_drm.h                 |  6 ++++++
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a4953d668972..83bb2737c92e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -97,7 +97,6 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	spin_lock_init(&fence_drv->fence_list_lock);
 
 	fence_drv->adev = adev;
-	fence_drv->fence_drv_xa_ptr = &userq->fence_drv_xa;
 	fence_drv->context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv->timeline_name, current);
 
@@ -591,6 +590,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
 	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
 	struct drm_amdgpu_userq_wait *wait_info = data;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_usermode_queue *waitq;
 	struct drm_gem_object **gobj_write;
 	struct drm_gem_object **gobj_read;
 	struct dma_fence **fences = NULL;
@@ -840,6 +842,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			fences[num_fences++] = fence;
 		}
 
+		waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
+		if (!waitq)
+			goto free_fences;
+
 		for (i = 0, cnt = 0; i < num_fences; i++) {
 			struct amdgpu_userq_fence_driver *fence_drv;
 			struct amdgpu_userq_fence *userq_fence;
@@ -868,14 +874,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			 * Otherwise, we would gather those references until we don't
 			 * have any more space left and crash.
 			 */
-			if (fence_drv->fence_drv_xa_ptr) {
-				r = xa_alloc(fence_drv->fence_drv_xa_ptr, &index, fence_drv,
-					     xa_limit_32b, GFP_KERNEL);
-				if (r)
-					goto free_fences;
+			r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
+				     xa_limit_32b, GFP_KERNEL);
+			if (r)
+				goto free_fences;
 
-				amdgpu_userq_fence_driver_get(fence_drv);
-			}
+			amdgpu_userq_fence_driver_get(fence_drv);
 
 			/* Store drm syncobj's gpu va address and value */
 			fence_info[cnt].va = fence_drv->va;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index f0a91cc02880..d5090a6bcdde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -55,7 +55,6 @@ struct amdgpu_userq_fence_driver {
 	spinlock_t fence_list_lock;
 	struct list_head fences;
 	struct amdgpu_device *adev;
-	struct xarray *fence_drv_xa_ptr;
 	char timeline_name[TASK_COMM_LEN];
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index ecd49cf15b2a..7c754ba56cff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -73,7 +73,6 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	}
 
 	uq_funcs->mqd_destroy(uq_mgr, queue);
-	queue->fence_drv->fence_drv_xa_ptr = NULL;
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
 	kfree(queue);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ef97c0d78b8a..e061762185d8 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -501,6 +501,12 @@ struct drm_amdgpu_userq_fence_info {
 };
 
 struct drm_amdgpu_userq_wait {
+	/**
+	 * @waitq_id: Queue handle used by the userq wait IOCTL to retrieve the
+	 * wait queue.
+	 */
+	__u32	waitq_id;
+	__u32	pad;
 	/**
 	 * @syncobj_handles: The list of syncobj handles submitted by the user queue
 	 * job to get the va/value pairs.
-- 
2.34.1

