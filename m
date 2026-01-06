Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D343C47BDF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D0010E4CF;
	Tue,  6 Jan 2026 10:14:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BRXNa3ht";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EF3910E4CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjn9KASLI9Ea/e0hQfUxsGwsH2s8ZB3MVbo5WDQfr/UCzIO0R1+xbheXSt6LOYSSpmDUSrFQ/5opJgsC0NHc4aOSOANtNOJoEg1sgAuXLEo7/YikHBRyHURQ9PtrGKIox8+4izzh3iXWH4eVpLjnjzAqxEvePVq/2pCIWlva2kzWNZKZP7bzfhuE+FENbEKxkWBQI2EHWKsFzU1XEJ9Euv/l9ZZZc0SXaugiIJpECv9V+xUbbcVLqyk3dhTBBsr3aYj16KtTbDb+fruUwzH1sCMwnsnnyZH/loUDKnZCT0TuDA5CqM9gm1Am2yHMrUMNPYmXw0Gco8Bnoav1EIDmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZF++AMp8op5ztiECXzQchrA2W6MW4sVPMNyW6YcrDjQ=;
 b=L66QQ0W20DybI4XkEdnDBXCPuysfTBP76SesO+gDw0dO9/M/RcamZBFvD5qo9Nc5x+SPKv4u6LoaGV/QJPjYUShREjLUEvfNRfXUnXSco5AB0vMsMvuAkozZMTh6J2Y7f3sNQhdXJjvtCuVivYj9KBpIZjt7E8duxDgf/l/2WaHzn7Jqwo/1Kh3MBAouRBSgpBL7+OijVw+NvqQHrKQfgHHLK7pDraVkxCwXjDfyzRZ6JabjtRSeR3ZyEmYOQPz1lEDbkaOUHDLssPLIB24P9C7DC1eV240hVeS24G1n0MewoioShL8u71KBkqQd6UxL951O8r5VnmIzJI4LwFWFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZF++AMp8op5ztiECXzQchrA2W6MW4sVPMNyW6YcrDjQ=;
 b=BRXNa3ht7203YGVFWVnwj/aftLYgqjP1qAdJ+TT/AdLmk/grOG1zwC0gyzh5GNxgEh/pkR+ASih4PLlKvFqh3hstlFNAHCujpt9SgF4UQgNpsVpPl2Z1E1hvq44f91Wn6QAvjbl1hjr62D5iYfaHCitaZrnJu7QlM8CkiLkGL24=
Received: from SN6PR01CA0007.prod.exchangelabs.com (2603:10b6:805:b6::20) by
 DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Tue, 6 Jan 2026 10:14:11 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::a1) by SN6PR01CA0007.outlook.office365.com
 (2603:10b6:805:b6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 10:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:14:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:14:08 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 17/21] drm/amd/pm: Drop unused ppt callback from SMUv13
