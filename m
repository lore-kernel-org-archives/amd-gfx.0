Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CFAFF8864
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 20:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E31AD10E931;
	Mon, 27 Apr 2026 20:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c45kyukD";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB8510E931
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 20:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bP0dZY0s2oYtXKbJ+fo7gk4n5a8dFe6/Dwl+q28pb8c+EljfCOT9TyJ1V70EAJfB0Hv2uzAfFVpaqljxcHaOhkkrrqH3K4nDAVnscCSB7hXEsqXdLok0zncpV0rynBJ8iOrebRd1aPlZ6jAle2MlYmXVbasiP0wAmaVOFiTMJ206B18UyeVNWy+PuLdMEgs0y3uEwS9eG1zcBjLtvC81BqIpxeRPpnTPJDjFzPUUtWeO+VtEyAWFMusKZatvokWsZo7eyNlQQxnZp8pugAB+0eeRl3pu/5G1UOg+XFabp7YoSCC6M75xgDqEs/oezHbNQD1tjJQfTueSWDpr7mM1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgTNiT33O4UitVsIO8gPAV+aPoRRy2N8W7odxbpnr44=;
 b=JT+ekLEtAur9QEqberlGoV6Pviq4V6BVa8uInyI3U8abgrxcsPqahtUNrwYyyIHzCXhJ/VcIlUhPwpZbkuvp58pVCCQOvIV7v9uUx0oVlKHTuLHr4sTWaGhDMujhzZQISFKpzaN5t0Mvo0pYWFT1b7d/JbQpJpQsPEiRPCTjZtaPGkWIiGI8hI9Q5MzFhNbDfK3w6O61Nhks0RPXOfwnP2wYtBDsHPG7OhQzAiHtiZ6C0lwiF4He/HrovCB8VA1UPM/7no8CGtPAuHlS4N1y7yMOVCdLnljHX54CjkyY9DTXVKZtyPDyu0DFAaKmrTGzmA5sFFnCXdOYFhrM0wkM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgTNiT33O4UitVsIO8gPAV+aPoRRy2N8W7odxbpnr44=;
 b=c45kyukDR16AMdocaIlPJ58JLkvR/jhU1912+5NnhG3/h7ra23hBDUxzjoz90KK+p3WXYNzlmCn+zcRVXR7sVcG2tRcQIpsgPJDvpCnQMsIiila435DsXzP3H1pTENX+hyNimTOetRqs2+nFOGO67qxfKZKqZqUKIOmDLDAdld8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 20:53:11 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 20:53:11 +0000
Content-Type: multipart/alternative;
 boundary="------------RTuKPYEAVdUFtARrdf2YHLSL"
Message-ID: <b9679800-c13b-498a-91e4-d3a12a1530a8@amd.com>
Date: Mon, 27 Apr 2026 16:53:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Make all TLB-flushes heavy-weight
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com, christian.koenig@amd.com
References: <20260420155822.718805-1-felix.kuehling@amd.com>
 <f2f17b8e-ce73-4d96-b5df-29d235f9ffca@amd.com>
 <a663fedf-0c41-4d4d-ab6a-f85c3d46a129@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <a663fedf-0c41-4d4d-ab6a-f85c3d46a129@amd.com>
