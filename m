Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0204CF58D5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 06:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874E010E7AA;
	Fri, 20 Sep 2024 06:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wj6PAt8G";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB8810E7AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 06:31:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdxiXubhHBSaDla4RWXZnZkb1bi1BbMO3kZGYVyBqCeROyjw6dv/xQnt5uQyrUHK4pRA/LVCtLq6oVjvdc5bXgmaTHojOjMEiaqpAWiBISGKXDw0o6oNGoTfc9XfyiUDj+T5Lqn5Y4aOZRGP9/yp/j6IoZ6DzknvGzJ/xpvpYcjP4X1S2nxCaxoP3Xyl3gRSQEofKTKtf9A5lR/1zZKyDDUn3BIPqfr6E1TESJn7ye7+0vzbPA+G+uKRzvgd+WDJykFiMGyeVkB89Rrkmtx9nymXNXS+qvek+Ju2Ujw5f7WaLKP6SRoD5BBidFA9QLQaTnRwiXC6noNjjVvMG7HliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noVC0OzeVfUPbid5O1VkaKz3NCuzMxN7IHiajmJ2j7o=;
 b=gPL64oSOpZBrDM9A23njhCjlH80JP0sNc2Yw9ABYTJ8AGuBl9j6vxjZC7lBrX4aRodjmqr56J6I8Vs5noV8IH7Mfwu/tVdh1AaFTy4B6OfFKfiCS0+j8SxiA7uxXSFuNYsJAzv4QkQrwBq9rFoX50+NONd8Fnp6BFc6frJpJTM+2GIMTeK67CweBK1fdqupk6Hx0c3HJ8f1oMHWqqbf9c3FJwU6rB4D9Pefe72ATD3wYAnulB6X8cahqmJIh3i9fcEGkkR9vPyakBdv4FsAaTciYuAnRYN4t3SZqSMP6oU5lmRPBQEl9Ko+LxLUFdoAGoA26DD0jAiiLaqDD6kTRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noVC0OzeVfUPbid5O1VkaKz3NCuzMxN7IHiajmJ2j7o=;
 b=Wj6PAt8GGixJFdD9O4SWKniIVsFiPQh5OVgmfc2lv2y1rogm39hnKCjJY6lq0HSN5g55cPZw1WNF5vDXwV6sMB8xK7eXOqjR5AHVpI5ti2NJsGBlKBW5KgrnYZqefasT7TCwiAAGOe2bpAblgW2AUaTNmwDSO0B8XQmo8S4XvLE=
