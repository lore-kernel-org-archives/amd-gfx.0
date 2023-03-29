Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0679C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3065E10EC2D;
	Wed, 29 Mar 2023 20:11:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0805A10EC28
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMlW704+c3Uc40ZuRJiOXlI9Lwp7cnYVVmA7TWMUyVU1LuDTK8GmU5KBHTwTIr7gZyaFwxVXIXp6UyuTuTs8nkQhZhw64+UOdP/cxSkmTbYE1JMOGjS09ye+akbPKoGDJLC9R7qwxva6zoou6HHZ0FskSvNaO16aLET41Pi52/EEACULIrsYw/82wvsUncuxSZICW1Gapg/GfXqKyELUUUQKQrs2jeLxganva7f5DtQKV8gNKMomuvGAA9zCLohAcyCBfoidsCBjrMt8RpYIJWpKXUqZNZqtjZ5w1RgfK8XBeT/Sb2O9XNYY7h2FK1ChagNfgFAaVNCi2gjVelFkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOXvlOOni6nw9gofZDQlTwhoiC1dD3wEgpVHaRr5Puk=;
 b=Mrbd0+9N76LKl2wD1hm6gHKYt7PufE2hkYiO0SaPvwT6hz3XZHxFnxvJQmP2f1yYXTMGnABNVOoGlSBEmHdt+nkimHF9cYVU2A9EpGFzMcQGrdsIHJrMeMcDjjvpUjdo3sU2SJAJzTtXYifHMGQpn5DvM3B8XCKEq024e5/IEgS8+IV93DQSVjZbx/dqE56kjZweKuB4dRXEI263HcPc9Qo9FtiHuLmvQakTxzNHRt9bBEyTmDrQCEsvc5c64mCw1BzVZGuS8gqKh+BcI2aJjrlaXGYV17YIgXdUGZ8V0Id6Jt0IRmV8tAONgFC2+Rb03y7zV+j7RsFvNj19ihOQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOXvlOOni6nw9gofZDQlTwhoiC1dD3wEgpVHaRr5Puk=;
 b=PYnWSgbT+2pGVu490M3hWmo0yil4d5S8E742KJumItevWSXgfuL4p3mDdciaHlEB7DcuU9r8oA91YXMJFdmf0DU/HA+eGq9xR9ZgJU8zboXXd4G4SiJooiEgrgn4HYXaZKLj2MIaa9xRFXmNFHqKQjladw9pEJDzDSR0Sw3bl98=
