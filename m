Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F099C52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED4E110E70B;
	Wed, 21 Aug 2024 22:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZXXLPeQp";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F9AA10E709
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCrTRe2oDlvtJCS0mvudi6m+mqaTiW5AXVrvcbFPikZrloyaHS9bT+E1PTgKijSzzDwzKsdArA45rqy8iR5dEOy/TwodDNskj0H6no/cgr9IdePymBupDjiHMRhFEwPDBOeqwFXOuQm1MSEainttVjDWOazovCdga8WMEqZrrZ0upsIJQk5W6U6PwAAZqEJUdddthyGFZs2ulf8jJlaGlCsJfo8/eYRYpLi/0UiIiedGrVMu2U6a1fGsbVdZbsAZxTZY9D14VJkxDDZz3AZt7/gTVHr21BkIjSa0XPVo7V6Kz0cS8GKTkQUid+Jtg6E1/TqH1vkJNYhLbGjoell2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hX8yIcVgFeeljDDIEvppyNAS1mDEX/GtEaLc7YxVTeY=;
 b=VmBnS24OTEG2TpxRxzqBq6V8rr38ghZ+Kcnhx1/2ZZlrTYcI9h8a3u+RXyrmqpSPRKHCKmsDlpVcHPcFJsmDC82IjO1E5ZQZrRmDV/z93oIEqmc4nvBPyHRQcdxuZgC9WS+rxqfUTC+frP81BUqXjzaIg7XS2BnPXAQRPHoImNNmMDJ67A5axK0AqP25pHmQYjSnUcMswMOahgHRALRiJtawZKqlQN0aKe3R/itCSuaIkFdD01w5lmqQPu6r2TwUmdA06dKBCgznjxl1Tpd8VSvgkc4iOht3OAnHKV0RVuEOjnKH7t3WbHqr32w4geVHVeVt9D+Pgw9eqyY7H61Ttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hX8yIcVgFeeljDDIEvppyNAS1mDEX/GtEaLc7YxVTeY=;
 b=ZXXLPeQpkWAo1/SzFlZsWXqakCl3bUKGBhJZlO/brILXJuYarnIHpAg4JwRf60Bk3PYtD5tprndP8k10factDyulf3HRcuMmZ7SWYJN3b1qXlSY8jMzje8gyFhq2A0uQz7hqgDa4Qy7o1ZEpMYft8VU+utloxAaT/mrgCqgR/9o=
