Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89C4C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E8864E0C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E8864E0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A9E89E33;
	Mon, 15 Mar 2021 11:23:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 146CF89E32
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:23:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPHZYj/iOveZqxSSRKexqpsrL3tQC6Y8slw2LcNr3808vlc5/PCqdTCgiFtV///lYYR4J043vrlR5KYZAbygvyg6MLYV2eTW/3w+5peopqgGCWrzz1/AMT17ceLAQQ7h5PJJRl8GbRry21klzgD7K2S1xf22jR6p3tHqvlFHHwVfNEtL/Y0eu3N3EgPrqtlSzgA3EbARul4FLG5ntgkdifPtR31zKct280GHBzVgTdFnsntFmOHOJ8WqaYMlDniu/imD92KvCfIycE4sYR2LrN3R+/WfFoJkobHa7ZijBfZG3/8hZ0lJWunHwAhuBPz06CazysOpQaQzvaDsQle7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu9eSNqzR8jiMA00SUYCyhi9CAHLmXoTcXx6fn31qEQ=;
 b=WfH61HWtyTn85YeE0HsZnfsFTS+ettGdUlvTde7trB9Ud8WKBz6cSgysIfjbNfv1LAoDIX1VuZ84S0I/J4e/QuVkkzJJoDYGiHLrHRI5BRU/KXQaYsCUU6oNbFgt1y4SI2/wh5qEk0F/ApareD/1AymhE5J3NB5AGcPrZMnJjSqYj1g6YBr0q1i/5cUgTR1HEraA10vFuLkZePW4t9PnF5MUeg+aRd4cLhkQc0H3zeoz7Lse8vrIVI4gtxjxYEbAwk+A8tcJpibic9mYhveizd7GM+jYH/6BuzQ7DFYIgOWajk7Ksqvza0/H0FY9rdvZvxK1aJ2JgsjNFC98rEMMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu9eSNqzR8jiMA00SUYCyhi9CAHLmXoTcXx6fn31qEQ=;
 b=qhLO3LFcQReUmwNHstchwPhitKIVd4LZzmipy4pTQNrrGGxO3JxSkmqj1NUSfmwC2j5EcREqEyIBSHhdA/6ukwWdJemldEyn++Mnyh3SLOq4H70xSXZcNFQpto+SY7GAlb3Bp8bj0RslZ9kTr3eopLbYAHG7X/xOsHzb0zArFZ0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:23:47 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:23:47 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/23] drm/amd/display: fix dcn3+ bw validation soc param
 update sequence
