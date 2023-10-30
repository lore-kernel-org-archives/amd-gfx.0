Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15FCC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 17:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F4DD10E357;
	Mon, 30 Oct 2023 17:56:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF7010E356
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 17:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQd5jNoju1+RLAdS7g7zk08LuGW3lCIXyYeNrqNK6PL53TkdZCdHqjR1biXllwOL5ZwlGikXJ1LX7pBp58lRMX3m8pSxipiurq4wIPFUVTEZqEsGDS4OVo90GWRH1GtV38gaMo3kyZYrwgOSwHjZldf6LHd14IbQc+eNgIQw7vZ6fK8aeHPP7kmFmNCwYQEDazo5j2GQAsI8rHHAzR8zawMjjE43j3vxXGoVW3dRb+WA0/w8GczmxxTd17a3lOFqi9Hho3E6Y15BhAbm09rpDI2QahUH+60qDKlIrTpSGEm9LUFmdIXXmI1C9BJAJmH1B2zAxNGCIoOMZ2opx1+5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMNd/4dgtPL2kn4p5aUV47eUHxPxsyVea4PzUmojtSQ=;
 b=Mcm5NAznlu/9bSUZ4DgmkKzToLGulqv0owq/+mbrjhxAQvWT7BlySJjLdMmF1XTM2JUv9jKV/Ek02bQiBGh0tV1mAz1/Ohyws26qL0gKavL0o70LEWleOh5Bad7AIYKja8CFKzNPWwut17seCkWYujot7M15EAvw0IEfbcxx0vcszqWCv58VK8NU80h3+MPL3Y02XevxJHBgH2RNiHtMQvGcuPdjIGJSK0JhQ9c/+RYnSCTnfBncYlIsoE2ZhFyzx7adY1C8cKN7OQoaL0WQs1+q9AM+9TgLF7Crx1Sy1tOv2Cnb6G2/51CjwPAueTVzYZz36IJIEeL3Xc3Wuni4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMNd/4dgtPL2kn4p5aUV47eUHxPxsyVea4PzUmojtSQ=;
 b=i32wjKoDtpBb8vnKCe72UvAQoiD6IficuXL/xDlWO23ffWMelvE80cWm/kM/vCo2s7QZ31dskFiaRPCcHZQW/dcrBXnyIRKF2T9CrK4HHOesyAow+EDCkArjXqe6J2yF52s+hjmk3BynK8iwKp8Cx9z39MLG/fvnrIwzY00Rsi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4860.namprd12.prod.outlook.com (2603:10b6:610:6c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 17:56:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31%4]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 17:56:20 +0000
