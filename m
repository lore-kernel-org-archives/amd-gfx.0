Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9405FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 11:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A8E10E730;
	Fri,  4 Nov 2022 11:20:05 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2069.outbound.protection.outlook.com [40.107.212.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4412A10E730
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 11:20:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hp03gHHpF2N1fqchqfbihl72T+CJ7se/Vwt3N6xwO4KcV0Sa/fg57U3CLPf80ENtefbs07aYUFmwGGbQa2YUGZEdX2uT1ci5qccig1CIHOhEfkeNei7OAGGU+5DCxFem96BX8irC04Eu8k38R38zK23AXT8Ww00gAuPcfyWwISZ3Q96uX/hks2JNRNPj1uRFwCNuE0QTZDe0ovC3dtfU7amno9KaPfzBmjitA7w0xKa51unwCnuE6eJU1aoQE+VeXYYyKBtWuN30yu7FIL2YAnOWKVdvg9zceaTga4RG3L8q5g1LsxAvylEWLU8fTs7hARYHVzz96m2i3znanCgk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1ByZ4cEfLwoTSmxW5pnvZGl+DytA1v36cOs7Fwo4qc=;
 b=LhBAxa93U7FcfMqCMbiF3Xf9OkSMYzLnmqhPO5yrKzR4ND8Vi55hnL2+MlZU3C+VMWP4lmCRzApvIuCe+Gnp0QevbDgEx5mxj9/ePzObzM8l6xP0O2ijnJfSvkrglHIpmA4m7UVOms9lbb9Dc64bl/KzytVce+CWhbwuuQgV8wJpuVOmLUw0u8f5DSjJYXzW86Oj27c55PXQ6skMcEPT4Nj6IjvJY4/IzqbJpwLES2SPg/kCJnBeelicOBomS73ox/AO/FCNwqVi9JmHEE3exhwJWrIVHYr30efGVW12mCbMx9GDiOHyArDfKPMdrKerjgve6ttPegx9/sZ0tBN+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1ByZ4cEfLwoTSmxW5pnvZGl+DytA1v36cOs7Fwo4qc=;
 b=Nh1GRs1bYVlZI2eIHpn3V1QpJ5HPKYu0HUfG/gfN3W6BPlGIETsFKWcKigAdaSB+GbLgYdawDlirZRPM2zz1pWZzf1+dW+PcJ3h1c+RaD/hVphpT2XR6TXnMWJ7p6jluG7rylN5RhVoYZvYbznqwj4mAHIvvxfCOX5ZLiG6xuVE=
Received: from MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::33)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:219::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 4 Nov
 2022 11:19:57 +0000
