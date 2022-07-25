Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ECEC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 21:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E322A8CFC0;
	Mon, 25 Jul 2022 21:14:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC90C8D080
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 21:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrVYrUovPWFMnb06D3MyMbGi+GihhWzOA1DEn7A64xwrDOCwxazEwGz68pofUdtWPIrZ9VkYq7FIb9RAcY1DuHw6n8PnxWcmCUXl2WIU2zAocJG66VzPpw6/IvuQ17YAnkC8d6jA47tnspCvaaKhujy7v/1dEINSPgy5zR+lUemix7wQs5qXBZqhCalGRtkWTdWj0mrcWCYMOjSlJFpObSRkb7hKugx7mrdNGOdzAxKTJhaduRBJaAGdDkfP5ucdayU1skG7r9lYfGdkWm+vvbkbMW+5dEdQxvG6qHtEviQVvmmcsju5rgP0Eg5bXsxmxDWBi0pfesqJlZvzmr8XVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjyh1mFHjEBY2AUC9yWI6EyHshHWQdPKrKuXu76KoRA=;
 b=bTB9ZEnY7kRtFa+pv5mX7Xg5N38rWrhz9K12Qe79uqIRb3z8IeFm2IeflcqiH/X0ZEnSpTJdTEG1qgHqW+5b1cOBqyJdHs5irepC5LUsTvXV1q2Kp18fMNt+yobb8pBoZtXU43yoNSJCl8eCUJOXp/m4d507YudWDzDfxJDLjMYGIeg49aa0F2n9DR3dsNTF+uhuJnOKitvCAtc661q4CixXb+Yk4aMYfxMgDC/VyjDPX9i8MPX3bKTaQqnuoSX+eAewtaVk/5takNS9tMQE8ezOm6kpHtGHKXPRd4uJhE8Te8hxSxBJZC8FMiM4JMM8i6Kdr/rpWlPOE+wBbyCUfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjyh1mFHjEBY2AUC9yWI6EyHshHWQdPKrKuXu76KoRA=;
 b=IuKhEpv8+hFvB7ye/9AUWlBJ/m8rlI1b+eJIsa5314dhAmb1F2HneAlR8/Gz0LjVfhGAmbVOlp1OlHmuCt++m/AXA357JhobzYjf+1jaGGnbKg6301zb6QRpY/0CiTkyLhtquJm/YffW1EdkTAvAZ+Z+bE3Al1WM2dpcT07EhgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY4PR12MB1589.namprd12.prod.outlook.com (2603:10b6:910:e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Mon, 25 Jul
 2022 21:14:08 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595%6]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 21:14:08 +0000
