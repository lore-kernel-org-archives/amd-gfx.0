Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8139CCA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 11:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F70F10E8F2;
	Wed, 10 Sep 2025 11:37:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2CENLSE9";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 623B810E8F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 11:37:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6uPk6lC9CR91U8XQd+zDZkbel6IQCg/vN9mZhuY7yVDnpsKUwwGXNHLtCHU2N0GvtP8BuLO3S1ItDPsl6ejl+EC5cVY54JTIUbVIX2piLmcJnB5VyP5bU0Wi+z/eyJxGTIZ1GkppQuAVNQM47xkkJqg34fpsOST6sxZ/izDW/QqqWCqRMGUG8MWzQqa0PpwYu2ZU1U80vNLM4KQJQnknOmmmSg3YVMtyc+sW6ZWSmN/GCQZ4sEsTsI4EG8RFRgI/JQXJZg7j0CXTgZnH7WlffnAoQucAuWq0NMhFmtq61OeyWySgiu2fuhMAsdz2xTNi+pTvg+BQCQGntPPTtvVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD9xwjrUgBHZfXT1S5W+9K3ShITPRlbyJJ22l0c3SoA=;
 b=sHDHV+iMuCNFrWDQpvEBSjhRsPAOhEztm7o1JvASFsVZ3mraLWTm67eoOd6EXAKTRDjd9frFgAOz+jJM7UoCI4UHTEXzVLS7X+lVCwKLgJPtRBuYkaTa0k5nfnTNO89iwczVDYbqGvJOXNynIZ6xTp+fMtTxk2wXCu5iwulD9FED5/TJDGQW9t+WkAeFLUpP9RNarY1S6YRTUuN+A0DR3D06RZsjlta8rkHNUphjW9XF5pIwz6CyRH1HQJEMvPkztHzfGmeMllBJ33+v1LfkpCW/958ziRtyuPtXxMY2BKiNKYMe273Iim3d5xecm+UzbutF1YKtIAAHYHpXgNaXCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD9xwjrUgBHZfXT1S5W+9K3ShITPRlbyJJ22l0c3SoA=;
 b=2CENLSE9sgJ34l1eTwkivPDuP6I8X29JBE4fWkCRtDxsLgr5AkbBcpOLZNwF3fRL+ERNSWesTzO1q/zNAEP1Lyiel27tP/m61lQk3eTndoahLhWQ6N1lWToZhxHAfKW0FULqdbsQlJJgWqqKZS5G5JHjngyegFYyFKS9D+7mhXI=
Received: from CH0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:610:b3::11)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:37:51 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::51) by CH0PR03CA0036.outlook.office365.com
 (2603:10b6:610:b3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 11:37:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 11:37:51 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:37:49 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/9] drm/amdgpu: track the userq bo va for its obj management
Date: Wed, 10 Sep 2025 19:37:28 +0800
Message-ID: <20250910113731.2688320-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910113731.2688320-1-Prike.Liang@amd.com>
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e33b68b-90fc-48f3-fa28-08ddf05e7980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p7f+6NBEv9MKBOrHDEZc15S1BzCPHyvq9N5a+gCaY1oxjbAA8pTa0V+kJyYi?=
 =?us-ascii?Q?JPa5WbK3fYg3H/+eJZB+pg8hnMxwG/4zonc+R+h3EVdJJ5Db2FfTPQlgg1wP?=
 =?us-ascii?Q?umqlnwaHmft/utXJKT0WShPGd/WZS51ZfoRAefudSLoFw0NOh5ihg50H+tRc?=
 =?us-ascii?Q?bZl4P8LWmiTYNin67YtJgaoicFdive38xonS+057Z6UTCupIG5IuznWo1euY?=
 =?us-ascii?Q?s9o55x5zYigouCaWfmaxqn9EmeftIsBxO67II6go0IxyZ8zWhr3AJ5LZ85X1?=
 =?us-ascii?Q?eO4PihIDKgMmPYoxrvL5EdB8K2DIZCaga+afpzuSL8wQGMIjYhdhAYOy4wjz?=
 =?us-ascii?Q?Ag7k6PAOXLt40rt//FwPbQUHn1p5DN6g8i02m34ewuYgxDaPixsbqIKbDIDv?=
 =?us-ascii?Q?2smkylJojxzf44LCMupf51tv/jKfh/783cSM9Qg4ZHE7XMjLfj66gCTmVRsI?=
 =?us-ascii?Q?2gENbCie3UYMIyYMzY+2HYLlnH/3xOzcx9fYHzCYD7rOpKNCz8a4al/f5HK6?=
 =?us-ascii?Q?pWlXSezKGof9ZQCa3VosFj639O/qlB/ps8meIyKgEI+eMlUghzOe+/iqNsp/?=
 =?us-ascii?Q?gk/G2iJ4ne07Ri41Q0kPbBR5qnyzlHGuaHFuQdCjFkILRsCTKEza7NK/B6FF?=
 =?us-ascii?Q?m4g7tlF9mEJr7W1OyGBqoObdAskU3dzkjB/qPKtC5WY+ZLXLxzF9UII2qe+h?=
 =?us-ascii?Q?xQCB8zeF9fmkHkNymGuf7Q2k9y2/egSMRTrLN+49RximW5jJYDH4pl0SM0Xw?=
 =?us-ascii?Q?GraoPnGT3bQf6WOmaF4bvdg3BeOY42Wd3ejnl9sdUNMkLDudF+FbKXFQkG6l?=
 =?us-ascii?Q?ctF/5enj1CFz5Lpd6dEHWcbgI9PksTU9Dbrw+jUNgpRFjkD055nupA4ow8HM?=
 =?us-ascii?Q?IlPyoAXOnwHDaU84h3cxlwbH4cX3fuGLmGZ7DvvC1FblOt7qxgJQUaPBz53Q?=
 =?us-ascii?Q?ApbTNZlpYTaR0l5CY5oIJMy49bzZQfExf1e3tVfqSSj0AZ0JrJc4trsz4Jiw?=
 =?us-ascii?Q?TxdWQXzgQfZv0CTPG4RR5gZGhVi6SLaRElVubTj15eMCNVXbkdEdSJYNvDFl?=
 =?us-ascii?Q?3R7j8ajEX98WwOoorbHNUaaEAFhqLvUNqXvX0S2kRvd5f7yk6w4mJv4abs0M?=
 =?us-ascii?Q?Kppjt3LKKTTZkuMUYbj2m3iX8dpX2fg7XZ9PqQdkWx/UmyZTmqu4xm0rnvHg?=
 =?us-ascii?Q?ZjfWyHDfDvFe7jKLjR15/NwKAuZypurc9MY4gdWKoVA5lcrdnztqtGUfQ2oo?=
 =?us-ascii?Q?Xdgq1JquxU4rnvpKlIdI4jojXNfUYDA59jL+937MTaGhfVe4rExl8TBYVLBK?=
 =?us-ascii?Q?x6iDsbSMeDniULwFtDxLX3Jfu9ldGcCyaZMaUtuvcaPbmLlIpOA3RdHWKMN0?=
 =?us-ascii?Q?FPhIW52y+o/4/U3PlN2mgrzNlw63GOt/OJbaKV/rR+PDO0Age+kyoSVYGZEn?=
 =?us-ascii?Q?VEU/slr5qMCkmP+G0nEBA/KTmLPj6/a0yNHYXL/h5zGDiJOV0fmPctwBo4Pg?=
 =?us-ascii?Q?SaxSgYvZ5x48vt6mZSsF4IIZEJUTwkUWQQ6a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:37:51.2031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e33b68b-90fc-48f3-fa28-08ddf05e7980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
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

