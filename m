Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B6EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 19:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6356910E256;
	Thu,  9 Dec 2021 19:15:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFFFE10E256
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 19:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlbvmKvg5rDiy8JBYc11FUmbgqzu5ev9P7R//oVZPt8iZRxagfLK6M51yxRz0Zr8pJokpMBUFVNC8KOwwS5JcZgTPRrxTaIJ4E6VRyyDNtUjpaTpa4KSOIaImdrARYeZ4AxOGtEN3atlassXs14LGo16ur0YnymRkm1gQNlFH5b/Hq80kVHaWBMESRCUlZGwSwUXZ6N6AoIY3cytmEcPCjZ8b/iowYwO9/AMmuzMY1SWv+qT0+mVDy1UGaGb69jjv720yxzcnjYP214kgJfWOvVMbb23U8Z2Opq6jQIG5xChq+Za5gfePcAnVJMtCP4BaMmGBNdSL2VTebvddgHMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzIwKQHkV32uPp70BznR6AH+zHmmScZvA5+lBuWGWYg=;
 b=E/UntlMqqvAju6i95FBEwCMj301JKZd3KiZpvP3IGJQNbLva/uhEo2uBHtNR7kQSXiOFT8Go48Qvik/l9Go1NQACI53JMqqSDxf2NKwHvcjlWEmjRuXZ3RnJzJpeRwzIjLmCT5HUYHGpfDb1stZCkQ42h55TraWyBmeXowhwz6jk4df+pG2t2/RIOWOewfvQT3CCMg+rCmsn3MreJvOLXRJXmB/mDYjLKn6AQIG42UjX1uDJhQrxDGehufug7A8RYcuWeqj3IeJqtWTB7htribTYUAY9stI9g+3kTz9r/XJ9lIu/hy0z8BQN0IQGR6IKSaOqP2gB2LRk44CRitbcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzIwKQHkV32uPp70BznR6AH+zHmmScZvA5+lBuWGWYg=;
 b=fBXkcfosQxUOBfrm9J9aWpMjm3meBHBAOEbDBhmMWNn7G1L4U6N5imM9g1UKg0STrQYgVpZ3cvcgCyqMSCIs6082HOjwuWuvGnBfzN4zbrRqBEri9U9uvGpVfY3Vtt84nPiqZYgcnqXlJz2kfplYBVmVJBmk7yJ11ffVo8kqhLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB5566.namprd12.prod.outlook.com (2603:10b6:5:20d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 19:15:25 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%5]) with mapi id 15.20.4734.024; Thu, 9 Dec 2021
 19:15:25 +0000
