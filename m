Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE177CAC5A9
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 08:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45DF510E66B;
	Thu, 18 Sep 2025 08:18:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EcdaBcM+";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013031.outbound.protection.outlook.com
 [40.107.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CFE310E66B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 08:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrESKDDSfD5tbIo7TKuAmSh5jXf5Jd0AQuNWyU+aqwjL2NIWNwWiKkQ//OUhE+86sQvXvBLfjEBIBC9/vgQWHSlecMLSbigixdLeq6mHEcvUj34X7ib1/T1j9yipizUVUnDXHONA/2WkrL2uamhYxY3ntf/loCA3x09/FWmHe/D6R21v6TjOw7miP+zODpMJ0C69btupMrCsHpxOklMlncgq+rLuUa3rdTCRUaCsjwROsTBjrMXtE+nDh7OankZjvH72UoIuTJK8bUfSy2kBaq2Bcjwb8ggH+ePyvKEUOnXCf14W4a+j5vlNtZ1mYkZ3UsI9rX/D122ERf0vtkdyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+f8VRlUiZv5nqcGVP+rkF1QoRPyTvNRsC4aCy8VOhg=;
 b=X/U8RfTaEZNNL98QC2sIu5b1Z8jVzq+QqRT6l0xNFlUy08HUfAC0jXcddyqpvcwEJjbPKZ/7zZuetl7p23SwoVEcHgqB4J+avmpe82vB2fKbv5ly8pQRlGNulz8tWxsIid7m7Rlorl/j11PKhR8sNGZ6x/OehdcdBpvS9IYe4aSHoVvoEmrKbQWnpbILnFGrTLWyFg/Lly3u0MhxRpwlmY+rMkzujK6ZzP5UrsrQPuws++nbvSwLXCTVtPm04CJEeUIZs0Gfp+ApWkh0Fk/YjMICBB4D68N1qSYUk91EPp3qXv6dgQw/1BtU8fjsCwXrAR/xIHkZZUC9MI2P/7gkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+f8VRlUiZv5nqcGVP+rkF1QoRPyTvNRsC4aCy8VOhg=;
 b=EcdaBcM+9IGJCmvJcHp4U0YZCaXYU9QhT0XCCj03T+UqAwrqS9KbFgr3TcvGfW+JBb/XTJEFDzrTFAaz+ptibar+gsJtcxSIbKqdIfRoCv9ICfsTnlVhH87drrTqnuf5W/+FI22UA9NuYKe7CgN/TP5KGeN5eDTvFloVMvtIp/s=
Received: from MW4PR03CA0263.namprd03.prod.outlook.com (2603:10b6:303:b4::28)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 08:18:49 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::73) by MW4PR03CA0263.outlook.office365.com
 (2603:10b6:303:b4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 08:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 08:18:48 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 01:18:33 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 06/10] drm/amdgpu: add userq object va track helpers
