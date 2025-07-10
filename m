Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95590C83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F3210E974;
	Thu, 10 Jul 2025 21:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IbN0ILU5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E4C10E973
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFmiJF+QRbm06X3D6I3HycVcIPVDjb7JgXcgFvIFRQTmudSq6QtMnduCrLckVeXPKnEcRA/1Emx8RfacH6IVPrNwQRQUkuzjqJP4gPJEmR8NW37OGm6SUA/WyR4cwg3ggBvh4h33F6dOSWRl/QqkOmn2Zdi9U/rmQfU9ACnaSYB5sVsF0B+X4dRQNEoaDAXV1bIGqQImA+FNbiIEIKXC/Toyv4nOLmo7ngIavUqqgutNGCq0/uZjq2Fi8FyGd1zWDOLTRvD311nHPgI03lllB3ySeRjVGIwAVeqlcrL40SJOMrDkoKnziPRFVve+8AgDGRaSA16uOO0Ne7WTblLs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXfFqX9f6GhqejGwz/jmfHRnMps/+mt7dSkSjPFtYe4=;
 b=IS/8gtVym5tiHNDMCkghOH2VJCjpvS262FUTXDqSxLlH7MOeNJf79mTeTa/jnLTmXrL8x71UL0mDDOyFUoqiC1M0HaPeO7VoTVsGE7JOtnHioW/sgAUT9inWkgqNWh6xXdzag9OOvd35nNqhwu9kUQy7h2pHJyR709JvG94oQIcErdYe/BaYqN3oQVWkfvyJMGEUxcKEFJplCQneMsbQ0aeRumxhRfGShKCYgI5xZDTJksUHeEXkXqJZTAJONmV04QtghqWQlgFX7xiFCwyVnj6by27w88bo/gntha2zeNfwKmC7wnZqEGd/lyCL9GYdWDc6q4IGHDh61x+NaBjlSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXfFqX9f6GhqejGwz/jmfHRnMps/+mt7dSkSjPFtYe4=;
 b=IbN0ILU5irHkUqx3zMjQVVQJIgOqGNVJcch0ueEL3tuvKinR9gqlpneWtFJ7umeoB7tasMMSMBJo6CNek+G45h2BBDIhvzPoe4d3cqc8sG7bSc1rRVFJXhxYbFcJsa0KpH91+wpTuu3ymgH3TDiqUs9lQ3LTy5eRrO4WXHUqjdc=
Received: from CH2PR03CA0019.namprd03.prod.outlook.com (2603:10b6:610:59::29)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 21:31:30 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::9) by CH2PR03CA0019.outlook.office365.com
 (2603:10b6:610:59::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Thu,
 10 Jul 2025 21:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:31:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:31:13 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:31:12 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 16/18] drm/amd/display: Initial support for SmartMux
