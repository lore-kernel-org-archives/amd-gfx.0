Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72882D1489F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7C410E68A;
	Thu,  8 Jan 2026 04:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gVwnMIk6";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2CE610E68B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:50:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbnhxEoX4AkaM2ohfJ4khIvjf3dYCOCs5SxjMHV1SalEaJWCN1GQn81VAksoBr5i0hhEk/okwXKqOQRu6D3Oi0MSsm/JRK9/d5pO5BQEVTODGuFWCZFGZ66wu+in3Ib9KNC+A+i13AN8vcVVo5NZ9+Ig92LyEt8dmq8flcPB+5uBHWb5mRaCp3Hatxc6Lq+ZhtrizGvvR11ZSpNkd9W5jgBWBYgrah0qMJb833YqEpgG8ubdECUAxFFbj5mwVNrJGO69+Go6YJKN4dzjM38anRkwhIHswXaIppjMTkRDymgxMiE0B4uVn1o+Jscj7CTys2VWJ5QWWp69WkfuHYuRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vmBEEsNmCh9oiOcAk78oBovtFwJbm/jDbra6TJvb9Y=;
 b=Bt2fJ0sTe4XNSoDF0nl3UsFPPnXAQUZ/0/2syslnC+5yOYd2vTf0Tq1c04q0OY4qXNTvu1D9Mab1dRht+uRRV3LvIprYxRFHfwuRVP/nStHYzsYQ/ngSZsVlWG8Pmr0oeCdW6CRFW17Wpv1Cbzq3FFurQj69ICs7BSSsTcNyCmtG2igkTMmmbROk0FM3QAUScuPR42aDLkeIdhNGobgxVEy2AWxaDSlSBDZt0e/ouqNwBRz6iis6FwMMzfNM5Ukq2Tlnj67XGXbC+sA1iQE3E3ltj3Q+KWHLrgfSZ6XkqRHgczPIPsDIMiTbI8oktTPyIlYidageUCbgeASg1oOQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vmBEEsNmCh9oiOcAk78oBovtFwJbm/jDbra6TJvb9Y=;
 b=gVwnMIk6aYsNR4CWRGAHlmnDAV2Bdrkt7Dar8vWHJVQ9G4dpMmFSjBX6bVQTl4Jd2XUNIG3cf029IKbryKpfHV6FEOKPIAIoJ85l8decBh4EqiGUMGhpWszK4CMiKjdGmCD+IWflod8GFFkPntTfMN+GUQJW6XwHWpy1YJNWh6g=
Received: from DM6PR06CA0066.namprd06.prod.outlook.com (2603:10b6:5:54::43) by
 SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:49:57 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:54:cafe::38) by DM6PR06CA0066.outlook.office365.com
 (2603:10b6:5:54::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Thu, 8
 Jan 2026 04:50:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:57 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:55 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 19/24] drm/amd/pm: Drop unused ppt callback from SMUv13
