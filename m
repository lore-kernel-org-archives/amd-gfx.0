Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BE0EE49A0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9278A10E45C;
	Wed, 23 Aug 2023 15:52:01 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E760E10E446
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN+AQlVGKFOWlyhgRBSYCKBj78hqUAKeJDKGMjVTVo1o2xZFkcFQhq3/Dw/y3cDebjuAXdrF3joNiTYqnq7AArNiz/SE0GUejauG3AwyshBOrrd+E7jYfuE3z2wxhz8HGPydJ7w6P5ynhwJzJqhwQmM4eSd/yZdN3YHR0mLtHAI1q1GuRPJjI/5Q2v7D0nBJR+RxAVwZjljUQY/2cquyykrierV2v7VEnA19vB1uFdTkGxp5lkqEYt5DAV/pNkoZJ3bEPXgcJsY/plgv5VJB5jYBo5s0OkDuG8KpcB9STrg6w6MFdsUdRsvMRkf4nGhKCRMTRgnp7d5pKPnIOO5VJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1c8NBqGSdeDdyxVNFUFxqDZKI0gPSGxZgz9lV/OQeA=;
 b=AuHKM80da8isgEmUqUafbKhM78I3mieGMi/a5fiM/QF1ljYAwdRln9/5y+mg3O9x9WvC+BlNiOvnveAWnqzB1Y/QNvZKXy+4KQS2nvN38YA9QD4NLGVQ+1SAGTb1r8f11mD+gyJeS7fIeCIlCh+NCG90S0trBc08Bxy4U4jG2RBHNDMs8Bg+wysxbU6IobPaiTfT7IFPKhSE89xaMjzkPFkFy5pv/LgiQmT6ZJmDSyyOpOatOYE3m4q516YQ95qhBvJkVoDD4Qr5ZpmRi9lvLWH65QstB0zXsnVugSCstseKfIntf+jJhykUgCSqUa7Lcs2kF7JOWmQXVnzYYoJVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1c8NBqGSdeDdyxVNFUFxqDZKI0gPSGxZgz9lV/OQeA=;
 b=LcMe+z6m5vz1udxUFFQ4HjtSnOSuuf7RvvNJBJDrrANjxGmRNGqQW3+LvR+2BTheBykTa3rboKYayXfQC4hr2zfhbaueB3ZHN9G8C7AlVzWNFeBrNUNJrynXIVGgc5ip6Ip2tP0h4DS1MonYvNtRwIQ5qJOdzQoaxIu59KV/xBk=
Received: from CY5PR19CA0034.namprd19.prod.outlook.com (2603:10b6:930:1a::13)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:51:26 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::f5) by CY5PR19CA0034.outlook.office365.com
 (2603:10b6:930:1a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/35] drm/amd/display: Add DCN35 DMUB
Date: Wed, 23 Aug 2023 11:50:41 -0400
Message-ID: <20230823155048.2526343-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5205d7-2f2d-4234-01bb-08dba3f0cee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RyTwQ3jnSM+/tVoHaTqVSV2B6b6+7xVzg7/EPmQzooOjfSbczS0P+L7W7JdojFSp0bfhVwUtilkygTqw/++F4wISU35UbUfod3h0j3LwPM/X9tR49izLF/sDs3+qHJw++sD1iaKIdUcZTgDeJK2lMpjhc4xO6OxOSuN8+fln7lH8934ecsqx6MPPDRB1VjUv2FdpbkHT5Wu6r6aORvbAUX69O6Cl70yqZk26iMB+HpUQDpR472ri94i7mGT+rlC/LSl8pjM6IMJFdlj9vptDW7Qg/IWjc90rp4UulRzbUqtZMtaM6k+MJXdkC40Q11Jhv3qDdQOjbeaPIBcdsNQ+45LQeW+yqAsxnP1N9LVACnfiEX4YhqwzvcP/tfRKWis2jNX4Z6Z9T7d9NCWNsFP6AjOlDTL4WvqTbsJInhC5nEe78htYnYgNmjJl0ZBPLbzFHV4HLkjkJ2smn8rbl18NtYzzTtn9X18d6NmuR3vcZTqpXYhaNFSz7N7Bm95CfhEs6vH+1udUkvVpeVNs64surxkYXj7hapiOXd8HcCoB6GoMja85HZDGMU57GImMcv8KQR5cLIvRCC9Z1JZ+p/tNy/glAy+/DJUfL6fon+qxuFZ/GSuLZeA+oiR9lu6ebwAIZsEY2BxQCgj/a0Hg7SzUWXNmdVcjo0472y/W6sKBzgy3ieq/6mUwPLjTRmLxSLbasdYNE/GpNQQKSy7nHf7p6rp0y/ydSx9jQwNsuup5VsNrxOVffwiMxIj9pr5D3oRd85Pw7MN2am0/jjYi9Tcl0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(6916009)(316002)(70586007)(70206006)(66899024)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(30864003)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(5660300002)(26005)(16526019)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:26.0228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5205d7-2f2d-4234-01bb-08dba3f0cee0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Add DMUB handling for DCN35.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  64 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   3 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  23 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c | 552 ++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.h | 282 +++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  76 ++-
 7 files changed, 999 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index b46a26a8ad4c..979f52ee5604 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -32,6 +32,7 @@
 #include "../basics/conversion.h"
 #include "cursor_reg_cache.h"
 #include "resource.h"
+#include "clk_mgr.h"
 
 #define CTX dc_dmub_srv->ctx
 #define DC_LOGGER CTX->logger
