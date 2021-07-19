Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E788CC07E95
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 14:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83B9600CC
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 14:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83B9600CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 101D76E140;
	Mon, 19 Jul 2021 14:27:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2931C6E0EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 14:27:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2KGHbr2Idow4l5B3QkA1XbhIS5rI9gXcZzK71x/BxjARlpAXmRcsZ6Cu+Nvv6Vw9wxo1tYFzz1KSjwk0XSKRNch8srqcMjkMRazVgWQuzM91MjOPHppru7sk54+Fc3DlUiQ0GvhNEOnws7T1ctgVD/W/kxk5o+UVYuZV0y+/H/zxCqsz4EX431/WDKoWoD7CMr+E0nRMHNXqDoW6s5e3dCvziXw5gKV18Qrt2BF1nSZ0ESSTm/CHR0CFDej0IV2TpD4x7jPqzkWE7O48daVi/GMoCSycSFyUQpm1fXPZ0PruF1qp7Ybf9eWZQkRt4rPVrLTNXtT8HsqMDdhKuE27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZAV9zVqwPDjTbNgPuV5HbVDc+oASn/4j+2k3UCY2Fg=;
 b=d53H5xDDCkdRT0/5LpbGfuKyxK2GJ1zzrYuXcrBfkssPgXTh2VoefJ15dj2Nj5cFo7XRaaMYsLBI80/QrpYtVSpwzzXqybYHN1Q0Iw73k8kokvel7rqVtb8SEd0x96VHL/EsjnY5R093Ynxwv9Cbpr5e7tWRDmH3P+uoot5IfSoLGOzUSzV4eOqiVp9xiPmP8pIe2RVyr3DxYJ6ySWYqrIzwLQUnqN1Vo/0QLg1gFX/W7CBECxys+sIL9SQ6ZNLxehDteUI4BFzdUGNxhDWXlWqXdLgCAgUHuel8PznuQcZdFpkgCD6fAT2FrdO6h31abFFzYbNrITPbg7rmvbbM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZAV9zVqwPDjTbNgPuV5HbVDc+oASn/4j+2k3UCY2Fg=;
 b=zFruhzMtWYfmZHaQopoM30n3vamj3AkghwHzFi6fu1Imn0QhOY/t58/lKmPXhjZ5lzXS63L+oZ5ULfA400BYDQWpiHH8wcdVopeaav5i6uJ511pZnkdJQ0vrK2ZxNTh+cyk5tZPaZ0p5u8q7sNJReUdfp363vj1IhSSKp6tdzxI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.32; Mon, 19 Jul
 2021 14:27:27 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5987:7323:7c90:a427]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5987:7323:7c90:a427%8]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 14:27:27 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: Allow querying SVM attributes that are
 clear
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210717024621.703793-1-Felix.Kuehling@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <af3b18ec-3a50-6b61-4c65-77ad480d4e62@amd.com>
Date: Mon, 19 Jul 2021 10:27:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210717024621.703793-1-Felix.Kuehling@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::30) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0151.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 14:27:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90d056b7-2091-45f4-2900-08d94ac1555d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5311357FF537345718F83239E6E19@DM4PR12MB5311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0xlJsV0rIo5cc1Qfs4aTUEpXaukGdANiflhQ3jRLniz9zNGUV4RUNvFjtXrO9aNnKrnUgB1S9co0uzO+jfORwWB9AGMuMlSCsWG/jQYbeQBupTQ8GVPmvY0ZJ+CJscFFJhwzTveEJZeyKDcZR45gy0Kcek06TRnan8w4GCfeftPkV9ZJ40Ej9A1oIYU6YA9ggD7ZrcJu2S9j3SAAlb1QR4aPaZI+dS6iK4Fsud3y87lu/fWQknKsfY02yB5x0aYDLqhw/uqZMMHETfIdWFUho5BvcOBF5cz0qZEhjIp6KomtcP3E6o0l5B9hrqEMz/ywP+br5fomOaQ2LtXaSVLd86SkEalElbC66zBok3PWTJPDA4gBP+fyW10vEdTywD6/cjeTMSRrtM5e0SBAV5KG7iy9q9fvX7w0aO7CAdvDV+uqxXxL6cx1EhDj7pJSS6uwLdxRmGftu2Q4xzXWGC9mJcoSPFbjKzhbh3Ff7nUr6w3BB/PqDYDFIa3D/WB+Fj/yF/MeFolzsw3Jgsm3BrdZ8mo0iV52DzaS69wpffdn1cDqsoHlQr1frXK67EzZBC8PnevZrx+WMQW2eUUTbOiW1LY8rjAEtcxZUfQ4tRSYGOslUGlpX9C9r+r+m3jJSXPMnghkwQrkbz+YArZjoZAsX0qLedWxq2cW3Adu42A8zHhBxixOKPhwl8BMN/2XLw75vxf83r5cqr6aVQy3Gh/hzi/s6AddtmqgSW2Ib67MeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(8676002)(53546011)(36756003)(8936002)(508600001)(316002)(66556008)(186003)(66476007)(66946007)(6486002)(2906002)(31696002)(2616005)(956004)(26005)(16576012)(5660300002)(83380400001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2VPNUdNdGJkejgvU00yRjkyRlVlYXF0UmpoNWdSNkY3NGhEK21lWFhpbENP?=
 =?utf-8?B?cFhvdHFtYlRLdnhPN3doMVV2K05oMjl0TkZFcWNxYW1UVkN1djRXTWhweHpx?=
 =?utf-8?B?aHpQOUszZW9HdE5sbmtORVd2MlAxZ0VoUXpmV1hCR0RaTVkzK2hwcUdpTGJT?=
 =?utf-8?B?bDg5UlluN0xjZno3WVhXdkNOVS91UUxhL2xRMExXWlNGcUZPYWdtaWxVTU12?=
 =?utf-8?B?Ump5SDRxdm1qbWVLY2NrVmFKNnRrODBhazFLSVlNZDhQV0YvdEpGeG82QXRs?=
 =?utf-8?B?K1JSdDM4bFJ0SVU5cHlYZXA3THFucm1MOGcrVlIzbGEyZ2NyalV4WnpwTWJk?=
 =?utf-8?B?UmhJSDUxb0RxZ0xSQmF3aStvditzU3hRUktRakN2VHBjeXRIdWkzcjltVWVC?=
 =?utf-8?B?UmF0dWtqbkc3dnVPQ0kvejJ4MGZZTW5sM1R0aEpxVnhWbERnNWJEc0NvOUt0?=
 =?utf-8?B?RGVMMVkyazRkU2dJU2xCY3JyNU9UbWlTa25OSW1sbStoVVNwOC9VWldDR0pR?=
 =?utf-8?B?UTZsaDdrSU01ZUFxSmJsN240S1ZXbWYwZlIyeHRCMUNWdHBEU3p3MWIwNnpH?=
 =?utf-8?B?SXc1Z2lhRjN6MHBtQ1RSMTBaSzFUV3F6czF5UU5FQzF4ckhqTXpYdXVrT2Ju?=
 =?utf-8?B?OG93aEpXUTIyL2I1eEZpaytBdUtLdDVIMURhSEhma29MT0g4UmFwMm5WQU45?=
 =?utf-8?B?U1BPa1ZPMlZRdzZNYlc0cmJ5N0Q0YTBObVc1ajdDMEhwcnphN2R5cFVsVktr?=
 =?utf-8?B?cGYvV0tvalhjU2JOVmYyVXZsZ1RWTTUwbnBNK1h1UDNYSTk2UUZScGRhK3Rv?=
 =?utf-8?B?WTRGbGxwa3VkVzQ0RmdoR1N3SnppWWJFT0RRZjduMDNNYVNXdzFPdTBuMXp4?=
 =?utf-8?B?WlhhSUMxeTFNaW5KQWdvRUNRdG9EanU5TG9ENWMrb1NQYmw5bEZCZGNjUWZG?=
 =?utf-8?B?VDNLOTJFV2p2Z29jcVloQVcxZitwNUhlc1MxcjZkU0dKTjBGWXBMOEo4ZFVp?=
 =?utf-8?B?Qkp1S003OXNlSjhKVWExeWkxajdhbjV3TGtzZEp1Zy9aYmxBM0FNdmF0bzNY?=
 =?utf-8?B?RUs5K1kwQVRGKzl6VFpwVHd1UjhVek5yMUplb3JERjl4Z1FVTFJsWVZpbTRF?=
 =?utf-8?B?UXNDODlTS2lwMjVubHZXVXpTWThVQjR5aG9LbHNGZnltWmViUm1HVnVkTmZk?=
 =?utf-8?B?WGtWQ3I3cncyK3lrckxBNkJFSjVFaUZ2V0s0WU8xSm5ESno1SjJoa0gwYng0?=
 =?utf-8?B?bXQ1VEFaZ1Q3L1kwWUtDVzNoaWNpR3h1N1ZXQWRpa2J4TG5MMXZkQlFMbmdX?=
 =?utf-8?B?RjUrT1ZZbmhlck1yb3B6Vkw0ajlaeGIyc01FbXg5T1JGQXM2enRrOHZmWG9h?=
 =?utf-8?B?b0hwOFpUZXNCQUY4dkFFdHJ0TU1LRmFwT1EvTEFpOVRIRmNLQXJWa1NHMlZE?=
 =?utf-8?B?RVZtMTdDUFM3MmI3UDNJMzBWTk83WCtIVUlmUFpMNGtrOGxLQUk0dGpDcThQ?=
 =?utf-8?B?Qk9RQ251SXFsM0VyVEVVbWtRWDBWZ1dHaUIxcnNvTnNJL3dnOVd5UThhaUtu?=
 =?utf-8?B?bi9jSkgxZUo5RytLdE1WamhzN3U2VHRvQ1R2MGhRbXgyT1RLdEVsenhqS1Vw?=
 =?utf-8?B?NU94ejg2aUtsaXVOdjB1NGtiOHdIelhJSnI2emNrbXNvcmZCZkhDNzFOQ1Z6?=
 =?utf-8?B?SjN5bHJTdU1GRHFiZzRBMXZwelpvNlE5U0ZCSEY5bFovclhuRnljY0Z2NDAz?=
 =?utf-8?Q?hrH0xrCKfR+9+th4FZ/gMO/LmIqTSl5OXrJxiH6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d056b7-2091-45f4-2900-08d94ac1555d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 14:27:27.2889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkNTAq5Ugd7sUOMxOwL8CzzEsl1QK9len8MWFmZop1jxsT9zEFXn5XUgnHcDBRKj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
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
Content-Type: multipart/mixed; boundary="===============0242572339=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0242572339==
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-07-16 10:46 p.m., Felix
      Kuehling wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20210717024621.703793-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">Currently the SVM get_attr call allows querying, which flags are set
in the entire address range. Add the opposite query, which flags are
clear in the entire address range. Both queries can be combined in a
single get_attr call, which allows answering questions such as, &quot;is
this address range coherent, non-coherent, or a mix of both&quot;?

Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20210717024621.703793-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 19 +++++++++++++------
 include/uapi/linux/kfd_ioctl.h       | 16 +++++++++-------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e7e99c5070b9..c66221a9c02d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3019,7 +3019,8 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 	struct svm_range *prange;
 	uint32_t prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
 	uint32_t location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
-	uint32_t flags = 0xffffffff;
+	uint32_t flags_and = 0xffffffff;
+	uint32_t flags_or = 0;
 	int gpuidx;
 	uint32_t i;
 
@@ -3046,12 +3047,12 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 			get_accessible = true;
 			break;
 		case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
+		case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
 			get_flags = true;
 			break;
 		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
 			get_granularity = true;
 			break;
-		case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
 		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
 		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
 			fallthrough;
@@ -3069,7 +3070,8 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 	if (!node) {
 		pr_debug(&quot;range attrs not found return default values\n&quot;);
 		svm_range_set_default_attributes(&amp;location, &amp;prefetch_loc,
-						 &amp;granularity, &amp;flags);
+						 &amp;granularity, &amp;flags_and);
+		flags_or = flags_and;
 		if (p-&gt;xnack_enabled)
 			bitmap_copy(bitmap_access, svms-&gt;bitmap_supported,
 				    MAX_GPU_INSTANCE);
@@ -3115,8 +3117,10 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 			bitmap_and(bitmap_aip, bitmap_aip,
 				   prange-&gt;bitmap_aip, MAX_GPU_INSTANCE);
 		}
