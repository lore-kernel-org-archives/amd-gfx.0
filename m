Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F813E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 11:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 104D010EFE0;
	Fri, 13 Dec 2024 11:41:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YJXhmYE0";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6CB310EFE0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 11:41:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dM/A/9e+ZozCkRdYyu/N4m9WPEbo9QORlUm317cg2UijKDa1WnPWDwRM3OrLCs4VFzPPyJ/BXvNltzhHZB0mg6/fdXUXw+4ljsj5TVlkkoqYPIClUm4u4GgvBcIy+zQqfAQR1IaWgMIEjg6gHesgWWtrjbqug21oBRhiZQ/ln2YUsvEWku13Bhn5KHfdMUCzt14gz9nYROJ1Y1F5A7EM2lsJzgGFVpgBBzSdNz8Id3mZ9JZw8GoPGRMDfKtj4P2/+7BlRlBBgKtAcUoDrJVZSbebdrAmehMu6xtalEN0RrkK5Gjno7orv6Nnjr+DFO6HePhsnuirn39+JOmzhcWUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nl6PelvC3kOLMQUXzXp5PegLqEEVtRGTmLBNQew+UhA=;
 b=vgZBcBpN79ix5oaMQ0dgMO1NHbDJqNPH59TbKUTcnasZOaUlai+eB9x3bxB1W+Co2LmbOwEjXGs9hRYGTS32uPJRfLQTXXzGbajA8+2U0ls/cozoZxJBIv3N89w+3i3UXqELbAaNjinPk7YU2uIht2gJpaVdAUTETrR2wumDRTI+P7AaNRkitWVbmvShriZUmS5etTU3RTQuauR1YcSvcH7PGzCpR1tMC+7M87FTgo9Z/wBlT2RWrEAJc1Qb/cjwH2u/ylt++1TBVOslPRp73XYEQd/No2eI2RicA7D47D3C/ioMTLSi9z9FYNK2XDvJOckuMX3xc6YYzeggg9Cu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nl6PelvC3kOLMQUXzXp5PegLqEEVtRGTmLBNQew+UhA=;
 b=YJXhmYE0+8wXcxWzq7l60ea5sGS9NIU2njpPbPmYiZb0u4rw11mRaAKDc0B0tCr6VSblRkhRQ9a488wYLATL0W2xdOLE72dq+YbzKBGmv194jtbLneo9rLxenk9bcKSAMKaIdL2Q5Ip3GeaVM3nkLGWwIBVDwL3X0GaOdgD1mZk=
