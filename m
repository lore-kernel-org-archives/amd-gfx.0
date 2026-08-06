Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45876C55838
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 06:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAEF310E28E;
	Thu,  6 Aug 2026 06:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YmwsiQlX";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A85D10E28E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 06:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnFdZzeaR0kgRaC2HCdAk7ZijlwrO+z+qjBs7ynay+AR6rCIleT8ZjtOMHumSDMKthvjftmSFCFo5gBIeYC+el52l5X5/lMlgUSl/xHujkQoMG53yKkw00wrTGxRy2SFAKWJr5Mb2aXLs6EKNiphhobwaSHfuWC0/wZrPMpcaOIEe6ZvqLaBzP4Q8PaKWYIdiy6I2QiX4RdjRML3S2TlwrQ0h+GKNx88r/wmdi8VMOSa8xSHkYFKc3iH+LnPyM6Z6xaIueL34pyGNlhxTL4rzVPTs3DHkBrvTwKmE5HHq1sciBRaDyXKD5tYETMseUchfgibFbfpYelsX9izDKVnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcjn3Ih3sQs0Dq87/94R6iP0+BwehfxLnW5g9wGsxtg=;
 b=ZyVXjiVNR8E0zjKLwMFGh6iLLqmXuGutp7NzwUFogYtISrcruxeaSqeS+9t2VYWlN3dP4PxVn8XvfPgoZJWkQMqIA9vxIBzldmmn1k6K4ZqlWaqPFbuIlqhZUbRk2bV1ZYtPpqGT7XzvQdg1Xn6Y952R2L/cOa+WJpkKkO9//EY2VNUSc7ClZcUyQQSp2ULVO6RnnOg6q4xusMuSPEOvJoh2h7WRoK06VqeeLQdRWimliWbJZ1rRUycA3wv+vkdKWvep8XwRA5fGWa/6wkzhdL8HrdLOdUifmUcy7RzwhqFKVBN+m/MNJQCmvpbBw8g5E/p4P9w73B67u0LSRlEq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcjn3Ih3sQs0Dq87/94R6iP0+BwehfxLnW5g9wGsxtg=;
 b=YmwsiQlXKEHbHDOK+A4UjzdITfQ20jIqrZaKko89lNijWEthP7Og3/LHwpBOxI+kT5WTY/zcsvbtezAHt+Ssl9MTmKcaMWce41C3rFmTiXO3N18k6QNjyb+78dX0OIFW89QyZAbGUez9LGT12zCr1VsMIabK3kFpvkWdO7A6Csg=
