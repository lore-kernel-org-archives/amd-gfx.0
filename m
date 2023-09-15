Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CEAEEB596
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 14:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F0D10E63F;
	Fri, 15 Sep 2023 14:49:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B25510E63C
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 14:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSgx08VR1ux/VWSD/yVHfCYrP8uqMbEEZN9LVU2Wvd2iX4AgsC03fH6+uNNV+llD2thie4/uoZ5Kh3+QroYdIX1rq2KDQImNmJlhu2ONs89Z0pgjaNN4Ax1V51QBDjLYJhT/BEF8RCgPtseMo+1zP+8z7rrVp2dSrY8ZxmFpWatNNmMma6OYRoOV7u3qhpn9fYG45RviglwQ5K/w0anL9rhbADiWc54MclEqGfjsRvalKrx7loD/Ff8eB2JI2/CjFhfDq7NQVT+k3HEGeM5toM3e4/brURBZ9w5wmVlk1/DwJrgUTyFmdkHbigjaFkuxm+eANfIOfCWqxWTFVeQ80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YOsu8np8K5JCshQu7eSt57eWyHN22leNJmH6ac0M94=;
 b=KrLIiKY84T4FPZWFCJN/DZzySLYwxD4ItiahrQnFVLRpYY1SOXGUwdK0Jrz6U5/1S3wkUfA8jIZrIrDZlkhfNkR68GsjE6lfCPCeweWZL4BxUGCQWzBBhsW/hpu8IgqAeHtlsSbRHizg+pSGuqeHNKp/ecNhEgnbJJhplQtZcB2CdwG1IqhD5L/lh3DUnVbIbFd79cPOJ7dp3kJ/Ge1I3k/OWEyzZc61d12+9a8soIF2MmzNXpeZobU1M8ViPR0QIVrEFZ8qb62UwIKPUfAX7LjPnLcXJ3zSbYXtctiorvQmzv9K7Wa3o4PXR7Y61Nqin0Tm1zra8FS2PlCeVEKu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YOsu8np8K5JCshQu7eSt57eWyHN22leNJmH6ac0M94=;
 b=ta3XIXB7lIl+Jikyd/UdByY3EdsYnJrtx0ORegaQKvol88boRpn5htIFUW/x+Ymy6NQsbcUN8hMErgRbADoHfiKp2tvYo95hEmDPJkuau8pzLF2q+4gN1Cik/jkFMjAc3+qqHZ0Ht/Z1L2oPa9ym7zp+wNvV/d4VA2QpMipgdrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB7083.namprd12.prod.outlook.com (2603:10b6:a03:4ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 14:49:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 14:49:45 +0000
Content-Type: multipart/alternative;
 boundary="------------teiMFkcqzokB0Oc0bMRLoUvY"
Message-ID: <1c4c51ad-a042-983a-ff66-cddfbb917c6f@amd.com>
Date: Fri, 15 Sep 2023 10:49:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] drm/amdgpu: always use legacy tlb flush on
 cyan_skilfish
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Lang Yu <Lang.Yu@amd.com>
References: <20230914092350.3512016-1-Lang.Yu@amd.com>
 <40c096af-6c59-ce6d-af26-5cce7bceab83@amd.com>
 <1317e1a5-b1c0-2c3d-6082-b628fde5ab4d@amd.com>
 <745145aa-76fb-bb17-6065-c5e29c37f3c6@amd.com>
 <e7913001-ff45-169d-7110-3f2bef86208a@amd.com>
 <ZQQbmfuivo/F+b9o@lang-desktop>
 <39f0c4d9-0959-73ed-9bca-43a342fb906a@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <39f0c4d9-0959-73ed-9bca-43a342fb906a@gmail.com>
