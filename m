Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBDDC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 658D08913D;
	Fri,  6 May 2022 15:43:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32D9D10E61B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQRPyYeyCT0kVWQlPzW1RNkOycU2iSS/HhLjVlDOTvPIdAvvcyn4UrlUYguEj1zSwzIneFgf0Mtq4AfNUnOjdqFDjOF9zWEVHkwJe/JhIjPwUciSljA1KnS4f2iV55RsV8hSQNQYm7hSMf9A1ndbZA63JtMQV+VUpm+qsM3Y0JFuFmjW4SQM9AqheSYsWyYgdfbfGMYOf7neyobC9M9hdmXJcd1rmqOab01ol8jwiP0VtSIPxErunq61DRtpdIUVYm9ZOyiWrzv2rnAwcccdWOH/7CzrYVdm10wLtuqe9LShN8bJVKTyf1ubY6N/Yf/b7jz5jjCnvMW0iEXggw7oyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njCLhtSVDyGGd1DBhPFz2fY67PwY0qzpEpomXdzdATI=;
 b=kE0D5Zm+CPCpExEmSlww5G7MJi1ZAQk8hnA2AOlv286UpJm6inpOR/TCvLM8NTblQLnZn923ccVhn49VO8TFEOI3ksM8Bcx0wbmND8OCNkX+3j88Fn+00FfClw6IxQvnQUPQC7+fmHa0yGw3EtM3+sRW/Gmvcoghcgi4YbWNqR1NvvhlMJ++GXPyMRqLhhsJZ4gnBKyAOwG3IfDXXcWJp3gWtbPZkGv8Btz+lFxOgdTAC8xd+hGIjcMFkPEqo4Ft8R3SLf36dajso0a/SUXP/k84dIu6Q2/AuS2O6nIiXsbJQh/GSMgGPWj8hExOWyJmC9mBKHWoxYJUAF7KNWNvjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njCLhtSVDyGGd1DBhPFz2fY67PwY0qzpEpomXdzdATI=;
 b=lVD4KpqbxJH2/6sGVtNHoL7yo5ZpZBuoyiluHKR7X+4Hypf8l9agAr+Qm6yqIyHDa3y/N4zSBb3REIiq+A4aOKF99InMm3CnEFjKvkf/zSMnhNZSUBAQtxMoHE4HxT5l5FjMRFET5FPpea5qR79jFyfeRpAKwxjWcJwYk4X8isk=
Received: from MW4PR04CA0110.namprd04.prod.outlook.com (2603:10b6:303:83::25)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Fri, 6 May
 2022 15:43:14 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::28) by MW4PR04CA0110.outlook.office365.com
 (2603:10b6:303:83::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Fri, 6 May 2022 15:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:43:14 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:43:08 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/15] drm/amd/display: do not wait for vblank during pipe
 programming
Date: Fri, 6 May 2022 23:42:05 +0800
Message-ID: <20220506154214.3438665-7-stylon.wang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506154214.3438665-1-stylon.wang@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c77b49c7-7104-4005-a95e-08da2f7721e9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4486:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB44864264C7E0045651CF750AFFC59@MN2PR12MB4486.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e7KXt0pR+JyY/vmb1P8I/9DKSowU1gbcuje43CBiyihW5l/DGMc64hD7UiMKkbpedCOizd7BHEK0Reyvrs7aLZiz5/R9JoxD7Z0HzHyGKD2Ko4xRFv4CN7yzNNNl6TE77uqTwtxqSlldUeZnMHt+Gc9KxvgGXUDB+28Q5SHKlmHFf56NvfE6omfeVbTeKa2w694PaoVJKIwJh2KQUgL1ELrJxrAVa8Pul2T+bp3B5dBrOCTI/woflLX/8Vu9CIm7qhkmCEGh2m5vDXrt65r8WEpkhXbTy5viSRtphhH0v0O7T9QlV+NbBJfMkEO0LpSftsGAr6hUUDcyEz//tA94305tdUPnu+9gvsJB0BM/0sMXNiZAr/KgPsfXKgfQGzw/CwQ7rqVW5BZsWbm0Ar9D/nvCqH1T/c92rdQb4fwki3xdqhkkUUfu6f+69QbfEgwV66UYAd70ykc7/r+8ImKVTbSj8XbV6UY37cQdM6UtPXMV8i/D5euQzDVWMtCNn7ImUtPCJLcmM0Wg9McfKEEMLJu7C4SG67jNWG08XozbemFnlsatKur6RLk5dmuGzq93tuC8QKfiEK9TrfYafzS44sR/hkBhtyrm4ssaoq90TcGaEsFSzYSBr/RSdoXjQuKSF2eG3K6HZadtAJml3aXEhGFE4o3thoWfpDiD6rYrmK1/C7ui/4y2PU3+pczb8gkwlwuT8Bp6wJ2u3F9eIRovjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(86362001)(336012)(47076005)(16526019)(186003)(2906002)(426003)(36756003)(1076003)(2616005)(70206006)(8676002)(36860700001)(40460700003)(44832011)(4326008)(70586007)(54906003)(6916009)(356005)(81166007)(83380400001)(508600001)(8936002)(7696005)(316002)(6666004)(82310400005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:43:14.1046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c77b49c7-7104-4005-a95e-08da2f7721e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
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
Cc: stylon.wang@amd.com, Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Aric Cyr <Aric.Cyr@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why]
Waiting for the vlbank every time a global sync update is requested,
including during full update flips, results in a stutter.

[How]
Do not wait for vblank during pipe programming.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index b627c41713cc..e1f87bd72e4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1593,7 +1593,6 @@ static void dcn20_program_pipe(
 				pipe_ctx->pipe_dlg_param.vupdate_offset,
 				pipe_ctx->pipe_dlg_param.vupdate_width);
 
-		pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
 		pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
 
 		pipe_ctx->stream_res.tg->funcs->set_vtg_params(
-- 
2.35.1

