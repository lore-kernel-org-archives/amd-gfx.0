Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC09CD4F49
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 14:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB15D10E8D5;
	Mon, 18 May 2026 14:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K2FcwEkL";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 502BB10E8D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 14:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIoInVanCW8JWywawQPL3UveXhXjYmflsyFvUWkQvJkGSydHHorj2sMHEuQCaIaAP1pPpC4VpDG8jCWJFiQgVl+ntGBf2jpnkh41HAcQudlTrGszhVu0gm2H+NREsDL3bhkb7npWJzl+jah5gnKZ19FAHaAtRYl97gVmSqzgRjSo+VKycy9EpdWrvTmNuR6bLwBnSQiTK4mqnJBI6cPt+R3oDndlVbOaQKY1l8emNzWkOPNmNhJIFBrYt6/P+QXLOQ6lp3ri50ulWt+IkFzLCpRNRBouWX564zIWOcQthvs/2mUvnimFr6vwtQIeH70SqlBqtdCCTY+Mj1ucVlMQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYMuQLUGc0gYarewpu0au4sFFL7t3GagxNEHYFOGt9s=;
 b=hii2iOPOwcOBPjRzor3EVsp5bTd7P78N/7aHGIAjgp3CV4FcF4JdZ1rTqDcCV4ClDdCsXiuusJmCyVZu0nvRVjjC7yJtG+jiXJhi+m3iiFpv4bPM0KMLb6lJb92SRT1WwdEhDRCkV3aKSjxz8lmGC2OCM90aPcZsnQyDt01Ms8snqsaRFx+xc618BYFlRAUkGenXkvFVfXRqtQfJ1hSAO9KonhGkTW6XpOB4CVuqnvOO3fq/ssL0XAxP4sJ3DVDCpECwEtVgZTZxpwl0u0uXL6HYhc9zU1QETqu9DW+TMMjlG+SWDBfpWVnAgAvu9BS9cG3H07E1E87vH+uKPoJLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYMuQLUGc0gYarewpu0au4sFFL7t3GagxNEHYFOGt9s=;
 b=K2FcwEkLdnUY8cA2xdPA1xKj3DCXC/H6E9Fafgnrhfw4zLCYgGGoSgK9W3sDwH1mAOTPuKW8GHfs3cMoxAN6Z2kZTQEZrNhm9US6RnoZiS61e3wMqLlrSv9Jy0ky3bYxtx2g6gmdxdKQsQ/Y1h2Dy6JGklLf+5RvuUyPCjU9iGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 14:57:17 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:57:17 +0000
