Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E601DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 20:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A5010E119;
	Thu, 28 Apr 2022 20:20:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59FD110E119
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 20:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIxPDYCLfbe9qlO2dLZ7R6gDTPkheDJr4POLcsz2POuSFOv+ByWz31kj8gxuDeVTMd6ZOBCzD21x318Nmm6yYHvvWAopd9HhdSazpQZN2qtnd1fcy2KiZpdQDdqacUftL0XQWRjG7NEtTnJvfbL53D855l66udzxAJl0jejTgMD3RYkqR0OI21vqIy2Bc/0z2dYFKbcsIpy3wuRlqulwJg4NZy8foACfWMnexOpysoHytR18DaEVLP/0fRuxF4Pt0QC01HLlbUUYI/2xXcV3E7Wy+2/iMe1r79yIZ4YZ0wC3vGllrf0eoP0uQYSwZbgvzr8TW2N+yGJvY2lVvJjmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WqAVpCDodqIA/Ovi/d5d5uyZjBcBA2AFi5VRmrSoiY=;
 b=dl/Su5fbgpOn8cyTWLBfnEPclp30e/YxnhI/xwA9h1Vqfytvyrwbq/KNoJIqoL2sZSPJBiN0YlS0Jm1A8ax7068i3EKDvoGs5A52Xco5nzQ8EX9d1CXetl+gGPWgTCXDklRLOheij6eyEmyxZvsCcGRSLts7EF8SWCn7QtQc5ZDlUpUoroBWKbfIiNjGQRe5TLgEZQhDRDgR/e5wgQ4Y3R3Gi6fTGxR9EbKlwB3Ft8VmYBrYr4jYUtiKE3DlHR2JN6bDjQg1PbUMewWhJHoBQiYVz/JxSwxPq8Rw2rdHtLuwkqrqGuApWSRKKGy1yk1hhy0VRNgqpDM9hUY/ngrDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WqAVpCDodqIA/Ovi/d5d5uyZjBcBA2AFi5VRmrSoiY=;
 b=zT3iiVdak3pUjqggMTxIT4h7aGl0Uno/sD2j1x13A2Xb2sXVKQ5dXBSpiMt3LDdqVE7he9VFZOatP0j9EzMtq5qjqRXetWpnpd6HtHRc5LvhDCWIY8a91EmW6loahb9LRBbhOO7GwLyS93gnoiiC/i+Wu0lChErigq980WXU56k=
Received: from BN9PR03CA0458.namprd03.prod.outlook.com (2603:10b6:408:139::13)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 20:20:44 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::a6) by BN9PR03CA0458.outlook.office365.com
 (2603:10b6:408:139::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 28 Apr 2022 20:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 20:20:43 +0000
Received: from elenaKubuntuDevTest.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 15:20:42 -0500
From: Elena Sakhnovitch <elena.sakhnovitch@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd/pm: Disable fan control if not supported
Date: Thu, 28 Apr 2022 16:20:19 -0400
Message-ID: <20220428202019.1494874-1-elena.sakhnovitch@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1796cc3f-de8a-474b-7f15-08da29549281
X-MS-TrafficTypeDiagnostic: BY5PR12MB4307:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB430753C535C023EF5F8551A0E0FD9@BY5PR12MB4307.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kibUFK8q/iVrlTlhTIds+8DxiawSsSqP5C7qlXUIWC0jyhJS88FPBf6Kkzcr/Jf/8xQ1d4dELx214kdzyichTL1RVMLZ6mGsv8C4NbA3OPIz/AQkKRx6lp5WHJRgyHSfVQZz7fCbTPIviEyuReReRvYGFNIn8RFago6Ath4vRj7PtrtA8y2wZSGc1UGhr6VaHR8yxZtYOX3hOfM4O5TVVVA5jjHV73cMvT+HV7LlO2ovbXbLN4+BpcNCIkz9NJGJ69/vHAhN2xXJqm6QiocaavAmWvfddmZ1cQcEIxhZ/v3TyNwHAdbEBAKIW2nGgQi5YcG6bjH9oFudzmrCDzpk71tKwPtGujCXrvbanaQC9sejM+xGEcPs43SOt2+4ep9Gi3afLLetYWwRRkVD04vT2my+QdTKd6U35g7KxlkWko2yi3z9sVA7tixdeEYobhnR2tyOg9L9SMtk5IjJZ7deuPuP50HllAG9sSBzrrpjdK59bkRbH1Gx78lSSMJCbYuFt07r6sFEtyy6kqL+iWSs59g6PwMZz0I3SgDVbOvOwNV1wHesw1Nw0w9f+caRIFDtnd5WJsu7FfcTjU+YMUYfUwV2mW0U/23aQiiRGMTcgHd8CcSv3jhYvqEdCYMC5u0F3czj43LeZYRz1z395MHnXZlSYUYA01gjuI6y+Z67GbJ9geCe8uAqhqg8H5mGC66H9CN96sd+7WsfgwJmoUO3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(16526019)(47076005)(81166007)(336012)(426003)(316002)(186003)(5660300002)(1076003)(8936002)(7696005)(6666004)(36860700001)(44832011)(86362001)(70586007)(70206006)(2616005)(6916009)(4326008)(8676002)(83380400001)(356005)(82310400005)(26005)(508600001)(40460700003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 20:20:43.7673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1796cc3f-de8a-474b-7f15-08da29549281
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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

On Sienna Cichild, not all platforms use PMFW based fan control
(ex: fanless systems). On such ASICs fan control by PMFW will be
disabled in PPTable. Disable hwmon knobs for fan control also as
it is not possible to report or control fan speed on such platforms
through driver.

v3: FeaturesToRun casted as uint64_t

Signed-off-by: Elena Sakhnovitch  <elena.sakhnovitch@amd.com>
---
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index ab3e9d8b831e..9ec44b4e9f83 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -371,6 +371,22 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
 	}
 }
 
+static void sienna_cichlid_check_fan_support(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	uint64_t features = *(uint64_t *) pptable->FeaturesToRun;
+
+	/* Fan control is not possible if PPTable has it disabled */
+	smu->adev->pm.no_fan =
+		!(features & (1ULL << FEATURE_FAN_CONTROL_BIT));
+	if (smu->adev->pm.no_fan)
+		dev_info_once(smu->adev->dev,
+			      "PMFW based fan control disabled");
+
+
+}
+
 static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -381,6 +397,7 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 		smu->dc_controlled_by_gpio = true;
 
 	sienna_cichlid_check_bxco_support(smu);
+	sienna_cichlid_check_fan_support(smu);
 
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
-- 
2.25.1

