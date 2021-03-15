Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AECAC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B119164DDF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B119164DDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE7989933;
	Mon, 15 Mar 2021 11:22:37 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B9689933
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/qzfSne3XyC/jObafFLaiwAIF6f+qZ/i+nfug0ytzVxJsPFhRr33vvr6wuI1AZfHfGtLeyvGwrXwR79ABPRqYXT+esOJPY2BsTKUS5MObEvgGLArk59A/y9sGrO6qwGOFB4xbKw+y/+EXPsMsdCpJdicPL02Pz1HxGc0WIvoCEmmZD5qWm4FMIZKuju+7sI6GHpgiud57WYddSfyzvv3gsKM52wi6QDUxWFwkw66aKB+fNmx8p8Bxx8yt2syZs3UQkUXg84ZtwfOsq6XQMlT1yXGjp2bq1xENU3c3wbFaUw+ZaIAqPcH9+i/Vt18j9KZEdvFffHueyLly1L/da9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKhYeg1+wTtbyerBv7alb8LLUZTVpKp5SDr4Di9idp8=;
 b=kMQCJ524eFZTVhUb98UDA2I8KdUBFBtDVnxxRL7BZBstDvmX/kR/ZFnvUCOELCZ4zlXJJaoWpEZniCB2cnQ/ALOKoUgJye4SrUnYvcaDovOfof8iaU3BKSpl9WlwzZO8jwZHIoIN0MTa4zsdKSKuPl2NBKKzenQjuzoneo/dNnw+lGQuKDY7GDu9FwtU7tCck9RRrIVtFZlgGN+U7IKYhml52pTvgrnvekIpyqZwDy8UaHAZnMP0Vri6qMbXLy1Qv1vgsYzvDfQ867hMJxOrAJvIGGtN89chT1/2niCixWKCRV7NKwMQeml7oWyvDBeireUg6L1/qsf9xzPy/HJtMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKhYeg1+wTtbyerBv7alb8LLUZTVpKp5SDr4Di9idp8=;
 b=D3OqUo81k4/oT3+P1o7iJqpDul3w68nNBo3mipyLkAClCcWp3n+IxCbtEGfgEEJ6N+7TZl/tvWwr+dzQZIrFMOFQ7NeoHTPleoyUIYXDcN9WElUST5pYj5ydbuiOAcxkbcAhesfES4Pzxuw0YnzVsQ7SOirFr9lwz6YAglrPD+A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB3740.namprd12.prod.outlook.com (2603:10b6:5:1c3::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:22:32 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:22:32 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/23] drm/amd/display: System black screen hangs on driver
 load