Received: from MW4PR04CA0181.namprd04.prod.outlook.com (2603:10b6:303:86::6)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Wed, 29 Mar
 2023 20:11:28 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::cd) by MW4PR04CA0181.outlook.office365.com
 (2603:10b6:303:86::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Wed, 29 Mar 2023 20:11:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:11:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/jpeg: add JPEG multiple AIDs support
Date: Wed, 29 Mar 2023 16:11:07 -0400
Message-ID: <20230329201109.1982249-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|CY8PR12MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d36c26-0066-41f5-7d9f-08db3091c76c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ve2/7fLLnfIADLiJOi3j219jvhL9iiNGU5vQGYL8BdKpxhhSo5bzk4BJXucl3YiYgLJV0EyU6YGB3CCv9tpvkWeZ2j29Px/2VPnw3xt/MjiBRA0KuO24PTdSwpo7feWzUfsG/a+2/dX1q0i4cCiL+CjBK3ERx5pb20u9fuMnSecqslK4uPa12SJOmmf2c1XveoUEwqesGN/3t74QH1NH+/6vefswFo1ba5oYK6wf3dpjD7VGGO85K6LBDfoEm++w9EYWgV4UxA/OJi22f5WOCCkSE+yws8w661Yyb1eQJQacDc6voVIaEqYC3e+eW6mXHjFFB4p0LjyLeAYckfWWy4nAY1m4uDtnnaFqnYOVxh4UIilQhcCrfw/bw0+wuVuWSW0Tc/55De5qHZN19Bgw2EK8rtCqyAIgFiP8EQSEufVNd4h/+Hz/HJ/eSy7RV89SV3UdRbV22bIMxFhv/WvGFrchjzMXZiwXbDAX1PzCFEv1U2qivTohF4vhTaVFOD1UYsk95NHaPw/I48O/fJwnY1UhqIVvYexmtU5PmDJ9RldQh1r3QXpOcd/WBvqwO0LWKlVTOMMtcUFAkSVD9xRss62bSREa6i4Iw/ThsHoHNJuOzfNVT0O5iTPDeYnghKKBcgHwG2rvaVxdLgPa1SnhSBUz6F98FwY7a4Lo9F90859k3ibqo2GPljCLC9BlO1iDPJG2+csYVpEZG3kGf4GEl8H6fWBTmJUU4mVU+IK/FTw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(8936002)(47076005)(2906002)(336012)(83380400001)(426003)(2616005)(41300700001)(86362001)(36860700001)(36756003)(40460700003)(82740400003)(5660300002)(81166007)(356005)(40480700001)(478600001)(7696005)(8676002)(54906003)(6916009)(70206006)(70586007)(4326008)(16526019)(30864003)(6666004)(186003)(82310400005)(1076003)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:11:27.5505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d36c26-0066-41f5-7d9f-08db3091c76c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100
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

Add JPEG multiple AIDs support.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 380 ++++++++++++++---------
 1 file changed, 227 insertions(+), 153 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index e12e3646c49a..aa14a6619e9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -63,6 +63,8 @@ static int jpeg_v4_0_3_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	adev->jpeg.num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS;
+
 	jpeg_v4_0_3_set_dec_ring_funcs(adev);
 	jpeg_v4_0_3_set_irq_funcs(adev);
 
@@ -80,12 +82,12 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring;
-	int i, r;
+	int i, j, r;
 
-	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
+	for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 		/* JPEG TRAP */
 		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
-				amdgpu_ih_srcid_jpeg[i], &adev->jpeg.inst->irq);
+				amdgpu_ih_srcid_jpeg[j], &adev->jpeg.inst->irq);
 		if (r)
 			return r;
 	}
@@ -98,22 +100,27 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 	if (r)
 		return r;
 
-	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
-		ring = &adev->jpeg.inst->ring_dec[i];
-		ring->use_doorbell = true;
-		ring->vm_hub = AMDGPU_MMHUB0(0);
-		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
-		sprintf(ring->name, "jpeg_dec_%d", i);
-		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
-					AMDGPU_RING_PRIO_DEFAULT, NULL);
-		if (r)
-			return r;
-
-		adev->jpeg.internal.jpeg_pitch[i] =
-			regUVD_JRBC0_UVD_JRBC_SCRATCH0_INTERNAL_OFFSET;
-		adev->jpeg.inst->external.jpeg_pitch[i] =
-			SOC15_REG_OFFSET1(JPEG, 0, regUVD_JRBC0_UVD_JRBC_SCRATCH0,
-			(i?(0x40 * i - 0xc80):0));
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			ring = &adev->jpeg.inst[i].ring_dec[j];
+			ring->use_doorbell = true;
+			ring->vm_hub = AMDGPU_MMHUB0(adev->jpeg.inst[i].aid_id);
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + j + 9 * i;
+			sprintf(ring->name, "jpeg_dec_%d.%d", i, j);
+			r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
+						AMDGPU_RING_PRIO_DEFAULT, NULL);
+			if (r)
+				return r;
+
+			adev->jpeg.internal.jpeg_pitch[j] =
+				regUVD_JRBC0_UVD_JRBC_SCRATCH0_INTERNAL_OFFSET;
+			adev->jpeg.inst[i].external.jpeg_pitch[j] =
+				SOC15_REG_OFFSET1(JPEG, i, regUVD_JRBC0_UVD_JRBC_SCRATCH0,
+				(j?(0x40 * j - 0xc80):0));
+		}
 	}
 
 	return 0;
@@ -149,22 +156,30 @@ static int jpeg_v4_0_3_sw_fini(void *handle)
 static int jpeg_v4_0_3_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
-	int i, r;
+	struct amdgpu_ring *ring;
+	int i, j, r;
 
