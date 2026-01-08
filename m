Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB77D14893
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4108E10E678;
	Thu,  8 Jan 2026 04:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CLQwCnQZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012064.outbound.protection.outlook.com
 [40.107.200.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E48C10E678
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiIIX0b1uiWvflvlNWFK8/e2+RoirA7ZGc/oHgZdPBEOhyiwstpAE8IQBbfASK30JRLcm0HU8DpHHSkUDZ2lgtR2JgxGvRZp/icurgreL43oZ5ow5r3pIJEE4aUlPBI7hrISkiBHRUblYbDA0rlJoWZENEeMRPfPK0kr1xgESS1fOJ60IXXRvMuiD74c8mwcSTl3GrFpMVHVb4AWi9ehRk0OQDtQS5lLAHIRLH1LQXTNv7MYtIMraGIYXtbhTKs5oxwLOIpJDOsmeyVEn0GrCmCIYsTF0YxdarBFRwDPzRCgeNiCHKUrEcdYtepWoKToFMjnvqbG/fklfYVo8LN/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYYmYxSnw55xyDpd8fFgrAVkQ76RxnH7+1Vq8NyN10Q=;
 b=huued4ijfYl4pD09/Z8tKn3wfROskVDOKrtRpMmJ5Rk5omQaCCq1+GEw8TXo0l9SlwT3WmvChvyd2kVGrM0aLYqs7qw6EZfOuNut72xSykUPktAOqMSGTmAftMQSF/p7cvRQE/RVQUHwnHhtnjqecf+6Wq1Q78m+V4OgBblhN80zZ6TO8gAAQ4V8NCgaA/84/zCwQX1isYRh/VeNuo61hik47K+EW3gAY5jQapjPVW8Iolg0QWIVoqnvZzsnm92DAsrifj/HtAbgelnD00mFEXYqMHPmoil0bwilHfb2eoduBSzW1g/vTSJA02dNP9volow02eIcij+k0fwPu3Dj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYYmYxSnw55xyDpd8fFgrAVkQ76RxnH7+1Vq8NyN10Q=;
 b=CLQwCnQZbdY42NA8qogVU/sbjDyY7t1WGGDk+pmxMw9Z199ijthL3cgWB9Nj6iPNWGdQu1sU2G0CnjL2sv26lHDTQ4PrWyH5LKIhebzVxAGK4axbikR4KEcsWT4kZsYs9JdKaf26sjTFo0WzzPANaVlR9KL2wBIVrCrk/VenIBA=
Received: from CH0PR08CA0002.namprd08.prod.outlook.com (2603:10b6:610:33::7)
 by CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 04:49:17 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::c9) by CH0PR08CA0002.outlook.office365.com
 (2603:10b6:610:33::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 04:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:16 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:13 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 02/24] drm/amd/pm: Add message control for SMUv11
