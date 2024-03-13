Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7134C54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 11:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA12110F3F1;
	Wed, 13 Mar 2024 11:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f97OdmKk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9F5310E4E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 11:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPjSjm5DT+PtmiOXZf3G9OYyrDDuTOUAcja72DfHq9AF4kMXWdxQmyFIVJSLosEVhFYwWIkEq+3UZC3f00OikBCpXC1YLR5ktImdUPYYUR6SkEKfC5k6ZxUVkWUPGmic98X+7sAxRww0CHeAKdbquDry5TYdvl5yIDMf4JGbU/KHpY2uV66eXQ5UUst2KG7LL3/u0JncA9ijCaJO9XDLziy92PnDNF5bQ+vmjGp3WpG/JWQPgB9Ujz9DF9FhD9/RbsoHUvJBcc6QMtiXmgd68d/zWYpQyTnLwH5qS7rid2tZvyhlfoFBZNdoOds2UowT8J7+wicTRF3OJ9S0nABsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzeLPfgf528ra4xpecByWMrjfMDE56vwnc67NEr62BQ=;
 b=kw2lEykKlvTjt4A6xegScAO3bV8psEl5W0vzcOU+tWiGq5UyeexCv2y6oxLEUvMw9uG2qqN0F1W2IqyXvVIgzW4KTougzHcIMUbGiVYehfUgtuMknJz9a0vjDcp3hTGjQGyPiEbQEDwqLNJJfbZOCCx2LIssNeyQQVoO4NKAv/lAhnCVWqTelgFq4l3ou8qcfs+ZJQr8bfXNvqHPz/nGTEtJuKDV2XKvt09ilb0hQCPfcV/07raJovV1EWMVeMCJGwiz0aJGAkAR+6GvxmoTeHe5grNtd4X1ggyIZqFvv7Mt/jGwV2em83jmQ0vwU0nVcqdPAqmSyrSzvXXAm7h4aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzeLPfgf528ra4xpecByWMrjfMDE56vwnc67NEr62BQ=;
 b=f97OdmKkZW7VhU2xhzsGibAf2QBwAf8v1UB1NdPuoqwPxbCGiyyBFqpcP0v9aNnQNq2tuUsp+R2uuCin6FFMrLiK8zDPYt0l2Qm/gRiZpoUU71t9oGlOBBiuPkEC4Q/SYoa3Rh3dr7zILdInVkHbCSqbh/8B0ahfHi2vaoCnQ7s=
Received: from MN2PR22CA0017.namprd22.prod.outlook.com (2603:10b6:208:238::22)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 11:03:24 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::db) by MN2PR22CA0017.outlook.office365.com
 (2603:10b6:208:238::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 13 Mar 2024 11:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 11:03:23 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 06:03:22 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH 2/9] drm/amd/pm: Update PMFW messages for SMUv13.0.6
Date: Wed, 13 Mar 2024 16:32:49 +0530
Message-ID: <20240313110256.669474-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313110256.669474-1-lijo.lazar@amd.com>
References: <20240313110256.669474-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SJ1PR12MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: f39e130c-3581-41d2-0c3c-08dc434d33b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lasv/12W3YmrJR/ayw+27llHQX1gIRsnpgp0phqZH5G0r0beXYexg13xW4AOA/gA2ZJv0hx4y80kZ8w+FTsqBkk2fVubNswYo1JxCC4iJhWwLCwykM8GQwhdFY4vOWXt2qcStHUuhLWYbfzMric7N/xnns1UGE3nkv+lPXlytkE6gZncHkW+y8F4G7rVV2cH3oVOQY9xppVa67JhlCXjZmx+pATi9IFA/F1EryvDuqE2x4ThGPAYvywhMkpNs2n4/9SicdPrieUTz2mp/jRATTkT2439Ylv92Uhbo5x+H+fVsOQYWiY0Z611T3khex3Cu6H3UUXXMoXntRTIidBkee0SYcFLVsNx3LGs8UxHaAChEDCgB3unCzXnNs+nIuQIdqq3dVZczquwkI67gsq3lZ52z7YqRuuum0nsvnVc2Ui77TK8BVLsmxZ33seX5ZB9Ww3NyNxXxLr6OJ0UQUHLn4cwxKObTzSN4Nue4rX2X6MFUoxHy+AN+E9qOtKICQLhDpaev+4MPzJ+M7a2frvrRWnZtX5+a/29BR6fhAzFU/4WC+5m7kGvIIvM8Vhi4SAS0g6PeMCAHov4qtXP8ScYP7SE9rQGJ42J0kf3vrG8u2dkLrGffM5yhZdJUyeAqh9jwHlZbp7GjspIe0KnUPk5AF66ocn52pG1DiHtL9bDGV0E5Bso9w/AP+Hp1kdkutLLvRwbVg2BJEEs3FErXqL9h1Jcli00Yi13qwmAry9C5cpwtgD+4yP8qty+O1jIZfUL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 11:03:23.8476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f39e130c-3581-41d2-0c3c-08dc434d33b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290
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

Add PMF message to select a Pstate policy in SOCs with SMU v13.0.6.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h                 | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 86758051cb93..41cb681927e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -92,7 +92,8 @@
 #define PPSMC_MSG_McaBankCeDumpDW                   0x3B
 #define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
-#define PPSMC_Message_Count                         0x44
+#define PPSMC_MSG_SelectPstatePolicy                0x44
+#define PPSMC_Message_Count                         0x45
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index a941fdbf78b6..dadbacde32ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -262,7 +262,8 @@
 	__SMU_DUMMY_MAP(SetSoftMinVpe), \
 	__SMU_DUMMY_MAP(GetMetricsVersion), \
 	__SMU_DUMMY_MAP(EnableUCLKShadow), \
-	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold),
+	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold),\
+	__SMU_DUMMY_MAP(SelectPstatePolicy),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
-- 
2.25.1

