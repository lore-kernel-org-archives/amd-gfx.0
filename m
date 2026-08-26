Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F023C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9E3810E24D;
	Wed, 26 Aug 2026 23:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B4HtZEjM";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF4510EE34
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:17:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ld1N1RsSzu3ehMKq1X1223qCamjGmQSqGCXuALwsTwivGnWQI74zTuQskJOsnwPGSFy62xMSvkbVncd1d+2wnK0/fADdUgWmOxb+mpaNLsb0qasfA9Wa2Or26fHX2LR594eKaS+7zlX7YqjCQcesxlluiv+wP/GZWlemuief53de7Qlp/TAlsVPVFAsAv9OcR20IDEEZyl//W8KeZ05yIOCOVDtQoS76wvuIzV8ULjefDPjaIzVSFEdL/ybJYLsoPcd/c30m1v1HQ0BAHhLTTXnfB0uB2PuuzGPoka/WKgnxHMWDqPSDblBwqY6216e6ui58WBI5pmxltMMQNnLoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4X/W5onvy+Jl+EIEwusASA/SQLjTBxMlOgZEWJGAnQ=;
 b=eDrtEj9g8HbdKudl7WEYKVcp8LNBnG4HE1jU1GLHiTEL2h4/MMYNRnkqFLSnGfWuac4bliIFm+faOFpVlfqCS+QOvurYGoRKi47Tkp+b/mWoXzVkrg/Ovz8OJOgOaIqfYSNm8gTwQRfEVCcxR8HP4/NNpSnn4ixlWmvr5BQA1H+yUpwXu2WUoDozTw4Aqlt70/rrWGz3MdKphpZfyrmUZMsSpDlY+joCEFwRJ5XrSJkn969an5ci0/O97OCjz6c9wYDZnrB6xd/QzEixr4dBucI6AmwpCwpWFIU7SSjYsxLwsJr7Op7WeVZ5/+tm6fLPhHS5NS7tcTVwhkTEcbMMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4X/W5onvy+Jl+EIEwusASA/SQLjTBxMlOgZEWJGAnQ=;
 b=B4HtZEjMz8Lzz7x8lAY5uGeqNyeGKXLxgOG5qhFY12vTStMzTpD8X4ASbohTBX8ksJtkn6UjqgcbBrEMn4/QyWPSQEvwIXJ/LGI9F1Cd3AGou/+ULhInftxw6rcbDEJ7rB3HuIt38iLgL976o6gEyHzvAijmvx0f9/euKBrfnwk=
Received: from CY8P220CA0040.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::10)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 26 Aug
 2026 23:17:45 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:47:cafe::44) by CY8P220CA0040.outlook.office365.com
 (2603:10b6:930:47::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:17:45 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:17:40 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 06/59] drm/amd/display: Fix DCN5/6 DML2 compilation warnings
