Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67DBD65C49
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8703C10ECDB;
	Wed, 17 Dec 2025 13:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CELVCpVj";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D1810ECDC
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJYcjMwWgSB6/7aWxKkTCDlZaPdkYPe7hAB0Bq+voru4iF7Q/qdQXzeAKPEKcDbeGKOXU1SVQy9Sg1hiOrhqDE2LyzVc+0Y+YVtgOKY71nE1BM1rIWZ0BgLTVlxFHBAtPjJDPQjYPCtem3zRz6N//ldhZ8EwHmacUxTI4sHH4GhhkkfDDF7ZLbqxt0mARng+f3qL818aaeDyoPuvQnJoH80sZTYjF1tLplVoUv/RrJRiaKBxfyq4ofn7d59zNkgt7xNVameQuS2X79NVT+dTzp2J5gr/y/sTY3wdTchxn7lIb+ZtPVUF3ka7nJDeF5oEAw0TB+THcHNsxMkqHWBLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ1MMVk2Cpnt22icNAJPm8T5XtM4ef22MlscVXrlM8s=;
 b=JEU4zXuEsIi6lZQn1yBcRCnxCNQchsLwq+1NDJ3XEUIRRJbVD/EmAOOm4t59F/NEWwAbO3t4MWKQDczAByAA3O50Ivzktv3lK44PQt0L4M3qsdmJlbMFML4vAxMPCGixrVwUxXKWpIrp44hiRDstWlZb6MQWW2z3Gp/gWoAs4GN35uF3o8QVTK6Cl0hklYY3aTZxhqS+rn03ktvNQdvJ1+gJGkmRF628KLx22VTUXKGs5+nrqIJaS/NNz7J1zY7zcKsO6HbLE20tjnJjKnEVIGfGb4C6JZaB5ZX1F9/MAk95kWV1GMoHmij7UsjPlExK/pk1jkAP7hWyUtcgMKNtPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ1MMVk2Cpnt22icNAJPm8T5XtM4ef22MlscVXrlM8s=;
 b=CELVCpVjrBG/g3aN2IVxlp00sPTyRWlw11ay0MTEJZ57ydpkMz34cElVQGDfZHHbTnHFPwRxkhiQH/zkQH4eyuF7pVbKvxI2S1ZtTFjjEvowwDuOz9nuqfoarqa5S/3z85E78oM5ag50W4UR5BVVyvYV3MuZACx4unaWV0KsfJw=
Received: from CH2PR15CA0028.namprd15.prod.outlook.com (2603:10b6:610:51::38)
 by CH1PR12MB9719.namprd12.prod.outlook.com (2603:10b6:610:2b2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:55:16 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::e0) by CH2PR15CA0028.outlook.office365.com
 (2603:10b6:610:51::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 13:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:55:15 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:13 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 12/21] drm/amd/pm: Drop legacy message fields from SMUv13
