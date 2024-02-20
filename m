Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CE7C48BC4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Feb 2024 20:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9371110E22C;
	Tue, 20 Feb 2024 20:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XI2DFHPT";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77E3110E22C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 20:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTCYRbfc8tUoRJeyx9NpQevMwrgHq6zUViGb3Vn81dJrvsDdwRDIc4CsuvSuE4TrIgQfEQmPgf2Grwpst7LtT1/SoEPtcSM6S/ND8DlwmM1737+0G/T77BnfrLDNo7TYIGLrJdMLcFBppIW67HRgwjVvIG8ryeqaOWra09fyn5L8nzuPbDEkYgmOuM3w1gHbulsW6gZR5wL0aC2vCKsvPNx2AX4kE+e4uPWbraOTmHvufqLa86TdZTtXDwHOKLKuwd/rqBOJpyZlwsgfehn0JRyQU0Nj7PdjiMn1AAMn6NGzqESTmzyCr2Gqmqzwg+217Gv+wuGu106OPn2bCYCmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AXKMfmsusyrAOOV7SGzNqZUO8NHto4OAf3LHtVN/W4=;
 b=IbPq6efPEXv6DmBW0cK75tDmYL2yw6gR9u1vmegt7kV1Sxn4qxaSMMwKZNW4MPehvjDEB96Hi8TBZWQus89Dy4HjKyLVd0VyqMGs51rIbAjZWugD0RRignRr0PNihwpLIhG3kgKlib+o91cbF37UpXdqpQilLTyd1J0Etf9/odL5PT9XGQpegCXEIRimmJ6O8H5TwzxeC0Afhr02V1PHR0utkdubnHaAz2fnreraXGjPBjvOhGhT0ihURbPuJ2Wf0g6ghO80XuPqJkd0/IdlirWL12TVRsurM8php0MwTw/QpYQ47bFCR9IdxxtW4a0pso++LQ/RD5TzMtLvqSP5yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AXKMfmsusyrAOOV7SGzNqZUO8NHto4OAf3LHtVN/W4=;
 b=XI2DFHPTkzrGSkvfx6xEj9NkwdXxcWujysSrwzsqsKCXJm1IznnXYbUhR/QLv088w4lRUhXQ+Dq+C9OTvqfW8K3PP8iWBtydP7vc+Wrfe3QtXRHNWPIg33nGcm5dmzVU5N/kDKcrs9O+Zj0IaiPltep8IKnznEuFhSV9/nmw9FI=
