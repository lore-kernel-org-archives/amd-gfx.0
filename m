Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D473C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 15:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DAD61364
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 15:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DAD61364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 725AB6EA59;
	Tue, 11 May 2021 15:14:53 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A84E6EA59
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 15:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeE63NN07ggjuWXJVnNCAW2rR0PW3XRbABPyobPk/KY6x2+DZh+izvGcGYVcoH5As6ImlhsUhfM8EnEmX62nQQ2t3pDgKS6F4WRkeGJszNiPKxYSVhi2c2n/NUtWvuPV8LBWDmWjory3soeaI73W8hiZxsgiWPOsP0MNTrSUCaUj5rlTTDs97dtEwgRQ7wrYINwjHjw9c4ADHrUmGdA+8OQCFY0WcctV37ZtdDPSzK/uyoJqNdU5JmCma5Q+xqgIYo4kGM3sWg6ChpLriUqVra9e0wIcLLQGWtrTGOhvvcYNptyu+gWZgUVcvVRmK4Rz2CHCrtE1jCEbWCYv39WT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgpNV7onLO7rj6i11pI0D1lJKiVBVoNaWGTsTl4ThQI=;
 b=WdRprYdiUyyMLwv/jVyH29VC66XPQDWhlm/ewL/xL4l0zXF9ROE2Pkks1JDUgR+gU+StNQMqLBUhQoX7woK+xmmMwnJdwW0xAPV55uB/jtVgN0MZarhDwzvycDruh8Ff7e4N3xyAmrWRdCY2+YH6aPawz/H00xk7sxd698qtHKhj2BwdS5CUMPyLST/7p/ND5dN3wMSxgHwcxHRZDiZpLNA7GudbwpDPOirizuK6W0FLqwUZWNBFVBIBwFpszDBMdf7CKrz+jFUq7cF3BjInlhMpiie27amI2hwvSFCTIyRKyszkoc320tc7MF/ja49SOGwlwEugL8eF4PHyirxmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgpNV7onLO7rj6i11pI0D1lJKiVBVoNaWGTsTl4ThQI=;
 b=r5pTXx0BPLMZoBib/50xhsTv/+qzepcWjmvbxRAG2p26N0Sznbl75+R5gFmbxsQXqfxgUDHICUdQpeJnTJ28jyMmhqHg00DXcqXRWNtDH27+iveZDooEQW8lQ8jmDlGVQE/++ka91zq5eeBWC3RMv5olq4trxJKkz9W+gwybURo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Tue, 11 May 2021 15:14:48 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 15:14:48 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: unregistered range accessible by all GPUs
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210505175617.30404-2-Philip.Yang@amd.com>
 <20210507190704.7682-1-Philip.Yang@amd.com>
 <21e77c32-4299-2923-e43c-821fe996defe@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <f5ecaa03-bb1c-f2be-eb48-d3173da8f73a@amd.com>
