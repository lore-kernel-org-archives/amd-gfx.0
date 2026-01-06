Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C79C47BE0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E13110E4BE;
	Tue,  6 Jan 2026 10:13:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kkuH6a/H";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011069.outbound.protection.outlook.com
 [40.93.194.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A096810E4C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:13:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2DSrlHCrFlJM+lyRlahKiaTWB7arpaHZ0gjK944nGsL17ayshswBDEJ5IU7IB1F37Thfp3U3AUxhs3IPWqCZfltqji/J6ZIx1XZ0NfjUmOJrP92kpvTMG9G7sgDMDzYPlD3u6WayEmQZ3ItC6/Bu6zLTO89FBhTb+8HLXpWEJCeOvO2vQWIcIcIbCxlBnKBN9wVKl10Z9lvOgsNh97Teb3zQ042YuDb5TpWrWngHPVz78Szsu/tVwC12QiSRgtbq1y0fpX34jWN3BBpXbAb7W5LU+TNGSFxlFA4lcO5zHMrH4UaB5rZUb4g72vn/IiiSxpIRA60WdGCpkyqRpP3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQnist2/SVEh8+Omq+e8lHc7B7rVQPotNukhzyf7jAw=;
 b=KDN5Ns79csAcXmG6EFHBxBpn/pt/9HPfa21xR8UhxJjaYKreICHrRUAxvAE6ICzE9pAe+bN401qewMwjt1ebTNVrFapUj1hl/0laeiV1qkQvl7sIiRjNRhAoAI3U+95f5uZLMaYtMOfG1FdW5VLyMR325kIYP5NpcoakH5cKCC6hqytdTmBThp2sVsfNaFcFWr2ZbtpiXtQkg6QRqcYtf+21nwgiYssKkxcDXF2Rt/KBYKqNWDfB9uqE/Jql6ctkWsaui36aDQL4oId5gPlYnxmlPHB6i4q8XLtpfEVIF+RmrxOIMjGr2b7aOa6D6AGlXxptorzCg8jXUvi0HSZhxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQnist2/SVEh8+Omq+e8lHc7B7rVQPotNukhzyf7jAw=;
 b=kkuH6a/HiuDy0ccIsZgtgiHelVzTdwv0eAvhF+79JOHWiSmRQptNNRs0612wxG3wG+aUKMfy/mIoPWx8L0T79IbMC9oZ1VCGykH76zVi3SfSMJDz4/gDhl5shba0s8yXpe2o0RuJ5BPEGAOVPWQurgNIIXIPPREm9gt6Kr1awQU=
Received: from SA9PR13CA0111.namprd13.prod.outlook.com (2603:10b6:806:24::26)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Tue, 6 Jan 2026 10:13:48 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::8e) by SA9PR13CA0111.outlook.office365.com
 (2603:10b6:806:24::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Tue, 6
 Jan 2026 10:13:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:13:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:13:45 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 05/21] drm/amd/pm: Add message control for SMUv14
