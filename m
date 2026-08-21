Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FF7C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 09:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A7E310F2C5;
	Fri, 21 Aug 2026 09:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cXnBpDQn";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F19AB10F2BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 09:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwrUcN9BSqij2cilFggYSAYdfOaMhVd5P8AS31e/vdl9t9embkes8hRmspt6OhyVnPJrGTvUj/l+IVnuyWr4QKV5sg57Yr+/lyN7UgloJoT38n84xRR2vtuMbtLKwl5UiOhTImno67SJyGQJkn82r4WQCgp+0zY8yDlofKWcAIMLSvb3pBPAFeDoVER2bUVuUlztLpCTFuFtnaqhYKFfNS+5GzkgAY18cucznAKzycJfgnL5p/WUovg2rN72sY60zWhHe2BrXMWdKGJOMhBMGl076g9TGC7Xd8ZUIwyYy1V1Wj7OVuKjYPdx+P+XJm/6jT9VNkFBwLr29kMfRzx8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeFXqWLnrHQQ7iW8HOg366jRNzbUxbGLFdSXiQgayO4=;
 b=iWt3pyxIin8BLEAH55XstGdjMrtpwsSj/tzCunx1XVEulKsQDmBF8tjecAQle2UK+WDKvdM1t3B4POK4u40y14vUKzWgXgnfnqFeYKXZBg38E66qhem5Qz7K1boWPsxFE3rJpmW7JGyepOH8aSzdjEYNQFdPgtJ2UoqcTjQVFM0ye58cV0aYh6l2aGGbXZwd5ZR1dfW8TMJRcBYO6n0P6L+pL1k3ubVxqk6NcHK3qOzHpgdiIBRs/0FRHk3m6NfkeSr5d+1cDwxJuLseLTDIR2S4+GpRBaLVnb7RtP5KOjMX7h/NzpTBUs4kX1zuk4aBfMrx2Wu6k2rLCjgYrKrADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeFXqWLnrHQQ7iW8HOg366jRNzbUxbGLFdSXiQgayO4=;
 b=cXnBpDQnqtaDZmS2HUS4dLg9l1JN+zFHiVe4AZFYrLA7IF4yaDzJj8frzx1aooi9ShAmRwOTWOh1jf4KkwZg8m6Pg/AsrOhLyeLjPqZNPW7K0fHoLETPryLtEU+SdFzzNfLp9383pbXEmybpAF99PQ1vD+2QW7nDyclgdhpJTxM=
Received: from CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::11)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 09:54:33 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::14) by CH0P221CA0032.outlook.office365.com
 (2603:10b6:610:11d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 09:54:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 09:54:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 04:54:32 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 04:54:31 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 03/10] drm/amdgpu/gfx11: implement compute and GFX update_mqd
Date: Fri, 21 Aug 2026 17:52:12 +0800
Message-ID: <20260821095427.2361126-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
References: <20260821095427.2361126-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 91fcf737-6dda-4249-d799-08deff6a338d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CJghQ1yPiBJKJKrcBe9M8+iVLZY6UFH6GDJB60yp8B971EI5CT5VRI88GzO6fQMmZ1vk9TOpQKzUHt6CmixFK0TRXErBoNECJAfJ7cLcPdHE6IrQ1IfbVbjzxNbcRAdF4Ww8akmbaM2xVHyTOE2PVP0yUusd8z4o4TNnjsaebIpgCoGJS6xxccpnCGgXAztr42aSFGB0RlSHsCGHhZEIgA83Wzj3uEpzj0u7TTm5KqEm9lD5UvCKqS35eZZXuMnV/37lK2Myc1FLIuqPSbM0+KdrhiOZ/i2smGyBllF+Dsz0uTbXlVP2bODqw9JwmG/RZf9w5QsJ8OBhVlzTcL1WgyV5pipZY6sMzH5+4PhPSU6aDfVEQc3mqOu93hr6SDB2NFOUOpz29mHVT+1HUW9Qqyq9WZX3/uNiPcN2z7qMQuhwi7k/ITjeTcz2Gk0lYU6N3XIsj/suPA3ypeZ1w8EUdqqJ+n+/cOjO65rmkW8u90WPwXNk5kMoja2eOOjXPtzunI/B5A/oQ2ThXaTyUnqsj0z6K7nklPbS5pgL3wXhmPIKDo3CfOHHPYMUaAnYgOJy1OKYsWdUTtnmf2vZ1d2VSP0YDbytlpXqAzFb624KsMweFN04CW230Gu6RP2AaUFhzgvvI3fkgN+kDltnq4W2KYUZHY/508DPBoXS6oues+QuJvoDlJ7BIRREtVoSyl/j/qPQjKfHJ1QsrxZjusJ3iQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wO9Aew/C1/KfcWouPdoHANvW5npOwlYRLyiWp8x2L7FHcOZCSMVzbZ26vndWwAkBidKFdeZN74NiW8NNxaEdVbKkl13AsstWEaTmgqCTDDl7in4pajRayfVcVaiQXv3uwhNendB9QipLN4Zqww68H7mkmxuNI2VkXgDwtzFfxXO7FpafyadWdhiV/dNgLD/ZV1vyRbYuP17WvKkBlG+BGtuld9RM6JNHeJTe/SrTUeILUXUgiUufk5BjggU5r/pxDAIZ0K14VpeQBB+pNQC94U1h+QZW7C/X9xXq0y7Ssqx5+pKY0TNmnUu7BI+vbcgcqIel04Vf1JJDr/7OvcZqPnGzIByhBDyQCmmZ5TF0tbFidebT3joIiVGMvAzGPetusHhcT9jBU0ubux2ytZQImD/xsPVCDOACa2c9f9yBfrzHxhg5GINzQNg2vZAKzXcY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 09:54:32.9206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fcf737-6dda-4249-d799-08deff6a338d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
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

