Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E8AC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1327110EA26;
	Tue,  3 May 2022 20:09:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66A410E9EE
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzj8L0C9c0NR2GW9nvyF935kxT9+1hQMgk2sMpx1XmQkSvf8m9DxtSlNjDYvjEtkXZkThVoJsCauBQu+dUqOH5od2ShlU0mAqQEV0cNqz/w+gjEiEwuziSQSIjdcYnJh33NUeUyjrsH1RMY8q8p4X3gvO2tuTneDeRbyW3WpnhkzYZIFO9Mf7P2sZUMFvIskzycFLnYkhEsy/NMDnmcjLxdsRxy1J7f+82J2t0+oRMUTD/TnqFQA5Tv6OlPt4OvHbBHxuRVK8r57uX1rwka+szeH3WDPELlm8NdJwer3RlV1gJ+YuBOqKzb2uGHq9HaPnXDeZGAC+VzNYZaLv7vXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jht3I2VfeF8dnVIwn+YNuyjKbLzc5er3dOF/Ojd3kLc=;
 b=Y553dhMGdx8pk4ICVWHfm0G93vit7ZGm3WEhjjaO0pB1IQDQMUARnQGJxmEpbbvumyOqw0eQc/yEDam8a/MZBxOpHKiaVcTd8bk3047F01QJzWAzfiI5Ap0VRYcnQMojRnVKbfT8Sl5E0/OfZNfXpFV9+d5KDUbI50bQmdqh/NaIQE0oZX5Ve/a08lL0SWBBoTeIzq+rNbEMzR2uYiYprMoeJ35BbH/7SWX8eOOBf4N5pI8IvvPJ2XTzD2BFLBVEosaM2QmpOpGsjvmE0fu/+nzsX1d/2bhbLEWt1wYl258ywwyRdlHkOAzm+fexL8+oDIhgj2C2fOQSQGUGkF6fkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jht3I2VfeF8dnVIwn+YNuyjKbLzc5er3dOF/Ojd3kLc=;
 b=3JGVw/dyQC/mCXjg1Lt4FzPN68VOXLZtnI4re/i27gvaWXiqb/E55VVGCl6kwelHI+l8pPRdZHW2S7dXA4J4Hd+cnfl+QHsF71R31eBEWDA+4+YxVFhzLG6Ui4Mmmv4Buj2LmIm8qVH1P1LtdNbG8Fg/ySG+PJ6spUHbXWOkBE4=
Received: from DM6PR07CA0062.namprd07.prod.outlook.com (2603:10b6:5:74::39) by
 IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:09:14 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::f0) by DM6PR07CA0062.outlook.office365.com
 (2603:10b6:5:74::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable more GFX clockgating features for GC 11.0.0
Date: Tue, 3 May 2022 16:08:38 -0400
Message-ID: <20220503200855.1163186-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a7e446c-f229-4cb3-6666-08da2d40cbcd
X-MS-TrafficTypeDiagnostic: IA1PR12MB6307:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB630786B3C226FFBDEDA5CBA3F7C09@IA1PR12MB6307.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cEcDxzS9NvF4VuEVhvQBPhFWo2l2W+8V7ragfUnlu0kDaQs2pF1sZllKKu21vLUemqlmW5BS/J815NUa+M3r3G/BhivYDeO204UkrWNJTGqRcwQ0PXS7QDt7yzlhjKrbE6ESDFItLAaag2QQM3av13a1J5PvYH0dLt8Ezfe8EegJpghS3o/d/xOsXbvqzo+XbHv8nqdO8TcWBBdF+jg+oceKmufrn8o3H/cApRBx3LJiFiCOj6KqN8xYN99n4JCJ7Cxv/WARXgLJgG0cY/kNmNHW9RJ/hZdwk0tIgmKAqMi//tN5JSePOxhNRLbM9x2bvH7v9PkoMvpff89OrI8r7GpwwwQDKVeR/X2yYC3GM4XMX3DdfZfxeIq+Z+yDb9HlM6JXYARIJJctVp0i+adVNgXrTSSIa5uV4zYjriVDwcasE2bLCzRW44KK3ZGWZ3HDb7/l835nzzl13i1pb58s8Xw2se/H12ncaTVV0zvxZvYjxnXjDe8alXJv850gnUGZPAQRRR8XFmcD/phC99RaM0vtYf88PBEDzShbHY6m7wQlCexc191VjxnK40IvtPdrLO+f3p9Z+3ygPC5b8nzZCCX/rhKvu9NIb5uEmq3b05vPtChY+QWH3hbfYiZJ+8+3CEWxpioCtE0UAVEpTwtDbk7cEGMCOV0e1j2ZxmHNiVTP0XMj0qEC/DWh0r0oNuCBYUt9FO76aQW5+6ue3zXMPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(70586007)(508600001)(316002)(5660300002)(54906003)(6916009)(4326008)(356005)(86362001)(8936002)(81166007)(8676002)(70206006)(6666004)(186003)(83380400001)(16526019)(36756003)(40460700003)(82310400005)(47076005)(426003)(336012)(2616005)(1076003)(36860700001)(2906002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:14.5645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7e446c-f229-4cb3-6666-08da2d40cbcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Support more GFX clockgating features(3D_CGCG, 3D_CGLS, MGCG,
FGCG and PERF_CLK).

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 100 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/soc21.c       |   5 ++
 drivers/gpu/drm/amd/include/amd_shared.h |   1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c       |   2 +-
 4 files changed, 93 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 184bf554acca..8a1c0f783a2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4888,6 +4888,44 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);
 }
 
