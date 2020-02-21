Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6594C35657
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB792067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YBaBWeu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB792067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B9676F4BE;
	Fri, 21 Feb 2020 16:04:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81DE6F4AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzdaIfQjgrqwTGod+OyCFU+Nj2UV9bALMxwc//VSI/fBdiRtVGDBHkHcJUzMT+XEl/CsDOZQionDs4OFWhH+g9uqK+hr4S+8gpC7OOE27qwIbjLBAQAESFTJcAc0R8Qs04aqkwuaep1WBIs2X+kN1ACy0p5HsXk87xxBB3vyKpRhre5K9I53zOgqZlRn2jUD2mWi1yOzT2hVzyO5m+LpsXSpjBNjmGIrB8UqqeaiVRiWWQzfmX5IOMFgFxUNsTH2iAM43OMakAVvI9Bg7O+kJCVSgrfTBYHEpsNJfAtTv+ujSZ7lMjTWfxTkekWADmyHhTOtoN9pr74Ucv/yS+WTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUAThQnKzohfJ2xnUoNEPmTW9mx11xfwet23y/wOFWo=;
 b=UjV6alAbm9r6uQ4V3cxKMJ1Aq+lw/0NMzuMd+/PoDAF6NVvo510XvVAQjfYHCceBdMbQC1javMy46KrJCwp4c+opjJuLzBCqB4Iy5qCFaj6Yk+8KQgGUEspY8YihOfjo3xmEayC5ZSXGayHCvAoxVPUZiC48sJyb5X/A6zWAFxiVBqQ+FEL4B1rL8Vblq/t6x96nYDoyhVR9VQAjVW93RUNVfO4JmlR7Ne3+fkrhRg/7lBHVL1W6JerWhAukXvwn3BrNvVa/WaoxspsF8Ix4902a+MOe1Ew0U6AfF9YRudI+BxC+Ea/Dl1TiMF82g81ZyjJ7JP2iLCOYY3GWnSEhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUAThQnKzohfJ2xnUoNEPmTW9mx11xfwet23y/wOFWo=;
 b=YBaBWeu8gfDhHbWSpBICPmtmgObWoQX7lAFTMwGNR6hdSZtLpDLF83a8K6NIC4vHhS82/PAJC8lWpTeZSCGfLtDDGNF5r8kJtB3HWdpyKButX8RH0VTVlqWBEz/gU0mmlvyNWvoEIKJsTETTgl9SpmwwCNO9czLbsaCfMRi6Q8Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:52 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:51 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 34/35] drm/amd/display: Access patches from stream for ignore
 MSA monitor patch
Date: Fri, 21 Feb 2020 11:03:23 -0500
Message-Id: <20200221160324.2969975-35-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:04:16 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5342c8d4-23b6-4a73-1fcc-08d7b6e7b3fe
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB257252F92161183CB7EE6E8D98120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(6666004)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggcV/yZid0aTbK+MOuhRECEqgWyMt/4wtHXlv0GiLIKN9MkxMOmrR//oOYgyNrTmIJCSHeG4nzwbfKC+0I5yyHuFjcWzcPKBeJz9aWQeo3sXFDJomm8jsDBP5p/4aV6E+BiVX2DwKMpnFmUr60Ps/B8OInDk12u3ALvIpzN444/C2LIL7PHPaqbOI4dyz4R9WyFb0TmF1bx4X9Igg7GOeDA7Z+FYE9C3HGCVd/zTod9iAmAaZbXHr6LGdIxXDrJvBpO9AQ5c+cGnwpZ1O0vAganInMAPDm9h3El6gsl1qlIsjVPNo7iHAzjJUMaSMzbbNB6TmcP3vLizYXGTjY+1Qb8iWAfFVLOc+q0UJyZMDGc23FC8uyE4MyilhPz/2EjyTuqNRkpB2xUyPmL3ccD70ZRddcAOuU04qL8qCBQbQFkyhruc2PK40J3OlaO8I4wM
X-MS-Exchange-AntiSpam-MessageData: ucL9H131bbbsF5sbgFY9obQ8JrpLHM3XEIiyPs5SHEdGeyGRcLZyq/szT5Fo948bJDoVh4l9sKlSmuBijqufNhcoxaHzNFhEvdRUb4uOJIhUcCfO6fxVTrPmJ9o/1M4S9gJbXNO0wvHEN2J7RqeD1w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5342c8d4-23b6-4a73-1fcc-08d7b6e7b3fe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:17.2469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zN60t0sO8mS3JVIUFBu7bsujIWD2dbIRQLqLGrkj0xnAbQ6fMCY1rQGIfbp+2Hjq6ft1gfxmDioEVtVHNqamCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Ashley Thomas <Ashley.Thomas2@amd.com>,
 Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Jaehyun Chung <jaehyun.chung@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jaehyun Chung <jaehyun.chung@amd.com>

[Why]
System will crash when trying to access local sink in
core_link_enable_stream in MST case.

[How]
Access patches directly from stream.

Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Reviewed-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 2ccc2db93f5d..02e1ad318203 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3095,8 +3095,8 @@ void core_link_enable_stream(
 		dc->hwss.unblank_stream(pipe_ctx,
 			&pipe_ctx->stream->link->cur_link_settings);
 
-		if (stream->link->local_sink->edid_caps.panel_patch.delay_ignore_msa > 0)
-			msleep(stream->link->local_sink->edid_caps.panel_patch.delay_ignore_msa);
+		if (stream->sink_patches.delay_ignore_msa > 0)
+			msleep(stream->sink_patches.delay_ignore_msa);
 
 		if (dc_is_dp_signal(pipe_ctx->stream->signal))
 			enable_stream_features(pipe_ctx);
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
