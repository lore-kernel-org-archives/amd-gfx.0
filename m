Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956C0C47BE0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C67D10E4C8;
	Tue,  6 Jan 2026 10:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oKJ392k8";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B40610E4C8
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omZcpUDw9yNue4r3t6ma+vOsC1cTwFLVIZgMJ496ImnyZAI9DSmqNTyFWiaoEiCok5zzJFgeFgkwht15a6IlDyVh5NNakXLuZAKJVTVVtqqFHspzHOySr4nIn+io6EkqaVCHTx6PrTxBv0243v9jRRsCFIPeQBwww6uvkUZFopnapErPflHkW/jlWbn2ti4z3Min8XHUsfRIL0aokdP7DZURm0pPKeXcvAk8q/q/WtDNv0xnRRH+txnPT5g2x6rzBnzI8a6qTlngWSCKOefjFkFJJgLYzdZEmKzUEOwrGotNnn20N+qtaUKpVRFTgMMJ3moh/QrGMwbfYsAs9Cgvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onCulCJ6wauxEPVoXatgUOB3urFEQCaWUM6F5TTLnZg=;
 b=pSZfPsgQO3aQVVNVXIqrEQdVvL0HjoLYE+1ZTY/Srzo16IUfNySBVVVoc4nuTlv06c8bN2MFRCXTj5l2Tuc0hj77tKORQQX5l4DZiPq0dw/a2dbqaHBZM++8x9nfyh5cUrFqCxNbT7DCp9mseY4rPZUXrb2IHOeLTEQn6KHfyYGauCksDQpk6UTAjIcFDnPdshLHujnS+fV3vqDjtr4gSkKpEdZ4c2bB+sX31TteXI6DRZK+tyV5I7rZp0fPgE+hGXQqZx8cEz8xojIxp6N0TPcq/+LPw2AkO1CvHbzcnNmkvMl/+fJpIHvPqC5iFExHn5hbl4GBPMp5N7k+Jr5YnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onCulCJ6wauxEPVoXatgUOB3urFEQCaWUM6F5TTLnZg=;
 b=oKJ392k8OK2m1cIbzk5/BqiaZjxM0PgmRrwaPEJa9y8QX1bPA7jVw5oPiGNaYlwavTi4KwEWho6iUHgSsAc9bV8iOV0ni3YY9p3RaJOAB1E8dm/Pk4C2BLr7vRUhQJGSFzNGzfo+xxotwq1LPo24Z/TNo93ruFx+cw3KxbHkJIo=
Received: from SA0PR11CA0166.namprd11.prod.outlook.com (2603:10b6:806:1bb::21)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:14:01 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::6f) by SA0PR11CA0166.outlook.office365.com
 (2603:10b6:806:1bb::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 10:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:14:01 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:13:59 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 12/21] drm/amd/pm: Drop legacy message fields from SMUv13