-	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
-			(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+		ring = adev->jpeg.inst[i].ring_dec;
 
-	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
-		ring = &adev->jpeg.inst->ring_dec[i];
 		if (ring->use_doorbell)
-			WREG32_SOC15_OFFSET(VCN, 0, regVCN_JPEG_DB_CTRL,
-				(ring->pipe?(ring->pipe - 0x15):0),
-				ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
-				VCN_JPEG_DB_CTRL__EN_MASK);
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
+			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 9 * i,
+				adev->jpeg.inst[i].aid_id);
+
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			ring = &adev->jpeg.inst[i].ring_dec[j];
+			if (ring->use_doorbell)
+				WREG32_SOC15_OFFSET(VCN, i, regVCN_JPEG_DB_CTRL,
+					(ring->pipe?(ring->pipe - 0x15):0),
+					ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+					VCN_JPEG_DB_CTRL__EN_MASK);
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				return r;
+		}
 	}
 	DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
 
@@ -233,48 +248,52 @@ static int jpeg_v4_0_3_resume(void *handle)
 	return r;
 }
 
-static void jpeg_v4_0_3_disable_clock_gating(struct amdgpu_device *adev)
+static void jpeg_v4_0_3_disable_clock_gating(struct amdgpu_device *adev, int inst_idx)
 {
 	uint32_t data;
 	int i;
 
-	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
-	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG)
+	data = RREG32_SOC15(JPEG, inst_idx, regJPEG_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG) {
 		data |= 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-	else
+		data &= (~(JPEG_CGC_CTRL__JPEG0_DEC_MODE_MASK << 1));
+	} else {
 		data &= ~JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	}
 
 	data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
 	data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
-	WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
+	WREG32_SOC15(JPEG, inst_idx, regJPEG_CGC_CTRL, data);
 
-	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE);
+	data = RREG32_SOC15(JPEG, inst_idx, regJPEG_CGC_GATE);
 	data &= ~(JPEG_CGC_GATE__JMCIF_MASK | JPEG_CGC_GATE__JRBBM_MASK);
 	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i)
 		data &= ~(JPEG_CGC_GATE__JPEG0_DEC_MASK << i);
-	WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
+	WREG32_SOC15(JPEG, inst_idx, regJPEG_CGC_GATE, data);
 }
 
-static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev)
+static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst_idx)
 {
 	uint32_t data;
 	int i;
 
-	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
-	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG)
+	data = RREG32_SOC15(JPEG, inst_idx, regJPEG_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG) {
 		data |= 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-	else
+		data |= (JPEG_CGC_CTRL__JPEG0_DEC_MODE_MASK << 1);
+	} else {
 		data &= ~JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	}
 
 	data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
 	data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
-	WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
+	WREG32_SOC15(JPEG, inst_idx, regJPEG_CGC_CTRL, data);
 
-	data = RREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE);
+	data = RREG32_SOC15(JPEG, inst_idx, regJPEG_CGC_GATE);
 	data |= (JPEG_CGC_GATE__JMCIF_MASK | JPEG_CGC_GATE__JRBBM_MASK);
 	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i)
 		data |= (JPEG_CGC_GATE__JPEG0_DEC_MASK << i);
-	WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
+	WREG32_SOC15(JPEG, inst_idx, regJPEG_CGC_GATE, data);
 }
 
 /**
@@ -286,58 +305,63 @@ static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev)
  */
 static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
