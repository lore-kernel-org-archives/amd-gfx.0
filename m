Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640F4D6AAF8
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 029EB10F296;
	Thu,  2 Apr 2026 18:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WLjN9QIz";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE5510F28C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixRX9QrqGQJ1FaL5+2O9p3BJkclnBVkXXPJfK33zJZx41HCCix1zh8Jd7w6g1vCC6zc4cZnyzxWDDYvJS5P92kJUlz9ca8/Gvn0zipkCR2RRIAYi+MWFru/j623pu/7meFPqXP5c/BXhzGOO7GFHDzGEY+nYiLH93br1QL+TqOyZEF8rk9uyGqu63OKpSYOuKiU7dPgm5n2cqxTgEIZtiGnpgnQi0NT2EdZEZGwdxUWNuJ2QMzjTpSs3IV5A1iPMKp6l76dBc5N5FJ7w4/C3CUISIC/ysYXP3K8LsTI5YdP7pNm79zHuXk2cUIsIIa/l02uw6trNGXHMujqRtsaNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h99eUgSVfb49KjpbzvlBovWnwIE1N0IyRMTGqYaFvvo=;
 b=tEO9BgGrQtr8iWhirYf9dLS5JRIIwkIlzJJwM07fZDj7mQEz5QqUr7J7QpGJY7p2ux/NyPHX0fub3Uer89Y6aG9Iizyusx73ZfMgi5wljHzgnM8cUHVL3mPN3IwPVvDLvvUu/44IvQFjb9/mhSFUTRhrjBqKvOlspXTupT00WPThpgSyVUvDc1BcAwU2rVCM/K5jJbSCkY6d4mruOQfsdmCCCew9P4ivm9i7lm3ECBi8k1SQ4KaNKiUI2WOhZcdgoIW3g0/7uyqm5wpIngAeBwjbpbMHeUxjZ75dudepMv5UmEDfOMHDrC1wHSUXi0JZ9sV+XngDXlkObTwJLoin/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h99eUgSVfb49KjpbzvlBovWnwIE1N0IyRMTGqYaFvvo=;
 b=WLjN9QIzbdTQUSoHowZBjcBVDABPkU0h5d2VjsukE1MnVUL+924zhIlZZB6bthq9dJhBowr7pNhNVNPLKM2LyfTwngxMa5Jrzqs+uVzdF4gGXccDv78+Afrs9SBw4i+UKeFSUFrTdzGwGrjlvCu5+DrZMaRstJpZJaJ6UnDKHgw=
Received: from CH0P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::16)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 18:34:21 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::9e) by CH0P223CA0005.outlook.office365.com
 (2603:10b6:610:116::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Thu,
 2 Apr 2026 18:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:34:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:34:15 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:34:15 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 19/22] drm/amd/display: Add DCN42 PMO policy for DML2.1
