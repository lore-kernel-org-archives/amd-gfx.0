Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF71DCA5FF0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 07:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705FC10F209;
	Tue,  6 Oct 2026 07:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5N0zyaUU";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605D410F209
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 07:27:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHv0ZJ00m5k9C0HGNRX/zsgfMALr+CjDkcMc7VloWpGcHb/7E4jLgvBLz4sTNTQ5sXWMeyG2i6TMIjs+oqBr62sjcY0ofI5Pxx4y4G4Z6cgXGDcx+z5zKEioHj8I2/mpMoehAPrRqFOhilAjCaxjRp7v22sDR+h8ON3BBL954rrW/Yk3h+jCTp9JkxjvKCjyK0Tuhf+/PhA7gPYgJTzI1SCoWIZdOZyPprvEg/ggMAW+0W/vfsQoYzTptYZlwzBIhE6qLOWCT+2tQFVHPQIGgrKUIul3G2rtkc79S80L9pxrThaRwWJE8v1x4ij6UvjLnw+RdhLJj5ri5rucp50qYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtByaULwkn7hNCanUV2EGl2M1x091mwTvL4umU7v3To=;
 b=K8lLwa3cnj1sGp1Wv2l58/ebwWICGmOMZxKIurJg+xm2f0wMtwBL3kyuBzCjLnIdb/ZUenz0hh5jZcEh+y71h6SuW4JKMiwThHHVNx8urbhI7pBrPJxyY2OVxrSko1pRtYPU/B40+kOSA+kktT/zu2NLGxRDafX45ZtcaVvDqGiDLvXiQcQyjf55hRM9eDf4E3BWJImqnwfOhe9DQ0k4Ueg+MP0dG8mQ5ru2rObzcMjaeh7BlvEyWEQaDPnDfjh2p3kvOGv6XvJvaMdWKjqTHW4bgbv6oa4kbjf9Fj+xNJvSqeaTQsdb+jpB9UGNabIveKIsj7zPDazTh7KKgeuHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtByaULwkn7hNCanUV2EGl2M1x091mwTvL4umU7v3To=;
 b=5N0zyaUUcG6ZJavciSelv2VsemLRjXb1jWOV5qimjEwPWe4n/SoiAGC+iPn4unvX69lJbUqz58F10GM1xSfLx/SGOL01s9WPmmdEsRnwJbe0izUXv+1U/InvGLd63E8rY18IbXUAK5KV+Z8TjgSwUMThmfnyczYG5kD4lLGSQBU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.29; Tue, 6 Oct
 2026 07:27:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 07:27:17 +0000
Message-ID: <04899fe2-1b3c-43f2-a130-9c71b56715c1@amd.com>
Date: Tue, 6 Oct 2026 09:27:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: don't drop the TLB flush fence in the GEM VA
 ioctl path