Subject: Re: [PATCH 1/2] drm/amdkfd: Use prange->list head for insert_list
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211209000340.974954-1-Felix.Kuehling@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <8ba69c49-e58e-d730-22fa-a081571b78ea@amd.com>
Date: Thu, 9 Dec 2021 14:15:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211209000340.974954-1-Felix.Kuehling@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0020.namprd15.prod.outlook.com
 (2603:10b6:610:51::30) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 CH2PR15CA0020.namprd15.prod.outlook.com (2603:10b6:610:51::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Thu, 9 Dec 2021 19:15:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec21fd4e-a325-4839-49d8-08d9bb4840c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB5566:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB556618AE4BDEFB813F8890BDE6709@DM6PR12MB5566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jv1xWzJvOXCKFcSognNZFPMruHKJHRc1NHydcaHXbK3IuyhR7IXhaHLNfC78YSqlayaYEYsTyXvP0Z1SWYJ8EnWP9/vFkohppIgXjRJzdOSZUkwaMSvi8bAX1p32mSBUWUzzwLwBRf5cNdaLTpjR4KT7ma6iXg4eWrggVXvfR590g58uzEXnAUg85F90SYBP0xvZmS6A4apy5BL3eulx5RUqDeMSdJKD9pa2IbbAptIXcxYdLUvYpClnSyzc8HMZy9EmmWgaeaVNc4MPH2OYM9S9UeOtg2RGeeM/EaI/LRFMiLjilB5IT4rnETozXrmvaUOKPWMocxE84FqpQXaNzp1e0tZt7B1q/i88YdsnkWFivMhlV2nG6ejFU7sB/ZWtVx/F1bsDP6ES4C8O1KBfr7hIODcVRT0adltIEHx9KySog3tQpneoyNlGcxZxezO4M+3PksJELnzKv908h8gj2j1b3rU9IB1ivRNgXJ9SjLkYgkYfzwPySlj/fLpVCAJdI4UFgb8lZ233OIL46jGTkrEXeMiKWeDFmSxdiL6lMCnAtS2FKg4yndGAM7xfOAH1v1JDQ9hmCP3wnfQvB+uZ80gRc88PbJ4Tz3hEgopvELPXwnE1md4DRiCDLqcYn/GoaLtqtD7OjCgfLOkd2C9vOhZykWPZ7g8o+Sw0VL+2ke7yrS/50fCDxnv2AHdMSuLNWsMK/gfx2S8jhs87AGBUAPu1/AHA9PtTlJQL6WRN8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(66946007)(956004)(2906002)(66556008)(66476007)(31686004)(186003)(316002)(16576012)(2616005)(36756003)(8676002)(4326008)(26005)(38100700002)(5660300002)(508600001)(31696002)(53546011)(8936002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1dySk9la2M4dXQ5V3JNeUpvRW84Q2ZmS0t5M0dRT2ljM1oxTHpHUHpvQk1q?=
 =?utf-8?B?WVRwOFdpblcyZTBWVTNIK3ZsZHhIYU9WeU9jZ0djQ1NsY3R4bVNvVUdWVzdo?=
 =?utf-8?B?RnM3czl3bzVFVzllRUdNM1BndjVtK1ZwMWdlZWNpd1h5UE9FNVIzb2VIWmsw?=
 =?utf-8?B?cFByYURkOWxkVkN0Q1NsODhLalMwNVJFeHU0L0pjQVo4dmdSTDBKYlBkd25H?=
 =?utf-8?B?NjB5enRGenJnMDN6TGlqSU92NjNzQU0xQXJvL0dGSlRuWjBFNEhXeTl5WXRu?=
 =?utf-8?B?b2xhVk0xV2dyT2NlWkhCcWptS29ZcVRNRXJwNURURlFnYmlkQVcwa1k3bE5a?=
 =?utf-8?B?dGo4U1RNL0YxbUgweXZZcjAxYkJrbW90RzdUUFBhMVZSTVFxMzUzbXpDTGtI?=
 =?utf-8?B?cC83L2xFRUlJcml4Z0M1MllRbFBpckJ5bkdpMVFPWjFMbVdOY0h1cXVqeUc1?=
 =?utf-8?B?YmlPRkhyMlJFbGsvNlRadmd6Z0tHR21laVUzRENLQVp1c0tDMFhRWSt3Wm1F?=
 =?utf-8?B?OVhPUG9hajhhNGJsS2Rvc1lNOVd0NXpQc2VMZk9NRm9hNHNQcnhrSjNidDds?=
 =?utf-8?B?cExvaWVOajZCbVVENTlWY3A4U3lVbHc2M1dWc1pvWnFtZk5xMWd1bHYzKzBj?=
 =?utf-8?B?QzBsazhoUlNqN1BBM1N5UFJUb3hQeXpPQ0E5aFFnM0dNaGZValBBSzV1M3gr?=
 =?utf-8?B?N2JydUNjQnpxUXpBaXIrK3JRR0p5dEl1My9vT05SZG4yazJTUWVKVERxQnJo?=
 =?utf-8?B?VGkzYTdjSkp4NDRxRFEwbUVSbkpENFBNK09tUm9oMlJTc1h1RG9QMzNWK0Nh?=
 =?utf-8?B?QkF0N3YwaWJTUVNjRzZwSm80RWFPYncramszL2M5WlQ1T2hOWXdTc1ZaakZB?=
 =?utf-8?B?cG9JelRrdDZlQkw4T2ZYU0lUeTQ4dnBMV1BDYktIMzBLZHZRWU42Unh1OEt0?=
 =?utf-8?B?enBub1ZySEw5ZE9Jd094VU1UcVU2WC83R1dYdzV2N0pwejh6Q1BWWmk1dlNX?=
 =?utf-8?B?MG9sRUhIbURDQ1UrczJQai9IMEV4Z282YWU2QzJoTUI5cTVQKzNBcEwzUUI4?=
 =?utf-8?B?TzRqMFk2NjFPMm9JbTR3VjIxOWVIZmdrNzJnejFCc1ZRTlFiQ04rNEVEVGhq?=
 =?utf-8?B?RE5XUGFPbXJQclVudHpncW5zMnZqeGpHdGU2TVpMalJ6YTUzWWJ0SVJvZTBk?=
 =?utf-8?B?TlV4TnR3b3lhK2pKbGkvMTY3VkpCOXY0bG9GU01NK1M1dzJ6Z0hGVnd5Mzdp?=
 =?utf-8?B?TVpEZWV6SnRyQzBNVkRLanB1c2NSM3hhb2RXYXFOQkloQ0VHTWpiSWxuRkJS?=
 =?utf-8?B?MzRLdEY1UzIxRG1VOGcxaHRkREgxK0tzVnNIYkJsTUswMlBERkhWdndNRlFY?=
 =?utf-8?B?VU1PMVRac3ZTQS9KOURsR0ZQYTBDczFOOXYrSElsaHYrbTdESVhzZW9aMjlR?=
 =?utf-8?B?RnpHN3ZKNVMxZXJEaCtMaHdmWDJWcXFDV1ZiR2NidnFtbGZoRlJjOXdyTUhr?=
 =?utf-8?B?SlZ4aHAyTE5neHhnUnhEdjRVL3lHclhiZXV4UitaM0R5Z2VIL2RjVHl2SU1T?=
 =?utf-8?B?ZllxNVIvZzlML1FWU3NkQWc0TVhZdUJzQ09pVGdQMWpTL25SNHNud3NNQmQz?=
 =?utf-8?B?YmZhNCtRYmVrNGt3cWRRZ0JTODR0ckhBYnE2MFVmTEFJOXgraE1RdmE2S3VU?=
 =?utf-8?B?TEkyYWMvYkJrNFVqOWduM2tPMHBGV1RtanBaTktuUmtBWGpub1RNaVFCTVBG?=
 =?utf-8?B?ay90eUxicEJoamhKMk5lN2hxRTZuVGszWVB4VGRNRFlOTitmTnVGcFlTc09Y?=
 =?utf-8?B?RlB6Y3kwNFdqcU5tYkdYS3c3dWt2MjZnTUNsRWNvNUtWK2VKbndIMWhuQy90?=
 =?utf-8?B?Q1J0ZHZEWFVscEdBTGxkTzJXVldJTXlGWERQV01obmI2VXc3Ky9GeGJUckpa?=
 =?utf-8?B?ZXhJb3lORTZ3cWlnY2xPSXgyc2pSaHBiSWwyQS9lWVVFYmxQQit2Q1pBeDA3?=
 =?utf-8?B?eWJiZ01RaEYxRmlRQTVqMnIzZ3h3Nksxd0FiVkRWNG9uQllOTkd4WDcxS0dX?=
 =?utf-8?B?RTZXUVBTZmthRzBUeWJ5UERuZHR2WTM3NFZqd2ZFUmcrSVQ0dk53Sk1ITEt0?=
 =?utf-8?Q?Vs3U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec21fd4e-a325-4839-49d8-08d9bb4840c8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 19:15:25.0245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMz2LhajTHVOmsJ8HU7hNRn/R6BYKYHejGTRGqxwJLHr3FMPqL4aqBlzEFy7WcgF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5566
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
Cc: alex.sierra@amd.com, philip.yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-12-08 7:03 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211209000340.974954-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">There are seven list_heads in struct svm_range: list, update_list,
remove_list, insert_list, svm_bo_list, deferred_list, child_list. This
patch and the next one remove two of them that are redundant.

The insert_list head was only used for new ranges that are not on the
svms-&gt;list yet. So we can use that list head for keeping track of
new ranges before they get added, and use list_move_tail to move them
to the svms-&gt;list when ready.
</pre>
    </blockquote>
    <p>prange-&gt;insert_list was added to handle rollback case if
      migration failed, to avoid insert_list is corrupted, now this is
      not needed as we changed rollback logic.<br>
    </p>
    <p>Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    </p>
    <blockquote type="cite" cite="mid:20211209000340.974954-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 17 ++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  2 --
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c178d56361d6..dea7c6236be5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -107,7 +107,7 @@ static void svm_range_add_to_svms(struct svm_range *prange)
 	pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx 0x%lx]\n&quot;, prange-&gt;svms,
 		 prange, prange-&gt;start, prange-&gt;last);
 
