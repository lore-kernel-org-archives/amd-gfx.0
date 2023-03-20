Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD35AC7618A
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 17:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56FF010E5F8;
	Mon, 20 Mar 2023 17:31:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A0710E5F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 17:31:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGQ0pO3M4tmG2nHdGj6uoZiggW6jeZOEzFJzG8TcpnjEF/GyqK44+Rvj5iPa7GsIrjb2BDD/aC0lfJFU20rD7C/AlCDS8eHAWA2jEg3pY/Hg6Hn2DikXu0+cq6FoBdHh/fTyps3dx58wg8oShYj4hM2OSsDf0iT04gbzc9M+e/m9HtpcVNia6jVZ43KFQ0IdXWKeykvSKZrrMe3H4meav4cG+b8ethFFjFuRI2NiQxxFRYgdKm3Jt7Y17C/QviL+Clb0EMLx4VKFIU43bn9mEFYMb+yTI9z7FCjFHiBeoxbYsHiNwPrMjTgM8ml7nrHf5qjlhyOnQf7AVYe/xj5p5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6csWnss+N+MJiuIj8tJOaw84yToaQz5ryQ+M0EsnoPM=;
 b=g4ZmH8WBcuAm/c3g4rCI1/N1tYcXCSzayitm0IdpUGAgGosvTZE1LoAeny98Mxl0vtO00lsWN39Yc6r3NbLuOHfxg8OYd46lJ1XIe395ZNsDU3yVc1oi3tyruZx2BJIrlFNOe7OfQnraVfPMlgIK4eo4eTVXvRT8scJTQaSzIoDoeZR0bfhulY44GMjl/ZD+oYefVcRmvbZN96aaor68jVSg6HMDegSt8DMV7DaCpHVTa3KEdHJ8RFhRUbMJzwyED2NpdfqIIz0fplSN5YS85yNpLyXJLShwnyAL0sSVTPjx0hgL5EB3Y/yQXcolXsZ+sehNk3EMAqPpe19zjBd6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6csWnss+N+MJiuIj8tJOaw84yToaQz5ryQ+M0EsnoPM=;
 b=3x3COsXA5oyanb2eGuZxpPy/m55KryYy1m8iIe2LPh1A0o3KsmZxO02k6HpE/pSq5vNG4cAxwWW5jU0HbzwKLYL8+P5Tr1Z/0fmuEh1j2gu6YlabOTXL4Zl7KyvGJoWtUn9hsI7cLkDa1emmGGrjtDAul5sUQaaBqFO8YL2Mpis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:31:45 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 17:31:41 +0000
Message-ID: <8763c460-82cc-d3d4-c72a-3a8c571ab620@amd.com>
Date: Mon, 20 Mar 2023 18:31:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: improve debug VRAM access performance using
 sdma
