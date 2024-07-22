Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D5FC3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 11:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1252510E4ED;
	Mon, 22 Jul 2024 11:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XmtTwoGo";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9949310E4ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 11:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goqD9VW44irr+Mhx0Sf00pYJ1/5RKVRkOVaHC/njof6JBOti+0DVo7HHMmzg4IO2V/nIKx4pK9XNjnG1Z4PnbmzLo3ediVWtReeOkpLoO2vAiaws8EbRlXA/BE9nYH8uuk4Ja92XzCtahcM4bwX44b0nYH2aMhC5Qk0o1KALKvCYXJ6ixZrOose0n+UeNU69CDbkRxvoRMuJVaaHTZ6wNU3HTJWRoT0hT9bXpvrcCvrNNWy9y+ug+uxpzeNjhfDJsQDTnrgOqpAopeaOdAUA9FrbFji30btyEG6PFdeO40SO1Yx/vy8VUrJQ7xXJOSCpIDsQHwctPNLzuFQoZDUUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BAcoXzJhGew3ExOhzncYcbmUkc9vW/kfTmnMiVPydw=;
 b=Pw6eK7G7sJUbIGyGgm6fvLaKOorpOzf6cv1e4Kgok8AuvQUVYdlI0onTPcJbUnOyvUaofH61JRAQmgx7hmZI6BEuqZmaaG3egAly7w0KvhjG4RySwZsF/we3eCOtvj6PQXALNNco+lNsEKbWLeX+Gk+Gv/1MaFanF2JWWU+Iq8XOX713RXkx+Ee9DQe6s2dq6GTY9eM2p6dSii8Ak8BjF3zOoPMYE2N7bygtp76BDRyFhsMk/9RQU+wIbg8YjFhzVUa/jGpMEvJ30GACCbE/FmvAgveUxJqA5ooA6IexLypXWoNena1fmLPs4ZavDV6XbBil3JU9fc4ijqSmIGi5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BAcoXzJhGew3ExOhzncYcbmUkc9vW/kfTmnMiVPydw=;
 b=XmtTwoGoRluQFnwZvh/mRTTrzKoJ0WQwMCb/GEVrWq6AKiN2ZMUk6t9scobdD5VwXR1c5PhPEGOWhRpyecLPWyDtDbsPwMSzR21Bvz3srHY9GEINNrvQXyj4NNVSt9utTguHQf0ncPxreZWKXs+K71DCox8CBfbP7XjwLzZqK8w=
Received: from BYAPR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:c0::28)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 11:48:39 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::ea) by BYAPR05CA0015.outlook.office365.com
 (2603:10b6:a03:c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Mon, 22 Jul 2024 11:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 11:48:39 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 06:48:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 "Tom Chung" <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH v2] drm/amd/display: Add null check for set_output_gamma in
 dcn30_set_output_transfer_func
