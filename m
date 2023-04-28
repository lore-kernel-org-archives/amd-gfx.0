Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2998AC77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 19:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E3E10E138;
	Fri, 28 Apr 2023 19:10:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C1B810E138
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 19:10:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEzQ44hCrSEwhhkQZDNYaB9rwiEMfK6N4Q/Ey17dpxTiRk/njz3m14dglZdyZcEVNHDZrQaHEeK1eGCxAVCVuau7gIkLfyCHJLbOnnxUC9+HQAQixNmXH6FBBRXsQaIWdDZU2OOhpoIsRWWbUflrs8YSY21RCXdkyE6H+rBSX/SqbTRUs5a7NY6rhz9LkJ+NhEnqxeWUgQxoqU6KCXHQeLlO5+ZitHemx84EL5zc+sdUjCuwR8h7Z4r83yvjchjsaB94Z1i4Odwy5gaFwuWOgcEwhCxCPNcqvUKl9E6ThUMObCaHj2qLVJPjEB4/gOS6eHoS+74Ran+fYiFwg4yPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf7rl+7W5d/cS2LmDJCOc/1mJ0fTZ19OVBlGOp/3taw=;
 b=Ck9vUPMs5/eXvihYce2EcoMIzJ3rqsHtx/eRLSrFckHLDYCxqtMT56baYe8BGQrLldava4JMmxEvhveinOL3OMw7FeqxwINyp9DXYz930JA3xtBV6Y6sNOmqnvrz9fttfyjAQCfWxnhSHn6mRzms7HEJ+MbmeuT/wE3xhOFx7BqQj6/m/nzgpkZ60Ie792XiMeKzgCZViXT3U6rzTZ4mlDMln2/e5J1wLFGZG3paYeBvUogn/hjOgUZ2Iyr5QtrAgk92375YTk5tGECGKr2Vbklz2F4DO4WO5ph04bYr7aBVcFayd2BCcxII0fm0hp3sFRmYAw2e/P1lLizYYprNuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf7rl+7W5d/cS2LmDJCOc/1mJ0fTZ19OVBlGOp/3taw=;
 b=Av9StZ+dAHe8HAwgC18IjmF7rkB22zBqO7uV2XoL+A/W1f6Eb6Rs9BgO8h9xxgRVCRsPTHPf73BfqgverasJ0dWhyygLcxt4WY1mf7uzfVYDVm1KwVQNLr/SoroKVfdL4bLMLD6gbA1ijlSytYQVPB3bAt1WKS269vaGThJhMXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 19:09:59 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::459:bcc0:b905:31a9]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::459:bcc0:b905:31a9%4]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 19:09:59 +0000
