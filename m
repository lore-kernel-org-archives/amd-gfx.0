Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBED6CD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 15:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A74210E4D8;
	Mon, 18 May 2026 15:11:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oAJhn1Vg";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A06A10E4D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 15:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4yKcd/5VqVyynTCszyde/7VhHsISVSgZenonHe4YOV1deCTzYcQTVgBR5eaVY8/2wNONelE9EJXe1mJvydr7FevCa7kzIBPBXVXdbeovbVHr72rlGoPmjscfGCnrLG+wSVkta0lcUvfG3VSMD77LytLLc3GdUgMhFlBvhQwgKHvg+CU2hgs+KniSFoo1scLluPmOx1RMc+qYhNMA9iglChLKonH5IM5HG076uQbOYOFhh5phUwEcnegiI6OI0K2AvEoyG0sK3e0GvWruKDlr8E5E8o4g6/5chKfTsnAz/Y+HeD3vWRJG6DjY3WmDYFq1/Wpuyif/fTVGh1tOEnnZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQo23v69MCpDxmtaJWnMQBUhhUs3NWmyBr/vtA4rrHM=;
 b=aGcFxkV/inE0+nkMSRR86weEsi3rOlxge0yMu/Oc+CaPdjdNX33i9wUkhai97+J8/5Z79MQVIhbM0nxxCYdIclIwev6FjaBLQ6o51iy1kDC4tvOsTP2qW4EJktkXhyKCAg/u4aE7dxjh2PGz5rnhBvuEI1CRkijY/XWpSDI3EHR4shAshLccaR5Hz04mdBuUwZKCh/8zYvlKFoVDKQANBXEynmJq2r7EKeiv3f0lZDT7acC45MgZsOyf5/XK+KvTMmIb6/zg42mQz36egstKDUDrZoCkb/twbMRkb+MC+DKj2kwL/8CRPVkCOrWnzdrnsR6HzCUvHBj17qS2pKJvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQo23v69MCpDxmtaJWnMQBUhhUs3NWmyBr/vtA4rrHM=;
 b=oAJhn1Vg/GN+nSN0UHaTrHLnhEmqxsN0FecH8S1ggmjth8Ba+MhWXNgeRHpVp7BoW4QPMW6G/7wbXLBCA000StpHSzcufoa7xrWZTpCrTgxvIB2Z1sc1Dvj3zex6KZaw9e5KBVqhm5ELRzDnOrzZyL+itDx3m9FTQJJa44pzwjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 15:11:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 15:11:32 +0000