To: David Yat Sin <David.YatSin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: Bincy.Mani@amd.com, Cursor <cursoragent@cursor.com>,
 Natalie Vock <natalie.vock@gmx.de>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20261005214318.2272476-1-David.YatSin@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261005214318.2272476-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: b1798a77-6012-4f97-4b35-08df237b404c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GzJUOs9vmOR87NogUQsh9w/dr/xeimC0E85SvXhLgp9wxq5tfveZmI+oT4+K3Plo5vKVWm8t3wO/OYT6WgDV42Xx/9ko8ysJG4KMMzEMQyRamqmhcArTBuFXQhl4EP8hx8BUC65c04+urw9GiPCjZ+3d7AdR7D6pCjn4Ca+rurtpi9Ad+nHlBGZ0yFKXaAb4ZCpzlSpgm53nO3M+TgtnFk3EVXtMWTEZ8huhTq8Oql+Pzn4fdQrPgx3qGFZv9KIAIJDx6x+Ij/0XTu8Bp+eIq4UNSCbWAZiDHgUrKFBn73tj0eMjaS+mFaI8Q/MK664iZSJylh0WFGFE7ifL8eBx4pMalSPjwP+9Ix5jIL4mA6iFzwdzWRI9RYLmgqh/dpyIT0DzzeFJqWCGwpNrHzHBbuxa9NH5a9ryymZ9sSdR+GnWBJ+hyvMX1wWSiITRp6sGZcKk7VBhogdjNe4/kt0Wct1dW42VWB+chx/qLiaWFTDa1bUQO6219FR8e0ktzQ6yRdhlPF+G+ML3Lb9d8mCVumlbBBv1isFXSPTqh9Ovlmu3NkJdwzBuPr/Larb6VkZkZPjUG7uoaLsa8R8omROTwmdO4tTZBTbI4iRO2iXK1kOhl1wlJ9LM+2YAm7jwABrC+eZ6sDJnN0H/i0496JBvEjHdoCh/ysAJVhchPCEOQLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWhmUVMzMTZOVjArVEg5dE9LTzJFNGJyQVBodTZ3OHNDTGt1VEQvMjlJVGJr?=
 =?utf-8?B?NDVpWDVsbFBSeTR2YlFoUWN5a1E4czB6NkJYQXF1TEpwYXZzUmIxOXBpZUFy?=
 =?utf-8?B?WTFvelpIQ2NLMnY2UG5HMDhCUXZScHlVSXI5RmxwUGtCZkVZUFBWSHcrUHBR?=
 =?utf-8?B?cC84UXBxNE9qR0I3TlJFUXVpYTZwNUtGdlRoV0h2RmpoQzNzQVpUd1ByNUR0?=
 =?utf-8?B?L0ZHZFZXL0tGZEI1M29EQTd0eFBCVSs4bUs2Y1BlU3pIaEZmODhOYnhmWTgx?=
 =?utf-8?B?a0hBVEIvYzVneEh1OHV2c0g2K0l2TEkxb2ZqSEZTcVZlUzNRRTE4Q25rR3dR?=
 =?utf-8?B?dmt0dlpFOUMzcEJXTE42VXlLL09ybytsYk9ZZVpVKzRydjcvSGlPaU5VanEy?=
 =?utf-8?B?MGlZRmNTKzl4bUI0RFNoVU5OSExROTJac3lzcEU1YjBCZjgybk9xd1V5OFVB?=
 =?utf-8?B?MXVrUTVGSUhzUm9RODFCSGtMSFcwS2t6VEc0YW1Jb2I1bFJsTC9oQ08vd3l3?=
 =?utf-8?B?L2hZODRudzFDZGpOSzV6cW90ZkFCbWtxYS9TTEtaK3FrcFkrK0tpQ2hmZVJE?=
 =?utf-8?B?Wko2NFM4UUx6emdvZVEzbjNYWVQwSFY0NjZoVlpIN0czbWxFNHhjb0FoNTUw?=
 =?utf-8?B?aE5pRFM2cHJKa1lnQnN4NzBEMEhrVDUwUVRReTc2MFhleENKeHBXYVVzclFR?=
 =?utf-8?B?a2dIY3RKRGZIRExOT3N0c3MwZXpMdmk3MFV2MzREa011RGc1YUxkankwNWVX?=
 =?utf-8?B?N2FBdnpyaXhKYVdkQkI1ejIyQjVsM2djSEtHVEsxdjBFWC93blZibjZSbzlM?=
 =?utf-8?B?eDh3cFhhVTI0NWlLamwwcEh3VUg4VVIrUlJTVjB3QXhlZEI3eC9FdTBHRjNh?=
 =?utf-8?B?Um82aDNXSUNGeG81N1lSbDU1MjZqMGJ3bWMxbWhxWE1abmlnanVEWS9IalBC?=
 =?utf-8?B?enBqZWZ0UUVHZEtYQ2JwdGdoYkdGRmZOeHdlRGJ3MHFuR1RSeXJLY2JMY0Rk?=
 =?utf-8?B?L0ZqWTFzMk5jSVA5NXJaOFlzUWVxT1ZoZDJtaUc0NWRtQnk2N0lDU3JlUkM2?=
 =?utf-8?B?QzFFeStZbW9iSEVJT1VwZjc0aHRZUlE1aDYwdG1sK3JLV2tUREVhRFowNWhT?=
 =?utf-8?B?U0RJaXF5Ui9tRXY5ZDVZbXJoVERpVGF0WTlXd1hMVTdhaitnZnJXY05lNUl2?=
 =?utf-8?B?NFR5SWx0K2U1cG50VHBpcXA4djZhQ3ZvUHkzQ2pFTFY3VzRWWnd3d0lYRTZX?=
 =?utf-8?B?QkNxRGJmbnRTVHN4UHRnY3Z3Z2R2d2l1M2xORlpFRW9GVEx4S3VoamwvU2pv?=
 =?utf-8?B?MXN2R1FBTUR4QU1UU2xndUQzTWdNMXNzeFUrR2dGRk50OEE1OEpjVi81aTgr?=
 =?utf-8?B?SXp0WHNRTEF1aTk1YkhiTFd2cmsyaHVXdXBYNThGclVZbUd1bytZVEtRd1F2?=
 =?utf-8?B?UEg0bVVIV2wwdG9Ndjh4NHZmWmJCemg1RkZuWXIyS2RmMHd4RzhyTmo3dU05?=
 =?utf-8?B?YXJCQlk2U3ZUc0U5bWMzRXdNNjNpQjZKN3Y4TUN4dmdITUhtTEZNVDVEekEx?=
 =?utf-8?B?WUNnN1RyY2xKOWxjeE1FNDlUQmkzYlBJeFRISGhtaUFxOXo0cWpTbTRtcS9u?=
 =?utf-8?B?YUZhYjJxQnFpbUZYRHFKcDhiOFZrb2dxeUNqWmxrVHZLR2w3dGFnUUR5OE9G?=
 =?utf-8?B?azlvRExBTmFibkNqNmRWNElZY3pjMEdmaHROTnpHaDYrSlorMDgyclZsbUZQ?=
 =?utf-8?B?NlgxdnJkN2lIVjdDRG9DK214VE5HWDl6V0hycmMxRSs1d1dLUDd0U0h6cjFt?=
 =?utf-8?B?TCtPWDJRaVZZa2sxdUY0a2ZpV01zYS9hMkRyYnZ3cnZYYm9lSjZiaXZHcklQ?=
 =?utf-8?B?L3RIN2tRTXpuc1BUbWVzbXUvaFRDNkx3anNXZnpycVhTTm4rb1ZxT1E0WGdM?=
 =?utf-8?B?WlJqKzdIQ2UwMFE5bmNkVXg3WmdySEhmZHA2UHZsUnFPYkY4Y2diR0hlZ1Y2?=
 =?utf-8?B?ei9tYW9hdEd3UFVucnFKS05Tc1lrRnlJRGRIQ3J4Ui82Ui9IMHlsV29TVGgw?=
 =?utf-8?B?ekJXVnBLRGQxMmdvSllBbkE2ME8xUStlWlRCMWdlNFgxMldrUld0SDZaZUU0?=
 =?utf-8?B?TGVHbU95MXBHc0ZtblVhVXAzb0ZnWHRpdnc5VkZpeDZzVFVBQnFYM3MraGlj?=
 =?utf-8?B?L0UyK2xHYnlVMGdnaEk5RWczRzNkU1pPejFKUFBJT1ZqWFJ0czRMQVJsT1E0?=
 =?utf-8?B?aWRadGEvNGUrYmJXa1o4YzROOEF2S1hORDduYVZOY2JFazdZNWZEUmtzZG1X?=
 =?utf-8?Q?viCzk/7EXwuz+a5WkO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1798a77-6012-4f97-4b35-08df237b404c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:27:17.7589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kl3jO0bdAt8UfKsxY5n1kUUhx+XSq1Jo224pEEsIK2suCnSlAQZhGVIscQgzp4RL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426
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