Date: Wed, 26 Aug 2026 17:04:37 -0600
Message-ID: <20260826231519.881949-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bef8a0c-f728-46ce-efc7-08df03c83ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|11063799006|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: BeL8omS9dp0L2kDs4pIG3qfSXrHf0O0BtmQw9R795rkggalMcnj6BTsDDm9DCaPD2nJeZk/8XFl14DaQ2VHzyUAW63aDE+FzJ3PAoyYPvRK+Zk1r5sEH8gcPxC4PQ95WXfYdTcpC4yKWgFiGohP3W5XtqZ2S3f7qu6Xsl8r+inGMdfJrFMK7Gx14jjcaJFSO5IKFINbgzRBb4WPkXHz0DFXAqQfcjetflK23DLl2c7hXY9GIPfD4D9A2CDbub+KN8DVqWhARZDiKdiKRONos767MyqIlLY4M6MCQrblhQeohD446ou/MgJVoPVzf5pOiWr1t5ZAylGNhhmyAGrwYvx6y0RN9tJTO49c/gwx44CcvurPYJgkTZopgSuh0aqDipoC5dnj9FEP/6vkS4ydou6msD9YLdFvyCf/71UbmzVpwdTwyVxxfH23RISzafOuJLbIXomg7XY9EiACFMTxC7p0jFOJo5lBohezIbekpxO+rmUtLdyLYpDMuns/pxMKc7E7rUFD7fro+XerOsfooX7DHi4manlUY+KLbQQzLqA6nE52GrSlrAkujFcY3zi0AfNmSTOZfEELAQM8S/NQL3+RXmDUTFGbVC+qsgj+jzRInZJ8OogDpj+NWp0DapNCBqPzrptb6juGA/dok5TVBUFlof9+bSJBTveSPSHk/v8n6MGf1uqXBKD5w+yBW/pTUrZgGS57eITr8bugCKMPGdQ==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(11063799006)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bLA+fCXPRPcMX584tGMnE0yppAKajfxU5TpTY5vPqsHi/3FTaeZhZj8kTQXfeAdClc2klxVvpFK82csd1yMAdX1kr4uBKeYv/gL+MmX53JqHYkrQonIAvdBHxpIruEHBGToDG6npHI4QvevIA7l2WIrB9vRw+zeSt0AjiTEz5GdUa1YBumTBpkRT5kSDk8gbkmHICxx6KGhkHN8WxdwPxhZc6YikEWC4RriMebRR/gLhYSZUBGSYje6Vesd3OCiLV4GGqjujekSSFVoo0X6QjRunH54ORxe4W2r0tKJ0dI1RdcY4x65L/yfRXWUxZnjVLEkz/c/iXx+2w9YwVyc+VosWiBJYVMDfQSp8yGSQpr/VVW9+J1X/MsgTBeAZWFyNRPeFDkbTjk9W5ZRgTB0XzVuemwOYUilUyFS1buTP5w7Gvs3Chy1CqRzjrQ9sVdKT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:17:45.4522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bef8a0c-f728-46ce-efc7-08df03c83ca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737
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

From: Ivan Lipski <ivan.lipski@amd.com>

[WHY]
A kernel compilation warning was reported caused by upstream of DCN5/6.

[HOW]
Using plain integer as NULL pointer. Assign NULL to the
VActiveLatencyHidingMargin/VActiveLatencyHidingUs pointer members in
dml2_core_dcn5_funcs_mode_programming.c, and pass NULL for the pointer
arguments to calculate_first_second_splitting() in
dml2_pmo_dcn6_stage_optimizers.c.

Fixes: 7f7d7ea1fa51 ("drm/amd/display: Add new sources for DCN6")
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../src/dml2_core/dml2_core_dcn5_funcs_mode_programming.c     | 4 ++--
 .../dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.c
index 8497eaea012e..297e21e7c68d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.c
@@ -1128,8 +1128,8 @@ static bool dcn5_mode_programming(struct dml2_core_calcs_mode_programming_ex *in
 		CalculateWatermarks_params->USRRetrainingSupport = &mode_lib->mp.USRRetrainingSupport;
 		CalculateWatermarks_params->temp_read_or_ppt_support = mode_lib->mp.temp_read_or_ppt_support;
 		CalculateWatermarks_params->global_temp_read_or_ppt_supported = &mode_lib->mp.global_temp_read_or_ppt_supported;
-		CalculateWatermarks_params->VActiveLatencyHidingMargin = 0;
-		CalculateWatermarks_params->VActiveLatencyHidingUs = 0;
+		CalculateWatermarks_params->VActiveLatencyHidingMargin = NULL;
+		CalculateWatermarks_params->VActiveLatencyHidingUs = NULL;
 
 		dcn5_calculate_watermarks_and_dram_speed_change_support(&mode_lib->scratch, CalculateWatermarks_params);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c
index 0b884a8661c8..6d6611a6b5a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c
@@ -1414,7 +1414,7 @@ static bool find_shift_for_valid_cache_id_assignment(const int *mcache_boundarie
 		success = true;
 		for (pipe_index = 0; pipe_index < pipe_count; pipe_index++) {
 			if (!calculate_first_second_splitting(mcache_boundaries, num_boundaries, *shift,
-				pipe_vp_startx[pipe_index], pipe_vp_endx[pipe_index], 0, 0)) {
+				pipe_vp_startx[pipe_index], pipe_vp_endx[pipe_index], NULL, NULL)) {
 				success = false;
 				break;
 			}
-- 
2.43.0

