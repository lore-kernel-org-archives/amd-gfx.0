Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46757C636D3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 17:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DE010E9E7;
	Mon,  6 Feb 2023 17:03:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC7FB10E9E2
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 17:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bb89cjUpsL/gN/ILv9cTqU3dea/TTGDZL6l9me/bf9nkfwdnYg/A+i1Fgx9n/MjLSmsnsnY+F90ulPeujcYDBCm3kJcyu3Fh1zSFQEsJlreHNJ7xo95BJlF8szouTEk7PaJLYN4CBGeveODYlND5VPyXFmnwWc5Kp/kaNxe8sUp3cNkPqcxLTm5DILhc4SAMfuZjp9KiPJce94ZoaxzV0cLAEBZH64qAdDvJYEfPl8tzJg9ocLmN4K3KrmYk3U1fw9iWxOEeMITYKT/h4Cx7XILUdw+RIU1p+Z2agPK9amfTQs7n+4j3UcWEECRy5JzS255omHcQLORIG/ojR2udDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1duAs2LCO6JPT1LMmVMTaUK7G/uvh+atF8zm8qLV08=;
 b=RwKaaC6/m/QkXlYaRRVmb8IVwwSs7SnczvEjPEbUVQILWC7uAtlQM2lp9fsxgWu3fDfVNY1jRbv0j5QqBKkJm0YDh8+SiGWKRDN9mATRX6DMxa5fMd67C5uWk95rq1DJ61MCSnpOY/ARhC6BnRMPI2eq3ZOLKdltsPfQ/ZZbW1FfHMo9psem7I4QHBL8te0BJ6EiylWAFYaox6RnWEdoRuNLJ9QmLgm+2R6TV+fEseGp+qqOh8Npi8ZG3a5Cb86jXnMsvW2b20V4bEsldJabQG0KmQcb0crkSpWG1ec7J91oDKJzmD4+AVjgU+ap9NkWbSehvsvh6nOzm4h6GIZ3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1duAs2LCO6JPT1LMmVMTaUK7G/uvh+atF8zm8qLV08=;
 b=TYpZQ5NfpuCWoefsbUwNV5+KgOV6/PSrFo6I1g4JBj0OPUXvhW8weLfxz/FjqMrNhZRnW/DerXNtlMDRflBYsE4XvcmeT0ad476czMVCRByx3eqhS/ASuifhRUi2hYvHR/Q1xiKoS2mvZOMVqN/jGLs9bHVT4YAbuqnHFrB12LE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Mon, 6 Feb
 2023 17:03:52 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 17:03:52 +0000
