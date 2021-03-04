Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746BFC43381
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 17:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E9D64F1E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 17:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E9D64F1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD7C26EA54;
	Thu,  4 Mar 2021 17:41:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733CF6EA53
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 17:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvQy941EK3CeTpuskqx0E9m4lA/q1EmLhd3yy3BZ+pQfW7nD/Mvu+F1cnafe8UyyAdVBhOAtXSpgOfi/AyYtDMBFiPKmDhwgkW99Ukpims+WEFjSv8QkqGGn2j1x2kVfiKEFu/RfdaYL49NveohvmI1p6cKmJgf9AI56lcVbBtu4OUcPbQiTChq9RM1PiQhBtxMWaPZu/MyrTMYGpNaCmcMJk932ZbNBIAD9HwS8EzsNAJEthD+4A+XhZmacb872JBZiPn9oYbIp6Ne/FfT2LqRGv/11NVF9zFyW0zwHQBTSFG7uJ029OPf5GMsSOFR6mA9tHV20Xxeo1HfJUhae8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1vusSXf7zuQdGY8zu7ieXlcL3OfMHUT7JmMPBvm7HY=;
 b=I0KFv+miRg/2gLjoFlOY2JJqHRjtxHtlve9UMJtzISmoSlmCnru9Iyims3p0K9joJWpscpt7OFnVbgSuoRH/DaOy36lERMCtmNSOtg22KtNMdEAzAaCAI0fvAiETx8Cie/K/vc5vGZzwByHfmxaN/PbZnOEWVn6Kfd4DyjqmU983DBo9HfbotcuQccXUWtRMVs1JkAs8HoX8BtCcOV3m5QNu9QsXng7gcWnh+/CieDdzqWAGuuj+GI4GHW3oE/4b448w2Pf1FIeh2ccoO+vaef9nzzbEfuy4bZSQjSxrJCFHG/kUHZoXh5XAHJrZQ0V1bKE2tplUlSf58mnzgz5i/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1vusSXf7zuQdGY8zu7ieXlcL3OfMHUT7JmMPBvm7HY=;
 b=OiZHfw+Mqxe1iiKJfVIWdI1V6pzXOhfIqyeR34QamMy8ZhrUqB1YjdCj4BCNhwJio3oJf7Tn7jX9pVkRCSe57hzZs+oxHsJzzvuiGw720f/1IBmy6/QQ60f1GPgGF3pK+wq8M6fiw5FtPmMlC22BFd+mEhGToRt1vQ+txisGa+I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 by MWHPR12MB1341.namprd12.prod.outlook.com (2603:10b6:300:11::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 17:41:24 +0000
Received: from MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::e0fc:4c91:e080:7b]) by MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::e0fc:4c91:e080:7b%3]) with mapi id 15.20.3890.030; Thu, 4 Mar 2021
 17:41:24 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, tiwai@suse.de, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, nicholas.kazlauskas@amd.com