Implement the update_mqd callback for gfx11 compute and GFX user queues.
It patches only the fields a MODIFY can change (compute: queue_size, CU
mask, priority; GFX: queue_size, priority, shadow/CSA) and forwards the
write pointer to the user wptr while keeping the firmware-saved read
pointer, so a re-enabled queue resumes at the first un-consumed packet
rather than replaying the ring from 0.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 69 ++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a447562977ab..2e25ffdb7f12 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4256,6 +4256,39 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+/*
+ * GFX update_mqd: patch queue_size, ring base, priority and shadow/CSA in place
+ * and forward the write pointer, keeping the firmware-saved rptr.
+ */
+static int gfx_v11_0_gfx_mqd_update(struct amdgpu_device *adev, void *m,
+				    struct amdgpu_mqd_prop *prop,
+				    u64 user_wptr)
+{
+	struct v11_gfx_mqd *mqd = m;
+	uint32_t rb_bufsz, tmp;
+
+	rb_bufsz = order_base_2(prop->queue_size / 4) - 1;
+	tmp = mqd->cp_gfx_hqd_cntl;
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
+	mqd->cp_gfx_hqd_cntl = tmp;
+
+	mqd->cp_gfx_hqd_base = prop->hqd_base_gpu_addr >> 8;
+	mqd->cp_gfx_hqd_base_hi = upper_32_bits(prop->hqd_base_gpu_addr >> 8);
+
+	gfx_v11_0_gfx_mqd_set_priority(adev, mqd, prop);
+
+	mqd->shadow_base_lo = lower_32_bits(prop->shadow_addr);
+	mqd->shadow_base_hi = upper_32_bits(prop->shadow_addr);
+	mqd->fw_work_area_base_lo = lower_32_bits(prop->csa_addr);
+	mqd->fw_work_area_base_hi = upper_32_bits(prop->csa_addr);
+
+	mqd->cp_gfx_hqd_wptr = lower_32_bits(user_wptr);
+	mqd->cp_gfx_hqd_wptr_hi = upper_32_bits(user_wptr);
+
+	return 0;
+}
+
 static int gfx_v11_0_kgq_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -4477,6 +4510,38 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+/*
+ * Compute update_mqd: patch queue_size, ring/EOP base, CU mask and priority in
+ * place and forward the write pointer, keeping the firmware-saved rptr.
+ */
+static int gfx_v11_0_compute_mqd_update(struct amdgpu_device *adev, void *m,
+					struct amdgpu_mqd_prop *prop,
+					u64 user_wptr)
+{
+	struct v11_compute_mqd *mqd = m;
+
+	mqd->cp_hqd_pq_control &= ~CP_HQD_PQ_CONTROL__QUEUE_SIZE_MASK;
+	mqd->cp_hqd_pq_control |=
+		(order_base_2(prop->queue_size / 4) - 1)
+		<< CP_HQD_PQ_CONTROL__QUEUE_SIZE__SHIFT;
+
+	mqd->cp_hqd_pq_base_lo = prop->hqd_base_gpu_addr >> 8;
+	mqd->cp_hqd_pq_base_hi = upper_32_bits(prop->hqd_base_gpu_addr >> 8);
+
+	mqd->cp_hqd_eop_base_addr_lo = prop->eop_gpu_addr >> 8;
+	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(prop->eop_gpu_addr >> 8);
+
+	mqd->cp_hqd_pipe_priority = prop->hqd_pipe_priority;
+	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
+
+	gfx_v11_0_compute_mqd_set_cu_mask(adev, mqd, prop);
+
+	mqd->cp_hqd_pq_wptr_lo = lower_32_bits(user_wptr);
+	mqd->cp_hqd_pq_wptr_hi = upper_32_bits(user_wptr);
+
+	return 0;
+}
+
 static int gfx_v11_0_kiq_init_register(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -7271,11 +7336,15 @@ static void gfx_v11_0_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v11_gfx_mqd);
 	adev->mqds[AMDGPU_HW_IP_GFX].init_mqd =
 		gfx_v11_0_gfx_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_GFX].update_mqd =
+		gfx_v11_0_gfx_mqd_update;
 	/* set compute eng mqd */
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size =
 		sizeof(struct v11_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v11_0_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].update_mqd =
+		gfx_v11_0_compute_mqd_update;
 }
 
 static void gfx_v11_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.49.0

