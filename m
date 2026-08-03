Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73144C5518F
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 10:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1032210E59D;
	Mon,  3 Aug 2026 10:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T9YrRmRs";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011001.outbound.protection.outlook.com
 [40.93.194.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B573D10E59D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 10:07:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2sh6TUTrS7KplAORbbv9SUtUe+xA6DtrWXCBufeuOOykAh6VRCJ1ZqVitQ3F3VQxDHAB1Obo9b65bJT6J62eOvA+Tkd7jknX06upScoxUT96o6zhJ6xes2tFqu9tM7zER6Q/CfbZF2kPIePkSSZ2RWRcEStHCRvzNRnnFzzGJhp4ZhJl8WAOAE6ciIB3zEkihEcrZjIT4mcEU8PF3cN4rpt5R5mH6zzNIXBrPaPhTYGLGaYqG6vpcwcT59pofTzqNL/cMeNw/0VGSDhYxh0DEkzXQjxsuoqB3jlkIwGcC07+3QYeUEZ9x7wAQQfhiET1r1cXy4r0TDNJ6sdmUihyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paCHYPTM4qhF40KDCWCVMgntA91edf0MNG000wFlrfs=;
 b=YI9fgtxXLTg0lqE3kAc9EJBKKU14Asg1APseBDuwsTwB5/pbsHldLWDGA/0r7ZTfOr8fz2t1fo4uQcyio3/aSOYSPaJndxYSJ+syqiINyk4klK0KUDyGjs+ffO07s6nc0aLWT4AKTOrdyCKXAD+utKA/MNH0+Usa1kIvFobEeOMIrBXEmkzGBSTQAcRrL/sLTMYxc/0XXbHEymdh5E+a2CRmwckWoAJUVSRIXevCK2EyoC8lFgJfNIqyYAxFIP7TITJTUASsMNN0gBSQhO0YPPBQNCwATrMSubNx9Gi22jGTCVBYfFx8hjsYSaIUIWL5HN2EFHuKgnW6UU/gvHlbBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paCHYPTM4qhF40KDCWCVMgntA91edf0MNG000wFlrfs=;
 b=T9YrRmRsfv6GeKskC0IMp3RJBivxBW9zipwDbs4AbP47gJ3u6TbhlnEE5HxYL88Tw0sDmq1SoloF3jYj5TmOxIbZefVd6Vre/MNtiATAaoS2L6HvBgQd1L/BLOmDfTdfcA48ZwPlEJa7M4IIq7naxzCXqoeC+pVWq84XEONTQCE=
Received: from SJ0PR13CA0072.namprd13.prod.outlook.com (2603:10b6:a03:2c4::17)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 10:07:06 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::79) by SJ0PR13CA0072.outlook.office365.com
 (2603:10b6:a03:2c4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.14 via Frontend Transport; Mon, 3
 Aug 2026 10:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 10:07:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 05:07:05 -0500
Received: from shikangserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 3 Aug 2026 05:07:02 -0500
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Philip.Yang@amd.com>, <Mario.Limonciello@amd.com>,
 <Srinivasan.Shanmugam@amd.com>, <Tiantian.Zhang@amd.com>,
 <Victor.Zhao@amd.com>, <Guoqing.Zhang@amd.com>, Shikang Fan
 <shikang.fan@amd.com>
Subject: [PATCH v4] drm/amdkfd: preserve VRAM MQD across hibernation via
 unpin/repin
Date: Mon, 3 Aug 2026 18:06:59 +0800
Message-ID: <20260803100659.469806-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 0275c72d-27a9-493a-d6c5-08def146f8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: I+qHoDtc/MTziy/xJ1nPTAkJkrFJy/rMhJFBMWTUGTFEvJ0As91hPMBKXcxRCt3v3LzE2qknEDP2vmT/1wEOuA8dludV9js9Tpc3HytSod7ld9nUOoxXnJBSFP/KLUGosTKbvbKrgYyLGfKjEegr6rUTBCB1zTriN8rpZIyen8UHJp5RlkvgttQH01cEhk3gQV+BBNC0TwyKGbIhqrk/ltgflGq0Xk2BcMcqMphkvaBVBOUmftCFXv3oYaonNaadsYZyYjx+Oqo3PeWKqeEbcX8F51xvv4WKqghMHjGzsWy/cQbberOFF1XOPV7QbWrxhSuJcgomTGyFocLpBYlFHuq4f6EGFsHt9orPoxVJ+z6UrzvnyEcECKYNJhZaMvuuGCS2rWMUNhfsJhu9qlGMfeY870hUdI8uJIunosBl05lE7EbM95hHvs5t1au9gBCYJPwwsznYF0GV3mHL3wcg0DJT0VJxdC1A0WZ6J7iFT4GbBG04CdvQdMIf2WLLFzNH6OCZnxHtLU5Jl0a4PXcs7NOjtC54AIRylLByM92qmAkmsdIY3yODyxsHU8nCpT8YZsLtEmHypXciGt76ugP81RbWAJCr0G74Dj9cP6Q+GFOkWG0SK+4bvbHJRTtDPwsO7NteBIpyB6YnuXhCKL98ETQxnH+FszJFxytR8i4njspVenmb97NxBMQJ6klzjA9wmS4uwKQUZwI+hKkqIgyT3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XaiGcL7V5Ny2ZC8l23SIPSRHl2p4sFy/vn0VZ2f9RRGg9y/D0LwtoQpCx/Kpe9CGufQzBsh7272r6D5veib6g+JCGRUC9BAY4nVB9I0lc/gUDC9jhYun9/Fb0DjseSgSbVmZK+X71fXjj2X7cZz3cLXcn1/wX2N8+0rj7qUbD+Bi+l31i1jcJBlqxOn9EOt1ds0p9chhs/7mS1W17cBBMjZt6k8KuNrBrIUEKKAvKrKadj7Xg5KXvf6dVKC7cUwILrcR97LLtl8D6zlJSFXEu3Oe8rlgCmNTJL5co0cvFSepK/w8xrUnXEslIXRJDJcpe2hdAaEBGfmu1I4WAza4JIRFJgPWuZm3FFOnmSYZcURQXfnIzwfJrUK9DC6idYPOJKphDAk7Xn7P6eDptLvyD9CP4VVnVh3ZkEhcEQYe1z3rAfW4Xs8A8zr225VFU+Bl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 10:07:05.5356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0275c72d-27a9-493a-d6c5-08def146f8b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
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

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 123 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |   8 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  40 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   6 +
 4 files changed, 177 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 51ee9c39104b..5ce4d4cb423c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -77,6 +77,7 @@ static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *
 static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
 			       struct qcm_process_device *qpd);
 static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q);