@@ -1061,4 +1062,65 @@ void dc_dmub_srv_enable_dpia_trace(const struct dc *dc)
 void dc_dmub_srv_subvp_save_surf_addr(const struct dc_dmub_srv *dc_dmub_srv, const struct dc_plane_address *addr, uint8_t subvp_index)
 {
 	dmub_srv_subvp_save_surf_addr(dc_dmub_srv->dmub, addr, subvp_index);
-}
\ No newline at end of file
+}
+
+bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
+{
+	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
+	enum dmub_status status;
+
+	if (dc_dmub_srv->ctx->dc->debug.dmcub_emulation)
+		return true;
+
+	if (wait) {
+		status = dmub_srv_wait_for_hw_pwr_up(dc_dmub_srv->dmub, 500000);
+		if (status != DMUB_STATUS_OK) {
+			DC_ERROR("Error querying DMUB hw power up status: error=%d\n", status);
+			return false;
+		}
+	} else
+		return dmub_srv_is_hw_pwr_up(dc_dmub_srv->dmub);
+
+	return true;
+}
+
+void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
+{
+	union dmub_rb_cmd cmd = {0};
+
+	if (dc->debug.dmcub_emulation)
+		return;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.idle_opt_notify_idle.header.type = DMUB_CMD__IDLE_OPT;
+	cmd.idle_opt_notify_idle.header.sub_type = DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE;
+	cmd.idle_opt_notify_idle.header.payload_bytes =
+		sizeof(cmd.idle_opt_notify_idle) -
+		sizeof(cmd.idle_opt_notify_idle.header);
+
+	cmd.idle_opt_notify_idle.cntl_data.driver_idle = allow_idle;
+
+	dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	if (allow_idle)
+		udelay(500);
+}
+
+void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
+{
+	if (dc->debug.dmcub_emulation)
+		return;
+	// Tell PMFW to exit low power state
+	if (dc->clk_mgr->funcs->exit_low_power_state)
+		dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
+
+	// Wait for dmcub to load up
+	dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true);
+
+	// Notify dmcub disallow idle
+	dc_dmub_srv_notify_idle(dc, false);
+
+	// Confirm dmu is powered up
+	dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true);
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 2ebd4717f4a2..31150b214394 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -91,4 +91,7 @@ bool dc_dmub_check_min_version(struct dmub_srv *srv);
 void dc_dmub_srv_enable_dpia_trace(const struct dc *dc);
 void dc_dmub_srv_subvp_save_surf_addr(const struct dc_dmub_srv *dc_dmub_srv, const struct dc_plane_address *addr, uint8_t subvp_index);
 
+bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait);
+void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle);
+void dc_dmub_srv_exit_low_power_state(const struct dc *dc);
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index e7a50cbf2540..261a23fe33c7 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -104,6 +104,7 @@ enum dmub_asic {
 	DMUB_ASIC_DCN316,
 	DMUB_ASIC_DCN32,
 	DMUB_ASIC_DCN321,
+	DMUB_ASIC_DCN35,
 	DMUB_ASIC_MAX,
 };
 
@@ -264,6 +265,7 @@ struct dmub_srv_hw_params {
 	bool dpia_hpd_int_enable_supported;
 	bool disable_clock_gate;
 	bool disallow_dispclk_dppclk_ds;
+	enum dmub_ips_disable_type disable_ips;
 };
 
 /**
@@ -371,6 +373,7 @@ struct dmub_srv_hw_funcs {
 	bool (*is_psrsu_supported)(struct dmub_srv *dmub);
 
 	bool (*is_hw_init)(struct dmub_srv *dmub);
+	bool (*is_hw_powered_up)(struct dmub_srv *dmub);
 
 	void (*enable_dmub_boot_options)(struct dmub_srv *dmub,
 				const struct dmub_srv_hw_params *params);
@@ -418,6 +421,7 @@ struct dmub_srv_create_params {
 	struct dmub_srv_base_funcs funcs;
 	struct dmub_srv_hw_funcs *hw_funcs;
 	void *user_ctx;
+	struct dc_context *dc_ctx;
 	enum dmub_asic asic;
 	uint32_t fw_version;
 	bool is_virtual;
@@ -443,6 +447,7 @@ struct dmub_srv {
 	const struct dmub_srv_common_regs *regs;
 	const struct dmub_srv_dcn31_regs *regs_dcn31;
 	struct dmub_srv_dcn32_regs *regs_dcn32;
+	struct dmub_srv_dcn35_regs *regs_dcn35;
 
 	struct dmub_srv_base_funcs funcs;
 	struct dmub_srv_hw_funcs hw_funcs;
@@ -650,6 +655,24 @@ enum dmub_status dmub_srv_cmd_queue(struct dmub_srv *dmub,
  */
 enum dmub_status dmub_srv_cmd_execute(struct dmub_srv *dmub);
 
