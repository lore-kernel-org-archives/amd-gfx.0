Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDDCC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 19:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB1A10E2DF;
	Wed,  9 Mar 2022 19:21:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A0110E2DF
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 19:20:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZf7DXwJh3wq0RcK96cHSxyb6WQyH7rA3FLg2SVbTlyg6LGH/w2eluhuwMKnact2r3Vch5CK5YBM0gHHyLzr//G2yIZtxxkYj79BeIK82RSFrkPLwhWABgEA7okx7NjEcublcZEnGVt/OyG56INDw3O1ZnqZjU3OqJcV2vYNq6wuPrhMDC+kF09fqSbRrEAwvVXtIJfAvz4gjyY0SRm9uIqJvPhkVGoUjaL8fbrt8+hu7veLd6JjEPFQh5YIs4vfw7rZ5TZmEb/M7/fDsOdZq4Rbgp1FRaEQonjS3VE+l/lwbHSwLfIIxAUztTWtZLwXHH55b4BuP5aIAXr0cKUBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmR5V/FSZyMqltA/izN/08IQdm1ol3h4tDGK7TLv9TM=;
 b=oOW2tFGdwgfLojvXoSUTfsoNutPeofbe+OWawRsYuhPhupnEeoXPljA3XSlr2e6qle3w6xBrMzpennrC/4lb8+OMTYTOVReq4PeUEWAj619DTKrMpvDOBs9rHZOMciOpdb706X447+VIKbVbxpsXufuNElPd9Tg52nReAoxsh5+PSdoLmRYy7kvG/Tm1qZ6zt2ahc4SEx7bZfB8Td8gUoDQVYzDC+zcNlXuhcrbio4Tr2FlubY4GrpZ6StNy2cE+biLok2Ko6DLCU84YIO+f0RNvgBFcMqzZhMuzFVkwZGvdNMHYg5SFypqW+OOg3UmJbxDMXjurptIqwtzqsVgdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmR5V/FSZyMqltA/izN/08IQdm1ol3h4tDGK7TLv9TM=;
 b=JZISF94fAENhskW+CYep16rjDElsND/EColJSoovBTebRtbeAmScN+bQAzwmw5vfYNhnSApZGnhHf+Au3Yx4jXr1ortM28rZiGt3pUjKjAiXxbNwWbstSrjmUZW36UXDLJO3SlA9gXcXhTahTYkqURNKMLt7xarn0Ymfw+adTpY=
