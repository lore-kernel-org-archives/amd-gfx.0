Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF00FC369A1
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Apr 2025 08:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DCC110E19D;
	Sat, 12 Apr 2025 08:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oSSk47Kk";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A8610E1C3
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Apr 2025 08:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHUsJrA2DAUicnoOWIQAZf6XETUxc/cZvuySAb+KwUICr7S8uFVK9HwEDKLQWXfmKZpTWPsl+Z75ywYfsW5i5KRSuGqbN22i/Iw2lMqbmY7T6Xpi/xJkaPjGischwTqlQoVZuT0ffKqcT7AgvtOCrTwEKmbqBBb+uszzRDZDExq0TjUSoiQHY8FfVu2SeJCuSeYM9ujK26G/x7gYuBX4trdOa9utb70jVimP1tZDIVFB0XtLLZ4wuGifqcKzSMR3p5ySFKP8Mglj37p1nPxI2ULgqoTcbaa3l5nUyBqHhN/AlWu9paUu49jFBoBMLku0OlDrHXN66DBmnfdAw0FSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChCGtXtBppPk1h+iB86VBZGEsUshBPIr4Ug6xJfiIXM=;
 b=wyRwWRndQOkkFetO5ycqfDshoi8j2HruOfcVSU6PguepNP8AG/fTQIwLDqBkTR9X/6Zxz5wOrTOgCrM1AGJtnoohMkpKFwd4ckyDphPSx0ElGoA0SqFOTbitia1HJLgfDIeOQMMaiuPou2dMjdOXcxOs5KIifn/I6Vz5BN8LJHtrHjynZgTEvW/iGXU6iVo5Jv2EX5bJl414Id30GrRv1iAqdVxZBwJfmnWMuiHi/A4Urbzx+poZV8ffxtRSMYiAaYd71EZrpjRd0TvYFreiEkWr8sOyK9XFYfF/4FW80CEXp6ZwWqZklFH+VUrH4CvOgDuuxrKCCEeN7weqA/fgqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChCGtXtBppPk1h+iB86VBZGEsUshBPIr4Ug6xJfiIXM=;
 b=oSSk47KkVg8PIa+8eiPQPs3ijcjt1OjktEyM7Nbw3/pXXFgdMYtyK9e1AuG8kSVImZFyMliJj/2zCEXmgxIW4l+7a8PTmzH7ubd3etKUnktBrk5uY+maWxjL4ugf2IcOjcjE0nSAZJ0m4gR0SWxZzHcpbujPVb3bZSN3w56QQKU=
Received: from MN2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:208:239::30)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Sat, 12 Apr
 2025 08:03:41 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::3) by MN2PR08CA0025.outlook.office365.com
 (2603:10b6:208:239::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.30 via Frontend Transport; Sat,
 12 Apr 2025 08:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Sat, 12 Apr 2025 08:03:41 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 12 Apr
 2025 03:03:39 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, <marek.olsak@amd.com>, "Arunpravin Paneer
 Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2] drm/amdgpu: Add queue id support to the user queue wait
 IOCTL
