Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC7CEBFD0A
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 07:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D79510E307;
	Mon, 13 Apr 2026 07:50:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ILlWN3n";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013038.outbound.protection.outlook.com
 [40.93.196.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD88A10E307
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 07:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwQ1mgOh8vqDdYEIA0I/9srEFrh+3YOXvUK9zcSV/tpbrvgoZIU+xTrC03Ha3Yc9oa1Nbxt6ky6RBZ5rt9LRPUdPXSC2lZBRbg+Z44nrkuqvVKPer701mUeabYGVtinfTE/Z1WfvnPvy3bHhMM+ibjPfBJtUMAoMriJWB8dzNxS5lD1BLMSJvrqUvUnt/LpbA5LH2ZH/FGFRy/M6YKC9TYUuq3bZxHA6nRAOnq9ATuKJweUUSu/VcNNjLF2L7ZWeIZ6f7fYe8Wz+dr4OcJ/tr2ZjS5C1PkbZZg0eUiij/ga5izF6JblOu8wQ6Had+ctHMVFaZEG+a5ku0us0dheHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYuNfa1HQU1gZP38XDxEkAlqfPL07L7lDdQKtRX1dxA=;
 b=oHHfzVB6+a6WTk/n+f9WAek9RFn66s4mg6nEndNflBo52HIDV/snLqp2ONTeGZ8W8kosM3LKXvMoqzR9eD4Z6ZwEdz7JDfD9AwYSVheqsVcxrNedbXjjRTdhiAzmnsR4RDPGHXcuCclVIMM6cHTKoUS/IkKak5qqFaEvBUiqcfPhkC7b3Zqy2+HvtK1AQ7F3H3oprew6TWgbAh9Iz0x9ao2QQKArZRMtPeuJHa3nfwGStybxsO7VFpjk4npd1rvMoiKlfhqyuaJSY5wEyikJp6kUs4aW/i4KrCnLhJcojLD7TIbkflUQJc1D2uE2UszoX2mGTSKcsb7zRJaFti5aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYuNfa1HQU1gZP38XDxEkAlqfPL07L7lDdQKtRX1dxA=;
 b=4ILlWN3nTuC1yqlb7bzSk1r6SD8UXekUh+cAwQ8mjcWqSIiTnoo7cL3hzCX5EHu10lUBfIe9lVtoXFVLn5rHXOg+whRrOn+JXD/7JsPy9abFwOMRo8U5F3i6Pocq5cwGGtShs48eiQ6Hvrx9+HAFrWals9X6h7aKcIVS/relLFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.35; Mon, 13 Apr
 2026 07:50:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 07:50:45 +0000
Message-ID: <f70b9814-8f02-464a-a2d9-b466f0edee47@amd.com>
Date: Mon, 13 Apr 2026 09:50:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] drm/amdgpu/userq: hold root bo lock in caller of
 input_va_validate
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260413062153.4050981-1-sunil.khatri@amd.com>
 <20260413062153.4050981-3-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260413062153.4050981-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d157b2-02b1-4123-9170-08de99315e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: tpMs08NlyiZ1cP4sEzKov8DLVQ0Sj89XlSe5XZrWjjPyKEbjNI8GirY0sD2iRrwwqHi3R0qWAgovkUT/7zQYMNhJAKmXtBeFSkEmvo9Qyz+lIzAbXz9nI++Zn2T3fML60H/+JhtjUlslE98DYzDfuDbI+7wO3bsbUhgCBJF6IO13iL8Zn+i+J+HiZC4B940o29Y6kvZ4Hr9yJ+TgeOvQ1dCqrayQuYWuWgGF2fCXjaFIvqUL5MleNIy81lyQCzwYZmmrx7ecl9ZFaieRAYYqCIAzKygaZGCj150DvXV736+/jmW2H/Hgc/6qY+fmliRS3LvXKaetbRSGNpBKJxhModG0cV4NN80UuaR0r9osGpIBS/GleH5dGlY5AJS5eeWGCCUjDEOakJIJpIrL0t/DV2y35ogjS3Badpeg/3zfY5D6XUDwArc7OQKjY6GLRkCJfMgSo6F0HT1dEbFCTxq3+rrhtI+1HvVoqClH0FEJrgCRhJjt9cgu1xT7xwjero1xWeIOQgssDCyE9yFhywff5SJt6lvU5pmeUpBzOogln6rtYZCsmWE4W4b3rOneQZoHVbNSdhDateSXEuULyL2iWz0ZL7B8UhtSc6YMQ2WInln/D7W3eL1CW9ImssW6iAa23L5sXiyBhNvE84Fdc4HM1YhYssO9mvx6a9KibF63u7f30LVS0aksoaMT55FUzLClTCSTYKlqnN+aaVszzOVW38El7E2Dhwsxw5k/Eglqt4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE83S0huOEU3SFVGV1cwZkkzMjRyVW1GN0t5bUsyaW9LdnBMZG1BcVkzZVQv?=
 =?utf-8?B?dE5CQ3YrTG1tcHAxZmtlNnc4WExudVZYWjZqMk56WEpnc3VPcGJtRm84ek1J?=
 =?utf-8?B?dVBqcXphc240c2pFWCtZaU5WSWtUUllFS2JiSDhSOHM4SEFOTjNmb2VEV1Fh?=
 =?utf-8?B?YjEyTTQxaFFWNnYxMFNEbXFtOWl4a0xLRVdlaFA3TnhRTTd4ZWhsNmFQNFdv?=
 =?utf-8?B?TEIxLzlQL2lmNnBreEZnQTNxSEdPOTJTT2N4K29oT0VOV255bUhnbWdlNG8v?=
 =?utf-8?B?eFcvcG5YRE5rbWZRQzM5NVdXMmljWmZZekQyWFB1dWhMcm80SVlONW4zYmcz?=
 =?utf-8?B?TWtFQ2pSc3B5WUl3T05UWWFpVGR5Q1BmU1JZZTBmT1oycjdqZHV2M3pVL1Vi?=
 =?utf-8?B?L0V2aktuZkZNd3hkMjZEMVJoNmx5TWxqdXNnSFpQdWFZQ3JUc2FHT3hySmN1?=
 =?utf-8?B?am1XWEZ1VEUwR0FoVDcvRVVnNWpOUXN3MllMOVc0UHUreUpYYWhlZ3JSK3ZI?=
 =?utf-8?B?dWtXY0ZGWGh5Zm1YcFlaL2lrcHRhVHkweWJPVldRQXNzdExmZ1Mzb0RvV242?=
 =?utf-8?B?UVp6YTBQQUs2VGpCUGN1QmxpaW56elh5Zm9laThPV3J4enczMVZkVnJTajJB?=
 =?utf-8?B?c3I5STRFd0tNS1lNNEJlZ2xaU1RUU0g3RWlLQis2bnF6bmFKUkpsMEQ0QXA2?=
 =?utf-8?B?MFhJS0dQMFZoSnZxcFdhb25mcldQZlV3T04yekV6YnJVaDYyZWFmRitEcjA4?=
 =?utf-8?B?LzlrM0hZNVRzeVQzYmNJYVN5NEJwZXh5bS82QWFTUms2M1F1UVR4M1R3MDZV?=
 =?utf-8?B?QjZwUDlFZGxiRm9PS2ZIbGh3U0ppT1BHRGM1a3RlTmd4NnFJdWgrd1M0V3k1?=
 =?utf-8?B?ZXJKcnJTUWhMd0YxSjRUYm8yT1BxbjVEWmRtbjR2TFRDdE4zMTB2L0k2bzFz?=
 =?utf-8?B?VStLMzRnYkJiNFNvTVBCN3k3cHN0VXZ1WGpDck8wQWEyQ01zYTdZbzhBQmxO?=
 =?utf-8?B?aTBld25kWk10MDNNejlwR1dLSmZRN0NzYVBVVWNUNVdySGIyQUFVQ0FIVkhs?=
 =?utf-8?B?MjIwR1ZBWmh1d0NoS2VBS05JMzdIdVAvZXlJY0JMdHNEY0pZcGszYTQ4bTQy?=
 =?utf-8?B?Znc5bVpsWGMySVQ5WUhaWmgzNWxiaVA1T1JaVDBjN0Z5Nkc5amFwYUQ4dldV?=
 =?utf-8?B?VnNkZFIvcFVvM1lyVVFjOGUrSlo1aU9uNTE2M0FHcUJoRm5qWEhsYzBqZTJL?=
 =?utf-8?B?dmM3aXlMb1pCVjBSY3VXekJVVm5GdWlwYzQ3dUpHWUlZcktpWjVpbVo0emhP?=
 =?utf-8?B?RmducVVuMjJUUUpWV0lRY1UraUxFQ1J4bVcwNmdrOU9TOW15YU0rWGpKZmxq?=
 =?utf-8?B?SEtKWjJsSU9BQ3A4NUNBSFp3RmdYeHNHN0pjYjk3R21NdGRIdW9WT3RwSTg1?=
 =?utf-8?B?c0lyZUtLNzRYajdTSStwT3hPcndIOGJaSngwQVE1TmVJUE5ZMkJGc1BpdnNl?=
 =?utf-8?B?VnMvL2k3Z2RBN1F5WkJTUis2c2cxY3R6ZlpVbGVpbGFocXp4VU1rSG9oQlBa?=
 =?utf-8?B?VWs1K1NpQXorS0lpUGZOdHc5R1RGWDVMNnpWOXNzamdZMm9yRWhLK3A5N2xF?=
 =?utf-8?B?Mk1BOGl6eDhEU2w0TDhLUlB6NzJLSkNpV2RHaEFkZWp4ZVc4UFN6eXp6QWln?=
 =?utf-8?B?aitwaXF1a0ppV3YzaFVLL01Ubkt1aVh3QWg0RFhzeXFWb0xmRUtxczRFL3BO?=
 =?utf-8?B?TzBXNksvb0g5ZjhqTnNSeXRiVE1DOXVNMUxta012Z0NJd1p2RG56OEJKa04v?=
 =?utf-8?B?RzE1cTlvSWg3TldrbktsODNqZ25lb0l4YmdrcWJIRzhMNlVyN2huQUt5b09t?=
 =?utf-8?B?Qi9JdkdBUXRYa2VQWFRYMHkwcmptd0dhTDg2TmIrV2cyUjBrMmZ5eUdPNDdT?=
 =?utf-8?B?bFpuemV6cWI2Q3VPVzNGWGs1bEpMejBMVnRnaEpadmlvODdad3ozOUNFenEr?=
 =?utf-8?B?WGdTMDdHY3RLVTRFbTlkbjFtMUNqc2ZFNTdrWjJ0dk02bURTalJhRVJHOURV?=
 =?utf-8?B?WFovakxYUExNcldJSkkrVmVDT1BGanBiRzg1Z2lQZGtBckRzMWlWdmRnazdC?=
 =?utf-8?B?cDBCNUVyL1cvQU14SXRPVTkwR2R5c1JrZ3Byck1ndnI1UCt2UDM2eE1MYTlt?=
 =?utf-8?B?YXp3cmRmSGJ3SGVlMnplMDRkbUpmTWgwSjBGSCtDbi9KTHQyWHVsMFR6cytL?=
 =?utf-8?B?b2pzU2pQUFJvK1hWbEtCYkdPUFl6ZlhnQ1dZYUg5YWRlaVVNYjVmdWFYSk14?=
 =?utf-8?Q?5e9jXNiDEPFiOwk4An?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d157b2-02b1-4123-9170-08de99315e3a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 07:50:44.7975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8ghr5S06DjlKDEtZHi/pzsZ4C6GbnsIEsggpjpwivQcs24UR3z1HYkRN+FQqK+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578
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

