Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196F2C3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08F621D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZLDdV6Cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08F621D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB1C6E5C5;
	Mon,  2 Mar 2020 16:48:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F8C86E5C5
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikd8qq6Ao4Orv+usnOoWW7Uc/gsPA761QKbY2UYt+jxsx+382dC9zbEfyL/+8DkQbVs0q/Ep1QFHrvW/6xFrhuHQjL311wFGbh0nqAUghLMwp+aCj5mznszmMsgTHgFezc2/mlhM0SZcEQGetQNd0a53SlGBE9/NHDdmokOIwWFPexFqieDn+iYFHY96taoihxC/YHxDr6u0N1Oim+eNDrH/CUCw/F5t6Mtig7CoJfMAeNBkysatKpE5AaeUMRr/E3/v3pdtiKmAbCPH9uMhmCUp+AGsGEOp8u/glpJCjsIJRaiNLajPcyEin4TF3iLIlho3l5cKhvMj/uZvqix2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxt1VV81VOuzIXmShbqlnoUn7rd7vCAjHNwteWeWhgY=;
 b=iMMN1aHzU16VnzZNNBzRkGKEGafSgZkq1MpQ/5LzI8QT+6MagnfeZcutFKdOzmwu8qE6JqzSlvgLdSC/o16Rh6pwsVBaqNKgSJE8acpJQ+GfciiA+jBifvjhVS5h4AbZwFWcY6ymW3G5kWMOLQ+CAnODRv7dCb10HMyf5jcEsS6eTMdtsLLmHygakxjx8DwNsdxH1/hLaRJLADfHWSTRx2GbeaekoRmh4Ay8hI+hExNN7WI7XqdBl29KIPw4yIEtfF6OuqDFvLbFpWPM6OIcn1k5drnFTN3bU1NISwjFj2FD/zQFd4xbGTktkSAr8XZta8rpE7egWLl3nYba55PFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxt1VV81VOuzIXmShbqlnoUn7rd7vCAjHNwteWeWhgY=;
 b=ZLDdV6CcIu7jHjEYIZxZfl1tfwWfKE6scTqjnqEhuw74KMCqBfm4vzW0Ht3fZisGe25DhHMkyzzWhWq8x76Y1WADvULxZI34R21ek3ssIwIetqN0wHLIk9Rwc/R+nkAgLZnq3uJBq1Hiqdih2BcXGhxFjO5ALV0JfpOaOKpkD2Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 16:48:10 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:48:10 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/22] drm/amd/display: 3.2.75
Date: Mon,  2 Mar 2020 11:47:33 -0500
Message-Id: <20200302164736.89429-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:48:07 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f46e5a3-f43e-4f62-d0bc-08d7bec97c75
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:|MW2PR12MB2411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24114D693AB0D2BFBB6D641998E70@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(66946007)(6916009)(6666004)(54906003)(8676002)(316002)(4326008)(66556008)(478600001)(36756003)(66476007)(8936002)(2616005)(4744005)(1076003)(956004)(81156014)(186003)(81166006)(16526019)(86362001)(2906002)(52116002)(7696005)(26005)(6486002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2411;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YyQgf63Iajk4+YMoVjlAjuGA/XMryITaw26WoYR2B/gan6V0n0KUYLNIG1pE6teQeTD6g82/nrzS1Amv6kSH+CHvEw8W+u0hPcRCKbsSrqU8ElCawusZqii53UFkgD6rjX8PPy5jJQozp9p4RJRRyOd/Y1BbU7kCTXA7GUi4l5A/u36evAEs9Rq6RzhMDVCbkT8yy517DOyUjAP40iE1dJMksx9imcjKtEs3e+2JCx/7mmmsjXc3xmTxt8gRhBuvsB3mMrUhzV/JO28hkIo4vvynAUNPGjtVzHMIh6+Z2FCLBZcP0jSTK2KYFFk8kML71dPJL7wmZzJPtTVlDzTthAtI9x4tT0ecq1eJpqX0HRp0u9KNVvMB4KWQ1+LKYJYUcENlh+wnXdMd5nXpt9/Ann3JOWoefnd3Do6VlDEmKZ0SEUKVwzjqMalnunA3gaX+
X-MS-Exchange-AntiSpam-MessageData: Jphko8Zp1i1HAvrFtO2c/w/43NwrbPhVnUGT3Ic88PB+1dK/om1bt1vjlgNLQpgYOefJKQfS1OhIrk+CcYNdnl2hUOB5/R8zvaBUlm5v1FwgS9uuCVXcicQOVaYzSbVhRiJjcDMwNbA66u7aW4qknQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f46e5a3-f43e-4f62-d0bc-08d7bec97c75
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:48:08.5402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VonUSFfyjUzYfsF3Fqbb5raIPV1JOtak4lfzfgr5p06wnnCfSNMRGXr98zyYE+Pt2FJF1Dh4GL3pGlzoixwy+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2411
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Rodrigo.Siqueira@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 32dec3257d5b..abff0da945e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.74"
+#define DC_VER "3.2.75"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