Message-ID: <92befe19-f779-4dda-84ba-12997d5e144b@amd.com>
Date: Mon, 18 May 2026 17:11:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: userq_va_mapped should remain true once
 done
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260513081418.1727864-1-sunil.khatri@amd.com>
 <2ca8cd17-58f2-4b03-8fa7-3da869208c0c@amd.com>
 <410f0398-0344-40a7-abca-722d76fb98c5@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <410f0398-0344-40a7-abca-722d76fb98c5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:208:530::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b6d2f1-6e0d-40dc-5cc3-08deb4efbec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info: SJMLqqHEBI0Te7vZnuIdqQZ5rsdMPLc6Kdegmb4b1GgBSmtHi+cHQcP9vcJbyD/iy/b/U2nruw+XTHDdZRLzfEWc94IrQ+PNWGZaW/gkuq9wzl8KTrAz5ubc0tsB1yOcXBWkKZjUoZMtDUdcoJArp1s5rzhsB9K6pZrakqwsVZszU9O5GkC1wK4s87oxq9xkAyyipqNRszGGDKPRfAYGi0WpDuzS2BBY4WDtO9QwrpWe91SsmojSgFd2u9Coe1nAVsNLCVR9Vt2TdFcazpdCoybyvJnxgQDSzYA1pJyZg43S+7p3moG5T4th8AffZa6AMjljTtBnxUjdLzTQWn13k34b1GKNHdEOMhXRxHxtFvf76rY059Fa3V80TSV5tWRS8J39wn7YvkCUQ7pM8qV/EaN/2PBgQBGehVrn6wP6iGl7I3Cr0NxOxJP0IJXEPsWsoapnD2kLh2eyoRSAQvs/lqg8I+mD0yYrMUEi5D+OW4VFJAP/lAVWfcB24EX8s7zwk8YVlunEzUeDVE5/Bk7D1vX0Wrq4spKY5rbOVAgrqn/mL5kg5fy3eHL64I6toDSeKXansYcTukbhjeu3SbBMuvtH2sl8QWmsbaxShMvwVgUZGVFRt5tcmq5fFEOAjSFQbFyd1nhZuYDZMLFCI9gfMwud2yapnhqsrNjhHuBthFc/Dg9SROVWJZ4l+8hEB4IB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXc0UTh3YjU4VDJFcVBvMUN5bGF6aXRPaTlGT3hObld2bzBRZGh0VjBraFNq?=
 =?utf-8?B?NGt2bHd5NWhOQ09NNjFEMGNDenM4anAvcUNwZnB3OWk1RmpabTNvb3BZT24y?=
 =?utf-8?B?aTNNKzdrSUUzNTJLT05Sblk2V0xpZnVzbVdlYjVxMWNlcFMyclhLYldrdnBB?=
 =?utf-8?B?OU9vVERTTmtTMlBIVFpoWjl0emZCb1hZZDR6cEtiS3BpeGhPQWk2SklZWDh4?=
 =?utf-8?B?Z3RXYkVaalc5bmM3L1FWWWhuQ3k3YXNIZ0N0cklRYVlvSENwQ2xpK2x3dWM1?=
 =?utf-8?B?OWJlVWIrQ3RTb2tnV1o0Qno2K0pZYmJNMCtaK3NsMVp3VWpyajRtN2RBN3Rn?=
 =?utf-8?B?cVVFcmIwRVZIU2orRGorUzZMbHVGYy9ueFlaN1h5ZlRBWXowMjF3NWpZUWo3?=
 =?utf-8?B?UXk2K2cvOHJyRUxIVlpscFBUSlVib0xUT1B4UUxyNmx3eE9XN1JWTzhRejZt?=
 =?utf-8?B?NVRLTys0L01hN0h6a2gzR2YvQmp2SFRPSG8xV1FiZS8yUXUvY25iVkgraW5j?=
 =?utf-8?B?N1N5Vk9rSDFjcWpLV1JCZU9MMGorMllkVjZzdWhKOER2ZHBCdEg0SXEyeXY2?=
 =?utf-8?B?MDF3Y21pQ2RiRit4L0MwZnRIWG44NjlJK0txVE9RWHdaVEpZYWE2RDdQQU5o?=
 =?utf-8?B?a3hydk9rNkFucHZNZ3VyeFVwcEVnUXZvbmhuMEt1cFBEQTNBclppb3JuVlhv?=
 =?utf-8?B?ZXpualRkazN4MVlmOXVqZ3JuY2ptZVppdVNEaW1Ua2xwdHRyeTZvREhINjJT?=
 =?utf-8?B?T1NJODdXT2QyR28raHZQdlY4SDd6L2lPTzc5TEJVS1luc28zUVROVnloNlFU?=
 =?utf-8?B?endjRHNzREQxT29pYnhyZ2FjMmxlV28rQ2FZTUJPTnROblYxSFlvcWVJSWE3?=
 =?utf-8?B?TWc0UFFNOWRwcWZyWVg3K2hpS2hxdmdiTXRxdm9Ga0RRMTNtUk4xMS8vaU5k?=
 =?utf-8?B?SFFCMFR0SVJmelpURVI2V3Jqb0R4VGY1UlZQQ2Z6K1JrZ05qN1R2Yy8zUlRl?=
 =?utf-8?B?dmdXWTVuYlBZd044NG1ocThmRU5DckM3ME9LS2VvSUllcnNyOGJFMS8wYzlu?=
 =?utf-8?B?WU1rckhMSHJZbnN3S2lLaXRRc1FnSVFmd2k3T3NWVHlCY2prRzllbEhhL0V5?=
 =?utf-8?B?UFNWVit6QjI1dnUxSlRUbzh3OG5rRkZsV2IwNlM3RFRPN0s1VjVKblA0ZmxV?=
 =?utf-8?B?S3puMlB1S2dxNUROMmNsVWMyQktrd2hWZnRCSUl6VWhMZUxVa1Y5dlBheVYw?=
 =?utf-8?B?aS8xRlNYOUppeEpBOXlZd2xwTFgwNE9MM0QwVFpkdG56YjFPWUF2SFphMUlw?=
 =?utf-8?B?R0xobldWWThxUFlEcjhwL2paUW80RWJBNzJia210SnBPWnlaa09wVHhCVFVL?=
 =?utf-8?B?UVU1MkdqUlFpbFh6N1dJTmUwUEYxTmJtbGFwa1R6b0hNZ1FBNVppRDRxQUs5?=
 =?utf-8?B?YXdPNW9PMEw0YnZrSEd6NXMybk9FeTQweEoyTG8xak84NzUxanRabjRiVWFs?=
 =?utf-8?B?TkQvaFNqNVZtYWVqWFlZWkR0cC9zL1pmbFlNVW9pUmNSOVNIN3o2bVNpMzdh?=
 =?utf-8?B?RmZoZjFuMkhSYU5DcThxMDJmUENZdHF0Wm5jMWZJV1lSRnNGL0lSM1ZYbXl0?=
 =?utf-8?B?YVNRbmlmZTQrQm54Q0lSK1RWL3gyNlRRblJ2V0hQTkZSNWhwUWU0NEFoYzBG?=
 =?utf-8?B?ckV5TzRVUGZsMmJTK3hNMktEQk41c0RGNXNWSlNnZXVrRlMvSG9RbTFpMytt?=
 =?utf-8?B?R1lYUzRYZVgzVmc5NjZOM25PZUlpL0wxemtPZFQ2TlNOeTdodzFwTVFzYkFI?=
 =?utf-8?B?QlgwOURLdDRJcjgxVHZLT1VnNG5zK0NnNkNHN3p2dDNDUUFPK0lBdnoyOFZp?=
 =?utf-8?B?S1REL3pyVmhSS044c25ja2t2YTN2NXdsU2p0Z0wzeUZtNW9nS2VNclZpbzU4?=
 =?utf-8?B?VHF5TFhqSjFKUmFNb3lLMlhwdjdSSVJUY3FjWDVWa0Y0OVArbEhFSGd5ZWtI?=
 =?utf-8?B?TytHYUs2REZDVUNvMlRpVkJEalNOdGxmVFNBRnRZcXJxenFXN05jVXJkUzVi?=
 =?utf-8?B?Q20wYWM3S0o1VGxXSWthMEJnTHlwYlNxbHJNd212RERpVkNWa1BZYXhnbER1?=
 =?utf-8?B?ZE5BM0xyRXhvendwWjBDZXB0SC94aE52SVlYbjQ3NEJQd3RHNkVXbkkvNkVt?=
 =?utf-8?B?MUtQcXFLVkZucm9yQi9vSXJabFpSTWh4Z3QxN0hlSzJRbUVYQU1PZDFsU2l4?=
 =?utf-8?B?K0k4anFTcWdNMkg1TTl3cmFQSng3WXUzNW9iVnNxVFlURm9vME5ZT3Y1cTFv?=
 =?utf-8?Q?hHmqN/j5pz2XeAigaT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b6d2f1-6e0d-40dc-5cc3-08deb4efbec6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 15:11:32.5983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUfa9K9qfw1sQd9+6fpiTzCLzMCmObJT+HyqgRgyQBqODOVk99uSWH2xKh6VJYs3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900
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

