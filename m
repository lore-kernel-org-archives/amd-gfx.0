Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DB2C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 18:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA0710E030;
	Wed,  5 Aug 2026 18:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xcN8e/St";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE32E10E030
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 18:21:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfV3SFvdfOSilp9Oi/Qbr7xsK8Bq9KAVtaBl2lcqO1rqk+RFbPvtKGnj1uN/EHkRfihrN3pi3feVQk8YGdUHM0sGiwcoiS/PlQE8Xt1YQk4QvAow72HCONpie3ZPRVNg8WA21PedjHuzkkqq2ZVQMBanpGFjw3tUsvlXWCUD5g0khLRMYggai4Zzvk2XodKtMp5PhBsxx/ORhnXwFRRh4UyP7Pl3dYKHykBM1PfhRU3O9SYGuPD1DKQ7JTvkaxUoyhFA9zrgwAeHhuUkDcB+9nk3M3ru6P0hB0KcDCHY211KuMCZA2gxrea2jc+ZP1gOpdXQeXOBGJEKYGzi7fLfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xaxBR6DoQsR9xAPBgRxYeJeirs1ZVjfTZZ80kJXPBs=;
 b=ykw4ksOSyFCo2AnqYRKv5vcyAun+XfCSisNUkFmWaH3rRBTN0aWq1HDyA1kbaD9ke05Z5Jo3cSO5OfZSXaNhc2fojrt7dDRdBTxls8O5mWNWWnCVI92vizE7ow4o8ZpIUFXsoOl3HmlQCljCmlYYbbx/DxmeoWc9+aYmnIlYf3wRgVnLo77R+YS0xZsgCCmuJXiaCkaS5TtoF1bq9eXdIEYScu0JFVVJTMwnT/Iz9eLFr9KoiylgozN7JYiVgi7oqWD23+4RKdaKtywS/qJJX/k+eMYsc+tx4+K+Tioa1MMNMd2XZeIwA7+mG0ZYQPKnPIj2Hh07VbQnHU3HrwAC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xaxBR6DoQsR9xAPBgRxYeJeirs1ZVjfTZZ80kJXPBs=;
 b=xcN8e/St/DFJSKREgNTQ3c9EDEborDC6KIQk73PrtWxAmRsWB0RtKbXJ2ic0K97U1/CIOJ54xT223yD86ZLUqpoEgc5Vcw3odPSAKUHgtMRg09UdPIXJotPbaoUT/Auu9bNCzR69cVfFpKbFN3mpRj+EYtUnlwRIZXFiI3CZ+2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) by
 IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 18:21:30 +0000
