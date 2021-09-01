Return-Path: <SRS0=BBbY=NX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70DFC432BE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 19:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA6960F6F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 19:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FA6960F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D376E284;
	Wed,  1 Sep 2021 19:43:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E2D16E288
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Sep 2021 19:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9Xx7B0J0RvlHe8klJ4hqOMPbZb7SkW3A+0i16AOzcx3w5ifB5GlK3+kU/bQS3e9zun9G1UgLCxHJdBbZxsUmmF4lqQ4OkRt7Tx9roZNyHNPwfhCaoiKiBoVPAWESYAUySRmjBz4L9PPebmxY9PE1OwpN/ugpMBhS8PP5TAUeL5QG/LGvOnXj8Mb9NbGnYvgP2iUyKHboa3MRIxOlq5XTmdOA3jrCs+kKaTRht6RfW5xnMA8m6vOhIcv77P6Kk8Ymu0fIc4r/BZAoq0hmYmsq7fLggtjdBHK7eqhDCjKzh0tXhkn4wgqlSqyzQollT5HR9hkk2SPQQyWLgzJIVnPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=3KIccLhujmWOsWPYsQfwPG+2LS1Tkx3CTQuTEyODzDI=;
 b=nJEUCTODSFY/NN0D2XfxveRsKCQ/hCiHmFpMINYY8yWnNXplwW/pBUM5BZO7VIyjn0kn7sgUUHUnzcTLRVHLFle0XNFP8RVTwxZAncVGBdq/sLf3AKlmZMFnoCHupPd9E9Kfuxs0D/oRuIqTLTw7jFiJTQsKJea8o6em2tQOH+lSRZqcxX6NwX6kioOreoxdTbIwstWZlhGZi6Sh6/5IwlrZgQw0JeMcXV5vauw1tw32HAKU8jfCI8GP5pgMPDIjF8q3kGOJQxSdxEA5dlFYGyBXGhA0nv0uysQqUEw0KNOaI8u+xZzytMz/JEBqqM1XGdSCKHG6CRfOQv5vZe96eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KIccLhujmWOsWPYsQfwPG+2LS1Tkx3CTQuTEyODzDI=;
 b=TG+BZHPeHKVaIY8YPd6kJKX0nIi2PmaadYTCVT6SSxoid6j1m/UF8T664taZNEOtLBrsHpqO7HTT3Efpm5723ZoAPwpOsvjEaSWdg3+f30uxQ/PZT/BzJ6B7EPuJVmtmVvaiZbckjyadZmYkdfzdPk4EEdiqhYA7ph5r6LOMLgY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5164.namprd12.prod.outlook.com (2603:10b6:408:11d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Wed, 1 Sep
 2021 19:43:22 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 19:43:22 +0000
Subject: Re: [PATCH] drm/amdkfd: drop process ref count when xnack disable
From: Felix Kuehling <felix.kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org, "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 Alex Sierra <alex.sierra@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210901024121.23964-1-alex.sierra@amd.com>
 <b690d7a8-6c4b-fc52-0076-7a8c0bc7a391@amd.com>
 <DM5PR12MB4680D1A4C08DBD7DCF72120985CD9@DM5PR12MB4680.namprd12.prod.outlook.com>
 <813b0a09-a81e-3d0d-0342-eaad81f67f8a@amd.com>
 <DM5PR12MB4680F859F8CA637B9BB9B35185CD9@DM5PR12MB4680.namprd12.prod.outlook.com>
 <69eea37c-e36d-0239-962f-c7908d72e778@amd.com>
Message-ID: <fd3f1472-7766-57a7-52ff-a2c50ea237bb@amd.com>
Date: Wed, 1 Sep 2021 15:43:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <69eea37c-e36d-0239-962f-c7908d72e778@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::7) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT3PR01CA0094.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.18 via Frontend Transport; Wed, 1 Sep 2021 19:43:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fcd4adb-1c29-4a25-7a6a-08d96d80c1e5
X-MS-TrafficTypeDiagnostic: BN9PR12MB5164:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5164A0588A832C87213B584D92CD9@BN9PR12MB5164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTOT7xMsJUkLfTgSqsZVOi/dU9W08OJTR75gmRHuc8EgN7fa5ukYttoK71mThXg4FhlyrQmpo8YVmAHvSZR3lljmiwFBJNO7kva1C4a38oV+QDLnW6Dhmnfpk1XCX4ZYUBWeQGJUswVpv4vp1H9CPvHyoSAfjQ2JIH2PXwH6yShrZ9HFD+3buhABtlXgMTEstmnSJniDzQ329c7cbkAqlvtVyQBZqufAvkV9olROvz6qD1ZJvwgPF2Y40nZtjnKGnM/mGHGw32/bDYSi+kwetq6xqh/8b48xODMW1epu00AIJ9kUniH7qZ7ufi5C9F62CuETUfEScIddoA3cm1L1heIHhH6nH0Z60TI9hGv6fVkrIFalB1MK2FpyrptzwfLYpTPFU9SUJd8adKN0Uyf5mx1bW9KvPJvBpVQxi0aY4xNiQWPeW1XC0jGEuzY9rFStEN9EHTurRwse7lkKZc34Ewfalx7icSEDZwxzB3xoD21ynYE3LxWEHvugK+XWyLUU+AzzMjH5LAxKAV9SBzNCpFKhYLLlqU4KCDuN2LpQWTo1B1w5G0OGnLeTAK6Wv02zydPjOjkHqnGzLMfQiZ2QgWhmf8dal+y7KCXrvUZhl6WMK+KXAAvU0DfgQgHk+dOetL/x75gwKgFvSdAMb1dVSQH9qBTiFdKwfqwqTmEKfu6AnOkTVjy2R8kPrky0m1N8KYNjq+SC4eWMUyi9HHApr0EuOaVT7cuV7ZFurdz1qeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(2906002)(31686004)(86362001)(186003)(26005)(66946007)(36756003)(44832011)(6636002)(5660300002)(83380400001)(478600001)(38100700002)(956004)(16576012)(2616005)(8936002)(316002)(6486002)(66556008)(66476007)(31696002)(53546011)(110136005)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3dUeDBzSTNTVWFXOTUyRlBXM2Zwa3VQWU5pQkpYUm56NmgvTEcxZlBsTi8x?=
 =?utf-8?B?alhQNUlVZzdyRkltaHRlNjdsZnFsWFNMRkV3Zys4YTdUMEFneFZ1ZkdVYnh0?=
 =?utf-8?B?aGhKL1NkY0F4YnhuYitxRFhsV1YwUTAyZFdnMHJncW8xZU82RkozYUhRbE1m?=
 =?utf-8?B?VGZNTlY2ZDZFemVrT0w5a1FuRzhwVFB5WlZ6bGpoMkczUWRwRFNhT0hoR0ZO?=
 =?utf-8?B?bjN2OXNwMFdKVjArNE5SQm1IbEJ6bHEvbmorQ1RLY1l6aU5kVFVQS3ZQdzdX?=
 =?utf-8?B?dUI2ZHNwL05XSGIyMThDOEZFQ1Y2QzljNkkxKzhWdEZTZ1Y0S3FHRzU1bUtR?=
 =?utf-8?B?dWl0NGZVSlpYcWRQQ3lHUERIU3NtT1FFeDdwaldkc3dVTGRXajQvUWNuckxX?=
 =?utf-8?B?bEt6NzM1WFFXMG1tbURFUXVaK0M3QnRKZ1NYU1RKWkRMbndVWHVhQzdaNEpP?=
 =?utf-8?B?bkdCV3BqcDdyY2lQa2Q2OERQUStKdng1MWJmeG1pNDZYQmcxWks3SnNSZHZu?=
 =?utf-8?B?UDBWa2dVenJFcWZHQzhpMUVVR0hWb0VIZEx4ZTMwOTcwMkMza09GcVVCdjZm?=
 =?utf-8?B?d0M3eUMvUUZIU1gwT0VQVktkbmNYWExndVlnckhOUHlTbDZNa283RE4vRjRx?=
 =?utf-8?B?cSthNVNJaTVUTHNHS2x0RWFJUnhPdzZnZkR1bHlKZ3dFbGJ3cXQ4eEpHamhH?=
 =?utf-8?B?NmI5N2FlaG5tQlBKR1JkTUdaSWd0VERYcXdLSUswMWp3ZGRjbktPYkQvMDlm?=
 =?utf-8?B?WjV1ZFZqa1ZFQjZmQ202VTFlSkNIOVlFWGVtTHY2b0lRcnF6TWZXckdTYmUy?=
 =?utf-8?B?ZkkvMjRURDNtRzFyNjlOaS9mc3F1RVlpODJFbUhyQjJwVGxTOVJjM3d5T3Bl?=
 =?utf-8?B?MVQzOER0M0JSNkV4cmtaYUtHUGVublV2NzJpNzM4OFE0allPUUxZVFpkbk84?=
 =?utf-8?B?L05lK3dVZDhvT0RxNUtwR3llSGxBUURaMFFqSHNMMDJlbnZRWUE5NzNucnVy?=
 =?utf-8?B?TG42N2J2clN2dzZwUXo5V3orWDNqRm5JK0FiS2ZJemtmMTdFTU91NUE5TW1Q?=
 =?utf-8?B?aklVbU1qRTBmT3hJMGRiK0p1TnQvTW85QWNoeU9pa0h2Z3hmRU1DWnhBOVhy?=
 =?utf-8?B?cVYwTnJLWTcvZ1BOVnpsQWxEQTdFU3kxV2F6UHcrdkZacFZwWTlZN3JHazda?=
 =?utf-8?B?S01oYXFHZTlHLzJvZGZpRExCcUJLK2pOeGZ0WUdUbCthc0hrUE9pL2d5Tmsz?=
 =?utf-8?B?ZFVubDl5eDRNZUVwK2lpYVRsRDkzREJhTWVEcnpzdHpzQ1B0VWtFVWg5L1BM?=
 =?utf-8?B?YU4rRHpscytxVlFLelh1NHl6ZHYwajJoUFVKTHg0RzV2bkJGRTB4L2xzWHE0?=
 =?utf-8?B?emJpcDloc3VvQytEUzJiUjNvWFJqNkxFYkdwWmlBVnFmL2pWRGhENDUzMVE1?=
 =?utf-8?B?NkxZWnVxMFhhNEpWRzJvWHNXQVB5aS9VakVuUmYwalpoYS9raXpub2FUU1FN?=
 =?utf-8?B?bGhmeFgyVW02MHlQanZmYjNSZFZFYzR3bEVBbk1PT0FSemgvNWhJN1dqaGVp?=
 =?utf-8?B?cUZPME9uRFF6WXNLbjlmZmNtSStaTTBWbmhqWGQ4UlpMUENyV204Z2ZLTE5m?=
 =?utf-8?B?QWN5N0FkTEhVbEV1RmJXWkxMYmpIRVJaLzBwQXhWVG5Ka0xIdjRQYWV4MnY1?=
 =?utf-8?B?OUFoamxza3FCNys3bG1yTkZDRFNhQmJ1cWN2WnFrS0tXUzFvWFZjcVo0WkxC?=
 =?utf-8?Q?mEE6EUv3vXLNidXHAXXrq/XNbSQ+zP0W49joJde?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcd4adb-1c29-4a25-7a6a-08d96d80c1e5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 19:43:22.7591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFFDJN4vk3WrNv8Rn9Wkfe9QV3yi69nICNMpq2ccPpdAscHhWM1MPe8SlQvkDGbOM5PaavPgzEY4KhXsKJ69Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5164
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

