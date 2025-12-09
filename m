Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7E9D3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DB3B10E4DE;
	Tue,  9 Dec 2025 08:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IynbnPfQ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3EB10E4DE
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHRNM8+sT92pu1meOFl6gAjJGnYN42l6XbOuCh+vJAoM+hrqWc0K5ZckKHwzivgb8nLg+NbOX6rskJz9m2V4UiC3kStqxdS594md2k4fG7eZfFmbXYqPjYS1Ss+0oo+NcZ8+4XaU3IW3h5vdxvk6F2lGa+aDzARJKAnDDcF7CeWhCUBhBNjkQIOAI3KpTwMVqQyznQKLcPQEWYhrsbGtHLqsvIjVAj0SxrM7sXeCkpoIPK1gd8YisHn5aaX0uCjDsWwkS9EP5vzrEBasdtWG/7CGc5VAPhVW+9LW4AK+NJdbhxc9eHiDqF0GGIKpwAFtBAiPtdsLUssT1ECM8N1LqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdVoFD5+jj5JGTQsk6qxjFo16jq/o99sgKpTdcAvHgA=;
 b=Fz0t+KeKAe8hWxcCqO7iG8P+ahA2NvsvE2qzwusnwOL6R6i0TlsClgUl8sUorCIpLsl5gEfxk4EvjxZVF4BGgb53a1Fw7G3PKhjZnEePIXZtwef3WM3nlGfBSCrYTr8Ou6GVL+Q8h4I2jptFYY23yFKrKZWa+9n20C10L5iUdZOpehp906rROo7YOZOhTZadAHV1INJ5i1uHna/ByE2Bzl2uYli+ci0GFw/0622O8IIlCRZ2EfSuXaSRJQaWKmbbhXI0uS6GPJ+iLZ0OdMWtknt6iC10zaQyRVpItnKUooSucsJ/bf9IuKn2Pmrupgef1Eu6vsYQNfppGfGbCybCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdVoFD5+jj5JGTQsk6qxjFo16jq/o99sgKpTdcAvHgA=;
 b=IynbnPfQtwwK1cD4Tl3COCvMqEum4PyNCgfe1EhdH4kSZG51i0kjI1+pIk41HSvsoPGcrnkR/YmgUiC5NMTPKWYo0tgV52gVkA68asRQiVKK4mT5YPKmWsjcN1YMn2Z1BT+ex7mrXqGFhDPeOcP7CKPlHUSjHGHJubXTpQcEXrI=
Received: from SJ0PR13CA0037.namprd13.prod.outlook.com (2603:10b6:a03:2c2::12)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Tue, 9 Dec
 2025 08:58:33 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::f4) by SJ0PR13CA0037.outlook.office365.com
 (2603:10b6:a03:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4 via Frontend Transport; Tue, 9
 Dec 2025 08:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:58:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Dec
 2025 02:58:31 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Dec
 2025 02:58:31 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:58:27 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 13/15] drm/amd/display: Split update_planes_and_stream_v3 into
 parts (V2)