-		if (get_flags)
-			flags &amp;= prange-&gt;flags;
+		if (get_flags) {
+			flags_and &amp;= prange-&gt;flags;
+			flags_or |= prange-&gt;flags;
+		}
 
 		if (get_granularity &amp;&amp; prange-&gt;granularity &lt; granularity)
 			granularity = prange-&gt;granularity;
@@ -3150,7 +3154,10 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 				attrs[i].type = KFD_IOCTL_SVM_ATTR_NO_ACCESS;
 			break;
 		case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
-			attrs[i].value = flags;
+			attrs[i].value = flags_and;
+			break;
+		case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
+			attrs[i].value = ~flags_or;
 			break;
 		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
 			attrs[i].value = (uint32_t)granularity;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 3cb5b5dd9f77..af96af174dc4 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -31,9 +31,10 @@
  * - 1.3 - Add SMI events support
  * - 1.4 - Indicate new SRAM EDC bit in device properties
  * - 1.5 - Add SVM API
+ * - 1.6 - Query clear flags in SVM get_attr API
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 5
+#define KFD_IOCTL_MINOR_VERSION 6
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
@@ -575,18 +576,19 @@ struct kfd_ioctl_svm_attribute {
  * @KFD_IOCTL_SVM_ATTR_PREFERRED_LOC or
  * @KFD_IOCTL_SVM_ATTR_PREFETCH_LOC resepctively. For
  * @KFD_IOCTL_SVM_ATTR_SET_FLAGS, flags of all pages will be
- * aggregated by bitwise AND. The minimum  migration granularity
- * throughout the range will be returned for
- * @KFD_IOCTL_SVM_ATTR_GRANULARITY.
+ * aggregated by bitwise AND. That means, a flag will be set in the
+ * output, if that flag is set for all pages in the range. For
+ * @KFD_IOCTL_SVM_ATTR_CLR_FLAGS, flags of all pages will be
+ * aggregated by bitwise NOR. That means, a flag will be set in the
+ * output, if that flag is clear for all pages in the range.
+ * The minimum migration granularity throughout the range will be
+ * returned for @KFD_IOCTL_SVM_ATTR_GRANULARITY.
  *
  * Querying of accessibility attributes works by initializing the
  * attribute type to @KFD_IOCTL_SVM_ATTR_ACCESS and the value to the
  * GPUID being queried. Multiple attributes can be given to allow
  * querying multiple GPUIDs. The ioctl function overwrites the
  * attribute type to indicate the access for the specified GPU.
- *
- * @KFD_IOCTL_SVM_ATTR_CLR_FLAGS is invalid for
- * @KFD_IOCTL_SVM_OP_GET_ATTR.
  */
 struct kfd_ioctl_svm_args {
 	__u64 start_addr;
</pre>
    </blockquote>
  </body>
</html>

--===============0242572339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0242572339==--
