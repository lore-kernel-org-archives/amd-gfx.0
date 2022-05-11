Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A339CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 05:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CCF110E5B6;
	Wed, 11 May 2022 05:09:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DAD610E5B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 05:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjQQ6UxxQL8FKyQn+ADgXEIT6MvzxPFFkso9JpEL5A8QDXm+5lo9uRqp5p6YP8xb9RoKggdrkFjx4+KqMuE5kn35OzJaoqgOv0sPMA1gwTtGAQHYGufFYlvDAqYfkeXZTECSMDJ2DeWDbv3AykqdJlSbrBFkPojvr5K14wkBrWxB7Y746NieWVEUffMuwdkjDmEP/ceD+xEUXbAS4C56UCXkVUA1QJqWl3TSJhBKbCL52/Xh7l7zELmzOO/bTL+IunCMOWxDGbZ/bqBf16g3KiDN+VWPxLbWmotcD9Y64CTx+bItpgjw0wTuLNAiqvctU3Ezy0VDdDg4uDBvgyoukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xL2wJPPEfENhnpupJECTk9qwJlwZhb+XdxcCx2N17PU=;
 b=l+DhVIJ5Vr7rXoDodc4tpYg+YrDUFQyZfQUqERyN4zyYJyTyBxlusF5QaHVs2xLbvci6KyOiTJutGxUKA3G28EwkXeCAITr6fQoybQX0/7N47PWVKyLsQgZo/NEqBY7vGE0vohJDTP36W608pXf19ti8MUxXy00zZzyyzbpuFulLkLphQH+6D/7AFH+eqsvucKo+71NeNIqPnqx8B5IVvNRYYN7TQtpnkxI9DBqo5f+fypJaZ7iRoSpdI2HfO78y/TvBOLyGix31/ENYvnVACtedVde0xFiNEsUAtnS55zT+4XmXdt7HgFgFJkpghR9tU7BpPb4Ul7U09HrPLwaXEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xL2wJPPEfENhnpupJECTk9qwJlwZhb+XdxcCx2N17PU=;
 b=ZGpT31tyiwb4YQuz6CmCM8OeZgM0DVTuW2BHv6nHFjbrp+I0Fg9YQ7vUzx1xGMunW126YW0ZxImYRemt692xffkOo+GbWhuglc4u3IBaKXYV64D+nD2eH5Lq1ljhLPkRaZ3qC+Uz1B8naN6LvjlVgch4YRfLp1HcoVxunvRm4Bc=
