Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5F0C7EE2E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 20:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 752E110E6E0;
	Fri,  9 Jun 2023 20:27:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6384D10E6E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 20:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pe9xH2Y//4vpFZqQ4qQDzghKkRMgFN+JrdNAHrUuMQOvfB2W4XQ3RPpD22KfNRzky2pbhG9kMOSIrebZwqB/BpNDy5DPA8NdpGlvQ80TJwepY0H1zPmAXbYxyVHpFThoUL0zClJqlAA2rL0ygeQv0xZiit52vetm8b+Ca6rk4OMjrK1x66QBrES8WUQp6JzMzwDTdo6XfCDRKx7VFIbYjPF8iqpzA+qp0obYszpJM86h43mMONEfejqgAu30VuoiZmckXmwc+tR8PI8AmEmmnkLk31IPKemYNCUu6Pp0I5OF8Bt36DlHjx0M0j3CoR33NFjSocwOXrsKp9HO+9VIIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd/ZZAZNdnnVxfQfwuhUZO1PrKYkhSDtJ2SchCgMjDk=;
 b=cJpiRfNWjtScRLMfxdsZGhw5lrLEi2zZGGXfnSjut9E8BN9B7MeGX2wlNFxAUv64DurYaRe3swHEUpotEyRHO1my8AiajQTThjAzJVcbaKUn2jvYLvaej2gQUxUU9PTR8ueI7kub9VTUc+3w6AheJsZmMxLen2OwdcT6n2UOPDjMmEsKnSrVkzACqLmw2XxBCoaVfkSyzyOQTflt3PbFzparIFAum/bGEAMgWXl4UNMgMQ5XcZu4a4MR6pEl279jUa/CEmadcNwu6VC1IEtGguUUR9GFZXiswS2Kfes1Cgmgj5NNEhadd0qflCZebdpBagQxm0rZI8meHsEXf7I90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd/ZZAZNdnnVxfQfwuhUZO1PrKYkhSDtJ2SchCgMjDk=;
 b=iPzHDkynJC5+AxY3NavrneELk+UDoL+jPw/kzW2vFPCINY5LeFx+rOhVLe6cnxrm5OxBdNfKcBpITvRgSXK7qpB5OalbK9bLoUlGZXU+Wdog1rknCoFh+x6EdDed6G3s3q7olubG2nmZP2d6z4wdnuAsHXHSigocMC/dcv4/xQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19)
 by PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 20:27:47 +0000
