Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD84E8B39B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 04:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC0B10E31D;
	Wed,  4 Feb 2026 04:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pi7WUraK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8625210E33F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 04:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndjfN99gV+VukbKEX1Rqy+kZMTWjpeanq0HAcUTrKUf1q/lVoAC0dwVgFxzOs4jplTTFv9FXx//fjNJQG9IKgjqiE9Z+BagKQ8ZOA0zSAvgNFkqgzvlDY5zpVFYjYBFk08A9ZEC+KNG4tY1/qBGFb0uCzY1cw4DoIL7ejm1fypLvIyxCkS3Wy9V2J8sogvgedDYEnbVMiVCTqjeWx5CxB8xpFlB0A6zPvhIR9URtVaZ5OEXamrzGzeYJj0ZnRQ3x6j9AgG+rekEMuDhNmQkMxBUr9YeX3P4RKreU2015sccolm1lgsiKYNuXk2SSxK+MK3JMMRPj3YNB6ulHD75vjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HCjpeO5HSfs+nDBhbMeuP03r8AL1sKjTblhqzoXlls=;
 b=ylJx32WecnA4wX53zKs76zEr9RO89+GED2E/wZSlN/RmuW6fM9jIqJEOAGcvaWokjh9Ju52QtL9h3kozDEeT8SjDmC+5o6lCR+lOHR8OXS2gDuuadHCNUzeXmJte1oY3HjYW7ZEhA3ra1ENYUKY633pJJjYh+9WKtOa9uDOizW1qoSPtki/RjoV9OIxxsrLTwVOKOUVpxIlvzg2yhWR76W89qN6gYNORUA4oIUivPrpisovFy+79gxwhtyWr2WSD/Hk6OCG/zbQgN368yfLuXse3T5aP7QfEZmQDe9CMhazhovcfvuiA86YRo9Cz98BB0Ay7Dxsz/uVwVKYnzmvHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HCjpeO5HSfs+nDBhbMeuP03r8AL1sKjTblhqzoXlls=;
 b=pi7WUraKZJEQVNJhGVUCrZ9NHC3Poxbpl1VuUZOdHap6mjv7j4sWQuyYBnHbtqEhEgeJOBCRjbndBKt0Gn8I+BkDK2AaRMpl9Kp6SUMlwWuTUV84b8fYS2xvjH+/bEJ/9JrRfxr7YewPMhmm3Y99tQ/RIXYTFmQ6Yc5Ye/ddp98=
Received: from BN0PR04CA0125.namprd04.prod.outlook.com (2603:10b6:408:ed::10)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Wed, 4 Feb
 2026 04:44:11 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::57) by BN0PR04CA0125.outlook.office365.com
 (2603:10b6:408:ed::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 04:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 4 Feb 2026 04:44:10 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 22:44:04 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v2 07/11] drm/amdgpu: Drop unsupported function
