Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B309C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 22:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C7610E0F8;
	Thu, 14 Dec 2023 22:21:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723C010E0F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 22:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ParPUidWNidwJKYsIuBjXtpfLFA2D2fFA6az6d3VOC1E23zIaoy8o/iLOMb0naDAIIsXycl9rRLDDgQWgDqvIArl84dW8LVyQwpuSzYyUzanqD5LiJ2H1rOqsibLrMH8CPdhUGeLnPehevnQrEgw1HdEQC07WDvxPQ5f6NXGDd0ndfTOUb+g7bV3KDCLolbCgzrMxbIg9mmIMrQQIteSEfNTjvIQKZBclBJt9cCdLgjmgH0CwojIGrBvYom4NC8SCnD3fl2f0k3f7KcbEvGw4tjhHzl8w6qMX5BEwXcs3laWVDwUhIoYX41hOpdjA7lLAKQw/Y50+aKBE8VNjSi25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcoiZB7DpbNpl6Ly4iVwsThkpPWs2UMRDs/OR+nMLS4=;
 b=XD/zb04qzsWIUKH5ivs8ABw4mdprxoFinxTqzv9x78Wcn57j/uwzxGWdGCizvlloyqQAbZefLoOQf6n38qWt+I06Non16wlmkGvi51gFRStWlM+Yma8ChOwvgIa57wVWqfXj1PN74xnkkhfaRyx53E9FDaXBlRvaiRMDhxciCRP9I19nYQ6tfeZwwYGzljddc+K8FlPoB0noBk1QHgxcM3LzH1E5CbCCKlyECv2xXvQjssu+uytd7xQQAkeV+PsBfwBRSOuv3Q5z/QtRwP8khtsTYtPkNOgNsWdZsJosT2EIEKpvrt63/S9KiDOUeG/2Bc/+8rLirLVbZtHRdHarvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcoiZB7DpbNpl6Ly4iVwsThkpPWs2UMRDs/OR+nMLS4=;
 b=Wcjgut8LVM3rZBw9oPwggkIALj+Od2UFoDZVEIPIsf5luqArU/IgNDIi2tJzghnpgJZAtIBK/MtNC5swgrONDOzyWxnR+WTP1e0L154/IZgoycysZ3uU3EXto4x2PQwaxIfYR9rfCdTROi5rZd+ycNMku5kdhEbbU/XE2fydZlc=
Received: from MW4PR03CA0299.namprd03.prod.outlook.com (2603:10b6:303:b5::34)
 by PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 22:21:03 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::6b) by MW4PR03CA0299.outlook.office365.com
 (2603:10b6:303:b5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Thu, 14 Dec 2023 22:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 22:21:02 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 16:21:01 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Add missing definitions for `SMU_MAX_LEVELS_VDDGFX`
Date: Thu, 14 Dec 2023 15:11:53 -0600
Message-ID: <20231214211153.45546-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|PH0PR12MB5481:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bea80ff-d672-4173-5646-08dbfcf2f51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5UX9LP8FL7RjqxhKOQEgi3u54JnYPGQrFX2iqyqXY5AQ3V7keYrxmCUIDQYSECG0FY+jNTviMnm3dB3wlhIClwB9xP3/gDVv2NcG7ux31ghTYkA/07kXvFkCJpyLjoT3B7J8w6RSa1P4huTvFhFGsOR6NsdW26sLCMRI07nvGZaNY4gbix2hLj00dQN8lGDvJH0s3rYLxLy6SQFeeFx/TzqGo399LNzoVmCqvppV7dbXS8ZA9ENQZsgH7aPHukGxVzCDfif1Pxi2oPFTX/eYYalpjKV/LuSj5cShe2LROmIjUrb1QhaMleLjv6T4sM3tD+JpC0UMPlAUY4CJJs/sSfSiMkXJ+yyCdvCCpJRkQ2QoTcK+eAGyRA+JM4NETRgUaDez/mvZ3kBAbLcZln1pvmYtFRijkzoGCwH8OpwQ23Lok9P0wq6pXWLLsGaePQWYT7fR590VgkVgQYB3qCtqAHU7EsnwBGo4Ffdi1uJGf6TBbyKYbK9VaMenlMzlL2p7Lw963ZnTuPQnqMcL8LtjNOFWIVUMdH3YJ8G4NArM8vAs9ibsp/BLGtv3fp1qXm8ng7l5Skl6xlmnck02Fbc+c4qp8mkO7R59BCjNd3nwjMCS1G9XPUAqBlVW6+c1PUPOeDC1LHDEDmZyIxxggjGn3MW0Jz/sYvz+rnuwFIwev5FsEuhVbcnoYiwqhFrHQzTdXDsUyakyLgGD8Oxjl9l82Tt6KaWZ/phRZL8bXvM1iXGDqKAMLREtKozS8qelu1kttKPfvJwTWbz8zlAcNtU0DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(70586007)(8936002)(4326008)(8676002)(316002)(6916009)(70206006)(44832011)(2906002)(478600001)(966005)(6666004)(5660300002)(1076003)(2616005)(26005)(16526019)(426003)(336012)(47076005)(36860700001)(81166007)(41300700001)(40480700001)(82740400003)(356005)(86362001)(36756003)(40460700003)(7696005)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 22:21:02.6185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bea80ff-d672-4173-5646-08dbfcf2f51e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5481
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is reported that on a Topaz dGPU the kernel emits:
	amdgpu: can't get the mac of 5

This is because there is no definition for max levels of VDDGFX
declared for SMU71 or SMU7. There is however an unused definition of
VDDNB. Use this to return the max levels for VDDGFX.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3049
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c      | 2 ++
 drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 9e4228232f02..c5bccd382196 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -2303,6 +2303,8 @@ static uint32_t ci_get_mac_definition(uint32_t value)
 		return SMU7_MAX_LEVELS_VDDCI;
 	case SMU_MAX_LEVELS_MVDD:
 		return SMU7_MAX_LEVELS_MVDD;
+	case SMU_MAX_LEVELS_VDDGFX:
+		return SMU7_MAX_LEVELS_VDDNB;
 	}
 
 	pr_debug("can't get the mac of %x\n", value);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
index 97d9802fe673..c9115eaa63c4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
@@ -2268,6 +2268,8 @@ static uint32_t iceland_get_mac_definition(uint32_t value)
 		return SMU71_MAX_LEVELS_VDDCI;
 	case SMU_MAX_LEVELS_MVDD:
 		return SMU71_MAX_LEVELS_MVDD;
+	case SMU_MAX_LEVELS_VDDGFX:
+		return SMU71_MAX_LEVELS_VDDNB;
 	}
 
 	pr_warn("can't get the mac of %x\n", value);
-- 
2.34.1

