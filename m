Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A74EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 18:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0363710E111;
	Fri, 16 Jun 2023 18:00:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9780B10E111
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 18:00:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgGPMx3rlM7eXRMnCJOiaJhZHBkSmmb8sYhRFPPImyvhUxcKErwUCKSCed7tJmFBQT0G9JqIFrKtvKE6kstPTTbczU8lW3LLvTXouIju7pkIgrV9yoAJKpjR2Jd96+md9xDqDJgr+DutXI6PbichSpu86mF0L95swOst5znQuEPnE6onLuLTe7vWKiNxgCM0k99YYJ/YgS6NrbnVD48DgsMbeQ1Lj+oqF+x1P8c12SqmrrMngLp+/Hn3QLR7mFS94Vc1rC5vGG4EVhlAFz3SHbwxSdnk42yQR/Oap5qmoW0D1DmlRcN6PHzZsX0E5zi1IbOU8baVTvZyore7Wkf9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnvmi2Vp6p6JVHASNd1WB7piTMLDGlZQHtkYz01hSWw=;
 b=fs7gE3w6svTkLwmZlV9QcaI2+ApJcEaTo4sF1+HWfuz8RSRRGSj/7wVDqYa8awaMhjKbqBk/XKBhOR5fQH6xdpfU4x0WpfWzuU4Eq/79+MPK9O/rlQrBqqKSa9144Z2UsC30+AvRDxfNEotD8PA++oeuqx0iu7jRHNT6OzdEWDT8H3flK8SW1s6n/g20v7HmIrPSxzvqHeMU2ef0LYh+sN36OObWcxxKJVBOGKtrasMCRN+7TOaTSOJ/RGz9XwwT/axRhun5PS4sn1q/3ptO7VGTPhEZjD6GbfoUMKFw+SYYzKAoQMXpArx8yXRFKEL7gZX7jTXnxvALZ5BApwxObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnvmi2Vp6p6JVHASNd1WB7piTMLDGlZQHtkYz01hSWw=;
 b=AeR9588Wmwh0dpICovoqw14IIHecKvMh7rldFRdyiVrptSe4I5v5ZqPq9VUszg2Z7Ia4uemdipV7B5Y//hQT0bZADPYkIw15JQolV2DwTGaH0LBimEBgGap+ryEW/zIU6axs2pJV8Q4DHKYFrGvrNKCiMG0h+kGPZ7SGLz8Hs4w=