Received: from MW4PR04CA0302.namprd04.prod.outlook.com (2603:10b6:303:82::7)
 by BN8PR12MB3459.namprd12.prod.outlook.com (2603:10b6:408:65::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 05:09:42 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::41) by MW4PR04CA0302.outlook.office365.com
 (2603:10b6:303:82::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Wed, 11 May 2022 05:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 05:09:41 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 00:09:40 -0500
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: add smu feature map support for smu_v13_0_7
Date: Wed, 11 May 2022 13:09:27 +0800
Message-ID: <20220511050928.735909-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33abe386-342b-4056-d55a-08da330c74fd
X-MS-TrafficTypeDiagnostic: BN8PR12MB3459:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB34591990AAE97BFF018155A382C89@BN8PR12MB3459.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tX1aQWHoriyvg84H+c+23rzqXSmjUr//4kKsRwJuLImRidMDk4VdM+qT5BNtDsMyNfyyxHJ4/Ux1M+zY5m1RfmLf9h9s337kOV3oQbs5UMCWy3CQIPqAF/oW3zDjdwMR1LWnC8Asd5StVu9AWLLs7Gr0zAhjMdHvqtogabydtMXDYqxzNwxupbinohgh6NLrY9uM2UeqgooB2vsJeneF62f+T9htqpT/XCbuZ3AoFapTXveR4eQ5iEHXf88c+CFRSY9w31adjTGa/Lkib7k4mFoWetjFHFcdJyopOcqOzaTMFLbIOj8PnFT/JoygsBnd+fPh5jcQ4fn5dAJoz5+qRhOokBinN1qy4SaqIAdzzB57OzhY3St1HoH+0k199ftProjUz+5uLOw0UAkU8y2ku71B+gNiiEE3YDBSfXuiGPxDYQ0HQnSHulBLw7GrYyPq+T3cIaksMqBsTxMdvlJyfK8RrCKb+v7gf3ZsIOhu9pIk98PppQeKnvOSdSvTY4ZIsMvB6NSOwXJrw6a6nlIqwgdQpHsXi4nUXEBgvJux88XGdfsc6ilxEFbYh/jMbEmOFc1RTZxoix4Ki5k/tBXou05iFty/HqCoUpo8ZZzukZRpDm89EoI3N1DvZsPHJHIn/1yKv+HlPcT/EX2k5AVu5FLV5Y6JZTCSP8XVGr+1MkYu6k+/A20Wt/Isyn2vmjJznplpk1/BRgCeMyrzUE08gA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(82310400005)(8936002)(81166007)(4326008)(70586007)(70206006)(8676002)(2906002)(86362001)(336012)(356005)(426003)(6666004)(47076005)(7696005)(16526019)(2616005)(36860700001)(6916009)(1076003)(83380400001)(26005)(40460700003)(316002)(186003)(508600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 05:09:41.9888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33abe386-342b-4056-d55a-08da330c74fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3459
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
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  | 23 ++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 58 ++++++++++++++++---
 2 files changed, 73 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 3f40cd6e4165..799050ea7515 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -368,6 +368,29 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(DATA_CALCULATION),				\
        __SMU_DUMMY_MAP(DPM_VCLK),			\
        __SMU_DUMMY_MAP(DPM_DCLK),			\
+       __SMU_DUMMY_MAP(FW_DATA_READ),			\
+       __SMU_DUMMY_MAP(DPM_GFX_POWER_OPTIMIZER),	\
+       __SMU_DUMMY_MAP(DPM_DCN),			\
+       __SMU_DUMMY_MAP(VMEMP_SCALING),			\
+       __SMU_DUMMY_MAP(VDDIO_MEM_SCALING),		\
+       __SMU_DUMMY_MAP(MM_DPM),				\
+       __SMU_DUMMY_MAP(SOC_MPCLK_DS),			\
+       __SMU_DUMMY_MAP(BACO_MPCLK_DS),			\
+       __SMU_DUMMY_MAP(THROTTLERS),			\
+       __SMU_DUMMY_MAP(SMARTSHIFT),			\
+       __SMU_DUMMY_MAP(GFX_READ_MARGIN),		\
+       __SMU_DUMMY_MAP(GFX_IMU),			\
+       __SMU_DUMMY_MAP(GFX_PCC_DFLL),			\
+       __SMU_DUMMY_MAP(BOOT_TIME_CAL),			\
+       __SMU_DUMMY_MAP(BOOT_POWER_OPT),			\
+       __SMU_DUMMY_MAP(GFXCLK_SPREAD_SPECTRUM),		\
+       __SMU_DUMMY_MAP(SOC_PCC),			\
+       __SMU_DUMMY_MAP(OPTIMIZED_VMIN),			\
+       __SMU_DUMMY_MAP(CLOCK_POWER_DOWN_BYPASS),	\
+       __SMU_DUMMY_MAP(MEM_TEMP_READ),			\
+       __SMU_DUMMY_MAP(ATHUB_MMHUB_PG),			\
+       __SMU_DUMMY_MAP(BACO_CG),			\
+       __SMU_DUMMY_MAP(SOC_CG),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(feature)	SMU_FEATURE_##feature##_BIT
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 00964b3728fe..7c9e0ba7ab50 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -131,14 +131,56 @@ static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_feature_mask_map[SMU_FEATURE_COUNT] = {
-	[SMU_FEATURE_DPM_GFXCLK_BIT] = {1, FEATURE_DPM_GFXCLK_BIT},
-	[SMU_FEATURE_DPM_UCLK_BIT] = {1, FEATURE_DPM_UCLK_BIT},
-	[SMU_FEATURE_DPM_FCLK_BIT] = {1, FEATURE_DPM_FCLK_BIT},
-	[SMU_FEATURE_DPM_SOCCLK_BIT] = {1, FEATURE_DPM_SOCCLK_BIT},
-	[SMU_FEATURE_DPM_LINK_BIT] = {1, FEATURE_DPM_LINK_BIT},
-	[SMU_FEATURE_DPM_VCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
-	[SMU_FEATURE_DPM_DCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
-	[SMU_FEATURE_FAN_CONTROL_BIT] = {1, FEATURE_FAN_CONTROL_BIT},
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
 
 static struct cmn2asic_mapping smu_v13_0_7_table_map[SMU_TABLE_COUNT] = {
-- 
2.25.1

