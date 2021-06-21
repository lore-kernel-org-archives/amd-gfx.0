Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB18C48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375716109E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375716109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE75989CB8;
	Mon, 21 Jun 2021 07:01:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5428289CB8
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 07:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX6nTibYVdUUSOMhXEyM0QwJ5iekfhJyw1XeEXp/NBV+pq9RIIUIoGICwK7aMIfHZUBfF3mISCgtkgdhBDVgi9ONQdMdkprfbqqwnfIe9aF8S5BUt+wLgu2keZISkurjOopHz4gT03kzcsS5nAaC606a+iDx6qQanwvc1UccGlys3s4inFBcB7oxdnKqYOlm5FMI1vI4Y8vbKAllSfNNpwwadcyUnfe2OEvWITNh0nrrvNxYPUgc9hsCjrn8ikEJoLG9KVXBDJPke0m0yR2w2rczJdg60bfyrEuJkI4mT9lmRdJvrYEoM6hOpRAV2+5TSSWsVDvfQDvk6FwAJ7oRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUy4JDWdHi9lGYSSPhQtpudzL5r8lwONsP6TYo6KAyo=;
 b=UHdS0AQEyTW1Ydx31PKqf2yXmb3Kd4+LkUEVrTcvMZKfamO77IK9TwpEw1S6WR/AtJZ2meM3q5BrHRlUNlQdj2uA5Q+9xsUiBn2JD5WhBe4eOzFiNV0m2+us6qBPrqnN2eLdgkpabhUjuwae9WBKsd4iGYMIhrPzxrUn6/mSlmkgIdewLOpXzaVXm3vKmVg0/wjj0lp3t5ib4o5f7SHlNE9IHWlcZ+xYaY1rkqySd7xG50WA1HmUe6/hqXMeENjmG16YAhPnklfk4lCUapduB7OjMAGeunWo80ozAFej9GyM63dwsVqO917y95tJHnToE8utQSRCqmyHOGNYoGxkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUy4JDWdHi9lGYSSPhQtpudzL5r8lwONsP6TYo6KAyo=;
 b=Z6GZFxvuBO+/WIASYXcy5MRiWB/VALSyIE06T6FWd5NGLHyuiszavAUbffEox8w8ufYmU9Wt7vX7doa0agiFAdLVpLm8FpTPaD2PDe82BJYTd56nHt08kIHiEhtU+TsqvXRUqO/lh4z7dXY0DLxmslf6TIUYhxlI70V24vxz5PA=
Received: from DM6PR17CA0004.namprd17.prod.outlook.com (2603:10b6:5:1b3::17)
 by CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 07:01:19 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3::4) by DM6PR17CA0004.outlook.office365.com
 (2603:10b6:5:1b3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Mon, 21 Jun 2021 07:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 07:01:19 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 21 Jun
 2021 02:01:17 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 7/7] drm/amdgpu: update HDP LS settings
