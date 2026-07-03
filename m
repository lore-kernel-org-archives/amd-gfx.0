Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2ACEC43602
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 07:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A71310F6B4;
	Fri,  3 Jul 2026 07:43:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0sb6SmEl";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0356110F6B4
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 07:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Spfic/gKNELSObvwDniNDnJS0FTCdYyQKoOBUmJH+AgCF+03cw8cmJN5Rb+mX75DYcCEB+J8CY8/+aGcL4Ji9FT2ZZI0K8vJcjEFptNbNpxOn9N/o+O5dEwy9RI/6mERJ8JfBRrdRRJxxjNiVBgIsoKUbmpaXDlU8nJW9SB3ORftQnWUluTOoKCUMFfT2sHaMLvdxKPJfjna9trO9q1/9i93cEA28USuLZvvwDnOPXP/3EB7PvHtloMVmq41JSSaEvrBl/MOF2jvWXy++yLZ+m6v/ihVkBurjtO1zmxJ5kVOCEXRwzLE2P4Fj4at/3oG6zP45tL26o1KBlRHHPJArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGesBF+8UNRGrHmQftpfoTK8CfJgBRgSO/9B7kE+Ozc=;
 b=WHJG7F3StJ1q57s8xLvRoD9VmfKIZj3QhtWUbAg/hHYJum7/el01tvQq0HnSpqf7Y1qG66ikVIWhM9X2f2JDo2DcwdMdl1A7A4BevIe5Ej3YTmb+fdGmkAr58Cao3YHFgA2Q7RIHd8TG7cTZ2LoQOnZM7ASWHA9oUKWJBtcyCofP8XSDbN7RmM9Q+QkAPZ7EzrCNs8zIEWH8EDC8lHSY/cL/isR+Vot4ILBZYzGIlo7aZ4ktI1SqBT1V/g6bx4A3kpj1LUTJOCf4tSEMXz0vEBUtqnZWPNT3niqjZiZIduRZfBivMnG+jdWs1Yg4ROJrjfPlnoz6WIjl5/cItw66xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGesBF+8UNRGrHmQftpfoTK8CfJgBRgSO/9B7kE+Ozc=;
 b=0sb6SmElMXc//a2/w9hL7OgPPu6GZ6Ux+yXqXZrcMBrzsdcTNPFLR3iqp/8dXD9SD0EYY0baniA1tGykvJ4FHUKkt6PrzI+iPietGxokFMYbziPAmG20daSH0GEJe8++9xXGVg4ylbbv3okrqS4g8+CsA0wfcujcBelfzEJpl7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 07:43:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 07:43:03 +0000
