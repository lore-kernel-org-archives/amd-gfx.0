Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205C6C38A2D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 20:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE9AD10E66C;
	Fri, 21 Oct 2022 20:53:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE61310E66C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 20:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARkBMaSb9TQmB/HWxf2KlYVhzZ+sMz47Yu3aO/fVN6KwWS96ENj93os5jgl9vlC330IG8TBQWzg6kFxcuJ7UWhGTxVF86ukqKLu0u0t7mG3JIk3j6zsTN6eGqvcOoDH+5qqPd8TWEkkLvVJS0sTILhJEpTM/4QPLsmv/kF/XOAgn5A8xeJDJbBcaef1Vw/pQiydvc0LiQiD6cJ8MC3A72KBl+BNGKVec7o4fEE85AMNKc1/SvWjBeuYpIxXLdPa0KsxThTKNAVERugMhhyoJHGP/sWy8y+PLQRlDoeSQCiI5T7wFxAsrJ+5UwhZJwxYOeh6IWmAa5uo75B4OeCFNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgAjhM58gMnYS5/rqyowoKrwd0Ynljfvqpw5HNeV4zg=;
 b=KR1KNcaK0+EdiObfsQ+kGLoBjNfq1Gv2aSghmXWX0y1a9bI3WSGMEX9aW2SCQbWl9qFSmB3ZtGA5lf5mIr3uMmdTDIZlHZnE7D8b+/bWWgvNvqiBai4uYp0csbVYw3+XmxQEE9pFmfsfz8BN9yIW+xSNtauRU6Ys3zRIep1RgDbWIBggssIz5NLLeFnaM9G0nLPPvu1ZWaUE1uh5o21wdBJ1vTUHqbWDOmfC+HHr6miO1M2P51HPiZJI2pQDWw6PxWY60ATKXkn55uBVwxlUUUrIxz49aBG87cOvZLhfB2qIEWGBoM41vmLsteFUtf5+sLdww3cIfBBwZ5UTz6m1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgAjhM58gMnYS5/rqyowoKrwd0Ynljfvqpw5HNeV4zg=;
 b=kVth0Bgnn2XHahWMSjMQYhAJgg6+gtC0ObY1yeboHTPfxjmq4B2bVPVnbzZLx17OlA8mZPLHKehdPL5l/WZkXmaRXmmN7VmMShKTQmo4gVnRqo941hiYvMZFWS3DHPqC4+4F+ihAWoLjZfA8eCkVOm85zvlWm+/41cQzFaXVhpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:20a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 20:53:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7e91:f457:9ec5:33be]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7e91:f457:9ec5:33be%6]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 20:53:27 +0000
Message-ID: <5c9c6edc-0b6a-7bf0-6ec3-9916a339b8d0@amd.com>
Date: Fri, 21 Oct 2022 16:53:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] drm/amdkfd: introduce dummy cache info for property
 asic
