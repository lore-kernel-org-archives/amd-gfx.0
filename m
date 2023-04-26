Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DBAC7618E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 16:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D6610E252;
	Wed, 26 Apr 2023 16:59:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD1110E252
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 16:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5hf8uVpeYxQqDT3QAhnwA5n1kTRpRhl58mJ+YfEiw9c8G0LTAvaDp4TkCb6HmuvedGfjWiW/NBSeB70ZQeoj8zCA+YzwnDcHjn/YTIyMVr/eXZnSX03Bv6DIQ4X4ffYDHvbyuvDZsiqHHdpNK8Fre15nsiG69EiPNzpftW6rgNyYny9R3UYsVn7QJUEbitJX8/D4K3jdhaZ1vOXGmP/3U6Tb7z6L4GiTSW9tx+1G7ypPeBLZPb5OQ38D11XLCg4oQyb6w50lsUcTciQYzN2OQd/XU3ZDMsU5yvWUCdiUToUSgggv3S0T77jwlFUIvwh3YJMEQj5YHLLcrz144cJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUCtA5v0jXILtREYvvNbUn8clfv/0Qm9ZiNm0yJDdK4=;
 b=UqET0CwmbMwOBKwtnlt6Wn0tuY51DHmHav6jKx+kjJq2xtjfSFuiJ7HxuVltSd1+quonlhCETq8pdLAo2F3JNznuClOV5u/wcA933Zh7TRgsAqchhO8ok2fcwp9ZmQu1mbw+mS+j8Due7K4sof7N3NZnQ1XfG/cA0OQWDWD3qJpFtE+8ddWX2piVWfhaZG5Hj/8P0NGNcH79C4LI1kjObE1AV3kbh3ZKQSY3D8sDzXAmduhcQSaRJlGRBHmgbeDJk9LLmuLiE5WK1VGemqBU7Zd9rNnEWpT3hcSiQrpglR+TxsGLy1iyulQAUqvFabfx+MfTGNT1pK1lpelcSNbI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUCtA5v0jXILtREYvvNbUn8clfv/0Qm9ZiNm0yJDdK4=;
 b=NFSCT86s4lmEoDK3f380uS8FBmpAQNIPysOJKbV5e4cxSz3FaBIG0aPXzE0Kji2UICSihohPW5x1xg718i3/mCB02QlDxHTX9vOh8/KWWfuZHWPaeEh7zKajWRt/Kal8jkUDZOKpw50Zns9EMY0pTAvmro6JiiCQ72g00mOaHrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 16:59:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6340.020; Wed, 26 Apr 2023
 16:59:16 +0000