Received: from BLAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:32b::15)
 by IA0PPF002462CFE.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 06:21:00 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::8a) by BLAPR03CA0010.outlook.office365.com
 (2603:10b6:208:32b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.20 via Frontend Transport; Thu, 6
 Aug 2026 06:20:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 06:20:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 01:20:59 -0500
Received: from shikangserver.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 6 Aug 2026 01:20:56 -0500
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Philip.Yang@amd.com>, <Mario.Limonciello@amd.com>,
 <Srinivasan.Shanmugam@amd.com>, <Tiantian.Zhang@amd.com>,
 <Victor.Zhao@amd.com>, <Guoqing.Zhang@amd.com>, Shikang Fan
 <shikang.fan@amd.com>
Subject: [PATCH v5] drm/amdkfd: preserve VRAM MQD across hibernation via
 unpin/repin
Date: Thu, 6 Aug 2026 14:20:53 +0800
Message-ID: <20260806062053.806535-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|IA0PPF002462CFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 56076921-3c4f-4138-26e6-08def382e217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ESp5ju/1H05yfRRN+rtgrXx7q3VpHK+BwjZWGMpW6nLZLZ1F0usy39VqnYb8cmnqGXoro4J4EUtv9R1Ei3Q0M9hvyQapyWqnTxk2heyK+HfaycunNxMXFY9pzA1GAJfg0LsncXefmjlgWF6etzT5jXmtwIKfbfnssufKHBll8FE8WzJkJ0W/M07gi7KZMhvE0g67brPXzJdgj9urYhHX0+fi22jRlF4ge4TvYwVGBBUHqmJT3tzn5ACgQpAXGEre9B0qCMbXC7XBvTzPOqBCWmLVRQcOAeehXBnapbsA9bw5OdH/33Owj6FrrEELuO4gL4Scn7o1XXP5eCh6rJa7pEgwdl3UYBR+spi7caCclbu6GP5wa3eHl+awqIRDotG9WRBzGBru1qS+VzmiaA9dNZkaJkaa/u12QSHGKlfEMisyOuwW2/y2V8Tbm866zBmYXeY8lN75uVCKR/xATL8/swo0/NOHA8/TE3AWjCwmk/H6DnndZOhjLuDr05Okyf4kbBXr3kBAPVbVBD03BEjYLVuLapnbGR5evDVvde3g3Quy/SFVoR3FG+DzEnrjNBgob2veBUOFSuT8xgAXwQ50qN99wLSNfioS7WuRKuAzMkIJG3IBfr+21nDda10o0+DQKB4JRtf35yNReRVDY4BfC9kmJ1rB5CHPSKyFYxuIJr12VQuS51bua+f5KNdNaBfe+44XUFmFvx39hEeAfTB4gQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4yRmWCvtNmWuVUY/7JknG7tA43NSbnDH0PzNWn9mGbUu12RF91I+PUl0St74APgT9QAaEllZ7Z3JvbNvuUNYEtfiY+onHrq5VNuzH4p8cQHqaTNhIF7Cco/r1TB/+n0e513T3ErXclC8CqDQa5+QGP1NbyVhRyJBAhv9zd1Mar7cOSw1/rOLXzZ357onZSLn3aB6cg3jBqa2fs/IeuVqSr9jBKGnUN0yF7iqcQJaOp1ujnTU5KhtAx/le0ADRdv0EuQzpRac5ZDhbBom0L7Hh6uIuqPb6dkfto5R4/N4GhafkvsTCLQiOZO9DGE1vgNO6Lp/XQNkQnhSxkVgTlW4/gLEQjpklEhVdkux8z8Jsne/ttr4/C0DwV/3svmcp3Pqaj+FPaMZbaw44W4LgpiRiFQ708J6LWON4fWub0t8ShunIJtLyjQ7qmrb+1VPnc+c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 06:20:59.7203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56076921-3c4f-4138-26e6-08def382e217
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF002462CFE
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

On gfx9 ASICs with mqd_on_vram(), a compute queue MQD lives in a pinned
VRAM buffer object. Pinned BOs are skipped by the VRAM eviction done at S4
suspend, so the MQD contents are lost across hibernation and the first
submission after resume page-faults on a stale MQD.

Unpin the MQD BO at suspend so the eviction migrates it into the
hibernation image, and pin it back to VRAM on resume. The BO may return at
a different VRAM address, so refresh the kernel mapping and cached GPU
addresses and patch the MQD self-address via a new update_mqd_gpu_addr()
mqd_manager op; skip eviction with a warning if that op is not implemented.

v3: use unpin/repin instead of shadowing the MQD into a separate buffer.

v4: drop the explicit VRAM->GTT placement at evict (a bare unpin is enough
for the eviction pass to move the BO out of VRAM), and also repin at queue
destroy. KFD queue restore runs late - user processes thaw before it, and
under SR-IOV it is deferred until the VF regains full access - so once the
VM has resumed an application can destroy a queue before its MQD BO is
repinned, which would otherwise unpin an already-unpinned BO and touch a
stale q->mqd.

v5: drop support for no-HWS mode, and set q->mqd to NULL at eviction.

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 106 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |   8 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  40 +++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   6 +
 4 files changed, 160 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ea9d87450eae..a23384571193 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1257,6 +1257,99 @@ static int resume_single_queue(struct device_queue_manager *dqm,
 	return 0;
 }
 
+/* Unpin the MQD BO at S4 suspend so it is evicted into the hibernation image;
+ * dqm_repin_mqd_bo() pins it back on resume. Gated on adev->in_s4 so runtime
+ * eviction is untouched.
+ */
+static void dqm_evict_mqd_bo(struct device_queue_manager *dqm, struct queue *q)
+{
+	struct mqd_manager *mqd_mgr;
+	struct amdgpu_bo *bo;
+
+	if (!dqm->dev->adev->in_s4)
+		return;
+	if (!mqd_on_vram(dqm->dev->adev))
+		return;
+	if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE)
+		return;
+	if (!q->mqd_mem_obj || !q->mqd_mem_obj->mem)
+		return;
+
+	/* Without update_mqd_gpu_addr() the MQD self-address cannot be fixed up
+	 * after a repin, so skip eviction (with a warning) instead of faulting.
+	 */
+	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
+	if (!mqd_mgr->update_mqd_gpu_addr) {
+		dev_warn_once(dqm->dev->adev->dev,
+			      "MQD is in VRAM but update_mqd_gpu_addr is not implemented; skipping hibernation eviction\n");
+		return;
+	}
+
+	bo = q->mqd_mem_obj->mem;
+	if (amdgpu_bo_reserve(bo, false))
+		return;
+
+	amdgpu_bo_unpin(bo);
+	amdgpu_bo_unreserve(bo);
+	q->mqd = NULL;
+	q->needs_mqd_repin = true;
+}
+
+/* Repin the MQD BO to VRAM and refresh the cached mapping and GPU addresses.
+ * Used both on resume and when a queue is destroyed before resume has repinned
+ * it. A no-op unless a repin is owed (needs_mqd_repin set).
+ */
+static int dqm_repin_mqd_bo(struct device_queue_manager *dqm, struct queue *q)
+{
+	struct mqd_manager *mqd_mgr;
+	struct amdgpu_bo *bo;
+	void *cpu_ptr;
+	int r;
+
+	if (!q->needs_mqd_repin)
+		return 0;
+	if (!q->mqd_mem_obj || !q->mqd_mem_obj->mem)
+		return 0;
+
+	bo = q->mqd_mem_obj->mem;
+	r = amdgpu_bo_reserve(bo, false);
+	if (r)
+		return r;
+	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_VRAM);
+	if (r) {
+		amdgpu_bo_unreserve(bo);
+		dev_err(dqm->dev->adev->dev,
+			"Failed to repin MQD of queue %d to VRAM: %d\n",
+			q->properties.queue_id, r);
+		return r;
+	}
+	/* The BO may have moved; refresh the kernel mapping and gpu address. */
+	amdgpu_bo_kunmap(bo);
+	r = amdgpu_bo_kmap(bo, &cpu_ptr);
+	amdgpu_bo_unreserve(bo);
+	if (r) {
+		dev_err(dqm->dev->adev->dev,
+			"Failed to remap MQD of queue %d: %d\n",
+			q->properties.queue_id, r);
+		return r;
+	}
+
+	q->mqd_mem_obj->cpu_ptr = cpu_ptr;
+	q->mqd_mem_obj->gpu_addr = amdgpu_bo_gpu_offset(bo);
+	q->gart_mqd_addr = q->mqd_mem_obj->gpu_addr;
+	q->mqd = cpu_ptr;
+
+	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
+			q->properties.type)];
+	if (mqd_mgr->update_mqd_gpu_addr)
+		mqd_mgr->update_mqd_gpu_addr(mqd_mgr, q->mqd,
+					     q->mqd_mem_obj,
+					     &q->properties);
+
+	q->needs_mqd_repin = false;
+	return 0;
+}
+
 static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd)
 {
@@ -1353,6 +1446,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 				goto out;
 			}
 		}
