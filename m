Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E6ECAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 18:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3292510E0B8;
	Wed, 24 Sep 2025 18:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kBH0h6GR";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6899610E0B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 18:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noy0mZr8mCcXIfps7LBhBbWvDxWwyBYveaK9ITkDGWkY1o/C/gRy/VoFmE8oHhE/uwzKC3mLMiboA3bUynFCiHJ/fUyLyAXDCI/voVMvuZorBekP6VOOtA7QGJgeowgWJwJjzDhqIJ3zg1o8opfmjbS7TwaTBggqQU+jI6ocN50bI9u+BYc4bU56FyK2aqm5ZOiGdQDvOZ1i4k5yBo1XAZd2d6k0XuMz3nbk4lShGDVPdJzHJdi7rvNVfWNsrdiJRroqxzQo+d6hFONVmHv2vPBzTvmzIOaOXKaIhuJmRoSDWNtN38QrDPkRoqXFI3OGsQ1xHX2y8JZJSas0XBgzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbhAROYTNNZU9duWSWBpYzKowc1KxKcv14iGYmgPKaY=;
 b=PzDoRRi1F0DY7m9E9+9C3rmVwy5ZwcgFBbHydnybEfLe7Dx5nzqWnvQrIPcMSF4HFAYMiKdcIIIu/z4rMAdbk89nrZOy8zMzVhQ+l8rL/YZ6w/pNYIul+OuNLlCUwmY4ANDjmnAhq+CAuTGb/I6Bt2Qs0cxf8pjqIlEp6dYs42VNeiILw9WV+uWD8puNWtYtxN+D5tyjMlFVdvm1vykSw+p6pnfR6tiFqZMOmMihijB4FoD7AiLvcxvMTMSos89ibW10rhgrpeyn2AmKFQ1crLCeLSPzPiRLPNqXjC0S87CzXreYPxOaO+xAU3D//wvkc7uG7vv+1PqALnglOIp0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbhAROYTNNZU9duWSWBpYzKowc1KxKcv14iGYmgPKaY=;
 b=kBH0h6GR+TuEDxaqzaRDdWsEy63GyaaF1f2HjHo4I+XTZnCIN6s7IQB6gvSoWUBBs5ieuNToMRBp30Gxn29EzYiZR6tiDFY5PajAY+D9hh7ZII4i6bHGGCJySo7q/a6nILt+uKlz9X/FwA7q+r9m3R+eLwPbptnlv0El7t4aQdk=
