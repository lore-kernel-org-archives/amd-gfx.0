Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4435C88E75
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 05:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BDA710E801;
	Fri, 18 Sep 2026 05:06:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BNBHRYYi";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D8C110E801
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 05:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSLHDtY5MN2SIQCHePH8G1hlkJh8YfuS//BBxkufbrSqFuzK0USxsD4BBoFal89h/H5yPzlXC9Lu1C2JnZtN+pUPyrNx9aq0eBZGtE0izrVZetoNUEFop+G262dGDLe+G+Z0pStFFyw4+MgrrJHir5+N3LESjVAtKb3eN8RgLpMsfkm7O4Ulye/5wvv4zMVRWMsHVHnMnQILzUrZJZsuQe516Fe3MFZ5oOdU5uoaTyjZiQ1gs03VclVm+HPT4HVSqUuWKBmzt/hzJRzZqMvbufyWeSSB9To9NMdIT5UvVRyr9g1i2ekO0glxiJNOOkhjbav0fW+02iDttShBGbiP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0aclhRkPe+9hB0iLpgnHg4dPSTRC/BwripV+YNvXp0=;
 b=T91oAJLjiLRNEHWIjArvP1bYtrhVjhJoAOwEPcMj3lPl2LGS1a0yVSwBXUZGsDecTfiaWDTeOO5YV4FrSfp4OrhsTXnYAO5MxMhes9KY3cCod/mM/XmmfNTKtBFVvvOtzU6h/vq1fB8DF9rDn6/EZWBp5ZN+h081DUDlhiTd3AmREYuwhnLGdoKG017Zo4NkVFkRGbKbgnmSc/lN+p2BSWy4JKoPkwEX3nRMJ0nGqpJaqrL3kvPkxuIiEGvlHKJJUMe0X2j8J9O4ADDFRjIuiXupm1S1sAwklufjOZVBKFbvmvZ4LIfFOpWU0Le4FQ6Z50ViPjS6ehmsmfUPdnkYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0aclhRkPe+9hB0iLpgnHg4dPSTRC/BwripV+YNvXp0=;
 b=BNBHRYYigljQKQsPz54VE4nuH0X8s3IoBFVzVhv4IS7WcfHUis9ZM6SG3yR/SToaqMubaJKp5KjNadgCGlhqjXj3HxW9d1v7BZEeEzPW0gStif6hwxvdA/j0yhtLdT5nKFLE491QNOBEYFkPR3sg64U4KLD/xfTB97CDVqI+MG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 18 Sep
 2026 05:06:14 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 05:06:14 +0000
