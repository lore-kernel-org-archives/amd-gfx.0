Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55DACCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 663D310E8B8;
	Wed,  8 Oct 2025 18:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V+qXkEAd";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B605A10E8B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R61X8XmwUJ3SX1YAcpDE+2RsH5cEYwat/anb1xWHAPXngad0KeHV4tIKLtRWzAKOvwYil3MLceIzkh5spfMqENFEYA9SEkS2ysGL7+mbb5Jv1ao7Bsgu888vLmYDMRvPBlrvBXjHutxm/nB1Sojia243eWQDY0LsRixHmO+piymWwSdI0sdqKQRFCAxIIOjoHMEmm+4hLbUceETlslVm4Stbftz1gmEjKcoIS1E8duH4R7Vm693CF8h4Zrn5QiWbvFtzT7c8Py3xo+LIMT3FjeQE6KgpvcSCqhZUW5ecVPGX5OVodlZ6hItHQiA1iBuryWrX2nAVa5rsSsfjBIdvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVUWWvGE6c7MPLeQDGPJPZR070ULnX6HqV18z2nF4LU=;
 b=jVgFevWnec0NeTuYHeB+Za4krpgHz1gTv4vlheYBE3uPY3uHCSycm/0dluvbhb2eTwu4GXMfMxvEmL6gjkg3IXzRl+Xx8RgV8NZQ7mAPhlqE4PO1ZNjmwSMXLFjvTX3GKYkQ4CKdbRXwo6ipAEtLEYxuhEpZyANf4KV6faDDLkrrL8EYNCZyboGT93w2XSh+KOnqUSLfA2LkQHLRZVXmcxcYJkrtONdpuNkcRJ0v14rSba4PBkTVX0rXLBHPOx8io5t0i2cG+vh6QNXRNIGXCrQ5UjjXpHG1ln5ZvUBgvMCGVykWeTmibVdWVZi7hgePSXxAj/tOtrqNONHdDP3ZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVUWWvGE6c7MPLeQDGPJPZR070ULnX6HqV18z2nF4LU=;
 b=V+qXkEAdSjshLo/+n+uaYC8o6xn9B7uiQSJPB9qZ8cVfhqmRjCTv2jLJTvTJESpdg8VYs8bJsqPJvAvt4HiTRCxTamk5swTf8I5F1SHxJ+RNkPr7mPdfFDqKQj1EbLWdbP/oc/z4OJEM9Dt/V7z4Zp7R+E1KK2UOAWfuRPgmeTs=
Received: from BY5PR17CA0003.namprd17.prod.outlook.com (2603:10b6:a03:1b8::16)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 18:49:00 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::aa) by BY5PR17CA0003.outlook.office365.com
 (2603:10b6:a03:1b8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 18:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:49:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:45 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:44 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:44 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 07/22] drm/amd/display: add new block
 sequence-building/executing functions
Date: Wed, 8 Oct 2025 14:47:01 -0400
Message-ID: <20251008184839.78916-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 334be1ef-ca14-4168-edc1-08de069b5828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ex16txrx8EzX6g1dMqQpwuMsN85p0EduhRsbImIB6W5mvhXoMv8SCHmYJOF+?=
 =?us-ascii?Q?k6MvOZhncLL3jL0yOJl+J2ubGcviodZfneaOF9gF1Xu6Yt34LzFGt8IAuoAj?=
 =?us-ascii?Q?2EO9reQ7wVg3UGdu8dyN31r931vQ59J19Y27VT9srz+kz3rr11BkxZOp5sho?=
 =?us-ascii?Q?TvT127C/K+Fz++Rfdk1cZH8/ZXWDcURUvfT/y1rFKMASo2mmAmIwTBvtrraw?=
 =?us-ascii?Q?vUS7yH4esrkW0eO6avrvguJdvtiMZd/WeG0qa3lZa/UPZXBUh/VBVxKDKKOf?=
 =?us-ascii?Q?ZZ/2Fr/qOAu/IdJIEGbfssy9kjO2D3N048Qf1mKQ59i+YTz0UCrlV+LL9hmc?=
 =?us-ascii?Q?02My/xjdLlzi/i60kayE2wlgr+6TYJkmNWkdUhVzI0l5GPdpre4JCuh40jTe?=
 =?us-ascii?Q?FTxKNAAk0Lcg0acww+EDXtXkTHIHOAyRnI2Ki4noJNcoCNo7DhK1h7HL+mCP?=
 =?us-ascii?Q?F8iprIzUpJTPp2NSfLUzaoy016qhNSNYK6w9ERI7cIbjab7Ww/oX9YNHU2Qo?=
 =?us-ascii?Q?00CjBDV3BsIPZgexpFneP7rEm/5Lu6C0us1KcxHcZTjambV0TD8oXyOg/l4I?=
 =?us-ascii?Q?l9myN6g9ujRl8REBNWhtDtKqq7uXO3xD6mFgZJipO+KYhCE5qXq1HD0sL1o3?=
 =?us-ascii?Q?43VxikOtGZj22NRlVqHPzcsnpxfAEzLII+KnuYjEwD+P9c/4mGdxKdoszpUY?=
 =?us-ascii?Q?k6RZUbtyhq/3uIqeaOg2nRyslN1DUnYMk6lbiwodC1GxlXwyNnjngqgxTdX+?=
 =?us-ascii?Q?nOUB9shlhGsyonMEVwcA9gebUJhHOU1he5a4AqMGm1tR+EWtmULBq6QnP/aZ?=
 =?us-ascii?Q?Bf4fSsaJqvZfA8+cyKvrM0Mc9Q3oir/YQynq9OJUrZs/X5TzL8tiMo2OBYZ2?=
 =?us-ascii?Q?KjHOWcempqR42h4GaCgwc1HIro/KfJDihcZOmNEnJQ/NeJmUYRGO2Yy3i/R4?=
 =?us-ascii?Q?gZdswREV8To2Pq97a9K0E9gYJtp7tvgq0OWo2OD9yOWkjERh/89su9tjVbtA?=
 =?us-ascii?Q?7DN2VkHK0KgEaan6aC8IqViE306HwsWXH9+0P3e2K9xjBgLfIeQTqwJSZOCw?=
 =?us-ascii?Q?ic8V1Rq1ZymTJAtztUz7L0tcJjmo2naqN6jaVL5ZvRXNbshnXPMssE1vrll5?=
 =?us-ascii?Q?Pc+yYwui2T3Cr0jmAxriw3MKQgFo/7UL5WxEqPPPVVzotARJ35tRS92d2QIb?=
 =?us-ascii?Q?OKSjnllM0c+aY6Qw/BjyEy2ci/s7cRerINVbxFq+UG3ZkWyhJ2svYVlWv3k7?=
 =?us-ascii?Q?cYHIMHcf5z/cFCMSe3cLNIbzL7m7JgvoNBo5D+n933kKFuEYz9uQxSV315DS?=
 =?us-ascii?Q?Ex5fu/kFmkyglmbC5PaypkjQkDalFKggbSskEeTRJCd4xwK+l3RsLxOakcnL?=
 =?us-ascii?Q?jr0W9e9OYzK8kvs0LtTBgOLxeDMEdvuBiN5rF5AYi12jy6hODi1Sq9v6fK2o?=
 =?us-ascii?Q?vtUqU8ltIcv3VROmYNml9S8UevHhRRfg3K98IiYTVb8aJ9wyH/+Wb+b/dIWT?=
 =?us-ascii?Q?lwS0W9H/DS1qZgmuYYiBdnLsEcIY9bkUQC0Nw7j2yxk61P65fYSBuYqq9OrN?=
 =?us-ascii?Q?K68+Eq7Qz3B3oFXkNp4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:00.0600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334be1ef-ca14-4168-edc1-08de069b5828
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800
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

[Why/How]
Create functions for building/executing HW block programming steps

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 3161 ++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |    1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 1352 ++++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   98 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   17 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 1409 +++++++-
 .../display/dc/hwss/hw_sequencer_private.h    |   36 +
 7 files changed, 5878 insertions(+), 196 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 1bed3b14a287..16d916986fed 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -32,6 +32,12 @@
 #include "resource.h"
 #include "dc_dmub_srv.h"
 #include "dc_state_priv.h"
+#include "opp.h"
+#include "dsc.h"
+#include "dchubbub.h"
+#include "dccg.h"
+#include "abm.h"
+#include "dcn10/dcn10_hubbub.h"
 
 #define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
 #define MAX_NUM_MCACHE 8
