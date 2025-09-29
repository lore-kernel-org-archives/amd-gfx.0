Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136F4CAC5BD
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Sep 2025 08:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5461410E159;
	Mon, 29 Sep 2025 08:10:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GPHUK2Tz";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010054.outbound.protection.outlook.com
 [40.93.198.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1E910E134
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Sep 2025 08:10:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJ1KpSimJcdlZT7dQRC44qeJ4OVh60DAvjsuNGLALIa8OotTcK8DJBi2qvl3mvSmLrhf3UUFsuDck1L0vpdHTuAbRN1Elab8AQaq0MfwkHihp6V0Gl/jaKULVaE/KN2bOMqBUilCl4IxAB7oYJy8fn04nQPY6fXQ2jHRZ+InrFHiNL/3GkEW/UiggMe2lGYImALgq9RSUjt8n+m5ECeJC1oJNsBNQTp+mDhGFsfgvEjUYmZCZWYjW9D+X85Yuo+oill0UTbUZyclIME2ye+nnHHFghwcAGafB0ACyY3L4Ukb5p/2a0e8CRsmiDAU12O/zfawIKo9Jecg+9MS3buZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9NoS2gmqe05vLtd5NaNrB7aoNB30o/MRNFIlKk6n3Q=;
 b=nzwAo250A+gQXkTXWyT9+TDLwZhNl2Dvd1FfbwcRc7WjZvfpXax/B46367989rlfKV3hzXHXMjSix2ZaneRbP6+nnwxtvfcMEQzsgoerrkayPJ0Wfv2OM4SQ7cosKg4FAypd64gW07M3WvNtFuHc5PAhKd5T4a1yo3tpfO2ZHBbdBokbzUbnI+Thxc1jm6ibJbkueodlFA8/QQ1gJmiWNBMUJMGjVZX1KcXl+FEUiRjPV281eUwYCHSpiHhp+ux7cRrJ/3A4SAsPO/NZIVKX+LS/Ml3NpNLrCeSBRxv9RvEURWQgh08NR/Dh4ZO1KRrmtU7iKe8KYzjDle9LJUqe8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9NoS2gmqe05vLtd5NaNrB7aoNB30o/MRNFIlKk6n3Q=;
 b=GPHUK2Tzng0iIDVGFjSbof+o1pLQ6B690cx6hU3Doz0mOS3j3mT73Vp2EDAUUFS5s7rAVniYzp6lpylVfnhFhmkVc6bPgjvwV5Emotoa2KuUUla4povLylrtm3W40cGGJka5KH0ntW1iMRfTOE/ltE4oQog+itWbzsbsED/jztg=
Received: from SJ0PR03CA0170.namprd03.prod.outlook.com (2603:10b6:a03:338::25)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Mon, 29 Sep
 2025 08:10:00 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::8e) by SJ0PR03CA0170.outlook.office365.com
 (2603:10b6:a03:338::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 08:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 08:09:59 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 01:09:57 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v5 2/8] drm/amdgpu: add userq object va track helpers
