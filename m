Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C796CD8CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 14:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E375110E561;
	Wed, 10 Jun 2026 14:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gwmD2qlc";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3EAA10E561
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 14:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkfsUZ3ehIDZaebOdC1SkK0R2Tvk3rGUuDTs3QmLPZbt68uf8UlYwKvST2Q21TblevNC3y2wO8XvwWqEaKBb5akJmbpd/hhjHKeJoLTymiMG0w8HazO1foWaHvdVtjVuU3k8zKksEpdoNCTbuCqafMKJEJnWquR3e4tpaeus1DtOSNjvbWQsAVg2Pknx9x0QpdXjksYIDDg+BNUYHwnjKSofEj9L/wen5xZ1FJDphwi7n4kOmPAJ/lFgvJVkqyCOkNRyYePQZJMimsU4h4wUq72yYyKdWDW2kjgiAlrS9VC29VElT0ZBMxlX1KaOcgI4Er1SJSNNBATnV0m6a08+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1deqMKf+57DvhWKIc+h+8H3uTIWHnfjTjinHFUjVeGQ=;
 b=hMjpQtpO0XSGMdoEOisrIZ5ETobmfB/SFyJQUyuhpAnMmIy0b5YeyvJSh0Oed57tsAVNOg6yTD0XczawVyaExvHPBf4KuV75ttDjYd80ytKqGJ1cD/Y/4y7uwEXJ7+q8yODBhCvTpcZGBJUcPMR3ZxGtu+zJ+bORVrTtPCH20Q9SJ2THZ988dli65PgYMnUDHnuMJDNXX4C/HuqNrCpfnjCatfbmhTFbpoZ/Jo1rNO+EmP4cfX3BUblDgqM3j2NFRTJxgy5JhZtLdDyveFGHWnf8VEGFu8rvQX0RMgqBez/fr89TutmOowM0w18hvDJuCuqBlB+Hm1OOPIo4SgRcig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1deqMKf+57DvhWKIc+h+8H3uTIWHnfjTjinHFUjVeGQ=;
 b=gwmD2qlclt6OrT9yOCnbU242QYwZiOamcDmShEf1h2qsACACpjXSCY30nGLS94MsIv87aLYfa+JBeQgoNOQNLlx7nLvQsCPSFrcDlzN6REqlsoSgKeqSEjYmuYELAYu+nCcoaCUQuy0rk8emnENBxj68Tj6Ua/8xF7a8Z6un47g=
Received: from SJ0PR13CA0209.namprd13.prod.outlook.com (2603:10b6:a03:2c3::34)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 14:48:38 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::84) by SJ0PR13CA0209.outlook.office365.com
 (2603:10b6:a03:2c3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 14:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 14:48:36 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 10 Jun 2026 09:48:36 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH v3] drm/amdkfd: add sdma queue counter for gfxv9.4.3
Date: Wed, 10 Jun 2026 10:48:22 -0400
Message-ID: <20260610144822.65905-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ec08cb-5c7a-4cfc-bb8c-08dec6ff5a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|3023799007|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 0M2a5+EHXdwdu1vqtw2beLXjQdR6EqRy5LgtBaOdAH6xsQhTbQ1BvVZsLF1c8c51UeA1jA0MGsag5AxwzqdwV7F+7c830WbD+8qqu59AvJpd2CoADxlriX5I6Qel5CmvPyMaQ49AZHJgfKFVE/72+rCUSU5YVdskP6aPpbztHs0oC/vMKSecrNq0cv9pURRherAjspBa1tNt6O/U3tPE9JzZkEZj4OuJL2UdNuaXGxroy8Vn0GPzN0A6lPSYluEcjQsNSTTSIM6nTEouy2WR7/B1xkK6ShdLx5cDe4C4SR7/7EGB3ubUDN7Sd5FFfAD6bZ8MGC0Xsbk8oVQyoKGcpYKfddb8ldQ4n2jUbFX8CHvVP0A15hgNPqdGs6VC7bZC9ii9BwoBGxkd1tRrNf8niPYdoxV630BDToFF5yO9UvmXl66p9S8q3MsGXRTS8sdMrFNjY8Swj3vhvmOJ9t/Awvzo62CboGAgq2txBtQ/rMs8BkybUQSe8Uu/9QfrNzmbvqoSBKRaoMYG8aH+zTKgg2L/D8oXsUaUpQbRSopsCMJYqpdHw85VimaEdXjvR3vqoB2g8lCV6wBdtNNxCPm33ZscfNiibX4LuQIxt6kWkXJpaMTspy2RyshwI57TYXk2JqjN7BClXhxbZ4Wm27hZZxu2Lc1Xx0O0wRhWT7lD2QCYCVAtLAR5z/kM9TN7PP0asdYGxZVt6L0+Ih6DBRf0gAyYfp//UHoh7ejJBmEzuWI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(3023799007)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4fWFPSyan9COTmaZmgXjJlJzj7LdWJ628NvLqzbqhb1KL0epD1WfpSB8fUmPd6cY3QNzzMG94uj4++CaEc+T5APhOSC+N+j+pcLJ+6j5OqmnhEKGY/hzgoH7+x8FzyImRJ95YovAkuh25PRcUb1BcWO3Wk77dN/dLeGRHXg2PZFmeTKvzNDQwn8ET0M17SMqhISXVOClH+0jUTOWbv9wUtXAMOKkskG97MhQLLZ9Vayg0ngTKVbttjfnUzOet5D4ENpFmQbPsUel/h578yJN/ABNMxLyuT51N8Du6FKkZxrSEN/6FlpENkZEv3pxPxvGJRXxHCR+U0++qZ1rfRwcWAbm+GAYpluykmcnXrsYVBWUuCN48FfIbsh/Ahy78ZgAFfL3Y/UIwBscW+LC01ZstNY9rgQcvuST2l7RAuF113NItZ0Db6zvMKw2jJymLQ4I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 14:48:36.8692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ec08cb-5c7a-4cfc-bb8c-08dec6ff5a77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
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
v3: add CPFW supported version check (Harish)

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 67 ++++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 27 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 14 +++-
 .../include/asic_reg/sdma/sdma_4_4_2_offset.h |  4 ++
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  3 +
 drivers/gpu/drm/amd/include/v9_structs.h      |  4 +-
 6 files changed, 111 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index f46c59118304..a97398e7fc30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -584,6 +584,70 @@ static uint32_t kgd_v9_4_3_ptl_ctrl(struct amdgpu_device *adev,
 			ptl_state, fmt1, fmt2);
 }
 