Date: Thu, 10 Jul 2025 17:25:49 -0400
Message-ID: <20250710212941.630259-17-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c86aae-e6d6-47c1-4d13-08ddbff922be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tEoRgpH0SFsbCbStb6yleIm79tHG3QGxZMnlOL6Y4UDyYKnII9N+k2mHYjfT?=
 =?us-ascii?Q?cMggajskqKqegXdaYV1GdgiNkBO2emKXc+HCjxL4qfL3iMNe5goLXcFvzOT2?=
 =?us-ascii?Q?bYLEmTXwpjViNXIazVyTFCrGSJRE9EO/gNBBMUWHwfTGbXjIr65pC/C2LZt+?=
 =?us-ascii?Q?Tan4NIE84VOb/hUZW7y9s+4AHF+fIYSAPlIJZaTse/EFViuMQIM85QssXLme?=
 =?us-ascii?Q?RFHb7Wp2BA/+SkM/+qRZ3r8vWwMptcQhnMAYGewKHiK0TrnSV4jMbaNjd6Ff?=
 =?us-ascii?Q?ysVqoNqmy4QN8pqV75Abm94P0fWQsWAK6lNCTXUvk2OfqB9rk1DczeiH9BXp?=
 =?us-ascii?Q?1JJODlWdb4DSqUi7eYzOIevoInP0xj9j2r1dXt4CGN7uFFiDAyRaG9SHhkbf?=
 =?us-ascii?Q?C/wdwlNVzdA8/fIV9h2OKB3zEdtGLRR1Nw6RgVPs0FSDfKsf46UDKK/b41u9?=
 =?us-ascii?Q?NPJSfQiI4I958k756BEJoJsIhLMTKs1k9zuZBqSwXcXzFYTLtAhBOFQXNJJ6?=
 =?us-ascii?Q?fcfVuNBUSjt6xW/+7nykWGRFueKzDGxPmLuOScyJ7kxtmLoE9aSRxhmLJ5KZ?=
 =?us-ascii?Q?oS8sip8PBfktuadg1825SJy+X8PvlRqRCGIkWXfHqez4W5bP17iNb4t7+cZ0?=
 =?us-ascii?Q?FmNZH1bvsLt1CaOHAYqxrBicUAaKAN+k+sfxnFqoSL53oJ7Hjon3u3rNIDI9?=
 =?us-ascii?Q?jE5wMG3HFrrXy28piOKlLi6d13Sy/LI0VSwnDRj7i7sC3lxokLbP0LmEr0pm?=
 =?us-ascii?Q?tMSaIckqA04402eaPtL5Mrno7fcjj4lZTpLKNTRua6vG9D5A5ogf6G1Xnk9z?=
 =?us-ascii?Q?64r4/GoeuU5iBvFKXTONk3T4sCCbxt+R3YRWhRS8cF6N0NNrfGLQcM1x42Hl?=
 =?us-ascii?Q?uAtJyio+7tDdPrZlFcELeOgHYccrwC0HGtIrIMasm+a9HDx5226J4BzOCVlT?=
 =?us-ascii?Q?nttYwhx3aBDrHzIfRT24lis6edGh1BhM4icxdbsVopsZZlZE3zfiaHEga6DY?=
 =?us-ascii?Q?cSwo8dfRwyOudeXJMjYt09d39ZhHYmgPU9s8IK/7ZngpzsRyQc2L0CZCGSmp?=
 =?us-ascii?Q?AQVbdBft9H5iDEM1pKFitcwgB1CwMZEBBNcnOSsPsvqPfimLr1VzkEYCZV6V?=
 =?us-ascii?Q?MUgsX2edjGjvvhaYGnXZhmFuJYQZ1I8r4WovC8nGNbqZaKRt3/9drbXi44A4?=
 =?us-ascii?Q?uHH3zksxJRyJER1TiQdVE1oTjcNYBDOCvYQ7BHOm3KcFsud3d6XJHhflQOcL?=
 =?us-ascii?Q?uSCNJA29qsh+19JtvoFdAI8/7fz0CkkcF2wnNl/dqwSnvc84ezv2R7Y6qknG?=
 =?us-ascii?Q?XKnZa3G9jwK4qnyX0mlPf/KVFCHwlpWdp5nFupePNKxODOH15TnHhEnR/0fx?=
 =?us-ascii?Q?BW/18dvDmGF6CqVuIE0i+DOi+6fxASYI8RMjYYgWN5I67GHpNW/U5Fm0Kj1t?=
 =?us-ascii?Q?j0/2GKKt/GYinVZVjqxeTqOXed+u6fPRVk0ugLKfprBBeydYkF9M2wCmepAV?=
 =?us-ascii?Q?NsV/i/1o/RVT1ddgekrszclBJvtHTIkqPk95?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:31:30.6587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c86aae-e6d6-47c1-4d13-08ddbff922be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

SmartMux is a mechanism to switch the GPU being used for scanout in a
hybrid configuration. This is used for devices with an eDP and two GPUs.
This is only valid when the system has a physical switch (Multiplexer)
in the board to switch between the two GPUs.

When a graphically intensive workload like a game is being run, the
system can be switch the active display to the dGPU, so that we can
avoid copying the buffer from dGPU to APU for scanout. This helps with
latency and FPS. When power consumption is preferred, the system can be
switched to the APU.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |   2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   2 +-
 .../drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h |   3 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   4 +-
 .../display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.c |  36 ++++++
 .../display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.h |  31 +++++
 .../dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.c | 118 ++++++++++++++++++
 .../dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.h |  34 +++++
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  26 ++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   8 ++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  24 ++++
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  13 ++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   3 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   2 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  19 ++-
 .../drm/amd/display/dc/link/link_factory.c    |   8 +-
 .../dc/link/protocols/link_dp_capability.c    |  19 +++
 .../link/protocols/link_edp_panel_control.c   |  17 +++
 .../link/protocols/link_edp_panel_control.h   |   1 +
 .../amd/display/modules/power/power_helpers.h |   2 +
 20 files changed, 366 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.h

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index d9955c5d2e5e..60021671b386 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -112,7 +112,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN21)
 ###############################################################################
 # DCN30
 ###############################################################################
