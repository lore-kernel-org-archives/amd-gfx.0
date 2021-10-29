Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BFBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE9161165
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BE9161165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642E76E12E;
	Fri, 29 Oct 2021 15:15:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC41B6E123
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:15:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIuJn5re68wzWHEa5Nm2Nw7JcbzmK2TmBBkW5vffszpadiH0GK4F3NMgw3rlFeYvnggsrXi7i+7ZzEuA7oJrfBXbJlN8qNXFlrweeEhaYNg+U/5u7BblSBMilv6VFFhB7ZtjAwRDnyRwv76SIiyDZCut71zw9OoNzMnUO1qC/dob5uin8g9JyKLzB4Aev6zAhiksP33wvj3DCdFXxWY3T6D7BAWuVC1vZ2IiXbj7wRnxoYL2yZYjr6dDZnaKMEyL1bY0IBYgM/GjnE8zEhyy1ueyeJ2zED9aYPIYJjYXmb9ZgbngQKXKSMbVljK+vC/YSBeJAMQmddLfEgAaCbPLmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H95h6OY/x9U6OHZV7qm27/5WeEFz/dTyYjot1u3f8mA=;
 b=g6tqc2LARqCWyTrRo8H9mgiJ4bJQJ3jQId6XWQkFRpGJeVbHJoThc1ulVIV71JZn2+Imk9er2/uxEoskuw3WozshrWZeZBgbRCOcxsKytxABk/0hcGLyI3PGHcJ91LlWk+CaqZYJRWLa2GMLSpfMZCn/0cLQSxqFyowbEXAu89+6RtH/a2hR+9Ub+U0gUAuQ7s64dhIPO6HfCjFZ+BCLgxzrhzPwxKj2f1xYjlD/WohtdSCqe0yWzNz0uQoBpAX1bRy9S3Geev9xzSUxLDHdXztFidJsC1/lkonkqZIx212GUoZhMpADnmqzaMYI8R7IiqAqZAjUheQ1qGiNdPm/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H95h6OY/x9U6OHZV7qm27/5WeEFz/dTyYjot1u3f8mA=;
 b=J+6obVaZJrWMwoV4I0hoKTrIrjmTTmN+U35wl7TuBpbf09O5j9H1tV6d9N2tdwQ1P4DjZTYfnl7eMXLzz0ZUafHh8wUVaiD4RUCY5AjAeZk0yoeafWSWoYDzy4QMDbEncnChZgsAsFvcTITbRYc4nyDbtIHlU0G1u9bmt0qhHl8=
