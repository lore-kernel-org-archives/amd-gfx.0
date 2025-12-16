Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAD7D5CCA5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C68510E7E0;
	Tue, 16 Dec 2025 09:58:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TJpgOp+j";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB7C10E7E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUfTUxATUaGFQmDhF2edyBn7zCmiW2mz8opwigFFn3XEcsFl44BN2aOHAq5/aQpazqllhd3b1TOakyg5dlwpLx8v6ekDqlNHPV8RJgTDGHbuUuSV5quWK4BdFu5rOqF3CjWR/Z/TMqM++gorhE0ANjSkYPkP5jO5qh0/fIfAG+v1WeOaEwO8ZOxX3/0KARilpg28S9L0RCFJReWgz8919YtMlLXHcJUkNFaYETkVaS0w8MYT5btFfoYcPb8zfhBSsv7zNk3Qcml4bRPZ0BnooY55GvT55fl5KaVR2kDr5FmJ8SnAXk7pxEov8X/sfAEuCFtFPl8wLNeDl3s3udGjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWZOTt5pIAw/8reMF4STNSI84PV62nuVFezGwWogJz8=;
 b=MXjW8ammqmhvK4akldorWblikfknXRRVCVEVpICcKYUWAItPwnNsJ7h5Mcm/laCOj0lJHbxNffZHVLcz0FmQ7JwgDCppPib67fmLDZbkOqxfqVAAvOQX8gdcU342V3hYU8xjOHuRo9oInO8914p8WL7ObklZrX2q2nkYsm7QsEKBudIgxiBWtAQdOEBZrzohRUwpdkpu8ASUY8kH5Keqdh4EPYeZyKs62nexqc4nIThByOy3JXt0ydoAZWxz36n5kvBK9PQHIgrTaTm+HvvI6EPhTyXS25Hf3iO3RbE7bje8DxxymA2rKXpqBYYsiiuqbMqZNATPPnCMyZ3ivxVwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWZOTt5pIAw/8reMF4STNSI84PV62nuVFezGwWogJz8=;
 b=TJpgOp+jhBvWZVyflytO6BzcEl8wgco3rNL7tVIa0M3+x+PTizCHImZgI2dIytn3Xdc8Y6Wt2N/xhNmLPlJhyHJhpbvK0Ld9Mm1VxdHuaZWymbr82MSRrmyJDAH05QYsvcZBlFOxUDkgXweXu/8agyW9yqBpLxUS9Jl5+dykhso=
Received: from SN7PR04CA0089.namprd04.prod.outlook.com (2603:10b6:806:121::34)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:58:14 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::59) by SN7PR04CA0089.outlook.office365.com
 (2603:10b6:806:121::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 09:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 09:58:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:58:14 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:58:13 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:58:10 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Cruise Hung <Cruise.Hung@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 12/16] drm/amd/display: Remove unnecessary divider update flag
