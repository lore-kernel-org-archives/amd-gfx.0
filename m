Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BC3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 05:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B4210E45F;
	Tue, 15 Mar 2022 05:45:39 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D0E610E45F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 05:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrXtnHZeOiOP6atZxYLNsm2HjpZnzTEev1uDEe8iAf9fthpmYbNegoRRLitaQtfw/2dyFmb+VX1tO6NadW/NHkmSMMaKaPfQRRcis7D9MxmROurq0pxYTOzu9qrx4zCQk67UbARDZL5A2/OVxa/5IOp5SnlI/3ZCimqJfmxtO1wn359jfR916bTTOZjOFwHljYyMuT/gt3xBDYVkztFa2O93HRPGCdjah9AdM3laNrI7HzdebynnyWk0bTNiMqRjeGZDnP3z2IiSvZWT3HiI7/cO/2QtlSReZQAVXC0lx+B5Su4nM/du1I3+rksUygg4cIq2lJ3k02wf7+vj801XaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzVEYzPdN0dgJLE5M/NIHDfm1rywE5UaY/lRispoZ7g=;
 b=ANZczoUZqcLfBvpJeLTytRrm1d/BSED3H4NiW3FoIfiocL94zdsuRaR6AKBNaESGaODZfGh0ctDTyZDCeABBCtyNiIW7HNdIXrlvXSSBM7+Lk3Hm83DMaKgmSP9di+cpBFZKPcNZfCxZdW/seRQ7AqZIiLgG2DaAbt53FEsAomJl6R4TQuFa2h+p1DTeTuwDPaRbj0em6FjkqOyvhXODiVBZ+Ipq9xokTPPKIc5M87KKR376rgo9EzH9u8/ALOXImXb7V0xjgEHEFaen+1kTgvjvakS06KBJ6SGqwsdXajwG0AHCA9F7yVCXRFemTMRtIxtzCMgpljm/J+ohP4ZGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzVEYzPdN0dgJLE5M/NIHDfm1rywE5UaY/lRispoZ7g=;
 b=RaV+w/PdCECnnwcvp/Pcni8wo4NM4QJHgYiOyUxNR26pM45+Ft7N9UCntcM0oRqRHv7gnQaR4gdm4HYsOVxfKZBmqrtKfRPjoj2gObYnExgdsgzaHakz27YCbKlTtQRu5L2g6ooELnOyhz2qxy4YFmrWuxhC2QNGv4hklJAyGZc=
Received: from MW4PR04CA0171.namprd04.prod.outlook.com (2603:10b6:303:85::26)
 by CH2PR12MB5530.namprd12.prod.outlook.com (2603:10b6:610:35::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 05:45:35 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::f1) by MW4PR04CA0171.outlook.office365.com
 (2603:10b6:303:85::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25 via Frontend
 Transport; Tue, 15 Mar 2022 05:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 05:45:34 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 15 Mar
 2022 00:45:31 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: only allow secure submission on rings which
 support that
Date: Tue, 15 Mar 2022 13:45:18 +0800
Message-ID: <20220315054518.2374124-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d370dbba-c393-42d7-8144-08da06470669
X-MS-TrafficTypeDiagnostic: CH2PR12MB5530:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB553088EEC6BC3776B8FD94EFFB109@CH2PR12MB5530.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FfeUxkTuT2XIOGGYQegoufhipelA8SJrqoKaRJrKvbXY+VHSbgYzguJmi532pbIL8zhYxKvsZxhB+WKqXJAUMXV/5BiH0n2DSKerR0j2BZf/yu0NovPtGiqv6LLem8OIQn7AY/SfLW/shRf+27FwsFxXhiYF0rFEsQUodUcH806BV7Qc+xrZ591PIpSJdJ6br7u0uSCCyqUjb8GJaIJ6SRqlik/In5uYiFk697ZQFoN9KfhUenAzKMytQl51yeW18ca5Gt3YZsNPX5dcOLyTrBPhfs1ZUoAqSzpyO7Cakj0PmMrmkal79VMIclxm45+IDgv++QDZncjuTA/l5jIKdqA6U93Go79tn00c2CtHZX/rk2hGCL4sJGc7dSQJ4MSmdj3dU41rIeMhv95UNANhdZMcvMfTZ0G8X7otdwQDjd840ImNWJNAW5IKQt5b+Ta4sRERcsj998ds09bVi2Oop5MalKBNGlCaIm5bsDiQQsYWf+gROAt8pwcdK+weIgABA+2cyMRZLwiGoHbXShH1o7a6cuRYuLlDLtcYLjUoGM8gLqfMmDyJ8eI6qTq+iGi7c9da6AIK76Jb3k3nI3Vzth8LfCrcp+0DcD1RZJJgB/9j68xQAjDh7y+C2CSMnnObTcik173P9NhG0XcQ3zsLKLngOImQBI8eQdy+/79GgXYOurRf4/Gbqs0FetDUSUHTDue0XvPOzXpN0m+9RkVTuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(6666004)(8936002)(356005)(70586007)(1076003)(70206006)(508600001)(7696005)(36756003)(16526019)(26005)(5660300002)(81166007)(186003)(6916009)(426003)(54906003)(336012)(2906002)(82310400004)(83380400001)(316002)(8676002)(47076005)(4326008)(40460700003)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 05:45:34.4337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d370dbba-c393-42d7-8144-08da06470669
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5530
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only GFX ring, SDMA ring and VCN decode ring support secure submission
at the moment.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 4 ++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 2 ++
 13 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index bc1297dcdf97..d583766ea392 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -166,8 +166,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	}
 
 	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