Message-ID: <cbd64ddc-554a-226e-66bb-6e6809bc2877@amd.com>
Date: Mon, 25 Jul 2022 17:14:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/3] drm/amdkfd: Set svm range max pages
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220725171943.9155-1-Philip.Yang@amd.com>
 <20220725171943.9155-2-Philip.Yang@amd.com>
 <3d31300f-4f32-1aa2-8c50-c2a4f79a6ca2@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <3d31300f-4f32-1aa2-8c50-c2a4f79a6ca2@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:208:234::32) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2a3ebbe-7369-46a7-eec9-08da6e829c9d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1589:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgT290rJp9GVfwtFzsCqnRLVDE7X0H+GW8A8hrzo10PCp8exp14HSwtFxRfjrLMgQ79v/sTyseJ3/v8aVd4aTj0jLmztLW+44JLMbj37Y0cWgM6oJU/xZXINoZAF82OSF6pyA81Fot4NUWf6O2f8KGncXIdN+apDqovwV6dNrLgfBMJ1JYYKUWvFjrDGWgWFRg2J5i4k43aS11JIT3AIL7ZfGZWb7JZSpYI/Xub3OpogFHDPS2RBmqmNDWRW3bRD3mQAuaPOnt4d4yQ+9XcbiGGdwkuvGQvMax/J6wwn7xAh/vy6iocXGB9lqukJcjF4jkBCqlCLmNeVbqKJKpOA55Xg1OBIkr7ebLFdbFvHBbrgE4fA7f/Q07SsvKvWG/3HFT1sN8qkWB1dvt2jwl+A0HjHRRH5YFQB3rnIIOGdPrcn1Fu7aDvVdDGtPnTuwwL84M7GTi9vnMG2L0tobtT2voHlR0SdBRsz7rv9VM/uZRj0Zly0xU11XMSpXX+6ORgP27dX6aTfbsMnSTI5WKNt0Qd6dKdEpEBsXDhk2cM7+SS99TnB4UHKnlso7eG5OQExXJPtxL94Qh1tvfcn1AEVNyTj/iLZoVpr1GhEDU4WdlOR44f8jyJuY09v04YFfDfRV+hZ06CA6sxZFq5oZ27IZJcyS7vxd0YIrNJk7MKWfqUZZPxADzX2c1fBHZkPfE62r8+5YKB/MMx8rcoHBO2tz37F6ihDbscyA22JU1/VV4aDYJiqvw5r4W4yrpOMGB+XtkOrmurBtir/lOT7w1WQgpuhgSG1E1f19grAwxXu+qPy1lo5rJxH0NqB3dpegMop4WWkV3bNwlf141KiG1BQig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(31696002)(36756003)(38100700002)(31686004)(186003)(83380400001)(2616005)(6512007)(478600001)(316002)(2906002)(53546011)(110136005)(6506007)(8936002)(41300700001)(66476007)(66946007)(66556008)(5660300002)(8676002)(26005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXhmTVUrSEhWZGkvK3dZNTgxOFlaVDQ5akd1eXlCckZaVCthdkJqZTlXSDR4?=
 =?utf-8?B?ZjhHNlM1YmMveTluRkE4b3YwNnptQmNyUm4yYksva2ZRZzFEWGZncFNyNkdk?=
 =?utf-8?B?aE5kMEdDNkVxSDRYUHdDaUt0WmhSdGdZRWRnekpLMFJFZ051aU5vd1diSHRy?=
 =?utf-8?B?Nk5EYlFLTFl1TWY5cERZSG5qMDdkdVp3QXNTMzMzRUpiRkxQZThBbFFMS3hX?=
 =?utf-8?B?UzRTSzUxTDZVS2Rqb2tkdHg0UDIxblg3My83a1NBZVp0ZVVjdnp1bG0yT2hm?=
 =?utf-8?B?ZTBDUWlBMnhKV3FDSHZmU2dEbEdBMWQvbTZCdkFUVEJZalcxdzNNT3BZVzRZ?=
 =?utf-8?B?ZGliT2lWR1c5RTlTSlhDYlRmblZiWUFyZk9kdWkzTSs1OEpNTlo4VkgzWE9k?=
 =?utf-8?B?RWlHZTNhOUJtWUtzejJoS0kvM0prWlAvc1FYOGozR2tqejhpZWl2Q2VQVmJq?=
 =?utf-8?B?SjdnYXlJSzE0aDk3L1BTcVpvK0NLUWhrRzU2cmh1ZzJ4aTl4dENaeEE0OVRT?=
 =?utf-8?B?VVlRd3M0SHpsNWVhOHBwRm5YMktUZkJUZWpVK3pJRU1MaWsxdncvbWFpcDl1?=
 =?utf-8?B?RzRPeHNIRHhUOXZXZ2g0bXBOdWlCRDE2Nnc3L0h4bWZRdkMrWXA2Q1JMck9m?=
 =?utf-8?B?SHdjdlJSVmVlbmh4YTExMk03SzNTVFVVZlVuaVBOR3VBeEU3bHVxbGtTOTBK?=
 =?utf-8?B?QzkrUC9KazRQNlNiMEhGd2JMY21vVHZRYWV0Rm1aQ0tJcU9ibGhLRFpJdXFa?=
 =?utf-8?B?N1hQRVJvVlUrY1N6MkQ2TzJJZ3ZQcFNpd0gwd056QnFhblJsKzZvVU1LYUN0?=
 =?utf-8?B?L09Nd3RMcnFJNlZEVk0vcnBKRGs0dytaeTJFWE9mYUQ1T1V0dko4UXEwUVha?=
 =?utf-8?B?WWwwZEN0enM3UTBUenZnekJBZVpxN2FSSGZiWVgzQk01TS8vR3kwNTU1NG1P?=
 =?utf-8?B?aS9INkRoWWtiQ0NTZkhhMEkzaHUyaHRVSEN5dUY4RFEzYkxhY2FvT0s2MFJ1?=
 =?utf-8?B?QXVMU3FPTXp6UEE5NlN6VGMrcXpmVUZKa3lDQmlRWXlzNFNtaHI1WHZrdjBl?=
 =?utf-8?B?cGErSGxIRm1CM2UzR1MyVlFXdzFoQ2dTaXpBWlBDR3hPK1dieFE1Vld2ZEho?=
 =?utf-8?B?NlN0ZFBkV0U2ODdCNnFZNUhNN3ZKVjMzRGxUR3lPZmMrdGxRTkxnVkxsSFNi?=
 =?utf-8?B?Njhzd0FyeGg1WnlaY1RGcHFUN2dCdFNjUXZSN2dNVSt0cXpzNXpJL3haTEk5?=
 =?utf-8?B?RjR4S3VwaHRXQlZSQTlUbEw4MzIvYndtWTRjUjFmWFQybDNBVmdrdnRsVWMz?=
 =?utf-8?B?TVB3bDdXYWdzR0ErTnRvdW4yUHdrdDNzT3prc3ZwNStIM1JhdEtKK21ISzNZ?=
 =?utf-8?B?Q1V1Ym9PNGhVR214dnk0OFFYdzVKOFZHUWpNdkpJdVVXRk5jYTg3ZkRKQWZi?=
 =?utf-8?B?UWRlM25sSHl4OS9FM253Tk9aZVhhSWJXV0grQkMrY291eGowbHJsT0xmLy9v?=
 =?utf-8?B?cG9zL1BMM2U4dWNaRlRGZEJuMUxZRmpDT2FpdTQ0S2JBSzVYcmMvU3c4THVw?=
 =?utf-8?B?aHZqa1BGeUE4YVc4YzFhRU1abk40cEtwYnpaVC9GT3ZFTC9YbGRIVnJ0YjRY?=
 =?utf-8?B?N0hmeWI5VnUvTG81MjhHaXl3N2tSdUp5dyt2a2kzU2VHVjNDUHFzYXRudXVw?=
 =?utf-8?B?WTU1SEp3SFVJaDA3UWhxTGoxN0dLN1JIWVZOWnZHaG95M3ArUjRnQm1wNDdG?=
 =?utf-8?B?Vnp3VjZMcnU3MDhiS2xwOFFjYVlBYmZyMHl5VmtEa2JsQm0rNFlFUWROQ05P?=
 =?utf-8?B?YWpIVE5DMTBRNU1ScjVsRVVIMExHSmxxTkxZcFNKQVIrUVRMVkxLSE9kOEVH?=
 =?utf-8?B?YkZJdkpaOGdWQUJaMEdka2R1bVlsLzA4QW5uTm44MmhyWnBBamJRMEVTSkI4?=
 =?utf-8?B?UWRUQ1Z1Z0lQMzJaT1FNSnpHZzlISURORGNDWVJ2ZndNMWVBTS85ZjNmZHl2?=
 =?utf-8?B?VmhIY2hlM3IwK1lFQ2xPRE5ydXI0OVNOM2JpS2tSTmdHdm5HTkk5SFprOWRk?=
 =?utf-8?B?cTZHZkt1RkNzbkpyWWVDRlhFRHlsQWJJVmtHOFYwazY1WXkvSGpid1o0ZmJr?=
 =?utf-8?Q?6uvc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a3ebbe-7369-46a7-eec9-08da6e829c9d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 21:14:08.0151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/1rv61f9ZvgOkdk0gsejibDXa+YDX6coMdhQ0ocbM6H730Zt9I6xXc6xTudP4ln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1589
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-07-25 14:02, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:3d31300f-4f32-1aa2-8c50-c2a4f79a6ca2@amd.com">
      <br>
      Am 2022-07-25 um 13:19 schrieb Philip Yang:
      <br>
      <blockquote type="cite">This will be used to split giant svm range
        into smaller ranges, to
        <br>
        support VRAM overcommitment by giant range and improve GPU retry
        fault
        <br>
        recover on giant range.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |&nbsp; 2 ++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp; | 19
        +++++++++++++++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +++
        <br>
        &nbsp; 3 files changed, 24 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        index 9667015a6cbc..b1f87aa6138b 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        @@ -1019,6 +1019,8 @@ int svm_migrate_init(struct amdgpu_device
        *adev)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        amdgpu_amdkfd_reserve_system_mem(SVM_HMM_PAGE_STRUCT_SIZE(size));
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; svm_range_set_max_pages(adev);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;HMM registered %ldMB device memory\n&quot;, size
        &gt;&gt; 20);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index b592aee6d9d6..098060147de6 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -46,6 +46,11 @@
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING&nbsp;&nbsp;&nbsp; (2UL *
        NSEC_PER_MSEC)
        <br>
        &nbsp; +/* Giant svm range split into smaller ranges based on this,
        it is decided using
        <br>
        + * minimum of all dGPU/APU 1/32 VRAM size, between 2MB to 1GB
        and align to 2MB.
        <br>
        + */
        <br>
        +uint64_t max_svm_range_pages;
        <br>
        +
        <br>
        &nbsp; struct criu_svm_metadata {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head list;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_criu_svm_range_priv_data data;
        <br>
        @@ -1870,6 +1875,20 @@ static struct svm_range
        *svm_range_clone(struct svm_range *old)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return new;
        <br>
        &nbsp; }
        <br>
        &nbsp; +void svm_range_set_max_pages(struct amdgpu_device *adev)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; uint64_t max_pages;
        <br>
        +&nbsp;&nbsp;&nbsp; uint64_t pages;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* 1/32 VRAM size in pages */
        <br>
        +&nbsp;&nbsp;&nbsp; pages = adev-&gt;gmc.real_vram_size &gt;&gt; 17;
        <br>
        +&nbsp;&nbsp;&nbsp; pages = clamp(pages, 1ULL &lt;&lt; 9, 1ULL &lt;&lt; 18);
        <br>
        +&nbsp;&nbsp;&nbsp; max_pages = READ_ONCE(max_svm_range_pages);
        <br>
        +&nbsp;&nbsp;&nbsp; max_pages = min_not_zero(max_pages, pages);
        <br>
        +&nbsp;&nbsp;&nbsp; max_pages = ALIGN(max_pages, 1ULL &lt;&lt; 9);
        <br>
      </blockquote>
      <br>
      In the next patch you use max_svm_range_pages as alignment
      parameter in an ALIGN_DOWN macro. The ALIGN... macros assume that
      the alignment is a power of two. Just aligning it with 2MB is not
      enough.
      <br>
      <br>
    </blockquote>
    You are right, test with 6MB failed, change align to
    rounddown_pow_of_two. <br>
    <blockquote type="cite" cite="mid:3d31300f-4f32-1aa2-8c50-c2a4f79a6ca2@amd.com">I also
      don't understand why you do the alignment after taking the
      min_not_zero. If you assume that max_svm_range_pages was correctly
      aligned before, you can just to the alignment to a power of two
      before the min_not_zero call.
      <br>
      <br>
      The READ_ONCE ... WRITE_ONCE is not atomic. It should work as long
      as this function can't be called on multiple threads concurrently.
      That is, it should work as long as GPU initialization or hotplug
      is somehow serialized. I'm not sure whether that's the case. If
      that is not assured, the proper way to do this is either with a
      global or static spinlock or with a cmpxchg in a retry loop.
      <br>
    </blockquote>
    <p>Looks like pci_probe is serialized on mGPUs, but yes it is not
      clear from calling path as it is done in a scheduled work, change
      to use cmpxchg in next version.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:3d31300f-4f32-1aa2-8c50-c2a4f79a6ca2@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp; WRITE_ONCE(max_svm_range_pages,
        max_pages);
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; /**
        <br>
        &nbsp;&nbsp; * svm_range_add - add svm range and handle overlap
        <br>
        &nbsp;&nbsp; * @p: the range add to this process svms
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        index eab7f6d3b13c..9156b041ef17 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        @@ -204,6 +204,9 @@ void
        svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
        struct mm_s
        <br>
        &nbsp; #define KFD_IS_SVM_API_SUPPORTED(dev) ((dev)-&gt;pgmap.type !=
        0)
        <br>
        &nbsp; &nbsp; void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
        <br>
        +
        <br>
        +void svm_range_set_max_pages(struct amdgpu_device *adev);
        <br>
        +
        <br>
        &nbsp; #else
        <br>
        &nbsp; &nbsp; struct kfd_process;
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
