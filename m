Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA6FD14893
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CCF810E67A;
	Thu,  8 Jan 2026 04:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yxqvv/eS";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0301210E67A
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBm3iu7bne3o6cxYVp/p2P/YBxmoEnE081vaHvKQxaczBb6kGsm8a9YGTQabTxdTKS5JJGPcKYWPTkRrwSmHGRAwVYOOAGRW9/8bhIzy9DEyOkIHpJQVEyLc9ZsCGmNPVuDLQ+oSxdBV/XZ1Rbg7vwpY5kRYB8aMc2YPrLMgsUL/i/WbSrTRaWKU0yv71nre3zJkdhVOyj9+Btwt+J68pciGdtuBcbKTqb7GxXo6FrKcBzgceDbWjBEfbfQPh0cr++3Ia3h+ubXYf2DyYq3p0stPx/x5Km7fMX6yig2YPGw+YfHrelXreMwNn9+G6CLNs0teuhX4y0j8NeD0x+4nZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/T+M/YHdWKrSATtsiSQEPmPMAe9oug0G//mnHelPSJg=;
 b=puu4RdyU4DcyrQLYeT1FKSp2QWcsr+wFTcj/Dm3Pa6x6hhoA6AT13x1L8JijgCoG8Oz+bw2srKApn3tGx+P3+MN5YvMe4vUGsHcSEJw3PjxT4Rs7cEtFhJa6IlVGKdjUYOf6Ty/tgZ1auL9Rc3Be9wsCPIT23hHOq6J9gyTM05HIMyYBgfR0XSBAKxIUmo4oRd1ORMAUn7lF2PFxGD1RwRgImjcfizccqrRcK6Ot/FyU9JHQQBq99AidEFkG1HA7irEmAHMl/HnHfVV6uPsm8xpJGksO/53mPoLEsld5WtlReUajIbWIW/9wo3Mynk77q3EOt9HDpIEGouHYbYx/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T+M/YHdWKrSATtsiSQEPmPMAe9oug0G//mnHelPSJg=;
 b=Yxqvv/eSGtO9P1o8q42beNit+Un5R7ncPP227T49DJoZtQQXPFs2BmDQ3gx9utb8083CFIvbhI8gAtNb9BeSi/jZO1Nz7lUMLh0DywWQL4eKigf3jiLGpOwaZSOyIH4XHsQd2JSemXlZaBt5qlIagIqeQfkxwgzxF3MiEcsa/i0=
Received: from DM6PR11CA0016.namprd11.prod.outlook.com (2603:10b6:5:190::29)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:49:22 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:190:cafe::1b) by DM6PR11CA0016.outlook.office365.com
 (2603:10b6:5:190::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 04:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:21 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:18 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 04/24] drm/amd/pm: Add message control for SMUv13
