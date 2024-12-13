Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6054EE7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 082F910F06F;
	Fri, 13 Dec 2024 15:54:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gBLo0KxT";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 744A810F06F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJ5BMs3o1dnctx1FTqM+XDeIsjLqNgivH2jJ5mTf6mxjdwDu7Rb4vFV7Rxt+CazfsU+ykwojgKoEY+U49+m5MM+EjI13L8h2a0bO+cxhSI5B4c68Nicdz4zKQzqOqEMCiuA++CAvhT7x5TQH8IlY87bkfOlm1Wc5f9VFRIYYjYF+JSBx8nJLNdPq45wIxr4+pkj9/bxkEXNMnFYdGWXoWj/4SPW+MPxBGw42tF7ZHgSw8AHwRVLUzwOypm1nzJ2l0E9REIY6TjFITc4dP3RDNDA3wpiLoeaxPT1jhORfqZtD+ZfrSnTxnCTSqZ2aTPlUV0KEcDiFJg1TERGMWj5mdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxizJLop4QPzJ0NZxvc/2/z20EDsrih6SLGWlD6FZdY=;
 b=dkS2vi90OvU6h6ZB9gVmPpSZz4lSeKtmZPn4wf2VT485fSnvJI62bdTM2gODD1anJP5wYwqfmB2/8/Qkdnw7aIATXMoLrG388GAM2Z21eubsY1Fy0JVV+5R4DkIp+jyM8kiUJqqSaLOYeCrrAKUv5YTmp9B9qOtCs7SecRJl9pJDKZzkz9Brk6ApkfZOrFN+rFyl6jdQprbKTD9agwuMz0V9jeZV/jJFpf7tckKDxEOUfjqt7jCvEQKLFGhcs6rUgCoPfsGHnkJCldqLVFZrszjLXpyu+5UuapqWdPMeS7EW5d4mcuuEhAFZ4+ofkAmET8FtWAXExApCnpnaAuLK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxizJLop4QPzJ0NZxvc/2/z20EDsrih6SLGWlD6FZdY=;
 b=gBLo0KxTwSwfEs1TKXs0/z/8fHgwNK95q66hg2uVXJxXZGQumPsykiQqL5zfFyGlspIuWBNXeOnkJ/cwiPIRNlog9eb3f42r9pYm6tq9i10C1fypJdBow2nR8+4t7Ify2/93nu3JzcX1IX3gFeJu5vWnYwJVSHM2K/me1CVEqos=
Received: from DS7PR03CA0313.namprd03.prod.outlook.com (2603:10b6:8:2b::18) by
 SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 15:54:40 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::58) by DS7PR03CA0313.outlook.office365.com
 (2603:10b6:8:2b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 15:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:54:39 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:54:36 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 02/17] drm/amd/display: Add support for FAMS2+ interface
 versions
