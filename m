Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DA1CD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 07:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C5410F1B5;
	Thu, 18 Jun 2026 07:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B9WXXTUn";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A7110F1B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 07:47:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elWhMAeSavrz4s4wDTW2l5oK8Bi+TGEEgc/k3h65wvcM/jB3JJFwOJF7FvKh0Y4gc5+7CDX9v102DWkGeBHFdrMDyZmw11GR9ozne9JxRLZ6X/8gPJcusLUJ3bazN46LoWX+eq0MO7QK80clr7bGnnu0yRqRlJixBqFrHISW4lVS5m1KDZXjMu6GdU5LX4lY7CvYZv0XY1lHvaEnciP1NPKYb3fWXuLra1MbByLgRpUnrggoOY1JV//KqgG2JgGSx1BXqPb3UE+zLGZzMRhZ1qn729AiGxe4oaIGizvkEaH1WqnSJBWnyFdnxwu7kzhjZ1oxoUjNbTG4kXCx9GIAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkgvdJFKfd0W67quoI0b+41YXzbbrWcNYXt0ipl5yec=;
 b=xrKOoT1KUHBGatZr3R23ct8LmTgU9tyzPN4c4A/ZbAcSIEjHg1Xsax5b0gjmRixpzPCLfXobxBS66tSwS4d0XPQbskVC5ssNyzOrco1WAZJfAmxP20NQRqDBVHSPCq5D3Pz1zngMhag++cFkoa4axGOHxxRjzDGuoMuwKhKzKnzqTH2ZklymFOWmE+g/3waRvsaM2S1L7Oc6QR1wFYE5MJsSkT6N5CS6tqkPVWGY8MsfQEQaX27ETxwl3hCQ8dYHCePV7DSEqEP1c60RAu3U83CCCV5ZvhN40oiuwZmHNGfYiT7o3yNtBorUVggTjHuJ9EVkAEm3kGy5LLPYkwSw1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkgvdJFKfd0W67quoI0b+41YXzbbrWcNYXt0ipl5yec=;
 b=B9WXXTUnxzEmKcRWfPQw7oA2YLY8dp969MesLU4BWzVEJa4OXTfYjvawl2kvcZKgAHshChZYFHb1Ajg7Epvl8EtJSi+KV87uSqZFhTl7FPq4zB5aDmHwuloFJWDyG6AAp2+G83GeSjOe9iRpXn3SMrV98idN42WonYC2IU7mXwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Thu, 18 Jun 2026 07:47:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 07:47:19 +0000
Message-ID: <c312cca5-fa4e-42b4-b0ea-e8c351f30d5e@amd.com>
Date: Thu, 18 Jun 2026 09:47:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: allocate a per-process CSA to isolate
 scheduler state
To: Xiang Liu <xiang.liu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, Stanley.Yang@amd.com,
 YiPeng.Chai@amd.com