X-ClientProxiedBy: YQZPR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::11) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: c408f347-771e-4128-1e2c-08dea49efe4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: PPq5rA+iB1mhnGPpciDTdLuu5OAwGhut8W0OwZMW8ZLg7gYOTk0XyggMuwoo4tuCHDofDqcuiCbFA62dtDEOOkxpaY2z3LVybIPIPllbirefSfpbR1JxTedj+7lE+8J0ws82yXB8c1JjbTPObw9uFZ3ioqMUfsS/mVAvjRsJfNR53fVG5dlDedNMEX4Vr3AWCTPmUjoiANpG+8TAr5mqvYrXhDrMltRn7VaosrcMtKhkQJpVaWKw9C4xw68iNE1bvSMJWb8kU2U0hs4ESMsXIP6vEWkdhAsUWVb6UMvwUY9CFm8w7p+8jaWabD5NM4F2K7NTMUbUuSJnBR5HlpfFymMdKX+us4iEEFvvm9jpdsoxkhd2DX4v8QmtCBPXLwmPNkAYuVw1jJJj4mE7iRTBew1eyWtNEASvvHHKVf7pcfEIcbdp9nGOxrgblq2pJyNzh4bicdYSEZ8bnWvWojOu6aGanFtBqAsLELvoiUykJCpZD9pktxhAIiCAgtT+oY6KiBJ3bNGhTRbDF7S2XC0PgYeR3eSQWrrXevGlZ/Hwdz0w/58PplTdQJluvpZX5EvDmZmyGyK5gRelF5RolP7jeFpfbKCsrc+B4GURnyh/RXynfrLGfMr0m4fAzDN3QRPNyxnquLZgJyaE9np79xjA42eGibrWJ/Iboh6FhGMD1fnfRNhhsSQ4qAEhHqneiUwip6qgN5/0BqKJ0uXhVpvRFYk+EIV3Id72pqmkxwNET6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzU5VmgrZVlBdzJUanIxVzVJSXZndHVtU2pCak9jMG5qRXhvc1pKYVR6UjNH?=
 =?utf-8?B?U2tVR1ZIcWlqN0p5T2pPalF4TXl6NkxmeGVJQU1KeGR1WUw2aXlsT01semtY?=
 =?utf-8?B?L21uTHVPdFh2eFBiZmMxSkptS3c2aFhWSG1oSkkvOWtnc3ExaEJOcHVCOWRW?=
 =?utf-8?B?TXNTYXRFSmgraFpqZ3lkc0Q1MnlzKzJJYW53a2I0NVJ5aU1yOTRRWEc0d2ky?=
 =?utf-8?B?UUtydFJuR01aTU5HMUxRTXYxTjF2ZC9GNG9PeTArdHRrenJJT29PSDNFOUdl?=
 =?utf-8?B?VjRDREVUTXdwajhxeFVNcE5KRDNVYU9SV1pOREY2d0VmMHhrUmtPY05TVnIy?=
 =?utf-8?B?bFFwaFpvZzdwRmxSZVhZY0xsQVA2Yk5hU0lVbnNzd2tNZmV2blljVTcrLzls?=
 =?utf-8?B?MndhYkIrSEh5NDhaSUx4OGUxRWdpQ0x0b2Q5cmlSWkh1RVlKM2FxVXpsb1N2?=
 =?utf-8?B?aGhaRERnTzEwcCthd1Rxb3NLdkxyQTBoUjUzUktYTjR3ZUFBWS9uK3l1YitV?=
 =?utf-8?B?TFdkaU90RGMrdHcxVlZManQxTHE5QitaQ2phTnBGRmNXVkZad1hKdXlqb01Z?=
 =?utf-8?B?bldHeEU0R1E1VU9ISVZNL3FGYVBsZDcrMnhqemkzUHJXVWpnWmtsMUNVZ2hm?=
 =?utf-8?B?NGlWTDEzQkI0ODhSOVBiT1hqb3YwbGRPc2Ixa3oySlhFY0tDSlFGRmdDYzlI?=
 =?utf-8?B?cHhCZTVHdTRCVEd0SHhxTk5iNWVtaTM2SkI0QWJWVlBoZTU3dlphY3ZNaEgx?=
 =?utf-8?B?b1RVWEVndjhHYkNMR1c2YUg1QkVZcHhNNFc1U2FsejZEY2NwaE5qclc3aEVQ?=
 =?utf-8?B?bXNodnZaRjh4Y0MyWUxnZXRPaG40cWVjWkhpb0J6Y1BtZjNTT1NQMjZJY2ZT?=
 =?utf-8?B?alNJdUVVejUrdXM1VUpycm14MG5ZMVR5NUhIR1ZBTzMxK3pJWXk0dURKeTBW?=
 =?utf-8?B?MU9yaC9QUTN5MmdvYzNYaExBZm5BaFovZ09DTTdFeWg4dll4S2xVVjRqdS9Q?=
 =?utf-8?B?MzlHK1NSbm9BRTgxczBrVzJDOENrV0V1TGVnZWE4NWFTdDBHZS95TnhUQ2Vs?=
 =?utf-8?B?QVArNkNCbWhHZTM0UmUzSHB0TTY1ZFdXK25DY3huUCtzak0wNjZ0c01zVS8z?=
 =?utf-8?B?L1JWOFRYSkhxb2V0bTBibnoweXI4MWtLOW1MYjA1Q1dsaDVHNUE2bHhEUko0?=
 =?utf-8?B?akdHeThtVmw0L090c3VoaGxQVFR3QXQ4T1pRUlpyN08rdHBkN2dMRHRFdDZt?=
 =?utf-8?B?TzNna2VFeWlaQmVJWnZ1c2toV3NZRUtydThDS2JIT3BPYnRCd09uV21za3lG?=
 =?utf-8?B?T1pvTTUwRENuT1J1SDFCTGN5TXZGeWVjL1BBTWkrTVZiNnMrVFpONUxpS3pF?=
 =?utf-8?B?UjJSQUV1N0ZCbXRQUHhxNVl2V0xSQlV1c0xNMGJVK0pBOVlhL0pJazRsemNs?=
 =?utf-8?B?enVma1c4NVBZMUtmaHBUd2hwTUVUdVB0YlRSVnVXWlZtTUEydWZxRWFrdUxn?=
 =?utf-8?B?ZWo4T2ZTZlB1MklENEJsSHAxc09QVFNadWdLenNDMkQ0NzR1M2hMWXJpSVda?=
 =?utf-8?B?UWJUS25kNWdoRTBTT1VLbDJ0V3VxNmFuUnlRVlJ2SEl2akYwcE5ONDhKRnUz?=
 =?utf-8?B?QStEOVVzQ1NTdGlodlZKVEo3Tm9hZkg0VVFET3JVTG1qaVRmbFVIb1hMS1RH?=
 =?utf-8?B?VFhVNXJtTnBTdE52K3RWTXFZZHRnZHZHMlhkOFhVVWp3VVFqUnBFZ05ZeUx5?=
 =?utf-8?B?MG9JNmROcGN1TlZFZ3ZhZG1lKzZpbit2Sk12c1lhakNZYlBJL3RBeUtDVy9X?=
 =?utf-8?B?SU51d01aMllIcGpXZmh0bFlHeWkwV2VVd1lnTHcveXNybnVHVXpob1NMWUcw?=
 =?utf-8?B?eFg5bWViN05GM00zN3gxZkJseGNtKzZYdGdUZjR1WFVsQTdIYUNtVnRySGxr?=
 =?utf-8?B?anNGTVN4VmdzaXZGVjdFOXNoc2tQMVdEdU04cUpHYVdtTzYxd1d2MWhadjJV?=
 =?utf-8?B?NHVnNUxXaFZRTmpCWnlOS3JVREVhcGR5REdob3RMSGlZYmQxeGhhQjFNY2Zn?=
 =?utf-8?B?YjBib0l3Qm11LzFJUlZJQ1MrbklxNXFVbGRZd2pObTZQR3gwbkZTeFdIUXRp?=
 =?utf-8?B?YW1jT010aDBVeStHWXRIeFhTVjNDbEhHNmZBZWtMUmZ3Q05SWFpMUGlxN1N1?=
 =?utf-8?B?bmxIWGNDTVhiNHl1L2ZLS1pBTE44V1E3dGJZbVRYaDJSeWtMekdTT3ZIc1NU?=
 =?utf-8?B?RUVvWEF5MHlVNzRUSmZ5T0dEeVF5bGl4Q29CcU9na1dnY2ZlMGpSWDA3VUdI?=
 =?utf-8?Q?ANpxnnXtFBW2KsiJ/W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c408f347-771e-4128-1e2c-08dea49efe4f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 20:53:11.3194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5E1z4LsIpB5DdC1VoGnYzmwr11OFjsgkx62ld+eQ0i2Oq00aSATEOSyl4v6lizeW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
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

