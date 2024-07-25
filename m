Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C53C3DA61
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 02:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C797E10E02C;
	Thu, 25 Jul 2024 02:54:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kXged+3B";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BEE010E02C
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 02:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ke2KZIK+rNdzshE4ocWTC/dHf9PpCjXWwBZq9qtKEM/HUZgoKBeHgvl8MDdIB8JGFPGY0Ey0+zeDFJS7/2GADsSGyN1VtKaFpTYW9Jz+d027kmmSoHAiX6ZAO9FD12xGe6ZchNG8JuHvaTSi7IcqIPITZtlCKai/93eTQktCE809v5QUqHOTJZFBGDvHRcD8+idbandp5GSRLUHS/Hs+P7FY8vloFpY4twIdVULNOytwSPt3xu4UuTy8d4pdEApdncWAXAXUsJEJpGM223RiDNiVjX2yaPPlzdDRrieOFDb/QkhG/b4L42USsyf1VAD3D912ZZo/WRfiQIYqptjjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69zFYI0R250AfvRzcCU4lsr6ELJQJZuH2sSAyeiAYQg=;
 b=YU/HE6XZnVsxLKsOW7vOLPJhATRqGoYpjul0Jfd9CZ0DHho+urbPozw1cPdD+OcEAJe9r9w0g9mvjK2x0XAE8ULXTRBn516OaeZXCpqZoVHcZ23XBTteJ7cHjhk+iFO0mqEaNbze/wEWvlJzA4GPWR5MEAGW+rt2/XPmOBXJmKiqi+pqp3vKDrDmPxrSACgW9zzFZ9mjOHR9MKwQJTcboXMgmD0LYXYOWpXr1LGqjKqdGRqdTCiQTlHsaU+ty8nUxWUjbOe9p3ahMk8OTwuV2EI9YgYAGb+ccFB+1MD/mWc+w/+S/KnbTsuy3ldt4zqXh9yMuqW2qGv5986LwprfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69zFYI0R250AfvRzcCU4lsr6ELJQJZuH2sSAyeiAYQg=;
 b=kXged+3B55YNg9kCAZy7xSFnWrc3c95MoNron4i03qv/OXuNrlWXWI6IoKt2kZaycF0PGvEtJXjaMzNfrYcw8z1XVqeKUoeMuVzdiuQ/PMCPUT1RBnfqRaIBxYah6ZCCfipvOO4C64m1knXpFwFuBqQlZ4R9JR3u657I2ujPyTU=
Received: from BN0PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:e8::18)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 02:54:40 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::6c) by BN0PR04CA0043.outlook.office365.com
 (2603:10b6:408:e8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 02:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 02:54:40 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 21:54:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Add null check for pipe_ctx->plane_state in
 dcn20_program_pipe
Date: Thu, 25 Jul 2024 08:24:08 +0530
Message-ID: <20240725025409.1507764-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a433b6c-b5fc-4305-2307-08dcac5520bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2GsGkV9N2c/WUhW6LZqhdf9/EUm4iamo8xf72bD1QBgFMTzmT3vOIdwjCy58?=
 =?us-ascii?Q?cUzAlgzjs9n/RJPF64aBFvUouI6kRhK565iSZvWhf7d1YFkdPV758GFMfPrY?=
 =?us-ascii?Q?aOi3oXOnQLHCMV9HV1tqgto2rXyrCr9BIfjWe5UkmdOewM1KDVpfT0ZNEfTp?=
 =?us-ascii?Q?wQvf23b2OrtE7iWvEN+luEb9yR+L4t1Mx4yvTlj2NW2XKxQXNQ06Sqn4k118?=
 =?us-ascii?Q?rXKhPkEFcPdXK3pE158YRhFewD+aSbmLimTfGWIZhmzyYqD1yKKFZ09S/k5q?=
 =?us-ascii?Q?9baN9OwkwmQfTKbj3zvv7TIl2CkTcHsLaxAy8dDf4T6QbPUthC++zHeb6PUw?=
 =?us-ascii?Q?/9DoN9EHGGUI9I5m9DmJGK3qeJu81QCON1Jx1b1JdODycke4j/xt/Hth8km6?=
 =?us-ascii?Q?/gNu5nLuTuU7u9au0jrsd4N9DkpmymL4WM9wbx0d62fUNbaMx0nRJDDC4xYw?=
 =?us-ascii?Q?RnpFi/MPaQlKg3T+IcKdFI8tzPfgHYWVLUNtqzhrEcTMnXvfXPIWU6em/qY2?=
 =?us-ascii?Q?KAWUNh6fLeBAzNUidzMVVsMFomEr4nNiJWC+inviLIaulIZsGWEj9ALU6VaF?=
 =?us-ascii?Q?CQZi3fWjkKL8JvzlWIW05ebChYPsWqP0+kVTGWLiXWPGUFGF55wZ8YmML6uW?=
 =?us-ascii?Q?ciNW2fiztQKXr8udws/odJw29Fl77sK2u8DuCByt2b2geCsh+1dN+HpJeGNf?=
 =?us-ascii?Q?4YlEOC6z9C0g6HAWyPptcvP7MhUGD35HKCpX76SmvAVMyHXEPsw0Kmc+H2ug?=
 =?us-ascii?Q?mvkFMFU4r/nElOjihJh5z4NvRTx3CLFWfcMrY4Bp4Z3ILLVXNFCXXsHHD2MB?=
 =?us-ascii?Q?TEJ4/2X6/o3crbBvURLEFIO/iH9yvReOo95rIoX+sPxeIbyG29OVxVRAbTXm?=
 =?us-ascii?Q?3cWQqVA0KdCEa7KL7shArI60n9w7vgT90QLynmc1WGtCIBJNpbeHoZoUXhp5?=
 =?us-ascii?Q?N36HH4HEjtGanFp/cLOh+rDC1KsRRtnrsrefZm2hXQJF62qLZ6rJmXRGV31B?=
 =?us-ascii?Q?bEoUKfQmVKhavE8N9oK9h26nGxoQkmWCnoS2HGD4uxRly62ahYoALA7u3IVw?=
 =?us-ascii?Q?SxWqczhbxcSJdqKRa/OnzhLNT3a57PgkUyiLVJ7OEISpp8eSuTjMO4CzMzoG?=
 =?us-ascii?Q?QgKvH6/wsH/AQYxz2SfR+VAKZLS8H18QJKI3wBBAqGTzKkpGZVniavcNloRJ?=
 =?us-ascii?Q?sKAJ5fZL4opx9hgEbXV+Whq6jdscC6DAKs+xFATmDzcHl3ThsgQrXdxeCRZZ?=
 =?us-ascii?Q?eP/1qWOREdY6vDgjXhSE8Ra8hK7OY185AJaEsLvHI/JxfrELNeEd1Vv6e726?=
 =?us-ascii?Q?v9HHFhb06nijyOncBqm0LV7ON3MgKgLjAqyVKIvhaq2hKueurBA/WgGUHGDb?=
 =?us-ascii?Q?gzzB5OyjFgJID9tej44+5d6GS+QMSxVRBRTPhaaRmB2CiI7nLHvRVkpg2f0x?=
 =?us-ascii?Q?wqS7c6GxrMxAuUtIOvdozJTOzN2OR2mG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 02:54:40.0475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a433b6c-b5fc-4305-2307-08dcac5520bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
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

This commit addresses a null pointer dereference issue in the
`dcn20_program_pipe` function. The issue could occur when
`pipe_ctx->plane_state` is null.

The fix adds a check to ensure `pipe_ctx->plane_state` is not null
before accessing. This prevents a null pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn20/dcn20_hwseq.c:1925 dcn20_program_pipe() error: we previously assumed 'pipe_ctx->plane_state' could be null (see line 1877)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 30 ++++++++++++-------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 270e337ae27b..5a6064999033 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1922,22 +1922,29 @@ static void dcn20_program_pipe(
 				dc->res_pool->hubbub, pipe_ctx->plane_res.hubp->inst, pipe_ctx->hubp_regs.det_size);
 	}
 