Date: Mon, 15 Mar 2021 09:40:08 +0800
Message-Id: <20210315014010.16238-22-solomon.chiu@amd.com>
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
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:23:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0f96a17-f0c7-4277-5b37-08d8e7a4cce5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46178A2BE30365E86E4651BA976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bE0LjsyP4+/z99WEOONWvijsiRO3gzpn5gy1I+ccDzs6de7p2dPk1pSclCvqkUiK33arTqTvETFht9HOO5J4q+E4jFxa7UemSxMbVfrmE5QHg54WwlGiA1pGRuEdgWU9B4iXsmO5XqlcXrGy7NgWBxIlNEofRJSPWoDYOxM3p/SCmsTcFGBdA26HED+2Sur2mONYqIHhwDI8FwjHhG1l17qOysW6dA2EwSi9U+NRx80FqWUsvMbaSaMqYBuE75UfCcyb4E3iaZIS56jU1cF8gS7y3/YOfbRUd5tA2BOtEZYNUvi4LoNczrGN8yqjop2++T4ggk0GoNZt1XjrZzqkx7i03ATJ0jpZnH56SlvHqPRH4r1/5QJWGwtPqJza6DzQruOXSDRpcYufErjQXQ+nhJ5WKrX8vAo0/Od+PHzkLAZMo5uAiNfK2sKqJb1tYWCwjHJHgiJXiA/+RWr8GUHR933RH5I8dWaopGaHn13bWnCCWNZd3QUFvLSig6iCSSU+KuNQjoGyl4UxIIOLaEtMdaefv6akT65PFSQEziOLdJYkzq69YcaNjEK8b2ao+y5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(15650500001)(8676002)(6666004)(54906003)(8936002)(52116002)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(83380400001)(2616005)(2906002)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MetM0AaBmsbbocApcuhvo9npaOmL/RUa038LS72M7TExmSUl31GYj5jGia7E?=
 =?us-ascii?Q?5N1aUr9rItqJywVl4WyescGFldoaKnxbQujo67UyY8PYJZrGuUHeFamHBkyM?=
 =?us-ascii?Q?DDUaPtZSnqPOma9QsvwhikN3eajZ/KzZMRoKv2/ooGDIY03R878FP9Z7BLj/?=
 =?us-ascii?Q?Kp1yKOGW/hH/jAXI9rZLcdyrHHRBzmIUVegADg4yw4VI2ucIvnKeICK4xzf7?=
 =?us-ascii?Q?FNnQp1kdvLO2rqpauGNBWhQlUBPO4sOvndVDK7Kdj9aB5uCk3UDzst9x6zIq?=
 =?us-ascii?Q?orkGnktpQ/ilIz8naWUYY/EZ+aj/XgG9L4J9nFsScMjPCxRZxZbMUN59E5e9?=
 =?us-ascii?Q?DF5XY+vHsKhbZL+g2dN3BKWl8L4FulVmQcpJVbDxW4L3cbFxaOz55uRbqKir?=
 =?us-ascii?Q?oU+zkeBIsZ8v6yZiTF3qUtcsI64ip4eeDIwENoF2zRvTUId5Zjs60HYlb5O8?=
 =?us-ascii?Q?zWNHN7/71oKif+8q8vJ3UUtVcc1yMZhSsh0nxauG7m120cR7j3u1dUAijMto?=
 =?us-ascii?Q?4/+tRx20PGuXJaZeclOz2vVmPSc91g8nYBMd8NW/YsTWNEV8kwaCRhoJB7p5?=
 =?us-ascii?Q?9s6JoMOknM6X4P0LKNXFS43bHppjqlB9oHXr8nm5HVMI/3RkRksvylwSOPsC?=
 =?us-ascii?Q?LKw4xkKM5zqt7n8jFJ83nnvk+u65Tg79EHrmZIAoWhcZA7ITAZfFkskNGfKi?=
 =?us-ascii?Q?L+aTbgT9eKk4YIAgwxtPHf3C3jmMvJOszFJXbWzYgUTHAIeVx+fa7jVyqemS?=
 =?us-ascii?Q?y3L9P9zZLERtDdL4ro2BN3J544N0ZVn+XAnlUnp9F7U/seVrW5SJ1NodQLTF?=
 =?us-ascii?Q?9MV0AxlELaBbVf7QGFLXR71/XAvfhtt8XdXnGqyXLDLVf1d2/YhQLts6/5vY?=
 =?us-ascii?Q?ruCVVJmoWY2GpULXUQXkUZBUBqxCoiC2Xrse8nZ8GpwS9rbpc6leDbqwAAf0?=
 =?us-ascii?Q?uO/nml+lq0CH5ZFfGPxlYOXaGHJqLFlmwlK3hsbAbb02AWWToDUTX7dYbBe/?=
 =?us-ascii?Q?md1+Ps0sk2Sj7W50D1OiUxSP65Be0FtRRIrsFZvbRF5uzXKqNDvaM0YPXxq0?=
 =?us-ascii?Q?ALGW8elCbts1EDSvhFXOonl3ta3Zc172EwNMt+9u3WkjPS/jDQ9xNuifjHvP?=
 =?us-ascii?Q?sqMU8GJ9ieTEUOjvluzTethnB8THZH3oxruRYixS3JsQk60rukYiaqTNrbXZ?=
 =?us-ascii?Q?jd9tKKoPe/HPelLLWMYzFHHP6rhQ2F2oZkSGkr3Aw+6FRgBlveCPl26pD5fs?=
 =?us-ascii?Q?JoPwP/r6oD7gz/rx5T+lKEHJKFoswBBqDnJBQtxBZnyyhDR3rnoYdwmOi35g?=
 =?us-ascii?Q?/Xm1H4X2iNPXEz1Da6XkPoOsmn5k/A9EX/KSsK8yvkumUw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f96a17-f0c7-4277-5b37-08d8e7a4cce5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:23:47.3050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Yn7QO+IMOdfoBuYNb0OsdlvqkTRnFnfEf3G7cGc9XI5XM6eOniLzBVItIVdbO8dmDhNQsK65itpDZ3AhKA6nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <Eric.Bernstein@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

