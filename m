Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E766C54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 11:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF77610E47E;
	Wed, 29 Jul 2026 11:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="spVKRlzl";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011027.outbound.protection.outlook.com
 [40.93.194.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C187B10E47E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 11:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVftggkKTRWS5A5D5h179meY9GlnqfAZHM/04IMQK8Rrd6GENmuFgN4MwudfqI0IPx1nco/tiZgnvXn2loNLPRlQBFnZymDhHE170uEb8tuG4V9IhYUP5n34tHfbPV+yG4vz/yFhJszixqrdFiIgkQ6wAOLFMoTMcijFQrck9DaZ/+37AopB75AsDTsI3m2OSPzUCsI3Dl1TUSD2ZoCme6lzEk69+csmhJx3dgzZqiy4skH4kapWsWkqwGuw1jBlZIUAtPt6Auvk4elTPiYY+/7QCBi8bbhoVALxmKnWupwkOr+oFGPXlofnSUBpQex1+8ztzGEO2uHMDK6YrN3RQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLpF0hWSeepMaaNjIonrgUXTPUxvt37NAwdsmh2YysU=;
 b=Zz+4yCYNcbsZDMRESFvp5SkdW+IDTG4gxua2oe6ybhieonAOwBPEc8b/4dreCdsVce7kHNWghmpulJigf3NVeTy2EDdQn/zVTAgZkKUAiSdHvX4VrQcbsJebL+0Mcq8etrqwkhq9vPmPgv465/ik533hwTX8s5Up90bOQdsYK01vC+jxbJxVbe7fDp1Ti+tHvIpDkATH2VQkq8ARCrSwPxjw6IxFXliKMac2UATjutO2xwyDuAW03ffw9tETYtNdJD0hu2UPP3dE678FL7vcWdPezy73E/uaK+l9S48GvVrYCHcMEcY4BnK5UVp5Xt3jyc+D31ukSvqs9n6rU0Ws1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLpF0hWSeepMaaNjIonrgUXTPUxvt37NAwdsmh2YysU=;
 b=spVKRlzlT4mz/B8JdUiE5bm3GN+F/KNYixLCKMUr99BZuqbsMWKbX0v5zFw/I9/tVpLF4P4FCy7L21vzT1s/8oUeP60LVN8L6t9Q3g/2hunIcUWkYlDAsDYWxv/TU0TjZeaAYoZ9qwZSi07MRkh0hB6LGxY+z5SzcLbUerydX8A=
Received: from MN0P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::9)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 11:00:15 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::58) by MN0P223CA0015.outlook.office365.com
 (2603:10b6:208:52b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 11:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 11:00:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 06:00:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 06:00:12 -0500
Received: from shikangserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 06:00:10 -0500
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>
CC: <Christian.Koenig@amd.com>, <Philip.Yang@amd.com>,
 <Mario.Limonciello@amd.com>, <Srinivasan.Shanmugam@amd.com>,
 <Tiantian.Zhang@amd.com>, <Victor.Zhao@amd.com>, Shikang Fan
 <shikang.fan@amd.com>
Subject: [PATCH v3] drm/amdkfd: preserve VRAM MQD across hibernation via GTT
 eviction
Date: Wed, 29 Jul 2026 19:00:01 +0800
Message-ID: <20260729110001.46186-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: e84ae48b-271f-40c9-85de-08deed6091b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: Z+V/cm26tyqdnCU2Vew66CXISQCrihGIYfASYXdKUwvPmVCUFUoKYGYtb7JS1kmGAFc/ndhNUrJKpSw78DaMxcnTxEypVfPyVbqlAHj2O+JmFp4rpF+KJbyXWwuqzf2zAbXvuYclhyJkR8BHen7qvnXSSoOtTfbGmNKsBrcZ34P21cDxYqKmaI3C2TI1fvO+Y6hHodsuwtUPMEUjZQNSqMOQFCyrrJIdS4DsAuwxECbrdfHoLB88ScFnuNDufB3cH7TKMtv4mt2mWB9aiENuxV0acDMFQDa+JtFxKvbGDiYm/j7E08c/NAnmb3FgVMHWTZ4BpVl7AKxBJSab+hT2F5CBI/Z7FQACmdygb8LQI8Yg5Dm3Bgp6ou8gDxde7oEJ0HK+jFRvaAknejRtaiJqnAiLR1Ox6vScv/SVsaI4epN5Cu/vLM7d6dXPjHLmkvX4o5RFKy6LhpycXO+GkBReTTI7Xh6Qlz2+5UXNw4kygHx1HpmHM+facgm6TOxWpzLK1fOAUga1NRBaHo/pLBYDHvnucTmHsFqeQ1H9F0Q9iMpk55HYHWQEr72hZcqIS9GkFyquS/84U7giw0aTVsrzuLyoL1dALduk8s5Va76TzaaoSW7Rb2Q+gRyuR+RQcWmvISzCurrQjT5BO8buxOy3wGU2kZ0fNG6ifM4Rm4hMai0yHluPr+fc62Xyfsr9FBIvYds2zlwryn41zv41RNYYog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rOQxHsr3PpvjtIeduHe8dwr4p26Ar/vaNw8rC6SHlSXNqmA7DSGm5oQLTj5BlLXKTApA6lrGdYnt61EtxQLdOIaIFygUEatoGvw87xXTajZXv3yAMNoCMyJdsOMDKuBL7D4KcI1T3v3Okq4e7uCU42sLWamiiE95JjAVWjtyqr11cqGmm4D7XORMgfUjp3rp+0lVDKFlUKZL+XAr18+xkFrY3B3tQtsUs39/2wWkC65d19TYm390Qjj3k0YF5H36w+yrplBfBQFZTFEwr52hatQazq+naCmA5T93Wgx3qdNxma+/U3u5l2Ybl6KGRmN69Dk6oJD091oXHYzexQM7r/dlXpNKHveLbQgx4Y409kFAghswtIp18UwIxC+yP0fVolkwS1gcpfwcGm7t4QyUoua+mmOkWrEQtNIo5VfYOYAR6AvLeHVuCkmrDLR6Etgv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 11:00:14.9518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e84ae48b-271f-40c9-85de-08deed6091b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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

On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a pinned VRAM
buffer object (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction and
is not saved across S4 hibernation, so the MQD is garbage on resume and
the first submission faults (no-retry page fault, UTCL2/gfxhub0).

A bare unpin is not enough: amdgpu's eviction policy relocates the BO
within VRAM rather than to system memory, so its contents are still lost
when VRAM powers off. Instead, at suspend, unpin the MQD BO and move it to
GTT (ttm_bo_validate to GTT) while it is unpinned, so ttm_device_swapout()
captures it in the hibernation image. On resume, repin it to VRAM and
refresh the cached MQD GPU address (and kernel mapping) since the BO may
come back at a new location.

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 115 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |   8 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  40 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   6 +
 4 files changed, 169 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 51ee9c39104b..f4da27da0af7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1254,6 +1254,106 @@ static int resume_single_queue(struct device_queue_manager *dqm,
 	return 0;
 }
 
+/* The MQD of a gfx9 compute queue lives in a pinned VRAM buffer object when
+ * mqd_on_vram(). Pinned VRAM is skipped by TTM eviction, and a bare unpin only
+ * lets amdgpu relocate the BO within VRAM - whose contents are lost across S4
+ * hibernation. To have the MQD captured in the hibernation image, move the BO to
+ * GTT (system memory) while it is unpinned so ttm_device_swapout() snapshots it,
+ * then pin it back to VRAM on resume.
+ *
+ * dqm_evict_mqd_bo() runs at suspend, gated on adev->in_s4 so runtime eviction
+ * (where the pinned VRAM MQD stays intact) is untouched.
+ */
+static void dqm_evict_mqd_bo(struct device_queue_manager *dqm, struct queue *q)
+{
+	struct ttm_operation_ctx ctx = { false, false };
+	struct amdgpu_bo *bo;
+	int r;
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
+	bo = q->mqd_mem_obj->mem;
+	if (amdgpu_bo_reserve(bo, false))
+		return;
+
+	amdgpu_bo_unpin(bo);
+	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
+	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	amdgpu_bo_unreserve(bo);
+	if (r) {
+		dev_err(dqm->dev->adev->dev,
+			"Failed to evict MQD of queue %d to GTT: %d\n",
+			q->properties.queue_id, r);
+		return;
+	}
+	q->needs_mqd_repin = true;
+}
+
+/* Repin the MQD BO to VRAM on resume. Gated on the per-queue needs_mqd_repin flag
+ * rather than adev->in_s4, because in_s4 is cleared (PM_POST_HIBERNATION) partway
+ * through the KFD resume sequence and is unreliable here. The BO may come back at a
+ * new VRAM address, so refresh the cached copies (mqd_mem_obj->gpu_addr,
+ * q->gart_mqd_addr, the kernel mapping, and the self-address inside the MQD) before
+ * the queue is handed back to HW.
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
@@ -1297,6 +1397,8 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 			 * maintain a consistent eviction state
 			 */
 			ret = retval;
+
+		dqm_evict_mqd_bo(dqm, q);
 	}
 
 out:
@@ -1350,6 +1452,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 				goto out;
 			}
 		}
+
+		dqm_evict_mqd_bo(dqm, q);
 	}
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes) {
@@ -1429,6 +1533,10 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 		if (WARN_ONCE(!dqm->sched_running, "Restore when stopped\n"))
 			continue;
 
+		retval = dqm_repin_mqd_bo(dqm, q);
+		if (retval && !ret)
+			ret = retval;
+
 		retval = mqd_mgr->load_mqd(mqd_mgr, q->mqd, q->pipe,
 				       q->queue, &q->properties, mm);
 		if (retval && !ret)
@@ -1489,6 +1597,13 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
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
index 88191a4c1657..3d0ffcc91e3b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -637,6 +637,12 @@ struct queue {
 	void *gang_ctx_cpu_ptr;
 
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