Date: Thu, 2 Apr 2026 14:33:11 -0400
Message-ID: <20260402183314.1388755-20-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 4366cb4f-245b-4e1c-69e4-08de90e67528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: B6MSiLThIK8LU2q6OkEWGGrr88stffa3fDu9n9zDG3rrrXLWDRaRo16SDqle5cme6WfslsndrDDlkY8GhCDKAOtxavKRpG3V41l+Rvy1MRTPlaXMHTLeZr7pIL54uU8EbFNMlCC1nztvtMtLRo3K9AKegTCaV6iimAMWqJN+fAb44R9oauAQ1qq7sARWaHO/Lj6aNn2yNUosqgRTuRNijcOIctvIKWmFYdJH9gsPBWVpcxO9lCP4JhkIPuEgqOqcilmpSgPdpCJeCItNClHyyCFNQCge4QCi4QfgFm8QAvc5rdcMSWhsOMiwlrknIT/2CAJT17ggYFOmjK1ewD51F+VnKTD0nlH3nlf1joOZDJoHF6axb+mvuuCtDhyh2Ech3mi9NwgZ/9JI6YYWHn59HrLKWdFbMwwFEBSt3C8cq8970/trKH3l5BY2UKeg2aIcMOXxPYSxaZ0ys/XFbZCvOJQiSYJoMPru25PmMohT3mRLmxGtggHbZQir/R4fEB2MtScFf7PWTSFlXrFiKtHciYHGdK5ZUFk7rN05rfhiXS89mXJMKj7JxO5NqgRXKPepKzfEcFGQZm96ar6NyO3dwpYZ2uUGEzMi31lYtHvCCLjbVkJMmCzMPbuVA48tUsaogZhLVAUXGxZstwTceeVZM5g2E5q17JYevHR7CE7ezg6mPhsRPFwDS+4JRKKTlz7gYcCoL6YB3rZQPupTTf2XlkTzGBFViZHOzgpfmUToXQ8VDfBv/9EV/7b/7Go91Ka2pm3sDdfi/+9zMPwtD0DoXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EL1U4VKEIpDonMASHrjGc96YcQBAggWFr26Ed+eeI1HvLWH3F66A7h5f7drvM3fVNYQC9/D6tvK3wc6jHeJT9NXa4rULGW3kHFOvBKq4pOAe9BQNEHz8QIqXbpTH2DQgywZp5uhrZ3QtJkl7bwVVvJ7Rnjl69QUOdee1SGO0DHDsBBbWrzvnLjC96E3o/Vz/iLT9ReeOoL/mAY/rVHwm8Ca6LzOc6fygfhSTyH2yhGgHZpJFxXKbb6VsiCeObmeXHnJMAs+54tpVKDAc9D+00rIQN8ihVjWGmhGDOOC7N2+gnOJmX9lxGF8g1zPrtEDsQpB9jq4Rm6YE28JN9mr3nnNa0l3aNQEWjqnBY/6CmlSCNkMV4k1ePsRnDQjX8CrHSvbhRwV8KDSNT1Rw1ZfoBfwwdNJf/ufURfvunhW8m0995LGCYKr2ExG/xWxFrF87
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:34:21.5338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4366cb4f-245b-4e1c-69e4-08de90e67528
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The MinTTU policy in DML2.1 does not guarantee that we support p-state
in blank. This is a delta vs dml2 and earlier revisions as the prefetch
mode override has been removed in favor of a more configurable pstate
optimizer.

[How]
Split off DCN42 with its own PMO helpers so that we can use a simpler
strategy of only allowing the mode if we support p-state in vblank and
if vactive has enough latency hiding.

The actual hookup to use these helpers in the PMO factory will be
done in a later patch to satisfy build system requirements.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.c       | 192 ++++++++++++++++++
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.h       |  17 ++
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  16 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h  |  10 +
 5 files changed, 229 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 2625943d7f7e..8a451c36fdb3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -100,6 +100,7 @@ DML21 += src/dml2_mcg/dml2_mcg_factory.o
 DML21 += src/dml2_pmo/dml2_pmo_dcn3.o
 DML21 += src/dml2_pmo/dml2_pmo_factory.o
 DML21 += src/dml2_pmo/dml2_pmo_dcn4_fams2.o
