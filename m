Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DE9C4363C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 21:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE83023A5C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 21:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JXlaF7SF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE83023A5C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 648BC6E08C;
	Mon, 21 Sep 2020 21:14:34 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760050.outbound.protection.outlook.com [40.107.76.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02D7D6E08C
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 21:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brz9Z1Xg6DJXYTIZPjJVXhmBnDA39SKsZmWvpOQGV4XWTpbEjeOsfXt5BKJj5zBBIz/oN8rB6LfjVHdRrc9fnz+TXkyDCs+p/kckUa5WY++qEt1g4LBC8B6JyVw/yZjcNUdQLqdHHcXt5bkzgvurHhu2K1AHLliHxYrP+T/tP080b8UNtv41+bpJOF3CbANZ6YU0SEJhJFdh5dqc+WM6RIrzyuzWTpY6fC/mAI9uDxD1sjtw1uE4RNnLDTKSdmXOlqr1GTT/ETBtOIfGhJpLHywbQ/4E3tHyno0sUvWsXKNjs4WFA1fMnuSiJqlH+/4EZB7N1scQiRhRcfQMUz0vQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLNJCAM2Ajh3Tu2uhoO6ch2DaGeKdvrymZwHeq42QVM=;
 b=BzxsjVAER9ieKAsRuXm29mGUnBRGRJvKgsyw9rZzO0x5+/j07JnoKAgJn5OwUKs+D9AAVaveiF+HNSKg3CUIGdgX+BCqjy0ShZ2/4S3BxexrfpZjw+zAF+dLjqOqrWKdy8ZFgXpc0SgSpzHKgXY5nEcBMGLBPxJEJdlvXSR/Q3l1dTbYRnZhbnZFTFydYaBC5fxrVXP7CwG3YwbLZGfD3QT8SI2x/0JMVHXEQGSWjWhwyiPriSZPWgilkx7y9JUzPDnrIPekJxvgdS07Z86/e65WNTz54DyGW/uc2D59GI0QsF/UgEwGAMS4JuW6ryCwhvunrxvCX1Zd3S4xSUe+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLNJCAM2Ajh3Tu2uhoO6ch2DaGeKdvrymZwHeq42QVM=;
 b=JXlaF7SFkdCDG2s9uOu0rRGd47Bd7UqHI+bru3Qj2FWy7hN95SnZyPhKXlwq1qpNj9Dm/8BDhoOypNLObXj6B3MzIeYfzfkV2maCRM9smphYxjOPBzNNOy3XfywJbMQPFGHlbDm3LZdh3KE/pRUpYYgEvxGQtOHDCBc/8lsTxJE=
Received: from BN4PR10CA0019.namprd10.prod.outlook.com (2603:10b6:403::29) by
 SN6PR12MB4670.namprd12.prod.outlook.com (2603:10b6:805:11::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Mon, 21 Sep 2020 21:14:30 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:0:cafe::62) by BN4PR10CA0019.outlook.office365.com
 (2603:10b6:403::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Mon, 21 Sep 2020 21:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Mon, 21 Sep 2020 21:14:30 +0000
Received: from rkhaire-dev2.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 21 Sep
 2020 16:14:29 -0500
From: Rohit Khaire <rohit.khaire@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix SDMA RAP violations on Sienna Cichlid SRIOV
Date: Mon, 21 Sep 2020 17:14:14 -0400
Message-ID: <20200921211414.13285-1-rohit.khaire@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB02.amd.com (10.181.40.143) To SATLEXMB01.amd.com
 (10.181.40.142)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95fa8c7f-a085-4e25-f63a-08d85e735467
X-MS-TrafficTypeDiagnostic: SN6PR12MB4670:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4670CFF52530A1116B187C89873A0@SN6PR12MB4670.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fbjpv8pLRohxR/JlbKQH4bjC73xoTAa7CtJwpcYO53h4SQQNtYGaPmIzfl+XERmQ/gAVVeCXCtYBCtKKK/omGKumTOJTBgmw5jR7nfTsMGC/sscoJ+d9+5xT4VPnTMmzqoFckvgILD7QX/CZFPEuze4S8P+GiQWdOfGP4gvynFgzK8NcSuI3aahLRbpz3B4qZClwrSPSElYn/hr/nVmnzSJU7HNT6fzobM77w1PcFmML5m4DI68iSUp53LgpP/63sKRARvb/uS2hnx6K72wUMVty8k2XMxyrDORUkVfMEfe8AAybGGk09K9b4GWmSjXRgqwZrwSZ/M9We2XeM9nUKtCuENAZpjYvg+d92kv3RBOXq49mDxz26pWRljAGdRHxbH43lP0NdlZChk//+tv7HfQQe+0Af9NBPcz2k53lW0nJjiktC4Xv2PDyHQRRqvTx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966005)(1076003)(426003)(70586007)(26005)(86362001)(2906002)(70206006)(4326008)(6666004)(2616005)(7696005)(316002)(5660300002)(54906003)(186003)(478600001)(16526019)(44832011)(356005)(336012)(36756003)(81166007)(82740400003)(83380400001)(8936002)(47076004)(8676002)(6916009)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 21:14:30.2834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fa8c7f-a085-4e25-f63a-08d85e735467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4670
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>, Rohit Khaire <rohit.khaire@amd.com>,
 Rong Li <Rong.Li@amd.com>, Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, Frank Min <Frank.Min@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 128 ++++++++++++++-----------
 1 file changed, 70 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 34ccf376ee45..6fb5588fc0b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -541,7 +541,9 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
 			       phase_quantum);
 		}
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
+		if (!amdgpu_sriov_vf(adev))
+			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL),
+					f32_cntl);
 	}
 
 }
