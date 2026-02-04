Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EE8E8B39C
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 04:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B41A10E34C;
	Wed,  4 Feb 2026 04:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c/QhAPPt";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C81810E31D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 04:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiF+uEssertVxGS36XimqwnnM68A4jrYNaTWQqSL2uFaef5UEV13uZzYGYvKtBC8esyeCjRbN/qmfASUoUV2wjvJQwvhzdOnuBuuckJcoCIfCAniStizk6cTRvRPYJV0aKpjA2t55ZhMZD5aCdtVvbHKeDDXSjANQJYBOr6hwURuHodDUKBLv7ZpBXJYVJhcvC2o63uXjsce/B3g6w2+d4s0SQsiup6R3LNPkLr7O8Y+7/Um1CrZeLxT4/eVyqCqnSibN3/4aedYZk7F8bEI+QkCoC0KWeviVrF3S8CRKzecv+0y5ypjGS+OSnCNQ9M5RnLiFi2efbuwUyGbqgC4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03fu/aamFpoc8By9Y5VM5bmLtbzUQ04ctKfP0VfOVFw=;
 b=dnurdSahFkQ/3AWjx6/0tlDUYWBuKi6CzlWo6h57OPyzbXxmOWxqjfVvaUunPO4/GaKTCHm0b7YohR2+kMQbKCkH66mhykC67oa2JntGr3ABU8g6igv7Sq+Glf6u3maimz7rPaHL5ZTbVv2cINuslkz4R18loGJi5qsxp4xsPHd8NDwK7aVHgxn4BC69AkUwAOcNfZCihZWX4Ewj+sFJvn9plETqM0aLC5YrC6zYBex1DK1OWOY2Bz7IZkB6bG0LC06nisk7Z5iQwKnP6fw1fO58SmiKGX7m0M0eaq+62zCc1IsEawEfeWH38Bi+qsGfEN8JoXSUkEOafty67lSreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03fu/aamFpoc8By9Y5VM5bmLtbzUQ04ctKfP0VfOVFw=;
 b=c/QhAPPtAMqnYiM418DqMBJ4mGNT7pBChoPHhhuY890pYsrtA2o48Va1rOiCe0sRmAvQLb/8MUmladTqp5x6l6/9bMaDWDe+60gi1pUuva+mCzaqG0K6VVUlXuYJaL3kszS2HJotrLmCjRkGc0ZGBVZoSJFyi5IHUrRiKnIG46M=
Received: from BN0PR04CA0127.namprd04.prod.outlook.com (2603:10b6:408:ed::12)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 04:44:12 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::4b) by BN0PR04CA0127.outlook.office365.com
 (2603:10b6:408:ed::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 04:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 4 Feb 2026 04:44:12 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 22:44:06 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v2 08/11] drm/amd: Drop MALL
