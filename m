Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CB5C48BE5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84EE8611CE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EE8611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB08E6E8C6;
	Thu, 17 Jun 2021 08:40:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B89D56E8C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 08:40:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAszPJ7RR2JQpUPkDZrY5SnLf/3dcj8ZRU6JlIH3YIBvYBQMTv0qZzC6xYfk2IUl20sJ/tkzLFcRmIw1VcOCrUofr7IPC0vMKlFsZq4Uepp2GYMlVobYf1Wx+Jjl/nhLNRSLGKTzyAIuPtEXr+4IDRK3ZtxO7BK+5LXHVb61CUdVlio/bINorWjCZBvZBHwLgFfPmnEdPhNMXy9n11gBilbb1TsnH4nQh6ZbxSqqJ21idhngcH9NUq6Vvi0DwPR6np54pSbv/c19FSolduhMEquJ7ZdpoKvZ7RjowOFH30FKgAIXRqyJOdY26fztDpZ2ToCaqykaqDI0TSyYGAdKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwE+/WgVKBRtazhGccNFLcknlcNhJZEjkVJApB5aFfc=;
 b=jTIDU8bIzKWXbBW/LrubPWyDMvGoB+bDiaGB+BTW+M+ydvgRXI1fqVY8cFT/A1AWiR9KQHzVpj5W5B8TjItbMHDr+pFr1OWCXHpxlFtlwjBLAf3QaxMj4nmWrKMc/7wxP2rYOr27vUc+9tFKVqRcCYAi1D7sPvJTi+PcDDqQWNBs32ZbLtEcdrQRx1yEjz7LsDa3IvA2psBR1mF2ViKr66L0h97uDBvq2s3ZKK4d6PmN3IaHPsGnC5r6lESHzB8Adwj1Fxq8M729om8/FDqyG6Tf+1uyJlm/jx8IN2KQgO49+ZOJCjRWvqltu5nC8kX/GmfKnlh60XhoYdq49NLu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwE+/WgVKBRtazhGccNFLcknlcNhJZEjkVJApB5aFfc=;
 b=kYDHIg6kGqQODR66znq7qPEe09BNApbIQVDAycHT9FM5wwgp1Ogwob6wD3Onbs/X/sZXjbK2mqMcHtqyyGFvCt3hA2oCoF0r2ZiyG1/y8PXl/gaa9Q/IXvzJs4ycMlnGj4B8SIN/XiGxAQxtnEtHPZn+Mrx9kfH8vGGCK+mkSAU=
Received: from BN6PR1701CA0024.namprd17.prod.outlook.com
 (2603:10b6:405:15::34) by BN8PR12MB4625.namprd12.prod.outlook.com
 (2603:10b6:408:71::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 08:39:57 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::36) by BN6PR1701CA0024.outlook.office365.com
 (2603:10b6:405:15::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Thu, 17 Jun 2021 08:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 08:39:57 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 17 Jun
 2021 03:39:55 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 5/7] drm/amdgpu: correct clock gating settings on feature
 unsupported