Date: Mon, 29 Sep 2025 16:09:38 +0800
Message-ID: <20250929080944.2892809-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929080944.2892809-1-Prike.Liang@amd.com>
References: <20250929080944.2892809-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 289e6ba1-9b0a-477e-db96-08ddff2f95ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zL3R5D1yI8EqhPvtvg1KmAH2DKNWKjWsjIJzNFSnn7ddTZDOxA75q1yQQ311?=
 =?us-ascii?Q?wtB7TnhrxNdu8KfpiA/L09ZflDRVp4UX6PWXDwDiUhmgx7Lw/GWtlpT6qm29?=
 =?us-ascii?Q?JLlogTLRfNnwhM9dX/V74VZGUCO5Wg91ptpp1c0u5zl9q5nblS+W4aeA7XFr?=
 =?us-ascii?Q?a8S9IPkSSfuWnUWq/FYFAAxtcOL7TnNnGkLVguIVNMxdo4zE8Wc9OBSvK44/?=
 =?us-ascii?Q?WuamkkF0x+Yw8qKRTvuB/DkWD0Gxd3YEtkuZ0O6er3SKUkiT/By3hfSPAHfD?=
 =?us-ascii?Q?XSZOKMjkWJ4bzvS1zN5FWr2Uhfu4GLqk1IswZxwxZSWWreaJ1evBT9i6bkoA?=
 =?us-ascii?Q?SgeRIYGt4PCz/PmPTYsTtQP7fPKkOUD/X6f89EDwG4+IY0aKswEWfdRPU0Fa?=
 =?us-ascii?Q?cIVnlFnOr8x3ChIpf8XcWggKYDp1xcWyGli8guSVIkJspNuA5wf8x6KrODVD?=
 =?us-ascii?Q?bFsc3wGH0ZuBXxD/QaOyCrogDoyg/YGehj+tpq6NZfYwbSaSbyNslCMjGIZh?=
 =?us-ascii?Q?LFFBkCzVVlhcATqRCDEniXeLn78KJLUY4xyxrrZtRcpfee1e5GMOrkMGFnh5?=
 =?us-ascii?Q?6vG6NCqluSt9Ifep+yw05jnRUW7lhozN3bydxPsf55+P3ydNK26RQMhMAiMT?=
 =?us-ascii?Q?wNCdSlB8tgDCaGoFAhIL7YUHNwXU9m+nmPAdQzhk8p0O6IDZPBGt2J/cCBKH?=
 =?us-ascii?Q?pcjo7zt8giu3rRcaYyvzmHc9N1mlExbEpb3yT+iPRB5qxla1X5t+1t+iOsAC?=
 =?us-ascii?Q?tdPyHEwk2iAuZecyVs1rGgkbLSghFJOCwBlrwCrx8yWa/oCj3+JnIPh+5QFh?=
 =?us-ascii?Q?jqz8Vcs8q150y0+XZ7iwiD4TB6JQHhW9j+mLcLpXbeG+9CU2FxbjkUYbTQFH?=
 =?us-ascii?Q?aFfSLoG/kltvFm6B+7ccQFqXfxwfONEJopBgXRlZ4TpXqlw0++90Yie6IvBp?=
 =?us-ascii?Q?9DgMRTCiX7LyEbWMXMercj0CGiCCnURD87LGH0XE097Xb1ywsJI5unRUn2qm?=
 =?us-ascii?Q?R7v3DkRUb/BGuDZ3c4ekKbzgRNaR2iw2grTtkEgIOe6GgFJBs80onk02V+5+?=
 =?us-ascii?Q?PE/qBsfGfLFEFLKRhdSb6+5+YDN9jvRn9Xga2gLuZ1rxNxQg6GUJTdTtWZeC?=
 =?us-ascii?Q?edHjwVhJLZ10loTJ6Xaf+EVu6fvfa2WAR9z7S48to8nWKROozhPXNhZl6OyE?=
 =?us-ascii?Q?edXKgOCaxlMxrPlSUkhUmMi2IBAsqPN8gob33wFqUxnSHTgj0NKNk1jSkkfw?=
 =?us-ascii?Q?HiF3R7NKme5yCSfn07/8RQqrIp06FrWutKONyErcXK88bk7wC03xvmw+54Rw?=
 =?us-ascii?Q?K+t5CN9/VlnnYudHinvrW6nhLlLTwotU3ecm7MoKxvnYvxGGAcOC+DR6hiKj?=
 =?us-ascii?Q?VXh0IVM8wM0sVfip/53l1wkDJsH8CjFa+jAVO6r+jC2AcPLbdOdGiZDZlFg5?=
 =?us-ascii?Q?EwplDDSJFN6VqMQCmxPs8Jdwjp6W1Xn031OdR3rcIVMLGbmja7la/1P7fZYf?=
 =?us-ascii?Q?H7h7H9tRR2kGG1X3m4rcpyyLYsnl2NXBV9FfsbCVqmqqY9uSG+dYROEfWMD3?=
 =?us-ascii?Q?dj8/HsbwJUwu6qgUYQA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 08:09:59.4888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 289e6ba1-9b0a-477e-db96-08ddff2f95ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
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

