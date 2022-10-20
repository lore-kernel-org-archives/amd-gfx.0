Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE14AC43217
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A619210E48A;
	Thu, 20 Oct 2022 15:50:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B27810E506
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkXs0b5X+KSUJS2WWtNO67mZwytPF1lL2fFfQkiwb0ptKe1SPCeoklgo/e6xV/dJyvwS8Wt3OB7s+brmzAb0sMkwoUCy70v55RIojVgqSIJ5oLLUj8xY9V+IB+Chv4DZ/828hiRN85nf+DYELIRbbgKlZGUKPglSIt3fgvMFOiBFPKBTYl0AtsD2Z6rKLcixjVcPwS8otWIt1YfbxpLu330eRZ5DfPFoP5JYzSCgoW5p0BT9X+S9PhgjxXViyaOkyGs3O2KihCqe6kBhggXPJ/ptHSSDrxHVq7zOUL0gAAebekG4s7qqKwVuD3cem+mS3L7M7g6gTbL+JjH8aouiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eMmWRq5bIUwiHoVxOveNHAsQtwka2NaOzp/BlCCpd0=;
 b=lx4NtowA9JnYXKih/vGHbFiq/Ve004QQ4lFk09lJysB2BWLFLYtQBAgNex04XhDx0KL3TjybV1MFLrbXoXBMdZU13GJinNVeyKcXdGGMWo3UD/05GCs47YFnlW3N3fdsoG6u/0pvK+IgD3iY2arSvWXqiGbG6ijvlw348J0MV7ZLY6CDNNu7/nJeBXH7KHKqfNqXph8F7H4y2ae+LnzrmZRKdIY3O319Tc7XwW8auAtd77mcOTyUBEO89ayLS3Yh0cAHjmsSOSXyH5J2x4T/oVPTVWQ9QtIHDWIZnuV/QvaV0bEFHfn/copaEmNZrCbMlolyy1kmPEiSdnH/KFJVvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eMmWRq5bIUwiHoVxOveNHAsQtwka2NaOzp/BlCCpd0=;
 b=U0tNjuD3bxS55GUQkWzmbae/ZIUJKLJMgaoXpY0wRkE+0MzDKKz01XdkfZAcFk2WOHfid/s2R1qBAqwUYQ3znpMUQwfHg5IwU6HcwCIlg0iWzgP2b6DGl7TESr6bBZXvYV7q8Sn80KYyP3y/s5T5FsHfK6cyoJ2H32NXVtKmWYs=
Received: from DS7PR06CA0034.namprd06.prod.outlook.com (2603:10b6:8:54::18) by
 CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 15:48:12 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::d2) by DS7PR06CA0034.outlook.office365.com
 (2603:10b6:8:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:12 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:48:10 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/33] drm/amd/display: wait for vblank during pipe programming
Date: Thu, 20 Oct 2022 11:46:54 -0400
Message-ID: <20221020154702.503934-26-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: bfdce507-54b6-45a8-7d37-08dab2b27e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJvnZGbaVafLDDJspvRWBaLrAHINQQqkPa5Iq5oD83u44tEbW5fHFU99lPrt9f5ydy+qsEWKi0ebdkxaFXZv5MS/6fmPEbBi4W6wHrbktnPcvx/lxd6Ynfdf9tyFTEoz3UhmjavfY7fdbnr1VT3Eb/2eOIlWKcoR89o/qAnzlWRXVMp+fZbJ1WezKO8E7Gr5eph0WGrHLMkC4Z3sadNPv586pZBoOUKhgwj6C63ITZWe/bm58ZQIll3AKibxflORHp8tRzHBb79Mz/IHL3v3dp4imcYhk30uIEGhh68Xl1U19OifcfG/KkUHX2vlLXacfAcI8EFFk3zAimSo3/VsjLLt8/W3l1c/rxs+mLIErznfDbs1Pc4pfxGe4dpO9u9aIKBoGsofBJKJDG2yGQfSYFRS/Fz84gJAdn5CpEApL6xqCeWaD2I/RhR2yrmOQgo7BSrQvms5lTYDrGFDHRkxTSdji3xeeQ71IX9KvF8vp88p46boiuYSfqX8VFNMOoqHdguOtvEPsGPzattyWjUuy9eVse1X0cYOLxENxewones0A9467F1YAaXLwPnvCzuNZ4N2pLESBOVnBt7Q5ptGTwF5MWBFdx+i4BNB5CyOmztDj6IWgzlhVqKNPWzMHnSBxsA/Wtbop3LPrRvblZSSC+kiWVk8whuKZ3U1ZyTxeIzpVNBU00YJvInEM8FRlRdLRCrKua4OGF9Z1R506vHcgoiVB8lo53qkt+CbbfVzTd1W7seRDKHd597Y1nmV/ySIHFU9MdkFcJqrf+yv++AuwthmHVqzWVSHrVprSXgCUsSrMh6vQvT0aUer2PI7f8LN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(82310400005)(86362001)(47076005)(82740400003)(41300700001)(356005)(36860700001)(83380400001)(426003)(2616005)(81166007)(40460700003)(16526019)(1076003)(186003)(336012)(40480700001)(6666004)(7696005)(478600001)(5660300002)(2906002)(316002)(8936002)(6916009)(70206006)(8676002)(4326008)(26005)(54906003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:12.0789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdce507-54b6-45a8-7d37-08dab2b27e70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Haiyi Zhou <Haiyi.Zhou@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Haiyi Zhou <Haiyi.Zhou@amd.com>

[WHY]
Skipping vblank during global sync update request can result in
underflow on certain displays.

[HOW]
Roll back to the previous behavior where DC waits for vblank during pipe
programming.

Fixes: 5d3e14421410 ("drm/amd/display: do not wait for vblank during pipe programming")
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Haiyi Zhou <Haiyi.Zhou@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 1ac0ed5be605..feff834d5410 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1640,10 +1640,8 @@ static void dcn20_program_pipe(
 				pipe_ctx->pipe_dlg_param.vupdate_width);
 
 		if (pipe_ctx->stream->mall_stream_config.type != SUBVP_PHANTOM) {
-			pipe_ctx->stream_res.tg->funcs->wait_for_state(
-				pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
-			pipe_ctx->stream_res.tg->funcs->wait_for_state(
-				pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
 		}
 
 		pipe_ctx->stream_res.tg->funcs->set_vtg_params(
-- 
2.35.1