Date: Tue, 11 May 2021 11:14:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <21e77c32-4299-2923-e43c-821fe996defe@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39)
 To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Tue, 11 May 2021 15:14:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b59af6f5-4cce-44c3-c579-08d9148f8447
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3403F195A6F0AF87CAAF5A70E6539@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPDQl7tXlqA0cInPMl+rGYP/YCJj/ouRDPJFAMcMHzYwb3KEV1T7Q2YGqBUYYyGs0yvy+TfkIvRUcxZF+uUtCf6fzb2RUXRDIjrP5RoMjXO4ZxZsWD3RPDL/SRxWXnG6dooP/qaMAscFcmEmhhwONnzy5uvzEA83uItrwN5ICMcZc6kdEYoZ4ON5XqMMlX2q5yjqmeLe7EHGptCWJeB+TznhEo0kmyvQeZrsM8E+y7RJ4+4EgJuEtF105DpxixnmgT5q/LUcV3fsdRCUuYqZX0Hrfm5Cza15WI3lSr2TCLkHibuKWK8BWKQO4OrTlkS+WNu1/gEFzUm/yLsCNNMXV+0Sn3nRvmpCkDLGdJG9fgxhJcbPE2EQ+jPbXk8sK587J0XYANY0a8gf9TUdN5yLkPBQHfUc/mcEr0jz0UZA4rUTPyInx9refTQxkk4iAkV05GS+STiVF5vnQMrR490DzPjluk8LFxGxoj5b7VUvxAW3BpAyQIZIkVhIo+FLawRcuwV2KkrbnOZqI0UycjzEapUfmCe7BA+OobIq36zal1QsBqLqyioxRhyCdhbi5ZPM0jQTKNj5kNdcpEqJD+b0Og3jSxpZRduOGUeRlsxe1nYslbxW8tuR0H4w6jBTgzpX1JbmtRLdCfi6nWPMlBxYGYppZ/VmlOcGGWyf5l6r9mhD/VT70fX06nxFGYbiA3S2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(83380400001)(6486002)(478600001)(8676002)(26005)(186003)(53546011)(31686004)(5660300002)(16576012)(110136005)(8936002)(66556008)(66476007)(316002)(38100700002)(66946007)(956004)(2616005)(31696002)(16526019)(2906002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bm9YMDhFeEs5cE02M0xKb2VvTjIwYmxINmhZS3FLWG9jK0VQaktGMlpFOEY5?=
 =?utf-8?B?UGFvTUJJRnFtT3VxeXUrazJRaklwekRCMVRZYmRaUDJFUThrdUdXVmJLTk5D?=
 =?utf-8?B?L1FrT0h4QjI5LzlHRzdDR1pJaTNTZ1BXMjloNjU1eHY5U2g5R21VaTY4UTlo?=
 =?utf-8?B?amxrWG5hZkp4OXlZWXllL1l0TnU5Tkl3bjFoUzZkdHV5U2ZKVGhjTWU5TVI5?=
 =?utf-8?B?T0Y1bjRIN2hpa1VjOGhRaXVLU2JraFVtbExweEw5UDQ1MHVlWWlRd1FGYmRI?=
 =?utf-8?B?YkdjOVJGTHg0NVJMTFlZQ0lOVVhrRWI3dW9WYWE2RkxkOTZHSm9nZE9PZ0wr?=
 =?utf-8?B?UzRIMUh3VWdwUER1S3hZam9zMnZ5M1Q0VkJPdmRETmJRVkJYUTMrQitJVWts?=
 =?utf-8?B?UkJVZXpPZ2pzTFA5RVVGTU5tMVNnOUd0T0N1bVF1TXNsTk1ndnBxNmEwbDhv?=
 =?utf-8?B?Y2RETUxLMFd2ZjU2ZjRlQStPdUVVdGtkWW9iTjZjdjBNT25ibTVSYTVMdXli?=
 =?utf-8?B?RDFjdUdYTFZ6Y1IzaUp3UDNMS3N0OGJjcnprWklDQWRsU2hvbDVESkZid2pn?=
 =?utf-8?B?am5tL25zSVk0VnFUNnVEcVFGSS9zenU4eWFzbWNsaElaSW9xalpKcWhpR1hF?=
 =?utf-8?B?S3IwT1dYakxDVmdSVnFFVWVVb21xL1p5UW5hc2xjdkxXWUw5Y1EwdWk4S3lE?=
 =?utf-8?B?YkROc3p0UTRsc296ZEdMbjJYbktnTWxTUEZYZjc0NDV0a0YvTFI1NUVHWHJi?=
 =?utf-8?B?a1l0Z3dEakIxVVNKZDVXTGdHMFJSU3ZGbmRWLzI1dE1RT0JPYWN0NGtjOEUw?=
 =?utf-8?B?Y2VVWU5Bd0tVdTBiOW81c2YvNnVHQlRPS01PWXA0djlZZHg4THM3ZFFjZVBp?=
 =?utf-8?B?V3NrOGt2V0d3QitoR3VOcXZvQzZhSGhWQll1SEx5dEpsYlo5WHUxMlRuMWFz?=
 =?utf-8?B?NVBmRUJqMitzbnAzM1NwbkNSS2tSMENmRzZZdFhwWDN0RVo0cnEvOUZ3Wjhl?=
 =?utf-8?B?RmlkZStuQ1dSemVHaXR5WXRqa3BRWFplZ2FyMmlKRnhBdzNTSm96akJpODRX?=
 =?utf-8?B?UWZDeXBCK0JaTmUrNlR5d01FeTkyc2JIYTZ6YTlacUxjc01QZWRrN2gyNGR1?=
 =?utf-8?B?N0k3RGcvOTJGVmF3U21BVFVnMnAreWxvR2t1NG1DQS9FdUxuUDFnOVlBSG5Q?=
 =?utf-8?B?eVFpaTVHM0RiZnFHY3dhSkFEQ2ZCWktPS2RIMGRoMXhKQVl2MmxucDNNZzdG?=
 =?utf-8?B?M2sybUkzeThtQmtBQU1hUTVGSUJDcitDZjlmTXVKNkIwcmZuUkhwemw3R1pJ?=
 =?utf-8?B?MEdFSlRTS3ArMlRMU1Jtc0I1YUlKdDNvSFR0Rkc5M3BnamQ2eUs0bFRHQ0pr?=
 =?utf-8?B?T2o1Tm5hU1g1QVNrOUlJcTNiZ0x3Qlp3MlZMT0ZyOFk3U2Rvak54eU5nZEJt?=
 =?utf-8?B?eUpFOE5UNFdZZjBFUTF6NnJmdGF5RGYyZlRLajZVT043UWlieFY1cEE5bllh?=
 =?utf-8?B?a2ZYUnZuUDkrNmtCNkpSTnFNSktmV1NMV3lvWkdIdi9nNXU3dHZFYjlpTUJ1?=
 =?utf-8?B?NmYwUTNmS3RPSSthR2tvc2daNzZMbTNrbTFvanV4VFhlSmNSbFpRZ3hBNkxL?=
 =?utf-8?B?OUVvZC9nY3l6MUVLK2xmakxYNnRiYWs0NDJlcm9pTXFBVWR5bzB1ZERNVkhx?=
 =?utf-8?B?Z29PYnoreFgxYWtEVXRiWk9Gdm9zOUFIU1J0WngxTHVSSE0rMVI5VVdYazNC?=
 =?utf-8?Q?6q77Pl55Y80odm9QOWZhJm5YSLLqE2SKF4eUWMr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59af6f5-4cce-44c3-c579-08d9148f8447
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 15:14:48.4219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSHg5YHQju9r1TeKRTWhM1ftnYIsaULVMZObej3diz9p1DzkRiBjI+TKZea8e/bf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
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
Content-Type: multipart/mixed; boundary="===============0476511772=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0476511772==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-05-10 8:56 a.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:21e77c32-4299-2923-e43c-821fe996defe@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-05-07 um 3:07 p.m. schrieb Philip Yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">New range is created to recover retry vm fault, set all GPUs have access
to the range. The new range preferred_loc is default value
KFD_IOCTL_SVM_LOCATION_UNDEFINED.

Correct one typo.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Would it be better to move this into svm_range_new, conditional on
p-&gt;xnack_enabled? That way it would correctly apply to ranges created
through SVM API calls (e.g. in svm_range_handle_overlap or
svm_range_add) as well?
</pre>
    </blockquote>
    <p>Yes, this is good idea, patch 1/2 is not needed with this change.<br>
    </p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:21e77c32-4299-2923-e43c-821fe996defe@amd.com">
      <pre class="moz-quote-pre" wrap="">
Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d9111fea724b..537b12e75f54 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2243,7 +2243,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 
 	prange = svm_range_new(&amp;p-&gt;svms, start, last);
 	if (!prange) {
-		pr_debug(&quot;Failed to create prange in address [0x%llx]\\n&quot;, addr);
+		pr_debug(&quot;Failed to create prange in address [0x%llx]\n&quot;, addr);
 		return NULL;
 	}
 	if (kfd_process_gpuid_from_kgd(p, adev, &amp;gpuid, &amp;gpuidx)) {
@@ -2251,9 +2251,8 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 		svm_range_free(prange);
 		return NULL;
 	}
-	prange-&gt;preferred_loc = gpuid;
-	prange-&gt;actual_loc = 0;
-	/* Gurantee prange is migrate it */
+
+	bitmap_fill(prange-&gt;bitmap_access, MAX_GPU_INSTANCE);
 	svm_range_add_to_svms(prange);
 	svm_range_add_notifier_locked(mm, prange);
 
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--===============0476511772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0476511772==--