+DML21 += src/dml2_pmo/dml2_pmo_dcn42.o
 DML21 += src/dml2_standalone_libraries/lib_float_math.o
 DML21 += dml21_translation_helper.o
 DML21 += dml21_wrapper.o
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
new file mode 100644
index 000000000000..30fd5efe4b87
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+
+#include "dml2_pmo_dcn42.h"
+#include "lib_float_math.h"
+#include "dml2_debug.h"
+#include "dml2_pmo_dcn4_fams2.h"
+
+/*
+ * DCN42 PMO Policy Implementation
+ * This implementation provides VBlank-only strategies for 1, 2, 3, and 4 display
+ * configurations, ensuring p-state watermark support in the blank period only.
+ */
+
+static const struct dml2_pmo_pstate_strategy dcn42_strategy_list_1_display[] = {
+	// VBlank only
+	{
+		.per_stream_pstate_method = { dml2_pstate_method_vblank, dml2_pstate_method_na, dml2_pstate_method_na, dml2_pstate_method_na },
+		.allow_state_increase = true,
+	},
+};
+
+static const int dcn42_strategy_list_1_display_size = sizeof(dcn42_strategy_list_1_display) / sizeof(struct dml2_pmo_pstate_strategy);
+
+static const struct dml2_pmo_pstate_strategy dcn42_strategy_list_2_display[] = {
+	// VBlank only for both displays
+	{
+		.per_stream_pstate_method = { dml2_pstate_method_vblank, dml2_pstate_method_vblank, dml2_pstate_method_na, dml2_pstate_method_na },
+		.allow_state_increase = true,
+	},
+};
+
+static const int dcn42_strategy_list_2_display_size = sizeof(dcn42_strategy_list_2_display) / sizeof(struct dml2_pmo_pstate_strategy);
+
+static const struct dml2_pmo_pstate_strategy dcn42_strategy_list_3_display[] = {
+	// VBlank only for all three displays
+	{
+		.per_stream_pstate_method = { dml2_pstate_method_vblank, dml2_pstate_method_vblank, dml2_pstate_method_vblank, dml2_pstate_method_na },
+		.allow_state_increase = true,
+	},
+};
+
+static const int dcn42_strategy_list_3_display_size = sizeof(dcn42_strategy_list_3_display) / sizeof(struct dml2_pmo_pstate_strategy);
+
+static const struct dml2_pmo_pstate_strategy dcn42_strategy_list_4_display[] = {
+	// VBlank only for all four displays
+	{
+		.per_stream_pstate_method = { dml2_pstate_method_vblank, dml2_pstate_method_vblank, dml2_pstate_method_vblank, dml2_pstate_method_vblank },
+		.allow_state_increase = true,
+	},
+};
+
+static const int dcn42_strategy_list_4_display_size = sizeof(dcn42_strategy_list_4_display) / sizeof(struct dml2_pmo_pstate_strategy);
+
+bool pmo_dcn42_test_for_pstate_support(struct dml2_pmo_test_for_pstate_support_in_out *in_out)
+{
+	const struct dml2_pmo_scratch *s = &in_out->instance->scratch;
+	const int REQUIRED_RESERVED_TIME =
+		(int)in_out->instance->soc_bb->power_management_parameters.dram_clk_change_blackout_us;
+	bool p_state_supported = true;
+	unsigned int stream_index;
+
+	if (in_out->base_display_config->display_config.overrides.all_streams_blanked)
+		return true;
+
+	if (s->pmo_dcn4.cur_pstate_candidate < 0)
+		return false;
+
+	for (stream_index = 0; stream_index < in_out->base_display_config->display_config.num_streams; stream_index++) {
+		if (s->pmo_dcn4.pstate_strategy_candidates[s->pmo_dcn4.cur_pstate_candidate].per_stream_pstate_method[stream_index] == dml2_pstate_method_vblank) {
+			if (dcn4_get_minimum_reserved_time_us_for_planes(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) < REQUIRED_RESERVED_TIME ||
+			    dcn4_get_vactive_pstate_margin(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) > 0) {
+				p_state_supported = false;
+				break;
+			}
+		} else {
+			p_state_supported = false;
+			break;
+		}
+	}
+
+	return p_state_supported;
+}
+
+bool pmo_dcn42_initialize(struct dml2_pmo_initialize_in_out *in_out)
+{
+	int i = 0;
+	struct dml2_pmo_instance *pmo = in_out->instance;
+
+	unsigned int base_list_size = 0;
+	const struct dml2_pmo_pstate_strategy *base_list = NULL;
+	unsigned int *expanded_list_size = NULL;
+	struct dml2_pmo_pstate_strategy *expanded_list = NULL;
+
+	DML_LOG_COMP_IF_ENTER();
+
+	pmo->soc_bb = in_out->soc_bb;
+	pmo->ip_caps = in_out->ip_caps;
+	pmo->mpc_combine_limit = 2;
+	pmo->odm_combine_limit = 4;
+	pmo->mcg_clock_table_size = in_out->mcg_clock_table_size;
+
+	/*
+	 * DCN42 does not support FAMS features like SubVP and DRR.
+	 * These parameters are initialized to safe values but won't be used
+	 * since our strategies only use VBlank.
+	 */
+	pmo->fams_params.v2.subvp.refresh_rate_limit_max = 0;
+	pmo->fams_params.v2.subvp.refresh_rate_limit_min = 0;
+	pmo->fams_params.v2.drr.refresh_rate_limit_max = 0;
+	pmo->fams_params.v2.drr.refresh_rate_limit_min = 0;
+
+	pmo->options = in_out->options;
+
+	/* Generate permutations of p-state configs from base strategy list */
+	for (i = 0; i < PMO_DCN4_MAX_DISPLAYS; i++) {
+		switch (i+1) {
+		case 1:
+			if (pmo->options->override_strategy_lists[i] && pmo->options->num_override_strategies_per_list[i]) {
+				base_list = pmo->options->override_strategy_lists[i];
+				base_list_size = pmo->options->num_override_strategies_per_list[i];
+			} else {
+				base_list = dcn42_strategy_list_1_display;
+				base_list_size = dcn42_strategy_list_1_display_size;
+			}
+
+			expanded_list_size = &pmo->init_data.pmo_dcn4.num_expanded_strategies_per_list[i];
+			expanded_list = pmo->init_data.pmo_dcn4.expanded_strategy_list_1_display;
+
+			break;
+		case 2:
+			if (pmo->options->override_strategy_lists[i] && pmo->options->num_override_strategies_per_list[i]) {
+				base_list = pmo->options->override_strategy_lists[i];
+				base_list_size = pmo->options->num_override_strategies_per_list[i];
+			} else {
+				base_list = dcn42_strategy_list_2_display;
+				base_list_size = dcn42_strategy_list_2_display_size;
+			}
+
+			expanded_list_size = &pmo->init_data.pmo_dcn4.num_expanded_strategies_per_list[i];
+			expanded_list = pmo->init_data.pmo_dcn4.expanded_strategy_list_2_display;
+
+			break;
+		case 3:
+			if (pmo->options->override_strategy_lists[i] && pmo->options->num_override_strategies_per_list[i]) {
+				base_list = pmo->options->override_strategy_lists[i];
+				base_list_size = pmo->options->num_override_strategies_per_list[i];
+			} else {
+				base_list = dcn42_strategy_list_3_display;
+				base_list_size = dcn42_strategy_list_3_display_size;
+			}
+
+			expanded_list_size = &pmo->init_data.pmo_dcn4.num_expanded_strategies_per_list[i];
+			expanded_list = pmo->init_data.pmo_dcn4.expanded_strategy_list_3_display;
+
+			break;
+		case 4:
+			if (pmo->options->override_strategy_lists[i] && pmo->options->num_override_strategies_per_list[i]) {
+				base_list = pmo->options->override_strategy_lists[i];
+				base_list_size = pmo->options->num_override_strategies_per_list[i];
+			} else {
+				base_list = dcn42_strategy_list_4_display;
+				base_list_size = dcn42_strategy_list_4_display_size;
+			}
+
+			expanded_list_size = &pmo->init_data.pmo_dcn4.num_expanded_strategies_per_list[i];
+			expanded_list = pmo->init_data.pmo_dcn4.expanded_strategy_list_4_display;
+
+			break;
+		}
+
+		DML_ASSERT(base_list_size <= PMO_DCN4_MAX_BASE_STRATEGIES);
+
+		/*
+		 * Populate list using DCN4 FAMS2 expansion function.
+		 * Since our strategies only contain VBlank methods, the expansion
+		 * will not introduce any FAMS-specific logic.
+		 */
+		pmo_dcn4_fams2_expand_base_pstate_strategies(
+				base_list,
+				base_list_size,
+				i + 1,
+				expanded_list,
+				expanded_list_size);
+	}
+
+	DML_LOG_DEBUG("%s exit with true\n", __func__);
+	DML_LOG_COMP_IF_EXIT();
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h
new file mode 100644
index 000000000000..31ba8575351d
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __DML2_PMO_DCN42_H__
+#define __DML2_PMO_DCN42_H__
+
+#include "dml2_internal_shared_types.h"
+
+struct dml2_pmo_initialize_in_out;
+struct dml2_pmo_test_for_pstate_support_in_out;
+
+bool pmo_dcn42_initialize(struct dml2_pmo_initialize_in_out *in_out);
+bool pmo_dcn42_test_for_pstate_support(struct dml2_pmo_test_for_pstate_support_in_out *in_out);
+
+#endif /* __DML2_PMO_DCN42_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index f7c10dbfc154..b348c65a0f75 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1662,7 +1662,7 @@ static bool validate_pstate_support_strategy_cofunctionality(struct dml2_pmo_ins
 	return is_config_schedulable(pmo, display_cfg, pstate_strategy);
 }
 