@@ -784,7 +790,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 		while (current_mpc_pipe) {
 			if (current_mpc_pipe->plane_state) {
 				if (dc->hwss.set_flip_control_gsl && current_mpc_pipe->plane_state->update_flags.raw) {
-					block_sequence[*num_steps].params.set_flip_control_gsl_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].params.set_flip_control_gsl_params.hubp = current_mpc_pipe->plane_res.hubp;
 					block_sequence[*num_steps].params.set_flip_control_gsl_params.flip_immediate = current_mpc_pipe->plane_state->flip_immediate;
 					block_sequence[*num_steps].func = HUBP_SET_FLIP_CONTROL_GSL;
 					(*num_steps)++;
@@ -949,8 +955,9 @@ void hwss_execute_sequence(struct dc *dc,
 					params->pipe_control_lock_params.lock);
 			break;
 		case HUBP_SET_FLIP_CONTROL_GSL:
-			dc->hwss.set_flip_control_gsl(params->set_flip_control_gsl_params.pipe_ctx,
-					params->set_flip_control_gsl_params.flip_immediate);
+			params->set_flip_control_gsl_params.hubp->funcs->hubp_set_flip_control_surface_gsl(
+				params->set_flip_control_gsl_params.hubp,
+				params->set_flip_control_gsl_params.flip_immediate);
 			break;
 		case HUBP_PROGRAM_TRIPLEBUFFER:
 			dc->hwss.program_triplebuffer(params->program_triplebuffer_params.dc,
@@ -1011,11 +1018,296 @@ void hwss_execute_sequence(struct dc *dc,
 		case DMUB_HW_CONTROL_LOCK_FAST:
 			dc->hwss.dmub_hw_control_lock_fast(params);
 			break;
+		case HUBP_PROGRAM_SURFACE_CONFIG:
+			hwss_program_surface_config(params);
+			break;
+		case HUBP_PROGRAM_MCACHE_ID:
+			hwss_program_mcache_id_and_split_coordinate(params);
+			break;
 		case PROGRAM_CURSOR_UPDATE_NOW:
 			dc->hwss.program_cursor_offload_now(
 				params->program_cursor_update_now_params.dc,
 				params->program_cursor_update_now_params.pipe_ctx);
 			break;
+		case HUBP_WAIT_PIPE_READ_START:
+			params->hubp_wait_pipe_read_start_params.hubp->funcs->hubp_wait_pipe_read_start(
+				params->hubp_wait_pipe_read_start_params.hubp);
+			break;
+		case HWS_APPLY_UPDATE_FLAGS_FOR_PHANTOM:
+			dc->hwss.apply_update_flags_for_phantom(params->apply_update_flags_for_phantom_params.pipe_ctx);
+			break;
+		case HWS_UPDATE_PHANTOM_VP_POSITION:
+			dc->hwss.update_phantom_vp_position(params->update_phantom_vp_position_params.dc,
+				params->update_phantom_vp_position_params.context,
+				params->update_phantom_vp_position_params.pipe_ctx);
+			break;
+		case OPTC_SET_ODM_COMBINE:
+			hwss_set_odm_combine(params);
+			break;
+		case OPTC_SET_ODM_BYPASS:
+			hwss_set_odm_bypass(params);
+			break;
+		case OPP_PIPE_CLOCK_CONTROL:
+			hwss_opp_pipe_clock_control(params);
+			break;
+		case OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL:
+			hwss_opp_program_left_edge_extra_pixel(params);
+			break;
+		case DCCG_SET_DTO_DSCCLK:
+			hwss_dccg_set_dto_dscclk(params);
+			break;
+		case DSC_SET_CONFIG:
+			hwss_dsc_set_config(params);
+			break;
+		case DSC_ENABLE:
+			hwss_dsc_enable(params);
+			break;
+		case TG_SET_DSC_CONFIG:
+			hwss_tg_set_dsc_config(params);
+			break;
+		case DSC_DISCONNECT:
+			hwss_dsc_disconnect(params);
+			break;
+		case DSC_READ_STATE:
+			hwss_dsc_read_state(params);
+			break;
+		case DSC_CALCULATE_AND_SET_CONFIG:
+			hwss_dsc_calculate_and_set_config(params);
+			break;
+		case DSC_ENABLE_WITH_OPP:
+			hwss_dsc_enable_with_opp(params);
+			break;
+		case TG_PROGRAM_GLOBAL_SYNC:
+			hwss_tg_program_global_sync(params);
+			break;
+		case TG_WAIT_FOR_STATE:
+			hwss_tg_wait_for_state(params);
+			break;
+		case TG_SET_VTG_PARAMS:
+			hwss_tg_set_vtg_params(params);
+			break;
+		case TG_SETUP_VERTICAL_INTERRUPT2:
+			hwss_tg_setup_vertical_interrupt2(params);
+			break;
+		case DPP_SET_HDR_MULTIPLIER:
+			hwss_dpp_set_hdr_multiplier(params);
+			break;
+		case HUBP_PROGRAM_DET_SIZE:
+			hwss_program_det_size(params);
+			break;
+		case HUBP_PROGRAM_DET_SEGMENTS:
+			hwss_program_det_segments(params);
+			break;
+		case OPP_SET_DYN_EXPANSION:
+			hwss_opp_set_dyn_expansion(params);
+			break;
+		case OPP_PROGRAM_FMT:
+			hwss_opp_program_fmt(params);
+			break;
+		case OPP_PROGRAM_BIT_DEPTH_REDUCTION:
+			hwss_opp_program_bit_depth_reduction(params);
+			break;
+		case OPP_SET_DISP_PATTERN_GENERATOR:
+			hwss_opp_set_disp_pattern_generator(params);
+			break;
+		case ABM_SET_PIPE:
+			hwss_set_abm_pipe(params);
+			break;
+		case ABM_SET_LEVEL:
+			hwss_set_abm_level(params);
+			break;
+		case ABM_SET_IMMEDIATE_DISABLE:
+			hwss_set_abm_immediate_disable(params);
+			break;
+		case MPC_REMOVE_MPCC:
+			hwss_mpc_remove_mpcc(params);
+			break;
+		case OPP_SET_MPCC_DISCONNECT_PENDING:
+			hwss_opp_set_mpcc_disconnect_pending(params);
+			break;
+		case DC_SET_OPTIMIZED_REQUIRED:
+			hwss_dc_set_optimized_required(params);
+			break;
+		case HUBP_DISCONNECT:
+			hwss_hubp_disconnect(params);
+			break;
+		case HUBBUB_FORCE_PSTATE_CHANGE_CONTROL:
+			hwss_hubbub_force_pstate_change_control(params);
+			break;
+		case TG_ENABLE_CRTC:
+			hwss_tg_enable_crtc(params);
+			break;
+		case TG_SET_GSL:
+			hwss_tg_set_gsl(params);
+			break;
+		case TG_SET_GSL_SOURCE_SELECT:
+			hwss_tg_set_gsl_source_select(params);
+			break;
+		case HUBP_WAIT_FLIP_PENDING:
+			hwss_hubp_wait_flip_pending(params);
+			break;
+		case TG_WAIT_DOUBLE_BUFFER_PENDING:
+			hwss_tg_wait_double_buffer_pending(params);
+			break;
+		case UPDATE_FORCE_PSTATE:
+			hwss_update_force_pstate(params);
+			break;
+		case HUBBUB_APPLY_DEDCN21_147_WA:
+			hwss_hubbub_apply_dedcn21_147_wa(params);
+			break;
+		case HUBBUB_ALLOW_SELF_REFRESH_CONTROL:
+			hwss_hubbub_allow_self_refresh_control(params);
+			break;
+		case TG_GET_FRAME_COUNT:
+			hwss_tg_get_frame_count(params);
+			break;
+		case MPC_SET_DWB_MUX:
+			hwss_mpc_set_dwb_mux(params);
+			break;
+		case MPC_DISABLE_DWB_MUX:
+			hwss_mpc_disable_dwb_mux(params);
+			break;
+		case MCIF_WB_CONFIG_BUF:
+			hwss_mcif_wb_config_buf(params);
+			break;
+		case MCIF_WB_CONFIG_ARB:
+			hwss_mcif_wb_config_arb(params);
+			break;
+		case MCIF_WB_ENABLE:
+			hwss_mcif_wb_enable(params);
+			break;
+		case MCIF_WB_DISABLE:
+			hwss_mcif_wb_disable(params);
+			break;
+		case DWBC_ENABLE:
+			hwss_dwbc_enable(params);
+			break;
+		case DWBC_DISABLE:
+			hwss_dwbc_disable(params);
+			break;
+		case DWBC_UPDATE:
+			hwss_dwbc_update(params);
+			break;
+		case HUBP_UPDATE_MALL_SEL:
+			hwss_hubp_update_mall_sel(params);
+			break;
+		case HUBP_PREPARE_SUBVP_BUFFERING:
+			hwss_hubp_prepare_subvp_buffering(params);
+			break;
+		case HUBP_SET_BLANK_EN:
+			hwss_hubp_set_blank_en(params);
+			break;
+		case HUBP_DISABLE_CONTROL:
+			hwss_hubp_disable_control(params);
+			break;
+		case HUBBUB_SOFT_RESET:
+			hwss_hubbub_soft_reset(params);
+			break;
+		case HUBP_CLK_CNTL:
+			hwss_hubp_clk_cntl(params);
+			break;
+		case HUBP_INIT:
+			hwss_hubp_init(params);
+			break;
+		case HUBP_SET_VM_SYSTEM_APERTURE_SETTINGS:
+			hwss_hubp_set_vm_system_aperture_settings(params);
+			break;
+		case HUBP_SET_FLIP_INT:
+			hwss_hubp_set_flip_int(params);
+			break;
+		case DPP_DPPCLK_CONTROL:
+			hwss_dpp_dppclk_control(params);
+			break;
+		case DISABLE_PHANTOM_CRTC:
+			hwss_disable_phantom_crtc(params);
+			break;
+		case DSC_PG_STATUS:
+			hwss_dsc_pg_status(params);
+			break;
+		case DSC_WAIT_DISCONNECT_PENDING_CLEAR:
+			hwss_dsc_wait_disconnect_pending_clear(params);
+			break;
+		case DSC_DISABLE:
+			hwss_dsc_disable(params);
+			break;
+		case DCCG_SET_REF_DSCCLK:
+			hwss_dccg_set_ref_dscclk(params);
+			break;
+		case DPP_PG_CONTROL:
+			hwss_dpp_pg_control(params);
+			break;
+		case HUBP_PG_CONTROL:
+			hwss_hubp_pg_control(params);
+			break;
+		case HUBP_RESET:
+			hwss_hubp_reset(params);
+			break;
+		case DPP_RESET:
+			hwss_dpp_reset(params);
+			break;
+		case DPP_ROOT_CLOCK_CONTROL:
+			hwss_dpp_root_clock_control(params);
+			break;
+		case DC_IP_REQUEST_CNTL:
+			hwss_dc_ip_request_cntl(params);
+			break;
+		case DCCG_UPDATE_DPP_DTO:
+			hwss_dccg_update_dpp_dto(params);
+			break;
+		case HUBP_VTG_SEL:
+			hwss_hubp_vtg_sel(params);
+			break;
+		case HUBP_SETUP2:
+			hwss_hubp_setup2(params);
+			break;
+		case HUBP_SETUP:
+			hwss_hubp_setup(params);
+			break;
+		case HUBP_SET_UNBOUNDED_REQUESTING:
+			hwss_hubp_set_unbounded_requesting(params);
+			break;
+		case HUBP_SETUP_INTERDEPENDENT2:
+			hwss_hubp_setup_interdependent2(params);
+			break;
+		case HUBP_SETUP_INTERDEPENDENT:
+			hwss_hubp_setup_interdependent(params);
+			break;
+		case DPP_SET_CURSOR_MATRIX:
+			hwss_dpp_set_cursor_matrix(params);
+			break;
+		case MPC_UPDATE_BLENDING:
+			hwss_mpc_update_blending(params);
+			break;
+		case MPC_ASSERT_IDLE_MPCC:
+			hwss_mpc_assert_idle_mpcc(params);
+			break;
+		case MPC_INSERT_PLANE:
+			hwss_mpc_insert_plane(params);
+			break;
+		case DPP_SET_SCALER:
+			hwss_dpp_set_scaler(params);
+			break;
+		case HUBP_MEM_PROGRAM_VIEWPORT:
+			hwss_hubp_mem_program_viewport(params);
+			break;
+		case SET_CURSOR_ATTRIBUTE:
+			hwss_set_cursor_attribute(params);
+			break;
+		case SET_CURSOR_POSITION:
+			hwss_set_cursor_position(params);
+			break;
+		case SET_CURSOR_SDR_WHITE_LEVEL:
+			hwss_set_cursor_sdr_white_level(params);
+			break;
+		case PROGRAM_OUTPUT_CSC:
+			hwss_program_output_csc(params);
+			break;
+		case HUBP_SET_BLANK:
+			hwss_hubp_set_blank(params);
+			break;
+		case PHANTOM_HUBP_POST_ENABLE:
+			hwss_phantom_hubp_post_enable(params);
+			break;
 		default:
 			ASSERT(false);
 			break;
@@ -1023,256 +1315,2749 @@ void hwss_execute_sequence(struct dc *dc,
 	}
 }
 
-void hwss_send_dmcub_cmd(union block_sequence_params *params)
+/**
+ * Helper function to add OPTC pipe control lock to block sequence
+ */
+void hwss_add_optc_pipe_control_lock(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool lock)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.pipe_control_lock_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.pipe_control_lock_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.pipe_control_lock_params.lock = lock;
+		seq_state->steps[*seq_state->num_steps].func = OPTC_PIPE_CONTROL_LOCK;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add HUBP set flip control GSL to block sequence
+ */
+void hwss_add_hubp_set_flip_control_gsl(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		bool flip_immediate)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.set_flip_control_gsl_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.set_flip_control_gsl_params.flip_immediate = flip_immediate;
+		seq_state->steps[*seq_state->num_steps].func = HUBP_SET_FLIP_CONTROL_GSL;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add HUBP program triplebuffer to block sequence
+ */
+void hwss_add_hubp_program_triplebuffer(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool enableTripleBuffer)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.program_triplebuffer_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.program_triplebuffer_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.program_triplebuffer_params.enableTripleBuffer = enableTripleBuffer;
+		seq_state->steps[*seq_state->num_steps].func = HUBP_PROGRAM_TRIPLEBUFFER;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add HUBP update plane address to block sequence
+ */
+void hwss_add_hubp_update_plane_addr(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.update_plane_addr_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.update_plane_addr_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].func = HUBP_UPDATE_PLANE_ADDR;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add DPP set input transfer function to block sequence
+ */
+void hwss_add_dpp_set_input_transfer_func(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_plane_state *plane_state)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.set_input_transfer_func_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.set_input_transfer_func_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.set_input_transfer_func_params.plane_state = plane_state;
+		seq_state->steps[*seq_state->num_steps].func = DPP_SET_INPUT_TRANSFER_FUNC;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add DPP program gamut remap to block sequence
+ */
+void hwss_add_dpp_program_gamut_remap(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.program_gamut_remap_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].func = DPP_PROGRAM_GAMUT_REMAP;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add DPP program bias and scale to block sequence
+ */
+void hwss_add_dpp_program_bias_and_scale(struct block_sequence_state *seq_state, struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.program_bias_and_scale_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].func = DPP_PROGRAM_BIAS_AND_SCALE;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add OPTC program manual trigger to block sequence
+ */
+void hwss_add_optc_program_manual_trigger(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.program_manual_trigger_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].func = OPTC_PROGRAM_MANUAL_TRIGGER;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add DPP set output transfer function to block sequence
+ */
+void hwss_add_dpp_set_output_transfer_func(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_stream_state *stream)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.set_output_transfer_func_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.set_output_transfer_func_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.set_output_transfer_func_params.stream = stream;
+		seq_state->steps[*seq_state->num_steps].func = DPP_SET_OUTPUT_TRANSFER_FUNC;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add MPC update visual confirm to block sequence
+ */
+void hwss_add_mpc_update_visual_confirm(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		int mpcc_id)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.update_visual_confirm_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.update_visual_confirm_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.update_visual_confirm_params.mpcc_id = mpcc_id;
+		seq_state->steps[*seq_state->num_steps].func = MPC_UPDATE_VISUAL_CONFIRM;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add MPC power on MPC mem PWR to block sequence
+ */
+void hwss_add_mpc_power_on_mpc_mem_pwr(struct block_sequence_state *seq_state,
+		struct mpc *mpc,
+		int mpcc_id,
+		bool power_on)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.power_on_mpc_mem_pwr_params.mpc = mpc;
+		seq_state->steps[*seq_state->num_steps].params.power_on_mpc_mem_pwr_params.mpcc_id = mpcc_id;
+		seq_state->steps[*seq_state->num_steps].params.power_on_mpc_mem_pwr_params.power_on = power_on;
+		seq_state->steps[*seq_state->num_steps].func = MPC_POWER_ON_MPC_MEM_PWR;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add MPC set output CSC to block sequence
+ */
+void hwss_add_mpc_set_output_csc(struct block_sequence_state *seq_state,
+		struct mpc *mpc,
+		int opp_id,
+		const uint16_t *regval,
+		enum mpc_output_csc_mode ocsc_mode)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.set_output_csc_params.mpc = mpc;
+		seq_state->steps[*seq_state->num_steps].params.set_output_csc_params.opp_id = opp_id;
+		seq_state->steps[*seq_state->num_steps].params.set_output_csc_params.regval = regval;
+		seq_state->steps[*seq_state->num_steps].params.set_output_csc_params.ocsc_mode = ocsc_mode;
+		seq_state->steps[*seq_state->num_steps].func = MPC_SET_OUTPUT_CSC;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add MPC set OCSC default to block sequence
+ */
+void hwss_add_mpc_set_ocsc_default(struct block_sequence_state *seq_state,
+		struct mpc *mpc,
+		int opp_id,
+		enum dc_color_space colorspace,
+		enum mpc_output_csc_mode ocsc_mode)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.set_ocsc_default_params.mpc = mpc;
+		seq_state->steps[*seq_state->num_steps].params.set_ocsc_default_params.opp_id = opp_id;
+		seq_state->steps[*seq_state->num_steps].params.set_ocsc_default_params.color_space = colorspace;
+		seq_state->steps[*seq_state->num_steps].params.set_ocsc_default_params.ocsc_mode = ocsc_mode;
+		seq_state->steps[*seq_state->num_steps].func = MPC_SET_OCSC_DEFAULT;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add DMUB send DMCUB command to block sequence
+ */
+void hwss_add_dmub_send_dmcub_cmd(struct block_sequence_state *seq_state,
+		struct dc_context *ctx,
+		union dmub_rb_cmd *cmd,
+		enum dm_dmub_wait_type wait_type)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.send_dmcub_cmd_params.ctx = ctx;
+		seq_state->steps[*seq_state->num_steps].params.send_dmcub_cmd_params.cmd = cmd;
+		seq_state->steps[*seq_state->num_steps].params.send_dmcub_cmd_params.wait_type = wait_type;
+		seq_state->steps[*seq_state->num_steps].func = DMUB_SEND_DMCUB_CMD;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add DMUB SubVP save surface address to block sequence
+ */
+void hwss_add_dmub_subvp_save_surf_addr(struct block_sequence_state *seq_state,
+		struct dc_dmub_srv *dc_dmub_srv,
+		struct dc_plane_address *addr,
+		uint8_t subvp_index)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.subvp_save_surf_addr.dc_dmub_srv = dc_dmub_srv;
+		seq_state->steps[*seq_state->num_steps].params.subvp_save_surf_addr.addr = addr;
+		seq_state->steps[*seq_state->num_steps].params.subvp_save_surf_addr.subvp_index = subvp_index;
+		seq_state->steps[*seq_state->num_steps].func = DMUB_SUBVP_SAVE_SURF_ADDR;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add HUBP wait for DCC meta propagation to block sequence
+ */
+void hwss_add_hubp_wait_for_dcc_meta_prop(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *top_pipe_to_program)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.wait_for_dcc_meta_propagation_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.wait_for_dcc_meta_propagation_params.top_pipe_to_program = top_pipe_to_program;
+		seq_state->steps[*seq_state->num_steps].func = HUBP_WAIT_FOR_DCC_META_PROP;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add HUBP wait pipe read start to block sequence
+ */
+void hwss_add_hubp_wait_pipe_read_start(struct block_sequence_state *seq_state,
+		struct hubp *hubp)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.hubp_wait_pipe_read_start_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].func = HUBP_WAIT_PIPE_READ_START;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add HWS apply update flags for phantom to block sequence
+ */
+void hwss_add_hws_apply_update_flags_for_phantom(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.apply_update_flags_for_phantom_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].func = HWS_APPLY_UPDATE_FLAGS_FOR_PHANTOM;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add HWS update phantom VP position to block sequence
+ */
+void hwss_add_hws_update_phantom_vp_position(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct dc_state *context,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.update_phantom_vp_position_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.update_phantom_vp_position_params.context = context;
+		seq_state->steps[*seq_state->num_steps].params.update_phantom_vp_position_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].func = HWS_UPDATE_PHANTOM_VP_POSITION;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add OPTC set ODM combine to block sequence
+ */
+void hwss_add_optc_set_odm_combine(struct block_sequence_state *seq_state,
+		struct timing_generator *tg, int opp_inst[MAX_PIPES], int opp_head_count,
+		int odm_slice_width, int last_odm_slice_width)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.set_odm_combine_params.tg = tg;
+		memcpy(seq_state->steps[*seq_state->num_steps].params.set_odm_combine_params.opp_inst, opp_inst, sizeof(int) * MAX_PIPES);
+		seq_state->steps[*seq_state->num_steps].params.set_odm_combine_params.opp_head_count = opp_head_count;
+		seq_state->steps[*seq_state->num_steps].params.set_odm_combine_params.odm_slice_width = odm_slice_width;
+		seq_state->steps[*seq_state->num_steps].params.set_odm_combine_params.last_odm_slice_width = last_odm_slice_width;
+		seq_state->steps[*seq_state->num_steps].func = OPTC_SET_ODM_COMBINE;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add OPTC set ODM bypass to block sequence
+ */
+void hwss_add_optc_set_odm_bypass(struct block_sequence_state *seq_state,
+		struct timing_generator *tg, struct dc_crtc_timing *timing)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.set_odm_bypass_params.tg = tg;
+		seq_state->steps[*seq_state->num_steps].params.set_odm_bypass_params.timing = timing;
+		seq_state->steps[*seq_state->num_steps].func = OPTC_SET_ODM_BYPASS;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_send_dmcub_cmd(union block_sequence_params *params)
+{
+	struct dc_context *ctx = params->send_dmcub_cmd_params.ctx;
+	union dmub_rb_cmd *cmd = params->send_dmcub_cmd_params.cmd;
+	enum dm_dmub_wait_type wait_type = params->send_dmcub_cmd_params.wait_type;
+
+	dc_wake_and_execute_dmub_cmd(ctx, cmd, wait_type);
+}
+
+/**
+ * Helper function to add TG program global sync to block sequence
+ */
+void hwss_add_tg_program_global_sync(struct block_sequence_state *seq_state,
+		struct timing_generator *tg,
+		int vready_offset,
+		unsigned int vstartup_lines,
+		unsigned int vupdate_offset_pixels,
+		unsigned int vupdate_vupdate_width_pixels,
+		unsigned int pstate_keepout_start_lines)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.tg_program_global_sync_params.tg = tg;
+		seq_state->steps[*seq_state->num_steps].params.tg_program_global_sync_params.vready_offset = vready_offset;
+		seq_state->steps[*seq_state->num_steps].params.tg_program_global_sync_params.vstartup_lines = vstartup_lines;
+		seq_state->steps[*seq_state->num_steps].params.tg_program_global_sync_params.vupdate_offset_pixels = vupdate_offset_pixels;
+		seq_state->steps[*seq_state->num_steps].params.tg_program_global_sync_params.vupdate_vupdate_width_pixels = vupdate_vupdate_width_pixels;
+		seq_state->steps[*seq_state->num_steps].params.tg_program_global_sync_params.pstate_keepout_start_lines = pstate_keepout_start_lines;
+		seq_state->steps[*seq_state->num_steps].func = TG_PROGRAM_GLOBAL_SYNC;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add TG wait for state to block sequence
+ */
+void hwss_add_tg_wait_for_state(struct block_sequence_state *seq_state,
+		struct timing_generator *tg,
+		enum crtc_state state)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.tg_wait_for_state_params.tg = tg;
+		seq_state->steps[*seq_state->num_steps].params.tg_wait_for_state_params.state = state;
+		seq_state->steps[*seq_state->num_steps].func = TG_WAIT_FOR_STATE;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add TG set VTG params to block sequence
+ */
+void hwss_add_tg_set_vtg_params(struct block_sequence_state *seq_state,
+		struct timing_generator *tg,
+		struct dc_crtc_timing *dc_crtc_timing,
+		bool program_fp2)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.tg_set_vtg_params_params.tg = tg;
+		seq_state->steps[*seq_state->num_steps].params.tg_set_vtg_params_params.timing = dc_crtc_timing;
+		seq_state->steps[*seq_state->num_steps].params.tg_set_vtg_params_params.program_fp2 = program_fp2;
+		seq_state->steps[*seq_state->num_steps].func = TG_SET_VTG_PARAMS;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add TG setup vertical interrupt2 to block sequence
+ */
+void hwss_add_tg_setup_vertical_interrupt2(struct block_sequence_state *seq_state,
+		struct timing_generator *tg, int start_line)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.tg_setup_vertical_interrupt2_params.tg = tg;
+		seq_state->steps[*seq_state->num_steps].params.tg_setup_vertical_interrupt2_params.start_line = start_line;
+		seq_state->steps[*seq_state->num_steps].func = TG_SETUP_VERTICAL_INTERRUPT2;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add DPP set HDR multiplier to block sequence
+ */
+void hwss_add_dpp_set_hdr_multiplier(struct block_sequence_state *seq_state,
+		struct dpp *dpp, uint32_t hw_mult)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.dpp_set_hdr_multiplier_params.dpp = dpp;
+		seq_state->steps[*seq_state->num_steps].params.dpp_set_hdr_multiplier_params.hw_mult = hw_mult;
+		seq_state->steps[*seq_state->num_steps].func = DPP_SET_HDR_MULTIPLIER;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add HUBP program DET size to block sequence
+ */
+void hwss_add_hubp_program_det_size(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub,
+		unsigned int hubp_inst,
+		unsigned int det_buffer_size_kb)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.program_det_size_params.hubbub = hubbub;
+		seq_state->steps[*seq_state->num_steps].params.program_det_size_params.hubp_inst = hubp_inst;
+		seq_state->steps[*seq_state->num_steps].params.program_det_size_params.det_buffer_size_kb = det_buffer_size_kb;
+		seq_state->steps[*seq_state->num_steps].func = HUBP_PROGRAM_DET_SIZE;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubp_program_mcache_id(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		struct dml2_hubp_pipe_mcache_regs *mcache_regs)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.program_mcache_id_and_split_coordinate.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.program_mcache_id_and_split_coordinate.mcache_regs = mcache_regs;
+		seq_state->steps[*seq_state->num_steps].func = HUBP_PROGRAM_MCACHE_ID;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_force_pstate_change_control(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub,
+		bool enable,
+		bool wait)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.hubbub_force_pstate_change_control_params.hubbub = hubbub;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_force_pstate_change_control_params.enable = enable;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_force_pstate_change_control_params.wait = wait;
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_FORCE_PSTATE_CHANGE_CONTROL;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add HUBP program DET segments to block sequence
+ */
+void hwss_add_hubp_program_det_segments(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub,
+		unsigned int hubp_inst,
+		unsigned int det_size)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.program_det_segments_params.hubbub = hubbub;
+		seq_state->steps[*seq_state->num_steps].params.program_det_segments_params.hubp_inst = hubp_inst;
+		seq_state->steps[*seq_state->num_steps].params.program_det_segments_params.det_size = det_size;
+		seq_state->steps[*seq_state->num_steps].func = HUBP_PROGRAM_DET_SEGMENTS;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add OPP set dynamic expansion to block sequence
+ */
+void hwss_add_opp_set_dyn_expansion(struct block_sequence_state *seq_state,
+		struct output_pixel_processor *opp,
+		enum dc_color_space color_space,
+		enum dc_color_depth color_depth,
+		enum signal_type signal)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.opp_set_dyn_expansion_params.opp = opp;
+		seq_state->steps[*seq_state->num_steps].params.opp_set_dyn_expansion_params.color_space = color_space;
+		seq_state->steps[*seq_state->num_steps].params.opp_set_dyn_expansion_params.color_depth = color_depth;
+		seq_state->steps[*seq_state->num_steps].params.opp_set_dyn_expansion_params.signal = signal;
+		seq_state->steps[*seq_state->num_steps].func = OPP_SET_DYN_EXPANSION;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add OPP program FMT to block sequence
+ */
+void hwss_add_opp_program_fmt(struct block_sequence_state *seq_state,
+		struct output_pixel_processor *opp,
+		struct bit_depth_reduction_params *fmt_bit_depth,
+		struct clamping_and_pixel_encoding_params *clamping)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.opp_program_fmt_params.opp = opp;
+		seq_state->steps[*seq_state->num_steps].params.opp_program_fmt_params.fmt_bit_depth = fmt_bit_depth;
+		seq_state->steps[*seq_state->num_steps].params.opp_program_fmt_params.clamping = clamping;
+		seq_state->steps[*seq_state->num_steps].func = OPP_PROGRAM_FMT;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_opp_program_left_edge_extra_pixel(struct block_sequence_state *seq_state,
+		struct output_pixel_processor *opp,
+		enum dc_pixel_encoding pixel_encoding,
+		bool is_otg_master)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL;
+		seq_state->steps[*seq_state->num_steps].params.opp_program_left_edge_extra_pixel_params.opp = opp;
+		seq_state->steps[*seq_state->num_steps].params.opp_program_left_edge_extra_pixel_params.pixel_encoding = pixel_encoding;
+		seq_state->steps[*seq_state->num_steps].params.opp_program_left_edge_extra_pixel_params.is_otg_master = is_otg_master;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add ABM set pipe to block sequence
+ */
+void hwss_add_abm_set_pipe(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.set_abm_pipe_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.set_abm_pipe_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].func = ABM_SET_PIPE;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add ABM set level to block sequence
+ */
+void hwss_add_abm_set_level(struct block_sequence_state *seq_state,
+		struct abm *abm,
+		uint32_t abm_level)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.set_abm_level_params.abm = abm;
+		seq_state->steps[*seq_state->num_steps].params.set_abm_level_params.abm_level = abm_level;
+		seq_state->steps[*seq_state->num_steps].func = ABM_SET_LEVEL;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add TG enable CRTC to block sequence
+ */
+void hwss_add_tg_enable_crtc(struct block_sequence_state *seq_state,
+		struct timing_generator *tg)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.tg_enable_crtc_params.tg = tg;
+		seq_state->steps[*seq_state->num_steps].func = TG_ENABLE_CRTC;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add HUBP wait flip pending to block sequence
+ */
+void hwss_add_hubp_wait_flip_pending(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		unsigned int timeout_us,
+		unsigned int polling_interval_us)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.hubp_wait_flip_pending_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_wait_flip_pending_params.timeout_us = timeout_us;
+		seq_state->steps[*seq_state->num_steps].params.hubp_wait_flip_pending_params.polling_interval_us = polling_interval_us;
+		seq_state->steps[*seq_state->num_steps].func = HUBP_WAIT_FLIP_PENDING;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add TG wait double buffer pending to block sequence
+ */
+void hwss_add_tg_wait_double_buffer_pending(struct block_sequence_state *seq_state,
+		struct timing_generator *tg,
+		unsigned int timeout_us,
+		unsigned int polling_interval_us)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.tg_wait_double_buffer_pending_params.tg = tg;
+		seq_state->steps[*seq_state->num_steps].params.tg_wait_double_buffer_pending_params.timeout_us = timeout_us;
+		seq_state->steps[*seq_state->num_steps].params.tg_wait_double_buffer_pending_params.polling_interval_us = polling_interval_us;
+		seq_state->steps[*seq_state->num_steps].func = TG_WAIT_DOUBLE_BUFFER_PENDING;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_program_manual_trigger(union block_sequence_params *params)
+{
+	struct pipe_ctx *pipe_ctx = params->program_manual_trigger_params.pipe_ctx;
+
+	if (pipe_ctx->stream_res.tg->funcs->program_manual_trigger)
+		pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
+}
+
+void hwss_setup_dpp(union block_sequence_params *params)
+{
+	struct pipe_ctx *pipe_ctx = params->setup_dpp_params.pipe_ctx;
+	struct dpp *dpp = pipe_ctx->plane_res.dpp;
+	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
+
+	if (!plane_state)
+		return;
+
+	if (dpp && dpp->funcs->dpp_setup) {
+		// program the input csc
+		dpp->funcs->dpp_setup(dpp,
+				plane_state->format,
+				EXPANSION_MODE_ZERO,
+				plane_state->input_csc_color_matrix,
+				plane_state->color_space,
+				NULL);
+	}
+}
+
+void hwss_program_bias_and_scale(union block_sequence_params *params)
+{
+	struct pipe_ctx *pipe_ctx = params->program_bias_and_scale_params.pipe_ctx;
+	struct dpp *dpp = pipe_ctx->plane_res.dpp;
+	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
+	struct dc_bias_and_scale bns_params = plane_state->bias_and_scale;
+
+	//TODO :for CNVC set scale and bias registers if necessary
+	if (dpp->funcs->dpp_program_bias_and_scale) {
+		dpp->funcs->dpp_program_bias_and_scale(dpp, &bns_params);
+	}
+}
+
+void hwss_power_on_mpc_mem_pwr(union block_sequence_params *params)
+{
+	struct mpc *mpc = params->power_on_mpc_mem_pwr_params.mpc;
+	int mpcc_id = params->power_on_mpc_mem_pwr_params.mpcc_id;
+	bool power_on = params->power_on_mpc_mem_pwr_params.power_on;
+
+	if (mpc->funcs->power_on_mpc_mem_pwr)
+		mpc->funcs->power_on_mpc_mem_pwr(mpc, mpcc_id, power_on);
+}
+
+void hwss_set_output_csc(union block_sequence_params *params)
+{
+	struct mpc *mpc = params->set_output_csc_params.mpc;
+	int opp_id = params->set_output_csc_params.opp_id;
+	const uint16_t *matrix = params->set_output_csc_params.regval;
+	enum mpc_output_csc_mode ocsc_mode = params->set_output_csc_params.ocsc_mode;
+
+	if (mpc->funcs->set_output_csc != NULL)
+		mpc->funcs->set_output_csc(mpc,
+				opp_id,
+				matrix,
+				ocsc_mode);
+}
+
+void hwss_set_ocsc_default(union block_sequence_params *params)
+{
+	struct mpc *mpc = params->set_ocsc_default_params.mpc;
+	int opp_id = params->set_ocsc_default_params.opp_id;
+	enum dc_color_space colorspace = params->set_ocsc_default_params.color_space;
+	enum mpc_output_csc_mode ocsc_mode = params->set_ocsc_default_params.ocsc_mode;
+
+	if (mpc->funcs->set_ocsc_default != NULL)
+		mpc->funcs->set_ocsc_default(mpc,
+				opp_id,
+				colorspace,
+				ocsc_mode);
+}
+
+void hwss_subvp_save_surf_addr(union block_sequence_params *params)
+{
+	struct dc_dmub_srv *dc_dmub_srv = params->subvp_save_surf_addr.dc_dmub_srv;
+	const struct dc_plane_address *addr = params->subvp_save_surf_addr.addr;
+	uint8_t subvp_index = params->subvp_save_surf_addr.subvp_index;
+
+	dc_dmub_srv_subvp_save_surf_addr(dc_dmub_srv, addr, subvp_index);
+}
+
+void hwss_program_surface_config(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->program_surface_config_params.hubp;
+	enum surface_pixel_format format = params->program_surface_config_params.format;
+	struct dc_tiling_info *tiling_info = params->program_surface_config_params.tiling_info;
+	struct plane_size size = params->program_surface_config_params.plane_size;
+	enum dc_rotation_angle rotation = params->program_surface_config_params.rotation;
+	struct dc_plane_dcc_param *dcc = params->program_surface_config_params.dcc;
+	bool horizontal_mirror = params->program_surface_config_params.horizontal_mirror;
+	int compat_level = params->program_surface_config_params.compat_level;
+
+	hubp->funcs->hubp_program_surface_config(
+		hubp,
+		format,
+		tiling_info,
+		&size,
+		rotation,
+		dcc,
+		horizontal_mirror,
+		compat_level);
+
+	hubp->power_gated = false;
+}
+
+void hwss_program_mcache_id_and_split_coordinate(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->program_mcache_id_and_split_coordinate.hubp;
+	struct dml2_hubp_pipe_mcache_regs *mcache_regs = params->program_mcache_id_and_split_coordinate.mcache_regs;
+
+	hubp->funcs->hubp_program_mcache_id_and_split_coordinate(hubp, mcache_regs);
+
+}
+
+void get_surface_tile_visual_confirm_color(
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color)
+{
+	uint32_t color_value = MAX_TG_COLOR_VALUE;
+	/* Determine the overscan color based on the bottom-most plane's context */
+	struct pipe_ctx *bottom_pipe_ctx  = pipe_ctx;
+
+	while (bottom_pipe_ctx->bottom_pipe != NULL)
+		bottom_pipe_ctx = bottom_pipe_ctx->bottom_pipe;
+
+	switch (bottom_pipe_ctx->plane_state->tiling_info.gfx9.swizzle) {
+	case DC_SW_LINEAR:
+		/* LINEAR Surface - set border color to red */
+		color->color_r_cr = color_value;
+		break;
+	default:
+		break;
+	}
+}
+
+/**
+ * hwss_wait_for_all_blank_complete - wait for all active OPPs to finish pending blank
+ * pattern updates
+ *
+ * @dc: [in] dc reference
+ * @context: [in] hardware context in use
+ */
+void hwss_wait_for_all_blank_complete(struct dc *dc,
+		struct dc_state *context)
+{
+	struct pipe_ctx *opp_head;
+	struct dce_hwseq *hws = dc->hwseq;
+	int i;
+
+	if (!hws->funcs.wait_for_blank_complete)
+		return;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		opp_head = &context->res_ctx.pipe_ctx[i];
+
+		if (!resource_is_pipe_type(opp_head, OPP_HEAD) ||
+				dc_state_get_pipe_subvp_type(context, opp_head) == SUBVP_PHANTOM)
+			continue;
+
+		hws->funcs.wait_for_blank_complete(opp_head->stream_res.opp);
+	}
+}
+
+void hwss_wait_for_odm_update_pending_complete(struct dc *dc, struct dc_state *context)
+{
+	struct pipe_ctx *otg_master;
+	struct timing_generator *tg;
+	int i;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		otg_master = &context->res_ctx.pipe_ctx[i];
+		if (!resource_is_pipe_type(otg_master, OTG_MASTER) ||
+				dc_state_get_pipe_subvp_type(context, otg_master) == SUBVP_PHANTOM)
+			continue;
+		tg = otg_master->stream_res.tg;
+		if (tg->funcs->wait_odm_doublebuffer_pending_clear)
+			tg->funcs->wait_odm_doublebuffer_pending_clear(tg);
+		if (tg->funcs->wait_otg_disable)
+			tg->funcs->wait_otg_disable(tg);
+	}
+
+	/* ODM update may require to reprogram blank pattern for each OPP */
+	hwss_wait_for_all_blank_complete(dc, context);
+}
+
+void hwss_wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
+{
+	int i;
+	for (i = 0; i < MAX_PIPES; i++) {
+		int count = 0;
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->plane_state || dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM)
+			continue;
+
+		/* Timeout 100 ms */
+		while (count < 100000) {
+			/* Must set to false to start with, due to OR in update function */
+			pipe->plane_state->status.is_flip_pending = false;
+			dc->hwss.update_pending_status(pipe);
+			if (!pipe->plane_state->status.is_flip_pending)
+				break;
+			udelay(1);
+			count++;
+		}
+		ASSERT(!pipe->plane_state->status.is_flip_pending);
+	}
+}
+
+void hwss_wait_for_outstanding_hw_updates(struct dc *dc, struct dc_state *dc_context)
+{
+/*
+ * This function calls HWSS to wait for any potentially double buffered
+ * operations to complete. It should be invoked as a pre-amble prior
+ * to full update programming before asserting any HW locks.
+ */
+	int pipe_idx;
+	int opp_inst;
+	int opp_count = dc->res_pool->res_cap->num_opp;
+	struct hubp *hubp;
+	int mpcc_inst;
+	const struct pipe_ctx *pipe_ctx;
+
+	for (pipe_idx = 0; pipe_idx < dc->res_pool->pipe_count; pipe_idx++) {
+		pipe_ctx = &dc_context->res_ctx.pipe_ctx[pipe_idx];
+
+		if (!pipe_ctx->stream)
+			continue;
+
+		/* For full update we must wait for all double buffer updates, not just DRR updates. This
+		 * is particularly important for minimal transitions. Only check for OTG_MASTER pipes,
+		 * as non-OTG Master pipes share the same OTG as
+		 */
+		if (resource_is_pipe_type(pipe_ctx, OTG_MASTER) && dc->hwss.wait_for_all_pending_updates) {
+			dc->hwss.wait_for_all_pending_updates(pipe_ctx);
+		}
+
+		hubp = pipe_ctx->plane_res.hubp;
+		if (!hubp)
+			continue;
+
+		mpcc_inst = hubp->inst;
+		// MPCC inst is equal to pipe index in practice
+		for (opp_inst = 0; opp_inst < opp_count; opp_inst++) {
+			if ((dc->res_pool->opps[opp_inst] != NULL) &&
+				(dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst])) {
+				dc->res_pool->mpc->funcs->wait_for_idle(dc->res_pool->mpc, mpcc_inst);
+				dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst] = false;
+				break;
+			}
+		}
+	}
+	hwss_wait_for_odm_update_pending_complete(dc, dc_context);
+}
+
+void hwss_process_outstanding_hw_updates(struct dc *dc, struct dc_state *dc_context)
+{
+	/* wait for outstanding updates */
+	hwss_wait_for_outstanding_hw_updates(dc, dc_context);
+
+	/* perform outstanding post update programming */
+	if (dc->hwss.program_outstanding_updates)
+		dc->hwss.program_outstanding_updates(dc, dc_context);
+}
+
+void hwss_set_odm_combine(union block_sequence_params *params)
+{
+	struct timing_generator *tg = params->set_odm_combine_params.tg;
+	int *opp_inst = params->set_odm_combine_params.opp_inst;
+	int opp_head_count = params->set_odm_combine_params.opp_head_count;
+	int odm_slice_width = params->set_odm_combine_params.odm_slice_width;
+	int last_odm_slice_width = params->set_odm_combine_params.last_odm_slice_width;
+
+	if (tg && tg->funcs->set_odm_combine)
+		tg->funcs->set_odm_combine(tg, opp_inst, opp_head_count,
+				odm_slice_width, last_odm_slice_width);
+}
+
+void hwss_set_odm_bypass(union block_sequence_params *params)
+{
+	struct timing_generator *tg = params->set_odm_bypass_params.tg;
+	const struct dc_crtc_timing *timing = params->set_odm_bypass_params.timing;
+
+	if (tg && tg->funcs->set_odm_bypass)
+		tg->funcs->set_odm_bypass(tg, timing);
+}
+
+void hwss_opp_pipe_clock_control(union block_sequence_params *params)
+{
+	struct output_pixel_processor *opp = params->opp_pipe_clock_control_params.opp;
+	bool enable = params->opp_pipe_clock_control_params.enable;
+
+	if (opp && opp->funcs->opp_pipe_clock_control)
+		opp->funcs->opp_pipe_clock_control(opp, enable);
+}
+
+void hwss_opp_program_left_edge_extra_pixel(union block_sequence_params *params)
+{
+	struct output_pixel_processor *opp = params->opp_program_left_edge_extra_pixel_params.opp;
+	enum dc_pixel_encoding pixel_encoding = params->opp_program_left_edge_extra_pixel_params.pixel_encoding;
+	bool is_otg_master = params->opp_program_left_edge_extra_pixel_params.is_otg_master;
+
+	if (opp && opp->funcs->opp_program_left_edge_extra_pixel)
+		opp->funcs->opp_program_left_edge_extra_pixel(opp, pixel_encoding, is_otg_master);
+}
+
+void hwss_dccg_set_dto_dscclk(union block_sequence_params *params)
+{
+	struct dccg *dccg = params->dccg_set_dto_dscclk_params.dccg;
+	int inst = params->dccg_set_dto_dscclk_params.inst;
+	int num_slices_h = params->dccg_set_dto_dscclk_params.num_slices_h;
+
+	if (dccg && dccg->funcs->set_dto_dscclk)
+		dccg->funcs->set_dto_dscclk(dccg, inst, num_slices_h);
+}
+
+void hwss_dsc_set_config(union block_sequence_params *params)
+{
+	struct display_stream_compressor *dsc = params->dsc_set_config_params.dsc;
+	struct dsc_config *dsc_cfg = params->dsc_set_config_params.dsc_cfg;
+	struct dsc_optc_config *dsc_optc_cfg = params->dsc_set_config_params.dsc_optc_cfg;
+
+	if (dsc && dsc->funcs->dsc_set_config)
+		dsc->funcs->dsc_set_config(dsc, dsc_cfg, dsc_optc_cfg);
+}
+
+void hwss_dsc_enable(union block_sequence_params *params)
+{
+	struct display_stream_compressor *dsc = params->dsc_enable_params.dsc;
+	int opp_inst = params->dsc_enable_params.opp_inst;
+
+	if (dsc && dsc->funcs->dsc_enable)
+		dsc->funcs->dsc_enable(dsc, opp_inst);
+}
+
+void hwss_tg_set_dsc_config(union block_sequence_params *params)
+{
+	struct timing_generator *tg = params->tg_set_dsc_config_params.tg;
+	enum optc_dsc_mode optc_dsc_mode = OPTC_DSC_DISABLED;
+	uint32_t bytes_per_pixel = 0;
+	uint32_t slice_width = 0;
+
+	if (params->tg_set_dsc_config_params.enable) {
+		struct dsc_optc_config *dsc_optc_cfg = params->tg_set_dsc_config_params.dsc_optc_cfg;
+		if (dsc_optc_cfg) {
+			bytes_per_pixel = dsc_optc_cfg->bytes_per_pixel;
+			slice_width = dsc_optc_cfg->slice_width;
+			optc_dsc_mode = dsc_optc_cfg->is_pixel_format_444 ?
+				OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
+		}
+	}
+
+	if (tg && tg->funcs->set_dsc_config)
+		tg->funcs->set_dsc_config(tg, optc_dsc_mode, bytes_per_pixel, slice_width);
+}
+
+void hwss_dsc_disconnect(union block_sequence_params *params)
+{
+	struct display_stream_compressor *dsc = params->dsc_disconnect_params.dsc;
+
+	if (dsc && dsc->funcs->dsc_disconnect)
+		dsc->funcs->dsc_disconnect(dsc);
+}
+
+void hwss_dsc_read_state(union block_sequence_params *params)
+{
+	struct display_stream_compressor *dsc = params->dsc_read_state_params.dsc;
+	struct dcn_dsc_state *dsc_state = params->dsc_read_state_params.dsc_state;
+
+	if (dsc && dsc->funcs->dsc_read_state)
+		dsc->funcs->dsc_read_state(dsc, dsc_state);
+}
+
+void hwss_dsc_calculate_and_set_config(union block_sequence_params *params)
+{
+	struct pipe_ctx *pipe_ctx = params->dsc_calculate_and_set_config_params.pipe_ctx;
+	struct pipe_ctx *top_pipe = pipe_ctx;
+	bool enable = params->dsc_calculate_and_set_config_params.enable;
+	int opp_cnt = params->dsc_calculate_and_set_config_params.opp_cnt;
+
+	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
+	struct dc_stream_state *stream = pipe_ctx->stream;
+
+	if (!dsc || !enable)
+		return;
+
+	/* Calculate DSC configuration - extracted from dcn32_update_dsc_on_stream */
+	struct dsc_config dsc_cfg;
+
+	while (top_pipe->prev_odm_pipe)
+		top_pipe = top_pipe->prev_odm_pipe;
+
+	dsc_cfg.pic_width = (stream->timing.h_addressable + top_pipe->dsc_padding_params.dsc_hactive_padding +
+			stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
+	dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
+	dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
+	dsc_cfg.color_depth = stream->timing.display_color_depth;
+	dsc_cfg.is_odm = top_pipe->next_odm_pipe ? true : false;
+	dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
+	dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
+	dsc_cfg.dsc_padding = top_pipe->dsc_padding_params.dsc_hactive_padding;
+
+	/* Set DSC configuration */
+	if (dsc->funcs->dsc_set_config)
+		dsc->funcs->dsc_set_config(dsc, &dsc_cfg,
+			&params->dsc_calculate_and_set_config_params.dsc_optc_cfg);
+}
+
+void hwss_dsc_enable_with_opp(union block_sequence_params *params)
+{
+	struct pipe_ctx *pipe_ctx = params->dsc_enable_with_opp_params.pipe_ctx;
+	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
+
+	if (dsc && dsc->funcs->dsc_enable)
+		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
+}
+
+void hwss_tg_program_global_sync(union block_sequence_params *params)
+{
+	struct timing_generator *tg = params->tg_program_global_sync_params.tg;
+	int vready_offset = params->tg_program_global_sync_params.vready_offset;
+	unsigned int vstartup_lines = params->tg_program_global_sync_params.vstartup_lines;
+	unsigned int vupdate_offset_pixels = params->tg_program_global_sync_params.vupdate_offset_pixels;
+	unsigned int vupdate_vupdate_width_pixels = params->tg_program_global_sync_params.vupdate_vupdate_width_pixels;
+	unsigned int pstate_keepout_start_lines = params->tg_program_global_sync_params.pstate_keepout_start_lines;
+
+	if (tg->funcs->program_global_sync) {
+		tg->funcs->program_global_sync(tg, vready_offset, vstartup_lines,
+			vupdate_offset_pixels, vupdate_vupdate_width_pixels, pstate_keepout_start_lines);
+	}
+}
+
+void hwss_tg_wait_for_state(union block_sequence_params *params)
+{
+	struct timing_generator *tg = params->tg_wait_for_state_params.tg;
+	enum crtc_state state = params->tg_wait_for_state_params.state;
+
+	if (tg->funcs->wait_for_state) {
+		tg->funcs->wait_for_state(tg, state);
+	}
+}
+
+void hwss_tg_set_vtg_params(union block_sequence_params *params)
+{
+	struct timing_generator *tg = params->tg_set_vtg_params_params.tg;
+	struct dc_crtc_timing *timing = params->tg_set_vtg_params_params.timing;
+	bool program_fp2 = params->tg_set_vtg_params_params.program_fp2;
+
+	if (tg->funcs->set_vtg_params) {
+		tg->funcs->set_vtg_params(tg, timing, program_fp2);
+	}
+}
+
+void hwss_tg_setup_vertical_interrupt2(union block_sequence_params *params)
+{
+	struct timing_generator *tg = params->tg_setup_vertical_interrupt2_params.tg;
+	int start_line = params->tg_setup_vertical_interrupt2_params.start_line;
+
+	if (tg->funcs->setup_vertical_interrupt2) {
+		tg->funcs->setup_vertical_interrupt2(tg, start_line);
+	}
+}
+
+void hwss_dpp_set_hdr_multiplier(union block_sequence_params *params)
+{
+	struct dpp *dpp = params->dpp_set_hdr_multiplier_params.dpp;
+	uint32_t hw_mult = params->dpp_set_hdr_multiplier_params.hw_mult;
+
+	if (dpp->funcs->dpp_set_hdr_multiplier) {
+		dpp->funcs->dpp_set_hdr_multiplier(dpp, hw_mult);
+	}
+}
+
+void hwss_program_det_size(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->program_det_size_params.hubbub;
+	unsigned int hubp_inst = params->program_det_size_params.hubp_inst;
+	unsigned int det_buffer_size_kb = params->program_det_size_params.det_buffer_size_kb;
+
+	if (hubbub->funcs->program_det_size) {
+		hubbub->funcs->program_det_size(hubbub, hubp_inst, det_buffer_size_kb);
+	}
+}
+
+void hwss_program_det_segments(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->program_det_segments_params.hubbub;
+	unsigned int hubp_inst = params->program_det_segments_params.hubp_inst;
+	unsigned int det_size = params->program_det_segments_params.det_size;
+
+	if (hubbub->funcs->program_det_segments) {
+		hubbub->funcs->program_det_segments(hubbub, hubp_inst, det_size);
+	}
+}
+
+void hwss_opp_set_dyn_expansion(union block_sequence_params *params)
+{
+	struct output_pixel_processor *opp = params->opp_set_dyn_expansion_params.opp;
+	enum dc_color_space color_space = params->opp_set_dyn_expansion_params.color_space;
+	enum dc_color_depth color_depth = params->opp_set_dyn_expansion_params.color_depth;
+	enum signal_type signal = params->opp_set_dyn_expansion_params.signal;
+
+	if (opp->funcs->opp_set_dyn_expansion) {
+		opp->funcs->opp_set_dyn_expansion(opp, color_space, color_depth, signal);
+	}
+}
+
+void hwss_opp_program_fmt(union block_sequence_params *params)
+{
+	struct output_pixel_processor *opp = params->opp_program_fmt_params.opp;
+	struct bit_depth_reduction_params *fmt_bit_depth = params->opp_program_fmt_params.fmt_bit_depth;
+	struct clamping_and_pixel_encoding_params *clamping = params->opp_program_fmt_params.clamping;
+
+	if (opp->funcs->opp_program_fmt) {
+		opp->funcs->opp_program_fmt(opp, fmt_bit_depth, clamping);
+	}
+}
+
+void hwss_opp_program_bit_depth_reduction(union block_sequence_params *params)
+{
+	struct output_pixel_processor *opp = params->opp_program_bit_depth_reduction_params.opp;
+	bool use_default_params = params->opp_program_bit_depth_reduction_params.use_default_params;
+	struct pipe_ctx *pipe_ctx = params->opp_program_bit_depth_reduction_params.pipe_ctx;
+	struct bit_depth_reduction_params bit_depth_params;
+
+	if (use_default_params) {
+		memset(&bit_depth_params, 0, sizeof(bit_depth_params));
+	} else {
+		resource_build_bit_depth_reduction_params(pipe_ctx->stream, &bit_depth_params);
+	}
+
+	if (opp->funcs->opp_program_bit_depth_reduction) {
+		opp->funcs->opp_program_bit_depth_reduction(opp, &bit_depth_params);
+	}
+}
+
+void hwss_opp_set_disp_pattern_generator(union block_sequence_params *params)
+{
+	struct output_pixel_processor *opp = params->opp_set_disp_pattern_generator_params.opp;
+	enum controller_dp_test_pattern test_pattern = params->opp_set_disp_pattern_generator_params.test_pattern;
+	enum controller_dp_color_space color_space = params->opp_set_disp_pattern_generator_params.color_space;
+	enum dc_color_depth color_depth = params->opp_set_disp_pattern_generator_params.color_depth;
+	struct tg_color *solid_color = params->opp_set_disp_pattern_generator_params.use_solid_color ?
+		&params->opp_set_disp_pattern_generator_params.solid_color : NULL;
+	int width = params->opp_set_disp_pattern_generator_params.width;
+	int height = params->opp_set_disp_pattern_generator_params.height;
+	int offset = params->opp_set_disp_pattern_generator_params.offset;
+
+	if (opp && opp->funcs->opp_set_disp_pattern_generator) {
+		opp->funcs->opp_set_disp_pattern_generator(opp, test_pattern, color_space,
+			color_depth, solid_color, width, height, offset);
+	}
+}
+
+void hwss_set_abm_pipe(union block_sequence_params *params)
+{
+	struct dc *dc = params->set_abm_pipe_params.dc;
+	struct pipe_ctx *pipe_ctx = params->set_abm_pipe_params.pipe_ctx;
+
+	dc->hwss.set_pipe(pipe_ctx);
+}
+
+void hwss_set_abm_level(union block_sequence_params *params)
+{
+	struct abm *abm = params->set_abm_level_params.abm;
+	unsigned int abm_level = params->set_abm_level_params.abm_level;
+
+	if (abm->funcs->set_abm_level) {
+		abm->funcs->set_abm_level(abm, abm_level);
+	}
+}
+
+void hwss_set_abm_immediate_disable(union block_sequence_params *params)
+{
+	struct dc *dc = params->set_abm_immediate_disable_params.dc;
+	struct pipe_ctx *pipe_ctx = params->set_abm_immediate_disable_params.pipe_ctx;
+
+	if (dc && dc->hwss.set_abm_immediate_disable) {
+		dc->hwss.set_abm_immediate_disable(pipe_ctx);
+	}
+}
+
+void hwss_mpc_remove_mpcc(union block_sequence_params *params)
+{
+	struct mpc *mpc = params->mpc_remove_mpcc_params.mpc;
+	struct mpc_tree *mpc_tree_params = params->mpc_remove_mpcc_params.mpc_tree_params;
+	struct mpcc *mpcc_to_remove = params->mpc_remove_mpcc_params.mpcc_to_remove;
+
+	mpc->funcs->remove_mpcc(mpc, mpc_tree_params, mpcc_to_remove);
+}
+
+void hwss_opp_set_mpcc_disconnect_pending(union block_sequence_params *params)
+{
+	struct output_pixel_processor *opp = params->opp_set_mpcc_disconnect_pending_params.opp;
+	int mpcc_inst = params->opp_set_mpcc_disconnect_pending_params.mpcc_inst;
+	bool pending = params->opp_set_mpcc_disconnect_pending_params.pending;
+
+	opp->mpcc_disconnect_pending[mpcc_inst] = pending;
+}
+
+void hwss_dc_set_optimized_required(union block_sequence_params *params)
+{
+	struct dc *dc = params->dc_set_optimized_required_params.dc;
+	bool optimized_required = params->dc_set_optimized_required_params.optimized_required;
+
+	dc->optimized_required = optimized_required;
+}
+
+void hwss_hubp_disconnect(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_disconnect_params.hubp;
+
+	if (hubp->funcs->hubp_disconnect)
+		hubp->funcs->hubp_disconnect(hubp);
+}
+
+void hwss_hubbub_force_pstate_change_control(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_force_pstate_change_control_params.hubbub;
+	bool enable = params->hubbub_force_pstate_change_control_params.enable;
+	bool wait = params->hubbub_force_pstate_change_control_params.wait;
+
+	if (hubbub->funcs->force_pstate_change_control) {
+		hubbub->funcs->force_pstate_change_control(hubbub, enable, wait);
+		/* Add delay when enabling pstate change control */
+		if (enable)
+			udelay(500);
+	}
+}
+
+void hwss_tg_enable_crtc(union block_sequence_params *params)
+{
+	struct timing_generator *tg = params->tg_enable_crtc_params.tg;
+
+	if (tg->funcs->enable_crtc)
+		tg->funcs->enable_crtc(tg);
+}
+
+void hwss_tg_set_gsl(union block_sequence_params *params)
+{
+	struct timing_generator *tg = params->tg_set_gsl_params.tg;
+	struct gsl_params *gsl = &params->tg_set_gsl_params.gsl;
+
+	if (tg->funcs->set_gsl)
+		tg->funcs->set_gsl(tg, gsl);
+}
+
+void hwss_tg_set_gsl_source_select(union block_sequence_params *params)
+{
+	struct timing_generator *tg = params->tg_set_gsl_source_select_params.tg;
+	int group_idx = params->tg_set_gsl_source_select_params.group_idx;
+	uint32_t gsl_ready_signal = params->tg_set_gsl_source_select_params.gsl_ready_signal;
+
+	if (tg->funcs->set_gsl_source_select)
+		tg->funcs->set_gsl_source_select(tg, group_idx, gsl_ready_signal);
+}
+
+void hwss_hubp_wait_flip_pending(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_wait_flip_pending_params.hubp;
+	unsigned int timeout_us = params->hubp_wait_flip_pending_params.timeout_us;
+	unsigned int polling_interval_us = params->hubp_wait_flip_pending_params.polling_interval_us;
+	int j = 0;
+
+	for (j = 0; j < timeout_us / polling_interval_us
+		&& hubp->funcs->hubp_is_flip_pending(hubp); j++)
+		udelay(polling_interval_us);
+}
+
+void hwss_tg_wait_double_buffer_pending(union block_sequence_params *params)
+{
+	struct timing_generator *tg = params->tg_wait_double_buffer_pending_params.tg;
+	unsigned int timeout_us = params->tg_wait_double_buffer_pending_params.timeout_us;
+	unsigned int polling_interval_us = params->tg_wait_double_buffer_pending_params.polling_interval_us;
+	int j = 0;
+
+	if (tg->funcs->get_optc_double_buffer_pending) {
+		for (j = 0; j < timeout_us / polling_interval_us
+			&& tg->funcs->get_optc_double_buffer_pending(tg); j++)
+			udelay(polling_interval_us);
+	}
+}
+
+void hwss_update_force_pstate(union block_sequence_params *params)
+{
+	struct dc *dc = params->update_force_pstate_params.dc;
+	struct dc_state *context = params->update_force_pstate_params.context;
+	struct dce_hwseq *hwseq = dc->hwseq;
+
+	if (hwseq->funcs.update_force_pstate)
+		hwseq->funcs.update_force_pstate(dc, context);
+}
+
+void hwss_hubbub_apply_dedcn21_147_wa(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_apply_dedcn21_147_wa_params.hubbub;
+
+	hubbub->funcs->apply_DEDCN21_147_wa(hubbub);
+}
+
+void hwss_hubbub_allow_self_refresh_control(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_allow_self_refresh_control_params.hubbub;
+	bool allow = params->hubbub_allow_self_refresh_control_params.allow;
+
+	hubbub->funcs->allow_self_refresh_control(hubbub, allow);
+
+	if (!allow && params->hubbub_allow_self_refresh_control_params.disallow_self_refresh_applied)
+		*params->hubbub_allow_self_refresh_control_params.disallow_self_refresh_applied = true;
+}
+
+void hwss_tg_get_frame_count(union block_sequence_params *params)
+{
+	struct timing_generator *tg = params->tg_get_frame_count_params.tg;
+	unsigned int *frame_count = params->tg_get_frame_count_params.frame_count;
+
+	*frame_count = tg->funcs->get_frame_count(tg);
+}
+
+void hwss_mpc_set_dwb_mux(union block_sequence_params *params)
+{
+	struct mpc *mpc = params->mpc_set_dwb_mux_params.mpc;
+	int dwb_id = params->mpc_set_dwb_mux_params.dwb_id;
+	int mpcc_id = params->mpc_set_dwb_mux_params.mpcc_id;
+
+	if (mpc->funcs->set_dwb_mux)
+		mpc->funcs->set_dwb_mux(mpc, dwb_id, mpcc_id);
+}
+
+void hwss_mpc_disable_dwb_mux(union block_sequence_params *params)
+{
+	struct mpc *mpc = params->mpc_disable_dwb_mux_params.mpc;
+	unsigned int dwb_id = params->mpc_disable_dwb_mux_params.dwb_id;
+
+	if (mpc->funcs->disable_dwb_mux)
+		mpc->funcs->disable_dwb_mux(mpc, dwb_id);
+}
+
+void hwss_mcif_wb_config_buf(union block_sequence_params *params)
+{
+	struct mcif_wb *mcif_wb = params->mcif_wb_config_buf_params.mcif_wb;
+	struct mcif_buf_params *mcif_buf_params = params->mcif_wb_config_buf_params.mcif_buf_params;
+	unsigned int dest_height = params->mcif_wb_config_buf_params.dest_height;
+
+	if (mcif_wb->funcs->config_mcif_buf)
+		mcif_wb->funcs->config_mcif_buf(mcif_wb, mcif_buf_params, dest_height);
+}
+
+void hwss_mcif_wb_config_arb(union block_sequence_params *params)
+{
+	struct mcif_wb *mcif_wb = params->mcif_wb_config_arb_params.mcif_wb;
+	struct mcif_arb_params *mcif_arb_params = params->mcif_wb_config_arb_params.mcif_arb_params;
+
+	if (mcif_wb->funcs->config_mcif_arb)
+		mcif_wb->funcs->config_mcif_arb(mcif_wb, mcif_arb_params);
+}
+
+void hwss_mcif_wb_enable(union block_sequence_params *params)
+{
+	struct mcif_wb *mcif_wb = params->mcif_wb_enable_params.mcif_wb;
+
+	if (mcif_wb->funcs->enable_mcif)
+		mcif_wb->funcs->enable_mcif(mcif_wb);
+}
+
+void hwss_mcif_wb_disable(union block_sequence_params *params)
+{
+	struct mcif_wb *mcif_wb = params->mcif_wb_disable_params.mcif_wb;
+
+	if (mcif_wb->funcs->disable_mcif)
+		mcif_wb->funcs->disable_mcif(mcif_wb);
+}
+
+void hwss_dwbc_enable(union block_sequence_params *params)
+{
+	struct dwbc *dwb = params->dwbc_enable_params.dwb;
+	struct dc_dwb_params *dwb_params = params->dwbc_enable_params.dwb_params;
+
+	if (dwb->funcs->enable)
+		dwb->funcs->enable(dwb, dwb_params);
+}
+
+void hwss_dwbc_disable(union block_sequence_params *params)
+{
+	struct dwbc *dwb = params->dwbc_disable_params.dwb;
+
+	if (dwb->funcs->disable)
+		dwb->funcs->disable(dwb);
+}
+
+void hwss_dwbc_update(union block_sequence_params *params)
+{
+	struct dwbc *dwb = params->dwbc_update_params.dwb;
+	struct dc_dwb_params *dwb_params = params->dwbc_update_params.dwb_params;
+
+	if (dwb->funcs->update)
+		dwb->funcs->update(dwb, dwb_params);
+}
+
+void hwss_hubp_update_mall_sel(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_update_mall_sel_params.hubp;
+	uint32_t mall_sel = params->hubp_update_mall_sel_params.mall_sel;
+	bool cache_cursor = params->hubp_update_mall_sel_params.cache_cursor;
+
+	if (hubp && hubp->funcs->hubp_update_mall_sel)
+		hubp->funcs->hubp_update_mall_sel(hubp, mall_sel, cache_cursor);
+}
+
+void hwss_hubp_prepare_subvp_buffering(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_prepare_subvp_buffering_params.hubp;
+	bool enable = params->hubp_prepare_subvp_buffering_params.enable;
+
+	if (hubp && hubp->funcs->hubp_prepare_subvp_buffering)
+		hubp->funcs->hubp_prepare_subvp_buffering(hubp, enable);
+}
+
+void hwss_hubp_set_blank_en(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_set_blank_en_params.hubp;
+	bool enable = params->hubp_set_blank_en_params.enable;
+
+	if (hubp && hubp->funcs->set_hubp_blank_en)
+		hubp->funcs->set_hubp_blank_en(hubp, enable);
+}
+
+void hwss_hubp_disable_control(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_disable_control_params.hubp;
+	bool disable = params->hubp_disable_control_params.disable;
+
+	if (hubp && hubp->funcs->hubp_disable_control)
+		hubp->funcs->hubp_disable_control(hubp, disable);
+}
+
+void hwss_hubbub_soft_reset(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_soft_reset_params.hubbub;
+	bool reset = params->hubbub_soft_reset_params.reset;
+
+	if (hubbub)
+		params->hubbub_soft_reset_params.hubbub_soft_reset(hubbub, reset);
+}
+
+void hwss_hubp_clk_cntl(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_clk_cntl_params.hubp;
+	bool enable = params->hubp_clk_cntl_params.enable;
+
+	if (hubp && hubp->funcs->hubp_clk_cntl) {
+		hubp->funcs->hubp_clk_cntl(hubp, enable);
+		hubp->power_gated = !enable;
+	}
+}
+
+void hwss_hubp_init(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_init_params.hubp;
+
+	if (hubp && hubp->funcs->hubp_init) {
+		hubp->funcs->hubp_init(hubp);
+	}
+}
+
+void hwss_hubp_set_vm_system_aperture_settings(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_set_vm_system_aperture_settings_params.hubp;
+	//struct vm_system_aperture_param *apt = &params->hubp_set_vm_system_aperture_settings_params.apt;
+	struct vm_system_aperture_param apt;
+
+	apt.sys_default = params->hubp_set_vm_system_aperture_settings_params.sys_default;
+	apt.sys_high = params->hubp_set_vm_system_aperture_settings_params.sys_high;
+	apt.sys_low = params->hubp_set_vm_system_aperture_settings_params.sys_low;
+
+	if (hubp && hubp->funcs->hubp_set_vm_system_aperture_settings) {
+		//hubp->funcs->hubp_set_vm_system_aperture_settings(hubp, apt);
+		hubp->funcs->hubp_set_vm_system_aperture_settings(hubp, &apt);
+	}
+}
+
+void hwss_hubp_set_flip_int(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_set_flip_int_params.hubp;
+
+	if (hubp && hubp->funcs->hubp_set_flip_int) {
+		hubp->funcs->hubp_set_flip_int(hubp);
+	}
+}
+
+void hwss_dpp_dppclk_control(union block_sequence_params *params)
+{
+	struct dpp *dpp = params->dpp_dppclk_control_params.dpp;
+	bool dppclk_div = params->dpp_dppclk_control_params.dppclk_div;
+	bool enable = params->dpp_dppclk_control_params.enable;
+
+	if (dpp && dpp->funcs->dpp_dppclk_control)
+		dpp->funcs->dpp_dppclk_control(dpp, dppclk_div, enable);
+}
+
+void hwss_disable_phantom_crtc(union block_sequence_params *params)
+{
+	struct timing_generator *tg = params->disable_phantom_crtc_params.tg;
+
+	if (tg && tg->funcs->disable_phantom_crtc)
+		tg->funcs->disable_phantom_crtc(tg);
+}
+
+void hwss_dsc_pg_status(union block_sequence_params *params)
+{
+	struct dce_hwseq *hws = params->dsc_pg_status_params.hws;
+	int dsc_inst = params->dsc_pg_status_params.dsc_inst;
+
+	if (hws && hws->funcs.dsc_pg_status)
+		params->dsc_pg_status_params.is_ungated = hws->funcs.dsc_pg_status(hws, dsc_inst);
+}
+
+void hwss_dsc_wait_disconnect_pending_clear(union block_sequence_params *params)
+{
+	struct display_stream_compressor *dsc = params->dsc_wait_disconnect_pending_clear_params.dsc;
+
+	if (!params->dsc_wait_disconnect_pending_clear_params.is_ungated)
+		return;
+	if (*params->dsc_wait_disconnect_pending_clear_params.is_ungated == false)
+		return;
+
+	if (dsc && dsc->funcs->dsc_wait_disconnect_pending_clear)
+		dsc->funcs->dsc_wait_disconnect_pending_clear(dsc);
+}
+
+void hwss_dsc_disable(union block_sequence_params *params)
+{
+	struct display_stream_compressor *dsc = params->dsc_disable_params.dsc;
+
+	if (!params->dsc_disable_params.is_ungated)
+		return;
+	if (*params->dsc_disable_params.is_ungated == false)
+		return;
+
+	if (dsc && dsc->funcs->dsc_disable)
+		dsc->funcs->dsc_disable(dsc);
+}
+
+void hwss_dccg_set_ref_dscclk(union block_sequence_params *params)
+{
+	struct dccg *dccg = params->dccg_set_ref_dscclk_params.dccg;
+	int dsc_inst = params->dccg_set_ref_dscclk_params.dsc_inst;
+
+	if (!params->dccg_set_ref_dscclk_params.is_ungated)
+		return;
+	if (*params->dccg_set_ref_dscclk_params.is_ungated == false)
+		return;
+
+	if (dccg && dccg->funcs->set_ref_dscclk)
+		dccg->funcs->set_ref_dscclk(dccg, dsc_inst);
+}
+
+void hwss_dpp_pg_control(union block_sequence_params *params)
+{
+	struct dce_hwseq *hws = params->dpp_pg_control_params.hws;
+	unsigned int dpp_inst = params->dpp_pg_control_params.dpp_inst;
+	bool power_on = params->dpp_pg_control_params.power_on;
+
+	if (hws->funcs.dpp_pg_control)
+		hws->funcs.dpp_pg_control(hws, dpp_inst, power_on);
+}
+
+void hwss_hubp_pg_control(union block_sequence_params *params)
+{
+	struct dce_hwseq *hws = params->hubp_pg_control_params.hws;
+	unsigned int hubp_inst = params->hubp_pg_control_params.hubp_inst;
+	bool power_on = params->hubp_pg_control_params.power_on;
+
+	if (hws->funcs.hubp_pg_control)
+		hws->funcs.hubp_pg_control(hws, hubp_inst, power_on);
+}
+
+void hwss_hubp_reset(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_reset_params.hubp;
+
+	if (hubp && hubp->funcs->hubp_reset)
+		hubp->funcs->hubp_reset(hubp);
+}
+
+void hwss_dpp_reset(union block_sequence_params *params)
+{
+	struct dpp *dpp = params->dpp_reset_params.dpp;
+
+	if (dpp && dpp->funcs->dpp_reset)
+		dpp->funcs->dpp_reset(dpp);
+}
+
+void hwss_dpp_root_clock_control(union block_sequence_params *params)
+{
+	struct dce_hwseq *hws = params->dpp_root_clock_control_params.hws;
+	unsigned int dpp_inst = params->dpp_root_clock_control_params.dpp_inst;
+	bool clock_on = params->dpp_root_clock_control_params.clock_on;
+
+	if (hws->funcs.dpp_root_clock_control)
+		hws->funcs.dpp_root_clock_control(hws, dpp_inst, clock_on);
+}
+
+void hwss_dc_ip_request_cntl(union block_sequence_params *params)
+{
+	struct dc *dc = params->dc_ip_request_cntl_params.dc;
+	bool enable = params->dc_ip_request_cntl_params.enable;
+	struct dce_hwseq *hws = dc->hwseq;
+
+	if (hws->funcs.dc_ip_request_cntl)
+		hws->funcs.dc_ip_request_cntl(dc, enable);
+}
+
+void hwss_dccg_update_dpp_dto(union block_sequence_params *params)
+{
+	struct dccg *dccg = params->dccg_update_dpp_dto_params.dccg;
+	int dpp_inst = params->dccg_update_dpp_dto_params.dpp_inst;
+	int dppclk_khz = params->dccg_update_dpp_dto_params.dppclk_khz;
+
+	if (dccg && dccg->funcs->update_dpp_dto)
+		dccg->funcs->update_dpp_dto(dccg, dpp_inst, dppclk_khz);
+}
+
+void hwss_hubp_vtg_sel(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_vtg_sel_params.hubp;
+	uint32_t otg_inst = params->hubp_vtg_sel_params.otg_inst;
+
+	if (hubp && hubp->funcs->hubp_vtg_sel)
+		hubp->funcs->hubp_vtg_sel(hubp, otg_inst);
+}
+
+void hwss_hubp_setup2(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_setup2_params.hubp;
+	struct dml2_dchub_per_pipe_register_set *hubp_regs = params->hubp_setup2_params.hubp_regs;
+	union dml2_global_sync_programming *global_sync = params->hubp_setup2_params.global_sync;
+	struct dc_crtc_timing *timing = params->hubp_setup2_params.timing;
+
+	if (hubp && hubp->funcs->hubp_setup2)
+		hubp->funcs->hubp_setup2(hubp, hubp_regs, global_sync, timing);
+}
+
+void hwss_hubp_setup(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_setup_params.hubp;
+	struct _vcs_dpi_display_dlg_regs_st *dlg_regs = params->hubp_setup_params.dlg_regs;
+	struct _vcs_dpi_display_ttu_regs_st *ttu_regs = params->hubp_setup_params.ttu_regs;
+	struct _vcs_dpi_display_rq_regs_st *rq_regs = params->hubp_setup_params.rq_regs;
+	struct _vcs_dpi_display_pipe_dest_params_st *pipe_dest = params->hubp_setup_params.pipe_dest;
+
+	if (hubp && hubp->funcs->hubp_setup)
+		hubp->funcs->hubp_setup(hubp, dlg_regs, ttu_regs, rq_regs, pipe_dest);
+}
+
+void hwss_hubp_set_unbounded_requesting(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_set_unbounded_requesting_params.hubp;
+	bool unbounded_req = params->hubp_set_unbounded_requesting_params.unbounded_req;
+
+	if (hubp && hubp->funcs->set_unbounded_requesting)
+		hubp->funcs->set_unbounded_requesting(hubp, unbounded_req);
+}
+
+void hwss_hubp_setup_interdependent2(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_setup_interdependent2_params.hubp;
+	struct dml2_dchub_per_pipe_register_set *hubp_regs = params->hubp_setup_interdependent2_params.hubp_regs;
+
+	if (hubp && hubp->funcs->hubp_setup_interdependent2)
+		hubp->funcs->hubp_setup_interdependent2(hubp, hubp_regs);
+}
+
+void hwss_hubp_setup_interdependent(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_setup_interdependent_params.hubp;
+	struct _vcs_dpi_display_dlg_regs_st *dlg_regs = params->hubp_setup_interdependent_params.dlg_regs;
+	struct _vcs_dpi_display_ttu_regs_st *ttu_regs = params->hubp_setup_interdependent_params.ttu_regs;
+
+	if (hubp && hubp->funcs->hubp_setup_interdependent)
+		hubp->funcs->hubp_setup_interdependent(hubp, dlg_regs, ttu_regs);
+}
+
+void hwss_dpp_set_cursor_matrix(union block_sequence_params *params)
+{
+	struct dpp *dpp = params->dpp_set_cursor_matrix_params.dpp;
+	enum dc_color_space color_space = params->dpp_set_cursor_matrix_params.color_space;
+	struct dc_csc_transform *cursor_csc_color_matrix = params->dpp_set_cursor_matrix_params.cursor_csc_color_matrix;
+
+	if (dpp && dpp->funcs->set_cursor_matrix)
+		dpp->funcs->set_cursor_matrix(dpp, color_space, *cursor_csc_color_matrix);
+}
+
+void hwss_mpc_update_mpcc(union block_sequence_params *params)
+{
+	struct dc *dc = params->mpc_update_mpcc_params.dc;
+	struct pipe_ctx *pipe_ctx = params->mpc_update_mpcc_params.pipe_ctx;
+	struct dce_hwseq *hws = dc->hwseq;
+
+	if (hws->funcs.update_mpcc)
+		hws->funcs.update_mpcc(dc, pipe_ctx);
+}
+
+void hwss_mpc_update_blending(union block_sequence_params *params)
+{
+	struct mpc *mpc = params->mpc_update_blending_params.mpc;
+	struct mpcc_blnd_cfg *blnd_cfg = &params->mpc_update_blending_params.blnd_cfg;
+	int mpcc_id = params->mpc_update_blending_params.mpcc_id;
+
+	if (mpc && mpc->funcs->update_blending)
+		mpc->funcs->update_blending(mpc, blnd_cfg, mpcc_id);
+}
+
+void hwss_mpc_assert_idle_mpcc(union block_sequence_params *params)
+{
+	struct mpc *mpc = params->mpc_assert_idle_mpcc_params.mpc;
+	//struct pipe_ctx *pipe_ctx = params->mpc_assert_idle_mpcc_params.pipe_ctx;
+	int mpcc_id = params->mpc_assert_idle_mpcc_params.mpcc_id;
+
+	if (mpc && mpc->funcs->wait_for_idle)
+		mpc->funcs->wait_for_idle(mpc, mpcc_id);
+
+	//pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_id] = false;
+}
+
+void hwss_mpc_insert_plane(union block_sequence_params *params)
+{
+	struct mpc *mpc = params->mpc_insert_plane_params.mpc;
+	struct mpc_tree *tree = params->mpc_insert_plane_params.mpc_tree_params;
+	struct mpcc_blnd_cfg *blnd_cfg = &params->mpc_insert_plane_params.blnd_cfg;
+	struct mpcc_sm_cfg *sm_cfg = params->mpc_insert_plane_params.sm_cfg;
+	struct mpcc *insert_above_mpcc = params->mpc_insert_plane_params.insert_above_mpcc;
+	int mpcc_id = params->mpc_insert_plane_params.mpcc_id;
+	int dpp_id = params->mpc_insert_plane_params.dpp_id;
+
+	if (mpc && mpc->funcs->insert_plane)
+		mpc->funcs->insert_plane(mpc, tree, blnd_cfg, sm_cfg, insert_above_mpcc,
+			dpp_id, mpcc_id);
+}
+
+void hwss_dpp_set_scaler(union block_sequence_params *params)
+{
+	struct dpp *dpp = params->dpp_set_scaler_params.dpp;
+	const struct scaler_data *scl_data = params->dpp_set_scaler_params.scl_data;
+
+	if (dpp && dpp->funcs->dpp_set_scaler)
+		dpp->funcs->dpp_set_scaler(dpp, scl_data);
+}
+
+void hwss_hubp_mem_program_viewport(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_mem_program_viewport_params.hubp;
+	const struct rect *viewport = params->hubp_mem_program_viewport_params.viewport;
+	const struct rect *viewport_c = params->hubp_mem_program_viewport_params.viewport_c;
+
+	if (hubp && hubp->funcs->mem_program_viewport)
+		hubp->funcs->mem_program_viewport(hubp, viewport, viewport_c);
+}
+
+void hwss_set_cursor_attribute(union block_sequence_params *params)
+{
+	struct dc *dc = params->set_cursor_attribute_params.dc;
+	struct pipe_ctx *pipe_ctx = params->set_cursor_attribute_params.pipe_ctx;
+
+	if (dc && dc->hwss.set_cursor_attribute)
+		dc->hwss.set_cursor_attribute(pipe_ctx);
+}
+
+void hwss_set_cursor_position(union block_sequence_params *params)
+{
+	struct dc *dc = params->set_cursor_position_params.dc;
+	struct pipe_ctx *pipe_ctx = params->set_cursor_position_params.pipe_ctx;
+
+	if (dc && dc->hwss.set_cursor_position)
+		dc->hwss.set_cursor_position(pipe_ctx);
+}
+
+void hwss_set_cursor_sdr_white_level(union block_sequence_params *params)
+{
+	struct dc *dc = params->set_cursor_sdr_white_level_params.dc;
+	struct pipe_ctx *pipe_ctx = params->set_cursor_sdr_white_level_params.pipe_ctx;
+
+	if (dc && dc->hwss.set_cursor_sdr_white_level)
+		dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
+}
+
+void hwss_program_output_csc(union block_sequence_params *params)
+{
+	struct dc *dc = params->program_output_csc_params.dc;
+	struct pipe_ctx *pipe_ctx = params->program_output_csc_params.pipe_ctx;
+	enum dc_color_space colorspace = params->program_output_csc_params.colorspace;
+	uint16_t *matrix = params->program_output_csc_params.matrix;
+	int opp_id = params->program_output_csc_params.opp_id;
+
+	if (dc && dc->hwss.program_output_csc)
+		dc->hwss.program_output_csc(dc, pipe_ctx, colorspace, matrix, opp_id);
+}
+
+void hwss_hubp_set_blank(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_set_blank_params.hubp;
+	bool blank = params->hubp_set_blank_params.blank;
+
+	if (hubp && hubp->funcs->set_blank)
+		hubp->funcs->set_blank(hubp, blank);
+}
+
+void hwss_phantom_hubp_post_enable(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->phantom_hubp_post_enable_params.hubp;
+
+	if (hubp && hubp->funcs->phantom_hubp_post_enable)
+		hubp->funcs->phantom_hubp_post_enable(hubp);
+}
+
+void hwss_add_dccg_set_dto_dscclk(struct block_sequence_state *seq_state,
+		struct dccg *dccg, int inst, int num_slices_h)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DCCG_SET_DTO_DSCCLK;
+		seq_state->steps[*seq_state->num_steps].params.dccg_set_dto_dscclk_params.dccg = dccg;
+		seq_state->steps[*seq_state->num_steps].params.dccg_set_dto_dscclk_params.inst = inst;
+		seq_state->steps[*seq_state->num_steps].params.dccg_set_dto_dscclk_params.num_slices_h = num_slices_h;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_dsc_calculate_and_set_config(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx, bool enable, int opp_cnt)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DSC_CALCULATE_AND_SET_CONFIG;
+		seq_state->steps[*seq_state->num_steps].params.dsc_calculate_and_set_config_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.dsc_calculate_and_set_config_params.enable = enable;
+		seq_state->steps[*seq_state->num_steps].params.dsc_calculate_and_set_config_params.opp_cnt = opp_cnt;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_mpc_remove_mpcc(struct block_sequence_state *seq_state,
+		struct mpc *mpc, struct mpc_tree *mpc_tree_params, struct mpcc *mpcc_to_remove)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = MPC_REMOVE_MPCC;
+		seq_state->steps[*seq_state->num_steps].params.mpc_remove_mpcc_params.mpc = mpc;
+		seq_state->steps[*seq_state->num_steps].params.mpc_remove_mpcc_params.mpc_tree_params = mpc_tree_params;
+		seq_state->steps[*seq_state->num_steps].params.mpc_remove_mpcc_params.mpcc_to_remove = mpcc_to_remove;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_opp_set_mpcc_disconnect_pending(struct block_sequence_state *seq_state,
+		struct output_pixel_processor *opp, int mpcc_inst, bool pending)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = OPP_SET_MPCC_DISCONNECT_PENDING;
+		seq_state->steps[*seq_state->num_steps].params.opp_set_mpcc_disconnect_pending_params.opp = opp;
+		seq_state->steps[*seq_state->num_steps].params.opp_set_mpcc_disconnect_pending_params.mpcc_inst = mpcc_inst;
+		seq_state->steps[*seq_state->num_steps].params.opp_set_mpcc_disconnect_pending_params.pending = pending;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubp_disconnect(struct block_sequence_state *seq_state,
+		struct hubp *hubp)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_DISCONNECT;
+		seq_state->steps[*seq_state->num_steps].params.hubp_disconnect_params.hubp = hubp;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_dsc_enable_with_opp(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DSC_ENABLE_WITH_OPP;
+		seq_state->steps[*seq_state->num_steps].params.dsc_enable_with_opp_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_tg_set_dsc_config(struct block_sequence_state *seq_state,
+		struct timing_generator *tg, struct dsc_optc_config *dsc_optc_cfg, bool enable)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = TG_SET_DSC_CONFIG;
+		seq_state->steps[*seq_state->num_steps].params.tg_set_dsc_config_params.tg = tg;
+		seq_state->steps[*seq_state->num_steps].params.tg_set_dsc_config_params.dsc_optc_cfg = dsc_optc_cfg;
+		seq_state->steps[*seq_state->num_steps].params.tg_set_dsc_config_params.enable = enable;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_dsc_disconnect(struct block_sequence_state *seq_state,
+		struct display_stream_compressor *dsc)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DSC_DISCONNECT;
+		seq_state->steps[*seq_state->num_steps].params.dsc_disconnect_params.dsc = dsc;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_dc_set_optimized_required(struct block_sequence_state *seq_state,
+		struct dc *dc, bool optimized_required)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DC_SET_OPTIMIZED_REQUIRED;
+		seq_state->steps[*seq_state->num_steps].params.dc_set_optimized_required_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.dc_set_optimized_required_params.optimized_required = optimized_required;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_abm_set_immediate_disable(struct block_sequence_state *seq_state,
+		struct dc *dc, struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = ABM_SET_IMMEDIATE_DISABLE;
+		seq_state->steps[*seq_state->num_steps].params.set_abm_immediate_disable_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.set_abm_immediate_disable_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_opp_set_disp_pattern_generator(struct block_sequence_state *seq_state,
+		struct output_pixel_processor *opp,
+		enum controller_dp_test_pattern test_pattern,
+		enum controller_dp_color_space color_space,
+		enum dc_color_depth color_depth,
+		struct tg_color solid_color,
+		bool use_solid_color,
+		int width,
+		int height,
+		int offset)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = OPP_SET_DISP_PATTERN_GENERATOR;
+		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.opp = opp;
+		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.test_pattern = test_pattern;
+		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.color_space = color_space;
+		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.color_depth = color_depth;
+		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.solid_color = solid_color;
+		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.use_solid_color = use_solid_color;
+		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.width = width;
+		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.height = height;
+		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.offset = offset;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add MPC update blending to block sequence
+ */
+void hwss_add_mpc_update_blending(struct block_sequence_state *seq_state,
+		struct mpc *mpc,
+		struct mpcc_blnd_cfg blnd_cfg,
+		int mpcc_id)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = MPC_UPDATE_BLENDING;
+		seq_state->steps[*seq_state->num_steps].params.mpc_update_blending_params.mpc = mpc;
+		seq_state->steps[*seq_state->num_steps].params.mpc_update_blending_params.blnd_cfg = blnd_cfg;
+		seq_state->steps[*seq_state->num_steps].params.mpc_update_blending_params.mpcc_id = mpcc_id;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add MPC insert plane to block sequence
+ */
+void hwss_add_mpc_insert_plane(struct block_sequence_state *seq_state,
+		struct mpc *mpc,
+		struct mpc_tree *mpc_tree_params,
+		struct mpcc_blnd_cfg blnd_cfg,
+		struct mpcc_sm_cfg *sm_cfg,
+		struct mpcc *insert_above_mpcc,
+		int dpp_id,
+		int mpcc_id)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = MPC_INSERT_PLANE;
+		seq_state->steps[*seq_state->num_steps].params.mpc_insert_plane_params.mpc = mpc;
+		seq_state->steps[*seq_state->num_steps].params.mpc_insert_plane_params.mpc_tree_params = mpc_tree_params;
+		seq_state->steps[*seq_state->num_steps].params.mpc_insert_plane_params.blnd_cfg = blnd_cfg;
+		seq_state->steps[*seq_state->num_steps].params.mpc_insert_plane_params.sm_cfg = sm_cfg;
+		seq_state->steps[*seq_state->num_steps].params.mpc_insert_plane_params.insert_above_mpcc = insert_above_mpcc;
+		seq_state->steps[*seq_state->num_steps].params.mpc_insert_plane_params.dpp_id = dpp_id;
+		seq_state->steps[*seq_state->num_steps].params.mpc_insert_plane_params.mpcc_id = mpcc_id;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add MPC assert idle MPCC to block sequence
+ */
+void hwss_add_mpc_assert_idle_mpcc(struct block_sequence_state *seq_state,
+		struct mpc *mpc,
+		int mpcc_id)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = MPC_ASSERT_IDLE_MPCC;
+		seq_state->steps[*seq_state->num_steps].params.mpc_assert_idle_mpcc_params.mpc = mpc;
+		seq_state->steps[*seq_state->num_steps].params.mpc_assert_idle_mpcc_params.mpcc_id = mpcc_id;
+		(*seq_state->num_steps)++;
+	}
+}
+
+/**
+ * Helper function to add HUBP set blank to block sequence
+ */
+void hwss_add_hubp_set_blank(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		bool blank)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_SET_BLANK;
+		seq_state->steps[*seq_state->num_steps].params.hubp_set_blank_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_set_blank_params.blank = blank;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_opp_program_bit_depth_reduction(struct block_sequence_state *seq_state,
+		struct output_pixel_processor *opp,
+		bool use_default_params,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = OPP_PROGRAM_BIT_DEPTH_REDUCTION;
+		seq_state->steps[*seq_state->num_steps].params.opp_program_bit_depth_reduction_params.opp = opp;
+		seq_state->steps[*seq_state->num_steps].params.opp_program_bit_depth_reduction_params.use_default_params = use_default_params;
+		seq_state->steps[*seq_state->num_steps].params.opp_program_bit_depth_reduction_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_dc_ip_request_cntl(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		bool enable)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DC_IP_REQUEST_CNTL;
+		seq_state->steps[*seq_state->num_steps].params.dc_ip_request_cntl_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.dc_ip_request_cntl_params.enable = enable;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_dwbc_update(struct block_sequence_state *seq_state,
+		struct dwbc *dwb,
+		struct dc_dwb_params *dwb_params)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DWBC_UPDATE;
+		seq_state->steps[*seq_state->num_steps].params.dwbc_update_params.dwb = dwb;
+		seq_state->steps[*seq_state->num_steps].params.dwbc_update_params.dwb_params = dwb_params;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_mcif_wb_config_buf(struct block_sequence_state *seq_state,
+		struct mcif_wb *mcif_wb,
+		struct mcif_buf_params *mcif_buf_params,
+		unsigned int dest_height)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = MCIF_WB_CONFIG_BUF;
+		seq_state->steps[*seq_state->num_steps].params.mcif_wb_config_buf_params.mcif_wb = mcif_wb;
+		seq_state->steps[*seq_state->num_steps].params.mcif_wb_config_buf_params.mcif_buf_params = mcif_buf_params;
+		seq_state->steps[*seq_state->num_steps].params.mcif_wb_config_buf_params.dest_height = dest_height;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_mcif_wb_config_arb(struct block_sequence_state *seq_state,
+		struct mcif_wb *mcif_wb,
+		struct mcif_arb_params *mcif_arb_params)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = MCIF_WB_CONFIG_ARB;
+		seq_state->steps[*seq_state->num_steps].params.mcif_wb_config_arb_params.mcif_wb = mcif_wb;
+		seq_state->steps[*seq_state->num_steps].params.mcif_wb_config_arb_params.mcif_arb_params = mcif_arb_params;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_mcif_wb_enable(struct block_sequence_state *seq_state,
+		struct mcif_wb *mcif_wb)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = MCIF_WB_ENABLE;
+		seq_state->steps[*seq_state->num_steps].params.mcif_wb_enable_params.mcif_wb = mcif_wb;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_mcif_wb_disable(struct block_sequence_state *seq_state,
+		struct mcif_wb *mcif_wb)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = MCIF_WB_DISABLE;
+		seq_state->steps[*seq_state->num_steps].params.mcif_wb_disable_params.mcif_wb = mcif_wb;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_mpc_set_dwb_mux(struct block_sequence_state *seq_state,
+		struct mpc *mpc,
+		int dwb_id,
+		int mpcc_id)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = MPC_SET_DWB_MUX;
+		seq_state->steps[*seq_state->num_steps].params.mpc_set_dwb_mux_params.mpc = mpc;
+		seq_state->steps[*seq_state->num_steps].params.mpc_set_dwb_mux_params.dwb_id = dwb_id;
+		seq_state->steps[*seq_state->num_steps].params.mpc_set_dwb_mux_params.mpcc_id = mpcc_id;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_mpc_disable_dwb_mux(struct block_sequence_state *seq_state,
+		struct mpc *mpc,
+		unsigned int dwb_id)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = MPC_DISABLE_DWB_MUX;
+		seq_state->steps[*seq_state->num_steps].params.mpc_disable_dwb_mux_params.mpc = mpc;
+		seq_state->steps[*seq_state->num_steps].params.mpc_disable_dwb_mux_params.dwb_id = dwb_id;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_dwbc_enable(struct block_sequence_state *seq_state,
+		struct dwbc *dwb,
+		struct dc_dwb_params *dwb_params)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DWBC_ENABLE;
+		seq_state->steps[*seq_state->num_steps].params.dwbc_enable_params.dwb = dwb;
+		seq_state->steps[*seq_state->num_steps].params.dwbc_enable_params.dwb_params = dwb_params;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_dwbc_disable(struct block_sequence_state *seq_state,
+		struct dwbc *dwb)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DWBC_DISABLE;
+		seq_state->steps[*seq_state->num_steps].params.dwbc_disable_params.dwb = dwb;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_tg_set_gsl(struct block_sequence_state *seq_state,
+		struct timing_generator *tg,
+		struct gsl_params gsl)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = TG_SET_GSL;
+		seq_state->steps[*seq_state->num_steps].params.tg_set_gsl_params.tg = tg;
+		seq_state->steps[*seq_state->num_steps].params.tg_set_gsl_params.gsl = gsl;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_tg_set_gsl_source_select(struct block_sequence_state *seq_state,
+		struct timing_generator *tg,
+		int group_idx,
+		uint32_t gsl_ready_signal)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = TG_SET_GSL_SOURCE_SELECT;
+		seq_state->steps[*seq_state->num_steps].params.tg_set_gsl_source_select_params.tg = tg;
+		seq_state->steps[*seq_state->num_steps].params.tg_set_gsl_source_select_params.group_idx = group_idx;
+		seq_state->steps[*seq_state->num_steps].params.tg_set_gsl_source_select_params.gsl_ready_signal = gsl_ready_signal;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubp_update_mall_sel(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		uint32_t mall_sel,
+		bool cache_cursor)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_UPDATE_MALL_SEL;
+		seq_state->steps[*seq_state->num_steps].params.hubp_update_mall_sel_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_update_mall_sel_params.mall_sel = mall_sel;
+		seq_state->steps[*seq_state->num_steps].params.hubp_update_mall_sel_params.cache_cursor = cache_cursor;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubp_prepare_subvp_buffering(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		bool enable)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_PREPARE_SUBVP_BUFFERING;
+		seq_state->steps[*seq_state->num_steps].params.hubp_prepare_subvp_buffering_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_prepare_subvp_buffering_params.enable = enable;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubp_set_blank_en(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		bool enable)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_SET_BLANK_EN;
+		seq_state->steps[*seq_state->num_steps].params.hubp_set_blank_en_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_set_blank_en_params.enable = enable;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubp_disable_control(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		bool disable)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_DISABLE_CONTROL;
+		seq_state->steps[*seq_state->num_steps].params.hubp_disable_control_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_disable_control_params.disable = disable;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_soft_reset(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub,
+		void (*hubbub_soft_reset)(struct hubbub *hubbub, bool reset),
+		bool reset)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_SOFT_RESET;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_soft_reset_params.hubbub = hubbub;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_soft_reset_params.hubbub_soft_reset = hubbub_soft_reset;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_soft_reset_params.reset = reset;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubp_clk_cntl(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		bool enable)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_CLK_CNTL;
+		seq_state->steps[*seq_state->num_steps].params.hubp_clk_cntl_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_clk_cntl_params.enable = enable;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_dpp_dppclk_control(struct block_sequence_state *seq_state,
+		struct dpp *dpp,
+		bool dppclk_div,
+		bool enable)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DPP_DPPCLK_CONTROL;
+		seq_state->steps[*seq_state->num_steps].params.dpp_dppclk_control_params.dpp = dpp;
+		seq_state->steps[*seq_state->num_steps].params.dpp_dppclk_control_params.dppclk_div = dppclk_div;
+		seq_state->steps[*seq_state->num_steps].params.dpp_dppclk_control_params.enable = enable;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_disable_phantom_crtc(struct block_sequence_state *seq_state,
+		struct timing_generator *tg)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DISABLE_PHANTOM_CRTC;
+		seq_state->steps[*seq_state->num_steps].params.disable_phantom_crtc_params.tg = tg;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_dsc_pg_status(struct block_sequence_state *seq_state,
+		struct dce_hwseq *hws,
+		int dsc_inst,
+		bool is_ungated)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DSC_PG_STATUS;
+		seq_state->steps[*seq_state->num_steps].params.dsc_pg_status_params.hws = hws;
+		seq_state->steps[*seq_state->num_steps].params.dsc_pg_status_params.dsc_inst = dsc_inst;
+		seq_state->steps[*seq_state->num_steps].params.dsc_pg_status_params.is_ungated = is_ungated;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_dsc_wait_disconnect_pending_clear(struct block_sequence_state *seq_state,
+		struct display_stream_compressor *dsc,
+		bool *is_ungated)
 {
-	struct dc_context *ctx = params->send_dmcub_cmd_params.ctx;
-	union dmub_rb_cmd *cmd = params->send_dmcub_cmd_params.cmd;
-	enum dm_dmub_wait_type wait_type = params->send_dmcub_cmd_params.wait_type;
-
-	dc_wake_and_execute_dmub_cmd(ctx, cmd, wait_type);
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DSC_WAIT_DISCONNECT_PENDING_CLEAR;
+		seq_state->steps[*seq_state->num_steps].params.dsc_wait_disconnect_pending_clear_params.dsc = dsc;
+		seq_state->steps[*seq_state->num_steps].params.dsc_wait_disconnect_pending_clear_params.is_ungated = is_ungated;
+		(*seq_state->num_steps)++;
+	}
 }
 
-void hwss_program_manual_trigger(union block_sequence_params *params)
+void hwss_add_dsc_disable(struct block_sequence_state *seq_state,
+		struct display_stream_compressor *dsc,
+		bool *is_ungated)
 {
-	struct pipe_ctx *pipe_ctx = params->program_manual_trigger_params.pipe_ctx;
-
-	if (pipe_ctx->stream_res.tg->funcs->program_manual_trigger)
-		pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DSC_DISABLE;
+		seq_state->steps[*seq_state->num_steps].params.dsc_disable_params.dsc = dsc;
+		seq_state->steps[*seq_state->num_steps].params.dsc_disable_params.is_ungated = is_ungated;
+		(*seq_state->num_steps)++;
+	}
 }
 
