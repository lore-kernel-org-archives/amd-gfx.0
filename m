Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB9EC83F1F
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Aug 2023 02:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AABF10E082;
	Thu, 31 Aug 2023 02:42:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B618910E082
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 02:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giIBMMrQkrvK3pXzJh5o9QF/NmaAxN4Rqq1oItUqXNAA09a2PDkeSAp83gu1SH8G5QS6q6jfv/ZMo/4x83bVrNfbBZT4zAkcWFPXjyEyK/W4xJRxdyYA5Qk1HPiDU6FqEqg5681jPt7JDJZx+8aT1W+t7JcDPdFHuUMaYk6ZJ+lC2EmR5ILShzCGb1pYf0CxxxmOQqoEyAEQq8F/FKzTaS066QiR+bYkhqjHkQsismqJtURLfkNUwlOW8uhe0VBn3en2D8BhxxbaNJ4UvO3hlqTQjMO81h7zuibp7/zH3sL5pnVBh4YZZcl9Ve399q2K97nx9rHSTDucvJm5uB1XIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuN/czU9k4bXvZec8uNXBDHuOCy17ZiSxeZwGe/s8JA=;
 b=a4iA3JCWGZJUjE5VNcZUqoTUL5b1OxxXExcFqEx43kEFV3nqcV/ipssJHxLj0dmg93RcbV+adE50wsxn0/3z3JWVCcBRyXlSCQw0ryfFkQuSBzt66aVyAAx4r3CYPgY4VaSoMHbm4CSskvDB6eEcXuBKkWkdDn7pMOu4KIOyrWDLghRl/EW8qutDLI0jnp/JGl8livOeDVNjzxLApWrZd5RHUML3TDIKYu01dqa7Stau85DC0+bPAYwmTQ/0X6KmBsTK2mNVOUayWC7A8Cv5JResMFWMFMMvsGQkK9CvQ39YB4Wkl1w3vqLyTfjttAZrnfwaBglYHG1oCGHR5bC7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuN/czU9k4bXvZec8uNXBDHuOCy17ZiSxeZwGe/s8JA=;
 b=j02s+ejcJVjafLo071W/mKonqbOnSFioRjw8cEEsbHeIf6X51Ys1EcL4KEXPBgAdcKF9hgGSFxMiVNm5cDV/RoS8PnO6qcE5Pyim2dAhvLAE1gBkcwdpLzj0w470BPn8qlHfQhOpbRHAvzLhYPHA8QWabhef3Rf8FyZrxnkNtb4=
Received: from DM6PR05CA0047.namprd05.prod.outlook.com (2603:10b6:5:335::16)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Thu, 31 Aug
 2023 02:42:36 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::2) by DM6PR05CA0047.outlook.office365.com
 (2603:10b6:5:335::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 02:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 02:42:36 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 21:42:33 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amd/pm: disable the SMU13 OD feature support
 temporarily"
Date: Thu, 31 Aug 2023 10:42:21 +0800
Message-ID: <20230831024221.1011479-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 8388e089-5c67-40f6-bb00-08dba9cbef48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/FNDpi5D20TBcT3HLBNuh7bhnJugm1I/QU7+cGpG2E0TubHCw8XcYts0hzmtxFw/JfYAbQQ0fIj/y4pwBD9b4LDW35MTM4xLUriopfrcBOYN25esnMO8itsQJjUahym78EqBSJk32otWZdv/X7lSpUp6gfZzGWO/0NuWL9ZqIeG93rSQCja6XLcW1gM9cxlIWJZDpycwY2W9HJ+ddHKu1osFkpfIM+MYdNpaZ5//iPEVKOdJna/KV3Cuvc0KIzjtx/CCUJrO1JrplaVxFf9srDcqOFMkmSeiIR5TJ7+K7lgRlFfxY5vF6Kgo51+nmi9LJVDKoStHBqTUwIVcIMIfc4KJk0m2bBDUk4wY3PhbtYJY2ZDU1s683wFxhKTn/wky8twOUAoeizjtxxsiir+faeX6YsGWbO+iqkWQuxARPqLy9l6fLkGCB2rEy/JPPimnT4gdQ0mN8JOtO2Ybtsqo3XsfUd8+LbWwCL5zKvFxtPcNr2MocFpA02VsJ5nTzhVNya82UjRVK0TDQjsUzqZ/Sib9YG549kuu8dMQsZZZ7zVDf2tg7YfZoi+SgvdQCM5IYNsDqMpimnlcFE0f1947/O5nAXFta0nkwZN+G2CURK2zdCOmSNNtV83Pd3AvAFSEBc1g4xfmnwGGoq953LfKzgKevGFzHHGG2q2wrR6Mn9KG7Ff0uHyVJDPc3bPrN3M8xULlyHDApFJT0JWCYIjKkB+f7pnsV/yjQfHFaPYR4gi9WTawV4LBunizEfqsVRdAIEUaU6nL3it+tkdYrCsYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(82310400011)(451199024)(1800799009)(186009)(46966006)(40470700004)(36840700001)(40460700003)(41300700001)(316002)(4326008)(426003)(336012)(2616005)(2906002)(47076005)(86362001)(44832011)(8676002)(16526019)(5660300002)(83380400001)(36756003)(1076003)(26005)(36860700001)(6916009)(40480700001)(8936002)(6666004)(82740400003)(81166007)(356005)(7696005)(54906003)(478600001)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 02:42:36.0095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8388e089-5c67-40f6-bb00-08dba9cbef48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 3592cc20beeece83db4c50a0f400e2dd15139de9.

The enablement for the new OD mechanism completed. Also, the support for
fan control related OD feature has been added via this new mechanism.
Thus, it is time to bring back the SMU13 OD support.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 18 +++---------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 12 +++---------
 2 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index c48f81450d24..093962a37688 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -348,13 +348,10 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
 		table_context->power_play_table;
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
-#if 0
-	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	const OverDriveLimits_t * const overdrive_upperlimits =
 				&pptable->SkuTable.OverDriveLimitsBasicMax;
 	const OverDriveLimits_t * const overdrive_lowerlimits =
 				&pptable->SkuTable.OverDriveLimitsMin;
-#endif
 
 	if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_HARDWAREDC)
 		smu->dc_controlled_by_gpio = true;
