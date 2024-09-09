Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F775ECE57B
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 09:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA9910E363;
	Mon,  9 Sep 2024 09:54:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3AVJq0NY";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 461AB10E363
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 09:54:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnZ1U8HN++m1+Fvne6reKBwoOvS62EGme6PLT5BKNq1F1y9ou/b1hEJ3bySh+jQw4yDIHT9baAp2XzLYY1di3R26UmHQWn3TTOPzre1KtLDYDHkI52Zjx/oZENRx+xDmEnhvBqACtIkP/ObZrrVYK3qOyhZze8mj/zIUxrIeOhsVVEtN5w06VTCQJCIbO05yD/IY9hE62yQ8/jyEd7GxWnG9eg1iW1Ut5SDfkhrnqdcp4NPxiLyxXl2HrxwIoiE0mTb/jSyuWGZOlEvjCMVZ2R9uOnlUmxEjXaIRNpk28gm0sshb+RQwFiEcLqPc3jzRuFF+lRB/0d6oEXiMTDwXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2g+xGHO3FMn8G60d2199J0K+rpJSry4Lyk6YTGuFS8=;
 b=MtVUeSlEaOsS5NhTeEiWdC4Y2+pKBWx+ehNU2Chh4B5bclXGF5l5+eT51oWj54+p4/+X9rengGfjikgnYwdRMLRwCIYWDOzvnS7OSep8z3voD2CD16CUbfBkyEgJAbkxgM0zW8zTppQniqX3fD7TWBg5Swd5DBicitJfSg4+ObhO+vlQW+1FrN7cB+zF2f5aaKFE1FOKecJSxVc0S4AvJ5FoB/K6Dn5+g8B+PV5++fk4joCRsplReKwiYESxWR8Hr9fYnMYXxVGyejX4plLJiAtDlYMEOwA1tBBSTDlmdWumY8sEuJI37HCC6RieHWkTXB3eQE2IrmN3BlZpam/w9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2g+xGHO3FMn8G60d2199J0K+rpJSry4Lyk6YTGuFS8=;
 b=3AVJq0NYzB2hcOPmKQ/0NVCuhJ7FeGbLXR9n13p7JD5Mgn1jD1wKgY9zPmenP+xbFcmshYZmyIYWOzRCI3PUuKCsjCBwRZ+P0gCPhlWIrdahbmKdjFIN+A7jvg4iYy55v1WonWgrGvpL3zXjeOT8OQ5csaRSEF9HKGVYlVDhImE=
