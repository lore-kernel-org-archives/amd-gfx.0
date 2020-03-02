Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2954DC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 01:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE392468D
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 01:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MV5cpKy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE392468D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B606C6E048;
	Mon,  2 Mar 2020 01:57:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 609F26E048
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 01:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bhi6PraOPmQse50gQ8sf+w50/dxzCklP1LfILt5i4sOuWZ0eNKMObSPaAF6YjD3PEUDfNtOoBevc047IwVPigtsVQugfzVjSQrwJiv7smADSaHhwxOeu7NHfjNnQMnxehBvahAjeBgSBhdC229DLG2RzaIf2BDv7SgpuTS9A00iNfBqoctk6C3WKycsLpYECJDOqQQsy6M2CXQzz5I8z5FG9ju4it7O4W3l0PohisnHH/7kZJz7PlpALTDvdLGeFkSIpxtiK24ESA2vyYsMWWELn/xzlMEkcDHeGMKYFoC5YnGiwD7y3uPfDBgOiFaz7VIsR0n0juc3xiHpHGEPPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS7eOUjyVI7ybfUwNLkuzSCae7dUVy0PPtLXbE43XEo=;
 b=oNjJ2ch8VmdMPX7lCTWUQX3LZDn0FqlAfm7dCwE95wVruXZ7dbiDXuGd4UNarwZrCvlsMLJI8GPj0Zb0pjf97Z8D2stJEaHi4LZalmTrwCvUoyWWVlfvqe6HglMIAdfJcuoIuNHRVHx9KpjosluKoYVQ7T+B+K+QGN7uhqj+rxLrT/s1Tjn02l91SkVEJq1XZiRxcJaspIsEPWxX0rm3vlHmYsAdnLlOQEUuzxahN6tuoNoyPOxNyiUqSjEAQnv4IXNYoDLTVK5qny7O4+lb3jLHl1MBYcSG60dQFRSRcOo3lrT86VODlplnA/sjhma56llc6cmX/lRzK+NQdtmrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS7eOUjyVI7ybfUwNLkuzSCae7dUVy0PPtLXbE43XEo=;
 b=MV5cpKy3euPGzVhj3ZEHhtT0RQeCdE04MbLq6TWkPZifa2RZq7s2LS4FTw2BtgDh0Q6Xu9HvPoTReiCCIXMgjSTRHlTPEgWVu8L9GVja2nxRQuJIVzkjIG0j6OaasblWi1cuJr426mdb1csZcBE0WB5MQWB09ahiVf4MHx2UUP0=
Received: from MWHPR1601CA0011.namprd16.prod.outlook.com
 (2603:10b6:300:da::21) by MN2PR12MB3520.namprd12.prod.outlook.com
 (2603:10b6:208:100::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 01:57:19 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::22) by MWHPR1601CA0011.outlook.office365.com
 (2603:10b6:300:da::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16 via Frontend
 Transport; Mon, 2 Mar 2020 01:57:19 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 01:57:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 1 Mar 2020
 19:57:18 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 1 Mar 2020
 19:57:17 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 1 Mar 2020 19:57:15 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable 3D pipe 1 on Navi1x
Date: Mon, 2 Mar 2020 09:57:13 +0800
Message-ID: <20200302015713.14355-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(428003)(199004)(189003)(7696005)(8936002)(6916009)(8676002)(70586007)(1076003)(5660300002)(81166006)(81156014)(70206006)(426003)(336012)(36756003)(478600001)(26005)(356004)(2616005)(316002)(54906003)(4326008)(2906002)(86362001)(186003)(44832011)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3520; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98c89720-5032-4e7f-554f-08d7be4d0a60
X-MS-TrafficTypeDiagnostic: MN2PR12MB3520:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3520DB1DF0EB874C3F54A8A695E70@MN2PR12MB3520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrHnkUw1wRzG1sU9H+Ci2UWtIL4ZExeVBCDsh7/mCfALANMonTK4Ku8m9+1u28Ck6WzSmoIxAk7sLRsmZCBA4cZQql7i2fwzkTGyt4TJRQTvvj/2lRzwIHahnoj8VHXGqJlZkVS2fWYOT5QJWKhvW4pQfmI3Vy9BBsxCf6wk65FSFC9hZNEs/ncRD6IKYvKysXqZ4Ac/MlK9MHMo+KEqoXvuNz6ngkciuX7+Ntzb64rvE4/o0d3f4XxqdrEvH/FQ7uOs4Xb0a271KFXwulGuYKtPE5fYMkb1RC0lZiHsM2DimFVJ3pEgnZStQVry2vrOt1KQEfFInUXME7+ounLha/5LzhYWtfX/O3oGfZ+C/mMS6ifmg5S+fbAf5gdhVzQcmZWaUEZq2+XL0tJ8SkQvYohnjxawGB4HtfzwctR/BbM5oSdx8ptLeyJZN2Fjhc9mqMzg1Nk1SVrM9OtNe0wqW5CqoPX7hQUVv4SbzdyL1jkrc7WYCbiaVO/xV75loFPl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 01:57:19.0450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c89720-5032-4e7f-554f-08d7be4d0a60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3520
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
Cc: Long Gang <Gang.Long@amd.com>, Pauline Li <pauline.li@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Tianci Yin <tianci.yin@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

[why]
CP firmware decide to skip setting the state for 3D pipe 1 for Navi1x as there
is no use case.

[how]
Disable 3D pipe 1 on Navi1x.

Change-Id: I6898bdfe31d4e7908bd9bcfa82b6a75e118e8727
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 97 ++++++++++++++------------
 1 file changed, 51 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 760fe2ebe799..f348512eb8c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -52,7 +52,7 @@
  * 1. Primary ring
  * 2. Async ring
  */
-#define GFX10_NUM_GFX_RINGS	2
+#define GFX10_NUM_GFX_RINGS_NV1X	1
 #define GFX10_MEC_HPD_SIZE	2048
 
 #define F32_CE_PROGRAM_RAM_SIZE		65536
@@ -1305,7 +1305,7 @@ static int gfx_v10_0_sw_init(void *handle)
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 2;
+		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
@@ -2711,18 +2711,20 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 	amdgpu_ring_commit(ring);
 
 	/* submit cs packet to copy state 0 to next available state */
-	ring = &adev->gfx.gfx_ring[1];
-	r = amdgpu_ring_alloc(ring, 2);
-	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
-		return r;
-	}
-
-	amdgpu_ring_write(ring, PACKET3(PACKET3_CLEAR_STATE, 0));
-	amdgpu_ring_write(ring, 0);
+	if (adev->gfx.num_gfx_rings > 1) {
+		/* maximum supported gfx ring is 2 */
+		ring = &adev->gfx.gfx_ring[1];
+		r = amdgpu_ring_alloc(ring, 2);
+		if (r) {
+			DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+			return r;
+		}
 
-	amdgpu_ring_commit(ring);
+		amdgpu_ring_write(ring, PACKET3(PACKET3_CLEAR_STATE, 0));
+		amdgpu_ring_write(ring, 0);
 
+		amdgpu_ring_commit(ring);
+	}
 	return 0;
 }
 