Date: Wed, 17 Dec 2025 19:18:05 +0530
Message-ID: <20251217135431.2943441-13-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|CH1PR12MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 4558d8ef-f6a9-48cf-53c2-08de3d73e7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5IM8Sd/7JJYa++/rRLTnL70Q0fMYKIGK+o0CaatkAZHSG5yPD1JIhcwuqeME?=
 =?us-ascii?Q?0x6MswBn3uztJrUeXtnTpMXxn+9LeIN5AkzLLmy0ZZCl02BmPNR2AEsJhNH3?=
 =?us-ascii?Q?a1F5cu2Lgk4rbqy3os97hRor8jojLVCxsh8UGThHDWYYlYTsw8zK/xVOqye+?=
 =?us-ascii?Q?g5ToT96ScUHGYjBrnIJKuuHf6y/U5vdfR14i8zoQ98nBmwbQ31Qe6SdEB4A9?=
 =?us-ascii?Q?02xPzina3UhDpgKIyjaUk8Ox/Hiepg84LdfiMoy6K4t8i8YAKkAnq/tAOCep?=
 =?us-ascii?Q?Rx/b6HBibLDJZv6Mjyc39sxHfybxKvyPR+MigCmpnkG2jNJuXxtRRzVD7LP+?=
 =?us-ascii?Q?OL9/u5d91I6hgKnsZYcwClv4grM/ToLocPR9TCimiR1xKm4d861uX0MdRFZG?=
 =?us-ascii?Q?xVt9YiAd/TeVRmT+mu6jvSLatru6U65uDreChKvm/eL+BdnQI/Zc4vGs/hGh?=
 =?us-ascii?Q?hctDXBHUfcGdeVBcnbOmfASkUXCy+8W618mlRBEvDnXHUnjJJJbz5OPUgmKe?=
 =?us-ascii?Q?EPNyEE3qLPHV47fJKEoQPSCIIn6MuPCqLTkjd85zcHLTIawOcDUZ21cOVRyA?=
 =?us-ascii?Q?mGDuJFvYjv03ipkYVUdOHpZSfRLfhiXTZAYZUudCB5r1o6YiQvBY/jFQHoR6?=
 =?us-ascii?Q?GrlqSbMUaa2qtkAvVQfr/3M43o/REE9bgtazoyvfXtxgmfatGEVgOpZy5+Fp?=
 =?us-ascii?Q?K4TY6Qo9cJpG1Xn68e5IjSp014a/2mvs9kfYsp6S527mMRoEGnv1DMhfUwpK?=
 =?us-ascii?Q?OlEEMcLaIcBwkF+yQySR+aegA98aOLBYy9YQ/Ko9xUmQ93nxNaCcij4jBucQ?=
 =?us-ascii?Q?ZwPhgAIPMgwFWEIYdxX2wm6org3DRdBFNfled+APZy2TUj8P7lD+bguxIBOU?=
 =?us-ascii?Q?6uyM6j/U7WpUkDoxRk5rpWIT5MG86SBpyEOvj/3ggWN2zTP1QdqGnNseVd+2?=
 =?us-ascii?Q?hFFGtW8PFQ0JutTfTqR4F+KjfVZCXSyPaLc4whcIRHHe34bhHz5fuf3BI+2K?=
 =?us-ascii?Q?tkdCbXvk212tytD4mL6lCPfWBAE4VP+mGqUc0VtTRJkQiP4yGcC2cf9GG+M7?=
 =?us-ascii?Q?KsntNo1LsFslrMAOaUO8WZvLSZcy8FG/WFxf425DPpCNCx0iZp+em/s2sW8L?=
 =?us-ascii?Q?924ASJ0Nfq8dvltrjiki6hvlRAqMdjYNuoCPjdhfYLf/A4QWW7/GD13wOX6g?=
 =?us-ascii?Q?bhi3NDoKsxU0u/gIYeCW4Wi2augeCMsc6KWMngoD/SJSRMnimsafs5Ro8lI2?=
 =?us-ascii?Q?nojg11FUUeRQoFWX9Zf5OMX+AjAyZdHE3XBjqNNT/HmlfQmOJSkxB/QIr6+s?=
 =?us-ascii?Q?kSNnCQShfQVnl0tVCZkxGnza/pwUOesWgxw4v7TKzp4RbklMT6V2SrlgAYAE?=
 =?us-ascii?Q?6lNRSQVuTVsVbd8UiHqR9TSYnL2+p0G7el9flSPi7oBMBh64VcuX+k939FKO?=
 =?us-ascii?Q?XhrvEKxpYsnpL8kkJSMtYkfZfJIjN78H/1v9QQKoMvYyjshqkw6+4FrfSEix?=
 =?us-ascii?Q?OjVp/tZb/Il4sB9NpvDKRmANbR0DdG0wh/77EgJPrcil/bOYowNs/KLNnHzM?=
 =?us-ascii?Q?GvHKV8ZiAsmYe8q4yys=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:15.4722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4558d8ef-f6a9-48cf-53c2-08de3d73e7f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9719
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

Remove usage of legacy message related fields from SMUv13 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h    |  1 -
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c  |  2 --
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c  |  9 ---------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 14 --------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c    | 17 ++---------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c    |  6 ------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    |  7 ++++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    |  2 --
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c    |  2 --
 9 files changed, 6 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index fabf61e15dba..efeaa3d57712 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -251,7 +251,6 @@ int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
 
 int smu_v13_0_set_default_dpm_tables(struct smu_context *smu);
 
-void smu_v13_0_set_smu_mailbox_registers(struct smu_context *smu);
 void smu_v13_0_init_msg_ctl(struct smu_context *smu,
 			    const struct cmn2asic_msg_mapping *message_map);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 76edb54972dc..94b8e5dd76b5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -2034,11 +2034,9 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 void aldebaran_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &aldebaran_ppt_funcs;
-	smu->message_map = aldebaran_message_map;
 	smu->clock_map = aldebaran_clk_map;
 	smu->feature_map = aldebaran_feature_mask_map;
 	smu->table_map = aldebaran_table_map;
 	smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_ALDE;
-	smu_v13_0_set_smu_mailbox_registers(smu);
 	smu_v13_0_init_msg_ctl(smu, aldebaran_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index b941ab24f823..34ff4c35baff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2351,15 +2351,6 @@ int smu_v13_0_set_default_dpm_tables(struct smu_context *smu)
 				    smu_table->clocks_table, false);
 }
 
-void smu_v13_0_set_smu_mailbox_registers(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
-}
-
 void smu_v13_0_init_msg_ctl(struct smu_context *smu,
 			    const struct cmn2asic_msg_mapping *message_map)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e2ad0865de1c..a245e3bfc69f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -70,15 +70,6 @@
 
 #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE	0x4000
 
-#define mmMP1_SMN_C2PMSG_66                                                                            0x0282
-#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
-
-#define mmMP1_SMN_C2PMSG_82                                                                            0x0292
-#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                                                   0
-
-#define mmMP1_SMN_C2PMSG_90                                                                            0x029a
-#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
-
 #define mmMP1_SMN_C2PMSG_75                                                                            0x028b
 #define mmMP1_SMN_C2PMSG_75_BASE_IDX                                                                   0
 
