Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA2FD14893
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CCAB10E688;
	Thu,  8 Jan 2026 04:50:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QEIcwYto";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013029.outbound.protection.outlook.com
 [40.93.196.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9278010E689
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IARPJ8Z79UZcl0XCi3rVo33tKs3aQLGTReeAVUiJI7IomZgkJZnFYe/O4UYHg7Kuy5mfs38Nx/Go6E8ICS919XL+289qGZ67h0MbDtu3U5KkQ6lge1MgoXeWvuympD3opfU0gKCQCku1+17xGfZj0XFXNRJ2c8RzkcJlFasxMuGLbGfvCOKwyYB43dolZhBdq5TbJZF9jXo+vmnukxcTC+VKBVPhOIqPFYzgU1yD1AssdhViGsmWQ+ncpc7nNQMtmSLHKGGJ5V5zUr+Ig3k+AGgWXK3Gck0ay2ySHipKzKm9NAEvoVGhYgkpRdA9gC02yscnIjY3PAiSEpuiIB4Elg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0Ty4LgnWUJihLhqRyqWbDrO6O0NMLamXGdoUa0Tc1g=;
 b=FH8EJSuN+lZQZmc0sAbs6K88o9O1eh4JsGMPFblHPlDojrtNDfpVYOXoQJWaYVlo4VqN2r2K7Oi+2LAfXJtmaqGOW7IZWeO9dc7U9/+ChdAhh3LK5HalsvV/SIAUhaEzgp1+BFrvqd0spJyJmwVSBnHtJ8zJdL4gpizNWuacNS4OKcjaxgIjbQoY5cWdFWP911wusTvRJKjIjYKnWNCi4UYFITVA0rJIfq8/WrxAJCu1pwqPWS180aJGTlNHbl0k1jmEHe4Ix2oubwtEqLfWK3NTZsG1WlnP+FPXG4YViXRhBns4urZcaAeMBHEl21VWRS/2O6NWASMWFCzF6LQBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0Ty4LgnWUJihLhqRyqWbDrO6O0NMLamXGdoUa0Tc1g=;
 b=QEIcwYtoQcs/I5wvvVJT2H31Tc7d1WMv05/8FvMM0rSJUDwE2oxmksRU7rnRgsYg0kf6GGfrUQ9taTg3707TDVLu89IzZQOkqyGmrQWvZ5tsmQgMXmqoqXwCa2A8khwFOvxduX4o9pALGaig6s1FKMgNHOjG+GKJRBB4bNsS9DQ=
Received: from DS7PR06CA0005.namprd06.prod.outlook.com (2603:10b6:8:2a::20) by
 CH3PR12MB8849.namprd12.prod.outlook.com (2603:10b6:610:178::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:49:53 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::25) by DS7PR06CA0005.outlook.office365.com
 (2603:10b6:8:2a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 04:49:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:50 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 17/24] drm/amd/pm: Drop unused ppt callback from SMUv11
Date: Thu, 8 Jan 2026 10:17:33 +0530
Message-ID: <20260108044839.4084279-18-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|CH3PR12MB8849:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c80b08-e31a-4c04-0ff4-08de4e715cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a468sS3PjV8WkevjIgzblrI7A1U67k+vuM/KjbFYZ2SDYEbsU7AhUShgaAHv?=
 =?us-ascii?Q?Ed9z41Zx+/lCkFO34Q4eD9HnkYMH+btXynCsA2UnOJjbfVgO4xPSyd8iNw6I?=
 =?us-ascii?Q?j6QsRfCUGjyNExErNoPE7Jtpz5MKor6FXtmDXnbVJEPRd6qrPfs4jWPkaIOP?=
 =?us-ascii?Q?Ucc6jy/WHkq3XiG1zBGhZDbqt24/MrqAIt81tJTgChRYsQVTK+eR5l6uv8Vs?=
 =?us-ascii?Q?94Jp4ZqHQ2W+inAkBChj9Rb5BgIYC5c/6zV1Ukb9I/dPtNAGDIKXpE3OKnIv?=
 =?us-ascii?Q?vBIdeILLmkYDHyxjDC87PAncMo4Gh+9Vtzfn5kycsDfhdGAG+GSvg3DC3k13?=
 =?us-ascii?Q?oCfsZlQOGtVsJgcyoKA8Yu5Khix2rlrqwk6yl6/Y/yfGNV3I2NbXVp6kV03D?=
 =?us-ascii?Q?PHmb0J4zHG9V3Tkt2i872cjJLXq0RK4Ra1s/GVS5gkIqxn7nbIDaCHqq4upa?=
 =?us-ascii?Q?+vFJ+l6V29Ms2mBLAg6V1YN0OlQGdXFRxeJBEa+XciVy8s5fyZbpMPsxeDqy?=
 =?us-ascii?Q?SoT4Vp8sgSsOEVaid4Uf/6lvkd7GUz8DmpULvXDJfjFoFmBfL0AGUQ/KDK12?=
 =?us-ascii?Q?n2OYGeJj3wveiF54WYpfku3oDK6gxzkRamcb9FcgiOMiFZMak3k/EZ3P5ska?=
 =?us-ascii?Q?5doJFh6RlMtI+eAKZOgvnbc6y3ALLCkuy4QqiEuDL2bL9Ag0VQz8/cD4pVMd?=
 =?us-ascii?Q?Rauc92NLnCpM2kZrX3C+m+71vUR/XIYzRgaVH1QxWvZEJ7yR5YKyDpITxwWA?=
 =?us-ascii?Q?4R88ZTW02eGM1Her2O1jomjJRpX/5YjWLbTx4Cjvq4a+0WHPuGfOEl1/jB5d?=
 =?us-ascii?Q?6jifODT3MfisIuGbJxuVYR6/AU1GriPjCx2uFigJW2m80cQalScSZVqvgzIM?=
 =?us-ascii?Q?mEs8u1Z4H26IhIpW/RlpouY9ECmlUhfFq0ywB7IYEAWIgruL/hkLmwDeTIsB?=
 =?us-ascii?Q?uSQV9A+0wptGknpkbx/j4leKYj6YFs7r6DrtunBluAhRBKwNE1IDHs/EO6n7?=
 =?us-ascii?Q?4qRqzfVC1+MYJ997Ml3FgwTitzc929nshlmrsVnnhswQutm/Clm2nXPTtqRk?=
 =?us-ascii?Q?1BfsGSEni1v8trBAQWtDBd/Vt5nf/0+t83No88aajNUCypIIZQT3tsCoOO6h?=
 =?us-ascii?Q?fb6Np9PKA86VtPHymm0EZJTOHI4y5wjss4LeHAhJCd+IayK/S6bT70VbCZxP?=
 =?us-ascii?Q?MtF4Ss5HPx/SQmYvxWpa4qPAfJozEXkC507tn17qNC77TuGt8ma1hM1U6ZMv?=
 =?us-ascii?Q?KzeRriYqRFWGHOuQIvMt7KbCyvJG/FjgmRCOvS5jc2PPfmk5hvB1H2GafEiS?=
 =?us-ascii?Q?Wa6s7A7/ppgj+LFzh4kF/IRQjyP8xrKbBtpoJVWTwTB0t28FHlEF1GygJIVs?=
 =?us-ascii?Q?1XkBqBkY/0BKAc/RF4SPUt9F9lO0GhuJbVTllP7bMwI/YvLJmpFmCzGIWCBf?=
 =?us-ascii?Q?GUaVSqDJbId/UBp9zwT8fvuKEkoAEPU2wdIvkbzqdfxVrR8Hu7UbqImjzd22?=
 =?us-ascii?Q?7kGZXNhU5nFK3Rn0CIfSzHL5eeXTbTnZcL1tmIdrRb9neYLQFiP6MlpvKVbi?=
 =?us-ascii?Q?fjbffcHKct80A7b3O4s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:52.9851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c80b08-e31a-4c04-0ff4-08de4e715cea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8849
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
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
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

