Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1361DC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE7C610EFDE;
	Thu, 30 Mar 2023 19:32:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1B7310EFB3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhUb4Udobxm+eUYv1brV/czMphFy3ebfJjFBYuW4Oju0D1dNcFZjKfFvvwFnVrzjZMOJM7SsDWaheKAxCja1RBxMrSgRnvYoXXaztQDCTydSVLOVc9a0L4/r9OswZdidt+XNLecbfKURbu9qYAXMvSfMkQAzlAMlVELyIKtwVJ2JKDWbyVkXBAW8gCPbxmE3IqN7b5SA5dyf1KZIb42Hie4abHfKCMWFo7o1uYAvUNYY/guDE0mHUEJ6si9hnGBzEZF9Ygi6CtAzIEbYLIyq2sWSOd2kLb8iYn93N2uWcXrtlGQczs9HBlUKN2IZDThhm+8fhKyq4tH1pFu3HHvmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDD2Rq9Yc5gb76M9RajbRJstYE3GIX/0vc8so5IOVEI=;
 b=Ys8W1VvF0F7M/nafzH/hd79B4qOmK5W8v7LYzJD3YQR1ry4fxWq9tmRAsIzWfxj2gvfK2k5fGvQiqZnz2Pgu8dLkKd3mtk4Cnb2vWFu6rcJ9kq+AMjuE2SHrUJqoBdCq0tW03CAfMXtIVqBh9zznmkAOTyh8PRAKqGvAO63y3cWEf3os8ucfoBMJTwaFF+2yY0xQTy44SQ6epnfCJcbrfkDSXRiyhM4N9WO9RXPfCnAt2ERVD9UhgtgX0dV70dHpSYkD6mN+/L76yUMe4dgjhNwSIKDud4HYOYjEAETQDWI3h0BhPZ71ki06LeV6BLmmO0dMX2fwYkH0N5c45E1tog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDD2Rq9Yc5gb76M9RajbRJstYE3GIX/0vc8so5IOVEI=;
 b=wX+Y3X2HtIQRLXbS9zd9ZfhN6oqqUlGun9QecdMo8ad14y9XV+gwtLolXuGbPmnyxeTuYMNiJm0aFuKEjpaxvD3rEPxZFUOSr6P84dAbdoWVagyMblQH6Slo3BujchzS7BN4W5kwPjyhZ01ME/Kfuo2Vx7t6Gm+VKeNOIPEie2g=
Received: from BN9PR03CA0087.namprd03.prod.outlook.com (2603:10b6:408:fc::32)
 by PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 19:32:21 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::87) by BN9PR03CA0087.outlook.office365.com
 (2603:10b6:408:fc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:32:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:32:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/10] drm/amdgpu: Add sdma instance specific functions
