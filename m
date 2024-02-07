Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925A0C4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D0110E434;
	Wed,  7 Feb 2024 20:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CfnHN8Pq";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E7C10E3C8
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMpC/bMgAyas+KihP7l/q4qzxSsbcwm3LW7vzt3iTpQT5OaTdIXKb8BLXhW7JmM7IBa7PzTObgYfn/cx5ps3PcMC1hIcvJWdnss3GrnZNIDLMx1YGwmFuweToY9Ho+3QmdGjBOtjJ68/o02zgJwB7yuxnpxYqRdkrub2dQC/LJdNYtJKrBx3UAtkKvemcu/nPU8CfU9ffQb/Ni2sk7DFK/5flsk6CYpDLOOc2amHangPGG6LqeKgrZF8fozkXne+dBmxzU377++be9veajZ+a6/w7cuK45duYWq2yJdqws7Jd8471Gc/Vs4TH9evVGyrtF5fp8dW0Jd5YEuqhp/bhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMkYCkr8JvZb5oJCLC6fDgz9rZmvlwAMAc6qBbccYpQ=;
 b=EccaJhEgCHRRCe1205e750WtyL3mmOaZu2b6HdyILWI3yVOGaJeS2xUn3Lpqp6/03SJDkjvAOAMOJ0JzsaXtFqERzaq5ENCNZNKmktxuvBAmiThgKYflesdu0j3txQLfkqBXbwA4MA4Kqj0vYZJqPHHgJUVbWQfKoqpO4F6nqisvWmtsOeQtrGtPjWlb0xv9rcYaHtqZpuAxiuM2tvEfRS9yhfKPYOmn0rRXkr+KwVSgS2F27wWxglNY/4PKnUcRSaxphOiyNvflgkowZVtoLf684MOF6ZfbBI7uEl9T783nrn7oK2jT5gjlyvxLK/zX3NDTSM/TAdeSYLGPCej6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMkYCkr8JvZb5oJCLC6fDgz9rZmvlwAMAc6qBbccYpQ=;
 b=CfnHN8Pq/EdTZLzpES7k2tinqnEbY7wmjCxgLCTxFQRQ5swPhcYjGv3hq3BbwXynD4UfcD2GiKl+BX0lfhFSECo1QW4lZz3faA3xqsNA3MCTeg7VspJmVLbBOtD5zSJu0CQjSOp52/aWZJBH60eZTqY9LSDRWdl1Tk+RvmB37FY=
Received: from DM6PR18CA0007.namprd18.prod.outlook.com (2603:10b6:5:15b::20)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 7 Feb
 2024 20:52:16 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::95) by DM6PR18CA0007.outlook.office365.com
 (2603:10b6:5:15b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Wed, 7 Feb 2024 20:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 20:52:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:15 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:15 -0600
Received: from manjaura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 14:52:14 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 10/15] drm/amd/display: Add shared firmware state for DMUB IPS
 handshake
Date: Wed, 7 Feb 2024 15:50:45 -0500
Message-ID: <20240207205200.1608684-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
References: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b68c38c-ea9e-48c3-d326-08dc281eab3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ugzan5cZbGQNu04uZEF5uKk8uQzE8Ofm3mfHNn49sncQrsw4BMBAtHZ49vcZYE7PQJfvz9DHHuM53tS1/ipfK3QYoy0uQzDqU8OOX7JkHXvaXO+K/IicYYHi0U0jYsXr6CzP2b6LvcyagL1S24J99T7NFzIM5wm3os+ZilhvfZQq9An7qFIVHCb7xmQ9HwSvDGsk1sUkNX8EWNkvA0POGwEjK0TMwaGKA1VmaCUHc637JcV8qW8YUdTraH7uBGMJSzWi3MfZYT7sVsAGIs7Ej0I8WVXoaAClfG2iU/gADeY8rSkdNGKnN9BsLl7q7cD0cwWIZ3qOVW47b3ckgUWd+PmI4Q3U5QcHCnS08IKGokaPMIwaJ8yS/8BOoLMKy2GRP4gkd60ytC0N/mn71qG2UR/mxmiF+2YHsnSNrM1Py88BtzDZvtGpdSl/ufToXOzTJecYp91bmwqWn3yvxd6t3kiaqoyuB7epJxt0PkQ+roHuZZmxMqcOd9RNoIypUE9TrIVKByL66WBOzDev/Q4ttczLE5fmdFAdC8iHgWeJuLseT8T7GUoxCWEcHpzXTMnYgkM5syEJaNs8L8q60lvkCLRJ7tBq94OpUfkaR21JngU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(54906003)(44832011)(6916009)(2906002)(82740400003)(316002)(8936002)(70206006)(356005)(36756003)(4326008)(86362001)(30864003)(81166007)(8676002)(70586007)(5660300002)(26005)(426003)(336012)(1076003)(2616005)(83380400001)(478600001)(6666004)(7696005)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:52:16.5043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b68c38c-ea9e-48c3-d326-08dc281eab3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128
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
Read modify write hazards can occur when using a single shared scratch
register between driver and firmware leading to driver accessing DCN
in IPS2 and a system hang.

