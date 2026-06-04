Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B2ACD6E77
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 17:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00FCF11A21D;
	Thu,  4 Jun 2026 17:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3bIOo2GF";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DFB411A21D
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 17:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5nPS/fs2kMYmSlOZjoQe3IgHiuj3OXHDiRPJyDDI4oT1BG85IItUOkrTBrjaz4SRyJdSArzPcdat9r0KsQFgbvwuaL10G0pGOedTzLAxbq/9eDZRM66CU+b3My8VaBPUgPgxNhLY5P57/ow3gFKoNTP9+T9TAozKcjxF8Day5bUIOAUxpiBG6sWp3L0aXyQRlw/gwASA+/XKkJSbS9hDYA6pvJpJ9b7l0Cvklpfko1qspsoEL5gdFNX+g5mCgpuaxk/RIoCoDYn49IIxl4oAoofAOG50K2qPwenxhNF+mmW6kimiPZ4ZBnRs7ZxCXmJ1Vnwr4dNbVOQW7jQZIEs+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIDfsia2cCemXHRMiHgPfMXqbB1gSi2aGYcUC5l1+dA=;
 b=tqEBF63+PgbjoCRPDUQ0+TqbCjyW6ziiBABI4KEskJzF8dL7/o1/IDaFeCr4ExErQ/9hEc/HmhWU/kU2J5WO4F9gArVVBn68WLQ5mEj6Y9g+GQAi65gUpl+7tk/5zuZYrkLuQ+NaGuYVBaWKGKUZwoE9vT8BfDDrx1yuFEWunFQf9xsmXrOSNfBxNNa0C+BsC4f1cphLCu+Lb6hCinZnRttZQDmT+kz7wVsXQO5QJvpblTZJh/M1TAtKGIx4lB4JpROl6xvpQ8pnvnPd6lqXGhaU1CrwJ5sCWrkcVwsjXB7eVFEi8VmU/lsPWm5gJ8SxurBUeIbZZCB2PM88IlexWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIDfsia2cCemXHRMiHgPfMXqbB1gSi2aGYcUC5l1+dA=;
 b=3bIOo2GFsRPWg5F0Hvc9txfXgh1eQPBjX47MWU8qYasl9D2Lfen3Tk/+W583IBJkzWhmHLBn41MB8WDNEE3gJi/49s50M6qlA/x47+CX5GMdD3JmEdXdTOgCb3IQ0CD6AP8eM7qrdSqpcmZcDUUgPPK5c/bqTSz8+qksCu4YIFI=
Received: from BN0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:408:e6::18)
 by CH1PR12MB9717.namprd12.prod.outlook.com (2603:10b6:610:2b2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 17:45:44 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::d) by BN0PR03CA0013.outlook.office365.com
 (2603:10b6:408:e6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 17:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 17:45:43 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 4 Jun 2026 12:45:42 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH v2] drm/amdkfd: add sdma queue counter for gfxv9.4.3
Date: Thu, 4 Jun 2026 13:45:26 -0400
Message-ID: <20260604174526.131849-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|CH1PR12MB9717:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e875c9-6a43-452a-113f-08dec26119a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|6133799003|3023799007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: PgHmLc68gmT0PHgp+/Vm4rV40JclAsOwTOuKQlhrzA6Nx7I4sd8M3kyBJ2Kjj3+xnkwL84r7AC9jW4WYhJVR7DpI6hr9X/pJXFmmfEMlIT/YHaD6y5HZH8tLgAMFUCgTpmLLi5ufn12YZyiXAE8fBf+0kb1vlGWNyfz5R+THeK2a9q8+K4cOKjs7ZnSWnMaqH8I/fQYEazdH3lYmMXZulbyNMF9fTdIdKnevJxplxXehIX5QVvwnBgecpWp2Gr/TtAKAD4apGkyFUL2iWuTpFRGRyRjpLVdtd4eUbygjVU12EAnncS7jjTprkd37fKYix3HqO0oQwOlINTsjLTbb2xEHnohLvRD4hYaR5shJxZ3rWsj4kTt/sl35GpOvEXt1sDLfsanMnQlE71yOC7aFT9zG+4GNJBkrxqLAKzvpXva7iVqG/qDZY/1dP9pv+8TSaIdHOEnOw9UcrQreZlJFcn2M8mRbzOpmF4DXK1Zc6EPZ/k/SeHd7PDjer1Oc2mzcSMVS4zpmjtgt8bwUgohMXNnH6v9eKLF4WTXnJL8TkZH0ScXm7syCAi0P+eXfhsXefyBw3zYaD7Kj8eRQqxvW78GLrHh89MpZHMLLfXyvsvVujHAY2WJFEilfrj6elDTRZH/qd8f9xpdyM+MLp0ATTLEqmQzleL12iGOTFARzfMrwHmhBy0uc1BL5LDXc1ZZl2tXTXrsh+Q+kbzXIYVZKUGQt0pq9DPbTz8WP/h73i9k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(6133799003)(3023799007)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2whs7dZj6cVTqXXdyjAQM1biII4DuIOdF9PLG46sHPrghl+aEHv66YfvZK+R48vTVTljiFgllKpxoHoVt3HBt7Z2HXHqczEfh2K249FOhelhjoIJXoAHv3nuGpvABuEiHcgDufLqSdm46wHxBr0lhRe3Aj3Ynvc5Tky/Mckpm8K914Dktoa7+bVtRvZsAKztlVrKr6R0t1L0xydbnMN6UE/v5aOpRsh7ly3x8Z1IsJv1BsVxdi65dc8th3VSsG8uTCpWbNiuD8Uy9hFY0VHCMrNqQILA9kvxg9ccXLlFdHroarfBaMWiGTlJHxmiDbJFXMk8potEmWaf/6QcKIPwdNArNUdejhSSMWBiYJwwP1j4qavMR4yFYQYkLyVQqNR/avf1Kz7IZmsTtJEcdesfhzo8CLhKsMBqvj2F+BZPjfWtijtV5B2FSbEDo97OXW9Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 17:45:43.0499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e875c9-6a43-452a-113f-08dec26119a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9717
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

