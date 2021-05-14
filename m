Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BC3C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F78E61184
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F78E61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41EBE6E1A4;
	Fri, 14 May 2021 04:50:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C0A6E1A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adcnnSvu1/S0YkpAybScyZl/IbzgHyU52Elt0wlM+GwfSX/cMa2m0C+KizKbOlEAkx91lyBiKbXtm7q9WEJVCCgUhsKCrJ/jU9GZqBPCkN2euq7Qs/y11YS7YaGwTeUXSfO9S4/GukeqURU5yy/gj/qf2hAdLzFsEpoICKWsKfN1r6tfSvnRaECx4YyJY3/bb4PMcQvHYrOeO0wyk1ewm+SnQVqqUIbJUT9+yCS3NNskCgeurt9iplIRtSN6TpD0Bv5Bb+DHmLGMfuByc+6LEAnhyOqq6mw/hr8NEKsgZUqelmH8kcqypyvMsd1SigxDDmY0F27GhAecoHhKTKrnfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/YqyVQ9cvIVkkTXKTVTroGTUFLYOpkO55BbHjR6FgI=;
 b=As/QDVzroyAd3C8KMGWkOSC/LzGAULU0NwwWTcQxa/A9193iFvjJJ9afg7kniJN0UBenBON9gXQEmH33nOt/YO8fBYRarO14krVfpinQlDUTeEFqZwgpmBoCqM+RkgM7Xppi5NmqpMutztvl9uW6lGJaI6y6szkO6dp/5AiDwUDesCAzXDrIVG2cQgegaSbQbgPVocL2oIVotZPcxkmL9aPR0mipHSbJrrzYqu1V4LYFpT0TXUxSNBHEN+G2J+soWcf5bZi2/Nrjm54RqkxmMBrON/0mVfl/M731kaJAgBkdrjiYvNHb813g8bc/UvAZzZL8G8jT1RmARVEY1geIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/YqyVQ9cvIVkkTXKTVTroGTUFLYOpkO55BbHjR6FgI=;
 b=kw8+jFrmsmxqS8rRXBsDVoU77R39g+5lpdxx33PKNWCMjr3p0O4L/EJikLvMRQy2B/u0BFMet1mxlVeTTGkBsN88NZapt9eHatCsdBRUuPFUl16RJqlBJbdftl/oLujeh85gegU3OaaFUGoYuT2/DiQvUmcBsKJicylptpX7Rf0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:50:32 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:50:32 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/20] drm/amd/display: treat memory as a single-channel for
 asymmetric memory V3