Received: from SA1PR04CA0011.namprd04.prod.outlook.com (2603:10b6:806:2ce::18)
 by CY5PR12MB6035.namprd12.prod.outlook.com (2603:10b6:930:2d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 18:00:46 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::86) by SA1PR04CA0011.outlook.office365.com
 (2603:10b6:806:2ce::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Fri, 16 Jun 2023 18:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Fri, 16 Jun 2023 18:00:46 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 13:00:45 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Use KIQ to unmap HIQ
Date: Fri, 16 Jun 2023 14:00:30 -0400
Message-ID: <20230616180030.1270267-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CY5PR12MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb62ce6-8cce-47a2-3c5f-08db6e939c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWFby339DKiL0hd3fdk+lNWYlBKZH+W/gO83hZxM+VgQLuisTl7XoDrZNYZM6N0OBIsQ41Egqidk2dKMyaOQ5DNSA1L4iL0oyBbfY0zt8NhZSqO9OZjI6fZAEfiWGdMQovr/8TuOns5xcyx6pVs7wlzRNvI+lrPTYpan3NgCtq2Zlsd34N7CuZgoH8qtE+BiTc0raF3T0aV3Me4Xw2oUchtP9uz3NyeitA07Mg3cK1MMKUp6Q8PKtv/Y3J4GFdUbougThhlaFzqynkBxZvFGeVjkhDRzetgIssddDjPtLFsbmI5VIV93xXYIkMtVJp1p8ggITAKzqihtUY+WraPy7dxvEIHbfwEMjuiRfokZ8odJ09DfVQJoiu8pCfSHDnwaL5wT1OdM55hVZl+ogOck+oTcfVEqF5nE9P8qHa5bHaixLYyhKV/C8jL1hmuVg2QqWjaK8jmKabb/ydE6XNAFStDKvWyuhMJRlS4n7um0G6JnFZDV4gmUJN4lo/yC2f90MWBAOztgzaRcMFKsBskkeLo5u6nNvea62pR0FzpVkNHF5NiJO2741Ek+Zn/JevGqdIUGB9OGHbin3AExe63RrzM2CZ97z0fZ9UHJqukvhaQxJNGQpIzX3LS0a97qfvqRLk29Q80T2jEhHS9F5t8U3EKaDlgL490yVI5M5zNuLac8dK5W0DchWDcmnhfWMjRbu8tRk0cvkDBwDquBUzWh1Xgi76ZhRrXehIjg/OYUnVS0bXtLhT8ccdaFACvHWmkE0sOiF9f1v1qL0aBDj9/eog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(2906002)(186003)(16526019)(30864003)(26005)(36860700001)(47076005)(2616005)(40480700001)(40460700003)(6916009)(336012)(83380400001)(426003)(70206006)(70586007)(356005)(81166007)(4326008)(82740400003)(41300700001)(7696005)(8936002)(8676002)(6666004)(316002)(54906003)(82310400005)(86362001)(36756003)(478600001)(44832011)(1076003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 18:00:46.1890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb62ce6-8cce-47a2-3c5f-08db6e939c2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6035
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently, we unmap HIQ by directly writing to HQD
registers. This doesn't work for GFX9.4.3. Instead,
use KIQ to unmap HIQ, similar to how we use KIQ to
map HIQ. Using KIQ to unmap HIQ works for all GFX
series post GFXv9.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  1 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 47 ++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  3 ++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  1 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    | 47 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 48 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  3 ++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  8 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  4 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  7 ++-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  3 ++
 13 files changed, 170 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 5b4b7f8b92a5..b82435e17ed0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -372,6 +372,7 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.hqd_sdma_dump = kgd_gfx_v9_4_3_hqd_sdma_dump,
 	.hqd_is_occupied = kgd_gfx_v9_hqd_is_occupied,
 	.hqd_sdma_is_occupied = kgd_gfx_v9_4_3_hqd_sdma_is_occupied,
+	.hiq_hqd_destroy = kgd_gfx_v9_hiq_hqd_destroy,
 	.hqd_destroy = kgd_gfx_v9_hqd_destroy,
 	.hqd_sdma_destroy = kgd_gfx_v9_4_3_hqd_sdma_destroy,
 	.wave_control_execute = kgd_gfx_v9_wave_control_execute,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 8ad7a7779e14..a919fb8e09a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -510,6 +510,52 @@ static bool kgd_hqd_sdma_is_occupied(struct amdgpu_device *adev, void *mqd)
 	return false;
 }
 
+int kgd_gfx_v10_hiq_hqd_destroy(struct amdgpu_device *adev, void *mqd,
+				uint32_t pipe_id, uint32_t queue_id,
+				uint32_t inst)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
+	struct v10_compute_mqd *m = get_mqd(mqd);
+	uint32_t mec, pipe;
+	uint32_t doorbell_off;
+	int r;
+
+	doorbell_off = m->cp_hqd_pq_doorbell_control >>
+			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+
+	acquire_queue(adev, pipe_id, queue_id);
+
+	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
+	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
+
+	spin_lock(&adev->gfx.kiq[0].ring_lock);
+	r = amdgpu_ring_alloc(kiq_ring, 6);
+	if (r) {
+		pr_err("Failed to alloc KIQ (%d).\n", r);
+		goto out_unlock;
+	}
+
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
+	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
+			  PACKET3_UNMAP_QUEUES_ACTION(0) |
+			  PACKET3_UNMAP_QUEUES_QUEUE_SEL(0) |
+			  PACKET3_UNMAP_QUEUES_ENGINE_SEL(0) |
+			  PACKET3_UNMAP_QUEUES_NUM_QUEUES(1));
+	amdgpu_ring_write(kiq_ring,
+			  PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(doorbell_off));
+	amdgpu_ring_write(kiq_ring, 0);
+	amdgpu_ring_write(kiq_ring, 0);
+	amdgpu_ring_write(kiq_ring, 0);
+
+	amdgpu_ring_commit(kiq_ring);
+
+out_unlock:
+	spin_unlock(&adev->gfx.kiq[0].ring_lock);
+	release_queue(adev);
+
+	return r;
+}
+
 static int kgd_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
