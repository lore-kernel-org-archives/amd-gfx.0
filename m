Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235EA606A326
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HraANQOX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9950110ECA5;
	Wed, 11 Nov 2026 13:10:49 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011035.outbound.protection.outlook.com
 [40.93.194.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D111910ECA5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 13:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAmx63ox7oXUaTUeGTxU+hE319CzwdA0efm8iGm4f0yN7Zt/cKhuxaaCShCVg0xNeIIabVKuwaG1NVTT+I9b+DK+q4kcRfcTlih2ewnqjdckOiN4ibMw/ZmP/i35Mrv0UR90suNGK7tulHPuWD+luKqFFMMy4ciWZrFopnUSR3citiWSzJFdsOsI0CIDGt2GPX0AUggtnFLjLs43ArtktaMcOluVbxIi90E55tlnz0KpW9P7FAbvyrNbgrHc+TFnFv6eZFg7Zw5+8WNpYp8GoVdZFVOq50g0eF10YD11gJ/23J16j1Dl6hAJacpRqA8Gc9EqkL0d22Je7Iqqm4fPog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llDWg9B9ksmPpVTSS71oh6jq+Ck0rywXsd/2sa/aAbo=;
 b=qSn4n3SVhesAgdlht5DXtPiEfvyLiGk6B+7sW56iG+Xz0fHqlfutW25oi74A0v+Mu8tRqUEbstcAJ//jZkPEjM1js5T+6xJBWjwCLZur8EqVCRt1R6HgOlsVliMBknDraZzjZOlkzK8ka62edNS3PL7x/1TfCo72EEJF0N1XRNxtH/N/NdXZXKNCFqeRhKh2vXqm3WtLRQcTZMjwZHRl3VVQIzknf4zqanOUD7aEJfyeaQw1lmgA0uzmnk7BNbS3zjhp1YGkiJTKQ/cb+4LkQf3F4K51aM6TM0Hx/gFWk2YOGTm1ErXDe2z+cz0PkRdRjUevilYxRelVAQOAiDOCOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llDWg9B9ksmPpVTSS71oh6jq+Ck0rywXsd/2sa/aAbo=;
 b=HraANQOX/TXysuasbPlv/ILtKjObTw0w1sdR1O0yH6MUDIAIeh676ZygrUT6CQAyxxmoRvX7ALQ7E10rhfUpVyA2YVPkBGl++EHSuQ9Ly1AWXSOINBY4UYliIBJ0UdRMF4kxwGpfrqElAKSSp1ZfAaIiyZDW6PVdJW6Fdxz+PIg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS8PR12MB899436.namprd12.prod.outlook.com (2603:10b6:8:446::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 13:10:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 13:10:40 +0000
Message-ID: <cf32555e-3d44-4754-ba08-c1205f4b568c@amd.com>
Date: Wed, 11 Nov 2026 14:10:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/6] drm/amdgpu: unwind failed page-table
 initialization
To: "Mu, Zihao" <Zihao.Mu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
 <MW3PR12MB4572B43E948F524191A58EF09E712@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <MW3PR12MB4572B43E948F524191A58EF09E712@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:208:23e::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS8PR12MB899436:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f70d87e-c2ed-4ffe-dcd5-08df3ff52f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: qzWnWHvwufLM6HRSitIlG3edIfaetrH9KSQTEtqPsdSsxqUQhZLMt0jA2sD+DyoOkRZh34Xu0HSda0HEQYJO8Mz6Lus8XmQ7HaEXDdKkorX73HCB6gmsDhi+1UziCA474JOd/rN9YNbzSOW2xWOGXqif7FDEW+3+qyNW7CbInGYzWL/Fz6VAvHrSEy0CE8ZAc0pSY6hkAaRKK053hp2/c7AeNj8LjLfAPa0O9WRwx3sTTZNLZc3QjoNNwRuVO2xvfJEoobHGHkLNhEZgBaFnlA/boUuwwqaMguCSspemEBumX0yvqqtyVpV6l5HrgPeL4L5+dQv6HSqpyfIfSaSjUUu+CpXziItd60XnZBUD9uKpGJSEh3wN8iiMCKsoD7k8P4hG91nJOoejqA0C4oeVyfdXpa9qmpIRJyU0S752lvS33f2hB6rXm4O6/po2cuVMcnSjMg55NGOVUjI6XVLVOj1VkOS/0TSkwkrUimgUfEbxLKw6xqqAI2O/b+h6s6i5sWMmG61Uh6mWMtnf6nIaKb6HmnritFjH7r/R2BijiA+3jQbwxZpT/MhhesmQ+IVdeaVaIbOmLECFQYKN3nmZUWmqF3rjEee+l5zjbcQesFsboknJJL0v0VNKEEcPChj2ge64f+br566k2L5/6Gq6CVp/tW8cCEkeDJYCjFeF5uI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEdCMzZQRDBidXFYTXFUOEJiMnVpeloxOEpsbzZZVU1tdzIrODhYQm9SK3F5?=
 =?utf-8?B?QVM2UmVNQ2JKbjV6L0JwZDBNK21IWHVPUTdOdmNtQzdIMzRCUjNWaTdXL0Rz?=
 =?utf-8?B?NWl5U21CbEtRdGFsWHVjb200eVd2K3VUVTVzRmplZm94Sk1GZlpxcDBhNldC?=
 =?utf-8?B?OFhWaFFneGQ1bGI3NTlaYWdURG5zdSswRmF5Z3dNalh4d29US05RVUE2bFlj?=
 =?utf-8?B?SHNBc3Z4WVVuYzIwdGpocmpjYUxENzliclA4K3F6T091bDRuTDYwTVVNcnEw?=
 =?utf-8?B?bHU1dnpDek9DOU44VG8zWi9BdThRMDd4eWIyQTlMMUJoNE1wWkNCWTNqREVp?=
 =?utf-8?B?NEp3cHdqY3Q5WGJZRXFCQlRTaC9HVHBPdWVYT3ZCQ1dmdXhJZ3c3OUlrUlA3?=
 =?utf-8?B?dUZ3WDZRTE4zYnRCb0JyUWE0WUtFcFoyWWhoNWprVmlYTG9qUnNIMjR4V0Zs?=
 =?utf-8?B?ZTNhajAwdmRiZDlmOFNuVVpKOE5CQWRubnlNVExHNkVnRWl0eXNmT1c3emNT?=
 =?utf-8?B?eFEvcTJmOEQxWGJXL2h5SXhBVnQvSWZ5d0JOY1N5eC9uOFpqMVZFR2tKaVVC?=
 =?utf-8?B?N1hMZ0RQMzFvc21kd3F5UzZrcDFtaWVIdFNhZEVjYWdBOWRzRVNuSFdqYUZM?=
 =?utf-8?B?ZzdieWljb0xrdmxzc2R2ZThiYzRQVm1BSUF3OFliUzZsbVIrREMzdG4yTlFQ?=
 =?utf-8?B?MkltZSs0UXdFdUM2akZxb2w5WmErTzhnWjl2aXZDUTM0QmEycTZIUVJNSGlN?=
 =?utf-8?B?Z0JqWlZrQzRaYS85TkxnbE5iMmpWdTNPTHBvVjVtcUZUbm0zOWxCbEo5d3FY?=
 =?utf-8?B?VFBUVFZGb1hQWDZEd053N1pIcDJuM1VncEJLbzRsQnVJVHRkNHZnK2NRbXMx?=
 =?utf-8?B?WDhxbEJERnZxdnRNa0QrR3k3VlpQZSt5c0RkdUhsTkExWnhFR3NjVjFzd3p2?=
 =?utf-8?B?SFpMdXEzWkN5QWcwUi8vbmlqZW03Q3NKQ1g2emE0bFdWbzhNbTQ5RFdiSnRm?=
 =?utf-8?B?RVhuMC9UdEZrSEdhbVhTdWU0eEVtZXZNZEVhQjdVZ2RkZU9jYnFoNmh0aHJL?=
 =?utf-8?B?b3UybVBROVQrZ25PVXJUcmdiQ1UxK1A0VEs4NkhNYUNPVWdCVElZRFBmNm5I?=
 =?utf-8?B?T1JxVURtL2R2MFhFTi9tdjlYVTdTMWt2Q2V6TTlqbVBNbCtNZU16OFZlVHdj?=
 =?utf-8?B?MUt2MElMMytuWldHdVNPZFhDdkNLcnV6OTZkOWVEYjJBbm5XWTJHM0FWZXRD?=
 =?utf-8?B?QmVseFQ2anhacGp0LzhUcWRVanZuZHIySEVxUjNiNnJhb0ZrSWFuRXV2OGhY?=
 =?utf-8?B?WE9vbEladUtwWXFkaFltVHBwdWNiZ2ZQcyt3WUJ4S2psWU1jRE1iclhUM29z?=
 =?utf-8?B?TDVsWnc5ZTNlQXpoeDlNQzNkY0ZtcXJwMmcyQlNkQWxUczZSZnJUaXRFZzAw?=
 =?utf-8?B?QlIybldKcU1vU1FTS2VROTNuaUNhbkNhbWExR0xuL0RwRk5MZUtabkZUTDdD?=
 =?utf-8?B?cXdpOWgrQmI0MlFoUldrcHZYbTR3QjZqdHNGUHd2eGlLZndtb2hoRFRrdWRo?=
 =?utf-8?B?azZhZEhiOHBZcTJwMGQ1elkyNlFwUTNSUExBRzFCeVRqU2xaVmgzS2tiVFZx?=
 =?utf-8?B?S2dhODB2cFZBVkszL3p2eXFnQVVZWkxUbkM0ei9VY3Fod01pZ0s0djd0NWUz?=
 =?utf-8?B?d0t6YlpSekdoTFBjYTJDb3I0WGpFLzdOM1BDR0RHVkhZSk1qZnNQT3pERlk5?=
 =?utf-8?B?STE2Q0lUTkFjOXRJTHN4S0k4bmxSUlVkREZmYzdwcytQbHF4OHNEZE1VdWFz?=
 =?utf-8?B?UFI1bjRaMmQxejhNMHUxVWh4dXR5ZXp1WjQ2NU50bElZMlMwMHhEUURsZUpZ?=
 =?utf-8?B?a3NXRzNQdCszTE9DMHFnMXliNVZoQm1ac3R6bTl3MWNXOEVYT3RqUWorcVZT?=
 =?utf-8?B?d2FUamFyWXVJR3hMRGhuckR5cDhmMWZGOE9hSzI2K0NmSGtWU2xRLzFMYytQ?=
 =?utf-8?B?dUVXcDc0L05nVkw2bHNKbG8xbzI1eUdFd3U2eXJ3WDZuREpnVmJLZzJTSDIw?=
 =?utf-8?B?RWcxNWZqU3E2blJRSVlQTnNpbjBodUlRL0JpY012cnRsa1NvTzlrdWdYYURU?=
 =?utf-8?B?aDNpUW1NRE9paEtOb2V0aHU5K09DN0lFSGhWWEdBY3Jrbmk5Uk1YcVF0RkZN?=
 =?utf-8?B?dDdVRVRKQ2d1ZUs2cFpHZlBLOTUzcXBQQlFLSU5aM0FnM2lDVkgrQkZUR1F4?=
 =?utf-8?B?YU40QkVtMjJjaERxUGpzaUU5SjdJbDlnMUtER214OWhheUQxRGh3Y0pma29Y?=
 =?utf-8?Q?Qg6IyQCEgW/15zZmGY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f70d87e-c2ed-4ffe-dcd5-08df3ff52f08
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:10:40.0915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0T2oncg8pA+g4TH+O0akyqXux/SxDKGBU00Pk+QIFeR4O8FIedWQ1VPgIJpF8OG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS8PR12MB899436
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 12:55, Mu, Zihao wrote:
> From: Zihao Mu <zmu@amd.com>
> 
> A new table is linked to the VM before it is cleared. If clearing fails,
> the allocation path only unpins and drops the BO reference, leaving the
> entry, VM status list and accounting referring to that BO.
> 
> Unwind the initialized entry through amdgpu_vm_pt_free() instead. Finish
> any partial SDMA clear before returning its original error, so no current
> job is abandoned. The tracked completion and reservation fences retain
> the submitted work while TTM handles the BO release.
> 
> Keep this initialization-error fix separate from the update-phase
> boundary changes. PDE iteration and its error policy are not changed.

James already stumbled over that problem and the patch to fix that is already reviewed and should show up in amd-staging-drm-next soon.

Regards,
Christian.

> 
> Signed-off-by: Zihao Mu <zmu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 9955be111ce..bdd06b7718c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -372,7 +372,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	struct amdgpu_bo *bo = &vmbo->bo;
>  	uint64_t value = 0, flags = 0;
>  	uint64_t addr;
> -	int r, idx;
> +	int r, commit_r, idx;
>  
>  	/* Figure out our place in the hierarchy */
>  	if (ancestor->parent) {
> @@ -426,10 +426,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
>  				     value, flags);
> -	if (r)
> -		goto exit;
> -
> -	r = vm->update_funcs->commit(&params, &vm->last_update);
> +	commit_r = vm->update_funcs->commit(&params, &vm->last_update);
> +	if (!r)
> +		r = commit_r;
>  exit:
>  	if (last_update && params.last_update)
>  		swap(*last_update, params.last_update);
> @@ -507,6 +506,8 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	return 0;
>  }
>  
> +static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry);
> +
>  /**
>   * amdgpu_vm_pt_alloc - Allocate a specific page table
>   *
> @@ -550,8 +551,10 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
>  	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
>  	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate,
>  			       &p->last_update);
> -	if (r)
> -		goto error_unpin;
> +	if (r) {
> +		amdgpu_vm_pt_free(entry);
> +		return r;
> +	}
>  
>  	return 0;
>  