X-ClientProxiedBy: YQBPR0101CA0292.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: 06237281-30b0-4032-e89d-08dbb5fb0053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUFnmJfNeSNTvTl4Ik5tMVwszeBYUBwycVFVd5KYeT2BpLDjTo7+MHG0mzPOZ7hT94jJEH/f4ocOfg81hfep1IZhgrutrTvFbWZO7xXPNMmY4d44xRfUosrFwKcLuGORRE+FPjQJ4vQRJY4YPFIysd8g4y4b8QwIALmnZ5qvUtsA9pbEqTxQEAtZNXVH/l/JjuQyQuR74xOVWInnAmZHIUAG4JcGZIXAF+UZMGVTqK0XeWKTUX8muC7KT2MmrArfKTxVzlmUy25CrGmaix2X3vPjtHEM1YWU9NbJV7gbYXfJDenF6o2Xwkn1im2xV+exyzAi9G45phfv9nep/N8pvhhVihN7/bv2DplEYndCkmPxsUJwWF8ZQ3qE3iAA8p/6j3LDDa8MuRrcUfiUDSZuFO38C61TeBO74T0kdJs0ULWO5hNRBtCyhLR/BkPUzDJB40vbAX9hFPO+vVwAhsUnSuJIDuGDc/5Vx07D4fnGwoMU5ZXEqGqipPju4neXKhVvXrFPUNtR8BTV3H/9yqorHxogxxgryKmAocD2k9qIqBNO/ful/HdnUW3rWNnj1rCobe/1rk9+FpTABL6yArdkL66rVvk2l/r+P+gsIy7quKTsvhu8FxavoS17BW+Ms1hdTsIDkjXD9tEfpN7XmAxm0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(1800799009)(186009)(451199024)(66899024)(83380400001)(66574015)(2616005)(26005)(66946007)(66476007)(66556008)(6636002)(54906003)(316002)(8936002)(8676002)(44832011)(5660300002)(41300700001)(6506007)(53546011)(33964004)(6666004)(4326008)(30864003)(2906002)(478600001)(6486002)(6512007)(110136005)(86362001)(31696002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW9FM2w1ZlFEeHI2cm8rSTQxM3pkMWtjWVUyS3BkZzFpd3VqVTNIVnBkQUxD?=
 =?utf-8?B?dTdoOVMvdDlCNUhKdTdVcFlFVklPbS9mTmo2Nnh6U1orNmFVSGh4ZG1hNWdG?=
 =?utf-8?B?a1Y5S0p2SjgvS2MrMlI2TWI1WENaeXdnTEhteWVPbW9heXo1VHBPN21sd0Y5?=
 =?utf-8?B?eGQvbHczNW1UWlZqczRuNHlUNWNDc1JKZjM1b1ZFaFdsRzlmaktmeVdiaHFZ?=
 =?utf-8?B?TnlZaHpLWENEUWZFRys2VWsvUmo4L0R0OVBzaDRXN1dObFVENXB5YzlHanpU?=
 =?utf-8?B?REo2YytiUXdWbWtKRmZCQ205OEZEcnExZlplRnUxbnhHRVd4cy9uNWZTbWpK?=
 =?utf-8?B?eGllUisyWFU3TGl6UVpnemU1V29kd0txN1Z4OXUxbWNjb3Y0Vzhpc2Y4eEhn?=
 =?utf-8?B?QlVQTXlhN0dJUXdjTDZBMithcUNuYXdXbmhVRi96U0VyRzBjdkl1dzdEWHhk?=
 =?utf-8?B?eTc1bE5yK2JXeXgvS29NbWYwZC9oM2RTWTZURXI1UTVvOU1hTGxXQUQvOVBO?=
 =?utf-8?B?ZE5hdnFyeUwzSjZodkhYYWowdnE3M0ZwNkMwSWx2S095N2hvM1dNWUpuL3JU?=
 =?utf-8?B?R3VraERTTVl1QTkraWhpRmx6N3ZUbDJFSURqOHpTWkowSG1KV0tybUtjNWNy?=
 =?utf-8?B?MGFXdHNYb2FsYkt5bExjWFNhb1hLRFN3dVZPZDdXY1g1VWV2RXNVeUJCWVA4?=
 =?utf-8?B?cVBjN3YwNldidUNjR1EvRmtPMlRaOEFOMWVqUTFzS3QxY0tCRFF3eS9GK1dE?=
 =?utf-8?B?QmdFRHltL2lidzNjQklVQXVnNkM3L3VFcDk2VytBcEhiK1llQnJXbDRRRWpK?=
 =?utf-8?B?RnpOZXMvc1FJS09YS2JDTWFuN0ZQTlYvdElHWEFEUzhLOWhpZjZrbjJqM0ZY?=
 =?utf-8?B?NGZZVFg2ZllBNTdFQStoK1ljaXl5ejRtV2RjbDNyTVg3RHNncmlQQkJLREQz?=
 =?utf-8?B?ejI3eU16WVc2U2NRN0ZxeFBOek4zK3NwajNZamVPMFBhQ1J0QytGeHhBUGN4?=
 =?utf-8?B?bk5kc1NzV3dWSWdNV2Zhd01CYWhxT3czN2JTcHo1azhYVEZ0T2hyMG4vc0pl?=
 =?utf-8?B?cWRnL3NoWDNiQW1OeDJwdkxHYTZFc1Z6VUN5MVFTZmJDWENUT2VsN21KSnZQ?=
 =?utf-8?B?TmN0NzVteGFxR0FyY2VCTjRXNTErUUNkL3BjL3gremlURWRQNGwvL0xnVjcr?=
 =?utf-8?B?SHcxVDNYV2h4bzMxTkk1eG9OdktXRDFMS0tQTW9JWC9FZlV1SS9GZm5hVE52?=
 =?utf-8?B?aEJpRmNTMjdLN0JPaFExSzg5cGtQaytuZTFxbU5LT1hPeXNyRW8xWW5pZFpI?=
 =?utf-8?B?M0lHVDdYbWlxdWZ5WmI4RTMycmFCajVybmhlTzUxZGVWM2E0dkxnMkVsNGpm?=
 =?utf-8?B?SW5UK0JwK2Y4V0ZWbGxNUDA2TUc5T1V1RjF1YThydHFLSTFMQXdkR0FxakFO?=
 =?utf-8?B?TjAzTHh4Ni9aMmJiOHBSTUxYbnpGR2JDOUFSM01qWDFBZ0hXTlZaYU1pVllx?=
 =?utf-8?B?OHg2RlQ4Yzc5UXNCQU5lRE4wRTVvMWp4SDFYRmhlb085dVdlV25JRk9FOWRk?=
 =?utf-8?B?VzRHREU2RGUwZ3RXZUhmWXBoUnNsV0tDS0NHcnBTb2sxZlN3L05zc1ZNOTVP?=
 =?utf-8?B?NFVCZDhKckx1MnFaUHA0L2RHOEhZV05RcGhBWlpzbFZWQzZqZmQ1WUNvZXlO?=
 =?utf-8?B?cFRiY1dCVjdmZERGQTVtNHl6NG1EQ2tHODk1U3BwWEJPR1VUT242VGhWanZZ?=
 =?utf-8?B?Qm5iNnpkUERrL3BaOHVXWXhRRVlJLzRhMXJ1OE5JMWc0RVBYNGJKQnRCYS8y?=
 =?utf-8?B?c0tTMFMxZ1RBNTE2Z21kemxkWHQ2dy9jU0Eyak5DRExJRXFBZlhvTVdrRjVr?=
 =?utf-8?B?YXl3bkFXM1JKSkVXQWg2SWNwQ3RRN0wvLzJYMmxDYll4aElkKytNNmlIVVU0?=
 =?utf-8?B?aDdqdkkycFB0ay9aUS9nRkJsbTZyT3RPMEVYeVZNalNYd1A3a3VucE8vNE9L?=
 =?utf-8?B?WVJHQ2k3WnlmR09zOU0rWEd1NDYyR2pwVGJlRlU2QXY5WC9DYUNUQ1I1dnlU?=
 =?utf-8?B?NWVmWnpDS0RsOURUR3pzUXJ3VUhPQnVWUC9oVi92YlVvUkpPbVdrN3VnZ05l?=
 =?utf-8?Q?w/++BlQnW7azhkeDMCgagoUPq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06237281-30b0-4032-e89d-08dbb5fb0053
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 14:49:45.1363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9rdFsPzV8PnBNnw3yKytDG3vT9Mx9ZfKI7XUldMD207mHk3FmX/2LoyguMCu+j2UuvwuNXL4e7piQda1K3IxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------teiMFkcqzokB0Oc0bMRLoUvY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-09-15 6:19, Christian König wrote:
> Am 15.09.23 um 10:53 schrieb Lang Yu:
>> On 09/14/ , Felix Kuehling wrote:
>>> On 2023-09-14 10:02, Christian König wrote:
>> Do we still need to use legacy flush to emulate heavyweight flush
>> if we don't use SVM? And can I push this now?
>
> Felix needs to decide that. From what I understand the KFD needs 
> heavyweight flushes for secure SVM operation.

Yes. We need to be able to guarantee to the kernel, that the GPU will 
not access unmapped memory. There are two strategies in the driver to do 
this:

 1. Preempt GPU queues (which implies a heavy-weight TLB flush in the
    scheduler firmware)
 2. Invalidate page table entries and flush TLBs

#1 happens during MMU notifiers with XNACK off. #2 happens in MMU 
notifiers with XNACK on (not supported on GFX10.x) and when unified 
memory us munmapped. It's that last part I'm worried about. When memory 
is munmapped and given back to the OS, we need to be able to guarantee 
that the GPU won't access it any more. The same is true when GTT BOs and 
userptr BOs are freed. After unmapping them from the GPU page tables, we 
need a heavy-weight flush. I believe the same should apply to the 
graphics driver, but maybe that's implied through the CS and fence 
mechanisms that keep memory allocated while the GPU is accessing it.

A legacy flush has a slim chance of not being sufficient because memory 
accesses using old addresses can still be in flight in the GPU.


>
> If heavyweight flushes are buggy papering over that by using legacy 
> flushes is only a mediocre workaround.

I agree. I'd like to avoid half-baked workarounds that will cause more 
headaches later on. I started an internal email thread with Tony to 
understand the requirements for heavy-weight flushes on the affected 
GPUs and find a better workaround.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Regards,
>> Lang
>>
>>
>>>> Am 14.09.23 um 15:59 schrieb Felix Kuehling:
>>>>> On 2023-09-14 9:39, Christian König wrote:
>>>>>> Is a single legacy flush sufficient to emulate an heavyweight
>>>>>> flush as well?
>>>>>>
>>>>>> On previous generations we needed to issue at least two legacy
>>>>>> flushes for this.
>>>>> I assume you are referring to the Vega20 XGMI workaround. That is a
>>>>> very different issue. Because PTEs would be cached in L2, we had to
>>>>> always use a heavy-weight flush that would also flush the L2 cache
>>>>> as well, and follow that with another legacy flush to deal with race
>>>>> conditions where stale PTEs could be re-fetched from L2 before the
>>>>> L2 flush was complete.
>>>> No, we also have another (badly documented) workaround which issues a
>>>> legacy flush before each heavy weight on some hw generations. See 
>>>> the my
>>>> TLB flush cleanup patches.
>>>>
>>>>> A heavy-weight flush guarantees that there are no more possible
>>>>> memory accesses using the old PTEs. With physically addressed caches
>>>>> on GFXv9 that includes a cache flush because the address translation
>>>>> happened before putting data into the cache. I think the address
>>>>> translation and cache architecture works differently on GFXv10. So
>>>>> maybe the cache-flush is not required here.
>>>>>
>>>>> But even then a legacy flush probably allows for in-flight memory
>>>>> accesses with old physical addresses to complete after the TLB
>>>>> flush. So there is a small risk of memory corruption that was
>>>>> assumed to not be accessed by the GPU any more. Or when using IOMMU
>>>>> device isolation it would result in IOMMU faults if the DMA mappings
>>>>> are invalidated slightly too early.
>>>> Mhm, that's quite bad. Any idea how to avoid that?
>>> A few ideas
>>>
>>>   * Add an arbitrary delay and hope that it is longer than the FIFOs in
>>>     the HW
>>>   * Execute an atomic operation to memory on some GPU engine that could
>>>     act as a fence, maybe just a RELEASE_MEM on the CP to some 
>>> writeback
>>>     location would do the job
>>>   * If needed, RELEASE_MEM could also perform a cache flush
>>>
>>> Regards,
>>>    Felix
>>>
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Regards,
>>>>>    Felix
>>>>>
>>>>>
>>>>>> And please don't push before getting an rb from Felix as well.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>
>>>>>> Am 14.09.23 um 11:23 schrieb Lang Yu:
>>>>>>> cyan_skilfish has problems with other flush types.
>>>>>>>
>>>>>>> v2: fix incorrect ternary conditional operator usage.(Yifan)
>>>>>>>
>>>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>>>> Cc: <stable@vger.kernel.org> # v5.15+
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
>>>>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>>> index d3da13f4c80e..c6d11047169a 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>>> @@ -236,7 +236,8 @@ static void
>>>>>>> gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t
>>>>>>> vmid,
>>>>>>>    {
>>>>>>>        bool use_semaphore =
>>>>>>> gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
>>>>>>>        struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>>>>>>> -    u32 inv_req =
>>>>>>> hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
>>>>>>> +    u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid,
>>>>>>> +              (adev->asic_type != CHIP_CYAN_SKILLFISH) ?
>>>>>>> flush_type : 0);
>>>>>>>        u32 tmp;
>>>>>>>        /* Use register 17 for GART */
>>>>>>>        const unsigned int eng = 17;
>>>>>>> @@ -331,6 +332,8 @@ static void
>>>>>>> gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t
>>>>>>> vmid,
>>>>>>>          int r;
>>>>>>>    +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH)
>>>>>>> ? flush_type : 0;
>>>>>>> +
>>>>>>>        /* flush hdp cache */
>>>>>>>        adev->hdp.funcs->flush_hdp(adev, NULL);
>>>>>>>    @@ -426,6 +429,8 @@ static int
>>>>>>> gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>>>>>>        struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
>>>>>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>>>>>>    +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH)
>>>>>>> ? flush_type : 0;
>>>>>>> +
>>>>>>>        if (amdgpu_emu_mode == 0 && ring->sched.ready) {
>>>>>>> spin_lock(&adev->gfx.kiq[0].ring_lock);
>>>>>>>            /* 2 dwords flush + 8 dwords fence */
>
--------------teiMFkcqzokB0Oc0bMRLoUvY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023-09-15 6:19, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:39f0c4d9-0959-73ed-9bca-43a342fb906a@gmail.com">Am
      15.09.23 um 10:53 schrieb Lang Yu:
      <br>
      <blockquote type="cite">On 09/14/ , Felix Kuehling wrote:
        <br>
        <blockquote type="cite">On 2023-09-14 10:02, Christian König
          wrote:
          <br>
        </blockquote>
        Do we still need to use legacy flush to emulate heavyweight
        flush
        <br>
        if we don't use SVM? And can I push this now?
        <br>
      </blockquote>
      <br>
      Felix needs to decide that. From what I understand the KFD needs
      heavyweight flushes for secure SVM operation.
      <br>
    </blockquote>
    <p>Yes. We need to be able to guarantee to the kernel, that the GPU
      will not access unmapped memory. There are two strategies in the
      driver to do this:</p>
    <ol>
      <li>Preempt GPU queues (which implies a heavy-weight TLB flush in
        the scheduler firmware)</li>
      <li>Invalidate page table entries and flush TLBs<br>
      </li>
    </ol>
    <p>#1 happens during MMU notifiers with XNACK off. #2 happens in MMU
      notifiers with XNACK on (not supported on GFX10.x) and when
      unified memory us munmapped. It's that last part I'm worried
      about. When memory is munmapped and given back to the OS, we need
      to be able to guarantee that the GPU won't access it any more. The
      same is true when GTT BOs and userptr BOs are freed. After
      unmapping them from the GPU page tables, we need a heavy-weight
      flush. I believe the same should apply to the graphics driver, but
      maybe that's implied through the CS and fence mechanisms that keep
      memory allocated while the GPU is accessing it.<br>
    </p>
    <p>A legacy flush has a slim chance of not being sufficient because
      memory accesses using old addresses can still be in flight in the
      GPU.<br>
    </p>
    <br>
    <blockquote type="cite" cite="mid:39f0c4d9-0959-73ed-9bca-43a342fb906a@gmail.com">
      <br>
      If heavyweight flushes are buggy papering over that by using
      legacy flushes is only a mediocre workaround.
      <br>
    </blockquote>
    <p>I agree. I'd like to avoid half-baked workarounds that will cause
      more headaches later on. I started an internal email thread with
      Tony to understand the requirements for heavy-weight flushes on
      the affected GPUs and find a better workaround.</p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:39f0c4d9-0959-73ed-9bca-43a342fb906a@gmail.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Regards,
        <br>
        Lang
        <br>
        <br>
        <br>
        <blockquote type="cite">
          <blockquote type="cite">Am 14.09.23 um 15:59 schrieb Felix
            Kuehling:
            <br>
            <blockquote type="cite">On 2023-09-14 9:39, Christian König
              wrote:
              <br>
              <blockquote type="cite">Is a single legacy flush
                sufficient to emulate an heavyweight
                <br>
                flush as well?
                <br>
                <br>
                On previous generations we needed to issue at least two
                legacy
                <br>
                flushes for this.
                <br>
              </blockquote>
              I assume you are referring to the Vega20 XGMI workaround.
              That is a
              <br>
              very different issue. Because PTEs would be cached in L2,
              we had to
              <br>
              always use a heavy-weight flush that would also flush the
              L2 cache
              <br>
              as well, and follow that with another legacy flush to deal
              with race
              <br>
              conditions where stale PTEs could be re-fetched from L2
              before the
              <br>
              L2 flush was complete.
              <br>
            </blockquote>
            No, we also have another (badly documented) workaround which
            issues a
            <br>
            legacy flush before each heavy weight on some hw
            generations. See the my
            <br>
            TLB flush cleanup patches.
            <br>
            <br>
            <blockquote type="cite">A heavy-weight flush guarantees that
              there are no more possible
              <br>
              memory accesses using the old PTEs. With physically
              addressed caches
              <br>
              on GFXv9 that includes a cache flush because the address
              translation
              <br>
              happened before putting data into the cache. I think the
              address
              <br>
              translation and cache architecture works differently on
              GFXv10. So
              <br>
              maybe the cache-flush is not required here.
              <br>
              <br>
              But even then a legacy flush probably allows for in-flight
              memory
              <br>
              accesses with old physical addresses to complete after the
              TLB
              <br>
              flush. So there is a small risk of memory corruption that
              was
              <br>
              assumed to not be accessed by the GPU any more. Or when
              using IOMMU
              <br>
              device isolation it would result in IOMMU faults if the
              DMA mappings
              <br>
              are invalidated slightly too early.
              <br>
            </blockquote>
            Mhm, that's quite bad. Any idea how to avoid that?
            <br>
          </blockquote>
          A few ideas
          <br>
          <br>
          &nbsp; * Add an arbitrary delay and hope that it is longer than the
          FIFOs in
          <br>
          &nbsp;&nbsp;&nbsp; the HW
          <br>
          &nbsp; * Execute an atomic operation to memory on some GPU engine
          that could
          <br>
          &nbsp;&nbsp;&nbsp; act as a fence, maybe just a RELEASE_MEM on the CP to some
          writeback
          <br>
          &nbsp;&nbsp;&nbsp; location would do the job
          <br>
          &nbsp; * If needed, RELEASE_MEM could also perform a cache flush
          <br>
          <br>
          Regards,
          <br>
          &nbsp;&nbsp; Felix
          <br>
          <br>
          <br>
          <blockquote type="cite">Regards,
            <br>
            Christian.
            <br>
            <br>
            <blockquote type="cite">Regards,
              <br>
              &nbsp;&nbsp; Felix
              <br>
              <br>
              <br>
              <blockquote type="cite">And please don't push before
                getting an rb from Felix as well.
                <br>
                <br>
                Regards,
                <br>
                Christian.
                <br>
                <br>
                <br>
                Am 14.09.23 um 11:23 schrieb Lang Yu:
                <br>
                <blockquote type="cite">cyan_skilfish has problems with
                  other flush types.
                  <br>
                  <br>
                  v2: fix incorrect ternary conditional operator
                  usage.(Yifan)
                  <br>
                  <br>
                  Signed-off-by: Lang Yu <a class="moz-txt-link-rfc2396E" href="mailto:Lang.Yu@amd.com">&lt;Lang.Yu@amd.com&gt;</a>
                  <br>
                  Cc: <a class="moz-txt-link-rfc2396E" href="mailto:stable@vger.kernel.org">&lt;stable@vger.kernel.org&gt;</a> # v5.15+
                  <br>
                  ---
                  <br>
                  &nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
                  <br>
                  &nbsp;&nbsp; 1 file changed, 6 insertions(+), 1 deletion(-)
                  <br>
                  <br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
                  <br>
                  b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
                  <br>
                  index d3da13f4c80e..c6d11047169a 100644
                  <br>
                  --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
                  <br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
                  <br>
                  @@ -236,7 +236,8 @@ static void
                  <br>
                  gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev,
                  uint32_t
                  <br>
                  vmid,
                  <br>
                  &nbsp;&nbsp; {
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_semaphore =
                  <br>
                  gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vmhub *hub =
                  &amp;adev-&gt;vmhub[vmhub];
                  <br>
                  -&nbsp;&nbsp;&nbsp; u32 inv_req =
                  <br>
                  hub-&gt;vmhub_funcs-&gt;get_invalidate_req(vmid,
                  flush_type);
                  <br>
                  +&nbsp;&nbsp;&nbsp; u32 inv_req =
                  hub-&gt;vmhub_funcs-&gt;get_invalidate_req(vmid,
                  <br>
                  +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type !=
                  CHIP_CYAN_SKILLFISH) ?
                  <br>
                  flush_type : 0);
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use register 17 for GART */
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const unsigned int eng = 17;
                  <br>
                  @@ -331,6 +332,8 @@ static void
                  <br>
                  gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev,
                  uint32_t
                  <br>
                  vmid,
                  <br>
                  &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
                  <br>
                  &nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; flush_type = (adev-&gt;asic_type !=
                  CHIP_CYAN_SKILLFISH)
                  <br>
                  ? flush_type : 0;
                  <br>
                  +
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* flush hdp cache */
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;flush_hdp(adev, NULL);
                  <br>
                  &nbsp;&nbsp; @@ -426,6 +429,8 @@ static int
                  <br>
                  gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device
                  *adev,
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                  &amp;adev-&gt;gfx.kiq[0].ring;
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq =
                  &amp;adev-&gt;gfx.kiq[0];
                  <br>
                  &nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; flush_type = (adev-&gt;asic_type !=
                  CHIP_CYAN_SKILLFISH)
                  <br>
                  ? flush_type : 0;
                  <br>
                  +
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_emu_mode == 0 &amp;&amp;
                  ring-&gt;sched.ready) {
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  spin_lock(&amp;adev-&gt;gfx.kiq[0].ring_lock);
                  <br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 2 dwords flush + 8 dwords fence */
                  <br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------teiMFkcqzokB0Oc0bMRLoUvY--
