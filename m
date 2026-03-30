Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C69FF494F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 12:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F43910E1FD;
	Mon, 30 Mar 2026 12:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VqMIFy/u";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013049.outbound.protection.outlook.com
 [40.93.196.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 928FA10E1FD
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 12:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1cJUp48aZc+sVlFMXUnZrT2Wce0GXhp8Ge5hoM3PhGwLxyczEqsqVK/G5s3J6mM5IfTgW23IPKL8CzkTHwHIt91fvF2xIsYrL/l8dbyvbg2OukTV7Wu55u65nTtH1C4dj4k1qRHUyMbMc5PhpZIM+qR8hEXiqRxzY7LFDUTeHDrtTTuSsY2cHHcjmeYIwC+8mQtaXJ8uqIXj7DwSosw2g/IWAFhFJdojRBztnaUkBuHjVCZQpJgPTZt4ixlOsKaYmPSfsqUbY9F7FAwrmkQ8mlYd/PYk6j57FDw7tcGEdRD38CudaWzS4hcsiYOVe5jvCqkQqAWS/Qpkhgg8lJlyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSLj5dJ1RIppQuctwztATXCiGqJnPtHfdOnvyE90hDk=;
 b=Jfa65oJu54aFJSsXt+XeGB4KyXLxZbyNfOxEchTCPGWYCIKKrWCDjnvZD3HrFwOBiu4g6D9j05Tcd2XR65EEzmtpMnh2L6n4T0v/VxbOXYnZWz/M/y7p4Hep5L7LPQU2CLAd3yJ2QQv7LiCdkKbIhwqyJKYjOMGyndswkDNklJ21oaSSWquDSfdhcPsnppwVwbm9TR2R8MtKDAPsiEhA8K+c+wFY5+btGJVul45yld5wDwWVG+5A/6VeY2wObHn1DAbxDto3UQLg4Rs1kYgZXskWzIhcoVxAXFQTD+p7/d8prBsfnofZp1fMFicGwGHtgal1BGYXvg2FygoZXLyxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSLj5dJ1RIppQuctwztATXCiGqJnPtHfdOnvyE90hDk=;
 b=VqMIFy/uhqJr2rbSPeBYYLkVGUX9lZYincakrFTmheNbgTFHqnP0WS4XC+LB6V0VTglTmi7i8QEtwA9s9xRvuHJtr9PbDxjsaDKPXiLcTy93fJ74xlh7c7NcJzIkaAehQ2vIkhMALAqv+ETsTovX/wu6/6WRtBnwBUfwoon2hfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 12:45:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 12:45:32 +0000
Message-ID: <9bfdbd5e-302c-48da-bd2b-84c7e0c3ed32@amd.com>
Date: Mon, 30 Mar 2026 14:45:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 3/3] drm/amdgpu/userq: dont check and call
 dma_resv_wait_timeout
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260326132353.2753833-1-sunil.khatri@amd.com>
 <20260326132353.2753833-4-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260326132353.2753833-4-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f061f4-f646-44e3-fa82-08de8e5a3af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: peieM0ToopKR7OqRiY4bcFelFwpDBkvlW+OmZvD97sLT+fSmTEzYohhzywGlGFtlr5c/ryBA1RJ+3+0fR4PqYLj2rnYA6Y69vVFxAd7zEfwAdO1ClldjFbASuAC9K4CRvS0RS6tVRKol8SzaaZXgaWf63m5+XzxYhEsA5N2nT194/4DA3YY0t2d5cgTuoGJGxTZZ0efJkzuKa2U9yRblTbLnCEAeBEaLVROPV7yItTnIotoCfKXj/cHHJ4i2Vr79vccA6B43b2FJGPM2CeojlCkIjz7slW0JapsYrlIm5VLViTpSvWzoOrzdAPfES/hr8C27/MZJA5O0EcDxbaA7DIVIg0h2dftYPdjTY8QxofO9qVprDt52OCr3I5n4ZfKL/dXNDVGTVcAeU0eLHXKV40g9/NUe/5JnGnb7Jn0GrYaThOKL5CjgfNt3z5gVkalSug6puAkTPj6DMDy6vk/PSKn+EvoDGgf77N8PGZocAqUhr+XRnQk7Ctp5km0yxwivkQYpGKC3kiwd7SLNja043dM2ufLnf4ubKfG+0dlYMJWnz8HZFl8VOxHF8tgEDoy8XayNfwicCc+F9idZY/AII5OjH/4vgRcyHDRiPodsWs8yUID5hL3i3cTPOSUTsHdN1P6hLsVD/1zcW1dXOZrgMu4pgXTuOUmsrK9habcmkFulrPgrKgksir/7LdFZ6UJNIBMiVmJJm31QxQBbKfldolAVTiqg6WLM96qbK8BTnjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXZTbHdzbEVFaFgxaVBBRVR1dlREWlhRQXpiRGRRZHJJZ0psVktDelBscmdQ?=
 =?utf-8?B?M3RrVEhISmxpejNTNXVESDJJak1tTjlQeFNxcGVJWkptS0FhK2JVS0RMY2pI?=
 =?utf-8?B?by8zOHNDOVNxMjlJVkFMYTV2NlV5WHlTWG15UlVEUUhOZkVnUFZCOFVWbHZH?=
 =?utf-8?B?cVpoeEovaGxhNDE4U3RmMHhYV3VVUUdPZW95eE9saE5oQmVWbERtQjhNZXd5?=
 =?utf-8?B?TGcxMW1LanlwcVRoOExrOTRLSFQyV3NXQWE2ekwxTnFiRThQSHhML0U3a1Nk?=
 =?utf-8?B?VXVTL3NhclY2cmJRZHR3a2YvYkJvZWs3c2g1WGxoNHE2NlFRTzNOeVVJWVA5?=
 =?utf-8?B?NVlqZHp2YzQ2N1RWQXpwUjhzb05TOVZqQTlERXFIVFJPY0plcXZHM1JFMHlu?=
 =?utf-8?B?SDZkN2VJdHl6RDFkdWJZanhBNlN3S3dSSW5uK3M1UStweW5JR0hXUXVVMFQy?=
 =?utf-8?B?RVBqTDBUcnFKTmIrc2tFZ08yWHgrS3o1cTNVU2VIMkNNdjlFT21lQ1BpU0M0?=
 =?utf-8?B?QVR3Y1FzMlF5T0xBZ0s3RUZZNDBIRE9uMDM3YmI0MXBZZDdlZXg3aGxUcTR0?=
 =?utf-8?B?dEczbUJUcHRwSXhTR1ZVS2JpSkFONTRWWXFaREF6VEFmdVRYRVlYUURZMk53?=
 =?utf-8?B?aG5oenZhSjFYQnBlY29qQm9MUm8vK2hYUmI4WmlRM2x5ZWJKbis0K0NPYkEy?=
 =?utf-8?B?Sld0aHNuVWQwUzlWYWNPbmRxSDFJbDVVbmFSTnllekFMUkhlVnhHYXQzNG5X?=
 =?utf-8?B?Mjdmd0pLQmtkeHJmNi9SV05YcEoyRXdJdnBWTncwTDcvQmpQOHNlck5aYkVJ?=
 =?utf-8?B?TmpOajkzSHp6WG93Qmx4QWFLWEdJTFZWRXUzNkdaQ3FzeFVTVWpzVkZnL1kv?=
 =?utf-8?B?QkdTaTNNNy9VZWVVcmI3T05tZFRwL3NjbldmU3lyV1dic283NFZRUTFRQTA2?=
 =?utf-8?B?d3VOVk5zYi95a0ZMdUN6WGFnaHVyekJ5VmhFSHJsaXFSbWFNYnZvdXU3UzJT?=
 =?utf-8?B?SXJZbXh1OEtnTGZ2NHNkbENNSVc3OWxzVFdlZW5yZHM4Sm1CdnB0bHplOHcv?=
 =?utf-8?B?UC85d0hKbnVJSjlnWHR2Y2JsMEZaV1I1aTF3WHhyTEFmSk1jZTBIeG5menA0?=
 =?utf-8?B?Q280UXVZMUc5dit0LzE0OXBmN0VUVlNIa1dhVFQrU1R0R09mM2IybHRyZnNU?=
 =?utf-8?B?eWZncjBZSllyYVVSeDc4dkJ1cFZIM1RwRkZPdnJYbnA1RXpsUEEvaHZwMkda?=
 =?utf-8?B?NFpuV3hMRWZuT2p0WFJJeU9tR1Nob0dGSkszTUZHM0hSUllYOWF5V05JUzNp?=
 =?utf-8?B?ejZQRDJwYUUxVHorN2hUNGF3S3hmY1hETHhscGJFRDlEejVFQXdLQytSckpa?=
 =?utf-8?B?cUdPWG0vWWVPSXVTWWpXb0V6VGIvRndtdHRGdnhWY3dMNDFmb0R0ZkpsRDdE?=
 =?utf-8?B?VDE2elpYaDJSRVp5STZDNFMwbndtNHg1M2RCUnpzSzJJNmRvZlN0UEJFMVhC?=
 =?utf-8?B?dENmUmxnVVg1Y1pjZWFodlBRa3h1RVkxa1FXKzQ3amJhNElRU3FBMnBScjEz?=
 =?utf-8?B?S3BrT2tVZlFmcUZzRGwvSldQN3h6Z2x1Y2F3eFNWdm94UlMrZWlFTHJCM2tl?=
 =?utf-8?B?UGI2Ni9QQlhjVzNCOUc1c201WFhnQ3h3c2NjRVZxKzJLQzVXYTFBV2t1S0lk?=
 =?utf-8?B?UkRpRXJIWnd4Sk1Vdnk1dWJubkJYT1dwVXcyRE1YZ2JmT0U3ZWFOY3hCNWlP?=
 =?utf-8?B?WmdBbE5rREtnYkFWT29Jb2Zza1ZQWk04TDZld0ZtaHRpOEJuV0hqbEZydWtY?=
 =?utf-8?B?a2VISm5UVHpmRE9ESGpCMUJkOWlUaFhCRWhOZkFyQmxucmtaWURNZHMyaHBp?=
 =?utf-8?B?ZDMrZWhQSEpHYXdsRVpCeUdlcm1abGZ3WGMzelBuL3lyeVVMdXBDMnUvTm9x?=
 =?utf-8?B?QVBLYmpYeVlES2ZvR1UrcUt0ajh2N0Jidm9WbHpOcDNlQXJ2QVplKzA2YThZ?=
 =?utf-8?B?NFdWNk9JUFJpRUZwbG91djZ3M3lqa0lxalFmV2tZbnhPVFZyR2lVY2tlOEpv?=
 =?utf-8?B?TUpMeFVoTjhFSXpBY1FqbmlyYVVnY095ZjVsK0dQVmlQZC9TRFN1bUpVWHRl?=
 =?utf-8?B?YTA2V3I1VzRqNk5ZUFpnWjBxUHJMeElpVmMyYUVuK3YrRmZHVE5BZWFnVzZk?=
 =?utf-8?B?K2hkcStlSWZ6L1RsNW9La2tHVHZBeVRVSTJxSlNIVGc3OFNnMU5neVdrem1h?=
 =?utf-8?B?UFpTWFF6TWhlZWV3cng3dzRaZlUvYzlxYXNSSHg4VHBFb2p6OE5PcVNhWXh1?=
 =?utf-8?Q?l8hgFXp6uXAd/LxRIb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f061f4-f646-44e3-fa82-08de8e5a3af3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:45:32.2508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5ioiVbeeFNIL2DMvZurCrpk9QtEJ9lYRBTS5rROWgrMu1r3k+TgguwFVdOL/9Pq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
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