Received: from MN2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:208:134::38)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 06:31:38 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:134::4) by MN2PR16CA0025.outlook.office365.com
 (2603:10b6:208:134::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25 via Frontend
 Transport; Fri, 20 Sep 2024 06:31:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 06:31:37 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 01:31:36 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/sdma5.2: split out per instance resume function
Date: Fri, 20 Sep 2024 14:31:11 +0800
Message-ID: <20240920063112.370961-3-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920063112.370961-1-jiadong.zhu@amd.com>
References: <20240920063112.370961-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 1003e427-d032-4144-7d42-08dcd93de170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8isWq2pe+rYJB11E1XLy5TdptWS1M6hZIQG5cQVJgNzvA6yDgiTOCxbWZpc5?=
 =?us-ascii?Q?xHIDnIcJR61RF7+11KlA/0jW/Gn6EaNUGvcLmCTUbGOE9XFZRHR9hUff4Mth?=
 =?us-ascii?Q?HnUpTqaIc12enesDiifUQ6mTxkb3srg5is+kBWEqN9VAdRNO1gcowda7xm2B?=
 =?us-ascii?Q?sq3BRligZNyPMQ9ocCxtQC+iTjNyyKx6U1nTSlzj22BkwzRBNsVHGumCi7H9?=
 =?us-ascii?Q?lv1bRZsaRT0EcGIQsgZAFuI+pZSRfuZW0UbgxgaIZQ8Uc8qJ7oMS4NIYY8rE?=
 =?us-ascii?Q?fSE/Pixyl4k9OsyxI0LrcLd6ywBnNS9UHGDJZwKVZsptN3SB4VlV8x4lMCvS?=
 =?us-ascii?Q?CmeUt8TyHIZwFALZRHGmeUW4aQoKr9x11xqnfECmnVdQ7opURJT2GdqyfrEy?=
 =?us-ascii?Q?xCMCFEXkiSFRD6ziyJo6uc7TW/vT+mga/Gav5qTG/eMthfo4eUS6pNPA8TDB?=
 =?us-ascii?Q?Du2YxrdZaiHnB7RcSkLCzJJsHcaxCul3AexZjTjxmGH7RJnXfLKR7Zj0ys05?=
 =?us-ascii?Q?GaLS0sdmarxMRKmMQHfnjW+6oUI6dytFo6GKxbl7guvQ/+nL8+dFN/gzovNw?=
 =?us-ascii?Q?mPoE7p4dW5uEUHb8hrQaEzGahTtBJ6dV/83MsPNbI4yOtMU8RR36UJkt3Aas?=
 =?us-ascii?Q?QwvDEAPSa/GZQy7yiBzDlTb77Jk9gNX+YVy0iLK72ozTQx/sJMc3+9EvFV5Y?=
 =?us-ascii?Q?LdNjC2IXlksep3SumjtdsYImX5qgUJ3pWwz9NZDHrqQqRLALF2B7GsPxHSWj?=
 =?us-ascii?Q?nVJfPruJtB9JDrG7MlAL/NC3kt8puCx236XzyBuCbakV0wqf2JN2pAcb8l1L?=
 =?us-ascii?Q?PMiZVA2RtndZZVssuq/EPauB3XB2EfxGjBXzXD0oHOm5jyGFAbbWDpyOxDMW?=
 =?us-ascii?Q?C/TEmCevvZVFvvBisGXQ0rIACUI2YPxVkiTYl2eOTOl13rFwTtqkRXj5K40s?=
 =?us-ascii?Q?tqALFWppbxjHfP0VnVdw/34fhXgVnjEPBdUQ3FSRL6l/h5XqBE1ARDC17Kha?=
 =?us-ascii?Q?7xvP4MN5lInfuYHfxcpjii6L4mV5BcamyqNaKbNpKnBnqhZ4ncKn+6Wan8t4?=
 =?us-ascii?Q?9TafUC0uaqtYuGf/tkYLFLEcCZZI/8UymTdXcVQoA+sMCbdlTnoS9qHRQq0D?=
 =?us-ascii?Q?G+iwswvfoBTH1Z1z/7wJoWx/4R11OUhxdQSjPgPhsFUraqA4Wm2C6v0YXcBE?=
 =?us-ascii?Q?5fFMEUUkN8Ii7fS1e7n53sfc7P5CO6qAw0SJgq72MxAOQ1QngzTIaKECkpcB?=
 =?us-ascii?Q?hhiWXjZZJHE6gLKV8DHfw9ZqcyMfHV4+4GrqfFFrC2q3ioRnPDM1+aIH7Q/V?=
 =?us-ascii?Q?hugOXHZ4Uj3WQPRI3WmFS/TeToJhXKmQgpaV+cn6Faa1OniFLn9EOCo20NmT?=
 =?us-ascii?Q?n0cXkZs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 06:31:37.7308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1003e427-d032-4144-7d42-08dcd93de170
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Extract the resume sequence from sdma_v5_2_gfx_resume for
starting/restarting an individual instance.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 247 ++++++++++++++-----------
 1 file changed, 136 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index bc9b240a3488..21457093eae9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -522,14 +522,17 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
 }
 
 /**
- * sdma_v5_2_gfx_resume - setup and start the async dma engines
+ * sdma_v5_2_gfx_resume_instance - start/restart a certain sdma engine
  *
  * @adev: amdgpu_device pointer
+ * @i: instance
+ * @restore: used to restore wptr when restart
  *
- * Set up the gfx DMA ring buffers and enable them.
- * Returns 0 for success, error for failure.
+ * Set up the gfx DMA ring buffers and enable them. On restart, we will restore wptr and rptr.
+ * Return 0 for success.
  */
-static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
+
+static int sdma_v5_2_gfx_resume_instance(struct amdgpu_device *adev, int i, bool restore)
 {
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl;
@@ -539,139 +542,161 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 	u32 temp;
 	u32 wptr_poll_cntl;
 	u64 wptr_gpu_addr;
-	int i, r;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
+	ring = &adev->sdma.instance[i].ring;
 
-		if (!amdgpu_sriov_vf(adev))
-			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+	if (!amdgpu_sriov_vf(adev))
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
 
-		/* Set ring buffer size in dwords */
-		rb_bufsz = order_base_2(ring->ring_size / 4);
-		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb_bufsz);
+	/* Set ring buffer size in dwords */
+	rb_bufsz = order_base_2(ring->ring_size / 4);
+	rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb_bufsz);
 #ifdef __BIG_ENDIAN
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENABLE, 1);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL,
-					RPTR_WRITEBACK_SWAP_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL,
+				RPTR_WRITEBACK_SWAP_ENABLE, 1);
 #endif
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
-
-		/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+
+	/* Initialize the ring buffer's read and write pointers */
+	if (restore) {
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), lower_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
+	} else {
 		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
 		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
 		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
 		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
+	}
 