-void hwss_setup_dpp(union block_sequence_params *params)
+void hwss_add_dccg_set_ref_dscclk(struct block_sequence_state *seq_state,
+		struct dccg *dccg,
+		int dsc_inst,
+		bool *is_ungated)
 {
-	struct pipe_ctx *pipe_ctx = params->setup_dpp_params.pipe_ctx;
-	struct dpp *dpp = pipe_ctx->plane_res.dpp;
-	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
-
-	if (!plane_state)
-		return;
-
-	if (dpp && dpp->funcs->dpp_setup) {
-		// program the input csc
-		dpp->funcs->dpp_setup(dpp,
-				plane_state->format,
-				EXPANSION_MODE_ZERO,
-				plane_state->input_csc_color_matrix,
-				plane_state->color_space,
-				NULL);
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DCCG_SET_REF_DSCCLK;
+		seq_state->steps[*seq_state->num_steps].params.dccg_set_ref_dscclk_params.dccg = dccg;
+		seq_state->steps[*seq_state->num_steps].params.dccg_set_ref_dscclk_params.dsc_inst = dsc_inst;
+		seq_state->steps[*seq_state->num_steps].params.dccg_set_ref_dscclk_params.is_ungated = is_ungated;
+		(*seq_state->num_steps)++;
 	}
+}
 