Date: Thu, 30 Mar 2023 15:31:50 -0400
Message-ID: <20230330193158.1134802-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330193158.1134802-1-alexander.deucher@amd.com>
References: <20230330193158.1134802-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3d6457-a566-4438-c4f8-08db31557b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A5pF3nCTydd1HeA3lNPbisjfOBPZIlL/pI6+XRy4GZW+5DJ6EjV3/7TemsiTL0DnJdPWVYAXPJiwQoT7mGuKEYrvLqTobuKS1/VuMoP3wld7YdOTS/HCnJZ6uIGF3vmKe9zBMAxxZPY10zmx0iysjfEl+lLCEvDjf9U+EVuKuz9h9jX7nt9661tx298LgBoMLqpMZqV0yQUDX7s7Zee8tH+9NqEVLV14q/mZSB+uOKOLyllKRF4AZVMZ1pVsmzH+hO8BmIBODSLCWiNf4KZW+VqPi0l6F9foSICrdfZn0Oru5UTqrsB1HOG5xWnw+Q2br2dMlBqKW/OUXFtEeZNEebJUvAn4nxJmny4KFX8FxMA3h8a6hXcSV6g5Puuz4y66lzHSiNzZ66waNO2BNm6gAJ/jNcCKqbcc3EKlKnNxQ67nQePVUjUJcojLRisBagxozHcLzcpgjg/mH+23pE+/eY0IcSpqK7tf1/J+q1b3E1BwltHNwyZzL+vPo+oOYmYYZlQqxJBAmMHgQXh5fl4gwtggJEbH4tXF0+ahs/OV8JM9kGKvOQdCQUpTOBthGNG8lVlj1zkCYaC1Qs/BZAvsUtCLXcwqruO1hXSOchdpXcFdBVkFIcmTqkr1QVY/ybi2+bepOc6ICq3swtpA8TfAtxeQLdpab7oIwzSTMyoWSmeOGDIbCwEmbrAyUQ2/uGTypj0vxTJiBG0isPtmQyelPqZimyMsEGeZQ7HxW4ujbM/WPo22GoID8PmgK9ckMXg4Wy7XFcLDU4fMP4unxycaSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(70586007)(6916009)(70206006)(4326008)(41300700001)(8676002)(8936002)(82740400003)(81166007)(2906002)(40460700003)(40480700001)(356005)(30864003)(5660300002)(186003)(16526019)(6666004)(1076003)(26005)(2616005)(82310400005)(336012)(36756003)(83380400001)(47076005)(426003)(86362001)(54906003)(316002)(7696005)(36860700001)(478600001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:32:21.6344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3d6457-a566-4438-c4f8-08db31557b7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858
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

SDMA 4.4.2 supports multiple instances. Add functions to support
handling of each SDMA instance separately.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 162 +++++++++++++----------
 1 file changed, 91 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 016813b295ac..6a971e15b4b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -94,7 +94,8 @@ static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
 	}
 }
 
