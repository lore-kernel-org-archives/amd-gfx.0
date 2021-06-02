Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D368CC4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A559E61C53
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A559E61C53
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9B36EDD1;
	Wed,  2 Jun 2021 16:51:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5CE6EDCF
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFWkXcVSZNkClsNjlz9WVHGT8vHM3keilgnQq2G7fUnPuJAwQqNiZaz5bB6dtFOTr4Bd0ynIjtyWmi6nkKXWlUM/vMR+GImW2+w5oKbYo1Bk3XM0lfprcSMSCJGnZPtZbrkURTAS6ijiFq4ZM6Jm+17SvYY1KZ+jN57JTJRCrVzEwV89mypN/u8juNaQKWMGkFYR3c0MvYLQE5nplXcps1hNthl9yyio5UfcZUH7F1YgbZmdNpGYCRGaUgz1799yETpiYzLgp9Jy1XK8Ef9vcTXaKkspU7FMeR3S1HB0D5umRl/Suv4d4C5XoAYIAk6u9vklVgQW+BY7dGIZBUxNQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltDC28ZNepr9OVPJm5EDwr48xPsf3N8BpAyMEcx3Pz8=;
 b=f2Z2bzjRwOp3m3elGIMzJWGDwJcoi+uvnSRWx3j7hF+E3UNHj6cQjiN9FmmtydaguXRTeq6P4j7MU60oS1+UEAypV/wOaf5jUTvU3EMti+ANwxvyXDAlBa9Cr/RlDxG74oGmIMUGcIUH43zoUEcY3l0L63UvXtcFmKYG/s1lTn7DWScUx0t1mKzzv+qbiSr4RC1gTyLkv05P4zKUEc+WjVcRmNxGhzqBVfr23NJnP+cTM17ycJX85+h1HE2kH/MRHhwsZj2u8hp46XfiQY+1D7yhIywogtSPISoJLoT+xif+TfNsn3CYvtNR5xSPtX2e1xbKPV+rPJl/Zz+Eytm0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltDC28ZNepr9OVPJm5EDwr48xPsf3N8BpAyMEcx3Pz8=;
 b=wFSJPRb/qgusgTTiWXUWEe+vK9x3hOv3UXJcJ3RPGz+Zyb/GTsRX7GFG7H9hTmIGNNdhEa+EM7BAEs3HNzkfkclx6f4JYTq1QCJaOFdvWVPlbGLCU4iANCg5sUPzknV9/PbmKeertRKroMYVCqcUVgGCRN9JJNQNYmOxNpJb3Ek=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2369.namprd12.prod.outlook.com (2603:10b6:207:40::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:16 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:16 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 68/89] drm/amdgpu: add video_codecs query support for yellow
 carp