Message-ID: <6f7baf04-2469-4bb2-e184-a15525922fb2@amd.com>
Date: Mon, 6 Feb 2023 18:03:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 12/13] drm/amdgpu: add domain info in bo_create_kernel_at
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-16-shashank.sharma@amd.com>
 <b94aa331-ce65-fbe2-6695-32e68ec68236@amd.com>
 <CADnq5_Nyqs=uXWTY_Q_iJH+yLQ7q_sQFqGzCA5i3HUPC+z5L-A@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_Nyqs=uXWTY_Q_iJH+yLQ7q_sQFqGzCA5i3HUPC+z5L-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e0a7dd-092e-4001-288d-08db08641f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUpk/qLgvw8pbwUuKsAVKSbfuOsXtrKiY1gTypglCQ8AExacTdI93679RFWXd0OqPFKOujcevtOoiZ82QrJ7Zca1opsSETO8Gu4r72APsP8FrDEcoiraMmUUEzNtvh64rlEWRzM4nSKAE42Mf54zp63aHNxynIeO2E+6gRB/e157dHqbQXnVDZlZa79u657yOiqf89SjLa++a1SjRHu7IGjy5rRaUBYCVjjQoAPaPdqaUxS554Geb0lltFtS7xRwBaM0LoX0ReJM/um6Nd1wClwjy75SLyztP++J+sU8I68WUZ6zy9fHcn7OyZB7zWHWEaQT3T6n+nISAhIf/S7M2FyWNt7zc9eVlPnMgLWo4su3v6y+5/1SU2lxp0dRVwK7LrtrIF1QVsanb663vL95Y3+JKRpl/OjhB+ADo/mpHI/NZrF5ImAWH2kvuKdhGfczCIpB9/PLz4fVir/D3qo8L6H7uiG7HIffwRwZAQlBfLwIlxtWW7fzvDmUzU9YuXS/IpyGT//TvvTBSVtLi+uc/48mXRvmOOoIPAiSNa86xWkt2rnvf9si4ZKNaI5fB7Q1htT3WFzKRzcVYDL0FMsTJwMaUYIXnbNaah5jZcsIYVHnYVyCTs1u5InQ/kvrMDmJU2CV+03roZFxGIPRKLA2QUYY1O4g7Rag4h9iouJvSZLTKzA1DCVDsK6b+AA9yny5Kbt9LroLUiJqleMkKQuMRDdaPaO5Rysee87xwdhJm6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199018)(31686004)(66946007)(6916009)(66476007)(66556008)(6486002)(478600001)(4326008)(316002)(8676002)(86362001)(38100700002)(31696002)(36756003)(6666004)(66574015)(83380400001)(186003)(6506007)(53546011)(6512007)(2616005)(41300700001)(8936002)(54906003)(5660300002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnhZWkEzTEhYUEtyZjlOc1E5L2lnbzZQZU0wMUpGaTZ6bmQ4WVBza3FoK2pa?=
 =?utf-8?B?V2RtQjROQ0tocXdWd0JUdk9ua3lVK1UzQndWQWkvQjRqWVJRMllDQ0IzaHg4?=
 =?utf-8?B?NjhXUWVBaS9BcUw5aDRvMGtLOS92MW93TENDTHc0d2RsZ2RYVWxsMDIzNldx?=
 =?utf-8?B?dWw3dkduMEpRRUVZcWU4cWZqcGY1ZStraGxHbTRDbjNJZ2o2M2VmcXU0eVph?=
 =?utf-8?B?UUU1ZlM2cHhVeEdNRGtOeStOYzNaM0Q1NE9LOXNRYjduSGpKR3BZVXRaUlBz?=
 =?utf-8?B?Y3R1RFUrdjlwa0lVVzYzekxOODdETy8vbHRvUjNublRKTGZPWkJISlZXdldT?=
 =?utf-8?B?dFNUQzJUZzdOTzRSMVZjL0QwS1l0VVJvSUJRaEFhYTVuNVFEK1E3ZUgxTmUz?=
 =?utf-8?B?cnNSVTdSVUMxa1p2RnliTkxiZGxHN09oWEg3eGttYTlTa0JudmtNaTdKOWdM?=
 =?utf-8?B?Q2IyVWZ3YzRlYUg1cXJ6SWtLQnowRkRkc1JvbVpLbzBOQ0dwUUJQTU1jVEJN?=
 =?utf-8?B?YTA0L3N4Sk5ITjZibXRaajgyZzZDaTRSaG5JY0luZ0Z1cjR1dWdEVWxGSXpD?=
 =?utf-8?B?RlVhWXJOMHJlK3ptUHdFeVpuMExvZE5NSXVpaEpLVWl3TWFiZzZZY3lUMENO?=
 =?utf-8?B?b2tZdlZiK3dXemNPNmRnWDdLNTJKdmY2eS9la2NkMTVMSGNtRnV2cDM0WThw?=
 =?utf-8?B?U1NxMGRlSWNweEZUT20rd2hoeXZjbGcxa1hteUg4U3A1Ynh3dkRTcS93Z0dH?=
 =?utf-8?B?ejFJT2hNRGs4dXpVbTZTRlc5OG5QcWZKYnl6WndJUmxDWFVyZmNIUytmTFB2?=
 =?utf-8?B?T29ZMjJxME80WXQ2WlZlQUJJWXd3bEpXNWRrbjlNOGxyN0JXVW81bmRuKyty?=
 =?utf-8?B?U0ZtUngybnMxdHo5K0xaM2ZKZGlSSEhTc0lJWkg3RitpTzRLVEFYSVNZcUhr?=
 =?utf-8?B?OTBIR1hoS2tMT20rVG1IRmhiTXhPVXlMdW5mRVU1QWd5L2wxR1k0OU9xVzNG?=
 =?utf-8?B?cHJmWGx3RXFSSU11M1FvaVdQR3h3NmEybzVsTG9lSkgzd0FJcHJKVGZMcU5P?=
 =?utf-8?B?bXZHaEhVQmR5TE8xK3Jzc2tlSFhYaVUzV0pXdUNJQmhZK2orODlldm16cUpE?=
 =?utf-8?B?blR3SGxHOTVKRE9CWDU4OWpPdm5QcHR3OC8rNWRlbDJteFdaU0ZYUTFISmZL?=
 =?utf-8?B?dlZCcWZVOEF4RFd4Mml4Y25KVFRZWTBhNWQ5WHI3d2FwSitBU0lwNFI4c2lP?=
 =?utf-8?B?QzJ1TllLWjRsQnZJZ3cwQWszd2dlMzRHVlFPckw5UnRJRExBNHFXMituaStO?=
 =?utf-8?B?YkswdjEvQy9IeHVnaW5ZU0FlVEt2V1BFMDU2aFVwa0ZCNlMwUGhURmtKYi9N?=
 =?utf-8?B?Ni9GTW5DWlZaUDNMZE4xaHo2NWdiZVM0eHZwSy9FMEwzUEE5WTFGWWRZRyt6?=
 =?utf-8?B?Y2EraVlDT3pFajg5ZUtKc3ZxYzN6bWliajFLWU5yRUlxTHB4ZkhWTVIvR2cw?=
 =?utf-8?B?YkFrWS9PeG1KanZocHpRR203WnhCTW9LZmFGeXRSYUxES2lKaTZQeG9XQzdu?=
 =?utf-8?B?aUU3aTFjOTVxNkNnK0I3NXFSSVg0MndCR3hQZXliNVI2dXpDaWhobmEzUFZo?=
 =?utf-8?B?Lzl5VUs4KzhxK0hiZC95eUNXZytBUDJMS2pscW10ZEY3UllvVEdNNTk3T1Nz?=
 =?utf-8?B?TmNQMm9hZHM3NkV4Z2EvQ0ljejltOHFKc1JyMVVtMU5QZzhIc1UxNVNPMGxq?=
 =?utf-8?B?ZGNSdlF6NHptRm5nRTVTK0lydVRBLzFleWdPemY4bDZYM1BtTS9PRlFrZXFI?=
 =?utf-8?B?bWdMM1pTeXZKTi8zK3htalFrZXd5VHFnMkZUajNMVFk5VHJ4TVhJWjBRVm5z?=
 =?utf-8?B?MHhUZTF5b2FpUHNrd21kZ2NybU5mTnVzWU94WmZWSHEwNHFmdG9UeityNVdF?=
 =?utf-8?B?clZ3ZjB6SGp5Y3l1R2R4RGNpL0Q4a0xOWEJiU2FHNG5rYW9GcytFQkw2TGcv?=
 =?utf-8?B?SXVMRFZmL3UxMmY0N2ZhWW1rQ1RkZ3grVkh2dHZiaGxXelU0RHYrMTVLRkhO?=
 =?utf-8?B?KzZOY3QrVjZ0UkJadEtKdEViSmNRV2VQYnZSTzlxckkzNDFxaFJDaW5jallY?=
 =?utf-8?B?YXNHeXJPOWdBcE54M0N6a1lWZGFVcTZ4OCsvYitEYWRZSTdNdHU3ZjJmYVJM?=
 =?utf-8?Q?hypAozMjlZUwuscdR49xT07kOXgf/ljEy+sXWuPFYO6Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e0a7dd-092e-4001-288d-08db08641f75
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:03:52.2143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THpxfPjF01gab1Cgwejhew2C4312LVjSRqYxnrla1YBAIunoZOxsuQq5QhNJkzc6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org, Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.02.23 um 18:01 schrieb Alex Deucher:
> On Mon, Feb 6, 2023 at 11:51 AM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 03.02.23 um 20:08 schrieb Shashank Sharma:
>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>
>>> This patch adds a domain input variable for amdgpu_bo_create_kernel_at,
>>> so that it could be used for both VRAM and DOORBELL domains objects. It
>>> also adds supporting code for existing callers.
>> We should probably drop this one as well.
>>
>> We just removed the domain from the function because we only have BIOS
>> reserved regions in VRAM, never anywhere else.
>>
>> Allocating a doorbell for the kernel is not really an use case for
>> amdgpu_bo_create_kernel_at().
> We just need some way to guarantee that the kernel always gets the
> first page.  It's required for SR-IOV compatibility.