Date: Thu, 18 Sep 2025 16:18:11 +0800
Message-ID: <20250918081815.2755437-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918081815.2755437-1-Prike.Liang@amd.com>
References: <20250918081815.2755437-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: b67def56-d7a9-4e8d-e9e9-08ddf68bfe7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ts/qdiZ10JBcwk40ECj4dFSwsxBFMyAT8+ygEPoqZA7IAF6eJ39PYTcA0bEr?=
 =?us-ascii?Q?LckOIkVWgzD+Fa1dysV8vnUVf3WYUwi/RoAMjVfBRY6mTwOE4RlWtKdS2YCz?=
 =?us-ascii?Q?ElvXUT0kYyOAtNFE5FKiwuGpcfXpZPafQ8Wtk0kCzcgMDLff7Kyc6Mf2Drh3?=
 =?us-ascii?Q?TZfhizv09vfXYdGP0TMM6MzYSD6RgQtsIDjPV6sijluL6MM09KEDZOBgfb8u?=
 =?us-ascii?Q?3EeEg1vleZsfqmyFQ1ZDtQBau7VzyMaFYPiffnQtlDhyQvt/B6aElcXZLTaE?=
 =?us-ascii?Q?jUDsc3EJutP6qJpfskncaBAej3MuhbRQP9JKQYaEBZBl6ihs8HD7w4eJrgPm?=
 =?us-ascii?Q?pNKhJ6A/hkh9/5+siB6Thw1UAKrh4A2w8FGpQZzaWw3x5aUGPger7jqPjX1a?=
 =?us-ascii?Q?Im+HXor+uu1mnE4ckw3DzoUte1hgZX5Ovjf7AwM6B2yGYktLa5gW/VAOogb/?=
 =?us-ascii?Q?aHbzVGozVeE6Ud6ikWEjSFc9WkxQtZZt/COpbmbiVBczgwvQMixQEJh0M3i6?=
 =?us-ascii?Q?RvIGpYgPkglh58UeA4xw+eMX2SmDLCaI0iuEMVt3KHcB0pMNTGZgZpftD218?=
 =?us-ascii?Q?1qsCQELaRrvZmS94EuUuWKOq4nIuAlFG5qafFCnt67VGtIRYQ7xL4KgYwSHV?=
 =?us-ascii?Q?6HCfmbnqkZT/UTpbUn9xMpvcELpbLpIBzYEUBtDh+d2RdaIC3yef3jIfsccX?=
 =?us-ascii?Q?1jpsrOIM6TC0CLzmtgMpWiLeyttp9MdZj1ihygGarKBvfqD9evCiiTE3pS2I?=
 =?us-ascii?Q?z4w/H9vPvAgIf6UFoQ1xrHGJgU4K9kvEyKhNGpmrU/1nHapyTQywa4k1UATY?=
 =?us-ascii?Q?G1ilZcnpuAgzAGxZEqqjR+Y+UUTfafFM3IW5J40pQZFfJzcT6zTazxwHrLPv?=
 =?us-ascii?Q?nNy+UngneWw5TiFdWdksTLMXoHOb0Ox5895qWcNk3nMVJ30UuKqdbsM3rpP2?=
 =?us-ascii?Q?x0vaPP8bRsO2icA0l8lWJ8FsZckryurqafStpSgUNwL/ncgQ6cvuQC9BvM3q?=
 =?us-ascii?Q?6gECdCe97p4Dn2DtM3AZvWiddDO1SBg039DVLDCoY8Q5VX0yd7IHGxT29SRG?=
 =?us-ascii?Q?0qoYZPb28Y1lCCeyOgCrI2/iUK0i0D98xpXkp5d23gdTqaceXAxx/h2Sp0jE?=
 =?us-ascii?Q?Avv+Jh0OpUaJowbkhhptCdzBFC34+1qzbhofpb8+MEk7PPg5LjOomRSsYgFQ?=
 =?us-ascii?Q?IlffgQrpVOSWli1yb/2IvDIs2zSP/bPSSkeRyqsZcjF9j3Jrhyty9kKdvSHh?=
 =?us-ascii?Q?zIQ8SNDKZJKln1TmVnovhTYcqxqth9KfcPy+oV9AH73twGW4hHu21vmbdDVr?=
 =?us-ascii?Q?0/CHzd/XmRnQqI2WT3dmfQf6jwNFcHMY6cSAWI3FPiTwDsOeuUJt1K/5TOy4?=
 =?us-ascii?Q?ncpXtCyibnPY72jxivR7eUBujElZC5RaR9L99pLwkxlGqcST93y3IFXbyLaE?=
 =?us-ascii?Q?0wGZSKxqDCvQcPelaSSIE9FZoZtgeF5SwtckXHNgD+m5mZED9mumoCbthXfs?=
 =?us-ascii?Q?OAk8KeuLMJFZUOOSfNMX2fQQ56yk+co+2Cey?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:18:48.5491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b67def56-d7a9-4e8d-e9e9-08ddf68bfe7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408
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

Add the userq object virtual address get(),mapped() and put()
helpers for tracking the userq obj va address usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 73 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  | 15 ++++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 ++--
 4 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 656b8a931dae..52c2d1731aab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -96,6 +96,7 @@ struct amdgpu_bo_va {
 	 * if non-zero, cannot unmap from GPU because user queues may still access it
 	 */
 	unsigned int			queue_refcount;
+	atomic_t			userq_va_mapped;
 };
 
 struct amdgpu_bo {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3b57352e523a..71cac54791c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -44,7 +44,8 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
-int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
+				   struct amdgpu_vm *vm, u64 addr,
 				   u64 expected_size)
 {
 	struct amdgpu_bo_va_mapping *va_map;
@@ -67,6 +68,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 	/* Only validate the userq whether resident in the VM mapping range */
 	if (user_addr >= va_map->start  &&
 	    va_map->last - user_addr + 1 >= size) {
+		amdgpu_userq_buffer_va_list_add(queue, va_map, user_addr);
 		amdgpu_bo_unreserve(vm->root.bo);
 		return 0;
 	}
@@ -76,6 +78,66 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 	return r;
 }
 