Date: Thu, 8 Jan 2026 10:17:18 +0530
Message-ID: <20260108044839.4084279-3-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|CY3PR12MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f8b200-0e9a-4f74-8322-08de4e71471c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HSoNp0o0jCnKvuZJWgGU36piA7MFothF8Gk0Ajx9cf61fsGePk1mf0n/ClZ7?=
 =?us-ascii?Q?ijxp2KXBVnmi3nJjFRaWOOjrvICODxyBbqPFPn1f6sSslRnRuuAZRg41Y/qq?=
 =?us-ascii?Q?j0oyFARnBzdA2t5QsEPNlpEiGYk+DgqvjA6I2KhC3SKLQ9TlPnxBoe5r3FYI?=
 =?us-ascii?Q?gfztGJiOqKeV0rOzSGApB6FsFdwV/oemtmrn9l04XFRkVizw2SQHykEO7fwH?=
 =?us-ascii?Q?vYKb9dX/9WNnn0yIBx9jBhGH0PLY2q78dX6qjEQ8wBeps9ca7qHlCfAQH+L/?=
 =?us-ascii?Q?908YHkltlpf10QuYKUKNMwjAJNQ93K6vL9onjxUDQLHPd3X95Lmov/7rPPfj?=
 =?us-ascii?Q?X2DeE/m+m1NriUJDagcpZi20jr6yTgBUunJRnYOO+MBD+Bmu1BfkxFHecNL0?=
 =?us-ascii?Q?1RE1IVu3Cd7qIkqefhVFplk1zrqWXigj2LKSJWRiK/qFQpFRouj8vCCFkMMl?=
 =?us-ascii?Q?ITL43DO8zJOoEKssj3XmmxVbTPYZrre+Fqc6tCqrRb14d46fIhSetPrT010B?=
 =?us-ascii?Q?Om2LEfsb6jpSIdQshsoJzR5iCNYQO64SyXqGnro28+zwgpeu2KC0BmXACHnC?=
 =?us-ascii?Q?LSljX4ibhRRaIC1AIy5EUwigkHfN6bq+srTST5Iaex2SiWdUlXZiW9ijypic?=
 =?us-ascii?Q?LjnNHQWqaH36w9XXj6DPImCQ5I0eDyadOxTVFknOW7yryjmxWf/YXZ1UNfl+?=
 =?us-ascii?Q?VKj/hKGTcqNiYRtt+di/YZfbwDLyUnqTka5ZrDPBNpwNFv0PKQbZ+xDPNVlD?=
 =?us-ascii?Q?lU7YgsI+4nrCyGI81S9NBu0Xeid6DUT9eF8/ZhdoOGQQjc+RRY2R1kL/xGk0?=
 =?us-ascii?Q?H3mkVqfivRCF5XqwiiFRoJkrCLYVNX0Wy4DQ5vD/ewFOVE6Q4NcGg0eQlb1m?=
 =?us-ascii?Q?RGoGm5sDmHENUMOOiptx7Nqf2iNmhc/YUKX/sX8TeoceJ23DQj9zEQSOqBtW?=
 =?us-ascii?Q?xWoNl9iKvZbPqRvX0mAvbTXG35BxpfOF2gHZoyrlnpsnR3qj30CDiMprctRW?=
 =?us-ascii?Q?TqoL4qicNlq7Wz8EGigm4iANcjkSrqhxavT8Mc6rYcsNx2PeXwVhINfFQxOk?=
 =?us-ascii?Q?uDRdLQo+igl0dHPrda0lY4Tifl0DocEuKiSTwJdY9CrY3/0vlu2WIh9WNJIg?=
 =?us-ascii?Q?xUeBqLDQqjeVtniAlskULuo4+NisCRGAPbL32suuT1NsAdfKl7Qs2fVObPPV?=
 =?us-ascii?Q?siSoj+mTAadraVTCJi5I8hXJWSaFaigektfRePGZktlL7R/WDGFfrqF/6+uA?=
 =?us-ascii?Q?LUTHbZhnKSiL7PJhheNYGjhfp/MxGpHX70DEd4yOewACMiU06hmQy1RTFdTO?=
 =?us-ascii?Q?lCVTeeJZaT+2aXsEiA+tIPz9TJ42KuY6uzGskpHWGfxKy/WYYW3LP/zVbmeX?=
 =?us-ascii?Q?GH+Q0CSfrDF+Y+368FiW/hNgRo70yucJ48zc02ftAu5omGCRrdMiOQjZt67m?=
 =?us-ascii?Q?4ZBrcX8dp3Wtgovc/bRiKELSRckTu3sj2xQ03uYXg8IfrAx4uvDP97oMiUxK?=
 =?us-ascii?Q?eGFlvEZJ44VFFDbugZ2t84tiWMjYj9NYmxMwn/7l5MnYTbjoLNlPmVQhOius?=
 =?us-ascii?Q?Q/cskfaqbzDGk+DxUaM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:16.3710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f8b200-0e9a-4f74-8322-08de4e71471c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9555
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
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
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