+static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
+				      bool enable)
+{
+	uint32_t def, data;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
+		return;
+
+	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+	if (enable)
+		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+	else
+		data |= RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+}
+
+static void gfx_v11_0_update_sram_fgcg(struct amdgpu_device *adev,
+				       bool enable)
+{
+	uint32_t def, data;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_FGCG))
+		return;
+
+	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+	if (enable)
+		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK;
+	else
+		data |= RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+}
+
 static void gfx_v11_0_update_repeater_fgcg(struct amdgpu_device *adev,
 					   bool enable)
 {
@@ -4907,19 +4945,40 @@ static void gfx_v11_0_update_repeater_fgcg(struct amdgpu_device *adev,
 		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
 }
 
-#if 0
 static void gfx_v11_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
-						      bool enable)
+						       bool enable)
 {
-	/* TODO: add power related feature later. */
-}
+	uint32_t data, def;
 
-static void gfx_v11_0_update_3d_clock_gating(struct amdgpu_device *adev,
-					   bool enable)
-{
-	/* TODO: add power related feature later. */
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_GFX_MGCG | AMD_CG_SUPPORT_GFX_MGLS)))
+		return;
+
+	/* It is disabled by HW by default */
+	if (enable) {
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG) {
+			/* 1 - RLC_CGTT_MGCG_OVERRIDE */
+			def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+			data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
+				  RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
+				  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK);
+
+			if (def != data)
+				WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+		}
+	} else {
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG) {
+			def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+			data |= (RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
+				 RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
+				 RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK);
+
+			if (def != data)
+				WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+		}
+	}
 }
-#endif
 
 static void gfx_v11_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
 						       bool enable)
@@ -5050,8 +5109,14 @@ static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 
 	gfx_v11_0_update_coarse_grain_clock_gating(adev, enable);
 
+	gfx_v11_0_update_medium_grain_clock_gating(adev, enable);
+
 	gfx_v11_0_update_repeater_fgcg(adev, enable);
 
+	gfx_v11_0_update_sram_fgcg(adev, enable);
+
+	gfx_v11_0_update_perf_clk(adev, enable);
+
 	if (adev->cg_flags &
 	    (AMD_CG_SUPPORT_GFX_MGCG |
 	     AMD_CG_SUPPORT_GFX_CGLS |
@@ -5144,16 +5209,23 @@ static void gfx_v11_0_get_clockgating_state(void *handle, u64 *flags)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
 
-	/* AMD_CG_SUPPORT_GFX_FGCG */
-	data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
-	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK))
-		*flags |= AMD_CG_SUPPORT_GFX_FGCG;
-
 	/* AMD_CG_SUPPORT_GFX_MGCG */
 	data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
 	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
 		*flags |= AMD_CG_SUPPORT_GFX_MGCG;
 
+	/* AMD_CG_SUPPORT_REPEATER_FGCG */
+	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_REPEATER_FGCG_OVERRIDE_MASK))
+		*flags |= AMD_CG_SUPPORT_REPEATER_FGCG;
+
+	/* AMD_CG_SUPPORT_GFX_FGCG */
+	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK))
+		*flags |= AMD_CG_SUPPORT_GFX_FGCG;
+
+	/* AMD_CG_SUPPORT_GFX_PERF_CLK */
+	if (!(data & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK))
+		*flags |= AMD_CG_SUPPORT_GFX_PERF_CLK;
+
 	/* AMD_CG_SUPPORT_GFX_CGCG */
 	data = RREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL);
 	if (data & RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 9e689a1f2ea4..c618f2b8ece8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -526,7 +526,12 @@ static int soc21_common_early_init(void *handle)
 	case IP_VERSION(11, 0, 0):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_GFX_FGCG |
+			AMD_CG_SUPPORT_GFX_PERF_CLK |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 9ae4060a9d0f..bcdf7453a403 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -149,6 +149,7 @@ enum amd_powergating_state {
 #define AMD_CG_SUPPORT_JPEG_MGCG		(1ULL << 30)
 #define AMD_CG_SUPPORT_GFX_FGCG			(1ULL << 31)
 #define AMD_CG_SUPPORT_REPEATER_FGCG		(1ULL << 32)
+#define AMD_CG_SUPPORT_GFX_PERF_CLK		(1ULL << 33)
 /* PG flags */
 #define AMD_PG_SUPPORT_GFX_PG			(1 << 0)
 #define AMD_PG_SUPPORT_GFX_SMG			(1 << 1)
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e92d07f88048..6e40e9ba9ff0 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -67,7 +67,7 @@ static const struct cg_flag_name clocks[] = {
 	{AMD_CG_SUPPORT_IH_CG, "Interrupt Handler Clock Gating"},
 	{AMD_CG_SUPPORT_JPEG_MGCG, "JPEG Medium Grain Clock Gating"},
 	{AMD_CG_SUPPORT_REPEATER_FGCG, "Repeater Fine Grain Clock Gating"},
-
+	{AMD_CG_SUPPORT_GFX_PERF_CLK, "Perfmon Clock Gating"},
 	{AMD_CG_SUPPORT_ATHUB_MGCG, "Address Translation Hub Medium Grain Clock Gating"},
 	{AMD_CG_SUPPORT_ATHUB_LS, "Address Translation Hub Light Sleep"},
 	{0, NULL},
-- 
2.35.1