Received: from CH0PR03CA0326.namprd03.prod.outlook.com (2603:10b6:610:118::9)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.32; Mon, 9 Sep
 2024 09:54:28 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::50) by CH0PR03CA0326.outlook.office365.com
 (2603:10b6:610:118::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 09:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 09:54:28 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 04:54:26 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/sdma6: implement ring reset callback for sdma6
Date: Mon, 9 Sep 2024 17:54:08 +0800
Message-ID: <20240909095408.1683-2-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909095408.1683-1-jiadong.zhu@amd.com>
References: <20240909095408.1683-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a453fb-e79c-48f3-3036-08dcd0b5652a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v7vgkc3mdfYkr0rq6VS6tN07HcBhkP+LMf2Outh+ejGp9Uoy7QzH8HcQU4Jj?=
 =?us-ascii?Q?yMHap0V43nutVjhz3zajLLNg5iD3AHMkhOd5Vsxk9okohryMzSAtYufEixds?=
 =?us-ascii?Q?/y7iv/bbj/UiQZhStXttyd4kUaMK8roRCyDXxYXfX7+fPuVU99/Jf30pZoBu?=
 =?us-ascii?Q?eLYjcpYlAU8oErXI2rJKQgLsfdPc1Aeol2X01OeWpUCCX8kbUzbv1i0swEau?=
 =?us-ascii?Q?z1orfkyTIioNNIYlQNEXj0OscLlrLlkLQq3COEMZOaXeeyfdZMAHxcKXYOO6?=
 =?us-ascii?Q?InaNLvefxdPnVWVNBFLRjv09WWaNGBnU/5jDfjp7udg5FnWyxNub7unXfOcH?=
 =?us-ascii?Q?SMPLb/hIxQcKBWqTZwIkLogPkADjj8C0/4BohA7PiMJhBC5SKrZz9cKDNdFE?=
 =?us-ascii?Q?PungltYXblZlHbjbKm292m1HGGIi1wEK/wCWnDevcwrhQKDKUv48Z3cxv2GR?=
 =?us-ascii?Q?4sB6UhGFjezAEumzXekHtB2cZscClPa0wcfKsrTYSoWgLh8X4mTJL3MX7Ptg?=
 =?us-ascii?Q?KVPWV8dHEecDlgkjMrBLVyc4I8xyH7ZyJb0W7w4esCChrpvByn+nUBylgS7y?=
 =?us-ascii?Q?Lutj4wTatnayrvac9KmwOcweEbyV9eIHZ73wP03sWCpZSxxhroy8KgWrCwqV?=
 =?us-ascii?Q?VVVg3XAyJZLai07292hy2LvQkXzC4/zLmDES5jqjOVP6XBwZDbW3XLFSup6L?=
 =?us-ascii?Q?4+an9pp/Hc5vaFhkmt1rFsMjTOIQfNsnzNODB+v2USw/5yXpHxpi8lDb68ol?=
 =?us-ascii?Q?RtONPlhBN2nW6XbEoEpfaxSA0H/d74fkryAaCsBBmYYkcHE1d5voNoyauF0G?=
 =?us-ascii?Q?DoiBgMbVRWdiJExZG3+3dON6e8HOSw/wXlxCgnPnE/5oQsM0mPslyv5rsjzl?=
 =?us-ascii?Q?3TKTDOhm4KKr6BRRgCKThKAAxVR9qvHDexPwOsqLC4jpQQL34UG15si1lTXe?=
 =?us-ascii?Q?y2VwdZZH9DPYNKbGr/2/m+F7Wr/QkGVTzgsku6I3gP3kwjstaH+N/TlX5dOw?=
 =?us-ascii?Q?chxGNB4Unmb60gG6rLcijsSHQ9XJtRnMVAle42IZLQrG31pWM8xMVMb9zuCb?=
 =?us-ascii?Q?KNGR/naS7dH4PukVBCqTI8eAp3CHVzfaa4lLiKqQ+5Mfm0TVY+l3wmSz4d2u?=
 =?us-ascii?Q?Cf7pWRzt5KjVYMtn3+lG0rcf+LgfWfCXcgjN66svkpKyJdamH5xIvAdxC8EM?=
 =?us-ascii?Q?Uv0IlWmLNyQNnoqYHprAykm4UrPMyy+ppGFi/j6N5Ybn2RMgXDp6MS1FCGBL?=
 =?us-ascii?Q?44CdOEyd7LKRLdXxizzziBZyPdr5trLNSqTisWpnFqsD2g8vfVGfWs14Xccu?=
 =?us-ascii?Q?EvGjcF++WoLyWWPTiydWm3ARElzB5ZFyX2qbVEqHOfCV4fAI/08jQLspbEoX?=
 =?us-ascii?Q?lA2UaDul2jtLVIhT4HHynBwkkfT40fUqYATdojWGCjW3nwz5OEYB68kLl20x?=
 =?us-ascii?Q?vsb2fi0fkNA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 09:54:28.3595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a453fb-e79c-48f3-3036-08dcd0b5652a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481
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

Implement sdma queue reset callback using mes_reset_queue_mmio.
Extract sdma resume sequence from sdma_v6_0_gfx_resume for queue restarting.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 266 +++++++++++++++----------
 1 file changed, 157 insertions(+), 109 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 208a1fa9d4e7..d8865a60b788 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -469,14 +469,16 @@ static void sdma_v6_0_enable(struct amdgpu_device *adev, bool enable)
 }
 
 /**
- * sdma_v6_0_gfx_resume - setup and start the async dma engines
+ * sdma_v6_0_gfx_resume_instance - start/restart a certain sdma engine
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
-static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
+static int sdma_v6_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool restore)
 {
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl;
@@ -485,132 +487,152 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
 	u32 doorbell_offset;
 	u32 temp;
 	u64 wptr_gpu_addr;
-	int i, r;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
+	ring = &adev->sdma.instance[i].ring;
+	if (!amdgpu_sriov_vf(adev))
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
 
-		if (!amdgpu_sriov_vf(adev))
-			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
-
-		/* Set ring buffer size in dwords */
-		rb_bufsz = order_base_2(ring->ring_size / 4);
-		rb_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SIZE, rb_bufsz);
+	/* Set ring buffer size in dwords */
+	rb_bufsz = order_base_2(ring->ring_size / 4);
+	rb_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SIZE, rb_bufsz);
 #ifdef __BIG_ENDIAN
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SWAP_ENABLE, 1);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL,
-					RPTR_WRITEBACK_SWAP_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SWAP_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL,
+				RPTR_WRITEBACK_SWAP_ENABLE, 1);
 #endif
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_PRIV, 1);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
-
-		/* Initialize the ring buffer's read and write pointers */
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_PRIV, 1);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
+
+	/* Initialize the ring buffer's read and write pointers */
+	if (restore) {
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), lower_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
+	} else {
 		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), 0);
 		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), 0);
 		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), 0);
 		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), 0);