Content-Language: en-US
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220104191211.1707514-1-jonathan.kim@amd.com>
 <DM6PR12MB26197A9101DD2B16D580D12AE4809@DM6PR12MB2619.namprd12.prod.outlook.com>
 <7c9ae421-8bf6-4935-0e2b-fde402f2825a@gmail.com>
 <CY8PR12MB74355011070411B9F9A43A6485809@CY8PR12MB7435.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CY8PR12MB74355011070411B9F9A43A6485809@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22)
 To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 2107c11c-b674-45f3-3c90-08db2968f798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xjrqQPfaazNC49IpQAgdgpoWUJKZPrbDyYLWfA4CBAALLlJZdAEtGtH2WPmB9Hh4fk+t3nM8BFpz2bJvLzc8XuAmDtPOy7HwHxWi6SP6tynhipUf8pPteaFEWkShM9k9CmExtfoNGC6rHEaYKBfFjWiLlXjRw00c/+wc/qh+60njozwCP2F5f3u3Q3XV0iwecuOc7p0ibCJ+nBqmX3S7+QcVRjusjGeJpKwDOrHbwlLqqztR3Yv7Xmd446OYrHbWQm+rk62VoSOehumdeMAorWj5HzkLZnAJkDFIXZkfzMfyLHBEjVVgnlQwkOFVEkI5CUXMll2dp9hA3Nzlt1Fa57EAdvWoO+0iONXOAdUWdKbYVmG2J8OWsW9qnaFcZIdlOy0kABkClyC+j8GCd4lbfXigVlkWy+2LfY6PmG2gN+4pS3AM//3JjFmRixF9zUITktCSPc9qy+XyDIzAeAK8IFB+Hn7Id9hvND/YqaS+p/In5uaAiRRZFbA7dEgqWPpEFrAxTfEDOwEtlv4agMpg8QERdq+/nkcxVxhu5OeHklUtQvtz4+5kAzJ/hdYsXE8QMpOLOy5ujJzpkcB7iDoHvgfnWCnDZbElEosMyBlxcpbergSZEtI5DBjRr8Xy640LAW18OL//Fxc5FeE9OdsRdSI26u1Qng/T3qCbQr5btdBGsInYsgFTT/11zUY47NuG8jRoX3bkord/26JbXAuCSqGGsFFx6mYNBDvbivs8GY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199018)(6666004)(186003)(66574015)(478600001)(8676002)(6486002)(6506007)(83380400001)(6512007)(31686004)(53546011)(110136005)(2616005)(316002)(66556008)(66476007)(66946007)(4326008)(41300700001)(5660300002)(8936002)(38100700002)(2906002)(31696002)(86362001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUV6bHgxZkc3YkdZQ2k5Wks5RUZVTE8xY0xieW16SFY5SXVsanp5bFVXd3hq?=
 =?utf-8?B?OEJpbVUvR0pFQjhQKzh6WHc0cDQzL2lMSGI1eVptaTJRbTRnamxUMmV1WEJj?=
 =?utf-8?B?cXQreTVTVXVTMlRaYjdJRjN5Qy9MVThiem1lK1B0UTdRNlB3NWhXQXVlc2Fr?=
 =?utf-8?B?MjJBV2RmM0hzVTh3VDVGcmlGN0pwT1gvT204ZVRlcEVUQlZTWnBWRG1QNjQr?=
 =?utf-8?B?ZU92eCt1dnJkNjFaa0ZNRlZEbG1tTE15SkdlZE51OEVFbW5KR3YzVDR5WXQv?=
 =?utf-8?B?amlBNmRyOUNRSjNacGN5ZTdXWnQ3Y2RBeThNQytZeGdvVTArdGg2RUYzTzRu?=
 =?utf-8?B?R1FVYXlIS2ZEMkNmcngyTEI4TjNCUW1RZ3dsZzBBUTFkdmVSUUNIUjZrcWRS?=
 =?utf-8?B?dHdNbnp1dktyNitEKzB1U0lIV0lFVk5BOVBjWUhjL1h3KzRaQ0Nha0tkaVlY?=
 =?utf-8?B?WUV2VnJFK3BNOFJpZG03bWtQT3RCcXlCdm44TDJXZTlMRW9VQUx4dm9VV1VW?=
 =?utf-8?B?b1F1R3p4eDN6Z25pQkhoMWp3aldnZURJSjdmM1B4cHhBNG1ORk5TMTdzZU9N?=
 =?utf-8?B?RnY1cG1FYlhsTFNYMHRZQkM0bDVxeEl6aE53L1pNTElWSmtsaWlBRXUzSGpl?=
 =?utf-8?B?a1AwdnBQVHlBeHBCM2hNZUFmRmorMTRQK1JCMk41U210NG9BV0NkLytlaGVZ?=
 =?utf-8?B?bVFFdlFBZVVBck1wenVWTDhVcmMwSCtaK0dJVHlQaFhUQ0QwZ2ZGZ0xseVp4?=
 =?utf-8?B?T0M3YXNRRGZ3M2NKcUlhemdESnVzanR0RGJmblBKSnF0RFJrejZZMGNNYkhR?=
 =?utf-8?B?K1FpNFdkUUFUWXpGZ1M5N1NBZ1ZDTUg0V3NqTC8vRXJwbGdNUXdRWTNzTWlS?=
 =?utf-8?B?YllOSkQzbnZkT0ljL1d2UUZRaGJtc0pObXhiQVEveTdFQVhWeE9vM2ZTV2p5?=
 =?utf-8?B?VGx6K1BaZjFxM28wNzdtZGF1QkpRakFmWGtZV3VBQUdET2wyemJCcHlVZkdr?=
 =?utf-8?B?djNBU2F2MmhPb1RXeTNBNlNoVWNDVUVBK1NVaXdaM1hRYVc1b2N4enR1QVNa?=
 =?utf-8?B?Mk10Y3hmUWtoV0ZqODllZ3JRVzBPaDhrNHFiZzdISk40d3RzaVFERitsZHk0?=
 =?utf-8?B?bUNWd0U0Zk9FZHlYM2VaUGFjS2s2Y0lsa3dTOEs4YS9ReEdDOEEyNmZVRllM?=
 =?utf-8?B?Y2xjdE1QREZQOXduNGFJd2hqa0F0cnFNYy80OG52Rmx5QUFJTTQ3UUNMdGdj?=
 =?utf-8?B?Z3BHTFdRNHhBdUtpYTc4dlJXK0lKbUNERVdCcmg2TEVDZjZyQTFiNDNWTDNI?=
 =?utf-8?B?cmwyaUVQTUpWT3J3M2c1SHBBaFBKelJaVHFYZTNiSjFpakF4K2x1VUdrdXp0?=
 =?utf-8?B?YzFMTTJORDkwWG9CVzhJdzVzYkI4dmFzK3MrbGlld2RoV0xZTGptY3pGSTZW?=
 =?utf-8?B?YWxUcjhFZjVYQVU5MlpaZTBPRmpBcjNucWpCMlJTRGhBaVFuL2V4MW5jbmY4?=
 =?utf-8?B?OVdRNEttUU5jbGtjOWI3aklVTUE2UVlvNWFTNjVPZ09qSklpc3hadURZRHV1?=
 =?utf-8?B?cVIrdUFuMTJoLzVRVEZYUHdac1U2MWJsOWl5MkhSeUZ1RDBxUXNKc2p6cnVF?=
 =?utf-8?B?TTVibG5jRUI0TFcwUW9PYnl5ek8ybXFHVHNRMURML2FINGxERnRuVmhXVnR2?=
 =?utf-8?B?TllNdWV2dTBoUFI4U0NrNDN0L0FkZUR0QW04eFVwMWZxNmZtZko2YlZGWmZt?=
 =?utf-8?B?Y2RDaHBhaUZ4VE9iY2JwNU5LZGFHdmluUXJWRU1yUndlckxXY1JpVDk1U2xu?=
 =?utf-8?B?eTF3ZjE0MlZybkNpcGIwN3htcHFabVkreER6K3EvakRmc1JPQVg5bXJFTjg0?=
 =?utf-8?B?aTIwR2xoR0dvdVBTN1BnNFpXc3lveXI4bllRRmpqSGRETkhXeUovWVR5MVpN?=
 =?utf-8?B?djhmTWxSdEM3b0g1dnROcmp5dDhLT25SYWhGcngrdTZEVG9hMkZxaThEM2Nq?=
 =?utf-8?B?blpyUnUxV2RpMTA1RmdQTXJmaE1ISjJFUUJmZXoycm4vblQxTzhSQ2ZRSzla?=
 =?utf-8?B?cXBxbGdQT0E1cEpJT2ZsZldOYm9iVHdXTCtmK1lLRmw5RXRYemRjV2NTYnVZ?=
 =?utf-8?B?WVFFbjZJUlZ6UFQySHFsWUQ0eVlsMnRNb2VUc09iTFZxYS9NYkRFQTgwQUg1?=
 =?utf-8?Q?Tx6PvC3pobNyoz0Xx79YfalSDbqUx/lldaVpP0JyNteH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2107c11c-b674-45f3-3c90-08db2968f798
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:31:41.2062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7fKcN7grwUc24/SbAr6iFO17AlaeBgisycyWLqUL0qoZqVDKfJtazzYtPF/TwLp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ah, yes! GART doesn't need to be read to make a GTT allocation.

