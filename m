Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDE0C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 01:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF96910E032;
	Fri, 19 May 2023 01:09:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A423F10E032
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 01:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEvkBZCiZ3u13TvO8VR3cRNGdXXVMTSKhhi8BO4LJVtxo80ZTJBP62WxVnTy8JmR6fxotpCH3T98WQo1bQdXBNCCbGZwEH+VPQZyxxYVHSGjHaPknpNPFV12lEGRYOw5H/HysqrBIzHvvZU5dqcSSE3BSqR2KuLTaTGbv8Z7q4k4SDwFlXPcXAIJ1/36vA5lSjtrTHTrIInrT0PkobMOytuBLYXNQEQC+L0GSweKjncEFSZVZ4zSYVo1btBH/8A0GKk+wJWVoikvzJUlluCF5+MC+PyE07YNYvPZponP0Hnra1h7xa/ZNkLn2XvkE3ZSl3OuoEY39OF5/un5w9b+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNADz1hX4WADyolytkytpNFEDQEXY5pdgJVvxH+gfKM=;
 b=A9aM09QQ0pfmOgXZdzavsXGEZfD9XzSs2dypCtAht+bsBvHwCd23+wxkGKWmNgdoAqdTWaopU+z78hiqxkDe3vZ237k/7aRgiB9qe+Jnq1Ek0gG9lZVOy6rWkdOd6NXtKOia6xhJR+IO4yCdz/kjebcNFB2aAtoZ5xobB88Ge+Gxidr4zKTdz9RtcqWzJ5lKg89ycFzpNxUe2fZFKP+rr5YsFjNcezJZUyT9OSnNVrarBh8db+zumIbXubm55gNZZJ0leGB8/WlJV/0dR8YvygjBX2CM4uIOEvkD55K5p26E1AGquWWQzTAPASnym02c7UeFwIbn+8Y4it0gswVUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNADz1hX4WADyolytkytpNFEDQEXY5pdgJVvxH+gfKM=;
 b=pOVr7IJLvVAD1+eAACbX2/pQPDS9G1kTEZBG5qa+qLsBX4GIu0PELJtBMn5eAdjfhmTYeTfigcC38Bsc7HwVsfSVQ7A+UtOMsfjN1Uoc1IsbAuJiG7wF/hINVuSCh+0I6RSsrwxSxIeu6s2L3RV06cCbj92PBA/ZzCetSED0Shc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17; Fri, 19 May 2023 01:09:04 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::2ef6:2d8d:4a0:3396]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::2ef6:2d8d:4a0:3396%7]) with mapi id 15.20.6411.017; Fri, 19 May 2023
 01:09:03 +0000
