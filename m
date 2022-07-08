Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF134CCA480
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 08:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB351112D00;
	Fri,  8 Jul 2022 08:54:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C922112D2C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 08:54:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQw5RwwumzciTRQCKvUkMj8kfoxsvivmf2w60r+rTuf1V2JKjrnLtjjelUxCnw9J4jy8C25GeaX1xOgaZg/WGNRHToi7ERQDO23vCiOThFn4q3bjEu8rH0sdnqncBg7tTM6GWgqEE9uVYDq0q6JNmfbFvwISWaLKowdB1ACRLqULWh9XQeLxvOpU9OPy1GNg+JcfBdiSB7GdFjZ6AdeqtGeSZf7SMQmYWQ2bGCRyW4+GmCWecF3GFocjcFbhORtMgmK5oRIT8sCNgbpBTBhF46tGoWDRs2gjj1KHVXM0z0JugxnFGmiYFOv25mzL5K4YYKjwGqiyixijc6rgZlBh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKlcRhYsakr/HFpOh4ZUh7vZRzyjb7d3fZeW4HF172c=;
 b=RryQMn0HBaYgIQADVUEfRBfbHxxiKRsLapwt+cjE9gBVlxQic1W5MBs/OEqUPIDgA6SB2nOljKzoGMQbH8rfE1MlDygPi37sv5gGg6dAWNAY9vZY+w0EW6jLwitvwAXH9JD5sKEUdCRu72TqXuj6xC9/npUYOUkqu6A/CvIQ3Ew1BStcD5AhsHSHdK9QhohR27QsD8CjAtLPMvGTpFhRYW6QwkgcQAw/e+rEv6KXK4WUp0ejwXTQxpWIGbKxgxWGvN/QKUfc6dmzromRjXFfbGyko6zH2tkV2S5MgnNpO1/UTOhppfYh8UrgOjslsgt9zJ8FzBPWCYeMwScxNIBhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKlcRhYsakr/HFpOh4ZUh7vZRzyjb7d3fZeW4HF172c=;
 b=bsu1Q7ZKr0MwWr7svLq16aHXAuTwRM546uN/FIlTCFLSQwUOnhHMnws8z3kTS025pKv/+ZoC1U+2nj6YTzuygn/7NuSYV3Th2gKawxAKNaFFpemTMRRNWaTxJqPPVCfWribzQ2YFTkV1K8IQbDRIOzfjY3QjcvBPvy/UCfnq2xI=
