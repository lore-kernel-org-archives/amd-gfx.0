Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC49C36003
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 384B910E564;
	Wed, 19 Mar 2025 17:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xSXVLLZd";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FDAC10E567
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpEd+Mt5r1aLk/uzXUVJnXh/kH+pFv1peB4ZgqJzaqEUvpexBDSm2+dJNOqrHIw3RWS/YF0AxtDjq1NLXqPcq3NexPJJHd7Q8cnDpjrZqo9oh9r1wN+99vRR4XdZwzSF1hvimD451gXXP8nPy6uxAndMqsLWwBbG26QJ3L3gTcTAF/gTIeOLS+cPRmvI2U1mozQ6MD+deWc1mJDWc/sjS0uePiFLe4DvK3kqLofx0Zwrjt5vixJCNQGEMyVSbImn5AKHquhOSfxanjdHj0gF++LuBf4j65Wtbo6UFOXcg9gjVmNFC3MXj0PlQK30Ib15Gm4PCaZ35XtZ5S4NN70ONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YlkuvjEPfJE/oRYjvDKE2y4fs1AlzcX/cWIZptS/b4=;
 b=SHwnF4N+XgfCaXTlQbkFT4Ha/z4jXXMUdTxa9RdsOSs4ZfyYpieiljnRCw3b/H5ewPmtw5QTjYtaz67KnoFjhdkjvUgn0riMN2ZWzxOfVBvFwO7JeB34MVjAJdaf37XnqDHZq1Xl0NPPhNY1XR9VkT9/BasOjdWxfcpaqoibVlmlp2kX9OeWwBndQxyrPgqLfOgdi0DCZmqPtJRDP5vi/pVteD812a+wrFQIAYoLs/i48wut21xMiQC8s298jl5neWRT6BNA8AaLLxSf93QjxIoweLoaleEhyfwp3hRVR8C+QC2ghO8vuhlz86XpOzmj3RdoxXv6QRMtfZrR01C0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YlkuvjEPfJE/oRYjvDKE2y4fs1AlzcX/cWIZptS/b4=;
 b=xSXVLLZdCMMZRR7KVHYj3PyOWEF/xyoaX/n4jCGluxjQH1JH5tmdFZpCRlz5F3r6QmHIEqH5Ia4mKLwPbHBFkU7p7y4PwAwr9+JQnR7EqLcl5Sm2YsDkhATulWy9k29RZQt2WHNHFLlpzI3z3TyWHmFfhOguD+k7X1Cehv5ugL8=
Received: from CH0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:76::18)
 by SA5PPFD8C5D7E64.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 17:57:25 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::d3) by CH0PR04CA0013.outlook.office365.com
 (2603:10b6:610:76::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 17:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 17:57:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:23 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:23 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Paul Hsieh <Paul.Hsieh@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 07/16] drm/amd/display: Skip to enable dsc if it has been off