since gfx 9.4.3 HW is calculating accumulated activity counter
per-queue in register sdmax_rlcx_utilization_hi/lo, CPFW adds it in
sdma MQD for save/restore, KFD will read it from there. gfx 9.4.2
will still keep the way to read from memory at rptr+8.

v2: read dynamic counter directly from utilization register

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 51 ++++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 23 +++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 13 ++++-
 .../include/asic_reg/sdma/sdma_4_4_2_offset.h |  4 ++
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  2 +
 drivers/gpu/drm/amd/include/v9_structs.h      |  4 +-
 6 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index f46c59118304..16bad244c091 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -35,6 +35,8 @@
 #include "sdma/sdma_4_4_2_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+#define SDMA_QUEUES_NUM_PER_ENG	8
+
 static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
 {
 	return (struct v9_sdma_mqd *)mqd;
@@ -584,6 +586,52 @@ static uint32_t kgd_v9_4_3_ptl_ctrl(struct amdgpu_device *adev,
 			ptl_state, fmt1, fmt2);
 }
 
+static int kgd_gfx_v9_4_3_hqd_sdma_get_counter(struct amdgpu_device *adev,
+					void *mqd, uint64_t *val)
+{
+	struct v9_sdma_mqd *m = get_sdma_mqd(mqd);
+	uint32_t sdma_rlc_reg_offset;
+	uint32_t sdma_rlc_rb_cntl;
+	uint32_t engine_id, queue_id;
+	uint32_t engines = adev->sdma.num_instances;
+	uint32_t sdma_rlcx_rb_base, sdma_rlcx_rb_base_hi;
+	bool found = false;
+
+	if (!m)
+		return -EINVAL;
+
+	for (engine_id = 0; engine_id < engines && !found; engine_id++) {
+		for (queue_id = 0; queue_id < SDMA_QUEUES_NUM_PER_ENG; queue_id++) {
+			sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev,
+						engine_id, queue_id);
+			sdma_rlcx_rb_base = RREG32(sdma_rlc_reg_offset +
+						regSDMA_RLC0_RB_BASE);
+			sdma_rlcx_rb_base_hi = RREG32(sdma_rlc_reg_offset +
+						regSDMA_RLC0_RB_BASE_HI);
+
+			if (m->sdmax_rlcx_rb_base == sdma_rlcx_rb_base &&
+			    m->sdmax_rlcx_rb_base_hi == sdma_rlcx_rb_base_hi) {
+				found = true;
+				break;
+			}
+		}
+	}
+
+	sdma_rlc_rb_cntl = RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_CNTL);
+
+	/* Read sdma activity counter from utilization register
+	 * if hw queue is enabled, otherwise read from MQD.
+	 */
+	if (sdma_rlc_rb_cntl & SDMA_RLC0_RB_CNTL__RB_ENABLE_MASK)
+		*val = (uint64_t)RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_UTILIZATION_HI) << 32 |
+			RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_UTILIZATION_LO);
+	else
+		*val = (uint64_t)m->sdmax_rlcx_utilization_hi << 32 |
+			m->sdmax_rlcx_utilization_lo;
+
+	return 0;
+}
+
 const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
@@ -623,5 +671,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.trigger_pc_sample_trap = kgd_v9_4_3_trigger_pc_sample_trap,
 	.override_core_cg = kgd_gfx_v9_4_3_override_core_cg,
 	.setup_stoch_sampling = kgd_v9_4_3_setup_stoch_sampling,
