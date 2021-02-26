Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25708C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21C064E38
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21C064E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5605D6E453;
	Fri, 26 Feb 2021 22:37:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 703536E459
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 22:37:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhV1N9Zp9hTWRBrr779CZSQs/M95R9XBgFNtSGc9CxF+A45bbyHK01FTjnpEWPf3f/wHmZcj9MbxhMZzEAOhnyoc2gE4MB/j14J5wI22m+PdI/aRegQc+Tol6KjizVOeTSGOglbiN1J9kdyuEpolTEJJn72qTclBQ+McMt17gVqZhB9Y1en1HeB/+OJK7j47Rr2RcXFZXtnj7PwRDgTkSLd5m7CLQxKz8QkxBP33eIwmMUbQZELJdotLz3eojRwkmLqj+w06lsijywONkythMx+obFBfCqqM6E/VVUSz5RyKhhT303IhRdPOc+MSt0bdOMSuK3syCzFORswXoJqhHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4d80R0W8MJVWLgpx+e/szdac5GfR8LV5wJj/o6gdlE=;
 b=SChlbzoXB7hmyrVhxmXUDQ5Mw6XCblFokZ8zK/lo4BEz+jPbwgHDKMKUjy26Zj5IQWAQv2dLrmAc6Kj9nNcWyngIqzgsWeYt7D1iiQxLvjlxDYcSPx8mxeds7qXnBA6wHdlaDVCM2oBemiz5RfEzEmwZpSJldDuneiPnwKl1+6ahFgRJjve0R1jCnbceNRFSns0fOjoAe3Q0Ih5jzPZ72DslntDG9QGQ935toBJSYtL1zChgk9Ne6hvNDM0mOkhY2xYlFGDPyFjt2lQxHioA8CCkOm4MolfuTaNjrGX6RzJ9eLBRLwIswej+xVMWXzsJzDI9suQ0QHZQsW7tbbSCAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4d80R0W8MJVWLgpx+e/szdac5GfR8LV5wJj/o6gdlE=;
 b=ZzwkwIYknKrBQpaG6vb6cPGv/h3fh69d7D1gotca+O7+eH2rJmiy4iSEr4zGKXiyj+KsKZES399c5Yf63lb50AMyJiM+fulh+g+AfL19/s3c+Io4Jfl0ctmeQQClwApKia2WDyGb/X86hyC48saNRhIeBJjhzIChK8S/29Cf4fM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 26 Feb 2021 22:37:54 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 22:37:54 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/11] drm/amd/display: treat memory as a single-channel for
 asymmetric memory
