Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3905C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 00:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4769F10E2B1;
	Thu, 16 Dec 2021 00:52:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 544EF10E2B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 00:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sfvts36gTzRrdWXJgF4SCf8DTU+ypKPJ21z+UfwYsLWZD0rnrswPMiihJvDNrTuAQo8NmT/VajJM1Ixy4Kgz0BNRj/uwrBUQbSIlp5+hcDUMa+bW0/oV5IpbRfCeEWDf7amfm7w1z6kdE/ULjnmSQknGxXRjlL/a0SZBl4zBrhTmUz6+aVuhFZFzDaabgXIdCFpW+v+puvmWGYz3NqC9G9xo5p69DZaww5z/8EgFtT9QAYJezXVgADshOASfLIOSM3jFBgY5XurmoHq8HJguABnKFyQtDmR0vB1zwfcj0YajV1/KNUvYpUzL4D69QROah6JCFVrpFryJC04bAcgMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/otjri3Ialh7lILuNN0dQMrgJTbLaZSeEMa6kkPWXwE=;
 b=EC1TuW798SQgL5e7ZNS8f64DCjs2t7C6pybPYwsiLpzA14uFCOWLnBp2P8rKw8NPN8fdDUeLzECr/LdwIFTopGhUa47frMQYiyiNaKEICV5gXOxSf3D4LFiqCVEwzRtDjRrlW28HwnEB6va9jcYg1N6SqKmP1xvHIwH4I09IXmsqfkj8aHYkc+w1ykZR9FzUHSAkdihlPwmagKxoZRNrMzjkbhKpViCdEmyQ3Vc/XMza+o/X6KA0vlXFcrOeaWQFV9tI2irpvVlFYrnamHVncrjgeGXdBGRTU8rx5BkhxfJ4WliVWIBMhzPIETiKhTbOHfbH8mNfWlp9hCphSVcGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/otjri3Ialh7lILuNN0dQMrgJTbLaZSeEMa6kkPWXwE=;
 b=onGHL2hygJxvY+/f1lRBEmfGYyK4FmXbEDB3WtCgooCdFNfuCk/KHjWfEkHD+Clu+2nMil8CjY4Bl00cxzYqAmvDSKNP1Kztm1FUZKpAsVHPh9nKHpeqnoyydDE6RhYTwh6fJsGasXYZwZwZoRlywx9scU6mXmJbaIzUGDXcgZQ=
Received: from MWHPR04CA0038.namprd04.prod.outlook.com (2603:10b6:300:ee::24)
 by BN8PR12MB3457.namprd12.prod.outlook.com (2603:10b6:408:67::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Thu, 16 Dec
 2021 00:52:40 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::76) by MWHPR04CA0038.outlook.office365.com
 (2603:10b6:300:ee::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Thu, 16 Dec 2021 00:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 00:52:40 +0000
Received: from AWS-Host-01.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 18:52:39 -0600
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Filter security violation registers
Date: Wed, 15 Dec 2021 19:52:26 -0500
Message-ID: <20211216005226.24834-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1dd379d-27e0-4b2b-dbc7-08d9c02e5c82
X-MS-TrafficTypeDiagnostic: BN8PR12MB3457:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3457ABB09EBB6D7708CD8921F4779@BN8PR12MB3457.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TOm8JQrOqyUq/mzSCjOLZ1t8MTW1th5R9eMZCBEDFkuJagMIMSLY5K4CWUts1PaohY3BZTkEcZbPp99D+6ujaMYHXxRCLY4Ohrpkf2c2ciIOANqSZywgUR9wCp5SWHcRn9ivY3ZF84yqb03mbnpfG/eFFO24iiKUtZnjzVCr927nDOnfqe5mDHVxGxS6/Q846m3Fg+GV/SWat74LiGQbJ1e4e7ryxeMyUKXKFU8Q1oyioZze11pYF/j3nEwi+jPnEG0VDEh0/SPxHgVZxZ3MkfBAhPqUbFeT4ahRIkMLPPUaX5NFgEWJGNOYOejXXDUa5gnN5BxV6n961M3xCycmL10XLgaZGB9MKMLWQGlZIdhFTUyqe99YAHyT4oKAG3iQXUiM9Caxxw+kwbfhZogTIFsvTKtQTsoxwq4PM75hfPOQvSF/jJ4GviamgEDDZpBWJDjrPLBfxt3g2Atjlfourcola5XXUQU1lj9IHdqTtDxgHRKG4Hc5L3YhxoPiX2pobBODApdWEXVF74m4uypx/anUzcQfJNXv3mrzb29OdM8aenBR2VEfUHCrcKWsp7xi1lGrSYYv25lY3RmO3qlkdDSJqQCa7cGDNj7P60AYvjrh54Hp8u/m0IM7yHt0SXcyGr7JnVOGk75C9kAqoxfkBIR0KoIsWKGlmf3du/UFugwsm99Jr984wz9m8QXhG0Dzq6RGnP3khfggi5FAbHNVaQ7jrVpHNkZLGhbvhzCYerZnTp4w1rveZT4awQ21CN5H+zN/hxH00ys5x3SdcNyNAHiPE1yULG+u+panQPRga0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(6666004)(15650500001)(2906002)(356005)(316002)(47076005)(508600001)(86362001)(5660300002)(83380400001)(186003)(36756003)(8936002)(1076003)(16526019)(26005)(6916009)(4326008)(426003)(7696005)(82310400004)(70206006)(8676002)(81166007)(2616005)(336012)(70586007)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 00:52:40.1181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dd379d-27e0-4b2b-dbc7-08d9c02e5c82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3457
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Recently, there is security policy update under SRIOV.
We need to filter the registers that hit the violation
and move the code to the host driver side so that
the guest driver can execute correctly.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
Change-Id: Ida893bb17de17a80e865c7662f04c5562f5d2727
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 83 ++++++++++++++------------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 4f546f632223..d3d6d5b045b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -542,9 +542,6 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
-		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-				AUTO_CTXSW_ENABLE, enable ? 1 : 0);
 		if (enable && amdgpu_sdma_phase_quantum) {
 			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
 			       phase_quantum);
