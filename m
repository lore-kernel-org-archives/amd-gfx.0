Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DA8C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 11:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C57110E0B7;
	Wed, 28 Feb 2024 11:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qfGB+uBF";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC24110E0B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 11:39:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvFo2r6PcpbSuO5KRDyS+NUkI4Abzggfmca9/8ae2wWecbPri9vJ+aiBAxhcefDZnotQIiBQaiyou6ag3oT5Dhbq/7IukUgyL2mr6EK9j5qL+VCm/bpyHPCA7RDhuXHu+MiQMTVmlg74W51lgUz5CkBn7kUzAhZPT7HRp/Febdo1REHkwvX5msoGEVUleY100buo9dl1H/HHoRQATFLvJlfnZuXURAf5+abh2akpxMx5+EfJlbKM1QqFH92IaFty+fleMD4cXADkCVneI4zw5thhCOrzXInJoTSpttLXkcipvbjIvULkrudPM2s4nKh04Su0KYFMP1rcM5XPTlXYUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5tYYwClvAcN7DBH0QDwH1aLJFPxlSxnB2Nd8DC9o94=;
 b=YuMB4x3NNl9xSOyPsL2Cswho983S+RASIhG2bvD1vRxoAMwnzCT3+LVGG9F8gGBEy9eM4edS06qmV5+BnEMOnKiaT5YAMlxzSn3fqNiFOICv/h7zrjeVW5JSmBIf/ZD/8L+k9C+FBdYq87DZwKRHTj4lZRo3RA4joygeff9/eJVrIVKcbb/lHijGi0QGKo8sNXs93mKf0fX6OebwACCSP13uk9/Uk1DXN6F1uns2ywPxl7X5xD6r8IPv6MfzxcYlzaflR8G1oTxuWrDetCz23aIT5JMvnatImz39ZjBIbKLVGt9dHC0fcE19A0AvzMH5qlQg37HRx4yDXS68Ld8lBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5tYYwClvAcN7DBH0QDwH1aLJFPxlSxnB2Nd8DC9o94=;
 b=qfGB+uBFIdt+IlIPTdSxmE2WONGbkX7Za+pWG8nnP0XKyEvnj7DLbUwURLOlJTyjaUEQwijklrAQ9HqVmveeCcgwhJkVmJSRLAc2Rlp0brmj4/mWfnbpFTDtGLjf8KHOdRj2rzWoC6licU0WFLEO7Ne9RkxvDoKshpLm+Bgrthg=
Received: from MW2PR2101CA0019.namprd21.prod.outlook.com (2603:10b6:302:1::32)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 11:39:31 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::b) by MW2PR2101CA0019.outlook.office365.com
 (2603:10b6:302:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12 via Frontend
 Transport; Wed, 28 Feb 2024 11:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 11:39:30 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 05:39:28 -0600
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <yifan1.zhang@amd.com>, <lang.yu@amd.com>,
 "Li Ma" <li.ma@amd.com>
Subject: [PATCH] drm/amd/swsmu: modify the gfx activity scaling
Date: Wed, 28 Feb 2024 19:39:16 +0800
Message-ID: <20240228113916.235390-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: efa4af6d-4c08-477d-2a25-08dc3851ed99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9MCHuWKVxbIfBM1ZbbmnvOyquPrbAjzTwvyYb9HdeS1RXxrsHrwm7psDKgHyY4WFej69p9WwMeRbzb9VO8eSYBHi8eHEvyXhSVmJx00G+EK0d6tlJ4ybp8vf/6TOW3elradqnN34yksAgmx0HxrKlXhbpQT3IxoLFi5WFuNnAF2ZuZM9musnqTjgCq9J5Rtyr55Bd9hv2iX8Tf73Czad1tIeUMIZj1xeBM+P6tQxVMnWUWCyfILrokX99hFEaBZVkh5c9Y+8qr9juYM5R6yTwQihttqcPuZpKHIzAySYwcA6DqYxsSd5y7znRcabyg5oqJ9gK5Wdkpa4M+IIpsASQqTa/N1E4R8OLmUYwUuExN85SSKcNOrTwhfhjqLIznVROgo8QZw/w6EnasC2aO9/Q77mGtui1XyIKtxjnn+nrA04NmXftVc56z7ulcT5ryiRLqESJteBk4jZoLmgkp0g/2/rq7mboGp3bI/EUnTWfUsPnbcX0H5CHsj82hA8CpPNlbfLLKV2kgwuQWe4tISiMkRouJAnteamTr5yZJl7JnaXTcjcTKgHJWzsa7epPzR/z8zIasVrl6d66xCVTkpOM7E7d9JI03KF4wLaMlUMCb+xtku0iqUqw8SHUHxSiBdxhuy6OkP5ZhfuYzyaQLh04xPVoMMb5GSPRUg1iDKfwhgziIkXaxg4FQzGOwvMcOkfhfBxAK5fHY14ZgqWwK1zKXGAkeM0lSO4MNS/9W7BeLzlqHz9C0RbOj79FfrR3BvN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(230273577357003)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:39:30.8105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efa4af6d-4c08-477d-2a25-08dc3851ed99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add an if condition for gfx activity because the scaling has been changed after smu fw version 5d4600.
And remove a warning log.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c       | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 5 ++++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 2aa7e9945a0b..7ac9bc0df8fd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -229,8 +229,6 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_2;
 		break;
 	case IP_VERSION(14, 0, 0):
-		if ((smu->smc_fw_version < 0x5d3a00))
-			dev_warn(smu->adev->dev, "The PMFW version(%x) is behind in this BIOS!\n", smu->smc_fw_version);
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_0;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 47fdbae4adfc..9310c4758e38 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -261,7 +261,10 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->MpipuclkFrequency;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
-		*value = metrics->GfxActivity / 100;
+		if ((smu->smc_fw_version > 0x5d4600))
+			*value = metrics->GfxActivity;
+		else
+			*value = metrics->GfxActivity / 100;
 		break;
 	case METRICS_AVERAGE_VCNACTIVITY:
 		*value = metrics->VcnActivity / 100;
-- 
2.25.1