-		/* setup the wptr shadow polling */
-		wptr_gpu_addr = ring->wptr_gpu_addr;
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
-		       lower_32_bits(wptr_gpu_addr));
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
-		       upper_32_bits(wptr_gpu_addr));
-		wptr_poll_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
-							 mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
-		wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
-					       SDMA0_GFX_RB_WPTR_POLL_CNTL,
-					       F32_POLL_ENABLE, 1);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
-		       wptr_poll_cntl);
-
-		/* set the wb address whether it's enabled or not */
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
-		       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
-		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
-
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
-
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);
-
+	/* setup the wptr shadow polling */
+	wptr_gpu_addr = ring->wptr_gpu_addr;
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
+	       lower_32_bits(wptr_gpu_addr));
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
+	       upper_32_bits(wptr_gpu_addr));
+	wptr_poll_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
+						 mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
+	wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
+				       SDMA0_GFX_RB_WPTR_POLL_CNTL,
+				       F32_POLL_ENABLE, 1);
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
+	       wptr_poll_cntl);
+
+	/* set the wb address whether it's enabled or not */
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
+	       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
+	       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
+
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
+
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);
+
+	if (restore)
 		ring->wptr = 0;
 
-		/* before programing wptr to a less value, need set minor_ptr_update first */
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
+	/* before programing wptr to a less value, need set minor_ptr_update first */
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
 
-		if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
-		}
+	if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
+	}
 
-		doorbell = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
-		doorbell_offset = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET));
+	doorbell = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
+	doorbell_offset = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET));
 
-		if (ring->use_doorbell) {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 1);
-			doorbell_offset = REG_SET_FIELD(doorbell_offset, SDMA0_GFX_DOORBELL_OFFSET,
-					OFFSET, ring->doorbell_index);
-		} else {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 0);
-		}
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL), doorbell);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET), doorbell_offset);
+	if (ring->use_doorbell) {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 1);
+		doorbell_offset = REG_SET_FIELD(doorbell_offset, SDMA0_GFX_DOORBELL_OFFSET,
+				OFFSET, ring->doorbell_index);
+	} else {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 0);
+	}
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL), doorbell);
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET), doorbell_offset);
 
-		adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
-						      ring->doorbell_index,
-						      adev->doorbell_index.sdma_doorbell_range);
+	adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
+					      ring->doorbell_index,
+					      adev->doorbell_index.sdma_doorbell_range);
 
-		if (amdgpu_sriov_vf(adev))
-			sdma_v5_2_ring_set_wptr(ring);
+	if (amdgpu_sriov_vf(adev))
+		sdma_v5_2_ring_set_wptr(ring);
 
-		/* set minor_ptr_update to 0 after wptr programed */
+	/* set minor_ptr_update to 0 after wptr programed */
 
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
 
-		/* SRIOV VF has no control of any of registers below */
-		if (!amdgpu_sriov_vf(adev)) {
-			/* set utc l1 enable flag always to 1 */
-			temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
-			temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
-
-			/* enable MCBP */
-			temp = REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENABLE, 1);
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);
-
-			/* Set up RESP_MODE to non-copy addresses */
-			temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
-			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
-			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
-			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
-
-			/* program default cache read and write policy */
-			temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
-			/* clean read policy and write policy bits */
-			temp &= 0xFF0FFF;
-			temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
-				 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
-				 SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
-			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
-
-			/* unhalt engine */
-			temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
-			temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), temp);
-		}
+	/* SRIOV VF has no control of any of registers below */
+	if (!amdgpu_sriov_vf(adev)) {
+		/* set utc l1 enable flag always to 1 */
+		temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
+		temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
+
+		/* enable MCBP */
+		temp = REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENABLE, 1);
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);
+
+		/* Set up RESP_MODE to non-copy addresses */
+		temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
+		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
+		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
+
+		/* program default cache read and write policy */
+		temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
+		/* clean read policy and write policy bits */
+		temp &= 0xFF0FFF;
+		temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
+			 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
+			 SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
+
+		/* unhalt engine */
+		temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
+		temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), temp);
+	}
 
-		/* enable DMA RB */
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+	/* enable DMA RB */
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
 
-		ib_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 1);
+	ib_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 1);
 #ifdef __BIG_ENDIAN
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
-		/* enable DMA IBs */
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
+	/* enable DMA IBs */
+	WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
 
-		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
-			sdma_v5_2_ctx_switch_enable(adev, true);
-			sdma_v5_2_enable(adev, true);
-		}
+	if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
+		sdma_v5_2_ctx_switch_enable(adev, true);
+		sdma_v5_2_enable(adev, true);
+	}
+
+	return amdgpu_ring_test_helper(ring);
+}
 
-		r = amdgpu_ring_test_helper(ring);
+/**
+ * sdma_v5_2_gfx_resume - setup and start the async dma engines
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set up the gfx DMA ring buffers and enable them.
+ * Returns 0 for success, error for failure.
+ */
+static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		r = sdma_v5_2_gfx_resume_instance(adev, i, false);
 		if (r)
 			return r;
 	}
-- 
2.25.1