Message-ID: <04b2fcfc-90d8-5398-9ccf-58dfd178d73b@amd.com>
Date: Wed, 26 Apr 2023 11:58:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences invalidating
 preemptible DMABuf imports
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Eric Huang <jinhuieric.huang@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230412222511.236384-1-jinhuieric.huang@amd.com>
 <ce2de03d-27c5-a7ad-1a76-814cbd92f15e@amd.com>
 <6d32ae76-08fa-64a4-6726-2d55e8c9fc08@gmail.com>
 <7df3dfd1-d89c-1f24-c3b9-789e1bedf138@amd.com>
 <73c8c82e-907a-1666-b05b-4ba257363a01@amd.com>
 <8b8d22bd-0eff-2f81-9267-07c4c4d058d1@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <8b8d22bd-0eff-2f81-9267-07c4c4d058d1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:610:b0::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: 2558d0dc-b98f-45ce-dcbd-08db467791d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UapfC4Fbn43k1PGdA/kG1YGvcLJCD7tIJmNkkGG4gETCJCC5imC4zBDZpHGZoDgksQMNWI/xqLIGKE4QHTH6RjylViduIayqD/gugS0XG0aYDMaKorLN/CBXu6viaRdF9CSfArWwx+IJjv2VmZ36R0vB0Fx/B+NaNGinlsWVYGsWHrkRvzK/KuoPNaaWmHQhJQXRCKWvEZA/okGC54olQCDOjtIDZFOWyU0hvF/+rMI5iEeKJJKRGx6WlKpX/r0Mk3lSBNh9GKMIE17iUtdSZ9aD9icprEDCRnSA9fXlFHdtUdXBuz7Z0r1UhNY22jjXD1i6luhHFai+4QzKdY4gmNaSOPkSm38Pes3smenlIQMYEx4E1TDhM3LibPA5IfCkW0q7m779hBZ6Lp1N1Bnnovz5Xu3aTss/3pVxduGN/kbsb+QC4eGCy5LNqB6d5D2NvDq1qsC1LlmkFE1QuTuZ3KC1vwMBCUZvEievqdlQ5ixeoAtT5ceot9NafpHFn1/W2oOlCQAfQ/giaNRnClUI/Z26Mq8u/9fau9hbdqrPRT7z66XxM3+ZSaXxbNg4RAyI+fbFgVvfDdxtuH67WvUPmlt6JfwfVQ42OizK52laqAmTcOWWpCBWnm3l8/xpoJy5Mj8gY56BgJWuRJT225aUPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199021)(44832011)(316002)(38100700002)(41300700001)(5660300002)(8676002)(8936002)(36756003)(31696002)(86362001)(2906002)(66476007)(66556008)(6486002)(6666004)(6512007)(26005)(6506007)(53546011)(2616005)(478600001)(83380400001)(66574015)(186003)(31686004)(110136005)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnNMSk1uYjNpSTJ0d1QvRUVFWXJwaGNvRTBia1RGVjRPaCsyQ2wrNHpFNGV0?=
 =?utf-8?B?TlFLd1Q2NHViNDYvelowWHQ3WEVWWG9zcG9UK2NxZHhwWFdpNExqMEY3TkE2?=
 =?utf-8?B?TGMzZ21qazJjYXhGemZSS2FTSHRhUGcwWU40RVBLM3ZvUm42VzhxVkg1bFpU?=
 =?utf-8?B?cmNTQnNkTUhPdkhlZjEvTkNMemdJMllFU1k0b2dCM0pRUjVXZldzQi9sMHNu?=
 =?utf-8?B?eWx4Y2xiWjZ3T0s4NmsrY3ZSbHl0R3VzSkVtTnRVNWpPcTJtWmtLOEhYSDBN?=
 =?utf-8?B?eUVaRjRPWVVsbGhjYVRUK3JURExXZXFrNk9KRlArUWRlbHZ2ZzV1VGhEMU5n?=
 =?utf-8?B?ckpXTDFVT1JhbHdzU293YWduTVlFMFFjTEMwSC9PWTkxNzlXSlIva1ZxN2FK?=
 =?utf-8?B?QzNQNFRsaUtFeHlhZkszV00wekZtQ2ZONThUdUdCOWlNcVZWWDl2VU1ZeUhi?=
 =?utf-8?B?eWtsNWh5bktyOVVFREJ6L0I2ellaNkRLaHJaSENEZmVEMEpuem16TUNXR3FC?=
 =?utf-8?B?VkJsUmRKOTM0amJFZTBTNnd0ak1MdDhOL0ZnS2lWQWVxQzFSQytxYVpQVVk3?=
 =?utf-8?B?WTNWUXhuQ2phRnJKLzl3RThqR09sWE1mb0MzUE54T0xReFA0a29PQm1FUVhB?=
 =?utf-8?B?dHF4Q1BMcGNOa1lsb29rT0svN0dPNk5EM0l3ZTJNcFZ6WkwzODdxRWJQU2Vl?=
 =?utf-8?B?KzgvaHZHRVdvQUszUSthUEZkS3hmandpSWVaYStTdlVpaU11L21XMGNnL2pH?=
 =?utf-8?B?aDhiL3RQYzY1UG9zcjNlK2orR2JaQzk3MU1Fam9ESDFSTCtpVE91TmtLdXkz?=
 =?utf-8?B?R3Y4VEpZSGpBaWgxbEhDY2U4ci8vck9rK3Rsa0FnN01MMzBKTFBrRDBjOHR6?=
 =?utf-8?B?c2ZwK3M3bWxMazRuWVZYNll6UFVtaWhyMlBLcm11TjJwUmxZOTMxVnNMdmF4?=
 =?utf-8?B?cVc1MU5DMm1iQTlxbVZ1eGpYVmFTaFBYOFl0dWx5dStsOW9lNnA0WC9UOHhy?=
 =?utf-8?B?MU8zM2lkd09PVDZaZ0VXSkRmUmFlTVc1Sm5mS3dULzd3UEg0RzNrcjBjbFlk?=
 =?utf-8?B?SzIvajZzTmNMa2ErUlBGblc1enY2N3ExeG5XcWtERHZsQlBDTGVOR3J1TGZm?=
 =?utf-8?B?MGRlS1Z5SFJpOC9WUnYvMVBoZjBOTitFaExhcGYxS2tEYzMxZDFTQi9tZ01Z?=
 =?utf-8?B?VzFnelNMTmdLK3VFYkpKNkQ3MDBZS0dTS3dobkhRSktJV2w0VTJEZ29KS3N4?=
 =?utf-8?B?dFpvVG5kTDI4OHQzeUR3aEE2aHdFSlF2ZjFRQVMvbWhVSnpQdXVRMW1oUW9Z?=
 =?utf-8?B?MXBScWRUa3dhT3dJTUxBcDJSS1FVQk5TZkNnOGxPd0xCb1ovd3NkL29DZjEw?=
 =?utf-8?B?YjAxTmdxMGo5azJ5ejJCYUNSRnM3cEdMdGQ3UnhLSUdCeVg3UHZ2ZzFvTFg4?=
 =?utf-8?B?cXBPRjBrV3FUZ2F2Sk1mMjUySHppOW9BZ1lzU0hza2NzNzhyNm5aWW91VXd6?=
 =?utf-8?B?Q2tteUtkTW9hQ1ltTkRWQjdIV09jZUNzemhXaWxVMkxEa3dWQ0thRVFTTHlS?=
 =?utf-8?B?WGt1cW9qdVErNFAyMlNwVEZMZXZrS1RkTFMreVViY29hMjhWVkJtbjZkWVlU?=
 =?utf-8?B?aUhWMzE0Q3Z4b3JCdWc2Q0FuckRtSWZTZm1IbHJrSnM0WVJjdTFYbHRqN0M4?=
 =?utf-8?B?Q2l2dEN2cjE4MDBpbUIrV2ZTRCtaUGdFZSswdFVMQUh5V2ptL1NNVXc5V0hS?=
 =?utf-8?B?RlFwMVFpYzNJbFdVR2lEd3BHU0Jqbzkybit1WmFUMzBlQ2ZmK3NHMldQMGZi?=
 =?utf-8?B?bUpYNDlWS0VCWGcvSDdJaGU5amcwUVBPcW9hMjJYQU1Od1hncS9hUFhWTmJl?=
 =?utf-8?B?V1p5T0hpQTJPSlRjMHpXeEwxUjc2Yi9yM0xiU1JoQWtxYWIwZkpLWkU1QTA3?=
 =?utf-8?B?Ujc3Zmphc1AvZ3BsQVhtcEhBalU2ZXNNdmViYTV3bUZoR2tRdmw1bHBMbklL?=
 =?utf-8?B?RGlReGxjKzUrT2JjcVRnbndGOUhyYmpvRGc2a1FQRjVXQzd2THowUDBaRjY0?=
 =?utf-8?B?M0JkR1QyVlRMQ1ZINXBkUGNiN3kwUTkyRHNMbUpSUCtSQitMdHNDZ0gveWdV?=
 =?utf-8?Q?uE2A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2558d0dc-b98f-45ce-dcbd-08db467791d8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:59:16.6991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: as42rNIfp7EeKKY+qexYvx2EHqyknOvf2Z8yLTenwOCyUCdm3ytQZ17Cb8b6cFSV0ta35B/dmzKOG5eBuT3PUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
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


