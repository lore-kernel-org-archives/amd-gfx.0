Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137ADC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B861130DB;
	Wed,  1 May 2024 07:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WmYF0lH3";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36991130DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWt7O3p41/n6dRHBGZRDFm5EV6Da//eJxQ2rlMrB6leadoOzhWhiTd/Zc2PO9FhL4ZB3MDy96yyC9cwE/GiEfvUfqI8oD1u4gpFVoXpknP/nNoMbBYsSPRkmNeIN73jJREaDekU3R1PuoNu7Mo8NsroA/97bi0X5wmbSbrLObClY5ZMidkFu1l82V2TpBN5kK2eiK7HEoHIR95UQulVnK+RZqhbqZwrZU0nQgfQX4bfTH2AdZa9PhfuKTYQkwzssMdtw2LSc31kIjA1hatkdOY57BII0OIrlWwK8M5oQg/URv9xan579G53jX9rhMBGHt4fTYaj36xDc6innyq8Mnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkPlT12F4vQDe5y6hgERDyDwT/8j5ADpWzrN7lRCfEM=;
 b=Yh/VadQE/Zp2JOCeJSpHezzh7pXz42BwodL/IOgrjB52QWoshkQ9jBhxsKijeYGPyLZx3hDUe6op4FjXOVAWKWD8QGYw/j0bm+XPNlgLtcIQq2CngXgaNkBl60wnWGwBXZ8n8DnydXJ+dknWabkvAXDvOt8VhsDdftdcrtb5b5wpr7QxhzG80pvXE/fkql81Y6TXf/sIAkL5ynepyVgsuUoUFQKhGpnQrWd3wBOKjrBVB40kGjxM6s3QkUmwzsbiNo6tGlQX3sRPk0uwkC28YefTKb95kkUuLDrpJF2YdBhm9vX9HBdu5L31mEG6lsku0V5EEgn18XH5ZcvDBRRDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkPlT12F4vQDe5y6hgERDyDwT/8j5ADpWzrN7lRCfEM=;
 b=WmYF0lH3KZ8hHccr7CR07K4sO7z/UYNh/SyFOC33RihLsjnQ9K0QOdKGHPJghgsb9URp0nb5vVoh7zorbHZcbNJEvnr1MEnPPHm1S0xu99YoIGRVFxm7mXHy0B+g+7AEfLtXKctVPtjVWvRJzd9BzvBXjPY01G0yb5z3ukjYu4I=
Received: from SN6PR01CA0005.prod.exchangelabs.com (2603:10b6:805:b6::18) by
 PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Wed, 1 May 2024 07:21:28 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::b9) by SN6PR01CA0005.outlook.office365.com
 (2603:10b6:805:b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Wed, 1 May 2024 07:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:21:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:21:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:21:27 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:21:19 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 42/45] drm/amd/display: Avoid overflow dc_clk_table->entries
 by limit to MAX_NUM_DPM_LVL
