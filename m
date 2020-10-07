Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91948C41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F6A20789
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UZFBCj4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F6A20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8704B6E8DF;
	Wed,  7 Oct 2020 12:42:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3FA6E8DE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 12:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bb57PcyMSrJ2Qk6Q71eRvOYpxpCAPoIFHGnKOv+B+mfidHzLtkX3wKVLpFEB3VensA6Y4m9mxNGhoZEl0lSZ4uj5YNxjYQiLPRJZ5xaPJorLVnrHAE19R95Bi2JEDy/NhbjqeEb8BYY7ZsrESqzvVKEb/H1A+oTw0Nmqja8Fm0dcDPaC+tegQOn/7rXXr1J9yXwa0u0IkKgulOz59cUVUDI54SYC4wm6k1T7tyhbF1K5garcci5dVfK3278oSuSyerjTtjKbejg2jJuVw7Utq+90AHCv/lcb0RW+U94BX0Ud/7wWWxwUN3Qg4y0Nmp+GXPRUGq5k94R5EKvbw4EGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o7ev7JD16uYHD95wmDWhLDVvZfLselr3MKYjm2YTws=;
 b=K6CmT7Wb1Z4curXjB93Y7wu1XqKNYLNF7U8wDalm9I1pphlTj467XvaWp6Zo6d52Y9N/FdMIILIxuoMyyDjobb6R/0VbscCiBCkDL+3U5h3asOgeMJB0frj6FDITOQy1lFGeYeehoPG7HLEG3FkcZwAadPMsr9n0lSAgVZNab83EZvkUsAcjBXW2hTleENu7SdD/rR3IhoEytluzvstQS3dzcGBSKY2r3lgwcbS1+9RixnxM9AeouZ64fxog4vZEAK3ZgC2EELXl0UpujS14xmamWJfAvlWYa7i5ZIjRgiyPGxWEwV2DByPFoz9FMaylBCAfUYt86CpuaABJrtgigw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o7ev7JD16uYHD95wmDWhLDVvZfLselr3MKYjm2YTws=;
 b=UZFBCj4pfKe1HlZmghGbdaV7VuOnEbdAp+2wIyxgL9ymC9QEdwv8zGb6tpTToEKc/YCgy8XGH2xDZ1dxDqLOoMeKgWPCmtbbU8pxPOnxvJ34VdE6zGaDliQgCuZIM+DnGsKzOrPUOVOYOLuEpTovASd1GHgEt6wYCvreJUPRdrE=
Received: from DM5PR1401CA0024.namprd14.prod.outlook.com (2603:10b6:4:4a::34)
 by BYAPR12MB4616.namprd12.prod.outlook.com (2603:10b6:a03:a2::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Wed, 7 Oct
 2020 12:42:36 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::97) by DM5PR1401CA0024.outlook.office365.com
 (2603:10b6:4:4a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Wed, 7 Oct 2020 12:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 12:42:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:35 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:35 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 7 Oct 2020 07:42:35 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amd/display: Set WM set A to 0 if full pstate not
 supported
Date: Wed, 7 Oct 2020 08:42:19 -0400
Message-ID: <20201007124224.18789-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201007124224.18789-1-aurabindo.pillai@amd.com>
References: <20201007124224.18789-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05e483b1-75cb-407e-6f21-08d86abe7829
X-MS-TrafficTypeDiagnostic: BYAPR12MB4616:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB4616A8B8FC216D4462C111EF8B0A0@BYAPR12MB4616.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kTN+mOATw1a7ZS6BkQFTWhq4VQsI1dDr0+J7dy7BfnpX9R4q1dvX9SIptQqc1tBvb6BFXsaln/gJcPiK1+esSRPeBL2hKHaUj2zO1LIEbTHHqRgXiWx5/W97XNYliaMRhpd9A1uSr5SZ8wn/G+HaIjZ0My4FT8MdOX4gYZdPR4M59Jyt5pkDD7ClbkwSB1cPNwwVKy14AJcDeHEFgsquwOb8KOqR3yrtcppzxDerJZeDUQndyRm7A1tQHNpPFnSdTwPFNCRX4ullro9Lv2k2amKCJyLLgXjp094hItI3K86Z1o68TMTzCkd26bijujz5T+VVUUauuYjdMU/hdj/zS8bumYSgslzG+ZCt7SsVBJKfLmQzm+ANoozIvW88iPJN77FWAoR0Ng33dWpyjXXsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(83380400001)(36756003)(47076004)(54906003)(82740400003)(70586007)(70206006)(5660300002)(478600001)(86362001)(426003)(2906002)(7696005)(336012)(1076003)(2616005)(316002)(186003)(26005)(8936002)(6666004)(44832011)(81166007)(356005)(82310400003)(6916009)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 12:42:36.4327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e483b1-75cb-407e-6f21-08d86abe7829
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4616
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
If full pstate is not supported, we should set WM set A
to 0 to prevent any hangs

[How]
If pstate is not supported, set watermark set A to 0

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index beaa6b9ae752..8a4eb8e1386c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2313,7 +2313,7 @@ void dcn30_calculate_wm_and_dlg(
 		 * calculate DLG based on dummy p-state latency, and max out the set A p-state watermark
 		 */
 		context->bw_ctx.bw.dcn.watermarks.a = context->bw_ctx.bw.dcn.watermarks.c;
-		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = 0x13FFFF;
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = 0;
 	} else {
 		/* Set A:
 		 * DCFCLK: Min Required
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
