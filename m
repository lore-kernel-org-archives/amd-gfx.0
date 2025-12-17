Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F22D65C49
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B8210ECE7;
	Wed, 17 Dec 2025 13:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aaEwybCA";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2295910ECEF
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seQleLA640AjE0tFPSMb11SbSQ5ShbRZP9Sdq15dwMu+QfZ93BcorIN9cb4cZRz3qmVufD32B1fqyaNhRYdhoKp2Stu+VjHZG3HSOxBexGs7apbp9paAcEQ80ZbQ5oHrQSMgF8ylN7hO9yRr/LI+KE75mtk2V3MOY6fNUJjcCMtz0PILRw5DYttLDvWJtyoWnddpyGcfj1IDCT3PDL37dvAd+XtjbaaIorKJzJoukXogkvB2dVAZxMDpzytF50v9S855Cg7O5b/zoagSLsCfXBNugs/7BJooV+VegB42p8BEBr8ad166+yyNPgVpHnyAzmdHKMTpUNmKmITG414h5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0/PFgioOhD5pJjXZXOuh65QwglPokJpfZToHLOyT0U=;
 b=AZ2Oe2d4U0ynXKNvt7EknIqYwndvEuGlnvf37Ew79DNdaK6UtnwEOzqhjrJUN02g4Yj+T4cg5cDZSnm9dh2ZDb6S+GccPqAMdlCziUbqAPkSTlRh77Dn4jcZWbjcRfeHrVAPYCv2CI4itkz1ZUCUMyecjHfnfp22TJFJyvf/9tba8ea3GuV99CntX2l4wwW7LhPC0UHM1a20E/cTl/E2PGNVF067qg6YwH3mpRjDU8qZ7CrMC1PiL6FQje7PBFnj10aW8l5JTfGv7nbQOAnb1fcC+ae34I37iqpqhw5LSwDUcA1Expkq2yYNVZpi68NHXyAlUjr6t/7Spfn9jxhq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0/PFgioOhD5pJjXZXOuh65QwglPokJpfZToHLOyT0U=;
 b=aaEwybCAho31jqeJDjwfWgx/pHAgBFZy2IPJjE6P2raOVz/YKrKo7ZcOKSiRnYxxXjXfI7e1RR+/GnfJLOAPG+d4QwRQF3RBs5JDovRLPCv5de9Y+Fud5dkhiCMwRNptTADGJ630YhENbJWzzqO9nkvBMn6NsxmBJFqQ03rQ7Ko=
Received: from PH7PR17CA0011.namprd17.prod.outlook.com (2603:10b6:510:324::20)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:55:24 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::29) by PH7PR17CA0011.outlook.office365.com
 (2603:10b6:510:324::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:55:23 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:21 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 16/21] drm/amd/pm: Drop unused ppt callback from SMUv12
