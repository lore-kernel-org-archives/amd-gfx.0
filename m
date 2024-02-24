Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A714C5478C
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Feb 2024 06:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C860D10E175;
	Sat, 24 Feb 2024 06:40:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nbc/5+g6";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C73E10E175
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Feb 2024 06:40:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQ4Kv1yPdZWdlXYPyUMjfhfMDGuwOToUKWQJuGZEi5fpqLCg29+KVHOhlKjkbL8NlbPvxkqBCL4oKEcg6FVSH/3IPgqRHG7AzhUphD8V5bHxcRTT+/Gzc0ZFbFio2JByh+VjDVhM27aocnkEFdz8nMu3yRT4fJF4lWZ8OTSfKLQ85BffYhHBELx2JMJNeHPVjy9/eVKT5r8kvgbOpPDiBpVELixNEf1C9XeYbN/RxbKCnmqfn54JGWtj0JhbUwi8UU60TCdfrUDEVR2pS0fA6Gpt4ZOZD2EiED1FtA/jJjjajdg7Vecjnk9B2rQiR+dNwEZ2Au6r7PDQCAHj4jt3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb7D5hTnl31xq+6WYnl9bHPe+xIhi6+ae9DffYY4ZZE=;
 b=B/Q5whSLxRJN9HGiBb2mqmy6/AAGuL1UO3LGP9uosBnXVGvczLKspxOmmfuSa03vHWJL3nfFsn1wPlpVvDZMBZViYVOUgJyxYCYDItjYQO6nEi/fzsbRANNqxp1jwCkbI1SEjb7MeKXH0e+l3CsHMz4TWAJ1pWJso9CFWA9TQh0RAQCjSlVVR0V0XyUYipUYmaKiGCyxRM5YaH8S3qgLjiC9PhOK+9lny6uBonZ3vVaJsB61F4GoImNYnZHOsQfTPe9A5JTih5iDgF/hPzPYzoSzr51AOB/AT8Fwxbk88/VYt9oWQdTEGRKLmnRam/BSXKyoDTbP7qK1gfuqfuIyaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb7D5hTnl31xq+6WYnl9bHPe+xIhi6+ae9DffYY4ZZE=;
 b=nbc/5+g69V70Um2nMREzadHmJ8YJAbx8ehH8geuvt9tmw9DYqeEFEiuTGYjRrbOtXetcHyq6JOH2vaQ7HYkSZjCt+mXJtBVjOs8mmEYmnekj/ksuyxKrPHDW2H5Zt/1IpOm0rE9E1uyB3NgHLC6j3XBq0CTfoyyr+Zb/aodnpZ8=
Received: from MN2PR10CA0004.namprd10.prod.outlook.com (2603:10b6:208:120::17)
 by DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Sat, 24 Feb
 2024 06:40:01 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::6c) by MN2PR10CA0004.outlook.office365.com
 (2603:10b6:208:120::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.45 via Frontend
 Transport; Sat, 24 Feb 2024 06:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Sat, 24 Feb 2024 06:40:01 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 00:39:57 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Qingqing Zhuo <Qingqing.Zhuo@amd.com>, "Harry
 Wentland" <Harry.Wentland@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Remove redundant condition in
 dcn35_calc_blocks_to_gate()
Date: Sat, 24 Feb 2024 12:09:39 +0530
Message-ID: <20240224063939.1512278-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240224063939.1512278-1-srinivasan.shanmugam@amd.com>
References: <20240224063939.1512278-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 8325c7d6-fb3a-47a2-7ed7-08dc35036d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRJBp9Tzztmcd4Icp4EiJ3OuuyExqVk9lShnFDGSH+MUCjuB/g5iBOSD3M+3UchKpUS8Vny69Z2nT0NjNbjaipdmBbtaIUsx3d01njHKBLt+pJlznvSaaVhTpbKivMIH3sAtEEn8MZ+IJ7X7t2L/GyMmxpNCbqc/oj5DHCmGbD1zRqBHCOOWhobF1J/W4rnoibK/gwB4Nt7AzS6wnARQJ6ej2iXJxoJtQfE2wnFToYFe4EILtpfjtrU3RHs6hdwn1CF4hzmbORp6Pgpy1p65c9HsXVpnlegBHmSvwkIR8gE0MwKiYfNiOH6iGk1K9icmoU+ATHt946lM88GaBAsKrlrJ8lERc1+PpeJgLSJC4osQ/MKjCp0DxhR23pT60n+p41G209ZEPJ/i0asCwfP5jOvflzMIymsh2hoC9RN+nXPZPcL27eieWsJUtYltDYrY0pQ7o+7CB8tKk0vEh3Z3PO1SvoH29XGY+SKIvgF6EHKu8PKaTPaj/OLrZ4yCAlo6gMB9S0ub4QGJ9CQtK+v4T/mcq41pK0mQGsmNCDcWBf0qYme1A8EOVu7iwDYt+O9wqtq/S60wvA24/q7p/TWEYvnFsyQkLBms1Seu8BrwfeSIPs83EnMh6nj7KQ3wyoqllpM67+Em/g6eP/2z4NbCivmVzhf0rZ6Qg/kFHpgJESI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 06:40:01.1868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8325c7d6-fb3a-47a2-7ed7-08dc35036d26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925
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

pipe_ctx->plane_res.mpcc_inst is of a type that can only hold values
between 0 and 255, so it's always greater than or equal to 0.

Thus the condition 'pipe_ctx->plane_res.mpcc_inst >= 0' was always true
and has been removed.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn35/dcn35_hwseq.c:1023 dcn35_calc_blocks_to_gate() warn: always true condition '(pipe_ctx->plane_res.mpcc_inst >= 0) => (0-255 >= 0)'

Fixes: 6f8b7565cca4 ("drm/amd/display: Add DCN35 HWSEQ")
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 4b92df23ff0d..3dbbf6ea2603 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1019,8 +1019,7 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 		if (pipe_ctx->plane_res.dpp)
 			update_state->pg_pipe_res_update[PG_DPP][pipe_ctx->plane_res.hubp->inst] = false;
 
-		if ((pipe_ctx->plane_res.dpp || pipe_ctx->stream_res.opp) &&
-			pipe_ctx->plane_res.mpcc_inst >= 0)
+		if (pipe_ctx->plane_res.dpp || pipe_ctx->stream_res.opp)
 			update_state->pg_pipe_res_update[PG_MPCC][pipe_ctx->plane_res.mpcc_inst] = false;
 
 		if (pipe_ctx->stream_res.dsc)
-- 
2.34.1