+static int kgd_gfx_v9_4_3_hqd_sdma_get_counter(struct amdgpu_device *adev,
+					void *mqd, uint32_t num_sdma_queues_per_eng,
+					uint64_t *val)
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
+	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
+	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
+	    adev->gfx.mec_fw_version < 194) {
+		pr_warn_once("MEC FW doesn't support SDMA counter!\n");
+		return -ENOTSUPP;
+	}
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0) &&
+	    adev->gfx.mec_fw_version < 44) {
+		pr_warn_once("MEC FW doesn't support SDMA counter!\n");
+		return -ENOTSUPP;
+	}
+
+	/* SDMA doesn't support over-subscription, there must be
+	 * a HQD associated with a MQD, so found must be true in
+	 * the finding loop.
+	 */
+	for (engine_id = 0; engine_id < engines && !found; engine_id++) {
+		for (queue_id = 0; queue_id < num_sdma_queues_per_eng; queue_id++) {
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
@@ -623,5 +687,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.trigger_pc_sample_trap = kgd_v9_4_3_trigger_pc_sample_trap,
 	.override_core_cg = kgd_gfx_v9_4_3_override_core_cg,
 	.setup_stoch_sampling = kgd_v9_4_3_setup_stoch_sampling,
-	.ptl_ctrl = kgd_v9_4_3_ptl_ctrl
+	.ptl_ctrl = kgd_v9_4_3_ptl_ctrl,
+	.hqd_sdma_get_counter = kgd_gfx_v9_4_3_hqd_sdma_get_counter
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b934863312d0..2b9177427058 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1067,8 +1067,17 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
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
+					dqm->dev->adev, q->mqd,
+					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
+					&sdma_val) :
+				 -ENOTSUPP;
 		if (retval)
 			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
 				q->properties.queue_id);
@@ -2728,8 +2737,18 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
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
+					dqm->dev->adev, q->mqd,
+					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
+					&sdma_val) :
+				 -ENOTSUPP;
+
 		if (retval)
 			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
 				q->properties.queue_id);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0be2fd04e6d0..d17f064ea7b9 100644
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
@@ -193,7 +195,17 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 
 	list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
 		val = 0;
-		ret = read_sdma_queue_counter(sdma_q->rptr, &val);
+
+		if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
+			ret = read_sdma_queue_counter(sdma_q->rptr, &val);
+		else
+			ret = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
+			      dqm->dev->kfd2kgd->hqd_sdma_get_counter(
+					dqm->dev->adev,	sdma_q->mqd,
+					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
+					&val) :
+			      -ENOTSUPP;
+
 		if (ret) {
 			pr_debug("Failed to read SDMA queue active counter for queue id: %d",
 				 sdma_q->queue_id);
diff --git a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
index ead81aeffd67..11c32e4274fa 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
@@ -493,6 +493,10 @@
 #define regSDMA_RLC0_MIDCMD_DATA10_BASE_IDX                                                             0
 #define regSDMA_RLC0_MIDCMD_CNTL                                                                        0x017b
 #define regSDMA_RLC0_MIDCMD_CNTL_BASE_IDX                                                               0
+#define regSDMA_RLC0_UTILIZATION_LO                                                                     0x017c
+#define regSDMA_RLC0_UTILIZATION_LO_BASE_IDX                                                            0
+#define regSDMA_RLC0_UTILIZATION_HI                                                                     0x017d
+#define regSDMA_RLC0_UTILIZATION_HI_BASE_IDX                                                            0
 #define regSDMA_RLC1_RB_CNTL                                                                            0x0188
 #define regSDMA_RLC1_RB_CNTL_BASE_IDX                                                                   0
 #define regSDMA_RLC1_RB_BASE                                                                            0x0189
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index d34c869b182f..2c91242caadc 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -361,6 +361,9 @@ struct kfd2kgd_calls {
 			     uint32_t *ptl_state,
 			     enum amdgpu_ptl_fmt *fmt1,
 			     enum amdgpu_ptl_fmt *fmt2);
+	int (*hqd_sdma_get_counter)(struct amdgpu_device *adev,
+				    void *mqd, uint32_t num_sdma_queues_per_eng,
+				    uint64_t *val);
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

