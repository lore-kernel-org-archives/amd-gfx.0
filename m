Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380B6CDB482
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC0C410E41F;
	Wed, 18 Oct 2023 17:42:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F6510E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfAN+FWzie3OlPJ/WZlw2iDeM+skwptVMlGm+odo2iXKZkL9dBQbnJOkQqgOBX/CT3MymolU6Dk3Xf3232/6Tnni5nI+mwofHtwcc+dnd5bp7H1Zg4D4RMvis4V8mFcgM+jCe7D5LkXtkwkEReEUEvbK11K/PGWLA9rXM2pBfrqthqLLgEwcmuOk5fIMaF7cZWuyeX+2tlxzY9iqCxtcuIvVYrgtKJNnnsEgN0byncDnbqrFqQoqDBMS6+AKDnGrZplOsEc/hVS7CxlqDPgkYL2rfGBjNkQujqOtBGAJLQJQwNG0JGrL3SzeETq6xQoy39Vnfq+BO+RGDBoz0fPvyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iy2SA5/v8L1f8X/zFgIJBc7UTcyomFRXUhKFmzjYKpI=;
 b=HyqHLmk12WxFxngauPszsJeNcZRywmfXeTrz15i+7wqYSBPCrWjPwPeo9chWVr1rK64DvmGrbstMkybG/hzVUWwo1ztIJIoTDSiUrtgf2oHWDAsZb6eDz4bK/amM+9lZ5wm/l2D+Mf4kXlrmT0VanrpLBMfwwquuCXc6q/4ac1bS6a/wIIWmsW9yon+qen7dC0zFJleMtO4vnWScqmE77m5l9E5d12XL2Tv51Sej2DHIN9U2EG0ySy8YwYrTIq2qdVP0+0fgS7fyUO9G0PNiLESZh7jZDj6TYSCjffrP39J7VCHLj7Ps0OqKlB/xQ/w6K9yoXSi1B04Ahw8PxIChmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iy2SA5/v8L1f8X/zFgIJBc7UTcyomFRXUhKFmzjYKpI=;
 b=pRKnn8e4W2z9SbKYyeanZP9ew5gVrpqEnuQQcaMjwsTR9PTBJ9PXYumHf1Bmf/3flH/X2PuQgf+gXs5R5ZqSPS+4xX2AHJxHGMhZXlqNTEm6yn3VoBBbXLU2loudN1RoDJo79t/fIy2bcM8myqesPau1oH98h75oFiFc/n0dVCg=
Received: from BY5PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:1e0::16)
 by SN7PR12MB7202.namprd12.prod.outlook.com (2603:10b6:806:2a9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 17:42:33 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::ab) by BY5PR03CA0006.outlook.office365.com
 (2603:10b6:a03:1e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37 via Frontend
 Transport; Wed, 18 Oct 2023 17:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:42:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:41:59 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:41:58 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/26] drm/amd/display: Add a check for idle power optimization
Date: Wed, 18 Oct 2023 13:41:13 -0400
Message-ID: <20231018174133.1613439-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|SN7PR12MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: c233f53f-a231-4dc3-f6eb-08dbd0019bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0uTkDzWrQC9e4RfuUzRWFq35qakgGxxjcTNjqWE3hPrO7BTkXF6uqMZUOYPlSqT6n8Xk0BGhXB/0sHmclgKplEO9ANG3WQ05W7N+Vf2ZT2kAzYEwXZdCunCUHSpxCPfY165q0VnIp0bSkFyVxwRC0yl4xOxeDfh5V1rTbyMe63FrBVtRzNIV5ruvc695PA2Hc+JNC4A6a6j39RCKWECEe0k8HiA50te8uIOeR7t4lDXC5NpecW6wYLpWW5UgXOKQwxfvHa4aTjhEDZtx/6LrLW9bTf/zp2dRiiWJoSVk/bSehArjtFssNOUAt9sut/968svbYYhlznzdd5F7Vpb9Qb+l7zKonEVA3OibWD6kGXCCShmHH/L47bpScFnQnyNlGqtUylT6eEwbdpe3Rx7o3/5z/wipyr/Aqi7XlnEYu/Wc0ERuPihTuyQhYIfZFM+6XCtvd+BlEmrel7BGqBxyR6NSPXFrr80ySVfd0mVq0oCzrxV7RNqZSDtSxGWVVhQxl13p5gv/n7OyEL2fsE7uPE8f/9sflV+dzUpg3op7vHpCXMZLQuMJfeo4b0dHm8MbkFF51lK0+0C7ZBHAMwg4R0eS/u4RGwseWCu/xpJJs3dJ8LRVxNfRTDFtsh0eXp++YDC3BD+qs0PZkGP1MyBEfqxJiUyAqWsUUJHr9RLpScpgbnUjl5HrxaKfjs9YpUOFSDbXmCvzDJKT5PM/sGsCRVGB+eod5eHZA4hWDwL0dHZ5qUNPH/gMEtx5L1ox1lPcEioPx/BsV1vHRlGvFWUZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(2616005)(8936002)(40480700001)(426003)(26005)(40460700003)(82740400003)(356005)(478600001)(81166007)(316002)(1076003)(336012)(2906002)(36756003)(70586007)(6916009)(70206006)(4326008)(54906003)(5660300002)(86362001)(41300700001)(8676002)(2876002)(7696005)(47076005)(6666004)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:42:33.1455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c233f53f-a231-4dc3-f6eb-08dbd0019bf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7202
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Sung Joon Kim <sungkim@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Nicholas Choi <nicholas.choi@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
Need a helper function to check idle power is allowed
so that dc doesn't access any registers that are power-gated.

