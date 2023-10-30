Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A189EC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 18:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BB0110E358;
	Mon, 30 Oct 2023 18:00:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5369D10E358
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 18:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0r3PmG6Ad/o3nTUlzZ7VDAWsI7cgI6j56ZcaeVo7hO0aN5t1mN1wxKb3A0xBSoCLlhXbWKOez5in13k1zVPIIv5gs9A9lgC6KFAvs6rybY1LhI6AgN3S8j2wH+Q+9OlkvCjM4KCVDltZrxWsjOzTdg+QuyKxx//b/TBjKZbQFa0gU1FIimtXtAmBadf+FDoUDm7xirN2oIUlIOTlIyEafIW/BxyX0kPYfYPvFFIdiIjt6iSJdmo4u0Es1jf8/TQjSt0cNZmuCnUEG6cqfBjY9ozS/wsnqRwMJFMBFcesMQsYK0k32hIOeXnfucjIMCvWi8d/bJPkNbdiGQeWe6krQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1ctWRRviuJBHwnlxBFfLMFbqb07VvvqZmjmMzKWuiQ=;
 b=GBUW/+tPhTgNKvN6/U2D7vLbBw2bjoO9uigjyvHH9UDobzcEwsS+gPafQ2rxSuZidSZ+25bwJxq46GU6MIltYnT5svPOJJXIWkt6Q5YVpfCDteCYfn4oWF3U6GS+3xYbb+shw75Pu+r0TAM3OpdnPJiC8actJc+C3lK67ImMFVjm+VSHVuc248rk/LLONAkmBItm//9HmoHkX2oJ5qqA7oRCkbZT2aIBa7Ffmxd15b++DWFsbBG//khQzyS5/UxmdAdgxiBeTqXMoDa4hnS7t9GONgc2Yd3phsWxv7g9BuwzsoLYnLlyQuSQZrwZ6omQbQUxD6bIj5mjFaREJsRHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1ctWRRviuJBHwnlxBFfLMFbqb07VvvqZmjmMzKWuiQ=;
 b=DO04J3W/54h+t5Nosrp1DDw01FHjUW6hCFFvItau7BBPCVNuPc5XXgFW7a/26jcyKrUt7WrjPgoPU1AmMhZ3Pqj9/fjgoyYHhWLQGVOfGtH4k3OXkU7nEria4f/c3u/Gz2tGuSn41BTFJlDCl9vGcVPvSZ/QzNqhZY9VlrV+uWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 18:00:54 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%6]) with mapi id 15.20.6933.029; Mon, 30 Oct 2023
 18:00:53 +0000
