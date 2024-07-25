Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C4AC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9149F10E8A2;
	Thu, 25 Jul 2024 18:04:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ubOiD0bv";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5EF210E8A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnARdU/WCWl9l+xCqhoiC3qu91WiDIVSKVF2VEwTeNFAdty8lCh1SO78j3mg94e7iTOBhfYJHDYxKIG2q0Bs6VirIRrQdbCYc03kK2SLGBefOUSNNyJuoJJZZvnPHK5O/lLyOm9i2XnDkSOsbJ11nZisiOgmfgMpCv1fZ8gYXiLC9+DwIFABx3EIbkUg3BP+ExWOKsPp1B5yW2Gos34mT1Czmwkr33kw6tm7LmJ5KR7emKFeuXCQVihU4ttHXD2mmBpLrjZkzQAHHjGHChVkrxsDwr8LT0MlUEG6i8yZY9dXgUM6/XxHUIivMgDUfPy1k+CI8P5MGsirYqeNaPWwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqoBrtapTV8h/a1HPY43k//OS0SeNND2qsCifl7qzHw=;
 b=H+CaM0oeFyeMkyWxvQR+h/ScmXzC3ZFMQbl199LUTXn2RQvBx3F6jxGD5UtcCSZH89kaOETLoypeW5nZ67P2UcJgKEYKZOsuoCQaBrE1/tZEUKzoS7+gKWAYMT2l1lJEiMbRWCSCVzDWVBcFRGAUlsXCOlpU4JJbZavkIHI3vpH0w7EFdD/pO4EerzjqLHv5WhfZpDI7Z267ySAtEfr7U7Lw9OxuUElv9JtaAGTeRvam1F5jmR1c9TwofB17VjsEeaNn6fhblu+G+aJLbkhyvyrjZ3JBOiduNUw+a6/78kkOu6AJfgfLolFzIYtnZ9pDkpk31nQ+RvGDuJZfa1mQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqoBrtapTV8h/a1HPY43k//OS0SeNND2qsCifl7qzHw=;
 b=ubOiD0bvBifS5gGekj6L7lztRWNV1vEg41SdMng/eXpm9zk7u7R7JZcd+8Ow3EW1dYBM59XASU5whZRouL5AK//QECD/siyE7HKT8B/PDPzA75GyhUoLToAFMpoB6n6W9kmb/wggT9FL/nUA/JmUgd7Ywq3gkwanNtse/bCy6Tw=
Received: from CH2PR10CA0029.namprd10.prod.outlook.com (2603:10b6:610:4c::39)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 18:04:04 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::6f) by CH2PR10CA0029.outlook.office365.com
 (2603:10b6:610:4c::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:04 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:01 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Ilya Bakoulin
 <Ilya.Bakoulin@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 16/39] drm/amd/display: Use correct cm_helper function
Date: Thu, 25 Jul 2024 12:01:00 -0600
Message-ID: <20240725180309.105968-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: af5c39f6-2c05-4a09-bd3b-08dcacd42b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lUM6amBx6X9P5Yx0AKlzizquuhBY9cMnrLFPMbdYxF3Gw2GfzHaYNsdpOrLn?=
 =?us-ascii?Q?klkH7AmKb5bSZzUP0rZHxHferV/AokJ6Y9WTtzJnukCuLZx0u7Nzcn9tJR1k?=
 =?us-ascii?Q?mJzMIWgXbV1V6j00bjdy8aY2f935zeXkjgdRV9DuDONr8XjHoAV0KR10c518?=
 =?us-ascii?Q?/kGg2ZCK+bASAaylR1AGd5OiyrKOCs2p87fbpetfRvJvoJazXmzpZ3LD8810?=
 =?us-ascii?Q?Yjh93SJJ0nxasnrMaawbwsi9C4CTwuV6hTuyi8jNtzGorwXC4WLSM67C75h+?=
 =?us-ascii?Q?A33laOSMs0uhEEplMhj1nvhPi+oVKW9Dvwqdlx60vRqcpakHxJtjZV62MZ9w?=
 =?us-ascii?Q?babGe+LVCTTCHShRtfElxoP//RcGx2tGmQccQwwvucGEl1Je/6bkl+WROPo2?=
 =?us-ascii?Q?YwfMVc6qUolbse78aShpnJd2aIEUkA9FAGLP8dzAsCd+zGx0zq+wy8KN4jlH?=
 =?us-ascii?Q?Mwx6+CcYNRZR3BrVoejHAT3rfBhTuMHu0Vr9bTodI014pnXhm0NAR4wg6/8O?=
 =?us-ascii?Q?xhaFidGl76Lubf0509zkNK81C1fKh/5ti0tHZr19fUDXiPsKtduFn2qcc27r?=
 =?us-ascii?Q?u+4FkVglT46xS+6G5QjdxTcsxF6+piBlwVD1akjg+6mrWa2w+ZGv5toC68WO?=
 =?us-ascii?Q?Gq+jEOmVwKi9bFaa6gi6QMnmnynMaV6+LZzGe2jRYxeOT5eSam4ZDJYGaQlk?=
 =?us-ascii?Q?JnPtbgwXmWK8wIwspYu7Kb4BHDVg1ljMarwkPQcz74dcEMKATtQWvKrEUxED?=
 =?us-ascii?Q?PK0N9Xqqh6wCW7BkdprEv22TMZmVmVVufiY1YIFkGVWwm/LffPNXrGshVsJR?=
 =?us-ascii?Q?5PX7OpNSJ/DqGOY4Jon7HmD9iqdcur0x6WNiHpC9EDhOqqEfMdQAsSOBrLSS?=
 =?us-ascii?Q?38SrEzxFVXD7XroOAmoSzePrmHaoCGldNhsO8cf9ihedCO7mwVmBfTZ5yIg7?=
 =?us-ascii?Q?9TJycUls0A8iL8yHmmzrVcCCtm4PwlrMSCMIeoKMXxsU0raSay6VhMUDYbg9?=
 =?us-ascii?Q?IYEy2k1MF7HNfZybiiIE8ilHEVguD+LgEy74YxXXzHfIQShzyOXBqKCvYEWZ?=
 =?us-ascii?Q?+EMW/dXPyJ93uXODf3mGA8Km5vLSFt8CXWkftkdLTGP6aHY46V5xeRgXDCI0?=
 =?us-ascii?Q?Y/SrD31+hEjMWpEPid1NOgR25PVeYgz/fxVjMzGuYk398lxRlf9CETwyjxtn?=
 =?us-ascii?Q?KDHarI+57wSNW1qEXyn+6SlGtLKgLIjOHN7YvNhQML1uKDo8QWYrfSAgK7em?=
 =?us-ascii?Q?W7Wt8fWNn3RnHC6H64+COiOUbjwf3ifK1ltku5M/BTasbvUvPqqMsIk/wLkd?=
 =?us-ascii?Q?hqWeEDsAr+JH/XmzYFo82wd2ublqMc0FR14Xu74nkwqTkMEAnBWMfGTRel0f?=
 =?us-ascii?Q?L5kjX63nIGMk7bzekPuVMfE0ZdRfE343PPiYkBmcpu0ZHwV6dW8uN5BQtHjb?=
 =?us-ascii?Q?ILJlYdUfhb5IJFK9H+lQLpDNIkF60d0n?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:04.0980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af5c39f6-2c05-4a09-bd3b-08dcacd42b8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