Date: Tue, 9 Dec 2025 16:55:16 +0800
Message-ID: <20251209085702.293682-14-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fad5159-56f7-4c66-98ea-08de37012157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SD2bwgcHJIfGUzdqG0/5/lwJ7XgJNAEtXZxqR2prOXOqKOVVT6ZveG6JI19N?=
 =?us-ascii?Q?5HIPZxRkTJ+5xdaQBW16/AbP6UsFV7cbQb+idSX8ciMdC7djRs3El4LbTQv9?=
 =?us-ascii?Q?1iXVfCHwVcNusuGQ1MWAJ7Ntycdu6CiLpwD5fu2Pvrght61QLhuMjW+0H2eB?=
 =?us-ascii?Q?6b3QMPpRp15W7qvTr6m/5mWis3Kf/i/YvGKRNvfoC52ozLsMgc1taTg2YzE9?=
 =?us-ascii?Q?FltKY9ufXZ35+uebgtmSdWFmLP6d9WbLqH/4QVz2SzIejT6c4KyVceStyIYw?=
 =?us-ascii?Q?GLK8XOgS2yc5lx73oBoMReRiY7o3GhL6qjRwmOgLdv3vrAO193VfpMLa01Pl?=
 =?us-ascii?Q?HJgm0Fvu7paCJESiG2z6rg95bCcwze8IHFz2nVp5acoQs6SM616Nx3JfzgYr?=
 =?us-ascii?Q?0YIoLQJWpeQSthyIxiO7zCJKajdp/Lz1B17rd46JVl85aaY0RDeixpBNKPlb?=
 =?us-ascii?Q?8RcfmKe8QktHSlH13UuMK1J5yh8/sZJjmF1R2BtQDmq8en7m5+mJ5veJ/GNq?=
 =?us-ascii?Q?yERdoklv3hlQg8Lh+Wxu3clKVSMqo7rDkwAONeyS8jCNSnzKnnj47YFgTodl?=
 =?us-ascii?Q?XByt/lh1v6g37lDEiSt2Ar8mEdPIGj2fem2it1ZkVQ3NIDkZf50uOjNSv8VQ?=
 =?us-ascii?Q?RiEnbIfWouwcGBjlcGRnUzNcx7zDH9saF+FoO1NwXQOM5xUpA0hoThquV8o+?=
 =?us-ascii?Q?8oi+fbTKAdMFVuXdAE7++onxS2vlEh59XhEjMXQ7OcN2NrnG5CM9wbZbTvrJ?=
 =?us-ascii?Q?Wea1E+JARN79uKYSDoVYmkW5BTYpeoN1wnUFgIVKbtVeiX5dIK7dPG8HDPK/?=
 =?us-ascii?Q?0PZl+BGKDIf2od/69J2/Jg7ONYyzT2RIMteYIilXhVFxM+QzSYnNXwhLdo6C?=
 =?us-ascii?Q?G9BukfRlCbHocn/R4QkqXmOpXihGAiSBBi54DEGBj4tqOBxIJ/AJxc6SV/ge?=
 =?us-ascii?Q?EW5mCad/rdoh0H3FH6OV8m51vIaxU0UCM8RN+wB0tMn9d+qr0AKnRxiJIacQ?=
 =?us-ascii?Q?hzoCDu4Lc8EYpFSyqlzOfrzNhOH0yxbExNO6+pVb2RCog70637O1vjvVFy5K?=
 =?us-ascii?Q?sO2qaDmbACyiskjKkp6MVTChXvlDHEwr7HzgNbGf+zqzwxbB6TdFbvJIPf5Q?=
 =?us-ascii?Q?EjeLfmUWS+ck0+gF4XT7gWnfQxlSoYWBD6I24s4OHr/sTxgXGxX7mN5Zo1Al?=
 =?us-ascii?Q?OEhfsqMrMrBhM1QG5t0PUFE5/j06pxYtK0SsPiIv8TOrU6SVq+1U5Yk0d5kO?=
 =?us-ascii?Q?1q71UcyF7KKqJsf1jZ7LeYL7SR/njv8QZRfLz7wbW2QqxSe9pAZroSNDB0nD?=
 =?us-ascii?Q?TDj+bEiFfLukC3qyAfCAUpFgS11eEHw5PdLpQ9cCERHWGBNNd9UxardVb7y2?=
 =?us-ascii?Q?NCyt+kimDPexSa9Mq/szTvL/7e5U0dDArZrs/GPC9v6wAFiSBNaSOLzFsNtl?=
 =?us-ascii?Q?Cw+iWSLbA0RIblouz/C9hvG2JXgtMdLy0lDb616xtiYxH7jnJXdPZqZrb8bu?=
 =?us-ascii?Q?msOpCSzbNCGl6WCMakjE/+V5FB4MV9tL2NkI9uZnYSvnvZzCTq13YgXEPHKS?=
 =?us-ascii?Q?Rf+iVw1CbRSMo8dshLQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:58:32.5734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fad5159-56f7-4c66-98ea-08de37012157
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why]
Currently all of the preparation and execution of plane update is done
under a DC lock, blocking other code from accessing DC for longer than
strictly necessary.

[How]
Break the v3 update flow into 3 parts:
    * prepare - locked, calculate update flow and modify DC state
    * execute - unlocked, program hardware
    * cleanup - locked, finalize DC state and free temp resources
