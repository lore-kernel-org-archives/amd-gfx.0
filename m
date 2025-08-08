Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FFFC87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 20:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E3B10E00A;
	Fri,  8 Aug 2025 20:29:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v87CZD/R";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B6710E00A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 20:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnWdj809bocKTcpguRHLZZ0U0rJoL/Ccwt1KVgAqlKJPVrmFbWmYPfQI92yzmzJe1BXzKBGEQuplTFcdsPL9Yk7RuJdENhpI+/qVrVXlqcA7j7SIqxH1oKV3/O2pwZcfqshDkgjUCxMdLzSIsjNOK4iHkyCpjSynu1vy7t9iQyej3Ix7crAzQsEwzOWUvUXxr4f+6XFskn2yikkd1T5qYlo5bZfSpoJlEFoUs5NnoafQGwT4zaYyhjxYLq1S9KFw5/l2O4Z7sXxsxl7iMc+J+a3Oay43rtVUKl89xCbf8UPhBjBIXb1J8LsFYmKWhnA6WFqnTb4hF7HEbdB41Xj8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl5HJOQOEFC/GVqUt7ACQHpkYyuBQvT3ocg422snP5M=;
 b=dGvfXyMF0sB0XWJs8SM7p9DKv0Gs1NyDJjmovXSyKoPTkA6hhQfb0wY4Ijzc4UTMdPknZhev6xy8V9DUBmWC9Tn3UyUl0Z+w8ZQuMSChqE0Vfv+JPkUqcxh3okt6lHEIVJ5dDFqt/PJS8vcTi1iEeC5cK+hpxSv1NyvAb5PbQBHhvt7dgciM2lw+7rRhGkWDpMefo06WRAclWhuHao3gVhcwuEyVrG0r+W1x226i/5NQ8y+7H+ABZMI/52IpIVR6kKIApI44UA0nvgeLRodAppBfVWjalWfvp7LDDF1OhiFRI1AWU9QDaUYr4lkY1OVZKFDQQ2DeeZr9fAtVAcGL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl5HJOQOEFC/GVqUt7ACQHpkYyuBQvT3ocg422snP5M=;
 b=v87CZD/Rhns/G3ZxcqROywYTwUQLbgwHjtIhUmao1nDU0cQ5jONzrX3LBLO0fJbMCTi3+IrzH/aHZ8Ua2pg5OAd1wggVhgl8fxJmYOCgRvTRTkcOFBOH+R/kAY2BZala6zo3HsgLgiqmTrF/GDDAblewGNzRAmQnXbRr03VKKiI=
