Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6917C2D0C6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9CF2173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kXOgAHQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9CF2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2D16EB8B;
	Wed, 11 Dec 2019 15:33:40 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760078.outbound.protection.outlook.com [40.107.76.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86AFF6EB8B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2u/Iv/XSedK3TNG6e+KvzOahH6Lxfg+xpjO+23iAMBdvDzvbja9FQc7PRG547UHa6DizP30//HLst5vCNyB5TJB81bPSZqf7cmJ8ZNb5Ap3spES6N7NFzKzO42RX4JAMlyB/DEPPaDlKGT8baOEdX4vRQD1vJbKkdh9j5ckEpypjp9JHqSivnbhRammqrZtlsA9fw1jxvP1gY4srQjqicvSDOfbd8iDcIZ5ntPKyYzPgxf6GYuUOGdLHZbaXJFcOVJg7iZoUGEVCHLovYLzb4lahkmnDy4s8xxvbAOWkWl1oRzDYatip8D1fjziFPv73ZPTYSHiTUEAgYseMLyEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va+19M95o7eNQilSk9iskApeMRJSl9XxI+Jw/6soIeU=;
 b=P1vR1tFiFZTCs6398cOk7UzBVuJ9cI6jRRp5i3qQvxU1duIzgpYm6k3mC/PP0zx3xZDxgUS7pMOZ/NkYrGFUQ305oHcUCZ6FVG6ofbrWjMEfKvSTLfqT/W/d5n/SfJohisFTHbuxBlBUmNDoa2m9mRlpU0dNRVXBAhkkvQA7PxVA65nLZDv3/zcD01mSFjkElYpmuiKFtwt/8J2zQ6m9Es4Ns3xfnTNzE/+d1DCOn8iQjzS5RfScnXLk4ktDYxXGpl8dKKl3f8yKp+2tmfOVp78Dy3VLl4cjOZ8TnKWbe8GAxMV90OCJ5D3ax9uODiZlmsbkFwQRQQOcH9LPkltvfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va+19M95o7eNQilSk9iskApeMRJSl9XxI+Jw/6soIeU=;
 b=kXOgAHQmhU4nL/GUJjQkJM6ZZvF7+xSYTJuuw1b8jcWuenSDLAvax8qxm6QblRzMP0ZgMQmktn5ug9DxUij7e3quZtAd0mXNco/lJeI7oKUcovMY5UO3YsJYA+yVxU73Yfw/hsdk9OIxyT6sehEnixCy3hWiuJ0AkyP8cmjZKl8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:37 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:37 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/39] drm/amd/display: disable lttpr for Navi
Date: Wed, 11 Dec 2019 10:32:37 -0500
Message-Id: <20191211153253.2291112-24-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 78c8e7a6-3a7f-479f-80e5-08d77e4f7d74
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491C3837C11B4D74BBBA921985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(4744005)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v04vw+BtutG7cs/akjuBYtCt5mOhhFSFHaVIEj8bCggGPWKGPazOQzcG3qJdIDtBpJFmzTJUTndVoyTEpdMo1a8LBLIf2NCUUreTNWEZ2GT5CAKP2QnzKksfBUXZhpxy7GWG5hBAZ0/dXAXyZlWgvo6ohcG2MMkTig37x26QWPmpzDZpxF961PaPH/PIysucoIs3adLSFHPtLhu2Zw153TeAtevg13JaXVSOOY7MMh2S2FAqtpCy9z2DrWOr7otlv68pHJhQV5Aqocsk+ZuaqriBVej1QjLEHv4yEIUOZHjgPykR4s1ST4sekUcXn8Mx6sArdwm2URpCnyRPcx84+4HLdvMq90siT4Zhmcv02VNxBStxodVDft8+LRfjQqUILgcq2nh2ZR822sjjvMLNs/UxI6x6P4lJRsJEzmPF5cnC3LMw0tLL3WTFmnBXxgeI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c8e7a6-3a7f-479f-80e5-08d77e4f7d74
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:37.1186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaLDaPKWJH9gjjU/WN15RG16eioD4yV4aauMBotK4XBucoQbDA71lqegT5W8uVTZpWVS763tTPWZYJ9D/fT4UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Hugo Hu <hugo.hu@amd.com>,
 Harry.Wentland@amd.com, Abdoulaye Berthe <Abdoulaye.Berthe@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hugo Hu <hugo.hu@amd.com>

Signed-off-by: Hugo Hu <hugo.hu@amd.com>
Reviewed-by: Abdoulaye Berthe <Abdoulaye.Berthe@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index cfc69919ef9e..1368b74d1124 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3467,7 +3467,7 @@ static bool dcn20_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.hw_3d_lut = true;
-	dc->caps.extended_aux_timeout_support = true;
+	dc->caps.extended_aux_timeout_support = false;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV) {
 		dc->debug = debug_defaults_drv;
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