+/**
+ * dmub_srv_wait_for_hw_pwr_up() - Waits for firmware hardware power up is completed
+ * @dmub: the dmub service
+ * @timeout_us: the maximum number of microseconds to wait
+ *
+ * Waits until firmware hardware is powered up. The maximum
+ * wait time is given in microseconds to prevent spinning forever.
+ *
+ * Return:
+ *   DMUB_STATUS_OK - success
+ *   DMUB_STATUS_TIMEOUT - timed out
+ *   DMUB_STATUS_INVALID - unspecified error
+ */
+enum dmub_status dmub_srv_wait_for_hw_pwr_up(struct dmub_srv *dmub,
+					     uint32_t timeout_us);
+
+bool dmub_srv_is_hw_pwr_up(struct dmub_srv *dmub);
+
 /**
  * dmub_srv_wait_for_auto_load() - Waits for firmware auto load to complete
  * @dmub: the dmub service
diff --git a/drivers/gpu/drm/amd/display/dmub/src/Makefile b/drivers/gpu/drm/amd/display/dmub/src/Makefile
index caf095aca8f3..08aaf84affaf 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/Makefile
+++ b/drivers/gpu/drm/amd/display/dmub/src/Makefile
@@ -24,6 +24,7 @@ DMUB = dmub_srv.o dmub_srv_stat.o dmub_reg.o dmub_dcn20.o dmub_dcn21.o
 DMUB += dmub_dcn30.o dmub_dcn301.o dmub_dcn302.o dmub_dcn303.o
 DMUB += dmub_dcn31.o dmub_dcn314.o dmub_dcn315.o dmub_dcn316.o
 DMUB += dmub_dcn32.o
+DMUB += dmub_dcn35.o
 
 AMD_DAL_DMUB = $(addprefix $(AMDDALPATH)/dmub/src/,$(DMUB))
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
new file mode 100644
index 000000000000..6d1fbea0f6ba
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -0,0 +1,552 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "../dmub_srv.h"
+#include "dc_types.h"
+#include "dmub_reg.h"
+#include "dmub_dcn35.h"
+#include "dc/dc_types.h"
+
+#include "dcn/dcn_3_5_0_offset.h"
+#include "dcn/dcn_3_5_0_sh_mask.h"
+
+#define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
+#define CTX dmub
+#define REGS dmub->regs_dcn35
+#define REG_OFFSET_EXP(reg_name) BASE(reg##reg_name##_BASE_IDX) + reg##reg_name
+
+void dmub_srv_dcn35_regs_init(struct dmub_srv *dmub, struct dc_context *ctx) {
+	struct dmub_srv_dcn35_regs *regs = dmub->regs_dcn35;
+#define REG_STRUCT regs
+
+#define DMUB_SR(reg) REG_STRUCT->offset.reg = REG_OFFSET_EXP(reg);
+	DMUB_DCN35_REGS()
+	DMCUB_INTERNAL_REGS()
+#undef DMUB_SR
+
+#define DMUB_SF(reg, field) REG_STRUCT->mask.reg##__##field = FD_MASK(reg, field);
+	DMUB_DCN35_FIELDS()
+#undef DMUB_SF
+
+#define DMUB_SF(reg, field) REG_STRUCT->shift.reg##__##field = FD_SHIFT(reg, field);
+	DMUB_DCN35_FIELDS()
+#undef DMUB_SF
+#undef REG_STRUCT
+}
+
+static void dmub_dcn35_get_fb_base_offset(struct dmub_srv *dmub,
+					  uint64_t *fb_base,
+					  uint64_t *fb_offset)
+{
+	uint32_t tmp;
+
+	/*
+	if (dmub->fb_base || dmub->fb_offset) {
+		*fb_base = dmub->fb_base;
+		*fb_offset = dmub->fb_offset;
+		return;
+	}
+	*/
+
+	REG_GET(DCN_VM_FB_LOCATION_BASE, FB_BASE, &tmp);
+	*fb_base = (uint64_t)tmp << 24;
+
+	REG_GET(DCN_VM_FB_OFFSET, FB_OFFSET, &tmp);
+	*fb_offset = (uint64_t)tmp << 24;
+}
+
+static inline void dmub_dcn35_translate_addr(const union dmub_addr *addr_in,
+					     uint64_t fb_base,
+					     uint64_t fb_offset,
+					     union dmub_addr *addr_out)
+{
+	addr_out->quad_part = addr_in->quad_part - fb_base + fb_offset;
+}
+
+void dmub_dcn35_reset(struct dmub_srv *dmub)
+{
+	union dmub_gpint_data_register cmd;
+	const uint32_t timeout = 100;
+	uint32_t in_reset, is_enabled, scratch, i, pwait_mode;
+
+	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
+
+	if (in_reset == 0) {
+		cmd.bits.status = 1;
+		cmd.bits.command_code = DMUB_GPINT__STOP_FW;
+		cmd.bits.param = 0;
+
+		dmub->hw_funcs.set_gpint(dmub, cmd);
+
+		/**
+		 * Timeout covers both the ACK and the wait
+		 * for remaining work to finish.
+		 */
+
+		for (i = 0; i < timeout; ++i) {
+			if (dmub->hw_funcs.is_gpint_acked(dmub, cmd))
+				break;
+
+			udelay(1);
+		}
+
+		for (i = 0; i < timeout; ++i) {
+			scratch = dmub->hw_funcs.get_gpint_response(dmub);
+			if (scratch == DMUB_GPINT__STOP_FW_RESPONSE)
+				break;
+
+			udelay(1);
+		}
+
+		for (i = 0; i < timeout; ++i) {
+			REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &pwait_mode);
+			if (pwait_mode & (1 << 0))
+				break;
+
+			udelay(1);
+		}
+		/* Force reset in case we timed out, DMCUB is likely hung. */
+	}
+
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_enabled);
+
+	if (is_enabled) {
+		REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
+		REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
+		REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
+	}
+
+	REG_WRITE(DMCUB_INBOX1_RPTR, 0);
+	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX1_WPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX0_RPTR, 0);
+	REG_WRITE(DMCUB_OUTBOX0_WPTR, 0);
+	REG_WRITE(DMCUB_SCRATCH0, 0);
+
+	/* Clear the GPINT command manually so we don't send anything during boot. */
+	cmd.all = 0;
+	dmub->hw_funcs.set_gpint(dmub, cmd);
+}
+
+void dmub_dcn35_reset_release(struct dmub_srv *dmub)
+{
+	REG_WRITE(DMCUB_SCRATCH15, dmub->psp_version & 0x001100FF);
+
+	REG_UPDATE_3(DMU_CLK_CNTL,
+		     LONO_DISPCLK_GATE_DISABLE, 1,
+		     LONO_SOCCLK_GATE_DISABLE, 1,
+		     LONO_DMCUBCLK_GATE_DISABLE, 1);
+
+	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
+	udelay(1);
+	REG_UPDATE_2(DMCUB_CNTL, DMCUB_ENABLE, 1, DMCUB_TRACEPORT_EN, 1);
+	REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
+	udelay(1);
+	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 0);
+	REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 0);
+}
+
+void dmub_dcn35_backdoor_load(struct dmub_srv *dmub,
+			      const struct dmub_window *cw0,
+			      const struct dmub_window *cw1)
+{
+	union dmub_addr offset;
+	uint64_t fb_base, fb_offset;
+
+	dmub_dcn35_get_fb_base_offset(dmub, &fb_base, &fb_offset);
+
+	dmub_dcn35_translate_addr(&cw0->offset, fb_base, fb_offset, &offset);
+
+	REG_WRITE(DMCUB_REGION3_CW0_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW0_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW0_BASE_ADDRESS, cw0->region.base);
+	REG_SET_2(DMCUB_REGION3_CW0_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW0_TOP_ADDRESS, cw0->region.top,
+		  DMCUB_REGION3_CW0_ENABLE, 1);
+
+	dmub_dcn35_translate_addr(&cw1->offset, fb_base, fb_offset, &offset);
+
+	REG_WRITE(DMCUB_REGION3_CW1_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW1_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW1_BASE_ADDRESS, cw1->region.base);
+	REG_SET_2(DMCUB_REGION3_CW1_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW1_TOP_ADDRESS, cw1->region.top,
+		  DMCUB_REGION3_CW1_ENABLE, 1);
+
+	/* TODO: Do we need to set DMCUB_MEM_UNIT_ID? */
+	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 0);
+}
+
+void dmub_dcn35_backdoor_load_zfb_mode(struct dmub_srv *dmub,
+		      const struct dmub_window *cw0,
+		      const struct dmub_window *cw1)
+{
+	union dmub_addr offset;
+
+	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 1);
+	offset = cw0->offset;
+	REG_WRITE(DMCUB_REGION3_CW0_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW0_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW0_BASE_ADDRESS, cw0->region.base);
+	REG_SET_2(DMCUB_REGION3_CW0_TOP_ADDRESS, 0,
+			DMCUB_REGION3_CW0_TOP_ADDRESS, cw0->region.top,
+			DMCUB_REGION3_CW0_ENABLE, 1);
+	offset = cw1->offset;
+	REG_WRITE(DMCUB_REGION3_CW1_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW1_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW1_BASE_ADDRESS, cw1->region.base);
+	REG_SET_2(DMCUB_REGION3_CW1_TOP_ADDRESS, 0,
+			DMCUB_REGION3_CW1_TOP_ADDRESS, cw1->region.top,
+			DMCUB_REGION3_CW1_ENABLE, 1);
+	REG_UPDATE_2(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 0, DMCUB_MEM_UNIT_ID,
+			0x20);
+}
+void dmub_dcn35_setup_windows(struct dmub_srv *dmub,
+			      const struct dmub_window *cw2,
+			      const struct dmub_window *cw3,
+			      const struct dmub_window *cw4,
+			      const struct dmub_window *cw5,
+			      const struct dmub_window *cw6)
+{
+	union dmub_addr offset;
+
+	offset = cw3->offset;
+
+	REG_WRITE(DMCUB_REGION3_CW3_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW3_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW3_BASE_ADDRESS, cw3->region.base);
+	REG_SET_2(DMCUB_REGION3_CW3_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW3_TOP_ADDRESS, cw3->region.top,
+		  DMCUB_REGION3_CW3_ENABLE, 1);
+
+	offset = cw4->offset;
+
+	REG_WRITE(DMCUB_REGION3_CW4_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW4_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW4_BASE_ADDRESS, cw4->region.base);
+	REG_SET_2(DMCUB_REGION3_CW4_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW4_TOP_ADDRESS, cw4->region.top,
+		  DMCUB_REGION3_CW4_ENABLE, 1);
+
+	offset = cw5->offset;
+
+	REG_WRITE(DMCUB_REGION3_CW5_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW5_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW5_BASE_ADDRESS, cw5->region.base);
+	REG_SET_2(DMCUB_REGION3_CW5_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW5_TOP_ADDRESS, cw5->region.top,
+		  DMCUB_REGION3_CW5_ENABLE, 1);
+
+	REG_WRITE(DMCUB_REGION5_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION5_OFFSET_HIGH, offset.u.high_part);
+	REG_SET_2(DMCUB_REGION5_TOP_ADDRESS, 0,
+		  DMCUB_REGION5_TOP_ADDRESS,
+		  cw5->region.top - cw5->region.base - 1,
+		  DMCUB_REGION5_ENABLE, 1);
+
+	offset = cw6->offset;
+
+	REG_WRITE(DMCUB_REGION3_CW6_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW6_OFFSET_HIGH, offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW6_BASE_ADDRESS, cw6->region.base);
+	REG_SET_2(DMCUB_REGION3_CW6_TOP_ADDRESS, 0,
+		  DMCUB_REGION3_CW6_TOP_ADDRESS, cw6->region.top,
+		  DMCUB_REGION3_CW6_ENABLE, 1);
+}
+
+void dmub_dcn35_setup_mailbox(struct dmub_srv *dmub,
+			      const struct dmub_region *inbox1)
+{
+	REG_WRITE(DMCUB_INBOX1_BASE_ADDRESS, inbox1->base);
+	REG_WRITE(DMCUB_INBOX1_SIZE, inbox1->top - inbox1->base);
+}
+
+uint32_t dmub_dcn35_get_inbox1_wptr(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_INBOX1_WPTR);
+}
+
+uint32_t dmub_dcn35_get_inbox1_rptr(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_INBOX1_RPTR);
+}
+
+void dmub_dcn35_set_inbox1_wptr(struct dmub_srv *dmub, uint32_t wptr_offset)
+{
+	REG_WRITE(DMCUB_INBOX1_WPTR, wptr_offset);
+}
+
+void dmub_dcn35_setup_out_mailbox(struct dmub_srv *dmub,
+			      const struct dmub_region *outbox1)
+{
+	REG_WRITE(DMCUB_OUTBOX1_BASE_ADDRESS, outbox1->base);
+	REG_WRITE(DMCUB_OUTBOX1_SIZE, outbox1->top - outbox1->base);
+}
+
+uint32_t dmub_dcn35_get_outbox1_wptr(struct dmub_srv *dmub)
+{
+	/**
+	 * outbox1 wptr register is accessed without locks (dal & dc)
+	 * and to be called only by dmub_srv_stat_get_notification()
+	 */
+	return REG_READ(DMCUB_OUTBOX1_WPTR);
+}
+
+void dmub_dcn35_set_outbox1_rptr(struct dmub_srv *dmub, uint32_t rptr_offset)
+{
+	/**
+	 * outbox1 rptr register is accessed without locks (dal & dc)
+	 * and to be called only by dmub_srv_stat_get_notification()
+	 */
+	REG_WRITE(DMCUB_OUTBOX1_RPTR, rptr_offset);
+}
+
+bool dmub_dcn35_is_hw_init(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_status status;
+	uint32_t is_enable;
+
+	status.all = REG_READ(DMCUB_SCRATCH0);
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_enable);
+
+	return is_enable != 0 && status.bits.dal_fw;
+}
+
+bool dmub_dcn35_is_supported(struct dmub_srv *dmub)
+{
+	uint32_t supported = 0;
+
+	REG_GET(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE, &supported);
+
+	return supported;
+}
+
+void dmub_dcn35_set_gpint(struct dmub_srv *dmub,
+			  union dmub_gpint_data_register reg)
+{
+	REG_WRITE(DMCUB_GPINT_DATAIN1, reg.all);
+}
+
+bool dmub_dcn35_is_gpint_acked(struct dmub_srv *dmub,
+			       union dmub_gpint_data_register reg)
+{
+	union dmub_gpint_data_register test;
+
+	reg.bits.status = 0;
+	test.all = REG_READ(DMCUB_GPINT_DATAIN1);
+
+	return test.all == reg.all;
+}
+
+uint32_t dmub_dcn35_get_gpint_response(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_SCRATCH7);
+}
+
+uint32_t dmub_dcn35_get_gpint_dataout(struct dmub_srv *dmub)
+{
+	uint32_t dataout = REG_READ(DMCUB_GPINT_DATAOUT);
+
+	REG_UPDATE(DMCUB_INTERRUPT_ENABLE, DMCUB_GPINT_IH_INT_EN, 0);
+
+	REG_WRITE(DMCUB_GPINT_DATAOUT, 0);
+	REG_UPDATE(DMCUB_INTERRUPT_ACK, DMCUB_GPINT_IH_INT_ACK, 1);
+	REG_UPDATE(DMCUB_INTERRUPT_ACK, DMCUB_GPINT_IH_INT_ACK, 0);
+
+	REG_UPDATE(DMCUB_INTERRUPT_ENABLE, DMCUB_GPINT_IH_INT_EN, 1);
+
+	return dataout;
+}
+
+union dmub_fw_boot_status dmub_dcn35_get_fw_boot_status(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_status status;
+
+	status.all = REG_READ(DMCUB_SCRATCH0);
+	return status;
+}
+
+union dmub_fw_boot_options dmub_dcn35_get_fw_boot_option(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_options option;
+
+	option.all = REG_READ(DMCUB_SCRATCH14);
+	return option;
+}
+
+void dmub_dcn35_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params)
+{
+	union dmub_fw_boot_options boot_options = {0};
+
+	boot_options.bits.z10_disable = params->disable_z10;
+	boot_options.bits.dpia_supported = params->dpia_supported;
+	boot_options.bits.enable_dpia = params->disable_dpia == true ? 0:1;
+	boot_options.bits.usb4_cm_version = params->usb4_cm_version;
+	boot_options.bits.dpia_hpd_int_enable_supported = params->dpia_hpd_int_enable_supported;
+	boot_options.bits.power_optimization = params->power_optimization;
+	boot_options.bits.disable_clk_ds = params->disallow_dispclk_dppclk_ds;
+	boot_options.bits.disable_clk_gate = params->disable_clock_gate;
+	boot_options.bits.ips_disable = params->disable_ips;
+
+	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
+}
+
+void dmub_dcn35_skip_dmub_panel_power_sequence(struct dmub_srv *dmub, bool skip)
+{
+	union dmub_fw_boot_options boot_options;
+	boot_options.all = REG_READ(DMCUB_SCRATCH14);
+	boot_options.bits.skip_phy_init_panel_sequence = skip;
+	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
+}
+
+void dmub_dcn35_setup_outbox0(struct dmub_srv *dmub,
+			      const struct dmub_region *outbox0)
+{
+	REG_WRITE(DMCUB_OUTBOX0_BASE_ADDRESS, outbox0->base);
+
+	REG_WRITE(DMCUB_OUTBOX0_SIZE, outbox0->top - outbox0->base);
+}
+
+uint32_t dmub_dcn35_get_outbox0_wptr(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_OUTBOX0_WPTR);
+}
+
+void dmub_dcn35_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset)
+{
+	REG_WRITE(DMCUB_OUTBOX0_RPTR, rptr_offset);
+}
+
+uint32_t dmub_dcn35_get_current_time(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_TIMER_CURRENT);
+}
+
+void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data)
+{
+	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
+	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
+
+	if (!dmub || !diag_data)
+		return;
+
+	memset(diag_data, 0, sizeof(*diag_data));
+
+	diag_data->dmcub_version = dmub->fw_version;
+
+	diag_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	diag_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	diag_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	diag_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	diag_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	diag_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	diag_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	diag_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	diag_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	diag_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	diag_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	diag_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	diag_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	diag_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	diag_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	diag_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
+	diag_data->scratch[16] = REG_READ(DMCUB_SCRATCH16);
+
+	diag_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	diag_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	diag_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	diag_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	diag_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	diag_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	diag_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	diag_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	diag_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
+	diag_data->is_dmcub_enabled = is_dmub_enabled;
+
+	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
+	diag_data->is_dmcub_soft_reset = is_soft_reset;
+
+	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
+	diag_data->is_dmcub_secure_reset = is_sec_reset;
+
+	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
+	diag_data->is_traceport_en  = is_traceport_enabled;
+
+	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
+	diag_data->is_cw0_enabled = is_cw0_enabled;
+
+	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
+	diag_data->is_cw6_enabled = is_cw6_enabled;
+
+	diag_data->gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
+}
+void dmub_dcn35_configure_dmub_in_system_memory(struct dmub_srv *dmub)
+{
+	/* DMCUB_REGION3_TMR_AXI_SPACE values:
+	 * 0b011 (0x3) - FB physical address
+	 * 0b100 (0x4) - GPU virtual address
+	 *
+	 * Default value is 0x3 (FB Physical address for TMR). When programming
+	 * DMUB to be in system memory, change to 0x4. The system memory allocated
+	 * is accessible by both GPU and CPU, so we use GPU virtual address.
+	 */
+	REG_WRITE(DMCUB_REGION3_TMR_AXI_SPACE, 0x4);
+}
+
+bool dmub_dcn35_should_detect(struct dmub_srv *dmub)
+{
+	uint32_t fw_boot_status = REG_READ(DMCUB_SCRATCH0);
+	bool should_detect = (fw_boot_status & DMUB_FW_BOOT_STATUS_BIT_DETECTION_REQUIRED) != 0;
+	return should_detect;
+}
+
+void dmub_dcn35_send_inbox0_cmd(struct dmub_srv *dmub, union dmub_inbox0_data_register data)
+{
+	REG_WRITE(DMCUB_INBOX0_WPTR, data.inbox0_cmd_common.all);
+}
+
+void dmub_dcn35_clear_inbox0_ack_register(struct dmub_srv *dmub)
+{
+	REG_WRITE(DMCUB_SCRATCH17, 0);
+}
+
+uint32_t dmub_dcn35_read_inbox0_ack_register(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_SCRATCH17);
+}
+
+bool dmub_dcn35_is_hw_powered_up(struct dmub_srv *dmub)
+{
+	union dmub_fw_boot_status status;
+
+	status.all = REG_READ(DMCUB_SCRATCH0);
+
+	return status.bits.hw_power_init_done;
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h
new file mode 100644
index 000000000000..129a7031d2ae
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h
@@ -0,0 +1,282 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef _DMUB_DCN35_H_
+#define _DMUB_DCN35_H_
+
+#include "dmub_dcn31.h"
+
+struct dmub_srv;
+
+/* DCN35 register definitions. */
+
+#define DMUB_DCN35_REGS() \
+	DMUB_SR(DMCUB_CNTL) \
+	DMUB_SR(DMCUB_CNTL2) \
+	DMUB_SR(DMCUB_SEC_CNTL) \
+	DMUB_SR(DMCUB_INBOX0_SIZE) \
+	DMUB_SR(DMCUB_INBOX0_RPTR) \
+	DMUB_SR(DMCUB_INBOX0_WPTR) \
+	DMUB_SR(DMCUB_INBOX1_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_INBOX1_SIZE) \
+	DMUB_SR(DMCUB_INBOX1_RPTR) \
+	DMUB_SR(DMCUB_INBOX1_WPTR) \
+	DMUB_SR(DMCUB_OUTBOX0_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_OUTBOX0_SIZE) \
+	DMUB_SR(DMCUB_OUTBOX0_RPTR) \
+	DMUB_SR(DMCUB_OUTBOX0_WPTR) \
+	DMUB_SR(DMCUB_OUTBOX1_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_OUTBOX1_SIZE) \
+	DMUB_SR(DMCUB_OUTBOX1_RPTR) \
+	DMUB_SR(DMCUB_OUTBOX1_WPTR) \
+	DMUB_SR(DMCUB_REGION3_CW0_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW1_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW2_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW3_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW4_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW5_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW6_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW7_OFFSET) \
+	DMUB_SR(DMCUB_REGION3_CW0_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW1_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW2_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW3_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW4_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW5_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW6_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW7_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION3_CW0_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW1_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW2_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW3_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW4_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW5_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW6_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW7_BASE_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW0_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW1_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW2_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW3_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW4_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW5_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW6_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION3_CW7_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION4_OFFSET) \
+	DMUB_SR(DMCUB_REGION4_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION4_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION5_OFFSET) \
+	DMUB_SR(DMCUB_REGION5_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION5_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_SCRATCH0) \
+	DMUB_SR(DMCUB_SCRATCH1) \
+	DMUB_SR(DMCUB_SCRATCH2) \
+	DMUB_SR(DMCUB_SCRATCH3) \
+	DMUB_SR(DMCUB_SCRATCH4) \
+	DMUB_SR(DMCUB_SCRATCH5) \
+	DMUB_SR(DMCUB_SCRATCH6) \
+	DMUB_SR(DMCUB_SCRATCH7) \
+	DMUB_SR(DMCUB_SCRATCH8) \
+	DMUB_SR(DMCUB_SCRATCH9) \
+	DMUB_SR(DMCUB_SCRATCH10) \
+	DMUB_SR(DMCUB_SCRATCH11) \
+	DMUB_SR(DMCUB_SCRATCH12) \
+	DMUB_SR(DMCUB_SCRATCH13) \
+	DMUB_SR(DMCUB_SCRATCH14) \
+	DMUB_SR(DMCUB_SCRATCH15) \
+	DMUB_SR(DMCUB_SCRATCH16) \
+	DMUB_SR(DMCUB_SCRATCH17) \
+	DMUB_SR(DMCUB_SCRATCH18) \
+	DMUB_SR(DMCUB_SCRATCH19) \
+	DMUB_SR(DMCUB_SCRATCH20) \
+	DMUB_SR(DMCUB_SCRATCH21) \
+	DMUB_SR(DMCUB_GPINT_DATAIN0) \
+	DMUB_SR(DMCUB_GPINT_DATAIN1) \
+	DMUB_SR(DMCUB_GPINT_DATAOUT) \
+	DMUB_SR(CC_DC_PIPE_DIS) \
+	DMUB_SR(MMHUBBUB_SOFT_RESET) \
+	DMUB_SR(DCN_VM_FB_LOCATION_BASE) \
+	DMUB_SR(DCN_VM_FB_OFFSET) \
+	DMUB_SR(DMCUB_TIMER_CURRENT) \
+	DMUB_SR(DMCUB_INST_FETCH_FAULT_ADDR) \
+	DMUB_SR(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR) \
+	DMUB_SR(DMCUB_DATA_WRITE_FAULT_ADDR) \
+	DMUB_SR(DMCUB_REGION3_TMR_AXI_SPACE) \
+	DMUB_SR(DMCUB_INTERRUPT_ENABLE) \
+	DMUB_SR(DMCUB_INTERRUPT_ACK) \
+	DMUB_SR(DMU_CLK_CNTL)
+
+#define DMUB_DCN35_FIELDS() \
+	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
+	DMUB_SF(DMCUB_CNTL, DMCUB_TRACEPORT_EN) \
+	DMUB_SF(DMCUB_CNTL2, DMCUB_SOFT_RESET) \
+	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_SEC_RESET) \
+	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_MEM_UNIT_ID) \
+	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS) \
+	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW1_TOP_ADDRESS, DMCUB_REGION3_CW1_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW1_TOP_ADDRESS, DMCUB_REGION3_CW1_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW2_TOP_ADDRESS, DMCUB_REGION3_CW2_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW2_TOP_ADDRESS, DMCUB_REGION3_CW2_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW3_TOP_ADDRESS, DMCUB_REGION3_CW3_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW3_TOP_ADDRESS, DMCUB_REGION3_CW3_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW4_TOP_ADDRESS, DMCUB_REGION3_CW4_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW4_TOP_ADDRESS, DMCUB_REGION3_CW4_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW5_TOP_ADDRESS, DMCUB_REGION3_CW5_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW5_TOP_ADDRESS, DMCUB_REGION3_CW5_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE) \
+	DMUB_SF(DMCUB_REGION3_CW7_TOP_ADDRESS, DMCUB_REGION3_CW7_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION3_CW7_TOP_ADDRESS, DMCUB_REGION3_CW7_ENABLE) \
+	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_ENABLE) \
+	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_ENABLE) \
+	DMUB_SF(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE) \
+	DMUB_SF(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET) \
+	DMUB_SF(DCN_VM_FB_LOCATION_BASE, FB_BASE) \
+	DMUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET) \
+	DMUB_SF(DMCUB_INBOX0_WPTR, DMCUB_INBOX0_WPTR) \
+	DMUB_SF(DMCUB_REGION3_TMR_AXI_SPACE, DMCUB_REGION3_TMR_AXI_SPACE) \
+	DMUB_SF(DMCUB_INTERRUPT_ENABLE, DMCUB_GPINT_IH_INT_EN) \
+	DMUB_SF(DMCUB_INTERRUPT_ACK, DMCUB_GPINT_IH_INT_ACK) \
+	DMUB_SF(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS) \
+	DMUB_SF(DMU_CLK_CNTL, LONO_DISPCLK_GATE_DISABLE) \
+	DMUB_SF(DMU_CLK_CNTL, LONO_SOCCLK_GATE_DISABLE) \
+	DMUB_SF(DMU_CLK_CNTL, LONO_DMCUBCLK_GATE_DISABLE)
+
+struct dmub_srv_dcn35_reg_offset {
+#define DMUB_SR(reg) uint32_t reg;
+	DMUB_DCN35_REGS()
+	DMCUB_INTERNAL_REGS()
+#undef DMUB_SR
+};
+
+struct dmub_srv_dcn35_reg_shift {
+#define DMUB_SF(reg, field) uint8_t reg##__##field;
+	DMUB_DCN35_FIELDS()
+#undef DMUB_SF
+};
+
+struct dmub_srv_dcn35_reg_mask {
+#define DMUB_SF(reg, field) uint32_t reg##__##field;
+	DMUB_DCN35_FIELDS()
+#undef DMUB_SF
+};
+
+struct dmub_srv_dcn35_regs {
+	struct dmub_srv_dcn35_reg_offset offset;
+	struct dmub_srv_dcn35_reg_mask mask;
+	struct dmub_srv_dcn35_reg_shift shift;
+};
+
+/* Hardware functions. */
+
+
+void dmub_dcn35_init(struct dmub_srv *dmub);
+
+void dmub_dcn35_reset(struct dmub_srv *dmub);
+
+void dmub_dcn35_reset_release(struct dmub_srv *dmub);
+
+void dmub_dcn35_backdoor_load(struct dmub_srv *dmub,
+			      const struct dmub_window *cw0,
+			      const struct dmub_window *cw1);
+
+void dmub_dcn35_backdoor_load_zfb_mode(struct dmub_srv *dmub,
+				       const struct dmub_window *cw0,
+				       const struct dmub_window *cw1);
+
+void dmub_dcn35_setup_windows(struct dmub_srv *dmub,
+			      const struct dmub_window *cw2,
+			      const struct dmub_window *cw3,
+			      const struct dmub_window *cw4,
+			      const struct dmub_window *cw5,
+			      const struct dmub_window *cw6);
+
+void dmub_dcn35_setup_mailbox(struct dmub_srv *dmub,
+			      const struct dmub_region *inbox1);
+
+uint32_t dmub_dcn35_get_inbox1_wptr(struct dmub_srv *dmub);
+
+uint32_t dmub_dcn35_get_inbox1_rptr(struct dmub_srv *dmub);
+
+void dmub_dcn35_set_inbox1_wptr(struct dmub_srv *dmub, uint32_t wptr_offset);
+
+void dmub_dcn35_setup_out_mailbox(struct dmub_srv *dmub,
+			      const struct dmub_region *outbox1);
+
+uint32_t dmub_dcn35_get_outbox1_wptr(struct dmub_srv *dmub);
+
+void dmub_dcn35_set_outbox1_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
+
+bool dmub_dcn35_is_hw_init(struct dmub_srv *dmub);
+
+bool dmub_dcn35_is_supported(struct dmub_srv *dmub);
+
+void dmub_dcn35_set_gpint(struct dmub_srv *dmub,
+			  union dmub_gpint_data_register reg);
+
+bool dmub_dcn35_is_gpint_acked(struct dmub_srv *dmub,
+			       union dmub_gpint_data_register reg);
+
+uint32_t dmub_dcn35_get_gpint_response(struct dmub_srv *dmub);
+
+uint32_t dmub_dcn35_get_gpint_dataout(struct dmub_srv *dmub);
+
+void dmub_dcn35_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params);
+
+void dmub_dcn35_skip_dmub_panel_power_sequence(struct dmub_srv *dmub, bool skip);
+
+union dmub_fw_boot_status dmub_dcn35_get_fw_boot_status(struct dmub_srv *dmub);
+
+union dmub_fw_boot_options dmub_dcn35_get_fw_boot_option(struct dmub_srv *dmub);
+
+void dmub_dcn35_setup_outbox0(struct dmub_srv *dmub,
+			      const struct dmub_region *outbox0);
+
+uint32_t dmub_dcn35_get_outbox0_wptr(struct dmub_srv *dmub);
+
+void dmub_dcn35_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
+
+uint32_t dmub_dcn35_get_current_time(struct dmub_srv *dmub);
+
+void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data);
+
+void dmub_dcn35_configure_dmub_in_system_memory(struct dmub_srv *dmub);
+
+void dmub_dcn35_send_inbox0_cmd(struct dmub_srv *dmub, union dmub_inbox0_data_register data);
+
+void dmub_dcn35_clear_inbox0_ack_register(struct dmub_srv *dmub);
+
+uint32_t dmub_dcn35_read_inbox0_ack_register(struct dmub_srv *dmub);
+
+bool dmub_dcn35_should_detect(struct dmub_srv *dmub);
+
+bool dmub_dcn35_is_hw_powered_up(struct dmub_srv *dmub);
+
+void dmub_srv_dcn35_regs_init(struct dmub_srv *dmub, struct dc_context *ctx);
+
+#endif /* _DMUB_DCN35_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 53464c3e49c1..ac81ee2ef2a0 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -36,6 +36,7 @@
 #include "dmub_dcn315.h"
 #include "dmub_dcn316.h"
 #include "dmub_dcn32.h"