Received: from SA1PR12MB8946.namprd12.prod.outlook.com
 ([fe80::7ca7:213e:8117:6920]) by SA1PR12MB8946.namprd12.prod.outlook.com
 ([fe80::7ca7:213e:8117:6920%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 20:27:47 +0000
Message-ID: <baf7f4d0-c7ed-41ef-e403-9df6a80f12a2@amd.com>
Date: Fri, 9 Jun 2023 16:27:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/5] drm/amdkfd: set activated flag true when event age
 unmatchs
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230608170705.2271276-4-James.Zhu@amd.com>
 <20230609201328.2350231-1-James.Zhu@amd.com>
 <5936e919-b9b4-067e-4cdb-e818bff865d0@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <5936e919-b9b4-067e-4cdb-e818bff865d0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::33) To SA1PR12MB8946.namprd12.prod.outlook.com
 (2603:10b6:806:375::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8946:EE_|PH0PR12MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: 346cdc7f-f455-4223-fd3c-08db6927fcf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUgyNkng7RuAaQfRucKsoT9/MGC8VX6xfiHOZbiOqOHtcW2pvwpryYgoDPKlE5j4rl/WH0um4FPgLAZC0FY5VrZL+zgXRfonW204xuiP5OoETY733Ia2sXKw4A7tPHNPmDUobxRy+QjAa1RLIC1Q36Q/wkm2buwDLpNOQ8y0LbhOcO4k2mH4N0nHX2mFrTmwadX8peTVcV0x0h4VB/Z0hU7RZvKvRMBkVlge2t6EUQpyaI8abCUMowSCM8v8XxQXtQCF3xlvq2heVRofeAaH2/bd5sPGcHh84MNU/LoOEeymznXmq79yy8b3M9FR2vFQjL9CQbu3bJadBQPqWNpCpzPmC3qt0gt1SrAiTxHJ1okD49U8qMIf4jVOukRPxdrcUxy504B1+i8DWgC3KoCHZKqSowqBCeXEcA3TV18uPXA9XC5Dqt1tZprtARa8acYYxYaUiC8g4rJlQpTpiTQqtgzAkTymO/KMpDEgQVsVVZ8stdemNQZDP++vU3jxfTAHxWoy4q2/TW/hvZYez6c5rzSCD9kpukdTzs3aNlOly4DFqatJtPVRbO5L78pkBCXBZcwBRaZEW3uJZqaYNCzbiw7ODz8b7My2DMUePcMlp7KYeE8q4Zpzn5iEWrcXnKL2oIEClzxNT/3mBJt1Kuhltr+JryAt8XedRP+C5enbT/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8946.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(5660300002)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(41300700001)(31686004)(110136005)(478600001)(2906002)(38100700002)(31696002)(26005)(53546011)(6506007)(6512007)(36756003)(6486002)(36916002)(186003)(2616005)(83380400001)(6666004)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXhlTVJtMjFCWUgzYloxUGlsYmdyeWNlWVFFUGdrUllDc0dLdzFjeEJmd0Js?=
 =?utf-8?B?WnczNkhvcUI2MldDUE5uUk9Dam1Mc1VFaG5wa2xMK2RaV3VEaFFsZCs2Tmlo?=
 =?utf-8?B?djU0QllScmU1WWpadXNCVmVCSUJReC9FVFR0QWlmQWxqb0U1M1dqUlFZN3My?=
 =?utf-8?B?cUxuWmdQVXA4Q2hnNkVPS25jaFNadklGR2tHSUZuZ1c2eXFWNm9HOEJzazl0?=
 =?utf-8?B?RzlRQzNtV1VHeHJmVFJTT3RUSFJuenZtMVQ1TVhHcm5RR3pyYlFzbng3SWxF?=
 =?utf-8?B?SnhVUGhqVEZWWVdPbGllNXl0eHdjcVM3Y0l3V0ZFcXkxZ1pBUlN2RmExa1Q2?=
 =?utf-8?B?Z3BOa0w2anpPbHc4NEpZM1Q0WVk4T2pDQStIYURBSWRWS2lnMURCaXptb1ZP?=
 =?utf-8?B?djY0WktnUFpvMVh6VTRJb3NlSXJOcFlXcUd0d2IwUFoyc0JPUkx2OVFSSVdZ?=
 =?utf-8?B?SEdKZDZ6T0c0VnRaRVgyZnRtRThHaldDSDFScm1lbTNiNEVvRDkyanFpTk5a?=
 =?utf-8?B?eFAwMlh0SCtEeXZKVmZ2TVltd2dVNXAraVJ3dGllMmZWcG4ySUZUV3pLSmlV?=
 =?utf-8?B?NDJRWWQyUk9PRjdraE1hQUpZcEdsTXlUMkQ3T1JJc0htbmRBU1VsWUMrVmtI?=
 =?utf-8?B?MkZwazR3UDNKKzlqTEM4UFFKK01TamJCSlJLWXRkK0JBTW1ycTBCa0hnS0Zw?=
 =?utf-8?B?aDIxWlJNZDkzdFR3RzMvMjZhQXJwVThHNEhXbVdlc2tEcWpYekROdzczQ2hN?=
 =?utf-8?B?OGN5VWJNYnVYWTd5dytvL2hYVmpqa2E5RmJuUzRwOWNFWkN1NDJmanprMG9m?=
 =?utf-8?B?YWZZeW9GbittVEpDcUZ0ckFxNnBvenpqZ3RYUklKb1J6MS9vYUFxMWpiZkVY?=
 =?utf-8?B?OHQ5Wk5vdStwMjE3RWh3YTBPK2pxaXRzU2RhL0dBRlllYkw4RCszQUI5N3dN?=
 =?utf-8?B?Yzd2T0xZUklrVk5yb05GRVcwdHdCcGl0Y2xRMnVuTTlKRStZaGkvREpLMElt?=
 =?utf-8?B?Qm9JSncvMEtpU0hMVnFHN1g0OVRKbEtpbFl2ajR6dyt1Umo2QTZXbmdYM1dt?=
 =?utf-8?B?am9tbHRZNFJZdDdqcjRPWllxYkhCd1BmdGt0NXVyN0ZBdHd1SVAwempaNktO?=
 =?utf-8?B?QmtEWU4vdit6M1k0Q2FFcHNId3ZMWTFJaHd2Z2paRUg3Y0ZyVXgzQ2wzREhM?=
 =?utf-8?B?dzFPeFo3V2ZNbnloemFraWZsWk5OdzFKemZTVTVyUWFqakJxSU96eVBwV2tu?=
 =?utf-8?B?d2RoVzB6N09HMThhMFpHNklHd0VKM3pQNlVCVUE1N3lPcFVWTGV4ODFQN1JG?=
 =?utf-8?B?MzR0UGREYkRUY05ablQ4alViUHphc2JUZ3pFeEhpRFFlNTJXMDVaR2cyRzYv?=
 =?utf-8?B?eTF3Q2RFQ2Q5K1F0K25JeGt5OHc5QWJwSmNRYzM4S2NPVFRPL21KMDhHRklL?=
 =?utf-8?B?akw2MVhtLzVZTnV2NGR5enBxOURmaVljckF5OTMrS0o4ckxkYXdGWC9Xbmg5?=
 =?utf-8?B?WTdEQjB1OFVuWUNLWXRCd2I2aGp4RTBsd2RKQzZMMjFFb3I4emVjRlltZnJh?=
 =?utf-8?B?bjQxOEZ1NzgyUnJHTlhBRXpTTnI1NWxKV1dXaUtLKzVnM0FnV3BLakRSSTFV?=
 =?utf-8?B?UW42OW1qM0VkRVhaVGkrNW14NVZPT3pvQzFnbVZTZUphSjlyc2hvLzkyODZS?=
 =?utf-8?B?b01iN0V4UzE5djV2WDM5TnowMXRzRG1vdytjSDdBSkMwNytDOWVRU2hRdTBZ?=
 =?utf-8?B?ZmN6T1RNQzlpaXZGSFZHdDd6cjRRclIzMENqQmtNcjRvWGd4QWkxbE5ydm9U?=
 =?utf-8?B?YUh1SDhMRDNuMEpPT1NaYTIzV1ZEVnF2Sk5EM3pGN2xVbnNYRzFiQ0E3RDhs?=
 =?utf-8?B?eFpSZStyZ1BpalpLSlRzV1VRN21QVEViUlZjOEpTRUdwcms2cmRWeE5BcjhI?=
 =?utf-8?B?cHdNZzVVOGNxcEhxUEZBK3VCTzhKSEJtYWYvWmdLT2VrZmdqWDlOTkZPb2Vn?=
 =?utf-8?B?ZVFJenRTZ3NVbTJ4ek1Bdi8raUZBVTBRdnVSdjU0VEJtaDdHOWlSTHpYZ0dr?=
 =?utf-8?B?Z0ZSM2RmejlwcnZKQ0tia3V4bjkzMVVZb25Ba2hjNnNzbC9nQ2NBdDhZTm0r?=
 =?utf-8?Q?CrIPblBprrE19TyxjgxJ6I2QB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346cdc7f-f455-4223-fd3c-08db6927fcf8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 20:27:47.3605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2i/yjoQmTj/TdZtmW/YvQEbDl/ApC8jU1fXK6fO7IXzmfzzHx2W4ZWNOtC8KrXy5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482
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


On 2023-06-09 16:22, Felix Kuehling wrote:
>
> On 2023-06-09 16:13, James Zhu wrote:
>> Set waiter's activated flag true when event age unmatchs with 
>> last_event_age.
>>
>> -v4: add event type check
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> index c7689181cc22..2cc1a7e976f4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> @@ -41,6 +41,7 @@ struct kfd_event_waiter {
>>       wait_queue_entry_t wait;
>>       struct kfd_event *event; /* Event to wait for */
>>       bool activated;         /* Becomes true when event is signaled */
>> +    bool event_age_enabled;  /* set to true when last_event_age is 
>> non-zero */
>>   };
>>     /*
>> @@ -797,9 +798,9 @@ static struct kfd_event_waiter 
>> *alloc_event_waiters(uint32_t num_events)
>>     static int init_event_waiter(struct kfd_process *p,
>>           struct kfd_event_waiter *waiter,
>> -        uint32_t event_id)
>> +        struct kfd_event_data *event_data)
>>   {
>> -    struct kfd_event *ev = lookup_event_by_id(p, event_id);
>> +    struct kfd_event *ev = lookup_event_by_id(p, event_data->event_id);
>>         if (!ev)
>>           return -EINVAL;
>> @@ -808,6 +809,13 @@ static int init_event_waiter(struct kfd_process *p,
>>       waiter->event = ev;
>>       waiter->activated = ev->signaled;
>>       ev->signaled = ev->signaled && !ev->auto_reset;
>> +
>> +    /* last_event_age = 0 reserved for backward compatible */
>> +    waiter->event_age_enabled = 
>> !!event_data->signal_event_data.last_event_age;
>
> This should also be inside the "if (waiter->event->type == 
> KFD_EVENT_TYPE_SIGNAL)". I'd do something like this:
>
>     if (waiter->event->type == KFD_EVENT_TYPE_SIGNAL &&
>         event_data->signal_event_data.last_event_age) {
>         waiter->event_age_enabled = true;
>         if (ev->event_age != 
> event_data->signal_event_data.last_event_age)
>             waiter->activated = true;
>     }
>
> You don't need WRITE_ONCE here because there can be no concurrent 
> access before you add the waiter to the wait queue.
[JZ] Yes, this looks better.
>
> Regards,
>   Felix
>
>
>> +    if (waiter->event->type == KFD_EVENT_TYPE_SIGNAL && 
>> waiter->event_age_enabled &&
>> +        ev->event_age != event_data->signal_event_data.last_event_age)
>> +        WRITE_ONCE(waiter->activated, true);
>> +
>>       if (!waiter->activated)
>>           add_wait_queue(&ev->wq, &waiter->wait);
>>       spin_unlock(&ev->lock);
>> @@ -948,8 +956,7 @@ int kfd_wait_on_events(struct kfd_process *p,
>>               goto out_unlock;
>>           }
>>   -        ret = init_event_waiter(p, &event_waiters[i],
>> -                    event_data.event_id);
>> +        ret = init_event_waiter(p, &event_waiters[i], &event_data);
>>           if (ret)
>>               goto out_unlock;
>>       }
