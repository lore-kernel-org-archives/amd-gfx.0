Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE65C54F30
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AD6A10E55F;
	Wed, 28 May 2025 02:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cptgWQ5T";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D7610E55F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:54:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwNTMJjYocZd3Y+pxe+tBgiuNtD9dibDnpq3IIcGSz+IC8ZYH1Qmi1mAE2rNQTuyU8cjwjQMVSh8GrBJbQftHWxvJoFlYOu3YDJfK52UvlCvfGt535lmIEddmP4WILfX8uClpGRpNstyGaEqiUMNM+Xydl1yNUFr00iyQ4aa9SKHBX79fJczNClH7D5sbb4oV7JCx62Fipw9x6+PyfbCzibH2/u6YALmMJP/HqTnjRvStZRtCMVmug19kGjJs4I5/fy2E8qjDmtvOcORFNh16QW9X2xJlS49lOkNaT9+YnqDdiF5KNs9zebGSk7Ng8OhOdqIjry+roiPuJPg2PaNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AE0d/3m84P78gnAidR8jHNniVgR01bV5NIvwQ4O+gNc=;
 b=E3C+gEPWBYj5L3bSn9kFoi6OyjQpOfz63uSmnb2ZHqEaMqhJ+hNhuFzhOgf/axTFcqbdjaLWrU+IIS/w26PdX4ACyb7GJzlISNmriQPzZIqO7+eR06L0rQXzM0kvhI8QFCMtU5Y9iyfZhNJ7ApAbI/bNDgtxLBOj+gWa+9uGrcA1/sMXaRE037zwtV/jRGDxcTpD51WCM27zchn1d77cpk4AmBNhInmzVjjUHwueD3PAaZCbgVO/jf8X4RyObqrZcxxAz5YY9mchCIDdrYjOL60u8J18LDZEbaxmhUlJDOau2zDPlt5EqYikToKkyOlemrFrf+U08t0ccdlx5eu9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AE0d/3m84P78gnAidR8jHNniVgR01bV5NIvwQ4O+gNc=;
 b=cptgWQ5TpCl2fm6ZSaDGRTQZL+SEz/0g9vt8sWx3YFj4uxcc2suAokz7fX3yU7Rnyr4r0+x5x264RSDnWamGGGUAO0gAMPPQpQJtSWu+ypc5uh5rro5ITZLm1FmaGwQbb8+iBlxx38pnUNZ0Pp4vf0g+27P8czRsdlwUX+oauhM=
Received: from CH0PR04CA0060.namprd04.prod.outlook.com (2603:10b6:610:77::35)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 02:54:07 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::4e) by CH0PR04CA0060.outlook.office365.com
 (2603:10b6:610:77::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 28 May 2025 02:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:54:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:54:06 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:54:01 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Zhongwei Zhang
 <Zhongwei.Zhang@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 20/24] drm/amd/display: Avoid calling blank_stream() twice
