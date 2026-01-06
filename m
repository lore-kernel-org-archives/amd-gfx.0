Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71373C47BDF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14D6210E45F;
	Tue,  6 Jan 2026 10:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kv1u6+yq";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013048.outbound.protection.outlook.com
 [40.93.196.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60AA310E4BE
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:13:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Swi5zaf2RDplkpF9AjvaxXAssPv0nYr2ia9x1D1PMBPYNncRU4flw1GFGkXUwJ1sGHce6E6H5qWLsrN9+X3gK8Sth5TM7M+3jaXlCa+a83T6LuSoXjzfXnsbkCcm+G56X6M4RYFY9YG2Q1H26AUicmW5OFpE+KyyUpbIVjj/w3Dy5mzsap8XYdnyhw3UzG02v+ty5fq7oSFDDuhaIuUvVOsY2Kaml17QTvTw2laWNBEWkrqWke35iKPW5z7n5y9w76VGo7UyBi3ARskLH8GNQ7F/Xxbrfbvv0Pib89Zmcb0hx+ajVaLEXrAF8Tf/T/GcmpJz3xi68a4K0dHWihODDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TriMA+99eE9d4eHqWK8qijB2dwq/agGXg3E4wpf58vA=;
 b=lLuW8m9mt61kAMUwvzpV2GkFcOe6oB087Mkgpx4fMlIafGIFqpkcahV9K4ATl8Mj4AjLZATN8v2FrRYRAjsJLn4/23FVM/lrzkPnp/5cJ4NotOiQyYfaF6VsIlk4Ad12vJ28d6y4ssBXNdAHFg3L+0etoCSjq+k5yT1dsRAVt1LIilwWealxJ9uw+PEJC9vyYRqlLbOl7/zqm5gReePtaokQ9Nx14KEgEEPJE4/zqYIbIxFIrENQ0feGk6ZzMvw7zkqymtvu+3emb2sloroLM1/yQOM14t292VBhJaDiE0mTNB9WFF6QL7a+CvIzjEMHgJzq4fzObLaNSRDrQGQ/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TriMA+99eE9d4eHqWK8qijB2dwq/agGXg3E4wpf58vA=;
 b=kv1u6+yq6imO3CIuOUYrDW5UmhWWF/2QzdPJGrK4u1TZtg1xuTOkZocn9vOVtCUr6meGUJa6F+q1DuDzh3begax53oZr9LIwyaacMRboMgUOCDkuDIjp+GDfZz3U9qEniyxt+RfeK6rh1IJeQjVBowd7EQr7n+Bilfp6xe1lMU0=
Received: from SN7PR18CA0015.namprd18.prod.outlook.com (2603:10b6:806:f3::6)
 by SN7PR12MB8058.namprd12.prod.outlook.com (2603:10b6:806:348::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:13:46 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::3c) by SN7PR18CA0015.outlook.office365.com
 (2603:10b6:806:f3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 10:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:13:46 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:13:43 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 04/21] drm/amd/pm: Add message control for SMUv13
Date: Tue, 6 Jan 2026 15:42:24 +0530
Message-ID: <20260106101317.3856153-5-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|SN7PR12MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 666f098a-01cd-457a-88fb-08de4d0c4716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v6C6cg2UUjhXGo5bxcYkccEOL56lz5WZJ/VdZrZ+UsMow9GPDTiGPCNHrEcJ?=
 =?us-ascii?Q?iXSkcjJig+Nz33VhRP9y9WJbY/w6LBI3jc9rTjV9JIFQmrwyJ2e6UijOMz/g?=
 =?us-ascii?Q?D+HpMaqYNg2h7mShcQ8ZWhfXM+f8lOWB7UP4bQkP4h32I1laA3AIiM8G9PTr?=
 =?us-ascii?Q?IPLAcLxg0yYKdDjg4ujPmvypgMrKQeVvX2VAE5/jh/0cum6iYmEyuZdOj6ji?=
 =?us-ascii?Q?pSX/0lOMpt2yKpTyVERJx9uAK1oFbXeQcfl3HIvzyQ/q51K1ReQ32RpkFVgM?=
 =?us-ascii?Q?zYpBg2n+6fAQWLZU89wNpui+aHvwFqf5/Y6rfGy6EiBFy5bQBOdBzAmBB/Ec?=
 =?us-ascii?Q?zdsTBsJ2ie++uMaa15Z83gxdfVKW4Ryrjjh12bJE6oXrWgnHsMyj3Uekb9Fr?=
 =?us-ascii?Q?AXjy2qJg8+UpvJPqCbHdDBGpXUCD24hgCd3iALn6s1uAD0tBvcR2mrKmNUli?=
 =?us-ascii?Q?g8OeUv0/zETFS6oMsI+Dmw0zAj3ATyN41McAGdk26uCfbFfCz52tQxkFfyvI?=
 =?us-ascii?Q?SUMmpixfD9BznV+2U+M1UFGKhd8U6OpgxyS40XoWmDjM/9TUJZJQRPfctq45?=
 =?us-ascii?Q?qke8IWJYBL29+41wP8Oeu4T8UqTvqNkoHjOdw7i9rTa6dI1tGA7KZMSnHAcW?=
 =?us-ascii?Q?Y3ffp8Z4dD0nU4A13MlXmwXQ8ugZ2RlflBgpRePEWkeRfjf2lAkM6RNOAsum?=
 =?us-ascii?Q?kEwtM9cHScyBW6DZ0GEVReVoKSQcloCkTQrW72GEpfr4a4k9NqPpga1KTdyf?=
 =?us-ascii?Q?se1FVAgVU4PYOCsKbgsUg9THi8w0NCbyI72LgM8Men6bCRNxRke8XGa23Hsh?=
 =?us-ascii?Q?oq7MjwPFVK3gq5TX0aqQEk5cGaLkJpkdHcUAi9SiozJMcH654l94+L2zlkq7?=
 =?us-ascii?Q?NjSlIWnNJpLm/rnTHYb0a0b4EKA7ijjFz/jje+rSVQLij+dkDB2YvReAUGya?=
 =?us-ascii?Q?kOmLRbfwF4cQEBgKGj+S/ynvhUXmfoUT91UAPlBnqDftESXgS+4fr3yNFzAd?=
 =?us-ascii?Q?dZPO5hbi0zLzCKKVwp/oWHUapjcYHaKqMWD3MGFMbGhDCQxVjNMYwW+nAaVf?=
 =?us-ascii?Q?rr8ECcG6vUrpcA/t2DkzQsaDSGVfBdBHX48muOeXu0QaPQyxmy0R9cwkasjC?=
 =?us-ascii?Q?J3yUEmu5n81iJ2ftjgItmlFTo5n8dv6zwZxRswkJ5Cc83y/90xcvnHr6SyFg?=
 =?us-ascii?Q?we+iLLC4aLYj57aRBBtKXyFgKZsV2npMVvUrKzIBav3LLqmeA+PPFGKxXX1K?=
 =?us-ascii?Q?J8/5qBPv3vQEuz3LNUQII59I7PF5gcnSiwzAyTsOrbVSksKQ+17LU9VjpVEh?=
 =?us-ascii?Q?iblheIx/vPQowlVInLqd5zPDafOGJznP5jlI5HO6EFh8EgHzK4gLORGSpi1w?=
 =?us-ascii?Q?zT3+Dhwv01sp/edqz/lmdyiuRf/VLbCo4VJlAZT4P+ReRmmQl4f48gQrcI1N?=
 =?us-ascii?Q?QqjiJEvVrZTmcQGPxJApX4da5HYyOa9jCMBLNSEZtY1ui840hMKHH3oE50k0?=
 =?us-ascii?Q?pMZ5fpq/DNbTPodSWbe7lWmMoyLLycKKvth13ODze/QpScYr55Sej+YkaGUB?=
 =?us-ascii?Q?mMApeGROmBL9jAea5nY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:13:46.0097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666f098a-01cd-457a-88fb-08de4d0c4716
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8058
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

Initialize smu message control in SMUv13 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 ++
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 17 ++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 23 +++++++++++++++++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 17 ++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  1 +
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  1 +
 9 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index c35cbb2aee93..fabf61e15dba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -252,6 +252,8 @@ int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
 int smu_v13_0_set_default_dpm_tables(struct smu_context *smu);
 
 void smu_v13_0_set_smu_mailbox_registers(struct smu_context *smu);
+void smu_v13_0_init_msg_ctl(struct smu_context *smu,
+			    const struct cmn2asic_msg_mapping *message_map);
 
 int smu_v13_0_mode1_reset(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index e999ee7d053e..a3f4b25ac474 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -2038,4 +2038,5 @@ void aldebaran_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = aldebaran_table_map;
 	smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_ALDE;
 	smu_v13_0_set_smu_mailbox_registers(smu);
+	smu_v13_0_init_msg_ctl(smu, aldebaran_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index bf00ed3f2848..e5996162fd5c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2357,6 +2357,23 @@ void smu_v13_0_set_smu_mailbox_registers(struct smu_context *smu)
 	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }
 
+void smu_v13_0_init_msg_ctl(struct smu_context *smu,
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
+
 int smu_v13_0_mode1_reset(struct smu_context *smu)
 {
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 91442e39aa79..128fb68abf70 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -3231,6 +3231,7 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
 	smu->workload_map = smu_v13_0_0_workload_map;
 	smu->smc_driver_if_version = SMU13_0_0_DRIVER_IF_VERSION;
 	smu_v13_0_0_set_smu_mailbox_registers(smu);
+	smu_v13_0_init_msg_ctl(smu, smu_v13_0_0_message_map);
 
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
 		IP_VERSION(13, 0, 10) &&
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 4a99f585f071..d8ef38535fe8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -1133,6 +1133,22 @@ static void smu_v13_0_4_set_smu_mailbox_registers(struct smu_context *smu)
 	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }
 
+static void smu_v13_0_4_init_msg_ctl(struct smu_context *smu)
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
+	ctl->message_map = smu_v13_0_4_message_map;
+}
+
 void smu_v13_0_4_set_ppt_funcs(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1144,8 +1160,11 @@ void smu_v13_0_4_set_ppt_funcs(struct smu_context *smu)
 	smu->smc_driver_if_version = SMU13_0_4_DRIVER_IF_VERSION;
 	smu->is_apu = true;
 
-	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 4))
+	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 4)) {
 		smu_v13_0_4_set_smu_mailbox_registers(smu);
-	else
+		smu_v13_0_4_init_msg_ctl(smu);
+	} else {
 		smu_v13_0_set_smu_mailbox_registers(smu);
+		smu_v13_0_init_msg_ctl(smu, smu_v13_0_4_message_map);
+	}
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index f2e3c80ee203..f351880a5e97 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -1126,6 +1126,22 @@ static const struct pptable_funcs smu_v13_0_5_ppt_funcs = {
 	.set_fine_grain_gfx_freq_parameters = smu_v13_0_5_set_fine_grain_gfx_freq_parameters,
 };
 
