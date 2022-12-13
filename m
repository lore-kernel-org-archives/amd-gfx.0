Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F535C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Dec 2022 12:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10EE110E1B8;
	Tue, 13 Dec 2022 12:41:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA7EB10E1B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Dec 2022 12:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5V9UenmRjbtcmiRvPkk4AHkk8RHn0BCWFjI/41K3bL3IHC21BmSFDqVP+90N0id7JBTUTymXq6oDdcWbJxRlkM/RjeswpKkmoFIRv1WFCaAi31qMBUzM1JapZ1moeEqRiY7CE+gcY2cFHHLdAifNweM9poSPqvUbdTjew4X/B1lBxsTzjN8zu+FQTvkeZRLQRcDt9D9um0ENRmSeBukh0lmo29pWbW+uxFJoJ4eWql1mIAKPbx5CvXMXepUqmGGAfi/P8gVZUkRvwfltIThiayLtKn6tfdatHUqUYbg0KEHnNacnJRBBXvdrx2aMyYCwi3L2tbUv2J89nGNqJ8VoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWEPTFQMZoS58An9eZlENKp6VBBMn9rh7FY9JEWQ6y0=;
 b=UZAbiKFxxg+GnhmW0uQXIw9TFnxI1ryI8EqV6uzCVGfy8U4B3N07UxCsyBiXCqza+YZhsByp8hqyOZuq1n2PABO1sMGqIzVxEn1QV/fkcYcBRc4guPtMAYVZ0L4B2thCSo3YhZrSSejSpzAyA61CnjyJkRGsEgX4MRhHe+7NJThTk114LDYou34uokPWOeWYOsE7akB7xK+/AR6ngWkj1jowUwDR+MXxmvf+iAV+9j4wTz0MeZd65z2pztny8NUBBEQvmUdSSyoqggGgYQUHL8qseY06DzJyP/BkaNHritdxa9ewTnpNwJC2Q84Tr+lI2sPDXhgW/74aSE/JEmpYRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWEPTFQMZoS58An9eZlENKp6VBBMn9rh7FY9JEWQ6y0=;
 b=ndLwb1LdStKHbFuvskaU6WZtweIKtuW0vRFphTz6Yl1TV0u1VtQb7JcGiUGmp/pQ3a+GEmTgDu+syNgFr5jH+CyvCOtlZm+AhrVQxc5EKtR7nuVS/4hBafQxlzIJaxMXCXZRDLTinnk4oWfm7PuyD8QloX0jE+nI7dxdG7ItCIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 12:41:13 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bc0:e01b:6da0:9f24]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bc0:e01b:6da0:9f24%4]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 12:41:13 +0000