On 5/18/26 16:57, Khatri, Sunil wrote:
> On 18-05-2026 08:25 pm, Christian König wrote:
>> On 5/13/26 10:14, Sunil Khatri wrote:
>>> Multiple queues needs these bo_va objects belonging to
>>> the same uq_mgr. So once they are mapped lets not unmap
>>> them as at any point of time any of the queues might be
>>> using it.
>>>
>>> Also userq_va_mapped should be a boolean than atomic.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com> for this one here, but I think we also need some follow up cleanup.
>>
>> What is the userq_va_cursor actually used for?
> It holds the gpu address and the membership to the list. we just add the gpu address from the mapping of the buffers of interest from queue like wptr rptr etc.
> struct amdgpu_userq_va_cursor {
>     u64            gpu_addr;
>     struct list_head    list;
> };

Mhm, that's a bit overkill. We could use an array instead since the number of VA addresses is pretty fixed.

But yeah something for the nice to have list.

Thanks,
Christian.

> 
> Regards
> Sunil Khatri
>>
>> Regards,
>> Christian.
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 3 ++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 6 ++----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 2 +-
>>>   3 files changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> index 912c9afaf9e1..4d68732d6223 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> @@ -96,7 +96,8 @@ struct amdgpu_bo_va {
>>>        * if non-zero, cannot unmap from GPU because user queues may still access it
>>>        */
>>>       unsigned int            queue_refcount;
>>> -    atomic_t            userq_va_mapped;
>>> +    /* Indicates if this buffer is mapped for any user queue. Once set, never reset. */
>>> +    bool                userq_va_mapped;
>>>   };
>>>     struct amdgpu_bo {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 24b172a0d9ac..9225b3795e74 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -227,7 +227,7 @@ static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
>>>         INIT_LIST_HEAD(&va_cursor->list);
>>>       va_cursor->gpu_addr = addr;
>>> -    atomic_set(&va_map->bo_va->userq_va_mapped, 1);
>>> +    va_map->bo_va->userq_va_mapped = true;
>>>       list_add(&va_cursor->list, &queue->userq_va_list);
>>>         return 0;
>>> @@ -274,7 +274,7 @@ static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
>>>       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>         mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
>>> -    if (!IS_ERR_OR_NULL(mapping) && atomic_read(&mapping->bo_va->userq_va_mapped))
>>> +    if (!IS_ERR_OR_NULL(mapping) && mapping->bo_va->userq_va_mapped)
>>>           r = true;
>>>       else
>>>           r = false;
>>> @@ -303,8 +303,6 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
>>>   static void amdgpu_userq_buffer_va_list_del(struct amdgpu_bo_va_mapping *mapping,
>>>                           struct amdgpu_userq_va_cursor *va_cursor)
>>>   {
>>> -    if (mapping)
>>> -        atomic_set(&mapping->bo_va->userq_va_mapped, 0);
>>>       list_del(&va_cursor->list);
>>>       kfree(va_cursor);
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 82a1c19350ee..47c531ffc065 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2002,7 +2002,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>>>        * during user requests GEM unmap IOCTL except for forcing the unmap
>>>        * from user space.
>>>        */
>>> -    if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0))
>>> +    if (unlikely(bo_va->userq_va_mapped > 0))
>>>           amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
>>>         list_del(&mapping->list);

