Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02354C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 15:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D4F10E199;
	Thu, 17 Mar 2022 15:32:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D6A10E199
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 15:32:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fP368ravp+04vebPJBNT5GVoHi4atNpr5+kTsweV9C4SAEoQqa8gEYwkqfjLg4AeyUVj//gsv1jATitINPz2kbNi52h6gLASz8pLEVEV9QfGPhjCXGye/GQI1vpqsf8AYAzKDG2r4sa5q3spAHMC2nAkqdr/+jE1/Nr3FWBnked1f1ouLOQFDDx3t5sIouzFvpoI3I/dhSS13ifNvp26PZvx3wHojCfEttKaGhEwQ8EP5Xs39TL6CIHqyfvH3EhFGCxZXfB292ic/eHtHLT8fQx0l9Qx0wFzc1Q1ortL4J0rTPfXD4gXbJwwn1x7ZO8rGb4tFvp3GW7c8mFdugn7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAHt78RflsnYxogEef2K3zrT+ZkevsY5Jj70qIrC+HY=;
 b=ahiuPMU3SJr2bzqk2IJ8lBZ2dxa84Ap3tJPWmqRd2FO98JUqNd3KcVrH93aCMEw0UXtj+7MNCPagOsCP6Zw5aGozfYCFQ3ghaIvNOTBuJ/dWSJWK1ZnthA5E+ebYHixRHVAf2h5tSOVFHnroLucxCqaC96TzC4oMsLo5kZMsxl9ejDTEYwNxWX7Lt6jxbQRorwqcApnr8mzYaNiUC4ZZjyOBDB65BOPkdMueqq1y4QOPrFgQXvcbI8g9EaBHOZqfb7SG3bKQDGEGSjIKR5JWtXkxEsin1Qr3xFgHZJC4pxz/kMwbXfXhkiaKrD5vUeHBWjUBqB3gtbQKCmHoNn+hKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAHt78RflsnYxogEef2K3zrT+ZkevsY5Jj70qIrC+HY=;
 b=kRZD+3U+tVqqU3geEyaWt8+fnAAMLj3RA6Lvmiv9WVCzRSKXOl7YjR5vvEL++/2yRBhVh6QNBJxxXMgvTg+oH/+ORvoFuEsj4KSQrAjYOS5eSynhJFlTBP6F+4hqqftUixQexXpiD/SzRvUW8g27zpXQYll4SoH/g/E8j4Z1d8Y=
Received: from MW4PR04CA0213.namprd04.prod.outlook.com (2603:10b6:303:87::8)
 by BL0PR12MB5540.namprd12.prod.outlook.com (2603:10b6:208:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 15:32:27 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::4d) by MW4PR04CA0213.outlook.office365.com
 (2603:10b6:303:87::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14 via Frontend
 Transport; Thu, 17 Mar 2022 15:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 15:32:26 +0000
Received: from elenaKubuntuDevTest.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 10:32:25 -0500
From: Elena Sakhnovitch <elena.sakhnovitch@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: Disable fan control if not supported
Date: Thu, 17 Mar 2022 11:32:10 -0400
Message-ID: <20220317153210.1358401-1-elena.sakhnovitch@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbb5a716-dab1-44b8-1a62-08da082b574a
X-MS-TrafficTypeDiagnostic: BL0PR12MB5540:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55404E423B587B04423E9B6CE0129@BL0PR12MB5540.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AoWwAeq2YGIfuZt9of9f0uKR0rG+DQhZc9jBvhGlPWyKpkDTYPNVHHyPKuIPC6pXSt/TDepIgTtqrhzr2rNpNDjj+hd1U+S6Vrj5lovhXy02KZ6rEig+6CeHimCTzzB5LXi1vEOc1g/G4SoYDUzv3k6b0pqCm8kNlSSIpFF89VclZxwdFo522FryVjx+FAygK+Na4fjhNcyenatg3IUtg1eizAWpwVrn7oom2bjGW6+bfEu9TFaeakfvrn4n1jMPNX5K0UW5MsE+YuMYQzLCp4cd7v/vjpWDySjEgUlmKcfHXCXKFac7L20xp3ZU3QMoRd61SribnAaVoWSZbmabpy3RyvXWEdahINl7HJUDkdhIi6RHF4Hq6s6/SeWltCMssK8x8AD836wQf5S+EMdhbWjn8dfuuOFOY4IwortYtpsf8/8htoO6SEmtupJXeU1f/oEpXsmH+gw9Ql/Kxn2s5HSIgzqXzRqTOxge9RpSseNJk4J9OSC1XpI4AM758ZA7QkMmDUXtuQLmmwaxujc7LkoHZqnbQ1kIl50907bn9ZPPhemAGMwY6lE4k8mQo5fkz1dDBB67IoKV+8jtxY4tx3yb7zECmSAWanVZa/DrivguCZqQXjgR35CROMGfe/OuqqR/LgVItreFa2dP2QUIuKZI7fugKa/IX7v2CPQlcfHJf3Q06Dk753PtKiMkshsyYQn16yqEZKQ3jYZ8+92SmVvgbF61J/poPjUmfk1Hj5LRCNnGdeKqNrH+hx/DVffW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(44832011)(36860700001)(356005)(426003)(336012)(2616005)(186003)(81166007)(1076003)(86362001)(8936002)(6916009)(47076005)(83380400001)(36756003)(5660300002)(16526019)(26005)(40460700003)(70206006)(82310400004)(6666004)(7696005)(2906002)(508600001)(316002)(4326008)(70586007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 15:32:26.5718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb5a716-dab1-44b8-1a62-08da082b574a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5540
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
Cc: elena.sakhnovitch@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sienna Cichild, not all platforms use PMFW based fan control. On such
ASICs fan control by PMFW will be disabled in PPTable. Disable hwmon
knobs for fan control also as it is not possible to report or control
fan speed on such platforms through driver.
v2: FEATURE_FAN_CONTROL_MASK is replaced with FEATURE_FAN_CONTROL_BIT

Signed-off-by: Elena Sakhnovitch  <elena.sakhnovitch@amd.com>
---
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 38f04836c82f..23abb1d1f677 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -371,6 +371,18 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
 	}
 }
 
+static void sienna_cichlid_check_fan_support(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	/* No sort of fan control possible if PPTable has it disabled */
+	smu->adev->pm.no_fan =
+		!(pptable->FeaturesToRun[0] & FEATURE_FAN_CONTROL_MASK);
+	if (smu->adev->pm.no_fan)
+		dev_info_once(smu->adev->dev,
+			      "PMFW based fan control disabled");
+}
+
 static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -381,6 +393,7 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 		smu->dc_controlled_by_gpio = true;
 
 	sienna_cichlid_check_bxco_support(smu);
+	sienna_cichlid_check_fan_support(smu);
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
@@ -410,7 +423,7 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 	GET_PPTABLE_MEMBER(I2cControllers, &table_member);
 	memcpy(table_member, smc_dpm_table->I2cControllers,
 			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
-	
+
 	return 0;
 }
 
-- 
2.25.1