Received: from MW4PR04CA0297.namprd04.prod.outlook.com (2603:10b6:303:89::32)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 20:28:48 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:89:cafe::53) by MW4PR04CA0297.outlook.office365.com
 (2603:10b6:303:89::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 20:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 20:28:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 14:28:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>, "Veerabadhran
 Gopalakrishnan" <Veerabadhran.Gopalakrishnan@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/jpeg: add support for jpeg multi instance
Date: Tue, 20 Feb 2024 15:28:32 -0500
Message-ID: <20240220202832.417241-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 826b559a-bfe2-4821-d3ae-08dc32528ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNX/O6dAnUuna8H5/4mtiousl2gibFGVURkyhd53wLaQrsH7e+0BJLVjyYQwJAKKl46X73wXGb/m8vliUIIzYU8iDxhrKsZbz+W9yjRs8xQNsmMqulWLSnbfRMNipDeGhBngtNdcB5AHtLCySFX8h70mDoVdOzAryKwkuUM/PzSaiXw0ubnI8m0nVnbkrEyJffzXsO8LeH/iTmt94fZqEtI1/C/0hReREifIFaM9bMy+HSJKbxdanJmAy1XPvsiCZnzqUcwc9gWsIQuPkbU5T9S/tfC/NqP/LZ6W0mTxP/feKP7q4MwP+Q47TFRxlXN2jpMI+q4V2Et2h04pcuLlwztfg0cRhX3EAHagMRoTeeCzcgsyWNPdS1lwYgoLD6PjzvGKLbQVnWOxFexQVlTPs8ajcVU9GuWbkxakr8Qef11IpQgHQgRYe3ehiCEaMdaF6MZpzU4rlz1E0wWVp5JiRQlDhvb+VJd1kHIJDw77ZAT3/jaglrPPqWPSf2oPxQVU0SGCCciqy87x0q6dzq/TBeAO9vUb6J/luHQNNY5WIyB6DV0VzS2xjm4Z+8Ivj8zh3xiPg+vCHMD/obW3qkj62YeR1B8tAD/7rVEoZ0gGaFGfYVhOU4DGCPk1kQnQSidflTnPYb/zIY6mPayuSULdYQGY36yI2vOoiGBimxD2E2Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 20:28:47.6312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 826b559a-bfe2-4821-d3ae-08dc32528ad7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208
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

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

Enable support for multi instance on JPEG 4.0.6.

v2: squash in fixes (Alex)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 177 ++++++++++++++++-------
 1 file changed, 123 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 3602738874ee..521af589ffcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -53,6 +53,11 @@ static int jpeg_v4_0_5_set_powergating_state(void *handle,
 
 static void jpeg_v4_0_5_dec_ring_set_wptr(struct amdgpu_ring *ring);
 
+static int amdgpu_ih_clientid_jpeg[] = {
+	SOC15_IH_CLIENTID_VCN,
+	SOC15_IH_CLIENTID_VCN1
+};
+
 /**
  * jpeg_v4_0_5_early_init - set function pointers
  *
@@ -64,8 +69,20 @@ static int jpeg_v4_0_5_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
+	case IP_VERSION(4, 0, 5):
+		adev->jpeg.num_jpeg_inst = 1;
+		break;
+	case IP_VERSION(4, 0, 6):
+		adev->jpeg.num_jpeg_inst = 2;
+		break;
+	default:
+		DRM_DEV_ERROR(adev->dev,
+			"Failed to init vcn ip block(UVD_HWIP:0x%x)\n",
+			amdgpu_ip_version(adev, UVD_HWIP, 0));
+		return -EINVAL;
+	}
 
-	adev->jpeg.num_jpeg_inst = 1;
 	adev->jpeg.num_jpeg_rings = 1;
 
 	jpeg_v4_0_5_set_dec_ring_funcs(adev);
@@ -85,25 +102,30 @@ static int jpeg_v4_0_5_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring;
-	int r;
+	int r, i;
 
-	/* JPEG TRAP */
-	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
-		VCN_4_0__SRCID__JPEG_DECODE, &adev->jpeg.inst->irq);
-	if (r)
-		return r;
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
 
-	/* JPEG DJPEG POISON EVENT */
-	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
-			VCN_4_0__SRCID_DJPEG0_POISON, &adev->jpeg.inst->irq);
-	if (r)
-		return r;
+		/* JPEG TRAP */
+		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_jpeg[i],
+				VCN_4_0__SRCID__JPEG_DECODE, &adev->jpeg.inst[i].irq);
+		if (r)
+			return r;
 
-	/* JPEG EJPEG POISON EVENT */
-	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
-			VCN_4_0__SRCID_EJPEG0_POISON, &adev->jpeg.inst->irq);
-	if (r)
-		return r;
+		/* JPEG DJPEG POISON EVENT */
+		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_jpeg[i],
+			VCN_4_0__SRCID_DJPEG0_POISON, &adev->jpeg.inst[i].irq);
+		if (r)
+			return r;
+
+		/* JPEG EJPEG POISON EVENT */
+		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_jpeg[i],
+			VCN_4_0__SRCID_EJPEG0_POISON, &adev->jpeg.inst[i].irq);
+		if (r)
+			return r;
+	}
 
 	r = amdgpu_jpeg_sw_init(adev);
 	if (r)
@@ -113,21 +135,23 @@ static int jpeg_v4_0_5_sw_init(void *handle)
 	if (r)
 		return r;
 
-	ring = adev->jpeg.inst->ring_dec;
-	ring->use_doorbell = true;
-	ring->doorbell_index = amdgpu_sriov_vf(adev) ?
-				(((adev->doorbell_index.vcn.vcn_ring0_1) << 1) + 4) :
-				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1);
-	ring->vm_hub = AMDGPU_MMHUB0(0);
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
 
-	sprintf(ring->name, "jpeg_dec");
-	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
-			     AMDGPU_RING_PRIO_DEFAULT, NULL);
-	if (r)
-		return r;
+		ring = adev->jpeg.inst[i].ring_dec;
+		ring->use_doorbell = true;
+		ring->vm_hub = AMDGPU_MMHUB0(0);
+		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + 8 * i;
+		sprintf(ring->name, "jpeg_dec_%d", i);
+		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[i].irq,
+				     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
+		if (r)
+			return r;
 
-	adev->jpeg.internal.jpeg_pitch[0] = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
-	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
+		adev->jpeg.internal.jpeg_pitch[0] = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
+		adev->jpeg.inst[i].external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, i, regUVD_JPEG_PITCH);
+	}
 
 	return 0;
 }
@@ -162,8 +186,8 @@ static int jpeg_v4_0_5_sw_fini(void *handle)
 static int jpeg_v4_0_5_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