-	if (dpp && dpp->funcs->set_cursor_matrix) {
-		dpp->funcs->set_cursor_matrix(dpp,
-			plane_state->color_space,
-			plane_state->cursor_csc_color_matrix);
+void hwss_add_dpp_root_clock_control(struct block_sequence_state *seq_state,
+		struct dce_hwseq *hws,
+		unsigned int dpp_inst,
+		bool clock_on)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DPP_ROOT_CLOCK_CONTROL;
+		seq_state->steps[*seq_state->num_steps].params.dpp_root_clock_control_params.hws = hws;
+		seq_state->steps[*seq_state->num_steps].params.dpp_root_clock_control_params.dpp_inst = dpp_inst;
+		seq_state->steps[*seq_state->num_steps].params.dpp_root_clock_control_params.clock_on = clock_on;
+		(*seq_state->num_steps)++;
 	}
 }
 
-void hwss_program_bias_and_scale(union block_sequence_params *params)
+void hwss_add_dpp_pg_control(struct block_sequence_state *seq_state,
+		struct dce_hwseq *hws,
+		unsigned int dpp_inst,
+		bool power_on)
 {
-	struct pipe_ctx *pipe_ctx = params->program_bias_and_scale_params.pipe_ctx;
-	struct dpp *dpp = pipe_ctx->plane_res.dpp;
-	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
-	struct dc_bias_and_scale bns_params = plane_state->bias_and_scale;
-
-	//TODO :for CNVC set scale and bias registers if necessary
-	if (dpp->funcs->dpp_program_bias_and_scale) {
-		dpp->funcs->dpp_program_bias_and_scale(dpp, &bns_params);
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DPP_PG_CONTROL;
+		seq_state->steps[*seq_state->num_steps].params.dpp_pg_control_params.hws = hws;
+		seq_state->steps[*seq_state->num_steps].params.dpp_pg_control_params.dpp_inst = dpp_inst;
+		seq_state->steps[*seq_state->num_steps].params.dpp_pg_control_params.power_on = power_on;
+		(*seq_state->num_steps)++;
 	}
 }
 
-void hwss_power_on_mpc_mem_pwr(union block_sequence_params *params)
+void hwss_add_hubp_pg_control(struct block_sequence_state *seq_state,
+		struct dce_hwseq *hws,
+		unsigned int hubp_inst,
+		bool power_on)
 {
-	struct mpc *mpc = params->power_on_mpc_mem_pwr_params.mpc;
-	int mpcc_id = params->power_on_mpc_mem_pwr_params.mpcc_id;
-	bool power_on = params->power_on_mpc_mem_pwr_params.power_on;
-
-	if (mpc->funcs->power_on_mpc_mem_pwr)
-		mpc->funcs->power_on_mpc_mem_pwr(mpc, mpcc_id, power_on);
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_PG_CONTROL;
+		seq_state->steps[*seq_state->num_steps].params.hubp_pg_control_params.hws = hws;
+		seq_state->steps[*seq_state->num_steps].params.hubp_pg_control_params.hubp_inst = hubp_inst;
+		seq_state->steps[*seq_state->num_steps].params.hubp_pg_control_params.power_on = power_on;
+		(*seq_state->num_steps)++;
+	}
 }
 
-void hwss_set_output_csc(union block_sequence_params *params)
+void hwss_add_hubp_init(struct block_sequence_state *seq_state,
+		struct hubp *hubp)
 {
-	struct mpc *mpc = params->set_output_csc_params.mpc;
-	int opp_id = params->set_output_csc_params.opp_id;
-	const uint16_t *matrix = params->set_output_csc_params.regval;
-	enum mpc_output_csc_mode ocsc_mode = params->set_output_csc_params.ocsc_mode;
-
-	if (mpc->funcs->set_output_csc != NULL)
-		mpc->funcs->set_output_csc(mpc,
-				opp_id,
-				matrix,
-				ocsc_mode);
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_INIT;
+		seq_state->steps[*seq_state->num_steps].params.hubp_init_params.hubp = hubp;
+		(*seq_state->num_steps)++;
+	}
 }
 
-void hwss_set_ocsc_default(union block_sequence_params *params)
+void hwss_add_hubp_reset(struct block_sequence_state *seq_state,
+		struct hubp *hubp)
 {
-	struct mpc *mpc = params->set_ocsc_default_params.mpc;
-	int opp_id = params->set_ocsc_default_params.opp_id;
-	enum dc_color_space colorspace = params->set_ocsc_default_params.color_space;
-	enum mpc_output_csc_mode ocsc_mode = params->set_ocsc_default_params.ocsc_mode;
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_RESET;
+		seq_state->steps[*seq_state->num_steps].params.hubp_reset_params.hubp = hubp;
+		(*seq_state->num_steps)++;
+	}
+}
 
-	if (mpc->funcs->set_ocsc_default != NULL)
-		mpc->funcs->set_ocsc_default(mpc,
-				opp_id,
-				colorspace,
-				ocsc_mode);
+void hwss_add_dpp_reset(struct block_sequence_state *seq_state,
+		struct dpp *dpp)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DPP_RESET;
+		seq_state->steps[*seq_state->num_steps].params.dpp_reset_params.dpp = dpp;
+		(*seq_state->num_steps)++;
+	}
 }
 
-void hwss_subvp_save_surf_addr(union block_sequence_params *params)
+void hwss_add_opp_pipe_clock_control(struct block_sequence_state *seq_state,
+		struct output_pixel_processor *opp,
+		bool enable)
 {
-	struct dc_dmub_srv *dc_dmub_srv = params->subvp_save_surf_addr.dc_dmub_srv;
-	const struct dc_plane_address *addr = params->subvp_save_surf_addr.addr;
-	uint8_t subvp_index = params->subvp_save_surf_addr.subvp_index;
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = OPP_PIPE_CLOCK_CONTROL;
+		seq_state->steps[*seq_state->num_steps].params.opp_pipe_clock_control_params.opp = opp;
+		seq_state->steps[*seq_state->num_steps].params.opp_pipe_clock_control_params.enable = enable;
+		(*seq_state->num_steps)++;
+	}
+}
 
-	dc_dmub_srv_subvp_save_surf_addr(dc_dmub_srv, addr, subvp_index);
+void hwss_add_hubp_set_vm_system_aperture_settings(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		uint64_t sys_default,
+		uint64_t sys_low,
+		uint64_t sys_high)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_SET_VM_SYSTEM_APERTURE_SETTINGS;
+		seq_state->steps[*seq_state->num_steps].params.hubp_set_vm_system_aperture_settings_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_set_vm_system_aperture_settings_params.sys_default.quad_part = sys_default;
+		seq_state->steps[*seq_state->num_steps].params.hubp_set_vm_system_aperture_settings_params.sys_low.quad_part = sys_low;
+		seq_state->steps[*seq_state->num_steps].params.hubp_set_vm_system_aperture_settings_params.sys_high.quad_part = sys_high;
+		(*seq_state->num_steps)++;
+	}
 }
 
-void get_surface_tile_visual_confirm_color(
-		struct pipe_ctx *pipe_ctx,
-		struct tg_color *color)
+void hwss_add_hubp_set_flip_int(struct block_sequence_state *seq_state,
+		struct hubp *hubp)
 {
-	uint32_t color_value = MAX_TG_COLOR_VALUE;
-	/* Determine the overscan color based on the bottom-most plane's context */
-	struct pipe_ctx *bottom_pipe_ctx  = pipe_ctx;
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_SET_FLIP_INT;
+		seq_state->steps[*seq_state->num_steps].params.hubp_set_flip_int_params.hubp = hubp;
+		(*seq_state->num_steps)++;
+	}
+}
 
-	while (bottom_pipe_ctx->bottom_pipe != NULL)
-		bottom_pipe_ctx = bottom_pipe_ctx->bottom_pipe;
+void hwss_add_dccg_update_dpp_dto(struct block_sequence_state *seq_state,
+		struct dccg *dccg,
+		int dpp_inst,
+		int dppclk_khz)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DCCG_UPDATE_DPP_DTO;
+		seq_state->steps[*seq_state->num_steps].params.dccg_update_dpp_dto_params.dccg = dccg;
+		seq_state->steps[*seq_state->num_steps].params.dccg_update_dpp_dto_params.dpp_inst = dpp_inst;
+		seq_state->steps[*seq_state->num_steps].params.dccg_update_dpp_dto_params.dppclk_khz = dppclk_khz;
+		(*seq_state->num_steps)++;
+	}
+}
 
-	switch (bottom_pipe_ctx->plane_state->tiling_info.gfx9.swizzle) {
-	case DC_SW_LINEAR:
-		/* LINEAR Surface - set border color to red */
-		color->color_r_cr = color_value;
-		break;
-	default:
-		break;
+void hwss_add_hubp_vtg_sel(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		uint32_t otg_inst)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_VTG_SEL;
+		seq_state->steps[*seq_state->num_steps].params.hubp_vtg_sel_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_vtg_sel_params.otg_inst = otg_inst;
+		(*seq_state->num_steps)++;
 	}
 }
 
-/**
- * hwss_wait_for_all_blank_complete - wait for all active OPPs to finish pending blank
- * pattern updates
- *
- * @dc: [in] dc reference
- * @context: [in] hardware context in use
- */
-void hwss_wait_for_all_blank_complete(struct dc *dc,
-		struct dc_state *context)
+void hwss_add_hubp_setup2(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		struct dml2_dchub_per_pipe_register_set *hubp_regs,
+		union dml2_global_sync_programming *global_sync,
+		struct dc_crtc_timing *timing)
 {
-	struct pipe_ctx *opp_head;
-	struct dce_hwseq *hws = dc->hwseq;
-	int i;
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_SETUP2;
+		seq_state->steps[*seq_state->num_steps].params.hubp_setup2_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_setup2_params.hubp_regs = hubp_regs;
+		seq_state->steps[*seq_state->num_steps].params.hubp_setup2_params.global_sync = global_sync;
+		seq_state->steps[*seq_state->num_steps].params.hubp_setup2_params.timing = timing;
+		(*seq_state->num_steps)++;
+	}
+}
 
-	if (!hws->funcs.wait_for_blank_complete)
-		return;
+void hwss_add_hubp_setup(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		struct _vcs_dpi_display_dlg_regs_st *dlg_regs,
+		struct _vcs_dpi_display_ttu_regs_st *ttu_regs,
+		struct _vcs_dpi_display_rq_regs_st *rq_regs,
+		struct _vcs_dpi_display_pipe_dest_params_st *pipe_dest)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_SETUP;
+		seq_state->steps[*seq_state->num_steps].params.hubp_setup_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_setup_params.dlg_regs = dlg_regs;
+		seq_state->steps[*seq_state->num_steps].params.hubp_setup_params.ttu_regs = ttu_regs;
+		seq_state->steps[*seq_state->num_steps].params.hubp_setup_params.rq_regs = rq_regs;
+		seq_state->steps[*seq_state->num_steps].params.hubp_setup_params.pipe_dest = pipe_dest;
+		(*seq_state->num_steps)++;
+	}
+}
 
-	for (i = 0; i < MAX_PIPES; i++) {
-		opp_head = &context->res_ctx.pipe_ctx[i];
+void hwss_add_hubp_set_unbounded_requesting(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		bool unbounded_req)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_SET_UNBOUNDED_REQUESTING;
+		seq_state->steps[*seq_state->num_steps].params.hubp_set_unbounded_requesting_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_set_unbounded_requesting_params.unbounded_req = unbounded_req;
+		(*seq_state->num_steps)++;
+	}
+}
 
-		if (!resource_is_pipe_type(opp_head, OPP_HEAD) ||
-				dc_state_get_pipe_subvp_type(context, opp_head) == SUBVP_PHANTOM)
-			continue;
+void hwss_add_hubp_setup_interdependent2(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		struct dml2_dchub_per_pipe_register_set *hubp_regs)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_SETUP_INTERDEPENDENT2;
+		seq_state->steps[*seq_state->num_steps].params.hubp_setup_interdependent2_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_setup_interdependent2_params.hubp_regs = hubp_regs;
+		(*seq_state->num_steps)++;
+	}
+}
 
-		hws->funcs.wait_for_blank_complete(opp_head->stream_res.opp);
+void hwss_add_hubp_setup_interdependent(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		struct _vcs_dpi_display_dlg_regs_st *dlg_regs,
+		struct _vcs_dpi_display_ttu_regs_st *ttu_regs)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_SETUP_INTERDEPENDENT;
+		seq_state->steps[*seq_state->num_steps].params.hubp_setup_interdependent_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_setup_interdependent_params.dlg_regs = dlg_regs;
+		seq_state->steps[*seq_state->num_steps].params.hubp_setup_interdependent_params.ttu_regs = ttu_regs;
+		(*seq_state->num_steps)++;
 	}
 }
 
-void hwss_wait_for_odm_update_pending_complete(struct dc *dc, struct dc_state *context)
+void hwss_add_hubp_program_surface_config(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		enum surface_pixel_format format,
+		struct dc_tiling_info *tiling_info,
+		struct plane_size plane_size,
+		enum dc_rotation_angle rotation,
+		struct dc_plane_dcc_param *dcc,
+		bool horizontal_mirror,
+		int compat_level)
 {
-	struct pipe_ctx *otg_master;
-	struct timing_generator *tg;
-	int i;
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_PROGRAM_SURFACE_CONFIG;
+		seq_state->steps[*seq_state->num_steps].params.program_surface_config_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.program_surface_config_params.format = format;
+		seq_state->steps[*seq_state->num_steps].params.program_surface_config_params.tiling_info = tiling_info;
+		seq_state->steps[*seq_state->num_steps].params.program_surface_config_params.plane_size = plane_size;
+		seq_state->steps[*seq_state->num_steps].params.program_surface_config_params.rotation = rotation;
+		seq_state->steps[*seq_state->num_steps].params.program_surface_config_params.dcc = dcc;
+		seq_state->steps[*seq_state->num_steps].params.program_surface_config_params.horizontal_mirror = horizontal_mirror;
+		seq_state->steps[*seq_state->num_steps].params.program_surface_config_params.compat_level = compat_level;
+		(*seq_state->num_steps)++;
+	}
+}
 
-	for (i = 0; i < MAX_PIPES; i++) {
-		otg_master = &context->res_ctx.pipe_ctx[i];
-		if (!resource_is_pipe_type(otg_master, OTG_MASTER) ||
-				dc_state_get_pipe_subvp_type(context, otg_master) == SUBVP_PHANTOM)
-			continue;
-		tg = otg_master->stream_res.tg;
-		if (tg->funcs->wait_odm_doublebuffer_pending_clear)
-			tg->funcs->wait_odm_doublebuffer_pending_clear(tg);
-		if (tg->funcs->wait_otg_disable)
-			tg->funcs->wait_otg_disable(tg);
+void hwss_add_dpp_setup_dpp(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DPP_SETUP_DPP;
+		seq_state->steps[*seq_state->num_steps].params.setup_dpp_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
 	}
+}
 
-	/* ODM update may require to reprogram blank pattern for each OPP */
-	hwss_wait_for_all_blank_complete(dc, context);
+void hwss_add_dpp_set_cursor_matrix(struct block_sequence_state *seq_state,
+		struct dpp *dpp,
+		enum dc_color_space color_space,
+		struct dc_csc_transform *cursor_csc_color_matrix)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DPP_SET_CURSOR_MATRIX;
+		seq_state->steps[*seq_state->num_steps].params.dpp_set_cursor_matrix_params.dpp = dpp;
+		seq_state->steps[*seq_state->num_steps].params.dpp_set_cursor_matrix_params.color_space = color_space;
+		seq_state->steps[*seq_state->num_steps].params.dpp_set_cursor_matrix_params.cursor_csc_color_matrix = cursor_csc_color_matrix;
+		(*seq_state->num_steps)++;
+	}
 }
 
-void hwss_wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
+void hwss_add_dpp_set_scaler(struct block_sequence_state *seq_state,
+		struct dpp *dpp,
+		const struct scaler_data *scl_data)
 {
-	int i;
-	for (i = 0; i < MAX_PIPES; i++) {
-		int count = 0;
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DPP_SET_SCALER;
+		seq_state->steps[*seq_state->num_steps].params.dpp_set_scaler_params.dpp = dpp;
+		seq_state->steps[*seq_state->num_steps].params.dpp_set_scaler_params.scl_data = scl_data;
+		(*seq_state->num_steps)++;
+	}
+}
 
-		if (!pipe->plane_state || dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM)
-			continue;
+void hwss_add_hubp_mem_program_viewport(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		const struct rect *viewport,
+		const struct rect *viewport_c)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_MEM_PROGRAM_VIEWPORT;
+		seq_state->steps[*seq_state->num_steps].params.hubp_mem_program_viewport_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_mem_program_viewport_params.viewport = viewport;
+		seq_state->steps[*seq_state->num_steps].params.hubp_mem_program_viewport_params.viewport_c = viewport_c;
+		(*seq_state->num_steps)++;
+	}
+}
 
-		/* Timeout 100 ms */
-		while (count < 100000) {
-			/* Must set to false to start with, due to OR in update function */
-			pipe->plane_state->status.is_flip_pending = false;
-			dc->hwss.update_pending_status(pipe);
-			if (!pipe->plane_state->status.is_flip_pending)
-				break;
-			udelay(1);
-			count++;
-		}
-		ASSERT(!pipe->plane_state->status.is_flip_pending);
+void hwss_add_set_cursor_attribute(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = SET_CURSOR_ATTRIBUTE;
+		seq_state->steps[*seq_state->num_steps].params.set_cursor_attribute_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.set_cursor_attribute_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
 	}
 }
 
-void hwss_wait_for_outstanding_hw_updates(struct dc *dc, struct dc_state *dc_context)
+void hwss_add_set_cursor_position(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx)
 {
-/*
- * This function calls HWSS to wait for any potentially double buffered
- * operations to complete. It should be invoked as a pre-amble prior
- * to full update programming before asserting any HW locks.
- */
-	int pipe_idx;
-	int opp_inst;
-	int opp_count = dc->res_pool->res_cap->num_opp;
-	struct hubp *hubp;
-	int mpcc_inst;
-	const struct pipe_ctx *pipe_ctx;
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = SET_CURSOR_POSITION;
+		seq_state->steps[*seq_state->num_steps].params.set_cursor_position_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.set_cursor_position_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
 
-	for (pipe_idx = 0; pipe_idx < dc->res_pool->pipe_count; pipe_idx++) {
-		pipe_ctx = &dc_context->res_ctx.pipe_ctx[pipe_idx];
+void hwss_add_set_cursor_sdr_white_level(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = SET_CURSOR_SDR_WHITE_LEVEL;
+		seq_state->steps[*seq_state->num_steps].params.set_cursor_sdr_white_level_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.set_cursor_sdr_white_level_params.pipe_ctx = pipe_ctx;
+		(*seq_state->num_steps)++;
+	}
+}
 
-		if (!pipe_ctx->stream)
-			continue;
+void hwss_add_program_output_csc(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		enum dc_color_space colorspace,
+		uint16_t *matrix,
+		int opp_id)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = PROGRAM_OUTPUT_CSC;
+		seq_state->steps[*seq_state->num_steps].params.program_output_csc_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.program_output_csc_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.program_output_csc_params.colorspace = colorspace;
+		seq_state->steps[*seq_state->num_steps].params.program_output_csc_params.matrix = matrix;
+		seq_state->steps[*seq_state->num_steps].params.program_output_csc_params.opp_id = opp_id;
+		(*seq_state->num_steps)++;
+	}
+}
 
-		/* For full update we must wait for all double buffer updates, not just DRR updates. This
-		 * is particularly important for minimal transitions. Only check for OTG_MASTER pipes,
-		 * as non-OTG Master pipes share the same OTG as
-		 */
-		if (resource_is_pipe_type(pipe_ctx, OTG_MASTER) && dc->hwss.wait_for_all_pending_updates) {
-			dc->hwss.wait_for_all_pending_updates(pipe_ctx);
-		}
+void hwss_add_phantom_hubp_post_enable(struct block_sequence_state *seq_state,
+		struct hubp *hubp)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = PHANTOM_HUBP_POST_ENABLE;
+		seq_state->steps[*seq_state->num_steps].params.phantom_hubp_post_enable_params.hubp = hubp;
+		(*seq_state->num_steps)++;
+	}
+}
 
-		hubp = pipe_ctx->plane_res.hubp;
-		if (!hubp)
-			continue;
+void hwss_add_update_force_pstate(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct dc_state *context)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = UPDATE_FORCE_PSTATE;
+		seq_state->steps[*seq_state->num_steps].params.update_force_pstate_params.dc = dc;
+		seq_state->steps[*seq_state->num_steps].params.update_force_pstate_params.context = context;
+		(*seq_state->num_steps)++;
+	}
+}
 
-		mpcc_inst = hubp->inst;
-		// MPCC inst is equal to pipe index in practice
-		for (opp_inst = 0; opp_inst < opp_count; opp_inst++) {
-			if ((dc->res_pool->opps[opp_inst] != NULL) &&
-				(dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst])) {
-				dc->res_pool->mpc->funcs->wait_for_idle(dc->res_pool->mpc, mpcc_inst);
-				dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst] = false;
-				break;
-			}
-		}
+void hwss_add_hubbub_apply_dedcn21_147_wa(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_APPLY_DEDCN21_147_WA;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_apply_dedcn21_147_wa_params.hubbub = hubbub;
+		(*seq_state->num_steps)++;
 	}
-	hwss_wait_for_odm_update_pending_complete(dc, dc_context);
 }
 
-void hwss_process_outstanding_hw_updates(struct dc *dc, struct dc_state *dc_context)
+void hwss_add_hubbub_allow_self_refresh_control(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub,
+		bool allow,
+		bool *disallow_self_refresh_applied)
 {
-	/* wait for outstanding updates */
-	hwss_wait_for_outstanding_hw_updates(dc, dc_context);
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_ALLOW_SELF_REFRESH_CONTROL;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_allow_self_refresh_control_params.hubbub = hubbub;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_allow_self_refresh_control_params.allow = allow;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_allow_self_refresh_control_params.disallow_self_refresh_applied = disallow_self_refresh_applied;
+		(*seq_state->num_steps)++;
+	}
+}
 