Date: Fri, 26 Feb 2021 17:37:03 -0500
Message-Id: <20210226223704.400472-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
References: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf]
X-ClientProxiedBy: BN9PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:408:fc::12) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf)
 by BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Fri, 26 Feb 2021 22:37:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1d4afec-d492-43d3-cb1d-08d8daa727e6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18833521E3DCB8F803523030989D9@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1FCTrkS4DIN83/xcNxLiadeKIOePid5hJTtEiDBzhJk6o3Q6NJ1eQePpgsYtgSTI9jMf0XshXLBUdmV3itESO9Q+J/935hQctZsqMMOQjIMJ8Hw3nFqFZB65eoboNKoMjmpqezW6MDuhdgNB+qxi0n3vKoVuGHZHTK+QQrNXrfCvU0ohjK5aGuf/u7nfqxkjW5qCstSNOKEx7gzvRRp5mZe23XqeoYOd8Ls+hJrgudN5mUriNRWvEWHjynRo4W8GmIkTnrn5tKyGvF+HWmELk8f04BpbuLCPYIV44qhJPD+8y8z1gtrxJQaysEFFisYj2FxuUYF0Mb8j9IpZgiOs8OhgKLR60Mt1gKAmOIltcjA26kjtl+tQWoj8AkX9V5zkFCBacgJdYcg5j6rjoVMReQ2o1tMfY1jRRNujxzR7h1LMDGpspZohvTGwMRzSNUjlausOhY4D1UL59/5vdpa/rJwTLmuaytVxy2Z0vS0ZUrqKpDC/plld2dLj7e2nvXQ6gm59rUUuhk3/NkWaYAefA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(2906002)(6916009)(2616005)(5660300002)(66946007)(316002)(16526019)(186003)(1076003)(54906003)(83380400001)(36756003)(6486002)(478600001)(66556008)(52116002)(4326008)(6506007)(66476007)(6512007)(8936002)(8676002)(6666004)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AvvzWn5KEgir7Acefm+vwQgKR1t3y1Q5ul1UjKMl/FBgvRO8WI3iaTpfOPJw?=
 =?us-ascii?Q?27LMOYCayLr29uFSlfTqlm0BxwUNujqWwDS0FxQjGw6Yu1LOCs5+VlI+LdOY?=
 =?us-ascii?Q?MxPlYrJEdf5akVYDqRnoIv/svPEghvBAceSee9WkCD75J85lN/ALWuNHKnDF?=
 =?us-ascii?Q?E/QY3FRpeQSyatqtyv9kLYNDaaZNTg9Eb8FZYEWnS/2wVKJF3Z5xCPN3cpav?=
 =?us-ascii?Q?n119B/EsPsXCmOljvBVaNnBxuqTQNbZITqDP336ZwQiMzd/EMrBV6ibAOBA2?=
 =?us-ascii?Q?VRrS1AKIfOEBDHsxyCYunSagY5e6L/BolWikh/k8OnEViIGigYdyZq0BqfqZ?=
 =?us-ascii?Q?NPvPTEtLtYbFAt4aGPecnJ+wCIWnWVduCYhQw/wv44h2hVoBBeyPMjeT/P43?=
 =?us-ascii?Q?krm/o6aEMestwQDbF2DSuzA8yvmPBWpMsVeC79brN7BRdEcNnYh/mwKg1kRo?=
 =?us-ascii?Q?L9lcdHwBf7CuDIyqtDmC5gzBbgFbBqvzCJFprQ+RR+lTTofCRF+qxkok2ddq?=
 =?us-ascii?Q?td3PmuDwsWKBK9uShlgQljNiMpHOeLVDn04bnOWIpMGPiy5ihP7JUN4VP9XO?=
 =?us-ascii?Q?G1XIjEoJBzgABoAiGma+PaipX0KiILH0l4Jo5VIyVZTNv2Gkad/j5CsW2TnZ?=
 =?us-ascii?Q?BVOpXQmJtlaDrjZL/xY+Bzhzrx3C7QXQNrkLldpCyxeWb0yuvGYmu5oFFDIZ?=
 =?us-ascii?Q?Q+Vjjw9DNC/deTC5Y56vSzIygioLxbZf2ut1h/nCQA/vuysfHWTGs97+ngrj?=
 =?us-ascii?Q?Ko5NfUUFSk1nfwRNQgginfNd/f5Li4mPnCvw1c/TJYk9Fyyl2r4HglOe8G4S?=
 =?us-ascii?Q?Cs3QLtaZ+jRjxM7MIdLLCJnnJN91ELTWOlPbEbitq4kUGKcO0sDdGHdi7QVi?=
 =?us-ascii?Q?WIOiUSbLlIdAegz4cPT8dF/5dNC00Cdkm7eAHPYxUc35/z91yV2cKcypz8IF?=
 =?us-ascii?Q?/CsFfqcAux2RUoMFkQcVNGjNepcjd6GXXZbAg0ApdVdhYQFFtbPuNcICRehB?=
 =?us-ascii?Q?sNWiyoKc/26x5ga/NPKzixbxUWcSQzucanFUsD7r8EbpijTTydy0hnsWWSjC?=
 =?us-ascii?Q?6AqoWjv8EUJNwITxjtnJcl1NPDZhs52Okp8R/x4ZhWa13xiCgrDIEjfPnKXC?=
 =?us-ascii?Q?jWptbJdOUvTQJ+0mzTAFzI344Xq1u/y4py+xAc0yF1IP1h+ZyWyO6VqxCM0h?=
 =?us-ascii?Q?06f4iY2vrVbx0fiZCV/Cn1mPzgLHiCUzoiOQ7Rg/ri2HUn0biy1dK+l/zLqz?=
 =?us-ascii?Q?v594rzvBaL5PzAMDSZXCov/2Qsc2zw82SGRABgGifO7BUb1UmNJk+QNQ2tBl?=
 =?us-ascii?Q?OPZvXZHjJqxFtGHC67nSuNsU/1GXCl+G2ZALAFndtC+u+sjWkY1R62kjQA0e?=
 =?us-ascii?Q?Wz/Jrr6Ry7CQOHeBu8/bir4/AWhv3NWhuwcsQgjaslLj4i5cfA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d4afec-d492-43d3-cb1d-08d8daa727e6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 22:37:53.9693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZC27JV0eS4QjO05klrRagUtANvXidm9nMAUgQegf4EWkPaDj4o1f6tonX+gJCItIMaecSkrrefGhN40NPEWKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Bhawanpreet.Lakha@amd.com, Hugo Hu <hugo.hu@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hugo Hu <hugo.hu@amd.com>

[Why]
1. Driver use umachannelnumber to calculate watermarks for stutter.
In asymmetric memory config, the actual bandwidth is less than
dual-channel. The bandwidth should be the same as single-channel.
2. We found single rank dimm need additional delay time for stutter.

[How]
Get information from each DIMM. Treat memory config as a single-channel
for asymmetric memory in bandwidth calculating. Add additional delay
time for single rank dimm.

Signed-off-by: Hugo Hu <hugo.hu@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 48 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 01b1853b7750..3946d12e9fb1 100644
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
@@ -932,8 +969,12 @@ void rn_clk_mgr_construct(
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
@@ -951,6 +992,9 @@ void rn_clk_mgr_construct(
 		if (status == PP_SMU_RESULT_OK &&
 		    ctx->dc_bios && ctx->dc_bios->integrated_info) {
 			rn_clk_mgr_helper_populate_bw_params (clk_mgr->base.bw_params, &clock_table, ctx->dc_bios->integrated_info);
+			/* treat memory config as single channel if memory is asymmetrics. */
+			if (ctx->dc->config.is_asymmetric_memory)
+				clk_mgr->base.bw_params->num_channels = 1;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3b2b66104a31..b328393bcb7b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -307,6 +307,8 @@ struct dc_config {
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