Message-ID: <b6f9450c-c12e-4c2b-988a-bbb79c2ce6aa@amd.com>
Date: Mon, 30 Oct 2023 13:56:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amdkfd: Run restore_workers on freezable WQs
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20231027223911.2640763-1-Felix.Kuehling@amd.com>
 <8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com>
 <da7010c1-6b11-41f6-986d-796539073451@amd.com>
 <39374cfe-9c98-46bc-8b3d-196e50a65839@gmail.com>
 <f1d1b3e1-fac3-49a2-97f8-7cf9ede8c064@amd.com>
 <2e1e1fd3-ae15-4faa-98a6-a71ba3d8fafe@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <2e1e1fd3-ae15-4faa-98a6-a71ba3d8fafe@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fea2da-66cc-4636-2c2e-08dbd97185b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8nj6p9RkJ0mXxNiLTxsx/XmXuiKqd23bRGynwRr8D/BJVxhltHroizejioKmemHTqG4+YmL+LXDn8tG495fvGeO7DGP4eNQReRP0ltfTAk9HDTgaItekwSbGv9zGmOm9+KCKSRuv6/KOk9lXBi1sJSm/+Px3IuuC/n5Sb5raGTkt/oFvgkFPGqwN/z3YjJapJHAlS0IN0CdjcshYMoGaf+lSaaTJHHITH4fAVtjErAu3Nl1GtNuW2pdHlCh2tK4V3FM3zA4xJEamORDwae5xHdp5Y7UdWVzwLwQvEBCwU47aIuf9yJ+zF1PJTcxd+VLuZFwkBFFQ0hLgJX7boqtDqlUyExDnUrQHX2qj968rspwSXTL1aOhIyOJko7+quDTHZAVjYKmZE5V03wXYL5GgswB8FS5ZSYYechgtEafrRLZm94/mtk3wzbQwH8pWcX3Ab57aWF23Woc7ni0MWSdBvUdnQuHgnfvjtcs9ovj9xanS/48zB4UamKQkJkD4/jQ1NVi1mU5C20xc88gCahl7w/gGYYGIf+yY8S9Olw5P+yn/an5/IbcTrjVJm3Bv2WWmprBm7IcIRKAL0vA0xszDJxuxvaVDFDNZK6KVM6Hn/p2eZROdSiStHwmu86yl98zlz4l3+8XBsCPy11XQc6HlrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(83380400001)(26005)(6506007)(31686004)(6512007)(6666004)(2616005)(66574015)(31696002)(36756003)(53546011)(86362001)(8936002)(66556008)(66946007)(66476007)(44832011)(110136005)(4326008)(8676002)(6486002)(41300700001)(5660300002)(2906002)(4001150100001)(316002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU9aQUdrYWo3bXBjSlZVNjBlSVROdkZZRnFaakYvZ01kL29mcjV4T0lVbGhF?=
 =?utf-8?B?RStqMGZzTWNvNDhaL25NTnh3R3Mrc1RyY3lKYVVpNEVoSU9KT3JOWFRLeEZu?=
 =?utf-8?B?TnRyY3dUSEc2VGIrck1vV2M0azBKK1FqbzRndy9uWGZFRjBRQldMRlNyZDBk?=
 =?utf-8?B?MU5YalBpbmhWeW1sS0M2My9TRXpWVnM1VTJUdWp4N2hyL0lJd25jQ2QyRm9M?=
 =?utf-8?B?VFphUDB3Vmxqck4wdk9CQkxDL3BEYUxOVUQvck1qYkFZaUkzZUhCcFR3WGRF?=
 =?utf-8?B?REI0dXBSMWZ5Z1g2dlljL1JSVEljcFByckV2WFJIbWo5QW5hSHZvb250TVN4?=
 =?utf-8?B?ZVdJWlZYK0RvaFdSb3BIdWRWWnhHQVdGKzREaHQvbUJ3Y3ZOQ1gzOHhCM1gz?=
 =?utf-8?B?ZmpFMEUvQ3l2L0sva1J0RVhNcXY1VngyQ0ZjUXJxNmtoTlFBL1JQeXhYR2dU?=
 =?utf-8?B?Wnc2NnVpaUxDSFJSRzdOTTVYcVhxYXM1Zkg4Q3lUbXBTUkwzdHdNampmcGkv?=
 =?utf-8?B?MzErd2sxK3NXUWtVd2dIQURxaWlMWE5PVjZkb0hIc09WVG1EVXltV3Z2Vm8z?=
 =?utf-8?B?UTV1ZEpDblY0N05CUDE0cXFIa2dkaktVSjBjc0thQkp4bHExamdpbVZCWnJY?=
 =?utf-8?B?eGJJTno5WVE2USthdjlXYlJBSmJ3VkZnK2lXN1pQK3ViWkIxV29VLzBBdkMw?=
 =?utf-8?B?czdVS1BHSGZ5K1YyS015a1h4dzYrclk5eUpJRXVIdnEwZmN0a1BBNG9jdFRG?=
 =?utf-8?B?Z080SFRCeHA4UVAwNVoyUmMrUld2NnlCNnhvMVlnRE1YOUpTWU16SjVxN29Q?=
 =?utf-8?B?ODU3TDZ5bDhkRDNMZzdDbENWc2NGZ1phaHZNaEVyMlREdEZCUEFBZGJEYnJY?=
 =?utf-8?B?bWdhMm9uZGNzNWRQV1V1MGMxQkdLL1dsYzBrcTdidzFabFFGK3V0cUdlSkYr?=
 =?utf-8?B?bU5VTHNralIyNTRjQWJNLzRXQnZHams3WkJ3T25NRjBRTTZqWHk1eC9ad04x?=
 =?utf-8?B?a2RtMnhoemVvS09XOEljYkhLTGJLZ0tYaUFncDFaTFJMSWwvT0dMWlFSaEpt?=
 =?utf-8?B?UXlBUS9qWWIyTmdScm50QXc1Unh1RnBhdXR4NEk0RExlWXI1SmtBZWdPZE9T?=
 =?utf-8?B?TjhsYUloK2NOdnJISmJZcGsrSjJZN2ZGMC9OT0pHY1JZMGRlcGpRcGJJN3pz?=
 =?utf-8?B?VEgrRHFPbkFzYkhwQkp4U3ZlZHQyKy84Z0YxS0xYOXB1MU5pWWltV1FlSDJm?=
 =?utf-8?B?Q3JHQzJWcDJXZmFpUEl6cmlPYjN6dW53NEdWNnc2M3JVOXkybTQwTXVmNW9j?=
 =?utf-8?B?aHd1eDAxQ2JMU2VCMTF3b3BJVTNMaHFlQnlqRVN2TFdKVVFzenQ0RHF3VEMr?=
 =?utf-8?B?TVhtc2R4L3llSmtJdEl5K1MwT1daQnNYaFRwVkM5UVl2Y0UxamQ2QjdaWHFU?=
 =?utf-8?B?SVl6TndLbHFhcm5jaEErYjRhYkZvWldSNWJGeXR3bjNGVzVXK2RtUTRIQ2hk?=
 =?utf-8?B?Y0Fsakl5V3ozT08zcllCa1pSQTNTSXN3OHhsY2pOU0lRNjZSRmFqTW0zWE9w?=
 =?utf-8?B?QVhQcmNMOHY2Q0t2aVZWL25kZDNjUVpDYmRQNVE1c1FlcjdjS1RqdkdWeWVJ?=
 =?utf-8?B?RlRZSUZBdGlBUWxBcXNXWjhtbGZQTS95SVVZK2s3dC9kQzhEMnJ3aDI4cHBl?=
 =?utf-8?B?aGhVR1hVbTRaTElhYXlsNm9OWExJa1ppTW1QUVdyR1lOYjRBdkpzUUY4NEpR?=
 =?utf-8?B?UEpRWHpqQ3lCQ3RvdWE5Z0VXczk3em5jZGlpSXFOSDFkUWY2blA1K3VpSGhu?=
 =?utf-8?B?ZlJmVUVLdWlhZmR6d281OXZDUHpIK2M2U2c0d3JhbTA1WGJualhTRCt2SWsv?=
 =?utf-8?B?WlU0RDg2Vk9Ba2VUYzlBTlJXUjdGY1dPa284b254L2RCOFNBQ1hyTTZ3M2tS?=
 =?utf-8?B?NFB0bElvb2FkMkwyaUthNCt0amx3aTdpMFJRMTAzT0trWS9qdUpIZzlkRi9H?=
 =?utf-8?B?b1VhRS8rSTFzeVR3M0czaVJ6RkhmaUsxQmRZdlVTVXc5UGVkZEFnVlVBYnkx?=
 =?utf-8?B?MmJrSVRwSkkzSWt5cHp5VGhDZzF2akhsbU9lOUdCUFNoTVNsSEY3anRydzgz?=
 =?utf-8?Q?GNFXS+laUfpGZylp310p1/Li1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fea2da-66cc-4636-2c2e-08dbd97185b2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 17:56:20.1862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ik+HV9ATxxgbxjCKEsYFlxhol76oeOYIo1T+vLby6oZ66T2R1pJwuP+W/9kfc56Nj1aphO71tziFyqqxXvvmgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4860
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
Cc: emily.deng@amd.com, xinhui.pan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-30 13:48, Christian König wrote:
>
>
> Am 30.10.23 um 18:38 schrieb Felix Kuehling:
>> On 2023-10-30 12:16, Christian König wrote:
>>>>>> @@ -1904,6 +1906,19 @@ kfd_process_gpuid_from_node(struct 
>>>>>> kfd_process *p, struct kfd_node *node,
>>>>>>       return -EINVAL;
>>>>>>   }
>>>>>>   +static void signal_eviction_fence(struct kfd_process *p)
>>>>>> +{
>>>>>> +    spin_lock(&p->ef_lock);
>>>>>> +    if (!p->ef)
>>>>>> +        goto unlock_out;
>>>>>> +    dma_fence_signal(p->ef);
>>>>>
>>>>> This needs to grab the internal lock of the eviction fence, I'm 
>>>>> not sure that has correct ordering with the newly added ef_lock.
>>>>
>>>> Hmm, the only thing we could get a circular lock dependency would 
>>>> be, if we took the p->ef_lock in a fence callback. I don't think 
>>>> that ever happens, because even the eviction work runs on a worker 
>>>> thread (exactly to avoid such lock dependency issues).
>>>>
>>>> Anyway, I could try to move the fence_signal out of the critical 
>>>> section. The lock is only there to ensure that exactly one process 
>>>> signals and frees the fence.
>>>>
>>>
>>> So basically either the eviction worker or the GPU reset could 
>>> signal this fence.
>>>
>>> In that case I think it would be simpler to grab the reset lock in 
>>> the eviction worker to protect against a concurrent reset.
>>
>> Which reset lock? adev->reset_cntl->reset_lock? I only see that lock 
>> taken in aldebaran_mode2_perform_reset. I don't understand why this 
>> is in ASIC-specific code. But even so, it's only taken during the 
>> actual reset (in aldebaran_mode2_perform_reset). I don't think it 
>> covers the pre-reset code path that signals the eviction fence.
>
> No, what I mean is adev->reset_domain->sem. It's hold in write lock 
> during the reset and you can grab the read side if you need to delay a 
> reset.
>
> But thinking about that a bit more, you actually don't need any of 
> this. Something like this here should do fine:
>
> tmp = dma_fence_get_rcu_safe(&p->ef);
> dma_fence_signal(tmp);
> dma_fence_put(tmp);

dma_fence_get_rcu_safe gets a new reference that dma_fence_put drops. It 
doesn't drop the original reference in p->ef.

I need a way to ensure that exactly one thread frees the original 
reference in p->ef. Even with RCU, concurrent writers still need a lock 
or a mutex. So I don't think I can avoid using another lock here because 
I have potentially two concurrent writers.

Regards,
   Felix


>
> dma_fences are always RCU protected and can be signaled from multiple 
> sources by design.
>
> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards,
>>> Christian.
>