Received: from PH8PR05CA0006.namprd05.prod.outlook.com (2603:10b6:510:2cc::6)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 11:41:19 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::16) by PH8PR05CA0006.outlook.office365.com
 (2603:10b6:510:2cc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.9 via Frontend Transport; Fri,
 13 Dec 2024 11:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 11:41:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 05:41:18 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 13 Dec 2024 05:41:11 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, <Tim.Huang@amd.com>,
 "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: update 13_0_6 ppsmc header
Date: Fri, 13 Dec 2024 19:40:58 +0800
Message-ID: <20241213114059.3170033-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241213114059.3170033-1-jesse.zhang@amd.com>
References: <20241213114059.3170033-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: b9755991-691e-4025-9a6f-08dd1b6b0fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u7xDdvE7Bmbqr1RB4pwr4UmG/IQH05GH1TT1orVEaLJQ0q/4PEems5C0PYtU?=
 =?us-ascii?Q?FkYdQuxIX4/O1Dzo5d1oXOtZZDzTRMZbUaHSzQ/epgwoB+D75+FMhExKf63Z?=
 =?us-ascii?Q?nNI/u26+sw6/Mcml4n9ZeLjnrb52n5Jgt6MZWmSMD3PM9YA8G4sc1K6E4vfx?=
 =?us-ascii?Q?ZFsCUF3w0Cw5Ov4eoFcsly7re5qYzM3dM1qFMgj4eW4Y+OBi0qRlMyEa9mcp?=
 =?us-ascii?Q?JsGSf68huhDf9R53ufXHl6ZgXz3Xqi1qw/iiNUwotjrjGyh/MSQbYSoOaTvm?=
 =?us-ascii?Q?E1rVaA3ZUOdFTQCB6Ca+lPP91Ck76ZdN7q6rQvp49cDYbCq+Ny8KNI/4ITSR?=
 =?us-ascii?Q?lXoYRhGe+UJiHE6oESZkX6CILPMS4pmm2NVroN9S/brmFKGeJ2GKpvVFqJOg?=
 =?us-ascii?Q?uVCqPczC9y5E1yLG+iAbhWtpK0st7Pn4BZe8Ior2XMMTVwI/UTnNGPwtE0oi?=
 =?us-ascii?Q?Iuv2dcFls90Wc9dCllRVYh0q+xqUhWahqss7d977ZjgDEbRhFSGFFbZYm7HH?=
 =?us-ascii?Q?jNCq9M/0yU39T5h/bVtAQVoecNDrZWsqH8BJCHQw7fMN8nE/IykEgPgpbZbX?=
 =?us-ascii?Q?hEf7kfhrCXErGwvLeWzYpQi84pMr1fPMPo7wa0cxmHuB+NRD3/jiOqDeoOSo?=
 =?us-ascii?Q?Tl44OIFApe2ERWHrQsQt9y2ihdkYi0r7cGGXZ1c8+c0di1HpFDLaO2G6Bg5a?=
 =?us-ascii?Q?PhmOF9DBYL2O+aUfbnp8YtBAvqjHHs8h/gmPz1EKz7lODFWtse4cJedvjfsJ?=
 =?us-ascii?Q?RlbnbAcpDDrG6+Hl9nRDqBovLlNBa5ISk5ZLmauwmzvi6gg6e1mKZ/HLk76C?=
 =?us-ascii?Q?3K+1ANqkzE/+4iMjVi4IPFv9l9QLNfGTXTripFr96BCs4q0w6XKPjjgZMsKU?=
 =?us-ascii?Q?yhlRdaKl5nqdwnPA3t4EPPJfCjDwGV8V5jZEzm/CZrW233ZWsHKTDNhippVP?=
 =?us-ascii?Q?VW54+3zLqw9Ben4OX56YjNt+fMuBVLwqXUAMrm3xwN8WbTnZAtaJfFmkdGb/?=
 =?us-ascii?Q?kL8SpoQKTU0INeueaw+3cYLrkffx7Hd9eYrSIb60NzP+1Tm+qPRYXW/E4ldz?=
 =?us-ascii?Q?pl51q/ZZPloIR4LaqC3OAK10v1bqs+L4a++8entqMwKgVlyopS/8iYQ8HKax?=
 =?us-ascii?Q?GmjlzHD5fPt3v6b8PAbyP443H/u63H13d8mscm3/kKUsksNFT/f1yZCT4CqP?=
 =?us-ascii?Q?F1a9ElhtgZBNHPMORreAXHw7zo1YkqE5jSz4yCCZ6Io9lsnHhTogxer3+sng?=
 =?us-ascii?Q?ikeRGX7BnIpKp4BEMG6MN6leHzAgRwT7w8B3Tr95BZPPTj7sHCWN4sjgndSA?=
 =?us-ascii?Q?J5PCqiLl3jETSZecpR8Fx9xPcTuPruyRl2r9uRWpllvatv419jyWD23guSCV?=
 =?us-ascii?Q?zgZSmNaFJTA9xh1pURqyOt/X6XMpKrfMjR5gVrabcbsolJdRifxbPVwvMRE7?=
 =?us-ascii?Q?Qic0ZDGISwfJ+0YwxC9CnZ5sMalEEbW94gPwujfpbRn3r6Eo4fKo86YFrwi0?=
 =?us-ascii?Q?esQ+juD6EO/yCPQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 11:41:19.4223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9755991-691e-4025-9a6f-08dd1b6b0fb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

add the definition PPSMC_MSG_ResetSDMA2.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h                 | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c         | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 147bfb12fd75..7b65a27fb302 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -93,6 +93,7 @@
 #define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
 #define PPSMC_MSG_SelectPstatePolicy                0x44
+#define PPSMC_MSG_ResetSDMA2                        0x45
 #define PPSMC_MSG_ResetSDMA                         0x4D
 #define PPSMC_Message_Count                         0x4E
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index e4cd6a0d13da..b0dab9797c70 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -276,7 +276,8 @@
 	__SMU_DUMMY_MAP(SelectPstatePolicy), \
 	__SMU_DUMMY_MAP(MALLPowerController), \
 	__SMU_DUMMY_MAP(MALLPowerState), \
-	__SMU_DUMMY_MAP(ResetSDMA),
+	__SMU_DUMMY_MAP(ResetSDMA), \
+	__SMU_DUMMY_MAP(ResetSDMA2),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 5b86df0c8536..9222e7a777a6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -194,6 +194,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
 	MSG_MAP(SelectPstatePolicy,                  PPSMC_MSG_SelectPstatePolicy,              0),
 	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
+	MSG_MAP(ResetSDMA2,                          PPSMC_MSG_ResetSDMA2,                      0),
 };
 
 // clang-format on
-- 
2.25.1