Date: Thu, 17 Jun 2021 16:39:21 +0800
Message-ID: <20210617083923.421052-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210617083923.421052-1-evan.quan@amd.com>
References: <20210617083923.421052-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5473432c-bde3-419f-4059-08d9316b7ce0
X-MS-TrafficTypeDiagnostic: BN8PR12MB4625:
X-Microsoft-Antispam-PRVS: <BN8PR12MB4625C40272E9F5B49AD37670E40E9@BN8PR12MB4625.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AN4GCCtxc/B/vqEpODWzRyZoQxVszB5a5eMBsdLPxaR2/tTaN+jksPZncwQLfG88aliI0KCRDnxTmAmjmlg+GHyaBKm1zarly+aNdVpJeKFAAL204wpBkvROaoDDoU8KIv7Zk9ET2qW4DiGEti8eb5mKKBXuhedwv0jYOOaF9U5DFzJ7eW2/ieYtLE3+d7JxMafN7HjJLsJu/kSGmaCFoVMqD8Ku58more+Yyco7h512IWl4+T4a9/uKykOO59Y9stDykeWgIH4jKJvbslYtZWXUzrVhcdpdFR9k4e7yDp9BWF9Reo09ammixx8rAqHao2AxaHM35EGh8Ebc/ZPAfWxNGaOaugfiCCK40huakI5vlHXhSTLK5at6FKbPas+8mR26b2gxsUJjRFEa5jTagksPHHDSMXu099t61JROj0vAjrlOx5iT7WrByWEsbkmQy15l3rnVx14wsTEb4TmPad7wwFs9eq89OKA4MLoD/CsVLHQ/4iGE5Wzkv55jKCKYQ3mWR9fc+IHGrhBEL7MM6JYv2mhKuDLmujpXwNY7pKLeqlloqmTRD4vvXOnEdolKwYtfGKwdLSqbwLwVGW4p7Lw0p7e4EwwcbR0eVZFdF2axhIpJXYeqhsPVi0aGuBN2Y9J9doAkpph+2jHhWzpKs2Sqo9/ntub6CzjD0WLKamk61ZD9skHpB2RtymuE8Ppr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(46966006)(81166007)(316002)(86362001)(478600001)(70206006)(8936002)(2616005)(70586007)(30864003)(36860700001)(82310400003)(82740400003)(7696005)(426003)(336012)(6916009)(54906003)(8676002)(356005)(47076005)(83380400001)(186003)(6666004)(16526019)(2906002)(5660300002)(44832011)(36756003)(1076003)(26005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 08:39:57.5519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5473432c-bde3-419f-4059-08d9316b7ce0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4625
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Clock gating setting is still performed even when the corresponding
CG feature is not supported. And the tricky part is disablement is
actually performed no matter for enablement or disablement request.
That seems not logically right.
Considering HW should already properly take care of the CG state, we
will just skip the corresponding clock gating setting when the feature
is not supported.

Change-Id: Ic0995cf3de9f36b59316a90a28b7c95a08f4dccd
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c  | 12 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 69 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 10 +++-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c   | 10 +++-
 drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c |  5 +-
 5 files changed, 83 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
index 5b90efd6f6d0..3ac505d954c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
@@ -36,9 +36,12 @@ athub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 {
 	uint32_t def, data;
 
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG))
+		return;
+
 	def = data = RREG32_SOC15(ATHUB, 0, mmATHUB_MISC_CNTL);
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG))
+	if (enable)
 		data |= ATHUB_MISC_CNTL__CG_ENABLE_MASK;
 	else
 		data &= ~ATHUB_MISC_CNTL__CG_ENABLE_MASK;
@@ -53,10 +56,13 @@ athub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *adev,
 {
 	uint32_t def, data;
 
+	if (!((adev->cg_flags & AMD_CG_SUPPORT_MC_LS) &&
+	       (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS)))
+		return;
+
 	def = data = RREG32_SOC15(ATHUB, 0, mmATHUB_MISC_CNTL);
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS) &&
-	    (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
+	if (enable)
 		data |= ATHUB_MISC_CNTL__CG_MEM_LS_ENABLE_MASK;
 	else
 		data &= ~ATHUB_MISC_CNTL__CG_MEM_LS_ENABLE_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5cfd4800d5be..7d9464611d26 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7786,8 +7786,11 @@ static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 {
 	uint32_t data, def;
 
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG))
+		return;
+
 	/* It is disabled by HW by default */
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
+	if (enable) {
 		/* 0 - Disable some blocks' MGCG */
 		WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, 0xe0000000);
 		WREG32_SOC15(GC, 0, mmCGTT_WD_CLK_CTRL, 0xff000000);
