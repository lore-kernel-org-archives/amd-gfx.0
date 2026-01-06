Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6D5C47BE1
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A763010E4CD;
	Tue,  6 Jan 2026 10:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qdSZJrbg";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0805D10E4CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAqNvEu3ZFA5YAcn0ZrIvX5eK0bASKjxBWPcHdgqyAN/UDU5j+3+gyt2b/whoqzUe3cKy4eopFPq5qmsqm/flfNGTj62D50NfPLcenkBpUp9ptlCJFFcVfuxo/0OgvcVKhJWkpXkxm2DCyr9XJKdvCSEvxclW3+Z4q//W7yB6d69tcd/Kw8Rr26gPOUKcc0TKzFUeupCZ0qMb0fS15DKR+Sa0Y/b9I9dAluspSjaU/u10NUC1l7VqQc3KQg4xBxjdBQ8URp3vFUJMedxG5Dq5M9k743ogt9OkVMSQLtbWpqyiZYs5YM2FqaoqkSeTM8IMyEmFmECmqx4uF6UiJawOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1N72Hqj+3oaXpiaZErSbgmUKCVVTwlaES6fPJctBVn4=;
 b=PWGwGXYpXVgo+f0YGNusuBfiDtXXIRAmAwOUDSrYSJpJsomFbtZ7vgsyv84ChBJGZLKrUPJltWCC3cYt+whXTLcHHDCUyHbkWwGlUDgc5OmdoMMrL1hw79vYSyWIALtW6NvVQR+PpjIMC7qkAmE0+TMN89q7qwrft8IXu9xs7IJdaynUV/Oz2GlaBSRlV2p3sNZb4YH9pbSj881DFLO8a6JmPHeUc8Tu8VgUlUQ1h8saBGrWMVE7IQyEfkD8qJ+Tq+wcBeoOr+qPSuUnLZ7u04Ba1RhEZYE0fW51TmzNqggytEI1UuHDgHwEE6fZwB7JNuqYZHn0AUZoQOA64wRV0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1N72Hqj+3oaXpiaZErSbgmUKCVVTwlaES6fPJctBVn4=;
 b=qdSZJrbg9PH3oF/mmltMbhJKeojwJ/7KWHDlY51lPhNWF6jIk9OFf5oLRTTNxwzXaDR9MCT72QAa50Q+58cRF67m6bOLPCWGAl5r395SFqMSLdqcSyO+IUWv02lslELMkJUb6iIft6/SiAIBtIGl8sADgNTr0+eWLT0YcZ2Vvlg=
Received: from SA9PR13CA0112.namprd13.prod.outlook.com (2603:10b6:806:24::27)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:14:07 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::c9) by SA9PR13CA0112.outlook.office365.com
 (2603:10b6:806:24::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Tue, 6
 Jan 2026 10:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:14:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:14:05 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 15/21] drm/amd/pm: Drop unused ppt callback from SMUv11
