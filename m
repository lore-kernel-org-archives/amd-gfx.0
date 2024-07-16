Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09129C3DA59
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 15:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5280A10E77C;
	Tue, 16 Jul 2024 15:25:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AEgAKoCa";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E39410E779
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 15:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tm44P/EvBYnKKasmXjL+u6Q5AUXQETq0C/fXOQcziWmTLADvLNaV4wungj9RClNqy8ZlSj+kZo8O+Tx8e/Ql0M3raTGCOzY0xBy3r4bo20s/Czcxc/iahe2nEXneArSJyWXKmpodUxarsmwI1sZlD5fr0Oy+bbrjFjY2RMPtDk9M+u6FbomkiOM0VsqqHW0eDGWFsK91N36eiegywwr8n1RLRuN8wI0MIKb5eL1xBkJsA7U9QyQ5aOTyYBPmRjDd2GVPkt0qXtfkc3SOpqIUUdWmlbqQPPOiUNM23Esp/8y0xR2IM46zYIuWOsSvrKp7hiT+9xPk4UUKfNUcbF8pYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apU82IfdTxMs/PI3ZUipodmy7d6oTKiLdlA/gXUfAfw=;
 b=gxMwLcmt9SKgtmYe68Sk8Ge85l2wFR4DCPM9p5BMSKGDBu1OXsJHLr6qLMODO8QcgqdtCPhoqCOveKGmHyvkODCE4AGr/+N89tLXoiN3ZWKDKeqDmE4A6otFqVEaPk3QasGEDN8M0z0kiYfHMAVL84eYgUqt5KSudZJLIYwInkZo+8eCFWhD6m08BvZgQ8g5t7I5ittfGtAkYlDjo9nfhwih5urCy2bBh3/QcpNMLP42pXgUyYtAKSNWKowX4Tyx3wYmwW4ZzDcwKnchVaqoyDb+zCjET/bJroteCB7BzhNM7YFfVQFSTtuB8mUZiqOuAoOo/QSdSfNCvo36vh0wSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apU82IfdTxMs/PI3ZUipodmy7d6oTKiLdlA/gXUfAfw=;
 b=AEgAKoCa6+/PNthTTcaYs+Qf9oFuspjf1qTMWNcp83RjIryKPwGxw311nWs2aQdErpRjeoMdE2OfX/YE5ajdiMSWtms/zixNsDJK3nktLTzHnildikp5pCCvePGWBLNJil15lEbj4DQsOyudsYUsT4zqtE8z3+DX+Sg/UR2ylac=
