Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CC9FF8875
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 01:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 764CC10E3A7;
	Wed, 29 Apr 2026 01:53:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KOl3msXE";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 170F510E3AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 01:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCBmUYwVjieSC3FPZgP6TOZf2/XQBoI/tRjDCTsBtZhRWrPtOvVTwRni7ImU+W1LgR7G/xK+FcGsWcwlM044sRc5KFQ7Ppz6SCe27TjmlB9VruYFa1FeEr9LMi6mna0B+MEB2qc6VmaTwxR+Sr2OzGrnQSMe1yCnrfv1ST9I/mpi1OgT76VsTsHddEqGiNz3Rt9m9jH91zsO36xtd+q13SVWfK4895seyGJJUD5+zJ9yMnViXRiwY30klG+WQsWRhJRNOda0qzQFtomk6LwIvy2x1Owl3bDGfuhCtcAXNxgbzTNBPIOTsnks9aR3S4gCEiHuspenIfJo5syskVQQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pK/cHmTRQInnzRkkNrkpmGzJ/au7hMryal66cUrhixc=;
 b=MRR8GxFgAY+p7tLtOZoqgrXoZSNlaCiLHKqxEh4WAiAWNuQOUBfpr/zuuxjB2xh8BfulewQHqnzb9xwo/tmjYhceyPWqHb64QxhV8tTNbj+Gphh8aOZwEHxPyKmurBcxYP422OXW2EopzvbPcOr1/fpB08C5mTvmvnXjxEc5H27aZVu2/Gs1abywypbsyBd+Wf9LC5R0KOyOb7h70sHyQhn51MNTmzK0rRH++ftsDVEZsRkupWx3GdM9k0KpcwvmkhdyHndrXNNSZSPNRS3NcpPz1e+IZrmTGHyekrO6tCKTLWCMOzLJUhU0vO10XGzmAuargpvpJfKk0oNHO5ZUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pK/cHmTRQInnzRkkNrkpmGzJ/au7hMryal66cUrhixc=;
 b=KOl3msXEaFi6nfTIECsvUBNPTrmbIp47BXjrWLCnfKem9sISJVEi8veRihSyNPbITn9UT0yiM/tbcWPTNdb2vDdJxYL/00OcwU6Dw7p8FnlbqSkgSh9TdNrmh/5C8iJYMETPPhFGyxlH4dcbWDng9hmDWluJK7dJTM75rUH3WJk=
Received: from MN2PR14CA0023.namprd14.prod.outlook.com (2603:10b6:208:23e::28)
 by DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Wed, 29 Apr
 2026 01:53:29 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::64) by MN2PR14CA0023.outlook.office365.com
 (2603:10b6:208:23e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Wed,
 29 Apr 2026 01:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 01:53:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Apr
 2026 20:53:27 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Apr
 2026 20:53:26 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Tue, 28 Apr 2026 20:53:18 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 10/17] drm/amd/display: Fix type mismatches in DC and DMUB
 modules