@@ -366,27 +363,18 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
 	if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_MACO)
 		smu_baco->maco_support = true;
 
-	/*
-	 * We are in the transition to a new OD mechanism.
-	 * Disable the OD feature support for SMU13 temporarily.
-	 * TODO: get this reverted when new OD mechanism online
-	 */
-#if 0
 	if (!overdrive_lowerlimits->FeatureCtrlMask ||
 	    !overdrive_upperlimits->FeatureCtrlMask)
 		smu->od_enabled = false;
 
+	table_context->thermal_controller_type =
+		powerplay_table->thermal_controller_type;
+
 	/*
 	 * Instead of having its own buffer space and get overdrive_table copied,
 	 * smu->od_settings just points to the actual overdrive_table
 	 */
 	smu->od_settings = &powerplay_table->overdrive_table;
-#else
-	smu->od_enabled = false;
-#endif
-
-	table_context->thermal_controller_type =
-		powerplay_table->thermal_controller_type;
 
 	smu->adev->pm.no_fan =
 		!(pptable->SkuTable.FeaturesToRun[0] & (1 << FEATURE_FAN_CONTROL_BIT));
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 99bc449799a6..430ad1b05ba3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -338,12 +338,10 @@ static int smu_v13_0_7_check_powerplay_table(struct smu_context *smu)
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 	PPTable_t *smc_pptable = table_context->driver_pptable;
 	BoardTable_t *BoardTable = &smc_pptable->BoardTable;
-#if 0
 	const OverDriveLimits_t * const overdrive_upperlimits =
 				&smc_pptable->SkuTable.OverDriveLimitsBasicMax;
 	const OverDriveLimits_t * const overdrive_lowerlimits =
 				&smc_pptable->SkuTable.OverDriveLimitsMin;
-#endif
 
 	if (powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_HARDWAREDC)
 		smu->dc_controlled_by_gpio = true;
@@ -355,22 +353,18 @@ static int smu_v13_0_7_check_powerplay_table(struct smu_context *smu)
 	if (smu_baco->platform_support && (BoardTable->HsrEnabled || BoardTable->VddqOffEnabled))
 		smu_baco->maco_support = true;
 
-#if 0
 	if (!overdrive_lowerlimits->FeatureCtrlMask ||
 	    !overdrive_upperlimits->FeatureCtrlMask)
 		smu->od_enabled = false;
 
+	table_context->thermal_controller_type =
+		powerplay_table->thermal_controller_type;
+
 	/*
 	 * Instead of having its own buffer space and get overdrive_table copied,
 	 * smu->od_settings just points to the actual overdrive_table
 	 */
 	smu->od_settings = &powerplay_table->overdrive_table;
-#else
-	smu->od_enabled = false;
-#endif
-
-	table_context->thermal_controller_type =
-		powerplay_table->thermal_controller_type;
 
 	return 0;
 }
-- 
2.34.1