-	if (pipe_ctx->update_flags.raw || pipe_ctx->plane_state->update_flags.raw || pipe_ctx->stream->update_flags.raw)
+	if (pipe_ctx->update_flags.raw ||
+	    (pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.raw) ||
+	    pipe_ctx->stream->update_flags.raw)
 		dcn20_update_dchubp_dpp(dc, pipe_ctx, context);
 
-	if (pipe_ctx->update_flags.bits.enable
-			|| pipe_ctx->plane_state->update_flags.bits.hdr_mult)
+	if (pipe_ctx->update_flags.bits.enable ||
+	    (pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.bits.hdr_mult))
 		hws->funcs.set_hdr_multiplier(pipe_ctx);
 
 	if (hws->funcs.populate_mcm_luts) {
-		hws->funcs.populate_mcm_luts(dc, pipe_ctx, pipe_ctx->plane_state->mcm_luts,
-				pipe_ctx->plane_state->lut_bank_a);
-		pipe_ctx->plane_state->lut_bank_a = !pipe_ctx->plane_state->lut_bank_a;
+		if (pipe_ctx->plane_state) {
+			hws->funcs.populate_mcm_luts(dc, pipe_ctx, pipe_ctx->plane_state->mcm_luts,
+						     pipe_ctx->plane_state->lut_bank_a);
+			pipe_ctx->plane_state->lut_bank_a = !pipe_ctx->plane_state->lut_bank_a;
+		}
 	}
 	if (pipe_ctx->update_flags.bits.enable ||
-	    pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
-	    pipe_ctx->plane_state->update_flags.bits.gamma_change ||
-	    pipe_ctx->plane_state->update_flags.bits.lut_3d)
+	    (pipe_ctx->plane_state &&
+	     pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change) ||
+	    (pipe_ctx->plane_state &&
+	     pipe_ctx->plane_state->update_flags.bits.gamma_change) ||
+	    (pipe_ctx->plane_state &&
+	     pipe_ctx->plane_state->update_flags.bits.lut_3d))
 		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
 
 	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
@@ -1947,7 +1954,8 @@ static void dcn20_program_pipe(
 	if (pipe_ctx->update_flags.bits.enable ||
 			pipe_ctx->update_flags.bits.plane_changed ||
 			pipe_ctx->stream->update_flags.bits.out_tf ||
-			pipe_ctx->plane_state->update_flags.bits.output_tf_change)
+			(pipe_ctx->plane_state &&
+			 pipe_ctx->plane_state->update_flags.bits.output_tf_change))
 		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
 
 	/* If the pipe has been enabled or has a different opp, we
@@ -1971,7 +1979,7 @@ static void dcn20_program_pipe(
 	}
 
 	/* Set ABM pipe after other pipe configurations done */
-	if (pipe_ctx->plane_state->visible) {
+	if ((pipe_ctx->plane_state && pipe_ctx->plane_state->visible)) {
 		if (pipe_ctx->stream_res.abm) {
 			dc->hwss.set_pipe(pipe_ctx);
 			pipe_ctx->stream_res.abm->funcs->set_abm_level(pipe_ctx->stream_res.abm,
-- 
2.34.1