Date: Wed, 1 May 2024 15:16:48 +0800
Message-ID: <20240501071651.3541919-43-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d30d47-d9ac-4fc6-92ba-08dc69af5164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4TfSA8x5qlPf7Dnqov1FMGtQrYxcHlpG1BK3LWexi2b1ZPHh7sQvHzszRWkK?=
 =?us-ascii?Q?f2/IKy9bSqdTbuuo3IvRs9ZuQzTezJd10Y0TO/BiGWxyX6LwahAYokBjf9nS?=
 =?us-ascii?Q?XiJ67vhTapsgPPV1JeLFH9PIEJy4MZ9nIV4QbJ/tFu5DH3+dQGtn1D1R32Ix?=
 =?us-ascii?Q?gaIYRvrmTLr8JwC4MwtujymWRLWuBD4OFHTL9THrpoTrkaME+W/IeVDP0s5k?=
 =?us-ascii?Q?2bUMWjq7xeIJfkt8T/i5tqaZ0rLV0j/4BJA8Y8evabfcVdIMI9ZqgYfS+lnD?=
 =?us-ascii?Q?PaBr44784a20W7cr+VY3JJIlyc31Q/BonRnfRNpefHePL0pkqbcmM682b81g?=
 =?us-ascii?Q?WGhgc069kk8rg1b5vfw/h5kQf8g3RbNIrY+e0BrteSiVi3O7/1oGVnurZlOb?=
 =?us-ascii?Q?+LqEe6zGhpbqvOCjeIePaT7dGkcqDc/Ob701z2QMAM64Z9yVcZxun/vmu9i4?=
 =?us-ascii?Q?i3Tvo4iO24Qe+h1LYtQj/DWPZNA+qU/uFuYQOh2c2S5RiXWJpQdi1iFA7XDp?=
 =?us-ascii?Q?/vwU4octchkaXWlEsxhEdp2U4QbFccKG+U/WeBfWOF0cVkqFPjDuCiaFvwG9?=
 =?us-ascii?Q?EpfdLZN3+3y4DBS3yK4mSyCq9xxQppnMx9cITwUHBolw2XPSY7iIn+WVpge3?=
 =?us-ascii?Q?m1r53yH+rWxKLUZva9MxSqYSpP7PubsC6pfWJVC/uxgjAIK6B3KZm5JAd5cx?=
 =?us-ascii?Q?2WouQbOJcyORGa6pJ5YJRdGcfLLG7OPcEjPeGvMfiCXi81L1wH1iq/aKRBw7?=
 =?us-ascii?Q?QWWyuflYz0ImiGXjZ4tRn+GMQPAeOGfV89eX1KQHOP+3FnM1D+2Ftn3BPu9I?=
 =?us-ascii?Q?8xi5lBE9qO1MYogQUP45B5P8pdgDtKm2bn2XxBSzTo9hjBhtI+u3CoIx8sjb?=
 =?us-ascii?Q?DI6xPcfQAX5zeLJFMbsxzq1xuG1gWnmMHIH7wIkHvboU70ZLE0tzPC4tsBOn?=
 =?us-ascii?Q?lJNA/3JdiDhtzMW//fo//kJu6bwaFxpFLcEI/XnN6GaEF/VDIdiV8G/PX2Fc?=
 =?us-ascii?Q?7ZZSFUzYMibrlL35Zsd2CoeWz6NrkizkMjBe+8mT4Cyx1u0bb+1shzDt/KBq?=
 =?us-ascii?Q?8n2wID7uALl0aevdQbBLwYmu2YjUDGEIopgorNnvdVqMGilF/CdGETiIcc78?=
 =?us-ascii?Q?opBHvJvl8j2X8DDZ2kYM8Pd/0a7uOgoOPqQ394NAXYGCVIdq3k9ObXR99I/H?=
 =?us-ascii?Q?HTlDAb1Sm1ytVpTy/RwGK3QlEXQRwbvM12PA9ObkN8rFB3sJpkcw8CKbR0ar?=
 =?us-ascii?Q?Lb8hvysHe/puWOF6CX6UHrMwaEggIGkctZV/euYC2GNUX6sidib45KNGLb7Z?=
 =?us-ascii?Q?zorbyq1y+xu0FRSI8Kpx3ywwmXqelNOIAlvFCoZjOr49L3+BrBb+2Se1sX/j?=
 =?us-ascii?Q?G7H3OVy4K/CFvCmebIf6l5cokiwm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:21:28.4725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d30d47-d9ac-4fc6-92ba-08dc69af5164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175
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

From: Alex Hung <alex.hung@amd.com>

[Why]
dc_clk_table->entries has size of MAX_NUM_DPM_LVL(=8), but the loop
counter i can go up to DML_MAX_CLK_TABLE_SIZE(=20) - 1.

[How]
The loop should be min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL) - 1
instead.

