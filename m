Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96248ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 15:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8ABD10E013;
	Tue, 30 Aug 2022 15:41:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618EC10E013
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 15:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEDgqEQO2nyx3Mu9HVsUVVIBt+PnfuyLF8Oixb+rWYKZ1dwiC4olFOA45cSKsn5TO3CGYm4tLVQB8QNwi4AMHgxc9r8NEsHNbtvR2YBhhg/LFQ6XXU3gNJcu8jhM/Srrqinsk6swmZ8o7hXFlIwJAydn/vlc3my7ziBuGFo5Vo11nFth0uRLrhAuE9avNrA0ehyd2U9IKAYpKpcLVu+lMKNY/sEzNk7AeZcZ/KkNyTpayRuCV+6Lse+qZGqn8W7xRMx6GgJ7d4k4be0GfqmkVH2WCY6uURryRHwQXsreUsmEt/uuWTGMj1cShgsQL7nOLQY/TxKKoZQ60APQzeQiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiP4AOelmSO/Cogz14NNgY3rJfbS1G/qPz74TOCY6u4=;
 b=Xr3ni5l/F4SMaDer9cD6iuMtl68CBcYCaJHc5CBfza01ZxX6npS1U9QPQfhAUnCc3QX/geowQ/cmi5p1zzOsb8T5URmiX1KohdGs5rzxUPwKezAXbSIMZJAs3fLhWR0lQw9S6GPmbrig9Lwd9XcxUiuXgbY564bmLuijaAytT2yk/J8XqlcQObaHA8lJfbcJfGIBhFhbsAQ+bWk/VfKZgDZzdzref9mKtDryR8SUZRBTuCJqAmtDMimVDYPmxnQeNFEVEJvN/mF/bra9gMn26kjW1L6ybhjG2F4JI1cfbHw/lDpvzH8FUAqWm3pUI4kfyxLlaTg70p6vqlfihqThIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiP4AOelmSO/Cogz14NNgY3rJfbS1G/qPz74TOCY6u4=;
 b=tnHXczpyQzydEc8ZzBZhE5dTuhADLsvuDGvJPqt9VOo1bDHaWiN6KXP78A1VQ7/8X1oolxz9ySSNE+qilIl4GWDdonQs9PsXCcZagzgbDskAvuORRmrDlJsuiSCGHesFtSvg2ikm0uvuxMdmcgBjKfbSPpLODSzIpFK/8KY4hoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 15:41:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 15:41:16 +0000
Message-ID: <d24789be-daf5-69cf-383f-611597eb1a0a@amd.com>
Date: Tue, 30 Aug 2022 11:41:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: Set pte_flags for actual BO location
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220826231654.335169-1-Felix.Kuehling@amd.com>
 <2707c040-2b99-8c48-237d-45dee65e8833@gmail.com>
 <09f808fb-908c-477e-5470-cdd75b539273@amd.com>
 <b349a15b-7ac7-4358-bbc2-d5952a891448@gmail.com>
 <5d877fee-ec7a-0c17-c72f-ca3569a3ef8b@amd.com>
 <c5e6912f-215e-8c6d-8946-b2a9bebd8668@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <c5e6912f-215e-8c6d-8946-b2a9bebd8668@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:208:32a::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0949f663-3a72-4090-6bcc-08da8a9e13c1