[How]
Add infrastructure for using REGION6 as a shared firmware state between
driver and firmware. This region is uncachable.

Replace the existing get/set idle calls with reads/writes to the
(volatile) shared firmware state blocks that a separated by at least
a cache line between firmware and driver.

Remove the workarounds that required rewriting/checking read modify
write hazards.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  83 +++++++------
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   6 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 115 ++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.h |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  12 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.h |   8 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  13 +-
 15 files changed, 212 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fccc87ad401f..4cf4db0e5b08 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2129,7 +2129,8 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_4_MAILBOX
 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_5_TRACEBUFF
 		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_6_FW_STATE
-		DMUB_WINDOW_MEMORY_TYPE_FB		//DMUB_WINDOW_7_SCRATCH_MEM
+		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_7_SCRATCH_MEM
+		DMUB_WINDOW_MEMORY_TYPE_FB,		//DMUB_WINDOW_SHARED_STATE
 	};
 	int r;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index a1477906fe4f..0bc32537e2eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1198,6 +1198,7 @@ bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
 
 static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 {
+	struct dc_dmub_srv *dc_dmub_srv;
 	union dmub_rb_cmd cmd = {0};
 
 	if (dc->debug.dmcub_emulation)
@@ -1206,6 +1207,8 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 	if (!dc->ctx->dmub_srv || !dc->ctx->dmub_srv->dmub)
 		return;
 
+	dc_dmub_srv = dc->ctx->dmub_srv;
+
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.idle_opt_notify_idle.header.type = DMUB_CMD__IDLE_OPT;
 	cmd.idle_opt_notify_idle.header.sub_type = DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE;
@@ -1216,10 +1219,32 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 	cmd.idle_opt_notify_idle.cntl_data.driver_idle = allow_idle;
 
 	if (allow_idle) {
+		volatile struct dmub_shared_state_ips_driver *ips_driver =
+			&dc_dmub_srv->dmub->shared_state[DMUB_SHARED_SHARE_FEATURE__IPS_DRIVER].data.ips_driver;
+		union dmub_shared_state_ips_driver_signals new_signals;
+
 		dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
 
-		if (dc->hwss.set_idle_state)
-			dc->hwss.set_idle_state(dc, true);
+		memset(&new_signals, 0, sizeof(new_signals));
+
+		if (dc->config.disable_ips == DMUB_IPS_ENABLE ||
+		    dc->config.disable_ips == DMUB_IPS_DISABLE_DYNAMIC) {
+			new_signals.bits.allow_pg = 1;
+			new_signals.bits.allow_ips1 = 1;
+			new_signals.bits.allow_ips2 = 1;
+			new_signals.bits.allow_z10 = 1;
+		} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS1) {
+			new_signals.bits.allow_ips1 = 1;
+		} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2) {
+			new_signals.bits.allow_pg = 1;
+			new_signals.bits.allow_ips1 = 1;
+		} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2_Z10) {
+			new_signals.bits.allow_pg = 1;
+			new_signals.bits.allow_ips1 = 1;
+			new_signals.bits.allow_ips2 = 1;
+		}
+
+		ips_driver->signals = new_signals;
 	}
 
 	/* NOTE: This does not use the "wake" interface since this is part of the wake path. */
