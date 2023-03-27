Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E4EC761A6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B707B10E741;
	Mon, 27 Mar 2023 19:47:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6543110E73C
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7RwxvCLw7QJ0IdO3vYBmTpB6avo6lbX9XFFa7aisMEZuZt5j9kS6jgI4I3tboZvkxfmVt1zyUv4Lix2vqXc/pfrzKsCIOKeN5JihAppAW9T1K+W21vFGQIBhGTYgLdnW/RirWDJm4OAd8rF/fMgj42Z7xGWFt9oRAGXTyxzmiiAx2GE+Hfom7LK5YUH4IrQicJSv7OeAanWju53D/mSTWN2xsPhUAdN2nfOt1uxHgD7rFWIHV3emJFsOUW9X3BjjktVsvnrTjsJH5T6nW4KKKZQ3do1ilrwE6+AlsAxBeF66WC7CnLFHJKvLntqmnQ4WwttSFYtg9bBOxwJzO9x2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ialVG9Sejxb1t/D5AkvjbzvQWMkhdI2nFnWPcaCbRpY=;
 b=VBjtpeLuBok124nkXtP0nVZsT3qBXH/zk6u9ZV53QwcIaJu7kU0XTIBKx6GjVSfa4jb6kOw11cyNfeK2sLvqRoRjQTHJ9emcfmzvdtXmxttlRCd0VGSfmX+dPR/D+mdDeMXLYNAyDMF4HKMpxL2hBev3+tTulVxTvBR6uc6wpqGHe7Hfw8P70ND1/cUK9+u/OcJBVv9iUdlm8Rc5Bag8zM2NWFgrkUlS3ph+vWedb+UXCx/hoZt1mT7W/Wi3BypI1jOmEAPi4cMZK0DIzgchcUQl9sEf9MB9m/wGtdqlY6PUMF9Ez1JkgUisaiB87ArP95FYO4sTyqID4NLo4A4iBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ialVG9Sejxb1t/D5AkvjbzvQWMkhdI2nFnWPcaCbRpY=;
 b=nCNPPLeiLahR8YQfshdKmbD84HYeEqyi2jAJ8ZQKmWegOkECYjSrj3Pf7UzED7ECnbwej7CzavnSvIQxYTw7atJfAIKBCBejXTcIQkS2KzvpTP9mlqZiQNZrzhNNL0akBGJ9xLkPI5XLSyFQ+B9yzhn+hSJMDiUkB/WffA/+AGA=
Received: from DS7PR03CA0192.namprd03.prod.outlook.com (2603:10b6:5:3b6::17)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 19:46:44 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::db) by DS7PR03CA0192.outlook.office365.com
 (2603:10b6:5:3b6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Mon, 27 Mar 2023 19:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 19:46:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:46:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/11] drm/amdgpu/jpeg: add multiple jpeg rings support for
 vcn4_0_3
Date: Mon, 27 Mar 2023 15:46:22 -0400
Message-ID: <20230327194622.8109-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327194622.8109-1-alexander.deucher@amd.com>
References: <20230327194622.8109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|CY8PR12MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7141ca-387c-4b99-b468-08db2efbfe6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LkRqR/T61UghVNMI74+sRBH1NrJ7KNo3e77EybwBA1brF07GHbDHteV4qSGtpnlIkjr4DF4Qj/wHveGM8z5IJjZhi6PoRLLEyGyBziY9LWMNQ5P6k0xRzrv+o57ny1BNy7z3z+NnjOo1UgomJS3+EIGUa27nDxzDyRl6J+8NLBQtnh+ZnB5Sn5x+vUidankTD96w12zA6+dZ3YdENA5nlAiLOmoBodin41jw88XFS9gMa/4iny7ULmVx+UaTQM3shzR6nKT+ORiIJJt3rWGFPz1TJcRyfbtY5fhEbhAlEWU5FUNdrA/FCls3+pEgZDrIaaq1Yg64/2o6X6kfYCeUe9lfQXCaNtZ6XF8ePd3J6lPlq4yM8DbGUm+e37WI5poqkaKEhcAh7lA6G9+OJFD60DZPCLlXkAZk8q6ZAuS5m7CZFc/9c8ex1d7yYTbNemaHk1DBvwsIMaHHlVW3acHdRqzIsxLHjmEYOg+WSsGFTtsKQZHi3DXkA7ARcGGSq4/OmqfA7qNaJbLDnCcXsP0OXG4FSq3/6ySx1xbuVDp2EmL1mZsEST5vXJaRRu6UH+cL/to+01EV37iK8CrBFdSLVE9UmDr/iisJW0oKxyqW2QDPIdu4DHa0uP61l0xtrieWR6tUdddQSSCJMRkQ57AB87j0ceTfNpfBFuKsluCfDfsAvfvQCM+FZYvK7CwJO7khnDSAJPZADBFaWR2W6JJg+uYnQCcSyzhEYCDe3nNy8z8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(2616005)(47076005)(83380400001)(336012)(426003)(41300700001)(36860700001)(36756003)(86362001)(5660300002)(356005)(8936002)(81166007)(82740400003)(40460700003)(54906003)(7696005)(478600001)(70586007)(8676002)(4326008)(6916009)(70206006)(2906002)(40480700001)(82310400005)(30864003)(6666004)(16526019)(1076003)(316002)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:46:44.2572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7141ca-387c-4b99-b468-08db2efbfe6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Add multiple jpeg rings support for vcn4_0_3

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 214 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h |   1 +
 2 files changed, 147 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 784c83994ca1..0d3509409d3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -29,7 +29,7 @@
 
 #include "vcn/vcn_4_0_3_offset.h"
 #include "vcn/vcn_4_0_3_sh_mask.h"