X-MS-TrafficTypeDiagnostic: LV2PR12MB5920:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzheESKJI3QQorpJ4MnHGrozzTT7m04mJQOE9iZCiL+Y+aoQ2mWOiafZi/9kkgiZIrHIJ1u1yz/YYot6Pu1QWf53Yj1Mt9SOp6pmeG6Dtn1LbbfT0Pz4y7VtARuBaMuJvShP9PQd5fl/9J03yFsclyNDUup1Umxn70IntRMVsx0RqHAA5iChLEvDM1lKqxPIJFwnrd1KQPTuBuSklyiBmVoFzuwMs0JFiucP8SEEy5ofsYOvU2jxFAUfugdtHgcxdwGHoeD7AVQfWiUTeW9skx0sIF1qgsWSKybHgGlSOMhGcNL1Fh2mQAWqb3JdeVg+FgfzPfCifGhfqRWwLBKoO5u3WRC9sMBuGccuVKzzdxAdX66auYVdjQ3IKnCMviQCXfmnVIPqLQuddUlJP4Ey5T+ABDKYGWnN6wPiPJdBqT1uwjsV3zUV/VkD911Py73qAAV6y/7kia3VGYNkta515zhzkizVLI5TcO8f5pnmzGS69GvfhuWuviBxUEqLGhTNlWB8txI85J4aVpauptkhG6zvKSSTEO4GY5zBuv2DOn7kO1Q2bJG3QGUwDNV0fusvWVgxMKE0v1zFNK2WpdVhfNlnckK4UMAMY0ttnM3Po4A/2r5SEx3QPJi2B4lr0NwyFiq1tHpqICkjn5Z0gakmXr61TbYMUt7EzE9XLlFbryzZAfITLkvqjEsn9Y1vp9fjO0V1BB2zBeZTCs6FmmrAqZ7HEuBFlG/hd3LQAnIkaFm1nq09NdBJcnlBil89ECgcQNvKWkCjSaANE74wk9FpE3oZrycD8lOvk8DHjp3EIZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(66574015)(53546011)(6506007)(2906002)(44832011)(2616005)(36916002)(83380400001)(26005)(6512007)(186003)(38100700002)(31686004)(86362001)(8676002)(66946007)(31696002)(66476007)(66556008)(6486002)(316002)(36756003)(8936002)(5660300002)(41300700001)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enpwbFFRd2ZWSnp5L1J1eXh0VHlMMUZ5bk4wc3RSb1pNOWNoZG9xZTJSZTYv?=
 =?utf-8?B?UGhsVnN2aXZXZnJ5b1ZuZHVkOTJCTW1zUDZPOFJBVEdZYm5SQ3NReFduazhm?=
 =?utf-8?B?MXRNbEsvRVBZMkx6ZExOZTMwdFFOSHUyd1dnUDM5WFZPYjB5SjlPeVRFTjhN?=
 =?utf-8?B?cEpQM0d3aDEwK0lhUHNKMzVtU25yd2FCZ3dMU3gxK3FQTENDRHVFOFVObGVz?=
 =?utf-8?B?YTV6TWs1cTc4NCt3T3JoYWpMdVpmLzhoL3VXZ053eVNLaytlMGw0YmJWUk1v?=
 =?utf-8?B?M1RXbWlySk5nYW5adEhMV1c4cU02OW83OXBYQXlmSE5YbCs1ek8remkyV2x6?=
 =?utf-8?B?ZlFKMy9KajNicGt3NHpKT1d3V0RSSUZqN09GK2RCY3F6bFVQa0hzUDVzSGEv?=
 =?utf-8?B?c2tIdkRDTGs2OEllNmhCVW80RUcrZ3doZm1XdzJVc0pmNDM3dnkraFBiUDBq?=
 =?utf-8?B?eDd1MmplRC9KMFg1NUU5OVVhSysvMHhPL3ZwakhIVG41MnZ6WmFocnBMRUVH?=
 =?utf-8?B?QktNLzJrREdJT3Y0Z1RFWnhBOE9BOUEzQVpvQ1F2cEZuSzBnTEtTdVlMNVY1?=
 =?utf-8?B?NnVFU0JjSElOV0RsZFlUS05lYjJHTG1DZVB2SlAyeUk0NEJPd1pqcGpRazdq?=
 =?utf-8?B?TkR1MlpVY29wQXN3M1dZdWNPTFNiL05UallxWEFxRWxocHo1UlJHZDRpZEVN?=
 =?utf-8?B?SVdoRHY2anNqY3Nya1NtY05FTE8zRzhvZjJkNFhDbVBwWm5NVlkxYlJwSWpD?=
 =?utf-8?B?MTZuREVNcHM1Q3B3eG1XakZld25SSW9HYlQyZHVCK1J1V2ZwSkdBMWVlRkx5?=
 =?utf-8?B?NzVKTllxZ0VDV0htcmt1SllhbUlDV2NhZUw1cXVlT2FwYk5lS0hoUnBjZWg1?=
 =?utf-8?B?RDBrUzRRSVRLMTF4em9vUHFRWmVrQjFhSlFoWFd2QmRmZUphNU1GVjBYelp5?=
 =?utf-8?B?MzM2eDNrY0drMHRDUGp6ald3bDAzaGZDQkhTbTRHMmpBTUlZUDYxUzQ3a2Ix?=
 =?utf-8?B?bXVYWEpuVHdFVlZjODByOU02SWdiSHNFankxdTcxVm4vWmxzVWhzaERxYnNt?=
 =?utf-8?B?YnRnZnNVeC9PbEt1UHpsL0FXYjRkODcxODc1dGVwTDJSRkkrYWFtRC9CdXZp?=
 =?utf-8?B?akk3VGMzSGxDVmNMdnU3amd5cFNNbEJSTmNoU2kzZ0VtTU1KS3R3NHZJZjNK?=
 =?utf-8?B?WlNualo3blhTRy9ka1RPVDQyeEQ5aEJ4WldKRThOUVhYeHdxK3BvRm5XWUox?=
 =?utf-8?B?aTRPeHhqNmdhV25pbEc3aEoweEp5L2lmSFBPbFNDY1VzTUJqNmF1alFEdkh0?=
 =?utf-8?B?bTgyY0grZDN3RFIrZ3FRL3RQUHVFMFdpQVRqcEV4aWJ4a1VUczA5S09nbDdl?=
 =?utf-8?B?ZThZZmdXcGpqNzlTWlVwRXJZT3I4VUd5MTNBM2xiaGhVY3BNT3Y3TTB6dXFm?=
 =?utf-8?B?cG4rLzBCd1Z6TGcxMWl0VFNtY0dVODl4VHM5NitqS1hzREdRYmFVcnlZR1Nu?=
 =?utf-8?B?M0dYV01FN2E5YmRKTUVabGZ2d3NGU3I5cFZTY2VpMWVzekFqcndQc2Y1LzVj?=
 =?utf-8?B?Z1VQUXBwSzlxSmNzVzViV2Z1M1lTd3RDK3VKNFY5MVFTKzdnYS8xZ0hGOTlH?=
 =?utf-8?B?TVZpc1pYOWphRXJiV0RiaWo4QlhrL2JpclB3SUh1OTllRCs0b1NPd0JmZURT?=
 =?utf-8?B?S0tjRXFqWG14cTVhVHA5U2RwNGQyZFA1LzNIeCtBdWF0bFBVT1BITG1selZ0?=
 =?utf-8?B?OWVMMC9COU13SFhzZ2h1SEJpM0Z0Tk4rcmZkKzkxZGtUNlhVcXE1YjFDT2dI?=
 =?utf-8?B?cWFrSVFHYmxqOTNMZ1Vxa1NBWkZpNFl1U05UR0k2SEs4R3RNUCtJRGEyOTBs?=
 =?utf-8?B?eDVwclZlUnM3S1EzY0k1aWtjN1h2TjBSVGZ5amk0SzJDVll1N2hhcW5ZVEU1?=
 =?utf-8?B?OEs5bm9NVUZqeldpOS9ZeHJuQmJrRVk5Zm54K0l4YUFjSFhlSVg2ak8zVzNl?=
 =?utf-8?B?cHJ4TW10bnNocUtwSnlSL1ZFT3VKTGxtOEFXQ2hvMlBZcmUrdUdQUFhkZ3V2?=
 =?utf-8?B?SGE5QXJJR0hBcFNPZ1dFNUp4cGcvVWcyK2JlMm91MmlQNUZtdExkNFd5WDlQ?=
 =?utf-8?Q?d0Q0jZnPL4B9ydUTC5priNF0/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0949f663-3a72-4090-6bcc-08da8a9e13c1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 15:41:16.8817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCTpaDAOwXvHR7Rk5FjtWw9e3OBTSb1EoOx4u7Ej0//FoMuKRzcwHsWgy9Yapkl30qhp6Cv9PjkYZjxn5+xv3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920
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

