Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9145CCD37BE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 13:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2281E10E714;
	Mon, 11 May 2026 13:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XTVC3jGN";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011066.outbound.protection.outlook.com
 [40.93.194.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF03A10E717
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 13:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAoi1GCIfO9MiHvrEHsD9wScKRTRTxsL1l7D4bBkGFdm54+XdySndZaRUaZ+NTRuRFF8v974RfyPDb/FecBy73qzgkrW0DZ5FmbL/F9pFxa23ReydHukTPUAGrGRP+869DrgbhzV3uw80WFTKsqOP4v2HaagZzlqR0KWLqpZL/qkvLuTH9JDGlpkpUihv/lQy9/zjkFh4+26dP/HP4QDpewq9zemJwKQZ5LBea+k1KNiHrhX6DkrgmR4HRqiZEF+5ihpRYbmT6+BRWqjlYh2vne8WsmPBnqBYLyA4ibNT3iL6wQ/P8ajQ6vsR58z3Ym4LY0HDiM04QvCAAJwWAS8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xq+1CTepVM1oWpO5vESeRsT5mm0LB2frN1ZDYodBuK8=;
 b=PbBk/ojsEG7bFSiEQc4TbCJyLY2WILbiE9pQ01CLDUBHsCC3B8JSSEJIw61vrOUgFmR9EREXNe3M49WxfXvvYavlBKk55xcEvmWBhleIzDMkigyg2YaoMBaqkfpQAwcU5OMhcpvZpVn1/m/0Ya09sQLDyn64N2qc4rnD2sa+vJtmsilX+ztS5sgFPe4EENcNhFX79OkQQFpldOFeN8rTnB9/q3iDezJwS2PUdhzKHs9QwkN8KASN1KGmDHbIUvP0vQKhavUV2W68PwZt6pJBJ87daBGW3GmP3Qs0muS/Mp0MoOPa4cniKtM9PXIhjcKwbgyzrcEhuda6Hurm7PUrfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq+1CTepVM1oWpO5vESeRsT5mm0LB2frN1ZDYodBuK8=;
 b=XTVC3jGNIY6OVoSNs+JQjq6usAEJt1fqEp3S84JT5gDhgOfBOLKN/iSVH3u+x5AXkWJ+r7eHThS96wdiz8S0Apj7fEj56fB0khby7WEyLV1Y7LqOcbZdBnq27KKpj7DesWCdmK4srYZ0+Wneq36FNpaTCC91sat5ZVdjIhSS5qI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Mon, 11 May
 2026 13:22:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 13:22:36 +0000
Message-ID: <7922720c-4036-474d-805e-04bca3e9cd7a@amd.com>
Date: Mon, 11 May 2026 15:22:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu/userq: use drm_exec in
 amdgpu_userq_fence_read_wptr
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260508103910.2442183-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260508103910.2442183-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0722.namprd03.prod.outlook.com
 (2603:10b6:408:110::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: e9089a81-5edf-4ed7-36ff-08deaf605daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|11063799003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: +18muiWp/pXXqLCl6EL3CIkekTxwUistoL1hmOOyt6jtRPQQfNqRmXhCCDUpEf2LecI31N2kK7saGXazofSWHKZm9omOJjZIkNvLoZHcXe2Yws/MFoDUPszNF0IpuFaZgStvbt51DCRkfqA4yCogEOHd0QfSlht1auD1XhFq7YSpDyPrdctR92A2v1R2WAFxc9R43jBsRRcPaSW+D1TYiiXBX95m1NKrSJfJUM8keeElvoZ8OO5gsow5BqS4YxlrhaPWJSVGo+CNTANNzJ2b4Q1hIsjrZQglOyEAeqbzO1g9cky4ADtgDwJSOld5S4IMBunajwYb2rlxRRQBhf4+xfm1wSUQxAm7KjBcAuGH08Om1Q8adfsFXAzJr/DxiTFGJ9dckNgbDBk8KmJ3KYMtiXxUqirKpQzmj5TRntzfQzZ9vk9faUCwqN7ZnZ13LAGGNYh1IrvngOCi1lJ1aso1kpY/SQcVN1M17zx4MY0UsYnyExFTWjPa3VRiHz0oHWJz6rIQ5Enc9FtLxplrW0o8DuUgJSAFeCpkdHREF/x/wPB6y/anCAHhiU8tRAfF1IMnuLsTCzVM4GHR3fbq/6N2RwsZskGmhVj1yEuSwONOOeTzKRmn/ZPGT6Md+3LfNOVahrF6D3V6GwSNSBmGk97i72tPClvYAw0SMA4qtKZUlgUDknDmews8IiajLm/M9l2V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(11063799003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEhxeDgveUdiaWxqV21DeUFGNjdNbUVVaTM1RUdMdEQvalo1eW5FK2JxTWFx?=
 =?utf-8?B?bXR4cjdwYW1LMnNQOXZFNVp2ZGZpa1BMaUZRRXk1L0w1SklMY0VlNUlhSnRt?=
 =?utf-8?B?aVY5T0xUSHJSbXhreml5THViSm9EZHprUDcvRDJXSjFGOURJang3Sy9vNFN3?=
 =?utf-8?B?S2pHR2tPT3NtUEQvN0pvM2ZzUzd4a0paRW5IR2VldHNnaGNva1A1c1JBZDRB?=
 =?utf-8?B?OEY0ZDJ2bUF0NUUrZVdPd0d5emZBZU9ZQnRXdSsza0g1UzEvMVpNK3dCTmJj?=
 =?utf-8?B?aEFXa1gzUGdBdjNBWngwRzlkRW9ybmRRKzh5dEo3eC8zbE9EdHZkYXlHYWZN?=
 =?utf-8?B?SVQ3bGx4WWFQWHBPSlU2am1Ma0J5RHdEb3lodlNac1JSTzhiU0dkYnZXRjE4?=
 =?utf-8?B?R2M1SE9YanZPczVKby9acU43cmdQUnlMS1dSUDhleHA5VUVmMHR5NE04OHUy?=
 =?utf-8?B?bWtDUFEvREhPK1FLYXI1YkVBcVpYNU5MNFRsOXJhbTZDU1JSeFEvVnBwSXFL?=
 =?utf-8?B?NzNwcDhIZHNoeVd4VUNvd3RCWUNkaGx0ZTgxYnBiR2htdVd1Mkxnb3p5bzlh?=
 =?utf-8?B?WllTaC9XK3lLS1hrVVFNMHlmVUxyRHRpMy92VFkwSHpvSUhKaE9BaUgrUVl3?=
 =?utf-8?B?bEtSYy9RbzNCTHJMZy9SSlBqVGduSG9UQWlXQTRXemRDR1pRaEJaOFBQVGFQ?=
 =?utf-8?B?Mnc5c1J6ZmtHUEljdlVFbHU2dFN3VHd4MXovcnVxOTQ4Mjlwb2FyR2hXVDBX?=
 =?utf-8?B?ZXBCWGgwM0JWNVlXOUU5WXp5QmNiekdPaEltSklxUWk1LzczVmR5M2VsRHBw?=
 =?utf-8?B?WmVWdis0VkFMZ3M3VkdaNFpxMTlsQk85RmZRYktpSmF2bTRRQzNNTVV4VW9p?=
 =?utf-8?B?UmVYRXVWOXprS3JYT0JudnpzSFEzV2tucDcvZDhSVElUZG8yN0VtaG1QMTRl?=
 =?utf-8?B?a1Y5b3Mwd3JvVCttVi9HVFkrb2wyVUM2bktyZVYyVVVxSnVCeFRkRzljM3dz?=
 =?utf-8?B?MWhVdGZFb3pERTR6UTJ5RDlvbE9KRzhhVVRVcXE5My9pMVB2YnJFRnBQM2pw?=
 =?utf-8?B?TXljQmFiZFRSeXZ0ditIKzBqZlhJbVh6THBRamdnSmZ2ZkRicXVBdWVEVSt4?=
 =?utf-8?B?N1lick4ydFgvYWN0LzFCaUNuQmQwanFaTmZKK1hHUFl5YXlYcWQ2Ymp1UFFs?=
 =?utf-8?B?RXM2R0tvdE9Ybm1zaVVRbnEyN1pONERWOHFQU3QwU1VmQ3l1SzBFVVRVd2Vq?=
 =?utf-8?B?amxQbTZnSTJiYmloYjlPTld6NWM5MENhQkZVUUlQRXc5Ym5HOWRSM2FEYUpQ?=
 =?utf-8?B?a3NsemJTSTVvMCtjbkV2MUxwQTd0MDFYLytLNmpIUlpoUFZkNVBoMWFCMU5S?=
 =?utf-8?B?VFQ2SXRMTVc4QzFtTjNCQmFOUDgxTUt5YWJoMXZOZ2tlbVhpbUp6N1FxOEQw?=
 =?utf-8?B?dVkrck95bnFIZW1tY2JYRnJRR3RCRVpDMzVFa3RHT2FhL2V5ZTBFVm0xZzlL?=
 =?utf-8?B?dUNjSGtkTW5uU0wxWEVzWHZHNis1aVVJeUF4VHRCZ2hpeHBBd3AraWNMZlox?=
 =?utf-8?B?bzZkMTUxVXU2Y0kyY0RhclBxK1F3VkI5ajRvdmpxcS91NkswOTQ1ZFpJM3lO?=
 =?utf-8?B?NWZaMVNpa1JObVNyNVdOTnhQRUdKOEVJOTlnaHBvU1lOVVplcUh1SmpFdERH?=
 =?utf-8?B?SFdCR2lwbU1idVFvaVlSeERKblEvUkdubjR6c29QWFVCNnUvOG0xcVZ0UU5k?=
 =?utf-8?B?aHhrSkRFRjZtN0ordU0zMGxqY1IxQ2N2VmExakpNZzFSY0h4eEVabVljZnFY?=
 =?utf-8?B?S2dvWEx1RHJPRm0ybHQyZjdvbURiUFA5WEJVcSt5ckpSRlNJb2UxSHVKVW9F?=
 =?utf-8?B?bDhzdjlYa0M3UmhGTTR4ZnNoTEJuMUdDU0JSODBld0dJNEw3SndObDFHSGk1?=
 =?utf-8?B?ZS9JZVNlK3VJb3N3eTkxTmY4RGIwOVlTaEZPOStQVnlrZUpQVDNucDZ0NzR5?=
 =?utf-8?B?VldUWWNDMTZEcWVjL0E0bWlpRDBMQm1qa0t4ZjZQQ3BjdTFXaHAwbDBxd09p?=
 =?utf-8?B?RG1OT0JCeDlLYUhIUFBkSGp1K281NGpsVFBLbEw2RGttNS8reUd1enNaM1F4?=
 =?utf-8?B?ajAwYlpRR0h6SnYxTFA1dmVTT25IdkpkV1dwaUdPNjBHcS96SFJyUE1hR0lR?=
 =?utf-8?B?T29IN29NRXZSOTdqMVpZYzFyUm82ejFkaVZtVE9OeTV3T3Q2dk9oSVMyVzhj?=
 =?utf-8?B?c3pSMko0TTdRYm9WQkQzWDBCSlpEYkZkbzZ1WTZ1dDdhTTFiVDVVMGpvd3Ew?=
 =?utf-8?Q?ElLD1Sz26tFUonp/1B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9089a81-5edf-4ed7-36ff-08deaf605daa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:22:36.0465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3jpLrFV6V7TJ1rompq9jI/JyR1y/j731ng8Ysjgc9ZoiZQtiHMKlrcSjTy0rUvs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774
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

On 5/8/26 12:39, Sunil Khatri wrote:
> To access the bo from vm mapping first lock the root bo and
> then the object bo of the mapping to make sure both locks
> are taken safely.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 55 +++++++++----------
>  1 file changed, 26 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 369914cab555..008330a0d852 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -370,51 +370,48 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
>  {
>  	struct amdgpu_bo_va_mapping *mapping;
>  	struct amdgpu_bo *bo;
> +	struct drm_exec exec;
>  	u64 addr, *ptr;
> -	int r;
> -
> -	r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> -	if (r)
> -		return r;
> +	int ret;
>  
>  	addr = queue->userq_prop->wptr_gpu_addr;
>  	addr &= AMDGPU_GMC_HOLE_MASK;
>  
> -	mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr >> PAGE_SHIFT);
> -	if (!mapping) {
> -		amdgpu_bo_unreserve(queue->vm->root.bo);
> -		DRM_ERROR("Failed to lookup amdgpu_bo_va_mapping\n");
> -		return -EINVAL;
> -	}
> +	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
> +	drm_exec_until_all_locked(&exec) {
> +		ret = amdgpu_vm_lock_pd(queue->vm, &exec, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret))
> +			goto lock_error;
>  
> -	bo = amdgpu_bo_ref(mapping->bo_va->base.bo);
> -	amdgpu_bo_unreserve(queue->vm->root.bo);
> -	r = amdgpu_bo_reserve(bo, true);
> -	if (r) {
> -		amdgpu_bo_unref(&bo);
> -		DRM_ERROR("Failed to reserve userqueue wptr bo");
> -		return r;
> +		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr >> PAGE_SHIFT);
> +		if (!mapping) {
> +			ret = -EINVAL;
> +			goto lock_error;
> +		}
> +
> +		ret = drm_exec_lock_obj(&exec, &mapping->bo_va->base.bo->tbo.base);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret))
> +			goto lock_error;
>  	}
>  
> -	r = amdgpu_bo_kmap(bo, (void **)&ptr);
> -	if (r) {
> +	bo = mapping->bo_va->base.bo;
> +	ret = amdgpu_bo_kmap(bo, (void **)&ptr);
> +	if (ret) {
>  		DRM_ERROR("Failed mapping the userqueue wptr bo");
> -		goto map_error;
> +		goto lock_error;
>  	}
>  
>  	*wptr = le64_to_cpu(*ptr);
>  
>  	amdgpu_bo_kunmap(bo);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> -
> +	drm_exec_fini(&exec);
>  	return 0;
>  
> -map_error:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> -
> -	return r;
> +lock_error:
> +	drm_exec_fini(&exec);
> +	return ret;
>  }
>  
>  static void