Date: Fri, 14 May 2021 12:49:44 +0800
Message-Id: <20210514045003.3069681-2-stylon.wang@amd.com>
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
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:50:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fedca98c-b8cf-4cc3-1071-08d91693ce2f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129D8B4C3A16DD965AC9E5FFF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Q9i8Z3p8/rbRdRNXGqrZJtqX7db97m6JlGn/b3ZN4lv0UbQQ28hH//hAFrCk2BbpLJYPzhT+3WhbCqnZqn/VXJoyuMRDMdURhznIesyQiem/Y5E+cnizPIgD0EjlCocP5mD1PI4XEpDwrGz08DVVRhvM0ghvhtMFbWladUZB1stoSArayli/HAc6GiUl/SeJ858n/o3mrb8SfLiy/Nt3Car733gArUYo7BN13enkUdCV2lNAf3ucjsZ3ZB4XCgiGikVNA2t9Omb9D9R7HBj3gnIv9oPiDlvxPiEvlp3f4YJEROP2dLvuFSZQ49Ekqh1CWCYteCKxb6yiceQ1agrUSAsP3jq0+1SqVwW4yN5eDVObdDS09PFuRL6ieVRL/xzdAR6a6wR9LENReVb0H1z6o41dCd3GSVJ29NSkyvHG0JoEOEmgV01B0GpHzRAuwZLmLBUw3UQIeKSL0h0k4CfoXjVubZinl12NRrdtfatX7hZm7k9fmHLjKySI/ksgFLKXyAMepj2hljnGoTzsfcSU9VvGNUaE2nUSWqDBk1sOnxhgodJO43KQNY/RaMpggXK0LuVlFGQ3KNGspnV7tBfecfwBWVgIgE2sPQL9CgE3FmeXbX1nVIA5vcmrh8uI4WTkEPuMdV4Vy90flofl4e/5QeWfq7H2YXytOfoL8jSva0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8676002)(316002)(478600001)(83380400001)(26005)(956004)(86362001)(54906003)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OzdOS8F5FRKw5C6RPf1/WXLkjfSTu2fvTzNZaqR8R04nSSWp3x4tYIfHwjiD?=
 =?us-ascii?Q?76Cuses7LjuRGq7nmFVqh6ab464ADiUfS5/z/AtLhpsRvYvuKAPhNxvrZqrq?=
 =?us-ascii?Q?7v4dxHjenFL3+UlkCZsdte1mZAgqpCkJPfcWGeneSv+K1xoxJ5mtdBZoKHrJ?=
 =?us-ascii?Q?YQKAmp+52i+HsmZvs6e+EuvdU8VAcUGVJnP/A48uoA5sGXwIP/IhdqTi65sg?=
 =?us-ascii?Q?oGQq7KPAsHOrAwlE4lB39KISU7KxatdfSlAU4d3fzZOgyKMjGyxc7U/wCwLS?=
 =?us-ascii?Q?+J9inThPAOczFJMMvnFlYbxXV0w/D/1K+2uEt+73TkDzpEMJd5ORZnj3oh51?=
 =?us-ascii?Q?MVhtH2zXweQLaG/VvIbBcFKLSJUovQAuePfjINnnCWBgCOdkfpFFhb+eMF4W?=
 =?us-ascii?Q?xh6DWTGMTZ8Q0Wfu/H0NGX5JGxB7d/6Xn6mMKTncAhTflod/ZhucJ8T1MYnr?=
 =?us-ascii?Q?U9fJHGwfr67rDIskfni7Nit0RqjW0/n5FFtvUc3dBIpLSJtefLTDXcnfGRLD?=
 =?us-ascii?Q?PJftDd87PvOsfXHFCbKFPbmG0Dpt2atODvF21YevCg4Rh0hiYBVbo9qLhPCO?=
 =?us-ascii?Q?Qv1aEFykCVIfeVjrOiNn8mcX9L6rouyvvoyqqQDBOtP+gWSumTUutK3nsGV0?=
 =?us-ascii?Q?22wbpuTtywgpuPn2Vi78uV46hrIrdxv57cMJrNwXlWx5pHJGHkMSXVAzRNBa?=
 =?us-ascii?Q?b6cf8fR/O/hyC2ZYmG+M4QHTWvtK7K0T5FT6d5DZaE+J25hIWPtDjcyt+tmg?=
 =?us-ascii?Q?bTgfk7DdvPFGrGP7WKdnzy+wBLSwp2t3WiUZu7A5sypbTxEk65URITg0+CVV?=
 =?us-ascii?Q?lUwQecTkRHckIt0XvHphoxVyBqwGOK9/o9VSqnQYV2Pti04vXRCdrQgZmgAA?=
 =?us-ascii?Q?HyNlcvlf4ztr+IZvWw3NeN0mslPLtms1RQp3vDgxv+N0WU3fLLpBGprRVKel?=
 =?us-ascii?Q?DSlYY+z855e59nKkK2bMfRoX3VV6k+ZwLWxBZ9OwPLk1T40W3f/X2S/i6LYT?=
 =?us-ascii?Q?oHnXfCm6o23SQVxBa0AyUyfh3bhXL4MAPNHCclWnnDYHlJwUICFQup/9TwxX?=
 =?us-ascii?Q?ul4wgKTNu5YcEEVWX4qoNWYhqidLht19jdPm6SDgTuh1aqPQ53HeFbtvz3qe?=
 =?us-ascii?Q?JoEzxqe6lDacsmOej8n7YgYpklkZP+IFm5YKatLsSeeXj0HyWExbnuirzmCQ?=
 =?us-ascii?Q?iscoz8hGvm6uL285Iv/1CWETwuPuBvQMyGkr3mq5Ft0lm/R7gIuKEXTKvONc?=
 =?us-ascii?Q?dhXtD9MxAEAM6XZSl0s3xmiI5me0aKxI3/rhcNbRFB6AV3iWfgSGAyM4NSmt?=
 =?us-ascii?Q?wiX32jFK5Sr19nB4ltXwMLkS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedca98c-b8cf-4cc3-1071-08d91693ce2f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:50:32.7199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iImUYLQy0hOzqJpENHEZnY6S/OEt2LH0BFPEGqruiluLJd7I4AmyrLPvvn5a++X0Us/MjD1MT5EJ3gLIFjEktw==
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
Cc: Stylon Wang <stylon.wang@amd.com>, Sung Lee <Sung.Lee@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, Hugo Hu <hugo.hu@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hugo Hu <hugo.hu@amd.com>

