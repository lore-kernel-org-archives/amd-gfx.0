Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA7CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 19:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A94D810E069;
	Tue, 17 May 2022 19:57:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B15C10E069
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 19:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTtOPi/gs4X3g+DG6jTfYT15gsMY0n2INmzflh7o5lWZuNumayZ0Den+IYY/WNhyes5Fq8qZ8N1TKcRawH6QciOiBYroN/v2zrKxmuVpmwWKk7vHXJY1dwK67BBHm2PMtVeV+6qz60xQA15G82IKC46/G1EJg5DCBaSd0WEyDP+XFsAIMIzALcweHbSCwsycjNECie1LBxWczeBeIQz3GyiQ3oDe84rk776yKpn+OMNqtWfLKTTvxO+5izdCpPwoVtyqBNC5r6TiHsKWZ9gJPxryEWx619tOpdMlkhA3kKZn9HKOkTR6/RnLd5L3GNOuj5lrE9rRhHBlBjy/oGu/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoSrBL/fhuRwWoQ4tsfE0vG7FwA+4GBuTOxeJ9BKofU=;
 b=DTxn+uZ99AqlobBb1Xgfk1AL7ZXqzGva9qgCCyM4rT9E3lBUbH57tQjOH775OX/SAb1hbZhemBNwz1MtcIuIQaciLpkaIV/wHSguAvkncEa4woPEW4Lupk53kAUlT50ClRT0N7S7VMV6tmqjv2aQbuxksnWga8fgcKi4eoeGZ2eU0YLjpL5/SNN7ZyiQLDdIqU72bJ3slrvsqgtC5hey9tbi2ifJPB3p+DeF/Iw2REs5EJhCqGtlH6W71FdEgwU3HMIcnajKKkmqVPwrO2VmAgCdoJv95uASxZEkH40xYp8ewg9M0Rn9pveeM99LI/mnDisGUr9x5Mfov0ZyqeYU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoSrBL/fhuRwWoQ4tsfE0vG7FwA+4GBuTOxeJ9BKofU=;
 b=ah/SvQB1VngrNgbwakDjIFeCYLpCkLlPezrxrL92a9vs4FA+JKQitYYxUCjRdf6E8IWT+195vgF+oNE7IDHqqQf4rBDlDkW5mVpiUseCm+2dC4ZJgzY/R5WxmlH5Ld/AXCCAKeaVQ+P9SXKX7kUHczsiPgL1I2GTdHIGt+vz4+Q=
