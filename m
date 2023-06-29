Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C02EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 16:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC80710E037;
	Thu, 29 Jun 2023 16:34:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22DFC10E037
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 16:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEkCqrQ1XnSqUtp9XgNhnmUhh9bSBkP8ymDHiDTJ9Qr2M+fvpPfe51xjlu2XDpG3gbIk+ajBuDYblZi2clzzi9dtT80knGXfd9DgQ9cU/ZqSAT/3jut2wJZmUrkMko0EYqUjxngW/ameyE2Ils1t/HCccZtDEjQGzQhqpTcB+QzEZaubT+yTJlZaSv1SXt9fBl6ErWgjRoid1k6PLsVLf3GKx9n+rj3t2dynBXiyc5Pd5QX7hRLomQ4VY/8+f/XOuLtM39IgsQYUbvPsVOGEx6gaC3dfFOgcxQUYW57I/ffc7lhAr8buSmS3aQWbURvlNqqG8C9LMeF0GR3ZJzk/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26os+ES2JKjsPM+46/kgxJVVL/KqlJtXgAfo7qWSsR8=;
 b=f+JN3JpTfUsG0AlLe/jQLEhL7KvLc/wAovIyPKBppk8cQNCrTdX09gTk/UUm0Qr2UIU3OoyQZt21D4s7cyMqK+wOBTMBjasvCK/XNL2IkTQxw5Px1j57L6Tun4PXsrKTTvhH4vtLI3BNko86hCfEMjjGfG1SgZtQ59QpIdNee4uTxQbd8LAtAcC1EAcrpxCRZvaoPbjmrWSD2OiRFujDNGqDu/VSmpsQmgjRQBJ3b4BxI4+PllWpdP8Y78AiWsLBpBsGq5gqzQJvJIoI9qQM2f25UH8mCvJwYJJMl9DNl0sYeY6/oggeb6/GzckU5nvyqRIyyxgjySdizAzqz8u00A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26os+ES2JKjsPM+46/kgxJVVL/KqlJtXgAfo7qWSsR8=;
 b=sE0bTRqta4/Cs6uKWWK0DpFUBpbBesOr1l9WO3375/jzaLwvX6OxEy28E/yFB68B8Yyy/LwyK/nz+oWwxL81cgpoNAS6R4HKmkFIjIjnDWrbQedvBxx5RkyZ+zBnRyNYdTKgr+ndMn2erCaSQ44eUTRm+V5LZc5MAK78Hn5RDfY=
Received: from MW4PR03CA0176.namprd03.prod.outlook.com (2603:10b6:303:8d::31)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 16:34:46 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::1e) by MW4PR03CA0176.outlook.office365.com
 (2603:10b6:303:8d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 16:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 16:34:45 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 11:34:44 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv2] drm/amdkfd: Use KIQ to unmap HIQ