Date: Tue, 6 Jan 2026 15:42:32 +0530
Message-ID: <20260106101317.3856153-13-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: a1aaa17a-1dac-4cf5-c1af-08de4d0c504f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AGxU5SI9yYCyqXl0dwjTw6v8VBVu4QCNM1aZ/bznKmgFwwzodE85UV0WSVy0?=
 =?us-ascii?Q?t8YT+zxodisrXobaxJpgpA0dvAoBhH/uEm9KYYWcKahd87kOrgM8iDCEY1vU?=
 =?us-ascii?Q?nGa7Xzob7UQrofqv2gvsGrcs2+vtSW3E25EBPlD5uTWhfo3h5XrDgovYRQvV?=
 =?us-ascii?Q?6BBx1QSvnqH6sfelZXjR8z2NzHsyjpE7ONB+/cf55JFGco4HN2xBHQVbx+7V?=
 =?us-ascii?Q?Bx+NbpNzaiV7AJ6026W3xugTfcNtVpp3ia36AgUVYLlZUp/MXlLICKRtUXRe?=
 =?us-ascii?Q?Ao2BapTFV/ym6MQElcEy2h5VZqKO0P9W098pNTIMmYRBx/6Yc/JONIeWg+6i?=
 =?us-ascii?Q?msaxAJCl6ctt4O9QzHEIbLd3Zh0EMYYhr/POekvHwxaKxomzzZCQKoNzAhQT?=
 =?us-ascii?Q?KQI80TkR4sJ5bs3qYRaSyu19gXW7UyzwctomzcIcPRdDuMpNeUqySnO/TiHb?=
 =?us-ascii?Q?eh/KYiJsNsMEH+OrO1nPSShUUI0DXG2zqtxZ+YydzzJCffxUuP18UIedHtq3?=
 =?us-ascii?Q?im/MPNDzxIWS9zPcK8RBiwxu7573Fy9P+8ob9XfmIDYarVKX8pFuW8FO7cR7?=
 =?us-ascii?Q?dNfBT2E2lY9P3TVJ1uDmNC2+MK3Q0mDJdY3CEwOaxvELCiG7GCHD523ED2pP?=
 =?us-ascii?Q?o03iwy9cepJPGB+0SzJto2mg+7s5hJdE3HLUmRw+AIhH/NhQI9+8oI2GjIY+?=
 =?us-ascii?Q?TVxKjeMWk9lSv1mOBFc3INb+ebGb+w4Yc25AeDZz8zDgLTMkqhUhxkDgCBJJ?=
 =?us-ascii?Q?+h+r8s/mOqXRxgDwMdiO4dm3JJkwqsIuVCHeZkft1Fiuq4vrrgmztqHUz6zX?=
 =?us-ascii?Q?uqN6SwHBk0Wl/m4MLj4DLiDYHqkKpjv/u+YmT1bT8AyhggyDSdy60xyIl1R9?=
 =?us-ascii?Q?h7Je3YL4ZACXMDWpE2lIpuDbjyxhwl70x/L4nk7N9AwntrdxYHFfih1joi6S?=
 =?us-ascii?Q?jpZIYWn0kcBkh+ky4etyH6kG4fSbC4+Yd3EydiGXSvwUwY+91zQeYrwxXPNV?=
 =?us-ascii?Q?/N6Vi+bL4meD8xSf8lZ4ZLWPYuzTi9iHyoGxxaBSIvVKrN/X+D4/3r9IBRtI?=
 =?us-ascii?Q?18NOzLcBg88uSfPx8c3AEPB2P49zAoXt9G6TWkAYunoPe4c4WY/LnxmDu33d?=
 =?us-ascii?Q?9BwZbErxnRheYZoruwn+28P7SkZds8DRF2zmvbd8Eqj/JxKuUJbA2WzZsoz4?=
 =?us-ascii?Q?h/RblP8baGjXwZlzMNDrVYhBm4cRKafW1fKzDJR9bdQdlZxwzuG1zKKA0+6K?=
 =?us-ascii?Q?omxsS7oJ6IynbLqjxW/eJm/m1npqYVol51Nztk/5l5+XYUUi1p08cPacP1Nz?=
 =?us-ascii?Q?Wm2r7zl3KHpB9z8mwQ8GfMskoPrWv/9+DgU09spbdGSJ+cFCYNlqIarcMhey?=
 =?us-ascii?Q?FVQ67+kk/f7yXYTvuY8VbgPCvTPjExS6WENelepQ8aolpzLBmnNuWTSOr4tb?=
 =?us-ascii?Q?nbiJuUC6DKBsSRqmY4x4k/rllh1YxM2JuSQRILH//bvaLe8NzDw6uthUXCMq?=
 =?us-ascii?Q?kl2ZgzpDrfbE1OsOwA7HRtbyFhmOepEvC1ou4zhwFQuykdJd6nf06lKGhfur?=
 =?us-ascii?Q?cq3BUrxwhUZLSDXEFbI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:14:01.4882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1aaa17a-1dac-4cf5-c1af-08de4d0c504f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
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
index 128fb68abf70..37941b6c2831 100644
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
 
@@ -2895,10 +2886,6 @@ static void smu_v13_0_0_set_smu_mailbox_registers(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
-
 	smu->debug_param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_53);
 	smu->debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_75);
 	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_54);
@@ -3223,7 +3210,6 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
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
index d8f2059a1631..0375e8484b2a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2809,13 +2809,11 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
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

