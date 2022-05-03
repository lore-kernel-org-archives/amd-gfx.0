Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C61CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B7B10EA21;
	Tue,  3 May 2022 20:09:22 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F2410EA2F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDK3rSv+n9N6A2OMXH9cWJNFGizz+8qajCmtkO0n2OLoedjw2P+8HJ476Pq0L75tVI2PC9W1LOE0TyRbCIDNm86uN+yQrdWJOi+DBtz8bmGOYqWgf4sNAQsKe8h6S2l54LCRi/qgSqn+/9/LCAz3q18//ec+gF/dXj4o5eMDPG/vT92+sbzznNzpwSkSMEffFHTDFJl0mVX3R3xeISlArSRh8qzsMYIyui6AvkYuhRPAkUCjpcrgFtt6rJuDjtVw8o7GJ1qgxTNsQqzZ3CPFA6wh4ZT4dTAT0NSNFnGYV7xV1+mObApXp/hCs8rCyGsuX417+rVXNfM3TFT7gb/UNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5NdwyM/HtsCG4e2wTs8kDJ8H9X8x8fQt9nl/jTQqP4=;
 b=GVx8Z+D8pxPLA9SL66ZGaJ6ePZdJ7hLgWGKtNhqaXyeT9dVEiGLq17ckE4lDqY56iLbGnJiWv1VZn3ftvKwls19zGCI2RN1cdGcL+20U6/fxxe4trOLCyZqRlJrP1WUGY05YPNpUSQgp6bKTxhh4nR8sVJ+XF7mAkDiDYclaGuApnVf49A0Es1o8o5EBRg0PvBzT/VX6cYvPLmt7pFXSTPWyrDbY77rI9410nsFQg0Us5cnzBlticCxLaRSwvA+aM/tv38SadduzMCpDn7MMq5OfprJb0na6X7ZdVe2OQL3rzdDBTNc9midSInu61t1cyxit+eh24/6mAWEz3P2cug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5NdwyM/HtsCG4e2wTs8kDJ8H9X8x8fQt9nl/jTQqP4=;
 b=RM4qmimiJo9VgllzjUaqTFysL3WEnU7dqB89rH/KGHJp31kqHfleJwk1hkb99OyLD0h2KlBvacWm7ZHyHbvf6l4oH/QTgXL6qUi4/Ul8gqN+vWFmZLxOK015Ir65R6s3UT/3so6BWmZt+tN4tGmuKRB842+lWI52Rae7EJhwEhM=
Received: from DM6PR07CA0050.namprd07.prod.outlook.com (2603:10b6:5:74::27) by
 DM5PR1201MB0122.namprd12.prod.outlook.com (2603:10b6:4:57::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Tue, 3 May 2022 20:09:19 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::10) by DM6PR07CA0050.outlook.office365.com
 (2603:10b6:5:74::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.25 via Frontend
 Transport; Tue, 3 May 2022 20:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable clock gating for HDP 6.0
Date: Tue, 3 May 2022 16:08:46 -0400
Message-ID: <20220503200855.1163186-16-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f62c4a7f-055c-4808-8808-08da2d40ce66
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0122:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0122E4E5345D24EE821BF713F7C09@DM5PR1201MB0122.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrvGDizeILEXcHMT6aCFBjYtbGwfc8Mjcy6f26A9neWmgtRCi4QpgbkFAdBFvyg/CoMXXJcDDNXy7mB/vGea3tIR3zhZzj8m/H8q7CvbUOUHzFbGx7wQGK6AZIj6v1hfnfVIaIxe60r69aE/ZVEEgGR+uJxEmT3XXSvv4zls9JO0MabiHNMPGkrvSdxddEnvH+TgihmGB7eAEmFfvTTgeHB8KkeZeqNThta7uTSHI+aLo9jhh7Ogm1fuHWP8lOQob6S9j2lQSmBfaUvXdjarnGaPxh9nreDL6MkHZpNPwEizy4hCEYchzqem84u47/1j6ixhKRUzOyLJkZCLc0IsfIxcH/8IPbBma/lDj6uVrPAjEzmylpUQePWlGWgVDxsnG0wKckdlMLIsbvm8foguZSHX80VXbgduMbnoyKDwLTC18bFrTlxcskTITzmM8qYEograT6fXQKTNI/vk1hsO8gMFncdd7z+3LVoNqVIzLS9JQbvjPekMOdqdS9cjSyU9dkKU+/JCZjGCWoaTLvtGHcnBnkE4YTkBMs3YkealCNtgbphZMXXkPygeEU4RoxULj+OtwXsJtWUWOavNQ5/eXJJqg0S+sNLQjy1eBPsOz88Iu9+K0QLpLaW/5ecnWd1aXveBbu4Caz1WC96q0zP0mqtw9X5bs+ZUL7pJf+QaV7SRqvUJNSm1tzwZzTNz1MpwndoxHj/RxR9ab628XXN4eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(508600001)(40460700003)(186003)(36860700001)(1076003)(70586007)(70206006)(8676002)(6666004)(356005)(16526019)(26005)(7696005)(4326008)(81166007)(47076005)(426003)(336012)(54906003)(316002)(6916009)(83380400001)(2906002)(86362001)(5660300002)(8936002)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:18.9235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f62c4a7f-055c-4808-8808-08da2d40ce66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0122
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Enable HDP 6.0 clock gating.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c | 100 ++++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/soc21.c    |   3 +-
 2 files changed, 73 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
index 1dab8f3fcbad..063eba619f2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -38,33 +38,85 @@ static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
 }
 
 static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
