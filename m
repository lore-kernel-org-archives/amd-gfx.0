Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15749C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 15:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681598D95B;
	Mon, 18 Jul 2022 15:29:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21CAA8D943
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 15:29:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gkkc4JCWcqQynVfy0acOWhw2/86BZjWT9MFRJwDskYveLGIOTPM3RTb9KK0F+dvQ3x6jQqKBOvvPN5Mcw3RUIhMcPUJIo5bGcebKgR8dWtZwZg2OsbVt9Ez8Vw2Wo0xc9sVHeDt8AuJSSJIFjsRHTmtSMish9nggZtnkYi9v1Y4UeqAx4oI7fZeEQcP4gf8UrHV1eHd3Pny+BVMQD5LvQYX747Zf1CXSJSvF8IR7YCa5Pjwc0NEGrPUiJEGWFgBvaXYNO84uxl7EZ0DjnmRTJWEXpbR49s8lJy8vpurltPIMF2yt4nvyv5ZHsjhSybH9yGwhWitjBAVdvEU5waATfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzosNr1kfl7jcDLAUgCPWH7FkmO/4zG033upVuoABYs=;
 b=jXe29Lddef7Il24zCoXhHM+hcx4RkV0ZsWg0tlkHG6waxI5f7+VnxzRTGqUY8kWaxb+nvBLiUfVa8TJF2hB1RQ2fa6yTigmhXc0wBBnrU7Bc9KoNUHaz34WW6V4FhS0QjjeGBcz00vSubXMblQwxAnVntP6vmBZAS8THDNiewudwgu/YZuqfS/zEd9gVvYzL8gQdJLcY7sWmcj1t1qN5Ogpf403YS/UmF/Bg4SUkQ/GGLEnVlUGAxVYC4nHTcuoNwA1a/PcGwdyr269ddkh0fuy1kKa3IreCuSGfSOHaetoFen7YzUmFcPnZOJlVuV6Qm302xsVxogud6RWNh+Hhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzosNr1kfl7jcDLAUgCPWH7FkmO/4zG033upVuoABYs=;
 b=JPP45/ehIxMpcNgnBsW5szud6gS+Jh1DSEJOU71mWWSgSn/twCeKBy1GTf6KUxu8vmwM4Yz/ekWRs6zNfMa9vLfLkvUHzn5RlbNWQK7j0XDtERLz3TR1w4529ouEH2GJDjuchG3RfOwMsOWC8gNNmD8jUGg+/kQoLoZB0Dv3v0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Mon, 18 Jul
 2022 15:29:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a%4]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 15:29:32 +0000
