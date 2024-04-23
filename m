Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86670C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 14:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B7D610EBBB;
	Tue, 23 Apr 2024 14:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3ZTPdnlD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1220F10EBBB
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 14:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auVt0IX5lUIM5ngc3/mg/mJZ/uLnU+9OpxbiJjtSpUl984SZc4AcBdgAdRkeSWvekRxhgd1ZtDZwIkb1jMIDT5kZnUuvtMNaSo3Rhyt93t3o0iTt8IoPAJWD1MI3BntvExjue4E2oBrDwo3OmJi4BoeqeWfihnlmpJTW5qXewYzkXoNH42CFUYVAKR4TfEn3iuVkxI60UJDu4zvzd4SIDgiXDfGZd9yUAwkmPIiiG00GDlAdG5qFEVQUwSxtrzmJiXsjOF6aIerQuVJCetnSVhDA0hY/fCaEQq4SekfK1ShAUZ8tQZ08ICYgxRUYabKYchB8cJmYGxHvLaJ0Z+AU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fhQ5aRHQGYU/wmNa6sHpoWXXQWRGnrO28+ZKwcbvDI=;
 b=Xiw3cjiOhlHEw0yYLbfH5G0dSWRzpwUG3ZdxarNTAY+lAATMqioVbVZDmNu0IQJGdXjUlBHtmDpqsEeVY2v95VoTaffiDdShOwvfDVWSHBMfpl1hOqUXGH5xlOkdfZ0Ok6EyIRcFf7dZxzxJBMWaYV4Mm3QpyYpaqE2x0DCAarQPaViNENpZ3gpVnOF3nCaGb1Fi+fSj6HFTse03YR/uv9M6a9EzHYb1yV2xHOBEgu+cTseecnanJ/BssEeJaUnbcoccq80B5iPsr/VHfX323CUKaTgBGd9/rLg8R5o0daGZoulque5fwaN7jKUpvqlenJHD8PRrxR+ngJJxshuDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fhQ5aRHQGYU/wmNa6sHpoWXXQWRGnrO28+ZKwcbvDI=;
 b=3ZTPdnlDwMTzEQcySr7rLoHzartR/KQ7/WMnwaKaf5PwQxpQZwf5kJZDRHfZ/n3W1pmToSVknd4LbtSOi5JfkTlZRF6BN1I2c7j7Hw+TW+yfEWwgGulvGwtUe8bm+1tmIcSREED8mcJd/ETUoq5Ug6fojhx4h8a8A7fRnqvsQeA=