Date: Tue, 6 Jan 2026 15:42:37 +0530
Message-ID: <20260106101317.3856153-18-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260106101317.3856153-1-lijo.lazar@amd.com>
References: <20260106101317.3856153-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a6b2ca-f73d-4981-fba3-08de4d0c55ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0ajv95jMLavPIGRCMbemwvWMlGPjC3tyR1uvVfG8IbZEdrbQpsH1wX8DE7fY?=
 =?us-ascii?Q?+LzR/aCCq3Xn3X3fSuXXfT5nYSGDNXYL52XpH9tMDIANOCHXo1f53CDBYLhr?=
 =?us-ascii?Q?9/xP36XbCxW/yFctshvyakCKQBmlv+0YR7Lv/u3PY0TDfNuTP8O3gfijicYT?=
 =?us-ascii?Q?ztp7ty3dFNPqpPC7kqraQa1yB+is+95KoWJdAFbvT33HrqTczlh4wPqPztM1?=
 =?us-ascii?Q?caquLAeVfo3DydxRWiPIHARYifs6HWly9NAzjRdxBNXNQ6ob7wf8tol4WSS7?=
 =?us-ascii?Q?yPyjP9htc7eC4+JKRF6SZmwCXMEseof0qPjtWTQ9n9b0rbMHgM6joaXt5X+C?=
 =?us-ascii?Q?ekeIA8B5NaZ5bvUNy6USAPFHszVw2GPnqmE4t6zPKRIkoGhHqPG3xOmgN290?=
 =?us-ascii?Q?AYTTvEG3IPTbmP4tkSMbVUWvwIIKCvTS7DVeZLZrGQcS898MeaIk+L36fM6x?=
 =?us-ascii?Q?LALyWCZNE8ncmq+rxulPldfdS18x7ySidc7Ksa2eyEbfazL9YDhsHM9lxLcW?=
 =?us-ascii?Q?Esi2UbuBfGVFETdfQKqJ8a7o5ZeAm1S5M6pFMZxxOd2+reJnWsLRXzXGkYiY?=
 =?us-ascii?Q?DJrbwKthrQNfapppN+B4bWx3vekyND608LvaKx0Y+SpohDocORZEc26tltDf?=
 =?us-ascii?Q?aEuHyYo56mve2DuENqzWkb247fKn+jOu2XYZpIlzUNLugFHWnv3lBsLAozus?=
 =?us-ascii?Q?2jOggI3lzWAkZnD6mSAbjvMZUWBgGoasvhq+XbbOyeoQIx96LI/qTUmWJvYU?=
 =?us-ascii?Q?jrBdRsUqL0JEu/SDNfLKcwp0GWxcnM9ETGVde9c0x3fIIrQwMdgYxYyTGYWG?=
 =?us-ascii?Q?S+ff1qJg4LmgU22H53WGeyUYq2IfkLU2323S/rgarryzgResACgxUxov8Riz?=
 =?us-ascii?Q?RkR6zkwrYzXf9dGjQB6wDe+iXhorbLLHtf+twCGUIxY5nfc4O4CiDIx90LXf?=
 =?us-ascii?Q?myj9sOx+a+ErU/DaPnj9+Wl6xIEQrQMfJPayZKam1xgr2oTsOpG9SlVutTQg?=
 =?us-ascii?Q?Jv335y+wVJ/Cb7fof/2zJ7SLJV2awMzlhTY8iKFnCLrJH3R1FG/kBvYU1Ob4?=
 =?us-ascii?Q?dv2s0gQ7dIJf1QBvIyPtK5lPk1Xp1Qg+XLhHfIU1wBFbEuqOE1FhD7pbvCJ1?=
 =?us-ascii?Q?9UMozErIjLSXmZsyii264qyp0G2pC/Gr+9WLkGH5xzJjA4rrdmb7R1W+LzWX?=
 =?us-ascii?Q?ofgAkSyC+LtBz24wpiCgPnSDd58sl5z2spmc0jyUerHtePEAHyRlIIl2agdX?=
 =?us-ascii?Q?74jeUYNUOqd4YmA4K6hnyKlnGfVyNlFBWJBgZpvEK/mtl3Ya+pddz/3Wc6f/?=
 =?us-ascii?Q?F5eHJ899h+5xeyQvOTn5PAPi9hn7Euv3r8lzLZonkPVALQDLx/zYsBwEhPPj?=
 =?us-ascii?Q?azsIbLfpc2fFLanjpmPKcLddpkVFR+qAXMOcxqJmebXC0KztDVNvyf4xJLcV?=
 =?us-ascii?Q?PAp4MXr/oQ6Wcvc2cUK0TH/XJZ9TmWVukHwv2JC3087/Kj6MRxI3INzs1zZq?=
 =?us-ascii?Q?hPqOT4EmxIJndQP5vuTls3PjdqxR7L2ZbKGGGEiDwnnAP+NmtLuWiXpRprV1?=
 =?us-ascii?Q?5njGNz8XNqETPtkiFd0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:14:11.0358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a6b2ca-f73d-4981-fba3-08de4d0c55ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972
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

