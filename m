Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6A3C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 22:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 910BF10E5E6;
	Thu,  1 Jun 2023 22:06:30 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBEE810E5E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 22:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eo1rH8XoN17Hb51Vm945iNdggncjcBPUCsDzwBv2VvM+gv/3EkBbLcXT3fUdWCneAErU87HxW+7RQvDHQiz0Do5l/V8m0D/fdjsKUuLDds9NDlic4c7IejmozK5pipdQ8sIqKYn8lQS8KH9rmQQu/JQWfsv8b5bplyHmyKPsdpyPdnTRF+VEOFTpzahmahQvYUqXR9Tw2UKZ69gNRj9kYK28aL2OE+DSFMl7tqGahUdPVntxncgrn2qrEw66G5/Ymg5XAu6fXftRjrHIeCGWgqvduXGOOa/YnWgLU8JsRcjptx6Q/ixV4WIG0ro5qNrVrP9zbJjbMm5yeSjD+/4gvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rSL2QY4deuRVXd+CGasEKTdqIdxp9XDda+MKcVlk10=;
 b=YE+2M4Gzc0XODpLPuo6YFaYlCk9n/VKZpZ311vtM0ZW4NiuRRJCOmC2mkhaOhQmiFtVaQ7NbPX8Nsv6+mZdT3WDyf91YCHZ7wGNMc9fMbqQ1+L1cpXBL5tiwIgczmZb9Rx5+GXwMzG/8PU8VdRczENiNsx8OCJjjIkYxMBUiNlGySEJn1Liil/aXClOck5X5tP1WFz/63eQbTbsuy/SSGLzbk2OOtF29pCcIvSbJSixQmR/pRbASqbPCVwrHvz5SEVmXe+OvDqMC3GAIaxd29W5qijFsluTWw0M7jyUWxeRgw9lfOoO3A3m9vBpV+waYp/kGbj8q5XQrprf6qix5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rSL2QY4deuRVXd+CGasEKTdqIdxp9XDda+MKcVlk10=;
 b=M+lrS/WURq6N39ef1lFyx59fn6mvoBa9/nANywrplBI89Wyk1+ovYixo6sVggOyFb3rK4IL3DQBC7kwC55DFJqvJxa1cKYAsutLfKTF3hxaiD51wHgUOCg2P5yPCaNEhNt6v1zIdnRcAdTpR4mAMdvQ61GJv59OBHRuNSBiqPZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1750.namprd12.prod.outlook.com (2603:10b6:903:11c::21)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 22:06:25 +0000
Received: from CY4PR12MB1750.namprd12.prod.outlook.com
 ([fe80::de84:8cc:ac46:12fd]) by CY4PR12MB1750.namprd12.prod.outlook.com
 ([fe80::de84:8cc:ac46:12fd%9]) with mapi id 15.20.6455.024; Thu, 1 Jun 2023
 22:06:21 +0000
Content-Type: multipart/alternative;
 boundary="------------IgFcC0avqRSMI3jAI0cK7Oo2"
Message-ID: <d07bcd38-797e-6471-d5ed-18251c015d35@amd.com>
Date: Thu, 1 Jun 2023 18:06:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] drm/amdkfd: don't sleep when event age unmatch
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230601204740.1501616-1-James.Zhu@amd.com>
 <20230601204740.1501616-3-James.Zhu@amd.com>
 <04b12a87-6672-3241-456e-f6947f09de27@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <04b12a87-6672-3241-456e-f6947f09de27@amd.com>
