Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96B1C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 14:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5452210EEBA;
	Wed,  5 Aug 2026 14:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sbU+HNyI";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5514210E22C
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 14:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icd6Qw59VBYsGf3UT3rxSlr9TAHG79eyN41lMI1KSYnq7iZp/gQvEs38VZF00MUCaeYTFpaqvPmY5w5GEQTm3ymnzyIE5dZxMI7OCNMx+vdDxJu9gwd8Fy5OCS1Bb24P6PTgf6TWSRHsCORkZKyb24hHIn1Qi+eC4+w6IXh/YzpQogfVBThxV9kNxSxVAaWPZw6dt+8h+U0lIggTLVF08cZOQBSp+LADzF4A4zq79nvPJ7c1rza3zSE46RPTcmbJPuQF8w6Ve80e5QppFc9JA9J7ZSYUVvvrbwWZ+FfraF3mBn6CONSTLExnl7nxQFjO7fdpVYWzgn96Zk5Xjt/VnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAq9Rc1/w8lzZWfeYz3DTdiTL1dY9XfPqLhohCmaBn4=;
 b=x9X/Cl03I6f1aWuO1nYfrZz3hyo84bBQoEVrxmoHTT2MHy2WKsriDHHDe6mPM2dIGDK90MMm5gF3LBSr0dTQYsrnqY0j7/aL4ol1y/E9pTohvyQERN7XF9qrPJw0XFtYQn/Ithh+st57qMEPxumaPv0/h5/xPAxsez6m9VoqFpX3UQzWmMpm0/clXzWRPrcQ9e3YtxWlShWwEwBSnw+DaAU8+gXzau2hD3jDY596iPd0XaIhQYa5WBXqqUg6lMUvNU1EmfBpTgj5Vu0dDGWeYhSP322dLplv/nxw6wirin5rRy6idcCCXrjwfwhztZNvAxvOERqk+KhlUiW011qzrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAq9Rc1/w8lzZWfeYz3DTdiTL1dY9XfPqLhohCmaBn4=;
 b=sbU+HNyI/Oo71GmET13lAWl/kAkDyB8X+f8y+S/25E8VI2VLc7CHkCaJ1gpInKlBryy8zI8YbeXWOxBstb9LwJ82b6PN0sN2Bx+DXK9G/JTC2NzNXoEIHI5j/TXysFNoUfRIpSbnUSNeechWDCFezO+gqb6kwIDhhsrR6wScX2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS5PPF2FA070BDF.namprd12.prod.outlook.com (2603:10b6:f:fc00::649)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 14:58:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 14:58:25 +0000