@@ -1229,8 +1254,7 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 
 static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 {
-	uint32_t allow_state = 0;
-	uint32_t commit_state = 0;
+	struct dc_dmub_srv *dc_dmub_srv;
 
 	if (dc->debug.dmcub_emulation)
 		return;
@@ -1238,61 +1262,44 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 	if (!dc->ctx->dmub_srv || !dc->ctx->dmub_srv->dmub)
 		return;
 
-	if (dc->hwss.get_idle_state &&
-		dc->hwss.set_idle_state &&
-		dc->clk_mgr->funcs->exit_low_power_state) {
+	dc_dmub_srv = dc->ctx->dmub_srv;
 
-		allow_state = dc->hwss.get_idle_state(dc);
-		dc->hwss.set_idle_state(dc, false);
+	if (dc->clk_mgr->funcs->exit_low_power_state) {
+		volatile const struct dmub_shared_state_ips_fw *ips_fw =
+			&dc_dmub_srv->dmub->shared_state[DMUB_SHARED_SHARE_FEATURE__IPS_FW].data.ips_fw;
+		volatile struct dmub_shared_state_ips_driver *ips_driver =
+			&dc_dmub_srv->dmub->shared_state[DMUB_SHARED_SHARE_FEATURE__IPS_DRIVER].data.ips_driver;
+		union dmub_shared_state_ips_driver_signals prev_driver_signals = ips_driver->signals;
 
-		if (!(allow_state & DMUB_IPS2_ALLOW_MASK)) {
-			// Wait for evaluation time
-			for (;;) {
-				udelay(dc->debug.ips2_eval_delay_us);
-				commit_state = dc->hwss.get_idle_state(dc);
-				if (commit_state & DMUB_IPS2_ALLOW_MASK)
-					break;
+		ips_driver->signals.all = 0;
 
-				/* allow was still set, retry eval delay */
-				dc->hwss.set_idle_state(dc, false);
-			}
+		if (prev_driver_signals.bits.allow_ips2) {
+			udelay(dc->debug.ips2_eval_delay_us);
 
-			if (!(commit_state & DMUB_IPS2_COMMIT_MASK)) {
+			if (ips_fw->signals.bits.ips2_commit) {
 				// Tell PMFW to exit low power state
 				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
 
 				// Wait for IPS2 entry upper bound
 				udelay(dc->debug.ips2_entry_delay_us);
-				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
 
-				for (;;) {
-					commit_state = dc->hwss.get_idle_state(dc);
-					if (commit_state & DMUB_IPS2_COMMIT_MASK)
-						break;
+				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
 
+				while (ips_fw->signals.bits.ips2_commit)
 					udelay(1);
-				}
 
 				if (!dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true))
 					ASSERT(0);
 
-				/* TODO: See if we can return early here - IPS2 should go
-				 * back directly to IPS0 and clear the flags, but it will
-				 * be safer to directly notify DMCUB of this.
-				 */
-				allow_state = dc->hwss.get_idle_state(dc);
+				dmub_srv_sync_inbox1(dc->ctx->dmub_srv->dmub);
 			}
 		}
 
 		dc_dmub_srv_notify_idle(dc, false);
-		if (!(allow_state & DMUB_IPS1_ALLOW_MASK)) {
-			for (;;) {
-				commit_state = dc->hwss.get_idle_state(dc);
-				if (commit_state & DMUB_IPS1_COMMIT_MASK)
-					break;
-
+		if (prev_driver_signals.bits.allow_ips1) {
+			while (ips_fw->signals.bits.ips1_commit)
 				udelay(1);
-			}
+
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index ae30fe2b6d0d..ff2a65e67bd4 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -125,6 +125,7 @@ enum dmub_window_id {
 	DMUB_WINDOW_5_TRACEBUFF,
 	DMUB_WINDOW_6_FW_STATE,
 	DMUB_WINDOW_7_SCRATCH_MEM,
+	DMUB_WINDOW_SHARED_STATE,
 	DMUB_WINDOW_TOTAL,
 };
 
@@ -368,7 +369,8 @@ struct dmub_srv_hw_funcs {
 			      const struct dmub_window *cw3,
 			      const struct dmub_window *cw4,
 			      const struct dmub_window *cw5,
-			      const struct dmub_window *cw6);
+			      const struct dmub_window *cw6,
+			      const struct dmub_window *region6);
 
 	void (*setup_mailbox)(struct dmub_srv *dmub,
 			      const struct dmub_region *inbox1);
@@ -461,6 +463,7 @@ struct dmub_srv_create_params {
  * @user_ctx: user provided context for the dmub_srv
  * @fw_version: the current firmware version, if any
  * @is_virtual: false if hardware support only
+ * @shared_state: dmub shared state between firmware and driver
  * @fw_state: dmub firmware state pointer
  */
 struct dmub_srv {
@@ -469,6 +472,7 @@ struct dmub_srv {
 	uint32_t fw_version;
 	bool is_virtual;
 	struct dmub_fb scratch_mem_fb;
+	volatile struct dmub_shared_state_feature_block *shared_state;
 	volatile const struct dmub_fw_state *fw_state;
 
 	/* private: internal use only */
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 59b96136871e..a529e369b2ac 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -508,6 +508,8 @@ struct dmub_visual_confirm_color {
  * @trace_buffer_size: size of the tracebuffer region
  * @fw_version: the firmware version information
  * @dal_fw: 1 if the firmware is DAL
+ * @shared_state_size: size of the shared state region in bytes
+ * @shared_state_features: number of shared state features
  */
 struct dmub_fw_meta_info {
 	uint32_t magic_value; /**< magic value identifying DMUB firmware meta info */
@@ -516,6 +518,9 @@ struct dmub_fw_meta_info {
 	uint32_t fw_version; /**< the firmware version information */
 	uint8_t dal_fw; /**< 1 if the firmware is DAL */
 	uint8_t reserved[3]; /**< padding bits */
+	uint32_t shared_state_size; /**< size of the shared state region in bytes */
+	uint16_t shared_state_features; /**< number of shared state features */
+	uint16_t reserved2; /**< padding bytes */
 };
 
 /**
@@ -659,6 +664,116 @@ enum dmub_fw_boot_options_bit {
 	DMUB_FW_BOOT_OPTION_BIT_OPTIMIZED_INIT_DONE = (1 << 2), /**< 1 if optimized init done */
 };
 
+//==============================================================================
+//< DMUB_SHARED_STATE>==========================================================
+//==============================================================================
+
+/**
+ * Shared firmware state between driver and firmware for lockless communication
+ * in situations where the inbox/outbox may be unavailable.
+ *
+ * Each structure *must* be at most 256-bytes in size. The layout allocation is
+ * described below:
+ *
+ * [Header (256 Bytes)][Feature 1 (256 Bytes)][Feature 2 (256 Bytes)]...
+ */
+
+/**
+ * enum dmub_shared_state_feature_id - List of shared state features.
+ */
+enum dmub_shared_state_feature_id {
+	DMUB_SHARED_SHARE_FEATURE__INVALID = 0,
+	DMUB_SHARED_SHARE_FEATURE__IPS_FW = 1,
+	DMUB_SHARED_SHARE_FEATURE__IPS_DRIVER = 2,
+	DMUB_SHARED_STATE_FEATURE__LAST, /* Total number of features. */
+};
+
+/**
+ * struct dmub_shared_state_ips_fw - Firmware signals for IPS.
+ */
+union dmub_shared_state_ips_fw_signals {
+	struct {
+		uint32_t ips1_commit : 1;  /**< 1 if in IPS1 */
+		uint32_t ips2_commit : 1; /**< 1 if in IPS2 */
+		uint32_t reserved_bits : 30; /**< Reversed */
+	} bits;
+	uint32_t all;
+};
+
+/**
+ * struct dmub_shared_state_ips_signals - Firmware signals for IPS.
+ */
+union dmub_shared_state_ips_driver_signals {
+	struct {
+		uint32_t allow_pg : 1; /**< 1 if PG is allowed */
+		uint32_t allow_ips1 : 1; /**< 1 is IPS1 is allowed */
+		uint32_t allow_ips2 : 1; /**< 1 is IPS1 is allowed */
+		uint32_t allow_z10 : 1; /**< 1 if Z10 is allowed */
+		uint32_t reserved_bits : 28; /**< Reversed bits */
+	} bits;
+	uint32_t all;
+};
+
+/**
+ * IPS FW Version
+ */
+#define DMUB_SHARED_STATE__IPS_FW_VERSION 1
+
+/**
+ * struct dmub_shared_state_ips_fw - Firmware state for IPS.
+ */
+struct dmub_shared_state_ips_fw {
+	union dmub_shared_state_ips_fw_signals signals; /**< 4 bytes, IPS signal bits */
+	uint32_t reserved[61]; /**< Reversed, to be updated when adding new fields. */
+}; /* 248-bytes, fixed */
+
+/**
+ * IPS Driver Version
+ */
+#define DMUB_SHARED_STATE__IPS_DRIVER_VERSION 1
+
+/**
+ * struct dmub_shared_state_ips_driver - Driver state for IPS.
+ */
+struct dmub_shared_state_ips_driver {
+	union dmub_shared_state_ips_driver_signals signals; /**< 4 bytes, IPS signal bits */
+	uint32_t reserved[61]; /**< Reversed, to be updated when adding new fields. */
+}; /* 248-bytes, fixed */
+
+/**
+ * enum dmub_shared_state_feature_common - Generic payload.
+ */
+struct dmub_shared_state_feature_common {
+	uint32_t padding[62];
+}; /* 248-bytes, fixed */
+
+/**
+ * enum dmub_shared_state_feature_header - Feature description.
+ */
+struct dmub_shared_state_feature_header {
+	uint16_t id; /**< Feature ID */
+	uint16_t version; /**< Feature version */
+	uint32_t reserved; /**< Reserved bytes. */
+}; /* 8 bytes, fixed */
+
+/**
+ * struct dmub_shared_state_feature_block - Feature block.
+ */
+struct dmub_shared_state_feature_block {
+	struct dmub_shared_state_feature_header header; /**< Shared state header. */
+	union dmub_shared_feature_state_union {
+		struct dmub_shared_state_feature_common common; /**< Generic data */
+		struct dmub_shared_state_ips_fw ips_fw; /**< IPS firmware state */
+		struct dmub_shared_state_ips_driver ips_driver; /**< IPS driver state */
+	} data; /**< Shared state data. */
+}; /* 256-bytes, fixed */
+
+/**
+ * Shared state size in bytes.
+ */
+#define DMUB_FW_HEADER_SHARED_STATE_SIZE \
+	((DMUB_SHARED_STATE_FEATURE__LAST + 1) * sizeof(struct dmub_shared_state_feature_block))
+
 //==============================================================================
 //</DMUB_STATUS>================================================================
 //==============================================================================
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 98dad0d47e72..cae96fba6349 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -191,7 +191,8 @@ void dmub_dcn20_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw3,
 			      const struct dmub_window *cw4,
 			      const struct dmub_window *cw5,
-			      const struct dmub_window *cw6)
+			      const struct dmub_window *cw6,
+			      const struct dmub_window *region6)
 {
 	union dmub_addr offset;
 	uint64_t fb_base, fb_offset;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index 1df128e57ed3..de287b101848 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -197,7 +197,8 @@ void dmub_dcn20_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw3,
 			      const struct dmub_window *cw4,
 			      const struct dmub_window *cw5,
-			      const struct dmub_window *cw6);
+			      const struct dmub_window *cw6,
+			      const struct dmub_window *region6);
 
 void dmub_dcn20_setup_mailbox(struct dmub_srv *dmub,
 			      const struct dmub_region *inbox1);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
index 81dae75e9ff8..a4abe951c838 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
@@ -124,7 +124,8 @@ void dmub_dcn30_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw3,
 			      const struct dmub_window *cw4,
 			      const struct dmub_window *cw5,
-			      const struct dmub_window *cw6)
+			      const struct dmub_window *cw6,
+			      const struct dmub_window *region6)
 {
 	union dmub_addr offset;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h
index 9a3afffd9b0f..066f35a50094 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.h
@@ -43,7 +43,8 @@ void dmub_dcn30_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw3,
 			      const struct dmub_window *cw4,
 			      const struct dmub_window *cw5,
-			      const struct dmub_window *cw6);
+			      const struct dmub_window *cw6,
+			      const struct dmub_window *region6);
 
 
 #endif /* _DMUB_DCN30_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 094e9f864557..2bcf5fb87dd9 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -187,7 +187,8 @@ void dmub_dcn31_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw3,
 			      const struct dmub_window *cw4,
 			      const struct dmub_window *cw5,
-			      const struct dmub_window *cw6)
+			      const struct dmub_window *cw6,
+			      const struct dmub_window *region6)
 {
 	union dmub_addr offset;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
index 4d520a893c7b..eccdab4986ce 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
@@ -199,7 +199,8 @@ void dmub_dcn31_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw3,
 			      const struct dmub_window *cw4,
 			      const struct dmub_window *cw5,
-			      const struct dmub_window *cw6);
+			      const struct dmub_window *cw6,
+			      const struct dmub_window *region6);
 
 void dmub_dcn31_setup_mailbox(struct dmub_srv *dmub,
 			      const struct dmub_region *inbox1);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index 305463b8f110..0d521eeda050 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -216,7 +216,8 @@ void dmub_dcn32_setup_windows(struct dmub_srv *dmub,
 		const struct dmub_window *cw3,
 		const struct dmub_window *cw4,
 		const struct dmub_window *cw5,
-		const struct dmub_window *cw6)
+		const struct dmub_window *cw6,
+		const struct dmub_window *region6)
 {
 	union dmub_addr offset;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
index b0cd8d29402f..29c1132951af 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
@@ -206,7 +206,8 @@ void dmub_dcn32_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw3,
 			      const struct dmub_window *cw4,
 			      const struct dmub_window *cw5,
-			      const struct dmub_window *cw6);
+			      const struct dmub_window *cw6,
+			      const struct dmub_window *region6);
 
 void dmub_dcn32_setup_mailbox(struct dmub_srv *dmub,
 			      const struct dmub_region *inbox1);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 6d1fbea0f6ba..60223efc6fc8 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -229,7 +229,8 @@ void dmub_dcn35_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw3,
 			      const struct dmub_window *cw4,
 			      const struct dmub_window *cw5,