-	.ptl_ctrl = kgd_v9_4_3_ptl_ctrl
+	.ptl_ctrl = kgd_v9_4_3_ptl_ctrl,
+	.hqd_sdma_get_counter = kgd_gfx_v9_4_3_hqd_sdma_get_counter
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b934863312d0..a65161659f74 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1067,8 +1067,15 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 	/* Get the SDMA queue stats */
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
 	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
-		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
-							&sdma_val);
+		if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
+			retval = read_sdma_queue_counter(
+					(uint64_t __user *)q->properties.read_ptr,
+					&sdma_val);
+		else
+			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
+				 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
+					dqm->dev->adev, q->mqd, &sdma_val) :
+				 0;
 		if (retval)
 			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
 				q->properties.queue_id);
@@ -2728,8 +2735,16 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	/* Get the SDMA queue stats */
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
 	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
-		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
-							&sdma_val);
+		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
+			retval = read_sdma_queue_counter(
+					(uint64_t __user *)q->properties.read_ptr,
+					&sdma_val);
+		else
+			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
+				 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
+					dqm->dev->adev, q->mqd, &sdma_val) :
+				 0;
+
 		if (retval)
 			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
 				q->properties.queue_id);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0be2fd04e6d0..911f974e6bf5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -95,6 +95,7 @@ struct kfd_sdma_activity_handler_workarea {
 
 struct temp_sdma_queue_list {
 	uint64_t __user *rptr;
+	void *mqd;
 	uint64_t sdma_val;
 	unsigned int queue_id;
 	struct list_head list;
@@ -165,6 +166,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 
 		INIT_LIST_HEAD(&sdma_q->list);
 		sdma_q->rptr = (uint64_t __user *)q->properties.read_ptr;
+		sdma_q->mqd = q->mqd;
 		sdma_q->queue_id = q->properties.queue_id;
 		list_add_tail(&sdma_q->list, &sdma_q_list.list);
 	}
@@ -193,7 +195,16 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 
 	list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
 		val = 0;
-		ret = read_sdma_queue_counter(sdma_q->rptr, &val);
+
+		if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
+			ret = read_sdma_queue_counter(sdma_q->rptr, &val);
+		else
+			ret = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
+			      dqm->dev->kfd2kgd->hqd_sdma_get_counter(
+					dqm->dev->adev,
+					sdma_q->mqd, &val) :
+			      0;
+
 		if (ret) {
 			pr_debug("Failed to read SDMA queue active counter for queue id: %d",
 				 sdma_q->queue_id);
diff --git a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
index ead81aeffd67..8700f8190c7c 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
@@ -493,6 +493,10 @@
 #define regSDMA_RLC0_MIDCMD_DATA10_BASE_IDX                                                             0
 #define regSDMA_RLC0_MIDCMD_CNTL                                                                        0x017b
 #define regSDMA_RLC0_MIDCMD_CNTL_BASE_IDX                                                               0
+#define regSDMA_RLC0_UTILIZATION_LO									0x017c
+#define regSDMA_RLC0_UTILIZATION_LO_BASE_IDX								0
+#define regSDMA_RLC0_UTILIZATION_HI									0x017d
+#define regSDMA_RLC0_UTILIZATION_HI_BASE_IDX								0
 #define regSDMA_RLC1_RB_CNTL                                                                            0x0188
 #define regSDMA_RLC1_RB_CNTL_BASE_IDX                                                                   0
 #define regSDMA_RLC1_RB_BASE                                                                            0x0189
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index d34c869b182f..f3220794c108 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -361,6 +361,8 @@ struct kfd2kgd_calls {
 			     uint32_t *ptl_state,
 			     enum amdgpu_ptl_fmt *fmt1,
 			     enum amdgpu_ptl_fmt *fmt2);
+	int (*hqd_sdma_get_counter)(struct amdgpu_device *adev,
+				    void *mqd, uint64_t *val);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
diff --git a/drivers/gpu/drm/amd/include/v9_structs.h b/drivers/gpu/drm/amd/include/v9_structs.h
index a2f81b9c38af..e0d387f08576 100644
--- a/drivers/gpu/drm/amd/include/v9_structs.h
+++ b/drivers/gpu/drm/amd/include/v9_structs.h
@@ -69,8 +69,8 @@ struct v9_sdma_mqd {
 	uint32_t sdmax_rlcx_midcmd_cntl;
 	uint32_t reserved_42;
 	uint32_t reserved_43;
-	uint32_t reserved_44;
-	uint32_t reserved_45;
+	uint32_t sdmax_rlcx_utilization_lo;
+	uint32_t sdmax_rlcx_utilization_hi;
 	uint32_t reserved_46;
 	uint32_t reserved_47;
 	uint32_t reserved_48;
-- 
2.34.1