Received: from DM4PR12MB6278.namprd12.prod.outlook.com
 ([fe80::e54e:a560:f26a:5ec8]) by DM4PR12MB6278.namprd12.prod.outlook.com
 ([fe80::e54e:a560:f26a:5ec8%6]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 18:21:30 +0000
Message-ID: <92079b18-5c1f-4a46-bf96-e896ac48bbd2@amd.com>
Date: Wed, 5 Aug 2026 14:21:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: split tlb_seq into per-VMHUB counters to
 avoid spurious MMHUB flushes
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260804152635.899680-1-David.Wu3@amd.com>
 <fc961741-2c4f-464a-8884-6c7ecbd2e48d@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <fc961741-2c4f-464a-8884-6c7ecbd2e48d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0248.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::27) To DM4PR12MB6278.namprd12.prod.outlook.com
 (2603:10b6:8:a4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6278:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 2138ce4d-bc56-41c2-27bd-08def31e5f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: 5uAw6GYRICWwEPflq4gUuC1881NHCl5uvz9+Oha9I/vFrjKbnrIU/+Lqdfm9JkCJG+6H7HF2LMfMJoYpYjA35a8NLvvI5gVZ3+Md2hh0JSPSFHgqfiNxVPxfGezNRPb9g4ubieQcGUz3HurCY44nZSp9XLIhcWyOGMi7h81I8lNY5ybHw1EbmmgbArCrjRTjTPeEpq/3kW0b/vkJrHhItBItY8JHNEvwgTTHq4vNp1Jq6hUw5ffkrBA5yKvNFBiUm1x6H8OaCxzg5hsaloQKO8ZxPvG2OB5CqUzO3VTre6ZrtojJM3eZSlPCbBItW0b2PfC5pFGQk2MmnRhTigLRd3ENuIflPQA3jQHIoHFW31p4O/QewBeCkfYB3LSljEhoL9io1Z1Yu/jQRNGqhrpQGLOD7ij1fg6Z2RZT8A7QWsXURUaWvQosMaMGtc868TjHxcxOfX40b/omfLOAkG+keUYS1MyxrjJ+oddamcDl4rskPo3HpaX3JaoKtJbiylA2LRTxqUPI3WsZtZjQPbEQp4rkM5ECvLoDO2ou2D2+vYk29lz7RkOTmyIBTmK4SSq73VNUOmPwQf2YP4ms9owa/ZQ+5bKqJ/q9+c7TLqcoCqnUXRLD2D9Vln7gBlO3+0Acjtf1CwtScrNEh5vmx1WZ4CCKae6jpWQ+bAr/uh2xA/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6278.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mi9hZjVJMURnNyt1WHBtYXN4YWE1YzFjcmtyeGZVSEs1dGFVZFhwUHlPN25K?=
 =?utf-8?B?SXJCeTluUTQ4MGlMTmlhUncrSVNnN2dXN0lsS1FwNWQyckJEQUdpVWxqNWQ1?=
 =?utf-8?B?ZlBaRFB6TXp2N3RjUldkZ2NMZmJGVE12NXZ4Tks4U2FUektDMldzTFBqNGtL?=
 =?utf-8?B?V0xITjZhV082UzdiTmpyQTlJajJyeGdHdXdpT1haSk1yQnBzeWJNRm10OGQ4?=
 =?utf-8?B?ZjJjSjVNM3NKcGZUa2NEeWRvd1JYNlR3bmp2VGo0U05yUnZ4M3FWZXFHNHNa?=
 =?utf-8?B?RDFUbFoveGFJWlh0cUZFS0I5Wi8yaUNwRE9Rc3FjQlh3WUo1dDltYkJjcUs4?=
 =?utf-8?B?V0Q5cmFoWklrMW9iM1dvcnNkL1lWS1FXVzNKRndEeTVMTURFQm5pdXByUU02?=
 =?utf-8?B?QlVCQVNUWjVHY2pyamtRZE94cElyTDVwbjBGWjZoQjc5Y054azAvZi9zSFdC?=
 =?utf-8?B?QTBVU0JoQnFwWUFsSkhHTXl2R0cvbFVuNVk2UnNkN3Z1Vmd5ZHVleWpxa1Vv?=
 =?utf-8?B?YWpSQno0YWV1Rk56NVpvcGlmQWRHdzgwVStNd0ZtaWR3NVFSbURNMDBINFZE?=
 =?utf-8?B?VUxBK1lqcklmclZQcnd4cFMwSitSb0hXb0sxZGFFYjBaK2FIWjZCeXgwM0Jt?=
 =?utf-8?B?Rk91SkJpN0tMazVYWHFiMFUrWlVURnJCNG1Yc2Z3SVJSc1ZvNHpyUVB5NW1R?=
 =?utf-8?B?V0NKUUJ4eDBhYjVQbUdLTWxOYlJFZWxQSVNWcXEzUTVFZkV4ZTEvWlJsMDBF?=
 =?utf-8?B?c3l3dnA0SVlmQTUzU0NLM2xKYzRUaGN6ZjJyRGtiSXlWWlVtaUxvS3RZOTZH?=
 =?utf-8?B?UjAvcUVteG5OSjlHaHEyWmZoY0d2NSt2aHBldDkvbDJ2WG5IRE05SXNGQ2RT?=
 =?utf-8?B?R1pVRWh1cXBBaXpBUHhOTm9ZN0NRT3U0UXF4NXRqVHRQT0Eza3BuekJETXpZ?=
 =?utf-8?B?MmRqZHBYTUpzQ2crZ0tmcjdFbHdxSnhjR21pQzUraFhKM3FIaWZ4RSt4N0Ji?=
 =?utf-8?B?U0Z0aGJLYS9ncW9FWFZET1hDV29tTlBHY1h6R3ZjbG96Q2Y2ZEdoN0o0enNq?=
 =?utf-8?B?cFpRb082T3p0RmwzVFVTNE4vN0gwUitpclVla0x4T0dLNy9td1Q0QjI2Uk51?=
 =?utf-8?B?K2duNkJlRjI3MnFmMU4xTkZ2SHdjVGJjWVFRTklWakNrZ3FaY3F6azY5a2VU?=
 =?utf-8?B?VU5DcGxjMWJidDArYTlPOUhsdHUyaG5kd0ZBbTNGcmlhdW1ZUUcrWVRZQlo4?=
 =?utf-8?B?SHBOaEovUGw1SmM5QWwvOWZ0ZjJLbHBaMWJ4Mk9oSDFuRWdHMGZhVDhDQUJ5?=
 =?utf-8?B?S3phRWt3LysyYThOOUlJTXRackNlbEtYbXM1LzhSVERzNzVCbXZWTi8wdHds?=
 =?utf-8?B?eVIvbTFVc1NOSDhtRmhlM3RiTUdSbk03WTdHSmdYdzRueThTbGdUTy8zRTlq?=
 =?utf-8?B?RlY0bzZ5Mm9jS0NBbWFoWUVhYVpUZ24zZStpamdMVHc0SFdIaDlBMzZxVnpP?=
 =?utf-8?B?K3lSRW9Cc25GNWlOQnJqUmlCQzA4eWQ5SVNWSXlDSWYxc1UxaHJxdUNjd0Z5?=
 =?utf-8?B?NzlMTVFvOGcxUGgxMWFpcnNkb1RIOXQzbFlpRVU2d29sSGUvdlV4aTQ4MTdK?=
 =?utf-8?B?SWVsRlRMRjhoTnZURWt0M012d29IQURIdEVqaHZJN1ZnRkh4NWZVUHBVa0Fv?=
 =?utf-8?B?SmF6czdVWFBEUUpzQjB0elcvR0V1YlkxKzRVNmxacG54Z0hlTkcyVWpPLzZr?=
 =?utf-8?B?aXhUQmU2TzM0YzdCd3FDUUQ1bzFWUVVOQ25oWUt1UERRcU9SVWxlOEFpSE0z?=
 =?utf-8?B?cXhVR2xIR2NsNVovNVdwWW1lUEI5MHdwRnd5S0g4UUdUWkFtZ3FVWk92VThx?=
 =?utf-8?B?blpIcG0zL3FWa2RBZUZjelRZTEY2R00zeldGNTBxTytIdkZyWXlOWmNRZFhI?=
 =?utf-8?B?dlRlMUIyQlA1NDFoODBQaFJWYkhjMGUwVFBVbmdwVkZnYk9tVnJnN05JSHJk?=
 =?utf-8?B?SVl0ekNaR3ZNUVRqdVIrSkRUZVdLS1pnVFNTb05qMEY1Z3NXbzBOOWNmeDJu?=
 =?utf-8?B?Zm0xZmZnMXFBK1pONmRiVC8yZFVFSTZsOU9oS2pReHlWR2E3UFcwdm1VRW1M?=
 =?utf-8?B?WWNyMjUxZlFIV3ZXSjh4MUc5UXpKalR0ellLM3lsTFVjaXZjaDVKRTBkZ3gz?=
 =?utf-8?B?dTkvTSt4MTdSbENwZzVrSWUveTI4Y2V3dHJiSXVyRDRQcjl5bXQySC9DTGls?=
 =?utf-8?B?dUVvWmYzTHpjSExDMDFBcW51NGJEUzBhU2pZa095UjlleTc3SThNaXVEcGU5?=
 =?utf-8?B?OWNobUxzOTlId1FjMWdjemwxSkh2TDB4cWtDSHdDK2NqdXI4UGJhdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2138ce4d-bc56-41c2-27bd-08def31e5f03
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 18:21:30.4048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAUpy1ZyNGYGbQsy08G0jx/dB8qaP7uguA5zxmz9Zr+iCOHQ3rHn1PpScsQlxpgJeCB0RZSTUhuK2wvgfR9dXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206
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

On 2026-08-05 10:58, Christian König wrote:

> On 8/4/26 17:26, David (Ming Qiang) Wu wrote:
>> On hardware where EFC (Encode Frame Copy) is unavailable or the source
>> frame format requires conversion, the VA-API frontend falls back to a
>> GFX/compute shader blit (vl_compositor) to perform color space conversion
>> before VCN encode.  That blit goes through the GFX/compute ring and bumps
>> the VM's shared tlb_seq.  Every subsequent VCN encode job then finds
>> flushed_updates < tlb_seq and forces a full MMHUB TLB flush, even though
>> no MMHUB-relevant mappings changed.  On multi-instance VCN hardware the
>> same issue is compounded by the dedicated PIPE_CONTEXT_COMPUTE_ONLY
>> scheduling context Mesa creates.
>>
>> Fix this by splitting the single tlb_seq into two counters:
>>
>>    tlb_seq    - bumped only when mappings accessed by GFXHUB change
>>    tlb_seq_mm - bumped only when mappings accessed by MMHUB change
>>
>> To know which hubs are relevant for a given PT update, add a vmhub_mask
>> parameter to amdgpu_vm_update_range().  The mask is derived from the set
>> of rings in each command submission (collected in amdgpu_cs.c and stored
>> in bo_va->vmhub_mask / mapping->vmhub_mask).  When vmhub_mask is 0 (BO
>> has never been submitted), both counters are bumped conservatively.
>>
>> PDE updates and XGMI/GFX8 legacy paths bump both counters since they
>> affect all hubs.  The fault handler uses GENMASK(AMDGPU_MAX_VMHUBS-1,0)
>> because the faulting hub is unknown at that point.
>>
>> MMHUB VMID allocation (amdgpu_ids.c) now compares flushed_updates against
>> tlb_seq_mm instead of tlb_seq, so VCN VMIDs no longer force a TLB flush
>> when only GFX/compute page tables changed.
> Absolutely clear NAK to the whole idea.
>
> If we unmap something from a VM we *must* invalidate all TLBs who potentially can access them. Oherwise we get massive security problems.
>
> The whole idea here is a NO-GO.
the concern is real - The optimization in theory should only do PTE 
updates and not frees.
let me work on another patch to address your concern and explain the 
details.

thanks,
David
>
> Regards,
> Christian.
>
>> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>> Assisted-by: Claude:Claude-Sonnet-4-6
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     | 37 ++++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    |  9 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  5 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 65 +++++++++++++++++++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 32 ++++++++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c       |  5 +-
>>   6 files changed, 129 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index afc1c631d55a..33c1e9341774 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -1136,19 +1136,34 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>>   	 * with p->ticket. But removing it caused test regressions, so I'm
>>   	 * leaving it here for now.
>>   	 */
>> -	amdgpu_bo_list_for_each_entry(e, p->bo_list) {
>> -		bo_va = e->bo_va;
>> -		if (bo_va == NULL)
>> -			continue;
>> +	/* Collect vmhub bitmask for all rings in this submission */
>> +	{
>> +		uint16_t sub_vmhub_mask = 0;
>>   
>> -		r = amdgpu_vm_bo_update(adev, bo_va, false);
>> -		if (r)
>> -			return r;
>> +		for (i = 0; i < p->gang_size; ++i) {
>> +			struct amdgpu_ring *ring = amdgpu_job_ring(p->jobs[i]);
>>   
>> -		r = amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
>> -				      GFP_KERNEL);
>> -		if (r)
>> -			return r;
>> +			if (ring)
>> +				sub_vmhub_mask |= BIT(ring->vm_hub);
>> +		}
>> +
>> +		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
>> +			bo_va = e->bo_va;
>> +			if (bo_va == NULL)
>> +				continue;
>> +
>> +			/* Track which hubs have accessed this BO for per-hub tlb_seq */
>> +			bo_va->vmhub_mask |= sub_vmhub_mask;
>> +
>> +			r = amdgpu_vm_bo_update(adev, bo_va, false);
>> +			if (r)
>> +				return r;
>> +
>> +			r = amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
>> +					      GFP_KERNEL);
>> +			if (r)
>> +				return r;
>> +		}
>>   	}
>>   
>>   	r = amdgpu_vm_handle_moved(adev, vm, &p->exec.ticket);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index 8a2d64f0ebc3..9183569d340a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -331,7 +331,8 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
>>   	unsigned vmhub = ring->vm_hub;
>>   	uint64_t fence_context = adev->fence_context + ring->idx;
>>   	bool needs_flush = vm->use_cpu_for_update;
>> -	uint64_t updates = amdgpu_vm_tlb_seq(vm);
>> +	uint64_t updates = AMDGPU_IS_GFXHUB(ring->vm_hub) ?
>> +		amdgpu_vm_tlb_seq(vm) : amdgpu_vm_tlb_seq_mm(vm);
>>   	int r;
>>   
>>   	*id = vm->reserved_vmid[vmhub];
>> @@ -395,7 +396,8 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
>>   	unsigned vmhub = ring->vm_hub;
>>   	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>   	uint64_t fence_context = adev->fence_context + ring->idx;
>> -	uint64_t updates = amdgpu_vm_tlb_seq(vm);
>> +	uint64_t updates = AMDGPU_IS_GFXHUB(ring->vm_hub) ?
>> +		amdgpu_vm_tlb_seq(vm) : amdgpu_vm_tlb_seq_mm(vm);
>>   	int r;
>>   
>>   	job->vm_needs_flush = vm->use_cpu_for_update;
>> @@ -492,7 +494,8 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>>   
>>   	job->gds_switch_needed = amdgpu_vmid_gds_switch_needed(id, job);
>>   	if (job->vm_needs_flush) {
>> -		id->flushed_updates = amdgpu_vm_tlb_seq(vm);
>> +		id->flushed_updates = AMDGPU_IS_GFXHUB(ring->vm_hub) ?
>> +			amdgpu_vm_tlb_seq(vm) : amdgpu_vm_tlb_seq_mm(vm);
>>   		dma_fence_put(id->last_flush);
>>   		id->last_flush = NULL;
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index ff11a0903499..1d6373f1d985 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -70,6 +70,8 @@ struct amdgpu_bo_va_mapping {
>>   	uint64_t			__subtree_last;
>>   	uint64_t			offset;
>>   	uint32_t			flags;
>> +	/* bitmask of VMHUB indices whose TLBs have cached this mapping's PTEs */
>> +	uint16_t			vmhub_mask;
>>   };
>>   
>>   /* User space allocated BO in a VM */
>> @@ -91,6 +93,9 @@ struct amdgpu_bo_va {
>>   
>>   	bool				is_xgmi;
>>   
>> +	/* bitmask of VMHUB indices that have ever submitted jobs referencing this BO */
>> +	uint16_t			vmhub_mask;
>> +
>>   	/*
>>   	 * protected by vm reservation lock
>>   	 * if non-zero, cannot unmap from GPU because user queues may still access it
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index aac8ace9d7a6..b05befa1d5c0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -121,6 +121,11 @@ struct amdgpu_vm_tlb_seq_struct {
>>   	 */
>>   	struct amdgpu_vm *vm;
>>   
>> +	/**
>> +	 * @vmhub_mask: which hub counters to increment (bitmask of VMHUB indices)
>> +	 */
>> +	uint16_t vmhub_mask;
>> +
>>   	/**
>>   	 * @cb: callback
>>   	 */
>> @@ -1008,8 +1013,10 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>   	if (r)
>>   		goto error;
>>   
>> -	if (flush_tlb_needed)
>> +	if (flush_tlb_needed) {
>>   		atomic64_inc(&vm->tlb_seq);
>> +		atomic64_inc(&vm->tlb_seq_mm);
>> +	}
>>   
>>   	list_for_each_entry_safe(entry, tmp, &vm->kernel.needs_update,
>>   				 vm_status)
>> @@ -1031,9 +1038,25 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>>   				 struct dma_fence_cb *cb)
>>   {
>>   	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>> +	bool any_gfx, any_mm;
>> +	unsigned int i;
>>   
>>   	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
>> -	atomic64_inc(&tlb_cb->vm->tlb_seq);
>> +
>> +	any_gfx = any_mm = false;
>> +	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
>> +		if (!(tlb_cb->vmhub_mask & BIT(i)))
>> +			continue;
>> +		if (AMDGPU_IS_GFXHUB(i))
>> +			any_gfx = true;
>> +		else
>> +			any_mm = true;
>> +	}
>> +	if (any_gfx)
>> +		atomic64_inc(&tlb_cb->vm->tlb_seq);
>> +	if (any_mm)
>> +		atomic64_inc(&tlb_cb->vm->tlb_seq_mm);
>> +
>>   	kfree(tlb_cb);
>>   }
>>   
>> @@ -1054,6 +1077,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>>   	struct amdgpu_vm *vm = params->vm;
>>   
>>   	tlb_cb->vm = vm;
>> +	tlb_cb->vmhub_mask = params->vmhub_mask;
>>   	if (!fence || !*fence) {
>>   		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>>   		return;
>> @@ -1106,7 +1130,8 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>>    */
>>   int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   			   bool immediate, bool unlocked, bool flush_tlb,
>> -			   bool allow_override, struct amdgpu_sync *sync,
>> +			   bool allow_override, uint16_t vmhub_mask,
>> +			   struct amdgpu_sync *sync,
>>   			   uint64_t start, uint64_t last, uint64_t flags,
>>   			   uint64_t offset, uint64_t vram_base,
>>   			   struct ttm_resource *res, dma_addr_t *pages_addr,
>> @@ -1129,13 +1154,20 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   	/* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
>>   	 * heavy-weight flush TLB unconditionally.
>>   	 */
>> -	flush_tlb |= adev->gmc.xgmi.num_physical_nodes &&
>> -		     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0);
>> +	if (adev->gmc.xgmi.num_physical_nodes &&
>> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0)) {
>> +		flush_tlb = true;
>> +		/* XGMI: all hubs need flushing */
>> +		vmhub_mask = GENMASK(AMDGPU_MAX_VMHUBS - 1, 0);
>> +	}
>>   
>>   	/*
>>   	 * On GFX8 and older any 8 PTE block with a valid bit set enters the TLB
>>   	 */
>> -	flush_tlb |= amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 0);
>> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 0)) {
>> +		flush_tlb = true;
>> +		vmhub_mask = GENMASK(AMDGPU_MAX_VMHUBS - 1, 0);
>> +	}
>>   
>>   	memset(&params, 0, sizeof(params));
>>   	params.adev = adev;
>> @@ -1144,6 +1176,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   	params.pages_addr = pages_addr;
>>   	params.unlocked = unlocked;
>>   	params.needs_flush = flush_tlb;
>> +	params.vmhub_mask = vmhub_mask;
>>   	params.override_pte = allow_override && adev->gmc.override_pte;
>>   	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>>   
>> @@ -1366,9 +1399,18 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>   
>>   		trace_amdgpu_vm_bo_update(mapping);
>>   
>> +		/*
>> +		 * If vmhub_mask is 0, no ring has submitted a job with this BO
>> +		 * yet, so we don't know which hubs may have cached its PTEs.
>> +		 * Be conservative and bump all counters.
>> +		 */
>>   		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
>> -					   !uncached, &sync, mapping->start,
>> -					   mapping->last, update_flags,
>> +					   !uncached,
>> +					   bo_va->vmhub_mask ?
>> +					     bo_va->vmhub_mask :
>> +					     GENMASK(AMDGPU_MAX_VMHUBS - 1, 0),
>> +					   &sync,
>> +					   mapping->start, mapping->last, update_flags,
>>   					   mapping->offset, vram_base, mem,
>>   					   pages_addr, last_update);
>>   		if (r)
>> @@ -1572,6 +1614,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>   		list_del(&mapping->list);
>>   
>>   		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
>> +					   mapping->vmhub_mask ?
>> +					     mapping->vmhub_mask :
>> +					     GENMASK(AMDGPU_MAX_VMHUBS - 1, 0),
>>   					   &sync, mapping->start, mapping->last,
>>   					   0, 0, 0, NULL, NULL, &f);
>>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>> @@ -1989,6 +2034,8 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>>   
>>   	list_del(&mapping->list);
>>   	amdgpu_vm_it_remove(mapping, &vm->va);
>> +	/* Copy hub mask before clearing bo_va pointer (freed list loses the link) */
>> +	mapping->vmhub_mask = bo_va->vmhub_mask;
>>   	mapping->bo_va = NULL;
>>   	trace_amdgpu_vm_bo_unmap(bo_va, mapping);
>>   
>> @@ -2212,6 +2259,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>>   	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>>   		list_del(&mapping->list);
>>   		amdgpu_vm_it_remove(mapping, &vm->va);
>> +		mapping->vmhub_mask = bo_va->vmhub_mask;
>>   		mapping->bo_va = NULL;
>>   		trace_amdgpu_vm_bo_unmap(bo_va, mapping);
>>   		list_add(&mapping->list, &vm->freed);
>> @@ -3048,6 +3096,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>>   	}
>>   
>>   	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
>> +				   GENMASK(AMDGPU_MAX_VMHUBS - 1, 0),
>>   				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
>>   	if (r)
>>   		goto error_unlock;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 2f8234560764..deeb43a7ef86 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -313,6 +313,11 @@ struct amdgpu_vm_update_params {
>>   	 */
>>   	bool needs_flush;
>>   
>> +	/**
>> +	 * @vmhub_mask: bitmask of VMHUB indices whose tlb_seq counters to bump
>> +	 */
>> +	uint16_t vmhub_mask;
>> +
>>   	/**
>>   	 * @override_pte: true for memory that is not uncached and gmc override function is
>>   	 * implemented to allow MTYPE to be overridden for NUMA local memory.
>> @@ -403,6 +408,8 @@ struct amdgpu_vm {
>>   
>>   	/* Last finished delayed update */
>>   	atomic64_t		tlb_seq;
>> +	/* Separate TLB flush sequence for MMHUB rings (VCN/JPEG/VPE) */
>> +	atomic64_t		tlb_seq_mm;
>>   	struct dma_fence	*last_tlb_flush;
>>   	atomic64_t		kfd_last_flushed_seq;
>>   	uint64_t		tlb_fence_context;
>> @@ -528,7 +535,8 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>>   			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
>>   int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   			   bool immediate, bool unlocked, bool flush_tlb,
>> -			   bool allow_override, struct amdgpu_sync *sync,
>> +			   bool allow_override, uint16_t vmhub_mask,
>> +			   struct amdgpu_sync *sync,
>>   			   uint64_t start, uint64_t last, uint64_t flags,
>>   			   uint64_t offset, uint64_t vram_base,
>>   			   struct ttm_resource *res, dma_addr_t *pages_addr,
>> @@ -649,6 +657,28 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>>   	return atomic64_read(&vm->tlb_seq);
>>   }
>>   
>> +/**
>> + * amdgpu_vm_tlb_seq_mm - return MMHUB-specific tlb flush sequence number
>> + * @vm: the amdgpu_vm structure to query
>> + *
>> + * Returns the tlb flush sequence number for MMHUB rings (VCN/JPEG/VPE).
>> + * Only bumped when mappings accessed by MMHUB engines change.
>> + */
>> +static inline uint64_t amdgpu_vm_tlb_seq_mm(struct amdgpu_vm *vm)
>> +{
>> +	unsigned long flags;
>> +	spinlock_t *lock;
>> +
>> +	rcu_read_lock();
>> +	lock = dma_fence_spinlock(vm->last_tlb_flush);
>> +	rcu_read_unlock();
>> +
>> +	spin_lock_irqsave(lock, flags);
>> +	spin_unlock_irqrestore(lock, flags);
>> +
>> +	return atomic64_read(&vm->tlb_seq_mm);
>> +}
>> +
>>   /*
>>    * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
>>    * happens while holding this lock anywhere to prevent deadlocks when
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 30ad10bbd47e..fb888f200f70 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1372,7 +1372,9 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   		return -EINVAL;
>>   	}
>>   
>> -	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
>> +	return amdgpu_vm_update_range(adev, vm, false, true, true, false,
>> +				      GENMASK(AMDGPU_MAX_VMHUBS - 1, 0),
>> +				      NULL, gpu_start,
>>   				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
>>   				      fence);
>>   }
>> @@ -1490,6 +1492,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>>   			 pte_flags);
>>   
>>   		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
>> +					   GENMASK(AMDGPU_MAX_VMHUBS - 1, 0),
>>   					   NULL, gpu_start, gpu_end,
>>   					   pte_flags,
>>   					   (last_start - prange->start) << PAGE_SHIFT,
