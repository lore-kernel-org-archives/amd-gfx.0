Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B09CAC5B1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 18:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D870B10E7B8;
	Wed, 24 Sep 2025 18:22:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cDHbCNYG";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011047.outbound.protection.outlook.com
 [40.93.194.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60D5910E7B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 18:22:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urS5FtYAUaIucHi+WCER7uMWlnJN28EO5lYvvN1kCukpay4euwryGDXUrsk42zl0/cOGdhW3nJxh87Vzc3VzUnPkfR+E9qWAx2RVBIZvKKtBi/2dHTpfXQUVIBVyHuJ6UP216Iu7PnmaUi8qbshyKgPpZX9dTqBEROx3YiPmksJJPzYQXpy1ZK86MHpPDBlC4INsoByBx9IdjTLikoOeCB7xz2z/HJpWfoCTcXpKemDZseu3tgBXFNmkSI9uCy8aPMv/OmacN1F8VqUcLz8oCaZMSQSI9FnNSCOo8WlJ2FQ266GLCIPtMKHE1SV/pca5HEmzngIgP4Zj/8RuA0OV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5av35bxuHdcyDv5x+bpgDNFidtGrjknXhNCTYa/1rGk=;
 b=xvU83wG07NOJfFwx7dOitjtMyPPept9edS/kgV8nSXFJ1WWH/92Dg5xFpvl1S1qTanfXfjl5heCtEWny35y6SeHD6C3u3B9/YOqd5YDCUHdS8tfwNRqwJ+N8B5urv9kJVpUVQ6HKLTetNJe0HtDzMxqOimWgW1fYD3IHO9SdtAFZe//ahefrk052wTqym/oS1p+xm5XQYusjT0ZuFfL9q+fTEbjKPa7WlksiYIV6tbNJuz/ifftOb0UfCt4Oyn3a4FaWGAuB7ZbXdNP4Yxp9bMwyo8GdFin8bnyaH4qZl8gYYXzvvD7AhJxrwFfhYiJv0PtTpAAg+PCyfRAMa4Xw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5av35bxuHdcyDv5x+bpgDNFidtGrjknXhNCTYa/1rGk=;
 b=cDHbCNYGOPVyFXbFZ3WAfevJaEhcCRKK65wYrNaHt2JzRfNRBa7BOecpYLNjSMW+y3EW+2nocGXoRXd8b/ifizrPQegYQOKaXhyLhD8ulii39U57D4zxCRNFkYG9/UYvtdV3NrmzfIx4+2rk/ImIgBCQMbwnz1YdBvMiUIW+i8A=
Received: from CH2PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:59::24)
 by SA5PPFB2BF91BC0.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8de) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 24 Sep
 2025 18:22:37 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::b4) by CH2PR03CA0014.outlook.office365.com
 (2603:10b6:610:59::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Wed,
 24 Sep 2025 18:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 18:22:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 24 Sep
 2025 11:22:24 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Sep
 2025 13:22:24 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 11:22:23 -0700
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Alvin
 Lee <alvin.lee2@amd.com>
Subject: [PATCH 06/10] drm/amd/display: Rename FAMS2 global control lock to
 DMUB HW control lock
Date: Wed, 24 Sep 2025 14:21:57 -0400
Message-ID: <20250924182201.1049389-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924182201.1049389-1-Roman.Li@amd.com>
References: <20250924182201.1049389-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|SA5PPFB2BF91BC0:EE_
X-MS-Office365-Filtering-Correlation-Id: ef825afa-63b2-4c8f-65ca-08ddfb975673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?01P7XDjBrrlHvINJGiXKblFteLootBWDDtf/6W3uajO1pxsUyVANhfpA/1x/?=
 =?us-ascii?Q?Mn2i8BPLAMhWKXKAHDyekLkNlQ1sQJCnUwtWpvI3bDCKSjNtxrvz2cE+o2v6?=
 =?us-ascii?Q?0HQ3PvH8LkScODIcex/PavC0QKIilb72MZGb9uHbahyld8BXGsioxvVLTQU0?=
 =?us-ascii?Q?fKiPfP6k5uXcn7fO4ak9wmgcEJDyl7azxOL4asXoIICUVLsfFC0OGYdAexaC?=
 =?us-ascii?Q?tvfXJOxSS3Ba2FTTs5VBvOkA/mIXosapq4+g6A1ay6lV6kE9fcRB0A2QVp/H?=
 =?us-ascii?Q?mubHY4N7r4LcjObhMUugOY9RggKLY7ZaXKZ7VM5UVzg6MXHICIdpy69dUgBS?=
 =?us-ascii?Q?RChfY4eXwzMbysFnKwu6tSSCRkRYMumYyjzRti613Ms3Hc+8N0uS4ENfu+tI?=
 =?us-ascii?Q?tJZTblBiZ1ydkKc/x3ImDdKVD1GQMitGqrkLDBHrbFEK6bgeg7UMsXtyyVP8?=
 =?us-ascii?Q?ECG/1viUcS2Aa/XxZfTey/w+Msb1HMrksiY3MYK8RgV8vQET4T0Y1su9bNjt?=
 =?us-ascii?Q?1ctIfWwd0og6VnHIEUYjLyQcVDltvGxrMECFepefoSxtSzRhNmHb7rSnQfKT?=
 =?us-ascii?Q?GOc7FyJP+miG24E96TEptK8R1L/CwKL3x2ku4QUV820gFRh65ssTSaWjV2/y?=
 =?us-ascii?Q?JFgqqRub7PycjUvxGBR1iW0pzY87pTaRUdYFxInw3xTGq7GeIApYI77xlt4q?=
 =?us-ascii?Q?ydaq91EWcvhSPgfLEknsdCCzdMKoNdM+vrG8SLyi+EGhfHipqAm8VpOT6NVq?=
 =?us-ascii?Q?vetVFMZb5jJbPWHJbeUoJz3hrc/4I30p5Tfe318FqxEt+/BJSoFsCP46Rt78?=
 =?us-ascii?Q?jAsG+SLalrQaCkt/St2GdXVLPSh4/gl8z0xcuQY9qISEyn+iZpZWEXM1nH0q?=
 =?us-ascii?Q?k6s+1I9h2yWJo0xXt0j7WQkzTc9ZiGixa1IoHTWcqj/3FJrr9A2TbAte6QyE?=
 =?us-ascii?Q?gixgOJDhCBnQB/v08hvwYSmSmgBPijqCngMuQ9VwYl7mfCpRBAIYzvEJh3wQ?=
 =?us-ascii?Q?cZPmYTTA/S7WsakuVenEaK7GsoOdjl16i8vVLplU1CGNjw/bBgLXWq2lBH0J?=
 =?us-ascii?Q?53eeZ93HJwQQnUZYqIS4IIlxe9N+qF9ogdOjsP68SDErUqD0xJbBDtJEQp/q?=
 =?us-ascii?Q?bJTTpeEdT/jXir2UVmyvWTt9AUOlOOZTpleDVWZS2/1/OPDmwzfcK+C+78Kz?=
 =?us-ascii?Q?GJalG+A4cK/Y71Jlb1g3RYT0RGHqYYiXDdNKTJGHMIadP2Ci/4KOAuPnqsI5?=
 =?us-ascii?Q?qp/iO6fKcAbbAtVYmLCosz0BV3ggdG34KLdS8uALUNj6X6XmRoHyah0SuL12?=
 =?us-ascii?Q?//3lHyTieJXnuoQyaTEna4K9Mac30/Fr4UPtMxD95uG/gP57xnn2RyFgPZin?=
 =?us-ascii?Q?wCkwtFiwiGQKgos6rIBGo0tvBWTJ5Tq2JIgh/MKxUr2wKLoN02ULe/x7cYdk?=
 =?us-ascii?Q?B+mt145ReX8fExp58J/LwYgqrA1dSJAL1Bmy4pWtmoUMAAhUc6vrhRV5csaa?=
 =?us-ascii?Q?2A58WUv+6NxM/4hKdOf0AwGfAXVAxGAA2JKe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:22:36.4983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef825afa-63b2-4c8f-65ca-08ddfb975673
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB2BF91BC0
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
FAMS2 dictates whether the inbox0 HW lock is required, but it is not the
only feature that may determine this.

In order to leverage the faster inbox0 HW lock in place of the inbox1
ringbuffer based control lock it's desirable to utilize the HWSS
based locking protocol FAMS2 has already implemented.

[How]
Rename the FAMS2 global control lock to DMUB HW control lock.

This is purely a refactor with no functional change, the logic that will
determine which features need to enable this HW lock will be added in a
future commit.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 29 +++++++++----------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 24 +++++++--------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 18 ++++++------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  4 +--
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  4 +--
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 10 +++----
 6 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index be885801a9ed..eae2dabd5182 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2158,8 +2158,8 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	 */
 	if (dc->hwss.subvp_pipe_control_lock)
 		dc->hwss.subvp_pipe_control_lock(dc, context, true, true, NULL, subvp_prev_use);
-	if (dc->hwss.fams2_global_control_lock)
-		dc->hwss.fams2_global_control_lock(dc, context, true);
+	if (dc->hwss.dmub_hw_control_lock)
+		dc->hwss.dmub_hw_control_lock(dc, context, true);
 
 	if (dc->hwss.update_dsc_pg)
 		dc->hwss.update_dsc_pg(dc, context, false);
@@ -2229,8 +2229,8 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc->hwss.commit_subvp_config(dc, context);
 	if (dc->hwss.subvp_pipe_control_lock)
 		dc->hwss.subvp_pipe_control_lock(dc, context, false, true, NULL, subvp_prev_use);
-	if (dc->hwss.fams2_global_control_lock)
-		dc->hwss.fams2_global_control_lock(dc, context, false);
+	if (dc->hwss.dmub_hw_control_lock)
+		dc->hwss.dmub_hw_control_lock(dc, context, false);
 
 	for (i = 0; i < context->stream_count; i++) {
 		const struct dc_link *link = context->streams[i]->link;
@@ -4176,16 +4176,16 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (dc->hwss.subvp_pipe_control_lock)
 			dc->hwss.subvp_pipe_control_lock(dc, context, true, should_lock_all_pipes, NULL, subvp_prev_use);
 
-		if (dc->hwss.fams2_global_control_lock)
-			dc->hwss.fams2_global_control_lock(dc, context, true);
+		if (dc->hwss.dmub_hw_control_lock)
+			dc->hwss.dmub_hw_control_lock(dc, context, true);
 
 		dc->hwss.interdependent_update_lock(dc, context, true);
 	} else {
 		if (dc->hwss.subvp_pipe_control_lock)
 			dc->hwss.subvp_pipe_control_lock(dc, context, true, should_lock_all_pipes, top_pipe_to_program, subvp_prev_use);
 
-		if (dc->hwss.fams2_global_control_lock)
-			dc->hwss.fams2_global_control_lock(dc, context, true);
+		if (dc->hwss.dmub_hw_control_lock)
+			dc->hwss.dmub_hw_control_lock(dc, context, true);
 
 		/* Lock the top pipe while updating plane addrs, since freesync requires
 		 *  plane addr update event triggers to be synchronized.
@@ -4228,9 +4228,8 @@ static void commit_planes_for_stream(struct dc *dc,
 			dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes,
 							 NULL, subvp_prev_use);
 
-		if (dc->hwss.fams2_global_control_lock)
-			dc->hwss.fams2_global_control_lock(dc, context, false);
-
+		if (dc->hwss.dmub_hw_control_lock)
+			dc->hwss.dmub_hw_control_lock(dc, context, false);
 		return;
 	}
 
@@ -4467,13 +4466,13 @@ static void commit_planes_for_stream(struct dc *dc,
 	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 		if (dc->hwss.subvp_pipe_control_lock)
 			dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
-		if (dc->hwss.fams2_global_control_lock)
-			dc->hwss.fams2_global_control_lock(dc, context, false);
+		if (dc->hwss.dmub_hw_control_lock)
+			dc->hwss.dmub_hw_control_lock(dc, context, false);
 	} else {
 		if (dc->hwss.subvp_pipe_control_lock)
 			dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, top_pipe_to_program, subvp_prev_use);
-		if (dc->hwss.fams2_global_control_lock)
-			dc->hwss.fams2_global_control_lock(dc, context, false);
+		if (dc->hwss.dmub_hw_control_lock)
+			dc->hwss.dmub_hw_control_lock(dc, context, false);
 	}
 
 	// Fire manual trigger only when bottom plane is flipped
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index d82b1cb467f4..25a07e5f4ed7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -755,11 +755,11 @@ void hwss_build_fast_sequence(struct dc *dc,
 		block_sequence[*num_steps].func = DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST;
 		(*num_steps)++;
 	}
-	if (dc->hwss.fams2_global_control_lock_fast) {
-		block_sequence[*num_steps].params.fams2_global_control_lock_fast_params.dc = dc;
-		block_sequence[*num_steps].params.fams2_global_control_lock_fast_params.lock = true;
-		block_sequence[*num_steps].params.fams2_global_control_lock_fast_params.is_required = dc_state_is_fams2_in_use(dc, context);
-		block_sequence[*num_steps].func = DMUB_FAMS2_GLOBAL_CONTROL_LOCK_FAST;
+	if (dc->hwss.dmub_hw_control_lock_fast) {
+		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.dc = dc;
+		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.lock = true;
+		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.is_required = dc_state_is_fams2_in_use(dc, context);
+		block_sequence[*num_steps].func = DMUB_HW_CONTROL_LOCK_FAST;
 		(*num_steps)++;
 	}
 	if (dc->hwss.pipe_control_lock) {
@@ -894,11 +894,11 @@ void hwss_build_fast_sequence(struct dc *dc,
 		block_sequence[*num_steps].func = DMUB_SUBVP_PIPE_CONTROL_LOCK_FAST;
 		(*num_steps)++;
 	}
-	if (dc->hwss.fams2_global_control_lock_fast) {
-		block_sequence[*num_steps].params.fams2_global_control_lock_fast_params.dc = dc;
-		block_sequence[*num_steps].params.fams2_global_control_lock_fast_params.lock = false;
-		block_sequence[*num_steps].params.fams2_global_control_lock_fast_params.is_required = dc_state_is_fams2_in_use(dc, context);
-		block_sequence[*num_steps].func = DMUB_FAMS2_GLOBAL_CONTROL_LOCK_FAST;
+	if (dc->hwss.dmub_hw_control_lock_fast) {
+		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.dc = dc;
+		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.lock = false;
+		block_sequence[*num_steps].params.dmub_hw_control_lock_fast_params.is_required = dc_state_is_fams2_in_use(dc, context);
+		block_sequence[*num_steps].func = DMUB_HW_CONTROL_LOCK_FAST;
 		(*num_steps)++;
 	}
 
@@ -1001,8 +1001,8 @@ void hwss_execute_sequence(struct dc *dc,
 					params->wait_for_dcc_meta_propagation_params.dc,
 					params->wait_for_dcc_meta_propagation_params.top_pipe_to_program);
 			break;
-		case DMUB_FAMS2_GLOBAL_CONTROL_LOCK_FAST:
-			dc->hwss.fams2_global_control_lock_fast(params);
+		case DMUB_HW_CONTROL_LOCK_FAST:
+			dc->hwss.dmub_hw_control_lock_fast(params);
 			break;
 		default:
 			ASSERT(false);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 625653ce5556..bcd83fc4b262 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1404,9 +1404,9 @@ void dcn401_prepare_bandwidth(struct dc *dc,
 	}
 
 	if (dc->debug.fams2_config.bits.enable) {
-		dcn401_fams2_global_control_lock(dc, context, true);
+		dcn401_dmub_hw_control_lock(dc, context, true);
 		dcn401_fams2_update_config(dc, context, false);
-		dcn401_fams2_global_control_lock(dc, context, false);
+		dcn401_dmub_hw_control_lock(dc, context, false);
 	}
 
 	if (p_state_change_support != context->bw_ctx.bw.dcn.clk.p_state_change_support) {
@@ -1425,9 +1425,9 @@ void dcn401_optimize_bandwidth(
 
 	/* enable fams2 if needed */
 	if (dc->debug.fams2_config.bits.enable) {
-		dcn401_fams2_global_control_lock(dc, context, true);
+		dcn401_dmub_hw_control_lock(dc, context, true);
 		dcn401_fams2_update_config(dc, context, true);
-		dcn401_fams2_global_control_lock(dc, context, false);
+		dcn401_dmub_hw_control_lock(dc, context, false);
 	}
 
 	/* program dchubbub watermarks */
@@ -1466,7 +1466,7 @@ void dcn401_optimize_bandwidth(
 	}
 }
 
-void dcn401_fams2_global_control_lock(struct dc *dc,
+void dcn401_dmub_hw_control_lock(struct dc *dc,
 		struct dc_state *context,
 		bool lock)
 {
@@ -1483,12 +1483,12 @@ void dcn401_fams2_global_control_lock(struct dc *dc,
 	dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
 }
 
-void dcn401_fams2_global_control_lock_fast(union block_sequence_params *params)
+void dcn401_dmub_hw_control_lock_fast(union block_sequence_params *params)
 {
-	struct dc *dc = params->fams2_global_control_lock_fast_params.dc;
-	bool lock = params->fams2_global_control_lock_fast_params.lock;
+	struct dc *dc = params->dmub_hw_control_lock_fast_params.dc;
+	bool lock = params->dmub_hw_control_lock_fast_params.lock;
 
-	if (params->fams2_global_control_lock_fast_params.is_required) {
+	if (params->dmub_hw_control_lock_fast_params.is_required) {
 		union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
 
 		hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 2621b7725267..9591657d8eee 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -73,11 +73,11 @@ void dcn401_optimize_bandwidth(
 		struct dc *dc,
 		struct dc_state *context);
 
-void dcn401_fams2_global_control_lock(struct dc *dc,
+void dcn401_dmub_hw_control_lock(struct dc *dc,
 		struct dc_state *context,
 		bool lock);
 void dcn401_fams2_update_config(struct dc *dc, struct dc_state *context, bool enable);
-void dcn401_fams2_global_control_lock_fast(union block_sequence_params *params);
+void dcn401_dmub_hw_control_lock_fast(union block_sequence_params *params);
 void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx, struct dc_link_settings *link_settings);
 void dcn401_hardware_release(struct dc *dc);
 void dcn401_update_odm(struct dc *dc, struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index d6e11b7e4fce..a221b8cb6d4d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -95,9 +95,9 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.apply_update_flags_for_phantom = dcn32_apply_update_flags_for_phantom,
 	.wait_for_dcc_meta_propagation = dcn401_wait_for_dcc_meta_propagation,
 	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
-	.fams2_global_control_lock = dcn401_fams2_global_control_lock,
+	.dmub_hw_control_lock = dcn401_dmub_hw_control_lock,
 	.fams2_update_config = dcn401_fams2_update_config,
-	.fams2_global_control_lock_fast = dcn401_fams2_global_control_lock_fast,
+	.dmub_hw_control_lock_fast = dcn401_dmub_hw_control_lock_fast,
 	.program_outstanding_updates = dcn401_program_outstanding_updates,
 	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
 	.detect_pipe_changes = dcn401_detect_pipe_changes,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 1723bbcf2c46..619ac4dfff07 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -148,7 +148,7 @@ struct wait_for_dcc_meta_propagation_params {
 	const struct pipe_ctx *top_pipe_to_program;
 };
 
-struct fams2_global_control_lock_fast_params {
+struct dmub_hw_control_lock_fast_params {
 	struct dc *dc;
 	bool is_required;
 	bool lock;
@@ -173,7 +173,7 @@ union block_sequence_params {
 	struct set_ocsc_default_params set_ocsc_default_params;
 	struct subvp_save_surf_addr subvp_save_surf_addr;
 	struct wait_for_dcc_meta_propagation_params wait_for_dcc_meta_propagation_params;
-	struct fams2_global_control_lock_fast_params fams2_global_control_lock_fast_params;
+	struct dmub_hw_control_lock_fast_params dmub_hw_control_lock_fast_params;
 };
 
 enum block_sequence_func {
@@ -195,7 +195,7 @@ enum block_sequence_func {
 	MPC_SET_OCSC_DEFAULT,
 	DMUB_SUBVP_SAVE_SURF_ADDR,
 	HUBP_WAIT_FOR_DCC_META_PROP,
-	DMUB_FAMS2_GLOBAL_CONTROL_LOCK_FAST,
+	DMUB_HW_CONTROL_LOCK_FAST,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
@@ -452,13 +452,13 @@ struct hw_sequencer_funcs {
 			const struct dc_state *new_ctx);
 	void (*wait_for_dcc_meta_propagation)(const struct dc *dc,
 		const struct pipe_ctx *top_pipe_to_program);
-	void (*fams2_global_control_lock)(struct dc *dc,
+	void (*dmub_hw_control_lock)(struct dc *dc,
 			struct dc_state *context,
 			bool lock);
 	void (*fams2_update_config)(struct dc *dc,
 			struct dc_state *context,
 			bool enable);
-	void (*fams2_global_control_lock_fast)(union block_sequence_params *params);
+	void (*dmub_hw_control_lock_fast)(union block_sequence_params *params);
 	void (*set_long_vtotal)(struct pipe_ctx **pipe_ctx, int num_pipes, uint32_t v_total_min, uint32_t v_total_max);
 	void (*program_outstanding_updates)(struct dc *dc,
 			struct dc_state *context);
-- 
2.34.1

