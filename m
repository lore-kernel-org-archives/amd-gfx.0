Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87BAC47423
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422A6206F7
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hPbWH4e5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422A6206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 182CB6ED13;
	Fri, 25 Sep 2020 14:55:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 103456ED10
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3QvonX6i2Vr/SDXLqRR/I+slwsO4VYHHdHZkO3BLAVXd3pa8sSzYUy4lElnjpRO6GMLA+8ltXSn7FteG/6iUof+1eR0bzpl1iL0LmixGOEY5wd9piIGQSLkzW0z6R7GFnZS2mtTKqU2bkVQX3PNMi4aK7rQR1aF3IxlXpnZ68SZrv5s59GYWyUs+sIlW5nwO5muImrJ/WghlPiKihL7B8YU3PwGCQfSPyGNBrFvK6TcP95b6ceyuLxbKuObltxnNZ47MK4qjXT9Mz3gGDtYQNVISpDKLGFhPosNse06BNTQzsLAUz3ottdX5RmC5UlOykiA0M5ibPFaFIYFlSZ8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmOvfbXhwUWJVJNfO2yT6IND5VJy4ZtmoLBFmBbOmT8=;
 b=mzkUL2HC/FzYXqWKC36I4/o4qW+2d7xtDsRc/xJ+RKiv8TAVUujld5dWqXK1dsLLBq5EgAu60DvWfP9+4b9x/LHenVseTHyxDDalV8KO3u7fvbzidmL9UNFukZZ73dSOlBEYJnLgulzb7/VLhScIfB1Lrcd1uaHiQXyTEEYLAyOJBL7bZ9M3tvKMFjZgjgyxmxGvx46N4RVmG68OBHS4A9S2+764kTlo7NVv+8Z3QMPE5FZUI+gHQkGRMZwTFtI6OJCoRy59TFX/lFwqWY9y4asKJfKGd2aKIiOfnXExrRtUA4bGBesNz6n17vuBp4KUajrsq6xCE5Cdlob2w9YySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmOvfbXhwUWJVJNfO2yT6IND5VJy4ZtmoLBFmBbOmT8=;
 b=hPbWH4e5Nvd4I9iQR/FXBCWPTiRi4V3ErIjeFPlTanrPVOIb+3kzyZIcUEsKojLE15I0nyVGWaSff/Poc+EPRyr1rMuEVGVVOyuRnzirN92bKvTa2+RTxphqq5EHCUwn+C+H63D7x98fX70TpisajGwNELDL6TdYx0ayBzAN9yI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 14:55:10 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%7]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 14:55:10 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/9] drm/amd/display: Update NV1x SR latency values
Date: Fri, 25 Sep 2020 10:54:47 -0400
Message-Id: <20200925145455.2398170-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
References: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::980e]
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::980e) by
 YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 14:55:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6abbe80-8db3-4ea5-3a70-08d86162ffce
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4219E207F759B1565084516098360@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bmtHQvZPKEuflh4E67aAsnERHcB0Tb56h+NNn0TTyu4gUV3sDUmSjAOKtLTkxxdvARacfwHK4val04PyoytI5wYHjnV46FPFpHzYqNKEaRmOG7m3stHVjlRlQkid2GWti0Yst/lYwUWTLoqQJXa/nCkSE8S8TV8r/DY9lDrqIC4anBfJEc7OhI4zZd1UY0HhvSAR60RI+2s2XaVhiCHjkspqG+KM+F2NaDqhNijcYeyv64Qk/vgO4tbKdpeOtwWdu6es/lZQqYjz72vTF9h0VNqewUppJpBwvFMSP44vmf3yzPxlND6U6ldZIhUlcfvF9gxHTz2UwKMJgdcobU4eK1byRTlJ6yJYZ39M4HzHT/oGjkL4/FZt7i2DHLhFAtAC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66946007)(6666004)(36756003)(16526019)(4326008)(6506007)(52116002)(2906002)(86362001)(15650500001)(2616005)(478600001)(6512007)(66556008)(186003)(66476007)(6916009)(1076003)(5660300002)(54906003)(316002)(8936002)(83380400001)(6486002)(8676002)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qywsJzEBZPq80py+5lWblxCpb9pfFL77SkELT5qouZVouHtN+ZwS8/OUYtbbvhSSNvFDrbQLdMY9OpZKmKDc8JlmBDJuK/oniq+Oi/XhPZvqrnUM2/gCnFEPO1GATLSzioKyTy9iOn3dlncM5El/e3G12MrlghLUIfYRvhLxHbv73drpGm3Zndq+aIjIP/lXu5vKFNE93g2JdVEEhD1bPn/EhgVAj9qB7hGBBCbRrcK+eIFzyRuDSN6Py7hdZ7UN+syQtJrLGosLPfUpAQYF0lgwbluqL0CU2VSB0MVS5YO4GWIczs/4+oOfLjVy2c1RHgV1f7VSK2kjwDIZsVqT5q45Pk+keAK7g0E48QmI6I0ZAUIARpPnoFexgpvGmc5/ddd5GNSXXg09G/DBSjtmVxFSAeWsP/vso5j68yxArk7qGJb/+1LOXUh5b5Nrt/VpzgP7qTvRHlRv6NUzxrMZNEUhYV5beGJwQ47yzzmUee6uxHErSRODNjbzq/v8r8OG+3Q4+GugNxhXyOb7rG7DKdljadvWmamZac1zvRwFvJkKF2P5i0wO5+UoWZhyIEhwYFdMqs61Km1FamI9gGrGhXHXha9nWom/2YSCi3UN9ctWm78jyOgSwuAI+f+aEyOGI+K+WR9/LQk2d3xDTlmGesZAfZT9xdY4+iWHrGRROr2yFm0eGwT/zqUFQ6ZFy4dB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6abbe80-8db3-4ea5-3a70-08d86162ffce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 14:55:10.1948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Ak7Sa3qfCN0XqckpZKW7SmyjvLTogy7RxYMu6dnZLMnjvCwBLp+FnxqNeJMqI7yRvcb4bVExicnE3pEhfR7/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
HW team measurement requires updating values

[How]
Update bounding box values

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 18b9465057ff..bf37a229a342 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -298,8 +298,8 @@ static struct _vcs_dpi_soc_bounding_box_st dcn2_0_soc = {
 			},
 		},
 	.num_states = 5,
-	.sr_exit_time_us = 8.6,
-	.sr_enter_plus_exit_time_us = 10.9,
+	.sr_exit_time_us = 11.6,
+	.sr_enter_plus_exit_time_us = 13.9,
 	.urgent_latency_us = 4.0,
 	.urgent_latency_pixel_data_only_us = 4.0,
 	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