Message-ID: <fc961741-2c4f-464a-8884-6c7ecbd2e48d@amd.com>
Date: Wed, 5 Aug 2026 16:58:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: split tlb_seq into per-VMHUB counters to
 avoid spurious MMHUB flushes
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260804152635.899680-1-David.Wu3@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260804152635.899680-1-David.Wu3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS5PPF2FA070BDF:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e811fcc-e218-4350-7736-08def302000e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|10067099003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mSx8EnidsS7UP5wCATE1n41/Dpi47hymBIfOShOhKADNd+h7xIFj7jn5OyZaVq/W/UrO7ded3fQyP98SgfpCTWRo/VnAu28FSNtzrh6uAuRkC0Rs6g/WmQ0aZxWjED3fT6ZX1P6S8ER201h4fw+H1jrn0RH26O2jaZLIjiZwIbfAmjr4i6YLW8KuvAUYfMU2+/nOhBzpoN6UxvYuGYf0CxTdImnVpuiaORkgy4RzwBaq8bxMCUUzNx0SIAtBMGHD2nLPmxQYos9NHvjJm0fozsfAwqMieiSi3J5USTolzbWUD9/mDYObq/H5ti553Mnlrmym3yWwiMRVzCbRvr0nZgzRCF4OHdCN9cWLwWmVBYcN8tTziozQYPPVMIzxkopgceO8MtU4zrV5x4ZD9C+6dxfGFRCJf6d/k1de+qxOUB0TCC1EtMdpoP1RLMEJgj+/zZbUprUpfgECkZ5Pot2/P1nC3v+R+fedCipnqLU/O6pbsNkPZOnJyvKOnzPnT5ASdb5pQ8prQJIq7oyupe+EL7xYCNiRZw7deSHGH8twhll/GU6LwXF9+sTaQO2mEOAdWEtcHkRLUuld0WGpxc1rO1FuQEoETkFnHD2YKunBeaL/jyJnzHm16tg93SS3qsYpAfFaWllzv3r899dssLWjg8KFLaLHAzJNMdS1ML+B6tM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2tmWHpjOTZRcXZkOTdVajJBSHhnOW00UGFqQ3YyQ1U0Zk5oamk0WjArQTZq?=
 =?utf-8?B?T3Iwd3ZTWjhKZHN0Ymp2eHFiWTVQMFQ1N2djVWl0bmhod0R1K1pZbXlIRWJz?=
 =?utf-8?B?OU15NDRpdTZrWnFDOThmWVZFWk1ORjBSMExMRjFpZm9LTVo0MVpmNlJUM0Zv?=
 =?utf-8?B?YTFxUzgweW1vcnpSTkpaM0dZcnpNL1VEajVHR0J4WGhTZ2ZVSWxqbDVWdndV?=
 =?utf-8?B?MVZFZTVNSVBvVTczWWRGcFZoeUpXS2hDNHNFekhIQ09IblA1RHZNdTNhb2Jx?=
 =?utf-8?B?bUhPWElHZW5PZVdMZExBZmhpOTFHNzB3Qi91SXRYNlNHYytnV1VIbGJjSEFB?=
 =?utf-8?B?b3ZvUTIrZHREbkNGNVJ1VmhiTHQ2N1VFRzZ4cm1rbEhNMFVYSE5LWjJIdms4?=
 =?utf-8?B?UVZuZ2QwZ1h0ako0aFgrVU5icUZMT2xmbE5pWTRkT3l2dzE5M0s4MkNIS1ZD?=
 =?utf-8?B?dVRaajFVK2pvdTFSTVBwRTcvbkRkTHZCbWNrWHBYNUc2QnJpY2pVejM1cEs5?=
 =?utf-8?B?MEp4LzhhYXhGUURFeEJQR0cwSlREV1I1RHNXVllUSzg1bnoxLzB6ZEhYdlNq?=
 =?utf-8?B?ZG15eDJVUWordUZZMWFtc0N2RGZ0TGd0ektGazZjdWJab0FPazc2bEtEWVNa?=
 =?utf-8?B?ajdjOUtMNkkzSjlWb1pkSjZoREsvU3RrN3VYK0ZRSGxIa0NUbklQNUppRGxT?=
 =?utf-8?B?WkJwNUxaSFM2V2lNbWZkUjF6NzFwNTUyekxiTmpvWnFPRUlSUzRWbDB6Q1k3?=
 =?utf-8?B?YmJWbHhKaENISkZaMUhIWUhKd2thd0tVOHZ2RVdWaU5vMldLUWVxMENEVGpU?=
 =?utf-8?B?OTc3Wlc0b0F3L1BQbm9xV3F5b00wa0VIa3NNNUxJTnozMkpSd1hlaHFVajJO?=
 =?utf-8?B?K3hWTnNPSC9URTVjcEdFekdKU1pjTEtxM2paT0xnM1BNck1SZUV5OXNlUGZM?=
 =?utf-8?B?ekE2SUx1MXk1QmtKdGs5Y1l5bEFsR3YwSmpPd3lTMlVFbDJzMnp1NkRvcUx1?=
 =?utf-8?B?cUk5WnBqWXlkVzd0M0NlbEdKczVqQUZzQzBxeGpuUVl6RVliSlhTbmdiOUNp?=
 =?utf-8?B?Z1Y2SGlHSGhDdnhzcmh3b0tBS1l6NlVobFNWQ3V2SEc1ODJueW50cXFlbFRl?=
 =?utf-8?B?cGxERjhQN09TV3NaclJnVnNCYTh4KzJmemdTV2llSGFBY0ZFelB4UmZxbFZu?=
 =?utf-8?B?bElRWm9xVnJ4TkJLSFJTdHdQaGtNVTVGQnc5bDdQU2FGcDFOU053dTRodE9p?=
 =?utf-8?B?TnVxdlphbHdOOUJ0bHZkNVF4M1pPUXBySjJ0RWdpU1Q5N09JMHdRSzZKN0xx?=
 =?utf-8?B?Tlo2bmYrS0Jnbkt1Q0R1TGtiRk9Tbm1DWWVONWx1KzN1RFBEZThrQTA0UkpT?=
 =?utf-8?B?YTUwN202amRnTER6bnA2Y2RPS05ic0J1QkVqNC9FeTdpVjFJcXNUc2dvZENX?=
 =?utf-8?B?R1lTM0duSW9RSXpRVDJaOENTaUlKY3ZNaGhVR1psSi9ES2hXNHpkUklUblNS?=
 =?utf-8?B?a2YrV3V4T01uck1qTjVndlIyQ3NrcWswaHNiQ3VjcUZxUks0cjBjU0kwdmVh?=
 =?utf-8?B?Y0NQRWM3dCtCY1FWTFQ0V1VldUVKNEQ0NEczaFZlWXcwcmhtd09ucEZMRUF3?=
 =?utf-8?B?dVpsUnFBTUZGRS82d1dNQ1hwY1N3TmpRWHA3Z0c1ZllkbXZSRUw1b0tXZjVI?=
 =?utf-8?B?Nm9NS2RteHE1a3F0RlRVUlY3THk5YnNjdlJ1WHdZeVovbklwMzVnbU1JRTMr?=
 =?utf-8?B?WERuZGswUEdoR1BRdllLbW1CeGxadW9ndlpQYlVZTEdEMVFNbGFjVFJxN3Ar?=
 =?utf-8?B?cW9PWGdTeW00M2t5NEl6a2I2SXRqTjFaVHR6MGd1cnc2RHVSYWluSjlpSDcv?=
 =?utf-8?B?ZHVycjRjVTVtSStoYXJDaFRxM09mWlhiN2dxU1hXQzg4UlpCOGZXQkNYcmgw?=
 =?utf-8?B?UG1ESFlxWjZGWkcrWnFydHlQclExVjg0Z1d4OWlWSkYvRDU4V3BSbGFTVGU1?=
 =?utf-8?B?b1QxSXhDQjZYL1ZGOGxaMGx1aWswSXFlMWIrL1hMWmh6a2pDcHptV04vTXdy?=
 =?utf-8?B?UWJsM3VQaUV2bzdQbHp5cGVETWJFUGs1bXhYNFZLQnkvY3FhM0ZPM29qc0VK?=
 =?utf-8?B?ci9FZVFZN1ZyM1VqTDI2N3dYYUcwM2tIL1lFb05pZWx0ZkN0bE5oNExqRjBr?=
 =?utf-8?B?Y0NzSDUyNlhydzNXcDhuWmJ6bDF3b0V2QVhMSzVoam5mc1VqS3hsNk03N2xF?=
 =?utf-8?B?TUVpZ05ERFB5dTdZN08zcWx5Q1RVWk0wUHlra09CdDJUcHZDRi9VZHR3MVVz?=
 =?utf-8?Q?WSeURL1osG0IOm21PQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e811fcc-e218-4350-7736-08def302000e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 14:58:25.3077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWQSdUfZCkma9JBBcMuIO7W1rzAwiJIOC9pTycqufdUDaAb3AslwiyyD4CwFAKuI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF2FA070BDF
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