Received: from BN9PR03CA0122.namprd03.prod.outlook.com (2603:10b6:408:fe::7)
 by CY4PR12MB1926.namprd12.prod.outlook.com (2603:10b6:903:11b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Fri, 29 Oct
 2021 15:15:08 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::7b) by BN9PR03CA0122.outlook.office365.com
 (2603:10b6:408:fe::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 15:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:15:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:04 -0500
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 10:14:58 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Hersen Wu <hersenwu@amd.com>, Mikita Lipski
 <Mikita.Lipski@amd.com>
Subject: [PATCH 01/14] drm/amd/display: dsc engine not disabled after unplug
 dsc mst hub
Date: Fri, 29 Oct 2021 11:14:43 -0400
Message-ID: <20211029151456.955294-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029151456.955294-1-aurabindo.pillai@amd.com>
References: <20211029151456.955294-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 634e43f2-9a06-4219-1d34-08d99aeee339
X-MS-TrafficTypeDiagnostic: CY4PR12MB1926:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1926209443D1568FEC754A638B879@CY4PR12MB1926.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwtEZX7B2g5KwbbM1oF1OaUjSj+NB/RjUdUsM4sFPHm+D4cz3Osx2wjM3pv4Ik3iu6f0Lo1Mz2fgSZuj4dzeNLZnjwoVaAA4qqhLjksTcdn+XCr/JkC14V+zy4q8IcHxTtcp1bq8q/NDgjAsnM30Ick2iCL+XQr+eFVCFYJZROQRoNELEJuq1Lp1qTcWTuVaC89ih7eLP9DgchqVd8GSRfCdtDvTWLvKUZz9lQt02PIaDk2uM2wk3eQDW1CYPkcE9+uOGukHRDuTsUKnvHdRBgUdeWuWAMDFcb8PaM/9JQ7VcNRc9lBGADfPlfgWSXIg3fOzVR9JiU7DzZnFUYrJu5hh1UrD7cAVowthFlJKH4ZLeCwtPs3kRMwJ45Wp3Dbe8tXo5H0bQgFVT2D+8VAjpmNw/9bXDBN8KI4JsjjOVATB9w61M94QM7zMBB583qU71P2LKKpNX+FcI1TZKLuw+te2FMvO43xy0X0e/a2dc6PrAHFpwhSC4Kj92bGVFOB+gwV8TTATKj3+wX9zjWUe0r6MejdhoUBKD3mmYupZyS9ITWQlRnkVBdUo7wz1cQIeXtrL6V8JD3pLquPIMCSdqCZLef+d0CptDV0FIdrj8xVk4HifX/ZrBQYrddxR12wZWFkRtguwe2E9jxZbMgiEAZBtdQVZfUR6S3H5+UEyDzDV9pT9oboaSCzAZBm3TK3RYle44AoVqGFnv73ISwQIf7sGDRY4+ipsb5xxlCvhbIn7ZwrmgeBeEfHxCD8LlxE/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(83380400001)(508600001)(356005)(30864003)(8676002)(5660300002)(4326008)(86362001)(36756003)(26005)(44832011)(8936002)(36860700001)(47076005)(54906003)(1076003)(6666004)(70206006)(70586007)(316002)(426003)(6916009)(186003)(2616005)(82310400003)(81166007)(336012)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:15:05.3601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 634e43f2-9a06-4219-1d34-08d99aeee339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1926
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

From: Hersen Wu <hersenwu@amd.com>

[WHY]
If timing and bpp of displays on mst hub are not changed,
pbn, slot_num for displays should not be changed. Linux
user mode may initiate atomic_check with different display
configuration after set mode finished. This will call to
amdgpu_dm to re-compute payload, slot_num of displays and
saved to dm_connect_state. stream->timing.flags.dsc, pbn,
slot_num are updated to values which may be different from
that were used for set mode. when dsc hub with 3 4k@60hz dp
connected, 3 dsc engines are enabled. timing.flags.dsc = 1.
timing.flags.dsc are changed to 0 due to atomic check. when
dsc hub is unplugged, amdgpu driver check timing.flags.dsc
for last mode set and find out flags.dsc = 0, then does not
disable dsc.

[HOW]
check status of  displays on dsc mst hubs. re-compute pbn,
slot_num, timing.flags.dsc only if there is mode, connect
or enable/disable change.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Hersen Wu <hersenwu@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  31 ++--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 150 ++++++++++++++----
 2 files changed, 138 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6dd6262f2769..b48f3cb5ddeb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7241,8 +7241,8 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 	struct drm_connector_state *new_con_state;
 	struct amdgpu_dm_connector *aconnector;
 	struct dm_connector_state *dm_conn_state;
-	int i, j, clock;
-	int vcpi, pbn_div, pbn = 0;
+	int i, j;
+	int vcpi, pbn_div, pbn, slot_num = 0;
 
 	for_each_new_connector_in_state(state, connector, new_con_state, i) {
 
@@ -7270,17 +7270,7 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 		if (!stream)
 			continue;
 
-		if (stream->timing.flags.DSC != 1) {
-			drm_dp_mst_atomic_enable_dsc(state,
-						     aconnector->port,
-						     dm_conn_state->pbn,
-						     0,
-						     false);
-			continue;
-		}
-
 		pbn_div = dm_mst_get_pbn_divider(stream->link);
-		clock = stream->timing.pix_clk_100hz / 10;
 		/* pbn is calculated by compute_mst_dsc_configs_for_state*/
 		for (j = 0; j < dc_state->stream_count; j++) {
 			if (vars[j].aconnector == aconnector) {
@@ -7289,6 +7279,23 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 			}
 		}
 
+		if (j == dc_state->stream_count)
+			continue;
+
+		slot_num = DIV_ROUND_UP(pbn, pbn_div);
+
+		if (stream->timing.flags.DSC != 1) {
+			dm_conn_state->pbn = pbn;
+			dm_conn_state->vcpi_slots = slot_num;
+
+			drm_dp_mst_atomic_enable_dsc(state,
+						     aconnector->port,
+						     dm_conn_state->pbn,
+						     0,
+						     false);
+			continue;
+		}
+
 		vcpi = drm_dp_mst_atomic_enable_dsc(state,
 						    aconnector->port,
 						    pbn, pbn_div,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 874a49b605c7..32a5ce09a62a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -534,13 +534,14 @@ static int kbps_to_peak_pbn(int kbps)
 
 static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *params,
 		struct dsc_mst_fairness_vars *vars,
-		int count)
+		int count,
+		int k)
 {
 	int i;
 
 	for (i = 0; i < count; i++) {
 		memset(&params[i].timing->dsc_cfg, 0, sizeof(params[i].timing->dsc_cfg));
-		if (vars[i].dsc_enabled && dc_dsc_compute_config(
+		if (vars[i + k].dsc_enabled && dc_dsc_compute_config(
 					params[i].sink->ctx->dc->res_pool->dscs[0],
 					&params[i].sink->dsc_caps.dsc_dec_caps,
 					params[i].sink->ctx->dc->debug.dsc_min_slice_height_override,
@@ -553,7 +554,7 @@ static void set_dsc_configs_from_fairness_vars(struct dsc_mst_fairness_params *p
 			if (params[i].bpp_overwrite)
 				params[i].timing->dsc_cfg.bits_per_pixel = params[i].bpp_overwrite;
 			else
-				params[i].timing->dsc_cfg.bits_per_pixel = vars[i].bpp_x16;
+				params[i].timing->dsc_cfg.bits_per_pixel = vars[i + k].bpp_x16;
 
 			if (params[i].num_slices_h)
 				params[i].timing->dsc_cfg.num_slices_h = params[i].num_slices_h;
@@ -586,7 +587,8 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
 			     struct dc_link *dc_link,
 			     struct dsc_mst_fairness_params *params,
 			     struct dsc_mst_fairness_vars *vars,
-			     int count)
+			     int count,
+			     int k)
 {
 	int i;
 	bool bpp_increased[MAX_PIPES];
@@ -601,8 +603,9 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
 	pbn_per_timeslot = dm_mst_get_pbn_divider(dc_link);
 
 	for (i = 0; i < count; i++) {
-		if (vars[i].dsc_enabled) {
-			initial_slack[i] = kbps_to_peak_pbn(params[i].bw_range.max_kbps) - vars[i].pbn;
+		if (vars[i + k].dsc_enabled) {
+			initial_slack[i] =
+			kbps_to_peak_pbn(params[i].bw_range.max_kbps) - vars[i + k].pbn;
 			bpp_increased[i] = false;
 			remaining_to_increase += 1;
 		} else {
@@ -629,7 +632,7 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
 		link_timeslots_used = 0;
 
 		for (i = 0; i < count; i++)
-			link_timeslots_used += DIV_ROUND_UP(vars[i].pbn, pbn_per_timeslot);
+			link_timeslots_used += DIV_ROUND_UP(vars[i + k].pbn, pbn_per_timeslot);
 
 		fair_pbn_alloc = (63 - link_timeslots_used) / remaining_to_increase * pbn_per_timeslot;
 
@@ -682,7 +685,8 @@ static void try_disable_dsc(struct drm_atomic_state *state,
 			    struct dc_link *dc_link,
 			    struct dsc_mst_fairness_params *params,
 			    struct dsc_mst_fairness_vars *vars,
-			    int count)
+			    int count,
+			    int k)
 {
 	int i;
 	bool tried[MAX_PIPES];
@@ -692,8 +696,8 @@ static void try_disable_dsc(struct drm_atomic_state *state,
 	int remaining_to_try = 0;
 
 	for (i = 0; i < count; i++) {
-		if (vars[i].dsc_enabled
-				&& vars[i].bpp_x16 == params[i].bw_range.max_target_bpp_x16
+		if (vars[i + k].dsc_enabled
+				&& vars[i + k].bpp_x16 == params[i].bw_range.max_target_bpp_x16
 				&& params[i].clock_force_enable == DSC_CLK_FORCE_DEFAULT) {
 			kbps_increase[i] = params[i].bw_range.stream_kbps - params[i].bw_range.max_kbps;
 			tried[i] = false;
@@ -748,9 +752,10 @@ static void try_disable_dsc(struct drm_atomic_state *state,
 static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 					     struct dc_state *dc_state,
 					     struct dc_link *dc_link,
-					     struct dsc_mst_fairness_vars *vars)
+					     struct dsc_mst_fairness_vars *vars,
+					     int *link_vars_start_index)
 {
-	int i;
+	int i, k;
 	struct dc_stream_state *stream;
 	struct dsc_mst_fairness_params params[MAX_PIPES];
 	struct amdgpu_dm_connector *aconnector;
@@ -768,11 +773,17 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		if (stream->link != dc_link)
 			continue;
 
+		aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
+		if (!aconnector)
+			continue;
+
+		if (!aconnector->port)
+			continue;
+
 		stream->timing.flags.DSC = 0;
 
 		params[count].timing = &stream->timing;
 		params[count].sink = stream->sink;
-		aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
 		params[count].aconnector = aconnector;
 		params[count].port = aconnector->port;
 		params[count].clock_force_enable = aconnector->dsc_settings.dsc_force_enable;
@@ -794,44 +805,55 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 
 		count++;
 	}
+
+	if (count == 0) {
+		ASSERT(0);
+		return true;
+	}
+
+	/* k is start index of vars for current phy link used by mst hub */
+	k = *link_vars_start_index;
+	/* set vars start index for next mst hub phy link */
+	*link_vars_start_index += count;
+
 	/* Try no compression */
 	for (i = 0; i < count; i++) {
-		vars[i].aconnector = params[i].aconnector;
-		vars[i].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps);
-		vars[i].dsc_enabled = false;
-		vars[i].bpp_x16 = 0;
+		vars[i + k].aconnector = params[i].aconnector;
+		vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps);
+		vars[i + k].dsc_enabled = false;
+		vars[i + k].bpp_x16 = 0;
 		if (drm_dp_atomic_find_vcpi_slots(state,
 						 params[i].port->mgr,
 						 params[i].port,
-						 vars[i].pbn,
+						 vars[i + k].pbn,
 						 dm_mst_get_pbn_divider(dc_link)) < 0)
 			return false;
 	}
 	if (!drm_dp_mst_atomic_check(state) && !debugfs_overwrite) {
-		set_dsc_configs_from_fairness_vars(params, vars, count);
+		set_dsc_configs_from_fairness_vars(params, vars, count, k);
 		return true;
 	}
 
 	/* Try max compression */
 	for (i = 0; i < count; i++) {
 		if (params[i].compression_possible && params[i].clock_force_enable != DSC_CLK_FORCE_DISABLE) {
-			vars[i].pbn = kbps_to_peak_pbn(params[i].bw_range.min_kbps);
-			vars[i].dsc_enabled = true;
-			vars[i].bpp_x16 = params[i].bw_range.min_target_bpp_x16;
+			vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.min_kbps);
+			vars[i + k].dsc_enabled = true;
+			vars[i + k].bpp_x16 = params[i].bw_range.min_target_bpp_x16;
 			if (drm_dp_atomic_find_vcpi_slots(state,
 							  params[i].port->mgr,
 							  params[i].port,
-							  vars[i].pbn,
+							  vars[i + k].pbn,
 							  dm_mst_get_pbn_divider(dc_link)) < 0)
 				return false;
 		} else {
-			vars[i].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps);
-			vars[i].dsc_enabled = false;
-			vars[i].bpp_x16 = 0;
+			vars[i + k].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps);
+			vars[i + k].dsc_enabled = false;
+			vars[i + k].bpp_x16 = 0;
 			if (drm_dp_atomic_find_vcpi_slots(state,
 							  params[i].port->mgr,
 							  params[i].port,
-							  vars[i].pbn,
+							  vars[i + k].pbn,
 							  dm_mst_get_pbn_divider(dc_link)) < 0)
 				return false;
 		}
@@ -840,15 +862,76 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 		return false;
 
 	/* Optimize degree of compression */
-	increase_dsc_bpp(state, dc_link, params, vars, count);
+	increase_dsc_bpp(state, dc_link, params, vars, count, k);
 
-	try_disable_dsc(state, dc_link, params, vars, count);
+	try_disable_dsc(state, dc_link, params, vars, count, k);
 
-	set_dsc_configs_from_fairness_vars(params, vars, count);
+	set_dsc_configs_from_fairness_vars(params, vars, count, k);
 
 	return true;
 }
 
+static bool is_dsc_need_re_compute(
+	struct drm_atomic_state *state,
+	struct dc_state *dc_state,
+	struct dc_link *dc_link)
+{
+	int i;
+	bool is_dsc_need_re_compute = false;
+
+	/* only check phy used by mst branch */
+	if (dc_link->type != dc_connection_mst_branch)
+		return false;
+
+	/* check if there is mode change in new request */
+	for (i = 0; i < dc_state->stream_count; i++) {
+		struct amdgpu_dm_connector *aconnector;
+		struct dc_stream_state *stream;
+		struct drm_crtc_state *new_crtc_state;
+		struct drm_connector_state *new_conn_state;
+
+		stream = dc_state->streams[i];
+
+		if (!stream)
+			continue;
+
+		/* check if stream using the same link for mst */
+		if (stream->link != dc_link)
+			continue;
+
+		aconnector = (struct amdgpu_dm_connector *) stream->dm_stream_context;
+		if (!aconnector)
+			continue;
+
+		new_conn_state = drm_atomic_get_new_connector_state(state, &aconnector->base);
+
+		if (!new_conn_state)
+			continue;
+
+		if (IS_ERR(new_conn_state))
+			continue;
+
+		if (!new_conn_state->crtc)
+			continue;
+
+		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
+
+		if (!new_crtc_state)
+			continue;
+
+		if (IS_ERR(new_crtc_state))
+			continue;
+
+		if (new_crtc_state->enable && new_crtc_state->active) {
+			if (new_crtc_state->mode_changed || new_crtc_state->active_changed ||
+				new_crtc_state->connectors_changed)
+				is_dsc_need_re_compute = true;
+		}
+	}
+
+	return is_dsc_need_re_compute;
+}
+
 bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 				       struct dc_state *dc_state,
 				       struct dsc_mst_fairness_vars *vars)
@@ -857,6 +940,7 @@ bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 	struct dc_stream_state *stream;
 	bool computed_streams[MAX_PIPES];
 	struct amdgpu_dm_connector *aconnector;
+	int link_vars_start_index = 0;
 
 	for (i = 0; i < dc_state->stream_count; i++)
 		computed_streams[i] = false;
@@ -881,8 +965,12 @@ bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
 		if (dcn20_remove_stream_from_ctx(stream->ctx->dc, dc_state, stream) != DC_OK)
 			return false;
 
+		if (!is_dsc_need_re_compute(state, dc_state, stream->link))
+			continue;
+
 		mutex_lock(&aconnector->mst_mgr.lock);
-		if (!compute_mst_dsc_configs_for_link(state, dc_state, stream->link, vars)) {
+		if (!compute_mst_dsc_configs_for_link(state, dc_state, stream->link,
+			vars, &link_vars_start_index)) {
 			mutex_unlock(&aconnector->mst_mgr.lock);
 			return false;
 		}
-- 
2.30.2