+#include "dmub_dcn35.h"
 #include "os_types.h"
 /*
  * Note: the DMUB service is standalone. No additional headers should be
@@ -79,6 +80,7 @@
 #define DMUB_REGION5_BASE (0xA0000000)
 
 static struct dmub_srv_dcn32_regs dmub_srv_dcn32_regs;
+static struct dmub_srv_dcn35_regs dmub_srv_dcn35_regs;
 
 static inline uint32_t dmub_align(uint32_t val, uint32_t factor)
 {
@@ -311,6 +313,47 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 
 		break;
 
+	case DMUB_ASIC_DCN35:
+			dmub->regs_dcn35 = &dmub_srv_dcn35_regs;
+			funcs->configure_dmub_in_system_memory = dmub_dcn35_configure_dmub_in_system_memory;
+			funcs->send_inbox0_cmd = dmub_dcn35_send_inbox0_cmd;
+			funcs->clear_inbox0_ack_register = dmub_dcn35_clear_inbox0_ack_register;
+			funcs->read_inbox0_ack_register = dmub_dcn35_read_inbox0_ack_register;
+			funcs->reset = dmub_dcn35_reset;
+			funcs->reset_release = dmub_dcn35_reset_release;
+			funcs->backdoor_load = dmub_dcn35_backdoor_load;
+			funcs->backdoor_load_zfb_mode = dmub_dcn35_backdoor_load_zfb_mode;
+			funcs->setup_windows = dmub_dcn35_setup_windows;
+			funcs->setup_mailbox = dmub_dcn35_setup_mailbox;
+			funcs->get_inbox1_wptr = dmub_dcn35_get_inbox1_wptr;
+			funcs->get_inbox1_rptr = dmub_dcn35_get_inbox1_rptr;
+			funcs->set_inbox1_wptr = dmub_dcn35_set_inbox1_wptr;
+			funcs->setup_out_mailbox = dmub_dcn35_setup_out_mailbox;
+			funcs->get_outbox1_wptr = dmub_dcn35_get_outbox1_wptr;
+			funcs->set_outbox1_rptr = dmub_dcn35_set_outbox1_rptr;
+			funcs->is_supported = dmub_dcn35_is_supported;
+			funcs->is_hw_init = dmub_dcn35_is_hw_init;
+			funcs->set_gpint = dmub_dcn35_set_gpint;
+			funcs->is_gpint_acked = dmub_dcn35_is_gpint_acked;
+			funcs->get_gpint_response = dmub_dcn35_get_gpint_response;
+			funcs->get_gpint_dataout = dmub_dcn35_get_gpint_dataout;
+			funcs->get_fw_status = dmub_dcn35_get_fw_boot_status;
+			funcs->get_fw_boot_option = dmub_dcn35_get_fw_boot_option;
+			funcs->enable_dmub_boot_options = dmub_dcn35_enable_dmub_boot_options;
+			funcs->skip_dmub_panel_power_sequence = dmub_dcn35_skip_dmub_panel_power_sequence;
+			//outbox0 call stacks
+			funcs->setup_outbox0 = dmub_dcn35_setup_outbox0;
+			funcs->get_outbox0_wptr = dmub_dcn35_get_outbox0_wptr;
+			funcs->set_outbox0_rptr = dmub_dcn35_set_outbox0_rptr;
+
+			funcs->get_current_time = dmub_dcn35_get_current_time;
+			funcs->get_diagnostic_data = dmub_dcn35_get_diagnostic_data;
+
+			funcs->init_reg_offsets = dmub_srv_dcn35_regs_init;
+
+			funcs->is_hw_powered_up = dmub_dcn35_is_hw_powered_up;
+		break;
+
 	default:
 		return false;
 	}
@@ -727,10 +770,38 @@ enum dmub_status dmub_srv_cmd_execute(struct dmub_srv *dmub)
 	return DMUB_STATUS_OK;
 }
 
+bool dmub_srv_is_hw_pwr_up(struct dmub_srv *dmub)
+{
+	if (!dmub->hw_funcs.is_hw_powered_up)
+		return true;
+
+	return dmub->hw_funcs.is_hw_powered_up(dmub) &&
+		dmub->hw_funcs.is_hw_init(dmub);
+}
+
+enum dmub_status dmub_srv_wait_for_hw_pwr_up(struct dmub_srv *dmub,
+					     uint32_t timeout_us)
+{
+	uint32_t i;
+
+	if (!dmub->hw_init)
+		return DMUB_STATUS_INVALID;
+
+	for (i = 0; i <= timeout_us; i += 100) {
+		if (dmub_srv_is_hw_pwr_up(dmub))
+			return DMUB_STATUS_OK;
+
+		udelay(100);
+	}
+
+	return DMUB_STATUS_TIMEOUT;
+}
+
 enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
 					     uint32_t timeout_us)
 {
 	uint32_t i;
+	bool hw_on = true;
 
 	if (!dmub->hw_init)
 		return DMUB_STATUS_INVALID;
@@ -738,7 +809,10 @@ enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
 	for (i = 0; i <= timeout_us; i += 100) {
 		union dmub_fw_boot_status status = dmub->hw_funcs.get_fw_status(dmub);
 
-		if (status.bits.dal_fw && status.bits.mailbox_rdy)
+		if (dmub->hw_funcs.is_hw_powered_up)
+			hw_on = dmub->hw_funcs.is_hw_powered_up(dmub);
+
+		if (status.bits.dal_fw && status.bits.mailbox_rdy && hw_on)
 			return DMUB_STATUS_OK;
 
 		udelay(100);
-- 
2.41.0