Message-ID: <6129c413-73c7-4ae7-91d6-9311cbd21eb9@amd.com>
Date: Mon, 30 Oct 2023 19:00:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amdkfd: Run restore_workers on freezable WQs
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20231027223911.2640763-1-Felix.Kuehling@amd.com>
 <8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com>
 <da7010c1-6b11-41f6-986d-796539073451@amd.com>
 <39374cfe-9c98-46bc-8b3d-196e50a65839@gmail.com>
 <f1d1b3e1-fac3-49a2-97f8-7cf9ede8c064@amd.com>
 <2e1e1fd3-ae15-4faa-98a6-a71ba3d8fafe@amd.com>
 <b6f9450c-c12e-4c2b-988a-bbb79c2ce6aa@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b6f9450c-c12e-4c2b-988a-bbb79c2ce6aa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 01abb166-c4f4-45b4-73a0-08dbd9722881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWSMpmr0jGbN4eG1lnVfVwoEVoE7wZQLRvxTrnMf+vEpDzMPZboYG/ULWp8lt8imw0fu0hL/LqOBfFaV/vqD+l+TY/zWYRQR9JmSTvC1MY6kec1L2mKKPSuQ23RbqignTXyR0Kpowta3P9DtLb7TclHRdEG1/QbI3ThCCyoTHzr+Z7GgNvdRlGe5wQldnc3wYf+1YgAbtfFZ/NQ93Hz67J7AjruDVkxamK8wZvARex+Kc3skftxeZF0BWRC6lx+tZkpDszYAGVWosZV8i+Hkt98PwI/Mkb1777WOf0GCnxWcMFMXX0t8Kt9s1pcQQk46OPoy38rbaP6WgzdksJcxWMSOhryE/OYrNPEgCLxQXk75aPLuep03BMH0qC3T27in6G9YpPOcxH2LdIHUHqmOAAcQ09mFcE0+qcoTnYoWVtumrmrMnGPXa0owZvCsjRUEfICecUdI4hgQIx/jzFAcXlK/Q3pZq1WpnaBv+BD4JyyuKDpLyXAH2kipCOMl6pH/puq97OAO5YVuN+X2N5c1dGqcSWcBdDX4K1SatGWge/r7CGtXxkHTvYDJXXYwJ+HnYoMGEx45YL+SSz4JDZk/ybcYtXfh6cSxC+S5V60FiiDvljTyo6k123HXRGoDeuQ7xeZ3h4ncodKGDPEjTaVCqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(31686004)(6512007)(26005)(38100700002)(36756003)(86362001)(31696002)(4001150100001)(83380400001)(2906002)(478600001)(6506007)(66574015)(53546011)(6666004)(66476007)(8936002)(8676002)(6486002)(2616005)(316002)(4326008)(41300700001)(66946007)(5660300002)(110136005)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW1EVE01RWtPK1NSRStTSWhoSjZqZ1VaUzhpQjNSenFWVkNRK0N5WGdnSDcr?=
 =?utf-8?B?NHRVREROVmtjejNrZ3ozZDdEMTZ3dUtWUExrTytFTklaaHZ4REtTRVhOMzNQ?=
 =?utf-8?B?ODFEd1kycG5oQlV2V3A1RHF5UTQrZ2Ztd2l4UzN2bEZSUjI3alV5ZTZRR1dP?=
 =?utf-8?B?aVh2amdOOVI5elhkTjluOEE4QUpUUnRWd0ZKQmdTZVVLL3o5anRMckJ6OVJE?=
 =?utf-8?B?RGxaMWl6djVtaFFiRC9UcGxoTlU2OXArVlRlY3pNcFZpaVVSOHZJK2owZ3Jt?=
 =?utf-8?B?eVMrT3J0SmwyZVo5TXdmclJWNW1reFZ2cXJ4eS9RQjNJNTU0Y0k4c2ZwdStp?=
 =?utf-8?B?TjJvZWNxTHhqTHJ0WDlUTGhZTjBHODVMZ2JDY2NTZmttUXZIN29OeEtEbjNW?=
 =?utf-8?B?cDV4c0JtMG8xR3dJYm04UWdyNmhkcTExZis1UzhBTW1oRHo0cFF6Qm9vUlUw?=
 =?utf-8?B?SS9ESWRIQlZHbDhxRUQ5cWtEcmZydDRaMURRQ2I3djhYczlyamJwdit2OHAv?=
 =?utf-8?B?K1dnVTJEY2xMeU1WS2o3ZlhIRWlWOEJ1TlZBYlFMczJUMVB5UTMwYjYrS3I3?=
 =?utf-8?B?NDFaR0JKdHAyQ0JENTVvY2xFdFU4aUR3Vm10c1dUdkJQM1I5U29zUmhYNmZM?=
 =?utf-8?B?YVJHaklLSlBJR0hUT0pQYUtCZmNPTTUvdUpHMnRSZ05paDEwZWRuWUtRK1pj?=
 =?utf-8?B?M3lWRDJ1VDFqSHEwa3l5UkFvS3VUTkx1MEY5WEtiaWFkNVFhNHZiWkFYTDZh?=
 =?utf-8?B?Q2pZMkpQTWFJQktqZ09CTkt2VisrSVhZVWxBUGxTRGl6L1hBOVBxWnFFMVps?=
 =?utf-8?B?OTZVRHQ4TUltTzYzaFJJZ1lVTmRJL0x2MU54UTM4SW9ta2FYVkVYZ2JjUFQr?=
 =?utf-8?B?OWFacVhqZk1VVkczV2hGS0huSUEyUFh3QStOUWdwMERkKzdnMWhTUHRvZ2ox?=
 =?utf-8?B?d1g5dzU0ay9oOGh5RVVtbTd4bmNvdTBYVUx5UmJmeWc4Yy9ZdThQajZsQU9h?=
 =?utf-8?B?N0ROdGptRHNDZ3lrZUhiVXYwS2htTnd0Q3NsdnZaNnpXRFJmdTlPUENIQU9j?=
 =?utf-8?B?UVI3a1NESEJkRWJkNklzSEk4VHJLN3Rtb015dDIwSTNkUGNSdlZMMEp5UHgz?=
 =?utf-8?B?a0NZWGhqVFFEczNxaUdSRm1nOVBQY2lqK2E1K3RvWVVKMk5BSElJdnV0YU1N?=
 =?utf-8?B?Qm8zcHlCajE3MEpyUXlnTXdWOTFUdzZ2TElSZmNHMHhJNDdaMkp3am15MDVY?=
 =?utf-8?B?elY1Q0VSM3BmOWNPalJKWXJYWUJIanNKcU5YWFB3UHA5SHFnQ2RhTElCcyt1?=
 =?utf-8?B?QlNYd2E5TjQxWXI1S3dmcVU1Y0tOUU1HK2ZhMGd1S0pUM2FhSmFuK0QreGlI?=
 =?utf-8?B?ZDVrc2xwMTZ4RmtVNEdHbFd4OFdoZjI3WVV5amlrNXdyS2lvcFFoUXhSWE80?=
 =?utf-8?B?WnJyWlpZUW41eGZKb3VVNUJEZEFiVjVndnljODZaM1hiVU5pY2xBdHNTMElO?=
 =?utf-8?B?dWpOSDFmT0JpZkFJeUZNNElIQkNJVW9NQVBxZ0pFOFcxS3ZWTnE3cGxscFow?=
 =?utf-8?B?MCtYazd3dmRWbGFZcGY4ZTdPanlrQXJuakdybDhWSDJNQlI4dG1PaXhsSFha?=
 =?utf-8?B?U1RMclZ6cXRGZ0pKSG5JQzdWMHhrR2pUem1sWjdqWnByYVJBMWx5cm9TLzhh?=
 =?utf-8?B?NzFFbFpiaXhnZVBtWkJqV2htbmF0a1ltUCtYa3RnclAvSHdUNEdmZ3Y0U3Jo?=
 =?utf-8?B?ekErV1NiRXl2NmpRSzZOdG5oamNFZUNLTkhnRkQ1eEM4TWtpSVVIZFNOVERw?=
 =?utf-8?B?MFZwZnlZR2tMc1U3d3RsN2cyRTRLTUNwb3NNWnIrZUNJTTVWSHU5QklLMWRX?=
 =?utf-8?B?akRxMUdWbE02TVJrRHk3QytWZWRudmRlWVNadDdmOW9Qc1F2TEZoaGs0OEpV?=
 =?utf-8?B?eGVJTjVNODZTZmZ0RVpHa0NzblBlYjhqYm52clh5QnZkMmYzbEROSEF3T21q?=
 =?utf-8?B?b0RENW9PZ1F0aDk0VkNCc1dybHlQdk5PYkExUmdxV2FkL3hodUJUcFY5U2hh?=
 =?utf-8?B?UVlVamt3emJHOVhWanA0YjdDTlRCR1JjLy8vWWRYR2tPN3dSc1M4SUY2MG5X?=
 =?utf-8?Q?v0ZgCvRoyFcGk2RE8hu6YPixD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01abb166-c4f4-45b4-73a0-08dbd9722881
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 18:00:53.4816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rvh+fs+PjNnBTEgydy75Qpr+RMHQ/U35YNqSPruU8hvmhyPBKoniUr6oTwuTu3VC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270
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