Received: from BN6PR14CA0041.namprd14.prod.outlook.com (2603:10b6:404:13f::27)
 by CH2PR12MB3814.namprd12.prod.outlook.com (2603:10b6:610:28::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 08:54:51 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::6b) by BN6PR14CA0041.outlook.office365.com
 (2603:10b6:404:13f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Fri, 8 Jul 2022 08:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 08:54:50 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 03:54:48 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/mes: fix mes submission in atomic context
Date: Fri, 8 Jul 2022 16:54:24 +0800
Message-ID: <20220708085426.1857392-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c25bcde-a322-463c-e120-08da60bf846b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3814:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I04jv2rSZLJ3CfzyvIKvsbxBTYSGZBYxCKnpyuU7BieCSCKKjHq37KtEzcfCVXxt9xLajVxFzfSqXwG7uLWogruPcs6OkeweWQDeq7f2FQHULBsqK7HipNR4c7UM+CHobq775inizW1O8lEbQ7PXHWk3Cvhv8rhQCjkcEJtXVCDscsx42E2YqbFW/4amCJ9DhBlxmneWEQUs0gE8Ro1a5Yw13IGfpSRsOe3NS0DSrQbwrxAWyHI+/toTWGB51TXZ3E8tk2fr2FQ/+b5GGykavYPLnicDtXbG1KVb5HoDMoA8blka4JHSlji6bg/CuIAUUnWoe/S70lpaqDw4xKJQnsFki/khfb+Alxl1pchKH+EhxaTXnNglaTRkG1eI2OWsEnoLKJ+1ljs6ZWgTdAKAWe06tHSH2kOWz1mxXYNx110VU+IMt//XGKgnrUHqoOaCpk/SSArB2HG3Wb/biAGBZGko3FbSdCl/ZZIhn1O3FErUiESJ+sp+9UkOdnAm5XsAbuLprMmVHEEyJH5dZmF61cxmgTGolrnLgyGLEinOAGv2RqixxAMO0211xm/o8r6H6ld10IQpscBW6TnjM48Mnw9dwFXRASAmG56x4iT62JWR26iLuSrIUxZ7Rx+117te8ktFnt4JXtGzOcKOo//PQROL1i/plep5lEBTQ0AtnRl3mPyXYgyXZvrbYLckff9fHTb+iQ3fa70ZZHLq+eZkJrGhul/oOKp4a2wB2aISAvS9bt7EdZcueS7MjWgyDw/HHURFGXXr92fp0WgG/eh/cqk5PSwY/guSpFAtokbvYbe2AEpHdojS2tKvVq6YW/vUbt3V0205xXZ5WXIfpXXFmOH94ral6nOCrPzccffMpuvh45q21kNleo+hmjEOMiHixRgaGhhnM4+AVvrWTMARWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(40470700004)(46966006)(36840700001)(2906002)(36756003)(8936002)(30864003)(5660300002)(4326008)(70586007)(8676002)(82310400005)(70206006)(110136005)(40480700001)(40460700003)(86362001)(6636002)(316002)(478600001)(7696005)(41300700001)(26005)(2616005)(16526019)(1076003)(186003)(47076005)(426003)(6666004)(336012)(356005)(34020700004)(82740400003)(81166007)(83380400001)(36860700001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 08:54:50.2247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c25bcde-a322-463c-e120-08da60bf846b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3814
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For some cases (accessing registers, unmap legacy queue), it needs
access mes in atomic context. Use spinlock to protect agaist mes
ring buffer race condition.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 16 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 55 +++++++++------------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 63 ++++++++++---------------
 4 files changed, 50 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index ca44aa123a1e..db2138b7a858 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -150,6 +150,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	idr_init(&adev->mes.queue_id_idr);
 	ida_init(&adev->mes.doorbell_ida);
 	spin_lock_init(&adev->mes.queue_id_lock);
+	spin_lock_init(&adev->mes.ring_lock);
 	mutex_init(&adev->mes.mutex_hidden);
 
 	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
@@ -794,8 +795,6 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 	struct mes_unmap_legacy_queue_input queue_input;
 	int r;
 
-	amdgpu_mes_lock(&adev->mes);
-
 	queue_input.action = action;
 	queue_input.queue_type = ring->funcs->type;
 	queue_input.doorbell_offset = ring->doorbell_index;
@@ -808,7 +807,6 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 	if (r)
 		DRM_ERROR("failed to unmap legacy queue\n");
 
-	amdgpu_mes_unlock(&adev->mes);
 	return r;
 }
 
@@ -817,8 +815,6 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 	struct mes_misc_op_input op_input;
 	int r, val = 0;
 
-	amdgpu_mes_lock(&adev->mes);
-
 	op_input.op = MES_MISC_OP_READ_REG;
 	op_input.read_reg.reg_offset = reg;
 	op_input.read_reg.buffer_addr = adev->mes.read_val_gpu_addr;
@@ -835,7 +831,6 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 		val = *(adev->mes.read_val_ptr);
 
 error:
-	amdgpu_mes_unlock(&adev->mes);
 	return val;
 }
 
@@ -845,8 +840,6 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
 	struct mes_misc_op_input op_input;
 	int r;
 
-	amdgpu_mes_lock(&adev->mes);
-
 	op_input.op = MES_MISC_OP_WRITE_REG;
 	op_input.write_reg.reg_offset = reg;
 	op_input.write_reg.reg_value = val;
@@ -862,7 +855,6 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
 		DRM_ERROR("failed to write reg (0x%x)\n", reg);
 
 error:
-	amdgpu_mes_unlock(&adev->mes);
 	return r;
 }
 
@@ -873,8 +865,6 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 	struct mes_misc_op_input op_input;
 	int r;
 
-	amdgpu_mes_lock(&adev->mes);
-
 	op_input.op = MES_MISC_OP_WRM_REG_WR_WAIT;
 	op_input.wrm_reg.reg0 = reg0;
 	op_input.wrm_reg.reg1 = reg1;
@@ -892,7 +882,6 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 		DRM_ERROR("failed to reg_write_reg_wait\n");
 
 error:
-	amdgpu_mes_unlock(&adev->mes);
 	return r;
 }
 
@@ -902,8 +891,6 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
 	struct mes_misc_op_input op_input;
 	int r;
 
-	amdgpu_mes_lock(&adev->mes);
-
 	op_input.op = MES_MISC_OP_WRM_REG_WAIT;
 	op_input.wrm_reg.reg0 = reg;
 	op_input.wrm_reg.ref = val;
@@ -920,7 +907,6 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
 		DRM_ERROR("failed to reg_write_reg_wait\n");
 
 error:
-	amdgpu_mes_unlock(&adev->mes);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 17d58a08bbb7..02daffbda02d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -82,6 +82,7 @@ struct amdgpu_mes {
 	uint64_t                        default_gang_quantum;
 
 	struct amdgpu_ring              ring;
+	spinlock_t                      ring_lock;
 
 	const struct firmware           *fw[AMDGPU_MAX_MES_PIPES];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 18a129f36215..75cf92d38d41 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -87,21 +87,32 @@ static const struct amdgpu_ring_funcs mes_v10_1_ring_funcs = {
 };
 
 static int mes_v10_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
-						    void *pkt, int size)
+						    void *pkt, int size,
+						    int api_status_off)
 {
 	int ndw = size / 4;
 	signed long r;
 	union MESAPI__ADD_QUEUE *x_pkt = pkt;
+	struct MES_API_STATUS *api_status;
 	struct amdgpu_device *adev = mes->adev;
 	struct amdgpu_ring *ring = &mes->ring;
+	unsigned long flags;
 
 	BUG_ON(size % 4 != 0);
 
-	if (amdgpu_ring_alloc(ring, ndw))
+	spin_lock_irqsave(&mes->ring_lock, flags);
+	if (amdgpu_ring_alloc(ring, ndw)) {
+		spin_unlock_irqrestore(&mes->ring_lock, flags);
 		return -ENOMEM;
+	}
+
+	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
+	api_status->api_completion_fence_addr = mes->ring.fence_drv.gpu_addr;
+	api_status->api_completion_fence_value = ++mes->ring.fence_drv.sync_seq;
 
 	amdgpu_ring_write_multiple(ring, pkt, ndw);
 	amdgpu_ring_commit(ring);
+	spin_unlock_irqrestore(&mes->ring_lock, flags);
 
 	DRM_DEBUG("MES msg=%d was emitted\n", x_pkt->header.opcode);
 
@@ -166,13 +177,9 @@ static int mes_v10_1_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.gws_size = input->gws_size;
 	mes_add_queue_pkt.trap_handler_addr = input->tba_addr;
 
-	mes_add_queue_pkt.api_status.api_completion_fence_addr =
-		mes->ring.fence_drv.gpu_addr;
-	mes_add_queue_pkt.api_status.api_completion_fence_value =
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v10_1_submit_pkt_and_poll_completion(mes,
-			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt));
+			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
+			offsetof(union MESAPI__ADD_QUEUE, api_status));
 }
 
 static int mes_v10_1_remove_hw_queue(struct amdgpu_mes *mes,
@@ -189,13 +196,9 @@ static int mes_v10_1_remove_hw_queue(struct amdgpu_mes *mes,
 	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
 	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
 
-	mes_remove_queue_pkt.api_status.api_completion_fence_addr =
-		mes->ring.fence_drv.gpu_addr;
-	mes_remove_queue_pkt.api_status.api_completion_fence_value =
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v10_1_submit_pkt_and_poll_completion(mes,
-			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt));
+			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
 static int mes_v10_1_unmap_legacy_queue(struct amdgpu_mes *mes,
@@ -227,13 +230,9 @@ static int mes_v10_1_unmap_legacy_queue(struct amdgpu_mes *mes,
 			mes_remove_queue_pkt.unmap_kiq_utility_queue = 1;
 	}
 
-	mes_remove_queue_pkt.api_status.api_completion_fence_addr =
-		mes->ring.fence_drv.gpu_addr;
-	mes_remove_queue_pkt.api_status.api_completion_fence_value =
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v10_1_submit_pkt_and_poll_completion(mes,
-			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt));
+			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
 static int mes_v10_1_suspend_gang(struct amdgpu_mes *mes,
@@ -258,13 +257,9 @@ static int mes_v10_1_query_sched_status(struct amdgpu_mes *mes)
 	mes_status_pkt.header.opcode = MES_SCH_API_QUERY_SCHEDULER_STATUS;
 	mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 
-	mes_status_pkt.api_status.api_completion_fence_addr =
-		mes->ring.fence_drv.gpu_addr;
-	mes_status_pkt.api_status.api_completion_fence_value =
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v10_1_submit_pkt_and_poll_completion(mes,
-			&mes_status_pkt, sizeof(mes_status_pkt));
+			&mes_status_pkt, sizeof(mes_status_pkt),
+			offsetof(union MESAPI__QUERY_MES_STATUS, api_status));
 }
 
 static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes)