Date: Wed, 4 Feb 2026 04:43:34 +0000
Message-ID: <20260204044338.96093-7-Pratik.Vishwakarma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd11543-af06-46b6-c33c-08de63a80a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XRDN2g4UaKE84jTsQHkrg5YdJzcu1RCdzdCiThEv0rQHX3hnb/RhF6aWEQHQ?=
 =?us-ascii?Q?4y35Pef0FtvnFusANFoXP7dDuaCbMOIF8Nz0qJ5VhyKIexM+8AUZVoEa9K6V?=
 =?us-ascii?Q?Q+88jMYL9evcaXjpHrVpjSlSmd5of+Cp/VEuiGuO6B7Dp6tBhQeZjiIg4mTd?=
 =?us-ascii?Q?ebL9lF+5NC9FCkRxKaffOqQnZkaN6TCl5rOTJpu3NB5dE4Kc2hSUx4XZq9wg?=
 =?us-ascii?Q?R5CxkrkRtimqYfJ1zi23YEJWUyCjcNG9FlDpd909XYk1yblUj6SxtVk2Fwtm?=
 =?us-ascii?Q?O1AuYqKnuAaviAnKw4k8fGLDHZOhBURzsgiy2a6cVUCQ0YsXn2tQnfT4lIOY?=
 =?us-ascii?Q?Y/KL+oFoMJmr52ONbnlqcutlWxMfKYxFztReWOTgpF0GZWqnyOkCS79vZsRu?=
 =?us-ascii?Q?GFAhI/aJyoyAMtNsiA/FWhScD2s9jCjRlBNcFnzK2GS3mpE3qYOCmJPNIKaw?=
 =?us-ascii?Q?9LgX3ufveHHS2kBlmipoqm6rc5YKb9vgHuMN4Cw/ZhFYRcbNZ3K2qcCJxitq?=
 =?us-ascii?Q?4+9MDTY618k7fPcKjlgRMHAFpwKZoYvoZAEamakbgclVHrh2x9Ecz7ybCDx1?=
 =?us-ascii?Q?oEhuLB40677gwypN95ZgK/MYpKlxRgP/CwQhqI1/raT6EJO6qau3d5P0Dz8X?=
 =?us-ascii?Q?YtWTEm7CGt7a8eieZ8oRUR8EBtTIh0pWdktqXo1W0hNwLmQAXSRPgmKjwRDc?=
 =?us-ascii?Q?KAYR07huZtWf7R90tMGPxPuu8sd2GEqzZXhOW1oD5tZQ4GXiyuiKUa4nYwKx?=
 =?us-ascii?Q?aeirXw+6mTvSAqAYv4Bqp8uC7X9c2u57jm/dPsQoW2h68QHdwEvOwXg8Kacq?=
 =?us-ascii?Q?v52sc985Vj5eWHMPDUjCgIcH9iuVDnDkauv4bn+1wb1IiuJGMML7G9wn6610?=
 =?us-ascii?Q?LgTFPc6YRbra2cQZEStYqghfaHw9tGhCUKqwOKWtQUt0jRbZm/SieQ0rEEz7?=
 =?us-ascii?Q?qF4AU+t/LcHwtz2qFYzwV8O2nzsjwOvZ80kqPyXGkfdDn33AmVD6s52SmWxO?=
 =?us-ascii?Q?ZlQAttP4bJa8waQdVO4ZgAbDYfva7vLTZwn3VTmUViXUKr9huVJYtMPGA0pW?=
 =?us-ascii?Q?yeURWJneVSTVNHU7KSEqEW3bxPK3UV8JUZR2xVB8Zu71eukXTgTkuagJbbau?=
 =?us-ascii?Q?d3s/yZKkXb/qXAjstpC/X955w3t0sFu8Grmd4CTeZr7iu32spZTdUZq/OY07?=
 =?us-ascii?Q?M7anbXdboXr9TaPfuiCIiNLIgtERaKPOaplQMshZHKjnLKANRg3ykpXbH95O?=
 =?us-ascii?Q?Q45gKGMQ/KoTEh20FFt3E2ETIr7DoJq/Vi7kJfmnn+9dzgP1OnfNJGVlwE6b?=
 =?us-ascii?Q?6xjPIRnmlUQTYiQ30KyhA9V95JIMGs/ifRLtr37Glx+gB5GuYIdGeXfhFrN+?=
 =?us-ascii?Q?Hs1eK1+XKP4VRIl94cxqVKQK+Rn+o9sYF968e9pHlJREn87QSvEEMGUtddHm?=
 =?us-ascii?Q?EmHQ9G7q1Ctht345i5TwP1OcVaTKp0C/aaA6bYvAq7swFzGsgP0wy53yrhKo?=
 =?us-ascii?Q?wjzLv/MtUZl7Xg0R7pRqTxdhIeN80wwEkry6auuqr1sZAx62VpieAb60+pDo?=
 =?us-ascii?Q?CQWkm4qRbDaZV8Al+PoMII/6z1bTcuSMzZGbxrC9ITY3l1p/+GqPgMFwZama?=
 =?us-ascii?Q?i8XxfuagZxVl1rrVgydvaYgLydU8LZE3kJD/TDQ3NKrXO0UQHdjEsZKSUs9F?=
 =?us-ascii?Q?Yc6ijw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dblnkF9tkI3xm4gf0kzTPTBIByqF95ENaXdTOmuXqo0ze7bsa1R0k1d9hHZtaVEG5W7WLBQH8fcs7h4bsm5oPCuguUtadh9zbTyhACuvLg02N5T7e7uJIItM7fiyBTk7Af5P/0rA5DwU3vpg3oPHqcvDT/xOnGUeuslCoB3TUPWxNHFkJ+NfLXNcrEWvjicOy/kzmg2PU1A5hRzzHt0HA+h3ZqfmFCtwDr2kvmXr3AQ7BwOmrE3iT2Kd/xwSSLBQ1sT1TyaeSva/iHWRESqQGxGYV4OnSUmh/gtI0RAlSQnw01/0umoX62GFMfPFEuLp3lRP5Z2nqEB/7ek947xA5PTGHS+9/69AEN1q+KIbRuy60efbR6hSPtX71ug1viU5E0f9W3QqLGay3PJ8IR0koW0OtBUT7jf6hROBmpazc5fZzo4FEZydYu46H4fBaFY/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:44:10.8594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd11543-af06-46b6-c33c-08de63a80a24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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

