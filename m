Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1ACC74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D1810EC2B;
	Wed, 29 Mar 2023 20:10:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E86E10EC1C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:10:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDwlVa9BRXbir3cc397Jg87r9ECxD6Hr+XrpQsvkNC1oboIi1Bn6+A/ewIARfMF35Xz95gXMtE0i1V3Jz+5UHGa6cgYy0YbMXiHE2oFUBUzcaTayv8H6gN+9rH7iyGbs9nRdAdUFBPBpRx2b56OC8MgAR2z45Y+UmpQT1kaK13bDn+uCb+Edt2bnX39HxlheJaxiMix6tO3t8SQ1MEATCePiLVB/j1851zTFxxn8zNYY4mocLkk35TP+7//DGvTyrALhIaOXnf9bqbDDkj4U9RxS1mD+CL0f9sqn2ehSLaT/2KSZW5UpbKJfBMXq1USvJnKTUOJR9E51/A5LAo5Q0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRWhNsyzkJ0D47U3MiSgwa1QBAt5ZotUVKW7enJE2xw=;
 b=Ny6cKXzsVRAXiItkCc/sUNyiM4hE9ZTp2a4plFhq/xiR9UZYSRi5I1FkvbXR76M/r/IfTJvjmVerN8YjElHmLzRtkpjS4lt9+Xjq24rjdBdDaEYfPQQV1F8qa933fmpwKHb8d0MO2cOUputhHybyAHfFCDltDWwegpR3Smu11sFPBAtST0n+GfxOtwPkujjcKFW+Kf+d0OrPSKU5bQXkvkRVCQUbG0+bBrOCvgQPuYNSj+0FlJRddFzKrKjODgPMI5gRwMMmuQYfkN0Rggs17Nr+8DnWR0Sk/o+LJMrMWpBzTLUg0gWse7YBuWK/MgKPTEmvuRxx5C13sj9BFreuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRWhNsyzkJ0D47U3MiSgwa1QBAt5ZotUVKW7enJE2xw=;
 b=HGvG8F2VYN5SNU8VE20leqDPpE50ayiWEX5Syq4cs0PAlAXoeHugv2RWBNGEpJhQ3/6WE7ROyiXRjQsiIewATGDUCzu74/FcLKdzqOqjffOuD1Rly5Y0V2Vl0diaguzIhV0HdeSHGIOiBDUqAo100EvK0tv+YlINIR2vf7vC2sY=