Message-ID: <bd342a19-7622-24ba-5072-0ddd7cd7a43d@amd.com>
Date: Mon, 18 Jul 2022 11:29:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix a NULL pointer of fence
Content-Language: en-US
To: Mike Lothian <mike@fireburn.co.uk>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20220707095053.6755-1-xinhui.pan@amd.com>
 <92f468dc-2fad-5135-4aeb-c8ce2a680c69@gmail.com>
 <4b60ece6-afa5-62ca-afa6-bb800cdba982@amd.com>
 <DM4PR12MB5165724D36AB92CF9D40728487829@DM4PR12MB5165.namprd12.prod.outlook.com>
 <1766b5b0-05f1-b88e-3147-c5ac1749f0d1@gmail.com>
 <CAHbf0-FKQjkhAsQh=CKTBz755ROrnJN0p05Yq=5mJ+L9xZow4Q@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CAHbf0-FKQjkhAsQh=CKTBz755ROrnJN0p05Yq=5mJ+L9xZow4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:610:20::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0525070a-b59c-46a4-e361-08da68d24fb8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3189:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UNAlnDvrSnhi5tmMZ5cZfbQ5gx6T7I9Y0wvK05aBkHXfLaP75eAtn9Pg2TXTyxGDtrrn/Nc7m/EU0BgVGhV0WUcpC+6CKAZfIHCk592XWe6csTiGmSNhxSHLInpyWFhN8VDpXdUK2f0U3a463z0EkQQs/coxnKzYvKgDi/8uYZbtfPKV56hW0YlycTNfq245aV2gAPpabnIASAs4GhKTc28H7KND/+oMf6Ev6D/trzf0tLNGwyWJ8Wiz8crZae0MsvwcZaalaeOgwneXQDpamTJ/vYlFurCNM5OwzXf0aVMDvXeCF9uU9Ecng57P7OR2M4HUdllOIrXfsI4PW9m4YvhXpt/CQ9KvpYHqK/ooL5v+GbU1etau5kKoHtWcipm+oAShxTCyMeBm9gWXGC/2USNS3dwyR45l0JnhLBavaLzhTpBat563QmAMvrJoXHbKOpf2VetFUK6/15taddl1i1/1Nc0MYtkBuIEiTYHOOdmlpNOGQpNewfK4cH49NANM6tHdJ/T5+D+g/voWCwvpI/K1F6gytGYRWGJuZVdqnCWETtYhwbHFMHSGtKH7o3jpgjki5NBiNeR9sDcwnyFKkL/IoEvYjmUmSsQkrUXIsv/FBYTYR9S32fnL2duPXT8VbUSf/V56A8YWknArC2xGcSiPB9tz+Nx09y6sLaGng1M3zu1xWfH4YvUJ4iwQ1BkpW4MFY2WBgfho/Z7OsktMT7Ng8xt6EI/9+DxBMpCFnwXmUAduW3EC2MV8DZlov3HQmshxa0KueZRdPc2ELWVM3H2qa9vHoXmR36/TOPiaKL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(8676002)(4326008)(66476007)(66574015)(38100700002)(5660300002)(66556008)(66946007)(44832011)(31696002)(2616005)(86362001)(83380400001)(478600001)(36916002)(53546011)(8936002)(186003)(966005)(6486002)(6506007)(54906003)(6512007)(110136005)(316002)(41300700001)(26005)(31686004)(36756003)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWJiVjNoZTBDSEhsOWhjUDRVVGVROThWV1liZ3VocHQ3ckZQQjRRZ3FOUUox?=
 =?utf-8?B?ZVdzaFZ6YzkzbkZNYW5xVGFZRm51MHBRQTd1SC9WTDA5OEpNL1k1b3pzUFQ5?=
 =?utf-8?B?ZkZraldSdEFLamxEbFNSUFBKWnJFSmZ0QWlleWIvdE8xVjlBL2ZrUStoY0oz?=
 =?utf-8?B?QmxEWGZ0S0w0YW4xSXN6dUdUbk55eUZPeExCWkIvREkwK2NNVDVndHVqQmRm?=
 =?utf-8?B?TmhOQW0wNjhBV3ozM2pnQ2tyeDluamVUSzNuT21CTFZTa3hWOGJyWjhudk4z?=
 =?utf-8?B?Y20wTzZJeFVXVEJSWGdWSmg5ejFIWmE0UVNtZ2ZjajNvYXA5WUJOcVRyVmRu?=
 =?utf-8?B?TVpXelJBcnBML2VpZGVqeDhBWldoZVh2QkRHNlYxTU5nT3laK0c5VnBIREZv?=
 =?utf-8?B?T29sVmExTTNMTXFFSmErZFFlSlA1SHp4RDkxeDdTa3JoOUMvQU5CUkRqcEJu?=
 =?utf-8?B?VUk1ZG00MG9CSGhUa3lMalk2UnM3TXdweUhHNjRUZzBrRUVrMGFtazVsZ1p1?=
 =?utf-8?B?RVB6cVV5ZGNRSGI5THNZbGk3TkIya1lJdVRMWkFwWktWSS96V2VadlpxU0tx?=
 =?utf-8?B?NkcxSU5UNFhQZWFpRHBlb0xmWWpXMGh0RlVFOW5BV2RtbkIydHdLZG9pNlJr?=
 =?utf-8?B?cndMZ3kzMWw3ZE51Mm04VC9PU0EwREFISXoydXhtNWpNbGNLVmpOZm04U3RI?=
 =?utf-8?B?NDhON3V1cE9YeEZvMVJ3b2ZTYUVCRmJVc3M4TEtqYjBzUm1vQW13VEViK2l1?=
 =?utf-8?B?eXVlSXRBbTBOOHZyYmlqamxQT2N4TFFyTHZ5OU5UaE5kQjhTQmxXdkw1czIx?=
 =?utf-8?B?MWpBUnFiRldod1VoRkEyUFU3OVBNZTJuMW5ETlpJbFVtdGRoaTN5cGlCWGhn?=
 =?utf-8?B?QmhVQ0V3bmgrVnhtUGNDTVBjdk1FYTUzWUxLZlJUU09zcGxtR3pEN0hYS1RN?=
 =?utf-8?B?eUNxNWRka3FQaDdqV1doZEd4em43a2tYa3BGVGR3Qy9IcUl4YWFRVEJMZDgw?=
 =?utf-8?B?UUZuZTVhZWhxd05vYnpiSHJjK0hpOFNBbTJZQUJBUzFOakxqcHpITVdpdzlz?=
 =?utf-8?B?Z3pNdHY1VHZRTm5VWjEzaStIYkFMZHBsckp6ODNjTmpmbzR5VEZ3VkU2dlVI?=
 =?utf-8?B?WEZETnhvLzdHSDgvbUVQMDluZDN6T29xSFBQM01iMFN3NGp2djZmL044L2Zn?=
 =?utf-8?B?RmFPTGk2MjExVVN4UFp4MW9Ddm1OUUFQVGRUZjFZQVhDeFc5a21OM0F6TmxW?=
 =?utf-8?B?VG1lS2JXK3VPdndZTzdjNGN3TXZFTVFSQmRHNkRjT3A2OUpEa2FmMkRxN2Zs?=
 =?utf-8?B?bFUrU2tuQ0pPRy9YMUttYys0ck96WVNGb0l3L1RWVU4vUG1sUXkxbU12NVBp?=
 =?utf-8?B?UkxJKytUZEk3Q0ZHS2ZTbE1MaUNBU2hkTWozdlFlb2V1K1FkR2xHUW5KRCs1?=
 =?utf-8?B?VXJSQVR5UzgrMEtrbURFbHNPMFRoNmUzNm5DK2Y4ZlZTMVZiWnArVUpuTG85?=
 =?utf-8?B?d3U5VDFueGJ4UlMvbWZDcjJzSHJhWHZFRVJGZEdvWjZ1MHZxMjJHdzRjRVdH?=
 =?utf-8?B?K2M3WlpwWXI2MGhRTWprWWVKdGg1d202TGx6V2RLTE1PWVlsOW93cktZWE1Z?=
 =?utf-8?B?cFRlejdpcVNvMjlhOGsreVRCRU5iNk54MDNNaTJNSTFyTk53SkFOMFBweXZh?=
 =?utf-8?B?WW1EWnMxVlZ4Tyt4VWxPOWN0eWxSQXhsbkZKWTB3ZEpGQTRoYzRPbkxpQ1lX?=
 =?utf-8?B?RFVoZERzUUExNTNIeWdHMnVxbUJRNXdYVWJGQlpRSmc5Z1ljVHRKRWt6MTVF?=
 =?utf-8?B?aUZucFFjekFXVGpVTGpnR29sRktmcWtZRzVjRTFLcHp6NThrQ2NRRW1OVWtk?=
 =?utf-8?B?aTBnTVZ4cnkxd3U1TEE4RzJjYzdGL3hEVjJFUkNxQkJNOWFINlp0WUo2T3hS?=
 =?utf-8?B?M2tuRzFFT1hVdHM0VmRyZ1kyWmsrMnRTUGNFdUZlNDlnUU8wYUlaZkp1T2Rl?=
 =?utf-8?B?akRCNnVWd0V0V3VKZnFrOC9Vd0p5WVJmRkVHWVVQdVZHUEl3MVpEdjZ6eHRB?=
 =?utf-8?B?K0grNlJrVVVJQkl6N1l0dUtQTmh5aS9MUlZiN3c0NmJTVGtKVEw2dGtyU2tD?=
 =?utf-8?Q?IYfj6/fCHZRrg7638iPNbRDxP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0525070a-b59c-46a4-e361-08da68d24fb8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 15:29:31.9409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgTp3dJjBzQheQ2D2l/Iw4lNfUQPw0bsTjUttaQ8kN5SaVYCFbDw5gpCCQO/zyIoZ7PY5/2Y/Nu7KJkaqkFLkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3189
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Xinhui submitted this patch instead, which should address the same 
issue: "drm/amdgpu: Remove one duplicated ef removal"