Message-ID: <8b5e55f4-5d9d-41af-bf09-c3c6231c9123@amd.com>
Date: Fri, 18 Sep 2026 10:36:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu: Make first-level trap state GPUVM-owned
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <felix.kuehling@amd.com>
References: <20260916053722.601067-1-srinivasan.shanmugam@amd.com>
 <20260916053722.601067-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260916053722.601067-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c6c153-21ae-4877-beaa-08df1542902e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|6133799003|18002099003|56012099006|11063799006|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: fxuLGE6mAT7MqwSr8D4kM0hw2ujrg+Wt9CVxn86SWx89ii9tUX+DOSvbSvjegcLjX+hIbli/lxk+nd19Luw4iIetIAYrEAzcrN1aalIUIZVLvoQqAoEbQLtD9hyad4NrRvFPSIhJz387ZjVrc++JguJovPVYzRJ6QsDi89vw2g9pUkYOfPBjfHGTRcz33dsNxhyQp7r73495zbF2CpKCh4qPznHR31KNriQiVpxc7EWM14Kd1hZLmVHYQSf/TB6DcrfdkgmPZA6Rk069tomtq7pcGImBfOV8r93A9cuHEq/6Kwy7a5xUrT9yAO1zloHvTmIIStryIIDqMibQ5ihI3vhsrrc8qWOlFE627+ILgGZ2sKAU1mgwcmJiDJMs9okNDNhq9rwpFqK1EZr43eRxwVDT9adHlMt7adxrm8p4LwFY79QfBfICHcCStIeMXgSaRj0AgCLwKNJcyiPekpkOH28OplPfns0HGf5WFSGtKECzkKIlO4Z4cD+0hhLRC3MN0K6rMokNAEiBgJEjIUMRMZ2wVL4+fbETxqmj6bbqcVhltUjsiToU/9M/2HZzO4uTP+cD0XE7ssTOV3X/wRZu4tdmS9cGQPAOC7SsnoHOAAp3Atkh/ncLoRIEvNuqZ8eRfgrJgbiPwTkb0jmY61LxKnWUWnk1QJi4D1C2iyPX3cI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGRuSytUUmVhQWhJeXkyekFnbWZ3UFlyc20waHR4Zk44NmpWYjR4QXo0OWsw?=
 =?utf-8?B?UEdwTjJxdkVMcDk0ckV1Mk83RXloeU5tMzJBSmhyQ3RnaTNjbnNsOWZTaDAr?=
 =?utf-8?B?SzhLM2l0YzllMVYrVS8xV2N6MDlVcHNmQkpqeEtuZ2poNkY1SXZrcVk4QW1s?=
 =?utf-8?B?ZGpwSVhLdzRqT2t4QUJ3VDd6cVJ6SHpXeW53OXBWOE10R1hZNGlqZW9nNkV5?=
 =?utf-8?B?TjFnN21WdmNJdkI1emR2NHNHVzcyZXRlTk8zZzNFYnFqSEYrSTJHbkU4SDRP?=
 =?utf-8?B?Q2oxMk1icUNWcVBxaFdYS3lkbysvT0kwRzZKUW1kNFNILzFTMHdWUHNHVkwz?=
 =?utf-8?B?eEN1alR1VWlLTVZpRFBaTWc2TUVXUkpjaERLb3BobHlGcllIeGt5WDkxQ1Ux?=
 =?utf-8?B?V0tCNVVFcC9qR0IwUWUzQXg3ZEJyN0JvSXFPOTA3WmxCSnVRYldBOUxHQnZV?=
 =?utf-8?B?dzFhS1ZVRGxkeVhhR2t4dWpINmFIYXVLV3p1Vk9QOE8rSkFuVWtnY3RlZHR2?=
 =?utf-8?B?Y2lVdWhCc2V5TWovQ1ZwTXJlNHRlUXFkVmJnYWEvc202dXErMmUxYllYcTNG?=
 =?utf-8?B?OTdmMk5LRDR5bjFrNDhrM3JHdm9waEV4YnUxcTlCVWlNeGhRVmFwWmFGejhH?=
 =?utf-8?B?VC9TcG5Dc2xFb2lLSys1bWRqOVB0Nm9LYmY0M040L2xBUzQveUdidit0Tng1?=
 =?utf-8?B?Z1NxQlBxQ1Q1ZWhUNzhCODY2aU10SUNaVlJOY093K2Y4MzlPcVc5bjZkcEpi?=
 =?utf-8?B?SW44N1d1VXZhYTZRekFjcmFaUm8xUG5POUZrZFBONVo0TjVsbEZ1ZGtnMjJl?=
 =?utf-8?B?bVdHa3J5SjNmSFFIR3ZLQzZ4MUNjS0JJd0hGeTg5bDFjNGdQYms4dW1DWjN4?=
 =?utf-8?B?ZjM0YUdRQlk2QkdrRzdQQm1MakNuWWVuK25BcUNGY09jdkxNRGtWK1RvMTMy?=
 =?utf-8?B?bkplWERnWmo5U0RMQ0lSWC9sTGhxbGwvTlR1aXRwaC9WY1dIU2FMZEhjaWJB?=
 =?utf-8?B?MzNKcVJ1eUY5YTIyejQ0SlpsNUU2VTUrM2tBUW9OM1UvYllQeUtDbm9YQjhX?=
 =?utf-8?B?MVB4U1Jlak42U0tLazhKdjNMTzhGei90UktNZU9CTy9DeWlEaHkxU0F0akU2?=
 =?utf-8?B?OVgwV0dtWk40RXZ0YUoxZG40ZGFLbEYyNWhpRmhCdFVDcndzTEczYU5KeFda?=
 =?utf-8?B?VzZNbG93djViZUtvR0x5Tzk2U2kxdjgzNFJWLzRrTU5INUhuWDRDQWxBdmRD?=
 =?utf-8?B?SDRQeWt2dEdwWlpRdEtDSEhXdmxLSis4QUdQU1Q1azUwWTZrbnM5dmZqQzc2?=
 =?utf-8?B?M0IxVFNVdjg0ZmxVZUgzazlJeG5ySE9jb1RVdldVSExFU3NpSVRqRzdrWWZC?=
 =?utf-8?B?cGJvN2hIcjZPUitjWXg1N1FYcWZXenNCd2F3c21JOVA1eFZ5N2Q1cXNDS2l1?=
 =?utf-8?B?cHM5QnZCV0czbm42ZEtwS0pWRytoaFZUY3V6cUNXaWI2aXdMSG1ibXZmVXhZ?=
 =?utf-8?B?VkpSL202NzZYUXBXQUVXa0M1aHVWTzdhUXZXV0xXdkx5ZWFhYWNFbGhacHBn?=
 =?utf-8?B?b1NjVi9NRXNzMmx0eXkzSGJZUU1wd3F6b21DMmkxdjBmODJFcXNQbEFvUnY5?=
 =?utf-8?B?N3NVU0lzSm5RcXV2YjdrQ1docWNybWxjNW5mcndqODNkY3NuUFF4OU50YU1i?=
 =?utf-8?B?RFpsdzZaUmFJSzFYbURhYUh0NVRQODRhWk0xT2Y0TmVRZnVGeHpVQS9zZ1RG?=
 =?utf-8?B?VXg2NDhzeElJYm5tSmdMKzRBaEJZam5QYzFMQ2RwcjlRK2tJek1hdzBlWHJk?=
 =?utf-8?B?TnNiejV4MzdoQkFhRlZ3US9XeWR6cnBHam1hT3JwZGFOZFFBTmFIOG9iWlM0?=
 =?utf-8?B?N1NHcDl4cDVrRGlyRTZUaDdkUkMxTzRPZXlJcFFmT3BDL0Zrd05IVk5oYita?=
 =?utf-8?B?QlRaZDUrVlh1T0x5NG1OclJVWmM5ajFPaGFLUVMzd0g2TjlyQVVpczd1SEFu?=
 =?utf-8?B?cFBVSlhkTy9Gd1ZBbDR1bTludjB3TFpnU1l5cmtZUDZxMVR6YkdsdGZGLzhT?=
 =?utf-8?B?Zi9kRVJUL2twc2pXREZYb3lXMWx6dnJ6TlEyNGFXWUJkcU5wS0k5WkZJV25X?=
 =?utf-8?B?RFNDa0luWVJNdkpaVUdHc2tOWDA4bWJFS2FTVzI2TDBUOTBDZW9UTTZFS3Ry?=
 =?utf-8?B?S1hBMGZIR2RWaWFRdFpEVEFEb1hTM25RWlg5S2NqVDRRZG04SEloRGNFdzUv?=
 =?utf-8?B?RDEvY2JJWEcvUXZrQWRpNzMxWU1vc09kNWh2QVNGbW9QYmRCTW11NUxLNFB5?=
 =?utf-8?Q?pPCBpz5lirWk/0kaU+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c6c153-21ae-4877-beaa-08df1542902e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 05:06:14.4278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGkMNwOgZrEYUeSIyp0WY8JBDxPycLW9ZQa9Xn68Z/X0CU5BIxXQlF7sQwldvDwj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
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