@@ -553,7 +550,13 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
 			       phase_quantum);
 		}
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
+
+		if (!amdgpu_sriov_vf(adev)) {
+			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
+			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+					AUTO_CTXSW_ENABLE, enable ? 1 : 0);
+			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
+		}
 	}
 
 }
@@ -576,10 +579,12 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
 		sdma_v5_2_rlc_stop(adev);
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
-		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
+	if (!amdgpu_sriov_vf(adev)) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
+			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
+			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
+		}
 	}
 }
 
@@ -608,7 +613,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		ring = &adev->sdma.instance[i].ring;
 		wb_offset = (ring->rptr_offs * 4);
 
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+		if (!amdgpu_sriov_vf(adev))
+			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
@@ -683,32 +689,34 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 			sdma_v5_2_ring_set_wptr(ring);
 
 		/* set minor_ptr_update to 0 after wptr programed */
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
 
-		/* set utc l1 enable flag always to 1 */
-		temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
-		temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
-
-		/* enable MCBP */
-		temp = REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENABLE, 1);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);
-
-		/* Set up RESP_MODE to non-copy addresses */
-		temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
-		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
-		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
-
-		/* program default cache read and write policy */
-		temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
-		/* clean read policy and write policy bits */
-		temp &= 0xFF0FFF;
-		temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
-			 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
-			 SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
-		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
 
+		/* SRIOV VF has no control of any of registers below */
 		if (!amdgpu_sriov_vf(adev)) {
+			/* set utc l1 enable flag always to 1 */
+			temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
+			temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
+
+			/* enable MCBP */
+			temp = REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENABLE, 1);
+			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);
+
+			/* Set up RESP_MODE to non-copy addresses */
+			temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
+			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
+			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
+			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
+
+			/* program default cache read and write policy */
+			temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
+			/* clean read policy and write policy bits */
+			temp &= 0xFF0FFF;
+			temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
+				 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
+				 SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
+			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
+
 			/* unhalt engine */
 			temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
 			temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
@@ -1436,13 +1444,14 @@ static int sdma_v5_2_set_trap_irq_state(struct amdgpu_device *adev,
 					enum amdgpu_interrupt_state state)
 {
 	u32 sdma_cntl;
-
 	u32 reg_offset = sdma_v5_2_get_reg_offset(adev, type, mmSDMA0_CNTL);
 
-	sdma_cntl = RREG32(reg_offset);
-	sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,
-		       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
-	WREG32(reg_offset, sdma_cntl);
+	if (!amdgpu_sriov_vf(adev)) {
+		sdma_cntl = RREG32(reg_offset);
+		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,
+			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		WREG32(reg_offset, sdma_cntl);
+	}
 
 	return 0;
 }
-- 
2.25.1