On 8/4/26 17:26, David (Ming Qiang) Wu wrote:
> On hardware where EFC (Encode Frame Copy) is unavailable or the source
> frame format requires conversion, the VA-API frontend falls back to a
> GFX/compute shader blit (vl_compositor) to perform color space conversion
> before VCN encode.  That blit goes through the GFX/compute ring and bumps
> the VM's shared tlb_seq.  Every subsequent VCN encode job then finds
> flushed_updates < tlb_seq and forces a full MMHUB TLB flush, even though
> no MMHUB-relevant mappings changed.  On multi-instance VCN hardware the
> same issue is compounded by the dedicated PIPE_CONTEXT_COMPUTE_ONLY
> scheduling context Mesa creates.
> 
> Fix this by splitting the single tlb_seq into two counters:
> 
>   tlb_seq    - bumped only when mappings accessed by GFXHUB change
>   tlb_seq_mm - bumped only when mappings accessed by MMHUB change
> 
> To know which hubs are relevant for a given PT update, add a vmhub_mask
> parameter to amdgpu_vm_update_range().  The mask is derived from the set
> of rings in each command submission (collected in amdgpu_cs.c and stored
> in bo_va->vmhub_mask / mapping->vmhub_mask).  When vmhub_mask is 0 (BO
> has never been submitted), both counters are bumped conservatively.
> 
> PDE updates and XGMI/GFX8 legacy paths bump both counters since they
> affect all hubs.  The fault handler uses GENMASK(AMDGPU_MAX_VMHUBS-1,0)
> because the faulting hub is unknown at that point.
> 
> MMHUB VMID allocation (amdgpu_ids.c) now compares flushed_updates against
> tlb_seq_mm instead of tlb_seq, so VCN VMIDs no longer force a TLB flush
> when only GFX/compute page tables changed.

Absolutely clear NAK to the whole idea.

If we unmap something from a VM we *must* invalidate all TLBs who potentially can access them. Oherwise we get massive security problems.

The whole idea here is a NO-GO.

Regards,
Christian.

> 
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> Assisted-by: Claude:Claude-Sonnet-4-6
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     | 37 ++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    |  9 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  5 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 65 +++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     | 32 ++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c       |  5 +-
>  6 files changed, 129 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index afc1c631d55a..33c1e9341774 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1136,19 +1136,34 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>  	 * with p->ticket. But removing it caused test regressions, so I'm
>  	 * leaving it here for now.
>  	 */
> -	amdgpu_bo_list_for_each_entry(e, p->bo_list) {
> -		bo_va = e->bo_va;
> -		if (bo_va == NULL)
> -			continue;
> +	/* Collect vmhub bitmask for all rings in this submission */
> +	{
> +		uint16_t sub_vmhub_mask = 0;
>  
> -		r = amdgpu_vm_bo_update(adev, bo_va, false);
> -		if (r)
> -			return r;
> +		for (i = 0; i < p->gang_size; ++i) {
> +			struct amdgpu_ring *ring = amdgpu_job_ring(p->jobs[i]);
>  
> -		r = amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
> -				      GFP_KERNEL);
> -		if (r)
> -			return r;
> +			if (ring)
> +				sub_vmhub_mask |= BIT(ring->vm_hub);
> +		}
> +
> +		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
> +			bo_va = e->bo_va;
> +			if (bo_va == NULL)
> +				continue;
> +
> +			/* Track which hubs have accessed this BO for per-hub tlb_seq */
> +			bo_va->vmhub_mask |= sub_vmhub_mask;
> +
> +			r = amdgpu_vm_bo_update(adev, bo_va, false);
> +			if (r)
> +				return r;
> +
> +			r = amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
> +					      GFP_KERNEL);
> +			if (r)
> +				return r;
> +		}
>  	}
>  
>  	r = amdgpu_vm_handle_moved(adev, vm, &p->exec.ticket);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 8a2d64f0ebc3..9183569d340a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -331,7 +331,8 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
>  	unsigned vmhub = ring->vm_hub;
>  	uint64_t fence_context = adev->fence_context + ring->idx;
>  	bool needs_flush = vm->use_cpu_for_update;
> -	uint64_t updates = amdgpu_vm_tlb_seq(vm);
> +	uint64_t updates = AMDGPU_IS_GFXHUB(ring->vm_hub) ?
> +		amdgpu_vm_tlb_seq(vm) : amdgpu_vm_tlb_seq_mm(vm);
>  	int r;
>  
>  	*id = vm->reserved_vmid[vmhub];
> @@ -395,7 +396,8 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
>  	unsigned vmhub = ring->vm_hub;
>  	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>  	uint64_t fence_context = adev->fence_context + ring->idx;
> -	uint64_t updates = amdgpu_vm_tlb_seq(vm);
> +	uint64_t updates = AMDGPU_IS_GFXHUB(ring->vm_hub) ?
> +		amdgpu_vm_tlb_seq(vm) : amdgpu_vm_tlb_seq_mm(vm);
>  	int r;
>  
>  	job->vm_needs_flush = vm->use_cpu_for_update;
> @@ -492,7 +494,8 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>  
>  	job->gds_switch_needed = amdgpu_vmid_gds_switch_needed(id, job);
>  	if (job->vm_needs_flush) {
> -		id->flushed_updates = amdgpu_vm_tlb_seq(vm);
> +		id->flushed_updates = AMDGPU_IS_GFXHUB(ring->vm_hub) ?
> +			amdgpu_vm_tlb_seq(vm) : amdgpu_vm_tlb_seq_mm(vm);
>  		dma_fence_put(id->last_flush);
>  		id->last_flush = NULL;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index ff11a0903499..1d6373f1d985 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -70,6 +70,8 @@ struct amdgpu_bo_va_mapping {
>  	uint64_t			__subtree_last;
>  	uint64_t			offset;
>  	uint32_t			flags;
> +	/* bitmask of VMHUB indices whose TLBs have cached this mapping's PTEs */
> +	uint16_t			vmhub_mask;
>  };
>  
>  /* User space allocated BO in a VM */
> @@ -91,6 +93,9 @@ struct amdgpu_bo_va {
>  
>  	bool				is_xgmi;
>  
> +	/* bitmask of VMHUB indices that have ever submitted jobs referencing this BO */
> +	uint16_t			vmhub_mask;
> +
>  	/*
>  	 * protected by vm reservation lock
>  	 * if non-zero, cannot unmap from GPU because user queues may still access it
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index aac8ace9d7a6..b05befa1d5c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -121,6 +121,11 @@ struct amdgpu_vm_tlb_seq_struct {
>  	 */
>  	struct amdgpu_vm *vm;
>  
> +	/**
> +	 * @vmhub_mask: which hub counters to increment (bitmask of VMHUB indices)
> +	 */
> +	uint16_t vmhub_mask;
> +
>  	/**
>  	 * @cb: callback
>  	 */
> @@ -1008,8 +1013,10 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  	if (r)
>  		goto error;
>  
> -	if (flush_tlb_needed)
> +	if (flush_tlb_needed) {
>  		atomic64_inc(&vm->tlb_seq);
> +		atomic64_inc(&vm->tlb_seq_mm);
> +	}
>  
>  	list_for_each_entry_safe(entry, tmp, &vm->kernel.needs_update,
>  				 vm_status)
> @@ -1031,9 +1038,25 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>  				 struct dma_fence_cb *cb)
>  {
>  	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> +	bool any_gfx, any_mm;
> +	unsigned int i;
>  
>  	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
> -	atomic64_inc(&tlb_cb->vm->tlb_seq);
> +
> +	any_gfx = any_mm = false;
> +	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
> +		if (!(tlb_cb->vmhub_mask & BIT(i)))
> +			continue;
> +		if (AMDGPU_IS_GFXHUB(i))
> +			any_gfx = true;
> +		else
> +			any_mm = true;
> +	}
> +	if (any_gfx)
> +		atomic64_inc(&tlb_cb->vm->tlb_seq);
> +	if (any_mm)
> +		atomic64_inc(&tlb_cb->vm->tlb_seq_mm);
> +
>  	kfree(tlb_cb);
>  }
>  
> @@ -1054,6 +1077,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>  	struct amdgpu_vm *vm = params->vm;
>  
>  	tlb_cb->vm = vm;
> +	tlb_cb->vmhub_mask = params->vmhub_mask;
>  	if (!fence || !*fence) {
>  		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>  		return;
> @@ -1106,7 +1130,8 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>   */
>  int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			   bool immediate, bool unlocked, bool flush_tlb,
> -			   bool allow_override, struct amdgpu_sync *sync,
> +			   bool allow_override, uint16_t vmhub_mask,
> +			   struct amdgpu_sync *sync,
>  			   uint64_t start, uint64_t last, uint64_t flags,
>  			   uint64_t offset, uint64_t vram_base,
>  			   struct ttm_resource *res, dma_addr_t *pages_addr,
> @@ -1129,13 +1154,20 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	/* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
>  	 * heavy-weight flush TLB unconditionally.
>  	 */
> -	flush_tlb |= adev->gmc.xgmi.num_physical_nodes &&
> -		     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0);
> +	if (adev->gmc.xgmi.num_physical_nodes &&
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0)) {
> +		flush_tlb = true;
> +		/* XGMI: all hubs need flushing */
> +		vmhub_mask = GENMASK(AMDGPU_MAX_VMHUBS - 1, 0);
> +	}
>  
>  	/*
>  	 * On GFX8 and older any 8 PTE block with a valid bit set enters the TLB
>  	 */
> -	flush_tlb |= amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 0);
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 0)) {
> +		flush_tlb = true;
> +		vmhub_mask = GENMASK(AMDGPU_MAX_VMHUBS - 1, 0);
> +	}
>  
>  	memset(&params, 0, sizeof(params));
>  	params.adev = adev;
> @@ -1144,6 +1176,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	params.pages_addr = pages_addr;
>  	params.unlocked = unlocked;
>  	params.needs_flush = flush_tlb;
> +	params.vmhub_mask = vmhub_mask;
>  	params.override_pte = allow_override && adev->gmc.override_pte;
>  	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>  
> @@ -1366,9 +1399,18 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>  
>  		trace_amdgpu_vm_bo_update(mapping);
>  
> +		/*
> +		 * If vmhub_mask is 0, no ring has submitted a job with this BO
> +		 * yet, so we don't know which hubs may have cached its PTEs.
> +		 * Be conservative and bump all counters.
> +		 */
>  		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
> -					   !uncached, &sync, mapping->start,
> -					   mapping->last, update_flags,
> +					   !uncached,
> +					   bo_va->vmhub_mask ?
> +					     bo_va->vmhub_mask :
> +					     GENMASK(AMDGPU_MAX_VMHUBS - 1, 0),
> +					   &sync,
> +					   mapping->start, mapping->last, update_flags,
>  					   mapping->offset, vram_base, mem,
>  					   pages_addr, last_update);
>  		if (r)
> @@ -1572,6 +1614,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>  		list_del(&mapping->list);
>  
>  		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
> +					   mapping->vmhub_mask ?
> +					     mapping->vmhub_mask :
> +					     GENMASK(AMDGPU_MAX_VMHUBS - 1, 0),
>  					   &sync, mapping->start, mapping->last,
>  					   0, 0, 0, NULL, NULL, &f);
>  		amdgpu_vm_free_mapping(adev, vm, mapping, f);
> @@ -1989,6 +2034,8 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>  
>  	list_del(&mapping->list);
>  	amdgpu_vm_it_remove(mapping, &vm->va);
> +	/* Copy hub mask before clearing bo_va pointer (freed list loses the link) */
> +	mapping->vmhub_mask = bo_va->vmhub_mask;
>  	mapping->bo_va = NULL;
>  	trace_amdgpu_vm_bo_unmap(bo_va, mapping);
>  
> @@ -2212,6 +2259,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>  	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>  		list_del(&mapping->list);
>  		amdgpu_vm_it_remove(mapping, &vm->va);
> +		mapping->vmhub_mask = bo_va->vmhub_mask;
>  		mapping->bo_va = NULL;
>  		trace_amdgpu_vm_bo_unmap(bo_va, mapping);
>  		list_add(&mapping->list, &vm->freed);
> @@ -3048,6 +3096,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  	}
>  
>  	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
> +				   GENMASK(AMDGPU_MAX_VMHUBS - 1, 0),
>  				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
>  	if (r)
>  		goto error_unlock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 2f8234560764..deeb43a7ef86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -313,6 +313,11 @@ struct amdgpu_vm_update_params {
>  	 */
>  	bool needs_flush;
>  
> +	/**
> +	 * @vmhub_mask: bitmask of VMHUB indices whose tlb_seq counters to bump
> +	 */
> +	uint16_t vmhub_mask;
> +
>  	/**
>  	 * @override_pte: true for memory that is not uncached and gmc override function is
>  	 * implemented to allow MTYPE to be overridden for NUMA local memory.
> @@ -403,6 +408,8 @@ struct amdgpu_vm {
>  
>  	/* Last finished delayed update */
>  	atomic64_t		tlb_seq;
> +	/* Separate TLB flush sequence for MMHUB rings (VCN/JPEG/VPE) */
> +	atomic64_t		tlb_seq_mm;
>  	struct dma_fence	*last_tlb_flush;
>  	atomic64_t		kfd_last_flushed_seq;
>  	uint64_t		tlb_fence_context;
> @@ -528,7 +535,8 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>  			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
>  int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			   bool immediate, bool unlocked, bool flush_tlb,
> -			   bool allow_override, struct amdgpu_sync *sync,
> +			   bool allow_override, uint16_t vmhub_mask,
> +			   struct amdgpu_sync *sync,
>  			   uint64_t start, uint64_t last, uint64_t flags,
>  			   uint64_t offset, uint64_t vram_base,
>  			   struct ttm_resource *res, dma_addr_t *pages_addr,
> @@ -649,6 +657,28 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>  	return atomic64_read(&vm->tlb_seq);
>  }
>  
> +/**
> + * amdgpu_vm_tlb_seq_mm - return MMHUB-specific tlb flush sequence number
> + * @vm: the amdgpu_vm structure to query
> + *
> + * Returns the tlb flush sequence number for MMHUB rings (VCN/JPEG/VPE).
> + * Only bumped when mappings accessed by MMHUB engines change.
> + */
> +static inline uint64_t amdgpu_vm_tlb_seq_mm(struct amdgpu_vm *vm)
> +{
> +	unsigned long flags;
> +	spinlock_t *lock;
> +
> +	rcu_read_lock();
> +	lock = dma_fence_spinlock(vm->last_tlb_flush);
> +	rcu_read_unlock();
> +
> +	spin_lock_irqsave(lock, flags);
> +	spin_unlock_irqrestore(lock, flags);
> +
> +	return atomic64_read(&vm->tlb_seq_mm);
> +}
> +
>  /*
>   * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
>   * happens while holding this lock anywhere to prevent deadlocks when
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 30ad10bbd47e..fb888f200f70 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1372,7 +1372,9 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		return -EINVAL;
>  	}
>  
> -	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
> +	return amdgpu_vm_update_range(adev, vm, false, true, true, false,
> +				      GENMASK(AMDGPU_MAX_VMHUBS - 1, 0),
> +				      NULL, gpu_start,
>  				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
>  				      fence);
>  }
> @@ -1490,6 +1492,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>  			 pte_flags);
>  
>  		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
> +					   GENMASK(AMDGPU_MAX_VMHUBS - 1, 0),
>  					   NULL, gpu_start, gpu_end,
>  					   pte_flags,
>  					   (last_start - prange->start) << PAGE_SHIFT,