Date: Fri, 13 Dec 2024 08:52:34 -0700
Message-ID: <20241213155405.393252-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 861044a9-f99e-430d-cb4b-08dd1b8e73ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M5xcj2lmxOkSjQ5qo/ZSN8WRD5UnjyBfsmnp9C1Pqi2Whebs7BACRdsu8Z4c?=
 =?us-ascii?Q?ZWeS6DR1B1CTtjD/BmniiHRhrwqQcQQAZx5sTFOrVtcDh3FUHMV4U56Q1dI/?=
 =?us-ascii?Q?eyGT5vzkYqCrJ3bQNUKHYTjtTy7Fth/6bnLf1vkSaNgqN+gILbC26lFzYXv4?=
 =?us-ascii?Q?nOyrWNw2n9WaI+Hh80O1TFZSIKeAuvIZSowoj+Ydsx0pxLdA1zmzcR7RPscc?=
 =?us-ascii?Q?eL1wKuiw50Z+KukbL7CUYuaLTowjVphGoJlWil5VEoaN+oW2IlRnPcs4Dqak?=
 =?us-ascii?Q?N1qYZ8LOU5rBGpTiPa9IAiJPOSRkvss5tP9JN8e+w6We7b0Am2+mG5rlu5pJ?=
 =?us-ascii?Q?jQ6KpdTc4dxLDrOjAeSIYsv86BUnnas/Jh9K5woVpGoh5iIvONdCNOzHFRvD?=
 =?us-ascii?Q?oWwN/yvA8i3NNmkIVMbZnqTZRhOoK1ZjdoMGSCd7xnXihrVXOE4PfS1C48Mi?=
 =?us-ascii?Q?OmOkk5iEhzEttiwQeGaPzdcHdYFFP2vrGozZYiqw2+b7ZIxqY3Kr4eNWFrFS?=
 =?us-ascii?Q?RzIX2OMGsC230H+Mm4ls0AnONtXrZea0oj+G5dElA/vmkDpquF2lDzYvwbAt?=
 =?us-ascii?Q?iPuX0zJQCGPexxHqNpX0/MCMYt5L0TwvankdUUOJERkYDNWb+97/FwuYOxKV?=
 =?us-ascii?Q?dro88GpujpGR5IeN+FbEICFFNhMoV+Dd7/fb7IMWsyrjhO8llJUYlVbB87n1?=
 =?us-ascii?Q?d87KNaP3YRG6nmssdMV6Yazi4GXttpXfP5zBkZZDL+suQzVi2oiUF6JG1aHz?=
 =?us-ascii?Q?mxxQc/Hsw3tceEB45a0CmKVuUhe7ZZMDOl2yvYCc91/M9OPOBgkCBqAqhUMM?=
 =?us-ascii?Q?Tm/O/f8Nk3Ic4mZRG7pb+mPZv6Tylmo3d/Jt5F3cgjwAiZcdyHb4EK5IcsJ0?=
 =?us-ascii?Q?1SNXhs/Ssh7+IkjFRw8NG6m6jmfVvpkgDs6x+5VzW1EEPy3qH8OD8T/iD/up?=
 =?us-ascii?Q?zsTZGcKcJuLLG3r4iKZbC0Rx1h/9fm6RHZjyeNL4dCii/NRdqgeyqCOmfGQE?=
 =?us-ascii?Q?W3POPNdheK5EBrBMe5o0Nl835Nf88b3WUHhvdZyTU5MzOBOGtCkW8LU78SvK?=
 =?us-ascii?Q?8vTH/WPmpRLuDt8v+hfT6i+mgwj7mVgmFMC9jaDDMvM6vcL6SbuebLOVX32g?=
 =?us-ascii?Q?Tb0LS8CzzYA8tu9Lq33DFZj00ZBuopqGFVaBLHR9oJ3/gCoOdct3x1CS36Hv?=
 =?us-ascii?Q?7i2JEoU4WA3ihdgbHjlh1XqGo7epeMGHlVJytp9Njv+nch+XZIeGKJsuQLHr?=
 =?us-ascii?Q?vzSyWAvDjGJpI0/2DMVC5x/ec4z/51gSBou9cg8mee4DkQyn64JspQ3KH8/M?=
 =?us-ascii?Q?YbzwNcoHwArIXcaUvO9aA33Y84RkOAhhQ3hVbLdw6VUssagRRy4WLh3Ie7hx?=
 =?us-ascii?Q?EUn+5xktTM+rqhQH58P72VyUsogTaMgC6LmNo9UECjnG4AeTuMIcMM6Q+wKV?=
 =?us-ascii?Q?Sjaj18fXV/T9CQRPlThDN7D+h1eSZEgu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:54:39.9589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 861044a9-f99e-430d-cb4b-08dd1b8e73ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361
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

From: Dillon Varone <dillon.varone@amd.com>

