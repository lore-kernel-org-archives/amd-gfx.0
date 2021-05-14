Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA94C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D34261447
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D34261447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 611306E1E0;
	Fri, 14 May 2021 04:50:39 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B7286E1E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTtS8DlCP1eJw7WtYN7I/spZOIErVBKbn/1NDTcp2kzuTMfkssN7afEsZRy2kOxytVWsaoPQWsWbedE7wEEca2e6Q/ORyYAqgpW61nKlXbCncIqwVnJr15bdqU3WJLdv9ep9vNbIaa5YMc8PaWJ1aC4pKtcqEjXGUZZhKhOEiRAEASwh2onQL9XAXL5/FIa5B14gsPDilx7P5JOByvtE36oB/ikuCD3db/FU/eCxbQqGKyVgYr6a5/k+hNpLGZTGYaxL8RglicR9t+8tYs2X/R1sPX9Q3BLTSvaJqWPXx8N/JCnEc5lmf9t+b6rUz2oTkLM1qNG1tkcTf708V+tBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cC1SdZbUSkimeEq+WNiEzEikZ4KwF5QUMiTQI1roY3o=;
 b=CyZ68q7sO+22/PAbPFT1ThWbId/rETFHrfIgMWZeCujTVF6Lvk8j9NLX3JiStPPEGdbqcuFfxe9+f5rSIxGN1v+UO3H2dXI592FozlXDY5M16vn2maC0xY2NUH3rRSignziNGSxq06kdZav2VhoIb2Q4fCzwnYE7pBAfaY5rK54XaAxLBHMY5SZXFYuLOYYpcbt0bbN4hCa3HY64kxVfasWiNMzkESNW0uQzCR6dnZAxCc6gXX22uFeR7t+cGfokapASxVu02dJcEZR4pdSaHlew/zctVrPJCAvavcgtq6HaRnGtfh0hkK0E7p1fURVdtVVc9t/Mgot+6+BNWTXTQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cC1SdZbUSkimeEq+WNiEzEikZ4KwF5QUMiTQI1roY3o=;
 b=nlj3gDUWrHQxiyaPeTZmFkLDkkMhjdA3CapX+/nVMzPrfz4BwTWxtr1Br2o5ApIs5Jl4KWvL+QaPv5ACL13F0l1sWA/BfFtLOKJ8AvXjG2ghrg6t7o2DpM8gJlNo+eJ46oa0g8ut2+ronXKUq14jS90AsMBWRA/5AU9ts9Cc2C0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:50:36 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:50:36 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/20] drm/amd/display: Add get_current_time interface to
 dmub_srv