-	int i;
-
-	WREG32_SOC15(JPEG, 0, regUVD_PGFSM_CONFIG,
-		1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
-	SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_PGFSM_STATUS,
-		UVD_PGFSM_STATUS__UVDJ_PWR_ON <<
-		UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
-		UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
-
-	/* disable anti hang mechanism */
-	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
-		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
-
-	/* JPEG disable CGC */
-	jpeg_v4_0_3_disable_clock_gating(adev);
-
-	/* MJPEG global tiling registers */
-	WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX8_ADDR_CONFIG,
-		adev->gfx.config.gb_addr_config);
-	WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
-		adev->gfx.config.gb_addr_config);
-
-	/* enable JMI channel */
-	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL), 0,
-		~UVD_JMI_CNTL__SOFT_RESET_MASK);
-
-	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
-		unsigned int reg_offset = (i?(0x40 * i - 0xc80):0);
-
-		ring = &adev->jpeg.inst->ring_dec[i];
-
-		/* enable System Interrupt for JRBC */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regJPEG_SYS_INT_EN),
-			JPEG_SYS_INT_EN__DJRBC0_MASK << i,
-			~(JPEG_SYS_INT_EN__DJRBC0_MASK << i));
-
-		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JMI0_UVD_LMI_JRBC_RB_VMID, reg_offset, 0);
-		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_CNTL, reg_offset,
-			(0x00000001L | 0x00000002L));
-		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
-			reg_offset, lower_32_bits(ring->gpu_addr));
-		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
-			reg_offset, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR, reg_offset, 0);
-		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR, reg_offset, 0);
-		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_CNTL, reg_offset,
-			0x00000002L);
-		WREG32_SOC15_OFFSET(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_SIZE, reg_offset,
-			ring->ring_size / 4);
-		ring->wptr = RREG32_SOC15_OFFSET(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
-			reg_offset);
+	struct amdgpu_ring *ring;
+	int i, j;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+		WREG32_SOC15(JPEG, i, regUVD_PGFSM_CONFIG,
+			1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
+		SOC15_WAIT_ON_RREG(JPEG, i, regUVD_PGFSM_STATUS,
+			UVD_PGFSM_STATUS__UVDJ_PWR_ON <<
+			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
+			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
+
+		/* disable anti hang mechanism */
+		WREG32_P(SOC15_REG_OFFSET(JPEG, i, regUVD_JPEG_POWER_STATUS), 0,
+			~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+		/* JPEG disable CGC */
+		jpeg_v4_0_3_disable_clock_gating(adev, i);
+
+		/* MJPEG global tiling registers */
+		WREG32_SOC15(JPEG, i, regJPEG_DEC_GFX8_ADDR_CONFIG,
+			adev->gfx.config.gb_addr_config);
+		WREG32_SOC15(JPEG, i, regJPEG_DEC_GFX10_ADDR_CONFIG,
+			adev->gfx.config.gb_addr_config);
+
+		/* enable JMI channel */
+		WREG32_P(SOC15_REG_OFFSET(JPEG, i, regUVD_JMI_CNTL), 0,
+			~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			unsigned int reg_offset = (j?(0x40 * j - 0xc80):0);
+
+			ring = &adev->jpeg.inst[i].ring_dec[j];
+
+			/* enable System Interrupt for JRBC */
+			WREG32_P(SOC15_REG_OFFSET(JPEG, i, regJPEG_SYS_INT_EN),
+				JPEG_SYS_INT_EN__DJRBC0_MASK << j,
+				~(JPEG_SYS_INT_EN__DJRBC0_MASK << j));
+
+			WREG32_SOC15_OFFSET(JPEG, i,
+				regUVD_JMI0_UVD_LMI_JRBC_RB_VMID, reg_offset, 0);
+			WREG32_SOC15_OFFSET(JPEG, i, regUVD_JRBC0_UVD_JRBC_RB_CNTL, reg_offset,
+				(0x00000001L | 0x00000002L));
+			WREG32_SOC15_OFFSET(JPEG, i, regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+				reg_offset, lower_32_bits(ring->gpu_addr));
+			WREG32_SOC15_OFFSET(JPEG, i, regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+				reg_offset, upper_32_bits(ring->gpu_addr));
+			WREG32_SOC15_OFFSET(JPEG, i, regUVD_JRBC0_UVD_JRBC_RB_RPTR, reg_offset, 0);
+			WREG32_SOC15_OFFSET(JPEG, i, regUVD_JRBC0_UVD_JRBC_RB_WPTR, reg_offset, 0);
+			WREG32_SOC15_OFFSET(JPEG, i, regUVD_JRBC0_UVD_JRBC_RB_CNTL, reg_offset,
+				0x00000002L);
+			WREG32_SOC15_OFFSET(JPEG, i, regUVD_JRBC0_UVD_JRBC_RB_SIZE, reg_offset,
+				ring->ring_size / 4);
+			ring->wptr = RREG32_SOC15_OFFSET(JPEG, i, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
+				reg_offset);
+		}
 	}
 
 	return 0;
@@ -352,24 +376,31 @@ static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
  */
 static int jpeg_v4_0_3_stop(struct amdgpu_device *adev)
 {
-	/* reset JMI */
-	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
-		UVD_JMI_CNTL__SOFT_RESET_MASK,
-		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+	int i;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
 
-	jpeg_v4_0_3_enable_clock_gating(adev);
+		/* reset JMI */
+		WREG32_P(SOC15_REG_OFFSET(JPEG, i, regUVD_JMI_CNTL),
+			UVD_JMI_CNTL__SOFT_RESET_MASK,
+			~UVD_JMI_CNTL__SOFT_RESET_MASK);
 
-	/* enable anti hang mechanism */
-	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS),
-		UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
-		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+		jpeg_v4_0_3_enable_clock_gating(adev, i);
 
-	WREG32_SOC15(JPEG, 0, regUVD_PGFSM_CONFIG,
-		2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
-	SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_PGFSM_STATUS,
-		UVD_PGFSM_STATUS__UVDJ_PWR_OFF <<
-		UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
-		UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
+		/* enable anti hang mechanism */
+		WREG32_P(SOC15_REG_OFFSET(JPEG, i, regUVD_JPEG_POWER_STATUS),
+			UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
+			~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+		WREG32_SOC15(JPEG, i, regUVD_PGFSM_CONFIG,
+			2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
+		SOC15_WAIT_ON_RREG(JPEG, i, regUVD_PGFSM_STATUS,
+			UVD_PGFSM_STATUS__UVDJ_PWR_OFF <<
+			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
+			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
+	}
 
 	return 0;
 }
@@ -502,10 +533,28 @@ static void jpeg_v4_0_3_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 		0, PACKETJ_CONDITION_CHECK0, PACKETJ_TYPE4));
 	amdgpu_ring_write(ring, 0);
 
+	if (ring->adev->jpeg.inst[ring->me].aid_id) {
+		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_MCM_ADDR_INTERNAL_OFFSET,
+			0, PACKETJ_CONDITION_CHECK0, PACKETJ_TYPE0));
+		amdgpu_ring_write(ring, 0x4);
+	} else {
+		amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
+		amdgpu_ring_write(ring, 0);
+	}
+
 	amdgpu_ring_write(ring,	PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
 	amdgpu_ring_write(ring, 0x3fbc);
 
+	if (ring->adev->jpeg.inst[ring->me].aid_id) {
+		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_MCM_ADDR_INTERNAL_OFFSET,
+			0, PACKETJ_CONDITION_CHECK0, PACKETJ_TYPE0));
+		amdgpu_ring_write(ring, 0x0);
+	} else {
+		amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
+		amdgpu_ring_write(ring, 0);
+	}
+
 	amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
 		0, 0, PACKETJ_TYPE0));
 	amdgpu_ring_write(ring, 0x1);