Date: Tue, 6 Jan 2026 15:42:25 +0530
Message-ID: <20260106101317.3856153-6-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: d86a9fbb-a7cd-41ef-8e2e-08de4d0c4838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?66dt1J6hg8pIIWqI3lLka0oD31IKGN51sWaoVOHhISImRCmUg6BK17rIOK9b?=
 =?us-ascii?Q?V3Kc0L8FFVQQQicNB0r8iPipsVnosWc/URHVjTEhtDjM2s7sqqdhXly60eKB?=
 =?us-ascii?Q?BgnZaIxNu0O4LfoMHq9eeSFF9Zpr9iGbdLkNTWhxTIDHTJja1AysJwySQUiT?=
 =?us-ascii?Q?unlnuwJpd5lQFgsksvMt3jF1Z2HupSaf1NDF6YseOgNKdLhEHrrD94hP5vTU?=
 =?us-ascii?Q?sF9cQuhp8dDt8rdFPpYw5Lo6fbOMe8pLIbQUUQ+cjx+slW3Oom4Mn+Li2MIe?=
 =?us-ascii?Q?k3OEFlQOIfCbypyC23gJ3wx6y7PBS/LR5fb0PPkMPZgm2rcmvzG0Ip84pa/8?=
 =?us-ascii?Q?kuZy/DmpPuPMZqspXMeXNefKbEce89G0bGetKKXD3IJQ/mKzCcwhpf88WgkJ?=
 =?us-ascii?Q?gmKcjebG4ITekPlBBQK5KH6k9KvkB0c3oUdEzsURbbZDkPlxsqcDtfSu6zmW?=
 =?us-ascii?Q?9fOrSi5BObP9XTZxAnvXNvOzatcE/rUjik4KlYNdy6Rm95cLbL8eOkXS3yXd?=
 =?us-ascii?Q?CMB8/tOOjRHX/S8MpYSV6BJmf8Hs3JexklLeToDcwmduUmXtlx3qA1eTrtm/?=
 =?us-ascii?Q?ReDCwPWmbjWtw/hT7hJ/xrZ04aM+dNHS7OAH8JeQSAGmyb34cV+OB5IITnb8?=
 =?us-ascii?Q?rg6dmKsog4tIS0i+GZkBeKrYY85sfXZSonk/hn5POL7E0iVqLWrJOuDmUrDJ?=
 =?us-ascii?Q?yzJM08yhI+ekO6GSr80bJeVsEzrY3B/33w+z+qGqjcG/yYHu4JR5B3ppOPe8?=
 =?us-ascii?Q?MVB0lzSKYP4VEL+L7lqC/c+tzwsQq7vS+AdPdIbtu9K5B3WlQpJWjp9NaqQF?=
 =?us-ascii?Q?G52aAF9QrkGl7NdyGaRIikAaHg2k6pZnwenMFDh/sdEXSxkX3Skv/TEjUIQi?=
 =?us-ascii?Q?qNWkEBCCAj9U0PwDSjxPe/C2AVVlTN/416ZjW4FvtQN2TZBt5NZdUR9PPOcM?=
 =?us-ascii?Q?FfMITJrKXREhiP6/qk7Rp3g4VdVsxGiMhCxzNX7v1i5FYYcLLZahtweKlx+r?=
 =?us-ascii?Q?QHv1Acrlo7K62eg5by8OLQMNZLXqFmlcnG162IVeHoauCZlZWxLrcg1ctQuj?=
 =?us-ascii?Q?uB1+FTb3wYFDmKROeaYfRS604qr8RC44oytK2ogB9ubpSP76XDP8N7FI7RKu?=
 =?us-ascii?Q?X+cKSXYid6tOIUz4q+S9OWzmAWjfpFsYVqaeJsJNoOtwQxHpfOwIql86TLof?=
 =?us-ascii?Q?SpnTvcuY8OuZO+Veu9ZD1tQFgYGh7IU18brA0GBQRRK5b4zkvJ+hUjm8F3w6?=
 =?us-ascii?Q?qXaLcCBUUV8gQvxgriFYuMB8fDB8+JpHPS/+nroCa8g1FBxqMgQUXeYUhk9F?=
 =?us-ascii?Q?x1Qf8u8B/64ud4BI+8rtHBHPTuwQTSQad7KpVuxK2JaXgqoQYm23D13GqIXi?=
 =?us-ascii?Q?dh9+Hswz+vlCGB9d580J/fubHiAyjBw2gltN5XA7jpb4S3mfZMI++dgIyTdK?=
 =?us-ascii?Q?fwX5JY9qxBmdJ/AC2Y22Cu8XdD0zFsZoHWMp0gA4+n7UagcdmBDvPptDxF/u?=
 =?us-ascii?Q?uxoEl6XDY9fgeUSJavZEbwRHyLil9ztZZWhavLoTcsJA1/ekh8mgeT/EBPOi?=
 =?us-ascii?Q?gnGJw7c0fJqj/b30o6c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:13:47.9147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86a9fbb-a7cd-41ef-8e2e-08de4d0c4838
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
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

Initialize smu message control in SMUv14 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c    | 17 +++++++++++++++++
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c    | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index ba895ca4f3e6..9c15fccac2b8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1740,6 +1740,22 @@ static void smu_v14_0_0_set_smu_mailbox_registers(struct smu_context *smu)
 	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }
 
+static void smu_v14_0_0_init_msg_ctl(struct smu_context *smu)
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
+	ctl->message_map = smu_v14_0_0_message_map;
+}
+
 void smu_v14_0_0_set_ppt_funcs(struct smu_context *smu)
 {
 
@@ -1750,4 +1766,5 @@ void smu_v14_0_0_set_ppt_funcs(struct smu_context *smu)
 	smu->is_apu = true;
 
 	smu_v14_0_0_set_smu_mailbox_registers(smu);
+	smu_v14_0_0_init_msg_ctl(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index b1fee26d989a..5bf10555effd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2120,6 +2120,22 @@ static void smu_v14_0_2_set_smu_mailbox_registers(struct smu_context *smu)
 	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_54);
 }
 
+static void smu_v14_0_2_init_msg_ctl(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	ctl->smu = smu;
+	mutex_init(&ctl->lock);
+	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_66);
+	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_90);
+	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_82);
+	ctl->config.num_arg_regs = 1;
+	ctl->ops = &smu_msg_v1_ops;
+	ctl->default_timeout = adev->usec_timeout * 20;
+	ctl->message_map = smu_v14_0_2_message_map;
+}
+
 static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
 					   void **table)
 {
@@ -2866,4 +2882,5 @@ void smu_v14_0_2_set_ppt_funcs(struct smu_context *smu)
 	smu->pwr_src_map = smu_v14_0_2_pwr_src_map;
 	smu->workload_map = smu_v14_0_2_workload_map;
 	smu_v14_0_2_set_smu_mailbox_registers(smu);
+	smu_v14_0_2_init_msg_ctl(smu);
 }
-- 
2.49.0