-						      bool enable)
+					 bool enable)
 {
-	uint32_t hdp_clk_cntl;
+	uint32_t hdp_clk_cntl, hdp_clk_cntl1;
+	uint32_t hdp_mem_pwr_cntl;
 
-	if (!(adev->cg_flags & AMD_CG_SUPPORT_HDP_MGCG))
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS |
+				AMD_CG_SUPPORT_HDP_DS |
+				AMD_CG_SUPPORT_HDP_SD)))
 		return;
 
-	hdp_clk_cntl = RREG32_SOC15(HDP, 0, regHDP_CLK_CNTL);
+	hdp_clk_cntl = hdp_clk_cntl1 = RREG32_SOC15(HDP, 0,regHDP_CLK_CNTL);
+	hdp_mem_pwr_cntl = RREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL);
 
+	/* Before doing clock/power mode switch,
+	 * forced on IPH & RC clock */
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     RC_MEM_CLK_SOFT_OVERRIDE, 1);
+	WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
+
+	/* disable clock and power gating before any changing */
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_CTRL_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_LS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_DS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_SD_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_CTRL_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_LS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_DS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_SD_EN, 0);
+	WREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
+
+	/* Already disabled above. The actions below are for "enabled" only */
 	if (enable) {
-		hdp_clk_cntl &=
-			~(uint32_t)
-			(HDP_CLK_CNTL__ATOMIC_MEM_CLK_SOFT_OVERRIDE_MASK |
-			 HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
-			 HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
-			 HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
-			 HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
-			 HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK);
-	} else {
-		hdp_clk_cntl |= HDP_CLK_CNTL__ATOMIC_MEM_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK;
+		/* only one clock gating mode (LS/DS/SD) can be enabled */
+		if (adev->cg_flags & AMD_CG_SUPPORT_HDP_SD) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_SD_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_SD_EN, 1);
+		} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_LS_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_LS_EN, 1);
+		} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_DS) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_DS_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_DS_EN, 1);
+		}
+
+		/* confirmed that IPH_MEM_POWER_CTRL_EN and RC_MEM_POWER_CTRL_EN have to
+		 * be set for SRAM LS/DS/SD */
+		if (adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS | AMD_CG_SUPPORT_HDP_DS |
+				      AMD_CG_SUPPORT_HDP_SD)) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_CTRL_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_CTRL_EN, 1);
+			WREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
+		}
 	}
 
+	/* disable IPH & RC clock override after clock/power mode changing */
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     RC_MEM_CLK_SOFT_OVERRIDE, 0);
 	WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
 }
 
@@ -73,16 +125,6 @@ static void hdp_v6_0_get_clockgating_state(struct amdgpu_device *adev,
 {
 	uint32_t tmp;
 
-	/* AMD_CG_SUPPORT_HDP_MGCG */
-	tmp = RREG32_SOC15(HDP, 0, regHDP_CLK_CNTL);
-	if (!(tmp & (HDP_CLK_CNTL__ATOMIC_MEM_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK)))
-		*flags |= AMD_CG_SUPPORT_HDP_MGCG;
-
 	/* AMD_CG_SUPPORT_HDP_LS/DS/SD */
 	tmp = RREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL);
 	if (tmp & HDP_MEM_POWER_CTRL__ATOMIC_MEM_POWER_LS_EN_MASK)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 24ba5e36378f..7804f95b790b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -538,7 +538,8 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_ATHUB_LS |
 			AMD_CG_SUPPORT_MC_MGCG |
 			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_IH_CG;
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_HDP_SD;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
-- 
2.35.1

