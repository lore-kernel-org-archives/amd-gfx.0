Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6553EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 10:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A79810E18D;
	Wed,  9 Aug 2023 10:12:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D9710E18D
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 10:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkLCjLzQtudc/zmU1mI7qV2Bc85R1esnoEYyBvM0N6xmnTrmRgMzCUBOmn1mwNdJofAS/j971XIHPBYXGshwIz1IFBOn4CKc1S9E1uADPGMjRfAJw6cyNiCQvXeND2LzpRK2+tbhRK0PFWV8ytn8aoqtfDrERinQz9jS3UZuJtpxZMvFGuIJhM+E+LNVGqvFFkVn1TlDPih9nrywuFUhYA/DtekIVDThYA6wpPOlZwKA0PMR6FUkN3F+gMIM2M5l7ku4DcT5klkVy+K/vLBTJ1V3/mdnTMgCIMUWce7HZ0d97q73UdUSCaVcbk3Wm7y/VVcHmQH8u6WBiQJEVQM1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDSfq40Zr7TO78ZeOiFi9bWAxNXw6ZLRDnIyM0S8Fxw=;
 b=Mmmhr5st7GnKSIE5AZm/qoBcwKffkZ1O0JZyoT4bwXknNHCgAVHks4FOm/7plQfHZn3ufdAKjWpKh75bytv+TiOF9XrRqBLFUC2Q15SY3cvyizhWXKs3CzVgdO5YpaY1K9WWS4L7z1LqO2KDaRS8SZsfJL0ekq23Y/45AIxrmQ+CrR+rAA6ijWhTNia86r5UOe884ibR9wPRfxsru7HXNhzlYUi8EvuF30K0U+D9JvdxL0KJLHbAIz7jhqMD6Apk6+QZiEb+Y6XAmaB9EdxWGUKki9rTuv6vP+jtI9eINeNwiYb8GJ9tNd+ba8viNlbvHHfnDwAnl2N1W8B0bzyiRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDSfq40Zr7TO78ZeOiFi9bWAxNXw6ZLRDnIyM0S8Fxw=;
 b=ArImN/nMFXxD3VPLvnayz+R5N8eQ9qENIGJ5lVhenELLnGxrrFcBEgTuCQnXn2qVwRNbNQQcQE5rci09CXdC4uUaJAv7RB3jyZd9MFSjJ72xAS0737zUBoZvyjqiBEJYhGTdZQttG5Cwncfagphv8/bVe48srS0RbG16Gmxxveg=
Received: from SA9PR13CA0078.namprd13.prod.outlook.com (2603:10b6:806:23::23)
 by PH7PR12MB5618.namprd12.prod.outlook.com (2603:10b6:510:134::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 10:12:52 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::56) by SA9PR13CA0078.outlook.office365.com
 (2603:10b6:806:23::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.17 via Frontend
 Transport; Wed, 9 Aug 2023 10:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 10:12:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 05:12:51 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via
 Frontend Transport; Wed, 9 Aug 2023 05:12:50 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: disallow the fan setting if there is no fan on
 smu 13.0.0
Date: Wed, 9 Aug 2023 18:12:35 +0800
Message-ID: <20230809101235.285114-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH7PR12MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: c96d1962-8b54-4fc3-971e-08db98c130e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MEmLWhcT6y4nnxqVPT2AaUk9zGOvqVsyMfYgB0zFaZZFGZLFYVfWr1ABL5fHgA+T2e0caszXm473094aQpdHjXOAEueBASXA9b6CDbsYVqu4E+P3UWOgGedZDMUtJ7iClNz4HHm4en4zUCP9ego18iyYDotAa3WY+SBgPHML6ZOjT6Cv8CpsvMnaXle4v0AfHZpnRwV+IuQahOSJ6movugXZpgkeiO9X+dKOiYu442OUwhcmcAosZ4PZJVnEah1XlfsHAITY+SBrJlbdUlVzNwa5G5f60/4RUjY4s9dZkBFZQD9d12joJ6T1qpVPtubgKnK9Ndv5UwmQaObzIZHSp3ibP1rwap5JZz0QwFvbxfvUdzCnoWR/5zSg1nGR4J7t+w1t51o86eqNXmQucaZ4VeGwMRGhupPfcjXjHPvn6fTa3T205shglXwiabOrDvbEdkIzdOCVTIAjPqsThkDX/fwqwt/3E7SKlNSBK9R3g+q1xLZfxi6ZASOHqBKn0hcJYjs2hZcoiiq5afliM6iOyD/fJ8CuSIZcgaI3WWcrUkdXnHd6j8s1e4odJdFbG6tE5ApJfrdrXfIR2xcHS4N24wYEGdxrPVcOyeNNEjVSlMsZkXbIVgF9gbZNxQ8sdkL56ZXD+6cX0aMldCC+gi/fEATIJG4IbYlrUSVebFJP/ShpAXiaLrbwfMcSuzCTQm628iAFoCk0MUn3TQ1R9Qvhwg+mOzvEGkweC0EweXXxP7TRWtTLea94lJIgjguNyPM/ESdYvVzTaUlR59Cv71r7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(1800799006)(451199021)(82310400008)(186006)(36840700001)(40470700004)(46966006)(83380400001)(6666004)(2616005)(356005)(81166007)(426003)(1076003)(54906003)(478600001)(26005)(82740400003)(4326008)(6916009)(70586007)(47076005)(70206006)(7696005)(36860700001)(336012)(5660300002)(40460700003)(8936002)(8676002)(41300700001)(2906002)(44832011)(316002)(86362001)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 10:12:51.8567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96d1962-8b54-4fc3-971e-08db98c130e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5618
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
Cc: lijo.lazar@amd.com, Kenneth Feng <kenneth.feng@amd.com>,
 maisam.arif@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drm/amd/pm: disallow the fan setting if there is no fan on smu 13.0.0
V2: depend on pm.no_fan to check

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index fddcd834bcec..0fb6be11a0cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -331,6 +331,7 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
 	struct smu_13_0_0_powerplay_table *powerplay_table =
 		table_context->power_play_table;
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
 #if 0
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	const OverDriveLimits_t * const overdrive_upperlimits =
@@ -371,6 +372,9 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
 
+	smu->adev->pm.no_fan =
+		!(pptable->SkuTable.FeaturesToRun[0] & (1 << FEATURE_FAN_CONTROL_BIT));
+
 	return 0;
 }
 
-- 
2.34.1

