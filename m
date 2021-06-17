Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F830C49361
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27EE9613EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EE9613EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B97F86E8C5;
	Thu, 17 Jun 2021 08:40:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C464D6E8C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 08:40:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFRjuVAqpQ+N+15jRw3R6VFJAfpGjSFPPaIVj4qRVka7Jxh8zqzq+sz5yE8BEBcK6T+nwXT0PFuo7blwJWxxz3PSbmCnveChcfIllxyaGhrXe1gCsE2Yk+zGaLgg7bx6bQIo473nBds0Nj8AU/UOY3s6gh/LVV85HvtciXBabUvlt32IDEU9Ys3Nc9MmE2blfrTPr7d2ah7yjNpoMGTxaGyRW0VpStkYbRwL6WcrpFE4IwRy3DebYmkT38/hgKvn5NKUji6+peLnK+9Ls+Y6zdjVUwQjXd2mo5a8tMpfc1KgXTCAyIAFNM5CNssNHFqD69aS373vYGee74ApBKsZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUy4JDWdHi9lGYSSPhQtpudzL5r8lwONsP6TYo6KAyo=;
 b=amIUxKboQ8YS5v1fnslLNpKdF71QAODniEudhYcbS5CPVHnQwaSvKtAsNtK8dgvHSB3sq6cZ3Q2n+xSRaE1+3mPjkcP/+RGeq3dM2qL1+9OpyqpiTKSRCqiGPgr+ZA4lz5lPK0caCyGnaOsMp8d6T+lJIxWb3tnrgDRshWj8PVvdYKVegGW7He+U/RhsWkbfYOI1pcsyrkUCvnKlzEQVls8o+cYUVHRZv5P5KCto4al74OfsXPj/gzS/zx4nLl1T7k7r3nNHgBFVBmRTeDoBi4SkwPhS8Iqg7UXuUknBf4xobkZGi3Eyhbm3OEvyhiFlvp7Vv+6OjuqhCAUoFmQ69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUy4JDWdHi9lGYSSPhQtpudzL5r8lwONsP6TYo6KAyo=;
 b=XSPcd3eMGWswyO4FZIcCCwUWK95entw2H3bd+6A07Qpi5Tdk5YKW5QFKxSE7OSRv/+2q4GWCZDLf4NQAtgMlHw4R33zRndApGgQi0MFT3/1Q12G2KSOVbyNRfqxNeHrhrKJ2FdTCqJCNgVvQWLNkaszrwy9wxClT+lM929wECYU=
Received: from BN9PR03CA0605.namprd03.prod.outlook.com (2603:10b6:408:106::10)
 by CY4PR12MB1495.namprd12.prod.outlook.com (2603:10b6:910:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 17 Jun
 2021 08:40:00 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::2a) by BN9PR03CA0605.outlook.office365.com
 (2603:10b6:408:106::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Thu, 17 Jun 2021 08:40:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 08:40:00 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 17 Jun
 2021 03:39:58 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 7/7] drm/amdgpu: update HDP LS settings
Date: Thu, 17 Jun 2021 16:39:23 +0800
Message-ID: <20210617083923.421052-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210617083923.421052-1-evan.quan@amd.com>
References: <20210617083923.421052-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f43632cb-24d9-42f8-7349-08d9316b7e8c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1495:
X-Microsoft-Antispam-PRVS: <CY4PR12MB149567A1686896C5BC36BB75E40E9@CY4PR12MB1495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cj3LTyo6Oj5XZT6662byTm+hzmSKWO8RlUGJdI4SYDi/WoYDFGslgO8Cldq0SOtX6g9dBfAVum4cmynsQ8k13w/nLqyjSF59G4P+fXDOmTiL3XeckCVvCj4teyJ8FTBhW/huPh07QaQpwgEv9ShJgaRGyljGTpH2NfkaV19uHxnbqViRPH7177RS2Noufq56c/Am+zzUqKFI7figiAdTEYaozypf6G+xVLhrKthDY2P3OR5APS+w25dIk2J1Zbwtj4bgbELj2ijFoG8xPUNJ1X9imPEvwVZ5Jo9NCwMesulZwYiDLncbGVTxeWP4tLeDgoo7Q9GubRkr/L6apTBtUPN1UAETg8gUDqz97fWgoZfkCabDUBzJhKPpotOt/3SdtO7VT13dnIBIfqHb+2yR//55BLf6FppcDbWVWm3EvHrX9fOaSapH4rPbwu40NpPdXt1VZwaE/0CJvXg3DBhoYdxfuB88Mb3/RAcaZKyxXcASGrc/hfdwtVFDf+G3kxTdc24sA4NGwyV9muL0zhurS3ekPFg+blTEFoZxVrfDkXD9R4EKMWsJtW4455gHIVPu3SfMrRqtmB6OhESUNyWeQI0Zq43QqL6jSiShblbEzG2P7K5YcFL35XveeNxIM2xEcsRNr+LSYlKTRD3oxBp3yTGwxeLUNtbopJEzMpiwZpyJAGUSjd28RGqYfZQHq7o
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(4326008)(6916009)(186003)(2906002)(8676002)(82310400003)(36756003)(2616005)(7696005)(316002)(44832011)(16526019)(82740400003)(8936002)(83380400001)(26005)(70206006)(70586007)(47076005)(478600001)(81166007)(356005)(5660300002)(36860700001)(54906003)(336012)(86362001)(1076003)(426003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 08:40:00.3601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f43632cb-24d9-42f8-7349-08d9316b7e8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1495
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