+	}
+	/* setup the wptr shadow polling */
+	wptr_gpu_addr = ring->wptr_gpu_addr;
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_LO),
+	       lower_32_bits(wptr_gpu_addr));
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_HI),
+	       upper_32_bits(wptr_gpu_addr));
+
+	/* set the wb address whether it's enabled or not */
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_HI),
+	       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_LO),
+	       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
+
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, F32_WPTR_POLL_ENABLE, 1);
+
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
+
+	if (!restore)
+		ring->wptr = 0;
 
-		/* setup the wptr shadow polling */
-		wptr_gpu_addr = ring->wptr_gpu_addr;
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_LO),
-		       lower_32_bits(wptr_gpu_addr));
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_HI),
-		       upper_32_bits(wptr_gpu_addr));
-
-		/* set the wb address whether it's enabled or not */
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_HI),
-		       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_LO),
-		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
+	/* before programing wptr to a less value, need set minor_ptr_update first */
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 1);
 
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, F32_WPTR_POLL_ENABLE, 1);
+	if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
+	}
 
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
+	doorbell = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL));
+	doorbell_offset = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET));
 
-		ring->wptr = 0;
-
-		/* before programing wptr to a less value, need set minor_ptr_update first */
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 1);
+	if (ring->use_doorbell) {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 1);
+		doorbell_offset = REG_SET_FIELD(doorbell_offset, SDMA0_QUEUE0_DOORBELL_OFFSET,
+				OFFSET, ring->doorbell_index);
+	} else {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 0);
+	}
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL), doorbell);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
 
-		if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
-			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
-			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
-		}
+	if (i == 0)
+		adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
+					      ring->doorbell_index,
+					      adev->doorbell_index.sdma_doorbell_range * adev->sdma.num_instances);
 
-		doorbell = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL));
-		doorbell_offset = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET));
+	if (amdgpu_sriov_vf(adev))
+		sdma_v6_0_ring_set_wptr(ring);
+
+	/* set minor_ptr_update to 0 after wptr programed */
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 0);
+
+	/* Set up sdma hang watchdog */
+	temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL));
+	/* 100ms per unit */
+	temp = REG_SET_FIELD(temp, SDMA0_WATCHDOG_CNTL, QUEUE_HANG_COUNT,
+			     max(adev->usec_timeout/100000, 1));
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL), temp);
+
+	/* Set up RESP_MODE to non-copy addresses */
+	temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL));
+	temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
+	temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL), temp);
+
+	/* program default cache read and write policy */
+	temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE));
+	/* clean read policy and write policy bits */
+	temp &= 0xFF0FFF;
+	temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
+		 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
+		 SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE), temp);
 
