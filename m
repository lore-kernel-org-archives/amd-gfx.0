Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C34C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 08:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60EC610E272;
	Thu,  3 Nov 2022 08:50:52 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2C3710E272
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 08:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO1YVWgF0SBAtoKfaXrvBwuYpk7qPdsd9S+khhRrsUHyhlA/KVKiSXCeRyVo7Kx95w7oPMGNAZXgSHs2EQ0PzSu/Q9KllqZPJWnzpRcPUmvK47s1mdehbGqeHHabL1UMBuvzY8WncpLuNdQ8ircPE246EQ0zRkxysxmpegEs6FohQzQftmlaXSBgLEazvhSH1JLFSZaByVUna0PLqB4c0tveTBTzTrWWAMgwG3MamzV0RHV7f0cJ4h7DHR1DdoQ5IMhsUHKNh758440nn9Z+U4RLPkExQUvrecFnenpsQS8ZdN5GDhwQnqxOuLIZWXY88uWx7mNyhkfsBrfwjFeJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLc+4LJ6XJElSmpKjdRbPb7PrthOFAbPW5/dR1H6o+E=;
 b=Hh/1UA5MCksemF33p6QeWLsdDeVK0v47a9hNsOe5LSvKIvAyD8+C1eBgFerfxu1NONLNXMiD+pDMf571cQt/y+KJW6vNtsly2aiG+pvcN1IIf6zbgGrvb+LAnmi3IwcskLZhouh2JNEu1C6rJ3niWS1hl8mS7gLb0fXMDnkCEUifzXX79snVkx0s+qoi7RfdK5K2fAb1VK6ppUduyoGEXan0qVjHxotPT3W+y6GrDHP8+YykQ150Qf5bAfKLeqEKIRj0XxxVmFliAeFP9intWtdD8SxfCyUJDvUv2pucnUIKvhcb1/kHvvt42Pi1iN3oUnvYcq8pve7JX6w1fmTVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLc+4LJ6XJElSmpKjdRbPb7PrthOFAbPW5/dR1H6o+E=;
 b=VSDVx/3ElB9ugsEJzLqPEopNkIrOfJOKXgqu6s3cFScUC8/fT0nEttsCoVPtHj3+8XNBtRlBQVEAIloziFArEyyxVWJj8U/C0m4xG1QZatzDlbJnQtMe7aTuxHClgUXbhweht0awL/utZNwslQsoGhKx2tYoExZXoRIbBWHxb+o=
