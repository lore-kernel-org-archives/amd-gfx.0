Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936C2C71157
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 15:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0960910E069;
	Wed, 18 Jun 2025 15:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ajLIX/Yd";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4343810E8C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UA8oRkP94doPgY5Y3mueJsZTQIgBczlHxsJnlC9XHdKxM4Wu6dDl0N6de4shPPuUKHMpenfPlEi3cNG3UjaIVD+z7TW8gpc/TwzP1ne8LbD5mMLQ2SC8/Zya8GhB6ar3c7D2wapGxtOuPwEpvokqgTMixuWPLd6vBbZEqK1tUIGIQVD46h962dgi5folSP9X2QIXelHAr8LmgN67A0XFpwu84r1JJV9O/PeOERSs3/Z25oSeu5CUmM9GqWf7WVIfPWiUHAmCn1cLhqGV35ShuDXeS6SunIkK5mThhOQE4V50Mf3QxDnWclh+hjyN3zeVqtzZgrUUGU9Wv21MdyXdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFo7KgL2cInbT9XjeH4UEwz8B5+WU70mg19YzOWqgQg=;
 b=IOT8ZcsyrFZX4U0xtFtv2iIpJbuzsX33gaZmxmuzejYbZYSoXCcbLgfm0/7FxH0g5cVxFS5u4ooOia1rg8QP+YHXvyz1eygivZPYNKVvuFU5hmVmd4cZA4ElJPAuOKWVVzLZju5BGsx3xW2QGA7Drg8Lv7WIN64JHtDMmIVyFCC9sMCHA1jW25CRiW2IJ/PJQT6Gwa1wGye//2DcyGFUvEC/NvueOwqLVDP7JOJfp0iXq26tjarAHHWLyoaFRVsLJr6sS9UatII/GBQCu523j8gGgagqYT3YAmb9GO/otXwrzpinrsS6pr834NstnqnNJYo00ZCOYmZQOCa6VoQVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFo7KgL2cInbT9XjeH4UEwz8B5+WU70mg19YzOWqgQg=;
 b=ajLIX/YdybbBU0fG03pxqRbxlwjNUhAssl1pQXEjmhI7B87lSBwMhY2iN0qFUbqxZUFhqS5q716izfFxoXFQnHnigCCrHZOlgJhjIUnEG98xU3PobJrlKUttNoCfgs4PEfurBdOY8cuLoXXnLcLjPYTxhfHo261TKnAUzUWkGk0=
Received: from SJ0PR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:33b::33)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Wed, 18 Jun 2025 15:54:56 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::4c) by SJ0PR05CA0028.outlook.office365.com
 (2603:10b6:a03:33b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Wed,
 18 Jun 2025 15:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 15:54:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:52 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 10:54:52 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, "Ostrowski, Rafal"
 <rostrows@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 07/13] drm/amd/display: LSDMA support
