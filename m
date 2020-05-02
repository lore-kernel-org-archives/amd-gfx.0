Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F43C47256
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865672072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2RZxmPeJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865672072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F076E123;
	Sat,  2 May 2020 21:34:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E89446E121
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHWYAaYnAHhQaPRhPxZsJb3caGBaJZFvIBJCwPdosvIx9CwCQn4Fgy8VW7Jg3Zw3Q8F63rGCCIgFf4E6bu2BrWVbcZeISiDchQ4mIOpZZYP1sWUnr39jv/F/8qXRjWvQic+5BZTHP/7gGRh0tBvoTHvjsok29J0rYV/r5xjOUsUkA9rNpI3Sy31OXpU4rAVntNpy6ggeMXc0D3EvOZFYUfW2MV3YsR3/mwRR3b6sBdqakUKNVcA6nHGfrD8SqU0RWutKS+fj27VXhzRC8059ATi2pQ3bsdkmDB/q4TFZstLAYlatA+OKkEWmXgNDCSuz8ejvEqVgxvTsCS7D7OTyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bE9QjoSpVYs2zm7Tyr1YGs8wSl6xZ7CW5/RMYq5DIQE=;
 b=PCNnbVeFAnYl2r8L6s28m9P7oeDOyuXTJCtFFA7tOoNDF7PecwTHHWJsQnEULwApxph71w2Hd2PD7CMiYTmLswqFkaQKneOuDvNgHIdDcQVBOez8ox41tdHmh+htsnDG1oGOdbiH0giB/sOBkHwTvGJdedloy2pmTXUs0fmvweAFyw7djH9XNrOngjLuaBOakxEl/AB+OifRmS0hAU6RjWxyb2LLo/m19r+DWd0XVaYlopWpOpo9BzE/GcowkmoUPR64Np7r01rrPo7AFXvwycQI831ZIj+s4ddwMlZL/J7onAxQEhsa9hySsQ858qQLWiUUIap22SmFHK5FbIUoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bE9QjoSpVYs2zm7Tyr1YGs8wSl6xZ7CW5/RMYq5DIQE=;
 b=2RZxmPeJ4K+egKdThGTqKoJl6H4fPpGFoBc36AveqVro0j80zFyHEDOszKcxm9XD36cqcdoKQrkOd+0UTfY6e53YcQ5jE/aULEnywMAeozimwRRP5c83cwvyxbeWiESzx1bwJoK54q+uJ0dpNUZGa7j2abtYpqxODKPSgPWrSiQ=
Received: from BN6PR2001CA0027.namprd20.prod.outlook.com
 (2603:10b6:405:16::13) by BY5PR12MB4196.namprd12.prod.outlook.com
 (2603:10b6:a03:205::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 2 May
 2020 21:34:51 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::2e) by BN6PR2001CA0027.outlook.office365.com
 (2603:10b6:405:16::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 21:34:50 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:34:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:49 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:49 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:34:49 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/16] drm/amd/display: fix counter in
 wait_for_no_pipes_pending
Date: Sat, 2 May 2020 17:34:31 -0400
Message-ID: <20200502213443.39232-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966005)(54906003)(336012)(426003)(316002)(4326008)(6666004)(70586007)(70206006)(6916009)(44832011)(81166007)(2616005)(356005)(82740400003)(82310400002)(47076004)(478600001)(36756003)(2906002)(186003)(86362001)(7696005)(1076003)(8936002)(8676002)(5660300002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa76c0ca-94b5-48f3-75c3-08d7eee0a4f2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4196:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4196B04417449201634313FB8BA80@BY5PR12MB4196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owWA4vJQ41GpXWfJAjjF09EtOzOsCFD1+iefaR6bQ9U2zyV6eg2ogl7E+DH/hFlakOfm7Cj0UEvUdcJHWTl3xFIOwpvJohLPU0y5ygsFito4pPGlFQdOFoV52JicSVrj75pkq8c/qxGCzYmUiBQfCBMduEmpL+vPSnOa2BNMS+l9zPlhMIdP3f948mz/y1GAK0vDJkqgl4Sn2UZLgPCVArmC+Mf+hh03poShi8OD4wbVMXZk/xZdyiL/uZhsFkw9WLc9mWA5bSl0G1iwNZo4Zb58Wfh2pYK8bToOD4rOUaf58/w9waY3Ro+9npfHpAKtbMo9znDYtRqHiIpLfSrZ1MCf+RgyNB96pBce76BUQFb64gOIoM5rbbc7BA2p3soAPQ5fGC4HJkZsXmNoqlajltEaYkTdoCkD0/L5Adet8z/bAtLqjfvRVgSG/msmM3pLXDX09uehoYhfOse8bdS2GxrbxbS+CrpOTXaJ+1L1vC98f0fy/KUU6BJ8Vfn5q2iH2AbMQoeXGtGxibX9MYvQEA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:34:50.3223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa76c0ca-94b5-48f3-75c3-08d7eee0a4f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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
Cc: Zhan Liu <Zhan.Liu@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Roman Li <roman.li@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
Wait counter is not being reset for each pipe.

[How]
Move counter reset into pipe loop scope.

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f47acf30acd2..0a12d13349c1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -839,11 +839,10 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 static void wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
 {
 	int i;
-	int count = 0;
-	struct pipe_ctx *pipe;
 	PERF_TRACE();
 	for (i = 0; i < MAX_PIPES; i++) {
-		pipe = &context->res_ctx.pipe_ctx[i];
+		int count = 0;
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (!pipe->plane_state)
 			continue;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