@@ -2888,10 +2879,6 @@ static void smu_v13_0_0_set_smu_mailbox_registers(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
-
 	smu->debug_param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_53);
 	smu->debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_75);
 	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_54);
@@ -3216,7 +3203,6 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &smu_v13_0_0_ppt_funcs;
-	smu->message_map = smu_v13_0_0_message_map;
 	smu->clock_map = smu_v13_0_0_clk_map;
 	smu->feature_map = smu_v13_0_0_feature_mask_map;
 	smu->table_map = smu_v13_0_0_table_map;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index d8ef38535fe8..7ca9adfa2446 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -1124,15 +1124,6 @@ static const struct pptable_funcs smu_v13_0_4_ppt_funcs = {
 	.set_gfx_power_up_by_imu = smu_v13_0_set_gfx_power_up_by_imu,
 };
 
-static void smu_v13_0_4_set_smu_mailbox_registers(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
-}
-
 static void smu_v13_0_4_init_msg_ctl(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1154,17 +1145,13 @@ void smu_v13_0_4_set_ppt_funcs(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 
 	smu->ppt_funcs = &smu_v13_0_4_ppt_funcs;
-	smu->message_map = smu_v13_0_4_message_map;
 	smu->feature_map = smu_v13_0_4_feature_mask_map;
 	smu->table_map = smu_v13_0_4_table_map;
 	smu->smc_driver_if_version = SMU13_0_4_DRIVER_IF_VERSION;
 	smu->is_apu = true;
 
-	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 4)) {
-		smu_v13_0_4_set_smu_mailbox_registers(smu);
+	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 4))
 		smu_v13_0_4_init_msg_ctl(smu);
-	} else {
-		smu_v13_0_set_smu_mailbox_registers(smu);
+	else
 		smu_v13_0_init_msg_ctl(smu, smu_v13_0_4_message_map);
-	}
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index f351880a5e97..29ec02f2dd6a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -1144,16 +1144,10 @@ static void smu_v13_0_5_init_msg_ctl(struct smu_context *smu)
 
 void smu_v13_0_5_set_ppt_funcs(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
-
 	smu->ppt_funcs = &smu_v13_0_5_ppt_funcs;
-	smu->message_map = smu_v13_0_5_message_map;
 	smu->feature_map = smu_v13_0_5_feature_mask_map;
 	smu->table_map = smu_v13_0_5_table_map;
 	smu->is_apu = true;
 	smu->smc_driver_if_version = SMU13_0_5_DRIVER_IF_VERSION;
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_34);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_2);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_33);
 	smu_v13_0_5_init_msg_ctl(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index cf011fc3bb61..d76ac14a8a64 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3899,8 +3899,10 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 {
+	const struct cmn2asic_msg_mapping *message_map;
+
 	smu->ppt_funcs = &smu_v13_0_6_ppt_funcs;
-	smu->message_map = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12)) ?
+	message_map = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12)) ?
 		smu_v13_0_12_message_map : smu_v13_0_6_message_map;
 	smu->clock_map = smu_v13_0_6_clk_map;
 	smu->feature_map = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12)) ?
@@ -3908,8 +3910,7 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = smu_v13_0_6_table_map;
 	smu->smc_driver_if_version = SMU_IGNORE_IF_VERSION;
 	smu->smc_fw_caps |= SMU_FW_CAP_RAS_PRI;
-	smu_v13_0_set_smu_mailbox_registers(smu);
-	smu_v13_0_init_msg_ctl(smu, smu->message_map);
+	smu_v13_0_init_msg_ctl(smu, message_map);
 	smu_v13_0_6_set_temp_funcs(smu);
 	amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
 	amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index fe09e19ea8ec..281d328588cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2807,13 +2807,11 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &smu_v13_0_7_ppt_funcs;
-	smu->message_map = smu_v13_0_7_message_map;
 	smu->clock_map = smu_v13_0_7_clk_map;
 	smu->feature_map = smu_v13_0_7_feature_mask_map;
 	smu->table_map = smu_v13_0_7_table_map;
 	smu->pwr_src_map = smu_v13_0_7_pwr_src_map;
 	smu->workload_map = smu_v13_0_7_workload_map;
 	smu->smc_driver_if_version = SMU13_0_7_DRIVER_IF_VERSION;
-	smu_v13_0_set_smu_mailbox_registers(smu);
 	smu_v13_0_init_msg_ctl(smu, smu_v13_0_7_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 79ec2d235a09..b4b55a66fb71 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1360,11 +1360,9 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 void yellow_carp_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &yellow_carp_ppt_funcs;
-	smu->message_map = yellow_carp_message_map;
 	smu->feature_map = yellow_carp_feature_mask_map;
 	smu->table_map = yellow_carp_table_map;
 	smu->is_apu = true;
 	smu->smc_driver_if_version = SMU13_YELLOW_CARP_DRIVER_IF_VERSION;
-	smu_v13_0_set_smu_mailbox_registers(smu);
 	smu_v13_0_init_msg_ctl(smu, yellow_carp_message_map);
 }
-- 
2.49.0