This fixes 21 OVERRUN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dc/dml2/dml21/dml21_translation_helper.c       | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 63f9bda3b130..e4c18417b6d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -104,7 +104,7 @@ void dml21_apply_soc_bb_overrides(struct dml2_initialize_instance_in_out *dml_in
 		/* dcfclk */
 		if (dc_clk_table->num_entries_per_clk.num_dcfclk_levels) {
 			dml_clk_table->dcfclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
-			for (i = 0; i < DML_MAX_CLK_TABLE_SIZE; i++) {
+			for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 				if (i < dml_clk_table->dcfclk.num_clk_values) {
 					if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dcfclk_mhz &&
 							dc_clk_table->entries[i].dcfclk_mhz > dc_bw_params->dc_mode_limit.dcfclk_mhz) {
@@ -127,7 +127,7 @@ void dml21_apply_soc_bb_overrides(struct dml2_initialize_instance_in_out *dml_in
 		/* fclk */
 		if (dc_clk_table->num_entries_per_clk.num_fclk_levels) {
 			dml_clk_table->fclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_fclk_levels;
-			for (i = 0; i < DML_MAX_CLK_TABLE_SIZE; i++) {
+			for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 				if (i < dml_clk_table->fclk.num_clk_values) {
 					if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.fclk_mhz &&
 							dc_clk_table->entries[i].fclk_mhz > dc_bw_params->dc_mode_limit.fclk_mhz) {
@@ -150,7 +150,7 @@ void dml21_apply_soc_bb_overrides(struct dml2_initialize_instance_in_out *dml_in
 		/* uclk */
 		if (dc_clk_table->num_entries_per_clk.num_memclk_levels) {
 			dml_clk_table->uclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_memclk_levels;
-			for (i = 0; i < DML_MAX_CLK_TABLE_SIZE; i++) {
+			for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 				if (i < dml_clk_table->uclk.num_clk_values) {
 					if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.memclk_mhz &&
 							dc_clk_table->entries[i].memclk_mhz > dc_bw_params->dc_mode_limit.memclk_mhz) {
@@ -173,7 +173,7 @@ void dml21_apply_soc_bb_overrides(struct dml2_initialize_instance_in_out *dml_in
 		/* dispclk */
 		if (dc_clk_table->num_entries_per_clk.num_dispclk_levels) {
 			dml_clk_table->dispclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dispclk_levels;
-			for (i = 0; i < DML_MAX_CLK_TABLE_SIZE; i++) {
+			for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 				if (i < dml_clk_table->dispclk.num_clk_values) {
 					if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dispclk_mhz &&
 							dc_clk_table->entries[i].dispclk_mhz > dc_bw_params->dc_mode_limit.dispclk_mhz) {
@@ -196,7 +196,7 @@ void dml21_apply_soc_bb_overrides(struct dml2_initialize_instance_in_out *dml_in
 		/* dppclk */
 		if (dc_clk_table->num_entries_per_clk.num_dppclk_levels) {
 			dml_clk_table->dppclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dppclk_levels;
-			for (i = 0; i < DML_MAX_CLK_TABLE_SIZE; i++) {
+			for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 				if (i < dml_clk_table->dppclk.num_clk_values) {
 					if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dppclk_mhz &&
 							dc_clk_table->entries[i].dppclk_mhz > dc_bw_params->dc_mode_limit.dppclk_mhz) {
@@ -219,7 +219,7 @@ void dml21_apply_soc_bb_overrides(struct dml2_initialize_instance_in_out *dml_in
 		/* dtbclk */
 		if (dc_clk_table->num_entries_per_clk.num_dtbclk_levels) {
 			dml_clk_table->dtbclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dtbclk_levels;
-			for (i = 0; i < DML_MAX_CLK_TABLE_SIZE; i++) {
+			for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 				if (i < dml_clk_table->dtbclk.num_clk_values) {
 					if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.dtbclk_mhz &&
 							dc_clk_table->entries[i].dtbclk_mhz > dc_bw_params->dc_mode_limit.dtbclk_mhz) {
@@ -242,7 +242,7 @@ void dml21_apply_soc_bb_overrides(struct dml2_initialize_instance_in_out *dml_in
 		/* socclk */
 		if (dc_clk_table->num_entries_per_clk.num_socclk_levels) {
 			dml_clk_table->socclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_socclk_levels;
-			for (i = 0; i < DML_MAX_CLK_TABLE_SIZE; i++) {
+			for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
 				if (i < dml_clk_table->socclk.num_clk_values) {
 					if (config->use_clock_dc_limits && dc_bw_params->dc_mode_limit.socclk_mhz &&
 							dc_clk_table->entries[i].socclk_mhz > dc_bw_params->dc_mode_limit.socclk_mhz) {
-- 
2.34.1

