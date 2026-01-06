Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7FCC47BE0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB9F10E4C5;
	Tue,  6 Jan 2026 10:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MT6q8t/L";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6427310E4C5
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6sBT2e/vL1qNGL8rV3yWx+yF9cR3FSEYvT6noMrKbBJma9Czsqp9sAT87mvNvSshtn4Og3GMhbs5NMbVOwrAoy+K9pcw5LpxmKsRFwKa3k2sbkW1kWXfAJ5P1pijXjeB8HUrM2jGID8jfJwCb5PvMY9xuGATu0UPqIrXmN1mQxzG68aczcbXbyls39GsfrjA9PEnVuu8SeV62xhx9kKhGCj/aOlpWDdaWVOVxOJjl4p4TVY4HYRFV39ylEmXVIBAcpevTSiU3KAn/qHl4JZ6UjO5FbBJj0F1YVsWB8Iw/TPtKAh2TrESXcDWtRWTsHkPD1h/amCleUpYapaYGwptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNO60Zt+UMskbn8ZGOCiQ6sz/CNO4U6vgPiJPvAt7NU=;
 b=bwNGlU1fawozPdSRzwvO4o6EngF+f++LlXNswCLnEm+IFEqn8Gj/3ZBr2AkS9iT+x6gGgmLjgyFaXBxaQP0srU49lKpr8t+gC79/ImuJ0mvhn4OreOyaIHwifgnvEdWwRZkl7kg2ckzoR5sUp9GAkUqy07uI4VSmxE2++vbZJmc+uDdgzR1Ccb3KyEX95a/AEBy9Chg4SpDEn2awy6TUleiY9ybKKTD002a+Iqq8CJh23v2OEjoxTy+FKXrOWj8J85X0IgEdCzI11g7iTEamz5AiMxL9lpLnvB/nANSdg75nIXycJ3q34mpHhTIlvnkgI1OlkGKQrFnpp9+7SMR8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNO60Zt+UMskbn8ZGOCiQ6sz/CNO4U6vgPiJPvAt7NU=;
 b=MT6q8t/LgxS/lhqCXuSGWme+Y0E0P7NprZq9X81xFq7zhhcEIHZH4NLBAb28aCItm2Qdst2VevEE6KMgEtuCCxZRe5fVpUEpe6/6vKoZalt7viyd7wmhe2m+UC7JZLgtg6Gc3l+ldF+s6AsPiI9cMxVoHLunHM1z7VLc6ABsbKA=
Received: from SA0PR11CA0178.namprd11.prod.outlook.com (2603:10b6:806:1bb::33)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:13:58 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::3d) by SA0PR11CA0178.outlook.office365.com
 (2603:10b6:806:1bb::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 10:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:13:57 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:13:55 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 10/21] drm/amd/pm: Drop legacy message fields from SMUv11