Date: Wed, 29 Apr 2026 09:19:19 +0800
Message-ID: <20260429012055.2065869-11-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429012055.2065869-1-PingLei.Lin@amd.com>
References: <20260429012055.2065869-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: PingLei.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS7PR12MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: c564bb08-8d80-4b0a-27ce-08dea5921ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RJsOZfru5tbOLYz1iRpRtW9sUmYJcEavq531RMwYR1sEnnyq4KS/xTuvsYE4ifttCoPJAVPmRqKlr7tjbuMzW/xWU4Uuyn3PgNLIEhblYP7UcqpKQR0sFAB6n1L+Y8gW9ekwy1xsD4ir9z3zVjaccmxHZJo//wK37uDHirqeF24RtOTn5GLWKfInymezK/uO9Mshb46q/7rlelsMB66Uy+o/EPelt6gytnIbCYSNTpP07FKZQTHoKuLweOhJZC8eu5w6g2Dgb6hFICENPbwDQeOaAe8/ctZp6ddwftZwO47xqpDcXYKDqVj4zTttvUJmngqCKhMDlHzUXqpDsOZq1mCJcBcXkoXcusfaUoMZeWUvZ7HOQsplwdtmauKBimr1m2dteCDPzzIUHrWLBeBQcz8DtrmaSmK/DN5TAV8DNa6VNsYXHoDGlkD5XB+Kv1KuGiYgCADqJY1ohaIA3Hev+BHXBP7cWXeuQEcLxJ7GPVIep7bIZEXel79FbuQK2P/O7JCyso7U0fCJ9Jj2ILkJPiX9odW2cFoTlqV5CobCPN9HQpqtNRKtAZK02iSeQe2FVmD88SY+X9GaJ5bhgIBlKSJeaNHZhupvzfnu0Gx5Myi3oZKgMfvkM9Qe0dnKpv/yeEEIbXlypsfm0IW8mZs+FE5BIXMo7ff2Hi8NiEK93tb24QUzm0g2HuTfCKHbZkV90P5WDhOdefswLFVfW5RO2hnxheRZBp+x1LD6x4YOOQmxXfZ8K5zhc+zg8RzgFZGQQveo3VzFy0n7GAnKAgcXVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vZwHoV7oLz7/oI/PI5zUrb2/ZljeElr0gyTyAmF5uv3FcyTHbzyKk1Et82ZpTuQDiUou7aVM88cNnexUciFQMxvd5Mz5nfMg/QTlzhmJplLiz+nHI/l6Fdde7AsyU8oRZAm6x9ZHB9iTz6FUsatKssL+oRp1PfFmDX8uBLwf/kwM8VgcuQ/w0YWfGh2AEXoAFAdmBxgVT/hG5y33S+coiPggvBovXSyCV3WTb8AKz7E1GstcOnuEk+bNpWA+fWd+mXGk2WgGbFlfbe6Eka7xKJRbTlQbOk5pyz0sDoLtbVgf+IVsUCpzPV+3GtleorrNAjI0iW/17dm+drnycKi3B0sVlYnogulu2GSdHrDEYVdTPDSt4Ga3QOE3BPR/VKIK9x/bskny3X7n/0UfmN/TOF76viTLx7XTxpR0bEhu8xYsMmDRDCcn32x1SeBq2QNV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:53:28.0602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c564bb08-8d80-4b0a-27ce-08dea5921ba8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6191
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why]
Address signed/unsigned comparison warnings across dc paths to keep
builds warning-clean and improve type safety at comparison boundaries.
Most warnings came from signed loop/index temporaries compared against
unsigned counters and table sizes, plus a smaller number of mixed
signed/unsigned clock, bandwidth, and geometry comparisons.

[How]
Aligned loop/index and bound types in the affected modules and DMUB
sources, including color, freesync, power, stats, and vmid paths.
Used unsigned iterators where bounds/counters are unsigned, preserved
signed types where negative values are meaningful, and updated related
format specifiers where type changes required it. Changes are limited to
warning resolution and type alignment.

