Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9FEC00140
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 15:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB38AE791;
	Mon, 15 Aug 2022 15:17:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19048C0A25
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 15:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqM0Fu3zKUwui31BDQssVAO6AXwdjZpjLUZwr1jHOReUacNNBfe0Kxd8rCBRwf10cSn5u/UGUJebLgRkvmXyxRLeLK6oic2TUutP3jZtDCOTQIxTMrfFjzaII8KJf1Cmat6SyUgx2ZRCZklNFbt/tuIE1jZAA2dY6Qsv352uEjVxXSOlDlyclaemkiC5dL0RJkchuyLnrRU9sfG4+EuJpFw5COYMwmqHn15uNStqTgoBG3aGBup+99VhRm90tbbyiQKbPs53f0nlNLB+3L2wABBTXIOlc6Ad3a0QkmE2stwaIQueCL3K4LZ5BPPjfsEpCCqwAgAWT2xxiqfSdiLfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UnNlpd4U2AmdagqwCSKcI+NoGBO4nlYSfXfMSlrGQQ=;
 b=LQfvcxKhi+45Fg5+9iV0kLeA9VzqP/FCM2LPkiUHY6nKFeLjLYWdl1Uo07iEHoCWELHzHjinrkh5bf/HYYiZ7rqJ3pQ9qd7V05VXtsRXR4/DtEol7dSD0NLaGsOfXeo/y6AJNXwaDLAt1Fvvo3dU3YSKRv4GkWAmMZwdabdNJdYEHc9aATm/XHEBWlOhB03QOtAuQF1Eiqqd1kHYT1W/L9Yx4qSjjxKSiDWFd6iRHgkrhkG+gf9FDeD/pVfX06tcB2DCGsha2FpQI3M8PCayUFrAYlUjPxOuhZBnrXYV9D91nnaBW1L2L/KwKsFFbDSBy4gohG8aN/zS+rRC5EjO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UnNlpd4U2AmdagqwCSKcI+NoGBO4nlYSfXfMSlrGQQ=;
 b=lwywl/mNS2n5UQ6bomzZ6KZwstIMx8uT437YR43B3HIBh0I/hTlXnmN+5nPrv+VhfCH9bkpW0XKeNYR/F/f3daUJc/z+wwC5PDdxiT9H+VYuHfXnaHhJZ6WJsG3SLjag2aT6NfUv6moO25vj6WLPzNThnd3JHVITWSWmX36M0kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Mon, 15 Aug
 2022 15:16:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 15:16:49 +0000
Message-ID: <04d1f7d0-354f-4a64-5ceb-b378997e1203@amd.com>
Date: Mon, 15 Aug 2022 11:16:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix interrupt handling on ih_soft ring
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220812205624.2902630-1-mukul.joshi@amd.com>
 <c761f5f9-eb52-c04b-e66f-1c05cfb2c2c1@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <c761f5f9-eb52-c04b-e66f-1c05cfb2c2c1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d5d5368-1150-4386-bbb3-08da7ed12d0d
