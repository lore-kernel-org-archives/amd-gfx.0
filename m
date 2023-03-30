Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1736DC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E7710F01E;
	Thu, 30 Mar 2023 19:49:16 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6118310F008
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:49:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftyafXFbKr23BsPPk69IdY7Q2HgrS5em/pQB10331OnaLw1+R/vqe1jcv2o1B/7kD1/9WbQr47s7cld5ffR0hozD1mzoqQwU8F7xGJ82PD9S+Qq4ELbjMafVHmQi60QkBG7cLFFwZR1EudSuiIuMhyaMTB4YY9YHIzUuZ316isilemeiOO5xlUoGGkwxeHA/tXhcnUyXQX7MNwKrBOS7wUGCfHKK5+6M7ndUnaRXROCAHN0HQIm7crxmfFrtOjoBVBpziwASdlMbbiXVTPaS0O3JlFEFZ04BredF5Qhhv4+RWGGGIkPRZs8qtGZP/4yHYra8jl5jCGGff6ds3hAFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0R5NRe2a/kcbxB3+41dJgTLgae51gtgAY2nQqhv/x4=;
 b=NlW61ukgjMHJFysei2/V6gohRu4PNhXdczbecfugneiXSmXX16x5lhfNv/6wYlizzl6EIF2Ncxm142b7nX+2s1sH4uFO8UtB9qo+ACvdWkRIVVHB2wPAKVmBlI4z/PbQpcmMd7cUJF207O+B4XNercvCsmHCuT/RTq+ZYEt4KcM87G30u5DwwbPv/+p1hx+MpjZ44TZ9M9uftZwShWAe7MyfTGRK4tS9qg0ppsqq1SpqFEpW2SIi5ZpegYSQul8NbTYG47ZIeD+bE5ORXx1MIvqlK5R9bloZVWncl8fGW9oFznpSkqrsKHObfYmYSCUOnKrazxr/k1Lc0E/6F7cG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0R5NRe2a/kcbxB3+41dJgTLgae51gtgAY2nQqhv/x4=;
 b=uba/20RkmW9BlTJ/u+jsdX90FDM+aJGLNaIOcqi7Xz7AJOIZGWGJtFKCoBU8ULQGwBP8ofYnBdbhFKkox0x+KO2vPVjMxaBqQJEOXF0gBGadM7p/RlfkSlaCDr4St9bcvWyzdFUKJ1oYiqUi/O0zXJOT2Cm7sRRTrT0U6aR43EQ=
Received: from CY5PR15CA0158.namprd15.prod.outlook.com (2603:10b6:930:67::20)
 by MW4PR12MB6707.namprd12.prod.outlook.com (2603:10b6:303:1ee::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:49:01 +0000
Received: from CY4PEPF0000C971.namprd02.prod.outlook.com
 (2603:10b6:930:67:cafe::28) by CY5PR15CA0158.outlook.office365.com
 (2603:10b6:930:67::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C971.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:49:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:48:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amdgpu: Fix mqd init on GFX v9.4.3
Date: Thu, 30 Mar 2023 15:48:43 -0400
Message-ID: <20230330194843.1136162-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194843.1136162-1-alexander.deucher@amd.com>
References: <20230330194843.1136162-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C971:EE_|MW4PR12MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: f80f0d98-2f4a-4a3d-bd67-08db3157cf7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDDeumJ3+eZ475+31HnzGBTVLseQesLp8CEMaSZYcAciNEgKgf3bWLpSnxeBSOuBHDvbR5oL9khENH+JhYwg4L9V/lVj13DWHgjw+EkuR1ov4fLnulUBvgVVxGzrF+Na4UHpN9LR+qB2xVFgWDCDHEEaRzU+RQoq9iiOtHNtsHkVb0mpQdErdB3NvmOduKHHY8zpH9DkSObuSIt2A4Q7sMFjX0bwaO8iRo2FnMRQL8Qlt7CY3yIRB5gjGjCStfmLz4p5tMdPKdZlS//FFeXxDs8b3Rne1tm/EeULGjCq3TyZK9I3YKQ9pgQFBsfoc/kSfUso4Txol32SGtB9k/R3ifJOMDU772s1/VYH7JElqT2ZlxIkgHJP20IGT/j03hRrApRE+HjmWY7mOxbB+pqcKLSFZbEPGhE22kWhpf9pbwxJNW4snCxBVOhKnS5mrciQLlw1YF34UbsG5aDdaQZfvavugg2MDgvYZmb2tVW963WpWx1jDHXviAq2Td5UXSHqtdkvAitYp9WT+t1J4iiumkKnw2VB/cErIiXFVehDTKDfwWflh+D9U2/DUjMM6zViFbGA5FXRrfUtwEIHMdyewOJ3CmQH4fxpsNutoCQ7JKKjRWOR24dBaRZou3eH6Xq8m4SJsVky7/C5QY83+XMwFoNDj+bo1RdJPr1hFVHpvvCscGn2ifdz/aWUcEklCsIzhC0XNRHskUENw8HvQroIYJ6gJMaRPLnX9Xnj7AEyYBA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(2616005)(426003)(336012)(26005)(83380400001)(356005)(47076005)(82740400003)(86362001)(81166007)(186003)(1076003)(36860700001)(316002)(40480700001)(16526019)(8936002)(8676002)(41300700001)(70586007)(40460700003)(6666004)(5660300002)(82310400005)(7696005)(478600001)(36756003)(4326008)(54906003)(6916009)(70206006)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:49:01.5068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f80f0d98-2f4a-4a3d-bd67-08db3157cf7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C971.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6707
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

For MQD init, an XCC's queue is selected with GRBM select. However, for
initialization of MQD, values read from logical XCC0 registers are used.
This results in garbage values being read from XCC0 whose queue is not
selected. Change to read from the right XCC for MQD initialization.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2a271cd6f477..304bf6247969 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1461,7 +1461,7 @@ static void gfx_v9_4_3_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd
 	}
 }
 
