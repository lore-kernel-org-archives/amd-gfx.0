Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFE2C61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 07:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D491A10F292;
	Fri, 28 Aug 2026 07:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j5BY4WcG";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010056.outbound.protection.outlook.com
 [52.101.193.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286C310F292
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 07:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8vduyH2Jkd9esGvO5K25uYATCK4EOtkTL+QqM7LmKkVVNBjc2R6JnlucsKp00mhzTd0y2FxwDEuGbcvOxxUPenDNj2Bh2wG5qSrjsn6B4lc7xcxLTN2yxjuf4OYkh46LXtMhhM3vN3wlP0q0jYJMjcBYCXO5qMif6LmpszjIvzwbYZrE1o2WyI7EmDqYdnJcuiMAN94NH/5opaeFs2XBrITc5/xV8Oyq4MhhLlxPpotvQU147RkVwUpIRewbqjQ9fw4U00UMuRMANlY6KCdWn0TPIw/lghUUcitFn3SZ1iEicaWZFnYU0qsAZxpS4giWU8a38ETfv+LJbJv5ku4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y33N/DitfV23OgUakDS1sw1pRcK8rnUoZdhWsWFHERg=;
 b=yNaiz39cFinGjoFflJgSQ2aZRQrIM5doMxSf/Qe1adFWx67gpjk3KnTHU9XR7sE1r7S11aPLWRFc+9dTkAxIVSwPM1vlxBTcpq4IxVIGXfn5bh3NdTidtGIB96D4fTNbaDDdOfAY5o2KQ4iitjJpYP1mg6SnrGYN1XINpKq6XORpU/JAXjjD90WyX6CxlnToePWgI4krQnAVBFsk/Cy8bF0mdouxahkAwK3cVAcGjHfZk/0y80+1D4xpuIMredfcViDI4ZIRXKVAXjHkDsjIpB56pfBKnGp+ozG1C1Pv756cstgAT9wVEnHT5nvCoBiuL4qBfb57ro4atijZn1KkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y33N/DitfV23OgUakDS1sw1pRcK8rnUoZdhWsWFHERg=;
 b=j5BY4WcGZSuerTVGzhvK8gVAZIAOsK6X6ccQGSVbTDSwQVSrFilpZyri0QK4Vz6RzIvAYZpTP2eJtoRKDLxCksIp5bv+aiLdfg4SGAr9/kf3e8aVo2haEWHHUxyAuP1w8LBf+t1W7jBEeQjJVEqmCRrSfvmh7zzdMPkpRRAs7bY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 07:29:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Fri, 28 Aug 2026
 07:29:12 +0000
Message-ID: <40134b08-2e8d-4020-9984-b6a9950135fc@amd.com>
Date: Fri, 28 Aug 2026 09:29:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] drm/amdgpu: make amdgpu_vm_bo_lookup_mapping()
 take a raw address
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260827154849.1021013-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260827154849.1021013-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: cd831cf6-4b00-4640-4f62-08df04d60eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: VywxQ0yy3VWO8L5i+iAAqztNnOp4Cj786FX+aHDOX1oaGXjsJKdvUAFUwu6uyA9bz/gP28M1aLaRLAy5GW27tSGq8TD97UY6lckKR8efvezZxcrLZS/0z3I18Q9u7CsolCh9wrxg5YHOI70Dl420SCNJpZo76PgGZQfswitsqWNWNnRzH1ZSpv4fwrI6DYZJ4uI6ENWunGsdh3Y3c+jhtFZRhJzmx7rri1FaiG/c0hZgztK0VpcV9rj8sdRrFG8cuuTcQac2/BBNGESw7hzqh5mRaBJ+5tlc1zgtQAMuAUZxwkWXkY71LvZTPgFnViNjIbBrUxb9MGpGTdVvLT6fVoc3YJOrQJMNDsQFdT8EWuV3cvfkqS+aWj2W9nVu6yRpBug9ZnyfdxL5oM+Stvc5ICMIXPtmkA/PLfbRkdZKbBi9q53kFbR9NHVowksFlPDz50eyMoKz81SEUy3Qsn6ZTNOIwfdUxrcgTNAvmtsHROOam8o377V/3SGG1p4eYZNyr6CGDphRJuldkVE9raHz213Bh6osphcfSnAzawLwpN5RlGbDkwEPze2aZ6UoXETjuhfIBREeqVeBDJ2NXkgc0fyfIXPnFzKpHTBrCrroe0FsH9xCM79ZRbybZud8mTTJzvnXFmp3TWM8Oq96DV3Ayj1lfGimU3slTPcO+3/Y7qo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTR4ckNlUlZQd0MvRDZJN1hKNU1QY2ZuY1drRHczcEt0dVc2QUo3WmorakNS?=
 =?utf-8?B?dnFLTGZuZkxldU1Kb29EVjYzRjg1UlpxbnpnN0hTd0p6eUxnU25nMXppRS8r?=
 =?utf-8?B?RVZaZ1FkUGZEVHpkQXUrRUlSbnFadm5iSGx1SmdleDdYd3VCRmMwaVFmQ0Fr?=
 =?utf-8?B?MGtEdFhpYWQrQndKejhxNC9BS251MUtzQ3R3aTRxeG54bXp5Zms0Ym1sdmFI?=
 =?utf-8?B?S2tZL0RTL0QrakpRN3Fic2pUalplWEVIVTE5dTlpZTRHeDRaSkdkK3VyVGQ2?=
 =?utf-8?B?OGx6ZDFDRHNBUzhUOXViZWdQMnlBT2JHQ0VkNkxDWWtsR3Z4TmhvRFBPekt6?=
 =?utf-8?B?Zm5aMVpqU2JnaHpLaUUrUVZrNFVWeC92czlNeVgzem0wY1hkNHM3UExJTmJK?=
 =?utf-8?B?K1ZnT216ek9jak8yWmxLc3dLaXU3TUxBSzBaaGdrU2h2amx4RmE5Mk5RTlpG?=
 =?utf-8?B?V0FjRkVJbWt1L3JnSjJQalQ4Y0RORjQ1K0diUGZMNG1wRnhtV1FZZW0yZnNr?=
 =?utf-8?B?c2pHb3NrTmFZSGRjdWNTb0F0MGcyc0N2NXZwMlJlcXVlTXQzM3R4elkwcFc1?=
 =?utf-8?B?Z3RWOG8rbFdZbmVpTk1xUUsrZVdiT2hvaWxYOHNHTnl0MUlETk1xR3lnOS9F?=
 =?utf-8?B?dzlnOWtWWjFBd1NGNkJvSVo5RE5mNlkvTDR2NW9PV0ZVWU1TZnlFZ09ZRnVW?=
 =?utf-8?B?aG50VzloeDQyN2dNbW41L29lOHVLTDJEUnkzMjdEQVlDcXhIVU43MU4vUjJV?=
 =?utf-8?B?UTdrN2h0QjRZL04xV2x5UHBFbjFkTjBONURFOHhUN2xXeWFuWElmM2ZlL2Zr?=
 =?utf-8?B?Y1JWb1lkZ2wzakJFWHE1Mys0Y0R2YWo1RThMbVpiWlJhY1dqajZLbDNNN3VP?=
 =?utf-8?B?bnNYZ0U5b01jRG00T1U2RWFWQ1hXVitIN1EwendNWGtqYTdwc0g3OEJQSXlh?=
 =?utf-8?B?c3J6RkdQWjFiamZ3aWVLQVJzMWxnSHorM3laRWl6VGg4QXl2a1F3ejlhV2Q4?=
 =?utf-8?B?dEptK1d3aFFTcmF0YmMrTkg4aFJSQXkwUmtwKy9RVDFXYXJYaHpEMStzZzZP?=
 =?utf-8?B?R2QwWXpWbU4xWjB1QjlPeU1UVEYzUUlnbmRJMU1SYjN6ck8zQ0s2ck9MYW0z?=
 =?utf-8?B?OGhDd1lDL0VJcnIzN3grcStHTmI5ckppQ0dSSmdsYmJEc1ZYZWdMSWxNSGRo?=
 =?utf-8?B?OTB4SEl0U0lFeTFaOURWcXAzY1ZEK1M2Qm9GMUlRRWdOTXA4cXJ6b2NZQVZx?=
 =?utf-8?B?K05FbDBEOGR3Z252cGxZZnZaYnZqanRoa3lLdGVJZXZSVms5SHFwa0hRR1VD?=
 =?utf-8?B?Mm9GVU5VUVAwcTBlTGMvNDlDZ3hYWHVsUStJMWpVY3Q1cm5uWklEbW80amxq?=
 =?utf-8?B?WWlzZWlGblFTVTdnbGNiRFRpODhXMEZvOG5HRW1FR3A3WEs1Y2tIeHVjZThY?=
 =?utf-8?B?M3hycU9DakNhc1haREV5L1dnSE5JMzJ0ZTFmVXNURjMwT3VDbEY5TnR2Yjll?=
 =?utf-8?B?V2NaYVVEN0ZDNjdpRnBlTExtd2VxcWIzaU9MVk5qczlPNHh3N3pRNTlzWGFs?=
 =?utf-8?B?N3dGYzNhVUkzd0x2MkpKellUbEFyQUFuM29XUm51c1l4bm9VM2ZBOG01M3h1?=
 =?utf-8?B?SWNSbUlhaWQ5QVlYZnlZWUd1OG1VSUEwQ1lISktZWlBJTXg1RWl1Z3JyU0Vi?=
 =?utf-8?B?eXM3TTRuR0RFK0lOYnhkUEc3UHp1dnlwT2I0eFVOMXd6KytoS0NNTkw2Wm1p?=
 =?utf-8?B?RWp4WG5BL1NjWFFrTDFQZ3VvVFFXa0lWRUVzOFQ1QmNWSHQ3alVkcjFMb2tz?=
 =?utf-8?B?cElxZXBQaHVSVzhMaUVhQnF5Zkt0cGdtaVBMajRxYjNPMXo5Z2g2Z1VIakhq?=
 =?utf-8?B?TkljYkc3WHRqenk0WjFvWU9ueXkzRXN5Qi9XRHp2VDlRQ1pnZER3aTQ4VW9R?=
 =?utf-8?B?MzNIcThFMjlwaEJaRDlZbXVNMkM3cUNDNkxGaUNXd1VLMytnSXVPOS9KZzlW?=
 =?utf-8?B?T1ZaNmFFdk9mY1p3WjVYNnpsKzBZK0hKbnFUejJpeC9wYmNzb2M2U0xyWXFM?=
 =?utf-8?B?UG1hTWQ5VlhUdlUycDRJZ2VKVUxzN1QxUUZxdGlLTjF3ZjNBQU1QYkFwRWNj?=
 =?utf-8?B?eG5yeTBNNTNZTlNVRWI1S3k3NTk4Q21oNWVWWWxuZVpPRlZrRjQzNE1zU0tV?=
 =?utf-8?B?NXFmdnBIempkVTQ1RFlManlKZ3kwRW5FVGJ0VFluM1p0OGF4MlgzaG9EUUZy?=
 =?utf-8?B?dlViRXBody9uUXdIckE0SjRkSFExTHovTDloVDZ3clhqTmJsS2FTTEovOThu?=
 =?utf-8?Q?mwfa8bYBM9dKcOUeCp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd831cf6-4b00-4640-4f62-08df04d60eaf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 07:29:12.7987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgaiQ/wXUpLT7kuWTxjyJCpfz4G1Lj5AjTJIXWZmsX76qxmd3VaNORSEvUKBBfdA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215
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

