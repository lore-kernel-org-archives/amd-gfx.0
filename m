Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7046DC7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 14:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D288610E82A;
	Wed, 12 Apr 2023 14:29:35 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A8610E82A
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 14:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC/tslqid3iFj3/axj0BVa5XIV/rAna1Nqfqktro3Il76JqkXnk10C19KElPkaFBhz0zqNlNbJ7LO2dphAFSa58WSrKqh3WX7L/gAC/ZN/vr+2En5fRKFUGg97wny/MIjkwfaDEK/8FQYV32ESG0LICbERSab+F7CL/onxPZCPI4f7jCfAoQInilwElCcUvnsnpkWtiIxd6qx1djpsfXQZJYlzJAUqK6nFxXRkoG38ySKfiGuxqIPDJ4NX6/vM4qF3D1dwOR0jXFa6mqwShqaEPe+1djezBRqA6hzw571HT6PbReoy35j9883MKwRZcDPwzIPJYSSreotSMaj6Yz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgXtISaIPnHFjK7YMfUmDp5kjDJuFAbE7Q7yoYRKi/8=;
 b=NYqTK5EIYb4gXecoezDM0pisqdRomeJtmy4K+m/imiRYUBhLkwqyg9fZhA/6TdwO7s18dIACkLaoEHXikSKrq4kArLoNGsVXoIlrNkW5VNDFBeXB8xNL4zToC19AGsPZS2uMau28e3X41pqJ5uR0TS7FaMLH7wqqQmApRGGTeKdlOmcwBsy4jEz1EyjputZoTu4nLohbjSYaqiBocNxI9GB13KNU8+1It4w/hbswKKCYc7vNko37YuW6M7gIHeSARZpWMWUS/goJ2NlyVm9XvfPXzkRWEvRCuxziFNSIorsFcCltoUDLMx35tgWV56TQ8pcNMrXsMPMo0P6pauY1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgXtISaIPnHFjK7YMfUmDp5kjDJuFAbE7Q7yoYRKi/8=;
 b=JYQ4G6kq4yxmz347f4LPr5FrVFsEaB7A9CEeU4Ps+8DW91oTPlnY7iFwv7THFo+xJVfd+dTUX8hruRwy+aVW+K9p9kSeBdfZmGSa5E599AojkgF5Owj4eEG5ezh2tsXSDOMot+LAFk9tzbFwRWzAcHa5/1XDgJPflnFPlbwe148=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 14:29:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 14:29:30 +0000
Message-ID: <c73fdd57-167c-7cde-204c-68355a3abd68@amd.com>
Date: Wed, 12 Apr 2023 10:29:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs when
 iommu is on