Message-ID: <d9a0013d-642a-afb5-27de-93d085a796f2@amd.com>
Date: Thu, 18 May 2023 20:09:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdgpu: Add a low priority scheduler for VRAM clearing
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230517214040.539342-1-mukul.joshi@amd.com>
 <41e91d4b-7504-a431-d891-ac5e79c5b80e@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <41e91d4b-7504-a431-d891-ac5e79c5b80e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR07CA0119.namprd07.prod.outlook.com
 (2603:10b6:4:ae::48) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 534ff9a6-e757-40ac-4faf-08db5805a2f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QeJ96jauIqsaEsx0xwQhzkdb9HQdcTEQiugC5cWKJ9YZQ5X8GfkpKHbcI/3HBFsb0Vc5N0jI0Yn1S2MsLyWJ6+8SQduP4w6K4s0JQk94iUHr04nFZcIB4s9aKe+kqXIU3ZPNvHoAmMHXxgdgtn3bzzyRIIB+8/3jQvfqjOA2UR0JcjD4Z6uglsgGVzkYkLYbS45uruzt/WJgx19t9evotLQea0AaMZLq0jbuTK3e7Hs5rVfLP61zAtM71zXP782v/PlT0+ENH9WCwC010i+5OWHObRat+ZvepFiGz4GAEiISjOxttKE7wVO4rlbjESM96vuX/nnCL7+aOg1+e/WmcFlmpw6M6d1v+tBU6ke3jzxDgyRwEdvYQ4jp2yleK7REaFkD93REJtoin3JeLl4X/h9qiLJo45GLaHBcZjF0vHjv7D8xxqa9L3KsFGrYvPoqVwqwmxdi1Fa9Ol9u5PSliEj6oxDXIu3RICi6EwA2YVcWmToyyqWhuD0m+1g2lfTVO2a/82de9IlssHlW4B0W3a39ZzRIOv35EAdWwtzM9+X6PaduZd/snSHXlFAT2pRKovQ7IJPNbWo5DqnmBQfZTEeb1tBFaeuXq2Z9PGBWvCrPTknNvP3Y1+oE19q/oypyAmlM1Zl+r825nxJTuUCQ1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199021)(31686004)(478600001)(6506007)(53546011)(6512007)(26005)(2616005)(186003)(83380400001)(8936002)(8676002)(316002)(36756003)(38100700002)(41300700001)(86362001)(66946007)(4326008)(6486002)(66556008)(66476007)(31696002)(110136005)(2906002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3J1dGo0bFczcjdCSGl6bkVRWFFHQlYzckM1STVWSGx4Lzk1cHd1azRFRmN4?=
 =?utf-8?B?TjU0SkROa09GTVV6cDcycVNDM2xUb3VqZkxCanVUSFZFbnlNcXRsRjQzRU9x?=
 =?utf-8?B?ZTJQS0JBLzZ4d0h5c2hsNDQwWGxuRjk3aTRoR2UxNW1Pa1YxWTNVV2crQTBy?=
 =?utf-8?B?SUFhUU9jZmNacmMxcE9lWVVibCtiZ1lyTnVCaWRjUGFIREE5ZUNZTS9xa2Fh?=
 =?utf-8?B?NHluNmRVaW00Mk1ydTNjeUp0a2dyUjBmK0pQV3A2bWNucFFNUjhpNFRZcUNo?=
 =?utf-8?B?Y3A0b2xHK056dmp5NXVKaHZFQXBVdjBGZWJFQ25UellRK1o4Z1hHUHR2WUNV?=
 =?utf-8?B?V1ZQM1ZoNWhiSFl0WlhLdmlWcjBZN2htTmM5TklId29wZkxGSjZ0RjFVK1JX?=
 =?utf-8?B?MiszbG9vZm1vdXdFSFMyNGtOTmFrR29rckZEK1BxcmZOYXhYclRwNlFyVzdH?=
 =?utf-8?B?NHJnaE1oRzFORklZUUxRbk4wcHliWXJjcEhUaFJyZnhIQzI3QUl5bGhaTStB?=
 =?utf-8?B?Z2UvdEd6UnBQU21PbnUxSHcrYU9TMmZSU2lCaFM0Z05vSi9jaGZEVTVTa0sv?=
 =?utf-8?B?NXFCUjlFc2RscGZJdi9oNnVKQTF1ZmhhU09vVjRVK2Y2eHJST09JRGdqOG5P?=
 =?utf-8?B?SXA3TEkrNTRBRkwvQ0VHTHpZZWpoT1ZpaHZBSnNaSVlzeC9zTnBIN053NmxI?=
 =?utf-8?B?Nklab3JVOWJXdmlqZFZPOG92TDNmZjFScGh3NGRNdm5rcVcvUkVVdGR6aSti?=
 =?utf-8?B?dm9NYkZWYnE5NUlBMWJYZEtuQndaN3BFaUh1OEwvQTVrR2xjdXJkNXJlNU9E?=
 =?utf-8?B?V1dvS1plNnZYR1RROGt1NkRWWnpObzlxaEFxb3gwTFF6ZEFhNnBEQklmZGx3?=
 =?utf-8?B?b3lIQzlFNUJwWjRoYjJ1SkN0YWVtZmhpc1RzUzR2Ni96QzE1dDFzdHdvWGcr?=
 =?utf-8?B?R2NIc0pvUGl3dUxUQzNvNDhrdGhtNEw4Nk93RDI2cmdVUG4rbTlHMERkL25s?=
 =?utf-8?B?WkRvbEtQUVF0SVdDaWdKdlFIM2YxQmZsYU8wQWhTaVNKalRCNk1VSVVEd1R5?=
 =?utf-8?B?NHJ1dHgxSnJWS1FnQ2RDRkhFM2cyVGt4OE9QV0RwS1BrbUpsOWMwU1A5OWRr?=
 =?utf-8?B?Vkxsc0dGVDg1dVJoVE9OdUx1dCtsNlZYa2ZCc1Z6alRJdTNQTEtKc21GZHVh?=
 =?utf-8?B?L245WWo2dER0OElTSk90N1o2WEhiUUVSeFFpR3hZbHFXOVRKbHRMT3NkbW5H?=
 =?utf-8?B?K1J3T005OUpVTERlSVhKamZuS0k1N1o5RVpzTXh0WWMveVpGQk51aGNEQnFN?=
 =?utf-8?B?VGZST2pzbFQ4Y2pobTVKV1Nna1JneWFJK2tzeG1RNTdRSWRMb2ZITFpTOHFh?=
 =?utf-8?B?WjdmaUtvR3d5WlBseExvdTI4SWxLd2p6SG1Uc2Rac3c0MGU1R0RDYzBnTUhF?=
 =?utf-8?B?VWxNMVIva25VbVc2aEJvd2wwbEJHeUFISEtXZVZNZHFiVmxCYnFkd1JCS1dK?=
 =?utf-8?B?a1JrcHN4dVEwcCtleFpUWUxhQWlNSlBkam9qZHBEdUo3dVU0eStnQXI1SWVn?=
 =?utf-8?B?R0Q1UnQ0K0kwODR6NXdBUWx6ZHNJeW0wcEd5TG1vSzZUSHg2YjV6UXhJVEJv?=
 =?utf-8?B?WTYyUEZIWkt0QktBZk1xU2FUSG5DZ1cwdTRBTUNVK3B2Sm5lNnZkUjdMakFR?=
 =?utf-8?B?T0Qxdm5LMjhaenBYYlpqNmFTdWJKRFpjemdMQlB0ZlozYmtrdGhKOTVxWURH?=
 =?utf-8?B?dkFRcGV6VG5RdDExeGdhQzloS05IZndSN0NIOVljQURwZFBjdzhxNEM3cTJO?=
 =?utf-8?B?RzFhU2oyYk96UEt3aloxUzlFVDIwdFNlYTJSaGJWMUxjajJjelRodDQ0VEsv?=
 =?utf-8?B?ZnhnNFBnNDl0NklYS2dMeGRveVJXV0lLdHNFbnJndWZWZ0lOeEFKK0k2OW8r?=
 =?utf-8?B?emkyZ0poQ2JiM2JPQ2crQkQvZzJyMFgrZWsxSm4vUW1vRXd6WitaVlNTOFh6?=
 =?utf-8?B?dHhJVlRiWDFnbW5IZitlNVNzUmJSR3NObFl6Rk9KREd0eVg2RW1pQStQc2pi?=
 =?utf-8?B?Y0FiOHhYNzc3V0N2UjBaYzhLT2JFY0Z5OVBzVnN2RDhyNkxxaEdWcjhhdVU1?=
 =?utf-8?Q?DvMs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534ff9a6-e757-40ac-4faf-08db5805a2f5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 01:09:03.8032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5KDhK3QmI73PR8xfJNY3fIilSzNqOjcAYGYBIkpfphodBGKVbLKrvIHHvcrmSei
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 5/17/2023 5:10 PM, Felix Kuehling wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
>
>
> On 2023-05-17 17:40, Mukul Joshi wrote:
>> Add a low priority DRM scheduler for VRAM clearing instead of using
>> the exisiting high priority scheduler. Use the high priority scheduler
>> for migrations and evictions.
>>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 37 ++++++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  5 ++-
>>   3 files changed, 34 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 9924c8de57ab..46f249912b67 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -627,7 +627,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>>           bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>>               struct dma_fence *fence;
>>
>> -             r = amdgpu_fill_buffer(bo, 0, bo->tbo.base.resv, &fence);
>> +             r = amdgpu_fill_buffer(bo, 0, bo->tbo.base.resv, 
>> &fence, true);
>>               if (unlikely(r))
>>                       goto fail_unreserve;
>>
>> @@ -1354,7 +1354,7 @@ void amdgpu_bo_release_notify(struct 
>> ttm_buffer_object *bo)
>>       if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))
>>               return;
>>
>> -     r = amdgpu_fill_buffer(abo, AMDGPU_POISON, bo->base.resv, &fence);
>> +     r = amdgpu_fill_buffer(abo, AMDGPU_POISON, bo->base.resv, 
>> &fence, true);
>>       if (!WARN_ON(r)) {
>>               amdgpu_bo_fence(abo, fence, false);
>>               dma_fence_put(fence);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 34724b771ace..bbdad0dc1b07 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -384,7 +384,8 @@ static int amdgpu_move_blit(struct 
>> ttm_buffer_object *bo,
>>           (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
>>               struct dma_fence *wipe_fence = NULL;
>>
>> -             r = amdgpu_fill_buffer(abo, AMDGPU_POISON, NULL, 
>> &wipe_fence);
>> +             r = amdgpu_fill_buffer(abo, AMDGPU_POISON, NULL, 
>> &wipe_fence,
>> +                                     false);
>>               if (r) {
>>                       goto error;
>>               } else if (wipe_fence) {
>> @@ -2040,8 +2041,18 @@ void amdgpu_ttm_set_buffer_funcs_status(struct 
>> amdgpu_device *adev, bool enable)
>>                                 r);
>>                       return;
>>               }
>> +
>> +             r = drm_sched_entity_init(&adev->mman.delayed,
>
> I'm not a big fan of the "delayed" name. But I see the parallel with
> "immediate" and "delayed" entities in amdgpu_vm. We may want to rename
> adev->mman.entity to "immediate" as well to make the distinction clearer.
>
>
>> + DRM_SCHED_PRIORITY_NORMAL, &sched,
>
> I wonder if this could even be DRM_SCHED_PRIORITY_MIN to minimize its
> performance impact on page table updates and graphics user mode
> submissions. Either way, the patch is
>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> Thanks,
>   Felix
>
I think you may make it more general: not jut two drm_sched_entity at 
adev->mma:

struct amdgpu_mman {
....
  struct drm_sched_entity entity[DRM_SCHED_PRIORITY_COUNT];

....

}

then drm_sched_entity_init each adev->mman.entity[i] at 
amdgpu_ttm_set_buffer_funcs_status. So you can use adev->mma.entity[i] 
for different usage, like adev->mma.entity[DRM_SCHED_PRIORITY_KERNEL] 
for svm migration, adev->mma.entity[DRM_SCHED_PRIORITY_NORMAL] for 
buffer cleaning during alloc/free,  
adev->mma.entity[DRM_SCHED_PRIORITY_MIN] for page table update, etc. 
That will handle different buffer copies with different priorities, led 
to performance improvement.

>
>> +                                       1, NULL);
>> +             if (r) {
>> +                     DRM_ERROR("Failed setting up TTM BO move entity 
>> (%d)\n",
>> +                               r);
>> +                     goto error_free_entity;
>> +             }
>>       } else {
>> drm_sched_entity_destroy(&adev->mman.entity);
>> + drm_sched_entity_destroy(&adev->mman.delayed);
>>               dma_fence_put(man->move);
>>               man->move = NULL;
>>       }
>> @@ -2053,6 +2064,11 @@ void amdgpu_ttm_set_buffer_funcs_status(struct 
>> amdgpu_device *adev, bool enable)
>>               size = adev->gmc.visible_vram_size;
>>       man->size = size;
>>       adev->mman.buffer_funcs_enabled = enable;
>> +
>> +     return;
>> +
>> +error_free_entity:
>> +     drm_sched_entity_destroy(&adev->mman.entity);
>>   }
>>
>>   static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
>> @@ -2060,14 +2076,16 @@ static int amdgpu_ttm_prepare_job(struct 
>> amdgpu_device *adev,
>>                                 unsigned int num_dw,
>>                                 struct dma_resv *resv,
>>                                 bool vm_needs_flush,
>> -                               struct amdgpu_job **job)
>> +                               struct amdgpu_job **job,
>> +                               bool delayed)
>>   {
>>       enum amdgpu_ib_pool_type pool = direct_submit ?
>>               AMDGPU_IB_POOL_DIRECT :
>>               AMDGPU_IB_POOL_DELAYED;
>>       int r;
>> -
>> -     r = amdgpu_job_alloc_with_ib(adev, &adev->mman.entity,
>> +     struct drm_sched_entity *entity = delayed ? &adev->mman.delayed :
>> + &adev->mman.entity;
>> +     r = amdgpu_job_alloc_with_ib(adev, entity,
>>                                    AMDGPU_FENCE_OWNER_UNDEFINED,
>>                                    num_dw * 4, pool, job);
>>       if (r)
>> @@ -2108,7 +2126,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring 
>> *ring, uint64_t src_offset,
>>       num_loops = DIV_ROUND_UP(byte_count, max_bytes);
>>       num_dw = ALIGN(num_loops * 
>> adev->mman.buffer_funcs->copy_num_dw, 8);
>>       r = amdgpu_ttm_prepare_job(adev, direct_submit, num_dw,
>> -                                resv, vm_needs_flush, &job);
>> +                                resv, vm_needs_flush, &job, false);
>>       if (r)
>>               return r;
>>
>> @@ -2144,7 +2162,7 @@ static int amdgpu_ttm_fill_mem(struct 
>> amdgpu_ring *ring, uint32_t src_data,
>>                              uint64_t dst_addr, uint32_t byte_count,
>>                              struct dma_resv *resv,
>>                              struct dma_fence **fence,
>> -                            bool vm_needs_flush)
>> +                            bool vm_needs_flush, bool delayed)
>>   {
>>       struct amdgpu_device *adev = ring->adev;
>>       unsigned int num_loops, num_dw;
>> @@ -2157,7 +2175,7 @@ static int amdgpu_ttm_fill_mem(struct 
>> amdgpu_ring *ring, uint32_t src_data,
>>       num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
>>       num_dw = ALIGN(num_loops * 
>> adev->mman.buffer_funcs->fill_num_dw, 8);
>>       r = amdgpu_ttm_prepare_job(adev, false, num_dw, resv, 
>> vm_needs_flush,
>> -                                &job);
>> +                                &job, delayed);
>>       if (r)
>>               return r;
>>
>> @@ -2180,7 +2198,8 @@ static int amdgpu_ttm_fill_mem(struct 
>> amdgpu_ring *ring, uint32_t src_data,
>>   int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>                       uint32_t src_data,
>>                       struct dma_resv *resv,
>> -                     struct dma_fence **f)
>> +                     struct dma_fence **f,
>> +                     bool delayed)
>>   {
>>       struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>       struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>> @@ -2209,7 +2228,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>                       goto error;
>>
>>               r = amdgpu_ttm_fill_mem(ring, src_data, to, cur_size, 
>> resv,
>> -                                     &next, true);
>> +                                     &next, true, delayed);
>>               if (r)
>>                       goto error;
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 8ef048a0a33e..e82b1edee7a4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -61,6 +61,8 @@ struct amdgpu_mman {
>>       struct mutex                            gtt_window_lock;
>>       /* Scheduler entity for buffer moves */
>>       struct drm_sched_entity                 entity;
>> +     /* Scheduler entity for VRAM clearing */
>> +     struct drm_sched_entity                 delayed;
>>
>>       struct amdgpu_vram_mgr vram_mgr;
>>       struct amdgpu_gtt_mgr gtt_mgr;
>> @@ -152,7 +154,8 @@ int amdgpu_ttm_copy_mem_to_mem(struct 
>> amdgpu_device *adev,
>>   int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>                       uint32_t src_data,
>>                       struct dma_resv *resv,
>> -                     struct dma_fence **fence);
>> +                     struct dma_fence **fence,
>> +                     bool delayed);
>>
>>   int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
