Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBAEC44514
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 09:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED17510F4BF;
	Fri, 17 Jul 2026 09:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f7fikkhZ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE0410E27F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 09:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rpo4OOWamyVdEXE81PyB2T7GaJYGwwJmL0fEF4amn6haixLJVUb9q9LWwujfd8/Qr9PO2QPjlHcdYWywoAQV+FnNkwAB0AD2IBqTDc28I+nIUDxaNA2PTKINDVUZnnM4IPUB31jP/3+ixgRSdvWyCoEK6XvSZyTwBQTlFmIc42GRW6KcHPYxcJuryvugznull2QPQnl3VZRhtD9Xzjka2EjxAOUKSHZxYknjs3rMP5eTjXtGJsgGc4Zo4nZDHFyvCk9XzGwVAsH/1lURqYr+1bACHHNIG5icw+1mwrkBpyX4K08QFMvckcxzSSv4y0ZFYgACaeonTH31gkdqwaOI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaQf0mEXHbe+cBvWgq2Eo2R1wea+sN7ocFmfWC1tD8g=;
 b=OkJVxYwChwKr5RvB7J6TyXYVjCU29rIvoAq1QY38crRyO4KQkVNe0WJxhPSnuWX+Kjg3ZOcKjB6Sjtl763fsY4vr/5ulLe0eF4k3GRHItFmB9BAFx6o05n0b0oObZrkOrm79RDf/lSVthc1QLDlQZ0AfuFDBNFRpl7QsjLpGN4wu41N924IMy7uKWBZq2FiYvLIgpviKtdtVH6vL5KUXXzn9q/36AkvD9QmeCqPvQfOcX1sIRabFJtNjc0b8ff+suf2hrxn/G+zHsKVqdoPrhasSjnfDqm2On2qrv0R6JIGrNiLkiDUENTQskcz+VZOBcZ+mvC2A7XElAycGZ/2XIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaQf0mEXHbe+cBvWgq2Eo2R1wea+sN7ocFmfWC1tD8g=;
 b=f7fikkhZwrHUqnKe7FzZqDVH/hYr9VpzNr/9lQCQb6YqNGQQbME063iFynbnT67HWv7i7Q05EJ7HY1zb72GO4g8XsxpLM4dNbSYn3hGSooQMCpVz6tjtmn5Lly4c02r4TfPWf+qh5WVGAAQOBJoSuRE5w5eclaXlUtjS38v4UYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:11:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:11:21 +0000