X-MS-TrafficTypeDiagnostic: SA1PR12MB6774:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyH1HwZ2fapFAg2FG5WdEnyNPQ5eG/0xy5UDedLB7iwf2Ubo1px0K/oIexX2Ai9hqyXRT3FcC33jqwlKVHe0MJOXdeV2Cy8lNexjpv0SdeJtlBi9gnswurmPBIGxrJf5YXyn/K8TKHKo1ntJLyoYmF9fMcZoW0X1EI71O9fox5zlg9xkZnn5gIGSDF9IAqLD2iIAHPEwte9k6bMIyv7CM2t0diAm4/lzraLwTtVPpo5Uaj6UgUsVKzEw77UZVQlvuGFzia39WBLrpSkZT8xTVWWdolBJcqK+Y5a2tXsFXeXJlGbm67LoYLCGWaPYVjfb9P2daNksIiupYvqkY0Y1Cbecc3SjtmsEfYv57u94QOcbSLskD76tXx/g9+KRTvG1z9C5IVwtYLAKufO5EDL0WCEbHpgy/XxnikYQbCp/sEFE4b20x33m0JvEqWXzkceoZw2Y94U+Uz+EyBoz2mFbNsE6oMVv4PPmWhSFDw7+BY2tl39y9uzcHg/fBOQqN0plFbyWFpWZrlwx0XJXBmPapHxs2GUgByYKjhoHfwbajs3eI1xSC9L6GsPGPkTB7VPn0vt0IkpPEXZVBMpabdgti1olt9WXahlt+59xAVbhvzu10fmR2rTLvBuYKcgJakBQ9Ml2WXiVKkJx/Yzxvxa/BzrnQSZ6W6NAAVnL4V39mKJ4d0gnCjLMNNTOaxoJ0/ynuGqkC1avYnQN3U1BshU5TIM4p6B05XXdCTv9TftigOj9IVEJNpl/VJBrucyv3rRx28Y2s2KTGHs1+4cWMzB6lIVDm8gkrrlVF2JVVS4zOUS2v0C76ucwiIT4vokMyFiu/4HNtVGGCQ5nrA7gkOoNb0Wm1nAX1rLS1JQIdRqHuQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(66556008)(66946007)(2616005)(316002)(26005)(8676002)(83380400001)(66476007)(31686004)(6512007)(66574015)(186003)(36756003)(44832011)(5660300002)(2906002)(86362001)(31696002)(8936002)(478600001)(6486002)(41300700001)(110136005)(6506007)(38100700002)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enpaYWxpNkxOZHZQamVVL2JtdlU0T3pUVDdhNGVKSFptemRZMUZQbjRRSFlK?=
 =?utf-8?B?SFFjd0ppOVAzeGQ5T0tmOTNoMzloLzZ4bUtlWTNRQnZYd2lyK3djQ0UrOW5O?=
 =?utf-8?B?T3hvMFpOM1FlS1ZoYzlkRXNiL21TcVE1UmVYZnNMRDdxdkJVdm5vV0FUNm8z?=
 =?utf-8?B?REFEVlc4YXBRckp5aE1rZmlKbStmaWRrSVVTcjAzNEE1UFQxeUJHdHo2QUU1?=
 =?utf-8?B?aW5ZRGFuOGlQTWR1VWEycW1SSTh0NHdWUXFmRFhvYjN3M083eE4vWUk3cThw?=
 =?utf-8?B?WFJYZHRYTlBHMk90SGpOTUdUY3dTNUZQQVlPNTFWTzRKUVhvNFNZQlNjdXNH?=
 =?utf-8?B?WDBPLzdIMVRlbzczYWt6VVh5WjFndVpTbW9maWhZRytjMi84TU1RM3Bwc3Zj?=
 =?utf-8?B?R3pRejg2ekwxUHpSTWl0YVBWMlhXUmhacGYrekdBdkZxdXZKNGdJNGdYTW9x?=
 =?utf-8?B?NmU4TTFRbnNwVzBjVXRzR21mY083UVhBTjBrNTNtSkFoa1Z3Q2x6MktNNVBj?=
 =?utf-8?B?MExGbE9wa09ndndpM2NadzNGQWxwZTJJaThpOG9aTWxWVWVNby9uVjlZSkdv?=
 =?utf-8?B?LzMySm9iaW5iWWd6bnJiK0JMRlFCTTdrUWlkaHlWbDVFSG5MY1dXM3Nob2pP?=
 =?utf-8?B?TFZuK3lKK21ZSGVTUU54Z1ZrRFdtR3VzeFNuMjRtZmFDbGtsUS9HS2Exd1RY?=
 =?utf-8?B?dzFFUU9kSDFvb2k2Uy9wbG5Bc2M2MjM5djRsS1d1WUgxV293eGNuRWU0d2Nq?=
 =?utf-8?B?a2hsOWpNdHhrSXgvKzVSc3V5bjRPVU4xQS9oYnVWakE0RVZWOUl2d3BSemNs?=
 =?utf-8?B?WGNFNE10L0w4T2UwTnVQaGQyTjFEZnd5NHJvY0FGNk1pSFdjVDAvSXZaZFps?=
 =?utf-8?B?eDNOYmNLSWlleENxYjgvcjZtTWwvcmQrSFFHKzBQWDdka09tNGI3TnhGdVlh?=
 =?utf-8?B?Zjh5VStGOUc0b25sS3dQeUUzU3dEdmlISERPc0IyTWp4S0lRRzFyejF5RUsv?=
 =?utf-8?B?ajhOOXJReVJqcjhyOTNHUGJRNzU1bmcyV0wySGd4WVUrMW1YT3JqZm0wU3dR?=
 =?utf-8?B?VFZBQkhCd01IQnhBOSszOS9LSXdtbzZ5SEpBeDlUN2wwNUNHcmtpL2EwTW16?=
 =?utf-8?B?UlRnakZWQy9PNk1jRWdxdUh4dStFQmttUzhablkxMTIzdk1oYWtJbTRCcTJF?=
 =?utf-8?B?cmNTMWtYOEx2ZWZhbFJ2bmxCeUoveXFSM05nY2VjUlJxbndPaHJwNTJESVJZ?=
 =?utf-8?B?dzR0bGRQRGczS2pjcktGcGZyUnNSK2l6TDgya25IWmd2WmIyY0xZMVNLcnR3?=
 =?utf-8?B?dHlZcmJmemN4T3BlSnlvRWh0bjRhT2Q1S0N2eGFjYVlIWllFYytHL3J4eFlt?=
 =?utf-8?B?cURUcW90V05Fc3pNNjJYeWIrVlNRZmYzZVpPYjRJSzRKQWVHQitOcURFOXdT?=
 =?utf-8?B?NlprYXNsMHBPMWtjZUVtaVJMdjY1NGVzNi9rS3h1U3E4OXJTQWdaWFdxUm9B?=
 =?utf-8?B?TmRYdFB3by9TRVROVFlXRUkzTUxiTmpWUU15ZXdOL2lqZkJqWFhsTVpMYnRC?=
 =?utf-8?B?K1kzQStLUkVLNVJuVGN6ZGxDbWh2dGgwTC8yMVpXMlg4eGVMdFlyVXcyZVFI?=
 =?utf-8?B?NkVicE54Q1YzN0RlK3NlRW50VjcweVRoYm5QWVQ2K2pVZXdLRXlHTTE5RHVu?=
 =?utf-8?B?QWhBeXNaSVNDSTlOSDgzK2wrUUcvZElRSVF3emcrMUlKRjcwL3J4MFZ5ckxP?=
 =?utf-8?B?K3drNDJHcU9JWUNRUmFOVEd3MkpIb3h2TUlsOGMrbk1nSzhYTWdldHUxazdV?=
 =?utf-8?B?YjFVd2dFVlRTRDA0WS9mMVlsaUhndmp4SHZjbGl3M2FDQzhPTSs1V0tLT3Vi?=
 =?utf-8?B?WjdnU3YyQVJDL21ZU2dxMnlOTDZrT0dQZklDMEtOSEFoT0tzYnZGUy93ekdo?=
 =?utf-8?B?b2F4ZU44dWFEWE5zWE9yYVhqMXlodXhVTFIxWXhFTUlPUEVRd3dGOUFjalc1?=
 =?utf-8?B?bEVhN1FkL3BER1dmV1ZtOHhxTUdvSTNXM0RpVVlqeWs2NG9lQlFSR3FGaVJ3?=
 =?utf-8?B?d0tuN3o2WERMbnF5OGc4ZXVlVFo5UmxwaGdkYndlSGJhVkRacnEwVER2cFJj?=
 =?utf-8?Q?Mb3Wj9Uo9NK2j+6CWV/7JHAKs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5d5368-1150-4386-bbb3-08da7ed12d0d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 15:16:49.6579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2wof82A7FEBYgyvKpc9FpX8cpCF7Emk+2oCQKbb1zhXPG7Vl3sZG29gGDVgmsPzDq4Z2+8UWoNV4hcTqT2wyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774
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