Message-ID: <efaec211-bece-427b-973f-c36eb8c62478@amd.com>
Date: Fri, 3 Jul 2026 09:42:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] drm/amdgpu: Resolve VM through DRM PASID ownership
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260703061833.3163913-1-srinivasan.shanmugam@amd.com>
 <20260703061833.3163913-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260703061833.3163913-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 06322744-7a4a-490c-ec47-08ded8d6b68c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 3PlnTMv/5EueNg6xgIS9Khms5P6BpM2Br67Bv4uQipcY3GbiJEmTI5c0HqjP4xS8pYotvoxgaWarFTJ1vzUbrwiNf1OKU4IJuDZBEs5UG6JQ6ek3pXHOWaFRjtas9J3Ee9VGoiqGYaOkxFvqVoFF1ROvTXWHQ2UnQ9FGWyB4OVumQW+O0Dvzo12aPG0GoEjNpCJe1Fui1ky2UViUTCUhHLZfDYeeFUFG0C0KByXlMlSvp9M6m1i7cit19fcgzaow1LhjVE1dCHdmxWJ6Ws3cmTr1eqUdrQPZRprrgOrZfMbYbVVnbzqPgK+q48CPC3/cZPk8ZOA+TQQiYUemQO2C8yjcD85iRwVkCIjjZ3v7ZkoDk7LlC9q2bpIa8/JgvaqftgrOHfGNNygAkoKN4uO9AR+A3nC4IY7yxY+ruaDYZd7YT5zF0rglesKJrSHukdh6E/MOJwXNuDxPi8d4T3n071lXEKMvL1rupN7u4/deYDReOquwg/YTXvJBATwbMSSze+0qYr358gFjGfuKojFAEEEUdrAq7MXG0aawS7aW5dWM+tAXFnh/cqvse15sXfb5iQM6R8l8PXHYHz2s2g7BLD6ET+czMcSQ338Ntk0PpoeKVs97W/4AbsgIYafNxJjBb6lMclfr4A0F/g6TdtTidkLfaICTRb4Nv4R5dOPPfP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDBBSStCaWc2VlZxRGdkUXhZR0lNclE0bXFJMEppbnROSC9pb1ZCc1B0c0Ey?=
 =?utf-8?B?cEt5N1JLNHErMkxpaENoN0lJWUhXVGpHdWUrcWd3c09ScmFDRlFTMmtOOGU0?=
 =?utf-8?B?aXJDVS9GanJYU0FKOHdZa09EQ1c2bjErZWhzNXl0TFVUR0dUVCtHbGpVUmRt?=
 =?utf-8?B?TTRXcGc1QlFkbnVDNkdXQUVpcENpZC83RkVKUTlsT2Mxb09vSlhPcG1Rc0R2?=
 =?utf-8?B?ZHRFZUlLSmJ6RnNObW8yaFk4aVVCeVo0Yk1BeXN4QkdoWlVTVzIyWEJSWXNs?=
 =?utf-8?B?ZGQvMDV1bll0SHF0S3ZvZTl1ZENobG44ZGRWMnVYSTZMbGozYWY0M1FHYlJq?=
 =?utf-8?B?T0pMcGpXZWhxalpyZ0tpNlJCV2JhbitxdkJCWXBHbHFZbUpWdkgzdHpUTEZR?=
 =?utf-8?B?NlBVWWZ1TDBuaUgycWJFdDRuRmIwSC9Oc0RXQ29FaS84dlgwZmU4Tm9ET1ZM?=
 =?utf-8?B?bUxMby9XZzhtZUlOc1RkVWhhWWJXMmNFdklFYlZnb0Nld2lXaW9HazdqUmpR?=
 =?utf-8?B?WnZGTjY5Q1M3ZzJHdWo0aDRNT1BTMEp1clBpWXdmNnJjMTJVU0ZYVm5TNk9i?=
 =?utf-8?B?VGJFT2pHdVV6UVpZU2hNekxOaklxVTZOclk3MDZqazA1UUliSGo0MUVpa25E?=
 =?utf-8?B?ME82dGxYazI3VDgyTnVWVFZhcmx4dXBLTFVWdnVZTnZFVVdmU1RFWEdqL1Fv?=
 =?utf-8?B?VkpzZ1hGbHYvaFlCTE0wZS9ObTh1OUt6M3paVW1SbkRTNzBRekh1bFVKQTY0?=
 =?utf-8?B?UG40NVU4dzBXaHFRSU0weDloMDNyNkM1Nlg5aE9RQ2tCYWloYUZOV3djV0lL?=
 =?utf-8?B?aDNJeklTUTJUUWlvdVJzQzJpNjVMYWtqeU01Nll0cjJBQ3NRUE1Xb0FOay9m?=
 =?utf-8?B?YUhXUGVyQU1zakJkazhpYk52SVd3a3ZlazEwaEZnc3JQaSt0T3ovUGF6bmtM?=
 =?utf-8?B?Z29vSE9semRlcyt0TlB5MGxta2hzY05nY25XdE5qR3hRSkhucUNNYXRmWktD?=
 =?utf-8?B?ZGRkMld3b1lCL1ZEOVhrYVp6aCtkbXFPZlgwaVcwQURPMzF5TVdzOUpYamUw?=
 =?utf-8?B?aXlWSkxsajZudVFKMVgyK09YTHJzanFRblZ6dG00UE1Ba3ZuMnc0UG5aZ0Fh?=
 =?utf-8?B?VWIwMVBMOWlXVThuSnFJMXNqd1pOb0wxbXoxUWxtb0RQLzJ5NEI4dnphMXR2?=
 =?utf-8?B?ZjYrSHh4SEQ4ZldJQlNZTCtCUVRQRXpDbWhUTjRIK2QraHpTamRkSk5GeXNG?=
 =?utf-8?B?OUFsQ1ExeWwxaVY0cysyQWw1elF4b2pGSlROeEV2ajgyUm40dmVFQnpQcXBX?=
 =?utf-8?B?RWVDKzVjTG1ycmZzb093OXl1SEhUM3pTRXNpTVhubnR0WnlTN01TZzdSRm5t?=
 =?utf-8?B?Nk9qa0xYZ000UGEwYmRrM012SjlyNDJkdWs5L1FLeThRNmIzRm9Gazc4Z1VD?=
 =?utf-8?B?U0lZNURJc0crMml5cG5jamUzWDJCRnpDRW1ZQ05sbUJHSDZLWXFEdFVzcUpL?=
 =?utf-8?B?enJKMEdpRUIzNlM4eFVTbDhHbmVFRmZmT1U2VEQxTzQxMVEwaDlDblJrazNZ?=
 =?utf-8?B?MC9YNFprQTkzSmg3WVZ1Y0xsSCswUDlxUk5wY2pDRStLWWtmS0pRSVRTUVBT?=
 =?utf-8?B?cnIvUnZWQjA1cysvWGtrRnA1bHFDVHlMM2NaNVgxcXBNZFdLZFQzU2VOMU9H?=
 =?utf-8?B?R2hDa2VOV0lXbFpCMlM1d3Z4M2ZNT0FqcjI3RGpYWk9HemVsVzRMckF4dmJF?=
 =?utf-8?B?TVJFZmJEYkRINHBCNWI0L0R0eEJ4RzUzZEhWOTBLRllRSVFGNHlPaTBLL3Zn?=
 =?utf-8?B?Yllra0w4YVdyY1o5dmZrdm1CY1dXbm9BSkZ6SXJGR3hNKzMyVTU0U2R2bXJP?=
 =?utf-8?B?MVZtS3Z0TmJWQmQwY3lPemRyMXN1OG0yK0dEakh3KzBqZndYU1dyTERaZ0pK?=
 =?utf-8?B?dVVBTkx0ZnY0TTRDZ0V6RHB5SkRxWWpIa0xyVVJ0cWpaK3B5WXBIQm0rd1k2?=
 =?utf-8?B?NnlnK25DZXovY2E4Rzc5QjFuUk1iTkZJdGcveGpsMU0zMFg4eDdIL25WVTNq?=
 =?utf-8?B?dmoxbGhUeFpNMGRJODkvTGlQaFZGZFhpWTJDbExMbzJabldpN3dFcFBOUTNR?=
 =?utf-8?B?S2xaR0FNU3k0OThnTk9Ic0sxZGMvSytCc3ZXWFI1OE05QTNMT2Vrd3VtZGtJ?=
 =?utf-8?B?WXNBMUZRc0tleS8xdGtDRi9FR0ZPRUlBMWMwL1B6dG55blgvM3JPMjFaMUZS?=
 =?utf-8?B?Vlh3bnhyYThyVGp1d1BSUnFTRUZPRVhvS3AyQVY3TUJxQlk3czZ1a0Z5aDE1?=
 =?utf-8?Q?/E3AYC4/qsEDZqgAmF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06322744-7a4a-490c-ec47-08ded8d6b68c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 07:43:03.1922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rczkwo8W2hfpC/VOIXKpzT+BZNcI3i4nfpiQzJh22tQQbMTPHXLeXcPPezoOZPqU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903
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