Date: Tue, 6 Jan 2026 15:42:30 +0530
Message-ID: <20260106101317.3856153-11-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b514fe2-36e7-46e6-df3b-08de4d0c4dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7HLcYgQ6WnayJm8WA7BqMwrNsLpsVekcBX6/8BZFlvqXco4JgHUXR0XdoXu7?=
 =?us-ascii?Q?+fvE3aBKklBdK4eR8xORi+GfYXNOs01GeAfUXsugI9YbajzFub2vY4JOMfWI?=
 =?us-ascii?Q?tK93pBs7wvjDfHjrm3QCiPaufWqjhp+QBoYh+Gl2VADlvbRU6a1ONuiBb2oi?=
 =?us-ascii?Q?SngFRkB0jsduD1YWdPhs3S9vZ/HB3llhf2p6NHwAvP+Ssge/yu1IYaEMzJql?=
 =?us-ascii?Q?wE70GSrG17IlOTjWxZyAlP6yxXvJwS+0hOK7xXxvXNPpUlUrDP4W2jEbkpGU?=
 =?us-ascii?Q?6q2NlKJpT7RZhWnSpk5pace5dDgK3Mi7Xld3ShgjaUs9BCUJ8stJgZQAKpsY?=
 =?us-ascii?Q?+CThpDi6B9dp32RbbubInbL2C1qIIGpQjIe3+irpAwBKO90VNH3n+kFF6GvX?=
 =?us-ascii?Q?sB4CGmNeHQAPRyDZikoYBggftiV5QPeexwTMtj9z8uwfJavKO8sFU//S7kJn?=
 =?us-ascii?Q?UBRFIk6HA3rvxpIBhU9KhhbBzrtGkQtlcKZw+tWuDN649nrjArJS31NjI0g7?=
 =?us-ascii?Q?8rLxxyeDYp0Uag9HnptW382lXKs0TBS/B5YKkaYf5x8+Z0lBcLOmiXE/O44e?=
 =?us-ascii?Q?4cCNearcVmUjf8cfMcTBD7iU7REJ2vfYq7TOdtWEZsWguBm7pEm7ZLW/yi74?=
 =?us-ascii?Q?f9cimRfzNkUuLPFx8hg19y7MyBEQj7ZOSEmsOZCt42+sZIUxgLDW99fVuh84?=
 =?us-ascii?Q?0KTFpyodCQIBXOGRAvPlQNoJAvbH+zOVCki4gY9OjDO1Cn6h4Uivq5qVj3JF?=
 =?us-ascii?Q?otFwqdlO3NnIxsSGAsuUUITGJXgop01SmmA/Z2b/DkSepQgc3+bBrC17J+lr?=
 =?us-ascii?Q?JnkM0k9BsUNl2K6Mj+mxwAoS8wHEjlCS8qjjUWcr/0+8WfyhVzjFw+ZUmuDj?=
 =?us-ascii?Q?sQ9d/KzmXlCrLTl87H+5f9HfdZ1ttBgXVQuqEeBWWmks3LRnVXCyNdVyMf2Z?=
 =?us-ascii?Q?25tT2QdfjE3Yc9wON1Bej5pwfKWD05BUMsfonV/h1xAtjSCRrvrj0O9Z7Af2?=
 =?us-ascii?Q?TDpRAgg3H+213wP5hhgJsoUwEZ1YVNPePiu5b9c1qLC73SzISa/MRLQaZAOm?=
 =?us-ascii?Q?DOw5M+xXymScevmYB1kaFJFGJD+ST++mlu7qe17ErfGlilPsxrwf3o8BVPOO?=
 =?us-ascii?Q?df6qIo/c8S/f5mMIHmEKqj2Er1d8DlCCNoBek93Ru3fpphd1vbobpoxDgrXk?=
 =?us-ascii?Q?alYbA/mKVMcDY0JfZ7KiZxXDsVBtuGOMS8BU6TinUoe2njhUf2Y8MnNV+9DC?=
 =?us-ascii?Q?EUueNfb+XJgnTlITVyiSoSrcCw6P5+rHsjmmVQbVf3b3tX7W0pSWvAQYNhv1?=
 =?us-ascii?Q?i55iMwopXcXreTOdc5CVkBuS9DQwaffKTTmztoKkEF2283pt45Z0Zonm8ZPK?=
 =?us-ascii?Q?NLf3WGtZb27LVBPtYoqlnz6xmrtrsoIR5R6RdyhKf20SdrCIcNIXGyd5JOIw?=
 =?us-ascii?Q?VlteAecjL5OsU4zxSK4ZBZ5Be3c6mPD8Yb2307ffVFjktcC/yvbHzkfuzL8o?=
 =?us-ascii?Q?UpVBMgSLkUmZrk61zdEYZo9gaSQyqBdX267xDmhLTIQ39I6PpABgQFEA2BUm?=
 =?us-ascii?Q?3C9MbZWlO+nSIdtXYJI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:13:57.5924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b514fe2-36e7-46e6-df3b-08de4d0c4dfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577
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

Remove usage of legacy message related fields from SMUv11 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h            | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c          | 9 ---------
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c        | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  | 4 ++--
 8 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index 97c19005952c..7c1701ed3e11 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -282,7 +282,6 @@ int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool enable);
 
 int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
 