Legacy v2 flow too compilicated to break down for now, link new API
with old by executing everything in slightly misnamed prepare stage.

V2:
Keep the new code structure, but point all users back at the old code,
until fully tested.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 351 +++++++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  31 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  31 +-
 3 files changed, 403 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e0db791953a5..1be5c1c15798 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3849,7 +3849,7 @@ static bool dc_dmub_should_send_dirty_rect_cmd(struct dc *dc, struct dc_stream_s
 void dc_dmub_update_dirty_rect(struct dc *dc,
 			       int surface_count,
 			       struct dc_stream_state *stream,
-			       struct dc_surface_update *srf_updates,
+			       const struct dc_surface_update *srf_updates,
 			       struct dc_state *context)
 {
 	union dmub_rb_cmd cmd;
@@ -4154,7 +4154,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 }
 
 static void commit_planes_for_stream(struct dc *dc,
-		struct dc_surface_update *srf_updates,
+		const struct dc_surface_update *srf_updates,
 		int surface_count,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update,
@@ -7175,3 +7175,350 @@ bool dc_get_qos_info(struct dc *dc, struct dc_qos_info *info)
 
 	return true;
 }
+
+enum update_v3_flow {
+	UPDATE_V3_FLOW_INVALID,
+	UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST,
+	UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FULL,
+	UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS,
+	UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW,
+	UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_CURRENT,
+};
+
+struct dc_update_scratch_space {
+	struct dc *dc;
+	struct dc_surface_update *surface_updates;
+	int surface_count;
+	struct dc_stream_state *stream;
+	struct dc_stream_update *stream_update;
+	bool update_v3;
+	bool do_clear_update_flags;
+	enum surface_update_type update_type;
+	struct dc_state *new_context;
+	enum update_v3_flow flow;
+	struct dc_state *backup_context;
+	struct dc_state *intermediate_context;
+	struct pipe_split_policy_backup intermediate_policy;
+	struct dc_surface_update intermediate_updates[MAX_SURFACES];
+	int intermediate_count;
+};
+
+size_t dc_update_scratch_space_size(void)
+{
+	return sizeof(struct dc_update_scratch_space);
+}
+
+static bool update_planes_and_stream_prepare_v2(
+		struct dc_update_scratch_space *scratch
+)
+{
+	// v2 is too tangled to break into stages, so just execute everything under lock
+	dc_exit_ips_for_hw_access(scratch->dc);
+	return update_planes_and_stream_v2(
+		scratch->dc,
+		scratch->surface_updates,
+		scratch->surface_count,
+		scratch->stream,
+		scratch->stream_update
+	);
+}
+
+static void update_planes_and_stream_execute_v2(
+		const struct dc_update_scratch_space *scratch
+)
+{
+	// Nothing to do, see `update_planes_and_stream_prepare_v2`
+	(void) scratch;
+}
+
+static bool update_planes_and_stream_cleanup_v2(
+		const struct dc_update_scratch_space *scratch
+)
+{
+	if (scratch->do_clear_update_flags)
+		clear_update_flags(scratch->surface_updates, scratch->surface_count, scratch->stream);
+
+	return false;
+}
+
+static void update_planes_and_stream_cleanup_v3_intermediate(
+		struct dc_update_scratch_space *scratch,
+		bool backup
+);
+
+static bool update_planes_and_stream_prepare_v3_intermediate_seamless(
+		struct dc_update_scratch_space *scratch
+)
+{
+	return is_pipe_topology_transition_seamless_with_intermediate_step(
+			scratch->dc,
+			scratch->dc->current_state,
+			scratch->intermediate_context,
+			scratch->new_context
+	);
+}
+
+static bool update_planes_and_stream_prepare_v3(
+		struct dc_update_scratch_space *scratch
+)
+{
+	dc_exit_ips_for_hw_access(scratch->dc);
+
+	if (!update_planes_and_stream_state(
+			scratch->dc,
+			scratch->surface_updates,
+			scratch->surface_count,
+			scratch->stream,
+			scratch->stream_update,
+			&scratch->update_type,
+			&scratch->new_context
+	)) {
+		return false;
+	}
+
+	if (scratch->new_context == scratch->dc->current_state) {
+		ASSERT(scratch->update_type < UPDATE_TYPE_FULL);
+
+		// TODO: Do we need this to be alive in execute?
+		struct dc_fast_update fast_update[MAX_SURFACES] = { 0 };
+
+		populate_fast_updates(
+				fast_update,
+				scratch->surface_updates,
+				scratch->surface_count,
+				scratch->stream_update
+		);
+		const bool fast = fast_update_only(
+				scratch->dc,
+				fast_update,
+				scratch->surface_updates,
+				scratch->surface_count,
+				scratch->stream_update,
+				scratch->stream
+		)
+		// TODO: Can this be used to skip `populate_fast_updates`?
+				&& !scratch->dc->check_config.enable_legacy_fast_update;
+		scratch->flow = fast
+				? UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST
+				: UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FULL;
+		return true;
+	}
+
+	ASSERT(scratch->update_type >= UPDATE_TYPE_FULL);
+
+	const bool seamless = scratch->dc->hwss.is_pipe_topology_transition_seamless(
+			scratch->dc,
+			scratch->dc->current_state,
+			scratch->new_context
+	);
+	if (seamless) {
+		scratch->flow = UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS;
+		return true;
+	}
+
+	scratch->intermediate_context = create_minimal_transition_state(
+		scratch->dc,
+		scratch->new_context,
+		&scratch->intermediate_policy
+	);
+	if (scratch->intermediate_context) {
+		if (update_planes_and_stream_prepare_v3_intermediate_seamless(scratch)) {
+			scratch->flow = UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW;
+			return true;
+		}
+
+		update_planes_and_stream_cleanup_v3_intermediate(scratch, false);
+	}
+
+	restore_planes_and_stream_state(&scratch->dc->scratch.current_state, scratch->stream);
+	scratch->backup_context = scratch->dc->current_state;
+	dc_state_retain(scratch->backup_context);
+	scratch->intermediate_context = create_minimal_transition_state(
+			scratch->dc,
+			scratch->backup_context,
+			&scratch->intermediate_policy
+	);
+	if (scratch->intermediate_context) {
+		if (update_planes_and_stream_prepare_v3_intermediate_seamless(scratch)) {
+			scratch->flow = UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_CURRENT;
+			scratch->intermediate_count = initialize_empty_surface_updates(
+					scratch->stream, scratch->intermediate_updates
+			);
+			return true;
+		}
+
+		update_planes_and_stream_cleanup_v3_intermediate(scratch, true);
+	}
+
+	scratch->flow = UPDATE_V3_FLOW_INVALID;
+	dc_state_release(scratch->backup_context);
+	restore_planes_and_stream_state(&scratch->dc->scratch.new_state, scratch->stream);
+	return false;
+}
+
+static void update_planes_and_stream_execute_v3_commit(
+		const struct dc_update_scratch_space *scratch,
+		bool intermediate_update,
+		bool intermediate_context
+)
+{
+	commit_planes_for_stream(
+			scratch->dc,
+			intermediate_update ? scratch->intermediate_updates : scratch->surface_updates,
+			intermediate_update ? scratch->intermediate_count : scratch->surface_count,
+			scratch->stream,
+			intermediate_context ? NULL : scratch->stream_update,
+			intermediate_context ? UPDATE_TYPE_FULL : scratch->update_type,
+			// `dc->current_state` only used in `NO_NEW_CONTEXT`, where it is equal to `new_context`
+			intermediate_context ? scratch->intermediate_context : scratch->new_context
+	);
+}
+
+static void update_planes_and_stream_execute_v3(
+		const struct dc_update_scratch_space *scratch
+)
+{
+	switch (scratch->flow) {
+	case UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST:
+		commit_planes_for_stream_fast(
+				scratch->dc,
+				scratch->surface_updates,
+				scratch->surface_count,
+				scratch->stream,
+				scratch->stream_update,
+				scratch->update_type,
+				scratch->new_context
+		);
+		break;
+
+	case UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FULL:
+	case UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS:
+		update_planes_and_stream_execute_v3_commit(scratch, false, false);
+		break;
+
+	case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW:
+		update_planes_and_stream_execute_v3_commit(scratch, false, true);
+		update_planes_and_stream_execute_v3_commit(scratch, false, false);
+		break;
+
+	case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_CURRENT:
+		update_planes_and_stream_execute_v3_commit(scratch, true, true);
+		update_planes_and_stream_execute_v3_commit(scratch, false, false);
+		break;
+
+	case UPDATE_V3_FLOW_INVALID:
+	default:
+		ASSERT(false);
+	}
+}
+
+static void update_planes_and_stream_cleanup_v3_new_context(
+		struct dc_update_scratch_space *scratch
+)
+{
+	swap_and_release_current_context(scratch->dc, scratch->new_context, scratch->stream);
+}
+
+static void update_planes_and_stream_cleanup_v3_intermediate(
+		struct dc_update_scratch_space *scratch,
+		bool backup
+)
+{
+	release_minimal_transition_state(
+			scratch->dc,
+			scratch->intermediate_context,
+			backup ? scratch->backup_context : scratch->new_context,
+			&scratch->intermediate_policy
+	);
+}
+
+static bool update_planes_and_stream_cleanup_v3(
+		struct dc_update_scratch_space *scratch
+)
+{
+	switch (scratch->flow) {
+	case UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST:
+	case UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FULL:
+		// No cleanup required
+		break;
+
+	case UPDATE_V3_FLOW_NEW_CONTEXT_SEAMLESS:
+		update_planes_and_stream_cleanup_v3_new_context(scratch);
+		break;
+
+	case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_NEW:
+		update_planes_and_stream_cleanup_v3_intermediate(scratch, false);
+		update_planes_and_stream_cleanup_v3_new_context(scratch);
+		break;
+
+	case UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL_CURRENT:
+		swap_and_release_current_context(scratch->dc, scratch->intermediate_context, scratch->stream);
+		dc_state_retain(scratch->dc->current_state);
+		update_planes_and_stream_cleanup_v3_intermediate(scratch, true);
+		dc_state_release(scratch->backup_context);
+		restore_planes_and_stream_state(&scratch->dc->scratch.new_state, scratch->stream);
+		update_planes_and_stream_cleanup_v3_new_context(scratch);
+		break;
+
+	case UPDATE_V3_FLOW_INVALID:
+	default:
+		ASSERT(false);
+	}
+
+	if (scratch->do_clear_update_flags)
+		clear_update_flags(scratch->surface_updates, scratch->surface_count, scratch->stream);
+
+	return false;
+}
+
+struct dc_update_scratch_space *dc_update_planes_and_stream_init(
+		struct dc *dc,
+		struct dc_surface_update *surface_updates,
+		int surface_count,
+		struct dc_stream_state *stream,
+		struct dc_stream_update *stream_update
+)
+{
+	const enum dce_version version = dc->ctx->dce_version;
+	struct dc_update_scratch_space *scratch = stream->update_scratch;
+
+	*scratch = (struct dc_update_scratch_space){
+		.dc = dc,
+		.surface_updates = surface_updates,
+		.surface_count = surface_count,
+		.stream = stream,
+		.stream_update = stream_update,
+		.update_v3 = version >= DCN_VERSION_4_01 || version == DCN_VERSION_3_2 || version == DCN_VERSION_3_21,
+		.do_clear_update_flags = version >= DCN_VERSION_3_2 || version == DCN_VERSION_3_01,
+	};
+
+	return scratch;
+}
+
+bool dc_update_planes_and_stream_prepare(
+		struct dc_update_scratch_space *scratch
+)
+{
+	return scratch->update_v3
+			? update_planes_and_stream_prepare_v3(scratch)
+			: update_planes_and_stream_prepare_v2(scratch);
+}
+
+void dc_update_planes_and_stream_execute(
+		const struct dc_update_scratch_space *scratch
+)
+{
+	scratch->update_v3
+			? update_planes_and_stream_execute_v3(scratch)
+			: update_planes_and_stream_execute_v2(scratch);
+}
+
+bool dc_update_planes_and_stream_cleanup(
+		struct dc_update_scratch_space *scratch
+)
+{
+	return scratch->update_v3
+			? update_planes_and_stream_cleanup_v3(scratch)
+			: update_planes_and_stream_cleanup_v2(scratch);
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 129cd5f84983..9349cccc8438 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -151,6 +151,7 @@ static void dc_stream_free(struct kref *kref)
 	struct dc_stream_state *stream = container_of(kref, struct dc_stream_state, refcount);
 
 	dc_stream_destruct(stream);
+	kfree(stream->update_scratch);
 	kfree(stream);
 }
 
@@ -164,26 +165,32 @@ void dc_stream_release(struct dc_stream_state *stream)
 struct dc_stream_state *dc_create_stream_for_sink(
 		struct dc_sink *sink)
 {
-	struct dc_stream_state *stream;
+	struct dc_stream_state *stream = NULL;
 
 	if (sink == NULL)
-		return NULL;
+		goto fail;
 
 	stream = kzalloc(sizeof(struct dc_stream_state), GFP_KERNEL);
 	if (stream == NULL)
-		goto alloc_fail;
+		goto fail;
+
+	stream->update_scratch = kzalloc((int32_t) dc_update_scratch_space_size(), GFP_KERNEL);
+	if (stream->update_scratch == NULL)
+		goto fail;
 
 	if (dc_stream_construct(stream, sink) == false)
-		goto construct_fail;
+		goto fail;
 
 	kref_init(&stream->refcount);
 
 	return stream;
 
-construct_fail:
-	kfree(stream);
+fail:
+	if (stream) {
+		kfree(stream->update_scratch);
+		kfree(stream);
+	}
 
-alloc_fail:
 	return NULL;
 }
 
@@ -195,6 +202,16 @@ struct dc_stream_state *dc_copy_stream(const struct dc_stream_state *stream)
 	if (!new_stream)
 		return NULL;
 
+	// Scratch is not meant to be reused across copies, as might have self-referential pointers
+	new_stream->update_scratch = kzalloc(
+			(int32_t) dc_update_scratch_space_size(),
+			GFP_KERNEL
+	);
+	if (!new_stream->update_scratch) {
+		kfree(new_stream);
+		return NULL;
+	}
+
 	if (new_stream->sink)
 		dc_sink_retain(new_stream->sink);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 321cfe92d799..719b98d8e8ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -315,6 +315,8 @@ struct dc_stream_state {
 	struct luminance_data lumin_data;
 	bool scaler_sharpener_update;
 	bool sharpening_required;
+
+	struct dc_update_scratch_space *update_scratch;
 };
 
 #define ABM_LEVEL_IMMEDIATE_DISABLE 255
@@ -390,6 +392,33 @@ bool dc_update_planes_and_stream(struct dc *dc,
 		struct dc_stream_state *dc_stream,
 		struct dc_stream_update *stream_update);
 
+struct dc_update_scratch_space;
+
+size_t dc_update_scratch_space_size(void);
+
+struct dc_update_scratch_space *dc_update_planes_and_stream_init(
+		struct dc *dc,
+		struct dc_surface_update *surface_updates,
+		int surface_count,
+		struct dc_stream_state *dc_stream,
+		struct dc_stream_update *stream_update
+);
+
+// Locked, false is failed
+bool dc_update_planes_and_stream_prepare(
+		struct dc_update_scratch_space *scratch
+);
+
+// Unlocked
+void dc_update_planes_and_stream_execute(
+		const struct dc_update_scratch_space *scratch
+);
+
+// Locked, true if call again
+bool dc_update_planes_and_stream_cleanup(
+		struct dc_update_scratch_space *scratch
+);
+
 /*
  * Set up surface attributes and associate to a stream
  * The surfaces parameter is an absolute set of all surface active for the stream.
@@ -597,7 +626,7 @@ struct pipe_ctx *dc_stream_get_pipe_ctx(struct dc_stream_state *stream);
 void dc_dmub_update_dirty_rect(struct dc *dc,
 			       int surface_count,
 			       struct dc_stream_state *stream,
-			       struct dc_surface_update *srf_updates,
+			       const struct dc_surface_update *srf_updates,
 			       struct dc_state *context);
 
 bool dc_stream_is_cursor_limit_pending(struct dc *dc, struct dc_stream_state *stream);
-- 
2.43.0