References: <20260617125121.1838486-1-xiang.liu@amd.com>
 <20260617125121.1838486-4-xiang.liu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260617125121.1838486-4-xiang.liu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e516db5-c8cf-4be9-8812-08decd0dd2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ZWJfV9Ac2+55bRBRIXFu935FsbS2yOjAe+RYtD2/57vrTon7BqAdSumGERQ0QJpsrUdAvG4AnqWpmsS/1xVoIBiRTUKrjcWGU/Z+FNuNw7WMKAKk9eNVEAcBEWFS6i3TOK802/iLqyRcdUZscsp+W2AZaKgHX7HHBelMJaiyL3WE46gdwgTA0oLZ21xV4nXK9zo3KC6CPWPeh4SMxPe+4IXwPFMicCKjO0OVzGHPdciUnNripUlFaOtmrPCVKwmzTlYHuBZf+Sw1hFWE2GDZzSu8wMccRcRpA0c5efJdSSsilRB6qu+0LS09e4Dvbrl8kON0iW1ePblJwDfz+/qhJDwyNizH2uOLqQIjGt68DBhFdX5JVnlwDqXWmxV/n5mm+rsf4iMBE4tK7cYvUBXHx72+w+xubOecjxcWd1Ow6Gcl60AlPQYfVrXnaQ66f0qdf1qRichQ+OjEhWWWpBgkuhCtLVRte8N4DGRSZSoWBnUBu7j9WxnVEoCwEiRAfZsH2y9axNN7/mtDYZYMoJVGFLkqnVacZ5SiT2QGFspApwTlEO6Xlkai4slYC1mYXJysrzHbNVnpIV15IRpvgrdZjdnUJaqVSkWJVMqDdnnvABg4OBT2i8UI9anP6mhof6dMACKTUNU8nlu2o8aNrBwBRCQ8qTppSGQbPRLQ54fMk769PEM+/FkhG4of301eBR5N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDRlTW5wd2lTcG1BdmNDM3hkTlA3QlJzbzZiZ0R6UGprNHRZQmRWRlBjM3BG?=
 =?utf-8?B?dXp4czV0c3hDYTc1dnNpcFFEaGdUR29pRFRuOCtMS3c4RXNFVlcydXF0aEJH?=
 =?utf-8?B?TzVaUEs4aU9SRS9WcDJwNGVVczl0UEZvaEVBZkNNTE13RFVkaFhVeEl3d2FF?=
 =?utf-8?B?WldxVmpYRk5wTUh1N05ZM1Y3Sm9mc0xDUXNrK2o3V0ZmYXV2R3lRTTFyclRq?=
 =?utf-8?B?N0Rwdlc5SjI3TFg5azlXVDJZK3B0ZmVvbDAyWGxtZmNoNFRncTlhOHFEaU5L?=
 =?utf-8?B?eCtSMklHVkx5VWx4cmNRMmd4RHpiU2p6K3hhekdqcDlGUHNvdGVDdFgzSVV2?=
 =?utf-8?B?b0hJMHZiN21CSGh6Zm81eDlrbVJWU0xjYkViNmVGQ0JkVEtGQ2ZjcFZWYUla?=
 =?utf-8?B?Sjg2OS9YazBIeUhuekJXOURXUkk2L2xpaTlKQkVNd1ljODFIOGVURDFXTlBR?=
 =?utf-8?B?cTdBbmo0SVZuRU5Mb0NLaThkOFgvTjVQNWVRTitKMnZ4bHJwUW5QOGdqeTdt?=
 =?utf-8?B?dUdndGlCVGJmdlV0d3pXaWpBb2ZLWlQwNVBDN3NiMEZuUjEzZEcrUnJSR2wx?=
 =?utf-8?B?UTBZUE9rbFRWbHZZTFZmNkwwK3NKbTFhaHQ4MHdqM3REQTBVSjNtcU9jcThN?=
 =?utf-8?B?K1JLdmpUUnQ0amxzczVXeG5ZdUc3L09ucDdZblVTb0tyZnFlTy9DczVScktJ?=
 =?utf-8?B?WXVVUEFTZDNKNG5NcU1jSHN6VjhTblY2OHlhRjNQczdNK1B4eTJnSDdEMFls?=
 =?utf-8?B?eVlKYmVEdnVsZ0ZTMm5LNDBobTBvTllaY3o2cTdsM2JnSmNrT2lhQk5LRmh4?=
 =?utf-8?B?QnpmRFdlOHpSNDV0VXRUQ2lmNHYxUmg4VXhVd3RhOFJ5ZjJGL2cvQXZXdjFG?=
 =?utf-8?B?aDJ2VXp4MFowZWtMM0xWYnZxaTRZMXhyd281UFV5V0hnejJNNkJXT2JxenBu?=
 =?utf-8?B?eDZjS09Yekw3dGZCK2FYMzNMQmRpVTdtTTMyR3hJSHBJNEw1UnhOMTFWRGJv?=
 =?utf-8?B?ek1qaUMzWGk2SllFYlpHV2xGK1M2VUdtTUF6NFBybndHSTBxaDB0ampuSUJK?=
 =?utf-8?B?WWw4aHlIbSs0TkdjL0xDeFJjM2N5TldPaVRZbFVMQzJpdXE5MVRIcG1PWmFY?=
 =?utf-8?B?SSswYi96QThiQ0xXSTIwRVUzLzlOZmgybTlaV29xS3B5NnF5NzNHZUNPT250?=
 =?utf-8?B?Z3pVTm04SmdUVC9UZHpGY1JFaHA3V2Z2M0ZmdHZsZUFURVI3K3Fib29FVENi?=
 =?utf-8?B?aW5qQ2NaNUNPVkUzU29mK2dYQ0V6eTBXTFhQVVZYVmFYdzlwUkFKZ3oxckM2?=
 =?utf-8?B?N1BoeTlqWmdYRmM0bmR0QnZCd1ZZRTIwRHNZcm9NaEZjaDkzVkVEZ3lSa3Ro?=
 =?utf-8?B?ZjhqaE9pWXc4N2lmUVhJcnU5akwxU0cxcUQ1QjliZlZvOVFPRndKdjhjQmlI?=
 =?utf-8?B?RHhnNUZXdk5VbFgzckJMZzlqMkVIeE9DeEx4YzhJUFB3M3V2S2NhYU94dUNX?=
 =?utf-8?B?TnM2Y1RlNy93OG0xYmw2SFBNMWFEZG5mMVN1VHcvVlBJM2s0TnBsRjhDRjl3?=
 =?utf-8?B?L1VLTDBZMGNRbG1UUTZlQ2JsQTVxdVBRUGsrL1ROaFFHMm9UZk9Wc0sreUtn?=
 =?utf-8?B?MlVBa2NhaGJNSFAvZ3hocURGREFHZGZxaGRCdU8wTXdtSXJOUzZsc2xCVG9s?=
 =?utf-8?B?TUo1VjBnYytOZUhHUytYQ21DL1lrdjkvMkU0TmlKUnRmMzZPbVFGclZ6TVZl?=
 =?utf-8?B?RWxsbzJDWGZYNnJlNVlWZllaSk1IL3Nnams4M2dMM09ES28weGVkRkdQS2JR?=
 =?utf-8?B?NHdsbm9ESHFyUlYrSFdURkRIRFAzNC9wTE1sd2JhcDh5RzRkeTZVY0lkQkFP?=
 =?utf-8?B?b3N5aXg5TkFPUndHQk4zckJuc2IrcCt0TTJyMUd3M1JIOFJPMGVBMExqRStV?=
 =?utf-8?B?UkljOFJPME1ZT2NLMG0yU0VqbHErVEhKZUxmdWNpM2hHMHhsSTFhaWlUdzB0?=
 =?utf-8?B?T3hueTVDWGIxVDI3Z2JMQXlNSDd0M3FIMUdTWFkxWmlLcE0wb3lyYkovaTJQ?=
 =?utf-8?B?ekh3QlpaenRralJ5Ym9lWXljaS9ERFdIYlVKTGpQR2xTRkNpQzl2U0JGMUx5?=
 =?utf-8?B?Vm9VbWh0WHFiRTViMGVwcE9JcnQ1SFBMeVFrcXBXaWgzbEVPMldBUG9oRnJX?=
 =?utf-8?B?NkxmajU0VjBzY3hYcmhxdkY3SVhjSGl2a2NXUmhXeDRFYXJuWU9OK3A3TUhn?=
 =?utf-8?B?TFIyQitleUpUV1ZuZmZ2RjhEV1h6TnRKZFpNb3VBRUlFRm10SlczdTRMK0JT?=
 =?utf-8?Q?4QciniM/9E9RbKZqfP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e516db5-c8cf-4be9-8812-08decd0dd2f7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:47:19.3566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yx11YHfuBydqfmA+AJ1GOqp42o21XXtog5hGPbeMVB585S8Ymu/YSkC+ahns+KCw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271
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

