Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1332BC35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5952067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X9sPwSO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5952067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7482A6F4B7;
	Fri, 21 Feb 2020 16:04:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1C26F4B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFcRqBOet+1mZtlcwwAuoejJUZ59IMYldJUGdO2FgFUHP9wNgZ1du2DG1B5fImhCPAwbKfYNiEVCcFuvXo2P3v6CnGlXg0qjVBThrFx0G+nkbGXApCaZPJXN+ElUKF6ufD3JjNeht3KWiDeX16ZG3ceo0tIhx6ZjTBZ69nlmHc4HW6dUb2GdFKe7nkJcurDlyxrpW5ay8XsuGRs4RSiwsTlVcvx7q6lobbhelfrWuhpCaEO72G6NpFq8xW1vWFH4ykx3Vz9wn0087p0XldZDFNTY3epAuRYZyqDsjBUhBI6e+TDWYrZRVJ0nGiHFCgRCdAFSkxmhBj9Qj3nRnaLXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbjvzQzoVcuJNeR0RYdp5BT53PUi2LYAHFhjTSJ582k=;
 b=MCpDx0yB8wMflNfHThfy8z6Is+E3m05oyFKxd/S3JaQaPn2sVWwhuKdpDM5KJjcIFLHW3wIPNtrQf4UE3gAaoqUfeYp4UhC/p8djffzCYWRqvD6u1iekpmajZFAfQ6KMkuAHDsE5+foZfxEIW/4AOb/HozKrpYxhMEFBPg30AZAAokscMnRMX88ijcBFqsHi2fAKVVC5pdcga7JWSURf8reDgB2xiJcPSdNj4HLeXRSh3EXDIXwnM746vYVdcCdJ7cjSTj6rO9cmprfEova+YluLCOFLyOiOF2h50oS6UlXZEGJr23+7XRwpH/Hy9U4XKYVEJSmsTAPbpS6JEvrzAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbjvzQzoVcuJNeR0RYdp5BT53PUi2LYAHFhjTSJ582k=;
 b=X9sPwSO9GymTjAF0ztJggiTYMlBTAfqmPXnWToHYK2U1X95ruzQN8vc4DRCkmUBg4NCaj7zgC3DGykPZNJYWiZiv8mGeC0/z3bJBmhszda0p4i4rTdVJTwLhHXToBJYjkLT2y2336QGGNYxX4tAqBvBS3dku+QvEsh+ytWbdVcQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:12 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:12 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/35] drm/amd/display: 3.2.74
Date: Fri, 21 Feb 2020 11:03:15 -0500
Message-Id: <20200221160324.2969975-27-Rodrigo.Siqueira@amd.com>
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
 Transport; Fri, 21 Feb 2020 16:04:08 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f56b7625-c752-4848-b472-08d7b6e7af11
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24095D1F22A38ABE6C7F8D3198120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(6666004)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(4744005)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tEYrT+jyXBrT5aPNwx+tJFYPCMbby54tY8g23jgM1QHta8zy2LQsN3/h/b0iKMHAkSGKyxyIE0vH5Fi9bwos9IKP3OSi/yTR8C32T+gIfAvKNkZktMG5mVxQ1mZn/UvI381bqJKJLCdj5QbMF9dPfUk4x9DVpe4iwR3Qvq1+nN+Tj2XD0sXEblCLKTqWtYN9PKKHKGDvf9d0DL0cw6U59b+fnPeRLJQOtJwSCKeG7cY92T/+c3/ElnQ1vb9YtvaX+K4HcFZmrWN9TH7qV3V/Yvec2KpPoACitBfLZgEQKOW/46KUnD6QfPSqASEamMeDJ98xBQD5W6CkTEP3vB0Y0hVHvzY2+7/T1dKdt1KQGlk0pvXY8FhYLMA59avZoK3ywssxXgVQ2nAKkAUQ8LAJQShrEImz7VXiJf1CG/WW53HNM6BTfwda81mY+SgnQMdf
X-MS-Exchange-AntiSpam-MessageData: hB8ObfjH1lxBYrWIbWkm4b7BBN2PVhzzvHO9e2eqh+hMLMcPqSM24Rg/kgk1HjVqBmw7gbMvYeECN0q83jayJTMeJ2xuYpA2Z3Aey8jNNG/6I27AE37KskJl83pNWP7pmUyr0aLRL14opd+mCEKQAg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56b7625-c752-4848-b472-08d7b6e7af11
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:08.9696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhXLsuldtJ/+Lh/BPVrF7RTzsEZmFiB1WMaETY/T8sGZp8elC/RTLgo7p1DfagQ7vDXjc/J4tdmTYwipCT3rAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
 Rodrigo.Siqueira@amd.com, Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 72298520a303..f8ee2b75d2b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.73"
+#define DC_VER "3.2.74"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