Received: from MN2PR05CA0063.namprd05.prod.outlook.com (2603:10b6:208:236::32)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 14:00:12 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:236:cafe::f8) by MN2PR05CA0063.outlook.office365.com
 (2603:10b6:208:236::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21 via Frontend
 Transport; Tue, 23 Apr 2024 14:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Tue, 23 Apr 2024 14:00:12 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 09:00:09 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Roman Li
 <roman.li@amd.com>, Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amd/display: Remove unnecessary NULL check in
 dcn20_set_input_transfer_func
Date: Tue, 23 Apr 2024 19:29:53 +0530
Message-ID: <20240423135953.1872483-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 16714376-c206-4179-bb85-08dc639db20b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1ThDsJj+8JhJuzlr13Mt2PfiJyypd28Oa+XQidYAhsufMl/PLd3E9s/loMuT?=
 =?us-ascii?Q?AbGVX4OVO+qwQFS7nKCkjb6uj8po1HAzqoal0Ur88JH4YMANnq1TZyIcv3Zm?=
 =?us-ascii?Q?ptgbzVI08eqSfXkPI+xtWoRQ1VPnVK29XH382txowDqailJCR00fkF6CeFar?=
 =?us-ascii?Q?EzobBAnWxXY5cgHc1L7rVIcWxazHxSfhZN4RcQDg5JrD9DCzOmE3ot4piJuD?=
 =?us-ascii?Q?KfGTHg1eVR1ZXFr1Igvx+FfoJ85hnEUqdoUNn01tjFMHsotPqOAoSw+ZF3q2?=
 =?us-ascii?Q?larLcUnaYXmt5hBzFVaWbD+pfzoyJaaLoIRksivTWESbNJACaf21rjekoZBI?=
 =?us-ascii?Q?5kditL1VxmQXD+qK+7ItFH287SgxRqoU9NSzHGeqZqHuFVzgAYxVRb23xH6D?=
 =?us-ascii?Q?S1YlKka+gxJsMZ9nPjFeAmW2NKm71GnRDG0V6ERnHixfgZGEVNLBcHKMy5d8?=
 =?us-ascii?Q?T9ln1G+77nlzQe7iSbpDwE9G0VNweydvQBjikG3ZZFjTMyUoiqG3QLfOJFLg?=
 =?us-ascii?Q?9BAF8vFsp/MSIU7+tOcQM0j91ksVnzgu++srBinEmGFW2E4yAxXuj0w2Tm2u?=
 =?us-ascii?Q?WxV06U481D0GdcE8Mmany8NoflGa+iBhOSUJDtqLgxZ1KmMoRZvE1SJH6wuS?=
 =?us-ascii?Q?i7H9Zy+UJMcpeTZIm8Ly4QS8ksrdLooylnkU99Q9eM258a0xm4MthAYykRuo?=
 =?us-ascii?Q?HEyLalTuILKiq8Gqorygmho0CYdD8xaVzQoNOHTs/IB/zwKXkbAgsVu6o6+C?=
 =?us-ascii?Q?mspKdQzynFYOWouTvxSLJRK09n05UqwQGN+vA5SjJEvc8x2o/7fe+JSThC9l?=
 =?us-ascii?Q?HZelNqTIDfBcCyqh3WdQRR0noJj8y1LtZUPCPeqK9X1oQqKvN+I1xPfa6RHt?=
 =?us-ascii?Q?XN/OY7K70cmDOyjBgXb1xADSCJ+IJqnyF+m/U+HTQPT4g5+0FjUWDHK0EKjX?=
 =?us-ascii?Q?ckrO4yWqMtFHZpjAck760qgZZev9F+8fKnlVHXuR23Z1Ufb+z0QbY/Ozt87m?=
 =?us-ascii?Q?/+7lGYyzVcq1d/CkD8zQzlCID6D37HVeRJo/JonoVjBZZYEz0xumq/iwBI4q?=
 =?us-ascii?Q?qrzcHwOoqv2nsasxYNl0BaNtMv6mOP7Pk97P+6i6owwRjI8J4e1iWV+VeLBd?=
 =?us-ascii?Q?gF00vpAc//yA2KXWCufQY9cpPQIt1OCEj27vM4mqY1ZEALrvnuwEub6TYft+?=
 =?us-ascii?Q?B51eK/2Qy81DHU/k7gncuHVLe0hzWslqU72AxojlLJdJg5/eLlQEytMksJcq?=
 =?us-ascii?Q?EhnyC+RWPje884mnZcS37TLh/E0r1SL2mhBOJEeLJN4vFR90PA328+lwWZ3+?=
 =?us-ascii?Q?/Umd/e7lPZPxhUKaupa73Tjex2kSV8gtgLDnddl0fG44M6wjeuZjqp8K+oaV?=
 =?us-ascii?Q?edorbJphPNnRTQ3yh+wOpZsdcaOI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 14:00:12.7427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16714376-c206-4179-bb85-08dc639db20b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274
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

This commit removes an unnecessary NULL check in the
`dcn20_set_input_transfer_func` function in the `dcn20_hwseq.c` file.
The variable `tf` is assigned the address of
`plane_state->in_transfer_func` unconditionally, so it can never be
`NULL`. Therefore, the check `if (tf == NULL)` is unnecessary and has
been removed.

The plane_state->in_transfer_func itself cannot be NULL because it's a
structure, not a pointer. When we do tf =
&plane_state->in_transfer_func;, we're getting the address of that
structure, which will always be valid as long as plane_state itself is
not NULL.

we've already checked if plane_state is NULL with the line if (dpp_base
== NULL || plane_state == NULL) return false;. So, if the code execution
gets to the point where tf = &plane_state->in_transfer_func; is called,
plane_state is guaranteed to be not NULL, and therefore tf will also not
be NULL.

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn20/dcn20_hwseq.c
    1094 bool dcn20_set_input_transfer_func(struct dc *dc,
    1095                                 struct pipe_ctx *pipe_ctx,
    1096                                 const struct dc_plane_state *plane_state)
    1097 {
    1098         struct dce_hwseq *hws = dc->hwseq;
    1099         struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
    1100         const struct dc_transfer_func *tf = NULL;
                                                ^^^^^^^^^ This assignment is not necessary now.

    1101         bool result = true;
    1102         bool use_degamma_ram = false;
    1103 
    1104         if (dpp_base == NULL || plane_state == NULL)
    1105                 return false;
    1106 
    1107         hws->funcs.set_shaper_3dlut(pipe_ctx, plane_state);
    1108         hws->funcs.set_blend_lut(pipe_ctx, plane_state);
    1109 
    1110         tf = &plane_state->in_transfer_func;
                 ^^^^^
Before there was an if statement but now tf is assigned unconditionally

    1111 
--> 1112         if (tf == NULL) {
                 ^^^^^^^^^^^^^^^^^
so these conditions are impossible.

    1113                 dpp_base->funcs->dpp_set_degamma(dpp_base,
    1114                                 IPP_DEGAMMA_MODE_BYPASS);
    1115                 return true;
    1116         }
    1117 
    1118         if (tf->type == TF_TYPE_HWPWL || tf->type == TF_TYPE_DISTRIBUTED_POINTS)
    1119                 use_degamma_ram = true;
    1120 
    1121         if (use_degamma_ram == true) {
    1122                 if (tf->type == TF_TYPE_HWPWL)
    1123                         dpp_base->funcs->dpp_program_degamma_pwl(dpp_base,

Fixes the below Smatch static checker warning:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn20/dcn20_hwseq.c:1112 dcn20_set_input_transfer_func() warn: address of 'plane_state->in_transfer_func' is non-NULL

Fixes: 285a7054bf81 ("drm/amd/display: Remove plane and stream pointers from dc scratch")
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index b60ba2a110f7..58fbdd535068 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1109,12 +1109,6 @@ bool dcn20_set_input_transfer_func(struct dc *dc,
 
 	tf = &plane_state->in_transfer_func;
 
-	if (tf == NULL) {
-		dpp_base->funcs->dpp_set_degamma(dpp_base,
-				IPP_DEGAMMA_MODE_BYPASS);
-		return true;
-	}
-
 	if (tf->type == TF_TYPE_HWPWL || tf->type == TF_TYPE_DISTRIBUTED_POINTS)
 		use_degamma_ram = true;
 
-- 
2.34.1