That should be guaranteed when we use ttm_range_manager() since that one 
gives you pages in the order you allocate them.

If the first page is already taken then bo_create_kernel_at() won't help 
either, you just get a error returned.

Just allocating and returning the error yourself does the same here.

Christian.

>
> Alex
>
>> Christian.
>>
>>> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 2 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 7 +++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 1 +
>>>    4 files changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index ef1f3106bc69..dec391fa42dc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -367,7 +367,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>>>     * 0 on success, negative error code otherwise.
>>>     */
>>>    int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>>> -                            uint64_t offset, uint64_t size,
>>> +                            uint64_t offset, uint64_t size, uint32_t domain,
>>>                               struct amdgpu_bo **bo_ptr, void **cpu_addr)
>>>    {
>>>        struct ttm_operation_ctx ctx = { false, false };
>>> @@ -378,7 +378,7 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>>>        size = ALIGN(size, PAGE_SIZE);
>>>
>>>        r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
>>> -                                   AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
>>> +                                   domain, bo_ptr, NULL,
>>>                                      cpu_addr);
>>>        if (r)
>>>                return r;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> index bf9759758f0d..b2b7e55ac486 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> @@ -284,7 +284,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
>>>                            u32 domain, struct amdgpu_bo **bo_ptr,
>>>                            u64 *gpu_addr, void **cpu_addr);
>>>    int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>>> -                            uint64_t offset, uint64_t size,
>>> +                            uint64_t offset, uint64_t size, uint32_t domain,
>>>                               struct amdgpu_bo **bo_ptr, void **cpu_addr);
>>>    int amdgpu_bo_create_user(struct amdgpu_device *adev,
>>>                          struct amdgpu_bo_param *bp,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 08355f981313..4cec90debe46 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -1591,6 +1591,7 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>>>        return amdgpu_bo_create_kernel_at(adev,
>>>                                          adev->mman.fw_vram_usage_start_offset,
>>>                                          adev->mman.fw_vram_usage_size,
>>> +                                       AMDGPU_GEM_DOMAIN_VRAM,
>>>                                          &adev->mman.fw_vram_usage_reserved_bo,
>>>                                          &adev->mman.fw_vram_usage_va);
>>>    }
>>> @@ -1616,6 +1617,7 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>>>        return amdgpu_bo_create_kernel_at(adev,
>>>                                          adev->mman.drv_vram_usage_start_offset,
>>>                                          adev->mman.drv_vram_usage_size,
>>> +                                       AMDGPU_GEM_DOMAIN_VRAM,
>>>                                          &adev->mman.drv_vram_usage_reserved_bo,
>>>                                          &adev->mman.drv_vram_usage_va);
>>>    }
>>> @@ -1696,6 +1698,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
>>>                ret = amdgpu_bo_create_kernel_at(adev,
>>>                                         ctx->c2p_train_data_offset,
>>>                                         ctx->train_data_size,
>>> +                                      AMDGPU_GEM_DOMAIN_VRAM,
>>>                                         &ctx->c2p_bo,
>>>                                         NULL);
>>>                if (ret) {
>>> @@ -1709,6 +1712,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
>>>        ret = amdgpu_bo_create_kernel_at(adev,
>>>                                adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
>>>                                adev->mman.discovery_tmr_size,
>>> +                             AMDGPU_GEM_DOMAIN_VRAM,
>>>                                &adev->mman.discovery_memory,
>>>                                NULL);
>>>        if (ret) {
>>> @@ -1816,18 +1820,21 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>         * avoid display artifacts while transitioning between pre-OS
>>>         * and driver.  */
>>>        r = amdgpu_bo_create_kernel_at(adev, 0, adev->mman.stolen_vga_size,
>>> +                                    AMDGPU_GEM_DOMAIN_VRAM,
>>>                                       &adev->mman.stolen_vga_memory,
>>>                                       NULL);
>>>        if (r)
>>>                return r;
>>>        r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
>>>                                       adev->mman.stolen_extended_size,
>>> +                                    AMDGPU_GEM_DOMAIN_VRAM,
>>>                                       &adev->mman.stolen_extended_memory,
>>>                                       NULL);
>>>        if (r)
>>>                return r;
>>>        r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_reserved_offset,
>>>                                       adev->mman.stolen_reserved_size,
>>> +                                    AMDGPU_GEM_DOMAIN_VRAM,
>>>                                       &adev->mman.stolen_reserved_memory,
>>>                                       NULL);
>>>        if (r)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> index fc9edc3028b6..fd1f58158238 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> @@ -395,6 +395,7 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
>>>                 */
>>>                if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
>>>                                               AMDGPU_GPU_PAGE_SIZE,
>>> +                                            AMDGPU_GEM_DOMAIN_VRAM,
>>>                                               &bo, NULL))
>>>                        DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
>>>

