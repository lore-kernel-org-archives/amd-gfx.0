Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57579C433E1
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 17:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2DD206B6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 17:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ugI/Azfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2DD206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 961C76E82D;
	Wed,  5 Aug 2020 17:41:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACBE16E82D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 17:41:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKXLqatcleViNjGF0OlsakHrU41/mXdAWwGxkYvj/M/GBzDaAlAjoXIH1xGlwlVLkBjoU9CcEHVQmDzvZyd+8TSmmSEf4dOzj9IPBMnLRbnTMcg9J/nK1NL11p8vNY7q/6BUFIxq/WCNMW3uy0ZJzpQm6P7bX8z10DvPVNRCp7LUEVt2z9Xuyv/ghjf8nwqkRhgDF/nrZjpRqtm/ErHSP6IN8tXrG6nLtqYAKQgWTcnbWA8glqBDYJc2yyu2vaQFfy9pEgpCmPPClMMLUGVRyzPuHvcj7glnWWUe4VD7RKXwzn6WqhTkQhS8y2LXABepxzwiXl25sR5tRd2bX2xWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqXo1NqwoKFKUexSU1qXGTstbeloq8p5tkDpbS3lILY=;
 b=W0LJbq2j75xO+79Fsa5VjCRCOOlbe0bzOXY0M+GwfzVXDCmxCtlZvM4F61mX8pyOn8LES3By4+qB8zd2QKmMrIrAn1uIXaxaesmMU3FIhTbBpmpOPcZ7WFTdFLLSfGRbG32yYXAc5085hjVbYuWPS8+6jECnIxwaUY/Z/QlW+OpzR6j/SacQ7AE9THL7GFjLwHkAfuoCJvIRlS0p+dWUuzUCoG4peaZEJmGaDyAcs8QZBmr2REmjJmAl83EiI0VL3wtUYuud+f288yB6Avi/MDOS8byRorhRNaQf7+g90hTgCAsGQgQwZqDYRm/Ia4yhptt48pdMQGODZCxiklFUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqXo1NqwoKFKUexSU1qXGTstbeloq8p5tkDpbS3lILY=;
 b=ugI/AzfkNi8YgXX+bfjuHqhjYVx5vbn2LJkOnrnVRp7OSbNP9C8SU/lhwST1IJbyKWXwNPzTccGbKTYDfui1bp7Dm5PNU8V7zBwUaurf/ZyW7Ah0fdF3OcP4Tb3N4Z2lFw++bcjSkIvLeGDe9xHj8SYTnrrSGCembTRr24raU70=
Received: from CO1PR15CA0067.namprd15.prod.outlook.com (2603:10b6:101:20::11)
 by SN6PR12MB2832.namprd12.prod.outlook.com (2603:10b6:805:eb::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Wed, 5 Aug
 2020 17:41:05 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::86) by CO1PR15CA0067.outlook.office365.com
 (2603:10b6:101:20::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Wed, 5 Aug 2020 17:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Wed, 5 Aug 2020 17:41:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 12:41:02 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 12:41:01 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 5 Aug 2020 12:41:01 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/9] drm/amd/display: mpcc black color should not be impacted
 by pixel encoding format
Date: Wed, 5 Aug 2020 13:40:53 -0400
Message-ID: <20200805174058.11736-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805174058.11736-1-qingqing.zhuo@amd.com>
References: <20200805174058.11736-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02dac367-eb9b-433f-0a7a-08d83966bab8
X-MS-TrafficTypeDiagnostic: SN6PR12MB2832:
X-Microsoft-Antispam-PRVS: <SN6PR12MB28325A1CE5B3489D516C7F13FB4B0@SN6PR12MB2832.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4h5pWFrwNYUlaOlq6qalwIiyhEluVk3H7tInzFlUoMsEhjITbjcEM7prkv+OqLEbVHxk2wviY1bHzPcr01vWzfpwRlzBEJRgqE9W2hSYrkHs6PJdvr0Uiyp0xt/uIwfge3ruo7I4CO5hEdsm9pp88VPqm+POMe6Y0ycQ4FH1YwVrWJwWHfsyqdQ4/nEhPvWGopV5IlJxBVy4C26Kj/zCfqvCvflylG0bhkFiq+WZo33vsu3kfEnNudr+V8u8ZEMnfPbDjPltwGwolRWK++sXKbtHglQ9y1mKM1SAOzSdPWw/Na1JlF6yZ+ZsOP0VRG9W8OIewEhvO0oSKwJ88wNv4QtAkmgUhF1H3GgbnHuDlRdKY/6G4VYne7F2mz+DGf8VHGoSfNy2BSqLFRI9Hr39Wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966005)(8936002)(336012)(4326008)(82740400003)(8676002)(81166007)(36756003)(70206006)(70586007)(186003)(47076004)(83380400001)(478600001)(26005)(82310400002)(356005)(6916009)(86362001)(2616005)(426003)(44832011)(316002)(5660300002)(54906003)(6666004)(1076003)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 17:41:05.3377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dac367-eb9b-433f-0a7a-08d83966bab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2832
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Xiaodong Yan <Xiaodong.Yan@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaodong Yan <Xiaodong.Yan@amd.com>

[Why]
The format in MPCC should be 444

[How]
do not modify the mpcc black color according to pixel encoding format

Signed-off-by: Xiaodong Yan <Xiaodong.Yan@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index a643927e272b..57cd52789606 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2368,14 +2368,6 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 				&blnd_cfg.black_color);
 	}
 
-	/*
-	 * The way 420 is packed, 2 channels carry Y component, 1 channel
-	 * alternate between Cb and Cr, so both channels need the pixel
-	 * value for Y
-	 */
-	if (pipe_ctx->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)
-		blnd_cfg.black_color.color_r_cr = blnd_cfg.black_color.color_g_y;
-
 	if (per_pixel_alpha)
 		blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
 	else
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