Date: Thu, 29 Jun 2023 12:34:30 -0400
Message-ID: <20230629163430.2031529-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae593bc-310f-4f9f-6282-08db78bebfa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCffYfpIfw6x+c7yAslaQwrn99aXO2wTNGIZbTprLz1IWGt+8d0aNfBeQc5b7kZZNKucTKU/zUCpILf9VBTS0SIZAsZcgv5pm8Fv2jL2sVyr4g9wZtQcwcMaSDSJvBFodt7P0JrLEqKB9Gvyy4TvsfWILdODnEV4oU7oXYLqwVCpUnThzynJg7kxmNjEXO6mchGlsNjd+ORCESe7GL3ToAN+w1BxIm8UCzTkoHMMpcbvSFm0Nu/KcLmwYx8c59ujnHhshkR6C2N3ZHBJU3coN5B2rXHcnqulKo/LXsrTSj1PDWb4Ekw+4fnI86YoS8yNjU7QmJ8RnGw6pE/Gh84sP317JAu0Rjtw0cJzMGhduZpeWFyG3NOaoaW1sedZL0/AakrYzW0in9vj4p0P4BLD27faTgUPCFWvX3o5exTEGytvnO5jW8bKk5mhGiL7V8I0nwtCwnFY9zeSbW9iBSfRP2djFw1JFVHagu/sYSoK9EKURqGBkfa18rmTwIhDmjfsWFLgTNTl2mgQEWx7DuR+gwZQ3/XdOnA8KJsZewW5ttRrEZqjWA1Ef0W1X5kvH5p336emG/oD0XG1+Yv/JuSlIrCFKNeFPBz7cF+KiXStxWSXYGLQlT7+mYoOZmbBv/iQpR+TuLG+k8D59S9B2luQIn/s6B9us8swTGPy6TGBws53i+LK0LxotUs/TTnn1fwkv0zGoz18sHbSWTEJLQA/kEjpeTtMKCfd1FbASVulnrzjnLu8iucXLeLf7noy7uwdOhRxORjmxstIDykgqqz7kQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(26005)(2906002)(86362001)(356005)(6666004)(82310400005)(7696005)(83380400001)(2616005)(81166007)(16526019)(186003)(47076005)(336012)(426003)(82740400003)(36860700001)(40460700003)(54906003)(41300700001)(40480700001)(4326008)(478600001)(36756003)(70586007)(316002)(6916009)(70206006)(1076003)(5660300002)(44832011)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 16:34:45.5704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae593bc-310f-4f9f-6282-08db78bebfa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476
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
Cc: amber.lin@amd.com, Mukul Joshi <mukul.joshi@amd.com>,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently, we unmap HIQ by directly writing to HQD
registers. This doesn't work for GFX9.4.3. Instead,
use KIQ to unmap HIQ, similar to how we use KIQ to
map HIQ. Using KIQ to unmap HIQ works for all GFX
series post GFXv9.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Use kiq_unmap_queues function instead of duplicating
  code (Felix).

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 36 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 22 +++++++++++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 22 +++++++++++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 36 +++++++++++++++----
 5 files changed, 109 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index b4fcad0e62f7..0040c63e2356 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -830,3 +830,39 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
 		return adev->gmc.real_vram_size;
 	}
 }
+
+int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
+			    u32 inst)
+{
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	struct amdgpu_ring_funcs ring_funcs;
+	struct amdgpu_ring ring;
+	int r = 0;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+		return -EINVAL;
+
+	memset(&ring, 0x0, sizeof(struct amdgpu_ring));
+	memset(&ring_funcs, 0x0, sizeof(struct amdgpu_ring_funcs));
+
+	ring_funcs.type = AMDGPU_RING_TYPE_COMPUTE;
+	ring.doorbell_index = doorbell_off;
+	ring.funcs = &ring_funcs;
+
+	spin_lock(&kiq->ring_lock);
+
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
+		spin_unlock(&kiq->ring_lock);
+		return -ENOMEM;
+	}
+
+	kiq->pmf->kiq_unmap_queues(kiq_ring, &ring, RESET_QUEUES, 0, 0);
+
+	if (kiq_ring->sched.ready && !adev->job_hang)
+		r = amdgpu_ring_test_helper(kiq_ring);
+
+	spin_unlock(&kiq->ring_lock);
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 2d0406bff84e..b34418e3e006 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -252,6 +252,8 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
 int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min);
 int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
 					uint32_t *payload);
+int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
+				u32 inst);
 
 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 94c0fc2e57b7..83699392c808 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -318,6 +318,26 @@ static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 			1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
 }
 
+static int destroy_hiq_mqd(struct mqd_manager *mm, void *mqd,
+			enum kfd_preempt_type type, unsigned int timeout,
+			uint32_t pipe_id, uint32_t queue_id)
+{
+	int err;
+	struct v10_compute_mqd *m;
+	u32 doorbell_off;
+
+	m = get_mqd(mqd);
+
+	doorbell_off = m->cp_hqd_pq_doorbell_control >>
+			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+
+	err = amdgpu_amdkfd_unmap_hiq(mm->dev->adev, doorbell_off, 0);
+	if (err)
+		pr_debug("Destroy HIQ MQD failed: %d\n", err);
+
+	return err;
+}
+
 static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 		struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 		struct queue_properties *q)
