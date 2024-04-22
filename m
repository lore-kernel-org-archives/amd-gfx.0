Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CAAC07E8E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 14:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E4F112B75;
	Mon, 22 Apr 2024 14:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vbAWF1Fp";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26F7112B75
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 14:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYwKGYaPCnCpgGtfAESet+gGdYcZpWrSDOEz9xmS7L8VWiqNrL7tHzxo1tPdue2McIVS/M69zRWj46ukbe9oUpIPh4cs3RnFcDCFx8nam0xxhVNEVaXWsz/OLJa7AeTxXjvY6jzT6TAtZTaYjk2Rs12pYw4v+tTuVXF+wnTFDqIumpZfQVcV2ZJn3BJx90bTN2aY1Z8+RVV8UNG0A2lqQNdO/GYOUqSruq9vnId/pIJlCsYE0UEvN4Vrh78H9HPm1dFOcj2saHXo6L6MmkRi7bNd2URnZZy2Oas2BUIFiSy0hNhRtKqxMZYOi6f73f2WBt9WkzteNIdB9X5v7W88Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaTrPv0ydCWz26qee47XlSHsRkbLOvmPuY8FXSRXozI=;
 b=WJJ7SWA71+Bl5HyRk7EI6w/efZ4UqTbQ0TzrO7GX5kw5zKRLY/6tOyX6YFzrgHui/cbvweVj+P5gNirobfXMpWeVQqc6S0tBYFgNQx3J4lEaftry7V14Y6hXgcY7OFrGoGbWwycu2+RZzXqZPSvzwobdLzziFqrb4EPkZM89Bgz5v2vBP3/kVw7eqSGJNvxflxJCdm6qWtJTqQ7YPO+/Rq/Y1zKE2IiwVY3lc7Cs0iFox6zBGsJ8sFLiPl3wAq+T80qpJ0GuG/qivWp7mFbhonqpcHwoOfosDfkhxSxR/xV0Z18XSeN5oFqR9gCnkntKLdfPzh5XMH4MysZhoQV8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaTrPv0ydCWz26qee47XlSHsRkbLOvmPuY8FXSRXozI=;
 b=vbAWF1FpCRMMHYXmAQ26eawUULzoc7XInt2g1GLMCgVpeAcYjJqD6I9xvrWsWIyek00Vi51ckewcw9J/ZQJGebAMVe5Xw2fQqeOu7agLFOAEMSoawAJFQ0m6WL3VV3UeqgZZ2nbtRgHkvqS8OJZ25FCanAj+rtO1gqRnBE765nA=