Date: Wed, 28 May 2025 10:49:15 +0800
Message-ID: <20250528025204.79578-21-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed408ac-4846-44f1-dabf-08dd9d92ea1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QpsbFgobRV9zkfhfi1svoRZccTDd2WdhSvhRHq/AzgHtaLoxqPLGc61You9H?=
 =?us-ascii?Q?IhCp4bUNzBZ9ChRVQNfOLjn2zkZFVk4VeiFwjIw8eSoGMev8pNsh81N9ILBa?=
 =?us-ascii?Q?FMZbTR6mF/kXqO7UJKDp0tjuayZQt3y+WP98eQ3REHiXc8Ohmz82JjCIJMYU?=
 =?us-ascii?Q?sCulUyvU4+hoCoqNJBtnf0AqJY69D1cqGoBsIa0glKYyKNRDg44VgpNdZpHF?=
 =?us-ascii?Q?AGDMGA4xVm1CPvs0wKuQ76Cf1zBr2vWL3AXDcRgEz+Qly2K/Engn+DD+qOpm?=
 =?us-ascii?Q?CG95zxaAo7zKtnrgCUITns/DQTMrhTgmhMIpnK4iNGbdjtN3Jy9sJQnAN/zg?=
 =?us-ascii?Q?NbRWTTzBTliy5Ex17faDQi6ferAW5MQOe+bcblXFHqG2n85pWXrwgj1NjEUa?=
 =?us-ascii?Q?ObcnoxlU31db0bXRXzrAm6XMChbzDSUKdaIrwBgHhvSRfGs7nKsHywuDhkHU?=
 =?us-ascii?Q?3ZAZ2tPmGqrFlQPr+O1lnCXmUIGv58w/gxP6Ay+vHYE43dpbwFKXvpC74QY5?=
 =?us-ascii?Q?HzZsV9fxic3DEOnfCChebf1Kvbg8VcNL3uWz5fTTG4zL9bUrFaXYn6yCeBXO?=
 =?us-ascii?Q?k2wQOypuAoPY1eVw5O3BnlQ+zZzRKB0v7KwAvP0SF4HoS2K/RtBveyWPHKSj?=
 =?us-ascii?Q?1x3OMiqEDXQh0Y76Q4yL7CJHUAl4CW+s//Y2w5fq7FsfnKtUknOf76ApDMEZ?=
 =?us-ascii?Q?9E2tZK9fgABg6oXI/NtAqKdWEHmH4f5wgZP8apudsJBG3Dder3vOyjSKzz/R?=
 =?us-ascii?Q?oMSQ2eBcFUYePcGmoyyzjWPJRq2G8pR5qheTy4btNCU0f/MS09VPfMkauWjA?=
 =?us-ascii?Q?lfcn7N/0dkwWvIw/ML403ehA1PC5zVXCgYe3jIpastOun8xtevnx7eRXs1NV?=
 =?us-ascii?Q?u/674zu4E6vPIzUKWN4zlUMMm9gzvH7ARQ+fGPsGZ5gF/k8y06QBaDNE0wH3?=
 =?us-ascii?Q?oYhvNKxqJV8hIZbIZhkG/80SGoa3OgB41Erkw8kmA6r8xUwuF2CmSph1jQgs?=
 =?us-ascii?Q?AfYd2iMme/iCbiCIvH+uocZy584i3wcKuKuVRMT7v25HkxuXiLuRLNtegimA?=
 =?us-ascii?Q?Wa5g4VreXEbAb+O0fgsrgZmsXnTWH1xvRUZe6/5YNAuAJNVyuWOb15arGlN8?=
 =?us-ascii?Q?fz9GQn/tnrj6wTMWsofnF0TrlYPrhRbV++1q73/yuXTKY4GbV+JTWvKH8V9y?=
 =?us-ascii?Q?WG/RlbGjT0rnVq2a9NoWYOdsYkY+7it+LplJex1ZIMxral3hP3sKVVrvMTJG?=
 =?us-ascii?Q?ppLxvnKZuJ29rPao4YBBzDbwYYXgeNHd0a6dAyZAIS9gFn40WlIVxLeD6KUR?=
 =?us-ascii?Q?Pxv+0JvVanO4Y2xslppVfLN+PGDFcz7Mq5bZv8jyuHKd+auCiUZ6y7Zoz9pr?=
 =?us-ascii?Q?2NUIFzosB6KGBh//wlwajYRGPwvzfEyndcoDqPvGS29YclmfNF2vJyI7228S?=
 =?us-ascii?Q?HGKfSOtXFVwcuRNcxGob2132Dydmxg3ny+/DfGFJnsK0aWGYzw06Zkkmzvp5?=
 =?us-ascii?Q?gYllDPEUtaVhvcKRec/LZFfFfyFGWn9nzcqR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:54:07.4463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed408ac-4846-44f1-dabf-08dd9d92ea1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
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

From: Zhongwei Zhang <Zhongwei.Zhang@amd.com>

[Why]
We've made fix for garbage in dcn31_reset_back_end_for_pipe(), adding
blank_stream() before disable_crtc(). And set_dpms_off() will call
blank_stream() again.

[How]
Add flag to avoid calling blank_stream() twice.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Zhongwei Zhang <Zhongwei.Zhang@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |  3 +++
 .../gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 11 +++++++++--
 .../drm/amd/display/dc/hwss/hw_sequencer_private.h    |  1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index a8174669bc49..b96b189e4a41 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1222,6 +1222,9 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 	struct dc_link *link = stream->link;
 	struct dce_hwseq *hws = link->dc->hwseq;
 
+	if (hws && hws->wa_state.skip_blank_stream)
+		return;
+
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
 		if (!link->skip_implict_edp_power_control)
 			hws->funcs.edp_backlight_control(link, false);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index f38340aa3f15..5ba3999991b0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -526,9 +526,15 @@ static void dcn31_reset_back_end_for_pipe(
 
 	link = pipe_ctx->stream->link;
 
+	if (dc->hwseq)
+		dc->hwseq->wa_state.skip_blank_stream = false;
+
 	if ((!pipe_ctx->stream->dpms_off || link->link_status.link_active) &&
-		(link->connector_signal == SIGNAL_TYPE_EDP))
+		(link->connector_signal == SIGNAL_TYPE_EDP)) {
 		dc->hwss.blank_stream(pipe_ctx);
+		if (dc->hwseq)
+			dc->hwseq->wa_state.skip_blank_stream = true;
+	}
 
 	pipe_ctx->stream_res.tg->funcs->set_dsc_config(
 			pipe_ctx->stream_res.tg,
@@ -570,7 +576,8 @@ static void dcn31_reset_back_end_for_pipe(
 			pipe_ctx->stream_res.audio = NULL;
 		}
 	}
-
+	if (dc->hwseq)
+		dc->hwseq->wa_state.skip_blank_stream = false;
 	pipe_ctx->stream = NULL;
 	DC_LOG_DEBUG("Reset back end for pipe %d, tg:%d\n",
 					pipe_ctx->pipe_idx, pipe_ctx->stream_res.tg->inst);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 09bc65c2fa23..1e2d247fbbac 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -49,6 +49,7 @@ struct hwseq_wa_state {
 	bool DEGVIDCN10_253_applied;
 	bool disallow_self_refresh_during_multi_plane_transition_applied;
 	unsigned int disallow_self_refresh_during_multi_plane_transition_applied_on_frame;
+	bool skip_blank_stream;
 };
 
 struct pipe_ctx;
-- 
2.43.0

