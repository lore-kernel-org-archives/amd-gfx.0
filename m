Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7910CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 11:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A71A10E8F4;
	Wed, 10 Sep 2025 11:38:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ObrWBDf2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 276D110E8F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 11:37:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3Ap/TOHSAlqjrX3T42q9FZMnn5p6phZhzjAH6QTG3bYrSnXC2MapW1NZvHOcp+tQt8JTevb6gcbGZZX6zVXm84rAwPVSPi9PUsR5P2WMxeToU3yNcLMjxEdgXFbNBlqvSyJ+jAP79m+7jDvtqXYV9XeakytjFwF1+moiKrQjRdxOh4jsNwbeJaK/k8JzQpn99abrXLdwqaS/QI7TI6GI4oKeydC/uJyNFzR2CLv/ilVEbAg+m14JI3YyLRNjmFO0O51wHy4Od0vT5N7UvOVJBoLm7Vsgv/ijDSnZXvTb6SEZnnCb7S6ShyKYvs5nT2yXCIbMq5vZDoG+4kowJGHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9cVrTD66pbqvZDSLvt+9nIwgI302mL+1v1yWDSEX+Q=;
 b=Dx9OlFDGyUCbL51ALSvHFeGcmegJ1RLhuf5GZte/UHxceURAGUaV8qOGZcvF7XVesEttRHrrdP/Wlk6q7UJcc/6//EdNtZy/iRixceiSJY+4NwLU8jbk0/B4jcvkXyFpsGT4abe7+j+s+/MKTyUIqpCcM9r64z1vm3aQrAwV3nGHZK9UszjL59OWM3V1kQGhM85N5w5hgLGaIQwrJJm6JhDvf/rA4WEZmIPq8rBj8dsNG4VWBbOlb3ThdYym1QQgBkSe5YzeXASM45HpptOENkPQjr63ghvMZPYQszZX69Hp/yasQEwpd9bYWpXKVtm+BSFgy3MFTQ9cVe3o/0bRdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9cVrTD66pbqvZDSLvt+9nIwgI302mL+1v1yWDSEX+Q=;
 b=ObrWBDf2Gjc3kNh9T3cGgSJdxthkMB13AHzMkPqZQruNNCbwlOlCeVKPTgjDyTx76uxyircxCZv2BPS/7HqgoyG8MvMJ3sFoVHoT5B2RkYyHWzd7J5O36WQp/aAWla0mg2F1volNOl+LJOWX7V4/72yL8v6X18AQF9ojl3dKh5s=
Received: from CH0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::15)
 by MW4PR12MB6851.namprd12.prod.outlook.com (2603:10b6:303:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 10 Sep
 2025 11:37:49 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::c6) by CH0P220CA0007.outlook.office365.com
 (2603:10b6:610:ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 11:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 11:37:49 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:37:47 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 5/9] drm/amdgpu: add userq object va track helpers