Date: Fri, 14 May 2021 12:49:45 +0800
Message-Id: <20210514045003.3069681-3-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:50:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfb3412f-ea06-4eef-6104-08d91693d053
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31291447F7E74A5350F37E7EFF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7GISm8R37rO6CHkO3huIrr2b6GWl/Rg+ywXiQQIus44Sdip+mwGd0h2FR/6bePhM0TcfTEufo+3eTdTuwpECYNu1U3J5dW+H0dg6LDgEqMDV/42yfOSll9W84BhlZlkzw0U3a2KBniOsQW0USOl9wIcrp2K8a+gq6Gj2f6sahpv9FYGEPydhahAROqZFtfpcNC/WgomxtAnx1rSfRX5XIifHU3A5kYW/H21KUOAfUziZF9o8AzApOs2ncgZjmCk/Nnk8aOBdLRUvB9X2tALk2tWCvCQG3lCWVINrv43GGPWZIOIV8z8cp6wSWkun3ONk/5FvygjFXUzVIjWNm9C1LIvN4Zgs7kiHssCU8YSJwIfCuXYT0hYarEdkpck40RrgjrAv639erO+W6HU0Frnccv4zGR6FuAoQlqmAo5DlDa+WRF6Vl/SPI2oNdhEof6LKXncRr7AMy5NulmDnAviP+aizoChFCnv7B+ES1hxr4yHzygrD9yKHgEbjDmtgDPZ0iekEZfXdbpsKAVCDiY5XYfFLr1uwVJ1IOoeW/ym7Rq1FWsdgKaG973M5Nh66EF1+5ivjNbqZm7dr4Uvs3FOjzM2FSFiH2mIIQTDE02ada4ygB+SsF9ps0Yzcl0ALtylytHlsNHvxnVJxym1DoU3D355pnEsksmauyRbX8Ztwm6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8676002)(316002)(478600001)(83380400001)(26005)(956004)(86362001)(54906003)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8YOR9wMd3Om7+Vgh9bf5/O/qiAzaa/Kv4yJZFRQCdNOQy8t0qUUSLNbjlc36?=
 =?us-ascii?Q?LPeGgCz0aFdeFbnJB1+Rj0QLGwEkd8mqXIs7bgZBiWBrj2ed8mbmCAEgVeTu?=
 =?us-ascii?Q?O3QV6X1aOzKe6r9SUCPX6zauRSS8zn8bWS+FKGOFchwwTq6upPFNk+QsNlkc?=
 =?us-ascii?Q?PbN8Is9KKvZ8MXApE9JlAANeLt6CpgY6aoePqcEoicT2YoVrVTg46QphUaTI?=
 =?us-ascii?Q?xa/2GmpyVxA4oLMhZN85Jgp1Y1VjoVmWZgILyxJz/zGqrrQhG6U4fhtY6CND?=
 =?us-ascii?Q?xXVV6FWBKJWO+5DYRhCXR8oACE51425LrxPJWs8cK7PdGjibBHKtnWqMVUd5?=
 =?us-ascii?Q?MLOhEDzeJILcE9dc9eeu1nGibkSP3Si0xDj40y83krT0uop61PDVVDjvMjse?=
 =?us-ascii?Q?vlSjM1H6d02W6hnPX+cBbvtmiNKYN6IXSM1CVRKJkuuFk/z8PpWheMq1hZ3Y?=
 =?us-ascii?Q?ogA0LPvuCmwadORPWelKhvzaaAS/eagLRKqvePNGNjOXUgVixYTKr57SgiBY?=
 =?us-ascii?Q?f8+iRnX41yol9lqUwkm+dI5CQLfZ2CGSllvwx25Xkk/PrdFR9NAXhGzkpX9R?=
 =?us-ascii?Q?jjWRjvKpYrtFk3hI0bOji1lWjnExOgJrpb6Qoje4g3En2sB2V3T7IqedRaTB?=
 =?us-ascii?Q?++IeYL8Z/z8flVomAytsrIon0Bic9E42DvidMt4j9k3YwHSVqBSQR4lS/1R6?=
 =?us-ascii?Q?O0R4GnImJ4ekkX7CETq3rS8BE4A5oIde1AEo25llqz7ibT9SPcad/OwI3pQg?=
 =?us-ascii?Q?grvuxbamUzIKv8wDndy9BddXBpCjkFNj9jTTnpMNIkVVPjWNIZ2Ijwi0mHNn?=
 =?us-ascii?Q?Mcr2KgGtjKsa99zeRAScjQ5nY/vviXkCpIPcEDGmtaDNqhphqv9D+wPHNiPu?=
 =?us-ascii?Q?N2243cBVBu1Id0QHZ4nM3+vvWmXEEzEQxwwIitKuHwrcF5PjQVAlPVh2i2Tx?=
 =?us-ascii?Q?ZrjgZ1g5xhU+lmVCGPTsOYKbaBSaP3gNdlAVj2KHgbWri/2raJW3UlJcx0dT?=
 =?us-ascii?Q?4loSyZNb++1JAsJUKKQL0DhxuQlmD0QgE1vrULLFMn6tb7V3tvK6fi27kGTC?=
 =?us-ascii?Q?yauqTz0L+JueZk94G93HR6i0ukwR1EiPMly7wd3ngP1XbClK96j7EGqjfuu9?=
 =?us-ascii?Q?29uAYtGbaYdkeblYfeVJxdQSW+glbn2pKOarU0qYEGMaff5377gSJ5hSIaZn?=
 =?us-ascii?Q?cPswlcpjD7AcKL7V5FFmGOEi3PqJWxX7cdqANNsAfEn8y9twyC6+5tT378Ah?=
 =?us-ascii?Q?a2jLlw8SXIZev0fgLYgMx0g0kGHDxc/aD7XGGa/cgDObUYU0eV9m0wuTVF7E?=
 =?us-ascii?Q?2V6/bvjPxT/xihZgHHTSz/Ys?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb3412f-ea06-4eef-6104-08d91693d053
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:50:36.3123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ABm9PeGT946DhIH025/oUu4VAaTAUzUwnRioEv3v2/CDsWtgRQMfYEatjcXk0SvHMrgpzA1tWMkolLz0hnEzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: Stylon Wang <stylon.wang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Wyatt Wood <wyatt.wood@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Need to get current DMUB time.

[How]
Add get_current_time interface to dmub_srv.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 39 ++++++++++---------
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |  8 ++--
 drivers/gpu/drm/amd/display/dc/dm_services.h  |  1 -
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  5 +++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |  5 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  1 +
 7 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d6f11dbf1bd4..b4aa20250301 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2636,14 +2636,14 @@ static void commit_planes_for_stream(struct dc *dc,
 						top_pipe_to_program->stream_res.tg);
 		}
 
-	if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
-		dc->hwss.interdependent_update_lock(dc, context, true);
-	else
-		/* Lock the top pipe while updating plane addrs, since freesync requires
-		 *  plane addr update event triggers to be synchronized.
-		 *  top_pipe_to_program is expected to never be NULL
-		 */
-		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
+		if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
+			dc->hwss.interdependent_update_lock(dc, context, true);
+		else
+			/* Lock the top pipe while updating plane addrs, since freesync requires
+			 *  plane addr update event triggers to be synchronized.
+			 *  top_pipe_to_program is expected to never be NULL
+			 */
+			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
 
 	// Stream updates
 	if (stream_update)
