Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06079D65C51
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EEFB10ECD8;
	Wed, 17 Dec 2025 13:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fwmQeDUh";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE4010ECD8
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfPVWoiY9Ra9HxkAcm59V2qIl8Dd7wMvPn9tv9wl9hCa1Xt30/RGmvVjGaC9iWTG+aweg84yviQm6lKVO4gvohkSxLCaP1vGtAVfTXuKb9nM+6a4J8C2EVEt4yfBmDrh7LpAZ01JaKgAltGT+fGBAQ7uNhQLK3y+jYoVrq+eKcMBXss+PIe1+FtBisqS+I9Oe6gMblaz18LaG6qIq2B9hJkAKr2OFyNPriGV13nNI5FK2PyLFAQTX1gBNkKfRiwooA/ml2Ux5MaQVntm4Cmu/svX4Hujnx1umlOSLVwzhxNuiknXfcoq+BN4qKIAGWNgk8D8geheeKxAFs1OzYg1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XacDWu4tuHKU8+HWnnZJKUo5dwo9x0F94VyO3/+aBz8=;
 b=EZdzt8e6rUbam7EzpFynahdk097zJVXZA5M6JmVIkFt8NbR1y6nU/4HTVqVxNfm2+v3b+1lxoG0M0tbACehpdsvMiwqIVKwBAnb4684gol50Pbh7k9numfMHIpj/Kg1ccR1Af0XEKyBkYIxS1GNT34vHSvD+vR1n5HCtsPlSSD1MvTd0N6E7YlJfEHTRQ2Vzpx4iVLUAtDPJEE8H0zcgRXeo/pBYSpwSn0gi4vKxqM5x9eijNX+IpmAvjYaudcDJMclYcZk+YjN2QYo+HQolUwH2jqj29qSsE2GaLUUowxQvIIQsX7lpXb1ldVplKZ+cTm0wZHElPdGpZ7bpa/ABqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XacDWu4tuHKU8+HWnnZJKUo5dwo9x0F94VyO3/+aBz8=;
 b=fwmQeDUhzgg8logcJIpmDGzlCyjl3+gNc74My0mBUEkFCszQq+7OYEbEnULxyfldIYlAxqEaV0rMq5DmoW6De23mQdAhtShI+2vw00oVfgAfomou9l4i/2I8hKl4THYz9X3EoWMLXKlkr+c+ICIt5PAYJ9eDjj0I3TAIypxI/y4=
Received: from CH2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:610:51::18)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Wed, 17 Dec 2025 13:55:21 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::4c) by CH2PR15CA0008.outlook.office365.com
 (2603:10b6:610:51::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Wed,
 17 Dec 2025 13:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:55:21 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:19 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 15/21] drm/amd/pm: Drop unused ppt callback from SMUv11