On 3/26/26 14:23, Sunil Khatri wrote:
> In function amdgpu_userq_gem_va_unmap_validate call
> dma_resv_wait_timeout directly.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 +---
>  2 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index d29620d3d0d2..e73c69026268 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1477,7 +1477,6 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>  	struct amdgpu_bo_va *bo_va = mapping->bo_va;
>  	struct dma_resv *resv = bo_va->base.bo->tbo.base.resv;
> -	int ret = 0;
>  
>  	if (!ip_mask)
>  		return 0;
> @@ -1491,14 +1490,8 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  	 * unmap is only for one kind of userq VAs, so at this point suppose
>  	 * the eviction fence is always unsignaled.
>  	 */
> -	if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {
> -		ret = dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true,
> -					    MAX_SCHEDULE_TIMEOUT);
> -		if (ret <= 0)
> -			return -EBUSY;
> -	}
> -
> -	return 0;
> +	return dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP,
> +				     true, MAX_SCHEDULE_TIMEOUT);
>  }
>  
>  void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 937a6dd3a4b5..7aa5b8c457c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1978,7 +1978,6 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>  	struct amdgpu_bo_va_mapping *mapping;
>  	struct amdgpu_vm *vm = bo_va->base.vm;
>  	bool valid = true;
> -	int r;
>  
>  	saddr /= AMDGPU_GPU_PAGE_SIZE;
>  
> @@ -2004,8 +2003,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>  	 * from user space.
>  	 */
>  	if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0)) {
> -		r = amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
> -		if (unlikely(r == -EBUSY))
> +		if (amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr))

That is actually broken. dma_resv_wait_timeout() can return -ERESTARTSYS when interrupted and in that moment you should not print an error.

Regards,
Christian.

>  			dev_warn_once(adev->dev,
>  				      "Attempt to unmap an active userq buffer\n");
>  	}

