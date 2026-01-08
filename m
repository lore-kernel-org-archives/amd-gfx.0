Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA522D1489F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9296510E684;
	Thu,  8 Jan 2026 04:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HVx4AvTm";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632B210E684
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEBkeVIWULRkOE0QAe70VlGCtUCMBbCdmVY6GVet8xS8JYn2rawSRAPkxWq/b1/LyjVigy9ZV9DSnGVfaU3VDOLaawTClW6sgLEVs+oMei1rbCOohhEuMDMP/kXz3Vx4R1PvIXJ2tTdpdU2srrzV0ULQUH3y6VxZTZo1I5LHvZy7PTKyN3JG9NMAG18dWXuh3fRdOnVh1Cdjun5gD+GBQEIeQiAvSKwIEZ/sAoVdTGFOf/K3d9Q8h+Dz2GI0QMaWN5gR3BjDZJq+H1yGqTwlWMxwdFOsePILO9MknQsPV9QC5DucXQjIi12wJ8jLLe/jOjaQxbnuCFL4CWsmoSiXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcP1FkH/45eHHsCo+/FuiCCBR2XpT7WTP2eSUV/heeY=;
 b=jlMS0My1lW8FVh20SPYMgwrofuhN3EbD8njIpWxO4WrxbO8G/+8sLb6xAzAPkHT55pt3f2wOu6sNmC9p+F8i0A7IzZ6oDilChp+gcfTsEcDKk5HvYWBYeDr/Hr9UnI0VGy51vFNnL5/+H/VSbxOG8j6uKp6YXRGB0zM1q6pPHsVyht84Djt9nfLI4Tue+gNbX1qCPryH9sUpUWxOWjOAF3DJCUpz+aqyWcTkXmvHaVMVxaKogjzN5Dq/ahjeASLX6jG21wzBKn03AdTOtqijshViYkVUSpk5oLangCDs0YBEoW1GUY8VNRjZ94RR4zcWkRecdjc88fDfr/0F35wpaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcP1FkH/45eHHsCo+/FuiCCBR2XpT7WTP2eSUV/heeY=;
 b=HVx4AvTmUzLJM2gWamoKwBB4lOLK1sT0NPA3pwDmsgpuOz9mY+rJXMBJ3dR9ktFldCJDKuqf/FN/zHKpZRubkh+s7/cnjUGqavqlbmS5+VUfgyIWu+FHXY9vMGUgyDRRsRFtEe2DgSw0thz6AIh+QJHIYp14J4p2YRTzFs3SEo4=
Received: from DS7PR03CA0004.namprd03.prod.outlook.com (2603:10b6:5:3b8::9) by
 PH7PR12MB7187.namprd12.prod.outlook.com (2603:10b6:510:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:49:43 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:3b8:cafe::1a) by DS7PR03CA0004.outlook.office365.com
 (2603:10b6:5:3b8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 04:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:43 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:40 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 13/24] drm/amd/pm: Drop legacy message fields from SMUv13
