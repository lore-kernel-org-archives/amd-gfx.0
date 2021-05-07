Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E70C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 19:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7389D6128B
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 19:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7389D6128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66336E3C6;
	Fri,  7 May 2021 19:07:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCFD56E3C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 19:07:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCfQwuN+6UuzWg2lZNHcwsC3YKhP6z3jAAWNSUh7WtI8J+MUL8IlITl7M0jWfCCuVbapddzzIKT/S8iDv0A9qBL/AMX/D0nGrhEtsiXgeaqdXlV7VJRsv+11pjyEbInpKAQ/BJEPXsUFwrahm4Kh+DINg1qH9cXDNarjPMlgDYokFIi2xW59csGqGlf1cXBx/N0dneREjdfhiA8LtGH621vGYo2ZML4ZcP1yM22ZqpqaNxKNmlNA3SN1CjpQREmHWJQz0rmBMNv7vUUPe65DsWPmTvr8Dmi3C2JjLO7blmJH0zg8cKvW9Zqgexx+lWLoUYnnIP5BX3cTHL23q/mXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daNDrqee7CyfFYyJkaWser7i/3mRXbpyZbMJaXOJ1KI=;
 b=Nbz0OCuhJhacKLAnvaPqDUgJ8qjxVnizqe6RqP+jnIVgVNHC0T3RrV+ev1Qq9Fe1QnYKFUa7nAMGsXwRoIAwMW/+TPgpKzYs0hV1ygazNik7PmjxpOAndqLjMz3G9/LN/KcHD6oT6qovlioib1y9p0SutEHErn2B/VU3iturGze/6IArEavjCcIzVovj7LAhcIDHy+ZlJy2T308vwCsbzQvecqRoVj+LW5Wn+B+ciCECehdhjlEMiMhiRjTGbfCweIQK0DEcEbK2Oj5EkLIbRVDmOgJ7A87xuxQr+fwaUXLJBUUAoU94UzK1zsP+i+kX47yTEKx2RaMn4ifXmOm/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daNDrqee7CyfFYyJkaWser7i/3mRXbpyZbMJaXOJ1KI=;
 b=b98hFYA1Dpfut3AtOm9Y6CDYBWN3cZG0pAZn83Ks6gqz1Oc1Zx9Va75mmGwzQoEwhAel5u+0meLeauuG/D4EnQdsbsu+Idnb2nWnRcSQc7CUURLa9rh9FKH/MgUA2GpF/Hi05RaSUbznDbZSQH6JZnuxlDC4VVJ1cZb+BXAK4OE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR12MB1756.namprd12.prod.outlook.com (2603:10b6:3:108::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.26; Fri, 7 May 2021 19:07:19 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 19:07:18 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: unregistered range accessible by all GPUs
Date: Fri,  7 May 2021 15:07:04 -0400
Message-Id: <20210507190704.7682-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210505175617.30404-2-Philip.Yang@amd.com>
References: <20210505175617.30404-2-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.38 via Frontend Transport; Fri, 7 May 2021 19:07:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3353ef5f-440f-47f9-26d3-08d9118b55b6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1756:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1756033045322AB6D19FA35AE6579@DM5PR12MB1756.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6zYZ3QA88TETka320ZrPop5HWcEchm1S+jCkeyyujAI/3KSjrP/HrheOyeQVxxOdjRT5IFFoK3kZbD7ZepPIY7ZpsrUHMOVy9DJoX+dci7AkkBgXl49dWUmvoDVVYWGSGRzCcCuJmrbOI2ZQJSc4N4fSNpF1AyTWysMkUQMEKPqbfp2812FxbhWyy9hbIvLukkA5Z8DUEe5OwBao7eWyocsVUBU4vqYWwLr/QOOHB3GqTRMcDJe6UFBQ8eXNHk87qBvWCPNlXoUrj+QOZJvTn+63iLN/y3kazU4kMQ4nZJeUV8IzKVnPNAn6UU6qh/IvobHGuozLhwK7CA2ycuxsIpSAwrIj6dySN84fdPn9jp4Iq/1pY+6vcnzuc/lTw+//4092+sTExcR2EOZHjdgeAh9/EOY49jj7L6H8Zd25Dus3eeMBju3ilvIHSsSNDQuSL7vLdM7gA4XrTg3LrJXHbvkY6QLrW7907g7DLFpVkm/HMRN9U/FfRB9xR2e2rwl/4O535306zbVtfJ5J1PZBMNhDkygEPvcj8lVDys44xWP3r/Mp96m0FT5JjUsvmTbJnctIFaDHO4xmrvXZ5f4G8eTTc+j0CsO0YdP/iR/9hOlSDBWpKZ7Z+liOeCJThdYhoNF/7St7fVmw615cUm/oaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(8936002)(956004)(52116002)(186003)(26005)(4326008)(8676002)(83380400001)(86362001)(478600001)(16526019)(7696005)(2616005)(38100700002)(66476007)(38350700002)(66946007)(6916009)(66556008)(316002)(6486002)(6666004)(2906002)(36756003)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?o7qpNAoFFdMg0bGQubxBpnn0qiFTVLYj4g/9f8BukM12m1FqKWwMAjm64LMY?=
 =?us-ascii?Q?tSis4eoLdiqxbfXih/nzuTCzJYv5U6x9VY0+N47IPPBzXwSn3+3oYFrERUen?=
 =?us-ascii?Q?UOeOqkRtsr8yYc/AdOCJBFdDUDMu0BTf0Q7Vpi/1Og+s1/w3q6iZXEagZZTh?=
 =?us-ascii?Q?et2MOzZ4Gk+78Nopfa0A6COVkpIuPThWPN+pSk/1KWLajQDRGfljUIdwkX24?=
 =?us-ascii?Q?gXV3vU/W6zoPfZt7Ebk1H1uPxnSoAQeuu/Y648jYrxajh6Tl43j+e76eaKMe?=
 =?us-ascii?Q?sxGhkBVe3M6gpsyAt3W4IN/zYlK+/FnQw/X/JKdah3BX0pGPR+QW9uBoyHq2?=
 =?us-ascii?Q?+JJU0Qq+8Ign36s/8prlT5OlmAClGd3G7lO3nCGgT+p3AKTMhuqttN0YtqgB?=
 =?us-ascii?Q?rX56J07CHw/2JNL0bcqqTnuyb9mSeS3fEZKYH1re5RoN+XlFAuJSpgS/xwJJ?=
 =?us-ascii?Q?Q4vD4fAT5OPingfXIpVKXqoOhzDPfjRro/U5V4KkodH2+hccDHY/ov0Z2cnr?=
 =?us-ascii?Q?usEFRhgdyrL/3dGe3B6+03GO1B6CH87qjihDy4lXniu0Wvp4Z+kmhNhvcMs7?=
 =?us-ascii?Q?+A9YoUbTppe+2NNuza4/MI9jrXEpNqzdz1cVe05or8HLGZXQRtYogzSMj/lW?=
 =?us-ascii?Q?R/JBno8eM5pt4Y7owepUS8X7uM9xwlDX3yyPjEUMJ5iHKmwRhp8uN4ZUXrjt?=
 =?us-ascii?Q?RRC7uQaUCwYGppqCCIJN+Zlgg95tEaYhnjeKDi2v14ZXgoW+fmifT6P/VaZi?=
 =?us-ascii?Q?9fbxHVrxFsQUoiIb5Pg0hmh5ZTot5wTBFvPci9kYhQqYjxJJRnw+D6yshq/W?=
 =?us-ascii?Q?4hgkxxJE3XLz6KnsoQX9rZkiMCUjnqxK53c87kY+G7PAWPAvPj4PJDbMKhhj?=
 =?us-ascii?Q?0x+knBXyiChKojNKpBjN5wkql4BhJmER9AvNAL7fi3AL8RnW/XeYDJ8cCO1y?=
 =?us-ascii?Q?ZqO3e/G3laVIqV+Sy4qWHm1b6afVFj27Pq+ZJoIgtZgeE8aKsTGHiAhUQ9Pf?=
 =?us-ascii?Q?QddNRZvkij1QdRLDHcUVglL6l/71CTBOVJW1xEcVqKjvuIe9YNkkj/ws1z5N?=
 =?us-ascii?Q?CFcLT0wUs0CNjYmu/3jILUN4WVfJ4cjwru/PS3rzKmoCpuMgLbcus0yQVgXu?=
 =?us-ascii?Q?n4W0ME8EivtQBTvj2eiYLXpdodH9S9aS7fzBL5XI1fri2o8OIl1IgkFIA0Hm?=
 =?us-ascii?Q?E+I59WReH5F2vqNKVWdhTnKuWwjXatJkC547wQjBHwMTerzhiFblT++u+jrk?=
 =?us-ascii?Q?GSQFJiwaICvWkTvZsUbM6tkc932HD7bsFFEUljOKDW3nNPV0Ijd1uj9sc/q1?=
 =?us-ascii?Q?pDr5YsAPLxRzXHqFScl96k5w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3353ef5f-440f-47f9-26d3-08d9118b55b6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 19:07:18.7911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDRaBUfs6OlpS/h5piX8N1EkF80/w+Eg1QxAO7zBcAdSBMgUIwCI4zoe91w5uWIW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1756
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

New range is created to recover retry vm fault, set all GPUs have access
to the range. The new range preferred_loc is default value
KFD_IOCTL_SVM_LOCATION_UNDEFINED.

Correct one typo.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d9111fea724b..537b12e75f54 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2243,7 +2243,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 
 	prange = svm_range_new(&p->svms, start, last);
 	if (!prange) {
-		pr_debug("Failed to create prange in address [0x%llx]\\n", addr);
+		pr_debug("Failed to create prange in address [0x%llx]\n", addr);
 		return NULL;
 	}
 	if (kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpuidx)) {
@@ -2251,9 +2251,8 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 		svm_range_free(prange);
 		return NULL;
 	}
-	prange->preferred_loc = gpuid;
-	prange->actual_loc = 0;
-	/* Gurantee prange is migrate it */
+
+	bitmap_fill(prange->bitmap_access, MAX_GPU_INSTANCE);
 	svm_range_add_to_svms(prange);
 	svm_range_add_notifier_locked(mm, prange);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