@@ -460,7 +480,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
 		mqd->free_mqd = free_mqd_hiq_sdma;
 		mqd->load_mqd = kfd_hiq_load_mqd_kiq;
 		mqd->update_mqd = update_mqd;
-		mqd->destroy_mqd = kfd_destroy_mqd_cp;
+		mqd->destroy_mqd = destroy_hiq_mqd;
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v10_compute_mqd);
 		mqd->mqd_stride = kfd_mqd_stride;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 31fec5e70d13..2319467d2d95 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -335,6 +335,26 @@ static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 			1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
 }
 
+static int destroy_hiq_mqd(struct mqd_manager *mm, void *mqd,
+			enum kfd_preempt_type type, unsigned int timeout,
+			uint32_t pipe_id, uint32_t queue_id)
+{
+	int err;
+	struct v11_compute_mqd *m;
+	u32 doorbell_off;
+
+	m = get_mqd(mqd);
+
+	doorbell_off = m->cp_hqd_pq_doorbell_control >>
+			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+
+	err = amdgpu_amdkfd_unmap_hiq(mm->dev->adev, doorbell_off, 0);
+	if (err)
+		pr_debug("Destroy HIQ MQD failed: %d\n", err);
+
+	return err;
+}
+
 static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 		struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 		struct queue_properties *q)
@@ -449,7 +469,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
 		mqd->free_mqd = free_mqd_hiq_sdma;
 		mqd->load_mqd = kfd_hiq_load_mqd_kiq;
 		mqd->update_mqd = update_mqd;
-		mqd->destroy_mqd = kfd_destroy_mqd_cp;
+		mqd->destroy_mqd = destroy_hiq_mqd;
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v11_compute_mqd);
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 601bb9f68048..e23d32f35607 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -405,6 +405,25 @@ static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 			1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
 }
 
+static int destroy_hiq_mqd(struct mqd_manager *mm, void *mqd,
+			enum kfd_preempt_type type, unsigned int timeout,
+			uint32_t pipe_id, uint32_t queue_id)
+{
+	int err;
+	struct v9_mqd *m;
+	u32 doorbell_off;
+
+	m = get_mqd(mqd);
+
+	doorbell_off = m->cp_hqd_pq_doorbell_control >>
+			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	err = amdgpu_amdkfd_unmap_hiq(mm->dev->adev, doorbell_off, 0);
+	if (err)
+		pr_debug("Destroy HIQ MQD failed: %d\n", err);
+
+	return err;
+}
+
 static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 		struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 		struct queue_properties *q)
@@ -548,16 +567,19 @@ static int destroy_hiq_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 {
 	uint32_t xcc_mask = mm->dev->xcc_mask;
 	int xcc_id, err, inst = 0;
-	void *xcc_mqd;
 	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
+	struct v9_mqd *m;
+	u32 doorbell_off;
 
 	for_each_inst(xcc_id, xcc_mask) {
-		xcc_mqd = mqd + hiq_mqd_size * inst;
-		err = mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, xcc_mqd,
-						    type, timeout, pipe_id,
-						    queue_id, xcc_id);
+		m = get_mqd(mqd + hiq_mqd_size * inst);
+
+		doorbell_off = m->cp_hqd_pq_doorbell_control >>
+				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+
+		err = amdgpu_amdkfd_unmap_hiq(mm->dev->adev, doorbell_off, xcc_id);
 		if (err) {
-			pr_debug("Destroy MQD failed for xcc: %d\n", inst);
+			pr_debug("Destroy HIQ MQD failed for xcc: %d\n", inst);
 			break;
 		}
 		++inst;
@@ -846,7 +868,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		} else {
 			mqd->init_mqd = init_mqd_hiq;
 			mqd->load_mqd = kfd_hiq_load_mqd_kiq;
-			mqd->destroy_mqd = kfd_destroy_mqd_cp;
+			mqd->destroy_mqd = destroy_hiq_mqd;
 		}
 		break;
 	case KFD_MQD_TYPE_DIQ:
-- 
2.35.1