Received: from MW4PR04CA0055.namprd04.prod.outlook.com (2603:10b6:303:6a::30)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Thu, 3 Nov
 2022 08:50:47 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::69) by MW4PR04CA0055.outlook.office365.com
 (2603:10b6:303:6a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Thu, 3 Nov 2022 08:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 08:50:46 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 03:50:43 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: update SMU IP v13.0.4 msg interface header
Date: Thu, 3 Nov 2022 16:50:13 +0800
Message-ID: <20221103085013.527767-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 664bcf3d-3aaa-48f6-4b4c-08dabd787fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8CemDWY4RG5Ukf0XV/UwnMSirysVWVvTJBkyUMvHbWvdhW2A/77Lk/VpH7TCsvZqA1JiTR4cYbdmCyTPHnPNW6+8x85DJd9gwBYZYVT7zsPYHo1K6TqOR3ys9imWBlKRT0rg6r7d6F+4Y4p0Wi98rrFJxuKqw1z0GARUrA2g2Yjq3Ca6pCyDh+qXGMLVDx0p3MmK43DwnNReSamZkr5T7hoxVyHJubiFsE9EEROU1M4p4dfvuDhjVfLPPs6M/lz40/kWFGh8LcvZmsd7MeAbxMv3vNYzdCte+vEAeqpFcgHhRcQFhknE6ItVkCbqx7Dc+Y+h9p6SACJvv2oomCAkFz3+vm+/AjJQlLmxh+boZ3d40MKRh0e29n2m75isQJ1RKy4TpXMNVOuwNP+WttC19S9eI5oJKmItlUBVSW9n7HUmTcTd93lsN1XLU3NzYPKBtWf1oEqBYBHWAN7OlRVT9gxJ+tuXZagvON5k3hQ7LUs+RsKT2UujBBL5uuCoUKYi1UutKHpUaQJjsF1s8Aa6Jy0YMsGSL814JkFTgtK2BpI5ExzYdpLZLJBQkS2CukInr2Ch5RSCNhcv3dgB8zPi9Bxu8ZcVx0WJOkgPkR2O6D8OceVPyL1OixTtpsV+gFMB2flYdMuq9iwWD5seoRYi3VEA3sz044NLrNIqXcRs/m4sDME2VErjbZF0el1tDuHLlWWkkfotReHVngnigtFhcihj5BR9qRPrl6jnxcg6KJNHO4PYVL574pdVoJ5tGYYhKtwZFgCp9e1sPx9BA64ElBT3rjDpf5b7KhmIyHax4U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(1076003)(15650500001)(336012)(83380400001)(47076005)(8936002)(26005)(16526019)(2616005)(426003)(2906002)(41300700001)(186003)(44832011)(36756003)(40460700003)(86362001)(40480700001)(5660300002)(356005)(36860700001)(81166007)(82740400003)(82310400005)(478600001)(54906003)(316002)(6916009)(6666004)(19627235002)(7696005)(70206006)(4326008)(70586007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 08:50:46.3022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 664bcf3d-3aaa-48f6-4b4c-08dabd787fd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some of the unused messages that were used earlier in development have
been freed up as spare messages, no intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h  | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h
index d9b0cd752200..f4d6c07b56ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h
@@ -54,14 +54,14 @@
 #define PPSMC_MSG_TestMessage                   0x01 ///< To check if PMFW is alive and responding. Requirement specified by PMFW team
 #define PPSMC_MSG_GetPmfwVersion                0x02 ///< Get PMFW version
 #define PPSMC_MSG_GetDriverIfVersion            0x03 ///< Get PMFW_DRIVER_IF version
-#define PPSMC_MSG_EnableGfxOff                  0x04 ///< Enable GFXOFF
-#define PPSMC_MSG_DisableGfxOff                 0x05 ///< Disable GFXOFF
+#define PPSMC_MSG_SPARE0                        0x04 ///< SPARE
+#define PPSMC_MSG_SPARE1                        0x05 ///< SPARE
 #define PPSMC_MSG_PowerDownVcn                  0x06 ///< Power down VCN
 #define PPSMC_MSG_PowerUpVcn                    0x07 ///< Power up VCN; VCN is power gated by default
 #define PPSMC_MSG_SetHardMinVcn                 0x08 ///< For wireless display
 #define PPSMC_MSG_SetSoftMinGfxclk              0x09 ///< Set SoftMin for GFXCLK, argument is frequency in MHz
-#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Needs update
-#define PPSMC_MSG_ForcePowerDownGfx             0x0B ///< Force power down GFX, i.e. enter GFXOFF
+#define PPSMC_MSG_SPARE2                        0x0A ///< SPARE
+#define PPSMC_MSG_SPARE3                        0x0B ///< SPARE
 #define PPSMC_MSG_PrepareMp1ForUnload           0x0C ///< Prepare PMFW for GFX driver unload
 #define PPSMC_MSG_SetDriverDramAddrHigh         0x0D ///< Set high 32 bits of DRAM address for Driver table transfer
 #define PPSMC_MSG_SetDriverDramAddrLow          0x0E ///< Set low 32 bits of DRAM address for Driver table transfer
@@ -73,8 +73,7 @@
 #define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min for FCLK
 #define PPSMC_MSG_SetSoftMinVcn                 0x15 ///< Set soft min for VCN clocks (VCLK and DCLK)
 
-
-#define PPSMC_MSG_EnableGfxImu                  0x16 ///< Needs update
+#define PPSMC_MSG_EnableGfxImu                  0x16 ///< Enable GFX IMU
 
 #define PPSMC_MSG_GetGfxclkFrequency            0x17 ///< Get GFX clock frequency
 #define PPSMC_MSG_GetFclkFrequency              0x18 ///< Get FCLK frequency
@@ -102,8 +101,8 @@
 #define PPSMC_MSG_SetHardMinIspxclkByFreq       0x2C ///< Set HardMin by frequency for ISPXCLK
 #define PPSMC_MSG_PowerDownUmsch                0x2D ///< Power down VCN.UMSCH (aka VSCH) scheduler
 #define PPSMC_MSG_PowerUpUmsch                  0x2E ///< Power up VCN.UMSCH (aka VSCH) scheduler
-#define PPSMC_Message_IspStutterOn_MmhubPgDis   0x2F ///< ISP StutterOn mmHub PgDis
-#define PPSMC_Message_IspStutterOff_MmhubPgEn   0x30 ///< ISP StufferOff mmHub PgEn
+#define PPSMC_MSG_IspStutterOn_MmhubPgDis       0x2F ///< ISP StutterOn mmHub PgDis
+#define PPSMC_MSG_IspStutterOff_MmhubPgEn       0x30 ///< ISP StufferOff mmHub PgEn
 
 #define PPSMC_Message_Count                     0x31 ///< Total number of PPSMC messages
 /** @}*/
-- 
2.25.1