No functional behavior change is intended.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |  2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |  2 +-
 .../amd/display/modules/color/color_gamma.c   | 12 +++++-----
 .../gpu/drm/amd/display/modules/power/power.c | 22 +++++++++----------
 .../gpu/drm/amd/display/modules/vmid/vmid.c   |  6 ++---
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
index e5a78df80d72..3444eb7d7d81 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
@@ -535,7 +535,7 @@ void dmub_dcn401_send_reg_inbox0_cmd_msg(struct dmub_srv *dmub,
 		union dmub_rb_cmd *cmd)
 {
 	uint32_t *dwords = (uint32_t *)cmd;
-	int32_t payload_size_bytes = cmd->cmd_common.header.payload_bytes;
+	uint32_t payload_size_bytes = cmd->cmd_common.header.payload_bytes;
 	uint32_t msg_index;
 	static_assert(sizeof(*cmd) == 64, "DMUB command size mismatch");
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
index a09aa19ad379..e86fcfc74985 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
@@ -429,7 +429,7 @@ void dmub_dcn42_send_reg_inbox0_cmd_msg(struct dmub_srv *dmub,
 		union dmub_rb_cmd *cmd)
 {
 	uint32_t *dwords = (uint32_t *)cmd;
-	int32_t payload_size_bytes = cmd->cmd_common.header.payload_bytes;
+	uint32_t payload_size_bytes = cmd->cmd_common.header.payload_bytes;
 	uint32_t msg_index;
 	static_assert(sizeof(*cmd) == 64, "DMUB command size mismatch");
 
diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 0f9e8a11df0d..b79ca7a2eedc 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -364,7 +364,7 @@ void precompute_pq(void)
 /* one-time pre-compute dePQ values - only for max pixel value 125 FP16 */
 void precompute_de_pq(void)
 {
-	int i;
+	uint32_t i;
 	struct fixed31_32  y;
 	uint32_t begin_index, end_index;
 
@@ -783,7 +783,7 @@ static struct fixed31_32 calculate_mapped_value(
 	struct pwl_float_data *rgb,
 	const struct pixel_gamma_point *coeff,
 	enum channel_name channel,
-	uint32_t max_index)
+	int32_t max_index)
 {
 	const struct gamma_point *point;
 
@@ -1425,7 +1425,7 @@ static void apply_lut_1d(
 		uint32_t num_hw_points,
 		struct dc_transfer_func_distributed_points *tf_pts)
 {
-	int i = 0;
+	uint32_t i = 0;
 	int color = 0;
 	struct fixed31_32 *regamma_y;
 	struct fixed31_32 norm_y;
@@ -1569,7 +1569,7 @@ static bool calculate_interpolated_hardware_curve(
 {
 
 	const struct pixel_gamma_point *coeff = coeff128;
-	uint32_t max_entries = 3 - 1;
+	int32_t max_entries = 3 - 1;
 
 	uint32_t i = 0;
 
@@ -1581,7 +1581,7 @@ static bool calculate_interpolated_hardware_curve(
 	}
 
 	i = 0;
-	max_entries += ramp->num_entries;
+	max_entries += (int32_t)ramp->num_entries;
 
 	/* TODO: float point case */
 
@@ -1635,7 +1635,7 @@ static bool map_regamma_hw_to_x_user(
 {
 	/* setup to spare calculated ideal regamma values */
 
-	int i = 0;
+	uint32_t i = 0;
 	struct hw_x_point *coords = coords_x;
 	const struct pwl_float_data_ex *regamma = rgb_regamma;
 
diff --git a/drivers/gpu/drm/amd/display/modules/power/power.c b/drivers/gpu/drm/amd/display/modules/power/power.c
index 5cef60079d67..1ee671119ddd 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power.c
@@ -125,7 +125,7 @@ struct core_power {
 	bool psr_smu_optimizations_support;
 	bool multi_disp_optimizations_support;
 
-	int num_entities;
+	unsigned int num_entities;
 };
 
 union dmcu_abm_set_bl_params {
@@ -628,7 +628,7 @@ bool mod_power_hw_init(struct mod_power *mod_power)
 	struct dc *dc = NULL;
 	struct dmcu *dmcu = NULL;
 	struct dmcu_iram_parameters params;
-	int i;
+	unsigned int i;
 
 	if (mod_power == NULL)
 		return false;
@@ -668,7 +668,7 @@ struct mod_power *mod_power_create(struct dc *dc,
 {
 	struct core_power *core_power = NULL;
 	int i = 0;
-	int abm_max_config = 0;
+	unsigned int abm_max_config = 0;
 	unsigned int inst = 0;
 	bool is_brightness_range_valid = false;
 
@@ -854,7 +854,7 @@ struct mod_power *mod_power_create(struct dc *dc,
 void mod_power_destroy(struct mod_power *mod_power)
 {
 	if (mod_power != NULL) {
-		int i;
+		unsigned int i;
 		struct core_power *core_power =
 				MOD_POWER_TO_CORE(mod_power);
 
@@ -903,7 +903,7 @@ bool mod_power_add_stream(struct mod_power *mod_power,
 
 	DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
 						WPP_BIT_FLAG_Firmware_PsrState,
-						"mod_power: add_stream: ERROR: stream=%p num_entities=%d >= MOD_POWER_MAX_CONCURRENT_STREAMS",
+						"mod_power: add_stream: ERROR: stream=%p num_entities=%u >= MOD_POWER_MAX_CONCURRENT_STREAMS",
 						stream,
 						core_power->num_entities);
 
@@ -913,7 +913,7 @@ bool mod_power_add_stream(struct mod_power *mod_power,
 bool mod_power_remove_stream(struct mod_power *mod_power,
 		const struct dc_stream_state *stream)
 {
-	int i = 0;
+	unsigned int i = 0;
 	struct core_power *core_power = NULL;
 	unsigned int index = 0;
 
@@ -938,7 +938,7 @@ bool mod_power_remove_stream(struct mod_power *mod_power,
 		BREAK_TO_DEBUGGER();
 		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
 							WPP_BIT_FLAG_Firmware_PsrState,
-							"mod_power: remove_stream: ERROR: index=%u >= num_entities=%d stream=%p",
+							"mod_power: remove_stream: ERROR: index=%u >= num_entities=%u stream=%p",
 							index,
 							core_power->num_entities,
 							stream);
@@ -1004,7 +1004,7 @@ bool mod_power_replace_stream(struct mod_power *mod_power,
 		BREAK_TO_DEBUGGER();
 		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
 							WPP_BIT_FLAG_Firmware_PsrState,
-							"mod_power: replace_stream: ERROR: index=%u >= num_entities=%d stream=%p",
+							"mod_power: replace_stream: ERROR: index=%u >= num_entities=%u stream=%p",
 							index,
 							core_power->num_entities,
 							current_stream);
@@ -1432,7 +1432,7 @@ bool mod_power_get_hw_backlight_aux_nits(struct mod_power *mod_power,
 {
 	struct core_power *core_power = NULL;
 	struct dc_link *link = NULL;
-	unsigned int stream_index;
+	int stream_index;
 
 	if (mod_power == NULL)
 		return false;
@@ -1910,7 +1910,7 @@ static bool set_psr_enable(struct mod_power *mod_power,
 	if (core_power->num_entities == 0) {
 		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
 							WPP_BIT_FLAG_Firmware_PsrState,
-							"set psr enable: ERROR: stream=%p num_entities=%d",
+							"set psr enable: ERROR: stream=%p num_entities=%u",
 							stream,
 							core_power->num_entities);
 		return false;
@@ -2043,7 +2043,7 @@ bool mod_power_set_psr_event(struct mod_power *mod_power,
 	if (core_power->num_entities == 0) {
 		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
 							WPP_BIT_FLAG_Firmware_PsrState,
-							"mod_power set_psr_event: ERROR: stream=%p event=%d num_entities=%d",
+							"mod_power set_psr_event: ERROR: stream=%p event=%d num_entities=%u",
 							stream,
 							(int)event,
 							core_power->num_entities);
diff --git a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c b/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
index 0f8fab5f5c6a..e3b2d78af014 100644
--- a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
+++ b/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
@@ -56,7 +56,7 @@ static void clear_entry_from_vmid_table(struct core_vmid *core_vmid, unsigned in
 
 static void evict_vmids(struct core_vmid *core_vmid)
 {
-	int i;
+	unsigned int i;
 	int ord_int = dc_get_vmid_use_vector(core_vmid->dc);
 
 	ASSERT(ord_int >= 0 && ord_int <= 0xFFFF);
@@ -72,7 +72,7 @@ static void evict_vmids(struct core_vmid *core_vmid)
 // Return value of -1 indicates vmid table uninitialized or ptb dne in the table
 static int get_existing_vmid_for_ptb(struct core_vmid *core_vmid, uint64_t ptb)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < core_vmid->num_vmid; i++) {
 		if (core_vmid->ptb_assigned_to_vmid[i] == ptb)
@@ -85,7 +85,7 @@ static int get_existing_vmid_for_ptb(struct core_vmid *core_vmid, uint64_t ptb)
 // Expected to be called only when there's an available vmid
 static int get_next_available_vmid(struct core_vmid *core_vmid)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 1; i < core_vmid->num_vmid; i++) {
 		if (core_vmid->ptb_assigned_to_vmid[i] == 0)
-- 
2.43.0