-#include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
 
 enum jpeg_engin_status {
 	UVD_PGFSM_STATUS__UVDJ_PWR_ON  = 0,
@@ -41,6 +41,17 @@ static void jpeg_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v4_0_3_set_powergating_state(void *handle,
 				enum amd_powergating_state state);
 
+static int amdgpu_ih_srcid_jpeg[] = {
+	VCN_4_0__SRCID__JPEG_DECODE,
+	VCN_4_0__SRCID__JPEG1_DECODE,
+	VCN_4_0__SRCID__JPEG2_DECODE,
+	VCN_4_0__SRCID__JPEG3_DECODE,
+	VCN_4_0__SRCID__JPEG4_DECODE,
+	VCN_4_0__SRCID__JPEG5_DECODE,
+	VCN_4_0__SRCID__JPEG6_DECODE,
+	VCN_4_0__SRCID__JPEG7_DECODE
+};
+
 /**
  * jpeg_v4_0_3_early_init - set function pointers
  *
@@ -69,13 +80,15 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring;
-	int r;
-
-	/* JPEG TRAP */
-	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
-		VCN_2_0__SRCID__JPEG_DECODE, &adev->jpeg.inst->irq);
-	if (r)
-		return r;
+	int i, r;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
+		/* JPEG TRAP */
+		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+				amdgpu_ih_srcid_jpeg[i], &adev->jpeg.inst->irq);
+		if (r)
+			return r;
+	}
 
 	r = amdgpu_jpeg_sw_init(adev);
 	if (r)
@@ -85,17 +98,22 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 	if (r)
 		return r;
 
-	ring = adev->jpeg.inst->ring_dec;
-	ring->use_doorbell = false;
-	ring->vm_hub = AMDGPU_MMHUB0(0);
-	sprintf(ring->name, "jpeg_dec");
-	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
-			     AMDGPU_RING_PRIO_DEFAULT, NULL);
-	if (r)
-		return r;
-
-	adev->jpeg.internal.jpeg_pitch[0] = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
-	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
+	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
+		ring = &adev->jpeg.inst->ring_dec[i];
+		ring->use_doorbell = false;
+		ring->vm_hub = AMDGPU_MMHUB0(0);
+		sprintf(ring->name, "jpeg_dec_%d", i);
+		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
+					AMDGPU_RING_PRIO_DEFAULT, NULL);
+		if (r)
+			return r;
+
+		adev->jpeg.internal.jpeg_pitch[i] =
+			regUVD_JRBC0_UVD_JRBC_SCRATCH0_INTERNAL_OFFSET;
+		adev->jpeg.inst->external.jpeg_pitch[i] =
+			SOC15_REG_OFFSET1(JPEG, 0, regUVD_JRBC0_UVD_JRBC_SCRATCH0,
+			(i?(0x40 * i - 0xc80):0));
+	}
 
 	return 0;
 }
@@ -130,14 +148,18 @@ static int jpeg_v4_0_3_sw_fini(void *handle)
 static int jpeg_v4_0_3_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
-	int r;
+	struct amdgpu_ring *ring;
+	int i, r;
 
-	r = amdgpu_ring_test_helper(ring);
-	if (!r)
-		DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
+	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
+		ring = &adev->jpeg.inst->ring_dec[i];
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
+	}
+	DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
 