+static void smu_v13_0_5_init_msg_ctl(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	ctl->smu = smu;
+	mutex_init(&ctl->lock);
+	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_2);
+	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_33);
+	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_34);
+	ctl->config.num_arg_regs = 1;
+	ctl->ops = &smu_msg_v1_ops;
+	ctl->default_timeout = adev->usec_timeout * 20;
+	ctl->message_map = smu_v13_0_5_message_map;
+}
+
 void smu_v13_0_5_set_ppt_funcs(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1139,4 +1155,5 @@ void smu_v13_0_5_set_ppt_funcs(struct smu_context *smu)
 	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_34);
 	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_2);
 	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_33);
+	smu_v13_0_5_init_msg_ctl(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 2c16da1065c8..a9789f3a23b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3911,6 +3911,7 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 	smu->smc_driver_if_version = SMU_IGNORE_IF_VERSION;
 	smu->smc_fw_caps |= SMU_FW_CAP_RAS_PRI;
 	smu_v13_0_set_smu_mailbox_registers(smu);
+	smu_v13_0_init_msg_ctl(smu, smu->message_map);
 	smu_v13_0_6_set_temp_funcs(smu);
 	amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
 	amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 26f4e0383ace..d8f2059a1631 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2817,4 +2817,5 @@ void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
 	smu->workload_map = smu_v13_0_7_workload_map;
 	smu->smc_driver_if_version = SMU13_0_7_DRIVER_IF_VERSION;
 	smu_v13_0_set_smu_mailbox_registers(smu);
+	smu_v13_0_init_msg_ctl(smu, smu_v13_0_7_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 358fe97ceea3..79ec2d235a09 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1366,4 +1366,5 @@ void yellow_carp_set_ppt_funcs(struct smu_context *smu)
 	smu->is_apu = true;
 	smu->smc_driver_if_version = SMU13_YELLOW_CARP_DRIVER_IF_VERSION;
 	smu_v13_0_set_smu_mailbox_registers(smu);
+	smu_v13_0_init_msg_ctl(smu, yellow_carp_message_map);
 }
-- 
2.49.0