To: Philip Yang <yangp@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Xiao, Shane" <shane.xiao@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20230404095640.3277840-1-shane.xiao@amd.com>
 <cd5efdb0-d6f6-8e91-353f-35906a1fe62f@amd.com>
 <DM4PR12MB5261B08BE4730541920230F89D939@DM4PR12MB5261.namprd12.prod.outlook.com>
 <c5bd045a-a5ff-36ea-ed9b-bc4732b50b16@gmail.com>
 <539b143b-64fd-9108-1967-04e2ef27848e@amd.com>
 <fe10d586-f547-d797-c084-08a4614bb0e1@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <fe10d586-f547-d797-c084-08a4614bb0e1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0015.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d503dc-d34d-4480-27f0-08db3b625391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KwBB6LwWkCFtVlAJBf7I5abhWWscdjgZNCcGiI4PcaGoF4DqSmys3/BKMnGv0wXfWxLIoLBkzJKiH0ApMppcYuBTfB9hgRD0vsKvdesO5qJWjCiUEqCGTlLZxe36r27bKW+BLmonOXjgOZYa04Yx7DuGQ41D0TE/ESM90eFwU5wozDTALWDsmznbQXPYy8/GgPOAgXTMvXc2mI9GcSZFUQe44wmjhRBKEk8h8VZwwbG3gk/cz32tdE7tSlNxgFLf8UC8mbNT8FU0qAhxZ2VHJlfXHugaDNDNekuun9kfkVXFohPXhnpUqJl77VQHgvMMtC3g0AwdtHkirwmvPio7vRBqqVmbk0/P57cdETAxuJnHFzsMaf5nBp1Kj9k/hTDyz/4bp1rhu2FYBsH5BfEdig8/UZiicYhbkxIMznzW18WALFRVZE6CMSZgzdGfXcZvWNmn6A2BiJU+rtipTsxlwWnp0pJMpxCfVpntpGwId1Zbu0X7ttUNGAtJ48bqF5gyvBsClYoCqjTAiODhOsOU3zocw8h0bNSKc0HxwMzcvOqXXX2y6VFDPd8r33NH+NckJSQgjQcf2rfPQ1RtmcLB7+aBLy9XT2OxUSZe3pDGSm94WSa7pCCgAaDPciOZdm7jIUjtBU0N+7NhuuN+4PvEsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(2616005)(44832011)(83380400001)(41300700001)(5660300002)(2906002)(31686004)(66574015)(38100700002)(8676002)(8936002)(186003)(53546011)(6506007)(6512007)(26005)(6486002)(110136005)(36756003)(66476007)(4326008)(66556008)(54906003)(86362001)(66946007)(31696002)(316002)(478600001)(6636002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnVZV2dlSGhFODhLNUFVOWFnd2t3eGh1NjFZMTJUQ2dZamdKUXZVTEtHaWJj?=
 =?utf-8?B?NFY0SW1XcFZydWdSUlNNb1VEVmxLL1Bxc0l5emlHMmdUb2ZhMDBWcEVaa29y?=
 =?utf-8?B?b0FJWEVqRVBUV05LK1pjZnVRajdpbWRNcVpkZEE0Tll5UFhLL3JITGhDdjdh?=
 =?utf-8?B?K3NOaHBWcFdkV2I1NG1LQVMxK0xuVER5enA1MEZ0ZXlmYVM4OW1aN0pFQi9z?=
 =?utf-8?B?UE96dlltc25rV0planUwNldzdG94QUVKT0ZyR21NOWlMNEZVUUw3OXIxT0lv?=
 =?utf-8?B?ZklFU01KV2JxNWdtMW4wYklWTWNpTzdZeHB1YTJhdlI3Y3puM25qSXVzRFh6?=
 =?utf-8?B?Y1VDc2I0dEk0WTQvS3I4WnQrbDdyNEhBcm5CSVNOMy90OGplNHpjNVM5OEJF?=
 =?utf-8?B?dnJoWmNGUTd3S05UYnk3RFlnZnkwSytFR3dtamI0eDZkMEZkMUVoR3ZiUnJV?=
 =?utf-8?B?QmhGT0tWblVoWEkrZUdaNVZjYzhuZnlLSTY1NmxRREhDQmlrcXFrV0NjM1dJ?=
 =?utf-8?B?VjExYWVkYzdhUmtnSGM5aTBqZGRJb1FGeWJLRWRaMWxraktQNE9DWHRrTUxD?=
 =?utf-8?B?cnVCeDdoREFCdFQwcU0rT2ttUDFPU2xVRS9wUzA3Y0NpU1M0b2xmRVRHMXd5?=
 =?utf-8?B?WXNYbEp5aVNJYkpyY01kd2lEajJPQ2tYb0Rld0J3SXZsU1Fscy9Ka3NOaFg4?=
 =?utf-8?B?QlFzanNWT29ZakxEV3RlNzUreS93cE9wMGZhV0lHMXdNQ1A1WXJMQXVIbm8y?=
 =?utf-8?B?MFp0Q0ZScElxMHc3TUtqd2NRbW80UzFkWDBaVW8ycDFWeFFDSWNKRk9mUDcx?=
 =?utf-8?B?aUQwa0I2ZE1XeE5rWkgzZi8zQ3lPV1ZSYTFwVkt4N0xKQ1ZYVC95dko4K3RI?=
 =?utf-8?B?R0czcUxVa09TT2dLQ3FOcG5EQVRMSm52bFUyTGkzcjQ3QVJ3SHBDdHNYc0l4?=
 =?utf-8?B?OE1ta0pTS1FLYzBvV3NZYW5lNWlvRnU2MXIzcmppYUQydGZnODRxOEp1T1ZS?=
 =?utf-8?B?b2lQTEIrKzJjRGhFQTNSSmZVV0RtekJYK3FJUEJSdzd1dUhFalh3b3R4eXFM?=
 =?utf-8?B?bVBFWmlGRlVCYzBNTTNlcXZQWHhDYkIvR2dzUlFpaUY0cG9KNmpqNDBYWmY1?=
 =?utf-8?B?d0NhK2VVNzFuelVvN2VaMExnVlI1MFE4dWNvVHgvVUp2TEFKWjBuL3h6OVN0?=
 =?utf-8?B?NEhYRmZ4TEJXdzBnNWRNZldta1had3g1SzdDc2ovOTg0UlBpUjU0VWNWY2l0?=
 =?utf-8?B?UjZ0VlZkQzZwN1BFbFJoSW8rMEVmTmNENEN2TzdOY25NSzRCcmdVSTZmb3ln?=
 =?utf-8?B?Q1V3NW45NUVSNm9adXhCcjRLMU5WNzBXSnYrM2pKOWlYb29IWmliUjF4aExj?=
 =?utf-8?B?ZTI3d1lrdXNXYUxsTnJ4M0hra1ZQRmZ2cGRBRkIvK09iK3RNU0EzdkZxTERy?=
 =?utf-8?B?SGFSTDUxOEFsbkxTS3JibFplcnVrM2F5N09rMndqdjMzSmUreDVqUytpaEpy?=
 =?utf-8?B?bGFodnZLa05RUU5MOG12Y256QW9mUU1wQnk0VyttYTNIMmgycDE2bTR0VXJR?=
 =?utf-8?B?ZVZVclJoZVd6a0dJbERFUGhxZ01CNi95YWZPdSsvOGtjMTFKN1RYRk1RRjky?=
 =?utf-8?B?RDRXSklTZkJ5TkVVNHdrOXZkcU51WnJVRUFoY0o4bWZKREdIeWJZTUxvTTE4?=
 =?utf-8?B?SGlmZGRYdGIzNWhFdVUxVkEvSHdwY3QwdlpJaVJQalZpOU5QbjJmZzE2b3hE?=
 =?utf-8?B?ZWpKaUJ0dXgrUmt0TXBWdnJReVBLSGZHNm84MzVDZUtHMzZIaDlOYnR4YlpO?=
 =?utf-8?B?Sm5McVo1WHJ5dHdVM2pFL0dVemN5UHhIek04RXhTa2VrczJHNVFoTVE4UGVt?=
 =?utf-8?B?RTEzUHFSbVdmTlI5Qmc2SEc3WkNmYlVQaDFOMk5CNFFCR0xDS0VoL1h1WU5m?=
 =?utf-8?B?Y05JTnVtQnZXUTdyVnRDVUlOSDNCTEJQUmRDS3pKZTNFODRvNzJYRTJIYWhF?=
 =?utf-8?B?UDQ5b290MnFNU3JPWDZLbXE2SkdVTTJQMmQwQzMvV2hUaG42dUMzczViOVk2?=
 =?utf-8?B?dGJpOUFxK3h2alJhdDdTRk9JMW1HVzFGWktTelErWVI3WmFTaFpGYUh4K3hr?=
 =?utf-8?Q?EEeRwS8/tAYywxd3KGUdK3r5/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d503dc-d34d-4480-27f0-08db3b625391
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 14:29:30.2144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fUV/vDFL1vQNPQZmCP3U4XaEkQMvlkvBZR1cwwn6mFcL55cONQbv7ACB2nfOOZGH0YFMfjQ3BCwzWTriAwqww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062
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
Cc: "Liu, Aaron" <Aaron.Liu@amd.com>, "Guo, Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2023-04-12 um 09:35 schrieb Philip Yang:
>
> On 2023-04-04 09:45, Felix Kuehling wrote:
>> [+Philip]
>>
>> Am 2023-04-04 um 08:47 schrieb Christian König:
>>
>>> Am 04.04.23 um 12:56 schrieb Xiao, Shane:
>>>> [AMD Official Use Only - General]
>>>>
>>>>> -----Original Message-----
>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Sent: Tuesday, April 4, 2023 6:27 PM
>>>>> To: Xiao, Shane <shane.xiao@amd.com>; amd-gfx@lists.freedesktop.org;
>>>>> Kuehling, Felix <Felix.Kuehling@amd.com>
>>>>> Cc: Liu, Aaron <Aaron.Liu@amd.com>; Guo, Shikai <Shikai.Guo@amd.com>
>>>>> Subject: Re: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs
>>>>> when iommu is on
>>>>>
>>>>> Am 04.04.23 um 11:56 schrieb Shane Xiao:
>>>>>> For userptr bo with iommu on, multiple GPUs use same system 
>>>>>> memory dma
>>>>>> mapping address when both bo_adev and adev in identity mode or in 
>>>>>> the
>>>>>> same iommu group.
>>>> Hi Christian,
>>>>
>>>>> WTF? Userptr BOs are not allowed to be exported/imported between 
>>>>> different
>>>>> GPUs.
>>>>>
>>>>> So how can the same userptr BO be used on different GPUs?
>>>> If GPUs are all in iommu identity mode which means dma address are 
>>>> the same as physical address,  all of the GPUs can see the system 
>>>> memory directly.
>>>>
>>>> In such case, should we export/import the BO,  then create a new SG 
>>>> BO for another GPU?
>>>
>>> Yes, absolutely. Each userptr BO is only meant to be used on one GPU.
>>>
>>> Even if you could use the same BO for multiple GPUs it's not 
>>> necessary a good idea since you then have live time problems for 
>>> example.
>>>
>>> E.g. what happens when one GPU is hot removed while the other one 
>>> who imported the BO is still in use?
>>>
>>> Felix can you comment on that? My recollection was that we rather 
>>> improve the storage of DMA addresses instead of duplicating the BOs 
>>> over different GPUs.
>>
>> For KFD we currently enable sharing of userptr BOs between multiple 
>> GPUs by creating a userptr BO for the first GPU, and creating 
>> additional SG BOs using the same page list for additional GPUs. That 
>> way we don't have to call hmm_range_fault N times and setup N MMU 
>> notifiers for the same address range on an N GPU system. But we do 
>> have to create N DMA mappings, which is facilitated by the SG BOs.
>>
>> We have a further optimization to not even store separate DMA 
>> addresses per-GPU if they are a direct mapping. In that case we just 
>> increase the reference count on the original userptr BO. (I agree 
>> that we should also look into more efficient storage of DMA 
>> addresses. However, last time we talked about this, you basically 
>> told us that scatter gather tables are being deprecated, but I 
>> haven't seen the alternative yet.)
>>
>> I think this patch fixes a potential issue with that optimization. 
>> There is an implicit assumption, that the DMA addresses stored in the 
>> original userptr BO are a direct mapping, so we can reuse them on 
>> other GPUs that also use a direct mapping. But, we didn't actually 
>> check that assumption. I think this patch fixes that for systems 
>> where system memory is direct mapped on some but not all GPUs.
>
> We will need similar optimization in svm_range_dma_map to reuse the 
> prange->dma_addr for GPUs on same iommu group or direct mapping.

Good point. Optimizing for direct mapping is easy: Just skip the dmamap. 
Reusing the same dmamapping for multiple GPUs in the same IOMMU group is 
a bit harder. First you need to identify all the GPUs that are in the 
same group and then check if one of them already has a DMA mapping that 
can be reused. I wonder how common this is, and whether it's worth the 
trouble.

Regards,
   Felix


>
> Regards,
>
> Philip
>
>>
>> This scenario should probably be called out explicitly in the patch 
>> description. The condition is also getting pretty hard to read and 
>> understand. Maybe move the both-direct-map-or-same-iommu-group 
>> conditions into a helper function, say 
>> "amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && reuse_dmamap(adev, 
>> bo_adev)".
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>>
>>>> Best Regards,
>>>> Shane
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++----
>>>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> index e7403f8e4eba..33cda358cb9e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> @@ -804,11 +804,11 @@ static int kfd_mem_attach(struct amdgpu_device
>>>>> *adev, struct kgd_mem *mem,
>>>>>>                 va + bo_size, vm);
>>>>>>
>>>>>>            if ((adev == bo_adev && !(mem->alloc_flags &
>>>>> KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) ||
>>>>>> - (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) &&
>>>>> adev->ram_is_direct_mapped) ||
>>>>>> -            same_hive) {
>>>>>> + (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) &&
>>>>> ((adev->ram_is_direct_mapped && bo_adev->ram_is_direct_mapped) ||
>>>>>> + adev->dev->iommu_group == bo_adev->dev-
>>>>>> iommu_group)) ||
>>>>>> +same_hive){
>>>>>>                /* Mappings on the local GPU, or VRAM mappings in
>>>>> the
>>>>>> -             * local hive, or userptr mapping IOMMU direct map
>>>>> mode
>>>>>> -             * share the original BO
>>>>>> +             * local hive, or userptr mapping in the same dma
>>>>>> +             * address space share the original BO
>>>>>>                 */
>>>>>>                attachment[i]->type = KFD_MEM_ATT_SHARED;
>>>>>>                bo[i] = mem->bo;
>>>
