Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E694C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 03:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1479C18B0B0;
	Tue, 26 Jul 2022 03:03:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC7F18B0B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 03:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3mCjrCjZR4CKScfV1s8YPTYL2gVFWg8eHczVxbN4dg6tziuQepzjlIj1XXblNUYgFN+3pjkIiS2TE2hhHGzPiVP8zNst2LXppuTwC+xljJ+Bfh9yjqSdsc/lM7KRIbWHzuIJUjk/rPCNuPXK6e9+rFqxSRPNm0A76npNVj7iR16SEEZruUalz+JlT1qjF6o376BxYFuQQHtjIE1lFwt00/9K7wIKP96z8G/1GkD3k6JEZbltHSmnF0KQ5jfeDFhgHsZcbUrcWeKSUo6sxYsI0gUEd4mz8xiJtfCAxmCQXmM65/jTWZEcLbm20ctDUG9DprfCC2S7RaOtiRZCTd/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyFzzuLcG5e+QdHGe22h27HaoW1zVbHuQW80jx8w2Yk=;
 b=g+ovqACyLugi7TfNPQx5CB2JWQmyfFe9gYzawl8RzK9VR67WNbTIllOSwuoAisGqthrb3P+Gy63XPeQHHA/SRhALu2/fiBLGXcAPohLez/V8aQrIcGP31+bZg28YxAxrGoTSvZU9dERb/Wwu9P/IiuPF6eQDPiPMAUDFlD49tGya5g/cx5pZbPblzOTx8H9ZzCAw85UYu/yWfKh7R0yFhBzZ+qzEYryw9pcjnRfecdYFVPQLc49gJHXpu3q0k8ioKOZ9HMO7yCK1uyBguXx/pcXGDZ7LfF4t7Cvcf0pBG56NqIU4wvCe0qrxPC1hmGZP9a19FfVk7iufC6EELuCL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyFzzuLcG5e+QdHGe22h27HaoW1zVbHuQW80jx8w2Yk=;
 b=aAmOyvhSiq9FRJyTpv0IPvGOXU+gQIBLpx1muy4S0tD2QmDEA5keQQHFY+jMNOImhkySuXWbq/p8k3UYho/bZ/H5GnGcrrOE1Js0k89l8aUyKaS6AZc4q/bQDIX8+FErahT6SFB/jgVF18WV/bqyIY62MiA4whFylpfvPBm4GOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BYAPR12MB3319.namprd12.prod.outlook.com (2603:10b6:a03:dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Tue, 26 Jul
 2022 03:03:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 03:03:26 +0000
Message-ID: <0b7c8d09-26b6-44f1-610f-636a3e21ef8b@amd.com>
Date: Mon, 25 Jul 2022 23:03:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] drm/amdkfd: refine the gfx BO based dmabuf handling
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20220725103205.2085630-1-Lang.Yu@amd.com>
 <20220725103205.2085630-2-Lang.Yu@amd.com>
 <3ea7d3b9-266f-d9b1-f6d5-d998a5e6e2c9@amd.com>
 <Yt8yHSREAp6sRK+K@lang-desktop>
 <9548e049-8567-7479-7939-4cd12e856153@amd.com>
 <Yt84EdsZe/2QCneC@lang-desktop>
 <fc9bff98-1d79-b769-6999-f792c045193c@amd.com>
 <Yt9O6loDDeDbQyen@lang-desktop>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <Yt9O6loDDeDbQyen@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52c4446a-93e0-4525-ff7a-08da6eb36903