Received: from CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::5e) by MW4P221CA0028.outlook.office365.com
 (2603:10b6:303:8b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 11:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT073.mail.protection.outlook.com (10.13.174.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 11:19:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 06:19:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 06:19:56 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Fri, 4 Nov 2022 06:19:55 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Enable gfx pipe1 and fix related issues
Date: Fri, 4 Nov 2022 19:19:52 +0800
Message-ID: <20221104111952.298814-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT073:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4e5a9a-81e4-4222-3661-08dabe5681a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wwGwUHnT1E9nuxrBAFXXrcr31MuNy2LXNgUSI56VY8urrB3F7IGo6f7NbzdnijR0cmH6M3AKgh69iYc0qeNil4eJk/m8gQ3wqm1ZQ7aZJHY5kiiXvOHQ0fo7AAH0TrmXn3UwyyQXZUtDgsamjAhIptYe+Gmm1B19MXVHpSCljfoqD4LbizLg39bz4Wje1uJ1XlEB8tSgA2KIqVljLowFO1v34utS/yKFA2y1rwtGVpeLPky6F/hCnos/DMLHaQG9OPpcgUN/wlpSellyNhMiXl6WLVGZMva34giBCtbQBq9aga1ZjkCt2BzG9yUNdfyNI/1ccWRybohZ171umIUxdF7ucBve/1HjJpf026DMibM4YwiWSYhmhuOnTahhIuk02OUFC2FVXPPqFFUf7RVAIl09hentpnsMcdyQJBYkPvcWvAoOKUOxNu93vaMf00VUm4nI+pGnZjGZc0UMyuVKTfy8Qllp0Wb6WX1+YEk538a+tc3MXtv90O6ebwPpd2lfJeLqxxSJiram7S8h+xAJW9fazJHesv2JoDmxMZSuTmmQgNETt6lUu6hDrET/n52Zh+FDPOtOUqolfAzjc+PWooUwAWjfs7hqLY4hGZJWBqZaJT/sB7or1MP+HbVfb2SMktBdZF7k2YxhxaTM8/3/PSHBRaXKf6pUavXPQOSxhFs7aZfMpsg59F11WBLNiA6cht8jEZpMdxNKAW47PqMr/6plxDob60mMqTF3Vc23Am/jffrWfnfXPLim8J4dLshR+S+bzYZh2asIi6Dbx8sluhnNk+Kk2puel0/eUKJjmOFuulWcJkHm26uqrggxy23CioLmAPx59herRGwqLLPw45Fn8FpCn/yNGhw5xikTOBo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(1076003)(36860700001)(5660300002)(426003)(26005)(6666004)(47076005)(6916009)(316002)(40480700001)(2616005)(4326008)(8936002)(40460700003)(186003)(36756003)(41300700001)(2906002)(86362001)(7696005)(70586007)(83380400001)(8676002)(336012)(81166007)(356005)(478600001)(82740400003)(70206006)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 11:19:57.5762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4e5a9a-81e4-4222-3661-08dabe5681a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359
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
Cc: Emily Deng <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Starting from SIENNA CICHLID asic supports two gfx pipes, enabling
two graphics queues for performance concern.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 42 ++++++++++++-------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 331aa191910c..0072f36b44d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -33,7 +33,7 @@
 	container_of((e), struct amdgpu_ctx_entity, entity)
 
 const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
-	[AMDGPU_HW_IP_GFX]	=	1,
+	[AMDGPU_HW_IP_GFX]	=	2,
 	[AMDGPU_HW_IP_COMPUTE]	=	4,
 	[AMDGPU_HW_IP_DMA]	=	2,
 	[AMDGPU_HW_IP_UVD]	=	1,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 49d34c7bbf20..bbf18060611e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4606,7 +4606,7 @@ static int gfx_v10_0_sw_init(void *handle)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_pipe_per_me = 2;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
@@ -6008,6 +6008,24 @@ static int gfx_v10_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int gfx_v10_0_wait_for_idle(void *handle)
+{
+	unsigned i;
+	u32 tmp;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		/* read MC_STATUS */
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS) &
+			GRBM_STATUS__GUI_ACTIVE_MASK;
+
+		if (!REG_GET_FIELD(tmp, GRBM_STATUS, GUI_ACTIVE))
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+}
+
 static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
@@ -6069,7 +6087,7 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 	amdgpu_ring_write(ring, 0x8000);
 
 	amdgpu_ring_commit(ring);
-
+	gfx_v10_0_wait_for_idle(adev);
 	/* submit cs packet to copy state 0 to next available state */
 	if (adev->gfx.num_gfx_rings > 1) {
 		/* maximum supported gfx ring is 2 */
@@ -7404,24 +7422,6 @@ static bool gfx_v10_0_is_idle(void *handle)
 		return true;
 }
 
-static int gfx_v10_0_wait_for_idle(void *handle)
-{
-	unsigned i;
-	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	for (i = 0; i < adev->usec_timeout; i++) {
-		/* read MC_STATUS */
-		tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS) &
-			GRBM_STATUS__GUI_ACTIVE_MASK;
-
-		if (!REG_GET_FIELD(tmp, GRBM_STATUS, GUI_ACTIVE))
-			return 0;
-		udelay(1);
-	}
-	return -ETIMEDOUT;
-}
-
 static int gfx_v10_0_soft_reset(void *handle)
 {
 	u32 grbm_soft_reset = 0;
@@ -8466,7 +8466,7 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 		}
 		reg_mem_engine = 0;
 	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
+		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
 		reg_mem_engine = 1; /* pfp */
 	}
 
-- 
2.36.1