Received: from MW4PR04CA0362.namprd04.prod.outlook.com (2603:10b6:303:81::7)
 by DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 20:10:01 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::82) by MW4PR04CA0362.outlook.office365.com
 (2603:10b6:303:81::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:10:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:10:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:09:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amdgpu: Use instance table for sdma 4.4.2
Date: Wed, 29 Mar 2023 16:09:28 -0400
Message-ID: <20230329200930.1982035-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329200930.1982035-1-alexander.deucher@amd.com>
References: <20230329200930.1982035-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|DM4PR12MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da27727-6397-415e-31ab-08db30919415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJxEnE+XSUly7VIOQFQ+/JW9ti3/PHdUlnIz5ji0jv9XkbKEsJeXHEYEzrc9ieBl6e2uyH6m1P+ur8MZsewop5fbSJRMA9B1xvVxcyDDpltOEhdLqUL/N8Wp3XPtRR4LzD292gs/XAmvlha1fLHGnBNKFL38gGDVwiiII9AQdmBxyHbZTpqyBpoY4Jnf83uFFT9j/WuVratx2bJeMk96l+liO1qyenqWSr1DnpBRZG3XI+tYlKQs1eWSm5KhziUuitaoVk1Hk2diH3xmhAJ1rFDHCaqGZjhaDkoOEayqzdGA2FWeW/JQsoJGF6jWRw7MfnyJwe8hjh18uY3CHUkUz7dyIkcY/zb9dssKBSpR6lfIgSq1qquTX4zB5DYAiBCJRVvyRr7xEzPWFpkx83JhwENwfqtNk7gEhTAQKtZXyy8jx0Y1IgvDoJKWndRXn8lDPNUxbECf2Z+FZ821SxCaFIqYUWYXg4uqo6eSBs4ZaGulRKFC+h999lCQOuCX93csZ6tN+wPThcHndyyykpWZlAtq0hx80MDjixNkcfLMlAQAUeZXbPnRhW7t9nfBC3VpPWSmk15zpbaSm1dCdPfee2Ne9rQa/bKQD6i2poTXfXm/H8a6NPqHUNG/2CtP5vrEHlQGEaYw3wwJAIPt6pTcGwEr1u9lPKvsOqWh0E+AXOyuiQiWPcsQF2wvkdmDxbNOh5CqlaAZo8KzZy0QtPsgckTgDddNRCUdGvmeKTOOGBw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(1076003)(6666004)(356005)(82740400003)(81166007)(26005)(2616005)(47076005)(186003)(16526019)(36860700001)(426003)(2906002)(5660300002)(336012)(40460700003)(8936002)(36756003)(82310400005)(478600001)(316002)(54906003)(7696005)(4326008)(86362001)(40480700001)(6916009)(41300700001)(70206006)(8676002)(70586007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:10:01.4146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da27727-6397-415e-31ab-08db30919415
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

For ASICs with sdma IP v4.4.2, add mapping for logical to physical
instances.

v2:
	Register accesses on bare metal should be based on physical
instance. Use GET_INST() to get physical instance.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  7 ++--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |  7 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 38 ++++++++++++++-----
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 5daec0b45545..772774615cb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -43,9 +43,10 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 					unsigned int engine_id,
 					unsigned int queue_id)
 {
-	uint32_t sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, engine_id,
-					regSDMA_RLC0_RB_CNTL) -
-					regSDMA_RLC0_RB_CNTL;
+	uint32_t sdma_engine_reg_base =
+		SOC15_REG_OFFSET(SDMA0, GET_INST(SDMA0, engine_id),
+				 regSDMA_RLC0_RB_CNTL) -
+		regSDMA_RLC0_RB_CNTL;
 	uint32_t retval = sdma_engine_reg_base +
 		  queue_id * (regSDMA_RLC1_RB_CNTL - regSDMA_RLC0_RB_CNTL);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 9353f04c5dd9..dfbf5973efed 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -75,7 +75,10 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 			bool use_doorbell, int doorbell_index, int doorbell_size)
 {
 	u32 doorbell_range = 0, doorbell_ctrl = 0;
-	int aid_id = adev->sdma.instance[instance].aid_id;
+	int aid_id, dev_inst;
+
+	dev_inst = GET_INST(SDMA0, instance);
+	aid_id = adev->sdma.instance[instance].aid_id;
 
 	if (use_doorbell == false)
 		return;
@@ -93,7 +96,7 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 		REG_SET_FIELD(doorbell_ctrl, S2A_DOORBELL_ENTRY_1_CTRL,
 			S2A_DOORBELL_PORT1_RANGE_SIZE, doorbell_size);
 
-	switch (instance % adev->sdma.num_inst_per_aid) {
+	switch (dev_inst % adev->sdma.num_inst_per_aid) {
 	case 0:
 		WREG32(SOC15_REG_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_1) +
 			4 * aid_id, doorbell_range);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9b53174925f8..4350939105c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -57,7 +57,9 @@ static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
 		u32 instance, u32 offset)
 {
-	return (adev->reg_offset[SDMA0_HWIP][instance][0] + offset);
+	u32 dev_inst = GET_INST(SDMA0, instance);
+
+	return (adev->reg_offset[SDMA0_HWIP][dev_inst][0] + offset);
 }
 
 static unsigned sdma_v4_4_2_seq_to_irq_id(int seq_num)
@@ -1475,16 +1477,31 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
-	uint32_t instance;
+	uint32_t instance, i;
 
 	DRM_DEBUG("IH: SDMA trap\n");
 	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
-	instance += node_id_to_phys_map[entry->node_id] *
-			adev->sdma.num_inst_per_aid;
+
+	/* Client id gives the SDMA instance in AID. To know the exact SDMA
+	 * instance, interrupt entry gives the node id which corresponds to the AID instance.
+	 * Match node id with the AID id associated with the SDMA instance. */
+	for (i = instance; i < adev->sdma.num_instances;
+	     i += adev->sdma.num_inst_per_aid) {
+		if (adev->sdma.instance[i].aid_id ==
+		    node_id_to_phys_map[entry->node_id])
+			break;
+	}
+
+	if (i >= adev->sdma.num_instances) {
+		dev_WARN_ONCE(
+			adev->dev, 1,
+			"Couldn't find the right sdma instance in trap handler");
+		return 0;
+	}
 
 	switch (entry->ring_id) {
 	case 0:
-		amdgpu_fence_process(&adev->sdma.instance[instance].ring);
+		amdgpu_fence_process(&adev->sdma.instance[i].ring);
 		break;
 	default:
 		break;
@@ -1717,12 +1734,12 @@ static void sdma_v4_4_2_get_clockgating_state(void *handle, u64 *flags)
 		*flags = 0;
 
 	/* AMD_CG_SUPPORT_SDMA_MGCG */
-	data = RREG32(SOC15_REG_OFFSET(SDMA0, 0, regSDMA_CLK_CTRL));
+	data = RREG32(SOC15_REG_OFFSET(SDMA0, GET_INST(SDMA0, 0), regSDMA_CLK_CTRL));
 	if (!(data & SDMA_CLK_CTRL__SOFT_OVERRIDE7_MASK))
 		*flags |= AMD_CG_SUPPORT_SDMA_MGCG;
 
 	/* AMD_CG_SUPPORT_SDMA_LS */
-	data = RREG32(SOC15_REG_OFFSET(SDMA0, 0, regSDMA_POWER_CNTL));
+	data = RREG32(SOC15_REG_OFFSET(SDMA0, GET_INST(SDMA0, 0), regSDMA_POWER_CNTL));
 	if (data & SDMA_POWER_CNTL__MEM_POWER_OVERRIDE_MASK)
 		*flags |= AMD_CG_SUPPORT_SDMA_LS;
 }
@@ -1809,7 +1826,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 
 static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
 {
-	int i;
+	int i, dev_inst;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		adev->sdma.instance[i].ring.funcs = &sdma_v4_4_2_ring_funcs;
@@ -1820,7 +1837,10 @@ static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
 			adev->sdma.instance[i].page.me = i;
 		}
 
-		adev->sdma.instance[i].aid_id = i / adev->sdma.num_inst_per_aid;
+		dev_inst = GET_INST(SDMA0, i);
+		/* AID to which SDMA belongs depends on physical instance */
+		adev->sdma.instance[i].aid_id =
+			dev_inst / adev->sdma.num_inst_per_aid;
 	}
 }
 
-- 
2.39.2