Content-Language: en-US
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221020091515.2758445-1-Prike.Liang@amd.com>
 <e92f2184-73bc-eb3c-d903-5a46c5c34ac0@amd.com>
 <DS7PR12MB600544275C2AB15530224DC5FB2D9@DS7PR12MB6005.namprd12.prod.outlook.com>
 <016ec155-12da-5a2d-9395-6941e332833d@amd.com>
 <DS7PR12MB60059C77644EA8907AFDC775FB2D9@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <DS7PR12MB60059C77644EA8907AFDC775FB2D9@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0002.namprd14.prod.outlook.com
 (2603:10b6:610:60::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 64bb6c43-0ec9-4183-eab1-08dab3a64d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTlqIIZYHMgwOTQ0oBA1I5h2wX559GrkW679gqtOf7fS6LolkxT3BpwrKq1AUnG+vPLWwpwnb80WSNYhgre2KWBCKfT1gTgkp7rrdoQlwLAk7/7x4whoozua3GJd4a2CZkC4BVgKvLnCt8ycYzHB4H7YljAS5mJlFSWg2B3mkfRx+7eQmHkAzKnGhwfceWcgRzgJcFCAoUuLmGbVx8aEJcr0At4VgVKWBvdFKf6mAThkQD5/8mDwnQIvMf+FlpoXoV3wgm5SkI2QkzWPUT1fJzranV6YH2fiwvSOG8L7fMbcto2tGicPUCGxv3EgQBzD/Cy0QXaRLc7QVByJDkozw7SNVd1L0ijpLKrQwCpdrqJyuiqmAF2H/ncMUhmF6YDdG52jIcFPYi3ThLbYUdnv5b9IkLXtVNdJ9Sc4NPR6pBvdOq+dh1B+Y86ZGIpKH7H55XrOGn/7cR380er4rgaKU7GZw3Xxm2aYe5cX479ghtLTBG/xVW4sSoIild/Ec4/NBdT3iAMuFjJ3HpBbP3gRQ8nntqVJNXPWoECect+E9ZAUv3uWZ5uGV02Q1+kw+l4zJf0am2Mb/eze9J5o+6Q7qFeQDKpx6iis9oqUAVm+2ukaQm52DNxRwcsXFnKjKoizRxHYE0ua8Bm8Pxkmoci6ZFX2bNlo4BXGOgCPPkWK7uvtNb1p66DHL7lE09FeFIH3QV+uC4dZ7e2y24VEoXeeDaILrC+dIak9Qw2AM5MtGFJiA7Y7wHzRCWVYJI6I3EqUHR/fqqu7syU2RLNidSrU1E201Ba9pt3Jhrc2qWK5G/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199015)(4326008)(110136005)(44832011)(83380400001)(8936002)(54906003)(38100700002)(186003)(2906002)(6486002)(5660300002)(2616005)(8676002)(86362001)(41300700001)(53546011)(6506007)(36916002)(316002)(66476007)(478600001)(66946007)(6512007)(66556008)(26005)(36756003)(31686004)(4001150100001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1ZIL1pMdVZIUUc3VFZjMFBpYVdTOXZOcVNTZVZhQkJUOTJuQWQ5RTdKaUg5?=
 =?utf-8?B?Qlh2YUlzTjBkQzRxMEdzWWZJNzBkT2h3M2psVGpBK0hhY2g4TUdXOVRTQWdT?=
 =?utf-8?B?Nmp0NTBLdEo5U3BUVUN6bjNQeElCdzF4dy9ZcjMrU3JidFFXUG9XN1RadnRz?=
 =?utf-8?B?amtsL0N0Sk5MdzJsRzIyOXd5ekVnQ1l3M2VkU3F6VDVoUnZXZ1VWZURCYno4?=
 =?utf-8?B?cXo5WUEySWhqUU1YMHhRTU42ZWxtMkc2dDVWNVNjdFF2Y2RUWWJ0bEVId2hO?=
 =?utf-8?B?MWQ4MjFPc0FzNWZMdjVBL21URWppZ3FxNWJ5TkZjaXpxUWFDZjUyRVN4RWty?=
 =?utf-8?B?Sm9xTyswbEh2SmxxTUxIZzdHZVllM2ErblVNSXp1R2s0MkRKbHFFbks4M25P?=
 =?utf-8?B?Q2FMTVBWcmFsWWFvM25jc2V6ZFlSKzNYa1NSWUtrWFo4NDFKeGpGUXp6VUs0?=
 =?utf-8?B?Q2VUZk1ZOVBTQUoyS2tDVDdjQ3VveE50c01LV1NvcDY0TzVCM1RuVXdxSVlD?=
 =?utf-8?B?WGNQS2hPOVYwV1hRU21lNHpOODVqUEMyeXZ2OUJYajVaNm5Lcm1JaW5MMTAv?=
 =?utf-8?B?UUxoTzdXd2JKWWRROUprVFdtTG1FdUsvR0ZvMmZaQ1YrMmc3dGJLS2svNjRV?=
 =?utf-8?B?L2Z6Y2tHRWJ5a0o2SnVQalBuRTNnbXIrc3JLM2RYeExuRWFLWEV5eGplcE5w?=
 =?utf-8?B?eElTMkg3WHp2NXA3Y1dyVERBTlY1dS9wa3VUYjhuSTFibmQ1QkVmaXlMWlR2?=
 =?utf-8?B?K2szcjhZREJEMmdDa013SU44VnVYMXhvc3BPNk5VWlc5S093Tko1US8wRGEr?=
 =?utf-8?B?THRQRHFZVzZDaHppV1hMbWhUMTBnb0FuYVRFRExYZ25KL3B5WjIxV2hUU05Y?=
 =?utf-8?B?bjc3UlA2b1g1dnZWOHRWMEpKUGYzNVFDeXoyRUZ1V2VjU1h0ZE4vNVRmUzhN?=
 =?utf-8?B?MFBtWll0WnRwTW5ybENtcVNLM1ZhSktYanM4WmRvM2I4UHJqb3ZHZFM4MG05?=
 =?utf-8?B?Q0ZtYXFhOUNXVk1UU0hPZm0wcVRGcU1haGN3T0pwdlZsMEU2ZFBiMjM1SkIw?=
 =?utf-8?B?c2QxdHFJV1lESzFQOGwvRmlDZFdwUENHNVZBQTUzZ244OFFZTE45ZXlYdk4v?=
 =?utf-8?B?SENLQmVqNkR2TTNNM3RBYXV2MzcvaytvSkxycXpsL21rYjNSbmVpeUZ0ckhy?=
 =?utf-8?B?dk1RQm1WZFZoZmhYYzVGc2VtNjBGTlJzcDdCS1hmcy8wNU91SDU0Wkd0Y0xq?=
 =?utf-8?B?MW0vK1RVaTdKY3RWZ01PaHE0cmlpQTFib3VHUG1HZTUxbWNxVkpNMGdodWpP?=
 =?utf-8?B?WmpPamZKNFhIakpTVmkvUGFUWGxaNTFTaU5CS2dLenBRT2JZZkpuZ2diekpo?=
 =?utf-8?B?bjRqYXNieHNndXJjemlhaXRuUE9sS0VuN25EQzBsbjMvK21EV0p6NXQ5MkJ3?=
 =?utf-8?B?aloydzY5NEZmNGJ0TVhUTEFLVW9xVHAyMk5lWSt0TjRIY3Y1dEh3ZHowS0pV?=
 =?utf-8?B?NEgzaFArR0U0V1ppRHpKblgxUW1IcEg2SjlCdTd1Z3JOVlJyVG5ic29WWE0w?=
 =?utf-8?B?ZDhXcWJQbHpNSE5UaEp0c2tRZ1dTeVpOeGNGOExldFEwd1VTOW1yckQzOEMx?=
 =?utf-8?B?UnoyTDRGV0tvUVZUVlNQUEU2aU96cS9XUVJIeUFvczZXU0JVZ2plMy9MVXVQ?=
 =?utf-8?B?UzRObTFCWE1xanFsdEcyRUZ1Tm9CNWZrZ2lRc0x5bVR1WTF4bmVKekdodGVq?=
 =?utf-8?B?eUxLM0ZDalFqaFpjanZGczlLdU43WVJzUDBOdnVrVy9MelRNdk9TN0VWUHI5?=
 =?utf-8?B?a2xEdUZUNFA4aE91YWxJR2hraEtud0FqRGY2UWNFeSt6dzloTjBHNXhJTEZa?=
 =?utf-8?B?ZW5oNHFoeHVKVDVtZDRHakhHOENrZWFFZjlQejhnUTdCay9oS2l0TUE4a0xR?=
 =?utf-8?B?SFpBTjB2KzNDb2ZSMmRRdlkvWDY4WWZLbUkzb3NRYUVrUVlMakxuelA3WkdK?=
 =?utf-8?B?SXh1aGtrT0szUy9qNXhDcVd6blJ0TGZTa05sc21zK1FwTXZyUGNzby9DcmN1?=
 =?utf-8?B?WmJZb0RpR0QrTUs2ZmN1QXVPZ3QvOHJPc2pWdExJVHBWZmFzWTg4YythTkRX?=
 =?utf-8?Q?gIGckL4Unvn7uQTrymLp7VNJl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bb6c43-0ec9-4183-eab1-08dab3a64d74
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 20:53:27.3516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vG2IUi3E7tO0LIuOX0Zx4ckwD1wch5MfQOXcv1ueilITNuQWIopkYqNuoquocBAhKcE7aeLuHAI2pfC/jvhfPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-10-21 09:05, Liang, Prike wrote:
> [Public]
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Friday, October 21, 2022 1:11 PM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
> Subject: Re: [PATCH 1/2] drm/amdkfd: introduce dummy cache info for property asic
>
> Am 2022-10-20 um 21:50 schrieb Liang, Prike:
>> [Public]
>>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Friday, October 21, 2022 12:03 AM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
>> <Yifan1.Zhang@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liu, Aaron
>> <Aaron.Liu@amd.com>
>> Subject: Re: [PATCH 1/2] drm/amdkfd: introduce dummy cache info for
>> property asic
>>
>>
>> Am 2022-10-20 um 05:15 schrieb Prike Liang:
>>> This dummy cache info will enable kfd base function support.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 55 +++++++++++++++++++++++++--
>>>     1 file changed, 52 insertions(+), 3 deletions(-)
>>>
[snip]
>>> @@ -1528,7 +1574,10 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>>>                                 kfd_fill_gpu_cache_info_from_gfx_config(kdev, pcache_info);
>>>                         break;
>>>                 default:
>>> -                     return -EINVAL;
>>> +                     pcache_info = dummy_cache_info;
>>> +                     num_of_cache_types = ARRAY_SIZE(dummy_cache_info);
>>> +                     pr_warn("dummy cache info is used temporarily and real cache info need update later.\n");
>>> +                     break;
>> Could we make this return an error if the amdgpu.exp_hw_support module parameter is not set?
>>
>> Regards,
>>      Felix
>>
>> [Prike] It's fine to protect this dummy info by checking the parameter amdgpu_exp_hw_support, but it may not friendly to end user by adding the parameter and some guys will still report KFD not enabled for this parameter setting problem. The original idea is the end user will not aware the dummy cache info and only alert the warning message to developer.
> I thought the intention was to simplify bring-up but make sure that valid cache info is available by the time a chip goes into production.
> Therefore, normal end users should never need to set the amdgpu_exp_hw_support option. I think you're saying that we would go to production with dummy info. That seems like a bad idea to me.
>
> Regards,
>     Felix
>
> [Prike]  Sorry for the confusion. In fact, this dummy cache info only used before production and meanwhile needn't require any parameter setting for CQE do KFD test. Anyway if you still have concern on this solution I will add the condition of checking amdgpu_exp_hw_support.

The idea to control this with a module parameter was to cause a more 
obvious failure if we don't have correct cache info before going to 
production. Just a warning in the log file is too easy to miss or 
ignore. Of course, if QA gets into the habit of testing with 
amdgpu_exp_hw_support, then this may not solve the problem. You need to 
have at least one test pass without amdgpu_exp_hw_support to catch 
missing cache info.

Regards,
   Felix