-	return r;
+	return 0;
 }
 
 /**
@@ -150,13 +172,14 @@ static int jpeg_v4_0_3_hw_init(void *handle)
 static int jpeg_v4_0_3_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int ret = 0;
 
 	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
-		jpeg_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		ret = jpeg_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -204,6 +227,7 @@ static int jpeg_v4_0_3_resume(void *handle)
 static void jpeg_v4_0_3_disable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data;
+	int i;
 
 	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
 	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG)
@@ -216,16 +240,16 @@ static void jpeg_v4_0_3_disable_clock_gating(struct amdgpu_device *adev)
 	WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
 
 	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE);
-	data &= ~(JPEG_CGC_GATE__JPEG0_DEC_MASK
-		| JPEG_CGC_GATE__JPEG2_DEC_MASK
-		| JPEG_CGC_GATE__JMCIF_MASK
-		| JPEG_CGC_GATE__JRBBM_MASK);
+	data &= ~(JPEG_CGC_GATE__JMCIF_MASK | JPEG_CGC_GATE__JRBBM_MASK);
+	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i)
+		data &= ~(JPEG_CGC_GATE__JPEG0_DEC_MASK << i);
 	WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
 }
 
 static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data;
+	int i;
 
 	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
 	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG)
@@ -238,10 +262,9 @@ static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev)
 	WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
 
 	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE);
-	data |= (JPEG_CGC_GATE__JPEG0_DEC_MASK
-		|JPEG_CGC_GATE__JPEG2_DEC_MASK
-		|JPEG_CGC_GATE__JMCIF_MASK
-		|JPEG_CGC_GATE__JRBBM_MASK);
+	data |= (JPEG_CGC_GATE__JMCIF_MASK | JPEG_CGC_GATE__JRBBM_MASK);
+	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i)
+		data |= (JPEG_CGC_GATE__JPEG0_DEC_MASK << i);
 	WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
 }
 
@@ -255,6 +278,7 @@ static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev)
 static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
+	int i;
 
 	WREG32_SOC15(JPEG, 0, regUVD_PGFSM_CONFIG,
 		1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
@@ -280,22 +304,32 @@ static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
 	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL), 0,
 		~UVD_JMI_CNTL__SOFT_RESET_MASK);
 
-	/* enable System Interrupt for JRBC */
-	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regJPEG_SYS_INT_EN),
-		JPEG_SYS_INT_EN__DJRBC0_MASK,
-		~JPEG_SYS_INT_EN__DJRBC0_MASK);
-
-	WREG32_SOC15(JPEG, 0, regUVD_JMI0_UVD_LMI_JRBC_RB_VMID, 0);
-	WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
-	WREG32_SOC15(JPEG, 0, regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
-		lower_32_bits(ring->gpu_addr));
-	WREG32_SOC15(JPEG, 0, regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
-		upper_32_bits(ring->gpu_addr));
-	WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR, 0);
-	WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR, 0);
-	WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_CNTL, 0x00000002L);
-	WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_SIZE, ring->ring_size / 4);
-	ring->wptr = RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR);
+	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
+		unsigned int reg_offset = (i?(0x40 * i - 0xc80):0);
+
+		ring = &adev->jpeg.inst->ring_dec[i];
+
+		/* enable System Interrupt for JRBC */
+		WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regJPEG_SYS_INT_EN),
+			JPEG_SYS_INT_EN__DJRBC0_MASK << i,
+			~(JPEG_SYS_INT_EN__DJRBC0_MASK << i));
+
+		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JMI0_UVD_LMI_JRBC_RB_VMID, reg_offset, 0);
+		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_CNTL, reg_offset,
+			(0x00000001L | 0x00000002L));
+		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+			reg_offset, lower_32_bits(ring->gpu_addr));
+		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+			reg_offset, upper_32_bits(ring->gpu_addr));
+		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR, reg_offset, 0);
+		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR, reg_offset, 0);
+		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_CNTL, reg_offset,
+			0x00000002L);
+		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_SIZE, reg_offset,
+			ring->ring_size / 4);
+		ring->wptr = RREG32_SOC15_OFFSET(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
+			reg_offset);
+	}
 
 	return 0;
 }