Date: Mon, 21 Jun 2021 15:00:40 +0800
Message-ID: <20210621070040.494336-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210621070040.494336-1-evan.quan@amd.com>
References: <20210621070040.494336-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da618ff1-5ae0-41ca-e0fa-08d934825ef6
X-MS-TrafficTypeDiagnostic: CY4PR12MB1287:
X-Microsoft-Antispam-PRVS: <CY4PR12MB128717AE79B463460E6067D2E40A9@CY4PR12MB1287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nALZpfBlhlgC7EZFuAFekV07fuToAgJNYH33pUAZzcngbMa/E1VVIS6uZpK4etJuMcYxb2csrcky+zUHR8lLeLH4gTMH5yGWaxDlhMqg51zOnAA65BPPKqju5O/SpLgSY8Zt2yThkcsUXprggnTMo5WsHwx9X41i1IWzHd7XXXfSu3H9uTBR47GJ75qjJxK1mI2I7osMlPxmnDe9hcRzo2VYR58fYhMYzIJ7D22y/K2Rnoh7ad7F6MccFw5blF34qmjyUW1OtD24JCq1qCang3zTfaKSOTc6E/HNtSUxOdFoqw0nyEIrCVcNm0auUB6wnXWoSs1qtS4Op4R9XKJSzh9zaqj8W+Ob2oelFCsLc9p8agfO5Lc9gtBUUL7NNwi0g8INFqCUxMM1t9vfSUJwf0Zd6809eegjMQjBZLRVDkKOfAfNE43EH2Xf1FalAYmOjAw/oYD7ByY/pRucFciSJSPNx4nmjEdZI1wFBlGRIyXqfryGzRVlh56n4bgM8iYWiauiXcv0iRLx5M6qUu4cHJ7uxmklPrtvEmHIFepnrP2eNscFuV/u89VBdGuiloI8oGUxKHfHBgzWgXIwSU97cjbQkPykB//zBZYZAIQckMrhiAxsNrF7BrSgU+A+6pzCNVWhGGfwWTGveqj1t+jxruf05bMJat07MK0teXOJ+ZslJquCLVOFVBdw37E2dO8T
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(46966006)(8936002)(82740400003)(82310400003)(6916009)(478600001)(2906002)(83380400001)(81166007)(4326008)(356005)(44832011)(6666004)(7696005)(70206006)(8676002)(36860700001)(336012)(86362001)(2616005)(26005)(186003)(16526019)(1076003)(316002)(36756003)(54906003)(426003)(47076005)(70586007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 07:01:19.2157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da618ff1-5ae0-41ca-e0fa-08d934825ef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1287
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Avoid unnecessary register programming on feature disablement.

Change-Id: Ia8ad4fb28cb23f80ddcf1399eace284e4d33bd90
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c | 85 +++++++++++++++------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
index 7a15e669b68d..5793977953cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -90,45 +90,56 @@ static void hdp_v5_0_update_mem_power_gating(struct amdgpu_device *adev,
 					 RC_MEM_POWER_SD_EN, 0);
 	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
 
-	/* only one clock gating mode (LS/DS/SD) can be enabled */
-	if (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_LS_EN, enable);
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_LS_EN, enable);
-	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_DS) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_DS_EN, enable);
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_DS_EN, enable);
-	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_SD) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_SD_EN, enable);
-		/* RC should not use shut down mode, fallback to ds */
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_DS_EN, enable);
-	}
-
-	/* confirmed that IPH_MEM_POWER_CTRL_EN and RC_MEM_POWER_CTRL_EN have to
-	 * be set for SRAM LS/DS/SD */
-	if (adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS | AMD_CG_SUPPORT_HDP_DS |
-			      AMD_CG_SUPPORT_HDP_SD)) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_CTRL_EN, 1);
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_CTRL_EN, 1);
+	/* Already disabled above. The actions below are for "enabled" only */
+	if (enable) {
+		/* only one clock gating mode (LS/DS/SD) can be enabled */
+		if (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 IPH_MEM_POWER_LS_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_LS_EN, 1);
+		} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_DS) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 IPH_MEM_POWER_DS_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_DS_EN, 1);
+		} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_SD) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 IPH_MEM_POWER_SD_EN, 1);
+			/* RC should not use shut down mode, fallback to ds  or ls if allowed */
+			if (adev->cg_flags & AMD_CG_SUPPORT_HDP_DS)
+				hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+								 HDP_MEM_POWER_CTRL,
+								 RC_MEM_POWER_DS_EN, 1);
+			else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS)
+				hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+								 HDP_MEM_POWER_CTRL,
+								 RC_MEM_POWER_LS_EN, 1);
+		}
+
+		/* confirmed that IPH_MEM_POWER_CTRL_EN and RC_MEM_POWER_CTRL_EN have to
+		 * be set for SRAM LS/DS/SD */
+		if (adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS | AMD_CG_SUPPORT_HDP_DS |
+				      AMD_CG_SUPPORT_HDP_SD)) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+							 IPH_MEM_POWER_CTRL_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_CTRL_EN, 1);
+			WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
+		}
 	}
 
-	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
-
-	/* restore IPH & RC clock override after clock/power mode changing */
-	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl1);
+	/* disable IPH & RC clock override after clock/power mode changing */
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     IPH_MEM_CLK_SOFT_OVERRIDE, 0);
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     RC_MEM_CLK_SOFT_OVERRIDE, 0);
+	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl);
 }
 
 static void hdp_v5_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
