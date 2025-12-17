Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC9DD65C49
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6781310ECD2;
	Wed, 17 Dec 2025 13:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cm3W3O9c";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013000.outbound.protection.outlook.com
 [40.107.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4090610ECD0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMKcxN8q5cVjvi0wZ+Ov/KquPtRHKsVoUicmlLXnGGKD89heX5/VPWapow5WGXA0HkFh1n1sw9j1UcvT/tzcDtGn/z0POxQ66FU/7Zvw6CQ+CPKEgMUVnqbiywZlyoqVLyyQhlObDw/L6HIO9U+Ng2zRZmBlGl/zNPtryXQxmh+uWCtRbeb2qqq8uzCrxgwvjP0vYM7NKPjxM8vqrXvYiEpaYNDutPA4zy9BwqQTL38qLXw0cs1qR83YThh5kmQkwz1jryg+jhazCdGzYQ+NcKB4xPEfKj1Rs4hYDJ+3xzht3+DCvCOx9vcdWj/jChO6hBmNqp2fJ4byYjNqTC772A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knrf3x2vshVoHzEYQb6E8ZyHvQYaf+bXvfw2+ETL+6Y=;
 b=LjH63NHjohnjzimgGvNgPMhro7uyhm2tiSqjSwNlyJu4MVAweYaUG8CA7T6GUKRqb45ziePORhpqTNCHNlHGlhvNfTuzZGLhiukwyCs7ZsWdzvAQsHMP0q9MUWYXnhUM2n8aKc6Yt+HaoLUKaDkOk7cHHgaNgxkI0XcC2hqVXuRFiZ8Bqnh282aNkd60p2xYvCWmpm7vX0kqZdH9YL1LWvEORyuoxEguXxOjGx/wVWWgY6XAFeRkZ9bRpQJEz5YTJHnZaoIJOUChE6U5Igg9iE9OnXfnpuRKsbZ8PPmqWLMIGlYfCX7A/JuKPe3qDtAfOcUisw5vS1iBw2fG27f2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knrf3x2vshVoHzEYQb6E8ZyHvQYaf+bXvfw2+ETL+6Y=;
 b=cm3W3O9cqLcIXwCm5jvn+QHcNSoi3t6jnK5H7cFfz4OJ4BpNE71SdrnfTEv24gDwEqBhkRTo3w7JwV03Kn8jSfOM4grSZ95edsuKChT+obrnm9a5w5eTEPxEdWbQjdMB74QSPw6yN3Ok7GFV0ESBPbSQI0tSqJO5cQ9KRiKF4u0=
Received: from CH2PR03CA0027.namprd03.prod.outlook.com (2603:10b6:610:59::37)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 13:55:00 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::b8) by CH2PR03CA0027.outlook.office365.com
 (2603:10b6:610:59::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:54:59 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:54:57 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 04/21] drm/amd/pm: Add message control for SMUv13
