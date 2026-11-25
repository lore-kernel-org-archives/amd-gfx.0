Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B705960A260F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0pXlMj4D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A3D810F5F8;
	Wed, 25 Nov 2026 06:56:53 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3902310F610
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:56:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jr8XZn5/UiO0Vl5NnaWFISlZP/iQjY5yRSzZKSV+rmbqENp7QjAYWuL0rfSFDAjE1AW15jh0QZzDJILubWPpymuysPCaYPRcA6KC7aI3FxGkkSY8cqoKf4uGkwvLdxY6zvCjxJ3ikpTZHBwvSdsIIUtEpZifnma38sWQv7vfWEc3VRzRfxNQ72SWuyJwInV5BsNdScJGsPOtEQn9kJQmx5hddrjNg0MC+uIXRu6rVmVwmnC6oRpKjMiRqAM7tPJB4eMj4zRPvECPz8hVWT2sdX7PNXalj+1yNHTl5ilh+NtA7vFYcpRoBLO1DWRSIxsCtefZbUuCMy8v5nT7BohO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LlmaRHNCu0QxNuJufGLWTCEGcgEDyz0maBri+oG6CY=;
 b=ENJ/9zBbn3v0DVeQYXV1tI00G5sjS+M/RpyNH35r5xoKKwJbufTAblc6lpox/MgxrAj+974apirHaA20mYfTGYczHCdUvt+Z9jB6R4f+hlVwVuCu9ujuj0gxsOIfqpE+0Ltgm3fstL9+J4ZNlnb8mK9OsjNcF/094V+56qtDVrgNKDYKU8FVShN3lhNJbQCyetgDaSIY4dOXKHHb1ERmOY7GlYD1GKTpDmSk/X9hGnfF6JGcbWeEQsRs42mNSnxRehAnpbVB7in9HSvpELe3mz0TtP6Jnmcwv/ivcBPMeSXwFhrrMl3+6GcB51w5Dbxrf3DbRaJGkCsm85Uv8bX4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LlmaRHNCu0QxNuJufGLWTCEGcgEDyz0maBri+oG6CY=;
 b=0pXlMj4DAMHfDbgR/PlqygLhfnM+4X+B8sVcVBb0SJCDNQTF2x2iITeEHApRT1hXJiycV/OgypQxNLZ2gphOSp+/wmrgmLT2DMUZHEj2DEH79/vGLJWbbYKlHL1iqU6EImx+qgV3d8lP6qZA+znCrgxni+Pc1R2ODTedQBX7auA=
Received: from PH0PR07CA0072.namprd07.prod.outlook.com (2603:10b6:510:f::17)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 06:56:42 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:510:f:cafe::23) by PH0PR07CA0072.outlook.office365.com
 (2603:10b6:510:f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 06:56:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:56:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:56:41 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:56:32 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 10/27] drm/amd/display: Carry the stream and plane update bits
 in update_flags