-	list_add_tail(&amp;prange-&gt;list, &amp;prange-&gt;svms-&gt;list);
+	list_move_tail(&amp;prange-&gt;list, &amp;prange-&gt;svms-&gt;list);
 	prange-&gt;it_node.start = prange-&gt;start;
 	prange-&gt;it_node.last = prange-&gt;last;
 	interval_tree_insert(&amp;prange-&gt;it_node, &amp;prange-&gt;svms-&gt;objects);
@@ -296,7 +296,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	INIT_LIST_HEAD(&amp;prange-&gt;list);
 	INIT_LIST_HEAD(&amp;prange-&gt;update_list);
 	INIT_LIST_HEAD(&amp;prange-&gt;remove_list);
-	INIT_LIST_HEAD(&amp;prange-&gt;insert_list);
 	INIT_LIST_HEAD(&amp;prange-&gt;svm_bo_list);
 	INIT_LIST_HEAD(&amp;prange-&gt;deferred_list);
 	INIT_LIST_HEAD(&amp;prange-&gt;child_list);
@@ -995,7 +994,7 @@ svm_range_split_tail(struct svm_range *prange,
 	int r = svm_range_split(prange, prange-&gt;start, new_last, &amp;tail);
 
 	if (!r)
-		list_add(&amp;tail-&gt;insert_list, insert_list);
+		list_add(&amp;tail-&gt;list, insert_list);
 	return r;
 }
 