Date: Thu, 8 Jan 2026 10:17:20 +0530
Message-ID: <20260108044839.4084279-5-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2f5fb4-ae80-4d72-92f3-08de4e714a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PV2ul9Xf+H0ZmrxBehelZBlnz8Av29+aR2uw0+hG6ZKLqgTvoaC+Fljao8Cb?=
 =?us-ascii?Q?8/Mqo6vWJN490D9En7vhWHt/HBzKJr0lvLEFjjIeEF7/wlRS64bcQgDk/re+?=
 =?us-ascii?Q?B4vVTl+sn31/Wkj/L5EzdFqCv1/thZh3cXUdMBgoAMzzA4mHwQGDZtXR3iZ/?=
 =?us-ascii?Q?zu7Sfb3e9GC3eHkob1BsH3hBQ+5P6YmotZu1Ci+KUkYLRj7SoG4MLK1kZaBH?=
 =?us-ascii?Q?x36juYCT6Bbjab7MN0vPP1BKTEnhWJ7vBAXf+GZDFsIWj073MNmIGDB1QJfq?=
 =?us-ascii?Q?lDtiCND3Ua31rJPq8aEK1i3txaSYswAErJ5IwQaEGNe/hu2RdLv58pcAm8+M?=
 =?us-ascii?Q?w8lKS9r2g7gfPtmVu4DFixYl9jGu4Paqu+0gvQD5XVAHN/h7SEMpGD73XMGh?=
 =?us-ascii?Q?ZNacsuJe9hz/X7fg/2exDKdMESGNKnb0qUNCJhJWRm5Z9KKsIZo3KmgtO5TB?=
 =?us-ascii?Q?9oVBdRUcXMr2SSdJ9DkF7yGx93uNGq7noTUAcYKetR0wZio4tHKtCsKKciCd?=
 =?us-ascii?Q?PkqTn14I7ubVJ6RDOW8u1htcbUostZ8fXpiu6abs5zmqFCpE4OEVLXafYVIB?=
 =?us-ascii?Q?c1VcvWA1yZBryUrAw+2xQzfDnam4XDzmhkSna90EMZINXOguwW22VQvZs/th?=
 =?us-ascii?Q?TZuEmcdjJuJIZoLtdmFqeM+mdDDSpZmKf2yTa2Lv1stvGeR0BYkyZJqYJMyN?=
 =?us-ascii?Q?eP3sW2Ui0vV5VDb4EjjCEhvTW4+zxOBnVCUxfAK9P8dD0chRL1pjlNS/P80k?=
 =?us-ascii?Q?rQdXH5B+os9FqxUFrXQwVIuQrEanmi7aYqnINeqcrNweurTlZL5adi0FFKoo?=
 =?us-ascii?Q?LPMU9gFy+YY8Z4rUCdB7Rc1/vL4+AcFxcVE/Fa4mdf8pyJ58Ozz6iCtHuZOI?=
 =?us-ascii?Q?ZoX3o6QawdVrf4K0/zEit1Zisf3okUesqz0I8orjhxlBclAc9g5P14+xNMBU?=
 =?us-ascii?Q?1AOaUTbt34bohmRzcd4SR66iIP2Wru9jeCShbg0PYJLlc0meR6H7t8VcL3h4?=
 =?us-ascii?Q?4BptuhWBAvqqsqjvPCuVsE/LHnchvRoz7bOB+EUmqoVRbuCdqHvZvy8AiseT?=
 =?us-ascii?Q?cHvVe904SgIEhxNzQSiQChLeWSJgLafpo/jMvjAqpLdQqAsFigt+n1UXXpSd?=
 =?us-ascii?Q?e8+2b4ZcI2XBJ3WOYBp2nFuTyW2zf/Ika8/9GUbxUM+vzDTZ0sDPT9GdO/dL?=
 =?us-ascii?Q?5nouPM9Pgdm8dI13c3s79DWptHUVRMoUruA8zJs8xdyv+8bM2/OD6jQN3GFp?=
 =?us-ascii?Q?Jzl2h0ZEV8gz11iZ4FvmN7DIW1moJwWny2E3QaRntvCGsFlQdqDrQs66BIZH?=
 =?us-ascii?Q?yiuO7y95uDkJuBUTssdP8aGxxXcS5ymaSDRY0twfmRn66iYGc+AQOvIWs6me?=
 =?us-ascii?Q?v/aJYQF9WMKmad2IGxU8FgyE7md5frwbDDAOnKB6+hLNAm1IFfZAD71JafOD?=
 =?us-ascii?Q?Xb8eFP/zybNHesAqg0Je131BxTZw1BIntYhKjBRIOj49V5mELZlKFv0Avt9x?=
 =?us-ascii?Q?vV4SIK3vdlVXY1y2uv7PFCQFmUSZaWsPIi5CxDS9rOejuGaXJzJvaBAEWFj4?=
 =?us-ascii?Q?Nd4zq9YHgDzt9sA49n8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:21.2346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2f5fb4-ae80-4d72-92f3-08de4e714a02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
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
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
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