-static int gfx_v9_4_3_mqd_init(struct amdgpu_ring *ring)
+static int gfx_v9_4_3_xcc_mqd_init(struct amdgpu_ring *ring, int xcc_id)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
@@ -1488,14 +1488,14 @@ static int gfx_v9_4_3_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
 
 	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_EOP_CONTROL);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_EOP_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
 			(order_base_2(GFX9_MEC_HPD_SIZE / 4) - 1));
 
 	mqd->cp_hqd_eop_control = tmp;
 
 	/* enable doorbell? */
-	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_PQ_DOORBELL_CONTROL);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONTROL);
 
 	if (ring->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
@@ -1525,7 +1525,7 @@ static int gfx_v9_4_3_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(ring->mqd_gpu_addr);
 
 	/* set MQD vmid to 0 */
-	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_MQD_CONTROL);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MQD_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
 	mqd->cp_mqd_control = tmp;
 
@@ -1535,7 +1535,7 @@ static int gfx_v9_4_3_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
 
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_PQ_CONTROL);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
 			    (order_base_2(ring->ring_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
@@ -1562,23 +1562,23 @@ static int gfx_v9_4_3_mqd_init(struct amdgpu_ring *ring)
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
 	ring->wptr = 0;
-	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_PQ_RPTR);
+	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_RPTR);
 
 	/* set the vmid for the queue */
 	mqd->cp_hqd_vmid = 0;
 
-	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_PERSISTENT_STATE);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PERSISTENT_STATE);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0x53);
 	mqd->cp_hqd_persistent_state = tmp;
 
 	/* set MIN_IB_AVAIL_SIZE */
-	tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_IB_CONTROL);
+	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_IB_CONTROL);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
 	mqd->cp_hqd_ib_control = tmp;
 
 	/* set static priority for a queue/ring */
 	gfx_v9_4_3_mqd_set_priority(ring, mqd);
-	mqd->cp_hqd_quantum = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HQD_QUANTUM);
+	mqd->cp_hqd_quantum = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_QUANTUM);
 
 	/* map_queues packet doesn't need activate the queue,
 	 * so only kiq need set this field.
@@ -1776,7 +1776,7 @@ static int gfx_v9_4_3_xcc_kiq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
 		mutex_lock(&adev->srbm_mutex);
 		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, xcc_id));
-		gfx_v9_4_3_mqd_init(ring);
+		gfx_v9_4_3_xcc_mqd_init(ring, xcc_id);
 		gfx_v9_4_3_xcc_kiq_init_register(ring, xcc_id);
 		soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 		mutex_unlock(&adev->srbm_mutex);
@@ -1807,7 +1807,7 @@ static int gfx_v9_4_3_xcc_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
 		mutex_lock(&adev->srbm_mutex);
 		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, xcc_id));
-		gfx_v9_4_3_mqd_init(ring);
+		gfx_v9_4_3_xcc_mqd_init(ring, xcc_id);
 		soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 		mutex_unlock(&adev->srbm_mutex);
 
-- 
2.39.2

