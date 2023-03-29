Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA87C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 456BA10EC29;
	Wed, 29 Mar 2023 20:11:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A4910EC28
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:11:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhlYQx2cIgBrWHdi7/VoyYQee0pCFPn6Y8JcA4eN4OlUtOEIixOlF184e/xor0uv+NrJOX0g7A2V2bBfcVNS/8ojDI7QbtZtXNsYckHpPsLp9mwPmltR20kXYCmu8ml/ozIaB62DB9Awdom9MeLnSml7fCgHkzBld6ZeFs9bBYo+2hs762Z1L5jhq65LhxUBMJcngevin129zm25WYtA++S8uKB9yeICJdHNt1HY2bZbcvz20iV1jmjDYQci4zPLGI0hGMtwCDkFe11fNvTyGFvmAu7wlMRJ5Lvfg9xIEox9Rue4mE6IJHM4yHEW+edYkDyffLyQRnP7LVtgmDvoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJRuRaRcSv27ihL9oGF5+bHtyfltkFFnTyfcnXyePGw=;
 b=c79xgqW/CH4xZGNiLbxQzb4G/ah4Uu7oBKLviHtng0tYD65GUk1cspd8riaOsaaXkt3fiHGHOLqZfSLB3Cs0JNQmNz+7hSe71RfAMIKqoT6gYhxzib9BOWbuHlSc9J7hF8DFQniiBKY4mXLo+eFEvTmia9fIXpuJCiToN4AQ2ERFYxpXt3xaCD+lAlNOfrd09cq7ksgjKWm+ILoQA2aqwf2ljreGuLH8Oq5nZP5qZXrdjz0h0IB5LSgU936eg2k7DhbOjTNB6TqGAvr0SNMHLWbKkq+57MyU1uC6WK22YmqCDUFB9pEmr/s5e0J8ycEi4oki+VXfolmQGxrNHojRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJRuRaRcSv27ihL9oGF5+bHtyfltkFFnTyfcnXyePGw=;
 b=2CLtyXlAGq3WiMhqU2i/CdtwRZa+CndKvKyWrZ6/rQ3vatMDk2p5FFqcozrSWKA/Kg7ZrWmxc4cXJ40pnmyA1kH2zs55HHRgDIxmQOsbr4nVy9NEsSHIiNNPdXlOJuv7e241qm84wpngEnlaUwtjCqFGGRMVZEirmVQ/z3HauDc=
Received: from MW4PR04CA0186.namprd04.prod.outlook.com (2603:10b6:303:86::11)
 by SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 20:11:28 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::fd) by MW4PR04CA0186.outlook.office365.com
 (2603:10b6:303:86::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Wed, 29 Mar 2023 20:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Wed, 29 Mar 2023 20:11:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:11:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/vcn: update clock gate setting for VCN 4.0.3
Date: Wed, 29 Mar 2023 16:11:08 -0400
Message-ID: <20230329201109.1982249-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201109.1982249-1-alexander.deucher@amd.com>
References: <20230329201109.1982249-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|SA1PR12MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e08b54-6c91-4dd1-9e7c-08db3091c7d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: snFwK51f46EDqBHjobVsenaLbpucB1YW1e1F4D5WfJGIRjiz2Z2ZazF4Lc9av5WMOQetDYjvnqQBWtvmwg/tNxozP0NL+Xxu2/LQgEM0+MfdquiU3aoJ+2Goa51m7/0tEif4eK6KoPmalBPyhCEUPTReLR5zbh3XgSZIWUFXgStS2Eo+xm+UZBclJ7u5zFdBX0GGeO8chp/slQP3bJTywmgNEOYr3AK9K+F7SPI2+aJuk3CMbd3TDtTEznkgfm7Sb/CTnt2wsuDCt1OaCDFHq35/U6Aq6+3XgHWId3qO23Z9GR81m2xQZsBmjv0Jo1rwfTHJuOczMu7P1cxcXnan2in4B186E66megsY9lh9kaAnE/fVG7iA9VYs2HddNsA6s4sMQlLLnZKleba0p0cmwy1Fgl5LPPnNwKd7DVo1wWL/ADpN0cvVVz9agmg/0h227fbCLko6e8yRoaKG/NZYSAVuqGiRGIHzCNa7QDnxd4vsdVOvE+x0agFhBwW3Ih8l2B2yGlUK4xDZiZ27N4qZWz1E4n3sI9izfM+BihGRhKGG3FYZ0BbFXvG8TV7CVUnSRQEldTRJYPwWJlwg66WLFi4JGrR3TiSIIYX2Nx/elxSmPsbyxp6wpebyxtu3Gqx7zcRBugMoE/ifhJu7esgohgSKZH/RGM1vBnVn0i3XjnXnCv8rkUyoCR+2nqlD25IT2Scxt8lll6PcMhBs8eOJ+oSEjJsya5VemY9pPMpYNyE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(36756003)(83380400001)(15650500001)(5660300002)(82740400003)(356005)(8936002)(40480700001)(82310400005)(336012)(81166007)(426003)(86362001)(2616005)(41300700001)(7696005)(6666004)(54906003)(1076003)(47076005)(26005)(316002)(478600001)(36860700001)(16526019)(4326008)(8676002)(70206006)(186003)(70586007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:11:28.2067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e08b54-6c91-4dd1-9e7c-08db3091c7d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101
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

Update clock gate setting.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 30 +++++++++++++------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 0b2b97593bac..a9f06f3b00eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -424,13 +424,14 @@ static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indir
 static void vcn_v4_0_3_disable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data;
+	int inst_idx = 0;
 
-	/* VCN disable CGC */
-	data = RREG32_SOC15(VCN, 0, regUVD_CGC_CTRL);
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
-		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-	else
-		data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
+		return;
+
+	/* VCN disable CGC */
+	data = RREG32_SOC15(VCN, inst_idx, regUVD_CGC_CTRL);
+	data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
 	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
 	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
 	WREG32_SOC15(VCN, 0, regUVD_CGC_CTRL, data);
@@ -517,11 +518,11 @@ static void vcn_v4_0_3_disable_clock_gating_dpg_mode(struct amdgpu_device *adev,
 {
 	uint32_t reg_data = 0;
 
-	/* enable sw clock gating control */
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
-		reg_data = 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-	else
-		reg_data = 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+		return;
+
+	/* enable sw clock gating control */
+	reg_data = 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
 	reg_data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
 	reg_data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
 	reg_data &= ~(UVD_CGC_CTRL__SYS_MODE_MASK |
@@ -563,13 +564,14 @@ static void vcn_v4_0_3_disable_clock_gating_dpg_mode(struct amdgpu_device *adev,
 static void vcn_v4_0_3_enable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data;
+	int inst_idx = 0;
 
-	/* enable VCN CGC */
-	data = RREG32_SOC15(VCN, 0, regUVD_CGC_CTRL);
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
-		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-	else
-		data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+		return;
+
+	/* enable VCN CGC */
+	data = RREG32_SOC15(VCN, inst_idx, regUVD_CGC_CTRL);
+	data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
 	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
 	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
 	WREG32_SOC15(VCN, 0, regUVD_CGC_CTRL, data);
-- 
2.39.2