On 6/17/26 14:51, Xiang Liu wrote:
> A single device-global CSA (adev->virt.csa_obj) was mapped into every
> render client's GPUVM at the same fixed virtual address. The CSA is
> GPU-writeable and holds CP preemption/resume (CE/DE) metadata that the
> kernel and CP firmware consume to save and restore gfx queue state, so a
> shared buffer lets one client overwrite the scheduler state relied upon
> for another client's queue. Under SR-IOV this is a cross-tenant
> scheduler-state integrity issue.
> 
> Allocate a private CSA per amdgpu_fpriv in amdgpu_driver_open_kms() and
> map that into the process GPUVM instead of the global object, and free
> it in amdgpu_driver_postclose_kms(). Publish its kernel mapping through
> vm->csa_cpu_addr so the preemption resume path reads back this process's
> own saved state. One client can no longer observe or corrupt another
> client's CSA.

Clear NAK to that design. That doesn't even remotely work correctly.

Userspace is responsible to allocate the CSA if the global one isn't used.

Regards,
Christian.

> 
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 27 ++++++++++++++++++++++---
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 59670aee0fd6f..50ac52f2e0565 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -448,6 +448,8 @@ struct amdgpu_fpriv {
>  	struct amdgpu_vm	vm;
>  	struct amdgpu_bo_va	*prt_va;
>  	struct amdgpu_bo_va	*csa_va;
> +	struct amdgpu_bo	*csa_obj;
> +	void			*csa_cpu_addr;
>  	struct amdgpu_bo_va	*seq64_va;
>  	struct mutex		bo_list_lock;
>  	struct idr		bo_list_handles;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 2e1284b7887c3..e0fc16bc7ef23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1529,10 +1529,28 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	if (adev->gfx.mcbp) {
>  		uint64_t csa_addr = amdgpu_csa_vaddr(adev) & AMDGPU_GMC_HOLE_MASK;
>  
> -		r = amdgpu_map_static_csa(adev, &fpriv->vm, adev->virt.csa_obj,
> -						&fpriv->csa_va, csa_addr, AMDGPU_CSA_SIZE);
> +		/* Allocate a per-process CSA. The CSA holds CP preemption/resume
> +		 * (CE/DE) metadata that the kernel and CP firmware rely on. A
> +		 * single device-global CSA mapped writable into every GPUVM would
> +		 * let one client corrupt another client's (or the kernel's) saved
> +		 * scheduler state, so give each process its own isolated copy.
> +		 */
> +		r = amdgpu_allocate_static_csa(adev, &fpriv->csa_obj,
> +					       AMDGPU_GEM_DOMAIN_VRAM |
> +					       AMDGPU_GEM_DOMAIN_GTT,
> +					       AMDGPU_CSA_SIZE,
> +					       &fpriv->csa_cpu_addr);
>  		if (r)
>  			goto error_vm;
> +
> +		r = amdgpu_map_static_csa(adev, &fpriv->vm, fpriv->csa_obj,
> +						&fpriv->csa_va, csa_addr, AMDGPU_CSA_SIZE);
> +		if (r) {
> +			amdgpu_free_static_csa(&fpriv->csa_obj);
> +			fpriv->csa_cpu_addr = NULL;
> +			goto error_vm;
> +		}
> +		fpriv->vm.csa_cpu_addr = fpriv->csa_cpu_addr;
>  	}
>  
>  	r = amdgpu_seq64_map(adev, &fpriv->vm, &fpriv->seq64_va);
> @@ -1604,9 +1622,12 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	if (fpriv->csa_va) {
>  		uint64_t csa_addr = amdgpu_csa_vaddr(adev) & AMDGPU_GMC_HOLE_MASK;
>  
> -		WARN_ON(amdgpu_unmap_static_csa(adev, &fpriv->vm, adev->virt.csa_obj,
> +		WARN_ON(amdgpu_unmap_static_csa(adev, &fpriv->vm, fpriv->csa_obj,
>  						fpriv->csa_va, csa_addr));
>  		fpriv->csa_va = NULL;
> +		fpriv->vm.csa_cpu_addr = NULL;
> +		amdgpu_free_static_csa(&fpriv->csa_obj);
> +		fpriv->csa_cpu_addr = NULL;
>  	}
>  
>  	amdgpu_seq64_unmap(adev, fpriv);