Date: Wed, 10 Sep 2025 19:37:27 +0800
Message-ID: <20250910113731.2688320-5-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|MW4PR12MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e297c47-d93f-4ac5-3452-08ddf05e786f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BjXJnKWktmL2lTq2yJS47zQMO3YPhloekSnpBzcqWDPPjIUApery8cARef6a?=
 =?us-ascii?Q?J/VJcXOMAdghT1RCMJnRPgDofToyFblCTu7xrp2r9XFM5P6lDIT+hnE26bgx?=
 =?us-ascii?Q?E/SJ2WRQ6PCXdp0PZJaDGcrMq4CMAhbcbiXx2c4KKefa4lUjFSzRNZz6zTEl?=
 =?us-ascii?Q?3BvrxixB0v9BhY984e1LEnWKxv+2QRSl+fSSm7aEIelvrVzQXttihvyLxxMW?=
 =?us-ascii?Q?giPFTuySYS5e/Ij/Xq36LeLHx7aQ1+eyLRGFkp4L07BLDidfG+tHSki1MPOQ?=
 =?us-ascii?Q?84ONw7b5S804xA10MlCyw57cH9vf7TTINuvuzgkN9gdlWM8hwpAXn1PQndOm?=
 =?us-ascii?Q?UZ02cWUUepMktStQwFlPatbPNqBRFSst6EiG27T/yYohwMZTvqwDjfb85pb0?=
 =?us-ascii?Q?vSZMakWAcGBotXxlUfZToog1GDJV8VyZryPxDRGwv2+50WYy2u/nn72JdKhM?=
 =?us-ascii?Q?qoEzU0H/8mURFMo9KpWwX2niI4o6oZIL9jflEhiDWQn8oMpAjYkppjui7ip4?=
 =?us-ascii?Q?t5hhRhs9xLAOZC6yJ9CL9f0uvE6p2Mf9J53OKvNenle3MxrrUcP3D5uGvc9p?=
 =?us-ascii?Q?sJsT17gntZE70ShUxATAAcnFIxLZuT+t0NUwGmszK6h5UnR5fiUulqIJxViU?=
 =?us-ascii?Q?VXl47CEzSLbVONV9aolaBq3uiWZSg7lxPPp6HP2PvsmeuOPZRl5dn3tdQx7J?=
 =?us-ascii?Q?4BMykdY7ziitO98jzPoHswg5+QCuHrGIplxpsM5AGsBBcv2UJF+f0RaxjOG6?=
 =?us-ascii?Q?iRBwrjUxMhJeoV1KIyjYzQ3en+YUnOXa3OmAGxsIDPvDVAO7WRz6w84zNDqj?=
 =?us-ascii?Q?GhSDmhAIrr1SqRIlBESPYloqcJMdLX+mhT0+4HiLLAPpWGlsN6+7wsXnQXq5?=
 =?us-ascii?Q?vXX5cZSBk8kjiH5OAQOSXYE79OmgmFXamXcMOxCfvchP/e6sn/EvszhUqw16?=
 =?us-ascii?Q?o7OIYWohHOI+RVr7r2ESNS5mWNf9EXEVvHzkPULhFhtNJfnvRyWXmEf89pO0?=
 =?us-ascii?Q?XxzDlzaWzaRYwZgvtHBX5T0pJHqn82r9Y+rH7p24FzXcg9F52LXD4qAoXoKc?=
 =?us-ascii?Q?TqqDmd1eBKfhxOALIA78QTpMIlWDyhm1QbcCkeYsQgVdgIPHbGsmDwUyoEgr?=
 =?us-ascii?Q?siBUh6QYXbC1cVuu06pbz+e21zJQzPnFmBrRiuHFjr6ccj52m00RXKVe/FBp?=
 =?us-ascii?Q?F55ebNXTquK3IqOoPiRCU9IuybTe2ljG3QAc+NpuUbVMSkTITjrn8eCIJFLv?=
 =?us-ascii?Q?BhijeE63coEPPZT09usMEg+Xgticq4oya5ymsMdUkm577xA2AeJhn3lwoJgI?=
 =?us-ascii?Q?q/KCyn4PpSywPceZ97vnEiUL+mj7lh04sUjCFynf5W6vlD9Eq6vIDtbUbCSY?=
 =?us-ascii?Q?bywHFRwcetehAiPEwvgWpde1XhVqmHqhRUizcwx+pCWE9OnA7mTKWbZiC9Ls?=
 =?us-ascii?Q?DtMcLS9OSYdOe/5GnMzoiNNU9Lc095ejmnauJ9HrMUaBJR+VgkoV6o3UL7cH?=
 =?us-ascii?Q?HFTv4y+j/0TKD/qkxXWO6hvuwsGwVIRbCtEo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:37:49.4099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e297c47-d93f-4ac5-3452-08ddf05e786f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6851
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 66 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  9 ++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 ++---
 4 files changed, 75 insertions(+), 14 deletions(-)

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
index ba7be4db5a01..f9e817acfdea 100644
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
+		amdgpu_userq_buffer_va_get(queue, va_map, user_addr);
 		amdgpu_bo_unreserve(vm->root.bo);
 		return 0;
 	}
@@ -76,6 +78,61 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 	return r;
 }
 
+int amdgpu_userq_buffer_va_get(struct amdgpu_usermode_queue *queue,
+			       struct amdgpu_bo_va_mapping *va_map, u64 addr)
+{
+	atomic_set(&va_map->bo_va->userq_va_mapped, 1);
+	return 0;
+
+}
+
+bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	u64 user_addr;
+	bool r;
+
+	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
+
+	if (amdgpu_bo_reserve(vm->root.bo, false))
+		return false;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
+	if (!IS_ERR_OR_NULL(mapping) && atomic_read(&mapping->bo_va->userq_va_mapped))
+		r = true;
+	else
+		r = false;
+	amdgpu_bo_unreserve(vm->root.bo);
+
+	return r;
+}
+
+int amdgpu_userq_buffer_va_put(struct amdgpu_usermode_queue *queue,
+			       u64 addr)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	struct amdgpu_vm *vm = queue->vm;
+	u64 user_addr;
+	int r;
+
+	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
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
@@ -462,9 +519,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
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
@@ -504,7 +561,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 33a582200dda..6044afeeb741 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -53,6 +53,7 @@ struct amdgpu_usermode_queue {
 	enum amdgpu_userq_state state;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
+
 	uint64_t		flags;
 	struct amdgpu_mqd_prop	*userq_prop;
 	struct amdgpu_userq_mgr *userq_mgr;
@@ -138,7 +139,11 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx);
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
-
-int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
+int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
+				   struct amdgpu_vm *vm, u64 addr,
 				   u64 expected_size);
+int amdgpu_userq_buffer_va_get(struct amdgpu_usermode_queue *queue,
+			       struct amdgpu_bo_va_mapping *va_map, u64 addr);
+bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
+int amdgpu_userq_buffer_va_put(struct amdgpu_usermode_queue *queue, u64 addr);
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

