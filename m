Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC52C4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Dec 2022 11:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFED10E1DA;
	Tue, 13 Dec 2022 11:40:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B31110E1DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Dec 2022 11:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaXGgSI5AtZDmDTOFsEx4055msFbLfpr20UP9oHa6snCFzn7OgDDO+ZklbCGtpKhbUBQzppDHWTeHVWG8+M2ykgIIcdrWZSurg0Y22AdTaaFS45D40zTgHE90+END/ZXEpAd/MYp/jq6MFlAFYCuYegXayu4nyveP+9Uprds8gWVT7cIctIOFYHAyvsuZ66PZDNPYpvfqFvmHNMxkkR4atzXcynqznjT5NUai7JaXU/PO32uvXbJcIPWT86j1l2Db1Tk0y1fOFgy9GbS9EWrHNiQAEsWKC+moO3FnLk7bMKGP18P7xuhQ/4L7J6KSWk38ZdvbWacG9WzXseLXO1yVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mw2/AIVyWrcTF8mL8/Z7TutZAU7hMNVhfAfxCp0X+vg=;
 b=S5qxXYG2/HkztK4IvRgpqKjl0kXtJ8i2K2W/hIKADqtXbeqxav5NWhpYSFr1/9J6fKSbfM/+sXC3KuJ+JcHAyAbG0jYm9uTvt5H13EphAepk6YIZ6aH5chVdWc+bTy/NXup0pNtt8FWINd2xPogvrnll6eoGQRng4jLyTqCITDpk6jOTYiYps/hx5wgkhnusMC6pBGCP2QaFPOODSy/367re7i8c5GWcMQt6G725KW+A4Zt8v1BopW/qC5BxkJg1zfGtBqbMdWf3txw3qC+DRmJ/3sdsh3OpXN6SWt9RAWeOk02MxwNoBhEyDxgfgQ0Ou7S4PPJui95uKOOWmQNLsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw2/AIVyWrcTF8mL8/Z7TutZAU7hMNVhfAfxCp0X+vg=;
 b=JMZiK9fb0DhIBS3x0J/53jgVbxw9+b1up7lrn4rkeUBJRfhbXLpzZVjRKjgE8N6GzJ+EFnckDwUS6MA3hI/0kqoYwYc6KFG8+nHPs2HGa0ypx2q2Lne9+DhGAYgCD6XL+JwBNahgJtNQNMc96/1q2KfI/RrHgzf2pJ6KWfI+2Ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ0PR12MB5486.namprd12.prod.outlook.com (2603:10b6:a03:3bb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 11:40:27 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bc0:e01b:6da0:9f24]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bc0:e01b:6da0:9f24%4]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 11:40:27 +0000