@@ -313,13 +308,9 @@ static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.disable_mes_log = 1;
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 
-	mes_set_hw_res_pkt.api_status.api_completion_fence_addr =
-		mes->ring.fence_drv.gpu_addr;
-	mes_set_hw_res_pkt.api_status.api_completion_fence_value =
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v10_1_submit_pkt_and_poll_completion(mes,
-			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt));
+			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
+			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
 }
 
 static const struct amdgpu_mes_funcs mes_v10_1_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 6b07a8b23d67..b78e09910c7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -86,21 +86,32 @@ static const struct amdgpu_ring_funcs mes_v11_0_ring_funcs = {
 };
 
 static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
-						    void *pkt, int size)
+						    void *pkt, int size,
+						    int api_status_off)
 {
 	int ndw = size / 4;
 	signed long r;
 	union MESAPI__ADD_QUEUE *x_pkt = pkt;
+	struct MES_API_STATUS *api_status;
 	struct amdgpu_device *adev = mes->adev;
 	struct amdgpu_ring *ring = &mes->ring;
+	unsigned long flags;
 
 	BUG_ON(size % 4 != 0);
 
-	if (amdgpu_ring_alloc(ring, ndw))
+	spin_lock_irqsave(&mes->ring_lock, flags);
+	if (amdgpu_ring_alloc(ring, ndw)) {
+		spin_unlock_irqrestore(&mes->ring_lock, flags);
 		return -ENOMEM;
+	}
+
+	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
+	api_status->api_completion_fence_addr = mes->ring.fence_drv.gpu_addr;
+	api_status->api_completion_fence_value = ++mes->ring.fence_drv.sync_seq;
 
 	amdgpu_ring_write_multiple(ring, pkt, ndw);
 	amdgpu_ring_commit(ring);
+	spin_unlock_irqrestore(&mes->ring_lock, flags);
 
 	DRM_DEBUG("MES msg=%d was emitted\n", x_pkt->header.opcode);
 
@@ -173,13 +184,9 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.tma_addr = input->tma_addr;
 	mes_add_queue_pkt.is_kfd_process = input->is_kfd_process;
 
-	mes_add_queue_pkt.api_status.api_completion_fence_addr =
-		mes->ring.fence_drv.gpu_addr;
-	mes_add_queue_pkt.api_status.api_completion_fence_value =
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt));
+			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
+			offsetof(union MESAPI__ADD_QUEUE, api_status));
 }
 
 static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
@@ -196,13 +203,9 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
 	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
 
-	mes_remove_queue_pkt.api_status.api_completion_fence_addr =
-		mes->ring.fence_drv.gpu_addr;
-	mes_remove_queue_pkt.api_status.api_completion_fence_value =
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt));
+			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
 static int mes_v11_0_unmap_legacy_queue(struct amdgpu_mes *mes,
@@ -233,13 +236,9 @@ static int mes_v11_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 			convert_to_mes_queue_type(input->queue_type);
 	}
 
-	mes_remove_queue_pkt.api_status.api_completion_fence_addr =
-		mes->ring.fence_drv.gpu_addr;
-	mes_remove_queue_pkt.api_status.api_completion_fence_value =
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt));
+			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
 static int mes_v11_0_suspend_gang(struct amdgpu_mes *mes,
@@ -264,13 +263,9 @@ static int mes_v11_0_query_sched_status(struct amdgpu_mes *mes)
 	mes_status_pkt.header.opcode = MES_SCH_API_QUERY_SCHEDULER_STATUS;
 	mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 
-	mes_status_pkt.api_status.api_completion_fence_addr =
-		mes->ring.fence_drv.gpu_addr;
-	mes_status_pkt.api_status.api_completion_fence_value =
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&mes_status_pkt, sizeof(mes_status_pkt));
+			&mes_status_pkt, sizeof(mes_status_pkt),
+			offsetof(union MESAPI__QUERY_MES_STATUS, api_status));
 }
 
 static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
@@ -316,13 +311,9 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		return -EINVAL;
 	}
 
-	misc_pkt.api_status.api_completion_fence_addr =
-		mes->ring.fence_drv.gpu_addr;
-	misc_pkt.api_status.api_completion_fence_value =
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&misc_pkt, sizeof(misc_pkt));
+			&misc_pkt, sizeof(misc_pkt),
+			offsetof(union MESAPI__MISC, api_status));
 }
 
 static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
@@ -372,13 +363,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
 
-	mes_set_hw_res_pkt.api_status.api_completion_fence_addr =
-		mes->ring.fence_drv.gpu_addr;
-	mes_set_hw_res_pkt.api_status.api_completion_fence_value =
-		++mes->ring.fence_drv.sync_seq;
-
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt));
+			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
+			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
 }
 
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
-- 
2.35.1