On 8/27/26 17:48, Sunil Khatri wrote:
> amdgpu_vm_bo_lookup_mapping() expected callers to pre-shift the
> address to a page frame number before calling in, unlike its sibling
> functions amdgpu_vm_bo_map() and amdgpu_vm_bo_replace_map(), which
> accept a raw address and shift internally. This inconsistency meant
> every caller had to duplicate the same shift to make it pfn and many
> place the shift is not AMDGPU_GPU_PAGE_SHIFT but normal PAGE_SHIFT too.
> 
> Move the shift inside amdgpu_vm_bo_lookup_mapping() and update all
> callers to stop pre-shifting, so the function's calling convention
> matches its siblings.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c |  8 +++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c        |  9 +++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  1 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c            |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c           | 10 +++++-----
>  8 files changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index e129ec46441e..87ccef153073 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1809,8 +1809,6 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
>  	struct amdgpu_bo_va_mapping *mapping;
>  	int i, r;
>  
> -	addr /= AMDGPU_GPU_PAGE_SIZE;
> -
>  	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
>  	if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
>  		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 87e15e39eb30..76771ad30c41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -256,10 +256,9 @@ amdgpu_devcoredump_print_ibs(struct drm_printer *p,
>  			goto unlock;
>  
>  		for (int i = 0; i < coredump->num_ibs; i++) {
> -			u64 pfn = (coredump->ibs[i].gpu_addr &
> -				   AMDGPU_GMC_HOLE_MASK) / AMDGPU_GPU_PAGE_SIZE;
> +			u64 addr = coredump->ibs[i].gpu_addr & AMDGPU_GMC_HOLE_MASK;
>  
> -			mapping = amdgpu_vm_bo_lookup_mapping(vm, pfn);
> +			mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
>  			if (!mapping)
>  				continue;
>  
> @@ -280,8 +279,7 @@ amdgpu_devcoredump_print_ibs(struct drm_printer *p,
>  			continue;
>  
>  		va_start = coredump->ibs[i].gpu_addr & AMDGPU_GMC_HOLE_MASK;
> -		mapping = amdgpu_vm_bo_lookup_mapping(vm,
> -						      va_start / AMDGPU_GPU_PAGE_SIZE);
> +		mapping = amdgpu_vm_bo_lookup_mapping(vm, va_start);
>  		if (!mapping)
>  			goto output_ib_content;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 0a816b3c5ff9..62bf6b78a534 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -241,7 +241,6 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  	struct amdgpu_vm *vm = queue->vm;
>  	u64 start_addr;
>  	u64 end_addr;
> -	u64 start_page;
>  
>  	/* Caller must hold vm->root.bo reservation */
>  	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
> @@ -253,16 +252,14 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  	if (check_add_overflow(start_addr, expected_size - 1, &end_addr))
>  		return -EINVAL;
>  
> -	start_page = start_addr >> AMDGPU_GPU_PAGE_SHIFT;
> -
> -	va_map = amdgpu_vm_bo_lookup_mapping(vm, start_page);
> +	va_map = amdgpu_vm_bo_lookup_mapping(vm, start_addr);
>  	if (!va_map)
>  		return -EINVAL;
>  
> -	/* Lookup guarantees start_page is mapped; ensure full span is covered. */
> +	/* Lookup guarantees start_addr is mapped; ensure full span is covered. */
>  	if ((end_addr >> AMDGPU_GPU_PAGE_SHIFT) <= va_map->last) {
>  		va_map->bo_va->userq_va_mapped = true;
> -		*va_out = start_page;
> +		*va_out = start_addr;

What is va_out used for? Cause that is now an address instead of a pfn.

Apart from that it looks good to me.

Regards,
Christian.

>  		return 0;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index cee5b0241196..5b936d12c55b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -385,7 +385,7 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
>  		if (unlikely(ret))
>  			goto lock_error;
>  
> -		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr >> PAGE_SHIFT);
> +		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr);
>  		if (!mapping) {
>  			ret = -EINVAL;
>  			goto lock_error;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 88249aa89ee3..c8d1f2624b1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2165,6 +2165,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>  struct amdgpu_bo_va_mapping *amdgpu_vm_bo_lookup_mapping(struct amdgpu_vm *vm,
>  							 uint64_t addr)
>  {
> +	addr /= AMDGPU_GPU_PAGE_SIZE;
>  	return amdgpu_vm_it_iter_first(&vm->va, addr, addr);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 7f334f718cd8..46ebc002548d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -53,7 +53,7 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>  		if (unlikely(ret))
>  			goto fail_lock;
>  
> -		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr >> PAGE_SHIFT);
> +		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr);
>  		if (!wptr_mapping) {
>  			ret = -EINVAL;
>  			goto fail_lock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 69976c8be034..72fd3022b606 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -2064,7 +2064,7 @@ static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
>  		return -EINVAL;
>  	}
>  
> -	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr/AMDGPU_GPU_PAGE_SIZE);
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr);
>  	if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
>  		return -EINVAL;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 15eeaaebbbcd..ae3e7c54014a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -197,18 +197,18 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
>  			 u64 expected_size)
>  {
>  	struct amdgpu_bo_va_mapping *mapping;
> -	u64 user_addr;
> +	u64 user_pfn;
>  	u64 size;
>  
> -	user_addr = (u64)addr >> AMDGPU_GPU_PAGE_SHIFT;
>  	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
>  
> -	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, (u64)(uintptr_t)addr);
>  	if (!mapping)
>  		goto out_err;
>  
> -	if (user_addr != mapping->start ||
> -	    (size != 0 && user_addr + size - 1 != mapping->last)) {
> +	user_pfn = (u64)(uintptr_t)addr >> AMDGPU_GPU_PAGE_SHIFT;
> +	if (user_pfn != mapping->start ||
> +	    (size != 0 && user_pfn + size - 1 != mapping->last)) {
>  		pr_debug("expected size 0x%llx not equal to mapping addr 0x%llx size 0x%llx\n",
>  			expected_size, mapping->start << AMDGPU_GPU_PAGE_SHIFT,
>  			(mapping->last - mapping->start + 1) << AMDGPU_GPU_PAGE_SHIFT);