Date: Wed, 17 Dec 2025 19:18:09 +0530
Message-ID: <20251217135431.2943441-17-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251217135431.2943441-1-lijo.lazar@amd.com>
References: <20251217135431.2943441-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8e1346-72d1-4302-fc67-08de3d73ec96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZlmWJw8vJjrqcbPcUjBPivcoVb5WQo7yOh4qAmF+EFHkKuhquS3GpQpTSW8P?=
 =?us-ascii?Q?Sen78PkpeOG+yk5NUKre9kZAVnyDxNicz1ztNTR5p2WE2OWjkETQyVYDtVCX?=
 =?us-ascii?Q?756HLhhNGJVoDhcLPZZES+WCzTGoMzMQg8Aag9fhWb8+AkgSH4TftoxiVn7H?=
 =?us-ascii?Q?LdCnbEFWsNkeegJhSpr2cYA7wXbpYW+ogWCHbeb3pyIp9UDSrbsdGaBKZHkb?=
 =?us-ascii?Q?u8HIJCpbtQ5AvA1E4U0lWRKQrOAiTTiyAh+ETsNeFi534IU4+iMy6rcCzJt2?=
 =?us-ascii?Q?mpLHejCpYx6z8CgYpMZLcOANRdZ3fj+9ISVHYwbmohRYIEtZopLvHyi3sQu6?=
 =?us-ascii?Q?9CzLLx+mMXEnBcDmRcW5QlmeaPGvV9c2/Kr5uawIcHsWzxC0HpfNZ10kpxnp?=
 =?us-ascii?Q?w8f3gMGOZg61xIdVXG1jsSuEfGP0TU7RuGv8g+lv5XuVcIHxI9//hpa1UnFR?=
 =?us-ascii?Q?58NZZX8QONVWthRjyTj9oxTssGrTPT+JuyyWVoZjhQRSzuBXmsYheQrJNXTn?=
 =?us-ascii?Q?Tae0A+bJPmyLYYMwsOb7M1M4e81AxQhZZTFigCRT4JIWC1i8j8Xy+oZ7pIbz?=
 =?us-ascii?Q?7HQ61voUVbmAr0T2hqd+Ad3gq5ehz8qW7oJC14iy5iK1ufUEAjZGR0pTV7gV?=
 =?us-ascii?Q?UbVUZh9V6fsr3zcoC94+tlse4wxZ/6LPziyFFmG3VqWjRkawAXb9bCdMONaU?=
 =?us-ascii?Q?CcrTnyJfdX16oMD2my6FyHQ928Id32qgsFpHFlIKevU8Fk8zuWhLYuOm9S72?=
 =?us-ascii?Q?fISqG2v/YYe2U5WRDVAJA/bgwu0gpqd2mzN8wKz1UsJn3Bcc/2kEEThMHiA6?=
 =?us-ascii?Q?8qzxm58YTUt4ose8DN1crM45R1KdhK0rgMw0DUDFMEdXRVqBuCImGW283ZAh?=
 =?us-ascii?Q?OhRTEHBBGaQeS3Z8iyyJlo/N3GlkAgT37TJVDsELTzWomm9H/JoizKHEmmXv?=
 =?us-ascii?Q?GfqjSC7hvXE+DnNt+fDySQLyGUbFzcsjkDluWn5ROfntolYEyPYd0/H+PGNX?=
 =?us-ascii?Q?Ark0FG4eaiZi+HK2bQmzUu6YBdfVTrRxExz8pMfOa56Jw0pshWGKv4QodBcV?=
 =?us-ascii?Q?laEs6nlLkz3F82E6zEgyOnTGlOvQJuHXtuNUtPw+E1VASBUYnkNrVjbB/EEI?=
 =?us-ascii?Q?a2tbf857CQvFTWpgGlMl+q4AFKNn/6tHTmJA/AVjy79tuKqTfFu11vCNEmoU?=
 =?us-ascii?Q?/qPCCXt6gH6mTbxau2x/5/wmvdGnMtJqPSR7wpaIWhbaxHC5ByifLqAvYH1T?=
 =?us-ascii?Q?N3pb2pcdNXvD6jxEr9d3UdvBNOE5RIH/SunBh3qyi0h2l2zE/pnZtCad5ETg?=
 =?us-ascii?Q?QpbkpTfHyCJakQ4cKuMWVhiuCeYH5a2E3wiv2kuD8t4XB8wP92We6QGkIJik?=
 =?us-ascii?Q?qgp/Hq4YvWoP9Iy7DS+Z6oj1YPkXWW/TFbspYwNVqg8iXpsGbTzFz+IFCcVo?=
 =?us-ascii?Q?cHw3vuDoARxaTtwO8ddBkJGm/tg6OW/XAzeRThEf0qHCf9qGoVSBvIHMweR1?=
 =?us-ascii?Q?kwsQwYN0tHR6dQtGzok5yGoqI1aA2D2T0Kkreg2Bgh1gAjB4lfZhG7E+H54y?=
 =?us-ascii?Q?A5AFkALCrOI6SWKStIQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:23.2640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8e1346-72d1-4302-fc67-08de3d73ec96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
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

SMU message related ppt callbacks are not used. Drop from SMUv12.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index a81360abc2f0..5346b60b09b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1459,8 +1459,6 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.check_fw_status = smu_v12_0_check_fw_status,
 	.check_fw_version = smu_v12_0_check_fw_version,
 	.powergate_sdma = smu_v12_0_powergate_sdma,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.set_gfx_cgpg = smu_v12_0_set_gfx_cgpg,
 	.gfx_off_control = smu_v12_0_gfx_off_control,
 	.get_gfx_off_status = smu_v12_0_get_gfxoff_status,
-- 
2.49.0

