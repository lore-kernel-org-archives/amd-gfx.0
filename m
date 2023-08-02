Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16431C001DE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 04:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A1A610E1E8;
	Wed,  2 Aug 2023 04:56:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4535E10E1E8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 04:56:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPER3eoIZVs7v0ob7F536SL8+xnEpRrU1s4OsLRaMUS5WrfJ8rBCb2YHfmiS0uOOm5mRWXvmpMc3SWkNsqxrV3xeYbs5G23do+Bg/vUEJhiN7vuzW407hkaGAUEhlGgs2dqe2gonJsCH3tQaz6l/Mj8YbYwIL+yAYttpzW2J7qzyjdpSf2FToktyFGKaPJmsJMiyQN71fSBeT5qaZC9xVJ5YvGjNAKoq3s0lSiY2/ml311VCFjMI2UEFbfNcsDTPB4IqtN32H6mDYfmXhxIDL0bnoyQYOPqaQD5HZQ16B47Wrk8T8WM7Y9/86ZDwo0VXOvjDPdjSVEmZ2SGIN2S6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qykG+a84r+qeu9QDNKdi0JvLWPSYXFCMeLcxtbnbErA=;
 b=W4BLH1J7IGuugL9hEafLvawcUkR9S5jRSIZT+MAJ42Lef3/yKplDLHG5ZgeEHlAhqXCqMZxyo+55N86WCWdJuyQNS1QGIL8jKyedU0Mo5p+dv/H9OiYOtXCrTT2/I3xypXjn2l0rWoXr681HcoK2HcB59xhd/B3Qbv+TyfdYXSskrftfm/Z9YY2SSdvNcBkXsuJ7+E6cMop9jpWRFbJxRJ2fydJ0jvxUqg1fmvetF5QqlVv6mLMGXlk5//pvaHiIVI0AJyPGEarHJYhexaFPscynvU9pkPXpF7AH+1I+sweAYQMazz2qI5zuoT5x9P48lqZJLUACeX6zaVx9ateltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qykG+a84r+qeu9QDNKdi0JvLWPSYXFCMeLcxtbnbErA=;
 b=N3zNFwT24eNFoUehf+BjVuuWmERj8bHiWZTOqIlqX9pDRZRZinPh+/Uh7NY88uxdLlbEJS+akEewHrM3HxHlf/4/l71+mjf0SMP0rtVgJhlrc5qRNMsCam00bQIF7GA7BVQIMzjOE1JylM7ctNTE5IuMrXMro5RjKbMx9QoFoQ0=
Received: from SA1P222CA0155.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::25)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 04:56:36 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::42) by SA1P222CA0155.outlook.office365.com
 (2603:10b6:806:3c3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Wed, 2 Aug 2023 04:56:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 04:56:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 23:56:33 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Fix SMU v13.0.6 energy reporting
Date: Wed, 2 Aug 2023 10:26:17 +0530
Message-ID: <20230802045617.238049-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: b0efe1ff-58b2-4adf-9f05-08db9314d980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JIx49yo/KbCNBayTXZ4hX0/v3hF4Vru/qLvBrO3wK35V1nN8OkquKrO+v6NBXpy12+9diW+udtK3SeZw7Ko2NubWlk3mLuNW1Sv8ijkjUDur+f6ZZsMSh/B9eWzXcGtruhpIYtygLP8jtnBkVst4pz2QbLTwmmB1bbB/anNJFdtjPlZGweHV5L9plhv7r4Qk005Gl8EzxS1Xi27tPSQzR23AqziGGxpZ8lXy+ZxQOJHMlkooryztg6FPZXg1hnCV/5zNg3FpfNE2OhnqImsA+hfomp0uqcsQiGtnGned4N+KZxYLyqSDLiipb48IMPOPjL6Cm2t4QEvvGXdN/2vWJn7qMGVRJUYdmy92zOFcICjsjH5iCt2B+mj319YZslh331cqdx9AusPfHFPqyWlw3ziVveZr96sUh3TucTdpeGb++QaEvqG3q5XfvpMLl/7E2QQWdeToskx9elHhslUrSg9mgf8hgy6zsWVnATtKcYISpd9DF3Rsu225dddGq/1242bKzs6ok/tJPnUbPCpRhatbKWZj6wUXitB8VCt9cZF2JIfRN2mItxLQGEfTKwzT5UZvRLsVU7zG3ZfPcWTHMcxiudH2jLKkBrzC1orW9MFYHneQPDcU0WTYLdqGJ30LD7XGZP3w2VcrKIfZnkB0F6Aot2PxPaHGfUi41EtJmDlBJ9yFoDHC99pXxjgFMpEqPQHrtstMIyZF4ThJhiFxbjRayejyeq+ZtGXLp1mWOgNQSPyjsGHDiXV5uiR90CbpD4+2YscrW9QjCWSCZAo/wHDczmmQCNqvSa9MsX7kV0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(336012)(16526019)(40460700003)(2616005)(186003)(316002)(86362001)(478600001)(81166007)(54906003)(70586007)(70206006)(6666004)(356005)(7696005)(6916009)(4326008)(82740400003)(36756003)(41300700001)(26005)(426003)(8676002)(5660300002)(8936002)(47076005)(1076003)(2906002)(36860700001)(44832011)(83380400001)(197533005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 04:56:36.0302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0efe1ff-58b2-4adf-9f05-08db9314d980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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
Cc: Alexander.Deucher@amd.com, Harish.Kasiviswanathan@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Energy counter should be reported in units of 15.259 uJ. Don't apply
any conversion.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 00eba3f950c6..90e003fbca81 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1965,9 +1965,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	gpu_metrics->average_socket_power =
 		SMUQ10_TO_UINT(metrics->SocketPower);
-	/* Energy is reported in 15.625mJ units */
-	gpu_metrics->energy_accumulator =
-		SMUQ10_TO_UINT(metrics->SocketEnergyAcc);
+	/* Energy counter reported in 15.259uJ (2^-16) units */
+	gpu_metrics->energy_accumulator = metrics->SocketEnergyAcc;
 
 	gpu_metrics->current_gfxclk =
 		SMUQ10_TO_UINT(metrics->GfxclkFrequency[xcc0]);
-- 
2.25.1