-		if (ring->use_doorbell) {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 1);
-			doorbell_offset = REG_SET_FIELD(doorbell_offset, SDMA0_QUEUE0_DOORBELL_OFFSET,
-					OFFSET, ring->doorbell_index);
-		} else {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 0);
-		}
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL), doorbell);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
-
-		if (i == 0)
-			adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
-						      ring->doorbell_index,
-						      adev->doorbell_index.sdma_doorbell_range * adev->sdma.num_instances);
-
-		if (amdgpu_sriov_vf(adev))
-			sdma_v6_0_ring_set_wptr(ring);
-
-		/* set minor_ptr_update to 0 after wptr programed */
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 0);
-
-		/* Set up sdma hang watchdog */
-		temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL));
-		/* 100ms per unit */
-		temp = REG_SET_FIELD(temp, SDMA0_WATCHDOG_CNTL, QUEUE_HANG_COUNT,
-				     max(adev->usec_timeout/100000, 1));
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL), temp);
-
-		/* Set up RESP_MODE to non-copy addresses */
-		temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL));
-		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
-		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL), temp);
-
-		/* program default cache read and write policy */
-		temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE));
-		/* clean read policy and write policy bits */
-		temp &= 0xFF0FFF;
-		temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
-			 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
-			 SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE), temp);
-
-		if (!amdgpu_sriov_vf(adev)) {
-			/* unhalt engine */
-			temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_F32_CNTL));
-			temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
-			temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, TH1_RESET, 0);
-			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_F32_CNTL), temp);
-		}
+	if (!amdgpu_sriov_vf(adev)) {
+		/* unhalt engine */
+		temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_F32_CNTL));
+		temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
+		temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, TH1_RESET, 0);
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_F32_CNTL), temp);
+	}
 
-		/* enable DMA RB */
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_ENABLE, 1);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
+	/* enable DMA RB */
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_ENABLE, 1);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
 
-		ib_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL));
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_ENABLE, 1);
+	ib_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL));
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_ENABLE, 1);
 #ifdef __BIG_ENDIAN
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_SWAP_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
-		/* enable DMA IBs */
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL), ib_cntl);
+	/* enable DMA IBs */
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL), ib_cntl);
+
+	if (amdgpu_sriov_vf(adev))
+		sdma_v6_0_enable(adev, true);
 
-		if (amdgpu_sriov_vf(adev))
-			sdma_v6_0_enable(adev, true);
+	return amdgpu_ring_test_helper(ring);
+}
 
-		r = amdgpu_ring_test_helper(ring);
+/**
+ * sdma_v6_0_gfx_resume - setup and start the async dma engines
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set up the gfx DMA ring buffers and enable them.
+ * Returns 0 for success, error for failure.
+ */
+static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		r = sdma_v6_0_gfx_resume_instance(adev, i, false);
 		if (r)
 			return r;
 	}
@@ -1469,6 +1491,31 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	return r;
 }
 
+static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int i, r;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
+	if (r)
+		return r;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (ring == &adev->sdma.instance[i].ring)
+			break;
+	}
+
+	if (i == adev->sdma.num_instances) {
+		DRM_ERROR("sdma instance not found\n");
+		return -EINVAL;
+	}
+
+	return sdma_v6_0_gfx_resume_instance(adev, i, true);
+}
+
 static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
@@ -1652,6 +1699,7 @@ static const struct amdgpu_ring_funcs sdma_v6_0_ring_funcs = {
 	.emit_reg_write_reg_wait = sdma_v6_0_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v6_0_ring_init_cond_exec,
 	.preempt_ib = sdma_v6_0_ring_preempt_ib,
+	.reset = sdma_v6_0_reset_queue,
 };
 
 static void sdma_v6_0_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