On 2023-04-26 9:03, Christian König wrote:
> Am 25.04.23 um 16:11 schrieb Eric Huang:
>> Hi Christian,
>>
>> What do you think about Felix's explanation?
>
> That's unfortunately not something we can do here.
>
>>
>> Regards,
>> Eric
>>
>> On 2023-04-13 09:28, Felix Kuehling wrote:
>>> Am 2023-04-13 um 07:35 schrieb Christian König:
>>>> Am 13.04.23 um 03:01 schrieb Felix Kuehling:
>>>>> Am 2023-04-12 um 18:25 schrieb Eric Huang:
>>>>>> It is to avoid redundant eviction for KFD's DMAbuf import
>>>>>> bo when dmaunmapping DMAbuf. The DMAbuf import bo has
>>>>>> been set as AMDGPU_PL_PREEMPT in KFD when mapping.
>>>>>>
>>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>>
>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>
>>>>> I'd like to get an Acked-by from Christian as well before 
>>>>> submitting this.
>>>>
>>>> I have to admit that I only partially followed the internal 
>>>> discussion, but in general you need a *really* good explanation for 
>>>> this.
>>>>
>>>> E.g. add code comment and explain in the commit message extensively 
>>>> why this is needed and why there are no alternatives.
>>>
>>> OK. I'll give it a shot:
>>>
>>>    This code path is used among other things when invalidating DMABuf
>>>    imports. These imports share a reservation object with the exported
>>>    BO. Waiting on all the fences in this reservation will trigger KFD
>>>    eviction fences unnecessarily, for example when a DMABuf import for
>>>    a DMA mapping on a secondary GPU is being unmapped explicitly. Only
>>>    moving the original exported BO requires stopping KFD user mode
>>>    queues. If the invalidation is triggered through a move notifier
>>>    from the exported BO, then moving the original BO already triggered
>>>    the eviction fence and we don't need to wait for it again on the 
>>> import.
>>>
>>>    We can identify DMABuf imports in KFD for secondary GPU DMA mappings
>>>    by the mem_type AMDGPU_PL_PREEMPT. In this case, use a wait
>>>    operation that ignores KFD eviction fences.
>>>
>>> How does this sound?
>
> To be honest like quite a bad idea. Why in the world are imported BOs 
> moved from GTT to SYSTEM in the first place?