Received: from BN9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::11)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 22:04:48 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::3) by BN9P223CA0006.outlook.office365.com
 (2603:10b6:408:10b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Wed, 21 Aug 2024 22:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:04:47 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:04:44 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Subject: [PATCH 10/16] drm/amd/display: Notify DMCUB of D0/D3 state
Date: Wed, 21 Aug 2024 18:01:52 -0400
Message-ID: <20240821220156.1498549-11-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 445ee8f7-1400-45c1-ef4e-08dcc22d45a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tRcPFA6W/lZsTa8QI5bcTK4VUGJ5m3n+d6wAuAS77EEz6j4FKkq95yHkWpqR?=
 =?us-ascii?Q?E/WEh9Pkrlb9uOQmzvMw6yzqTE3maw/rsryJ9ysd1IX8qkaz+3LxS/+8F6Va?=
 =?us-ascii?Q?o0QYEhofD4KfAJFFOYyH9puecVwtLhUnHMxjC3R0lADYmcH7jvzrGZz82YW0?=
 =?us-ascii?Q?OgE6ajNUphtRGK478dqkHCLd1hW8QtzPHrjhstbJNxnU+ZwwRTgI6rM5L0rS?=
 =?us-ascii?Q?BwnMX93grKiU1DXEvBAIwQxi+Jnixk7KAZZZO4hikQQgCULfguwgKj38JcA3?=
 =?us-ascii?Q?6dsKPYt2ysyyq3zgsLxcAkH3r7MSLNhY8cvmJ9Fv43BlmkPqm/Hoi+G90/Df?=
 =?us-ascii?Q?DO9XYlGy9Gt6BA8XvaBwYbVxV9rZe+Hm5LRcBV4SI+EuP0QNIQcgsPwBFgO0?=
 =?us-ascii?Q?ScJ1sMOgxlOZGQUQ1UyfszMmhZ4ICrLx8HcR+YldTmqHAlG5IxZA+wUzHbDw?=
 =?us-ascii?Q?w8bDyLjg1pP3fQHH1F2zLnWdNrRjNcuexWQ2bg8nONPMPCbeBZ9yEic8QjU8?=
 =?us-ascii?Q?+0F/Dgmksu5so/iDqnp24mBtn3S+e+3CC5GX7tN4DdipDmUrbhjMmWLv4+qc?=
 =?us-ascii?Q?wprMZOci/8uu8UP1yHDKlumb4tNB4ZgecMxGNgjpqaNwz/ArLVyxoWM2BqDG?=
 =?us-ascii?Q?Q8h/h4Cq0YHKobQP1ug/Q5dFJ8M4XW52G/hl+krYQb0mIK/3L4BHRT2wyDYO?=
 =?us-ascii?Q?9nHvq3G0U5F/nvFJ0bBBLl+P0EJnXoFbgFitoMBSLLrBqsd84wdC/C+jv0bZ?=
 =?us-ascii?Q?V37DOHEbtSEfUT8IHnLT4M5jX+BefQLp19Nh7PlM83cMfd9Rpu0vUnY3v6QJ?=
 =?us-ascii?Q?tiTF5jJpAxTrbRgrKheqqpPSTHx6VxXKrpEUeB+3FGbtsf0UXZQ13R7JViPZ?=
 =?us-ascii?Q?e6W9pbZ5OtENq+nPGhNt2cxMLbHSfT9/jkVVlfQxgAd6+4JPHVRvti05yhLg?=
 =?us-ascii?Q?SljDOtSWsLw32grRfkiQx/N0Rcjdb0soJAOuLwqVYdUxyEV8qjj5L7l6Pd2+?=
 =?us-ascii?Q?aoPmcr8lhmnWu1KqzJphYHaaCcDJNMyIRABzf/z9pUpo6wnSUcyTVr27Y72F?=
 =?us-ascii?Q?JKa8RryrmdU2Znb3ywQuYyJRQmcatzCKOWICBQyiE7ormgG8XP/grkS7E0wV?=
 =?us-ascii?Q?Pf103aKd6IkLW32IjSHBL0VnTstEvbo87v/oDBCzI5bDUELmkiWpjmon+pgY?=
 =?us-ascii?Q?o83uuaQa2P5wlCk0T6c2EiXhNuK2/B79OnBt67gRJtu1A5PLA2YJOT0v/XY5?=
 =?us-ascii?Q?Dc6sZAbMUdhIZlTycYaOSRMtsx0tEMuypZplV+957yL7yjbgx6PFrxqCSwlS?=
 =?us-ascii?Q?NpYbBx36PFlLFDr9MVsL6H2xrYXaeluCRCe5FUt8OMZWEK56HSL/0MBrN3Hg?=
 =?us-ascii?Q?ySw7+EoX9yIFPNsXl916r+Z0QxVSf4Lf+K+fXuGkyDTCZr6u07qmBJsaUJ5e?=
 =?us-ascii?Q?cHLlI4L6daae7shm5UHbrUF5CTH9gu7K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:04:47.6896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445ee8f7-1400-45c1-ef4e-08dcc22d45a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736
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
We want to avoid arming the HPD timer in firmware when preparing for
S0i3 entry when DC is considered in D3.

[How]
Notify DMCUB of the power state transitions so it can decide to arm
the HPD timer for idle in DCN35 only in D0.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <Ovidiu.Bunea@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 30 ++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  | 24 +++++++++++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 38 ++++++++++++++++++-
 4 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c8dabb081b3d..e07e47d74664 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5161,6 +5161,8 @@ void dc_set_power_state(struct dc *dc, enum dc_acpi_cm_power_state power_state)
 
 		dc_z10_restore(dc);
 
+		dc_dmub_srv_notify_fw_dc_power_state(dc->ctx->dmub_srv, power_state);
+
 		dc->hwss.init_hw(dc);
 
 		if (dc->hwss.init_sys_ctx != NULL &&
@@ -5172,6 +5174,8 @@ void dc_set_power_state(struct dc *dc, enum dc_acpi_cm_power_state power_state)
 	default:
 		ASSERT(dc->current_state->stream_count == 0);
 
+		dc_dmub_srv_notify_fw_dc_power_state(dc->ctx->dmub_srv, power_state);
+
 		dc_state_destruct(dc->current_state);
 
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index b1265124608b..1e7de0f03290 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1476,7 +1476,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		ips2_exit_count);
 }
 
