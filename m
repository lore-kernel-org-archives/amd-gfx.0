Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854A7EE2084
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 11:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB8F10E740;
	Fri,  6 Feb 2026 11:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MvFpF5n5";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA35810E1B5
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 11:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2Hl8lVwNSFYr+gLqEKrQeG9ul5Jm+PCq7IZiRr3otgi28hUZAaVpz36LTqchBAG0B48rxqPFGja5ifKqNn8m8eqJfNTINgRZlhFMedx7qyU6XBW/KHRQWdYilQ8Pi6FEoHbMN25OvSY8OanrycAmhuT6WGDZ8n/pkkA5Ai5Fz/rppmZdyIa+PiQZebZe7cJcvjygbcCwpID9WY72nJqsVHG95Ue7XHZ4FC6pEOblV9eknc81coBlypwjo8uHKqlq2UmWeY3/XaTMS7YUU7fepXHyj9O+trvv1lwitA88ug59WsBIk6hiwT7E9ZJ0vdYJnScqEVXabllYtzdZHbXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfCT6UsB61CdOKZsyXBQ5lCvmtrVn2uUn3qyAqcaNyc=;
 b=Q2MmBczKQs6LeOm/4SgnzF5SxgkVkOuq415tuS6JsbPwFu10J44LrO3AuEa8Tk84TH4WpdJMTxbLsCB0yO/Og2yinD+uknzqkK2LpjgT0tswb4wGQXFJqCLdF+B6eV1I1OZLdaxSxTRe6/uDLW9DUvxX1ScfvTfWnHqfykLLwp/A/yvm117EcuWnoL1M6UunuxDRcnW7aF1AwiifrafOSVqh9Nx8Y7s60aH3x9sknqG2RTY54XW05C038j3qoQpFTeZTy0+G0DjT+oBdDxFxFPbJGxqfdDiMrNQix3y7MpPSz6oF7gh2+lJa7H9QdxV48jk/9lmlnggLOpIYEB9j5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfCT6UsB61CdOKZsyXBQ5lCvmtrVn2uUn3qyAqcaNyc=;
 b=MvFpF5n5toDhWD4R0Jv9xOAN9hOtV6uov/SoJ+dYm0xHabDwJO/eovXfbdWYvfmlev2P4XxCQQARtLmewZqaKvBVghCwaRXqQL9HzpbanevRpmvjLsnO02nFvMEW7ANuRf4L6fY9nPhNiyi52s9EyGNzopU1C+KAF7jfBfJzHeg=
Received: from MN2PR22CA0026.namprd22.prod.outlook.com (2603:10b6:208:238::31)
 by CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 11:25:18 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::9b) by MN2PR22CA0026.outlook.office365.com
 (2603:10b6:208:238::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 11:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 11:25:18 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 05:25:16 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 07/11] drm/amdgpu: Drop unsupported function
