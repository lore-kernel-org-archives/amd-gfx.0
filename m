Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE04C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B3CF10EE45;
	Wed, 20 Mar 2024 06:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X95dzpoq";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ACB210EE45
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrF7Da06a+Us8+8J2088ej+1BSZvGYVWPnNM2xq3fMkKu2caVTDk2yQFO3pkKRDjbBF2ZLJl20kDxlrPPZSC1OP9UP/h3pIMPftTQlSj3QleNZpVTR+xkv2HTmlm9N5ZG+5bqK3fzl37QJexC6ENsEpTMWe7tAt3tBgVcNroRbfD7s7WNu+zm/o4EydB7LQF+7AHdU4uxx1/0txZ8LMSjGsTT9aGwpsriHUttJGed6tSWfc6gYzM5y6ZW66dxw+SkNImKv+gmu/Ae+Sv7xQ70JP9S3gfOzRLvA4xwztQFdeJC1xMUV7bz4m5msFbPAPJ5Tmqn7rp3V85oX9itO1t9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8jE9aURssmV2mbiAb0K5WjYgPdJK8HVMOz28Bzw9Dw=;
 b=oZ+JsoHU39FZc1EppW4GFZdz8WBHQAXsx3AgnJulkOj005TPAISprMUj88LM7d/X7wQBJOMu4DVyiZvTBG7YU+Aa5gY9dqPXt3KP6/ZpJmjoWRmQwzS/+Ql+JftrPNAZ/l1O4MsVIafIbXUTodRukhVWmVBbAdx7XK55BbRwSgFkXkUlfXtMqNsROz4h4gM3qcQICKVXqMe+/5xn4FPp41DLBxymXz526o0nymDnEbDf0FTeacdeH4EHDmg6uFUiy28HIA6MDuP1X2pu1DNmbCift4HNJMXKPoytEvBADwVwcuht3jYZVgBY2Sags36WBDkwoikk/GsNaYMrI/TxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8jE9aURssmV2mbiAb0K5WjYgPdJK8HVMOz28Bzw9Dw=;
 b=X95dzpoqs0xOGVtlPFQeZK2w77PKSZ8eSja8I+b6HVmiH+o2JyepE07EMvfLJ1VYcOolyEUeaumHn40cELxt4n9SPtZOomDlngvCI3Qi+OdLzZy9FsRze59xEaOQe0fASB7SEyGgX23ZsRRRo4iLg6ab/PLftgN/C9XMdZp5/+M=
Received: from BLAPR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:36e::8)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 06:36:43 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::7c) by BLAPR05CA0004.outlook.office365.com
 (2603:10b6:208:36e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 20 Mar 2024 06:36:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:36:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:42 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:36:39 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 10/22] drm/amd/display: build scaling params when a new plane
 is appended
Date: Wed, 20 Mar 2024 14:35:44 +0800
Message-ID: <20240320063556.1326615-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e197c49-f6fd-4ee7-3f05-08dc48a81b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Et7r5Nd8y+l5r1vsMP71QtrBoDs2zEdMk4U0istKJ3HfIJjAN3RhentIgXp23FKne5jSSG7aQ+cdx0tNUJYbK4vZjgiCDr9kb1yU9/xOP961quqe1hme6hmgO2zwvHJDhTQyd7pdWxoL7SlPoXmIFjgo8qr4IB0Ku/WJbhYfkbL6dkVI0t9cJtOiN2+iC1KusEeK3pBpSIlIY+VBt2FZN7Xl0tRscUSLY3jPKkN3AyKhk0MvuJON/7t/skTk/snTu873iYbAHVre9yanD9Ts6uk8sC8QpLYs7R4dbsVeo4ajPfy/DPWxlPDHi3ov7VJPbNK2e7Kb31PCm7VjL1I61KARaEib8uQZCUHIqnFUswIqD88Qo7lP+Z9QKB8Cf/3A2BaopK8BZ625GmyI2r9tG3JDEwE3GznThaMwKJU8UyyMGTXn4gGRXzKVpwvr+XF2O5FJr4rOVMg1WlcjkHMDVg/4KvXEz4JlEs9rvp0JW9Pgrhu5O/KZopNvMwoMNa3qPAbUFM/DkR5TVEuXOtMvQsStDaGjd/RyGd7k1ZVJQf44sDD8aOru16fzVjuqH0yhUe9iMtiDozeQIwC1dCJuCcz8Vpduf8Npo+q5Kt1uSStrFmKP0TpoUf5I/dCGuVYPNvTBrvvIhdxssNa75o0tbhMMILGXau8KMnfuqmtsc4OrbpiqBpU+a53UO8tOjb2hvz9qrlPHEvF/wG8TkiL11JhxdjvXzCM3lDz1UvoRUzjkBu4lsTEGVupf/4Mb7rjF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:36:43.3336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e197c49-f6fd-4ee7-3f05-08dc48a81b8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why & how]
We are boundling changes in plane state and build scaling params
together. This is to simplify DML code so DML doesn't need to build
scaling params. We are also avoiding rebuilding scaling params for
planes without scaling changes.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          |  5 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 10 ++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 726c82be16fa..5e93bd696d21 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3236,7 +3236,10 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	for (i = 0; i < surface_count; i++) {
 		struct dc_plane_state *surface = srf_updates[i].surface;
 
-		if (update_type >= UPDATE_TYPE_MED) {
+		if (update_type != UPDATE_TYPE_MED)
+			continue;
+		if (surface->update_flags.bits.clip_size_change ||
+				surface->update_flags.bits.position_change) {
 			for (j = 0; j < dc->res_pool->pipe_count; j++) {
 				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index fa6e6184c437..2b01b4a3861d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2649,13 +2649,19 @@ bool resource_append_dpp_pipes_for_plane_composition(
 		struct pipe_ctx *otg_master_pipe,
 		struct dc_plane_state *plane_state)
 {
+	bool success;
 	if (otg_master_pipe->plane_state == NULL)
-		return add_plane_to_opp_head_pipes(otg_master_pipe,
+		success = add_plane_to_opp_head_pipes(otg_master_pipe,
 				plane_state, new_ctx);
 	else
-		return acquire_secondary_dpp_pipes_and_add_plane(
+		success = acquire_secondary_dpp_pipes_and_add_plane(
 				otg_master_pipe, plane_state, new_ctx,
 				cur_ctx, pool);
+	if (success)
+		/* when appending a plane mpc slice count changes from 0 to 1 */
+		success = update_pipe_params_after_mpc_slice_count_change(
+				plane_state, new_ctx, pool);
+	return success;
 }
 
 void resource_remove_dpp_pipes_for_plane_composition(
-- 
2.34.1