Am 2022-08-14 um 13:27 schrieb Christian König:
> Am 12.08.22 um 22:56 schrieb Mukul Joshi:
>> There are no backing hardware registers for ih_soft ring.
>> As a result, don't try to access hardware registers for read
>> and write pointers when processing interrupts on the IH soft
>> ring.
>
> Mhm, the original plan was to have different ih function for the rings 
> but I think we just forgot to implement this fully.
>
> When you do it this way you need to apply it to a bunch of different 
> hw generation as Felix mentioned as well.
>
> Might be easier to clean that up.

Right now ih_funcs cannot be different per ring. Are you suggesting 
moving the ih_funcs into the amdgpu_ih_ring structure?

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> index 3b4eb8285943..2022ffbb8dba 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> @@ -385,9 +385,11 @@ static u32 vega20_ih_get_wptr(struct 
>> amdgpu_device *adev,
>>       u32 wptr, tmp;
>>       struct amdgpu_ih_regs *ih_regs;
>>   -    if (ih == &adev->irq.ih) {
>> +    if (ih == &adev->irq.ih || ih == &adev->irq.ih_soft) {
>>           /* Only ring0 supports writeback. On other rings fall back
>>            * to register-based code with overflow checking below.
>> +         * ih_soft ring doesn't have any backing hardware registers,
>> +         * update wptr and return.
>>            */
>>           wptr = le32_to_cpu(*ih->wptr_cpu);
>>   @@ -461,6 +463,9 @@ static void vega20_ih_set_rptr(struct 
>> amdgpu_device *adev,
>>   {
>>       struct amdgpu_ih_regs *ih_regs;
>>   +    if (ih == &adev->irq.ih_soft)
>> +        return;
>> +
>>       if (ih->use_doorbell) {
>>           /* XXX check if swapping is necessary on BE */
>>           *ih->rptr_cpu = ih->rptr;
>