Date: Wed, 18 Jun 2025 11:33:55 -0400
Message-ID: <20250618153936.6472-8-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618153936.6472-1-Jerry.Zuo@amd.com>
References: <20250618153936.6472-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 5867f140-af20-49d1-93bd-08ddae80787a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N4/yhs1fP1+M5L5JpDcqBwQfKL/QcR6k5RrA6ywTAk28tz3RVlN0Z4PDUS/y?=
 =?us-ascii?Q?mU6lRQDCReJZqvTtjVyP1xUdJLhr3ZEVRlpKsMDD8TPEEPNrBvRvm6sDu6jP?=
 =?us-ascii?Q?yxcbl8AuFF2cETq+zt3mMxuS0exntWQb6M3Cl70T9gjt9JZPRCfIm8d2Nlcp?=
 =?us-ascii?Q?vcKaiyrXgHsWNwLiCMuijVm5Cbz1rcSfQ4NpBu6UIvUXGB5jTwddIdlRKm7F?=
 =?us-ascii?Q?ckv/FZn+jc+ZPxR4TXAniJEpGmgbNA3rZknc+YHAWXaTYj2ewhyF+6GMOwQB?=
 =?us-ascii?Q?WlQmwqUHu60JWr38h5tcWa7lgfoHgUmZDyhYp15HSlRgOrhtZncZ9lRwsXBc?=
 =?us-ascii?Q?3v/A1KZaZPrKvw/CduDFUjqC3ie8XzDS78uwTbz3Fpt5ZTPKWoW3CYEMMkfg?=
 =?us-ascii?Q?ED+APl6c+085NQt+et6mdqNG7mACoIuHqWyiHB5bBLGwU36WNIozLMfPA99F?=
 =?us-ascii?Q?gGlLIMo2m2TAPEtx4BYr/I0Wjk9sPcrCFop+0+dc2qa8mgPrPtdjQnnHR/8u?=
 =?us-ascii?Q?knBG/W349qIXLQrhp+55MqnuO8YCFvZPPL4p/Md1NQVncudPktqSAq/BTYq5?=
 =?us-ascii?Q?7YG16CLGDHS8jf8afpXb5WrbBP4spzNMUu78gt/gw9h61bp7Azk64ybNhNcP?=
 =?us-ascii?Q?LXqsuLAm0Bkbc/Z+jnQY4r/l2cui1JzNUTI/+dQWWjO6hiQCX1un5tJwux+v?=
 =?us-ascii?Q?20GxuoVOXtKadl1DHSJPn6K0YfclOfTEpU14y3KB79rADQumsoCAaBqW/4oO?=
 =?us-ascii?Q?bJ+hefJsBy5scn7OAvui87k+FeX0qRAsaLBXw1lqcPpTIFhvbRa4NYghEXI/?=
 =?us-ascii?Q?DE99gOLL1xuReeuHEHm6jvvqKaSO4ASnp/THgVPHVzzgTS7O5WHQx2EJHW7L?=
 =?us-ascii?Q?gyUG9ytEhkOZFPanJ3ZtfXnSU6ICBqqObAKRhaT6pPRuX7hxW1K6mv9vFISe?=
 =?us-ascii?Q?stx6K+R7bAoRe3y81Wpv7m0kAft1xHHRsY0F36os/hbA2fP0rYTeXoUFXE5s?=
 =?us-ascii?Q?nsqI3KjVwWgyaY2q0i1ku7ELkXj69YPckEdacXejqB7s0jBkwUdlOvu0UT9I?=
 =?us-ascii?Q?XxiLdR2LZ2ujVrkk9sAbv8iJMEg2bALY4GZf3Wg2/CafIiiAmPWKwJQZRH2r?=
 =?us-ascii?Q?yxwiC7vjD0A0hUi7a2qhcVREb8Gcyp4yD3ekwgAap+FEMhM3Ax7t1RY+pMby?=
 =?us-ascii?Q?/8+TnOaC0LMTeS2DgN1PVSQIFg0iUaf6lywapjChXt4iNKfXJLGM4V0YjLRJ?=
 =?us-ascii?Q?SH2pE3RDwwiK34nN9sO7b8sCKjlTO/p5a/wiDs+IUJMTydJ9bvw+jeqBLkBC?=
 =?us-ascii?Q?t+3xS6j9z6ZGDYm+fk2fuqATg1jGmZ0rC11s4gKIfMZ/eHJWPpSGYN+q9YZI?=
 =?us-ascii?Q?WocEFef2vMjiiQrew3d1yFNhY1iOnJ2EUFh3R1cETECZtJFfMJlRLjguTPXO?=
 =?us-ascii?Q?oLOCpCDrB7jfFXREQ3mXbfm7FPblRi1VcG+4lmPQsyQrGAlhmWfeXCbj+HWQ?=
 =?us-ascii?Q?hXAXBoi9Yl54sGilV/CieIUl3A+ZBJ/8alwf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:54:55.5463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5867f140-af20-49d1-93bd-08ddae80787a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262
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

