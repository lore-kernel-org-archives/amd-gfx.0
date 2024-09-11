Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCBFEE57C1
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1058010EA5D;
	Wed, 11 Sep 2024 16:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="agRtj5Xd";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED52B10EA5D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItPcvSRvOTkuPbyzivqt1EGBdgWiwoxFGTjjfQKKaI5qOsRKaN1KaCYiSB06gBzr0h+hEhmcmyguwBFdWdxRRZI3IlVSu1HdzIGO+xv+4pibqu9LllX/8TdUk4iB1o2wOei6tFusS/qS2nh9s6YbYrYSsPDjkpFwJWGxIKYc9dAiWlo+i5RettCGPEC1c0WCX+V4D++CBEd0hsHDe0O+TiE37k6nBrE0zKTadNs/WZat1a9miZSE/VzBPlcs3UiOhwOLmxftO/dRDLNbX93gWvPqqiP4ZV2S39+ckl9gxyY/y076bZR0Eo/TKPRYjjqKODmjpHMmptfMjTCwntSLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fectndtn7wSRK+L0sDyGU7jbZv+NpNx1dBhr6SRnMTo=;
 b=lJbNkHEHx1g3l+rLnAozNDrN3XwFABBpNFM2CJ+xnsYUwZpHaPktl9YaWYSz+utBKOzSC+VuW/BURbwgzK6AlFttJHiEOJpbqybyEqdkHGl9bAvodl+S013IXI875yDSry/kJG/tWv9sKTb+VVwm4QZk5Fjvgf+PHPbeBbl/TKfOCPjr9PIvutPKv6FmAEUNs06cM8FN28/ZDKn+oKI9nSk4E1OZSErHu70ib58vZooJNeHqi7dO1frt1yAArLgJRBK8k5GrMwwB3ZmqEYjiUZ27ogIN19xcsA9rnas3xUQWVxAIMgQm70PIYMGNPZyP0EdBHIKaFl2bub7IioDsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fectndtn7wSRK+L0sDyGU7jbZv+NpNx1dBhr6SRnMTo=;
 b=agRtj5XdXWWQzxCseG7qATT6nKGDgMuno9zA7nkl17F0bdpuXhdX1xYCPFsN1uRX8Qr0XhpS0r1iyzAzT06CsaYhSEl0yVemv+gwWoew7CMdSIgN/wElOfMKeUf/y2oa34j4v+Z8YgXS7t53l+GwjPqvXC527AyVJ2Ni7ou37nw=
Received: from CH2PR14CA0040.namprd14.prod.outlook.com (2603:10b6:610:56::20)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Wed, 11 Sep
 2024 16:26:03 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::fc) by CH2PR14CA0040.outlook.office365.com
 (2603:10b6:610:56::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 16:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:26:02 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:25:59 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Zhikai Zhai <zhikai.zhai@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Wenjing Liu
 <wenjing.liu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 19/23] drm/amd/display: Skip to enable dsc if it has been off