Track the userq obj for its life time, and reference and
dereference the buffer counter at its creating and destroying
period.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 38 +++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 11 +++++++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f9e817acfdea..7b7dae436e5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -81,7 +81,19 @@ int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
 int amdgpu_userq_buffer_va_get(struct amdgpu_usermode_queue *queue,
 			       struct amdgpu_bo_va_mapping *va_map, u64 addr)
 {
+	struct amdgpu_userq_va_cursor *va_cursor;
+	struct userq_va_list;
+
+	va_cursor = kzalloc(sizeof(*va_cursor), GFP_KERNEL);
+	if (!va_cursor)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&va_cursor->list);
+	va_cursor->gpu_addr = addr;
+
 	atomic_set(&va_map->bo_va->userq_va_mapped, 1);
+	list_add(&va_cursor->list, &queue->userq_va_list);
+
 	return 0;
 
 }
@@ -112,15 +124,13 @@ int amdgpu_userq_buffer_va_put(struct amdgpu_usermode_queue *queue,
 {
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_vm *vm = queue->vm;
-	u64 user_addr;
 	int r;
 
-	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
 	r = amdgpu_bo_reserve(vm->root.bo, false);
 	if (r)
 		return r;
 
-	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
 	if (!mapping)
 		goto out_err;
 
@@ -133,6 +143,23 @@ int amdgpu_userq_buffer_va_put(struct amdgpu_usermode_queue *queue,
 	return -EINVAL;
 }
 
+int amdgpu_userq_buffer_vas_put(struct amdgpu_device *adev,
+			        struct amdgpu_vm *vm,
+			        struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
+	int r;
+
+	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
+		r += amdgpu_userq_buffer_va_put(queue, va_cursor->gpu_addr);
+		dev_dbg(adev->dev, "put the userq:%p va:%llx r:%d\n",
+			queue, va_cursor->gpu_addr, r);
+		list_del(&va_cursor->list);
+		kfree(va_cursor);
+	}
+	return r;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -195,9 +222,12 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
+	/* Drop the userq reference. */
+	amdgpu_userq_buffer_vas_put(adev, queue->vm, queue);
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
+	list_del(&queue->userq_va_list);
 	kfree(queue);
 }
 
@@ -518,6 +548,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	INIT_LIST_HEAD(&queue->userq_va_list);
+
 	/* Validate the userq virtual address.*/
 	if (amdgpu_userq_input_va_validate(queue, &fpriv->vm, args->in.queue_va, args->in.queue_size) ||
 	    amdgpu_userq_input_va_validate(queue, &fpriv->vm, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE ) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 6044afeeb741..3623c8f6899a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -48,6 +48,12 @@ struct amdgpu_userq_obj {
 	struct amdgpu_bo *obj;
 };
 
+struct amdgpu_userq_va_cursor {
+	uint64_t	 gpu_addr;
+	struct list_head	list;
+
+};
+
 struct amdgpu_usermode_queue {
 	int			queue_type;
 	enum amdgpu_userq_state state;
@@ -69,6 +75,8 @@ struct amdgpu_usermode_queue {
 	int			priority;
 	struct dentry		*debugfs_queue;
 	uint64_t		generation;
+
+	struct list_head	userq_va_list;
 };
 
 struct amdgpu_userq_funcs {
@@ -146,4 +154,7 @@ int amdgpu_userq_buffer_va_get(struct amdgpu_usermode_queue *queue,
 			       struct amdgpu_bo_va_mapping *va_map, u64 addr);
 bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_va_put(struct amdgpu_usermode_queue *queue, u64 addr);
+int amdgpu_userq_buffer_vas_put(struct amdgpu_device *adev,
+				struct amdgpu_vm *vm,
+				struct amdgpu_usermode_queue *queue);
 #endif
-- 
2.34.1