Date: Tue, 16 Dec 2025 17:56:12 +0800
Message-ID: <20251216095723.39018-13-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: e9953c5a-73ff-4d2b-0a26-08de3c89a107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8pMKlRRBEts61h7F9nkM78+tHZxwS7iu8ZQu8fPN0yU7Z0IF1NWQoZFVYks5?=
 =?us-ascii?Q?c7R7pE+WOOzY67IZv7VDuuzAuwdq3slQoBmUP7VXzauOrdPC4LC8L7NGmmwE?=
 =?us-ascii?Q?7ZCFvoutG2i9ogHAp4rlQpurBdHQT51NbU2+CbSnTSKNRtlCDVqRbdBSbS+u?=
 =?us-ascii?Q?szn2XUNq1NzcF/K4WrbziTchlKfLvCE1euNEhQr61y1wv2Z+KLTRBREKDf97?=
 =?us-ascii?Q?codzk/s7nd47v+JZby8pNcA5v2FYSmy53DVo7RJ+v799F/2zIPpzK0+x7Wqg?=
 =?us-ascii?Q?0l38NSOvoE4tGRF881mEu7qUbZTSmXw4WzGzPpyR4GylBxCoV4dMTicRGgaG?=
 =?us-ascii?Q?qXkkdtwQQMb7iee+7zp4WZUMuUfB6Uh03W/nQUQ23v7Wpp5mWDYPfoj+wY3z?=
 =?us-ascii?Q?jb8EYFpw9oVX1b8NfKAqNbj1lCiTpRP/aZGCVAhwdKViqidksGmk1KdK5J1D?=
 =?us-ascii?Q?ktI+e/zG6Pvop+l8tmtgMT1oBxyE9KJ0+DzoI/fQQ6+xyHq4BznNkOwQ6H9t?=
 =?us-ascii?Q?RKqKnWYpen/uYYHSaTRo8DjHYIE/1UaHVkllVpJhPRPc4rF+soSdVKr8qgrX?=
 =?us-ascii?Q?Bk75aTjoGViARDw3AcnKBXsBW0GG4vu9xOYBQt9lPPSxvGfWejb1mwXG3BN+?=
 =?us-ascii?Q?kIbjC2lRb1l2NSvCkpAAD/Q7YTAn2czOgrFrIaVtcpxNBQdXIeQY9gKQG/PA?=
 =?us-ascii?Q?Hl4foZ5rPKZBgJgm+mYgu7mRwW8T3CAHbhMRd3hxCttkMVYB2+RJ6HD7kWEW?=
 =?us-ascii?Q?QYkE1/2EwWlrDhfIsCb9PBSkvvWyTAtUFbOIL8BnwfgRTHmPiARzCDXnR8nT?=
 =?us-ascii?Q?WhuLtcsmEh2n8DoI7gRuJaIt5hjrh6sqGk4zUr/RyoejxdqxLwWwxzWlw3pt?=
 =?us-ascii?Q?YEOmRjf65EKqmgH9Sf/5dMxJzCJP0XpaH3RrfnejTAtexdypGBmliot8W/v7?=
 =?us-ascii?Q?8gWvmd+JnffNPOnKeZSvHJKTybwRHFqKexJLWRs7ZSGaypF8rPbR50adAMcx?=
 =?us-ascii?Q?d52DlhoaMGQQcGah0AkOlkvcX6jndsuxB0qg5fWNmBTR3QNjHg4ZisWPH/1C?=
 =?us-ascii?Q?ZUKVNMmiuUEBRvqQX2tB7Z8/NjmkQxFhK9FFcBxJEisQpCfo57TpxcVbYqC/?=
 =?us-ascii?Q?D/gvLQQ1JDZhMQ75UVCvN86+gLuM+Z9GzjmTPWff5lXqp98ySH+rJOlLXCfR?=
 =?us-ascii?Q?tUpDGu6iTnUNnmLwiAo18xDOhxW5SbVQeMeK4FEultQCrDl9UvhGNek16dce?=
 =?us-ascii?Q?I3j9MhOcE1JFBC4AslBSF+9Q9BtMFALjvX6elX2Y8cj6tHcz77Eyw/Nt4+eV?=
 =?us-ascii?Q?971EQZvta9kcL395txNMMMnI0JyPWODmQIG7XtbsV+lfm60UIUknNJd9qMbo?=
 =?us-ascii?Q?IBTySwCnJ2ONYUCnPr8PaRHEpDOOi6eUg94VxumPLQYjbX6s0BkduuB9Ao4z?=
 =?us-ascii?Q?x8J31yP6DtJMY0qtzqdmFY5P262oQkaQZxpvkaQvADDZvi7bCQeUpMus4n8G?=
 =?us-ascii?Q?R7c8MB9PSF5EHEMaOt5iwG0OmZ1hePuq62KNzVtm38+yQUi2RyqUq4+BGYuc?=
 =?us-ascii?Q?vwbYCjCl/COvv194pUw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:58:14.2609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9953c5a-73ff-4d2b-0a26-08de3c89a107
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
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

From: Cruise Hung <Cruise.Hung@amd.com>

[Why]
When transitioning from 640x480 at RBRx1 to HBR3x1,
both output pixel mode and pixel rate divider should update.
The needs_divider_update flag was only for 8b10b and 128b132b transition.

[How]
Remove needs_divider_update flag.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c   | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 1045c268672e..5a547d41d4a1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -70,7 +70,6 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	struct dc_state *state = link->dc->current_state;
 	struct dc_stream_update stream_update = { 0 };
 	bool dpms_off = false;
-	bool needs_divider_update = false;
 	bool was_hpo_acquired = resource_is_hpo_acquired(link->dc->current_state);
 	bool is_hpo_acquired;
 	uint8_t count;
@@ -80,9 +79,6 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	int num_streams_on_link = 0;
 	struct dc *dc = (struct dc *)link->dc;
 
-	needs_divider_update = (link->dc->link_srv->dp_get_encoding_format(link_setting) !=
-	link->dc->link_srv->dp_get_encoding_format((const struct dc_link_settings *) &link->cur_link_settings));
-
 	udelay(100);
 
 	link_get_master_pipes_with_dpms_on(link, state, &count, pipes);
@@ -99,7 +95,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 		pipes[i]->stream_res.tg->funcs->disable_crtc(pipes[i]->stream_res.tg);
 	}
 
-	if (needs_divider_update && link->dc->res_pool->funcs->update_dc_state_for_encoder_switch) {
+	if (link->dc->res_pool->funcs->update_dc_state_for_encoder_switch) {
 		link->dc->res_pool->funcs->update_dc_state_for_encoder_switch(link,
 				link_setting, count,
 				*pipes, &audio_output[0]);
-- 
2.43.0