Need to use cm3_helper function with DCN401 to avoid cases where high
RGB component values can get set to zero if using the TF curve generated
by cm_helper.

Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 0fa610590245..8e1ca709d304 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -497,6 +497,7 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 	enum MCM_LUT_XABLE lut3d_xable = MCM_LUT_DISABLE;
 	enum MCM_LUT_XABLE lut1d_xable = MCM_LUT_DISABLE;
 	bool is_17x17x17 = true;
+	bool rval;
 
 	dcn401_get_mcm_lut_xable_from_pipe_ctx(dc, pipe_ctx, &shaper_xable, &lut3d_xable, &lut1d_xable);
 
@@ -506,11 +507,10 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 		if (mcm_luts.lut1d_func->type == TF_TYPE_HWPWL)
 			m_lut_params.pwl = &mcm_luts.lut1d_func->pwl;
 		else if (mcm_luts.lut1d_func->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm_helper_translate_curve_to_hw_format(
-					dc->ctx,
+			rval = cm3_helper_translate_curve_to_hw_format(
 					mcm_luts.lut1d_func,
 					&dpp_base->regamma_params, false);
-			m_lut_params.pwl = &dpp_base->regamma_params;
+			m_lut_params.pwl = rval ? &dpp_base->regamma_params : NULL;
 		}
 		if (m_lut_params.pwl) {
 			if (mpc->funcs->populate_lut)
@@ -527,11 +527,10 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 			m_lut_params.pwl = &mcm_luts.shaper->pwl;
 		else if (mcm_luts.shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
 			ASSERT(false);
-			cm_helper_translate_curve_to_hw_format(
-					dc->ctx,
+			rval = cm3_helper_translate_curve_to_hw_format(
 					mcm_luts.shaper,
 					&dpp_base->regamma_params, true);
-			m_lut_params.pwl = &dpp_base->regamma_params;
+			m_lut_params.pwl = rval ? &dpp_base->regamma_params : NULL;
 		}
 		if (m_lut_params.pwl) {
 			if (mpc->funcs->populate_lut)
@@ -669,6 +668,7 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
 	bool result = true;
 	const struct pwl_params *lut_params = NULL;
+	bool rval;
 
 	mpc->funcs->set_movable_cm_location(mpc, MPCC_MOVABLE_CM_LOCATION_BEFORE, mpcc_id);
 	pipe_ctx->plane_state->mcm_location = MPCC_MOVABLE_CM_LOCATION_BEFORE;
@@ -677,10 +677,9 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 		if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
 			lut_params = &plane_state->blend_tf.pwl;
 		else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
-					&plane_state->blend_tf,
+			rval = cm3_helper_translate_curve_to_hw_format(&plane_state->blend_tf,
 					&dpp_base->regamma_params, false);
-			lut_params = &dpp_base->regamma_params;
+			lut_params = rval ? &dpp_base->regamma_params : NULL;
 		}
 		result = mpc->funcs->program_1dlut(mpc, lut_params, mpcc_id);
 		lut_params = NULL;
@@ -693,10 +692,9 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 		else if (plane_state->in_shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
 			// TODO: dpp_base replace
 			ASSERT(false);
-			cm_helper_translate_curve_to_hw_format(plane_state->ctx,
-					&plane_state->in_shaper_func,
+			rval = cm3_helper_translate_curve_to_hw_format(&plane_state->in_shaper_func,
 					&dpp_base->shaper_params, true);
-			lut_params = &dpp_base->shaper_params;
+			lut_params = rval ? &dpp_base->shaper_params : NULL;
 		}
 
 		result = mpc->funcs->program_shaper(mpc, lut_params, mpcc_id);
-- 
2.43.0

