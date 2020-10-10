Return-Path: <SRS0=Eo7T=DR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C949C433DF
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2020 07:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA12C2078B
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2020 07:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tm/Jv6j5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA12C2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 254D06E12A;
	Sat, 10 Oct 2020 07:57:39 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680068.outbound.protection.outlook.com [40.107.68.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04FDA6E0E3
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2020 07:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDioiBdqEiUE0OAKLtYcFcIOnKdggrwO1AMNmWFymD6J2Q/XC9PJ0ljdu0ATZ95esDY4PzSmRsasIkMkTE/GtW0EMOnKmPnBNFsV965pdb61y9V180wjpAflNfO79Ki0Ku0HrdsGLVip7Fhqb9zaca6qhcW7ulvc3i1RcrFI8Udt9m+pvz37/i6YiLXhjuuCoqVVUUahSpqeEClM7EWP7NpeBzE/Sqxtkp28UMwkpHWkoFGc/7pjA7cniMi/oXj7qTKnh0JuOpwJna6YhDFmpqEVNfMkTU1uSqSsBC+znFydN1hcrjERzVhPopin50eSJHR9D+KkCqGE4hbl5qSYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF5UPmsjiatS7Z1qBdrvBUL1iyeN79NC5noMPdC/oP0=;
 b=cWGo8M/4JbaGII2WL9UElrzbpEtQUTCK+kjLm3z5PAG+5SOJm486JZQ5TGISz5+RBuAIKt4euFGCPV7dF5KQ0Py8ApeFlyQj9LN+iabmawGkusZPqV8XOYfOV+CXA/kcUFoAJbKSyaExC31Qk6mCZcs7v/7UlZDLRCSClYCDnpLupDknPx67JRUwOSlTGVZ48qp9VpZ8KwTDhCPjyDSL4kNxu8F96/tv6fCnk5QEtYWlzzWRc4GoMht0jzImn+kKDb0yU8LbkmE2mOlCxCdBfxVQxW2EBEERtbV1zgzOSSByibZUnkqvswvPn9xfWcQJBSyG+xekwbtO/1WTAsZtGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF5UPmsjiatS7Z1qBdrvBUL1iyeN79NC5noMPdC/oP0=;
 b=tm/Jv6j5KLYxJzOjOLi0UghPHM3eLnOJdZJ9PMFdr/X8kaT5/k21w1Byb/MEn5O72YhFzH6qza3/bzX7uTH3B61h870Gw/rj0zioaLLmigenXyuZwolHauDs1EvcyXF6WVQF9IEAnjVQgtm2twA/qCg+XQxuNch64V27za2puXs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB2998.namprd12.prod.outlook.com (2603:10b6:a03:dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Sat, 10 Oct
 2020 07:57:34 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf%4]) with mapi id 15.20.3455.027; Sat, 10 Oct 2020
 07:57:34 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: jiansong.chen@amd.com, jack.gui@amd.com, hawking.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: remove ASD ucode init for dimgrey_cavefish
Date: Sat, 10 Oct 2020 15:57:18 +0800
Message-Id: <20201010075719.16491-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To BYAPR12MB2888.namprd12.prod.outlook.com
 (2603:10b6:a03:137::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from taozhou1u2.amd.com (58.247.170.242) by
 HKAPR04CA0012.apcprd04.prod.outlook.com (2603:1096:203:d0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Sat, 10 Oct 2020 07:57:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46664582-8982-40b2-8e79-08d86cf22586
X-MS-TrafficTypeDiagnostic: BYAPR12MB2998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2998D105167B168EA651F03CB0090@BYAPR12MB2998.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylWAlhgf59R825E9ZcPzZMEl/luO/h3BMeWG9+HskZBBmdqeGU17onzzxeu4Uhp/TEc3QCgHQ9/eVGAipj9FJJpDqQ+bGzbRaD3fYHDbtAeNehOFmmV6cxopam6OEZsvNj2Dvhb9HYZwrstuI1q3OJ790pTV9Gv13XIVluX5lfX5rlvXKum8rTGGtM0YzzwXcP6tUdY8ajbZj2JJzxSIs4/hukTylSODDlVOsCYIFuQPjQu4iyaepbhF6s3xV3OjZuxjyLyydRwb/cihW/tL04quNrcI1HpWgeBuspS+teg/pAiQOErW5pFOSzbk6oTi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(6486002)(66476007)(5660300002)(26005)(186003)(7696005)(478600001)(83380400001)(8936002)(4744005)(52116002)(66946007)(956004)(6666004)(16526019)(2906002)(36756003)(66556008)(2616005)(1076003)(316002)(8676002)(4326008)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: iPFNjgKFcRP5nwTl19TmzjL0iVIx2LWkrMopkLJzTZDMqd69r1YNLaJruAnvOJEpB0wwQNuSz52Q3sZwacatNi5LYUDRE6IvaoBzPWEBJF/l+NpepA4H2UA6yhXX4SB6J6o1gTtUBfkvAkbghKXbYlUeH+79PBFn8IAXJtvuDl5oNVwl33GQcoDZDlmSHupMV0DqqKNQcIyVFtNVNLLhrbi2+7VuS4nXKeHxrfEOv8EBaWkWwG6Fn14mO/l8gjshwbAXLmhtLE1VggeeC7hJ7e0elLordR8HPj9ZHu8L5wzsiYXHOWCbU1G32qMYZw1jMRUFQ8a5HS4jayGartLYT689Ey+Ym5OxccaWwvFKFVd9ceSx3U+l3gA0tR3mqrQ0sDudZ7linAQn7KNPe4ELfjiC8/MowG14LGThLvBio4ZCxfprODQvT05tdi+6W3QRotlo3mduSMxwh4U222YgqZiwfi1QcJp292HGvDOntV1+eb9rMDz4Lx0MDVA1AlONgKu0XAeE2Ar/CzQGs8DzM7BQMmwGWlcWf3pNQktiL30w1F80aYQKAmHOtymobEAQc3E4eRUchf9zEnbC/dnqJ7fJlMi05NkxUEMSmUuGBVcI9SuGW5ZGufug4CRwLgg5FaeKIDBBKLqNZAHyIg4afA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46664582-8982-40b2-8e79-08d86cf22586
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2020 07:57:34.7132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yirQzCVvpruh0o+WGyIFjPTkGkI+os0Xk+tCJ5RpJ8vGFbyHkyLNkFQLu87knQXS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2998
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dimgrey_cavefish has no ASD ucode currently, remove its initialization.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 993846f1d89f..b4cb31c3fe02 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -201,9 +201,6 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		break;
 	case CHIP_DIMGREY_CAVEFISH:
 		err = psp_init_sos_microcode(psp, chip_name);
-		if (err)
-			return err;
-		err = psp_init_asd_microcode(psp, chip_name);
 		if (err)
 			return err;
 		break;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