-			      const struct dmub_window *cw6)
+			      const struct dmub_window *cw6,
+			      const struct dmub_window *region6)
 {
 	union dmub_addr offset;
 
@@ -275,6 +276,15 @@ void dmub_dcn35_setup_windows(struct dmub_srv *dmub,
 	REG_SET_2(DMCUB_REGION3_CW6_TOP_ADDRESS, 0,
 		  DMCUB_REGION3_CW6_TOP_ADDRESS, cw6->region.top,
 		  DMCUB_REGION3_CW6_ENABLE, 1);
+
+	offset = region6->offset;
+
+	REG_WRITE(DMCUB_REGION6_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION6_OFFSET_HIGH, offset.u.high_part);
+	REG_SET_2(DMCUB_REGION6_TOP_ADDRESS, 0,
+		  DMCUB_REGION6_TOP_ADDRESS,
+		  region6->region.top - region6->region.base - 1,
+		  DMCUB_REGION6_ENABLE, 1);
 }
 
 void dmub_dcn35_setup_mailbox(struct dmub_srv *dmub,
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h
index 129a7031d2ae..686e97c00ccc 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h
@@ -89,6 +89,9 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_REGION5_OFFSET) \
 	DMUB_SR(DMCUB_REGION5_OFFSET_HIGH) \
 	DMUB_SR(DMCUB_REGION5_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION6_OFFSET) \
+	DMUB_SR(DMCUB_REGION6_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION6_TOP_ADDRESS) \
 	DMUB_SR(DMCUB_SCRATCH0) \
 	DMUB_SR(DMCUB_SCRATCH1) \
 	DMUB_SR(DMCUB_SCRATCH2) \
@@ -154,6 +157,8 @@ struct dmub_srv;
 	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_ENABLE) \
 	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_TOP_ADDRESS) \
 	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_ENABLE) \