-	/* perform outstanding post update programming */
-	if (dc->hwss.program_outstanding_updates)
-		dc->hwss.program_outstanding_updates(dc, dc_context);
+void hwss_add_tg_get_frame_count(struct block_sequence_state *seq_state,
+		struct timing_generator *tg,
+		unsigned int *frame_count)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = TG_GET_FRAME_COUNT;
+		seq_state->steps[*seq_state->num_steps].params.tg_get_frame_count_params.tg = tg;
+		seq_state->steps[*seq_state->num_steps].params.tg_get_frame_count_params.frame_count = frame_count;
+		(*seq_state->num_steps)++;
+	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0db01e0ec8db..1a5cf81e914a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1165,6 +1165,7 @@ struct dc_debug_options {
 	short auxless_alpm_lfps_t1t2_offset_us;
 	bool enable_pg_cntl_debug_logs;
 	bool disable_stutter_for_wm_program;
+	bool enable_block_sequence_programming;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 71c2cfa4df75..0870ca19cf59 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -26,9 +26,11 @@
 #include "clk_mgr.h"
 #include "dsc.h"
 #include "link_service.h"
+#include "custom_float.h"
 
 #include "dce/dmub_hw_lock_mgr.h"
 #include "dcn10/dcn10_cm_common.h"
+#include "dcn10/dcn10_hubbub.h"
 #include "dcn20/dcn20_optc.h"
 #include "dcn30/dcn30_cm_common.h"
 #include "dcn32/dcn32_hwseq.h"
@@ -36,6 +38,7 @@
 #include "dcn401/dcn401_resource.h"
 #include "dc_state_priv.h"
 #include "link_enc_cfg.h"
+#include "../hw_sequencer.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -1598,6 +1601,143 @@ void dcn401_update_odm(struct dc *dc, struct dc_state *context,
 		dc->hwseq->funcs.blank_pixel_data(dc, otg_master, true);
 }
 
+static void dcn401_add_dsc_sequence_for_odm_change(struct dc *dc, struct dc_state *context,
+		struct pipe_ctx *otg_master, struct block_sequence_state *seq_state)
+{
+	struct pipe_ctx *old_pipe;
+	struct pipe_ctx *new_pipe;
+	struct pipe_ctx *old_opp_heads[MAX_PIPES];
+	struct pipe_ctx *old_otg_master;
+	int old_opp_head_count = 0;
+	int i;
+
+	old_otg_master = &dc->current_state->res_ctx.pipe_ctx[otg_master->pipe_idx];
+
+	if (resource_is_pipe_type(old_otg_master, OTG_MASTER)) {
+		old_opp_head_count = resource_get_opp_heads_for_otg_master(old_otg_master,
+			&dc->current_state->res_ctx,
+			old_opp_heads);
+	} else {
+		old_otg_master = NULL;
+	}
+
+	/* Process new DSC configuration if DSC is enabled */
+	if (otg_master->stream_res.dsc && otg_master->stream->timing.flags.DSC) {
+		struct dc_stream_state *stream = otg_master->stream;
+		struct pipe_ctx *odm_pipe;
+		int opp_cnt = 1;
+		int last_dsc_calc = 0;
+		bool should_use_dto_dscclk = (dc->res_pool->dccg->funcs->set_dto_dscclk != NULL) &&
+				stream->timing.pix_clk_100hz > 480000;
+
+		/* Count ODM pipes */
+		for (odm_pipe = otg_master->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+			opp_cnt++;
+
+		int num_slices_h = stream->timing.dsc_cfg.num_slices_h / opp_cnt;
+
+		/* Step 1: Set DTO DSCCLK for main DSC if needed */
+		if (should_use_dto_dscclk) {
+			hwss_add_dccg_set_dto_dscclk(seq_state, dc->res_pool->dccg,
+					otg_master->stream_res.dsc->inst, num_slices_h);
+		}
+
+		/* Step 2: Calculate and set DSC config for main DSC */
+		last_dsc_calc = *seq_state->num_steps;
+		hwss_add_dsc_calculate_and_set_config(seq_state, otg_master, true, opp_cnt);
+
+		/* Step 3: Enable main DSC block */
+		hwss_add_dsc_enable_with_opp(seq_state, otg_master);
+
+		/* Step 4: Configure and enable ODM DSC blocks */
+		for (odm_pipe = otg_master->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+			if (!odm_pipe->stream_res.dsc)
+				continue;
+
+			/* Set DTO DSCCLK for ODM DSC if needed */
+			if (should_use_dto_dscclk) {
+				hwss_add_dccg_set_dto_dscclk(seq_state, dc->res_pool->dccg,
+						odm_pipe->stream_res.dsc->inst, num_slices_h);
+			}
+
+			/* Calculate and set DSC config for ODM DSC */
+			last_dsc_calc = *seq_state->num_steps;
+			hwss_add_dsc_calculate_and_set_config(seq_state, odm_pipe, true, opp_cnt);
+
+			/* Enable ODM DSC block */
+			hwss_add_dsc_enable_with_opp(seq_state, odm_pipe);
+		}
+
+		/* Step 5: Configure DSC in timing generator */
+		hwss_add_tg_set_dsc_config(seq_state, otg_master->stream_res.tg,
+			&seq_state->steps[last_dsc_calc].params.dsc_calculate_and_set_config_params.dsc_optc_cfg, true);
+	} else if (otg_master->stream_res.dsc && !otg_master->stream->timing.flags.DSC) {
+		/* Disable DSC in OPTC */
+		hwss_add_tg_set_dsc_config(seq_state, otg_master->stream_res.tg, NULL, false);
+
+		hwss_add_dsc_disconnect(seq_state, otg_master->stream_res.dsc);
+	}
+
+	/* Disable DSC for old pipes that no longer need it */
+	if (old_otg_master && old_otg_master->stream_res.dsc) {
+		for (i = 0; i < old_opp_head_count; i++) {
+			old_pipe = old_opp_heads[i];
+			new_pipe = &context->res_ctx.pipe_ctx[old_pipe->pipe_idx];
+
+			/* If old pipe had DSC but new pipe doesn't, disable the old DSC */
+			if (old_pipe->stream_res.dsc && !new_pipe->stream_res.dsc) {
+				/* Then disconnect DSC block */
+				hwss_add_dsc_disconnect(seq_state, old_pipe->stream_res.dsc);
+			}
+		}
+	}
+}
+
+void dcn401_update_odm_sequence(struct dc *dc, struct dc_state *context,
+		struct pipe_ctx *otg_master, struct block_sequence_state *seq_state)
+{
+	struct pipe_ctx *opp_heads[MAX_PIPES];
+	int opp_inst[MAX_PIPES] = {0};
+	int opp_head_count;
+	int odm_slice_width = resource_get_odm_slice_dst_width(otg_master, false);
+	int last_odm_slice_width = resource_get_odm_slice_dst_width(otg_master, true);
+	int i;
+
+	opp_head_count = resource_get_opp_heads_for_otg_master(
+			otg_master, &context->res_ctx, opp_heads);
+
+	for (i = 0; i < opp_head_count; i++)
+		opp_inst[i] = opp_heads[i]->stream_res.opp->inst;
+
+	/* Add ODM combine/bypass operation to sequence */
+	if (opp_head_count > 1) {
+		hwss_add_optc_set_odm_combine(seq_state, otg_master->stream_res.tg, opp_inst,
+			opp_head_count, odm_slice_width, last_odm_slice_width);
+	} else {
+		hwss_add_optc_set_odm_bypass(seq_state, otg_master->stream_res.tg, &otg_master->stream->timing);
+	}
+
+	/* Add OPP operations to sequence */
+	for (i = 0; i < opp_head_count; i++) {
+		/* Add OPP pipe clock control operation */
+		hwss_add_opp_pipe_clock_control(seq_state, opp_heads[i]->stream_res.opp, true);
+
+		/* Add OPP program left edge extra pixel operation */
+		hwss_add_opp_program_left_edge_extra_pixel(seq_state, opp_heads[i]->stream_res.opp,
+			opp_heads[i]->stream->timing.pixel_encoding, resource_is_pipe_type(opp_heads[i], OTG_MASTER));
+	}
+
+	/* Add DSC update operations to sequence */
+	dcn401_add_dsc_sequence_for_odm_change(dc, context, otg_master, seq_state);
+
+	/* Add blank pixel data operation if needed */
+	if (!resource_is_pipe_type(otg_master, DPP_PIPE)) {
+		if (dc->hwseq->funcs.blank_pixel_data_sequence)
+			dc->hwseq->funcs.blank_pixel_data_sequence(
+				dc, otg_master, true, seq_state);
+	}
+}
+
 void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx,
 		struct dc_link_settings *link_settings)
 {
@@ -2086,6 +2226,148 @@ void dcn401_program_pipe(
 	}
 }
 
+/*
+ * dcn401_program_pipe_sequence - Sequence-based version of dcn401_program_pipe
+ *
+ * This function creates a sequence-based version of the original dcn401_program_pipe
+ * function. Instead of directly calling hardware programming functions, it appends
+ * sequence steps to the provided block_sequence array that can later be executed
+ * as part of hwss_execute_sequence.
+ *
+ */
+void dcn401_program_pipe_sequence(
+	struct dc *dc,
+	struct pipe_ctx *pipe_ctx,
+	struct dc_state *context,
+	struct block_sequence_state *seq_state)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+
+	/* Only need to unblank on top pipe */
+	if (resource_is_pipe_type(pipe_ctx, OTG_MASTER)) {
+		if (pipe_ctx->update_flags.bits.enable ||
+				pipe_ctx->update_flags.bits.odm ||
+				pipe_ctx->stream->update_flags.bits.abm_level) {
+			if (dc->hwseq->funcs.blank_pixel_data_sequence)
+				dc->hwseq->funcs.blank_pixel_data_sequence(dc, pipe_ctx,
+					 !pipe_ctx->plane_state || !pipe_ctx->plane_state->visible,
+					 seq_state);
+		}
+	}
+
+	/* Only update TG on top pipe */
+	if (pipe_ctx->update_flags.bits.global_sync && !pipe_ctx->top_pipe
+		&& !pipe_ctx->prev_odm_pipe) {
+
+		/* Step 1: Program global sync */
+		hwss_add_tg_program_global_sync(seq_state, pipe_ctx->stream_res.tg,
+			dcn401_calculate_vready_offset_for_group(pipe_ctx),
+			(unsigned int)pipe_ctx->global_sync.dcn4x.vstartup_lines,
+			(unsigned int)pipe_ctx->global_sync.dcn4x.vupdate_offset_pixels,
+			(unsigned int)pipe_ctx->global_sync.dcn4x.vupdate_vupdate_width_pixels,
+			(unsigned int)pipe_ctx->global_sync.dcn4x.pstate_keepout_start_lines);
+
+		/* Step 2: Wait for VACTIVE state (if not phantom pipe) */
+		if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM) {
+			hwss_add_tg_wait_for_state(seq_state, pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+		}
+
+		/* Step 3: Set VTG params */
+		hwss_add_tg_set_vtg_params(seq_state, pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing, true);
+
+		/* Step 4: Setup vupdate interrupt (if available) */
+		if (hws->funcs.setup_vupdate_interrupt) {
+			dcn401_setup_vupdate_interrupt_sequence(dc, pipe_ctx, seq_state);
+		}
+	}
+
+	if (pipe_ctx->update_flags.bits.odm) {
+		if (hws->funcs.update_odm_sequence)
+			hws->funcs.update_odm_sequence(dc, context, pipe_ctx, seq_state);
+	}
+
+	if (pipe_ctx->update_flags.bits.enable) {
+		if (dc->hwss.enable_plane_sequence)
+			dc->hwss.enable_plane_sequence(dc, pipe_ctx, context, seq_state);
+	}
+
+	if (pipe_ctx->update_flags.bits.det_size) {
+		if (dc->res_pool->hubbub->funcs->program_det_size) {
+			hwss_add_hubp_program_det_size(seq_state, dc->res_pool->hubbub,
+				pipe_ctx->plane_res.hubp->inst, pipe_ctx->det_buffer_size_kb);
+		}
+
+		if (dc->res_pool->hubbub->funcs->program_det_segments) {
+			hwss_add_hubp_program_det_segments(seq_state, dc->res_pool->hubbub,
+				pipe_ctx->plane_res.hubp->inst, pipe_ctx->hubp_regs.det_size);
+		}
+	}
+
+	if (pipe_ctx->plane_state && (pipe_ctx->update_flags.raw ||
+	    pipe_ctx->plane_state->update_flags.raw ||
+	    pipe_ctx->stream->update_flags.raw)) {
+
+		if (dc->hwss.update_dchubp_dpp_sequence)
+			dc->hwss.update_dchubp_dpp_sequence(dc, pipe_ctx, context, seq_state);
+	}
+
+	if (pipe_ctx->plane_state && (pipe_ctx->update_flags.bits.enable ||
+		pipe_ctx->plane_state->update_flags.bits.hdr_mult)) {
+
+		hws->funcs.set_hdr_multiplier_sequence(pipe_ctx, seq_state);
+	}
+
+	if (pipe_ctx->plane_state &&
+		(pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
+			pipe_ctx->plane_state->update_flags.bits.gamma_change ||
+			pipe_ctx->plane_state->update_flags.bits.lut_3d ||
+			pipe_ctx->update_flags.bits.enable)) {
+
+		hwss_add_dpp_set_input_transfer_func(seq_state, dc, pipe_ctx, pipe_ctx->plane_state);
+	}
+
+	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
+	 * only do gamma programming for powering on, internal memcmp to avoid
+	 * updating on slave planes
+	 */
+	if (pipe_ctx->update_flags.bits.enable ||
+			pipe_ctx->update_flags.bits.plane_changed ||
+			pipe_ctx->stream->update_flags.bits.out_tf) {
+		hwss_add_dpp_set_output_transfer_func(seq_state, dc, pipe_ctx, pipe_ctx->stream);
+	}
+
+	/* If the pipe has been enabled or has a different opp, we
+	 * should reprogram the fmt. This deals with cases where
+	 * interation between mpc and odm combine on different streams
+	 * causes a different pipe to be chosen to odm combine with.
+	 */
+	if (pipe_ctx->update_flags.bits.enable
+		|| pipe_ctx->update_flags.bits.opp_changed) {
+
+		hwss_add_opp_set_dyn_expansion(seq_state, pipe_ctx->stream_res.opp, COLOR_SPACE_YCBCR601, pipe_ctx->stream->timing.display_color_depth, pipe_ctx->stream->signal);
+
+		hwss_add_opp_program_fmt(seq_state, pipe_ctx->stream_res.opp, &pipe_ctx->stream->bit_depth_params, &pipe_ctx->stream->clamping);
+	}
+
+	/* Set ABM pipe after other pipe configurations done */
+	if ((pipe_ctx->plane_state && pipe_ctx->plane_state->visible)) {
+		if (pipe_ctx->stream_res.abm) {
+			hwss_add_abm_set_pipe(seq_state, dc, pipe_ctx);
+
+			hwss_add_abm_set_level(seq_state, pipe_ctx->stream_res.abm, pipe_ctx->stream->abm_level);
+		}
+	}
+
+	if (pipe_ctx->update_flags.bits.test_pattern_changed) {
+		struct output_pixel_processor *odm_opp = pipe_ctx->stream_res.opp;
+
+		hwss_add_opp_program_bit_depth_reduction(seq_state, odm_opp, true, pipe_ctx);
+
+		hwss_add_opp_set_disp_pattern_generator(seq_state, odm_opp, pipe_ctx->stream_res.test_pattern_params.test_pattern, pipe_ctx->stream_res.test_pattern_params.color_space, pipe_ctx->stream_res.test_pattern_params.color_depth, (struct tg_color){0}, false, pipe_ctx->stream_res.test_pattern_params.width, pipe_ctx->stream_res.test_pattern_params.height, pipe_ctx->stream_res.test_pattern_params.offset);
+	}
+
+}
+
 void dcn401_program_front_end_for_ctx(
 	struct dc *dc,
 	struct dc_state *context)
@@ -2163,7 +2445,6 @@ void dcn401_program_front_end_for_ctx(
 			&& context->res_ctx.pipe_ctx[i].stream)
 			hws->funcs.blank_pixel_data(dc, &context->res_ctx.pipe_ctx[i], true);
 
-
 	/* Disconnect mpcc */
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable
@@ -2242,11 +2523,11 @@ void dcn401_program_front_end_for_ctx(
 
 		/* Avoid underflow by check of pipe line read when adding 2nd plane. */
 		if (hws->wa.wait_hubpret_read_start_during_mpo_transition &&
-			!pipe->top_pipe &&
-			pipe->stream &&
-			pipe->plane_res.hubp->funcs->hubp_wait_pipe_read_start &&
-			dc->current_state->stream_status[0].plane_count == 1 &&
-			context->stream_status[0].plane_count > 1) {
+				!pipe->top_pipe &&
+				pipe->stream &&
+				pipe->plane_res.hubp->funcs->hubp_wait_pipe_read_start &&
+				dc->current_state->stream_status[0].plane_count == 1 &&
+				context->stream_status[0].plane_count > 1) {
 			pipe->plane_res.hubp->funcs->hubp_wait_pipe_read_start(pipe->plane_res.hubp);
 		}
 	}
@@ -2358,7 +2639,6 @@ void dcn401_post_unlock_program_front_end(
 	 */
 	if (hwseq->funcs.update_force_pstate)
 		dc->hwseq->funcs.update_force_pstate(dc, context);
-
 	/* Only program the MALL registers after all the main and phantom pipes
 	 * are done programming.
 	 */
@@ -2727,3 +3007,1061 @@ void dcn401_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pip
 
 	cs->offload_streams[stream_idx].payloads[payload_idx].pipe_mask |= (1u << pipe->pipe_idx);
 }
