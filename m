Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2B3E7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 07:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B2B10E7EE;
	Tue, 10 Dec 2024 07:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mGXLZmCA";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7336E10E7EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 07:53:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsCs2oqI6LLu6DixbeQ7kjL/yCOdb4lsrj7B5ZPvCLb7D7Q9gBSIxJ569/yutEfzhwzn2o1bnh+hcWKXc9NchcgUc2tM6jQ6OdOnMtOIOuuhXiWF3/r282yGvVm1IdDPS41m2RO947pQaGcuDiW47+OCN7tS6g8dINDRV2MFOr0XgxLXx75E5Sf7EoTKpOXzFWTybhfFrgMAIGeVsdDpuDYhMIe+mEJIaF6nyZcH3rlL2hMD8cWYkqDUyomKfKqXQSQbyBMsvOsTEYxP1beKfXJGyBGuLyi7CyC6CgVK93clkI9rU8SRzfy7u2MBckiqYttceKwX0Rhrkbx0FDCfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXh3WkOmKpWfrI0V0M6DakDKnWASDuBq4fDTuirnF74=;
 b=hwM5YJPInnTq6K+TaeAb0N9t/kW5K3wu53f9AyAq+ulkG5GFYxl/6IriZkR0DeoiJc9MCFhXKZ/5Y3XzGQUSjUfOhIep7LowuZ2NbXz2UMmpqquVSgbxxQTNoOsBUYQYjZjKpVS04/rrSLd71R3EfL0Rp4Ac7KeIHSvPpd+am9NrEwrpes/2jv0bJhEjM+YijjcIrSTFPEbgOUb8AGUAzyZMu31H6jhpA/ex0mf6r+hoVSUzs4+DBskj25MrH8SDVZkO1F0UJV5GY8VDBpMCUg+stkKfSzaNy0donxHdPjapDAXcSGE5sulfs1OWGwtjG2rfy/ROqjj84mSAQPlkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXh3WkOmKpWfrI0V0M6DakDKnWASDuBq4fDTuirnF74=;
 b=mGXLZmCA1dw8ce8D+kCGfSnq7QUgbCQUK6OycWipPOffWF4KREwa+3pLnlabWls1SD3Hm4/UGBLM356+qSyedjL5HMlDBD8Lg2rvJSeQlq0pACIDXOp9A24eUW2rJoE1+MwcjjDnS/UGur710YvrkNPDKg7LbmDW4MCnE+pJGJ4=
Received: from BN0PR07CA0004.namprd07.prod.outlook.com (2603:10b6:408:141::22)
 by CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 07:53:13 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::f6) by BN0PR07CA0004.outlook.office365.com
 (2603:10b6:408:141::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 07:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 07:53:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 01:53:12 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 10 Dec 2024 01:53:10 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 1/7 v2] drm/amdgpu/sdma7: Implement resume function for each
 instance