From: "Ostrowski, Rafal" <rostrows@amd.com>

[Why]
Driver should be able to send LSDMA commands to DMCUB

[How]
Driver can now send LSDMA commands to DMCUB.
DMCUB should process them and send to LSDMA controller.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ostrowski Rafal <rostrows@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 199 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  55 +++++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   2 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   4 +
 4 files changed, 260 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 00ea81fa9573..1f685fc5c55a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1984,3 +1984,202 @@ void dc_dmub_srv_ips_query_residency_info(struct dc_dmub_srv *dc_dmub_srv, struc
 					       DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
 			output->histogram[i] = 0;
 }
+
+bool dmub_lsdma_init(struct dc_dmub_srv *dc_dmub_srv)
+{
+	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
+	union dmub_rb_cmd cmd;
+	enum dm_dmub_wait_type wait_type;
+	struct dmub_cmd_lsdma_data *lsdma_data = &cmd.lsdma.lsdma_data;
+	bool result;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.cmd_common.header.type     = DMUB_CMD__LSDMA;
+	cmd.cmd_common.header.sub_type = DMUB_CMD__LSDMA_INIT_CONFIG;
+	wait_type                      = DM_DMUB_WAIT_TYPE_NO_WAIT;
+
+	lsdma_data->u.init_data.gpu_addr_base.quad_part = dc_ctx->dmub_srv->dmub->lsdma_rb_fb.gpu_addr;
+	lsdma_data->u.init_data.ring_size               = dc_ctx->dmub_srv->dmub->lsdma_rb_fb.size;
+
+	result = dc_wake_and_execute_dmub_cmd(dc_ctx, &cmd, wait_type);
+
+	if (!result)
+		DC_ERROR("LSDMA Init failed in DMUB");
+
+	return result;
+}
+
+bool dmub_lsdma_send_linear_copy_packet(
+	struct dc_dmub_srv *dc_dmub_srv,
+	uint64_t src_addr,
+	uint64_t dst_addr,
+	uint32_t count)
+{
+	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
+	union dmub_rb_cmd cmd;
+	enum dm_dmub_wait_type wait_type;
+	struct dmub_cmd_lsdma_data *lsdma_data = &cmd.lsdma.lsdma_data;
+	bool result;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.cmd_common.header.type     = DMUB_CMD__LSDMA;
+	cmd.cmd_common.header.sub_type = DMUB_CMD__LSDMA_LINEAR_COPY;
+	wait_type                      = DM_DMUB_WAIT_TYPE_NO_WAIT;
+
+	lsdma_data->u.linear_copy_data.count   = count - 1; // LSDMA controller expects bytes to copy -1
+	lsdma_data->u.linear_copy_data.src_lo  = src_addr & 0xFFFFFFFF;
+	lsdma_data->u.linear_copy_data.src_hi  = (src_addr >> 32) & 0xFFFFFFFF;
+	lsdma_data->u.linear_copy_data.dst_lo  = dst_addr & 0xFFFFFFFF;
+	lsdma_data->u.linear_copy_data.dst_hi  = (dst_addr >> 32) & 0xFFFFFFFF;
+
+	result = dc_wake_and_execute_dmub_cmd(dc_ctx, &cmd, wait_type);
+
+	if (!result)
+		DC_ERROR("LSDMA Linear Copy failed in DMUB");
+
+	return result;
+}
+
+bool dmub_lsdma_send_tiled_to_tiled_copy_command(
+	struct dc_dmub_srv *dc_dmub_srv,
+	struct lsdma_send_tiled_to_tiled_copy_command_params params)
+{
+	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
+	union dmub_rb_cmd cmd;
+	enum dm_dmub_wait_type wait_type;
+	struct dmub_cmd_lsdma_data *lsdma_data = &cmd.lsdma.lsdma_data;
+	bool result;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.cmd_common.header.type     = DMUB_CMD__LSDMA;
+	cmd.cmd_common.header.sub_type = DMUB_CMD__LSDMA_TILED_TO_TILED_COPY;
+	wait_type                      = DM_DMUB_WAIT_TYPE_NO_WAIT;
+
+	lsdma_data->u.tiled_copy_data.src_addr_lo      = params.src_addr & 0xFFFFFFFF;
+	lsdma_data->u.tiled_copy_data.src_addr_hi      = (params.src_addr >> 32) & 0xFFFFFFFF;
+	lsdma_data->u.tiled_copy_data.dst_addr_lo      = params.dst_addr & 0xFFFFFFFF;
+	lsdma_data->u.tiled_copy_data.dst_addr_hi      = (params.dst_addr >> 32) & 0xFFFFFFFF;
+	lsdma_data->u.tiled_copy_data.src_x            = params.src_x;
+	lsdma_data->u.tiled_copy_data.src_y            = params.src_y;
+	lsdma_data->u.tiled_copy_data.dst_x            = params.dst_x;
+	lsdma_data->u.tiled_copy_data.dst_y            = params.dst_y;
+	lsdma_data->u.tiled_copy_data.src_width        = params.src_width - 1; // LSDMA controller expects width -1
+	lsdma_data->u.tiled_copy_data.dst_width        = params.dst_width - 1; // LSDMA controller expects width -1
+	lsdma_data->u.tiled_copy_data.src_swizzle_mode = params.swizzle_mode;
+	lsdma_data->u.tiled_copy_data.dst_swizzle_mode = params.swizzle_mode;
+	lsdma_data->u.tiled_copy_data.src_element_size = params.element_size;
+	lsdma_data->u.tiled_copy_data.dst_element_size = params.element_size;
+	lsdma_data->u.tiled_copy_data.rect_x           = params.rect_x;
+	lsdma_data->u.tiled_copy_data.rect_y           = params.rect_y;
+	lsdma_data->u.tiled_copy_data.dcc              = params.dcc;
+	lsdma_data->u.tiled_copy_data.tmz              = params.tmz;
+	lsdma_data->u.tiled_copy_data.read_compress    = params.read_compress;
+	lsdma_data->u.tiled_copy_data.write_compress   = params.write_compress;
+	lsdma_data->u.tiled_copy_data.src_height       = params.src_height - 1; // LSDMA controller expects height -1
+	lsdma_data->u.tiled_copy_data.dst_height       = params.dst_height - 1; // LSDMA controller expects height -1
+	lsdma_data->u.tiled_copy_data.data_format      = params.data_format;
+	lsdma_data->u.tiled_copy_data.max_com          = params.max_com;
+	lsdma_data->u.tiled_copy_data.max_uncom        = params.max_uncom;
+
+	result = dc_wake_and_execute_dmub_cmd(dc_ctx, &cmd, wait_type);
+
+	if (!result)
+		DC_ERROR("LSDMA Tiled to Tiled Copy failed in DMUB");
+
+	return result;
+}
+
+bool dmub_lsdma_send_pio_copy_command(
+	struct dc_dmub_srv *dc_dmub_srv,
+	uint64_t src_addr,
+	uint64_t dst_addr,
+	uint32_t byte_count,
+	uint32_t overlap_disable)
+{
+	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
+	union dmub_rb_cmd cmd;
+	enum dm_dmub_wait_type wait_type;
+	struct dmub_cmd_lsdma_data *lsdma_data = &cmd.lsdma.lsdma_data;
+	bool result;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.cmd_common.header.type     = DMUB_CMD__LSDMA;
+	cmd.cmd_common.header.sub_type = DMUB_CMD__LSDMA_PIO_COPY;
+	wait_type                      = DM_DMUB_WAIT_TYPE_NO_WAIT;
+
+	lsdma_data->u.pio_copy_data.packet.fields.byte_count      = byte_count;
+	lsdma_data->u.pio_copy_data.packet.fields.overlap_disable = overlap_disable;
+	lsdma_data->u.pio_copy_data.src_lo                        = src_addr & 0xFFFFFFFF;
+	lsdma_data->u.pio_copy_data.src_hi                        = (src_addr >> 32) & 0xFFFFFFFF;
+	lsdma_data->u.pio_copy_data.dst_lo                        = dst_addr & 0xFFFFFFFF;
+	lsdma_data->u.pio_copy_data.dst_hi                        = (dst_addr >> 32) & 0xFFFFFFFF;
+
+	result = dc_wake_and_execute_dmub_cmd(dc_ctx, &cmd, wait_type);
+
+	if (!result)
+		DC_ERROR("LSDMA PIO Copy failed in DMUB");
+
+	return result;
+}
+
+bool dmub_lsdma_send_pio_constfill_command(
+	struct dc_dmub_srv *dc_dmub_srv,
+	uint64_t dst_addr,
+	uint32_t byte_count,
+	uint32_t data)
+{
+	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
+	union dmub_rb_cmd cmd;
+	enum dm_dmub_wait_type wait_type;
+	struct dmub_cmd_lsdma_data *lsdma_data = &cmd.lsdma.lsdma_data;
+	bool result;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.cmd_common.header.type     = DMUB_CMD__LSDMA;
+	cmd.cmd_common.header.sub_type = DMUB_CMD__LSDMA_PIO_CONSTFILL;
+	wait_type                      = DM_DMUB_WAIT_TYPE_NO_WAIT;
+
+	lsdma_data->u.pio_constfill_data.packet.fields.constant_fill = 1;
+	lsdma_data->u.pio_constfill_data.packet.fields.byte_count    = byte_count;
+	lsdma_data->u.pio_constfill_data.dst_lo                      = dst_addr & 0xFFFFFFFF;
+	lsdma_data->u.pio_constfill_data.dst_hi                      = (dst_addr >> 32) & 0xFFFFFFFF;
+	lsdma_data->u.pio_constfill_data.data                        = data;
+
+	result = dc_wake_and_execute_dmub_cmd(dc_ctx, &cmd, wait_type);
+
+	if (!result)
+		DC_ERROR("LSDMA PIO Constfill failed in DMUB");
+
+	return result;
+}
+
+bool dmub_lsdma_send_poll_reg_write_command(struct dc_dmub_srv *dc_dmub_srv, uint32_t reg_addr, uint32_t reg_data)
+{
+	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
+	union dmub_rb_cmd cmd;
+	enum dm_dmub_wait_type wait_type;
+	struct dmub_cmd_lsdma_data *lsdma_data = &cmd.lsdma.lsdma_data;
+	bool result;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.cmd_common.header.type     = DMUB_CMD__LSDMA;
+	cmd.cmd_common.header.sub_type = DMUB_CMD__LSDMA_POLL_REG_WRITE;
+	wait_type                      = DM_DMUB_WAIT_TYPE_NO_WAIT;
+
+	lsdma_data->u.reg_write_data.reg_addr = reg_addr;
+	lsdma_data->u.reg_write_data.reg_data = reg_data;
+
+	result = dc_wake_and_execute_dmub_cmd(dc_ctx, &cmd, wait_type);
+
+	if (!result)
+		DC_ERROR("LSDMA Poll Reg failed in DMUB");
+
+	return result;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index ada5c2fb2db3..178a71e3b7dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -248,4 +248,59 @@ bool dc_dmub_srv_ips_residency_cntl(struct dc_dmub_srv *dc_dmub_srv, bool start_
  * @output: Output struct to copy the the residency info to
  */
 void dc_dmub_srv_ips_query_residency_info(struct dc_dmub_srv *dc_dmub_srv, struct ips_residency_info *output);
+
+bool dmub_lsdma_init(struct dc_dmub_srv *dc_dmub_srv);
+bool dmub_lsdma_send_linear_copy_packet(
+	struct dc_dmub_srv *dc_dmub_srv,
+	uint64_t src_addr,
+	uint64_t dst_addr,
+	uint32_t count);
+bool dmub_lsdma_send_pio_copy_command(
+	struct dc_dmub_srv *dc_dmub_srv,
+	uint64_t src_addr,
+	uint64_t dst_addr,
+	uint32_t byte_count,
+	uint32_t overlap_disable);
+bool dmub_lsdma_send_pio_constfill_command(
+	struct dc_dmub_srv *dc_dmub_srv,
+	uint64_t dst_addr,
+	uint32_t byte_count,
+	uint32_t data);
+
+struct lsdma_send_tiled_to_tiled_copy_command_params {
+	uint64_t src_addr;
+	uint64_t dst_addr;
+
+	uint32_t src_x            : 16;
+	uint32_t src_y            : 16;
+
+	uint32_t dst_x            : 16;
+	uint32_t dst_y            : 16;
+
+	uint32_t src_width        : 16;
+	uint32_t dst_width        : 16;
+
+	uint32_t rect_x           : 16;
+	uint32_t rect_y           : 16;
+
+	uint32_t src_height       : 16;
+	uint32_t dst_height       : 16;
+
+	uint32_t data_format      : 6;
+	uint32_t swizzle_mode     : 5;
+	uint32_t element_size     : 3;
+	uint32_t dcc              : 1;
+	uint32_t tmz              : 1;
+	uint32_t read_compress    : 2;
+	uint32_t write_compress   : 2;
+	uint32_t max_com          : 2;
+	uint32_t max_uncom        : 1;
+	uint32_t padding          : 9;
+};
+
+bool dmub_lsdma_send_tiled_to_tiled_copy_command(
+	struct dc_dmub_srv *dc_dmub_srv,
+	struct lsdma_send_tiled_to_tiled_copy_command_params params);
+bool dmub_lsdma_send_poll_reg_write_command(struct dc_dmub_srv *dc_dmub_srv, uint32_t reg_addr, uint32_t reg_data);
+
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 479db84fcdc2..c627093bb849 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -131,6 +131,7 @@ enum dmub_window_id {
 	DMUB_WINDOW_7_SCRATCH_MEM,
 	DMUB_WINDOW_IB_MEM,
 	DMUB_WINDOW_SHARED_STATE,
+	DMUB_WINDOW_LSDMA_BUFFER,
 	DMUB_WINDOW_TOTAL,
 };
 
@@ -579,6 +580,7 @@ struct dmub_srv {
 
 	enum dmub_srv_power_state_type power_state;
 	struct dmub_diagnostic_data debug;
+	struct dmub_fb lsdma_rb_fb;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 5f827104b4f8..b17a19400c06 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -68,6 +68,9 @@
 /* Default indirect buffer size. */
 #define DMUB_IB_MEM_SIZE (1280)
 
+/* Default LSDMA ring buffer size. */
+#define DMUB_LSDMA_RB_SIZE (64 * 1024)
+
 /* Number of windows in use. */
 #define DMUB_NUM_WINDOWS (DMUB_WINDOW_TOTAL)
 /* Base addresses. */
@@ -564,6 +567,7 @@ enum dmub_status
 	window_sizes[DMUB_WINDOW_7_SCRATCH_MEM] = DMUB_SCRATCH_MEM_SIZE;
 	window_sizes[DMUB_WINDOW_IB_MEM] = DMUB_IB_MEM_SIZE;
 	window_sizes[DMUB_WINDOW_SHARED_STATE] = max(DMUB_FW_HEADER_SHARED_STATE_SIZE, shared_state_size);
+	window_sizes[DMUB_WINDOW_LSDMA_BUFFER] = DMUB_LSDMA_RB_SIZE;
 
 	out->fb_size =
 		dmub_srv_calc_regions_for_memory_type(params, out, window_sizes, DMUB_WINDOW_MEMORY_TYPE_FB);
-- 
2.43.0