Received: from CH0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:610:b1::23)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 18:22:23 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::e8) by CH0PR13CA0018.outlook.office365.com
 (2603:10b6:610:b1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 18:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 18:22:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 24 Sep
 2025 11:22:22 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Sep
 2025 13:22:22 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 11:22:22 -0700
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Alvin
 Lee <alvin.lee2@amd.com>
Subject: [PATCH 04/10] drm/amd/display: Support possibly NULL link for
 should_use_dmub_lock
Date: Wed, 24 Sep 2025 14:21:55 -0400
Message-ID: <20250924182201.1049389-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924182201.1049389-1-Roman.Li@amd.com>
References: <20250924182201.1049389-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: d158c4e2-1505-4780-05da-08ddfb974e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PJgVT7v7IDbI9iGmmXB6LcML2seLABFIAd0LCjIN+HUkqI3CfJrI9IRn68ae?=
 =?us-ascii?Q?e+md4XTVl9ktbJvLGHicklOfhJzJRtDfwoDoK1tPpYnikHPX1acNHdlvKUC7?=
 =?us-ascii?Q?kieaN8Rm2AolzOACVVrs7kW8aomt6mldPl9ax9uX7oOlagJ2s2s+1hsSMVpS?=
 =?us-ascii?Q?3KI7zpPQ8FQhvNMrVYip4JY7BfceVJIc/xq8HojRIAXBDYf9AXkNfpYZ1Ahh?=
 =?us-ascii?Q?wQU4u2hokL36Y8IrbQwlsuEBS2pjRitTbAtT/r1utkRPJq4C4d/woZEjy53m?=
 =?us-ascii?Q?wq7COs3D3/P4bTDGhW4AjQNSJ0TDLZRf94NOGc+iOgZ7N+pdLn9DFFnGMsny?=
 =?us-ascii?Q?pdqt8GWnY8KoQTIiO2NI28eqH+sepHRjKoRPOtKQ9YN5JFcwhHQRi1BQ2WFF?=
 =?us-ascii?Q?QXHpET0vKi9twyyO5NLYMYzwBtxH2MVkC/a2hHGof7rmGvHiuHAN1/X+AHoT?=
 =?us-ascii?Q?QLJfgJdqH5C+DM2nbbr4cCgGpJaB2THPGBSh7aG9FwVgVkID8JQYKJk36uXY?=
 =?us-ascii?Q?lnKhmGhhfcDXviQJNoiSRI7TMLyaAm7FZMdtHEDr2TH0QkGomqsF5RK1Rpqe?=
 =?us-ascii?Q?uCxlzhvmY10CqRjkFLP3DSx3zIphKCKOYLei8N7dNTGVOjNFaSXJE/msOyWJ?=
 =?us-ascii?Q?Xn5hGSejnL3WL2c1EfQm5MT9nxHCwzXsiiMw4ltcNa+bi6lBf0egAj5AeVdA?=
 =?us-ascii?Q?59JMYi74dnVK+mJXr1FdKc2PSyLFMBJzftN1aFKZwUOsSbZfH69SduqkkMxl?=
 =?us-ascii?Q?HDuWsM/+o/zOsGY2RBNxHOb7Y/rfPY+FWaecGB014riBMeP/S2QoksvHwLpv?=
 =?us-ascii?Q?iiNAXLaIxBUBSZskcydGmuVPXbJb4CUS4uAqxf6brNq2iIX8MLgon1LUJkG+?=
 =?us-ascii?Q?/WLNkGJo+6Z9YkctIJWhSGaoBchU8NyNdo1rpz0+3eDyPVqJe1RVG/98XCIj?=
 =?us-ascii?Q?BTkNk7SXk+88alchq+k2umkeDD5/ea6PVQYLfGYWHi7D0wLPEU7dL2Oy0fFL?=
 =?us-ascii?Q?JTJa5I9rxE+8Je5FBOrBNQFXimKiufw1DWFzzEMRwtK0hDMKp5k8GYLcAB9J?=
 =?us-ascii?Q?pu+nad8aDQT48xrU+oHyyarI6sCgp3Q/z3lorwwwA6pE/TDCYrJhnso4U72R?=
 =?us-ascii?Q?o1/9++tXVMX7M79KqnwXjcFAR6cL6q88tnno7Qt8xlRlUSltvVQFVphUQA90?=
 =?us-ascii?Q?PRRzzoFmMPhSgcKBSsC8pokKFM3Jq96QK1amb3S4NophpYvnja7/KKLis6RY?=
 =?us-ascii?Q?QbkCwdLm0uQB1L+4Q6QGH0MYa0SpovJwV9wUz20uW6xzhSAPK9IfMWsPgajm?=
 =?us-ascii?Q?uDdBtUpXw0fHom53UvUcftTLnVfdUYUOOTW9qJjlQP5C6VDhaVpAGWO1DRun?=
 =?us-ascii?Q?bJ4kZ69YATLL/X/Nl+EQN0yklSTIZdDHAeWB6wuKfUPFNHF+SWnPArLk3vQi?=
 =?us-ascii?Q?mV+mXPIBdvOKQoAQdx27D2kil8vaK5y7BTlWWNnBo6TcMFVXOzwQHURfm8b2?=
 =?us-ascii?Q?b1Frn8naakt93WqG23usnad/NTGKUnsqFpZn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:22:23.2169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d158c4e2-1505-4780-05da-08ddfb974e89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115
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
It's possible to have a stream enabled without a link or link encoder.

There are cases where we'd still like to interlock the driver
programming from firmware programming to ensure that we don't put the
hardware in an undefined (or error) state if two programming sequences
are simultaneously executed on the same hardware blocks.

[How]
Add an explicit DC parameter to should_use_dmub_lock().

Make pointers to should_use_dmub_lock() const since it's a checker
function that shouldn't modify state.

Update the callsites to pass in DC explicitly.

Check that the link is non-NULL before deferencing and performing link
based checks.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +--
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 29 ++++++++++---------
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.h |  2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  2 +-
 .../display/dc/link/accessories/link_dp_cts.c |  4 +--
 6 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5f2d5638c819..3f5ec076da1c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4149,7 +4149,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program &&
 			top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
-			if (should_use_dmub_lock(stream->link)) {
+			if (should_use_dmub_lock(dc, stream->link)) {
 				union dmub_hw_lock_flags hw_locks = { 0 };
 				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
@@ -4419,7 +4419,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				top_pipe_to_program->stream_res.tg,
 				CRTC_STATE_VACTIVE);
 
-			if (should_use_dmub_lock(stream->link)) {
+			if (should_use_dmub_lock(dc, stream->link)) {
 				union dmub_hw_lock_flags hw_locks = { 0 };
 				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index d37ecfdde4f1..17c30c5b1679 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -61,27 +61,30 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 	dc_dmub_srv_wait_for_inbox0_ack(dmub_srv);
 }
 
-bool should_use_dmub_lock(struct dc_link *link)
+bool should_use_dmub_lock(const struct dc *dc, const struct dc_link *link)
 {
 	/* ASIC doesn't support DMUB */
-	if (!link->ctx->dmub_srv)
+	if (!dc->ctx->dmub_srv)
 		return false;
 
-	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
-		return true;
+	if (link) {
 
-	if (link->replay_settings.replay_feature_enabled)
-		return true;
+		if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
+			return true;
+
+		if (link->replay_settings.replay_feature_enabled)
+			return true;
 
-	/* only use HW lock for PSR1 on single eDP */
-	if (link->psr_settings.psr_version == DC_PSR_VERSION_1) {
-		struct dc_link *edp_links[MAX_NUM_EDP];
-		int edp_num;
+			/* only use HW lock for PSR1 on single eDP */
+		if (link->psr_settings.psr_version == DC_PSR_VERSION_1) {
+			struct dc_link *edp_links[MAX_NUM_EDP];
+			int edp_num;
 
-		dc_get_edp_links(link->dc, edp_links, &edp_num);
+			dc_get_edp_links(dc, edp_links, &edp_num);
 
-		if (edp_num == 1)
-			return true;
+			if (edp_num == 1)
+				return true;
+		}
 	}
 
 	return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
index 5a72b168fb4a..6e8863877686 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h
@@ -37,6 +37,6 @@ void dmub_hw_lock_mgr_cmd(struct dc_dmub_srv *dmub_srv,
 void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 		union dmub_inbox0_cmd_lock_hw hw_lock_cmd);
 
-bool should_use_dmub_lock(struct dc_link *link);
+bool should_use_dmub_lock(const struct dc *dc, const struct dc_link *link);
 
 #endif /*_DMUB_HW_LOCK_MGR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index e9fe97f0c4ea..cb915abac15a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2245,7 +2245,7 @@ void dcn10_cursor_lock(struct dc *dc, struct pipe_ctx *pipe, bool lock)
 	if (lock)
 		delay_cursor_until_vupdate(dc, pipe);
 
-	if (pipe->stream && should_use_dmub_lock(pipe->stream->link)) {
+	if (pipe->stream && should_use_dmub_lock(dc, pipe->stream->link)) {
 		union dmub_hw_lock_flags hw_locks = { 0 };
 		struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 717d2c4daa88..57343b08a3f0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1449,7 +1449,7 @@ void dcn20_pipe_control_lock(
 		!flip_immediate)
 	    dcn20_setup_gsl_group_as_lock(dc, pipe, false);
 
-	if (pipe->stream && should_use_dmub_lock(pipe->stream->link)) {
+	if (pipe->stream && should_use_dmub_lock(dc, pipe->stream->link)) {
 		union dmub_hw_lock_flags hw_locks = { 0 };
 		struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 9e33bf937a69..3c8eb1510226 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -876,7 +876,7 @@ bool dp_set_test_pattern(
 			return false;
 
 		if (pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_enable) {
-			if (should_use_dmub_lock(pipe_ctx->stream->link)) {
+			if (should_use_dmub_lock(pipe_ctx->stream->link->dc, pipe_ctx->stream->link)) {
 				union dmub_hw_lock_flags hw_locks = { 0 };
 				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
@@ -924,7 +924,7 @@ bool dp_set_test_pattern(
 				CRTC_STATE_VACTIVE);
 
 		if (pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_disable) {
-			if (should_use_dmub_lock(pipe_ctx->stream->link)) {
+			if (should_use_dmub_lock(pipe_ctx->stream->link->dc, pipe_ctx->stream->link)) {
 				union dmub_hw_lock_flags hw_locks = { 0 };
 				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
-- 
2.34.1