Date: Tue, 10 Dec 2024 15:53:04 +0800
Message-ID: <20241210075304.2183130-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CH3PR12MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6e7e10-0563-4c0e-700e-08dd18efb303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hZiQS2rB0IBovR+HMBmmA9Ixjk0ZLV3+GZCXsCn3cBxNguWiHish7fE0xWLo?=
 =?us-ascii?Q?ViexdQq6Tp8kx7OVI8jCnLpmEfpDyfzIsDeAL3ANBsOT3NiQwcs2SlfTi53M?=
 =?us-ascii?Q?Zm52hEG9SVa/0678pK7m7f1/ZkhE2YSF0T1g5IniNZ7pwucGfBiSQFiKBXlc?=
 =?us-ascii?Q?jqU5xhVBZ3UsLnHGLLzzNqa0TnV+TuB0Ey1j2gYS1mNlCguuFWXvaNPUhIdC?=
 =?us-ascii?Q?0z3Ef2JUeyYIOQnbuInqjvRI67OJ96TOYR3skherBiim6rBHS0uj5BvpW7Yj?=
 =?us-ascii?Q?Ba9rymnEhaY/p6RNADpeBN6mRAsW6BRVXlFKf8+Q6ADVxTe50RNWmP2WeF21?=
 =?us-ascii?Q?rcWhm+dbsQPgV1KvbGXWvC+K/K6ayhuQAkGpcLKOhjGxnpQYw5Njfg7mYYst?=
 =?us-ascii?Q?dp2KfgA7JzCYxBbemiOkiH5SucnFMXnC44U+PeUXtPWIU+xU242bVGCKsSe+?=
 =?us-ascii?Q?Wb6I+Wsk9cH6NQfCA1yMlyS+lkV3y9qva0N/50wtJScOdPc1WKfdAOLYBpi5?=
 =?us-ascii?Q?zX87tiomjMVrGbRaWzPzD4kugAGgzfoG5AvL4GCz4re0cIUUu+GWCNXHZw/i?=
 =?us-ascii?Q?0pLY0wfhXMk+CMFdHHN+wNb92kDuZQUY/W5kUWGhL8SpY8QexhKRsFCQM+Nk?=
 =?us-ascii?Q?4FqqlsFveEymV/9VtoETRKcqwPgc3ojGa+/k5gV24ilsMmhbUL9FqCJQkgQ8?=
 =?us-ascii?Q?p9iT9ot9LNlVkdVsPKWNxojeExkqL5ubUYPLYQv/wzkQySZfOxoVHiNuI9ax?=
 =?us-ascii?Q?AojSkqYMSCJ/M6PsKDoPi4XfCYOrvG8pP5w9n6irCEHbX18v1ZbSponptuzd?=
 =?us-ascii?Q?tCecp0R+n6uNq9hQ9gwxQWG4YZpdkIgkWFW+uZN0tTZojWYzMFw1zo0POMSF?=
 =?us-ascii?Q?ZSAB3CGgf6DHkSimWpXr9R6Jko3OGctQOke98Ng704HGB3KwpL8J9tyJ6K7l?=
 =?us-ascii?Q?v2p1gbm2eGDWcZ5lfaxTc4vyfWqPiU8XDfbx7F7PQXjKTg2YlHMZM1Ie9uvm?=
 =?us-ascii?Q?vQhY4u+9y+T8m2PS8+LTHlhCknefj2/hMaTIn356oENKz9J79iwmqLy+KyAT?=
 =?us-ascii?Q?tlli5wK5Nls36lCSHKAaNofWxRyqLS7O7tgusZ5LxUYZxiXJX0xEWXYgMvXE?=
 =?us-ascii?Q?c/Fd3HMw78LrXuC5gUANCqn2tlm3sSYho7MW/1hLVQZiceD+5PSinr8HsN1t?=
 =?us-ascii?Q?MIWtF0cEY69GQh1OzrZlIKs1aTEwBOLCPTKeZQylm5Hc1QkvpRD4+98iaeR1?=
 =?us-ascii?Q?W1eSzMU37THKkWfdfMvNIPq64Pk2CVGvWaDtj/51LWry2tJdFQ1Mi0FhKAoY?=
 =?us-ascii?Q?YLVN0CCaOiYN+N+R+PF6TSJ5FF1Ym/3jPwCRR4LR929Jy8EwFOrvgb6YXThe?=
 =?us-ascii?Q?EQ8jnxmGYtfFWTvl9L1G4VMA3lNEoTNjZlTatF0Q76uZlogCIwu8etiwxEOm?=
 =?us-ascii?Q?Ukt7ANMQ72syYganuoxkT0E3uXL8jf6Z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 07:53:13.5294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6e7e10-0563-4c0e-700e-08dd18efb303
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075
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

