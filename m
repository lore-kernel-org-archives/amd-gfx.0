Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E80ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 18:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD6A10E6CD;
	Thu, 27 Oct 2022 18:40:40 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C002910E6CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 18:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk619AQ75mvEMBfDv69uC17o6fiuT+KB4ou7ECkzeBDpxfxoDQQge9RBZngHpbIhnS6V8+4ND+gzOVI6wDA5vc507QZqrFxnB/YAPcpkIRb/3ZIQ409XycJffrKrUE+N4ogAToVIO2NFv2mK4CzjnSBMLuHD6c6iEiA47knjF5XBySeFdAdu1X9uC4wriJoo+5FADOSg1ftsjY9kZeBAAjgWmEgNzABYi0qHZaSIhKN7DJIYBK5l4eZIFfqZDzGwP3p5M1hQbXMLvAb6MBNK1RBAJuwdADB7ZqxhKaaApq9W3XZEwEwkAx7tvVt6EajEPlAU8tYYG//43UoFDvD7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nqCkHj7oxNCO1bcLJwzGBGOZYDvACysDPAuWxMPfmY=;
 b=hT4TaUsrlMqhcPBtlgAbPBAEUrBp1c5lBigDxmezkyy1Dq/VKrxBZVwAi1VT8PbskXJc7JbbxgQutHAcGqS05dqHHcMp+lJFqfESI56vycKvVmAeXoM2Y9m7nKVN/f8kRzoXuIPdsJ0qAG3G3sdy3bYnyvrGhQdrNft+GiEb4ad8apdYpdFjCdfNKrZyl5S/IKF2d3VAUmZKLHKoUr9sbEteMXTQeGnkOiFJGpkRHxMRW/119j4Lhl1hj52gUA0utZwEKmZ5UmIZ2s2c8ofhJ6i2yWf6MFZCNujr9svg99ghFXeFVEEibJqscIcxs7y1pBSZB7wE9NtQVMjp1n9D/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nqCkHj7oxNCO1bcLJwzGBGOZYDvACysDPAuWxMPfmY=;
 b=KHH0IBVPvuQeb7O720UhNqgj0Yljrv6G08sTR9uG02++yyU7ovHvHHbMqCzQIVk5nOps1st8cUwjdTNmTyIBYKSnQSe2VAoN8scFHaQYMsnP9hairnFFiUvzttSIyUNfXazyloOMtpG0lXQFJZkZLLGt+vMJu+bdJhp6A7aNdCc=
Received: from BN9PR03CA0135.namprd03.prod.outlook.com (2603:10b6:408:fe::20)
 by BY5PR12MB4904.namprd12.prod.outlook.com (2603:10b6:a03:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 18:40:31 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::d8) by BN9PR03CA0135.outlook.office365.com
 (2603:10b6:408:fe::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Thu, 27 Oct 2022 18:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 27 Oct 2022 18:40:30 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 13:40:28 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/18] drm/amd/display: Stop waiting for vblank during pipe
 programming
Date: Thu, 27 Oct 2022 12:35:33 -0600
Message-ID: <20221027183543.1117976-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027183543.1117976-1-alex.hung@amd.com>
References: <20221027183543.1117976-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|BY5PR12MB4904:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ce80d5-80f7-40fc-32fb-08dab84ab9b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrCKmAqv/kpuR1SLtrMHkH1Ris62BOSfRlIt357zgxg+IWuxTfvB7qS6eY52jlqoc/ARhbJrZPaNKBpSLSGJNYyyJSTPy4v16B0iGOCnrQyoUVkW+914XFgacEWM/zhcTjuAoDLtl4MWbvQwZLxR2qu0BRk2NqRgjRY4pUWGOVHlQwY6cdW/X4iiVrkdiMhA54fnBEYtvGh29J6LPCCoUHlvBsFuZpx8GSLhVqcJRzNGsV5pWAfpIbVmgfTcR4BibiprpmxK4Xn0G6/mKrwsr5UUxSMLOWUlfLJm/2E/PRnHerTlvPs7mhE89epIW/62ukYnvMP5FRPWZOOhysNpk9CTa2Lez/+gqfzGhBjQcDgxjuFJJ1QDFb761aVW+LMVbN/Wqj8RZFI/oOd/nhpd+WwpM1bZc3+DJezuHW/w5yu+t4J7+c9yMTJE61hk5T69WpouYdxIVKc5v/eFkkiJCTHJJFJl+/obPVSW9pkKbRAXUml2jPJPNdEB9aI9q0ByTEdmjNyF8XPgrxsEYd21bV+/NU9m92pg2SS8UQEBSDOEc7Tk6Up8NSORj9+30UM68GRFaME1s7tNcKyXNHORLrPwOhSNzOZuRDfSM9pytGgVW4DlGm2BiAx1t1g/gWkDj4F9nlvUXPQd4EsiBo6rQknyVPCqzpfen7wXDDX1yjtAClyk6a54kSOiVujyB9yp7X47si0SAv4bmDFsNuW421XivxqC6Km+e8/IYvnFwVYTTFSd/Jz0JsTjXxITZt3pQWLG2DEKdgn+F38bmLCzASUcbWxO1RL9Y7OXGE/AV+Q5c0P9IfvNzFqmReupzF5F
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(70586007)(41300700001)(8676002)(4326008)(82310400005)(7696005)(36756003)(316002)(6666004)(70206006)(54906003)(6916009)(47076005)(86362001)(40480700001)(36860700001)(426003)(83380400001)(26005)(44832011)(8936002)(5660300002)(336012)(2616005)(40460700003)(16526019)(2906002)(186003)(1076003)(82740400003)(478600001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:40:30.8562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ce80d5-80f7-40fc-32fb-08dab84ab9b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4904
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
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

[why and how]
This line was originally removed for a compliance issue, but then
reverted as it caused a fringe underflow case.

However, the addition of this line caused a underflow regression
when subVP is on, and it needs to be removed again. We plan to
fix subvp underflow and then re-add in this line. After that,
we will investigate what to do next for the compliance issue.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index b465a83bde6f..f3334f513eb4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1663,7 +1663,6 @@ static void dcn20_program_pipe(
 				pipe_ctx->pipe_dlg_param.vupdate_width);
 
 		if (pipe_ctx->stream->mall_stream_config.type != SUBVP_PHANTOM) {
-			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
 			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
 		}
 
-- 
2.38.1