On 4/13/26 08:21, Sunil Khatri wrote:
> Caller should hold the reservation lock for root.bo in func
> amdgpu_userq_input_va_validate.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 17 +++++++++++------
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 21 +++++++++++++++++++++
>  2 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 5154949c9ba7..76badb4d4a81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -239,13 +239,12 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  	u64 size;
>  	int r = 0;
>  
> +	/* Caller must hold vm->root.bo reservation */
> +	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
> +
>  	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
>  	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
>  
> -	r = amdgpu_bo_reserve(vm->root.bo, false);
> -	if (r)
> -		return r;
> -
>  	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
>  	if (!va_map) {
>  		r = -EINVAL;
> @@ -255,13 +254,11 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  	if (user_addr >= va_map->start  &&
>  	    va_map->last - user_addr + 1 >= size) {
>  		amdgpu_userq_buffer_va_list_add(queue, va_map, user_addr);
> -		amdgpu_bo_unreserve(vm->root.bo);
>  		return 0;
>  	}
>  
>  	r = -EINVAL;
>  out_err:
> -	amdgpu_bo_unreserve(vm->root.bo);
>  	return r;
>  }
>  
> @@ -769,13 +766,20 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	db_info.doorbell_offset = args->in.doorbell_offset;
>  
>  	queue->userq_mgr = uq_mgr;
> +
>  	/* Validate the userq virtual address.*/
> +	r = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
> +	if (r)
> +		goto free_queue;
> +
>  	if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va, args->in.queue_size) ||
>  	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
>  	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
>  		r = -EINVAL;
> +		amdgpu_bo_unreserve(fpriv->vm.root.bo);
>  		goto clean_mapping;
>  	}
> +	amdgpu_bo_unreserve(fpriv->vm.root.bo);
>  
>  	/* Convert relative doorbell offset into absolute doorbell index */
>  	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
> @@ -859,6 +863,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
>  	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>  	amdgpu_bo_unreserve(fpriv->vm.root.bo);
> +free_queue:
>  	kfree(queue);
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 527cf2f14691..d12cd1b7790b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -322,8 +322,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			goto free_mqd;
>  		}
>  
> +		r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> +		if (r) {
> +			kfree(compute_mqd);
> +			goto free_mqd;
> +		}
>  		r = amdgpu_userq_input_va_validate(adev, queue, compute_mqd->eop_va,
>  						   2048);
> +		amdgpu_bo_unreserve(queue->vm->root.bo);
>  		if (r) {
>  			kfree(compute_mqd);
>  			goto free_mqd;
> @@ -365,14 +371,22 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  		userq_props->tmz_queue =
>  			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
>  
> +		r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> +		if (r) {
> +			kfree(mqd_gfx_v11);
> +			goto free_mqd;
> +		}
>  		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
>  						   shadow_info.shadow_size);
>  		if (r) {
> +			amdgpu_bo_unreserve(queue->vm->root.bo);
>  			kfree(mqd_gfx_v11);
>  			goto free_mqd;
>  		}
> +
>  		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
>  						   shadow_info.csa_size);
> +		amdgpu_bo_unreserve(queue->vm->root.bo);
>  		if (r) {
>  			kfree(mqd_gfx_v11);
>  			goto free_mqd;
> @@ -394,8 +408,15 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			r = -ENOMEM;
>  			goto free_mqd;
>  		}
> +
> +		r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> +		if (r) {
> +			kfree(mqd_sdma_v11);
> +			goto free_mqd;
> +		}
>  		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
>  						   32);
> +		amdgpu_bo_unreserve(queue->vm->root.bo);
>  		if (r) {
>  			kfree(mqd_sdma_v11);
>  			goto free_mqd;