Date: Thu, 8 Jan 2026 10:17:35 +0530
Message-ID: <20260108044839.4084279-20-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260108044839.4084279-1-lijo.lazar@amd.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc1ca76-0f57-4d0b-d2b1-08de4e715fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RrL4P+0Gci3vUbKNCldHa2uxdHupOGj6cfi4OpRqdxR9Z9hBOCJjEPPzbNAq?=
 =?us-ascii?Q?bosgtwf7hAchOxh1KNFuVUhJ9Zt2JlvIKktY84g9lO4sFWQLIH4joTBAaXjS?=
 =?us-ascii?Q?KKG70FnVP1GKgdSVDNS3loaqwsqBH86Z87UyEglwCYVA9RuiFRtteeEceSKn?=
 =?us-ascii?Q?k1yy8b2HBkBVWmV7TA18/5hzJx/Yn4HlhULrPh95sbXyP8HU3npfkalYMdXT?=
 =?us-ascii?Q?FX1MNXHvi3yyVEd7jADYU+FGtVb9q7WsGqcy+rKPdO/hPyWH1dwJpnZ5z5Qt?=
 =?us-ascii?Q?f4MmzKPxe3SPKvp8caTVg4VizuNVQEMoRI6Sh0Zb2AVKbmB5ZZ7UrBFmR7id?=
 =?us-ascii?Q?39M5CdVyfC78r2Av0lnv+FRpoZcG3KbNrYk2BUfUN9yo5wYCc6XzoWpxmRBf?=
 =?us-ascii?Q?303HBc0+6lKh9yu+VvkM+ATKAErRbY6CXUWSTbaUu8e+El0sLxSTR+3ZY5Pt?=
 =?us-ascii?Q?pr02Mhyze9blJMAmaGGjcxAI5Ffa4BFQIQXHqhPheBpWLaYT16eD5WyvGsvo?=
 =?us-ascii?Q?fPyrQXuU4E35uFRUnlHo3i/fO781Isug3/YYJWCJv7eIxAipcyDM5HRH5usQ?=
 =?us-ascii?Q?UGr6MPQSxpgAPLrgOBoslYrFd057h3OK1xp6918dxlQAZkGDkfwF/wvHQlHC?=
 =?us-ascii?Q?OwvFfKm+NY1iWi0dQfEPCzHNESUWRgaYPFP77vtOaKd/et9RMVwRj5/k4fhY?=
 =?us-ascii?Q?NYvk134bn+O3kq6pnVaxrmmxFRDrq71A9Vchj0RciPIUUYWxvRoR+7Alassp?=
 =?us-ascii?Q?AtKKPVOJ19WRcl8OjTreAKHAc7Uo309We972PcyymG3QoUP22AKqOXv4UA7U?=
 =?us-ascii?Q?q/fkhR+eZ9XGMf2PSzXUATnr2tFWTy9Mkw2FdrCBkEwMKRdDsLgDHD08IAcl?=
 =?us-ascii?Q?NU8fFx7axQFU3BLkOlskSk98o69Sp2hfpu8lwdxnXtfJWSx7eRf/0HoFhfx9?=
 =?us-ascii?Q?OELE9CXpkuq5B0m0tk/GYRaFAPqatkJmdasGMNKLbirU8tAUVwuEU3CTqszl?=
 =?us-ascii?Q?sgr+e9Bov0PhvSJH6d5FgZQOV7JgZFovrpRWKvDbVAhdqFSLT3QD+GW1NACs?=
 =?us-ascii?Q?RSE90IlCZAVuHRzquRqRymVw+WtEpHhxI6ehZD06XPMv1xdF/H9ST0DliSEE?=
 =?us-ascii?Q?6DjYh7kqwUIYhMZviDUesPxEosMo1yKSJm33zV6I0hkhl6L5JexmGKbj0PX/?=
 =?us-ascii?Q?CnhBibQK3Lik6nX8lIiUhN/zNss23wqoE8fZYxRdo/HBOFXhYZNvpWAKeIR8?=
 =?us-ascii?Q?Ft6hfdtike69prZW1XkO5/Mh6LeGcdI9DvxB12V+Snf2FwvfRt11kV2ViAbU?=
 =?us-ascii?Q?F68+g7ys+h4p7/ewZKTK2VNd7yRJumOaAv5dEEyerGc2Syq+xixZTPQKzO+0?=
 =?us-ascii?Q?tUcs67D3vvLj9XZ5tK26MegpvBlzWTNqTWAVCzkc2JtAEHjC5FbHkSspvE5Z?=
 =?us-ascii?Q?E7bu0syJ3fHsFxOTG6uJuFZpAAHC8Nw0WvTppZFM+x/k9FHfvo0umaBte6Yv?=
 =?us-ascii?Q?+DDA20mMnJaNkvHm4/ZJ3XGQs3BIQJDJE5/hmo9lFw9LaXPLuZ44fEWUkyMC?=
 =?us-ascii?Q?kON5yy/6QccVyL5iDHw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:57.6999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc1ca76-0f57-4d0b-d2b1-08de4e715fbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008
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

SMU message related ppt callbacks are not used. Drop from SMUv13.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 2 --
 5 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 94b8e5dd76b5..9de0b676bb7b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1996,8 +1996,6 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v13_0_notify_memory_pool_location,
 	.system_features_control = aldebaran_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 7ca9adfa2446..41c61362f7fc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -1101,8 +1101,6 @@ static const struct pptable_funcs smu_v13_0_4_ppt_funcs = {
 	.fini_smc_tables = smu_v13_0_4_fini_smc_tables,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
 	.system_features_control = smu_v13_0_4_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.dpm_set_vcn_enable = smu_v13_0_set_vcn_enable,
 	.dpm_set_jpeg_enable = smu_v13_0_set_jpeg_enable,
 	.set_default_dpm_table = smu_v13_0_set_default_dpm_tables,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 29ec02f2dd6a..e4be727789c0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -1104,8 +1104,6 @@ static const struct pptable_funcs smu_v13_0_5_ppt_funcs = {
 	.fini_smc_tables = smu_v13_0_5_fini_smc_tables,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
 	.system_features_control = smu_v13_0_5_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.dpm_set_vcn_enable = smu_v13_0_5_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = smu_v13_0_5_dpm_set_jpeg_enable,
 	.set_default_dpm_table = smu_v13_0_5_set_default_dpm_tables,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index d76ac14a8a64..1e82c43c851a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3860,8 +3860,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v13_0_notify_memory_pool_location,
 	.system_features_control = smu_v13_0_6_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.get_enabled_mask = smu_v13_0_6_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.set_power_limit = smu_v13_0_6_set_power_limit,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index b4b55a66fb71..7f70f79c3b2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1333,8 +1333,6 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.fini_smc_tables = yellow_carp_fini_smc_tables,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
 	.system_features_control = yellow_carp_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.dpm_set_vcn_enable = yellow_carp_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = yellow_carp_dpm_set_jpeg_enable,
 	.set_default_dpm_table = yellow_carp_set_default_dpm_tables,
-- 
2.49.0

