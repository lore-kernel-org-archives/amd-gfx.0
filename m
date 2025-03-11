Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A5AC28B2E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 21:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F035C10E2B8;
	Tue, 11 Mar 2025 21:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cgLx1dHW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB61A10E2B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 21:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlijO3y4Prkdrp7ccFPTOpFp4bKg4aW/EYgMJo2or0HIGVcAJEaCIliqoNsQtVnDcq4NGOLj0yaeNQG4G4Ug5F/C/jFPccd+GBk8lzzSnWVZauwcfD1gC4rcM9KOXQHuIo+cVe7oF6Zk3YFBRXQmFVaRgQDVJROX2FRzB74rBJs8Pi8dXCIEg3oBpYYMpPEuwAg2Gx1QG7p3+6K4dvlwASCqcZj3FeQxhxe6VDk5i0mZwxVBUbqZDc2Bt5dH1WWNzqHSOS2B1zoKGwe2u4/dixFA8Qpjs7cY5DAlMylSZZDtasSYgewEG9dj+OGH/HBfxD0mFWLIoihzeYZadFRbrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0m8h1dBRFjyXHjcvpsxwjOxiiEfVYGINqPKKa5OVsE=;
 b=ZrKDGP8qksUX0/QSj/0Y0e+J/ORrapqwpX0Zfo59CFg9lONB4xKU7yp5PEyeqGu9RjMlIdCxVf0tk/Ky4KoHvsUBwA0lkuaDtN4lv0MjE8c+gUDJEY4lBXdXrmR5MxCld3BYuSGYbo1Cp6NY5YwpVMwrGNKqWxJC/1+Lfilr1Ww3vVyhYXH2rjDlLK8KxYUf4bkzyhj2ux0FtUEPxzUi5RlP64KvtpL/sFt+4s+3x1iz9tcDS+H3EIUUedIWKGSbMzKVqWmQKOxWAMxFDDz1BRVSJzA6KLALDgUQtR7jaOIpuhku1b0Dm0GpCtPqI1JjNcmnwVawLJvJ9y66m1q5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0m8h1dBRFjyXHjcvpsxwjOxiiEfVYGINqPKKa5OVsE=;
 b=cgLx1dHWckneX2tVdU5oWvlQ5j/Y6eEaazjbkA74vlMLynuovyA0drBUaoMVBqGpxB0dGv20voCEr7fJOOE0izWFaZjStpntiWLG9RwQWtad0rA/QmiJkB454PeS7OzLkUCQuxSpH1kZE6Qs77rdr5+VIFD/wO6lNNk3pxfX2xo=
Received: from MN2PR20CA0005.namprd20.prod.outlook.com (2603:10b6:208:e8::18)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 21:49:06 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::e3) by MN2PR20CA0005.outlook.office365.com
 (2603:10b6:208:e8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.24 via Frontend Transport; Tue,
 11 Mar 2025 21:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 21:49:05 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 16:49:03 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 01/11] drm/amd/display: Check pipe->stream before passing it
 to a function