Message-ID: <e86f5bef-24a0-0eaf-7971-563285714399@amd.com>
Date: Tue, 13 Dec 2022 17:10:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] drm/amdgpu: Fix size validation for non-exclusive
 domains
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20221210092419.16548-1-luben.tuikov@amd.com>
 <20221212174834.36544-1-luben.tuikov@amd.com>
 <802b6283-d015-eb67-18fd-cba6fb03c96a@amd.com>
 <fe09407d-9057-879b-be61-3bfbe74846db@amd.com>
 <9e14bcd5-a911-c430-a474-4f43daf44283@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <9e14bcd5-a911-c430-a474-4f43daf44283@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SJ0PR12MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a0b5c9-6916-4520-6862-08dadcfed468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+KHPAmWTH5rS5yA/CEoD+xWgm+4PVQ3tdzwf/Z/XDoTit9aCUYkM4O03yYcARrAReRqGyjslAazIN/HY5xsSxiREeR1dudoggWGHizbGb2o+jxBbjq9NzDQjIhqW8sujR9mzzAfe24VV0SrLR3EhnIrinXoPDQyD228IvjHP+k7kk2VULcktEXSBSf29G2QfsKrKsxVu1pJGDf/rFXQtDf6VosjRTT3SPriKX6tKJilQCrOBJIbysDDmPeekk1i3P1iFhcmUk1QP+qhPvb2JQZynEd1AAxJ/xzvG2XQ0I4+0szu+jgqT/oLNGIRvjN9KBGXZol+F07ViCJ/1Caz8G2wV1PUCFpX7AXsARsSTj7XLf5N97Reej89f/KcwxSjQalD8K9tXgj3Dx0GhNpDBfWNYs8VZBJ1nBtdEH9jcQkqXgN5IgSFMZdbmrs0IvvZB1Y8qd+zUXrsX8VjkyYUvxbp75GPsyVkoU/b+30EnXy5kS+gTLfHDVpAOUHt0h58HRoLm1rCT3U5Nj4D8ACNvtSv6McktivKgLmAOGagM2Ythru9gA4Vs5sz0uiKO4PPmJwYXR8gy4SwWnoHItW49vnRg6ehhzboq307eCF6nRfn/eY16DzZzQXSYzHn8mWZrHcS+wMYo4mCL74PYSxcoiE0pIBIj/G01NtCITQ8wmmpknRS/4g/4/WrLbqbNvykSepKM9YToLpYiWQplOcCZ0WneMI1nT9AuqbYT5ILU+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199015)(38100700002)(6486002)(2616005)(66574015)(6666004)(26005)(6512007)(83380400001)(6506007)(478600001)(53546011)(31696002)(36756003)(86362001)(186003)(31686004)(5660300002)(8676002)(41300700001)(66556008)(66476007)(66946007)(8936002)(2906002)(4001150100001)(316002)(6916009)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3pyU2RLMCtHNnN3N3lHMW1XeU5jRUJZM2c5dmFZeURYKzhqdGZDMk5KaHNp?=
 =?utf-8?B?NTBYREM1L0R2ZzlDRVRWbU5uOEgyOE9URUd3U3Y2UXJqSGNWZXNvNllwbnZz?=
 =?utf-8?B?SllOdTNxdjdsaStnK1NQS0Njbm9mOVVvSU1Tak9TeldYQUp0Rk5HSWdnRzFu?=
 =?utf-8?B?MVljdkkrV0ZHbjE2UkpuMFNOc2tURDhXbkEvK3Q3V1RadTMvVzduTDBCZEFU?=
 =?utf-8?B?R3NyblIwV1E0OEJFcU93dGZ1SzE2RE5YUjNCWVhGa2NaQWhlSjQyYkU2VlhM?=
 =?utf-8?B?VlpGYTJOenlwTVRoTkQ4dnpNM2hLbHhHTXp3RFc2NzcvNTJxZFo1YUdEbHE2?=
 =?utf-8?B?TThKemN2TEcrcFJ1c1pBU2dPYUxvOHlzY01ueS9PRnd3Z0FzOWhUL1drZzZC?=
 =?utf-8?B?Q2lNY2dvdm1zZzNoSk9Cejl6QVFwZ09UK0hNRHExaUNNa3B6Vm1nOFlxRCtZ?=
 =?utf-8?B?SkJJdXpLVUJWYnRDZVJHMWZsam02dzBMNmZEb0NWTFRPT2FOT1Q4elFuNGNX?=
 =?utf-8?B?TlFDMk4wc29kalQwSVluRDRmR0toa1B1Qzg3dmFDVWtYUFIreEcvdDVxMDNr?=
 =?utf-8?B?TmVKck0raUZPTC9PeElvaTJOMWlRNDE3SEdXNmExc2paRGlrMXpVZ3oyZXoy?=
 =?utf-8?B?bEFrYlFUNnpzVVZBUGRkRlJjY2VtVWI3ZHhYWWJVUDZVZ3RrNEovZDI3L1B4?=
 =?utf-8?B?WUg3N2R5WGthdGEvWExaZkdTUkpzVStublJST3JvVTlRMTZCUU0vYzlDU3R3?=
 =?utf-8?B?MGs4ZHFQY2U0QmlyWnc2NDBGT3VIKzc5Z0pBcy82RUFmc2htWFVhd1N4TWRF?=
 =?utf-8?B?c2NLc2dLL0lYRU54T25RazZQR0l0aGFQbUl2VHdqQ3FmeDZVY3ZIMmlwUXR2?=
 =?utf-8?B?MmIrQVlhWnBFejg0cjZsWkVPKy9KMmU5bmgxbnhtWmFwdVVYcE1YUGFSNzVp?=
 =?utf-8?B?SHBrckR6MlNTTU5ub1hjUERZTFFVTnZRVlI4Ny9pNmp1dkhSZytzNUdPU2Ev?=
 =?utf-8?B?RDNhK01Ic2pkSjBOWFA3U2l5MlYxbENqR2dtbGtDcWhmMFhOalBVcGNKRzRK?=
 =?utf-8?B?RU5kckdKRzRVOU1xVGFJZFBOUGRXRmZUUjNWYU02TTNXb2l0a09Gc1AxUGVW?=
 =?utf-8?B?YTNZek9YL1c1R2RvTFlBNkJBMmRzcHY3Zm9ZYkM1UjF3Y2REMEFwNTZTOFBL?=
 =?utf-8?B?MTU0Y2J3bVV3dGo3TldKTjhoLzdDU0k5WkZoVXZEZTcxcERSZ2FxaWR4MVdR?=
 =?utf-8?B?Sm8yT0lySncyekt4Tnoyd0ZsOTVtYWVrWVZqRlRBS0l5VzlVaE11eHNhZUQw?=
 =?utf-8?B?bmFWV1lWTW9udnJOOUpIb2tEbFZzZzhmVUpwSU5ReVEyRk8yaXp1N1pVOVAx?=
 =?utf-8?B?ei9EQTd3SzlRTXUyZWZlVTR1MzhraHZ5WkdyN296NWt0RjVEN3hhSkFmYWlz?=
 =?utf-8?B?MzFWZUY3OGRFMnFJZW5HVkNXMEtJRC9zWXdyUjZQRDV6a1hLUy9MbmdCVXNx?=
 =?utf-8?B?eXREMmtGeWJFeFdaTmYwaWY1N1NMcVNvRXF5Nm42VEFHTDM4b3ViaGw4OEhL?=
 =?utf-8?B?enZaVUhYeWZWeFpTR2pOZEJRWFI4VmZJTkpoTWo0ZEpZNXRQYThvT25Yd1Zw?=
 =?utf-8?B?aWJGSzVDODJoVXJ2SUxlVXBrZlMvb2N1SFVKSzRJMko0MjMzTVd6cmg3Yjlz?=
 =?utf-8?B?cTZQeFc2TGZrOG95bWNnUEhLTENlQmtJY3dMNk0zV2RjN3dOamROOWh4MXgx?=
 =?utf-8?B?ZFdMSjRnQmU4NHRSRGJ2aE0yRi85b1E5QjdVVHJwNlhlbUN0bUgrUXVyK1ha?=
 =?utf-8?B?OG5DbnIvc0Z0eGJkQWkxa3Z0cW0zWC8wNFJqVVBwdTlsSWtleHRsZjdrelpi?=
 =?utf-8?B?VFE3MmxseW9aWUpKMVRXallFbDNVQm9UVlAxc3dhRG5xbW4yWVVXWFdjelNL?=
 =?utf-8?B?a3FUN2MvU0d5VDkvKzRBY3FxOVBHVVVrazMzZG5tQTlYM2FBbUNJa1l2N1or?=
 =?utf-8?B?bWI0bzFjaDJiUjM0djgzSEFXbEIxT0hTT0RLSmRHSUdKZEJYa0dyM2tpcWZU?=
 =?utf-8?B?akhTK3Rxd1hPM1FPb3lCOWViejNPRVJidkkzdkpjNjRuUGJrczVhODM5T1g1?=
 =?utf-8?Q?kjEK5mE9E7qr3Wn1fkPh6GCN0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a0b5c9-6916-4520-6862-08dadcfed468
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 11:40:27.3356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mEScYPSfOA+NxPqekMGCnmq6VCy8yzyjkK7qo4IDir227MYNACBa9P4MnQfQjvE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5486
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