Subject: [PATCH 2/4] drm/amdgpu/display: don't assert in set backlight function
Date: Thu,  4 Mar 2021 12:41:01 -0500
Message-Id: <20210304174103.202272-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304174103.202272-1-alexander.deucher@amd.com>
References: <20210304174103.202272-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:208:236::18) To MW3PR12MB4491.namprd12.prod.outlook.com
 (2603:10b6:303:5c::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR05CA0049.namprd05.prod.outlook.com (2603:10b6:208:236::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Thu, 4 Mar 2021 17:41:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 896c5415-6bdf-4ab5-dac0-08d8df34baba
X-MS-TrafficTypeDiagnostic: MWHPR12MB1341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1341DBE48C77288679E32133F7979@MWHPR12MB1341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITRupL0jsLLLkERoMLkfWnJBb8wEQW3iSUwEiREfjpWm5AcHUcIqPEpncVSmywOz8ndvFBfdlmsaAWXXk6Fm2nQBwcxP/VWlYm8/gNIbzz9lHwgpR26q7X/071im5BWLWMzBa5G1qClX/OUPw3qIKUIVIbMHbNzTBfec4ikt/DilKDQuGvFRixmfTGLLxlN2UzPDqHKj/urTx5P/p7V+1RiQ1EkpSrur6Pgwo67npHT98mk7ESakb1FByoMBqTVplhZaBRGCApe0lNphjjUpljzxn4992IcqOJvO5Dn/uMyM9eVI58XxkVrP8d3eSGnDL/EjwkxS1kq+kCHojxo0mrJgbrahM6PdES3+3zyWpiR1TwpKEPe2hnCVr1hpJ4p+DhgcHyblXEPxnqnzFmlWBrVywnLQo/mZK7KLT6Dszm4hDvz+0xXqj01tna4TAZFeydG60DjK2adrbQLqUt9SdW1+csFzw3rwX8tL7/Q9QcFujkf4CibzzOIT6j9iJlFbsutOPfSqzW3Cou7rJp8Srk4sc2M1+RSwiCMgMLBKsO6dndE6P6oaCh9cDPGUQ4dpWHJyTq4S9TR3PaW4NLSUcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(66556008)(66946007)(52116002)(478600001)(6506007)(66476007)(4744005)(316002)(1076003)(2906002)(956004)(2616005)(6486002)(8936002)(6666004)(8676002)(4326008)(26005)(6512007)(16526019)(186003)(83380400001)(6636002)(69590400012)(5660300002)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?K1g1j2n+aKvp6SR1iK9vYLMmDwilnLG0U237GFumV3GaU7yPAteSGHgNpCMe?=
 =?us-ascii?Q?ReoiUmg0T8EbrGHEs3SmhnRT9z0UuzfbndkA9lgoNQagGfrCv1Hxjtr2NMZ8?=
 =?us-ascii?Q?ftDBodtSGEAvHUkYC/tjbQaQmzT9aYR8auFBKEQlQKK4KTlB8HJ6XTR7U/5F?=
 =?us-ascii?Q?rUTnH0KWhJRmSAelMmrFGrCsZ/qZANLwzg+5Iz/3uK6Cf1pkjK2heY/vOdW9?=
 =?us-ascii?Q?j+YmTkpE/cJWKwuckmYJF5Y0MVouEz7S3TNCdt0LILnCwmEexpqHZsEm+fka?=
 =?us-ascii?Q?fiigz+v6mVDVFfk2BjHXbbCfvjSy1cqdc+c/ZEjuOe2CGofz+EGAaQqo1Wu3?=
 =?us-ascii?Q?TGuCPaqOzm1DSeEbq+pbtopQrC0/LjntsfGtlaTaMnRKU2cUX3vtlwjDMxW9?=
 =?us-ascii?Q?xf/9ZaqSA+wiBv5RnJJ6Rr+nJYCI1/swwQ/lwfxAsEP6LbLysI0/jw8674QG?=
 =?us-ascii?Q?Ck8U3jwPp0d2Y19RIFRtr1OCqvEGT3bgfLZoLR4botVhYNtLSxt8miJynFQ1?=
 =?us-ascii?Q?iN6tZZ3fgcfywViHfJxIetYsgbmTuCPirkDONsB5wFqit1+3b6YHt8QAKvSp?=
 =?us-ascii?Q?sJTASC83GzLOYYjUuFk/dVcYIDxIm7IsCHxlerkcLgbY+M/foPqEciX+FtGZ?=
 =?us-ascii?Q?UUVWDHGUyUkNcLt5N52DpZQHj6ekMOv5xPZkICxj/oSEqrx2YWOl4tEUaOUS?=
 =?us-ascii?Q?UufgFFp1mSjDPGSlMjNCXHUmDLjdeK4pdlhsn9RRU3RN74snLJ/tdFZ+Dh0d?=
 =?us-ascii?Q?AGqvD5oQ6K/lu+qSE4Kj6hlVpPXw8JQ8z0YNqxmTR4DBkIc/fq3SlWxDjuqE?=
 =?us-ascii?Q?8z0mzjq6oUuq77BM0l55OySLEt9sswAtitDHIGRW98Ae1tp+CG5tGHk28/ab?=
 =?us-ascii?Q?hqRGSt7/X2u3B+qVwzsf5+nSR3kOD1DTrS3DQkovx0oN4dDgoNlsFYQhZk3X?=
 =?us-ascii?Q?X0/BEADOl7ju+bvuhywaubVIN+UkqeidfBzLrnbrVpqffB6khR4JiQOdt89T?=
 =?us-ascii?Q?p5qKiyflwjCfK2Vc3vEoeweqAr95hMh0cUz+KWUhFMmZCKW62XAO84Lmv6vC?=
 =?us-ascii?Q?ZsMNuEgo+50XNkatHZaaOPvqQcboIhCFKf7b0IKHNfZwUR0Lj63V+7YG/4+U?=
 =?us-ascii?Q?C2dfYY40icqrl6FVijUcIVH9b3TNx0wXD01b4E+xokT+B08x0uBtITnoS6Q5?=
 =?us-ascii?Q?lAyQwPr9QH0s6RkdNe35GPXxUpAr5dl2h09P6xvzkI9UVpfV71tWpDti3qpI?=
 =?us-ascii?Q?xtboVRboU2ObT46z6pR4nzEwMq7JwKgm8EWmMWyYZabZnFAT1bamXZuoadpm?=
 =?us-ascii?Q?zqdLhzojRuVnrDAnxLENEBZ6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896c5415-6bdf-4ab5-dac0-08d8df34baba
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 17:41:24.0680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlDDzEhdrpKYvuXNXqgz0YQVPJaAD0FMN2U3w4lvaVyzBlC85gMbmR5fommNiEWo3/4/6x2dEhovtFVHN4pWOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1341
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It just spams the logs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index fa9a62dc174b..974b70f21837 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2614,7 +2614,6 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 			if (pipe_ctx->plane_state == NULL)
 				frame_ramp = 0;
 		} else {
-			ASSERT(false);
 			return false;
 		}
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
