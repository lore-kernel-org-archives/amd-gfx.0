Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5658EC2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2751C21841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pvRvKDti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2751C21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6C076E357;
	Thu, 16 Apr 2020 23:41:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843DE6E353
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eANsetj4FbM8JN7NXkuwyHCdsADoTbWQlSdQ5X2mIMWl5gmkspCcu+B4GCaVXBMrGijR5+VV8MqHZ2dE26HJve6yOc+RI778kZLTjk9KB2YW7aI/aQ+U4giv1ORS8yxYhGkGETWg8Q4JNEva4v1VSurtHqkrPw5l2ZJgaHV+ZethRKw0Ub9umJ661TMngN0ENF2CTqE78ruXLIht1lnotArPw2eExA5Z9KzQn2cnAEvsz5R2EZSrgj7Qra042eD/nU+PyAC3mYNd8BiLG10beZuYdY+SBUo2eNOKQPsyHDAq7ldpJ+jvHlgDc6Vb8NIUe7YhlNaEMHjy9T04uh7hog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5S6GsEIeNp5UyOaMwnF68xvd1bRbqMPewH6UOeCXmc=;
 b=POzt/uaEQpcVSvUP7mlupNIvj0+LhHzmnwfs8OHu2bmEzxazcJ4Y2XmLZXFm/YAxGwm0TEKKXaH7BQOMJq7bhJBKa3yY0XIqbiKK+BK69gIuDrvB6k4bId9EjQmEyPLSyNfGAuaAlv8KISw2Zo9gPWLfP+sEkoJCk6ToXqJJ7HZJBInWoiflFLEy4XRGuP5DDb4mr81lTOuHkwNUpU/2eCK1Ee3MKCwa4skBS1dQgSBiTENoiDkIOC1IVI+NARkdQmBF5i+0WfIUwbw2cxEPilb0aBQ/tjIpdw8dc3M2TUsFAHIQRcVOhTcM0OqiuLrGTG7Ioqd6XynkaR1y5dHegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5S6GsEIeNp5UyOaMwnF68xvd1bRbqMPewH6UOeCXmc=;
 b=pvRvKDti/xP5KFJHoyY7wk8AahRcYHpn5P6mF6zkor1znKmjK/IPzDzvWnIP6Gyht7q+3IZzhOnubT4D+2QO2coOzq36Uv7Qbw4a1u8Vvp1X6nV+xpgGassE3hqjhTJoCwyjl+opgAfqjuiYhffhxRuuciOs4lBrRHNayd2hyRs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:49 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:49 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/35] drm/amd/display: Factor in immediate flip support into
 DLG calculations
Date: Thu, 16 Apr 2020 19:40:37 -0400
Message-Id: <20200416234044.2082886-29-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:48 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa09a35f-52d1-4e6e-5362-08d7e25fbb61
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24595CA67823FCD3B2DFFF7898D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002)(14773001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HSW7CPHuWiTCjR4zFznUbXxAO7i+vl6ta7kYy8vSH1uQkN/lCTINlmrFGjYrmxnfrj+X8mAYwPBA2oddlbwsWcMFKW6Xr/8jKlAFqnlLLMvqv3zS/wsfVFUSOo8Pjgsr4yEJEV8yQrJCgZLFov3CT5Wo0496zUiuCQiAgUB0U2VP6KPXoQn+UDDj1CzZM3LEVGL5HVz9zV0Aj6dOgal01ezAz0Kuy5Xk0qWy5+FJJ9smjrEwr0u4/xQHeiJ7aLd+Q9+HBRXA4cWt1aezCpTNd+2JhoPQxdcdoxW3YHqGSrWZZxvykIjMmYkKEW0u9qWbNj/DV26ix/I0wQ+xlilQR3zA7U1nSzCW1afIrBTKDnd+wxo86+soXakimR3bfweHToshB1j4i9SCJTZOVBjaJz4HHbTyIT9qc0l5ad3aaqHb3vl595F+lpTtW/VbwfnoH6xr/+jz/S53uuZJOVkxFxU8diteV+UA79qp/wDM3W9OL7TJXmr/s0N79EYnVduj
X-MS-Exchange-AntiSpam-MessageData: f1xqInQQTYzJecmcOLllmY3bArXZdPxeAvgigPBq5YGLPfrbc50dp2wMgFs/DMsFe4uQD3h/1AHzGlZ8UZqhBC8TqX2LmOFN0VkRSvpBTRLVLej+hAs0KWbCRdz3Y0e0pu/rt6SaBgmEh9C32nITcWqIUW0IYIFz1mMQgNRUeTY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa09a35f-52d1-4e6e-5362-08d7e25fbb61
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:49.2271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boGOEvOekiiO/E+uZE4Pu1DEZWyuSWhkexSkpbdg8gEcikkW1wmNbKu7e8+wmDB+MY7Unx4TSQGd01Qbd6p87g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We expect to be able to perform immediate flipping without having to
recalculate and update all the watermarks.

There are certain usecases today (1080p @ 90deg, 2160p @ 90deg) such
that we get a urgency value of 0 for frac_urg_bw_flip because we're
explicitly passing in a value of "false" for requiring immediate
flip support into the DLG calculation.

[How]
Always pass in true into the calculation. With this we get a correct
non-zero value for frac_urg_bw_flip.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 219aaed6e06e..6472c3a2d270 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3033,7 +3033,7 @@ void dcn20_calculate_dlg_params(
 				pipe_idx,
 				cstate_en,
 				context->bw_ctx.bw.dcn.clk.p_state_change_support,
-				false, false, false);
+				false, false, true);
 
 		context->bw_ctx.dml.funcs.rq_dlg_get_rq_reg(&context->bw_ctx.dml,
 				&context->res_ctx.pipe_ctx[i].rq_regs,
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