Date: Wed, 11 Sep 2024 10:21:01 -0600
Message-ID: <20240911162105.3567133-20-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a09970-b8d7-4bb7-2d6a-08dcd27e6dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pkWFNeo6y1BBpF9GB6d+lw57zhpF8K+vcHQdMmanPiai2kWNat4mk8OMLyvK?=
 =?us-ascii?Q?+8HD2qNH1ul2Rdvua47MzR7Y+JiQywWv0Nk7J+0FvERiO7KsLm4ps3B08Slr?=
 =?us-ascii?Q?W4NpMxbLuwx+a+mdpVXZfFQDM5nxvoSuBG9h2c+j4+hM8AopC5F6oFI9B+Bc?=
 =?us-ascii?Q?Lz8X/evmiNURqMEteyypkYmlq/cBAgSEdkTlVXlKwiBX54iJAGp2/pSVxMAX?=
 =?us-ascii?Q?qjaz+iKtpC8LOQw7uE13FGFAe+1yW2s2zqhKpZK6ziGWz4VlKRXddsL7MNds?=
 =?us-ascii?Q?9vE2rKujn5R1UIRp50jlonDJxlwVgz936SIXowGpyACRKCBvJnlKdhr1M/dz?=
 =?us-ascii?Q?5mWBHBpKaRZ2VJj8BnPWRPV0TYAHtboPkMLUq0KIH+wfWwbpIiOfo92BFhQJ?=
 =?us-ascii?Q?F7A7nQ4rkGeTZW0GUmdLVhuORqJM1dNqwSQPfK/VHKVP9qM9vC6QI79iI/B0?=
 =?us-ascii?Q?tTisTD+1wf1ISzihWph9bfJ2WADKHwbwarMmIhunDmUPs9gwoHo69HAY65dA?=
 =?us-ascii?Q?yL/O5aIPn+ZxMINFrsvyYLcYWTk3Y2iHNBGGlXwzXff5jN+2/CXyh26uSKv+?=
 =?us-ascii?Q?0Opb38ryAOzzSnLB72CwvVasCUelD3asrbjmGSIVAva0HOX0Azocbm1JrLx1?=
 =?us-ascii?Q?vOTASsnRdRiicJTFbwP9j7akahl1b7JXCQ5pHzJh10tx6MIHs/XGZV94mz2/?=
 =?us-ascii?Q?WX+PwtrjmzDwYyxMZL7FBhQvhMwH8FLEmzbZ6Bid99tK0tNk1iYPXjvU8w8v?=
 =?us-ascii?Q?i0+tUvph7eDWRIo08zScWfiw1V3i3vevGQJHmg6V8pDL8BskXWwVITYX5k6l?=
 =?us-ascii?Q?Un82VtJ/78UF4l4dqb6zqfuj3gpKBdQTVARk0njHAYG/N523Lwt3uXhXcw8I?=
 =?us-ascii?Q?h6BfWDA0QwaXCvAZMIOMG9iTtoZJtv8ewkrriRSK8Cfv/soTTIGaXKzX0kGd?=
 =?us-ascii?Q?tyQKNkmFGgAkhNjC2P26uqq/NpFWbsrjcmuzfg2N1FygGUylCfyKVnoQOlyr?=
 =?us-ascii?Q?niGUPFEOHyONmRvDwhezgjqU4Ln2W7axvqlJfl21LnDBUg2gnaTiXFajICq2?=
 =?us-ascii?Q?M4vLBBtkZCEaJMuiqkj9fhrifkve+5K1DyvPTTTw/IvTw8oD90T6MAnjbJPU?=
 =?us-ascii?Q?io4Bxt8XvZJHTm0ngw3Vcg3yXskwLwoOuD2PR4XnbQucfF1k+h+qtMTq/+si?=
 =?us-ascii?Q?x9PqtMBsxP0Yf2LNRHjSwHnAvJAqC0HoTPcRwFZH8HWscfKRytpS8jY56FLA?=
 =?us-ascii?Q?HqOemENAGTclYMLE/WQlnsqQDcOHVCeDoC/fCSM0xAA0gM5/ri3sa8Uj0lts?=
 =?us-ascii?Q?ispdpZlii+eiPtP77s0dn8depmeHVSOKgbvmmjqaSSHsp9f9wO7qee7kTE+2?=
 =?us-ascii?Q?dHUXEKgS0nNnOhI5L/XjiSsbSNHZdh/i6PHTY79h/YgWggCQkm+HkcC6GX40?=
 =?us-ascii?Q?ezNq3qthd3fv7sM2IJFLTtvPJDayofwU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:26:02.7878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a09970-b8d7-4bb7-2d6a-08dcd27e6dbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
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

From: Zhikai Zhai <zhikai.zhai@amd.com>

[WHY]
It makes DSC enable when we commit the stream which need
keep power off, and then it will skip to disable DSC if
pipe reset at this situation as power has been off. It may
cause the DSC unexpected enable on the pipe with the
next new stream which doesn't support DSC.

[HOW]
Check the DSC used on current pipe status when update stream.
Skip to enable if it has been off. The operation enable
DSC should happen when set power on.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    | 14 ++++++++++++++
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    | 13 +++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index a36e11606f90..2e8c9f738259 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1032,6 +1032,20 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
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
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 479fd3e89e5a..bd309dbdf7b2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -334,7 +334,20 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		struct dsc_config dsc_cfg;
 		struct dsc_optc_config dsc_optc_cfg = {0};
 		enum optc_dsc_mode optc_dsc_mode;
+		struct dcn_dsc_state dsc_state = {0};
 
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
 		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
-- 
2.34.1