Received: from BN9PR03CA0440.namprd03.prod.outlook.com (2603:10b6:408:113::25)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 15:25:14 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::96) by BN9PR03CA0440.outlook.office365.com
 (2603:10b6:408:113::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15 via Frontend
 Transport; Tue, 16 Jul 2024 15:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 15:25:13 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 10:25:10 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 "Tom Chung" <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Add null check for set_output_gamma in
 dcn30_set_output_transfer_func
Date: Tue, 16 Jul 2024 20:54:45 +0530
Message-ID: <20240716152445.228728-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: d46f3637-b622-420d-3500-08dca5ab7d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cWDca+GUzH+wHUBv5h8Q4EegUx/6emAhXjC8etfqNehpyeQoh8C/qVcYhIN1?=
 =?us-ascii?Q?iBwzrWvSVDUECVn2p7aX/nd2icPvyjEdcGI7NcjqTFqlL3dUjMfPGThggBI+?=
 =?us-ascii?Q?muxC/I+n30dwOinNpsSFU5sphHdAFd5RDcWcQM2su2piGF0cyuuEpKkL0oEo?=
 =?us-ascii?Q?wDl+e3lPC7TH6VQDkihrGV1+uQTxXMRtZs/lJrQECGxK/icMTWr+dTUyMIuv?=
 =?us-ascii?Q?Jq9s2GQFLMw9CvX2Hi8xmrUnxoKJb472yaHFbtsScJjJhUMP/YuTNfntD4ao?=
 =?us-ascii?Q?cP4dMATeXVcX1mIXguDNdOljI4MLNCD0ValpCA5VwExjbxp0KZIhAZYG7vx+?=
 =?us-ascii?Q?dbNhmWzu2i8oFi1kkGer7Py56KbhjugyFhUfDF8PQMUyz82hC4Dg1EZO6z2Y?=
 =?us-ascii?Q?bodiU/Sc5BoIcKLdthtTd264J2kZvo5StTNty+TuIKCCo0JuJ6H7hQ24cydo?=
 =?us-ascii?Q?tZbVKEWb2ydBC2t7ToU0dl5NhpZiRjxHw27X/hALgyEDq+O7jEJPnm9eDruU?=
 =?us-ascii?Q?2IUjWq/fsV8JPgRL6xMz852QA6MElSBQW7NLx/YgNqiZIr1c0x1P5ScyFGHk?=
 =?us-ascii?Q?+nuUNRaBBVMCZ7+GWw9FgPFt/CSUt0XSsObEHgTj3fR3l83RybRIBUqJ/KPJ?=
 =?us-ascii?Q?+Fbr5gGY4g79Nm2Kd+NaOVnrzM3J230k4KtVWit95njjyL4Gv45WXn/gADVP?=
 =?us-ascii?Q?GyNnzhIGt6709dktg7RSsnxuKpgiJ6UxUYl9P2ilyXdqZOpe+6OQHq+ka06u?=
 =?us-ascii?Q?GfDhzuVxsvjm7e8X6XADpoJxD6EaC/4/qv+Y5WtV28C5Rd11kzOsLmfMHJm2?=
 =?us-ascii?Q?gPt2Th35204TnJbPO1Hb37B7yBnCdOZi0tKFIEB5Mzbcg+7B8i5oQcJY5FRX?=
 =?us-ascii?Q?IbYCL7Vp9Mof0HLao3ECCiAcpFI2OZ8WBZbA9fkE7swKmMLYBUpmGQGvdk2E?=
 =?us-ascii?Q?3HAOdynh463qyE4qkf/1auGOHr8UUT2B1TXQkNYYHiv2SVatYZndnkOeo9Jz?=
 =?us-ascii?Q?1vzdPF4inDFVERBTO379cPQ4SUkKWlnoqMRZ55m3hVo0+A8yB4b35uIGyJDq?=
 =?us-ascii?Q?Ve6dI2pB4zkYO0nep98Juar+Io04t+cHnKQhACzO524+yTMoLGiwgBkZTKxt?=
 =?us-ascii?Q?DgVlY5VVcjGp4ykDmT1ECKhaa5K/udLPKLU0BA1mtWm+xzQQJbm6TMmpkqTX?=
 =?us-ascii?Q?dx4EdTgF05kn3NU4W1Ql0BgBe8CgRU3QGorzSYuURafJhmrRy7D73bipQfak?=
 =?us-ascii?Q?R8Xj1P4lxaXwGB1Nc93WIJrm7SbFk+hgeAKrz9E3SKfALR3R7v/1KfnyEwoY?=
 =?us-ascii?Q?9jVZggB7VvDfoucQx/i0CPMoHAk/QrVhLkwUiExUyfC9x9Ybt6LBxwVEC/44?=
 =?us-ascii?Q?mxxh3WAoMpgXew5ucZ5TTxeTDdQ0z2Vad+b8BrIUGeACXgz6Z7pD/NAW9D0w?=
 =?us-ascii?Q?dub43A4N2Gf1Ns9BCF1eJTPIgIaBAlNU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 15:25:13.6592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d46f3637-b622-420d-3500-08dca5ab7d23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
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

This commit adds a null check for the set_output_gamma function pointer
in the  dcn30_set_output_transfer_func function. Previously,
set_output_gamma was being checked for nullity at line 386, but then it
was being dereferenced without any nullity check at line 401. This
could potentially lead to a null pointer dereference error if
set_output_gamma is indeed null.

To fix this, we now ensure that set_output_gamma is not null before
dereferencing it. We do this by adding a nullity check for
set_output_gamma before the call to set_output_gamma at line 401. If
set_output_gamma is null, we log an error message and do not call the
function.

This fix prevents a potential null pointer dereference error.

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:401 dcn30_set_output_transfer_func()
error: we previously assumed 'mpc->funcs->set_output_gamma' could be null (see line 386)

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c
    373 bool dcn30_set_output_transfer_func(struct dc *dc,
    374                                 struct pipe_ctx *pipe_ctx,
    375                                 const struct dc_stream_state *stream)
    376 {
    377         int mpcc_id = pipe_ctx->plane_res.hubp->inst;
    378         struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
    379         const struct pwl_params *params = NULL;
    380         bool ret = false;
    381
    382         /* program OGAM or 3DLUT only for the top pipe*/
    383         if (pipe_ctx->top_pipe == NULL) {
    384                 /*program rmu shaper and 3dlut in MPC*/
    385                 ret = dcn30_set_mpc_shaper_3dlut(pipe_ctx, stream);
    386                 if (ret == false && mpc->funcs->set_output_gamma) {
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ If this is NULL

    387                         if (stream->out_transfer_func.type == TF_TYPE_HWPWL)
    388                                 params = &stream->out_transfer_func.pwl;
    389                         else if (pipe_ctx->stream->out_transfer_func.type ==
    390                                         TF_TYPE_DISTRIBUTED_POINTS &&
    391                                         cm3_helper_translate_curve_to_hw_format(
    392                                         &stream->out_transfer_func,
    393                                         &mpc->blender_params, false))
    394                                 params = &mpc->blender_params;
    395                          /* there are no ROM LUTs in OUTGAM */
    396                         if (stream->out_transfer_func.type == TF_TYPE_PREDEFINED)
    397                                 BREAK_TO_DEBUGGER();
    398                 }
    399         }
    400
--> 401         mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Then it will crash

    402         return ret;
    403 }

Fixes: d99f13878d6f ("drm/amd/display: Add DCN3 HWSEQ")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index eaeeade31ed7..bd807eb79786 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -398,7 +398,11 @@ bool dcn30_set_output_transfer_func(struct dc *dc,
 		}
 	}
 
-	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+	if (mpc->funcs->set_output_gamma)
+		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+	else
+		DRM_ERROR("set_output_gamma function pointer is NULL.\n");
+
 	return ret;
 }
 
-- 
2.34.1

