Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4ADCD3447
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 10:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E86610F409;
	Fri,  8 May 2026 10:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tm4A8y/S";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010065.outbound.protection.outlook.com
 [52.101.193.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D982B10F42D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 10:07:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyyk5e8XrZylrD043HAecwuGIrC+Mu6S6FHsn9BE69A2lButVRQnWAKppkI90U2U+2Z+G33JctCcHNiZOSRWXkn9RCGra29FHBwKrbEkae8vrgTMSUR6yTNhcB+1CQU62WQBJfW+msuAJ5LdSNp+j9VNRsvQnYi/LX9stSwHvQJxyjRrblEHg+gzf6fWkBI6G0JTqOONoCUW325/2JZ1aySRra3mGlIYndmHERI295kd7UC1mzF9z3hqjnLAQ0T/mAnmgwCZenrOV1J9akB1uy7bPulMWbxxzgbwmeJX07AhVktHCQXazgsCDoiOYsJoRWnc5Hc6oThDqr4cwWT7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJefvtfbb3OL9rVJcQmYbGGer51QIbCm4VrC8dtJX6Q=;
 b=ZOC2y221Iwo+kJmDSDXHGUzFgcKY47yQpiIufBkRID0QBGXQ+FEnwCIXsxQUoZtJfTQQQzya6P8VfkFydoJnTx4o/aVdKaIJ/GC6LVIaoQTKGQWBjEgB1NmiRR2ekOLl7z+h8ZfawRBNVs6SAtsW+wAz360oaNwW6Mm4uPOV0BMSaw5CUPJp85rM884cAkBpOrGWpgx9E0Ip7GWW14ld808KjDRyUzGt2E0yRlq8qF/nENlTBxW6rwbb+ZGIGIu/pR2bsraqEuvtg47+H6iDYzSs2NzmgSX1f6NoX13F8pIxiUVT870v9l7bL8bXCrNdLbfjUt2t1xgrRp2gxZakEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJefvtfbb3OL9rVJcQmYbGGer51QIbCm4VrC8dtJX6Q=;
 b=tm4A8y/Ss209RQknacJsNToxbW0/L6C1CX0957XQUgPAdCzqXqj8vgp0s7juh0ZLBJc2xPEHbAdgONtvI5/8URki/HrQc804lFbPgh3012B+rRqB4fOyYhx5rdQNRwVm5+ljdRNFsJPMvl1jAFCtrntTsHv7CdZTzOx4Fb5xpsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 10:07:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Fri, 8 May 2026
 10:07:04 +0000
Message-ID: <7e243c1e-2d2a-4f92-8f03-cbff97b43f74@amd.com>
Date: Fri, 8 May 2026 12:06:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: use drm_exec in
 amdgpu_userq_fence_read_wptr
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260508070150.1504484-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260508070150.1504484-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0286.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d7ed8e-40f3-4074-366e-08deace98d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: X9qq3udxE97VyxDRM+AnknRDtEs8bfeSDKo4+inDn7fjrQTeDWfyCphhH9d3oNP9PwWICGJ4lSxcJop483wte1L+HEgHjdMtvyXPnPbDBZiv9Ag+0K2bOUXAlCY7kZIN4T4v3JcY+fV1tiUPGgDprm8XP7fF6XzECwsY7lPIiIIlV4HDGqRsfSdFquDq7vIgHODwf7e1aOosvuCYqyyuxknKhaiKeXWnyxRfFX3EK0XZRpnNtflokEr6MV9MXpNpXs8Zqx3TN4trk9oKJLLNFRD8c1/3PGNRtqR0zsFCNn8EMEQK67eywZ8YsVdVAsKvVCK54q18GyH6XN0+ZQXTw91uYETOhoAJNI58YVH1eNi7QYW0H9mEyL0BlwTcV14mZO3jrrPPyMouk5E7qp0tkRRSOefCa30j643rweL4/fxzIenYp/ZFUIPBYChdTp/mfWPLfvpAWj/+zeB6WxpcOuWm2j3Ez7OAkwUAy8BhwEOFgSTRXcMJ0zdkUBlf/wZ9AX+p6S2Yl1DK7k63bAn7KFFJRck4oAro4uOGT4NJ5pyz54hTxYwg+RqH0TWmsvImNipVNMxV9fbPs9KPDbDNuL1tsKLC2TW5Fw3uW+z+CS8D8Tx7Nb3PepYXRqcVu8PPKf2qtpsMhkYLecK6zHDnTfsIybuUCOB5LQDh6U+Iu4b+srAVwAx44y8KsrlGE+TW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THpZTmRwY0NmdHhuSUQyVm11ZGZlUE83dVdpSlludmM2WHZVUzA5dHg4dG5n?=
 =?utf-8?B?aVRpWUxScytpSjdaclNESDZ5VnEyNDJXVlZpRjNxT2RHeE1OWHdybS96ZEs3?=
 =?utf-8?B?TWxWOHNCdFRQTnB5RU10VHQ0MlN6Z1FDUFNxM0kzbElvRDcyd05Rd1E0M3Ri?=
 =?utf-8?B?VjhVVU9odTFWTlUvRW5BcUVHcVAvTDJ2VmxqQ2tGNFQzd09ycEJLNmlseUJ1?=
 =?utf-8?B?alQ0MTZwTkJTYllsb29yVTA2aEFTSU1kTmZCRjQyWnBOaWZVN05KL3QrM1dn?=
 =?utf-8?B?WHJlWjRJOTM2Z0FWZXJkNkhsQ0RkbmtKMU5NOGZONG42YXpiUmJaamVFd2o5?=
 =?utf-8?B?WmFEbnA2VnIzZUtjdFRYNWMvMjVvc2gyb2lMV2c1M2svQXluMVRvSVQvZktP?=
 =?utf-8?B?dTBwbTlLZXZxUkRvakdDdW51eDYyUUVwWGpuOGgrVVRZNmVFNmZaT1pBSXVH?=
 =?utf-8?B?NWhmWFpRcXUyS2hnM21PL1NZaFh5NkdqZktqRnVnMVp0blltUU03REwwS09Z?=
 =?utf-8?B?bVd2TkY4NFhPSXJPV0pVSCtXb3ZoM3ZzSnNWejdCcnFJM2xFUmZTb3JDaFEy?=
 =?utf-8?B?UHBqZnRzZFNWR21FTDl0M1lvU0VjcG96dHNLRE5vSXNYUG5HV2p2Q2VPcFFo?=
 =?utf-8?B?ekJBbnRlcDNnR2oyeFc3cnlsNTJ6WUczSmxESEFCQWRGZHhNdVFzNCs2b2JT?=
 =?utf-8?B?TThrTGhoc25JM2huNGQ5eW5yeUtueDZuUUdDNkF3V1BjQUtyVjl6SzZLbmhL?=
 =?utf-8?B?UGp5TnZVNGRMeW1HdlI2SWhNbzdVTnZsdHdKc1VsN3p1MGlwTUpVN1l6TDNt?=
 =?utf-8?B?T2ZqcVh4V0xvOFV1enNaVVBWc3d1d3NHS3N0c0JaWU5oaFBFVFREaTk2WXJH?=
 =?utf-8?B?NmtGTHpEamQ0UVI1Tlh2Z1JWdTNkckM5aEIrOVZSRUlXbVgrWWZ3MDhmM2JC?=
 =?utf-8?B?Sm96Uk43OHNKa1hRUXNIRndmWm1DdG1KRDlPM3JNWURxRy9obWdmZ21reCtT?=
 =?utf-8?B?alNWckduU01XRzJ3Szh1UERvRk1UMnMyMHV1SlJiRWVqd1BUUEV3UDdWM29T?=
 =?utf-8?B?RDNtUnU2aEJFTmd4OEpyOEhkckhrVG1uNURZdllLWW5HVEVqKzRKR3VpMGdY?=
 =?utf-8?B?RnFzV3ZNVERUS3hkTEFqYmFNUTRLMnA5VEdIVTcyTDJ5QWJmcW1KTXYyY3hx?=
 =?utf-8?B?clhXK0ZGcjhJU2ZqRkk3Z09hZWxUaFFUTjVoZVExWGlCbVlXanp1cXJNeFVj?=
 =?utf-8?B?Sk5DdEwzOFRhcUhJekRWdURxMWlXOXJsUFg2NHJhM0RtUGlNeFBvZzE3YzYv?=
 =?utf-8?B?L0w5dXRUckp3cCtyUGxNNmlESnlsM1J0VHhoYStnTHAzNFJybnlyaGc1UStk?=
 =?utf-8?B?Y3FlZnRDSmNEb0kvNVRMdkU2TGZnV3FNZ2p6a2ZJY2tqRjlBY1ZJdDhERmZB?=
 =?utf-8?B?bjRpdnRHS3hzdWFacE0rWWhtYktqeWUxTmxFc1ZrUHFWTWtwakw4bEJiblRB?=
 =?utf-8?B?cjJoWDdoNk5Ia0cybkNBNHV5cE9rMEFNaTlYNjlaVjNLY0VFODZ0RzlLSjgx?=
 =?utf-8?B?clZ0TG4wZGp2N1dFMGREeWxtQisrNEVGQnppLy92eUtCVk4xejhKRjhuNXVv?=
 =?utf-8?B?QUdtL1NGejNNOWZ2SUliZkdjVWNLWThDcWJhL0tsWmJDR1VpN3JwaWlrWll4?=
 =?utf-8?B?WXlxM0hnc29JWXdHbTcxSHoyajdRSTJBdGZTekpIdXFpWWlzRmlRZHJLbmJw?=
 =?utf-8?B?dENrVjBUQlo3blRuK01KdUNEdTRkZEhEQ1hTblhhN09NQmd3OWVNWCtxSFRa?=
 =?utf-8?B?SzNyNE1CUXpCQ3hONXJ5R2xhSHIzdW45SGpqMEw4czhhRGxnZi9WOEpQd2Z3?=
 =?utf-8?B?cXdGTThxQURsbjBHZEZvejMvd3VRYXZJdHBHZURxU25WSUxtQ3VJVzZGdG85?=
 =?utf-8?B?ZTN2TDEyU0RqY1lCYUlxSFYvYStjQlk3OFY2YUt6QVFIVnN3MWRQTlVmL3ZF?=
 =?utf-8?B?SU5KcElYVjFENHZSNWZJYVBVaFNmcGI0MEpIVEJ2UXZ0blRmdFUyTG5QbGZW?=
 =?utf-8?B?K3JYMFNLVmRZMURueG13STZpS0dyYlYvOS9Rb2N1TjdLRGFGMnZxc3IzVzU2?=
 =?utf-8?B?c1cvUnp1SUNhRnZrRzBSZ3NNb3NNa09CTUowWUYvd3VNK2NEWmN4NjJlNS9F?=
 =?utf-8?B?SS9ZZzY2RlcxWmpvdE15cVc3Nk5pVGtLVEJRVGk1SXphb29vQ1orNDc3a0hQ?=
 =?utf-8?B?K3lUTjhmTGM5OUsxMEhFbmVaVWZPOEx1MXplNXJPYyt1aEpxbW93UktmUDFS?=
 =?utf-8?Q?dmSETfVhq46juphC3k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d7ed8e-40f3-4074-366e-08deace98d9b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 10:07:03.9461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XXVI6wnVlgEL28r/4ODCNmqMluNtcQ84XL+5pcsougYn44Unpjuoa9wZ9eyyY6E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770
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

On 5/8/26 09:01, Sunil Khatri wrote:
> To access the bo from vm mapping first lock the root bo and
> then the object bo of the mapping to make sure both locks
> are taken safely.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 50 +++++++++----------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 35ced3c26c8c..e5522e953edc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -370,34 +370,35 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
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
> +	bo = amdgpu_bo_ref(mapping->bo_va->base.bo);

As far as I can see we don't need that reference any more since drm_exec always keeps a reference to all the buffers it has locked.

Apart from that looks good to me,
Christian.

> +	ret = amdgpu_bo_kmap(bo, (void **)&ptr);
> +	if (ret) {
>  		DRM_ERROR("Failed mapping the userqueue wptr bo");
>  		goto map_error;
>  	}
> @@ -405,16 +406,15 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
>  	*wptr = le64_to_cpu(*ptr);
>  
>  	amdgpu_bo_kunmap(bo);
> -	amdgpu_bo_unreserve(bo);
>  	amdgpu_bo_unref(&bo);
> -
> +	drm_exec_fini(&exec);
>  	return 0;
>  
>  map_error:
> -	amdgpu_bo_unreserve(bo);
>  	amdgpu_bo_unref(&bo);
> -
> -	return r;
> +lock_error:
> +	drm_exec_fini(&exec);
> +	return ret;
>  }
>  
>  static void