Message-ID: <4144e247-0f58-f1da-a14c-e2dc24d0c010@amd.com>
Date: Tue, 13 Dec 2022 18:11:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] drm/amdgpu: Fix size validation for non-exclusive
 domains
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20221210092419.16548-1-luben.tuikov@amd.com>
 <20221212174834.36544-1-luben.tuikov@amd.com>
 <802b6283-d015-eb67-18fd-cba6fb03c96a@amd.com>
 <fe09407d-9057-879b-be61-3bfbe74846db@amd.com>
 <9e14bcd5-a911-c430-a474-4f43daf44283@amd.com>
 <e86f5bef-24a0-0eaf-7971-563285714399@amd.com>
 <78758ba9-27db-4314-9e6d-101c11c669ca@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <78758ba9-27db-4314-9e6d-101c11c669ca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e2e2e3-dce8-4d19-8f7f-08dadd07519f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvyU79s8VVz8H0b1wO6xDVSj0KKIN8bBL3zDguPYKbqqOtnq+m2kNfwAW7J8B8ze9bNDWGkkD6EETzRcc3zZZiGyebKDv13of4fiXsrLUpXzXSkwgACHVvRJJl/8Tx2XJnSvpqJFTnz8Cm582Q7v6uB0F80uxSj4iQg9zhCPDz/uvVVpyzi9T3PWYIxUNfMmU7VWY5LqzFsM6dZNJF/f8DWEzQ8tw02mzDrO5fNojLFmy6ztU7OfBfqtJeEMA/3gR+GDQwMgpI0CSAP0myfn8Vxq2NLidX2vS3a5xAE5+FbAQQbJgGKjr9CS/dF9XA3JRI83mhwR366UBdQlyrC7tDXOwcDLBDWlqidJLd7hNGl3kW5Xj3fxyA+q3p6f/wvqRAyL4vcjVlW0V2K1pgkB1mRTvvpir3A+jH72UvkRoQcm0WQclJH5m06HZsBRf9Aa+R2aQnvIsbYQ6vFnvgFhOHQoZCaDBZvJ5JULgNbPAahIv94MctI/5cOWoiFV5LBxVAFQiw5jxTLtxUapOkex8fgzZTKvgsmDZ2kgyUXxrtUXwXypC24544k/iNFoIUSePZwL/84bhd/2/4ojo52o0am8wztCTElZwqO7vFsuyX5w1ZMY0+rHrBJUQJLnmS3ryMXWnDPkL9RwDZjSymJuphQ7BaHGnuYHxoVijly2kAD5p7+FqzywLFPiJNE31jxA1F+G46rs4Mz7IbVZJHFoHvN/h/MrozXNCueolC2DC6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(31686004)(38100700002)(4001150100001)(2906002)(5660300002)(8936002)(36756003)(41300700001)(66946007)(8676002)(66476007)(66556008)(83380400001)(316002)(66574015)(478600001)(186003)(2616005)(6486002)(6512007)(26005)(53546011)(31696002)(6666004)(6506007)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjZ3KytTbjlEdFRTR1Q2VENpcU9SOFJXY0NrMDJjZ1c4aXdmald2dzhpNEg5?=
 =?utf-8?B?cUIyQzlnQjJHN2l5ck1LUzVuLzY2elpPZlBveStRMXQzUkU0Rm0wOWFLa29M?=
 =?utf-8?B?d3c5Smh2R01OWmhEazFuSG0wYWdmdWw2YURxT0Njb28raDJtcldOaTlyU1Mx?=
 =?utf-8?B?THhRQTV2L1Z2bWNsYzMybkxRamVPZXU4SlRPVGFoWnd1NDNtWlFxZ0xHS1FK?=
 =?utf-8?B?ZU44VWhEQ0YrU3RwZ3R5T0pnMnZCaVc4L2R4SWRycVVmdXkxWjg2NU41d3ph?=
 =?utf-8?B?VXVCdlFGNHpnVk5KcVhQdStTVmVFNDB3dk5NT1hzdXZhQi9WTkFZUE54eDZH?=
 =?utf-8?B?MlhDYmllWGc4N3h1cG1FZ3ZBcjRBM1N6dVVobjZIWVdnSHJIbDF6WDZvaXR1?=
 =?utf-8?B?K2x1YzBvU0FuK1gySDcwdmhVYTdaNEh4VHQxNU5zb0tCWStVdmZPVmEzb2g5?=
 =?utf-8?B?dXdDVHdycmYwQnhFTEZIS1FGbWdFUExRNlp5VnZOZmV3MGFFelBER2loK1pX?=
 =?utf-8?B?RGJ2QXgyUHpETFdFVlNjTzZ1SHE5VkoyVXY5bWpQeldZTHFYVmlNWExNdWhQ?=
 =?utf-8?B?dVI0aXRaUmpIM2VaTFlsNUV0dFZJRlZLekNpTHlxbFVmQXY4WitPRmIzaS96?=
 =?utf-8?B?MXdzUVo0cFpqM3dBay9RaVduVis3Y1UxSk1Fc3VHbWFmYlRQRGRZKzNwbzVz?=
 =?utf-8?B?Qk5ZejFZM2hheVBWQ1ovTU01ZHo1SWJSbGJZSDE1SmFqRGRXd0RaRlg2ckcy?=
 =?utf-8?B?NmFoS0RNemZENW80VThTQWhJYkFBL0F0MTZKKy9mK3BZMElkWloreTdtUzFa?=
 =?utf-8?B?dmxub2NGbE1yMUZHMWxXTEROZTN3REJaY2Jub2h4UFdCaXR1S1ErWGpSSEh1?=
 =?utf-8?B?U2NxMVMvVnRWamhVdEVNZWhVOE5OWXk3Y0FBMWFZNnJRdTNBd0o5RWdkVUd3?=
 =?utf-8?B?UG44MkkvcmQvSkhpMnJnWlEvcHZZQk0wYlhnSU45UUY4NGVWK3UrTVF3U1Fu?=
 =?utf-8?B?KzgzakpaOGxjcG1rZG1tQ3NqSEJOemw0Z0J2cnVJMFdjOGxWNHk0N3ZwZFFL?=
 =?utf-8?B?b2pTRTM4VjZQaytQSjdXUGVGbzRwSzZLTHBGVjZUNTU3WFpOMkozMHRsM3c1?=
 =?utf-8?B?WFIzZ3Y3a0N1SEJDWS9SOTFxbHZOMnMwdGlYMFc3aHZZWjl6R0tLWXBCTTNX?=
 =?utf-8?B?RmZaTndEQmlJL0V0d3o4b2dTdERyblpkR3kyeC9ERlpMazdmVzN3SzJkM1RP?=
 =?utf-8?B?QzJpKy9qcXFxK2lOQzNRSXVUYUhRUVVhNStTU2lKeVppMUNUM1diZi9veFJG?=
 =?utf-8?B?QXFUSjBBM0lUM2piREJ4R21RbmNmdk96UVJncFZqcTNyK1UvcDZ2alk3MjBB?=
 =?utf-8?B?RVdQTFB6UmxNd3U0eDBTd0RUNVg4aFRTT3J3M1VnMHZ6eTlOS3h2ZVk0VFpq?=
 =?utf-8?B?cFR0bjdpQzFwVmt4Z3ZTTEVUS0xaclFlY3prNGxqT1lmRzJ6bkNHMG16VitV?=
 =?utf-8?B?MlIzWUJaYlBCc2oxeDZYdUdqMUJ1RkZsdUtkUWoyb2h4ZFBZVFpWWU4xaW5W?=
 =?utf-8?B?YkIwVWFBazJIeXFsVlV1ekkxYzFlS0p4NHMwaFNVT0xqaWZ6dmVQQ1F0K25W?=
 =?utf-8?B?NUM2TTJBZXdiSm5mWVpiU1p2WWZnOWtlZ1czRndDKzV0T2dzc2g2QzNMdXBR?=
 =?utf-8?B?ZkZxdm1EcFFWY0E2ZVk3NFNOMGRLT1pXVGtaS2E1UjE0NjBYaDhpY0lrZTBX?=
 =?utf-8?B?NnFGSWlhbFRMTnAya1o1dGpVbmk4TjBERFpDSXltVUZWWlZVYnU1VjRrekJS?=
 =?utf-8?B?bld4SldxTEpBMm0zM3d3Tk9uMDJCUW9JcVVpbm5UVmFKOVhOSkxXQktlcHA0?=
 =?utf-8?B?VTU5R1RyY3RxTWJSamhBV1VFT1J3bU15SEhrTHB4MWVBTitKb3M2R3ZBL082?=
 =?utf-8?B?WmluZDNUWllscldUazZZU0o3UFJPVGJQTURFa3JuRFdQTFRnSkRkR1NYb1g3?=
 =?utf-8?B?S0h2bnBtK3RnNDdxemlWUjNmME5QdUhzYkRVdGwyZkRDS2Rwd0U1dWNUdjls?=
 =?utf-8?B?a0MxbEFoWnBoRHQyR3R1bXR3QlZYYlNuNW40U1Z0SjZFVStTRGRNQVI2VEZt?=
 =?utf-8?Q?0A0B2/mYL5jBfl9KKZYoVce9e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e2e2e3-dce8-4d19-8f7f-08dadd07519f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 12:41:13.3704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GprrTCWvc6KBxh6hieXxh/OZ71ID4yyeacQcWVOK2rKB4wwudEuotO8RlQ3gzLap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
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