Date: Wed, 17 Dec 2025 19:18:08 +0530
Message-ID: <20251217135431.2943441-16-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 11801bca-5d10-4192-0e86-08de3d73eb60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A+zvzHD3x548atmXm8LAkUEUq0cayZYoARRbRtJGEyDxR+s1BNQpw9VXimZJ?=
 =?us-ascii?Q?b0l4bL6a3Plk8Fv62+vdEkgMVU4IEdxvVFs4vbKhgA3KCLvGgrIy49IUpB2d?=
 =?us-ascii?Q?P5htujqcToJbFPq7zZKYZ3kbw63b4GhW1L2zXa3LFRxLtgHStgvyX7HJ4V4M?=
 =?us-ascii?Q?WFPvRNfq5r71TZFAuxg3xku/0RcdyatlOyn6w/dNwTDbT0zKIZR9MtWAYDji?=
 =?us-ascii?Q?cdjsIOCPZhIjLcE3ToSQH25JQr1Vp7mIhVw6ce3EXFfgg4hjF3YDkTfJz7dO?=
 =?us-ascii?Q?vx9tLjITw9NQCnGWz5ryqU1q4l+KJ0eIjEDWuqmHRirxCaF8+WbZqzkJ6+qk?=
 =?us-ascii?Q?QgHQn2g5sbWYOcZ0i+3QRBlIocjafMrBF2Fg3+sgW/BT3G1MD+xb2SVCeHL6?=
 =?us-ascii?Q?7Hy0zLQBcH12rMoWcdrIMJmKSvaBqs34SVMCPr9lkSVVcomuL3cL+yMLyslA?=
 =?us-ascii?Q?H/ZNwlb5NvUt6OOsYn5/TLRLwsW2yCPKOFlr7XSajnuEH8cszROdvclrDD/W?=
 =?us-ascii?Q?sy44n0klG+PbUCZ8EJ3Ynyz0Su3qIWA7W89JYkOSIoVz2ugvsiUOlDodCO17?=
 =?us-ascii?Q?sdNKBpkXi2x2MWGSAy0WQpa/p3MrLFjgmbCYKX8WujeeEIKz2m6K2y1ALuiU?=
 =?us-ascii?Q?37vtj/FcDwd/szrE6y83Y+q4cedkV/0Bh4cMtbUSEJokDyOxK/yqrHu0yZXY?=
 =?us-ascii?Q?VbcMqNev2qZo/ACXFWuctlBIFljpU0VtdYd0ul56pY3nrnQtkhUe6Tlw4Is3?=
 =?us-ascii?Q?n4suaMKUvwyNLialhcvPB7J02KBgKHdgQg2ljSLYEFRgNf2jSE8FNkQVEUB4?=
 =?us-ascii?Q?WDg5iHtGu2/rskms58FKaysJtGza/FXt40/LVfbkUjeifEsVHiacyzlRrI9x?=
 =?us-ascii?Q?UG8nKcTBUL0IY9OblCVNlfejGXm5hSx/HSB9diLSKqA654cuIfxh5/aPYhYL?=
 =?us-ascii?Q?reQ0KQmSueAL1ydVTuKqBQgAQOxs8CJiTYxiNjtYgy8+lR0YQmQAEfGrPB/T?=
 =?us-ascii?Q?rfEiwQcbEbGASB8IjhNDlWc5LdJtI1RLy66X7fXlZFdFmKeu3fGJdh6u5bPu?=
 =?us-ascii?Q?hlVboQMXJLEVjJycbGFvNPzXI2RRHnhabXE4GgErtFisnWs5HfAoL/BjZnLn?=
 =?us-ascii?Q?l1S4lDpPDyNMEhM3H+myccpPP7yQLZ0axp4gAyFlxHv9I+nIbQiQWWp0fgo8?=
 =?us-ascii?Q?yPwmX2miNGbkWP5Kr+KzBQhNwxQ1r6CPRLRQ9qO5xvDf4tb07+5zFJ8xtMFL?=
 =?us-ascii?Q?uAenOUaPqCe7QBQCEQs8PbiyXmTE0sGFEFrVUURrQFv0VIwhkF2L6CgTFT+i?=
 =?us-ascii?Q?Xmf5EIHNT7mWHuNbj2WSQ/vYkS8JwWBMcTMkb3xyA0g1i8TV4Q111cbPJwa9?=
 =?us-ascii?Q?g+Mv/kQaBOHR+l8E+My7XawRT+HBqBu6gsxbG1H23TgVYSS+yO6CjbLkY2Nx?=
 =?us-ascii?Q?DKyxWglSF7zB6c4AnqFIRdjviJGmH6yK7O07ztHZyMJoVm0fUwtHmEsGXgWz?=
 =?us-ascii?Q?kijbVZuvvGpekOnhR/E8KFvywPUIDzqexdHNgRy/f7oIFuVd65+1XPGjJ3Hv?=
 =?us-ascii?Q?Eso1mPomXMAbHMnu+38=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:21.2357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11801bca-5d10-4192-0e86-08de3d73eb60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
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
index 8829fcd52fbf..91c78c287f3f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3322,8 +3322,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
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