Message-ID: <442cc9d6-f322-4aa1-bd47-4d337a8bcb91@amd.com>
Date: Fri, 17 Jul 2026 11:11:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] drm/amdgpu: Resolve VM through DRM PASID ownership
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260708152729.3209550-1-srinivasan.shanmugam@amd.com>
 <20260708152729.3209550-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260708152729.3209550-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 12071ffb-17b2-4a21-d6eb-08dee3e35e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: D+2xZ1mR0sbJzi8t5i06ga1SoG+/JBySdq9HsRXS+n/EUzlxZgZaS3EappAko16Ne3nlstYkA02OIpBCHEwsQIENFHk7YT7eYOvmGusc2YNzh26I2YNJGJYTLrNfABuszM1uR0eec5GrIDafVIH0Zx9LDqEG/lQBywDUwRAYIUmlw0CvQfsh7YQgZYthCi+2viNi+oCUbS7JeV1TVBhe6c5wVl1b3X3wqky1Se2dK95DydcPZr8Am6sxrnsPVgYVgXXq6ZDNsfhs4drADQoBe3p+E2+r1c681N988LnuiwtwcXbpnIvsvQuMRXZdBPJAmdztf8fAw1VSghQxsPAvvxotFeiyaFfVyR7SyxQ6nvNEpiIa3zXCI7vrs3iZt7dpTNRd7+k4bKKEEWD+bWIfvL2ZevO/ytAIB6swEq7sE299nsZivt2GSi92XjEf2SI/znGimdLjGITjAvSyaPpSejiTPlJYZoCvjO3nXdSyUfzvCSAQTfzi/wMmETC2Y3Ua5EIKyiVpXa9ZdfiB7PXGAr16JFYg6Cit3f0sLD2fWaa9Qczgjf/cJMlsIopc9Xnau94VLfluyBi+CypVehNQ8fkW2wdkPLGhZmkjwW94zAFSBawsJaOMEZglUY84Hol4ctGHlPZNKUYa0gVLO+6QfRv/Ow3juSTFu1UMh+4ghO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0FaNTBuVThvRFNWWGlpQVlVQndHQWh3TWV4WW9LU0RVV28rMmtJVXdGMVN3?=
 =?utf-8?B?RDY5MDhGZzY3YjhpMkZuUmZseHpwU2JRS1c1bDE2QXUzMTZwRmZTd29WUExC?=
 =?utf-8?B?OHFQRWNlSjFXVFd0Q0FWWjJnMGt3bWhuY0NBay9IcDA1QnZtdGxYZE8xblJJ?=
 =?utf-8?B?aXVBNE1oa0l3NUp6TUpkZHg0YUtQSVRqZmxKMjd3RFNDaDlWQmJ2SCs5Vmcw?=
 =?utf-8?B?R2JuMGd4ZHlrUlR2N0dSK0FQYi9WTXB1ak5nMFpRMU16eWZNUlF2NVc1c0da?=
 =?utf-8?B?SnZabHM5WHFLamxUU01KazF1SGs3UTJtZGdwUE5VbVNkRDlwa2xsNzJ0bEFF?=
 =?utf-8?B?eTlnWGVGazNxR29YU1pTU3k1K25VWXB6MTZ6Yll6TVJETVVINzFlUDFPZTh1?=
 =?utf-8?B?c0hsZm9kSGt6c1NkeWptUjNtbUQrMVY4ZnUvcU81YlpHZTNqSFpyNFdPZ1Bx?=
 =?utf-8?B?Y2VPSFZvVnpqbnM5ajFaT3RrdVJPVVJCSTZuVTJ0cjBFalp4Y0ZqTDlyMm5L?=
 =?utf-8?B?NUlFVkxRZk5LVTNGcTB6bFBkV3FoYXpxOGIrRmFZWVpaVDA4WWZrdU4vb0Rs?=
 =?utf-8?B?VlI5RU1iQWdTOVl1MnQrUXR4TDZscUFoQmtycTkybEJuUXJhS05Wd2NXbDFW?=
 =?utf-8?B?VG9wZWdtQzdySTlrTkxzK2VBTTNRc2p0QjNicnl2UFdveVlmQ0ZlZ0VUOXpr?=
 =?utf-8?B?ZnNwUmNlOW1nMEl3THAvSXpOY0NzRVJmUmJVdlpsVkw2R0N5VCtIaTQ2MFZH?=
 =?utf-8?B?aUtKWjFYNzNsTDhoVXBzNUd6elZJZUdQd2dQNW9jcXpGOXc4bmU5eFBiZXBO?=
 =?utf-8?B?TDUyRmtBWVV1SFFhY3g0WjRKaVVoRkhLdXhGc1hJTXNTcmFDSXlZY3A3YUdi?=
 =?utf-8?B?U3BZNWJ0S2ZmLzJVQlVDNGt1NXBZak9hZ1AzcEpQK2pFVTV4UWI4aXBGRmsw?=
 =?utf-8?B?NXJSVFJ3b2F2NUxCUW5vRDZhT1ZXVlAwSkZ5YWNFOUxwb3Z4WDdaeGl3QzE2?=
 =?utf-8?B?SDVoOFJxd2ZjalUwdFMvWEE0WlBmMjV4cGFtb0tDTXVHVjZmTjZERWl6T250?=
 =?utf-8?B?UFRWWlIxMmwvOGZlSHIwYXU2MzVtUk1MZG1UcW5UZjRvcU5iR285bEJqbTRL?=
 =?utf-8?B?ZlB0cW9MUzh5ZXNJUURZSzdKQUFPYjRiNWQwUGo2cU84U3JqTy9TYzBxRFg5?=
 =?utf-8?B?eEhaYWpXRUpFZHpscnpDR0hhNCtOZlhCMTBiaVM4WnQ1c2lpdC9pRVBoeFFX?=
 =?utf-8?B?T1J4dnlRYW1FWkRyZlAvTzFwMWs0Q3NZbHlKZzhBdk81Y1pKdnBCc2VBa2Nl?=
 =?utf-8?B?U2Y1ZnFqQkc4NjR6SVVKVGkzMzFMV2Vzc2tQWTg5eHFyRXdWaFpnOW9ERVBN?=
 =?utf-8?B?d0N5Z0tsVC90cVBNRHRKeXp1UGpWMUJIYnNEbm9NMDNmZW5QcVFRTGU5dXdJ?=
 =?utf-8?B?S1owVS8vVXduSzhmK2Y5YVBaVjNGa3ZybWFQQk12TEh3M1U5V1IxQWd2WlY5?=
 =?utf-8?B?YnRQcVJTNWtuWXRMeXZ6Nkh3TjBpZVI5Qk5xMGs1cCtWK01oOG1ieDJzWXVB?=
 =?utf-8?B?cytSbDJCem1oQ1MxWldhMnlybnoyMXRlQ1NaWVBxeVZPZnZSVTU3SjdZSmIz?=
 =?utf-8?B?a3NUblhieXdtTXRhRzVtZmNQTGdJejVDSkpQcllHTW1UNXExWWt6RENORnla?=
 =?utf-8?B?bWlFWGFveGc5ajk5M3lmbE1VYzFrbnhtTmhqemdLeWVwLzc0K3QwMXBYOG9h?=
 =?utf-8?B?TzdFdnlYOXhGcjJoRVhFT0IvaDdqOExsbVJkNFIyOHlNR0E0aEZMdEl4VFpt?=
 =?utf-8?B?bHJiNno1R0c1T0dmcUFUSGlOSUEwZkVDYkowWTdhRlBIcU5TMHdCeU1RcWtl?=
 =?utf-8?B?Mk5Cb1RTWDg0RmJnZFNJUDI5WEg1bDd1UHVMRkZUVEpHNmFEUUVWZW5IMURu?=
 =?utf-8?B?bE5LbXVoRXViVE1YTnFVMEZpNEE5STk1bkI5T2wvaFN0R1Jpb1YxeDNWT1NR?=
 =?utf-8?B?SWpYQWFmZitOaXRjUVBsOG9Ed2xxcHZHeFZMNHFycFllT2ZsQUR2TWRLdUtp?=
 =?utf-8?B?bUpaVkF3dGk4eTZqOVdrZ05aK1RpcUs0UVRvTVVBcXdFNk9TSklnN2t1aEw4?=
 =?utf-8?B?UEx1VXNlNVp0bC8ydXZyZFZuTkNrbVUrQnhGU2R5aUZURjk5K3NoTVpPM1ky?=
 =?utf-8?B?YnlWN1QwRXRLRCt0czFJZUg5S2QrSFRvUElycXp4L0U1eEk5cFVXK2w5eDd0?=
 =?utf-8?B?V1VuVDlrV3ZqQWFRdHlIL29IRVFpbFFPWk0zVTBWQXJabjZ0c0ZGeGNaZTVu?=
 =?utf-8?Q?Q6x+C5LP6c7QMbvY+u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12071ffb-17b2-4a21-d6eb-08dee3e35e28
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:11:21.2149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzu2DGdSCKtyFh5VeYHmWaf7YgUj4LNpKIHMkOzYWJ3eD6ftvHnHAvK5VXYQAXHu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
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