Received: from MN2PR20CA0046.namprd20.prod.outlook.com (2603:10b6:208:235::15)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:38:01 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::f8) by MN2PR20CA0046.outlook.office365.com
 (2603:10b6:208:235::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 14:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 14:38:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 09:37:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes11: Use a separate fence per transaction
Date: Mon, 22 Apr 2024 10:37:38 -0400
Message-ID: <20240422143738.322710-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422143738.322710-1-alexander.deucher@amd.com>
References: <20240422143738.322710-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0f42c6-86db-40ce-7670-08dc62d9cfba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VJNkTEonyPEoOwMlIRgi1SrWmVzSHQpMplPjv2lUZSZ85WvbykTXCVSHU0MI?=
 =?us-ascii?Q?Jvc3exEpVgJHAI9A+NYA4HWmBMtnd4otVzuqwojv5ezg3qIYApuu2pFAvwmw?=
 =?us-ascii?Q?V+8FQutE3tng5pynjiWd8Jwc25BW/8mPo6jq+CB8AbG/qzXiNVqtfG6SmnKu?=
 =?us-ascii?Q?HYe61Bu+eZOyfpO+of4NS7bFkFTJ+yNdVekVi42LFJyQuH4ynLAp5/GYkPeB?=
 =?us-ascii?Q?jMInFK+SJGRY60N91BLDxmI69mM4l3YewKKmqlY2MSSnJNxYD1poYdk7McR4?=
 =?us-ascii?Q?hQT6TIoseHYGAS7uk3/fkyhvVJcTCEQFNfHfyS0v/EmS/zGVUHkfx+6DnFa8?=
 =?us-ascii?Q?ux9gyc0dx74TvRR59tj4He0hsH/Ier3CelQ0qq1GR5Ei3sGnQW9NywLO+eFB?=
 =?us-ascii?Q?j0Z05ghitGvT0LPbZ0UlRkGsg0yIF7kNAqX5tCNSPMn/5spgRrkEdFRDo2Nl?=
 =?us-ascii?Q?QwiotwqtbZGoOx6wpBHObDxB726UrZG+taQSA1AZs9/40Wa+hPdIdhaQWHWn?=
 =?us-ascii?Q?BgaYcZOiV2VGVNXqCY5rAAQUg1NDUyaov32H07bM4gTLnoRUX5VuHC8NJdnZ?=
 =?us-ascii?Q?mTP0IAtn1pd/lU4TjHPMUGVMSlngY+a+cMlsIZ+T2DE4E2vF8u9tTuScbFM+?=
 =?us-ascii?Q?ZNYom5x1c3e+3yVmcb0oVk/PvYM4ru7oIol+pRVZTHInt1e5I7Qia6kRfDOW?=
 =?us-ascii?Q?2aOi0FRSgoXaURmd0FaCibYcDPVzgXnD3pO94Xh+3dnvPEDpuCdLpI9385AL?=
 =?us-ascii?Q?nlnPQ1nFEhCpfUJ5aTwnvfTu1ywfUpnIJjYpj7ie0SR2aTcqvOQ5mTey+YQn?=
 =?us-ascii?Q?57dnntVP+3RSv5qoR1KzmpRRDP9mAYYMBwLLFKyRXa/U3ksqlgzcK2/nbQY5?=
 =?us-ascii?Q?k5Z0QtIBbCrI57DPX+KPLPRxMNcIpva/q8DtyBfxCeCrX4NMfrTtOImf6dA4?=
 =?us-ascii?Q?a9WHrGxSdiMKzuBHzNpZDeFZW9Nu8SMwhagAAqtknFapc3QnU+uc3S2FZUuD?=
 =?us-ascii?Q?N8QpLWonyBrfauahBIvCbBL5E2zFI+03vDrXw+j+YhF8wUH9dmkBgPptaY0v?=
 =?us-ascii?Q?A11mwAgpOpmXAHFa/6d+/z0yIJ3g2kXjaQsS1DdYKmauVa1DRZ3Q/UQyUbT0?=
 =?us-ascii?Q?bIOyWCw2zFUFevHSOLPD6WltnL0hKkQm5PcDThgseSpPNg8x9f8wDNB+fCRM?=
 =?us-ascii?Q?DcS31g4QCVEWlRbtHG2I2eUpTetXVR91Ry3fmQgrBHVVjguAtJXxBabUCvJ2?=
 =?us-ascii?Q?JpEwJkcHKhEKASjpKD3Cv1qEB++yaHhz5Ie8qnmA5Pho5xjmgv/n663En7gd?=
 =?us-ascii?Q?BxVpWNyTTo0i136EbY94qZGWSVipnMdb/n8I2W04tHKczi0Kn83VQdIpmcOa?=
 =?us-ascii?Q?xdQAHt0pHVru/thd7nib+HrAXL+X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:38:01.1828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0f42c6-86db-40ce-7670-08dc62d9cfba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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

We can't use a shared fence location because each transaction
should be considered independently.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 21 +++++++++++++++++----
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 78e4f88f5134..92c6fae780f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -32,6 +32,18 @@
 #define AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
 #define AMDGPU_ONE_DOORBELL_SIZE 8
 
+signed long amdgpu_mes_fence_wait_polling(u64 *fence,
+					  u64 wait_seq,
+					  signed long timeout)
+{
+
+	while ((s64)(wait_seq - *fence) > 0 && timeout > 0) {
+		udelay(2);
+		timeout -= 2;
+	}
+	return timeout > 0 ? timeout : 0;
+}
+
 int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
 {
 	return roundup(AMDGPU_ONE_DOORBELL_SIZE *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 6b3e1844eac5..b99a2b3cffe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -340,6 +340,10 @@ struct amdgpu_mes_funcs {
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
 #define amdgpu_mes_kiq_hw_fini(adev) (adev)->mes.kiq_hw_fini((adev))
 
+signed long amdgpu_mes_fence_wait_polling(u64 *fence,
+					  u64 wait_seq,
+					  signed long timeout);
+
 int amdgpu_mes_ctx_get_offs(struct amdgpu_ring *ring, unsigned int id_offs);
 
 int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index eb25af46622e..09193aee71c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -163,6 +163,10 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	unsigned long flags;
 	signed long timeout = 3000000; /* 3000 ms */
 	const char *op_str, *misc_op_str;
+	u32 fence_offset;
+	u64 fence_gpu_addr;
+	u64 *fence_ptr;
+	int ret;
 
 	if (x_pkt->header.opcode >= MES_SCH_API_MAX)
 		return -EINVAL;
@@ -175,15 +179,24 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	}
 	BUG_ON(size % 4 != 0);
 
+	ret = amdgpu_device_wb_get(adev, &fence_offset);
+	if (ret)
+		return ret;
+	fence_gpu_addr =
+		adev->wb.gpu_addr + (fence_offset * 4);
+	fence_ptr = (u64 *)&adev->wb.wb[fence_offset];
+	*fence_ptr = 0;
+
 	spin_lock_irqsave(&mes->ring_lock, flags);
 	if (amdgpu_ring_alloc(ring, ndw)) {
 		spin_unlock_irqrestore(&mes->ring_lock, flags);
+		amdgpu_device_wb_free(adev, fence_offset);
 		return -ENOMEM;
 	}
 
 	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
-	api_status->api_completion_fence_addr = mes->ring.fence_drv.gpu_addr;
-	api_status->api_completion_fence_value = ++mes->ring.fence_drv.sync_seq;
+	api_status->api_completion_fence_addr = fence_gpu_addr;
+	api_status->api_completion_fence_value = 1;
 
 	amdgpu_ring_write_multiple(ring, pkt, ndw);
 	amdgpu_ring_commit(ring);
@@ -199,8 +212,8 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	else
 		dev_dbg(adev->dev, "MES msg=%d was emitted\n", x_pkt->header.opcode);
 
-	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
-		      timeout);
+	r = amdgpu_mes_fence_wait_polling(fence_ptr, (u64)1, timeout);
+	amdgpu_device_wb_free(adev, fence_offset);
 	if (r < 1) {
 
 		if (misc_op_str)
-- 
2.44.0