Date: Thu, 8 Jan 2026 10:17:29 +0530
Message-ID: <20260108044839.4084279-14-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|PH7PR12MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e610cbd-f3bc-47f8-7d8b-08de4e715721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nj4BipD+cFlw/9HtepXDBKdVOzdAPbeeRPIfwtY97VLc6fuTVL42JjFpIgWV?=
 =?us-ascii?Q?dnHowLUOotNnFPMqg31Cuctchc6o12LHfBHOqCoGAAYTKuLo1N+rOQIjljZX?=
 =?us-ascii?Q?n4TpDIcCGkM828QLCCGOfiN8hLpmoCZNy2JQ0OT5c6+9fetlE2ic7PJdkruu?=
 =?us-ascii?Q?4RHYxuj7Q3h90pjUXcbjo5Ovzg8EU9CvF9BDYWCj3uQlQtwMVuiPR+snuPZt?=
 =?us-ascii?Q?G6+FQRmC3XPL5ZPwTasYy4K8VTGFMOaX/+coofTFOnvoSXfkWJ5VKsTzkrbV?=
 =?us-ascii?Q?HOMikXc0NyM20Y021x0jN3b8iDPA2QuAmJAA9SDBKl5aAyNCP23a/SpwcibA?=
 =?us-ascii?Q?8kWWBluSr8H4CDA9TXCR7hojNxust1gRcy88qrRBDMgmBPJaWjIQed9dst3a?=
 =?us-ascii?Q?gYkOjxchgC+TGM0kp+C0mSh+qPVatDdYxLbaYLV0Iq0VCUyq54F/nU8rNDEs?=
 =?us-ascii?Q?HMoy6n/w1Wrx1vTPAUrZl4athjGv+E687630OjfJ7YUYljNpw4Vh49MOQQt7?=
 =?us-ascii?Q?1d6RdDtLbNdD1OtKTus8xZP/r/Z8PynFBij4g7Qe81e3pxvIVKjU0iR4bw8Z?=
 =?us-ascii?Q?OEzQ2DbhczZT/G1DZGrl5rmdWjsHxIiyOaoOGl8xR6BObrk4wlMW+Z/B++W4?=
 =?us-ascii?Q?rAJUvcyJGIUvDJ92LNMCOw78I4KCd3dEqOqOz6nvL+CokxVkXCKy/xUuniIa?=
 =?us-ascii?Q?WAThE4OlLCBqg1k4j9lkNFQRyqAdY/aoRwrty7nwSyVhMoBOC1jeLRtJG+EK?=
 =?us-ascii?Q?IdKWXBtL0P8lmOvWMJ3C8KYhcn+3QBJ2szHX3s+4EEWzeHlRSIjNT4E205o/?=
 =?us-ascii?Q?0xIMi2wQis5RjIl2WFtL8R6H8l3pMFe4muwWYqRgOH5Vns1jKR/axRnjizRi?=
 =?us-ascii?Q?dY8TxGy3voU1FMKvFSC9Rb7+CF8FJ6rjaRSHnjx1gnSjZR9dd8UBN2At0y8h?=
 =?us-ascii?Q?X9Uk52e1ha4MRPuEOvap8bTswGdHCxEY1T3RpH4h55ReGAQj7fmqc5rM2XKB?=
 =?us-ascii?Q?+r4avkGcPHghHHr/RVyUL25puz1TTdfLwNLTAw1xIOWhyVm6fGuHYTAtXOVs?=
 =?us-ascii?Q?D4/PAOMEJYS87QHW3alwv2xmC90WPla6F4V3Qk7oQVFlISIgTIq+uJl4JrXf?=
 =?us-ascii?Q?+vdZryRPGoYsf8lOr+JmmJt0sdNtUK04hVu8aKo3TDmS3yiMUE9+3QALO7At?=
 =?us-ascii?Q?IlvIedE7S+5+KblMB3yZcTg7YjrXxkJZzVE66t3fZslBSuEj0Wdbsjo6CeB5?=
 =?us-ascii?Q?QUmdykRauoaLy7H4AAtkjI9YrEKzy4LYyeo0UeFVgEvci415d+00BN+0g9dl?=
 =?us-ascii?Q?zqhMP+o/FQIU6mN3E6IraNX2D/qNvnWQQzCZaYtSO60y2C2FlU/+zUobdA0z?=
 =?us-ascii?Q?XxOplHHhtGDjuxWptuGvTrOslJfkwxdA7c0qTuHEB295jDpYZmFOfPoiAT2b?=
 =?us-ascii?Q?Xt+4Bu8kfEqP5CriaxUhAuME9pVo6j8nAg2JEu7+R2ZUuBSWdf//+R7bpJkB?=
 =?us-ascii?Q?bDXP4daDcZ8lZ9+CmIjQeltPh0GBCLtNU+E7Ixsd8agg1H07QNV4Fg2gY/F6?=
 =?us-ascii?Q?zd6H1+Ip8perdV2eoOQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:43.2480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e610cbd-f3bc-47f8-7d8b-08de4e715721
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7187
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
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
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

