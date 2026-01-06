Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4C4C47BDF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFE010E2A1;
	Tue,  6 Jan 2026 10:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F7qaf1N+";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013045.outbound.protection.outlook.com
 [40.93.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0755F10E3A3
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7IoeAsr9obfQ56mJibZ8QPR4oEDvdxWcTlAVXmA9YiZHWmpUxUVvodC17yamvAW6j10IfGJQop2buBdneXtk05rYQr2PNInBIB5mE7cAJOqOcGtU/uDxoq/SbirGq+51Iv5oRcWOlaUA4eRqpZReOeh9T6u5aZhSf9V92+uTWt7BZBE2vl8+Kbpsd5oPRZma2QubDYS6BxCpy+XdWsuF8mPMy2amgbylngWQ4wa/UgsQXW6WNJzWfhMggJPlzaXIgeDdPl/4BpstCWeCp1mH9W4G2+Lr93vPK8SRc/5mQ+AOO+nrL9Wu7P6DaAbxGsQLmK4bCBD2ovU+fREQJZONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXxMjJWg8VGhj17zvQH4J6mDqzxySIhA6j/J8JgW5oE=;
 b=qCF+ggoYnY1jvtDTUmJWmc+f7eMUtYR+nLIjOfrXR9eU9FXAxQcLNDrE3RnzNffIjhGfwDarlnyuxbV3YHuaRndZspa2JwFaY50TqSpkzy9ZKTYcP15PrttPUa4RDW/Ddba5cNJfAa2Xg8Zwpg0iojCozeIX2eQ64Nd5Cq7a1bv/AzorLAOWj1gIuZQOW+PzrIfRHxKQ41P5NxWOsPMa24b6AR+4V4jmnV9z3TVuhWxjOQalOEBnzbC3dTt5M7iy3h66rs31HmWUq2qBRLwYSJ+07n3pEJ1w/ERgywHLIFsyD6pp6Mm3W2zIM/yiYZEpsG3luGOEdhTdQLJHETNxtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXxMjJWg8VGhj17zvQH4J6mDqzxySIhA6j/J8JgW5oE=;
 b=F7qaf1N+HE75Ni4gV9RSb/GyV6+J0YkBuALRmlnAa+em/QCr/nw9MMSqx+p5OHX0qsI9TB/NDUCAnEpCdq/xtRGVuryQwGjBioDxWDSwYeQuGDFdOMXV3Ywzq865z43yNMzWRwax49sJdQHB96O9TMS1eI3HxGD8H//HAp2pbM0=
Received: from SN6PR01CA0029.prod.exchangelabs.com (2603:10b6:805:b6::42) by
 DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.5; Tue, 6 Jan 2026 10:13:42 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::72) by SN6PR01CA0029.outlook.office365.com
 (2603:10b6:805:b6::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 10:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:13:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:13:40 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 02/21] drm/amd/pm: Add message control for SMUv11