@@ -559,6 +561,9 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
 	u32 f32_cntl;
 	int i;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (!enable) {
 		sdma_v5_2_gfx_stop(adev);
 		sdma_v5_2_rlc_stop(adev);
@@ -596,7 +601,9 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		ring = &adev->sdma.instance[i].ring;
 		wb_offset = (ring->rptr_offs * 4);
 
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+		if (!amdgpu_sriov_vf(adev))
+			WREG32(sdma_v5_2_get_reg_offset(adev, i,
+				mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
@@ -621,13 +628,16 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		       lower_32_bits(wptr_gpu_addr));
 		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
 		       upper_32_bits(wptr_gpu_addr));
-		wptr_poll_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i,
-							 mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
-		wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
-					       SDMA0_GFX_RB_WPTR_POLL_CNTL,
-					       F32_POLL_ENABLE, 1);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
-		       wptr_poll_cntl);
+
+		if (!amdgpu_sriov_vf(adev)) {
+			wptr_poll_cntl = RREG32(sdma_v5_2_get_reg_offset(
+				adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
+			wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
+				SDMA0_GFX_RB_WPTR_POLL_CNTL,
+				F32_POLL_ENABLE, 1);
+			WREG32(sdma_v5_2_get_reg_offset(adev, i,
+				mmSDMA0_GFX_RB_WPTR_POLL_CNTL), wptr_poll_cntl);
+		}
 
 		/* set the wb address whether it's enabled or not */
 		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
@@ -673,30 +683,40 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		/* set minor_ptr_update to 0 after wptr programed */
 		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
 
-		/* set utc l1 enable flag always to 1 */
-		temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
-		temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
-
-		/* enable MCBP */
-		temp = REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENABLE, 1);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);
-
-		/* Set up RESP_MODE to non-copy addresses */
-		temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
-		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
-		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
-
-		/* program default cache read and write policy */
-		temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
-		/* clean read policy and write policy bits */
-		temp &= 0xFF0FFF;
-		temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
-			 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
-			 0x01000000);
-		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
-
 		if (!amdgpu_sriov_vf(adev)) {
+			/* set utc l1 enable flag always to 1 */
+			temp = RREG32(sdma_v5_2_get_reg_offset(adev, i,
+						mmSDMA0_CNTL));
+			temp = REG_SET_FIELD(temp, SDMA0_CNTL,
+						UTC_L1_ENABLE, 1);
+
+			/* enable MCBP */
+			temp = REG_SET_FIELD(temp, SDMA0_CNTL,
+						MIDCMD_PREEMPT_ENABLE, 1);
+			WREG32(sdma_v5_2_get_reg_offset(adev, i,
+						mmSDMA0_CNTL), temp);
+
+			/* Set up RESP_MODE to non-copy addresses */
+			temp = RREG32(sdma_v5_2_get_reg_offset(adev, i,
+						mmSDMA0_UTCL1_CNTL));
+			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL,
+						RESP_MODE, 3);
+			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL,
+						REDO_DELAY, 9);
+			WREG32(sdma_v5_2_get_reg_offset(adev, i,
+						mmSDMA0_UTCL1_CNTL), temp);
+
+			/* program default cache read and write policy */
+			temp = RREG32(sdma_v5_2_get_reg_offset(adev, i,
+						mmSDMA0_UTCL1_PAGE));
+			/* clean read policy and write policy bits */
+			temp &= 0xFF0FFF;
+			temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
+				(CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
+				0x01000000);
+			WREG32(sdma_v5_2_get_reg_offset(adev, i,
+						mmSDMA0_UTCL1_PAGE), temp);
+
 			/* unhalt engine */
 			temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
 			temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