Add the userq object virtual address list_add(),mapped()
and list_del() helpers for tracking the userq obj va address
usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 71 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  | 12 +++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 ++--
 4 files changed, 76 insertions(+), 21 deletions(-)

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
index 3bbe1001fda1..a9ac2efcd37b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -44,10 +44,30 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
-int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
-				   u64 expected_size)
+static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
+					   struct amdgpu_bo_va_mapping *va_map, u64 addr)
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
+int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
+				   u64 addr, u64 expected_size)
 {
 	struct amdgpu_bo_va_mapping *va_map;
+	struct amdgpu_vm *vm = queue->vm;
 	u64 user_addr;
 	u64 size;
 	int r = 0;
@@ -67,6 +87,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 	/* Only validate the userq whether resident in the VM mapping range */
 	if (user_addr >= va_map->start  &&
 	    va_map->last - user_addr + 1 >= size) {
+		amdgpu_userq_buffer_va_list_add(queue, va_map, user_addr);
 		amdgpu_bo_unreserve(vm->root.bo);
 		return 0;
 	}
@@ -77,6 +98,32 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 	return r;
 }
 
+static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
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
+static void amdgpu_userq_buffer_va_list_del(struct amdgpu_bo_va_mapping *mapping,
+					   struct amdgpu_userq_va_cursor *va_cursor)
+{
+	atomic_set(&mapping->bo_va->userq_va_mapped, 0);
+	list_del(&va_cursor->list);
+	kfree(va_cursor);
+}
+
 static int
 amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -185,6 +232,7 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
+	list_del(&queue->userq_va_list);
 	kfree(queue);
 }
 
@@ -505,14 +553,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-	/* Validate the userq virtual address.*/
-	if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args->in.queue_size) ||
-	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
-	    amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
-		r = -EINVAL;
-		kfree(queue);
-		goto unlock;
-	}
+	INIT_LIST_HEAD(&queue->userq_va_list);
 	queue->doorbell_handle = args->in.doorbell_handle;
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
@@ -523,6 +564,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	db_info.db_obj = &queue->db_obj;
 	db_info.doorbell_offset = args->in.doorbell_offset;
 
+	/* Validate the userq virtual address.*/
+	if (amdgpu_userq_input_va_validate(queue, args->in.queue_va, args->in.queue_size) ||
+	    amdgpu_userq_input_va_validate(queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
+	    amdgpu_userq_input_va_validate(queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
+		r = -EINVAL;
+		kfree(queue);
+		goto unlock;
+	}
+
 	/* Convert relative doorbell offset into absolute doorbell index */
 	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
 	if (index == (uint64_t)-EINVAL) {
@@ -548,7 +598,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ded33fe76e1c..f19416feb7ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -48,6 +48,11 @@ struct amdgpu_userq_obj {
 	struct amdgpu_bo *obj;
 };
 
+struct amdgpu_userq_va_cursor {
+	uint64_t		gpu_addr;
+	struct list_head	list;
+};
+
 struct amdgpu_usermode_queue {
 	int			queue_type;
 	enum amdgpu_userq_state state;
@@ -67,6 +72,8 @@ struct amdgpu_usermode_queue {
 	u32			xcp_id;
 	int			priority;
 	struct dentry		*debugfs_queue;
+
+	struct list_head	userq_va_list;
 };
 
 struct amdgpu_userq_funcs {
@@ -137,7 +144,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx);
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
-
-int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
-				   u64 expected_size);
+int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
+				   u64 addr, u64 expected_size);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 2db9b2c63693..9c73a7238fd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -298,8 +298,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
-		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
-		    max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)))
+		if (r = amdgpu_userq_input_va_validate(queue, compute_mqd->eop_va,
+					max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)))
 			goto free_mqd;
 
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
@@ -330,8 +330,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
 
-		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
-		    shadow_info.shadow_size))
+		if (r = amdgpu_userq_input_va_validate(queue, mqd_gfx_v11->shadow_va,
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
+		if (r = amdgpu_userq_input_va_validate(queue, mqd_sdma_v11->csa_va,
+					shadow_info.csa_size))
 			goto free_mqd;
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
-- 
2.34.1

