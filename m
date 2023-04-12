Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1CBC77B6E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 13:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42F3F10E7E5;
	Wed, 12 Apr 2023 13:35:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C3310E7E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 13:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfY6z0u5J4f79QiIuJuMqQGPgrStC9TV/MwnxQNmWLhJUpR8vZiOTlyksU0RIzBckSdAXHg5+Xg4WAN68d/kbY+ALvVksqweQ8xgiuD21Ca8y3NZsBG4jrGFkvAnaFDNVMpLQBdViSG08agG5ujgJk8w60aNkAaxflV1spdzYY2EZgL5ZkeExQMskMEPstkfipsrHZz3h9g1NSfHGiqDaEJ/5kXW6RllyQ6gV7IabCqK+c7O2O5317ck7TCaRJ6DkC9CwlDvFDHcYXRP/8NY/pKDLy0iCDpwy4M8i1irG8yb6lEHDUTb3vg3iloauNUuxHJ6iDo6HU8d+towJATz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2qb9ciP/XOF8krZ5JmIycmipHveG8EpIwr5668R9Cg=;
 b=Ip859Fc7lpfhq0xtQVOQnSHKEWX+qsUhwCFxRjx23bd0euPXPMuG+5ZWfwecoTUkbjli8fO3soH3DPZJYuns8bQmsgcHOn8VQLwSviVvvvXOzt1t0NBTT5cBy/d+8GbAXZYz+5DB7PotWTNaHLafIbuVes4pPziPbz8vkM69ssRfQx+vINJEXAADO3z+2HMfC9Kaq0HxIAeunHrDhTxZ0fBjbwNL28KrorEOvSgB05x9f7DTp1IlnucKKrq2d4HOSH707ugDjKImWNv+j60pgp5EkfuDAJI9dYRvr4VFzQIyqGtCnVxqUHFa/L0yM+ssjbMtMFioD8FEWX8BBYZ9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2qb9ciP/XOF8krZ5JmIycmipHveG8EpIwr5668R9Cg=;
 b=UcHAsaUWacPKEbS9y3ameWenDofz3ZtRM7YCTbSWbI2OIBluSl9I5eTcEfRvwjD5ic1qzy53CjCLFKYXBlhFqciRNn0fds+EtpgshDr80u05Qe3dCGJWXDFgEFJ0CjhWxqxgHXEK+ff4PMzxlj4ouakISinbxnipWX/PanLtQ3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Wed, 12 Apr
 2023 13:35:52 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::d7aa:1762:6797:7d61]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::d7aa:1762:6797:7d61%4]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 13:35:52 +0000
