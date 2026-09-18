Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E205BC88E75
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 08:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F36210E2FC;
	Fri, 18 Sep 2026 08:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JjgWm8Ic";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012001.outbound.protection.outlook.com [52.101.53.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E07710E2FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 08:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+dqtWeDYkM8X5KPJKvi6MDiljuW40MIh2HkpHUqq6sS6HneuG+CPDys4HfPRJt///72KjfPCajQVlq4C/oitrb4J1t28z8mYRNl72ehr2I6w0tZlodzpH2OMIFJjQjJDJW1DKwn4PrCAhVsu1CGkOgDXu/Q6wLzoxT9SLGR4xkKz0gpT9ZnvFw1wbnP0lDaDDfuKmO7nk3ZnYnNocPL0wvBwQFj9cS5v4U4TQuWwgonW0TATagm4d/kTxYWhm77NqJ/5//g0sgh4tGiTYe13XIDbUEwenI34lOkdNyjwq/lePBKN0cVxxv3eWDqY4qNlqrHBYMZRjxtXxVxBfSHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIXi1CGTHv1X2RsenCCzVyDVXdD78n6nP93PJgR5L5M=;
 b=QzxqUP5gTfdxEzEWUhQN5Mm9XSPhtvdBfveb53QFs7oRBm0NprOlMyNmZj6oOYR9PrEbPG7XCuFbjxOVM6bv8v1neSjL4rYZTQWapI9BkVEmi6kpxcRNBk2GvfT/ViM6g02OYpERUTayUisAxIWrGAmrMAJAh5YO9ytl8dDuBdmRIu/picSN+g8VWOHSLicyaDnjE2X/17YwmEZ7XScDlXDo9ayotalGNUBp2d8udNeEkQDOqxhdd4R6+RCzvWhcuAWgWsYoqo+18HCKe+P7AVxbWaACUp+mMyZhgXR5ffu08kM6G5kj9Cp8I6H+/lhEG5cqQLXjeo8JyZAf6be7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIXi1CGTHv1X2RsenCCzVyDVXdD78n6nP93PJgR5L5M=;
 b=JjgWm8Ic4gHNOoIRczG5WpVRe1h0VtXoUgt8L9nifStrLeP0PXH7wZC0MxKrWjANci9EBts+VyyAR0V1a2LeqFAvhA3RANcGBCOkZ+lpdgJgx6Fj6u9d130/ToolTjiGvR271185Hb6ZDMEdNUrdprDzZ59rZPQRd8PykIakDWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8547.namprd12.prod.outlook.com (2603:10b6:610:164::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Fri, 18 Sep
 2026 08:23:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 08:23:26 +0000
Message-ID: <3faddbe1-c923-4768-997e-9cf806b07c26@amd.com>
Date: Fri, 18 Sep 2026 10:23:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] drm/amdgpu: defer GPU resume from open/close to
 first use
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
 <20260917195812.72917-9-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260917195812.72917-9-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0344.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1f3f91-db65-4dc6-3fd0-08df155e1cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: M8gM2PMiPR++UwSyEps8rhngIOQdXi44+FHCniRm5ot8QRcho7UWRuSRvVRL+H4nMvXrPiigg2cbC+QdMaLAbuFQywHq0Zl2YQGvT7d/z9+HpJVZAHmLJbh3N0nDAgkkZkNVfFcBpoW4gA9KCHahWHQEMF+ElapVJkBxhW0qb2nrCK4MuzoXSKF+k4QJCpMFrua/u2Z/RmM7eb592s7WRwjip837FxglLxSVzuSh+CF7gTPgpTMYc9q1PnB47qvnCzPBFG9RtegFYaSn1cOoQS5Q+wXTlQNBLgHA8FIW99Fh8psiAImAXPn3JbnSjuCHvQ1/cJMsLj8fu/cV3DRWFJ+dHdLaWcXGwkSdEfsxbj7CpHqjaehTjQ3wGglujSbxmV19p/ehAntLYuQapt6FvHWA+J93/Yt2QXBk4HG73OxOIsk3SpiI22hTUKLwY5BUEC2gFtt5Pe8HFF4jdiyb8KIlW0SKaALgFEjHsntKM8v1t10CClwuQG2xFmvswQKfNEf7Q2oIaSUrY4JKyt7Z6QsShORW+ww+GGKDZ0y35p+FvvNVhkfUrNVHA/GgH35dxJjFj/kYpU/KuJTMiGf/cyekokdp3U7hpKs9oBZ9say10JZKyjFMQ91oNUgaq0Tyl/K5p39QG7lY1+DU+ly7SNVddyW355CCwtoU+q8HylM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enQ4Z1Q4THdFUkdhRkRoczJCMWNBRGorbHpNdUEyQTMvRDkzeUlyUjFEUDNn?=
 =?utf-8?B?VFFoSU1PdmcwN3EyTFlwRHlqd3hCdUgvTEFpTW1DVGxTSG9IZThaRWxxVVht?=
 =?utf-8?B?bjBGUS9ZUXhNbUlSSTl6VGJtZDByNm15dzkrNEdwTVNFOGJKR2VUeHRLOTZz?=
 =?utf-8?B?ZklMUnpVcmR3M2dZcmVieFZWT2NmWTR3UzdwdU5ML3E0Z0REUVBqV2hRdWJu?=
 =?utf-8?B?L1BNV2VnY29TKzZPd0JsMnRGZXc1Q2puTUdMN0QzSmEwTlpiVjNWQzVtZllS?=
 =?utf-8?B?ME1TRCs4cnZ4NFNTZW1nSTVsTytuTVlxaTdwUXU3eE9LVFhyMUNCeGNRejVr?=
 =?utf-8?B?ZTE3Wmw0eU9PTkNXNGJwRDBJZkM5QTJUYkZ0enVpL2VmbXJhQ2dJbGRWTFdQ?=
 =?utf-8?B?MlNZV0Z0OGhTTFI5NHRWVmo3ZytDWWkxVGJpbkNwSEJ2bWpCUm9UakppWGhv?=
 =?utf-8?B?bFk4VHR6Z3BFdEp2SE5QdTFjVzZQM3pQNGNYTk04bWxTc2cxbGJVK1BNZXZx?=
 =?utf-8?B?TDNzOU1OaW5mTVMrWFBuU09OdFFKM3Zla3pBbytqREVzNkpIMngrQ1FuSVBM?=
 =?utf-8?B?UUhUeXZLdzRMRWVTOG8zekhYR2dFdERxVGtkMGJ3bzZYZTFLRHJsUmZadTZH?=
 =?utf-8?B?K0xZZGhCYVJjQmNKbzFiMTQ5UVdoZ0N1d0xnN1hYZzFyOGJqSjl1aGpCK3Y0?=
 =?utf-8?B?ZTBPbWh5V2ExOGtyT05qUlZnLzBMK0RlTXdNMElkUmpnazNXenNyQTJyYUhH?=
 =?utf-8?B?eGRUUDdWSVhZeFdVeHQwWllOSThtY0VDaGE3bkFic1J2Q3o0SkpUdFFpWWlD?=
 =?utf-8?B?MVp6S3BoS0NLQm1sKzBhVkpZRjAvL21FUXBEUjRjT2NHSHJIQ1lKYlQxZFQ1?=
 =?utf-8?B?bzBHcTh6TGZwV3NXNU4wOWViN29pWTRIamxwSFRjRjZna0ZFTkJtZDZ2VkZn?=
 =?utf-8?B?YXlidG1oeUVJc0JhdzVLZG95TGlLSDV3NVZPazNhbW90Q2hBOURhM0Z3WlEv?=
 =?utf-8?B?NEkzM3M4UURyT05OR2JXUDJwQlE2aFlEd01GSHBOVCtHdmhiakorVnJuNVpV?=
 =?utf-8?B?a2lDTWtPLzhEM2RGUUFJeU9hQ01qTExxMFJLcjJmYWFtc29DalJnaU1wYzBD?=
 =?utf-8?B?UDJqdGVWTlp4SGtSNTB0eVRhalNkVUsvRFEyTTRHREtqTSt5dkpoY3FBbXVw?=
 =?utf-8?B?MWZSQ3FQczRsdVNJdDVlRjh6MW5EN2QxNTJMQjJ3aVpKd3N2SlhtV0czUnZV?=
 =?utf-8?B?dENqeGREN0dyMENGN1FxdXg4cWpQd1NlU0xMN0htU3ZoNWlUdHBEd2F2NzJi?=
 =?utf-8?B?NlFZcmN5eGpCa1Irdk92eS9lSFAxZlJwK2FBMmZWQTBMMXJIbEk1Mnp0OHpV?=
 =?utf-8?B?RzNvNG5pSVF4QXRsaFJlak1QOUNUSk00eW4xdzI5TU1IeGxNamZCK1RyUWdk?=
 =?utf-8?B?TzN1NXJjMXdYcDVONEY4Qzd6ZWdjdnBoU05VT0c4Q1FnMGxzT0JDNnZwKzZG?=
 =?utf-8?B?LzBSQ1Fna3c4UFJWdlJ3OURwKzdOWUNnRXZMSjZBRlZCVHZHUEs5enY2NHE3?=
 =?utf-8?B?c3RoaGYweW45c0pqSzFydHpjSjF2S0g4Q1dOVmdFQXNxKzdGVlEyZUV4TXJz?=
 =?utf-8?B?R1pEZ0VZRVZLZ2V6ZUlrVnVxb21nTEVZS0ZCZFB1b2M4cWxlcHUrVTJmUkda?=
 =?utf-8?B?NmNOVFhsU1loVVFrNUp4dXU1MTNzdFdkTitZYmlSNndZWmpaSEdqOXpFUEpL?=
 =?utf-8?B?N1NiUjdxM2FkSFk1SEx3RnZ1U1QxcmJ2ekUrNy9zeWk5aENKbXluV0hiSzVm?=
 =?utf-8?B?RGpWbUN3Z0JjSWxhZ3ZpQWIyRWt0RzVTSWJWS0ZHYjNVRVlIUExQcXBvMnYw?=
 =?utf-8?B?RUFQdUJXb244Y3RhakVUbTByTFNqWERxSWtWWFRtaFQzVndTN2habC94bmhG?=
 =?utf-8?B?WnVndngydWRxKzVWVVRLbTUxbmVtTEtGUGJPNmMyQXY1Mm9aK1ZjcFVXVDFQ?=
 =?utf-8?B?aWZmaktBU3RQQkNPcU8wZTN4U2NBS1VNem41TlozektwVWd5c1oxT1REZDgv?=
 =?utf-8?B?cm1FRXpmUHE0ZlBERjNvcVkyKzloaHJaZ0RrYThuN1NaS0xHOG5teXJSemlU?=
 =?utf-8?B?dk5EVmd1RzJ1LzdVSk1CTUlhS2xWcVNmR2N5bDI5OXRmZXFwdTJNU2MrY2R0?=
 =?utf-8?B?dmJmV00wYVhCRjJROG1WK0lIVGVjZTJoMjZCSzFZZXdidGdUd0VacFdZU2g4?=
 =?utf-8?B?MHVScGVScWNvYmt6STV1R0xOc0o3TU5LTWdidVB2UUFxamRMcFFNTVFTZ3la?=
 =?utf-8?Q?rlnB5sgiqhB9L7AX57?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1f3f91-db65-4dc6-3fd0-08df155e1cc7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:23:26.5603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Uo/RY5co9A0NxT9W3k6gRSn4rFyYvfKk4I9cbQK3uxgDuLl5xRtIfHcOT6zPQHS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8547
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

