Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE280C3DA61
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Jul 2024 06:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE2710E1B5;
	Sun, 21 Jul 2024 06:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jjGovszJ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 904BE10E1B5
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Jul 2024 06:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUg5dzkGF5tpRUkHueoxoLcZ6DpBX9JvzOjBKvf8zDIPR1VG5Dq7wetFW59ciA/JHtoZGljQ6sGjGyNgQrS8swUKgfspI8bECLacQm2fKtJk4/LKOYl9uQ1cuJlX23h9lzwklEFZS+Gvt/SAnH++jly7TMzwtD9GuhZ6xzniyvkfT9p9gjr94oEKIsSMtemHYPeGclzW5s5NrDyCyjXDpOXCIElNFl/53Dm3bfFRuFb3KdJ73096d1rwWHVP0CuCM2xmQ1ZJxnyPxj7WhKK0eigirgnwgkoh3a4gwr99ti/+TEr3wXV+nQQJ8aOT7S0FiBHRMaU5Wvq7YK6fprP7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apU82IfdTxMs/PI3ZUipodmy7d6oTKiLdlA/gXUfAfw=;
 b=fSSbcNCd7EyP8TxQ4BnOLOPfnZPJ7B1tTTpLFF/7gUZt6UmSUO1IK7gGpLjXnRo7hjsg1N2Ox1SkWDn27dF2SDuvAmyWj2NW3plC/8Znm1ckJHjpZEFb8aKXXofAV8IRLrAHFt0aouGQV7i0hVuKCNzmokV/E0XQlBvE2j8QzeeroO5ExT2HzXGVW7x9Q0AQ7zYeNx5vnrTCgfTLZSjeQ/UEEiPGqJT2eELlOnGMtLGZjr9/0mFQWuHfaUTEIOJyabOqGQF/cHA5W/8wmxAh3VC1khZZspTm+kAHzZFU7cqwFT+5HjUQOgDnYtvCKOuAvClFFp/+yuQ69uTT0751mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apU82IfdTxMs/PI3ZUipodmy7d6oTKiLdlA/gXUfAfw=;
 b=jjGovszJewW6wU8YQRDSMm7Z93Ne0CCCKeADLmVlmTIYJOjD5Ci3cCeJT+mir2omGUoMCfkyvxY2U6PKLmpEBZ6PnD/FyEoO+yfnyDVMV9N/C4G6Y8SG0N2bBsk/0cFrhdpPgF2Pcx1c3lIvHUWfstoRUFe+sqMdxsvPUPwsCJY=
Received: from CH5PR02CA0010.namprd02.prod.outlook.com (2603:10b6:610:1ed::22)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Sun, 21 Jul
 2024 06:22:44 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::33) by CH5PR02CA0010.outlook.office365.com
 (2603:10b6:610:1ed::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Sun, 21 Jul 2024 06:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Sun, 21 Jul 2024 06:22:44 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 01:22:40 -0500
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
Date: Sun, 21 Jul 2024 11:52:13 +0530
Message-ID: <20240721062216.3151119-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
References: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: dc968308-02a6-4a5d-599f-08dca94d884d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6ssIVboPpzhglure/LJD8EQTiibZamyCdIIYzT01o8UIlH787zHhAdaq4AIz?=
 =?us-ascii?Q?J5EheoyqhKKEqXHHvtDMd2mC/LquDmsYES8MuKMdNdourXzc4UFb2avMQ9Op?=
 =?us-ascii?Q?7yVVRDY+bLp9X/tTKVZFIQlNg22jF9JccgszM+6EXPCLxeL8vIfBU1zp8kKa?=
 =?us-ascii?Q?9+Ot6jYmPOJm28htS8wemUmYy6ZVjfRqYsBFmpPnB9jqR4gr2K/U33XAXqpC?=
 =?us-ascii?Q?Lf4cywMNmbsq5lsQ0m9/zFTXIGm0pSs5xvoKx7GCVW58wAXYNwe9ElJDNFye?=
 =?us-ascii?Q?I58WZtC6zwEIyZoN/QOOqtNRz59OS+V9Nwp5I+8UA2JA+wLcuFhkk6v/aj1N?=
 =?us-ascii?Q?Zou10ytcXvzdkcFrRrxtUU9yFv3AGXg5Ia+NL7CgXWUHKwjz5dR0jKYCAQgF?=
 =?us-ascii?Q?ESZCNB3xsas4Jp+3ElHmFSs1S0kiJPWuIkzevGIhW5/2toVc+/7sARPtFUVl?=
 =?us-ascii?Q?tgNxpn3QKxUXmqn6kUqUYKoTFl51qatn1+H0YgpCD9AGDkWvMZ1j7b+Wlt9M?=
 =?us-ascii?Q?EF6tkCxs+4k0Zx0Jq5YYBGIBk9gcYNaRIUIco35VKvK/25uKwacPUsXavUOY?=
 =?us-ascii?Q?g+k4kk4cQbWfYaQ+J+td2gO4XVGGXAtIK6exFOu9z45h5rEuxVnQrIr4+mjr?=
 =?us-ascii?Q?fgTr6lAcWR3d9A4HuBKR2nXSRayt9MTnzMs/HKO/vz1T/aCyelEHGkVyjm93?=
 =?us-ascii?Q?/hxxx1iG2qPjsSJtYTZFrXj7nRlVovbmSHQyQXMCG4X4+eq/fYSwslW8zWyA?=
 =?us-ascii?Q?o3MVPZe+4lcII6SFv0VZmWwMAcintuNdYZiGRxQPUCfliaFCSo+6paqksJGB?=
 =?us-ascii?Q?9aAtJDnp3WJbx8SYe5a8nERjU9EJTxoPGW/ybJAdLhw1BzEjlS9W7olF2FlK?=
 =?us-ascii?Q?4h5jIZi3Tajsy7B26uj4V19kMYj+/lsUN6HM3HiIzFNyysFCmndYZh6qTqZ5?=
 =?us-ascii?Q?XVWQwmHUqucCV3EnNEWkUfmEyRI3+mTnlgRd/UZYCbVoCz/LoV7LCYcjxFNy?=
 =?us-ascii?Q?DlIe56CGiVQ0pI2zuvbD5KS7lmnJEniRZK1FapgIp5r2jqCC0maT+UhvPaWc?=
 =?us-ascii?Q?UfMJ5PCPoN316kSM3L7Uzd2YqAE695ekyKAtfM7sqp+bD+NmnXv0rlDvS1hZ?=
 =?us-ascii?Q?n/H8GJd4sNe7ZGYi9z6DZ0xswJeFCHux/yxnN3u5oe0wIMoG7MqBunvd4bAd?=
 =?us-ascii?Q?xU/4faYGA7ilCYsxqkYB4vcFnslpabxGTK3NbVMR40IfzpjD49JrSpuYfSaW?=
 =?us-ascii?Q?50rVz0gFvrDCHS6v8UrHJzYIQ5o/5xIBmcZqZNIUS8sLRy7kQa8zqBGwaaqo?=
 =?us-ascii?Q?7g2ubUtUMMPdQMpVjV9fdtyFXNRusAmEVoj54Q017NSn9BRdmSn/7vWgCZCb?=
 =?us-ascii?Q?3hEHXYLOesBmJBgMLQe64LrCy46hjg9Y1+R/VGAl5X1wYFefS5BuDUL1yJiM?=
 =?us-ascii?Q?ZUrD0rlSMO35Gm9tUwC1idgPqPjpDuk/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2024 06:22:44.3176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc968308-02a6-4a5d-599f-08dca94d884d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938
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