-CLK_MGR_DCN30 = dcn30_clk_mgr.o dcn30_clk_mgr_smu_msg.o
+CLK_MGR_DCN30 = dcn30_clk_mgr.o dcn30_clk_mgr_smu_msg.o dcn30m_clk_mgr.o dcn30m_clk_mgr_smu_msg.o
 
 AMD_DAL_CLK_MGR_DCN30 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn30/,$(CLK_MGR_DCN30))
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 4c3e58c730b1..33b9d36619ff 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -67,7 +67,7 @@ int clk_mgr_helper_get_active_display_cnt(
 		if (dc_state_get_stream_subvp_type(context, stream) == SUBVP_PHANTOM)
 			continue;
 
-		if (!stream->dpms_off || (stream_status && stream_status->plane_count))
+		if (!stream->dpms_off || dc->is_switch_in_progress_dest || (stream_status && stream_status->plane_count))
 			display_count++;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h
index fa09c594fd36..06da34676965 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h
@@ -56,6 +56,7 @@
 #define DALSMC_MSG_SetDisplayRefreshFromMall      0xF
 #define DALSMC_MSG_SetExternalClientDfCstateAllow 0x10
 #define DALSMC_MSG_BacoAudioD3PME                 0x11
-#define DALSMC_Message_Count                      0x12
+#define DALSMC_MSG_SmartAccess                    0x12
+#define DALSMC_Message_Count                      0x13
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 8083a553c60e..ef77fcd164ed 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -30,6 +30,7 @@
 #include "dce100/dce_clk_mgr.h"
 #include "dcn30/dcn30_clk_mgr.h"
 #include "dml/dcn30/dcn30_fpu.h"
+#include "dcn30/dcn30m_clk_mgr.h"
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dm_helpers.h"
@@ -498,7 +499,8 @@ static struct clk_mgr_funcs dcn3_funcs = {
 		.are_clock_states_equal = dcn3_are_clock_states_equal,
 		.enable_pme_wa = dcn3_enable_pme_wa,
 		.notify_link_rate_change = dcn30_notify_link_rate_change,
-		.is_smu_present = dcn3_is_smu_present
+		.is_smu_present = dcn3_is_smu_present,
+		.set_smartmux_switch = dcn30m_set_smartmux_switch
 };
 
 static void dcn3_init_clocks_fpga(struct clk_mgr *clk_mgr)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.c
new file mode 100644
index 000000000000..8e8a11c7437e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.c
@@ -0,0 +1,36 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
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
+#include "clk_mgr_internal.h"
+#include "dcn30/dcn30m_clk_mgr.h"
+#include "dcn30m_clk_mgr_smu_msg.h"
+
+
+uint32_t dcn30m_set_smartmux_switch(struct clk_mgr *clk_mgr_base, uint32_t pins_to_set)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	return dcn30m_smu_set_smart_mux_switch(clk_mgr, pins_to_set);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.h
new file mode 100644
index 000000000000..757985b2eadc
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
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
+#ifndef __DCN30M_CLK_MGR_H__
+#define __DCN30M_CLK_MGR_H__
+
+uint32_t dcn30m_set_smartmux_switch(struct clk_mgr *clk_mgr_base, uint32_t pins_to_set);
+
+#endif //__DCN30M_CLK_MGR_H__
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.c
new file mode 100644
index 000000000000..0dd0583ff21e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.c
@@ -0,0 +1,118 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#include "dcn30m_clk_mgr_smu_msg.h"
+
+#include "clk_mgr_internal.h"
+#include "reg_helper.h"
+#include "dm_helpers.h"
+
+#include "dalsmc.h"
+
+#define mmDAL_MSG_REG  0x1628A
+#define mmDAL_ARG_REG  0x16273
+#define mmDAL_RESP_REG 0x16274
+
+#define REG(reg_name) \
+	mm ## reg_name
+
+#include "logger_types.h"
+#undef DC_LOGGER
+#define DC_LOGGER \
+	CTX->logger
+#define smu_print(str, ...) {DC_LOG_SMU(str, ##__VA_ARGS__); }
+
+
+/*
+ * Function to be used instead of REG_WAIT macro because the wait ends when
+ * the register is NOT EQUAL to zero, and because the translation in msg_if.h
+ * won't work with REG_WAIT.
+ */
+static uint32_t dcn30m_smu_wait_for_response(struct clk_mgr_internal *clk_mgr,
+	unsigned int delay_us, unsigned int max_retries)
+{
+	uint32_t reg = 0;
+
+	do {
+		reg = REG_READ(DAL_RESP_REG);
+		if (reg)
+			break;
+
+		if (delay_us >= 1000)
+			msleep(delay_us/1000);
+		else if (delay_us > 0)
+			udelay(delay_us);
+	} while (max_retries--);
+
+	/* handle DALSMC_Result_CmdRejectedBusy? */
+
+	/* Log? */
+
+	return reg;
+}
+
+static bool dcn30m_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
+	uint32_t msg_id, uint32_t param_in, uint32_t *param_out)
+{
+	uint32_t result;
+	/* Wait for response register to be ready */
+	dcn30m_smu_wait_for_response(clk_mgr, 10, 200000);
+
+	/* Clear response register */
+	REG_WRITE(DAL_RESP_REG, 0);
+
+	/* Set the parameter register for the SMU message */
+	REG_WRITE(DAL_ARG_REG, param_in);
+
+	/* Trigger the message transaction by writing the message ID */
+	REG_WRITE(DAL_MSG_REG, msg_id);
+
+	result = dcn30m_smu_wait_for_response(clk_mgr, 10, 200000);
+
+	if (IS_SMU_TIMEOUT(result))
+		dm_helpers_smu_timeout(CTX, msg_id, param_in, 10 * 200000);
+
+	/* Wait for response */
+	if (result == DALSMC_Result_OK) {
+		if (param_out)
+			*param_out = REG_READ(DAL_ARG_REG);
+
+		return true;
+	}
+
+	return false;
+}
+
+uint32_t dcn30m_smu_set_smart_mux_switch(struct clk_mgr_internal *clk_mgr, uint32_t pins_to_set)
+{
+	uint32_t response = 0;
+
+	smu_print("SMU Set SmartMux Switch: switch_dgpu = %d\n", pins_to_set);
+
+	dcn30m_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_SmartAccess, pins_to_set, &response);
+
+	return response;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.h
new file mode 100644
index 000000000000..8a59a473fc5e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#ifndef DAL_DC_DCN30M_CLK_MGR_SMU_MSG_H_
+#define DAL_DC_DCN30M_CLK_MGR_SMU_MSG_H_
+
+#include "core_types.h"
+
+struct clk_mgr_internal;
+
+uint32_t     dcn30m_smu_set_smart_mux_switch(struct clk_mgr_internal *clk_mgr, uint32_t pins_to_set);
+#endif /* DAL_DC_DCN30M_CLK_MGR_SMU_MSG_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 7014b8d000bb..ec4e80e5b6eb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -427,6 +427,32 @@ void get_hdr_visual_confirm_color(
 	}
 }
 