Message-ID: <fe10d586-f547-d797-c084-08a4614bb0e1@amd.com>
Date: Wed, 12 Apr 2023 09:35:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs when
 iommu is on
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>,
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
From: Philip Yang <yangp@amd.com>
In-Reply-To: <539b143b-64fd-9108-1967-04e2ef27848e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::19) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: d103af96-60be-4406-847c-08db3b5ad581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kqqv+cV9OAzq2N6UjARfeL3p8kB83vcCVFFiemoWP928ZmFJ8iiCRoq7sRreMnGsvbg0rUQhgRgWDH0OqfKYhaA5LroSMwWeDGveVfp+wPUljXJ/aO1fg0Qg1PB5Dgh4TDQWdGtwrWfbcVe/u9Pl0g7hJ3k3QpU/iUceD59Rls5ZiGQUvk/KTxsPetQelFUhhDZDzomspMO697mKFb83ywSpkl5UYuNbyYfnaIm0GMIKGjdaJHyrbXGVHklf/+1CQCPb1M7VYRYBscIHMD3rP7i+AsbwMTzEer/ENcs3VJw+uXdRDwdw26lskrit/W1vf6cT8YAURljQ/sxmMXTbSFbu2s48wxQXu00wx2ey+2QECBlpHTof5sAwxWOPeoNaZ8LyTGiDKYwF1Vn4OlIefQhr/QCpFpeENTSh94jf7ppGSHnnDnko9O+ETzyW2Hzd1rHFRT53WNONZQGzL5bH/0eMXrkj3+upRe7+epdnVIr1xGtk8YcfA8LfB4yoXB21MEmTPvdWTk/C954E0ImH3+e6wt0UCmz1c3Z3lKqB0CsZzsxQXd8sMF2HevSZdnyiRbgkwIg5WjlicVCAxngrKz+Y9I07kfWBd25qb3yAbItq7mgzoHQwmgQ9IwC/EbCHspmZti4rOO+HnovAm6pn7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(478600001)(36756003)(6636002)(110136005)(54906003)(5660300002)(8676002)(8936002)(38100700002)(66476007)(66946007)(66556008)(2906002)(41300700001)(4326008)(26005)(31696002)(6512007)(316002)(53546011)(6506007)(186003)(2616005)(31686004)(83380400001)(66574015)(6486002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFRQN0NNN0FQNnJnWDNIc1VyUGxWbEFVQVF5T3FMaTNETHRjRkg5dXpOeStM?=
 =?utf-8?B?TnpoT0cwbWlyRTkydzVrREFhbDlORkpZZUVDRC8yL1g5VnpBRkd1aERNdmF4?=
 =?utf-8?B?M1I0WEt4Ym9UcDFGVklwUjlZNmQyTHREM1VnQk5EL25DNUd1M2hXMnlpMjV0?=
 =?utf-8?B?cThubjhSNHRPZFNFQ1RJOWxWL0FiWWhJUDlwTmpMMC9tM2VkcUs4YnN3R1JZ?=
 =?utf-8?B?Ni9oZWtUdG9Zb1A2U1NlK2R1ZkNuRkc0OGhHeFA3VEpOWEZQMXZPZ1lIdnhq?=
 =?utf-8?B?VGV2b2Z3RjdaOFJSRVloV1FEVGtJcjRHeldZMjRnYThHMS9lMHZzbHozSk84?=
 =?utf-8?B?dDcyQmUyaFBLckNzb0xIS0VJbmhUY2NnQlZ2VXF3VnBTQ1djWkgzdTc3OXZB?=
 =?utf-8?B?NHo1NC9JT1B3V283SVlHQzlvY2dCc05yK0MrR3pXVFZRRG5IbkQxWUZQeUcx?=
 =?utf-8?B?c0xRK21jUnRyWkFLOEQwQjEyQlFDK0FIREtRcXdicTY2bjU4dFhLMmtkU29N?=
 =?utf-8?B?b2QrRVcwVjA5UkhzNU5MU1NjR2Nackk2akNOZ3duRVdIRU9vQUkwT25CdUNL?=
 =?utf-8?B?NTZEWnV1UkZ3SytaK0g1VzB1UVNlYWZITS9YTTU2Tk95Y3JEQVJlSjViVDFL?=
 =?utf-8?B?R2diMVhrTk9aSHpTOGJuMklUd2NleHdRT0tJdjJ3VmZMZ3d4U0tzZ1puSEda?=
 =?utf-8?B?SVF3WTkwZFUwMEdHQyt5MlVqRWZ4bDNOUmIxSHdPa2lCVDJaeFRiWXdrOXlT?=
 =?utf-8?B?WXVyRmg1YVlORmpzMUJkTmNuUnI5OFhPc1lwUVB5ZC8rSUp2cXBlSUJaQk16?=
 =?utf-8?B?cUk3bDh4dVhVdGpKVDViVzlWTThRM055V1hnbEYwYlJXNWFyMkNMMFA3dFdv?=
 =?utf-8?B?TFg2eGN5eEtDNzVKZitCVWRzUVl2ZDZ3SmNBdHpnWDh3TDRuMHNPcWZmS1dm?=
 =?utf-8?B?aHZHK01SeGs3aXU5RjNKUzg3NU9tL3JrS0g2NDJWZGVsbWsySjFCY2JIZSti?=
 =?utf-8?B?dmpQUzBVZzFYeWhPYXFscjNBbjVRaTlpZTZ4NjV0TEVxblZVQjdLUDIrMTg4?=
 =?utf-8?B?c0o1dFVTaU5STGNqeEFQSGFpMDJ5YkFqUm11WDVPeVRQK05DUHlicXBZNjZE?=
 =?utf-8?B?bmhHa0NzMW9wUDl2STU1R0RnL1lEU2d4WFp5K2UwVS9Cd1RHSWFKZjNYdW1i?=
 =?utf-8?B?K0ZER01ld2pQbmtsOUNYc3JXL3JCdFFuTGhKQ3c4eVVtSTRQdnhlMmZ2UVpu?=
 =?utf-8?B?dFlvbHVUWEgvb2JsaFFqUjVkTWs0eVJkZW0rN3MrVHpnQ215VUJUYWJjMHFV?=
 =?utf-8?B?OEJBa1lSb2NkZTJobVNiaUg0MTVIb2hOcXpleFR3L1BkTXRCWmVuVlMzTnJn?=
 =?utf-8?B?eWN4dzlxU1pGOUN1dGEvc2IwL250cm9HTWV5WFhjWmRhN2h3a2NjVXNFNmMy?=
 =?utf-8?B?TytHRHlJZy84cnN4S2EyWHltNWo5bjJ2NjIya0hVbnJYN1BMNlNzTEhlTkRR?=
 =?utf-8?B?UWdyQXQ0Ly9ia1BDVytkSGI1NmQ3Ri9OMzVPbGpybnBmS0hDVFRhbzJvWit5?=
 =?utf-8?B?REhsdTRTQjd3UkM0a1JpVytLUmZmSzdaSXJvaDM2MVByWTFzSXN0YUk0OU5V?=
 =?utf-8?B?TzVzVjhsME5pV09DSmx4V1VrNjlWMXlqYzBpTjVjNU5pTkQ3aGI3TkRoKzhD?=
 =?utf-8?B?M2wyNlhUTmRTQzRmNC9rNWVlOHk2WlZrMU90K1VWYzlsQjRsWk5Wd0tIVE4v?=
 =?utf-8?B?Vjl6azJFejF2NzJGM2Y2YzJRY25OUnVtelNIQ0g3ODM1MzVlL1RyTEd0bVdF?=
 =?utf-8?B?ZmJTZFJ5cUJodzUzem1LaFVETGw4d0xZOTdCcFh6TXU1YVRVbWJZMlhVY3VO?=
 =?utf-8?B?Zi9lR01Kb0xxTldQdVh3N2xuMldQUXVSRVNrQndhSk1POHFQMmlvcXVwM045?=
 =?utf-8?B?OExvdWpQQjJ3R1F1NFl1ZTUwenV3RnJGak1rUGtrbnM5R1h0ZzdxZzBrbHoz?=
 =?utf-8?B?NVR0SmNnOUFid1BqZE5JaFExVENIVEN5ejROM2RXOGxXcEhSQ2NIeHhQemVl?=
 =?utf-8?B?ckY1dGkyVVh0OE9xSWhVanlTb3hwZi9aQXROUzBBa0RQdVQ3VWVJbU1Lem1G?=
 =?utf-8?Q?rV80=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d103af96-60be-4406-847c-08db3b5ad581
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:35:52.0284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZojJA+HbC97oURvLPc/EeShW9j1ntXjy/Fu4pyj4bHqsc+5Sc6rf6M1hcCEpb4A/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
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


On 2023-04-04 09:45, Felix Kuehling wrote:
> [+Philip]
>
> Am 2023-04-04 um 08:47 schrieb Christian König:
>
>> Am 04.04.23 um 12:56 schrieb Xiao, Shane:
>>> [AMD Official Use Only - General]
>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Tuesday, April 4, 2023 6:27 PM
>>>> To: Xiao, Shane <shane.xiao@amd.com>; amd-gfx@lists.freedesktop.org;
>>>> Kuehling, Felix <Felix.Kuehling@amd.com>
>>>> Cc: Liu, Aaron <Aaron.Liu@amd.com>; Guo, Shikai <Shikai.Guo@amd.com>
>>>> Subject: Re: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs
>>>> when iommu is on
>>>>
>>>> Am 04.04.23 um 11:56 schrieb Shane Xiao:
>>>>> For userptr bo with iommu on, multiple GPUs use same system memory 
>>>>> dma
>>>>> mapping address when both bo_adev and adev in identity mode or in the
>>>>> same iommu group.
>>> Hi Christian,
>>>
>>>> WTF? Userptr BOs are not allowed to be exported/imported between 
>>>> different
>>>> GPUs.
>>>>
>>>> So how can the same userptr BO be used on different GPUs?
>>> If GPUs are all in iommu identity mode which means dma address are 
>>> the same as physical address,  all of the GPUs can see the system 
>>> memory directly.
>>>
>>> In such case, should we export/import the BO,  then create a new SG 
>>> BO for another GPU?
>>
>> Yes, absolutely. Each userptr BO is only meant to be used on one GPU.
>>
>> Even if you could use the same BO for multiple GPUs it's not 
>> necessary a good idea since you then have live time problems for 
>> example.
>>
>> E.g. what happens when one GPU is hot removed while the other one who 
>> imported the BO is still in use?
>>
>> Felix can you comment on that? My recollection was that we rather 
>> improve the storage of DMA addresses instead of duplicating the BOs 
>> over different GPUs.
>
> For KFD we currently enable sharing of userptr BOs between multiple 
> GPUs by creating a userptr BO for the first GPU, and creating 
> additional SG BOs using the same page list for additional GPUs. That 
> way we don't have to call hmm_range_fault N times and setup N MMU 
> notifiers for the same address range on an N GPU system. But we do 
> have to create N DMA mappings, which is facilitated by the SG BOs.
>
> We have a further optimization to not even store separate DMA 
> addresses per-GPU if they are a direct mapping. In that case we just 
> increase the reference count on the original userptr BO. (I agree that 
> we should also look into more efficient storage of DMA addresses. 
> However, last time we talked about this, you basically told us that 
> scatter gather tables are being deprecated, but I haven't seen the 
> alternative yet.)
>
> I think this patch fixes a potential issue with that optimization. 
> There is an implicit assumption, that the DMA addresses stored in the 
> original userptr BO are a direct mapping, so we can reuse them on 
> other GPUs that also use a direct mapping. But, we didn't actually 
> check that assumption. I think this patch fixes that for systems where 
> system memory is direct mapped on some but not all GPUs.

We will need similar optimization in svm_range_dma_map to reuse the 
prange->dma_addr for GPUs on same iommu group or direct mapping.

Regards,

Philip

>
> This scenario should probably be called out explicitly in the patch 
> description. The condition is also getting pretty hard to read and 
> understand. Maybe move the both-direct-map-or-same-iommu-group 
> conditions into a helper function, say 
> "amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && reuse_dmamap(adev, 
> bo_adev)".
>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>>
>>> Best Regards,
>>> Shane
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++----
>>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index e7403f8e4eba..33cda358cb9e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -804,11 +804,11 @@ static int kfd_mem_attach(struct amdgpu_device
>>>> *adev, struct kgd_mem *mem,
>>>>>                 va + bo_size, vm);
>>>>>
>>>>>            if ((adev == bo_adev && !(mem->alloc_flags &
>>>> KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) ||
>>>>> - (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) &&
>>>> adev->ram_is_direct_mapped) ||
>>>>> -            same_hive) {
>>>>> + (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) &&
>>>> ((adev->ram_is_direct_mapped && bo_adev->ram_is_direct_mapped) ||
>>>>> + adev->dev->iommu_group == bo_adev->dev-
>>>>> iommu_group)) ||
>>>>> +same_hive){
>>>>>                /* Mappings on the local GPU, or VRAM mappings in
>>>> the
>>>>> -             * local hive, or userptr mapping IOMMU direct map
>>>> mode
>>>>> -             * share the original BO
>>>>> +             * local hive, or userptr mapping in the same dma
>>>>> +             * address space share the original BO
>>>>>                 */
>>>>>                attachment[i]->type = KFD_MEM_ATT_SHARED;
>>>>>                bo[i] = mem->bo;
>>