Date: Wed, 4 Feb 2026 04:43:35 +0000
Message-ID: <20260204044338.96093-8-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d6660d-1abe-495d-f2ec-08de63a80b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UYiNfnOyMEhXu00BzguvnKp6CEOZ0aUyjnu6Q8SfgcXIWZSVmVu/03dNshh5?=
 =?us-ascii?Q?oT93/aYwPxB8x6PvEiRx4zSv+mcZNDRzhgu0oEcQ1y7TIJuCrCxiuQS1L4fs?=
 =?us-ascii?Q?8aYgSomNKV+zfeTGBol4GrXPnQ7odz0x88rO5IInYBT3+h/wRofZVy3yifxd?=
 =?us-ascii?Q?nB8rtvVFUt752aRC8/G8lrHOXgRbzL3ftv9CHzIxe3TOZXuhBJF7yhOahY4W?=
 =?us-ascii?Q?YB8TlLq5ZEjc7VHOjI5RqWoCgqGEY0gCutVWGpXP2Pwk+xPsDyPYptfn0QNw?=
 =?us-ascii?Q?Z9vRtXNLrZ4T1kTFqFtC2wJ9WTwtiqrzxw1LuxTprzgNqc5Nh09D64wSJs4Y?=
 =?us-ascii?Q?aHNQ9A4/bydFWxp/BJ0DGPyMfRVl830for6W5SviIFTUwMg+lFrOeajeQmsV?=
 =?us-ascii?Q?PtzxqNJYkWZ9xPvH9pPMVTV7ewuYHSqQ5U28F1194RHo0YIdg9XZgqyEhmtk?=
 =?us-ascii?Q?SpxBZg/YBaOW6HH65c5KasbFJEOjL+ZYR+7Cmc4MDSmkOOEu6vFgYxbejswt?=
 =?us-ascii?Q?sInTrcUH3wt1x/hpsNFYgp2vuDasOfI5XmFansWPwgsY+gWrlH5hsliRmM6C?=
 =?us-ascii?Q?KvzdtFcNDjzhSILhoJJpdDtTcIWwF7MlQtgmlLl5V9/zR1aKtWyRq+6aV9fo?=
 =?us-ascii?Q?Zb28cTT/YqtENy8wIS/bvBHlJkhVUQqeaHTzoqIleQLrpAZXii/hdAwqB22b?=
 =?us-ascii?Q?aQxmkmUk5I2Fw0BsxItJpuz3B40X2zQSP5ND0sf4wCuVkmO7A87YcUVR2jTB?=
 =?us-ascii?Q?9IYksgyLtjclZzGwaYg/Qkpr74e49ij3LN/7YKI92wf66Y5xgPcc9yrHeKDe?=
 =?us-ascii?Q?QY5fHHDVs5weJRC5SeqTiZwBKSBZJOZzvVoC9aI9fj5gWSAskCbvnGiK3S/l?=
 =?us-ascii?Q?ciHN6UzKRqrjZxa0MB97kLCdTnNVqihzQraSqSUPVI7fjXJtvSZft23ymKxS?=
 =?us-ascii?Q?9UFEsOLbENw6iOpBiJn1G5aKym9fTgi2GKPW+yUqzAo26KQLaV1m2Uq4Vf4s?=
 =?us-ascii?Q?TqMd7arFfAmeQ2c2GUFCxu4a4LPjcGgCHBxUZBBPHTF80VNLCgeo0gJIxWMQ?=
 =?us-ascii?Q?BB5Ploemo6GYKgn7Db4Ogth/uOQIe5g5pUmBuksRjL6nYy4aBthN7JULAoMU?=
 =?us-ascii?Q?X0EUHS6UANKR/KO9SbcR8cTSRySq/0xPidm9N899DXscVWYDz3y3jzPeMMnd?=
 =?us-ascii?Q?QDHAt5h2+MvSZXkmb1+thj7fsKg4qYCXtl03wgOgvPQzPrHStP1VfKBdq8PV?=
 =?us-ascii?Q?SMoLGwjY2fTYukuGG8qVLYDUP8BZBtLemxNTzTQEquq1IMnncx3v/qix6HtE?=
 =?us-ascii?Q?Rhfls2KNounfvOcWlhJCR/3nmR6O6rz77oO5KbbNu3u0+Ee0sexTtMoFPCqH?=
 =?us-ascii?Q?KeAZ4t5qWPcGwRwgB47mOn9km1HodsehQ5L/Yfl2ZGBaBCRqSYQhhwNf6hah?=
 =?us-ascii?Q?BTQdgoAPesUmSER/CNFzUmbVj2kp7Gepu5FwwJZf2fyaL3OWuQ89tVhjRPhN?=
 =?us-ascii?Q?uZONIR+JIh3WcEvsORfrBGs90fSgNQnnZt1jL1OCN1/ZdBUDD9uTRgosDJbT?=
 =?us-ascii?Q?0x4F57780xhb1R3Vd0UG268+AziqFcndtLQSVamykfphgFWBFYmzzMwiiCcl?=
 =?us-ascii?Q?aFPGcjBpBN2szMyOwaAgjH5OaZqFPBbcaF1nJ3nEORRRwPIRkh3/5fV+X4v7?=
 =?us-ascii?Q?97nqWA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cH7Bf1HI4560+AB0QYfflM+rrJXSOaAswyT9nxpDsrgkkWY1Se4MdpZrz+DOcsNVaFJ65d4c+DcN5P1gmUa40h33Cuf05LDBQZfLkUpitiLnuehX1z5mRZY+A5RYGAZxWdZEqTQz84+LKOkwqi9OH9ugoaWS+GHq/LncmYliGsKJm1KLtRnt+MqguW62rHion9zBevC7gdSDkvtdrelctDLNYk6ZCk+71QdhXvq8EQCmHrOq0XkqpkE/mWbMSreN5A5aqUJH1MDG9/kmuiMHa2ZNNOs3tDODbgbi4cdepFON2eYc+AbdDagTY2jV65XwlZmP3e14ufNxTUHU7ojf0PsZGTLBHA3DdptcRZrWLe2CgcBZkPFlzKwFIxMK3k+cpaVr4fyzBglVDegMU8gRwo4K3SjE0zB9WcL+hsJcLR4n6TobrEH47yM9FtSicPWd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:44:12.6433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d6660d-1abe-495d-f2ec-08de63a80b34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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

Not supported on SMU 15_0_0

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c    | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 7331c7559454..140e5b8c0489 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -58,19 +58,6 @@
 #define mmMP1_SMN_C2PMSG_34                   0x0062
 #define mmMP1_SMN_C2PMSG_34_BASE_IDX                  1
 
-/* MALLPowerController message arguments (Defines for the Cache mode control) */
-#define SMU_MALL_PMFW_CONTROL 0
-#define SMU_MALL_DRIVER_CONTROL 1
-
-/*
- * MALLPowerState message arguments
- * (Defines for the Allocate/Release Cache mode if in driver mode)
- */
-#define SMU_MALL_EXIT_PG 0
-#define SMU_MALL_ENTER_PG 1
-
-#define SMU_MALL_PG_CONFIG_DEFAULT SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
-
 #define SMU_15_0_UMD_PSTATE_GFXCLK 700
 #define SMU_15_0_UMD_PSTATE_SOCCLK 678
 #define SMU_15_0_UMD_PSTATE_FCLK 1800
-- 
2.43.0

