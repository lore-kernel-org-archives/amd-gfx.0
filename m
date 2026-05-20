Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC82CD5BA6
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 01:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C58610ECEA;
	Wed, 20 May 2026 01:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ef4biG2i";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011005.outbound.protection.outlook.com [52.101.57.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B05D10E129
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 01:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BS2k0qbsFBRiC9EVjG9EspScQvH/2KwYvlVVOO2AaCXorFo3vYwhWosubbanGPSuctD9p3FRleSIkuUaEmqfg0yGY5dYAfwxz5xrgQIxvh5ogaUi9Cu5oCjs+mo01eNbpGWZSWMU8HeidQnAHSYG/ENuLzGe5ONT2Lirzs7/CCJjzfez2kFOSpNX9CQGLtUkXVHB3D9SQtW6rA9pk5nQ9tbNXdG0I0j8DpD23bwxbPwyV06PXOlogze9Pa601ljBdkeubfjHR6D36S8qixorHgKdw6dFoB3uyG07XDWyQ9rKhYBJ4v1JGTVUPmMKUqVMNPrinKJyXA+ObGtYTaTcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z70hX6pNnTXSJ+ctql3s5Mk2iMpRsv3UjI5Ri1JUrkk=;
 b=GV7WiqiiaN5prcGXJ2QSIacPCRkA2ZrCnG7Q3ny41qpKpWp3TcchgzLbobgU/06dUJPXgU0PraW6URSnpveMLAk0TfCLpxafCVLwi0bjhicsL9Iwhq6d7SI+SWAL44REX5GKrFOpWas5HJm8MTNllxSPhcvOIr9gWFLXurIoFNmkseouJaB0j88Szx1Y4JJy07hWUtjhW2CidtOOXfj63zlI82vAtX29tZNy5LloJSYRIkJ5fV90a7LVwLpg5JfQnZ3wHdyzPKgXUP8VngDuwMnPpi5kD/KqWKCbxSKsYVMQiWxr/Wbr/hVUC78RWKpTzK9De47C/hRgsA4FKAzyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z70hX6pNnTXSJ+ctql3s5Mk2iMpRsv3UjI5Ri1JUrkk=;
 b=Ef4biG2iuA0pRZULdz6oSrEPGUe/bg37+LoR7MgUTs/Ne0an6jd6eujrRhMCqsCXlvz8IuJDh5yGFBNGLQcxj9we28FMrVBmUH4XHJi89xckMfe2BfXwOJqUdIHdKIChH1vrxHX3bNF+cCnuNKmZ5wKevMliHNi8NSEQZWw7TvM=