Extracts the resume sequence for per sdma instance from sdma_v7_0_gfx_resume.
This function can be used in start or restart scenarios of specific instances.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 259 ++++++++++++++-----------
 1 file changed, 141 insertions(+), 118 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 10ddf2c9e1fd..8cc8eaff0680 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -491,162 +491,185 @@ static void sdma_v7_0_enable(struct amdgpu_device *adev, bool enable)
 }
 
 /**
- * sdma_v7_0_gfx_resume - setup and start the async dma engines
+ * sdma_v7_0_gfx_resume_instance - start/restart a certain sdma engine
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
-static int sdma_v7_0_gfx_resume(struct amdgpu_device *adev)
+static int sdma_v7_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool restore)
 {
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl;
 	u32 rb_bufsz;
 	u32 doorbell;
 	u32 doorbell_offset;
-	u32 tmp;
+	u32 temp;
 	u64 wptr_gpu_addr;
-	int i, r;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
+	int r;
 
-		//if (!amdgpu_sriov_vf(adev))
-		//	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+	ring = &adev->sdma.instance[i].ring;
 
-		/* Set ring buffer size in dwords */
-		rb_bufsz = order_base_2(ring->ring_size / 4);
-		rb_cntl = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SIZE, rb_bufsz);
+	/* Set ring buffer size in dwords */
+	rb_bufsz = order_base_2(ring->ring_size / 4);
+	rb_cntl = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
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
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
-
-		/* Initialize the ring buffer's read and write pointers */
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_PRIV, 1);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
+
+	/* Initialize the ring buffer's read and write pointers */
+	if (restore) {
+		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), lower_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
+	} else {
 		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), 0);
 		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), 0);
 		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), 0);
 		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), 0);
+	}
+	/* setup the wptr shadow polling */
+	wptr_gpu_addr = ring->wptr_gpu_addr;
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_LO),
+	       lower_32_bits(wptr_gpu_addr));
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_HI),
+	       upper_32_bits(wptr_gpu_addr));
+
+	/* set the wb address whether it's enabled or not */
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_HI),
+	       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_LO),
+	       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
+
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
+	if (amdgpu_sriov_vf(adev))
+		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 1);
+	else
+		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
 
-		/* setup the wptr shadow polling */
-		wptr_gpu_addr = ring->wptr_gpu_addr;
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_LO),
-		       lower_32_bits(wptr_gpu_addr));
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_HI),
-		       upper_32_bits(wptr_gpu_addr));
-
-		/* set the wb address whether it's enabled or not */
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_HI),
-		       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_LO),
-		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
-
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
-		if (amdgpu_sriov_vf(adev))
-			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 1);
-		else
-			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, MCU_WPTR_POLL_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, MCU_WPTR_POLL_ENABLE, 1);
 
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
 
+	if (!restore)
 		ring->wptr = 0;
 
-		/* before programing wptr to a less value, need set minor_ptr_update first */
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 1);
+	/* before programing wptr to a less value, need set minor_ptr_update first */
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 1);
 
-		if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
-			WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
-			WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
-		}
+	if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
+		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
+		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
+	}
 
-		doorbell = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL));
-		doorbell_offset = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET));
+	doorbell = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL));
+	doorbell_offset = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET));
 
-		if (ring->use_doorbell) {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 1);
-			doorbell_offset = REG_SET_FIELD(doorbell_offset, SDMA0_QUEUE0_DOORBELL_OFFSET,
-					OFFSET, ring->doorbell_index);
-		} else {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 0);
-		}
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL), doorbell);
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
-
-		if (i == 0)
-			adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
-						      ring->doorbell_index,
-						      adev->doorbell_index.sdma_doorbell_range * adev->sdma.num_instances);
-
-		if (amdgpu_sriov_vf(adev))
-			sdma_v7_0_ring_set_wptr(ring);
-
-		/* set minor_ptr_update to 0 after wptr programed */
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 0);
-
-		/* Set up sdma hang watchdog */
-		tmp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL));
-		/* 100ms per unit */
-		tmp = REG_SET_FIELD(tmp, SDMA0_WATCHDOG_CNTL, QUEUE_HANG_COUNT,
-				    max(adev->usec_timeout/100000, 1));
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL), tmp);
-
-		/* Set up RESP_MODE to non-copy addresses */
-		tmp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL));
-		tmp = REG_SET_FIELD(tmp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
-		tmp = REG_SET_FIELD(tmp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL), tmp);
-
-		/* program default cache read and write policy */
-		tmp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE));
-		/* clean read policy and write policy bits */
-		tmp &= 0xFF0FFF;
-		tmp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
-			 (CACHE_WRITE_POLICY_L2__DEFAULT << 14));
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE), tmp);
-
-		if (!amdgpu_sriov_vf(adev)) {
-			/* unhalt engine */
-			tmp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_MCU_CNTL));
-			tmp = REG_SET_FIELD(tmp, SDMA0_MCU_CNTL, HALT, 0);
-			tmp = REG_SET_FIELD(tmp, SDMA0_MCU_CNTL, RESET, 0);
-			WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_MCU_CNTL), tmp);
-		}
+	if (ring->use_doorbell) {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 1);
+		doorbell_offset = REG_SET_FIELD(doorbell_offset, SDMA0_QUEUE0_DOORBELL_OFFSET,
+				OFFSET, ring->doorbell_index);
+	} else {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 0);
+	}
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL), doorbell);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
 