Date: Tue, 11 Mar 2025 15:42:02 -0600
Message-ID: <20250311214618.3106637-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311214618.3106637-1-alex.hung@amd.com>
References: <20250311214618.3106637-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8e9323-25c3-44d6-d76e-08dd60e68b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ncS3EvNeBJ2hcaLBpuVq8LFX7KVfPUiKWA6deb1vqN13I/WjGcSmyTFJxRT5?=
 =?us-ascii?Q?0lHX3I95tDBfDbv7UyXsJO8LhRUldgHlPHFXkMbdASYH68jHJvUfiGJo3Ozf?=
 =?us-ascii?Q?YJXaBdhc3v3qOnSRMpux7JlzNyxO31IfuCGCroBbX9k1YP6TPOugXfnzvazG?=
 =?us-ascii?Q?XK6klPKdfXbwF3PxSa4HuyWQlqKOZHACojWGIyb0Rp+U5rrw01kRQll/gLL2?=
 =?us-ascii?Q?Is4iNp9Htp8rufSr/UHU8Fr38QSH36BtaQz/dcTXSUZNWqGVhCc4ZwgoWQ7y?=
 =?us-ascii?Q?SUED6wOJvanaAEHLYyYdOEQMy4xctYPHx+mt4ar+esV16WWvl+pfQ2eEPP2r?=
 =?us-ascii?Q?Qdc/1534l8D0LVCvud59ow3QM5BCCBKBNLq/Kmcfk1hdbv1/C0AnnsV0egdR?=
 =?us-ascii?Q?ET7Q6P/kQ4bEtb1gUeoWu0PQh37CkXkN8cWhZIc3Z3vnoeGgWax9r3oI4cR3?=
 =?us-ascii?Q?q2XxO4WD5M2sMX1FDLXI4oeEVmh7M22hf9wfHrjh4hkabdiWx+2z1pQ/dWWA?=
 =?us-ascii?Q?xF+ZXewwQp14cq48Y5CRaehTX7UgCqyvCewH9/3iTLt7qzXxYUu9JLWK4Bj8?=
 =?us-ascii?Q?Fa2uL0pZTcGLV7HH+yWdeVklTuBQYyXJ/tXCTHuvTKdmYcINnwpWmHctxn+P?=
 =?us-ascii?Q?dkYRp8LYSittwjc9KDfbTa2DGSEs1A9Qxh+z9V6FutHdXNWfQv9gsUbMW0/n?=
 =?us-ascii?Q?h3b9Qr6PbV15/xJQV1pGYL85ar6oiGBM7ktG0327CfJBcxBWVOogddQoheol?=
 =?us-ascii?Q?Kw88DkZUzsTUUiyzrD6SbsWWPEs7rFK8vJKheOIiFO1aKCxZ4XdkufyIr36B?=
 =?us-ascii?Q?V/9kJLSZ8kfanYe/gylqpm4ocwoh7MmMzNZbqrFPfoi2GWPnR8f8klUrv3XW?=
 =?us-ascii?Q?mmIB6UM7AriXt1qoxD7fyd8ofWLQGiOnqYfE0RCQ/pUSVr03tc8m/AG/aLLO?=
 =?us-ascii?Q?fXWylanwwIVgyIEPhqLZZLZDMuHKi6T3Hn83BCkESNATzzXrVq3o4JSnths4?=
 =?us-ascii?Q?hiXz4D4Fb8iACg/WUryJoOePuEEIYSfVZwKGIrbEaeKjHXHcGW9goYcsl0d6?=
 =?us-ascii?Q?YwEb6w+7V71mrJqsOUfjHzF4SNEebhLX/hWwaNx+UrqFAS8bruGedmi9k8xB?=
 =?us-ascii?Q?KwI4iyuiwLEexeTGQ3uQmtyeJNWOar+vHrT7IsEtjJW6PagTsIBltDMeFlMr?=
 =?us-ascii?Q?8Z4kuYbla+TfsfBWDcOvyz3tnIinfjyaprRGBggYTGavwtcMMu4y/RVJVF2f?=
 =?us-ascii?Q?y4gDB0i03unqTjUkhxntlHu24XJSOcMm8wxrIsD8p/Gq1jfYR/LiZ0MG97WS?=
 =?us-ascii?Q?XTef092NLtFberFT+0Pr/PKoYB0X+lnMmC4UcYKviRTjI5mlDKgt5sfkt4Yl?=
 =?us-ascii?Q?6NmSK7/MUwelH1xGe87SPl56qdO7fAhjRpWT/j3/Lu1JvdqgUc/8KF4Y+HfB?=
 =?us-ascii?Q?O8W1RzmrjKVZnrt8zJqlI3Oko6MPnaSMw9OiMcGeiaSGSg3LfOWT6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 21:49:05.6803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8e9323-25c3-44d6-d76e-08dd60e68b98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191
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

[WHAT & HOW]
dp_is_128b_132b_signal dereferences pipe->stream so it is necessary to
check it in advance.

Also fix erroneous spaces and move a variable declaration to top.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index af722519a1fa..142de8938d7c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -204,6 +204,8 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 		struct link_encoder *new_pipe_link_enc = new_pipe->link_res.dio_link_enc;
 		struct link_encoder *pipe_link_enc = pipe->link_res.dio_link_enc;
 		bool stream_changed_otg_dig_on = false;
+		bool has_active_hpo = false;
+
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
 
@@ -225,20 +227,15 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 		new_pipe->stream_res.stream_enc->funcs->is_fifo_enabled &&
 		new_pipe->stream_res.stream_enc->funcs->is_fifo_enabled(new_pipe->stream_res.stream_enc);
 
-		bool has_active_hpo = false;
-
 		if (old_pipe->stream && new_pipe->stream && old_pipe->stream == new_pipe->stream) {
 			has_active_hpo =  dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(old_pipe) &&
 			dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(new_pipe);
 
-		 }
-
-
-		if (!has_active_hpo && !dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe) &&
-					(pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) ||
-					!pipe_link_enc) && !stream_changed_otg_dig_on)) {
-
+		}
 
+		if (!has_active_hpo && !stream_changed_otg_dig_on && pipe->stream &&
+		    (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) || !pipe_link_enc) &&
+		    !dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe)) {
 			/* This w/a should not trigger when we have a dig active */
 			if (disable) {
 				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->immediate_disable_crtc)
-- 
2.43.0