@@ -2819,39 +2821,41 @@ static int gfx_v10_0_cp_gfx_resume(struct amdgpu_device *adev)
 	mutex_unlock(&adev->srbm_mutex);
 
 	/* Init gfx ring 1 for pipe 1 */
-	mutex_lock(&adev->srbm_mutex);
-	gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID1);
-	ring = &adev->gfx.gfx_ring[1];
-	rb_bufsz = order_base_2(ring->ring_size / 8);
-	tmp = REG_SET_FIELD(0, CP_RB1_CNTL, RB_BUFSZ, rb_bufsz);
-	tmp = REG_SET_FIELD(tmp, CP_RB1_CNTL, RB_BLKSZ, rb_bufsz - 2);
-	WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
-	/* Initialize the ring buffer's write pointers */
-	ring->wptr = 0;
-	WREG32_SOC15(GC, 0, mmCP_RB1_WPTR, lower_32_bits(ring->wptr));
-	WREG32_SOC15(GC, 0, mmCP_RB1_WPTR_HI, upper_32_bits(ring->wptr));
-	/* Set the wb address wether it's enabled or not */
-	rptr_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
-	WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
-	WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR_HI, upper_32_bits(rptr_addr) &
-		CP_RB1_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
-	wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
-	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO,
-		lower_32_bits(wptr_gpu_addr));
-	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI,
-		upper_32_bits(wptr_gpu_addr));
-
-	mdelay(1);
-	WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
-
-	rb_addr = ring->gpu_addr >> 8;
-	WREG32_SOC15(GC, 0, mmCP_RB1_BASE, rb_addr);
-	WREG32_SOC15(GC, 0, mmCP_RB1_BASE_HI, upper_32_bits(rb_addr));
-	WREG32_SOC15(GC, 0, mmCP_RB1_ACTIVE, 1);
-
-	gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
-	mutex_unlock(&adev->srbm_mutex);
-
+	if (adev->gfx.num_gfx_rings > 1) {
+		mutex_lock(&adev->srbm_mutex);
+		gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID1);
+		/* maximum supported gfx ring is 2 */
+		ring = &adev->gfx.gfx_ring[1];
+		rb_bufsz = order_base_2(ring->ring_size / 8);
+		tmp = REG_SET_FIELD(0, CP_RB1_CNTL, RB_BUFSZ, rb_bufsz);
+		tmp = REG_SET_FIELD(tmp, CP_RB1_CNTL, RB_BLKSZ, rb_bufsz - 2);
+		WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
+		/* Initialize the ring buffer's write pointers */
+		ring->wptr = 0;
+		WREG32_SOC15(GC, 0, mmCP_RB1_WPTR, lower_32_bits(ring->wptr));
+		WREG32_SOC15(GC, 0, mmCP_RB1_WPTR_HI, upper_32_bits(ring->wptr));
+		/* Set the wb address wether it's enabled or not */
+		rptr_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
+		WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
+		WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR_HI, upper_32_bits(rptr_addr) &
+			     CP_RB1_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
+		wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+		WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO,
+			     lower_32_bits(wptr_gpu_addr));
+		WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI,
+			     upper_32_bits(wptr_gpu_addr));
+
+		mdelay(1);
+		WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
+
+		rb_addr = ring->gpu_addr >> 8;
+		WREG32_SOC15(GC, 0, mmCP_RB1_BASE, rb_addr);
+		WREG32_SOC15(GC, 0, mmCP_RB1_BASE_HI, upper_32_bits(rb_addr));
+		WREG32_SOC15(GC, 0, mmCP_RB1_ACTIVE, 1);
+
+		gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
+		mutex_unlock(&adev->srbm_mutex);
+	}
 	/* Switch to pipe 0 */
 	mutex_lock(&adev->srbm_mutex);
 	gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
@@ -3967,7 +3971,8 @@ static int gfx_v10_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->gfx.num_gfx_rings = GFX10_NUM_GFX_RINGS;
+	adev->gfx.num_gfx_rings = GFX10_NUM_GFX_RINGS_NV1X;
+
 	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
 
 	gfx_v10_0_set_kiq_pm4_funcs(adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