+
+void dcn401_plane_atomic_power_down_sequence(struct dc *dc,
+		struct dpp *dpp,
+		struct hubp *hubp,
+		struct block_sequence_state *seq_state)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	uint32_t org_ip_request_cntl = 0;
+
+	DC_LOGGER_INIT(dc->ctx->logger);
+
+	/* Check and set DC_IP_REQUEST_CNTL if needed */
+	if (REG(DC_IP_REQUEST_CNTL)) {
+		REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+		if (org_ip_request_cntl == 0) {
+			hwss_add_dc_ip_request_cntl(seq_state, dc, true);
+		}
+	}
+
+	/* DPP power gating control */
+	hwss_add_dpp_pg_control(seq_state, hws, dpp->inst, false);
+
+	/* HUBP power gating control */
+	hwss_add_hubp_pg_control(seq_state, hws, hubp->inst, false);
+
+	/* HUBP reset */
+	hwss_add_hubp_reset(seq_state, hubp);
+
+	/* DPP reset */
+	hwss_add_dpp_reset(seq_state, dpp);
+
+	/* Restore DC_IP_REQUEST_CNTL if it was originally 0 */
+	if (org_ip_request_cntl == 0 && REG(DC_IP_REQUEST_CNTL)) {
+		hwss_add_dc_ip_request_cntl(seq_state, dc, false);
+	}
+
+	DC_LOG_DEBUG("Power gated front end %d\n", hubp->inst);
+
+	/* DPP root clock control */
+	hwss_add_dpp_root_clock_control(seq_state, hws, dpp->inst, false);
+}
+
+/* trigger HW to start disconnect plane from stream on the next vsync using block sequence */
+void dcn401_plane_atomic_disconnect_sequence(struct dc *dc,
+		struct dc_state *state,
+		struct pipe_ctx *pipe_ctx,
+		struct block_sequence_state *seq_state)
+{
+	struct hubp *hubp = pipe_ctx->plane_res.hubp;
+	int dpp_id = pipe_ctx->plane_res.dpp->inst;
+	struct mpc *mpc = dc->res_pool->mpc;
+	struct mpc_tree *mpc_tree_params;
+	struct mpcc *mpcc_to_remove = NULL;
+	struct output_pixel_processor *opp = pipe_ctx->stream_res.opp;
+
+	mpc_tree_params = &(opp->mpc_tree_params);
+	mpcc_to_remove = mpc->funcs->get_mpcc_for_dpp(mpc_tree_params, dpp_id);
+
+	/*Already reset*/
+	if (mpcc_to_remove == NULL)
+		return;
+
+	/* Step 1: Remove MPCC from MPC tree */
+	hwss_add_mpc_remove_mpcc(seq_state, mpc, mpc_tree_params, mpcc_to_remove);
+
+	// Phantom pipes have OTG disabled by default, so MPCC_STATUS will never assert idle,
+	// so don't wait for MPCC_IDLE in the programming sequence
+	if (dc_state_get_pipe_subvp_type(state, pipe_ctx) != SUBVP_PHANTOM) {
+		/* Step 2: Set MPCC disconnect pending flag */
+		hwss_add_opp_set_mpcc_disconnect_pending(seq_state, opp, pipe_ctx->plane_res.mpcc_inst, true);
+	}
+
+	/* Step 3: Set optimized required flag */
+	hwss_add_dc_set_optimized_required(seq_state, dc, true);
+
+	/* Step 4: Disconnect HUBP if function exists */
+	if (hubp->funcs->hubp_disconnect) {
+		hwss_add_hubp_disconnect(seq_state, hubp);
+	}
+
+	/* Step 5: Verify pstate change high if debug sanity checks are enabled */
+	if (dc->debug.sanity_checks) {
+		dc->hwseq->funcs.verify_allow_pstate_change_high_sequence(dc, seq_state);
+	}
+}
+
+void dcn401_blank_pixel_data_sequence(
+	struct dc *dc,
+	struct pipe_ctx *pipe_ctx,
+	bool blank,
+	struct block_sequence_state *seq_state)
+{
+	struct tg_color black_color = {0};
+	struct stream_resource *stream_res = &pipe_ctx->stream_res;
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	enum dc_color_space color_space = stream->output_color_space;
+	enum controller_dp_test_pattern test_pattern = CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR;
+	enum controller_dp_color_space test_pattern_color_space = CONTROLLER_DP_COLOR_SPACE_UDEFINED;
+	struct pipe_ctx *odm_pipe;
+	struct rect odm_slice_src;
+
+	if (stream->link->test_pattern_enabled)
+		return;
+
+	/* get opp dpg blank color */
+	color_space_to_black_color(dc, color_space, &black_color);
+
+	if (blank) {
+		/* Set ABM immediate disable */
+		hwss_add_abm_set_immediate_disable(seq_state, dc, pipe_ctx);
+
+		if (dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE) {
+			test_pattern = CONTROLLER_DP_TEST_PATTERN_COLORSQUARES;
+			test_pattern_color_space = CONTROLLER_DP_COLOR_SPACE_RGB;
+		}
+	} else {
+		test_pattern = CONTROLLER_DP_TEST_PATTERN_VIDEOMODE;
+	}
+
+	odm_pipe = pipe_ctx;
+
+	/* Set display pattern generator for all ODM pipes */
+	while (odm_pipe->next_odm_pipe) {
+		odm_slice_src = resource_get_odm_slice_src_rect(odm_pipe);
+
+		hwss_add_opp_set_disp_pattern_generator(seq_state,
+			odm_pipe->stream_res.opp,
+			test_pattern,
+			test_pattern_color_space,
+			stream->timing.display_color_depth,
+			black_color,
+			true,
+			odm_slice_src.width,
+			odm_slice_src.height,
+			odm_slice_src.x);
+
+		odm_pipe = odm_pipe->next_odm_pipe;
+	}
+
+	/* Set display pattern generator for final ODM pipe */
+	odm_slice_src = resource_get_odm_slice_src_rect(odm_pipe);
+
+	hwss_add_opp_set_disp_pattern_generator(seq_state,
+		odm_pipe->stream_res.opp,
+		test_pattern,
+		test_pattern_color_space,
+		stream->timing.display_color_depth,
+		black_color,
+		true,
+		odm_slice_src.width,
+		odm_slice_src.height,
+		odm_slice_src.x);
+
+	/* Handle ABM level setting when not blanking */
+	if (!blank) {
+		if (stream_res->abm) {
+			/* Set pipe for ABM */
+			hwss_add_abm_set_pipe(seq_state, dc, pipe_ctx);
+
+			/* Set ABM level */
+			hwss_add_abm_set_level(seq_state, stream_res->abm, stream->abm_level);
+		}
+	}
+}
+
+void dcn401_program_all_writeback_pipes_in_tree_sequence(
+		struct dc *dc,
+		const struct dc_stream_state *stream,
+		struct dc_state *context,
+		struct block_sequence_state *seq_state)
+{
+	struct dwbc *dwb;
+	int i_wb, i_pipe;
+
+	if (!stream || stream->num_wb_info > dc->res_pool->res_cap->num_dwb)
+		return;
+
+	/* For each writeback pipe */
+	for (i_wb = 0; i_wb < stream->num_wb_info; i_wb++) {
+		/* Get direct pointer to writeback info */
+		struct dc_writeback_info *wb_info = (struct dc_writeback_info *)&stream->writeback_info[i_wb];
+		int mpcc_inst = -1;
+
+		if (wb_info->wb_enabled) {
+			/* Get the MPCC instance for writeback_source_plane */
+			for (i_pipe = 0; i_pipe < dc->res_pool->pipe_count; i_pipe++) {
+				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i_pipe];
+
+				if (!pipe_ctx->plane_state)
+					continue;
+
+				if (pipe_ctx->plane_state == wb_info->writeback_source_plane) {
+					mpcc_inst = pipe_ctx->plane_res.mpcc_inst;
+					break;
+				}
+			}
+
+			if (mpcc_inst == -1) {
+				/* Disable writeback pipe and disconnect from MPCC
+				 * if source plane has been removed
+				 */
+				dcn401_disable_writeback_sequence(dc, wb_info, seq_state);
+				continue;
+			}
+
+			ASSERT(wb_info->dwb_pipe_inst < dc->res_pool->res_cap->num_dwb);
+			dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
+
+			if (dwb->funcs->is_enabled(dwb)) {
+				/* Writeback pipe already enabled, only need to update */
+				dcn401_update_writeback_sequence(dc, wb_info, context, seq_state);
+			} else {
+				/* Enable writeback pipe and connect to MPCC */
+				dcn401_enable_writeback_sequence(dc, wb_info, context, mpcc_inst, seq_state);
+			}
+		} else {
+			/* Disable writeback pipe and disconnect from MPCC */
+			dcn401_disable_writeback_sequence(dc, wb_info, seq_state);
+		}
+	}
+}
+
+void dcn401_enable_writeback_sequence(
+		struct dc *dc,
+		struct dc_writeback_info *wb_info,
+		struct dc_state *context,
+		int mpcc_inst,
+		struct block_sequence_state *seq_state)
+{
+	struct dwbc *dwb;
+	struct mcif_wb *mcif_wb;
+
+	if (!wb_info->wb_enabled || wb_info->dwb_pipe_inst >= dc->res_pool->res_cap->num_dwb)
+		return;
+
+	dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
+	mcif_wb = dc->res_pool->mcif_wb[wb_info->dwb_pipe_inst];
+
+	/* Update DWBC with new parameters */
+	hwss_add_dwbc_update(seq_state, dwb, &wb_info->dwb_params);
+
+	/* Configure MCIF_WB buffer settings */
+	hwss_add_mcif_wb_config_buf(seq_state, mcif_wb, &wb_info->mcif_buf_params, wb_info->dwb_params.dest_height);
+
+	/* Configure MCIF_WB arbitration */
+	hwss_add_mcif_wb_config_arb(seq_state, mcif_wb, &context->bw_ctx.bw.dcn.bw_writeback.mcif_wb_arb[wb_info->dwb_pipe_inst]);
+
+	/* Enable MCIF_WB */
+	hwss_add_mcif_wb_enable(seq_state, mcif_wb);
+
+	/* Set DWB MUX to connect writeback to MPCC */
+	hwss_add_mpc_set_dwb_mux(seq_state, dc->res_pool->mpc, wb_info->dwb_pipe_inst, mpcc_inst);
+
+	/* Enable DWBC */
+	hwss_add_dwbc_enable(seq_state, dwb, &wb_info->dwb_params);
+}
+
+void dcn401_disable_writeback_sequence(
+		struct dc *dc,
+		struct dc_writeback_info *wb_info,
+		struct block_sequence_state *seq_state)
+{
+	struct dwbc *dwb;
+	struct mcif_wb *mcif_wb;
+
+	if (wb_info->dwb_pipe_inst >= dc->res_pool->res_cap->num_dwb)
+		return;
+
+	dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
+	mcif_wb = dc->res_pool->mcif_wb[wb_info->dwb_pipe_inst];
+
+	/* Disable DWBC */
+	hwss_add_dwbc_disable(seq_state, dwb);
+
+	/* Disable DWB MUX */
+	hwss_add_mpc_disable_dwb_mux(seq_state, dc->res_pool->mpc, wb_info->dwb_pipe_inst);
+
+	/* Disable MCIF_WB */
+	hwss_add_mcif_wb_disable(seq_state, mcif_wb);
+}
+
+void dcn401_update_writeback_sequence(
+		struct dc *dc,
+		struct dc_writeback_info *wb_info,
+		struct dc_state *context,
+		struct block_sequence_state *seq_state)
+{
+	struct dwbc *dwb;
+	struct mcif_wb *mcif_wb;
+
+	if (!wb_info->wb_enabled || wb_info->dwb_pipe_inst >= dc->res_pool->res_cap->num_dwb)
+		return;
+
+	dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
+	mcif_wb = dc->res_pool->mcif_wb[wb_info->dwb_pipe_inst];
+
+	/* Update writeback pipe */
+	hwss_add_dwbc_update(seq_state, dwb, &wb_info->dwb_params);
+
+	/* Update MCIF_WB buffer settings if needed */
+	hwss_add_mcif_wb_config_buf(seq_state, mcif_wb, &wb_info->mcif_buf_params, wb_info->dwb_params.dest_height);
+}
+
+static int find_free_gsl_group(const struct dc *dc)
+{
+	if (dc->res_pool->gsl_groups.gsl_0 == 0)
+		return 1;
+	if (dc->res_pool->gsl_groups.gsl_1 == 0)
+		return 2;
+	if (dc->res_pool->gsl_groups.gsl_2 == 0)
+		return 3;
+
+	return 0;
+}
+
+void dcn401_setup_gsl_group_as_lock_sequence(
+		const struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool enable,
+		struct block_sequence_state *seq_state)
+{
+	struct gsl_params gsl;
+	int group_idx;
+
+	memset(&gsl, 0, sizeof(struct gsl_params));
+
+	if (enable) {
+		/* return if group already assigned since GSL was set up
+		 * for vsync flip, we would unassign so it can't be "left over"
+		 */
+		if (pipe_ctx->stream_res.gsl_group > 0)
+			return;
+
+		group_idx = find_free_gsl_group(dc);
+		ASSERT(group_idx != 0);
+		pipe_ctx->stream_res.gsl_group = group_idx;
+
+		/* set gsl group reg field and mark resource used */
+		switch (group_idx) {
+		case 1:
+			gsl.gsl0_en = 1;
+			dc->res_pool->gsl_groups.gsl_0 = 1;
+			break;
+		case 2:
+			gsl.gsl1_en = 1;
+			dc->res_pool->gsl_groups.gsl_1 = 1;
+			break;
+		case 3:
+			gsl.gsl2_en = 1;
+			dc->res_pool->gsl_groups.gsl_2 = 1;
+			break;
+		default:
+			BREAK_TO_DEBUGGER();
+			return; // invalid case
+		}
+		gsl.gsl_master_en = 1;
+	} else {
+		group_idx = pipe_ctx->stream_res.gsl_group;
+		if (group_idx == 0)
+			return; // if not in use, just return
+
+		pipe_ctx->stream_res.gsl_group = 0;
+
+		/* unset gsl group reg field and mark resource free */
+		switch (group_idx) {
+		case 1:
+			gsl.gsl0_en = 0;
+			dc->res_pool->gsl_groups.gsl_0 = 0;
+			break;
+		case 2:
+			gsl.gsl1_en = 0;
+			dc->res_pool->gsl_groups.gsl_1 = 0;
+			break;
+		case 3:
+			gsl.gsl2_en = 0;
+			dc->res_pool->gsl_groups.gsl_2 = 0;
+			break;
+		default:
+			BREAK_TO_DEBUGGER();
+			return;
+		}
+		gsl.gsl_master_en = 0;
+	}
+
+	hwss_add_tg_set_gsl(seq_state, pipe_ctx->stream_res.tg, gsl);
+	hwss_add_tg_set_gsl_source_select(seq_state, pipe_ctx->stream_res.tg, group_idx, enable ? 4 : 0);
+}
+
+void dcn401_disable_plane_sequence(
+		struct dc *dc,
+		struct dc_state *state,
+		struct pipe_ctx *pipe_ctx,
+		struct block_sequence_state *seq_state)
+{
+	bool is_phantom = dc_state_get_pipe_subvp_type(state, pipe_ctx) == SUBVP_PHANTOM;
+	struct timing_generator *tg = is_phantom ? pipe_ctx->stream_res.tg : NULL;
+
+	if (!pipe_ctx->plane_res.hubp || pipe_ctx->plane_res.hubp->power_gated)
+		return;
+
+	/* Wait for MPCC disconnect */
+	if (dc->hwss.wait_for_mpcc_disconnect_sequence)
+		dc->hwss.wait_for_mpcc_disconnect_sequence(dc, dc->res_pool, pipe_ctx, seq_state);
+
+	/* In flip immediate with pipe splitting case GSL is used for synchronization
+	 * so we must disable it when the plane is disabled.
+	 */
+	if (pipe_ctx->stream_res.gsl_group != 0) {
+		dcn401_setup_gsl_group_as_lock_sequence(dc, pipe_ctx, false, seq_state);
+	}
+
+	/* Update HUBP mall sel */
+	if (pipe_ctx->plane_res.hubp && pipe_ctx->plane_res.hubp->funcs->hubp_update_mall_sel) {
+		hwss_add_hubp_update_mall_sel(seq_state, pipe_ctx->plane_res.hubp, 0, false);
+	}
+
+	/* Set flip control GSL */
+	hwss_add_hubp_set_flip_control_gsl(seq_state, pipe_ctx->plane_res.hubp, false);
+
+	/* HUBP clock control */
+	hwss_add_hubp_clk_cntl(seq_state, pipe_ctx->plane_res.hubp, false);
+
+	/* DPP clock control */
+	hwss_add_dpp_dppclk_control(seq_state, pipe_ctx->plane_res.dpp, false, false);
+
+	/* Plane atomic power down */
+	if (dc->hwseq->funcs.plane_atomic_power_down_sequence)
+		dc->hwseq->funcs.plane_atomic_power_down_sequence(dc, pipe_ctx->plane_res.dpp,
+			pipe_ctx->plane_res.hubp, seq_state);
+
+	pipe_ctx->stream = NULL;
+	memset(&pipe_ctx->stream_res, 0, sizeof(pipe_ctx->stream_res));
+	memset(&pipe_ctx->plane_res, 0, sizeof(pipe_ctx->plane_res));
+	pipe_ctx->top_pipe = NULL;
+	pipe_ctx->bottom_pipe = NULL;
+	pipe_ctx->prev_odm_pipe = NULL;
+	pipe_ctx->next_odm_pipe = NULL;
+	pipe_ctx->plane_state = NULL;
+
+	/* Turn back off the phantom OTG after the phantom plane is fully disabled */
+	if (is_phantom && tg && tg->funcs->disable_phantom_crtc) {
+		hwss_add_disable_phantom_crtc(seq_state, tg);
+	}
+}
+
+void dcn401_post_unlock_reset_opp_sequence(
+		struct dc *dc,
+		struct pipe_ctx *opp_head,
+		struct block_sequence_state *seq_state)
+{
+	struct display_stream_compressor *dsc = opp_head->stream_res.dsc;
+	struct dccg *dccg = dc->res_pool->dccg;
+
+	/* Wait for all DPP pipes in current mpc blending tree completes double
+	 * buffered disconnection before resetting OPP
+	 */
+	if (dc->hwss.wait_for_mpcc_disconnect_sequence)
+		dc->hwss.wait_for_mpcc_disconnect_sequence(dc, dc->res_pool, opp_head, seq_state);
+
+	if (dsc) {
+		bool *is_ungated = NULL;
+		/* Check DSC power gate status */
+		if (dc->hwseq && dc->hwseq->funcs.dsc_pg_status) {
+			hwss_add_dsc_pg_status(seq_state, dc->hwseq, dsc->inst, false);
+		}
+
+		/* Seamless update specific where we will postpone non
+			* double buffered DSCCLK disable logic in post unlock
+			* sequence after DSC is disconnected from OPP but not
+			* yet power gated.
+			*/
+
+		/* DSC wait disconnect pending clear */
+		hwss_add_dsc_wait_disconnect_pending_clear(seq_state, dsc, is_ungated);
+
+		/* DSC disable */
+		hwss_add_dsc_disable(seq_state, dsc, is_ungated);
+
+		/* Set reference DSCCLK */
+		if (dccg && dccg->funcs->set_ref_dscclk) {
+			hwss_add_dccg_set_ref_dscclk(seq_state, dccg, dsc->inst, 0);
+		}
+	}
+}
+
+void dcn401_dc_ip_request_cntl(struct dc *dc, bool enable)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+
+	if (REG(DC_IP_REQUEST_CNTL)) {
+		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, enable ? 1 : 0);
+	}
+}
+
+void dcn401_enable_plane_sequence(struct dc *dc, struct pipe_ctx *pipe_ctx,
+				 struct dc_state *context,
+				 struct block_sequence_state *seq_state)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	uint32_t org_ip_request_cntl = 0;
+
+	if (!pipe_ctx->plane_res.dpp || !pipe_ctx->plane_res.hubp || !pipe_ctx->stream_res.opp) {
+		return;
+	}
+
+	if (REG(DC_IP_REQUEST_CNTL))
+		REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+
+	/* Step 1: DPP root clock control - enable clock */
+	if (hws->funcs.dpp_root_clock_control) {
+		hwss_add_dpp_root_clock_control(seq_state, hws, pipe_ctx->plane_res.dpp->inst, true);
+	}
+
+	/* Step 2: Enable DC IP request (if needed) */
+	if (hws->funcs.dc_ip_request_cntl) {
+		hwss_add_dc_ip_request_cntl(seq_state, dc, true);
+	}
+
+	/* Step 3: DPP power gating control - power on */
+	if (REG(DC_IP_REQUEST_CNTL) && hws->funcs.dpp_pg_control) {
+		hwss_add_dpp_pg_control(seq_state, hws, pipe_ctx->plane_res.dpp->inst, true);
+	}
+
+	/* Step 4: HUBP power gating control - power on */
+	if (REG(DC_IP_REQUEST_CNTL) && hws->funcs.hubp_pg_control) {
+		hwss_add_hubp_pg_control(seq_state, hws, pipe_ctx->plane_res.hubp->inst, true);
+	}
+
+	/* Step 5: Disable DC IP request (restore state) */
+	if (org_ip_request_cntl == 0 && hws->funcs.dc_ip_request_cntl) {
+		hwss_add_dc_ip_request_cntl(seq_state, dc, false);
+	}
+
+	/* Step 6: HUBP clock control - enable DCFCLK */
+	if (pipe_ctx->plane_res.hubp->funcs->hubp_clk_cntl) {
+		hwss_add_hubp_clk_cntl(seq_state, pipe_ctx->plane_res.hubp, true);
+	}
+
+	/* Step 7: HUBP initialization */
+	if (pipe_ctx->plane_res.hubp->funcs->hubp_init) {
+		hwss_add_hubp_init(seq_state, pipe_ctx->plane_res.hubp);
+	}
+
+	/* Step 8: OPP pipe clock control - enable */
+	if (pipe_ctx->stream_res.opp->funcs->opp_pipe_clock_control) {
+		hwss_add_opp_pipe_clock_control(seq_state, pipe_ctx->stream_res.opp, true);
+	}
+
+	/* Step 9: VM system aperture settings */
+	if (dc->vm_pa_config.valid && pipe_ctx->plane_res.hubp->funcs->hubp_set_vm_system_aperture_settings) {
+		hwss_add_hubp_set_vm_system_aperture_settings(seq_state, pipe_ctx->plane_res.hubp, 0,
+			dc->vm_pa_config.system_aperture.start_addr, dc->vm_pa_config.system_aperture.end_addr);
+	}
+
+	/* Step 10: Flip interrupt setup */
+	if (!pipe_ctx->top_pipe
+			&& pipe_ctx->plane_state
+			&& pipe_ctx->plane_state->flip_int_enabled
+			&& pipe_ctx->plane_res.hubp->funcs->hubp_set_flip_int) {
+		hwss_add_hubp_set_flip_int(seq_state, pipe_ctx->plane_res.hubp);
+	}
+}
+
+void dcn401_update_dchubp_dpp_sequence(struct dc *dc,
+				       struct pipe_ctx *pipe_ctx,
+				       struct dc_state *context,
+				       struct block_sequence_state *seq_state)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	struct hubp *hubp = pipe_ctx->plane_res.hubp;
+	struct dpp *dpp = pipe_ctx->plane_res.dpp;
+	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
+	struct dccg *dccg = dc->res_pool->dccg;
+	bool viewport_changed = false;
+	enum mall_stream_type pipe_mall_type = dc_state_get_pipe_subvp_type(context, pipe_ctx);
+
+	if (!hubp || !dpp || !plane_state) {
+		return;
+	}
+
+	/* Step 1: DPP DPPCLK control */
+	if (pipe_ctx->update_flags.bits.dppclk) {
+		hwss_add_dpp_dppclk_control(seq_state, dpp, false, true);
+	}
+
+	/* Step 2: DCCG update DPP DTO */
+	if (pipe_ctx->update_flags.bits.enable) {
+		hwss_add_dccg_update_dpp_dto(seq_state, dccg, dpp->inst, pipe_ctx->plane_res.bw.dppclk_khz);
+	}
+
+	/* Step 3: HUBP VTG selection */
+	if (pipe_ctx->update_flags.bits.hubp_rq_dlg_ttu) {
+		hwss_add_hubp_vtg_sel(seq_state, hubp, pipe_ctx->stream_res.tg->inst);
+
+		/* Step 4: HUBP setup (choose setup2 or setup) */
+		if (hubp->funcs->hubp_setup2) {
+			hwss_add_hubp_setup2(seq_state, hubp, &pipe_ctx->hubp_regs,
+				&pipe_ctx->global_sync, &pipe_ctx->stream->timing);
+		} else if (hubp->funcs->hubp_setup) {
+			hwss_add_hubp_setup(seq_state, hubp, &pipe_ctx->dlg_regs,
+				&pipe_ctx->ttu_regs, &pipe_ctx->rq_regs, &pipe_ctx->pipe_dlg_param);
+		}
+	}
+
+	/* Step 5: Set unbounded requesting */
+	if (pipe_ctx->update_flags.bits.unbounded_req && hubp->funcs->set_unbounded_requesting) {
+		hwss_add_hubp_set_unbounded_requesting(seq_state, hubp, pipe_ctx->unbounded_req);
+	}
+
+	/* Step 6: HUBP interdependent setup */
+	if (pipe_ctx->update_flags.bits.hubp_interdependent) {
+		if (hubp->funcs->hubp_setup_interdependent2) {
+			hwss_add_hubp_setup_interdependent2(seq_state, hubp, &pipe_ctx->hubp_regs);
+		} else if (hubp->funcs->hubp_setup_interdependent) {
+			hwss_add_hubp_setup_interdependent(seq_state, hubp, &pipe_ctx->dlg_regs, &pipe_ctx->ttu_regs);
+		}
+	}
+
+	/* Step 7: DPP setup - input CSC and format setup */
+	if (pipe_ctx->update_flags.bits.enable ||
+			pipe_ctx->update_flags.bits.plane_changed ||
+			plane_state->update_flags.bits.bpp_change ||
+			plane_state->update_flags.bits.input_csc_change ||
+			plane_state->update_flags.bits.color_space_change ||
+			plane_state->update_flags.bits.coeff_reduction_change) {
+		hwss_add_dpp_setup_dpp(seq_state, pipe_ctx);
+
+		/* Step 8: DPP cursor matrix setup */
+		if (dpp->funcs->set_cursor_matrix) {
+			hwss_add_dpp_set_cursor_matrix(seq_state, dpp, plane_state->color_space,
+				&plane_state->cursor_csc_color_matrix);
+		}
+
+		/* Step 9: DPP program bias and scale */
+		if (dpp->funcs->dpp_program_bias_and_scale) {
+			hwss_add_dpp_program_bias_and_scale(seq_state, pipe_ctx);
+		}
+	}
+
+	/* Step 10: MPCC updates */
+	if (pipe_ctx->update_flags.bits.mpcc ||
+	     pipe_ctx->update_flags.bits.plane_changed ||
+	     plane_state->update_flags.bits.global_alpha_change ||
+	     plane_state->update_flags.bits.per_pixel_alpha_change) {
+
+		/* Check if update_mpcc_sequence is implemented and prefer it over single MPC_UPDATE_MPCC step */
+		if (hws->funcs.update_mpcc_sequence)
+			hws->funcs.update_mpcc_sequence(dc, pipe_ctx, seq_state);
+	}
+
+	/* Step 11: DPP scaler setup */
+	if (pipe_ctx->update_flags.bits.scaler ||
+			plane_state->update_flags.bits.scaling_change ||
+			plane_state->update_flags.bits.position_change ||
+			plane_state->update_flags.bits.per_pixel_alpha_change ||
+			pipe_ctx->stream->update_flags.bits.scaling) {
+		pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->plane_state->per_pixel_alpha;
+		ASSERT(pipe_ctx->plane_res.scl_data.lb_params.depth == LB_PIXEL_DEPTH_36BPP);
+		hwss_add_dpp_set_scaler(seq_state, pipe_ctx->plane_res.dpp, &pipe_ctx->plane_res.scl_data);
+	}
+
+	/* Step 12: HUBP viewport programming */
+	if (pipe_ctx->update_flags.bits.viewport ||
+	     (context == dc->current_state && plane_state->update_flags.bits.position_change) ||
+	     (context == dc->current_state && plane_state->update_flags.bits.scaling_change) ||
+	     (context == dc->current_state && pipe_ctx->stream->update_flags.bits.scaling)) {
+		hwss_add_hubp_mem_program_viewport(seq_state, hubp,
+			&pipe_ctx->plane_res.scl_data.viewport, &pipe_ctx->plane_res.scl_data.viewport_c);
+		viewport_changed = true;
+	}
+
+	/* Step 13: HUBP program mcache if available */
+	if (hubp->funcs->hubp_program_mcache_id_and_split_coordinate) {
+		hwss_add_hubp_program_mcache_id(seq_state, hubp, &pipe_ctx->mcache_regs);
+	}
+
+	/* Step 14: Cursor attribute setup */
+	if ((pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed ||
+	     pipe_ctx->update_flags.bits.scaler || viewport_changed == true) &&
+	    pipe_ctx->stream->cursor_attributes.address.quad_part != 0) {
+
+		hwss_add_set_cursor_attribute(seq_state, dc, pipe_ctx);
+
+		/* Step 15: Cursor position setup */
+		hwss_add_set_cursor_position(seq_state, dc, pipe_ctx);
+
+		/* Step 16: Cursor SDR white level */
+		if (dc->hwss.set_cursor_sdr_white_level) {
+			hwss_add_set_cursor_sdr_white_level(seq_state, dc, pipe_ctx);
+		}
+	}
+
+	/* Step 17: Gamut remap and output CSC */
+	if (pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed ||
+			pipe_ctx->update_flags.bits.plane_changed ||
+			pipe_ctx->stream->update_flags.bits.gamut_remap ||
+			plane_state->update_flags.bits.gamut_remap_change ||
+			pipe_ctx->stream->update_flags.bits.out_csc) {
+
+		/* Gamut remap */
+		hwss_add_dpp_program_gamut_remap(seq_state, pipe_ctx);
+
+		/* Output CSC */
+		hwss_add_program_output_csc(seq_state, dc, pipe_ctx, pipe_ctx->stream->output_color_space,
+			pipe_ctx->stream->csc_color_matrix.matrix, hubp->opp_id);
+	}
+
+	/* Step 18: HUBP surface configuration */
+	if (pipe_ctx->update_flags.bits.enable ||
+			pipe_ctx->update_flags.bits.plane_changed ||
+			pipe_ctx->update_flags.bits.opp_changed ||
+			plane_state->update_flags.bits.pixel_format_change ||
+			plane_state->update_flags.bits.horizontal_mirror_change ||
+			plane_state->update_flags.bits.rotation_change ||
+			plane_state->update_flags.bits.swizzle_change ||
+			plane_state->update_flags.bits.dcc_change ||
+			plane_state->update_flags.bits.bpp_change ||
+			plane_state->update_flags.bits.scaling_change ||
+			plane_state->update_flags.bits.plane_size_change) {
+		struct plane_size size = plane_state->plane_size;
+
+		size.surface_size = pipe_ctx->plane_res.scl_data.viewport;
+		hwss_add_hubp_program_surface_config(seq_state, hubp,
+				plane_state->format, &plane_state->tiling_info, size,
+				plane_state->rotation, &plane_state->dcc,
+				plane_state->horizontal_mirror, 0);
+		hubp->power_gated = false;
+	}
+
+	/* Step 19: Update plane address (with SubVP support) */
+	if (pipe_ctx->update_flags.bits.enable ||
+	     pipe_ctx->update_flags.bits.plane_changed ||
+	     plane_state->update_flags.bits.addr_update) {
+
+		/* SubVP save surface address if needed */
+		if (resource_is_pipe_type(pipe_ctx, OTG_MASTER) && pipe_mall_type == SUBVP_MAIN) {
+			hwss_add_dmub_subvp_save_surf_addr(seq_state, dc->ctx->dmub_srv, &pipe_ctx->plane_state->address, pipe_ctx->subvp_index);
+		}
+
+		/* Update plane address */
+		hwss_add_hubp_update_plane_addr(seq_state, dc, pipe_ctx);
+	}
+
+	/* Step 20: HUBP set blank - enable plane */
+	if (pipe_ctx->update_flags.bits.enable) {
+		hwss_add_hubp_set_blank(seq_state, hubp, false);
+	}
+
+	/* Step 21: Phantom HUBP post enable */
+	if (pipe_mall_type == SUBVP_PHANTOM && hubp->funcs->phantom_hubp_post_enable) {
+		hwss_add_phantom_hubp_post_enable(seq_state, hubp);
+	}
+}
+
+void dcn401_update_mpcc_sequence(struct dc *dc,
+				struct pipe_ctx *pipe_ctx,
+				struct block_sequence_state *seq_state)
+{
+	struct hubp *hubp = pipe_ctx->plane_res.hubp;
+	struct mpcc_blnd_cfg blnd_cfg = {0};
+	bool per_pixel_alpha;
+	int mpcc_id;
+	struct mpcc *new_mpcc;
+	struct mpc *mpc = dc->res_pool->mpc;
+	struct mpc_tree *mpc_tree_params = &(pipe_ctx->stream_res.opp->mpc_tree_params);
+
+	if (!hubp || !pipe_ctx->plane_state) {
+		return;
+	}
+
+	per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha;
+
+	/* Initialize blend configuration */
+	blnd_cfg.overlap_only = false;
+	blnd_cfg.global_gain = 0xff;
+
+	if (per_pixel_alpha) {
+		blnd_cfg.pre_multiplied_alpha = pipe_ctx->plane_state->pre_multiplied_alpha;
+		if (pipe_ctx->plane_state->global_alpha) {
+			blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINED_GLOBAL_GAIN;
+			blnd_cfg.global_gain = pipe_ctx->plane_state->global_alpha_value;
+		} else {
+			blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
+		}
+	} else {
+		blnd_cfg.pre_multiplied_alpha = false;
+		blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_GLOBAL_ALPHA;
+	}
+
+	if (pipe_ctx->plane_state->global_alpha)
+		blnd_cfg.global_alpha = pipe_ctx->plane_state->global_alpha_value;
+	else
+		blnd_cfg.global_alpha = 0xff;
+
+	blnd_cfg.background_color_bpc = 4;
+	blnd_cfg.bottom_gain_mode = 0;
+	blnd_cfg.top_gain = 0x1f000;
+	blnd_cfg.bottom_inside_gain = 0x1f000;
+	blnd_cfg.bottom_outside_gain = 0x1f000;
+
+	if (pipe_ctx->plane_state->format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA)
+		blnd_cfg.pre_multiplied_alpha = false;
+
+	/* MPCC instance is equal to HUBP instance */
+	mpcc_id = hubp->inst;
+
+	/* Step 1: Update blending if no full update needed */
+	if (!pipe_ctx->plane_state->update_flags.bits.full_update &&
+	    !pipe_ctx->update_flags.bits.mpcc) {
+
+		/* Update blending configuration */
+		hwss_add_mpc_update_blending(seq_state, mpc, blnd_cfg, mpcc_id);
+
+		/* Update visual confirm color */
+		hwss_add_mpc_update_visual_confirm(seq_state, dc, pipe_ctx, mpcc_id);
+		return;
+	}
+
+	/* Step 2: Get existing MPCC for DPP */
+	new_mpcc = mpc->funcs->get_mpcc_for_dpp(mpc_tree_params, mpcc_id);
+
+	/* Step 3: Remove MPCC if being used */
+	if (new_mpcc != NULL) {
+		hwss_add_mpc_remove_mpcc(seq_state, mpc, mpc_tree_params, new_mpcc);
+	} else {
+		/* Step 4: Assert MPCC idle (debug only) */
+		if (dc->debug.sanity_checks) {
+			hwss_add_mpc_assert_idle_mpcc(seq_state, mpc, mpcc_id);
+		}
+	}
+
+	/* Step 5: Insert new plane into MPC tree */
+	hwss_add_mpc_insert_plane(seq_state, mpc, mpc_tree_params, blnd_cfg, NULL, NULL, hubp->inst, mpcc_id);
+
+	/* Step 6: Update visual confirm color */
+	hwss_add_mpc_update_visual_confirm(seq_state, dc, pipe_ctx, mpcc_id);
+
+	/* Step 7: Set HUBP OPP and MPCC IDs */
+	hubp->opp_id = pipe_ctx->stream_res.opp->inst;
+	hubp->mpcc_id = mpcc_id;
+}
+
+static struct hubp *get_hubp_by_inst(struct resource_pool *res_pool, int mpcc_inst)
+{
+	int i;
+
+	for (i = 0; i < res_pool->pipe_count; i++) {
+		if (res_pool->hubps[i]->inst == mpcc_inst)
+			return res_pool->hubps[i];
+	}
+	ASSERT(false);
+	return NULL;
+}
+
+void dcn401_wait_for_mpcc_disconnect_sequence(
+		struct dc *dc,
+		struct resource_pool *res_pool,
+		struct pipe_ctx *pipe_ctx,
+		struct block_sequence_state *seq_state)
+{
+	int mpcc_inst;
+
+	if (dc->debug.sanity_checks) {
+		dc->hwseq->funcs.verify_allow_pstate_change_high_sequence(dc, seq_state);
+	}
+
+	if (!pipe_ctx->stream_res.opp)
+		return;
+
+	for (mpcc_inst = 0; mpcc_inst < MAX_PIPES; mpcc_inst++) {
+		if (pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst]) {
+			struct hubp *hubp = get_hubp_by_inst(res_pool, mpcc_inst);
+
+			if (pipe_ctx->stream_res.tg &&
+				pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.tg)) {
+				hwss_add_mpc_assert_idle_mpcc(seq_state, res_pool->mpc, mpcc_inst);
+			}
+			pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst] = false;
+			if (hubp) {
+				hwss_add_hubp_set_blank(seq_state, hubp, true);
+			}
+		}
+	}
+
+	if (dc->debug.sanity_checks) {
+		dc->hwseq->funcs.verify_allow_pstate_change_high_sequence(dc, seq_state);
+	}
+}
+
+void dcn401_setup_vupdate_interrupt_sequence(struct dc *dc, struct pipe_ctx *pipe_ctx,
+		struct block_sequence_state *seq_state)
+{
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
+	int start_line = dc->hwss.get_vupdate_offset_from_vsync(pipe_ctx);
+
+	if (start_line < 0)
+		start_line = 0;
+
+	if (tg->funcs->setup_vertical_interrupt2) {
+		hwss_add_tg_setup_vertical_interrupt2(seq_state, tg, start_line);
+	}
+}
+
+void dcn401_set_hdr_multiplier_sequence(struct pipe_ctx *pipe_ctx,
+		struct block_sequence_state *seq_state)
+{
+	struct fixed31_32 multiplier = pipe_ctx->plane_state->hdr_mult;
+	uint32_t hw_mult = 0x1f000; // 1.0 default multiplier
+	struct custom_float_format fmt;
+
+	fmt.exponenta_bits = 6;
+	fmt.mantissa_bits = 12;
+	fmt.sign = true;
+
+	if (!dc_fixpt_eq(multiplier, dc_fixpt_from_int(0))) // check != 0
+		convert_to_custom_float_format(multiplier, &fmt, &hw_mult);
+
+	hwss_add_dpp_set_hdr_multiplier(seq_state, pipe_ctx->plane_res.dpp, hw_mult);
+}
+
+void dcn401_program_mall_pipe_config_sequence(struct dc *dc, struct dc_state *context,
+		struct block_sequence_state *seq_state)
+{
+	int i;
+	unsigned int num_ways = dcn401_calculate_cab_allocation(dc, context);
+	bool cache_cursor = false;
+
+	// Don't force p-state disallow -- can't block dummy p-state
+
+	// Update MALL_SEL register for each pipe (break down update_mall_sel call)
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct hubp *hubp = pipe->plane_res.hubp;
+
+		if (pipe->stream && pipe->plane_state && hubp && hubp->funcs->hubp_update_mall_sel) {
+			int cursor_size = hubp->curs_attr.pitch * hubp->curs_attr.height;
+
+			switch (hubp->curs_attr.color_format) {
+			case CURSOR_MODE_MONO:
+				cursor_size /= 2;
+				break;
+			case CURSOR_MODE_COLOR_1BIT_AND:
+			case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
+			case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
+				cursor_size *= 4;
+				break;
+
+			case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
+			case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
+			default:
+				cursor_size *= 8;
+				break;
+			}
+
+			if (cursor_size > 16384)
+				cache_cursor = true;
+
+			if (dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM) {
+				hwss_add_hubp_update_mall_sel(seq_state, hubp, 1, false);
+			} else {
+				// MALL not supported with Stereo3D
+				uint32_t mall_sel = (num_ways <= dc->caps.cache_num_ways &&
+					pipe->stream->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED &&
+					pipe->plane_state->address.type != PLN_ADDR_TYPE_GRPH_STEREO &&
+					!pipe->plane_state->address.tmz_surface) ? 2 : 0;
+				hwss_add_hubp_update_mall_sel(seq_state, hubp, mall_sel, cache_cursor);
+			}
+		}
+	}
+
+	// Program FORCE_ONE_ROW_FOR_FRAME and CURSOR_REQ_MODE for main subvp pipes
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct hubp *hubp = pipe->plane_res.hubp;
+
+		if (pipe->stream && hubp && hubp->funcs->hubp_prepare_subvp_buffering) {
+			if (dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_MAIN) {
+				hwss_add_hubp_prepare_subvp_buffering(seq_state, hubp, true);
+			}
+		}
+	}
+}
+
+void dcn401_verify_allow_pstate_change_high_sequence(struct dc *dc,
+		struct block_sequence_state *seq_state)
+{
+	struct hubbub *hubbub = dc->res_pool->hubbub;
+
+	if (!hubbub->funcs->verify_allow_pstate_change_high)
+		return;
+
+	if (!hubbub->funcs->verify_allow_pstate_change_high(hubbub)) {
+		/* Attempt hardware workaround force recovery */
+		dcn401_hw_wa_force_recovery_sequence(dc, seq_state);
+	}
+}
+
+bool dcn401_hw_wa_force_recovery_sequence(struct dc *dc,
+		struct block_sequence_state *seq_state)
+{
+	struct hubp *hubp;
+	unsigned int i;
+
+	if (!dc->debug.recovery_enabled)
+		return false;
+
+	/* Step 1: Set HUBP_BLANK_EN=1 for all active pipes */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe_ctx != NULL) {
+			hubp = pipe_ctx->plane_res.hubp;
+			if (hubp != NULL && hubp->funcs->set_hubp_blank_en) {
+				hwss_add_hubp_set_blank_en(seq_state, hubp, true);
+			}
+		}
+	}
+
+	/* Step 2: DCHUBBUB_GLOBAL_SOFT_RESET=1 */
+	hwss_add_hubbub_soft_reset(seq_state, dc->res_pool->hubbub, hubbub1_soft_reset, true);
+
+	/* Step 3: Set HUBP_DISABLE=1 for all active pipes */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe_ctx != NULL) {
+			hubp = pipe_ctx->plane_res.hubp;
+			if (hubp != NULL && hubp->funcs->hubp_disable_control) {
+				hwss_add_hubp_disable_control(seq_state, hubp, true);
+			}
+		}
+	}
+
+	/* Step 4: Set HUBP_DISABLE=0 for all active pipes */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe_ctx != NULL) {
+			hubp = pipe_ctx->plane_res.hubp;
+			if (hubp != NULL && hubp->funcs->hubp_disable_control) {
+				hwss_add_hubp_disable_control(seq_state, hubp, false);
+			}
+		}
+	}
+
+	/* Step 5: DCHUBBUB_GLOBAL_SOFT_RESET=0 */
+	hwss_add_hubbub_soft_reset(seq_state, dc->res_pool->hubbub, hubbub1_soft_reset, false);
+
+	/* Step 6: Set HUBP_BLANK_EN=0 for all active pipes */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe_ctx != NULL) {
+			hubp = pipe_ctx->plane_res.hubp;
+			if (hubp != NULL && hubp->funcs->set_hubp_blank_en) {
+				hwss_add_hubp_set_blank_en(seq_state, hubp, false);
+			}
+		}
+	}
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index f489bb7a4c26..f78162ab859b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -9,6 +9,7 @@
 #include "dc.h"
 #include "dc_stream.h"
 #include "hw_sequencer_private.h"
+#include "hwss/hw_sequencer.h"
 #include "dcn401/dcn401_dccg.h"
 
 struct dc;
@@ -82,6 +83,8 @@ void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx, struct dc_link_settings *l
 void dcn401_hardware_release(struct dc *dc);
 void dcn401_update_odm(struct dc *dc, struct dc_state *context,
 		struct pipe_ctx *otg_master);
+void dcn401_update_odm_sequence(struct dc *dc, struct dc_state *context,
+		struct pipe_ctx *otg_master, struct block_sequence_state *seq_state);
 void adjust_hotspot_between_slices_for_2x_magnify(uint32_t cursor_width, struct dc_cursor_position *pos_cpy);
 void dcn401_wait_for_det_buffer_update_under_otg_master(struct dc *dc, struct dc_state *context, struct pipe_ctx *otg_master);
 void dcn401_interdependent_update_lock(struct dc *dc, struct dc_state *context, bool lock);
@@ -97,6 +100,11 @@ void dcn401_program_pipe(
 	struct dc *dc,
 	struct pipe_ctx *pipe_ctx,
 	struct dc_state *context);
+void dcn401_program_pipe_sequence(
+	struct dc *dc,
+	struct pipe_ctx *pipe_ctx,
+	struct dc_state *context,
+	struct block_sequence_state *seq_state);
 void dcn401_perform_3dlut_wa_unlock(struct pipe_ctx *pipe_ctx);
 void dcn401_program_front_end_for_ctx(struct dc *dc, struct dc_state *context);
 void dcn401_post_unlock_program_front_end(struct dc *dc, struct dc_state *context);
@@ -109,7 +117,97 @@ void dcn401_detect_pipe_changes(
 void dcn401_plane_atomic_power_down(struct dc *dc,
 		struct dpp *dpp,
 		struct hubp *hubp);
+void dcn401_plane_atomic_power_down_sequence(struct dc *dc,
+		struct dpp *dpp,
+		struct hubp *hubp,
+		struct block_sequence_state *seq_state);
+void dcn401_plane_atomic_disconnect_sequence(struct dc *dc,
+		struct dc_state *state,
+		struct pipe_ctx *pipe_ctx,
+		struct block_sequence_state *seq_state);
+void dcn401_blank_pixel_data_sequence(
+	struct dc *dc,
+	struct pipe_ctx *pipe_ctx,
+	bool blank,
+	struct block_sequence_state *seq_state);
 void dcn401_initialize_min_clocks(struct dc *dc);
 void dcn401_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe);
 
+void dcn401_program_all_writeback_pipes_in_tree_sequence(
+		struct dc *dc,
+		const struct dc_stream_state *stream,
+		struct dc_state *context,
+		struct block_sequence_state *seq_state);
+
+void dcn401_enable_writeback_sequence(
+		struct dc *dc,
+		struct dc_writeback_info *wb_info,
+		struct dc_state *context,
+		int mpcc_inst,
+		struct block_sequence_state *seq_state);
+
+void dcn401_disable_writeback_sequence(
+		struct dc *dc,
+		struct dc_writeback_info *wb_info,
+		struct block_sequence_state *seq_state);
+
+void dcn401_update_writeback_sequence(
+		struct dc *dc,
+		struct dc_writeback_info *wb_info,
+		struct dc_state *context,
+		struct block_sequence_state *seq_state);
+
+void dcn401_setup_gsl_group_as_lock_sequence(
+		const struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool enable,
+		struct block_sequence_state *seq_state);
+
+void dcn401_disable_plane_sequence(
+		struct dc *dc,
+		struct dc_state *state,
+		struct pipe_ctx *pipe_ctx,
+		struct block_sequence_state *seq_state);
+
+void dcn401_post_unlock_reset_opp_sequence(
+		struct dc *dc,
+		struct pipe_ctx *opp_head,
+		struct block_sequence_state *seq_state);
+
+void dcn401_dc_ip_request_cntl(struct dc *dc, bool enable);
+
+void dcn401_enable_plane_sequence(struct dc *dc, struct pipe_ctx *pipe_ctx,
+				 struct dc_state *context,
+				 struct block_sequence_state *seq_state);
+
+void dcn401_update_dchubp_dpp_sequence(struct dc *dc,
+				       struct pipe_ctx *pipe_ctx,
+				       struct dc_state *context,
+				       struct block_sequence_state *seq_state);
+
+void dcn401_update_mpcc_sequence(struct dc *dc,
+				struct pipe_ctx *pipe_ctx,
+				struct block_sequence_state *seq_state);
+
+void dcn401_wait_for_mpcc_disconnect_sequence(
+		struct dc *dc,
+		struct resource_pool *res_pool,
+		struct pipe_ctx *pipe_ctx,
+		struct block_sequence_state *seq_state);
+
+void dcn401_setup_vupdate_interrupt_sequence(struct dc *dc, struct pipe_ctx *pipe_ctx,
+		struct block_sequence_state *seq_state);
+
+void dcn401_set_hdr_multiplier_sequence(struct pipe_ctx *pipe_ctx,
+		struct block_sequence_state *seq_state);
+
+void dcn401_program_mall_pipe_config_sequence(struct dc *dc, struct dc_state *context,
+		struct block_sequence_state *seq_state);
+
+void dcn401_verify_allow_pstate_change_high_sequence(struct dc *dc,
+		struct block_sequence_state *seq_state);
+
+bool dcn401_hw_wa_force_recovery_sequence(struct dc *dc,
+		struct block_sequence_state *seq_state);
+
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 1c736b7e3300..162096ce0bdf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -39,6 +39,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.enable_audio_stream = dce110_enable_audio_stream,
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
+	.disable_plane_sequence = dcn401_disable_plane_sequence,
 	.pipe_control_lock = dcn20_pipe_control_lock,
 	.interdependent_update_lock = dcn401_interdependent_update_lock,
 	.cursor_lock = dcn10_cursor_lock,