Message-ID: <2d6e286d-3ba2-3510-4e24-0fe555aaa5dc@amd.com>
Date: Fri, 28 Apr 2023 15:09:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences invalidating
 preemptible DMABuf imports
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230412222511.236384-1-jinhuieric.huang@amd.com>
 <ce2de03d-27c5-a7ad-1a76-814cbd92f15e@amd.com>
 <6d32ae76-08fa-64a4-6726-2d55e8c9fc08@gmail.com>
 <7df3dfd1-d89c-1f24-c3b9-789e1bedf138@amd.com>
 <73c8c82e-907a-1666-b05b-4ba257363a01@amd.com>
 <8b8d22bd-0eff-2f81-9267-07c4c4d058d1@amd.com>
 <04b2fcfc-90d8-5398-9ccf-58dfd178d73b@amd.com>
 <19238e6c-86db-6a00-ea83-e69b7384eeba@amd.com>
 <008e334c-d62a-bca7-6465-3cccea7f0c17@amd.com>
 <56d9dd1c-2028-76ca-3f74-d37ad1733264@amd.com>
 <BN9PR12MB51153ACF2B1F2028E85ADD3E926B9@BN9PR12MB5115.namprd12.prod.outlook.com>
 <203033d8-3edc-ef85-fb5d-df77315cf118@amd.com>
 <ac08c72e-ed64-09d3-1669-4f23ae0172a1@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <ac08c72e-ed64-09d3-1669-4f23ae0172a1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:610:52::29) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: e9dbf754-ede3-4caf-6c9d-08db481c28eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xenuWNp/wtaiiq341ZnguRPrUEySYErOcdOHSVNrEVuYsYrQiAztpSCW6h7tI6RgKtsjxfK/VQCiUlFO5IsMGwyBmz9Z3LHZSsCa80S+8RuCc7nevfEmcXHK1N+ka6dd+9gmOLdoZOoNeBCpWO0237xoqJjiDIz/OgUQEMotRwB/Mmw2nCbd+r+DdCRoDIlQQTXUnzSaP43m7bpb6hSCA20hYLmOiMXZc6wDnAFtECdK0KuyE3XHqxDD/pJ/hIOt3nVf0OdBrTOOyf6NMnA2zEFjp2mpMcAB7w5dn1+wgHz8joHgfRXuGis4khssbloZQLAzlvXXiSBE1WALuNRIGFKn445iSwSdxLAkVuI6yfxjpGV4PTBko3INuMV2oe6DCWCVRSSSU2e3yO49nFMY9SjFH9NrgAu4nSS6/R5Do8K0uvr3MMEgW9wg1aoTB05lnbXxEQQAsyKv6BhA1SnX3VNpBuud4A48vzMzmMJxpWSwqVoz/mdKnDAmSmtUHMnNamZklIqUsCzzcko1qidZqcy9VwrdDIE0EKpohNOEiXWNI78K2fcme+9ShAwXLYk8qVp7S0W/TQ4cd8Dkac8w+4O6/hOOWkUoGjyIhrpHUYgGdJ9hTBysRtfG3rVVLacZ6rqWfOFi7VpaglxgKOMmzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199021)(2616005)(83380400001)(186003)(6666004)(6486002)(6506007)(478600001)(26005)(53546011)(6512007)(31696002)(86362001)(36756003)(110136005)(41300700001)(316002)(8936002)(8676002)(31686004)(5660300002)(66556008)(66946007)(66574015)(66476007)(30864003)(2906002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2hOMW9sNjFOc0dNMFZ6WFExNHBleE1oUmNoeE9VbEtGTUU3MXcrdkhublpK?=
 =?utf-8?B?UEZuU0t5bXNkQ09yQ0NncXpvdTFhYXZKSHlxTTlOZDBqYlFuYWF1Y3Q2VkRo?=
 =?utf-8?B?aDE1RW5kaWhxZldnVXgrZUtlakxWelhXc2h1RUttWi9VeTQ5U3greU9HZ0hJ?=
 =?utf-8?B?emF6MTNoZzNtMHF0dWprMTJXWFJtZi9RUWdWSnAwcXBpT2NsckNQb0ZtVjVh?=
 =?utf-8?B?ZDYyS2lvZkFkYy9CNGM5L0NVTVBvc3FTNFdsTHdqUVRxYlFhU1krOWtDajBC?=
 =?utf-8?B?VlorSit2NEZvV2Z1Q25rajh1Zys2azVtUDdKSVpLSkxIN1I5Mnk5Mjljdzd1?=
 =?utf-8?B?VHVONS9OZnJiOVBTbTlqdFp6UmZORW9YS2czMUJkNXNFVjNTTHdBWTM2Z1J1?=
 =?utf-8?B?eG42dVA5REN2RFpoL3dVU3RzZUNhV1JEZjJxajF4RUZ2SHg0WXIxVkpRYnhm?=
 =?utf-8?B?MmhBWk9xbXRXQTkzcGoxR2RBdUhsc0l4YmFhWmFFYUMwcUpOWE9mUDJHSVV5?=
 =?utf-8?B?M0VJc05hYlk0aFNleDNzTlFrenBoUnFsVWo0bDlHREpSMzk2eWNxT0FoeGR4?=
 =?utf-8?B?NlN5WHV0UWdXOUY0ZGg1UDkyakNUQmlENXUza3ora0M3VktibENHd09kSkls?=
 =?utf-8?B?WUtXdEkyYTVGNGtJekVBbmtZcDd6N1JLdGc3UkVuaXl2Nk9uM1hZZGZ1YTJP?=
 =?utf-8?B?Y2hJdUJJRmJSMHBtNHVzamhXbTBzMCtiR2t3bHZSYW5xWlFCUEdaRmdWdyto?=
 =?utf-8?B?WlhCeURqUXZHZU5LSk5veUluekJsU2h5ZWdSeFRIa0RhcTJLWHdMOFNiTlUx?=
 =?utf-8?B?aWNnMHNCaEdUUnMyMGVtY2lYVXRHY1QrUUxVTVYvQUJScE5mZWNMN2xvcG1z?=
 =?utf-8?B?V2c2aElvcHh4RnFkQXFRUlhLOGRPVURheUxoa1QvVEYzN2ZaM29oUmRYK3Ns?=
 =?utf-8?B?eExaVjBzeXRWVzV3SFcweVE1MGx1cXJUMk41SzZUZ0RzTUJseFZuSDJwMXNx?=
 =?utf-8?B?WnROWFdLN3V1RDM5S1NrUTlpREx5NmZ0RjVUZXRUa0Eya2k4NjZ2QzgvQy9R?=
 =?utf-8?B?b3lKbWxTK0NGY0tmL1cwWkZNbDV2aHl5cXJIekFkNHlGbkpkemFvd3pzNWwv?=
 =?utf-8?B?OS9tQm1BSjRXK2V3RjBCcFg3SW9hWGdFUkk3aURPc1NtLzRDTWlXQWJFbk42?=
 =?utf-8?B?eVZVWTBZZGdoRElHNWd6WVVWeEhraVlobzFiWTNta2V6WXZuOGtyeExLN1hj?=
 =?utf-8?B?c2tVK2RzQ283VVp6K1p1QVRGaUx5VnYvcFNXNmtLeVNIbWQveTlkRno4R0NW?=
 =?utf-8?B?Y1FPNTVlRVkwb3ZsazJNNThDSmt4VWJneGFHZmFSNFJ6Y2NQck95blhYMDJ1?=
 =?utf-8?B?YWZ6ZE9jU1VBYjdEejl1dUV2SjFtaFFML0srRCsveENPeTF5ejZhZndSTlBk?=
 =?utf-8?B?RDhCRU5OSzNmek85YitaekVWM1NtV0ZWTDRjTHhTTUsrRlBCZFRoS3U5a0dn?=
 =?utf-8?B?QytnMmgzYU1NUDVpdU9yU3hPMjZuVTRhNHVCS2FZcHBHWk1uZFltR21RT0Iz?=
 =?utf-8?B?TExFaHJSdDVBQUZGZXJTRE42blM0cnNsWjBxYmRrZzRLQzg4WldyY1ZSb3Vl?=
 =?utf-8?B?ZEJJZUtNN0RiaU5XQUJ6Y1llVHhZa2RhS2hUdy84VTlWR1dYeUFNVUxUaUsw?=
 =?utf-8?B?dGRGWWJOalEwd0xFTER5enVtNlNrRjBHTDBvY1hWckIwZW40dzNzNHpPZHQv?=
 =?utf-8?B?SHJKM1dhRkF4YUJZMm9ZZXQ3Q3VnTTBBb1h0SjRCWXBFL3IzQlpkelFiSUhD?=
 =?utf-8?B?ZWNkT3Rtbm4xUmE2Y3NkZ0tIWENvNnExZGViYnNJb3JqMkY0Z0dMYk5nOFpM?=
 =?utf-8?B?K1YyZ2FtYUJlTm9GejY0UlpQOHI1ajNoUXYvb2c0RUxPTmpYNmxrOTV1SXB4?=
 =?utf-8?B?dFN3MlU3WVg2Rm83NWxSQUVPRzhZdzhDVHhXUEdhSEd4TVNFWFlsSGlWS1dV?=
 =?utf-8?B?bStJbjZKeVN4YTh5ZWhCNVNGT2lBQmJhVWVaYWZaL1lhQktJcHJGdkRSbkxp?=
 =?utf-8?B?M2JVT240QlR0Y25yQmNRQ2k4YlN2Y0hwcS8zWUJIVHBpR0tSWllZbnRGVXF2?=
 =?utf-8?Q?N3SNnbvxM0x2ydMcjOFI+pfaN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dbf754-ede3-4caf-6c9d-08db481c28eb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 19:09:58.8374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dndtdYDw7/8YdLYaxh98VQnK7Vi42xG55kmdS/TQw0fFEuYbQ7uaPr4xXq4+fOXKN6uuFB5RFKD51jKP/f2u6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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


On 2023-04-28 12:41, Felix Kuehling wrote:
> On 2023-04-28 10:17, Eric Huang wrote:
>>
>> On 2023-04-27 23:46, Kuehling, Felix wrote:
>>> [AMD Official Use Only - General]
>>>
>>> Re-mapping typically happens after evictions, before a new eviction 
>>> fence gets attached. At that time the old eviction fence should be 
>>> in the signaled state already, so it can't be signaled again. 
>>> Therefore I would expect my patch to help with unmapping the DMABuf 
>>> import, without breaking the eviction case.
>>>
>>> Are you talking about remapping with a map-to-gpu call from user 
>>> mode? I think that would only be a problem if the KFD BO was 
>>> unmapped and remapped multiple times. The first time it's mapped, 
>>> the fresh dmabuf import should be in the SYSTEM domain, so the 
>>> validation in the SYSTEM domain before GTT would be a no-op.
>> Yes. The case scenario I am talking about is from user mode, 
>> mapping->unmapping->re-mapping to the KFD GTT BO will trigger the 
>> eviction.
>>>
>>> I sort of agree that we don't really rely on the eviction fence on 
>>> the DMABuf import. The reservation object is shared with the 
>>> original BO. Moving the original BO triggers the eviction fence, so 
>>> we don't need to trigger it again on the dmabuf import. Other than 
>>> moving the original BO, I don't think we can do anything to the 
>>> DMABuf import that would require an eviction for KFD use case. It is 
>>> a special use case because we control both the import and the export 
>>> in the same context.
>> I am thinking about no adding KFD eviction fence in first place of 
>> mapping original GTT BO, because I don't see it can be evicted in any 
>> cases.
>
> That's not an option. We're not adding an eviction fence. The 
> reservation object with the eviction fence is shared between the 
> exported BO and the imported one. That's just how DMABuf works. If you 
> wait for the fences on the imported BO, you are effectively waiting 
> for the fences on the exported BOs. And you can't remove the eviction 
> fence from the exported BO.

What if the exported BO will be never evicted in reality? I understand 
how DMABuf works, and imported BO doesn't have eviction fence, it shares 
with exported BO's one if eviction happens, but I don't see the exported 
BO can be evicted.

Regards,
Eric

>
> Regards,
>   Felix
>
>
>> In theory GTT BO is mapped by user calling mmap() in system memory 
>> like userptr, unlike VRAM it will be not evicted by amdgpu vram 
>> manager. The only thing is CPU invalidation, but GTT BO doesn't 
>> register mmu notifier, that will be a potential problem when 
>> switching paged/userptr to non-paged/GTT for mes scheduler.
>>
>> Regards,
>> Eric
>>>
>>> In the general case dmabuf imports need their eviction fences. For 
>>> example when we're importing a DMABuf from somewhere else, so the 
>>> eviction fence is not shared with a BO that we already control. Even 
>>> then, unmapping a dmabuf from our KFD VM does not need to wait for 
>>> any fences on the DMABuf.
>>>
>>> Regards,
>>>    Felix
>>>
>>> -----Original Message-----
>>> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
>>> Sent: Thursday, April 27, 2023 14:58
>>> To: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian 
>>> <Christian.Koenig@amd.com>; Christian König 
>>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences 
>>> invalidating preemptible DMABuf imports
>>>
>>> Hi Felix,
>>>
>>> I tested your patch on mGPU systems. It doesn't break any KFD 
>>> eviction tests, because tests don't allocate DMABuf import, that 
>>> doesn't trigger it's eviction fence. The only thing the patch 
>>> affects is in re-mapping DMABuf imports that the eviction will still 
>>> be triggered.
>>>
>>> I have an idea that we probably can remove eviction fence for GTT 
>>> bo, because currently the only way to trigger the eviction fence is 
>>> by calling ttm_bo_validate for CPU domain in 
>>> kfd_mem_dmaunmap_dmabuf. Do you know there is other case to trigger 
>>> GTT bo's eviction?
>>>
>>> Regards,
>>> Eric
>>>
>>> On 2023-04-26 22:21, Felix Kuehling wrote:
>>>> Hi Eric,
>>>>
>>>> Can you try if the attached patch fixes the problem without breaking
>>>> the eviction tests on a multi-GPU PCIe P2P system?
>>>>
>>>> Thanks,
>>>>    Felix
>>>>
>>>>
>>>> On 2023-04-26 13:02, Christian König wrote:
>>>>> Am 26.04.23 um 18:58 schrieb Felix Kuehling:
>>>>>> On 2023-04-26 9:03, Christian König wrote:
>>>>>>> Am 25.04.23 um 16:11 schrieb Eric Huang:
>>>>>>>> Hi Christian,
>>>>>>>>
>>>>>>>> What do you think about Felix's explanation?
>>>>>>> That's unfortunately not something we can do here.
>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Eric
>>>>>>>>
>>>>>>>> On 2023-04-13 09:28, Felix Kuehling wrote:
>>>>>>>>> Am 2023-04-13 um 07:35 schrieb Christian König:
>>>>>>>>>> Am 13.04.23 um 03:01 schrieb Felix Kuehling:
>>>>>>>>>>> Am 2023-04-12 um 18:25 schrieb Eric Huang:
>>>>>>>>>>>> It is to avoid redundant eviction for KFD's DMAbuf import bo
>>>>>>>>>>>> when dmaunmapping DMAbuf. The DMAbuf import bo has been set as
>>>>>>>>>>>> AMDGPU_PL_PREEMPT in KFD when mapping.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>>>>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>>>>>>
>>>>>>>>>>> I'd like to get an Acked-by from Christian as well before
>>>>>>>>>>> submitting this.
>>>>>>>>>> I have to admit that I only partially followed the internal
>>>>>>>>>> discussion, but in general you need a *really* good explanation
>>>>>>>>>> for this.
>>>>>>>>>>
>>>>>>>>>> E.g. add code comment and explain in the commit message
>>>>>>>>>> extensively why this is needed and why there are no 
>>>>>>>>>> alternatives.
>>>>>>>>> OK. I'll give it a shot:
>>>>>>>>>
>>>>>>>>>     This code path is used among other things when invalidating
>>>>>>>>> DMABuf
>>>>>>>>>     imports. These imports share a reservation object with the
>>>>>>>>> exported
>>>>>>>>>     BO. Waiting on all the fences in this reservation will 
>>>>>>>>> trigger
>>>>>>>>> KFD
>>>>>>>>>     eviction fences unnecessarily, for example when a DMABuf
>>>>>>>>> import for
>>>>>>>>>     a DMA mapping on a secondary GPU is being unmapped 
>>>>>>>>> explicitly.
>>>>>>>>> Only
>>>>>>>>>     moving the original exported BO requires stopping KFD user
>>>>>>>>> mode
>>>>>>>>>     queues. If the invalidation is triggered through a move
>>>>>>>>> notifier
>>>>>>>>>     from the exported BO, then moving the original BO already
>>>>>>>>> triggered
>>>>>>>>>     the eviction fence and we don't need to wait for it again on
>>>>>>>>> the import.
>>>>>>>>>
>>>>>>>>>     We can identify DMABuf imports in KFD for secondary GPU DMA
>>>>>>>>> mappings
>>>>>>>>>     by the mem_type AMDGPU_PL_PREEMPT. In this case, use a wait
>>>>>>>>>     operation that ignores KFD eviction fences.
>>>>>>>>>
>>>>>>>>> How does this sound?
>>>>>>> To be honest like quite a bad idea. Why in the world are imported
>>>>>>> BOs moved from GTT to SYSTEM in the first place?
>>>>>> As I understand it, the way to update SG tables in  SG BOs (e.g.
>>>>>> userptr and dmabuf imports) is to move them back and forth between
>>>>>> system and GTT domains. If we left the import in the GTT domain all
>>>>>> the time, we would have no way to update it, e.g. after an eviction.
>>>>>> Currently the move to the system domain is done in the unmap code 
>>>>>> path.
>>>>>>
>>>>>> Before memory is freed, we also need to unmap it from GPUVM,
>>>>>> including the DMABuf imports on remote GPUs. For the above reason
>>>>>> that currently includes moving the import to the system domain. If
>>>>>> we removed that from the unmap code path, we'd need to do the move
>>>>>> to system somewhere else, maybe in the mapping/validation path.
>>>>>>
>>>>>>
>>>>>>> The only reason for this I can think of is that the DMA mappings
>>>>>>> become invalid for some reasons and in this case waiting for the
>>>>>>> KFD fence is actually the absolutely right thing to do.
>>>>>> In this case the reason the only reason for unmapping the memory is
>>>>>> that we're about to free the memory and its DMABuf imports on other
>>>>>> GPUs. This is coming from the application with a promise "I'm no
>>>>>> longer accessing the memory". We don't need to wait for fences here.
>>>>>> We only need to invalidate the PTEs to make sure that any further
>>>>>> buggy access by the application will fault.
>>>>> Well in this case just free the BO and it's bo_va structure. The core
>>>>> handling should take care of clearing all the freed up regions.
>>>>>
>>>>> As for updating the SG of a BO you indeed need to move it from GTT to
>>>>> SYSTEM and back, but in this case we should either indeed wait for
>>>>> the KFD fence since page tables in between the operation still have
>>>>> the old entries or we should destroy the BO and create a new one. The
>>>>> later would overwrite the PTEs with invalid entries first and then
>>>>> fill in new valid ones.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> Regards,
>>>>>>    Felix
>>>>>>
>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>>    Felix
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>> Christian.
>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>>    Felix
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> ---
>>>>>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>>>>>>>>>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>> index 2430f3e9f3a7..64795fe9eecb 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>>>>>>> @@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct
>>>>>>>>>>>> ttm_buffer_object *bo, bool evict,
>>>>>>>>>>>>        if ((old_mem->mem_type == TTM_PL_TT ||
>>>>>>>>>>>>             old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>>>>>>>>>>>            new_mem->mem_type == TTM_PL_SYSTEM) {
>>>>>>>>>>>> -        r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>>>>>> +        if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
>>>>>>>>>>>> +            r = amdgpu_bo_sync_wait(abo,
>>>>>>>>>>>> + AMDGPU_FENCE_OWNER_KFD,
>>>>>>>>>>>> + ctx->interruptible);
>>>>>>>>>>>> +        else
>>>>>>>>>>>> +            r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>>>>>>            if (r)
>>>>>>>>>>>>                return r;
>>

