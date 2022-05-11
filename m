Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DADC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 05:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B67610E654;
	Wed, 11 May 2022 05:09:50 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2081.outbound.protection.outlook.com [40.107.212.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD39810E654
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 05:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyUcAIpbzxgktL3el1rWtErNRa8H38RDuo1gXjsJbcMRdrBcWz1gMz9sQkaL307dKJhETpUQza3LyoUBt3iGxVGAF2ELniynxGViC5bilNOQ+z5LHS0jwux76YjL3DdJLkCVV6+y2gxqyRGoXJn+K+vOTMk09W0I5T0wL1KrrX9oPG71wlOOsyDL2FanLfSEhsflWVom5p33lYftcZSUss6zbscg4h4ysvogxDcLA44Zk7CcU2uLRYgoVW+IAlMGcuPybIom+qiivkKNxXtuh5XGT/ie6hEr/7G2GITHYJWDXtrXaZX92bRTCb5mmW2jnHJie44XuqhU4RU35HiVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOdA0OvTYRcGEGl5k/ZZazZIeXn4LMO2Q4S+VfMzMdw=;
 b=WDbrkKGpeZDUNpkTI0gvS9EPSD2Y720tn/fNfMDlQpjUGtshVTkTstuE7wri8Nw9sH2YNeCFymPNuuL0PbgQ2QG3gzatgrAtErCGjv2Ngq44/tCaXu0Mfe3D0dOR9JAnLnVw5h3Sa5wSJihU018ENACEhtpasWaEV2qgm8qC0b8Uxh/g1t0i9xEqA2CEbxTgce9pAgSEoQD8rXMrUqHN58oThVEFbZCyEbnOdBPDZZ131ntKZJEQx5KYqm78jJ5aoK0i8WCvk6Gt1IO2q3WZaE0W52Db4/nLu4Oao54s1eLSeHDAdyodGP4e1uaG+V2+KZXFT6iZhrfCm9R1FA8FHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOdA0OvTYRcGEGl5k/ZZazZIeXn4LMO2Q4S+VfMzMdw=;
 b=IztVA1/8gmMv8adoMAk63dCz9m/Cn7yDHE7Mf8dv7m82pfEkD252Up2rYMwbdoBMH3LjQGETCgDB/OleNX243xXm0bP4+UTI+1KkOHdZWlr40DjDSXqfFrkb43aXrls7UDd+WwFDHBu9NS88QgE40Z1zPiWh48a5Psa0t6vfDKw=
Received: from MW4PR04CA0282.namprd04.prod.outlook.com (2603:10b6:303:89::17)
 by DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.21; Wed, 11 May 2022 05:09:45 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::20) by MW4PR04CA0282.outlook.office365.com
 (2603:10b6:303:89::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Wed, 11 May 2022 05:09:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 05:09:45 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 00:09:43 -0500
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: add smu feature map support for smu_v13_0_0
Date: Wed, 11 May 2022 13:09:28 +0800
Message-ID: <20220511050928.735909-2-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511050928.735909-1-KevinYang.Wang@amd.com>
References: <20220511050928.735909-1-KevinYang.Wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f964c481-62e1-4495-193f-08da330c76dd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1308:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB13085CB6E1FA7BD3D52372F482C89@DM5PR12MB1308.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fh+O+J6lvpfFMgbMoTp+wV1/yw0lQtZdWsrqazFA7BYg6NJNpv/QJLUqCHLx1qjLalYriBeaxJaDiOdelL6QDpYi9nAm3zhd8B6xqazvcAuJnCgN/Y5DFYOj1OKNIe+W22Yk5OKY0tzxP3hi8MCu8bYwwK27eEC5PExgbjnlXJPd68mE6UO4g1/c2xhfOFWa5aBg+89Ls+beWHk+PVX/pGpFyZx3JEexq+3Zdln5y8KfCL9Hfru2KtHpIIsooFo1oRSLzY1IfbQU/X/7xcjli+JIWTcXq+5/oTJyk+XQCdz4URI1lW7L5588SSgw58ZNuhzK8X1s9dMMoaasuAgTOguACHquDd5LWVOGdTQPrKY+txeSncsdd7O0zVeaGZGaP4Z1rgbqeqBG7mWDjFnzNEEQ2VR1c6ELkynk+GWlblPTk7yXK6QVXJs15xrZsUpCjrJ/JSxXL/h1le84EWPNvqjWs549atF4FZEe6QmZHux25TMPwEpfQm0GIYCQ5LgPiECcNnA6MwrNO4yPNyNKd+V902+E/1/qzBi00BJSlPNBGvpbpnGmwuXc62vXwtt0fu4QBIADrhZxKKFZR7iJFOk5tnXd8+gmkCFKrnwTz4UkTUdrGCDfpxxC0bSh9DnwfS7l4A89DJ9spY/avQMZd33bx6y1hDJ1aDVGx1P5zzyYCDyD0e7VQKCptA3DU4jxQSrdTRvwBg/1huFuLYallg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(186003)(70206006)(70586007)(6666004)(426003)(36860700001)(36756003)(7696005)(508600001)(8676002)(4326008)(336012)(40460700003)(16526019)(6916009)(47076005)(316002)(2906002)(26005)(83380400001)(82310400005)(1076003)(86362001)(8936002)(356005)(2616005)(5660300002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 05:09:45.1297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f964c481-62e1-4495-193f-08da330c76dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1308
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
Cc: Yang Wang <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the pp_features can't display full feauture information
when these mapping is not exiting.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 69 ++++++++++++++-----
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 86f98e968341..197a0e2ff063 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -133,25 +133,56 @@ static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_feature_mask_map[SMU_FEATURE_COUNT] = {
-	[SMU_FEATURE_DPM_GFXCLK_BIT] = {1, FEATURE_DPM_GFXCLK_BIT},
-	[SMU_FEATURE_DPM_UCLK_BIT] = {1, FEATURE_DPM_UCLK_BIT},
-	[SMU_FEATURE_DPM_FCLK_BIT] = {1, FEATURE_DPM_FCLK_BIT},
-	[SMU_FEATURE_DPM_SOCCLK_BIT] = {1, FEATURE_DPM_SOCCLK_BIT},
-	[SMU_FEATURE_DPM_LINK_BIT] = {1, FEATURE_DPM_LINK_BIT},
-	[SMU_FEATURE_DPM_VCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
-	[SMU_FEATURE_DPM_DCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
-	[SMU_FEATURE_FAN_CONTROL_BIT] = {1, FEATURE_FAN_CONTROL_BIT},
-	[SMU_FEATURE_PPT_BIT] = {1, FEATURE_THROTTLERS_BIT},
-	[SMU_FEATURE_DS_GFXCLK_BIT] = {1, FEATURE_DS_GFXCLK_BIT},
-	[SMU_FEATURE_DS_SOCCLK_BIT] = {1, FEATURE_DS_SOCCLK_BIT},
-	[SMU_FEATURE_DS_UCLK_BIT] = {1, FEATURE_DS_UCLK_BIT},
-	[SMU_FEATURE_DS_FCLK_BIT] = {1, FEATURE_DS_FCLK_BIT},
-	[SMU_FEATURE_DS_LCLK_BIT] = {1, FEATURE_DS_LCLK_BIT},
-	[SMU_FEATURE_DS_VCN_BIT] = {1, FEATURE_DS_VCN_BIT},
-	[SMU_FEATURE_DS_MP0CLK_BIT] = {1, FEATURE_SOC_MPCLK_DS_BIT},
-	[SMU_FEATURE_DS_MP1CLK_BIT] = {1, FEATURE_BACO_MPCLK_DS_BIT},
-	[SMU_FEATURE_GFX_ULV_BIT] = {1, FEATURE_GFX_ULV_BIT},
-	[SMU_FEATURE_BACO_BIT] = {1, FEATURE_BACO_BIT},
+	FEA_MAP(FW_DATA_READ),
+	FEA_MAP(DPM_GFXCLK),
+	FEA_MAP(DPM_GFX_POWER_OPTIMIZER),
+	FEA_MAP(DPM_UCLK),
+	FEA_MAP(DPM_FCLK),
+	FEA_MAP(DPM_SOCCLK),
+	FEA_MAP(DPM_MP0CLK),
+	FEA_MAP(DPM_LINK),
+	FEA_MAP(DPM_DCN),
+	FEA_MAP(VMEMP_SCALING),
+	FEA_MAP(VDDIO_MEM_SCALING),
+	FEA_MAP(DS_GFXCLK),
+	FEA_MAP(DS_SOCCLK),
+	FEA_MAP(DS_FCLK),
+	FEA_MAP(DS_LCLK),
+	FEA_MAP(DS_DCFCLK),
+	FEA_MAP(DS_UCLK),
+	FEA_MAP(GFX_ULV),
+	FEA_MAP(FW_DSTATE),
+	FEA_MAP(GFXOFF),
+	FEA_MAP(BACO),
+	FEA_MAP(MM_DPM),
+	FEA_MAP(SOC_MPCLK_DS),
+	FEA_MAP(BACO_MPCLK_DS),
+	FEA_MAP(THROTTLERS),
+	FEA_MAP(SMARTSHIFT),
+	FEA_MAP(GTHR),
+	FEA_MAP(ACDC),
+	FEA_MAP(VR0HOT),
+	FEA_MAP(FW_CTF),
+	FEA_MAP(FAN_CONTROL),
+	FEA_MAP(GFX_DCS),
+	FEA_MAP(GFX_READ_MARGIN),
+	FEA_MAP(LED_DISPLAY),
+	FEA_MAP(GFXCLK_SPREAD_SPECTRUM),
+	FEA_MAP(OUT_OF_BAND_MONITOR),
+	FEA_MAP(OPTIMIZED_VMIN),
+	FEA_MAP(GFX_IMU),
+	FEA_MAP(BOOT_TIME_CAL),
+	FEA_MAP(GFX_PCC_DFLL),
+	FEA_MAP(SOC_CG),
+	FEA_MAP(DF_CSTATE),
+	FEA_MAP(GFX_EDC),
+	FEA_MAP(BOOT_POWER_OPT),
+	FEA_MAP(CLOCK_POWER_DOWN_BYPASS),
+	FEA_MAP(DS_VCN),
+	FEA_MAP(BACO_CG),
+	FEA_MAP(MEM_TEMP_READ),
+	FEA_MAP(ATHUB_MMHUB_PG),
+	FEA_MAP(SOC_PCC),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_table_map[SMU_TABLE_COUNT] = {
-- 
2.25.1