@@ -54,6 +55,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
+	.wait_for_mpcc_disconnect_sequence = dcn401_wait_for_mpcc_disconnect_sequence,
 	.edp_backlight_control = dce110_edp_backlight_control,
 	.edp_power_control = dce110_edp_power_control,
 	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
@@ -109,48 +111,63 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
 	.detect_pipe_changes = dcn401_detect_pipe_changes,
 	.enable_plane = dcn20_enable_plane,
+	.enable_plane_sequence = dcn401_enable_plane_sequence,
 	.update_dchubp_dpp = dcn20_update_dchubp_dpp,
+	.update_dchubp_dpp_sequence = dcn401_update_dchubp_dpp_sequence,
 	.post_unlock_reset_opp = dcn20_post_unlock_reset_opp,
+	.post_unlock_reset_opp_sequence = dcn401_post_unlock_reset_opp_sequence,
 	.get_underflow_debug_data = dcn30_get_underflow_debug_data,
 };
 
 static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
+	.plane_atomic_disconnect_sequence = dcn401_plane_atomic_disconnect_sequence,
 	.update_mpcc = dcn20_update_mpcc,
+	.update_mpcc_sequence = dcn401_update_mpcc_sequence,
 	.set_input_transfer_func = dcn32_set_input_transfer_func,
 	.set_output_transfer_func = dcn401_set_output_transfer_func,
 	.power_down = dce110_power_down,
 	.enable_display_power_gating = dcn10_dummy_display_power_gating,
 	.blank_pixel_data = dcn20_blank_pixel_data,
+	.blank_pixel_data_sequence = dcn401_blank_pixel_data_sequence,
 	.reset_hw_ctx_wrap = dcn401_reset_hw_ctx_wrap,
 	.enable_stream_timing = dcn401_enable_stream_timing,
 	.edp_backlight_control = dce110_edp_backlight_control,
 	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
+	.setup_vupdate_interrupt_sequence = dcn401_setup_vupdate_interrupt_sequence,
 	.did_underflow_occur = dcn10_did_underflow_occur,
 	.init_blank = dcn32_init_blank,
 	.disable_vga = dcn20_disable_vga,
 	.bios_golden_init = dcn10_bios_golden_init,
 	.plane_atomic_disable = dcn20_plane_atomic_disable,
 	.plane_atomic_power_down = dcn401_plane_atomic_power_down,
+	.plane_atomic_power_down_sequence = dcn401_plane_atomic_power_down_sequence,
 	.enable_power_gating_plane = dcn32_enable_power_gating_plane,
 	.hubp_pg_control = dcn32_hubp_pg_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
+	.program_all_writeback_pipes_in_tree_sequence = dcn401_program_all_writeback_pipes_in_tree_sequence,
 	.update_odm = dcn401_update_odm,
+	.update_odm_sequence = dcn401_update_odm_sequence,
 	.dsc_pg_control = dcn32_dsc_pg_control,
 	.dsc_pg_status = dcn32_dsc_pg_status,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
+	.set_hdr_multiplier_sequence = dcn401_set_hdr_multiplier_sequence,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
+	.verify_allow_pstate_change_high_sequence = dcn401_verify_allow_pstate_change_high_sequence,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
 	.dccg_init = dcn20_dccg_init,
 	.set_mcm_luts = dcn401_set_mcm_luts,
 	.program_mall_pipe_config = dcn32_program_mall_pipe_config,
+	.program_mall_pipe_config_sequence = dcn401_program_mall_pipe_config_sequence,
 	.update_mall_sel = dcn32_update_mall_sel,
 	.calculate_dccg_k1_k2_values = NULL,
 	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
 	.reset_back_end_for_pipe = dcn401_reset_back_end_for_pipe,
 	.populate_mcm_luts = NULL,
 	.perform_3dlut_wa_unlock = dcn401_perform_3dlut_wa_unlock,