SOC needs to be updated to the WM set A values before validation
happens.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c   | 17 ++++++++++++-----
 .../drm/amd/display/dc/dcn30/dcn30_resource.h   |  1 +
 .../drm/amd/display/dc/dcn301/dcn301_resource.c |  1 +
 .../drm/amd/display/dc/dcn302/dcn302_resource.c |  1 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h |  2 ++
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index deab48806fa2..263c2986682d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1876,6 +1876,7 @@ static noinline bool dcn30_internal_validate_bw(
 	if (!pipes)
 		return false;
 
+	dc->res_pool->funcs->update_soc_for_wm_a(dc, context);
 	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
 
 	DC_FP_START();
@@ -2225,11 +2226,7 @@ static noinline void dcn30_calculate_wm_and_dlg_fp(
 		 *
 		 * Set A calculated last so that following calculations are based on Set A
 		 */
-		if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid) {
-			context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
-			context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us;
-			context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us;
-		}
+		dc->res_pool->funcs->update_soc_for_wm_a(dc, context);
 		context->bw_ctx.bw.dcn.watermarks.a.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
@@ -2272,6 +2269,15 @@ static noinline void dcn30_calculate_wm_and_dlg_fp(
 				dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
 }
 
+void dcn30_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
+{
+	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid) {
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us;
+		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us;
+	}
+}
+
 void dcn30_calculate_wm_and_dlg(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
@@ -2496,6 +2502,7 @@ static const struct resource_funcs dcn30_res_pool_funcs = {
 	.panel_cntl_create = dcn30_panel_cntl_create,
 	.validate_bandwidth = dcn30_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,
+	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
index 8ce7f6d39a20..b754b89beadf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
@@ -60,6 +60,7 @@ void dcn30_calculate_wm_and_dlg(
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt,
 		int vlevel);
+void dcn30_update_soc_for_wm_a(struct dc *dc, struct dc_state *context);
 void dcn30_populate_dml_writeback_from_context(
 		struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 5f29a4f85ef2..e41747c39e29 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1721,6 +1721,7 @@ static struct resource_funcs dcn301_res_pool_funcs = {
 	.panel_cntl_create = dcn301_panel_cntl_create,
 	.validate_bandwidth = dcn30_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn301_calculate_wm_and_dlg,
+	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index daa16a41e6b7..0723e29fd42e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1397,6 +1397,7 @@ static struct resource_funcs dcn302_res_pool_funcs = {
 		.panel_cntl_create = dcn302_panel_cntl_create,
 		.validate_bandwidth = dcn30_validate_bandwidth,
 		.calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,
+		.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 		.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 		.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
 		.add_stream_to_ctx = dcn30_add_stream_to_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index c5f483287509..eb1a19bf0d81 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -110,6 +110,8 @@ struct resource_funcs {
 				display_e2e_pipe_params_st *pipes,
 				int pipe_cnt,
 				int vlevel);
+	void (*update_soc_for_wm_a)(
+				struct dc *dc, struct dc_state *context);
 	int (*populate_dml_pipes)(
 		struct dc *dc,
 		struct dc_state *context,
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