+/* Visual Confirm color definition for Smart Mux */
+void get_smartmux_visual_confirm_color(
+	struct dc *dc,
+	struct tg_color *color)
+{
+	uint32_t color_value = MAX_TG_COLOR_VALUE;
+
+	const struct tg_color sm_ver_colors[5] = {
+			{0, 0, 0},					/* SMUX_MUXCONTROL_UNSUPPORTED - Black */
+			{0, MAX_TG_COLOR_VALUE, 0},			/* SMUX_MUXCONTROL_v10 - Green */
+			{0, MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE},	/* SMUX_MUXCONTROL_v15 - Cyan */
+			{MAX_TG_COLOR_VALUE, MAX_TG_COLOR_VALUE, 0}, 	/* SMUX_MUXCONTROL_MDM - Yellow */
+			{MAX_TG_COLOR_VALUE, 0, MAX_TG_COLOR_VALUE}, 	/* SMUX_MUXCONTROL_vUNKNOWN - Magenta*/
+	};
+
+	if (dc->caps.is_apu) {
+		/* APU driving the eDP */
+		*color = sm_ver_colors[dc->config.smart_mux_version];
+	} else {
+		/* dGPU driving the eDP - red */
+		color->color_r_cr = color_value;
+		color->color_g_y = 0;
+		color->color_b_cb = 0;
+	}
+}
+
 /* Visual Confirm color definition for VABC */
 void get_vabc_visual_confirm_color(
 	struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b4fe5859fa5f..59c07756130d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -505,6 +505,7 @@ struct dc_config {
 	bool use_spl;
 	bool prefer_easf;
 	bool use_pipe_ctx_sync_logic;
+	int smart_mux_version;
 	bool ignore_dpref_ss;
 	bool enable_mipi_converter_optimization;
 	bool use_default_clock_table;
@@ -541,6 +542,7 @@ enum visual_confirm {
 	VISUAL_CONFIRM_SWAPCHAIN = 6,
 	VISUAL_CONFIRM_FAMS = 7,
 	VISUAL_CONFIRM_SWIZZLE = 9,
+	VISUAL_CONFIRM_SMARTMUX_DGPU = 10,
 	VISUAL_CONFIRM_REPLAY = 12,
 	VISUAL_CONFIRM_SUBVP = 14,
 	VISUAL_CONFIRM_MCLK_SWITCH = 16,
@@ -1639,6 +1641,8 @@ struct dc_scratch_space {
 
 	struct gpio *hpd_gpio;
 	enum dc_link_fec_state fec_state;
+	bool is_dds;
+	bool is_display_mux_present;
 	bool link_powered_externally;	// Used to bypass hardware sequencing delays when panel is powered down forcibly
 
 	struct dc_panel_config panel_config;
@@ -1693,6 +1697,10 @@ struct dc {
 
 	/* Require to maintain clocks and bandwidth for UEFI enabled HW */
 
+	/* For eDP to know the switching state of SmartMux */
+	bool is_switch_in_progress_orig;
+	bool is_switch_in_progress_dest;
+
 	/* FBC compressor */
 	struct compressor *fbc_compressor;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 252e862449a2..4ea13d0bf815 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1686,6 +1686,19 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_OTG);
 
+	/* Temporary workaround to perform DSC programming ahead of stream enablement
+	 * for smartmux/SPRS
+	 * TODO: Remove SmartMux/SPRS checks once movement of DSC programming is generalized
+	 */
+	if (pipe_ctx->stream->timing.flags.DSC) {
+		if ((pipe_ctx->stream->signal == SIGNAL_TYPE_EDP &&
+			((link->dc->config.smart_mux_version && link->dc->is_switch_in_progress_dest)
+			|| link->is_dds || link->skip_implict_edp_power_control)) &&
+			(dc_is_dp_signal(pipe_ctx->stream->signal) ||
+			dc_is_virtual_signal(pipe_ctx->stream->signal)))
+			dc->link_srv->set_dsc_enable(pipe_ctx, true);
+	}
+
 	if (!stream->dpms_off)
 		dc->link_srv->set_dpms_on(context, pipe_ctx);
 
@@ -1927,6 +1940,13 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 
 				can_apply_edp_fast_boot = dc_validate_boot_timing(dc,
 					edp_stream->sink, &edp_stream->timing);
+
+				// For Mux-platform, the default value is false.
+				// Disable fast boot during mux switching.
+				// The flag would be clean after switching done.
+				if (dc->is_switch_in_progress_dest && edp_link->is_dds)
+					can_apply_edp_fast_boot = false;
+
 				edp_stream->apply_edp_fast_boot_optimization = can_apply_edp_fast_boot;
 				if (can_apply_edp_fast_boot) {
 					DC_LOG_EVENT_LINK_TRAINING("eDP fast boot Enable\n");
@@ -1970,6 +1990,10 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	if (edp_with_sink_num)
 		edp_link_with_sink = edp_links_with_sink[0];
 
+	// During a mux switch, powering down the HW blocks and then enabling
+	// the link via a DPCD SET_POWER write causes a brief flash
+	keep_edp_vdd_on |= dc->is_switch_in_progress_dest;
+
 	if (!can_apply_edp_fast_boot && !can_apply_seamless_boot) {
 		if (edp_link_with_sink && !keep_edp_vdd_on) {
 			/*turn off backlight before DP_blank and encoder powered down*/
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 5ba3999991b0..8ba934b83957 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -562,6 +562,19 @@ static void dcn31_reset_back_end_for_pipe(
 	else if (pipe_ctx->stream_res.audio)
 		dc->hwss.disable_audio_stream(pipe_ctx);
 
+	/* Temporary workaround to perform DSC programming ahead of pipe reset
+	 * for smartmux/SPRS
+	 * TODO: Remove SmartMux/SPRS checks once movement of DSC programming is generalized
+	 */
+	if (pipe_ctx->stream->timing.flags.DSC) {
+		if ((pipe_ctx->stream->signal == SIGNAL_TYPE_EDP &&
+			((link->dc->config.smart_mux_version && link->dc->is_switch_in_progress_dest)
+			|| link->is_dds || link->skip_implict_edp_power_control)) &&
+			(dc_is_dp_signal(pipe_ctx->stream->signal) ||
+			dc_is_virtual_signal(pipe_ctx->stream->signal)))
+			dc->link_srv->set_dsc_enable(pipe_ctx, false);
+	}
+
 	/* free acquired resources */
 	if (pipe_ctx->stream_res.audio) {
 		/*disable az_endpoint*/
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 3a0795045bc6..9df8030e37f7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -502,6 +502,9 @@ void get_hdr_visual_confirm_color(
 void get_mpctree_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
+void get_smartmux_visual_confirm_color(
+	struct dc *dc,
+	struct tg_color *color);
 void get_vabc_visual_confirm_color(
 	struct pipe_ctx *pipe_ctx,
 	struct tg_color *color);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 7d66e62b6be6..2c9a4a12bd8a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -337,6 +337,8 @@ struct clk_mgr_funcs {
 
 	bool (*is_dc_mode_present)(struct clk_mgr *clk_mgr);
 
+	uint32_t (*set_smartmux_switch)(struct clk_mgr *clk_mgr, uint32_t pins_to_set);
+
 	unsigned int (*get_max_clock_khz)(struct clk_mgr *clk_mgr_base, enum clk_type clk_type);
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index bd51b279ad14..774dce435344 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -140,7 +140,7 @@ void link_blank_dp_stream(struct dc_link *link, bool hw_init)
 				}
 		}
 
-		if (((!link->wa_flags.dp_keep_receiver_powered) || hw_init) &&
+		if (((!dc->is_switch_in_progress_dest) && ((!link->wa_flags.dp_keep_receiver_powered) || hw_init)) &&
 			(link->type != dc_connection_none))
 			dpcd_write_rx_power_ctrl(link, false);
 	}
@@ -2537,6 +2537,14 @@ void link_set_dpms_on(
 				!pipe_ctx->next_odm_pipe) {
 		pipe_ctx->stream->dpms_off = false;
 		update_psp_stream_config(pipe_ctx, false);
+
+		if (link->is_dds) {
+			uint32_t post_oui_delay = 30; // 30ms
+
+			dpcd_set_source_specific_data(link);
+			msleep(post_oui_delay);
+		}
+
 		return;
 	}
 
@@ -2629,6 +2637,15 @@ void link_set_dpms_on(
 			dp_is_128b_132b_signal(pipe_ctx))
 		update_sst_payload(pipe_ctx, true);
 
+	/* Corruption was observed on systems with display mux when stream gets
+	 * enabled after the mux switch. Having a small delay between link
+	 * training and stream unblank resolves the corruption issue.
+	 *This is workaround.
+	 */
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP &&
+			link->is_display_mux_present)
+		msleep(20);
+
 	dc->hwss.unblank_stream(pipe_ctx,
 		&pipe_ctx->stream->link->cur_link_settings);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index c5f4e803be84..de1143dbbd25 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -539,10 +539,16 @@ static bool construct_phy(struct dc_link *link,
 
 		break;
 	case CONNECTOR_ID_EDP:
+		// If smartmux is supported, only create the link on the primary eDP.
+		// Dual eDP is not supported with smartmux.
+		if (!(!link->dc->config.smart_mux_version || dc_ctx->dc_edp_id_count == 0))
+			goto create_fail;
+
 		link->connector_signal = SIGNAL_TYPE_EDP;
 
 		if (link->hpd_gpio) {
-			if (!link->dc->config.allow_edp_hotplug_detection)
+			if (!link->dc->config.allow_edp_hotplug_detection
+				&& !is_smartmux_suported(link))
 				link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
 
 			switch (link->dc->config.allow_edp_hotplug_detection) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 0f965380a9b4..651926e547b9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1388,6 +1388,21 @@ void dpcd_set_source_specific_data(struct dc_link *link)
 		struct dpcd_amd_signature amd_signature = {0};
 		struct dpcd_amd_device_id amd_device_id = {0};
 
+		if (link->is_dds) {
+			uint8_t dpcd_dp_edp_backlight_mode = 0;
+
+			/*
+			 * Write 0 to bits 0:1 for dp_edp_backlight_mode_set register
+			 * if platform is DDS
+			 */
+			core_link_read_dpcd(link, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
+				&dpcd_dp_edp_backlight_mode, sizeof(uint8_t));
+			dpcd_dp_edp_backlight_mode &= ~0x3;
+
+			core_link_write_dpcd(link, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
+				&dpcd_dp_edp_backlight_mode, sizeof(uint8_t));
+		}
+
 		amd_device_id.device_id_byte1 =
 				(uint8_t)(link->ctx->asic_id.chip_id);
 		amd_device_id.device_id_byte2 =
@@ -1543,6 +1558,10 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 		return false;
 
 	link->dpcd_sink_ext_caps.raw = dpcd_data;
+	if (link->is_dds && !link->dpcd_sink_ext_caps.bits.oled) {
+		link->dpcd_sink_ext_caps.raw = 0;
+		return false;
+	}
 
 	if (core_link_read_dpcd(link, DP_EDP_GENERAL_CAP_2, &edp_general_cap2, 1) != DC_OK)
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index a4258b5b77be..e7927b8f5ba3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -161,6 +161,9 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 			link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
 		return false;
 
+	if (link->is_dds && !link->dpcd_caps.panel_luminance_control)
+		return true;
+
 	// use internal backlight control if dmub capabilities are not present
 	if (link->backlight_control_type == BACKLIGHT_CONTROL_VESA_AUX &&
 		!link->dc->caps.dmub_caps.aux_backlight_support) {
@@ -243,6 +246,8 @@ bool edp_get_backlight_level_nits(struct dc_link *link,
 			link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
 		return false;
 
+	if (link->is_dds)
+		return false;
 	if (!core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_CURRENT_PEAK,
 			dpcd_backlight_get.raw,
 			sizeof(union dpcd_source_backlight_get)))
@@ -269,6 +274,8 @@ bool edp_backlight_enable_aux(struct dc_link *link, bool enable)
 		link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
 		return false;
 
+	if (link->is_dds)
+		return true;
 	if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_ENABLE,
 		&backlight_enable, 1) != DC_OK)
 		return false;
@@ -1194,6 +1201,16 @@ int edp_get_target_backlight_pwm(const struct dc_link *link)
 	return (int) abm->funcs->get_target_backlight(abm);
 }
 
+bool is_smartmux_suported(struct dc_link *link)
+{
+	if (link->dc->caps.is_apu)
+		return false;
+	if (!link->dc->config.smart_mux_version)
+		return false;
+
+	return true;
+}
+
 static void edp_set_assr_enable(const struct dc *pDC, struct dc_link *link,
 		struct link_resource *link_res, bool enable)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index bcfa6ac5d4e7..4a475d5b9dde 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -30,6 +30,7 @@
 enum dp_panel_mode dp_get_panel_mode(struct dc_link *link);
 void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode);
 bool set_default_brightness_aux(struct dc_link *link);
+bool is_smartmux_suported(struct dc_link *link);
 void edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd);
 int edp_get_backlight_level(const struct dc_link *link);
 bool edp_get_backlight_level_nits(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 758a8aa31fbe..391209a3bf29 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -79,4 +79,6 @@ bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
 bool fill_custom_backlight_caps(unsigned int config_no,
 		struct dm_acpi_atif_backlight_caps *caps);
 void reset_replay_dsync_error_count(struct dc_link *link);
+void change_replay_to_psr(struct dc_link *link);
+void change_psr_to_replay(struct dc_link *link);
 #endif /* MODULES_POWER_POWER_HELPERS_H_ */
-- 
2.43.0