Date: Wed, 19 Mar 2025 13:55:12 -0400
Message-ID: <20250319175718.2578234-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA5PPFD8C5D7E64:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6e430a-d318-45b1-0d1c-08dd670f818b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FrvEfRLe7c7r8IPg08cz3eYak3y/gVHKp+qq8DCsHQq+4JyBpk3Dl1xfpLmV?=
 =?us-ascii?Q?42QnI/M933bgqm4bB2yIMfpkaXkuUgTEqmUa6O6l11t1iIlSg178zGqCp0ia?=
 =?us-ascii?Q?t/fGBvL5KVZlNiKOwnettSuN0vhb4X8+FZWw64y06odD6OGLRchJiUh4Ly8+?=
 =?us-ascii?Q?572fzMV6sTD731B9/r99OwhH5sOJ6Eu5NCDkQUNEbxqYZiXnd/Fb+lKMeHVQ?=
 =?us-ascii?Q?Qo0UFx4L+tzsL8N+r0OnleSi4t+sbuWcmv9z4fZX4NTfrQbnSoTsKkoM+570?=
 =?us-ascii?Q?StnEOX4jXGN6vuIeL6lRWGx8S4GEjf1UD2nucP4H5R/eqi5kAwd6yOeHhVJU?=
 =?us-ascii?Q?H3aLyR3gGXP54MC5hO7hto6ErksC1NkhQFvw6+YrcWwbJ1qG+XSFgYbWEFxE?=
 =?us-ascii?Q?i1PDIsh1Rt36RxQPreZvHFPIqrJAOD8Paix01t6s9cRAPucbiazvRtn1poch?=
 =?us-ascii?Q?BDFtxlhocVMCPMYSt2UHrKK4k1cM4W+a/ARY2sVEHBxUy4AFmXPxE4gSNiNe?=
 =?us-ascii?Q?EQk2GxPhjtTUuHvZISEjhL2DN/b0OGeC0Ce3gFP7rhLd9JyacWupGF/x9mQW?=
 =?us-ascii?Q?k6OadAeHV9HoYKfPUnc6/P+R9pLvp+vHwYNI0dLZwC+GsE1YTDC5+Nrt9qqW?=
 =?us-ascii?Q?4YH/2dq1jqoBxhxemTvaXEXO0gJGQtImFxmjy//JWE22tO8oYm7gHCX8LE7y?=
 =?us-ascii?Q?DXMmpaZjBLxHy9yV5tkfgOPDMQxL2Eq8zcJyGfMhW+hcuvhNRhwzNlntJtSE?=
 =?us-ascii?Q?EosA/gmcPaarg8nDWvzo4TQPlt2gJrqzFlacCQ88BJTdrUythgFiRqaRUvK+?=
 =?us-ascii?Q?TjEb3d4w80/JKser4HwmqkzaablLuNYkYNlLiFCkH6TqqYHKfOfo/+/tWwb5?=
 =?us-ascii?Q?nRoGAkXOJP7OmBeURtlazoY+Jw2B/lbuJGvJ6aCvpYZMkvW6Q4XLrwYQURz5?=
 =?us-ascii?Q?ggFAnxEL7kd91i9qI8z4zFYXYCh/AOtAZzceFHaaiD6S4bBSdr6MCnMutQeN?=
 =?us-ascii?Q?FOixePDcV690gGpIrdDwKcodfei7dvStRtrju0MGy+TOeZMRnc0KYJGLbM0N?=
 =?us-ascii?Q?Fy3eF7NaqZz71XPuBZOqMX93G6Yr/Ry6Sy9Err5ZhL4TsTd3D0mA8/b0GHQy?=
 =?us-ascii?Q?va9L2NQWx8bNU09hVE+jmVy9onkVoMJDgu7fXe4Uj2OteIfMk7grl35jXnK9?=
 =?us-ascii?Q?4J0DTzM3hlaFrg4aBiCHmD72BqiXY3uN9Tamjs3XeSxbtafh7vGR3i9KpWGi?=
 =?us-ascii?Q?JyIwmtJwJZurmjraXpLM+rxj2ixultu0qmfc4NfRFWkqk173RG+yJRBffe6e?=
 =?us-ascii?Q?zWq50sTSir+DQiLR/XIdkQjBIA1YyFP/mXrNzpuJbH0M3agVdg8+Cbzt9RZ1?=
 =?us-ascii?Q?eeOUFGCE8+XdL9IUVkQtvU48in9qHAqz0gqCOTbxiCwjrVLKrGhTK/sgIel4?=
 =?us-ascii?Q?PVjfMrNUgx+X5GHWG7m4C2dNH5gvx1OVP4xB0c3s/+ef8oC1ExfVWC5YO/8+?=
 =?us-ascii?Q?+MZh4HERKa6v/ts=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:25.1241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6e430a-d318-45b1-0d1c-08dd670f818b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD8C5D7E64
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

From: Paul Hsieh <Paul.Hsieh@amd.com>

[Why]
It makes DSC enable when we commit the stream which need
keep power off.And then it will skip to disable DSC if
pipe reset at this situation as power has been off. It may
cause the DSC unexpected enable on the pipe with the
next new stream which doesn't support DSC.

[HOW]
Check the DSC used on current pipe status when update stream.
Skip to enable if it has been off. The operation enable
DSC should happen when set power on.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Paul Hsieh <Paul.Hsieh@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index be26c925fdfa..e68f21fd5f0f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -84,6 +84,20 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		struct dsc_config dsc_cfg;
 		struct dsc_optc_config dsc_optc_cfg = {0};
 		enum optc_dsc_mode optc_dsc_mode;
+		struct dcn_dsc_state dsc_state = {0};
+
+		if (!dsc) {
+			DC_LOG_DSC("DSC is NULL for tg instance %d:", pipe_ctx->stream_res.tg->inst);
+			return;
+		}
+
+		if (dsc->funcs->dsc_read_state) {
+			dsc->funcs->dsc_read_state(dsc, &dsc_state);
+			if (!dsc_state.dsc_fw_en) {
+				DC_LOG_DSC("DSC has been disabled for tg instance %d:", pipe_ctx->stream_res.tg->inst);
+				return;
+			}
+		}
 
 		/* Enable DSC hw block */
 		dsc_cfg.pic_width = (stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
-- 
2.49.0