Received: from DM6PR12CA0013.namprd12.prod.outlook.com (2603:10b6:5:1c0::26)
 by MWHPR1201MB2495.namprd12.prod.outlook.com (2603:10b6:300:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Wed, 9 Mar
 2022 19:20:56 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::16) by DM6PR12CA0013.outlook.office365.com
 (2603:10b6:5:1c0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 19:20:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 19:20:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 9 Mar
 2022 13:20:54 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 9 Mar 2022 13:20:53 -0600
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Add pstate verification and recovery for
 DCN31
Date: Wed, 9 Mar 2022 14:19:44 -0500
Message-ID: <20220309191944.46377-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e19791cb-9967-48c3-edaf-08da0201ef62
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2495:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2495A2914F7EE2E3DBAEDE1FEC0A9@MWHPR1201MB2495.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atKMD8iT29n737QJc1Gy4YXC5ilxnMNnm4Hrk8qKjlw9QpfLwpSGbK1Tzpy31Dol1oXEZUUjeH0bdqipjp1xseL/ahFKmVN0xKHOEEh/r94GP3ltzF698wh5jpbW/Cz2ueS6SLCDjEWeG7gwQzP+3sgMHjoiLhAmH3C4oFUL7svBFVzRBWgLQbJaq6hT47dhBOlwda8MVCcFeAq1NeN6lboh4Ck88rHnhYNzMvSlAvbGxJuBNOAM9CfGLUGFfQneO90eIwIBrHTVgP5DGNhcaiVtbK7WEW81ppVXZDSlBmoE6xr2+isI2FzsdIgZmAhGFQaO/4+6BoLEn47l8ns1my9N9QI7FHRQtPElw4O0mmiBgPjN99Yufs03f2iFbEkMxYMHNkRz+PINKkzX5RyihjjDiI5a630m4DO6OY3oXuEkXB3PG70r8ds1/e8sPAz/zz6gbxXNnqXzFHRNtH2em1pyU871C+oIW5J47x8TmOotCkq1IC7uyyJF8aYd5P/I0OKLi4gCBjKD2HDevE6NO/hgGcmRuG10fvnUScOwOEw2hhtu8TF/dj17PI1OiKQ6a+Cpxk7801rxU3yKr3DNJpbRB9MgAbOpn7HQGVT4dx01C/JJ0SasFeamGh6llNxt4aM7yDD6YSt/lrR1N61t+p1vCj3PMRAiYOA6plPuRVW/VauXl63SOoVtbyabxVMqAxClRRL/2g+4SRkFg4eSpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(70206006)(36860700001)(47076005)(15650500001)(83380400001)(2906002)(26005)(44832011)(5660300002)(86362001)(6916009)(36756003)(54906003)(316002)(4326008)(426003)(8676002)(356005)(81166007)(6666004)(186003)(2616005)(508600001)(336012)(40460700003)(1076003)(82310400004)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 19:20:55.9557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e19791cb-9967-48c3-edaf-08da0201ef62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2495
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
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
To debug when p-state is being blocked and avoid PMFW hangs when
it does occur.

[How]
Re-use the DCN10 hardware sequencer by adding a new interface for
verifying p-state high on the hubbub. The interface is mostly the
same as the DCN10 interface, but the bit definitions have changed for
the debug bus.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   |  1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 10 +++-
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.c   |  1 +
 .../drm/amd/display/dc/dcn301/dcn301_hubbub.c |  1 +
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   | 60 +++++++++++++++++++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  2 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  2 +
 7 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
index f4f423d0b8c3..80595d7f060c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
@@ -940,6 +940,7 @@ static const struct hubbub_funcs hubbub1_funcs = {
 	.program_watermarks = hubbub1_program_watermarks,
 	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
 	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
+	.verify_allow_pstate_change_high = hubbub1_verify_allow_pstate_change_high,
 };
 
 void hubbub1_construct(struct hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index bc9dd48258e3..c3e141c19a77 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1112,9 +1112,13 @@ static bool dcn10_hw_wa_force_recovery(struct dc *dc)
 
 void dcn10_verify_allow_pstate_change_high(struct dc *dc)
 {
+	struct hubbub *hubbub = dc->res_pool->hubbub;
 	static bool should_log_hw_state; /* prevent hw state log by default */
 
-	if (!hubbub1_verify_allow_pstate_change_high(dc->res_pool->hubbub)) {
+	if (!hubbub->funcs->verify_allow_pstate_change_high)
+		return;
+
+	if (!hubbub->funcs->verify_allow_pstate_change_high(hubbub)) {
 		int i = 0;
 
 		if (should_log_hw_state)
@@ -1123,8 +1127,8 @@ void dcn10_verify_allow_pstate_change_high(struct dc *dc)
 		TRACE_DC_PIPE_STATE(pipe_ctx, i, MAX_PIPES);
 		BREAK_TO_DEBUGGER();
 		if (dcn10_hw_wa_force_recovery(dc)) {
-		/*check again*/
-			if (!hubbub1_verify_allow_pstate_change_high(dc->res_pool->hubbub))
+			/*check again*/
+			if (!hubbub->funcs->verify_allow_pstate_change_high(hubbub))
 				BREAK_TO_DEBUGGER();
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
index f4414de96acc..152c9c5733f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
@@ -448,6 +448,7 @@ static const struct hubbub_funcs hubbub30_funcs = {
 	.program_watermarks = hubbub3_program_watermarks,
 	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
 	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
+	.verify_allow_pstate_change_high = hubbub1_verify_allow_pstate_change_high,
 	.force_wm_propagate_to_pipes = hubbub3_force_wm_propagate_to_pipes,
 	.force_pstate_change_control = hubbub3_force_pstate_change_control,
 	.init_watermarks = hubbub3_init_watermarks,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c
index 1e3bd2e9cdcc..a046664e2031 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c
@@ -60,6 +60,7 @@ static const struct hubbub_funcs hubbub301_funcs = {
 	.program_watermarks = hubbub3_program_watermarks,
 	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
 	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
+	.verify_allow_pstate_change_high = hubbub1_verify_allow_pstate_change_high,
 	.force_wm_propagate_to_pipes = hubbub3_force_wm_propagate_to_pipes,
 	.force_pstate_change_control = hubbub3_force_pstate_change_control,
 	.hubbub_read_state = hubbub2_read_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
index 5e3bcaf12cac..3e6d6ebd199e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
@@ -949,6 +949,65 @@ static void hubbub31_get_dchub_ref_freq(struct hubbub *hubbub,
 	}
 }
 
+static bool hubbub31_verify_allow_pstate_change_high(struct hubbub *hubbub)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	/*
+	 * Pstate latency is ~20us so if we wait over 40us and pstate allow
+	 * still not asserted, we are probably stuck and going to hang
+	 */
+	const unsigned int pstate_wait_timeout_us = 100;
+	const unsigned int pstate_wait_expected_timeout_us = 40;
+
+	static unsigned int max_sampled_pstate_wait_us; /* data collection */
+	static bool forced_pstate_allow; /* help with revert wa */
+
+	unsigned int debug_data = 0;
+	unsigned int i;
+
+	if (forced_pstate_allow) {
+		/* we hacked to force pstate allow to prevent hang last time
+		 * we verify_allow_pstate_change_high.  so disable force
+		 * here so we can check status
+		 */
+		REG_UPDATE_2(DCHUBBUB_ARB_DRAM_STATE_CNTL,
+			     DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_VALUE, 0,
+			     DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_ENABLE, 0);
+		forced_pstate_allow = false;
+	}
+
+	REG_WRITE(DCHUBBUB_TEST_DEBUG_INDEX, hubbub2->debug_test_index_pstate);
+
+	for (i = 0; i < pstate_wait_timeout_us; i++) {
+		debug_data = REG_READ(DCHUBBUB_TEST_DEBUG_DATA);
+
+		/* Debug bit is specific to ASIC. */
+		if (debug_data & (1 << 26)) {
+			if (i > pstate_wait_expected_timeout_us)
+				DC_LOG_WARNING("pstate took longer than expected ~%dus\n", i);
+			return true;
+		}
+		if (max_sampled_pstate_wait_us < i)
+			max_sampled_pstate_wait_us = i;
+
+		udelay(1);
+	}
+
+	/* force pstate allow to prevent system hang
+	 * and break to debugger to investigate
+	 */
+	REG_UPDATE_2(DCHUBBUB_ARB_DRAM_STATE_CNTL,
+		     DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_VALUE, 1,
+		     DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_ENABLE, 1);
+	forced_pstate_allow = true;
+
+	DC_LOG_WARNING("pstate TEST_DEBUG_DATA: 0x%X\n",
+			debug_data);
+
+	return false;
+}
+
 static const struct hubbub_funcs hubbub31_funcs = {
 	.update_dchub = hubbub2_update_dchub,
 	.init_dchub_sys_ctx = hubbub31_init_dchub_sys_ctx,
@@ -961,6 +1020,7 @@ static const struct hubbub_funcs hubbub31_funcs = {
 	.program_watermarks = hubbub31_program_watermarks,
 	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
 	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
+	.verify_allow_pstate_change_high = hubbub31_verify_allow_pstate_change_high,
 	.program_det_size = dcn31_program_det_size,
 	.program_compbuf_size = dcn31_program_compbuf_size,
 	.init_crb = dcn31_init_crb,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 7dbe301a994a..89b7b6b7254a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1011,7 +1011,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.max_downscale_src_width = 4096,/*upto true 4K*/
 	.disable_pplib_wm_range = false,
 	.scl_reset_length10 = true,
-	.sanity_checks = false,
+	.sanity_checks = true,
 	.underflow_assert_delay_us = 0xFFFFFFFF,
 	.dwb_fi_phase = -1, // -1 = disable,
 	.dmub_command_table = true,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 713f5558f5e1..9195dec294c2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -154,6 +154,8 @@ struct hubbub_funcs {
 	bool (*is_allow_self_refresh_enabled)(struct hubbub *hubbub);
 	void (*allow_self_refresh_control)(struct hubbub *hubbub, bool allow);
 
+	bool (*verify_allow_pstate_change_high)(struct hubbub *hubbub);
+
 	void (*apply_DEDCN21_147_wa)(struct hubbub *hubbub);
 
 	void (*force_wm_propagate_to_pipes)(struct hubbub *hubbub);
-- 
2.25.1