@@ -1007,7 +1006,7 @@ svm_range_split_head(struct svm_range *prange,
 	int r = svm_range_split(prange, new_start, prange-&gt;last, &amp;head);
 
 	if (!r)
-		list_add(&amp;head-&gt;insert_list, insert_list);
+		list_add(&amp;head-&gt;list, insert_list);
 	return r;
 }
 
@@ -1880,7 +1879,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			}
 
 			list_add(&amp;old-&gt;remove_list, remove_list);
-			list_add(&amp;prange-&gt;insert_list, insert_list);
+			list_add(&amp;prange-&gt;list, insert_list);
 			list_add(&amp;prange-&gt;update_list, update_list);
 
 			if (node-&gt;start &lt; start) {
@@ -1912,7 +1911,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 				goto out;
 			}
 
-			list_add(&amp;prange-&gt;insert_list, insert_list);
+			list_add(&amp;prange-&gt;list, insert_list);
 			list_add(&amp;prange-&gt;update_list, update_list);
 		}
 
@@ -1927,13 +1926,13 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			r = -ENOMEM;
 			goto out;
 		}
-		list_add(&amp;prange-&gt;insert_list, insert_list);
+		list_add(&amp;prange-&gt;list, insert_list);
 		list_add(&amp;prange-&gt;update_list, update_list);
 	}
 
 out:
 	if (r)
-		list_for_each_entry_safe(prange, tmp, insert_list, insert_list)
+		list_for_each_entry_safe(prange, tmp, insert_list, list)
 			svm_range_free(prange);
 
 	return r;
@@ -3217,7 +3216,7 @@ svm_range_set_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 		goto out;
 	}
 	/* Apply changes as a transaction */
-	list_for_each_entry_safe(prange, next, &amp;insert_list, insert_list) {
+	list_for_each_entry_safe(prange, next, &amp;insert_list, list) {
 		svm_range_add_to_svms(prange);
 		svm_range_add_notifier_locked(mm, prange);
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 6dc91c33e80f..c3738bd35a3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -76,7 +76,6 @@ struct svm_work_list_item {
  * @list:       link list node, used to scan all ranges of svms
  * @update_list:link list node used to add to update_list
  * @remove_list:link list node used to add to remove list
- * @insert_list:link list node used to add to insert list
  * @mapping:    bo_va mapping structure to create and update GPU page table
  * @npages:     number of pages
  * @dma_addr:   dma mapping address on each GPU for system memory physical page
@@ -113,7 +112,6 @@ struct svm_range {
 	struct list_head		list;
 	struct list_head		update_list;
 	struct list_head		remove_list;
-	struct list_head		insert_list;
 	uint64_t			npages;
 	dma_addr_t			*dma_addr[MAX_GPU_INSTANCE];
 	struct ttm_resource		*ttm_res;
</pre>
    </blockquote>
  </body>
</html>