+
+		dqm_evict_mqd_bo(dqm, q);
 	}
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes) {
@@ -1492,6 +1587,13 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 		q->properties.is_active = true;
 		increment_queue_count(dqm, &pdd->qpd, q);
 
+		retval = dqm_repin_mqd_bo(dqm, q);
+		if (retval) {
+			dev_err(dev, "Failed to repin MQD for queue %d\n",
+				q->properties.queue_id);
+			goto out;
+		}
+
 		if (dqm->dev->kfd->shared_resources.enable_mes) {
 			retval = add_queue_mes(dqm, q, qpd);
 			if (retval) {
@@ -2763,6 +2865,8 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 				qpd->pqm->process, q->device,
 				-1, false, NULL, 0);
 
+	/* Repin the MQD BO if still evicted for hibernation, before it is freed. */
+	dqm_repin_mqd_bo(dqm, q);
 	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
 
 	return retval;
@@ -3020,6 +3124,8 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 		list_del(&q->list);
 		qpd->queue_count--;
 		dqm_unlock(dqm);
+		/* Repin the MQD BO if still evicted for hibernation, before free. */
+		dqm_repin_mqd_bo(dqm, q);
 		mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
 		dqm_lock(dqm);
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 59eff3389d39..38b46b696243 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -117,6 +117,14 @@ struct mqd_manager {
 				const void *ctl_stack_src,
 				const u32 ctl_stack_size);
 
+	/* Patch the MQD's cached self GPU address after the MQD BO has moved
+	 * (e.g. repinned to a new VRAM location on hibernation resume). The MQD
+	 * contents are otherwise preserved.
+	 */
+	void	(*update_mqd_gpu_addr)(struct mqd_manager *mm, void *mqd,
+				       struct kfd_mem_obj *mqd_mem_obj,
+				       struct queue_properties *p);
+
 #if defined(CONFIG_DEBUG_FS)
 	int	(*debugfs_show_mqd)(struct seq_file *m, void *data);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 75e5a9f67d50..b95720198e28 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -476,6 +476,20 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 	qp->is_active = 0;
 }
 
+static void update_mqd_gpu_addr(struct mqd_manager *mm, void *mqd,
+				struct kfd_mem_obj *mqd_mem_obj,
+				struct queue_properties *qp)
+{
+	struct v9_mqd *m = get_mqd(mqd);
+	uint64_t addr = mqd_mem_obj->gpu_addr;
+
+	m->cp_mqd_base_addr_lo = lower_32_bits(addr);
+	m->cp_mqd_base_addr_hi = upper_32_bits(addr);
+
+	if (mqd_on_vram(mm->dev->adev))
+		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
+}
+
 static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *q)