On 7/8/26 17:27, Srinivasan Shanmugam wrote:
> Allocate DRM PASIDs with fpriv and resolve VM lookup users through:
> 
> 	PASID -> fpriv -> VM
> 
> This preserves the root BO reference and revalidation flow in
> amdgpu_vm_lock_by_pasid().
> 
> v5:
> - Delay DRM PASID allocation until after VM initialization so that the
>   PASID is not published before the VM is fully initialized.
> 
> v4:
> - Allocate DRM PASIDs with fpriv directly.
> - Squash ownership registration and PASID lookup conversion.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 21 ++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 40 ++++++++++++++++---------
>  2 files changed, 37 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 0c973a3c73fa..43396c44e868 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1376,11 +1376,11 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
> @@ -1465,7 +1465,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct amdgpu_fpriv *fpriv;
>  	struct drm_exec exec;
> -	int r, pasid;
> +	int r, pasid = 0;
>  
>  	/* Ensure IB tests are run on ring */
>  	flush_delayed_work(&adev->delayed_init_work);
> @@ -1488,22 +1488,23 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  		goto out_suspend;
>  	}
>  
> -	pasid = amdgpu_pasid_alloc(16, NULL);
> -	if (pasid < 0) {
> -		dev_warn(adev->dev, "No more PASIDs available!");
> -		pasid = 0;
> -	}
> -
>  	r = amdgpu_xcp_open_device(adev, fpriv, file_priv);
>  	if (r)
>  		goto error_pasid;
>  
>  	amdgpu_debugfs_vm_init(file_priv);
>  
> -	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, pasid);
> +	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, 0);