@@ -1034,6 +1080,7 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.hqd_sdma_dump = kgd_hqd_sdma_dump,
 	.hqd_is_occupied = kgd_hqd_is_occupied,
 	.hqd_sdma_is_occupied = kgd_hqd_sdma_is_occupied,
+	.hiq_hqd_destroy = kgd_gfx_v10_hiq_hqd_destroy,
 	.hqd_destroy = kgd_hqd_destroy,
 	.hqd_sdma_destroy = kgd_hqd_sdma_destroy,
 	.wave_control_execute = kgd_wave_control_execute,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index e6b70196071a..00b4514ebdd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -53,3 +53,6 @@ void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t grace_period,
 					       uint32_t *reg_offset,
 					       uint32_t *reg_data);
+int kgd_gfx_v10_hiq_hqd_destroy(struct amdgpu_device *adev, void *mqd,
+				uint32_t pipe_id, uint32_t queue_id,
+				uint32_t inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 8c8437a4383f..98b3a8cdc2c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -666,6 +666,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.hqd_sdma_dump = hqd_sdma_dump_v10_3,
 	.hqd_is_occupied = hqd_is_occupied_v10_3,
 	.hqd_sdma_is_occupied = hqd_sdma_is_occupied_v10_3,
+	.hiq_hqd_destroy = kgd_gfx_v10_hiq_hqd_destroy,
 	.hqd_destroy = hqd_destroy_v10_3,
 	.hqd_sdma_destroy = hqd_sdma_destroy_v10_3,
 	.wave_control_execute = wave_control_execute_v10_3,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 91c3574ebed3..d0ef32ec76df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -485,6 +485,52 @@ static bool hqd_sdma_is_occupied_v11(struct amdgpu_device *adev, void *mqd)
 	return false;
 }
 