+	.program_pipe_sequence = dcn401_program_pipe_sequence,
+	.dc_ip_request_cntl = dcn401_dc_ip_request_cntl,
 };
 
 void dcn401_hw_sequencer_init_functions(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index a937a2b2135e..3772b4aa11cc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -31,6 +31,8 @@
 #include "inc/hw/opp.h"
 #include "inc/hw/link_encoder.h"
 #include "inc/core_status.h"
+#include "inc/hw/hw_shared.h"
+#include "dsc/dsc.h"
 
 struct pipe_ctx;
 struct dc_state;
@@ -48,6 +50,8 @@ struct dc_dmub_cmd;
 struct pg_block_update;
 struct drr_params;
 struct dc_underflow_debug_data;
+struct dsc_optc_config;
+struct vm_system_aperture_param;
 
 struct subvp_pipe_control_lock_fast_params {
 	struct dc *dc;
@@ -62,7 +66,7 @@ struct pipe_control_lock_params {
 };
 
 struct set_flip_control_gsl_params {
-	struct pipe_ctx *pipe_ctx;
+	struct hubp *hubp;
 	bool flip_immediate;
 };
 
@@ -154,11 +158,576 @@ struct dmub_hw_control_lock_fast_params {
 	bool lock;
 };
 
+struct program_surface_config_params {
+	struct hubp *hubp;
+	enum surface_pixel_format format;
+	struct dc_tiling_info *tiling_info;
+	struct plane_size plane_size;
+	enum dc_rotation_angle rotation;
+	struct dc_plane_dcc_param *dcc;
+	bool horizontal_mirror;
+	int compat_level;
+};
+
+struct program_mcache_id_and_split_coordinate {
+	struct hubp *hubp;
+	struct dml2_hubp_pipe_mcache_regs *mcache_regs;
+};
+
 struct program_cursor_update_now_params {
 	struct dc *dc;
 	struct pipe_ctx *pipe_ctx;
 };
 
+struct hubp_wait_pipe_read_start_params {
+	struct hubp *hubp;
+};
+
+struct apply_update_flags_for_phantom_params {
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct update_phantom_vp_position_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+	struct dc_state *context;
+};
+
+struct set_odm_combine_params {
+	struct timing_generator *tg;
+	int opp_inst[MAX_PIPES];
+	int opp_head_count;
+	int odm_slice_width;
+	int last_odm_slice_width;
+};
+
+struct set_odm_bypass_params {
+	struct timing_generator *tg;
+	const struct dc_crtc_timing *timing;
+};
+
+struct opp_pipe_clock_control_params {
+	struct output_pixel_processor *opp;
+	bool enable;
+};
+
+struct opp_program_left_edge_extra_pixel_params {
+	struct output_pixel_processor *opp;
+	enum dc_pixel_encoding pixel_encoding;
+	bool is_otg_master;
+};
+
+struct dccg_set_dto_dscclk_params {
+	struct dccg *dccg;
+	int inst;
+	int num_slices_h;
+};
+
+struct dsc_set_config_params {
+	struct display_stream_compressor *dsc;
+	struct dsc_config *dsc_cfg;
+	struct dsc_optc_config *dsc_optc_cfg;
+};
+
+struct dsc_enable_params {
+	struct display_stream_compressor *dsc;
+	int opp_inst;
+};
+
+struct tg_set_dsc_config_params {
+	struct timing_generator *tg;
+	struct dsc_optc_config *dsc_optc_cfg;
+	bool enable;
+};
+
+struct dsc_disconnect_params {
+	struct display_stream_compressor *dsc;
+};
+
+struct dsc_read_state_params {
+	struct display_stream_compressor *dsc;
+	struct dcn_dsc_state *dsc_state;
+};
+
+struct dsc_calculate_and_set_config_params {
+	struct pipe_ctx *pipe_ctx;
+	struct dsc_optc_config dsc_optc_cfg;
+	bool enable;
+	int opp_cnt;
+};
+
+struct dsc_enable_with_opp_params {
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct program_tg_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+	struct dc_state *context;
+};
+
+struct tg_program_global_sync_params {
+	struct timing_generator *tg;
+	int vready_offset;
+	unsigned int vstartup_lines;
+	unsigned int vupdate_offset_pixels;
+	unsigned int vupdate_vupdate_width_pixels;
+	unsigned int pstate_keepout_start_lines;
+};
+
+struct tg_wait_for_state_params {
+	struct timing_generator *tg;
+	enum crtc_state state;
+};
+
+struct tg_set_vtg_params_params {
+	struct timing_generator *tg;
+	struct dc_crtc_timing *timing;
+	bool program_fp2;
+};
+
+struct tg_set_gsl_params {
+	struct timing_generator *tg;
+	struct gsl_params gsl;
+};
+
+struct tg_set_gsl_source_select_params {
+	struct timing_generator *tg;
+	int group_idx;
+	uint32_t gsl_ready_signal;
+};
+
+struct setup_vupdate_interrupt_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct tg_setup_vertical_interrupt2_params {
+	struct timing_generator *tg;
+	int start_line;
+};
+
+struct dpp_set_hdr_multiplier_params {
+	struct dpp *dpp;
+	uint32_t hw_mult;
+};
+
+struct program_det_size_params {
+	struct hubbub *hubbub;
+	unsigned int hubp_inst;
+	unsigned int det_buffer_size_kb;
+};
+
+struct program_det_segments_params {
+	struct hubbub *hubbub;
+	unsigned int hubp_inst;
+	unsigned int det_size;
+};
+
+struct update_dchubp_dpp_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+	struct dc_state *context;
+};
+
+struct opp_set_dyn_expansion_params {
+	struct output_pixel_processor *opp;
+	enum dc_color_space color_space;
+	enum dc_color_depth color_depth;
+	enum signal_type signal;
+};
+
+struct opp_program_fmt_params {
+	struct output_pixel_processor *opp;
+	struct bit_depth_reduction_params *fmt_bit_depth;
+	struct clamping_and_pixel_encoding_params *clamping;
+};
+
+struct opp_program_bit_depth_reduction_params {
+	struct output_pixel_processor *opp;
+	bool use_default_params;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct opp_set_disp_pattern_generator_params {
+	struct output_pixel_processor *opp;
+	enum controller_dp_test_pattern test_pattern;
+	enum controller_dp_color_space color_space;
+	enum dc_color_depth color_depth;
+	struct tg_color solid_color;
+	bool use_solid_color;
+	int width;
+	int height;
+	int offset;
+};
+
+struct set_abm_pipe_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct set_abm_level_params {
+	struct abm *abm;
+	unsigned int abm_level;
+};
+
+struct set_abm_immediate_disable_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct set_disp_pattern_generator_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+	enum controller_dp_test_pattern test_pattern;
+	enum controller_dp_color_space color_space;
+	enum dc_color_depth color_depth;
+	const struct tg_color *solid_color;
+	int width;
+	int height;
+	int offset;
+};
+
+struct mpc_update_blending_params {
+	struct mpc *mpc;
+	struct mpcc_blnd_cfg blnd_cfg;
+	int mpcc_id;
+};
+
+struct mpc_assert_idle_mpcc_params {
+	struct mpc *mpc;
+	int mpcc_id;
+};
+
+struct mpc_insert_plane_params {
+	struct mpc *mpc;
+	struct mpc_tree *mpc_tree_params;
+	struct mpcc_blnd_cfg blnd_cfg;
+	struct mpcc_sm_cfg *sm_cfg;
+	struct mpcc *insert_above_mpcc;
+	int dpp_id;
+	int mpcc_id;
+};
+
+struct mpc_remove_mpcc_params {
+	struct mpc *mpc;
+	struct mpc_tree *mpc_tree_params;
+	struct mpcc *mpcc_to_remove;
+};
+
+struct opp_set_mpcc_disconnect_pending_params {
+	struct output_pixel_processor *opp;
+	int mpcc_inst;
+	bool pending;
+};
+
+struct dc_set_optimized_required_params {
+	struct dc *dc;
+	bool optimized_required;
+};
+
+struct hubp_disconnect_params {
+	struct hubp *hubp;
+};
+
+struct hubbub_force_pstate_change_control_params {
+	struct hubbub *hubbub;
+	bool enable;
+	bool wait;
+};
+
+struct tg_enable_crtc_params {
+	struct timing_generator *tg;
+};
+
+struct hubp_wait_flip_pending_params {
+	struct hubp *hubp;
+	unsigned int timeout_us;
+	unsigned int polling_interval_us;
+};
+
+struct tg_wait_double_buffer_pending_params {
+	struct timing_generator *tg;
+	unsigned int timeout_us;
+	unsigned int polling_interval_us;
+};
+
+struct update_force_pstate_params {
+	struct dc *dc;
+	struct dc_state *context;
+};
+
+struct hubbub_apply_dedcn21_147_wa_params {
+	struct hubbub *hubbub;
+};
+
+struct hubbub_allow_self_refresh_control_params {
+	struct hubbub *hubbub;
+	bool allow;
+	bool *disallow_self_refresh_applied;
+};
+
+struct tg_get_frame_count_params {
+	struct timing_generator *tg;
+	unsigned int *frame_count;
+};
+
+struct mpc_set_dwb_mux_params {
+	struct mpc *mpc;
+	int dwb_id;
+	int mpcc_id;
+};
+
+struct mpc_disable_dwb_mux_params {
+	struct mpc *mpc;
+	unsigned int dwb_id;
+};
+
+struct mcif_wb_config_buf_params {
+	struct mcif_wb *mcif_wb;
+	struct mcif_buf_params *mcif_buf_params;
+	unsigned int dest_height;
+};
+
+struct mcif_wb_config_arb_params {
+	struct mcif_wb *mcif_wb;
+	struct mcif_arb_params *mcif_arb_params;
+};
+
+struct mcif_wb_enable_params {
+	struct mcif_wb *mcif_wb;
+};
+
+struct mcif_wb_disable_params {
+	struct mcif_wb *mcif_wb;
+};
+
+struct dwbc_enable_params {
+	struct dwbc *dwb;
+	struct dc_dwb_params *dwb_params;
+};
+
+struct dwbc_disable_params {
+	struct dwbc *dwb;
+};
+
+struct dwbc_update_params {
+	struct dwbc *dwb;
+	struct dc_dwb_params *dwb_params;
+};
+
+struct hubp_update_mall_sel_params {
+	struct hubp *hubp;
+	uint32_t mall_sel;
+	bool cache_cursor;
+};
+
+struct hubp_prepare_subvp_buffering_params {
+	struct hubp *hubp;
+	bool enable;
+};
+
+struct hubp_set_blank_en_params {
+	struct hubp *hubp;
+	bool enable;
+};
+
+struct hubp_disable_control_params {
+	struct hubp *hubp;
+	bool disable;
+};
+
+struct hubbub_soft_reset_params {
+	struct hubbub *hubbub;
+	void (*hubbub_soft_reset)(struct hubbub *hubbub, bool reset);
+	bool reset;
+};
+
+struct hubp_clk_cntl_params {
+	struct hubp *hubp;
+	bool enable;
+};
+
+struct hubp_init_params {
+	struct hubp *hubp;
+};
+
+struct hubp_set_vm_system_aperture_settings_params {
+	struct hubp *hubp;
+	//struct vm_system_aperture_param apt;
+	PHYSICAL_ADDRESS_LOC sys_default;
+	PHYSICAL_ADDRESS_LOC sys_low;
+	PHYSICAL_ADDRESS_LOC sys_high;
+};
+
+struct hubp_set_flip_int_params {
+	struct hubp *hubp;
+};
+
+struct dpp_dppclk_control_params {
+	struct dpp *dpp;
+	bool dppclk_div;
+	bool enable;
+};
+
+struct disable_phantom_crtc_params {
+	struct timing_generator *tg;
+};
+
+struct dpp_pg_control_params {
+	struct dce_hwseq *hws;
+	unsigned int dpp_inst;
+	bool power_on;
+};
+
+struct hubp_pg_control_params {
+	struct dce_hwseq *hws;
+	unsigned int hubp_inst;
+	bool power_on;
+};
+
+struct hubp_reset_params {
+	struct hubp *hubp;
+};
+
+struct dpp_reset_params {
+	struct dpp *dpp;
+};
+
+struct dpp_root_clock_control_params {
+	struct dce_hwseq *hws;
+	unsigned int dpp_inst;
+	bool clock_on;
+};
+
+struct dc_ip_request_cntl_params {
+	struct dc *dc;
+	bool enable;
+};
+
+struct dsc_pg_status_params {
+	struct dce_hwseq *hws;
+	int dsc_inst;
+	bool is_ungated;
+};
+
+struct dsc_wait_disconnect_pending_clear_params {
+	struct display_stream_compressor *dsc;
+	bool *is_ungated;
+};
+
+struct dsc_disable_params {
+	struct display_stream_compressor *dsc;
+	bool *is_ungated;
+};
+
+struct dccg_set_ref_dscclk_params {
+	struct dccg *dccg;
+	int dsc_inst;
+	bool *is_ungated;
+};
+
+struct dccg_update_dpp_dto_params {
+	struct dccg *dccg;
+	int dpp_inst;
+	int dppclk_khz;
+};
+
+struct hubp_vtg_sel_params {
+	struct hubp *hubp;
+	uint32_t otg_inst;
+};
+
+struct hubp_setup2_params {
+	struct hubp *hubp;
+	struct dml2_dchub_per_pipe_register_set *hubp_regs;
+	union dml2_global_sync_programming *global_sync;
+	struct dc_crtc_timing *timing;
+};
+
+struct hubp_setup_params {
+	struct hubp *hubp;
+	struct _vcs_dpi_display_dlg_regs_st *dlg_regs;
+	struct _vcs_dpi_display_ttu_regs_st *ttu_regs;
+	struct _vcs_dpi_display_rq_regs_st *rq_regs;
+	struct _vcs_dpi_display_pipe_dest_params_st *pipe_dest;
+};
+
+struct hubp_set_unbounded_requesting_params {
+	struct hubp *hubp;
+	bool unbounded_req;
+};
+
+struct hubp_setup_interdependent2_params {
+	struct hubp *hubp;
+	struct dml2_dchub_per_pipe_register_set *hubp_regs;
+};
+
+struct hubp_setup_interdependent_params {
+	struct hubp *hubp;
+	struct _vcs_dpi_display_dlg_regs_st *dlg_regs;
+	struct _vcs_dpi_display_ttu_regs_st *ttu_regs;
+};
+
+struct dpp_set_cursor_matrix_params {
+	struct dpp *dpp;
+	enum dc_color_space color_space;
+	struct dc_csc_transform *cursor_csc_color_matrix;
+};
+
+struct mpc_update_mpcc_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct dpp_set_scaler_params {
+	struct dpp *dpp;
+	const struct scaler_data *scl_data;
+};
+
+struct hubp_mem_program_viewport_params {
+	struct hubp *hubp;
+	const struct rect *viewport;
+	const struct rect *viewport_c;
+};
+
+struct hubp_program_mcache_id_and_split_coordinate_params {
+	struct hubp *hubp;
+	struct mcache_regs_struct *mcache_regs;
+};
+
+struct set_cursor_attribute_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct set_cursor_position_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct set_cursor_sdr_white_level_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct program_output_csc_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+	enum dc_color_space colorspace;
+	uint16_t *matrix;
+	int opp_id;
+};
+
+struct hubp_set_blank_params {
+	struct hubp *hubp;
+	bool blank;
+};
+
+struct phantom_hubp_post_enable_params {
+	struct hubp *hubp;
+};
+
 union block_sequence_params {
 	struct update_plane_addr_params update_plane_addr_params;
 	struct subvp_pipe_control_lock_fast_params subvp_pipe_control_lock_fast_params;
@@ -179,7 +748,106 @@ union block_sequence_params {
 	struct subvp_save_surf_addr subvp_save_surf_addr;
 	struct wait_for_dcc_meta_propagation_params wait_for_dcc_meta_propagation_params;
 	struct dmub_hw_control_lock_fast_params dmub_hw_control_lock_fast_params;
+	struct program_surface_config_params program_surface_config_params;
+	struct program_mcache_id_and_split_coordinate program_mcache_id_and_split_coordinate;
 	struct program_cursor_update_now_params program_cursor_update_now_params;
+	struct hubp_wait_pipe_read_start_params hubp_wait_pipe_read_start_params;
+	struct apply_update_flags_for_phantom_params apply_update_flags_for_phantom_params;
+	struct update_phantom_vp_position_params update_phantom_vp_position_params;
+	struct set_odm_combine_params set_odm_combine_params;
+	struct set_odm_bypass_params set_odm_bypass_params;
+	struct opp_pipe_clock_control_params opp_pipe_clock_control_params;
+	struct opp_program_left_edge_extra_pixel_params opp_program_left_edge_extra_pixel_params;
+	struct dccg_set_dto_dscclk_params dccg_set_dto_dscclk_params;
+	struct dsc_set_config_params dsc_set_config_params;
+	struct dsc_enable_params dsc_enable_params;
+	struct tg_set_dsc_config_params tg_set_dsc_config_params;
+	struct dsc_disconnect_params dsc_disconnect_params;
+	struct dsc_read_state_params dsc_read_state_params;
+	struct dsc_calculate_and_set_config_params dsc_calculate_and_set_config_params;
+	struct dsc_enable_with_opp_params dsc_enable_with_opp_params;
+	struct program_tg_params program_tg_params;
+	struct tg_program_global_sync_params tg_program_global_sync_params;
+	struct tg_wait_for_state_params tg_wait_for_state_params;
+	struct tg_set_vtg_params_params tg_set_vtg_params_params;
+	struct tg_setup_vertical_interrupt2_params tg_setup_vertical_interrupt2_params;
+	struct dpp_set_hdr_multiplier_params dpp_set_hdr_multiplier_params;
+	struct tg_set_gsl_params tg_set_gsl_params;
+	struct tg_set_gsl_source_select_params tg_set_gsl_source_select_params;
+	struct setup_vupdate_interrupt_params setup_vupdate_interrupt_params;
+	struct program_det_size_params program_det_size_params;
+	struct program_det_segments_params program_det_segments_params;
+	struct update_dchubp_dpp_params update_dchubp_dpp_params;
+	struct opp_set_dyn_expansion_params opp_set_dyn_expansion_params;
+	struct opp_program_fmt_params opp_program_fmt_params;
+	struct opp_program_bit_depth_reduction_params opp_program_bit_depth_reduction_params;
+	struct opp_set_disp_pattern_generator_params opp_set_disp_pattern_generator_params;
+	struct set_abm_pipe_params set_abm_pipe_params;
+	struct set_abm_level_params set_abm_level_params;
+	struct set_abm_immediate_disable_params set_abm_immediate_disable_params;
+	struct set_disp_pattern_generator_params set_disp_pattern_generator_params;
+	struct mpc_remove_mpcc_params mpc_remove_mpcc_params;
+	struct opp_set_mpcc_disconnect_pending_params opp_set_mpcc_disconnect_pending_params;
+	struct dc_set_optimized_required_params dc_set_optimized_required_params;
+	struct hubp_disconnect_params hubp_disconnect_params;
+	struct hubbub_force_pstate_change_control_params hubbub_force_pstate_change_control_params;
+	struct tg_enable_crtc_params tg_enable_crtc_params;
+	struct hubp_wait_flip_pending_params hubp_wait_flip_pending_params;
+	struct tg_wait_double_buffer_pending_params tg_wait_double_buffer_pending_params;
+	struct update_force_pstate_params update_force_pstate_params;
+	struct hubbub_apply_dedcn21_147_wa_params hubbub_apply_dedcn21_147_wa_params;
+	struct hubbub_allow_self_refresh_control_params hubbub_allow_self_refresh_control_params;
+	struct tg_get_frame_count_params tg_get_frame_count_params;
+	struct mpc_set_dwb_mux_params mpc_set_dwb_mux_params;
+	struct mpc_disable_dwb_mux_params mpc_disable_dwb_mux_params;
+	struct mcif_wb_config_buf_params mcif_wb_config_buf_params;
+	struct mcif_wb_config_arb_params mcif_wb_config_arb_params;
+	struct mcif_wb_enable_params mcif_wb_enable_params;
+	struct mcif_wb_disable_params mcif_wb_disable_params;
+	struct dwbc_enable_params dwbc_enable_params;
+	struct dwbc_disable_params dwbc_disable_params;
+	struct dwbc_update_params dwbc_update_params;
+	struct hubp_update_mall_sel_params hubp_update_mall_sel_params;
+	struct hubp_prepare_subvp_buffering_params hubp_prepare_subvp_buffering_params;
+	struct hubp_set_blank_en_params hubp_set_blank_en_params;
+	struct hubp_disable_control_params hubp_disable_control_params;
+	struct hubbub_soft_reset_params hubbub_soft_reset_params;
+	struct hubp_clk_cntl_params hubp_clk_cntl_params;
+	struct hubp_init_params hubp_init_params;
+	struct hubp_set_vm_system_aperture_settings_params hubp_set_vm_system_aperture_settings_params;
+	struct hubp_set_flip_int_params hubp_set_flip_int_params;
+	struct dpp_dppclk_control_params dpp_dppclk_control_params;
+	struct disable_phantom_crtc_params disable_phantom_crtc_params;
+	struct dpp_pg_control_params dpp_pg_control_params;
+	struct hubp_pg_control_params hubp_pg_control_params;
+	struct hubp_reset_params hubp_reset_params;
+	struct dpp_reset_params dpp_reset_params;
+	struct dpp_root_clock_control_params dpp_root_clock_control_params;
+	struct dc_ip_request_cntl_params dc_ip_request_cntl_params;
+	struct dsc_pg_status_params dsc_pg_status_params;
+	struct dsc_wait_disconnect_pending_clear_params dsc_wait_disconnect_pending_clear_params;
+	struct dsc_disable_params dsc_disable_params;
+	struct dccg_set_ref_dscclk_params dccg_set_ref_dscclk_params;
+	struct dccg_update_dpp_dto_params dccg_update_dpp_dto_params;
+	struct hubp_vtg_sel_params hubp_vtg_sel_params;
+	struct hubp_setup2_params hubp_setup2_params;
+	struct hubp_setup_params hubp_setup_params;
+	struct hubp_set_unbounded_requesting_params hubp_set_unbounded_requesting_params;
+	struct hubp_setup_interdependent2_params hubp_setup_interdependent2_params;
+	struct hubp_setup_interdependent_params hubp_setup_interdependent_params;
+	struct dpp_set_cursor_matrix_params dpp_set_cursor_matrix_params;
+	struct mpc_update_mpcc_params mpc_update_mpcc_params;
+	struct mpc_update_blending_params mpc_update_blending_params;
+	struct mpc_assert_idle_mpcc_params mpc_assert_idle_mpcc_params;
+	struct mpc_insert_plane_params mpc_insert_plane_params;
+	struct dpp_set_scaler_params dpp_set_scaler_params;
+	struct hubp_mem_program_viewport_params hubp_mem_program_viewport_params;
+	struct set_cursor_attribute_params set_cursor_attribute_params;
+	struct set_cursor_position_params set_cursor_position_params;
+	struct set_cursor_sdr_white_level_params set_cursor_sdr_white_level_params;
+	struct program_output_csc_params program_output_csc_params;
+	struct hubp_set_blank_params hubp_set_blank_params;
+	struct phantom_hubp_post_enable_params phantom_hubp_post_enable_params;
 };
 
 enum block_sequence_func {
@@ -195,6 +863,7 @@ enum block_sequence_func {
 	DPP_SETUP_DPP,
 	DPP_PROGRAM_BIAS_AND_SCALE,
 	DPP_SET_OUTPUT_TRANSFER_FUNC,
+	DPP_SET_HDR_MULTIPLIER,
 	MPC_UPDATE_VISUAL_CONFIRM,
 	MPC_POWER_ON_MPC_MEM_PWR,
 	MPC_SET_OUTPUT_CSC,
@@ -202,7 +871,102 @@ enum block_sequence_func {
 	DMUB_SUBVP_SAVE_SURF_ADDR,
 	HUBP_WAIT_FOR_DCC_META_PROP,
 	DMUB_HW_CONTROL_LOCK_FAST,
+	HUBP_PROGRAM_SURFACE_CONFIG,
+	HUBP_PROGRAM_MCACHE_ID,
 	PROGRAM_CURSOR_UPDATE_NOW,
+	HUBP_WAIT_PIPE_READ_START,
+	HWS_APPLY_UPDATE_FLAGS_FOR_PHANTOM,
+	HWS_UPDATE_PHANTOM_VP_POSITION,
+	OPTC_SET_ODM_COMBINE,
+	OPTC_SET_ODM_BYPASS,
+	OPP_PIPE_CLOCK_CONTROL,
+	OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL,
+	DCCG_SET_DTO_DSCCLK,
+	DSC_SET_CONFIG,
+	DSC_ENABLE,
+	TG_SET_DSC_CONFIG,
+	DSC_DISCONNECT,
+	DSC_READ_STATE,
+	DSC_CALCULATE_AND_SET_CONFIG,
+	DSC_ENABLE_WITH_OPP,
+	TG_PROGRAM_GLOBAL_SYNC,
+	TG_WAIT_FOR_STATE,
+	TG_SET_VTG_PARAMS,
+	TG_SETUP_VERTICAL_INTERRUPT2,
+	HUBP_PROGRAM_DET_SIZE,
+	HUBP_PROGRAM_DET_SEGMENTS,
+	OPP_SET_DYN_EXPANSION,
+	OPP_PROGRAM_FMT,
+	OPP_PROGRAM_BIT_DEPTH_REDUCTION,
+	OPP_SET_DISP_PATTERN_GENERATOR,
+	ABM_SET_PIPE,
+	ABM_SET_LEVEL,
+	ABM_SET_IMMEDIATE_DISABLE,
+	MPC_REMOVE_MPCC,
+	OPP_SET_MPCC_DISCONNECT_PENDING,
+	DC_SET_OPTIMIZED_REQUIRED,
+	HUBP_DISCONNECT,
+	HUBBUB_FORCE_PSTATE_CHANGE_CONTROL,
+	TG_ENABLE_CRTC,
+	TG_SET_GSL,
+	TG_SET_GSL_SOURCE_SELECT,
+	HUBP_WAIT_FLIP_PENDING,
+	TG_WAIT_DOUBLE_BUFFER_PENDING,
+	UPDATE_FORCE_PSTATE,
+	PROGRAM_MALL_PIPE_CONFIG,
+	HUBBUB_APPLY_DEDCN21_147_WA,
+	HUBBUB_ALLOW_SELF_REFRESH_CONTROL,
+	TG_GET_FRAME_COUNT,
+	MPC_SET_DWB_MUX,
+	MPC_DISABLE_DWB_MUX,
+	MCIF_WB_CONFIG_BUF,
+	MCIF_WB_CONFIG_ARB,
+	MCIF_WB_ENABLE,
+	MCIF_WB_DISABLE,
+	DWBC_ENABLE,
+	DWBC_DISABLE,
+	DWBC_UPDATE,
+	HUBP_UPDATE_MALL_SEL,
+	HUBP_PREPARE_SUBVP_BUFFERING,
+	HUBP_SET_BLANK_EN,
+	HUBP_DISABLE_CONTROL,
+	HUBBUB_SOFT_RESET,
+	HUBP_CLK_CNTL,
+	HUBP_INIT,
+	HUBP_SET_VM_SYSTEM_APERTURE_SETTINGS,
+	HUBP_SET_FLIP_INT,
+	DPP_DPPCLK_CONTROL,
+	DISABLE_PHANTOM_CRTC,
+	DSC_PG_STATUS,
+	DSC_WAIT_DISCONNECT_PENDING_CLEAR,
+	DSC_DISABLE,
+	DCCG_SET_REF_DSCCLK,
+	DPP_PG_CONTROL,
+	HUBP_PG_CONTROL,
+	HUBP_RESET,
+	DPP_RESET,
+	DPP_ROOT_CLOCK_CONTROL,
+	DC_IP_REQUEST_CNTL,
+	DCCG_UPDATE_DPP_DTO,
+	HUBP_VTG_SEL,
+	HUBP_SETUP2,
+	HUBP_SETUP,
+	HUBP_SET_UNBOUNDED_REQUESTING,
+	HUBP_SETUP_INTERDEPENDENT2,
+	HUBP_SETUP_INTERDEPENDENT,
+	DPP_SET_CURSOR_MATRIX,
+	MPC_UPDATE_BLENDING,
+	MPC_ASSERT_IDLE_MPCC,
+	MPC_INSERT_PLANE,
+	DPP_SET_SCALER,
+	HUBP_MEM_PROGRAM_VIEWPORT,
+	SET_CURSOR_ATTRIBUTE,
+	SET_CURSOR_POSITION,
+	SET_CURSOR_SDR_WHITE_LEVEL,
+	PROGRAM_OUTPUT_CSC,
+	HUBP_SET_LEGACY_TILING_COMPAT_LEVEL,
+	HUBP_SET_BLANK,
+	PHANTOM_HUBP_POST_ENABLE,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
@@ -212,6 +976,11 @@ struct block_sequence {
 	enum block_sequence_func func;
 };
 
+struct block_sequence_state {
+	struct block_sequence *steps;
+	unsigned int *num_steps;
+};
+
 #define MAX_HWSS_BLOCK_SEQUENCE_SIZE (HWSS_BLOCK_SEQUENCE_FUNC_COUNT * MAX_PIPES)
 
 struct hw_sequencer_funcs {
@@ -229,6 +998,8 @@ struct hw_sequencer_funcs {
 	enum dc_status (*apply_ctx_to_hw)(struct dc *dc,
 			struct dc_state *context);
 	void (*disable_plane)(struct dc *dc, struct dc_state *state, struct pipe_ctx *pipe_ctx);
+	void (*disable_plane_sequence)(struct dc *dc, struct dc_state *state, struct pipe_ctx *pipe_ctx,
+		struct block_sequence_state *seq_state);
 	void (*disable_pixel_data)(struct dc *dc, struct pipe_ctx *pipe_ctx, bool blank);
 	void (*apply_ctx_for_surface)(struct dc *dc,
 			const struct dc_stream_state *stream,
@@ -246,6 +1017,10 @@ struct hw_sequencer_funcs {
 	void (*wait_for_mpcc_disconnect)(struct dc *dc,
 			struct resource_pool *res_pool,
 			struct pipe_ctx *pipe_ctx);
+	void (*wait_for_mpcc_disconnect_sequence)(struct dc *dc,
+			struct resource_pool *res_pool,
+			struct pipe_ctx *pipe_ctx,
+			struct block_sequence_state *seq_state);
 	void (*edp_backlight_control)(
 			struct dc_link *link,
 			bool enable);
@@ -485,11 +1260,23 @@ struct hw_sequencer_funcs {
 	void (*enable_plane)(struct dc *dc,
 			struct pipe_ctx *pipe_ctx,
 			struct dc_state *context);
+	void (*enable_plane_sequence)(struct dc *dc,
+			struct pipe_ctx *pipe_ctx,
+			struct dc_state *context,
+			struct block_sequence_state *seq_state);
 	void (*update_dchubp_dpp)(struct dc *dc,
 			struct pipe_ctx *pipe_ctx,
 			struct dc_state *context);
+	void (*update_dchubp_dpp_sequence)(struct dc *dc,
+			struct pipe_ctx *pipe_ctx,
+			struct dc_state *context,
+			struct block_sequence_state *seq_state);
 	void (*post_unlock_reset_opp)(struct dc *dc,
 			struct pipe_ctx *opp_head);
+	void (*post_unlock_reset_opp_sequence)(
+			struct dc *dc,
+			struct pipe_ctx *opp_head,
+			struct block_sequence_state *seq_state);
 	void (*get_underflow_debug_data)(const struct dc *dc,
 			struct timing_generator *tg,
 			struct dc_underflow_debug_data *out_data);
@@ -602,4 +1389,624 @@ void hwss_set_ocsc_default(union block_sequence_params *params);
 
 void hwss_subvp_save_surf_addr(union block_sequence_params *params);
 
+void hwss_program_surface_config(union block_sequence_params *params);
+
+void hwss_program_mcache_id_and_split_coordinate(union block_sequence_params *params);
+
+void hwss_set_odm_combine(union block_sequence_params *params);
+
+void hwss_set_odm_bypass(union block_sequence_params *params);
+
+void hwss_opp_pipe_clock_control(union block_sequence_params *params);
+
+void hwss_opp_program_left_edge_extra_pixel(union block_sequence_params *params);
+
+void hwss_blank_pixel_data(union block_sequence_params *params);
+
+void hwss_dccg_set_dto_dscclk(union block_sequence_params *params);
+
+void hwss_dsc_set_config(union block_sequence_params *params);
+
+void hwss_dsc_enable(union block_sequence_params *params);
+
+void hwss_tg_set_dsc_config(union block_sequence_params *params);
+
+void hwss_dsc_disconnect(union block_sequence_params *params);
+
+void hwss_dsc_read_state(union block_sequence_params *params);
+
+void hwss_dsc_calculate_and_set_config(union block_sequence_params *params);
+
+void hwss_dsc_enable_with_opp(union block_sequence_params *params);
+
+void hwss_program_tg(union block_sequence_params *params);
+
+void hwss_tg_program_global_sync(union block_sequence_params *params);
+
+void hwss_tg_wait_for_state(union block_sequence_params *params);
+
+void hwss_tg_set_vtg_params(union block_sequence_params *params);
+
+void hwss_tg_setup_vertical_interrupt2(union block_sequence_params *params);
+
+void hwss_dpp_set_hdr_multiplier(union block_sequence_params *params);
+
+void hwss_program_det_size(union block_sequence_params *params);
+
+void hwss_program_det_segments(union block_sequence_params *params);
+
+void hwss_opp_set_dyn_expansion(union block_sequence_params *params);
+
+void hwss_opp_program_fmt(union block_sequence_params *params);
+
+void hwss_opp_program_bit_depth_reduction(union block_sequence_params *params);
+
+void hwss_opp_set_disp_pattern_generator(union block_sequence_params *params);
+
+void hwss_set_abm_pipe(union block_sequence_params *params);
+
+void hwss_set_abm_level(union block_sequence_params *params);
+
+void hwss_set_abm_immediate_disable(union block_sequence_params *params);
+
+void hwss_mpc_remove_mpcc(union block_sequence_params *params);
+
+void hwss_opp_set_mpcc_disconnect_pending(union block_sequence_params *params);
+
+void hwss_dc_set_optimized_required(union block_sequence_params *params);
+
+void hwss_hubp_disconnect(union block_sequence_params *params);
+
+void hwss_hubbub_force_pstate_change_control(union block_sequence_params *params);
+
+void hwss_tg_enable_crtc(union block_sequence_params *params);
+
+void hwss_tg_set_gsl(union block_sequence_params *params);
+
+void hwss_tg_set_gsl_source_select(union block_sequence_params *params);
+
+void hwss_hubp_wait_flip_pending(union block_sequence_params *params);
+
+void hwss_tg_wait_double_buffer_pending(union block_sequence_params *params);
+
+void hwss_update_force_pstate(union block_sequence_params *params);
+
+void hwss_hubbub_apply_dedcn21_147_wa(union block_sequence_params *params);
+
+void hwss_hubbub_allow_self_refresh_control(union block_sequence_params *params);
+
+void hwss_tg_get_frame_count(union block_sequence_params *params);
+
+void hwss_mpc_set_dwb_mux(union block_sequence_params *params);
+
+void hwss_mpc_disable_dwb_mux(union block_sequence_params *params);
+
+void hwss_mcif_wb_config_buf(union block_sequence_params *params);
+
+void hwss_mcif_wb_config_arb(union block_sequence_params *params);
+
+void hwss_mcif_wb_enable(union block_sequence_params *params);
+
+void hwss_mcif_wb_disable(union block_sequence_params *params);
+
+void hwss_dwbc_enable(union block_sequence_params *params);
+
+void hwss_dwbc_disable(union block_sequence_params *params);
+
+void hwss_dwbc_update(union block_sequence_params *params);
+
+void hwss_hubp_update_mall_sel(union block_sequence_params *params);
+
+void hwss_hubp_prepare_subvp_buffering(union block_sequence_params *params);
+
+void hwss_hubp_set_blank_en(union block_sequence_params *params);
+
+void hwss_hubp_disable_control(union block_sequence_params *params);
+
+void hwss_hubbub_soft_reset(union block_sequence_params *params);
+
+void hwss_hubp_clk_cntl(union block_sequence_params *params);
+
+void hwss_hubp_init(union block_sequence_params *params);
+
+void hwss_hubp_set_vm_system_aperture_settings(union block_sequence_params *params);
+
+void hwss_hubp_set_flip_int(union block_sequence_params *params);
+
+void hwss_dpp_dppclk_control(union block_sequence_params *params);
+
+void hwss_disable_phantom_crtc(union block_sequence_params *params);
+
+void hwss_dsc_pg_status(union block_sequence_params *params);
+
+void hwss_dsc_wait_disconnect_pending_clear(union block_sequence_params *params);
+
+void hwss_dsc_disable(union block_sequence_params *params);
+
+void hwss_dccg_set_ref_dscclk(union block_sequence_params *params);
+
+void hwss_dpp_pg_control(union block_sequence_params *params);
+
+void hwss_hubp_pg_control(union block_sequence_params *params);
+
+void hwss_hubp_reset(union block_sequence_params *params);
+
+void hwss_dpp_reset(union block_sequence_params *params);
+
+void hwss_dpp_root_clock_control(union block_sequence_params *params);
+
+void hwss_dc_ip_request_cntl(union block_sequence_params *params);
+
+void hwss_dccg_update_dpp_dto(union block_sequence_params *params);
+
+void hwss_hubp_vtg_sel(union block_sequence_params *params);
+
+void hwss_hubp_setup2(union block_sequence_params *params);
+
+void hwss_hubp_setup(union block_sequence_params *params);
+
+void hwss_hubp_set_unbounded_requesting(union block_sequence_params *params);
+
+void hwss_hubp_setup_interdependent2(union block_sequence_params *params);
+
+void hwss_hubp_setup_interdependent(union block_sequence_params *params);
+
+void hwss_dpp_set_cursor_matrix(union block_sequence_params *params);
+
+void hwss_mpc_update_mpcc(union block_sequence_params *params);
+
+void hwss_mpc_update_blending(union block_sequence_params *params);
+
+void hwss_mpc_assert_idle_mpcc(union block_sequence_params *params);
+
+void hwss_mpc_insert_plane(union block_sequence_params *params);
+
+void hwss_dpp_set_scaler(union block_sequence_params *params);
+
+void hwss_hubp_mem_program_viewport(union block_sequence_params *params);
+
+void hwss_set_cursor_attribute(union block_sequence_params *params);
+
+void hwss_set_cursor_position(union block_sequence_params *params);
+
+void hwss_set_cursor_sdr_white_level(union block_sequence_params *params);
+
+void hwss_program_output_csc(union block_sequence_params *params);
+
+void hwss_hubp_set_legacy_tiling_compat_level(union block_sequence_params *params);
+
+void hwss_hubp_set_blank(union block_sequence_params *params);
+
+void hwss_phantom_hubp_post_enable(union block_sequence_params *params);
+
+void hwss_add_optc_pipe_control_lock(struct block_sequence_state *seq_state,
+		struct dc *dc, struct pipe_ctx *pipe_ctx, bool lock);
+
+void hwss_add_hubp_set_flip_control_gsl(struct block_sequence_state *seq_state,
+		struct hubp *hubp, bool flip_immediate);
+
+void hwss_add_hubp_program_triplebuffer(struct block_sequence_state *seq_state,
+		struct dc *dc, struct pipe_ctx *pipe_ctx, bool enableTripleBuffer);
+
+void hwss_add_hubp_update_plane_addr(struct block_sequence_state *seq_state,
+		struct dc *dc, struct pipe_ctx *pipe_ctx);
+
+void hwss_add_dpp_set_input_transfer_func(struct block_sequence_state *seq_state,
+		struct dc *dc, struct pipe_ctx *pipe_ctx, struct dc_plane_state *plane_state);
+
+void hwss_add_dpp_program_gamut_remap(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_dpp_program_bias_and_scale(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_optc_program_manual_trigger(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_dpp_set_output_transfer_func(struct block_sequence_state *seq_state,
+		struct dc *dc, struct pipe_ctx *pipe_ctx, struct dc_stream_state *stream);
+
+void hwss_add_mpc_update_visual_confirm(struct block_sequence_state *seq_state,
+		struct dc *dc, struct pipe_ctx *pipe_ctx, int mpcc_id);
+
+void hwss_add_mpc_power_on_mpc_mem_pwr(struct block_sequence_state *seq_state,
+		struct mpc *mpc, int mpcc_id, bool power_on);
+
+void hwss_add_mpc_set_output_csc(struct block_sequence_state *seq_state,
+		struct mpc *mpc, int opp_id, const uint16_t *regval, enum mpc_output_csc_mode ocsc_mode);
+
+void hwss_add_mpc_set_ocsc_default(struct block_sequence_state *seq_state,
+		struct mpc *mpc, int opp_id, enum dc_color_space colorspace, enum mpc_output_csc_mode ocsc_mode);
+
+void hwss_add_dmub_send_dmcub_cmd(struct block_sequence_state *seq_state,
+		struct dc_context *ctx, union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type);
+
+void hwss_add_dmub_subvp_save_surf_addr(struct block_sequence_state *seq_state,
+		struct dc_dmub_srv *dc_dmub_srv, struct dc_plane_address *addr, uint8_t subvp_index);
+
+void hwss_add_hubp_wait_for_dcc_meta_prop(struct block_sequence_state *seq_state,
+		struct dc *dc, struct pipe_ctx *top_pipe_to_program);
+
+void hwss_add_hubp_wait_pipe_read_start(struct block_sequence_state *seq_state,
+		struct hubp *hubp);
+
+void hwss_add_hws_apply_update_flags_for_phantom(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_hws_update_phantom_vp_position(struct block_sequence_state *seq_state,
+		struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx);
+
+void hwss_add_optc_set_odm_combine(struct block_sequence_state *seq_state,
+		struct timing_generator *tg, int opp_inst[MAX_PIPES], int opp_head_count,
+		int odm_slice_width, int last_odm_slice_width);
+
+void hwss_add_optc_set_odm_bypass(struct block_sequence_state *seq_state,
+		struct timing_generator *optc, struct dc_crtc_timing *timing);
+
+void hwss_add_tg_program_global_sync(struct block_sequence_state *seq_state,
+		struct timing_generator *tg,
+		int vready_offset,
+		unsigned int vstartup_lines,
+		unsigned int vupdate_offset_pixels,
+		unsigned int vupdate_vupdate_width_pixels,
+		unsigned int pstate_keepout_start_lines);
+
+void hwss_add_tg_wait_for_state(struct block_sequence_state *seq_state,
+		struct timing_generator *tg, enum crtc_state state);
+
+void hwss_add_tg_set_vtg_params(struct block_sequence_state *seq_state,
+		struct timing_generator *tg, struct dc_crtc_timing *dc_crtc_timing, bool program_fp2);
+
+void hwss_add_tg_setup_vertical_interrupt2(struct block_sequence_state *seq_state,
+		struct timing_generator *tg, int start_line);
+
+void hwss_add_dpp_set_hdr_multiplier(struct block_sequence_state *seq_state,
+		struct dpp *dpp, uint32_t hw_mult);
+
+void hwss_add_hubp_program_det_size(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, unsigned int hubp_inst, unsigned int det_buffer_size_kb);
+
+void hwss_add_hubp_program_mcache_id(struct block_sequence_state *seq_state,
+		struct hubp *hubp, struct dml2_hubp_pipe_mcache_regs *mcache_regs);
+
+void hwss_add_hubbub_force_pstate_change_control(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, bool enable, bool wait);
+
+void hwss_add_hubp_program_det_segments(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, unsigned int hubp_inst, unsigned int det_size);
+
+void hwss_add_opp_set_dyn_expansion(struct block_sequence_state *seq_state,
+		struct output_pixel_processor *opp, enum dc_color_space color_sp,
+		enum dc_color_depth color_dpth, enum signal_type signal);
+
+void hwss_add_opp_program_fmt(struct block_sequence_state *seq_state,
+		struct output_pixel_processor *opp, struct bit_depth_reduction_params *fmt_bit_depth,
+		struct clamping_and_pixel_encoding_params *clamping);
+
+void hwss_add_abm_set_pipe(struct block_sequence_state *seq_state,
+		struct dc *dc, struct pipe_ctx *pipe_ctx);
+
+void hwss_add_abm_set_level(struct block_sequence_state *seq_state,
+		struct abm *abm, uint32_t abm_level);
+
+void hwss_add_tg_enable_crtc(struct block_sequence_state *seq_state,
+		struct timing_generator *tg);
+
+void hwss_add_hubp_wait_flip_pending(struct block_sequence_state *seq_state,
+		struct hubp *hubp, unsigned int timeout_us, unsigned int polling_interval_us);
+
+void hwss_add_tg_wait_double_buffer_pending(struct block_sequence_state *seq_state,
+		struct timing_generator *tg, unsigned int timeout_us, unsigned int polling_interval_us);
+
+void hwss_add_dccg_set_dto_dscclk(struct block_sequence_state *seq_state,
+		struct dccg *dccg, int inst, int num_slices_h);
+
+void hwss_add_dsc_calculate_and_set_config(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx, bool enable, int opp_cnt);
+
+void hwss_add_mpc_remove_mpcc(struct block_sequence_state *seq_state,
+		struct mpc *mpc, struct mpc_tree *mpc_tree_params, struct mpcc *mpcc_to_remove);
+
+void hwss_add_opp_set_mpcc_disconnect_pending(struct block_sequence_state *seq_state,
+		struct output_pixel_processor *opp, int mpcc_inst, bool pending);
+
+void hwss_add_hubp_disconnect(struct block_sequence_state *seq_state,
+		struct hubp *hubp);
+
+void hwss_add_dsc_enable_with_opp(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_dsc_disconnect(struct block_sequence_state *seq_state,
+		struct display_stream_compressor *dsc);
+
+void hwss_add_dc_set_optimized_required(struct block_sequence_state *seq_state,
+		struct dc *dc, bool optimized_required);
+
+void hwss_add_abm_set_immediate_disable(struct block_sequence_state *seq_state,
+		struct dc *dc, struct pipe_ctx *pipe_ctx);
+
+void hwss_add_opp_set_disp_pattern_generator(struct block_sequence_state *seq_state,
+		struct output_pixel_processor *opp,
+		enum controller_dp_test_pattern test_pattern,
+		enum controller_dp_color_space color_space,
+		enum dc_color_depth color_depth,
+		struct tg_color solid_color,
+		bool use_solid_color,
+		int width,
+		int height,
+		int offset);
+
+void hwss_add_opp_program_bit_depth_reduction(struct block_sequence_state *seq_state,
+		struct output_pixel_processor *opp,
+		bool use_default_params,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_dc_ip_request_cntl(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		bool enable);
+
+void hwss_add_dwbc_update(struct block_sequence_state *seq_state,
+		struct dwbc *dwb,
+		struct dc_dwb_params *dwb_params);
+
+void hwss_add_mcif_wb_config_buf(struct block_sequence_state *seq_state,
+		struct mcif_wb *mcif_wb,
+		struct mcif_buf_params *mcif_buf_params,
+		unsigned int dest_height);
+
+void hwss_add_mcif_wb_config_arb(struct block_sequence_state *seq_state,
+		struct mcif_wb *mcif_wb,
+		struct mcif_arb_params *mcif_arb_params);
+
+void hwss_add_mcif_wb_enable(struct block_sequence_state *seq_state,
+		struct mcif_wb *mcif_wb);
+
+void hwss_add_mcif_wb_disable(struct block_sequence_state *seq_state,
+		struct mcif_wb *mcif_wb);
+
+void hwss_add_mpc_set_dwb_mux(struct block_sequence_state *seq_state,
+		struct mpc *mpc,
+		int dwb_id,
+		int mpcc_id);
+
+void hwss_add_mpc_disable_dwb_mux(struct block_sequence_state *seq_state,
+		struct mpc *mpc,
+		unsigned int dwb_id);
+
+void hwss_add_dwbc_enable(struct block_sequence_state *seq_state,
+		struct dwbc *dwb,
+		struct dc_dwb_params *dwb_params);
+
+void hwss_add_dwbc_disable(struct block_sequence_state *seq_state,
+		struct dwbc *dwb);
+
+void hwss_add_tg_set_gsl(struct block_sequence_state *seq_state,
+		struct timing_generator *tg,
+		struct gsl_params gsl);
+
+void hwss_add_tg_set_gsl_source_select(struct block_sequence_state *seq_state,
+		struct timing_generator *tg,
+		int group_idx,
+		uint32_t gsl_ready_signal);
+
+void hwss_add_hubp_update_mall_sel(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		uint32_t mall_sel,
+		bool cache_cursor);
+
+void hwss_add_hubp_prepare_subvp_buffering(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		bool enable);
+
+void hwss_add_hubp_set_blank_en(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		bool enable);
+
+void hwss_add_hubp_disable_control(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		bool disable);
+
+void hwss_add_hubbub_soft_reset(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub,
+		void (*hubbub_soft_reset)(struct hubbub *hubbub, bool reset),
+		bool reset);
+
+void hwss_add_hubp_clk_cntl(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		bool enable);
+
+void hwss_add_dpp_dppclk_control(struct block_sequence_state *seq_state,
+		struct dpp *dpp,
+		bool dppclk_div,
+		bool enable);
+
+void hwss_add_disable_phantom_crtc(struct block_sequence_state *seq_state,
+		struct timing_generator *tg);
+
+void hwss_add_dsc_pg_status(struct block_sequence_state *seq_state,
+		struct dce_hwseq *hws,
+		int dsc_inst,
+		bool is_ungated);
+
+void hwss_add_dsc_wait_disconnect_pending_clear(struct block_sequence_state *seq_state,
+		struct display_stream_compressor *dsc,
+		bool *is_ungated);
+
+void hwss_add_dsc_disable(struct block_sequence_state *seq_state,
+		struct display_stream_compressor *dsc,
+		bool *is_ungated);
+
+void hwss_add_dccg_set_ref_dscclk(struct block_sequence_state *seq_state,
+		struct dccg *dccg,
+		int dsc_inst,
+		bool *is_ungated);
+
+void hwss_add_dpp_root_clock_control(struct block_sequence_state *seq_state,
+		struct dce_hwseq *hws,
+		unsigned int dpp_inst,
+		bool clock_on);
+
+void hwss_add_dpp_pg_control(struct block_sequence_state *seq_state,
+		struct dce_hwseq *hws,
+		unsigned int dpp_inst,
+		bool power_on);
+
+void hwss_add_hubp_pg_control(struct block_sequence_state *seq_state,
+		struct dce_hwseq *hws,
+		unsigned int hubp_inst,
+		bool power_on);
+
+void hwss_add_hubp_set_blank(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		bool blank);
+
+void hwss_add_hubp_init(struct block_sequence_state *seq_state,
+		struct hubp *hubp);
+
+void hwss_add_hubp_reset(struct block_sequence_state *seq_state,
+		struct hubp *hubp);
+
+void hwss_add_dpp_reset(struct block_sequence_state *seq_state,
+		struct dpp *dpp);
+
+void hwss_add_opp_pipe_clock_control(struct block_sequence_state *seq_state,
+		struct output_pixel_processor *opp,
+		bool enable);
+
+void hwss_add_hubp_set_vm_system_aperture_settings(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		uint64_t sys_default,
+		uint64_t sys_low,
+		uint64_t sys_high);
+
+void hwss_add_hubp_set_flip_int(struct block_sequence_state *seq_state,
+		struct hubp *hubp);
+
+void hwss_add_dccg_update_dpp_dto(struct block_sequence_state *seq_state,
+		struct dccg *dccg,
+		int dpp_inst,
+		int dppclk_khz);
+
+void hwss_add_hubp_vtg_sel(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		uint32_t otg_inst);
+
+void hwss_add_hubp_setup2(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		struct dml2_dchub_per_pipe_register_set *hubp_regs,
+		union dml2_global_sync_programming *global_sync,
+		struct dc_crtc_timing *timing);
+
+void hwss_add_hubp_setup(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		struct _vcs_dpi_display_dlg_regs_st *dlg_regs,
+		struct _vcs_dpi_display_ttu_regs_st *ttu_regs,
+		struct _vcs_dpi_display_rq_regs_st *rq_regs,
+		struct _vcs_dpi_display_pipe_dest_params_st *pipe_dest);
+
+void hwss_add_hubp_set_unbounded_requesting(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		bool unbounded_req);
+
+void hwss_add_hubp_setup_interdependent2(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		struct dml2_dchub_per_pipe_register_set *hubp_regs);
+
+void hwss_add_hubp_setup_interdependent(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		struct _vcs_dpi_display_dlg_regs_st *dlg_regs,
+		struct _vcs_dpi_display_ttu_regs_st *ttu_regs);
+void hwss_add_hubp_program_surface_config(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		enum surface_pixel_format format,
+		struct dc_tiling_info *tiling_info,
+		struct plane_size plane_size,
+		enum dc_rotation_angle rotation,
+		struct dc_plane_dcc_param *dcc,
+		bool horizontal_mirror,
+		int compat_level);
+
+void hwss_add_dpp_setup_dpp(struct block_sequence_state *seq_state,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_dpp_set_cursor_matrix(struct block_sequence_state *seq_state,
+		struct dpp *dpp,
+		enum dc_color_space color_space,
+		struct dc_csc_transform *cursor_csc_color_matrix);
+
+void hwss_add_mpc_update_blending(struct block_sequence_state *seq_state,
+		struct mpc *mpc,
+		struct mpcc_blnd_cfg blnd_cfg,
+		int mpcc_id);
+
+void hwss_add_mpc_assert_idle_mpcc(struct block_sequence_state *seq_state,
+		struct mpc *mpc,
+		int mpcc_id);
+
+void hwss_add_mpc_insert_plane(struct block_sequence_state *seq_state,
+		struct mpc *mpc,
+		struct mpc_tree *mpc_tree_params,
+		struct mpcc_blnd_cfg blnd_cfg,
+		struct mpcc_sm_cfg *sm_cfg,
+		struct mpcc *insert_above_mpcc,
+		int dpp_id,
+		int mpcc_id);
+
+void hwss_add_dpp_set_scaler(struct block_sequence_state *seq_state,
+		struct dpp *dpp,
+		const struct scaler_data *scl_data);
+
+void hwss_add_hubp_mem_program_viewport(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		const struct rect *viewport,
+		const struct rect *viewport_c);
+
+void hwss_add_set_cursor_attribute(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_set_cursor_position(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_set_cursor_sdr_white_level(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx);
+
+void hwss_add_program_output_csc(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		enum dc_color_space colorspace,
+		uint16_t *matrix,
+		int opp_id);
+
+void hwss_add_phantom_hubp_post_enable(struct block_sequence_state *seq_state,
+		struct hubp *hubp);
+
+void hwss_add_update_force_pstate(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct dc_state *context);
+
+void hwss_add_hubbub_apply_dedcn21_147_wa(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub);
+
+void hwss_add_hubbub_allow_self_refresh_control(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub,
+		bool allow,
+		bool *disallow_self_refresh_applied);
+
+void hwss_add_tg_get_frame_count(struct block_sequence_state *seq_state,
+		struct timing_generator *tg,
+		unsigned int *frame_count);
+
+void hwss_add_tg_set_dsc_config(struct block_sequence_state *seq_state,
+		struct timing_generator *tg,
+		struct dsc_optc_config *dsc_optc_cfg,
+		bool enable);
+
+void hwss_add_opp_program_left_edge_extra_pixel(struct block_sequence_state *seq_state,
+		struct output_pixel_processor *opp,
+		enum dc_pixel_encoding pixel_encoding,
+		bool is_otg_master);
+
 #endif /* __DC_HW_SEQUENCER_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 1e2d247fbbac..406db231bc72 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -27,6 +27,7 @@
 #define __DC_HW_SEQUENCER_PRIVATE_H__
 
 #include "dc_types.h"
+#include "hw_sequencer.h"
 
 enum pipe_gating_control {
 	PIPE_GATING_CONTROL_DISABLE = 0,
@@ -80,7 +81,13 @@ struct hwseq_private_funcs {
 	void (*plane_atomic_disconnect)(struct dc *dc,
 			struct dc_state *state,
 			struct pipe_ctx *pipe_ctx);
+	void (*plane_atomic_disconnect_sequence)(struct dc *dc,
+			struct dc_state *state,
+			struct pipe_ctx *pipe_ctx,
+			struct block_sequence_state *seq_state);
 	void (*update_mpcc)(struct dc *dc, struct pipe_ctx *pipe_ctx);
+	void (*update_mpcc_sequence)(struct dc *dc, struct pipe_ctx *pipe_ctx,
+			struct block_sequence_state *seq_state);
 	bool (*set_input_transfer_func)(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_plane_state *plane_state);
@@ -97,6 +104,10 @@ struct hwseq_private_funcs {
 	void (*blank_pixel_data)(struct dc *dc,
 			struct pipe_ctx *pipe_ctx,
 			bool blank);
+	void (*blank_pixel_data_sequence)(struct dc *dc,
+			struct pipe_ctx *pipe_ctx,
+			bool blank,
+			struct block_sequence_state *seq_state);
 	enum dc_status (*enable_stream_timing)(
 			struct pipe_ctx *pipe_ctx,
 			struct dc_state *context,
@@ -105,6 +116,8 @@ struct hwseq_private_funcs {
 			bool enable);
 	void (*setup_vupdate_interrupt)(struct dc *dc,
 			struct pipe_ctx *pipe_ctx);
+	void (*setup_vupdate_interrupt_sequence)(struct dc *dc, struct pipe_ctx *pipe_ctx,
+		struct block_sequence_state *seq_state);
 	bool (*did_underflow_occur)(struct dc *dc, struct pipe_ctx *pipe_ctx);
 	void (*init_blank)(struct dc *dc, struct timing_generator *tg);
 	void (*disable_vga)(struct dce_hwseq *hws);
@@ -112,6 +125,10 @@ struct hwseq_private_funcs {
 	void (*plane_atomic_power_down)(struct dc *dc,
 			struct dpp *dpp,
 			struct hubp *hubp);
+	void (*plane_atomic_power_down_sequence)(struct dc *dc,
+			struct dpp *dpp,
+			struct hubp *hubp,
+			struct block_sequence_state *seq_state);
 	void (*plane_atomic_disable)(struct dc *dc, struct pipe_ctx *pipe_ctx);
 	void (*enable_power_gating_plane)(struct dce_hwseq *hws,
 		bool enable);
@@ -140,15 +157,31 @@ struct hwseq_private_funcs {
 			unsigned int dsc_inst);
 	void (*update_odm)(struct dc *dc, struct dc_state *context,
 			struct pipe_ctx *pipe_ctx);
+	void (*update_odm_sequence)(struct dc *dc, struct dc_state *context,
+			struct pipe_ctx *pipe_ctx, struct block_sequence_state *seq_state);
 	void (*program_all_writeback_pipes_in_tree)(struct dc *dc,
 			const struct dc_stream_state *stream,
 			struct dc_state *context);
+	void (*program_all_writeback_pipes_in_tree_sequence)(
+			struct dc *dc,
+			const struct dc_stream_state *stream,
+			struct dc_state *context,
+			struct block_sequence_state *seq_state);
 	bool (*s0i3_golden_init_wa)(struct dc *dc);
 	void (*set_hdr_multiplier)(struct pipe_ctx *pipe_ctx);
+	void (*set_hdr_multiplier_sequence)(struct pipe_ctx *pipe_ctx,
+			struct block_sequence_state *seq_state);
 	void (*verify_allow_pstate_change_high)(struct dc *dc);
+	void (*verify_allow_pstate_change_high_sequence)(struct dc *dc,
+		struct block_sequence_state *seq_state);
 	void (*program_pipe)(struct dc *dc,
 			struct pipe_ctx *pipe_ctx,
 			struct dc_state *context);
+	void (*program_pipe_sequence)(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		struct dc_state *context,
+		struct block_sequence_state *seq_state);
 	bool (*wait_for_blank_complete)(struct output_pixel_processor *opp);
 	void (*dccg_init)(struct dce_hwseq *hws);
 	bool (*set_blend_lut)(struct pipe_ctx *pipe_ctx,
@@ -163,6 +196,8 @@ struct hwseq_private_funcs {
 	void (*enable_plane)(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			       struct dc_state *context);
 	void (*program_mall_pipe_config)(struct dc *dc, struct dc_state *context);
+	void (*program_mall_pipe_config_sequence)(struct dc *dc, struct dc_state *context,
+			struct block_sequence_state *seq_state);
 	void (*update_force_pstate)(struct dc *dc, struct dc_state *context);
 	void (*update_mall_sel)(struct dc *dc, struct dc_state *context);
 	unsigned int (*calculate_dccg_k1_k2_values)(struct pipe_ctx *pipe_ctx,
@@ -186,6 +221,7 @@ struct hwseq_private_funcs {
 	void (*perform_3dlut_wa_unlock)(struct pipe_ctx *pipe_ctx);
 	void (*wait_for_pipe_update_if_needed)(struct dc *dc, struct pipe_ctx *pipe_ctx, bool is_surface_update_only);
 	void (*set_wait_for_update_needed_for_pipe)(struct dc *dc, struct pipe_ctx *pipe_ctx);
+	void (*dc_ip_request_cntl)(struct dc *dc, bool enable);
 };
 
 struct dce_hwseq {
-- 
2.51.0