@@ -651,15 +700,19 @@ static bool jpeg_v4_0_3_is_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool ret;
-	int i;
-
-	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
-		unsigned int reg_offset = (i?(0x40 * i - 0xc80):0);
-
-		ret &= ((RREG32_SOC15_OFFSET(JPEG, 0,
-				regUVD_JRBC0_UVD_JRBC_STATUS, reg_offset) &
-				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
-				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+	int i, j;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			unsigned int reg_offset = (j?(0x40 * j - 0xc80):0);
+
+			ret &= ((RREG32_SOC15_OFFSET(JPEG, i,
+					regUVD_JRBC0_UVD_JRBC_STATUS, reg_offset) &
+					UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
+					UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+		}
 	}
 
 	return ret;
@@ -669,17 +722,20 @@ static int jpeg_v4_0_3_wait_for_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int ret;
-	int i;
+	int i, j;
 
-	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
-		unsigned int reg_offset = (i?(0x40 * i - 0xc80):0);
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			unsigned int reg_offset = (j?(0x40 * j - 0xc80):0);
 
-		ret &= SOC15_WAIT_ON_RREG_OFFSET(JPEG, 0,
-			regUVD_JRBC0_UVD_JRBC_STATUS, reg_offset,
-			UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
-			UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+			ret &= SOC15_WAIT_ON_RREG_OFFSET(JPEG, i,
+				regUVD_JRBC0_UVD_JRBC_STATUS, reg_offset,
+				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
+				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+		}
 	}
-
 	return ret;
 }
 
@@ -688,15 +744,19 @@ static int jpeg_v4_0_3_set_clockgating_state(void *handle,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+	int i;
 
-	if (enable) {
-		if (!jpeg_v4_0_3_is_idle(handle))
-			return -EBUSY;
-		jpeg_v4_0_3_enable_clock_gating(adev);
-	} else {
-		jpeg_v4_0_3_disable_clock_gating(adev);
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+		if (enable) {
+			if (!jpeg_v4_0_3_is_idle(handle))
+				return -EBUSY;
+			jpeg_v4_0_3_enable_clock_gating(adev, i);
+		} else {
+			jpeg_v4_0_3_disable_clock_gating(adev, i);
+		}
 	}
-
 	return 0;
 }
 
@@ -732,32 +792,35 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
+	uint32_t i;
+
+	i = node_id_to_phys_map[entry->node_id];
 	DRM_DEV_DEBUG(adev->dev, "IH: JPEG TRAP\n");
 
 	switch (entry->src_id) {
 	case VCN_4_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[0]);
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[0]);
 		break;
 	case VCN_4_0__SRCID__JPEG1_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[1]);
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[1]);
 		break;
 	case VCN_4_0__SRCID__JPEG2_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[2]);
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[2]);
 		break;
 	case VCN_4_0__SRCID__JPEG3_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[3]);
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[3]);
 		break;
 	case VCN_4_0__SRCID__JPEG4_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[4]);
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[4]);
 		break;
 	case VCN_4_0__SRCID__JPEG5_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[5]);
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[5]);
 		break;
 	case VCN_4_0__SRCID__JPEG6_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[6]);
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[6]);
 		break;
 	case VCN_4_0__SRCID__JPEG7_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst->ring_dec[7]);