-void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu);
 void smu_v11_0_init_msg_ctl(struct smu_context *smu,
 			    const struct cmn2asic_msg_mapping *message_map);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index eadd81e413aa..4de7ae6f7c8e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1959,12 +1959,10 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 void arcturus_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &arcturus_ppt_funcs;
-	smu->message_map = arcturus_message_map;
 	smu->clock_map = arcturus_clk_map;
 	smu->feature_map = arcturus_feature_mask_map;
 	smu->table_map = arcturus_table_map;
 	smu->pwr_src_map = arcturus_pwr_src_map;
 	smu->workload_map = arcturus_workload_map;
-	smu_v11_0_set_smu_mailbox_registers(smu);
 	smu_v11_0_init_msg_ctl(smu, arcturus_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 5ae6ee87de04..15968b057469 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -601,9 +601,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 void cyan_skillfish_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &cyan_skillfish_ppt_funcs;
-	smu->message_map = cyan_skillfish_message_map;
 	smu->table_map = cyan_skillfish_table_map;
 	smu->is_apu = true;
-	smu_v11_0_set_smu_mailbox_registers(smu);
 	smu_v11_0_init_msg_ctl(smu, cyan_skillfish_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 3596cb7f8adf..d7aa16681e24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3369,12 +3369,10 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 void navi10_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &navi10_ppt_funcs;
-	smu->message_map = navi10_message_map;
 	smu->clock_map = navi10_clk_map;
 	smu->feature_map = navi10_feature_mask_map;
 	smu->table_map = navi10_table_map;
 	smu->pwr_src_map = navi10_pwr_src_map;
 	smu->workload_map = navi10_workload_map;
-	smu_v11_0_set_smu_mailbox_registers(smu);
 	smu_v11_0_init_msg_ctl(smu, navi10_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 087b4b6ce857..90aba9adc24f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3182,12 +3182,10 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &sienna_cichlid_ppt_funcs;
-	smu->message_map = sienna_cichlid_message_map;
 	smu->clock_map = sienna_cichlid_clk_map;
 	smu->feature_map = sienna_cichlid_feature_mask_map;
 	smu->table_map = sienna_cichlid_table_map;
 	smu->pwr_src_map = sienna_cichlid_pwr_src_map;
 	smu->workload_map = sienna_cichlid_workload_map;
-	smu_v11_0_set_smu_mailbox_registers(smu);
 	smu_v11_0_init_msg_ctl(smu, sienna_cichlid_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 579b1dbd36ac..eb1b9faf8e5c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2168,15 +2168,6 @@ int smu_v11_0_restore_user_od_settings(struct smu_context *smu)
 	return ret;
 }
 
-void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
-}
-
 void smu_v11_0_init_msg_ctl(struct smu_context *smu,
 			    const struct cmn2asic_msg_mapping *message_map)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index fe1924289040..4ca211ea628f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2557,11 +2557,9 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 void vangogh_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &vangogh_ppt_funcs;
-	smu->message_map = vangogh_message_map;
 	smu->feature_map = vangogh_feature_mask_map;
 	smu->table_map = vangogh_table_map;
 	smu->workload_map = vangogh_workload_map;
 	smu->is_apu = true;
-	smu_v11_0_set_smu_mailbox_registers(smu);
 	smu_v11_0_init_msg_ctl(smu, vangogh_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 177643df1aab..6b673eefc7b1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -584,10 +584,10 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 	switch (type) {
 	case CMN2ASIC_MAPPING_MSG:
 		if (index >= SMU_MSG_MAX_COUNT ||
-		    !smu->message_map)
+		    !smu->msg_ctl.message_map)
 			return -EINVAL;
 
-		msg_mapping = smu->message_map[index];
+		msg_mapping = smu->msg_ctl.message_map[index];
 		if (!msg_mapping.valid_mapping)
 			return -EINVAL;
 
-- 
2.49.0