Message-ID: <410f0398-0344-40a7-abca-722d76fb98c5@amd.com>
Date: Mon, 18 May 2026 20:27:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: userq_va_mapped should remain true once
 done
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260513081418.1727864-1-sunil.khatri@amd.com>
 <2ca8cd17-58f2-4b03-8fa7-3da869208c0c@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <2ca8cd17-58f2-4b03-8fa7-3da869208c0c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0364.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::14) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 9534ccf6-2ca9-46f8-6614-08deb4edc148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799003|22082099003|56012099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: E8yyxppeY3YmWiH+xnAmbmhgMm63ZGWG21daOPdvcDIVA5ivmMgrzl4Hkr+Umu3siDLT6YWffDkSxXpTvJ9qh9Il+WoFcxrvzhQbVO8pO0/YAkPFzQQMP2XGKTIbW9wIxb7eKb8KuYVk0ZAI8COT5tyWmAJKMURFAe997FBr81elhR+nfqq7KPUUKgH+HF+XC4GYjOa/SCvsp/vw3qw2AcLtiveL42yxCuUtb48w963smIUw1/ddnF1aGOyYq97keQdjrX0RKQmfmri52TYYxAaC9A6mIYy0Ufy1yZFuNYxNMOJpEoTYTVa45wxzNkozMVgR9OTEH/5lCVDRowxrw6gatDmSULqxV536Rrg3v343kmxMRTAv/RDhZ+MltSW4214ckwIIQyleA1ab80ImN66pScld/wcM56UuQDT31CKd3nnbh3yekse7ieQhIkXU7cXYbfv78cqxhg6BLgJLl6GEowxIrRoNJzH+e1SW+BFMqdAXC7GVwWnS2yMsjeknRQ+xcQF+fAQ6a2bixeApMC6Ue1vYoIT+4LnyOVNjacbAHLWMQ7hTqQ3Ry7VZWfjRnbL1LVTQy3PGh0I1duP84lV1ihdDMhfsitvp05L8GcEanI9gjHqwqbTkik0oJPAFByHY48Xz7puxE9HMXvpiB6uOcsDNrlQw44lpZI3XEEaV5HGd3cxLhq2jJ7tPayBQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799003)(22082099003)(56012099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUNkV2RtZlFENUNKbkIrWXhEUnM0WjVkaTlGQWhZWS9zQW83Tmp1ZEd1K09W?=
 =?utf-8?B?VXdpUFVWYjJaL1BMZE10ZnJpQitVQU4vVjg5UE40dXcwbmJBSCtKM25ZZCtH?=
 =?utf-8?B?anAvcFd6cEtnTUdLazZvSHc5aWF2dUFCWlNIWTQydmQ2TStZZVFieG4vOXFC?=
 =?utf-8?B?eUEweHMzbVM0LzlEVVlqaHE2NUZjanF5b0RYMjc3ZVBUSGxvaEVyZnFLSDZV?=
 =?utf-8?B?MVFvMXRXOU1Bb2MzWnFYbTBOT1NjZUNZYTRMZGNIczh4bFdwUlZvY21ZR1VO?=
 =?utf-8?B?WTZ1TE1aaTNjc3V2ZWJXM2ZRWEZaQmI2UlBBNWY4SkhyTEw5YjlLWkxMWGs3?=
 =?utf-8?B?VllNck81Q0MvK01FZmhJZUU1SzBsYkZFbk5aK3g1VVBMeXp2UlJUUS9KcVpT?=
 =?utf-8?B?djVLNSs5TVoxUUV3Ym5VTk1zVzl5bTEvSGptcVRGWWVkWmJ2bEZ3b0JCaW9U?=
 =?utf-8?B?bENrQisxekFrUlJvMGxOOVhuK1ZuMHJGZ3dqVnR3b212RWo5Sm03eTFKVEVJ?=
 =?utf-8?B?ek1XM2hNc21uZzZNWFgrMys1MnMxVmt2eHdnZnFLZ3hhdk9uaTdkOFNFTDBK?=
 =?utf-8?B?UWd6T2FMSWc3aUJNY3F3cmxJR2taY1N5Qm5EcVhVMEpTSHpvQ2Excm51Qjh0?=
 =?utf-8?B?SjV3cUZYRmZmM3BwTkF2YkYxY1c5eEE1QmVKc3dNVjJJU2xJUGE1RjdBZzZx?=
 =?utf-8?B?cHVpM0Yvc2VZK1ovVkN0aVRDZVY4T1RVM2hzWmQ2bGRwdStQcytJRXk5Ymsx?=
 =?utf-8?B?MHp3VktsYSt1b1FhdVRTSURVUFRQZ2FDSlRaV3NVRWo4TW44YWxjdUI2dHhj?=
 =?utf-8?B?NHEzeWx0RkY1YU1ySEpjZVV4SHczTjZsNEpxVmEvbDg3OUVmOWhVWEUwOGl0?=
 =?utf-8?B?eFhQMnJWQWlFbmQxRFJVdTJVczR5c21OVkx2cVdyUGlIMUNJSTFRcVNZZTdy?=
 =?utf-8?B?am1sTVV6MC92SHFrM3grU0ZENi9tOWI2TmxZbTN5UXZLZms3NDNSTXc4Tnp3?=
 =?utf-8?B?Z2VKbWVZMjZVTEFnYk9tSTB0ZjkvQndJK0RZQ1RwTTRSOW16ZklIWjZKQ1Bx?=
 =?utf-8?B?TFVnUGpRVjgvUUxjRjZ6b2dsKzF2T3EzOC91T1hncUdCS1p4NTYrWExxQnQ5?=
 =?utf-8?B?MVhqM3o1U1crTmpxSStPN0xvNzFkZSs0NzFxYW9DRU43Y1YySEJPclI2enc2?=
 =?utf-8?B?Nng5dkk1NVpwUHc4dVZHTUg4OGViOThrWnNyRFlGNWd0UWdwWjZKclNrOGI3?=
 =?utf-8?B?SDU3Z2I3d0JJRmVmbHlhWUpXR2I0elNBdHR4cE5iM0ZMWmk0T3NlcUdvcWVn?=
 =?utf-8?B?UUdYOURIK0N0VlUydTJ5TmowQk1sSDRMYUV6a3NnVW5oc0I2dERYTzdiblZz?=
 =?utf-8?B?YnNKalVGRlBzTXUxL0VucmY3bkwwZVJNUlBhelowcVd6WHN1T0F6V2huYjRP?=
 =?utf-8?B?elFWclNGM1BKZzNIdWdTOWhVaTZBUnVZa1NxeFlodjhubi9oOVVMQ0lRZHFr?=
 =?utf-8?B?SW9NVFExTGYwOVRzb29ZS0ZQT1VKL0lZMHI4TTJna3cwQVBwUmtvRDRCWi9m?=
 =?utf-8?B?Q3hEaEkrOEZZbnlnTlF4cUNWYnVxdWRnT25CZVlwbFd5cnJyZnVMTTViN3VJ?=
 =?utf-8?B?TDZsbkdLSE5xOXRicmprQitvQkVUdlF2M2dPcDdkd0FxRVpSYWdxejBuMnZs?=
 =?utf-8?B?U3NjdFdVRE1qaEJEelpVRDc3T3JiTU94ZEJWL2NYWjVBZDFwZ2lJd01VbkhM?=
 =?utf-8?B?aVR5L0NKMWZWcE92eEF5NGpHNGoxaGRyN0w1K3J2aFJNSFdPMVo1ZGpVdVBD?=
 =?utf-8?B?SnFUZHI0ZlprajFOSUFnbDFURTErd2x5TnFuSmVUZ3Z1TmQrNDdaeWlWd3ZU?=
 =?utf-8?B?SWpjR0xNZ1ZkZnJYMXh4THA0NmhiMy9JYk00SjlSdEI3Q0c1TWVjQTN2VkRr?=
 =?utf-8?B?emlZUEdGZFhNOGRRZmJzU1I1TWljSDkybnJ5blBjSlh3ai9WUzZSTVNqT1FP?=
 =?utf-8?B?QkwrVTZ2NDhCS2x3UDZ2TjBTTld5WGp0NW1FYkluUFFFUERkYWVlbU5DMlJp?=
 =?utf-8?B?VThndUEvb1pwWlBVQk1pWVBKVStYU3NXbkp3ZWJPaVBrN0VqaGlYcVpTdU52?=
 =?utf-8?B?ZTVrclBUbnZEK2wzUDZyR3dyUVNYenQzRVFTem9HbFdtR1NOY2JOdlBUYVQz?=
 =?utf-8?B?U3ZYb1RRNDNSZjRrV1Y2QnlpYTh6MTlCdVArKytqWlpNZmtUOFQ3VnZZRHRE?=
 =?utf-8?B?ampDKytFRENQdjR4MEtZMmRKSDlmQmI2SVZUMXVpOXJpMnB3WEtRNFBMejRx?=
 =?utf-8?B?RGRnb3FmaDBMcUFrUEVjOFY2ejVVWjhBZEZEamRwTUlqLzJvMk9FUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9534ccf6-2ca9-46f8-6614-08deb4edc148
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:57:17.7398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xUYOpEQ/p4wzOsqzln99uJ7LErBMaXV8EVPy+bBJ1Ph4lzcgRDE+VwThAeRjgCNMcW3xCFcNtY5IXjLTHF05A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841
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


On 18-05-2026 08:25 pm, Christian König wrote:
> On 5/13/26 10:14, Sunil Khatri wrote:
>> Multiple queues needs these bo_va objects belonging to
>> the same uq_mgr. So once they are mapped lets not unmap
>> them as at any point of time any of the queues might be
>> using it.
>>
>> Also userq_va_mapped should be a boolean than atomic.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com> for this one here, but I think we also need some follow up cleanup.
>
> What is the userq_va_cursor actually used for?
It holds the gpu address and the membership to the list. we just add the 
gpu address from the mapping of the buffers of interest from queue like 
wptr rptr etc.
struct amdgpu_userq_va_cursor {
     u64            gpu_addr;
     struct list_head    list;
};

Regards
Sunil Khatri
>
> Regards,
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 3 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 6 ++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 2 +-
>>   3 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index 912c9afaf9e1..4d68732d6223 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -96,7 +96,8 @@ struct amdgpu_bo_va {
>>   	 * if non-zero, cannot unmap from GPU because user queues may still access it
>>   	 */
>>   	unsigned int			queue_refcount;
>> -	atomic_t			userq_va_mapped;
>> +	/* Indicates if this buffer is mapped for any user queue. Once set, never reset. */
>> +	bool				userq_va_mapped;
>>   };
>>   
>>   struct amdgpu_bo {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 24b172a0d9ac..9225b3795e74 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -227,7 +227,7 @@ static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
>>   
>>   	INIT_LIST_HEAD(&va_cursor->list);
>>   	va_cursor->gpu_addr = addr;
>> -	atomic_set(&va_map->bo_va->userq_va_mapped, 1);
>> +	va_map->bo_va->userq_va_mapped = true;
>>   	list_add(&va_cursor->list, &queue->userq_va_list);
>>   
>>   	return 0;
>> @@ -274,7 +274,7 @@ static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
>>   	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>   
>>   	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
>> -	if (!IS_ERR_OR_NULL(mapping) && atomic_read(&mapping->bo_va->userq_va_mapped))
>> +	if (!IS_ERR_OR_NULL(mapping) && mapping->bo_va->userq_va_mapped)
>>   		r = true;
>>   	else
>>   		r = false;
>> @@ -303,8 +303,6 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
>>   static void amdgpu_userq_buffer_va_list_del(struct amdgpu_bo_va_mapping *mapping,
>>   					    struct amdgpu_userq_va_cursor *va_cursor)
>>   {
>> -	if (mapping)
>> -		atomic_set(&mapping->bo_va->userq_va_mapped, 0);
>>   	list_del(&va_cursor->list);
>>   	kfree(va_cursor);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 82a1c19350ee..47c531ffc065 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2002,7 +2002,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>>   	 * during user requests GEM unmap IOCTL except for forcing the unmap
>>   	 * from user space.
>>   	 */
>> -	if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0))
>> +	if (unlikely(bo_va->userq_va_mapped > 0))
>>   		amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
>>   
>>   	list_del(&mapping->list);