Hi David,

dropping the internal list and adding the public list and a few people.

On 10/5/26 23:43, David Yat Sin wrote:
> When a compute VM is managed through the DRM GEM VA ioctl, the VM
> timeline syncobj can signal before the TLB invalidation has completed.
> Userspace that waits on the timeline and then reuses the VA can hit a
> stale translation and access the pages of the previous mapping.
> 
> This was the call flow:
> amdgpu_vm_clear_freed() already asks for a TLB invalidation: it calls
> amdgpu_vm_update_range() with flush_tlb set, which reaches
> amdgpu_vm_tlb_flush() and, for a VM with need_tlb_fence, replaces the
> update fence with one created by amdgpu_vm_tlb_fence_create(). That
> fence only signals once amdgpu_gmc_flush_gpu_tlb_pasid() has run, so
> vm->last_update correctly covers the invalidation at that point.
> 
> amdgpu_gem_va_update_vm() then calls amdgpu_vm_update_pdes(), whose
> commit() does swap(*fence, f) on &vm->last_update. When any PDE is dirty
> this overwrites the TLB flush fence with the PDE update job fence, and
> that is what gets attached to the user visible VM timeline syncobj.

Good catch, we already had multiple people running into this problem. Including Sunil with userqueues.

But this fix here is completely broken. What we need to do is to track the TLB invalidation and page tables updates separately.

Natalie and I already discussed parts of what is necessary here and will probably come up with a full patch to fix the issue.

Regards,
Christian.

> 
> Userspace waiting on that timeline therefore only learns that the page
> table write landed, not that the TLB was invalidated. When no PDE is
> dirty amdgpu_vm_update_pdes() returns early, the fence survives and the
> same sequence works, which is why this only reproduces for some sizes.
> 
> Publish a fence that covers the invalidation for compute VMs, with the
> page table update as its dependency, instead of blocking in the ioctl.
> 
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>
> Assisted-by: Cursor <cursoragent@cursor.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index efc270e99b4e..84f7d56a15ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -799,6 +799,16 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  		fence = dma_fence_get(vm->last_update);
>  	}
>  
> +	/*
> +	 * A compute VM is shared with KFD and userspace reuses the VA as soon
> +	 * as this fence signals. The TLB flush fence produced while clearing
> +	 * the freed mappings is dropped when amdgpu_vm_update_pdes() replaces
> +	 * vm->last_update, so publish a fence that covers the invalidation
> +	 * instead of blocking here.
> +	 */
> +	if (vm->is_compute_context)
> +		amdgpu_vm_tlb_fence_create(adev, vm, &fence);
> +
>  	return fence;
>  
>  error:

