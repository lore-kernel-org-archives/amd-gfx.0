Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F47DC636D4
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 13:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC76310E145;
	Wed, 15 Feb 2023 13:32:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8BC710E145
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 13:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bjn150uNaxQGvDsbUqHAmkYxzowhcygDS8TbDe9olXLty/d7Amkgo0f2n/H6VBTdeHtADmciW74qWmYn4bV4AXIavANtw5p1M4L4MjKhqBMP7+wsqFn8pvO6men/Jy0/0WuOiabpvmW2Fk0W2g5B0YUxeSNFXMmgS+Mpj5Zj0QDs3RsBXXw1FcqoraSAdaS1aOhfmsFKA+DYQ3/ChGaHdlK3qWHgfFrsqg+OIItJeiWTFt7uSL9NAsNYWb0hD/YH3lONrKTIji7gv8s8JBhzTt0FhIoigG7o+9dUC89ljPmA4SgG6jtpwvtZ3igd1HraplxGh/kzNG7RClS+IzUWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXRpRcs14tdGna/CrXJtr6a+Ff+fX3m64YT5DiGCLlY=;
 b=j+uz2wbJ0T7IkmoMmU6ozsdymO0rXl6QR4n7zZg+xZHks9/PySV+iTH6qViwbIsr5lrS5Dk6LeF4YMNHZo8MsvV+6JkpbpEl0xgfNmJKrhSlmWGLR0zxbHWyXzrwXz7lfA/rwb/Tm+iqeLRZXb14CccqOoa4qol4kLCuB1J3oZACiJlHQbB+/asa20ejZ+jc3z2376W2sIdlTGl5Ekwlt2fvpy5VDZglOpQwomfRrGWydhpiPA+oz0JoiNqNTLl0kCsvnEnLlVrUuuojSzuGKo36ZNLaPvtf9DpTO7kMsOMJ3khHsZrKGeJhM2Bw5d91zOxXmSlHe9kmjniFdLke7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXRpRcs14tdGna/CrXJtr6a+Ff+fX3m64YT5DiGCLlY=;
 b=BPRiVr3s4Z+AbQvt43Qev8XU8qW1U5lznmmSXPSxB7EadBinJm3KeLkklajL29CJNhLjEukVx0ygAZ+i1I+baz37Mr/k+FyeftgKCYn2yieUw/3DeeEF7t4CK4w3KDoOrMmDZHRwPz05kC+Y0MKJKyq5rDlaQD13JxWub1auRyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 13:32:11 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 13:32:11 +0000