Current driver interface does not allow for flexibility in coexistence
of multiple interface versions, so add support for checking minor
interface revisions and providing appropriate programming.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 40 ++++-----
 .../amd/display/dc/dml2/dml21/dml21_utils.c   | 80 +++++++++++------
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |  2 +-
 .../display/dc/dml2/dml21/inc/dml_top_types.h |  3 +-
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |  3 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 90 ++++++++++---------
 .../src/dml2_core/dml2_core_dcn4_calcs.h      |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  3 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  4 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |  4 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  4 +
 12 files changed, 134 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9cd81de4be02..961b8245523c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1056,6 +1056,7 @@ struct dc_debug_options {
 	bool dml21_force_pstate_method;
 	uint32_t dml21_force_pstate_method_values[MAX_PIPES];
 	uint32_t dml21_disable_pstate_method_mask;
+	union fw_assisted_mclk_switch_version fams_version;
 	union dmub_fams2_global_feature_config fams2_config;
 	bool enable_legacy_clock_update;
 	unsigned int force_cositing;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 4127a4a2f1e0..44ff9abe2880 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1714,30 +1714,26 @@ void dc_dmub_srv_fams2_update_config(struct dc *dc,
 
 		/* construct per-stream configs */
 		for (i = 0; i < context->bw_ctx.bw.dcn.fams2_global_config.num_streams; i++) {
-			struct dmub_rb_cmd_fams2 *stream_cmd = &cmd[i+1].fams2_config;
-			struct dmub_rb_cmd_fams2 *sub_state_cmd = &cmd[i+1+context->bw_ctx.bw.dcn.fams2_global_config.num_streams].fams2_config;
+			struct dmub_rb_cmd_fams2 *stream_base_cmd = &cmd[i+1].fams2_config;
+			struct dmub_rb_cmd_fams2 *stream_sub_state_cmd = &cmd[i+1+context->bw_ctx.bw.dcn.fams2_global_config.num_streams].fams2_config;
 
 			/* configure command header */
-			stream_cmd->header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
-			stream_cmd->header.sub_type = DMUB_CMD__FAMS2_CONFIG;
-			stream_cmd->header.payload_bytes = sizeof(struct dmub_rb_cmd_fams2) - sizeof(struct dmub_cmd_header);
-			stream_cmd->header.multi_cmd_pending = 1;
-			sub_state_cmd->header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
-			sub_state_cmd->header.sub_type = DMUB_CMD__FAMS2_CONFIG;
-			sub_state_cmd->header.payload_bytes = sizeof(struct dmub_rb_cmd_fams2) - sizeof(struct dmub_cmd_header);
-			sub_state_cmd->header.multi_cmd_pending = 1;
-			/* copy stream static state */
-			memcpy(&stream_cmd->config.stream_v1.base,
-					&context->bw_ctx.bw.dcn.fams2_stream_params[i],
-					sizeof(struct dmub_fams2_cmd_stream_static_base_state));
-			// TODO: Use the below memcpy call instead of the above once DML is updated
-			/*memcpy(&stream_cmd->config.stream_v1.base,
-					&context->bw_ctx.bw.dcn.fams2_stream_params[i].base,
-					sizeof(struct dmub_fams2_cmd_stream_static_base_state));*/
-			/* copy stream sub state */
-			memcpy(&stream_cmd->config.stream_v1.sub_state,
-					&context->bw_ctx.bw.dcn.fams2_stream_params[i].sub_state,
-					sizeof(union dmub_fams2_cmd_stream_static_sub_state));
+			stream_base_cmd->header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
+			stream_base_cmd->header.sub_type = DMUB_CMD__FAMS2_CONFIG;
+			stream_base_cmd->header.payload_bytes = sizeof(struct dmub_rb_cmd_fams2) - sizeof(struct dmub_cmd_header);
+			stream_base_cmd->header.multi_cmd_pending = 1;
+			stream_sub_state_cmd->header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
+			stream_sub_state_cmd->header.sub_type = DMUB_CMD__FAMS2_CONFIG;
+			stream_sub_state_cmd->header.payload_bytes = sizeof(struct dmub_rb_cmd_fams2) - sizeof(struct dmub_cmd_header);
+			stream_sub_state_cmd->header.multi_cmd_pending = 1;
+			/* copy stream static base state */
+			memcpy(&stream_base_cmd->config,
+					&context->bw_ctx.bw.dcn.fams2_stream_base_params[i],
+					sizeof(union dmub_cmd_fams2_config));
+			/* copy stream static sub state */
+			memcpy(&stream_sub_state_cmd->config,
+					&context->bw_ctx.bw.dcn.fams2_stream_sub_params[i],
+					sizeof(union dmub_cmd_fams2_config));
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
index 51d491bffa32..cb966f8d3216 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
@@ -482,7 +482,8 @@ void dml21_build_fams2_programming(const struct dc *dc,
 	unsigned int num_fams2_streams = 0;
 
 	/* reset fams2 data */
-	memset(&context->bw_ctx.bw.dcn.fams2_stream_params, 0, sizeof(struct dmub_fams2_stream_static_state) * DML2_MAX_PLANES);
+	memset(&context->bw_ctx.bw.dcn.fams2_stream_base_params, 0, sizeof(union dmub_cmd_fams2_config) * DML2_MAX_PLANES);
+	memset(&context->bw_ctx.bw.dcn.fams2_stream_sub_params, 0, sizeof(union dmub_cmd_fams2_config) * DML2_MAX_PLANES);
 	memset(&context->bw_ctx.bw.dcn.fams2_global_config, 0, sizeof(struct dmub_cmd_fams2_global_config));
 
 	if (dml_ctx->v21.mode_programming.programming->fams2_required) {
@@ -490,8 +491,10 @@ void dml21_build_fams2_programming(const struct dc *dc,
 			int dml_stream_idx;
 			struct dc_stream_state *phantom_stream;
 			struct dc_stream_status *phantom_status;
+			enum fams2_stream_type type = 0;
 
-			struct dmub_fams2_stream_static_state *static_state = &context->bw_ctx.bw.dcn.fams2_stream_params[num_fams2_streams];
+			union dmub_cmd_fams2_config *static_base_state = &context->bw_ctx.bw.dcn.fams2_stream_base_params[num_fams2_streams];
+			union dmub_cmd_fams2_config *static_sub_state = &context->bw_ctx.bw.dcn.fams2_stream_sub_params[num_fams2_streams];
 
 			struct dc_stream_state *stream = context->streams[i];
 
@@ -508,28 +511,38 @@ void dml21_build_fams2_programming(const struct dc *dc,
 			}
 
 			/* copy static state from PMO */
-			memcpy(static_state,
-					&dml_ctx->v21.mode_programming.programming->stream_programming[dml_stream_idx].fams2_params,
-					sizeof(struct dmub_fams2_stream_static_state));
-
-			/* get information from context */
-			static_state->num_planes = context->stream_status[i].plane_count;
-			static_state->otg_inst = context->stream_status[i].primary_otg_inst;
-
-			/* populate pipe masks for planes */
-			for (j = 0; j < context->stream_status[i].plane_count; j++) {
-				for (k = 0; k < dc->res_pool->pipe_count; k++) {
-					if (context->res_ctx.pipe_ctx[k].stream &&
-							context->res_ctx.pipe_ctx[k].stream->stream_id == stream->stream_id &&
-							context->res_ctx.pipe_ctx[k].plane_state == context->stream_status[i].plane_states[j]) {
-						static_state->pipe_mask |= (1 << k);
-						static_state->plane_pipe_masks[j] |= (1 << k);
+			memcpy(static_base_state,
+					&dml_ctx->v21.mode_programming.programming->stream_programming[dml_stream_idx].fams2_base_params,
+					sizeof(union dmub_cmd_fams2_config));
+			memcpy(static_sub_state,
+					&dml_ctx->v21.mode_programming.programming->stream_programming[dml_stream_idx].fams2_sub_params,
+					sizeof(union dmub_cmd_fams2_config));
+
+			switch (dc->debug.fams_version.minor) {
+			case 1:
+			default:
+				type = static_base_state->stream_v1.base.type;
+
+				/* get information from context */
+				static_base_state->stream_v1.base.num_planes = context->stream_status[i].plane_count;
+				static_base_state->stream_v1.base.otg_inst = context->stream_status[i].primary_otg_inst;
+
+				/* populate pipe masks for planes */
+				for (j = 0; j < context->stream_status[i].plane_count; j++) {
+					for (k = 0; k < dc->res_pool->pipe_count; k++) {
+						if (context->res_ctx.pipe_ctx[k].stream &&
+								context->res_ctx.pipe_ctx[k].stream->stream_id == stream->stream_id &&
+								context->res_ctx.pipe_ctx[k].plane_state == context->stream_status[i].plane_states[j]) {
+							static_base_state->stream_v1.base.pipe_mask |= (1 << k);
+							static_base_state->stream_v1.base.plane_pipe_masks[j] |= (1 << k);
+						}
 					}
 				}
 			}
 
+
 			/* get per method programming */
-			switch (static_state->type) {
+			switch (type) {
 			case FAMS2_STREAM_TYPE_VBLANK:
 			case FAMS2_STREAM_TYPE_VACTIVE:
 			case FAMS2_STREAM_TYPE_DRR:
@@ -543,16 +556,27 @@ void dml21_build_fams2_programming(const struct dc *dc,
 
 				/* phantom status should always be present */
 				ASSERT(phantom_status);
-				static_state->sub_state.subvp.phantom_otg_inst = phantom_status->primary_otg_inst;
+				if (!phantom_status)
+					break;
 
-				/* populate pipe masks for phantom planes */
-				for (j = 0; j < phantom_status->plane_count; j++) {
-					for (k = 0; k < dc->res_pool->pipe_count; k++) {
-						if (context->res_ctx.pipe_ctx[k].stream &&
-								context->res_ctx.pipe_ctx[k].stream->stream_id == phantom_stream->stream_id &&
-								context->res_ctx.pipe_ctx[k].plane_state == phantom_status->plane_states[j]) {
-							static_state->sub_state.subvp.phantom_pipe_mask |= (1 << k);
-							static_state->sub_state.subvp.phantom_plane_pipe_masks[j] |= (1 << k);
+				switch (dc->debug.fams_version.minor) {
+				case 1:
+				default:
+					static_sub_state->stream_v1.sub_state.subvp.phantom_otg_inst = phantom_status->primary_otg_inst;
+
+					/* populate pipe masks for phantom planes */
+					for (j = 0; j < phantom_status->plane_count; j++) {
+						for (k = 0; k < dc->res_pool->pipe_count; k++) {
+							if (context->res_ctx.pipe_ctx[k].stream &&
+									context->res_ctx.pipe_ctx[k].stream->stream_id == phantom_stream->stream_id &&
+									context->res_ctx.pipe_ctx[k].plane_state == phantom_status->plane_states[j]) {
+								switch (dc->debug.fams_version.minor) {
+								case 1:
+								default:
+									static_sub_state->stream_v1.sub_state.subvp.phantom_pipe_mask |= (1 << k);
+									static_sub_state->stream_v1.sub_state.subvp.phantom_plane_pipe_masks[j] |= (1 << k);
+								}
+							}
 						}
 					}
 				}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/bounding_boxes/dcn4_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/bounding_boxes/dcn4_soc_bb.h
index 8ef7977841de..8b18027b8357 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/bounding_boxes/dcn4_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/bounding_boxes/dcn4_soc_bb.h
@@ -354,7 +354,7 @@ static const struct dml2_ip_capabilities dml2_dcn401_max_ip_caps = {
 
 	.fams2 = {
 		.max_allow_delay_us = 100 * 1000,
-		.scheduling_delay_us = 125,
+		.scheduling_delay_us = 550,
 		.vertical_interrupt_ack_delay_us = 40,
 		.allow_programming_delay_us = 18,
 		.min_allow_width_us = 20,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
index eeb96c455658..476cbd7a4790 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
@@ -289,7 +289,8 @@ struct dml2_per_stream_programming {
 		union dml2_global_sync_programming global_sync;
 	} phantom_stream;
 
-	struct dmub_fams2_stream_static_state fams2_params;
+	union dmub_cmd_fams2_config fams2_base_params;
+	union dmub_cmd_fams2_config fams2_sub_params;
 };
 
 //-----------------
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
index 3d41ffde91c1..367dc8ca89a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -360,7 +360,8 @@ static void pack_mode_programming_params_with_implicit_subvp(struct dml2_core_in
 				/* unconditionally populate fams2 params */
 				dml2_core_calcs_get_stream_fams2_programming(&core->clean_me_up.mode_lib,
 					display_cfg,
-					&programming->stream_programming[main_plane->stream_index].fams2_params,
+					&programming->stream_programming[main_plane->stream_index].fams2_base_params,
+					&programming->stream_programming[main_plane->stream_index].fams2_sub_params,
 					programming->stream_programming[main_plane->stream_index].uclk_pstate_method,
 					plane_index);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 5fb91b882453..74baa480441f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -12332,7 +12332,8 @@ void dml2_core_calcs_get_global_fams2_programming(const struct dml2_core_interna
 
 void dml2_core_calcs_get_stream_fams2_programming(const struct dml2_core_internal_display_mode_lib *mode_lib,
 		const struct display_configuation_with_meta *display_cfg,
-		struct dmub_fams2_stream_static_state *fams2_programming,
+		union dmub_cmd_fams2_config *fams2_base_programming,
+		union dmub_cmd_fams2_config *fams2_sub_programming,
 		enum dml2_uclk_pstate_support_method pstate_method,
 		int plane_index)
 {
@@ -12340,6 +12341,9 @@ void dml2_core_calcs_get_stream_fams2_programming(const struct dml2_core_interna
 	const struct dml2_stream_parameters *stream_descriptor = &display_cfg->display_config.stream_descriptors[plane_descriptor->stream_index];
 	const struct dml2_fams2_meta *stream_fams2_meta = &display_cfg->stage3.stream_fams2_meta[plane_descriptor->stream_index];
 
+	struct dmub_fams2_cmd_stream_static_base_state *base_programming = &fams2_base_programming->stream_v1.base;
+	union dmub_fams2_cmd_stream_static_sub_state *sub_programming = &fams2_sub_programming->stream_v1.sub_state;
+
 	unsigned int i;
 
 	if (display_cfg->display_config.overrides.all_streams_blanked) {
@@ -12348,34 +12352,34 @@ void dml2_core_calcs_get_stream_fams2_programming(const struct dml2_core_interna
 	}
 
 	/* from display configuration */
-	fams2_programming->htotal = (uint16_t)stream_descriptor->timing.h_total;
-	fams2_programming->vtotal = (uint16_t)stream_descriptor->timing.v_total;
-	fams2_programming->vblank_start = (uint16_t)(stream_fams2_meta->nom_vtotal -
+	base_programming->htotal = (uint16_t)stream_descriptor->timing.h_total;
+	base_programming->vtotal = (uint16_t)stream_descriptor->timing.v_total;
+	base_programming->vblank_start = (uint16_t)(stream_fams2_meta->nom_vtotal -
 		stream_descriptor->timing.v_front_porch);
-	fams2_programming->vblank_end = (uint16_t)(stream_fams2_meta->nom_vtotal -
+	base_programming->vblank_end = (uint16_t)(stream_fams2_meta->nom_vtotal -
 		stream_descriptor->timing.v_front_porch -
 		stream_descriptor->timing.v_active);
-	fams2_programming->config.bits.is_drr = stream_descriptor->timing.drr_config.enabled;
+	base_programming->config.bits.is_drr = stream_descriptor->timing.drr_config.enabled;
 
 	/* from meta */
-	fams2_programming->otg_vline_time_ns =
+	base_programming->otg_vline_time_ns =
 		(unsigned int)(stream_fams2_meta->otg_vline_time_us * 1000.0);
-	fams2_programming->scheduling_delay_otg_vlines = (uint8_t)stream_fams2_meta->scheduling_delay_otg_vlines;
-	fams2_programming->contention_delay_otg_vlines = (uint8_t)stream_fams2_meta->contention_delay_otg_vlines;
-	fams2_programming->vline_int_ack_delay_otg_vlines = (uint8_t)stream_fams2_meta->vertical_interrupt_ack_delay_otg_vlines;
-	fams2_programming->drr_keepout_otg_vline = (uint16_t)(stream_fams2_meta->nom_vtotal -
+	base_programming->scheduling_delay_otg_vlines = (uint8_t)stream_fams2_meta->scheduling_delay_otg_vlines;
+	base_programming->contention_delay_otg_vlines = (uint8_t)stream_fams2_meta->contention_delay_otg_vlines;
+	base_programming->vline_int_ack_delay_otg_vlines = (uint8_t)stream_fams2_meta->vertical_interrupt_ack_delay_otg_vlines;
+	base_programming->drr_keepout_otg_vline = (uint16_t)(stream_fams2_meta->nom_vtotal -
 		stream_descriptor->timing.v_front_porch -
 		stream_fams2_meta->method_drr.programming_delay_otg_vlines);
-	fams2_programming->allow_to_target_delay_otg_vlines = (uint8_t)stream_fams2_meta->allow_to_target_delay_otg_vlines;
-	fams2_programming->max_vtotal = (uint16_t)stream_fams2_meta->max_vtotal;
+	base_programming->allow_to_target_delay_otg_vlines = (uint8_t)stream_fams2_meta->allow_to_target_delay_otg_vlines;
+	base_programming->max_vtotal = (uint16_t)stream_fams2_meta->max_vtotal;
 
 	/* from core */
-	fams2_programming->config.bits.min_ttu_vblank_usable = true;
+	base_programming->config.bits.min_ttu_vblank_usable = true;
 	for (i = 0; i < display_cfg->display_config.num_planes; i++) {
 		/* check if all planes support p-state in blank */
 		if (display_cfg->display_config.plane_descriptors[i].stream_index == plane_descriptor->stream_index &&
 				mode_lib->mp.MinTTUVBlank[i] <= mode_lib->mp.Watermark.DRAMClockChangeWatermark) {
-			fams2_programming->config.bits.min_ttu_vblank_usable = false;
+			base_programming->config.bits.min_ttu_vblank_usable = false;
 			break;
 		}
 	}
@@ -12384,67 +12388,67 @@ void dml2_core_calcs_get_stream_fams2_programming(const struct dml2_core_interna
 	case dml2_uclk_pstate_support_method_vactive:
 	case dml2_uclk_pstate_support_method_fw_vactive_drr:
 		/* legacy vactive */
-		fams2_programming->type = FAMS2_STREAM_TYPE_VACTIVE;
-		fams2_programming->sub_state.legacy.vactive_det_fill_delay_otg_vlines =
+		base_programming->type = FAMS2_STREAM_TYPE_VACTIVE;
+		sub_programming->legacy.vactive_det_fill_delay_otg_vlines =
 				(uint8_t)stream_fams2_meta->method_vactive.max_vactive_det_fill_delay_otg_vlines;
-		fams2_programming->allow_start_otg_vline =
+		base_programming->allow_start_otg_vline =
 				(uint16_t)stream_fams2_meta->method_vactive.common.allow_start_otg_vline;
-		fams2_programming->allow_end_otg_vline =
+		base_programming->allow_end_otg_vline =
 				(uint16_t)stream_fams2_meta->method_vactive.common.allow_end_otg_vline;
-		fams2_programming->config.bits.clamp_vtotal_min = true;
+		base_programming->config.bits.clamp_vtotal_min = true;
 		break;
 	case dml2_uclk_pstate_support_method_vblank:
 	case dml2_uclk_pstate_support_method_fw_vblank_drr:
 		/* legacy vblank */
-		fams2_programming->type = FAMS2_STREAM_TYPE_VBLANK;
-		fams2_programming->allow_start_otg_vline =
+		base_programming->type = FAMS2_STREAM_TYPE_VBLANK;
+		base_programming->allow_start_otg_vline =
 				(uint16_t)stream_fams2_meta->method_vblank.common.allow_start_otg_vline;
-		fams2_programming->allow_end_otg_vline =
+		base_programming->allow_end_otg_vline =
 				(uint16_t)stream_fams2_meta->method_vblank.common.allow_end_otg_vline;
-		fams2_programming->config.bits.clamp_vtotal_min = true;
+		base_programming->config.bits.clamp_vtotal_min = true;
 		break;
 	case dml2_uclk_pstate_support_method_fw_drr:
 		/* drr */
-		fams2_programming->type = FAMS2_STREAM_TYPE_DRR;
-		fams2_programming->sub_state.drr.programming_delay_otg_vlines =
+		base_programming->type = FAMS2_STREAM_TYPE_DRR;
+		sub_programming->drr.programming_delay_otg_vlines =
 				(uint8_t)stream_fams2_meta->method_drr.programming_delay_otg_vlines;
-		fams2_programming->sub_state.drr.nom_stretched_vtotal =
+		sub_programming->drr.nom_stretched_vtotal =
 				(uint16_t)stream_fams2_meta->method_drr.stretched_vtotal;
-		fams2_programming->allow_start_otg_vline =
+		base_programming->allow_start_otg_vline =
 				(uint16_t)stream_fams2_meta->method_drr.common.allow_start_otg_vline;
-		fams2_programming->allow_end_otg_vline =
+		base_programming->allow_end_otg_vline =
 				(uint16_t)stream_fams2_meta->method_drr.common.allow_end_otg_vline;
 		/* drr only clamps to vtotal min for single display */
-		fams2_programming->config.bits.clamp_vtotal_min = display_cfg->display_config.num_streams == 1;
-		fams2_programming->sub_state.drr.only_stretch_if_required = true;
+		base_programming->config.bits.clamp_vtotal_min = display_cfg->display_config.num_streams == 1;
+		sub_programming->drr.only_stretch_if_required = true;
 		break;
 	case dml2_uclk_pstate_support_method_fw_subvp_phantom:
 	case dml2_uclk_pstate_support_method_fw_subvp_phantom_drr:
 		/* subvp */
-		fams2_programming->type = FAMS2_STREAM_TYPE_SUBVP;
-		fams2_programming->sub_state.subvp.vratio_numerator =
+		base_programming->type = FAMS2_STREAM_TYPE_SUBVP;
+		sub_programming->subvp.vratio_numerator =
 				(uint16_t)(plane_descriptor->composition.scaler_info.plane0.v_ratio * 1000.0);
-		fams2_programming->sub_state.subvp.vratio_denominator = 1000;
-		fams2_programming->sub_state.subvp.programming_delay_otg_vlines =
+		sub_programming->subvp.vratio_denominator = 1000;
+		sub_programming->subvp.programming_delay_otg_vlines =
 				(uint8_t)stream_fams2_meta->method_subvp.programming_delay_otg_vlines;
-		fams2_programming->sub_state.subvp.prefetch_to_mall_otg_vlines =
+		sub_programming->subvp.prefetch_to_mall_otg_vlines =
 				(uint8_t)stream_fams2_meta->method_subvp.prefetch_to_mall_delay_otg_vlines;
-		fams2_programming->sub_state.subvp.phantom_vtotal =
+		sub_programming->subvp.phantom_vtotal =
 				(uint16_t)stream_fams2_meta->method_subvp.phantom_vtotal;
-		fams2_programming->sub_state.subvp.phantom_vactive =
+		sub_programming->subvp.phantom_vactive =
 				(uint16_t)stream_fams2_meta->method_subvp.phantom_vactive;
-		fams2_programming->sub_state.subvp.config.bits.is_multi_planar =
+		sub_programming->subvp.config.bits.is_multi_planar =
 				plane_descriptor->surface.plane1.height > 0;
-		fams2_programming->sub_state.subvp.config.bits.is_yuv420 =
+		sub_programming->subvp.config.bits.is_yuv420 =
 				plane_descriptor->pixel_format == dml2_420_8 ||
 				plane_descriptor->pixel_format == dml2_420_10 ||
 				plane_descriptor->pixel_format == dml2_420_12;
 
-		fams2_programming->allow_start_otg_vline =
+		base_programming->allow_start_otg_vline =
 				(uint16_t)stream_fams2_meta->method_subvp.common.allow_start_otg_vline;
-		fams2_programming->allow_end_otg_vline =
+		base_programming->allow_end_otg_vline =
 				(uint16_t)stream_fams2_meta->method_subvp.common.allow_end_otg_vline;
-		fams2_programming->config.bits.clamp_vtotal_min = true;
+		base_programming->config.bits.clamp_vtotal_min = true;
 		break;
 	case dml2_uclk_pstate_support_method_reserved_hw:
 	case dml2_uclk_pstate_support_method_reserved_fw:
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.h
index df2d1550a14b..d4c40b8c3752 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.h
@@ -28,7 +28,7 @@ void dml2_core_calcs_get_plane_support_info(const struct dml2_display_cfg *displ
 void dml2_core_calcs_get_informative(const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_display_cfg_programming *out);
 void dml2_core_calcs_get_stream_support_info(const struct dml2_display_cfg *display_cfg, const struct dml2_core_internal_display_mode_lib *mode_lib, struct core_stream_support_info *out, int plane_index);
 void dml2_core_calcs_get_mall_allocation(struct dml2_core_internal_display_mode_lib *mode_lib, unsigned int *out, int pipe_index);
-void dml2_core_calcs_get_stream_fams2_programming(const struct dml2_core_internal_display_mode_lib *mode_lib, const struct display_configuation_with_meta *display_cfg, struct dmub_fams2_stream_static_state *fams2_programming, enum dml2_uclk_pstate_support_method pstate_method, int plane_index);
+void dml2_core_calcs_get_stream_fams2_programming(const struct dml2_core_internal_display_mode_lib *mode_lib, const struct display_configuation_with_meta *display_cfg, union dmub_cmd_fams2_config *fams2_base_programming, union dmub_cmd_fams2_config *fams2_sub_programming, enum dml2_uclk_pstate_support_method pstate_method, int plane_index);
 void dml2_core_calcs_get_global_fams2_programming(const struct dml2_core_internal_display_mode_lib *mode_lib, const struct display_configuation_with_meta *display_cfg, struct dmub_cmd_fams2_global_config *fams2_global_config);
 
 void dml2_core_calcs_get_dpte_row_height(unsigned int *dpte_row_height, struct dml2_core_internal_display_mode_lib *mode_lib, bool is_plane1, enum dml2_source_format_class SourcePixelFormat, enum dml2_swizzle_mode SurfaceTiling, enum dml2_rotation_angle ScanDirection, unsigned int pitch, unsigned int GPUVMMinPageSizeKBytes);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 307782592789..3f27d8ae7f5d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -435,7 +435,8 @@ void dcn401_init_hw(struct dc *dc)
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
 		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver > 0;
 		dc->caps.dmub_caps.fams_ver = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
-		dc->debug.fams2_config.bits.enable &= dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver == 2;
+		dc->debug.fams2_config.bits.enable &=
+				dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver; // sw & fw fams versions must match for support
 		if ((!dc->debug.fams2_config.bits.enable && dc->res_pool->funcs->update_bw_bounding_box)
 			|| res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq) {
 			/* update bounding box if FAMS2 disabled, or if dchub clk has changed */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 785baffd33ad..06a420154888 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -539,8 +539,8 @@ struct dcn_bw_output {
 	bool legacy_svp_drr_stream_index_valid;
 	struct dml2_mcache_surface_allocation mcache_allocations[DML2_MAX_PLANES];
 	struct dmub_cmd_fams2_global_config fams2_global_config;
-	struct dmub_fams2_stream_static_state fams2_stream_params[DML2_MAX_PLANES];
-	/*struct dmub_fams2_stream_static_state_v1 fams2_stream_params[DML2_MAX_PLANES];*/ // TODO: Update to this once DML is updated
+	union dmub_cmd_fams2_config fams2_stream_base_params[DML2_MAX_PLANES];
+	union dmub_cmd_fams2_config fams2_stream_sub_params[DML2_MAX_PLANES];
 	struct dml2_display_arb_regs arb_regs;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index 783ca9acc762..338a0cad23a5 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -315,7 +315,7 @@ void optc401_set_drr(
 	struct drr_params amended_params = { 0 };
 	bool program_manual_trigger = false;
 
-	if (dc->caps.dmub_caps.fams_ver >= 2 && dc->debug.fams2_config.bits.enable) {
+	if (dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver && dc->debug.fams2_config.bits.enable) {
 		if (params != NULL &&
 				params->vertical_total_max > 0 &&
 				params->vertical_total_min > 0) {
@@ -380,7 +380,7 @@ void optc401_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, i
 {
 	struct dc *dc = optc->ctx->dc;
 
-	if (dc->caps.dmub_caps.fams_ver >= 2 && dc->debug.fams2_config.bits.enable) {
+	if (dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver && dc->debug.fams2_config.bits.enable) {
 		/* FAMS2 */
 		dc_dmub_srv_fams2_drr_update(dc, optc->inst,
 				vtotal_min,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 2a3dabfe3cea..09f5b8b40791 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -726,6 +726,10 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_unbounded_requesting = false,
 	.enable_legacy_fast_update = false,
 	.dcc_meta_propagation_delay_us = 10,
+	.fams_version = {
+		.minor = 1,
+		.major = 2,
+	}, //v2.1
 	.fams2_config = {
 		.bits = {
 			.enable = true,
-- 
2.45.2