X-MS-TrafficTypeDiagnostic: BYAPR12MB3319:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uj9+k1vKf8Mw5IyBOWMD1WXmSs6+T9q2JFuv6CvTXdMLtM4OXm/uyB0twU6wsOXo9w1hfdxy2dTZBVbDWFqDXyImaP/TrZORTFAcKipl6p+EXXsUkmrER/cDCggkGzKDnqdV3tAArY4pJ9aiLudAXK8MJf74bSmFQhM6Te+85I4W5M5Vtvj9By91UVk3bMJUD9ga/qBbtYbVpC6Xmh2BMe62g0F50Bkls8QxjB0lOczJHMLnbKKJizA0GPlyLRjZDgLaMova9G2hAvMWCnL6wSo4d7NOVn4PWcLgZYSIpWFHlRNlPMLOk7fHCm5Z+DC5G3BfRSn2IQLPZF/FnlNyeUeNXzadtTcXT+450UYZx2hgrqlMEE43wfDepiOAN9Cfgpm8N6Lc2emGQpsLafaPMMuJEDAbmEIDExI8HgDg+ZV6qusSuH1DpIuIkW3xI+VEzMnCCFJRH8qc5ngj60HhgOjQXksK+47zZsMJoIrFsinXKTaA3yxsioent7O/R4em0i8XT1G+XZ+eHHv+GJpnL63N47zSyWhMaiz03DwPvkPsIWPwqgKQCuQj5t9MMmESFlfjz0GiTOlHxQ7HpibArtiKJDqMCuSBPdjpthPm52J7bJ0s3qvjZ3HpCuBe/KkxUUfu0HQCpLBjNprXbtrgsM3aXKraJIcSSpqWtJOvSHFBTZkxnwDRb1nQ1FF/uzjJxxCNJwFgH7Z3HvaF3VFD8mzMAQPMwOTviyAbmis7YbYnd1X8r03F282ukgKUpcx57wkQ2MNcrIk4uRzj9khBhUo+k62YPnxAmiaxIhAAATavL6a5RroX3WJlozQ6jCnXH00APsC96uk5FVKLTMvFfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(8676002)(66946007)(66476007)(66556008)(2616005)(4326008)(54906003)(30864003)(8936002)(44832011)(6862004)(5660300002)(86362001)(186003)(6636002)(316002)(6486002)(37006003)(38100700002)(478600001)(36756003)(31686004)(6506007)(2906002)(6512007)(31696002)(26005)(83380400001)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG1BbXBkSG92aWdybUFQUUp0V2s3Rlo0QWRoSmFWbUlOTktUbzhGY0JHYlJL?=
 =?utf-8?B?SlZLdWM2QVlWVDY3TzloTkI2VHY1ZkZCbjZtM0d6MExWZEoxK29jbnIwZnA4?=
 =?utf-8?B?dFE2NStsbEVFZ3IrRVF5emRMczI1NmFRanJ2bjV6SXBqK2xMTzJ3OXhBc1Iz?=
 =?utf-8?B?a1RKVjRydm52Vzg0UXdveEN3bnRVcVNxZG5IRVY0Ujl5Tlo2UEJpOS96aDVi?=
 =?utf-8?B?K1lLS0RMNWozL3hCaDJ0MzNNRkhJU05Xd1FzOWE0YlRpY3p1NXRzUngycDVu?=
 =?utf-8?B?YkZuUDE3dXhpVkQ2eGJUNmRGVGlnYWlsblo0NzczMEJKYWhzNys5MTdrenc3?=
 =?utf-8?B?cWtoY1VhR3BGSXBuWVBXeWdQT05LZEZvbGRxbEJ2NE9uZWVYaDFQQ05wamJw?=
 =?utf-8?B?M0RVbHRZL0ZwVE5hT245dXd2TndFWFpVakwybzV6SlNPL0RxMGZlWmNuek5U?=
 =?utf-8?B?bHkvSmZkSW1GYUNYT200UXZwdFJkR2UzVkFzcjlRY0hFUmlONHVudjVtb0FS?=
 =?utf-8?B?WUNLTDlKaVZNcU1QNFdvT0tSR1F3USt1aEJxcGJFOEdPTGp6VmJsem80Q0tP?=
 =?utf-8?B?dktoOUhuMzd6cGZ6cU5uNGNmYmd3ci9RdWlrQ0xROTdEeGNxOGlweS9HTHNr?=
 =?utf-8?B?MmRpb1AzZVBkamNKMGNFb05Kd3ptNDVUNVRMcnJOdDRzbDJnMndOVmNyaWlR?=
 =?utf-8?B?Zmh2TDNPV29pRS9pb0Z1TFQ3SUlDYmNyUFFEdUJ0dnJsbGU0OWR5WWxrYkVZ?=
 =?utf-8?B?T3l4eHAzZmtEc2hrWjNLUlFsNVRKY1RHVXVBZC9MNXp0UGhacERvTm9QRWJz?=
 =?utf-8?B?RndDSEdzenU4UUIyTHBibnFHZWlPVWdlVWwzcmlxc1hIYTBGb2JTUWF6NHZX?=
 =?utf-8?B?NlNMdTIxV2l6dGFOUUtROEJ2TVljNm9BeVgzZThTclpQN0JGdGRyN0o2NXkv?=
 =?utf-8?B?OUJWcjRpU3ZIUFU5cks1VUdjcEM3czUvZkdSaDNLWHFxMXozQWoxaHNjcVNv?=
 =?utf-8?B?MVdwVVcrbnRhQ0xPQ3FQQWZTb2Z3MkE3SXJRNzBxVTRlL0MrZ2NrR2NrQTBy?=
 =?utf-8?B?SDNnYUhmeGNOREhYQmtidGdIY0tWbzlNb2luT1I2QjZkTyt6VWVvdk1IbWVS?=
 =?utf-8?B?azhwTnBTenBZUmtRRHhkbDF1WWFSeTErQVFxOWVINDBnZ2h5b1Fma0x6MTRp?=
 =?utf-8?B?Y0orQ0dYZDhOSVFBbFpQNU1BaHI0OUZEajcybmdtR3MzdWdBWm9MYmIzbzRZ?=
 =?utf-8?B?Tk9pUjFyeGs4Y0RiVU0wUlJXRGYvdDdWZklUZnRId0Fzb1RwZHFWRHVTckZX?=
 =?utf-8?B?TFdpdmI0cU92OGRncHQrckNhV1NONTY4RitFd2x2bG81cU5lamo3Qys2cmJ0?=
 =?utf-8?B?VDE5U3c5NllDWm5KajRLeTZFZ05SYmNCMHA3bk1WVGpMVHh6OHhrbnJvMFJn?=
 =?utf-8?B?YmVkNDFpS3NtTlkyOHJtWlM3djZZNDNPaUhxV2VmaUNkajJPYnZva2dpakxi?=
 =?utf-8?B?azR6Sk1hVkFQT1E1VGU2RlZ2SVppRXUxY3NSdzh5cG1rNmNNWU1ySHlubDM3?=
 =?utf-8?B?SmdPekZuZlpXSzR3Z2pwSlRmT1JabFpmYUpxcHd4Sm9XZC82R0xCQlF2VEtS?=
 =?utf-8?B?UzFIQ09sdDFleCt4S2g3Q2dIM05rMGlsQzZMUjhMbURxMXdKa3MvTllEcXI2?=
 =?utf-8?B?S3RySWcvRThGbitBL3A4eHZ4S2wzMTVuSTZ4dCs5OWNhamY0MXNyWlBpN1Z0?=
 =?utf-8?B?eTNrZXNONmRXOVpobWFKSmxrOWgrS3Vpb3ZoN05NVS9LMkpYMG05TWY1SWFG?=
 =?utf-8?B?WHdZK1JsRG03d2hhSWNTRnZ6RlBDR0x0amJZS3JSMjgzQjdTOXJndWtseEdB?=
 =?utf-8?B?R05oTHNBZXVpZmJrd01XMkxQNDl0ZmNlVnNtQWgvcnpNTFk5OEhyb1A5dGRZ?=
 =?utf-8?B?RHpaa3d3d2JlRm9JZlFYMStocW1jcE8zK3gvRUlWa3dMZDBXNGdFdTVDZTR5?=
 =?utf-8?B?RkJKUUNPbjZIOWsxcXppL0g0TGphcyt0N0JQTlduVG1tcXpVMWRhenA2NGtI?=
 =?utf-8?B?TktVc1hsaE83dGEwQTJ0L28xS1F3S0ZjQXV0ekZsSXlXMmdxbEMxNm50MW5w?=
 =?utf-8?Q?TVE4OU0mb/VZ5plhvK7s5Kgov?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c4446a-93e0-4525-ff7a-08da6eb36903
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 03:03:26.7511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80ep9OPGnet0Dw828/ByjeMWN5e7J3I53MqY60w47H51/GKUgLcEVJtseyHRm7ADQ0Mtm2lSAl/L7Rb1rNGJjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3319
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-07-25 um 22:18 schrieb Lang Yu:
> On 07/25/ , Felix Kuehling wrote:
>> Am 2022-07-25 um 20:40 schrieb Lang Yu:
>>> On 07/25/ , Felix Kuehling wrote:
>>>> Am 2022-07-25 um 20:15 schrieb Lang Yu:
>>>>> On 07/25/ , Felix Kuehling wrote:
>>>>>> Am 2022-07-25 um 06:32 schrieb Lang Yu:
>>>>>>> We have memory leak issue in current implenmention, i.e.,
>>>>>>> the allocated struct kgd_mem memory is not handled properly.
>>>>>>>
>>>>>>> The idea is always creating a buffer object when importing
>>>>>>> a gfx BO based dmabuf.
>>>>>>>
>>>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>>>> ---
>>>>>>>      .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 99 +++++++++++++------
>>>>>>>      1 file changed, 70 insertions(+), 29 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>>> index b3806ebe5ef7..c1855b72a3f0 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>>> @@ -225,7 +225,8 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>>>>>>>      	u32 alloc_flags = bo->kfd_bo->alloc_flags;
>>>>>>>      	u64 size = amdgpu_bo_size(bo);
>>>>>>> -	unreserve_mem_limit(adev, size, alloc_flags);
>>>>>>> +	if (!bo->kfd_bo->is_imported)
>>>>>>> +		unreserve_mem_limit(adev, size, alloc_flags);
>>>>>>>      	kfree(bo->kfd_bo);
>>>>>>>      }
>>>>>>> @@ -784,6 +785,24 @@ kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
>>>>>>>      	}
>>>>>>>      }
>>>>>>> +static struct drm_gem_object*
>>>>>>> +amdgpu_amdkfd_import(struct drm_device *dev, struct dma_buf *dma_buf)
>>>>>>> +{
>>>>>>> +	struct drm_gem_object *gobj;
>>>>>>> +	struct amdgpu_bo *abo;
>>>>>>> +
>>>>>>> +	if (dma_buf->ops == &amdgpu_dmabuf_ops) {
>>>>>> I'd rather remove this limitation. We should be able to use any DMABuf with
>>>>>> KFD. This check was added when we basically sidestepped all the dmabuf
>>>>>> attachment code and just extracted the amdgpu_bo ourselves. I don't think we
>>>>>> want to keep doing that.
>>>>> This limitation here is to just reference the gobj if it is an amdgpu bo
>>>>> and from same device instead of creating a gobj when importing a dmabuf.
>>>>>
>>>>>> Please see my patch "[PATCH v2 1/2] drm/amdgpu: Generalize KFD dmabuf
>>>>>> import" sent to amd-gfx on March 16. I'm about to send an updated version of
>>>>>> this as part of upstream RDMA support soon.
>>>>> The "drm/amdgpu: Generalize KFD dmabuf import" doesn't handle the struct kgd_mem
>>>>> memory leak issue. Looking forward to the updated version. Thanks!
>>>> Maybe we're trying to fix different problems. Can you give a more detailed
>>>> explanation of the memory leak you're seeing? It's not obvious to me.
>>> The struct kgd_mem is allocted by "*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);",
>>> but it is not assigned to bo->kfd_bo like this "bo->kfd_bo = *mem;". Then *mem will
>>> never be freed.
>> True. With the current upstream driver there is no way this can happen,
>> because we don't have an API for KFD to export a dmabuf in a way that could
>> later be imported. But with the RDMA and IPC features we're working on, this
>> becomes a real possibility.
>>
>> Your solution is to ensure that the dmabuf import always creates a new
>> amdgpu_bo. But that can add a lot of overhead. How about this idea: In
>> amdgpu_amdkfd_gpuvm_free_memory_of_gpu we could add this after
>> drm_gem_object_put:
>>
>> 	if (mem->bo->kfd_bo != mem)
>> 		kfree(mem);
> This way will turn a imported BO(e.g., a gfx BO) to a kfd BO , i.e.,
> assign *mem to bo->kfd_bo. I'm not sure whether it makes sense
> to modify the original BO like this.

No. The point is that it won't. bo->kfd_bo should only be set for BOs 
that were originally allocated with KFD. Any import won't change the 
bo->kfd_bo. So the condition I suggested will be true, and 
amdgpu_amdkfd_gpuvm_free_memory_of_gpu will kfree the kgd_mem structure 
itself. Only the original allocation will use the release notifier to 
free the kgd_mem.


>
> The overhead is drm_prime_pages_to_sg + dma_map_sgtable when importing a
> gfx dmabuf from same device.

Yes. The dma address arrays are pretty significant, because they store 
4KB PTEs. I'd like to avoid duplicating those for imports, if I can.

Regards,
   Felix


>
> Regards,
> Lang
>
>> That way amdgpu_amdkfd_release_notify would only be responsible for freeing
>> the original kgd_mem. Any imports will be freed explicitly.
>>
>> Regards,
>>    Felix
>>
>>
>>> Regards,
>>> Lang
>>>
>>>> The problem I'm trying to solve is, to ensure that each exported BO only has
>>>> a single dmabuf because we run into problems with GEM if we have multiple
>>>> dmabufs pointing to the same GEM object. That also enables re-exporting
>>>> dmabufs of imported BOs. At the same time I'm removing any limitations of
>>>> the types of BOs we can import, and trying to eliminate any custom dmabuf
>>>> handling in KFD.
>>>>
>>>> Regards,
>>>>     Felix
>>>>
>>>>
>>>>> Regards,
>>>>> Lang
>>>>>
>>>>>> Regards,
>>>>>>      Felix
>>>>>>
>>>>>>
>>>>>>> +		gobj = dma_buf->priv;
>>>>>>> +		abo = gem_to_amdgpu_bo(gobj);
>>>>>>> +		if (gobj->dev == dev && abo->kfd_bo) {
>>>>>>> +			drm_gem_object_get(gobj);
>>>>>>> +			return gobj;
>>>>>>> +		}
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	return amdgpu_dma_buf_create_obj_and_attach(dev, dma_buf);
>>>>>>> +}
>>>>>>> +
>>>>>>>      static int
>>>>>>>      kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>>>>>>>      		      struct amdgpu_bo **bo)
>>>>>>> @@ -802,7 +821,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>>>>>>>      		}
>>>>>>>      	}
>>>>>>> -	gobj = amdgpu_gem_prime_import(adev_to_drm(adev), mem->dmabuf);
>>>>>>> +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), mem->dmabuf);
>>>>>>>      	if (IS_ERR(gobj))
>>>>>>>      		return PTR_ERR(gobj);
>>>>>>> @@ -1805,12 +1824,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>>>>>      {
>>>>>>>      	struct amdkfd_process_info *process_info = mem->process_info;
>>>>>>>      	unsigned long bo_size = mem->bo->tbo.base.size;
>>>>>>> +	bool is_imported = false;
>>>>>>> +	struct drm_gem_object *imported_gobj;
>>>>>>>      	struct kfd_mem_attachment *entry, *tmp;
>>>>>>>      	struct bo_vm_reservation_context ctx;
>>>>>>>      	struct ttm_validate_buffer *bo_list_entry;
>>>>>>>      	unsigned int mapped_to_gpu_memory;
>>>>>>>      	int ret;
>>>>>>> -	bool is_imported = false;
>>>>>>>      	mutex_lock(&mem->lock);
>>>>>>> @@ -1885,7 +1905,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>>>>>      	}
>>>>>>>      	/* Free the BO*/
>>>>>>> -	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
>>>>>>> +	if (!is_imported) {
>>>>>>> +		drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
>>>>>>> +	} else {
>>>>>>> +		imported_gobj = mem->dmabuf->priv;
>>>>>>> +		drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
>>>>>>> +	}
>>>>>>> +
>>>>>>>      	if (mem->dmabuf)
>>>>>>>      		dma_buf_put(mem->dmabuf);
>>>>>>>      	mutex_destroy(&mem->lock);
>>>>>>> @@ -2249,62 +2275,77 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
>>>>>>>      				      uint64_t *mmap_offset)
>>>>>>>      {
>>>>>>>      	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
>>>>>>> -	struct drm_gem_object *obj;
>>>>>>> -	struct amdgpu_bo *bo;
>>>>>>> +	struct drm_gem_object *imported_gobj, *gobj;
>>>>>>> +	struct amdgpu_bo *imported_bo, *bo;
>>>>>>>      	int ret;
>>>>>>> -	if (dma_buf->ops != &amdgpu_dmabuf_ops)
>>>>>>> -		/* Can't handle non-graphics buffers */
>>>>>>> +	/*
>>>>>>> +	 * Can't handle non-graphics buffers and
>>>>>>> +	 * buffers from other devices
>>>>>>> +	 */
>>>>>>> +	imported_gobj = dma_buf->priv;
>>>>>>> +	if (dma_buf->ops != &amdgpu_dmabuf_ops ||
>>>>>>> +	    drm_to_adev(imported_gobj->dev) != adev)
>>>>>>>      		return -EINVAL;
>>>>>>> -	obj = dma_buf->priv;
>>>>>>> -	if (drm_to_adev(obj->dev) != adev)
>>>>>>> -		/* Can't handle buffers from other devices */
>>>>>>> +	/* Only VRAM and GTT BOs are supported */
>>>>>>> +	imported_bo = gem_to_amdgpu_bo(imported_gobj);
>>>>>>> +	if (!(imported_bo->preferred_domains &
>>>>>>> +	    (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)))
>>>>>>>      		return -EINVAL;
>>>>>>> -	bo = gem_to_amdgpu_bo(obj);
>>>>>>> -	if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
>>>>>>> -				    AMDGPU_GEM_DOMAIN_GTT)))
>>>>>>> -		/* Only VRAM and GTT BOs are supported */
>>>>>>> -		return -EINVAL;
>>>>>>> +	ret = drm_vma_node_allow(&imported_gobj->vma_node, drm_priv);
>>>>>>> +	if (ret)
>>>>>>> +		return ret;
>>>>>>> -	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
>>>>>>> -	if (!*mem)
>>>>>>> -		return -ENOMEM;
>>>>>>> +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), dma_buf);
>>>>>>> +	if (IS_ERR(gobj)) {
>>>>>>> +		ret = PTR_ERR(gobj);
>>>>>>> +		goto err_import;
>>>>>>> +	}
>>>>>>> -	ret = drm_vma_node_allow(&obj->vma_node, drm_priv);
>>>>>>> -	if (ret) {
>>>>>>> -		kfree(mem);
>>>>>>> -		return ret;
>>>>>>> +	bo = gem_to_amdgpu_bo(gobj);
>>>>>>> +	bo->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
>>>>>>> +
>>>>>>> +	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
>>>>>>> +	if (!*mem) {
>>>>>>> +		ret = -ENOMEM;
>>>>>>> +		goto err_alloc_mem;
>>>>>>>      	}
>>>>>>>      	if (size)
>>>>>>> -		*size = amdgpu_bo_size(bo);
>>>>>>> +		*size = amdgpu_bo_size(imported_bo);
>>>>>>>      	if (mmap_offset)
>>>>>>> -		*mmap_offset = amdgpu_bo_mmap_offset(bo);
>>>>>>> +		*mmap_offset = amdgpu_bo_mmap_offset(imported_bo);
>>>>>>>      	INIT_LIST_HEAD(&(*mem)->attachments);
>>>>>>>      	mutex_init(&(*mem)->lock);
>>>>>>>      	(*mem)->alloc_flags =
>>>>>>> -		((bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
>>>>>>> +		((imported_bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
>>>>>>>      		KFD_IOC_ALLOC_MEM_FLAGS_VRAM : KFD_IOC_ALLOC_MEM_FLAGS_GTT)
>>>>>>>      		| KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE
>>>>>>>      		| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
>>>>>>> -	drm_gem_object_get(&bo->tbo.base);
>>>>>>> +	get_dma_buf(dma_buf);
>>>>>>> +	(*mem)->dmabuf = dma_buf;
>>>>>>>      	(*mem)->bo = bo;
>>>>>>>      	(*mem)->va = va;
>>>>>>> -	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
>>>>>>> -		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
>>>>>>> +	(*mem)->domain = AMDGPU_GEM_DOMAIN_GTT;
>>>>>>>      	(*mem)->mapped_to_gpu_memory = 0;
>>>>>>>      	(*mem)->process_info = avm->process_info;
>>>>>>>      	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
>>>>>>>      	amdgpu_sync_create(&(*mem)->sync);
>>>>>>>      	(*mem)->is_imported = true;
>>>>>>> +	bo->kfd_bo = *mem;
>>>>>>>      	return 0;
>>>>>>> +err_import:
>>>>>>> +	drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
>>>>>>> +err_alloc_mem:
>>>>>>> +	drm_gem_object_put(gobj);
>>>>>>> +	return ret;
>>>>>>>      }
>>>>>>>      /* Evict a userptr BO by stopping the queues if necessary