Alex, can you pick up that patch for drm-fixes for 5.19, if it's not too 
late?

Thanks,
   Felix


On 2022-07-18 10:58, Mike Lothian wrote:
> Is this likely to land before 5.19 final? It's been nearly 2 weeks
> since I said if fixed an issue I was seeing
> https://gitlab.freedesktop.org/drm/amd/-/issues/2074
>
> On Fri, 8 Jul 2022 at 10:05, Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Hi guys,
>>
>> well the practice to remove all fences by adding a NULL exclusive fence
>> was pretty much illegal in the first place because this also removes
>> kernel internal fences which can lead to freeing up memory which is
>> still accessed.
>>
>> I've just didn't noticed that this was used by the KFD code as well
>> otherwise I would have pushed to clean that up much earlier.
>>
>> Regards,
>> Christian.
>>
>> Am 08.07.22 um 03:08 schrieb Pan, Xinhui:
>>> [AMD Official Use Only - General]
>>>
>>> Felix,
>>> Shared fences depend on exclusive fence, so add a new exclusive fence, say NULL would also remove all shared fences. That works before 5.18 . 😉
>>>   From 5.18, adding a new exclusive fence(the write usage fence) did not remove any shared fences(the read usage fence). So that is broken.
>>>
>>> And I also try the debug_evictions parameter. No unexpected eviction shows anyway.
>>> I did a quick check and found amdgpu implement BO release notify and it will remove kfd ef on pt/pd BO. So we don’t need this duplicated ef removal. The interesting thing is that is done by patch f4a3c42b5c52("drm/amdgpu: Remove kfd eviction fence before release bo (v2)") which is from me 😉 I totally forgot it.
>>>
>>> So I would make a new patch to remove this duplicated ef removal.
>>>
>>> -----Original Message-----
>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>> Sent: Thursday, July 7, 2022 11:47 PM
>>> To: Christian König <ckoenig.leichtzumerken@gmail.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: Fix a NULL pointer of fence
>>>
>>> Am 2022-07-07 um 05:54 schrieb Christian König:
>>>> Am 07.07.22 um 11:50 schrieb xinhui pan:
>>>>> Fence is accessed by dma_resv_add_fence() now.
>>>>> Use amdgpu_amdkfd_remove_eviction_fence instead.
>>>>>
>>>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index 0036c9e405af..1e25c400ce4f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -1558,10 +1558,10 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct
>>>>> amdgpu_device *adev,
>>>>>           if (!process_info)
>>>>>             return;
>>>>> -
>>>>>         /* Release eviction fence from PD */
>>>>>         amdgpu_bo_reserve(pd, false);
>>>>> -    amdgpu_bo_fence(pd, NULL, false);
>>>>> +    amdgpu_amdkfd_remove_eviction_fence(pd,
>>>>> +                    process_info->eviction_fence);
>>>> Good catch as well, but Felix needs to take a look at this.
>>> This is weird. We used amdgpu_bo_fence(pd, NULL, false) here, which would have removed an exclusive fence. But as far as I can tell we added the fence as a shared fence in init_kfd_vm and amdgpu_amdkfd_gpuvm_restore_process_bos. So this probably never worked as intended.
>>>
>>> You could try if this is really needed. Just remove the eviction fence removal. Then enable eviction debugging with
>>>
>>>        echo Y > /sys/module/amdgpu/parameters/debug_evictions
>>>
>>> Run some simple tests and check the kernel log to see if process termination is causing any unexpected evictions.
>>>
>>> Regards,
>>>      Felix
>>>
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>         amdgpu_bo_unreserve(pd);
>>>>>           /* Update process info */