On 12/13/2022 5:22 PM, Christian König wrote:
> Am 13.12.22 um 12:40 schrieb Lazar, Lijo:
>> On 12/13/2022 12:30 PM, Christian König wrote:
>>> Am 13.12.22 um 00:44 schrieb Luben Tuikov:
>>>> On 2022-12-12 14:19, Christian König wrote:
>>>>> Am 12.12.22 um 18:48 schrieb Luben Tuikov:
>>>>>> Fix amdgpu_bo_validate_size() to check whether the TTM domain 
>>>>>> manager for the
>>>>>> requested memory exists, and to allow for non-exclusive domain 
>>>>>> allocations, as
>>>>>> there would be if the domain is a mask, e.g. AMDGPU_GEM_DOMAIN_VRAM |
>>>>>> AMDGPU_GEM_DOMAIN_GTT.
>>>>>>
>>>>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 
>>>>>> +++++++------------
>>>>>>    1 file changed, 7 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> index fd3ab4b5e5bb1f..e0f103f0ec2178 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> @@ -448,31 +448,26 @@ static bool amdgpu_bo_validate_size(struct 
>>>>>> amdgpu_device *adev,
>>>>>>        /*
>>>>>>         * If GTT is part of requested domains the check must 
>>>>>> succeed to
>>>>>> -     * allow fall back to GTT
>>>>>> +     * allow fall back to GTT.
>>>>>> +     *
>>>>>> +     * Note that allocations can request from either domain. For
>>>>>> +     * this reason, check either in non-exclusive way, and if
>>>>>> +     * neither satisfies, fail the validation.
>>>>> That's not correct, the original logic was completely intentional.
>>>>>
>>>>> If both VRAM and GTT are specified it's valid if the size fits only 
>>>>> into
>>>>> GTT.
>>>> Given that this patch fixes a kernel oops, should this patch then 
>>>> fail the validation,
>>>> i.e. return false?
>>>
>>> It should be sufficient if a BO fits into the GTT domain for size 
>>> validation. If we haven't initialized the GTT domain and end up here 
>>> we should probably just ignore it.
>>>
>>>>
>>>> This would then fail, in amdgpu_ttm_reserve_tmr():
>>>>
>>>>     ret = amdgpu_bo_create_kernel_at(adev,
>>>>                 adev->gmc.real_vram_size - 
>>>> adev->mman.discovery_tmr_size,
>>>>                 adev->mman.discovery_tmr_size,
>>>>                 AMDGPU_GEM_DOMAIN_VRAM |
>>>>                 AMDGPU_GEM_DOMAIN_GTT,
>>>
>>> As I said before using amdgpu_bo_create_kernel_at() with VRAM|GTT 
>>> doesn't make any sense at all. We should probably drop the domain 
>>> parameter altogether.
>>>
>>
>> What is the alternative planned to prevent usage of VRAM at fixed 
>> offsets?
>>
>> BTW, AMDGPU_GEM_DOMAIN_GTT for above doesn't make any sense. Discovery 
>> region is always in VRAM domain.
> 
> 
> Well that was my point, reserved regions are always in VRAM.
> 
> We probably don't need to ability to reserve in any other domain so we 
> can drop the domain parameter here and just always assume that we need 
> VRAM.
> 

Got it. Thanks!

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Christian.
>>>
>>>> &adev->mman.discovery_memory,
>>>>                 NULL);
>>>>
>>>> Regards,
>>>> Luben
>>>>
>>>
> 