@@ -342,7 +376,8 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	return RREG32_SOC15(JPEG, ring->me, regUVD_JRBC0_UVD_JRBC_RB_RPTR);
+	return RREG32_SOC15_OFFSET(JPEG, ring->me, regUVD_JRBC0_UVD_JRBC_RB_RPTR,
+			ring->pipe?(0x40 * ring->pipe - 0xc80):0);
 }
 
 /**
@@ -359,7 +394,8 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	if (ring->use_doorbell)
 		return adev->wb.wb[ring->wptr_offs];
 	else
-		return RREG32_SOC15(JPEG, ring->me, regUVD_JRBC0_UVD_JRBC_RB_WPTR);
+		return RREG32_SOC15_OFFSET(JPEG, ring->me, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
+			ring->pipe?(0x40 * ring->pipe - 0xc80):0);
 }
 
 /**
@@ -377,8 +413,8 @@ static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring)
 		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
-		WREG32_SOC15(JPEG, ring->me,
-			regUVD_JRBC0_UVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
+		WREG32_SOC15_OFFSET(JPEG, ring->me, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
+			(ring->pipe?(0x40 * ring->pipe - 0xc80):0), lower_32_bits(ring->wptr));
 	}
 }
 
@@ -393,7 +429,7 @@ static void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring)
 {
 	amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, 0x62a04);/* TODO: PCTL0_MMHUB_DEEPSLEEP_IB */
+	amdgpu_ring_write(ring, 0x62a04); /* PCTL0_MMHUB_DEEPSLEEP_IB */
 
 	amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
 		0, 0, PACKETJ_TYPE0));
@@ -605,20 +641,36 @@ static void jpeg_v4_0_3_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count)
 static bool jpeg_v4_0_3_is_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool ret;
+	int i;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
+		unsigned int reg_offset = (i?(0x40 * i - 0xc80):0);
+
+		ret &= ((RREG32_SOC15_OFFSET(JPEG, 0,
+				regUVD_JRBC0_UVD_JRBC_STATUS, reg_offset) &
+				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
+				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+	}
 
-	return ((RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS) &
-		UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
-		UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+	return ret;
 }
 
 static int jpeg_v4_0_3_wait_for_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int ret;
+	int i;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
+		unsigned int reg_offset = (i?(0x40 * i - 0xc80):0);
+
+		ret &= SOC15_WAIT_ON_RREG_OFFSET(JPEG, 0,
+			regUVD_JRBC0_UVD_JRBC_STATUS, reg_offset,
+			UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
+			UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+	}
 
-	ret = SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS,
-		UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
-		UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
 	return ret;
 }
 
@@ -626,7 +678,7 @@ static int jpeg_v4_0_3_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	bool enable = (state == AMD_CG_STATE_GATE);
+	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
 
 	if (enable) {
 		if (!jpeg_v4_0_3_is_idle(handle))
@@ -674,8 +726,29 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
 	DRM_DEV_DEBUG(adev->dev, "IH: JPEG TRAP\n");
 
 	switch (entry->src_id) {
-	case VCN_2_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
+	case VCN_4_0__SRCID__JPEG_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[0]);
+		break;
+	case VCN_4_0__SRCID__JPEG1_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[1]);
+		break;
+	case VCN_4_0__SRCID__JPEG2_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[2]);
+		break;
+	case VCN_4_0__SRCID__JPEG3_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[3]);
+		break;
+	case VCN_4_0__SRCID__JPEG4_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[4]);
+		break;
+	case VCN_4_0__SRCID__JPEG5_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[5]);
+		break;
+	case VCN_4_0__SRCID__JPEG6_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[6]);
+		break;
+	case VCN_4_0__SRCID__JPEG7_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[7]);
 		break;
 	default:
 		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
@@ -737,8 +810,13 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 
 static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
-	adev->jpeg.inst->ring_dec->funcs = &jpeg_v4_0_3_dec_ring_vm_funcs;
-	adev->jpeg.inst->ring_dec->me = 0;
+	int i;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
+		adev->jpeg.inst->ring_dec[i].funcs = &jpeg_v4_0_3_dec_ring_vm_funcs;
+		adev->jpeg.inst->ring_dec[i].me = 0;
+		adev->jpeg.inst->ring_dec[i].pipe = i;
+	}
 	DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
 }
 
@@ -749,7 +827,7 @@ static const struct amdgpu_irq_src_funcs jpeg_v4_0_3_irq_funcs = {
 
 static void jpeg_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
 {
-	adev->jpeg.inst->irq.num_types = 1;
+	adev->jpeg.inst->irq.num_types = adev->jpeg.num_jpeg_rings;
 	adev->jpeg.inst->irq.funcs = &jpeg_v4_0_3_irq_funcs;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
index ca03d17e13fa..70a5f030d5f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
@@ -41,6 +41,7 @@
 #define regUVD_JRBC_RB_REF_DATA_INTERNAL_OFFSET				0x4084
 #define regUVD_JRBC_STATUS_INTERNAL_OFFSET				0x4089
 #define regUVD_JPEG_PITCH_INTERNAL_OFFSET				0x4043
+#define regUVD_JRBC0_UVD_JRBC_SCRATCH0_INTERNAL_OFFSET			0x4094
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
-- 
2.39.2