Message-ID: <f6afd62e-21b5-42db-28f3-262980e86e17@amd.com>
Date: Wed, 15 Feb 2023 14:32:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 5/8] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-6-shashank.sharma@amd.com>
 <7cfbd8c6-7865-2fe3-ac93-d3b264f2b4ab@amd.com>
 <447afcd9-719a-bf86-64ee-af8e8a7c67dd@amd.com>
 <b2aad851-7a5a-c5ad-c4fb-315f7a5ef244@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <b2aad851-7a5a-c5ad-c4fb-315f7a5ef244@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::6) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1ef871-3e7d-4101-19d8-08db0f590af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /VQ4+OpLCwtWDHVQw/LtA61aNpgTes2q8NM/KGZkSOrWp8LmZLg5szSnhhO60ca8rJjjBLiRpbb2Ax0kyhEzNVRhid6GjPFYGxEPZ0PM5k2RVnmaOAg9ubhENsylW4S9OhP2T6HXwJAuz0oWYz84nXAfCMc7dUjgVI6oe6ktKygTcEcOXHcSlm6E54c4GLtNqyF3AFKGqYuknDGZ5pJKxVjU4HaR9q8SdxNr0lNpo44c3IlmRZ48KCot9tlrZxyqxjckpxJ2Az9SC5uCCmUrNv7/4JHqm/zgG/nC02XfDLL0pAmlw1mAnXRNzVUgCezEGv0n4fspVu+lf9QvpHRFg6PCJ5Tbd7G6Hn++aMjoAs5d9wmtPaeDxVVCWiKNlZ+Iw8ljo9uklXNPSYy/hc1p+OpnMXzyJkBhEOzBHZfkBHf3Eimc8hAAb5fbGfRdtyW7cupw1o2aoN7KmUGjAi679ahX46SGKFcjG0YR/Ju673Q2hvoA4G1/2Ma8aXDoeq0DN9LlpUvWw4aH4lMXt/3hXhPz9oMqZXSJ5D+MJB/sfD9D5068aI3vnMpjAF+U4RtdonpcbucHYKpPjfzfzU2IWk+sPdRHUdlSnto5Oo/rLbM44LtOcfJljVLmVw7cA+zwBEONOvHOy3HjoVXTn10krU8/S5yqY1J7f4lIR0Yk4cqcXZEByl5ezsb2GsLhtelSCOsfHlaTdZvup5wccuuB9rI7CLCGyUYuuvzimhyuBsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199018)(38100700002)(2616005)(316002)(5660300002)(86362001)(8936002)(31696002)(66946007)(4326008)(8676002)(41300700001)(66476007)(83380400001)(66556008)(66574015)(6486002)(36756003)(44832011)(6666004)(478600001)(31686004)(186003)(2906002)(6512007)(6506007)(26005)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elBrYUE3L2hiSGdkcTVoV255a2pHWkQyR25pQ3Njb2htQ3M1UkhTTUVNbGxH?=
 =?utf-8?B?SkNnUGh6Sm1vMFpQMDB4VU1YbUpER1U0cjJvR1g3R1RCWEl4UFByL1FteDZ6?=
 =?utf-8?B?TFFYQ29HV0lOc2haUjdNaHNnUkI1S2t2dlcwY29BN3YrV1pvcyszQUdGcXQz?=
 =?utf-8?B?WjR3dmFDTGlsM3FJaXpJN2ZLWXZ0MWc5YTJCV0dWeFRLaCtMRWFxakl3NUJt?=
 =?utf-8?B?NXprR2ZERE1VYlFqVVUwbmtFWHdRSDlhN0VQZGUxTm04eHdVc0ZXeFNManF4?=
 =?utf-8?B?L3BXZUdVNDlCbzM2ZFoyZDVlUlFhaGlUQTlvalRDQ3FWTzZFZ2lHWEhDRVBz?=
 =?utf-8?B?WVQvTitwcEErajFrZDVZcm1uQ0o5aUUvdExDU3lFQUNIdzJVSWRuUy9md0R5?=
 =?utf-8?B?R2hLNTFtczhCVmViZDl1M1VDY3MvRlFEOHRJZlZNRDRVMEV2Q1QrOUxCVm4v?=
 =?utf-8?B?cHZlNkJ4WCtmeGREN2xtSlZFWGpSRFZlVG4vYkp1TU54NE5rQnowUjZIUmZI?=
 =?utf-8?B?YTZGa3pzNHpqNHZyODdicE52YkRFVkpLV3M5SUZNay9VWWRoOXp1WEtINFA1?=
 =?utf-8?B?d2phMGpPWXZOWUpqSmlULytwUjBrTFJ0bU50SUpWVXh2emlUcmJmNlhPRmF6?=
 =?utf-8?B?S3huM29oQUw5SjUveTVuaEo4Z2NweGRPTzRBaUY2cmluQVVQa2kvWXM2MHc5?=
 =?utf-8?B?ZmhhYlZ0Y0F1Tm9DUlRLTnZYd0NBaVhsQXlHSG91T1EzWkViT01raWN0a1ZL?=
 =?utf-8?B?QW5VbS91NVA1anFWcVVTVFZ2cmM0TW1MVzl2TWUxU3k2RDF0bnlLN0hiQ0Zt?=
 =?utf-8?B?T3VoMHcyMklBY1RTV0ZPL0xsWDlYRm9lKzVsTm5JaHNrMVkrZEhDajhRT01O?=
 =?utf-8?B?bEMvK01VUCsvT2pvcDFpZU9jeEF4VklvMzNNNTZzaXhrMGNxRklTbnJGK2w2?=
 =?utf-8?B?VXVhbE9xaFI5RlRwSmt0dFdBU0pSa2xReEtzVi80SG8vMW5nWGdnMldDSXVo?=
 =?utf-8?B?bjNHVURUQkoxRUdyR2VPT2ptMGYwUzI1bWM4anZKZEZMNXArbGxId01oMTls?=
 =?utf-8?B?azQrWHBpYXBqZk5DaFh1NmFCTldQQlJXVm1kb05DRWFqNjFmeS9rQ1dDVitN?=
 =?utf-8?B?TTZ4WExleCtzekh0K1lUQ3NyZkFSMmY4L3czVmdtVDlsdW94ejRZcGpIR0Zx?=
 =?utf-8?B?Y283b1M4bGdVM1RJd0llSlYwcURLM1M5emJPK3hjQXlCT1lMcTdKMEhEWjBN?=
 =?utf-8?B?cWVCUFhMNHBOUXpYY0dQdkUxMGNud0xveGV3enlJelNPU0lWSWZPaWhVSUFN?=
 =?utf-8?B?aVdiS3JJeTYrZW5jTVhWK3E5MC9VV0IrL1pDb3dIa1VGU1hrRC84SENxR0hx?=
 =?utf-8?B?UW5PZ0phT09WR3dFU3MrYUdVbTJWT2RMc05BTTRtNkJFdFZEM2w0UWxTbEY2?=
 =?utf-8?B?VUluZ0QxbTNRYkNRWXZSRmhjcG1nSkJIT2NxV0R3V1BYNVNDWWRjeFVIL0w0?=
 =?utf-8?B?NFhPcDVzOExkU2VuOUFlWHNQNVM3b1pBaEZTRnhoN1FGZFBSYzMwN3JROTQ4?=
 =?utf-8?B?aXR3bWFiU2dYR1FtbUFIUkZVQlRCNEZnVzFIY2NkZ0dENCswL3BIN3JRK1Nv?=
 =?utf-8?B?YkE3KzlCa3U2QjA3dHRPMlMzZ1J1NGtIR0ZGSy82SVVhc3BvN1h2NHBKTk85?=
 =?utf-8?B?eXovNHNTeVVuQUMvM0UxZ0J2RzI1ZmxZRkkvWTYxTzZPUE9HZ3YvdzVSYTQ0?=
 =?utf-8?B?RlVIYTEvSWFYL3ZuUzdhU1hYb2hVNmhPYlBPU0hHNmY2eHFwWERYOFY4UzJt?=
 =?utf-8?B?Z1FoZmNUWnpmVm8rTTZVWHVvLzJGdnB1TDFLVEY1cUtCTTVhcVprejMwSU5n?=
 =?utf-8?B?dXdpbHU2ZUdDcjJCb0xhSGExRHJFYWRlSURVZXZmd2daODIvQ3JIM3hvT3Nk?=
 =?utf-8?B?VFhUdGg1ZUlhYkdMa21RaER0RGludWU5aFJ0WlBQUm5Oa1FYdzY2UVU4dUZK?=
 =?utf-8?B?LzR3Y29ZaXAyZG8vU3BNRVM4NlZLcWx6QmZYdkU2Z1YvNDZNUXJPSEZKVis1?=
 =?utf-8?B?cWtONFdZbzRMelZqM0pSbmVMbnpGai8yOGJzVUZSVDIxMkRqeTBUNitnZ1Vt?=
 =?utf-8?Q?Ah+fU1TACwv2fwot+M8hXE7uz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1ef871-3e7d-4101-19d8-08db0f590af5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 13:32:11.6835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1kD02O+UH/7uG5TCIg4VGhUe2InfEJ9qPxEuFyXGr+6+Tdmzfihz3+hAn7iVOp+aP7MxjJFdwOuajbRFT1uLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491
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
Cc: alexander.deucher@amd.com, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 15/02/2023 07:17, Christian König wrote:
> Am 14.02.23 um 20:24 schrieb Shashank Sharma:
>>
>> On 14/02/2023 19:31, Christian König wrote:
>>> Am 14.02.23 um 17:15 schrieb Shashank Sharma:
>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>
>>>> This patch adds changes:
>>>> - to accommodate the new GEM domain DOORBELL
>>>> - to accommodate the new TTM PL DOORBELL
>>>>
>>>> to manage doorbell allocations as GEM Objects.
>>>>
>>>> V2: Addressed reviwe comments from Christian
>>>>      - drop the doorbell changes for pinning/unpinning
>>>>      - drop the doorbell changes for dma-buf map
>>>>      - drop the doorbell changes for sgt
>>>>      - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
>>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 ++++++++++-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 11 ++++++++++-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  1 +
>>>>   3 files changed, 21 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> index b48c9fd60c43..ff9979fecfd2 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> @@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct 
>>>> amdgpu_bo *abo, u32 domain)
>>>>           c++;
>>>>       }
>>>>   +    if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
>>>> +        places[c].fpfn = 0;
>>>> +        places[c].lpfn = 0;
>>>> +        places[c].mem_type = AMDGPU_PL_DOORBELL;
>>>> +        places[c].flags = 0;
>>>> +        c++;
>>>> +    }
>>>> +
>>>
>>> Mhm, do we need to increase AMDGPU_BO_MAX_PLACEMENTS?
>>>
>>> I think the answer is *no* since mixing DOORBELL with CPU, GTT or 
>>> VRAM placement doesn't make sense, but do we enforce that somewhere?
>> I am not sure why do we need that ?
>
> Userspace could otherwise specify DOORBEEL|CPU|GTT|VRAM as placement 
> which would overrun the array and be illegal.