@@ -717,11 +737,6 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 
 		ring->sched.ready = true;
 
-		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
-			sdma_v5_2_ctx_switch_enable(adev, true);
-			sdma_v5_2_enable(adev, true);
-		}
-
 		r = amdgpu_ring_test_ring(ring);
 		if (r) {
 			ring->sched.ready = false;
@@ -804,30 +819,23 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 {
 	int r = 0;
 
-	if (amdgpu_sriov_vf(adev)) {
-		sdma_v5_2_ctx_switch_enable(adev, false);
-		sdma_v5_2_enable(adev, false);
-
-		/* set RB registers */
-		r = sdma_v5_2_gfx_resume(adev);
-		return r;
-	}
+	if (!amdgpu_sriov_vf(adev)) {
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+			r = sdma_v5_2_load_microcode(adev);
+			if (r)
+				return r;
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
-		r = sdma_v5_2_load_microcode(adev);
-		if (r)
-			return r;
+			/* The value of mmSDMA_F32_CNTL is invalid the moment after loading fw */
+			if (amdgpu_emu_mode == 1)
+				msleep(1000);
+		}
 
-		/* The value of mmSDMA_F32_CNTL is invalid the moment after loading fw */
-		if (amdgpu_emu_mode == 1)
-			msleep(1000);
+		/* unhalt the MEs */
+		sdma_v5_2_enable(adev, true);
+		/* enable sdma ring preemption */
+		sdma_v5_2_ctx_switch_enable(adev, true);
 	}
 
-	/* unhalt the MEs */
-	sdma_v5_2_enable(adev, true);
-	/* enable sdma ring preemption */
-	sdma_v5_2_ctx_switch_enable(adev, true);
-
 	/* start the gfx rings and rlc compute queues */
 	r = sdma_v5_2_gfx_resume(adev);
 	if (r)
@@ -1403,8 +1411,12 @@ static int sdma_v5_2_set_trap_irq_state(struct amdgpu_device *adev,
 					enum amdgpu_interrupt_state state)
 {
 	u32 sdma_cntl;
+	u32 reg_offset;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
 
-	u32 reg_offset = sdma_v5_2_get_reg_offset(adev, type, mmSDMA0_CNTL);
+	reg_offset = sdma_v5_2_get_reg_offset(adev, type, mmSDMA0_CNTL);
 
 	sdma_cntl = RREG32(reg_offset);
 	sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