+	DMUB_SF(DMCUB_REGION6_TOP_ADDRESS, DMCUB_REGION6_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION6_TOP_ADDRESS, DMCUB_REGION6_ENABLE) \
 	DMUB_SF(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE) \
 	DMUB_SF(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET) \
 	DMUB_SF(DCN_VM_FB_LOCATION_BASE, FB_BASE) \
@@ -214,7 +219,8 @@ void dmub_dcn35_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw3,
 			      const struct dmub_window *cw4,
 			      const struct dmub_window *cw5,
-			      const struct dmub_window *cw6);
+			      const struct dmub_window *cw6,
+			      const struct dmub_window *region6);
 
 void dmub_dcn35_setup_mailbox(struct dmub_srv *dmub,
 			      const struct dmub_region *inbox1);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 569c2a27a042..fb66832dc996 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -78,6 +78,7 @@
 #define DMUB_CW6_BASE (0x66000000)
 
 #define DMUB_REGION5_BASE (0xA0000000)
+#define DMUB_REGION6_BASE (0xC0000000)
 
 static struct dmub_srv_dcn32_regs dmub_srv_dcn32_regs;
 static struct dmub_srv_dcn35_regs dmub_srv_dcn35_regs;
@@ -480,6 +481,7 @@ enum dmub_status
 	window_sizes[DMUB_WINDOW_5_TRACEBUFF] = trace_buffer_size;
 	window_sizes[DMUB_WINDOW_6_FW_STATE] = fw_state_size;
 	window_sizes[DMUB_WINDOW_7_SCRATCH_MEM] = DMUB_SCRATCH_MEM_SIZE;