On 12/13/2022 12:30 PM, Christian König wrote:
> Am 13.12.22 um 00:44 schrieb Luben Tuikov:
>> On 2022-12-12 14:19, Christian König wrote:
>>> Am 12.12.22 um 18:48 schrieb Luben Tuikov:
>>>> Fix amdgpu_bo_validate_size() to check whether the TTM domain 
>>>> manager for the
>>>> requested memory exists, and to allow for non-exclusive domain 
>>>> allocations, as
>>>> there would be if the domain is a mask, e.g. AMDGPU_GEM_DOMAIN_VRAM |
>>>> AMDGPU_GEM_DOMAIN_GTT.
>>>>
>>>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>>>> Cc: Christian König <christian.koenig@amd.com>
>>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 +++++++------------
>>>>    1 file changed, 7 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> index fd3ab4b5e5bb1f..e0f103f0ec2178 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> @@ -448,31 +448,26 @@ static bool amdgpu_bo_validate_size(struct 
>>>> amdgpu_device *adev,
>>>>        /*
>>>>         * If GTT is part of requested domains the check must succeed to
>>>> -     * allow fall back to GTT
>>>> +     * allow fall back to GTT.
>>>> +     *
>>>> +     * Note that allocations can request from either domain. For
>>>> +     * this reason, check either in non-exclusive way, and if
>>>> +     * neither satisfies, fail the validation.
>>> That's not correct, the original logic was completely intentional.
>>>
>>> If both VRAM and GTT are specified it's valid if the size fits only into
>>> GTT.
>> Given that this patch fixes a kernel oops, should this patch then fail 
>> the validation,
>> i.e. return false?
> 
> It should be sufficient if a BO fits into the GTT domain for size 
> validation. If we haven't initialized the GTT domain and end up here we 
> should probably just ignore it.
> 
>>
>> This would then fail, in amdgpu_ttm_reserve_tmr():
>>
>>     ret = amdgpu_bo_create_kernel_at(adev,
>>                 adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
>>                 adev->mman.discovery_tmr_size,
>>                 AMDGPU_GEM_DOMAIN_VRAM |
>>                 AMDGPU_GEM_DOMAIN_GTT,
> 
> As I said before using amdgpu_bo_create_kernel_at() with VRAM|GTT 
> doesn't make any sense at all. We should probably drop the domain 
> parameter altogether.
> 

What is the alternative planned to prevent usage of VRAM at fixed offsets?

BTW, AMDGPU_GEM_DOMAIN_GTT for above doesn't make any sense. Discovery 
region is always in VRAM domain.

Thanks,
Lijo

> Regards,
> Christian.
> 
>>                 &adev->mman.discovery_memory,
>>                 NULL);
>>
>> Regards,
>> Luben
>>
> 