As I understand it, the way to update SG tables in  SG BOs (e.g. userptr 
and dmabuf imports) is to move them back and forth between system and 
GTT domains. If we left the import in the GTT domain all the time, we 
would have no way to update it, e.g. after an eviction. Currently the 
move to the system domain is done in the unmap code path.

Before memory is freed, we also need to unmap it from GPUVM, including 
the DMABuf imports on remote GPUs. For the above reason that currently 
includes moving the import to the system domain. If we removed that from 
the unmap code path, we'd need to do the move to system somewhere else, 
maybe in the mapping/validation path.


>
> The only reason for this I can think of is that the DMA mappings 
> become invalid for some reasons and in this case waiting for the KFD 
> fence is actually the absolutely right thing to do.

In this case the reason the only reason for unmapping the memory is that 
we're about to free the memory and its DMABuf imports on other GPUs. 
This is coming from the application with a promise "I'm no longer 
accessing the memory". We don't need to wait for fences here. We only 
need to invalidate the PTEs to make sure that any further buggy access 
by the application will fault.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Thanks,
>>>>>   Felix
>>>>>
>>>>>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> index 2430f3e9f3a7..64795fe9eecb 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> @@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct 
>>>>>> ttm_buffer_object *bo, bool evict,
>>>>>>       if ((old_mem->mem_type == TTM_PL_TT ||
>>>>>>            old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>>>>>           new_mem->mem_type == TTM_PL_SYSTEM) {
>>>>>> -        r = ttm_bo_wait_ctx(bo, ctx);
>>>>>> +        if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
>>>>>> +            r = amdgpu_bo_sync_wait(abo,
>>>>>> +                        AMDGPU_FENCE_OWNER_KFD,
>>>>>> +                        ctx->interruptible);
>>>>>> +        else
>>>>>> +            r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>           if (r)
>>>>>>               return r;
>>>>
>>
>
