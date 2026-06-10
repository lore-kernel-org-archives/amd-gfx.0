Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B430CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 14:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B864D89DA9;
	Wed, 10 Jun 2026 14:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xkDM6ASW";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012062.outbound.protection.outlook.com
 [40.93.195.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A4D989DA9
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 14:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ov2Ysx7usHPLUw+1qnmIJNOfTcmEEyZGH2GzJ2Ozz8ziHsrwMyJAK4MrUIAGsooqsWozoT8Pc8ypJ8n9dCtAYxakE05iGJ1vIQrrqt8legQ0gru/P/3KWJMqSkg3rRBUgqjlsxccssn5CNfLhtxOr2Yt8L/fpK/f7z7fJyLs4KbuiEdnR6UJhwzNHG7Mjse//8hx4LYbgQpvhBnCLOgbfIGi/yifzOAlbsXitluMsTgm+/4iwgwweTJZNAr8xg7RZom6PWnavC1pGknnU9+ao2vYO8RB1rnkohA/1Mf8WJjVM0vrgz4CzXLgWn5k8adR8g/+KfjQh8nITQSUcF1u2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9e1mvYQvug81cKf0Nr5jWn3PRIwByeJbrRuPYk3Wsg4=;
 b=AVkY/lhtUp78sxcp30yq/3K/D1odQqt1zUR/cocNJoLYD3K0MzHmjjFe4VVWDXvThRHJNeV0XprMZyfT3ToxP9p2mX2y+gBN1EbantiC4BC6qUJiMAc+eBpqBPZtFwh0bZuTyj6EAi+7v38pxKTdTH95pA9TkhRxEEHEBuFPAu8PoPy/YSK/KKr8uypn+2QA0pFueoVbWy+diGIt5porvt5W/onZi5thOv6Qz4ganWZ72h87rS3X1HrmDsGQhTGXUuAPJ3xEmVVNVR6QAIbU/cS8Ir9ORzVRtxSfOscMTo2XkYtwiF156XdXas/tmG1jvm99Yk5do4TQnsjtfOrFVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9e1mvYQvug81cKf0Nr5jWn3PRIwByeJbrRuPYk3Wsg4=;
 b=xkDM6ASWRURL2+bgvX4MTTRXvyjitb4znO+qFoD59O995b09SUfa1Z+PIVjkAwt6Htphuf1RAWnAq1bWxbKqO+VNhsWYW4a+CoEBvkwjIpVTdHp0KQEPrrHeBfiCqfYEQ6oiL25AIha9XEiiBVttY2mWx+3l6g62FYbn5FmFmXc=
Received: from MW4PR04CA0204.namprd04.prod.outlook.com (2603:10b6:303:86::29)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 14:45:09 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::16) by MW4PR04CA0204.outlook.office365.com
 (2603:10b6:303:86::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 14:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 14:45:08 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 10 Jun 2026 09:36:56 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harish.kasiviswanathan@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH v3] drm/amdkfd: add sdma queue counter for gfxv9.4.3
Date: Wed, 10 Jun 2026 10:36:39 -0400
Message-ID: <20260610143639.59426-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9c54fc-ca15-40a4-1cde-08dec6fede6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|6133799003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: iK82L6wRa22yAArrzYA4TSYVCXSRy7O5IeR4rcHRMLmI4NWS1mTpDBKGlUFIhV92M3lbAOwZry88tO530pqY0YjJkeyPLu5e7+aOHLXUbPsCE4Jk6BjdiYhVc0ILPX5FzwJSfSGY5O8IAAAovwX5SXugibFs7qIOQRS1JHVXxisDDC55VQfjYtMm10PylDUWu8fW1Fym8PEapM17WGPe289cAxKmNv3gLoELPqh58l26HS4vCeD2mLPY2BL+9vfAb5v9vd1GjvuDjfna6gaSEMCZFzEz96bfxJSYlNWSpvLCdC2xL5sWT3sCuAALWGpvUc6st033/5rXocQuXWui8Dli2Blh3LM8pvaHRh8wZslbgOzGb+QsKTRWKND1jvoTAaCONY8pOU1nXZnYDQWTl+F+pakYDywhlYvv6Qm5Rh+u9pb3H8imXnkak9roOVHQzKRTMsVcR5jAKavDruko22xhbIPvPpUDLj4hMeBgJoxEaKWeLVah+cbmYBBYzMOTsK2oh/Jv6dJoooKzvkPpqOcZnfEEWqLHovOtwF0x63rTdfOpr5EoqHMGvZEmD6kgFXFNIfAlzcggirP/Fh8mGTLjq4w3aKb9VHrLmg2B+VezsLo0Au1g9n5js9NW8Tc8vMMwz0s+vJhrCjmqyRFw6LpkAEDZsqROlWU+u2xRPZfSZ5YM2ByBjr/UjtiYN+w3v6FhRP0mAE1pWXZ+wfLcfjsXqbSZYuxMbvApeo0XPc4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(6133799003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O5yD74MovmjLL8xZ7zj9VeQwtFnUlGz2ofxqbvT0pA3QIV8qAWTdaZJo+dUUh+yFHZ7TtPVr9hbyyG36CiFFgkVwGlGN8bXuBcq0zXQ92piFPNySAiBAner/eWCgUWyiqG6s3bv+/nkt1nIE5FbI6RV6B4FP+CxVi4vZQ5dNRJHc1CazgfZVZqvS47dSM4zgo116Siyhr4P4vWDxZAMshImw6b9rNzTeURnIZ0cPAVslc+yMk2uzirFy8tA3bi24YInMP7WPWzjFcIs30TD56bcxnU8MAlmTiPZ/y7PvvnPE5W/pEj8pWUW2USMaNK+5KP/DHasPAp+GlBTvzzcNfMmkfYJim3uTD6d4r7eNk0y3JB4abdafG8fIsLhxruLMTMznX/AAcsnORRRN392cnVlEAEXU1+C8F1aEiMUZH8GN1lp0Kfa6jRF0gGSvSfUA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 14:45:08.7292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9c54fc-ca15-40a4-1cde-08dec6fede6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140
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
index f46c59118304..24caf6061efa 100644
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
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 5) &&
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