If it's not too late, please add

Fixes: 2383f56bbe4a ("drm/amdkfd: page table restore through svm API")

Thanks,
  Felix


Am 2021-09-01 um 1:54 p.m. schrieb Felix Kuehling:
> Am 2021-09-01 um 12:59 p.m. schrieb Kim, Jonathan:
>> [Public]
>>
>>
>> [Public]
>>
>>
>> I wouldn’t know if it was another bug elsewhere.
>>
>> From what I was seeing, the leak was coming from !p->xnack_enable on
>> the svm_range_restore_pages call.
>>
>> If it helps, I saw this on Aldebaran where a shader does some bad
>> memory access on purpose on a debugged ptraced child process.
>>
> On Aldebaran the XNACK mode can be changed per process. But the page
> fault interrupts are retry faults (until they get turned into no-retry
> faults by updating the PTE in amdgpu_vm_handle_fault). The retry faults
> go into svm_range_restore_pages before they realize that the process in
> question doesn't use XNACK.
>
> The patch is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
>> The vm fault prompt pops up in dmesgs and a stale KFD process appends
>> per run without this fix.
>>
>> I’m just assuming at this point that the IV retry bit is set but I
>> never confirmed that.
>>
>>  
>>
>> Thanks,
>>
>>  
>>
>> Jon
>>
>> *From:* Yang, Philip <Philip.Yang@amd.com>
>> *Sent:* Wednesday, September 1, 2021 12:30 PM
>> *To:* Kim, Jonathan <Jonathan.Kim@amd.com>; Yang, Philip
>> <Philip.Yang@amd.com>; Sierra Guiza, Alejandro (Alex)
>> <Alex.Sierra@amd.com>; amd-gfx@lists.freedesktop.org
>> *Subject:* Re: [PATCH] drm/amdkfd: drop process ref count when xnack
>> disable
>>
>>  
>>
>>  
>>
>> On 2021-09-01 9:45 a.m., Kim, Jonathan wrote:
>>
>>     [AMD Official Use Only]
>>
>>      
>>
>>     We were seeing process leaks on a couple of machines running
>>     certain tests that triggered vm faults on purpose.
>>
>>     I think svm_range_restore_pages gets called unconditionally on vm
>>     fault handling (unless the retry interrupt payload bit is supposed
>>     to be clear with xnack off)?
>>
>>      
>>
>> yes, with xnack off, sh_mem_config retry should be off, retry bit is
>> supposed to be clear in fault interrupt vector, we should not try to
>> recover vm fault, just report the vm fault back to application and
>> evict user queues. Maybe it is another bug cause p->xnack_enabled and
>> sh_mem_config retry mismatch under specific condition?
>>
>> Regards,
>>
>> Philip
>>
>>     Either way, this patch prevents the process leaks we seeing and is
>>     also:
>>
>>     Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
>>     <mailto:jonathan.kim@amd.com>
>>
>>      
>>
>>     Thanks,
>>
>>      
>>
>>     Jon
>>
>>      
>>
>>      
>>
>>     *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
>>     <mailto:amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of
>>     *philip yang
>>     *Sent:* Wednesday, September 1, 2021 7:30 AM
>>     *To:* Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>
>>     <mailto:Alex.Sierra@amd.com>; amd-gfx@lists.freedesktop.org
>>     <mailto:amd-gfx@lists.freedesktop.org>
>>     *Subject:* Re: [PATCH] drm/amdkfd: drop process ref count when
>>     xnack disable
>>
>>      
>>
>>     [CAUTION: External Email]
>>
>>      
>>
>>     On 2021-08-31 10:41 p.m., Alex Sierra wrote:
>>
>>         During svm restore pages interrupt handler, kfd_process ref count was
>>
>>         never dropped when xnack was disabled. Therefore, the object was never
>>
>>         released.
>>
>>     Good catch, but if xnack is off, we should not get here to recover
>>     fault.
>>
>>     The fix looks good to me.
>>
>>     Reviewed-by: Philip Yang <philip.yang@amd.com>
>>     <mailto:philip.yang@amd.com>
>>
>>          
>>
>>         Signed-off-by: Alex Sierra <alex.sierra@amd.com> <mailto:alex.sierra@amd.com>
>>
>>         ---
>>
>>          drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-
>>
>>          1 file changed, 2 insertions(+), 1 deletion(-)
>>
>>          
>>
>>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>
>>         index 8f9b5b53dab5..110c46cd7fac 100644
>>
>>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>
>>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>
>>         @@ -2484,7 +2484,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>>
>>                  }
>>
>>                  if (!p->xnack_enabled) {
>>
>>                         pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
>>
>>         -               return -EFAULT;
>>
>>         +               r = -EFAULT;
>>
>>         +               goto out;
>>
>>                  }
>>
>>                  svms = &p->svms;
>>
>>          
>>