-		/* enable DMA RB */
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_ENABLE, 1);
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
+	if (i == 0)
+		adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
+					      ring->doorbell_index,
+					      adev->doorbell_index.sdma_doorbell_range * adev->sdma.num_instances);
 
-		ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL));
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_ENABLE, 1);
+	if (amdgpu_sriov_vf(adev))
+		sdma_v7_0_ring_set_wptr(ring);
+
+	/* set minor_ptr_update to 0 after wptr programed */
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 0);
+
+	/* Set up sdma hang watchdog */
+	temp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL));
+	/* 100ms per unit */
+	temp = REG_SET_FIELD(temp, SDMA0_WATCHDOG_CNTL, QUEUE_HANG_COUNT,
+			     max(adev->usec_timeout/100000, 1));
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL), temp);
+
+	/* Set up RESP_MODE to non-copy addresses */
+	temp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL));
+	temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
+	temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL), temp);
+
+	/* program default cache read and write policy */
+	temp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE));
+	/* clean read policy and write policy bits */
+	temp &= 0xFF0FFF;
+	temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
+		 (CACHE_WRITE_POLICY_L2__DEFAULT << 14));
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE), temp);
+
+	if (!amdgpu_sriov_vf(adev)) {
+		/* unhalt engine */
+		temp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_MCU_CNTL));
+		temp = REG_SET_FIELD(temp, SDMA0_MCU_CNTL, HALT, 0);
+		temp = REG_SET_FIELD(temp, SDMA0_MCU_CNTL, RESET, 0);
+		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_MCU_CNTL), temp);
+	}
+
+	/* enable DMA RB */
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_ENABLE, 1);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
+
+	ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL));
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_ENABLE, 1);
 #ifdef __BIG_ENDIAN
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_SWAP_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
-		/* enable DMA IBs */
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL), ib_cntl);
+	/* enable DMA IBs */
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL), ib_cntl);
+	ring->sched.ready = true;
 
-		ring->sched.ready = true;
+	if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
+		sdma_v7_0_ctx_switch_enable(adev, true);
+		sdma_v7_0_enable(adev, true);
+	}
 
-		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
-			sdma_v7_0_ctx_switch_enable(adev, true);
-			sdma_v7_0_enable(adev, true);
-		}
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		ring->sched.ready = false;
 
-		r = amdgpu_ring_test_helper(ring);
-		if (r) {
-			ring->sched.ready = false;
-			return r;
-		}
+	return r;
+}
 
+/**
+ * sdma_v7_0_gfx_resume - setup and start the async dma engines
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set up the gfx DMA ring buffers and enable them.
+ * Returns 0 for success, error for failure.
+ */
+static int sdma_v7_0_gfx_resume(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		r = sdma_v7_0_gfx_resume_instance(adev, i, false);
+		if (r)
+			return r;
 	}
 
 	return 0;
+
 }
 
 /**
-- 
2.25.1