+int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
+			       struct amdgpu_bo_va_mapping *va_map, u64 addr)
+{
+	struct amdgpu_userq_va_cursor *va_cursor;
+	struct userq_va_list;
+
+	va_cursor = kzalloc(sizeof(*va_cursor), GFP_KERNEL);
+	if (!va_cursor)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&va_cursor->list);
+	va_cursor->gpu_addr = addr;
+	atomic_set(&va_map->bo_va->userq_va_mapped, 1);
+	list_add(&va_cursor->list, &queue->userq_va_list);
+
+	return 0;
+
+}
+
+bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	bool r;
+
+	if (amdgpu_bo_reserve(vm->root.bo, false))
+		return false;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
+	if (!IS_ERR_OR_NULL(mapping) && atomic_read(&mapping->bo_va->userq_va_mapped))
+		r = true;
+	else
+		r = false;
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
+}
+
+int amdgpu_userq_buffer_va_list_del(struct amdgpu_vm *vm,
+				    u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	int r;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
+	if (!mapping)
+		goto out_err;
+
+	atomic_set(&mapping->bo_va->userq_va_mapped, 0);
+	amdgpu_bo_unreserve(vm->root.bo);
+	return 0;
+
+out_err:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return -EINVAL;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -141,6 +203,7 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
+	list_del(&queue->userq_va_list);
 	kfree(queue);
 }
 
@@ -461,10 +524,11 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	INIT_LIST_HEAD(&queue->userq_va_list);
 	/* Validate the userq virtual address.*/
-	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args->in.queue_size) ||
-	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
-	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
+	if (amdgpu_userq_input_va_validate(queue, &fpriv->vm, args->in.queue_va, args->in.queue_size) ||
+	    amdgpu_userq_input_va_validate(queue, &fpriv->vm, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE ) ||
+	    amdgpu_userq_input_va_validate(queue, &fpriv->vm, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
 		kfree(queue);
 		goto unlock;
 	}
@@ -504,7 +568,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 33a582200dda..e03bfa38c9ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -48,6 +48,11 @@ struct amdgpu_userq_obj {
 	struct amdgpu_bo *obj;
 };
 
+struct amdgpu_userq_va_cursor {
+	 uint64_t		gpu_addr;
+	struct list_head	list;
+};
+
 struct amdgpu_usermode_queue {
 	int			queue_type;
 	enum amdgpu_userq_state state;
@@ -68,6 +73,8 @@ struct amdgpu_usermode_queue {
 	int			priority;
 	struct dentry		*debugfs_queue;
 	uint64_t		generation;
+
+	struct list_head	userq_va_list;
 };
 
 struct amdgpu_userq_funcs {
@@ -138,7 +145,11 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx);
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
-
-int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
+				   struct amdgpu_vm *vm, u64 addr,
 				   u64 expected_size);
+int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
+			       struct amdgpu_bo_va_mapping *va_map, u64 addr);
+bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
+int amdgpu_userq_buffer_va_list_del(struct amdgpu_vm *vm, u64 addr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 3a4fd6de08ce..e10e4b6a10d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -298,8 +298,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
-		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
-		    max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)))
+		if (amdgpu_userq_input_va_validate(queue, queue->vm, compute_mqd->eop_va,
+					max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)))
 			goto free_mqd;
 
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
@@ -330,8 +330,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
 
-		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
-		    shadow_info.shadow_size))
+		if (amdgpu_userq_input_va_validate(queue, queue->vm, mqd_gfx_v11->shadow_va,
+					shadow_info.shadow_size))
 			goto free_mqd;
 
 		kfree(mqd_gfx_v11);
@@ -350,9 +350,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			r = -ENOMEM;
 			goto free_mqd;
 		}
-
-		if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
-		    shadow_info.csa_size))
+		if (amdgpu_userq_input_va_validate(queue, queue->vm, mqd_sdma_v11->csa_va,
+					shadow_info.csa_size))
 			goto free_mqd;
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
-- 
2.34.1