+int hiq_hqd_destroy_v11(struct amdgpu_device *adev, void *mqd,
+			uint32_t pipe_id, uint32_t queue_id,
+			uint32_t inst)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
+	struct v11_compute_mqd *m = get_mqd(mqd);
+	uint32_t mec, pipe;
+	uint32_t doorbell_off;
+	int r;
+
+	doorbell_off = m->cp_hqd_pq_doorbell_control >>
+			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+
+	acquire_queue(adev, pipe_id, queue_id);
+
+	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
+	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
+
+	spin_lock(&adev->gfx.kiq[0].ring_lock);
+	r = amdgpu_ring_alloc(kiq_ring, 6);
+	if (r) {
+		pr_err("Failed to alloc KIQ (%d).\n", r);
+		goto out_unlock;
+	}
+
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
+	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
+			  PACKET3_UNMAP_QUEUES_ACTION(0) |
+			  PACKET3_UNMAP_QUEUES_QUEUE_SEL(0) |
+			  PACKET3_UNMAP_QUEUES_ENGINE_SEL(0) |
+			  PACKET3_UNMAP_QUEUES_NUM_QUEUES(1));
+	amdgpu_ring_write(kiq_ring,
+			  PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(doorbell_off));
+	amdgpu_ring_write(kiq_ring, 0);
+	amdgpu_ring_write(kiq_ring, 0);
+	amdgpu_ring_write(kiq_ring, 0);
+
+	amdgpu_ring_commit(kiq_ring);
+
+out_unlock:
+	spin_unlock(&adev->gfx.kiq[0].ring_lock);
+	release_queue(adev);
+
+	return r;
+}
+
 static int hqd_destroy_v11(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
@@ -796,6 +842,7 @@ const struct kfd2kgd_calls gfx_v11_kfd2kgd = {
 	.hqd_sdma_dump = hqd_sdma_dump_v11,
 	.hqd_is_occupied = hqd_is_occupied_v11,
 	.hqd_sdma_is_occupied = hqd_sdma_is_occupied_v11,
+	.hiq_hqd_destroy = hiq_hqd_destroy_v11,
 	.hqd_destroy = hqd_destroy_v11,
 	.hqd_sdma_destroy = hqd_sdma_destroy_v11,
 	.wave_control_execute = wave_control_execute_v11,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 51d93fb13ea3..c1708de38b33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -523,6 +523,53 @@ static bool kgd_hqd_sdma_is_occupied(struct amdgpu_device *adev, void *mqd)
 	return false;
 }
 
+int kgd_gfx_v9_hiq_hqd_destroy(struct amdgpu_device *adev, void *mqd,
+				uint32_t pipe_id, uint32_t queue_id,
+				uint32_t inst)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[inst].ring;
+	struct v9_mqd *m;
+	uint32_t mec, pipe;
+	uint32_t doorbell_off;
+	int r;
+
+	m = get_mqd(mqd);
+	doorbell_off = m->cp_hqd_pq_doorbell_control >>
+			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
+
+	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
+	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
+
+	spin_lock(&adev->gfx.kiq[inst].ring_lock);
+	r = amdgpu_ring_alloc(kiq_ring, 6);
+	if (r) {
+		pr_err("Failed to alloc KIQ (%d).\n", r);
+		goto out_unlock;
+	}
+
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
+	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
+			  PACKET3_UNMAP_QUEUES_ACTION(0) |
+			  PACKET3_UNMAP_QUEUES_QUEUE_SEL(0) |
+			  PACKET3_UNMAP_QUEUES_ENGINE_SEL(0) |
+			  PACKET3_UNMAP_QUEUES_NUM_QUEUES(1));
+	amdgpu_ring_write(kiq_ring,
+			  PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(doorbell_off));
+	amdgpu_ring_write(kiq_ring, 0);
+	amdgpu_ring_write(kiq_ring, 0);
+	amdgpu_ring_write(kiq_ring, 0);
+
+	amdgpu_ring_commit(kiq_ring);
+
+out_unlock:
+	spin_unlock(&adev->gfx.kiq[inst].ring_lock);
+	kgd_gfx_v9_release_queue(adev, inst);
+
+	return r;
+}
+
 int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
@@ -1154,6 +1201,7 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.hqd_sdma_dump = kgd_hqd_sdma_dump,
 	.hqd_is_occupied = kgd_gfx_v9_hqd_is_occupied,
 	.hqd_sdma_is_occupied = kgd_hqd_sdma_is_occupied,
+	.hiq_hqd_destroy = kgd_gfx_v9_hiq_hqd_destroy,
 	.hqd_destroy = kgd_gfx_v9_hqd_destroy,
 	.hqd_sdma_destroy = kgd_hqd_sdma_destroy,
 	.wave_control_execute = kgd_gfx_v9_wave_control_execute,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 5f54bff0db49..37b76c66f0fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -45,6 +45,9 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 				enum kfd_preempt_type reset_type,
 				unsigned int utimeout, uint32_t pipe_id,
 				uint32_t queue_id, uint32_t inst);
+int kgd_gfx_v9_hiq_hqd_destroy(struct amdgpu_device *adev, void *mqd,
+				uint32_t pipe_id, uint32_t queue_id,
+				uint32_t inst);
 int kgd_gfx_v9_wave_control_execute(struct amdgpu_device *adev,
 					uint32_t gfx_index_val,
 					uint32_t sq_cmd, uint32_t inst);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 863cf060af48..83101b3d341a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -193,6 +193,14 @@ int kfd_hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
 					      queue_id, p->doorbell_off, 0);
 }
 