Date: Fri, 6 Feb 2026 11:24:45 +0000
Message-ID: <20260206112449.45381-7-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
References: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|CH2PR12MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: 3295b901-cf56-473b-44f5-08de65726851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R8brbvgKOwtTJiBDlVmIhhLzMvLWLvK5fOwKrLYZze81dlVFJu6iRjULhWdq?=
 =?us-ascii?Q?AyvLIsjf03yQ87eGCqoD4OArukjF7yxsoKY/AYdOp5xmb8T9WXJsLEQ9nLHm?=
 =?us-ascii?Q?c82fsElKsF8JMxx9ABfsnpsMt4sdqSnhaDSL8DJ/DpFhH1uYCSAwq4ELuRUi?=
 =?us-ascii?Q?YEo8LKLW1mA23ZhHiK9pSZXZUBlvs1cLSOrH/0SmAkXOHeRYoIT9uCXuqCnw?=
 =?us-ascii?Q?srqbfffO7Wr+9T1bo85BtWrHmyVcz6CClsBVihOPE0G3aWZW/QeyUfgnBvHh?=
 =?us-ascii?Q?gr+faZZtUXM0W32L4ZjNqWplkqE0GFj4VlQ3I3vbK6ghZ7k8t42REvWkqw7m?=
 =?us-ascii?Q?dVS8t7iDcSEGAopWWMBlQR6bivfMNbvHR4r8tF2j/zZTzkE5Lx76yRXHw1MS?=
 =?us-ascii?Q?l8XxhDT1gp8IvgeRG7jOyb4zUW8wx0Xhw/M8LXrse8hpTJ9E+CNJitNDSMJR?=
 =?us-ascii?Q?PP8DO+Ybp3KbTykCwEwHTzAGOg579JP1yxTmGcweiCwN+rlCsZm0ubKsSU0r?=
 =?us-ascii?Q?gvFYMNZcor3R8OUnu7eUHQTQ2HQS/1wgfhdd94XmvPmi+eT98Vtjc0LkObFM?=
 =?us-ascii?Q?hHNybgWj492fhoIwdGr4c97f9qJ2BL4rcCEe2kx+VO4tIGrZ0bvYgH6JlrL0?=
 =?us-ascii?Q?Es9wBdH0mpX6QcfTQ8XJtSHzod1CmhoX4ng4jfrG7kF92cmvwaiqMH9TxIMw?=
 =?us-ascii?Q?7pqCHtW/Hn4hgUE0JxovCJGHcWZka4XokzqZ1rmxhEZjc6ZBUyvOg7dILN8f?=
 =?us-ascii?Q?jD6mOVfLxnwAnteBE7VZhSsebTNgMNDDo8A02XUgvfSFdvK6TIJUsOHpnX5g?=
 =?us-ascii?Q?EZJKoCzfyZBSGGiQXisL+XPszNGUvYnIBRU6bZ4/d613YF9/jyqsUFmuY9ze?=
 =?us-ascii?Q?AErpAY64JWkHOeAiYtx0i9DoDfFLP7dTOdxR8y9f7lWLRiOAtdXlxn+e5PaJ?=
 =?us-ascii?Q?0H1WMpbn99UaEbCbhN3chpPmh5ofbMqWt1NSLoshV4G9M/qlPX65IBcCDH92?=
 =?us-ascii?Q?EO4Mk8Q9YWcrMjYjex9lxEK7fO+kXCBY2faubd2YLXoJ8vYz2rSwlDeUoCgn?=
 =?us-ascii?Q?RgKqg4i1s8E3oowPNPeWBI2MVTubHgafcowweB5iZ8x6AmgYOyL1XqoNTxjY?=
 =?us-ascii?Q?Q8eIlzZ7d+xONGdgGS8/a6JcsbNJVUota/7m6ELrx8y1FjaTFE/o7mexV7D2?=
 =?us-ascii?Q?Dqc/xXmECukHgHha3uzBIAV0mncz8/9L1+F8UOYUjeC6qfmeSyN2UZ3WsTXz?=
 =?us-ascii?Q?EwbLV+ymBNLgw7GO7xKmkeFLFtGjEgxY1onXkFb08ADuWjCOMy5rKKmfJlmG?=
 =?us-ascii?Q?9z4DnaH+msrIfiF+cUXNEthniAl7VfY8IjnTqjelmG3U19Bz4KJOMy6gw9B3?=
 =?us-ascii?Q?/gSvarwqi1r0LHb6ZL54E0VpPNapASk+boP02oaifiRZEBD9S0ZW6g4gn5BE?=
 =?us-ascii?Q?yD4j1zo78Yvq8KopDC1t/q9c5nWZYWc6a4PR5mfwBAHKngLaiQZ/6TEOQl0q?=
 =?us-ascii?Q?FNJILrOZl61wKtNuRNbcxV95Cqhi0OlkZfIq5PwVSG/1powurQz9bOWxdtJ0?=
 =?us-ascii?Q?W9Pe2nGYdHcQ4D8zExpPWELT5M/FiSOrnDYnDg7fUN2TQDnL71E47A18itBE?=
 =?us-ascii?Q?l21IkG0MbUGZ9CorgF5FeIo/9OFWoWvk7dS81jN5Pj/uBSxg0KsgdvrpJKX+?=
 =?us-ascii?Q?U4NZKg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PjtkoGQ9jvb5wQ2eFtJJ+ppVZAgGj8hAVRCDqVYY1C9PSWwv6tFAFwa92bThm8MdG0+JmZotG4e6bCo/FBj1yNFMaDl24vvQsrva51Z4WrhjyT1mIEYU4DFoBooBruaLTV52OqnFldM8MVpJxaX+bXC2sJHvMV8hnjJeGI2LEKtneeuxYyHoydxqXPNXSgIsOhxhyDwklnXB7gM74fHHFvGgkAiU7KV4yugjtzNd0vv1V2I3qSATTsQZo7g8AQ8xF3MtJ0T3ihG8U90WJixwvVb6uJBNXkUAozj6U510u4N+HjxppgBlJqjXjUzl4MipkEQNfSLRGERqAe1aPnBzTDhe+sPUIW6mfJRApuXyFOGzt9Q73EjIBK+gFy9kYUFdR//JnjRqswjH3Dos52Zs5I6dRrY4rTe4yZ3VXPF1afbMbKj4T5IDT8vaYGm8kMM+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:25:18.3573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3295b901-cf56-473b-44f5-08de65726851
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9457
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

drop set_driver_table_location

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index f90d274c0f67..7331c7559454 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1389,7 +1389,6 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
 	.get_enabled_mask = smu_v15_0_0_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-	.set_driver_table_location = smu_v15_0_set_driver_table_location,
 	.gfx_off_control = smu_v15_0_gfx_off_control,
 	.mode2_reset = smu_v15_0_0_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v15_0_common_get_dpm_ultimate_freq,
-- 
2.43.0