Received: from DS7PR03CA0274.namprd03.prod.outlook.com (2603:10b6:5:3ad::9) by
 BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 19:57:45 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::ba) by DS7PR03CA0274.outlook.office365.com
 (2603:10b6:5:3ad::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Tue, 17 May 2022 19:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 17 May 2022 19:57:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 14:57:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct the metrics version for SMU 11.0.11/12/13
Date: Tue, 17 May 2022 15:57:25 -0400
Message-ID: <20220517195725.2895202-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 480ae0eb-c841-4e17-7612-08da383f8215
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB46759ACE288A61E7E0116ECAF7CE9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNXZA7/JpkgW6SIF67Z9L9GLICQrFCFpJW0/KvAltHbnnOsMlj31Xysqy0Ppc+F+5ju8Rx7AlcmqgVE/RQww2OtSOtiXWP4ytx2KLeGxe1FqDm/fRyp2/MFUIek8vsBaSYKxjh1ADVEzlxfBT4IgRebjnxgAZojBb7Baoz3+ljqwEs/Ss3+CsQStIjeKhLd3sGno65/5XtMW2YSUHta4q9mGzYpmiHtk5/Mhxig1bWbgiq3RHmiaaVxTk0lTCCCuLm0yTXXtOBUXKLfkV+maus6ramJnycndZce7MNDiRKt+JYSNEENShypvjsEieXaQ5VWZvJc5+u9NMm0iuKObWiGf8ipu+fugXEwmaADEGtsHYA38gOhRoT316dDrAiT5ynQ2PeMfCqGdmb1WcHerKLjtrAZajQolH6bT8qAgYTDwZ7AwbVsPHuDUt39AvnHumIudpDlfgkp1hcFTvr7aoy8egrzNh+Ri0XYjhD99snj0VLOhSxSNaKMZOIbzknnpyh2PBFeDYgUI0zGI3E6kmFIIeuTtXoKSh1syUKOTdU+XS/Qvdbh13myLEqgQYno50Gxs+bhExcSdWev2nystvjfegeJPjJaZzAD0QLPm+zs2/kmBk/4YAluKtVGWn/ZMdEF23Sm5xI/PddS3+D9nUsogT0xEhE7hvPCDvbFB+1ifDakWIs73SSvT8toZ6HmR4NIybbkAdYqy8VFDRBXi2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(4326008)(8676002)(70206006)(70586007)(36860700001)(2616005)(26005)(83380400001)(5660300002)(81166007)(2906002)(6916009)(6666004)(36756003)(47076005)(82310400005)(54906003)(316002)(7696005)(336012)(426003)(966005)(8936002)(1076003)(356005)(40460700003)(186003)(16526019)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 19:57:44.0073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 480ae0eb-c841-4e17-7612-08da383f8215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Correct the metrics version used for SMU 11.0.11/12/13.
Fixes misreported GPU metrics (e.g., fan speed, etc.) depending
on which version of SMU firwmare is loaded.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1925
Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 57 ++++++++++++++-----
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index d68be8f8850e..78f3d9e722bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -697,12 +697,28 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 	uint32_t apu_percent = 0;
 	uint32_t dgpu_percent = 0;
 
-	if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
-		(smu->smc_fw_version >= 0x3A4900))
-		use_metrics_v3 = true;
-	else if ((smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
-		(smu->smc_fw_version >= 0x3A4300))
-		use_metrics_v2 =  true;
+	switch (smu->adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(11, 0, 7):
+		if (smu->smc_fw_version >= 0x3A4900)
+			use_metrics_v3 = true;
+		else if (smu->smc_fw_version >= 0x3A4300)
+			use_metrics_v2 = true;
+		break;
+	case IP_VERSION(11, 0, 11):
+		if (smu->smc_fw_version >= 0x412D00)
+			use_metrics_v2 = true;
+		break;
+	case IP_VERSION(11, 0, 12):
+		if (smu->smc_fw_version >= 0x3B2300)
+			use_metrics_v2 = true;
+		break;
+	case IP_VERSION(11, 0, 13):
+		if (smu->smc_fw_version >= 0x491100)
+			use_metrics_v2 = true;
+		break;
+	default:
+		break;
+	}
 
 	ret = smu_cmn_get_metrics_table(smu,
 					NULL,
@@ -3833,13 +3849,28 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	uint16_t average_gfx_activity;
 	int ret = 0;
 
-	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
-		(smu->smc_fw_version >= 0x3A4900))
-		use_metrics_v3 = true;
-	else if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7)) &&
-		(smu->smc_fw_version >= 0x3A4300))
-		use_metrics_v2 = true;
-
+	switch (smu->adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(11, 0, 7):
+		if (smu->smc_fw_version >= 0x3A4900)
+			use_metrics_v3 = true;
+		else if (smu->smc_fw_version >= 0x3A4300)
+			use_metrics_v2 = true;
+		break;
+	case IP_VERSION(11, 0, 11):
+		if (smu->smc_fw_version >= 0x412D00)
+			use_metrics_v2 = true;
+		break;
+	case IP_VERSION(11, 0, 12):
+		if (smu->smc_fw_version >= 0x3B2300)
+			use_metrics_v2 = true;
+		break;
+	case IP_VERSION(11, 0, 13):
+		if (smu->smc_fw_version >= 0x491100)
+			use_metrics_v2 = true;
+		break;
+	default:
+		break;
+	}
 
 	ret = smu_cmn_get_metrics_table(smu,
 					&metrics_external,
-- 
2.35.3