Date: Sat, 12 Apr 2025 13:33:27 +0530
Message-ID: <20250412080327.2687-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe2db38-5080-4b6f-f08e-08dd79988a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHJhaXBYc1hOWDFXb1dwc2hSRGhXZVZISzJWbllqMENLRGlNaER0bEZhcmR3?=
 =?utf-8?B?clh4cmVkLzMxMGc2dFR4bFhGOGszRTJpTXVVR3VaVVk4VWpZa0dYVml2OElT?=
 =?utf-8?B?NFNSQUszR2htYVdEZ1JCYTdmVkxBR1puVGV2YlJPUDdCaC9SUkR6dmpaNHBh?=
 =?utf-8?B?VGZlem9DaElaRXBndnZGMS9uMGtOVXpFWlJEcmd0cWxuZ2hva1VtcGxNaXFE?=
 =?utf-8?B?bU8rY2NrT2RWU05Xc2ZGUCs1cHJIZG40aU1kNk5ybjFKaitPSHh1S2lZeXE4?=
 =?utf-8?B?N2ZNMUgwcGh6QTZwQ1NZQjdqZEtueGNZaVhCOGVhTEJkdVZLaU55WUVEZ1ky?=
 =?utf-8?B?QlltbUh6WDN5ZENPN3JkZ2xjRzRyZUJuWTVaQ280NXRYN3J3QWtkZURJMTJi?=
 =?utf-8?B?OFRjRzNPVUV6ZUlFNHVwZkhPQ29Ob2V1OVRFQTBFKzg0WWI3aUtHemhmYUU5?=
 =?utf-8?B?cUN0QWNGcWF6Qzc0QWZ1VERjY1Q0ZmxrOC9hWjhIQTFGWjY2eWdKVU5sbnFp?=
 =?utf-8?B?UENPOGZYeXQwK2hDTEFsZXNGSnJnajRNM0I3V2RCb0ZreWpHYTlQSFJXTXRJ?=
 =?utf-8?B?RC91N2p4TnNicDMzVHBPTXd4TUpuNDY4czNmdUliY3pzek5SaHZvM1pUbkcr?=
 =?utf-8?B?eDM2a2hkWG9mWjhKdk40ZW1pQjFGaDJ1Q3ZvVDh6bVoxa1hmUnFwQmR0SjBQ?=
 =?utf-8?B?eW5EMFVJUkZoWGh0dmttNlJSUHpvVXRxQnhTQUhDQXVQUWpTREt3Vi91WVF5?=
 =?utf-8?B?UWxuYkkxVXFWcWFhVEhnSTR3SGJQNTJPR1hjVHBxaHJXcktmUnJFRS9tblVr?=
 =?utf-8?B?ejdkVUlOMW9HQmhWUW5NSWRUS25yV0hwdmtBdElYZTZ1VEtES0x2bEhXWXAr?=
 =?utf-8?B?S081YmgweER6aU9pRzMya05UQ0hoUHlKYzVOc1VydEpOMmVycGVSd3dmS1dP?=
 =?utf-8?B?VEF3azFZa3VGUUVOWTZPMHpsV2NzU3VvcFZnaG56QkVEdEVLUGJWT1VwN3d1?=
 =?utf-8?B?KzNwakJxN1lLMW42M0M0Mng5N0VZUHFkVUZmN3BIaERUQnBmVnZMbDlNRDMv?=
 =?utf-8?B?bFc4Q0txaHEvTUNKUDN3NU15NE5WN3U0WU04Yk1Kd0htQzhiU2o1VzVaYk5w?=
 =?utf-8?B?MkEwUVczejBybERTSHBNQmVvTTlhcHVIbmJiTEdtSkpmZmt2dldLeEYrUTJ5?=
 =?utf-8?B?R3RGQURLRU9zZWd5TjdTNG03ZW9jRzU1ZUJZUFExaDZyL09WMW9iaGxGYTFu?=
 =?utf-8?B?T0hYZy9MMjV0NERzUHZiYmhtZFJ1cGFLNjlqdll1WlVvbjNBQmtxMFFILzRK?=
 =?utf-8?B?YzR5K25GYS9HZm00V3dXNEdxbGdOQjlJciswNFpJVUtRV0xVdllJR2dKM1pF?=
 =?utf-8?B?TE9kRVhTaDJmaS9KbERnZXZSNjNIbUNhREd5NkVRK1cyVE10Y29zTVVCRkZQ?=
 =?utf-8?B?NngvRjJYT0IrSUpaUUhEQVUwd3g0Ti96VE40UHFIa2o1NWtrWXBXZFV1YlpW?=
 =?utf-8?B?S1BXYTdmazdFVHhIdmE4UURjVTNkLytxOEV3Y3ZoblZubGlSc0ZUZXUxTFk5?=
 =?utf-8?B?VmxQWmxleE91ekZQTnkzekFDWTAxR3QxYnpEdVRSNUxSOE9qRTd0T1RCV25Q?=
 =?utf-8?B?ai9IU1ZyWGRPb3Y4Um5sSHhzMHA4MmFlMWp3WTlidnNtakFhd2JNWmJjelpI?=
 =?utf-8?B?KzE3NzkwZXRHT3FMQXA4enVUdUFmYjJMeVZNS3VLVnhPbE1IVzNyak11VTEz?=
 =?utf-8?B?ZWttWmh5ME5qQk80QkE1NTNhZjc0YUZGM0JxWEFMbW4xa1JtSUluOUJSVlF6?=
 =?utf-8?B?N2hTYjZPaTE0RGdNZU5DZHV5dnFTTDFxZXhxWEJkeXVkNFpKekdWVWJxT3Bm?=
 =?utf-8?B?b2xEZXBDWXlJMnlKRlU1S2oxMXFXdUpUUlVwN2M2WVhKYzB5RVBzM1ZHbnpp?=
 =?utf-8?B?TU1rTGZUN2Q5SFBaTndlZ2NNbjRidDlQSW5RNnlhS3NjRUpyLytJQlhxcGo0?=
 =?utf-8?B?VnZPZnB5anJBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 08:03:41.5593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe2db38-5080-4b6f-f08e-08dd79988a22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
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

v2: Modify the UAPI comment as per the mesa and libdrm UAPI comment.

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
index ef97c0d78b8a..2195810ae42d 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -501,6 +501,12 @@ struct drm_amdgpu_userq_fence_info {
 };
 
 struct drm_amdgpu_userq_wait {
+	/**
+	 * @waitq_id: Queue handle used by the userq wait IOCTL to retrieve the
+	 * wait queue and maintain the fence driver references in it.
+	 */
+	__u32	waitq_id;
+	__u32	pad;
 	/**
 	 * @syncobj_handles: The list of syncobj handles submitted by the user queue
 	 * job to get the va/value pairs.
-- 
2.34.1