Date: Wed, 17 Dec 2025 19:17:57 +0530
Message-ID: <20251217135431.2943441-5-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2f2d00-3f18-459f-2217-08de3d73deaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aBz9v/hs4cIcE/2/bVzEBj9nIu0epXq9BYU7YMNQjHwU3bgs2I+rx+j8nf+u?=
 =?us-ascii?Q?E16VqcSDwbv6CjyTqingAe4j0ZfDOuv8nCeMg+W8y/JwzlfsRVpnW+1hTi+g?=
 =?us-ascii?Q?Aji5d1wDpYpPpNYpMZiEjsNXSVCkI3yO6XfypCtF0cbxYPTlqrRKzufmndH5?=
 =?us-ascii?Q?Bq3v7ZgaTWBWAUhBBmQ6YmtEonmGtthHJQg75TB2bICp7Z1K4ZXS6V6fE8VP?=
 =?us-ascii?Q?chx4pf4+OUv4zkAiTrhkDHsRhugmgtoA1JQLkf1EXIgOoWwe+B/UfEC98HFd?=
 =?us-ascii?Q?wNZkykh60Zf7v0y+5hAGEidXvvjJkFYmd7B2IGOM8DXqKtD7zmSbrtgMK7Ea?=
 =?us-ascii?Q?o87VeEMuO4RCdv/ztklfZxcY4HiQ42DE8x1rbCgO/ePshJBVtdpan2sLkLaE?=
 =?us-ascii?Q?wimHU1OCEL+W82OqCgAwAdQo+QuNt5QBlv8VeMai7T4L4hvYdu9aCUqzcUlu?=
 =?us-ascii?Q?VbnSJq0BS/SoDO9yhKsbpqX30z6j27bRrmoUn1phgaivEU4aCVrWTx1Ui4n2?=
 =?us-ascii?Q?ZnCTbIihBvAoMsBoIkTv0NmPz1DJyKK7iF1TsiXmqu3Z1LP/6GIvMfNEGGUq?=
 =?us-ascii?Q?6IC88t6bflUK+tALgbEUvMfKLxPM2wv2dJ29zYm8dFzC0C4xfQyNPeWM5u/5?=
 =?us-ascii?Q?FhZb9UwzqukyjM/LZSYD/86QP5GlDOpZv2HublsTp/2tnMzYDw1jQzHYcp0l?=
 =?us-ascii?Q?NUSrJJeJNwkXieETLoFYZOJkmy6dKdEil9jbec9bowcnWzPyPu8QNnJT6TJQ?=
 =?us-ascii?Q?BsrSN1XxGye33Qd+OOsNk+WkQFHzygp/0vZKAIzuyPuAqMUtjnQJWfEBS+vJ?=
 =?us-ascii?Q?CWsrsaFpUhjSdnyI35NhBBe8ZGM2qCOXhMfJp856ox3c0SlcJSZ8DVD1Ydex?=
 =?us-ascii?Q?Roq11nq2d3ddedZaYaviRXYXCfCZW+ILsCR1f0g98v/F9KD2YNfsx9LpX1gS?=
 =?us-ascii?Q?oRprDvm3EZpKFvBOAquxG4R1qm+42cjHfmVAeFiEx4IsSjRZ9BFujZvaGqA3?=
 =?us-ascii?Q?MG0gqWXjgEZPWHluvomli7mYv61m0u8f5bLX5blZlaaUt3yG4QANP7aVZu01?=
 =?us-ascii?Q?KSUihhtT/8VktzyGZ8NQSEDO6VasBDcUvT5Tsybfr/LQOqwB5wAg9F7/Pwt4?=
 =?us-ascii?Q?QEBHLkZbJ7F7X8a1sl3sWaQcpiZNkep+FEpvBjggzfISHin4zbCBViN4zXxW?=
 =?us-ascii?Q?/DVZEHjxNF/Ce+n00Mt7gutSb0E/xpUvNC5vX6OCivTPRxQFRxICIaXK9jp7?=
 =?us-ascii?Q?nO+vrNbHVtH7rIsDYfpIGgx3a/xZLSBvwCKX9X+zizUKb6smQAyYToXZoeRU?=
 =?us-ascii?Q?s02y0JSl9xckdPfLSrxkLGNAgwjU2iLHEOEomt/glBfE+aRFJASWuj5yWWti?=
 =?us-ascii?Q?sbaZ6EEYO/JodS7kWYyeV33fXurtBGBfHGBJJ30xLDQPZoW/c4DHpXIowj30?=
 =?us-ascii?Q?8fqo09l5ABpq2BlGVAuHYKFAOSa+oBiQv+H2ZouWCGgb8loLErl2iI1T+UrD?=
 =?us-ascii?Q?wvk13wBMWRckYxsfO1JUZZL33H6eW7/EnfOubR7AsTvPmYsEO22bLul40G5F?=
 =?us-ascii?Q?MUq6rF4JmZXCbds3fZE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:54:59.9209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2f2d00-3f18-459f-2217-08de3d73deaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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
index ffc959791a2a..e2ad0865de1c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -3224,6 +3224,7 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
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
index bea15fd4c79e..fe09e19ea8ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2815,4 +2815,5 @@ void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
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