+static int dqm_repin_mqd_bo(struct device_queue_manager *dqm, struct queue *q);
 
 static inline
 enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
@@ -1048,6 +1049,11 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 				q->properties.queue_id);
 	}
 
+	/* Repin the MQD BO if it is still evicted for hibernation, before
+	 * destroy_queue_nocpsch_locked() dereferences q->mqd or it is freed.
+	 */
+	dqm_repin_mqd_bo(dqm, q);
+
 	dqm_lock(dqm);
 	retval = destroy_queue_nocpsch_locked(dqm, qpd, q);
 	if (!retval)
@@ -1254,6 +1260,98 @@ static int resume_single_queue(struct device_queue_manager *dqm,
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
@@ -1297,6 +1395,8 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 			 * maintain a consistent eviction state
 			 */
 			ret = retval;
+
+		dqm_evict_mqd_bo(dqm, q);
 	}
 
 out:
@@ -1350,6 +1450,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 				goto out;
 			}
 		}
+
+		dqm_evict_mqd_bo(dqm, q);
 	}
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes) {
@@ -1429,6 +1531,10 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 		if (WARN_ONCE(!dqm->sched_running, "Restore when stopped\n"))
 			continue;
 
+		retval = dqm_repin_mqd_bo(dqm, q);
+		if (retval && !ret)
+			ret = retval;
+
 		retval = mqd_mgr->load_mqd(mqd_mgr, q->mqd, q->pipe,
 				       q->queue, &q->properties, mm);
 		if (retval && !ret)
@@ -1489,6 +1595,13 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
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
@@ -2760,6 +2873,8 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 				qpd->pqm->process, q->device,
 				-1, false, NULL, 0);
 
+	/* Repin the MQD BO if still evicted for hibernation, before it is freed. */
+	dqm_repin_mqd_bo(dqm, q);
 	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
 
 	return retval;
@@ -2827,6 +2942,12 @@ static int process_termination_nocpsch(struct device_queue_manager *dqm,
 		q = list_first_entry(&qpd->queues_list, struct queue, list);
 		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 				q->properties.type)];
+		/* Repin the MQD BO before destroy_queue_nocpsch_locked()
+		 * dereferences q->mqd; drop the DQM lock as reserve may sleep.
+		 */
+		dqm_unlock(dqm);
+		dqm_repin_mqd_bo(dqm, q);
+		dqm_lock(dqm);
 		ret = destroy_queue_nocpsch_locked(dqm, qpd, q);
 		if (ret)
 			retval = ret;
@@ -3017,6 +3138,8 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
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
index bcb929002839..0dc4f76a36d4 100644
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