Date: Mon, 15 Mar 2021 09:39:51 +0800
Message-Id: <20210315014010.16238-5-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:22:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b784161-e2ba-4e87-1b66-08d8e7a4a060
X-MS-TrafficTypeDiagnostic: DM6PR12MB3740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB374000917EC3AA2514AE59CF976C9@DM6PR12MB3740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIlsermf6I+tDOpMXhtHfJD5QZDwkT/oVSTTIWwGuHd4OqCGU46ZtOE7aRxwg9ekzat1hKC4cnDzg2FX7Ci9LKdTZht3JqQVrlUfEg8/tTCZt3e5k7F56Q0eu7h/ULXYzugEno5W0BkN7z2D1mIAm+qrClWXvKnuWtKD/S76fH1xfia6SQuN3cEJcoSb4HsDcMRloqBGI+US5sgJKmYRVS9BjY4nxHOt8Iam7sFy+3mmRgvWpTSIGJBMIBBTc+Vzzw1fMHZMEBK7JB5DUP7blqbs9Nldbn3s6YzbMaOzkHdOagLyNRMOA64yrHECJnCD/7Q2U6/FYKOhaNEgZ+ROSUMHXJ8QAf13TgREh9rjpf6tAiwbAmLoFgMqh9U+dIovZH269LFHIUFi95pZZtob7PvqADHyWhoyPzFFs6HCALaiCzjhst0ugz6S5gLWDW1vDS9QFKD0v0Fzl2p6apM5futZ0+JARU4zpgBNxVhbpMvXuLKavFgj8YMVLiAqlQlMqqV01uUupFsGPs+oDo8jyREcy+Ho2TGEjg5SwZHIkAmeCfA11v8bzs0FwL5aBGd8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(186003)(6486002)(6512007)(36756003)(6506007)(86362001)(4326008)(66946007)(16526019)(6666004)(66476007)(66556008)(6916009)(26005)(8676002)(478600001)(956004)(5660300002)(54906003)(2906002)(316002)(83380400001)(44832011)(52116002)(1076003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xFk26LZHTS3D4XEan6qbA3l/FCDEpLbeHWwU9a7AiYTV9ylDOmHwIgEHcr8Q?=
 =?us-ascii?Q?qLwhO6ssrNZ9gAnDEr+QN3VZhOcD967UJI8ymj1QlVjheYGTEzW3+eEDr/d9?=
 =?us-ascii?Q?ZNcV3NKz2lfFbrNhU2NgPGvtvctc4zBHTvEOABh2AgClsE7HdMaxC99YmT3+?=
 =?us-ascii?Q?j09OCyJcesMuNmJYNiNKWTPyKXPWbnTXaL075iccAczxdfHRIvFFwawxVrGA?=
 =?us-ascii?Q?Zk/Q4iztWJz8bzIsDq6KrpViqosirqjfI9OVgpWSRQUAN9XLo3+VZy6rjKq9?=
 =?us-ascii?Q?IZFoSRILCsF3pLSGMQ0Tip2I7+jbfZotFYIRY1tg96N4H/rhZXHrj991dAe+?=
 =?us-ascii?Q?psdhb844emMv+9BcSwu+RZBV/oy9kZGLs+0x8WjaKtLZzQ4YH7G9HMbuUBqw?=
 =?us-ascii?Q?DbvlfiuD6RBHNL7eM/jtqi/3fhImNDCoUtzBqh+fUc3ejBomO3caPqlwNhbt?=
 =?us-ascii?Q?aKK8emw9wTC546bzKQnHEDHHIkClH6ftIOG8ln8Td5xGVNvje+SgDZz5Zodl?=
 =?us-ascii?Q?Nk2vt7Knj852pUGgyeYkL/XGEeJovdoQERY2mOy3OeAPLwRi6Bg0JiGyrw83?=
 =?us-ascii?Q?ArlZLU3BNomOdH1YgCYokx11xxRyv4SnENdhqy2EPtgYmlurAZRu+Rz66RhF?=
 =?us-ascii?Q?po17XzWTueYvPh8oqji9KqtJ0hFzC6eiGc/OGUSBsPD2x233m2YzcCvbLAFL?=
 =?us-ascii?Q?7KHj7GaVezQSTYx8/NSzZktDyopTIs5PE+uyWRXDo2MuST3aOaFpxAd0fefa?=
 =?us-ascii?Q?1IDyWt4Lr+d+LDTXT1TvoMaNPE+Hz8yeSTdTAiUwT0dIJCwI3xph5gXuJ73m?=
 =?us-ascii?Q?sOq3IqIMP/FRUhEOM2n6QCCtS+pesZvgAoljjgg09cFj3rcbYPH+XcikETAl?=
 =?us-ascii?Q?wQ76k8Z/olp78IK6qVo7sgDTh41yUvo27NWxHhZIRdYiSzcXKgx1mqL8UXeC?=
 =?us-ascii?Q?9sMhudPWkoDGSgfhQ8MfSVngjVcaYqXgOC+wXHo2N2O/gtO5eKQ9qFpMcTrD?=
 =?us-ascii?Q?wMIuz7lp/i5n9GfdfZRBc/qY6s/f6k1m5aqtmnU9dHKaQuSm8YXMnLS2S8hq?=
 =?us-ascii?Q?RUjDBrY4zZ993ZeAXRGioO8Zq4LSsvpWyBumOo5ZrxfdElLFjgjVOiby11Ox?=
 =?us-ascii?Q?LSKIQmtuMavUHxt7G8TKROkey/+qS0voQKEWh/EMpxqF4Wa2wYrGhtk9/Evi?=
 =?us-ascii?Q?IAmoEfAkj7B4LAJhueXKYg0ned5E666eWDwd2EaQdwvFeVsXQ/7NYtPtXhCS?=
 =?us-ascii?Q?1mr6XeWYBWpJIaUktfKtHUNmxI8ia/WOT1KNImaUHWkicJnJIRpwaNqR9Nwi?=
 =?us-ascii?Q?b607OT1+wL1sL/DNb6IXEGAj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b784161-e2ba-4e87-1b66-08d8e7a4a060
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:22:32.6709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdD28RKCo0N6eVw+o390urBWXUIexb3UjqBBNygiIHQzGwihfDox+nwweRhT3hRErvVlL9spJ+SuWcZ7KdO5sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This reverts commit bea6beb76a9f19a9a86d24d304f27b3cff5f1791
as it causes crash on driver load in some scenarios.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 48 +------------------
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 -
 2 files changed, 2 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 3946d12e9fb1..01b1853b7750 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -761,43 +761,6 @@ static struct wm_table ddr4_wm_table_rn = {
 	}
 };
 