On 9/17/26 21:58, Shahyan Soltani wrote:
> Drop pm_runtime_get_sync() from open/close KMS to prevent unnecessary
> resumes. Instead, the PM reference will only be held if the GPU is
> currently awake.
> 
> Introduce delayed virtual memory hardware initialization through a
> powered_init flag to skip page table setup if the GPU is suspended.
> 
> If the GPU is suspended, pagetables will instead be initialized upon
> first use, such as when a cs_ioctl is called.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 16 +++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c  | 12 +++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  8 ++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  5 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |  2 +-
>  6 files changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f2f179421c4d..f40d864ca64e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1483,9 +1483,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  
>  	file_priv->driver_priv = NULL;
>  
> -	r = pm_runtime_get_sync(dev->dev);
> -	if (r < 0)
> -		goto pm_put;
> +	int pm_ref = pm_runtime_get_if_active(dev->dev);
>  
>  	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
>  	if (unlikely(!fpriv)) {
> @@ -1499,7 +1497,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  
>  	amdgpu_debugfs_vm_init(file_priv);
>  
> -	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id);
> +	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, pm_ref);

Use !!pm_ref as parameter here to convert the int to a bool.

>  	if (r)
>  		goto error_pasid;
>  
> @@ -1564,9 +1562,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	kfree(fpriv);
>  
>  out_suspend:
> -pm_put:
> -	pm_runtime_put_autosuspend(dev->dev);
> -
> +	if (pm_ref > 0)
> +		pm_runtime_put_autosuspend(dev->dev);
>  	return r;
>  }
>  
> @@ -1591,7 +1588,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	if (!fpriv)
>  		return;
>  
> -	pm_runtime_get_sync(dev->dev);
> +	int pm_ref = pm_runtime_get_if_active(dev->dev);
>  
>  	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
>  		amdgpu_uvd_free_handles(adev, file_priv);
> @@ -1630,7 +1627,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	kfree(fpriv);
>  	file_priv->driver_priv = NULL;
>  
> -	pm_runtime_put_autosuspend(dev->dev);
> +	if (pm_ref > 0)
> +		pm_runtime_put_autosuspend(dev->dev);
>  }
>  
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 21a225b0116a..7193d853df91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -103,11 +103,13 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		goto error;
>  	}
>  
> -	r = amdgpu_vm_bo_update(adev, *bo_va, false);
> -	if (r) {
> -		DRM_ERROR("failed to do vm_bo_update on userq sem\n");
> -		amdgpu_vm_bo_del(adev, *bo_va);
> -		goto error;
> +	if (vm->powered_init) {
> +		r = amdgpu_vm_bo_update(adev, *bo_va, false);
> +		if (r) {
> +			DRM_ERROR("failed to do vm_bo_update on userq sem\n");
> +			amdgpu_vm_bo_del(adev, *bo_va);
> +			goto error;
> +		}

Oh, that is the wrong place for that anyway.

I suggest to have a separate patch to move the call to amdgpu_vm_bo_update() to amdgpu_cs_vm_handling().

>  	}
>  
>  error:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index ab564202f550..6022ec6cf1b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -4071,7 +4071,7 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
>  {
>  	int i, r;
>  
> -	r = amdgpu_vm_init(adev, &adev->ualink.npa_vm, 0);
> +	r = amdgpu_vm_init(adev, &adev->ualink.npa_vm, 0, true);
>  	if (r)
>  		goto out;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 47cde5459469..a03000db3c36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2596,7 +2596,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   * 0 for success, error for failure.
>   */
>  int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		   int32_t xcp_id)
> +		   int32_t xcp_id, int device_active)
>  {
>  	struct amdgpu_bo *root_bo;
>  	struct amdgpu_bo_vm *root;
> @@ -2620,6 +2620,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
>  
> +	vm->powered_init = device_active;
>  	vm->is_compute_context = false;
>  	vm->need_tlb_fence = amdgpu_userq_enabled(&adev->ddev);
>  
> @@ -2640,7 +2641,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	vm->last_update = dma_fence_get_stub();
>  	vm->last_unlocked = dma_fence_get_stub();
>  	vm->last_tlb_flush = dma_fence_get_stub();

> -	vm->generation = amdgpu_vm_generation(adev, NULL);
>  
>  	mutex_init(&vm->eviction_lock);
>  	vm->evicting = false;
> @@ -2663,10 +2663,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		goto error_free_root;
>  

> -	r = amdgpu_vm_pt_clear(adev, vm, root, false);
> -	if (r)
> -		goto error_free_root;
> -

Please move dropping the vm->generation initialization and root PD clearing into a separate patch.

We also need some kind of test that this actually works correctly but that is a much bigger task.

>  	r = amdgpu_vm_create_task_info(vm);
>  	if (r)
>  		dev_dbg(adev->dev, "Failed to create task info for VM\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 0f6634b74974..b422a5f394a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -373,6 +373,8 @@ struct amdgpu_vm {
>  	bool			is_npa;
>  	/* Flag to indicate if VM needs a TLB fence (KFD or KGD) */
>  	bool			need_tlb_fence;
> +	/* Flag to indicate if VM during initialization holds a runtime reference */
> +	bool			powered_init;
>  
>  	/* Memory partition number, -1 means any partition */
>  	int8_t			mem_id;
> @@ -429,7 +431,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev);
>  void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
>  
>  long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id);
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id,
> +		   int device_active);
>  int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 1cdf2b854f26..a29127f27329 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -456,7 +456,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	bp.size = amdgpu_vm_pt_size(adev, level);
>  	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
>  
> -	if (!adev->gmc.is_app_apu)
> +	if (!adev->gmc.is_app_apu && vm->powered_init)

That won't work this easily.

This not only affects the initial domain where things are allocated on creation, but also the long term placement.

You need some construct to set bp.domain initially to AMDGPU_GEM_DOMAIN_GTT and then update bo->preffered_domains and bo->allowed_domains after the root PD is created.

Regards,
Christian.

>  		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>  	else
>  		bp.domain = AMDGPU_GEM_DOMAIN_GTT;