On 2022-08-30 02:00, Christian König wrote:
> Am 29.08.22 um 21:30 schrieb Felix Kuehling:
>>
>> Am 2022-08-29 um 14:59 schrieb Christian König:
>>> Am 29.08.22 um 18:07 schrieb Felix Kuehling:
>>>> Am 2022-08-29 um 11:38 schrieb Christian König:
>>>>> Am 27.08.22 um 01:16 schrieb Felix Kuehling:
>>>>>> BOs can be in a different location than was intended at 
>>>>>> allocation time,
>>>>>> for example when restoring fails after an eviction or BOs get 
>>>>>> pinned in
>>>>>> system memory. On some GPUs the MTYPE for coherent mappings 
>>>>>> depends on
>>>>>> the actual memory location.
>>>>>>
>>>>>> Use the actual location to determine the pte_flags every time the 
>>>>>> page
>>>>>> tables are updated.
>>>>>
>>>>> For a workaround ok, but looks a bit awkward. Basically we need 
>>>>> different MTYPE based on the location, right?
>>>>
>>>> Yes. On Aldebaran and Arcturus we need different MTYPEs for 
>>>> fine-grained coherence depending on the location.
>>>
>>> It would be much cleaner to have a better description how all this 
>>> came to be in the mapping.
>>>
>>> E.g. that we generate the flags in the VM code based on the 
>>> requirements described in the mapping.
>>>
>>> Do we have time to clean this up thoughtfully?
>>
>> Currently we have two places in the KFD code that generates the 
>> mapping flags. I was planning to eliminate the duplication. I think 
>> you're suggesting moving it into the amdgpu_vm code instead. 
>> Unfortunately it's somewhat GPU-specific. So you probably won't like 
>> this code in the general amdgpu_vm code. Maybe the HW-specific part 
>> should be in gmc_v*.c.
>
> We have the gmc_v*_get_vm_pte() and gmc_v*_get_vm_pde() functions 
> exactly for that.
>
>>
>> The requirements would include:
>>
>>  * Memory type and mapping (local, system, PCIe P2P, XGMI P2P)
>>  * Memory model (coarse-grained or fine-grained coherence)
>
> Question is if any of this is a per BO or per mapping information?