On 7/3/26 08:18, Srinivasan Shanmugam wrote:
> Allocate DRM PASIDs with fpriv and resolve VM lookup users through:
> 
> 	PASID -> fpriv -> VM
> 
> This preserves the root BO reference and revalidation flow in
> amdgpu_vm_lock_by_pasid().
> 
> v4:
> - Allocate DRM PASIDs with fpriv directly.
> - Squash ownership registration and PASID lookup conversion.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 16 +++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 40 ++++++++++++++++---------
>  2 files changed, 34 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 4610d6889e9b..087ca7783d1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1375,11 +1375,11 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  
>  		memset(&gpuvm_fault, 0, sizeof(gpuvm_fault));
>  
> -		xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> +		amdgpu_pasid_lock(&flags);
>  		gpuvm_fault.addr = vm->fault_info.addr;
>  		gpuvm_fault.status = vm->fault_info.status;
>  		gpuvm_fault.vmhub = vm->fault_info.vmhub;
> -		xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
> +		amdgpu_pasid_unlock(flags);
>  
>  		return copy_to_user(out, &gpuvm_fault,
>  				    min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
> @@ -1464,7 +1464,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct amdgpu_fpriv *fpriv;
>  	struct drm_exec exec;
> -	int r, pasid;
> +	int r, pasid = 0;
>  
>  	/* Ensure IB tests are run on ring */
>  	flush_delayed_work(&adev->delayed_init_work);
> @@ -1487,16 +1487,16 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  		goto out_suspend;
>  	}
>  
> -	pasid = amdgpu_pasid_alloc(16, NULL);
> +	r = amdgpu_xcp_open_device(adev, fpriv, file_priv);
> +	if (r)
> +		goto error_pasid;
> +
> +	pasid = amdgpu_pasid_alloc(16, fpriv);