+	window_sizes[DMUB_WINDOW_SHARED_STATE] = DMUB_FW_HEADER_SHARED_STATE_SIZE;
 
 	out->fb_size =
 		dmub_srv_calc_regions_for_memory_type(params, out, window_sizes, DMUB_WINDOW_MEMORY_TYPE_FB);
@@ -565,9 +567,10 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	struct dmub_fb *tracebuff_fb = params->fb[DMUB_WINDOW_5_TRACEBUFF];
 	struct dmub_fb *fw_state_fb = params->fb[DMUB_WINDOW_6_FW_STATE];
 	struct dmub_fb *scratch_mem_fb = params->fb[DMUB_WINDOW_7_SCRATCH_MEM];
+	struct dmub_fb *shared_state_fb = params->fb[DMUB_WINDOW_SHARED_STATE];
 
 	struct dmub_rb_init_params rb_params, outbox0_rb_params;
-	struct dmub_window cw0, cw1, cw2, cw3, cw4, cw5, cw6;
+	struct dmub_window cw0, cw1, cw2, cw3, cw4, cw5, cw6, region6;
 	struct dmub_region inbox1, outbox1, outbox0;
 
 	if (!dmub->sw_init)
@@ -652,10 +655,16 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 
 	dmub->fw_state = fw_state_fb->cpu_addr;
 
+	region6.offset.quad_part = shared_state_fb->gpu_addr;
+	region6.region.base = DMUB_CW6_BASE;
+	region6.region.top = region6.region.base + shared_state_fb->size;
+
+	dmub->shared_state = shared_state_fb->cpu_addr;
+
 	dmub->scratch_mem_fb = *scratch_mem_fb;
 
 	if (dmub->hw_funcs.setup_windows)
-		dmub->hw_funcs.setup_windows(dmub, &cw2, &cw3, &cw4, &cw5, &cw6);
+		dmub->hw_funcs.setup_windows(dmub, &cw2, &cw3, &cw4, &cw5, &cw6, &region6);
 
 	if (dmub->hw_funcs.setup_outbox0)
 		dmub->hw_funcs.setup_outbox0(dmub, &outbox0);
-- 
2.43.0