When GART becomes ready it will be filled with all the buffers which 
were allocated before it was ready.

So this is perfectly fine.

Thanks,
Christian.

Am 20.03.23 um 18:24 schrieb Kim, Jonathan:
> [Public]
>
> This was a long time ago but I think we agreed allocation was ok before GART was ready.
> IIRC, there was also some mentioned related scenario where APUs needed to work without VRAM but allocations were required (but I don't know the details regarding that).
> I vaguely remember the requirement for GART readiness for the bounce buffer allocation caused some problems elsewhere.
> Are there problems observed with the bounce buffer being allocated without GART readiness?
>
> Thanks,
>
> Jon
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Monday, March 20, 2023 1:02 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; Kim, Jonathan
>> <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: improve debug VRAM access performance
>> using sdma
>>
>> Caution: This message originated from an External Source. Use proper
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> I don't think so. Have we recently re-ordered something here?
>>
>> Christian.
>>
>> Am 20.03.23 um 08:05 schrieb Quan, Evan:
>>> [AMD Official Use Only - General]
>>>
>>> I happened to find the sdma_access_bo allocation from GTT seems
>> performing before gart is ready.
>>> That makes the "amdgpu_gart_map" is skipped since adev->gart.ptr is still
>> NULL.
>>> Is that done intentionally ?
>>>
>>> Evan
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>> Jonathan Kim
>>>> Sent: Wednesday, January 5, 2022 3:12 AM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan
>>>> <Jonathan.Kim@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>>>> Subject: [PATCH] drm/amdgpu: improve debug VRAM access performance
>>>> using sdma
>>>>
>>>> For better performance during VRAM access for debugged processes, do
>>>> read/write copies over SDMA.
>>>>
>>>> In order to fulfill post mortem debugging on a broken device, fallback to
>>>> stable MMIO access when gpu recovery is disabled or when job
>> submission
>>>> time outs are set to max.  Failed SDMA access should automatically fall
>>>> back to MMIO access.
>>>>
>>>> Use a pre-allocated GTT bounce buffer pre-mapped into GART to avoid
>>>> page-table updates and TLB flushes on access.
>>>>
>>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 78
>>>> +++++++++++++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  5 +-
>>>>    2 files changed, 82 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 367abed1d6e6..512df4c09772 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -48,6 +48,7 @@
>>>>    #include <drm/ttm/ttm_range_manager.h>
>>>>
>>>>    #include <drm/amdgpu_drm.h>
>>>> +#include <drm/drm_drv.h>
>>>>
>>>>    #include "amdgpu.h"
>>>>    #include "amdgpu_object.h"
>>>> @@ -1429,6 +1430,70 @@ static void
>> amdgpu_ttm_vram_mm_access(struct
>>>> amdgpu_device *adev, loff_t pos,
>>>>       }
>>>>    }
>>>>
>>>> +static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object
>>>> *bo,
>>>> +                                    unsigned long offset, void *buf, int
>>>> len, int write)
>>>> +{
>>>> +    struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
>>>> +    struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
>>>> +    struct amdgpu_job *job;
>>>> +    struct dma_fence *fence;
>>>> +    uint64_t src_addr, dst_addr;
>>>> +    unsigned int num_dw;
>>>> +    int r, idx;
>>>> +
>>>> +    if (len != PAGE_SIZE)
>>>> +            return -EINVAL;
>>>> +
>>>> +    if (!adev->mman.sdma_access_ptr)
>>>> +            return -EACCES;
>>>> +
>>>> +    r = drm_dev_enter(adev_to_drm(adev), &idx);
>>>> +    if (r)
>>>> +            return r;
>>>> +
>>>> +    if (write)
>>>> +            memcpy(adev->mman.sdma_access_ptr, buf, len);
>>>> +
>>>> +    num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
>>>> +    r = amdgpu_job_alloc_with_ib(adev, num_dw * 4,
>>>> AMDGPU_IB_POOL_DELAYED, &job);
>>>> +    if (r)
>>>> +            goto out;
>>>> +
>>>> +    src_addr = write ? amdgpu_bo_gpu_offset(adev-
>>>>> mman.sdma_access_bo) :
>>>> +                    amdgpu_bo_gpu_offset(abo);
>>>> +    dst_addr = write ? amdgpu_bo_gpu_offset(abo) :
>>>> +                    amdgpu_bo_gpu_offset(adev-
>>>>> mman.sdma_access_bo);
>>>> +    amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
>>>> PAGE_SIZE, false);
>>>> +
>>>> +    amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
>>>> +    WARN_ON(job->ibs[0].length_dw > num_dw);
>>>> +
>>>> +    r = amdgpu_job_submit(job, &adev->mman.entity,
>>>> AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
>>>> +    if (r) {
>>>> +            amdgpu_job_free(job);
>>>> +            goto out;
>>>> +    }
>>>> +
>>>> +    if (!dma_fence_wait_timeout(fence, false, adev->sdma_timeout))
>>>> +            r = -ETIMEDOUT;
>>>> +    dma_fence_put(fence);
>>>> +
>>>> +    if (!(r || write))
>>>> +            memcpy(buf, adev->mman.sdma_access_ptr, len);
>>>> +out:
>>>> +    drm_dev_exit(idx);
>>>> +    return r;
>>>> +}
>>>> +
>>>> +static inline bool amdgpu_ttm_allow_post_mortem_debug(struct
>>>> amdgpu_device *adev)
>>>> +{
>>>> +    return amdgpu_gpu_recovery == 0 ||
>>>> +            adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
>>>> +            adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
>>>> +            adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
>>>> +            adev->video_timeout == MAX_SCHEDULE_TIMEOUT;
>>>> +}
>>>> +
>>>>    /**
>>>>     * amdgpu_ttm_access_memory - Read or Write memory that backs a
>>>> buffer object.
>>>>     *
>>>> @@ -1453,6 +1518,10 @@ static int amdgpu_ttm_access_memory(struct
>>>> ttm_buffer_object *bo,
>>>>       if (bo->resource->mem_type != TTM_PL_VRAM)
>>>>               return -EIO;
>>>>
>>>> +    if (!amdgpu_ttm_allow_post_mortem_debug(adev) &&
>>>> +                    !amdgpu_ttm_access_memory_sdma(bo, offset, buf,
>>>> len, write))
>>>> +            return len;
>>>> +
>>>>       amdgpu_res_first(bo->resource, offset, len, &cursor);
>>>>       while (cursor.remaining) {
>>>>               size_t count, size = cursor.size;
>>>> @@ -1793,6 +1862,12 @@ int amdgpu_ttm_init(struct amdgpu_device
>> *adev)
>>>>               return r;
>>>>       }
>>>>
>>>> +    if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
>>>> +                            AMDGPU_GEM_DOMAIN_GTT,
>>>> +                            &adev->mman.sdma_access_bo, NULL,
>>>> +                            adev->mman.sdma_access_ptr))
>>>> +            DRM_WARN("Debug VRAM access will use slowpath MM
>>>> access\n");
>>>> +
>>>>       return 0;
>>>>    }
>>>>
>>>> @@ -1823,6 +1898,9 @@ void amdgpu_ttm_fini(struct amdgpu_device
>>>> *adev)
>>>>       ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
>>>>       ttm_device_fini(&adev->mman.bdev);
>>>>       adev->mman.initialized = false;
>>>> +    if (adev->mman.sdma_access_ptr)
>>>> +            amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo,
>>>> NULL,
>>>> +                                    &adev->mman.sdma_access_ptr);
>>>>       DRM_INFO("amdgpu: ttm finalized\n");
>>>>    }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> index 91a087f9dc7c..b0116c4a768f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> @@ -98,6 +98,10 @@ struct amdgpu_mman {
>>>>       u64             fw_vram_usage_size;
>>>>       struct amdgpu_bo        *fw_vram_usage_reserved_bo;
>>>>       void            *fw_vram_usage_va;
>>>> +
>>>> +    /* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>>>> +    struct amdgpu_bo        *sdma_access_bo;
>>>> +    void                    *sdma_access_ptr;
>>>>    };
>>>>
>>>>    struct amdgpu_copy_mem {
>>>> @@ -193,5 +197,4 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct
>>>> amdgpu_device *adev, struct ttm_tt *ttm,
>>>>    int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int
>>>> mem_type);
>>>>
>>>>    void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
>>>> -
>>>>    #endif
>>>> --
>>>> 2.25.1