That needs to come even later, e.g. after the VM is initialized.

Otherwise we would run into a bunch of trouble should there be any stale entries for this PASID in the interrupt ring buffers.

Apart from that looks good to me,
Christian.

>  	if (pasid < 0) {
>  		dev_warn(adev->dev, "No more PASIDs available!");
>  		pasid = 0;
>  	}
>  
> -	r = amdgpu_xcp_open_device(adev, fpriv, file_priv);
> -	if (r)
> -		goto error_pasid;
> -
>  	amdgpu_debugfs_vm_init(file_priv);
>  
>  	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 32719f31b6c9..9092ff227a55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2463,12 +2463,14 @@ static void amdgpu_vm_destroy_task_info(struct kref *kref)
>  static inline struct amdgpu_vm *
>  amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)
>  {
> +	struct amdgpu_fpriv *fpriv;
>  	struct amdgpu_vm *vm;
>  	unsigned long flags;
>  
> -	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> -	vm = xa_load(&adev->vm_manager.pasids, pasid);
> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
> +	amdgpu_pasid_lock(&flags);
> +	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
> +	vm = fpriv ? &fpriv->vm : NULL;
> +	amdgpu_pasid_unlock(flags);
>  
>  	return vm;
>  }
> @@ -2943,14 +2945,16 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
>  					  u32 pasid, struct drm_exec *exec)
>  {
>  	unsigned long irqflags;
> +	struct amdgpu_fpriv *fpriv;
>  	struct amdgpu_bo *root;
>  	struct amdgpu_vm *vm;
>  	int r;
>  
> -	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> -	vm = xa_load(&adev->vm_manager.pasids, pasid);
> -	root = vm ? amdgpu_bo_ref(vm->root.bo) : NULL;
> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
> +	amdgpu_pasid_lock(&irqflags);
> +	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
> +	vm = fpriv ? &fpriv->vm : NULL;
> +	root = vm && vm->root.bo ? amdgpu_bo_ref(vm->root.bo) : NULL;
> +	amdgpu_pasid_unlock(irqflags);
>  
>  	if (!root)
>  		return NULL;
> @@ -2962,11 +2966,17 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
>  	}
>  
>  	/* Double check that the VM still exists */
> -	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> -	vm = xa_load(&adev->vm_manager.pasids, pasid);
> -	if (vm && vm->root.bo != root)
> +	amdgpu_pasid_lock(&irqflags);
> +	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
> +	if (!fpriv) {
>  		vm = NULL;
> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
> +	} else {
> +		vm = &fpriv->vm;
> +		if (vm->root.bo != root)
> +			vm = NULL;
> +	}
> +	amdgpu_pasid_unlock(irqflags);
> +
>  	if (!vm) {
>  		drm_exec_unlock_obj(exec, &root->tbo.base);
>  		amdgpu_bo_unref(&root);
> @@ -3163,12 +3173,14 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>  				  uint32_t status,
>  				  unsigned int vmhub)
>  {
> +	struct amdgpu_fpriv *fpriv;
>  	struct amdgpu_vm *vm;
>  	unsigned long flags;
>  
> -	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> +	amdgpu_pasid_lock(&flags);
>  
> -	vm = xa_load(&adev->vm_manager.pasids, pasid);
> +	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
> +	vm = fpriv ? &fpriv->vm : NULL;
>  	/* Don't update the fault cache if status is 0.  In the multiple
>  	 * fault case, subsequent faults will return a 0 status which is
>  	 * useless for userspace and replaces the useful fault status, so
> @@ -3201,7 +3213,7 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>  			WARN_ONCE(1, "Invalid vmhub %u\n", vmhub);
>  		}
>  	}
> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
> +	amdgpu_pasid_unlock(flags);
>  }
>  
>  void amdgpu_vm_print_task_info(struct amdgpu_device *adev,