Received: from CH5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:1f1::6)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 20:29:27 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::9f) by CH5PR03CA0004.outlook.office365.com
 (2603:10b6:610:1f1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.18 via Frontend Transport; Fri,
 8 Aug 2025 20:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 20:29:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 15:29:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/swm14: Update power limit logic
Date: Fri, 8 Aug 2025 16:29:12 -0400
Message-ID: <20250808202912.2067194-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 408d4c76-05fc-430a-75c7-08ddd6ba455b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g5S3F/xNuXRizkESKo3tLireCp+qjXTeCrMitHi6HDLI2mUVrDExmDI4mP7L?=
 =?us-ascii?Q?YnsYhwDoT+syt62ecwHZAgQ5u1jPKVhWhCq/keP3MeDiahQYuGPctK+KzO4H?=
 =?us-ascii?Q?ocLH7FdakK4wI0v+IZRFP7IcVc1Gn+4+jccAA0CH9aRk5zLF6y4Mc2WGTqFY?=
 =?us-ascii?Q?ryAHJg8qBGHDL9PTRW62jqfpnfdLOU5pvuoTOfiHHqczA195bYvPKCSd2ROW?=
 =?us-ascii?Q?/+wupMGhTQ9smxT0gUtTqN5gvz6T+T3yaJcOxUOCmcKesqNXzuTjvMuCaX8m?=
 =?us-ascii?Q?zP53sTL50GOxh8NQ243iRWTigr631gFEMh40o3C5ciSXuKUPLrVpvhFpgxxR?=
 =?us-ascii?Q?RFFDhHt0XrvxlImaLREQ7Av8hr07hgEXq9RrHvK4xrY67Z88OxvEfKDoIqJz?=
 =?us-ascii?Q?xe6xR24MDQzSHqSkApGWeRf1s1gZu7Jjjvr4bEdvLRSK+sVdmcKNhA77PlOJ?=
 =?us-ascii?Q?au5ID5s6jrOmmttKccK8aetglmzFR46izT60th7hTxI71BbGxhMm71u/iyBq?=
 =?us-ascii?Q?BD51eDq6pnMBgeh+dBnh4Q8eg2GhivVaI5c+B4RdRQVR50tQuTiZtq0UxJ7q?=
 =?us-ascii?Q?Fxn24/UiguG0Uvdjqyq7PlzO4nhPxbtAF2bRrZtYyWA0pTclNtV0zpPSSWyt?=
 =?us-ascii?Q?9Msh2ujYwDSPD9PrV72enfjd7oFndKKUUNDSr6CwYH9HRoNiKZ/dxkgIMeYy?=
 =?us-ascii?Q?gQusQ1TNQ3Y663y1rcxlEwLQdT+Maxn3e+zWH47EOPudJt8Yh0whRErBoM6Q?=
 =?us-ascii?Q?CvldgSDthpD4ChtqTuEeyhlDJuwx0hDP/3th5adMVsf3UiimpCPu0cKgJjTH?=
 =?us-ascii?Q?gz4zRKnTmMOH2L5XD9P/da4ia9tkTcX9H/qiM0m2B6FxK5QkZXYCcD1zAUd9?=
 =?us-ascii?Q?zBQ8TiCCG/VAEHfLA62fxYPGnyqsabfZwSNAE0ZSSmP+IEHkEPhM3a115d5e?=
 =?us-ascii?Q?ofnbUMFwE/GUks0/YNxWzeXhfHMtpk+LXhG90ucXmLYbgldX/6WoaFDGcRdn?=
 =?us-ascii?Q?bdG+MLPSwYmhmo8N6INIljbFFEq0Hbd2P2KZS/QTBcQcrsdryhZH4iL/PkmV?=
 =?us-ascii?Q?BASpKxPRaMVqqpfB2lM1e83RMk1zj0eYe7UbywYxitIAvzhxweUKk96zqrBx?=
 =?us-ascii?Q?LIxO+KTpM1WiAeaoKHJk83vbhMCzwlaj5a86ZLsOHuAyxiIr1o7behuQ1IcV?=
 =?us-ascii?Q?W5wJR3s+UH3BNpCpGzXMeuTHd3rM1KKK0Yt8Q01k2wfvPE7mRbrXDDWsB5yS?=
 =?us-ascii?Q?TXBlmMfJBig6+eTg7o9PCbzA+TV1GhNGhZN0dmlIdZbKWJUnWuhDShacY7CL?=
 =?us-ascii?Q?1NL3hfpiGjIwhgkmQkkXVDLFXP7Zm1hF1td1yF6OdNXO0f0tqubDPri7J+sB?=
 =?us-ascii?Q?j9c/nJLK/hpRTfwT+JjkBmmjv6dYRLWxW17A3WOVZ4nQqV8x4LuXAJXUxDZ3?=
 =?us-ascii?Q?njjV+lx/RwVDclSNgczfU9vRHggOvAM6J6nfEZVwUSD1K/04gZv7mA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 20:29:27.1828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 408d4c76-05fc-430a-75c7-08ddd6ba455b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792
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

Take into account the limits from the vbios.  Ported
from the SMU13 code.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4352
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 30 +++++++++++++++----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 3aea32baea3da..f32474af90b34 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1697,9 +1697,11 @@ static int smu_v14_0_2_get_power_limit(struct smu_context *smu,
 				       uint32_t *min_power_limit)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_14_0_2_powerplay_table *powerplay_table =
+		table_context->power_play_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	CustomSkuTable_t *skutable = &pptable->CustomSkuTable;
-	uint32_t power_limit;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
 	uint32_t msg_limit = pptable->SkuTable.MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
 
 	if (smu_v14_0_get_current_power_limit(smu, &power_limit))
@@ -1712,11 +1714,29 @@ static int smu_v14_0_2_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (max_power_limit)
-		*max_power_limit = msg_limit;
+	if (powerplay_table) {
+		if (smu->od_enabled &&
+		    smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_BIT)) {
+			od_percent_upper = pptable->SkuTable.OverDriveLimitsBasicMax.Ppt;
+			od_percent_lower = pptable->SkuTable.OverDriveLimitsBasicMin.Ppt;
+		} else if (smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_BIT)) {
+			od_percent_upper = 0;
+			od_percent_lower = pptable->SkuTable.OverDriveLimitsBasicMin.Ppt;
+		}
+	}
+
+	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
+					od_percent_upper, od_percent_lower, power_limit);
+
+	if (max_power_limit) {
+		*max_power_limit = msg_limit * (100 + od_percent_upper);
+		*max_power_limit /= 100;
+	}
 
-	if (min_power_limit)
-		*min_power_limit = 0;
+	if (min_power_limit) {
+		*min_power_limit = power_limit * (100 + od_percent_lower);
+		*min_power_limit /= 100;
+	}
 
 	return 0;
 }
-- 
2.50.1