Date: Wed,  2 Jun 2021 12:48:47 -0400
Message-Id: <20210602164908.2848791-68-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56160389-bdb6-4fbe-5482-08d925e67e9d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2369491E6A811EB6514858C0F73D9@BL0PR12MB2369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3/XGGDuJyEhlos0qeSC0EuBuZXkxJi5LFzUBRYlRbkki0Kq2jWYFxYjDjgSpUdEqR4vSl5xoEVJX1kYQf7RGY4apU0RJsiudeH0VNpHgv1CloR0QkkxKmsTTM8b/u5jYu+ILFwp9v+xcr9j0Awz+6BuRLfs2h1vKpozDfhDGjAseIYI+oWiSV25QALS0uWazxkS6+n0sLU9i/z+NBnDW14/07a/0t2z+uzuMYsxCKK6qUWnNsF4/rLgo08wdnm7SLFYQ9daqF+ZGEY5XpqC+8yd+iyOcinvj+wT+BZsr0HDKOrNow4Uq5ZTLXk4GWs/jH8XIMiZxp55jRTn5F/QFRYvFGanb/FopM9G99/4HNJ7KxDPyHr4tYdyQQ6SfOno9waD+J8MVE0qfOPuytDtd7zrGp7DX47fA+a9dOMf3b55SnWGefi01UwdJXWNCjP/oFMkMqOrvSTdHwj7mGPik8Xt8CdtOSeL99efVaSq7ZefZ6smeX3OO5yNFJKxIvW2xqU1HTcRpIcys7Brh7ZiRJw4BVGmj+uJJCf9XVw2AuuCWSs7bIu/YS3UsNoQhmEj0EPn1yX6VOWglrQroOcvvLP4Oukmm/udZ8TJZvvJfcNimur243L9e/wQ1GEJxdhf4ofRv4edVezlTX7s/r65OszwBOwidpkBVSnFx7dEUQ4XeYlGr0Y+6nVv/Db3tNwB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(346002)(366004)(396003)(54906003)(1076003)(8676002)(6916009)(956004)(2616005)(478600001)(6512007)(6486002)(86362001)(6506007)(4326008)(6666004)(38100700002)(316002)(38350700002)(52116002)(26005)(186003)(5660300002)(66476007)(66946007)(8936002)(4744005)(36756003)(66556008)(16526019)(2906002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?i85Bp+3Zv6diyPZIzPm0vHIocEVwFYG44xp7ACi+AbkyD8QQf/qhPbdYghy/?=
 =?us-ascii?Q?ap9Xaf4ZxaCzIWBUMb3kMjKfCuBrMij9N7MbslfFZLQF2t6W7S6KLRtz2AuP?=
 =?us-ascii?Q?MBjwkbjFLoqzpw2R59eoZxv7/waixP9qKSD4kmqo1djdOjL/ia1vx8uIuwXu?=
 =?us-ascii?Q?ujPlO8KO3v711/m3fLe1AtkKNQzAzeStmnUETnVP7uQRjlif/972Ltv6NS0p?=
 =?us-ascii?Q?yyDZePc4u/ZcVUszIEl0MEO4SFs8OfRo1MKV2/RUmYFZPWsX5b0eOAHzpfHt?=
 =?us-ascii?Q?T5qXF5pVEGMds53htbzIZwBnMXa/4ZSlD4Kx9RVwngwtnMuJ1YKPXPLg56wR?=
 =?us-ascii?Q?FcZ4hqq5M+/JvrZa4DYf6aGuUyBDW1ZFn82J1iojbq9XUykwYPnIZ1/BP+gO?=
 =?us-ascii?Q?uF9rSbe1+JLczOK3Pnnhk3vnwe3q2jdcAg3qh5E21MOv6Q9fgIviBrxE++7g?=
 =?us-ascii?Q?kzkTOpcHHFLcpcP1eHcOgA2b2du+i8XTFYo5IvWw3dBdQB6g//V+Q+tla8HM?=
 =?us-ascii?Q?JNdFC1um247gdUl2k82cdZugI/Zm9vAB5TbCCMn4EfATgUHABgG1d2fU3j2v?=
 =?us-ascii?Q?AwV0iKqxOYiiLm3y2Yg2NafQOyQSvZErsUkB0XZ7x+/pHd8ss3ZAUcteEfPU?=
 =?us-ascii?Q?y6Zg5nC3pMv4gQw9u7SPlgaQStUbjm/aEDfdYH1BRJuQ3fgtOt+NiBmrTXx7?=
 =?us-ascii?Q?cmroZkTqNKnmGdSD9sO5zzl0Ltm5nqeMbhCrqz2rfUqNDcmNglGqJejSTCO3?=
 =?us-ascii?Q?JC0b82omidXGuJbcHNNVcYrD09bY/4iofjKcDYYQvTCblmSWaYqim4N7hUfj?=
 =?us-ascii?Q?XMel9FJnyhqO8UABef0Xvzn6jG4aURitEyeC00Gy99cmZvKSc1Okm/lTtmO6?=
 =?us-ascii?Q?+6MlEIOBMu91VBQzYE+CDuezTWScLF0WzTuZLgBM3sGSpnTV1n6GTwEjADhd?=
 =?us-ascii?Q?rcYX1HEBKaZE9Qt1y4netf5xiQhf+/61KMuymZcZKaifoiM9DV92myEvhTmO?=
 =?us-ascii?Q?zG34/2To6s5S04JcAQ2JlXTpeH3Cw68NJms6J2GH4NFxBnYn14KBltCGOusP?=
 =?us-ascii?Q?gvVI2dZujG3qOm5QuS76uty5GRr2HidavJ0F/oLJhtyHqxrK9ggwC2ZQ2lqu?=
 =?us-ascii?Q?l3VuwdD3yEudQh77QKwwh29JxphMGzbdBz/00naA2EJasyQPiGbbC2hiCxVl?=
 =?us-ascii?Q?IVou3blh5v73N/2DfgPk9/BHN6DzV5eSGTbhapw6lS3DVqnwM3UY3Fyacp0t?=
 =?us-ascii?Q?/yT90nc9Ai8c3QRqLUvv9f+rJ/XxVZd7cQyrxmjLRZWwRcSyyy3ZqDd5d97H?=
 =?us-ascii?Q?VbIrfta0oTVwmx3RLzNxlR23?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56160389-bdb6-4fbe-5482-08d925e67e9d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:14.8373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mYT12QEpuhONSbPl5c8dhV7PoJX1sYf3t7KAEvWLFmQ64cP7Gy/uBVAMaHPzsjOkd1/6t3Zf6MqtLSOPg26Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2369
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Add video_codecs query support for yellow carp.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 54dd1bde202c..11b292131c02 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -329,6 +329,7 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_VANGOGH:
+	case CHIP_YELLOW_CARP:
 		if (encode)
 			*codecs = &nv_video_codecs_encode;
 		else
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