Previous patch caused crash and had been reverted. This patch
addresses the issue without regression.

[Why]
1. Driver use umachannelnumber to calculate watermarks for stutter.
In asymmetric memory config, the actual bandwidth is less than
dual-channel. The bandwidth should be the same as single-channel.
2. We found single rank dimm need additional delay time for stutter.

[How]
Get information from each DIMM. Treat memory config as a single-channel
for asymmetric memory in bandwidth calculating.
Add additional delay time for single rank dimm.

Signed-off-by: Hugo Hu <hugo.hu@amd.com>
Reviewed-by: Sung Lee <Sung.Lee@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 48 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index f965914ea57c..416a24db17a9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -761,6 +761,43 @@ static struct wm_table ddr4_wm_table_rn = {
 	}
 };
 
+static struct wm_table ddr4_1R_wm_table_rn = {
+	.entries = {
+		{
+			.wm_inst = WM_A,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 13.90,
+			.sr_enter_plus_exit_time_us = 14.80,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_B,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 13.90,
+			.sr_enter_plus_exit_time_us = 14.80,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_C,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 13.90,
+			.sr_enter_plus_exit_time_us = 14.80,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_D,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 13.90,
+			.sr_enter_plus_exit_time_us = 14.80,
+			.valid = true,
+		},
+	}
+};
+
 static struct wm_table lpddr4_wm_table_rn = {
 	.entries = {
 		{
@@ -971,8 +1008,12 @@ void rn_clk_mgr_construct(
 		} else {
 			if (is_green_sardine)
 				rn_bw_params.wm_table = ddr4_wm_table_gs;
-			else
-				rn_bw_params.wm_table = ddr4_wm_table_rn;
+			else {
+				if (ctx->dc->config.is_single_rank_dimm)
+					rn_bw_params.wm_table = ddr4_1R_wm_table_rn;
+				else
+					rn_bw_params.wm_table = ddr4_wm_table_rn;
+			}
 		}
 		/* Saved clocks configured at boot for debug purposes */
 		rn_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
@@ -990,6 +1031,9 @@ void rn_clk_mgr_construct(
 		if (status == PP_SMU_RESULT_OK &&
 		    ctx->dc_bios && ctx->dc_bios->integrated_info) {
 			rn_clk_mgr_helper_populate_bw_params (clk_mgr->base.bw_params, &clock_table, ctx->dc_bios->integrated_info);
+			/* treat memory config as single channel if memory is asymmetrics. */
+			if (ctx->dc->config.is_asymmetric_memory)
+				clk_mgr->base.bw_params->num_channels = 1;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d26153ab9d62..63b61468898f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -308,6 +308,8 @@ struct dc_config {
 #endif
 	uint64_t vblank_alignment_dto_params;
 	uint8_t  vblank_alignment_max_frame_time_diff;
+	bool is_asymmetric_memory;
+	bool is_single_rank_dimm;
 };
 
 enum visual_confirm {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