Date: Wed, 25 Nov 2026 14:54:59 +0800
Message-ID: <20261125065631.3889665-11-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: af913219-2213-48cf-6211-08df4ac142d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|261009223027099003|22082099003|18002099003|261102123227099003|261021123027099003|261021121427099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 9uvNwg1Y795rZuCFhpG4vVuqkLoeqCnyypv2+SJJVh6G8Y2aVGJvk4hLw8OKAn4D0JC9OyMR5ZGVYTYWtePi5G0n7Sojhvj4dR+fDF6FBSya+YfTzjW8qi6kGGLunBSgvlTghAm4zmjefkcx42earwGst9pWD52t+M76Pd3kKflPNGzZYL0tYJy1GopXgxzlIOeYPa1myYHKFL8epANdivmjG6jX8zgutMQpuz9cO66dGkDRy/wcSGw/SX7K2IBum3u/AG8EHg6iSm/chgo1nDHbC9kB5fgOM1TMCnaq7NtL2QmET0ADGlFHXUL3Via+G8i/+I7ZWh9ZpnjE2RlGVcaDJblS2rudHpfl2AqUXPzS8Eyq7lhbU6DT/dz+GYpz0kEzh2OgjQPm9ohfoycXofhzqLZQM50QAPtZGH0QnOtwVv1NbXZffZWWYiy3Sh/Jp8OY/Nj8PtooXAm6kbjxIDxSvblUXpIAcFHU3QWaF8afuiFrw1dQpWwOkJO9Sv50Kj2aznShuIu8hkisGf2UjXhi480so2y83ScEL7YIOUzeiW+15hrds6x8yq0T4pEiu1ec3RkFcTl+tq1NFxYxGCPsjxcLVMLuwU1D0qdJGx+JE2n6beL9Y1zhyBnP/hx8+2scUa7m3s0iJ6o3qJRNL6XUYpYXiAoEzqwybU9OTTVJHQeUgdFVEFzFjwUaHDfgM9GufHmfkTUi8AHwam169Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(261009223027099003)(22082099003)(18002099003)(261102123227099003)(261021123027099003)(261021121427099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VRZ0eE2QX+VMqs2tmHBFvfvB41hOtbNUXZP3JBLhXj24Rl1Z9JTuFKqBB+4WpjwQRATnHtOclJJh654sQbd4uv8Qc0u22rAqPkqafCqIGKPlXVhHnn3DDNEdDG2JDLLJnQ6FkJf/8y+DEqdS3xgJSpk17UdG91k49EEd/EzqBrgNE9srlFSkZYpfpflemsX4SYA0a6tnKxkrfKy5TyO3/EeilSUVfmyubCx0okx8B5N+Yf/zR46skd3/OqLKhU/67/Z5iw88YpRPsqwYONjgKYtug7rh7cm8xXDQl6CwiO3kWnxRGh9bAEYxc18JNcpwiWrW5w49pGtSVZeVwCbEg58pGYyZ7TijyYlMtuCbF4jJ8aW3vtWRoT5//lSZpCsMJ6HRnYUsMLkFPpo35r7rv+okrV1L1x9QEJqsj6JJZ6rCihiGOihT60qB+qyQCiu3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:56:41.8971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af913219-2213-48cf-6211-08df4ac142d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

[Why]
A BLS builder should read what dc_core changed from the update flags
instead of comparing the current and new states itself.

[How]
dc_state_compute_update_flags copies the update flags of each stream
into streams[], and the update bits of the plane on each pipe into the
plane field of its pipe flags. No builder reads them yet.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dc_state_priv.h | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 961c3c1ea51f..7eadf802c3e9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -1174,6 +1174,8 @@ static void pipe_flags(const struct pipe_ctx *pipe,
 			pipe->plane_res.hubp && pipe->plane_res.dpp &&
 			pipe->stream_res.opp;
 	flags->det_size = pipe->hubp_regs.det_size;
+	if (pipe->plane_state)
+		flags->plane = pipe->plane_state->update_bits;
 }
 
 enum dc_status dc_state_compute_update_flags(const struct dc_state *cur_state,
@@ -1191,5 +1193,7 @@ enum dc_status dc_state_compute_update_flags(const struct dc_state *cur_state,
 		pipe_flags(&target_state->res_ctx.pipe_ctx[i],
 				&out_flags->new_pipes[i]);
 	}
+	for (i = 0; i < target_state->stream_count && i < MAX_STREAMS; i++)
+		out_flags->streams[i] = target_state->streams[i]->update_flags;
 	return DC_OK;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_state_priv.h b/drivers/gpu/drm/amd/display/dc/dc_state_priv.h
index 0415e45d438e..c73c08989bd9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_state_priv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_state_priv.h
@@ -136,12 +136,18 @@ struct dc_state_pipe_flags {
 	bool has_plane;
 	/* The DET size from hubp_regs. */
 	uint32_t det_size;
+	/* What dc_core changed on the plane of the pipe. */
+	struct pipe_update_bits plane;
 };
 
-/* The facts of pipe i in the current and in the target state. */
+/*
+ * The facts of pipe i in the current and in the target state, and what
+ * dc_core changed on stream i of the target state.
+ */
 struct dc_state_update_flags {
 	struct dc_state_pipe_flags cur_pipes[MAX_PIPES];
 	struct dc_state_pipe_flags new_pipes[MAX_PIPES];
+	union stream_update_flags streams[MAX_STREAMS];
 };
 
 /* Pure: reads both states and writes only out_flags. */
-- 
2.43.0