Now when I understand this, how can we enforce this ? A size check that 
blocks places to go over a certain value, which is fixed for boorbell ?

>
>>>
>>>>       if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>>>           places[c].fpfn = 0;
>>>>           places[c].lpfn = 0;
>>>> @@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct 
>>>> amdgpu_device *adev,
>>>>           goto fail;
>>>>       }
>>>>   -    /* TODO add more domains checks, such as 
>>>> AMDGPU_GEM_DOMAIN_CPU */
>>>> +    /* TODO add more domains checks, such as 
>>>> AMDGPU_GEM_DOMAIN_CPU,  AMDGPU_GEM_DOMAIN_DOORBELL */
>>>
>>> Should we enforce that user space can only allocate 1 page doorbells?
>>>
>> Should we add a per-PID basis check ?
>
> No, just a check that the allocation size of the doorbell BOs is just 
> 1 page.

Noted

- Shashank

>
> Christian.
>
>>
>> - Shashank
>>
>>>>       return true;
>>>>     fail:
>>>> @@ -1014,6 +1022,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>>>       } else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>>>           atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>>>       }
>>>> +
>>>
>>> Unrelated change.
>>
>> Noted
>>
>> - Shashank
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>   }
>>>>     static const char *amdgpu_vram_names[] = {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 0e8f580769ab..e9dc24191fc8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct 
>>>> ttm_buffer_object *bo,
>>>>       case AMDGPU_PL_GDS:
>>>>       case AMDGPU_PL_GWS:
>>>>       case AMDGPU_PL_OA:
>>>> +    case AMDGPU_PL_DOORBELL:
>>>>           placement->num_placement = 0;
>>>>           placement->num_busy_placement = 0;
>>>>           return;
>>>> @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct 
>>>> ttm_buffer_object *bo, bool evict,
>>>>       if (old_mem->mem_type == AMDGPU_PL_GDS ||
>>>>           old_mem->mem_type == AMDGPU_PL_GWS ||
>>>>           old_mem->mem_type == AMDGPU_PL_OA ||
>>>> +        old_mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>>           new_mem->mem_type == AMDGPU_PL_GDS ||
>>>>           new_mem->mem_type == AMDGPU_PL_GWS ||
>>>> -        new_mem->mem_type == AMDGPU_PL_OA) {
>>>> +        new_mem->mem_type == AMDGPU_PL_OA ||
>>>> +        new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>>>           /* Nothing to save here */
>>>>           ttm_bo_move_null(bo, new_mem);
>>>>           goto out;
>>>> @@ -586,6 +589,11 @@ static int amdgpu_ttm_io_mem_reserve(struct 
>>>> ttm_device *bdev,
>>>>           mem->bus.offset += adev->gmc.vram_aper_base;
>>>>           mem->bus.is_iomem = true;
>>>>           break;
>>>> +    case AMDGPU_PL_DOORBELL:
>>>> +        mem->bus.offset = mem->start << PAGE_SHIFT;
>>>> +        mem->bus.offset += adev->doorbell.doorbell_aper_base;
>>>> +        mem->bus.is_iomem = true;
>>>> +        break;
>>>>       default:
>>>>           return -EINVAL;
>>>>       }
>>>> @@ -1267,6 +1275,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct 
>>>> ttm_tt *ttm, struct ttm_resource *mem)
>>>>           flags |= AMDGPU_PTE_VALID;
>>>>         if (mem && (mem->mem_type == TTM_PL_TT ||
>>>> +            mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>>               mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>>>           flags |= AMDGPU_PTE_SYSTEM;
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> index 967b265dbfa1..9cf5d8419965 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> @@ -33,6 +33,7 @@
>>>>   #define AMDGPU_PL_GWS        (TTM_PL_PRIV + 1)
>>>>   #define AMDGPU_PL_OA        (TTM_PL_PRIV + 2)
>>>>   #define AMDGPU_PL_PREEMPT    (TTM_PL_PRIV + 3)
>>>> +#define AMDGPU_PL_DOORBELL    (TTM_PL_PRIV + 4)
>>>>     #define AMDGPU_GTT_MAX_TRANSFER_SIZE    512
>>>>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS    2
>>>
>