@@ -2659,11 +2659,10 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (dc->hwss.program_front_end_for_ctx)
 			dc->hwss.program_front_end_for_ctx(dc, context);
 
-		if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
-			dc->hwss.interdependent_update_lock(dc, context, false);
-		else
-			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
-
+			if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
+				dc->hwss.interdependent_update_lock(dc, context, false);
+			else
+				dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
 		dc->hwss.post_unlock_program_front_end(dc, context);
 		return;
 	}
@@ -2764,6 +2763,7 @@ static void commit_planes_for_stream(struct dc *dc,
 							plane_state->flip_immediate);
 				}
 			}
+
 		/* Perform requested Updates */
 		for (i = 0; i < surface_count; i++) {
 			struct dc_plane_state *plane_state = srf_updates[i].surface;
@@ -2786,12 +2786,13 @@ static void commit_planes_for_stream(struct dc *dc,
 					dc->hwss.update_plane_addr(dc, pipe_ctx);
 			}
 		}
+
 	}
 
-	if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
-		dc->hwss.interdependent_update_lock(dc, context, false);
-	else
-		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
+		if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
+			dc->hwss.interdependent_update_lock(dc, context, false);
+		else
+			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
 
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
@@ -2837,8 +2838,8 @@ static void commit_planes_for_stream(struct dc *dc,
 				pipe_ctx->plane_state->skip_manual_trigger)
 			continue;
 
-		if (pipe_ctx->stream_res.tg->funcs->program_manual_trigger)
-			pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
+			if (pipe_ctx->stream_res.tg->funcs->program_manual_trigger)
+				pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index b0c9180b808f..e7c56df8f762 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -795,10 +795,10 @@ bool hubp21_program_surface_flip_and_addr(
 	flip_regs.tmz_surface = address->tmz_surface;
 	flip_regs.immediate = flip_immediate;
 
-	if (hubp->ctx->dc->debug.enable_dmcub_surface_flip && address->type == PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
-		dmcub_PLAT_54186_wa(hubp, &flip_regs);
-	else
-		program_surface_flip_and_addr(hubp, &flip_regs);
+		if (hubp->ctx->dc->debug.enable_dmcub_surface_flip && address->type == PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
+			dmcub_PLAT_54186_wa(hubp, &flip_regs);
+		else
+			program_surface_flip_and_addr(hubp, &flip_regs);
 
 	hubp->request_address = *address;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
index 9a3f2a44f882..7a3beaecd19d 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
@@ -264,7 +264,6 @@ static inline unsigned long long dm_get_timestamp(struct dc_context *ctx)
 unsigned long long dm_get_elapse_time_in_ns(struct dc_context *ctx,
 		unsigned long long current_time_stamp,
 		unsigned long long last_time_stamp);
-
 /*
  * performance tracing
  */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 3ef6b536ccea..deff333e7437 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -323,6 +323,7 @@ struct dmub_srv_hw_funcs {
 
 	uint32_t (*get_gpint_response)(struct dmub_srv *dmub);
 
+	uint32_t (*get_current_time)(struct dmub_srv *dmub);
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index b11f530f682c..8cdc1c75394e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -399,3 +399,8 @@ void dmub_dcn20_skip_dmub_panel_power_sequence(struct dmub_srv *dmub, bool skip)
 	boot_options.bits.skip_phy_init_panel_sequence = skip;
 	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
 }
+
+uint32_t dmub_dcn20_get_current_time(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_TIMER_CURRENT);
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index 42d610a260ef..f772f8b348ea 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -107,7 +107,8 @@ struct dmub_srv;
 	DMUB_SR(MMHUBBUB_SOFT_RESET) \
 	DMUB_SR(DCN_VM_FB_LOCATION_BASE) \
 	DMUB_SR(DCN_VM_FB_OFFSET) \
-	DMUB_SR(DMCUB_INTERRUPT_ACK)
+	DMUB_SR(DMCUB_INTERRUPT_ACK) \
+	DMUB_SR(DMCUB_TIMER_CURRENT)
 
 #define DMUB_COMMON_FIELDS() \
 	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
@@ -231,4 +232,6 @@ bool dmub_dcn20_use_cached_inbox(struct dmub_srv *dmub);
 
 bool dmub_dcn20_use_cached_trace_buffer(struct dmub_srv *dmub);
 
+uint32_t dmub_dcn20_get_current_time(struct dmub_srv *dmub);
+
 #endif /* _DMUB_DCN20_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index ed9fa6138aa6..fa89ada1e313 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -159,6 +159,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->get_fw_status = dmub_dcn20_get_fw_boot_status;
 		funcs->enable_dmub_boot_options = dmub_dcn20_enable_dmub_boot_options;
 		funcs->skip_dmub_panel_power_sequence = dmub_dcn20_skip_dmub_panel_power_sequence;
+		funcs->get_current_time = dmub_dcn20_get_current_time;
 
 		// Out mailbox register access functions for RN and above
 		funcs->setup_out_mailbox = dmub_dcn20_setup_out_mailbox;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