Please also remove the now unused pasid parameter from amdgpu_vm_init() if that isn't done in patch #3.

Let me check path #3 as well.

>  	if (r)
>  		goto error_pasid;
>  
> +	pasid = amdgpu_pasid_alloc(16, fpriv);
> +	if (pasid < 0) {
> +		dev_warn(adev->dev, "No more PASIDs available!");
> +		pasid = 0;
> +	}
> +	fpriv->vm.pasid = pasid;
> +
>  	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>  	drm_exec_until_all_locked(&exec) {
>  		r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 180d694323e8..11822bf832f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2506,14 +2506,16 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm)
>  struct amdgpu_task_info *
>  amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid)
>  {
> +	struct amdgpu_fpriv *fpriv;
>  	struct amdgpu_task_info *ti;
>  	struct amdgpu_vm *vm;
>  	unsigned long flags;
>  
> -	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> -	vm = xa_load(&adev->vm_manager.pasids, pasid);
> +	amdgpu_pasid_lock(&flags);
> +	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
> +	vm = fpriv ? &fpriv->vm : NULL;
>  	ti = amdgpu_vm_get_task_info_vm(vm);
> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
> +	amdgpu_pasid_unlock(flags);
>  
>  	return ti;
>  }
> @@ -2938,14 +2940,16 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
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
> @@ -2957,11 +2961,17 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
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

Oh! Good catch! At least in theory that is a bug in the existing code.

We probably don't need to fix it in existing code because PASIDs are allocated cyclic, but that is definately better.

Regards,
Christian.

> +	}
> +	amdgpu_pasid_unlock(irqflags);
> +
>  	if (!vm) {
>  		drm_exec_unlock_obj(exec, &root->tbo.base);
>  		amdgpu_bo_unref(&root);
> @@ -3158,12 +3168,14 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
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
> @@ -3196,7 +3208,7 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>  			WARN_ONCE(1, "Invalid vmhub %u\n", vmhub);
>  		}
>  	}
> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
> +	amdgpu_pasid_unlock(flags);
>  }
>  
>  void amdgpu_vm_print_task_info(struct amdgpu_device *adev,