Date: Tue, 6 Jan 2026 15:42:35 +0530
Message-ID: <20260106101317.3856153-16-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c9bab0-a522-44b3-22cb-08de4d0c5396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Iq3zzxwTR/CyRTduNqZb6J+aqrw3tJgIpW4PbErVJfawPhwENlpJagRkDN4d?=
 =?us-ascii?Q?wURCdF2XE7hqDqv75WsLE+yDXvYPzXHl/TnSDScbc3K/QGmDX2MUjWoPsJO5?=
 =?us-ascii?Q?xVStNbfq3FcKmwOoR26GlKDriyoO1KnSJoOtXIZkUfLugVKqGM7eykmzNCEJ?=
 =?us-ascii?Q?dUoVeL6i5i3uIxD2NsXOxmGQh9R0bVnL3lLzh/tM23oW7ykPENERaa3mt0p7?=
 =?us-ascii?Q?v0DB+jvYXLaBYan7vnihAbe35qHXDpPAHcaBOZ3QIMbJJi58zsxqxKWoI+KV?=
 =?us-ascii?Q?AWl6QC+0rHq5yyL8G2JeakHMW25EGp0P3nVHYivvbmVeGBPnJH51uXvchZ9A?=
 =?us-ascii?Q?2iK3v4HEoQbeUkFgdIG51xkpYy+922GJqrCh+si85phvMTe70BPCLU9i6olY?=
 =?us-ascii?Q?5w/dyn/2ZscY05+jI6Fix3OlpkyRtvOgNP7H3CJnNdXoHWGXDokG3iRpE1fi?=
 =?us-ascii?Q?ihYfjsHcIiPnGJ14ydifjdw2cxDUWIDDMIJtWVaZr1QCaaDkUWZV1rIhpk1d?=
 =?us-ascii?Q?YUtLGiB8lijFLtlcx7tDx9PjUX+bsHazQnquEqa26LU02ZocYKDCyTpZNEcR?=
 =?us-ascii?Q?Nsfk1M8WyHBwbXHkB7Ak9keoMK2hG685pHdbEje/rLq7IKvI/aelwblT8xaP?=
 =?us-ascii?Q?E98j6nCdp92AVbP1TWTlBCjATyX595/E+hwnw1zUw/EpXOv8h8Hk9ctmLIQn?=
 =?us-ascii?Q?dr8esJlMRuTKPFbj8MXY7SVpvIn6u8U1ALVslN9d4gXUip/StC+GZjwW+pcV?=
 =?us-ascii?Q?m/BnqqvXXhkBz5ZwAYT0GC3xKIzGjPqIMQYnyITzq9L5MJJKuXlZRQ18ONuM?=
 =?us-ascii?Q?ofRkLrKwXbBjrF9rvMaLRPmQv6X2XH+a4HLELQsmLASSqhZGLMDnVl0GW4WN?=
 =?us-ascii?Q?JHuRpgqvEEfZXAjSzAP5N+ZrHr74m4J/kFk99SqzrZIFdzeZteKnLMPPr7s/?=
 =?us-ascii?Q?dbB/Conc7wuun/a9SbpkSnT+9jiTSP4jlXJdBi2VK9ki2TSShqWJRIN8vjkv?=
 =?us-ascii?Q?dXiSNh1pJ9LbVuV+UuMwaMOazdzRBKHK4ZgdqGCSTi4lxnnN6ZKGaQxU44cg?=
 =?us-ascii?Q?kQRhLoksd9FPigE23tfV4bu7FVDcEf2Uxp7pbaX83Hey2BAqwu9giz+/nFYq?=
 =?us-ascii?Q?PZffQUasfE/Ryf/D9RcU5iCuXtgs9p/9kMidq81gr8Qac+OxA/snTPgO/PKF?=
 =?us-ascii?Q?ZSJnqp9UOY+vNvJuprO7tpJ/Ynt1R3hGZl7mmN4CiXtX31+HDqUduKnA3Rt7?=
 =?us-ascii?Q?eHrrQoxnJgQxObjyQHS6WdukEg8Rvlk48UAWpjHKnn1hE3SWj12zTGTykC1P?=
 =?us-ascii?Q?cReU7FosbmRbOtDJuclPuurLUAqGSvr1Bf0JiI0sVWeae/Gmod/Ij6uxT/h9?=
 =?us-ascii?Q?ZIHgRuaFCEGydATLGcmbZrYE+XvwkrI2byDe4llQqd2FAXBa6P8pkQ8Arr+G?=
 =?us-ascii?Q?gLR0lhua++dCSsVlOnKmEtWAlf46591thr6WbEmVvX9XeBThz2yJ8tu/7gZ7?=
 =?us-ascii?Q?w748Ib7jedpAHI+JhGlAbJBORE9T67uKKCJIn06v6p+T0bYhY3euUHcbJn3k?=
 =?us-ascii?Q?KVQP0t9xvsWGGXvmC9E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:14:07.0174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c9bab0-a522-44b3-22cb-08de4d0c5396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418
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

SMU message related ppt callbacks are not used. Drop from SMUv11.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c        | 2 --
 5 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4de7ae6f7c8e..7c5ce6a6e2ca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1915,8 +1915,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.system_features_control = smu_v11_0_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.init_display_count = NULL,
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 15968b057469..4a5dcc893665 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -592,8 +592,6 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 	.get_dpm_ultimate_freq = cyan_skillfish_get_dpm_ultimate_freq,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.interrupt_work = smu_v11_0_interrupt_work,
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index d7aa16681e24..1f84654bbc85 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3319,8 +3319,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.system_features_control = smu_v11_0_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.init_display_count = smu_v11_0_init_display_count,
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 90aba9adc24f..f930ba2733e9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3126,8 +3126,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.system_features_control = sienna_cichlid_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.init_display_count = NULL,
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 4ca211ea628f..4de1778ea6b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2516,8 +2516,6 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.fini_power = smu_v11_0_fini_power,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.dpm_set_vcn_enable = vangogh_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = vangogh_dpm_set_jpeg_enable,
 	.is_dpm_running = vangogh_is_dpm_running,
-- 
2.49.0