@@ -860,6 +874,30 @@ static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 	if (mqd_on_vram(mm->dev->adev))
 		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
 }
+
+static void update_mqd_gpu_addr_v9_4_3(struct mqd_manager *mm, void *mqd,
+				       struct kfd_mem_obj *mqd_mem_obj,
+				       struct queue_properties *qp)
+{
+	struct kfd_mem_obj xcc_mqd_mem_obj;
+	uint64_t offset = mm->mqd_stride(mm, qp);
+	u32 num_xcc = NUM_XCC(mm->dev->xcc_mask);
+	struct v9_mqd *m;
+	int xcc;
+
+	memset(&xcc_mqd_mem_obj, 0x0, sizeof(struct kfd_mem_obj));
+
+	for (xcc = 0; xcc < num_xcc; xcc++) {
+		get_xcc_mqd(mqd_mem_obj, &xcc_mqd_mem_obj, offset * xcc);
+		m = get_mqd(mqd + offset * xcc);
+		m->cp_mqd_base_addr_lo = lower_32_bits(xcc_mqd_mem_obj.gpu_addr);
+		m->cp_mqd_base_addr_hi = upper_32_bits(xcc_mqd_mem_obj.gpu_addr);
+	}
+
+	if (mqd_on_vram(mm->dev->adev))
+		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
+}
+
 static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		   enum kfd_preempt_type type, unsigned int timeout,
 		   uint32_t pipe_id, uint32_t queue_id)
@@ -1017,6 +1055,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 			mqd->get_wave_state = get_wave_state_v9_4_3;
 			mqd->checkpoint_mqd = checkpoint_mqd_v9_4_3;
 			mqd->restore_mqd = restore_mqd_v9_4_3;
+			mqd->update_mqd_gpu_addr = update_mqd_gpu_addr_v9_4_3;
 		} else {
 			mqd->init_mqd = init_mqd;
 			mqd->load_mqd = load_mqd;
@@ -1025,6 +1064,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 			mqd->get_wave_state = get_wave_state;
 			mqd->checkpoint_mqd = checkpoint_mqd;
 			mqd->restore_mqd = restore_mqd;
+			mqd->update_mqd_gpu_addr = update_mqd_gpu_addr;
 		}
 		break;
 	case KFD_MQD_TYPE_HIQ:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2ea1cfd330a9..d8631847f0eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -638,6 +638,12 @@ struct queue {
 	uint32_t gang_ctx_array_index;
 
 	struct amdgpu_bo *wptr_bo_gart;
+
+	/* The VRAM-resident MQD BO (mqd_on_vram()) is unpinned at S4 suspend so
+	 * TTM evicts it into the hibernation image, and repinned on resume. Set
+	 * while the BO is unpinned so the resume path knows to repin it.
+	 */
+	bool needs_mqd_repin;
 };
 
 enum KFD_MQD_TYPE {
-- 
2.34.1