X-ClientProxiedBy: YQZPR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::6) To CY4PR12MB1750.namprd12.prod.outlook.com
 (2603:10b6:903:11c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR12MB1750:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: 800eb7bc-2447-4f39-9d55-08db62ec6ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HYDGtth3NvhpV4LHxR3467sH+tZBpZbx3Ksysj9/Fl8TtUfGa3bOmbjtf+glSvleiYWJLHBNDSO5QULn0WAo9FDehon/xH2lQ0MGaVpj448iulByU2q4mfSApCO1pJ4OfDI5mKdNL//3jq+k6EL/vujGCO4IqhbPDAGFrl2OzFLQ8LV/+ibLh+oDWCA1xLMXXqrlAzT3NfaM9YXsPuXcR6MUPJPWgJSLoiuew6jikyE/Nc2MrSPZ5raleCKJ5eBZZxj4MAtxIp6IBUrnnDA8oCZ18YrUYY5eiB38RqXzDVDRcGt6ITb76U+Qt5kfIScom+nbeA+8yCrqNVARAQHP6S6XRgiJzgZ9QWV0DfUMGS6L/A3rsDTAgWO6vLEHWKZSs3KjPzHxPqy/aEJPrXeUMsaK2WplQDVqww/2u5kVslALYQOnKG4GATGbykAbS3vdKbNSvKROtJgpIb+6vgStmZf6tGC9SQWNDzrRakJPrk7LIdjl7nGDrUBrQZbBZtJhrHmvgDHjHk3coV+niXmbcKtjERU6UmEgkYRlzHxv39IjTvxTyi8MgMspzjHkn1C3YQZ0oWLl3sLb29C+oFp6RTNhTnF5YSvVCHQpPg4bNpYRWQRGCqy3K1SSseYVijqETCKCJcVcbX7bRPzg1001A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1750.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(6486002)(6666004)(36916002)(33964004)(36756003)(83380400001)(2616005)(38100700002)(31696002)(6506007)(53546011)(6512007)(26005)(186003)(2906002)(66476007)(66946007)(66556008)(4326008)(110136005)(8936002)(8676002)(316002)(5660300002)(41300700001)(31686004)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU9YU3o1enl0eEhaeC9ZQ1IzZnZ1ZmtHQ3RwTHorQXFBdUk4UGlqZnpFTlZq?=
 =?utf-8?B?eXdaMmd6S0w5bU5vaWtYbjArMnhqaEJERzF3S0x5RWtHdUM2UU9YVitqVUtB?=
 =?utf-8?B?N1JXelRTQlVBZjdhRzE4Y2YzbkZDbnpoRUk3U2VEWEg4TnVjRDQzbG9HMWNt?=
 =?utf-8?B?emdsT25Lc2FQNmV3KzJWTnc1bkJaNlNPMUVnMklhT3lLVUtOL1lZbm5TRGw2?=
 =?utf-8?B?c1p3SEhQWnorOGRFVU5wK3RUOTZJemNVbWtmZDJZVkRVaDZYejhVM0RwODAv?=
 =?utf-8?B?LzVSdE43QkNubUJ2K1hsQjdYY3Z1WWRabUJaUkxuaktpNVczRGJ5UFMyOGVh?=
 =?utf-8?B?ZnQ0SzZrQnpLNEFyRFhNazdPS3M4NVNodG1LWU1RSG02NUVIalJtYW9MNE9S?=
 =?utf-8?B?RENjQmtwK0RhdGZhU0NHSlFibHp3ckZWZDdKSEordVdMKzlnbWs5YkpUREEz?=
 =?utf-8?B?Z1FPMUkxckN6OFBNOGsrenNzYkVxU2hkRnJlRHVLbW9RM1RPNDFBU24xTVJQ?=
 =?utf-8?B?OW9FRy82QXV1QnBHSTV1bUIyVjcxRWhVODk2ZmJoVEtkZTU3VGhiNDVnd2RX?=
 =?utf-8?B?TGVUZ202dzBUZFVLNEJ5WEYxRlM2eTZuZExNY0tYclN4Rjd5K0xqaDNYOTJn?=
 =?utf-8?B?eWVOeXpjN09OOEJMbWFlM1hSbDVGMEhRUFZLUkM2ME53ZnZQMEkzTnpsRG8x?=
 =?utf-8?B?UzR5TWI5NVhZOE1ZODlDUXUvYW1BNUVGdndBWXRLTHNYZCtSRlNwSXZQUmFt?=
 =?utf-8?B?V2JwQytpTkJlVGhXcmNSK1NFVG5HRWZqNk1QZWJTYjIrK1Rubmc3dzQ2Y1pM?=
 =?utf-8?B?WkpkK042dFVLdmpiRnJCdFRKQW9YLzRPaVFlK3k4Q295eXhqZTRlT3BVckIx?=
 =?utf-8?B?QmFzUE05QnZPL2Y2R080VytyZldTVndtUXlEUFJ2OHJSeWd2bklrUzJqNTNs?=
 =?utf-8?B?UVhzZ3RGM1B1b3ZUeHM0dVc1ZzA5YnNEWU0rWHlUdVBjb0VYd0U5MEVHU0dN?=
 =?utf-8?B?YnlQdUJGYnBQL2dhWGZlRXdkUHQrekM3S0tyWWhMOS8rUVFXampyYU1JSU55?=
 =?utf-8?B?c0ppb1BBd1ZzdTZ0Q2NraXJYS08zZjNLSnBUeUlHTHp4dENvTG5EeUF1YmNW?=
 =?utf-8?B?R2o5QzFZc2xkTXFFcXdDSFF3djlad3NUcVJGSEJVVzh5a1NsRjY3RXVucFds?=
 =?utf-8?B?ZU9vTlZjOXlHdHBuSEIyYTZmakRhbTkyMkR3Z0t6dFRJc2pSN0RFWUVvZXBO?=
 =?utf-8?B?L3haSHBKczJ2ZjgxUU41UDhSeDFnVmN4bE8zWjMramQvNDlobXZ1YzV6bVRV?=
 =?utf-8?B?QUNtRWxIRFcvS3QwYkNtdERHZ243cHF2WkoxdG9ERkdyT1pRNkJpRG1adnls?=
 =?utf-8?B?ekJNZkJINmFRVjNUc0xQNHpKWkQza01jUkp0a2xNTVQ0NWFWaHM2TG5tenlH?=
 =?utf-8?B?MStFUllsbjlWRlF1Y08wejdqekJRYTg4K3k2Nm9qd1FqTmRoYTRYNXlxQ3lW?=
 =?utf-8?B?amhmemhpNDFNaG1BU2ZOS2tzZS8wQVp1dWhTZDVhOTNTK2NMMktCd2phVzlh?=
 =?utf-8?B?d0REekxLUXQ1eGJtWHZEWE1WdlYrSkVFL3JnQXppWHZGUXloWkhIdlRha0Fl?=
 =?utf-8?B?RnJaWWhUSW8xdlNUdFFhcldoRzlyZFVyRDc5MVJVTU9aUWJkQmJBZUQ0U3o1?=
 =?utf-8?B?WDFZU2N5R2x4VW5wbHQrc2pIQnU2YkFXUmhKNiswWFJzUzc2My9TZ2tNSVI1?=
 =?utf-8?B?bjczc09VN3B4ZmRlL2JMemlJUEQvdjYwNmRDTkM5Y0RjTHNoZkNWL3BPU1N4?=
 =?utf-8?B?UzIvcUZrSzdyM0JLMkFjZzhzT3FJdEI2UzkzeXYwelp6TW5CL2ZGQUdxdEt5?=
 =?utf-8?B?aVVLcjBzTE9lMThMUG9RRE9GMjREUmtmazFianZhUkwwa2F4N2lYKzZSS3Vl?=
 =?utf-8?B?OTY3NnZaZjBrL0VTZzdJeFAveThXWU01bkJsMUtKSzZJRXlaaWF1MGU4NzZy?=
 =?utf-8?B?a3lmeExKM29qaXpJODd3TTVteGhRWHYzZnM0VmNlTmlpRHM4YVFpZlVndjVP?=
 =?utf-8?B?VVp4VktSM05OWEJrdUFEeW9XYmZSRS9PeFdjMjV0T3E1WVJna3NlRGR5b1Ja?=
 =?utf-8?Q?MSfdraeT9KW826idLnELNHaVa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800eb7bc-2447-4f39-9d55-08db62ec6ee0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 22:06:21.7769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSiNZ2iJTlpziCpThibTeza4cjqLbZLBvYvUZQGhf/jyheABa/W/5k6WDIhFv1d2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
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

--------------IgFcC0avqRSMI3jAI0cK7Oo2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2023-06-01 17:17, Felix Kuehling wrote:
> On 2023-06-01 16:47, James Zhu wrote:
>> Don't sleep when event age unmatch, and update last_event_age.
>> It is only for KFD_EVENT_TYPE_SIGNAL which is checked by user space.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> index b27a79c5f826..23e154811471 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> @@ -964,6 +964,19 @@ int kfd_wait_on_events(struct kfd_process *p,
>>                       event_data.event_id);
>>           if (ret)
>>               goto out_unlock;
>> +
>> +        /* last_event_age = 0 reserved for backward compatible */
>> +        if (event_data.last_event_age &&
>> +            event_waiters[i].event->event_age != 
>> event_data.last_event_age) {
>> +            event_data.last_event_age = 
>> event_waiters[i].event->event_age;
>> +            WRITE_ONCE(event_waiters[i].activated, true);
>
> I think this is probably not necessary if you're returning before the 
> first call to test_event_condition.

[JZ] Currently, the returning is with test_event_condition. Since some 
conditions needs return with all events signaled.

so all waiters need check and update if any event interrupts are missing 
here(unmatched event age).

>
>
>> +
>> +            if (copy_to_user(&events[i], &event_data,
>> +                sizeof(struct kfd_event_data))) {
>> +                ret = -EFAULT;
>> +                goto out_unlock;
>> +            }
>> +        }
>
> When waiting on multiple events, it would be more efficient to catch 
> all events with outdated age in a single system call, instead of 
> returning after finding the first one. Then return after the loop if 
> it found one or more outdated events.
[JZ] Yes, the code is working in this way, when all events' waiters are 
activated, the following test_event_condition == 
KFD_IOC_WAIT_RESULT_COMPLETE, then return to user mode without sleep.
>
>
> Also EFAULT is the wrong error code. It means "bad address". I think 
> we could return 0 here because there is really no error. It's just a 
> normal condition to allow user mode to update its event information 
> before going to sleep. If you want a non-0 return code, I'd recommend 
> -EDEADLK, because sleeping without outdated event information can lead 
> to deadlocks. We'd also need to translate that into a meaningful 
> status code in the Thunk to let ROCr know what's going on. I don't see 
> a suitable status code in the current Thunk API for this.
[JZ] Basically, this failure is for copy_to_user. It will lead to busy 
wait instead of deadlock.
> **
> Regards,
>   Felix
>
>
>>       }
>>         /* Check condition once. */
--------------IgFcC0avqRSMI3jAI0cK7Oo2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-06-01 17:17, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:04b12a87-6672-3241-456e-f6947f09de27@amd.com">On
      2023-06-01 16:47, James Zhu wrote:
      <br>
      <blockquote type="cite">Don't sleep when event age unmatch, and
        update last_event_age.
        <br>
        It is only for KFD_EVENT_TYPE_SIGNAL which is checked by user
        space.
        <br>
        <br>
        Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_events.c | 13 +++++++++++++
        <br>
        &nbsp; 1 file changed, 13 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
        <br>
        index b27a79c5f826..23e154811471 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
        <br>
        @@ -964,6 +964,19 @@ int kfd_wait_on_events(struct kfd_process
        *p,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; event_data.event_id);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* last_event_age = 0 reserved for backward compatible
        */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (event_data.last_event_age &amp;&amp;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; event_waiters[i].event-&gt;event_age !=
        event_data.last_event_age) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; event_data.last_event_age =
        event_waiters[i].event-&gt;event_age;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(event_waiters[i].activated, true);
        <br>
      </blockquote>
      <br>
      I think this is probably not necessary if you're returning before
      the first call to test_event_condition.
      <br>
    </blockquote>
    <p>[JZ] Currently, the returning is with test_event_condition. Since
      some conditions needs return with all events signaled.</p>
    <p>so all waiters need check and update if any event interrupts are
      missing here(unmatched event age). <br>
    </p>
    <blockquote type="cite" cite="mid:04b12a87-6672-3241-456e-f6947f09de27@amd.com">
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (copy_to_user(&amp;events[i], &amp;event_data,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct kfd_event_data))) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = -EFAULT;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
      </blockquote>
      <br>
      When waiting on multiple events, it would be more efficient to
      catch all events with outdated age in a single system call,
      instead of returning after finding the first one. Then return
      after the loop if it found one or more outdated events.</blockquote>
    [JZ] Yes, the code is working in this way, when all events' waiters
    are activated, the following test_event_condition ==
    KFD_IOC_WAIT_RESULT_COMPLETE, then return to user mode without
    sleep.<br>
    <blockquote type="cite" cite="mid:04b12a87-6672-3241-456e-f6947f09de27@amd.com">
      <br>
      <br>
      Also EFAULT is the wrong error code. It means &quot;bad address&quot;. I
      think we could return 0 here because there is really no error.
      It's just a normal condition to allow user mode to update its
      event information before going to sleep. If you want a non-0
      return code, I'd recommend -EDEADLK, because sleeping without
      outdated event information can lead to deadlocks. We'd also need
      to translate that into a meaningful status code in the Thunk to
      let ROCr know what's going on. I don't see a suitable status code
      in the current Thunk API for this.
      <br>
    </blockquote>
    [JZ] Basically, this failure is for copy_to_user. It will lead to
    busy wait instead of deadlock.<br>
    <blockquote type="cite" cite="mid:04b12a87-6672-3241-456e-f6947f09de27@amd.com"><b>
      </b><br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check condition once. */
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------IgFcC0avqRSMI3jAI0cK7Oo2--