@@ -7854,22 +7857,34 @@ static void gfx_v10_0_update_3d_clock_gating(struct amdgpu_device *adev,
 {
 	uint32_t data, def;
 
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_GFX_3D_CGCG | AMD_CG_SUPPORT_GFX_3D_CGLS)))
+		return;
+
 	/* Enable 3D CGCG/CGLS */
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)) {
+	if (enable) {
 		/* write cmd to clear cgcg/cgls ov */
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
+
 		/* unset CGCG override */
-		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
+
 		/* update CGCG and CGLS override bits */
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
+
 		/* enable 3Dcgcg FSM(0x0000363f) */
 		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
-		data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
-			RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
+		data = 0;
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
+			data = (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+				RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
+
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
 			data |= (0x000F << RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
 				RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
+
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D, data);
 
@@ -7882,9 +7897,14 @@ static void gfx_v10_0_update_3d_clock_gating(struct amdgpu_device *adev,
 	} else {
 		/* Disable CGCG/CGLS */
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
+
 		/* disable cgcg, cgls should be disabled */
-		data &= ~(RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK |
-			  RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK);
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
+			data &= ~RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
+			data &= ~RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
+
 		/* disable cgcg and cgls in FSM */
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D, data);
@@ -7896,25 +7916,35 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 {
 	uint32_t def, data;
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)) {
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_GFX_CGCG | AMD_CG_SUPPORT_GFX_CGLS)))
+		return;
+
+	if (enable) {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
+
 		/* unset CGCG override */
-		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
+
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
 			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGLS_OVERRIDE_MASK;
-		else
-			data |= RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGLS_OVERRIDE_MASK;
+
 		/* update CGCG and CGLS override bits */
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
 
 		/* enable cgcg FSM(0x0000363F) */
 		def = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
-		data = (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
-			RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
+		data = 0;
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
+			data = (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+				RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
+
 		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
 			data |= (0x000F << RLC_CGCG_CGLS_CTRL__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
 				RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK;
+
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL, data);
 
@@ -7926,8 +7956,14 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 			WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_CNTL, data);
 	} else {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
+
 		/* reset CGCG/CGLS bits */
-		data &= ~(RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK | RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK);
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
+			data &= ~RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
+			data &= ~RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK;
+
 		/* disable cgcg and cgls in FSM */
 		if (def != data)
 			WREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL, data);
@@ -7939,7 +7975,10 @@ static void gfx_v10_0_update_fine_grain_clock_gating(struct amdgpu_device *adev,
 {
 	uint32_t def, data;
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_FGCG)) {
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_FGCG))
+		return;
+
+	if (enable) {
 		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
 		/* unset FGCG override */
 		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index f7e93bbc4e15..7ded6b2f058e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -568,6 +568,9 @@ static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *ad
 {
 	uint32_t def, data, def1, data1;
 
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG))
+		return;
+
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
@@ -582,7 +585,7 @@ static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *ad
 		break;
 	}
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG)) {
+	if (enable) {
 		data |= MM_ATC_L2_MISC_CG__ENABLE_MASK;
 
 		data1 &= ~(DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
@@ -627,6 +630,9 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *ade
 {
 	uint32_t def, data;
 
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_MC_LS))
+		return;
+
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
@@ -639,7 +645,7 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *ade
 		break;
 	}
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS))
+	if (enable)
 		data |= MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
 	else
 		data &= ~MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index 05ddec7ba7e2..791cc48752e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -218,8 +218,11 @@ static void nbio_v2_3_update_medium_grain_clock_gating(struct amdgpu_device *ade
 {
 	uint32_t def, data;
 
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG))
+		return;
+
 	def = data = RREG32_PCIE(smnCPM_CONTROL);
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG)) {
+	if (enable) {
 		data |= (CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MASK |
 			 CPM_CONTROL__TXCLK_DYN_GATE_ENABLE_MASK |
 			 CPM_CONTROL__TXCLK_LCNT_GATE_ENABLE_MASK |
@@ -244,8 +247,11 @@ static void nbio_v2_3_update_medium_grain_light_sleep(struct amdgpu_device *adev
 {
 	uint32_t def, data;
 
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
+		return;
+
 	def = data = RREG32_PCIE(smnPCIE_CNTL2);
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS)) {
+	if (enable) {
 		data |= (PCIE_CNTL2__SLV_MEM_LS_EN_MASK |
 			 PCIE_CNTL2__MST_MEM_LS_EN_MASK |
 			 PCIE_CNTL2__REPLAY_MEM_LS_EN_MASK);
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
index e9c474c217ec..b6f1322f908c 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
@@ -43,9 +43,12 @@ static void smuio_v11_0_update_rom_clock_gating(struct amdgpu_device *adev, bool
 	if (adev->flags & AMD_IS_APU)
 		return;
 
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_ROM_MGCG))
+		return;
+
 	def = data = RREG32_SOC15(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0);
 
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_ROM_MGCG))
+	if (enable)
 		data &= ~(CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE0_MASK |
 			CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE1_MASK);
 	else
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