Am 30.10.23 um 18:56 schrieb Felix Kuehling:
> On 2023-10-30 13:48, Christian König wrote:
>>
>>
>> Am 30.10.23 um 18:38 schrieb Felix Kuehling:
>>> On 2023-10-30 12:16, Christian König wrote:
>>>>>>> @@ -1904,6 +1906,19 @@ kfd_process_gpuid_from_node(struct 
>>>>>>> kfd_process *p, struct kfd_node *node,
>>>>>>>       return -EINVAL;
>>>>>>>   }
>>>>>>>   +static void signal_eviction_fence(struct kfd_process *p)
>>>>>>> +{
>>>>>>> +    spin_lock(&p->ef_lock);
>>>>>>> +    if (!p->ef)
>>>>>>> +        goto unlock_out;
>>>>>>> +    dma_fence_signal(p->ef);
>>>>>>
>>>>>> This needs to grab the internal lock of the eviction fence, I'm 
>>>>>> not sure that has correct ordering with the newly added ef_lock.
>>>>>
>>>>> Hmm, the only thing we could get a circular lock dependency would 
>>>>> be, if we took the p->ef_lock in a fence callback. I don't think 
>>>>> that ever happens, because even the eviction work runs on a worker 
>>>>> thread (exactly to avoid such lock dependency issues).
>>>>>
>>>>> Anyway, I could try to move the fence_signal out of the critical 
>>>>> section. The lock is only there to ensure that exactly one process 
>>>>> signals and frees the fence.
>>>>>
>>>>
>>>> So basically either the eviction worker or the GPU reset could 
>>>> signal this fence.
>>>>
>>>> In that case I think it would be simpler to grab the reset lock in 
>>>> the eviction worker to protect against a concurrent reset.
>>>
>>> Which reset lock? adev->reset_cntl->reset_lock? I only see that lock 
>>> taken in aldebaran_mode2_perform_reset. I don't understand why this 
>>> is in ASIC-specific code. But even so, it's only taken during the 
>>> actual reset (in aldebaran_mode2_perform_reset). I don't think it 
>>> covers the pre-reset code path that signals the eviction fence.
>>
>> No, what I mean is adev->reset_domain->sem. It's hold in write lock 
>> during the reset and you can grab the read side if you need to delay 
>> a reset.
>>
>> But thinking about that a bit more, you actually don't need any of 
>> this. Something like this here should do fine:
>>
>> tmp = dma_fence_get_rcu_safe(&p->ef);
>> dma_fence_signal(tmp);
>> dma_fence_put(tmp);
>
> dma_fence_get_rcu_safe gets a new reference that dma_fence_put drops. 
> It doesn't drop the original reference in p->ef.
>
> I need a way to ensure that exactly one thread frees the original 
> reference in p->ef. Even with RCU, concurrent writers still need a 
> lock or a mutex. So I don't think I can avoid using another lock here 
> because I have potentially two concurrent writers.

Mhm, why would you need that? Isn't p->ef be replaced with a new fence 
when the process is restored?

Or do you go from fence->NULL->fence? If that's the case then yeah the 
lock is probably your only option.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> dma_fences are always RCU protected and can be signaled from multiple 
>> sources by design.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>