Date: Mon, 22 Jul 2024 17:18:17 +0530
Message-ID: <20240722114817.3935101-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716152445.228728-1-srinivasan.shanmugam@amd.com>
References: <20240716152445.228728-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: ed209696-20d0-4a2d-8159-08dcaa443a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WOOJ0nPbx6D60A4ViQqfVRk7r6+QMa6D8REAcirZD/I414WgR3nRXwTM1qC5?=
 =?us-ascii?Q?ePMYTJ/Wz2zE4NjNAUJ3jiJlYbsapcmu0o/U9AI2rOtD4hZNPa+VgwWe/7VT?=
 =?us-ascii?Q?L91v40JaQY7XfnmryKs5ULmBX8LTooCIiEuGIs0FOWc3hFztS2ZGRiwStmib?=
 =?us-ascii?Q?gZMzvEyLcCSl4b1n97oShfHF2EztUzsqQnKHa4EXzJFueT27r9MCsG+EDjgZ?=
 =?us-ascii?Q?LC9TNubMQgI3iSN4xk2wlfTj4s4kFjbns/0a0aX2LyLuu6XDIrTI9/sAGfq4?=
 =?us-ascii?Q?jp5D/O5pdYeiu+ZrndXrOZzbW9Y23ZJioyoEofBEGBMTgusd4wrF9RsJA8ha?=
 =?us-ascii?Q?gw8pQKE+b91qkvvCShPh9fWW9HeCFuPRQ1F7lSH5WwGZ0hv27IBY1zsT/1Ti?=
 =?us-ascii?Q?g3B6BOT8mIwAvinSkv2Qg52tAhdvQwN26iVj1BTOXqPq7bwWvZ5Ie1MUGQvh?=
 =?us-ascii?Q?1K03hlcX1bY2+l9MYF3SZrT3aCKcjfiJJglmNpIlwwcxHn7qHOdt6ikdIUHy?=
 =?us-ascii?Q?9lhJihLcKxeIbKNdTCRJKRCqcy+85Fp+q3yMmefkEz3BDJFsWjmsszaOKd2O?=
 =?us-ascii?Q?cLii7+vrhO0F4gc4GyBm+CDEhJBFdqciMovzrEOXZLqUBW8/rN2sV4PnlaBK?=
 =?us-ascii?Q?IThG5ykdA3Q8GFLDwakgqVA5OE9zqvb3/803YVkM69w4AQSDKb4rGFKQES9m?=
 =?us-ascii?Q?NHBQPcXWm2BE33RMcJK/FsqVDubRM471oM72cnpbLFSVL05DuCOKDHGXBf7v?=
 =?us-ascii?Q?QjEaD2LFKccXVWVUBjR8QpzHvgt+W5WwLfAekaLvxOZ65OUp4L10ZMhmY9ti?=
 =?us-ascii?Q?cfoSEX0brBzZsYLGDoS5lFFQOPuApfjrmbgc0AKNX0ZfGBc9IdzCdHVOaHzk?=
 =?us-ascii?Q?oMoJciYYoy5aGO4vX43B8vcczU8kFbOz9pMscG5jJP/7HP2RnQ59gTPHh9sS?=
 =?us-ascii?Q?xBmh9n8BjBBzKRfYkhH0StXKQC0P/m/wgQASbm3A7HO+QBCnwEzgRqFuBLnD?=
 =?us-ascii?Q?bdW75h3QMmOgnuD6wxR4gVrsrgn1kNnMe4DBqDyl1iemlXLlxFCRLA3L65Yb?=
 =?us-ascii?Q?BkK9uTZv45GUawmu6kkpEFvPqkxaRElJluEkf2QeC1a3h6bZSJpY6FFwzjxd?=
 =?us-ascii?Q?N3fpetdFPLBFmpNcae8pX4kRprSQWgk0ARugsmkDSjGRiqp1cu1L03hTNb/V?=
 =?us-ascii?Q?YxIWK4H/iyIcVl2V5XfWJX/TEKB102MhFrF3+/88S86bQ9kyw91K2JhPlHP9?=
 =?us-ascii?Q?GliqKKYDTR5A2DYcsU+9OBMgnxCuVLw6cUD+rIYtmjUYSP8EcIm21zBYcSmy?=
 =?us-ascii?Q?vPWe+da0tAah9KudsjThTW7xCO75mkjXTywEml5Vt8EdXYg/zT5pHNOESI2W?=
 =?us-ascii?Q?YkBqY1Gcay1eGg50B/L4dxBKZhpKMr6HpIp+EV3bQpIl034ZtV40CtsRSQkG?=
 =?us-ascii?Q?gj/GMuBGWKBDNcMq8ULgSdH4AfuYN7qr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 11:48:39.1934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed209696-20d0-4a2d-8159-08dcaa443a5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273
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
v2: s/DRM_ERROR/DC_LOG_ERROR (Tom)

 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 98a40d46aaae..42c52284a868 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -398,7 +398,11 @@ bool dcn30_set_output_transfer_func(struct dc *dc,
 		}
 	}
 
-	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+	if (mpc->funcs->set_output_gamma)
+		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+	else
+		DC_LOG_ERROR("%s: set_output_gamma function pointer is NULL.\n", __func__);
+
 	return ret;
 }
 
-- 
2.34.1