Date: Tue, 6 Jan 2026 15:42:22 +0530
Message-ID: <20260106101317.3856153-3-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 07973b0b-e943-4e66-7e1a-08de4d0c44c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sur6Agj6D/xRtE6CelE2r2tQDBYYhWwHOHg+lGamr8Pmln8eBFwXxVtrl7Hf?=
 =?us-ascii?Q?5puovqZa5erfPE8ch+3i9Vvkw97FNUjDUk3G5mue1k37f4f30M22o3lAMDtn?=
 =?us-ascii?Q?mfKc9fUHG/9bFJSvaS0vCg68PTdmrT64gCX1HYuQw9GhU/BkC/0iu+N2OJI8?=
 =?us-ascii?Q?Wn8kNocm98UNyPvPpWyKsqSmpr26KLTSk3oTbOF1Kk526GHL8zUmQbbDOap+?=
 =?us-ascii?Q?7OgPTpqPTjlpbXY/IwjumigKoMP8mTXlOIFOd9SL2U5nSMozLgx8fF0TOG6l?=
 =?us-ascii?Q?fVqPh4xzLcEU0pexo2ZONReTcxZDJKfbfwGuMZYu2jAupGBC1KjrhLSMMU7q?=
 =?us-ascii?Q?4ID6xxmVB09smuUdEl+n02ZRccMyckseQl5PAsUzf2FbnSIMd6EFZhIGSvb/?=
 =?us-ascii?Q?vNN2D85BDt2LOeJdiDZW+imAmZ92GmTsBUQ0NvBbT/AB5RtM0OUAz51nYzac?=
 =?us-ascii?Q?4UK/86XCs6TZ16QBKwkRHI2auRKF79K1V6s9Sfi7r+d6j4VuxkRb1dGt9xOw?=
 =?us-ascii?Q?UCGcREK8aHOHFe9EnSqpdcy1lFKY5KbpOsVnTBuJlGRTScZD3C72eipPlR2j?=
 =?us-ascii?Q?p9fbfKaiG1ldAdyW0n/Rt0Hsy0WQEG2bBjr0bi4W4DT3nMtNZwXVtvSAJ+ys?=
 =?us-ascii?Q?WPHqtu8iCoW3UMmj5TuniJZUDW/X1IrNMbrwTe5dznAjxHR7MokGzGAacvGN?=
 =?us-ascii?Q?ys58rx8/4r0HXplxQx+VON1DNUvIYT8WgJCMtTWOE29lyFSw7dPZSgsIA6y6?=
 =?us-ascii?Q?0FiLzH7LdWsqs4A06OMUu7vnRYTK3QH9znTw1DICB5f8tkDUMND7ukFnJC3A?=
 =?us-ascii?Q?/D1uGj15Yl7mpkvQ52ppq7zZTe/xk02kLddtLiXyDRsIOR9/7rpO/IuVAn2+?=
 =?us-ascii?Q?mjVRYA64KLFHbLhtgBQ4VmNqPExmQ0DtOdV5VSNjl/3kpr+5ylN6DAfP30bx?=
 =?us-ascii?Q?NUPq7Tky3fgN2kl7up9z0TzeVKDL9WvqsMKwGi1pBo0UjEhNnsYs7CMveRwK?=
 =?us-ascii?Q?zoQpLISftIMzikzmZCnZOnn9xKs0amrQgALPPsKSWVyYn5iDM5fz5aHNV6bf?=
 =?us-ascii?Q?lXxZvWpR6Kx7h2Xmnied0iMpV6XM1jBvXqDhvFYPdkhKEwOYmksKiH6erZX0?=
 =?us-ascii?Q?H5X4FGO8GCLZAPU1YcQO/LfXnNIAAqqWAV5QQXimLKeOEP+ly3lcd1TDTadN?=
 =?us-ascii?Q?E/qU+UJPc/bOyUx84L1XVs96z9fg9I/uqx97Y0w8IHnVW8O290Df94sse3XX?=
 =?us-ascii?Q?F8lYSVjRQZU5+RmJAdTVmXSaUbCEYjciE0545EEV84paQC4c0g+pes6zWzHr?=
 =?us-ascii?Q?HY4i018DxfxF72eJPdjb9QC/Syqth3WRSwqWHT83pKVci2ZcUyitFxAH3gFw?=
 =?us-ascii?Q?6C6kuiC5fDQEvIo2Gbgi5sa4YWcVjPJ1eEP4tA5TDbwK6TSQQfXeQOEqDcs/?=
 =?us-ascii?Q?+lYKvw7yrph0gU5zjVy8lo5t2qQieD+QKh5q2pbzbOrt8iTaD7MqCAP8GaGj?=
 =?us-ascii?Q?JDGv3MYOVaGYYDEGYBT8mHljYCYd9m7sTpU2U77VQpcL5Z0n/1YM4PgumiqR?=
 =?us-ascii?Q?NzcQKedBbWZmVlBOPSg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:13:42.1070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07973b0b-e943-4e66-7e1a-08de4d0c44c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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

Initialize smu message control in SMUv11 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h    |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c   |  1 +
 .../drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c |  1 +
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c  | 17 +++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c    |  1 +
 7 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index d18934c6fbd5..97c19005952c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -283,6 +283,8 @@ int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool enable);
 int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
 
 void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu);
+void smu_v11_0_init_msg_ctl(struct smu_context *smu,
+			    const struct cmn2asic_msg_mapping *message_map);
 
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 81241976b53c..eadd81e413aa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1966,4 +1966,5 @@ void arcturus_set_ppt_funcs(struct smu_context *smu)
 	smu->pwr_src_map = arcturus_pwr_src_map;
 	smu->workload_map = arcturus_workload_map;
 	smu_v11_0_set_smu_mailbox_registers(smu);
+	smu_v11_0_init_msg_ctl(smu, arcturus_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 51f0e299b840..5ae6ee87de04 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -605,4 +605,5 @@ void cyan_skillfish_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = cyan_skillfish_table_map;
 	smu->is_apu = true;
 	smu_v11_0_set_smu_mailbox_registers(smu);
+	smu_v11_0_init_msg_ctl(smu, cyan_skillfish_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 74f24618485a..3596cb7f8adf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3376,4 +3376,5 @@ void navi10_set_ppt_funcs(struct smu_context *smu)
 	smu->pwr_src_map = navi10_pwr_src_map;
 	smu->workload_map = navi10_workload_map;
 	smu_v11_0_set_smu_mailbox_registers(smu);
+	smu_v11_0_init_msg_ctl(smu, navi10_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3f3947dc52a9..9ea6b0d1954b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3189,4 +3189,5 @@ void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
 	smu->pwr_src_map = sienna_cichlid_pwr_src_map;
 	smu->workload_map = sienna_cichlid_workload_map;
 	smu_v11_0_set_smu_mailbox_registers(smu);
+	smu_v11_0_init_msg_ctl(smu, sienna_cichlid_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 3d03010abcc1..579b1dbd36ac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2176,3 +2176,20 @@ void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu)
 	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
 	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }
+
+void smu_v11_0_init_msg_ctl(struct smu_context *smu,
+			    const struct cmn2asic_msg_mapping *message_map)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	ctl->smu = smu;
+	mutex_init(&ctl->lock);
+	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	ctl->config.num_arg_regs = 1;
+	ctl->ops = &smu_msg_v1_ops;
+	ctl->default_timeout = adev->usec_timeout * 20;
+	ctl->message_map = message_map;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 65a0302ce875..a645094b029b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2569,4 +2569,5 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
 	smu->workload_map = vangogh_workload_map;
 	smu->is_apu = true;
 	smu_v11_0_set_smu_mailbox_registers(smu);
+	smu_v11_0_init_msg_ctl(smu, vangogh_message_map);
 }
-- 
2.49.0