[how]
Implement helper function to check idle power optimization.
Enable a hook to check if detection is allowed.

V2:
Add function hooks for set and get idle states.
Check if function hook was properly initialized.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Nicholas Choi <nicholas.choi@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 23 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  4 +++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  8 ++-----
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  2 ++
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  2 ++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  1 +
 7 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 49e31bd52992..4f2b9911e6ff 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4821,6 +4821,9 @@ void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 	if (dc->debug.disable_idle_power_optimizations)
 		return;
 
+	if (dc->caps.ips_support && dc->config.disable_ips)
+		return;
+
 	if (dc->clk_mgr != NULL && dc->clk_mgr->funcs->is_smu_present)
 		if (!dc->clk_mgr->funcs->is_smu_present(dc->clk_mgr))
 			return;
@@ -4832,6 +4835,26 @@ void dc_allow_idle_optimizations(struct dc *dc, bool allow)
 		dc->idle_optimizations_allowed = allow;
 }
 
+bool dc_dmub_is_ips_idle_state(struct dc *dc)
+{
+	uint32_t idle_state = 0;
+
+	if (dc->debug.disable_idle_power_optimizations)
+		return false;
+
+	if (!dc->caps.ips_support || dc->config.disable_ips)
+		return false;
+
+	if (dc->hwss.get_idle_state)
+		idle_state = dc->hwss.get_idle_state(dc);
+
+	if ((idle_state & DMUB_IPS1_ALLOW_MASK) ||
+		(idle_state & DMUB_IPS2_ALLOW_MASK))
+		return true;
+
+	return false;
+}
+
 /* set min and max memory clock to lowest and highest DPM level, respectively */
 void dc_unlock_memory_clock_frequency(struct dc *dc)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index cc1cae4d7329..e3b8c71e2c31 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2362,6 +2362,7 @@ bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc, struct dc_plane_
 				struct dc_cursor_attributes *cursor_attr);
 
 void dc_allow_idle_optimizations(struct dc *dc, bool allow);
+bool dc_dmub_is_ips_idle_state(struct dc *dc);
 
 /* set min and max memory clock to lowest and highest DPM level, respectively */
 void dc_unlock_memory_clock_frequency(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 5daedd893923..5d62805f3bdf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -586,7 +586,9 @@ void dcn31_reset_hw_ctx_wrap(
 			struct clock_source *old_clk = pipe_ctx_old->clock_source;
 
 			/* Reset pipe which is seamless boot stream. */
-			if (!pipe_ctx_old->plane_state) {
+			if (!pipe_ctx_old->plane_state &&
+				dc->res_pool->hubbub->funcs->program_det_size &&
+				dc->res_pool->hubbub->funcs->wait_for_det_apply) {
 				dc->res_pool->hubbub->funcs->program_det_size(
 					dc->res_pool->hubbub, pipe_ctx_old->plane_res.hubp->inst, 0);
 				/* Wait det size changed. */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 12821cb9ab6c..36d2b91aa337 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -627,12 +627,8 @@ void dcn35_power_down_on_boot(struct dc *dc)
 	if (dc->clk_mgr->funcs->set_low_power_state)
 		dc->clk_mgr->funcs->set_low_power_state(dc->clk_mgr);
 
-	if (dc->clk_mgr->clks.pwr_state == DCN_PWR_STATE_LOW_POWER) {
-		if (!dc->idle_optimizations_allowed) {
-			dc_dmub_srv_notify_idle(dc, true);
-			dc->idle_optimizations_allowed = true;
-		}
-	}
+	if (dc->clk_mgr->clks.pwr_state == DCN_PWR_STATE_LOW_POWER)
+		dc_allow_idle_optimizations(dc, true);
 }
 
 bool dcn35_apply_idle_power_optimizations(struct dc *dc, bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index d45302035e3f..c43d1f6c2a06 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -418,6 +418,8 @@ struct hw_sequencer_funcs {
 		struct pg_block_update *update_state, bool power_on);
 	void (*root_clock_control)(struct dc *dc,
 		struct pg_block_update *update_state, bool power_on);
+	void (*set_idle_state)(const struct dc *dc, bool allow_idle);
+	uint32_t (*get_idle_state)(const struct dc *dc);
 
 	bool (*is_pipe_topology_transition_seamless)(struct dc *dc,
 			const struct dc_state *cur_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index cb2dc3f75ae2..fa9614bcb160 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -262,6 +262,8 @@ struct clk_mgr_funcs {
 	void (*set_low_power_state)(struct clk_mgr *clk_mgr);
 	void (*exit_low_power_state)(struct clk_mgr *clk_mgr);
 	bool (*is_ips_supported)(struct clk_mgr *clk_mgr);
+	void (*set_idle_state)(struct clk_mgr *clk_mgr, bool allow_idle);
+	uint32_t (*get_idle_state)(struct clk_mgr *clk_mgr);
 
 	void (*init_clocks)(struct clk_mgr *clk_mgr);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index b99db771e071..e43e8d4bfe37 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -352,6 +352,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 			funcs->init_reg_offsets = dmub_srv_dcn35_regs_init;
 
 			funcs->is_hw_powered_up = dmub_dcn35_is_hw_powered_up;
+			funcs->should_detect = dmub_dcn35_should_detect;
 			break;
 
 	default:
-- 
2.34.1