-static void sdma_v4_4_2_init_golden_registers(struct amdgpu_device *adev)
+static void sdma_v4_4_2_inst_init_golden_registers(struct amdgpu_device *adev,
+						   uint32_t inst_mask)
 {
 	u32 val;
 	int i;
@@ -418,13 +419,14 @@ static void sdma_v4_4_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64
  *
  * Stop the gfx async dma ring buffers.
  */
-static void sdma_v4_4_2_gfx_stop(struct amdgpu_device *adev)
+static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
+				      uint32_t inst_mask)
 {
 	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
 	u32 rb_cntl, ib_cntl;
 	int i, unset = 0;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	for_each_inst(i, inst_mask) {
 		sdma[i] = &adev->sdma.instance[i].ring;
 
 		if ((adev->mman.buffer_funcs_ring == sdma[i]) && unset != 1) {
@@ -448,7 +450,8 @@ static void sdma_v4_4_2_gfx_stop(struct amdgpu_device *adev)
  *
  * Stop the compute async dma queues.
  */
-static void sdma_v4_4_2_rlc_stop(struct amdgpu_device *adev)
+static void sdma_v4_4_2_inst_rlc_stop(struct amdgpu_device *adev,
+				      uint32_t inst_mask)
 {
 	/* XXX todo */
 }
@@ -460,14 +463,15 @@ static void sdma_v4_4_2_rlc_stop(struct amdgpu_device *adev)
  *
  * Stop the page async dma ring buffers.
  */
-static void sdma_v4_4_2_page_stop(struct amdgpu_device *adev)
+static void sdma_v4_4_2_inst_page_stop(struct amdgpu_device *adev,
+				       uint32_t inst_mask)
 {
 	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
 	u32 rb_cntl, ib_cntl;
 	int i;
 	bool unset = false;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	for_each_inst(i, inst_mask) {
 		sdma[i] = &adev->sdma.instance[i].page;
 
 		if ((adev->mman.buffer_funcs_ring == sdma[i]) &&
@@ -495,7 +499,8 @@ static void sdma_v4_4_2_page_stop(struct amdgpu_device *adev)
  *
  * Halt or unhalt the async dma engines context switch.
  */
-static void sdma_v4_4_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
+static void sdma_v4_4_2_inst_ctx_switch_enable(struct amdgpu_device *adev,
+					       bool enable, uint32_t inst_mask)
 {
 	u32 f32_cntl, phase_quantum = 0;
 	int i;
@@ -524,7 +529,7 @@ static void sdma_v4_4_2_ctx_switch_enable(struct amdgpu_device *adev, bool enabl
 			unit  << SDMA_PHASE0_QUANTUM__UNIT__SHIFT;
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	for_each_inst(i, inst_mask) {
 		f32_cntl = RREG32_SDMA(i, regSDMA_CNTL);
 		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA_CNTL,
 				AUTO_CTXSW_ENABLE, enable ? 1 : 0);
@@ -538,7 +543,6 @@ static void sdma_v4_4_2_ctx_switch_enable(struct amdgpu_device *adev, bool enabl
 		/* Extend page fault timeout to avoid interrupt storm */
 		WREG32_SDMA(i, regSDMA_UTCL1_TIMEOUT, 0x00800080);
 	}
-
 }
 
 /**
@@ -546,22 +550,24 @@ static void sdma_v4_4_2_ctx_switch_enable(struct amdgpu_device *adev, bool enabl
  *
  * @adev: amdgpu_device pointer
  * @enable: enable/disable the DMA MEs.
+ * @inst_mask: mask of dma engine instances to be enabled
  *
  * Halt or unhalt the async dma engines.
  */
-static void sdma_v4_4_2_enable(struct amdgpu_device *adev, bool enable)
+static void sdma_v4_4_2_inst_enable(struct amdgpu_device *adev, bool enable,
+				    uint32_t inst_mask)
 {
 	u32 f32_cntl;
 	int i;
 
 	if (!enable) {
-		sdma_v4_4_2_gfx_stop(adev);
-		sdma_v4_4_2_rlc_stop(adev);
+		sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
+		sdma_v4_4_2_inst_rlc_stop(adev, inst_mask);
 		if (adev->sdma.has_page_queue)
-			sdma_v4_4_2_page_stop(adev);
+			sdma_v4_4_2_inst_page_stop(adev, inst_mask);
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	for_each_inst(i, inst_mask) {
 		f32_cntl = RREG32_SDMA(i, regSDMA_F32_CNTL);
 		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA_F32_CNTL, HALT, enable ? 0 : 1);
 		WREG32_SDMA(i, regSDMA_F32_CNTL, f32_cntl);
@@ -780,7 +786,8 @@ static void sdma_v4_4_2_init_pg(struct amdgpu_device *adev)
  * Set up the compute DMA queues and enable them.
  * Returns 0 for success, error for failure.
  */
-static int sdma_v4_4_2_rlc_resume(struct amdgpu_device *adev)
+static int sdma_v4_4_2_inst_rlc_resume(struct amdgpu_device *adev,
+				       uint32_t inst_mask)
 {
 	sdma_v4_4_2_init_pg(adev);
 
@@ -795,7 +802,8 @@ static int sdma_v4_4_2_rlc_resume(struct amdgpu_device *adev)
  * Loads the sDMA0/1 ucode.
  * Returns 0 for success, -EINVAL if the ucode is not available.
  */
-static int sdma_v4_4_2_load_microcode(struct amdgpu_device *adev)
+static int sdma_v4_4_2_inst_load_microcode(struct amdgpu_device *adev,
+					   uint32_t inst_mask)
 {
 	const struct sdma_firmware_header_v1_0 *hdr;
 	const __le32 *fw_data;
@@ -803,9 +811,9 @@ static int sdma_v4_4_2_load_microcode(struct amdgpu_device *adev)
 	int i, j;
 
 	/* halt the MEs */
-	sdma_v4_4_2_enable(adev, false);
+	sdma_v4_4_2_inst_enable(adev, false, inst_mask);
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	for_each_inst(i, inst_mask) {
 		if (!adev->sdma.instance[i].fw)
 			return -EINVAL;
 
@@ -831,38 +839,41 @@ static int sdma_v4_4_2_load_microcode(struct amdgpu_device *adev)
 }
 
 /**
- * sdma_v4_4_2_start - setup and start the async dma engines
+ * sdma_v4_4_2_inst_start - setup and start the async dma engines
  *
  * @adev: amdgpu_device pointer
  *
  * Set up the DMA engines and enable them.
  * Returns 0 for success, error for failure.
  */
-static int sdma_v4_4_2_start(struct amdgpu_device *adev)
+static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
+				  uint32_t inst_mask)
 {
 	struct amdgpu_ring *ring;
+	uint32_t tmp_mask;
 	int i, r = 0;
 
 	if (amdgpu_sriov_vf(adev)) {
-		sdma_v4_4_2_ctx_switch_enable(adev, false);
-		sdma_v4_4_2_enable(adev, false);
+		sdma_v4_4_2_inst_ctx_switch_enable(adev, false, inst_mask);
+		sdma_v4_4_2_inst_enable(adev, false, inst_mask);
 	} else {
 		/* bypass sdma microcode loading on Gopher */
 		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP &&
-		    !(adev->pdev->device == 0x49) && !(adev->pdev->device == 0x50)) {
-			r = sdma_v4_4_2_load_microcode(adev);
+		    adev->sdma.instance[0].fw) {
+			r = sdma_v4_4_2_inst_load_microcode(adev, inst_mask);
 			if (r)
 				return r;
 		}
 
 		/* unhalt the MEs */
-		sdma_v4_4_2_enable(adev, true);
+		sdma_v4_4_2_inst_enable(adev, true, inst_mask);
 		/* enable sdma ring preemption */
-		sdma_v4_4_2_ctx_switch_enable(adev, true);
+		sdma_v4_4_2_inst_ctx_switch_enable(adev, true, inst_mask);
 	}
 
 	/* start the gfx rings and rlc compute queues */
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	tmp_mask = inst_mask;
+	for_each_inst(i, tmp_mask) {
 		uint32_t temp;
 
 		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
@@ -889,15 +900,16 @@ static int sdma_v4_4_2_start(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
-		sdma_v4_4_2_ctx_switch_enable(adev, true);
-		sdma_v4_4_2_enable(adev, true);
+		sdma_v4_4_2_inst_ctx_switch_enable(adev, true, inst_mask);
+		sdma_v4_4_2_inst_enable(adev, true, inst_mask);
 	} else {
-		r = sdma_v4_4_2_rlc_resume(adev);
+		r = sdma_v4_4_2_inst_rlc_resume(adev, inst_mask);
 		if (r)
 			return r;
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	tmp_mask = inst_mask;
+	for_each_inst(i, tmp_mask) {
 		ring = &adev->sdma.instance[i].ring;
 
 		r = amdgpu_ring_test_helper(ring);
@@ -1383,14 +1395,17 @@ static int sdma_v4_4_2_hw_init(void *handle)
 {
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t inst_mask;
 
+	/* TODO: Check if this is needed */
 	if (adev->flags & AMD_IS_APU)
 		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, false);
 
+	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
 	if (!amdgpu_sriov_vf(adev))
-		sdma_v4_4_2_init_golden_registers(adev);
+		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
 
-	r = sdma_v4_4_2_start(adev);
+	r = sdma_v4_4_2_inst_start(adev, inst_mask);
 
 	return r;
 }
@@ -1398,22 +1413,27 @@ static int sdma_v4_4_2_hw_init(void *handle)
 static int sdma_v4_4_2_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t inst_mask;
 	int i;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
 			       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
 	}
 
-	sdma_v4_4_2_ctx_switch_enable(adev, false);
-	sdma_v4_4_2_enable(adev, false);
+	sdma_v4_4_2_inst_ctx_switch_enable(adev, false, inst_mask);
+	sdma_v4_4_2_inst_enable(adev, false, inst_mask);
 
 	return 0;
 }
 
+static int sdma_v4_4_2_set_clockgating_state(void *handle,
+					     enum amd_clockgating_state state);
+
 static int sdma_v4_4_2_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1650,15 +1670,39 @@ static int sdma_v4_4_2_process_srbm_write_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void sdma_v4_4_2_update_medium_grain_clock_gating(
-		struct amdgpu_device *adev,
-		bool enable)
+static void sdma_v4_4_2_inst_update_medium_grain_light_sleep(
+	struct amdgpu_device *adev, bool enable, uint32_t inst_mask)
+{
+	uint32_t data, def;
+	int i;
+
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_LS)) {
+		for_each_inst(i, inst_mask) {
+			/* 1-not override: enable sdma mem light sleep */
+			def = data = RREG32_SDMA(i, regSDMA_POWER_CNTL);
+			data |= SDMA_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
+			if (def != data)
+				WREG32_SDMA(i, regSDMA_POWER_CNTL, data);
+		}
+	} else {
+		for_each_inst(i, inst_mask) {
+			/* 0-override:disable sdma mem light sleep */
+			def = data = RREG32_SDMA(i, regSDMA_POWER_CNTL);
+			data &= ~SDMA_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
+			if (def != data)
+				WREG32_SDMA(i, regSDMA_POWER_CNTL, data);
+		}
+	}
+}
+
+static void sdma_v4_4_2_inst_update_medium_grain_clock_gating(
+	struct amdgpu_device *adev, bool enable, uint32_t inst_mask)
 {
 	uint32_t data, def;
 	int i;
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)) {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
+		for_each_inst(i, inst_mask) {
 			def = data = RREG32_SDMA(i, regSDMA_CLK_CTRL);
 			data &= ~(SDMA_CLK_CTRL__SOFT_OVERRIDE7_MASK |
 				  SDMA_CLK_CTRL__SOFT_OVERRIDE6_MASK |
@@ -1672,7 +1716,7 @@ static void sdma_v4_4_2_update_medium_grain_clock_gating(
 				WREG32_SDMA(i, regSDMA_CLK_CTRL, data);
 		}
 	} else {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
+		for_each_inst(i, inst_mask) {
 			def = data = RREG32_SDMA(i, regSDMA_CLK_CTRL);
 			data |= (SDMA_CLK_CTRL__SOFT_OVERRIDE7_MASK |
 				 SDMA_CLK_CTRL__SOFT_OVERRIDE6_MASK |
@@ -1688,45 +1732,21 @@ static void sdma_v4_4_2_update_medium_grain_clock_gating(
 	}
 }
 
-
-static void sdma_v4_4_2_update_medium_grain_light_sleep(
-		struct amdgpu_device *adev,
-		bool enable)
-{
-	uint32_t data, def;
-	int i;
-
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_LS)) {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			/* 1-not override: enable sdma mem light sleep */
-			def = data = RREG32_SDMA(0, regSDMA_POWER_CNTL);
-			data |= SDMA_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
-			if (def != data)
-				WREG32_SDMA(0, regSDMA_POWER_CNTL, data);
-		}
-	} else {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-		/* 0-override:disable sdma mem light sleep */
-			def = data = RREG32_SDMA(0, regSDMA_POWER_CNTL);
-			data &= ~SDMA_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
-			if (def != data)
-				WREG32_SDMA(0, regSDMA_POWER_CNTL, data);
-		}
-	}
-}
-
 static int sdma_v4_4_2_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t inst_mask;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	sdma_v4_4_2_update_medium_grain_clock_gating(adev,
-			state == AMD_CG_STATE_GATE);
-	sdma_v4_4_2_update_medium_grain_light_sleep(adev,
-			state == AMD_CG_STATE_GATE);
+	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
+
+	sdma_v4_4_2_inst_update_medium_grain_clock_gating(
+		adev, state == AMD_CG_STATE_GATE, inst_mask);
+	sdma_v4_4_2_inst_update_medium_grain_light_sleep(
+		adev, state == AMD_CG_STATE_GATE, inst_mask);
 	return 0;
 }
 
-- 
2.39.2