-	    (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
-		dev_err(adev->dev, "secure submissions not supported on compute rings\n");
+	    (!ring->funcs->secure_submission_supported)) {
+		dev_err(adev->dev, "secure submissions not supported on ring <%s>\n", ring->name);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index a8bed1b47899..5320bb0883d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -155,6 +155,7 @@ struct amdgpu_ring_funcs {
 	u32			nop;
 	bool			support_64bit_ptrs;
 	bool			no_user_fence;
+	bool			secure_submission_supported;
 	unsigned		vmhub;
 	unsigned		extra_dw;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 713d39d89e30..f4c6accd3226 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9377,6 +9377,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.align_mask = 0xff,
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = gfx_v10_0_ring_get_rptr_gfx,
 	.get_wptr = gfx_v10_0_ring_get_wptr_gfx,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 8def7f630d4c..46d4bf27ebbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6865,6 +6865,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.align_mask = 0xff,
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = gfx_v9_0_ring_get_rptr_gfx,
 	.get_wptr = gfx_v9_0_ring_get_wptr_gfx,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 4509bd4cce2d..1d8bbcbd7a37 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -1142,6 +1142,7 @@ static const struct amdgpu_ring_funcs sdma_v2_4_ring_funcs = {
 	.align_mask = 0xf,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = false,
+	.secure_submission_supported = true,
 	.get_rptr = sdma_v2_4_ring_get_rptr,
 	.get_wptr = sdma_v2_4_ring_get_wptr,
 	.set_wptr = sdma_v2_4_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 135727b59c41..4ef4feff5649 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1580,6 +1580,7 @@ static const struct amdgpu_ring_funcs sdma_v3_0_ring_funcs = {
 	.align_mask = 0xf,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = false,
+	.secure_submission_supported = true,
 	.get_rptr = sdma_v3_0_ring_get_rptr,
 	.get_wptr = sdma_v3_0_ring_get_wptr,
 	.set_wptr = sdma_v3_0_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 01b385568c14..d7e8f7232364 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2414,6 +2414,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
 	.align_mask = 0xf,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = sdma_v4_0_ring_get_rptr,
 	.get_wptr = sdma_v4_0_ring_get_wptr,
@@ -2450,6 +2451,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs_2nd_mmhub = {
 	.align_mask = 0xf,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_MMHUB_1,
 	.get_rptr = sdma_v4_0_ring_get_rptr,
 	.get_wptr = sdma_v4_0_ring_get_wptr,
@@ -2482,6 +2484,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs = {
 	.align_mask = 0xf,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = sdma_v4_0_ring_get_rptr,
 	.get_wptr = sdma_v4_0_page_ring_get_wptr,
@@ -2514,6 +2517,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs_2nd_mmhub = {
 	.align_mask = 0xf,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_MMHUB_1,
 	.get_rptr = sdma_v4_0_ring_get_rptr,
 	.get_wptr = sdma_v4_0_page_ring_get_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 53a8df4b030e..a8d49c005f73 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1690,6 +1690,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 	.align_mask = 0xf,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = sdma_v5_0_ring_get_rptr,
 	.get_wptr = sdma_v5_0_ring_get_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index dcc622e18d45..824eace69884 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1687,6 +1687,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.align_mask = 0xf,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = sdma_v5_2_ring_get_rptr,
 	.get_wptr = sdma_v5_2_ring_get_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 7bbb9ba6b80b..6c9d5cde61c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1910,6 +1910,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
 	.align_mask = 0xf,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 319ac8ea434b..8cb2124405f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -2007,6 +2007,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v2_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v2_0_dec_ring_get_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 1869bae4104b..1bf672966a62 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1515,6 +1515,7 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
 static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_MMHUB_1,
 	.get_rptr = vcn_v2_5_dec_ring_get_rptr,
 	.get_wptr = vcn_v2_5_dec_ring_get_wptr,
@@ -1545,6 +1546,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
 static const struct amdgpu_ring_funcs vcn_v2_6_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v2_5_dec_ring_get_rptr,
 	.get_wptr = vcn_v2_5_dec_ring_get_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 5dbf5ba7d62d..c87263ed20ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1786,6 +1786,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0x3f,
 	.nop = VCN_DEC_SW_CMD_NO_OP,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
@@ -1944,6 +1945,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
+	.secure_submission_supported = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
-- 
2.25.1