+		amdgpu_fence_process(&adev->jpeg.inst[i].ring_dec[7]);
 		break;
 	default:
 		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
@@ -798,7 +861,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
 		8 + /* jpeg_v4_0_3_dec_ring_emit_vm_flush */
-		18 + 18 + /* jpeg_v4_0_3_dec_ring_emit_fence x2 vm fence */
+		22 + 22 + /* jpeg_v4_0_3_dec_ring_emit_fence x2 vm fence */
 		8 + 16,
 	.emit_ib_size = 22, /* jpeg_v4_0_3_dec_ring_emit_ib */
 	.emit_ib = jpeg_v4_0_3_dec_ring_emit_ib,
@@ -819,12 +882,17 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 
 static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
-	int i;
-
-	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
-		adev->jpeg.inst->ring_dec[i].funcs = &jpeg_v4_0_3_dec_ring_vm_funcs;
-		adev->jpeg.inst->ring_dec[i].me = 0;
-		adev->jpeg.inst->ring_dec[i].pipe = i;
+	int i, j;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+			adev->jpeg.inst[i].ring_dec[j].funcs = &jpeg_v4_0_3_dec_ring_vm_funcs;
+			adev->jpeg.inst[i].ring_dec[j].me = i;
+			adev->jpeg.inst[i].ring_dec[j].pipe = j;
+		}
+		adev->jpeg.inst[i].aid_id = i / adev->jpeg.num_inst_per_aid;
 	}
 	DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
 }
@@ -836,7 +904,13 @@ static const struct amdgpu_irq_src_funcs jpeg_v4_0_3_irq_funcs = {
 
 static void jpeg_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
 {
-	adev->jpeg.inst->irq.num_types = adev->jpeg.num_jpeg_rings;
+	int i;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+		adev->jpeg.inst->irq.num_types += adev->jpeg.num_jpeg_rings;
+	}
 	adev->jpeg.inst->irq.funcs = &jpeg_v4_0_3_irq_funcs;
 }
 
-- 
2.39.2