-	int r;
+	struct amdgpu_ring *ring;
+	int r, i;
 
 	// TODO: Enable ring test with DPG support
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
@@ -171,9 +195,15 @@ static int jpeg_v4_0_5_hw_init(void *handle)
 		return 0;
 	}
 
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+
+		ring = adev->jpeg.inst[i].ring_dec;
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
+	}
 
 	if (!r)
 		DRM_INFO("JPEG decode initialized successfully under SPG Mode\n");
@@ -191,14 +221,20 @@ static int jpeg_v4_0_5_hw_init(void *handle)
 static int jpeg_v4_0_5_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i;
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
-	if (!amdgpu_sriov_vf(adev)) {
-		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
-			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
-			jpeg_v4_0_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
-	}
 
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+
+		if (!amdgpu_sriov_vf(adev)) {
+			if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
+			    RREG32_SOC15(JPEG, i, regUVD_JRBC_STATUS))
+				jpeg_v4_0_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+		}
+	}
 	return 0;
 }
 
@@ -442,13 +478,17 @@ static void jpeg_v4_0_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  */
 static int jpeg_v4_0_5_start(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
+	struct amdgpu_ring *ring;
 	int r, i;
 
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_jpeg(adev, true);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
+
+		ring = adev->jpeg.inst[i].ring_dec;
 		/* doorbell programming is done for every playback */
 		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i, i);
@@ -511,11 +551,14 @@ static int jpeg_v4_0_5_stop(struct amdgpu_device *adev)
 	int r, i;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-		if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
 
+		if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
 			jpeg_v4_0_5_stop_dpg_mode(adev, i);
 			continue;
 		}
+
 		/* reset JMI */
 		WREG32_P(SOC15_REG_OFFSET(JPEG, i, regUVD_JMI_CNTL),
 			UVD_JMI_CNTL__SOFT_RESET_MASK,
@@ -528,7 +571,6 @@ static int jpeg_v4_0_5_stop(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_jpeg(adev, false);
 
@@ -546,7 +588,7 @@ static uint64_t jpeg_v4_0_5_dec_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	return RREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_RPTR);
+	return RREG32_SOC15(JPEG, ring->me, regUVD_JRBC_RB_RPTR);
 }
 
 /**
@@ -563,7 +605,7 @@ static uint64_t jpeg_v4_0_5_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	if (ring->use_doorbell)
 		return *ring->wptr_cpu_addr;
 	else
-		return RREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR);
+		return RREG32_SOC15(JPEG, ring->me, regUVD_JRBC_RB_WPTR);
 }
 
 /**
@@ -581,29 +623,41 @@ static void jpeg_v4_0_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
 		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
-		WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
+		WREG32_SOC15(JPEG, ring->me, regUVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
 	}
 }
 
 static bool jpeg_v4_0_5_is_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int ret = 1;
+	int i, ret = 1;
 
-	ret &= (((RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS) &
-		UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
-		UVD_JRBC_STATUS__RB_JOB_DONE_MASK));
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
 
+		ret &= (((RREG32_SOC15(JPEG, i, regUVD_JRBC_STATUS) &
+			UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
+			UVD_JRBC_STATUS__RB_JOB_DONE_MASK));
+	}
 	return ret;
 }
 
 static int jpeg_v4_0_5_wait_for_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i;
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+		if (adev->jpeg.harvest_config & (1 << i))
+			continue;
 
-	return SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_JRBC_STATUS,
-		UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
-		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+		return SOC15_WAIT_ON_RREG(JPEG, i, regUVD_JRBC_STATUS,
+			UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
+			UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+	}
+
+	return 0;
 }
 
 static int jpeg_v4_0_5_set_clockgating_state(void *handle,
@@ -659,11 +713,25 @@ static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
+	uint32_t ip_instance;
+
 	DRM_DEBUG("IH: JPEG TRAP\n");
 
+	switch (entry->client_id) {
+	case SOC15_IH_CLIENTID_VCN:
+		ip_instance = 0;
+		break;
+	case SOC15_IH_CLIENTID_VCN1:
+		ip_instance = 1;
+		break;
+	default:
+		DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
+		return 0;
+	}
+
 	switch (entry->src_id) {
 	case VCN_4_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
+		amdgpu_fence_process(adev->jpeg.inst[ip_instance].ring_dec);
 		break;
 	case VCN_4_0__SRCID_DJPEG0_POISON:
 	case VCN_4_0__SRCID_EJPEG0_POISON:
@@ -736,6 +804,7 @@ static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev)
 			continue;
 
 		adev->jpeg.inst[i].ring_dec->funcs = &jpeg_v4_0_5_dec_ring_vm_funcs;
+		adev->jpeg.inst[i].ring_dec->me = i;
 		DRM_DEV_INFO(adev->dev, "JPEG%d decode is enabled in VM mode\n", i);
 	}
 }
-- 
2.42.0