Received: from BL1PR13CA0350.namprd13.prod.outlook.com (2603:10b6:208:2c6::25)
 by BN7PPF62A0C9A68.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Wed, 20 May
 2026 01:56:17 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::24) by BL1PR13CA0350.outlook.office365.com
 (2603:10b6:208:2c6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 01:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 01:56:16 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 20:56:11 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 20:56:11 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: guard userq BO unpin calls against zero
 pin_count
Date: Tue, 19 May 2026 21:55:11 -0400
Message-ID: <20260520015609.127747-2-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520015609.127747-1-vitaly.prosyak@amd.com>
References: <20260520015609.127747-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|BN7PPF62A0C9A68:EE_
X-MS-Office365-Filtering-Correlation-Id: 531d1afc-3527-4ec8-bb7f-08deb612faf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: u/gsJZArFF87aniikZH/yvx7VYp/rrExkmX51JkGDA3O7l7o0/Lf1dXO8OImJBuoUY6hIUo0NSvBchHPT/sxWySlHNHIbWIOCX8ab6MKj3n8ViEVDGeGAwBSN9JNDAPZ8lU9NcWGqjV5uyLcMouE0J+NiL4AVjfW2hsCb+BC0dCti3SLf5Az5NKWMJxE2V1BHgUGp5VE+3WWtZcEwcq2fUnFmaSwjAkA0kRvIUlZ7YUtl+3FJcFu9Ml/m/LcwVpnaTbBOffKIEuvUl5+VnSkLCgP0u/jAVKlL+8F/TXOkHl3C8pP7SbwVFCaAqcgJ2JMlw5d5GoJYKqSGibW+wNkfX3Ne5CeUs1d9sru2CzMWD07iFEgChoVz56kKZL9ptBcyHQUCn1M1OPYXGMzlfCJd6ajnTQH6x1aOx6+8WbU96xj482y191Dv9XyYGJZix/YAjLYJZNU/uolFq+kre7HAHtm9LEszJYhRMDDa0eg9MTnVXVeIncgaPWbpyCVHSuIzd1PIB4OomGJvy+pxerzIfWcYTlwdTAzYnGUMMsNWA7u1thcpqZ56gxApy110JS6TMaPBu8DrZ6FRP7hZBCkjYlVDPqNNFTRaGemIuAh5oL9qn5ToEZ2bJnD59bxWKh1lLmExP4o2DrS6U6CN2l/d1yBtCB8Le2jZXC0EBJsWJyhM84fDX+63Ll7Kih6wWNofNXEryTe4Nu9dVK47eM5pL8eYtDYxt95WcYrbiECldY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SgkUmjF2GXKAo6LP3KuhHH/Gef/K4I6hirY/XbOerESB4vL+4KbLLeTTzJBCpHfgoO5EK8aJu4sjrIil6nzdh2GKO2ZYVQ4zL9tGkLiQFFkIxDHo/NM3DX9EDwHhWtF9kzsED/NXTxL5uEZelpTBsqqusa1oxsBYzwGz7M7zpjmYAjRy5AAh4nPZcShLoLg2d/QpGmZhNBtmVbWfQPCz3mAXr/9kQLlVZFiAMZDu/dBsSD2A2VWP/J+Z3s1RCafhqKftvhX1V9OuUXDGpkFfj19/w2K8VFBYA3F1avFGiFaRLQN44tlztAG7J24FW8N3FZCWlctbQwhe6Hu8dGp+PXoIqGQO97lZgKEXLu8XQSF2Sj4w2qSFLIjiw9OTTcfuJCtZ3QFuuwVQsVQmvOgD6qQV/2XpgLu6Gi/ayedxf9B0rnr08dWGguOnmY8P+CBc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 01:56:16.9012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 531d1afc-3527-4ec8-bb7f-08deb612faf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF62A0C9A68
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

Add pin_count checks before calling amdgpu_bo_unpin() in the user queue
destroy paths. When a GPU reset or TDR occurs during a SDMA user queue
hang, the BOs may already be unpinned by the reset path. The subsequent
explicit destroy (via ioctl or file close) then hits pin_count==0,
triggering TTM warnings:

  WARNING: drivers/gpu/drm/ttm/ttm_bo.c:646 at ttm_bo_unpin
  WARNING: drivers/gpu/drm/ttm/ttm_resource.c:270 at ttm_resource_move_to_lru_tail

Also add the missing amdgpu_bo_reserve/unreserve around the unpin in
amdgpu_userq_destroy_object(), which TTM requires (dma_resv_assert_held).

Move mqd_destroy() outside of the userq_mutex critical section in
amdgpu_userq_destroy() to fix a circular locking dependency:
  reservation_ww_class_mutex -> userq_mutex (restore_worker path)
  userq_mutex -> reservation_ww_class_mutex (destroy path via mqd_destroy)

The queue is already unmapped at this point, so firmware no longer
references the MQD - safe to free the BOs without holding userq_mutex.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com> 
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 27 +++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3bfb9ae2cb3a..88c80dae27b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -417,17 +417,14 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
-	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
 	/* Wait for mode-1 reset to complete */
 	down_read(&adev->reset_domain->sem);
 
-	uq_funcs->mqd_destroy(queue);
 	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
 	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
 	amdgpu_userq_fence_driver_free(queue);
 	queue->fence_drv = NULL;
-	queue->userq_mgr = NULL;
 	list_del(&queue->userq_va_list);
 
 	up_read(&adev->reset_domain->sem);
@@ -531,8 +528,13 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
 void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_userq_obj *userq_obj)
 {
-	amdgpu_bo_kunmap(userq_obj->obj);
-	amdgpu_bo_unpin(userq_obj->obj);
+	struct amdgpu_bo *bo = userq_obj->obj;
+
+	amdgpu_bo_reserve(bo, true);
+	amdgpu_bo_kunmap(bo);
+	if (bo->tbo.pin_count)
+		amdgpu_bo_unpin(bo);
+	amdgpu_bo_unreserve(bo);
 	amdgpu_bo_unref(&userq_obj->obj);
 }
 
@@ -637,13 +639,24 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	amdgpu_userq_cleanup(queue);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
+	/*
+	 * Free MQD and firmware objects outside of userq_mutex to maintain
+	 * lock ordering: reservation_ww_class_mutex (acquired by bo_reserve
+	 * inside mqd_destroy) must not be taken while holding userq_mutex,
+	 * since the restore worker takes them in the opposite order.
+	 */
+	adev->userq_funcs[queue->queue_type]->mqd_destroy(queue);
+	queue->userq_mgr = NULL;
+
 	amdgpu_bo_reserve(queue->db_obj.obj, true);
-	amdgpu_bo_unpin(queue->db_obj.obj);
+	if (queue->db_obj.obj->tbo.pin_count)
+		amdgpu_bo_unpin(queue->db_obj.obj);
 	amdgpu_bo_unreserve(queue->db_obj.obj);
 	amdgpu_bo_unref(&queue->db_obj.obj);
 
 	amdgpu_bo_reserve(queue->wptr_obj.obj, true);
-	amdgpu_bo_unpin(queue->wptr_obj.obj);
+	if (queue->wptr_obj.obj->tbo.pin_count)
+		amdgpu_bo_unpin(queue->wptr_obj.obj);
 	amdgpu_bo_unreserve(queue->wptr_obj.obj);
 	amdgpu_bo_unref(&queue->wptr_obj.obj);
 	kfree(queue);
-- 
2.54.0