-static int get_vactive_pstate_margin(const struct display_configuation_with_meta *display_cfg, int plane_mask)
+int dcn4_get_vactive_pstate_margin(const struct display_configuation_with_meta *display_cfg, int plane_mask)
 {
 	unsigned int i;
 	int min_vactive_margin_us = 0xFFFFFFF;
@@ -1907,7 +1907,7 @@ bool pmo_dcn4_fams2_init_for_pstate_support(struct dml2_pmo_init_for_pstate_supp
 
 	// Figure out which streams can do vactive, and also build up implicit SVP and FAMS2 meta
 	for (stream_index = 0; stream_index < display_config->display_config.num_streams; stream_index++) {
-		if (get_vactive_pstate_margin(display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) >= (int)(MIN_VACTIVE_MARGIN_PCT * pmo->soc_bb->power_management_parameters.dram_clk_change_blackout_us))
+		if (dcn4_get_vactive_pstate_margin(display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) >= (int)(MIN_VACTIVE_MARGIN_PCT * pmo->soc_bb->power_management_parameters.dram_clk_change_blackout_us))
 			set_bit_in_bitfield(&s->pmo_dcn4.stream_vactive_capability_mask, stream_index);
 
 		/* FAMS2 meta */
@@ -2182,7 +2182,9 @@ static bool setup_display_config(struct display_configuation_with_meta *display_
 	return success;
 }
 
-static int get_minimum_reserved_time_us_for_planes(struct display_configuation_with_meta *display_config, int plane_mask)
+int dcn4_get_minimum_reserved_time_us_for_planes(
+	const struct display_configuation_with_meta *display_config,
+	int plane_mask)
 {
 	int min_time_us = 0xFFFFFF;
 	unsigned int plane_index = 0;
@@ -2222,16 +2224,16 @@ bool pmo_dcn4_fams2_test_for_pstate_support(struct dml2_pmo_test_for_pstate_supp
 
 		if (s->pmo_dcn4.pstate_strategy_candidates[s->pmo_dcn4.cur_pstate_candidate].per_stream_pstate_method[stream_index] == dml2_pstate_method_vactive ||
 				s->pmo_dcn4.pstate_strategy_candidates[s->pmo_dcn4.cur_pstate_candidate].per_stream_pstate_method[stream_index] == dml2_pstate_method_fw_vactive_drr) {
-			if (get_vactive_pstate_margin(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) < (MIN_VACTIVE_MARGIN_PCT * in_out->instance->soc_bb->power_management_parameters.dram_clk_change_blackout_us) ||
+			if (dcn4_get_vactive_pstate_margin(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) < (MIN_VACTIVE_MARGIN_PCT * in_out->instance->soc_bb->power_management_parameters.dram_clk_change_blackout_us) ||
 					get_vactive_det_fill_latency_delay_us(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) > stream_pstate_meta->method_vactive.max_vactive_det_fill_delay_us) {
 				p_state_supported = false;
 				break;
 			}
 		} else if (s->pmo_dcn4.pstate_strategy_candidates[s->pmo_dcn4.cur_pstate_candidate].per_stream_pstate_method[stream_index] == dml2_pstate_method_vblank ||
 				s->pmo_dcn4.pstate_strategy_candidates[s->pmo_dcn4.cur_pstate_candidate].per_stream_pstate_method[stream_index] == dml2_pstate_method_fw_vblank_drr) {
-			if (get_minimum_reserved_time_us_for_planes(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) <
+			if (dcn4_get_minimum_reserved_time_us_for_planes(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) <
 				REQUIRED_RESERVED_TIME ||
-				get_vactive_pstate_margin(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) < MIN_VACTIVE_MARGIN_VBLANK) {
+				dcn4_get_vactive_pstate_margin(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) < MIN_VACTIVE_MARGIN_VBLANK) {
 				p_state_supported = false;
 				break;
 			}
@@ -2243,7 +2245,7 @@ bool pmo_dcn4_fams2_test_for_pstate_support(struct dml2_pmo_test_for_pstate_supp
 			}
 		} else if (s->pmo_dcn4.pstate_strategy_candidates[s->pmo_dcn4.cur_pstate_candidate].per_stream_pstate_method[stream_index] == dml2_pstate_method_fw_drr) {
 			if (!all_planes_match_method(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index], dml2_pstate_method_fw_drr) ||
-				get_vactive_pstate_margin(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) < MIN_VACTIVE_MARGIN_DRR) {
+				dcn4_get_vactive_pstate_margin(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) < MIN_VACTIVE_MARGIN_DRR) {
 				p_state_supported = false;
 				break;
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h
index 6baab7ad6ecc..f0afa8002a2f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h
@@ -7,6 +7,16 @@
 
 #include "dml2_internal_shared_types.h"
 
+struct display_configuation_with_meta;
+
+int dcn4_get_vactive_pstate_margin(
+	const struct display_configuation_with_meta *display_cfg,
+	int plane_mask);
+
+int dcn4_get_minimum_reserved_time_us_for_planes(
+	const struct display_configuation_with_meta *display_config,
+	int plane_mask);
+
 bool pmo_dcn4_fams2_initialize(struct dml2_pmo_initialize_in_out *in_out);
 
 bool pmo_dcn4_fams2_optimize_dcc_mcache(struct dml2_pmo_optimize_dcc_mcache_in_out *in_out);
-- 
2.34.1