--------------RTuKPYEAVdUFtARrdf2YHLSL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-04-27 13:48, Felix Kuehling wrote:
> On 2026-04-20 17:32, Philip Yang wrote:
>>
>>
>> On 2026-04-20 11:58, Felix Kuehling wrote:
>>> With only one sequence number we cannot track the need for legacy vs
>>> heavy-weight flushes reliably. Always use heavy-weight.
>>>
>>> Signed-off-by: Felix Kuehling<felix.kuehling@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              | 4 ++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 6 +++---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c                  | 4 ++--
>>>   4 files changed, 10 insertions(+), 10 deletions(-)
>> Probably change to heavy-weight flush in this path, other changes 
>> look good to me.
>>
>> amdgpu_gem_va_update_vm()
>>  {
>>   ....
>>           if (vm->is_compute_context) {
>>             .....
>>                                r = amdgpu_vm_flush_compute_tlb(adev, vm,
>>                             TLB_FLUSH_LEGACY,
>>                             xcc_mask);
>
> This code doesn't exist on the amd-staging-drm-next branch that this 
> patch is intended for. I'll need to make a separate patch for the DKMS 
> branch that includes this one.
>
> Can I get your R-b for this patch?
ohh, I checked the DKMS branch as I am working on it. For 
amd-staging-drm-next branch, this patch is

Reviewed-by: Philip Yang <philip.yang@amd.com>
>
> Thanks,
>   Felix
>
>
>> }
>>
>> Regards,
>> Philip
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 16fb39259911..0625104a7693 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -1358,7 +1358,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct 
>>> file *filep,
>>>           peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
>>>           if (WARN_ON_ONCE(!peer_pdd))
>>>               continue;
>>> -        kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
>>> +        kfd_flush_tlb(peer_pdd);
>>>       }
>>>       kfree(devices_arr);
>>>   @@ -1453,7 +1453,7 @@ static int 
>>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>>           if (WARN_ON_ONCE(!peer_pdd))
>>>               continue;
>>>           if (flush_tlb)
>>> -            kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
>>> +            kfd_flush_tlb(peer_pdd);
>>>             /* Remove dma mapping after tlb flush to avoid 
>>> IO_PAGE_FAULT */
>>>           err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, 
>>> peer_pdd->drm_priv);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index c1f668f12732..8d9bf4334090 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -595,7 +595,7 @@ static int allocate_vmid(struct 
>>> device_queue_manager *dqm,
>>>               qpd->vmid,
>>>               qpd->page_table_base);
>>>       /* invalidate the VM context after pasid and vmid mapping is 
>>> set up */
>>> -    kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
>>> +    kfd_flush_tlb(qpd_to_pdd(qpd));
>>>         if (dqm->dev->kfd2kgd->set_scratch_backing_va)
>>> dqm->dev->kfd2kgd->set_scratch_backing_va(dqm->dev->adev,
>>> @@ -633,7 +633,7 @@ static void deallocate_vmid(struct 
>>> device_queue_manager *dqm,
>>>           if (flush_texture_cache_nocpsch(q->device, qpd))
>>>               dev_err(dev, "Failed to flush TC\n");
>>>   -    kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
>>> +    kfd_flush_tlb(qpd_to_pdd(qpd));
>>>         /* Release the vmid mapping */
>>>       set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
>>> @@ -1307,7 +1307,7 @@ static int 
>>> restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>>>                   dqm->dev->adev,
>>>                   qpd->vmid,
>>>                   qpd->page_table_base);
>>> -        kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
>>> +        kfd_flush_tlb(pdd);
>>>       }
>>>         /* Take a safe reference to the mm_struct, which may otherwise
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 53c26b1a25ca..dc8787dc399b 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -1559,13 +1559,13 @@ void kfd_signal_reset_event(struct kfd_node 
>>> *dev);
>>>   void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 
>>> pasid);
>>>   void kfd_signal_process_terminate_event(struct kfd_process *p);
>>>   -static inline void kfd_flush_tlb(struct kfd_process_device *pdd,
>>> -                 enum TLB_FLUSH_TYPE type)
>>> +static inline void kfd_flush_tlb(struct kfd_process_device *pdd)
>>>   {
>>>       struct amdgpu_device *adev = pdd->dev->adev;
>>>       struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
>>>   -    amdgpu_vm_flush_compute_tlb(adev, vm, type, pdd->dev->xcc_mask);
>>> +    amdgpu_vm_flush_compute_tlb(adev, vm, TLB_FLUSH_HEAVYWEIGHT,
>>> +                    pdd->dev->xcc_mask);
>>>   }
>>>     static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 015eb61f3440..5090f8c15428 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1418,7 +1418,7 @@ svm_range_unmap_from_gpus(struct svm_range 
>>> *prange, unsigned long start,
>>>               if (r)
>>>                   break;
>>>           }
>>> -        kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
>>> +        kfd_flush_tlb(pdd);
>>>       }
>>>         return r;
>>> @@ -1560,7 +1560,7 @@ svm_range_map_to_gpus(struct svm_range 
>>> *prange, unsigned long offset,
>>>               }
>>>           }
>>>   -        kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
>>> +        kfd_flush_tlb(pdd);
>>>       }
>>>         return r;
>>

--------------RTuKPYEAVdUFtARrdf2YHLSL
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-04-27 13:48, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a663fedf-0c41-4d4d-ab6a-f85c3d46a129@amd.com">On
      2026-04-20 17:32, Philip Yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2026-04-20 11:58, Felix Kuehling wrote:
        <br>
        <blockquote type="cite">With only one sequence number we cannot
          track the need for legacy vs
          <br>
          heavy-weight flushes reliably. Always use heavy-weight.
          <br>
          <br>
          Signed-off-by: Felix Kuehling<a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
          <br>
          ---
          <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4
          ++--
          <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6
          +++---
          <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 6
          +++---
          <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4
          ++--
          <br>
          &nbsp; 4 files changed, 10 insertions(+), 10 deletions(-)
          <br>
        </blockquote>
        Probably change to heavy-weight flush in this path, other
        changes look good to me.
        <br>
        <br>
        amdgpu_gem_va_update_vm()
        <br>
        &nbsp;{
        <br>
        &nbsp; ....
        <br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (vm-&gt;is_compute_context) {
        <br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .....
        <br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;r =
        amdgpu_vm_flush_compute_tlb(adev, vm,
        <br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TLB_FLUSH_LEGACY,
        <br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; xcc_mask);
        <br>
      </blockquote>
      <br>
      This code doesn't exist on the amd-staging-drm-next branch that
      this patch is intended for. I'll need to make a separate patch for
      the DKMS branch that includes this one.
      <br>
      <br>
      Can I get your R-b for this patch?&nbsp;<br>
    </blockquote>
    ohh, I checked the DKMS branch as I am working on it. For
    amd-staging-drm-next branch, this patch is<br>
    <br>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a>
    <blockquote type="cite" cite="mid:a663fedf-0c41-4d4d-ab6a-f85c3d46a129@amd.com"><br>
      Thanks,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">}
        <br>
        <br>
        Regards,
        <br>
        Philip
        <br>
        <blockquote type="cite">diff --git
          a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
          <br>
          index 16fb39259911..0625104a7693 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
          <br>
          @@ -1358,7 +1358,7 @@ static int
          kfd_ioctl_map_memory_to_gpu(struct file *filep,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer_pdd = kfd_process_device_data_by_id(p,
          devices_arr[i]);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON_ONCE(!peer_pdd))
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(peer_pdd);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(devices_arr);
          <br>
          &nbsp; @@ -1453,7 +1453,7 @@ static int
          kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON_ONCE(!peer_pdd))
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flush_tlb)
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(peer_pdd);
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Remove dma mapping after tlb flush to avoid
          IO_PAGE_FAULT */
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem,
          peer_pdd-&gt;drm_priv);
          <br>
          diff --git
          a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
          <br>
          index c1f668f12732..8d9bf4334090 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
          <br>
          @@ -595,7 +595,7 @@ static int allocate_vmid(struct
          device_queue_manager *dqm,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;vmid,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;page_table_base);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* invalidate the VM context after pasid and vmid
          mapping is set up */
          <br>
          -&nbsp;&nbsp;&nbsp; kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
          <br>
          +&nbsp;&nbsp;&nbsp; kfd_flush_tlb(qpd_to_pdd(qpd));
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
          (dqm-&gt;dev-&gt;kfd2kgd-&gt;set_scratch_backing_va)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          dqm-&gt;dev-&gt;kfd2kgd-&gt;set_scratch_backing_va(dqm-&gt;dev-&gt;adev,
          <br>
          @@ -633,7 +633,7 @@ static void deallocate_vmid(struct
          device_queue_manager *dqm,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flush_texture_cache_nocpsch(q-&gt;device, qpd))
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;Failed to flush TC\n&quot;);
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
          <br>
          +&nbsp;&nbsp;&nbsp; kfd_flush_tlb(qpd_to_pdd(qpd));
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Release the vmid mapping */
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_pasid_vmid_mapping(dqm, 0, qpd-&gt;vmid);
          <br>
          @@ -1307,7 +1307,7 @@ static int
          restore_process_queues_nocpsch(struct device_queue_manager
          *dqm,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;dev-&gt;adev,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;vmid,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;page_table_base);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(pdd);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Take a safe reference to the mm_struct, which may
          otherwise
          <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
          b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
          <br>
          index 53c26b1a25ca..dc8787dc399b 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
          <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
          <br>
          @@ -1559,13 +1559,13 @@ void kfd_signal_reset_event(struct
          kfd_node *dev);
          <br>
          &nbsp; void kfd_signal_poison_consumed_event(struct kfd_node *dev,
          u32 pasid);
          <br>
          &nbsp; void kfd_signal_process_terminate_event(struct kfd_process
          *p);
          <br>
          &nbsp; -static inline void kfd_flush_tlb(struct kfd_process_device
          *pdd,
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum TLB_FLUSH_TYPE type)
          <br>
          +static inline void kfd_flush_tlb(struct kfd_process_device
          *pdd)
          <br>
          &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = pdd-&gt;dev-&gt;adev;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm = drm_priv_to_vm(pdd-&gt;drm_priv);
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; amdgpu_vm_flush_compute_tlb(adev, vm, type,
          pdd-&gt;dev-&gt;xcc_mask);
          <br>
          +&nbsp;&nbsp;&nbsp; amdgpu_vm_flush_compute_tlb(adev, vm,
          TLB_FLUSH_HEAVYWEIGHT,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;xcc_mask);
          <br>
          &nbsp; }
          <br>
          &nbsp; &nbsp; static inline bool kfd_flush_tlb_after_unmap(struct
          kfd_dev *dev)
          <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          index 015eb61f3440..5090f8c15428 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          @@ -1418,7 +1418,7 @@ svm_range_unmap_from_gpus(struct
          svm_range *prange, unsigned long start,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(pdd);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
          <br>
          @@ -1560,7 +1560,7 @@ svm_range_map_to_gpus(struct svm_range
          *prange, unsigned long offset,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(pdd);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
          <br>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------RTuKPYEAVdUFtARrdf2YHLSL--