+int kfd_destroy_hiq_hqd(struct mqd_manager *mm, void *mqd,
+		enum kfd_preempt_type type, unsigned int timeout,
+		uint32_t pipe_id, uint32_t queue_id)
+{
+	return mm->dev->kfd2kgd->hiq_hqd_destroy(mm->dev->adev, mqd,
+						pipe_id, queue_id, 0);
+}
+
 int kfd_destroy_mqd_cp(struct mqd_manager *mm, void *mqd,
 		enum kfd_preempt_type type, unsigned int timeout,
 		uint32_t pipe_id, uint32_t queue_id)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 23158db7da03..8ad8c8087da8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -173,4 +173,8 @@ void kfd_get_hiq_xcc_mqd(struct kfd_node *dev,
 uint64_t kfd_hiq_mqd_stride(struct kfd_node *dev);
 uint64_t kfd_mqd_stride(struct mqd_manager *mm,
 			struct queue_properties *q);
+
+int kfd_destroy_hiq_hqd(struct mqd_manager *mm, void *mqd,
+			enum kfd_preempt_type type, unsigned int timeout,
+			uint32_t pipe_id, uint32_t queue_id);
 #endif /* KFD_MQD_MANAGER_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 94c0fc2e57b7..40c0ebb5e7ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -460,7 +460,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
 		mqd->free_mqd = free_mqd_hiq_sdma;
 		mqd->load_mqd = kfd_hiq_load_mqd_kiq;
 		mqd->update_mqd = update_mqd;
-		mqd->destroy_mqd = kfd_destroy_mqd_cp;
+		mqd->destroy_mqd = kfd_destroy_hiq_hqd;
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v10_compute_mqd);
 		mqd->mqd_stride = kfd_mqd_stride;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 31fec5e70d13..79f245efde5a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -449,7 +449,7 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
 		mqd->free_mqd = free_mqd_hiq_sdma;
 		mqd->load_mqd = kfd_hiq_load_mqd_kiq;
 		mqd->update_mqd = update_mqd;
-		mqd->destroy_mqd = kfd_destroy_mqd_cp;
+		mqd->destroy_mqd = kfd_destroy_hiq_hqd;
 		mqd->is_occupied = kfd_is_occupied_cp;
 		mqd->mqd_size = sizeof(struct v11_compute_mqd);
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 601bb9f68048..7893c53c9372 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -553,9 +553,8 @@ static int destroy_hiq_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 
 	for_each_inst(xcc_id, xcc_mask) {
 		xcc_mqd = mqd + hiq_mqd_size * inst;
-		err = mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, xcc_mqd,
-						    type, timeout, pipe_id,
-						    queue_id, xcc_id);
+		err = mm->dev->kfd2kgd->hiq_hqd_destroy(mm->dev->adev, xcc_mqd,
+						    pipe_id, queue_id, xcc_id);
 		if (err) {
 			pr_debug("Destroy MQD failed for xcc: %d\n", inst);
 			break;
@@ -846,7 +845,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		} else {
 			mqd->init_mqd = init_mqd_hiq;
 			mqd->load_mqd = kfd_hiq_load_mqd_kiq;
-			mqd->destroy_mqd = kfd_destroy_mqd_cp;
+			mqd->destroy_mqd = kfd_destroy_hiq_hqd;
 		}
 		break;
 	case KFD_MQD_TYPE_DIQ:
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index d0df3381539f..0f242aad22c7 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -268,6 +268,9 @@ struct kfd2kgd_calls {
 				unsigned int timeout, uint32_t pipe_id,
 				uint32_t queue_id, uint32_t inst);
 
+	int (*hiq_hqd_destroy)(struct amdgpu_device *adev, void *mqd,
+			uint32_t pipe_id, uint32_t queue_id, uint32_t inst);
+
 	bool (*hqd_sdma_is_occupied)(struct amdgpu_device *adev, void *mqd);
 
 	int (*hqd_sdma_destroy)(struct amdgpu_device *adev, void *mqd,
-- 
2.35.1