With XGMI, we are sharing the same BO between multiple GPUs. Local and 
remote mappings of the same BO can be different. I think a per-BO 
attribute to decide the memory model makes sense. Then the mapping code 
needs to figure out the flags from the per-BO memory model and the type 
of mapping on the fly. gmc_v*_get_vm_pte() seems to have all the 
parameters necessary to figure this out.


>
> For the gfx side we unfortunately have put the MTYPE into the mapping 
> (which turned out to be a bad idea).
>
> So as far as I understand it the MTYPE should rather be obtained from 
> per buffer flags and the current placement, correct?

Yes. I can work on a patch for that.

Regards,
   Felix


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
>>>
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>>
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>> ---
>>>>>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++++++++-
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 19 
>>>>>> +++++++++++++++++++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 +
>>>>>>   3 files changed, 28 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> index cbd593f7d553..5dd89f5a032f 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>>> @@ -405,6 +405,7 @@ static int vm_update_pds(struct amdgpu_vm 
>>>>>> *vm, struct amdgpu_sync *sync)
>>>>>>   static uint64_t get_pte_flags(struct amdgpu_device *adev, 
>>>>>> struct kgd_mem *mem)
>>>>>>   {
>>>>>>       struct amdgpu_device *bo_adev = 
>>>>>> amdgpu_ttm_adev(mem->bo->tbo.bdev);
>>>>>> +    bool is_vram = mem->bo->tbo.resource->mem_type == TTM_PL_VRAM;
>>>>>>       bool coherent = mem->alloc_flags & 
>>>>>> KFD_IOC_ALLOC_MEM_FLAGS_COHERENT;
>>>>>>       bool uncached = mem->alloc_flags & 
>>>>>> KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED;
>>>>>>       uint32_t mapping_flags;
>>>>>> @@ -420,7 +421,7 @@ static uint64_t get_pte_flags(struct 
>>>>>> amdgpu_device *adev, struct kgd_mem *mem)
>>>>>>       switch (adev->asic_type) {
>>>>>>       case CHIP_ARCTURUS:
>>>>>>       case CHIP_ALDEBARAN:
>>>>>> -        if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>>>>>> +        if (is_vram) {
>>>>>>               if (bo_adev == adev) {
>>>>>>                   if (uncached)
>>>>>>                       mapping_flags |= AMDGPU_VM_MTYPE_UC;
>>>>>> @@ -1236,12 +1237,18 @@ static int update_gpuvm_pte(struct 
>>>>>> kgd_mem *mem,
>>>>>>   {
>>>>>>       struct amdgpu_bo_va *bo_va = entry->bo_va;
>>>>>>       struct amdgpu_device *adev = entry->adev;
>>>>>> +    uint64_t pte_flags = get_pte_flags(adev, mem);
>>>>>>       int ret;
>>>>>>         ret = kfd_mem_dmamap_attachment(mem, entry);
>>>>>>       if (ret)
>>>>>>           return ret;
>>>>>>   +    if (unlikely(entry->pte_flags != pte_flags)) {
>>>>>> +        amdgpu_vm_bo_update_flags(bo_va, pte_flags);
>>>>>> +        entry->pte_flags = pte_flags;
>>>>>> +    }
>>>>>> +
>>>>>>       /* Update the page tables  */
>>>>>>       ret = amdgpu_vm_bo_update(adev, bo_va, false);
>>>>>>       if (ret) {
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> index 59cac347baa3..954a40d5d828 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> @@ -1862,6 +1862,25 @@ void amdgpu_vm_bo_invalidate(struct 
>>>>>> amdgpu_device *adev,
>>>>>>       }
>>>>>>   }
>>>>>>   +/**
>>>>>> + * amdgpu_vm_bo_update_flags - Update mapping flags of invalid 
>>>>>> mappings
>>>>>> + *
>>>>>> + * @bo_va: identifies the BO and VM
>>>>>> + * @flags: new mapping flags
>>>>>> + *
>>>>>> + * The update is only applied to invalid mappings. This allows 
>>>>>> updating the
>>>>>> + * mapping flags after a migration to maintain the desired 
>>>>>> coherence. The next
>>>>>> + * call to amdgpu_vm_bo_update() will apply the new @flags to 
>>>>>> the page table.
>>>>>> + */
>>>>>> +void amdgpu_vm_bo_update_flags(struct amdgpu_bo_va *bo_va,
>>>>>> +                   uint64_t flags)
>>>>>> +{
>>>>>> +    struct amdgpu_bo_va_mapping *mapping;
>>>>>> +
>>>>>> +    list_for_each_entry(mapping, &bo_va->invalids, list)
>>>>>> +        mapping->flags = flags;
>>>>>> +}
>>>>>> +
>>>>>>   /**
>>>>>>    * amdgpu_vm_get_block_size - calculate VM page table size as 
>>>>>> power of two
>>>>>>    *
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>> index 9ecb7f663e19..11793716cd8b 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>> @@ -413,6 +413,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>>>>> *adev,
>>>>>>   bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
>>>>>>   void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>>>>>>                    struct amdgpu_bo *bo, bool evicted);
>>>>>> +void amdgpu_vm_bo_update_flags(struct amdgpu_bo_va *bo_va, 
>>>>>> uint64_t flags);
>>>>>>   uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, 
>>>>>> uint64_t addr);
>>>>>>   struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
>>>>>>                          struct amdgpu_bo *bo);
>>>>>
>>>
>