On 16-Sep-26 11:07 AM, Srinivasan Shanmugam wrote:
> The first-level trap mapping is a property of a GPU virtual address
> space, not of a queue type. User queues and kernel queues executing in
> the same GPUVM read the same TMA, so both paths must not carry separate
> trap allocations.
> 
> Move ownership of the trap object to struct amdgpu_vm and create it
> during VM initialization. Keep fpriv->trap_obj as a read-only alias so
> the existing render-node ioctl paths do not need changes.  This also
> establishes the trap mapping before a GPUVM can be used by any queue
> type, which allows the gfxhub setup code in the following patch to
> enable TRAP_EN without a deferred allocation.
> 
> The first-level ISA binary is identical across VMs for the same hardware
> generation. It is copied once into adev->trap_info->isa_bo at device
> init and mapped into each GPUVM at vm_init rather than duplicated
> per-VM.
> 
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  8 ++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 18 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  3 +++
>   3 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 559c9222fc48..5ff3e62671b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1641,11 +1641,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   
>   	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
>   
> -	if (amdgpu_trap_is_enabled(adev)) {
> -		r = amdgpu_trap_alloc(adev, &fpriv->vm, &fpriv->trap_obj);
> -		if (r)
> -			dev_dbg(adev->dev, "trap handler not enabled");
> -	}
> +	/* The trap object is owned by the GPUVM; expose it as an alias. */
> +	fpriv->trap_obj = fpriv->vm.trap_obj;

If it's getting moved, suggest to remove this altogether and fetch 
through fpriv->vm always.

Thanks,
Lijo

>   
>   	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>   
> @@ -1716,7 +1713,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   	}
>   
>   	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
> -	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->userq_mgr, &fpriv->trap_obj);
>   
>   	if (pasid)
>   		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 930b744c5f5f..d981915ac2f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -44,6 +44,7 @@
>   #include "amdgpu_dma_buf.h"
>   #include "amdgpu_res_cursor.h"
>   #include "kfd_svm.h"
> +#include "amdgpu_trap.h"
>   
>   /**
>    * DOC: GPUVM
> @@ -2639,6 +2640,14 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (r)
>   		goto error_free_root;
>   
> +	if (amdgpu_trap_is_enabled(adev)) {
> +		r = amdgpu_trap_alloc(adev, vm, &vm->trap_obj);
> +		if (r) {
> +			amdgpu_vm_fini(adev, vm);
> +			return r;
> +		}
> +	}
> +
>   	r = amdgpu_vm_create_task_info(vm);
>   	if (r)
>   		dev_dbg(adev->dev, "Failed to create task info for VM\n");
> @@ -2753,6 +2762,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>   
> +	/*
> +	 * Free trap state before reserving root. amdgpu_trap_free()
> +	 * uses drm_exec to lock the page directory internally; calling
> +	 * it after amdgpu_bo_reserve(root) would deadlock on the same
> +	 * ww_mutex.
> +	 */
> +	if (vm->trap_obj)
> +		amdgpu_trap_free(adev, vm, NULL, &vm->trap_obj);
> +
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
>   	dma_fence_wait(vm->last_unlocked, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index dd825e179979..8707618c199e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -488,6 +488,9 @@ struct amdgpu_vm {
>   
>   	/* cached fault info */
>   	struct amdgpu_vm_fault_info fault_info;
> +
> +	/* First-level trap state shared by all queue paths using this GPUVM. */
> +	struct amdgpu_trap_obj *trap_obj;
>   };
>   
>   struct amdgpu_vm_manager {