-static struct wm_table ddr4_1R_wm_table_rn = {
-	.entries = {
-		{
-			.wm_inst = WM_A,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 13.90,
-			.sr_enter_plus_exit_time_us = 14.80,
-			.valid = true,
-		},
-		{
-			.wm_inst = WM_B,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 13.90,
-			.sr_enter_plus_exit_time_us = 14.80,
-			.valid = true,
-		},
-		{
-			.wm_inst = WM_C,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 13.90,
-			.sr_enter_plus_exit_time_us = 14.80,
-			.valid = true,
-		},
-		{
-			.wm_inst = WM_D,
-			.wm_type = WM_TYPE_PSTATE_CHG,
-			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 13.90,
-			.sr_enter_plus_exit_time_us = 14.80,
-			.valid = true,
-		},
-	}
-};
-
 static struct wm_table lpddr4_wm_table_rn = {
 	.entries = {
 		{
@@ -969,12 +932,8 @@ void rn_clk_mgr_construct(
 		} else {
 			if (is_green_sardine)
 				rn_bw_params.wm_table = ddr4_wm_table_gs;
-			else {
-				if (ctx->dc->config.is_single_rank_dimm)
-					rn_bw_params.wm_table = ddr4_1R_wm_table_rn;
-				else
-					rn_bw_params.wm_table = ddr4_wm_table_rn;
-			}
+			else
+				rn_bw_params.wm_table = ddr4_wm_table_rn;
 		}
 		/* Saved clocks configured at boot for debug purposes */
 		rn_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
@@ -992,9 +951,6 @@ void rn_clk_mgr_construct(
 		if (status == PP_SMU_RESULT_OK &&
 		    ctx->dc_bios && ctx->dc_bios->integrated_info) {
 			rn_clk_mgr_helper_populate_bw_params (clk_mgr->base.bw_params, &clock_table, ctx->dc_bios->integrated_info);
-			/* treat memory config as single channel if memory is asymmetrics. */
-			if (ctx->dc->config.is_asymmetric_memory)
-				clk_mgr->base.bw_params->num_channels = 1;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 153093abafbd..2088508dac1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -307,8 +307,6 @@ struct dc_config {
 #endif
 	uint64_t vblank_alignment_dto_params;
 	uint8_t  vblank_alignment_max_frame_time_diff;
-	bool is_asymmetric_memory;
-	bool is_single_rank_dimm;
 };
 
 enum visual_confirm {
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