-void dc_dmub_srv_set_power_state(struct dc_dmub_srv *dc_dmub_srv, enum dc_acpi_cm_power_state powerState)
+void dc_dmub_srv_set_power_state(struct dc_dmub_srv *dc_dmub_srv, enum dc_acpi_cm_power_state power_state)
 {
 	struct dmub_srv *dmub;
 
@@ -1485,12 +1485,38 @@ void dc_dmub_srv_set_power_state(struct dc_dmub_srv *dc_dmub_srv, enum dc_acpi_c
 
 	dmub = dc_dmub_srv->dmub;
 
-	if (powerState == DC_ACPI_CM_POWER_STATE_D0)
+	if (power_state == DC_ACPI_CM_POWER_STATE_D0)
 		dmub_srv_set_power_state(dmub, DMUB_POWER_STATE_D0);
 	else
 		dmub_srv_set_power_state(dmub, DMUB_POWER_STATE_D3);
 }
 
+void dc_dmub_srv_notify_fw_dc_power_state(struct dc_dmub_srv *dc_dmub_srv,
+					  enum dc_acpi_cm_power_state power_state)
+{
+	union dmub_rb_cmd cmd;
+
+	if (!dc_dmub_srv)
+		return;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.idle_opt_set_dc_power_state.header.type = DMUB_CMD__IDLE_OPT;
+	cmd.idle_opt_set_dc_power_state.header.sub_type = DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE;
+	cmd.idle_opt_set_dc_power_state.header.payload_bytes =
+		sizeof(cmd.idle_opt_set_dc_power_state) - sizeof(cmd.idle_opt_set_dc_power_state.header);
+
+	if (power_state == DC_ACPI_CM_POWER_STATE_D0) {
+		cmd.idle_opt_set_dc_power_state.data.power_state = DMUB_IDLE_OPT_DC_POWER_STATE_D0;
+	} else if (power_state == DC_ACPI_CM_POWER_STATE_D3) {
+		cmd.idle_opt_set_dc_power_state.data.power_state = DMUB_IDLE_OPT_DC_POWER_STATE_D3;
+	} else {
+		cmd.idle_opt_set_dc_power_state.data.power_state = DMUB_IDLE_OPT_DC_POWER_STATE_UNKNOWN;
+	}
+
+	dc_wake_and_execute_dmub_cmd(dc_dmub_srv->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+}
+
 bool dc_dmub_srv_should_detect(struct dc_dmub_srv *dc_dmub_srv)
 {
 	volatile const struct dmub_shared_state_ips_fw *ips_fw;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 580940222777..42f0cb672d8b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -109,7 +109,29 @@ bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait);
 
 void dc_dmub_srv_apply_idle_power_optimizations(const struct dc *dc, bool allow_idle);
 
-void dc_dmub_srv_set_power_state(struct dc_dmub_srv *dc_dmub_srv, enum dc_acpi_cm_power_state powerState);
+/**
+ * dc_dmub_srv_set_power_state() - Sets the power state for DMUB service.
+ *
+ * Controls whether messaging the DMCUB or interfacing with it via HW register
+ * interaction is permittable.
+ *
+ * @dc_dmub_srv - The DC DMUB service pointer
+ * @power_state - the DC power state
+ */
+void dc_dmub_srv_set_power_state(struct dc_dmub_srv *dc_dmub_srv, enum dc_acpi_cm_power_state power_state);
+
+/**
+ * dc_dmub_srv_notify_fw_dc_power_state() - Notifies firmware of the DC power state.
+ *
+ * Differs from dc_dmub_srv_set_power_state in that it needs to access HW in order
+ * to message DMCUB of the state transition. Should come after the D0 exit and
+ * before D3 set power state.
+ *
+ * @dc_dmub_srv - The DC DMUB service pointer
+ * @power_state - the DC power state
+ */
+void dc_dmub_srv_notify_fw_dc_power_state(struct dc_dmub_srv *dc_dmub_srv,
+					  enum dc_acpi_cm_power_state power_state);
 
 /**
  * @dc_dmub_srv_should_detect() - Checks if link detection is required.
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index c5f99cbff0b6..f5dda1d69ae0 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1879,7 +1879,12 @@ enum dmub_cmd_idle_opt_type {
 	/**
 	 * DCN hardware notify idle.
 	 */
-	DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE = 2
+	DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE = 2,
+
+	/**
+	 * DCN hardware notify power state.
+	 */
+	DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE = 3,
 };
 
 /**
@@ -1906,6 +1911,33 @@ struct dmub_rb_cmd_idle_opt_dcn_notify_idle {
 	struct dmub_dcn_notify_idle_cntl_data cntl_data;
 };
 
+/**
+ * enum dmub_idle_opt_dc_power_state - DC power states.
+ */
+enum dmub_idle_opt_dc_power_state {
+	DMUB_IDLE_OPT_DC_POWER_STATE_UNKNOWN = 0,
+	DMUB_IDLE_OPT_DC_POWER_STATE_D0 = 1,
+	DMUB_IDLE_OPT_DC_POWER_STATE_D1 = 2,
+	DMUB_IDLE_OPT_DC_POWER_STATE_D2 = 4,
+	DMUB_IDLE_OPT_DC_POWER_STATE_D3 = 8,
+};
+
+/**
+ * struct dmub_idle_opt_set_dc_power_state_data - Data passed to FW in a DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE command.
+ */
+struct dmub_idle_opt_set_dc_power_state_data {
+	uint8_t power_state; /**< power state */
+	uint8_t pad[3]; /**< padding */
+};
+
+/**
+ * struct dmub_rb_cmd_idle_opt_set_dc_power_state - Data passed to FW in a DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE command.
+ */
+struct dmub_rb_cmd_idle_opt_set_dc_power_state {
+	struct dmub_cmd_header header; /**< header */
+	struct dmub_idle_opt_set_dc_power_state_data data;
+};
+
 /**
  * struct dmub_clocks - Clock update notification.
  */
@@ -5298,6 +5330,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE command.
 	 */
 	struct dmub_rb_cmd_idle_opt_dcn_notify_idle idle_opt_notify_idle;
+	/**
+	 * Definition of a DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE command.
+	 */
+	struct dmub_rb_cmd_idle_opt_set_dc_power_state idle_opt_set_dc_power_state;
 	/*
 	 * Definition of a DMUB_CMD__REPLAY_COPY_SETTINGS command.
 	 */
-- 
2.34.1

